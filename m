Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B295C154BE8
	for <virtualization@lists.linux.dev>; Fri, 12 Jul 2024 10:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720780905; cv=none; b=RZX4Yq4pk2FgnuZ7i0cHQjJe2eqiUgaw8NUyHBAhjhmBBA5tx7y+oTLBvHTnIcn01x7KS9FzOsjGboD2Dt1tLq8Ej9wMzCYx+20TXHofoFYXAtUfAdE1N6vJQmmgZwr98fRxk1yNyR0pr5wdH+sVJkf/T+dl3jN/q2hJscHmJvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720780905; c=relaxed/simple;
	bh=YzBJLaP5b66CE8Z23dlgpk1BztCreho1AUoOB+MtsC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DDuabpaHdaEKCdtD8zscbG6nnlcq1Lv5/ZyFcg0NpkP/fP3kzXp43GZQeHgXX4U6VQB9nKxvs4vawY3OSsxHWz+FiKrFicbUKzQWV0G8HQniShgyQOeL1F4fl5fPEcDf/M4w50z/G8MKv72nF9ah+uZy5lPceaFOUkd0WmNhQFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FWkp/6dq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FWkp/6dq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720780902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E67/qwqrLYs0uApKpXhnQ+HOWLOkwVXqoDhKeoX4fEM=;
	b=FWkp/6dqOpZiWKVI6fOM5iEduJIGKgict5TXpbJbaepFgPmBpb9Fk0UAqiieTS/UhI+y47
	SybCAxq/gVuouSCFqvW9r3cSfhxRXO20i3Xyhr6KPoFVT9deMiPC+upn5Wns2gr2qVHcvd
	fTTCyK504RKMmgjfQMzRxPYeosmnQv0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-ZX2H9xkDMOum0MYpmcc-kg-1; Fri, 12 Jul 2024 06:41:41 -0400
X-MC-Unique: ZX2H9xkDMOum0MYpmcc-kg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42667cc80e8so12258055e9.2
        for <virtualization@lists.linux.dev>; Fri, 12 Jul 2024 03:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720780900; x=1721385700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E67/qwqrLYs0uApKpXhnQ+HOWLOkwVXqoDhKeoX4fEM=;
        b=LKMuLpv9RlibpEwZc/6ALaHTLBGq9DCwT+PjpVWz4Yx730C5eRvVB0U9olljM5Xdnw
         TYon5V23oxO5RxlpZ1jjk7+5M/oIPo3WPVTcbGIQ0Y85WKRQXKOVXps141C0tpzC6rCH
         RhJfiQP14d41h6ON0Fd10L3rflIThlRK2J6fbKmo1VkjSD7Gcu6MEzGY6+zrd4HbSl/A
         J5+ajvYuJ6FsLmHO/Ek23oGIfOthEr5ZRTO/c9bQe1/r9ETlMYciH49pqVVwTz+jakB2
         StHpaUAkf4lBdrfWZSZyIwzuMtibe0CWvOOnrOVH075KS5FVz1v0/tezm/vVHmLugept
         CXUA==
X-Forwarded-Encrypted: i=1; AJvYcCWePzQrZdHGg3AoDZMQecxdS3NsSQvQuGfLHALinUruiGHTWdzBEeSMe0XPpvhlZC00DSJI7+yk6fs7uzH9xtrG2waQL+evPDaGucOZaC4=
X-Gm-Message-State: AOJu0YxwQj8M5ra1Dhcq9ywR3mepuJAY7hdDMBgZg5bZzJAr3ovi6cUx
	byIXGuoqd21sllZFApZs1egeXumzNMeu1G7V4nLZwDDFNNncVb9uIZ9hP1RVfpawuSJASiJTwQb
	tMCDlqfEwcSdL7VMqPpmLZ3gwoCu2Qbl/d67TVTdZwmzPk+ER9SXzden9/Nsll4If
X-Received: by 2002:a05:600c:5345:b0:426:602d:a243 with SMTP id 5b1f17b1804b1-426707d8a90mr79381335e9.16.1720780899990;
        Fri, 12 Jul 2024 03:41:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8OPh1JQThp8k62evdvZ2hO2J+txRXY+8A943RJMLhueJqiK6v1NIubwHMCk3qBpabQ+QOjA==
X-Received: by 2002:a05:600c:5345:b0:426:602d:a243 with SMTP id 5b1f17b1804b1-426707d8a90mr79381035e9.16.1720780899393;
        Fri, 12 Jul 2024 03:41:39 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:341:761e:f82:fc9a:623b:3fd1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde84912sm9902723f8f.40.2024.07.12.03.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 03:41:38 -0700 (PDT)
Date: Fri, 12 Jul 2024 06:41:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, Aishwarya TCV <aishwarya.tcv@arm.com>
Subject: Re: [PATCH net-next] net: virtio: fix virtnet_sq_free_stats
 initialization
Message-ID: <20240712064019-mutt-send-email-mst@kernel.org>
References: <20240712080329.197605-2-jean-philippe@linaro.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240712080329.197605-2-jean-philippe@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 12, 2024 at 09:03:30AM +0100, Jean-Philippe Brucker wrote:
> Commit c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
> added two new fields to struct virtnet_sq_free_stats, but commit
> 23c81a20b998 ("net: virtio: unify code to init stats") accidentally
> removed their initialization. In the worst case this can trigger the BUG
> at lib/dynamic_queue_limits.c:99 because dql_completed() receives a
> random value as count. Initialize the whole structure.
> 
> Fixes: 23c81a20b998 ("net: virtio: unify code to init stats")
> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Both these patches are still in next so it might be possible to fix it
> up directly.

I'd be fine with squashing but I don't think it's done in net-next.

> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 10d8674eec5d2..f014802522e0f 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -530,7 +530,7 @@ static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
>  	unsigned int len;
>  	void *ptr;
>  
> -	stats->bytes = stats->packets = 0;
> +	memset(stats, 0, sizeof(*stats));
>  
>  	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
>  		if (!is_xdp_frame(ptr)) {
> 
> base-commit: 3fe121b622825ff8cc995a1e6b026181c48188db
> -- 
> 2.45.2

