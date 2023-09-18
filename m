Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5317CD37B0
	for <virtualization@archiver.kernel.org>; Mon, 18 Sep 2023 08:46:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 74EEC81F8A;
	Mon, 18 Sep 2023 08:46:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 74EEC81F8A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZXOrTBQA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nYr9tWe1IMym; Mon, 18 Sep 2023 08:46:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CED19818E6;
	Mon, 18 Sep 2023 08:46:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CED19818E6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F973C0039;
	Mon, 18 Sep 2023 08:46:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E72F2C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 08:46:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B9C314057C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 08:46:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B9C314057C
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZXOrTBQA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f21KvCmHEnFz
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 08:46:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EF97F40201
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 08:46:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EF97F40201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695026793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ne/6wvHEM171/1YnTSavkevXbhaVIZD2o3rmnI4AXAc=;
 b=ZXOrTBQAWjvwkFi/N+5l5GF1SbzicRXC/navZYSMJOoC11BRzzFr7kULeOHQX6mJked4yz
 rE1jkJ2tDvEXtFADSZlcmIeChZ0mGLihAA+8vZPwxIBdkMBqCPh22Khcdkh+XVEkaewBZB
 l0EpjvrpiSiLdvhFxOkuUp3NYN/Ezb0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-a4bHPK3UNQ2MpOp4QsaO7g-1; Mon, 18 Sep 2023 04:46:31 -0400
X-MC-Unique: a4bHPK3UNQ2MpOp4QsaO7g-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5009121067cso4886075e87.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 01:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695026789; x=1695631589;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ne/6wvHEM171/1YnTSavkevXbhaVIZD2o3rmnI4AXAc=;
 b=v8UV2cES1bOVsf4C7QFRbJ0Tr+ZBaSD+2IYlV3n9JDGw+Gco+ohz8nh/EOKeN3ZVao
 eK50S6qq+bm0TPaL1nfDrwiWaN2x6ijrlTkqmaoq/Ea0P50a2Rt3dTPBJQrZN4tDjAXX
 rg915/vv8SYPRTRUyYm17tHsV2pGf104gvuyA5yCCFdOBAYfwdsKhxmj20H1/49xBecZ
 oGGS49bzyCs16xqA3dHVaxtudZ8XLUCbhVPQwm2A9v8uLpzxR6ZZEQUHhmquFUsop21U
 7QGojgRsj3ZzheKGk9Z3To0D4jjtU354PyA3ASiGOW2sKm3oP3Rjfqk1p+k7wYsb6chx
 ZX+g==
X-Gm-Message-State: AOJu0YyXPzMnQWTbKaz8cUIxayT9I/HFFxGDBxzG1O07Txde+i8uuOGP
 VCfR0qsN0jbp1/WEZ1ZiewOgjE26kKGKu0wYn0xOO/LqIWK54JQNJ7p/84d8VwAZ08dAB/CRXOX
 L/I41fhO1rHkWx3OqA6C0GffPFx/ZirhZLmyErO0RDZow45eGFOYT4bKQ3A==
X-Received: by 2002:a05:6512:3d27:b0:503:5d8:da33 with SMTP id
 d39-20020a0565123d2700b0050305d8da33mr5511661lfv.20.1695026789532; 
 Mon, 18 Sep 2023 01:46:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgMCrTK06HsA1jmrN2m8hmh2JeHg5MHIGzt2YqOFrbMXyCjP3e56ikeAOpp3+Aew9hlguYd0zxzDgNAWMVZ90=
X-Received: by 2002:a05:6512:3d27:b0:503:5d8:da33 with SMTP id
 d39-20020a0565123d2700b0050305d8da33mr5511649lfv.20.1695026789253; Mon, 18
 Sep 2023 01:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230912030008.3599514-1-lulu@redhat.com>
 <20230912030008.3599514-3-lulu@redhat.com>
In-Reply-To: <20230912030008.3599514-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 18 Sep 2023 16:46:18 +0800
Message-ID: <CACGkMEuOYWYYGta5VoZaURVxrBFwU+1aNwoh7RyT1woQCNHJtg@mail.gmail.com>
Subject: Re: [RFC v2 2/4] vduse: Add file operation for mmap
To: Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 maxime.coquelin@redhat.com
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

