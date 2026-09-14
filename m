Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D3240EBAE
	for <virtualization@lists.linux.dev>; Mon, 14 Sep 2026 08:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789375182; cv=pass; b=eXm3atBc9jS5+Z8n8JVC2pawtTpK0f0IivtTtIX9w1bn4iYBuELVAiAR5iUCFOwtbkizNInAia8IZVqfbEneL1UG0NipeARFJZ48ma3jx/6tlyhszhlvbQcCLoXhy4i9S7CwNJgXqdaOvtefVyxMvbvHvMLdPlZgVJUqMxFK904=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789375182; c=relaxed/simple;
	bh=qcoMC/s+Yrc0wEY/iKMF45CQwVjH1i79yiWScSddz9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FfeQ/b3nIl5rub36BbjGbWX9cQ8dPzLZWe0l81HTYKhKmyS9duJebZosLc2XJZVsYs6uHERo42YcuMU5TnJoOEScQCUeAt4/xyUfjk2BA5qUfYgnhIKWQluvjQJDJNOlawUV7rPiz6AKeS/JDMFNbK3wqHBbz3Cs4/oJ94fUAkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rdn2Mnka; arc=pass smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rdn2Mnka"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-90e9ad1a373so36110566d6.0
        for <virtualization@lists.linux.dev>; Mon, 14 Sep 2026 01:39:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789375173; cv=none;
        d=google.com; s=arc-20260327;
        b=arw31okJsTHF1sbs5+dpjgwrN/N7eVoinzkt2OrVWCrDJ23is7tWnX/hg8GihnGaDx
         nNVPSPTRVW06rNyVAUAKQ2EpzPW2l3GqsLmSw40dFSKTNDJJGl9wCfVauqGU5DjYGaMW
         gHWJxhRZz1aKAYRmS6aHpXIEIvZLx6xM19j2Vh2ZVrrmTBWXQygmiUvyKRPVfU4Vfdvw
         22n4IVoJffxS6txdmboejrUwtkbL/8BrWBW0KmaRkFsdITF55eaNDDMUrBr1SeaOJ3BY
         C0cx8g9eSZu7TKDqu1dgCV5LUfKZx4B6XrsFIwd1R6G84g0SUSMR1JhKRx8zCxM0OZ+5
         T7uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l8ggFII5MyNYC9kvCPHSC1d8pjP/XE+f6UmrXyuFuNw=;
        fh=Gm9wmu1k8YqrdUHmcyzqJMq+MJRbGwMyGWRI+6dhf48=;
        b=lvXXAPInT06lSe36jkzymERrTAxB/Fz76KMr2HOeovWIgScdqcKeWgUglt2GnHr1b0
         00/KLrC6f7JX/2U499qrMtDOyYBmXcGd2/MAAmhuCbAApW7oumZycFkcHg28JwWnFj7R
         fyOxFGgIMvWBZI/wWAz9lYSNupiZiGH/fabYyYu5u1kRYvSOpYfudtPsm/qGYZa4VJyg
         EWDQV1FWG4WYliK4kbM9nILZ2l2qn5sQhbAJffmgtD1j7PpBnBvQOzXKX3RoBuBXCTL/
         3xLNvcVWWYMOaRLwt9CwgXJ8sT3FkCVrtNqDfG77+iqDJG9OPomsv7ESgKZziEMUZGrD
         4F1g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789375173; x=1789979973; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l8ggFII5MyNYC9kvCPHSC1d8pjP/XE+f6UmrXyuFuNw=;
        b=Rdn2MnkaBjLRc8WWIb2bi5VddCu9jUdvTf6cG5YKLsVngkFclmxxkFP8CMgMvYErgh
         /GD0Bb5e47N1DQDcNK/Ws91KVEru8+9hK+07W4pDcAkcV5imdw5ldW/r1XHqQMqA3/xm
         7zqZDS+qTQ2u1lRDY/ec4shifdywpWgf7SncZ/XCMUwpfBfBDqtZ9Nf9qtO0kwyy3uzs
         gZUDsg5W9u9cdbBm3+RLtZmtNvmkzusrSW2J7I5HdRsmWZ+i6m0Q3tQsfYKhq0a+DbJt
         HD6R3lY7Tspqqm7mBwDFi5qkjd1HoPDNCwHKTjLshJwIPNOYpy/FK9SrjY+apYt4Psgl
         S0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789375173; x=1789979973;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l8ggFII5MyNYC9kvCPHSC1d8pjP/XE+f6UmrXyuFuNw=;
        b=hW4eT6gpVMGw5Ra4e8V8hJEANNXL/zQnL9IHULBkYJr/7pieVRO4CgYfabB6Iupv9Q
         89LVu7A3FfwIkXzuD9QjiqFPWnuoDkXFWeGJqjL9SA1RjzmcZq2jVxYwnRsgJsO4jxbR
         dzN9zdD6jw5WpRpYhLNY8ZBr3pHcA70j4OQxUt2cS5nhoZi9ZZvY52/WMeMa4/4TV3MQ
         BhjVcX/M9Zttcu4kp1EPwvPzGka26+FeKM7tnNOTeqjTX2DDnRHySAQ1pBCKdTlEarXp
         QXjPRtGeYTaN0Er6zAaLWGnJqVjheXI/of6o6jGOWulI/UP0UH/IPWQU+GPzup0nsFos
         w2XQ==
