Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E2AEB64DA
	for <virtualization@archiver.kernel.org>; Tue, 18 Jul 2023 10:33:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 072B240544;
	Tue, 18 Jul 2023 10:33:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 072B240544
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cnLTzrud
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kh9mBzq04d8U; Tue, 18 Jul 2023 10:33:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 325824050F;
	Tue, 18 Jul 2023 10:32:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 325824050F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9949C0072;
	Tue, 18 Jul 2023 10:32:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6144AC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jul 2023 10:32:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 307EB60A67
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jul 2023 10:32:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 307EB60A67
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cnLTzrud
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hkAY1-wUNGjA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jul 2023 10:32:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B506C606F9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B506C606F9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jul 2023 10:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689676375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LJ9VjFOAX7KEpsqx+3rsCh7QB66sbTgBmRj0i8t7LUg=;
 b=cnLTzrudeYeQsBCnLZxLqMWpdR4XGyVqPXgFSIrI+OKtH6uzA0RyML63xU+67F0Tn+5q2T
 tB87+wFn03cL45XhP6jStcRkoQRGyVnLz1uqTMWiEqjKOto/JMRZNQq6zB+Ufgrr07VNbH
 SsqYqnIgOG3y9rSPJr6d/+FqIZI3ZFg=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-GjnZjCSuNs2Q-QQEynbMWA-1; Tue, 18 Jul 2023 06:32:54 -0400
X-MC-Unique: GjnZjCSuNs2Q-QQEynbMWA-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-56cf9a86277so52992747b3.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jul 2023 03:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689676373; x=1690281173;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LJ9VjFOAX7KEpsqx+3rsCh7QB66sbTgBmRj0i8t7LUg=;
 b=FoPX7bb22M5ksAo9C6KEc0b+NHLFS2AWVHEitq/F7RPof2DmDOKo6JxXVXamP4L/Hp
 /76+lTLF0s7R3PJMFe60FOOjSs9C+nsdzq1/n35vzUeUDLQOM+/BONpOHI+kmdolA+Tu
 AC++q9opkiLjIf4O1diUqEwnVAM+kGwOuS8Nouu3lagRVCYnPC03jGgsid3Tdq0XJUrG
 pXGi5nW4RCFEuivoEdH5rRbYa4yGGU29euCVU2RbWooCedMvInnFHoOriJORz+fWnQXc
 lTGIxPRrMXk6CRCI1bvqXP2ZqFki1AHkjAcTsClbmiax/OqFMpRQ80Y54EX9vXwGHFfj
 yMFw==
X-Gm-Message-State: ABy/qLYsRsP6DyxbhQA6HFDIjNZkeUgir3L3MWbwwjOUcBSFiLEKdlII
 tVd6j2mzKe22+vZvGDafpBg4Dq2dfZ5Il4E0z8uB2eg0GiIwRkksXcGiho4jZHNz+gSkFMmu1mt
 NCxQPKPZFGCGSatLkSNqjAp0BSN/PsFOiTmHKs7CHhrXpslFRaiABn6aG0g==
X-Received: by 2002:a0d:d8c9:0:b0:56d:2490:7cde with SMTP id
 a192-20020a0dd8c9000000b0056d24907cdemr14789755ywe.50.1689676373083; 
 Tue, 18 Jul 2023 03:32:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHh8k3t3IqzzvYl1s7LPsoKr9b2R0bmumUYFEbPNxabAWjebYIVQ+sEo+6VeMyB0kSsryVx8PoR+hEwPIikfak=
X-Received: by 2002:a0d:d8c9:0:b0:56d:2490:7cde with SMTP id
 a192-20020a0dd8c9000000b0056d24907cdemr14789740ywe.50.1689676372798; Tue, 18
 Jul 2023 03:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230418225638.1467969-1-peili.dev@gmail.com>
 <CAJaqyWebSowMMWh+HCjj7tmbA3Ey6C69T=SPA4k+6fd_-GjfoA@mail.gmail.com>
 <CACGkMEu0d0y82wo1p2g-ovbUTYJcVon0-t8fvgFQLokZmd7hDQ@mail.gmail.com>
