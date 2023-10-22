Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F9EC001E0
	for <virtualization@archiver.kernel.org>; Sun, 22 Oct 2023 01:15:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1465D84DF6;
	Sun, 22 Oct 2023 01:15:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1465D84DF6
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mgyt3qua
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rjeoeI3KtMGV; Sun, 22 Oct 2023 01:15:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2014784D05;
	Sun, 22 Oct 2023 01:15:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2014784D05
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC0D5C0039;
	Sun, 22 Oct 2023 01:15:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F4CEC0032
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Oct 2023 01:15:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E217D708D8
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Oct 2023 01:15:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E217D708D8
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=mgyt3qua
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YbWXb-Qd-kxL
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Oct 2023 01:15:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2AB57708DA
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Oct 2023 01:15:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2AB57708DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697937341; x=1729473341;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=RaBJhY6Noscr6BKqNP3rnbzAtIyQU+7PO2jqJX1CmRA=;
 b=mgyt3quaepNEMezNR84NilgukJthKs72Y/6nPQlOw7P99R1uqGCO3Ckg
 Q4vIPab3G5qIyPFB/C7Uk0HY45cFl5cg5hp+jGhVMMPzWG+feQH1f4+l2
 GKRDCoaeYfyJpYYjt/C77gERjOwY026tdCIQpYLEfLstWU2mPZbMOmgeL
 vDb5BtqufRo6NOxF8gpxpR9DJ57tcDfE7dJec30LotQUazPHtU9dh1Nwj
 +RYLs9CqRqqZU5dRgTYfJVAQUI8QK74QQjQhL0vB82UDlivdw0GStXQsg
 SQ/JtJvIa5Hloc+K70+gLSKTgCBwu43M4Tupkh2bGu/0Od5Zp3VGrMaLZ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="383872724"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; d="scan'208";a="383872724"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2023 18:15:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="5713592"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
 by fmviesa001.fm.intel.com with ESMTP; 21 Oct 2023 18:15:32 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1quN40-0005S2-2v;
 Sun, 22 Oct 2023 01:15:32 +0000
Date: Sun, 22 Oct 2023 09:14:41 +0800
From: kernel test robot <lkp@intel.com>
To: Yishai Hadas <yishaih@nvidia.com>, alex.williamson@redhat.com,
 mst@redhat.com, jasowang@redhat.com, jgg@nvidia.com
Subject: Re: [PATCH V1 vfio 6/9] virtio-pci: Introduce APIs to execute legacy
 IO admin commands
Message-ID: <202310220842.ADAIiZsO-lkp@intel.com>
References: <20231017134217.82497-7-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231017134217.82497-7-yishaih@nvidia.com>
Cc: kvm@vger.kernel.org, maorg@nvidia.com, llvm@lists.linux.dev,
 virtualization@lists.linux-foundation.org, jiri@nvidia.com,
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

Hi Yishai,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.6-rc6]
[cannot apply to next-20231020]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yishai-Hadas/virtio-pci-Fix-common-config-map-for-modern-device/20231017-214450
base:   linus/master
patch link:    https://lore.kernel.org/r/20231017134217.82497-7-yishaih%40nvidia.com
patch subject: [PATCH V1 vfio 6/9] virtio-pci: Introduce APIs to execute legacy IO admin commands
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231022/202310220842.ADAIiZsO-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231022/202310220842.ADAIiZsO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310220842.ADAIiZsO-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/virtio/virtio_pci_modern.c:731:5: warning: no previous prototype for function 'virtio_pci_admin_list_query' [-Wmissing-prototypes]
   int virtio_pci_admin_list_query(struct pci_dev *pdev, u8 *buf, int buf_size)
       ^
   drivers/virtio/virtio_pci_modern.c:731:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int virtio_pci_admin_list_query(struct pci_dev *pdev, u8 *buf, int buf_size)
   ^
   static 
>> drivers/virtio/virtio_pci_modern.c:758:5: warning: no previous prototype for function 'virtio_pci_admin_list_use' [-Wmissing-prototypes]
   int virtio_pci_admin_list_use(struct pci_dev *pdev, u8 *buf, int buf_size)
       ^
   drivers/virtio/virtio_pci_modern.c:758:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int virtio_pci_admin_list_use(struct pci_dev *pdev, u8 *buf, int buf_size)
   ^
   static 
