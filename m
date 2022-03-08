Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC92C4332F
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 07:29:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46CDF8146F;
	Tue,  8 Mar 2022 07:29:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vPmpSKDUNyxy; Tue,  8 Mar 2022 07:29:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BFA3C8145B;
	Tue,  8 Mar 2022 07:28:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98118C001D;
	Tue,  8 Mar 2022 07:28:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C025C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 07:28:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5A374410BE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 07:28:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DcSiSarL6fQ6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 07:28:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 66CE6410BD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 07:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646724536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ztihaAlc182OY1fZeHkkwRaEj5VUIs+DTdjcjAgLSk=;
 b=QbGzIbInrnRCo+vaJrETF8UOxYTXCjIBGn1MhJ5sVusPDv4MpX7yptU1PPlP/nta5zTiku
 TZXQsAs4u023iGlvVdKkR+CkJVF15RuhS+GNtZIZSk64TA2xX7MShpTVGFxWRJZZuu/dv7
 Y0RXAknUHxE4OBIi89yqQIx6gZzAstQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-U8FiUPa1NVu5WBgU_gmeag-1; Tue, 08 Mar 2022 02:28:55 -0500
X-MC-Unique: U8FiUPa1NVu5WBgU_gmeag-1
Received: by mail-pg1-f197.google.com with SMTP id
 196-20020a6307cd000000b0038027886594so3422579pgh.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Mar 2022 23:28:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=6ztihaAlc182OY1fZeHkkwRaEj5VUIs+DTdjcjAgLSk=;
 b=0ZGO81L/D2YG+sbYufJZYSN5S+bE4xY3NZXlegx2vdBtFnW7vEHHTQlin4u9Zg+R+1
 xI6UgPi27Ftlc3Q0zFJTF1ZoAEKIvmpx27hXZvXo5vKrVVhs7dWO3qtjblCdw7wyAAwI
 jdFPHoRY1f5D5tZvaPbcebKD225IqzmBrhyYn3VyXKNISAXIi5VFob5RkQZMZ2sf5p+u
 e9/m3Skv2yyoITzew9GnMEsRrJQSVB5mZJ4eIrhNEihc0NX5ZiYV0e5G6UdZJSbppBp5
 0NHqJCW9WAVSC+S+PyEh9CT3mcJmhatAJcshD8uU7oAMlhyXjX8E6gWjPDLbCVhfnDbV
 Nl9g==
X-Gm-Message-State: AOAM532O5nQddHFxOEZMgFQmTj0jZu36l62swkxlsVHuoZ2DKP47Tl3E
 CJJlrAC/RgzNP+UdLsWugcZonbwZK6rGh/BzfRPyLD5k1tIKo7O3KWyFzekcjiEEno+uz746HsC
 tyacvnPw00AhR/3d2LbIg0NKnUYZ1eamQi61ktDNNiw==
X-Received: by 2002:a63:5a5c:0:b0:378:73b1:e1d8 with SMTP id
 k28-20020a635a5c000000b0037873b1e1d8mr13018920pgm.364.1646724533797; 
 Mon, 07 Mar 2022 23:28:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwCUyzra0ttoBcB8VkDz4+CWP5e4H7VU1NxfWT6AIZG0k832QCn774gcMfF9dm/7wb5trfu5Q==
X-Received: by 2002:a63:5a5c:0:b0:378:73b1:e1d8 with SMTP id
 k28-20020a635a5c000000b0037873b1e1d8mr13018893pgm.364.1646724533473; 
 Mon, 07 Mar 2022 23:28:53 -0800 (PST)
