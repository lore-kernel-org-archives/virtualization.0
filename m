Return-Path: <SRS0=GbdO=L3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58524C07E97
	for <virtualization@archiver.kernel.org>; Sat,  3 Jul 2021 09:04:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DF286143E
	for <virtualization@archiver.kernel.org>; Sat,  3 Jul 2021 09:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF286143E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C92A5605F9;
	Sat,  3 Jul 2021 09:04:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ieoecsLgYF3J; Sat,  3 Jul 2021 09:04:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0A4D5605DF;
	Sat,  3 Jul 2021 09:04:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB928C0010;
	Sat,  3 Jul 2021 09:04:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53899C000E
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Jul 2021 09:04:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 34AA142396
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Jul 2021 09:04:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FabdwQ2CLyY5
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Jul 2021 09:04:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 90ED842295
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Jul 2021 09:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625303054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TVu0raAXHHac8RYBeboQlPHsVSFx1+2WCdPZevKx+R0=;
 b=bjQgOb/5RRvOvqllzgsRD5ilBpIa3+VGvoeweNL5oDHKP4kX857jMyFUTmsNzfMgzLvqEj
 oxmvsnLey+a0MHVR9+rjOk07jm7dckz7f4cijEL8vLeMhoQgh2XLmFs9NaR7rV+DUu7nLZ
 e0B0yLeQB4zFQZ2ujlJGi/jIC4qrCuo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-tsVOvPLwMFiUfF5jgoJEPw-1; Sat, 03 Jul 2021 05:04:13 -0400
X-MC-Unique: tsVOvPLwMFiUfF5jgoJEPw-1
Received: by mail-wm1-f69.google.com with SMTP id
 a129-20020a1ce3870000b02901f050bc61d2so4523475wmh.8
 for <virtualization@lists.linux-foundation.org>;
 Sat, 03 Jul 2021 02:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TVu0raAXHHac8RYBeboQlPHsVSFx1+2WCdPZevKx+R0=;
 b=bDm+7UasukuDD8XGk35XOnfcSwl04kp5Ud+vzymgLq8cO5O2dbt5CsfsqKvYtexi/E
 X6/mPGcmgHpG5Y7bx9oQRuM19AfGV2ZsWI7Xeuv5grf2C6oyuYu/ndwUlDoHPqotcZoC
 PxcWdotSI5LAYXwIjKusU4sLXmy/1HtXx8ud3Vn/nZR+OJaOz1vPy//PGf1CAe0xPTo1
 l8uNYSyWZ8jhG0lvisj2sDHTHxMw+0y5Be1VdKY3DoRbSsNWfHrUgA6cPeCaYrOXii6i
 ZLgKnQ7ugdgC5+JWhcTk4ZHISP/V6VK8MboGjLuogSa2+/mmTZralYID9c22OKLQAiF4
 5lHQ==
X-Gm-Message-State: AOAM532xlTGLteVZmADfa2Es4c8GT6tKcfvkp5QMzt3d1+H+5tTx0kKh
 sa/Gsx3pK5ZO1R+m5/xVU/ithu3OQZ+TO79sD/KEhrNCpgkPIEMIYTloRbUMyaETqs5IsT8Uowz
 tmLciJlY2ZnKMOxFj1jm29KkDVW0fkfxfUFmyIYbjOw==
X-Received: by 2002:a05:600c:1d06:: with SMTP id
 l6mr1310983wms.111.1625303051844; 
 Sat, 03 Jul 2021 02:04:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBiMbxnrnsML4eQwt8oUtcimEaS5j9QhAj9zlj+jkBSqLAfDER1GiUjarz9whoxVL6duyUJw==
X-Received: by 2002:a05:600c:1d06:: with SMTP id
 l6mr1310965wms.111.1625303051644; 
 Sat, 03 Jul 2021 02:04:11 -0700 (PDT)
Received: from redhat.com ([2.55.4.39])
 by smtp.gmail.com with ESMTPSA id 2sm5714024wrz.87.2021.07.03.02.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Jul 2021 02:04:11 -0700 (PDT)
Date: Sat, 3 Jul 2021 05:04:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 2/3] vDPA/ifcvf: implement management netlink framework
 for ifcvf
Message-ID: <20210703050320-mutt-send-email-mst@kernel.org>
References: <20210630082145.5729-3-lingshan.zhu@intel.com>
 <202107010221.pN7dwv6A-lkp@intel.com>
MIME-Version: 1.0
In-Reply-To: <202107010221.pN7dwv6A-lkp@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kbuild-all@lists.01.org, kvm@vger.kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, clang-built-linux@googlegroups.com,
 Zhu Lingshan <lingshan.zhu@intel.com>
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

On Thu, Jul 01, 2021 at 03:04:09AM +0800, kernel test robot wrote:
> Hi Zhu,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on linus/master]
> [also build test WARNING on v5.13 next-20210630]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Zhu-Lingshan/vDPA-ifcvf-implement-management-netlink-framework/20210630-162940
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 007b350a58754a93ca9fe50c498cc27780171153
> config: x86_64-randconfig-a015-20210630 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 8d21d5472501460933e78aead04cf59579025ba4)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         # https://github.com/0day-ci/linux/commit/7ea782fbd896e1a5b3c01b29f4929773748a525f
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Zhu-Lingshan/vDPA-ifcvf-implement-management-netlink-framework/20210630-162940
>         git checkout 7ea782fbd896e1a5b3c01b29f4929773748a525f
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/vdpa/ifcvf/ifcvf_main.c:612:14: warning: variable 'adapter' is uninitialized when used here [-Wuninitialized]
>            put_device(&adapter->vdpa.dev);
>                        ^~~~~~~
>    drivers/vdpa/ifcvf/ifcvf_main.c:546:31: note: initialize the variable 'adapter' to silence this warning
>            struct ifcvf_adapter *adapter;
>                                         ^
>                                          = NULL
>    1 warning generated.
> 


