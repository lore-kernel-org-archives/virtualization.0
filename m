Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5463CC6FD19
	for <virtualization@archiver.kernel.org>; Thu, 16 Mar 2023 04:03:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BD5F540C07;
	Thu, 16 Mar 2023 04:03:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BD5F540C07
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BkHwneK2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Hz1rAo1kWZf; Thu, 16 Mar 2023 04:03:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4B699400D3;
	Thu, 16 Mar 2023 04:02:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4B699400D3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C19ABC0071;
	Thu, 16 Mar 2023 04:02:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9DAC6C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 04:02:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 643CD40C03
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 04:02:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 643CD40C03
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jEtLD1tYeLjG
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 04:02:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 56707400D3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 56707400D3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 04:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678939373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3NgIc+ak/M8tTVwg+nTzbx40rNW8uHJV2Ocv/hWrBM4=;
 b=BkHwneK2duxO9Hlp9vNVTIeWwjIffa10uLom5GPhvgNKihT+8xeyIjp46LHf/IS3WKnfgm
 YNrIwsl77w1457E1+iWR9uuLXtKuRjaeFNYyZnbMJf+RPGV0KUmal0+Wy7UV0Gf5/87JAx
 0ELXRuVuZg0MaYC0rxm7r1VSbyiWbuw=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-3lEQ4EoWN6CalOkYJ7HSyw-1; Thu, 16 Mar 2023 00:02:52 -0400
X-MC-Unique: 3lEQ4EoWN6CalOkYJ7HSyw-1
Received: by mail-oi1-f198.google.com with SMTP id
 bj22-20020a056808199600b003869dd33f19so348807oib.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 21:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678939371;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3NgIc+ak/M8tTVwg+nTzbx40rNW8uHJV2Ocv/hWrBM4=;
 b=gNEW6/YADrnjE5fPQA8RFocIcUjwDGWZ4xZ8cK3binrUm98H6CG1tMlQL3bAbP9kK6
 pZpT3Qm66FFXL2Mw7zoNOe3WijnHeJkutUBmujRaIXOZCG6XeNTJ6IC/L2rzsHuyjVCp
 pI2555GRnsRdoxzcMweD07qW30zoBtkn1bx/KmyBWM2K3r2vMjkhPinSbuMZRAgJU11F
 SjKYh//L/1O2r9iscXK0DgjqROYf+2VRi22VFPNT3p2P5oGF4T4ZejgWdSZcGlEL57T6
 o9u9psZBpj0qyb7gORMPjHLAEd2tv0CBjL5W2MqVC2kA6wZ1zHP2ncUcRpOSDu+TPXfM
 mwBQ==
X-Gm-Message-State: AO0yUKXMz6Ju+/XUlwiKqW2jCj3eRZc5eJMmY82lmJofiq++OaqABFTl
 mlRa65L6avp2BRdAP0b6qZsHAJNfxiHcQeVcF3/0tHdRgY8aLCgr+un72X/xETzLhd7SKRh7CLe
 mLVz+0AK52t6NhFpnTArZU+lEXlvwGIUHuy0K/9AN/soBymGDZL45UJ7U5g==
X-Received: by 2002:a05:6870:649f:b0:177:9f9c:dc5 with SMTP id
 cz31-20020a056870649f00b001779f9c0dc5mr6560163oab.9.1678939371349; 
 Wed, 15 Mar 2023 21:02:51 -0700 (PDT)
X-Google-Smtp-Source: AK7set8g3ja89JMUVExSezS1VgvMoNhMWwkgtn2lNsstuNCoJJsapbZptTph6GdpByMAKii8UzClR/RRava7uPu0d0k=
X-Received: by 2002:a05:6870:649f:b0:177:9f9c:dc5 with SMTP id
 cz31-20020a056870649f00b001779f9c0dc5mr6560159oab.9.1678939371089; Wed, 15
 Mar 2023 21:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230228094110.37-1-xieyongji@bytedance.com>
 <20230228094110.37-4-xieyongji@bytedance.com>
