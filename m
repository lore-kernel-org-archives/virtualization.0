Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3F33E51E8
	for <virtualization@lists.linux.dev>; Mon,  7 Sep 2026 03:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788750359; cv=pass; b=qtCwk1rx1af4RgQ9/6Mtkom1mm6HLyxAUXgAWTHDBoSJLnN1i69BNtSVS7r1jwOT9JLaBSI7SxlCDjYQzsrl2yISHvM/QQh9MuMLHmrwfgoJzSFRR+08t7AUnBwU3FgV7voXpv/Gp9xdJLHy5HzyD3QF6e8FA2YA18s9lviJZ3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788750359; c=relaxed/simple;
	bh=JjTBnWXYcPYPei20BQ2ElWZXSEdrjRdouifOfM3rT+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0c9RDYkiaDBwZ2vHi+Xw5rJYk/MGfI7kri66c4+2kI+6tvZ20DtamcxZ8zTU6c0PJYY7xSDM4xJGKkNF6jjSczGvtzBuGsCW/yNYz2TSdS4KWR69auf29YkK7wqybxAP2xvyE7P33UDvCtmxYgaW8U3o6SqhxGLVrJf7AOMu3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TP4Dv9lV; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TP4Dv9lV"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-90e7bde5596so39815006d6.1
        for <virtualization@lists.linux.dev>; Sun, 06 Sep 2026 20:05:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788750355; cv=none;
        d=google.com; s=arc-20260327;
        b=As0e78Sgp1+v83997arLu27TzrpfcPgrRagE8EAs/gSCvapSCtx24ZcEToUyAl6GBd
         YCTf36nPzatWJtRUirERCKQ53LXFv4GM9z4Rp67Tc6Tpaz9ubsAGjm1n5ZGD7uYulfcW
         YT8eYu1MN5pnb2SGbTjQuFksXrzB/CDN/dQt/m+j++fSFe8iZNBJcaID8jJwqwc8kv7N
         wVGotvZ94jqLY2nUMzBFRivHeqg0eEuhuuA1C29LSQ9h7g7KrZEbPpiR1WxGizw7yba9
         wm2E2vszEEm8C/o8jJ4DiIR69APGI4HibEBadBf4JX7HNOCOI80KRm9Lsy/KVZO9Uu5g
         RX+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vp6kqRH18z2BkXSeT4B0EuoiGVpEoZr0cYZ/GmzT9oY=;
        fh=Zt4quNeMsFUjVlDyT9waZJ8emEEuGjeNEllxN4uZJXM=;
        b=FAlZG/gp1xV69fj/JuzlvwJu9YxXogsH74btpF4ddCLtDwLF1rTN1xh2bwpIiuvcFD
         avbDVwLWWkSOiayQBI68yZHFCJSHm3Ah8JDWnrggmmLVOZAsBbTYYPQhyfM7s9CYon/S
         kdKh4Ma5+QJdJLH9R+Cns2IFMWO56fc+NpFxAx98U8eXluapK93ETnOZZbr9VYHzHfmR
         Y34GSvuyxyFfru6SRTOU2LIoQg1ZSGOznXLsa1RU3RRyaGzrBLDOWRutr5lMWy1RTdNp
         DOByw6SALNjhwy+jgjnV3br3L9F5P7ZAlP0o8dGWohp/1+LufZcXNsj9kZLJ9t6vaec9
         TeBA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788750355; x=1789355155; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vp6kqRH18z2BkXSeT4B0EuoiGVpEoZr0cYZ/GmzT9oY=;
        b=TP4Dv9lViRAD6JBWwOInMGTcJa8/2JOfXereLUeyM0HEYxhGIzvmg5neQBGM+MltVl
         l87vUAs6129TwGjPf1O3XqpBeKc511GX3NqaG1w75Kdf451D+5YW8tFIM3/1PYspyzc6
         z69Q4GECbmVDmbgySCzWKFqyuQhV7KAh10ceyPhVYT3uKBjYHFwJ1Nx7MGU6/zja7+Jy
         SLyNVRjl34JE7yYg9lQt3XWIbCx7wOsacuo9xwqd3qvah1Rl2+FEHyjOaTtPrZmLui+F
         1bpvb7CMomnaF1DDNq768TIwvEthe1zWFOf3aWscImeFi6HcTWRCDcWC2BankKIA3f7J
         mUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788750355; x=1789355155;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vp6kqRH18z2BkXSeT4B0EuoiGVpEoZr0cYZ/GmzT9oY=;
        b=PjJ18Hpa2juz+zaaT2GRpW2jah879nWijL0eAgwQwFM2IjPdO+0TXe6+d9yBsN9viU
         Sq9C7uxpjWJrEylL6hhpcqKe+EKS/b5zBHji/AH0RkHrHQ80/H+K/6M9sodKOKGzN893
         K+8ymZQTgYUrLjB1CuOigntehcghb/1mkbgU8cHiF0vhWFx1wgDHe2PJTJMzt+u3UU6n
         I+9zVvbrh2mmWwrLlCbcrOHYfz+PAytTD85qLIi/eMJAlRhb/fQCkDvpBeOqA89UgGfx
         MjXyRzmFssmqWXdIvt1yi4lUS46y6IIfVQIh2Rzh6elewXQiL+Em1qHRnZQxf159Vtja
         djLw==
