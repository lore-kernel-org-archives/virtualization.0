Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146F7EB64DA
	for <virtualization@archiver.kernel.org>; Wed, 28 Jun 2023 08:11:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C9CB60B2D;
	Wed, 28 Jun 2023 08:11:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8C9CB60B2D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gE6cTy7R
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Biu0R0TN3XRA; Wed, 28 Jun 2023 08:11:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 12F0560B38;
	Wed, 28 Jun 2023 08:11:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 12F0560B38
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1F81C007C;
	Wed, 28 Jun 2023 08:11:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38C09C0037
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 08:11:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F270040546
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 08:11:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F270040546
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gE6cTy7R
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KOIaQnxwoSN8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 08:11:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2C635404E9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2C635404E9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 08:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687939905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4cTND2wcrFvf5T3HdGEC88WLZ2tC38KyAB0FmRrOrTk=;
 b=gE6cTy7ReE89ABWsLQF15Ux66eUn2IEM5+2tOzM+jPW7EcsW9bTo79tF/Xn8nelzMXLY8W
 NmFgUwadzhyfVkqXGeFFBVzH1+GYwirNP/MfZOtYayGxXUUDnhHllo18zDQrznyDqboDMK
 YqwPaNmV6TMC5B0BNAc61rQ0miitxVc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-5vXoRlceOWqIW5fiHlV4qQ-1; Wed, 28 Jun 2023 04:11:40 -0400
X-MC-Unique: 5vXoRlceOWqIW5fiHlV4qQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b6c037f015so1333421fa.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 01:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687939899; x=1690531899;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4cTND2wcrFvf5T3HdGEC88WLZ2tC38KyAB0FmRrOrTk=;
 b=MIVnOQTUvCua5BxQ7+AVXp0FTPfZvJzXZ4ZgwzBG/UfM15B//9vgyrm7fEhTIkWWcV
 nfpXVEnPg2ukVSFH9aN5jcAiG4jLzTKaKyU+WJ7uTQNT7gwLEr4jjCKSY9iGGJoWkJG2
 gtwiBhoV+zRXrYUpoQfNFekbvewIv4U9NwX0yB3Hef6ykDoTecpBvdQOJhzgP9p8ufsY
 3DcszKYIaUwXio6MTL44gT8/1G1+kN/XuGwHw98XrQVmMPPwnB+Kz4BfzlGPwyRCUiGe
 LXnx+hdxfbELwCsmbDoTJZIfE1285PGDZi0E1aY+2Dzfk4q7NPE5CC9GY55pPhuBolI+
 f6mg==
X-Gm-Message-State: AC+VfDzIFJObCO7Ar126/56syQi+cU0HtWjw2vXpWGN5b7bq3/YjQYOB
 J5bLLD4kcZH1NiWcyb03jkKxBkmQDYDdmNWJLklejis4OzhX7oYum0DyUXGM/pidK5CXZKCfgIr
 CMx/CAB/ji4IidQRl3ZmLmbGtHgu80MfW9qDC/Ymc8n7mBtySUUpGn9oltQ==
X-Received: by 2002:a2e:b0c3:0:b0:2b6:a75b:c5f2 with SMTP id
 g3-20020a2eb0c3000000b002b6a75bc5f2mr5105439ljl.32.1687939899075; 
 Wed, 28 Jun 2023 01:11:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4hL8AvEQrWFOAL7w+oejp5DdV0UlLp5XupFg/wppPG5fuNsIH20ieYEPTpEECGwRrlsQbTp1I7XJfrVR4E4LE=
X-Received: by 2002:a2e:b0c3:0:b0:2b6:a75b:c5f2 with SMTP id
 g3-20020a2eb0c3000000b002b6a75bc5f2mr5105426ljl.32.1687939898789; Wed, 28 Jun
 2023 01:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230628065919.54042-1-lulu@redhat.com>
 <20230628065919.54042-4-lulu@redhat.com>
