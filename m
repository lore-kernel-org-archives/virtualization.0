Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3188BC433FE
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 06:57:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C19DD60E8B
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 06:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C19DD60E8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 86AFD40454;
	Mon, 13 Sep 2021 06:57:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WALJ4JMJwP8S; Mon, 13 Sep 2021 06:57:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F318C40430;
	Mon, 13 Sep 2021 06:57:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6ADAC0011;
	Mon, 13 Sep 2021 06:57:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A810DC000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:57:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8FE2F40430
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:57:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VKJAO45r3Z-T
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:57:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 57C494042F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631516240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uq9tbu3TDqgOAJs2JRYdBCy2+stYK+Aour5wYZ0uUGA=;
 b=Ieh8v56XO1VuZCj42SfnjpO4QTPS2mgUvyJrcKTXbznWmbq8bGW3GDEBEuPBemXxvbVUzN
 rNdjsh1AwAtvEGPTx5jrLQbx5Sw3uCtY6qzq4MHhj8Cs22EC3iwJI5DYvtjcQSVTQgXu+P
 WnzztgH/Oo/8IlyF0IBYtXNvAMzenbg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-BwY1c9msPHWQ9NgDNQ1Llg-1; Mon, 13 Sep 2021 02:57:18 -0400
X-MC-Unique: BwY1c9msPHWQ9NgDNQ1Llg-1
Received: by mail-ej1-f71.google.com with SMTP id
 f10-20020a170906390a00b005eeb8ca19f7so1652287eje.7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 23:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Uq9tbu3TDqgOAJs2JRYdBCy2+stYK+Aour5wYZ0uUGA=;
 b=xuKacWJxZ1LS8WR5O1FXRmTpVkjrhuPaEpjytzbiL5MNGb11AHQoQAClhT6f3EY2gd
 lPatHGA8DmLDGrpZI5Pvh+5OIgnLKR1WOO+YyvKCT85rTIYdoWzy//vJmqny4u2vdNKk
 2knSVotF8V5XwMdLUNroeIkX3g7QuQ/Fa5siQqzEWN8DlDyV8SZwbUdeDn8yKtFwdrM9
 0fF2587faC+gpXl5s8V9QKMVokNzWaF2s1Rekz5zkEeW/lnue4/bgw2uJWB8qbcFVIP5
 aSHBNGtnDLm+RE3lMTiCboSHNkySXhYVxLA9KuFQHChnZLF589psir71iHB0aJ+XXTsq
 8rDQ==
X-Gm-Message-State: AOAM530yG3/v/yr7w1kreCJGft6ykdlg6hjlxItUwICatwO/33B1X9lv
 LI4xBxYnFJaWNgrte7atzgK7LFEWS3mn8xvijlozgPeB7/PuX76bm0DgUg4htmtV71pdL8jUjxT
 W5TbaiRQQ0ol+zDk9OFk1Kzb1nxcGObKr2gVBRahVQw==
X-Received: by 2002:a17:906:b104:: with SMTP id
 u4mr11298287ejy.201.1631516237578; 
 Sun, 12 Sep 2021 23:57:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyf5/Gf8m1Q3nQCm+wPmq4d0HVpTy/1yuqlo2Uj3Zc2BLzZUv7WljJ+w+6qn7kZUCSD+LF40w==
X-Received: by 2002:a17:906:b104:: with SMTP id
 u4mr11298276ejy.201.1631516237402; 
 Sun, 12 Sep 2021 23:57:17 -0700 (PDT)
Received: from redhat.com ([2.55.27.174])
 by smtp.gmail.com with ESMTPSA id lz19sm3027248ejb.40.2021.09.12.23.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Sep 2021 23:57:16 -0700 (PDT)
Date: Mon, 13 Sep 2021 02:57:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 9/9] virtio_ring: validate used buffer length
Message-ID: <20210913025145-mutt-send-email-mst@kernel.org>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-10-jasowang@redhat.com>
 <20210913023428-mutt-send-email-mst@kernel.org>
 <CACGkMEsqFbnog3jktR0Ms-u75yHfo8zKO-SC66iN2fLZ185XWQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsqFbnog3jktR0Ms-u75yHfo8zKO-SC66iN2fLZ185XWQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Mon, Sep 13, 2021 at 02:40:09PM +0800, Jason Wang wrote:
> On Mon, Sep 13, 2021 at 2:36 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Sep 13, 2021 at 01:53:53PM +0800, Jason Wang wrote:
> > > This patch validate the used buffer length provided by the device
> > > before trying to use it. This is done by record the in buffer length
> > > in a new field in desc_state structure during virtqueue_add(), then we
> > > can fail the virtqueue_get_buf() when we find the device is trying to
> > > give us a used buffer length which is greater than the in buffer
> > > length.
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> > Hmm this was proposed in the past. The overhead here is
> > not negligeable, so I'd like to know more -
> > when is it a problem if the used len is too big?
> 
> One example is: https://github.com/fuzzsa/fuzzsa-bugs/blob/master/virtio_rng.md
> 
> And there would be more I guess.

That seems to suggest hwrng validation is better, and
I think it makes sense: will fix all rng drivers in one go.

> > Don't the affected drivers already track the length somewhere
> > and so can validated it without the extra cost in
> > virtio core?
> 
> Probably, but this requires the changes in each device driver. And it
> would be easily forgotten if new drivers are introduced?
> 
> Thanks

