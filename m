Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69531430BB2
	for <virtualization@lists.linux.dev>; Mon,  2 Mar 2026 15:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772466742; cv=none; b=toQbKJ1zxX84i9Lm/EtdLhBTBk4YUfG2dYX2mij9L2y8Cmq/fOvoibE60XhJBiCcf43Fcin2SG5C3u92P/oVPijfydka2nVNw1NxJepbvZ7Y2DQFndU0m9R54M+vqgGvQ7XTCu1P06cU1cMP8tpJQIEjrB3/adtYR/MggK/8tXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772466742; c=relaxed/simple;
	bh=hpnlOqrcE6XKQCbvfZC/Jw2+6G9P7VjT8fcJZ6bj9hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SywYqKa9VqN0qVfSicVNpparDSrIkqttMiGSmAUyNlLegt47HwLl7SHoNle7cBznB82HJK1PT2IYKnUfRKoauBUXb+puboE2yd/vmV1wcHZqrP5n8d7iUFee0HaL//yT1kwBGauD7llA2GcKCyX9UwfoA6X8VihtrgXdOHjoI/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WQb+rTsN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQb+rTsN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772466739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CH9mL5pbMrwDtlONtIMgJdUZf3F53m9y7sOyrOwP3i8=;
	b=WQb+rTsNIkM0kdKzWL51AjDhHiqlgTw6kMhf4scEGvDoR9Lczz1dnvqlHZHYE/vl/GOwrw
	njEuXH4hT6QApaZJjzLiuaV+xa9D/f2owtK5dOE4a0WEY/oxM/bdni7fACrSkrcHaEU2tc
	UEEwtqfkTUtUvpLXpiXbrUC5QVoc5AQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-2MRANZhVN_ONOtuVqmSMTg-1; Mon, 02 Mar 2026 10:52:18 -0500
X-MC-Unique: 2MRANZhVN_ONOtuVqmSMTg-1
X-Mimecast-MFC-AGG-ID: 2MRANZhVN_ONOtuVqmSMTg_1772466737
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4806b12ad3fso38537415e9.0
        for <virtualization@lists.linux.dev>; Mon, 02 Mar 2026 07:52:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772466737; x=1773071537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CH9mL5pbMrwDtlONtIMgJdUZf3F53m9y7sOyrOwP3i8=;
        b=ULfIsQejS5/YDxIlLL3GSofs4QlQdjBHtnBbHeuV56EnvQk7tzbs9hHF5BLw4ZWkhi
         +dvURdWLpcFMk2vbnCAogBnLI2Jz1ibua0+4P6wUtrulOp/GS8HFIcXJPXqMaL7fVcx0
         wHkelENyqf4AXxwfKZopCfiw4G6hq3+9wCwUDdeQWI7ws6s23MK7vs9pIlcuWAixlkWr
         HZ2N4YIZb7EWt1oEVGYmJsTAdpNhKt21K2kzkQCn6RsitmWk/QUHkDtBLcqwBfc7AeUk
         5pPkt8++gfcNMTOxI1NiN9HNTbU0kgE5H204XMG4X8lIG0Fd0UcU94Z17Bwk/trzhLgw
         4zVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHILyiPA3I+jfRG7ePYaWyFV0SBtruZhPUSLhQlETH46mfH7gX7xstS17II4/LuPiG0+yoDbufWW2jMP5Adg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxc0X7DXIrFxieTAoDwkbhVWGgJUcza64Syt95gFF85TW/7vmQC
	Cg9YE6SbdWEIl618Qt2GYFVzoAJmeIPOR6dg5RM90S/WVbmti3VpxVmA6aIqEnTBKovg1RAf5WJ
	0PW+Cm3m2ST5AU3LjIwhGrRqxkrusYHdkEf0MlrtUEN8VcjLAlabWTwYSXGJhQomjlKcw
X-Gm-Gg: ATEYQzy3Vas7QNoB9ArAHOE5xaHbBVFAUanRkLFRgAv0une1CfSonBXZNT6EdCmvUpg
	VI5eXqCXQLjjkgj/O09w8wpqAli2+/Oi058Hw4AwfBPRYcx/0qWGCcLOMgYsPU8GmkEEUdyXnEZ
	IeAzIfYbSO1ldURZY5mK2iIsvUzFKpCKBmZ8GrDaYJbnTJ+oOPbKpE5P4QDFkz8ujltpwZvlQNz
	rjoH3xqhuPBoDKHPo9p5vTatGatyqbg1hxyyoLW98srFSAzfOcvddvHEUJ9gBH/k0Ni4dv7KRC/
	R7y9Hd7z+qlxQeSHrWptxh4FQEpN1P8QMT4mwYoqMm348Q+bmGCyOnFzVzD9JrgXsRI9QKH2b0Z
	UK4y1SJjs56bncMg=
X-Received: by 2002:a05:600c:64c7:b0:477:9cdb:e337 with SMTP id 5b1f17b1804b1-483c9bc55a1mr224120385e9.7.1772466736849;
        Mon, 02 Mar 2026 07:52:16 -0800 (PST)
X-Received: by 2002:a05:600c:64c7:b0:477:9cdb:e337 with SMTP id 5b1f17b1804b1-483c9bc55a1mr224120045e9.7.1772466736375;
        Mon, 02 Mar 2026 07:52:16 -0800 (PST)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7030b9sm336188245e9.4.2026.03.02.07.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:52:15 -0800 (PST)
Date: Mon, 2 Mar 2026 16:52:13 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Harald Mommer <harald.mommer@oss.qualcomm.com>,
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org,
	virtualization@lists.linux.dev,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>, francesco@valla.it
Subject: Re: [PATCH v10] can: virtio: Add virtio CAN driver
Message-ID: <aaWyLWmqx0KCJvwI@fedora>
References: <aZRB7Reu/D6HvRcb@fedora>
 <20260302-mighty-wondrous-seagull-75085c-mkl@pengutronix.de>
 <20260302-condor-of-nonconcrete-infinity-d3ddbb-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260302-condor-of-nonconcrete-infinity-d3ddbb-mkl@pengutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: le6GNBtlJ6zGnWmGBHjZ-kl0OwhLYlUd1xFaxy4nbW0_1772466737
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 02, 2026 at 02:23:42PM +0100, Marc Kleine-Budde wrote:
> On 02.03.2026 11:30:34, Marc Kleine-Budde wrote:
> > > +static int virtio_can_open(struct net_device *ndev)
> > > +{
> > > +	virtio_can_start(ndev);
> > > +
> > > +	netif_start_queue(ndev);
> > > +
> > > +	return 0;
> > > +}
> >
> > Is open_candev() missing? The CAN framework requires drivers to call
> > open_candev() in their ndo_open handler. open_candev() validates that
> > bittiming has been configured (returns -EINVAL if bitrate is 0), checks
> > CAN FD data bitrate requirements, and manages carrier state. Without this
> > call, can the device be brought up without configuring bitrate? The driver
> > does call close_candev() in virtio_can_close(), showing awareness of the
> > CAN lifecycle. Every other CAN driver in the kernel calls open_candev() in
> > its open function.
> 
> This is true for physical CAN devices, so let's clarify things for
> virtio.
> 
> As far as I can see, there's no interface to get/set the bit timing/bit
> rate from the guest, right?
> 
AFAIU there is not such a interface.

> You can set bittiming.bitrate to CAN_BITRATE_UNKNOWN, remove the
> netif_carrier handling from virtio_can_start() and use open_candev().
> 
Will do. Thanks!

Matias

