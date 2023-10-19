Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B83CDB483
	for <virtualization@archiver.kernel.org>; Thu, 19 Oct 2023 11:34:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2BAD60ECE;
	Thu, 19 Oct 2023 11:34:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F2BAD60ECE
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RY0wsF1S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j0bqgcit_Mnh; Thu, 19 Oct 2023 11:34:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8505261057;
	Thu, 19 Oct 2023 11:34:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8505261057
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C3DEC0039;
	Thu, 19 Oct 2023 11:34:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32280C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 11:34:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1A36B83C8D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 11:34:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1A36B83C8D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=RY0wsF1S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wgLFL0nKdsHl
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 11:34:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C44B083C6D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 11:34:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C44B083C6D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697715253; x=1729251253;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=UZ2MRMETMkvC4Gm+iYt0qTrKR1exYOUbxk00Jvoitsk=;
 b=RY0wsF1S+T4BSmggXAIdFEXKZKjRS5AKPvPIc4E2QTPPXEBvYBFbNReK
 lugluUaLxpZuAdG64m9QWKo3BF/ei8VY011+sRZ/tEV9H6qM4sB03qLWG
 6MHmYx4X7k88RXkLOA67Dw3/4i/AQRZBlsc4L/YmUk6VWT2+xQwUocCPV
 8GJyrVtUIgJh0fPrEAanxxxkcZKXR1VnTx/447uOxvc0CPBnjKANuwFpV
 VHRfpDMgqTpVhlam4JMVaxfmkV3G4LarSL+w9vd+4Yj65TiSKbyB/8M0r
 6vVaTOn3tGnUscytbsySNe51mG08o04upCXnYaGbYAsI+3F6WXnc7YFsM Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="7782521"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="7782521"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2023 04:34:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="1004198450"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; d="scan'208";a="1004198450"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
 by fmsmga006.fm.intel.com with ESMTP; 19 Oct 2023 04:34:09 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1qtRHy-00024T-22;
 Thu, 19 Oct 2023 11:34:06 +0000
Date: Thu, 19 Oct 2023 19:33:32 +0800
From: kernel test robot <lkp@intel.com>
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, virtualization@lists.linux-foundation.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH v3 1/5] x86/paravirt: move some functions and defines to
 alternative
Message-ID: <202310191944.Z8sC9h8O-lkp@intel.com>
References: <20231019091520.14540-2-jgross@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231019091520.14540-2-jgross@suse.com>
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
patch link:    https://lore.kernel.org/r/20231019091520.14540-2-jgross%40suse.com
patch subject: [PATCH v3 1/5] x86/paravirt: move some functions and defines to alternative
reproduce: (https://download.01.org/0day-ci/archive/20231019/202310191944.Z8sC9h8O-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310191944.Z8sC9h8O-lkp@intel.com/

# many are suggestions rather than must-fix

ERROR:COMPLEX_MACRO: Macros with complex values should be enclosed in parentheses
#32: FILE: arch/x86/include/asm/alternative.h:334:
+#define DEFINE_ASM_FUNC(func, instr, sec)		\
+	asm (".pushsection " #sec ", \"ax\"\n"		\
+	     ".global " #func "\n\t"			\
+	     ".type " #func ", @function\n\t"		\
+	     ASM_FUNC_ALIGN "\n"			\
+	     #func ":\n\t"				\
+	     ASM_ENDBR					\
+	     instr "\n\t"				\
+	     ASM_RET					\
+	     ".size " #func ", . - " #func "\n\t"	\
+	     ".popsection")

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
