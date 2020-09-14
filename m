Return-Path: <SRS0=alD2=CX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420ACC43461
	for <virtualization@archiver.kernel.org>; Mon, 14 Sep 2020 15:25:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4C1120639
	for <virtualization@archiver.kernel.org>; Mon, 14 Sep 2020 15:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C1120639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8AA5C860FB;
	Mon, 14 Sep 2020 15:25:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d7_V4Cm1oSZJ; Mon, 14 Sep 2020 15:25:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BC901860E6;
	Mon, 14 Sep 2020 15:25:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B309FC088B;
	Mon, 14 Sep 2020 15:25:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D0F8C0859
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 15:25:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 230DA87223
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 15:25:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Pr8-FmARH-BX
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 15:25:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 27A3C87243
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 15:25:04 +0000 (UTC)
IronPort-SDR: UYBKV1D5Nn1x5bWtkBlnowLkB6775H45MK6+cOHkaf3fkcbGM929CKU/X9bMRUg1qEpud6Mjuy
 ZkpzkrnleGvQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="146833704"
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; d="scan'208";a="146833704"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2020 08:25:02 -0700
IronPort-SDR: ZdvynAtB6veCZZB9VSyHPHZEqQiWj6uh52RE82Ms7IFmKYZDEipZia3FtgI62xai/GYd/plriY
 1FMkYTygWPKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; d="scan'208";a="335315947"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga008.jf.intel.com with ESMTP; 14 Sep 2020 08:24:59 -0700
Received: from andy by smile with local (Exim 4.94)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1kHqLf-00Gd82-Jr; Mon, 14 Sep 2020 18:24:55 +0300
Date: Mon, 14 Sep 2020 18:24:55 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20200914152455.GI3956970@smile.fi.intel.com>
References: <c4bd4fd56df36864ed34d3572f00b2b838fd833a.1599795029.git.jie.deng@intel.com>
 <20200914144807.GC4282@kadam>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200914144807.GC4282@kadam>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: kbuild-all@lists.01.org, lkp@intel.com, mst@redhat.com, kbuild@lists.01.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 wsa@kernel.org, wsa+renesas@sang-engineering.com,
 jarkko.nikula@linux.intel.com, linux-i2c@vger.kernel.org, jdelvare@suse.de
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Sep 14, 2020 at 05:48:07PM +0300, Dan Carpenter wrote:
> Hi Jie,
> 
> url:    https://github.com/0day-ci/linux/commits/Jie-Deng/i2c-virtio-add-a-virtio-i2c-frontend-driver/20200911-115013
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
> config: parisc-randconfig-m031-20200913 (attached as .config)
> compiler: hppa-linux-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> drivers/i2c/busses/i2c-virtio.c:160 virtio_i2c_xfer() error: we previously assumed 'vmsg' could be null (see line 137)
> 

It's quite possible a false positive. Look at 122. But I agree that for-loop is
not the best for such things to understand. Perhaps switching to do {} while ()
will make it better.

