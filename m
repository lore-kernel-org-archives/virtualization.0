Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD364331ECF
	for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 19:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785351995; cv=pass; b=gOnxq1z8DgCWLCaN8Uh+biR9NpZjmpuB6hIIhRtZM4KEICN8rA6g0BpLjiyvtyOqDWMe4WfWxdiqpskiTXyIJG18wlszMgtwuxGnW0M+MzepZiCGhWi0RGRYq3rBteSwtKsvttPuyTIdHR3RRKMHlemtqclUX+iJnoj6/cO5dYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785351995; c=relaxed/simple;
	bh=6WPhx8PReV46HTsCogkuoq6nCnjySOBHp1E70tMVQgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TUrfB+9so8dLtsihnkawQMgXnJIhlmAdgJkWKdqC/OqN9GyBpmUmxafWxO+j7IG8VI66ureCf2AwTw0PWA4hWP1ggiipZLeTP7YKPW0iQB1vm48L7jYWozoerZnIeLtpD6B4ZzRLQ40IpRDZVdOCe/T8nebehdAU+PTh03Ujhqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tD4H3sAI; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tD4H3sAI"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-69fc6a09b5aso2182483a12.3
        for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 12:06:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785351991; cv=none;
        d=google.com; s=arc-20260327;
        b=rtJCWD1/lTLSuckDlc55fMeNb7Ldjwkz9X6YWww3Uaa/4G1AA0FdI8FYSvwiY8dH33
         DyvLj40oQcTvGUCdfFNfdASuqVNksuNx9pJleWoJpHldNq06ZOb+LYhuW4ai7qKgZ2Rv
         x9qW4VxPVdo3Kf2kn293txpMuILoUFKawFcpQjiSqG1RqkH3eD0C5plgQ20/ROFG3dxp
         PujpOxYondlu0Jr2RMwbgc4n1mgVoDiUka/zWiJN7NSXkkinpcE7TOlwXeQo09Bcd1+m
         0GzE5VWyAYRsh13ZdZ/DuXazJTwlO2AbqMx2CqX17UHEIdlbYZOZBFOrKOm4c6S/+ePN
         vomg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xnnMp3bYdgLemtWGnJyzOun3f7Jn2r77yt762F4YIuA=;
        fh=Y9/aYE5xLXdCiMV1ucjgXGGyw7y0D7h9RZ8gvajL7Lg=;
        b=ZIvfBQFuV2WC8LysITHq2Hz7N+/ogD7gVJDVW/541CjPAlkJ79fJt7NzVO5C90q2bT
         vbXueZ4mI9koriGkpvuYACD3WXMDTc8IbPF+54KAqfd1vCqF+PvCjOq3/f7AxQUkPcTo
         jzBFKp9hRHwFZeMctGu3wEh0ueVW3eN/BJc0RUKDP3ylLJb+wg+QgLPed0R1tv/LpB1N
         DbBpAJPnf0/1QZ/KIsxhQMfd81ZXRo7B6Gz0jXQxDYJ6f04GuJ5Oxi/BiUELS3hlK8QG
         hSdTM7gojeEmrZiOufZ1BavkrAD1mVgSN3uYoP58Hm5qmOD4hI7/NZrn97uM3PTOEeLm
         ROow==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785351991; x=1785956791; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xnnMp3bYdgLemtWGnJyzOun3f7Jn2r77yt762F4YIuA=;
        b=tD4H3sAI9XvdQyFOH8O9AqQB8xDt7v3Kbpk6/qIny0Bdyjh9zx2PXrKo4kGGmuiOmL
         gVZDlQ6mIvNC5OjvBxfV7XxKaS5RpzZUc9IiJVvszSruePey/2522KPwbuxi0Zi6Cnf0
         E7RTieO7+FQbsu++Hwn0ZZ4tC9dDjFerlIm4vlZSn4bnZf0suHwelVTtv7yrNigyCqn0
         SMBM8wBwcL9DUk5HR+x/HJGYp/+ozLGI8vZObgKii5tbYHf5GmC5HSpLhvwggW7IKYTt
         foOvmIwbvXP4D8VJc8xP1RZmAWjFyzwlk0xoji5Z1+3UMzbI2vLwtnaptJtQ2tlDgRS1
         AOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785351991; x=1785956791;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xnnMp3bYdgLemtWGnJyzOun3f7Jn2r77yt762F4YIuA=;
        b=GQBaefUi5ELST1HMi8RoUxrTVoNHKqDAjCqbRh1GWqHt4Z+DpjzGxIFLtXek/VVdj/
         sgQrLaglOxCNXyOfQDiLS9wIq5JAG9ei8JUc3iYped+fj5eCrIPhF+Ha8mTGBJ6wswtY
         lD1HYPknpODcSXIJLqYOmtSvaiOvbf1bq4XUVZNatWRK2nlm1S+//lcPWAX5dRLs9cr+
         jQ6b0fScv+qVkW24y0eHWwUyxTJx44drjutIfLp8vJoWdf1oKgzfLmInT2TJhPJbIQat
         hmBeX6FOIp62KYsgCqQZxy0b4WKDeKsmr3RZsEKhaYR4yurs1s5AGnM7dLnF4NZOWVa+
         Hu1g==
