require 'rspec'
require 'json'
require 'bosh/template/test'

describe 'alicloud_cpi job' do
  let(:release) { Bosh::Template::Test::ReleaseDir.new(File.join(File.dirname(__FILE__), '../..')) }
  let(:job) { release.job('alicloud_cpi') }

  describe 'cpi.json' do
    let(:template) { job.template('config/cpi.json') }

    let(:config) { JSON.parse(template.render(manifest_properties)) }

    let(:manifest_properties) do
      {
        'alicloud' => {
          'region' => 'moon'
        },
        'blobstore' => {
          'address' => 'blobstore-address.example.com',
          'agent' => {
            'user' => 'agent',
            'password' => 'agent-password'
          }
        }
      }
    end

    let(:rendered_alicloud_properties) { config['cloud']['properties']['alicloud'] }

    it 'renders the CPI config properly' do
      expect(rendered_alicloud_properties['region']).to eq('moon')
    end

    context 'when using a dav blobstore' do
      let(:rendered_blobstore) { config['cloud']['properties']['agent']['blobstore'] }

      it 'renders agent user/password for accessing blobstore' do
          expect(rendered_blobstore['options']['user']).to eq('agent')
          expect(rendered_blobstore['options']['password']).to eq('agent-password')
      end

      context 'when enabling signed URLs' do
        before do
          manifest_properties['blobstore']['agent'].delete('user')
          manifest_properties['blobstore']['agent'].delete('password')
        end

        it 'does not render agent user/password for accessing blobstore' do
          expect(rendered_blobstore['options']['user']).to be_nil
          expect(rendered_blobstore['options']['password']).to be_nil
        end
      end
    end
  end
end
