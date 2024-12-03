Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F7C22611
	for <virtualization@lists.linux.dev>; Tue,  3 Dec 2024 02:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733192731; cv=none; b=UNR0oMPGV3ozpwnPXgxwReWG9RttjZL143deHmAPLjxkiUs1DJ/5rVQkHfhAmVHJVcfClP5mMvUROokn2V36oQE68P6ylssq1AV9B6Fvy0jiTftMAT709pHWARNNSMpHY/yPyf9muXQvCkdne8QYpDkDjZyE8Q+KdPOJUKQxhgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733192731; c=relaxed/simple;
	bh=d6q8bGpZsfPskVwkj6L7Lml5GYk/xxetw+D0hD9cEJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UB5yiFwG/VthNCOSxIQpcX5k0Sqck1yV2KS37jV8rsitKwg067VQO+tHqpZ0qDvnJVyzxGtJIrRWjuURBJ/NKKchgw6dFqPbdtXwanuu7pYJBUD6AlqGlPu83cYGEfeMa+tqopBNKF1OVhOawZwGq9j4LPH0DyZYjt19TubQuTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b4EAqaIS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4EAqaIS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733192728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d6q8bGpZsfPskVwkj6L7Lml5GYk/xxetw+D0hD9cEJM=;
	b=b4EAqaISwa+mJLCpjirIdOJEDEr99H45OfozaT2BnlqphUszY1aQH9E/8RbSHufGQNaM2i
	FikslVW2l2Jq4psub1JJzeJSHlE8jDI5H47GUqR2JiNSPecWDaVKxyXumrD/mHCP0Auqef
	ES8PlEtOPo9keg81GyodeKLacych1u0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-zJdGKizNPoWBWzwFH1zT7w-1; Mon, 02 Dec 2024 21:25:27 -0500
X-MC-Unique: zJdGKizNPoWBWzwFH1zT7w-1
X-Mimecast-MFC-AGG-ID: zJdGKizNPoWBWzwFH1zT7w
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2eec0bad68dso1798588a91.2
        for <virtualization@lists.linux.dev>; Mon, 02 Dec 2024 18:25:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733192726; x=1733797526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6q8bGpZsfPskVwkj6L7Lml5GYk/xxetw+D0hD9cEJM=;
        b=uhfN8jmSbe5Niy0kL+KmFKsdaHfT/ax3zziHgfuE9+DMUsLiiKw2Wrkim0I8RgPjrj
         weKWaViCIzfuFYFthOM6EBHXyUwhwhTAZ9Qli9qGqVt6zekVg1IU4R/AE119cNGHw/6K
         AAr7hNEcfNUQqC7uOz49MBK9YzA+oHQcSvJjo2K4aeUm4SQBmpbDl9o7CxNp6by0uhKZ
         bU5E7OGIb4hAD8DHQ9+p1i3r8c1V3KgkwpZbWgso6ZoPoqo+rkZ31ewi7ptOG/0ErGRu
         VyfXdHCyJc23pdrktVLZwydjDWR0GcqvojABCujndpg9HflU/iw1Mco/FyFmyM8ma1vk
         qgEA==
X-Forwarded-Encrypted: i=1; AJvYcCUQx+vK4yibC8r9bdztEkwbu5kAU7Limpjpn6wPTJyVFFx/3ONE6gQ2ZfxyeLqFthNM3b1AQ3nULOcsXmXk5A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMqsNlLL1fpb3GGUpmvilOesTxdlVL5iJUd709J3sFG2ttkOGr
	dw25XPFUjVninAp5wcgRFAGUYwPRdh2004ApeScigJDoIrv+JsedSdxgLB9tqegrEHrtVCo1zmB
	zkR6uyV13oWRa2IsZhrfblU/e3g2F0ZB2dxwPGS3oXQaBR3BgqxJVEbr88p6a4d+Frta7BqZHI8
	Eg1q/4QoHEyIMZFS/LsZTG0UHytLFEyDfEBkPIvBA=
X-Gm-Gg: ASbGncvVtjSDjT83THHUMHPxmpK4MASErwLHNeIvTUsa5Biu7FFUj1D+QAPV8VAKb2J
	k3bcurqIiPubgRf1aYOE8QGZeE+PIg8Z9
X-Received: by 2002:a17:90b:3ecb:b0:2ee:b8ac:73b4 with SMTP id 98e67ed59e1d1-2ef01276888mr1136824a91.36.1733192726108;
        Mon, 02 Dec 2024 18:25:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHH5qQnZ0DiMbRpH7Ik71jXULxUEUKJNASFzFHC0GxhUTgu42/8cZ6SwHvLSqsP/acaKB2ErIzMfAseQ2enXwc=
X-Received: by 2002:a17:90b:3ecb:b0:2ee:b8ac:73b4 with SMTP id
 98e67ed59e1d1-2ef01276888mr1136791a91.36.1733192725616; Mon, 02 Dec 2024
 18:25:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241130181744.3772632-1-koichiro.den@canonical.com>
 <CACGkMEtmH9ukthh+DGCP5cJDrR=o9ML_1tF8nfS-rFa+NrijdA@mail.gmail.com> <20241202181445.0da50076@kernel.org>
In-Reply-To: <20241202181445.0da50076@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Dec 2024 10:25:14 +0800
Message-ID: <CACGkMEs=A3tJHf3sFFN++Fb+VL=7P9bWGCynDAVFjtOT-0bYFQ@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: drop netdev_tx_reset_queue() from virtnet_enable_queue_pair()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Koichiro Den <koichiro.den@canonical.com>, virtualization@lists.linux.dev, 
	mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, jiri@resnulli.us, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Cdd6IzmuaokQzWoDfs7EKgh3LuZO94oyrx6dfAEcwOY_1733192726
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 10:14=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 2 Dec 2024 12:22:53 +0800 Jason Wang wrote:
> > > Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
> > > Cc: <stable@vger.kernel.org> # v6.11+
> > > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> >
> > Acked-by: Jason Wang <jasowang@redhat.com>
>
> I see Tx skb flush in:
>
> virtnet_freeze() -> remove_vq_common() -> free_unused_bufs() -> virtnet_s=
q_free_unused_buf()
>
> do we need to reset the BQL state in that case?

Yes, I think so. And I spot another path which is:

virtnet_tx_resize() -> virtqueue_resize() -> virtnet_sq_free_unused_buf().

> Rule of thumb is netdev_tx_reset_queue() should follow any flush
> (IOW skb freeing not followed by netdev_tx_completed_queue()).
>

Right.

Koichiro, I think this fixes the problem of open/stop but may break
freeze/restore(). Let's fix that.

For resizing, it's a path that has been buggy since the introduction of BQL=
.

Thanks

