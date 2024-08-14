Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A55F166F38
	for <virtualization@lists.linux.dev>; Wed, 14 Aug 2024 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723628645; cv=none; b=kjucCkl1mSKOUPPhylHSqA6Tamw/8LjIWL2/HiSHePGZ7/cBDXU0TIWSjSfK9UXv0NaJQoddH8hQZoHgL/tJ+YK05sVddqnDep7KUysqDf2cw3QnOOXcs83d/1JLu2Azh+GvjZzXxaOA7XRkNJCiztunP+xPKVK7d3k7KeFWDwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723628645; c=relaxed/simple;
	bh=bDX0W0YcHfz6UrXy8uYh9/2NpWe0JqnGzLjCtVJFHL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Rar6LeLO7tL5YQNRaKFC2rXg8NCtbNbIViyuwYRNVt+9ihf2HzoxQ58Ckbarw0zArDjbupJnQMA0r7FnjadEQUpDNvofPGtcDu4aobxu/VTdP3NJgWfW7aWef33mGo5izg/Puu7JQ8+uQohQ1EegEAgVDG+T6dW7wJsX4safQU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M1dXrswN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1dXrswN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723628643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+elik60oxPmXl+HwPhEYp0jss+bQ52uuhXHHXAgMsXQ=;
	b=M1dXrswNrGaXvgI80EyC2dgKZamTNjjlE4mqgTaVX4A7lRgpE6Agxoi+oPhqBqxkBHz9YP
	GZ9fVlso3Y7R4YjOatw0nKDgNKSZdkGzN+xWQqn1g3rNsKN7Z5w0umrMU1dKR+iut71W+X
	IAJH4DKahz2HICodSzQR5nBlsSPVLzQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-8PdqJAm_McGe6wdW0H5dtg-1; Wed, 14 Aug 2024 05:43:59 -0400
X-MC-Unique: 8PdqJAm_McGe6wdW0H5dtg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a7bcaa94892so487461566b.0
        for <virtualization@lists.linux.dev>; Wed, 14 Aug 2024 02:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723628639; x=1724233439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+elik60oxPmXl+HwPhEYp0jss+bQ52uuhXHHXAgMsXQ=;
        b=EtToi9FPcC21aXqzpxPy5pH2x78tjfoZJ1CXVewjir2VKgfO+7v4TG4Kx65s0snS9r
         F/QHFELwk4jNtMv1eRzRbR53HWN1GHowos7ukepZdFWDBIcW6UmAgvvtFMjNYJa5gb6/
         KOrmw5rMD3cy/YeEdMlLmdabJ5JiGX0E507K35t5rywX0AaoOlfR7BRlHIg/OBXhFAVj
         hDcOKTysELBHLrjKh5MOTbNcJovgftMyH9zFK3RwVvFBSdg5Nx8lMl8D5o4EL9zC3w2p
         IZ5371zPZMfuuqdaMDUOZ+RIqF+zdfq6C25eE45E1MrDs1ZSm/1GFxHitZ5ZsC9cW2xG
         eZ1w==
X-Forwarded-Encrypted: i=1; AJvYcCVtjMNgBlpgHCHlxDun6pob40MsXsDoC0ZqPIC6g/45FxRSRL9ton496r7CLHyZBVv59PgluEASIXV/1nPb+jBi6B8mgIShWflilq3x8RM=
X-Gm-Message-State: AOJu0YzCjSK5kwal3/bYIawVcG4NYjiknh8bjMXsy4oArOy0dMYXl/wR
	ZtaOJBtRk+eJjdodWGSFPcQ+/3LYt8TzNnqcGRm1JQld3K6kiLQHZsYnwia+dA+jITF0gw1YBYw
	0y9BKeTRRgp5L6v7Jh9WUoTS0Z4ilhAN/L2NpT/vbKAFUR9/bKfbdsg9ZNRulJ20p
X-Received: by 2002:a17:907:7e95:b0:a77:db36:1ccf with SMTP id a640c23a62f3a-a83670913a4mr157848566b.42.1723628638688;
        Wed, 14 Aug 2024 02:43:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqgSyfSPfgnA5rfz+Si+DMzLKsMw6jiA0HIHLtzrsRJoI+UE3pbGrO6gcYuSOHr66pPBiDBA==
X-Received: by 2002:a17:907:7e95:b0:a77:db36:1ccf with SMTP id a640c23a62f3a-a83670913a4mr157844566b.42.1723628637900;
        Wed, 14 Aug 2024 02:43:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:dcde:9c09:aa95:551d:d374])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f418260esm150658566b.197.2024.08.14.02.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 02:43:57 -0700 (PDT)
Date: Wed, 14 Aug 2024 05:43:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	dave.taht@gmail.com, kerneljasonxing@gmail.com,
	hengqi@linux.alibaba.com
Subject: Re: [PATCH net-next v3] virtio_net: add support for Byte Queue Limits
Message-ID: <20240814053637-mutt-send-email-mst@kernel.org>
References: <20240618144456.1688998-1-jiri@resnulli.us>
 <CGME20240812145727eucas1p22360b410908e41aeafa7c9f09d52ca14@eucas1p2.samsung.com>
 <cabe5701-6e25-4a15-b711-924034044331@samsung.com>
 <Zro8l2aPwgmMLlbW@nanopsycho.orion>
 <e632e378-d019-4de7-8f13-07c572ab37a9@samsung.com>
 <Zrxhpa4fkVlMPf3Z@nanopsycho.orion>
 <ZrxoC_jCc00MzD-o@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZrxoC_jCc00MzD-o@nanopsycho.orion>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 14, 2024 at 10:17:15AM +0200, Jiri Pirko wrote:
> >diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >index 3f10c72743e9..c6af18948092 100644
> >--- a/drivers/net/virtio_net.c
> >+++ b/drivers/net/virtio_net.c
> >@@ -2867,8 +2867,8 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
> > 	if (err < 0)
> > 		goto err_xdp_reg_mem_model;
> > 
> >-	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
> > 	netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, qp_index));
> >+	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
> > 	virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index].napi);
> 
> Hmm, I have to look at this a bit more. I think this might be accidental
> fix. The thing is, napi can be triggered even if it is disabled:
> 
>        ->__local_bh_enable_ip()
>          -> net_rx_action()
>            -> __napi_poll()
> 
> Here __napi_poll() calls napi_is_scheduled() and calls virtnet_poll_tx()
> in case napi is scheduled. napi_is_scheduled() checks NAPI_STATE_SCHED
> bit in napi state.
> 
> However, this bit is set previously by netif_napi_add_weight().

It's actually set in napi_disable too, isn't it?

> 
> >
> > > ...
> >
> >Best regards
> >-- 
> >Marek Szyprowski, PhD
> >Samsung R&D Institute Poland
> >
> 
> 
> > 
> > 	return 0;
> >
> >
> >Will submit the patch in a jiff. Thanks!
> >
> >
> >
> >>
> >>Best regards
> >>-- 
> >>Marek Szyprowski, PhD
> >>Samsung R&D Institute Poland
> >>

