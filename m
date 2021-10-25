Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCD3C433EF
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 04:45:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB18B60F4F
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 04:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DB18B60F4F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94D5540387;
	Mon, 25 Oct 2021 04:45:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BRwMa5CQdTYY; Mon, 25 Oct 2021 04:45:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2BA9B40384;
	Mon, 25 Oct 2021 04:45:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00E0FC0012;
	Mon, 25 Oct 2021 04:45:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47EAFC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 04:45:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2324640387
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 04:45:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zqv8m7a0IgFz
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 04:45:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6085240384
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 04:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635137152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F6OUU63iz+cJPE/D1JS5ge1TKoVjiL2+e3CLUbXWt4I=;
 b=bISaQC7WigCg7AlhGQPe/XicYlHiknpEMuGrsHYM41iCV7vPof09lno85pGFTMsj1A2ju/
 nSglsUAqjf8YwrvogpHxKT0d4cQPmSQc386Spgd9bbG264I8NZVxdFfCJFg8sLTemBHPyf
 Asarcr+kHfnKLEx3Jd9x3oPPgWp1G/w=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-EXUa4mvEOK-oz4jn5VgnsA-1; Mon, 25 Oct 2021 00:45:50 -0400
X-MC-Unique: EXUa4mvEOK-oz4jn5VgnsA-1
Received: by mail-pf1-f200.google.com with SMTP id
 4-20020a621604000000b0047bce81cc51so2932508pfw.20
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 21:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:cc:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=F6OUU63iz+cJPE/D1JS5ge1TKoVjiL2+e3CLUbXWt4I=;
 b=ib3o3yEXJPilP0mQB0XUlHK9VUuCIAP1+Zb3d6C9scR30c3w10F/GVuEwO/DmXorL3
 sJ4FZg5tLw8PtbNHcVk490UMxCXWVjvFmgDhDh+qCriNk+AlOU6NG4HIG/hY9YYNGnPy
 xZSisVwLF4KZH8GgWQMiDy5HxowDX+5zp1X+QJw+LAqgw+a8lqOdLB5wSVnqA14cV0Wk
 xfBxiV5FBEYLPjHZQLf+scnNEiIq49UhArkzz6QlmiiWM8MMO26pk7XsxQsKjdfSHq+G
 rvx9c7LAUWwse17eBJ0ilVJMij4l6UoLsYXWhqAtErqyKAo7E9VjQ3/mxcSNlElZQIWu
 v1ew==
X-Gm-Message-State: AOAM532lapKNIoCgg+VbfqxsIr11AnNeDsH9jxCEOWIjU9qyuSpIstc7
 IAmHf1zpeIddXxwtwGlrFV4DGFY4gWJAsl3V4lWADmUomnJgZ77hqGpiUC0eG3t/qRDbEEHQSBy
 kAjNHh+yZzLx+GonQsmKy4aKh0HjQ2NBBlWpnCL+ifQ==
X-Received: by 2002:a05:6a00:234f:b0:3eb:3ffd:6da2 with SMTP id
 j15-20020a056a00234f00b003eb3ffd6da2mr15535554pfj.15.1635137149708; 
 Sun, 24 Oct 2021 21:45:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLB72PqNSdfJrX+247H6/uoN4JrbLXebefRT3rHVi8UXZS/3aQKoa93b8u7w4Ov85ugoXGmg==
X-Received: by 2002:a05:6a00:234f:b0:3eb:3ffd:6da2 with SMTP id
 j15-20020a056a00234f00b003eb3ffd6da2mr15535530pfj.15.1635137149307; 
 Sun, 24 Oct 2021 21:45:49 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id l6sm7186243pfc.126.2021.10.24.21.45.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Oct 2021 21:45:48 -0700 (PDT)
Subject: Re: [PATCH v6 6/8] virtio_vdpa: setup correct vq size with callbacks
 get_vq_num_{max,min}
To: Wu Zongyong <wuzongyong@linux.alibaba.com>
References: <cover.1634281805.git.wuzongyong@linux.alibaba.com>
 <cover.1634870456.git.wuzongyong@linux.alibaba.com>
 <c75b4499f7ead922daa19bf67b32eed6f185d260.1634870456.git.wuzongyong@linux.alibaba.com>
 <CACGkMEtNECAUtpEvLvEpTFKfbYRC7YQKnHDnjxR3k9Hap1tmig@mail.gmail.com>
 <20211025024403.GA3684@L-PF27918B-1352.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <bfb2875b-0da1-27e8-829b-f6b61ea6e326@redhat.com>
