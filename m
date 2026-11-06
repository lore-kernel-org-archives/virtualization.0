Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793968174;
	b=VPQ4X1UPgCbroR7IvSTbMXbkqb1u9cGVBFmmkgZRxOz9SCgtC3iLWkIaP7678OSs1Vma
	 Xxkyi4kWTnlfz7xd/YTcnxQ4CNAiR0/OBxWVVxB3sF49IQGI5bqWXQWm+G8eItTPHrqSy
	 whdBGZS2mvVh1mB/5D6lpT2oggYCvwcaK3VOqyI3rLcTLHGlrjOO2EbiiIw+84aA8u2cY
	 0RuOhHcPfEHNiQXVvWhpdU8g3xU9ar/CTJ3E/TVyvpa3k0wYbQxWO9Y33gCXbVU/whrFb
	 KBYZTbSx+3xs7QMYAoAt+o0qhBhBBMjF+Fz8Lp8HmxLfacv5byUf0aUtZcF14l5rHqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=gH1mJSj/kyZPh+4tLVnw5BdMCKvmnBAyYQhJaAhQgzo=;
	b=MNUrZMu2/JIED5ttOc2ET+hw1MxvtjOr1AgyXX7c1HJjlK4s3cGvHBFCKbOwzTLKA+oR
	 OHpnju0kfY3BMJ5BIreMaAVRkroGADyseHYuhynhYv4q3/zFGGC3fWrx8gaT1CrTw44PO
	 5XJqUolxuTZfg0RPkp4D+9mEZs8qraMdI4sHk+BkQGeDgaYbM0iKE6VhQkQoYzCo4O1UW
	 9Hmag+TydXVdlBFqqR6As2P3q9Gf7p91cSLSUz3lT2nH+m1kDfZUgsH4nipTDuYNrk8is
	 qcNNwT3JCxhfppFM9PfsIdtq6cSaU/0z4xc3QOB8UQhSiSMhhNrEaW2zLV4d2ZHUC6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y6pbC6nA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F54606A32C
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 12:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7F54606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y6pbC6nA
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93f3c616c84so52520585a.1
        for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 04:29:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793968173; cv=none;
        d=google.com; s=arc-20260327;
        b=UomVWXo9E+NRbklHNAHxhgjbHA70fLpxeBHWUWjhw9V/GIpyrVmdqQ/3ZpDHx62ndC
         cmn6pqpWVID0HA8MrWJ+/ndE9o/Wdl+uI/8cKTnTZcfw0WrToLQpHNX1Rz8c0uHtWpHb
         yUBzwz1f8avKSpvpozE/O0SKd5caPJ317WTTKTdF18nQyhOmlrrxUHmjTGmW2oYrC8vc
         lQTrCjb2ZFIhpCx95z2rkVZMsY2udLeYZCqcXyBB/F4UdzTPJB87VTkFjKfo7+15JHoN
         rEyjltQTtJtMTnRw0YasZIHyAA2rKnKTQP1VjjY2eTpL09LaEGS1WHIOV7zE1Ha3j2u5
         evgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gH1mJSj/kyZPh+4tLVnw5BdMCKvmnBAyYQhJaAhQgzo=;
        fh=+YG0ELUnx2kqr7VlUYQGeyaOUZ0G8qrmzZg6CjSK16Y=;
        b=e0y2wJAxulx9R5atxTlBJ4yVkGxAQ0hp1PoBtsb7s1LBiiAWoQ5zuHg81+OOXDCD44
         vjwXRL4stytTcifVISbw8cRFiFk4pstl4i93QXNU85abwjTqImjesMz6N8jPyX+bp26n
         /W5SP0YthKa43/qBW3qmor4QjJQfK7fKbTCTQig1C0gXg7gAvg2g4VoqbZOwNluUefOt
         Cku5DZZhaenb+8jr75yg3vw/sx7r5hPjDIENsNQjJp9lVtZcd1+NVmjm1CjtLCxovrXG
         SmE+WzRPg67yuOky3AqkweZeYYSRjhIXT61bHHG05ZjE5Peh/YD3gqmudYsJwDCpeR4C
         iIHg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793968173; x=1794572973; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gH1mJSj/kyZPh+4tLVnw5BdMCKvmnBAyYQhJaAhQgzo=;
        b=y6pbC6nArRCzn4tfdwzVl+lSHYXqLgo+N7qnMEA9EkH0KcXZZKHA97HWV0gk3h/bR2
         O7bn0wpHfh0lgJaFsaVbMIlRsHOk6BaB37uXNS3ijiYRXI3AMXLmtkZonC8sTzKAa6QN
         cLdGa8bLhmK0ox+Fjtn/6hkqTNg2Btz2acbLZ9WUxgXJhU2uNrWuy8U64lKEIr6AYJfT
         auy2u114cbGG32w/NaSEz6NNJQPHUtxCOG0sSB1fj4IUYrQYX9JC3VDwsObm6S8tqL6F
         0+ihif+ujtaC0rLDJjGFJWEISutHfcqvCKyMRHGN5NOXd1mcZ9/SPtNMUeMMe9KIP9wB
         NeUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793968173; x=1794572973;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gH1mJSj/kyZPh+4tLVnw5BdMCKvmnBAyYQhJaAhQgzo=;
        b=WVUEACITlnJWIWXrmqYWtACaRSYwCp29WLhqrQJbm/6yeycvwjHx4UFgbEUJgqSl4J
         5Wk0ssyKBiwoUODTZS2AO3XbLj2vby5dSUqWFBmauAZ7lPjSpQTKeJQ8iryNRAptIKpz
         nkLu7Mv78aGWOhb+uJv6VQ8HwNtWpy4GDaPGrXJWA/1PFK3f8vPNtPhnwSMhFO9mSqF0
         LGEcplrwbZbIkAp5TrHcCJyMV6BSIki4uzbgZFIReEbWF2rGdTCJ4dkdCjpMH7HcS+xr
         yB0EgPJxzo5Q9tYTsoBWVdnJQ16xWuW/7QtCCwguuwZtwaxyH5oMozv8u7LepuuUEhAR
         8CGA==
