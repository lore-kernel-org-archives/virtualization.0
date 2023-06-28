Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B8CEB64D7
	for <virtualization@archiver.kernel.org>; Wed, 28 Jun 2023 08:09:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1F6D44032B;
	Wed, 28 Jun 2023 08:09:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1F6D44032B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dh5708f/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dq5VbldP0Kx4; Wed, 28 Jun 2023 08:09:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9A1BC40420;
	Wed, 28 Jun 2023 08:09:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9A1BC40420
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4EC9DC007C;
	Wed, 28 Jun 2023 08:09:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5E01C0037
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 08:08:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9150C40219
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 08:08:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9150C40219
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dh5708f/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hLj2RrCJI1CV
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 08:08:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 13B9940142
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 13B9940142
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 08:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687939736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JpBHuqgFMq924SVEU5PVhg79o4Lnwc8I8AxFIOnjXWg=;
 b=dh5708f/Iwt4qLGW8K/P4BlgWJ5K0NYOYFtYOLQKgyWLdof+3Vo5QO8JkE8B+KIKP2LxDL
 FcnzrpAQVWPiQWBMeE69OeVDc4SE5GNzR4r0t2WvnQCJF3/zQwsAkWpWHQby+3X6TYfhAi
 weyw1ChQ0cQMMhbMthmM0TpEWhJru2Q=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-901LgHCaO2uVB3jXpZiVSA-1; Wed, 28 Jun 2023 04:08:53 -0400
X-MC-Unique: 901LgHCaO2uVB3jXpZiVSA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b699c5f238so28643701fa.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 01:08:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687939732; x=1690531732;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JpBHuqgFMq924SVEU5PVhg79o4Lnwc8I8AxFIOnjXWg=;
 b=X6/6SPe2hwfzuiBM50dGxN1rhcQhuOcIfEdGRUi1wds2GQPwRUwcFW31uCMN0J9rYs
 m+x+VvFl2cSPcaRR8HZuKnJf2fBWSs111oOitK6DUtmtx14ktlxc4xssDWRViRXKmeFq
 BCmzenFl6xJ9IWwbcHpWmMbDRqOeWv4BbM1YK+iV7llgtjKaN5flkYnkAeOJbUpnZN64
 4G1pz8H7AQLNPWckCY1bvRD2hP+E7b1bMblUySgD/aVB8zpQRMvYbA9n/17zze7MU5zD
 o4Y1TDutwA+fCSbAorcoAOfUsNfbs5L06rp5wOc+WY8wJ83847wV1IYGbba6GibK0U9j
 DSlg==
X-Gm-Message-State: AC+VfDwT3VldTX0DzfYISzvYsIOXZZ0tZKIL+jvADL2GNQ7ngEZUydp7
 LHG0G2i0ktZKLgnxK7qoYK7eixS+ulZkJ/VxXOY47zqYRSbkMO9Bu+gAIZbn3XRv7kxmgBsED8c
 Shd0iS9L8bqYo+4oAaPWf2iCwWVOMF22mQk23wH0lywDO/3isSnuXiIRd0g==
X-Received: by 2002:a2e:6a10:0:b0:2b6:a76b:c39e with SMTP id
 f16-20020a2e6a10000000b002b6a76bc39emr4223204ljc.35.1687939731900; 
 Wed, 28 Jun 2023 01:08:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5+2Gicsdplyts+dFUSGHhnRnz2PbkDycBiBNT+Jwcbz1g8KzKNLvTR0NgEfWGTD+ab672YFJAqtl48gc9cCKM=
X-Received: by 2002:a2e:6a10:0:b0:2b6:a76b:c39e with SMTP id
 f16-20020a2e6a10000000b002b6a76bc39emr4223191ljc.35.1687939731611; Wed, 28
 Jun 2023 01:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230628065919.54042-1-lulu@redhat.com>
 <20230628065919.54042-3-lulu@redhat.com>
In-Reply-To: <20230628065919.54042-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 28 Jun 2023 16:08:39 +0800
Message-ID: <CACGkMEuzrFP96qcFL0M=nGiQ9t57-EzOhZmB3No-8T8pMAWTxw@mail.gmail.com>
Subject: Re: [RFC 2/4] vduse: Add file operation for mmap
To: Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, maxime.coquelin@redhat.com
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

