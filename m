Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311E53CBE79
	for <virtualization@lists.linux.dev>; Tue,  1 Sep 2026 02:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788229670; cv=pass; b=k8YNMVhHmSUHJTH7j8iJu0pWgInZnkJyacLzsDettHcbwOdVh9xoobU9Adp4UDsrR8l5GnpUTbK4wvFN8L7krbLj0sETQlWzoFJhk9vimnidkQR4HrDZfFHcvs9hcZNOU8XRVLwmpm5CJffwKrELTc7HLRiXWSrvyVFNJg4Lhu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788229670; c=relaxed/simple;
	bh=PN/UjImC7bgd865J9BP2KD4atjXNWpj+MALMnuPZKh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RqafYhHNTRzvy2CDFG1NFyIMAXB7r7RcA/IeXWwFn3HiJmF7Elktq3rGJSSnaS60a5V5dX1oB6+lq6yWRTCFLeZcO+UIWf30UaUT4rXigJrk9fFqg+f5TX9CW+YBgR7B4++vyS+xNbQOoD1Xdexq5fPHG+s+WGoDG9N5Yn5nnLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=healnj8T; arc=pass smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="healnj8T"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-934956bee57so576913585a.2
        for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 19:27:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788229667; cv=none;
        d=google.com; s=arc-20260327;
        b=GYCf003hUu1TJfA5O6jXzv+fUNCGv1NZHtvuUjSxjFwMOyEE3z0Mz+/PbFiV/zQ+NL
         ipf8MPnNKj5BavpSIs8X0mYTwmcBjgEvK5P78gaCGyLnXjKgHSfPsEAvnISnd8XoJa8N
         3QmeSfMcQqwbqBOtMvLLAQq5q6Kmdpq8iciti/lsytDi/dF+/BOOPOA8L7nMiY5Wa2uL
         LF2uF6Tn8pON1zlQI0QlBHsM2MdDIBfuMxNn/PsYYGRbfFpA9KrRaEBCcVN++YrasZAp
         +LLQUL1/2dwh3HVqbqSYB48+15W214tJTauzbeJ/Tqmv7dXP5ntywXvNeLM3CR0o1jUc
         z1+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DIwG3h1DWr4hnTm8Um8YYeq8VR9qYUjCZHlufcU+1bY=;
        fh=JlYjlSHVkFMUQ7PzcHu4jRiTaZjFP4GLh7WgW+bybC0=;
        b=CcEM5VKJKwosfk1UAqThku5zcxQCr4SYaOlmczga2tKeU70QvnnSyw52igLNJWP/jL
         1pRjsAeDAV47qv7cN5FsRsQHH8eKyGUjxbh6xZtLmSU2Y3Vqoo9u//ME53JOBApBoGec
         ab0d+s8lxgMu7MvQsX+MnYQjVWxih/2QaPMsysNalrZz8Zq48KRT6mTX7kNOi1FnD1/V
         xNuYG56SI6mxeWOIId5akQpVYqkITuLsvaebszQlAKCgqLK915Qk5cfSBXrZBXIHCcEn
         vG3VAniOzLVKhH5u+wmHzMa6OZBaWsNEP2v/jHtyd4a7liHW4nzTcUSB7n2GfwmZFxDM
         sFfQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788229667; x=1788834467; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DIwG3h1DWr4hnTm8Um8YYeq8VR9qYUjCZHlufcU+1bY=;
        b=healnj8TH/i1rTv2stdVYhdAAv8IdLa+CUGyU/uQV0gcYb7p/5K7xbCUpyTn7QO8mu
         jh6pdNHMISdZsmMdguAeMbHk64XWGm6gvRHxJP+y1/5CZMnNm8Q7ids9jf2BnjHHSQ17
         p45x9LMg6uUynttopwN3BJsUKxbkzPkk18xkdQQb21391cvTcPtWUH2ym2rB/8NMgpbm
         d8cOzrvoIhGeDwJJEiJ2aBvTdjeyGmfq0YbCMlEyFkJAvnfjOdd7eVmTjuJyQ9K4C8Ea
         8Og/DJVencKiF1VsjrHxzKoWwODCE9NxMHHNf09yJKKQQUs74LJWR7xGB9GpZTj6k6kT
         oR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788229667; x=1788834467;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DIwG3h1DWr4hnTm8Um8YYeq8VR9qYUjCZHlufcU+1bY=;
        b=iLEKcSSC6iKwS9an5utDCx8G4aIhHiCR76BNWSo1lvNA/E6hQCazYiFcc9akSwqS/3
         OcfaBX1MKlfOT3cQIiST4C4xHr8w5KHtGTuZp5OYQC3vdeirFehXOqvd2DzpSS9Jx3ZW
         RE91mmb6k0CSb/oxCoWtUIVq+jhxdSP7Ubm+b3No996wtfx49XXCL6E2we3s5wMHbfJe
         Ppi3Fi6877LHUoobDt6/nacOPi8p5TpqB4dQu7GDqCIgnLkNARxEiKg50f+7idqjc5za
         PnJXZ95QEGzP1bS3B4Ugi31V+V8DAHHsxev/nV87XqwiWTBffLIxQB90cx7KI8y4b6AI
         y6gA==