In-Reply-To: <CACGkMEu0d0y82wo1p2g-ovbUTYJcVon0-t8fvgFQLokZmd7hDQ@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 18 Jul 2023 12:32:41 +0200
Message-ID: <CAGxU2F4N+xAM0gRh2dHDLSujkJ4Ek--Hk+PoTHOsxe4k+GTrrA@mail.gmail.com>
Subject: vdpa: use io_uring passthrough command for IOCTLs [was Re: [PATCH
 1/2] Reduce vdpa initialization / startup overhead]
To: Jason Wang <jasowang@redhat.com>, Michael Tsirkin <mst@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: peili.dev@gmail.com, qemu devel list <qemu-devel@nongnu.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>
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

T24gVGh1LCBBcHIgMjAsIDIwMjMgYXQgNjoyMOKAr0FNIEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gV2VkLCBBcHIgMTksIDIwMjMgYXQgMTE6MzPigK9QTSBF
dWdlbmlvIFBlcmV6IE1hcnRpbgo+IDxlcGVyZXptYUByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4g
PiBPbiBXZWQsIEFwciAxOSwgMjAyMyBhdCAxMjo1NuKAr0FNIDxwZWlsaS5kZXZAZ21haWwuY29t
PiB3cm90ZToKPiA+ID4KPiA+ID4gRnJvbTogUGVpIExpIDxwZWlsaS5kZXZAZ21haWwuY29tPgo+
ID4gPgo+ID4gPiBDdXJyZW50bHksIHBhcnQgb2YgdGhlIHZkcGEgaW5pdGlhbGl6YXRpb24gLyBz
dGFydHVwIHByb2Nlc3MKPiA+ID4gbmVlZHMgdG8gdHJpZ2dlciBtYW55IGlvY3RscyBwZXIgdnEs
IHdoaWNoIGlzIHZlcnkgaW5lZmZpY2llbnQKPiA+ID4gYW5kIGNhdXNpbmcgdW5uZWNlc3Nhcnkg
Y29udGV4dCBzd2l0Y2ggYmV0d2VlbiB1c2VyIG1vZGUgYW5kCj4gPiA+IGtlcm5lbCBtb2RlLgo+
ID4gPgo+ID4gPiBUaGlzIHBhdGNoIGNyZWF0ZXMgYW4gYWRkaXRpb25hbCBpb2N0bCgpIGNvbW1h
bmQsIG5hbWVseQo+ID4gPiBWSE9TVF9WRFBBX0dFVF9WUklOR19HUk9VUF9CQVRDSCwgdGhhdCB3
aWxsIGJhdGNoaW5nCj4gPiA+IGNvbW1hbmRzIG9mIFZIT1NUX1ZEUEFfR0VUX1ZSSU5HX0dST1VQ
IGludG8gYSBzaW5nbGUKPiA+ID4gaW9jdGwoKSBjYWxsLgo+Cj4gSSdkIGV4cGVjdCB0aGVyZSdz
IGEga2VybmVsIHBhdGNoIGJ1dCBJIGRpZG4ndCBzZWUgdGhhdD8KPgo+IElmIHdlIHdhbnQgdG8g
Z28gdGhpcyB3YXkuIFdoeSBzaW1wbHkgaGF2ZSBhIG1vcmUgZ2VuZXJpYyB3YXksIHRoYXQgaXMK
PiBpbnRyb2R1Y2luZyBzb21ldGhpbmcgbGlrZToKPgo+IFZIT1NUX0NNRF9CQVRDSCB3aGljaCBk
aWQgc29tZXRoaW5nIGxpa2UKPgo+IHN0cnVjdCB2aG9zdF9jbWRfYmF0Y2ggewo+ICAgICBpbnQg
bmNtZHM7Cj4gICAgIHN0cnVjdCB2aG9zdF9pb2N0bHNbXTsKPiB9Owo+Cj4gVGhlbiB5b3UgY2Fu
IGJhdGNoIG90aGVyIGlvY3RscyBvdGhlciB0aGFuIEdFVF9WUklOR19HUk9VUD8KPgoKSnVzdCBy
ZXN0YXJ0aW5nIHRoaXMgZGlzY3Vzc2lvbiwgc2luY2UgSSByZWNlbnRseSB3b3JrZWQgbW9yZSB3
aXRoCmlvX3VyaW5nIHBhc3N0aHJvdWdoIGNvbW1hbmRzIGFuZCBJIHRoaW5rIGl0IGNhbiBoZWxw
IGhlcmUuCgpUaGUgTlZNZSBndXlzIGhhZCBhIHNpbWlsYXIgcHJvYmxlbSAoaW9jdGwgdG9vIHNs
b3cgZm9yIHRoZWlyIHVzZQpjYXNlKVsxXVsyXSwgc28gdGhleSBkZXZlbG9wZWQgYSBuZXcgZmVh
dHVyZSBpbiBpb191cmluZyB0aGF0CmJhc2ljYWxseSBhbGxvd3MgeW91IHRvIGRvIElPQ1RMcyBh
c3luY2hyb25vdXNseSBhbmQgaW4gYmF0Y2hlcyB1c2luZwppb191cmluZy4KClRoZSBzYW1lIGZl
YXR1cmUgaXMgYWxzbyB1c2VkIGJ5IHVibGsgWzNdIGFuZCBJIHJlY2VudGx5IHRhbGtlZCBhYm91
dAp0aGlzIGF0IERldkNvbmYgd2l0aCBHZXJtYW4gWzRdLgoKQmFzaWNhbGx5LCB0aGVyZSdzIGEg
bmV3IGNhbGxiYWNrIGluIGZvcHMgKHN0cnVjdCBmaWxlX29wZXJhdGlvbnMudXJpbmdfY21kKS4K
SUlVQyBmb3IgTlZNZSAoZHJpdmVycy9udm1lL2hvc3QvaW9jdGwuYykgdGhleSB1c2VkIGV4YWN0
bHkgdGhlIHNhbWUKdmFsdWVzIHVzZWQgZm9yIElPQ1RMcyBhbHNvIGZvciB0aGUgbmV3IHVyaW5n
X2NtZCBjYWxsYmFjay4KCldlIGNvdWxkIGRvIHRoZSBzYW1lLiBUaGUgY2hhbmdlcyBpbiB0aGUg
dmhvc3QtdmRwYSBrZXJuZWwgbW9kdWxlCnNob3VsZCBiZSBzaW1wbGUsIGFuZCB3ZSBjb3VsZCBz
aGFyZSB0aGUgY29kZSBmb3IgaGFuZGxpbmcgaW9jdGwgYW5kCnVyaW5nX2NtZC4KVGhhdCB3YXkg
YW55IG5ldyBjb21tYW5kIGNhbiBiZSBzdXBwb3J0ZWQgd2l0aCBib3RoIGZvciBjb21wYXRpYmls
aXR5LgoKSW4gUUVNVSB0aGVuIHdlIGNhbiBzdGFydCB1c2luZyBpdCB0byBvcHRpbWl6ZSB0aGUg
Y29udHJvbCBwYXRoLgoKV2hhdCBkbyB5b3UgdGhpbms/CgpJZiBpdCdzIGludGVyZXN0aW5nLCBJ
IGNvdWxkIHRocm93IGRvd24gYW4gUkZDIHdpdGggdGhlIGNoYW5nZXMgb3IgaWYKYW55b25lIGlz
IGludGVyZXN0ZWQgaW4gd29ya2luZyBvbiBpdCwgSSBjYW4gaGVscCB3aXRoIHRoZSBkZXRhaWxz
LgoKVGhhbmtzLApTdGVmYW5vCgpbMV0gaHR0cHM6Ly9scGMuZXZlbnRzL2V2ZW50LzExL2NvbnRy
aWJ1dGlvbnMvOTg5LwpbMl0gaHR0cHM6Ly9scGMuZXZlbnRzL2V2ZW50LzE2L2NvbnRyaWJ1dGlv
bnMvMTM4Mi8KWzNdIGh0dHBzOi8vbHduLm5ldC9BcnRpY2xlcy85MDM4NTUvCls0XSBodHRwczov
L3d3dy55b3V0dWJlLmNvbS93YXRjaD92PTZKcU5QaXJyZW9ZCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
