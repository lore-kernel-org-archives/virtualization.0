Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795509867;
	b=RTpY3vhtVdDh3IT63teN8St0i+jplwGSzNGqU2Gy8uEfmeuHTvEqCLZGACxVekrr4303
	 AsWqLT3/zd510lgqdpGfPSmVG6PhAJ/wvOGJPUpd6o3tYUqYukZCuB8NHaHU7ig/8Az8d
	 yj6AQ5sNWgllgKZwD+U1mCZK1uxjVdeiLwpPELyARg+YpN+oEXVFnam8WGlCwXI8ng9gk
	 dww+kXhkNHoSK77CCjsCzM+Q4TNWOfJHSnaFwO9Si75uVx93H86OgZeGWJE+hqqL6amQV
	 b+r7fRa1SED3QqQbCQlbIODcrznrAUwRHeyK1vYuKJVzl65Z/AfPVrv/2dtJY14uCfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795509867;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:X-Priority:
	 X-Mailer:In-Reply-To:References:X-NTES-SC:Content-Transfer-Encoding:
	 Content-Type:MIME-Version:Message-ID:X-Coremail-Locale:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=Xk20DCYaE3oWRw+FuIOMjIvTivy8uTfU+jEz728D46Q=;
	b=Pbe8Ax/fxfHN8ZytLWLOsL8O1SDjHrlT3jBW2AkKLtj3UMDiBKBnXoMvZyDL5KAoOXt0
	 yfZfvl/AxeURLZPlKT2QhNTLlB1Uh80lzLtM/xUbzjU5LXL/sGm3IhG9D3G0MY4lB+DLX
	 p+AzIbn6ySL0zSWWoFpxufSWadK23lJXBI/zeDxLMML7QUuTjiGZ779UJPeE8y74C+2sK
	 f3f76eYyl6yCHXMLd0N6oMgRPzsUVPnlk7ounjO6FDVi4u3u5Qj0onV0wVMO2bwpWqdPi
	 kRxe5yDZ+z+M4i7JUKj85842pQNBe1TgnU6vzHBKhl5itN/ijCKuHWl6SoUAZo80zVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=R99bj9eQ;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FAF606A331
	for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 08:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1FAF606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=R99bj9eQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=Xk20DCYaE3oWRw+FuIOMjIvTivy8uTfU+jEz728D46Q=; b=R
	99bj9eQQ2ezmEUh/iXl7x+SipO48SAfnnIoQp+q6nDTAQ+AC3TVsdVxcqHcQUdo2
	9/e4c2ml/jzLxDgaHEmevGZNxFVleUnxu/IuG/a20CuCEtftQeI0wxE1ULez4UEe
	iqbaw2HlvYf2Ju6rh1fu03B2vEQW2DX6sDNfitiH9Q=
Date: Tue, 24 Nov 2026 16:43:59 +0800 (CST)
From: "Lange Tang" <lange_tang@163.com>
To: "Jiaming Fan" <fan.jiaming@hotmail.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "Jakub Kicinski" <kuba@kernel.org>,
	"Eugenio Perez" <eperezma@redhat.com>,
	"jasowangio@gmail.com" <jasowangio@gmail.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Tang Longjun" <tanglongjun@kylinos.cn>
Subject: Re:Re: [PATCH v2 0/3] virtio_net: introduce an RX queue watchdog
 for stuck detection
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <OS3PR01MB10251CFF97E32B1E7B71D497CE7472@OS3PR01MB10251.jpnprd01.prod.outlook.com>
References: <20261120071826.198604-1-lange_tang@163.com>
 <OS3PR01MB10251CFF97E32B1E7B71D497CE7472@OS3PR01MB10251.jpnprd01.prod.outlook.com>
