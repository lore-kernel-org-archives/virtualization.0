Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB313C25B6B
	for <virtualization@archiver.kernel.org>; Thu, 26 Oct 2023 09:03:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 31C3340998;
	Thu, 26 Oct 2023 09:03:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 31C3340998
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Xf9kttC+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IEaHBQBD8NWU; Thu, 26 Oct 2023 09:03:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 55D4E409F3;
	Thu, 26 Oct 2023 09:03:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 55D4E409F3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27F09C0071;
	Thu, 26 Oct 2023 09:03:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CF47C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 09:03:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5EB1461191
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 09:03:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5EB1461191
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Xf9kttC+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tXMxrN81NvBF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 09:03:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 001B361174
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 09:03:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 001B361174
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698311009; x=1729847009;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=tdMCYhhtdDyuQ1YyIqyhjZ6BXjSHRnJQZrR/uUizRRA=;
 b=Xf9kttC+kCMWHsGyCFkPHiQMaJugiL+daDPnOk38REFXKnpzLRWiKDKM
 e1UnHFaxAUKAIbB317C72AZ6+l2ix1dxArcJynsFO1jqP15wA++eUq9M+
 SFnH1N0vDRBTDctgqfFieS6A+7FW0dYhJW2+7GX7jfVAxL2Pz5/qPWhn0
 CA+pfTNO4xW0K3Nu/rrk4Vm5BGTU8Pwn3U8vFa0ZV01MODLlSpbfzeWzo
 7ctR6rDUjGydhbr8akBhRbiFe9fGFweNP+bZSAgUi4hPQ6UCn7CMbZXTn
 hfHTgsxQE7OsSPqryNTWEPXo2zlZbEAIxRuxAXFlGGirHM+4S1Mw9tIoQ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="386376292"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; d="scan'208";a="386376292"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 02:03:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="752648781"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; d="scan'208";a="752648781"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
 by orsmga007.jf.intel.com with ESMTP; 26 Oct 2023 02:03:13 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1qvwGl-0009fP-1J;
 Thu, 26 Oct 2023 09:03:11 +0000
Date: Thu, 26 Oct 2023 17:02:22 +0800
From: kernel test robot <lkp@intel.com>
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v3 4/5] x86/paravirt: switch mixed paravirt/alternative
 calls to alternative_2
Message-ID: <202310261653.LKIRqagq-lkp@intel.com>
References: <20231019091520.14540-5-jgross@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231019091520.14540-5-jgross@suse.com>
Cc: Juergen Gross <jgross@suse.com>, "H. Peter Anvin" <hpa@zytor.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ajay Kaher <akaher@vmware.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Alexey Makhalov <amakhalov@vmware.com>, oe-kbuild-all@lists.linux.dev,
 Thomas Gleixner <tglx@linutronix.de>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on kvm/queue]
