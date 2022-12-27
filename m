Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F2AC4332F
	for <virtualization@archiver.kernel.org>; Tue, 27 Dec 2022 03:51:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 890E04030A;
	Tue, 27 Dec 2022 03:51:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 890E04030A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zbt5aXqP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w0Ac7-hY4OWr; Tue, 27 Dec 2022 03:51:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D35D94030D;
	Tue, 27 Dec 2022 03:51:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D35D94030D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2082C0032;
	Tue, 27 Dec 2022 03:51:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 135EFC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 03:51:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CF5BF4031D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 03:51:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CF5BF4031D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zbt5aXqP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6pU3nLPKoFCO
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 03:51:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 15F55400D1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 15F55400D1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 03:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672113077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mjSoArX5HY6uv1LNJcQFkVTx4PMTjeA2EWxVBFBuH60=;
 b=Zbt5aXqP1AFbtiWITrYBIdakKYb6QGd7zwq/MctJdH7VFtMQqMYPAdGDqnM9hemLyEFb5u
 9WpC/NFJeNP1xcdUY0RB5U30OUWx06wwsjRODmtv5lnQBoD3fLy4szNTsTwESZnvaBPl4S
 NmMm4yc0bNe0NWWB2jZlE+AM4nNYj6I=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-42-lawO0JEvM7GNbSKhm9M_fA-1; Mon, 26 Dec 2022 22:51:14 -0500
X-MC-Unique: lawO0JEvM7GNbSKhm9M_fA-1
Received: by mail-ot1-f72.google.com with SMTP id
 y14-20020a0568301d8e00b00670641b451bso7228165oti.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 19:51:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mjSoArX5HY6uv1LNJcQFkVTx4PMTjeA2EWxVBFBuH60=;
 b=J8f6hwiByWOm4FRU6SCj1LxHLtUG5momV5+q9VlsY8iuzA2N13BSXKT82mz/bXQq5l
 ZTlcPltNp79qewr4ZeiPMsM4jJl0BRDwIbnuLgK85Gqj2kETKCqPVPgd3DAQy5RlOYmE
 DUqqto/PXE0ISmogt+y9yRvMlaBT3RZG+g9x00iP6G7LiaJUZPlsIMwXJKrC9nmy8dOC
 /mnAH4MWVmQOW1qvW7K886P8p+dN3g5o6rHE0PFjiXTRkvDsFUkoPCvjsviCkjHP8FL0
 BxftxrVWyJhs3srkv1Z3J3/z5f8hJOQlmCn3A/ljHpOMkpDC2LeWOUB+wDKokJqHR00N
 n9Tg==
X-Gm-Message-State: AFqh2kq1qega5cSF/g/ETtOElZhuvQ10Ov/UmrdDAbW25F+2N8wXRAf4
 GzgG5CNiySyEz5IXIzHhlgfC/l2VwRLbMAnk6M6v3Pu4n47QUhEqvm2QRKuKRO6plLZjLx3ygRL
 f1reSUBXyxz+TI6lqNwzW8Tr0qZ/DcWtbvRDJfBST7JhlluYE8cb6VTX4KQ==
X-Received: by 2002:a54:4e89:0:b0:35c:303d:fe37 with SMTP id
 c9-20020a544e89000000b0035c303dfe37mr721894oiy.35.1672113073652; 
 Mon, 26 Dec 2022 19:51:13 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsCulI1T5cwjq8wWoaycCdKJLT0V8hvvOPAQssypU3+1Le5l09BrAre+/+QUnsIsGezI46+6cqY0LXGqi1asRg=
X-Received: by 2002:a54:4e89:0:b0:35c:303d:fe37 with SMTP id
 c9-20020a544e89000000b0035c303dfe37mr721883oiy.35.1672113073448; Mon, 26 Dec
 2022 19:51:13 -0800 (PST)
MIME-Version: 1.0
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-3-jasowang@redhat.com>
 <20221226183604-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221226183604-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Dec 2022 11:51:02 +0800
Message-ID: <CACGkMEuv9+o4anxnE8xewEaFj5Sc+bn4OFDrHYR6jyxb+3ApGw@mail.gmail.com>
Subject: Re: [PATCH 2/4] virtio_ring: switch to use BAD_RING()
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, maxime.coquelin@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

On Tue, Dec 27, 2022 at 7:36 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Dec 26, 2022 at 03:49:06PM +0800, Jason Wang wrote:
> > Switch to reuse BAD_RING() to allow common logic to be implemented in
> > BAD_RING().
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> > Changes since V1:
> > - switch to use BAD_RING in virtio_break_device()
> > ---
> >  drivers/virtio/virtio_ring.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 2e7689bb933b..5cfb2fa8abee 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -58,7 +58,8 @@
> >       do {                                                    \
> >               dev_err(&_vq->vq.vdev->dev,                     \
> >                       "%s:"fmt, (_vq)->vq.name, ##args);      \
> > -             (_vq)->broken = true;                           \
> > +             /* Pairs with READ_ONCE() in virtqueue_is_broken(). */ \
>
> I don't think WRITE_ONCE/READ_ONCE pair as such. Can you point
> me at documentation of such pairing?

Introduced by:

commit 60f0779862e4ab943810187752c462e85f5fa371
Author: Parav Pandit <parav@nvidia.com>
Date:   Wed Jul 21 17:26:45 2021 +0300

    virtio: Improve vq->broken access to avoid any compiler optimization

I think it might still apply here since virtqueue_is_broken() is still
put into a loop inside wait_event().

Thanks

>
> > +             WRITE_ONCE((_vq)->broken, true);                       \
> >       } while (0)
> >  #define START_USE(vq)
> >  #define END_USE(vq)
> > @@ -2237,7 +2238,7 @@ bool virtqueue_notify(struct virtqueue *_vq)
> >
> >       /* Prod other side to tell it about changes. */
> >       if (!vq->notify(_vq)) {
> > -             vq->broken = true;
> > +             BAD_RING(vq, "vq %d is broken\n", vq->vq.index);
> >               return false;
> >       }
> >       return true;
> > @@ -2786,8 +2787,7 @@ void virtio_break_device(struct virtio_device *dev)
> >       list_for_each_entry(_vq, &dev->vqs, list) {
> >               struct vring_virtqueue *vq = to_vvq(_vq);
> >
> > -             /* Pairs with READ_ONCE() in virtqueue_is_broken(). */
> > -             WRITE_ONCE(vq->broken, true);
> > +             BAD_RING(vq, "Device break vq %d", _vq->index);
> >       }
> >       spin_unlock(&dev->vqs_list_lock);
> >  }
> > --
> > 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
