Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6FBCD68ED
	for <virtualization@archiver.kernel.org>; Tue, 10 Oct 2023 06:41:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3735C81F51;
	Tue, 10 Oct 2023 06:41:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3735C81F51
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hjj+Fp5e
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1S4lYoID33_b; Tue, 10 Oct 2023 06:41:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 61EE381F4C;
	Tue, 10 Oct 2023 06:41:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 61EE381F4C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 287D3C0039;
	Tue, 10 Oct 2023 06:41:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E713AC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:41:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AEB6060BE3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:41:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AEB6060BE3
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hjj+Fp5e
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oCOaCTYCIUKj
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:41:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6863260BD0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:41:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6863260BD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696920113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PhXeBdCz5bUPjH/oKhut+ReRQy+ZsJSkhLrIqryDxKY=;
 b=Hjj+Fp5eifjwot2eHKqz0LUMaAKI2CxEBY0Rap3TnIG7teOWi+K4xo0E7mMNJp/3YJDnT4
 KTFSYiCW1FqKDR1YF9XtCWSD5SyQW3drPsj7y9dRdOs+Mjiv1jtbgh78iYmWgUteCrKkVV
 wc5f+rypMW7CHZ89aItl7IPS5LyvyXw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-fnLu9-TTM6i7ULfekpxwbQ-1; Tue, 10 Oct 2023 02:41:52 -0400
X-MC-Unique: fnLu9-TTM6i7ULfekpxwbQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-503c774fd61so4539097e87.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Oct 2023 23:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696920110; x=1697524910;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PhXeBdCz5bUPjH/oKhut+ReRQy+ZsJSkhLrIqryDxKY=;
 b=TmqMq7w6x+hZXYVdUvjx2m6yenpAZ7SPfKy33b6ysgifnpF67+iaN6o/7hFeXeL6Uc
 /7UcDpFYmCI6fiiOw9etil70LVUsrhCJivc84PvZXJkZ2QYDtG+fIoiRGeB221+9GnHg
 mg1dvDu0PEGcNTTeVH19tXYIZAU/j2dc56bjZNAVuj6UslySV5+zPdUAKMi/ns5eE7Hv
 ETXWXziQG6AhtKVK7emGTCn4yoaf/w88DIyAl55GhCf3PDrBcMbB3IX2yvxEkKlH4HXJ
 rrrEhhXp3QwA3wY8dpHCvnET6l+FRYGjykAXBsdkVnG/LTaOdBQR7WujDtqIVOi+R6T7
 T/bA==
X-Gm-Message-State: AOJu0YwCX+2J2k8rLG0c4VbKCwShnsU0w0e7lAt8R3uBM++LfUCnevm/
 4E0xwgYhJrWBTKKQkxvTos5ivljqQdGjd+GLV63fhetBLbo25Bcmcpb4vBnXcIFnFDsRHy4Ehtx
 igQo/7BylI+ORpEyLoAJa98CAQJvHRyp4q/x48ybtO/oKy57UFAIM6+XlZA==
X-Received: by 2002:a19:385c:0:b0:4fb:780d:2a49 with SMTP id
 d28-20020a19385c000000b004fb780d2a49mr12671595lfj.5.1696920110592; 
 Mon, 09 Oct 2023 23:41:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHKfq4H88bGdM5rsBJ4Sad3Rz6H9wDBB99hmboWDPzq8OOznvcbTmuRUzKl5TZgphpktlXnML8Qp9dL+GU95A=
X-Received: by 2002:a19:385c:0:b0:4fb:780d:2a49 with SMTP id
 d28-20020a19385c000000b004fb780d2a49mr12671588lfj.5.1696920110245; Mon, 09
 Oct 2023 23:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231010031120.81272-1-xuanzhuo@linux.alibaba.com>
 <20231010031120.81272-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231010031120.81272-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Oct 2023 14:41:39 +0800