>> drivers/virtio/virtio_pci_modern.c:786:5: warning: no previous prototype for function 'virtio_pci_admin_legacy_io_write' [-Wmissing-prototypes]
   int virtio_pci_admin_legacy_io_write(struct pci_dev *pdev, u16 opcode,
       ^
   drivers/virtio/virtio_pci_modern.c:786:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int virtio_pci_admin_legacy_io_write(struct pci_dev *pdev, u16 opcode,
   ^
   static 
>> drivers/virtio/virtio_pci_modern.c:831:5: warning: no previous prototype for function 'virtio_pci_admin_legacy_io_read' [-Wmissing-prototypes]
   int virtio_pci_admin_legacy_io_read(struct pci_dev *pdev, u16 opcode,
       ^
   drivers/virtio/virtio_pci_modern.c:831:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int virtio_pci_admin_legacy_io_read(struct pci_dev *pdev, u16 opcode,
   ^
   static 
>> drivers/virtio/virtio_pci_modern.c:877:5: warning: no previous prototype for function 'virtio_pci_admin_legacy_io_notify_info' [-Wmissing-prototypes]
   int virtio_pci_admin_legacy_io_notify_info(struct pci_dev *pdev,
       ^
   drivers/virtio/virtio_pci_modern.c:877:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int virtio_pci_admin_legacy_io_notify_info(struct pci_dev *pdev,
   ^
   static 
   5 warnings generated.


vim +/virtio_pci_admin_list_query +731 drivers/virtio/virtio_pci_modern.c

   721	
   722	/*
   723	 * virtio_pci_admin_list_query - Provides to driver list of commands
   724	 * supported for the PCI VF.
   725	 * @dev: VF pci_dev
   726	 * @buf: buffer to hold the returned list
   727	 * @buf_size: size of the given buffer
   728	 *
   729	 * Returns 0 on success, or negative on failure.
   730	 */
 > 731	int virtio_pci_admin_list_query(struct pci_dev *pdev, u8 *buf, int buf_size)
   732	{
   733		struct virtio_device *virtio_dev = virtio_pci_vf_get_pf_dev(pdev);
   734		struct virtio_admin_cmd cmd = {};
   735		struct scatterlist result_sg;
   736	
   737		if (!virtio_dev)
   738			return -ENODEV;
   739	
   740		sg_init_one(&result_sg, buf, buf_size);
   741		cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_LIST_QUERY);
   742		cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SRIOV);
   743		cmd.result_sg = &result_sg;
   744	
   745		return vp_modern_admin_cmd_exec(virtio_dev, &cmd);
   746	}
   747	EXPORT_SYMBOL_GPL(virtio_pci_admin_list_query);
   748	
   749	/*
   750	 * virtio_pci_admin_list_use - Provides to device list of commands
   751	 * used for the PCI VF.
   752	 * @dev: VF pci_dev
   753	 * @buf: buffer which holds the list
   754	 * @buf_size: size of the given buffer
   755	 *
   756	 * Returns 0 on success, or negative on failure.
   757	 */
 > 758	int virtio_pci_admin_list_use(struct pci_dev *pdev, u8 *buf, int buf_size)
   759	{
   760		struct virtio_device *virtio_dev = virtio_pci_vf_get_pf_dev(pdev);
   761		struct virtio_admin_cmd cmd = {};
   762		struct scatterlist data_sg;
   763	
   764		if (!virtio_dev)
   765			return -ENODEV;
   766	
   767		sg_init_one(&data_sg, buf, buf_size);
   768		cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_LIST_USE);
   769		cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SRIOV);
   770		cmd.data_sg = &data_sg;
   771	
   772		return vp_modern_admin_cmd_exec(virtio_dev, &cmd);
   773	}
   774	EXPORT_SYMBOL_GPL(virtio_pci_admin_list_use);
   775	
   776	/*
   777	 * virtio_pci_admin_legacy_io_write - Write legacy registers of a member device
   778	 * @dev: VF pci_dev
   779	 * @opcode: op code of the io write command
   780	 * @offset: starting byte offset within the registers to write to
   781	 * @size: size of the data to write
   782	 * @buf: buffer which holds the data
   783	 *
   784	 * Returns 0 on success, or negative on failure.
   785	 */
 > 786	int virtio_pci_admin_legacy_io_write(struct pci_dev *pdev, u16 opcode,
   787					     u8 offset, u8 size, u8 *buf)
   788	{
   789		struct virtio_device *virtio_dev = virtio_pci_vf_get_pf_dev(pdev);
   790		struct virtio_admin_cmd_legacy_wr_data *data;
   791		struct virtio_admin_cmd cmd = {};
   792		struct scatterlist data_sg;
   793		int vf_id;
   794		int ret;
   795	
   796		if (!virtio_dev)
   797			return -ENODEV;
   798	
   799		vf_id = pci_iov_vf_id(pdev);
   800		if (vf_id < 0)
   801			return vf_id;
   802	
   803		data = kzalloc(sizeof(*data) + size, GFP_KERNEL);
   804		if (!data)
   805			return -ENOMEM;
   806	
   807		data->offset = offset;
   808		memcpy(data->registers, buf, size);
   809		sg_init_one(&data_sg, data, sizeof(*data) + size);
   810		cmd.opcode = cpu_to_le16(opcode);
   811		cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SRIOV);
   812		cmd.group_member_id = cpu_to_le64(vf_id + 1);
   813		cmd.data_sg = &data_sg;
   814		ret = vp_modern_admin_cmd_exec(virtio_dev, &cmd);
   815	
   816		kfree(data);
   817		return ret;
   818	}
   819	EXPORT_SYMBOL_GPL(virtio_pci_admin_legacy_io_write);
   820	
   821	/*
   822	 * virtio_pci_admin_legacy_io_read - Read legacy registers of a member device
   823	 * @dev: VF pci_dev
   824	 * @opcode: op code of the io read command
   825	 * @offset: starting byte offset within the registers to read from
   826	 * @size: size of the data to be read
   827	 * @buf: buffer to hold the returned data
   828	 *
   829	 * Returns 0 on success, or negative on failure.
   830	 */
 > 831	int virtio_pci_admin_legacy_io_read(struct pci_dev *pdev, u16 opcode,
   832					    u8 offset, u8 size, u8 *buf)
   833	{
   834		struct virtio_device *virtio_dev = virtio_pci_vf_get_pf_dev(pdev);
   835		struct virtio_admin_cmd_legacy_rd_data *data;
   836		struct scatterlist data_sg, result_sg;
   837		struct virtio_admin_cmd cmd = {};
   838		int vf_id;
   839		int ret;
   840	
   841		if (!virtio_dev)
   842			return -ENODEV;
   843	
   844		vf_id = pci_iov_vf_id(pdev);
   845		if (vf_id < 0)
   846			return vf_id;
   847	
   848		data = kzalloc(sizeof(*data), GFP_KERNEL);
   849		if (!data)
   850			return -ENOMEM;
   851	
   852		data->offset = offset;
   853		sg_init_one(&data_sg, data, sizeof(*data));
   854		sg_init_one(&result_sg, buf, size);
   855		cmd.opcode = cpu_to_le16(opcode);
   856		cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SRIOV);
   857		cmd.group_member_id = cpu_to_le64(vf_id + 1);
   858		cmd.data_sg = &data_sg;
   859		cmd.result_sg = &result_sg;
   860		ret = vp_modern_admin_cmd_exec(virtio_dev, &cmd);
   861	
   862		kfree(data);
   863		return ret;
   864	}
   865	EXPORT_SYMBOL_GPL(virtio_pci_admin_legacy_io_read);
   866	
   867	/*
   868	 * virtio_pci_admin_legacy_io_notify_info - Read the queue notification
   869	 * information for legacy interface
   870	 * @dev: VF pci_dev
   871	 * @req_bar_flags: requested bar flags
   872	 * @bar: on output the BAR number of the member device
   873	 * @bar_offset: on output the offset within bar
   874	 *
   875	 * Returns 0 on success, or negative on failure.
   876	 */
 > 877	int virtio_pci_admin_legacy_io_notify_info(struct pci_dev *pdev,
   878						   u8 req_bar_flags, u8 *bar,
   879						   u64 *bar_offset)
   880	{
   881		struct virtio_device *virtio_dev = virtio_pci_vf_get_pf_dev(pdev);
   882		struct virtio_admin_cmd_notify_info_result *result;
   883		struct virtio_admin_cmd cmd = {};
   884		struct scatterlist result_sg;
   885		int vf_id;
   886		int ret;
   887	
   888		if (!virtio_dev)
   889			return -ENODEV;
   890	
   891		vf_id = pci_iov_vf_id(pdev);
   892		if (vf_id < 0)
   893			return vf_id;
   894	
   895		result = kzalloc(sizeof(*result), GFP_KERNEL);
   896		if (!result)
   897			return -ENOMEM;
   898	
   899		sg_init_one(&result_sg, result, sizeof(*result));
   900		cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO);
   901		cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SRIOV);
   902		cmd.group_member_id = cpu_to_le64(vf_id + 1);
   903		cmd.result_sg = &result_sg;
   904		ret = vp_modern_admin_cmd_exec(virtio_dev, &cmd);
   905		if (!ret) {
   906			struct virtio_admin_cmd_notify_info_data *entry;
   907			int i;
   908	
   909			ret = -ENOENT;
   910			for (i = 0; i < VIRTIO_ADMIN_CMD_MAX_NOTIFY_INFO; i++) {
   911				entry = &result->entries[i];
   912				if (entry->flags == VIRTIO_ADMIN_CMD_NOTIFY_INFO_FLAGS_END)
   913					break;
   914				if (entry->flags != req_bar_flags)
   915					continue;
   916				*bar = entry->bar;
   917				*bar_offset = le64_to_cpu(entry->offset);
   918				ret = 0;
   919				break;
   920			}
   921		}
   922	
   923		kfree(result);
   924		return ret;
   925	}
   926	EXPORT_SYMBOL_GPL(virtio_pci_admin_legacy_io_notify_info);
   927	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
