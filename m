Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5FFC6FD1D
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 13:10:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 62F7860640;
	Tue, 21 Mar 2023 13:10:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 62F7860640
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gEdoZO1V
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n0XEaKGb-EsE; Tue, 21 Mar 2023 13:10:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8AA67605A3;
	Tue, 21 Mar 2023 13:10:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8AA67605A3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61B98C0035;
	Tue, 21 Mar 2023 13:10:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49C90C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 13:10:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1E876417D9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 13:10:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1E876417D9
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gEdoZO1V
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u_-x1bleHyYw
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 13:10:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B01E8417D1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B01E8417D1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 13:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679404231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LHioC2Bz+LhXLt/kWCD/RKd45AYTVWaKEiEQ85K6IJk=;
 b=gEdoZO1V+u5JBwfSdSamO7ckHHSmCzYZdhSDhWww+EbRzJOUVzY9F27A+dfbFVVMXf5Ujq
 Fb4mRHaUsA07CMdYDeZ/UueXZqTndmi0Q/vrjbWQ9RL+P1ZcoReC/xJr8bbCkQu4LWAnKT
 GmlnPb6TR40ZafcFFa1DMxpxxBa9K9I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-gQg3QGrOOUS7pjercg99cw-1; Tue, 21 Mar 2023 09:10:26 -0400
X-MC-Unique: gQg3QGrOOUS7pjercg99cw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC75A96DC85;
 Tue, 21 Mar 2023 13:10:25 +0000 (UTC)
