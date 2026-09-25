Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A18745198E;
	Fri, 25 Sep 2026 07:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790322217; cv=none; b=a+mHV2vpgZVXIDMOGOh+Caa9e8Yvuvc5O+JmY3DA/YKigw9v8OiRMmOwVxuC5frVoI8ny/IMDkGvqkucQh/S6O2ez1yI4s4c8lnoFxmZxZys1p8cfaoazLAENU7I50opXbFkuvK1JXUHJ9E6cylY3hiMV16vcTwbkSgGayxcX7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790322217; c=relaxed/simple;
	bh=HmLFghI7T/rZIZJUKluSxFd5PCbOk8DZrf0mZqC6KAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1+z1DpEDsNp3nlSumKrddpxMcAdETmbI+3FpjYu4uxX5yXCAjx9p9M5CvVkgC6T6wbjpNR0nyWmuGYwcP8RnupEAU2k2XVO0eLNZasiONm4Bk5tp3JG2y7jBq80NgRY4oku7dSA/YK0xr2354Afgu9bUTrjfexsyBCtmTcd2kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MUvezfih; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MUvezfih"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KgGrQ2Rb3/9aZ1fMAFWII3W+U6TCnA4h9tEdG5e23tg=; b=MUvezfih/DPOzLe6xL8tgJcc9f
	54kuO/Hi4KW4rV/RFK3dL01oQtgbBHLNRugpxCSH0JbSibJsBec6QcFcYV4TWLCIxDSkek+0+Wx3K
	hONBAOxR7C201wHRUFI4vyP9k0JD+29j15gP+dwfrRT9wAdwOvEZsRfXQyW/utTeYKkyQj/PRh/mX
	9iR220DJ6s8VATFvPPWfRkBkdGWfC0e5JCUOhjrefItQ6Bq8+2bGl+Cjwo5C5Y02NzAw5QAcWwlmN
	I/sKbhdxBkJKJQ4GOiYFDVPqyaHxWq2YcZ2RXiL1mU6PGdPpXu6xatB8I/SQyG/Kou+UP/V8+tiN4
	nkh5FZKA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1xA0aS-0000000GhUh-2wRB;
	Fri, 25 Sep 2026 07:43:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CA9D430070F; Fri, 25 Sep 2026 09:43:14 +0200 (CEST)
Date: Fri, 25 Sep 2026 09:43:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, yury.norov@gmail.com,
	kprateek.nayak@amd.com, iii@linux.ibm.com, corbet@lwn.net,
	meted@linux.ibm.com, ynorov@nvidia.com, tglx@kernel.org,
	gregkh@linuxfoundation.org, pbonzini@redhat.com, seanjc@google.com,
	vschneid@redhat.com, huschle@linux.ibm.com, rostedt@goodmis.org,
	dietmar.eggemann@arm.com, maddy@linux.ibm.com, srikar@linux.ibm.com,
	hdanton@sina.com, chleroy@kernel.org, vineeth@bitbyteword.org,
	frederic@kernel.org, arighi@nvidia.com, pauld@redhat.com,
	christian.loehle@arm.com, tj@kernel.org,
	tommaso.cucinotta@gmail.com, maz@kernel.org, rafael@kernel.org,
	rdunlap@infradead.org, kernellwp@gmail.com,
	linux-doc@vger.kernel.org, jgross@suse.com,
	virtualization@lists.linux.dev, sunlightlinux@gmail.com
Subject: Re: [PATCH v13 06/13] sched/core: Try to use a preferred CPU in
 is_cpu_allowed
Message-ID: <20260925074314.GF4121339@noisy.programming.kicks-ass.net>
References: <20260909135617.871006-1-sshegde@linux.ibm.com>
 <20260909135617.871006-7-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909135617.871006-7-sshegde@linux.ibm.com>

On Wed, Sep 09, 2026 at 07:26:10PM +0530, Shrikanth Hegde wrote:

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a689a0cea4eb..b4ef2e92d786 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2504,6 +2504,23 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
>  	return rq->nr_pinned;
>  }
>  
> +static inline bool task_can_sched_on_preferred(int cpu, struct task_struct *p)

(somehow those arguments feel backwards)

> +{
> +	if (cpu_preferred(cpu))
> +		return false;

FWIW, this reads very weird. task_can_sched_on_preferred() returning
false when task is on a preferred cpu.

The question really is more like: can we migrate to a preferred CPU, and
in that context it makes more sense. No point in migrating if we are
already on one.

Perhaps a comment on top of the function can clarify?

> +	/* Only FAIR tasks honor preferred CPU state */
> +	if (unlikely(p->sched_class != &fair_sched_class))
> +		return false;
> +
> +	/* Ignore preferred state if task affinity is changing */
> +	if (unlikely(!cpumask_test_cpu(task_cpu(p), p->cpus_ptr)))
> +		return false;
> +
> +	return cpumask_intersects_and(p->cpus_ptr, cpu_preferred_mask,
> +				      task_cpu_possible_mask(p));
> +}
