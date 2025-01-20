Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133BF1DF26B
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 11:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737371262; cv=none; b=Cxv/ZzbSg68Hzobrqb7KRLKZSNIiUKidpqtHw3YqTFeQZGM5QMJukOkB/SqgpmLUg7H9zslulsHed+M6ssIgCBWmzQdhIKS7vh03lJR88LFMmk+uOFgiXTZN9PLHyE+XNilByAevFVG8Z7EwOgNPI22JLU0VdpNp70au8fKK8Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737371262; c=relaxed/simple;
	bh=NY8xOSTb5H82+FIEW3G7ByzU+dpqafjZ58KpUcTCBIM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=PGrIeQLh7vyOODxmxu1salrQ2q1VYDOXucYTPrsEtozKR9p9Lsz0XUhWoMJ7k/QDOTSbJdUguw21KVOGfS0XpocjOGA65rmrdD6Sm9aoMjzpNoYdG+VUovuH7jrDpbCLHK3clzw61nz7p4n7RNdtdy1yPCISTRng3VEb1CskYCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cawE+9EZ; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cawE+9EZ"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 91965413B0
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 11:07:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eCEjYlNf4le2 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jan 2025 11:07:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::830; helo=mail-qt1-x830.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 535F6413A1
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 535F6413A1
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cawE+9EZ
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 535F6413A1
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 11:07:38 +0000 (UTC)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-46df3fc7176so42881531cf.2
        for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 03:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737371257; x=1737976057; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJ6K6nvdOyUKshD5noQZW6cAKo0Nx9BnvWyFQDdbnYI=;
        b=cawE+9EZauB2G/IjYRHgEX4HWWMAjoeoThPDDrFxtJDS246e77o6h60LwG1HBMNKNZ
         qFBjWGn65HmL4K4/O1iFuZ9AAzrcVf2OfR7D3plIgeFB2Y9pgJfRHyI1bfykhZo+d/jN
         xaXjLwKR38x5UtdczG0TfazG0yra3YuiDfi92ffO7LTLOjR2sIXx/xitAqngA6P8619j
         DPn20GD5gUaITg7Hfo+mahULeoQAqzul1rcsZ9tIxvrTaFuLKU33EA1XXUp4GghwvFme
         e/b/M9XCDEFBC56vxCUe4CRsk9PeHR8yAMx3hvsZ1JUiXQLY8cE7peDWKjMkmLbixk+Z
         edEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737371257; x=1737976057;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DJ6K6nvdOyUKshD5noQZW6cAKo0Nx9BnvWyFQDdbnYI=;
        b=Z1nrLPqAzWxESMIiCb88xUZXl/CUJwLFvHXcg1e9a/X3fOAJSKS+86JQ2MxNBYTlqD
         Z1m5qnP5zaEGxHoexpzWEng0RTzNh+4aHVg13MYy855xtfdAN2o+rHLYg894OSitgrud
         pGf6NEAikibJzzX9lCutTRxfW8bfmgumA9e8w7CNWHIJTXhLCg7CbsSLKaN/olr3ChAo
         tLz73EC3Ip0GCRMpNDRWhqZeM98SivbEissGWnxkdGjANKpzwQRfHIhoLdvviyA0zKJ/
         gVifEC2+r/7927gDw8EMRIxoA1YRBKCcSH0Ezb0vKMYaMDTxhhIk3lcegfERoIAGJKum
         YMEg==
X-Forwarded-Encrypted: i=1; AJvYcCVWZrm9Jm86Q8wQ5S0f3mCf6e7SNh64y4yu61ZwF2UFHf0k69hEzzl8D11JUN7haTXD3q3zOEK7bvVIYks5xA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yz+gOtcFbuZrCvNDdTT1OJ4s5U53RgRfSVtvkZWBSVYDBJKnY3I
	XZD/WrFAQcwBtNWtx/8ltS0SgD/E385hBtbxGRHWWus0erA/lh6b
X-Gm-Gg: ASbGncuK4CvAUSB8W5oAMEuznLLke2XCD11W/HF5kh5o3MnmB/WBszjXIZDzRBYIs0Q
	AqTk52vywUQiH1SzR9onN4Y2M6xrT21pG3GUmuSxutlPn6Ni6wwPdZgWvWf/sa+aiThBqD5ZERe
	5DFL491mjfHzpqNgE7rayuChiGMa3Ype3DzbKfzFjn2G9WTfk7/l6A/D7uLfKB9hnwZaC9bGbNw
	YfdPw/oUbF55Ik5YEg6UldgClRJr1mEhuSDU1wNs3vS9XR6rWoY1efMCX/7WKQatv1FA6/ND6bS
	gM1ad/7DnndSoI3uAqTcq1dBRAKjlTrp7j6r0JcVWA==
