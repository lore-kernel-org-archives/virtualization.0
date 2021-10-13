Return-Path: <SRS0=kx+w=PB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE44CC433EF
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 03:57:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 677AD608FE
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 03:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 677AD608FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B1CF8295A;
	Wed, 13 Oct 2021 03:57:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 68ibcVrNsRjm; Wed, 13 Oct 2021 03:57:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B7EBF82897;
	Wed, 13 Oct 2021 03:57:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97756C0011;
	Wed, 13 Oct 2021 03:57:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB345C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 03:57:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8D041606C6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 03:57:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LIFRXhTRTsYU
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 03:57:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D7DC260662
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 03:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634097432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OfEv3P2XE+BIrw1JNXoxGqnhbGwSlGRDfuMPFt5ERNQ=;
 b=M9vxLF1W/iB6UK2ywl1OrQ5FP0MOL2zoB7yjB9X7NeARMiuL0kurOEvNccLDPl9okOquQ2
 07l95kexETAr4c8IeP9uz0iZoUF3IwTGhXKp9+WsHUsP4rnPg/DpxcU9Js+sAsi/pQUN4y
 v5XVeuFD+cgAFhjTf7fqb8tnLa9h8Ds=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-YFLFfmi3MJa74Tea2x74kw-1; Tue, 12 Oct 2021 23:57:06 -0400
X-MC-Unique: YFLFfmi3MJa74Tea2x74kw-1
Received: by mail-pl1-f197.google.com with SMTP id
 w4-20020a1709029a8400b00138e222b06aso418560plp.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 20:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=OfEv3P2XE+BIrw1JNXoxGqnhbGwSlGRDfuMPFt5ERNQ=;
 b=UeoNfrlqWzf/aaeYU39YXvzmajv8PDe0BjlUOVYr5b9NBGwYZXRzZSEJ6mHMKGdXLS
 oC8trc0NksPDXGhhRhJekxHyc3xt76M2VsHa5Ug8dQyOMKhPSPhiMAt8FB0vp6ssJq8x
 bY9Q8SUSnfhL+cYcnsvaPtyGxjYtyjwwBag5RLfR/5WntWDeqo3+mjANzbION8UQuTWW
 JVDDSseRev2yGZRNoiGc3MghKFhg4kqhsez78k/KJHn+wxBcvmKvtEQeSJBC93Zewt53
 eYtcsbW/c6uBjgjxm+sI44+a9o+gTZ06WOHVo+uR0rwfx90+t4scQRLoEQacbvevStU3
 +Fxg==
X-Gm-Message-State: AOAM531nbMF6ucpMYVc19hCC3pomxUqXveH9XA8V1+49z8/XVYoIATSt
 o4aH5SWuShQqdAFtJ67Dn0lSTSV94ICGNWv8VhVodjSyMsxheGMlX71MVQuTY1NIvz1eY7/djuM
 vGtvJ+VJX+dZ0U1obEEs2g0UZy9fuVaxL5VsmzdDBvQ==
X-Received: by 2002:a17:90a:b314:: with SMTP id
 d20mr10817568pjr.174.1634097425662; 
 Tue, 12 Oct 2021 20:57:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZOF+K/NFHFlr2aR3JavlxxijfcUZA9fvRfDnc4w62lBlPtcRrDNXxsbc0AxbzFG+lWfEKjQ==
X-Received: by 2002:a17:90a:b314:: with SMTP id
 d20mr10817540pjr.174.1634097425406; 
 Tue, 12 Oct 2021 20:57:05 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id k1sm4143302pjj.54.2021.10.12.20.57.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Oct 2021 20:57:05 -0700 (PDT)
Subject: Re: [RFC PATCH v4 13/20] vdpa: Save host and guest features
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20211001070603.307037-1-eperezma@redhat.com>
 <20211001070603.307037-14-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <37bddd4a-eeae-33c3-45f5-3d9070a25513@redhat.com>