Date: Mon, 25 Oct 2021 12:45:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211025024403.GA3684@L-PF27918B-1352.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: wei.yang1@linux.alibaba.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvMTAvMjUgyc/O5zEwOjQ0LCBXdSBab25neW9uZyDQtLXAOgo+IE9uIE1vbiwgT2N0
IDI1LCAyMDIxIGF0IDEwOjIyOjMwQU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+IE9uIEZy
aSwgT2N0IDIyLCAyMDIxIGF0IDEwOjQ1IEFNIFd1IFpvbmd5b25nCj4+IDx3dXpvbmd5b25nQGxp
bnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPj4+IEZvciB0aGUgZGV2aWNlcyB3aGljaCBpbXBsZW1l
bnQgdGhlIGdldF92cV9udW1fbWluIGNhbGxiYWNrLCB0aGUgZHJpdmVyCj4+PiBzaG91bGQgbm90
IG5lZ290aWF0ZSB3aXRoIHZpcnRxdWV1ZSBzaXplIHdpdGggdGhlIGJhY2tlbmQgdmRwYSBkZXZp
Y2UgaWYKPj4+IHRoZSB2YWx1ZSByZXR1cm5lZCBieSBnZXRfdnFfbnVtX21pbiBlcXVhbHMgdG8g
dGhlIHZhbHVlIHJldHVybmVkIGJ5Cj4+PiBnZXRfdnFfbnVtX21heC4KPj4+IFRoaXMgaXMgdXNl
ZnVsIGZvciB2ZHBhIGRldmljZXMgYmFzZWQgb24gbGVnYWN5IHZpcnRpbyBzcGVjZmljYXRpb24u
Cj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogV3UgWm9uZ3lvbmcgPHd1em9uZ3lvbmdAbGludXguYWxp
YmFiYS5jb20+Cj4+PiAtLS0KPj4+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYyB8IDIx
ICsrKysrKysrKysrKysrKystLS0tLQo+Pj4gICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9u
cygrKSwgNSBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8v
dmlydGlvX3ZkcGEuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMKPj4+IGluZGV4IDcy
ZWFlZjJjYWViMS4uZTQyYWNlMjlkYWExIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy92aXJ0aW8v
dmlydGlvX3ZkcGEuYwo+Pj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYwo+Pj4g
QEAgLTE0NSw3ICsxNDUsOCBAQCB2aXJ0aW9fdmRwYV9zZXR1cF92cShzdHJ1Y3QgdmlydGlvX2Rl
dmljZSAqdmRldiwgdW5zaWduZWQgaW50IGluZGV4LAo+Pj4gICAgICAgICAgLyogQXNzdW1lIHNw
bGl0IHZpcnRxdWV1ZSwgc3dpdGNoIHRvIHBhY2tlZCBpZiBuZWNlc3NhcnkgKi8KPj4+ICAgICAg
ICAgIHN0cnVjdCB2ZHBhX3ZxX3N0YXRlIHN0YXRlID0gezB9Owo+Pj4gICAgICAgICAgdW5zaWdu
ZWQgbG9uZyBmbGFnczsKPj4+IC0gICAgICAgdTMyIGFsaWduLCBudW07Cj4+PiArICAgICAgIHUz
MiBhbGlnbiwgbWF4X251bSwgbWluX251bSA9IDA7Cj4+PiArICAgICAgIGJvb2wgbWF5X3JlZHVj
ZV9udW0gPSB0cnVlOwo+Pj4gICAgICAgICAgaW50IGVycjsKPj4+Cj4+PiAgICAgICAgICBpZiAo
IW5hbWUpCj4+PiBAQCAtMTYzLDIyICsxNjQsMzIgQEAgdmlydGlvX3ZkcGFfc2V0dXBfdnEoc3Ry
dWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsIHVuc2lnbmVkIGludCBpbmRleCwKPj4+ICAgICAgICAg
IGlmICghaW5mbykKPj4+ICAgICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7
Cj4+Pgo+Pj4gLSAgICAgICBudW0gPSBvcHMtPmdldF92cV9udW1fbWF4KHZkcGEpOwo+Pj4gLSAg
ICAgICBpZiAobnVtID09IDApIHsKPj4+ICsgICAgICAgbWF4X251bSA9IG9wcy0+Z2V0X3ZxX251
bV9tYXgodmRwYSk7Cj4+PiArICAgICAgIGlmIChtYXhfbnVtID09IDApIHsKPj4+ICAgICAgICAg
ICAgICAgICAgZXJyID0gLUVOT0VOVDsKPj4+ICAgICAgICAgICAgICAgICAgZ290byBlcnJvcl9u
ZXdfdmlydHF1ZXVlOwo+Pj4gICAgICAgICAgfQo+Pj4KPj4+ICsgICAgICAgaWYgKG9wcy0+Z2V0
X3ZxX251bV9taW4pCj4+PiArICAgICAgICAgICAgICAgbWluX251bSA9IG9wcy0+Z2V0X3ZxX251
bV9taW4odmRwYSk7Cj4+PiArCj4+PiArICAgICAgIG1heV9yZWR1Y2VfbnVtID0gKG1heF9udW0g
PT0gbWluX251bSkgPyBmYWxzZSA6IHRydWU7Cj4+PiArCj4+PiAgICAgICAgICAvKiBDcmVhdGUg
dGhlIHZyaW5nICovCj4+PiAgICAgICAgICBhbGlnbiA9IG9wcy0+Z2V0X3ZxX2FsaWduKHZkcGEp
Owo+Pj4gLSAgICAgICB2cSA9IHZyaW5nX2NyZWF0ZV92aXJ0cXVldWUoaW5kZXgsIG51bSwgYWxp
Z24sIHZkZXYsCj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0cnVlLCB0
cnVlLCBjdHgsCj4+PiArICAgICAgIHZxID0gdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZShpbmRleCwg
bWF4X251bSwgYWxpZ24sIHZkZXYsCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB0cnVlLCBtYXlfcmVkdWNlX251bSwgY3R4LAo+Pj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHZpcnRpb192ZHBhX25vdGlmeSwgY2FsbGJhY2ssIG5hbWUpOwo+Pj4g
ICAgICAgICAgaWYgKCF2cSkgewo+Pj4gICAgICAgICAgICAgICAgICBlcnIgPSAtRU5PTUVNOwo+
Pj4gICAgICAgICAgICAgICAgICBnb3RvIGVycm9yX25ld192aXJ0cXVldWU7Cj4+PiAgICAgICAg
ICB9Cj4+Pgo+Pj4gKyAgICAgICBpZiAodmlydHF1ZXVlX2dldF92cmluZ19zaXplKHZxKSA8IG1p
bl9udW0pIHsKPj4+ICsgICAgICAgICAgICAgICBlcnIgPSAtRUlOVkFMOwo+Pj4gKyAgICAgICAg
ICAgICAgIGdvdG8gZXJyX3ZxOwo+Pj4gKyAgICAgICB9Cj4+IEkgd29uZGVyIHVuZGVyIHdoaWNo
IGNhc2UgY2FuIHdlIGhpdCB0aGlzPwo+Pgo+PiBUaGFua3MKPiBJZiBtaW5fdnFfbnVtIDwgbWF4
X3ZxX251bSwgbWF5X3JlZHVjZV9udW0gc2hvdWxkIGJlIHRydWUsIHRoZW4gaXQgaXMKPiBwb3Nz
aWJsZSB0byBhbGxvY2F0ZSBhIHZpcnRxdWV1ZSB3aXRoIGEgc21hbGwgc2l6ZSB3aGljaCB2YWx1
ZSBpcyBsZXNzCj4gdGhhbiB0aGUgbWluX3ZxX251bSBzaW5jZSB3ZSBvbmx5IHNldCB0aGUgdXBw
ZXIgYm91bmQgZm9yIHZpcnRxdWV1ZSBzaXplCj4gd2hlbiBjcmVhdGluZyB2aXJ0cXVldWUuCj4K
PiBSZWZlcnMgdG8gdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9zcGxpdCBpbiBkcml2ZXIvdmlydGlv
L3ZpcnRpb192cmluZy5jOgo+Cj4gCWZvciAoOyBudW0gJiYgdnJpbmdfc2l6ZShudW0sIHZyaW5n
X2FsaWduKSA+IFBBR0VfU0laRTsgbnVtIC89IDIpIHsKPiAJCXF1ZXVlID0gdnJpbmdfYWxsb2Nf
cXVldWUodmRldiwgdnJpbmdfc2l6ZShudW0sIHZyaW5nX2FsaWduKSwKPiAJCQkJCSAgJmRtYV9h
ZGRyLAo+IAkJCQkJICBHRlBfS0VSTkVMfF9fR0ZQX05PV0FSTnxfX0dGUF9aRVJPKTsKPiAJCWlm
IChxdWV1ZSkKPiAJCQlicmVhazsKPiAJCWlmICghbWF5X3JlZHVjZV9udW0pCj4gCQkJcmV0dXJu
IE5VTEw7Cj4gCX0KCgpJdCBsb29rcyB0byBtZSBpdCdzIGJldHRlciB0byBmaXggdGhpcyBmdW5j
dGlvbiBpbnN0ZWFkIG9mIGNoZWNraW5nIGl0IAppbiB0aGUgY2FsbGVyPwoKCj4KPiBCVFcsIEkg
aGF2ZSByZXBsaWVkIHRoaXMgbWFpbCBvbiBOb3YuMTgsIGhhdmUgeW91IGV2ZXIgcmVjZWl2ZWQg
aXQ/CgoKRm9yIHNvbWUgcmVhc29uIEkgZG9udCcgZ2V0IHRoYXQuCgpUaGFua3MKCgo+Pj4gKwo+
Pj4gICAgICAgICAgLyogU2V0dXAgdmlydHF1ZXVlIGNhbGxiYWNrICovCj4+PiAgICAgICAgICBj
Yi5jYWxsYmFjayA9IHZpcnRpb192ZHBhX3ZpcnRxdWV1ZV9jYjsKPj4+ICAgICAgICAgIGNiLnBy
aXZhdGUgPSBpbmZvOwo+Pj4gLS0KPj4+IDIuMzEuMQo+Pj4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