X-Forwarded-Encrypted: i=1; AKwUvBzKeJZHnQe9t1Qk/1+a1vY1g81X+QD73Fg95O577ZbZcB0CkjRknkgHdkqp+UhXvSbwfv+9aWWxuXCWxo3Ozg==@lists.linux.dev
X-Gm-Message-State: AFuF++msVCWZ3eX3UcsxznnlaVflLfhelj0RWwvqML1u2yZXYv9+kpiY
	C/pAaxG4XQIHrBY9KRIEyjnwbm6LDAZBH8Dcu1HxAWy0AC8+qt8cy6NcIscF/7iqC8BV64bkjIR
	nZJAPMP29vhVtkWilpboaNRFa9gEJYdQ=
X-Gm-Gg: AYBFou1m52brbb2HQTYA1wD6v1MyfWvALLcgFhY1XkCVW7xixiInpzt/sq1rTGlmCGL
	zQ/YpEk+tUYTmQfCmk4mFA2+A810p+iYWqmiIQPTnyaIXQ5cmlMQjl11uOOZ9i2Gp0DCkF5tK+s
	MkcjbeTJJI05Psu3r0TwAl+LsnFdc+CXxOnHh6HBZ2SeJ8cmig8RtDwyPxJ7WDv3qmXKhIcmPgR
	HgOcOb9vkB8MMZ/UOHrBDQgzPaYqDXy/DMp9hf4OQ8VZwdjP5a+gPFqZcyFKpc758r9l5HCyYpu
	CEHeXwrNjRA4lx8tsB4LLNVHyNwssF6CL2sWevDUp1d/
X-Received: by 2002:a05:620a:2a14:b0:939:16f6:4d01 with SMTP id
 af79cd13be357-93980371409mr1860789685a.21.1788750355107; Sun, 06 Sep 2026
 20:05:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260906013659.517889-1-physicalmtea@gmail.com> <20260905234007-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260905234007-mutt-send-email-mst@kernel.org>
