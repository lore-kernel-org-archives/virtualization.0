Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5D7824A7
	for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718791795; cv=none; b=JUv3d0q/dh6f5bED+DIocx1RZOFaOWgfINC4LuN/Wh6uW8LevOOoSlLRhHD0tUy3s+roLGryjyznMLLNxhoiz/PmuvxSShmfYByBuQhRtcn9GIVFkfTTWW2MTlyjpNE3TxjILjG4ajmBMGHWQDunTNl1ZxtJoAl5sDM0mxiHJLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718791795; c=relaxed/simple;
	bh=go0N1DzsnwUSIX3tAlGUzWU5ojSNLuO8X/Rf/c9a+jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAcPdlspHqtMpM9mY2trgsodVdd++jxPJHZQOVElp0pzuvBT281dzyqa5WcLRErbHKZPaJIaEwpdTNXwj4tn3xI8+WA4SKpigDKqZVhZ/H3e8/tfldK+Ds8MQMdk5CB0GjdxZrvf4xeqm9yrK14bpWwFpgQ9X6k5vZ8dKs10LcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=0jK9OeOG; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="0jK9OeOG"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-421bb51d81aso48993585e9.3
        for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 03:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718791791; x=1719396591; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lXZz75hd5uGBGJqUsDcAFXcdIZelqwAK9ojhlaEtNmQ=;
        b=0jK9OeOGMKjOgeeZGllPzaYeJ3WWuDxSA6L9iaht6RmwYQCRqo4KJz1MM65jiXs3vh
         Pqnox2QuNUbn82czJIQqBxVoNjop7Qrl7IgYPvpnvlCcY3E90DB/h29Jd8l9aacMOuFA
         dQOK5TH9eh1wSRwwoTj897Ezz68PVB2GbGt4mbjPjDIKb53BjuN3f3h3krXY4D9VG0cl
         8ZkeLfrhjj+Br/ZQOr8BGUZ9UtNyB3yIYRWV+DkkACCaa6HYoXLxpja9+8GMoCmI599S
         pI1BSu08MpHLLjNh8On9EO3eIS6ZJMqwS4P9hC5FH0xJNAVO7pNVM9vV6qsNVmDmaGjl
         Vs2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718791791; x=1719396591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXZz75hd5uGBGJqUsDcAFXcdIZelqwAK9ojhlaEtNmQ=;
        b=et7DuXWTzy2jSXTYsEm21p8Hgc7EbgCyVe9bWIW5+NoGrzSD5/0FuMjNfgLRlaBj05
         caJ/ImTaSLieQtU1XsbdH2PvbYocO8/Ufxu/SDq1edikJev+o/mWytU8lO0s+vfTCiMV
         G9vSyMRNgnlkGnyTrZaQVSodSxCWBlA4YC+eDM/4+PSyI3KNK4R8awb8jkkLx3Jzrn07
         S8R6+2Y7jlL7+9X7/4zYKTjcjvKem/ZCG2nypDXhQIQ5zprvwCiyUUQOv75tFYArq3MB
         Igd7Z5hHdNKEPa9Oymz5jvh4PeVpliN5aKhm/XSDS8y9OvuA85WAWBOHkOC62SDKfVRZ
         7JLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWGGcBxKm/rYEJq+doKFXlC9ycZt+HRUKVCTvm4frchA+9uZl+PdUl+9cy3UUwQqxEqWQ9achojMvmZSomYrI1fNi0qzQTrJkS61xrdfY=
X-Gm-Message-State: AOJu0YxjjxRAOgf6vqOjmOjzbAOfBt9Cfk9NLf/lZie4gSPyKiWoD52p
	Yw6vKQ+LtZxtjtf7+/UUbGGC2MRQ8SLVEt5wZB5d6zdu1XSiJNtG5Y0qvSPIuRg=
X-Google-Smtp-Source: AGHT+IHFvkihrclMF2NJsgs2fSWvJrLrizWwcUSzCRuHn3PE2s5QfpEXdAaiI6uX4/l2LPecwiMxLw==
X-Received: by 2002:a05:600c:1d17:b0:424:760d:75ce with SMTP id 5b1f17b1804b1-424760d777fmr13098055e9.7.1718791790683;
        Wed, 19 Jun 2024 03:09:50 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286fe8fb8sm263909255e9.11.2024.06.19.03.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 03:09:50 -0700 (PDT)
Date: Wed, 19 Jun 2024 12:09:45 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, dave.taht@gmail.com,
	kerneljasonxing@gmail.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH net-next v3] virtio_net: add support for Byte Queue Limits
Message-ID: <ZnKuafjQt-Y-VokM@nanopsycho.orion>
References: <20240618144456.1688998-1-jiri@resnulli.us>
 <20240618140326-mutt-send-email-mst@kernel.org>
 <ZnJwbKmy923yye0t@nanopsycho.orion>
 <20240619014938-mutt-send-email-mst@kernel.org>
 <ZnKRVS6fDNIwQDEM@nanopsycho.orion>
 <20240619041846-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619041846-mutt-send-email-mst@kernel.org>

Wed, Jun 19, 2024 at 10:23:25AM CEST, mst@redhat.com wrote:
>On Wed, Jun 19, 2024 at 10:05:41AM +0200, Jiri Pirko wrote:
>> >Oh. Right of course. Worth a comment maybe? Just to make sure
>> >we remember not to call __free_old_xmit twice in a row
>> >without reinitializing stats.
>> >Or move the initialization into __free_old_xmit to make it
>> >self-contained ..
>> 
>> Well, the initialization happens in the caller by {0}, Wouldn't
>> memset in __free_old_xmit() add an extra overhead? IDK.
>
>
>Well if I did the below the binary is a bit smaller.
>
>If you have to respin you can include it.
>If not I can submit separately.

Please send it reparately. It's should be a separate patch.

Thanks!

>
>----
>
>
>virtio-net: cleanup __free_old_xmit
>
>Two call sites of __free_old_xmit zero-initialize stats,
>doing it inside __free_old_xmit seems to make compiler's
>job a bit easier:
>
>$ size /tmp/orig/virtio_net.o 
>   text    data     bss     dec     hex filename
>  65857    3892     100   69849   110d9 /tmp/orig/virtio_net.o
>$ size /tmp/new/virtio_net.o 
>   text    data     bss     dec     hex filename
>  65760    3892     100   69752   11078 /tmp/new/virtio_net.o
>
>Couldn't measure any performance impact, unsurprizingly.
>
>Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
>---
>
>diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>index 283b34d50296..c2ce8de340f7 100644
>--- a/drivers/net/virtio_net.c
>+++ b/drivers/net/virtio_net.c
>@@ -383,6 +383,8 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
> 	unsigned int len;
> 	void *ptr;
> 
>+	stats->bytes = stats->packets = 0;

Memset perhaps?

>+
> 	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
> 		++stats->packets;
> 
>@@ -828,7 +830,7 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
> 
> static void free_old_xmit(struct send_queue *sq, bool in_napi)
> {
>-	struct virtnet_sq_free_stats stats = {0};
>+	struct virtnet_sq_free_stats stats;
> 
> 	__free_old_xmit(sq, in_napi, &stats);
> 
>@@ -979,7 +981,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
> 			    int n, struct xdp_frame **frames, u32 flags)
> {
> 	struct virtnet_info *vi = netdev_priv(dev);
>-	struct virtnet_sq_free_stats stats = {0};
>+	struct virtnet_sq_free_stats stats;
> 	struct receive_queue *rq = vi->rq;
> 	struct bpf_prog *xdp_prog;
> 	struct send_queue *sq;
>
