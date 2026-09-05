Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0729361957
	for <virtualization@lists.linux.dev>; Sat,  5 Sep 2026 05:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788586162; cv=pass; b=Stc82xHy3El9tyURZjkRqRUbNHNUXgNQa5ewyrcdqcR84LGSbL4t+1Iyn6p6kqrVNc1kd1pZwytrjoJ8ibOxzGR13J91r7vdPLB3Wp+pYK8FJG2LQauIf2U7r29gXuMzlDPnOkSZ1trrp5Dc/3kwkANB8xQc99sOjagap4VDIQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788586162; c=relaxed/simple;
	bh=p+U6slXGSkZV2gS8bWjG0Z2gRjO1LEC+tQzZbsv+2SM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oRt4Ej41rHi5zZQm3OYiRh1rJxKBlIDv7STWaGDH9LZu/prWkMN8ks6JaSn8GhCFQVjPiu3VMqIBt/hq+UfLGHGf3/sgC6SRiHXLImRLYS+J8OB4UWmPCmLVQZAEImYSb4N9mcNDhq1x8xu86O7uTV3kWQ8G8kQJbhFulXL6/aI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyV8FZwl; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyV8FZwl"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-53069ec6e61so2461751cf.2
        for <virtualization@lists.linux.dev>; Fri, 04 Sep 2026 22:29:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788586159; cv=none;
        d=google.com; s=arc-20260327;
        b=oKR9HQmQaeauMYNhv9EmCuZwNOP0/1UhVmVz1O1lBeZepch81s7oe/yLUu3hND6+Km
         gs+rdQrTBg2sMse04MK5J2u/amDEwoGAEakHc9S4Kw/8tzoNHX5N/BmBLEBhA+qNP1D9
         pCcNTeRp/PVi/axMkOrBZM8jiu3fcuyqINWO0ySdcCL3LM6AWrz4taPkO8p7uYonT8pk
         QB/J3P0MjuGiC4Qzw1+TxyLBhwydsr/PFAHU+i/v0tJl0tpCfF6V/h8zpONj0pNb4H6T
         hNdwbX4hFZ/6i0P90y37AZ5r6T81FKoOEw+yDsF/1EP504MNYb/kAfI2Y6tqvHZj7B/0
         L+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zOOtROkozwZMIXH8rgnwGdPPygaONrUYrSuVGiaR5T8=;
        fh=34e/4ZZOmQ3ePhnTTQhSKLqBJYbH4YiehDOyN9Z/sJ8=;
        b=PEmcJuysyIK7ZC9MIp5KqaSiSQ6XflUu0XzRAZy+Keu5cVvyqILO4mts/uuTjuzLU5
         8IoAvCVl3AYLP24wTV64vC5VA1Ez/0qTPyWXaMlfnXHI69OaqMPSSuYHEo3gipl5pBaW
         gPradtWBEQKKoNivPe2F9oOnjke7KB/ciplQ8BG7InM09w+MslGerN4UDHa0kyfZrCDH
         z4uGQBfdEzF0rNLOiShE0kyb3bfUo6p3H2q7TWbflS9VC9MiMM2c5SfYJ/LFaAbu6Fsg
         eaCIl5zR+dKyNqNBMC17dN3S6g9KtY4X0gk81dLEzwLMZVCWzCiseqrPS1OSx18TiR3j
         LZWw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788586159; x=1789190959; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zOOtROkozwZMIXH8rgnwGdPPygaONrUYrSuVGiaR5T8=;
        b=UyV8FZwlog2x7LtaCmyDjXMYUXvjLlWTxUkH6Wi6c+INRMSvWcfubHzOxfBi7E2eXU
         F7qN0HT2PSnGGvtf7fKrwqSytpammsNHBTLAjr9I8y1OO09GCnP+b5rmK4+Pt6whxVtY
         qmHqja7UqIUPXbt7yF+cJ/Y6oGBHQfgcv5aikLSufhi97pKoAvVzWkFmlYb1fgER5gW+
         HCV6FEa+uPgnjDeyLxbXJe9Q5Q2VP/tPgIY3L5MmvJg8XqMjfBCJMeWeUPlpj0i4xuNZ
         njC+LNZz7fbPszbiNEcwQCCwkS7QC/ak5edPTI5Ox0QI7c1r4ZFoTRrNh+mRSyyNFRbc
         OCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788586159; x=1789190959;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zOOtROkozwZMIXH8rgnwGdPPygaONrUYrSuVGiaR5T8=;
        b=cdMRCBinpHXX7WMGaoHdrwhuX2/kZIilXcZ7XnXk61I65hWw5BYtzLmqc83nA4b7YP
         PFWyJGt7/43/D4/sDH/hC9i7Ng6F4jI5kaFNM0ViFQEGqHFYIql1YMK8ENE6vxripul4
         zYgsRMOCnjlLEE141a4xbTzo46gqExAnL2YW2XbHa0CttD89EIywZzVOxkRy/TDMePhY
         zgjxWjFSWc/nn6a+plI3/OvoORj9lokzl5PhSuf9XECAFkGazUNordKuTxN7iEVnoOKd
         Lc9j6ywXj4v4QBBJ1GaZ72sB44JT4uSpAmlMd/9meFKjdnKQvHUkzSf+S6LXP24xSq9U
         6rug==
