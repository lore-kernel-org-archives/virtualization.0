Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67640498A2
	for <virtualization@lists.linux.dev>; Mon, 18 Dec 2023 16:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcODc6iK"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-203ae9903a6so655113fac.0
        for <virtualization@lists.linux.dev>; Mon, 18 Dec 2023 08:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702917395; x=1703522195; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQV19gsqAR0o53Ir8ZJ+QKmKnVhQISOohb4gzU/oY50=;
        b=RcODc6iKhqWzCnGVJsP7txpaoxmJakgXfkazeBZ+9uGkqnM0CCFNwfIOSd4ChC0n2U
         q9ZZMcoODIec5BQHYfyx0MqW2n5der/yLf4aCkHiZoROKS0CejttJlRnRD1PiGu6ccol
         9w9w8XiG17YCIW+HKm8ZtT9RsUa5x36KA/CxRLbqETXkV6GbT/0udopDLltQ+UCgn/2u
         ThckvOEcwMS3woFDsSZUJx8PuUaDvP+gNfOqZJ3iP1VoDsYyr1eN7Jd9C3nlBcZ6Pxh6
         Q+NJmff+8qoGqeHrs5AFt8cz2RHUjqXqBntqQn0AbmrSpRJA1Ra66+n37rs/7KPfB3qt
         NRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702917395; x=1703522195;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lQV19gsqAR0o53Ir8ZJ+QKmKnVhQISOohb4gzU/oY50=;
        b=cQZvwJNyQiNe/k9S2ZgfNKQBP3GG0xN6b8sGiS0s4RwE222Gjp9U5aBqdcZACFRyo1
         PFt7jGcVMIPNwNHhzMvtVLd4dGlPMF10Ve2Jc984S5e1hmrbQIYIntP0xRg1bWvLKuIg
         mChGAEKziD4lkq/z+F/nG2W7oYcOKTeQc68rUwT4VUQ1APjfO0YwgVz/SBn9bEc/7FOt
         1u6cqyZjyKleomOQMzgJ9NC5cg9NdyQ67Pw3bMdiuW6MM9HQXhKEeJTmi5thwTKB0nL7
         IY/7D5E/P2SKACcMtfM45Pue4gfFD9zoBlRMzGR3sHbH8vmPGojQrDCz8tzTEmYzXfHq
         n0/w==
X-Gm-Message-State: AOJu0YyPTxH2/BJaSMc/NL0CwoA8B8a1qgC//36/JvWLxvztbNqpVPYA
	6WV7d9OgbffYl6MN7I+JBR4=
X-Google-Smtp-Source: AGHT+IElzJWlJ9gs7JsWQZZ0tgpLq9OGnBM00u2DOHZw3YzQXThA4bGST+JUjXecMMmFXfbzQ/IWjA==
X-Received: by 2002:a05:6870:a40b:b0:203:936b:70d with SMTP id m11-20020a056870a40b00b00203936b070dmr3344641oal.62.1702917395435;
        Mon, 18 Dec 2023 08:36:35 -0800 (PST)
Received: from localhost (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id bm27-20020a05620a199b00b0077d62e78db9sm8408821qkb.128.2023.12.18.08.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 08:36:34 -0800 (PST)
Date: Mon, 18 Dec 2023 11:36:34 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <65807512bc20b_805482941e@willemb.c.googlers.com.notmuch>
In-Reply-To: <20231218-v6-7-topic-virtio-net-ptp-v1-0-cac92b2d8532@pengutronix.de>
References: <20231218-v6-7-topic-virtio-net-ptp-v1-0-cac92b2d8532@pengutronix.de>
Subject: Re: [PATCH RFC 0/4] virtio-net: add tx-hash, rx-tstamp, tx-tstamp and
 tx-time
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Steffen Trumtrar wrote:
> This series tries to pick up the work on the virtio-net timestamping
> feature from Willem de Bruijn.
> 
> Original series
>     Message-Id: 20210208185558.995292-1-willemdebruijn.kernel@gmail.com
>     Subject: [PATCH RFC v2 0/4] virtio-net: add tx-hash, rx-tstamp,
>     tx-tstamp and tx-time
>     From: Willem de Bruijn <willemb@google.com>
> 
>     RFC for four new features to the virtio network device:
> 
>     1. pass tx flow state to host, for routing + telemetry
>     2. pass rx tstamp to guest, for better RTT estimation
>     3. pass tx tstamp to guest, idem
>     3. pass tx delivery time to host, for accurate pacing
> 
>     All would introduce an extension to the virtio spec.
> 
> The original series consisted of a hack around the DMA API, which should
> be fixed in this series.
> 
> The changes in this series are to the driver side. For the changes to qemu see:
>     https://github.com/strumtrar/qemu/tree/v8.1.1/virtio-net-ptp
> 
> Currently only virtio-net is supported. The original series used
> vhost-net as backend. However, the path through tun via sendmsg doesn't
> allow us to write data back to the driver side without any hacks.
> Therefore use the way via plain virtio-net without vhost albeit better
> performance.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Thanks for picking this back up, Steffen. Nice to see that the code still
applies mostly cleanly.

For context: I dropped the work only because I had no real device
implementation. The referenced patch series to qemu changes that.

I suppose the main issue is the virtio API changes that this introduces,
which will have to be accepted to the spec.

One small comment to patch 4: there I just assumed the virtual device
time is CLOCK_TAI. There is a concurrent feature under review for HW
pacing offload with AF_XDP sockets. The clock issue comes up a bit. In
general, for hardware we cannot assume a clock. For virtio, perhaps
assuming the same monotonic hardware clock in guest and host can be
assumed. But this clock alignment needs some thought.

