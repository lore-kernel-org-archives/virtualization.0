Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701A360DCF
	for <virtualization@lists.linux.dev>; Mon, 14 Oct 2024 04:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728881876; cv=none; b=bGrfEwVljeOx2oGI3nohxrPbqNwC65YKa1MZ2iXnAQYtSNBz0Kxx3EoCYPYmJNTOOyPsXxdy1vrb4ZgCKigF6f3PEu+I47BqFL1q/3FUkzEg7V49im5XhvB/WEcwvbHvFwRcki9LIrorCP86olG+BnDUocHG5/ym4fqD4E2+cXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728881876; c=relaxed/simple;
	bh=XTX+OYWTvegQz4+v0ZFkHfZzljt0DOpIst10jFFEJps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CnOXdZTmrntZa7pJFxPiNNNWo9nQx6aerQaTfQC3JUIeOmvDee9hiagNJeMQ00tx3ePSGd3WTASyWmQtFz4Qs3twnTPD3xG7gE+TixNXDM10ft3eOWY2Qs0x2Mzh8o80wMw+aJMdm0ZWaUJvdDLA93aVw+KfsEIkrGQNrMxL5/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mwy4ZBzd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mwy4ZBzd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728881873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NNfw05JeqCiaE0aPXcBAetAKovvsf7rX91wGjBumb7E=;
	b=Mwy4ZBzdnDAxVYaeEECsaKSbJ07cppr7uMlbCelA8FpZt9nLcXWEB44owtVjAaMJtqVhhc
	1jPj0Md+idUvoiB4IS0KbElDTEVqljutDz/9vw7nTh1hzMVcSLq8CSHHbqytetFh7F39J0
	1QrNXSpnEKrb3RqCtZ17P7xMxy+Dinc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-jRmwHmBvP0G0avaoC-MvBg-1; Mon, 14 Oct 2024 00:57:49 -0400
X-MC-Unique: jRmwHmBvP0G0avaoC-MvBg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9a194d672bso7522766b.2
        for <virtualization@lists.linux.dev>; Sun, 13 Oct 2024 21:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728881868; x=1729486668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNfw05JeqCiaE0aPXcBAetAKovvsf7rX91wGjBumb7E=;
        b=IbEp3nEKo1ClOqHhkLs2H1l0DOzn/mAKvo0a4JmhHta1Rnuc7lt9rbVVcDTFk5v+tQ
         Y/GXOzjVUfUOFuV1Flz54g0GibEooCazOn58vbspq/66GxOZ/Oj27j9EeDx1N9I/ibzN
         czgX4r4kBCiMINUQVLb41/sDWbo1ec6xa/pmJP5x1GAwCA+XYDjaLl+oPUM/ghFPPfo9
         42LSr4T6xUFwi0oeWUDV/i/CzslOm+IH9SGYaqFAOXo0m7A0NBgwDaQuUTrx2kQDh7mZ
         pHm4WPnZd0U2K2ssQqvBBWjNQRd3S1NSTA4J0g61e33xb/ybXO94v6UWuJYjOfHUHs5g
         2T+g==
X-Forwarded-Encrypted: i=1; AJvYcCWNdzg7vn6mkawR/yqF42I7c45u2kodQnWW3wHSmC7S78BcU67dnSfedx1wQyB0L07Lez/pLx2SMmCinvM7+w==@lists.linux.dev
X-Gm-Message-State: AOJu0YycZ5r6icFskTPdfaKZFLuz1aKKswyD88g7Tp5nhJY482/c1DbB
	PGZ8OyH2LU6egXHP+y9NybY2bJVx86KS0XEa3rdV18aQ4Xn05lfDKekN1uiMRLygQ6kYjc0R1AD
	sHVeQg0wDAU16xITZ0KkZHIGKmqVaz8DYOCnuSMf/i3IZIeFtG9llbisT855MZaXa
X-Received: by 2002:a50:cb88:0:b0:5c9:5a96:2863 with SMTP id 4fb4d7f45d1cf-5c95ac1582emr4347117a12.13.1728881868672;
        Sun, 13 Oct 2024 21:57:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg1zgGKPYY2qUjDast+zBLcsCYUTRpyjjjgmslaW62xyjr0N9eWzmfPPhE/J3MFikwUsQyCQ==
X-Received: by 2002:a50:cb88:0:b0:5c9:5a96:2863 with SMTP id 4fb4d7f45d1cf-5c95ac1582emr4347104a12.13.1728881868323;
        Sun, 13 Oct 2024 21:57:48 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:d16c:2d5b:a55d:7fda:5330])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c937267272sm4425344a12.75.2024.10.13.21.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 21:57:46 -0700 (PDT)
Date: Mon, 14 Oct 2024 00:57:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	Darren Kenny <darren.kenny@oracle.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH 0/5] virtio_net: enable premapped mode by default
Message-ID: <20241014005529-mutt-send-email-mst@kernel.org>
References: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 14, 2024 at 11:12:29AM +0800, Xuan Zhuo wrote:
> In the last linux version, we disabled this feature to fix the
> regress[1].
> 
> The patch set is try to fix the problem and re-enable it.
> 
> More info: http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com
> 
> Thanks.
> 
> [1]: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com

Darren, you previously reported crashes with a patch very similar to 1/5.
Can you please test this patchset and report whether they
are still observed?
If yes, any data on how to reproduce would be very benefitial for Xuan
Zhuo.


> Xuan Zhuo (5):
>   virtio-net: fix overflow inside virtnet_rq_alloc
>   virtio_net: introduce vi->mode
>   virtio_net: big mode skip the unmap check
>   virtio_net: enable premapped mode for merge and small by default
>   virtio_net: rx remove premapped failover code
> 
>  drivers/net/virtio_net.c | 168 ++++++++++++++++++++++++---------------
>  1 file changed, 105 insertions(+), 63 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f