From: Jia Jia <physicalmtea@gmail.com>
Date: Mon, 7 Sep 2026 11:05:18 +0800
X-Gm-Features: AcwNN1VD3mXF6xsr3Q77Ee5e_NmlFL287LdrgSbhF2Hf-aI0ro1H1y2newXV4-0
Message-ID: <CAJwVaMJcqOPPt6eQuVdySmwvjMz2Bh5dRPYidF+s8_1fNf2uiw@mail.gmail.com>
Subject: Re: [PATCH v4] vhost/vsock: batch RX used-ring updates
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: sgarzare@redhat.com, stefanha@redhat.com, jasowang@redhat.com, 
	eperezma@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> On Sun, Sep 06, 2026 at 09:36:59AM +0800, Jia Jia wrote:
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
> > ring size and array capacity.  Flush when the batch reaches its limit o=
r
> > before leaving the worker.
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
> > The test used vsock_perf with a fresh Guest for each state and 20 paire=
d
> > runs. The Guest receiver used:
> >
> >   vsock_perf --port PORT --buf-size 64M --vsk-size 64M --rcvlowat 1
> >
> > The Host sender used:
> >
> >   vsock_perf --sender 3 --port PORT --bytes 1G \
> >       --buf-size SEND_BUF --vsk-size 64M
> >
> > The table reports geometric mean Guest RX throughput.
> >
> >   SEND_BUF   baseline RX   batching RX   change
> >              (Gbit/s)       (Gbit/s)
> >   256 B      0.0795724      0.0831509      +4.497%
> >   512 B      0.1194885      0.1210297      +1.290%
> >   4 KiB      0.7208273      0.7242053      +0.469%
> >   64 KiB     2.1712797      2.1951941      +1.101%
>
>
> I will be frank I don't find the numbers compelling enough
> to bother with this trickery.
>
> vsock wasn't optimized all that much for small packets -
> first of all, it is doing most of its work in a work item
> so we are already at the mercy of the scheduler.
>
> That's more work but you will see a much bigger win for bw and
> latency by just handling small packets directly in the cb
> if you can.
>
> Looking at batching: wakeup per packet in rx_work, lock_sock per packet,
> sk->sk_write_space per rx packet are all high overhead things we are
> doing in the data path that are likely easier to handle
> and will give you more bang for the buck.
>
>
>
>
>

Thank you very much for giving such a clear direction!

> >
> > As supplementary data, perf stat measured the vhost worker cycles and
> > instructions per GiB in 10 paired runs. The patched implementation
> > reduced cycles by 3.846%, 2.162%, and 4.109%, and instructions by
> > 2.548%, 2.084%, and 4.637% for 256 B, 4 KiB, and 64 KiB, respectively.
> >
> > An AF_VSOCK request-response latency test with 10 AB/BA pairs showed no
> > consistent RTT change: -0.102% for 256-byte messages (4/10 pairs lower)=
 and
> > +3.281% for 4-KiB messages (5/10 pairs lower), using arithmetic mean RT=
Ts.
> >
> > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> > Changes in v4:
> > - Simplify the performance description.
> > - Add a brief AF_VSOCK RTT measurement.
> > - Keep the batch limit within the used ring and scratch arrays, without
> >   duplicating the worker weight limit.
> > - Flush after adding a used entry when the batch reaches the limit, and
> >   remove the redundant flush in the empty-queue path.
> > ---
> >  drivers/vhost/vsock.c | 47 +++++++++++++++++++++++++++++++++++++++++++=
++--
> >  1 file changed, 45 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > index 9aaab6bb8061..7a13abe73345 100644
> > --- a/drivers/vhost/vsock.c
> > +++ b/drivers/vhost/vsock.c
> > @@ -103,12 +103,35 @@ static bool vhost_transport_has_remote_cid(struct=
 vsock_sock *vsk, u32 cid)
> >       return found;
> >  }
> >
> > +static bool vhost_vsock_flush_used(struct vhost_virtqueue *vq,
> > +                                unsigned int used_count)
> > +{
> > +     if (!used_count)
> > +             return false;
> > +
> > +     vhost_add_used_n(vq, vq->heads, vq->nheads, used_count);
> > +     return true;
> > +}
> > +
> > +static void vhost_vsock_add_used(struct vhost_virtqueue *vq,
> > +                              unsigned int used_count,
> > +                              unsigned int head, unsigned int len)
> > +{
> > +     struct vring_used_elem *used =3D &vq->heads[used_count];
> > +
> > +     used->id =3D cpu_to_vhost32(vq, head);
> > +     used->len =3D cpu_to_vhost32(vq, len);
> > +     vq->nheads[used_count] =3D 1;
> > +}
> > +
>
>
> flush where? add where? return what? these apis don't make it
> easier to read code.
>

