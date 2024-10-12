Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92961474B8
	for <virtualization@lists.linux-foundation.org>; Sat, 12 Oct 2024 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728754824; cv=none; b=c3LiC7qiMc0fnEh19gIGu2lmZHptWpdzkeY+zUVYq0ar5mTwa6NBjBC2tgHHq/uBsE4uKmSLxzqKRLGAVtK/1F+Z1HM4fsS2gARgT9rq1UVuFUpsq5D4xZ2GyJzGMBa9hR0SEDuayXDYy6zpObSPl8xra/2x4qCbYdPLn8WLkuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728754824; c=relaxed/simple;
	bh=j+0eugA5qlshkzOWKhURgw3WOGiDbE79dVsJbtUFeow=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=QX+zzb95iQqojS2xtIYTo8rvioc5ypOxKXKjfTv2RCh6IPW8vIV6TV+yztquvm9Be15vbnrH0ZWRxufyW8eplYWmJjSaiVQrMtNydMdcGrJbDkCDlQPNwnMVYs/k/HX9dx3l6aUQiUzvaAL/SoZAzKcetHml5j7B8gQHdtF+xSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQFBybJl; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQFBybJl"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7447F6060C
	for <virtualization@lists.linux-foundation.org>; Sat, 12 Oct 2024 17:40:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WtYtAsd2iGu8 for <virtualization@lists.linux-foundation.org>;
 Sat, 12 Oct 2024 17:40:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::729; helo=mail-qk1-x729.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B08A0600CB
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B08A0600CB
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VQFBybJl
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B08A0600CB
	for <virtualization@lists.linux-foundation.org>; Sat, 12 Oct 2024 17:40:21 +0000 (UTC)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7b1109e80f8so225986985a.0
        for <virtualization@lists.linux-foundation.org>; Sat, 12 Oct 2024 10:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728754820; x=1729359620; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeQVh5vaiF4LZT4ihfN5o5UvxngIEpWBJHf7f40MegM=;
        b=VQFBybJlch7cHoIs+7tkxkcDdoITvVtn1S6UF6Laiko3MHZ9WzwYn/Y2NLU8A0Karq
         I4GfyZ4Dd1GVsu9atiU3suV6n5649hA4X+DZZkwJK1gxOpAf3d2nAWi0P3plhEaExb3V
         7xgutQcJNASQH4t7fWalBbDTHj9L+QBmXK/sCx/k4VnDnuyFukk+f/BITgqwFhTtJNyt
         K6YKOHCDGB2yKkCgM8QCW6x30PIMwCz8jLlV1kCU6Y1aETxgwTdbEN7YxZZ/gb1lI3q7
         NkDJ1Vgg35cac3xzsvRkzZDjooAunLrFMfySRNgDrZACB9fdSkHyFeNLdHA2HxFpx1Si
         iVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728754820; x=1729359620;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qeQVh5vaiF4LZT4ihfN5o5UvxngIEpWBJHf7f40MegM=;
        b=RdbffeU7B0srAi4Ayv4ZdhW4V643J0gl9xag8Y84X/ywXx8XNdzWmWLAc3sH/p2SXP
         qlCTyyeC6Re28yw7ehNz62mhRg3j0JNyx5lcZKz/taWDimgTIFn4yiAEi26iRwK4hVry
         C7OGtmDyAgxwT2fW8tLd6qrLOlYFB38+W6IsBJXJlOrFaAS0EFpXGMVdSva8x+ZKnz+Y
         O7zrM5lvprnNnbJVe86Ccfmth1lkeZrD+nvt0kzeLh6zxL4MODQdAqupL76Bh9Wudwtb
         zbkDZQf+P/R7LaaQ9chIdmg6Nwk6VRAoXw1DifbiplOL/3p7kPf3jrVAMtKsBjw1256b
         EjVA==
X-Forwarded-Encrypted: i=1; AJvYcCVcOqG4sfi/VQdR6193L1y0EiI4Fic1ROetXb5nRwUA/HYDrPTlmgBPJtR2/Vb/CqrGMcSM2DQiD9OsM92tnQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyRIFGgAmBSObV+vP8lEYdef/lvSS6ylp/1X6nZm/AusYhZfuHR
	7qUdl3t0q1W99+Ft4WkX6mqPgiJIkbH6E6K6cPnFra3FIyWcg7wF
X-Google-Smtp-Source: AGHT+IHm4Bx8DL3ED0EiIGa9UoE0AQ+a9pp5rid+2GyH7NTS4vnz6h0mFmR06lQvNNdN+JG5fbYMyg==
X-Received: by 2002:a05:620a:4446:b0:7af:ce6e:1663 with SMTP id af79cd13be357-7b12101be7bmr436841385a.60.1728754820032;
        Sat, 12 Oct 2024 10:40:20 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1148c7129sm240855985a.19.2024.10.12.10.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 10:40:19 -0700 (PDT)
Date: Sat, 12 Oct 2024 13:40:18 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
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
 gur.stavi@huawei.com
Message-ID: <670ab482ba75d_2737bf2945a@willemb.c.googlers.com.notmuch>
In-Reply-To: <30bbebd8-1692-4b62-9a1f-070f6152061c@daynix.com>
References: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
 <20241008-rss-v5-1-f3cf68df005d@daynix.com>
 <67068a7261d8c_1cca3129414@willemb.c.googlers.com.notmuch>
 <30bbebd8-1692-4b62-9a1f-070f6152061c@daynix.com>
Subject: Re: [PATCH RFC v5 01/10] virtio_net: Add functions for hashing
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
> On 2024/10/09 22:51, Willem de Bruijn wrote:
> > Akihiko Odaki wrote:
> >> They are useful to implement VIRTIO_NET_F_RSS and
> >> VIRTIO_NET_F_HASH_REPORT.
> >>
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >> ---
> >>   include/linux/virtio_net.h | 188 +++++++++++++++++++++++++++++++++++++++++++++
> > 
> > No need for these to be in header files
> 
> I naively followed prior examples in this file. Do you have an 
> alternative idea?

This is long overdue really, not specific to this fuatre.

And extends to your patch 4 that deduplicates tun.c and tap.c.

Perhaps drivers/net/virtio_net_hdr.c.

Or drivers/net/tun_vnet.c, matching your choice of drivers/net/tun_vnet.h.

