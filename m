Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793470549;
	b=hbzTPRkGGEDGbLh1nml4yj/EKIJFl213CRDiPkb1mqj6Q9J5zCzYi7v0V1/QeQlwMnBn
	 Jhdt4cPp0x1QzupZ1EmXwjWUbyeWxqX4DYzxVUdiVfo26OgHJBjYuSJnpwviVB3TbKaSr
	 FTUaA73IC0ypbV4MpkdRMunh0ezgbANH/2k0VERykXHlgsY1xFYUf3YgJBLDfwDnhT/nX
	 8VwgjDoCGP6uv+PzkmwfP+Z2CKkqh2gA9p9w7hJ/qFWgAvG/llhtC66pP0duiOatMKKET
	 rzQkxudA5Ebj5O2tJfxDDUUmaPvLQs1g889CZCAP8Bn+CuCDstZLinypsXt1CuVMC0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793470549;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=Eec5Aouc9wFIQO+NM0GHrs+3vbQHhqX9lnMdXV8EI1A=;
	b=juwF+EzrJ+imXi14hJV+8BAAj2ifsS+rRttkAV/pCq2v+FjMfL1YH8udnJy2Gx5XVQiN
	 EVVtsnDlZfJnTkgAVOTz75CKne3XmF8nv1Dv/EBCknshmh74fVhgBl/Hz3pt98FjODsQM
	 VdzxdIydFFma2AKWflC3MSbcpMJS1uFpyb3oPaF8CBN37qjScDecRJn+pCf2kub3fVol1
	 2Uy7Z2f0kvaz40vtVXp59HOr87tMLKl3iAO3vDH6Kx1M6Zci1QEzCbHXKIJ6JtwRf4OQL
	 h8o6iY7TvPTGCuCQJnR5E9lXvh4LVS9E7+DhhxjrYaJZnfr9bYqxFXb0bK4mATpjBJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SIAM12Ao;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79953606A31F
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 18:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79953606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SIAM12Ao
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793470547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eec5Aouc9wFIQO+NM0GHrs+3vbQHhqX9lnMdXV8EI1A=;
	b=SIAM12AolSq6pTkL141wKgFIS/iF3deL2c3a2tQ5ExQ7nw2lBKmzMbRv7ikb1UZ3CWPo7y
	nApaKKJLMKYkLGv/xEKs8mdJXUqEdhuoajglzgiVVF2f9x+NrBzacxbDuagmB+WOyh66RI
	pqwr577MZwTtT2Nioe6QlS0Az3luPJo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-3qiL72ixMAGuwdV2bzrYhQ-1; Sat, 31 Oct 2026 14:15:46 -0400
X-MC-Unique: 3qiL72ixMAGuwdV2bzrYhQ-1
X-Mimecast-MFC-AGG-ID: 3qiL72ixMAGuwdV2bzrYhQ_1793470545
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a359c7f47bso15368425e9.2
        for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 11:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793470545; x=1794075345;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Eec5Aouc9wFIQO+NM0GHrs+3vbQHhqX9lnMdXV8EI1A=;
        b=oz0Fuedn+VA9iotJZObEZJX8iE2S8dfhbpoCpVLO8vDdYbahOtjRueTiQLZ5WEhGuF
         86xszeCPYD7ckN4eWsvxdePslbX57HG23Fd68XK6ZF2bjP7WfddP5fpnCoXg0NB19GAr
         u7EN20ZvUjeT5oflv0HeRoh8VHZH9JCel8wu1QmMT+HaOjyACHaHAAuu00EcJo1Ej0Qh
         mx70+2yHKJfDFCrIvUVvfxuVKcH7oBtKP9UtKCoJZKmUICzMNcRPwAbu1xBvK3dm2sE2
         84NgT25+szfFJyolvHW3EDi737/jptqaUtuIvSgcQrCtrLZaYUpiCBLuwSjd5IHtn+fe
         NXsA==
X-Forwarded-Encrypted: i=1; AKwUvBzCjgMfADRMLgXEazT5c+PBkWULI5UTz+Ra7p8Ol2VbOtvmT5sKDCYbyx3XVCF2N+ozmmqD5AytjFli8PLMUg==@lists.linux.dev
X-Gm-Message-State: AFq9FYIXUq8XneEJMwlxYifqCd4gJqWu+pHmyHiZj0N7H1JF3Ts1yc/+
	vkd2JZUAtUzpaMsqwwEnylQqwM5QFThGPz2SAvfFidFsrhQAivaa5GHoYfoH1FflXWEVOzbcYSv
	+cUZSQqNBDl1Ow4+SVkKsNPiejkIJcfk3/S7mtQyl2vTFOwwrQwgdNqX5Wj07LCmYCjse
