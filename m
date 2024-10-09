Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1367199243
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Oct 2024 13:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481910; cv=none; b=VehIyZRx6rJSpIkI4q1wnOg3grv/BjfLeGZcelD7PpNzcXH+WfJbcCHO3sX1AS7v/OnsFeWP4jUZrgUdyP8NgKRkzWrL4iuTpEsxdLSLDsUF8LNIHNKAwCCPDzn4LPLPAMCfiBR94LNJU9A8fDAyDmuxgexhinEupzsNeAYQHNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481910; c=relaxed/simple;
	bh=jYgb7BwLs38wtXSfN1wpIvBf5tLjsHOZeuzvh4Bgntk=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dpMAvu7rWWB0ITzpxCquONWlaTaJn2ZQi1FssmLBkY2X0qAYVzwWJbBhL75v/JhOFWvN2SzQdoprhGoo39r7v5u3uXDnQaPbBKWJpPyVHjEMvbwUTL7+ZKcDrcnVF1zjkytoaRioVBms9WIXmNEwFDHlsQvqnk4mxtFpt4hoFhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juNrrGVz; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juNrrGVz"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1AFD560600
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Oct 2024 13:51:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V7kmS7bxK9Qr for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Oct 2024 13:51:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::f29; helo=mail-qv1-xf29.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5864D608B9
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5864D608B9
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=juNrrGVz
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5864D608B9
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Oct 2024 13:51:48 +0000 (UTC)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-6cbcd49b833so4141316d6.3
        for <virtualization@lists.linux-foundation.org>; Wed, 09 Oct 2024 06:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728481907; x=1729086707; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUc34dZTHKciGaII3zabz1ZKWWaMos36cbYH1GBxAp8=;
        b=juNrrGVzn9NH8nSCQXaSHiwkGgCzmZFwO9YVABo6Ik0Pga0A/Z8JXynWnzZMGMgx2p
         ITT4+bNb0v1WSSEp6VeKGX5jGHsmy2dXnhuTFEhbGry0RyrCZfdU/q/rgUb11FJ4eeud
         CljJrE1AOO/sWKdVuWWOiQJ9cackd56EcJRo3cio6Z+0W0YPhzGeZyfMK6XS3ZAMyi4F
         7KGpQnI3wg9gYxrM5I4uU0OtgKhCO4fVhxS+9CmB8VVbaGnukMKqN7h5pGIudCwtdP1e
         TRGFZep9YowB79Fdwa1ErfdZ1dNJa3MdhHJtbHKb0E97yHqXgP7Upnminbwq0YGEfTQj
         xd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728481907; x=1729086707;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUc34dZTHKciGaII3zabz1ZKWWaMos36cbYH1GBxAp8=;
        b=QvCOL5wKTIaPmYqyotL0Bkg8tL2RM5TuQH7wUF+2EoDVZQYo56K2rNVtA7gBb60HX1
         c8ffgPuOwAZIjw0tr4u/hICzf6BBlE+88xN1yMjOkcPjcfJWGAJgdahvU7hqFssIoNwt
         nw13gpTsmXR6lTCSjLY4cnUhIIYyE4242rXHXHIPa3hHpLS25wniFyaOupRrr6yrHln0
         enIb+m4Vrb/YpR9gXAXSen2om8CggFqwA+lgjiZruUfIOaRo/z0phSrnasWJAUXFuUSN
         vgiBV3wxLLD4MT25AeOgHqY+8BMRrnZ/gvZZKf3pokEBxoZsNFyaImQQbJPEccVFfEJF
         BbgA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ4sKAqJi7UJKHGRpS6/V62okwqLFAlclBp6Dr3/2jtDqlEaz7j0xlov4pGDQdkNbupSNR0dVgq8w1mde+yg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxMAxUmOFMC1803KEXDvywT5CI05fj/lJztfqdt5vXIApHAIcGV
	QWnthdCctHSMk9Xg0l5qBeX2276PxJAmoEY3oeAIr+9DEPRvbTmR
X-Google-Smtp-Source: AGHT+IGkew5/j69otxM8iwfX7gFjP4eK+FksUEv8jew+/bnfYJy9/Nhw1Lw41t2weOaHSSLA4zni5w==
X-Received: by 2002:a05:6214:5d83:b0:6cb:3cc8:5d7a with SMTP id 6a1803df08f44-6cbc955e801mr51908116d6.35.1728481907058;
        Wed, 09 Oct 2024 06:51:47 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba4751294sm46132086d6.93.2024.10.09.06.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 06:51:46 -0700 (PDT)
Date: Wed, 09 Oct 2024 09:51:46 -0400
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
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <67068a7261d8c_1cca3129414@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241008-rss-v5-1-f3cf68df005d@daynix.com>
References: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
 <20241008-rss-v5-1-f3cf68df005d@daynix.com>
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
> They are useful to implement VIRTIO_NET_F_RSS and
> VIRTIO_NET_F_HASH_REPORT.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  include/linux/virtio_net.h | 188 +++++++++++++++++++++++++++++++++++++++++++++

No need for these to be in header files
