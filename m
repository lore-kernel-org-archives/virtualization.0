Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D292CC433F5
	for <virtualization@archiver.kernel.org>; Wed,  8 Dec 2021 11:09:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CFDC41D62;
	Wed,  8 Dec 2021 11:09:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2BZkuH04yoZi; Wed,  8 Dec 2021 11:09:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0EDB941D34;
	Wed,  8 Dec 2021 11:09:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C03E9C002F;
	Wed,  8 Dec 2021 11:09:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF987C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 11:09:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ADA7740207
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 11:09:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ex5mXJzLdvYj
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 11:09:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 810C54017C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 11:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638961748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B444APunhjQQI7ewweOzGaGNLCo2wF23Z1jHaRUgWMM=;
 b=XBFFtt+oo9B73ZiWfukcDiv8B/+DDYEPqYSaCX892Qc//skudafaS+LE0jrXPW7MA1sTWf
 rmd9WwFcUsL52hjRs3AqEnDJ2yLUEHYYiUPuDxLiuZz5qEL6k/7/t0CWOrv8HCXDpJqPBh
 Nwsy4kleVsM3PwGi5LhoO1S6WtM2GXw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539-8Ztm_DHvNoq-NNS6RgCQSg-1; Wed, 08 Dec 2021 06:09:06 -0500
X-MC-Unique: 8Ztm_DHvNoq-NNS6RgCQSg-1
Received: by mail-ed1-f71.google.com with SMTP id
 p4-20020aa7d304000000b003e7ef120a37so1792424edq.16
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Dec 2021 03:09:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=B444APunhjQQI7ewweOzGaGNLCo2wF23Z1jHaRUgWMM=;
 b=yecKbQaeKMuwTCMUT66O89CK+SLAlUecVOmb+HfjaidmJwLYJ2L+at9eRgVWgH3dxX
 HpRZ0XZVZjUHI/SypcT2wSCsxapDJ5EHz9lR1iV9irFyRf5xakbUp4isnT201R2dqDWu
 YaK9b0EM6TBUmcYDX/9dsbvRXDC/H93P/dFBgcevg9DIaZR6sHUb7xmkb15b7gIMWhSS
 xDoNVWIoezMPs0vuPipeD+IbhdZNt0ooEbNVgnjPs7Mrbh6vpnnZRcr6oJT0RsBtURlj
 hY5koDSvUuVvE2mxl17Gz+Ts+w5O+lDpuDwMHPJ1gCqxEg6ZqW80x8MJ5mqMKWbaTzMX
 Ls/g==
X-Gm-Message-State: AOAM531cUqyyGCuU3Y/3aW5YsxYocOy63N6PdP0wGcVV5wj2Ks0x+z0V
 jV24X7msT17PAMsfY7I88pbglo/W6Gvis+d93W/aMwHjOx5bJwP86wWpbLfjCkKfp9bum34XbSv
 22YE0bFHs9Y9bs2Wc88DRqaywbvFXFqgFsL0j395eUA==
X-Received: by 2002:a17:906:3b54:: with SMTP id
 h20mr6540136ejf.468.1638961745787; 
 Wed, 08 Dec 2021 03:09:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzh9GMkBKKw7RyCq/4YuJ3MnnteCYuC//FXO9Hp9hK7sQEDVB83XOPsN2aHFE3+S8gTgOzaHA==
X-Received: by 2002:a17:906:3b54:: with SMTP id
 h20mr6540100ejf.468.1638961745442; 
 Wed, 08 Dec 2021 03:09:05 -0800 (PST)
Received: from redhat.com ([147.161.9.141])
 by smtp.gmail.com with ESMTPSA id s16sm1758274edt.30.2021.12.08.03.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Dec 2021 03:09:02 -0800 (PST)
Date: Wed, 8 Dec 2021 06:08:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Subject: Re: [RFC PATCH] virtio: make sure legacy pci device gain 32bit-pfn vq
Message-ID: <20211208060115-mutt-send-email-mst@kernel.org>
References: <b50fff4d-9f05-76b3-eba7-91241c351751@linux.alibaba.com>
 <20211207031217-mutt-send-email-mst@kernel.org>
 <8bbfd029-d969-4632-cb8e-482481d65a2f@linux.alibaba.com>
 <20211208021947-mutt-send-email-mst@kernel.org>
 <dfb712d7-1186-1496-9fcc-a72e23c3409b@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <dfb712d7-1186-1496-9fcc-a72e23c3409b@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: open list <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>
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

