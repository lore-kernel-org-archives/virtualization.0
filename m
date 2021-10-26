Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999FAC433F5
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 04:46:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CA5261078
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 04:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3CA5261078
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0388840319;
	Tue, 26 Oct 2021 04:46:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PSjiqw7jkBrq; Tue, 26 Oct 2021 04:46:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5E3DC4030C;
	Tue, 26 Oct 2021 04:46:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DDE6C0019;
	Tue, 26 Oct 2021 04:46:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 558E4C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:46:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 44D0C80FFF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:46:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tUaCBcOXSYjH
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:46:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8A74080F2E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635223604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ywFf8Nt0Po4A+AsAVSGAY5OyaS8B6ezXbsiAVAuI/M8=;
 b=WQrenAprwuxX5LSQFfrExmCHiTsTN9Xsa69Rk5d0wEgRz03hg/XDLAubCp+l8prh5crJDX
 hdqnmGCdNH2la9qEHtldDBrTZ8ZuRpzbogyNN+lWIw1VnUrEuav6dpgDLAG5lPFeVywBXx
 L951W4spANHLyp1KX1ffXt8ZM6V0TyA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-gTsKz8rfPd-R26-P9cDCog-1; Tue, 26 Oct 2021 00:46:43 -0400
X-MC-Unique: gTsKz8rfPd-R26-P9cDCog-1
Received: by mail-lj1-f197.google.com with SMTP id
 j12-20020a2e800c000000b00210c475e1aaso198276ljg.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 21:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ywFf8Nt0Po4A+AsAVSGAY5OyaS8B6ezXbsiAVAuI/M8=;
 b=XPqSNZb5RVQwN4nqwJRKFOJUGIMAJdAX6QkuMN7RGG8io+PHqeFN1B2mdBMYtGxYCz
 k0zl13JgPPDK0dWsM7DWPY+W9NQHlVfxh1mDBdXMh39VkURLTGuzwwker2Obqo1Vun0z
 BB4EQ7UxA7vm9Jb52zmX11IB5YpcW0rGwogvWgQAMqZr2BGPDvvB0SWeKGd+OKefj7EE
 PV2RvNAUt5RD6jBCmmJ547oyklX08VhwJrQeJRe+dSbq7rHOjtfSf9UFhueHEea00lax
 RKmHl4/j1TzV5xPe2yJEQ6L2GJ++GiIm2hz1xNlppXnfQSPnT3NJvKolufCdsW/OuKkS
 1T3w==
X-Gm-Message-State: AOAM532wMC1yND2IC5/3EvnsnW+oNJD8R0fXyIxycxPUwRnNhxCp1/zx
 j7o6bbUs1jC5B2M06U7RpqWj4lsiAcI821d8GqBYvq+7EhzRxOhhprm2vVaLou9m0xbKVNeFncq
 PG8tZfIVBQ8/zCJejIUMugV+qWPm1RqRlfVv7ABv3KEaYZjBjLy8b5xf7PQ==
X-Received: by 2002:a05:6512:3d11:: with SMTP id
 d17mr16086969lfv.481.1635223601668; 
 Mon, 25 Oct 2021 21:46:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcLiJzIwVWhMCDF8Td4cRTk/ol0gv9lySImO+vOnYnXqjy15iLtfVFK+Rp3mNhOD4BkEZ4r0ZV/jCqDb/6UC4=
X-Received: by 2002:a05:6512:3d11:: with SMTP id
 d17mr16086951lfv.481.1635223601462; 
 Mon, 25 Oct 2021 21:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634281805.git.wuzongyong@linux.alibaba.com>
 <cover.1634870456.git.wuzongyong@linux.alibaba.com>
 <c75b4499f7ead922daa19bf67b32eed6f185d260.1634870456.git.wuzongyong@linux.alibaba.com>
 <CACGkMEtNECAUtpEvLvEpTFKfbYRC7YQKnHDnjxR3k9Hap1tmig@mail.gmail.com>
 <20211025024403.GA3684@L-PF27918B-1352.localdomain>
 <bfb2875b-0da1-27e8-829b-f6b61ea6e326@redhat.com>
 <20211025062454.GA4832@L-PF27918B-1352.localdomain>
In-Reply-To: <20211025062454.GA4832@L-PF27918B-1352.localdomain>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Oct 2021 12:46:30 +0800
Message-ID: <CACGkMEvhRqWY=HXEqJHJUMupmEx+GZRvrzA3bZVoVgf=-r2U1A@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] virtio_vdpa: setup correct vq size with callbacks
 get_vq_num_{max, min}
