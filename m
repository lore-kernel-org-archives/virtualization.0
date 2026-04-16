Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE9E8460
	for <virtualization@lists.linux.dev>; Thu, 16 Apr 2026 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776336724; cv=none; b=kIuICjKQJD+SxrZgnErOHmBpIl+7H/OTydU/BDmNNy/SMdD8Cgr0G/Tzc5oKJ+MMLpJAJNAXMmHnG+b5fqt5XXNzWK7N9Mi7A3SFBhE5l3VQm9/Ate/iKZxJs0buXLnSfLQZ/YuRe/aulXvR3p9V6KSFg0beBASah/CI7VAYvRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776336724; c=relaxed/simple;
	bh=EixB+VBYELB9QZou2WcR2YRGdtQyBm7qn3tnBBWJdDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MCxMTIgmzJrw70d/vK3MJzDmfirADohGTllAbD437CuXbjEJ0xQkyMXPXybdiFnhkKExsjPm7ZReYwf1g8kDSJtD5L7U8jIY9CQPMZ4Q5IWaxgA21fTDmYNAoM4Nx+F+knBhbDerXfVH3bYLBkSSNUX+aOoc7ZV6qmlKXpst4ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FNQ5dx8c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FNQ5dx8c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776336722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RWWOQAJEN/95l4X8m42iXJycRGuqxRmfK0Cq2b139G8=;
	b=FNQ5dx8c6ErdBngsENolYzOejj3f9uG9sKgk3zt7bIulZQY1JSqBSIMxpahmBU2QlCQAkh
	jQ6BlwsuA0GJCZ+cW7KXw420e/C97XJ60Nne9wdIH3d7ibJhP4gy0OSDrECpc/UEJI3+sn
	ff/PVMftux6wq9WTk9lqpkApUhOwGgk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-Vw7YMMSwORCwHhMjwYruuA-1; Thu, 16 Apr 2026 06:52:00 -0400
X-MC-Unique: Vw7YMMSwORCwHhMjwYruuA-1
X-Mimecast-MFC-AGG-ID: Vw7YMMSwORCwHhMjwYruuA_1776336720
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d03db814eso8304573f8f.2
        for <virtualization@lists.linux.dev>; Thu, 16 Apr 2026 03:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776336719; x=1776941519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RWWOQAJEN/95l4X8m42iXJycRGuqxRmfK0Cq2b139G8=;
        b=OdBz4oZmSLhZw7aviicINAJrk7MWBNEN6p27sApxscYND4hvgW80OAliAOmzjHTBxu
         pcAZp28rAP+iwLfblQpIN/7s7jowjONAsg0lgm4mA5lbjyChV77n0oDJb+AlrI8OK1ig
         rusfSXN5DV/EwHOorGPPAP7Mowcp7LtKMA4//ebh94kwRw/M310/mQUK8u5+v2FLG7zZ
         Dgv7GufQA0dJDf6Xal0fxaZruBJyx2kg/0lNrqCzYTa2UocxbetbGFjixQf534D6aixD
         gwKMeAQOreWRN9PcN56JsyP4OZ/wc6XqDmeQWAjVdgyhBmpL4QzWo1ZwXg3VpJbnQKJ0
         +Nwg==
X-Forwarded-Encrypted: i=1; AFNElJ/J3WcOFdGR3dZP5lhaDVaWZyQQaBJE6j96olzvtF8dRuMzLDhJhYyYJzmNz1hMnlqugF3zjvZcxCoztGpyhg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/Mp/AuOi2agxY7XYIFIggdCneyTC1KFh2AMQOpSj/RsfwlDLQ
	HNJ2xp0uPtPqPp1KygesEciuooOBDiVzNeoNIKl+fMDTdMmSiRHhqFhGDCw+ZboXdvNxPJSwUMA
	GZs0pNFGVGCukq4BZrifRPimhq95TGA8zuWkjNLGs9odGnTBWV3+hbg552ZGH49HDkOia