X-Forwarded-Encrypted: i=1; AHgh+Rr3JAezcnSBVuWjqbB/jKsu4v0PQHOGeaeQFPQAYLNvA0fVWQWJBv93on+Qe1MdOiBvSUp0CXVRj53t1dFRQQ==@lists.linux.dev
X-Gm-Message-State: AFuF++m2tGdrUAKPRiVn5PMfZ2aZGvbQGLYLpXQgtx18sG9f4CjbRcxj
	rYHabk+QhMHSKHSyUq9wq54LNDpCXxgSPZln4/89se4FJJuVMCOstnpuGpEgB5L1X4KDvgZbRty
	DJ82vgOuI06S0ehTtZaIkG17c/vGhBko=
X-Gm-Gg: AR+sD10D6NAO+CJqmmckcq/UjdSrybOSxqoF4IXZa4crxWRxhGz7xDChD3kBWSd0bfN
	aHEWX7B0gOBQWu9ZAWOUCnTxgTuyIkX4m/PEu5Dw0/5D4amIZvLDYBb2LHOlTW2vOU9Uf5kZ5VY
	Sbp3C+Ikx4TmGZ/TyC6dIYLR0limkRn2isr40nzcdJusmFxJKxEr/UaMJrWk14aorXTwxmvjB+C
	w8NnsKE8HLedwKwrtUE/XyTEtrGEhZpYcAwtb6WCKBD12YKkXaHmG2p4/pwNvCWn7E3SRyMFEiz
	+tqX44nAaw143FDA4zmwQXFAAq9o3tCiBlCWLeoBWXet
X-Received: by 2002:a05:620a:172b:b0:939:32ea:9f0c with SMTP id
 af79cd13be357-93932eaa334mr1720744085a.8.1788229666903; Mon, 31 Aug 2026
 19:27:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260827055850.26951-1-physicalmtea@gmail.com> <CAJaqyWfjjSe19z4TrPbJfBBQZJXuAzqE4H8bik6UAiSgogzfmQ@mail.gmail.com>
In-Reply-To: <CAJaqyWfjjSe19z4TrPbJfBBQZJXuAzqE4H8bik6UAiSgogzfmQ@mail.gmail.com>
From: Jia Jia <physicalmtea@gmail.com>
Date: Tue, 1 Sep 2026 10:27:11 +0800
X-Gm-Features: AcwNN1X8xFc3zj4Mx5oZW-ZuOM04e_bQ28qEh0Tx7DrEEEAOGAyocsDW-QjEdZI
Message-ID: <CAJwVaMJ5Lc0J1M-+QAHH9w_tcrjNYDqOTbkAWUucCK4_50ay-g@mail.gmail.com>
Subject: Re: [PATCH] vhost/vsock: batch RX used-ring updates
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> On Thu, Aug 27, 2026 at 7:59=E2=80=AFAM Jia Jia <physicalmtea@gmail.com> =
wrote:
> >
> > vhost_transport_do_send_pkt() calls vhost_add_used() for every Guest RX
> > buffer even though it delays the Guest signal until the worker finishes=
.
> > Each call publishes one used entry and updates the used index separatel=
y.
> >
> > Collect the completed buffer heads in the arrays already allocated for =
the
> > virtqueue and publish them with vhost_add_used_n().  Bound the batch by=
 the
