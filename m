Return-Path: <SRS0=I+ly=HU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C8DC433DB
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 08:15:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D174A64E6F
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 08:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D174A64E6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E6BA605DD
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 08:15:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LK8y-Ze_Mpix for <virtualization@archiver.kernel.org>;
	Thu, 18 Feb 2021 08:15:30 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id CD471605EC; Thu, 18 Feb 2021 08:15:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 546D1605D3;
	Thu, 18 Feb 2021 08:14:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 249B9C000F;
	Thu, 18 Feb 2021 08:14:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DFDCC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 08:14:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3B09F86456
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 08:14:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NCJyXR95XYR9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 08:14:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 51F688633E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 08:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=rFuCEDruQM3ANvsFui7zHQhN7ske9Q4pPXaIkjwguxg=; b=wOct5ZUuVs84BfzGoHAtevMAst
 U+MwPU+FwceTFebaOa/YfxTXWAlE3yYBCUa2yclPtq7j9EiLnSuhfXTTIzaBsS4IG0tyY2bSG7OMf
 ONF1GFQSMM2z4xupwsset0+VV+KUGXMmBHkkqrDidEVwMIHh3VUDJtRHUTGsm/QwoVbPCK05OvnsK
 j5ZpZUanoMV81iB88ONksrXDTSwsSGxznYijhgkbNqo6kixSzXl4Zgbdwm/MzPkujYjFGpZHXkPgr
 e9HRu8ZxBSaI+o5BItL6q7b87RBFmj9T8aL/hCXUHqmrnB74Tk7YDGjFbhXjugRVAVmMCqaDjHI9w
 KeHlarkw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lCeRs-001Pgy-9q; Thu, 18 Feb 2021 08:14:14 +0000
Date: Thu, 18 Feb 2021 08:14:08 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH v5 4/8] x86/mm/tlb: Flush remote and local TLBs
 concurrently
Message-ID: <20210218081408.GB335524@infradead.org>
References: <20210209221653.614098-1-namit@vmware.com>
 <20210209221653.614098-5-namit@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210209221653.614098-5-namit@vmware.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: Sasha Levin <sashal@kernel.org>, Juergen Gross <jgross@suse.com>,
 linux-hyperv@vger.kernel.org, x86@kernel.org,
 Stephen Hemminger <sthemmin@microsoft.com>, xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
 Nadav Amit <namit@vmware.com>, Andy Lutomirski <luto@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Michael Kelley <mikelley@microsoft.com>
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

Given that the last patch killed the last previously existing
user of on_each_cpu_cond_mask there are now the only users.

>  	if (info->freed_tables) {
> -		smp_call_function_many(cpumask, flush_tlb_func,
> -			       (void *)info, 1);
> +		on_each_cpu_cond_mask(NULL, flush_tlb_func, (void *)info, true,
> +				      cpumask);

.. 

> +		on_each_cpu_cond_mask(NULL, flush_tlb_func, (void *)info, true,
> +				      cpumask);

Which means the cond_func is unused, and thus on_each_cpu_cond_mask can
go away entirely in favor of on_each_cpu_cond.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
