Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE0FC61DA4
	for <virtualization@archiver.kernel.org>; Wed, 22 Feb 2023 03:43:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DF1134021C;
	Wed, 22 Feb 2023 03:43:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DF1134021C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Sjtztd6y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c5xpMVz0lmEf; Wed, 22 Feb 2023 03:43:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 45F2240138;
	Wed, 22 Feb 2023 03:43:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 45F2240138
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C3E0C0033;
	Wed, 22 Feb 2023 03:43:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4089C002B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 03:43:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A907940148
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 03:43:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A907940148
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dxqr2UGD4Ka3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 03:43:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A8C4940138
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A8C4940138
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 03:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677037405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GYy9cshmMNr8BfPaOPWLByKunyms8d6bnFFqfMFZ4B8=;
 b=Sjtztd6ynN8kPSswysQ+QuA3ji68Z/xazB/kMFeu+xb9XsnhCGBLJIyo2XBguA0Yr+FhNt
 CWA+WHarLKn3LkSjaMry+zOK5xUfaKLoV6S4Qg2UyIH0EliAvvW3zDgjVMXDrmAUd4g+rW
 EHkdCVPiZWKHP20sm1Cd6bduK86pezE=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-176-gBz5f9U-NHmRNf4adImyUg-1; Tue, 21 Feb 2023 22:43:23 -0500
X-MC-Unique: gBz5f9U-NHmRNf4adImyUg-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-1720fcf0944so2477289fac.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 19:43:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GYy9cshmMNr8BfPaOPWLByKunyms8d6bnFFqfMFZ4B8=;
 b=70Jwl2QI031sREE9UFunI4uux+VFxepQ354mdNAIKV4TG31bLEAVHOVUbBHv1iWLPX
 zCfz2tulagpD/y4cfa6vVF542XKfJ3p/BKymGzPWuk6jcn3iYHVscsDRzDH36HVDe2fh
 /FvRRWC0OERHRy2OIbFhbadZd8dEn1370GtpWkXMg+xxgBR3GVWTV/7KRtCBfvT+IxCs
 Q3qNqnksGq4bk8nB7zvHgusfsOPqQ8SBrdKHFh4Q32dkwvOc/QlNt3fGVC29HL+n0L61
 cT+6IFRu1+CDHlurJoZ7rC59GGTIZM3AW95eMQqhCL2HEanaMke2bEsiH0bRR0GwtxKQ
 AnUQ==
X-Gm-Message-State: AO0yUKU4NyLU3T0L0wY9n28C6TZ/+kRbcVcND6KaKm8PCtDUmD0Sfn/+
 HL3r6482C1lNkinWBPd5cjFJlZdOyy0NJIakGxc49IiA1zXYDCq13LbRmAmmlbfMeJd2K7y6mg1
 aPg+e2aKwP7VcsvwUbWrHIJY5faZJwMouU/KNP28LMvlv75XCrzz4M/Y2fA==
X-Received: by 2002:a05:6871:725:b0:16a:2c1a:e416 with SMTP id
 f37-20020a056871072500b0016a2c1ae416mr746355oap.35.1677037403043; 
 Tue, 21 Feb 2023 19:43:23 -0800 (PST)
X-Google-Smtp-Source: AK7set9C8zghOv+GH1Gih+SpNi9utTa+DTMyMp55TkhEpeMx1+yj83hNjy2Hrvwb83uTeF/muFGuHkUN4v+XCbuXaGc=
X-Received: by 2002:a05:6871:725:b0:16a:2c1a:e416 with SMTP id
 f37-20020a056871072500b0016a2c1ae416mr746334oap.35.1677037402798; Tue, 21 Feb
 2023 19:43:22 -0800 (PST)
MIME-Version: 1.0
References: <20230208094253.702672-1-eperezma@redhat.com>
 <20230208094253.702672-5-eperezma@redhat.com>
 <f8487b52-964f-641c-4365-e38b44ea2627@redhat.com>
 <CAJaqyWdmApbyUdUCKXV2RvfRbSPQD=G18WVtdKXR3qTD5J5hqw@mail.gmail.com>
In-Reply-To: <CAJaqyWdmApbyUdUCKXV2RvfRbSPQD=G18WVtdKXR3qTD5J5hqw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 22 Feb 2023 11:43:11 +0800
Message-ID: <CACGkMEtSDfyYPpbWcOydDr329936nmUyKQdPFbvfxQPZMj6HJQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] vdpa: move vhost reset after get vring base
To: Eugenio Perez Martin <eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Gautam Dawar <gdawar@xilinx.com>,
 virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Lei Yang <leiyang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 longpeng2@huawei.com, Shannon Nelson <snelson@pensando.io>,
 Liuxiangdong <liuxiangdong5@huawei.com>
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