X-Forwarded-Encrypted: i=1; AHgh+Rq4SKEbgTK6uE58QpKT7If1+hFqhfWJZj/Z9UTqXyScXoqQvbfc407DOAeu3eo02aqA4rzIF6tWTZQ77KqN+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxiTmJu//nceFxb4eHtT1WnI032fMm6ejpYJ1UmtsMiG7729QLw
	8dc7p/Ka2Iy64KgfG77Jgv/T4bNWeQ/55v+/BM0QORKbsUN69NCApv9K2yLEAm+II0qK6U3trsk
	B09dlPBiyka8aivTkAuD6ykAdToaeUbQ=
X-Gm-Gg: AR+sD11lJ+JZQzzYtF8sP+CS4puucuDymnG3bCCNe84WK1lvN4AUcZKMC1ipNzXgtPR
	9QFBmR6jODJT/M4QwnacO82cNsXAnDF93oHsw7LGj0lGk1/56+TFZQJoXy6I+Cc1eltvIoaNFaS
	C5x5jOAQl3YY6TXavkeDGUeb1hWDDfnKpmrywQTYYMBsjMjzEzSVxmqQoCGyA/Qfza1N0qT3siR
	zttZPRxsAFlpGRH0JwSF6W9RXPzsXGWda5D5PFfHJfU40bq+gJXWyKu1Psi0eda7YRnyfhMCuPT
	t5m8DkxZfp4EIieGXJYroCk0QwBKreE1lCYFA/hlsWho3ZXG8sAMPp76ILYMC7f/+XtMatCS/1Q
	=
X-Received: by 2002:a17:907:9802:b0:c1c:4d19:f733 with SMTP id
 a640c23a62f3a-c1f720eefe6mr463168666b.40.1785351990816; Wed, 29 Jul 2026
 12:06:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260727035804.1860862-1-bestswngs@gmail.com> <amjkQ2F+NEK9SPAj@devvm29614.prn0.facebook.com>
 <amoR0pnMO2OQ2E6z@sgarzare-redhat>