To: Wu Zongyong <wuzongyong@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: wei.yang1@linux.alibaba.com, mst <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

T24gTW9uLCBPY3QgMjUsIDIwMjEgYXQgMjoyNSBQTSBXdSBab25neW9uZwo8d3V6b25neW9uZ0Bs
aW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4KPiBPbiBNb24sIE9jdCAyNSwgMjAyMSBhdCAxMjo0
NTo0NFBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4KPiA+IOWcqCAyMDIxLzEwLzI1IOS4
iuWNiDEwOjQ0LCBXdSBab25neW9uZyDlhpnpgZM6Cj4gPiA+IE9uIE1vbiwgT2N0IDI1LCAyMDIx
IGF0IDEwOjIyOjMwQU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gT24gRnJpLCBP
Y3QgMjIsIDIwMjEgYXQgMTA6NDUgQU0gV3UgWm9uZ3lvbmcKPiA+ID4gPiA8d3V6b25neW9uZ0Bs
aW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiBGb3IgdGhlIGRldmljZXMgd2hpY2gg
aW1wbGVtZW50IHRoZSBnZXRfdnFfbnVtX21pbiBjYWxsYmFjaywgdGhlIGRyaXZlcgo+ID4gPiA+
ID4gc2hvdWxkIG5vdCBuZWdvdGlhdGUgd2l0aCB2aXJ0cXVldWUgc2l6ZSB3aXRoIHRoZSBiYWNr
ZW5kIHZkcGEgZGV2aWNlIGlmCj4gPiA+ID4gPiB0aGUgdmFsdWUgcmV0dXJuZWQgYnkgZ2V0X3Zx
X251bV9taW4gZXF1YWxzIHRvIHRoZSB2YWx1ZSByZXR1cm5lZCBieQo+ID4gPiA+ID4gZ2V0X3Zx
X251bV9tYXguCj4gPiA+ID4gPiBUaGlzIGlzIHVzZWZ1bCBmb3IgdmRwYSBkZXZpY2VzIGJhc2Vk
IG9uIGxlZ2FjeSB2aXJ0aW8gc3BlY2ZpY2F0aW9uLgo+ID4gPiA+ID4KPiA+ID4gPiA+IFNpZ25l
ZC1vZmYtYnk6IFd1IFpvbmd5b25nIDx3dXpvbmd5b25nQGxpbnV4LmFsaWJhYmEuY29tPgo+ID4g
PiA+ID4gLS0tCj4gPiA+ID4gPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMgfCAyMSAr
KysrKysrKysrKysrKysrLS0tLS0KPiA+ID4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2Vy
dGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4gPiA+ID4gPgo+ID4gPiA+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRw
YS5jCj4gPiA+ID4gPiBpbmRleCA3MmVhZWYyY2FlYjEuLmU0MmFjZTI5ZGFhMSAxMDA2NDQKPiA+
ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMKPiA+ID4gPiA+ICsrKyBi
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMKPiA+ID4gPiA+IEBAIC0xNDUsNyArMTQ1LDgg
QEAgdmlydGlvX3ZkcGFfc2V0dXBfdnEoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsIHVuc2ln
bmVkIGludCBpbmRleCwKPiA+ID4gPiA+ICAgICAgICAgIC8qIEFzc3VtZSBzcGxpdCB2aXJ0cXVl
dWUsIHN3aXRjaCB0byBwYWNrZWQgaWYgbmVjZXNzYXJ5ICovCj4gPiA+ID4gPiAgICAgICAgICBz
dHJ1Y3QgdmRwYV92cV9zdGF0ZSBzdGF0ZSA9IHswfTsKPiA+ID4gPiA+ICAgICAgICAgIHVuc2ln
bmVkIGxvbmcgZmxhZ3M7Cj4gPiA+ID4gPiAtICAgICAgIHUzMiBhbGlnbiwgbnVtOwo+ID4gPiA+
ID4gKyAgICAgICB1MzIgYWxpZ24sIG1heF9udW0sIG1pbl9udW0gPSAwOwo+ID4gPiA+ID4gKyAg
ICAgICBib29sIG1heV9yZWR1Y2VfbnVtID0gdHJ1ZTsKPiA+ID4gPiA+ICAgICAgICAgIGludCBl
cnI7Cj4gPiA+ID4gPgo+ID4gPiA+ID4gICAgICAgICAgaWYgKCFuYW1lKQo+ID4gPiA+ID4gQEAg
LTE2MywyMiArMTY0LDMyIEBAIHZpcnRpb192ZHBhX3NldHVwX3ZxKHN0cnVjdCB2aXJ0aW9fZGV2
aWNlICp2ZGV2LCB1bnNpZ25lZCBpbnQgaW5kZXgsCj4gPiA+ID4gPiAgICAgICAgICBpZiAoIWlu
Zm8pCj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgIHJldHVybiBFUlJfUFRSKC1FTk9NRU0pOwo+
ID4gPiA+ID4KPiA+ID4gPiA+IC0gICAgICAgbnVtID0gb3BzLT5nZXRfdnFfbnVtX21heCh2ZHBh
KTsKPiA+ID4gPiA+IC0gICAgICAgaWYgKG51bSA9PSAwKSB7Cj4gPiA+ID4gPiArICAgICAgIG1h
eF9udW0gPSBvcHMtPmdldF92cV9udW1fbWF4KHZkcGEpOwo+ID4gPiA+ID4gKyAgICAgICBpZiAo
bWF4X251bSA9PSAwKSB7Cj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgIGVyciA9IC1FTk9FTlQ7
Cj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgIGdvdG8gZXJyb3JfbmV3X3ZpcnRxdWV1ZTsKPiA+
ID4gPiA+ICAgICAgICAgIH0KPiA+ID4gPiA+Cj4gPiA+ID4gPiArICAgICAgIGlmIChvcHMtPmdl
dF92cV9udW1fbWluKQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIG1pbl9udW0gPSBvcHMtPmdl
dF92cV9udW1fbWluKHZkcGEpOwo+ID4gPiA+ID4gKwo+ID4gPiA+ID4gKyAgICAgICBtYXlfcmVk
dWNlX251bSA9IChtYXhfbnVtID09IG1pbl9udW0pID8gZmFsc2UgOiB0cnVlOwo+ID4gPiA+ID4g
Kwo+ID4gPiA+ID4gICAgICAgICAgLyogQ3JlYXRlIHRoZSB2cmluZyAqLwo+ID4gPiA+ID4gICAg
ICAgICAgYWxpZ24gPSBvcHMtPmdldF92cV9hbGlnbih2ZHBhKTsKPiA+ID4gPiA+IC0gICAgICAg
dnEgPSB2cmluZ19jcmVhdGVfdmlydHF1ZXVlKGluZGV4LCBudW0sIGFsaWduLCB2ZGV2LAo+ID4g
PiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHJ1ZSwgdHJ1ZSwgY3R4
LAo+ID4gPiA+ID4gKyAgICAgICB2cSA9IHZyaW5nX2NyZWF0ZV92aXJ0cXVldWUoaW5kZXgsIG1h
eF9udW0sIGFsaWduLCB2ZGV2LAo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdHJ1ZSwgbWF5X3JlZHVjZV9udW0sIGN0eCwKPiA+ID4gPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB2aXJ0aW9fdmRwYV9ub3RpZnksIGNhbGxiYWNrLCBu
YW1lKTsKPiA+ID4gPiA+ICAgICAgICAgIGlmICghdnEpIHsKPiA+ID4gPiA+ICAgICAgICAgICAg
ICAgICAgZXJyID0gLUVOT01FTTsKPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgZ290byBlcnJv
cl9uZXdfdmlydHF1ZXVlOwo+ID4gPiA+ID4gICAgICAgICAgfQo+ID4gPiA+ID4KPiA+ID4gPiA+
ICsgICAgICAgaWYgKHZpcnRxdWV1ZV9nZXRfdnJpbmdfc2l6ZSh2cSkgPCBtaW5fbnVtKSB7Cj4g
PiA+ID4gPiArICAgICAgICAgICAgICAgZXJyID0gLUVJTlZBTDsKPiA+ID4gPiA+ICsgICAgICAg
ICAgICAgICBnb3RvIGVycl92cTsKPiA+ID4gPiA+ICsgICAgICAgfQo+ID4gPiA+IEkgd29uZGVy
IHVuZGVyIHdoaWNoIGNhc2UgY2FuIHdlIGhpdCB0aGlzPwo+ID4gPiA+Cj4gPiA+ID4gVGhhbmtz
Cj4gPiA+IElmIG1pbl92cV9udW0gPCBtYXhfdnFfbnVtLCBtYXlfcmVkdWNlX251bSBzaG91bGQg
YmUgdHJ1ZSwgdGhlbiBpdCBpcwo+ID4gPiBwb3NzaWJsZSB0byBhbGxvY2F0ZSBhIHZpcnRxdWV1
ZSB3aXRoIGEgc21hbGwgc2l6ZSB3aGljaCB2YWx1ZSBpcyBsZXNzCj4gPiA+IHRoYW4gdGhlIG1p
bl92cV9udW0gc2luY2Ugd2Ugb25seSBzZXQgdGhlIHVwcGVyIGJvdW5kIGZvciB2aXJ0cXVldWUg
c2l6ZQo+ID4gPiB3aGVuIGNyZWF0aW5nIHZpcnRxdWV1ZS4KPiA+ID4KPiA+ID4gUmVmZXJzIHRv
IHZyaW5nX2NyZWF0ZV92aXJ0cXVldWVfc3BsaXQgaW4gZHJpdmVyL3ZpcnRpby92aXJ0aW9fdnJp
bmcuYzoKPiA+ID4KPiA+ID4gICAgIGZvciAoOyBudW0gJiYgdnJpbmdfc2l6ZShudW0sIHZyaW5n
X2FsaWduKSA+IFBBR0VfU0laRTsgbnVtIC89IDIpIHsKPiA+ID4gICAgICAgICAgICAgcXVldWUg
PSB2cmluZ19hbGxvY19xdWV1ZSh2ZGV2LCB2cmluZ19zaXplKG51bSwgdnJpbmdfYWxpZ24pLAo+
ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZkbWFfYWRkciwKPiA+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBHRlBfS0VSTkVMfF9fR0ZQ
X05PV0FSTnxfX0dGUF9aRVJPKTsKPiA+ID4gICAgICAgICAgICAgaWYgKHF1ZXVlKQo+ID4gPiAg
ICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+ID4gPiAgICAgICAgICAgICBpZiAoIW1heV9yZWR1
Y2VfbnVtKQo+ID4gPiAgICAgICAgICAgICAgICAgICAgIHJldHVybiBOVUxMOwo+ID4gPiAgICAg
fQo+ID4KPiA+Cj4gPiBJdCBsb29rcyB0byBtZSBpdCdzIGJldHRlciB0byBmaXggdGhpcyBmdW5j
dGlvbiBpbnN0ZWFkIG9mIGNoZWNraW5nIGl0IGluCj4gPiB0aGUgY2FsbGVyPwo+Cj4gT3Igd2Ug
Y2FuIHNpbXBseSByZW1vdmUgdGhhdCBjb2RlIHNpbmNlIHRoaXMgY2FzZSBvbmx5IGV4aXN0cyBp
biB0aGVvcnksIGFuZAo+IHRoZXJlIGlzIG5vIHJlYWwgdXNlY2FzZSBmb3Igbm93LgoKKEFkZGlu
ZyBsaXN0IGJhY2spCgpTb21laG93LCBpdCBjYW4ndCBoYXBwZW4gaWYgeW91IHN0aWNrIHRvIGEg
MjU2IGFzIGJvdGggbWluIGFuZCBtYXguCgpBbm90aGVyIHF1ZXN0aW9uLCBjYW4gRU5JIHN1cHBv
cnQgdnJpbmcgc2l6ZSB3aGljaCBpcyBsZXNzIHRoYW4gMjU2PwoKVGhhbmtzCgo+Cj4gPgo+ID4K
PiA+ID4KPiA+ID4gQlRXLCBJIGhhdmUgcmVwbGllZCB0aGlzIG1haWwgb24gTm92LjE4LCBoYXZl
IHlvdSBldmVyIHJlY2VpdmVkIGl0Pwo+ID4KPiA+Cj4gPiBGb3Igc29tZSByZWFzb24gSSBkb250
JyBnZXQgdGhhdC4KPiA+Cj4gPiBUaGFua3MKPiA+Cj4gPgo+ID4gPiA+ID4gKwo+ID4gPiA+ID4g
ICAgICAgICAgLyogU2V0dXAgdmlydHF1ZXVlIGNhbGxiYWNrICovCj4gPiA+ID4gPiAgICAgICAg
ICBjYi5jYWxsYmFjayA9IHZpcnRpb192ZHBhX3ZpcnRxdWV1ZV9jYjsKPiA+ID4gPiA+ICAgICAg
ICAgIGNiLnByaXZhdGUgPSBpbmZvOwo+ID4gPiA+ID4gLS0KPiA+ID4gPiA+IDIuMzEuMQo+ID4g
PiA+ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
