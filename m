Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920C5C77B6F
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 09:14:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 03FE281E84;
	Tue, 11 Apr 2023 09:14:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 03FE281E84
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U+7HSel9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zmfmGsuM207B; Tue, 11 Apr 2023 09:14:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5EE7181E20;
	Tue, 11 Apr 2023 09:13:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5EE7181E20
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15B8CC0036;
	Tue, 11 Apr 2023 09:13:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AEE71C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 09:13:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8658F400E2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 09:13:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8658F400E2
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=U+7HSel9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gOArlwAFbSLB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 09:13:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3437C417C0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3437C417C0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 09:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681204435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rG8YVr+3IWo4CE+CY2XyHcE+ZCDuW4teuWofuqNtms0=;
 b=U+7HSel9jMppWWIyNARB03sZZpFm0YdAyDWNFUXCYM8eaUmjByV7zRk/U9axH/l9beXKlL
 mTQvfD6qT/n8zKKhAbWGSMSWJ6GT0VlO9PdX0TTH1EfLa/5vZ2g8rgVyt7Ej2Ii4OfdGEG
 PW6Yok4xcWS4Zwltqz0NLrTPoznugHs=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-AuHOdbhtNlyE4fLtDcEVBw-1; Tue, 11 Apr 2023 05:13:53 -0400
X-MC-Unique: AuHOdbhtNlyE4fLtDcEVBw-1
Received: by mail-oo1-f70.google.com with SMTP id
 n2-20020a4ad622000000b0053e2e3db15dso1408620oon.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 02:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681204433; x=1683796433;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rG8YVr+3IWo4CE+CY2XyHcE+ZCDuW4teuWofuqNtms0=;
 b=2zX53NNA6Z0VMqFurmGQq4m2wbF5AqxU0RXVywRL/9kKFNG1A4YEh+syTP4Kng/JJa
 OC6gqM+Kr1cm9YAa1IwGr1khAr8Q1w+qIk6uRAt9kTpvVwTqGq8KmuxpeZq5kY/AC4gZ
 Q0YhVrolxdd7eIJDplQEDMGxw5JeROs3Tytc7dHtxPei7wM72ENK3wSXCPKrjIWvoXGp
 9ZzyExXLQfkJMxHdRspjlltzKLqyBRl8z5Pq3kHim5ID6dDc8cfWqrXySC0n4yKJv1Tf
 4kdA4M+/50kcyFscu87iv0sUGQyW5DelGqzWzFsiIkz+7fjw2Ew1LrtIdESy6ihmBilc
 X9Pg==
X-Gm-Message-State: AAQBX9fW5mBWtNqXg641772wj+1WDifpPxPhkRC/GCIGWTrBTSi/x4HZ
 5VR2lrVlj+fvZ/EdgXgTfV5jq6S1RPlg1b6nJtEM/R14XeIIpg7osEOxdo+MoS99Sja9XtA46u3
 MGb7NK1VOYQTges2FYKGSzjwkqs7xqutZlleeBlf5LWuw5+IZV0DFBUj25Q==
X-Received: by 2002:aca:280f:0:b0:387:5a8c:4125 with SMTP id
 15-20020aca280f000000b003875a8c4125mr2889709oix.3.1681204432870; 
 Tue, 11 Apr 2023 02:13:52 -0700 (PDT)
X-Google-Smtp-Source: AKy350YvpDPRV+stgWN71cbwISfDR9tuAtGF5dt0HDFBq3HH+19cK/azHyaoNC8arnfyuDaEmDUHp+71+dODeIH4ho4=
X-Received: by 2002:aca:280f:0:b0:387:5a8c:4125 with SMTP id
 15-20020aca280f000000b003875a8c4125mr2889704oix.3.1681204432261; Tue, 11 Apr
 2023 02:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230410150130.837691-1-lulu@redhat.com>
 <CACGkMEvTdgvqacFmMJZD4u++YJwESgSmLF6CMdAJBBqkxpZKgg@mail.gmail.com>
 <CACLfguWKw68=wZNa7Ga+Jm8xTE93A_5za3Dc=S_z7ds9FCkRKg@mail.gmail.com>
