Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939253749EA
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 01:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040670; cv=none; b=ZrS9JMaCKcdQJltqDpMQUTnizL+JfoYMfHqmJsx7sNELtWUZsBQAHzviY9DnzZoAuobHOIWFWFO79J4xcOGIR2QUraqRu+Bcwz9Jra1M8NzPTTJmvx51Rs9dJQPX4GlJjpVqigjSvACikP3r5I236H9JJxCqifDLOie4P6T4I7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040670; c=relaxed/simple;
	bh=pLQIzyAXx9BXS4Jj3YBYF1I98hZkelIy5fkVP6OLqRQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=pyE+sTPwGysRuzqgoqQAW5p8rY/XEdtLH7x/2eiIkl4NX0DZyooMJgprfJjX38EpPj1KWKh8dGX9CH9ms2ptts+bbOTgM3kIyxG0kuNhKEl7Ch/4SfOJNbVMs88PfjSEJ2E3vi1Czm8Oud267LAr6L2FfcdakXm/YrneNC1oV24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeHMSIEL; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeHMSIEL"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e56a1b327so2786255d50.0
        for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 18:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790040667; x=1790645467; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xZPM204BsQkvGwo/0VKtkWmPTs7CeisxuHS7DMwf2J0=;
        b=FeHMSIELSx0i2An7yKLCArEeQZesyhgepGQaTpYS6r3wDOTOy1qPNgrMLs6HA/aTB+
         tGQ+pZMFlpnaxptgjhzsrBX9JmzT5bli0goqIcAk949bVp35CjOi2YekXnRHcUguwo29
         n0D2wwKf11hij5K5W7a4VNK8QC9CxYtn0aUX42e3COd+Ukhf5V6PgyuR67AbFTyvQA2o
         M+PA2qVDDyTd1/SNkI762gHavDZ5ROp/ol0FQyc09CCz3tghqQtqJ8kajVdX/Mq5bLkC
         hkIhM9bVrKMw89u5YBQoSK+0cXbHKphfif/Ixo8Ogt5nA3BKIcaM7Hqr7v+DATVoE5yH
         N30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790040667; x=1790645467;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xZPM204BsQkvGwo/0VKtkWmPTs7CeisxuHS7DMwf2J0=;
        b=t1ymxtq/rBlxAd6ZQT0o+PW97/2XG3Qz2ZuRX/ztt8RJOAo7ztV3gts8NORvTnaWOq
         YRiTP38xjYqSTI214NwEc2lqf+ZbUvmHkkzJRJWWtpVDUOjgYxIe+C3GkAKfP0QnC8Aw
         YA39Uq37Tgmv0gRiTSDbWjRz+c6pYLbPl98pIlbduR/g6mk2ECXqqVWMWEqin6G+6gfQ
         JnGgSAXx+m/5CWTKpuyEkqHNrjYVQyz/wDIQF1Rkd5/9ybuJ8IjihjOLbixxsngK4wB/
         9bIM8fUtuke6EqmvdkekxQetZMH/kjsOs6NsTQ1bMp8dU5gUzsHoDqI6H47eJI2ZD0Z8
         Iryw==
X-Gm-Message-State: AFuF++nTcBXUjXQ8D3t44Vbax+k+v8u4v7paMytPFv9gmoFEqq2OZTjm
	EgkZbmSRzllUVZaLl4LHMRioe44h5AgjRVg8xbKftbbQvFUBIP0wQbsL
X-Gm-Gg: AYBFou2sRV7V/tJH1B2D3qFMrXSIzvNi//hee02w5kAK+b6TKc5QL3m/rSczdsBHnNa
	xO1x0Z1iNU2743hwsdzrnYjcrwgvEreDbMkjCvJ2f8t4OnlfYc4lC05tLKu9+92Fe0dLc99wJpm
	gVK3mE2yJFLZtYpemSo91MayaZjcGnPV8IvFFtGArwCdNPKzDqghg0wzBdU4aQUvqjgtlqIeWUN
	drOgXZQJX9jBip+Bc2aJYnLfrFtAiJkrrgphPEOGSw72aUzw4mS79uwY8Zwu7JlOa33pfdZDhXv
	FNK1uCfFNVVgWkF/pzog6Me8gOdP2fdy2DTbnyY1P82DHvk9uTZA8WwC4vTwXvOA8mqKPbWsILn
	pskzSxdAE+TS4YiF62VeglAEqMOn6BIv16G95NKnCzP5xSE9rXwlFvfDN/+Xulm1PcF9vNIrhnG
	MyDqdnXhD34XUbNxIYUf6NAOIj2D3Qwjwh2jqf95EdN4QxI49MG4Tigws7DE6iyhkJE5TleCe2T
	NsM7rfg2MJ0pmXDLcs/JnlIkj4sMcIMw9y7omMRLCi1qZXM++av
X-Received: by 2002:a05:690e:138a:b0:672:a83b:9964 with SMTP id 956f58d0204a3-672c199f5d8mr821945d50.38.1790040667423;
        Mon, 21 Sep 2026 18:31:07 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-672c766dfcbsm157903d50.17.2026.09.21.18.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:31:05 -0700 (PDT)
Date: Mon, 21 Sep 2026 21:31:04 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Jason Wang <jasowangio@gmail.com>
Cc: virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
Message-ID: <willemdebruijn.kernel.2e1c6881ed336@gmail.com>
In-Reply-To: <20260921-v6-7-topic-virtio-net-ptp-v3-0-3350851c4f88@pengutronix.de>
References: <20260921-v6-7-topic-virtio-net-ptp-v3-0-3350851c4f88@pengutronix.de>
Subject: Re: [PATCH RFC v3 0/2] virtio-net: add flow filter for receive
 timestamps
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
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
> The changes in this series are to the driver side. For the changes to qemu see:
>     https://github.com/strumtrar/qemu/tree/v11.0.1/virtio-rx-stamps    

What is the plan wrt the virtio spec? +1 on demonstrating working code
first for feasibility.

Does this now also need a spec proposal to virtio-comment@lists.linux.dev?
