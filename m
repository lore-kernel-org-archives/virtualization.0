Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8771CFA9
	for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718869417; cv=none; b=UHA/cVU0omZx7x4+6EeivZe5kGm7oEpGFDlGrIvUTNluON62xVAs4FcqrhmfN0kBjSeSrNyraxJAtEyo8HcZGg9npcZjqAfXyHBbfpXkiPX96556COBB45wTFeT4wC3JOdDwZHiObgXWBRnNoZzDwODqsOcZp+WQWiYeBfK5CvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718869417; c=relaxed/simple;
	bh=jyZP6zvozf8EbqUwf6ioCSVFEUju+1hSxjUKNLziRFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=noM5mGZNBg2LO4Ty1E3gwuT7JqZ6cfcaAci3BNBIUXEJI4PK41zetw3HEvTYjAGBmMqv7etVxlJkYIETxPWtp7VA9jQfTGj2EXyEiN4G+fdsW2ERfq3bbq6U3mt3/5J8amXznN9+zT1KGgKTWrGinblabaGWqoTsj1gkFMtHYl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ToWXMKb8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ToWXMKb8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718869414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6IllHNP6pe8oet9dZhi5FEduxqCNmohu0Uxo5VF6EIA=;
	b=ToWXMKb8dTP7FvZj69BALMAszigAGqYqhUJ5BQZpmpPoXWNt/Rn9ZSLmAoK3WA8pRZMoQI
	YbWUSq8RLQ4szum8c72gdtWPzwy0rWn2nn0CehtE5+U2bOdYf0PSLurrAInkl0dPBtnTZ3
	FcMCkW69HwaBcpnaEadxxpsc8tIr0ao=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-NbkTPOKyNg2Dfqc9Q06MpA-1; Thu, 20 Jun 2024 03:43:32 -0400
X-MC-Unique: NbkTPOKyNg2Dfqc9Q06MpA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a6ef7afd90aso24707066b.2
        for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 00:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718869411; x=1719474211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IllHNP6pe8oet9dZhi5FEduxqCNmohu0Uxo5VF6EIA=;
        b=NmWCRfBCK0mFlG9zw6Ix7jtMhYunjQ9ccdLbqZRlton8SksflyEMkSaMpZ98e88SnA
         7Oq8W7GMOt/lI9GGiSxWCApQZzzYvj6Zd9p+mZw08a1HHsrWnuICM/+tF3sY1EM5hRmB
         b9SgwjahzIQRMMmLdtP2zJGJkONXrUA3ZrIluZ8P2bjrKqn1IimV99zi7VJttsa+VjPE
         6YtdoTjb/NxbLD1ejZOpVJEKdsYPmplUhR/fSabDnvVnIwkZbKhye2vsbvj4yXDGZ4ZZ
         DW7/RPekO4AQZa6HlCfw0XTkqnNosjRPepJFFW7LqAipXQfASGk8AIoqTc+Cbx/M6Nah
         VPsA==
X-Forwarded-Encrypted: i=1; AJvYcCWV0wXPHXJEHRxmyFjp2K6iiHehJTfPIQswLOBN17vsbUx0awNpT3ZDCOl88bYXQ77/CRrZFjbRXQhdZUkfaMvA/CFpBQATYUmCemSLFVU=
X-Gm-Message-State: AOJu0YxbM4vbFDF3g/uhkvM1oMMH2ja5fvpJ/0bgQoZ54eOODSZ3jxmb
	3P6mjxYNzm+/W6/XA0lrSiNUevzb0pgZCOIgFA0x8l6YP2JHhC12m98IVuqMUFi/f3Hg++HipWA
	u5LLNnDKuQD+tXQOy/04n3bFREfnxqPqGHs8yZLC/Ru8EHQ+7BqnvNcDb/tIestBm
X-Received: by 2002:a17:907:9848:b0:a6f:5a9d:37f9 with SMTP id a640c23a62f3a-a6fab77a6edmr237228066b.48.1718869411505;
        Thu, 20 Jun 2024 00:43:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeWTQ5qAdQ8c3nreJgA53fKPCnNOZO16YgYwi+9R7guaHTC2Qu3SHuZ9LaFmUL07kEgmfYYw==
