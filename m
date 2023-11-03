Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A3CC4332F
	for <virtualization@archiver.kernel.org>; Fri,  3 Nov 2023 07:39:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2C77B43549;
	Fri,  3 Nov 2023 07:39:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2C77B43549
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UXY+fvAm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7hmgDTypIAYq; Fri,  3 Nov 2023 07:39:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B03D54185E;
	Fri,  3 Nov 2023 07:39:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B03D54185E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E1FBC0071;
	Fri,  3 Nov 2023 07:39:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C0C4C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Nov 2023 07:39:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 61B7F707C3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Nov 2023 07:39:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 61B7F707C3
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UXY+fvAm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ALyqI4PhWxEZ
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Nov 2023 07:39:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 18AE1707C2
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Nov 2023 07:39:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 18AE1707C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698997161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ZuQohmnOldmW1VHy4ROYujf3sIsVkqTMbg2gI0VTvA=;
 b=UXY+fvAm+5MOpxw5oCf3ZucvzeSaMbCEsrSQRPhXIFLUfMSEs31/Udw/OiAYWXzVVedvKc
 cQifisedbevmBTAEULHOnEoYSn2zlKWdPaukplhxUfhZEdO+LnlMUgMSJqfMIeCWXt2wWE
 RF/jXV2gUlfETkTAtc/uIM6x0MMy1lM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-923rvr0EMCG3IC8w1ZVU9g-1; Fri, 03 Nov 2023 03:39:17 -0400
X-MC-Unique: 923rvr0EMCG3IC8w1ZVU9g-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40837aa4a58so11844425e9.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 03 Nov 2023 00:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698997156; x=1699601956;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ZuQohmnOldmW1VHy4ROYujf3sIsVkqTMbg2gI0VTvA=;
 b=apIvrBaGNxxne6kCSQmwz553xNRNrJuZ3AEwBxEpRspV9diwWWwX9d9vcJZQIc/p8o
 2RRdAj53h5l3Fj5Cvy5Bl/QcCrN1EA+NF7GjfGzuynHR5Cc0FiMP0OgLJZOHt0I/K6MX
 gJrGu0a0JIh0bjtsGyjQX8V0dwyP3Qwa+QMawFWBjuhr7k7Zc/Ylwoom+iRdo29HrVi8
 zraLiERJ7N6jA4xxTjG2eNb1i8NKoiJqG0G8mjo+qf66SQSnG8H7HUTpEqMzwKdN15KZ
 MCqXd6KDhdhDAaM1wJ7bpH5kyn7dBM5aQmTmTP5+Z77u47lM0YqQ3DsIUZ48CPKKW50z
 NMDQ==
X-Gm-Message-State: AOJu0Yw5dDfykrlC0HZUqRHqc4FaQrGHv0ECEdjRB5b9ECv8ZAmMw9uG
 wn+WA0O10py/tkeHnSUbWj8gdO8EoTuo6firojtrwhWsqPWWUqX6Ixiqsxen3h7/OzFGFPrnCUp
 PFJRyQECD5BCLFDmretrk9pbQMWK0YjXcJtF5vdEWAA==
X-Received: by 2002:a05:600c:4313:b0:401:c7ec:b930 with SMTP id
 p19-20020a05600c431300b00401c7ecb930mr1838750wme.10.1698997156167; 
 Fri, 03 Nov 2023 00:39:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsPxlKYqAwFNSXNswHyQdCOpU9lVHJsDEKqDQ0yhKTs/DCMk3R2BvFerg99LrQVPM6Xpycwg==
X-Received: by 2002:a05:600c:4313:b0:401:c7ec:b930 with SMTP id
 p19-20020a05600c431300b00401c7ecb930mr1838728wme.10.1698997155784; 
 Fri, 03 Nov 2023 00:39:15 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:efc3:a5be:5586:34a6:1108])
 by smtp.gmail.com with ESMTPSA id
 bg19-20020a05600c3c9300b0040531f5c51asm1583577wmb.5.2023.11.03.00.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 00:39:14 -0700 (PDT)
Date: Fri, 3 Nov 2023 03:39:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: kernel test robot <lkp@intel.com>
Subject: Re: [PATCH V2 vfio 5/9] virtio-pci: Initialize the supported admin
 commands
Message-ID: <20231103033834-mutt-send-email-mst@kernel.org>
References: <20231029155952.67686-6-yishaih@nvidia.com>
 <202311030838.GjyaBTjM-lkp@intel.com>
MIME-Version: 1.0
In-Reply-To: <202311030838.GjyaBTjM-lkp@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com, jiri@nvidia.com,
 virtualization@lists.linux-foundation.org, jgg@nvidia.com,
 oe-kbuild-all@lists.linux.dev, leonro@nvidia.com
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

