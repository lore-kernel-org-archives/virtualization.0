Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F2AC433F5
	for <virtualization@archiver.kernel.org>; Thu,  3 Feb 2022 14:07:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BEE426100A;
	Thu,  3 Feb 2022 14:07:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VfDcXj9ySpfa; Thu,  3 Feb 2022 14:07:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5891661006;
	Thu,  3 Feb 2022 14:07:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A61DC001A;
	Thu,  3 Feb 2022 14:07:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E96E5C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 14:07:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CB3B184075
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 14:07:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fMVaKtUut9O5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 14:07:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D851284051
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 14:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643897242; x=1675433242;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=k7t9+8sl0AcAsdxYpKwT8kR61/IOyAKr04n19lIiPE0=;
 b=Ef/6D7cAxmpJm3pm31F1g4zHRxNiRaiQvVYLEU/gG+WYRgTjZGkKJLEd
 wt3Ldwax1qIUwYwJbvB9rr8vdWX8jVpjvAy8Q02fG4iBMAbln3Ig82Tum
 BnLqQBZqK+FdVmIUT4itj/aFbqayAaSFyZ++guc1B+ikxAOvQW3BX+Dpb
 P6fUFDKze91ooLmSA5MrTDf3OOdvKcMC98rp2a/11pfMpB7U5oJMXgDkL
 sInEZ6E1jK3sKzKQQmMx/d6ygHc6tzDLNYCJbdgsJqAIGK4DU9gi7x4gI
 y6JCkfPN1tbsxkc7dMUcu1GfCzHkJNd9DhAnaUTW/VjvQ6BBnxWb0ys0k w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="246983040"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; d="scan'208";a="246983040"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2022 06:07:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; d="scan'208";a="523933368"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
 by orsmga007.jf.intel.com with ESMTP; 03 Feb 2022 06:07:15 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nFclX-000WD0-36; Thu, 03 Feb 2022 14:07:15 +0000
Date: Thu, 3 Feb 2022 22:06:49 +0800
From: kernel test robot <lkp@intel.com>
To: Mike Christie <michael.christie@oracle.com>, geert@linux-m68k.org,
 hdanton@sina.com, hch@infradead.org, stefanha@redhat.com,
 jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk
Subject: Re: [PATCH 6/8] vhost_task: Allow vhost layer to use copy_process
Message-ID: <202202032136.uq6pXzYT-lkp@intel.com>
References: <20220202210200.5235-7-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220202210200.5235-7-michael.christie@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kbuild-all@lists.01.org
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

Hi Mike,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mst-vhost/linux-next]
[also build test WARNING on tip/x86/core linus/master v5.17-rc2]
[cannot apply to davem-sparc/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Mike-Christie/Use-copy_process-in-vhost-layer/20220203-050454
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20220203/202202032136.uq6pXzYT-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/2c7380ae8136c224f4c7074027303b97b0a0f84c
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Mike-Christie/Use-copy_process-in-vhost-layer/20220203-050454
        git checkout 2c7380ae8136c224f4c7074027303b97b0a0f84c
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/vhost_task.c:85:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long [usertype] size @@     got restricted gfp_t @@
   kernel/vhost_task.c:85:24: sparse:     expected unsigned long [usertype] size
   kernel/vhost_task.c:85:24: sparse:     got restricted gfp_t
>> kernel/vhost_task.c:85:36: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted gfp_t [usertype] flags @@     got unsigned long @@
   kernel/vhost_task.c:85:36: sparse:     expected restricted gfp_t [usertype] flags
   kernel/vhost_task.c:85:36: sparse:     got unsigned long

vim +85 kernel/vhost_task.c

    62	
    63	/**
    64	 * vhost_task_create - create a copy of a process to be used by the kernel
    65	 * @fn: thread stack
    66	 * @arg: data to be passed to fn
    67	 * @node: numa node to allocate task from
    68	 *
    69	 * This returns a specialized task for use by the vhost layer or NULL on
    70	 * failure. The returned task is inactive, and the caller must fire it up
    71	 * through vhost_task_start().
    72	 */
    73	struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg, int node)
    74	{
    75		struct kernel_clone_args args = {
    76			.flags		= CLONE_FS | CLONE_UNTRACED | CLONE_VM,
    77			.exit_signal	= 0,
    78			.stack		= (unsigned long)vhost_task_fn,
    79			.worker_flags	= USER_WORKER | USER_WORKER_NO_FILES |
    80					  USER_WORKER_SIG_IGN,
    81		};
    82		struct vhost_task *vtsk;
    83		struct task_struct *tsk;
    84	
  > 85		vtsk = kzalloc(GFP_KERNEL, sizeof(*vtsk));
    86		if (!vtsk)
    87			return ERR_PTR(-ENOMEM);
    88	
    89		init_completion(&vtsk->exited);
    90		vtsk->data = arg;
    91		vtsk->fn = fn;
    92		args.stack_size =  (unsigned long)vtsk;
    93	
    94		tsk = copy_process(NULL, 0, node, &args);
    95		if (IS_ERR(tsk)) {
    96			kfree(vtsk);
    97			return NULL;
    98		}
    99	
   100		vtsk->task = tsk;
   101	
   102		return vtsk;
   103	}
   104	EXPORT_SYMBOL_GPL(vhost_task_create);
   105	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
