Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDD5C433F5
	for <virtualization@archiver.kernel.org>; Mon, 10 Jan 2022 06:45:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF3F4408DB;
	Mon, 10 Jan 2022 06:45:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QwZd5Kf1Awvc; Mon, 10 Jan 2022 06:45:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 55E19408C2;
	Mon, 10 Jan 2022 06:45:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32DBDC002F;
	Mon, 10 Jan 2022 06:45:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11CA8C001E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 06:45:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E027960BF8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 06:45:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jt7BYIX5wAgC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 06:45:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 15CE960BF3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 06:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641797149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DGgDqmRDvSQ4/RN+uZBGVOftwQhFVYQQJM5IjhB7bDg=;
 b=D9sqCugorsZ8alMXB9eWE/QroHsSlBt6O6H32hmfydTE+AuehBLuuoegF4ZGc9SdcarJWp
 zvWsdXv5VGy0DTbLXI83Y8b1f9knyYGoYT3CZe107xa1rJIwQH7elbiImGN3GcvCCFpKMa
 7Ig8qYhKou1pFZP0wSZ9nS9yjfyMdBk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-55-9aBb8QCdPdy7VenlUN9DdA-1; Mon, 10 Jan 2022 01:45:47 -0500
X-MC-Unique: 9aBb8QCdPdy7VenlUN9DdA-1
Received: by mail-pj1-f72.google.com with SMTP id
 k93-20020a17090a3ee600b001b32ec86e10so10543609pjc.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 09 Jan 2022 22:45:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=DGgDqmRDvSQ4/RN+uZBGVOftwQhFVYQQJM5IjhB7bDg=;
 b=pEaQvd2mKJVmysISuwO1zb9K7u1NsnFPYkXkI++O5I2ei5n8ILiic8VnviVF0XyWNz
 eQ1d++Nn/QKnONY0NiJFMg+haTb1yRxB5HxzycUpA9NyjRDbpQ6G+RwbX6gaKzyPlE3Z
 y/giZRxvmzQueBqN1uZlSo+DRAv7kHsBwiZ7AsFNLLV5rChaskkvi+rvU4Q5ogdvPZb8
 qa4sP+EWjSuXblqISucMgDVlLfrP97lKZDU6fTasZ5fB05xrqDtZwIloJMLCFLDhM/39
 zK4XAujYRDlyFIoDT0ca96iF0NKXgVGq8csnjPdqv6SpwddfpArpsK6eKUBkDnO4/yG5
 QTGA==
X-Gm-Message-State: AOAM53063qP42MUw1e9r56cK4gAATV67H8wsARfO1LrNt+2ijIkQBgbZ
 DHxJMxNg45oGTvgKxleoVFMAqhPZDtYhNco41/Dc4mfOmVzSrlQ4IjweIVbEShWhScResg/XRrd
 CeKuNlTKrIRGFPTLBW71lFGlb/hy0p0xSHRaSJCK2qg==
X-Received: by 2002:a17:902:8c94:b0:14a:db5:3de with SMTP id
 t20-20020a1709028c9400b0014a0db503demr11784203plo.132.1641797146492; 
 Sun, 09 Jan 2022 22:45:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxRVoUhcz+plnA8ZXnUzM6rci1ejSAmAAo9SVI37UgA9c96IyzOvH+0kgDec7k/QMSTwk5fuw==
X-Received: by 2002:a17:902:8c94:b0:14a:db5:3de with SMTP id
 t20-20020a1709028c9400b0014a0db503demr11784191plo.132.1641797146245; 
 Sun, 09 Jan 2022 22:45:46 -0800 (PST)
Received: from [10.72.13.131] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id d13sm5654980pfj.135.2022.01.09.22.45.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Jan 2022 22:45:45 -0800 (PST)
Message-ID: <768a05cc-16f7-b374-04a6-48fecfe1768b@redhat.com>
Date: Mon, 10 Jan 2022 14:45:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH 4/6] virtio: split: virtqueue_add_split() support dma
 address
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220107063306.23240-1-xuanzhuo@linux.alibaba.com>
 <20220107063306.23240-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220107063306.23240-5-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzEvNyDkuIvljYgyOjMzLCBYdWFuIFpodW8g5YaZ6YGTOgo+IHZpcnRxdWV1ZV9h