On Fri, Nov 03, 2023 at 08:33:06AM +0800, kernel test robot wrote:
> Hi Yishai,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on awilliam-vfio/for-linus]
> [also build test WARNING on linus/master v6.6]
> [cannot apply to awilliam-vfio/next mst-vhost/linux-next next-20231102]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Yishai-Hadas/virtio-Define-feature-bit-for-administration-virtqueue/20231030-000414
> base:   https://github.com/awilliam/linux-vfio.git for-linus
> patch link:    https://lore.kernel.org/r/20231029155952.67686-6-yishaih%40nvidia.com
> patch subject: [PATCH V2 vfio 5/9] virtio-pci: Initialize the supported admin commands
> config: i386-randconfig-061-20231102 (https://download.01.org/0day-ci/archive/20231103/202311030838.GjyaBTjM-lkp@intel.com/config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231103/202311030838.GjyaBTjM-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311030838.GjyaBTjM-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
> >> drivers/virtio/virtio_pci_modern.c:726:16: sparse: sparse: restricted __le16 degrades to integer
> 
> vim +726 drivers/virtio/virtio_pci_modern.c
> 
>    673	
>    674	static int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
>    675					    struct virtio_admin_cmd *cmd)
>    676	{
>    677		struct scatterlist *sgs[VIRTIO_AVQ_SGS_MAX], hdr, stat;
>    678		struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>    679		struct virtio_admin_cmd_status *va_status;
>    680		unsigned int out_num = 0, in_num = 0;
>    681		struct virtio_admin_cmd_hdr *va_hdr;
>    682		struct virtqueue *avq;
>    683		u16 status;
>    684		int ret;
>    685	
>    686		avq = virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ) ?
>    687			vp_dev->admin_vq.info.vq : NULL;
>    688		if (!avq)
>    689			return -EOPNOTSUPP;
>    690	
>    691		va_status = kzalloc(sizeof(*va_status), GFP_KERNEL);
>    692		if (!va_status)
>    693			return -ENOMEM;
>    694	
>    695		va_hdr = kzalloc(sizeof(*va_hdr), GFP_KERNEL);
>    696		if (!va_hdr) {
>    697			ret = -ENOMEM;
>    698			goto err_alloc;
>    699		}
>    700	
>    701		va_hdr->opcode = cmd->opcode;
>    702		va_hdr->group_type = cmd->group_type;
>    703		va_hdr->group_member_id = cmd->group_member_id;
>    704	
>    705		/* Add header */
>    706		sg_init_one(&hdr, va_hdr, sizeof(*va_hdr));
>    707		sgs[out_num] = &hdr;
>    708		out_num++;
>    709	
>    710		if (cmd->data_sg) {
>    711			sgs[out_num] = cmd->data_sg;
>    712			out_num++;
>    713		}
>    714	
>    715		/* Add return status */
>    716		sg_init_one(&stat, va_status, sizeof(*va_status));
>    717		sgs[out_num + in_num] = &stat;
>    718		in_num++;
>    719	
>    720		if (cmd->result_sg) {
>    721			sgs[out_num + in_num] = cmd->result_sg;
>    722			in_num++;
>    723		}
>    724	
>    725		if (cmd->opcode == VIRTIO_ADMIN_CMD_LIST_QUERY ||
>  > 726		    cmd->opcode == VIRTIO_ADMIN_CMD_LIST_USE)

yes, this is broken on BE. You need to convert enums to LE before you
compare.

>    727			ret = __virtqueue_exec_admin_cmd(&vp_dev->admin_vq, sgs,
>    728					       out_num, in_num,
>    729					       sgs, GFP_KERNEL);
>    730		else
>    731			ret = virtqueue_exec_admin_cmd(&vp_dev->admin_vq, sgs,
>    732					       out_num, in_num,
>    733					       sgs, GFP_KERNEL);
>    734		if (ret) {
>    735			dev_err(&vdev->dev,
>    736				"Failed to execute command on admin vq: %d\n.", ret);
>    737			goto err_cmd_exec;
>    738		}
>    739	
>    740		status = le16_to_cpu(va_status->status);
>    741		if (status != VIRTIO_ADMIN_STATUS_OK) {
>    742			dev_err(&vdev->dev,
>    743				"admin command error: status(%#x) qualifier(%#x)\n",
>    744				status, le16_to_cpu(va_status->status_qualifier));
>    745			ret = -status;
>    746		}
>    747	
>    748	err_cmd_exec:
>    749		kfree(va_hdr);
>    750	err_alloc:
>    751		kfree(va_status);
>    752		return ret;
>    753	}
>    754	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
