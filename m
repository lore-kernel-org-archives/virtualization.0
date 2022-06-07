Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B93AC43334
	for <virtualization@archiver.kernel.org>; Tue,  7 Jun 2022 08:02:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E2ACF410B4;
	Tue,  7 Jun 2022 08:01:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rikjllMiSRMH; Tue,  7 Jun 2022 08:01:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E5E65404B0;
	Tue,  7 Jun 2022 08:01:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C48A0C0032;
	Tue,  7 Jun 2022 08:01:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B08FC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 08:01:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6D3D684087
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 08:01:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ttVgCkyUgiAp
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 08:01:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E0FF18407A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 08:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654588912; x=1686124912;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=mQzWEDPxMO7UmRFxluiJ1Ca9g136QsEllPnrNDFo86E=;
 b=LYdWTevVknceaxiHI5ZDb/kI7p95Z6aLACFHfjht6bFO/e1Fv3uLKpyh
 IyNoGXGjrm37ZETgDB6N8giq+NDy+DeLckytqVwU43agmCIfCWz0Cansc
 kAGfJYfAPMNnrF2Q3dnEZnpddYOrNWLWfE1Mjm0H7bjOoxQlljfV/6oJm
 gkJ2ANcVbNT0/4ef9eABJk17qVtyiaIsJy8KzcRvcJWjv6BGWsRbI44Dl
 fQ5QpqRp31rAZM/wBWIFIQUef1hyrKVlrrUyczfKy0WZALp13iCcGpsGl
 CBKunH91Zx/Rt+1+6NUiGvpWqZQGcbH6hk9zyI1055+TM59Yl8uK7Fc5/ g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="275487454"
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; d="scan'208";a="275487454"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2022 01:01:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; d="scan'208";a="709385390"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
 by orsmga004.jf.intel.com with ESMTP; 07 Jun 2022 01:01:47 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1nyU9q-000DUT-Qe;
 Tue, 07 Jun 2022 08:01:46 +0000
Date: Tue, 7 Jun 2022 16:01:02 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/20] mm/migrate: Convert buffer_migrate_page() to
 buffer_migrate_folio()
Message-ID: <202206071552.6lOdScLW-lkp@intel.com>
References: <20220606204050.2625949-5-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220606204050.2625949-5-willy@infradead.org>
Cc: linux-aio@kvack.org, linux-nfs@vger.kernel.org, cluster-devel@redhat.com,
 kbuild-all@lists.01.org, linux-ntfs-dev@lists.sourceforge.net,
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
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

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.19-rc1 next-20220607]
[cannot apply to jaegeuk-f2fs/dev-test trondmy-nfs/linux-next kdave/for-next xfs-linux/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/Convert-aops-migratepage-to-aops-migrate_folio/20220607-044509
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git f2906aa863381afb0015a9eb7fefad885d4e5a56
config: s390-randconfig-c005-20220606 (https://download.01.org/0day-ci/archive/20220607/202206071552.6lOdScLW-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b92436efcb7813fc481b30f2593a4907568d917a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/96e64ba8b1be545885d89f44b1d8b968b22bdb4d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Matthew-Wilcox-Oracle/Convert-aops-migratepage-to-aops-migrate_folio/20220607-044509
        git checkout 96e64ba8b1be545885d89f44b1d8b968b22bdb4d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/migrate.c:775: warning: expecting prototype for buffer_migrate_folio_noref(). Prototype was for buffer_migrate_folio_norefs() instead


vim +775 mm/migrate.c

89cb0888ca1483 Jan Kara                2018-12-28  758  
96e64ba8b1be54 Matthew Wilcox (Oracle  2022-06-06  759) /**
96e64ba8b1be54 Matthew Wilcox (Oracle  2022-06-06  760)  * buffer_migrate_folio_noref() - Migration function for folios with buffers.
96e64ba8b1be54 Matthew Wilcox (Oracle  2022-06-06  761)  * @mapping: The address space containing @src.
96e64ba8b1be54 Matthew Wilcox (Oracle  2022-06-06  762)  * @dst: The folio to migrate to.
96e64ba8b1be54 Matthew Wilcox (Oracle  2022-06-06  763)  * @src: The folio to migrate from.
96e64ba8b1be54 Matthew Wilcox (Oracle  2022-06-06  764)  * @mode: How to migrate the folio.
96e64ba8b1be54 Matthew Wilcox (Oracle  2022-06-06  765)  *
96e64ba8b1be54 Matthew Wilcox (Oracle  2022-06-06  766)  * Like buffer_migrate_folio() except that this variant is more careful
96e64ba8b1be54 Matthew Wilcox (Oracle  2022-06-06  767)  * and checks that there are also no buffer head references. This function
96e64ba8b1be54 Matthew Wilcox (Oracle  2022-06-06  768)  * is the right one for mappings where buffer heads are directly looked
96e64ba8b1be54 Matthew Wilcox (Oracle  2022-06-06  769)  * up and referenced (such as block device mappings).
96e64ba8b1be54 Matthew Wilcox (Oracle  2022-06-06  770)  *
96e64ba8b1be54 Matthew Wilcox (Oracle  2022-06-06  771)  * Return: 0 on success or a negative errno on failure.
89cb0888ca1483 Jan Kara                2018-12-28  772   */
96e64ba8b1be54 Matthew Wilcox (Oracle  2022-06-06  773) int buffer_migrate_folio_norefs(struct address_space *mapping,
96e64ba8b1be54 Matthew Wilcox (Oracle  2022-06-06  774) 		struct folio *dst, struct folio *src, enum migrate_mode mode)
89cb0888ca1483 Jan Kara                2018-12-28 @775  {
96e64ba8b1be54 Matthew Wilcox (Oracle  2022-06-06  776) 	return __buffer_migrate_folio(mapping, dst, src, mode, true);
89cb0888ca1483 Jan Kara                2018-12-28  777  }
9361401eb7619c David Howells           2006-09-30  778  #endif
1d8b85ccf1ed53 Christoph Lameter       2006-06-23  779  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
