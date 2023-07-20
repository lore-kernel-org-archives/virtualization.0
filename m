Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B47C001E0
	for <virtualization@archiver.kernel.org>; Thu, 20 Jul 2023 02:27:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 557874028D;
	Thu, 20 Jul 2023 02:27:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 557874028D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fNQvVjiQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hQXFFzSbrnoo; Thu, 20 Jul 2023 02:27:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D8CD7400A4;
	Thu, 20 Jul 2023 02:27:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D8CD7400A4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5C9EC0072;
	Thu, 20 Jul 2023 02:27:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D7A9C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 02:27:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EC33060BB1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 02:27:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EC33060BB1
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fNQvVjiQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P67z64gQMiFl
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 02:27:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0F4A160B49
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 02:27:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0F4A160B49
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689820038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PhX0KcPz6bpGMzzt6+Tw+HFeLg7cMeTIF/CHwLfDxqU=;
 b=fNQvVjiQzy6HisfBBRGWYv0mNQUAj+0v8hwfI2P7dV8u37rlNz2zp3l34ahLdBuGoHAl8H
 KHDd45NrPyyJ8zlKrIDYF8fh4lojxxarYr8WyYKTWQO+TiMLwHaq2chsibXU6DhyfNsxt0
 3jYY1HbmQ+JqoRKzhMJV+YcA5jUDQxw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556--ZyWnbW8MnSRbYiHbo85mw-1; Wed, 19 Jul 2023 22:27:17 -0400
X-MC-Unique: -ZyWnbW8MnSRbYiHbo85mw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b708e49042so2388091fa.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jul 2023 19:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689820036; x=1692412036;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PhX0KcPz6bpGMzzt6+Tw+HFeLg7cMeTIF/CHwLfDxqU=;
 b=hA76isl6S/Lo7b7+oVLtxjHXSVrrw2g4t90JOyAsNMa4XZXCUZOM+RMbHU4ONJpGHM
 oI7UinLIWhIpP8lCgulPwF0u6aYUARyAGP/u5HG1lIcCEP6VRKY+2Oas8XRQ3dJXoTBb
 ju+dBET/hsHIKK8UdLNyLTbriSMiu0xZlN3awUkt/mgUnIusxpltlU+k8zB34f4gEk4+
 Jatbwz9CR0NVrIPo0pDhfNPJIVqOE4NyT4tfk4iRZ5Gqt+8MB/mIcOjV8d+xY394jFzZ
 95zHFt8wgIscqoaYopjb8+IGe2wg59bek370T0RZsqJZMjpb0rsHfVxi5f5jZvmeFAtL
 m7Hw==
X-Gm-Message-State: ABy/qLbiX05iFKU5itrthePL83Bklqxcld5mAE5SO8KhV27Ny22r1bBE
 3nyi1dTHSzXAtW8qILI9CKHdnEbj8Sq4T9WEaqeBIkil2ZGgSZbEGo+o60jA4+BiSprsQ/cbj6v
 ktZcOzeqpZp9GAC1BPlJb2TEYTFTsPAPnCBNU+WnCwv3M5h+uniXCKcpDEg==
X-Received: by 2002:a2e:b70a:0:b0:2a7:adf7:1781 with SMTP id
 j10-20020a2eb70a000000b002a7adf71781mr1207364ljo.2.1689820036241; 
 Wed, 19 Jul 2023 19:27:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGG8VfnWGKux2XQqloHvmum/oTHRj7uk/Z8damP4dF1V13QVr/IDb3lqUNAF2zJ46P6L2CkZPMsB4+tjAqSbnQ=
X-Received: by 2002:a2e:b70a:0:b0:2a7:adf7:1781 with SMTP id
 j10-20020a2eb70a000000b002a7adf71781mr1207359ljo.2.1689820035929; Wed, 19 Jul
 2023 19:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230719154550.79536-1-feliu@nvidia.com>
In-Reply-To: <20230719154550.79536-1-feliu@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Jul 2023 10:27:04 +0800
Message-ID: <CACGkMEv1b698NcpZHxpDoNokWH0gEs07D2eYSAjsiF1efhxORw@mail.gmail.com>
Subject: Re: [PATCH v1] virtio-pci: Fix legacy device flag setting error in
 probe
To: Feng Liu <feliu@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>
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