[also build test ERROR on tip/master linus/master v6.6-rc7 next-20231025]
[cannot apply to tip/x86/core kvm/linux-next tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Juergen-Gross/x86-paravirt-move-some-functions-and-defines-to-alternative/20231019-171709
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
patch link:    https://lore.kernel.org/r/20231019091520.14540-5-jgross%40suse.com
patch subject: [PATCH v3 4/5] x86/paravirt: switch mixed paravirt/alternative calls to alternative_2
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231026/202310261653.LKIRqagq-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231026/202310261653.LKIRqagq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310261653.LKIRqagq-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/entry/entry_64.S: Assembler messages:
>> arch/x86/entry/entry_64.S:454: Error: no such instruction: `alt_call_instr'
   arch/x86/entry/entry_64.S:319:  Info: macro invoked from here
   arch/x86/entry/entry_64.S:1138:   Info: macro invoked from here


vim +454 arch/x86/entry/entry_64.S

6368558c37107b Thomas Gleixner 2020-05-21  442  
cfa82a00533f70 Thomas Gleixner 2020-02-25  443  /**
cfa82a00533f70 Thomas Gleixner 2020-02-25  444   * idtentry_mce_db - Macro to generate entry stubs for #MC and #DB
cfa82a00533f70 Thomas Gleixner 2020-02-25  445   * @vector:		Vector number
cfa82a00533f70 Thomas Gleixner 2020-02-25  446   * @asmsym:		ASM symbol for the entry point
cfa82a00533f70 Thomas Gleixner 2020-02-25  447   * @cfunc:		C function to be called
cfa82a00533f70 Thomas Gleixner 2020-02-25  448   *
cfa82a00533f70 Thomas Gleixner 2020-02-25  449   * The macro emits code to set up the kernel context for #MC and #DB
cfa82a00533f70 Thomas Gleixner 2020-02-25  450   *
cfa82a00533f70 Thomas Gleixner 2020-02-25  451   * If the entry comes from user space it uses the normal entry path
cfa82a00533f70 Thomas Gleixner 2020-02-25  452   * including the return to user space work and preemption checks on
cfa82a00533f70 Thomas Gleixner 2020-02-25  453   * exit.
cfa82a00533f70 Thomas Gleixner 2020-02-25 @454   *
cfa82a00533f70 Thomas Gleixner 2020-02-25  455   * If hits in kernel mode then it needs to go through the paranoid
cfa82a00533f70 Thomas Gleixner 2020-02-25  456   * entry as the exception can hit any random state. No preemption
cfa82a00533f70 Thomas Gleixner 2020-02-25  457   * check on exit to keep the paranoid path simple.
cfa82a00533f70 Thomas Gleixner 2020-02-25  458   */
cfa82a00533f70 Thomas Gleixner 2020-02-25  459  .macro idtentry_mce_db vector asmsym cfunc
cfa82a00533f70 Thomas Gleixner 2020-02-25  460  SYM_CODE_START(\asmsym)
4708ea14bef314 Josh Poimboeuf  2023-03-01  461  	UNWIND_HINT_IRET_ENTRY
8f93402b92d443 Peter Zijlstra  2022-03-08  462  	ENDBR
cfa82a00533f70 Thomas Gleixner 2020-02-25  463  	ASM_CLAC
c64cc2802a784e Lai Jiangshan   2022-04-21  464  	cld
cfa82a00533f70 Thomas Gleixner 2020-02-25  465  
cfa82a00533f70 Thomas Gleixner 2020-02-25  466  	pushq	$-1			/* ORIG_RAX: no syscall to restart */
cfa82a00533f70 Thomas Gleixner 2020-02-25  467  
cfa82a00533f70 Thomas Gleixner 2020-02-25  468  	/*
cfa82a00533f70 Thomas Gleixner 2020-02-25  469  	 * If the entry is from userspace, switch stacks and treat it as
cfa82a00533f70 Thomas Gleixner 2020-02-25  470  	 * a normal entry.
cfa82a00533f70 Thomas Gleixner 2020-02-25  471  	 */
cfa82a00533f70 Thomas Gleixner 2020-02-25  472  	testb	$3, CS-ORIG_RAX(%rsp)
cfa82a00533f70 Thomas Gleixner 2020-02-25  473  	jnz	.Lfrom_usermode_switch_stack_\@
cfa82a00533f70 Thomas Gleixner 2020-02-25  474  
c82965f9e53005 Chang S. Bae    2020-05-28  475  	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
cfa82a00533f70 Thomas Gleixner 2020-02-25  476  	call	paranoid_entry
cfa82a00533f70 Thomas Gleixner 2020-02-25  477  
cfa82a00533f70 Thomas Gleixner 2020-02-25  478  	UNWIND_HINT_REGS
cfa82a00533f70 Thomas Gleixner 2020-02-25  479  
cfa82a00533f70 Thomas Gleixner 2020-02-25  480  	movq	%rsp, %rdi		/* pt_regs pointer */
cfa82a00533f70 Thomas Gleixner 2020-02-25  481  
cfa82a00533f70 Thomas Gleixner 2020-02-25  482  	call	\cfunc
cfa82a00533f70 Thomas Gleixner 2020-02-25  483  
cfa82a00533f70 Thomas Gleixner 2020-02-25  484  	jmp	paranoid_exit
cfa82a00533f70 Thomas Gleixner 2020-02-25  485  
cfa82a00533f70 Thomas Gleixner 2020-02-25  486  	/* Switch to the regular task stack and use the noist entry point */
cfa82a00533f70 Thomas Gleixner 2020-02-25  487  .Lfrom_usermode_switch_stack_\@:
e2dcb5f1390715 Thomas Gleixner 2020-05-21  488  	idtentry_body noist_\cfunc, has_error_code=0
cfa82a00533f70 Thomas Gleixner 2020-02-25  489  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
