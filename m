Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AD73002B3
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788174586; cv=none; b=br9bnaYXAdVju79Z82rSov3k4duhZ2Z9d2Tw5sSZKYRjrW8UYgM6PBhXwO7lxiKf5QNesUeADAT/jraWEuwXrMfCJDx+P8lNyJjgYTM2uEV8ju2aDMEA7seeeeGnLA1X7FFkprEWCR3kjyDJL9IkzX/YHkgkC6JFPQcQldDYgRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788174586; c=relaxed/simple;
	bh=eNEEQlIjrSAO0DH2OmgK6lfFH24wmDnCRfFdxuXXBJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/ZkzbGo3K6nTrKGfat9ZKzrQtdcwO/czd3Bct/YzudRWjBXjqgyj7ckA/c75m37ltEgxamRt3RFXdQiBdwFB7LvJiI7YF3SGrNX6xeqx2tyKruEBoKrXto+cg99ENF6C/D7wPgLyls+OuEkSEQybsT4IVluU2rTJVEtfv5MOI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Amfas3of; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Amfas3of"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788174583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gGVDSMHx5ugj+9ChPGD41hmHDHU/4Z3alFYnki4dZYo=;
	b=Amfas3ofEpPqw32CUCQSXCj4UUhRiWuFML2V5w5gd7YbXLQJJ0SlVl6nXhCdhP0qdNy+mE
	k08AC2uCNc035xNT2YTfjyvGqpRiaCdnYJWngDG8imYETXzX2vramJSba8lvr0DVSDeAUT
	snXzN7QqEjIxvo1b+aREQTGZcg806gw=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128--21HaS1mOguEaxKl3UTrZw-1; Mon, 31 Aug 2026 07:09:42 -0400
X-MC-Unique: -21HaS1mOguEaxKl3UTrZw-1
X-Mimecast-MFC-AGG-ID: -21HaS1mOguEaxKl3UTrZw_1788174582
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-81e6bb29581so53553867b3.2
        for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 04:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788174582; x=1788779382;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gGVDSMHx5ugj+9ChPGD41hmHDHU/4Z3alFYnki4dZYo=;
        b=stynpV46YdUgAYorL+so6hbLE4zKf5VXpDLn+quMjmJdlHwX8jTSuX90qc9X7euU0O
         arf8nzvWEOe/5PL0JjrWvxEfxmJ+oxBbcsY6aKVo9cny+O2qQh60crh6OeOM8APwqsHf
         lw6LCdnZ/pEHlgXWyp2xXiVC6oTfmgsC8d/GpyGcKQWO7rQ/tbLK+N9exUq4GVcq1nnd
         8KAtU8+h157DWODHKx1Bt0bNu3+gg4A6rtoSippsG6KVIzd3iDGuFybHksikn/fboc9U
         EIoINuiKsm9pCd8KgbHKvq+I8o+wKOUgPE+YvHHwRTCb6q79UoG/Ck1RBgvUfxoMKgct
         oPnA==
X-Forwarded-Encrypted: i=1; AKwUvBx4OjmD/b2rkNASDAFHTC1I2KELzfZNSgePcJYN2B1MOI8C+wMymupeiBPdJ9oeqleLMX3pNDgMrqLcAqeC2Q==@lists.linux.dev
X-Gm-Message-State: AFuF++n7atD5WCdCx2lp8G4cc1nqKDRNndnIcFyIN1Db3ncLSEvur3x4
	D32Os03XH3iHUuQgVhbfpYMfpQM+vA35WEjnBaYzZG1B6zDMVDAl25NNg+hT4qm2ZJpePbaTo93
	2RzZtR/QprpGug0M2tUEEcvaWnf8sYC8BN5SLVXMWlAT7r53BRF/ekMdSWnTXIdBK65zZblRxgl
	C7tFPHc/uStQtG8bQMwXnhy4CdVqI1atc2xiIvt1F5h4I=
X-Gm-Gg: AYBFou0s2dEOywwdghegJwge7bRu6mwLkJ6kmQsLks8HbzPbcyFJLHJX3UuxKsOFe83
	fyJpxsYh2Y6qfQ64UJjxsRPfuQw+KLDLhiP4LJL1HUz+UZtOyneUxf/0XrXqLOqudmmTjJbqxfs
	WJzYRhSew7FvUzQ6Wp/ooovxr60MaBXa/yft+aRgCWAWtT0569Lc7JBsPVpGytzqujlc622SaM6
	YaYbe4MYs+PNzH4gsuFUyjR5jKVQRiJ+7PwdRpCp8KXXrG+qk+/MzmwKdQ=
