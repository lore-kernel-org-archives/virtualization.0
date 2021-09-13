Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888E3C433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 07:14:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1831560FF2
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 07:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1831560FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D97E640271;
	Mon, 13 Sep 2021 07:14:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yoWR-FvpUMQI; Mon, 13 Sep 2021 07:13:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 596354023F;
	Mon, 13 Sep 2021 07:13:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 395F0C000F;
	Mon, 13 Sep 2021 07:13:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1240C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 07:13:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 89F2C80C56
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 07:13:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aG7ujeLNNp8P
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 07:13:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BBE9280A93
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 07:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631517233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jh0KU3Sv6x8sFcS0pPhFPEvAjOPvPT5qvBoko3QxumI=;
 b=HUFOG7CWMqsG5ZVWfPskO9rFIAEfgPRiEpaeBYa0lC8NZ21Ttij6xOwKAS//l2DieGMYQW
 vXZ7LgO9HkWEO8ySczJbfiWmhq/5mhafXH/Us/wK5uZXPzbkeePKyzOUcejqx5DNBYPWno
 WxyeWdsgjWoXkJcml4Xt5SBTOdxCyKk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-q-zWwDc1OOSrID80VMThdg-1; Mon, 13 Sep 2021 03:13:51 -0400
X-MC-Unique: q-zWwDc1OOSrID80VMThdg-1
Received: by mail-lj1-f199.google.com with SMTP id
 w11-20020a2e998b000000b001c071349c96so3731132lji.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 00:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jh0KU3Sv6x8sFcS0pPhFPEvAjOPvPT5qvBoko3QxumI=;
 b=erni5fSd01Zh3ta2bZi/UUG0g+5YFmeQh7M541DNbO4Z9WDkjNZiu4cifJGSjgYuwr
 TQ5Zye0cY2jo2MwnYYUWdAibhZbdj7ovEsagj+2SFYGoRJv0i1vleyUIspJ5L8Ah3vPP
 4ZrFEGtuZUEaqtFdy0dkNAz/g07dok2eKw9gDhgI84cJO++06jWq60pRwaZHI/tKwZlq
 saVRstix4M1wNqISoew5x2xsEGiPYAgOmz5e+swWGBDHajtdqNmDpTn1lP4BDGknISx1
 b2LtV/+/EoGEv6DVbGmqLyWWTWs+oPtXLlAqBshumONzHukdxEBucmPjjTW1NHyG0RSD
 DL+A==
X-Gm-Message-State: AOAM532ty9H29ZBStwIpQN1tIpE2lBP8MmCtN7VKR7+Znfu/d+nbGMj3
 TODOdwlxwmJ+WEhvodjeyJpQ3A846iZzwChyqwVeKHsmlH3qiQGQkidEZVSuwYoBlkDSljFHQs9
 ZMVNzMAq0qGQcRfe1ZpEnMbit3AGIQD7ihn0YvhglQt8MluA68COD0Xq2Sg==
X-Received: by 2002:a05:651c:54c:: with SMTP id
 q12mr9602417ljp.369.1631517229634; 
 Mon, 13 Sep 2021 00:13:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycPxBgCQO1gE8i+MvVdUGtkEMPUfn03lKIoegv1ZwDbOj48JN0k6JDpy6CnZ0f/tV6+r520UFOx8xcJ2azRaw=
X-Received: by 2002:a05:651c:54c:: with SMTP id
 q12mr9602400ljp.369.1631517229343; 
 Mon, 13 Sep 2021 00:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-10-jasowang@redhat.com>
 <20210913023428-mutt-send-email-mst@kernel.org>
 <CACGkMEsqFbnog3jktR0Ms-u75yHfo8zKO-SC66iN2fLZ185XWQ@mail.gmail.com>
 <20210913025145-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210913025145-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 13 Sep 2021 15:13:38 +0800
Message-ID: <CACGkMEvPcRwHFxAsjsDxaAVOQkDUONSKgeyP6ZS9SM6RAw81uA@mail.gmail.com>
Subject: Re: [PATCH 9/9] virtio_ring: validate used buffer length
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Hetzelt,
 Felicitas" <f.hetzelt@tu-berlin.de>,
 linux-kernel <linux-kernel@vger.kernel.org>, "kaplan,
 david" <david.kaplan@amd.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Mon, Sep 13, 2021 at 2:57 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Sep 13, 2021 at 02:40:09PM +0800, Jason Wang wrote:
> > On Mon, Sep 13, 2021 at 2:36 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Sep 13, 2021 at 01:53:53PM +0800, Jason Wang wrote:
> > > > This patch validate the used buffer length provided by the device
> > > > before trying to use it. This is done by record the in buffer length
> > > > in a new field in desc_state structure during virtqueue_add(), then we
> > > > can fail the virtqueue_get_buf() when we find the device is trying to
> > > > give us a used buffer length which is greater than the in buffer
> > > > length.
> > > >
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > >
> > > Hmm this was proposed in the past. The overhead here is
> > > not negligeable, so I'd like to know more -
> > > when is it a problem if the used len is too big?
> >
> > One example is: https://github.com/fuzzsa/fuzzsa-bugs/blob/master/virtio_rng.md
> >
> > And there would be more I guess.
>
> That seems to suggest hwrng validation is better, and
> I think it makes sense: will fix all rng drivers in one go.
>
> > > Don't the affected drivers already track the length somewhere
> > > and so can validated it without the extra cost in
> > > virtio core?
> >
> > Probably, but this requires the changes in each device driver. And it
> > would be easily forgotten if new drivers are introduced?
> >
> > Thanks
>
> My thinking is one just has to be aware that before enabling
> any drivers they have to be audited. We can validate
> used length but e.g. for virtio net the length is inside
> the buffer anyway.

