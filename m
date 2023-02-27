Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541C6C64ED6
	for <virtualization@archiver.kernel.org>; Mon, 27 Feb 2023 08:20:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D40B381CDB;
	Mon, 27 Feb 2023 08:20:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D40B381CDB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bCg7+ByG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PuRrgQf8ezuZ; Mon, 27 Feb 2023 08:20:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3F54A81A23;
	Mon, 27 Feb 2023 08:20:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3F54A81A23
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06882C0033;
	Mon, 27 Feb 2023 08:20:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4258C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 08:20:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A734581A23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 08:20:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A734581A23
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z_SIJGkt8n5F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 08:20:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BC61B81CAF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BC61B81CAF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 08:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677486007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZAeHxyUwJVHN8PzkafY6op1MIGDp3/3HL3aFhUhLx0U=;
 b=bCg7+ByGOh+28wzb7VvSRWX29AwVH6eBEQU9fFhwzckjyUEreD3ayHJtooZLaFizFxCUFa
 1uvCNnCT6x95AvctZOBzuhhYliHCGG/8k43ivhTpe33prviXycJf4O06miOJp/Kcc+uf0s
 mVVfB3Gf66I8qY4jfRm8jmub9GKCFZ0=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-235-kYxQZh2SOWGrNkrJDB7n5A-1; Mon, 27 Feb 2023 03:20:05 -0500
X-MC-Unique: kYxQZh2SOWGrNkrJDB7n5A-1
Received: by mail-oi1-f197.google.com with SMTP id
 bf30-20020a056808191e00b003843744eaecso384147oib.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 00:20:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZAeHxyUwJVHN8PzkafY6op1MIGDp3/3HL3aFhUhLx0U=;
 b=4KEgTeFXnlU33+famVJ/lk1hOyQrDmMuuOpihW3cxNkpx/fTn8ooNHrc8u/dD6xkQl
 x1doHJ8a3BUJ/EVv9fnO0pc4BaxzmbOjCQd8qT91tb2FcZAr7zPeXMrVzKuPnejJbZGN
 75maxHcWfLyDjghGo96cshQzqbmbLK3sq0fcKIUesJCuMysoS7luxRpf+ezBZBbhDNos
 BV6Xt+o36Z+l8NDAa9CIf6V+avdl0V5UqYfn9F4bObV8UICuBcD/jVADhk16Ja8/4BI1
 5kcrGPEWYeCWQy92qAJeITX+abgBH2vP3W2aBegYVP6Y7hfO+ApRYssH8Hc3hh8W4Z6k
 JhPg==
X-Gm-Message-State: AO0yUKWrhONde/f95oq4FYnZDo0W0gEbrYeJ6FDgCa/+2ve1wcTuDaED
 aA+UNYrElPjDJr/a91oPwK//7iunXl315OGtN2x8vY8BWcSldMvKnflnUtkaQ3Sj+2L00AOOR6O
 15M+1IOIt0qJId7jol3i9ZISxq8Kp2zu2X4ii5R8vx2IMvu42I6Z+rdsJtg==
X-Received: by 2002:aca:911:0:b0:36e:f6f5:604c with SMTP id
 17-20020aca0911000000b0036ef6f5604cmr3061884oij.9.1677486005127; 
 Mon, 27 Feb 2023 00:20:05 -0800 (PST)
X-Google-Smtp-Source: AK7set8zn8gc0mU/teU6Qe0ZjKCtm5c8WmdPv8ShuIiXY4PnGfMOzdf4R8ZsXJ7/s7kQy52fVf9MD7I4Gl436K1if0A=
X-Received: by 2002:aca:911:0:b0:36e:f6f5:604c with SMTP id
 17-20020aca0911000000b0036ef6f5604cmr3061875oij.9.1677486004895; Mon, 27 Feb
 2023 00:20:04 -0800 (PST)
MIME-Version: 1.0
References: <20230224155438.112797-1-eperezma@redhat.com>
 <20230224155438.112797-13-eperezma@redhat.com>
 <2367dcff-e8c3-c3ca-378a-e9e67e10710a@redhat.com>
In-Reply-To: <2367dcff-e8c3-c3ca-378a-e9e67e10710a@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 27 Feb 2023 16:19:53 +0800
Message-ID: <CACGkMEs13RdzLfU8nZwHT0YsZ_hXy47or4t9jkHCoJ1EVa3q9w@mail.gmail.com>
Subject: Re: [PATCH v4 12/15] vdpa: block migration if device has unsupported
 features
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 qemu-devel@nongnu.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gautam Dawar <gdawar@xilinx.com>, virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Lei Yang <leiyang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 longpeng2@huawei.com, Shannon Nelson <snelson@pensando.io>,
 Liuxiangdong <liuxiangdong5@huawei.com>
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

