Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A57331A66
	for <virtualization@lists.linux.dev>; Thu, 18 Dec 2025 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766049595; cv=none; b=LuX36jiQbtLtsmmsR5u6h64pj/cCblwan4LE11H4cbOitbuOe2wnsOSrwk0vCCgoXcFVRI6If/p5tPeyqo/KUDghb2dhg0vB08Nopg22vI1y1Oto51k4yd0NLKhW6I68tAq/2KBp31/BnGqVajzwGtos3+Q70Ov7vSi8veH9Mic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766049595; c=relaxed/simple;
	bh=yt0+W7rSVC5sqG/HWU1LuerYwILbmVgG+28GWJkkJF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sd4bCQGzM7vi+H4s/SRhg/HqIFXqdG0yUHLNHKarzreLkmgXb5Wf7NS5z13ad8zArG830gmvkYgrZ6o0YU54g5MicGeJGAE4W3h8P4au20bdPSIQaj0pT+ipMLwCH6WWUAczMOkdjGVo0hizEXlXqTicwtYiR4IFEOaxAHSEsA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NAnnD4xt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NAnnD4xt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766049592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5DGUhTzB3JPaoSv5rwYKyV5NjPUkuU9Lam+Ho2USOIg=;
	b=NAnnD4xtekNjrs3HTqLMQFB1m+osh+STmgKUZX90PSD5KjiIWrmUrQdYGgmQEromIi4lIL
	GnC3RK8t3LUsckxpwhHukZd2lmbyzw8HOV8DtdOiimmuSCcDweO9La8X7fK+vWyNx471u4
	xkxP8GuNByarauiTvB5RKppIWn3K4e4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-C6J5BByvNZOaQCrS3CqZSA-1; Thu, 18 Dec 2025 04:19:51 -0500
X-MC-Unique: C6J5BByvNZOaQCrS3CqZSA-1
X-Mimecast-MFC-AGG-ID: C6J5BByvNZOaQCrS3CqZSA_1766049590
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b79f8db2c81so55547966b.1
        for <virtualization@lists.linux.dev>; Thu, 18 Dec 2025 01:19:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766049590; x=1766654390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5DGUhTzB3JPaoSv5rwYKyV5NjPUkuU9Lam+Ho2USOIg=;
        b=tOzuWebZgCVqDR7Ml+NUMaKO5OWjOmBPonSmawXXt5FvTkpBIcHeM9xMrmxZC2n/Ly
         AdEEAthiuRZaoSLxO3G2wSL70pG89+jFvK51GvOXEzqGre1U+mbVvX/+bG0Mf+u6E3uL
         YYqjXPbH9EAnIJH8u/iwl8Zba02eU4izr7YqSjcu+pvO6VCiQvaKfA3Hln4fx78i1UXh
         Ku0A2R27MG8T1hs7YX0FtISjwKFblLtPckvPf4BEnHtIhT7zSpswfWOxtfmWmmjcRc2u
         y5PPAZR0f9ld6QaewMISUTl8mGJRxwnGhDqJ8U5dWIVlagj2BimoKiA5emIdIg1IopaB
         C8sg==
X-Forwarded-Encrypted: i=1; AJvYcCUz6srA9YB1T7pqxc9RGdgGpPgvvL6m/2rdvWMTrnFM/ACbAr7OwH/5CUM8XxGito6yZmHsDLN5JYslv1s34w==@lists.linux.dev
X-Gm-Message-State: AOJu0YypnvmuRSBHiAXl8ALVTLskopb4q9BWKTe5toO+D17s3ET3wxdT
	I2bihl5wHtNQ2c5u6fQLm7N0QPJiJM24wRXLILBdqlNs8zLyMB9/kW0m51yN641CqB7CiMzHthF
	nzYi3dPK8FCAjSH8sA2ujawgWX27jRADz2dhU5Lcudzgij35EXH2X8Dmfyh0hLM5Brac4
