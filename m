Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C818C433F5
	for <virtualization@archiver.kernel.org>; Wed, 12 Jan 2022 14:52:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B2F0040A4C;
	Wed, 12 Jan 2022 14:52:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oOvDSmXuHf10; Wed, 12 Jan 2022 14:52:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 97CA040B9C;
	Wed, 12 Jan 2022 14:52:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DB73C0030;
	Wed, 12 Jan 2022 14:52:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70E0FC001E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 14:52:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6A96E428FD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 14:52:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lBl6eLESZFbb
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 14:52:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8E61A4290D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 14:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641999150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JbB9qVe2cdADAoLi9p85NL4WatOPJExL0xOEqnBVVk0=;
 b=Ucm89owBNRQ30FIjBPEKpBKWsPly8jGZoRAZWX9HwTW1YCYDBl2OBHNn5LwJwFAlw8COqr
 8H/wPoJgALvTQiyaA1UZ/IqxB2I8s9l4gQCOR/MahCKi3gDEigB/DCd96/t5/xmuDxJXpR
 jXefJ/3TiCFdVTVv4huZ95LMnTkzKLg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-186-9u4SxDi7N22E77WbmoeqNQ-1; Wed, 12 Jan 2022 09:52:29 -0500
X-MC-Unique: 9u4SxDi7N22E77WbmoeqNQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 m8-20020a056402510800b003f9d22c4d48so2433375edd.21
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 06:52:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=JbB9qVe2cdADAoLi9p85NL4WatOPJExL0xOEqnBVVk0=;
 b=am1noMRAMCe1ZujrbHAUbEM2UJH2gBbcjf2vD3nLWHmT7Tzdsb46YqgLtoAM0J2jtI
 nSN+8zlmrTFK9VxILYiJtrty+uf3vkfOgNbjqkTBi/La7bh6Z/Oc7WbU92/Vmq0qLxhU
 +vBwdvLeaqL7HQKu2pDdTynkKLG2iQn8aPwxMcGMixlbIywUppwXgNzU0hDTWTQ2wJDj
 i0KbyyXUApBdjv87qMaH/yErcU0C5XmeAjC2pjsjFsKhexPzZBJ05HTT+iFh+BSueqtV
 Gl7HhxRcoKctIWe0hmDzjVN8VVje2uBwlgjJ1BBThrOpf9V9cOOZOP/JPEyvWgcNaMhI
 IABg==
X-Gm-Message-State: AOAM530ZZ32nqD04SP5/Ol9lgVlQo3FPyYCta/LcB6KT5vhifWnAbofD
 WRVhOVBEnzam7wwO1eIRVhz4CAmqHgsTfEq432bAnNqhfwukBEhsU7fCtJtq4oUMv9Kqys3JhVy
 qc60Gw8Eqx/yFXPJAoLouwrbZ+uRlO92Jllzyetr3cQ==
X-Received: by 2002:a17:906:3a55:: with SMTP id
 a21mr102713ejf.274.1641999148058; 
 Wed, 12 Jan 2022 06:52:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxuS6tdgV/MCq8jq1Hv/Sxpb7BZFZoP0GZA1WpMAVHCYU+7TrNcUVD8zlmUbrxmVIq5DlbDfA==
X-Received: by 2002:a17:906:3a55:: with SMTP id
 a21mr102691ejf.274.1641999147794; 
 Wed, 12 Jan 2022 06:52:27 -0800 (PST)
Received: from redhat.com ([2.55.132.148])
 by smtp.gmail.com with ESMTPSA id h3sm25788ede.32.2022.01.12.06.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jan 2022 06:52:26 -0800 (PST)
Date: Wed, 12 Jan 2022 09:52:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio_vdpa: Support surprise removal of virtio vdpa
 device
Message-ID: <20220112095208-mutt-send-email-mst@kernel.org>
References: <tencent_7A45E1E967F13AE14B061269@qq.com>
 <20220111065033-mutt-send-email-mst@kernel.org>
 <CACGkMEuAoSwore14qnuMDgdEtWh-UOJf1=oR9vhPMff8hoEZEQ@mail.gmail.com>
 <20220112013018-mutt-send-email-mst@kernel.org>
 <CACGkMEs6u7o4pX4ahvnfPByt1BrSfmaFfEKm5pQJsjjH+XHYxw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEs6u7o4pX4ahvnfPByt1BrSfmaFfEKm5pQJsjjH+XHYxw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: =?utf-8?B?5p2O5Lic5Y2H?= <lidongsheng@dayudpu.com>,
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