X-Gm-Message-State: AFuF++mVkrrrc2ELb4XNZAjD23yhU9rMFelngsWRYcUcbrGM1RII3ByG
	9yXQSw79UEBCvvYz7decoeuBwVEyWbVXFzmR3brBQH6bSJTu+srn/KmnUQcVfdcdQe3QSzbmEV1
	RF5zMFWhPNj6JufeXkeEa95kyRaL4/SU=
X-Gm-Gg: AYBFou02c+zXTaYhb0/aSxO2JQqOvZVl4td7msYgLyfS3FWvFGfWp5yCXjevnmsfP0E
	dNxdPyeiCwKN/htFw8eZZSsRz0RU6mZuee0egdOEs9HpHidLudXz/LvrBiSMjGNCvu9XqFjivam
	ynkhIzPwGQ4lj7oClW1qZYjQ+hSr2ufvPnMQs8dZf2O+u0Ejhu3WqZJ00YznHiG7gkbPxiKpgrK
	g+vkdShaks4I6T+dUJm6T1kORwaqfxNIU95Aa3QFGc0WRVJx7MjgHKdPDACVbLf9DE+jSipm2MQ
	e0MKe7YgQL0kuDT1BxCUegapoEe8wc8QZEFFBZR9X11gYABykw0U0Mo=
X-Received: by 2002:a05:620a:63ca:b0:939:f1c2:7df7 with SMTP id
 af79cd13be357-93a187b5cf0mr518226885a.41.1789375173301; Mon, 14 Sep 2026
 01:39:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260912090420.47439-1-physicalmtea@gmail.com> <20260913090452.2B8221F00893@smtp.kernel.org>
In-Reply-To: <20260913090452.2B8221F00893@smtp.kernel.org>
From: Jia Jia <physicalmtea@gmail.com>
Date: Mon, 14 Sep 2026 16:38:57 +0800
X-Gm-Features: AcwNN1XVuYU0HUchoPplkYqW2a005r4W4YLv5OFcOP7MGcLCwxwN9odGIIkQaFk
Message-ID: <CAJwVaMKtk=PxFq330K8NBLRF7FzgcSu32vt1irLEJ7dSRQ5A_w@mail.gmail.com>
Subject: Re: [PATCH] vhost-scsi: do not relock event vq mutex on send_evt fallback
To: sashiko-reviews@lists.linux.dev
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	Eugenio Perez <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [Critical] vhost_scsi_do_evt_work() accesses vq->iov[out] without verif=
ying that the guest actually provided an input buffer, leading to arbitrary=
 user-space memory corruption.
