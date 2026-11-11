Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.191
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409736;
	b=zMO0x1BhjxhZSMLey27ghzAQZNUmYimO1fXWEQoLDPM7aDjfSXlhhquTQJue9dClabbe
	 7UOAcHASWRWPMk2fyBA2jblEhIRcTT6hZHkx2OtoDHDDJEEc3iVEJQau5c1BkXszFOO+Z
	 kFVw8udjohSEwfOy8/QCua57P1wEBKlt/PdoSpzdkNiYjXrE+4vIljNtxE4V7K52NP+Mv
	 gMiYbi1pxO3C0CHvDk+qu9AgkPtbyZ/GN61Cf1aSbAfmklhSJtm5ixwQM65+5lelRR08o
	 t0qw7Ibp6dyN2cTpU09gae4r/ydlxwuRMuDiJau1mj9DXUTgP6SuF9TDpxHXDoA0LJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409736;
	h=DMARC-Filter:DKIM-Signature:X-QQ-XMRINFO:X-QQ-XMAILINFO:From:To:Cc:
	 Subject:Mime-Version:Content-Type:Content-Transfer-Encoding:Date:
	 X-Priority:Message-ID:X-QQ-MIME:X-Mailer:X-QQ-Mailer:References:
	 In-Reply-To:X-QQ-mid;
	bh=LPV/0m1FhlHncjDMGPgjphBsoLLLCxbF9YAsFHWAVCk=;
	b=s2MS8w3pdIvj4h96wE345RRZue4tFhoix2QL8RJPHDFSFw/W2gQu1yoOnNcHdWpGVKqP
	 u7JCABT5OZ3tOYZjqFt3b55lhMwtVBLgH8UUKvjnDssFPa4Q/4J15Noe4XM4YIK69Da03
	 alVq7z9dl4RIJ8rULyfYd0dZ2MSLzIOqvnlXmfxefXa6lz8oxm8l95eyxMlsZopvqZpjc
	 eqijEyRNoHsv5ImR0tpeI+i4UqdUYs3yTs0U0hXfduoRhGHGBYNS7j2O5wklaIHEX414S
	 YseJSgeTMWZk4kBY6zwyp7ykAQWOHRQOoqago1qQFPwWkGYUdE5p2BLZz07GSeaHljQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=EAOBzMc3;
	arc=none smtp.remote-ip=203.205.221.191
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3C6606A899
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 15:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C3C6606A899
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=EAOBzMc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794409731; bh=LPV/0m1FhlHncjDMGPgjphBsoLLLCxbF9YAsFHWAVCk=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=EAOBzMc3O6x8UPIR7x/MytAXpBssLOPoe96zo1eP/1KlUnlf4PfpX+frIPnoF2xtp
	 kxRZApTZHVC1lQr5aSKekIlBPJ8i1w6a6x6xMY0qFr+qA7VFQVLbqwFJI9wmkegfVw
	 VimFhgk0wXyExaFHqVdCdf5XTyUxiIv+EeAdZ3P0=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-XMAILINFO: MqG4KXyEKpQy7PiNJkUwScMSuOKEvaNZq9Aq/l5NSGpib8u2OnqKzLAYdyyp/A
	 8eVi9qNs+CP5ydoCffnvW6hiPslk0aUOXOBuc1thONTqbCeHXpC+v6IONyx6aR7S/u/DenGt2SRoX
	 ajixyL2fwiQhdxPEs/cozU/PKNbKmLEKC1gQGjV14krN6k2p6X2SlQgnu2Ly1El7o5UtwT8DpGQyC
	 tGQkMhFiclq4hbM2hsvcexfNtuzWL6xAg4t7T0hS5hAo0rmaYPqcz03qu5ByugQ3Q1nnsZQEeqNBS
	 BKsjyM0hJ9h5mji3S3fpmh7QDEZZVMEtN4k6vD1TaxPUEgY81NZXBlPSYHE1CURSMKUhy5VBtEqS0
	 MSnr/yGnQW+h+mBm3axG/KeXlS0Qi6LNRU4T0CxJ6M2x+oiXVnRKkyHF/UzJjTJOGWfFAgn2HKr4+
	 uf3Dw227SMxQzvtD7V6LZZfw30N5ivVE9JGpoNPNzU78GOyiT4vCqovuWQADU2ALrfsZk7RuJ1fr1
	 fl9japYPU6vqvNMSo9rQCnZqU3F7ilWJRr97qmhUhoiyJK1Qndqx1KQUuPMdIgQwVIMqSwvuef99u
	 tsIp43Qdd45wQ0nq/wkPRm9Y9PSH3Tx8zP3zVf2HJ1Uov/C0eJwmi8XWaK/ryvS+7gURwal9uyN13
	 jJh17/rAHGASKuibWbMZxk4MNqu4WYdEbWM2hQW1LQfF3iHLl4h7+Ty02V9ZzSfTVY3DTV7g7SXKI
	 MdcsD5M567oFWFEeTGtvUYjb1nfRp8j3u+mGR4g44Ei3DAOzjZ3fSUGBtDGmyNGXajcBP73ws/U77
	 UuMQek1qD+4SJwy0IYkcDTCZS5YME9hcHjX4dmHN8KSO0OA3G7lwZ4pl/UG0ZIDp3+mLV1yaufU6V
	 e+EHW5xi8V0Kntk4xbTC4MUwdIkHMToFy3jPYH8K0joV1W/6PtjmSk2dLtWQA58/jNrHkKTHU/Skj
	 8eqtSrFPB1lxVOkOm1tdCMhRMhGoe4YG4SNeVNvIvN9K1HMFN1tllxFDW21NZOhj/lguwaITAFRiu
	 0+f0Gbz4dUoMXjkI2iCMVoTBSqvq6ljD6bm1yupwvz65wUMwz+nw5a/YNoAmQrihrF4qKOsUSdQN3
	 Mtgm6JTFWchzFA==
