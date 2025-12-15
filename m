Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAAB33B96F
	for <virtualization@lists.linux.dev>; Mon, 15 Dec 2025 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808140; cv=none; b=rmccSDA12OH/AAUmc8G5Ruxzy/mkpYe9raCc4tJD4klkTFrFh17MvztUDDCLBhINhqoP6bh56nJje3bbeGmI0wMDDb/blMdYGmCh1nvV13jr0iWUmUM6JgtOSG+IjvyPKq6rhmKkI40/l7BEelduqTf8BRW0Kp5sx9vE+e0n5iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808140; c=relaxed/simple;
	bh=XCaTRYYtdjBnDMmtW6LMz2eDeLZgPQs0Zj1KdxrUzfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eSRrQN1TfXLEqv17X8dpJXBTVWXz5D0fAmTBK3AAAbay9E8uRPvK8wM4EpWhtmjtU8B3+YC4/tiAmfukfx8egi4Zu9b6S4yiZtryzYeWdtSMPPX/AcnMjsshMxpHey1m1wtf0k9Jk/FdGNp3JC8eLH5+HY5QZ6Bxt5OvVZm3BsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SyAaXabP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SyAaXabP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765808134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L49NIO1n5q1751W/k8gzxOpfDxRxrpcTIrbILgaPsTg=;
	b=SyAaXabPOew/UPzAF/9JpNlLNz85XzGdgrkLONai9PtUh5eZApVGEp9AV4XQ8c9RB0w9mM
	n7ymdzNq9umdUU5BK9+voxi5jg7YbE7L7aBQy1y7GvwtXOsscHjbzppIFb7wsee3Rb7kD7
	fs4kXJPhh6IU1eAm39TjAvqwAqeQR+w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-OZzCGeUHOaOJ4QDW9Q3tEg-1; Mon, 15 Dec 2025 09:15:33 -0500
X-MC-Unique: OZzCGeUHOaOJ4QDW9Q3tEg-1
X-Mimecast-MFC-AGG-ID: OZzCGeUHOaOJ4QDW9Q3tEg_1765808132
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477964c22e0so24534965e9.0
        for <virtualization@lists.linux.dev>; Mon, 15 Dec 2025 06:15:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808132; x=1766412932;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L49NIO1n5q1751W/k8gzxOpfDxRxrpcTIrbILgaPsTg=;
        b=T1fsS3weLq9aEVriYaDP/grvHCbjEubIXqkCIUjtYjhgqQyKBnYFNOoiGnSaSSSNmW
         exhZ9t5NEV5xexa30dOzHFLBdVzBpGiKgGVwVDhTlglhyliWwcz6di+T/1UvhXgLI6Fk
         da8V2mGExHSYQYc3bv/sIHomr8Zhm3d50XCC4CDYLXHjPlo+mAFYWHXtB02pLB1pgad5
         VGQ3abBHfOBcUOb6DTyqRII17ymY2TXDMp6Ja9dWikeUty/5uNlCssDT4k9nMfBvBRIO
         XdmUqTo+iobdjzDhiOLV2J606dAkFLU7jZ6IyCr6jw1HQAR836uCc4NuuFrymnRurtJD
         +WzA==
X-Forwarded-Encrypted: i=1; AJvYcCVK9aCdu2ll9sAz+vw5NVX8UcKH2ZqU8tZwaV/rg7WIsoGRgXDYmi0Si0kk3Ba/YpUPAOSufLfi/XQ/FIPhIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDyzAS6tiU9YPu/AQjuR2RozDbkUwqsF1dgwXq2ly3A3CPzlm6
	fli5zE8pP5NPLMIfqRFfm6auwJvQ1JrWeUmWbblRDYS2Tgz/pPwKelsvCW0Apb2jG96hra6nWsR
	IsA+l1uokkr7q6e9W5SrvHnVR99UH/SoN1vjfZ/h3fH9u4sKjv6QXqIqb/DUCN4v0QPWY
