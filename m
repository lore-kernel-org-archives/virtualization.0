Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2A6C433DF
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 11:40:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E52CE2070A
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 11:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nkvz0Tb+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52CE2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C57E98817F;
	Wed,  5 Aug 2020 11:40:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2JL2JVZpJzHU; Wed,  5 Aug 2020 11:40:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 47D3588179;
	Wed,  5 Aug 2020 11:40:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24F99C0051;
	Wed,  5 Aug 2020 11:40:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 407E0C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 11:40:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2E6C22044E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 11:40:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SdLOKbpE9NSg
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 11:40:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-1.mimecast.com [205.139.110.61])
 by silver.osuosl.org (Postfix) with ESMTPS id 528E5207A2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 11:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596627622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lad+l1QsVGACWdbh/Js4EqT43VIKUvJSAKVohar8Uec=;
 b=Nkvz0Tb+jOHNjblgQx8X+EkJWTxgW2oAFEjxssHdqHhYzKxT1ZR+AqsabSNUnlD4+hyaPn
 R34/bisFHNa7NzNuNKaX9JJRckNMMVHzPs9wf5vUoaZdkvrn1FR2MZH8aErhnn+3AtFIFs
 IJSYjJryaVB+xQqbITHuVs6YADWb2Qc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-6bgOI08wMQiWqvY-y6Vhlw-1; Wed, 05 Aug 2020 07:40:20 -0400
X-MC-Unique: 6bgOI08wMQiWqvY-y6Vhlw-1
Received: by mail-wr1-f71.google.com with SMTP id e14so10013809wrr.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 04:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=lad+l1QsVGACWdbh/Js4EqT43VIKUvJSAKVohar8Uec=;
 b=KfXiivCl2k3F3Sge9Peg0p5IuaLQpAxuesdYCCyT0A+BYkQv+lB+APJHTKFkGyBFJf
 mFB3DPMmJyU++gqOIHQ2L7B9ZB0sNqH1IFJNlsfS6kA7qBAwP/jftNzv+3mZtkl+O7P/
 xDGuUXuakFpORJzUD4CLUuo2gw3/4+bUB9zqAIzaJ1y/0KIIKX0vxTIx5ht8T2BYSiW+
 oTcsWd9fOeIwLeUWF2EJYxSh5WYpYGkQuDfHtV5yod1+nU/R6PGiupfuXY7GdkIe2ee1
 ClxiFhCmLNo6lYjSohSKC1uRytzpMFTcaxXviLDzI+OgxgcOTMn42tJU0fdD1TvwLDPq
 VSzw==
X-Gm-Message-State: AOAM532wBTmDPhHg2S98c4sur9P4f5Wt4esqcyXnFW4/4O2hx16Tn7Uu
 S5ZOZqwF+n5sVsyfO0eWxgOQNE37sAUWQv9NxuCYFxkX8pVaN4r6cniYdI2Bpgf0sFd8QWj96Nn
 6QlDITya66Ocs14+cvxTCIzuTR7YBzOUK2s718Be5UA==
X-Received: by 2002:a05:600c:2154:: with SMTP id
 v20mr2905539wml.186.1596627619070; 
 Wed, 05 Aug 2020 04:40:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzLUhNKsFdDJV97Qke7oWTu+zTzIxWpF7w4wMB3AJ3toR2KxppLas4gqRP9GzEle7rmm20eQ==
X-Received: by 2002:a05:600c:2154:: with SMTP id
 v20mr2905517wml.186.1596627618867; 
 Wed, 05 Aug 2020 04:40:18 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
 by smtp.gmail.com with ESMTPSA id
 d14sm2409261wre.44.2020.08.05.04.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 04:40:17 -0700 (PDT)
Date: Wed, 5 Aug 2020 07:40:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 19/24] vdpa: make sure set_features in invoked for
 legacy
Message-ID: <20200805073929-mutt-send-email-mst@kernel.org>
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-20-mst@redhat.com>
 <9e47d227-f220-4651-dcb9-7a11f059a715@redhat.com>
MIME-Version: 1.0
In-Reply-To: <9e47d227-f220-4651-dcb9-7a11f059a715@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

