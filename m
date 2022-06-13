Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8DBC433EF
	for <virtualization@archiver.kernel.org>; Mon, 13 Jun 2022 14:04:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 116FA4092A;
	Mon, 13 Jun 2022 14:04:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vLEUQYuvWmwf; Mon, 13 Jun 2022 14:04:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6F50640913;
	Mon, 13 Jun 2022 14:04:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4EBB2C0039;
	Mon, 13 Jun 2022 14:04:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33C94C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 14:04:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 229C3401DD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 14:04:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7ziOtwYe8P5Q
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 14:04:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6673D400E9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 14:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655129091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HzSJ1rJzqacXFWLCNqeBWpjScX69mSzXcZnT032XYX0=;
 b=T5t6kLHQVM0C8lK4w/JuVnuTbco5Pi26LOs4Kpzd6USJSUisJn23UBjpJ4BUIhET7Re/nJ
 c6lhvdNXBV6/nowzB2DKTxye9HgtFlNuzDalkkHy8na3ofxpUjG7Nqv2BJ/z+Cr8sM+LL8
 VVxQWv9ZKtbpiJCREcjoY/0VsWKAXi0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-ogJO9YXbOW2ZLMFbPjXD_g-1; Mon, 13 Jun 2022 10:04:50 -0400
X-MC-Unique: ogJO9YXbOW2ZLMFbPjXD_g-1
Received: by mail-wr1-f72.google.com with SMTP id
 n5-20020adf8b05000000b00219ece7272bso773110wra.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 07:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=HzSJ1rJzqacXFWLCNqeBWpjScX69mSzXcZnT032XYX0=;
 b=lAnarP6469StGfbR52bxus+4eN7SgyeL0zpON9CvHhpiach6QscJ15MVwpWBV03Lib
 8eovZIxEHKGRGCfKpNXauv1IXOD7UwlEQPYybbzKuofoKfU+fsZSVj5Apz3GDLEwsB2r
 V8hK/NLjpMSAw97nPSSIeUM5ddbMr4PLwj5XdjtMnBS894tMNGHY759Xrj+tLDhtqYWo
 3WFLOZnV3NS7nqmVR2k7ndnSnEL6ZJOfAzSWnquHLu4++yETzF430wet33XCQd/+WlN5
 FnWBZjanyq0UJNc/UwIMY9UCMN1UwgktZL3Zcvzzw5Ll8Gj89EthTf/i25H/UGhUhDfx
 SW6Q==
X-Gm-Message-State: AJIora8AYUhbWFb5FsgWcVwCFPiOkFwH7kac/lZkLlwhBueKA99uevTa
 MQpiaumk7afFjV18qVos7v5j9qq2qkt59EPMxQspAG76gZ8ZrukzmQqG+8hVWPpJJv6NPJYvKVl
 Szjvd0d7KizeLjrJndoIviV3NmQe8+cTlYrIK0Rj6iA==
X-Received: by 2002:a05:6000:186e:b0:218:5f5d:9c55 with SMTP id
 d14-20020a056000186e00b002185f5d9c55mr70623wri.128.1655129088704; 
 Mon, 13 Jun 2022 07:04:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vhoRex5Bwx+c1+KYIJCwZCrABnFWyMataP8w6xAqnGn9CI8bz/GhsgdDnhR8K4D1z6008ZwQ==
X-Received: by 2002:a05:6000:186e:b0:218:5f5d:9c55 with SMTP id
 d14-20020a056000186e00b002185f5d9c55mr70594wri.128.1655129088389; 
 Mon, 13 Jun 2022 07:04:48 -0700 (PDT)
Received: from redhat.com ([2.53.9.208]) by smtp.gmail.com with ESMTPSA id
 q7-20020a056000136700b0020c6b78eb5asm8592203wrz.68.2022.06.13.07.04.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jun 2022 07:04:47 -0700 (PDT)
Date: Mon, 13 Jun 2022 10:04:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio_ring : fix vring_packed_desc memory out of bounds
 bug
Message-ID: <20220613100433-mutt-send-email-mst@kernel.org>
References: <20220610103314.61577-1-huangjie.albert@bytedance.com>
 <20220610103905-mutt-send-email-mst@kernel.org>
 <CACGkMEuTv6HMrKJE9w2y8SJ8cAx6XBSqRxVXgRBrkN7uP3S1pg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuTv6HMrKJE9w2y8SJ8cAx6XBSqRxVXgRBrkN7uP3S1pg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "huangjie.albert" <huangjie.albert@bytedance.com>,
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

