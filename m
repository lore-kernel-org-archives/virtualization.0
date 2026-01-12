Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B8F3563F9
	for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 11:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768216776; cv=none; b=jFuaS56JIr6oRqSly34s+7FXYyME6+BMedIfwydpHp2VRfcN3Mr/2XwPTI2PYVaILqoDVDj12rafM3PUXIcW14IyUSgWnxrwQz++BmnbwRvyspgYNdDTVfeha/aqaK4NUd9D/npp0vphy0sd/zQS058XtFu3NE2utIxYZxewjDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768216776; c=relaxed/simple;
	bh=dEODH6OKSSM3wWFAUIvzs3xEPFKgpqUcd7jKkQTVgAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NFugDntbzmFHaXo9N68kj+OQN5eDyzlrZVo2ScR8xadn9E2a/PNAkjufHaq4g9NyEgrXR3MNdhVTtVcG/eG2rDbjW3ncaMN3HCLLRfv49eZvA3LvN6kpKE4bD5PoqRxoBaLeqLSd3j6jS+9zALVF3SnrZhiNgWs0gj/HfDyU6bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZxIvZDpo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZxIvZDpo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768216773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uPyEp35yrxB/6+/GJhhyFrjf6xeA9T1VOzgBIjcqhzY=;
	b=ZxIvZDpocKd5rIweo3DUjH9WnKIXK486vs1zl7me8xO0/k0f3Dx0xIXSYdCJDY8ooDcvRS
	nehHAH9Oq3X7r6CeNF/KEwaVC0XeRshzbUOveelPeIf6N3avqbNA59CNh9AC5TqPtrARLa
	I1KE13ZvJx5AYF0xz7XyxdkuLxxGgxY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-3AwTbI_kNMa39fVQvu2NVQ-1; Mon, 12 Jan 2026 06:19:30 -0500
X-MC-Unique: 3AwTbI_kNMa39fVQvu2NVQ-1
X-Mimecast-MFC-AGG-ID: 3AwTbI_kNMa39fVQvu2NVQ_1768216769
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4779edba8f3so49591305e9.3
        for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 03:19:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768216769; x=1768821569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPyEp35yrxB/6+/GJhhyFrjf6xeA9T1VOzgBIjcqhzY=;
        b=VpPO5+LTEa8x52i14+RwXEZ5BZob5dIrkmDJkYVff45gpPfLTuJ4igua5vje6xnkwh
         BJzUz69TI3ksejJbHwyWWRR32OlZw4c6sPdlD5dgkXoNfdl1bxWMx9fyMkDUS7tKPXZ3
         mAQD3rNa8uYtdahQ7pt4b1kfNgaQMkfx+CWrla95iicESt6HKT1JwETqbkCZL3lnKIyA
         nDswXOeer5JL5cC9C3t/e9QLr15F3dc4Jzcfipc/lWQoifKv0kDKfbu2l7r3LOSy9Gm3
         DwMAZfByA+ZODNY9vvm02UgZevYSdcqV5rGqiEjY/QryefUrU1FRDyYgvzWeyKI3dUzR
         xnHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0lMBK5Z73psJxN1BkoInF+a0epSlEyYi9ccRrXyH5LqiUpf6G6BZLFeVJ2yDI/xvrcUW9ubhBuCnJVW7jaQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx71g86ApXYBnNZyDdl1zWAGmNT4J2yMDYj5mdxKAaDu75eHPj2
	CDGUPcVTXzXsdLPb7pXE+xGlovIfsKR2v9rlxr0Wt4RKF+qXi42qNbenRYUGGhGgXzHOxEdyMes
	0NH2PPU9O3YXBLZJQf/eljL6GZahJz+Z2MQ2KqDmowGiDEK7M/5duQbw3uveluykEehlh
