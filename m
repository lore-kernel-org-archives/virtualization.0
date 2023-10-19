Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BB5CDB465
	for <virtualization@archiver.kernel.org>; Thu, 19 Oct 2023 12:07:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B222583CF3;
	Thu, 19 Oct 2023 12:07:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B222583CF3
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KPBhMqdr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id duE1Oustwy7S; Thu, 19 Oct 2023 12:07:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B163A83CEF;
	Thu, 19 Oct 2023 12:07:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B163A83CEF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9417BC0039;
	Thu, 19 Oct 2023 12:07:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D92BC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 12:07:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 38EE64179D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 12:07:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 38EE64179D
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=KPBhMqdr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oUALDDqHh1qn
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 12:07:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4F239416A9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 12:07:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4F239416A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697717231; x=1729253231;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=rbsBJpmkS47G9tV6+xTsrI+g7quKxqgTbZfC3LaxFAw=;
 b=KPBhMqdrJ3E2t2pak4T0w0c9uTFqXyPCTFG/vbcHxFKAHpUBz3dzDtdA
 HFO/IqFX0iOK/fC5he0lPLCbnZqUyJt3d3SEiD+P+aj0dQ237Ge4Fk431
 J3RpcZ5l9rGa8O8VNsflxsTRCrZO+Wzkmo+VAFN0XTOD4Tw0LgrPLAISo
 Y5l7buBLX3K20zSaHUJ6JB4KIbpe/k92lsHUU0VBnQkUM8P44dTCHZG2S
 zL3ObaQu4sX3VPS2mUOcmONRQCEMK7mhOQ2hjVPN83vjJ+wElhDy8fylj
 SBOZmUtK6NqB89EK/S4LEWdT9NQxtC7QcW2h1D/36yswTyElREk/sGF2J Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="366473292"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; d="scan'208";a="366473292"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2023 05:07:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="1088342758"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; d="scan'208";a="1088342758"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
 by fmsmga005.fm.intel.com with ESMTP; 19 Oct 2023 05:07:09 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1qtRnv-00025W-0K;
 Thu, 19 Oct 2023 12:07:07 +0000
Date: Thu, 19 Oct 2023 20:06:31 +0800
From: kernel test robot <lkp@intel.com>
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v3 5/5] x86/paravirt: remove no longer needed paravirt
 patching code
Message-ID: <202310191909.USSRXzXc-lkp@intel.com>
References: <20231019091520.14540-6-jgross@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231019091520.14540-6-jgross@suse.com>
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
patch link:    https://lore.kernel.org/r/20231019091520.14540-6-jgross%40suse.com
patch subject: [PATCH v3 5/5] x86/paravirt: remove no longer needed paravirt patching code
reproduce: (https://download.01.org/0day-ci/archive/20231019/202310191909.USSRXzXc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310191909.USSRXzXc-lkp@intel.com/

# many are suggestions rather than must-fix

WARNING:SPLIT_STRING: quoted string split across lines
#327: FILE: arch/x86/tools/relocs.c:69:
 	"__x86_cpu_dev_(start|end)|"
+	"__alt_instructions(_end)?|"

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
