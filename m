Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2883C433F5
	for <virtualization@archiver.kernel.org>; Wed, 23 Feb 2022 07:50:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39530414CA;
	Wed, 23 Feb 2022 07:50:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aqgLmxeBpcXJ; Wed, 23 Feb 2022 07:50:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E6A68408E7;
	Wed, 23 Feb 2022 07:50:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98F09C0021;
	Wed, 23 Feb 2022 07:50:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7DE4C0011
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 07:50:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CDE814148B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 07:50:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N_6gmFSM88xc
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 07:50:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 01B5F408E7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 07:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645602622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=18/7L9IlK0MUSWEpBnnED7xfRcmw6buBtiFVEVIoIww=;
 b=MqeUYzTmyCeOzIYBmDHKdR9yS4eUGdhgF+Fs4t6p3/wQMZwAeHYvexQWlSuB9truomnE6E
 39Rot1gt7aLp+BTsOQCtHrA9PAcK3umaiJE7Dd/DNcYkYZ4dgVvFgYJTjMF6hz/76VuZHK
 Sy2tfKaD9sQrCk34WuGse31I7JkCqHI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-rXugmKuDPr2uv6hV8khHZQ-1; Wed, 23 Feb 2022 02:50:20 -0500
X-MC-Unique: rXugmKuDPr2uv6hV8khHZQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 20-20020a05651c009400b002462f08f8d2so5213050ljq.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 23:50:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=18/7L9IlK0MUSWEpBnnED7xfRcmw6buBtiFVEVIoIww=;
 b=taoi+szKgcemXoFuaOfF7gLGBGbJPy0r9L2PHehKVX8tOeQru+ABiETowZIRkIianq
 x0yLg5OnmJyOmaOtYthbjz72cGc4hj6Wlp3dHaYYwBgQvmA9rzocOSuqIBtot7q5WnRS
 SYodiwDWrPB9Futw5VF8M2QSrAiYfaTdQHlZTa4/Eo/9LdSBKp6Cnlv39KVYBCsJ9RbY
 y28ZE20/Ew6MGJvfoMtsn2yKXSiops6NcsFQoLD1F67NSr/Rimt3qUfK9SfL1WYA3euO
 2nxzMnDZBdIDN/d2vph7c6f0wJQPpKGjbb1zhxR/RWEKxU3Eo0V+K31RGopOLHp43bGc
 CknQ==
X-Gm-Message-State: AOAM530Vo52iNiUS+Ul8+yzvGyoY8f2ooftWt44gN3A6jRFwYQtfVWac
 ctrnx8bUDP+n40NZ/7WEoJktFs3NQXNmr1UckHy7CoNMNxFDIX1IFqvDH1nQKS7S8Aq6mMIFeNl
 M4hBjhLbd6GEI6u5DqFs1IChHsRGVmx58qjg32f6a08DC4OQQgQcR9+sHVA==
X-Received: by 2002:a2e:7a15:0:b0:236:deb2:1f74 with SMTP id
 v21-20020a2e7a15000000b00236deb21f74mr20100097ljc.315.1645602619240; 
 Tue, 22 Feb 2022 23:50:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXtXvHLakBc+SCeksBjaI5IBz4p+vdxHIOsU2WxMxmALaRHcCUrxNy5WT1Szp6b8RDwuFVxayNMXj5FW9I3GA=
X-Received: by 2002:a2e:7a15:0:b0:236:deb2:1f74 with SMTP id
 v21-20020a2e7a15000000b00236deb21f74mr20100087ljc.315.1645602619006; Tue, 22
 Feb 2022 23:50:19 -0800 (PST)
MIME-Version: 1.0
References: <20211108081324.14204-1-jasowang@redhat.com>
 <CACGkMEucnZPt_dhaSXCegeFE0gs=dSDfv7CJSq4HCW_4a4XfGg@mail.gmail.com>
 <20220223020452-mutt-send-email-mst@kernel.org>
 <CACGkMEu2UkOpGHJyKGzjJHMa3RmOoCmqD1iD_nh+pVcT63BQqA@mail.gmail.com>
In-Reply-To: <CACGkMEu2UkOpGHJyKGzjJHMa3RmOoCmqD1iD_nh+pVcT63BQqA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Feb 2022 15:50:07 +0800
Message-ID: <CACGkMEuu-Q83aBm0ijGr8AhP9C0tjxzvuHKvnY4HaArL5d2eoQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: aovid reading flag from the descriptor ring
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
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

On Wed, Feb 23, 2022 at 3:34 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Wed, Feb 23, 2022 at 3:08 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Feb 23, 2022 at 11:19:03AM +0800, Jason Wang wrote:
> > > On Mon, Nov 8, 2021 at 4:13 PM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > Commit 72b5e8958738 ("virtio-ring: store DMA metadata in desc_extra
> > > > for split virtqueue") tries to make it possible for the driver to not
> > > > read from the descriptor ring to prevent the device from corrupting
> > > > the descriptor ring. But it still read the descriptor flag from the
> > > > descriptor ring during buffer detach.
> > > >
> > > > This patch fixes by always store the descriptor flag no matter whether
> > > > DMA API is used and then we can avoid reading descriptor flag from the
> > > > descriptor ring. This eliminates the possibly of unexpected next
> > > > descriptor caused by the wrong flag (e.g the next flag).
> > > >
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > >
> > > Michael, any comment for this?
> > >
> > > Thanks
> >
> > I don't exactly see why we should care without DMA API, it seems
> > cleaner not to poke at the array one extra time.
>
> I think the answer is that we have any special care about the DMA API

I meant "we haven't had" actually.

Thanks

> for all other places that are using desc_extra.
>
> Thanks
>
>
> >
> > > > ---
> > > >  drivers/virtio/virtio_ring.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > index 00f64f2f8b72..28734f4e57d3 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -583,7 +583,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > > >         }
> > > >         /* Last one doesn't continue. */
> > > >         desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
> > > > -       if (!indirect && vq->use_dma_api)
> > > > +       if (!indirect)
> > > >                 vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
> > > >                         ~VRING_DESC_F_NEXT;
> > > >
> > > > @@ -713,7 +713,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> > > >         /* Put back on free list: unmap first-level descriptors and find end */
> > > >         i = head;
> > > >
> > > > -       while (vq->split.vring.desc[i].flags & nextflag) {
> > > > +       while (vq->split.desc_extra[i].flags & nextflag) {
> > > >                 vring_unmap_one_split(vq, i);
> > > >                 i = vq->split.desc_extra[i].next;
> > > >                 vq->vq.num_free++;
> > > > --
> > > > 2.25.1
> > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