X-Gm-Gg: AY/fxX7Wl7hDbdXidfJAkQrrziqcivkDxqHN1ga/iYY0U29DmXc8oJLJx8S52Z1aqTF
	O/yacs5rZri5d6iUVL4yuS2nss/TGftEgoGA6xk2X6VMEnU9txSIlu/QfrANKnc0bFj9hcDYX/8
	wJ+XOQUgldkvfaJrBlDxiFuO8b0EzG/2b4XME6+NSpgM6tMqRuaEDUmdBed11if5onRKKxIC350
	HYemKy4VQbMetkXPVb8PtCCbjHiJWbrMUJlZTSEKLxpJ6w8x6+6fLzdzhQd7AAz1pz6QYPgNmy6
	EF01hnrYEi++WIuD8sxu8oH2sIGB3avDc8QkzFjRCPuR0uke6+umeA9UKv2gWiKVi7LK1Vz8zvj
	FIn0BF+TGBGU2NnThPzVKnEBAvj1hLpY=
X-Received: by 2002:a05:600c:3146:b0:477:b642:9dc9 with SMTP id 5b1f17b1804b1-47d84b3b513mr189681985e9.28.1768216769323;
        Mon, 12 Jan 2026 03:19:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkXiyM0dc1PZUdH5UxPIiTHeham2VtB7pwju2vrblwSj2QD/OERovKHTVGzk8mENQ3pAgOlw==
X-Received: by 2002:a05:600c:3146:b0:477:b642:9dc9 with SMTP id 5b1f17b1804b1-47d84b3b513mr189681475e9.28.1768216768829;
        Mon, 12 Jan 2026 03:19:28 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f653cd6sm367623105e9.9.2026.01.12.03.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 03:19:28 -0800 (PST)
Date: Mon, 12 Jan 2026 06:19:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Jason Wang <jasowang@redhat.com>, willemdebruijn.kernel@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v7 9/9] tun/tap & vhost-net: avoid ptr_ring
 tail-drop when qdisc is present
Message-ID: <20260112061831-mutt-send-email-mst@kernel.org>
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de>
 <20260107210448.37851-10-simon.schippers@tu-dortmund.de>
 <CACGkMEuQikCsHn9cdhVxxHbjKAyW288SPNxAyXQ7FWNxd7Qenw@mail.gmail.com>
 <bd41afae-cf1e-46ab-8948-4c7fa280b20f@tu-dortmund.de>
 <CACGkMEs8VHGjiLqn=-Gt5=WPMzqAXNM2GcK73dLarP9CQw3+rw@mail.gmail.com>
 <900c364b-f5ca-4458-a711-bf3e0433b537@tu-dortmund.de>
 <20260111233129-mutt-send-email-mst@kernel.org>
 <55bcb1ec-bdbb-44aa-8fa0-470916e986aa@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <55bcb1ec-bdbb-44aa-8fa0-470916e986aa@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JuZLasmhnlurlWBUyWxLiV6GtQSMhyTXYI1p53PCRyg_1768216769
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 12, 2026 at 12:17:12PM +0100, Simon Schippers wrote:
> On 1/12/26 05:33, Michael S. Tsirkin wrote:
> > On Fri, Jan 09, 2026 at 11:14:54AM +0100, Simon Schippers wrote:
> >> Am I not allowed to stop the queue and then return NETDEV_TX_BUSY?
> > 
> > We jump through a lot of hoops in virtio_net to avoid using
> > NETDEV_TX_BUSY because that bypasses all the net/ cleverness.
> > Given your patches aim to improve precisely ring full,
> > I would say stopping proactively before NETDEV_TX_BUSY
> > should be a priority.
> > 
> 
> I already proactively stop here with the approach you proposed in
> the v6.
> Or am I missing something (apart from the xdp path)?

Yes, I am just answering the general question you posed.

> 
> And yes I also dislike returning NETDEV_TX_BUSY but I do not see how
> this can be prevented with lltx enabled.

Preventing NETDEV_TX_BUSY 100% of the time is not required. It's there
to handle races.

-- 
MST

