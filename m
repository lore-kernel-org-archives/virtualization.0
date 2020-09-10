Return-Path: <SRS0=1ME9=CT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698D9C43461
	for <virtualization@archiver.kernel.org>; Thu, 10 Sep 2020 13:08:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9755207FB
	for <virtualization@archiver.kernel.org>; Thu, 10 Sep 2020 13:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qInl638Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9755207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 951F3875E9;
	Thu, 10 Sep 2020 13:08:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pstd2FbgQjgb; Thu, 10 Sep 2020 13:08:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EA55E868BB;
	Thu, 10 Sep 2020 13:08:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4280C0052;
	Thu, 10 Sep 2020 13:08:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51D77C0051
 for <virtualization@lists.linuxfoundation.org>;
 Thu, 10 Sep 2020 13:08:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1253D2002F
 for <virtualization@lists.linuxfoundation.org>;
 Thu, 10 Sep 2020 13:08:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2bwTHPqtbSkW
 for <virtualization@lists.linuxfoundation.org>;
 Thu, 10 Sep 2020 13:08:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by silver.osuosl.org (Postfix) with ESMTPS id 96C512000D
 for <virtualization@lists.linuxfoundation.org>;
 Thu, 10 Sep 2020 13:08:08 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id z4so6653789wrr.4
 for <virtualization@lists.linuxfoundation.org>;
 Thu, 10 Sep 2020 06:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=VTVfCEbIpB5fbvLyRQsLgkWOuv0YuyagQSjkPAOupB8=;
 b=qInl638Y3krtYC7g3I1hvGbFr6J7xDslF8+3nIUvB40z3sYcaGbH3sUHqdsWL9p1tm
 Va2Pr+DJrdTcxICI8syUWpGkJesKdONWO/j72KVspp2/z1jlZPPH1s4vbKKTdczoPFbm
 720CXnmYLwxc6byztZmusrdtI3JJMdjIbB/mSxK40umn19TR9EE51wmJ/C71+mpFrOaV
 COWiPIV1veWgsNhWIU962f3i5a5ZIbOt4MYfU2OHVgpILlY8A0yVXP6WGD1JJOfcp5HG
 rRk9xH4Jw5TwaRLGBkK0JvnrHbmskkau3Ti1bR5kuys4KlqBGNQJF240U8kvIVDW26V+
 kgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=VTVfCEbIpB5fbvLyRQsLgkWOuv0YuyagQSjkPAOupB8=;
 b=raHzdISN3v7rewZrxDHLx5BNCNrsXhtqXkcKkeqisEAf1LBCr6qDPZR9CIs4p1I7M3
 Ws9ske/RatUaI32XMdk+8FZMk/wsi0TKwVAg0zCb5GfAEoHBbuD79wU1U3gH0EggJBbE
 Tvc7qxmYPfGSeQ0XvgiTVMcOXnz6vZJvuPFua7g6KWv7Q+C2Uc9AvJJu2enwNS7dYhuO
 Yl+YCHwQ8z53nc8fxwpidPJm9251ItXdF4KcGDtNa1UBjNuv1kJ1ASxL+wR/BSwoqtZv
 5OikB9pqkIJwgB0jmvJHG8Hly2Cs79QCzMCNfgL53nz2FwlfQPUvQSGnaWqhUh0kTf6w
 5Gww==
X-Gm-Message-State: AOAM532YYL9PQO1B5jk5Y65X1AyvXGG376tHXmQgxTe3O/Uwjm+GW/K8
 S1y0mRLw+Nsw8kHSDFZOAkzgsw==
X-Google-Smtp-Source: ABdhPJwkqNEpsVg3x6Cor5K/5Rou/bVuK+QcO5wuaCRfmDSoFTsiRlpV1dUIvc+qsAYcF8PoQmZQSw==
X-Received: by 2002:a5d:6412:: with SMTP id z18mr9008124wru.30.1599743287040; 
 Thu, 10 Sep 2020 06:08:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e18sm10550660wra.36.2020.09.10.06.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 06:08:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6CE3F1FF7E;
 Thu, 10 Sep 2020 14:08:05 +0100 (BST)
