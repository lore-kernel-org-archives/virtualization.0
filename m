Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295733DCD99
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 09:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946043; cv=none; b=TUG87vsE4ZsodIc3fSXWdf9wzdeowspOv5ssnKPDMr2OITUuvrqAXZ1bIYGxzS483gxmWJbRektyR/RnK4pHPfavxX0hscwPjl+1MpmuLuNS0VkdKafZTSFPuWSVGPX60c8N7+uFXOJFBedeUxzzaoX1E6Q3zVUCRHbIKWezmvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946043; c=relaxed/simple;
	bh=mwcV+x7YGKD/0r0AOXGnb+vaUCisPjv+ZL1Dk94i0pA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fdNjwEikPd46NKW6XlPk+15VmyHT9GO6eA3dTbWDEq0KdrZxteHuwEH4MXbXsS5gE/IYsTF5SgJR9K2PQO+ceZCav5NzwOPxzJSjIKWpUYVDrZa09bXTYz6falahk3ve5M7oUvxbmW6QDPetPXqJL4cEdbEqWTOL21+CXWF2wCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqW4AXbU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqW4AXbU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F471F00A3D;
	Wed,  9 Sep 2026 09:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788946039;
	bh=GaKnEyqOLubrNqVGEbEusDR7Go7+oMY26+DPvToRdCk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SqW4AXbU6xlKbRz2Du/DLCpd+u2Dsh1OEafkF91LvEpbd0p/QiZsGJ1ByGh0agsiF
	 8+0UCsKu/0hPga4Z6J2m0IkFNcSriL+IkYCW2k8XYvO2K7zHUy5Z9FY9CyQQVojm/1
	 KJQXj/LB1UGoVnNpUGONBTEqUW+QqGzLIe70m9G15064rQbh5Lwmig2LK3xwjovWuS
	 +05Ytg+Q2x2ab4eWu5j7EhljfFxaNWeMDukduqTm9CC/lfF+1TH0ObP5+ajhUKr9Bc
	 q9S3YmK+DoKIW072lhIle91eZFJyYZKRiLwuheqFk2mjs6weAWt9cpSKfBRw/COWaU
	 ZaRcimNeNI6Kg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC RESEND 3/3] virtio_net: add rx_timeouts per-queue
 statistic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Longjun Tang" <lange_tang@163.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260908092646.108865-4-lange_tang@163.com>
References: <20260908092646.108865-1-lange_tang@163.com>
 <20260908092646.108865-4-lange_tang@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:27:18 +0000
Message-Id: <20260909092718.D3F471F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Concurrent writers to per-queue u64_stats_sync from timer context =
and NAPI violate mutual exclusion.
--

commit 2e5fa229ff4c8c773848d0c1f36b14c2d2f2edf7
Author: Longjun Tang <tanglongjun@kylinos.cn>

virtio_net: add rx_timeouts per-queue statistic

This commit adds an rx_timeouts field to the per-queue RX statistics.
It increments the counter when the RX watchdog fires and exposes it
via ethtool to track per-queue stall events.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c

[ ... ]

> @@ -3094,6 +3097,10 @@ static void virtnet_rx_watchdog(struct timer_list =
*t)
>  			unsigned int stall_ms =3D
>  				jiffies_to_msecs(jiffies - rq->watchdog_jiffies);
> =20
> +			u64_stats_update_begin(&rq->stats.syncp);
> +			u64_stats_inc(&rq->stats.rx_timeouts);
> +			u64_stats_update_end(&rq->stats.syncp);

[Severity: High]
Does this introduce a race condition with the NAPI poll loop?

The u64_stats_sync API requires mutually exclusive writers per syncp.
This timer callback (virtnet_rx_watchdog) executes in a global timer softirq
context on an arbitrary CPU and writes to rq->stats.syncp.

Concurrently, NAPI polling executes in the receive queue's bound softirq
context on another CPU and also writes to rq->stats.syncp. Since
rx_timeouts was added to virtnet_rq_stats_desc, NAPI dynamically iterates
over it during virtnet_receive():

drivers/net/virtio_net.c:virtnet_receive() {
    ...
    u64_stats_add(item, u64_stats_read(src));
    ...
}

Concurrent writers corrupt the sequence counter on 32-bit systems, causing
readers (such as ndo_get_stats64 via ethtool) to spin in an infinite
retry loop.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908092646.1088=
65-1-lange_tang@163.com?part=3D3