T24gVHVlLCBGZWIgMjEsIDIwMjMgYXQgMzowOCBQTSBFdWdlbmlvIFBlcmV6IE1hcnRpbgo8ZXBl
cmV6bWFAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBUdWUsIEZlYiAyMSwgMjAyMyBhdCA2OjM2
IEFNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+Cj4gPiDl
nKggMjAyMy8yLzggMTc6NDIsIEV1Z2VuaW8gUMOpcmV6IOWGmemBkzoKPiA+ID4gVGhlIGZ1bmN0
aW9uIHZob3N0LmM6dmhvc3RfZGV2X3N0b3AgY2FsbHMgdmhvc3Qgb3BlcmF0aW9uCj4gPiA+IHZo
b3N0X2Rldl9zdGFydChmYWxzZSkuIEluIHRoZSBjYXNlIG9mIHZkcGEgaXQgdG90YWxseSByZXNl
dCBhbmQgd2lwZXMKPiA+ID4gdGhlIGRldmljZSwgbWFraW5nIHRoZSBmZXRjaGluZyBvZiB0aGUg
dnJpbmcgYmFzZSAodmlydHF1ZXVlIHN0YXRlKSB0b3RhbGx5Cj4gPiA+IHVzZWxlc3MuCj4gPiA+
Cj4gPiA+IFRoZSBrZXJuZWwgYmFja2VuZCBkb2VzIG5vdCB1c2Ugdmhvc3RfZGV2X3N0YXJ0IHZo
b3N0IG9wIGNhbGxiYWNrLCBidXQKPiA+ID4gdmhvc3QtdXNlciBkby4gQSBwYXRjaCB0byBtYWtl
IHZob3N0X3VzZXJfZGV2X3N0YXJ0IG1vcmUgc2ltaWxhciB0byB2ZHBhCj4gPiA+IGlzIGRlc2ly
YWJsZSwgYnV0IGl0IGNhbiBiZSBhZGRlZCBvbiB0b3AuCj4gPiA+Cj4gPiA+IFNpZ25lZC1vZmYt
Ynk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgo+ID4gPiAtLS0KPiA+ID4g
ICBpbmNsdWRlL2h3L3ZpcnRpby92aG9zdC1iYWNrZW5kLmggfCAgNCArKysrCj4gPiA+ICAgaHcv
dmlydGlvL3Zob3N0LXZkcGEuYyAgICAgICAgICAgIHwgMjIgKysrKysrKysrKysrKysrKy0tLS0t
LQo+ID4gPiAgIGh3L3ZpcnRpby92aG9zdC5jICAgICAgICAgICAgICAgICB8ICAzICsrKwo+ID4g
PiAgIDMgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPiA+
ID4KPiA+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmlydGlvL3Zob3N0LWJhY2tlbmQuaCBi
L2luY2x1ZGUvaHcvdmlydGlvL3Zob3N0LWJhY2tlbmQuaAo+ID4gPiBpbmRleCBjNWFiNDkwNTFl
Li5lYzNmYmFlNThkIDEwMDY0NAo+ID4gPiAtLS0gYS9pbmNsdWRlL2h3L3ZpcnRpby92aG9zdC1i
YWNrZW5kLmgKPiA+ID4gKysrIGIvaW5jbHVkZS9ody92aXJ0aW8vdmhvc3QtYmFja2VuZC5oCj4g
PiA+IEBAIC0xMzAsNiArMTMwLDkgQEAgdHlwZWRlZiBib29sICgqdmhvc3RfZm9yY2VfaW9tbXVf
b3ApKHN0cnVjdCB2aG9zdF9kZXYgKmRldik7Cj4gPiA+Cj4gPiA+ICAgdHlwZWRlZiBpbnQgKCp2
aG9zdF9zZXRfY29uZmlnX2NhbGxfb3ApKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwKPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgZmQpOwo+ID4gPiArCj4g
PiA+ICt0eXBlZGVmIHZvaWQgKCp2aG9zdF9yZXNldF9zdGF0dXNfb3ApKHN0cnVjdCB2aG9zdF9k
ZXYgKmRldik7Cj4gPiA+ICsKPiA+ID4gICB0eXBlZGVmIHN0cnVjdCBWaG9zdE9wcyB7Cj4gPiA+
ICAgICAgIFZob3N0QmFja2VuZFR5cGUgYmFja2VuZF90eXBlOwo+ID4gPiAgICAgICB2aG9zdF9i
YWNrZW5kX2luaXQgdmhvc3RfYmFja2VuZF9pbml0Owo+ID4gPiBAQCAtMTc3LDYgKzE4MCw3IEBA
IHR5cGVkZWYgc3RydWN0IFZob3N0T3BzIHsKPiA+ID4gICAgICAgdmhvc3RfZ2V0X2RldmljZV9p
ZF9vcCB2aG9zdF9nZXRfZGV2aWNlX2lkOwo+ID4gPiAgICAgICB2aG9zdF9mb3JjZV9pb21tdV9v
cCB2aG9zdF9mb3JjZV9pb21tdTsKPiA+ID4gICAgICAgdmhvc3Rfc2V0X2NvbmZpZ19jYWxsX29w
IHZob3N0X3NldF9jb25maWdfY2FsbDsKPiA+ID4gKyAgICB2aG9zdF9yZXNldF9zdGF0dXNfb3Ag
dmhvc3RfcmVzZXRfc3RhdHVzOwo+ID4gPiAgIH0gVmhvc3RPcHM7Cj4gPiA+Cj4gPiA+ICAgaW50
IHZob3N0X2JhY2tlbmRfdXBkYXRlX2RldmljZV9pb3RsYihzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYs
Cj4gPiA+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhvc3QtdmRwYS5jIGIvaHcvdmlydGlvL3Zo
b3N0LXZkcGEuYwo+ID4gPiBpbmRleCBjYmJlOTJmZmU4Li4yNmUzOGE2YWFiIDEwMDY0NAo+ID4g
PiAtLS0gYS9ody92aXJ0aW8vdmhvc3QtdmRwYS5jCj4gPiA+ICsrKyBiL2h3L3ZpcnRpby92aG9z
dC12ZHBhLmMKPiA+ID4gQEAgLTExNTIsMTQgKzExNTIsMjMgQEAgc3RhdGljIGludCB2aG9zdF92
ZHBhX2Rldl9zdGFydChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIGJvb2wgc3RhcnRlZCkKPiA+ID4g
ICAgICAgaWYgKHN0YXJ0ZWQpIHsKPiA+ID4gICAgICAgICAgIG1lbW9yeV9saXN0ZW5lcl9yZWdp
c3Rlcigmdi0+bGlzdGVuZXIsICZhZGRyZXNzX3NwYWNlX21lbW9yeSk7Cj4gPiA+ICAgICAgICAg
ICByZXR1cm4gdmhvc3RfdmRwYV9hZGRfc3RhdHVzKGRldiwgVklSVElPX0NPTkZJR19TX0RSSVZF
Ul9PSyk7Cj4gPiA+IC0gICAgfSBlbHNlIHsKPiA+ID4gLSAgICAgICAgdmhvc3RfdmRwYV9yZXNl
dF9kZXZpY2UoZGV2KTsKPiA+ID4gLSAgICAgICAgdmhvc3RfdmRwYV9hZGRfc3RhdHVzKGRldiwg
VklSVElPX0NPTkZJR19TX0FDS05PV0xFREdFIHwKPiA+ID4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgVklSVElPX0NPTkZJR19TX0RSSVZFUik7Cj4gPiA+IC0gICAgICAgIG1l
bW9yeV9saXN0ZW5lcl91bnJlZ2lzdGVyKCZ2LT5saXN0ZW5lcik7Cj4gPiA+ICsgICAgfQo+ID4g
Pgo+ID4gPiAtICAgICAgICByZXR1cm4gMDsKPiA+ID4gKyAgICByZXR1cm4gMDsKPiA+ID4gK30K
PiA+ID4gKwo+ID4gPiArc3RhdGljIHZvaWQgdmhvc3RfdmRwYV9yZXNldF9zdGF0dXMoc3RydWN0
IHZob3N0X2RldiAqZGV2KQo+ID4gPiArewo+ID4gPiArICAgIHN0cnVjdCB2aG9zdF92ZHBhICp2
ID0gZGV2LT5vcGFxdWU7Cj4gPiA+ICsKPiA+ID4gKyAgICBpZiAoZGV2LT52cV9pbmRleCArIGRl
di0+bnZxcyAhPSBkZXYtPnZxX2luZGV4X2VuZCkgewo+ID4gPiArICAgICAgICByZXR1cm47Cj4g
PiA+ICAgICAgIH0KPiA+ID4gKwo+ID4gPiArICAgIHZob3N0X3ZkcGFfcmVzZXRfZGV2aWNlKGRl
dik7Cj4gPiA+ICsgICAgdmhvc3RfdmRwYV9hZGRfc3RhdHVzKGRldiwgVklSVElPX0NPTkZJR19T
X0FDS05PV0xFREdFIHwKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVklS
VElPX0NPTkZJR19TX0RSSVZFUik7Cj4gPiA+ICsgICAgbWVtb3J5X2xpc3RlbmVyX3VucmVnaXN0
ZXIoJnYtPmxpc3RlbmVyKTsKPiA+ID4gICB9Cj4gPiA+Cj4gPiA+ICAgc3RhdGljIGludCB2aG9z
dF92ZHBhX3NldF9sb2dfYmFzZShzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIHVpbnQ2NF90IGJhc2Us
Cj4gPiA+IEBAIC0xMzQ2LDQgKzEzNTUsNSBAQCBjb25zdCBWaG9zdE9wcyB2ZHBhX29wcyA9IHsK
PiA+ID4gICAgICAgICAgIC52aG9zdF92cV9nZXRfYWRkciA9IHZob3N0X3ZkcGFfdnFfZ2V0X2Fk
ZHIsCj4gPiA+ICAgICAgICAgICAudmhvc3RfZm9yY2VfaW9tbXUgPSB2aG9zdF92ZHBhX2ZvcmNl
X2lvbW11LAo+ID4gPiAgICAgICAgICAgLnZob3N0X3NldF9jb25maWdfY2FsbCA9IHZob3N0X3Zk
cGFfc2V0X2NvbmZpZ19jYWxsLAo+ID4gPiArICAgICAgICAudmhvc3RfcmVzZXRfc3RhdHVzID0g
dmhvc3RfdmRwYV9yZXNldF9zdGF0dXMsCj4gPiA+ICAgfTsKPiA+ID4gZGlmZiAtLWdpdCBhL2h3
L3ZpcnRpby92aG9zdC5jIGIvaHcvdmlydGlvL3Zob3N0LmMKPiA+ID4gaW5kZXggZWI4YzRjMzc4
Yy4uYTI2NjM5NjU3NiAxMDA2NDQKPiA+ID4gLS0tIGEvaHcvdmlydGlvL3Zob3N0LmMKPiA+ID4g
KysrIGIvaHcvdmlydGlvL3Zob3N0LmMKPiA+ID4gQEAgLTIwNDksNiArMjA0OSw5IEBAIHZvaWQg
dmhvc3RfZGV2X3N0b3Aoc3RydWN0IHZob3N0X2RldiAqaGRldiwgVmlydElPRGV2aWNlICp2ZGV2
LCBib29sIHZyaW5ncykKPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGhkZXYt
PnZxcyArIGksCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBoZGV2LT52cV9p
bmRleCArIGkpOwo+ID4gPiAgICAgICB9Cj4gPiA+ICsgICAgaWYgKGhkZXYtPnZob3N0X29wcy0+
dmhvc3RfcmVzZXRfc3RhdHVzKSB7Cj4gPiA+ICsgICAgICAgIGhkZXYtPnZob3N0X29wcy0+dmhv
c3RfcmVzZXRfc3RhdHVzKGhkZXYpOwo+ID4gPiArICAgIH0KPiA+Cj4gPgo+ID4gVGhpcyBsb29r
cyByYWN5LCBpZiB3ZSBkb24ndCBzdXNwZW5kL3Jlc2V0IHRoZSBkZXZpY2UsIGRldmljZSBjYW4g
bW92ZQo+ID4gbGFzdF9hdmFpbF9pZHggZXZlbiBhZnRlciBnZXRfdnJpbmdfYmFzZSgpPwo+ID4K
PiA+IEluc3RlYWQgb2YgZG9pbmcgdGhpbmdzIGxpa2UgdGhpcywgc2hvdWxkIHdlIGZhbGxiYWNr
IHRvCj4gPiB2aXJ0aW9fcXVldWVfcmVzdG9yZV9sYXN0X2F2YWlsX2lkeCgpIGluIHRoaXMgY2Fz
ZT8KPiA+Cj4KPiBSaWdodCwgd2UgY2FuIHRyYWNrIGlmIHRoZSBkZXZpY2UgaXMgc3VzcGVuZGVk
IC8gU1ZRIGFuZCB0aGVuIHJldHVybgo+IGFuIGVycm9yIGluIHZyaW5nX2dldF9iYXNlIGlmIGl0
IGlzIG5vdC4gV291bGQgdGhhdCB3b3JrPwoKV2hlbiB3ZSBkb24ndCBzdXBwb3J0IHN1c3BlbmQs
IHllcy4KClRoYW5rcwoKPgo+IFRoYW5rcyEKPgo+ID4gVGhhbmtzCj4gPgo+ID4KPiA+ID4KPiA+
ID4gICAgICAgaWYgKHZob3N0X2Rldl9oYXNfaW9tbXUoaGRldikpIHsKPiA+ID4gICAgICAgICAg
IGlmIChoZGV2LT52aG9zdF9vcHMtPnZob3N0X3NldF9pb3RsYl9jYWxsYmFjaykgewo+ID4KPgo+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