Yes, maybe we can introduce a boolean to tell the virtio core that the
driver can do the validation by itself.

>
> If we really have to, maybe use extra->len?

The extra->len has already been used for per descriptor length.

> And maybe have a mod param so the check can be turned off e.g.
> for benchmarking purposes.

Right. And I will benchmark the differences.

Thanks

>
>
>
> > >
> > > > ---
> > > >  drivers/virtio/virtio_ring.c | 23 +++++++++++++++++++++++
> > > >  1 file changed, 23 insertions(+)
> > > >
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > index d2ca0a7365f8..b8374a6144f3 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -69,6 +69,7 @@
> > > >  struct vring_desc_state_split {
> > > >       void *data;                     /* Data for callback. */
> > > >       struct vring_desc *indir_desc;  /* Indirect descriptor, if any. */
> > > > +     u64 buflen;                     /* In buffer length */
> > > >  };
> > > >
> > > >  struct vring_desc_state_packed {
> > > > @@ -76,6 +77,7 @@ struct vring_desc_state_packed {
> > > >       struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
> > > >       u16 num;                        /* Descriptor list length. */
> > > >       u16 last;                       /* The last desc state in a list. */
> > > > +     u64 buflen;                     /* In buffer length */
> > > >  };
> > > >
> > > >  struct vring_desc_extra {
> > > > @@ -490,6 +492,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > > >       unsigned int i, n, avail, descs_used, prev, err_idx;
> > > >       int head;
> > > >       bool indirect;
> > > > +     u64 buflen = 0;
> > > >
> > > >       START_USE(vq);
> > > >
> > > > @@ -571,6 +574,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > > >                                                    VRING_DESC_F_NEXT |
> > > >                                                    VRING_DESC_F_WRITE,
> > > >                                                    indirect);
> > > > +                     buflen += sg->length;
> > > >               }
> > > >       }
> > > >       /* Last one doesn't continue. */
> > > > @@ -605,6 +609,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > > >
> > > >       /* Store token and indirect buffer state. */
> > > >       vq->split.desc_state[head].data = data;
> > > > +     vq->split.desc_state[head].buflen = buflen;
> > > >       if (indirect)
> > > >               vq->split.desc_state[head].indir_desc = desc;
> > > >       else
> > > > @@ -784,6 +789,11 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> > > >               BAD_RING(vq, "id %u is not a head!\n", i);
> > > >               return NULL;
> > > >       }
> > > > +     if (unlikely(*len > vq->split.desc_state[i].buflen)) {
> > > > +             BAD_RING(vq, "used len %d is larger than in buflen %lld\n",
> > > > +                     *len, vq->split.desc_state[i].buflen);
> > > > +             return NULL;
> > > > +     }
> > > >
> > > >       /* detach_buf_split clears data, so grab it now. */
> > > >       ret = vq->split.desc_state[i].data;
> > > > @@ -1062,6 +1072,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> > > >       unsigned int i, n, err_idx;
> > > >       u16 head, id;
> > > >       dma_addr_t addr;
> > > > +     u64 buflen = 0;
> > > >
> > > >       head = vq->packed.next_avail_idx;
> > > >       desc = alloc_indirect_packed(total_sg, gfp);
> > > > @@ -1089,6 +1100,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> > > >                       desc[i].addr = cpu_to_le64(addr);
> > > >                       desc[i].len = cpu_to_le32(sg->length);
> > > >                       i++;
> > > > +                     if (n >= out_sgs)
> > > > +                             buflen += sg->length;
> > > >               }
> > > >       }
> > > >
> > > > @@ -1141,6 +1154,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> > > >       vq->packed.desc_state[id].data = data;
> > > >       vq->packed.desc_state[id].indir_desc = desc;
> > > >       vq->packed.desc_state[id].last = id;
> > > > +     vq->packed.desc_state[id].buflen = buflen;
> > > >
> > > >       vq->num_added += 1;
> > > >
> > > > @@ -1176,6 +1190,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> > > >       unsigned int i, n, c, descs_used, err_idx;
> > > >       __le16 head_flags, flags;
> > > >       u16 head, id, prev, curr, avail_used_flags;
> > > > +     u64 buflen = 0;
> > > >
> > > >       START_USE(vq);
> > > >
> > > > @@ -1250,6 +1265,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> > > >                                       1 << VRING_PACKED_DESC_F_AVAIL |
> > > >                                       1 << VRING_PACKED_DESC_F_USED;
> > > >                       }
> > > > +                     if (n >= out_sgs)
> > > > +                             buflen += sg->length;
> > > >               }
> > > >       }
> > > >
> > > > @@ -1268,6 +1285,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> > > >       vq->packed.desc_state[id].data = data;
> > > >       vq->packed.desc_state[id].indir_desc = ctx;
> > > >       vq->packed.desc_state[id].last = prev;
> > > > +     vq->packed.desc_state[id].buflen = buflen;
> > > >
> > > >       /*
> > > >        * A driver MUST NOT make the first descriptor in the list
> > > > @@ -1455,6 +1473,11 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> > > >               BAD_RING(vq, "id %u is not a head!\n", id);
> > > >               return NULL;
> > > >       }
> > > > +     if (unlikely(*len > vq->packed.desc_state[id].buflen)) {
> > > > +             BAD_RING(vq, "used len %d is larger than in buflen %lld\n",
> > > > +                     *len, vq->packed.desc_state[id].buflen);
> > > > +             return NULL;
> > > > +     }
> > > >
> > > >       /* detach_buf_packed clears data, so grab it now. */
> > > >       ret = vq->packed.desc_state[id].data;
> > > > --
> > > > 2.25.1
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