T24gVHVlLCBTZXAgMTIsIDIwMjMgYXQgMTE6MDDigK9BTSBDaW5keSBMdSA8bHVsdUByZWRoYXQu
Y29tPiB3cm90ZToKPgo+IEFkZCB0aGUgb3BlcmF0aW9uIGZvciBtbWFwLCBUaGUgdXNlciBzcGFj
ZSBBUFAgd2lsbAo+IHVzZSB0aGlzIGZ1bmN0aW9uIHRvIG1hcCB0aGUgcGFnZXMgdG8gdXNlcnNw
YWNlCj4KPiBTaWduZWQtb2ZmLWJ5OiBDaW5keSBMdSA8bHVsdUByZWRoYXQuY29tPgo+IC0tLQo+
ICBkcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jIHwgNjMgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCA2MyBpbnNlcnRpb25zKCspCj4KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYyBiL2RyaXZlcnMv
dmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMKPiBpbmRleCA0YzI1NmZhMzFmYzQuLjJjNjlmNDAw
NGE2ZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jCj4g
KysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYwo+IEBAIC0xMzg4LDYgKzEz
ODgsNjcgQEAgc3RhdGljIHN0cnVjdCB2ZHVzZV9kZXYgKnZkdXNlX2Rldl9nZXRfZnJvbV9taW5v
cihpbnQgbWlub3IpCj4gICAgICAgICByZXR1cm4gZGV2Owo+ICB9Cj4KPiArc3RhdGljIHZtX2Zh
dWx0X3QgdmR1c2Vfdm1fZmF1bHQoc3RydWN0IHZtX2ZhdWx0ICp2bWYpCj4gK3sKPiArICAgICAg
IHN0cnVjdCB2ZHVzZV9kZXYgKmRldiA9IHZtZi0+dm1hLT52bV9maWxlLT5wcml2YXRlX2RhdGE7
Cj4gKyAgICAgICBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSA9IHZtZi0+dm1hOwo+ICsgICAg
ICAgdTE2IGluZGV4ID0gdm1hLT52bV9wZ29mZjsKPiArICAgICAgIHN0cnVjdCB2ZHVzZV92aXJ0
cXVldWUgKnZxOwo+ICsgICAgICAgc3RydWN0IHZkcGFfcmVjb25uZWN0X2luZm8gKmluZm87Cj4g
Kwo+ICsgICAgICAgaWYgKGluZGV4ID09IDApIHsKPiArICAgICAgICAgICAgICAgaW5mbyA9ICZk
ZXYtPnJlY29ubmVjdF9zdGF0dXM7Cj4gKyAgICAgICB9IGVsc2Ugewo+ICsgICAgICAgICAgICAg
ICB2cSA9ICZkZXYtPnZxc1tpbmRleCAtIDFdOwo+ICsgICAgICAgICAgICAgICBpbmZvID0gJnZx
LT5yZWNvbm5lY3RfaW5mbzsKPiArICAgICAgIH0KPiArICAgICAgIHZtYS0+dm1fcGFnZV9wcm90
ID0gcGdwcm90X25vbmNhY2hlZCh2bWEtPnZtX3BhZ2VfcHJvdCk7Cj4gKyAgICAgICBpZiAocmVt
YXBfcGZuX3JhbmdlKHZtYSwgdm1mLT5hZGRyZXNzICYgUEFHRV9NQVNLLCBQRk5fRE9XTihpbmZv
LT5hZGRyKSwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgUEFHRV9TSVpFLCB2bWEtPnZt
X3BhZ2VfcHJvdCkpCj4gKyAgICAgICAgICAgICAgIHJldHVybiBWTV9GQVVMVF9TSUdCVVM7Cj4g
KyAgICAgICByZXR1cm4gVk1fRkFVTFRfTk9QQUdFOwo+ICt9Cj4gKwo+ICtzdGF0aWMgY29uc3Qg
c3RydWN0IHZtX29wZXJhdGlvbnNfc3RydWN0IHZkdXNlX3ZtX29wcyA9IHsKPiArICAgICAgIC5m
YXVsdCA9IHZkdXNlX3ZtX2ZhdWx0LAo+ICt9Owo+ICsKPiArc3RhdGljIGludCB2ZHVzZV9kZXZf
bW1hcChzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEpCj4gK3sK
PiArICAgICAgIHN0cnVjdCB2ZHVzZV9kZXYgKmRldiA9IGZpbGUtPnByaXZhdGVfZGF0YTsKPiAr
ICAgICAgIHN0cnVjdCB2ZHBhX3JlY29ubmVjdF9pbmZvICppbmZvOwo+ICsgICAgICAgdW5zaWdu
ZWQgbG9uZyBpbmRleCA9IHZtYS0+dm1fcGdvZmY7Cj4gKyAgICAgICBzdHJ1Y3QgdmR1c2Vfdmly
dHF1ZXVlICp2cTsKPiArCj4gKyAgICAgICBpZiAodm1hLT52bV9lbmQgLSB2bWEtPnZtX3N0YXJ0
ICE9IFBBR0VfU0laRSkKPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4gKyAgICAg
ICBpZiAoKHZtYS0+dm1fZmxhZ3MgJiBWTV9TSEFSRUQpID09IDApCj4gKyAgICAgICAgICAgICAg
IHJldHVybiAtRUlOVkFMOwo+ICsKPiArICAgICAgIGlmIChpbmRleCA+IDY1NTM1KQo+ICsgICAg
ICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPiArCj4gKyAgICAgICBpZiAoaW5kZXggPT0gMCkg
ewo+ICsgICAgICAgICAgICAgICBpbmZvID0gJmRldi0+cmVjb25uZWN0X3N0YXR1czsKPiArICAg
ICAgIH0gZWxzZSB7Cj4gKyAgICAgICAgICAgICAgIHZxID0gJmRldi0+dnFzW2luZGV4IC0gMV07
Cj4gKyAgICAgICAgICAgICAgIGluZm8gPSAmdnEtPnJlY29ubmVjdF9pbmZvOwo+ICsgICAgICAg
fQo+ICsKPiArICAgICAgIGlmIChpbmZvLT5pbmRleCAhPSBpbmRleCkKPiArICAgICAgICAgICAg
ICAgcmV0dXJuIC1FSU5WQUw7CgpVbmRlciB3aGljaCBjYXNlIGNvdWxkIHdlIG1lZXQgdGhpcz8K
Cj4gKwo+ICsgICAgICAgaWYgKGluZm8tPmFkZHIgJiAoUEFHRV9TSVpFIC0gMSkpCj4gKyAgICAg
ICAgICAgICAgIHJldHVybiAtRUlOVkFMOwoKQW5kIHRoaXM/Cgo+ICsgICAgICAgaWYgKHZtYS0+
dm1fZW5kIC0gdm1hLT52bV9zdGFydCAhPSBpbmZvLT5zaXplKQo+ICsgICAgICAgICAgICAgICBy
ZXR1cm4gLUVPUE5PVFNVUFA7Cj4gKwo+ICsgICAgICAgdm1fZmxhZ3Nfc2V0KHZtYSwgVk1fSU8g
fCBWTV9QRk5NQVAgfCBWTV9ET05URFVNUCk7CgpXaHkgZG8geW91IHVzZSBWTV9JTywgVk1fUEZO
TUFQIGFuZCBWTV9ET05URFVNUD8KClRoYW5rcwoKPiArICAgICAgIHZtYS0+dm1fb3BzID0gJnZk
dXNlX3ZtX29wczsKPiArCj4gKyAgICAgICByZXR1cm4gMDsKPiArfQo+ICsKPiAgc3RhdGljIGlu
dCB2ZHVzZV9kZXZfb3BlbihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlsZSkK
PiAgewo+ICAgICAgICAgaW50IHJldDsKPiBAQCAtMTQyMCw2ICsxNDgxLDggQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgdmR1c2VfZGV2X2ZvcHMgPSB7Cj4gICAgICAgICAu
dW5sb2NrZWRfaW9jdGwgPSB2ZHVzZV9kZXZfaW9jdGwsCj4gICAgICAgICAuY29tcGF0X2lvY3Rs
ICAgPSBjb21wYXRfcHRyX2lvY3RsLAo+ICAgICAgICAgLmxsc2VlayAgICAgICAgID0gbm9vcF9s
bHNlZWssCj4gKyAgICAgICAubW1hcCAgICAgICAgICAgPSB2ZHVzZV9kZXZfbW1hcCwKPiArCj4g
IH07Cj4KPiAgc3RhdGljIHN0cnVjdCB2ZHVzZV9kZXYgKnZkdXNlX2Rldl9jcmVhdGUodm9pZCkK
PiAtLQo+IDIuMzQuMwo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
