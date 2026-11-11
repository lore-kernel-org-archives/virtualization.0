Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415664;
	b=WyEWznXPcRA502TfDiocuBrYHtu2O+hNu8qmQzYuCKwAkX/mvcef2r1aDmTk49qfTiZ3
	 Njcnk6OXVTwwpFYY9+rrYBOTqoRTLe6j1MgKqCRISI0Xe64HCzKrl9g5QyeXvC1jR7a7F
	 s2oUXKZyVLt45m7ohjkidReMm12VrhMLUCEN39sclfukirSpj6L4ZMdFlu+M3SQr2LKzB
	 hD0Xol9VEHRJFHZk8wvASN2kT3pEs6ghbq+lKjt08X0EcvKfOBtvviqrLW/vbOguulMIK
	 OIgDs2KAhmogvtdlMPx4kJU2eGTw4ylJYgfQeqi/ud2LpoGT0GeaeMK575/eOaKFBmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=JEN1we3zUbJ34wQgamBpttlVbDethKWGuPURScqYgfU=;
	b=0mGhN2KfRewuGIro2n9QwEd7QShX7HLnSZNRB6twlPizcDOyQEAoLBagW/r/yy/FLpCk
	 f1+Vm3RhMN6bTdw9P4K/qcPl0xPEc2oQejqQlPs+yt+8GXcuWtCvAXdxhQVh9k0GFPivx
	 5GltOiIQ0ISC25UDcwoKzG9LMqD2HPUwZ0Tu3xkNKgi7EQyDlRyGJ/DxdlAenfS6InqJV
	 StukHlVDfhLRanjB1csrC+lCwMAfprpyEKJFqOwogMFt8jjDhmThEeg4y5kLNUBL2M/gB
	 trQqjYuAPzOcxts9yDt2Z8jxuXXew+ROR+CTyQaRVgrHAxmabK+rbYjNrGIMpxZZIdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pxV0d1bK;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740F9606A330
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 16:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 740F9606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pxV0d1bK
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so252125e9.0
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 08:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794415663; x=1795020463; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JEN1we3zUbJ34wQgamBpttlVbDethKWGuPURScqYgfU=;
        b=pxV0d1bKyYUe1+xmb+QH9TTW/DktKeNIDnHt+AkmmCoTokOXse5avDBLuBhKr1+lFM
         1dt2Bt1+bx68ANjER7DiZeo1NoSfxWV/ii5NVjHJ1HBD8aWAmo/828eWqRgxhvD/H9RG
         jUmhJfrvQNuDeR7v8bPCsSDP3GcENj0i2XD/vKba56ZxIVXLPXDhZTQhn3Sf4XQUs9WU
         XvJs1Bv4iROFpViYH3GT7nq0BvQm9ihxCmioGVJwbtrVYGeP/H2bFnwGtjijnaCE2+g/
         G522IBicYbSodCoZjLkGhtrTcPAJvhv2DeYXL9HpvTRXi/eJzX71VBHffCXvJlJWJ0rJ
         1EcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415663; x=1795020463;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JEN1we3zUbJ34wQgamBpttlVbDethKWGuPURScqYgfU=;
        b=BBhMeUppqwaALeAQ7izs6FsI6Z22ZBr9NSiR2PX6nnyuglgyB6hDwh/ZhlSIpXvs7H
         jWO7hENFCVstNz33+wvvrZQAmnkNpiKRgxP14QNJWux/91A3wu665vx0n6kUJc13GVGG
         zNjWXgpgotAz26GAXi1i1EBEmC8VhS1mW/rzxH3Y9PBLgbZjcJBdw4H2QvWbkmJZ99OT
         NhgX6jHML5CBhLT3CnsA6Pn47V5/1aJ9z4y6jKMZ0EgfvS01bU045UvEnwJFlfzP6T8J
         1Dm92tao9hi+W6MYTQGNea2OC2yW2RFFkmxPmABcPsALK1V+XAM8ksWEqGxog/gJ08N0
         ARlg==
X-Forwarded-Encrypted: i=1; AL+hErGVjR14ZlTk8XckMQno4H4yISYlRrno+GSRyZqcjsqjhmA4CCpTNlvViUpfTr7QJTTMN6OsQ3g8sZ8H9G++2A==@lists.linux.dev
X-Gm-Message-State: APuU4Z8JAUi65lE6Ds5RlmB+2kmA/wuUIDNS7YhqdweKOX/Os1Gxwms7
	lW7tiaWZErP9Gj6dhdUlaOHl6zaJO3K05cZv/wGOnniMn0O8d4+aGqOSt38BiTD1Lw==
X-Gm-Gg: AYBFou2xM50hQK+Pt4fJlby1MFjHLx7w3o06EcZUe1uQ+2PqtQWm275CX1f12TCWsI/
	deB2sZHgi9BnkDfeNkOZXxyO9122v725E5tWL9tIJSxD03Zo5jDExta5A2i/Ft7X8g0SUap08Q5
	V3Z5u6rBkNo4j61CSvLxNtO+2YvDdOau2yWd9MDJR9iFtFw+g0Mxq/stDjlyitKzurDlcYdeheE
	j4IrrU3MNZuOMNRq4j9pEkYsIKMQuhqjg6gJ9jRJoW2Kd+SW8T/qMioffVdbF2XG5swGmcxyseF
	XJV6Vwqoozmtb0jtZRJKOrlxUacjtnuaBwkGTNjKwWLZyi0iiiooYPCZ1Kt+5oBGu0eT92xAgc6
	I9KO6oDpySkMhkc+Lobtev0jqA/9l0weqdUFraBL6Q0oLwboEzHatIV9Gd0yx7dOrtJJCo+0Kn4
	/1KCzouXBYXVTsJSVaBHM/tHZ2WtH09odDA9saTw0LGEMPimUmLRRLdsYBfRs/JE2MIK6aMa6lM
	mCkJweYVxTqy+4CSZgJC9GmBLdKYxJeOF92leY7mmXmUThCyePY4q1xQ321mT1cWdfDkW1MOOWT
	3MOyFWulquu4pQMRBZonNam9RmZ/PPh2pVsf9kOqRrZfNx/lu5jnhoc/Njq21UXFoQ==