> - [High] Events are processed in LIFO order instead of FIFO, which can ca=
use state corruption for hotplug/hotunplug sequences.
> --
>
> commit 05830c30fc2e4dc682c270a9b487ae5abb66218b
> Author: Jia Jia <physicalmtea@gmail.com>
>
> vhost-scsi: do not relock event vq mutex on send_evt fallback
>
> This commit resolves a deadlock during fallback event handling when the v=
host
> worker has disconnected. It splits event completion into an internal unlo=
cked
> helper and a locked wrapper to safely reuse the completion path.
>
> Link: https://lore.kernel.org/all/20260905005352.1E5B01F00A3D@smtp.kernel=
.org/
>
> > diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> > index 4f8c0260bc9e7..42abf18291b75 100644
> > --- a/drivers/vhost/scsi.c
> > +++ b/drivers/vhost/scsi.c
> > @@ -660,19 +660,26 @@ vhost_scsi_do_evt_work(struct vhost_scsi *vs, str=
uct vhost_scsi_evt *evt)
> >       vhost_scsi_log_write(vq, vq_log, log_num);
> >  }
> >
> > -static void vhost_scsi_complete_events(struct vhost_scsi *vs, bool dro=
p)
> > +/* Caller must hold the event virtqueue mutex. */
> > +static void __vhost_scsi_complete_events(struct vhost_scsi *vs, bool d=
rop)
> >  {
> > -     struct vhost_virtqueue *vq =3D &vs->vqs[VHOST_SCSI_VQ_EVT].vq;
> >       struct vhost_scsi_evt *evt, *t;
> >       struct llist_node *llnode;
> >
> > -     mutex_lock(&vq->mutex);
> >       llnode =3D llist_del_all(&vs->vs_event_list);
> >       llist_for_each_entry_safe(evt, t, llnode, list) {
>
> [Severity: High]
> This is a pre-existing issue, but does this loop deliver events to the gu=
est
> in reverse order?
>
> The events are added to vs_event_list using llist_add(), which constructs=
 a
> last-in, first-out list. Because lnode is retrieved locklessly with
> llist_del_all(), and the iteration happens without first calling
> llist_reverse_order(), the events appear to be processed from newest to
> oldest.
>
> Could this cause state corruption for hotplug and hotunplug sequences? Fo=
r
> example, if a device is plugged and then rapidly unplugged, the guest mig=
ht
> receive the unplug event first and the plug event second, leaving it
> erroneously believing the device is still present.
>

Looks like this could get the acquire order wrong? Need to verify.

> >               if (!drop)
> >                       vhost_scsi_do_evt_work(vs, evt);
>
> [Severity: Critical]
> This is a pre-existing issue, but can this function access out-of-bounds =
or
> stale memory if the guest provides an empty input buffer?
>
> Looking at vhost_scsi_do_evt_work() in drivers/vhost/scsi.c, the code use=
s
> vhost_get_vq_desc() which populates vq->iov:
>
>     head =3D vhost_get_vq_desc(vq, vq->iov,
>             ARRAY_SIZE(vq->iov), &out, &in,
>             vq_log, &log_num);
>     ...
>     if ((vq->iov[out].iov_len !=3D sizeof(struct virtio_scsi_event))) {
>         vq_err(vq, "Expecting virtio_scsi_event, got %zu bytes\n",
>                 vq->iov[out].iov_len);
>
> If a guest submits a descriptor chain with only read-only descriptors,
> vhost_get_vq_desc() sets in =3D 0. The out variable holds the count of
> read-only descriptors, meaning the first writable descriptor expected by =
the
> host would be at index out.
>

This is a dup -- an earlier patch already fixed it:
https://lore.kernel.org/all/20260904005240.502787-1-physicalmtea@gmail.com/
It was while fixing that earlier issue that Sashiko spotted this
adjacent problem.

> Does the length check above access vq->iov[out].iov_len without verifying
> that in > 0?
>
> If in is 0, vq->iov[out] was not populated by vhost_get_vq_desc() and
> contains stale data from a previous request. Could a malicious guest use
> this to force the kernel to write the event structure to a previously
> legitimate but now hot-unplugged host virtual address via the
> __copy_to_user() call later in the function?
>
> >               vhost_scsi_free_evt(vs, evt);
> >       }
> > +}
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912090420.47=
439-1-physicalmtea@gmail.com?part=3D1
