Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D313B813A
	for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 19:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352840; cv=pass; b=B7HXaQfjGHmTcSdDJts+f3A/uXyXGKThgaqmlerMN5dPbwrAaPco0sAhzMgOyPbipV7+3caL7wu7qj4Mz7KuuxfV/RjBOoDa0Xuw8XpGfoIIQ/sNtVLuiylF9YNHwV1nzWyqLbRHeYRxuVyv+3EY3NZoL0zdE7q2+Zwd6bK5hLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352840; c=relaxed/simple;
	bh=v39J0NNGbheOQbg9MTs7WdorPz5bwtfU4Pews8O/IIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mg33E6DjSPgZ8uRFpCj/hXanGGIPbOQQc/QMEH/8++Gp07WDTIOa1T4h8cUMxKAGsTi08i8aWaeDl+tDaU30NTKui2EA7QEQwWLsoylPFxR72ZbdrDZf5ORBlGLyKLlUH6DidBqGONi55rk9Cfx7hYeXOI+rTeTbe0SazSej8Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I82HX181; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I82HX181"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-699fbcd23ccso2059712a12.1
        for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 12:20:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785352830; cv=none;
        d=google.com; s=arc-20260327;
        b=SDvGZmFA7+X7I+GggMJ1AbtjX9QQSuvKOF8QevtQmjfwC3vE18aqP8oC7UhhWPpcDP
         Z9Oc/5JRThpPEwqmByu2vtz8tw1h5bRy6yEUHmYoct/Bh0V1IFA/NNwXZa+gOcvi7e7I
         Gfuocd1P4Rb4kOyCbOJfXwOmnjuXu2TeGg3acwq9lhW6aSULSmNwi8cAWxmmJ37sw27l
         97cAAsJWhKJ80yOqs1Dd/Amsg57RHnUVCHg+D8T1pCXfauJmLLYIpL78P+1vD9/+kVE/
         caWf1hn88axyAw9Dvh3TCo2b5MDY6u362R2QzmefEQqLRC7suo/KRuRUXvMfC3HUC0EZ
         z7NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NDSAww7eofhNwmhBo8NXZ9YQ6g85WKpVrD6PKX308GA=;
        fh=3MpXG+8+798CdniZcZCXycRKRCoy/tb3Xog5eC9gV7I=;
        b=Tlah8u1myXp8JacGqJ/Oj7wxhzrGXex/fEekrYlyW8xca+OrW9PsvfVbW9u2Qs2fT8
         S/we5EKWZgyor0RcA+oXs92dmj4DDnBAeA0NAzWHvFM4NucDVdNnLv77PmLDAj5mF3b8
         gTRIMURpk5Tskk7ty3ovgOUvo1c3Xnsi7KfhTjGOKMLJCpCDjXbqyRD810BOYJdYGQ9G
         qde8E2JhhIK/jdxz2f+KUDZf/gz9duTeVQOaNQzLRLytp9XYfrmqQwvWRH+13OVvlqWH
         E7Y3UuuXVCICE/7om5c56DVqKcF/ZFMW7n4AOVYd00RPMZrQuMo9o5Y3ep3yvM2SECQA
         0UWg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785352830; x=1785957630; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NDSAww7eofhNwmhBo8NXZ9YQ6g85WKpVrD6PKX308GA=;
        b=I82HX181IlbJGXvwOxIUeJdIogPwVbOBLqDlMGORrOMX5lMHOzdjbYvsV5ZYc0f8vX
         +NzX5N8tPCuTzzqZCYUvwuK/5rNtIVTwEHTYvSlZi1jScNiITQ+Te3uunchSpgdC0OBl
         byG9oWh69Qyye5OYa2ciOUdnY+cmlUzMypZPrv9sru1B1Kn2DR4N6RRphw1fqWVNn4/3
         XKR+C5B7LParj7kplUTyjT5W7DwEYsu8LLmf1baLNBCeLL3/tjlaDIe+BswRk3W1XtDc
         i8O4dGNE92mLyH7zQq/Odlv31O3NmmCWMIsHys7GpLlMKu5EUqHswbfyzFbPa/K8ZuH+
         zBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785352830; x=1785957630;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NDSAww7eofhNwmhBo8NXZ9YQ6g85WKpVrD6PKX308GA=;
        b=Oica8UAt4OHwU5/6mRXPmUyY0f0iGx3jr4+/JuuTy0eq2jTCDoSbNum1/clD5iV71b
         1HAe5RxXf58vQiq8kWNyXiCCKzLBIsWEIlcsl9B8+stFvXSdku+CxwS6P88ggOj+twWK
         v5HNwUW5LASSugJNlojwgGItDpR47xyUItJWikU0eielrfnt///9M60RXDhdIxk7LJSN
         Nm+Ig2XTJHgW3qeJN+Mv6Cb2eTYUciIOLxGG7UVcWA07C5iiGGmpiIbUw6WPjXX8kf7T
         Ot27uKmEV9x83JEXY4mABw9D+N+X7kpiip0qlL0AxKWSr+09FuGfd2joZCuN98QdqbeM
         jQSA==