Message-ID: <CACGkMEtChiwWV7KPLTJ=GqxT24YJh7oXoE2JbpwWMPJE9053qA@mail.gmail.com>
Subject: Re: [PATCH vhost v3 3/4] virtio_pci: add check for common cfg size
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVHVlLCBPY3QgMTAsIDIwMjMgYXQgMTE6MTHigK9BTSBYdWFuIFpodW8gPHh1YW56aHVvQGxp
bnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IFNvbWUgYnVnZ3kgZGV2aWNlcywgdGhlIGNvbW1v
biBjZmcgc2l6ZSBtYXkgbm90IG1hdGNoIHRoZSBmZWF0dXJlcy4KPgo+IFRoaXMgcGF0Y2ggY2hl
Y2tzIHRoZSBjb21tb24gY2ZnIHNpemUgZm9yIHRoZQo+IGZlYXR1cmVzKFZJUlRJT19GX05PVElG
X0NPTkZJR19EQVRBLCBWSVJUSU9fRl9SSU5HX1JFU0VUKS4gV2hlbiB0aGUKPiBjb21tb24gY2Zn
IHNpemUgZG9lcyBub3QgbWF0Y2ggdGhlIGNvcnJlc3BvbmRpbmcgZmVhdHVyZSwgd2UgZmFpbCB0
aGUKPiBwcm9iZSBhbmQgcHJpbnQgZXJyb3IgbWVzc2FnZS4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1
YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvdmly
dGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMgICAgIHwgMzYgKysrKysrKysrKysrKysrKysrKysrKysr
KysKPiAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm5fZGV2LmMgfCAgMiArLQo+ICBp
bmNsdWRlL2xpbnV4L3ZpcnRpb19wY2lfbW9kZXJuLmggICAgICB8ICAxICsKPiAgMyBmaWxlcyBj
aGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4uYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b19wY2lfbW9kZXJuLmMKPiBpbmRleCBkNmJiNjhiYTg0ZTUuLjZhOGY1ZmYwNTYzNiAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybi5jCj4gKysrIGIvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4uYwo+IEBAIC0zOSw2ICszOSwzOSBAQCBzdGF0aWMg
dm9pZCB2cF90cmFuc3BvcnRfZmVhdHVyZXMoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsIHU2
NCBmZWF0dXJlcykKPiAgICAgICAgICAgICAgICAgX192aXJ0aW9fc2V0X2JpdCh2ZGV2LCBWSVJU
SU9fRl9SSU5HX1JFU0VUKTsKPiAgfQo+Cj4gK3N0YXRpYyBpbnQgX192cF9jaGVja19jb21tb25f
c2l6ZV9vbmVfZmVhdHVyZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwgdTMyIGZiaXQsCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1MzIgb2Zmc2V0LCBj
b25zdCBjaGFyICpmbmFtZSkKPiArewo+ICsgICAgICAgc3RydWN0IHZpcnRpb19wY2lfZGV2aWNl
ICp2cF9kZXYgPSB0b192cF9kZXZpY2UodmRldik7Cj4gKwo+ICsgICAgICAgaWYgKCFfX3ZpcnRp
b190ZXN0X2JpdCh2ZGV2LCBmYml0KSkKPiArICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4gKwo+
ICsgICAgICAgaWYgKGxpa2VseSh2cF9kZXYtPm1kZXYuY29tbW9uX2xlbiA+PSBvZmZzZXQpKQo+
ICsgICAgICAgICAgICAgICByZXR1cm4gMDsKPiArCj4gKyAgICAgICBkZXZfZXJyKCZ2ZGV2LT5k
ZXYsCj4gKyAgICAgICAgICAgICAgICJ2aXJ0aW86IGNvbW1vbiBjZmcgc2l6ZSglbGQpIGRvZXMg
bm90IG1hdGNoIHRoZSBmZWF0dXJlICVzXG4iLAo+ICsgICAgICAgICAgICAgICB2cF9kZXYtPm1k
ZXYuY29tbW9uX2xlbiwgZm5hbWUpOwo+ICsKPiArICAgICAgIHJldHVybiAtRUlOVkFMOwo+ICt9
Cj4gKwo+ICsjZGVmaW5lIHZwX2NoZWNrX2NvbW1vbl9zaXplX29uZV9mZWF0dXJlKHZkZXYsIGZi
aXQsIGZpZWxkKSBcCj4gKyAgICAgICBfX3ZwX2NoZWNrX2NvbW1vbl9zaXplX29uZV9mZWF0dXJl
KHZkZXYsIGZiaXQsIFwKPiArICAgICAgICAgICAgICAgb2Zmc2V0b2ZlbmQoc3RydWN0IHZpcnRp
b19wY2lfbW9kZXJuX2NvbW1vbl9jZmcsIGZpZWxkKSwgI2ZiaXQpCj4gKwo+ICtzdGF0aWMgaW50
IHZwX2NoZWNrX2NvbW1vbl9zaXplKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ICt7Cj4g
KyAgICAgICBpZiAodnBfY2hlY2tfY29tbW9uX3NpemVfb25lX2ZlYXR1cmUodmRldiwgVklSVElP
X0ZfTk9USUZfQ09ORklHX0RBVEEsIHF1ZXVlX25vdGlmeV9kYXRhKSkKPiArICAgICAgICAgICAg
ICAgcmV0dXJuIC1FSU5WQUw7Cj4gKwo+ICsgICAgICAgaWYgKHZwX2NoZWNrX2NvbW1vbl9zaXpl
X29uZV9mZWF0dXJlKHZkZXYsIFZJUlRJT19GX1JJTkdfUkVTRVQsIHF1ZXVlX3Jlc2V0KSkKPiAr
ICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7CgpEbyB3ZSBuZWVkIHRvIGF0IGxlYXN0IGNo
ZWNrIHRoZSBvZmZzZXQgb2YgdGhlIHF1ZXVlX2RldmljZSBhcyB3ZWxsIGhlcmU/CgpUaGFua3MK
Cj4gKwo+ICsgICAgICAgcmV0dXJuIDA7Cj4gK30KPiArCj4gIC8qIHZpcnRpbyBjb25maWctPmZp
bmFsaXplX2ZlYXR1cmVzKCkgaW1wbGVtZW50YXRpb24gKi8KPiAgc3RhdGljIGludCB2cF9maW5h
bGl6ZV9mZWF0dXJlcyhzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiAgewo+IEBAIC01Nyw2
ICs5MCw5IEBAIHN0YXRpYyBpbnQgdnBfZmluYWxpemVfZmVhdHVyZXMoc3RydWN0IHZpcnRpb19k
ZXZpY2UgKnZkZXYpCj4gICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+ICAgICAgICAg
fQo+Cj4gKyAgICAgICBpZiAodnBfY2hlY2tfY29tbW9uX3NpemUodmRldikpCj4gKyAgICAgICAg
ICAgICAgIHJldHVybiAtRUlOVkFMOwo+ICsKPiAgICAgICAgIHZwX21vZGVybl9zZXRfZmVhdHVy
ZXMoJnZwX2Rldi0+bWRldiwgdmRldi0+ZmVhdHVyZXMpOwo+Cj4gICAgICAgICByZXR1cm4gMDsK
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm5fZGV2LmMgYi9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybl9kZXYuYwo+IGluZGV4IDljYjYwMWUxNjY4
OC4uMzNmMzE5ZGExNTU4IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lf
bW9kZXJuX2Rldi5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm5fZGV2
LmMKPiBAQCAtMjkyLDcgKzI5Miw3IEBAIGludCB2cF9tb2Rlcm5fcHJvYmUoc3RydWN0IHZpcnRp
b19wY2lfbW9kZXJuX2RldmljZSAqbWRldikKPiAgICAgICAgIG1kZXYtPmNvbW1vbiA9IHZwX21v
ZGVybl9tYXBfY2FwYWJpbGl0eShtZGV2LCBjb21tb24sCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBzaXplb2Yoc3RydWN0IHZpcnRpb19wY2lfY29tbW9uX2NmZyksIDQs
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwLCBzaXplb2Yoc3RydWN0
IHZpcnRpb19wY2lfbW9kZXJuX2NvbW1vbl9jZmcpLAo+IC0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgTlVMTCwgTlVMTCk7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAmbWRldi0+Y29tbW9uX2xlbiwgTlVMTCk7Cj4gICAgICAgICBpZiAoIW1kZXYt
PmNvbW1vbikKPiAgICAgICAgICAgICAgICAgZ290byBlcnJfbWFwX2NvbW1vbjsKPiAgICAgICAg
IG1kZXYtPmlzciA9IHZwX21vZGVybl9tYXBfY2FwYWJpbGl0eShtZGV2LCBpc3IsIHNpemVvZih1
OCksIDEsCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rlcm4uaCBi
L2luY2x1ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rlcm4uaAo+IGluZGV4IDA2N2FjMWQ3ODliYy4u
ZWRmNjJiYWUwNDc0IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rl
cm4uaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rlcm4uaAo+IEBAIC0yOCw2
ICsyOCw3IEBAIHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9kZXZpY2Ugewo+ICAgICAgICAgLyog
U28gd2UgY2FuIHNhbml0eS1jaGVjayBhY2Nlc3Nlcy4gKi8KPiAgICAgICAgIHNpemVfdCBub3Rp
ZnlfbGVuOwo+ICAgICAgICAgc2l6ZV90IGRldmljZV9sZW47Cj4gKyAgICAgICBzaXplX3QgY29t
bW9uX2xlbjsKPgo+ICAgICAgICAgLyogQ2FwYWJpbGl0eSBmb3Igd2hlbiB3ZSBuZWVkIHRvIG1h
cCBub3RpZmljYXRpb25zIHBlci12cS4gKi8KPiAgICAgICAgIGludCBub3RpZnlfbWFwX2NhcDsK
PiAtLQo+IDIuMzIuMC4zLmcwMTE5NWNmOWYKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
