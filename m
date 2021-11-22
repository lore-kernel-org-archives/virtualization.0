Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67DC0C433F5
	for <virtualization@archiver.kernel.org>; Mon, 22 Nov 2021 06:25:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D436940483;
	Mon, 22 Nov 2021 06:25:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CmV_N2HRdII0; Mon, 22 Nov 2021 06:25:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7B19D40477;
	Mon, 22 Nov 2021 06:25:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58DD2C001E;
	Mon, 22 Nov 2021 06:25:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90D64C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 06:25:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 71DDC607E1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 06:25:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PwuSw3BCOSHX
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 06:25:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7B56E607D2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 06:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637562342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=we/obok4HmO9SGZqYAFpede1GV0eMYxSu1MvSfp00RM=;
 b=jP5rVvSnfZmgp1egSxufrMGamijt7E78SSdH/laxPpHxb4rJcXBoQvx0OLY1G5ZXIVlNhe
 WFDzKEsWrVpeRfISUsPpM3EPd6vVdYkZ5H0eddGfr8fP+gLlg6gZaNFELkCwS8bRKUADFR
 5/xbTBBo7NDJ44y6V0x1n7h3GMrvBik=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-YrO5dqicMye0WFmxK8LP9g-1; Mon, 22 Nov 2021 01:25:40 -0500
X-MC-Unique: YrO5dqicMye0WFmxK8LP9g-1
Received: by mail-lf1-f72.google.com with SMTP id
 y40-20020a0565123f2800b003fded085638so11307202lfa.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 22:25:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=we/obok4HmO9SGZqYAFpede1GV0eMYxSu1MvSfp00RM=;
 b=EbQ51cgaTFGCVMvM66dizV1kc3ANCN5RI9VmudWZXabxfZMtzgp3PgkjnTOLuZpEUv
 /vTGD2L1zZ55CGC1aaj1xSIpY/y3uJ8Z7B0RLOWWLmMeDYrSHrenZuH1r3QKZrJpuYI8
 kme9u4IMWf6JMVIJSJIJ+MXE/QZEEYQEdYWd60KnhusZsAF+E6qz4K2caa2cWm1jcM6G
 zjvUqi/Vzeo8tcHBEds95c9S3sMDtCL0+rwxZpbnjOZgx5HeL0F7IzPphc6O6ROkOy3Y
 9fwFWH5P4TaTXjVFle5/bEoyn7ezbv44nYrH/wTQ8IpqfAh61G9tFj5gEq9wE7Lqw/h0
 B+aw==
X-Gm-Message-State: AOAM531LxE3tNswEc5zjmIsU1wW2H9XS1jz44lqUb8AYkQ4JLbq9Jrub
 AFeONsR9MwXbzVPySrZbfi+K2bR1BLb8bJKEUCEuowVyCaoOUvh4k7Zkjs6KMgUZgLxSEraM0U0
 XvzhDUHs8dV0JRX39qB0RSuDtUsP7RgaSuVvALnhbjtnMNMYlDhsuaBXOOw==
X-Received: by 2002:a05:6512:685:: with SMTP id
 t5mr55997117lfe.84.1637562339164; 
 Sun, 21 Nov 2021 22:25:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyvjpNkAqopUpG7y0WdBxsfbN0K27yrPbxpDn/zySxBCcwoxJhlPE2nEiPKcfgRGp9c5O9SVHRQl77cLFFhm/8=
X-Received: by 2002:a05:6512:685:: with SMTP id
 t5mr55997098lfe.84.1637562338934; 
 Sun, 21 Nov 2021 22:25:38 -0800 (PST)
MIME-Version: 1.0
References: <20211027022107.14357-1-jasowang@redhat.com>
 <20211027022107.14357-2-jasowang@redhat.com>
 <20211119160951.5f2294c8.pasic@linux.ibm.com>
 <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
 <20211122063518.37929c01.pasic@linux.ibm.com>
 <20211122064922.51b3678e.pasic@linux.ibm.com>
