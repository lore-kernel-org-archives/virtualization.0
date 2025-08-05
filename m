Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F02201269
	for <virtualization@lists.linux.dev>; Tue,  5 Aug 2025 07:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754378543; cv=none; b=Zcb9HSesxZ6VTW2lyc01EX0C3NvWgS1dXJk2iqNOX4PzLLE6ghlMU63R5QNJaNLTtlMHOXIObijsn7e3lyrwUbvMyM5otCD4LlgxtYeyrpNoKFYKR7Mw7P5X5v4m4cpx5YWHsu7umFCF+S1nFufhHxI2yiRZIefxMm7t4NIkqLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754378543; c=relaxed/simple;
	bh=Rk0SHI+PWqhqEbwPZy9Q1SRiwPsOpKQ9ER7M3n76sCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rGzFaXrWBjaFMx0UDVSuPSOZTudGMYPWmpGiQjD+mGsjnHvMsmRr+jv0SGhMp8v1sD07KZCQxovBCXGayFDQRyx6MYUxq5ZF3xtEy0ERFzbPeuU8jcywfYs9Pyrt4v/IeXA3wyQZ367/LnmTW29U45w9xzyJ8tjosq/JxitbbOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e9eLQCdT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9eLQCdT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754378541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VxjW/XUa/Tox1i570xeV1gDkoladwDp8K5HU/5Xe5bM=;
	b=e9eLQCdTl9VMlMeMi5EBs8DCdN5Q4CVlEgD/DG2/wL3UeoStEsgF1v2rn1Ta+3LHqkl8XE
	NQTgWsaMLE5Y0YD8SynBz4NZ/3IazAG/jz4UIIDw5YQr0DtZ8SwSfvbgHYKdeCIhDuezzx
	kYh2jP1jyfJm9e+gP9TUAxFm37UAoxw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-Qoe9REY7O3abruVX3fAMWA-1; Tue, 05 Aug 2025 03:22:19 -0400
X-MC-Unique: Qoe9REY7O3abruVX3fAMWA-1
X-Mimecast-MFC-AGG-ID: Qoe9REY7O3abruVX3fAMWA_1754378539
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4aedcff08fdso85389601cf.2
        for <virtualization@lists.linux.dev>; Tue, 05 Aug 2025 00:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754378539; x=1754983339;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VxjW/XUa/Tox1i570xeV1gDkoladwDp8K5HU/5Xe5bM=;
        b=jgxRbqAq+l5pRDL1EJ0bc1Aap+XvJpIk9v559yn+3leSiCpnVhTe1bf8l2nomjipdb
         nr9OrFNVGR0Zb9jqYlzIVuhXPXU35YhuDDEZiwCtDDOhBQ8Rm3mYIfx3Rv0TTYH+fu8g
         QI3AIR71ej0BcKGSho3sScQiItFLvFkpGIMy24KylOmCXbvWuL/qUpH1HDVZc1RKORUg
         6I9agSAr5b44akmxT8/ctcv9puO4wuxUKIAl3Uq7GKmRIZUVDBlSxgqnPB6TT4id7slx
         +901C3JmCux0U1oRldZZIdFu2Siqwb8PtVHlOxN/s1FAzM2RSyD4LK5b8h+5P7Pg2yop
         rLMg==
X-Forwarded-Encrypted: i=1; AJvYcCUHg9slKnsbGiMijv4A+wY9aa4w+311vaFuL0mvzVwGFG5qJ8rMYpz0LUdOEZDufETMrL8ggTr3UHFQk+4Q1A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYkjgVd7Inz9lqLUqxzeYxDHsTqsS7MGo25V7KWiMycYl80Ipd
	u347vxyW9utEwymbnZhD5IlpBILBCzXYb/LgjfpM8+n5m9JPgMFAdnzLasAnoDZVHC3hOrP5GFF
	YrPYZq7gNwyjPYXQ/wH4u6nvJHv2G5So/wcoiiC4yyACj/k1QQR0ksVXLtRCR2p0mWG1x
X-Gm-Gg: ASbGnctU3/EG2KF5x1oJwc7fK7LPsTxAsorVJpjo1gnplSEVCJhDsUBZmUMWyIx1eMR
	ZEBGf9t364KROtA2JXnsiOLY2ccmBVyMupeLrAIJfP5EL5PlAqW0Pcma10ZUwffifsWsQjDf5pi
	6bqzKfPiKtm1rEArg9gWweZUOfS6B2RRziQ7eWNUBP7ghSI70iV3KK2nvK58lY+mf1dknncExCb
	2sgE6B7Z9nto8jjTwf+uvSN3lqd+zfiKvA/eAgj99+An//XS+7qHupkqKtI9BoA+lPU4sGqCyuv
	UnDdn8AgM/IDbwaMBLDxW9Sbc2Px71S6didEi0z2j/rWnBhmjcoWwFrdD6y1FlOkjP07Y+TRgHl
	LK5kYTofD/BLSf6Y=
