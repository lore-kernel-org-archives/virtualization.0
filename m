Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CA1C433EF
	for <virtualization@archiver.kernel.org>; Mon, 13 Jun 2022 06:59:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D04B660ED5;
	Mon, 13 Jun 2022 06:59:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r6vMNEI2ctNS; Mon, 13 Jun 2022 06:59:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 78A4A60E2D;
	Mon, 13 Jun 2022 06:59:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C2F7C0032;
	Mon, 13 Jun 2022 06:59:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59A29C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 06:59:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 35EB741676
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 06:59:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b3Qj0G11cpiA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 06:59:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1E03241655
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 06:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655103543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oVRFLE7RGwK5y8lRXbnI7Xv89WxvPuxuOeVilE+WukU=;
 b=fcsBhc7jwweQcWzu73KSCH6X6gKwLJBhzsl13CSzPvp++7OqZTQKbz/iWnLw/hv9na1YPn
 o4lBWgNYS/d5p9ZfSBYNVgAEpqPvIcTWcc06NHyDihtwsC88lJC2HTU8e1CS1/cshNn+PA
 3UvAwRyfAlyhZD1CV1JjjLS6xezI7a4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154-yJBONUP7OOuyXqVszVa2rg-1; Mon, 13 Jun 2022 02:59:00 -0400
X-MC-Unique: yJBONUP7OOuyXqVszVa2rg-1
Received: by mail-ed1-f72.google.com with SMTP id
 f9-20020a056402354900b0042ded146259so3389107edd.20
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Jun 2022 23:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=oVRFLE7RGwK5y8lRXbnI7Xv89WxvPuxuOeVilE+WukU=;
 b=GREE9HqNQBdcp9sRIAPiLJk0Vu5sbYjb8rHEmH5zl14bT4MBgObEjMKVjJzVjwx/Gm
 65p6pYS2wDtqFxhaMYJRVqaQ7PFc85WP2e0P6vtrrGy6kHGVzct66dJso7y0VQP6p8UO
 /PbIHetthtJK3OJ1Swkn4Qv8EMGMn2HhWTEeGUC/Ez/1RDmHe1UBW51qdUZ2H4/p6o62
 jfObtBEK0LgOxHs5JJQHx1akx1+kzAeJOflyspinWrCfBCT3PkBll3nHXHunRZT0tn7W
 mwLxtexASITeiX+cSKWvJT8ey3sUHQ482S+edOlEfZQMiw7LjZh9QMgA8WGU1Cez/Imm
 ma9A==
X-Gm-Message-State: AOAM530GiMWUgKR6tBbwIGQ/X1R1j7TUZSAdKU+9TNdgLf6TLa6SJTOr
 GpywIAMkg/PZWfEDajhX26vvPDMMIiM88aw7OE7jH9r3/lJGnVHpb58vv77r/dPE7hmkIH6ZrMz
 GMWeAkb8d0PRxRNZPeB4x97DqcONJ/GPKxdmtFN7l6w==
X-Received: by 2002:a17:906:73cc:b0:715:76d0:861f with SMTP id
 n12-20020a17090673cc00b0071576d0861fmr7737524ejl.279.1655103539078; 
 Sun, 12 Jun 2022 23:58:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKr+VY6PAYpH+B8olrglxv2z4tvg1IqCD623zp9Wy7HhMX5YZn9U2e/hO9mTyMzbfA9vuToA==
X-Received: by 2002:a17:906:73cc:b0:715:76d0:861f with SMTP id
 n12-20020a17090673cc00b0071576d0861fmr7737519ejl.279.1655103538884; 
 Sun, 12 Jun 2022 23:58:58 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:107c:be5a:1a30:9f6d:4400:4adc])
 by smtp.gmail.com with ESMTPSA id
 14-20020a170906328e00b006fee961b9e0sm3405436ejw.195.2022.06.12.23.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jun 2022 23:58:58 -0700 (PDT)