X-Received: by 2002:a05:690c:c4f1:b0:81e:7d90:5673 with SMTP id 00721157ae682-85d6b84749cmr86908317b3.26.1788174581586;
        Mon, 31 Aug 2026 04:09:41 -0700 (PDT)
X-Received: by 2002:a05:690c:c4f1:b0:81e:7d90:5673 with SMTP id
 00721157ae682-85d6b84749cmr86908167b3.26.1788174580953; Mon, 31 Aug 2026
 04:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260827055850.26951-1-physicalmtea@gmail.com>
In-Reply-To: <20260827055850.26951-1-physicalmtea@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 31 Aug 2026 13:09:04 +0200
X-Gm-Features: AcwNN1VgorMGLHjUu2yMfvgBMefLlEZdtOPgiCl06CVBpYpTFVo6Jeh18PCESXs
Message-ID: <CAJaqyWfjjSe19z4TrPbJfBBQZJXuAzqE4H8bik6UAiSgogzfmQ@mail.gmail.com>
Subject: Re: [PATCH] vhost/vsock: batch RX used-ring updates
To: Jia Jia <physicalmtea@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0UC7wLeo9b8D--goBFqoVFSNWvqYmoOyjymV_CTyBLk_1788174582
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 7:59=E2=80=AFAM Jia Jia <physicalmtea@gmail.com> wr=
ote:
>
> vhost_transport_do_send_pkt() calls vhost_add_used() for every Guest RX
> buffer even though it delays the Guest signal until the worker finishes.
> Each call publishes one used entry and updates the used index separately.
>
> Collect the completed buffer heads in the arrays already allocated for th=
e
> virtqueue and publish them with vhost_add_used_n().  Bound the batch by t=
he
> ring size, array capacity, and worker packet budget.  Flush before
> re-enabling notifications or leaving the worker.
>
> Each used entry describes one completed RX buffer and keeps its actual us=
ed
> length, so set nheads to 1 for every entry.  This patch does not change
> negotiated features or compress multiple buffers into one used entry.
>
> This patch is limited to the current skb-based vhost-vsock RX path.
>
> Performance:
>
> Tested with a QEMU/KVM guest on a host with 4 online CPUs, using 2 vCPUs
> pinned to host CPUs 2 and 3, QEMU 10.2.1, q35, 1536 MiB, and Linux
> 7.2.0-rc3-next-20260713-next-debug-kasan.  The vhost-vsock source is base=
d
> on linux-next master at 49362394dad7df66c274c867a271394c10ca2bb8.
>
> Current vhost-vsock does not implement VIRTIO_F_IN_ORDER or
> VIRTIO_F_RING_PACKED, so both configurations used packed=3Doff and
> in_order=3Doff:
>
>   baseline:                 RX batching=3Doff
>   vhost-vsock RX batching:  RX batching=3Don
>
> The test used vsock_perf.  The Guest receiver was started with:
>
>   vsock_perf --port PORT --buf-size 64M --vsk-size 64M --rcvlowat 1
>
> The Host sender was started with:
>
>   vsock_perf --sender 3 --port PORT --bytes BYTES \
>       --buf-size SEND_BUF --vsk-size 64M
>
> Each workload transferred BYTES=3D1 GiB.  The SEND_BUF values were 256 B
> (SEND_BUF=3D256), 512 B (SEND_BUF=3D512), 4 KiB (SEND_BUF=3D4K), and 64 K=
iB
> (SEND_BUF=3D64K).
> Each state used a fresh Guest.  Each workload uses 20 paired runs, with 1=
0
> runs in each order.  The reported values are
> Guest RX throughput in Gbits/s.  The baseline and batching columns are th=
e
> geometric means over the 20 runs; change is batching / baseline - 1,
> computed from the unrounded values:
>
>   workload   baseline RX    batching RX   change   faster
>   256 B      0.0795724      0.0831509      +4.497%  20/20
>   512 B      0.1194885      0.1210297      +1.290%  14/20
>   4 KiB      0.7208273      0.7242053      +0.469%  11/20
>   64 KiB     2.1712797      2.1951941      +1.101%  13/20
>
> For reference, the table below gives the 95% normal-approximation interva=
ls
> obtained from the 20 paired log(batching / baseline) values:
>
>   workload   paired 95% interval
>   256 B      +3.985% to +5.011%
>   512 B      +0.206% to +2.385%
>   4 KiB      -1.442% to +2.416%
>   64 KiB     -1.474% to +3.745%
>
> All transfers passed byte-count checks, and no kernel errors were observe=
d
> in the logs.  The 256-byte workload improved in every pair.  The 512 B
> workload was faster in 14 of 20 pairs, with a small gain.  The 4 KiB and
> 64 KiB workloads showed no material throughput change; the difference
> between their results may be due to scheduling and execution variation.
>
> Link: https://lore.kernel.org/r/20181214082146-mutt-send-email-mst@kernel=
.org
> Link: https://lore.kernel.org/r/20220901055434.824-4-qtxuning1999@sjtu.ed=
u.cn
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> ---
>  drivers/vhost/vsock.c | 41 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 9aaab6bb8..d8050cca2 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -103,12 +103,37 @@ static bool vhost_transport_has_remote_cid(struct v=
sock_sock *vsk, u32 cid)
>         return found;
>  }
>
> +static bool vhost_vsock_flush_used(struct vhost_virtqueue *vq,
> +                                  unsigned int *used_count)
> +{
> +       if (!*used_count)
> +               return false;
> +
> +       vhost_add_used_n(vq, vq->heads, vq->nheads, *used_count);
> +       *used_count =3D 0;
> +       return true;
> +}
> +

