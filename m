Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC1AC433EF
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 02:31:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0CB6607A3;
	Tue, 23 Nov 2021 02:31:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CzlOEkJLn6za; Tue, 23 Nov 2021 02:31:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2CA70605F5;
	Tue, 23 Nov 2021 02:31:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEB86C002E;
	Tue, 23 Nov 2021 02:30:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4FA1C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 02:30:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B0C214041F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 02:30:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MmCF5XI5Qt_T
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 02:30:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DCDCD40411
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 02:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637634656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wCkvV/uQ/l+5VmuSujGW2K1ZJaWeBNqARPUi89XiOro=;
 b=LUfxPDitX3haVsEMVpX5akyDqkeqn+v+Brre1vKn7/w8r3JKVKspfJ9/1RmUEnw0SCt7hp
 9S0I/C5BtExP5eOVtKlLY/LKQDh1SKGnJLzr70SN6d8BiedlAX73+evPfmIf2XuZdEoO1K
 3SON5JflBTq+nw0I2JvuNbdcMFk3IgY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-525-J3UXHG0PMc6-xh9MWawN5A-1; Mon, 22 Nov 2021 21:30:55 -0500
X-MC-Unique: J3UXHG0PMc6-xh9MWawN5A-1
Received: by mail-lf1-f71.google.com with SMTP id
 b23-20020a0565120b9700b00403a044bfcdso13381672lfv.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 18:30:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wCkvV/uQ/l+5VmuSujGW2K1ZJaWeBNqARPUi89XiOro=;
 b=X9AJ6LDJMkfxIJsgkLYLtzMJ13OPIMiauWNsQCCp63nWhDkHr2TAPzPkKr/GOpgofU
 twfLaWfy87hl53mieb1Tt0tMW84zvtovFGyqsL9pnRUjACJSEUeD9dbMS+7qGwdjxOVg
 T8sn+0mGNAK9XNl1bDcG216VASQknjnwlyhe35EFaJG5DCMeQVnWyITDWaQi14ZMTMoi
 jt5uEa720KyfbYMg4dgaHCpF7+mK3qp5J5J3HATWqTM/kYHJUEs4wke9z2L9hl+ocsQa
 TiXneiWYQirxzOxNJUbWYGY5jSO/cW86innfTAuM3TqzF1+prAGEoofK/9EbkiH9ds6a
 qAgA==
X-Gm-Message-State: AOAM530Qw8zPC1l/NacFLlplOBa6RkwzfPe+5/ORo8u1kZgrZC7C0lg7
 DOGGKeUyWJsSvZUY2gFaLjJqF7FZHuDID9DnWHr06f+6VnHFTgTLtjsNZEAPEr5G1laAMbxxKJY
 +1jZwVjbNkiBvkiQYXvUNjMHcc+dy2i0a4WcAvLEFPH6TX6EFNSph8RmwNQ==
X-Received: by 2002:a2e:2ac1:: with SMTP id q184mr1242447ljq.420.1637634653898; 
 Mon, 22 Nov 2021 18:30:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRAo64DnpXGi056uwL0AGCZ115VkubYU56IC6Uae253U4UUTM6u6QJOOsgeBLEqc1CbnUQlDBIu1AlEAYCjos=
X-Received: by 2002:a2e:2ac1:: with SMTP id q184mr1242418ljq.420.1637634653620; 
 Mon, 22 Nov 2021 18:30:53 -0800 (PST)
MIME-Version: 1.0
References: <20211027022107.14357-1-jasowang@redhat.com>
 <20211027022107.14357-2-jasowang@redhat.com>
 <20211119160951.5f2294c8.pasic@linux.ibm.com>
 <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
 <20211122063518.37929c01.pasic@linux.ibm.com>
 <20211122064922.51b3678e.pasic@linux.ibm.com>
 <CACGkMEu+9FvMsghyi55Ee5BxetP-YK9wh2oaT8OgLiY5+tV0QQ@mail.gmail.com>
 <20211122145003.3e127a03.pasic@linux.ibm.com>
In-Reply-To: <20211122145003.3e127a03.pasic@linux.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 Nov 2021 10:30:42 +0800
Message-ID: <CACGkMEsdUfxrSsF30QNhs=41FxQN9uMW0cOb1E-HWF3yChU_Gw@mail.gmail.com>
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

