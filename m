Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.111.35.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355874;
	b=DVee2IJT46lj2uWa2/KtVploum7G3DqxcYCv2APLxCEb+AR3rmvSvkIb6WXLtLIH54WE
	 iFxFK3l7xXD2whZIhnQyDUkyFyo4jvPsOV4+ZX40S9wzmLoRCHaB3JnB+1YcoKeLa5+0t
	 6w6+TtvCaCi7iQkqwcDTSEy4aDAercRnqOq0dhWkQayruwp6tR6q3uqUlHw6+y4eTmhwq
	 8Gz9aLBQ5tfNabvF7VP9qJpitGKyYFSFzYQ9obmhIXoJ15EBNWHhXp2NvRxyhDD66G30F
	 HbBykBbxqBJ76A5/1i2OAhtwxT5Br061swc+QR+qFSCNKaGVVjDhCRk83vdwNCWblzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355874;
	h=DMARC-Filter:X-Originating-IP:X-Works-Smtp-Source:Received:
	 DKIM-Signature:X-Session-ID:MIME-Version:Message-ID:Date:From:
	 In-Reply-To:References:Importance:To:Cc:Subject:X-Originating-IP:
	 X-Works-Send-Opt:Content-Type:Content-Transfer-Encoding;
	bh=66m7ZBHAd5MCUYL+NObH+dSeUwaoKEwcjZoMx+AWcMw=;
	b=ZlS6PJlP8+FWjGS6RzHK9FYnEHsK62FnXyxDWwj1q9Ev/jnA/cSVkS+3cVFnsawn/5mB
	 sziYgkCWkCRay5EwAzZfTRNojWVbb6Q/N712UNHQORnpSope5V4gC2JFQF0iyythUk1KF
	 glHmIdam7sSH+KVLrIMGH/eOu9604KU9hz4r3lYIr998heFGgu5kvw3V1YFVBSuzZRICl
	 Bq+1rfdoSRPzYC7JKhVJj4uL23praJ05b6g7tFkYsKZWfJNzZpnmE/4cDdJtCeoaM2PQe
	 yjz4gHClMb9wur85WXCASiBb7/TbKqyzKIEr5XLHQOTzobQnT0ECrmajziN+POIKKHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=naver.com;
	spf=pass smtp.mailfrom=naver.com;
	dkim=pass header.d=naver.com header.i=@naver.com header.a=rsa-sha256 header.s=s20171208 header.b="wNuYm/Qn";
	arc=none smtp.remote-ip=114.111.35.233
