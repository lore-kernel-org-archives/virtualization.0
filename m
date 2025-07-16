Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537A42EAB63
	for <virtualization@lists.linux.dev>; Wed, 16 Jul 2025 08:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752656342; cv=none; b=o2EsFJZ3lJxlisHMNtlEzGXQ4FNF+ipJvYxy2PCH8Kz9YD7L/ZZFlEW/mnkHXSIYHZpe/g+qpfYat/N7zb/F85xg2KIZQ9td1yp6lCIuVbIG+d+ueY5B5udsejJj8bKoOqxLjaZwBL+8izN8PGfd0nr8lx+V0psApaq4qnPS9aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752656342; c=relaxed/simple;
	bh=k/xKLRmdytdD5dFxCZPED+uv6Wm4lSnJRb0jKkIgcTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=F/18nh/KCd3FnTlkOxKWFdwXRXzco+JD+IeKBI75xV0GIGxI/dxvYhIufrU6qD7WGOQmuSRfaxW38lJ6mXWMAM3rpt6kJG85XEfGxslT84xEhSXjmbU6y2K6IfyaHIcOLnp2YfhdNsWTTKpLGbrWWZ6/nVir3vcsyoZZEeRY0ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cKNUcUFW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKNUcUFW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752656340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BzMG3VIcZp7IpI2SiaxGZq52jq3kQ6ab3CdN8rN3Rxw=;
	b=cKNUcUFWAouNwDAl0gOf3bF/rOaPZpi0uczTTXYDi9TUxmGA0erBytO1CPNorJfFLp3crX
	ncgSHATox774TBfo41j/SBVvSTvo/MWt/pr1ELOAjyET8JkhLcDejjYOk3se7yJzVqZR9r
	QIvAV0ltViE7Oo6GeOohBVl4sItdbN0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-2L62pRX3NXGvxVPnv6SfRA-1; Wed, 16 Jul 2025 04:58:58 -0400
X-MC-Unique: 2L62pRX3NXGvxVPnv6SfRA-1
X-Mimecast-MFC-AGG-ID: 2L62pRX3NXGvxVPnv6SfRA_1752656337
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a523ce0bb2so3164413f8f.0
        for <virtualization@lists.linux.dev>; Wed, 16 Jul 2025 01:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752656337; x=1753261137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzMG3VIcZp7IpI2SiaxGZq52jq3kQ6ab3CdN8rN3Rxw=;
        b=FVnqTQU2D+oks83mrKqDvwsXsKbYZouL4QZLyuduIqDTZM2OUB2PVqojLuaRetXXlK
         ywfapZ2GgB44erT8jorkycB5F0FlTQyUfkkp56lnXi4GezOth9j1OK9DRxA6xKSgETPH
         Ug+8tYMTVEaO1OXSmckqdcBv/HNk7y5V+Y2VPLyDwyN2hOXjNRQXwY5S51Y65b3IRF5z
         vGvH6hpf9mc/cHw8jGiHLlQVbe5jZ8Tko50cHHevrB/Qxy0sDphN5ANO2Si3lJ/SkR0v
         X1UXgEd0sPY2tZlR9bmyzgIJk5SDFO8Dh/48fTSI/6C4422t8JxAUShXI7z/hivOHW7g
         G62g==
X-Gm-Message-State: AOJu0Yy4maF+KYVAiHdMcwQ74V6dUAa/8YgtIC7zE9qkkzHmPkyw0HKS
	zULGMKIGT58hCi399sJxZ9+DaTOiOCxdiMgfSQOvc8mkc52zAkYiUftClKt1w6aMSijGOVYJS71
	B1CbHrZvj+SWaEiZj6l5KYcpFbXyEabHajiBdUIVOVhKcGXyTpa40f8pQaAB4LE+xNR0i
X-Gm-Gg: ASbGncv3tpawufJAGB49x20Kz2YEI7QLret61KbOtb7x1nVeTeT6pGlh52CfBNkV9qb
	6gGm1t4ZH9ErBUGGZy1f5VE6Gh6wIyS5irHxH6mFtNVy1DTJfjLp6T+W9KnQuqabHPNU/Pn6FSR
	Gr9smlqN8/tFEwWD+I6SHulTZmxpDJjWZAHcu4ZU/pOyp5+y4DNY9Rb3uev0xuZHIADDqcgUtdL
	4wbNGbYv72bLksYMyhw638Pf+5C6dUNj1q1B3jwAifmy2uI58VcceruTcmTKpdH8uHUHiQr/3JG
	Kb6HONh0D4hH0SOW2UtyxWBooIxHHmNv
X-Received: by 2002:a05:6000:2087:b0:3a6:e1e7:2a88 with SMTP id ffacd0b85a97d-3b60e518b33mr1415220f8f.57.1752656337277;
        Wed, 16 Jul 2025 01:58:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgFM5T6msjvz4eBt9JJxEEAvHAo5VJrH/1JPYb+hX9XJmhxEwUw9K86spL5EHzREJnWORrmA==
X-Received: by 2002:a05:6000:2087:b0:3a6:e1e7:2a88 with SMTP id ffacd0b85a97d-3b60e518b33mr1415197f8f.57.1752656336811;
        Wed, 16 Jul 2025 01:58:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d76fsm17596638f8f.64.2025.07.16.01.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 01:58:56 -0700 (PDT)
Date: Wed, 16 Jul 2025 04:58:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH] vhost:  Use ERR_CAST inlined function instead of
 ERR_PTR(PTR_ERR(...))
Message-ID: <20250716045841-mutt-send-email-mst@kernel.org>
References: <1a8499a5da53e4f72cf21aca044ae4b26db8b2ad.1749020055.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1a8499a5da53e4f72cf21aca044ae4b26db8b2ad.1749020055.git.xiaopei01@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ljlhJcUDfF0WIHOLzbBa9M8apa-c9gyEcy_ITTZPZzk_1752656337
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 04, 2025 at 02:55:48PM +0800, Pei Xiao wrote:
> cocci warning:
> ./kernel/vhost_task.c:148:9-16: WARNING: ERR_CAST can be used with tsk
> 
> Use ERR_CAST inlined function instead of ERR_PTR(PTR_ERR(...)).
> 
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  kernel/vhost_task.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index 2f844c279a3e..8c4a82c0bdbe 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -111,7 +111,7 @@ EXPORT_SYMBOL_GPL(vhost_task_stop);
>   * @arg: data to be passed to fn and handled_kill
>   * @name: the thread's name
>   *
> - * This returns a specialized task for use by the vhost layer or ERR_PTR() on
> + * This returns a specialized task for use by the vhost layer or ERR_CAST() on
>   * failure. The returned task is inactive, and the caller must fire it up
>   * through vhost_task_start().
>   */
> @@ -145,7 +145,7 @@ struct vhost_task *vhost_task_create(bool (*fn)(void *),
>  	tsk = copy_process(NULL, 0, NUMA_NO_NODE, &args);
>  	if (IS_ERR(tsk)) {
>  		kfree(vtsk);
> -		return ERR_PTR(PTR_ERR(tsk));
> +		return ERR_CAST(tsk);
>  	}
>  
>  	vtsk->task = tsk;

I applied just this chunk.

> -- 
> 2.25.1

