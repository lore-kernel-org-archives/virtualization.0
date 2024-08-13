Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DF218E11
	for <virtualization@lists.linux.dev>; Tue, 13 Aug 2024 03:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723520641; cv=none; b=f7hXuL3dl+P7JC00GoubLHwqCFotG/geCSiqAw5WC6b+FIkgfB6Mt2E4YM+WnS/dxv6ASUNjpQBdbnn0sNH81UQuisvh4XJ87SCxL23832lX533Q7wnQr7j8rslGg/YbmFh1dcccAQDRLSm/4vitG0xiG31UnWTnEaRzjClqOkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723520641; c=relaxed/simple;
	bh=Su7MAzd9Yy/Zx73BwnjeRJHKXm/Dqxa7oKm3l/+o2+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PwOQo9mDv2/FD8Bc7ERnJDxKwkBcOy6rLjrMHmYGuy1FZRnYHWTj1XjsllwS+QansSN052aMFt2vU9jTzQkPlvvtxaMEu3D+GfBMXOvLcMBblRfk/WhqNpCnVhVxlvrfKbr+v32suSg8vCX7OsfwMq1Zg1/hAtVb4hZ4/yL6HZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WH0KMPrc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WH0KMPrc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723520638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Su7MAzd9Yy/Zx73BwnjeRJHKXm/Dqxa7oKm3l/+o2+k=;
	b=WH0KMPrccpouVT5y8WXWF5uSGxPoS+Pm74sh4C8pTWd1mfkvErFD9zAGcW/5cp0riYQ3PC
	QdQ9t6xZz+kCxSTQq/A6BpI+maWGfc577BdEHatL7Le2fbcXPmNwRzuvbGjg+hNNQWvxVV
	1vk3WjkZxToaTrr0Wk1HeIRHzqdJDAU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-7A0KDvVtNwevAFmvquwN3w-1; Mon, 12 Aug 2024 23:43:56 -0400
X-MC-Unique: 7A0KDvVtNwevAFmvquwN3w-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2cb5847ff53so6270627a91.2
        for <virtualization@lists.linux.dev>; Mon, 12 Aug 2024 20:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723520635; x=1724125435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Su7MAzd9Yy/Zx73BwnjeRJHKXm/Dqxa7oKm3l/+o2+k=;
        b=KVddCUvIXlXByOznrzZnuAvvxrMMSRbI/iv+fwAOcbQQ8Dh8TQBoQmck+OrH7OwdPI
         x6ug2ZsgnIqEigVNlwnqciZRua751+KNZ4+gnIUDsAikKA8RL0ATbRYAek8JbfqKnECu
         h4eUS0sjO2xA69ki1vfMDU/AxtPA4e7WucP9GOCROFL5vRZZB+xwZrvn6wRPdjweytku
         tBJKccISK8IlbXsYuaSLRLJORI/tcbYViiKqAioBjPEqQ8vEMZJeRlI43vr0q5gr16FP
         8Q6F5PeAOVTI+C3DqUyNbFGIxLwPMWyGsR653I5sth61Fcro7QE0i29YLfp+1FxrXpGV
         NldQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpP/56krx9I+LvPnrM1dBVb5z0O7uoDGvV/RFxlrZ8BbZSw69DcOiheqtuJS0GNPnYwpaMd9qKLwBNXxzF802HWqp7a+sXiao3UCuBo7c=
X-Gm-Message-State: AOJu0Yz2EiAyNXP5CzSP9H1PEgOiYeCex970vxAdtyILjLPbcyqwu7gm
	zR50azm8jLfu4CBNwAMd7y5szqvfuWdkz9FocJ0R9BfMlh2fepMFWtKj9t04FTzV9iKzD7oJO2A
	Wz7fwX+lp7pwLEBG8Q2NywSAEGzdS9l48R9brEnaY+sjjHJwI5mLDjMXwZjX0wNOvIO1NOqcwLS
	MQ/awazw5Iqf++dg4pCw6kgasBotSGvALqzQa+79xNPX5nlkTiKA==
X-Received: by 2002:a17:90b:89:b0:2c9:9c25:7581 with SMTP id 98e67ed59e1d1-2d39250f3c4mr2566944a91.16.1723520635523;
        Mon, 12 Aug 2024 20:43:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6MA9BP6pmDHbnjy1bE7jxyzt0JSd6+Jor/U4mIPatBQ31eFjzMETJs1p+NZwb9A9w16BoIT6DhGKyBeNG3Y0=
X-Received: by 2002:a17:90b:89:b0:2c9:9c25:7581 with SMTP id
 98e67ed59e1d1-2d39250f3c4mr2566923a91.16.1723520634973; Mon, 12 Aug 2024
 20:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240806022224.71779-1-jasowang@redhat.com> <20240807095118-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240807095118-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 13 Aug 2024 11:43:43 +0800
Message-ID: <CACGkMEvht5_yswTOGisfOhrjLTc4m4NEMA-=ws_wpmOiMjKoGw@mail.gmail.com>
Subject: Re: [PATCH net-next V6 0/4] virtio-net: synchronize op/admin state
To: davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, edumazet@google.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	inux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 9:51=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Tue, Aug 06, 2024 at 10:22:20AM +0800, Jason Wang wrote:
> > Hi All:
> >
> > This series tries to synchronize the operstate with the admin state
> > which allows the lower virtio-net to propagate the link status to the
> > upper devices like macvlan.
> >
> > This is done by toggling carrier during ndo_open/stop while doing
> > other necessary serialization about the carrier settings during probe.
> >
> > While at it, also fix a race between probe and ndo_set_features as we
> > didn't initalize the guest offload setting under rtnl lock.
>
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Hello netdev maintainers.

Could we get this series merged?

Thanks