I think that the used_count should be updated by the caller based on
the boolean returned by this function.

> +static void vhost_vsock_add_used(struct vhost_virtqueue *vq,
> +                                unsigned int *used_count,
> +                                unsigned int head, unsigned int len)
> +{
> +       struct vring_used_elem *used =3D &vq->heads[*used_count];
> +
> +       used->id =3D cpu_to_vhost32(vq, head);
> +       used->len =3D cpu_to_vhost32(vq, len);
> +       vq->nheads[*used_count] =3D 1;
> +       (*used_count)++;
> +}

Same here, why pass it as an argument? The caller knows way better.

Other than that, the patch looks good to me,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> +
>  static void
>  vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>                             struct vhost_virtqueue *vq)
>  {
>         struct vhost_virtqueue *tx_vq =3D &vsock->vqs[VSOCK_VQ_TX];
>         int pkts =3D 0, total_len =3D 0;
> +       unsigned int used_count =3D 0;
> +       unsigned int used_limit;
>         bool added =3D false;
>         bool restart_tx =3D false;
>
> @@ -120,6 +145,12 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsoc=
k,
>         if (!vq_meta_prefetch(vq))
>                 goto out;
>
> +       used_limit =3D min_t(unsigned int, vq->num,
> +                          min_t(unsigned int, vq->dev->iov_limit,
> +                                vq->dev->weight));
> +       if (unlikely(!used_limit))
> +               goto out;
> +
>         /* Avoid further vmexits, we're already processing the virtqueue =
*/
>         vhost_disable_notify(&vsock->dev, vq);
>
> @@ -134,9 +165,13 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsoc=
k,
>                 u32 offset;
>                 int head;
>
> +               if (used_count =3D=3D used_limit)
> +                       added |=3D vhost_vsock_flush_used(vq, &used_count=
);
> +
>                 skb =3D virtio_vsock_skb_dequeue(&vsock->send_pkt_queue);
>
>                 if (!skb) {
> +                       added |=3D vhost_vsock_flush_used(vq, &used_count=
);
>                         vhost_enable_notify(&vsock->dev, vq);
>                         break;
>                 }
> @@ -153,6 +188,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock=
,
>                         /* We cannot finish yet if more buffers snuck in =
while
>                          * re-enabling notify.
>                          */
> +                       added |=3D vhost_vsock_flush_used(vq, &used_count=
);
>                         if (unlikely(vhost_enable_notify(&vsock->dev, vq)=
)) {
>                                 vhost_disable_notify(&vsock->dev, vq);
>                                 continue;
> @@ -230,8 +266,8 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock=
,
>                  */
>                 virtio_transport_deliver_tap_pkt(skb);
>
> -               vhost_add_used(vq, head, sizeof(*hdr) + payload_len);
> -               added =3D true;
> +               vhost_vsock_add_used(vq, &used_count, head,
> +                                    sizeof(*hdr) + payload_len);
>
>                 VIRTIO_VSOCK_SKB_CB(skb)->offset +=3D payload_len;
>                 total_len +=3D payload_len;
> @@ -264,6 +300,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock=
,
>                         virtio_transport_consume_skb_sent(skb, true);
>                 }
>         } while(likely(!vhost_exceeds_weight(vq, ++pkts, total_len)));
> +       added |=3D vhost_vsock_flush_used(vq, &used_count);
>         if (added)
>                 vhost_signal(&vsock->dev, vq);
>
> --
> 2.53.0
>