Actually the problem is real and this is almost surely the wrong fix.
We need an extra label to skip using put_device when adapter was not
yet initialized.



> vim +/adapter +612 drivers/vdpa/ifcvf/ifcvf_main.c
> 
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  541  
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  542  static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  543  {
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  544  	struct ifcvf_vdpa_mgmt_dev *ifcvf_mgmt_dev;
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  545  	struct device *dev = &pdev->dev;
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  546  	struct ifcvf_adapter *adapter;
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  547  	u32 dev_type;
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  548  	int ret;
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  549  
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  550  	ifcvf_mgmt_dev = kzalloc(sizeof(struct ifcvf_vdpa_mgmt_dev), GFP_KERNEL);
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  551  	if (!ifcvf_mgmt_dev) {
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  552  		IFCVF_ERR(pdev, "Failed to alloc memory for the vDPA management device\n");
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  553  		return -ENOMEM;
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  554  	}
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  555  
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  556  	dev_type = get_dev_type(pdev);
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  557  	switch (dev_type) {
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  558  	case VIRTIO_ID_NET:
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  559  		ifcvf_mgmt_dev->mdev.id_table = id_table_net;
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  560  		break;
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  561  	case VIRTIO_ID_BLOCK:
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  562  		ifcvf_mgmt_dev->mdev.id_table = id_table_blk;
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  563  		break;
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  564  	default:
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  565  		IFCVF_ERR(pdev, "VIRTIO ID %u not supported\n", dev_type);
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  566  		ret = -EOPNOTSUPP;
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  567  		goto err;
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  568  	}
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  569  
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  570  	ifcvf_mgmt_dev->mdev.ops = &ifcvf_vdpa_mgmt_dev_ops;
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  571  	ifcvf_mgmt_dev->mdev.device = dev;
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  572  	ifcvf_mgmt_dev->pdev = pdev;
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  573  
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  574  	ret = pcim_enable_device(pdev);
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  575  	if (ret) {
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  576  		IFCVF_ERR(pdev, "Failed to enable device\n");
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  577  		goto err;
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  578  	}
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  579  
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  580  	ret = pcim_iomap_regions(pdev, BIT(0) | BIT(2) | BIT(4),
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  581  				 IFCVF_DRIVER_NAME);
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  582  	if (ret) {
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  583  		IFCVF_ERR(pdev, "Failed to request MMIO region\n");
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  584  		goto err;
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  585  	}
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  586  
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  587  	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  588  	if (ret) {
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  589  		IFCVF_ERR(pdev, "No usable DMA configuration\n");
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  590  		goto err;
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  591  	}
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  592  
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  593  	ret = devm_add_action_or_reset(dev, ifcvf_free_irq_vectors, pdev);
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  594  	if (ret) {
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  595  		IFCVF_ERR(pdev,
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  596  			  "Failed for adding devres for freeing irq vectors\n");
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  597  		goto err;
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  598  	}
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  599  
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  600  	pci_set_master(pdev);
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  601  
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  602  	ret = vdpa_mgmtdev_register(&ifcvf_mgmt_dev->mdev);
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  603  	if (ret) {
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  604  		IFCVF_ERR(pdev,
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  605  			  "Failed to initialize the management interfaces\n");
> 5a2414bc454e89 drivers/virtio/vdpa/ifcvf/ifcvf_main.c Zhu Lingshan 2020-03-26  606  		goto err;
> 5a2414bc454e89 drivers/virtio/vdpa/ifcvf/ifcvf_main.c Zhu Lingshan 2020-03-26  607  	}
> 5a2414bc454e89 drivers/virtio/vdpa/ifcvf/ifcvf_main.c Zhu Lingshan 2020-03-26  608  
> 5a2414bc454e89 drivers/virtio/vdpa/ifcvf/ifcvf_main.c Zhu Lingshan 2020-03-26  609  	return 0;
> 5a2414bc454e89 drivers/virtio/vdpa/ifcvf/ifcvf_main.c Zhu Lingshan 2020-03-26  610  
> 5a2414bc454e89 drivers/virtio/vdpa/ifcvf/ifcvf_main.c Zhu Lingshan 2020-03-26  611  err:
> 5a2414bc454e89 drivers/virtio/vdpa/ifcvf/ifcvf_main.c Zhu Lingshan 2020-03-26 @612  	put_device(&adapter->vdpa.dev);
> 7ea782fbd896e1 drivers/vdpa/ifcvf/ifcvf_main.c        Zhu Lingshan 2021-06-30  613  	kfree(ifcvf_mgmt_dev);
> 5a2414bc454e89 drivers/virtio/vdpa/ifcvf/ifcvf_main.c Zhu Lingshan 2020-03-26  614  	return ret;
> 5a2414bc454e89 drivers/virtio/vdpa/ifcvf/ifcvf_main.c Zhu Lingshan 2020-03-26  615  }
> 5a2414bc454e89 drivers/virtio/vdpa/ifcvf/ifcvf_main.c Zhu Lingshan 2020-03-26  616  
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
