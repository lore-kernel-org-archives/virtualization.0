Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.37.83.207
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325059;
	b=Z9c6aFWxL7VLq5Vz624k4dwXd9wW5sDfWZ5DxTBAbHlKSeEtfDDK0w3ddWhB8TY9G5vp
	 1zjOudFfK2hGKAIUQ1o5vr/nZpOMM5LTFdtrFwN6k8pNDPAKSJuP8cGCJtYpE2UUN1dVk
	 4QEVrEnjlWr1J7i7VMtFV0Hj7Fzl4kzJ9ZJCkAN9sVF5stllSdIxj8Ovs18jYQ5IY6z0o
	 sGYIqOxaIdGYsOt9ArNZSDfmBaMxksjzRek+2dX0DmCYHDbuxMVMBE/FtC8ew+uyWCWU+
	 ng/kk5GYlANX/1jux6Qn+jzwcSG1LrsQAzeeZ3m6+TOhvZVRSrS+LsSyq3vX7OyYZRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325059;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=z2zJvtWSvsoPKBlouh1vBhxQqaiQUERZXakXN2vXVOQ=;
	b=g5ASF9wgJ9WiDPRuI7xn1kxhO1eY40wI2X11sCR3TdsgVFbXftavvOAU7KBeHJCOBs40
	 EG5ydsKnKu3YhkSsgVppUxNJNlgPTLZg4Yph+O527Lot9P0OElB8SEAqFjVb3wLOGRw2Y
	 XwNLen5nRx1PPOj/fTsOMZYq+juak8tRIM+EwmZ+I3CUEdUkLuxyiIzNdehuET3lBKt4E
	 Q2C1X0bhNE9dDpMHcu00SC7VvTUzCNMKgfby/z9menl15M4zbNxPRKR3rrHJdgvol44/e
	 tCOgC1bKrRHBVZRcQn+emuu4C07XTiztyflVjfl/94Io7wU7pDxOd/IWH0ieuk30s1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dfb.sh;
	spf=pass smtp.mailfrom=dfb.sh;
	dkim=pass header.d=dfb.sh header.i=@dfb.sh header.a=rsa-sha256 header.s=frkn header.b=JPxWjCxK;
	arc=none smtp.remote-ip=54.37.83.207
Received: from frkn.dfb.sh (frkn.dfb.sh [54.37.83.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B201B606A31C
	for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 15:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B201B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dfb.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dfb.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dfb.sh header.i=@dfb.sh header.a=rsa-sha256 header.s=frkn header.b=JPxWjCxK
DKIM-Signature: v=1; a=rsa-sha256; s=frkn; d=dfb.sh; c=relaxed/relaxed; r=y;
	h=Message-ID:Date:Subject:To:From; t=1794325021; bh=z2zJvtWSvsoPKBlouh1vBhx
	QqaiQUERZXakXN2vXVOQ=; b=JPxWjCxKBH8abNNVsGVlylt+XDYXUaqaaQonjUrp1z8FOc8/jH
	UbZL8dOgHB1H7YtwbT7eP9UQz7uQDBUnc+KHFsBRe1vlPsvftj9MKuxRZn+ZWMiphH8U8LEMS41
	kx0dCGuH3Id9Qxj10rMX5eymPmEs3ci5shVPQZ0uerrsZ5Z09g22W1kF/RNXidr9mbCORmmQE3d
	6nXKJaBZZaCs5F+zs71Rh/yc58CCxQhgKvdNX5V2K8Gs7girC8u0DBTl4XsP52uSg/gEVyTzrz5
	cY0zzpSi/KHx0H83apY4WrgBza4ZlKej0GyC/bOC6XJUj2Uuf7ySA66PLl5kKCK3OxA==;
From: Vladimir Petrzhikovskii <vladimir@dfb.sh>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	vishs@meta.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	nikolai@kalinidze.me
Subject: Re: [PATCH net] virtio_net: check RX buffer length before DMA sync
Date: Tue, 10 Nov 2026 16:36:57 +0100
Message-ID: <20261110153657.599022-1-vladimir@dfb.sh>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <179425939711.994134.2719389056327615125@kernel.org>
References: <20261108-b4-virtionet-rxlen-v1-1-0078c5ab7e14@dfb.sh> <179425939711.994134.2719389056327615125@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 09 Nov 2026 21:23:17 +0000, netdev-bot+sashiko@kernel.org wrote:
> Should the Fixes: tag point at 295525e29a5b and/or fb22437c1ba3? It would
> also help to say in the changelog that those trees need a separate fix,
> for example limiting the sync in virtnet_rq_unmap() to the posted length.

Yes, this is right. Since 295525e29a5b virtnet_rq_unmap() syncs with the
used length before any length check, and the mapping covers the whole
frag, so those kernels have the same problem.

v2 will carry Fixes: 295525e29a5b and say in the changelog that kernels
before v7.1 need a separate backport. No code change. We will prepare
that backport for stable separately.

pw-bot: cr