References: <87sgct153f.fsf@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: virtio-dev@lists.oasis-open.org, virtualization@lists.linuxfoundation.org
Subject: Re: clarifying the handling of responses for virtio-rpmb
In-reply-to: <87sgct153f.fsf@linaro.org>
Date: Thu, 10 Sep 2020 14:08:05 +0100
Message-ID: <87a6xxpyoa.fsf@linaro.org>
MIME-Version: 1.0
Cc: Tomas Winkler <tomas.winkler@intel.com>, "Michael
 S.Tsirkin" <mst@redhat.com>, "Zhu, Bing" <bing.zhu@intel.com>,
 Yang Huang <yang.huang@intel.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CkFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4gd3JpdGVzOgoKPiBIaSwKPgo+
IFRoZSBzcGVjaWZpY2F0aW9uIGxpc3RzIGEgbnVtYmVyIG9mIGNvbW1hbmRzIHRoYXQgaGF2ZSBy
ZXNwb25zZXM6Cj4KPiAgIFRoZSBvcGVyYXRpb24gb2YgYSB2aXJ0aW8gUlBNQiBkZXZpY2UgaXMg
ZHJpdmVuIGJ5IHRoZSByZXF1ZXN0cyBwbGFjZWQKPiAgIG9uIHRoZSB2aXJ0cXVldWUuIFRoZSB0
eXBlIG9mIHJlcXVlc3QgY2FuIGJlIHByb2dyYW0ga2V5Cj4gICAoVklSVElPX1JQTUJfUkVRX1BS
T0dSQU1fS0VZKSwgZ2V0IHdyaXRlIGNvdW50ZXIKPiAgIChWSVJUSU9fUlBNQl9SRVFfR0VUX1dS
SVRFX0NPVU5URVIpLCB3cml0ZQo+ICAgKFZJUlRJT19SUE1CX1JFUV9EQVRBX1dSSVRFKSwgYW5k
IHJlYWQgKFZJUlRJT19SUE1CX1JFUV9EQVRBX1JFQUQpLiBBCj4gICBwcm9ncmFtIGtleSBvciB3
cml0ZSByZXF1ZXN0IGNhbiBhbHNvIGNvbWJpbmUgd2l0aCBhIHJlc3VsdCByZWFkCj4gICAoVklS
VElPX1JQTUJfUkVRX1JFU1VMVF9SRUFEKSBmb3IgYSByZXR1cm5lZCByZXN1bHQuCj4KPiBOb3cg
SSdtIGRlZXAgaW4gdGhlIGd1dHMgb2YgdmlydCBxdWV1ZXMgZG9pbmcgdGhlIGltcGxlbWVudGF0
aW9uIEknbQo+IHRyeWluZyB0byBjbGFyaWZ5IGV4YWN0bHkgd2hhdCBmcmFtZXMgc2hvdWxkIGJl
IHNlbnQgdG8gdGhlIGRldmljZSBhbmQKPiBpZiB0aGV5IHNob3VsZCBiZSBvdXRfc2dzIG9yIGlu
X3Nncy4gSSBzdXNwZWN0IHRoZXJlIGlzIHNvbWUgZGlmZmVyZW5jZQo+IGJldHdlZW4gdGhlIG9y
aWdpbmFsIHByb3RvdHlwZSBpbnRlcmZhY2UgYW5kIHdoYXQgd2UgaGF2ZSBub3cuCj4KPiBTb21l
IG9wZXJhdGlvbnMgb2J2aW91c2x5IGhhdmUgYW4gaW1wbGllZCByZXNwb25zZQo+IChWSVJUSU9f
UlBNQl9SRVFfR0VUX1dSSVRFX0NPVU5URVIgYW5kIFZJUlRJT19SUE1CX1JFUV9EQVRBX1JFQUQp
LiBBcwo+IGZhciBhcyBJIGNvdWxkIHRlbGwgdGhlIGZyYW1lIHNob3VsZCBiZSBzaW1wbGU6Cj4K
PiAgIHNnWzBdIChvdXRfc2c9MSkgLSBmcmFtZSB3aXRoIGNvbW1hbmQKPiAgIHNnWzEuLm5dIChp
bl9zZz0xLi5uKSAtIHNwYWNlIGZvciB0aGUgcmVwbHkgdG8gYmUgZmlsbGVkIGluIGJ5IHRoZSBk
ZXZpY2UKPgo+IEhvd2V2ZXIgdGhlIGxhbmd1YWdlIGZvciB0aGUgcHJvZ3JhbSBrZXkgYW5kIGRh
dGEgd3JpdGUgc2F5IHRoZXkgY2FuIGJlCj4gY29tYmluZWQgd2l0aCBhIFZJUlRJT19SUE1CX1JF
UV9SRVNVTFRfUkVBRCB0byBvcHRpb25hbGx5IHJldHVybiBhCj4gcmVzdWx0LiBNeSBxdWVzdGlv
biBpcyBpcyB0aGlzIHJlc3VsdCByZWFkIG1lYW50IHRvIGJlIGluIGEgc2VwYXJhdGUKPiByZXF1
ZXN0IGZyYW1lIGFuZCByZXNwb25zZSBmcmFtZSBzbyB5b3UgZ2V0Ogo+Cj4gIHNnWzBdIC0gVklS
VElPX1JQTUJfUkVRX1BST0dSQU1fS0VZL1ZJUlRJT19SUE1CX1JFUV9EQVRBX1dSSVRFIGZyYW1l
Cj4gIHNnWzFdIC0gVklSVElPX1JQTUJfUkVRX1JFU1VMVF9SRUFEIChvdXRfc2c9MikKPiAgc2db
Ml0gLSBlbXB0eSBmcmFtZSBmb3IgcmVzcG9uc2UgKGluX3NnPTEpCj4KPiBvcjoKPgo+ICBzZ1sw
XSAtIFZJUlRJT19SUE1CX1JFUV9QUk9HUkFNX0tFWS9WSVJUSU9fUlBNQl9SRVFfREFUQV9XUklU
RSBmcmFtZSAob3V0X3NnPTEpCj4gIHNnWzFdIC0gVklSVElPX1JQTUJfUkVRX1JFU1VMVF9SRUFE
IChpbl9zZz0xKQo+Cj4gd2hlcmUgdGhlIHJlc3VsdCBmcmFtZSBpcyBmaWxsZWQgaW4gYW5kIHNl
bnQgYmFjaz8KPgo+IEkgbXVzdCBzYXkgSSdtIGEgbGl0dGxlIGNvbmZ1c2VkIGJ5IHRoZSBsb2dp
YyBpbiBycG1iX2lvY3RsIChpbiB0aGUKPiB1c2Vyc3BhY2UgdG9vbCkgd2hpY2ggY3JlYXRlcyBi
b3RoIG91dF9mcmFtZXMgYW5kIHJlc3AgZnJhbWVzOgo+Cj4gICBzdGF0aWMgaW50IHJwbWJfaW9j
dGwodWludDhfdCBmcmFtZV90eXBlLCBpbnQgZmQsIHVpbnQxNl90IHJlcSwKPiAgICAgICAgICAg
ICAgICAgICAgICAgICBjb25zdCB2b2lkICpmcmFtZXNfaW4sIHVuc2lnbmVkIGludCBjbnRfaW4s
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqZnJhbWVzX291dCwgdW5zaWduZWQgaW50
IGNudF9vdXQpCj4gICB7Cj4gICAgICAgICAgIGludCByZXQ7Cj4gICAgICAgICAgIHN0cnVjdCBf
X3BhY2tlZCB7Cj4gICAgICAgICAgICAgICAgICAgc3RydWN0IHJwbWJfaW9jX3NlcV9jbWQgaDsK
PiAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgcnBtYl9pb2NfY21kIGNtZFszXTsKPiAgICAgICAg
ICAgfSBpc2VxID0ge307Cj4KPiAgICAgICAgICAgdm9pZCAqZnJhbWVfcmVzID0gTlVMTDsKPiAg
ICAgICAgICAgaW50IGk7Cj4gICAgICAgICAgIHVpbnQzMl90IGZsYWdzOwo+Cj4gICAgICAgICAg
IHJwbWJfZGJnKCJSUE1CIE9QOiAlc1xuIiwgcnBtYl9vcF9zdHIocmVxKSk7Cj4gICAgICAgICAg
IGRiZ19kdW1wX2ZyYW1lKGZyYW1lX3R5cGUsICJJbiBGcmFtZTogIiwgZnJhbWVzX2luLCBjbnRf
aW4pOwo+Cj4gICAgICAgICAgIGkgPSAwOwo+ICAgICAgICAgICBmbGFncyA9IFJQTUJfRl9XUklU
RTsKPiAgICAgICAgICAgaWYgKHJlcSA9PSBSUE1CX1dSSVRFX0RBVEEgfHwgcmVxID09IFJQTUJf
UFJPR1JBTV9LRVkpCj4gICAgICAgICAgICAgICAgICAgZmxhZ3MgfD0gUlBNQl9GX1JFTF9XUklU
RTsKPiAgICAgICAgICAgcnBtYl9pb2NfY21kX3NldChpc2VxLmNtZFtpXSwgZmxhZ3MsIGZyYW1l
c19pbiwgY250X2luKTsKPiAgICAgICAgICAgaSsrOwo+Cj4gICAgICAgICAgIGlmIChyZXEgPT0g
UlBNQl9XUklURV9EQVRBIHx8IHJlcSA9PSBSUE1CX1BST0dSQU1fS0VZKSB7Cj4gICAgICAgICAg
ICAgICAgICAgZnJhbWVfcmVzID0gcnBtYl9mcmFtZV9hbGxvYyhmcmFtZV90eXBlLCAwKTsKPiAg
ICAgICAgICAgICAgICAgICBpZiAoIWZyYW1lX3JlcykKPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHJldHVybiAtRU5PTUVNOwo+ICAgICAgICAgICAgICAgICAgIHJwbWJfZnJhbWVfc2V0KGZy
YW1lX3R5cGUsIGZyYW1lX3JlcywKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBS
UE1CX1JFU1VMVF9SRUFELCAwLCAwLCAwKTsKPiAgICAgICAgICAgICAgICAgICBycG1iX2lvY19j
bWRfc2V0KGlzZXEuY21kW2ldLCBSUE1CX0ZfV1JJVEUsIGZyYW1lX3JlcywgMCk7Cj4gICAgICAg
ICAgICAgICAgICAgaSsrOwo+ICAgICAgICAgICB9Cj4KPiAgICAgICAgICAgcnBtYl9pb2NfY21k
X3NldChpc2VxLmNtZFtpXSwgMCwgZnJhbWVzX291dCwgY250X291dCk7Cj4gICAgICAgICAgIGkr
KzsKPgo+ICAgICAgICAgICBpc2VxLmgubnVtX29mX2NtZHMgPSBpOwo+ICAgICAgICAgICByZXQg
PSBpb2N0bChmZCwgUlBNQl9JT0NfU0VRX0NNRCwgJmlzZXEpOwo+ICAgICAgICAgICBpZiAocmV0
IDwgMCkKPiAgICAgICAgICAgICAgICAgICBycG1iX2VycigiaW9jdGwgZmFpbHVyZSAlZDogJXMu
XG4iLCByZXQsIHN0cmVycm9yKGVycm5vKSk7Cj4KPiAgICAgICAgICAgcmV0ID0gcnBtYl9jaGVj
a19yZXFfcmVzcChmcmFtZV90eXBlLCByZXEsIGZyYW1lc19vdXQpOwo+Cj4gICAgICAgICAgIGRi
Z19kdW1wX2ZyYW1lKGZyYW1lX3R5cGUsICJSZXMgRnJhbWU6ICIsIGZyYW1lX3JlcywgMSk7Cj4g
ICAgICAgICAgIGRiZ19kdW1wX2ZyYW1lKGZyYW1lX3R5cGUsICJPdXQgRnJhbWU6ICIsIGZyYW1l
c19vdXQsIGNudF9vdXQpOwo+ICAgICAgICAgICBmcmVlKGZyYW1lX3Jlcyk7Cj4gICAgICAgICAg
IHJldHVybiByZXQ7Cj4gICB9Cj4KPiBhbHRob3VnaCBJJ20gZ3Vlc3NpbmcgdGhpcyBtaWdodCBq
dXN0IGJlIGFuIGltcGVkYW5jZSBiZXR3ZWVuIHRoZQo+IGNoYXJkZXYgaW9jdGwgaW50ZXJmYWNl
IGZvciBycG1iIGFuZCB0aGUgdmlydGlvIEZFIGRyaXZlciB3aGljaCBpcyBvbmx5Cj4gb25lIHBv
dGVudGlhbCBjb25zdW1lciBvZiB0aGVzZSBycG1iIGlvYyBjb21tYW5kcz8gCj4KPiBDYW4gYW55
b25lIGNsYXJpZnk/CgpQaW5nPwoKLS0gCkFsZXggQmVubsOpZQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
