Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDA4C433F5
	for <virtualization@archiver.kernel.org>; Fri, 20 May 2022 12:48:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DB5C140A88;
	Fri, 20 May 2022 12:48:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gvcqpZiUE8Zq; Fri, 20 May 2022 12:48:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 647B04014B;
	Fri, 20 May 2022 12:48:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E481C0032;
	Fri, 20 May 2022 12:48:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 840E2C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 12:48:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6D230846A1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 12:48:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2tzcjQzaGI1P
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 12:48:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5B38E8469B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 12:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653050931; x=1684586931;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ydq2rAxzxy58oJMneM/mj2UuLnLEiLOSmzW01gULOvU=;
 b=BXhQ4aTxD8SIS1oiK1OfqbeMQEJazdzeDNtW0glkWARgocZkRhsSN+vP
 GqQFyXMW94E7tmHCxkCFLxsqajYHfQ5XlWA1ntPXBSSK1mO9ZMOHgCE/t
 D5p0E1mZpkKwq5G3aOd4V80NPr50O40wgKwyobvMZNHS8PUVoqiwKHxAC
 8m1IqXlMl6Fm3TuTglwaAfUDC5UQlBKFehuU50ncA8b6V+c+nJcoFFP2k
 uP4zhv+2M3FZxZ3S/2wj7AENLbYQMhrWs0ZfZLRCfxmw7oKYi5sFPssaK
 Y3ZiCFjN3WC6KECxMpWEz4LrSwQ65wiSYIi0WMG0OEW5794ZZ6fJNL+K1 w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="359002089"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; d="scan'208";a="359002089"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2022 05:48:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; d="scan'208";a="662248000"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
 by FMSMGA003.fm.intel.com with ESMTP; 20 May 2022 05:48:44 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1ns23g-0004hw-5m;
 Fri, 20 May 2022 12:48:44 +0000
Date: Fri, 20 May 2022 20:48:19 +0800
From: kernel test robot <lkp@intel.com>
To: zhenwei pi <pizhenwei@bytedance.com>, akpm@linux-foundation.org,
 naoya.horiguchi@nec.com, mst@redhat.com, david@redhat.com
Subject: Re: [PATCH 3/3] virtio_balloon: Introduce memory recover
Message-ID: <202205202014.mgqgBrKd-lkp@intel.com>
References: <20220520070648.1794132-4-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220520070648.1794132-4-pizhenwei@bytedance.com>
Cc: kbuild-all@lists.01.org, qemu-devel@nongnu.org, llvm@lists.linux.dev,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, zhenwei pi <pizhenwei@bytedance.com>, pbonzini@redhat.com
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

Hi zhenwei,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on next-20220519]
[cannot apply to linux/master linus/master v5.18-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/zhenwei-pi/recover-hardware-corrupted-page-by-virtio-balloon/20220520-151328
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: hexagon-randconfig-r041-20220519 (https://download.01.org/0day-ci/archive/20220520/202205202014.mgqgBrKd-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project e00cbbec06c08dc616a0d52a20f678b8fbd4e304)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a42127073dd4adb6354649c8235c5cde033d01f2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review zhenwei-pi/recover-hardware-corrupted-page-by-virtio-balloon/20220520-151328
        git checkout a42127073dd4adb6354649c8235c5cde033d01f2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/virtio/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/virtio/virtio_balloon.c:654:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
           default:
           ^
   drivers/virtio/virtio_balloon.c:654:2: note: insert 'break;' to avoid fall-through
           default:
           ^
           break; 
   1 warning generated.


vim +654 drivers/virtio/virtio_balloon.c

   593	
   594	static void recover_vq_handle_response(struct virtio_balloon *vb, unsigned int len)
   595	{
   596		struct __virtio_balloon_recover *in_vbr;
   597		struct virtio_balloon_recover *vbr;
   598		struct page *page;
   599		unsigned int pfns;
   600		u32 pfn0, pfn1;
   601		__u8 status;
   602	
   603		/* the response is not expected */
   604		if (unlikely(len != sizeof(struct __virtio_balloon_recover)))
   605			return;
   606	
   607		in_vbr = &vb->in_vbr;
   608		vbr = &in_vbr->vbr;
   609		if (unlikely(vbr->cmd != VIRTIO_BALLOON_R_CMD_RESPONSE))
   610			return;
   611	
   612		/* to make sure the contiguous balloon PFNs */
   613		for (pfns = 1; pfns < VIRTIO_BALLOON_PAGES_PER_PAGE; pfns++) {
   614			pfn0 = virtio32_to_cpu(vb->vdev, in_vbr->pfns[pfns - 1]);
   615			pfn1 = virtio32_to_cpu(vb->vdev, in_vbr->pfns[pfns]);
   616			if (pfn1 - pfn0 != 1)
   617				return;
   618		}
   619	
   620		pfn0 = virtio32_to_cpu(vb->vdev, in_vbr->pfns[0]);
   621		if (!pfn_valid(pfn0))
   622			return;
   623	
   624		pfn1 = -1;
   625		spin_lock(&vb->recover_page_list_lock);
   626		list_for_each_entry(page, &vb->corrupted_page_list, lru) {
   627			pfn1 = page_to_pfn(page);
   628			if (pfn1 == pfn0)
   629				break;
   630		}
   631		spin_unlock(&vb->recover_page_list_lock);
   632	
   633		status = vbr->status;
   634		switch (status) {
   635		case VIRTIO_BALLOON_R_STATUS_RECOVERED:
   636			if (pfn1 == pfn0) {
   637				spin_lock(&vb->recover_page_list_lock);
   638				list_del(&page->lru);
   639				balloon_page_push(&vb->recovered_page_list, page);
   640				spin_unlock(&vb->recover_page_list_lock);
   641				queue_work(system_freezable_wq, &vb->unpoison_memory_work);
   642				dev_info_ratelimited(&vb->vdev->dev, "recovered pfn 0x%x", pfn0);
   643			}
   644			break;
   645		case VIRTIO_BALLOON_R_STATUS_FAILED:
   646			/* the hypervisor can't fix this corrupted page, balloon puts page */
   647			if (pfn1 == pfn0) {
   648				spin_lock(&vb->recover_page_list_lock);
   649				list_del(&page->lru);
   650				spin_unlock(&vb->recover_page_list_lock);
   651				put_page(page);
   652				dev_info_ratelimited(&vb->vdev->dev, "failed to recover pfn 0x%x", pfn0);
   653			}
 > 654		default:
   655			break;
   656		};
   657	
   658		/* continue to get response from host side if the response gets handled successfully */
   659		recover_vq_get_response(vb);
   660	}
   661	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