X-Gm-Gg: AY/fxX5fGEbcIPqE8P3bm+wYnwPK6V/00CwWeTmEnbh8K83iTeevejHhxoi3Vb0qhNr
	DaMNptnhlb8OYl6EHHB7bnc7KkW1w+QllgTnnmoW/Cn0lDfbSY5pzEysgp6Lx0KKUVzmNrjg8q9
	IVF1dzfM2hncfx3IOyhh3LW4qQfrWnYbUGm7zKV56sPo03Z3PMkDt3F/ykVmGE/du2124p6J1N1
	9bDqWH7FDqdRVrV+nyLa5W/mO/yNMeOMO1JBnxmUXY1kgo30k/2zbfc+CcqjLZmzIjcMRTnRvTo
	5Qaq01PXfU1XOgheZc0r28PQe+FZNjMCB6fTp6mICsYwfOWOS95QORl9cgodK5m9RjH1HWF85e4
	lHAn5hucrEdduYZSe
X-Received: by 2002:a05:600c:c0d2:10b0:477:9cec:c83e with SMTP id 5b1f17b1804b1-47a89d9c2f9mr119399515e9.1.1765808132061;
        Mon, 15 Dec 2025 06:15:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnn39+IGc8T4gbIMiapFrAkLpdN3U9Oa1ixlw3v9TO5MUF+UqsPDl1fUxMRulxmuHP3h3NgA==
X-Received: by 2002:a05:600c:c0d2:10b0:477:9cec:c83e with SMTP id 5b1f17b1804b1-47a89d9c2f9mr119399175e9.1.1765808131556;
        Mon, 15 Dec 2025 06:15:31 -0800 (PST)
