Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440B5EE6421
	for <virtualization@archiver.kernel.org>; Fri, 15 Sep 2023 06:53:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BB06E416E0;
	Fri, 15 Sep 2023 06:53:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BB06E416E0
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JYEPIGeC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 55qdUmD8PaTN; Fri, 15 Sep 2023 06:53:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 24F444061F;
	Fri, 15 Sep 2023 06:53:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 24F444061F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01E21C0039;
	Fri, 15 Sep 2023 06:53:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 634F4C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 06:53:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3C73040950
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 06:53:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3C73040950
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JYEPIGeC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jS0PNqs9ACNY
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 06:53:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 25F8C40900
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 06:53:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 25F8C40900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694760829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1yo/ltbu6gyQyMT5IUFnw0353h8EE843EVbYpVcgDCY=;
 b=JYEPIGeCph3fdj8PaNdyLOo+v6/0QjAno/GsCLH3RppOuyUx2ABmRFCnCfBPki59ndU99B
 KUshVnhsyntPgU5D2wwBsMWSOZWq6hf2/1SY8YRykATiO+W9tmrGk7X1EuCWIOvItEBKiQ
 9OGEg0jbFdqL73msva9THFx+j3lZKGE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-162Llmg5Ou23BqaFIMa8wA-1; Fri, 15 Sep 2023 02:53:48 -0400
X-MC-Unique: 162Llmg5Ou23BqaFIMa8wA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-502ea9d36a4so1649483e87.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Sep 2023 23:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694760827; x=1695365627;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1yo/ltbu6gyQyMT5IUFnw0353h8EE843EVbYpVcgDCY=;
 b=qcZKyQ/HORSd09hKXaTg+NnaLJPmaNanAD0TwEqMvFpSabsAYj47VhoTNDFHoTGaMi
 OLTfotEKU9SzuU/bWirJoGBlLT1pfiFEwlT/lM9HJB+eDpfNoGRmm1ZZ3lCYLxgQNN03
 szDSXYAyml2GO0kUIvyCvy+9yjoPJVEKgCuqpx/id2ELOEWet40xpRSzhE29h38CrP6K
 E3D9krGfayCriOCDr4X9sroDlt535g+2yFtGJuKse/lyC5/qf7B2JjxK5BuqIW7pQOpT
 atQ92CvNNN/Jbcy5jEU9TNoct1StrGvnwDLBr24R8tCuLCBbfMrA5332uq3BCmFCtj0B
 I4zQ==
X-Gm-Message-State: AOJu0YyfR9PrPjpp/enGF8YqXpGzrJUfTaylW14VHrFcGpTJHTCh+ckJ
 MuiKsfALG/7gBGdjSUbobJM7DSKbTuYPhkVUvN40aIrVKN52oOj15BPPi6Aforjth1S5uLnc5FR
 Gtaf6r8RNxZwtWIGtpegip5DmxH8959G++9AiBaWHTYEWJ+9+jLpl0s6nIQ==
X-Received: by 2002:a05:6512:2118:b0:4fb:bef0:948e with SMTP id
 q24-20020a056512211800b004fbbef0948emr756376lfr.5.1694760826848; 
 Thu, 14 Sep 2023 23:53:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUH4I6aV5QreN6mk31ZBMA6OFB1mVM2TE0phoCc5O/m60tRNYb9K8GAZYxOqPql8v8ND7yp1NfW/D+aXFo530=
X-Received: by 2002:a05:6512:2118:b0:4fb:bef0:948e with SMTP id
 q24-20020a056512211800b004fbbef0948emr756367lfr.5.1694760826555; Thu, 14 Sep
 2023 23:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230829174014.928189-2-dtatulea@nvidia.com>
In-Reply-To: <20230829174014.928189-2-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 15 Sep 2023 14:53:35 +0800
Message-ID: <CACGkMEuQHsWi=FkKyRQk_tg8-gBjLfr9K48LzK9t9DKbaHga5w@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Fix double release of debugfs entry
To: Dragos Tatulea <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Gal Pressman <gal@nvidia.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