In-Reply-To: <20230228094110.37-4-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 16 Mar 2023 12:02:40 +0800
Message-ID: <CACGkMEvmV7xKc7VnaZT+DGcN2hg64ksGHxRAihW2f=RpXydZoQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] vdpa: Add set_irq_affinity callback in
 vdpa_config_ops
To: Xie Yongji <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
 virtualization@lists.linux-foundation.org, hch@lst.de, mst@redhat.com
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

T24gVHVlLCBGZWIgMjgsIDIwMjMgYXQgNTo0MuKAr1BNIFhpZSBZb25namkgPHhpZXlvbmdqaUBi
eXRlZGFuY2UuY29tPiB3cm90ZToKPgo+IFRoaXMgaW50cm9kdWNlcyBzZXRfaXJxX2FmZmluaXR5
IGNhbGxiYWNrIGluCj4gdmRwYV9jb25maWdfb3BzIHNvIHRoYXQgdmRwYSBkZXZpY2UgZHJpdmVy
IGNhbgo+IGdldCB0aGUgaW50ZXJydXB0IGFmZmluaXR5IGhpbnQgZnJvbSB0aGUgdmlydGlvCj4g
ZGV2aWNlIGRyaXZlci4gVGhlIGludGVycnVwdCBhZmZpbml0eSBoaW50IHdvdWxkCj4gYmUgbmVl
ZGVkIGJ5IHRoZSBpbnRlcnJ1cHQgYWZmaW5pdHkgc3ByZWFkaW5nCj4gbWVjaGFuaXNtLgo+Cj4g
U2lnbmVkLW9mZi1ieTogWGllIFlvbmdqaSA8eGlleW9uZ2ppQGJ5dGVkYW5jZS5jb20+Cj4gLS0t
Cj4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMgfCA0ICsrKysKPiAgaW5jbHVkZS9saW51
eC92ZHBhLmggICAgICAgICB8IDkgKysrKysrKysrCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5z
ZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMg
Yi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jCj4gaW5kZXggZjcyNjk2YjRjMWMyLi45ZWVl
OGFmYWJkYTggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYwo+ICsr
KyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMKPiBAQCAtMjgyLDkgKzI4MiwxMyBAQCBz
dGF0aWMgaW50IHZpcnRpb192ZHBhX2ZpbmRfdnFzKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2
LCB1bnNpZ25lZCBpbnQgbnZxcywKPiAgICAgICAgIHN0cnVjdCB2aXJ0aW9fdmRwYV9kZXZpY2Ug
KnZkX2RldiA9IHRvX3ZpcnRpb192ZHBhX2RldmljZSh2ZGV2KTsKPiAgICAgICAgIHN0cnVjdCB2
ZHBhX2RldmljZSAqdmRwYSA9IHZkX2dldF92ZHBhKHZkZXYpOwo+ICAgICAgICAgY29uc3Qgc3Ry
dWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRwYS0+Y29uZmlnOwo+ICsgICAgICAgc3RydWN0
IGlycV9hZmZpbml0eSBkZWZhdWx0X2FmZmQgPSB7IDAgfTsKPiAgICAgICAgIHN0cnVjdCB2ZHBh
X2NhbGxiYWNrIGNiOwo+ICAgICAgICAgaW50IGksIGVyciwgcXVldWVfaWR4ID0gMDsKPgo+ICsg
ICAgICAgaWYgKG9wcy0+c2V0X2lycV9hZmZpbml0eSkKPiArICAgICAgICAgICAgICAgb3BzLT5z
ZXRfaXJxX2FmZmluaXR5KHZkcGEsIGRlc2MgPyBkZXNjIDogJmRlZmF1bHRfYWZmZCk7Cj4gKwo+
ICAgICAgICAgZm9yIChpID0gMDsgaSA8IG52cXM7ICsraSkgewo+ICAgICAgICAgICAgICAgICBp
ZiAoIW5hbWVzW2ldKSB7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgdnFzW2ldID0gTlVMTDsK
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92ZHBhLmggYi9pbmNsdWRlL2xpbnV4L3ZkcGEu
aAo+IGluZGV4IGQ2MWYzNjlmOWNkNi4uMTBiZDIyMzg3Mjc2IDEwMDY0NAo+IC0tLSBhL2luY2x1
ZGUvbGludXgvdmRwYS5oCj4gKysrIGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPiBAQCAtMjU5LDYg
KzI1OSwxMyBAQCBzdHJ1Y3QgdmRwYV9tYXBfZmlsZSB7Cj4gICAqICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBAdmRldjogdmRwYSBkZXZpY2UKPiAgICogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIEBpZHg6IHZpcnRxdWV1ZSBpbmRleAo+ICAgKiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgUmV0dXJucyB0aGUgaXJxIGFmZmluaXR5IG1hc2sKPiArICogQHNldF9pcnFfYWZmaW5p
dHk6ICAgICAgICAgIFBhc3MgdGhlIGlycSBhZmZpbml0eSBoaW50IChiZXN0IGVmZm9ydCkKCk5v
dGUgdGhhdCB0aGlzIGNvdWxkIGVhc2lseSBjb25mdXNlIHRoZSB1c2Vycy4gSSB3b25kZXIgaWYg
d2UgY2FuCnVuaWZ5IGl0IHdpdGggc2V0X2lycV9hZmZpbml0eS4gTG9va2luZyBhdCB2ZHVzZSdz
IGltcGxlbWVudGF0aW9uLCBpdApzaG91bGQgYmUgcG9zc2libGUuCgooRS5nIHNldF92cV9hZmZp
bml0eSBpbXBsZW1lbnRlZCBieSB2aXJ0aW8tcGNpIGFyZSB1c2luZyBpcnEgYWZmaW5pdHkgYWN0
dWFsbHkpLgoKVGhhbmtzCgo+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZnJvbSB0
aGUgdmlydGlvIGRldmljZSBkcml2ZXIgdG8gdmRwYQo+ICsgKiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgZHJpdmVyIChvcHRpb25hbCkuCj4gKyAqICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBOZWVkZWQgYnkgdGhlIGludGVycnVwdCBhZmZpbml0eSBzcHJlYWRpbmcKPiArICogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIG1lY2hhbmlzbS4KPiArICogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIEB2ZGV2OiB2ZHBhIGRldmljZQo+ICsgKiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgQGRlc2M6IGlycSBhZmZpbml0eSBoaW50Cj4gICAqIEBzZXRfZ3JvdXBfYXNpZDog
ICAgICAgICAgICBTZXQgYWRkcmVzcyBzcGFjZSBpZGVudGlmaWVyIGZvciBhCj4gICAqICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB2aXJ0cXVldWUgZ3JvdXAgKG9wdGlvbmFsKQo+ICAgKiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgQHZkZXY6IHZkcGEgZGV2aWNlCj4gQEAgLTM1Myw2
ICszNjAsOCBAQCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzIHsKPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgY29uc3Qgc3RydWN0IGNwdW1hc2sgKmNwdV9tYXNrKTsKPiAgICAgICAgIGNv
bnN0IHN0cnVjdCBjcHVtYXNrICooKmdldF92cV9hZmZpbml0eSkoc3RydWN0IHZkcGFfZGV2aWNl
ICp2ZGV2LAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB1MTYgaWR4KTsKPiArICAgICAgIHZvaWQgKCpzZXRfaXJxX2FmZmluaXR5KShzdHJ1Y3QgdmRw
YV9kZXZpY2UgKnZkZXYsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IGlycV9hZmZpbml0eSAqZGVzYyk7Cj4KPiAgICAgICAgIC8qIERNQSBvcHMgKi8KPiAgICAgICAg
IGludCAoKnNldF9tYXApKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdW5zaWduZWQgaW50IGFz
aWQsCj4gLS0KPiAyLjIwLjEKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