Received: from localhost (unknown [10.39.193.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 56696140E95F;
 Tue, 21 Mar 2023 13:10:25 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Viktor Prutyanov <viktor@daynix.com>
Subject: Re: [PATCH v2] virtio: add VIRTIO_F_NOTIFICATION_DATA feature support
In-Reply-To: <20230321050719-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20230320232115.1940587-1-viktor@daynix.com>
 <CACGkMEu5qa2KUHti3w59DcXNxBdh8_ogZ9oW9bo1_PHwbNiCBg@mail.gmail.com>
 <CAPv0NP5wTMG=3kT_FX4xi9kGbX0Dah4qTQfFQPutWYsWvK1i-g@mail.gmail.com>
 <20230321050719-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Tue, 21 Mar 2023 14:10:23 +0100
Message-ID: <87jzzamerk.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Cc: linux-s390@vger.kernel.org, farman@linux.ibm.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 pasic@linux.ibm.com, yan@daynix.com
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

T24gVHVlLCBNYXIgMjEgMjAyMywgIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29t
PiB3cm90ZToKCj4gT24gVHVlLCBNYXIgMjEsIDIwMjMgYXQgMTI6MDA6NDJQTSArMDMwMCwgVmlr
dG9yIFBydXR5YW5vdiB3cm90ZToKPj4gT24gVHVlLCBNYXIgMjEsIDIwMjMgYXQgNToyOeKAr0FN
IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+PiA+Cj4+ID4gT24gVHVl
LCBNYXIgMjEsIDIwMjMgYXQgNzoyMeKAr0FNIFZpa3RvciBQcnV0eWFub3YgPHZpa3RvckBkYXlu
aXguY29tPiB3cm90ZToKPj4gPiA+Cj4+ID4gPiBBY2NvcmRpbmcgdG8gVmlydElPIHNwZWMgdjEu
MiwgVklSVElPX0ZfTk9USUZJQ0FUSU9OX0RBVEEgZmVhdHVyZQo+PiA+ID4gaW5kaWNhdGVzIHRo
YXQgdGhlIGRyaXZlciBwYXNzZXMgZXh0cmEgZGF0YSBhbG9uZyB3aXRoIHRoZSBxdWV1ZQo+PiA+
ID4gbm90aWZpY2F0aW9ucy4KPj4gPiA+Cj4+ID4gPiBJbiBhIHNwbGl0IHF1ZXVlIGNhc2UsIHRo
ZSBleHRyYSBkYXRhIGlzIDE2LWJpdCBhdmFpbGFibGUgaW5kZXguIEluIGEKPj4gPiA+IHBhY2tl
ZCBxdWV1ZSBjYXNlLCB0aGUgZXh0cmEgZGF0YSBpcyAxLWJpdCB3cmFwIGNvdW50ZXIgYW5kIDE1
LWJpdAo+PiA+ID4gYXZhaWxhYmxlIGluZGV4Lgo+PiA+ID4KPj4gPiA+IEFkZCBzdXBwb3J0IGZv
ciB0aGlzIGZlYXR1cmUgZm9yIE1NSU8gYW5kIFBDSSB0cmFuc3BvcnRzLiBDaGFubmVsIEkvTwo+
PiA+ID4gdHJhbnNwb3J0IHdpbGwgbm90IGFjY2VwdCB0aGlzIGZlYXR1cmUuCj4+ID4gPgo+PiA+
ID4gU2lnbmVkLW9mZi1ieTogVmlrdG9yIFBydXR5YW5vdiA8dmlrdG9yQGRheW5peC5jb20+Cj4+
ID4gPiAtLS0KPj4gPiA+Cj4+ID4gPiAgdjI6IHJlamVjdCB0aGUgZmVhdHVyZSBpbiB2aXJ0aW9f
Y2N3LCByZXBsYWNlIF9fbGUzMiB3aXRoIHUzMgo+PiA+ID4KPj4gPiA+ICBkcml2ZXJzL3MzOTAv
dmlydGlvL3ZpcnRpb19jY3cuYyAgIHwgIDQgKy0tLQo+PiA+ID4gIGRyaXZlcnMvdmlydGlvL3Zp
cnRpb19tbWlvLmMgICAgICAgfCAxNSArKysrKysrKysrKysrKy0KPj4gPiA+ICBkcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jIHwgMTAgKysrKysrKysrKwo+PiA+ID4gIGRyaXZlcnMv
dmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmggfCAgNCArKysrCj4+ID4gPiAgZHJpdmVycy92aXJ0
aW8vdmlydGlvX3BjaV9sZWdhY3kuYyB8ICAyICstCj4+ID4gPiAgZHJpdmVycy92aXJ0aW8vdmly
dGlvX3BjaV9tb2Rlcm4uYyB8ICAyICstCj4+ID4gPiAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jp
bmcuYyAgICAgICB8IDE3ICsrKysrKysrKysrKysrKysrCj4+ID4gPiAgaW5jbHVkZS9saW51eC92
aXJ0aW9fcmluZy5oICAgICAgICB8ICAyICsrCj4+ID4gPiAgaW5jbHVkZS91YXBpL2xpbnV4L3Zp
cnRpb19jb25maWcuaCB8ICA2ICsrKysrKwo+PiA+ID4gIDkgZmlsZXMgY2hhbmdlZCwgNTYgaW5z
ZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPj4gPiA+Cj4+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9zMzkwL3ZpcnRpby92aXJ0aW9fY2N3LmMgYi9kcml2ZXJzL3MzOTAvdmlydGlvL3ZpcnRp
b19jY3cuYwo+PiA+ID4gaW5kZXggYTEwZGJlNjMyZWY5Li5kNzJhNTk0MTU1MjcgMTAwNjQ0Cj4+
ID4gPiAtLS0gYS9kcml2ZXJzL3MzOTAvdmlydGlvL3ZpcnRpb19jY3cuYwo+PiA+ID4gKysrIGIv
ZHJpdmVycy9zMzkwL3ZpcnRpby92aXJ0aW9fY2N3LmMKPj4gPiA+IEBAIC03ODksOSArNzg5LDcg
QEAgc3RhdGljIHU2NCB2aXJ0aW9fY2N3X2dldF9mZWF0dXJlcyhzdHJ1Y3QgdmlydGlvX2Rldmlj
ZSAqdmRldikKPj4gPiA+Cj4+ID4gPiAgc3RhdGljIHZvaWQgY2N3X3RyYW5zcG9ydF9mZWF0dXJl
cyhzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPj4gPiA+ICB7Cj4+ID4gPiAtICAgICAgIC8q
Cj4+ID4gPiAtICAgICAgICAqIEN1cnJlbnRseSBub3RoaW5nIHRvIGRvIGhlcmUuCj4+ID4gPiAt
ICAgICAgICAqLwo+PiA+ID4gKyAgICAgICBfX3ZpcnRpb19jbGVhcl9iaXQodmRldiwgVklSVElP
X0ZfTk9USUZJQ0FUSU9OX0RBVEEpOwo+PiA+Cj4+ID4gSXMgdGhlcmUgYW55IHJlc3RyaWN0aW9u
IHRoYXQgcHJldmVudHMgdXMgZnJvbSBpbXBsZW1lbnRpbmcKPj4gPiBWSVJUSU9fRl9OT1RJRklD
QVRJT05fREFUQT8gKFNwZWMgc2VlbXMgZG9lc24ndCBsaW1pdCB1cyBmcm9tIHRoaXMpCj4+IAo+
PiBNb3N0IGxpa2VseSwgbm90aGluZy4KPgo+IFNvIHBscyBjb2RlIGl0IHVwLiBJdCdzIHRoZSBz
YW1lIGZvcm1hdC4KCkZXSVcsIHRoZSBub3RpZmljYXRpb24gZGF0YSBuZWVkcyB0byBnbyB2aWEg
dGhlIHRoaXJkIHBhcmFtZXRlciBvZgprdm1faHlwZXJjYWxsMygpIGluIHZpcnRpb19jY3dfa3Zt
X25vdGlmeSgpLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