T24gV2VkLCBKdW4gMjgsIDIwMjMgYXQgMjo1OeKAr1BNIENpbmR5IEx1IDxsdWx1QHJlZGhhdC5j
b20+IHdyb3RlOgo+Cj4gRnJvbTogWW91ciBOYW1lIDx5b3VAZXhhbXBsZS5jb20+Cj4KPiBBZGQg
dGhlIG9wZXJhdGlvbiBmb3IgbW1hcCwgVGhlIHVzZXIgc3BhY2UgQVBQIHdpbGwKPiB1c2UgdGhp
cyBmdW5jdGlvbiB0byBtYXAgdGhlIHBhZ2VzIHRvIHVzZXJzcGFjZQoKUGxlYXNlIGJlIHNwZWNp
ZmljIGluIHRoZSBsb2cuIEUuZyB3aHkgYW5kIHdoYXQgdGhlIG1haW4gZ29hbCBmb3IgdGhpcyBt
bWFwLgoKPgo+IFNpZ25lZC1vZmYtYnk6IENpbmR5IEx1IDxsdWx1QHJlZGhhdC5jb20+Cj4gLS0t
Cj4gIGRyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMgfCA0OSArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDQ5IGluc2VydGlvbnMoKykKPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jIGIvZHJpdmVy
cy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYwo+IGluZGV4IGY4NDVkYzQ2YjFkYi4uMWI4MzNi
ZjBhZTM3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMK
PiArKysgYi9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jCj4gQEAgLTEzMTMsNiAr
MTMxMyw1NCBAQCBzdGF0aWMgc3RydWN0IHZkdXNlX2RldiAqdmR1c2VfZGV2X2dldF9mcm9tX21p
bm9yKGludCBtaW5vcikKPiAgICAgICAgIHJldHVybiBkZXY7Cj4gIH0KPgo+ICsKPiArc3RhdGlj
IHZtX2ZhdWx0X3QgdmR1c2Vfdm1fZmF1bHQoc3RydWN0IHZtX2ZhdWx0ICp2bWYpCj4gK3sKPiAr
ICAgICAgIHN0cnVjdCB2ZHVzZV9kZXYgKmRldiA9IHZtZi0+dm1hLT52bV9maWxlLT5wcml2YXRl
X2RhdGE7Cj4gKyAgICAgICBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSA9IHZtZi0+dm1hOwo+
ICsgICAgICAgdTE2IGluZGV4ID0gdm1hLT52bV9wZ29mZjsKPiArCj4gKyAgICAgICBzdHJ1Y3Qg
dmRwYV9yZWNvbm5lY3RfaW5mbyAqaW5mbzsKPiArICAgICAgIGluZm8gPSAmZGV2LT5yZWNvbm5l
Y3RfaW5mb1tpbmRleF07Cj4gKwo+ICsgICAgICAgdm1hLT52bV9wYWdlX3Byb3QgPSBwZ3Byb3Rf
bm9uY2FjaGVkKHZtYS0+dm1fcGFnZV9wcm90KTsKPiArICAgICAgIGlmIChyZW1hcF9wZm5fcmFu
Z2Uodm1hLCB2bWYtPmFkZHJlc3MgJiBQQUdFX01BU0ssIFBGTl9ET1dOKGluZm8tPmFkZHIpLAo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBQQUdFX1NJWkUsIHZtYS0+dm1fcGFnZV9wcm90
KSkKCkknbSBub3Qgc3VyZSBpZiB0aGlzIGNhbiB3b3JrIGUuZyBkbyB3ZSB3YW50IHRvIHVzZSBz
ZXBhcmF0ZSBwYWdlcyBmb3IKZWFjaCB2aXJ0cXVldWUgKEkgdGhpbmsgdGhlIGFuc3dlciBpcyB5
ZXMpLgoKPiArICAgICAgICAgICAgICAgcmV0dXJuIFZNX0ZBVUxUX1NJR0JVUzsKPiArICAgICAg
IHJldHVybiBWTV9GQVVMVF9OT1BBR0U7Cj4gK30KPiArCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
dm1fb3BlcmF0aW9uc19zdHJ1Y3QgdmR1c2Vfdm1fb3BzID0gewo+ICsgICAgICAgLmZhdWx0ID0g
dmR1c2Vfdm1fZmF1bHQsCj4gK307Cj4gKwo+ICtzdGF0aWMgaW50IHZkdXNlX21tYXAoc3RydWN0
IGZpbGUgKmZpbGUsIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKQo+ICt7Cj4gKyAgICAgICBz
dHJ1Y3QgdmR1c2VfZGV2ICpkZXYgPSBmaWxlLT5wcml2YXRlX2RhdGE7Cj4gKyAgICAgICBzdHJ1
Y3QgdmRwYV9yZWNvbm5lY3RfaW5mbyAqaW5mbzsKPiArICAgICAgIHVuc2lnbmVkIGxvbmcgaW5k
ZXggPSB2bWEtPnZtX3Bnb2ZmOwo+ICsKPiArICAgICAgIGlmICh2bWEtPnZtX2VuZCAtIHZtYS0+
dm1fc3RhcnQgIT0gUEFHRV9TSVpFKQo+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsK
PiArICAgICAgIGlmICgodm1hLT52bV9mbGFncyAmIFZNX1NIQVJFRCkgPT0gMCkKPiArICAgICAg
ICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4gKwo+ICsgICAgICAgaWYgKGluZGV4ID4gNjU1MzUp
Cj4gKyAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+ICsKPiArICAgICAgIGluZm8gPSAm
ZGV2LT5yZWNvbm5lY3RfaW5mb1tpbmRleF07Cj4gKyAgICAgICBpZiAoaW5mby0+YWRkciAmIChQ
QUdFX1NJWkUgLSAxKSkKPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4gKyAgICAg
ICBpZiAodm1hLT52bV9lbmQgLSB2bWEtPnZtX3N0YXJ0ICE9IGluZm8tPnNpemUpIHsKPiArICAg
ICAgICAgICAgICAgcmV0dXJuIC1FTk9UU1VQUDsKPiArICAgICAgIH0KCkhvdyBjYW4gdXNlcnNw
YWNlIGtub3cgdGhlIGNvcnJlY3Qgc2l6ZSAoaW5mby0+c2l6ZSkgaGVyZT8KCj4gKwo+ICsgICAg
ICAgdm1fZmxhZ3Nfc2V0KHZtYSwgVk1fSU8gfCBWTV9QRk5NQVAgfCBWTV9ET05URVhQQU5EIHwg
Vk1fRE9OVERVTVApOwoKV2h5IGRvIHlvdSBuZWVkIFZNX0lPLCBWTV9QRk5NQVAgYW5kIFZNX0RP
TlREVU1QIGhlcmU/CgpUaGFua3MKCj4gKyAgICAgICB2bWEtPnZtX29wcyA9ICZ2ZHVzZV92bV9v
cHM7Cj4gKwo+ICsgICAgICAgcmV0dXJuIDA7Cj4gK30KPiArCj4gIHN0YXRpYyBpbnQgdmR1c2Vf
ZGV2X29wZW4oc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGUpCj4gIHsKPiAg
ICAgICAgIGludCByZXQ7Cj4gQEAgLTEzNDUsNiArMTM5Myw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgZmlsZV9vcGVyYXRpb25zIHZkdXNlX2Rldl9mb3BzID0gewo+ICAgICAgICAgLnVubG9ja2Vk
X2lvY3RsID0gdmR1c2VfZGV2X2lvY3RsLAo+ICAgICAgICAgLmNvbXBhdF9pb2N0bCAgID0gY29t
cGF0X3B0cl9pb2N0bCwKPiAgICAgICAgIC5sbHNlZWsgICAgICAgICA9IG5vb3BfbGxzZWVrLAo+
ICsgICAgICAgLm1tYXAgICAgICAgICAgID0gdmR1c2VfbW1hcCwKPiAgfTsKPgo+ICBzdGF0aWMg
c3RydWN0IHZkdXNlX2RldiAqdmR1c2VfZGV2X2NyZWF0ZSh2b2lkKQo+IC0tCj4gMi4zNC4zCj4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
