Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AEEEB64D7
	for <virtualization@archiver.kernel.org>; Wed, 28 Jun 2023 08:13:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BDA9460B3A;
	Wed, 28 Jun 2023 08:13:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BDA9460B3A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LfxrrgOG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7_ttDk9bHAiV; Wed, 28 Jun 2023 08:13:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 68581605AF;
	Wed, 28 Jun 2023 08:13:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 68581605AF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4102AC007C;
	Wed, 28 Jun 2023 08:13:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 743B6C0037
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 08:13:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 410E9605E3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 08:13:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 410E9605E3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1oDFr-qgMPEy
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 08:13:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5F4BA605AF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5F4BA605AF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 08:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687940008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2B1ynmbT0UkVLiBLPkihB9uufQdZmbcV3Hls/wgSG4U=;
 b=LfxrrgOGscLRrWlh3vQaMxCGEOvURc+tDZJLPxfZ4FM6O9MpBxmO5xoq+PFERJl7WgB53A
 rq6cbxw4U6M2W54//opOKNZv7efZDB81CtawfURRf0/0I1/bJgXMaV48Obi4mo+6Y79vSl
 Zbl/cH+4kfBXPh8Hxl7CQN/BJ014Azg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-jRC9XKNtNx21dHrfE8feDQ-1; Wed, 28 Jun 2023 04:13:27 -0400
X-MC-Unique: jRC9XKNtNx21dHrfE8feDQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4fb913e8cddso375393e87.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 01:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687940006; x=1690532006;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2B1ynmbT0UkVLiBLPkihB9uufQdZmbcV3Hls/wgSG4U=;
 b=ZFikqA4rS7S/bhW/4bJIo2sgQ/vsiZAVKtbWZcyUbvWjEFzsMfblWr/0xteBDQeLns
 yOV7FP1vGZnp/QtkTXr5Tt78fSVnZUiyvfjrkOsgwa4YE3dqATgtKZAbfjLIiISDDGPO
 +BEwmqv5VuU1ZNj/0iQByoIEsC3qXM551Kwh4b+syySZI1Cm82DKaeiWhB0a6FRkYlwj
 1PEmy73dJry0krIIlPgiCdw+9L0eQXOV/hj3i4ZUx3Cpvicvzdwy7yih5BekQwjztpdU
 J6RM96/yRWqqJfqK7DXU+lVP8BJFIrR2Dyd2sMTrsWYIUYtcMPCvr3fQEa+qJzNYLR25
 ciWQ==
X-Gm-Message-State: AC+VfDwIF87my5pzk7bZOBsgmDhGjai8kgSxGySagd8jOwZbIQOxGhpe
 V7fKs1HklKKYzSbK3HhtxCut1efrizWfDlIifHgSh6a9L8nsLEEbP7E+Uem+wMrbNAax8havA7c
 F+U91Pn9R4lvNfTWL4hXvtQ8lCoX9m1+j8vXXvVXQaOLOcxsNRswPP8/FGg==
X-Received: by 2002:a2e:9943:0:b0:2b6:9909:79b6 with SMTP id
 r3-20020a2e9943000000b002b6990979b6mr6308004ljj.40.1687940006183; 
 Wed, 28 Jun 2023 01:13:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5hUOUptmy1cz/bmc0SQBwJ16zCTf1sq+b8bGF74Opubi8l0hmlcMZJAcxolSBWuUoW13vUTOVfJelNLYP6OGc=
X-Received: by 2002:a2e:9943:0:b0:2b6:9909:79b6 with SMTP id
 r3-20020a2e9943000000b002b6990979b6mr6307993ljj.40.1687940005910; Wed, 28 Jun
 2023 01:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230628065919.54042-1-lulu@redhat.com>
 <20230628065919.54042-5-lulu@redhat.com>
In-Reply-To: <20230628065919.54042-5-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 28 Jun 2023 16:13:14 +0800
Message-ID: <CACGkMEtN7pE4FK2-504JC3A1tcfPjy9QejJiTyvXD7nt49KLvA@mail.gmail.com>
Subject: Re: [RFC 4/4] vduse: update the vq_info in ioctl
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

