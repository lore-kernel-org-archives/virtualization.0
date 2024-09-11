Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3433186E42
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Sep 2024 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726053294; cv=none; b=nmUgZX76ULPXXx9XmFbrvC17anABkZ4BosKRh2XmfiC5xKuHSq8cQT5llhu1MdAA5WZzBypm7XtUbObzSGwVW3Oqj3jmnqeA/jL49ClF1HegPbsDH2uwt1ilfsV46g5hvwJM0g1yCuqQW6PxsEXb63xk2JwSBHOJ3hDewhOqYXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726053294; c=relaxed/simple;
	bh=BqmxWsUGpfUEobiPJB0THI7iakdvlX0ThUxWPLdaaW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bp1j9j1hSxlJGCRhk8HG9oJZ3wo5AOreRnvyHAWrHhqfk68Pg/kCVKujP3xrpICdwpqcMvllK/HmQEqnm7wEKcERj+D0E8fG9D+eh+QTd6+9wmt+Iiqypucjgvot+M9EXYetXnV0JLObBjrV7ZLeU3Nv1avhF5ib+wBKm6pNuf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DVMATNxF; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DVMATNxF"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C00340D03
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Sep 2024 11:14:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -8.092
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A3a8R0SkHyZa for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Sep 2024 11:14:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5985940CEF
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5985940CEF
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DVMATNxF
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5985940CEF
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Sep 2024 11:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726053291; x=1757589291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BqmxWsUGpfUEobiPJB0THI7iakdvlX0ThUxWPLdaaW8=;
  b=DVMATNxF1NcdAhtDDbukmVUSW7/JRytteXuvri1FLicWG9rYMi2+i0TP
   oG1ryZYU3FndVX3F3YCcJ7+hAE5e/457ZTMX5Iq/1aDSOw7ttUxIKz+E/
   zovL0YhdJVHlgUT2aDNau4zzA0mq8KN+mMr4K68D+AP9aOoi6FbXex9mm
   +Tr2xCSw8bvCMEKCAnbzCNlXianmOnUYTUnR2LwqIUDMgdjRcUh9d+VkT
   a0L+2dkAxYC4w8mVFfMGTo0PjxztI+CJFVWlnw3nEN+SSI0KtKADwzkLG
   /U83J0b0YcEpwE5hwzb00hCFFbxQ5dWA0nGJyz2D/6wf9q0z/wKrxIMdn
   Q==;
X-CSE-ConnectionGUID: 30zL25R5QJqR6jaFCPfmsA==
X-CSE-MsgGUID: RrAA1MZYQHOA5UKJqc31kQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24385327"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="24385327"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 04:14:50 -0700
X-CSE-ConnectionGUID: cQlyxEGaROSubZX6BH/QFw==
X-CSE-MsgGUID: r4n+UmWTQC6Cgo166HJTQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67284394"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 11 Sep 2024 04:14:49 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soLJ7-0003RI-30;
	Wed, 11 Sep 2024 11:14:45 +0000
Date: Wed, 11 Sep 2024 19:13:58 +0800
From: kernel test robot <lkp@intel.com>
To: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com, mst@redhat.com,
	michael.christie@oracle.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1 2/7] vhost: Add kthread support in function
 vhost_worker_queue()
Message-ID: <202409111842.o3eEppU6-lkp@intel.com>
References: <20240909013531.1243525-3-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909013531.1243525-3-lulu@redhat.com>

Hi Cindy,

kernel test robot noticed the following build errors:

[auto build test ERROR on mst-vhost/linux-next]
[also build test ERROR on linus/master v6.11-rc7 next-20240910]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cindy-Lu/vhost-Add-a-new-module_param-for-enable-kthread/20240909-093852
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20240909013531.1243525-3-lulu%40redhat.com
patch subject: [PATCH v1 2/7] vhost: Add kthread support in function vhost_worker_queue()
config: arc-randconfig-001-20240911 (https://download.01.org/0day-ci/archive/20240911/202409111842.o3eEppU6-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240911/202409111842.o3eEppU6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409111842.o3eEppU6-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/vhost/vhost.c: In function 'vhost_worker_queue':
>> drivers/vhost/vhost.c:272:13: error: 'use_kthread' undeclared (first use in this function)
     272 |         if (use_kthread) {
         |             ^~~~~~~~~~~
   drivers/vhost/vhost.c:272:13: note: each undeclared identifier is reported only once for each function it appears in


vim +/use_kthread +272 drivers/vhost/vhost.c

   268	
   269	static void vhost_worker_queue(struct vhost_worker *worker,
   270				       struct vhost_work *work)
   271	{
 > 272		if (use_kthread) {
   273			vhost_work_queue_kthread(worker, work);
   274		} else {
   275			vhost_worker_queue_task(worker, work);
   276		}
   277	}
   278	bool vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work *work)
   279	{
   280		struct vhost_worker *worker;
   281		bool queued = false;
   282	
   283		rcu_read_lock();
   284		worker = rcu_dereference(vq->worker);
   285		if (worker) {
   286			queued = true;
   287			vhost_worker_queue(worker, work);
   288		}
   289		rcu_read_unlock();
   290	
   291		return queued;
   292	}
   293	EXPORT_SYMBOL_GPL(vhost_vq_work_queue);
   294	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