> > ring size, array capacity, and worker packet budget.  Flush before
> > re-enabling notifications or leaving the worker.
> >
> > Each used entry describes one completed RX buffer and keeps its actual =
used
> > length, so set nheads to 1 for every entry.  This patch does not change
> > negotiated features or compress multiple buffers into one used entry.
> >
> > This patch is limited to the current skb-based vhost-vsock RX path.
> >
> > Performance:
> >
> > Tested with a QEMU/KVM guest on a host with 4 online CPUs, using 2 vCPU=
s
> > pinned to host CPUs 2 and 3, QEMU 10.2.1, q35, 1536 MiB, and Linux
> > 7.2.0-rc3-next-20260713-next-debug-kasan.  The vhost-vsock source is ba=
sed
> > on linux-next master at 49362394dad7df66c274c867a271394c10ca2bb8.
> >
> > Current vhost-vsock does not implement VIRTIO_F_IN_ORDER or
> > VIRTIO_F_RING_PACKED, so both configurations used packed=3Doff and
> > in_order=3Doff:
> >
> >   baseline:                 RX batching=3Doff
> >   vhost-vsock RX batching:  RX batching=3Don
> >
> > The test used vsock_perf.  The Guest receiver was started with:
> >
> >   vsock_perf --port PORT --buf-size 64M --vsk-size 64M --rcvlowat 1
> >
> > The Host sender was started with:
> >
> >   vsock_perf --sender 3 --port PORT --bytes BYTES \
> >       --buf-size SEND_BUF --vsk-size 64M
> >
> > Each workload transferred BYTES=3D1 GiB.  The SEND_BUF values were 256 =
B
> > (SEND_BUF=3D256), 512 B (SEND_BUF=3D512), 4 KiB (SEND_BUF=3D4K), and 64=
 KiB
> > (SEND_BUF=3D64K).
> > Each state used a fresh Guest.  Each workload uses 20 paired runs, with=
 10
> > runs in each order.  The reported values are
> > Guest RX throughput in Gbits/s.  The baseline and batching columns are =
the
> > geometric means over the 20 runs; change is batching / baseline - 1,
> > computed from the unrounded values:
> >
> >   workload   baseline RX    batching RX   change   faster
> >   256 B      0.0795724      0.0831509      +4.497%  20/20
> >   512 B      0.1194885      0.1210297      +1.290%  14/20
> >   4 KiB      0.7208273      0.7242053      +0.469%  11/20
> >   64 KiB     2.1712797      2.1951941      +1.101%  13/20
> >
> > For reference, the table below gives the 95% normal-approximation inter=
vals
> > obtained from the 20 paired log(batching / baseline) values:
> >
> >   workload   paired 95% interval
> >   256 B      +3.985% to +5.011%
> >   512 B      +0.206% to +2.385%
> >   4 KiB      -1.442% to +2.416%
> >   64 KiB     -1.474% to +3.745%
> >
> > All transfers passed byte-count checks, and no kernel errors were obser=
ved
> > in the logs.  The 256-byte workload improved in every pair.  The 512 B
> > workload was faster in 14 of 20 pairs, with a small gain.  The 4 KiB an=
d
> > 64 KiB workloads showed no material throughput change; the difference
> > between their results may be due to scheduling and execution variation.
> >
> > Link: https://lore.kernel.org/r/20181214082146-mutt-send-email-mst@kern=
el.org
> > Link: https://lore.kernel.org/r/20220901055434.824-4-qtxuning1999@sjtu.=
edu.cn
> > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > ---
> >  drivers/vhost/vsock.c | 41 +++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 39 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > index 9aaab6bb8..d8050cca2 100644
> > --- a/drivers/vhost/vsock.c
> > +++ b/drivers/vhost/vsock.c
> > @@ -103,12 +103,37 @@ static bool vhost_transport_has_remote_cid(struct=
 vsock_sock *vsk, u32 cid)