In-Reply-To: <20211122064922.51b3678e.pasic@linux.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Nov 2021 14:25:26 +0800
Message-ID: <CACGkMEu+9FvMsghyi55Ee5BxetP-YK9wh2oaT8OgLiY5+tV0QQ@mail.gmail.com>
Subject: Re: [PATCH V5 1/4] virtio_ring: validate used buffer length
To: Halil Pasic <pasic@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "kaplan, david" <david.kaplan@amd.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Hetzelt,
 Felicitas" <f.hetzelt@tu-berlin.de>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 mst <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Nov 22, 2021 at 1:49 PM Halil Pasic <pasic@linux.ibm.com> wrote:
>
> On Mon, 22 Nov 2021 06:35:18 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
>
> > > I think it should be a common issue, looking at
> > > vhost_vsock_handle_tx_kick(), it did:
> > >
> > > len += sizeof(pkt->hdr);
> > > vhost_add_used(vq, head, len);
> > >
> > > which looks like a violation of the spec since it's TX.
> >
> > I'm not sure the lines above look like a violation of the spec. If you
> > examine vhost_vsock_alloc_pkt() I believe that you will agree that:
> > len == pkt->len == pkt->hdr.len
> > which makes sense since according to the spec both tx and rx messages
> > are hdr+payload. And I believe hdr.len is the size of the payload,
> > although that does not seem to be properly documented by the spec.

Sorry for being unclear, what I meant is that we probably should use
zero here. TX doesn't use in buffer actually.

According to the spec, 0 should be the used length:

"and len the total of bytes written into the buffer."

> >
> > On the other hand tx messages are stated to be device read-only (in the
> > spec) so if the device writes stuff, that is certainly wrong.
> >

Yes.

> > If that is what happens.
> >
> > Looking at virtqueue_get_buf_ctx_split() I'm not sure that is what
> > happens. My hypothesis is that we just a last descriptor is an 'in'
> > type descriptor (i.e. a device writable one). For tx that assumption
> > would be wrong.
> >
> > I will have another look at this today and send a fix patch if my
> > suspicion is confirmed.
>
> If my suspicion is right something like:
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 00f64f2f8b72..efb57898920b 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -764,6 +764,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>         struct vring_virtqueue *vq = to_vvq(_vq);
>         void *ret;
>         unsigned int i;
> +       bool has_in;
>         u16 last_used;
>
>         START_USE(vq);
> @@ -787,6 +788,9 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>                         vq->split.vring.used->ring[last_used].id);
>         *len = virtio32_to_cpu(_vq->vdev,
>                         vq->split.vring.used->ring[last_used].len);
> +       has_in = virtio16_to_cpu(_vq->vdev,
> +                       vq->split.vring.used->ring[last_used].flags)
> +                               & VRING_DESC_F_WRITE;

Did you mean vring.desc actually? If yes, it's better not depend on
the descriptor ring which can be modified by the device. We've stored
the flags in desc_extra[].

>
>         if (unlikely(i >= vq->split.vring.num)) {
>                 BAD_RING(vq, "id %u out of range\n", i);
> @@ -796,7 +800,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>                 BAD_RING(vq, "id %u is not a head!\n", i);
>                 return NULL;
>         }
> -       if (vq->buflen && unlikely(*len > vq->buflen[i])) {
> +       if (has_in && q->buflen && unlikely(*len > vq->buflen[i])) {
>                 BAD_RING(vq, "used len %d is larger than in buflen %u\n",
>                         *len, vq->buflen[i]);
>                 return NULL;
>
> would fix the problem for split. I will try that out and let you know
> later.

I'm not sure I get this, in virtqueue_add_split, the buflen[i] only
contains the in buffer length.

I think the fixes are:

1) fixing the vhost vsock
2) use suppress_used_validation=true to let vsock driver to validate
the in buffer length
3) probably a new feature so the driver can only enable the validation
when the feature is enabled.

Thanks

>
> Regards,
> Halil
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
