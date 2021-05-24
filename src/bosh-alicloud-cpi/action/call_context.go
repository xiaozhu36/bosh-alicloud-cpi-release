/*
 * Copyright (C) 2017-2019 Alibaba Group Holding Limited
 */
package action

import (
	"bosh-alicloud-cpi/alicloud"
	//"bosh-alicloud-cpi/registry"

	boshlog "github.com/cloudfoundry/bosh-utils/logger"
)

type CallContext struct {
	Input         string
	Logger        boshlog.Logger
	Config        alicloud.Config
	ConfigConcern bool
}

type Services struct {
	Stemcells alicloud.StemcellManager
	Osses     alicloud.OssManager
	Instances alicloud.InstanceManager
	Disks     alicloud.DiskManager
	Networks  alicloud.NetworkManager
	Registry  alicloud.RegistryManager
}

func NewCallContext(input []byte, logger boshlog.Logger, config alicloud.Config) CallContext {
	return CallContext{
		Input:         string(input),
		Logger:        logger,
		Config:        config,
		ConfigConcern: false,
	}
}

//Todo The next method has been deprecated from 29.0.0 and use bosherr methods instead. The next version should be removed.
//func cleanString(s string) string {
//	s = strings.Replace(s, "\n", "", -1)
//	s = strings.Replace(s, "\t", "", -1)
//	return s
//}
//
//func (c CallContext) Errorf(msg string, args ...interface{}) error {
//	s := "input=`" + cleanString(c.Input) + "` " + fmt.Sprintf(msg, args...)
//	return bosherr.Error(s)
//}
//
//func (c CallContext) WrapError(err error, msg string) error {
//	return bosherr.WrapErrorf(err, "input=`%s` message=%s", cleanString(c.Input), msg)
//}
//
//func (c CallContext) WrapErrorf(err error, msg string, args ...interface{}) error {
//	s := "input=`" + cleanString(c.Input) + "` " + fmt.Sprintf(msg, args...)
//	return bosherr.WrapError(err, s)
//}
