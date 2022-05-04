Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E37C433F5
	for <virtualization@archiver.kernel.org>; Wed,  4 May 2022 13:51:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82C396109E;
	Wed,  4 May 2022 13:51:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ii1KPJmeg9Ro; Wed,  4 May 2022 13:51:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CF4EA60AAA;
	Wed,  4 May 2022 13:51:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A02E8C0039;
	Wed,  4 May 2022 13:51:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22740C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 May 2022 13:51:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F0BD361083
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 May 2022 13:51:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t0xJdYKCHIDz
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 May 2022 13:51:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B8A8C60AAA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 May 2022 13:51:01 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id B9303B82416;
 Wed,  4 May 2022 13:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D280C385A4;
 Wed,  4 May 2022 13:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651672257;
 bh=ZHm4zRsrfroy4L8PmGFqSDzG1kyM2WEhmxfXu30nYJ8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KbD0RzUSQXY1GOpppkVJACC+5dEQ+Oa6BSONKBAqkMFnH24ZxfCh/URltxKrp48hu
 4ERCzWc5JbR0Dwx1fMhtEe8hFatvMvFPHtXvknO90dVNHnSsAA6DP+s2JitpkPo6At
 OrCGkGJ4vybphxUx+3TNN39kypMQPCjpbDHgxLrLXO0D0uqMGyeAvQTrEorGKltQZv
 wSCJGoHL3Xhr/GKJNCePKYdZcNfU+ev30vTx+iFL2IyW2p3nFudZspWTVwNCmrsAwV
 ZughhxY3oVqmWBH4BVsZrBpYquVzPqjhD+qSdlbeyjbuUILkCdNpx5QMWOQaNicTj7
 E+esIMj4DGfZQ==
Date: Wed, 4 May 2022 14:50:51 +0100
From: Will Deacon <will@kernel.org>
To: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2] arm64: paravirt: Use RCU read locks to guard
 stolen_time
Message-ID: <20220504135050.GA20470@willie-the-truck>
References: <20220428183536.2866667-1-quic_eberman@quicinc.com>
 <20220504094507.GA20305@willie-the-truck>
 <c6689e42-e87c-0c0b-c7ff-40134406e080@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c6689e42-e87c-0c0b-c7ff-40134406e080@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Murali Nalajala <quic_mnalajal@quicinc.com>,
 Elliot Berman <quic_eberman@quicinc.com>,
 Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Alexey Makhalov <amakhalov@vmware.com>,
 Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
 linux-arm-kernel@lists.infradead.org
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

On Wed, May 04, 2022 at 03:38:47PM +0200, Juergen Gross wrote:
> On 04.05.22 11:45, Will Deacon wrote:
> > On Thu, Apr 28, 2022 at 11:35:36AM -0700, Elliot Berman wrote:
> > > diff --git a/arch/arm64/kernel/paravirt.c b/arch/arm64/kernel/paravirt.c
> > > index 75fed4460407..e724ea3d86f0 100644
> > > --- a/arch/arm64/kernel/paravirt.c
> > > +++ b/arch/arm64/kernel/paravirt.c
> > > @@ -52,7 +52,9 @@ early_param("no-steal-acc", parse_no_stealacc);
> > >   /* return stolen time in ns by asking the hypervisor */
> > >   static u64 para_steal_clock(int cpu)
> > >   {
> > > +	struct pvclock_vcpu_stolen_time *kaddr = NULL;
> > >   	struct pv_time_stolen_time_region *reg;
> > > +	u64 ret = 0;
> > >   	reg = per_cpu_ptr(&stolen_time_region, cpu);
> > > @@ -61,28 +63,38 @@ static u64 para_steal_clock(int cpu)
> > >   	 * online notification callback runs. Until the callback
> > >   	 * has run we just return zero.
> > >   	 */
> > > -	if (!reg->kaddr)
> > > +	rcu_read_lock();
> > > +	kaddr = rcu_dereference(reg->kaddr);
> > > +	if (!kaddr) {
> > > +		rcu_read_unlock();
> > >   		return 0;
> > > +	}
> > > -	return le64_to_cpu(READ_ONCE(reg->kaddr->stolen_time));
> > > +	ret = le64_to_cpu(READ_ONCE(kaddr->stolen_time));
> > 
> > Is this READ_ONCE() still required now?
> 
> Yes, as it might be called for another cpu than the current one.
> stolen_time might just be updated, so you want to avoid load tearing.

Ah yes, thanks. The lifetime of the structure is one thing, but the
stolen time field is updated much more regularly than the kaddr pointer.

So:

Acked-by: Will Deacon <will@kernel.org>

Cheers,

Will
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