X-NTES-SC: AL_Qu2SB/mbtkAo7yadZOkfmUgRg+c/XsK4svUj24VVOJF8jCLp+DAKRVFkMFj68MSsEweXrCCTSQJo+MZ4UoV4b7gk0mLu7geXI+pTNs1UqygAJQ==
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
Message-ID: <413a69a4.746a.1a20cb9e72c.Coremail.lange_tang@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:bCgvCgC3vwRPTgVrrdl0AA--.2496W
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC-Q-C8GsFTk9+cAAA3h
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNi0xMS0yMSAxNjoyNzoyNywgIkppYW1pbmcgRmFuIiA8ZmFuLmppYW1pbmdAaG90bWFp
bC5jb20+IHdyb3RlOgo+SGkgTG9uZ2p1biwKPgo+SSBkb24ndCB0aGluayB0aGlzIHJlYXNvbmlu
ZyBob2xkcy4gWW91IHNhdyBhbiBSWCBzdGFsbCwgYnV0IHRoYXQKPmRvZXNuJ3QgbWVhbiBpdCB3
YXMgY2F1c2VkIGJ5IGEgbG9zdCBpbnRlcnJ1cHQuIE1hc2tpbmcgdGhlIGludGVycnVwdAo+aW5q
ZWN0aW9uIG9ubHkgY3JlYXRlcyB0aGUgc2FtZSBzeW1wdG9tLCBpdCBkb2Vzbid0IHJlcHJvZHVj
ZSB3aGF0Cj5oYXBwZW5lZCBpbiBwcm9kdWN0aW9uLgoKQSBsb3N0IGludGVycnVwdCBpcyBlbm91
Z2ggdG8gc3RhbGwgdGhlIFJYIHF1ZXVlLCBhbmQgdGhpcyBjYW4gYmUgc2VlbiAKZnJvbSB0aGUg
Y29kZTogdGhlIHJpbmcgaXMgb25seSBkcmFpbmVkIGZyb20gdGhlIG5vdGlmaWNhdGlvbiBwYXRo
LAp2cmluZ19pbnRlcnJ1cHQoKSAtPiBza2JfcmVjdl9kb25lKCkgLT4gdmlydHF1ZXVlX25hcGlf
c2NoZWR1bGUoKSAtPgp2aXJ0bmV0X3BvbGwoKS4gSWYgdGhhdCBub3RpZmljYXRpb24gaXMgbG9z
dCwgdGhlIHVzZWQgcmluZyBpcyBub3QgZHJhaW5lZCwKYnVmZmVycyBhcmUgbmV2ZXIgcmV0dXJu
ZWQsIHRoZSBkZXZpY2UgcnVucyBvdXQgb2YgZGVzY3JpcHRvcnMgYW5kIHN0b3BzCnB1Ymxpc2hp
bmcsIHNvIG5vIGZ1cnRoZXIgbm90aWZpY2F0aW9uIGNvbWVzLiBUaGUgcXVldWUgc3RheXMgc3R1
Y2suCgo+Cj5NaWNoYWVsIHBvc3RlZCBhIHBhdGNoIGZvciBhIHNpbWlsYXIgUlggc3RhbGwgcmVj
ZW50bHk6Cj5odHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvYWQ3NDg4NmE4NDI5YTg2MmMw
MGQxZTQyZjFkYzc0NmYyOTI0Yjc1Zi4xNzk1MTA4MzQxLmdpdC5tc3RAcmVkaGF0LmNvbS8KPgo+
U28gZGlkIHlvdXIgZ3Vlc3QgaGF2ZSBJUlEgZGVmZXJyYWwgZW5hYmxlZCAobmFwaV9kZWZlcl9o
YXJkX2lycXMgYW5kCj5ncm9fZmx1c2hfdGltZW91dCk/IElmIHNvLCB5b3UgbWF5IGhhdmUgaGl0
IHRoZSByYWNlIE1pY2hhZWwgZml4ZWQuIEl0Cj5zdGFsbHMgdGhlIHF1ZXVlIHRoZSBzYW1lIHdh
eSB3aXRob3V0IGxvc2luZyBhbnkgaW50ZXJydXB0LgoKSSBsb29rZWQgYXQgTWljaGFlbCdzIHBh
dGNoIGFuZCBteSBjYXNlIGRvZXMgbm90IG1hdGNoIGl0OiBhdCB0aGUgdGltZSAKb2YgdGhlIHN0
YWxsIHRoZSBjYWxsYmFja3Mgd2VyZSBlbmFibGVkLCBhbmQgSVJRIGRlZmVycmFsIHdhcyBub3Qg
ZW5hYmxlZAoobmFwaV9kZWZlcl9oYXJkX2lycXMgPSAwLCBncm9fZmx1c2hfdGltZW91dCA9IDAp
Lgo=