Received: from [10.72.13.77] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a056a00191000b004e155b2623bsm19224048pfi.178.2022.03.07.23.28.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Mar 2022 23:28:52 -0800 (PST)
Message-ID: <91910574-d3f7-6a75-57cf-06a5fcb29be8@redhat.com>
Date: Tue, 8 Mar 2022 15:28:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v6 06/26] virtio_ring: packed: extrace the logic of
 creating vring
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20220224081102.80224-1-xuanzhuo@linux.alibaba.com>
 <20220224081102.80224-7-xuanzhuo@linux.alibaba.com>
 <20220307171629-mutt-send-email-mst@kernel.org>
 <1646722885.3801584-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <1646722885.3801584-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Vadim Pasternak <vadimp@nvidia.com>, linux-remoteproc@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 platform-driver-x86@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, kvm@vger.kernel.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

CuWcqCAyMDIyLzMvOCDkuIvljYgzOjAxLCBYdWFuIFpodW8g5YaZ6YGTOgo+IE9uIE1vbiwgNyBN
YXIgMjAyMiAxNzoxNzo1MSAtMDUwMCwgIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQu
Y29tPiB3cm90ZToKPj4gT24gVGh1LCBGZWIgMjQsIDIwMjIgYXQgMDQ6MTA6NDJQTSArMDgwMCwg
WHVhbiBaaHVvIHdyb3RlOgo+Pj4gU2VwYXJhdGUgdGhlIGxvZ2ljIG9mIHBhY2tlZCB0byBjcmVh
dGUgdnJpbmcgcXVldWUuCj4+Pgo+Pj4gRm9yIHRoZSBjb252ZW5pZW5jZSBvZiBwYXNzaW5nIHBh
cmFtZXRlcnMsIGFkZCBhIHN0cnVjdHVyZQo+Pj4gdnJpbmdfcGFja2VkLgo+Pj4KPj4+IFRoaXMg
ZmVhdHVyZSBpcyByZXF1aXJlZCBmb3Igc3Vic2VxdWVudCB2aXJ0dXF1ZXVlIHJlc2V0IHZyaW5n
Lgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFi
YS5jb20+Cj4+IFN1YmplY3QgaGFzIGEgdHlwby4KPiBJIHdpbGwgZml4IGl0Lgo+Cj4+IEJlc2lk
ZXM6Cj4+Cj4+PiAtLS0KPj4+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDEyMSAr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQo+Pj4gICAxIGZpbGUgY2hhbmdlZCwg
OTIgaW5zZXJ0aW9ucygrKSwgMjkgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5j
Cj4+PiBpbmRleCBkYzYzMTNiNzkzMDUuLjQxODY0YzVlNjY1ZiAxMDA2NDQKPj4+IC0tLSBhL2Ry
aXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPj4+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmMKPj4+IEBAIC05Miw2ICs5MiwxOCBAQCBzdHJ1Y3QgdnJpbmdfc3BsaXQgewo+Pj4g
ICAJc3RydWN0IHZyaW5nIHZyaW5nOwo+Pj4gICB9Owo+Pj4KPj4+ICtzdHJ1Y3QgdnJpbmdfcGFj
a2VkIHsKPj4+ICsJdTMyIG51bTsKPj4+ICsJc3RydWN0IHZyaW5nX3BhY2tlZF9kZXNjICpyaW5n
Owo+Pj4gKwlzdHJ1Y3QgdnJpbmdfcGFja2VkX2Rlc2NfZXZlbnQgKmRyaXZlcjsKPj4+ICsJc3Ry
dWN0IHZyaW5nX3BhY2tlZF9kZXNjX2V2ZW50ICpkZXZpY2U7Cj4+PiArCWRtYV9hZGRyX3Qgcmlu
Z19kbWFfYWRkcjsKPj4+ICsJZG1hX2FkZHJfdCBkcml2ZXJfZXZlbnRfZG1hX2FkZHI7Cj4+PiAr
CWRtYV9hZGRyX3QgZGV2aWNlX2V2ZW50X2RtYV9hZGRyOwo+Pj4gKwlzaXplX3QgcmluZ19zaXpl
X2luX2J5dGVzOwo+Pj4gKwlzaXplX3QgZXZlbnRfc2l6ZV9pbl9ieXRlczsKPj4+ICt9Owo+Pj4g
Kwo+Pj4gICBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlIHsKPj4+ICAgCXN0cnVjdCB2aXJ0cXVldWUg
dnE7Cj4+Pgo+Pj4gQEAgLTE2ODMsNDUgKzE2OTUsMTAxIEBAIHN0YXRpYyBzdHJ1Y3QgdnJpbmdf
ZGVzY19leHRyYSAqdnJpbmdfYWxsb2NfZGVzY19leHRyYShzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVl
ICp2Cj4+PiAgIAlyZXR1cm4gZGVzY19leHRyYTsKPj4+ICAgfQo+Pj4KPj4+IC1zdGF0aWMgc3Ry
dWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9wYWNrZWQoCj4+PiAtCXVuc2ln
bmVkIGludCBpbmRleCwKPj4+IC0JdW5zaWduZWQgaW50IG51bSwKPj4+IC0JdW5zaWduZWQgaW50
IHZyaW5nX2FsaWduLAo+Pj4gLQlzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwKPj4+IC0JYm9v
bCB3ZWFrX2JhcnJpZXJzLAo+Pj4gLQlib29sIG1heV9yZWR1Y2VfbnVtLAo+Pj4gLQlib29sIGNv
bnRleHQsCj4+PiAtCWJvb2wgKCpub3RpZnkpKHN0cnVjdCB2aXJ0cXVldWUgKiksCj4+PiAtCXZv
aWQgKCpjYWxsYmFjaykoc3RydWN0IHZpcnRxdWV1ZSAqKSwKPj4+IC0JY29uc3QgY2hhciAqbmFt
ZSkKPj4+ICtzdGF0aWMgdm9pZCB2cmluZ19mcmVlX3ZyaW5nX3BhY2tlZChzdHJ1Y3QgdnJpbmdf
cGFja2VkICp2cmluZywKPj4+ICsJCQkJICAgIHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+
Pj4gK3sKPj4+ICsJZG1hX2FkZHJfdCByaW5nX2RtYV9hZGRyLCBkcml2ZXJfZXZlbnRfZG1hX2Fk
ZHIsIGRldmljZV9ldmVudF9kbWFfYWRkcjsKPj4+ICsJc3RydWN0IHZyaW5nX3BhY2tlZF9kZXNj
X2V2ZW50ICpkcml2ZXIsICpkZXZpY2U7Cj4+PiArCXNpemVfdCByaW5nX3NpemVfaW5fYnl0ZXMs
IGV2ZW50X3NpemVfaW5fYnl0ZXM7Cj4+PiArCXN0cnVjdCB2cmluZ19wYWNrZWRfZGVzYyAqcmlu
ZzsKPj4+ICsKPj4+ICsJcmluZyAgICAgICAgICAgICAgICAgID0gdnJpbmctPnJpbmc7Cj4+PiAr
CWRyaXZlciAgICAgICAgICAgICAgICA9IHZyaW5nLT5kcml2ZXI7Cj4+PiArCWRldmljZSAgICAg
ICAgICAgICAgICA9IHZyaW5nLT5kZXZpY2U7Cj4+PiArCXJpbmdfZG1hX2FkZHIgICAgICAgICA9
IHZyaW5nLT5yaW5nX3NpemVfaW5fYnl0ZXM7Cj4+PiArCWV2ZW50X3NpemVfaW5fYnl0ZXMgICA9
IHZyaW5nLT5ldmVudF9zaXplX2luX2J5dGVzOwo+Pj4gKwlyaW5nX2RtYV9hZGRyICAgICAgICAg
PSB2cmluZy0+cmluZ19kbWFfYWRkcjsKPj4+ICsJZHJpdmVyX2V2ZW50X2RtYV9hZGRyID0gdnJp
bmctPmRyaXZlcl9ldmVudF9kbWFfYWRkcjsKPj4+ICsJZGV2aWNlX2V2ZW50X2RtYV9hZGRyID0g
dnJpbmctPmRldmljZV9ldmVudF9kbWFfYWRkcjsKPj4+ICsKPj4+ICsJaWYgKGRldmljZSkKPj4+
ICsJCXZyaW5nX2ZyZWVfcXVldWUodmRldiwgZXZlbnRfc2l6ZV9pbl9ieXRlcywgZGV2aWNlLCBk
ZXZpY2VfZXZlbnRfZG1hX2FkZHIpOwo+Pj4gKwo+Pj4gKwlpZiAoZHJpdmVyKQo+Pj4gKwkJdnJp
bmdfZnJlZV9xdWV1ZSh2ZGV2LCBldmVudF9zaXplX2luX2J5dGVzLCBkcml2ZXIsIGRyaXZlcl9l
dmVudF9kbWFfYWRkcik7Cj4+PiArCj4+PiArCWlmIChyaW5nKQo+Pj4gKwkJdnJpbmdfZnJlZV9x
dWV1ZSh2ZGV2LCByaW5nX3NpemVfaW5fYnl0ZXMsIHJpbmcsIHJpbmdfZG1hX2FkZHIpOwo+PiBy
aW5nX3NpemVfaW5fYnl0ZXMgaXMgdW5pbml0aWFsaXplZCBoZXJlLgo+Pgo+PiBXaGljaCBiZWdz
IHRoZSBxdWVzdGlvbiBob3cgd2FzIHRoaXMgdGVzdGVkIHBhdGNoc2V0IGdlbmVyYWxseSBhbmQK
Pj4gdGhpcyBwYXRjaCBpbiBwYXJ0aWN1bGFyLgo+PiBQbGVhc2UgYWRkIG5vdGUgb24gdGVzdGVk
IGNvbmZpZ3VyYXRpb25zIGFuZCB0ZXN0cyBydW4gdG8gdGhlIHBhdGNoc2V0Lgo+IFNvcnJ5LCBt
eSBlbnZpcm9ubWVudCBpcyBydW5uaW5nIGluIHNwbGl0IG1vZGUuIEkgZGlkIG5vdCByZXRlc3Qg
dGhlIHBhY2tlZCBtb2RlCj4gYmVmb3JlIHNlbmRpbmcgcGF0Y2hlcy4gQmVjYXVzZSBteSBkcGRr
IHZob3N0LXVzZXIgaXMgbm90IGVhc3kgdG8gdXNlLCBJCj4gbmVlZCB0byBjaGFuZ2UgdGhlIGtl
cm5lbCBvZiB0aGUgaG9zdC4KPgo+IEkgd291bGQgbGlrZSB0byBhc2sgaWYgdGhlcmUgYXJlIG90
aGVyIGxpZ2h0d2VpZ2h0IGVudmlyb25tZW50cyB0aGF0IGNhbiBiZSB1c2VkCj4gdG8gdGVzdCBw
YWNrZWQgbW9kZS4KCgpZb3UgY2FuIHVzZSBRZW11J3MgZGF0YXBsYW5lLiBJdCBoYXMgc3VwcG9y
dCBmb3IgcGFja2VkIHZpcnRxdWV1ZS4KClRoYW5rcwoKCj4KPgo+IFRoYW5rcy4KPgo+Cj4+PiAr
fQo+Pj4gKwo+Pj4gK3N0YXRpYyBpbnQgdnJpbmdfY3JlYXRlX3ZyaW5nX3BhY2tlZChzdHJ1Y3Qg
dnJpbmdfcGFja2VkICp2cmluZywKPj4+ICsJCQkJICAgIHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2
ZGV2LAo+Pj4gKwkJCQkgICAgdTMyIG51bSkKPj4+ICAgewo+Pj4gLQlzdHJ1Y3QgdnJpbmdfdmly
dHF1ZXVlICp2cTsKPj4+ICAgCXN0cnVjdCB2cmluZ19wYWNrZWRfZGVzYyAqcmluZzsKPj4+ICAg
CXN0cnVjdCB2cmluZ19wYWNrZWRfZGVzY19ldmVudCAqZHJpdmVyLCAqZGV2aWNlOwo+Pj4gICAJ
ZG1hX2FkZHJfdCByaW5nX2RtYV9hZGRyLCBkcml2ZXJfZXZlbnRfZG1hX2FkZHIsIGRldmljZV9l
dmVudF9kbWFfYWRkcjsKPj4+ICAgCXNpemVfdCByaW5nX3NpemVfaW5fYnl0ZXMsIGV2ZW50X3Np
emVfaW5fYnl0ZXM7Cj4+Pgo+Pj4gKwltZW1zZXQodnJpbmcsIDAsIHNpemVvZigqdnJpbmcpKTsK
Pj4+ICsKPj4+ICAgCXJpbmdfc2l6ZV9pbl9ieXRlcyA9IG51bSAqIHNpemVvZihzdHJ1Y3QgdnJp
bmdfcGFja2VkX2Rlc2MpOwo+Pj4KPj4+ICAgCXJpbmcgPSB2cmluZ19hbGxvY19xdWV1ZSh2ZGV2
LCByaW5nX3NpemVfaW5fYnl0ZXMsCj4+PiAgIAkJCQkgJnJpbmdfZG1hX2FkZHIsCj4+PiAgIAkJ
CQkgR0ZQX0tFUk5FTHxfX0dGUF9OT1dBUk58X19HRlBfWkVSTyk7Cj4+PiAgIAlpZiAoIXJpbmcp
Cj4+PiAtCQlnb3RvIGVycl9yaW5nOwo+Pj4gKwkJZ290byBlcnI7Cj4+PiArCj4+PiArCXZyaW5n
LT5udW0gPSBudW07Cj4+PiArCXZyaW5nLT5yaW5nID0gcmluZzsKPj4+ICsJdnJpbmctPnJpbmdf
c2l6ZV9pbl9ieXRlcyA9IHJpbmdfc2l6ZV9pbl9ieXRlczsKPj4+ICsJdnJpbmctPnJpbmdfZG1h
X2FkZHIgPSByaW5nX2RtYV9hZGRyOwo+Pj4KPj4+ICAgCWV2ZW50X3NpemVfaW5fYnl0ZXMgPSBz
aXplb2Yoc3RydWN0IHZyaW5nX3BhY2tlZF9kZXNjX2V2ZW50KTsKPj4+ICsJdnJpbmctPmV2ZW50
X3NpemVfaW5fYnl0ZXMgPSBldmVudF9zaXplX2luX2J5dGVzOwo+Pj4KPj4+ICAgCWRyaXZlciA9
IHZyaW5nX2FsbG9jX3F1ZXVlKHZkZXYsIGV2ZW50X3NpemVfaW5fYnl0ZXMsCj4+PiAgIAkJCQkg
ICAmZHJpdmVyX2V2ZW50X2RtYV9hZGRyLAo+Pj4gICAJCQkJICAgR0ZQX0tFUk5FTHxfX0dGUF9O
T1dBUk58X19HRlBfWkVSTyk7Cj4+PiAgIAlpZiAoIWRyaXZlcikKPj4+IC0JCWdvdG8gZXJyX2Ry
aXZlcjsKPj4+ICsJCWdvdG8gZXJyOwo+Pj4gKwo+Pj4gKwl2cmluZy0+ZHJpdmVyID0gZHJpdmVy
Owo+Pj4gKwl2cmluZy0+ZHJpdmVyX2V2ZW50X2RtYV9hZGRyID0gZHJpdmVyX2V2ZW50X2RtYV9h
ZGRyOwo+Pj4KPj4+ICAgCWRldmljZSA9IHZyaW5nX2FsbG9jX3F1ZXVlKHZkZXYsIGV2ZW50X3Np
emVfaW5fYnl0ZXMsCj4+PiAgIAkJCQkgICAmZGV2aWNlX2V2ZW50X2RtYV9hZGRyLAo+Pj4gICAJ
CQkJICAgR0ZQX0tFUk5FTHxfX0dGUF9OT1dBUk58X19HRlBfWkVSTyk7Cj4+PiAgIAlpZiAoIWRl
dmljZSkKPj4+IC0JCWdvdG8gZXJyX2RldmljZTsKPj4+ICsJCWdvdG8gZXJyOwo+Pj4gKwo+Pj4g
Kwl2cmluZy0+ZGV2aWNlID0gZGV2aWNlOwo+Pj4gKwl2cmluZy0+ZGV2aWNlX2V2ZW50X2RtYV9h
ZGRyID0gZGV2aWNlX2V2ZW50X2RtYV9hZGRyOwo+Pj4gKwlyZXR1cm4gMDsKPj4+ICsKPj4+ICtl
cnI6Cj4+PiArCXZyaW5nX2ZyZWVfdnJpbmdfcGFja2VkKHZyaW5nLCB2ZGV2KTsKPj4+ICsJcmV0
dXJuIC1FTk9NRU07Cj4+PiArfQo+Pj4gKwo+Pj4gK3N0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2
cmluZ19jcmVhdGVfdmlydHF1ZXVlX3BhY2tlZCgKPj4+ICsJdW5zaWduZWQgaW50IGluZGV4LAo+
Pj4gKwl1bnNpZ25lZCBpbnQgbnVtLAo+Pj4gKwl1bnNpZ25lZCBpbnQgdnJpbmdfYWxpZ24sCj4+
PiArCXN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LAo+Pj4gKwlib29sIHdlYWtfYmFycmllcnMs
Cj4+PiArCWJvb2wgbWF5X3JlZHVjZV9udW0sCj4+PiArCWJvb2wgY29udGV4dCwKPj4+ICsJYm9v
bCAoKm5vdGlmeSkoc3RydWN0IHZpcnRxdWV1ZSAqKSwKPj4+ICsJdm9pZCAoKmNhbGxiYWNrKShz
dHJ1Y3QgdmlydHF1ZXVlICopLAo+Pj4gKwljb25zdCBjaGFyICpuYW1lKQo+Pj4gK3sKPj4+ICsJ
c3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnE7Cj4+PiArCXN0cnVjdCB2cmluZ19wYWNrZWQgdnJp
bmc7Cj4+PiArCj4+PiArCWlmICh2cmluZ19jcmVhdGVfdnJpbmdfcGFja2VkKCZ2cmluZywgdmRl
diwgbnVtKSkKPj4+ICsJCWdvdG8gZXJyX3ZxOwo+Pj4KPj4+ICAgCXZxID0ga21hbGxvYyhzaXpl
b2YoKnZxKSwgR0ZQX0tFUk5FTCk7Cj4+PiAgIAlpZiAoIXZxKQo+Pj4gQEAgLTE3NTMsMTcgKzE4
MjEsMTcgQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0cXVldWVf
cGFja2VkKAo+Pj4gICAJaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fRl9PUkRF
Ul9QTEFURk9STSkpCj4+PiAgIAkJdnEtPndlYWtfYmFycmllcnMgPSBmYWxzZTsKPj4+Cj4+PiAt
CXZxLT5wYWNrZWQucmluZ19kbWFfYWRkciA9IHJpbmdfZG1hX2FkZHI7Cj4+PiAtCXZxLT5wYWNr
ZWQuZHJpdmVyX2V2ZW50X2RtYV9hZGRyID0gZHJpdmVyX2V2ZW50X2RtYV9hZGRyOwo+Pj4gLQl2
cS0+cGFja2VkLmRldmljZV9ldmVudF9kbWFfYWRkciA9IGRldmljZV9ldmVudF9kbWFfYWRkcjsK
Pj4+ICsJdnEtPnBhY2tlZC5yaW5nX2RtYV9hZGRyID0gdnJpbmcucmluZ19kbWFfYWRkcjsKPj4+
ICsJdnEtPnBhY2tlZC5kcml2ZXJfZXZlbnRfZG1hX2FkZHIgPSB2cmluZy5kcml2ZXJfZXZlbnRf
ZG1hX2FkZHI7Cj4+PiArCXZxLT5wYWNrZWQuZGV2aWNlX2V2ZW50X2RtYV9hZGRyID0gdnJpbmcu
ZGV2aWNlX2V2ZW50X2RtYV9hZGRyOwo+Pj4KPj4+IC0JdnEtPnBhY2tlZC5yaW5nX3NpemVfaW5f
Ynl0ZXMgPSByaW5nX3NpemVfaW5fYnl0ZXM7Cj4+PiAtCXZxLT5wYWNrZWQuZXZlbnRfc2l6ZV9p
bl9ieXRlcyA9IGV2ZW50X3NpemVfaW5fYnl0ZXM7Cj4+PiArCXZxLT5wYWNrZWQucmluZ19zaXpl
X2luX2J5dGVzID0gdnJpbmcucmluZ19zaXplX2luX2J5dGVzOwo+Pj4gKwl2cS0+cGFja2VkLmV2
ZW50X3NpemVfaW5fYnl0ZXMgPSB2cmluZy5ldmVudF9zaXplX2luX2J5dGVzOwo+Pj4KPj4+ICAg
CXZxLT5wYWNrZWQudnJpbmcubnVtID0gbnVtOwo+Pj4gLQl2cS0+cGFja2VkLnZyaW5nLmRlc2Mg
PSByaW5nOwo+Pj4gLQl2cS0+cGFja2VkLnZyaW5nLmRyaXZlciA9IGRyaXZlcjsKPj4+IC0JdnEt
PnBhY2tlZC52cmluZy5kZXZpY2UgPSBkZXZpY2U7Cj4+PiArCXZxLT5wYWNrZWQudnJpbmcuZGVz
YyA9IHZyaW5nLnJpbmc7Cj4+PiArCXZxLT5wYWNrZWQudnJpbmcuZHJpdmVyID0gdnJpbmcuZHJp
dmVyOwo+Pj4gKwl2cS0+cGFja2VkLnZyaW5nLmRldmljZSA9IHZyaW5nLmRldmljZTsKPj4+Cj4+
PiAgIAl2cS0+cGFja2VkLm5leHRfYXZhaWxfaWR4ID0gMDsKPj4+ICAgCXZxLT5wYWNrZWQuYXZh
aWxfd3JhcF9jb3VudGVyID0gMTsKPj4+IEBAIC0xODA0LDEyICsxODcyLDcgQEAgc3RhdGljIHN0
cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0cXVldWVfcGFja2VkKAo+Pj4gICBlcnJf
ZGVzY19zdGF0ZToKPj4+ICAgCWtmcmVlKHZxKTsKPj4+ICAgZXJyX3ZxOgo+Pj4gLQl2cmluZ19m
cmVlX3F1ZXVlKHZkZXYsIGV2ZW50X3NpemVfaW5fYnl0ZXMsIGRldmljZSwgZGV2aWNlX2V2ZW50
X2RtYV9hZGRyKTsKPj4+IC1lcnJfZGV2aWNlOgo+Pj4gLQl2cmluZ19mcmVlX3F1ZXVlKHZkZXYs
IGV2ZW50X3NpemVfaW5fYnl0ZXMsIGRyaXZlciwgZHJpdmVyX2V2ZW50X2RtYV9hZGRyKTsKPj4+
IC1lcnJfZHJpdmVyOgo+Pj4gLQl2cmluZ19mcmVlX3F1ZXVlKHZkZXYsIHJpbmdfc2l6ZV9pbl9i
eXRlcywgcmluZywgcmluZ19kbWFfYWRkcik7Cj4+PiAtZXJyX3Jpbmc6Cj4+PiArCXZyaW5nX2Zy
ZWVfdnJpbmdfcGFja2VkKCZ2cmluZywgdmRldik7Cj4+PiAgIAlyZXR1cm4gTlVMTDsKPj4+ICAg
fQo+Pj4KPj4+IC0tCj4+PiAyLjMxLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
