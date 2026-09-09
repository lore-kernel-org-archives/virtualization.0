Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F015E314B6E
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974399; cv=none; b=QBqMk3+UEk9MSvDhq/N0ZwsBe3pr6kWPsDlo9DgVakviSxRFt7ZjzXRiGsczKlg5ljtgVyzLae9HcURgD9tNOMJygiBM8yQCUdpo/kgXU5lhuLHauOBZyUKQsp6xdaHLpcSHGyYO6/qQYkpOaal6ZYHpwpg1Wv7tuJcrX6S7ANI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974399; c=relaxed/simple;
	bh=Z0gb6PYt93u0VY6izJ56KhmshtzSyI7O+7Ihrl0lCmU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5nj5TgIhz6Kd/CllpNHhm++mFDPcyiTVdP0oG/xMAW+GfFqLCP2Wf05n6LsutxJ+lntX6E1K3P3uSC+5tJsPL8mVAMQqUBXRhs3vLGA60viJsc+fNL64SuHZgXNeVSEidn5Qg/r32K+OkAeU4O2cACufhtr6XSAVuWu7pZQPps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0OYH+w8; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0OYH+w8"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8565d77c277so84000017b3.0
        for <virtualization@lists.linux.dev>; Wed, 09 Sep 2026 10:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788974397; x=1789579197; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3PRZsX/KYek6emU5v5tZYtdcbcg2qPIIdPrtfdDH6As=;
        b=F0OYH+w8EKjCyDPchGGWeeq68mRlLP6+cVQwPYxGmpKjIf3MRH86CjdhtbIkJ689K6
         oJcbJUPR/jja0oUSvHZO1B60ozwhPeGYkFezXubOtRrYYjhc+8TqPLLxiGQiS4uCKIKm
         9i3wyn6vH7mqNftvWq65LMjitQ+QCFqkCEcDgNYr/Y41NfBln9QmixzAX/IlnrIN1O8F
         L5vLGfR8FsUNFtrg2DVV7WpPq5a9kJZ6VYsMe0lhsdB3k3fGBx9GuR9LVsRIqLJGQR/R
         HH2nPR/SWGxps8AfA3SP1gB+aHJ9eM7UpDbR30RbbcqYpGeHimerFTQQ06VfWcaqDc0C
         BkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788974397; x=1789579197;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3PRZsX/KYek6emU5v5tZYtdcbcg2qPIIdPrtfdDH6As=;
        b=mdO/F4iwnMg3B/e9d5MJN0dANeTW1T8IpHr0ioyE4FyvCnCq/m0uEkzIErZaqhHQFo
         pwh84Xyw0i2VTCQVqFt34Ro+Sv7uv/2GCzI2xiX1Ggp0S+fFYt+6nOatYI/yb8V5QBFq
         QlZkduqduW0tetbP0e5LNkst2G0EHs1S1OoRv1VKfaxmOYt95BZJqvGIT0ZINXURrl2K
         SisRw8nvvvuH9iTRfdrCx9ZKbN9z94qHkdTUoXDKXagxOqCtPt5VYxSbhoXYy5fzH8R8
         MjklHbycuomxXwjk5sAz7l9o17PJ5xkznNiGLihdm8902NifeUN8Pp+LlzQDtNCCGBqt
         S5/Q==
X-Forwarded-Encrypted: i=1; AKwUvBwlGifp4Kp5xAuC6v4eTWMPWQOz/xMa16IQI+fvXva/fJudesqGA2Hz40CNfLDjcbTGLLt69ujDDn5D7I6fBQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nk91BpYUOtCOFBKGsGd4trJZGCFpncr5YdmlU8WxixlQ7MyyzQ
	O+BJWaiwpVVUdoX+26O5GDPSdayZG99E4Ysln5oXf+TOoGLf/q2JeHG3