Thanks for pointing this out. If I understand correctly, the
responsibilities, call sites, and return values of these helpers make
the control flow harder to follow. I will be careful not to make the
path more complicated for the sake of abstraction in the future.

> >  static void
> >  vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> >                           struct vhost_virtqueue *vq)
> >  {
> >       struct vhost_virtqueue *tx_vq =3D &vsock->vqs[VSOCK_VQ_TX];
> >       int pkts =3D 0, total_len =3D 0;
> > +     unsigned int used_count =3D 0;
> > +     unsigned int used_limit;
> >       bool added =3D false;
> >       bool restart_tx =3D false;
> >
> > @@ -120,6 +143,11 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vs=
ock,
> >       if (!vq_meta_prefetch(vq))
> >               goto out;
> >
> > +     /* Keep the batch within the used ring and the scratch arrays. */
>
> what "the batch"? this is the 1st time code mentions any batch.
>

In the future, I will try not to introduce concepts used in a patch
midway through the code. They should be explained when used.

> > +     used_limit =3D min_t(unsigned int, vq->num, vq->dev->iov_limit);
> > +     if (unlikely(!used_limit))
> > +             goto out;
> > +
> >       /* Avoid further vmexits, we're already processing the virtqueue =
*/
> >       vhost_disable_notify(&vsock->dev, vq);
> >
> > @@ -150,9 +178,16 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vs=
ock,
> >
> >               if (head =3D=3D vq->num) {
> >                       virtio_vsock_skb_queue_head(&vsock->send_pkt_queu=
e, skb);
> > +
> > +                     /* Flush completed buffers before re-enabling not=
ifications. */
>
>
> redundant - i can see this is what it does but why? and what does flush m=
ean here?
>

I will pay attention to making the purpose of comments clear.

> > +                     if (vhost_vsock_flush_used(vq, used_count)) {
> > +                             added =3D true;
> > +                             used_count =3D 0;
> > +                     }
> > +
> >                       /* We cannot finish yet if more buffers snuck in =
while
> >                        * re-enabling notify.
> >                        */
> >                       if (unlikely(vhost_enable_notify(&vsock->dev, vq)=
)) {
> >                               vhost_disable_notify(&vsock->dev, vq);
> >                               continue;
> > @@ -230,8 +265,13 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vs=
ock,
> >                */
> >               virtio_transport_deliver_tap_pkt(skb);
> >
> > -             vhost_add_used(vq, head, sizeof(*hdr) + payload_len);
> > -             added =3D true;
> > +             vhost_vsock_add_used(vq, used_count, head,
> > +                                  sizeof(*hdr) + payload_len);
> > +             used_count++;
> > +             if (used_count =3D=3D used_limit) {
> > +                     added |=3D vhost_vsock_flush_used(vq, used_count)=
;
>
>
> bitwise or on a boolean likely not what was intended.
>

Understood.

> > +                     used_count =3D 0;
> > +             }
> >
> >               VIRTIO_VSOCK_SKB_CB(skb)->offset +=3D payload_len;
> >               total_len +=3D payload_len;
> > @@ -264,6 +304,9 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vso=
ck,
> >                       virtio_transport_consume_skb_sent(skb, true);
> >               }
> >       } while(likely(!vhost_exceeds_weight(vq, ++pkts, total_len)));
> > +
> > +     added |=3D vhost_vsock_flush_used(vq, used_count);
> > +
>
>
> and here.
>

I will drop the current patch and try a new optimization direction.
Thank you.

> >       if (added)
> >               vhost_signal(&vsock->dev, vq);
> >
> > --
> > 2.34.1
>
