Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.205
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794566318;
	b=S0wObVsx6VdGQFOrgTmye4NgY8OpHo8QaUhcuFBEBLZce4qy+QLPD9e38PM+Br+M/0vL
	 vukCPsDeMYCR4dD9qGcKc2nAxqYpqPvDQ2d2vtF+IkfyvC91kypkinzjsAKyZ3vsN+Evr
	 uoGL2ROKCbrG5pLj2b8EkDDjZkeruDrlZ1DXnpcOUD33O8h+HPfMDpjGWm17ESBEQmQe7
	 WtAjXjiETd/POlvgjbUSUzpRthvnVyDsq9gTuEf1UFhQyLcILPlgOmnBoq+WEoNaz76Fp
	 11i8R/8mUC3g02bWijDH16zGV0ZkhVrx7ZmGy5Yivcgoy8rSvln0YTWkcXkvhcw9ofQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566318;
	h=DMARC-Filter:DKIM-Signature:X-QQ-XMRINFO:X-QQ-XMAILINFO:From:To:Cc:
	 Subject:Mime-Version:Content-Type:Content-Transfer-Encoding:Date:
	 X-Priority:Message-ID:X-QQ-MIME:X-Mailer:X-QQ-Mailer:References:
	 In-Reply-To:X-QQ-mid;
	bh=yiVvrAzHhnqGTuFkC7TTJCqz/SjLoNkNWUXIur4ZiLg=;
	b=46EcsA51JEmDQSNCl88/Xxn4H7pcIxuHVMvBh7yI/sZ6FeCNdNAqOXLt080zc6dvyf1v
	 IlBSqtFZIHht5+wJ0AtuVDyZ24ee/tgdSlXL6A/o15OV9zAKWUXQvMa7I8hzv/FYkoK1c
	 2d8JoqJXU5lQHxbOUPOCgiWknarrM+qO6eP1BD3RjpP2kWKO7rT7RAqsbcRouzyq2ydHI
	 QMLaxoJzqtTK52VKcsvnDV5cN0qkVaiWNJe3G6od8tRyG73ZVL9LPc135f7S3OKb2BgvY
	 4ZxLlXCZb7vS3f6dUF8Y1eg/Akb9gzchJklMo+7+/sLVe71fGRAoW31muwp41DEnrFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b="tS/lmvhl";
	arc=none smtp.remote-ip=203.205.221.205
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70497606A321;
	Fri, 13 Nov 2026 10:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70497606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=tS/lmvhl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794566313; bh=yiVvrAzHhnqGTuFkC7TTJCqz/SjLoNkNWUXIur4ZiLg=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=tS/lmvhlGN1l30n3FyOvB5Y7Nih4AeKywVlGpqDnyIQYvbQ8zqfVZRIQ8yxvoyjpY
	 kMlqSYsh+vvUXNQD72Q0eaPC+6qGS/3MJOiPNiYpkwxj5vNzdJERKNpk1X2JEwsWix
	 FfFba6Wwe2nbKBe+4mJZoRYmoiFdx7fzAXtxnY5c=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-XMAILINFO: MdmyWVu0InhAUNv16odREWE3a5Yrsgy7rtEDxoUgTS2ie18ZbVUAkOcRxWt9fT
	 4j1eF8tIfoohuluP79yuvsLukrdHD/kH9A5Vn/zwjoMMTKGIcq8e+gaADcSvPJ7cavRYK6C1ww8nj
	 0Z1+JNM0SeFyG4kDDz9XcYv4/7SzYwNt1GUv0tkITh5mGp+o/gGBlalC+hi6T459gQseq3535SywF
	 ClLd0azcL8Pb7Cku0byYtihoaz05lAi4eMgMpj3qf6P+Z/BmkLBSsHDjmwGenwrkrl7p+ypscJJb+
	 WWALE+mZZWrPI3DL9EP2Fg0nzkzMS9Wbt0N74zH2mNqlJzaDmTB8eTuPQqmYW7c1a4hu7wWZ8H57B
	 zX5U9ncn+D4BCi3hn33XwmX39EHw/k5Z30oNMAWxjHqFZrd1AU5sgg7nL/VSJbvEkEOcNOPWippSc
	 AOglTHjcKXAxiavZ6JI5xg6H/uIkGrMSNeJpESisk0zERdAnQW4lid0EMX1BJOrtO4ATnQHgOFuGu
	 L3L4xRG0GWjuUkICNsL2ci69vRtD6Ti48cTBCb8dPGtx5Lz1jNm0qDT2BrZ2ZdEBaG76OEcbXoJDS
	 C8LNV5AUnFR+bzjK542nMAILCUPV7XGhYNXxCNFT4U5WrdcnsC1ytJLo/s8A5xOCcqlD/4+jergdQ
	 Ll/oEBTZImYamPHrSawVsqGALtUoB3O89O+oVUS3oYdu9TVIk0GRzFEHzzM5hNl4V2stbIJNPvd4I
	 LDn+Fn6tAmWZl4gmCpXJpt9HM1q+CjzcQqHQ1VCRjWMmnr5HFfqnczs1nQaqIUZvylVPJFLvePvHZ
	 Q0U+qMvpVCBvZPuIVrznhn/WX3rLNjxwT+jEn7m7pSEbT1kqJxpXr2tFzXO0z1aSfg+6KlX5RWAvS
	 Ql7HYux3csJ6pQ47NKfBwC3vKUKB8u1bmw09JHpnCV96BrKyx1Hrn4fF3Du/1ZsmE8bgDjFHz3ipk
	 eaVSvxi1+PQTt5UYUypHy+ALbJSkntBDKkvbsSa8A0XaVSI830MbqeDz4mgPxFVLVRh2cYFH7bkgM
	 bkChzXAwICxYn2+zca2BfOfAioiBsqiQLGvK2hapWrn7CHD+eYaccVyskT48j0kgqZ5P3
