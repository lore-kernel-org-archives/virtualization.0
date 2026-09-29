Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624D151B183;
	Tue, 29 Sep 2026 12:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684329; cv=none; b=D4AsQ6+BaE4ntaGMph5ktJvTXh+GgGKXuCC9/GYtk+ZbrQydCDHJ22qgCaJi8OcA8UTZFxPLmh973mP6BvMbD2+vU4LrI5AiKbaJhxQOqyaoJ7gNs7JEbucYX1NeUsUxc1UOq0aKLTQk8qODa0ijqKoOfdYIvWuxB2Rh7SgdHk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684329; c=relaxed/simple;
	bh=CGWOqCd9vsPY/gcXN/gnylro/kcR9EKe6etg52xavWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNQOD4zZJpz80cU518ZNDCz0BcUcMorNZvzkqCTENwsPK+d/5rLlpKyEQTaMA4RmZz9P+oFC2CTumNMa0KGnzdOHjtsD20Aj3T7aOLmWd5tghoV6elIvfgLdXMQHabDvszmopAizPZ1bqSsaEVA2GvuMZt75nkXGVkTP4rN8v/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2Qtf/pV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2Qtf/pV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE69E1F000FF;
	Tue, 29 Sep 2026 12:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790684328;
	bh=OLfJPOR0/R8u/zcgG0AXnc7VmM0ADuze8DIRGSrd7PE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j2Qtf/pVYxHItP5Q6BtmbsyJH9T5PyADGD5thiJf2iEvrppRDQLowpiFLUBGKD9UE
	 GEWhz1QuXnSai4S4iz+X3DjnUc7MMsSluEMefAAzFPbEmj/rcLvOxnIf1QE4m18YNz
	 wqhiiwQE5g/QGGEiFfWH4LGWfxLJIDku9Ullg18wVd8om8ZzXr6BM2e3ton1NGGACN
	 Uqm03sm+UCeCtZ/aQ8Jw7VoFUS4Zj2xFcnj6LmmD/Dc9gfKfRdXEsdBx0glKdUFKje
	 hYFOSGU2pp/L5OwfXDjBWamW9vtbzwrz9SNEbLBLTXVVMuW4YgNLpSFJvlzhGUxuOc
	 igpbdWqAWPv3g==
Date: Tue, 29 Sep 2026 14:18:38 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	yury.norov@gmail.com, kprateek.nayak@amd.com, iii@linux.ibm.com,
	corbet@lwn.net, meted@linux.ibm.com, ynorov@nvidia.com,
	tglx@kernel.org, gregkh@linuxfoundation.org, pbonzini@redhat.com,
	seanjc@google.com, vschneid@redhat.com, huschle@linux.ibm.com,
	rostedt@goodmis.org, dietmar.eggemann@arm.com, maddy@linux.ibm.com,
	srikar@linux.ibm.com, hdanton@sina.com, chleroy@kernel.org,
	vineeth@bitbyteword.org, frederic@kernel.org, arighi@nvidia.com,
	pauld@redhat.com, christian.loehle@arm.com, tj@kernel.org,
	tommaso.cucinotta@gmail.com, maz@kernel.org, rafael@kernel.org,
	rdunlap@infradead.org, kernellwp@gmail.com,
	linux-doc@vger.kernel.org, jgross@suse.com,
	virtualization@lists.linux.dev, sunlightlinux@gmail.com,
	Marco Elver <elver@google.com>, llvm@lists.linux.dev
Subject: Re: [PATCH v14 09/13] sched/debug: Add migration stats due to non
 preferred CPUs
Message-ID: <20260929121838.GA1814129@ax162>
References: <20260928053728.797539-1-sshegde@linux.ibm.com>
 <20260928053728.797539-10-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928053728.797539-10-sshegde@linux.ibm.com>

On Mon, Sep 28, 2026 at 11:07:24AM +0530, Shrikanth Hegde wrote:
> Add a new per-task stat,
> - nr_migrations_cpu_non_preferred: number of push migrations while the
>   CPU is non-preferred.
> 
> Since this new stat is per-task, it changes only /proc/<pid>/sched.
> It doesn't update /proc/schedstat. Hence increasing the schedstat version
> is not necessary.
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
...
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5049eff58fb7..7465c983e6f6 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -11236,8 +11236,13 @@ static int sched_non_preferred_cpu_push_stop(void *arg)
>  		update_rq_clock(rq);
>  		context_unsafe_alias(rq);
>  
> -		if (task_rq(p) == rq && task_on_rq_queued(p))
> -			rq = __migrate_task(rq, &rf, p, cpu);
> +		if (task_rq(p) == rq && task_on_rq_queued(p)) {
> +			struct rq *dest_rq = __migrate_task(rq, &rf, p, cpu);
> +
> +			if (rq != dest_rq)
> +				schedstat_inc(p->stats.nr_migrations_cpu_non_preferred);
> +			rq = dest_rq;
> +		}
>  		rq_unlock(rq, &rf);
>  	}

This breaks the build for me with clang-23+ (which have context analysis
enabled by default), although it bisects to the final patch of the
series since this is under CONFIG_PREFERRED_CPU and it is not selected
until then.

  kernel/sched/core.c:11292:25: error: calling function '__migrate_task' requires holding raw_spinlock 'rq_lockp(rq)' exclusively [-Werror,-Wthread-safety-analysis]
   11292 |                         struct rq *dest_rq = __migrate_task(rq, &rf, p, cpu);
         |                                              ^
  kernel/sched/core.c:11298:3: error: releasing raw_spinlock 'rq_lockp(rq)' that was not held [-Werror,-Wthread-safety-analysis]
   11298 |                 rq_unlock(rq, &rf);
         |                 ^
  kernel/sched/core.c:11303:1: error: raw_spinlock 'rq_lockp(__this_rq())' is not held on every path through here [-Werror,-Wthread-safety-analysis]
   11303 | }
         | ^
  kernel/sched/core.c:11286:3: note: raw_spinlock acquired here
   11286 |                 rq_lock(rq, &rf);
         |                 ^
  3 errors generated.

Not sure what the proper fix for this is, maybe another
context_unsafe_alias()? cc Marco just in case

-- 
Cheers,
Nathan