Received: from sgarzare-redhat ([193.207.203.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f8e90f2sm186130175e9.13.2025.12.15.06.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:15:30 -0800 (PST)
Date: Mon, 15 Dec 2025 15:15:22 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Melbin K Mathew <mlbnkm1@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, stefanha@redhat.com, 
	kvm@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH net v3] vsock/virtio: cap TX credit to local buffer size
Message-ID: <wssxyvbgq3a3icydzxsbj5bliqd67xreffaqqusfia2suxrjdk@gcke3jemvycx>
References: <20251211125104.375020-1-mlbnkm1@gmail.com>
 <20251211080251-mutt-send-email-mst@kernel.org>
 <zlhixzduyindq24osaedkt2xnukmatwhugfkqmaugvor6wlcol@56jsodxn4rhi>
 <CAMKc4jDpMsk1TtSN-GPLM1M_qp_jpoE1XL1g5qXRUiB-M0BPgQ@mail.gmail.com>
 <CAGxU2F7WOLs7bDJao-7Qd=GOqj_tOmS+EptviMphGqSrgsadqg@mail.gmail.com>
 <CAMKc4jDLdcGsL5_d+4CP6n-57s-R0vzrX2M7Ni=1GeCB1cxVYA@mail.gmail.com>
 <bwmol6raorw233ryb3dleh4meaui5vbe7no53boixckl3wgclz@s6grefw5dqen>
 <deccf66c-dcd3-4187-9fb6-43ddf7d0a905@gmail.com>
 <tandvvk6vas3kgqjuo6w3aagqai246qxejfnzhkbvbxds3w4y6@umqvf7f3m5ie>
 <24b9961d-7e0d-4239-97b3-39799524909f@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <24b9961d-7e0d-4239-97b3-39799524909f@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fUI0twojPWtgp4V86mJtauexy3ngaKyPVaEbLg3zmQk_1765808132
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sun, Dec 14, 2025 at 06:38:22AM +0000, Melbin K Mathew wrote:
>
>
>On 12/12/2025 12:26, Stefano Garzarella wrote:
>>On Fri, Dec 12, 2025 at 11:40:03AM +0000, Melbin K Mathew wrote:
>>>
>>>
>>>On 12/12/2025 10:40, Stefano Garzarella wrote:
>>>>On Fri, Dec 12, 2025 at 09:56:28AM +0000, Melbin Mathew Antony wrote:
>>>>>Hi Stefano, Michael,
>>>>>
>>>>>Thanks for the suggestions and guidance.
>>>>
>>>>You're welcome, but please avoid top-posting in the future:
>>>>https://www.kernel.org/doc/html/latest/process/submitting- 
>>>>patches.html#use-trimmed-interleaved-replies-in-email-discussions
>>>>
>>>Sure. Thanks
>>>>>
>>>>>I’ve drafted a 4-part series based on the recap. I’ve included the
>>>>>four diffs below for discussion. Can wait for comments, iterate, and
>>>>>then send the patch series in a few days.
>>>>>
>>>>>---
>>>>>
>>>>>Patch 1/4 — vsock/virtio: make get_credit() s64-safe and clamp 
>>>>>negatives
>>>>>
>>>>>virtio_transport_get_credit() was doing unsigned arithmetic; if the
>>>>>peer shrinks its window, the subtraction can underflow and look like
>>>>>“lots of credit”. This makes it compute “space” in s64 and clamp < 0
>>>>>to 0.
>>>>>
>>>>>diff --git a/net/vmw_vsock/virtio_transport_common.c
>>>>>b/net/vmw_vsock/virtio_transport_common.c
>>>>>--- a/net/vmw_vsock/virtio_transport_common.c
>>>>>+++ b/net/vmw_vsock/virtio_transport_common.c
>>>>>@@ -494,16 +494,23 @@ 
>>>>>EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
>>>>>u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, 
>>>>>u32 credit)
>>>>>{
>>>>>+ s64 bytes;
>>>>> u32 ret;
>>>>>
>>>>> if (!credit)
>>>>> return 0;
>>>>>
>>>>> spin_lock_bh(&vvs->tx_lock);
>>>>>- ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>>>>>- if (ret > credit)
>>>>>- ret = credit;
>>>>>+ bytes = (s64)vvs->peer_buf_alloc -
>>>>
>>>>Why not just calling virtio_transport_has_space()?
>>>virtio_transport_has_space() takes struct vsock_sock *, while 
>>>virtio_transport_get_credit() takes struct virtio_vsock_sock *, so 
>>>I cannot directly call has_space() from get_credit() without 
>>>changing signatures.
>>>
>>>Would you be OK if I factor the common “space” calculation into a 
>>>small helper that operates on struct virtio_vsock_sock * and is 
>>>used by both paths? Something like:
>>
>>Why not just change the signature of virtio_transport_has_space()?
>Thanks, that is cleaner.
>
>For Patch 1 i'll change virtio_transport_has_space() to take
>struct virtio_vsock_sock * and call it from both
>virtio_transport_stream_has_space() and virtio_transport_get_credit().
>
>/*
> * Return available peer buffer space for TX (>= 0).
> *
> * Use s64 arithmetic so that if the peer shrinks peer_buf_alloc while
> * we have bytes in flight (tx_cnt - peer_fwd_cnt), the subtraction does
> * not underflow into a large positive value as it would with u32.
> *
> * Must be called with vvs->tx_lock held.
> */
>static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs)
>{
>	s64 bytes;
>
>	bytes = (s64)vvs->peer_buf_alloc -
>		((s64)vvs->tx_cnt - (s64)vvs->peer_fwd_cnt);

wait, why casting also the counters?
they are supposed to wrap, so should be fine to avoid the cast there.

Please, avoid too many changes in a single patch.

>	if (bytes < 0)
>		bytes = 0;
>
>	return bytes;
>}
>
>s64 virtio_transport_stream_has_space(struct vsock_sock *vsk)
>{
>	struct virtio_vsock_sock *vvs = vsk->trans;
>	s64 bytes;
>
>	spin_lock_bh(&vvs->tx_lock);
>	bytes = virtio_transport_has_space(vvs);
>	spin_unlock_bh(&vvs->tx_lock);
>
>	return bytes;
>}
>
>u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
>{
>	u32 ret;
>
>	if (!credit)
>		return 0;
>
>	spin_lock_bh(&vvs->tx_lock);
>	ret = min_t(u32, credit, (u32)virtio_transport_has_space(vvs));

min_t() is supposed to be use exactly to avoid to cast each member, so 
why adding the cast to the value returned by 
virtio_transport_has_space() ?

>	vvs->tx_cnt += ret;
>	vvs->bytes_unsent += ret;
>	spin_unlock_bh(&vvs->tx_lock);
>
>	return ret;
>}
>
>Does this look right?

Pretty much yes, a part some comments, but I'd like to see the final 
solution.

Thanks,
Stefano

