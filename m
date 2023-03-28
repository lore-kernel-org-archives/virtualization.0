Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0CFC76195
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 09:42:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2F9A141665;
	Tue, 28 Mar 2023 09:42:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2F9A141665
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F8Xg3EUW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id emRbnfHPv1oO; Tue, 28 Mar 2023 09:42:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9926D411A9;
	Tue, 28 Mar 2023 09:42:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9926D411A9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68843C0037;
	Tue, 28 Mar 2023 09:42:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C2FAC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:42:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2AD476117E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:42:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2AD476117E
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=F8Xg3EUW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o24BvRoo42bJ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:42:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5B93F61160
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5B93F61160
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679996571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UiP0xWp+0ly7XQn9tc22k14IwNm7IEcKiG/dCrMFCU0=;
 b=F8Xg3EUWk0Ygmlf9CqzrF174O8Mn01E6cZWG9Fm/OkNk7ZyYbXJeGeQMyiHu+qG/cQvrGI
 WNluSdS1L+daJ1YpEGeHd82fkzxIhEuQB8DXIdgONwCk+6WcjXMsI5MjR2gF7R7FvTi+Bs
 l/J9iaMDey3x5SMCLTj3rgKF0ulaDXA=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-3m33pzgpOhmM_d_81LnUFg-1; Tue, 28 Mar 2023 05:42:47 -0400
X-MC-Unique: 3m33pzgpOhmM_d_81LnUFg-1
Received: by mail-yb1-f200.google.com with SMTP id
 m6-20020a056902118600b00aeb1e3dbd1bso11361811ybu.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:42:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679996567;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UiP0xWp+0ly7XQn9tc22k14IwNm7IEcKiG/dCrMFCU0=;
 b=phn2OWef8WCoEG0Ms58TaE+tbGLG+ZxvdbNdnzHIocJwFByaQ2wNBy/gvnoFkOSvlO
 d0kIoZhXSS2fAL16MnKvr3OKw7z6WaxNRdLJuqzvEFVD02m/Jwg0ngtC/oaGHJvid6uf
 YAsSk6ml3dBTPO57JMDDSU8aiTPMuwE3FzStzir7YcIWIfKyTJul7M96+WI7xdKnwcxD
 HqUIpcu6r6XXnxdpKXLjlK9GfOZMZMpiNRD05nknwmc1hR0ZGXXBL+QpE6Idkyr8D/OL
 zL7T8aC743n3djQr1czkvYjvnjVqT16s7KAJlsu9bwh9oaQ/IMN5U7axW9AWGT/2qME+
 cUDg==
X-Gm-Message-State: AAQBX9c/qp91i9Peb6kdt7mOV1nEeEKCaJVh//FkA306SzgcA4VR+hBK
 1jqguxkQDDWwUKVhN3wUXbUzldZjvtTJCi/h3rfDqoIgmMQf+DRHdIrbLsYXcVu9GNvLWWt1Ti5
 NJ/iDck9D1uFYRWQfefL92RUsyjg3eKvgpv1M/xHD1SVhErl7NnNitbQ7IQ==
X-Received: by 2002:a81:b620:0:b0:541:8995:5334 with SMTP id
 u32-20020a81b620000000b0054189955334mr6757330ywh.3.1679996566939; 
 Tue, 28 Mar 2023 02:42:46 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zeh8QW1ALX/iyqmCjH97T20NkLc6M0pceeD5Mqt8dWP2CV889xu4EIMZ3VRQI/JNEAdxXJQ35UqcDiY6IhSR4=
X-Received: by 2002:a81:b620:0:b0:541:8995:5334 with SMTP id
 u32-20020a81b620000000b0054189955334mr6757315ywh.3.1679996566699; Tue, 28 Mar
 2023 02:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <97f19214-ba04-c47e-7486-72e8aa16c690@sberdevices.ru>
 <99da938b-3e67-150c-2f74-41d917a95950@sberdevices.ru>
 <itjmw7vh3a7ggbodsu4mksu2hqbpdpxmu6cpexbra66nfhsw4x@hzpuzwldkfx5>
In-Reply-To: <itjmw7vh3a7ggbodsu4mksu2hqbpdpxmu6cpexbra66nfhsw4x@hzpuzwldkfx5>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 28 Mar 2023 11:42:35 +0200
Message-ID: <CAGxU2F648TyvAJN+Zk6YCnGUhn=0W_MZTox7RxQ45zHmHHO0SA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] vsock: return errors other than -ENOMEM to
 socket
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>, Bryan Tan <bryantan@vmware.com>,
 Vishnu Dasa <vdasa@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kernel@sberdevices.ru, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

