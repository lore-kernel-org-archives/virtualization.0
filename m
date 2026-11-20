Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795158664;
	b=y1Fhg4Vxkb51OLv0XPtR6aAL7YgKk6xq52ONp7hTmwG7zU3gdqvHaVNEeYnAkmE90bo5
	 34Ac/8PSNeA7EQFjIEMpVdCie4WjPAFgNcCJ0Wkai+AEPzuJa66KxZZiqhNJh90+JbuV+
	 cxnxSgFtXIPmQDIRJFgc3aM+K7J40gWeXrrlhf1pT5GekRWXs5CdOkz4P1U6NbJva50Jt
	 RpQ9ZJ43aHKvIFAXxNqejx3C/n55GteSlF0osLjGqWt0nxtHNh495BN20OE2rfqWrOD5M
	 8FWYC8x5Am/xw8FjZx+7bR7626wExAQ56TfB/7jSBS/LbcU4xur6yeh+glmSeo2MgnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795158664;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:X-Priority:
	 X-Mailer:In-Reply-To:References:X-NTES-SC:Content-Transfer-Encoding:
	 Content-Type:MIME-Version:Message-ID:X-Coremail-Locale:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=+DqeLXTbuKh5VVoCRVxV9j5x7CUCICaFzKJDzMFjyF4=;
	b=iTChx3Vaj8od5IZK100w18VJLbYDPBSJNdytEeKNCWuXtNRm7EcouqUUjbug+qOLIuzG
	 pn5Kj0MfplyHTf6tA1NmDm2N7ZPGESQteY+1AR2aRQpfHmPsJvJrgLBqpygRghonMobxA
	 58XKRKhuHm6fMS/zGzgjqbP0KeiYY7fl8k12Qmdl6DI6VQ7e6m2Xx1pQFn8TLXN1RmvMD
	 HPvB2ZLQ4bQM6m0v/a8WNV9lXJovaQ9jWu1mq6yS0nA1z1U1dYdO4hqBSiNgPFPI4vI/I
	 o6EVXV6kroEIcmC+milFx25YaWSDANVwffyfMH0Y4ZuSFM6W0CLRB4e/0Q7lrLoAiEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=MTRNBpkR;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26F1606A320
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 07:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F26F1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=MTRNBpkR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=+DqeLXTbuKh5VVoCRVxV9j5x7CUCICaFzKJDzMFjyF4=; b=M
	TRNBpkRnxeVAws52leRBrCd6ElyxuJcGQsuRYRG6jpVfXq0G5Hpjw5E8f32+Okno
	qvgpqvBQWD9P9hPqQ4uwAinKXYnR9MgRP3hbMbFw/bMCqquIGGz2V3VgVv1szoDi
	ZsV22eqCGYUMuqW/BXUfftrekELGkUjZMHIIqWDrdk=
Date: Fri, 20 Nov 2026 15:10:45 +0800 (CST)
From: "Lange Tang" <lange_tang@163.com>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "mst@redhat.com" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>,
	"jasowangio@gmail.com" <jasowangio@gmail.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Tang Longjun" <tanglongjun@kylinos.cn>
Subject: Re:Re: [PATCH 1/3] virtio: add virtqueue_get_last_used_idx() helper
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20261112085123.276997b4@kernel.org>
References: <20261109094310.103979-1-lange_tang@163.com>
 <20261109094310.103979-2-lange_tang@163.com>
 <20261112085123.276997b4@kernel.org>
X-NTES-SC: AL_Qu2SB/2et04v4yCRbekfmUgRg+c/XsK4svUj24VVOJF8jCDp+SEJYHZTFGvuwfi3ASqsmSO8ahFRxdZ2Wohybrgl6SutMcW08aThePl8uLus7w==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Message-ID: <1067ca32.5945.1a1f7cb1971.Coremail.lange_tang@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:aigvCgDnz8V28v9qdXxyAA--.306W
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC-RZ0omr-8nZkMAAA34
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNi0xMS0xMyAwMDo1MToyMywgIkpha3ViIEtpY2luc2tpIiA8a3ViYUBrZXJuZWwub3Jn
PiB3cm90ZToKPk9uIE1vbiwgIDkgTm92IDIwMjYgMTc6NDM6MDggKzA4MDAgTG9uZ2p1biBUYW5n
IHdyb3RlOgo+PiArLyoqCj4+ICsgKiB2aXJ0cXVldWVfZ2V0X2xhc3RfdXNlZF9pZHggLSBnZXQg
dGhlIGxhc3QgY29uc3VtZWQgdXNlZCByaW5nIGluZGV4Cj4+ICsgKiBAX3ZxOiB0aGUgc3RydWN0
IHZpcnRxdWV1ZSB3ZSdyZSB0YWxraW5nIGFib3V0Lgo+PiArICoKPj4gKyAqIFJldHVybnMgdGhl
IGluZGV4IG9mIHRoZSBtb3N0IHJlY2VudGx5IGNvbnN1bWVkIHVzZWQgYnVmZmVyLgo+Cj5rZG9j
IG5lZWRzIFJldHVybnM6IChtaXNzaW5nIDopCgpGaXhlZCBpbiB2MiwgdGhhbmtzLgo=