X-Received: by 2002:a17:907:9848:b0:a6f:5a9d:37f9 with SMTP id a640c23a62f3a-a6fab77a6edmr237224366b.48.1718869410179;
        Thu, 20 Jun 2024 00:43:30 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f42badsm737008666b.184.2024.06.20.00.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 00:43:29 -0700 (PDT)
Date: Thu, 20 Jun 2024 03:43:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, dave.taht@gmail.com,
	kerneljasonxing@gmail.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH net-next v3] virtio_net: add support for Byte Queue Limits
Message-ID: <20240620034251-mutt-send-email-mst@kernel.org>
References: <20240618144456.1688998-1-jiri@resnulli.us>
 <20240618140326-mutt-send-email-mst@kernel.org>
 <ZnJwbKmy923yye0t@nanopsycho.orion>
 <20240619014938-mutt-send-email-mst@kernel.org>
 <ZnKRVS6fDNIwQDEM@nanopsycho.orion>
 <20240619041846-mutt-send-email-mst@kernel.org>
 <ZnKuafjQt-Y-VokM@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZnKuafjQt-Y-VokM@nanopsycho.orion>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 19, 2024 at 12:09:45PM +0200, Jiri Pirko wrote:
> Wed, Jun 19, 2024 at 10:23:25AM CEST, mst@redhat.com wrote:
> >On Wed, Jun 19, 2024 at 10:05:41AM +0200, Jiri Pirko wrote:
> >> >Oh. Right of course. Worth a comment maybe? Just to make sure
> >> >we remember not to call __free_old_xmit twice in a row
> >> >without reinitializing stats.
> >> >Or move the initialization into __free_old_xmit to make it
> >> >self-contained ..
> >> 
> >> Well, the initialization happens in the caller by {0}, Wouldn't
> >> memset in __free_old_xmit() add an extra overhead? IDK.
> >
> >
> >Well if I did the below the binary is a bit smaller.
> >
> >If you have to respin you can include it.
> >If not I can submit separately.
> 
> Please send it reparately. It's should be a separate patch.
> 
> Thanks!
> 
> >
> >----
> >
> >
> >virtio-net: cleanup __free_old_xmit
> >
> >Two call sites of __free_old_xmit zero-initialize stats,
> >doing it inside __free_old_xmit seems to make compiler's
> >job a bit easier:
> >
> >$ size /tmp/orig/virtio_net.o 
> >   text    data     bss     dec     hex filename
> >  65857    3892     100   69849   110d9 /tmp/orig/virtio_net.o
> >$ size /tmp/new/virtio_net.o 
> >   text    data     bss     dec     hex filename
> >  65760    3892     100   69752   11078 /tmp/new/virtio_net.o
> >
> >Couldn't measure any performance impact, unsurprizingly.
> >
> >Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> >---
> >
> >diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >index 283b34d50296..c2ce8de340f7 100644
> >--- a/drivers/net/virtio_net.c
> >+++ b/drivers/net/virtio_net.c
> >@@ -383,6 +383,8 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
> > 	unsigned int len;
> > 	void *ptr;
> > 
> >+	stats->bytes = stats->packets = 0;
> 
> Memset perhaps?

Generates the same code and I find it less readable -
virtio generally opts for explicit initialization.

> >+
> > 	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
> > 		++stats->packets;
> > 
> >@@ -828,7 +830,7 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
> > 
> > static void free_old_xmit(struct send_queue *sq, bool in_napi)
> > {
> >-	struct virtnet_sq_free_stats stats = {0};
> >+	struct virtnet_sq_free_stats stats;
> > 
> > 	__free_old_xmit(sq, in_napi, &stats);
> > 
> >@@ -979,7 +981,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
> > 			    int n, struct xdp_frame **frames, u32 flags)
> > {
> > 	struct virtnet_info *vi = netdev_priv(dev);
> >-	struct virtnet_sq_free_stats stats = {0};
> >+	struct virtnet_sq_free_stats stats;
> > 	struct receive_queue *rq = vi->rq;
> > 	struct bpf_prog *xdp_prog;
> > 	struct send_queue *sq;
> >

