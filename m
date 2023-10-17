Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E239CCDB465
	for <virtualization@archiver.kernel.org>; Tue, 17 Oct 2023 03:28:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E7CF81F56;
	Tue, 17 Oct 2023 03:28:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5E7CF81F56
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mp4urfuQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OwsF_XFjoRxL; Tue, 17 Oct 2023 03:28:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A6B4A81F1F;
	Tue, 17 Oct 2023 03:28:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A6B4A81F1F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84AE4C0071;
	Tue, 17 Oct 2023 03:28:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4E26C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 03:28:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7A9DB60D76
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 03:28:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A9DB60D76
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mp4urfuQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AbKhx7tzGdMd
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 03:28:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4BA3A60B05
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 03:28:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4BA3A60B05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697513308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GYCSQYqds4DMd4Ao7B2IRHBxioxzzukKv5sP1PTQE00=;
 b=Mp4urfuQS2EnfhTZl3CUACdo14GccwYEEFzcPJZlrmlmIIOu28BhwHuKxi/TzFhqcZ8Wzt
 9MQDc/aXPro2nuSN7u/g3wwB4ffS525xRQLmv/XDaLh7Zxz1I0oXL8+MsFZyDEAmI1MGb2
 d3M4rDvtz9nDppOClGKc1F+rQ98IceA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-huPkkYrhPK6_Ta_zpNoCww-1; Mon, 16 Oct 2023 23:28:25 -0400
X-MC-Unique: huPkkYrhPK6_Ta_zpNoCww-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-507b8ac8007so960347e87.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 20:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697513304; x=1698118104;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GYCSQYqds4DMd4Ao7B2IRHBxioxzzukKv5sP1PTQE00=;
 b=SmvEPTrry5tTy8YKyRDfnzjHydyRxOr8nR4JlgKHwMQCiwXWzeIxOp27YqsK6TUXgW
 DcLsDeYHx7dHmIlwyeyV/fWJFgJ1UDyt9FL8ebVd4g7bf+A2w9SjFAwqGBgGlYz8o3T0
 sEbZ701jCy6R0rhkoaBpwXzekOFKUc2UEuv9LqGPdCAyYatGmaxam/KaRhezv42OtL0O
 O1pSsx+YzHRNCPShEx9qtj9D6q9QVPtZsj+LjW5it/UwbdK3J84a8wPDVIuyR/xFRDd3
 3x8w5oQ6FlclXSo/yqbiQKUGQ47i0+vN4IkntAtCbp9jqWWaySmTbodrF48EeZG1PpjF
 XBwA==
X-Gm-Message-State: AOJu0YzE8qPB3Py1YgM1XYHBk8WjKow3DwB24M0KlYl8KPhuPlJtd/Af
 GnDM9NStI8MElVGQjWmKYe4856nW0j1mNMKLFxkNDy+yKIs1d3I/IRR1nkl6Q8M8yTVAFqrr7/T
 JxhuyDl0/Lo3FEjC/gmZ/xNzIr8iAvIhPfAV/TqHyFTd+TzNJghDz2un/Vg==
X-Received: by 2002:a05:6512:3281:b0:507:a58f:79ac with SMTP id
 p1-20020a056512328100b00507a58f79acmr855140lfe.33.1697513304266; 
 Mon, 16 Oct 2023 20:28:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEN/Ezj+KzyQRY+7SW6mUopH1XVyGqOf/FfIJffqbAIFRJiAxwNowEknkKLe3v6Jc6d+Q8HGNfc2VdeLRLYIeA=
X-Received: by 2002:a05:6512:3281:b0:507:a58f:79ac with SMTP id
 p1-20020a056512328100b00507a58f79acmr855123lfe.33.1697513303922; Mon, 16 Oct
 2023 20:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEs4u-4ch2UAK14hNfKeORjqMu4BX7=46OfaXpvxW+VT7w@mail.gmail.com>
 <1697511725.2037013-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEskfXDo+bnx5hbGU3JRwOgBRwOC-bYDdFYSmEO2jjgPnA@mail.gmail.com>
 <1697512950.0813534-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1697512950.0813534-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 17 Oct 2023 11:28:12 +0800