X-Forwarded-Encrypted: i=1; AKwUvByJnkOLDonkw3RPMGzdYA//6RrsNhSHynTSLHAuvzUU+My+fBNniTrQcTsHJBWVCD/OjHyUD3wLjSVwWDVlMA==@lists.linux.dev
X-Gm-Message-State: AFuF++l8wRP8Qq42lcL8d8afMoUsBQltU8FPo+D4MHg2t3pLrBqxcAhJ
	1twfujML48LsvYxA7mt4myp+JeyZAhhDKgnPO6Q8jkrdhTL4oFo13pu+DXV+NNXJxJdYMN0ZVs4
	HzVTVwae/nB7FGwoTvQohl75rIOYEVnQ=
X-Gm-Gg: AYBFou1uWlMoTIf31wkw0LtTn4tn/HW8btbxL+wAGCcmB/xiQCND4SKb4KY5IFBOEZD
	SDARmrp35z2hrKYy1ErLVYbIHbIOdWOTRwD5bc9ejCfFqo84mNiEddMBYwUe1NTY11bHk74UD2k
	jEtSt8npskpi3CyLGu+ZZZcVRVqscqajVMDGttFWFz+/gpLSRbTUUZmD27SQuPwpVVN8AN7oXg9
	C1P/3ECUtFmQt4Oj7JJEgWLevSElHwW/5gh/X8ss48KXnpB6P7Y5mYU9setqNV6nK+a1EfTOqhb
	RbcAl2EDeZvC6Dv2/QBMyfUyCGctm1ky5sHtwhXYy5gx
X-Received: by 2002:ac8:690b:0:b0:530:430e:8126 with SMTP id
 d75a77b69052e-53054a4add9mr136508981cf.47.1788586158690; Fri, 04 Sep 2026
 22:29:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260904012537.503230-1-physicalmtea@gmail.com> <app1fIXbKd5xOFK3@sgarzare-redhat>
In-Reply-To: <app1fIXbKd5xOFK3@sgarzare-redhat>
From: Jia Jia <physicalmtea@gmail.com>
Date: Sat, 5 Sep 2026 13:28:42 +0800
X-Gm-Features: AcwNN1XrvSv63r-nDWqA7Y1OadR_GJjIuT2x_LlB_kswrVT-kKW3Ujpwni4K7sE
Message-ID: <CAJwVaM+LM+gPj2_UivF1Qs=ixJfDzx7NmuzN+Q-dE5ahq_-d9A@mail.gmail.com>
Subject: Re: [PATCH v3] vhost/vsock: batch RX used-ring updates
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> On Fri, Sep 04, 2026 at 09:25:37AM +0800, Jia Jia wrote:
> >vhost_transport_do_send_pkt() calls vhost_add_used() for every Guest RX
> >buffer even though it delays the Guest signal until the worker finishes.
> >Each call publishes one used entry and updates the used index separately=
.
> >
> >Collect the completed buffer heads in the arrays already allocated for t=
he
> >virtqueue and publish them with vhost_add_used_n().  Bound the batch by =
the
> >ring size, array capacity, and worker packet budget.  Flush before
> >re-enabling notifications or leaving the worker.
> >
> >Each used entry describes one completed RX buffer and keeps its actual u=
sed
> >length, so set nheads to 1 for every entry.  This patch does not change
> >negotiated features or compress multiple buffers into one used entry.
> >
> >This patch is limited to the current skb-based vhost-vsock RX path.
> >
> >Performance:
>
> It's great to include the performance metrics in the commit, and thanks
> for that, but I don't think we need all this AI slop that follows,
> please summarize it.
>