T24gTW9uLCBGZWIgMjcsIDIwMjMgYXQgNDoxNeKAr1BNIEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+IHdyb3RlOgo+Cj4KPiDlnKggMjAyMy8yLzI0IDIzOjU0LCBFdWdlbmlvIFDDqXJl
eiDlhpnpgZM6Cj4gPiBBIHZkcGEgbmV0IGRldmljZSBtdXN0IGluaXRpYWxpemUgd2l0aCBTVlEg
aW4gb3JkZXIgdG8gYmUgbWlncmF0YWJsZSBhdAo+ID4gdGhpcyBtb21lbnQsIGFuZCBpbml0aWFs
aXphdGlvbiBjb2RlIHZlcmlmaWVzIHNvbWUgY29uZGl0aW9ucy4gIElmIHRoZQo+ID4gZGV2aWNl
IGlzIG5vdCBpbml0aWFsaXplZCB3aXRoIHRoZSB4LXN2cSBwYXJhbWV0ZXIsIGl0IHdpbGwgbm90
IGV4cG9zZQo+ID4gX0ZfTE9HIHNvIHRoZSB2aG9zdCBzdWJzeXN0ZW0gd2lsbCBibG9jayBWTSBt
aWdyYXRpb24gZnJvbSBpdHMKPiA+IGluaXRpYWxpemF0aW9uLgo+ID4KPiA+IE5leHQgcGF0Y2hl
cyBjaGFuZ2UgdGhpcywgc28gd2UgbmVlZCB0byB2ZXJpZnkgbWlncmF0aW9uIGNvbmRpdGlvbnMK
PiA+IGRpZmZlcmVudGx5Lgo+ID4KPiA+IFFFTVUgb25seSBzdXBwb3J0cyBhIHN1YnNldCBvZiBu
ZXQgZmVhdHVyZXMgaW4gU1ZRLCBhbmQgaXQgY2Fubm90Cj4gPiBtaWdyYXRlIHN0YXRlIHRoYXQg
Y2Fubm90IHRyYWNrIG9yIHJlc3RvcmUgaW4gdGhlIGRlc3RpbmF0aW9uLiAgQWRkIGEKPiA+IG1p
Z3JhdGlvbiBibG9ja2VyIGlmIHRoZSBkZXZpY2Ugb2ZmZXIgYW4gdW5zdXBwb3J0ZWQgZmVhdHVy
ZS4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0
LmNvbT4KPiA+IC0tLQo+ID4gdjM6IGFkZCBtaXJnYXRpb24gYmxvY2tlciBwcm9wZXJseSBzbyB2
aG9zdF9kZXYgY2FuIGhhbmRsZSBpdC4KPiA+IC0tLQo+ID4gICBuZXQvdmhvc3QtdmRwYS5jIHwg
MTIgKysrKysrKystLS0tCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDQg
ZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL25ldC92aG9zdC12ZHBhLmMgYi9uZXQv
dmhvc3QtdmRwYS5jCj4gPiBpbmRleCA0Zjk4M2RmMDAwLi4wOTRkYzFjMmQwIDEwMDY0NAo+ID4g
LS0tIGEvbmV0L3Zob3N0LXZkcGEuYwo+ID4gKysrIGIvbmV0L3Zob3N0LXZkcGEuYwo+ID4gQEAg
LTc5NSw3ICs3OTUsOCBAQCBzdGF0aWMgTmV0Q2xpZW50U3RhdGUgKm5ldF92aG9zdF92ZHBhX2lu
aXQoTmV0Q2xpZW50U3RhdGUgKnBlZXIsCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGludCBudnFzLAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBib29sIGlzX2RhdGFwYXRoLAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBib29sIHN2cSwKPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBzdHJ1Y3Qgdmhvc3RfdmRwYV9pb3ZhX3JhbmdlIGlvdmFfcmFuZ2UpCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZob3N0X3Zk
cGFfaW92YV9yYW5nZSBpb3ZhX3JhbmdlLAo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHVpbnQ2NF90IGZlYXR1cmVzKQo+ID4gICB7Cj4gPiAgICAgICBOZXRDbGll
bnRTdGF0ZSAqbmMgPSBOVUxMOwo+ID4gICAgICAgVmhvc3RWRFBBU3RhdGUgKnM7Cj4gPiBAQCAt
ODE4LDcgKzgxOSwxMCBAQCBzdGF0aWMgTmV0Q2xpZW50U3RhdGUgKm5ldF92aG9zdF92ZHBhX2lu
aXQoTmV0Q2xpZW50U3RhdGUgKnBlZXIsCj4gPiAgICAgICBzLT52aG9zdF92ZHBhLnNoYWRvd192
cXNfZW5hYmxlZCA9IHN2cTsKPiA+ICAgICAgIHMtPnZob3N0X3ZkcGEuaW92YV9yYW5nZSA9IGlv
dmFfcmFuZ2U7Cj4gPiAgICAgICBzLT52aG9zdF92ZHBhLnNoYWRvd19kYXRhID0gc3ZxOwo+ID4g
LSAgICBpZiAoIWlzX2RhdGFwYXRoKSB7Cj4gPiArICAgIGlmIChxdWV1ZV9wYWlyX2luZGV4ID09
IDApIHsKPiA+ICsgICAgICAgIHZob3N0X3ZkcGFfbmV0X3ZhbGlkX3N2cV9mZWF0dXJlcyhmZWF0
dXJlcywKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmcy0+
dmhvc3RfdmRwYS5taWdyYXRpb25fYmxvY2tlcik7Cj4KPgo+IFNpbmNlIHdlIGRvIHZhbGlkYXRp
b24gYXQgaW5pdGlhbGl6YXRpb24sIGlzIHRoaXMgbmVjZXNzYXJ5IHRvIHZhbGlkCj4gb25jZSBh
Z2FpbiBpbiBvdGhlciBwbGFjZXM/CgpPaywgYWZ0ZXIgcmVhZGluZyBwYXRjaCAxMywgSSB0aGlu
ayB0aGUgcXVlc3Rpb24gaXM6CgpUaGUgdmFsaWRhdGlvbiBzZWVtcyB0byBiZSBpbmRlcGVuZGVu
dCB0byBuZXQsIGNhbiB3ZSB2YWxpZCBpdCBvbmNlCmR1cmluZyB2aG9zdF92ZHBhX2luaXQoKT8K
ClRoYW5rcwoKPgo+IFRoYW5rcwo+Cj4KPiA+ICsgICAgfSBlbHNlIGlmICghaXNfZGF0YXBhdGgp
IHsKPiA+ICAgICAgICAgICBzLT5jdnFfY21kX291dF9idWZmZXIgPSBxZW11X21lbWFsaWduKHFl
bXVfcmVhbF9ob3N0X3BhZ2Vfc2l6ZSgpLAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHZob3N0X3ZkcGFfbmV0X2N2cV9jbWRfcGFnZV9sZW4oKSk7Cj4g
PiAgICAgICAgICAgbWVtc2V0KHMtPmN2cV9jbWRfb3V0X2J1ZmZlciwgMCwgdmhvc3RfdmRwYV9u
ZXRfY3ZxX2NtZF9wYWdlX2xlbigpKTsKPiA+IEBAIC05NTYsNyArOTYwLDcgQEAgaW50IG5ldF9p
bml0X3Zob3N0X3ZkcGEoY29uc3QgTmV0ZGV2ICpuZXRkZXYsIGNvbnN0IGNoYXIgKm5hbWUsCj4g
PiAgICAgICBmb3IgKGkgPSAwOyBpIDwgcXVldWVfcGFpcnM7IGkrKykgewo+ID4gICAgICAgICAg
IG5jc1tpXSA9IG5ldF92aG9zdF92ZHBhX2luaXQocGVlciwgVFlQRV9WSE9TVF9WRFBBLCBuYW1l
LAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmRwYV9kZXZpY2Vf
ZmQsIGksIDIsIHRydWUsIG9wdHMtPnhfc3ZxLAo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBpb3ZhX3JhbmdlKTsKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgaW92YV9yYW5nZSwgZmVhdHVyZXMpOwo+ID4gICAgICAgICAgIGlmICghbmNz
W2ldKQo+ID4gICAgICAgICAgICAgICBnb3RvIGVycjsKPiA+ICAgICAgIH0KPiA+IEBAIC05NjQs
NyArOTY4LDcgQEAgaW50IG5ldF9pbml0X3Zob3N0X3ZkcGEoY29uc3QgTmV0ZGV2ICpuZXRkZXYs
IGNvbnN0IGNoYXIgKm5hbWUsCj4gPiAgICAgICBpZiAoaGFzX2N2cSkgewo+ID4gICAgICAgICAg
IG5jID0gbmV0X3Zob3N0X3ZkcGFfaW5pdChwZWVyLCBUWVBFX1ZIT1NUX1ZEUEEsIG5hbWUsCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZkcGFfZGV2aWNlX2ZkLCBpLCAx
LCBmYWxzZSwKPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBvcHRzLT54X3N2
cSwgaW92YV9yYW5nZSk7Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgb3B0
cy0+eF9zdnEsIGlvdmFfcmFuZ2UsIGZlYXR1cmVzKTsKPiA+ICAgICAgICAgICBpZiAoIW5jKQo+
ID4gICAgICAgICAgICAgICBnb3RvIGVycjsKPiA+ICAgICAgIH0KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
