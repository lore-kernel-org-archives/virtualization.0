Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF8AC77B75
	for <virtualization@archiver.kernel.org>; Fri, 21 Apr 2023 07:09:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 81EDF402CE;
	Fri, 21 Apr 2023 07:09:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 81EDF402CE
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UHEgtF4Z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8Y1-gfuS0EfE; Fri, 21 Apr 2023 07:09:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F371B401ED;
	Fri, 21 Apr 2023 07:09:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F371B401ED
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4E08C0036;
	Fri, 21 Apr 2023 07:09:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C7FAC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 07:09:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 32E2B60F3A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 07:09:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 32E2B60F3A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UHEgtF4Z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kVAZ4RRYkYZE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 07:09:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3410460B06
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3410460B06
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 07:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682060953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YvNqSawyJ3nJ/vCXn5tWx+RQcufZPyD2kLszhPcCGec=;
 b=UHEgtF4ZoDdnDu7Dc7lUPlo6BjlNHyvhsIpKzvWI+rlYtgvCQIMTgZKTQrfDeSLdgmmBi9
 q/1bPAVwci2brL8cFuHkbCsslJVhZV4xDUNei/Ex1hVmU2nbZc6opmZVebPsiy+UCReuLz
 CQF8NnPlXlM5q1slEbYXCLLEyEkbDdQ=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-77X9lEAVP0CHSp-rwpbl_g-1; Fri, 21 Apr 2023 03:09:11 -0400
X-MC-Unique: 77X9lEAVP0CHSp-rwpbl_g-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-541b69d5928so756641eaf.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 00:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682060951; x=1684652951;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YvNqSawyJ3nJ/vCXn5tWx+RQcufZPyD2kLszhPcCGec=;
 b=NB8R40Hmj7jW2dsrFEPj+NRSjc9vq+4xEmV/J1ETPGaC4WNQnKvRu0zjbYbDicogeu
 ubrHIGDlbCo0XXaKfhiar8acauotB9bN4AoZwwcLqEfPebkvr189o4wJ7tE1rU0zOFkf
 SUwMmqecX4fp89yrkS8bqegvaeFxlPw3mAyEeGvEW+D6ETMU7omSbxPH3Zac/HsFWK7t
 jS/EjoVEyCsnkvgr18I13v4z5+IfSJfTrewURdPd5EhlsQi2Si+lRyAASbqNqkfc86Nv
 8FfeDdPWxplHGrnhSUXdYkmI02hdnS9kdSwhCmqX2tFTHY7c+i76fb0/No5MLKnrxkjH
 o9IA==
X-Gm-Message-State: AAQBX9dypRbzcTJgLY/+RnliUmDKjvgrL4gyNZzJx3Hu0WlbxDBWH4cO
 hOH99TjujDE4LYC9jlT3Z8/XdA7BYumsAElN1JPyaHYLwBUsLxbXCaVwcozaTLg1q5zW9mwt863
 C3edbLc8HSEUbUG3MG3QyWaViBIHrpDqBtXKwMjo5xUbErhNI6QOBY0BpzA==
X-Received: by 2002:a05:6870:428e:b0:177:b62d:cc1c with SMTP id
 y14-20020a056870428e00b00177b62dcc1cmr3330129oah.0.1682060950843; 
 Fri, 21 Apr 2023 00:09:10 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZUnxaXgksNu0d9L0Wy5hrT6fYbh4k+ofySxdJolQXrJne1N1iwbOSJoXTrNObqrrmgHYlJIYKcUn7cD+PIHKQ=
X-Received: by 2002:a05:6870:428e:b0:177:b62d:cc1c with SMTP id
 y14-20020a056870428e00b00177b62dcc1cmr3330122oah.0.1682060950649; Fri, 21 Apr
 2023 00:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230419134329.346825-1-maxime.coquelin@redhat.com>
 <CACGkMEuiHqPkqYk1ZG3RZXLjm+EM3bmR0v1T1yH-ADEazOwTMA@mail.gmail.com>
 <ZEGG2GJw2DQk689j@x1n>
In-Reply-To: <ZEGG2GJw2DQk689j@x1n>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 21 Apr 2023 15:08:59 +0800
Message-ID: <CACGkMEvtBQg5fTTzSaMRwZH7P3WiDx0=eov9RdCtSFaHVtbh1w@mail.gmail.com>
Subject: Re: [RFC 0/2] vduse: add support for networking devices
To: Peter Xu <peterx@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, Maxime Coquelin <maxime.coquelin@redhat.com>,
 eperezma@redhat.com, david.marchand@redhat.com
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

