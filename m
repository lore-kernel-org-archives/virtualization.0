Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A04C41513
	for <virtualization@archiver.kernel.org>; Thu, 19 Oct 2023 11:56:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EDB7583CBB;
	Thu, 19 Oct 2023 11:56:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EDB7583CBB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=e6cJMvTb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9sfRrY-wsIBU; Thu, 19 Oct 2023 11:56:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 77D0381F08;
	Thu, 19 Oct 2023 11:56:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 77D0381F08
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51AEFC0039;
	Thu, 19 Oct 2023 11:56:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D970C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 11:56:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4827742EE0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 11:56:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4827742EE0
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=e6cJMvTb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bf6vtbC3HoIh
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 11:56:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0398542ED9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 11:56:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0398542ED9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697716572; x=1729252572;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=l7hEz3Co2RbjxtGVRFK3LE/YUuFfRDC66PxtMo30kow=;
 b=e6cJMvTb4KKHuybZiKsnf+OuXFvb/bkMQV1LbqsBYz51XmPsFwREgSng
 Gl0Ms8lGUAGOD+elIxgQn4xPkE9xflulzxoVlPaJ2nUU6wNZuJ8tvSOED
 Hj8OnPq+aNok+Rtaqv7T7sRrl1Im7bvTz3LQqM6aAKMOW4LMFvxVePr9a
 52Fxpirq5F5FThk8gOe6y/s8HXKKO+fbTK1ClKP+Pfr8oCAF2+A3fsk9n
 XxH6gI+tAR5CSjU9sbJ41KbTiWVjvQJAXyZUcMSvx4mjQCi5o8b0meI2y
 1NJxoF07NGZ4cpC9G0cSq+GT2yKuzVYWbsxOyJbkPEhO9m/nX+YTU9thw Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="366471353"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; d="scan'208";a="366471353"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2023 04:56:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="1088340277"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; d="scan'208";a="1088340277"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
 by fmsmga005.fm.intel.com with ESMTP; 19 Oct 2023 04:56:09 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1qtRdG-00025K-3B;
 Thu, 19 Oct 2023 11:56:06 +0000
Date: Thu, 19 Oct 2023 19:55:38 +0800
From: kernel test robot <lkp@intel.com>
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v3 4/5] x86/paravirt: switch mixed paravirt/alternative
 calls to alternative_2
Message-ID: <202310191920.R0c39S5h-lkp@intel.com>
References: <20231019091520.14540-5-jgross@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231019091520.14540-5-jgross@suse.com>
Cc: oe-kbuild-all@lists.linux.dev
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

Hi Juergen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kvm/queue]
[cannot apply to tip/x86/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Juergen-Gross/x86-paravirt-move-some-functions-and-defines-to-alternative/20231019-171709
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
patch link:    https://lore.kernel.org/r/20231019091520.14540-5-jgross%40suse.com
patch subject: [PATCH v3 4/5] x86/paravirt: switch mixed paravirt/alternative calls to alternative_2
reproduce: (https://download.01.org/0day-ci/archive/20231019/202310191920.R0c39S5h-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310191920.R0c39S5h-lkp@intel.com/

# many are suggestions rather than must-fix

ERROR:BRACKET_SPACE: space prohibited before open square bracket '['
#92: FILE: arch/x86/include/asm/paravirt_types.h:281:
+#define paravirt_ptr(op)	[paravirt_opptr] "m" (pv_ops.op)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