T24gV2VkLCBKdW4gMjgsIDIwMjMgYXQgMzowMOKAr1BNIENpbmR5IEx1IDxsdWx1QHJlZGhhdC5j
b20+IHdyb3RlOgo+Cj4gRnJvbTogWW91ciBOYW1lIDx5b3VAZXhhbXBsZS5jb20+Cj4KPiBpbiBW
RFVTRV9WUV9HRVRfSU5GTywgZHJpdmVyIHdpbGwgc3luYyB0aGUgbGFzdF9hdmFpbF9pZHgKPiB3
aXRoIHJlY29ubmVjdCBpbmZvLCBJIGhhdmUgb2xueSB0ZXN0IHRoZSBzcGxpdCBtb2RlLCBzbwoK
VHlwbywgc2hvdWxkIGJlICJvbmx5Ii4KCj4gb25seSB1c2UgdGhpcyBoZXJlLCB3aWxsIGFkZCBt
b3JlIGluZm9ybWF0aW9uIGxhdGVyCj4KPiBTaWduZWQtb2ZmLWJ5OiBDaW5keSBMdSA8bHVsdUBy
ZWRoYXQuY29tPgo+IC0tLQo+ICBkcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jIHwg
MTYgKysrKysrKysrKysrKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQo+
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMgYi9kcml2
ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jCj4gaW5kZXggM2RmMTI1NmVjY2I0Li5iOGU0
NTNlYWMwY2UgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYu
Ywo+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMKPiBAQCAtMTQxLDYg
KzE0MSwxMSBAQCBzdGF0aWMgdTMyIGFsbG93ZWRfZGV2aWNlX2lkW10gPSB7Cj4gICAgICAgICBW
SVJUSU9fSURfTkVULAo+ICB9Owo+Cj4gK3N0cnVjdCB2aG9zdF9yZWNvbm5lY3RfdnJpbmcgewo+
ICsgICAgICAgdWludDE2X3QgbGFzdF9hdmFpbF9pZHg7Cj4gKyAgICAgICBib29sIGF2YWlsX3dy
YXBfY291bnRlcjsKPiArfTsKClNob3VsZCB0aGlzIGJlbG9uZyB0byB1QVBJPwoKPiArCj4gIHN0
YXRpYyBpbmxpbmUgc3RydWN0IHZkdXNlX2RldiAqdmRwYV90b192ZHVzZShzdHJ1Y3QgdmRwYV9k
ZXZpY2UgKnZkcGEpCj4gIHsKPiAgICAgICAgIHN0cnVjdCB2ZHVzZV92ZHBhICp2ZGV2ID0gY29u
dGFpbmVyX29mKHZkcGEsIHN0cnVjdCB2ZHVzZV92ZHBhLCB2ZHBhKTsKPiBAQCAtMTE3Niw2ICsx
MTgxLDE3IEBAIHN0YXRpYyBsb25nIHZkdXNlX2Rldl9pb2N0bChzdHJ1Y3QgZmlsZSAqZmlsZSwg
dW5zaWduZWQgaW50IGNtZCwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZxLT5z
dGF0ZS5zcGxpdC5hdmFpbF9pbmRleDsKPgo+ICAgICAgICAgICAgICAgICB2cV9pbmZvLnJlYWR5
ID0gdnEtPnJlYWR5Owo+ICsgICAgICAgICAgICAgICBzdHJ1Y3QgdmRwYV9yZWNvbm5lY3RfaW5m
byAqYXJlYTsKPiArCj4gKyAgICAgICAgICAgICAgIGFyZWEgPSAmZGV2LT5yZWNvbm5lY3RfaW5m
b1tpbmRleF07Cj4gKyAgICAgICAgICAgICAgIHN0cnVjdCB2aG9zdF9yZWNvbm5lY3RfdnJpbmcg
KmxvZ19yZWNvbm5lY3Q7Cj4gKwo+ICsgICAgICAgICAgICAgICBsb2dfcmVjb25uZWN0ID0gKHN0
cnVjdCB2aG9zdF9yZWNvbm5lY3RfdnJpbmcgKilhcmVhLT52YWRkcjsKCldoYXQgaWYgdXNlcnNw
YWNlIGRvZXNuJ3QgZG8gbW1hcCgpPwoKVGhhbmtzCgo+ICsgICAgICAgICAgICAgICBpZiAobG9n
X3JlY29ubmVjdC0+bGFzdF9hdmFpbF9pZHggIT0KPiArICAgICAgICAgICAgICAgICAgIHZxX2lu
Zm8uc3BsaXQuYXZhaWxfaW5kZXgpIHsKPiArICAgICAgICAgICAgICAgICAgICAgICB2cV9pbmZv
LnNwbGl0LmF2YWlsX2luZGV4ID0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxv
Z19yZWNvbm5lY3QtPmxhc3RfYXZhaWxfaWR4Owo+ICsgICAgICAgICAgICAgICB9Cj4KPiAgICAg
ICAgICAgICAgICAgcmV0ID0gLUVGQVVMVDsKPiAgICAgICAgICAgICAgICAgaWYgKGNvcHlfdG9f
dXNlcihhcmdwLCAmdnFfaW5mbywgc2l6ZW9mKHZxX2luZm8pKSkKPiAtLQo+IDIuMzQuMwo+Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
