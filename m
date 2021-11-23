Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62536C433F5
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 12:17:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A8ED80DAB;
	Tue, 23 Nov 2021 12:17:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VfTiWTw2VliC; Tue, 23 Nov 2021 12:17:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 85C7980DA3;
	Tue, 23 Nov 2021 12:17:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 524D8C001E;
	Tue, 23 Nov 2021 12:17:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D047BC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 12:17:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B04D04019E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 12:17:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nxpyu9qmPhUE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 12:17:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E93E340163
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 12:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637669835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JBT66qvlU87c9lSFd4UZabgUG0N5vFPa+fiSliYRAuw=;
 b=N4s+t3A8P8o8U4ND67mJyLsV9ZnW/FHq1tpfmcsPPXISufSQYQbkqtC4IWvT+tsjU2bYpF
 I35luMDAVFehIIIj3IgEVThtASu9yLw2YR7rUSmfLrfXhzTPJskqfduCgoz3zmBlIkTEXe
 NCW4ICdKFG7f3ra9CGwocbrMoYyL0/I=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-3nlZGkJ9PVidsc5oQ6-Zgg-1; Tue, 23 Nov 2021 07:17:12 -0500
X-MC-Unique: 3nlZGkJ9PVidsc5oQ6-Zgg-1
Received: by mail-ed1-f69.google.com with SMTP id
 p4-20020aa7d304000000b003e7ef120a37so17621358edq.16
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 04:17:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JBT66qvlU87c9lSFd4UZabgUG0N5vFPa+fiSliYRAuw=;
 b=NOBvf0PJxKlIA6K58PpKcJ+arfGdu1av/M5i6+R8vCfW9QoFKP6ykaX2JMkBOJKcd2
 H1iQfYPdsShfZ7iugBp1Rxu5Xcon95Nz4F+/HKlJUTEzC9M+QmdFdy71QZdwRpxHHtqK
 L/qahuUaYGXVh7bt5xcWyxll2DKYF/ewSHKbqn8bby067a504k+ElJS7Bg0SW6HT+Y4c
 TWpQM5PU6y2nDFvdFtfTfrWXzU9ji93nbWYu02/I9NTGpb/0QNvjoGw6nwbiFL3+0xku
 ZI+tR98q1s7SdU+10n6vbn/DptlrtjIbd2WQZSw3maoDOWgFHIZ/8dcjvqExquJLtf0R
 0iXg==
X-Gm-Message-State: AOAM533JUc7do6lIdkIVh0BPyeFkBjfqST9Co9XEU7vSIa3vGXeqvlL8
 UTnt4hHSeYQNziGG2YYHMgaDBReuXmUIAngDc7crk9yfDZyTaOP0hn/006S7kV492ooo0nBAfN7
 dd6wuCy5oayFj0PsvHtGzwkQcxTy7/SZeBeEflsP//w==
X-Received: by 2002:a17:906:1396:: with SMTP id
 f22mr7167479ejc.228.1637669830898; 
 Tue, 23 Nov 2021 04:17:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzqOjquxUZFkVVBX1/K2n0e6XHS/pI/6jStmXjTavqRtuOPkqZofm+qd6I0XW+tAJ9pCyFJdA==
X-Received: by 2002:a17:906:1396:: with SMTP id
 f22mr7167446ejc.228.1637669830687; 
 Tue, 23 Nov 2021 04:17:10 -0800 (PST)
Received: from redhat.com ([45.15.16.143])
 by smtp.gmail.com with ESMTPSA id m25sm5651510edj.80.2021.11.23.04.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Nov 2021 04:17:09 -0800 (PST)
Date: Tue, 23 Nov 2021 07:17:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH V5 1/4] virtio_ring: validate used buffer length
Message-ID: <20211123071340-mutt-send-email-mst@kernel.org>
References: <20211027022107.14357-1-jasowang@redhat.com>
 <20211027022107.14357-2-jasowang@redhat.com>
 <20211119160951.5f2294c8.pasic@linux.ibm.com>
 <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
 <20211122063518.37929c01.pasic@linux.ibm.com>
 <20211122064922.51b3678e.pasic@linux.ibm.com>
 <CACGkMEu+9FvMsghyi55Ee5BxetP-YK9wh2oaT8OgLiY5+tV0QQ@mail.gmail.com>
 <20211122145003.3e127a03.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20211122145003.3e127a03.pasic@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kaplan, david" <david.kaplan@amd.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Hetzelt,
 Felicitas" <f.hetzelt@tu-berlin.de>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
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

On Mon, Nov 22, 2021 at 02:50:03PM +0100, Halil Pasic wrote:
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

The virtio spec actually says

Total length of the descriptor chain which was written to

without the "used" part.

> Also something like
> int vhost_add_used(struct vhost_virtqueue *vq, unsigned int head, int bytes_written)
> instead of
> int vhost_add_used(struct vhost_virtqueue *vq, unsigned int head, int len)
> would make it easier to read the code correctly.

I think we agree here. Patches?

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

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