X-Gm-Gg: AYBFou1Mp8MlEYQ+FSfK5TeNuAkqewwE/z1Me3BsStxytagER/WaKJ2hQ4Wh5zUtY8l
	HA3L2VNQe5HN3hW/ht1+FQ+4jipdCnvky9/508Rf2NQ2U9GiboL3LnVbEDVCfTa2ocPPp3hzIwT
	BZVOuRad0LxeOePQeP0PwiblQH6ig8NdVtBMc9kDgWZi2SAlOXU+8rL/qPoVUARXiKPbgZOeYRD
	9t4VZAbZ34IKMkZMYZCbTM2bdpCi+kaW0ft7dIwRRMbrmlCRb4C/r3ZEJCQht9TmVk0TenSjnbz
	aWO96QX/BWufCdFLLNxm2RADfIFv1U1LhNgWDlr2bxTQbzZsFe0zmxN/1NP2jXWuxEPpUI7TYwy
	lR+1z8M7r1jjkSk3wK72VusiuJkz8z5IV2EhFOgonqxt0
X-Received: by 2002:a05:600c:4454:b0:4a3:5a7b:6002 with SMTP id 5b1f17b1804b1-4ac17d19777mr127328195e9.28.1793470544604;
        Sat, 31 Oct 2026 11:15:44 -0700 (PDT)
X-Received: by 2002:a05:600c:4454:b0:4a3:5a7b:6002 with SMTP id 5b1f17b1804b1-4ac17d19777mr127327715e9.28.1793470543790;
        Sat, 31 Oct 2026 11:15:43 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73c1:fd00:6c8e:5a61:f533:519d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abeb77af8csm210425925e9.1.2026.10.31.11.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 11:15:43 -0700 (PDT)
Date: Sat, 31 Oct 2026 14:15:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org,
	linux-mmc@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost_task: do the return-to-userspace work between work
 items
Message-ID: <20261031141506-mutt-send-email-mst@kernel.org>
References: <20261031181004.4193627-1-shakeel.butt@linux.dev>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261031181004.4193627-1-shakeel.butt@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: o05rXpPWgUp24X3Gc8Hc0Gm549QN9UMc0Q7nNU48A60_1793470545
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 31, 2026 at 11:10:04AM -0700, Shakeel Butt wrote:
> A vhost task is a user worker: a thread of a user process that runs only
> kernel code. It never returns to userspace, so it never runs the work
> that is queued for the way back. resume_user_mode_work() does that work
> when TIF_NOTIFY_RESUME is set. For a vhost task this means:
> 
> - memory.high is handled at the wrong time. When a charge goes over
>   memory.high, the task counts the pages, and should reclaim, and sleep
>   if needed, on its way back to userspace. A vhost task only reclaims
>   when more than a batch of pages has built up and the charge can block.
>   Then it reclaims and sleeps in the middle of the charge, maybe while
>   it holds a lock. vhost-scsi, for example, can fault in guest memory
>   while it holds vq->mutex. If the charges can't block, nothing is done
>   at all, and the count keeps growing.
> 
> - Block cgroup throttling never runs. blkcg_schedule_throttle() asks for
>   it, but only resume_user_mode_work() acts on it.
> 
> - Task work queued with TWA_RESUME, like a deferred fput() or a NUMA
>   balancing scan, waits until the task gets a signal or exits.
> 
> io_uring workers had the same problem, and io_run_task_work() calls
> resume_user_mode_work() for them. Do the same in vhost_task_fn(): if
> TIF_NOTIFY_RESUME is set, call resume_user_mode_work() at the top of the
> loop. That is between work items, no locks are held there, and the task
> is running. Passing a NULL regs is fine, io_uring and KVM already do it.
> 
> This covers every user of vhost_task_create(): the vhost workers and
> KVM's NX huge page recovery thread.
> 
> Tested in a VM with a version of tools/virtio/vhost_net_test that puts
> each RX buffer on a new page, so the vhost worker faults in, and
> charges, 256M while its cgroup has memory.high=64M. Before, all 285
> calls to __mem_cgroup_handle_over_high() came from try_charge_memcg(),
> inside handle_rx() with vq->mutex held. After, all 589 came from
> vhost_task_fn(). memory.peak stayed at 64M, and the run took about the
> same time (0.66s before, 0.67s after). A lockdep kernel showed no
> warnings.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Is this different from:

Message-ID: <AS8P251MB00012469E6ECBEA2B7D87BB0C86C2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>


> ---
>  kernel/vhost_task.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index 3717885a5992..f0ab21aa2a1c 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -7,6 +7,7 @@
>  #include <linux/sched/task.h>
>  #include <linux/sched/vhost_task.h>
>  #include <linux/sched/signal.h>
> +#include <linux/resume_user_mode.h>
>  
>  enum vhost_task_flags {
>  	VHOST_TASK_FLAGS_STOP,
> @@ -38,6 +39,14 @@ static int vhost_task_fn(void *data)
>  				break;
>  		}
>  
> +		/*
> +		 * A vhost task never returns to userspace. Do the work that
> +		 * would run on the way back, like memory.high reclaim, here
> +		 * between work items, while no locks are held.
> +		 */
> +		if (test_thread_flag(TIF_NOTIFY_RESUME))
> +			resume_user_mode_work(NULL);
> +
>  		/* mb paired w/ vhost_task_stop */
>  		set_current_state(TASK_INTERRUPTIBLE);
>  
> -- 
> 2.53.0-Meta