From: "=?utf-8?B?emNq?=" <zcjie0802@qq.com>
To: "=?utf-8?B?bmV0ZGV2LWJvdCtzaW5mbw==?=" <netdev-bot+sinfo@kernel.org>
Cc: "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?utf-8?B?bXN0?=" <mst@redhat.com>, "=?utf-8?B?amFzb3dhbmdpbw==?=" <jasowangio@gmail.com>, "=?utf-8?B?ZXBlcmV6bWE=?=" <eperezma@redhat.com>, "=?utf-8?B?eHVhbnpodW8=?=" <xuanzhuo@linux.alibaba.com>, "=?utf-8?B?YW5kcmV3K25ldGRldg==?=" <andrew+netdev@lunn.ch>, "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>, "=?utf-8?B?ZWR1bWF6ZXQ=?=" <edumazet@kernel.org>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>, "=?utf-8?B?cGFiZW5p?=" <pabeni@redhat.com>, "=?utf-8?B?aG9ybXM=?=" <horms@kernel.org>, "=?utf-8?B?dmlydHVhbGl6YXRpb24=?=" <virtualization@lists.linux.dev>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 1/2] net: napi: add completion with an ordered IRQ mask callback
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
Date: Wed, 11 Nov 2026 23:08:48 +0800
X-Priority: 3
Message-ID: <tencent_4DBDF69909B9FD811F54F2DC0E6BAC1C0507@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <tencent_AA4F39DA7ADE330C721C03AAA832B92DD608@qq.com>
 <tencent_74EA7A2E8BF5758E9C5EF18C9B1CED401D06@qq.com>
	<179440541756.2168702.17991706426089713368@kernel.org>
In-Reply-To: <179440541756.2168702.17991706426089713368@kernel.org>
X-QQ-mid: xmsezc52-0t1794409728tprkn7v98

SGksCgpJIGZpcnN0IGVuY291bnRlcmVkIHRoaXMgaXNzdWUgb24gTGludXggNi4xOC41OCBk
dXJpbmcgYSBtdWx0aS10aHJlYWRlZApUQ1AgcmVjZWl2ZSB3b3JrbG9hZCB3aXRoIHZpcnRp
by1uZXQgaW4gS1ZNIGd1ZXN0cywgYW5kIHRoZW4gaW52ZXN0aWdhdGVkCnRoZSBOQVBJL3Zp
cnRxdWV1ZSBjb21wbGV0aW9uIG9yZGVyaW5nLgoKVGhlIG9ic2VydmVkIHN5bXB0b20gd2Fz
IGEgcGVyc2lzdGVudCBSWCBzdGFsbDogdGhlIFJYIHZpcnRxdWV1ZSBoYWQKdW5jb25zdW1l
ZCB1c2VkIGVudHJpZXMsIGJ1dCBub3RpZmljYXRpb25zIHdlcmUgZGlzYWJsZWQsIE5BUEkg
aGFkIG5vCm93bmVyIGFuZCBpdHMgd2F0Y2hkb2cgdGltZXIgd2FzIGluYWN0aXZlLiBUaGUg
cmVjZWl2aW5nIFRDUCB0aHJlYWRzCnJlbWFpbmVkIGJsb2NrZWQgd2FpdGluZyBmb3IgZGF0
YS4KCkEgZGV0ZXJtaW5pc3RpYyBLVW5pdCBmYXVsdC1pbmplY3Rpb24gdGVzdCBhbHNvIHJl
cHJvZHVjZWQgdGhlCm5vdGlmaWNhdGlvbi1sb3NzIG9yZGVyaW5nIHVzaW5nIHRoZSBwcm9k
dWN0aW9uIE5BUEkgY29tcGxldGlvbiBBUElzCmFuZCB3YXRjaGRvZy4gVGhlIHRlc3QgZGVs
aWJlcmF0ZWx5IGRlbGF5cyB0aGUgb2xkIGNhbGxlciB1bnRpbCBhCnN1Y2Nlc3NvciBwb2xs
IGhhcyByZWFybWVkIGNhbGxiYWNrcyBhbmQgY29tcGxldGVkLiBUaGUgcHJvcG9zZWQgZml4
CnBhc3NlcyB0aGUgc2FtZSB0ZXN0LiAKClRoZSBvcmlnaW5hbCBidWcgcmVwb3J0IGRlc2Ny
aWJlcyB0aGUgc3ltcHRvbXMgYW5kIGNvbXBsZXRpb24gcmFjZToKaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbmV0ZGV2L3RlbmNlbnRfQUE0RjM5REE3QURFMzMwQzcyMUMwM0FBQTgzMkI5
MkRENjA4QHFxLmNvbS8KClRoYW5rcywKQ29uZ2ppZSBaaG91Cg==