In-Reply-To: <amoR0pnMO2OQ2E6z@sgarzare-redhat>
From: Weiming Shi <thebestswings@gmail.com>
Date: Thu, 30 Jul 2026 03:05:53 +0800
X-Gm-Features: AUfX_mz3TgQR8C_4x8K7ZMCwqKKo1i2lXmGLm4XOyvkUGevFYGQ5eIt1hRXQEV0
Message-ID: <CANgPUi2LFBiBG1c7+s_AyzrtDdncXDXQQuphNqmC0uktvBY1dg@mail.gmail.com>
Subject: Re: [PATCH] vsock/virtio: prevent workers from using deleted virtqueues
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Stefano Garzarella <sgarzare@redhat.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=8829=
=E6=97=A5=E5=91=A8=E4=B8=89 22:47=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Jul 28, 2026 at 10:17:55AM -0700, Bobby Eshleman wrote:
> >On Sun, Jul 26, 2026 at 08:58:01PM -0700, Weiming Shi wrote:
> >> The RX, TX and event workers read their virtqueue pointers before taki=
ng
> >> the mutex that protects the queue and its run flag. A work item delaye=
d
> >> across freeze and restore can therefore retain a pointer deleted by
> >> virtio_vsock_vqs_del(), observe the run flag for the replacement queue=
s,
> >> and use the freed pointer.
> >>
> >> RX has an additional path: when rx_run is clear, the common exit still
> >> refills the RX queue. A queued worker can consequently call
> >> virtqueue_add_sgs() immediately after freeze deletes the virtqueues.
> >>
> >> BUG: KASAN: slab-use-after-free in virtqueue_add_sgs
> >> Read of size 4 by task kworker/2:1
> >> Workqueue: virtio_vsock virtio_transport_rx_work
> >> Call Trace:
> >>  virtqueue_add_sgs (drivers/virtio/virtio_ring.c:2796)
> >>  virtio_vsock_rx_fill (net/vmw_vsock/virtio_transport.c:332)
> >>  virtio_transport_rx_work (net/vmw_vsock/virtio_transport.c:701)
> >>  process_one_work (kernel/workqueue.c:3314)
> >>  worker_thread (kernel/workqueue.c:3478)
> >>  kthread (kernel/kthread.c:436)
> >>  ret_from_fork (arch/x86/kernel/process.c:158)
> >>  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
> >> ...
> >> Freed by task 141:
> >>  kfree (mm/slub.c:6566)
> >>  vp_del_vq (drivers/virtio/virtio_pci_common.c:259)
> >>  vp_del_vqs (drivers/virtio/virtio_pci_common.c:285)
> >>  virtio_vsock_freeze (net/vmw_vsock/virtio_transport.c:912)
> >>  virtio_device_freeze (drivers/virtio/virtio.c:658)
> >>  virtio_pci_freeze (drivers/virtio/virtio_pci_common.c:601)
> >>  pci_pm_freeze (drivers/pci/pci-driver.c:1098)
> >>  device_suspend (drivers/base/power/main.c:1968)
> >> Kernel panic - not syncing: KASAN: panic_on_warn set ...
> >>
> >> Read each worker's virtqueue under its mutex after confirming that the
> >> queue is running, and only refill RX while RX is running.
> >>
> >> Fixes: b917507e5ad9 ("vsock/virtio: stop workers during the .remove()"=
)
> >> Cc: stable@vger.kernel.org
> >> Reported-by: Xiang Mei <xmei5@asu.edu>
> >> Assisted-by: OpenAI-Codex:gpt-5
> >> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> >> ---
> >>  net/vmw_vsock/virtio_transport.c | 14 ++++++++------
> >>  1 file changed, 8 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_t=
ransport.c
> >> index 57f2d6ec3ffc..79cf19f58943 100644
> >> --- a/net/vmw_vsock/virtio_transport.c
> >> +++ b/net/vmw_vsock/virtio_transport.c
> >> @@ -346,12 +346,13 @@ static void virtio_transport_tx_work(struct work=
_struct *work)
> >>      struct virtqueue *vq;
> >>      bool added =3D false;
> >>
> >> -    vq =3D vsock->vqs[VSOCK_VQ_TX];
> >>      mutex_lock(&vsock->tx_lock);
> >>
> >>      if (!vsock->tx_run)
> >>              goto out;
> >>
> >> +    vq =3D vsock->vqs[VSOCK_VQ_TX];
> >> +
> >>      do {
> >>              struct sk_buff *skb;
> >>              unsigned int len;
> >> @@ -451,13 +452,13 @@ static void virtio_transport_event_work(struct w=
ork_struct *work)
> >>              container_of(work, struct virtio_vsock, event_work);
> >>      struct virtqueue *vq;
> >>
> >> -    vq =3D vsock->vqs[VSOCK_VQ_EVENT];
> >> -
> >>      mutex_lock(&vsock->event_lock);
> >>
> >>      if (!vsock->event_run)
> >>              goto out;
> >>
> >> +    vq =3D vsock->vqs[VSOCK_VQ_EVENT];
> >> +
> >>      do {
> >>              struct virtio_vsock_event *event;
> >>              unsigned int len;
> >> @@ -634,13 +635,13 @@ static void virtio_transport_rx_work(struct work=
_struct *work)
> >>              container_of(work, struct virtio_vsock, rx_work);
> >>      struct virtqueue *vq;
> >>
> >> -    vq =3D vsock->vqs[VSOCK_VQ_RX];
> >> -
> >>      mutex_lock(&vsock->rx_lock);
> >>
> >>      if (!vsock->rx_run)
> >>              goto out;
> >>
> >> +    vq =3D vsock->vqs[VSOCK_VQ_RX];
> >> +
> >>      do {
> >>              virtqueue_disable_cb(vq);
> >>              for (;;) {
> >> @@ -689,7 +690,8 @@ static void virtio_transport_rx_work(struct work_s=
truct *work)
> >>      } while (!virtqueue_enable_cb(vq));
> >>
> >>  out:
> >> -    if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
> >> +    if (vsock->rx_run &&
> >> +        vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
> >>              virtio_vsock_rx_fill(vsock);
> >>      mutex_unlock(&vsock->rx_lock);
> >>  }
> >> --
> >> 2.55.0
> >
> >Not a strong opinion from me, but since this last hunk is the one that
> >fixes the bug and the other hunks are moreso hardening, maybe break
> >these out into two patches?
>
> I think also the other hunks fix an issue, but I agree on the split
> since IMO we are fixing 2 different commits. Commit b917507e5ad9
> ("vsock/virtio: stop workers during the .remove()") was before
> freeze/resume added by commit bd50c5dc182b ("vsock/virtio: add support
> for device suspend/resume"). Only after that one we can have the false
> -> true transition of *_run variables.
>
> So IMO hunks 1-3 should have Fixes: bd50c5dc182b ... and hunk 4 should
> have Fixes: b917507e5ad9 ...
>
> That said, it's not a strong opinion here too, but if you prefer a
> single patch, please add both Fixes.
>
> Thanks,
> Stefano
>
> >
> >Besides, that all looks good to me.
> >
> >Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
> >
>

Thanks for your review. v2 sent.

Best,
Weiming Shi
