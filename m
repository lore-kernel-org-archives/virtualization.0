Return-Path: <SRS0=YcCX=LS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3ADC48BDF
	for <virtualization@archiver.kernel.org>; Thu, 24 Jun 2021 04:35:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75D6461003
	for <virtualization@archiver.kernel.org>; Thu, 24 Jun 2021 04:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D6461003
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B5D083B2C;
	Thu, 24 Jun 2021 04:35:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XKNxmtzGaX3T; Thu, 24 Jun 2021 04:35:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AAC6C83AB2;
	Thu, 24 Jun 2021 04:35:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50CFCC001A;
	Thu, 24 Jun 2021 04:35:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9103C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 04:35:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B008040659
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 04:35:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0RLBnlR5dLPw
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 04:35:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9C5B8405D1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 04:35:05 +0000 (UTC)
IronPort-SDR: 4BrzQ2nKN3GfEFMHRSe0/6znvC7XOlzKiGuFcgfwuR59eK/uP2Ntmznc9n9rUhrwAYG9E5o0u0
 MmXqTG2JlyIg==
X-IronPort-AV: E=McAfee;i="6200,9189,10024"; a="271236178"
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
 d="gz'50?scan'50,208,50";a="271236178"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2021 21:35:03 -0700
IronPort-SDR: ljmSGp8j01olplFaXjnopEqzpUxabmfxiiqXF0KJmx1V2kAqqKJQQiVkHXI920BtJG+Jc/l1iM
 s2FYWA4uPNsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
 d="gz'50?scan'50,208,50";a="557198237"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
 by fmsmga001.fm.intel.com with ESMTP; 23 Jun 2021 21:35:00 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lwH4t-0006MO-N1; Thu, 24 Jun 2021 04:34:59 +0000
Date: Thu, 24 Jun 2021 12:34:12 +0800
From: kernel test robot <lkp@intel.com>
To: Mike Christie <michael.christie@oracle.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, mst@redhat.com,
 sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 christian@brauner.io, akpm@linux-foundation.org,
 peterz@infradead.org, christian.brauner@ubuntu.com
Subject: Re: [PATCH 1/3] kthread: allow caller to pass in user_struct
Message-ID: <202106241205.evMViyFN-lkp@intel.com>
References: <20210624030804.4932-2-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <20210624030804.4932-2-michael.christie@oracle.com>
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
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mike,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on vhost/linux-next]
[also build test WARNING on linux/master linus/master v5.13-rc7]
[cannot apply to next-20210623]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Mike-Christie/kthread-pass-in-user-and-check-RLIMIT_NPROC/20210624-110925
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/9b4a744e588ed25e06eed415174977e7533b24dc
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Mike-Christie/kthread-pass-in-user-and-check-RLIMIT_NPROC/20210624-110925
        git checkout 9b4a744e588ed25e06eed415174977e7533b24dc
        # save the attached .config to linux build tree
        make W=1 ARCH=um SUBARCH=x86_64

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   cc1: warning: arch/um/include/uapi: No such file or directory [-Wmissing-include-dirs]
   kernel/kthread.c: In function 'kthread_create_for_user':
>> kernel/kthread.c:466:6: warning: function 'kthread_create_for_user' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     466 |      namefmt, args);
         |      ^~~~~~~


vim +466 kernel/kthread.c

   443	
   444	/**
   445	 * kthread_create_for_user - create a kthread and check @user's RLIMIT_NPROC
   446	 * @threadfn: the function to run until signal_pending(current).
   447	 * @data: data ptr for @threadfn.
   448	 * @user: user_struct that will have its RLIMIT_NPROC checked
   449	 * @namefmt: printf-style name for the thread.
   450	 *
   451	 * This will create a kthread on the current node, leaving it in the stopped
   452	 * state.  This is just a helper for kthread_create_on_node() that will check
   453	 * @user's process count against its RLIMIT_NPROC.  See the
   454	 * kthread_create_on_node() documentation for more details.
   455	 */
   456	struct task_struct *kthread_create_for_user(int (*threadfn)(void *data),
   457						    void *data,
   458						    struct user_struct *user,
   459						    const char namefmt[], ...)
   460	{
   461		struct task_struct *task;
   462		va_list args;
   463	
   464		va_start(args, namefmt);
   465		task = __kthread_create_on_node(threadfn, data, NUMA_NO_NODE, user,
 > 466						namefmt, args);
   467		va_end(args);
   468	
   469		return task;
   470	}
   471	EXPORT_SYMBOL(kthread_create_for_user);
   472	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--oyUTqETQ0mS9luUI
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
7SbMYYUAAA==

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--oyUTqETQ0mS9luUI--
