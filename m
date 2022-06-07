Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE59C43334
	for <virtualization@archiver.kernel.org>; Tue,  7 Jun 2022 06:14:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2B43841B0;
	Tue,  7 Jun 2022 06:14:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xqbCZI9hUdAP; Tue,  7 Jun 2022 06:14:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2722A82DE6;
	Tue,  7 Jun 2022 06:14:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3D50C0039;
	Tue,  7 Jun 2022 06:13:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A09AC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 06:13:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ED07F60C0C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 06:13:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yFaQ-H_bLgXG
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 06:13:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8DE07606DC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 06:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654582436; x=1686118436;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=pViZck3K1Rq0vF4B9iREn005L3q1DYrrwNaeY+v9f0c=;
 b=Jq1TWF2PCSi2T8sRCZ8c7DUQn/YHfKg5rV3g12lwOPZj0mwpIoGHIYfu
 03qxlOROTvTIiOg/tSjBDLMuwu4q5BTeLxarVVWmGKkVKibMestDWHOmf
 UctEa8oybYB8kAiQ20onhhtMMPBR+RFVgSbRiT458+8ZouXzyY4zc9Ijh
 LuiJ4y8csxVJYBmi3jx+Q7tWwjZ2A2k0BzGPePXL+ZkUprIVLosSVazWh
 QIyEEh5Wql6tYtcA4InyWGvJuyurfHjQLfTcw+xA+1/hDV0C6gegJA1+h
 T14UuJyjeieaaPE4ONzLKnpGzq/AzozmL/Nn1wOzBfEA0QrXADJWxj11m w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="337951730"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; d="scan'208";a="337951730"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2022 23:13:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; d="scan'208";a="614746862"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
 by orsmga001.jf.intel.com with ESMTP; 06 Jun 2022 23:13:44 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1nySTI-000DQ5-17;
 Tue, 07 Jun 2022 06:13:44 +0000
Date: Tue, 7 Jun 2022 14:13:26 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 14/20] hugetlb: Convert to migrate_folio
Message-ID: <202206071414.41wGG8fp-lkp@intel.com>
References: <20220606204050.2625949-15-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220606204050.2625949-15-willy@infradead.org>
Cc: linux-aio@kvack.org, linux-nfs@vger.kernel.org, cluster-devel@redhat.com,
 kbuild-all@lists.01.org, linux-ntfs-dev@lists.sourceforge.net,
 linux-kernel@vger.kernel.org,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-mm@kvack.org, linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com,
 linux-ext4@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
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

Hi "Matthew,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.19-rc1 next-20220607]
[cannot apply to jaegeuk-f2fs/dev-test trondmy-nfs/linux-next kdave/for-next xfs-linux/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/Convert-aops-migratepage-to-aops-migrate_folio/20220607-044509
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git f2906aa863381afb0015a9eb7fefad885d4e5a56
config: ia64-randconfig-r015-20220605 (https://download.01.org/0day-ci/archive/20220607/202206071414.41wGG8fp-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b038962c9c8c2ab77c71dfba24356ce24bd7a242
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Matthew-Wilcox-Oracle/Convert-aops-migratepage-to-aops-migrate_folio/20220607-044509
        git checkout b038962c9c8c2ab77c71dfba24356ce24bd7a242
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash fs/hugetlbfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/hugetlbfs/inode.c: In function 'hugetlbfs_migrate_folio':
>> fs/hugetlbfs/inode.c:990:17: error: implicit declaration of function 'folio_migrate_copy' [-Werror=implicit-function-declaration]
     990 |                 folio_migrate_copy(dst, src);
         |                 ^~~~~~~~~~~~~~~~~~
>> fs/hugetlbfs/inode.c:992:17: error: implicit declaration of function 'folio_migrate_flags'; did you mean 'folio_mapping_flags'? [-Werror=implicit-function-declaration]
     992 |                 folio_migrate_flags(dst, src);
         |                 ^~~~~~~~~~~~~~~~~~~
         |                 folio_mapping_flags
   cc1: some warnings being treated as errors


vim +/folio_migrate_copy +990 fs/hugetlbfs/inode.c

   972	
   973	static int hugetlbfs_migrate_folio(struct address_space *mapping,
   974					struct folio *dst, struct folio *src,
   975					enum migrate_mode mode)
   976	{
   977		int rc;
   978	
   979		rc = migrate_huge_page_move_mapping(mapping, dst, src);
   980		if (rc != MIGRATEPAGE_SUCCESS)
   981			return rc;
   982	
   983		if (hugetlb_page_subpool(&src->page)) {
   984			hugetlb_set_page_subpool(&dst->page,
   985						hugetlb_page_subpool(&src->page));
   986			hugetlb_set_page_subpool(&src->page, NULL);
   987		}
   988	
   989		if (mode != MIGRATE_SYNC_NO_COPY)
 > 990			folio_migrate_copy(dst, src);
   991		else
 > 992			folio_migrate_flags(dst, src);
   993	
   994		return MIGRATEPAGE_SUCCESS;
   995	}
   996	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