My thinking is one just has to be aware that before enabling
any drivers they have to be audited. We can validate
used length but e.g. for virtio net the length is inside
the buffer anyway.

If we really have to, maybe use extra->len?
And maybe have a mod param so the check can be turned off e.g.
for benchmarking purposes.



> >
> > > ---
> > >  drivers/virtio/virtio_ring.c | 23 +++++++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index d2ca0a7365f8..b8374a6144f3 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -69,6 +69,7 @@
> > >  struct vring_desc_state_split {
> > >       void *data;                     /* Data for callback. */
> > >       struct vring_desc *indir_desc;  /* Indirect descriptor, if any. */
> > > +     u64 buflen;                     /* In buffer length */
> > >  };
> > >
> > >  struct vring_desc_state_packed {
> > > @@ -76,6 +77,7 @@ struct vring_desc_state_packed {
> > >       struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
> > >       u16 num;                        /* Descriptor list length. */
> > >       u16 last;                       /* The last desc state in a list. */
> > > +     u64 buflen;                     /* In buffer length */
> > >  };
> > >
> > >  struct vring_desc_extra {
> > > @@ -490,6 +492,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > >       unsigned int i, n, avail, descs_used, prev, err_idx;
> > >       int head;
> > >       bool indirect;
> > > +     u64 buflen = 0;
> > >
> > >       START_USE(vq);
> > >
> > > @@ -571,6 +574,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > >                                                    VRING_DESC_F_NEXT |
> > >                                                    VRING_DESC_F_WRITE,
> > >                                                    indirect);
> > > +                     buflen += sg->length;
> > >               }
> > >       }
> > >       /* Last one doesn't continue. */
> > > @@ -605,6 +609,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > >
> > >       /* Store token and indirect buffer state. */
> > >       vq->split.desc_state[head].data = data;
> > > +     vq->split.desc_state[head].buflen = buflen;
> > >       if (indirect)
> > >               vq->split.desc_state[head].indir_desc = desc;
> > >       else
> > > @@ -784,6 +789,11 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> > >               BAD_RING(vq, "id %u is not a head!\n", i);
> > >               return NULL;
> > >       }
> > > +     if (unlikely(*len > vq->split.desc_state[i].buflen)) {
> > > +             BAD_RING(vq, "used len %d is larger than in buflen %lld\n",
> > > +                     *len, vq->split.desc_state[i].buflen);
> > > +             return NULL;
> > > +     }
> > >
> > >       /* detach_buf_split clears data, so grab it now. */
> > >       ret = vq->split.desc_state[i].data;
> > > @@ -1062,6 +1072,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> > >       unsigned int i, n, err_idx;
> > >       u16 head, id;
> > >       dma_addr_t addr;
> > > +     u64 buflen = 0;
> > >
> > >       head = vq->packed.next_avail_idx;
> > >       desc = alloc_indirect_packed(total_sg, gfp);
> > > @@ -1089,6 +1100,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> > >                       desc[i].addr = cpu_to_le64(addr);
> > >                       desc[i].len = cpu_to_le32(sg->length);
> > >                       i++;
> > > +                     if (n >= out_sgs)
> > > +                             buflen += sg->length;
> > >               }
> > >       }
> > >
> > > @@ -1141,6 +1154,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> > >       vq->packed.desc_state[id].data = data;
> > >       vq->packed.desc_state[id].indir_desc = desc;
> > >       vq->packed.desc_state[id].last = id;
> > > +     vq->packed.desc_state[id].buflen = buflen;
> > >
> > >       vq->num_added += 1;
> > >
> > > @@ -1176,6 +1190,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> > >       unsigned int i, n, c, descs_used, err_idx;
> > >       __le16 head_flags, flags;
> > >       u16 head, id, prev, curr, avail_used_flags;
> > > +     u64 buflen = 0;
> > >
> > >       START_USE(vq);
> > >
> > > @@ -1250,6 +1265,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> > >                                       1 << VRING_PACKED_DESC_F_AVAIL |
> > >                                       1 << VRING_PACKED_DESC_F_USED;
> > >                       }
> > > +                     if (n >= out_sgs)
> > > +                             buflen += sg->length;
> > >               }
> > >       }
> > >
> > > @@ -1268,6 +1285,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> > >       vq->packed.desc_state[id].data = data;
> > >       vq->packed.desc_state[id].indir_desc = ctx;
> > >       vq->packed.desc_state[id].last = prev;
> > > +     vq->packed.desc_state[id].buflen = buflen;
> > >
> > >       /*
> > >        * A driver MUST NOT make the first descriptor in the list
> > > @@ -1455,6 +1473,11 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> > >               BAD_RING(vq, "id %u is not a head!\n", id);
> > >               return NULL;
> > >       }
> > > +     if (unlikely(*len > vq->packed.desc_state[id].buflen)) {
> > > +             BAD_RING(vq, "used len %d is larger than in buflen %lld\n",
> > > +                     *len, vq->packed.desc_state[id].buflen);
> > > +             return NULL;
> > > +     }
> > >
> > >       /* detach_buf_packed clears data, so grab it now. */
> > >       ret = vq->packed.desc_state[id].data;
> > > --
> > > 2.25.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