On Mon, Nov 22, 2021 at 9:50 PM Halil Pasic <pasic@linux.ibm.com> wrote:
>
> On Mon, 22 Nov 2021 14:25:26 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
> > On Mon, Nov 22, 2021 at 1:49 PM Halil Pasic <pasic@linux.ibm.com> wrote:
> > >
> > > On Mon, 22 Nov 2021 06:35:18 +0100
> > > Halil Pasic <pasic@linux.ibm.com> wrote:
> > >
> > > > > I think it should be a common issue, looking at
> > > > > vhost_vsock_handle_tx_kick(), it did:
> > > > >
> > > > > len += sizeof(pkt->hdr);
> > > > > vhost_add_used(vq, head, len);
> > > > >
> > > > > which looks like a violation of the spec since it's TX.
> > > >
> > > > I'm not sure the lines above look like a violation of the spec. If you
> > > > examine vhost_vsock_alloc_pkt() I believe that you will agree that:
> > > > len == pkt->len == pkt->hdr.len
> > > > which makes sense since according to the spec both tx and rx messages
> > > > are hdr+payload. And I believe hdr.len is the size of the payload,
> > > > although that does not seem to be properly documented by the spec.
> >
> > Sorry for being unclear, what I meant is that we probably should use
> > zero here. TX doesn't use in buffer actually.
> >
> > According to the spec, 0 should be the used length:
> >
> > "and len the total of bytes written into the buffer."
>
> Right, I was wrong. I somehow assumed this is the total length and not
> just the number of bytes written.
>
> >
> > > >
> > > > On the other hand tx messages are stated to be device read-only (in the
> > > > spec) so if the device writes stuff, that is certainly wrong.
> > > >
> >
> > Yes.
> >
> > > > If that is what happens.
> > > >
> > > > Looking at virtqueue_get_buf_ctx_split() I'm not sure that is what
> > > > happens. My hypothesis is that we just a last descriptor is an 'in'
> > > > type descriptor (i.e. a device writable one). For tx that assumption
> > > > would be wrong.
> > > >
> > > > I will have another look at this today and send a fix patch if my
> > > > suspicion is confirmed.
>
> Yeah, I didn't remember the semantic of
> vq->split.vring.used->ring[last_used].len
> correctly, and in fact also how exactly the rings work. So your objection
> is correct.
>
> Maybe updating some stuff would make it easier to not make this mistake.
>
> For example the spec and also the linux header says:
>
> /* le32 is used here for ids for padding reasons. */
> struct virtq_used_elem {
>         /* Index of start of used descriptor chain. */
>         le32 id;
>         /* Total length of the descriptor chain which was used (written to) */
>         le32 len;
> };
>
> I think that comment isn't as clear as it could be. I would prefer:
> /* The number of bytes written into the device writable portion of the
> buffer described by the descriptor chain. */
>
> I believe "the descriptor chain which was used" includes both the
> descriptors that map the device read only and the device write
> only portions of the buffer described by the descriptor chain. And the
> total length of that descriptor chain may be defined either as a number
> of the descriptors that form the chain, or the length of the buffer.
>
> One has to use the descriptor chain even if the whole buffer is device
> read only. So "used" == "written to" does not make any sense to me.

Not a native speaker but if others are fine I'm ok with this tweak on
the comment.

>
> Also something like
> int vhost_add_used(struct vhost_virtqueue *vq, unsigned int head, int bytes_written)
> instead of
> int vhost_add_used(struct vhost_virtqueue *vq, unsigned int head, int len)
> would make it easier to read the code correctly.

Or maybe a comment to explain the len.

Thanks

>
> > >
> > > If my suspicion is right something like:
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 00f64f2f8b72..efb57898920b 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -764,6 +764,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> > >         struct vring_virtqueue *vq = to_vvq(_vq);
> > >         void *ret;
> > >         unsigned int i;
> > > +       bool has_in;
> > >         u16 last_used;
> > >
> > >         START_USE(vq);
> > > @@ -787,6 +788,9 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> > >                         vq->split.vring.used->ring[last_used].id);
> > >         *len = virtio32_to_cpu(_vq->vdev,
> > >                         vq->split.vring.used->ring[last_used].len);
> > > +       has_in = virtio16_to_cpu(_vq->vdev,
> > > +                       vq->split.vring.used->ring[last_used].flags)
> > > +                               & VRING_DESC_F_WRITE;
> >
> > Did you mean vring.desc actually? If yes, it's better not depend on
> > the descriptor ring which can be modified by the device. We've stored
> > the flags in desc_extra[].
> >
> > >
> > >         if (unlikely(i >= vq->split.vring.num)) {
> > >                 BAD_RING(vq, "id %u out of range\n", i);
> > > @@ -796,7 +800,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> > >                 BAD_RING(vq, "id %u is not a head!\n", i);
> > >                 return NULL;
> > >         }
> > > -       if (vq->buflen && unlikely(*len > vq->buflen[i])) {
> > > +       if (has_in && q->buflen && unlikely(*len > vq->buflen[i])) {
> > >                 BAD_RING(vq, "used len %d is larger than in buflen %u\n",
> > >                         *len, vq->buflen[i]);
> > >                 return NULL;
> > >
> > > would fix the problem for split. I will try that out and let you know
> > > later.
> >
> > I'm not sure I get this, in virtqueue_add_split, the buflen[i] only
> > contains the in buffer length.
>
> Sorry my diff is indeed silly.
>
> >
> > I think the fixes are:
> >
> > 1) fixing the vhost vsock
> > 2) use suppress_used_validation=true to let vsock driver to validate
> > the in buffer length
> > 3) probably a new feature so the driver can only enable the validation
> > when the feature is enabled.
> >
>
> Makes sense!
>
> Regards,
> Halil
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