T24gRnJpLCBBcHIgMjEsIDIwMjMgYXQgMjozOeKAr0FNIFBldGVyIFh1IDxwZXRlcnhAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4KPiBPbiBUaHUsIEFwciAyMCwgMjAyMyBhdCAxMjozNDowNlBNICswODAw
LCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiAzLiBDb3JlZHVtcDoKPiA+ID4gICBJbiBvcmRlciB0
byBiZSBhYmxlIHRvIHBlcmZvcm0gcG9zdC1tb3J0ZW0gYW5hbHlzaXMsIERQREsKPiA+ID4gICBW
aG9zdCBsaWJyYXJ5IG1hcmtzIHBhZ2VzIHVzZWQgZm9yIHZyaW5ncyBhbmQgZGVzY3JpcHRvcnMK
PiA+ID4gICBidWZmZXJzIGFzIE1BRFZfRE9EVU1QIHVzaW5nIG1hZHZpc2UoKS4gSG93ZXZlciB3
aXRoCj4gPiA+ICAgVkRVU0UgaXQgZmFpbHMgd2l0aCAtRUlOVkFMLiBNeSB1bmRlcnN0YW5kaW5n
IGlzIHRoYXQgd2UKPiA+ID4gICBzZXQgVk1fRE9OVEVYUEFORCBmbGFnIHRvIHRoZSBWTUFzIGFu
ZCBtYWR2aXNlJ3MKPiA+ID4gICBNQURWX0RPRFVNUCBmYWlscyBpZiBpdCBpcyBwcmVzZW50LiBJ
J20gbm90IHN1cmUgdG8KPiA+ID4gICB1bmRlcnN0YW5kIHdoeSBtYWR2aXNlIHdvdWxkIHByZXZl
bnQgTUFEVl9ET0RVTVAgaWYKPiA+ID4gICBWTV9ET05URVhQQU5EIGlzIHNldC4gQW55IHRob3Vn
aHRzPwo+ID4KPiA+IEFkZGluZyBQZXRlciB3aG8gbWF5IGtub3cgdGhlIGFuc3dlci4KPgo+IEkg
ZG9uJ3QuLiBidXQgSSBoYWQgYSBxdWljayBsb29rLCBpdCBzZWVtcyB0aGF0IFZNX0RPTlRFWFBB
TkQgd2FzIGtpbmQgb2YKPiByZXVzZWQgKGFuZCBJJ20gbm90IHN1cmUgd2hldGhlciBpdCdzIGFu
IGFidXNlIG9yIG5vdCBzbyBmYXIuLikgdG8KPiByZXByZXNlbnQgZGV2aWNlIGRyaXZlciBwYWdl
cyBzaW5jZSByZW1vdmFsIG9mIFZNX1JFU0VSVkVEOgoKSW50ZXJlc3RpbmcsIGJ1dCB0aGVyZSdy
ZSBpbmRlZWQgY2FzZXMgd2hlcmUgVk1fRE9OVEVYUEFORCBpcyB1c2VkIGJ5Cm5vbi1kcml2ZXIg
Y29kZXMuIFRoZSBwYWdlcyBtYXBwZWQgYnkgVkRVU0UgYXJlIG5vdCBkZXZpY2UgZHJpdmVyCnBh
Z2VzIGJ1dCB0aGUgSU9UTEIgYW5kIHZpcnRxdWV1ZS4KCkJ0dyB0aGUgZGVmaW5pdGlvbiBvZiBW
TV9TUEVDSUFMIGRvZXNuJ3Qgc2F5IGFueXRoaW5nIHJlbGF0ZWQgdG8gZHVtcDoKCi8qCiAqIFNw
ZWNpYWwgdm1hcyB0aGF0IGFyZSBub24tbWVyZ2FibGUsIG5vbi1tbG9jaygpYWJsZS4KICovCiNk
ZWZpbmUgVk1fU1BFQ0lBTCAoVk1fSU8gfCBWTV9ET05URVhQQU5EIHwgVk1fUEZOTUFQIHwgVk1f
TUlYRURNQVApCgo+Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMTIwNzMxMTAzNDU3
LjIwMTgyLjg4NDU0LnN0Z2l0QHp1cmcvCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIw
MTIwNzMxMTAzNTAzLjIwMTgyLjk0MzY1LnN0Z2l0QHp1cmcvCj4KPiBCdXQgSSB0aGluayB0aGF0
IGNoYW5nZSBhdCBsZWFzdCBicmVha3MgaHVnZXRsYiBvbmNlIHNvIHRoZXJlJ3MgdGhlCj4gZXhw
bGljaXQgaHVnZXRsYiBjaGVjayB0byByZWNvdmVyIHRoYXQgYmVoYXZpb3IgYmFjazoKPgo+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDE4MDkzMDA1NDYyOS4yOTE1MC0xLWRhbmllbEBs
aW51eC5pYm0uY29tLwoKVGhpcyBzZWVtcyBzaW1pbGFyIHRvIHRoZSBjYXNlIG9mIFZEVVNFLgoK
VGhhbmtzCgo+Cj4gVGhhbmtzLAo+Cj4gLS0KPiBQZXRlciBYdQo+CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