Date: Wed, 13 Oct 2021 11:56:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211001070603.307037-14-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Eric Blake <eblake@redhat.com>, Michael Lilja <ml@napatech.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIxLzEwLzEg5LiL5Y2IMzowNSwgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IFRob3Nl
IGFyZSBuZWVkZWQgZm9yIFNWUTogSG9zdCBvbmVzIGFyZSBuZWVkZWQgdG8gY2hlY2sgaWYgU1ZR
IGtub3dzCj4gaG93IHRvIHRhbGsgd2l0aCB0aGUgZGV2aWNlIGFuZCBmb3IgZmVhdHVyZSBuZWdv
dGlhdGlvbiwgYW5kIGd1ZXN0IG9uZXMKPiB0byBrbm93IGlmIFNWUSBjYW4gdGFsayB3aXRoIGl0
Lgo+Cj4gU2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+
Cj4gLS0tCj4gICBpbmNsdWRlL2h3L3ZpcnRpby92aG9zdC12ZHBhLmggfCAgMiArKwo+ICAgaHcv
dmlydGlvL3Zob3N0LXZkcGEuYyAgICAgICAgIHwgMzEgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tLQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmlydGlvL3Zob3N0LXZkcGEuaCBiL2lu
Y2x1ZGUvaHcvdmlydGlvL3Zob3N0LXZkcGEuaAo+IGluZGV4IGZkZGFjMjQ4YjMuLjkwNDRhZTY5
NGIgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9ody92aXJ0aW8vdmhvc3QtdmRwYS5oCj4gKysrIGIv
aW5jbHVkZS9ody92aXJ0aW8vdmhvc3QtdmRwYS5oCj4gQEAgLTI2LDYgKzI2LDggQEAgdHlwZWRl
ZiBzdHJ1Y3Qgdmhvc3RfdmRwYSB7Cj4gICAgICAgaW50IGRldmljZV9mZDsKPiAgICAgICB1aW50
MzJfdCBtc2dfdHlwZTsKPiAgICAgICBNZW1vcnlMaXN0ZW5lciBsaXN0ZW5lcjsKPiArICAgIHVp
bnQ2NF90IGhvc3RfZmVhdHVyZXM7Cj4gKyAgICB1aW50NjRfdCBndWVzdF9mZWF0dXJlczsKCgpB
bnkgcmVhc29uIHRoYXQgd2UgY2FuJ3QgdXNlIHRoZSBmZWF0dXJlcyBzdG9yZWQgaW4gVmlydGlv
RGV2aWNlPwoKVGhhbmtzCgoKPiAgICAgICBib29sIHNoYWRvd192cXNfZW5hYmxlZDsKPiAgICAg
ICBHUHRyQXJyYXkgKnNoYWRvd192cXM7Cj4gICAgICAgc3RydWN0IHZob3N0X2RldiAqZGV2Owo+
IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhvc3QtdmRwYS5jIGIvaHcvdmlydGlvL3Zob3N0LXZk
cGEuYwo+IGluZGV4IDZjNWY0Yzk4YjguLmEwNTdlODI3N2QgMTAwNjQ0Cj4gLS0tIGEvaHcvdmly
dGlvL3Zob3N0LXZkcGEuYwo+ICsrKyBiL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMKPiBAQCAtNDM5
LDEwICs0MzksMTkgQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX3NldF9tZW1fdGFibGUoc3RydWN0
IHZob3N0X2RldiAqZGV2LAo+ICAgICAgIHJldHVybiAwOwo+ICAgfQo+ICAgCj4gLXN0YXRpYyBp
bnQgdmhvc3RfdmRwYV9zZXRfZmVhdHVyZXMoc3RydWN0IHZob3N0X2RldiAqZGV2LAo+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IGZlYXR1cmVzKQo+ICsvKioK
PiArICogSW50ZXJuYWwgc2V0X2ZlYXR1cmVzKCkgdGhhdCBmb2xsb3dzIHZob3N0L1ZpcnRJTyBw
cm90b2NvbCBmb3IgdGhhdAo+ICsgKi8KPiArc3RhdGljIGludCB2aG9zdF92ZHBhX2JhY2tlbmRf
c2V0X2ZlYXR1cmVzKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwKPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IGZlYXR1cmVzKQo+ICAgewo+ICsgICAg
c3RydWN0IHZob3N0X3ZkcGEgKnYgPSBkZXYtPm9wYXF1ZTsKPiArCj4gICAgICAgaW50IHJldDsK
PiArICAgIGlmICh2LT5ob3N0X2ZlYXR1cmVzICYgQklUX1VMTChWSVJUSU9fRl9RVUVVRV9TVEFU
RSkpIHsKPiArICAgICAgICBmZWF0dXJlcyB8PSBCSVRfVUxMKFZJUlRJT19GX1FVRVVFX1NUQVRF
KTsKPiArICAgIH0KPiArCj4gICAgICAgdHJhY2Vfdmhvc3RfdmRwYV9zZXRfZmVhdHVyZXMoZGV2
LCBmZWF0dXJlcyk7Cj4gICAgICAgcmV0ID0gdmhvc3RfdmRwYV9jYWxsKGRldiwgVkhPU1RfU0VU
X0ZFQVRVUkVTLCAmZmVhdHVyZXMpOwo+ICAgICAgIHVpbnQ4X3Qgc3RhdHVzID0gMDsKPiBAQCAt
NDU1LDYgKzQ2NCwxNyBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfc2V0X2ZlYXR1cmVzKHN0cnVj
dCB2aG9zdF9kZXYgKmRldiwKPiAgICAgICByZXR1cm4gIShzdGF0dXMgJiBWSVJUSU9fQ09ORklH
X1NfRkVBVFVSRVNfT0spOwo+ICAgfQo+ICAgCj4gKy8qKgo+ICsgKiBFeHBvc2VkIHZob3N0IHNl
dCBmZWF0dXJlcwo+ICsgKi8KPiArc3RhdGljIGludCB2aG9zdF92ZHBhX3NldF9mZWF0dXJlcyhz
dHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdWludDY0X3QgZmVhdHVyZXMpCj4gK3sKPiArICAgIHN0cnVjdCB2aG9zdF92ZHBhICp2ID0g
ZGV2LT5vcGFxdWU7Cj4gKyAgICB2LT5ndWVzdF9mZWF0dXJlcyA9IGZlYXR1cmVzOwo+ICsgICAg
cmV0dXJuIHZob3N0X3ZkcGFfYmFja2VuZF9zZXRfZmVhdHVyZXMoZGV2LCBmZWF0dXJlcyk7Cj4g
K30KPiArCj4gICBzdGF0aWMgaW50IHZob3N0X3ZkcGFfc2V0X2JhY2tlbmRfY2FwKHN0cnVjdCB2
aG9zdF9kZXYgKmRldikKPiAgIHsKPiAgICAgICB1aW50NjRfdCBmZWF0dXJlczsKPiBAQCAtNjcz
LDEyICs2OTMsMTcgQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX3NldF92cmluZ19jYWxsKHN0cnVj
dCB2aG9zdF9kZXYgKmRldiwKPiAgIH0KPiAgIAo+ICAgc3RhdGljIGludCB2aG9zdF92ZHBhX2dl
dF9mZWF0dXJlcyhzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB1aW50NjRfdCAqZmVhdHVyZXMpCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdWludDY0X3QgKmZlYXR1cmVzKQo+ICAgewo+ICAgICAgIGludCBy
ZXQ7Cj4gICAKPiAgICAgICByZXQgPSB2aG9zdF92ZHBhX2NhbGwoZGV2LCBWSE9TVF9HRVRfRkVB
VFVSRVMsIGZlYXR1cmVzKTsKPiAgICAgICB0cmFjZV92aG9zdF92ZHBhX2dldF9mZWF0dXJlcyhk
ZXYsICpmZWF0dXJlcyk7Cj4gKwo+ICsgICAgaWYgKHJldCA9PSAwKSB7Cj4gKyAgICAgICAgc3Ry
dWN0IHZob3N0X3ZkcGEgKnYgPSBkZXYtPm9wYXF1ZTsKPiArICAgICAgICB2LT5ob3N0X2ZlYXR1
cmVzID0gKmZlYXR1cmVzOwo+ICsgICAgfQo+ICAgICAgIHJldHVybiByZXQ7Cj4gICB9Cj4gICAK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