In-Reply-To: <CACLfguWKw68=wZNa7Ga+Jm8xTE93A_5za3Dc=S_z7ds9FCkRKg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Apr 2023 17:13:41 +0800
Message-ID: <CACGkMEv3aca0Thx+X3WZxbV2HK7514G3RzR+A0PqRu7k6Deztg@mail.gmail.com>
Subject: Re: [PATCH] vhost_vdpa: fix unmap process in no-batch mode
To: Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com
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

T24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgMzoyOeKAr1BNIENpbmR5IEx1IDxsdWx1QHJlZGhhdC5j
b20+IHdyb3RlOgo+Cj4gT24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgMTE6MTDigK9BTSBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBNb24sIEFwciAxMCwg
MjAyMyBhdCAxMTowMeKAr1BNIENpbmR5IEx1IDxsdWx1QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4g
Pgo+ID4gPiBXaGlsZSB1c2luZyB0aGUgbm8tYmF0Y2ggbW9kZSwgdGhlIHByb2Nlc3Mgd2lsbCBu
b3QgYmVnaW4gd2l0aAo+ID4gPiBWSE9TVF9JT1RMQl9CQVRDSF9CRUdJTiwgc28gd2UgbmVlZCB0
byBhZGQgdGhlCj4gPiA+IFZIT1NUX0lPVExCX0lOVkFMSURBVEUgdG8gZ2V0IHZob3N0X3ZkcGFf
YXMsIHRoZSBwcm9jZXNzIGlzIHRoZQo+ID4gPiBzYW1lIGFzIFZIT1NUX0lPVExCX1VQREFURQo+
ID4gPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBDaW5keSBMdSA8bHVsdUByZWRoYXQuY29tPgo+ID4g
PiAtLS0KPiA+ID4gIGRyaXZlcnMvdmhvc3QvdmRwYS5jIHwgMSArCj4gPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKykKPiA+ID4KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhv
c3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiA+ID4gaW5kZXggN2JlOWQ5ZDhmMDFj
Li4zMjYzNmEwMmEwYWIgMTAwNjQ0Cj4gPiA+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4g
PiA+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gPiA+IEBAIC0xMDc0LDYgKzEwNzQsNyBA
QCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfcHJvY2Vzc19pb3RsYl9tc2coc3RydWN0IHZob3N0X2Rl
diAqZGV2LCB1MzIgYXNpZCwKPiA+ID4gICAgICAgICAgICAgICAgIGdvdG8gdW5sb2NrOwo+ID4g
Pgo+ID4gPiAgICAgICAgIGlmIChtc2ctPnR5cGUgPT0gVkhPU1RfSU9UTEJfVVBEQVRFIHx8Cj4g
PiA+ICsgICAgICAgICAgIG1zZy0+dHlwZSA9PSBWSE9TVF9JT1RMQl9JTlZBTElEQVRFIHx8Cj4g
Pgo+ID4gSSdtIG5vdCBzdXJlIEkgZ2V0IGhlcmUsIGludmFsaWRhdGlvbiBkb2Vzbid0IG5lZWQg
dG8gY3JlYXRlIGEgbmV3IEFTLgo+ID4KPiA+IE9yIG1heWJlIHlvdSBjYW4gcG9zdCB0aGUgdXNl
cnNwYWNlIGNvZGUgdGhhdCBjYW4gdHJpZ2dlciB0aGlzIGlzc3VlPwo+ID4KPiA+IFRoYW5rcwo+
ID4KPiBzb3JyeSBJIGRpZG4ndCB3cml0ZSBpdCBjbGVhcmx5Cj4gRm9yIHRoaXMgaXNzdWUgY2Fu
IHJlcHJvZHVjZSBpbiB2SU9NTVUgbm8tYmF0Y2ggbW9kZSBzdXBwb3J0IGJlY2F1c2UKPiB3aGls
ZSB0aGUgdklPTU1VIGVuYWJsZWQsIGl0IHdpbGwKPiBmbGFzaCBhIGxhcmdlIG1lbW9yeSB0byB1
bm1hcCwgYW5kIHRoaXMgbWVtb3J5IGFyZSBoYXZlbid0IGJlZW4gbWFwcGVkCj4gYmVmb3JlLCBz
byB0aGlzIHVubWFwcGluZyB3aWxsIGZhaWwKPgo+IHFlbXUtc3lzdGVtLXg4Nl82NDogZmFpbGVk
IHRvIHdyaXRlLCBmZD0xMiwgZXJybm89MTQgKEJhZCBhZGRyZXNzKQo+IHFlbXUtc3lzdGVtLXg4
Nl82NDogdmhvc3RfdmRwYV9kbWFfdW5tYXAoMHg3ZmEyNmQxZGQxOTAsIDB4MCwKPiAweDgwMDAw
MDAwKSA9IC01IChCYWQgYWRkcmVzcykKClNvIGlmIHRoaXMgaXMgYSBzaW1wbGUgdW5tYXAsIHdo
aWNoIGVycm9yIGNvbmRpdGlvbiBoYWQgeW91IG1ldCBpbgp2aG9zdF92ZHBhX3Byb2Nlc3NfaW90
bGJfbXNnKCk/CgpJIHRoaW5rIHlvdSBuZWVkIHRvIHRyYWNlIHRvIHNlZSB3aGF0IGhhcHBlbnMu
IEZvciBleGFtcGxlOgoKMSkgY2FuIHRoZSBjb2RlIHBhc3MgYXNpZF90b19pb3RsYigpCjIpIGlm
IG5vdCwgQVNJRCAwIGhhcyBiZWVuIGRlbGV0ZWQgc2luY2UgYWxsIHRoZSBtYXBwaW5ncyBoYXZl
IGJlZW4gdW5tYXBwZWQKCmlmIEFTSUQgMCBoYXMgYmVlbiBjb21wbGV0ZWx5IHVubWFwLCBhbnkg
cmVhc29uIHdlIG5lZWQgdG8gdW5tYXAgaXQKYWdhaW4/IEFuZCBkbyB3ZSBuZWVkIHRvIGRyb3Ag
dGhlIHZob3N0X3ZkcGFfcmVtb3ZlX2FzKCkgZnJvbSBib3RoCgoxKSB2aG9zdF92ZHBhX3VubWFw
KCkKYW5kCjIpIHZob3N0X3ZkcGFfcHJvY2Vzc19pb3RsYl9tc2coKQo/CgpUaGFua3MKCj4gcWVt
dS1zeXN0ZW0teDg2XzY0OiBmYWlsZWQgdG8gd3JpdGUsIGZkPTEyLCBlcnJubz0xNCAoQmFkIGFk
ZHJlc3MpCj4gLi4uLgo+IGluIGJhdGNoIG1vZGUgdGhpcyBvcGVyYXRpb24gd2lsbCBiZWdpbiB3
aXRoIFZIT1NUX0lPVExCX0JBVENIX0JFR0lOLAo+IHNvIGRvbid0IGhhdmUgdGhpcyBpc3N1ZQo+
Cj4gVGhhbmtzCj4gY2luZHkKPiA+ID4gICAgICAgICAgICAgbXNnLT50eXBlID09IFZIT1NUX0lP
VExCX0JBVENIX0JFR0lOKSB7Cj4gPiA+ICAgICAgICAgICAgICAgICBhcyA9IHZob3N0X3ZkcGFf
ZmluZF9hbGxvY19hcyh2LCBhc2lkKTsKPiA+ID4gICAgICAgICAgICAgICAgIGlmICghYXMpIHsK
PiA+ID4gLS0KPiA+ID4gMi4zNC4zCj4gPiA+Cj4gPgo+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