X-Forwarded-Encrypted: i=1; AKwUvBx2NELnNUOuTemlFFYym4gKvukh3QjlS+F8VJA6xbheICjRXRQLLms3Z0ysXoP2kudDmKWZkIFzY40u7OTYbw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/8I0zp4JvrTrdYIFHFJrCvgmahMpTqCIMqU9NHsfhBSCe1O5nO
	QovlyHcQ/GebKrQMx28XzdNqR97+rXeDcs0lxpr1O7oIyRiztgpTgVwPtiPEcD8hqAyu9Uyo7FH
	P03Tmubi4QN+0kJGgKvr44abAy8RR444=
X-Gm-Gg: AYBFou17cMlmiLBHY+jGdy/qHWrLzwrPL0FzjDP3318NrXKpuemYnje8GLOBTS8QnwH
	PKtmvqTzdVAaawL6l5lYOo3W5jysRpQuy/3OV2xBT0qXHgUdW+0uYPVDajcOa/D3f5Rur/zuGNZ
	9xIHbMRlb+bnvhdiUuxO3GkhZaMtymJOoRJKMztf4dnT3jEdh9bEE6sH6ToLSpiYFvJx9AcDRLP
	R91EUhYlM2WpnM7O8SOi0AJOt6Nu3pwDKidQR6TiryQIO0dnNhFP4RUHDoOSSDIG6u9xS64InjW
	8XxTos5QDBfn6V2h629/jwd0QZePsY72VKEsQQ+34nBwuU8SxG1vI8mnSwiWIR0YUdIS6gTdqCo
	M7Y6IXsK32esyrm1ZLVNCEpha9BXrPU4EQ5lMSWvPOFV6/ZxobyCBhNOoUUNO1FAV09QbPWQ=