ZGRfc3BsaXQoKSBvbmx5IHN1cHBvcnRzIHZpcnR1YWwgYWRkcmVzc2VzLCBkbWEgaXMgY29tcGxl
dGVkCj4gaW4gdmlydHF1ZXVlX2FkZF9zcGxpdCgpLgo+Cj4gSW4gc29tZSBzY2VuYXJpb3MgKHN1
Y2ggYXMgdGhlIEFGX1hEUCBzY2VuYXJpbyksIHRoZSBtZW1vcnkgaXMgYWxsb2NhdGVkCj4gYW5k
IERNQSBpcyBjb21wbGV0ZWQgaW4gYWR2YW5jZSwgc28gaXQgaXMgbmVjZXNzYXJ5IGZvciB1cyB0
byBzdXBwb3J0Cj4gcGFzc2luZyB0aGUgRE1BIGFkZHJlc3MgdG8gdmlydHF1ZXVlX2FkZF9zcGxp
dCgpLgo+Cj4gVGhpcyBwYXRjaCBzdGlwdWxhdGVzIHRoYXQgaWYgc2ctPmRtYV9hZGRyZXNzIGlz
IG5vdCBOVUxMLCB1c2UgdGhpcwo+IGFkZHJlc3MgYXMgdGhlIERNQSBhZGRyZXNzLiBBbmQgcmVj
b3JkIHRoaXMgaW5mb3JtYXRpb24gaW4gZXh0cmEtPmZsYWdzLAo+IHdoaWNoIGNhbiBiZSBza2lw
cGVkIHdoZW4gZXhlY3V0aW5nIGRtYSB1bm1hcC4KPgo+ICAgICAgZXh0cmEtPmZsYWdzIHw9IFZS
SU5HX0RFU0NfRl9QUkVETUE7CgoKSSB0aGluayB3ZSBuZWVkIGFub3RoZXIgbmFtZSBvdGhlciB0
aGFuIHRoZSBWUklOR19ERVNDX0YgcHJlZml4IHNpbmNlIAppdCdzIGZvciB0aGUgZmxhZyBkZWZp
bmVkIGluIHRoZSBzcGVjLiBNYXkgVklSVElPX0RFU0NfRl9QUkVETUEuCgpUaGFua3MKCgo+Cj4g
VGhpcyByZWxpZXMgb24gdGhlIHByZXZpb3VzIHBhdGNoLCBpbiB0aGUgaW5kaXJlY3Qgc2NlbmFy
aW8sIGZvciBlYWNoCj4gZGVzYyBhbGxvY2F0ZWQsIGFuIGV4dHJhIGlzIGFsbG9jYXRlZCBhdCB0
aGUgc2FtZSB0aW1lLgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51
eC5hbGliYWJhLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAy
OCArKysrKysrKysrKysrKysrKysrKysrKystLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMjQgaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IDc0
MjA3NDFjYjc1MC4uYWRkODQzMGQ5Njc4IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3Zp
cnRpb19yaW5nLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTY2
LDYgKzY2LDkgQEAKPiAgICNkZWZpbmUgTEFTVF9BRERfVElNRV9JTlZBTElEKHZxKQo+ICAgI2Vu
ZGlmCj4gICAKPiArLyogVGhpcyBtZWFucyB0aGUgYnVmZmVyIGRtYSBpcyBwcmUtYWxsb2MuIEp1
c3QgdXNlZCBieSB2cmluZ19kZXNjX2V4dHJhICovCj4gKyNkZWZpbmUgVlJJTkdfREVTQ19GX1BS
RURNQQkoMSA8PCAxNSkKPiArCj4gICBzdHJ1Y3QgdnJpbmdfZGVzY19leHRyYSB7Cj4gICAJZG1h
X2FkZHJfdCBhZGRyOwkJLyogRGVzY3JpcHRvciBETUEgYWRkci4gKi8KPiAgIAl1MzIgbGVuOwkJ
CS8qIERlc2NyaXB0b3IgbGVuZ3RoLiAqLwo+IEBAIC0zMzYsMTEgKzMzOSwxOSBAQCBzdGF0aWMg
aW5saW5lIHN0cnVjdCBkZXZpY2UgKnZyaW5nX2RtYV9kZXYoY29uc3Qgc3RydWN0IHZyaW5nX3Zp
cnRxdWV1ZSAqdnEpCj4gICAJcmV0dXJuIHZxLT52cS52ZGV2LT5kZXYucGFyZW50Owo+ICAgfQo+
ICAgCj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBzZ19pc19wcmVkbWEoc3RydWN0IHNjYXR0ZXJsaXN0
ICpzZykKPiArewo+ICsJcmV0dXJuICEhc2ctPmRtYV9hZGRyZXNzOwo+ICt9Cj4gKwo+ICAgLyog
TWFwIG9uZSBzZyBlbnRyeS4gKi8KPiAgIHN0YXRpYyBkbWFfYWRkcl90IHZyaW5nX21hcF9vbmVf
c2coY29uc3Qgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEsCj4gICAJCQkJICAgc3RydWN0IHNj
YXR0ZXJsaXN0ICpzZywKPiAgIAkJCQkgICBlbnVtIGRtYV9kYXRhX2RpcmVjdGlvbiBkaXJlY3Rp
b24pCj4gICB7Cj4gKwlpZiAoc2dfaXNfcHJlZG1hKHNnKSkKPiArCQlyZXR1cm4gc2dfZG1hX2Fk
ZHJlc3Moc2cpOwo+ICsKPiAgIAlpZiAoIXZxLT51c2VfZG1hX2FwaSkKPiAgIAkJcmV0dXJuIChk
bWFfYWRkcl90KXNnX3BoeXMoc2cpOwo+ICAgCj4gQEAgLTM5Niw2ICs0MDcsOSBAQCBzdGF0aWMg
dW5zaWduZWQgaW50IHZyaW5nX3VubWFwX29uZV9zcGxpdChjb25zdCBzdHJ1Y3QgdnJpbmdfdmly
dHF1ZXVlICp2cSwKPiAgIAkJCQkgKGZsYWdzICYgVlJJTkdfREVTQ19GX1dSSVRFKSA/Cj4gICAJ
CQkJIERNQV9GUk9NX0RFVklDRSA6IERNQV9UT19ERVZJQ0UpOwo+ICAgCX0gZWxzZSB7Cj4gKwkJ
aWYgKGZsYWdzICYgVlJJTkdfREVTQ19GX1BSRURNQSkKPiArCQkJZ290byBvdXQ7Cj4gKwo+ICAg
CQlkbWFfdW5tYXBfcGFnZSh2cmluZ19kbWFfZGV2KHZxKSwKPiAgIAkJCSAgICAgICBleHRyYS0+
YWRkciwKPiAgIAkJCSAgICAgICBleHRyYS0+bGVuLAo+IEBAIC00NDEsNyArNDU1LDggQEAgc3Rh
dGljIGlubGluZSB1bnNpZ25lZCBpbnQgdmlydHF1ZXVlX2FkZF9kZXNjX3NwbGl0KHN0cnVjdCB2
aXJ0cXVldWUgKnZxLAo+ICAgCQkJCQkJICAgIHVuc2lnbmVkIGludCBpLAo+ICAgCQkJCQkJICAg
IGRtYV9hZGRyX3QgYWRkciwKPiAgIAkJCQkJCSAgICB1bnNpZ25lZCBpbnQgbGVuLAo+IC0JCQkJ
CQkgICAgdTE2IGZsYWdzKQo+ICsJCQkJCQkgICAgdTE2IGZsYWdzLAo+ICsJCQkJCQkgICAgYm9v
bCBwcmVkbWEpCj4gICB7Cj4gICAJc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnJpbmcgPSB0b192
dnEodnEpOwo+ICAgCXN0cnVjdCB2cmluZ19kZXNjX2V4dHJhICpleHRyYTsKPiBAQCAtNDY4LDYg
KzQ4Myw5IEBAIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IHZpcnRxdWV1ZV9hZGRfZGVzY19z
cGxpdChzdHJ1Y3QgdmlydHF1ZXVlICp2cSwKPiAgIAlleHRyYS0+bGVuID0gbGVuOwo+ICAgCWV4
dHJhLT5mbGFncyA9IGZsYWdzOwo+ICAgCj4gKwlpZiAocHJlZG1hKQo+ICsJCWV4dHJhLT5mbGFn
cyB8PSBWUklOR19ERVNDX0ZfUFJFRE1BOwo+ICsKPiAgIAlyZXR1cm4gbmV4dDsKPiAgIH0KPiAg
IAo+IEBAIC01NDcsNyArNTY1LDggQEAgc3RhdGljIGlubGluZSBpbnQgdmlydHF1ZXVlX2FkZF9z
cGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gICAJCQkgKiB0YWJsZSBzaW5jZSBpdCB1c2Ug
c3RyZWFtIERNQSBtYXBwaW5nLgo+ICAgCQkJICovCj4gICAJCQlpID0gdmlydHF1ZXVlX2FkZF9k
ZXNjX3NwbGl0KF92cSwgaW4sIGksIGFkZHIsIHNnLT5sZW5ndGgsCj4gLQkJCQkJCSAgICAgVlJJ
TkdfREVTQ19GX05FWFQpOwo+ICsJCQkJCQkgICAgIFZSSU5HX0RFU0NfRl9ORVhULAo+ICsJCQkJ
CQkgICAgIHNnX2lzX3ByZWRtYShzZykpOwo+ICAgCQl9Cj4gICAJfQo+ICAgCWZvciAoOyBuIDwg
KG91dF9zZ3MgKyBpbl9zZ3MpOyBuKyspIHsKPiBAQCAtNTYzLDcgKzU4Miw4IEBAIHN0YXRpYyBp
bmxpbmUgaW50IHZpcnRxdWV1ZV9hZGRfc3BsaXQoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxLAo+ICAg
CQkJaSA9IHZpcnRxdWV1ZV9hZGRfZGVzY19zcGxpdChfdnEsIGluLCBpLCBhZGRyLAo+ICAgCQkJ
CQkJICAgICBzZy0+bGVuZ3RoLAo+ICAgCQkJCQkJICAgICBWUklOR19ERVNDX0ZfTkVYVCB8Cj4g
LQkJCQkJCSAgICAgVlJJTkdfREVTQ19GX1dSSVRFKTsKPiArCQkJCQkJICAgICBWUklOR19ERVND
X0ZfV1JJVEUsCj4gKwkJCQkJCSAgICAgc2dfaXNfcHJlZG1hKHNnKSk7Cj4gICAJCX0KPiAgIAl9
Cj4gICAJLyogTGFzdCBvbmUgZG9lc24ndCBjb250aW51ZS4gKi8KPiBAQCAtNTgyLDcgKzYwMiw3
IEBAIHN0YXRpYyBpbmxpbmUgaW50IHZpcnRxdWV1ZV9hZGRfc3BsaXQoc3RydWN0IHZpcnRxdWV1
ZSAqX3ZxLAo+ICAgCj4gICAJCXZpcnRxdWV1ZV9hZGRfZGVzY19zcGxpdChfdnEsIE5VTEwsIGhl
YWQsIGFkZHIsCj4gICAJCQkJCSB0b3RhbF9zZyAqIHNpemVvZihzdHJ1Y3QgdnJpbmdfZGVzYyks
Cj4gLQkJCQkJIFZSSU5HX0RFU0NfRl9JTkRJUkVDVCk7Cj4gKwkJCQkJIFZSSU5HX0RFU0NfRl9J
TkRJUkVDVCwgZmFsc2UpOwo+ICAgCX0KPiAgIAo+ICAgCS8qIFdlJ3JlIHVzaW5nIHNvbWUgYnVm
ZmVycyBmcm9tIHRoZSBmcmVlIGxpc3QuICovCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