Thanks for the thorough review.   I'll summarize the performance
section in the next version.

> >
> >Tested with a QEMU/KVM guest on a host with 4 online CPUs, using 2 vCPUs
> >pinned to host CPUs 2 and 3, QEMU 10.2.1, q35, 1536 MiB, and Linux
> >7.2.0-rc3-next-20260713-next-debug-kasan.  The vhost-vsock source is bas=
ed
> >on linux-next master at 49362394dad7df66c274c867a271394c10ca2bb8.
> >
>
> e.g. from here...
>
> >Current vhost-vsock does not implement VIRTIO_F_IN_ORDER or
> >VIRTIO_F_RING_PACKED, so both configurations used packed=3Doff and
> >in_order=3Doff:
> >
> >  baseline:                 RX batching=3Doff
> >  vhost-vsock RX batching:  RX batching=3Don
>
> ... to here, can be removed.
>

Understood. I'll remove this setup and configuration description.

> >
> >The test used vsock_perf.  The Guest receiver was started with:
> >
> >  vsock_perf --port PORT --buf-size 64M --vsk-size 64M --rcvlowat 1
> >
> >The Host sender was started with:
> >
> >  vsock_perf --sender 3 --port PORT --bytes BYTES \
> >      --buf-size SEND_BUF --vsk-size 64M
> >
> >Each workload transferred BYTES=3D1 GiB.  The SEND_BUF values were 256 B
> >(SEND_BUF=3D256), 512 B (SEND_BUF=3D512), 4 KiB (SEND_BUF=3D4K), and 64 =
KiB
> >(SEND_BUF=3D64K).
>
> Put `1 GiB` directly after --bytes, no?

I'll change the command to use `--bytes 1G`.

>
> About SEND_BUF values, use SEND_BUF in the table header, and remove the
> text here.
>

Understood. I'll put `SEND_BUF` in the table header and remove the
explanatory text.

> >Each state used a fresh Guest.  Each workload uses 20 paired runs, with =
10
> >runs in each order.  The reported values are
> >Guest RX throughput in Gbits/s.  The baseline and batching columns are t=
he
> >geometric means over the 20 runs; change is batching / baseline - 1,
> >computed from the unrounded values:
>
> Ditto, summarize or remove (e.g. Gbits/s can be put in the table
> header).
>

I'll put the unit in the table header and remove the extra explanation.

> >
> >  workload   baseline RX    batching RX   change   faster
> >  256 B      0.0795724      0.0831509      +4.497%  20/20
> >  512 B      0.1194885      0.1210297      +1.290%  14/20
> >  4 KiB      0.7208273      0.7242053      +0.469%  11/20
> >  64 KiB     2.1712797      2.1951941      +1.101%  13/20
> >
>
> What about the latency?
>

I will run an additional userspace request-response test:

Host send -> Guest echo -> Host userspace receive

The host will timestamp before sending and after receiving the echo to
measure the round-trip time. If this approach looks reasonable, I will
include the results in the next version.

> >For reference, the table below gives the 95% normal-approximation interv=
als
> >obtained from the 20 paired log(batching / baseline) values:
> >
> >  workload   paired 95% interval
> >  256 B      +3.985% to +5.011%
> >  512 B      +0.206% to +2.385%
> >  4 KiB      -1.442% to +2.416%
> >  64 KiB     -1.474% to +3.745%
> >
> >All transfers passed byte-count checks, and no kernel errors were observ=
ed
> >in the logs.  The 256-byte workload improved in every pair.  The 512 B
> >workload was faster in 14 of 20 pairs, with a small gain.  The 4 KiB and
> >64 KiB workloads showed no material throughput change; the difference
> >between their results may be due to scheduling and execution variation.
>
> All this text can be removed, it's clear from the table, no?
>

I'll remove it.