> >         return found;
> >  }
> >
> > +static bool vhost_vsock_flush_used(struct vhost_virtqueue *vq,
> > +                                  unsigned int *used_count)
> > +{
> > +       if (!*used_count)
> > +               return false;
> > +
> > +       vhost_add_used_n(vq, vq->heads, vq->nheads, *used_count);
> > +       *used_count =3D 0;
> > +       return true;
> > +}
> > +
>
> I think that the used_count should be updated by the caller based on
> the boolean returned by this function.
>

Thanks for the review. I will fix this in v2.

> > +static void vhost_vsock_add_used(struct vhost_virtqueue *vq,
> > +                                unsigned int *used_count,
> > +                                unsigned int head, unsigned int len)
> > +{
> > +       struct vring_used_elem *used =3D &vq->heads[*used_count];
> > +
> > +       used->id =3D cpu_to_vhost32(vq, head);
> > +       used->len =3D cpu_to_vhost32(vq, len);
> > +       vq->nheads[*used_count] =3D 1;
> > +       (*used_count)++;
> > +}
>
> Same here, why pass it as an argument? The caller knows way better.

I will fix this in v2.

>
> Other than that, the patch looks good to me,
>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> Thanks!
>

Thanks!

> > +
> >  static void
> >  vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> >                             struct vhost_virtqueue *vq)
> >  {
> >         struct vhost_virtqueue *tx_vq =3D &vsock->vqs[VSOCK_VQ_TX];
> >         int pkts =3D 0, total_len =3D 0;
> > +       unsigned int used_count =3D 0;
> > +       unsigned int used_limit;
> >         bool added =3D false;
> >         bool restart_tx =3D false;
> >
> > @@ -120,6 +145,12 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vs=
ock,
> >         if (!vq_meta_prefetch(vq))
> >                 goto out;
> >
> > +       used_limit =3D min_t(unsigned int, vq->num,
> > +                          min_t(unsigned int, vq->dev->iov_limit,
> > +                                vq->dev->weight));
> > +       if (unlikely(!used_limit))
> > +               goto out;
> > +
> >         /* Avoid further vmexits, we're already processing the virtqueu=
e */
> >         vhost_disable_notify(&vsock->dev, vq);
> >
> > @@ -134,9 +165,13 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vs=
ock,
> >                 u32 offset;
> >                 int head;
> >
> > +               if (used_count =3D=3D used_limit)
> > +                       added |=3D vhost_vsock_flush_used(vq, &used_cou=
nt);
> > +
> >                 skb =3D virtio_vsock_skb_dequeue(&vsock->send_pkt_queue=
);
> >
> >                 if (!skb) {
> > +                       added |=3D vhost_vsock_flush_used(vq, &used_cou=
nt);
> >                         vhost_enable_notify(&vsock->dev, vq);
> >                         break;
> >                 }
> > @@ -153,6 +188,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vso=
ck,
> >                         /* We cannot finish yet if more buffers snuck i=
n while
> >                          * re-enabling notify.
> >                          */
> > +                       added |=3D vhost_vsock_flush_used(vq, &used_cou=
nt);
> >                         if (unlikely(vhost_enable_notify(&vsock->dev, v=
q))) {
> >                                 vhost_disable_notify(&vsock->dev, vq);
> >                                 continue;
> > @@ -230,8 +266,8 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vso=
ck,
> >                  */
> >                 virtio_transport_deliver_tap_pkt(skb);
> >
> > -               vhost_add_used(vq, head, sizeof(*hdr) + payload_len);
> > -               added =3D true;
> > +               vhost_vsock_add_used(vq, &used_count, head,
> > +                                    sizeof(*hdr) + payload_len);
> >
> >                 VIRTIO_VSOCK_SKB_CB(skb)->offset +=3D payload_len;
> >                 total_len +=3D payload_len;
> > @@ -264,6 +300,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vso=
ck,
> >                         virtio_transport_consume_skb_sent(skb, true);
> >                 }
> >         } while(likely(!vhost_exceeds_weight(vq, ++pkts, total_len)));
> > +       added |=3D vhost_vsock_flush_used(vq, &used_count);
> >         if (added)
> >                 vhost_signal(&vsock->dev, vq);
> >
> > --
> > 2.53.0
> >
>