T24gV2VkLCBBdWcgMDUsIDIwMjAgYXQgMDI6MTQ6MDdQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIwLzgvNCDkuIrljYg1OjAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6
Cj4gPiBTb21lIGxlZ2FjeSBndWVzdHMganVzdCBhc3N1bWUgZmVhdHVyZXMgYXJlIDAgYWZ0ZXIg
cmVzZXQuCj4gPiBXZSBkZXRlY3QgdGhhdCBjb25maWcgc3BhY2UgaXMgYWNjZXNzZWQgYmVmb3Jl
IGZlYXR1cmVzIGFyZQo+ID4gc2V0IGFuZCBzZXQgZmVhdHVyZXMgdG8gMCBhdXRvbWF0aWNhbGx5
Lgo+ID4gTm90ZTogc29tZSBsZWdhY3kgZ3Vlc3RzIG1pZ2h0IG5vdCBldmVuIGFjY2VzcyBjb25m
aWcgc3BhY2UsIGlmIHRoaXMgaXMKPiA+IHJlcG9ydGVkIGluIHRoZSBmaWVsZCB3ZSBtaWdodCBu
ZWVkIHRvIGNhdGNoIGEga2ljayB0byBoYW5kbGUgdGhlc2UuCj4gCj4gCj4gSSB3b25kZXIgd2hl
dGhlciBpdCdzIGVhc2llciB0byBqdXN0IHN1cHBvcnQgbW9kZXJuIGRldmljZT8KPiAKPiBUaGFu
a3MKCgpXZWxsIGhhcmR3YXJlIHZlbmRvcnMgYXJlIEkgdGhpbmsgaW50ZXJlc3RlZCBpbiBzdXBw
b3J0aW5nIGxlZ2FjeQpndWVzdHMuIExpbWl0aW5nIHZkcGEgdG8gbW9kZXJuIG9ubHkgd291bGQg
bWFrZSBpdCB1bmNvbXBldGl0aXZlLgoKCgo+IAo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaWNo
YWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgo+ID4gLS0tCj4gPiAgIGRyaXZlcnMvdmRw
YS92ZHBhLmMgIHwgIDEgKwo+ID4gICBpbmNsdWRlL2xpbnV4L3ZkcGEuaCB8IDM0ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysKPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCAzNSBpbnNl
cnRpb25zKCspCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYS5jIGIvZHJp
dmVycy92ZHBhL3ZkcGEuYwo+ID4gaW5kZXggZGUyMTFlZjM3MzhjLi43MTA1MjY1ZTQ3OTMgMTAw
NjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYS5jCj4gPiArKysgYi9kcml2ZXJzL3ZkcGEv
dmRwYS5jCj4gPiBAQCAtOTYsNiArOTYsNyBAQCBzdHJ1Y3QgdmRwYV9kZXZpY2UgKl9fdmRwYV9h
bGxvY19kZXZpY2Uoc3RydWN0IGRldmljZSAqcGFyZW50LAo+ID4gICAJdmRldi0+ZGV2LnJlbGVh
c2UgPSB2ZHBhX3JlbGVhc2VfZGV2Owo+ID4gICAJdmRldi0+aW5kZXggPSBlcnI7Cj4gPiAgIAl2
ZGV2LT5jb25maWcgPSBjb25maWc7Cj4gPiArCXZkZXYtPmZlYXR1cmVzX3ZhbGlkID0gZmFsc2U7
Cj4gPiAgIAllcnIgPSBkZXZfc2V0X25hbWUoJnZkZXYtPmRldiwgInZkcGEldSIsIHZkZXYtPmlu
ZGV4KTsKPiA+ICAgCWlmIChlcnIpCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92ZHBh
LmggYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+ID4gaW5kZXggMjM5ZGI3OTQzNTdjLi4yOWI4Mjk2
ZjE0MTQgMTAwNjQ0Cj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+ID4gKysrIGIvaW5j
bHVkZS9saW51eC92ZHBhLmgKPiA+IEBAIC0zMywxMiArMzMsMTQgQEAgc3RydWN0IHZkcGFfbm90
aWZpY2F0aW9uX2FyZWEgewo+ID4gICAgKiBAZG1hX2RldjogdGhlIGFjdHVhbCBkZXZpY2UgdGhh
dCBpcyBwZXJmb3JtaW5nIERNQQo+ID4gICAgKiBAY29uZmlnOiB0aGUgY29uZmlndXJhdGlvbiBv
cHMgZm9yIHRoaXMgZGV2aWNlLgo+ID4gICAgKiBAaW5kZXg6IGRldmljZSBpbmRleAo+ID4gKyAq
IEBmZWF0dXJlc192YWxpZDogd2VyZSBmZWF0dXJlcyBpbml0aWFsaXplZD8gZm9yIGxlZ2FjeSBn
dWVzdHMKPiA+ICAgICovCj4gPiAgIHN0cnVjdCB2ZHBhX2RldmljZSB7Cj4gPiAgIAlzdHJ1Y3Qg
ZGV2aWNlIGRldjsKPiA+ICAgCXN0cnVjdCBkZXZpY2UgKmRtYV9kZXY7Cj4gPiAgIAljb25zdCBz
dHJ1Y3QgdmRwYV9jb25maWdfb3BzICpjb25maWc7Cj4gPiAgIAl1bnNpZ25lZCBpbnQgaW5kZXg7
Cj4gPiArCWJvb2wgZmVhdHVyZXNfdmFsaWQ7Cj4gPiAgIH07Cj4gPiAgIC8qKgo+ID4gQEAgLTI2
Niw0ICsyNjgsMzYgQEAgc3RhdGljIGlubGluZSBzdHJ1Y3QgZGV2aWNlICp2ZHBhX2dldF9kbWFf
ZGV2KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldikKPiA+ICAgewo+ID4gICAJcmV0dXJuIHZkZXYt
PmRtYV9kZXY7Cj4gPiAgIH0KPiA+ICsKPiA+ICtzdGF0aWMgaW5saW5lIHZvaWQgdmRwYV9yZXNl
dChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpCj4gPiArewo+ID4gKyAgICAgICAgY29uc3Qgc3Ry
dWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRldi0+Y29uZmlnOwo+ID4gKwo+ID4gKwl2ZGV2
LT5mZWF0dXJlc192YWxpZCA9IGZhbHNlOwo+ID4gKyAgICAgICAgb3BzLT5zZXRfc3RhdHVzKHZk
ZXYsIDApOwo+ID4gK30KPiA+ICsKPiA+ICtzdGF0aWMgaW5saW5lIGludCB2ZHBhX3NldF9mZWF0
dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHU2NCBmZWF0dXJlcykKPiA+ICt7Cj4gPiAr
ICAgICAgICBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzICpvcHMgPSB2ZGV2LT5jb25maWc7
Cj4gPiArCj4gPiArCXZkZXYtPmZlYXR1cmVzX3ZhbGlkID0gdHJ1ZTsKPiA+ICsgICAgICAgIHJl
dHVybiBvcHMtPnNldF9mZWF0dXJlcyh2ZGV2LCBmZWF0dXJlcyk7Cj4gPiArfQo+ID4gKwo+ID4g
Kwo+ID4gK3N0YXRpYyBpbmxpbmUgdm9pZCB2ZHBhX2dldF9jb25maWcoc3RydWN0IHZkcGFfZGV2
aWNlICp2ZGV2LCB1bnNpZ25lZCBvZmZzZXQsCj4gPiArCQkJCSAgIHZvaWQgKmJ1ZiwgdW5zaWdu
ZWQgaW50IGxlbikKPiA+ICt7Cj4gPiArICAgICAgICBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdf
b3BzICpvcHMgPSB2ZGV2LT5jb25maWc7Cj4gPiArCj4gPiArCS8qCj4gPiArCSAqIENvbmZpZyBh
Y2Nlc3NlcyBhcmVuJ3Qgc3VwcG9zZWQgdG8gdHJpZ2dlciBiZWZvcmUgZmVhdHVyZXMgYXJlIHNl
dC4KPiA+ICsJICogSWYgaXQgZG9lcyBoYXBwZW4gd2UgYXNzdW1lIGEgbGVnYWN5IGd1ZXN0Lgo+
ID4gKwkgKi8KPiA+ICsJaWYgKCF2ZGV2LT5mZWF0dXJlc192YWxpZCkKPiA+ICsJCXZkcGFfc2V0
X2ZlYXR1cmVzKHZkZXYsIDApOwo+ID4gKwlvcHMtPmdldF9jb25maWcodmRldiwgb2Zmc2V0LCBi
dWYsIGxlbik7Cj4gPiArfQo+ID4gKwo+ID4gICAjZW5kaWYgLyogX0xJTlVYX1ZEUEFfSCAqLwoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