From: "=?utf-8?B?emNq?=" <zcjie0802@qq.com>
To: "=?utf-8?B?c2FzaGlrby1yZXZpZXdz?=" <sashiko-reviews@lists.linux.dev>
Cc: "=?utf-8?B?dmlydHVhbGl6YXRpb24=?=" <virtualization@lists.linux.dev>, "=?utf-8?B?TWljaGFlbCBTLiBUc2lya2lu?=" <mst@redhat.com>, "=?utf-8?B?RXVnZW5pbyBQZXJleg==?=" <eperezma@redhat.com>
Subject: Re: [PATCH net 2/2] virtio_net: mask callbacks before releasing NAPI ownership
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Fri, 13 Nov 2026 18:38:31 +0800
X-Priority: 3
Message-ID: <tencent_1F60CBD50DC4A0CAE66E5B5BE4FCE941CD0A@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <tencent_AA4F39DA7ADE330C721C03AAA832B92DD608@qq.com>
 <tencent_3206E4502773D7AC6F720CF4046674E5A809@qq.com>
	<sashiko-outbox-211234@kernel.org>
In-Reply-To: <sashiko-outbox-211234@kernel.org>
X-QQ-mid: xmsezc52-0t1794566311t4y03mkfz

PiBTaG91bGQgaXQgaW5jbHVkZSBhIEZpeGVzIHRhZyBmb3IgdGhlIHBvc3QtY29tcGxldGlv
bgo+IHZpcnRxdWV1ZV9kaXNhYmxlX2NiKCkgY2FsbD8KPgo+ICAgRml4ZXM6IGZkYWE3Njdh
ZWZjMSAoInZpcnRpb19uZXQ6IERpc2FibGUgaW50ZXJydXB0cyBpZiBuYXBpX2NvbXBsZXRl
X2RvbmUgcmVzY2hlZHVsZWQgbmFwaSIpCgpUaGFua3MgZm9yIHRoZSByZXZpZXcuCgpmZGFh
NzY3YWVmYzEgaW50cm9kdWNlZCB0aGUgcG9zdC1jb21wbGV0aW9uIHZpcnRxdWV1ZV9kaXNh
YmxlX2NiKCkKY2FsbC4gSG93ZXZlciwgYmVmb3JlIDZmOGIxMmQ2NjFkMCwgdGhlIGZhbHNl
LXJldHVybiBwYXRocyBpbgpuYXBpX2NvbXBsZXRlX2RvbmUoKSBkaWQgbm90IGNsZWFyIE5B
UElfU1RBVEVfU0NIRUQuCgo2ZjhiMTJkNjYxZDAgYWRkZWQgdGhlIGhhcmQgSVJRIGRlZmVy
cmFsIHBhdGggdGhhdCBjYW4gY2xlYXIgU0NIRUQsCmFybSB0aGUgd2F0Y2hkb2cgYW5kIHJl
dHVybiBmYWxzZS4gVGhpcyBhbGxvd3MgYSBzdWNjZXNzb3IgcG9sbCB0bwpyZWFybSBjYWxs
YmFja3MgYmVmb3JlIHRoZSBvbGQgY2FsbGVyIGRpc2FibGVzIHRoZW0uCgpGb3IgdGhlIHdh
dGNoZG9nLWRyaXZlbiBpbnRlcmxlYXZpbmcgcmVwb3J0ZWQgaGVyZSwgSSBiZWxpZXZlIHRo
ZQphcHByb3ByaWF0ZSBhdHRyaWJ1dGlvbiBpczoKCkZpeGVzOiA2ZjhiMTJkNjYxZDAgKCJu
ZXQ6IG5hcGk6IGFkZCBoYXJkIGlycXMgZGVmZXJyYWwgZmVhdHVyZSIpCgpJIHBsYW4gdG8g
aW5jbHVkZSB0aGlzIHRhZyBpbiB0aGUgbmV4dCByZXZpc2lvbi4gVGhlIHByb3Bvc2VkIGNv
ZGUKY2hhbmdlcyB3aWxsIHJlbWFpbiB0aGUgc2FtZS4KClRoYW5rcywKQ29uZ2ppZSBaaG91