X-Gm-Gg: AeBDieuYd/KKEiYyNWLN1THHA+tK0XhTZpwPMGkX5nj37vIp2zR0mdEtjlO9a/njrFX
	AyoEEoOccFAV6jCFlKgTLDAmt6U47g7XzTHU76er/okU7MsIV9z1XS1J5icsnekMSfOqEfF0RAq
	n4XfWnY9ND1LGGDRJ4I0BGX375IlYDP/x5cF5EUCI3ii5q0ZUUbAyDh5hzK0unRD+qfcR0eLi3X
	OEcN1LamB97bLiiKZuOmELAm80fVw0MNkR7QOVnYkm3CTijN8c1U5eZ513MnDi5rYGhL2HXXqOf
	LmdDhAYU66weHVpiFH0ABLGEC2S1LSkolGRzHqez6l4ma2Zv+4cGFiDFuyLnE2RybkL+zrOJHQO
	ymD56apDvHXvpqBqS1wqK9eFCO3wc8Cr05nwARCSZbAI=
X-Received: by 2002:a05:600c:c08b:b0:488:bc6a:528d with SMTP id 5b1f17b1804b1-488d68867a0mr252350595e9.22.1776336719544;
        Thu, 16 Apr 2026 03:51:59 -0700 (PDT)
X-Received: by 2002:a05:600c:c08b:b0:488:bc6a:528d with SMTP id 5b1f17b1804b1-488d68867a0mr252350285e9.22.1776336718976;
        Thu, 16 Apr 2026 03:51:58 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5818d70sm73936565e9.4.2026.04.16.03.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 03:51:58 -0700 (PDT)
Date: Thu, 16 Apr 2026 06:51:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Jason Wang <jasowang@redhat.com>, willemdebruijn.kernel@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v8 4/4] tun/tap & vhost-net: avoid ptr_ring
 tail-drop when a qdisc is present
Message-ID: <20260416065132-mutt-send-email-mst@kernel.org>
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de>
 <20260312130639.138988-5-simon.schippers@tu-dortmund.de>
 <CACGkMEtN9XgYPGHQg4TEWEsa_UcMbcnzO=VaTFT=0Tn4BayMDw@mail.gmail.com>
 <0908392d-6314-4141-b908-6c9a880ba0a4@tu-dortmund.de>
 <cda710f8-033a-4772-b5ce-a2cfddf42bea@tu-dortmund.de>
 <CACGkMEuLqxnz=GtdKp3-u0egkGT_eZUgBBwvvtHcgAYpLJv-UA@mail.gmail.com>
 <3d3274b4-f274-4cf9-9d0f-989d05148604@tu-dortmund.de>
 <CACGkMEsUag4zNZG+aYipHv_PirbKb_rs7DzSOr-NF8ckhUaJOQ@mail.gmail.com>
 <b9d84d88-46d5-4fd3-a5b2-d914f54766f6@tu-dortmund.de>
 <73033bfc-4da3-4057-9480-bd977a66ecef@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <73033bfc-4da3-4057-9480-bd977a66ecef@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Nj0PsAa4XKWTzRfy5XnNydUw78x-3jxURxduvB6qrqw_1776336720
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 16, 2026 at 10:54:45AM +0200, Simon Schippers wrote:
> To summarize the discussion from my POV:
> 
> Open point: __ptr_ring_zero_tail() is only called after
>             consuming ring.batch elements.
> 1) Consumer wakes up the producer but the slot is not cleaned.
> --> I disagree, the consumer only wakes after consuming ring.size/2.
>     Then __ptr_ring_zero_tail() was called at least once.
> 2) Producer is woken up but see the ring is full, so it need to
>    drop the packet.
> --> I disagree, because then NETDEV_TX_BUSY is returned. This is
>     noticeable as qdisc requeue and only happens very rarely.
> 
> Points I will address:
> - Minor nit on patch 2 by MST.
> - Rebase patch 3 because of commit d748047
>   ("ptr_ring: disable KCSAN warnings").
> - Document the pair of the smp_mb__after_atomic() in tun_net_xmit
>   with tun_ring_consume().
> - Use 1 ptr_ring spinlock instead of 2 (currently used for consume
>   and empty check), not sure how to implement it pretty rn.
> - Run pktgen benchmarks with pg_set SHARED.

Thanks! The plan makes sense to me.

-- 
MST