X-Received: by 2002:a05:600c:3f07:b0:4a2:18c4:61a5 with SMTP id 5b1f17b1804b1-4bb4e27994emr1100895e9.6.1794415662004;
        Wed, 11 Nov 2026 08:47:42 -0800 (PST)
Received: from google.com (0.182.34.34.bc.googleusercontent.com. [34.34.182.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498365cd06fsm11724877f8f.40.2026.11.11.08.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:47:41 -0800 (PST)
Date: Wed, 11 Nov 2026 16:47:38 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Tao Cui <cui.tao@linux.dev>
Cc: akpm@linux-foundation.org, dgilbert@interlog.com, mkp@kernel.org,
	loberman@redhat.com, jmeneghi@redhat.com, kraxel@redhat.com,
	vivek.kasireddy@intel.com, mst@redhat.com, jasowangio@gmail.com,
	eperezma@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
	rostedt@goodmis.org, mhiramat@kernel.org, jgg@ziepe.ca,
	kevin.tian@intel.com, axboe@kernel.dk, linux-mm@kvack.org,
	James.Bottomley@hansenpartnership.com, sumit.semwal@linaro.org,
	christian.koenig@amd.com, phasta@kernel.org, joro@8bytes.org,
	will@kernel.org, linux-scsi@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
	iommu@lists.linux.dev, io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org, bobbyeshleman@meta.com,
	mathieu.desnoyers@efficios.com, robin.murphy@arm.com,
	mason@kernel.org, aesteve@redhat.com, tjmercier@google.com,
	harry@kernel.org, vbabka@suse.cz, cuitao@kylinos.cn
Subject: Re: [PATCH 4/7] tracing: account ring buffer pages and trace_array
 metadata to memcg
Message-ID: <avScKhR22kFOQ1z4@google.com>
References: <20261106131829.3228926-1-cui.tao@linux.dev>
 <20261106131829.3228926-5-cui.tao@linux.dev>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106131829.3228926-5-cui.tao@linux.dev>

On Fri, Nov 06, 2026 at 09:18:26PM +0800, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> Creating an instance immediately allocates two full sets of per-cpu
> ring buffers, array buffer plus snapshot, about 1.375MB per cpu per set
> on the default config, plus the trace_array and its name.  None of it
> is charged: neither trace.c nor ring_buffer.c passes __GFP_ACCOUNT,
> while user_events in the same directory accounts everything it
> allocates.
> 
> Instance creation is currently gated by tracefs file permissions
> alone, so a
> rootful container with the host tracefs bound in can create instances
> until the host runs out of memory.  Charge the ring buffer pages and
> the trace_array metadata to the creating cgroup.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  kernel/trace/ring_buffer.c | 8 +++++++-
>  kernel/trace/trace.c       | 6 +++---
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 1fd28a72e6ee..676c059c112c 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -441,7 +441,13 @@ static struct buffer_data_page *alloc_cpu_data(int cpu, int order)
>  	 * gracefully without invoking oom-killer and the system is not
>  	 * destabilized.
>  	 */
> -	mflags = GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_COMP | __GFP_ZERO;
> +	/*
> +	 * The subbuffers are charged to the memcg of whoever caused the
> +	 * allocation: the creator of a trace instance, or root at boot for
> +	 * the global trace.
> +	 */
> +	mflags = GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_COMP | __GFP_ZERO |
> +		  __GFP_ACCOUNT;
>  
>  	page = alloc_pages_node(cpu_to_node(cpu), mflags, order);
>  	if (!page)

Hum, by default tracefs is root only. 

And even if made accessible to other users: 

  1. The life span of a trace instance is not tied to the caller.
  2. The ring buffer is shared by multiple users.

Overall I am not convinced charging the creator makes much sense.

Eventually a few allocations for iterators could be GFP_ACCOUNT.

-- 
Vincent

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index e8c4efa8107b..04b60b9cc4f5 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -8693,11 +8693,11 @@ trace_array_create_systems(const char *name, const char *systems,
>  	int ret;
>  
>  	ret = -ENOMEM;
> -	tr = kzalloc_obj(*tr);
> +	tr = kzalloc_obj(*tr, GFP_KERNEL_ACCOUNT);
>  	if (!tr)
>  		return ERR_PTR(ret);
>  
> -	tr->name = kstrdup(name, GFP_KERNEL);
> +	tr->name = kstrdup(name, GFP_KERNEL_ACCOUNT);
>  	if (!tr->name)
>  		goto out_free_tr;
>  
> @@ -8708,7 +8708,7 @@ trace_array_create_systems(const char *name, const char *systems,
>  		goto out_free_tr;
>  
>  	if (systems) {
> -		tr->system_names = kstrdup_const(systems, GFP_KERNEL);
> +		tr->system_names = kstrdup_const(systems, GFP_KERNEL_ACCOUNT);
>  		if (!tr->system_names)
>  			goto out_free_tr;
>  	}
> -- 
> 2.43.0
> 
