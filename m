Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795514452;
	b=c6ybSOrq8e2wo+Yrld9bEP9sN9rXc3qkoCwwR8RDgw1Syfz/3qBO2JTC7TfJFHCffKYR
	 KMHS7/wG50ZJ0JTpEGYjpdx/zPKvuFh7PTPXKAhApRN9PlSQLIQJb++Lm97sWQ9/pSxys
	 fsD3MT0ZOjR3YRden+nmj4utT0DlxDyzNsNVc9+fbAVrJKTqmUaAdKM9mRVxIRh9A0yng
	 RDli548yurrj0vMdgKuun0F2Xw8NaByzwTtxC377Nsfo+m7rqSbPewhIXqVjfpFa11DoR
	 jxSIGKHP32PYZA8BmNzRfvn5BP1CXCPmzexIl8IsbhqAGMm+k6zNhjA627qQVOYslVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795514452;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=yIIBQoRR89NTHy9ZCDwkHf8kWCbxt7j/00D8+1ttnwc=;
	b=Bve82zF2HqJJgEaAqSj8K0M1VpPMWFbbCTVthEfynY5979FqV9jYO4Eyog3L6Fc8CGe2
	 EjrudjcpIxybruLPLhdRq7S9eyShOdZc2QvGxrxWxpzJL1HISeV1LHzw7XdxELSCi395Y
	 qQGP0a2PTxj6cJokkoIN4Y6P+Zf6/eilOEAoEKYelW8PLQ3Z707+wvgEN5YbzU08yyr1n
	 4uXY+mVD1OP3VhfqQyAswidnPED2r+S02hrwvbWQP9yVpS1Z5CbHCzDbMwVohvo2ee1n5
	 9rK2UcApISs4KRDT2KrKju6qXsLdP9bkVACGXOuLUHdHiUgtCpVphZPXrBvhiNqxj4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=HKwOpv2c;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331AC606A330
	for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 10:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 331AC606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=HKwOpv2c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=yI
	IBQoRR89NTHy9ZCDwkHf8kWCbxt7j/00D8+1ttnwc=; b=HKwOpv2cS5rXfPE1/+
	tk3bNdlj0USE1sZjhsMmEfn4wtQaRIX+4SQaLTGshDgrPpuOrupAjod2D+3kA7Bp
	2ionbwMtLRMZpGJgb+2AZLe5VlKCsma50mUT3zZgaeZLzkggPcM+q4tq33virAwo
	P34qgP3fm0q3bWsu2b2DosITU=
Received: from user-VMware-Virtual-Platform.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3jiUtYAVro_nRHw--.24605S2;
	Tue, 24 Nov 2026 18:00:13 +0800 (CST)
From: Ziheng Wei <zihengw03@163.com>
To: gregkh@linuxfoundation.org
Cc: fan.jiaming@hotmail.com,
	amit@kernel.org,
	arnd@arndb.de,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_console: drop device reference when DMA allocation fails
Date: Tue, 24 Nov 2026 18:00:11 +0800
Message-ID: <20261124100011.5043-1-zihengw03@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026112438-juggle-squeamish-22ea@gregkh>
References: <2026112438-juggle-squeamish-22ea@gregkh>
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
X-CM-TRANSID:PigvCgD3jiUtYAVro_nRHw--.24605S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVQJ5UUUUU
X-CM-SenderInfo: p2lkv0ljzqjqqrwthudrp/xtbC7g4-j2sFYC50pQAA3h

Sorry for the missing context. The question I was answering was:

  Is this a duplicate of
  https://lore.kernel.org/all/aoWK_qpSBeO6Bw0M@michalis-linux/?

Yes, it is. Both patches fix the same alloc_buf() device-reference leak
when dma_alloc_coherent() fails. I missed Michail Tatas's earlier patch
during my duplicate search, so please ignore mine.

Sorry again for the noise.

Ziheng Wei

