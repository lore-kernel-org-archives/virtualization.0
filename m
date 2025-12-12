Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E400B30DEBB
	for <virtualization@lists.linux.dev>; Fri, 12 Dec 2025 12:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765542426; cv=none; b=Uxrh32VEhyqqO6Uf3uwUdoNR7MofGJvM5jCYI79/n3I5NmQG1eSH94OXo1mUUKesjZqDzk2tERirGNYymmHZy0nJsmF/Xj3hzbB1W4PEzDmKev2ZWUX8l78ExD5Uex4r2Mu9MHTJWRGwDU3RfC3gOjd2qzmfhBzuy9pb8eYFrhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765542426; c=relaxed/simple;
	bh=arpZlHgTP/Q2XHdUgjjUMg9eCk7R5xCuBgD64udECtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Q51lWThZSENI+emx0M5bw83MStSRBk2i2JorbdxvzfXG1qHxROb/DzDOhmiodCq4y3tHE9TwCSLxuUF0IhXiJjp0mcNPBKcCL8S6g0L2OdcjJvhkQZRYtnFYImqymHPrD+8uDbzzSNUf/BUBismDo2BUm8Ye3f+nyCmpCB3+ED0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RVBRp7wb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RVBRp7wb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765542423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L/arTEPx+inQ9VeH2LUAllPPM58s2xpZHbogC2hjw54=;
	b=RVBRp7wb1dUpb9jOnRD5QXeOt3OR5222yjh29MBNVin8l3UYUxE1p/n2cUz7NHW6RSIL5s
	FOdPCCIQfzb4s5qRv3zMKXjWpdDIuVjPlfaV7Xge3A0bD1QvJJJHQ2GzytBT4+Su6haVLR
	g4xG0nTVFpI4Z39MjBxa7PMlLij5PaE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-kF4q2Z91NWa7MItHXrhzMQ-1; Fri, 12 Dec 2025 07:27:02 -0500
X-MC-Unique: kF4q2Z91NWa7MItHXrhzMQ-1
X-Mimecast-MFC-AGG-ID: kF4q2Z91NWa7MItHXrhzMQ_1765542421
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b79f6dcde96so338462266b.2
        for <virtualization@lists.linux.dev>; Fri, 12 Dec 2025 04:27:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765542421; x=1766147221;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L/arTEPx+inQ9VeH2LUAllPPM58s2xpZHbogC2hjw54=;
        b=sVjSfg4JGyxeYg36vfHq7el9NIsktcmANv53LTwa3zGA2vHwnBfBknKzzgs4tbmpie
         vUgvwnL7jVceC2YLY/I4DwYuZNeS4b/1209jzLunA/G2AJe09jdtIb/kfMEPuFg63JK5
         Mn9E8o/026uPys5mgfB7CNrI8UuVwH29/Cq/HIDGkq7GGXonOi3LdzHD6phoAWGbwlHo
         nPePUHK9mjexZH03DDdh8MuqAPzP4ltugv2onpyFbiJS1kWMVeiwtlTA7RoZjBt0u0QN
         u3WMg5r7cCa9+BX8/OQDBP//eTTWPc8aw82Sp+9s9kZLAqELOulEg3527rrxSoQCoJFW
         0/LA==
X-Forwarded-Encrypted: i=1; AJvYcCUL3mN8Bqf2BREqyg1ZwW6tasROqecYCkPboOJGnkvyLisN417eZ6xOWSNgaAB01eybUzEp2oCcDOoWXuuU1w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQmS/FVKmAnSiAiMUVgcgpdmSCGm57j8DNno41AETePJPFV9oy
	VMNgI6+jt3nvAIhfpkquQJE4b28alBUTrkWGT8cscxt/emAdQWdeRGpa0PTy0WXGazfad37351j
	tQ5LJE6QUcE0VJ865nmRsg/Msd9NlvrDoxuw+3/zjmryadnrjBEXtCnNRqaLgBwV/s0qA
X-Gm-Gg: AY/fxX5hf1xIGfusVyx38PhM0F9HYRroTdqKhek3pLnflpPVyVjDINQasLNBPrMIf9O
	vF+9Vft/vzjd+k5j6/NGswyzuQgjAnJRkQRhsTKvdyEedL03hSczEEpzxUZwzldlPKjC9GTJ/Ux
	wRHT8jCzAFi44URdIzpN1eeLfx74SGvqIEEkyVBUwMIfxYvO0CNCpWQB9a4Yp6WYSf3YKC3oGze
	IAS3BVNVQhpXRxUpZQARPU9NL0p0fWr/q/akgJ5lCCgL3qp4gq6wr1Symi3INvopbZ9+nOXSlMk
	3tERKx8dRroDovQXmfp/I8Q7oK2IyM/mADmvZ8amxmi1L4F46IhRIEcgmc5sXijeC6Vd2lzEDHn
	Nzn3hifmGcfnlkMZmmLi5L88RxSe8yqzWWFfIK6ry31TrQoyA7sHHsbqHtG8uTw==