Date: Mon, 13 Jun 2022 02:58:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Bluetooth: virtio_bt: fix device removal
Message-ID: <20220613025539-mutt-send-email-mst@kernel.org>
References: <20211125174200.133230-1-mst@redhat.com>
 <F52F65FE-6A07-486B-8E84-684ED85709E9@holtmann.org>
 <20211209162149-mutt-send-email-mst@kernel.org>
 <20211213054357-mutt-send-email-mst@kernel.org>
 <20211213185620-mutt-send-email-mst@kernel.org>
 <FF8BA713-6DD2-485B-9ADC-02006126BC60@holtmann.org>
 <20220114151142-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220114151142-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-bluetooth@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Johan Hedberg <johan.hedberg@gmail.com>
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

T24gRnJpLCBKYW4gMTQsIDIwMjIgYXQgMDM6MTI6NDdQTSAtMDUwMCwgTWljaGFlbCBTLiBUc2ly
a2luIHdyb3RlOgo+IE9uIFRodSwgRGVjIDE2LCAyMDIxIGF0IDA4OjU4OjMxUE0gKzAxMDAsIE1h
cmNlbCBIb2x0bWFubiB3cm90ZToKPiA+IEhpIE1pY2hhZWwsCj4gPiAKPiA+ID4+Pj4+IERldmlj
ZSByZW1vdmFsIGlzIGNsZWFybHkgb3V0IG9mIHZpcnRpbyBzcGVjOiBpdCBhdHRlbXB0cyB0byBy
ZW1vdmUKPiA+ID4+Pj4+IHVudXNlZCBidWZmZXJzIGZyb20gYSBWUSBiZWZvcmUgaW52b2tpbmcg
ZGV2aWNlIHJlc2V0LiBUbyBmaXgsIG1ha2UKPiA+ID4+Pj4+IG9wZW4vY2xvc2UgTk9QcyBhbmQg
ZG8gYWxsIGNsZWFudXAvc2V0dXAgaW4gcHJvYmUvcmVtb3ZlLgo+ID4gPj4+PiAKPiA+ID4+Pj4g
c28gdGhlIHZpcnRidF97b3BlbixjbG9zZX0gYXMgTk9QIGlzIG5vdCByZWFsbHkgd2hhdCBhIGRy
aXZlciBpcyBzdXBwb3NlCj4gPiA+Pj4+IHRvIGJlIGRvaW5nLiBUaGVzZSBhcmUgdHJhbnNwb3J0
IGVuYWJsZS9kaXNhYmxlIGNhbGxiYWNrcyBmcm9tIHRoZSBCVAo+ID4gPj4+PiBDb3JlIHRvd2Fy
ZHMgdGhlIGRyaXZlci4gSXQgbWFwcyB0byBhIGRldmljZSBiZWluZyBlbmFibGVkL2Rpc2FibGVk
IGJ5Cj4gPiA+Pj4+IHNvbWV0aGluZyBsaWtlIGJsdWV0b290aGQgZm9yIGV4YW1wbGUuIFNvIGlm
IGRpc2FibGVkLCBJIGV4cGVjdCB0aGF0IG5vCj4gPiA+Pj4+IHJlc291cmNlcy9xdWV1ZXMgYXJl
IGluIHVzZS4KPiA+ID4+Pj4gCj4gPiA+Pj4+IE1heWJlIEkgbWlzdW5kZXJzdGFuZCB0aGUgdmly
dGlvIHNwZWMgaW4gdGhhdCByZWdhcmQsIGJ1dCBJIHdvdWxkIGxpa2UKPiA+ID4+Pj4gdG8ga2Vl
cCB0aGlzIGZ1bmRhbWVudGFsIGNvbmNlcHQgb2YgYSBCbHVldG9vdGggZHJpdmVyLiBJdCBkb2Vz
IHdvcmsKPiA+ID4+Pj4gd2l0aCBhbGwgb3RoZXIgdHJhbnNwb3J0cyBsaWtlIFVTQiwgU0RJTywg
VUFSVCBldGMuCj4gPiA+Pj4+IAo+ID4gPj4+Pj4gVGhlIGNvc3QgaGVyZSBpcyBhIHNpbmdsZSBz
a2Igd2FzdGVkIG9uIGFuIHVudXNlZCBidCBkZXZpY2UgLSB3aGljaAo+ID4gPj4+Pj4gc2VlbXMg
bW9kZXN0Lgo+ID4gPj4+PiAKPiA+ID4+Pj4gVGhlcmUgc2hvdWxkIGJlIG5vIGJ1ZmZlciB1c2Vk
IGlmIHRoZSBkZXZpY2UgaXMgcG93ZXJlZCBvZmYuIFdlIGFsc28gZG9u4oCZdAo+ID4gPj4+PiBo
YXZlIGFueSBVU0IgVVJCcyBpbi1mbGlnaHQgaWYgdGhlIHRyYW5zcG9ydCBpcyBub3QgYWN0aXZl
Lgo+ID4gPj4+PiAKPiA+ID4+Pj4+IE5COiB3aXRoIHRoaXMgZml4IGluIHBsYWNlIGRyaXZlciBz
dGlsbCBzdWZmZXJzIGZyb20gYSByYWNlIGNvbmRpdGlvbiBpZgo+ID4gPj4+Pj4gYW4gaW50ZXJy
dXB0IHRyaWdnZXJzIHdoaWxlIGRldmljZSBpcyBiZWluZyByZXNldC4gV29yayBvbiBhIGZpeCBm
b3IKPiA+ID4+Pj4+IHRoYXQgaXNzdWUgaXMgaW4gcHJvZ3Jlc3MuCj4gPiA+Pj4+IAo+ID4gPj4+
PiBJbiB0aGUgdmlydGJ0X2Nsb3NlKCkgY2FsbGJhY2sgd2Ugc2hvdWxkIGRlYWN0aXZhdGUgYWxs
IGludGVycnVwdHMuCj4gPiA+Pj4+IAo+ID4gPj4+PiBSZWdhcmRzCj4gPiA+Pj4+IAo+ID4gPj4+
PiBNYXJjZWwKPiA+ID4+PiAKPiA+ID4+PiBTbyBNYXJjZWwsIGRvIEkgcmVhZCBpdCByaWdodCB0
aGF0IHlvdSBhcmUgd29ya2luZyBvbiBhIGZpeAo+ID4gPj4+IGFuZCBJIGNhbiBkcm9wIHRoaXMg
cGF0Y2ggZm9yIG5vdz8KPiA+ID4+IAo+ID4gPj4gcGluZwo+ID4gPiAKPiA+ID4gCj4gPiA+IElm
IEkgZG9uJ3QgaGVhciBvdGhlcndpc2UgSSdsbCBxdWV1ZSBteSB2ZXJzaW9uIC0gaXQgbWlnaHQg
bm90Cj4gPiA+IGJlIGlkZWFsIGJ1dCBpdCBhdCBsZWFzdCBkb2VzIG5vdCB2aW9sYXRlIHRoZSBz
cGVjLgo+ID4gPiBXZSBjYW4gd29yayBvbiBub3QgYWxsb2NhdGluZy9mcmVlaW5nIGJ1ZmZlcnMg
bGF0ZXIKPiA+ID4gYXMgYXBwcm9wcmlhdGUuCj4gPiAKPiA+IEkgaGF2ZSBhIHBhdGNoLCBidXQg
aXQgaXMgbm90IGZ1bGx5IHRlc3RlZCB5ZXQuCj4gPiAKPiA+IFJlZ2FyZHMKPiA+IAo+ID4gTWFy
Y2VsCj4gCj4gcGluZwo+IAo+IGl0J3MgYmVlbiBhIG1vbnRoIC4uLgo+IAo+IEknbSB3b3JraW5n
IG9uIGNsZWFuaW5nIHVwIG1vZHVsZS9kZXZpY2UgcmVtb3ZhbCBpbiB2aXJ0aW8gYW5kIGJ0Cj4g
aXMga2luZCBvZiBzdGlja2luZyBvdXQuCgpJIGFtIGluY2xpbmVkIHRvIG1ha2UgdGhpcyBkcml2
ZXIgZGVwZW5kIG9uIEJST0tFTiBmb3Igbm93LgpBbnkgb2JqZWN0aW9ucz8KCgo+IC0tIAo+IE1T
VAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