X-Received: by 2002:ac8:598c:0:b0:4b0:7298:1ec4 with SMTP id d75a77b69052e-4b07298225dmr65010581cf.51.1754378539401;
        Tue, 05 Aug 2025 00:22:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbFGbWbc/7vsrqHQg02yIUPn2Mkudvs+7LqNqnEBlCgK40SEkxmxEpp0vQ/78kK5UTY0baeg==
X-Received: by 2002:ac8:598c:0:b0:4b0:7298:1ec4 with SMTP id d75a77b69052e-4b07298225dmr65010161cf.51.1754378538873;
        Tue, 05 Aug 2025 00:22:18 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it. [79.45.205.118])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b06f790834sm19298781cf.60.2025.08.05.00.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 00:22:18 -0700 (PDT)
Date: Tue, 5 Aug 2025 09:22:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: bsdhenrymartin@gmail.com, huntazhang@tencent.com, jitxie@tencent.com, 
	landonsun@tencent.com, bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, Henry Martin <bsdhenryma@tencent.com>, 
	TCS Robot <tcs_robot@tencent.com>
Subject: Re: [PATCH] VSOCK: fix Integer Overflow in
 vmci_transport_recv_dgram_cb()
Message-ID: <bpm2jqi4qv5mkzikcazchdpzb2ztqhwldpyi6wyfowqsqsaobj@pltf2mfrbf7a>
References: <20250805041748.1728098-1-tcs_kernel@tencent.com>
 <ea9768e9-0427-4684-ad42-caad4b679639@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ea9768e9-0427-4684-ad42-caad4b679639@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Mx92r75qc5Ny0WWJqudFI0ZXp2wJMTEIujDP2_0_dK0_1754378539
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Aug 05, 2025 at 03:07:38PM +0800, Wang Liang wrote:
>
>在 2025/8/5 12:17, bsdhenrymartin@gmail.com 写道:
>>From: Henry Martin <bsdhenryma@tencent.com>
>>
>>The vulnerability is triggered when processing a malicious VMCI datagram
>>with an extremely large `payload_size` value. The attack path is:
>>
>>1. Attacker crafts a malicious `vmci_datagram` with `payload_size` set
>>    to a value near `SIZE_MAX` (e.g., `SIZE_MAX - offsetof(struct
>>    vmci_datagram, payload) + 1`)
>>2. The function calculates: `size = VMCI_DG_SIZE(dg)` Where
>>    `VMCI_DG_SIZE(dg)` expands to `offsetof(struct vmci_datagram,
>>    payload) + dg->payload_size`
>>3. Integer overflow occurs during this addition, making `size` smaller
>>    than the actual datagram size
>>
>>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>>Reported-by: TCS Robot <tcs_robot@tencent.com>
>>Signed-off-by: Henry Martin <bsdhenryma@tencent.com>
>>---
>>  net/vmw_vsock/vmci_transport.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>>index 7eccd6708d66..07079669dd09 100644
>>--- a/net/vmw_vsock/vmci_transport.c
>>+++ b/net/vmw_vsock/vmci_transport.c
>>@@ -630,6 +630,10 @@ static int vmci_transport_recv_dgram_cb(void *data, struct vmci_datagram *dg)
>>  	if (!vmci_transport_allow_dgram(vsk, dg->src.context))
>>  		return VMCI_ERROR_NO_ACCESS;
>>+	/* Validate payload size to prevent integer overflow */
>>+	if (dg->payload_size > SIZE_MAX - offsetof(struct vmci_datagram, payload))
>>+		return VMCI_ERROR_INVALID_ARGS;
>>+
>
>
>The struct vmci_datagram has no member 'payload'. Your patch may 
>trigger compile error.

@Wang thanks for the highlight!

mmm, so this is the 3rd no-sense patch from the same author!

Last advice for the author, please fix your bot and try your patches 
before submitting it!

Stefano

>
>>  	size = VMCI_DG_SIZE(dg);
>>  	/* Attach the packet to the socket's receive queue as an sk_buff. */
>

