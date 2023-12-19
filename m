Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2CB1D529
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 14:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c4wnNRLk"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7EC2740470
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 14:37:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7EC2740470
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=c4wnNRLk
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tjPDclecgbYC
	for <virtualization@lists.linux-foundation.org>;
	Tue, 19 Dec 2023 14:37:21 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 23F7A40132
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 14:37:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 23F7A40132
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2cc6d9b4c6aso31821011fa.3
        for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 06:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702996639; x=1703601439; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iVTm9oZMtqSZBwJqdXJb3hYZoPtCTwqTZfX2l30DHE=;
        b=c4wnNRLkyj6C8exydF2PxihQjk4BzBHwXphcvdjKXRfErrzvjeRR0FuR5ycqvm2/yD
         xf5shAKQaa5vVtYcdNoXh9TgNS3YjtC2TlPirSHhWhi7v9vswlNiQIJRE4VLbn79pZOx
         RJCQiuZGSdjFDoakHUP1pzz5jXaWmUVjIhVho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702996639; x=1703601439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iVTm9oZMtqSZBwJqdXJb3hYZoPtCTwqTZfX2l30DHE=;
        b=KOG0h3LfYhKmiFnaseootjp/5vNntR+TbP3YCslrYB0S+3yjWYJNelVQXS751vs2xP
         KQSOLyrWfNea5tBREj1zKIIntW+8wSh/Zbz/DH4NJwRycyAvCVzDwuuNhKpY1VGn42Eb
         SWMr9UudcIkWlst2bu2CgOqDk/H4UqvJH+fm1RKsBbJ/KSUsMsKtL81yJC8Kn5QMI1UB
         6M5aP/kIrEr0k4ObixQHYYJwX+er+NzQHLTB3kDdVL9YsaBMZtSvAfd79qVUrUZ7YkpY
         V/4qiUxK9OyhqxcRQ9S/6D3p5jeLqJrM6Ztzhua7grqViqF139SHdRsNcVQEwHr/oYLK
         auVQ==
X-Gm-Message-State: AOJu0Yw6bDxdIhCnQrABhpAKnzzIVdbzrQ2KByHRBzcvxRLoy+xkMEyr
	4wOUTtblyvh3iWFmrE8nBB5sRCQZLVNvmJC6ULFr/w==
X-Google-Smtp-Source: AGHT+IF+H7kOVCN0x8tihXqTBGeYLFioCMUVffwheMbHBbtqT5BVKyYtINt45F1GTcg91mvhaJk51Q85tOmD548iLIo=
X-Received: by 2002:a2e:be8b:0:b0:2cc:6bf0:8ee with SMTP id
 a11-20020a2ebe8b000000b002cc6bf008eemr2117097ljr.81.1702996638780; Tue, 19
 Dec 2023 06:37:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231218151842.2756673-1-stevensd@google.com> <aae229d7-0675-47c5-9a02-5ba0b6a64906@redhat.com>
In-Reply-To: <aae229d7-0675-47c5-9a02-5ba0b6a64906@redhat.com>
From: David Stevens <stevensd@chromium.org>
Date: Tue, 19 Dec 2023 09:37:07 -0500
Message-ID: <CAD=HUj4jzxVB3=9kYVr+Y+3Ef2EUVztA4aVOXvha2zsCyzDGQQ@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_balloon: stay awake while adjusting balloon
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 12:33=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 18.12.23 16:18, David Stevens wrote:
> > From: David Stevens <stevensd@chromium.org>
> >
> > A virtio_balloon's parent device may be configured so that a
> > configuration change interrupt is a wakeup event. Extend the processing
> > of such a wakeup event until the balloon finishes inflating or deflatin=
g
> > by calling pm_stay_awake/pm_relax in the virtio_balloon driver. Note
> > that these calls are no-ops if the parent device doesn't support wakeup
> > events or if the wakeup events are not enabled.
> >
> > This change allows the guest to use system power states such as s2idle
> > without running the risk the virtio_balloon's cooperative memory
> > management becoming unresponsive to the host's requests.
> >
> > Signed-off-by: David Stevens <stevensd@chromium.org>
> > ---
> > v1 -> v2:
> >   - Use adjustment_signal_pending flag instead of a sequence number
> >   - Call pm_stay_awake/pm_relax on parent device instead of adding a wa=
ke
> >     event to the virtio balloon device
> >
> >   drivers/virtio/virtio_balloon.c | 57 +++++++++++++++++++++++++++-----=
-
> >   1 file changed, 47 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ba=
lloon.c
> > index 1fe93e93f5bc..a3c11159cbe0 100644
> > --- a/drivers/virtio/virtio_balloon.c
> > +++ b/drivers/virtio/virtio_balloon.c
> > @@ -119,6 +119,11 @@ struct virtio_balloon {
> >       /* Free page reporting device */
> >       struct virtqueue *reporting_vq;
> >       struct page_reporting_dev_info pr_dev_info;
> > +
> > +     /* State for keeping the wakeup_source active while adjusting the=
 balloon */
> > +     spinlock_t adjustment_lock;
> > +     bool adjustment_signal_pending;
> > +     bool adjustment_in_progress;
> >   };
> >
> >   static const struct virtio_device_id id_table[] =3D {
> > @@ -437,6 +442,31 @@ static void virtio_balloon_queue_free_page_work(st=
ruct virtio_balloon *vb)
> >       queue_work(vb->balloon_wq, &vb->report_free_page_work);
> >   }
> >
> > +static void start_update_balloon_size(struct virtio_balloon *vb)
> > +{
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&vb->adjustment_lock, flags);
> > +     vb->adjustment_signal_pending =3D true;
> > +     if (!vb->adjustment_in_progress) {
> > +             vb->adjustment_in_progress =3D true;
> > +             pm_stay_awake(vb->vdev->dev.parent);
> > +     }
> > +     spin_unlock_irqrestore(&vb->adjustment_lock, flags);
> > +
> > +     queue_work(system_freezable_wq, &vb->update_balloon_size_work);
> > +}
> > +
> > +static void end_update_balloon_size(struct virtio_balloon *vb)
> > +{
> > +     spin_lock(&vb->adjustment_lock);
> > +     if (!vb->adjustment_signal_pending && vb->adjustment_in_progress)=
 {
>
> How could vb->adjustment_in_progress ever not be set at this point?
>
> > +             vb->adjustment_in_progress =3D false;
> > +             pm_relax(vb->vdev->dev.parent);
> > +     }
> > +     spin_unlock(&vb->adjustment_lock);
> > +}
> > +
>
> LGTM, although I wonder what happens when calling pm_stay_awake() etc.
> on a parent device that is not wakeup-even-capable?

If the parent device is not wakeup capable or if wakeup isn't enabled,
then the vb->vdev->dev.parent->power.wakeup pointer will be NULL, so
the NULL checks in __pm_relax/__pm_stay_awake will immediately return.

-David