X-Forwarded-Encrypted: i=1; AHgh+Rr4biO9LlR618mSlhoOMWyDHLzwKHz/C+oeATKYSrnLhjxInCMHziWRUEIGefkwruphmAO24J5O9dBDqubwpg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdLnjmbShmFT81TDU0O09QYEVDdAVPZiG3UacFSFhHuhRGNe01
	q/DoRHnoVYTlpXPGAHShBkVg4iXtJncuM841QZUCBX84ppdXyZFzI/duehDQpgP/0Lj7smtdczB
	cIzsfDyalaUqbyN7kWflAaEW542L1tB0=
X-Gm-Gg: AR+sD13X/7q0qwUTCsudwN2yZPCJUZEn6mQzzuDjQ/Gt2DKqQa3H5DE0zXWHiJBJn5f
	nyMGQa99zMHnZlwqbups/OGk3IMWTgmO6257NT3JQcrr9n5ONZ4B+52fc9MmPm9gGSgEOfqxxdh
	t1hcXL6fSkBKBzDl4Aw/Aqo+B1K2ZJZfDfshPtcW+7Tce2sfX/PF2Tws0iCXWW9paucZGfMbddu
	sDlcpuFEDobb7MxHWzoQo+j9vhvUWZHwzgYeM79mr2RPHCBPyBwTQilI/4K2nr0qJEIw3cSXPy3
	eiZ6mI1fscgxnnoSu+VGli4TsMjC3LhlHXyyyGz66W21dkpS5mYP/NGsQqTvMkKIEwl2fO5p3RQ
	=
X-Received: by 2002:a17:906:6a0c:b0:c1f:922d:34c3 with SMTP id
 a640c23a62f3a-c1f922d3b72mr205963066b.14.1785352829519; Wed, 29 Jul 2026
 12:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260727035804.1860862-1-bestswngs@gmail.com> <amjkQ2F+NEK9SPAj@devvm29614.prn0.facebook.com>
 <amoR0pnMO2OQ2E6z@sgarzare-redhat> <CANgPUi2LFBiBG1c7+s_AyzrtDdncXDXQQuphNqmC0uktvBY1dg@mail.gmail.com>
In-Reply-To: <CANgPUi2LFBiBG1c7+s_AyzrtDdncXDXQQuphNqmC0uktvBY1dg@mail.gmail.com>
From: Weiming Shi <thebestswings@gmail.com>
Date: Thu, 30 Jul 2026 03:19:52 +0800
X-Gm-Features: AUfX_myMxXtcqQ9SsdbccjfyUGE7H8t5bNEP8VjBISktONh9Fw_cte5ZVhUeiaQ
Message-ID: <CANgPUi3oUVf12GzPAWTX_3G6rEAssf6UwZi6dm7wW_YPjaMzmg@mail.gmail.com>
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

