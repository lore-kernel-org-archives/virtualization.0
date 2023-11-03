Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F46C4332F
	for <virtualization@archiver.kernel.org>; Fri,  3 Nov 2023 00:34:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BCE4540168;
	Fri,  3 Nov 2023 00:34:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BCE4540168
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bn3ab0d2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LV4BEzwWsYwA; Fri,  3 Nov 2023 00:34:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2280840ACB;
	Fri,  3 Nov 2023 00:34:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2280840ACB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0CD7C0039;
	Fri,  3 Nov 2023 00:34:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F060CC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Nov 2023 00:34:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B85A98510D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Nov 2023 00:34:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B85A98510D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=bn3ab0d2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z0PUz60v2Jo4
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Nov 2023 00:34:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9BDE98510C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Nov 2023 00:34:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9BDE98510C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698971663; x=1730507663;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=3Pt8fVwDAgej907rc78EFPw3tbD8E7fs6/CUusBrXSQ=;
 b=bn3ab0d2+lbV2IPETGIX2ORwKuNiYTU0hQoxni4LDbX/INZ5+6I2zoCK
 drjo0DfCMtpoag2U5h1CEG1phb55d6e7hZBYYcuE6j/mvbEJaIoGDamLK
 4RCa7QL/Yrf9AbhhZtMm7V2Mh7ldpWJDimWmUmpMTAXyqvDUPGKQh8UVa
 dTXD7WlkX7OFlpAQH/22aiSj0b1+ecs/fVgyar5IqLd7+OfZ9wL2+IIxU
 bzSCZ94uC8q1BCcCaULVVYjgzdZ5AwZYYnOd8r1Pdb3S00zEhvclUuA25
 P3YT0DJrCnsZ3WPKQEuh1QhDdlQUqHea7b7BjYFwqpEejZhym6wYSBcMh Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="387739251"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; d="scan'208";a="387739251"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 17:34:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="737915639"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; d="scan'208";a="737915639"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
 by orsmga006.jf.intel.com with ESMTP; 02 Nov 2023 17:34:10 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1qyi8V-00023b-1M;
 Fri, 03 Nov 2023 00:34:07 +0000
Date: Fri, 3 Nov 2023 08:33:06 +0800
From: kernel test robot <lkp@intel.com>
To: Yishai Hadas <yishaih@nvidia.com>, alex.williamson@redhat.com,
 mst@redhat.com, jasowang@redhat.com, jgg@nvidia.com
Subject: Re: [PATCH V2 vfio 5/9] virtio-pci: Initialize the supported admin
 commands
Message-ID: <202311030838.GjyaBTjM-lkp@intel.com>
References: <20231029155952.67686-6-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231029155952.67686-6-yishaih@nvidia.com>
Cc: kvm@vger.kernel.org, maorg@nvidia.com, oe-kbuild-all@lists.linux.dev,
 virtualization@lists.linux-foundation.org, jiri@nvidia.com, leonro@nvidia.com
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

Hi Yishai,

kernel test robot noticed the following build warnings:

[auto build test WARNING on awilliam-vfio/for-linus]
[also build test WARNING on linus/master v6.6]
[cannot apply to awilliam-vfio/next mst-vhost/linux-next next-20231102]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yishai-Hadas/virtio-Define-feature-bit-for-administration-virtqueue/20231030-000414
base:   https://github.com/awilliam/linux-vfio.git for-linus
patch link:    https://lore.kernel.org/r/20231029155952.67686-6-yishaih%40nvidia.com
patch subject: [PATCH V2 vfio 5/9] virtio-pci: Initialize the supported admin commands
config: i386-randconfig-061-20231102 (https://download.01.org/0day-ci/archive/20231103/202311030838.GjyaBTjM-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231103/202311030838.GjyaBTjM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311030838.GjyaBTjM-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/virtio/virtio_pci_modern.c:726:16: sparse: sparse: restricted __le16 degrades to integer

vim +726 drivers/virtio/virtio_pci_modern.c

   673	
   674	static int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
   675					    struct virtio_admin_cmd *cmd)
   676	{
   677		struct scatterlist *sgs[VIRTIO_AVQ_SGS_MAX], hdr, stat;
   678		struct virtio_pci_device *vp_dev = to_vp_device(vdev);
   679		struct virtio_admin_cmd_status *va_status;
   680		unsigned int out_num = 0, in_num = 0;
   681		struct virtio_admin_cmd_hdr *va_hdr;
   682		struct virtqueue *avq;
   683		u16 status;
   684		int ret;
   685	
   686		avq = virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ) ?
   687			vp_dev->admin_vq.info.vq : NULL;
   688		if (!avq)
   689			return -EOPNOTSUPP;
   690	
   691		va_status = kzalloc(sizeof(*va_status), GFP_KERNEL);
   692		if (!va_status)
   693			return -ENOMEM;
   694	
   695		va_hdr = kzalloc(sizeof(*va_hdr), GFP_KERNEL);
   696		if (!va_hdr) {
   697			ret = -ENOMEM;
   698			goto err_alloc;
   699		}
   700	
   701		va_hdr->opcode = cmd->opcode;
   702		va_hdr->group_type = cmd->group_type;
   703		va_hdr->group_member_id = cmd->group_member_id;
   704	
   705		/* Add header */
   706		sg_init_one(&hdr, va_hdr, sizeof(*va_hdr));
   707		sgs[out_num] = &hdr;
   708		out_num++;
   709	
   710		if (cmd->data_sg) {
   711			sgs[out_num] = cmd->data_sg;
   712			out_num++;
   713		}
   714	
   715		/* Add return status */
   716		sg_init_one(&stat, va_status, sizeof(*va_status));
   717		sgs[out_num + in_num] = &stat;
   718		in_num++;
   719	
   720		if (cmd->result_sg) {
   721			sgs[out_num + in_num] = cmd->result_sg;
   722			in_num++;
   723		}
   724	
   725		if (cmd->opcode == VIRTIO_ADMIN_CMD_LIST_QUERY ||
 > 726		    cmd->opcode == VIRTIO_ADMIN_CMD_LIST_USE)
   727			ret = __virtqueue_exec_admin_cmd(&vp_dev->admin_vq, sgs,
   728					       out_num, in_num,
   729					       sgs, GFP_KERNEL);
   730		else
   731			ret = virtqueue_exec_admin_cmd(&vp_dev->admin_vq, sgs,
   732					       out_num, in_num,
   733					       sgs, GFP_KERNEL);
   734		if (ret) {
   735			dev_err(&vdev->dev,
   736				"Failed to execute command on admin vq: %d\n.", ret);
   737			goto err_cmd_exec;
   738		}
   739	
   740		status = le16_to_cpu(va_status->status);
   741		if (status != VIRTIO_ADMIN_STATUS_OK) {
   742			dev_err(&vdev->dev,
   743				"admin command error: status(%#x) qualifier(%#x)\n",
   744				status, le16_to_cpu(va_status->status_qualifier));
   745			ret = -status;
   746		}
   747	
   748	err_cmd_exec:
   749		kfree(va_hdr);
   750	err_alloc:
   751		kfree(va_status);
   752		return ret;
   753	}
   754	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
