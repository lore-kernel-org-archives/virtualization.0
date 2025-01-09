Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B499219A78
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 13:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736430398; cv=none; b=BTeP0/QgQMSj+ML/w2me6SA6T0Cyyvbdp3kuOh7YJfoQUobeaJ9TqmMl+aZqAzxincYGKhTbMoxuasdnHlhlEeqrH2yJAGcoi2VY/dVtyvkQLSq0gIQBjN/6mdXovnAo9PT5PVbqAIhX4/3EYAKnYoymFcTZQuBxs0QMDa8HQ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736430398; c=relaxed/simple;
	bh=JWND2bHlwFHqnWFA2cA6tDBVVODeVDShgKzt9IWtlac=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=H4G9krL6lPUgrDphd8d+8eyvb8q2S9W+k877wWSloXsrgX+MafdExKeRy/ic3i02dECOtHRS1mVweT+jZJsNtfPPQjCAPJWTVduF/hGYGW+5TM1/E4JzL/v2UHoBr6bJIDBrwhOCUtpa1gK7Z371TxYC+fnuB3+CpxUdjU6Ripc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9/stPna; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9/stPna"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ECC124050D
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 13:46:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1NFFi0wgLp1k for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jan 2025 13:46:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::729; helo=mail-qk1-x729.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B9C6940517
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B9C6940517
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=S9/stPna
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B9C6940517
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 13:46:35 +0000 (UTC)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7b6eb531e13so42687185a.0
        for <virtualization@lists.linux-foundation.org>; Thu, 09 Jan 2025 05:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736430394; x=1737035194; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8ngqEeCWslFnwkv4pv69GyH61S/m9Qjg59kl9p0QvM=;
        b=S9/stPnaXmPBrd/xHn/hTxxyfPTvY3d6JqafgspbfDSuDJ5sY1ewW+aYCW1M6Q9s8w
         w7Z5q75WSibL3XXQANUvrFXE6UF637kek7GdYGdsB09mS7rQxUcDrvGGaPkJTAteCAlU
         CLl/WPnQ855ecqLciHFHif3a8zSdSMynrp8o2D5T7MOmBo9JfHtMQuMRoANYiEa4zf/Z
         b5dGEtUtdPaQ4DW+tW+frBvHseoCTspeXyT8IaH7dPWwgmW+azl2KSo4vduQ/AWE20yM
         YzGibRKsFIClRD+EbB7U5Cj70hXjSnYu0TxCAN0/iCkW4qXMC/pHoDM8eWAm1cCvw6qc
         bKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736430394; x=1737035194;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8ngqEeCWslFnwkv4pv69GyH61S/m9Qjg59kl9p0QvM=;
        b=imJqlbSbZ5bg1jlxHJVUQLTDqUWyn4RBnym1KgwkLk/pF0tulUep89pk325NDwr8vb
         kh7dvxL5E3EtIs7I0hbvoGwHdrSp9e20u3FoVN0m2R5aiJEpoEEoKdVFbESSidHSzVD1
         gYSBDQV+SvhnelHi0lwkco6wMOvw6M1qVQZosvUDn495GkTfjizq0hhb9QTA3qqiybOM
         7mqejcjEgrFBNVB1Lv7IecBqFqbheds5iVFepLkNUT/+XVjC18GRS7EvQUjOzfl1hb1U
         C7ac+ViLM8HTQGpzHpAcpDfC6d3qC+QnwNKjcfS2lU5CJ7sEUorPE3mM9FhZB9fcE6vZ
         PiHw==
X-Forwarded-Encrypted: i=1; AJvYcCVERvcyduCn5mkVxsNASgzyd4VW3ZdCDQhPrP95njSPgaliVLGuqko5gfPdsaVlv/q3NdAMAxjEvlu5d91QAw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Ywn6RZ1WhCTi+2Am1DqZewEWd3qzOK0BoVddSVF3lBPeooQYhYi
	sijOEyFMrv44e8WiQhwPi4gJ9HtHx5fNT1W2ThhoVmmklfwfZhg1
X-Gm-Gg: ASbGncu6aUG1riRcqzqSe180hcIkvDs7X5dpyNrLwIXKHdTnGh/hr0Ysi6+Sl2jn7nC
	OwJ+5qpktSka+dAmKMOJ3XF3iQIo+xFiNCnbhNI4/t9NjAPP6OUSsRETlhE1VW987LS9xHdk1sr
	KTF3O3VMNV+Mii3DkP/Yv+5PIdTwSSBXzE6e2WCNdgz2/XkchjYjAjnjVfNZyInv883bYnDSz9K
	PQ55UEHb7lJu5ZPiTgZYK1hedn9Ffh3KrZk/3gMUS2qw3Wtt2OkS2QBBERVkOQ2TXWwj9V+ks6C
	4QyC9XOQ/8HSCB2iPwqD7lPfTDYD
X-Google-Smtp-Source: AGHT+IEoo0DgH2YrU+DTme0xfEmNzK4L/V4paiii7CUCTVSordb/Xkqsduik2RsPGbTD3CGaIVGcpg==
X-Received: by 2002:a05:620a:2485:b0:7b8:61df:f5de with SMTP id af79cd13be357-7bcd9762c4bmr970386685a.45.1736430394183;
        Thu, 09 Jan 2025 05:46:34 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd7debcc33sm124773836d6.123.2025.01.09.05.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 05:46:33 -0800 (PST)
Date: Thu, 09 Jan 2025 08:46:33 -0500
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
Message-ID: <677fd3393b354_362bc129476@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
Subject: Re: [PATCH v2 0/3] tun: Unify vnet implementation and fill full vnet
 header
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
> ---
> Changes in v2:
> - Fixed num_buffers endian.
> - Link to v1: https://lore.kernel.org/r/20250108-tun-v1-0-67d784b34374@daynix.com
> 
> ---
> Akihiko Odaki (3):
>       tun: Unify vnet implementation
>       tun: Pad virtio header with zero
>       tun: Set num_buffers for virtio 1.0

Patches should explicitly to net or net-next.

In this case if the undefined data would be a bug, that would target
net. It sounds as if this is only relevant with the upcoming hash
changes, so then it too can target net-next. If needed at all.

The first patch is clearly net-next material.

I would prefer to work on that independent from the rest. I'm in
favor of deduplicating logic across tun/tap/pf_packet. Have taken a
stab, but haven't gotten to a concrete series. This indeed a valid
deduplication effort.

We have to make sure that the code is identical between tun and tap,
or where it isn't (due to one of the two having received a change to
such code, but the other not) explicitly note that in the commit
message. As then it is a behavioral change.

Anyway, let's send the undefined data, hash and dedup changes
independently. And preferably one after the other, rather than
having concurrent conversations across threads.