Received: from cvsmtppost16.nm.naver.com (cvsmtppost16.nm.naver.com [114.111.35.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3A0606A320
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 00:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB3A0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=naver.com header.i=@naver.com header.a=rsa-sha256 header.s=s20171208 header.b=wNuYm/Qn
X-Works-Smtp-Source: PrnZKqtlFqJCpNmrFotqWHF0
Received: from nv1s-hmac-real-11 ([10.180.31.91])
  by cvsmtppost16.nm.naver.com with ESMTP id A0PYaXLUSSyvyalMg1qzsQ
  for <multiple recipients>;
  Wed, 11 Nov 2026 00:11:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1794355866; bh=66m7ZBHAd5MCUYL+NObH+dSeUwaoKEwcjZoMx+AWcMw=;
	h=Message-ID:Date:From:To:Subject:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=wNuYm/QntdXDQqeWtI9A5azkmONYJ6wl+8OeH64gqDcTvpOojjkwNqCMNp1fbEPOF
	 dEP3JkTIoYzie/exp1M483gDP5Fq6y/hrEmZyFxkFNEADYqdx2KYUQr4UyQx+jlABJ
	 Sc7CD7mayItIGYGui8muwbtlQCRIte0pSt63nRE2RMcvEzIZ4BlpWo0azpQ5b7H3t2
	 qsS6ggPXXkDGlu250S6DQ7E36RSl4d2eawp7AnbC8n91gGDVt3u8eGv0YUheViosg/
	 ZYzw3BD7asvSq7bsdEOKcYaLIkfMNbK7iYk/Ll4ZMmDv9emNfvWsMEduyslcWAnedA
	 IGOTrn2HE5dMA==
X-Session-ID: 42f67c1586dde36270c192f6b2c1d0e2b43e502752c06cf0562d77cf14dd97c5
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Message-ID: <f439b7997e31bf938812e27bb02a2762@cweb013.nm>
Date: Wed, 11 Nov 2026 09:11:05 +0900
From: =?utf-8?B?7J6E7ISx7ZiE?= <forfortuna@naver.com>
In-Reply-To: <20261110122457-mutt-send-email-mst@kernel.org>
References: <20261111-virtio-can-ready-v1-1-0b4dd020af0b@naver.com>
	<20261110122457-mutt-send-email-mst@kernel.org>
Importance: normal
To: =?utf-8?B?TWljaGFlbCBTLiBUc2lya2lu?= <mst@redhat.com>
Cc: =?utf-8?B?SGFyYWxkIE1vbW1lcg==?= <harald.mommer@oss.qualcomm.com>,
	=?utf-8?B?TWF0aWFzIEV6ZXF1aWVsIFZhcmEgTGFyc2Vu?= <mvaralar@redhat.com>,
	=?utf-8?B?TWFyYyBLbGVpbmUtQnVkZGU=?= <mkl@pengutronix.de>,
	=?utf-8?B?VmluY2VudCBNYWlsaG9s?= <mailhol@kernel.org>,
	=?utf-8?B?TWlraGFpbCBHb2x1YmV2LUNpdWNoZWE=?= <mikhail.golubev-ciuchea@oss.qualcomm.com>,
	=?utf-8?B?RnJhbmNlc2NvIFZhbGxh?= <francesco@valla.it>,
	<virtualization@lists.linux.dev>,
	<linux-can@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	=?utf-8?B?SmFzb24gV2FuZw==?= <jasowangio@gmail.com>
Subject: =?utf-8?B?UmU6IFtQQVRDSF0gY2FuOiB2aXJ0aW86IGZpeCB2aXJ0cXVldWUgdXNlIGJlZm9yZSBEUg==?=
	=?utf-8?B?SVZFUl9PSw==?=
X-Works-Send-Opt: 0r+4b4e4jHwYM6l9+HiTKHmwKBmwFovXFxEqaA2ZjJkaBd9YKBmm
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64

T24gVHVlLCBOb3YgMTAsIDIwMjYgYXQgMTI6MjY6Li4uLCBNaWNoYWVsIFMuIFRzaXJraW4gd3Jv
dGU6Cj4gaG93ZXZlciwgZGV2aWNlIHJlYWR5IG1lYW5zIHlvdSBjYW4gZ2V0IGNhbGxiYWNrczog
Y29uZmlnCj4gYW5kIHZxLgo+Cj4gZGlkIHlvdSBhdWRpdCB0aGUgZHJpdmVyIHRvIG1ha2Ugc3Vy
ZSB0aGlzIGlzIHNhZmUgd2hpbGUKPiBwcm9iZSBkaWQgbm90IHlldCBwb3B1bGF0ZSBhbmQgcmVn
aXN0ZXIgdGhlIGRldmljZT8KClRoYW5rcyBmb3IgdGhlIHJldmlldy4KCkNvbmZpZyBjYWxsYmFj
a3MgYXJlIGZpbmU6IGNvbmZpZ19jb3JlX2VuYWJsZWQgc3RheXMgZmFsc2UgdW50aWwKcHJvYmUv
cmVzdG9yZSByZXR1cm5zLCBzbyBhIGNvbmZpZyBjaGFuZ2UgaXMgZGVmZXJyZWQgdW50aWwgdGhl
bi4KCkZvciB2cSBjYWxsYmFja3MsIHRoZXJlIGlzIGEgcmVhbCBwcm9ibGVtLCBhbHNvIHJlcG9y
dGVkIGJ5CnNhc2hpa28tYm90OiBhbiBSWC9UWCBpbnRlcnJ1cHQgdGhhdCBhcnJpdmVzIGJlZm9y
ZQp2aXJ0aW9fY2FuX25hcGlfZW5hYmxlKCkgaW4gdmlydGlvX2Nhbl9vcGVuKCkgY2FsbHMKdmly
dHF1ZXVlX2Rpc2FibGVfY2IoKSB3aGlsZSBOQVBJIGlzIHN0aWxsIGRpc2FibGVkLCBzbyB0aGUg
cXVldWUKc3RhbGxzLiBUaGlzIGFscmVhZHkgZXhpc3RzIGluIHRoZSBvcGVuIHBhdGgsIGJ1dCB3
aXRoIHRoaXMgcGF0Y2gKcmVzdG9yZSBjYW4gbm93IHJlYWNoIGl0LgoKSSB3aWxsIGZpeCB0aGF0
IGZpcnN0IGluIGEgc2VwYXJhdGUgcGF0Y2ggYW5kIHNlbmQgdjIgYXMgYQp0d28tcGF0Y2ggc2Vy
aWVzLgoKVGhhbmtzLApTZW9uZ2h5ZW9u