> >
> >The Guest RX throughput results above are the primary performance
> >measurement. For additional Host-side context, I measured the vhost
> >worker thread servicing the vhost-vsock RX queue in a separate set of
> >10 paired runs, with five runs in each AB/BA order. Counters were
> >normalized by the verified transferred GiB and summarized using
> >geometric means. Worker cycles/GiB improved by 3.846%, 2.162%, and
> >4.109% for 256 B, 4 KiB, and 64 KiB, respectively. The corresponding
> >worker instructions/GiB improvements were 2.548%, 2.084%, and 4.637%.
> >The patched implementation used fewer cycles in 10/10, 8/10, and
> >10/10 paired runs, respectively, and fewer instructions in 10/10
> >paired runs for all three workloads. This measures the complete vhost
> >worker thread during the transfer, rather than an individual helper
> >function, and is supplementary to the Guest RX throughput results.
>
> Please, summarize.
>

I'll summarize the host-side perf results as supplementary data.

> >
> >Link: https://lore.kernel.org/r/20181214082146-mutt-send-email-mst@kerne=
l.org
>
> You put this link, but you didn't explain why...
>
> >Link: https://lore.kernel.org/r/20220901055434.824-4-qtxuning1999@sjtu.e=
du.cn
>
> Ditto.
>

The first link points to the earlier vhost-vsock RX batching discussion,
and the second points to related vhost-vsock TX/IN_ORDER batching work.
I included them as background for the design choices, but I agree that
they are not necessary here and will remove both links in the next version.

> >Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> >Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >---
> >Changes in v3:
> >- Add supplementary Host-side perf measurements for the complete
> >  vhost worker thread during the transfer.
> >---
> > drivers/vhost/vsock.c | 53 +++++++++++++++++++++++++++++++++++++++++--
> > 1 file changed, 51 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> >index 9aaab6bb8061..9e72c67c287f 100644
> >--- a/drivers/vhost/vsock.c
> >+++ b/drivers/vhost/vsock.c
> >@@ -103,12 +103,35 @@ static bool vhost_transport_has_remote_cid(struct =
vsock_sock *vsk, u32 cid)
> >       return found;
> > }
> >
> >+static bool vhost_vsock_flush_used(struct vhost_virtqueue *vq,
> >+                                 unsigned int used_count)
> >+{
> >+      if (!used_count)
> >+              return false;
> >+
> >+      vhost_add_used_n(vq, vq->heads, vq->nheads, used_count);
> >+      return true;
> >+}
> >+
> >+static void vhost_vsock_add_used(struct vhost_virtqueue *vq,
> >+                               unsigned int used_count,
> >+                               unsigned int head, unsigned int len)
> >+{
> >+      struct vring_used_elem *used =3D &vq->heads[used_count];
> >+
> >+      used->id =3D cpu_to_vhost32(vq, head);
> >+      used->len =3D cpu_to_vhost32(vq, len);
> >+      vq->nheads[used_count] =3D 1;
> >+}
>
> Would it be better to move these functions to vhost.c?
> (not a strong opinion)
>

I'd prefer to keep them in vsock.c for now, since vhost-vsock is
currently the only caller.
I can move them to vhost.c if you prefer.

