Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41A3C7618D
	for <virtualization@archiver.kernel.org>; Mon, 20 Mar 2023 09:29:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4BE85813B6;
	Mon, 20 Mar 2023 09:29:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4BE85813B6
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b6CgPKwE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NRsLC3oUXBwB; Mon, 20 Mar 2023 09:29:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CEDCB81298;
	Mon, 20 Mar 2023 09:29:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CEDCB81298
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A61DCC0035;
	Mon, 20 Mar 2023 09:29:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B791C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 09:29:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4265760BBB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 09:29:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4265760BBB
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=b6CgPKwE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KRmgbjO2jtbT
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 09:29:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 58CBE60BB2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 58CBE60BB2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 09:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679304538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qTo+q2mElfHa9MVBWRK6r8wHoJ3lJbSbXymOTEaYkSM=;
 b=b6CgPKwEu2i9PaN7MCdC1Msg4EnSYDE/heOeotP5ui36wEgR13AWcGHz7VVS36Y2bAAYyE
 XI9PU291CgDLBgbFKm01mZlWaYCsMo6kYokd5cBZNlXz2v8hVwl28VvrxPVOKzjB6qepQn
 DAvFhs1AUdNkh8rzK3WbyeuCrHLSMb8=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-627-1KGrCr_oMo-Pg4ufPF7mlA-1; Mon, 20 Mar 2023 05:28:57 -0400
X-MC-Unique: 1KGrCr_oMo-Pg4ufPF7mlA-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-17e3d37b3e6so988236fac.22
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 02:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679304537;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qTo+q2mElfHa9MVBWRK6r8wHoJ3lJbSbXymOTEaYkSM=;
 b=uJsm4V83qXp6TTIeh4kSblKZAtUi49pnAcs62LrvGhlRiGTmTWPVHyxBmEWGqsCQF0
 oc0WOgt9RLvktffl3f2GgxSNIXGyg+mYQtLEgkFRYOsKQkb/E+oSMFdprdatb68O2KNF
 OLqjk6siJa91Hi1nglsDPPXECaaqaZ6DTh5X5h/+Hrc5wRax0BBT5VFHzHy2NY77awOR
 1rvFUQpGrdltlBlYFLh8YhYoVaoLZh9LG1LQHVzro1LKsOg4OXzIeq5uB9kut0OpM1Q0
 qxUA1P9M3HnwUkdgewIj/Owqk3If0oVKlyWqSiLlXWkFRDaanddZf5URRtLJaiugCEDn
 jDKw==
X-Gm-Message-State: AO0yUKV31rsZGs7fJs7CcRDLafujZS2nsaNq6ZyobhCyD6H/xZYbP6YS
 kqH6Y+40JLfcQKuxwTrEXbotYb3FltzeM5AmkYSZvyCzo2uj3F2bNugzwhKSQtsD0ewnpYVcw4J
 2teVAOPKlqDvs/AsYuYrCx2tgRLUHLlGkyohQBdEx0rm1qxKrQQrrlNLEQw==
X-Received: by 2002:a9d:66d3:0:b0:69f:229:ce72 with SMTP id
 t19-20020a9d66d3000000b0069f0229ce72mr2283169otm.2.1679304537075; 
 Mon, 20 Mar 2023 02:28:57 -0700 (PDT)
X-Google-Smtp-Source: AK7set+naF0+AdAwjPTbVTwa4amUqsUTHhHnZwbGLsZfXTy8lB7stvSwLXxs9D0f4RPkSlU3fRAu7Gm30ncQulkR4vQ=
X-Received: by 2002:a9d:66d3:0:b0:69f:229:ce72 with SMTP id
 t19-20020a9d66d3000000b0069f0229ce72mr2283164otm.2.1679304536804; Mon, 20 Mar
 2023 02:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230312084137.2300100-1-elic@nvidia.com>
 <CACGkMEsgyOMmVcj-5eEBtHMKqR5Z03tiuHbUK3opZQ_93tSbBw@mail.gmail.com>
 <0be81bfe-401c-6c2e-ed24-28b152a5ba7c@nvidia.com>
In-Reply-To: <0be81bfe-401c-6c2e-ed24-28b152a5ba7c@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Mar 2023 17:28:45 +0800
Message-ID: <CACGkMEuQmH8FrOMyAo5YFkCi6ptavmY+HUvterWJsU_a95+QbQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Remove debugfs file after device unregister
To: Eli Cohen <elic@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 parav@mellanox.com, mst@redhat.com
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

