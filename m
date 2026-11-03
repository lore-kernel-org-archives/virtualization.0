Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793676583;
	b=y0liDDa4usg69HPUxmYzybGa8Oaw3uoVIg7tZHsPkmSwcOtK27mUrT4cYFq3/T1Ls1y1
	 0X0IP2r9Q+Z8Qr2xSUcfYsuv6Mk+XepvrB8a5Hy4E7CJa9Mw4W8FdZpI4gNMew96C5/tt
	 hhxattighTR026kv4HkjfViyaHjNep+d7sEFNj9y8JfrdhSmKGCn7sRqhEFtjJ4osg0MG
	 fJvItKO/U84EUlq5SQN6yTC5Tfe0J0g73pmkgV+WB0WWYKLy7KGYz2D0/7NR3vEExH6kY
	 cj2pVVC+3QT35QBZkgsqoDEI5ccVmzZ1ZM79geylqFaaIVM15R3Swo72A0EJVramVGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793676583;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ss1QRBiOdnr9UcY/nCSTQQvqTaweAfZZQDUzoYpDMUU=;
	b=Hslj+q4IiUMU//Ue/gxDL4NsFSUp9NxSdo2Z/MYmxSeSwLcf2oqZ60PCYVqUMBp8f5Wi
	 NGnNHzOcShA49i6AuR1Yn8kdOA6HxkzAVE9WFvGbTihP4HueKbZseHvTJUrpmRQYbjujK
	 vNoNYVB0L1T+1+gDe2OEck2K7FjMhIKglwNeuEdydwx5X29VOe6sgya1vGfT8xb2c1Lmj
	 2SEdN5u5Bz8N08spqbOIF8gWI25vRrPTJhcjjIgJydJ6/8buF85ctQjftcc4uTnZU1Jvz
	 D+cDOV/4BQMPixUpqy+7WsjJDD+Wa64yDK84GhRevHAnkVliEA7HsApykdj6HtyLYlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=oeYbuWA3;
	arc=none smtp.remote-ip=115.124.28.5
Received: from out28-5.mail.aliyun.com (out28-5.mail.aliyun.com [115.124.28.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064BE606A324
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 03:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 064BE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=oeYbuWA3
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793676578; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Ss1QRBiOdnr9UcY/nCSTQQvqTaweAfZZQDUzoYpDMUU=;
	b=oeYbuWA30U41w3rtaAKRcPt5wdabjBxKNMyJEZNG4DvlLOP/nh/QYDGTdtYnmOm02knA6r1/4z7fCPz3nWBwzj0e9yTJiAotNiXesEGAtBaPelpWT3sl2zrRVIUvhoAV3sX8lDg4LzqtIzjZdoayJstQXr8JoxiftOqNhJU5ZCs=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06301045|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0205256-0.000483592-0.978991;FP=18268939574164468826|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.jvDbLeN_1793676576;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jvDbLeN_1793676576 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 03 Nov 2026 11:29:37 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: Re: [PATCH] vhost/vringh: reject zero-length indirect descriptor tables
Date: Tue,  3 Nov 2026 11:29:35 +0800
Message-ID: <20261103032935.58823-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261102122942-mutt-send-email-mst@kernel.org>
References: <20261102122942-mutt-send-email-mst@kernel.org>
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

Hi Michael,

Yes, same fix - sorry. The October 21 posting is a duplicate
of the v2 I posted on September 26:

https://lore.kernel.org/virtualization/20260926160755.21485-1-fangxy@xiaopeng.com/

I resent it as a new patch instead of a v3.

The !len form is equivalent to v2's len < sizeof(struct
vring_desc) check when combined with the modulo check -
zero is the only length below one descriptor that is also
a multiple of the descriptor size.

The diagnostic change is to pass the byte-order converted
len instead of the raw desc->len, so the reported length is
correct when the vring byte order differs from the CPU byte
order.

Would you prefer that I send a v3 on the original v2 thread
with this diagnostic correction, or should I drop the
October 21 posting and leave v2 as is?

Thanks,
Fang