X-Gm-Gg: AY/fxX5eXAIQcHf73iHOphDwvAgXt+qytNZ/OnZYRGsedyAHvB5RupeSxfvVIxhR2u2
	tjCLfLZPUtSYDiaSVKiJdDWEf3ycq3KCzKYHB6BNGn0Dsob/Ukq+NDeqsUVCgRx4i2+14QTTrSG
	nqgJJVRjkGQW535V2ChbTiYGTBhotro+tDKyQxN8tj/IuMqygBLuVgM6g4BGhgNM152cR5G+QcH
	8O5iLBLLz3sM7zP2XKzixw1xLQ2Ns9fiSAeQW7IiWcuvMxfUa4VZt8Zf00tdUFsEccxW9LinJ3c
	vIRIHGOpMgBOnqu/RcyJN3eifithudDgLraPG8bO3RW9/Y9JY7kcQAWBkLCIPqRdtOreBYM+Pv1
	ql3EDEBRf7O34xmQ=
X-Received: by 2002:a17:907:94c7:b0:b76:b921:d961 with SMTP id a640c23a62f3a-b7d23619397mr2068560966b.2.1766049590073;
        Thu, 18 Dec 2025 01:19:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwBxz8gZtgWPTcDUiRKsVSV+WI8XYHTkiS4tl6rPio3Z5g8v52QwhDNNNXIZbHjAuO8agkcQ==
X-Received: by 2002:a17:907:94c7:b0:b76:b921:d961 with SMTP id a640c23a62f3a-b7d23619397mr2068558266b.2.1766049589503;
        Thu, 18 Dec 2025 01:19:49 -0800 (PST)
Received: from sgarzare-redhat ([193.207.200.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b58891994sm1894793a12.29.2025.12.18.01.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 01:19:48 -0800 (PST)
Date: Thu, 18 Dec 2025 10:19:42 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Melbin K Mathew <mlbnkm1@gmail.com>
Cc: stefanha@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org
Subject: Re: [PATCH net v4 1/4] vsock/virtio: fix potential underflow in
 virtio_transport_get_credit()
Message-ID: <7oq7ejyud46smrlinz543xrczxyiz5bor62o7xpg6g4eiaa4ad@chcc25mgxc5q>
References: <20251217181206.3681159-1-mlbnkm1@gmail.com>
 <20251217181206.3681159-2-mlbnkm1@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251217181206.3681159-2-mlbnkm1@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uSYqfFY4QDY1CU1_HtcXO6it7VZjOihV6y9ev5QkeaM_1766049590
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Dec 17, 2025 at 07:12:03PM +0100, Melbin K Mathew wrote:
>The credit calculation in virtio_transport_get_credit() uses unsigned
>arithmetic:
>
>  ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>
>If the peer shrinks its advertised buffer (peer_buf_alloc) while bytes
>are in flight, the subtraction can underflow and produce a large
>positive value, potentially allowing more data to be queued than the
>peer can handle.
>
>Use s64 arithmetic for the subtraction and clamp negative results to
>zero, matching the approach already used in virtio_transport_has_space().
>
>Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 17 ++++++++++++++---
> 1 file changed, 14 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index dcc8a1d5851e..d692b227912d 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -494,14 +494,25 @@ EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
> u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
> {
> 	u32 ret;
>+	u32 inflight;
>+	s64 bytes;
>
> 	if (!credit)
> 		return 0;
>
> 	spin_lock_bh(&vvs->tx_lock);
>-	ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>-	if (ret > credit)
>-		ret = credit;
>+
>+	/*
>+	 * Compute available space using s64 to avoid underflow if
>+	 * peer_buf_alloc < inflight bytes (can happen if peer shrinks
>+	 * its advertised buffer while data is in flight).
>+	 */
>+	inflight = vvs->tx_cnt - vvs->peer_fwd_cnt;
>+	bytes = (s64)vvs->peer_buf_alloc - inflight;

I'm really confused, in our previous discussion we agreed on re-using
virtio_transport_has_space(), what changend in the mean time?

Stefano

>+	if (bytes < 0)
>+		bytes = 0;
>+
>+	ret = (bytes > credit) ? credit : (u32)bytes;
> 	vvs->tx_cnt += ret;
> 	vvs->bytes_unsent += ret;
> 	spin_unlock_bh(&vvs->tx_lock);
>-- 
>2.34.1
>