X-Gm-Gg: AYBFou1Ej/LcJ/rkRubdKRnvTfRvuMyfk7MNu7t0C48sNO8GdEHgS5WhL1Fxf+NlTTA
	G08l16enIxz/Y0FP78YZoJkq5xir0RYAYWqjLCxSozZURYnm3dSRzIANtyQWXHMh01iRFyshnC0
	G4CQdLrKC/25rjpfjYvK3sIPKn3f4LMyWjhdLf3LJVrsyK0IpOiGIGH2huJ3TI2Ar3t5BNKalRo
	S/zxv5maFqIQIG0nGdr1c4UiZuWA38DIIUwW0g2gyShYX1GlVfXNO8uXpXk/IE276olA/H368H0
	9blae0F59yzvu5NeXKuh8mbriG7bu60u5eitPyE5oSbHwWhlzt/vgv2gHRhyRKMIQ6bOiuuI4PZ
	Vf6ifjs5sA0gpCKHfAA6/hqGcGTQ8uIw6+/ewto6jId7i+8QyuztwpuUpUUtFW/YQWcg3ZpekXr
	IT7gxXnyYGdcQ2Ky7lMyjK2o08j4qtsir8WiEwqMYmuWnuMawgMGMT7nT3Jusms0H3x9p6RPMdu
	jBvfEtUI66ODFYbmweOZ2MGGSCSUxRrESVQGaY=
X-Received: by 2002:a05:690c:620f:b0:841:773e:8d86 with SMTP id 00721157ae682-871232363dfmr149350847b3.15.1788974396825;
        Wed, 09 Sep 2026 10:19:56 -0700 (PDT)
Received: from localhost (c-73-105-0-191.hsd1.fl.comcast.net. [73.105.0.191])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714b62bc77sm114405657b3.39.2026.09.09.10.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 10:19:56 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
Date: Wed, 9 Sep 2026 13:19:55 -0400
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	yury.norov@gmail.com, kprateek.nayak@amd.com, iii@linux.ibm.com,
	corbet@lwn.net, meted@linux.ibm.com, tglx@kernel.org,
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
Subject: Re: [PATCH v13 07/13] sched/fair: Load balance only among preferred
 CPUs
Message-ID: <aqGVMR2m_NF76tv3@yury>
References: <20260909135617.871006-1-sshegde@linux.ibm.com>
 <20260909135617.871006-8-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909135617.871006-8-sshegde@linux.ibm.com>

On Wed, Sep 09, 2026 at 07:26:11PM +0530, Shrikanth Hegde wrote:
> When a CPU is marked as non-preferred, any load pulled towards it is
> pointless since the task will be pushed out again in the next tick.
> So, consider only preferred CPUs for load balancing.
> 
> This ensures load balancing does not fight against the push task mechanism
> which happens at the tick. Also, this stops active balancing from happening
> on a non-preferred CPU pulling the load.
> 
> This also means there is no load balancing if a task is pinned only to
> non-preferred CPUs. They will continue to run where they were previously
> running before the CPUs were marked as non-preferred.
> 
> Bail out early for NEWIDLE balancing, as load balancing is done only on
> preferred CPUs. Note that idle balancing is allowed to go through, since
> that naturally updates nohz.next_balance when all the idle CPUs are
> non-preferred.
> 
> Also, optimization in find_new_ilb() is skipped. The steal governor driver,
> which is introduced in later patches, updates the preferred CPUs state in
> descending order. find_new_ilb() checks for idle CPUs in ascending order.
> Hence, in most common scenarios, the idle CPU found by find_new_ilb() will
> already be a preferred CPU. When all idle CPUs are non-preferred, the first
> idle CPU has to be chosen anyway. All of this is naturally handled in
> find_new_ilb() currently. Adding additional complexity to it for rare
> edge cases is not necessary.
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Reviewed-by: Yury Norov <ynorov@nvidia.com>

> ---
>  kernel/sched/fair.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b8bd308c2d5b..4ef1167b8c73 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -13473,7 +13473,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>  	};
>  	bool need_unlock = false;
>  
> -	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
> +	cpumask_and(cpus, sched_domain_span(sd), cpu_preferred_mask);
>  
>  	schedstat_inc(sd->lb_count[idle]);
>  
> @@ -14588,10 +14588,8 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
>  	 */
>  	this_rq->idle_stamp = rq_clock(this_rq);
>  
> -	/*
> -	 * Do not pull tasks towards !active CPUs...
> -	 */
> -	if (!cpu_active(this_cpu))
> +	/* Do not pull tasks towards !preferred CPUs */
> +	if (!cpu_preferred(this_cpu))
>  		return 0;
>  
>  	/*
> -- 
> 2.52.0