SSBwcmVzc2VkIHNlbmQgdG9vIGVhcmx5Li4uCgpDQ2luZyBCcnlhbiwgVmlzaG51LCBhbmQgcHYt
ZHJpdmVyc0B2bXdhcmUuY29tCgpPbiBUdWUsIE1hciAyOCwgMjAyMyBhdCAxMTozOeKAr0FNIFN0
ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBTdW4s
IE1hciAyNiwgMjAyMyBhdCAwMToxMzoxMUFNICswMzAwLCBBcnNlbml5IEtyYXNub3Ygd3JvdGU6
Cj4gPlRoaXMgcmVtb3ZlcyBiZWhhdmlvdXIsIHdoZXJlIGVycm9yIGNvZGUgcmV0dXJuZWQgZnJv
bSBhbnkgdHJhbnNwb3J0Cj4gPndhcyBhbHdheXMgc3dpdGNoZWQgdG8gRU5PTUVNLiBUaGlzIHdv
cmtzIGluIHRoZSBzYW1lIHdheSBhczoKPiA+Y29tbWl0Cj4gPmM0MzE3MGI3ZTE1NyAoInZzb2Nr
OiByZXR1cm4gZXJyb3JzIG90aGVyIHRoYW4gLUVOT01FTSB0byBzb2NrZXQiKSwKPiA+YnV0IGZv
ciByZWNlaXZlIGNhbGxzLgo+ID4KPiA+U2lnbmVkLW9mZi1ieTogQXJzZW5peSBLcmFzbm92IDxB
VktyYXNub3ZAc2JlcmRldmljZXMucnU+Cj4gPi0tLQo+ID4gbmV0L3Ztd192c29jay9hZl92c29j
ay5jIHwgNCArKy0tCj4gPiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQo+ID4KPiA+ZGlmZiAtLWdpdCBhL25ldC92bXdfdnNvY2svYWZfdnNvY2suYyBiL25l
dC92bXdfdnNvY2svYWZfdnNvY2suYwo+ID5pbmRleCAxOWFlYTdjYmEyNmUuLjkyNjJlMGI3N2Q0
NyAxMDA2NDQKPiA+LS0tIGEvbmV0L3Ztd192c29jay9hZl92c29jay5jCj4gPisrKyBiL25ldC92
bXdfdnNvY2svYWZfdnNvY2suYwo+ID5AQCAtMjAwNyw3ICsyMDA3LDcgQEAgc3RhdGljIGludCBf
X3Zzb2NrX3N0cmVhbV9yZWN2bXNnKHN0cnVjdCBzb2NrICpzaywgc3RydWN0IG1zZ2hkciAqbXNn
LAo+ID4KPiA+ICAgICAgICAgICAgICAgcmVhZCA9IHRyYW5zcG9ydC0+c3RyZWFtX2RlcXVldWUo
dnNrLCBtc2csIGxlbiAtIGNvcGllZCwgZmxhZ3MpOwo+Cj4gSW4gdm1jaV90cmFuc3BvcnRfc3Ry
ZWFtX2RlcXVldWUoKSB2bWNpX3FwYWlyX3BlZWt2KCkgYW5kCj4gdm1jaV9xcGFpcl9kZXF1ZXYo
KSByZXR1cm4gVk1DSV9FUlJPUl8qIGluIGNhc2Ugb2YgZXJyb3JzLgo+Cj4gTWF5YmUgd2Ugc2hv
dWxkIHJldHVybiAtRU5PTUVNIGluIHZtY2lfdHJhbnNwb3J0X3N0cmVhbV9kZXF1ZXVlKCkgaWYK
PiB0aG9zZSBmdW5jdGlvbnMgZmFpbCB0byBrZWVwIHRoZSBzYW1lIGJlaGF2aW9yLgo+Cj4gQ0Np
bmcgQnJ5YW4sIFZpc2hudSwgYW5kIHB2LWRyaXZlcnNAdm13YXJlLmNvbQo+Cj4gVGhlIG90aGVy
IHRyYW5zcG9ydHMgc2VlbSBva2F5IHRvIG1lLgo+Cj4gVGhhbmtzLAo+IFN0ZWZhbm8KPgo+ID4g
ICAgICAgICAgICAgICBpZiAocmVhZCA8IDApIHsKPiA+LSAgICAgICAgICAgICAgICAgICAgICBl
cnIgPSAtRU5PTUVNOwo+ID4rICAgICAgICAgICAgICAgICAgICAgIGVyciA9IHJlYWQ7Cj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gPiAgICAgICAgICAgICAgIH0KPiA+Cj4gPkBA
IC0yMDU4LDcgKzIwNTgsNyBAQCBzdGF0aWMgaW50IF9fdnNvY2tfc2VxcGFja2V0X3JlY3Ztc2co
c3RydWN0IHNvY2sgKnNrLCBzdHJ1Y3QgbXNnaGRyICptc2csCj4gPiAgICAgICBtc2dfbGVuID0g
dHJhbnNwb3J0LT5zZXFwYWNrZXRfZGVxdWV1ZSh2c2ssIG1zZywgZmxhZ3MpOwo+ID4KPiA+ICAg
ICAgIGlmIChtc2dfbGVuIDwgMCkgewo+ID4tICAgICAgICAgICAgICBlcnIgPSAtRU5PTUVNOwo+
ID4rICAgICAgICAgICAgICBlcnIgPSBtc2dfbGVuOwo+ID4gICAgICAgICAgICAgICBnb3RvIG91
dDsKPiA+ICAgICAgIH0KPiA+Cj4gPi0tCj4gPjIuMjUuMQo+ID4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