T24gV2VkLCBBdWcgMzAsIDIwMjMgYXQgMTo0MOKAr0FNIERyYWdvcyBUYXR1bGVhIDxkdGF0dWxl
YUBudmlkaWEuY29tPiB3cm90ZToKPgo+IFRoZSBlcnJvciBwYXRoIGluIHNldHVwX2RyaXZlciBk
ZWxldGVzIHRoZSBkZWJ1Z2ZzIGVudHJ5IGJ1dCBkb2Vzbid0Cj4gY2xlYXIgdGhlIHBvaW50ZXIu
IER1cmluZyAuZGV2X2RlbCB0aGUgaW52YWxpZCBwb2ludGVyIHdpbGwgYmUgcmVsZWFzZWQKPiBh
Z2FpbiBjYXVzaW5nIGEgY3Jhc2guCj4KPiBUaGlzIHBhdGNoIGZpeGVzIHRoZSBpc3N1ZSBieSBh
bHdheXMgY2xlYXJpbmcgdGhlIGRlYnVnZnMgZW50cnkgaW4KPiBtbHg1X3ZkcGFfcmVtb3ZlX2Rl
YnVnZnMuIEFsc28sIHN0b3AgcmVtb3ZpbmcgdGhlIGRlYnVnZnMgZW50cnkgaW4KPiAuZGV2X2Rl
bCBvcDogdGhlIGRlYnVnZnMgZW50cnkgaXMgYWxyZWFkeSBoYW5kbGVkIHdpdGhpbiB0aGUKPiBz
ZXR1cF9kcml2ZXIvdGVhcmRvd25fZHJpdmVyIHNjb3BlLgo+Cj4gRml4ZXM6IGYwNDE3ZTcyYWRk
NSAoInZkcGEvbWx4NTogQWRkIGFuZCByZW1vdmUgZGVidWdmcyBpbiBzZXR1cC90ZWFyZG93biBk
cml2ZXIiKQo+IFNpZ25lZC1vZmYtYnk6IERyYWdvcyBUYXR1bGVhIDxkdGF0dWxlYUBudmlkaWEu
Y29tPgo+IFJldmlld2VkLWJ5OiBHYWwgUHJlc3NtYW4gPGdhbEBudmlkaWEuY29tPgoKQWNrZWQt
Ynk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MKCj4gLS0tCj4gIGRy
aXZlcnMvdmRwYS9tbHg1L25ldC9kZWJ1Zy5jICAgICB8IDUgKysrLS0KPiAgZHJpdmVycy92ZHBh
L21seDUvbmV0L21seDVfdm5ldC5jIHwgNyArKy0tLS0tCj4gIGRyaXZlcnMvdmRwYS9tbHg1L25l
dC9tbHg1X3ZuZXQuaCB8IDIgKy0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyks
IDggZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L2Rl
YnVnLmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvZGVidWcuYwo+IGluZGV4IDYwZDZhYzY4Y2Rj
NC4uOWM4NTE2MmMxOWZjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9kZWJ1
Zy5jCj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L2RlYnVnLmMKPiBAQCAtMTQ2LDcgKzE0
Niw4IEBAIHZvaWQgbWx4NV92ZHBhX2FkZF9kZWJ1Z2ZzKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpu
ZGV2KQo+ICAgICAgICAgICAgICAgICBuZGV2LT5yeF9kZW50ID0gZGVidWdmc19jcmVhdGVfZGly
KCJyeCIsIG5kZXYtPmRlYnVnZnMpOwo+ICB9Cj4KPiAtdm9pZCBtbHg1X3ZkcGFfcmVtb3ZlX2Rl
YnVnZnMoc3RydWN0IGRlbnRyeSAqZGJnKQo+ICt2b2lkIG1seDVfdmRwYV9yZW1vdmVfZGVidWdm
cyhzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldikKPiAgewo+IC0gICAgICAgZGVidWdmc19yZW1v
dmVfcmVjdXJzaXZlKGRiZyk7Cj4gKyAgICAgICBkZWJ1Z2ZzX3JlbW92ZV9yZWN1cnNpdmUobmRl
di0+ZGVidWdmcyk7Cj4gKyAgICAgICBuZGV2LT5kZWJ1Z2ZzID0gTlVMTDsKPiAgfQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgYi9kcml2ZXJzL3ZkcGEv
bWx4NS9uZXQvbWx4NV92bmV0LmMKPiBpbmRleCAzN2JlOTQ1YTAyMzAuLmY5MWM5MzhiNGJlMSAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiArKysgYi9k
cml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiBAQCAtMjcxMyw3ICsyNzEzLDcgQEAg
c3RhdGljIGludCBzZXR1cF9kcml2ZXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2KQo+ICBl
cnJfcnF0Ogo+ICAgICAgICAgdGVhcmRvd25fdmlydHF1ZXVlcyhuZGV2KTsKPiAgZXJyX3NldHVw
Ogo+IC0gICAgICAgbWx4NV92ZHBhX3JlbW92ZV9kZWJ1Z2ZzKG5kZXYtPmRlYnVnZnMpOwo+ICsg
ICAgICAgbWx4NV92ZHBhX3JlbW92ZV9kZWJ1Z2ZzKG5kZXYpOwo+ICBvdXQ6Cj4gICAgICAgICBy
ZXR1cm4gZXJyOwo+ICB9Cj4gQEAgLTI3MjcsOCArMjcyNyw3IEBAIHN0YXRpYyB2b2lkIHRlYXJk
b3duX2RyaXZlcihzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldikKPiAgICAgICAgIGlmICghbmRl
di0+c2V0dXApCj4gICAgICAgICAgICAgICAgIHJldHVybjsKPgo+IC0gICAgICAgbWx4NV92ZHBh
X3JlbW92ZV9kZWJ1Z2ZzKG5kZXYtPmRlYnVnZnMpOwo+IC0gICAgICAgbmRldi0+ZGVidWdmcyA9
IE5VTEw7Cj4gKyAgICAgICBtbHg1X3ZkcGFfcmVtb3ZlX2RlYnVnZnMobmRldik7Cj4gICAgICAg
ICB0ZWFyZG93bl9zdGVlcmluZyhuZGV2KTsKPiAgICAgICAgIGRlc3Ryb3lfdGlyKG5kZXYpOwo+
ICAgICAgICAgZGVzdHJveV9ycXQobmRldik7Cj4gQEAgLTM0ODksOCArMzQ4OCw2IEBAIHN0YXRp
YyB2b2lkIG1seDVfdmRwYV9kZXZfZGVsKHN0cnVjdCB2ZHBhX21nbXRfZGV2ICp2X21kZXYsIHN0
cnVjdCB2ZHBhX2RldmljZSAqCj4gICAgICAgICBzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldiA9
IHRvX21seDVfdmRwYV9uZGV2KG12ZGV2KTsKPiAgICAgICAgIHN0cnVjdCB3b3JrcXVldWVfc3Ry
dWN0ICp3cTsKPgo+IC0gICAgICAgbWx4NV92ZHBhX3JlbW92ZV9kZWJ1Z2ZzKG5kZXYtPmRlYnVn
ZnMpOwo+IC0gICAgICAgbmRldi0+ZGVidWdmcyA9IE5VTEw7Cj4gICAgICAgICB1bnJlZ2lzdGVy
X2xpbmtfbm90aWZpZXIobmRldik7Cj4gICAgICAgICBfdmRwYV91bnJlZ2lzdGVyX2RldmljZShk
ZXYpOwo+ICAgICAgICAgd3EgPSBtdmRldi0+d3E7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRw
YS9tbHg1L25ldC9tbHg1X3ZuZXQuaCBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQu
aAo+IGluZGV4IDM2YzQ0ZDlmZGQxNi4uNjBjZGJjOTAzMDM3IDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuaAo+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25l
dC9tbHg1X3ZuZXQuaAo+IEBAIC04OCw3ICs4OCw3IEBAIHN0cnVjdCBtYWN2bGFuX25vZGUgewo+
ICB9Owo+Cj4gIHZvaWQgbWx4NV92ZHBhX2FkZF9kZWJ1Z2ZzKHN0cnVjdCBtbHg1X3ZkcGFfbmV0
ICpuZGV2KTsKPiAtdm9pZCBtbHg1X3ZkcGFfcmVtb3ZlX2RlYnVnZnMoc3RydWN0IGRlbnRyeSAq
ZGJnKTsKPiArdm9pZCBtbHg1X3ZkcGFfcmVtb3ZlX2RlYnVnZnMoc3RydWN0IG1seDVfdmRwYV9u
ZXQgKm5kZXYpOwo+ICB2b2lkIG1seDVfdmRwYV9hZGRfcnhfZmxvd190YWJsZShzdHJ1Y3QgbWx4
NV92ZHBhX25ldCAqbmRldik7Cj4gIHZvaWQgbWx4NV92ZHBhX3JlbW92ZV9yeF9mbG93X3RhYmxl
KHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2KTsKPiAgdm9pZCBtbHg1X3ZkcGFfYWRkX3Rpcm4o
c3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYpOwo+IC0tCj4gMi40MS4wCj4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