> # https://github.com/0day-ci/linux/commit/0a54ec771966748fcbc86256b830b5f786168b7d
> git remote add linux-review https://github.com/0day-ci/linux
> git fetch --no-tags linux-review Jie-Deng/i2c-virtio-add-a-virtio-i2c-frontend-driver/20200911-115013
> git checkout 0a54ec771966748fcbc86256b830b5f786168b7d
> vim +/vmsg +160 drivers/i2c/busses/i2c-virtio.c
> 
> 0a54ec77196674 Jie Deng 2020-09-11  109  static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
> 0a54ec77196674 Jie Deng 2020-09-11  110  {
> 0a54ec77196674 Jie Deng 2020-09-11  111  	struct virtio_i2c *vi = i2c_get_adapdata(adap);
> 0a54ec77196674 Jie Deng 2020-09-11  112  	struct virtqueue *vq = vi->vq;
> 0a54ec77196674 Jie Deng 2020-09-11  113  	struct virtio_i2c_msg *vmsg;
> 0a54ec77196674 Jie Deng 2020-09-11  114  	unsigned long time_left;
> 0a54ec77196674 Jie Deng 2020-09-11  115  	int len, i, ret = 0;
> 0a54ec77196674 Jie Deng 2020-09-11  116  
> 0a54ec77196674 Jie Deng 2020-09-11  117  	mutex_lock(&vi->i2c_lock);
> 0a54ec77196674 Jie Deng 2020-09-11  118  	vmsg = &vi->vmsg;
> 0a54ec77196674 Jie Deng 2020-09-11  119  	vmsg->buf = NULL;
> 0a54ec77196674 Jie Deng 2020-09-11  120  
> 0a54ec77196674 Jie Deng 2020-09-11  121  	for (i = 0; i < num; i++) {
> 0a54ec77196674 Jie Deng 2020-09-11  122  		ret = virtio_i2c_add_msg(vq, vmsg, &msgs[i]);
> 0a54ec77196674 Jie Deng 2020-09-11  123  		if (ret) {
> 0a54ec77196674 Jie Deng 2020-09-11  124  			dev_err(&adap->dev, "failed to add msg[%d] to virtqueue.\n", i);
> 0a54ec77196674 Jie Deng 2020-09-11  125  			break;
> 0a54ec77196674 Jie Deng 2020-09-11  126  		}
> 0a54ec77196674 Jie Deng 2020-09-11  127  
> 0a54ec77196674 Jie Deng 2020-09-11  128  		virtqueue_kick(vq);
> 0a54ec77196674 Jie Deng 2020-09-11  129  
> 0a54ec77196674 Jie Deng 2020-09-11  130  		time_left = wait_for_completion_timeout(&vi->completion, adap->timeout);
> 0a54ec77196674 Jie Deng 2020-09-11  131  		if (!time_left) {
> 0a54ec77196674 Jie Deng 2020-09-11  132  			dev_err(&adap->dev, "msg[%d]: addr=0x%x timeout.\n", i, msgs[i].addr);
> 0a54ec77196674 Jie Deng 2020-09-11  133  			break;
> 0a54ec77196674 Jie Deng 2020-09-11  134  		}
> 0a54ec77196674 Jie Deng 2020-09-11  135  
> 0a54ec77196674 Jie Deng 2020-09-11  136  		vmsg = (struct virtio_i2c_msg *)virtqueue_get_buf(vq, &len);
> 0a54ec77196674 Jie Deng 2020-09-11 @137  		if (vmsg) {
>                                                             ^^^^
> Check for NULL.
> 
> 0a54ec77196674 Jie Deng 2020-09-11  138  			/* vmsg should point to the same address with &vi->vmsg */
> 0a54ec77196674 Jie Deng 2020-09-11  139  			if (vmsg != &vi->vmsg) {
> 0a54ec77196674 Jie Deng 2020-09-11  140  				dev_err(&adap->dev, "msg[%d]: addr=0x%x virtqueue error.\n",
> 0a54ec77196674 Jie Deng 2020-09-11  141  					i, le16_to_cpu(vmsg->hdr.addr));
> 0a54ec77196674 Jie Deng 2020-09-11  142  				break;
> 0a54ec77196674 Jie Deng 2020-09-11  143  			}
> 0a54ec77196674 Jie Deng 2020-09-11  144  			if (vmsg->status != VIRTIO_I2C_MSG_OK) {
> 0a54ec77196674 Jie Deng 2020-09-11  145  				dev_err(&adap->dev, "msg[%d]: addr=0x%x error=%d.\n",
> 0a54ec77196674 Jie Deng 2020-09-11  146  					i, le16_to_cpu(vmsg->hdr.addr), vmsg->status);
> 0a54ec77196674 Jie Deng 2020-09-11  147  				break;
> 0a54ec77196674 Jie Deng 2020-09-11  148  			}
> 0a54ec77196674 Jie Deng 2020-09-11  149  			if ((msgs[i].flags & I2C_M_RD) && msgs[i].len)
> 0a54ec77196674 Jie Deng 2020-09-11  150  				memcpy(msgs[i].buf, vmsg->buf, msgs[i].len);
> 0a54ec77196674 Jie Deng 2020-09-11  151  
> 0a54ec77196674 Jie Deng 2020-09-11  152  			kfree(vmsg->buf);
> 0a54ec77196674 Jie Deng 2020-09-11  153  			vmsg->buf = NULL;
> 0a54ec77196674 Jie Deng 2020-09-11  154  		}
> 0a54ec77196674 Jie Deng 2020-09-11  155  
> 0a54ec77196674 Jie Deng 2020-09-11  156  		reinit_completion(&vi->completion);
> 0a54ec77196674 Jie Deng 2020-09-11  157  	}
> 0a54ec77196674 Jie Deng 2020-09-11  158  
> 0a54ec77196674 Jie Deng 2020-09-11  159  	mutex_unlock(&vi->i2c_lock);
> 0a54ec77196674 Jie Deng 2020-09-11 @160  	kfree(vmsg->buf);
>                                                       ^^^^^^^^^
> Unchecked dereference.
> 
> 0a54ec77196674 Jie Deng 2020-09-11  161  	return ((ret < 0) ? ret : i);
> 0a54ec77196674 Jie Deng 2020-09-11  162  }
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