T24gV2VkLCBKdWwgMTksIDIwMjMgYXQgMTE6NDbigK9QTSBGZW5nIExpdSA8ZmVsaXVAbnZpZGlh
LmNvbT4gd3JvdGU6Cj4KPiBUaGUgJ2lzX2xlZ2FjeScgZmxhZyBpcyB1c2VkIHRvIGRpZmZlcmVu
dGlhdGUgYmV0d2VlbiBsZWdhY3kgdnMgbW9kZXJuCj4gZGV2aWNlLiBDdXJyZW50bHksIGl0IGlz
IGJhc2VkIG9uIHRoZSB2YWx1ZSBvZiB2cF9kZXYtPmxkZXYuaW9hZGRyLgo+IEhvd2V2ZXIsIGR1
ZSB0byB0aGUgc2hhcmVkIG1lbW9yeSBvZiB0aGUgdW5pb24gYmV0d2VlbiBzdHJ1Y3QKPiB2aXJ0
aW9fcGNpX2xlZ2FjeV9kZXZpY2UgYW5kIHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9kZXZpY2Us
IHdoZW4KPiB2aXJ0aW9fcGNpX21vZGVybl9wcm9iZSBtb2RpZmllcyB0aGUgY29udGVudCBvZiBz
dHJ1Y3QKPiB2aXJ0aW9fcGNpX21vZGVybl9kZXZpY2UsIGl0IGFmZmVjdHMgdGhlIGNvbnRlbnQg
b2Ygc3RydWN0Cj4gdmlydGlvX3BjaV9sZWdhY3lfZGV2aWNlLCBhbmQgbGRldi5pb2FkZHIgaXMg
bm8gbG9uZ2VyIHplcm8sIGNhdXNpbmcKPiB0aGUgJ2lzX2xlZ2FjeScgZmxhZyB0byBiZSBzZXQg
YXMgdHJ1ZS4gVG8gcmVzb2x2ZSBpc3N1ZSwgd2hlbiBsZWdhY3kKPiBkZXZpY2UgaXMgcHJvYmVk
LCBtYXJrICdpc19sZWdhY3knIGFzIHRydWUsIHdoZW4gbW9kZXJuIGRldmljZSBpcwo+IHByb2Jl
ZCwga2VlcCAnaXNfbGVnYWN5JyBhcyBmYWxzZS4KPgo+IEZpeGVzOiA0ZjBmYzIyNTM0ZTMgKCJ2
aXJ0aW9fcGNpOiBPcHRpbWl6ZSB2aXJ0aW9fcGNpX2RldmljZSBzdHJ1Y3R1cmUgc2l6ZSIpCj4g
U2lnbmVkLW9mZi1ieTogRmVuZyBMaXUgPGZlbGl1QG52aWRpYS5jb20+Cj4gUmV2aWV3ZWQtYnk6
IFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZpZGlhLmNvbT4KPiBSZXZpZXdlZC1ieTogSmlyaSBQaXJr
byA8amlyaUBudmlkaWEuY29tPgo+IC0tLQo+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2Nv
bW1vbi5jIHwgMiAtLQo+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jIHwgMSAr
Cj4gIDIgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pCj4KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uYyBiL2RyaXZlcnMv
dmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMKPiBpbmRleCBhNmM4NmY5MTZkYmQuLmMyNTI0YTcy
MDdjZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jCj4g
KysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uYwo+IEBAIC01NTcsOCArNTU3
LDYgQEAgc3RhdGljIGludCB2aXJ0aW9fcGNpX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwY2lfZGV2
LAo+Cj4gICAgICAgICBwY2lfc2V0X21hc3RlcihwY2lfZGV2KTsKPgo+IC0gICAgICAgdnBfZGV2
LT5pc19sZWdhY3kgPSB2cF9kZXYtPmxkZXYuaW9hZGRyID8gdHJ1ZSA6IGZhbHNlOwo+IC0KPiAg
ICAgICAgIHJjID0gcmVnaXN0ZXJfdmlydGlvX2RldmljZSgmdnBfZGV2LT52ZGV2KTsKPiAgICAg
ICAgIHJlZ19kZXYgPSB2cF9kZXY7Cj4gICAgICAgICBpZiAocmMpCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cGNpX2xlZ2FjeS5jCj4gaW5kZXggMjI1N2YxYjNkOGFlLi5kOWNiYjAyYjM1YTEgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYwo+ICsrKyBiL2RyaXZlcnMv
dmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMKPiBAQCAtMjIzLDYgKzIyMyw3IEBAIGludCB2aXJ0
aW9fcGNpX2xlZ2FjeV9wcm9iZShzdHJ1Y3QgdmlydGlvX3BjaV9kZXZpY2UgKnZwX2RldikKPiAg
ICAgICAgIHZwX2Rldi0+Y29uZmlnX3ZlY3RvciA9IHZwX2NvbmZpZ192ZWN0b3I7Cj4gICAgICAg
ICB2cF9kZXYtPnNldHVwX3ZxID0gc2V0dXBfdnE7Cj4gICAgICAgICB2cF9kZXYtPmRlbF92cSA9
IGRlbF92cTsKPiArICAgICAgIHZwX2Rldi0+aXNfbGVnYWN5ID0gdHJ1ZTsKClRoaXMgc2VlbXMg
YnJlYWsgZm9yY2VfbGVnYWN5IGZvciBtb2Rlcm4gZGV2aWNlOgoKICAgICAgICBpZiAoZm9yY2Vf
bGVnYWN5KSB7CiAgICAgICAgICAgICAgICByYyA9IHZpcnRpb19wY2lfbGVnYWN5X3Byb2JlKHZw
X2Rldik7CiAgICAgICAgICAgICAgICAvKiBBbHNvIHRyeSBtb2Rlcm4gbW9kZSBpZiB3ZSBjYW4n
dCBtYXAgQkFSMCAobm8gSU8gc3BhY2UpLiAqLwogICAgICAgICAgICAgICAgaWYgKHJjID09IC1F
Tk9ERVYgfHwgcmMgPT0gLUVOT01FTSkKICAgICAgICAgICAgICAgICAgICAgICAgcmMgPSB2aXJ0
aW9fcGNpX21vZGVybl9wcm9iZSh2cF9kZXYpOwoKVGhhbmtzCgo+Cj4gICAgICAgICByZXR1cm4g
MDsKPiAgfQo+IC0tCj4gMi4zNy4xIChBcHBsZSBHaXQtMTM3LjEpCj4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
