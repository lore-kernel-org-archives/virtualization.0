Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657392;
	b=p29DZAAUFer1lbro9SBOtfQl90VJYscc8bCCKWbTSqylSk0s/wF0TCgjKy5SaKDmWsUM
	 E+P5+5mMnOJ+NyQRW0R9N+doZ6nrDF4+qFgf/Rt7yNtp03fBEWEY1fw3kDnbqmZdFn85x
	 z0HCrHCdEBRhz+wRwq/R4W4pBSyDvxgu6vP34dt0mGvYGP0dXTtx41JW4FJ+mkkHMawQ9
	 PtUjR3ihyMfovuvmnt2cKAM4ZNURBF2FLyXu4zjxbSffjTBDeYvjVVfweh+7wybzBT8gL
	 SIk9tDyCatYW4v4hs5mHKjEAm1Dra2RlxhiSndnB7UMNYb+cruaCKXlEluABPRTa/MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657392;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=/bwPKqX3Gv7tWV58tpYeJSVI3i/HRCmm3Zim49VKIWM=;
	b=HofymeVexXfK0rPN85fzA8YzlnkL0Nz2SjMCNsRk26x9vkJISWltKQ8DRfMlm809+q4i
	 L+IJD9VoqM7HDRrIgpbdxCWIk7LE1Q9ikjYSox6Zy2TW/N0G7+Qb1EdEJ3EK7/m18Uma0
	 aJKEWgb+1vdy22ulpn3/sTJv9cj48UbpX2/+WWmfOdlysDxevOQqPmzjKIDMcM0WoIGq6
	 knp9yQF57r63y9M2BNnT7dgOyYdshI9rwkxfMv44Bpo+f3dQjOysm5F3phXIEnmHcKkIL
	 xiQghKGpzEarYwrCPm/Ku5+9A/SIEYl412Ca/hO4dAigRz2b5UjtMxEHL746h4+VxEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Zi9t3Ta/";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B52606A32C
	for <virtualization@lists.linux.dev>; Mon,  2 Nov 2026 22:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3B52606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zi9t3Ta/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793657390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/bwPKqX3Gv7tWV58tpYeJSVI3i/HRCmm3Zim49VKIWM=;
	b=Zi9t3Ta/286WYIuLbICG4S12UU1PeptyJp4kgXuA/K/8tkb8Qcvq7HFxF+dDQEoBkKY+cP
	W2nlhuX5Uv6knB3ng9T/z/jQ3V6C5HKFCfgZnow9CO/yKBh7GjvPX09CjamIgDC7baZk9f
	kP7PWJOS1C/tVLJ/vz53+ILU4GGmhC0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-OHWUMneKPtu2ddjaRAeYAA-1; Mon, 02 Nov 2026 17:09:49 -0500
X-MC-Unique: OHWUMneKPtu2ddjaRAeYAA-1
X-Mimecast-MFC-AGG-ID: OHWUMneKPtu2ddjaRAeYAA_1793657388
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a204ac318aso10077185e9.2
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 14:09:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793657388; x=1794262188;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/bwPKqX3Gv7tWV58tpYeJSVI3i/HRCmm3Zim49VKIWM=;
        b=0BNHuWevequro9iObIaUG8LHOjBSbaqt2ruyq778SJ5u79FMru2DEoUM+JOGeweDgm
         xGRoBT4AZM6oxtevLd0AxPYqf/RYeqp9HpvtO34F1qV2YbwO0P2bR9f2g5GaZ+e76kYY
         HyIVqL7uhnIt9NSNh5h4eaJkBgUltKMuhCR9/zwXScjai+aGRkJcn859/GUt2Vhmpyxn
         DJMKVcZ5I5nqASNPJ/HSDVACgXvZFqXzyixI3+HIORCPHgbYDhS/w52tgoIt3AY+j24p
         owlQiHUTM9+Aw6vfg9m2h/3npqw/ibJmoSw4frXLgxZppIv/j+4ywNy4qZLPXHVYdutW
         6sxw==
X-Forwarded-Encrypted: i=1; AKwUvBysVTkNAhBSTNGdqJQ5uPkFmvEL3ESJiJesRhnbtvTWsjhfDSO6B5dCcSSbaM7kD70fiZoSrF6Qdr8XNbIsuQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYK4EcbrHqqR7FS1fJRWlyst8qpvXyzU/YzsLmedyWkTia3H1rWD
	ZF0uKpWZ9EbqSQyd8WwhvD09dwGYRzM3qiygH1iVjhgCuOQZy8rRvHedjCPECWo2+Dv/6HVXNLt
	8/EOkOGi6SCI+4JUI7HJWNSdQnMYJgNIeRBzE/QFuBrryIvU9Vag89yqsCUPp49VRk4af
