Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17622AEE4
	for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 03:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764300327; cv=none; b=d/E/VFclFqsx1p68Ycq1y3xrxg+PpQlNv+0hnE8QV1rxaWw26JuNeEHTYWDsv0LE5IboDQh6+iGWDqjJDEJ8MsAc1smBpJk0SVarVz9nPeAmDWwy+0hglByawLp0oTzaAqI61mRL98wVWH6CYv+72a2ba2EXfQO+efrHVU0xmns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764300327; c=relaxed/simple;
	bh=3Rr754dw5Ec63TZdWk1aPwAPgkPpi/Cm5uiYDYT2SP8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=pddSXvYdYk4gSvU3vAbO4iZETipG12vOXXTrFMi/+MM/WTRkDzZel5JA0Jn/iujRplfFCN+mbObGTui6uODBjrgJsEA4Qf0Redo5REDUqLQ570mhsA6geO+xGh2JFDVgTRmW6wL9A6HKYjiB+f4Ar7KCvBiExDcv30wSrU66gAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LW9IIfLb; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LW9IIfLb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=3Rr754dw5Ec63TZdWk1aPwAPgkPpi/Cm5uiYDYT2SP8=; b=L
	W9IIfLbDh4R36FQY2XI63F4nhuwEmV7ADP1kuGIiJpCoRMZ64Zyx0K+O7Il0J9rO
	ucdkj/Xq92DCg4o1ycEdIyJN6WBe2B4Lni4tM6ZhmR5htMxXnb7qy1XVTfvcnymu
	HIwnx/xxEuOp9U/8QCbj53NiCu3hKl1SiLMD+KGtr4=
Received: from lange_tang$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-140 (Coremail) ; Fri, 28 Nov 2025 11:25:09 +0800
 (CST)
Date: Fri, 28 Nov 2025 11:25:09 +0800 (CST)
From: "Lange Tang" <lange_tang@163.com>
To: "jasowang@redhat.com" <jasowang@redhat.com>
Cc: "mst@redhat.com" <mst@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"Tang Longjun" <tanglongjun@kylinos.cn>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Subject: Re:Re: [PATCH v1 3/7] tools/virtio/virtnet_mon: add kprobe
 start_xmit
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <CACGkMEv7szm0oYXZGPcRjdV8jOCzm9JYWttCeeCtA7pea5vA7w@mail.gmail.com>
References: <20251127032407.33475-1-lange_tang@163.com>
 <20251127032407.33475-4-lange_tang@163.com>
 <CACGkMEv7szm0oYXZGPcRjdV8jOCzm9JYWttCeeCtA7pea5vA7w@mail.gmail.com>
X-NTES-SC: AL_Qu2dBv+bv0sr7yiYZukfmUgRg+c/XsK4svUj24VVOJF8jB/o2QsAW0V5E2LqwOmRBxCgtzKMcT5r9815doN7ULAVzlEExCVTtO7zQrajd7KWlQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <93c506b.34df.19ac87e4538.Coremail.lange_tang@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:jCgvCgD3X4YWFilpE6MsAA--.3977W
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbBdhIULmkpAYCcqgACsr
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

VGhhbmsgeW91IGZvciB5b3VyIHJlcGx5LiAKCkluZGVlZCwgdGhlcmUgYXJlIHJlcGVhdGVkIHJl
ZmVyZW5jZXMgdG8gc29tZSBzdHJ1Y3R1cmVzIGRlZmluZWQgCmluIHZpcnRpb19uZXQgdGhhdCBh
cmUgbm90IHByZXNlbnQgaW4gYW55IGhlYWRlciBmaWxlcywgc3VjaCBhcyB2aXJ0bmV0X2luZm8s
IHZyaW5nX3ZpcnRxdWV1ZSwgZXRjLiAKSG93ZXZlciwgdGhlIHZpcnRuZXRfbW9uIG1vZHVsZSBy
ZXF1aXJlcyB0aGUgbGF5b3V0cyBvZiB0aGVzZSBzdHJ1Y3R1cmVzIHRvIGJlIGFibGUgdG8gdHJh
Y2sgdGhlaXIgbWVtYmVycy4KCgrlnKggMjAyNS0xMS0yOCAxMDoyMToyOe+8jCJKYXNvbiBXYW5n
IiA8amFzb3dhbmdAcmVkaGF0LmNvbT4g5YaZ6YGT77yaCj5PbiBUaHUsIE5vdiAyNywgMjAyNSBh
dCAxMTozM+KAr0FNIExvbmdqdW4gVGFuZyA8bGFuZ2VfdGFuZ0AxNjMuY29tPiB3cm90ZToKPj4K
Pj4gRnJvbTogVGFuZyBMb25nanVuIDx0YW5nbG9uZ2p1bkBreWxpbm9zLmNuPgo+Pgo+PiB0cmFj
ayBza2IgYW5kIHZpcnRxdWV1ZSB0aHJvdWdoIHRoZSBrcHJvYmUgc3RhcnRfeG1pdCBmdW5jdGlv
bgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBUYW5nIExvbmdqdW4gPHRhbmdsb25nanVuQGt5bGlub3Mu
Y24+Cj4+IC0tCj4KPkNhbiB5b3UgZXhwbGFpbiB3aGF0J3MgdGhlIHVzZSBjYXNlIGZvciB0aGlz
IG9yIHdoeSB3ZSBuZWVkIHRvCj5kdXBsaWNhdGUgdmlydGlvLW5ldCBkcml2ZXIgY29kZXMgaGVy
ZT8KPgo+VGhhbmtzCg==