T24gTW9uLCBNYXIgMjAsIDIwMjMgYXQgNTowN+KAr1BNIEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEu
Y29tPiB3cm90ZToKPgo+IE9uIDE3LzAzLzIwMjMgNTozMiwgSmFzb24gV2FuZyB3cm90ZToKPiA+
IE9uIFN1biwgTWFyIDEyLCAyMDIzIGF0IDQ6NDHigK9QTSBFbGkgQ29oZW4gPGVsaWNAbnZpZGlh
LmNvbT4gd3JvdGU6Cj4gPj4gV2hlbiBkZWxldGluZyB0aGUgdmRwYSBkZXZpY2UsIHRoZSBkZWJ1
Z2ZzIGZpbGVzIG5lZWQgdG8gYmUgcmVtb3ZlZCBzbwo+ID4+IG5lZWQgdG8gcmVtb3ZlIGRlYnVn
ZnMgYWZ0ZXIgdGhlIGRldmljZSBoYXMgYmVlbiB1bnJlZ2lzdGVyZWQuCj4gPj4KPiA+PiBUaGlz
IGZpeGVzIG51bGwgcG9pbnRlciBkZXJlZmVyZW5jZSB3aGVuIHNvbWVvbmUgZGVsZXRlcyB0aGUg
ZGV2aWNlCj4gPj4gYWZ0ZXIgZGVidWdmcyBoYXMgYmVlbiBwb3B1bGF0ZWQuCj4gPj4KPiA+PiBG
aXhlczogMjk0MjIxMDA0MzIyICgidmRwYS9tbHg1OiBBZGQgZGVidWdmcyBzdWJ0cmVlIikKPiA+
PiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPiA+PiAtLS0KPiA+
PiAgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDQgKystLQo+ID4+ICAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiA+Pgo+ID4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgYi9kcml2ZXJzL3Zk
cGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+PiBpbmRleCAzODU4YmExZTg5NzUuLjNmNjE0OWYy
ZmZkNCAxMDA2NDQKPiA+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMK
PiA+PiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+PiBAQCAtMzMy
Miw4ICszMzIyLDYgQEAgc3RhdGljIHZvaWQgbWx4NV92ZHBhX2Rldl9kZWwoc3RydWN0IHZkcGFf
bWdtdF9kZXYgKnZfbWRldiwgc3RydWN0IHZkcGFfZGV2aWNlICoKPiA+PiAgICAgICAgICBzdHJ1
Y3QgbWx4NV92ZHBhX25ldCAqbmRldiA9IHRvX21seDVfdmRwYV9uZGV2KG12ZGV2KTsKPiA+PiAg
ICAgICAgICBzdHJ1Y3Qgd29ya3F1ZXVlX3N0cnVjdCAqd3E7Cj4gPj4KPiA+PiAtICAgICAgIG1s
eDVfdmRwYV9yZW1vdmVfZGVidWdmcyhuZGV2LT5kZWJ1Z2ZzKTsKPiA+PiAtICAgICAgIG5kZXYt
PmRlYnVnZnMgPSBOVUxMOwo+ID4+ICAgICAgICAgIGlmIChuZGV2LT5uYl9yZWdpc3RlcmVkKSB7
Cj4gPj4gICAgICAgICAgICAgICAgICBuZGV2LT5uYl9yZWdpc3RlcmVkID0gZmFsc2U7Cj4gPj4g
ICAgICAgICAgICAgICAgICBtbHg1X25vdGlmaWVyX3VucmVnaXN0ZXIobXZkZXYtPm1kZXYsICZu
ZGV2LT5uYik7Cj4gPj4gQEAgLTMzMzIsNiArMzMzMCw4IEBAIHN0YXRpYyB2b2lkIG1seDVfdmRw
YV9kZXZfZGVsKHN0cnVjdCB2ZHBhX21nbXRfZGV2ICp2X21kZXYsIHN0cnVjdCB2ZHBhX2Rldmlj
ZSAqCj4gPj4gICAgICAgICAgbXZkZXYtPndxID0gTlVMTDsKPiA+PiAgICAgICAgICBkZXN0cm95
X3dvcmtxdWV1ZSh3cSk7Cj4gPj4gICAgICAgICAgX3ZkcGFfdW5yZWdpc3Rlcl9kZXZpY2UoZGV2
KTsKPiA+IFdoYXQgaWYgdGhlIHVzZXIgdHJpZXMgdG8gYWNjZXNzIGRlYnVnZnMgYWZ0ZXIgX3Zk
cGFfdW5yZWdpc3Rlcl9kZXZpY2UoKT8KPiBJIGRvbid0IHNlZSBhbiBpc3N1ZSB3aXRoIHRoYXQu
IER1cmluZyB0aGUgcHJvY2VzcyBvZiBkZWxldGluZyBhIGRldmljZSwKPiB0aGUgcmVzb3VyY2Vz
IGFyZSBkZXN0cm95ZWQgYW5kIHRoZWlyIGNvcnJlc3BvbmRpbmcgZGVidWdmcyBmaWxlcyBhcmUK
PiBhbHNvIGRlc3Ryb3llZCBqdXN0IHByaW9yIHRvIGRlc3Ryb3lpbmcgdGhlIHJlc291cmNlLgoK
Rm9yIGV4YW1wbGUsIHJ4X2Zsb3dfdGFibGVfc2hvdygpIHJlcXVpcmVzIHRoZSBzdHJ1Y3R1cmUg
bWx4NV92ZHBhX25ldAphbGl2ZSwgYnV0IGl0IHNlZW1zIHRoZSBzdHJ1Y3R1cmUgaGFzIGJlZW4g
ZnJlZWQgYWZ0ZXIKX3ZkcGFfdW5yZWdpc3Rlcl9kZXZpY2UoKS4KCklmIGEgdXNlciB0cmllcyB0
byBhY2Nlc3MgdGhhdCBmaWxlIGFmdGVyIF92ZHBhX3VucmVnaXN0ZXJfZGV2aWNlKCkKYnV0IGJl
Zm9yZSBtbHg1X3ZkcGFfcmVtb3ZlX2RlYnVnZnMoKSwgd2lsbCB3ZSBlbmQgdXAgd2l0aAp1c2Ut
YWZ0ZXItZnJlZT8KClRoYW5rcwoKCj4gPgo+ID4gVGhhbmtzCj4gPgo+ID4+ICsgICAgICAgbWx4
NV92ZHBhX3JlbW92ZV9kZWJ1Z2ZzKG5kZXYtPmRlYnVnZnMpOwo+ID4+ICsgICAgICAgbmRldi0+
ZGVidWdmcyA9IE5VTEw7Cj4gPj4gICAgICAgICAgbWd0ZGV2LT5uZGV2ID0gTlVMTDsKPiA+PiAg
IH0KPiA+Pgo+ID4+IC0tCj4gPj4gMi4zOC4xCj4gPj4KPgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