X-Received: by 2002:a17:907:7f23:b0:b73:3e15:a370 with SMTP id a640c23a62f3a-b7d23d0519emr166950466b.57.1765542421335;
        Fri, 12 Dec 2025 04:27:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJ8k95XyEgRKLOlMYKPgD8ZmrsPj3lizzCfh8rKYc1FUcJTIMFHxjLZLBoQTYJNZQdaPwGmw==
X-Received: by 2002:a17:907:7f23:b0:b73:3e15:a370 with SMTP id a640c23a62f3a-b7d23d0519emr166946666b.57.1765542420793;
        Fri, 12 Dec 2025 04:27:00 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it. [87.12.25.233])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cf9f38778sm570646266b.0.2025.12.12.04.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 04:27:00 -0800 (PST)
Date: Fri, 12 Dec 2025 13:26:44 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Melbin K Mathew <mlbnkm1@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, stefanha@redhat.com, 
	kvm@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH net v3] vsock/virtio: cap TX credit to local buffer size
Message-ID: <tandvvk6vas3kgqjuo6w3aagqai246qxejfnzhkbvbxds3w4y6@umqvf7f3m5ie>
References: <20251211125104.375020-1-mlbnkm1@gmail.com>
 <20251211080251-mutt-send-email-mst@kernel.org>
 <zlhixzduyindq24osaedkt2xnukmatwhugfkqmaugvor6wlcol@56jsodxn4rhi>
 <CAMKc4jDpMsk1TtSN-GPLM1M_qp_jpoE1XL1g5qXRUiB-M0BPgQ@mail.gmail.com>
 <CAGxU2F7WOLs7bDJao-7Qd=GOqj_tOmS+EptviMphGqSrgsadqg@mail.gmail.com>
 <CAMKc4jDLdcGsL5_d+4CP6n-57s-R0vzrX2M7Ni=1GeCB1cxVYA@mail.gmail.com>
 <bwmol6raorw233ryb3dleh4meaui5vbe7no53boixckl3wgclz@s6grefw5dqen>
 <deccf66c-dcd3-4187-9fb6-43ddf7d0a905@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <deccf66c-dcd3-4187-9fb6-43ddf7d0a905@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Bb5hSfJ62UbdxB1pPI33L4hINC1edweP-4JMe1DHGRU_1765542421
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Dec 12, 2025 at 11:40:03AM +0000, Melbin K Mathew wrote:
>
>
>On 12/12/2025 10:40, Stefano Garzarella wrote:
>>On Fri, Dec 12, 2025 at 09:56:28AM +0000, Melbin Mathew Antony wrote:
>>>Hi Stefano, Michael,
>>>
>>>Thanks for the suggestions and guidance.
>>
>>You're welcome, but please avoid top-posting in the future:
>>https://www.kernel.org/doc/html/latest/process/submitting- 
>>patches.html#use-trimmed-interleaved-replies-in-email-discussions
>>
>Sure. Thanks
>>>
>>>I’ve drafted a 4-part series based on the recap. I’ve included the
>>>four diffs below for discussion. Can wait for comments, iterate, and
>>>then send the patch series in a few days.
>>>
>>>---
>>>
>>>Patch 1/4 — vsock/virtio: make get_credit() s64-safe and clamp negatives
>>>
>>>virtio_transport_get_credit() was doing unsigned arithmetic; if the
>>>peer shrinks its window, the subtraction can underflow and look like
>>>“lots of credit”. This makes it compute “space” in s64 and clamp < 0
>>>to 0.
>>>
>>>diff --git a/net/vmw_vsock/virtio_transport_common.c
>>>b/net/vmw_vsock/virtio_transport_common.c
>>>--- a/net/vmw_vsock/virtio_transport_common.c
>>>+++ b/net/vmw_vsock/virtio_transport_common.c
>>>@@ -494,16 +494,23 @@ 
>>>EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
>>>u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 
>>>credit)
>>>{
>>>+ s64 bytes;
>>> u32 ret;
>>>
>>> if (!credit)
>>> return 0;
>>>
>>> spin_lock_bh(&vvs->tx_lock);
>>>- ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>>>- if (ret > credit)
>>>- ret = credit;
>>>+ bytes = (s64)vvs->peer_buf_alloc -
>>
>>Why not just calling virtio_transport_has_space()?
>virtio_transport_has_space() takes struct vsock_sock *, while 
>virtio_transport_get_credit() takes struct virtio_vsock_sock *, so I 
>cannot directly call has_space() from get_credit() without changing 
>signatures.
>
>Would you be OK if I factor the common “space” calculation into a 
>small helper that operates on struct virtio_vsock_sock * and is used 
>by both paths? Something like:

Why not just change the signature of virtio_transport_has_space()?

Thanks,
Stefano

>
>/* Must be called with vvs->tx_lock held. Returns >= 0. */
>static s64 virtio_transport_tx_space(struct virtio_vsock_sock *vvs)
>{
>	s64 bytes;
>
>	bytes = (s64)vvs->peer_buf_alloc -
>		((s64)vvs->tx_cnt - (s64)vvs->peer_fwd_cnt);
>	if (bytes < 0)
>		bytes = 0;
>
>	return bytes;
>}
>
>Then:
>
>get_credit() would do bytes = virtio_transport_tx_space(vvs); ret = 
>min_t(u32, credit, (u32)bytes);
>
>has_space() would use the same helper after obtaining vvs = vsk->trans;
>
>Does that match what you had in mind, or would you prefer a different 
>factoring?
>
>>
>>>+ ((s64)vvs->tx_cnt - (s64)vvs->peer_fwd_cnt);
>>>+ if (bytes < 0)
>>>+ bytes = 0;
>>>+
>>>+ ret = min_t(u32, credit, (u32)bytes);
>>> vvs->tx_cnt += ret;
>>> vvs->bytes_unsent += ret;
>>> spin_unlock_bh(&vvs->tx_lock);
>>>
>>> return ret;
>>>}
>>>
>>>
>>>---
>>>
>>>Patch 2/4 — vsock/virtio: cap TX window by local buffer (helper + use
>>>everywhere in TX path)
>>>
>>>Cap the effective advertised window to min(peer_buf_alloc, buf_alloc)
>>>and use it consistently in TX paths (get_credit, has_space,
>>>seqpacket_enqueue).
>>>
>>>diff --git a/net/vmw_vsock/virtio_transport_common.c
>>>b/net/vmw_vsock/virtio_transport_common.c
>>>--- a/net/vmw_vsock/virtio_transport_common.c
>>>+++ b/net/vmw_vsock/virtio_transport_common.c
>>>@@ -491,6 +491,16 @@ void virtio_transport_consume_skb_sent(struct
>>>sk_buff *skb, bool consume)
>>>}
>>>EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
>>>+/* Return the effective peer buffer size for TX credit computation.
>>>+ *
>>>+ * The peer advertises its receive buffer via peer_buf_alloc, but 
>>>we cap it
>>>+ * to our local buf_alloc (derived from SO_VM_SOCKETS_BUFFER_SIZE and
>>>+ * already clamped to buffer_max_size).
>>>+ */
>>>+static u32 virtio_transport_tx_buf_alloc(struct virtio_vsock_sock *vvs)
>>>+{
>>>+ return min(vvs->peer_buf_alloc, vvs->buf_alloc);
>>>+}
>>>
>>>u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 
>>>credit)
>>>{
>>> s64 bytes;
>>>@@ -502,7 +512,8 @@ u32 virtio_transport_get_credit(struct
>>>virtio_vsock_sock *vvs, u32 credit)
>>> return 0;
>>>
>>> spin_lock_bh(&vvs->tx_lock);
>>>- bytes = (s64)vvs->peer_buf_alloc -
>>>+ bytes = (s64)virtio_transport_tx_buf_alloc(vvs) -
>>> ((s64)vvs->tx_cnt - (s64)vvs->peer_fwd_cnt);
>>> if (bytes < 0)
>>> bytes = 0;
>>>@@ -834,7 +845,7 @@ virtio_transport_seqpacket_enqueue(struct 
>>>vsock_sock *vsk,
>>> spin_lock_bh(&vvs->tx_lock);
>>>
>>>- if (len > vvs->peer_buf_alloc) {
>>>+ if (len > virtio_transport_tx_buf_alloc(vvs)) {
>>> spin_unlock_bh(&vvs->tx_lock);
>>> return -EMSGSIZE;
>>> }
>>>@@ -884,7 +895,8 @@ static s64 virtio_transport_has_space(struct
>>>vsock_sock *vsk)
>>> struct virtio_vsock_sock *vvs = vsk->trans;
>>> s64 bytes;
>>>
>>>- bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>>>+ bytes = (s64)virtio_transport_tx_buf_alloc(vvs) -
>>>+ ((s64)vvs->tx_cnt - (s64)vvs->peer_fwd_cnt);
>>> if (bytes < 0)
>>> bytes = 0;
>>>
>>> return bytes;
>>>}
>>>
>>>
>>>---
>>>
>>>Patch 3/4 — vsock/test: fix seqpacket msg bounds test (set client 
>>>buf too)
>>
>>Please just include in the series the patch I sent to you.
>>
>Thanks. I'll use your vsock_test.c patch as-is for 3/4
>>>
>>>After fixing TX credit bounds, the client can fill its TX window and
>>>block before it wakes the server. Setting the buffer on the client
>>>makes the test deterministic again.
>>>
>>>diff --git a/tools/testing/vsock/vsock_test.c 
>>>b/tools/testing/vsock/ vsock_test.c
>>>--- a/tools/testing/vsock/vsock_test.c
>>>+++ b/tools/testing/vsock/vsock_test.c
>>>@@ -353,6 +353,7 @@ static void test_stream_msg_peek_server(const
>>>struct test_opts *opts)
>>>
>>>static void test_seqpacket_msg_bounds_client(const struct 
>>>test_opts *opts)
>>>{
>>>+ unsigned long long sock_buf_size;
>>> unsigned long curr_hash;
>>> size_t max_msg_size;
>>> int page_size;
>>>@@ -366,6 +367,18 @@ static void
>>>test_seqpacket_msg_bounds_client(const struct test_opts *opts)
>>> exit(EXIT_FAILURE);
>>> }
>>>
>>>+ sock_buf_size = SOCK_BUF_SIZE;
>>>+
>>>+ setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
>>>+    sock_buf_size,
>>>+    "setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
>>>+
>>>+ setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>>>+    sock_buf_size,
>>>+    "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
>>>+
>>> /* Wait, until receiver sets buffer size. */
>>> control_expectln("SRVREADY");
>>>
>>>
>>>---
>>>
>>>Patch 4/4 — vsock/test: add stream TX credit bounds regression test
>>>
>>>This directly guards the original failure mode for stream sockets: if
>>>the peer advertises a large window but the sender’s local policy is
>>>small, the sender must stall quickly (hit EAGAIN in nonblocking mode)
>>>rather than queueing megabytes.
>>
>>Yeah, using nonblocking mode LGTM!
>>
>>>
>>>diff --git a/tools/testing/vsock/vsock_test.c 
>>>b/tools/testing/vsock/ vsock_test.c
>>>--- a/tools/testing/vsock/vsock_test.c
>>>+++ b/tools/testing/vsock/vsock_test.c
>>>@@ -349,6 +349,7 @@
>>>#define SOCK_BUF_SIZE (2 * 1024 * 1024)
>>>+#define SMALL_SOCK_BUF_SIZE (64 * 1024ULL)
>>>#define MAX_MSG_PAGES 4
>>>
>>>/* Insert new test functions after test_stream_msg_peek_server, before
>>> * test_seqpacket_msg_bounds_client (around line 352) */
>>>
>>>+static void test_stream_tx_credit_bounds_client(const struct 
>>>test_opts *opts)
>>>+{
>>>+ ... /* full function as provided */
>>>+}
>>>+
>>>+static void test_stream_tx_credit_bounds_server(const struct 
>>>test_opts *opts)
>>>+{
>>>+ ... /* full function as provided */
>>>+}
>>>
>>>@@ -2224,6 +2305,10 @@
>>> .run_client = test_stream_msg_peek_client,
>>> .run_server = test_stream_msg_peek_server,
>>> },
>>>+ {
>>>+ .name = "SOCK_STREAM TX credit bounds",
>>>+ .run_client = test_stream_tx_credit_bounds_client,
>>>+ .run_server = test_stream_tx_credit_bounds_server,
>>>+ },
>>
>>Please put it at the bottom. Tests are skipped by index, so we don't 
>>want to change index of old tests.
>>
>>Please fix your editor, those diffs are hard to read without tabs/spaces.
>seems like some issue with my email client. Hope it is okay now
>>
>>Thanks,
>>Stefano
>>
>

