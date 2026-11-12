Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794502645;
	b=ZxGXzWB1PyuzyLwoNANFFL6ZZcPP2yKRMr9PaOmPsUYO/zNQg3npyjmaaEXX/PgkXYwO
	 LFR3tLUFpKpP83tZIB8ma7Z6ctYGUillodiQ33zSvH3+3uaY9oBYaVbOABL9YM9nBDKHK
	 VH1OMTDIEUwCxTDnoHzww7JlSaNT/3lmiepNEvGKtr0qsLfxmQzLJrvRggPekXHNjK8LU
	 OwUYwUlv/+YhP2ttaFdSJP2df5Dgg375HlptxehCWCggivpOxaZ0at7lxL78ZOz6nzXSu
	 6vWWwJ/hqHXnio1kLiEG5ZuSgAEn2vxsSVSabHlLK6xBNe8MLyZX+PdrguyBind4/Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502645;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type;
	bh=darN4TpL7cuu3l7AdV450Bjk03MaXBNxXOy+eZ4zU7o=;
	b=rUR51+yoGHocKddhl7h1Qlc4bDonfEM/RxgWMP0ir7iN4t9cGcTWECAQbZH0HBO+xLU0
	 apq9skOrdxbaemPR7T0H+dXlN2iIN1kGI6hf+LDiTRzDIwNl/XzGd1tpxD7hvfzaoyr7B
	 3BR4Ng+Ov9unLNtZgtOnBjMFaCJmI0uKmdC8x4u5xKFLdV5JA1+E3z2030xX86A8l4gdd
	 5DmXcEAMMQ3Pglc2x4lzJsYKv1bnq9f0y+FbIKqMvnMTe8PPezvHgXdtXDNgkBbtgEMMy
	 W4kAiEkDghQXnPWYRhrmqYkZStcK+sZuDbGPsUs2+tVZUvAJgBryJSDi2m/XM+byM8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BaxtydLN;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D620B606A335
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 16:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D620B606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BaxtydLN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794502643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=darN4TpL7cuu3l7AdV450Bjk03MaXBNxXOy+eZ4zU7o=;
	b=BaxtydLNGH1fB0CY9wOYxoIIc86qUnBG65B8GTkOwG9cuaQ8zV0gziZa13SkN6+VwMlHbu
	i56snWJe4JjV5dUrqtX3cL5rtoziorLfacMBqJFaFlFgzDoidQY5i/pv+Vrmu3996nRgau
	i2JTy5b7HxdThZZLqPKkO7IT7dCR2zU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-EkcoTZ_cNs-p8MuE8vcf0w-1; Thu, 12 Nov 2026 11:57:17 -0500
X-MC-Unique: EkcoTZ_cNs-p8MuE8vcf0w-1
X-Mimecast-MFC-AGG-ID: EkcoTZ_cNs-p8MuE8vcf0w_1794502636
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91f184f3334so10856d6.3
        for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 08:57:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794502636; x=1795107436;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=darN4TpL7cuu3l7AdV450Bjk03MaXBNxXOy+eZ4zU7o=;
        b=SOydprJb3fDJCHvhMzmCB3qMT+kgclvysHyzj8cOx5n945OGKRA2/WlT/L766QK2xn
         mv3sb9dpHhN8WRk7UdIJ1sp5FW3P71GPDxs+sA+1/ZbpWeVDoGskja1o0g+SLtbot6y2
         CcUEDGPsLe0dKYXxbMS6Ip90E/Q2jsGnxGTcf+YUfikdKTXYe6ZiuKci+Z7ItObCqnB+
         zbcGCfgPIkNhgjJK1YxiQMd1VATDQO/PmnML7ygncLmOpARw5qiCDRyyR+QIslw4nWDe
         GOXCs82+TwMwSq0RkxyrCx1FDrqwWSCEYMAEnffp0aR9tUw+0Ho2A9U79cftowEX1YIl
         j6vg==
X-Forwarded-Encrypted: i=1; AL+hErH56Dr4+bQ0et0YgcYM0H0AHitOsH4WxoJJbxVNj5jYbd5G4dCBoQPKKDw6Z1xB+s0/p/oUeKm94Fv6EuonWA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/af0P1/LUATcNszrHYxxnObwpEMAteHMJ4l/yhIVB3K2COoJui
	5w5SwYPSVV/3kPnVrxV7yOMsurHgp0RTO9XIapotxRcP2uR3/K+zY/GWY+umda/RCvQntAijQ01
	F4XyVUSoCDpLI0bOtzhA3VoHK2qKYb3952SsA94AzdJxsTmQ0sDA0IM5PzGqSxuRLVDk1LU+6XW
	A5Vz7HPCwwnwYpnlG0lM7LYANOXyJVKsIJYU5OwPmYJkc=
X-Gm-Gg: AYBFou20R6iegtMuZ808oMl2+ptotge1S4/5kOtywkK9fYqWdcsGEydI6SlyAH095eq
	rmGJGihIHBsPF3h41q5/75k7nmStut8cI/yRPt+NfrKUvE5lIQ+tz7wELjJQvX4WXrW3tOvWjJX
	5Kfdkw/iAliGBbAD6M3Vv+saokTaw3UEdGOc6km+kHMMvGF9OfoPWBxFc=
X-Received: by 2002:a05:6214:4907:b0:917:af36:df30 with SMTP id 6a1803df08f44-91f04024a36mr108416376d6.16.1794502636073;
        Thu, 12 Nov 2026 08:57:16 -0800 (PST)
X-Received: by 2002:a05:6214:4907:b0:917:af36:df30 with SMTP id
 6a1803df08f44-91f04024a36mr108415966d6.16.1794502635425; Thu, 12 Nov 2026
 08:57:15 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Nov 2026 10:57:14 -0600
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <aukO0YEZmiMIISaP@devvm29614.prn0.facebook.com>
References: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
 <20261028-vsock-dgram-support-v1-7-e457cf7cee78@sinrega.org> <aukO0YEZmiMIISaP@devvm29614.prn0.facebook.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Date: Thu, 12 Nov 2026 10:57:14 -0600
X-Gm-Features: AclHuK97Vbt87h1PiWp1yuLFdgsXXBfxSod9rL7qWx7O4MzdkcMf0Vg2mTyClE4
Message-ID: <CAAiTLFV5g4XV7ZU+TYFboAi3n535murgSjh4SBw_PMnp=oQyww@mail.gmail.com>
Subject: Re: [PATCH RFC 7/8] vsock: preserve host-to-guest datagram boundaries
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	bpf@vger.kernel.org, linux-hyperv@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H2IZY0Zuu3awiIv5yVKosHf6bE25XdH-7dVtAlKC3YU_1794502636
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

Bobby Eshleman <bobbyeshleman@meta.com> writes:

> On Wed, Oct 28, 2026 at 05:04:36PM +0100, Sergio Lopez wrote:
>> Vhost splits large datagrams across guest RX buffers, delivering each
>> fragment as a separate message. Allocate full-size RX buffers with
>> page fragments when datagrams are negotiated, and drop whole datagrams
>> if a guest buffer is too small. Refill empty RX queues even when only
>> one full-size buffer fits in the ring.
>
> I wonder if it might be better to do what seqpacket does, and just split
> the datagram across the buffers (for seqpacket, until the EOM flag is
> seen)? I'd expect that we will get better utilization of our vq buffers
> this way?
>

Yeah, I do like that approach better. I'm going to implement it for v2.

Thanks!
Sergio.