In-Reply-To: <20230628065919.54042-4-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 28 Jun 2023 16:11:27 +0800
Message-ID: <CACGkMEs2V2gqGOv1jd-ZrT-9HHnSU6dhC=1zUojHRDGCeG2E7w@mail.gmail.com>
Subject: Re: [RFC 3/4] vduse: Add the function for get/free the mapp pages
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
dGhlIGZ1bmN0aW9uIGZvciBnZXQvZnJlZSBwYWdlcywgYWQgdGhpcyBpbmZvCj4gd2lsbCBzYXZl
ZCBpbiBkZXYtPnJlY29ubmVjdF9pbmZvCgpJIHRoaW5rIHRoaXMgc2hvdWxkIGJlIHNxdWFzaGVk
IHRvIHBhdGNoIDIgb3RoZXJ3aXNlIGl0IGZpeGVzIGEgYnVnCnRoYXQgaXMgaW50cm9kdWNlZCBp
biBwYXRjaCAyPwoKPgo+IFNpZ25lZC1vZmYtYnk6IENpbmR5IEx1IDxsdWx1QHJlZGhhdC5jb20+
Cj4gLS0tCj4gIGRyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMgfCAzNSArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDM1IGluc2VydGlvbnMo
KykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jIGIv
ZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYwo+IGluZGV4IDFiODMzYmYwYWUzNy4u
M2RmMTI1NmVjY2I0IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2Vf
ZGV2LmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jCj4gQEAgLTEz
MTMsNiArMTMxMywzNSBAQCBzdGF0aWMgc3RydWN0IHZkdXNlX2RldiAqdmR1c2VfZGV2X2dldF9m
cm9tX21pbm9yKGludCBtaW5vcikKPiAgICAgICAgIHJldHVybiBkZXY7Cj4gIH0KPgo+ICtpbnQg
dmR1c2VfZ2V0X3ZxX3JlY29ubm5lY3Qoc3RydWN0IHZkdXNlX2RldiAqZGV2LCB1MTYgaWR4KQo+
ICt7Cj4gKyAgICAgICBzdHJ1Y3QgdmRwYV9yZWNvbm5lY3RfaW5mbyAqYXJlYTsKPiArICAgICAg
IHZvaWQgKmFkZHIgPSAodm9pZCAqKWdldF96ZXJvZWRfcGFnZShHRlBfS0VSTkVMKTsKPiArCj4g
KyAgICAgICBhcmVhID0gJmRldi0+cmVjb25uZWN0X2luZm9baWR4XTsKPiArCj4gKyAgICAgICBh
cmVhLT5hZGRyID0gdmlydF90b19waHlzKGFkZHIpOwo+ICsgICAgICAgYXJlYS0+dmFkZHIgPSAo
dW5zaWduZWQgbG9uZylhZGRyOwo+ICsgICAgICAgYXJlYS0+c2l6ZSA9IFBBR0VfU0laRTsKPiAr
ICAgICAgIGFyZWEtPmluZGV4ID0gaWR4Owo+ICsKPiArICAgICAgIHJldHVybiAwOwo+ICt9Cj4g
Kwo+ICtpbnQgdmR1c2VfZnJlZV92cV9yZWNvbm5uZWN0KHN0cnVjdCB2ZHVzZV9kZXYgKmRldiwg
dTE2IGlkeCkKPiArewo+ICsgICAgICAgc3RydWN0IHZkcGFfcmVjb25uZWN0X2luZm8gKmFyZWE7
Cj4gKwo+ICsgICAgICAgYXJlYSA9ICZkZXYtPnJlY29ubmVjdF9pbmZvW2lkeF07Cj4gKyAgICAg
ICBpZiAoKGFyZWEtPnNpemUgPT0gUEFHRV9TSVpFKSAmJiAoYXJlYS0+YWRkciAhPSBOVUxMKSkg
ewo+ICsgICAgICAgICAgICAgICBmcmVlX3BhZ2UoYXJlYS0+dmFkZHIpOwo+ICsgICAgICAgICAg
ICAgICBhcmVhLT5zaXplID0gMDsKPiArICAgICAgICAgICAgICAgYXJlYS0+YWRkciA9IDA7Cj4g
KyAgICAgICAgICAgICAgIGFyZWEtPnZhZGRyID0gMDsKPiArICAgICAgIH0KPiArCj4gKyAgICAg
ICByZXR1cm4gMDsKPiArfQo+Cj4gIHN0YXRpYyB2bV9mYXVsdF90IHZkdXNlX3ZtX2ZhdWx0KHN0
cnVjdCB2bV9mYXVsdCAqdm1mKQo+ICB7Cj4gQEAgLTE0NDYsNiArMTQ3NSwxMCBAQCBzdGF0aWMg
aW50IHZkdXNlX2Rlc3Ryb3lfZGV2KGNoYXIgKm5hbWUpCj4gICAgICAgICAgICAgICAgIG11dGV4
X3VubG9jaygmZGV2LT5sb2NrKTsKPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FQlVTWTsKPiAg
ICAgICAgIH0KPiArICAgICAgIGZvciAoaW50IGkgPSAwOyBpIDwgZGV2LT52cV9udW07IGkrKykg
ewo+ICsKPiArICAgICAgICAgICAgICAgdmR1c2VfZnJlZV92cV9yZWNvbm5uZWN0KGRldiwgaSk7
Cj4gKyAgICAgICB9Cj4gICAgICAgICBkZXYtPmNvbm5lY3RlZCA9IHRydWU7Cj4gICAgICAgICBt
dXRleF91bmxvY2soJmRldi0+bG9jayk7Cj4KPiBAQCAtMTU4Myw2ICsxNjE2LDggQEAgc3RhdGlj
IGludCB2ZHVzZV9jcmVhdGVfZGV2KHN0cnVjdCB2ZHVzZV9kZXZfY29uZmlnICpjb25maWcsCj4g
ICAgICAgICAgICAgICAgIElOSVRfV09SSygmZGV2LT52cXNbaV0ua2ljaywgdmR1c2VfdnFfa2lj
a193b3JrKTsKPiAgICAgICAgICAgICAgICAgc3Bpbl9sb2NrX2luaXQoJmRldi0+dnFzW2ldLmtp
Y2tfbG9jayk7Cj4gICAgICAgICAgICAgICAgIHNwaW5fbG9ja19pbml0KCZkZXYtPnZxc1tpXS5p
cnFfbG9jayk7Cj4gKwo+ICsgICAgICAgICAgICAgICB2ZHVzZV9nZXRfdnFfcmVjb25ubmVjdChk
ZXYsIGkpOwoKQ2FuIHdlIGRlbGF5IHRoZSBhbGxvY2F0ZWQgdW50aWwgZmF1bHQ/CgpUaGFua3MK
Cj4gICAgICAgICB9Cj4KPiAgICAgICAgIHJldCA9IGlkcl9hbGxvYygmdmR1c2VfaWRyLCBkZXYs
IDEsIFZEVVNFX0RFVl9NQVgsIEdGUF9LRVJORUwpOwo+IC0tCj4gMi4zNC4zCj4KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
