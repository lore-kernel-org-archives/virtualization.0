Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E743372EF3
	for <virtualization@lists.linux.dev>; Fri,  7 Aug 2026 01:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786066345; cv=none; b=dzeyUrYefisPqxY1MXVpS8gKkLxH+Kd8RQRO6AVI+hi5hGaP9Qx7J5ETZhxWEZsRGFWgEELG06mjOMawP56f8J8ikUBi/KJLGFpBgC66s1RMeKHVynx0s+IJxHKfY0Wz01k4nEUdbGapHsYm2haZ+6vVJuLYosq4WEzTChPmLUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786066345; c=relaxed/simple;
	bh=wsyRP142YZf4XMnHzOGwUdUJ8c/hm1/gqr1lEZT3WFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qj4jpzl49pAYXwhMBDWsHE5pZN5jKzPsNHDL6B7evU0UFOusaIoY4IRVCGI/KVXN/dkYGhfviHbyXb6kgGwK5aHl2bKay+CgY3BV5HXyJowYRZ6Vatya1ap5WNhA5qnTShSnbUlzG4qMRr3+z9nVy7hpvMQh2A398N+C/hW8ee4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ce5aaa0c91ff11f1aa26b74ffac11d73-20260807
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c5ffcfe7-d20b-407f-bcb1-85d1a0c7c666,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:a2fd6a2d36fbc58e45ea6ac09a000e97,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|136|865|898,TC:nil,Content:
	0|15|50,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ce5aaa0c91ff11f1aa26b74ffac11d73-20260807
X-User: xiongweimin@kylinos.cn
Received: from xwm-tianyi510pro-14imb.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 492142625; Fri, 07 Aug 2026 09:32:08 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] virtio_net: unmap AF_XDP header with tx virtqueue
Date: Fri,  7 Aug 2026 09:32:05 +0800
Message-ID: <20260807013205.2130344-1-xiongweimin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806160411.2689177-1-kuba@kernel.org>
References: <20260806160411.2689177-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Aug 06, 2026 at 09:04:11AM -0700, Jakub Kicinski wrote:
> Would it be clearer to state "no functional change intended" ...?

Agreed - with the existing dma_dev equality check, rq->vq and sq->vq
are equivalent for this unmap today.  I will drop this as a standalone
"fix" and fold the sq->vq symmetry into the v2 series with an
explicit no-functional-change note (no Fixes: tag for that part).

Thanks,
Xiong Weimin
