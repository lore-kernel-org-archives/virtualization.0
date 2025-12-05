Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ECA33BBAD;
	Fri,  5 Dec 2025 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764950864; cv=none; b=VMG6uqmWpQV0Qeno5tCKgIbvttRnV60tOMaJcjSZRdJopTQNgYjVOcE5KSCb8Oy5OufSAXxa4UO1IFs2DKk9x6nBE1z3IJULukHGac8RyWvU8X2+whYj674xZt/UGL/w3Xk5YXlKafs7Arvk/AJPbQwkeNGtxUePiEe/ASHbt6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764950864; c=relaxed/simple;
	bh=CVvVAP2jPQJ2Sjhir5sem0PfbWUQVuVhRTCLoxwRt5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWhadaoyzPrYHjXAHgFXD4E8GgMCFfIj7wjx6P1EFnMvkKHHmlOFUCBAQ9Ck8C9hS1LwJx+DFypsDvYCQlKIxDiGOp/FI98i5AnJjT8WxQRxqf7taGQD0/IPey8cuGjX8gJZlZ2HqnbEH8+x74DW0kEyAOKZvrZcvYG7vEHHBJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oZ/A7dKF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oZ/A7dKF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ckQBtq+4Y7vdp+TM9yy2DQcYJ6E6z7FHH/8z11ZMWKE=; b=oZ/A7dKFntf+0XHPiw4bQOKQCp
	ukDRjqI9iCRiV6BIFrOBiIXibk1yOtCfzEfsKxmKLRz0/aBv7RNJnbvASUF+JyeAzqAgp+60VwHAk
	9+qJWxLNsJCl9jaL+Ti25jPwQvnr5biHgTAb9mDJvjLBNW/3KcDaIM1VV5RrZr7znV1++/3M2jr0s
	j/+hhvWToyVNloYubOQbb46IckrqusIVVQPfZj2UUMUGJ1xZftHstw+op5W25ZpSLPh8HNVKsM/fm
	pR9nHEVh2+MtOJV9bJlaQ5ihkJCOxGyNPco7U7Vj3OWFruBfr748iYyveLdzyg5e4dhJ7wXqVtI4F
	eOkQ3HEQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRYL5-00000005v8L-3UD5;
	Fri, 05 Dec 2025 16:07:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 626F4300499; Fri, 05 Dec 2025 17:07:23 +0100 (CET)
Date: Fri, 5 Dec 2025 17:07:23 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Srikar Dronamraju <srikar@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Ben Segall <bsegall@google.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mel Gorman <mgorman@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Thomas Huth <thuth@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	virtualization@lists.linux.dev,
	Yicong Yang <yangyicong@hisilicon.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH 08/17] sched/core: Implement CPU soft offline/online
Message-ID: <20251205160723.GG2528459@noisy.programming.kicks-ass.net>
References: <20251204175405.1511340-1-srikar@linux.ibm.com>
 <20251204175405.1511340-9-srikar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204175405.1511340-9-srikar@linux.ibm.com>

On Thu, Dec 04, 2025 at 11:23:56PM +0530, Srikar Dronamraju wrote:
> Scheduler already supports CPU online/offline. However for cases where
> scheduler has to offline a CPU temporarily, the online/offline cost is
> too high. Hence here is an attempt to come-up with soft-offline that
> almost looks similar to offline without actually having to do the
> full-offline. Since CPUs are not to be used temporarily for a short
> duration, they will continue to be part of the CPU topology.
> 
> In the soft-offline, CPU will be marked as inactive, i.e removed from
> the cpu_active_mask, CPUs capacity would be reduced and non-pinned tasks
> would be migrated out of the CPU's runqueue.
> 
> Similarly when onlined, CPU will be remarked as active, i.e. added to
> cpu_active_mask, CPUs capacity would be restored.
> 
> Soft-offline is almost similar as 1st step of offline except rebuilding
> the sched-domains. Since the other steps are not done including
> rebuilding the sched-domain, the overhead of soft-offline would be less
> compared to regular offline. A new cpumask is used to indicate
> soft-offline is in progress and hence skips rebuilding the
> sched-domains.

Note that your thing still very much includes the synchronize_rcu() that
a lot of the previous 'hotplug is too slow' crowd have complained about.

So I'm taking it that your steal time thing really isn't that 'fast'.

It might be good to mention the frequency at which you expect cores to
come and go with your setup.
