Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8B92D7DF6
	for <virtualization@lists.linux.dev>; Sun,  1 Feb 2026 21:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769979611; cv=none; b=US6bl7XOWts+n0wbbFCQuZ1oVQ+LPw99K/MUx7oqlpMiszS85ZsDkquRnk4OilZ2N5okDIYtYvwREF9uMSN9SXbwVHQK9exklrJjXSAPV1IzXoC/LJUEnc2I0TRfP4mdrq/VswA91Yc71/XimKYzgW2rymZvBlb2wmYdc+HUE7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769979611; c=relaxed/simple;
	bh=AogniDSenuhKHGa0cFSla2/PdbM2zPi3vyokWKYGcDc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=g6+izyYrmQMOskkb+pRFjmFBVO5dcZvDglAYZgeCpBAEqmGDdad0tB4/s8zVkg4nKBm5Wjbug0Dlz3IdjPCWk1BK8e3IKm5wDwv4thhf+fLfXWvvi2v72NvdAm80ypp3SlJg1xmWYC0IwEwFL+roBNYHqmgmgHKZIudG77dbX70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqMVc9kD; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqMVc9kD"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79274e0e56bso35489687b3.0
        for <virtualization@lists.linux.dev>; Sun, 01 Feb 2026 13:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769979609; x=1770584409; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrM4NX39l+4X3I0Jzz5a+t2W5kTMBNHHRvTlPtw0XBk=;
        b=bqMVc9kDb21+1WQFobTiHZya+y1C3yI7KJ2tdcF50vrwfyMiuX3JbHfaT/APFw4HfL
         /r3Ho+0ndzpdr7uDVdsegl3qzkTwKvIl/+P2O88NnvoVSgOQ1JNW9V9EDZ7l0BAliGxf
         QgyRfaWbOs2sCiqPB2dSRAlpIMu1zq4gdDAiSz5X6Nj5JWaFgixrU35fcLR1PRqiO6Nj
         Z1pqV72MFPhtCXNKm/qwYVi+MIlE4GQeXaQE/w5xziH4pgca1jrzH7LG6fwnUl1pj/jO
         wFXSpwDdQ5zWweUHgSLd0Cqo+lrDAdnm0MReEynUcQGGCIDd9ahMbzRZyTcSjdM9TOjX
         yCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769979609; x=1770584409;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JrM4NX39l+4X3I0Jzz5a+t2W5kTMBNHHRvTlPtw0XBk=;
        b=b0zep7ZikjgDMVEFbAHmNY/rmar65LV7yxy169h5jObEVCoy8KG2cDvyOqDQQ3n6rZ
         VoCQswGPLjyvbRa+WSQh1Y3z3Tkb4cw8fG2kd2uz4wc42VPg6qC0tMF6vAmqMtbmzj+G
         PMaaOIa8iC3FyJHn7LFTO18/iGOe59ntI/Nb+gvzdc66enjoE1NVOHkJdbpz/BZ+4ooV
         WTNtetPD9agG7iXoh94ZBmIHjfy5Oo9deZ0Tfddyo2sE+oJJ4mOMKCQzz8iPGKar4xqm
         7boEqCyhk4S39AX89pHldyC7oSfDe7o9dSY9YkW10/3J9lhwqMqmdKwp8slWyEC7mPGy
         K31w==
X-Gm-Message-State: AOJu0Yw7fc3UNF0uGDZhMr0aX7/Ry9n7UizmHc887VGuNzSlXaKsRl2J
	rBS6XOnfE5Yfy+ZMK1RBFQMv4x7dNwqK+oo/VE0oQhzbQ7Y+8qelDGaU
X-Gm-Gg: AZuq6aJ/mB2z6qObMgONEjjw6ccowkg+ffYdU7c4h1lz9JA22MX/rZDKNTElAA+dJPM
	Pbb3hFucT0xVE9MalHdK1W5XBJDWUjiZupWoWVIiDP4Dysx7YMQckLrdAYKVSYGiucRTdK2mX28
	JDG1z2S4AiP8yBOeY5tYg2irjfTFBC3ztumCbZRo13x4iqcJgomEmN7yrktucZeaU52ptjVpaRc
	n16KvQ/Ycg7bt/iDE2J0YsPXANyjylj0t5ol07gbmUpf74xGIV4vQCzyWR8yxdmKG97ssSyub9B
	QV0OuHZmEGB0NyqURRSGfadTf0S7WKwX2LveNtgn3F4AYnpPSZbc4mQ6iToBngXAhehYTERpYZy
	bwgXlZT7TNQAYKF0QyxmUVAU9hn3i7DejIpY+aHRD9K6S4a2F2AGs+I1AbZizzFT0ovSla8rZzz
	P8vvm8+4k5vfOaNbN9noh4K247gjUsSozVjxoZQHqAbxmxstt3pspXXZlco/M=
X-Received: by 2002:a05:690c:34c3:b0:794:cb5b:89f4 with SMTP id 00721157ae682-794cb5ba215mr18826067b3.41.1769979608674;
        Sun, 01 Feb 2026 13:00:08 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-794d7cceafdsm4958417b3.15.2026.02.01.13.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 13:00:07 -0800 (PST)
Date: Sun, 01 Feb 2026 16:00:07 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
Message-ID: <willemdebruijn.kernel.279585f37ad8@gmail.com>
In-Reply-To: <20260129-v6-7-topic-virtio-net-ptp-v2-0-30a27dc52760@pengutronix.de>
References: <20260129-v6-7-topic-virtio-net-ptp-v2-0-30a27dc52760@pengutronix.de>
Subject: Re: [PATCH RFC v2 0/2] virtio-net: add flow filter for receive
 timestamps
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
> The changes in this series are to the driver side. For the changes to qemu see:
>     https://github.com/strumtrar/qemu/tree/v10.2.0/virtio-rx-stamps    
> 
> Currently only virtio-net is supported. Performance was tested with
> pktgen which doesn't show a decrease in transfer speeds.
> 
> As these patches are now mostly different from the initial patchset, I removed
> the Signed-off-bys from Willem, so he mustn't be ashamed of what his work evolved to ;)

Good to see this picked up. I would also still like to see support in
virtio-net for HW timestamps pass-through for virtio-net.

> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
> Changes in v2:
> - rework patches to use flow filter instead of feature flag
> - Link to v1: https://lore.kernel.org/r/20231218-v6-7-topic-virtio-net-ptp-v1-0-cac92b2d8532@pengutronix.de
> 
> ---
> Steffen Trumtrar (2):
>       tun: support rx-tstamp
>       virtio-net: support receive timestamp
> 
>  drivers/net/tun.c               |  30 +++++----
>  drivers/net/virtio_net.c        | 136 ++++++++++++++++++++++++++++++++++++----
>  include/uapi/linux/virtio_net.h |   9 +++
>  3 files changed, 151 insertions(+), 24 deletions(-)
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20231218-v6-7-topic-virtio-net-ptp-3df023bc4f4d
> 
> Best regards,
> -- 
> Steffen Trumtrar <s.trumtrar@pengutronix.de>
> 