Weiming Shi <thebestswings@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=8830=E6=
=97=A5=E5=91=A8=E5=9B=9B 03:05=E5=86=99=E9=81=93=EF=BC=9A
>
> Stefano Garzarella <sgarzare@redhat.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=88=
29=E6=97=A5=E5=91=A8=E4=B8=89 22:47=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Tue, Jul 28, 2026 at 10:17:55AM -0700, Bobby Eshleman wrote:
> > >On Sun, Jul 26, 2026 at 08:58:01PM -0700, Weiming Shi wrote:
> > >> The RX, TX and event workers read their virtqueue pointers before ta=
king
> > >> the mutex that protects the queue and its run flag. A work item dela=
yed
> > >> across freeze and restore can therefore retain a pointer deleted by
> > >> virtio_vsock_vqs_del(), observe the run flag for the replacement que=
ues,
> > >> and use the freed pointer.
> > >>
> > >> RX has an additional path: when rx_run is clear, the common exit sti=
ll
> > >> refills the RX queue. A queued worker can consequently call
> > >> virtqueue_add_sgs() immediately after freeze deletes the virtqueues.
> > >>
> > >> BUG: KASAN: slab-use-after-free in virtqueue_add_sgs
> > >> Read of size 4 by task kworker/2:1
> > >> Workqueue: virtio_vsock virtio_transport_rx_work
> > >> Call Trace:
> > >>  virtqueue_add_sgs (drivers/virtio/virtio_ring.c:2796)
> > >>  virtio_vsock_rx_fill (net/vmw_vsock/virtio_transport.c:332)
> > >>  virtio_transport_rx_work (net/vmw_vsock/virtio_transport.c:701)
> > >>  process_one_work (kernel/workqueue.c:3314)
> > >>  worker_thread (kernel/workqueue.c:3478)
> > >>  kthread (kernel/kthread.c:436)
> > >>  ret_from_fork (arch/x86/kernel/process.c:158)
> > >>  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
> > >> ...
> > >> Freed by task 141:
> > >>  kfree (mm/slub.c:6566)
> > >>  vp_del_vq (drivers/virtio/virtio_pci_common.c:259)
> > >>  vp_del_vqs (drivers/virtio/virtio_pci_common.c:285)
> > >>  virtio_vsock_freeze (net/vmw_vsock/virtio_transport.c:912)
> > >>  virtio_device_freeze (drivers/virtio/virtio.c:658)
> > >>  virtio_pci_freeze (drivers/virtio/virtio_pci_common.c:601)
> > >>  pci_pm_freeze (drivers/pci/pci-driver.c:1098)
> > >>  device_suspend (drivers/base/power/main.c:1968)
> > >> Kernel panic - not syncing: KASAN: panic_on_warn set ...
> > >>
> > >> Read each worker's virtqueue under its mutex after confirming that t=
he
> > >> queue is running, and only refill RX while RX is running.
> > >>
> > >> Fixes: b917507e5ad9 ("vsock/virtio: stop workers during the .remove(=
)")
> > >> Cc: stable@vger.kernel.org
> > >> Reported-by: Xiang Mei <xmei5@asu.edu>
> > >> Assisted-by: OpenAI-Codex:gpt-5
> > >> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > >> ---
> > >>  net/vmw_vsock/virtio_transport.c | 14 ++++++++------
> > >>  1 file changed, 8 insertions(+), 6 deletions(-)
> > >>
> > >> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio=
_transport.c
> > >> index 57f2d6ec3ffc..79cf19f58943 100644
> > >> --- a/net/vmw_vsock/virtio_transport.c
> > >> +++ b/net/vmw_vsock/virtio_transport.c
> > >> @@ -346,12 +346,13 @@ static void virtio_transport_tx_work(struct wo=
rk_struct *work)
> > >>      struct virtqueue *vq;
> > >>      bool added =3D false;
> > >>
> > >> -    vq =3D vsock->vqs[VSOCK_VQ_TX];
> > >>      mutex_lock(&vsock->tx_lock);
> > >>
> > >>      if (!vsock->tx_run)
> > >>              goto out;
> > >>
> > >> +    vq =3D vsock->vqs[VSOCK_VQ_TX];
> > >> +
> > >>      do {
> > >>              struct sk_buff *skb;
> > >>              unsigned int len;
> > >> @@ -451,13 +452,13 @@ static void virtio_transport_event_work(struct=
 work_struct *work)
> > >>              container_of(work, struct virtio_vsock, event_work);
> > >>      struct virtqueue *vq;
> > >>
> > >> -    vq =3D vsock->vqs[VSOCK_VQ_EVENT];
> > >> -
> > >>      mutex_lock(&vsock->event_lock);
> > >>
> > >>      if (!vsock->event_run)
> > >>              goto out;
> > >>
> > >> +    vq =3D vsock->vqs[VSOCK_VQ_EVENT];
> > >> +
> > >>      do {
> > >>              struct virtio_vsock_event *event;
> > >>              unsigned int len;
> > >> @@ -634,13 +635,13 @@ static void virtio_transport_rx_work(struct wo=
rk_struct *work)
> > >>              container_of(work, struct virtio_vsock, rx_work);
> > >>      struct virtqueue *vq;
> > >>
> > >> -    vq =3D vsock->vqs[VSOCK_VQ_RX];
> > >> -
> > >>      mutex_lock(&vsock->rx_lock);
> > >>
> > >>      if (!vsock->rx_run)
> > >>              goto out;
> > >>
> > >> +    vq =3D vsock->vqs[VSOCK_VQ_RX];
> > >> +
> > >>      do {
> > >>              virtqueue_disable_cb(vq);
> > >>              for (;;) {
> > >> @@ -689,7 +690,8 @@ static void virtio_transport_rx_work(struct work=
_struct *work)
> > >>      } while (!virtqueue_enable_cb(vq));
> > >>
> > >>  out:
> > >> -    if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
> > >> +    if (vsock->rx_run &&
> > >> +        vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
> > >>              virtio_vsock_rx_fill(vsock);
> > >>      mutex_unlock(&vsock->rx_lock);
> > >>  }
> > >> --
> > >> 2.55.0
> > >
> > >Not a strong opinion from me, but since this last hunk is the one that
> > >fixes the bug and the other hunks are moreso hardening, maybe break
> > >these out into two patches?
> >
> > I think also the other hunks fix an issue, but I agree on the split
> > since IMO we are fixing 2 different commits. Commit b917507e5ad9
> > ("vsock/virtio: stop workers during the .remove()") was before
> > freeze/resume added by commit bd50c5dc182b ("vsock/virtio: add support
> > for device suspend/resume"). Only after that one we can have the false
> > -> true transition of *_run variables.
> >
> > So IMO hunks 1-3 should have Fixes: bd50c5dc182b ... and hunk 4 should
> > have Fixes: b917507e5ad9 ...
> >
> > That said, it's not a strong opinion here too, but if you prefer a
> > single patch, please add both Fixes.
> >
> > Thanks,
> > Stefano
> >
> > >
> > >Besides, that all looks good to me.
> > >
> > >Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > >
> >
>
> Thanks for your review. v2 sent.
>
> Best,
> Weiming Shi

Sorry for the noise; I resent the series as v3 with proper threading
and no code changes.

https://lore.kernel.org/all/cover.1785352330.git.bestswngs@gmail.com/