T24gV2VkLCBEZWMgMDgsIDIwMjEgYXQgMDQ6MDQ6MTlQTSArMDgwMCwg546L6LSHIHdyb3RlOgo+
IAo+IAo+IOWcqCAyMDIxLzEyLzgg5LiL5Y2IMzoyMywgTWljaGFlbCBTLiBUc2lya2luIOWGmemB
kzoKPiA+IE9uIFR1ZSwgRGVjIDA3LCAyMDIxIGF0IDA1OjA5OjU2UE0gKzA4MDAsIOeOi+i0hyB3
cm90ZToKPiA+ID4gCj4gPiA+IAo+ID4gPiDlnKggMjAyMS8xMi83IOS4i+WNiDQ6MTMsIE1pY2hh
ZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4gPiA+ID4gT24gVHVlLCBEZWMgMDcsIDIwMjEgYXQgMDM6
NTE6NDVQTSArMDgwMCwg546L6LSHIHdyb3RlOgo+ID4gPiA+ID4gV2Ugb2JzZXJ2ZWQgaXNzdWVz
IGxpa2U6Cj4gPiA+ID4gPiAgICAgdmlydGlvLXBjaSAwMDAwOjE0OjAwLjA6IHBsYXRmb3JtIGJ1
ZzogbGVnYWN5IHZpcnRpby1tbWlvIG11c3QKPiA+ID4gPiA+ICAgICBub3QgYmUgdXNlZCB3aXRo
IFJBTSBhYm92ZSAweDQwMDBHQgo+ID4gPiA+ID4gCj4gPiA+ID4gPiB3aGVuIHdlIGhhdmUgYSBs
ZWdhY3kgcGNpIGRldmljZSB3aGljaCBkZXNpcmVkIDMyYml0LXBmbiB2cQo+ID4gPiA+ID4gYnV0
IGdhaW4gNjRiaXQtcGZuIGluc3RlYWQsIGxlYWQgaW50byB0aGUgZmFpbHVyZSBvZiBwcm9iZS4K
PiA+ID4gPiA+IAo+ID4gPiA+ID4gdnJpbmdfdXNlX2RtYV9hcGkoKSBpcyBwbGF5aW5nIHRoZSBr
ZXkgcm9sZSBpbiBoZXJlLCB0byBoZWxwIHRoZQo+ID4gPiA+ID4gYWxsb2NhdGlvbiBwcm9jZXNz
IHVuZGVyc3RhbmQgd2hpY2gga2luZCBvZiB2cSBpdCBzaG91bGQgYWxsb2MsCj4gPiA+ID4gPiBo
b3dldmVyLCBpdCBmYWlsZWQgdG8gdGFrZSBjYXJlIHRoZSBsZWdhY3kgcGNpIGRldmljZSwgd2hp
Y2ggb25seQo+ID4gPiA+ID4gaGF2ZSAzMmJpdCBmZWF0dXJlIGZsYWcgYW5kIGNhbiBuZXZlciBo
YXZlIFZJUlRJT19GX0FDQ0VTU19QTEFURk9STQo+ID4gPiA+ID4gc2V0dGVkLgo+ID4gPiA+ID4g
Cj4gPiA+ID4gPiBUaGlzIHBhdGNoIGludHJvZHVjZSBmb3JjZV9kbWEgZmxhZyB0byBoZWxwIHZy
aW5nX3VzZV9kbWFfYXBpKCkKPiA+ID4gPiA+IHVuZGVyc3RhbmRpbmcgdGhlIHJlcXVpcmVtZW50
IGJldHRlciwgdG8gYXZvaWQgdGhlIGZhaWxpbmcuCj4gPiA+ID4gPiAKPiA+ID4gPiA+IFNpZ25l
ZC1vZmYtYnk6IE1pY2hhZWwgV2FuZyA8eXVuLndhbmdAbGludXguYWxpYmFiYS5jb20+Cj4gPiA+
ID4gCj4gPiA+ID4gVGhpcyB3aWxsIGJyZWFrIGNvbmZpZ3Mgd2hlcmUgdGhlIGRldmljZSBhcHBl
YXJzIGJlaGluZAo+ID4gPiA+IGEgdmlydHVhbCBpb21tdSwgc28gdGhpcyB3b24ndCBmbHkuCj4g
PiA+ID4gSnVzdCBtYWtlIHlvdXIgZGV2aWNlIHN1cHBvcnQgMS4wLCBlaD8KPiA+ID4gCj4gPiA+
IEhpLCBNaWNoYWVsCj4gPiA+IAo+ID4gPiBUaGFua3MgZm9yIHRoZSBjb21tZW50LCB1bmZvcnR1
bmF0ZWx5IG1vZGlmeSBkZXZpY2UgaXMgbm90IGFuIG9wdGlvbiBmb3IgdXMKPiA+ID4gOi0oCj4g
PiA+IAo+ID4gPiBJcyB0aGVyZSBhbnkgaWRlYSBvbiBob3cgdG8gc29sdmUgdGhpcyBpc3N1ZSBw
cm9wZXJseT8KPiA+ID4gCj4gPiA+IFJlZ2FyZHMsCj4gPiA+IE1pY2hhZWwgV2FuZwo+ID4gCj4g
PiBCeSB0aGUgd2F5LCB0aGVyZSBpcyBhIGJ1ZyBpbiB0aGUgZXJyb3IgbWVzc2FnZS4gV2FudCB0
byBmaXggdGhhdD8KPiAKPiBDb3VsZCB5b3UgcGxlYXNlIHByb3ZpZGUgbW9yZSBkZXRhaWwgYWJv
dXQgdGhlIGJ1Zz8gV2UnZCBsaWtlIHRvIGhlbHAgZml4aW5nCj4gaXQgOi0pCgp2aXJ0aW8tcGNp
IDAwMDA6MTQ6MDAuMDogcGxhdGZvcm0gYnVnOiBsZWdhY3kgdmlydGlvLW1taW8gbXVzdCAuLi4K
CnNob3VsZCBiZSB2aXJ0aW8tcGNpIG5vdCB2aXJ0aW8tbW1pbwoKCgo+IEJlc2lkZXMsIEkndmUg
Y2hlY2tlZCB0aGF0IHBhdGNoIGJ1dCBpdCBjYW4ndCBhZGRyZXNzIG91ciBpc3N1ZSwgd2UgYWN0
dWFsbHkKPiBoYXZlIHRoaXMgbGVnYWN5IHBjaSBkZXZpY2Ugb24gYXJtIHBsYXRmb3JtLCBhbmQg
dGhlIG1lbW9yeSBsYXlvdXQgaXMKPiB1bmZyaWVuZGx5IHNpbmNlIGFsbG9jYXRpb24gcmFyZWx5
IHByb3ZpZGluZyBwYWdlLWFkZHJlc3MgYmVsb3cgNDRiaXQsIHdlCj4gdW5kZXJzdGFuZCB0aGUg
dmlydGlvLWlvbW11IGNhc2Ugc2hvdWxkIG5vdCBkbyBmb3JjZSBkbWEsIHdoaWxlIHdlIGRvbid0
Cj4gaGF2ZSB0aGF0IHNvIGl0J3MganVzdCB3b3JraW5nIGZpbmUuCj4gCj4gUmVnYXJkcywKPiBN
aWNoYWVsIFdhbmcKCkhtbSB3YWl0IGEgc2VjIGlzIGl0IGEgcGh5c2ljYWwgZGV2aWNlIG9yIGEg
aHlwZXJ2aXNvcj8KSWYgYSBwaHlzaWNhbCBvbmUgdGhlbiBkb2Vzbid0IGl0IG5lZWQgVklSVElP
X0ZfT1JERVJfUExBVEZPUk0Kb24gQVJNPwoKCgo+ID4gCj4gPiAKPiA+ID4gPiAKPiA+ID4gPiA+
IC0tLQo+ID4gPiA+ID4gICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYyB8IDEw
ICsrKysrKysrKysKPiA+ID4gPiA+ICAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgICAg
ICAgfCAgMyArKysKPiA+ID4gPiA+ICAgIGluY2x1ZGUvbGludXgvdmlydGlvLmggICAgICAgICAg
ICAgfCAgMSArCj4gPiA+ID4gPiAgICAzIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykK
PiA+ID4gPiA+IAo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19w
Y2lfbGVnYWN5LmMKPiA+ID4gPiA+IGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3ku
Ywo+ID4gPiA+ID4gaW5kZXggZDYyZTk4My4uMTFmMmViZiAxMDA2NDQKPiA+ID4gPiA+IC0tLSBh
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMKPiA+ID4gPiA+ICsrKyBiL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMKPiA+ID4gPiA+IEBAIC0yNjMsNiArMjYzLDE2
IEBAIGludCB2aXJ0aW9fcGNpX2xlZ2FjeV9wcm9iZShzdHJ1Y3QgdmlydGlvX3BjaV9kZXZpY2UK
PiA+ID4gPiA+ICp2cF9kZXYpCj4gPiA+ID4gPiAgICAJdnBfZGV2LT5zZXR1cF92cSA9IHNldHVw
X3ZxOwo+ID4gPiA+ID4gICAgCXZwX2Rldi0+ZGVsX3ZxID0gZGVsX3ZxOwo+ID4gPiA+ID4gCj4g
PiA+ID4gPiArCS8qCj4gPiA+ID4gPiArCSAqIFRoZSBsZWdhY3kgcGNpIGRldmljZSByZXF1cmUg
MzJiaXQtcGZuIHZxLAo+ID4gPiA+ID4gKwkgKiBvciBzZXR1cF92cSgpIHdpbGwgZmFpbGVkLgo+
ID4gPiA+ID4gKwkgKgo+ID4gPiA+ID4gKwkgKiBUaHVzIHdlIG1ha2Ugc3VyZSB2cmluZ191c2Vf
ZG1hX2FwaSgpIHdpbGwKPiA+ID4gPiA+ICsJICogcmV0dXJuIHRydWUgZHVyaW5nIHRoZSBhbGxv
Y2F0aW9uIGJ5IG1hcmtpbmcKPiA+ID4gPiA+ICsJICogZm9yY2VfZG1hIGhlcmUuCj4gPiA+ID4g
PiArCSAqLwo+ID4gPiA+ID4gKwl2cF9kZXYtPnZkZXYuZm9yY2VfZG1hID0gdHJ1ZTsKPiA+ID4g
PiA+ICsKPiA+ID4gPiA+ICAgIAlyZXR1cm4gMDsKPiA+ID4gPiA+IAo+ID4gPiA+ID4gICAgZXJy
X2lvbWFwOgo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5n
LmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiA+ID4gPiBpbmRleCAzMDM1YmI2
Li42NTYyZTAxIDEwMDY0NAo+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jp
bmcuYwo+ID4gPiA+ID4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gPiA+
ID4gQEAgLTI0NSw2ICsyNDUsOSBAQCBzdGF0aWMgaW5saW5lIGJvb2wgdmlydHF1ZXVlX3VzZV9p
bmRpcmVjdChzdHJ1Y3QKPiA+ID4gPiA+IHZpcnRxdWV1ZSAqX3ZxLAo+ID4gPiA+ID4gCj4gPiA+
ID4gPiAgICBzdGF0aWMgYm9vbCB2cmluZ191c2VfZG1hX2FwaShzdHJ1Y3QgdmlydGlvX2Rldmlj
ZSAqdmRldikKPiA+ID4gPiA+ICAgIHsKPiA+ID4gPiA+ICsJaWYgKHZkZXYtPmZvcmNlX2RtYSkK
PiA+ID4gPiA+ICsJCXJldHVybiB0cnVlOwo+ID4gPiA+ID4gKwo+ID4gPiA+ID4gICAgCWlmICgh
dmlydGlvX2hhc19kbWFfcXVpcmsodmRldikpCj4gPiA+ID4gPiAgICAJCXJldHVybiB0cnVlOwo+
ID4gPiA+ID4gCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92aXJ0aW8uaCBi
L2luY2x1ZGUvbGludXgvdmlydGlvLmgKPiA+ID4gPiA+IGluZGV4IDQxZWRiYzAuLmE0ZWIyOWQg
MTAwNjQ0Cj4gPiA+ID4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4gPiA+ID4gPiAr
KysgYi9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4gPiA+ID4gPiBAQCAtMTA5LDYgKzEwOSw3IEBA
IHN0cnVjdCB2aXJ0aW9fZGV2aWNlIHsKPiA+ID4gPiA+ICAgIAlib29sIGZhaWxlZDsKPiA+ID4g
PiA+ICAgIAlib29sIGNvbmZpZ19lbmFibGVkOwo+ID4gPiA+ID4gICAgCWJvb2wgY29uZmlnX2No
YW5nZV9wZW5kaW5nOwo+ID4gPiA+ID4gKwlib29sIGZvcmNlX2RtYTsKPiA+ID4gPiA+ICAgIAlz
cGlubG9ja190IGNvbmZpZ19sb2NrOwo+ID4gPiA+ID4gICAgCXNwaW5sb2NrX3QgdnFzX2xpc3Rf
bG9jazsgLyogUHJvdGVjdHMgVlFzIGxpc3QgYWNjZXNzICovCj4gPiA+ID4gPiAgICAJc3RydWN0
IGRldmljZSBkZXY7Cj4gPiA+ID4gPiAtLSAKPiA+ID4gPiA+IDEuOC4zLjEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