X-Google-Smtp-Source: AGHT+IEm2VfaURgMKTWVUkW8metfum5VkiD89JCWy5iWkkfOq8QOhBxbNhbeIAP1Xgz3v7nvNAsr3w==
X-Received: by 2002:ac8:7fd6:0:b0:46c:78cc:e48 with SMTP id d75a77b69052e-46e12a0c2e0mr144720311cf.9.1737371256783;
        Mon, 20 Jan 2025 03:07:36 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e1042efa5sm41216411cf.66.2025.01.20.03.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 03:07:35 -0800 (PST)
Date: Mon, 20 Jan 2025 06:07:35 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, 
 linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 gur.stavi@huawei.com, 
 devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Willem de Bruijn <willemb@google.com>
Message-ID: <678e2e779985a_19c7372947c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250120-tun-v4-0-ee81dda03d7f@daynix.com>
References: <20250120-tun-v4-0-ee81dda03d7f@daynix.com>
Subject: Re: [PATCH net-next v4 0/9] tun: Unify vnet implementation
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Akihiko Odaki wrote:
> When I implemented virtio's hash-related features to tun/tap [1],
> I found tun/tap does not fill the entire region reserved for the virtio
> header, leaving some uninitialized hole in the middle of the buffer
> after read()/recvmesg().
> 
> This series fills the uninitialized hole. More concretely, the
> num_buffers field will be initialized with 1, and the other fields will
> be inialized with 0. Setting the num_buffers field to 1 is mandated by
> virtio 1.0 [2].
> 
> The change to virtio header is preceded by another change that refactors
> tun and tap to unify their virtio-related code.
> 
> [1]: https://lore.kernel.org/r/20241008-rss-v5-0-f3cf68df005d@daynix.com
> [2]: https://lore.kernel.org/r/20241227084256-mutt-send-email-mst@kernel.org/
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

net-next is closed. But I'll review for when you resend.

> ---
> Changes in v4:
> - s/sz/vnet_hdr_len_sz/ for patch "tun: Decouple vnet handling"
>   (Willem de Bruijn)

Minor, and sorry my bad: len_sz is duplicative, vnet_hdr_sz is common.

> - Reverted to add CONFIG_TUN_VNET.
> - Link to v3: https://lore.kernel.org/r/20250116-tun-v3-0-c6b2871e97f7@daynix.com
> 
> Changes in v3:
> - Dropped changes to fill the vnet header.
> - Splitted patch "tun: Unify vnet implementation".
> - Reverted spurious changes in patch "tun: Unify vnet implementation".
> - Merged tun_vnet.c into TAP.
> - Link to v2: https://lore.kernel.org/r/20250109-tun-v2-0-388d7d5a287a@daynix.com
> 
> Changes in v2:
> - Fixed num_buffers endian.
> - Link to v1: https://lore.kernel.org/r/20250108-tun-v1-0-67d784b34374@daynix.com
> 
> ---
> Akihiko Odaki (9):
>       tun: Refactor CONFIG_TUN_VNET_CROSS_LE
>       tun: Avoid double-tracking iov_iter length changes
>       tun: Keep hdr_len in tun_get_user()
>       tun: Decouple vnet from tun_struct
>       tun: Decouple vnet handling
>       tun: Extract the vnet handling code
>       tap: Avoid double-tracking iov_iter length changes
>       tap: Keep hdr_len in tap_get_user()
>       tap: Use tun's vnet-related code
> 
>  MAINTAINERS            |   2 +-
>  drivers/net/Kconfig    |   5 ++
>  drivers/net/Makefile   |   1 +
>  drivers/net/tap.c      | 172 ++++++------------------------------------
>  drivers/net/tun.c      | 200 +++++++------------------------------------------
>  drivers/net/tun_vnet.c | 184 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/tun_vnet.h |  25 +++++++
>  7 files changed, 267 insertions(+), 322 deletions(-)
> ---
> base-commit: a32e14f8aef69b42826cf0998b068a43d486a9e9
> change-id: 20241230-tun-66e10a49b0c7
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>
> 