T24gV2VkLCBKYW4gMTIsIDIwMjIgYXQgMDM6NTI6NTJQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBXZWQsIEphbiAxMiwgMjAyMiBhdCAyOjMwIFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8
bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFdlZCwgSmFuIDEyLCAyMDIyIGF0IDEw
OjIzOjA3QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+IE9uIFR1ZSwgSmFuIDExLCAy
MDIyIGF0IDc6NTIgUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6
Cj4gPiA+ID4KPiA+ID4gPiBPbiBUdWUsIEphbiAxMSwgMjAyMiBhdCAxMTozNjo0MkFNICswODAw
LCDmnY7kuJzljYcgd3JvdGU6Cj4gPiA+ID4gPiBXaGVuIHZpcnRpbyB2ZHBhIGRldmljZSByZW1v
dmVkLCB0aGUgYWJub3JtYWwgZGFtYWdlIG9mIHRoZSBkZXZpY2UgY2Fubm90IGJlCj4gPiA+ID4g
PiBwZXJjZWl2ZWQgbm9ybWFsbHksIHdoaWNoIHdpbGwgY2F1c2UgcHJvYmxlbXMgc2ltaWxhciB0
bzoKPiA+ID4gPiA+Cj4gPiA+ID4gPiA0M2JiNDBjNWI5MjYKPiA+ID4gPgo+ID4gPiA+Cj4gPiA+
ID4gU2hvdWxkIGluY2x1ZGUgdGhlIHN1YmplY3Qgb2YgdGhlIHBhdGNoIHRvby4KPiA+ID4gPgo+
ID4gPiA+ID4gSGVuY2UsIGFkZCB0aGUgYWJpbGl0eSB0byBhYm9ydCB0aGUgY29tbWFuZCBvbiBz
dXJwcmlzZSByZW1vdmFsCj4gPiA+ID4gPgo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogZG9uZ3No
ZW5nIGxpIDxsaWRvbmdzaGVuZ0BkYXl1ZHB1LmNvbT4KPiA+ID4gPgo+ID4gPiA+IFdoZW4gcmVt
b3ZpbmcgZ3JhY2VmdWxseSwKPiA+ID4gPiBJIGFtIG5vdCBzdXJlIHdlIHNob3VsZCBicmVhayBk
ZXZpY2UgdW5jb25kaXRpb25hbGx5IGxpa2UgdGhpcwo+ID4gPiA+IGJlZm9yZSBnaXZpbmcgZHJp
dmVycyBhIGNoYW5jZSB0byBjbGVhbiB1cC4KPiA+ID4gPiBTaG91bGQgd2UganVzdCBkbyBpdCBm
b3Igc3VycHJpc2UgcmVtb3ZhbD8KPiA+ID4KPiA+ID4gVGhhdCByZXF1aXJlcyBhIG5ldyBtZXRo
b2QgdG8gcXVlcnkgd2hldGhlciBpdCdzIGEgc3VycHJpc2UgcmVtb3ZhbC4KPiA+ID4KPiA+ID4g
VGhhbmtzCj4gPgo+ID4gV2UgY2FuIGNoZWNrIHBjaV9kZXZpY2VfaXNfcHJlc2VudCBsaWtlIHZp
cnRpbyBkb2VzLgo+IAo+IFRob3VnaCB0aGUgUENJIGRldmljZSBpcyB0aGUgbWFpbiB1c2VyLCB3
ZSBhcmUgdmRwYSB0cmFuc3BvcnQgdGhhdCBpcwo+IHVuYXdhcmUgb2YgdGhlIHR5cGUgb2YgaXRz
IHBhcmVudC4KPiAKPiBTbyBpdCBsb29rcyB0byBtZSB3ZSBuZWVkIGEgbmV3IG1ldGhvZCBhbmQg
UENJIHBhcmVudCBhbmQgZG8gY2FsbCB0aGlzCj4gZnVuY3Rpb24gd2hlbiBuZWVkZWQuCj4gCj4g
VGhhbmtzCgpTdXJlLgoKPiA+Cj4gPiA+ID4KPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4gIGRyaXZl
cnMvdmlydGlvL3ZpcnRpb192ZHBhLmMgfCAxICsKPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKykKPiA+ID4gPiA+Cj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3ZkcGEuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMKPiA+ID4g
PiA+IGluZGV4IDRhOWRkYjQ0YjJhNy4uZmQ5MzA0MDlkMTkwIDEwMDY0NAo+ID4gPiA+ID4gLS0t
IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYwo+ID4gPiA+ID4gKysrIGIvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3ZkcGEuYwo+ID4gPiA+ID4gQEAgLTM3NCw2ICszNzQsNyBAQCBzdGF0aWMg
dm9pZCB2aXJ0aW9fdmRwYV9yZW1vdmUoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhKQo+ID4gPiA+
ID4gIHsKPiA+ID4gPiA+ICAgc3RydWN0IHZpcnRpb192ZHBhX2RldmljZSAqdmRfZGV2ID0gdmRw
YV9nZXRfZHJ2ZGF0YSh2ZHBhKTsKPiA+ID4gPiA+Cj4gPiA+ID4gPiArIHZpcnRpb19icmVha19k
ZXZpY2UodmRfZGV2LT52ZGV2KTsKPiA+ID4gPiA+ICAgdW5yZWdpc3Rlcl92aXJ0aW9fZGV2aWNl
KCZ2ZF9kZXYtPnZkZXYpOwo+ID4gPiA+ID4gIH0KPiA+ID4gPiA+Cj4gPiA+ID4gPiAtLQo+ID4g
PiA+ID4gMi4xNy4xCj4gPiA+ID4KPiA+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