X-Received: by 2002:a05:620a:2794:b0:945:f28f:ce92 with SMTP id
 af79cd13be357-945f34b9241mr264204285a.40.1793968171614; Fri, 06 Nov 2026
 04:29:31 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261103041134.33310-1-physicalmtea@gmail.com>
 <20261103041134.33310-3-physicalmtea@gmail.com> <auxFXGVwY5IxlP5L@sgarzare-redhat>
In-Reply-To: <auxFXGVwY5IxlP5L@sgarzare-redhat>
From: Jia Jia <physicalmtea@gmail.com>
Date: Fri, 6 Nov 2026 20:28:55 +0800
X-Gm-Features: AclHuK8WSWZqF0YhOcKmUqT_DW8bT4U1CLlE79rQgfWA3WujjgxC2J69k28qsgw
Message-ID: <CAJwVaMLa2kNAtQvJkE-2aVX7M=pA4eNOTTHeixdZ919DbKu5Nw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 2/5] vsock/virtio: factor RX skb metadata
 budget check
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, stefanha@redhat.com, bobbyeshleman@gmail.com, 
	mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Tue, Nov 03, 2026 at 12:11:31PM +0800, Jia Jia wrote:
> >Extract the skb metadata budget check from virtio_transport_inc_rx_pkt()
> >into virtio_transport_rx_buf_full().
> >
> >The helper retains the existing condition and will be reused by a
> >following RX batching change.
> >
> >Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> >---
> > net/vmw_vsock/virtio_transport_common.c | 12 +++++++++---
> > 1 file changed, 9 insertions(+), 3 deletions(-)
> >
> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> >index 43325d7aebbb1..2a9cfed085515 100644
> >--- a/net/vmw_vsock/virtio_transport_common.c
> >+++ b/net/vmw_vsock/virtio_transport_common.c
> >@@ -576,11 +576,17 @@ virtio_transport_collapse_rx_queue(struct virtio_vsock_sock *vvs,
> >       skb_queue_splice(&new_queue, &vvs->rx_queue);
> > }
> >
> >-static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> >-                                      u32 len)
> >+static bool
> >+virtio_transport_rx_buf_full(struct virtio_vsock_sock *vvs)
> > {
> >       u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> >
> >+      return skb_overhead > vvs->buf_alloc;
> >+}
>
> As I pointed out in patch 3, I'm not sure we need this.
> After we introduced the collapse, SOCK_STREAM should collapse rx_queue
> before hitting this, so not sure we really need this function.
>
> Thanks,
> Stefano
>

This patch only factors out the existing metadata check from
virtio_transport_inc_rx_pkt() into virtio_transport_rx_buf_full() so
can_continue() in patch 3 can reuse it.

virtio_transport_recv_enqueue() attempts collapse when the queue is
already at this limit, and then inc_rx_pkt() runs the check again.
Collapse may not free enough slots: some skbs cannot be merged, and
allocation of a replacement skb can fail. As explained in the patch 3
reply, when virtio_transport_rx_buf_full() is true before the packet is
handled, the caller releases the socket lock. A waiting reader then has
a chance to drain before that packet reaches
virtio_transport_recv_enqueue().

> >+
> >+static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> >+                                      u32 len)
> >+{
> >       /* Allow at most buf_alloc * 2 total budget (payload + overhead),
> >        * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
> >        * metadata. Check payload against buf_alloc to be sure the other
> >@@ -588,7 +594,7 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> >        * queue growth.
> >        */
> >       if ((u64)vvs->buf_used + len > vvs->buf_alloc ||
> >-          skb_overhead > vvs->buf_alloc)
> >+          virtio_transport_rx_buf_full(vvs))
> >               return false;
> >
> >       vvs->rx_bytes += len;
> >--
> >2.53.0
> >
>