T24gTW9uLCBKdW4gMTMsIDIwMjIgYXQgMDI6NTY6MTlQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBGcmksIEp1biAxMCwgMjAyMiBhdCAxMDo1MSBQTSBNaWNoYWVsIFMuIFRzaXJraW4g
PG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBGcmksIEp1biAxMCwgMjAyMiBhdCAw
NjozMzoxNFBNICswODAwLCBodWFuZ2ppZS5hbGJlcnQgd3JvdGU6Cj4gPiA+IGtzb2Z0aXJxZCBt
YXkgY29uc3VtZSB0aGUgcGFja2V0IGFuZCBpdCB3aWxsIGNhbGw6Cj4gPiA+IHZpcnRuZXRfcG9s
bAo+ID4gPiAgICAgICAtLT52aXJ0bmV0X3JlY2VpdmUKPiA+ID4gICAgICAgICAgICAgICAtLT52
aXJ0cXVldWVfZ2V0X2J1Zl9jdHgKPiA+ID4gICAgICAgICAgICAgICAgICAgICAgIC0tPnZpcnRx
dWV1ZV9nZXRfYnVmX2N0eF9wYWNrZWQKPiA+ID4gYW5kIGluIHZpcnRxdWV1ZV9nZXRfYnVmX2N0
eF9wYWNrZWQ6Cj4gPiA+Cj4gPiA+IHZxLT5sYXN0X3VzZWRfaWR4ICs9IHZxLT5wYWNrZWQuZGVz
Y19zdGF0ZVtpZF0ubnVtOwo+ID4gPiBpZiAodW5saWtlbHkodnEtPmxhc3RfdXNlZF9pZHggPj0g
dnEtPnBhY2tlZC52cmluZy5udW0pKSB7Cj4gPiA+ICAgICAgICAgIHZxLT5sYXN0X3VzZWRfaWR4
IC09IHZxLT5wYWNrZWQudnJpbmcubnVtOwo+ID4gPiAgICAgICAgICB2cS0+cGFja2VkLnVzZWRf
d3JhcF9jb3VudGVyIF49IDE7Cj4gPiA+IH0KPiA+ID4KPiA+ID4gaWYgYXQgdGhlIHNhbWUgdGlt
ZSwgdGhlcmUgY29tZXMgYSB2cmluZyBpbnRlcnJ1cHTvvIxpbiB2cmluZ19pbnRlcnJ1cHQ6Cj4g
PiA+IHdlIHdpbGwgY2FsbDoKPiA+ID4gdnJpbmdfaW50ZXJydXB0Cj4gPiA+ICAgICAgIC0tPm1v
cmVfdXNlZAo+ID4gPiAgICAgICAgICAgICAgIC0tPm1vcmVfdXNlZF9wYWNrZWQKPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAgIC0tPmlzX3VzZWRfZGVzY19wYWNrZWQKPiA+ID4gaW4gaXNfdXNl
ZF9kZXNjX3BhY2tlZCwgdGhlIGxhc3RfdXNlZF9pZHggbWF5YmUgPj0gdnEtPnBhY2tlZC52cmlu
Zy5udW0uCj4gPiA+IHNvIHRoaXMgY291bGQgY2FzZSBhIG1lbW9yeSBvdXQgb2YgYm91bmRzIGJ1
Zy4KPiA+ID4KPiA+ID4gdGhpcyBwYXRjaCBpcyB0byBmaXggdGhpcy4KPiA+ID4KPiA+ID4gU2ln
bmVkLW9mZi1ieTogaHVhbmdqaWUuYWxiZXJ0IDxodWFuZ2ppZS5hbGJlcnRAYnl0ZWRhbmNlLmNv
bT4KPiA+Cj4gPgo+ID4gVGhpcyBwYXR0ZXJuIHdhcyBhbHdheXMgaWZmeSwgYnV0IEkgZG9uJ3Qg
dGhpbmsgdGhlIHBhdGNoCj4gPiBpbXByb3ZlcyB0aGUgc2l0dWF0aW9uIG11Y2guIGxhc3RfdXNl
ZF9pZHggYW5kIHZxLT5wYWNrZWQudXNlZF93cmFwX2NvdW50ZXIKPiA+IGNhbiBzdGlsbCBnZXQg
b3V0IG9mIHN5bmMuCj4gPgo+ID4gTWF5YmUgcmVmYWN0b3IgY29kZSB0byBrZWVwIGV2ZXJ5dGhp
bmcgaW4gdnEtPmxhc3RfdXNlZF9pZHg/Cj4gPgo+ID4gSmFzb24gd2hhdCBpcyB5b3VyIHRha2U/
Cj4gCj4gSSB0aGluayB3ZSBjYW4gZG8gdGhpcyBzaW5jZSAxNmJpdC8zMmJpdCBvcGVyYXRpb25z
IGFyZSBndWFyYW50ZWVkIHRvIGJlIGF0b21pYy4KPiAKPiBUaGFua3MKCgpPSy4gV2hvJ3Mgd29y
a2luZyBvbiB0aGlzPwoKPiA+Cj4gPgo+ID4KPiA+Cj4gPgo+ID4gPiAtLS0KPiA+ID4gIGRyaXZl
cnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAzICsrKwo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKQo+ID4gPgo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmly
dGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+ID4gaW5kZXggMTNh
NzM0OGNlZGZmLi5kMmFiYmIzYTgxODcgMTAwNjQ0Cj4gPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlv
L3ZpcnRpb19yaW5nLmMKPiA+ID4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+
ID4gPiBAQCAtMTM5Nyw2ICsxMzk3LDkgQEAgc3RhdGljIGlubGluZSBib29sIGlzX3VzZWRfZGVz
Y19wYWNrZWQoY29uc3Qgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEsCj4gPiA+ICAgICAgIGJv
b2wgYXZhaWwsIHVzZWQ7Cj4gPiA+ICAgICAgIHUxNiBmbGFnczsKPiA+ID4KPiA+ID4gKyAgICAg
aWYgKGlkeCA+PSB2cS0+cGFja2VkLnZyaW5nLm51bSkKPiA+ID4gKyAgICAgICAgICAgICByZXR1
cm4gZmFsc2U7Cj4gPiA+ICsKPiA+ID4gICAgICAgZmxhZ3MgPSBsZTE2X3RvX2NwdSh2cS0+cGFj
a2VkLnZyaW5nLmRlc2NbaWR4XS5mbGFncyk7Cj4gPiA+ICAgICAgIGF2YWlsID0gISEoZmxhZ3Mg
JiAoMSA8PCBWUklOR19QQUNLRURfREVTQ19GX0FWQUlMKSk7Cj4gPiA+ICAgICAgIHVzZWQgPSAh
IShmbGFncyAmICgxIDw8IFZSSU5HX1BBQ0tFRF9ERVNDX0ZfVVNFRCkpOwo+ID4gPiAtLQo+ID4g
PiAyLjI3LjAKPiA+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