> >+
> > static void
> > vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> >                           struct vhost_virtqueue *vq)
> > {
> >       struct vhost_virtqueue *tx_vq =3D &vsock->vqs[VSOCK_VQ_TX];
> >       int pkts =3D 0, total_len =3D 0;
> >+      unsigned int used_count =3D 0;
> >+      unsigned int used_limit;
> >       bool added =3D false;
> >       bool restart_tx =3D false;
> >
> >@@ -120,6 +143,12 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vso=
ck,
> >       if (!vq_meta_prefetch(vq))
> >               goto out;
> >
>
> Can you add a comment whith the reason of this limit?
>

Sure. I'll add a comment explaining why the limit is bounded by both the
used-ring size and the scratch-array capacity.

> >+      used_limit =3D min_t(unsigned int, vq->num,
> >+                         min_t(unsigned int, vq->dev->iov_limit,
> >+                               vq->dev->weight));
>
> Why adding `vq->dev->weight` in the limit, the loop is already limited
> by that, no?
>
> (this is why a comment here is needed...)
>
>

I checked this again. weight is already enforced by vhost_exceeds_weight(),
so including it in used_limit is redundant. Thanks for pointing that
out. I'll change it to:

used_limit =3D min_t(unsigned int, vq->num, vq->dev->iov_limit);

> >+      if (unlikely(!used_limit))
> >+              goto out;
> >+
> >       /* Avoid further vmexits, we're already processing the virtqueue =
*/
> >       vhost_disable_notify(&vsock->dev, vq);
> >
> >@@ -134,9 +163,20 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vso=
ck,
> >               u32 offset;
> >               int head;
> >
> >+              if (used_count =3D=3D used_limit) {
> >+                      if (vhost_vsock_flush_used(vq, used_count)) {
> >+                              added =3D true;
> >+                              used_count =3D 0;
> >+                      }
> >+              }
>
> Can we move this in the vhost_vsock_add_used() or just after calling it?
> IMO, it's easier to read: add something, check if I've reached the
> limit, then flush.
>

I'll move the check immediately after adding the used entry:

    vhost_vsock_add_used(vq, used_count, head,
                         sizeof(*hdr) + payload_len);
    used_count++;

    if (used_count =3D=3D used_limit) {
            added |=3D vhost_vsock_flush_used(vq, used_count);
            used_count =3D 0;
    }

> >+
> >               skb =3D virtio_vsock_skb_dequeue(&vsock->send_pkt_queue);
> >
> >               if (!skb) {
> >+                      if (vhost_vsock_flush_used(vq, used_count)) {
> >+                              added =3D true;
> >+                              used_count =3D 0;
> >+                      }
>
> Why you need this, if after the loop we are calling
> vhost_vsock_flush_used() in any case?
>

My reason for flushing there was that, when used_count > 0 and
skb is NULL, the batch can still contain completed RX descriptors that
have not yet been published. Flushing there makes those completions
visible sooner. I will follow your suggestion and rely on the flush
after the loop instead, which makes the control flow more uniform. I
will also measure the latency impact.

> >                       vhost_enable_notify(&vsock->dev, vq);
> >                       break;
> >               }
> >@@ -153,6 +193,10 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vso=
ck,
> >                       /* We cannot finish yet if more buffers snuck in =
while
> >                        * re-enabling notify.
> >                        */
>
> Move the comment or update it explaining why we are flushing.
>

I'll update the comment to explain why we flush on that path

> >+                      if (vhost_vsock_flush_used(vq, used_count)) {
> >+                              added =3D true;
> >+                              used_count =3D 0;
> >+                      }
> >                       if (unlikely(vhost_enable_notify(&vsock->dev, vq)=
)) {
> >                               vhost_disable_notify(&vsock->dev, vq);
> >                               continue;
> >@@ -230,8 +274,9 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsoc=
k,
> >                */
> >               virtio_transport_deliver_tap_pkt(skb);
> >
> >-              vhost_add_used(vq, head, sizeof(*hdr) + payload_len);
> >-              added =3D true;
> >+              vhost_vsock_add_used(vq, used_count, head,
> >+                                   sizeof(*hdr) + payload_len);
> >+              used_count++;
> >
> >               VIRTIO_VSOCK_SKB_CB(skb)->offset +=3D payload_len;
> >               total_len +=3D payload_len;
> >@@ -264,6 +309,10 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vso=
ck,
> >                       virtio_transport_consume_skb_sent(skb, true);
> >               }
> >       } while(likely(!vhost_exceeds_weight(vq, ++pkts, total_len)));
>
> Please leave a blank line here.
>

Understood

> >+      if (vhost_vsock_flush_used(vq, used_count)) {
> >+              added =3D true;
> >+              used_count =3D 0;
>
> Why setting this here that we are going to exit?
>
> IMO this can be simplified in:
>         added |=3D vhost_vsock_flush_used(vq, used_count);
>
> or you can collapse this in the check for the vhost_signal:
>
>         if (vhost_vsock_flush_used(vq, used_count) || added)
>                 vhost_signal(&vsock->dev, vq);
>
> >+      }
>

Thanks for pointing this out. Resetting used_count is unnecessary
since the function is about to return. I'll simplify it to:

added |=3D vhost_vsock_flush_used(vq, used_count);

> Please leave a blank line here.
>

Understood

> Stefano
>
> >       if (added)
> >               vhost_signal(&vsock->dev, vq);
> >
> >--
> >2.34.1
> >
>