Message-ID: <CACGkMEtppjoX_WAM+vjzkMKaMQQ0iZL=C_xS4RObuoLbm0udUw@mail.gmail.com>
Subject: Re: [PATCH net-next v1 00/19] virtio-net: support AF_XDP zero copy
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

T24gVHVlLCBPY3QgMTcsIDIwMjMgYXQgMTE6MjbigK9BTSBYdWFuIFpodW8gPHh1YW56aHVvQGxp
bnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIFR1ZSwgMTcgT2N0IDIwMjMgMTE6MjA6NDEg
KzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gT24gVHVl
LCBPY3QgMTcsIDIwMjMgYXQgMTE6MTHigK9BTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFs
aWJhYmEuY29tPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gVHVlLCAxNyBPY3QgMjAyMyAxMDo1Mzo0
NCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4g
T24gTW9uLCBPY3QgMTYsIDIwMjMgYXQgODowMOKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4gPiA+ID4KPiA+ID4gPiA+ICMjIEFGX1hEUAo+ID4g
PiA+ID4KPiA+ID4gPiA+IFhEUCBzb2NrZXQoQUZfWERQKSBpcyBhbiBleGNlbGxlbnQgYnlwYXNz
IGtlcm5lbCBuZXR3b3JrIGZyYW1ld29yay4gVGhlIHplcm8KPiA+ID4gPiA+IGNvcHkgZmVhdHVy
ZSBvZiB4c2sgKFhEUCBzb2NrZXQpIG5lZWRzIHRvIGJlIHN1cHBvcnRlZCBieSB0aGUgZHJpdmVy
LiBUaGUKPiA+ID4gPiA+IHBlcmZvcm1hbmNlIG9mIHplcm8gY29weSBpcyB2ZXJ5IGdvb2QuIG1s
eDUgYW5kIGludGVsIGl4Z2JlIGFscmVhZHkgc3VwcG9ydAo+ID4gPiA+ID4gdGhpcyBmZWF0dXJl
LCBUaGlzIHBhdGNoIHNldCBhbGxvd3MgdmlydGlvLW5ldCB0byBzdXBwb3J0IHhzaydzIHplcm9j
b3B5IHhtaXQKPiA+ID4gPiA+IGZlYXR1cmUuCj4gPiA+ID4gPgo+ID4gPiA+ID4gQXQgcHJlc2Vu
dCwgd2UgaGF2ZSBjb21wbGV0ZWQgc29tZSBwcmVwYXJhdGlvbjoKPiA+ID4gPiA+Cj4gPiA+ID4g
PiAxLiB2cS1yZXNldCAodmlydGlvIHNwZWMgYW5kIGtlcm5lbCBjb2RlKQo+ID4gPiA+ID4gMi4g
dmlydGlvLWNvcmUgcHJlbWFwcGVkIGRtYQo+ID4gPiA+ID4gMy4gdmlydGlvLW5ldCB4ZHAgcmVm
YWN0b3IKPiA+ID4gPiA+Cj4gPiA+ID4gPiBTbyBpdCBpcyB0aW1lIGZvciBWaXJ0aW8tTmV0IHRv
IGNvbXBsZXRlIHRoZSBzdXBwb3J0IGZvciB0aGUgWERQIFNvY2tldAo+ID4gPiA+ID4gWmVyb2Nv
cHkuCj4gPiA+ID4gPgo+ID4gPiA+ID4gVmlydGlvLW5ldCBjYW4gbm90IGluY3JlYXNlIHRoZSBx
dWV1ZSBudW0gYXQgd2lsbCwgc28geHNrIHNoYXJlcyB0aGUgcXVldWUgd2l0aAo+ID4gPiA+ID4g
a2VybmVsLgo+ID4gPiA+ID4KPiA+ID4gPiA+IE9uIHRoZSBvdGhlciBoYW5kLCBWaXJ0aW8tTmV0
IGRvZXMgbm90IHN1cHBvcnQgZ2VuZXJhdGUgaW50ZXJydXB0IGZyb20gZHJpdmVyCj4gPiA+ID4g
PiBtYW51YWxseSwgc28gd2hlbiB3ZSB3YWtldXAgdHggeG1pdCwgd2UgdXNlZCBzb21lIHRpcHMu
IElmIHRoZSBDUFUgcnVuIGJ5IFRYCj4gPiA+ID4gPiBOQVBJIGxhc3QgdGltZSBpcyBvdGhlciBD
UFVzLCB1c2UgSVBJIHRvIHdha2UgdXAgTkFQSSBvbiB0aGUgcmVtb3RlIENQVS4gSWYgaXQKPiA+
ID4gPiA+IGlzIGFsc28gdGhlIGxvY2FsIENQVSwgdGhlbiB3ZSB3YWtlIHVwIG5hcGkgZGlyZWN0
bHkuCj4gPiA+ID4gPgo+ID4gPiA+ID4gVGhpcyBwYXRjaCBzZXQgaW5jbHVkZXMgc29tZSByZWZh
Y3RvciB0byB0aGUgdmlydGlvLW5ldCB0byBsZXQgdGhhdCB0byBzdXBwb3J0Cj4gPiA+ID4gPiBB
Rl9YRFAuCj4gPiA+ID4gPgo+ID4gPiA+ID4gIyMgcGVyZm9ybWFuY2UKPiA+ID4gPiA+Cj4gPiA+
ID4gPiBFTlY6IFFlbXUgd2l0aCB2aG9zdC11c2VyKHBvbGxpbmcgbW9kZSkuCj4gPiA+ID4gPgo+
ID4gPiA+ID4gU29ja3BlcmY6IGh0dHBzOi8vZ2l0aHViLmNvbS9NZWxsYW5veC9zb2NrcGVyZgo+
ID4gPiA+ID4gSSB1c2UgdGhpcyB0b29sIHRvIHNlbmQgdWRwIHBhY2tldCBieSBrZXJuZWwgc3lz
Y2FsbC4KPiA+ID4gPiA+Cj4gPiA+ID4gPiB4bWl0IGNvbW1hbmQ6IHNvY2twZXJmIHRwIC1pIDEw
LjAuMy4xIC10IDEwMDAKPiA+ID4gPiA+Cj4gPiA+ID4gPiBJIHdyaXRlIGEgdG9vbCB0aGF0IHNl
bmRzIHVkcCBwYWNrZXRzIG9yIHJlY3ZzIHVkcCBwYWNrZXRzIGJ5IEFGX1hEUC4KPiA+ID4gPiA+
Cj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICB8IEd1ZXN0IEFQUCBDUFUgfEd1ZXN0IFNvZnRp
cnEgQ1BVIHwgVURQIFBQUwo+ID4gPiA+ID4gLS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0t
LS0tLXwtLS0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tCj4gPiA+ID4gPiB4bWl0IGJ5IHN5
c2NhbGwgICB8ICAgMTAwJSAgICAgICAgfCAgICAgICAgICAgICAgICAgIHwgICA2NzYsOTE1Cj4g
PiA+ID4gPiB4bWl0IGJ5IHhzayAgICAgICB8ICAgNTkuMSUgICAgICAgfCAgIDEwMCUgICAgICAg
ICAgIHwgNSw0NDcsMTY4Cj4gPiA+ID4gPiByZWN2IGJ5IHN5c2NhbGwgICB8ICAgNjAlICAgICAg
ICAgfCAgIDEwMCUgICAgICAgICAgIHwgICA5MzIsMjg4Cj4gPiA+ID4gPiByZWN2IGJ5IHhzayAg
ICAgICB8ICAgMzUuNyUgICAgICAgfCAgIDEwMCUgICAgICAgICAgIHwgMywzNDMsMTY4Cj4gPiA+
ID4KPiA+ID4gPiBBbnkgY2hhbmNlIHdlIGNhbiBnZXQgYSB0ZXN0cG1kIHJlc3VsdCAod2hpY2gg
SSBndWVzcyBzaG91bGQgYmUgYmV0dGVyCj4gPiA+ID4gdGhhbiBQUFMgYWJvdmUpPwo+ID4gPgo+
ID4gPiBEbyB5b3UgbWVhbiB0ZXN0cG1kICsgRFBESyArIEFGX1hEUD8KPiA+Cj4gPiBZZXMuCj4g
Pgo+ID4gPgo+ID4gPiBZZXMuIFRoaXMgaXMgcHJvYmFibHkgYmV0dGVyIGJlY2F1c2UgbXkgdG9v
bCBkb2VzIG1vcmUgd29yay4gVGhhdCBpcyBub3QgYQo+ID4gPiBjb21wbGV0ZSB0ZXN0aW5nIHRv
b2wgdXNlZCBieSBvdXIgYnVzaW5lc3MuCj4gPgo+ID4gUHJvYmFibHksIGJ1dCBpdCB3b3VsZCBi
ZSBhcHBlYWxpbmcgZm9yIG90aGVycy4gRXNwZWNpYWxseSBjb25zaWRlcmluZwo+ID4gRFBESyBz
dXBwb3J0cyBBRl9YRFAgUE1EIG5vdy4KPgo+IE9LLgo+Cj4gTGV0IG1lIHRyeS4KPgo+IEJ1dCBj
b3VsZCB5b3Ugc3RhcnQgdG8gcmV2aWV3IGZpcnN0bHk/CgpZZXMsIGl0J3MgaW4gbXkgdG9kbyBs
aXN0LgoKPgo+Cj4gPgo+ID4gPgo+ID4gPiBXaGF0IEkgbm90aWNlZCBpcyB0aGF0IHRoZSBob3Rz
cG90IGlzIHRoZSBkcml2ZXIgd3JpdGluZyB2aXJ0aW8gZGVzYy4gQmVjYXVzZQo+ID4gPiB0aGUg
ZGV2aWNlIGlzIGluIGJ1c3kgbW9kZS4gU28gdGhlcmUgaXMgcmFjZSBiZXR3ZWVuIGRyaXZlciBh
bmQgZGV2aWNlLgo+ID4gPiBTbyBJIG1vZGlmaWVkIHRoZSB2aXJ0aW8gY29yZSBhbmQgbGF6aWx5
IHVwZGF0ZWQgYXZhaWwgaWR4LiBUaGVuIHBwcyBjYW4gcmVhY2gKPiA+ID4gMTAsMDAwLDAwMC4K
PiA+Cj4gPiBDYXJlIHRvIHBvc3QgYSBkcmFmdCBmb3IgdGhpcz8KPgo+IFlFUywgSSBpcyB0aGlu
a2luZyBmb3IgdGhpcy4KPiBCdXQgbWF5YmUgdGhhdCBpcyBqdXN0IHdvcmsgZm9yIHNwbGl0LiBU
aGUgcGFja2VkIG1vZGUgaGFzIHNvbWUgdHJvdWJsZXMuCgpPay4KClRoYW5rcwoKPgo+IFRoYW5r
cy4KPgo+ID4KPiA+IFRoYW5rcwo+ID4KPiA+ID4KPiA+ID4gVGhhbmtzLgo+ID4gPgo+ID4gPiA+
Cj4gPiA+ID4gVGhhbmtzCj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiAjIyBtYWludGFpbgo+
ID4gPiA+ID4KPiA+ID4gPiA+IEkgYW0gY3VycmVudGx5IGEgcmV2aWV3ZXIgZm9yIHZpcnRpby1u
ZXQuIEkgY29tbWl0IHRvIG1haW50YWluIEFGX1hEUCBzdXBwb3J0IGluCj4gPiA+ID4gPiB2aXJ0
aW8tbmV0Lgo+ID4gPiA+ID4KPiA+ID4gPiA+IFBsZWFzZSByZXZpZXcuCj4gPiA+ID4gPgo+ID4g
PiA+ID4gVGhhbmtzLgo+ID4gPiA+ID4KPiA+ID4gPiA+IHYxOgo+ID4gPiA+ID4gICAgIDEuIHJl
bW92ZSB0d28gdmlydGlvIGNvbW1pdHMuIFB1c2ggdGhpcyBwYXRjaHNldCB0byBuZXQtbmV4dAo+
ID4gPiA+ID4gICAgIDIuIHNxdWFzaCAidmlydGlvX25ldDogdmlydG5ldF9wb2xsX3R4IHN1cHBv
cnQgcmVzY2hlZHVsZWQiIHRvIHhzazogc3VwcG9ydCB0eAo+ID4gPiA+ID4gICAgIDMuIGZpeCBz
b21lIHdhcm5pbmdzCj4gPiA+ID4gPgo+ID4gPiA+ID4gWHVhbiBaaHVvICgxOSk6Cj4gPiA+ID4g
PiAgIHZpcnRpb19uZXQ6IHJlbmFtZSBmcmVlX29sZF94bWl0X3NrYnMgdG8gZnJlZV9vbGRfeG1p
dAo+ID4gPiA+ID4gICB2aXJ0aW9fbmV0OiB1bmlmeSB0aGUgY29kZSBmb3IgcmVjeWNsaW5nIHRo
ZSB4bWl0IHB0cgo+ID4gPiA+ID4gICB2aXJ0aW9fbmV0OiBpbmRlcGVuZGVudCBkaXJlY3RvcnkK
PiA+ID4gPiA+ICAgdmlydGlvX25ldDogbW92ZSB0byB2aXJ0aW9fbmV0LmgKPiA+ID4gPiA+ICAg
dmlydGlvX25ldDogYWRkIHByZWZpeCB2aXJ0bmV0IHRvIGFsbCBzdHJ1Y3QvYXBpIGluc2lkZSB2
aXJ0aW9fbmV0LmgKPiA+ID4gPiA+ICAgdmlydGlvX25ldDogc2VwYXJhdGUgdmlydG5ldF9yeF9y
ZXNpemUoKQo+ID4gPiA+ID4gICB2aXJ0aW9fbmV0OiBzZXBhcmF0ZSB2aXJ0bmV0X3R4X3Jlc2l6
ZSgpCj4gPiA+ID4gPiAgIHZpcnRpb19uZXQ6IHNxIHN1cHBvcnQgcHJlbWFwcGVkIG1vZGUKPiA+
ID4gPiA+ICAgdmlydGlvX25ldDogeHNrOiBiaW5kL3VuYmluZCB4c2sKPiA+ID4gPiA+ICAgdmly
dGlvX25ldDogeHNrOiBwcmV2ZW50IGRpc2FibGUgdHggbmFwaQo+ID4gPiA+ID4gICB2aXJ0aW9f
bmV0OiB4c2s6IHR4OiBzdXBwb3J0IHR4Cj4gPiA+ID4gPiAgIHZpcnRpb19uZXQ6IHhzazogdHg6
IHN1cHBvcnQgd2FrZXVwCj4gPiA+ID4gPiAgIHZpcnRpb19uZXQ6IHhzazogdHg6IHZpcnRuZXRf
ZnJlZV9vbGRfeG1pdCgpIGRpc3Rpbmd1aXNoZXMgeHNrIGJ1ZmZlcgo+ID4gPiA+ID4gICB2aXJ0
aW9fbmV0OiB4c2s6IHR4OiB2aXJ0bmV0X3NxX2ZyZWVfdW51c2VkX2J1ZigpIGNoZWNrIHhzayBi
dWZmZXIKPiA+ID4gPiA+ICAgdmlydGlvX25ldDogeHNrOiByeDogaW50cm9kdWNlIGFkZF9yZWN2
YnVmX3hzaygpCj4gPiA+ID4gPiAgIHZpcnRpb19uZXQ6IHhzazogcng6IGludHJvZHVjZSByZWNl
aXZlX3hzaygpIHRvIHJlY3YgeHNrIGJ1ZmZlcgo+ID4gPiA+ID4gICB2aXJ0aW9fbmV0OiB4c2s6
IHJ4OiB2aXJ0bmV0X3JxX2ZyZWVfdW51c2VkX2J1ZigpIGNoZWNrIHhzayBidWZmZXIKPiA+ID4g
PiA+ICAgdmlydGlvX25ldDogdXBkYXRlIHR4IHRpbWVvdXQgcmVjb3JkCj4gPiA+ID4gPiAgIHZp
cnRpb19uZXQ6IHhkcF9mZWF0dXJlcyBhZGQgTkVUREVWX1hEUF9BQ1RfWFNLX1pFUk9DT1BZCj4g
PiA+ID4gPgo+ID4gPiA+ID4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgIDIgKy0KPiA+ID4gPiA+ICBkcml2ZXJzL25ldC9LY29uZmlnICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgICA4ICstCj4gPiA+ID4gPiAgZHJpdmVycy9uZXQvTWFrZWZpbGUgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgMiArLQo+ID4gPiA+ID4gIGRyaXZlcnMvbmV0L3ZpcnRp
by9LY29uZmlnICAgICAgICAgICAgICAgICAgfCAgMTMgKwo+ID4gPiA+ID4gIGRyaXZlcnMvbmV0
L3ZpcnRpby9NYWtlZmlsZSAgICAgICAgICAgICAgICAgfCAgIDggKwo+ID4gPiA+ID4gIGRyaXZl
cnMvbmV0L3t2aXJ0aW9fbmV0LmMgPT4gdmlydGlvL21haW4uY30gfCA2NTIgKysrKysrKysrLS0t
LS0tLS0tLS0KPiA+ID4gPiA+ICBkcml2ZXJzL25ldC92aXJ0aW8vdmlydGlvX25ldC5oICAgICAg
ICAgICAgIHwgMzU5ICsrKysrKysrKysrCj4gPiA+ID4gPiAgZHJpdmVycy9uZXQvdmlydGlvL3hz
ay5jICAgICAgICAgICAgICAgICAgICB8IDU0NSArKysrKysrKysrKysrKysrCj4gPiA+ID4gPiAg
ZHJpdmVycy9uZXQvdmlydGlvL3hzay5oICAgICAgICAgICAgICAgICAgICB8ICAzMiArCj4gPiA+
ID4gPiAgOSBmaWxlcyBjaGFuZ2VkLCAxMjQ3IGluc2VydGlvbnMoKyksIDM3NCBkZWxldGlvbnMo
LSkKPiA+ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvdmlydGlvL0tjb25m
aWcKPiA+ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvdmlydGlvL01ha2Vm
aWxlCj4gPiA+ID4gPiAgcmVuYW1lIGRyaXZlcnMvbmV0L3t2aXJ0aW9fbmV0LmMgPT4gdmlydGlv
L21haW4uY30gKDkxJSkKPiA+ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQv
dmlydGlvL3ZpcnRpb19uZXQuaAo+ID4gPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJz
L25ldC92aXJ0aW8veHNrLmMKPiA+ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9u
ZXQvdmlydGlvL3hzay5oCj4gPiA+ID4gPgo+ID4gPiA+ID4gLS0KPiA+ID4gPiA+IDIuMzIuMC4z
LmcwMTE5NWNmOWYKPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4KPiA+Cj4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