X-Gm-Gg: AYBFou3hgb/G1Z8J9QZK9rH6tbmwZubiMkHL4s+H8tGcug2XSclYKsfQzmQwyx+RmLA
	NavLsRb7fFJUaLvuLf7/xQ00DyLpPZkugv1NrFXk26lS2TEr9nbfrby9FUEAH8vyJY7kyPtqg/+
	xIqwZVUstIlPbW4+pdgzANIMR6qNXwzGO3eP5DeK42bWslYRqMB+0PapQFv/Rwbfs0JXZR7LOM4
	JU6ThBBfn2QqicE17DnyQGRY/X1vD+IqYW69bFGmUrBIvh0qIov13kqgwq6MAjdBRgxcU/N/P2b
	IVnrd96oX1h91l3Tcz0bPIzDUXEBUSCDYvVu0AGnDEpBp7YRhU3YBB3Pg5QJPaNV5xLIkpHMHDl
	5zj2reYjc5Qja1Y5XEy47eH7bJvVJdYyXvcwgyIBf4Q==
X-Received: by 2002:a05:600c:6384:b0:4a1:702f:c736 with SMTP id 5b1f17b1804b1-4ac150b20famr265866005e9.3.1793657388292;
        Mon, 02 Nov 2026 14:09:48 -0800 (PST)
X-Received: by 2002:a05:600c:6384:b0:4a1:702f:c736 with SMTP id 5b1f17b1804b1-4ac150b20famr265865565e9.3.1793657387857;
        Mon, 02 Nov 2026 14:09:47 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b723bfsm20624049f8f.15.2026.11.02.14.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:09:46 -0800 (PST)
Date: Mon, 2 Nov 2026 17:09:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Aaron Lu <ziqianlu@bytedance.com>,
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] vhost: Run TIF_NOTIFY_RESUME work in the vhost_task loop
Message-ID: <20261102170928-mutt-send-email-mst@kernel.org>
References: <AS8P251MB00012469E6ECBEA2B7D87BB0C86C2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <AS8P251MB00012469E6ECBEA2B7D87BB0C86C2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IdjNWzGgppiwQRzNBbYkXUlrmwKofIS-lF0Avs5tQYM_1793657388
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 31, 2026 at 01:33:13AM +0000, Aamir Ahmed wrote:
> Since commit e1fad12dcb66 ("sched/fair: Switch to task based throttle
> model"), a throttled task is only dequeued when TWA_RESUME task_work
> runs on its way back to user mode.
> 
> vhost workers never return to user mode, and vhost_task_fn() only runs
> task_work via get_signal() when a signal is pending. A busy vhost worker
> therefore ignores its cgroup's cpu.max, while its runtime is still
> charged to the group, throttling the group's other tasks (typically the
> VM's vCPUs) harder.
> 
> Run pending notify-resume work at the top of the worker loop, as io-wq
> does in io_run_task_work(). Commit 12013e3d4695 ("KVM: powerpc: Use
> generic xfer to guest work function") fixed the same problem for KVM.
> 
> Fixes: e1fad12dcb66 ("sched/fair: Switch to task based throttle model")
> Cc: stable@vger.kernel.org # 6.18+
> Assisted-by: LLM
> Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>

Could you pls respond to Sashiko's review?

> ---
> Tested on x86_64 with a vhost_task-based reproducer: in a 0.2-CPU cgroup
> a busy worker drops from 100% to 19% of a CPU. Reproducer available on
> request.
> 
>  kernel/vhost_task.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index 3717885a599..7fa96e1b85b 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -6,6 +6,7 @@
>  #include <linux/completion.h>
>  #include <linux/sched/task.h>
>  #include <linux/sched/vhost_task.h>
> +#include <linux/resume_user_mode.h>
>  #include <linux/sched/signal.h>
>  
>  enum vhost_task_flags {
> @@ -31,6 +32,14 @@ static int vhost_task_fn(void *data)
>  	for (;;) {
>  		bool did_work;
>  
> +		/*
> +		 * We never return to user mode, so TWA_RESUME task_work (e.g. CFS
> +		 * bandwidth throttling) would otherwise never run. Run it here,
> +		 * where no locks are held, like io-wq workers do.
> +		 */
> +		if (test_thread_flag(TIF_NOTIFY_RESUME))
> +			resume_user_mode_work(NULL);
> +
>  		if (signal_pending(current)) {
>  			struct ksignal ksig;
>  
> 
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> -- 
> 2.43.0

