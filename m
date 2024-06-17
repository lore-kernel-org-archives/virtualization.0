Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0277C17E900
	for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 06:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718605704; cv=none; b=BTvxJcELwMAqESThQpWJl++DfPOL0+vlDKZBlWKDLcHbs8PcuC/pGz9r3xOepj1p3y/ewy3KUUrO2DdoT6ML2ij/TgZ8JZUKgqvTQsEp5yQu7Scv2qhzR8c4N5siebkXHCPMqhb7DeDAHiSAu7UTwSgMqRLrNNNjHEHSY04Oxyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718605704; c=relaxed/simple;
	bh=OSTkYO2YEbZIEWcvOK8gFKoY42oPBjRDD1sYUp4a7Js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lf6G/dZgFp8Xdb+OXqRzq0ci2SQA2I6rhqwBMWEdqZvSZO9SAjgo3OahKe2UveRUx7AgLy4yUZtOAskDJf4Yzepb5zKU97SnHIvhpahaEkRiOJOEiUk0t9fBqcODNEv9vWd13VSbNjPo/hZryos5sDOFOMyNA8x9dYrzrzPcXR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QmC9tg+4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmC9tg+4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718605702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Ps5JswGrFVlCCUIk9N0xG3axjAOsPQkWEjzfIjAMKY=;
	b=QmC9tg+4stQv7TUOHiokkVQHdfDJY6mnoniX+JMv3474N+p2ay5i/Ka8paPxFS4FHuOGQ3
	UICtAiU5DAo+VwPX14p5EbD4M+B37hQHHI/Z/9z1VUBfruYuJqzBEROSRFZm5HLrCpZ8Hr
	eekcar8eBj7zLEebN05SkX/qalLDJro=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-rHtt8PUnMM6n3hLrmObODg-1; Mon, 17 Jun 2024 02:28:19 -0400
X-MC-Unique: rHtt8PUnMM6n3hLrmObODg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-6e53ddbbb1fso4174894a12.0
        for <virtualization@lists.linux.dev>; Sun, 16 Jun 2024 23:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718605698; x=1719210498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Ps5JswGrFVlCCUIk9N0xG3axjAOsPQkWEjzfIjAMKY=;
        b=e3OH0FAkXkpAdZim30bYHfI6mHNosl7NcDqOBQG7nB4bsRcpvaFxXKTt+8xRJanAeZ
         DCYjpO5ayWaRA5gaihj/fGoksN92obIjI0mvjYYe6B0b7L1sILfUh5karv+h1s5v+hdW
         Hw6/VIRHsGIm6qzGBYxiKPDl5KX87OyhdOBHcTewcsmX/WhvcRVYO2PidKD2TQm0yi4d
         gCWiXNJhonJIqkHvNN9rOOKHyEhrx71ltm+ytMtPWo+YGEoog5Pp59FKWhXVL0atI3rO
         C3SraiDL+LRak5Phf3B83ZWnKut2oUdC2hsAwKAeN3+XNLshT6Pey2gRG7O11Phouhxr
         qIXw==
X-Forwarded-Encrypted: i=1; AJvYcCXloSjQLfNEvCYPgqFsmzYq9FnDOqgRX/4Yig6/JtzXqpBZQIYJoddQ0vZ3+nyvjfJo2QyLqdHvj424WZHdqmVrgoGEdhWKW1Zl+rI3G5o=
X-Gm-Message-State: AOJu0YxVc+vS3RmBW+gLubDRgwkBcDovjah246e3B9+uP8zJSigTBuhJ
	274Oy5vIgMEWKPdtaV632LYOgc3f0N2VIpgpfd7L6av2x70ZAqyJa1s6kVPxV8yf8uZ0H9fBNiM
	27xp+Qaaagu2vMKOgH4lk0WOqRPvP2sZ2tOzz2Vr/po1G7uN7qLiFEXYN4XZe59kBygfa4ElPgY
	KSu8iJ0ot0AjENo1TiG5b+eFGqMqI5QRn0uf/9OAA=
X-Received: by 2002:a05:6a20:12c1:b0:1b8:7de9:6e3f with SMTP id adf61e73a8af0-1bae82b6515mr10689242637.53.1718605698617;
        Sun, 16 Jun 2024 23:28:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2baPcl2kCTFLwcSKILsceKj+PbJEWOMXTqE4MSXxS0p/rU+v6ZPazw+zzfETCZucrn8dwHiLbJUrZH9BYgxw=
X-Received: by 2002:a05:6a20:12c1:b0:1b8:7de9:6e3f with SMTP id
 adf61e73a8af0-1bae82b6515mr10689221637.53.1718605698270; Sun, 16 Jun 2024
 23:28:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com>
 <20240614063933.108811-9-xuanzhuo@linux.alibaba.com> <CACGkMEu49yaJ+ZBAqP_e1T7kw-9GV8rKMeT1=GtG08ty52XWMw@mail.gmail.com>
In-Reply-To: <CACGkMEu49yaJ+ZBAqP_e1T7kw-9GV8rKMeT1=GtG08ty52XWMw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jun 2024 14:28:05 +0800
Message-ID: <CACGkMEuxhaPcSyvNnZH3q1uvSUTbpRMr+YuK4r0x6zG_SKesbg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 08/15] virtio_net: sq support premapped mode
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 1:00=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Jun 14, 2024 at 2:39=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > If the xsk is enabling, the xsk tx will share the send queue.
> > But the xsk requires that the send queue use the premapped mode.
> > So the send queue must support premapped mode when it is bound to
> > af-xdp.
> >
> > * virtnet_sq_set_premapped(sq, true) is used to enable premapped mode.
> >
> >     In this mode, the driver will record the dma info when skb or xdp
> >     frame is sent.
> >
> >     Currently, the SQ premapped mode is operational only with af-xdp. I=
n
> >     this mode, af-xdp, the kernel stack, and xdp tx/redirect will share
> >     the same SQ. Af-xdp independently manages its DMA. The kernel stack
> >     and xdp tx/redirect utilize this DMA metadata to manage the DMA
> >     info.
> >

Note that there's indeed a mode when we have exclusive XDP TX queue:

        /* XDP requires extra queues for XDP_TX */
        if (curr_qp + xdp_qp > vi->max_queue_pairs) {
                netdev_warn_once(dev, "XDP request %i queues but max
is %i. XDP_TX and XDP_REDIRECT will operate in a slower locked tx
mode.\n",
                                 curr_qp + xdp_qp, vi->max_queue_pairs);
                xdp_qp =3D 0;
        }

So we need to mention how the code works in this patch.

Thanks

