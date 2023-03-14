Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B15BC6FD1C
	for <virtualization@archiver.kernel.org>; Tue, 14 Mar 2023 07:34:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AAED881584;
	Tue, 14 Mar 2023 07:34:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AAED881584
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MlQap5W/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 56cdIYtvVYVV; Tue, 14 Mar 2023 07:34:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 103188143D;
	Tue, 14 Mar 2023 07:34:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 103188143D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCB8FC0035;
	Tue, 14 Mar 2023 07:34:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B2D5C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 07:34:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6E5A661007
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 07:34:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6E5A661007
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MlQap5W/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nrGAkcgP4nMC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 07:34:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 71FA060BD0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 71FA060BD0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 07:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678779274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oeXjQuD2bZdMh3b5lmFe0DNjQg6COdiRzr8gMts1AD4=;
 b=MlQap5W/ySpxqapLgs3zwxGjY9faG+9QW6hHDpfzq0bOuEAtVyWLXUJx+9t31sCzpqCBiC
 2UJVZwSvKq5UwMhth+HaV+kHKQzp1ffCIw17mNHMmPDWUp8tCj6oDa3iwmPTjHDw2WUjyk
 JsJZ/9YbZw4GduA+1eO5F4u+4teMS1k=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-QQBglh2zOmGMp6XQSsHhxg-1; Tue, 14 Mar 2023 03:34:30 -0400
X-MC-Unique: QQBglh2zOmGMp6XQSsHhxg-1
Received: by mail-oi1-f198.google.com with SMTP id
 s10-20020a056808208a00b0038445b695f9so6579600oiw.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 00:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678779270;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oeXjQuD2bZdMh3b5lmFe0DNjQg6COdiRzr8gMts1AD4=;
 b=qGUbRlweBhfeFMnxJ0lL9JADmCC/p/G8eCRRAqEiclk1VH96bR0p2ac2g8G5yojMwz
 3qO6pH20rg/wrd9YpqL+pFdsFTmLd1h9/5azWNvysN3tPJYApFNPmT2ZWl17HpvntQud
 Q2R2bh0iSbFx4SX4nCT2LDrZ5yQq6fVtnuxTr55TDSAUEiR2OyUwWriaTDHi09KIm7AR
 kiMwnE1K7zriyyYt8PT5zcJS5TYinkHdecFZKI/4saEGsiH4c6HMOcxKF7g6i+L2pI2W
 wtPLI0QbQ5WKuo2ehOqBtWxiPt7oVmI3jT871aaDCPoo+cIYbBJ3cw2fEbboQl9hQZio
 sZJw==
X-Gm-Message-State: AO0yUKWEYCO6xKG7W33aplBbvwcd/2h8JEv5LdrD10UW4/jDSAIcrkGH
 cNZMDvYmdgNV1wi8n/3ITk60fGV3Y07aXoNxdlkNoT40vWYvFw+Rzwi6+XK0DW+9IBp85amMd7h
 FfHuJPwNisbYs/shBe06dAJDgVF8uo2ukYCzEXyQEdYUmuiCJNN1ZqDMe/A==
X-Received: by 2002:a4a:d384:0:b0:525:65a1:acd9 with SMTP id
 i4-20020a4ad384000000b0052565a1acd9mr4616147oos.0.1678779269983; 
 Tue, 14 Mar 2023 00:34:29 -0700 (PDT)
X-Google-Smtp-Source: AK7set+QTJXK9zkB1oMK13MeHqT2rPmloBqAnXa7LsHLMK4HaUY+osZZusznN3I5QRDsD8ZT+/AsqEN3/MDlaoXzQFQ=
X-Received: by 2002:a4a:d384:0:b0:525:65a1:acd9 with SMTP id
 i4-20020a4ad384000000b0052565a1acd9mr4616141oos.0.1678779269702; Tue, 14 Mar
 2023 00:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230308064443.50639-1-xuanzhuo@linux.alibaba.com>
 <20230308064443.50639-5-xuanzhuo@linux.alibaba.com>
 <CACGkMEunz23S83ROPrXq5sYbMCq+j5BaqYPdTaYMH5atWZ4TpA@mail.gmail.com>
In-Reply-To: <CACGkMEunz23S83ROPrXq5sYbMCq+j5BaqYPdTaYMH5atWZ4TpA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Mar 2023 15:34:18 +0800
Message-ID: <CACGkMEv3sPTgqtCOSJfyQcGN=WoFEaFrO2fsFxPzrrdYeBuKrg@mail.gmail.com>
Subject: Re: [PATCH vhost v2 04/12] virtio_ring: split: support premapped
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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

T24gVHVlLCBNYXIgMTQsIDIwMjMgYXQgMzozMuKAr1BNIEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gV2VkLCBNYXIgOCwgMjAyMyBhdCAyOjQ04oCvUE0gWHVh
biBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPgo+ID4gdmlydGlv
IGNvcmUgb25seSBzdXBwb3J0cyB2aXJ0dWFsIGFkZHJlc3NlcywgZG1hIGlzIGNvbXBsZXRlZCBp
biB2aXJ0aW8KPiA+IGNvcmUuCj4gPgo+ID4gSW4gc29tZSBzY2VuYXJpb3MgKHN1Y2ggYXMgdGhl
IEFGX1hEUCksIHRoZSBtZW1vcnkgaXMgYWxsb2NhdGVkCj4gPiBhbmQgRE1BIGlzIGNvbXBsZXRl
ZCBpbiBhZHZhbmNlLCBzbyBpdCBpcyBuZWNlc3NhcnkgZm9yIHVzIHRvIHN1cHBvcnQKPgo+IFNo
b3VsZCBiZSAiRE1BIG1hcHBpbmcgaXMgY29tcGxldGVkIi4KPgo+ID4gcGFzc2luZyB0aGUgRE1B
IGFkZHJlc3MgdG8gdmlydGlvIGNvcmUuCj4gPgo+ID4gRHJpdmVzIGNhbiB1c2Ugc2ctPmRtYV9h
ZGRyZXNzIHRvIHBhc3MgdGhlIG1hcHBlZCBkbWEgYWRkcmVzcyB0byB2aXJ0aW8KPiA+IGNvcmUu
IElmIG9uZSBzZy0+ZG1hX2FkZHJlc3MgaXMgdXNlZCB0aGVuIGFsbCBzZ3MgbXVzdCB1c2Ugc2ct
Pgo+ID4gZG1hX2FkZHJlc3MsIG90aGVyd2lzZSBhbGwgZG1hX2FkZHJlc3MgbXVzdCBiZSBudWxs
Lgo+Cj4gIm11c3QgYmUgbnVsbCB3aGVuIHBhc3NpbmcgaXQgdG8gdmlydHF1ZXVlX2FkZF9zZ3Mo
KSI/Cj4KPiA+Cj4gPiBPbiB0aGUgbm9uLWluZGlyZWN0IHBhdGgsCj4KPiBTaG91bGQgaXQgYmUg
ImRpcmVjdCBkZXNjIHBhdGgiPwo+Cj4gPiBpZiBkbWFfYWRkcmVzcyBpcyB1c2VkLCBleHRyYS5h
ZGRyIHdpbGwgYmUKPiA+IHNldCB0byBETUFfTUFQUElOR19FUlJPUi4gU28gd2hlbiBkbyB1bm1h
cCwgd2UgY2FuIHBhc3MgaXQuCj4KPiBJIGRvbid0IGdldCB0aGUgbWVhbmluZyBvZiAicGFzcyIg
aGVyZS4gT3IgZG8geW91IG1lYW4KPiBETUFfTUFQSU5HX0VSUk9SIGlzIGEgaGludCB0aGF0IHRo
ZSBkZXNjIGlzIG1hcHBlZCBieSB0aGUgdXBwZXIgbGF5ZXIKPiBpbnN0ZWFkIG9mIHRoZSB2aXJ0
aW8gY29yZT8KPgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5j
IHwgMjIgKysrKysrKysrKysrKystLS0tLS0tLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNl
cnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gaW5k
ZXggMjIxZmY1NGZlNThiLi42MWRlYWYwYTRmYWYgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcmluZy5jCj4gPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5j
Cj4gPiBAQCAtNDU3LDYgKzQ1Nyw5IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgdnJpbmdfdW5tYXBf
b25lX3NwbGl0KGNvbnN0IHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLAo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgKGZsYWdzICYgVlJJTkdfREVTQ19GX1dSSVRFKSA/Cj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBETUFfRlJPTV9ERVZJQ0UgOiBETUFf
VE9fREVWSUNFKTsKPiA+ICAgICAgICAgfSBlbHNlIHsKPiA+ICsgICAgICAgICAgICAgICBpZiAo
ZXh0cmFbaV0uYWRkciA9PSBETUFfTUFQUElOR19FUlJPUikKPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIGdvdG8gb3V0Owo+ID4gKwo+ID4gICAgICAgICAgICAgICAgIGRtYV91bm1hcF9wYWdl
KHZyaW5nX2RtYV9kZXYodnEpLAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGV4
dHJhW2ldLmFkZHIsCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXh0cmFbaV0u
bGVuLAo+ID4gQEAgLTQ5Nyw3ICs1MDAsOCBAQCBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGludCB2
aXJ0cXVldWVfYWRkX2Rlc2Nfc3BsaXQoc3RydWN0IHZpcnRxdWV1ZSAqdnEsCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZG1hX2FkZHJfdCBh
ZGRyLAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHVuc2lnbmVkIGludCBsZW4sCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdTE2IGZsYWdzLAo+ID4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgaW5kaXJlY3QpCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBpbmRpcmVj
dCwKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBib29sIGRvX21hcCkKPiA+ICB7Cj4gPiAgICAgICAgIHN0cnVjdCB2cmluZ192aXJ0cXVldWUg
KnZyaW5nID0gdG9fdnZxKHZxKTsKPiA+ICAgICAgICAgc3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEg
KmV4dHJhID0gdnJpbmctPnNwbGl0LmRlc2NfZXh0cmE7Cj4gPiBAQCAtNTExLDcgKzUxNSw3IEBA
IHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IHZpcnRxdWV1ZV9hZGRfZGVzY19zcGxpdChzdHJ1
Y3QgdmlydHF1ZXVlICp2cSwKPiA+ICAgICAgICAgICAgICAgICBuZXh0ID0gZXh0cmFbaV0ubmV4
dDsKPiA+ICAgICAgICAgICAgICAgICBkZXNjW2ldLm5leHQgPSBjcHVfdG9fdmlydGlvMTYodnEt
PnZkZXYsIG5leHQpOwo+ID4KPiA+IC0gICAgICAgICAgICAgICBleHRyYVtpXS5hZGRyID0gYWRk
cjsKPiA+ICsgICAgICAgICAgICAgICBleHRyYVtpXS5hZGRyID0gZG9fbWFwID8gYWRkciA6IERN
QV9NQVBQSU5HX0VSUk9SOwo+Cj4gQW55IHJlYXNvbiB3ZSBkb24ndCBuZWVkIHRvIGRvIHRoZSBz
YW1lIGZvciBpbmRpcmVjdCBkZXNjcmlwdG9ycz8KCk9rLCBpdCdzIGJldHRlciB0byBtZW50aW9u
IGluIHRoZSBjaGFuZ2Vsb2cgdGhhdCB0aGUgZm9sbG93aW5nIHBhdGNoZXMKd2lsbCBkZWFsIHdp
dGggdGhpcy4KCkJ1dCBpbiBvcmRlciB0byBlYXNlIHRoZSByZXZpZXdlciwgSSBzdWdnZXN0IHRv
IHNxdWFzaCB0aGUgaW5kaXJlY3QKc3VwcG9ydCBpbnRvIHRoaXMgb25lLgoKVGhhbmtzCgo+Cj4g
VGhhbmtzCj4KPiA+ICAgICAgICAgICAgICAgICBleHRyYVtpXS5sZW4gPSBsZW47Cj4gPiAgICAg
ICAgICAgICAgICAgZXh0cmFbaV0uZmxhZ3MgPSBmbGFnczsKPiA+ICAgICAgICAgfSBlbHNlCj4g
PiBAQCAtNjA0LDcgKzYwOCw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IHZpcnRxdWV1ZV9hZGRfc3Bs
aXQoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxLAo+ID4gICAgICAgICBzdHJ1Y3Qgc2NhdHRlcmxpc3Qg
KnNnOwo+ID4gICAgICAgICBzdHJ1Y3QgdnJpbmdfZGVzYyAqZGVzYzsKPiA+ICAgICAgICAgdW5z
aWduZWQgaW50IGksIG4sIGF2YWlsLCBkZXNjc191c2VkLCBwcmV2Owo+ID4gLSAgICAgICBib29s
IGluZGlyZWN0Owo+ID4gKyAgICAgICBib29sIGluZGlyZWN0LCBkb19tYXA7Cj4gPiAgICAgICAg
IGludCBoZWFkOwo+ID4KPiA+ICAgICAgICAgU1RBUlRfVVNFKHZxKTsKPiA+IEBAIC02NTcsNyAr
NjYxLDggQEAgc3RhdGljIGlubGluZSBpbnQgdmlydHF1ZXVlX2FkZF9zcGxpdChzdHJ1Y3Qgdmly
dHF1ZXVlICpfdnEsCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9TUEM7Cj4gPiAgICAg
ICAgIH0KPiA+Cj4gPiAtICAgICAgIGlmICh2aXJ0cXVldWVfbWFwX3Nncyh2cSwgc2dzLCB0b3Rh
bF9zZywgb3V0X3NncywgaW5fc2dzKSkKPiA+ICsgICAgICAgZG9fbWFwID0gIXNnc1swXS0+ZG1h
X2FkZHJlc3M7Cj4gPiArICAgICAgIGlmIChkb19tYXAgJiYgdmlydHF1ZXVlX21hcF9zZ3ModnEs
IHNncywgdG90YWxfc2csIG91dF9zZ3MsIGluX3NncykpCj4gPiAgICAgICAgICAgICAgICAgcmV0
dXJuIC1FTk9NRU07Cj4gPgo+ID4gICAgICAgICBmb3IgKG4gPSAwOyBuIDwgb3V0X3Nnczsgbisr
KSB7Cj4gPiBAQCAtNjcwLDcgKzY3NSw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IHZpcnRxdWV1ZV9h
ZGRfc3BsaXQoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxLAo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzZy0+ZG1hX2FkZHJlc3MsCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNnLT5sZW5n
dGgsCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFZSSU5HX0RFU0NfRl9ORVhULAo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBpbmRpcmVjdCk7Cj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGluZGlyZWN0LCBkb19tYXApOwo+ID4g
ICAgICAgICAgICAgICAgIH0KPiA+ICAgICAgICAgfQo+ID4gICAgICAgICBmb3IgKDsgbiA8IChv
dXRfc2dzICsgaW5fc2dzKTsgbisrKSB7Cj4gPiBAQCAtNjg0LDcgKzY4OSw3IEBAIHN0YXRpYyBp
bmxpbmUgaW50IHZpcnRxdWV1ZV9hZGRfc3BsaXQoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxLAo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzZy0+
bGVuZ3RoLAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBWUklOR19ERVNDX0ZfTkVYVCB8Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZSSU5HX0RFU0NfRl9XUklURSwKPiA+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW5kaXJlY3Qp
Owo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBpbmRpcmVjdCwgZG9fbWFwKTsKPiA+ICAgICAgICAgICAgICAgICB9Cj4gPiAgICAgICAgIH0K
PiA+ICAgICAgICAgLyogTGFzdCBvbmUgZG9lc24ndCBjb250aW51ZS4gKi8KPiA+IEBAIC03MDUs
NyArNzEwLDcgQEAgc3RhdGljIGlubGluZSBpbnQgdmlydHF1ZXVlX2FkZF9zcGxpdChzdHJ1Y3Qg
dmlydHF1ZXVlICpfdnEsCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGhlYWQsIGFkZHIsCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHRvdGFsX3NnICogc2l6ZW9mKHN0cnVjdCB2cmluZ19kZXNjKSwKPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVlJJTkdfREVTQ19GX0lORElSRUNULAo+ID4g
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmYWxzZSk7Cj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZhbHNlLCB0cnVlKTsKPiA+ICAg
ICAgICAgfQo+ID4KPiA+ICAgICAgICAgLyogV2UncmUgdXNpbmcgc29tZSBidWZmZXJzIGZyb20g
dGhlIGZyZWUgbGlzdC4gKi8KPiA+IEBAIC03NDgsNyArNzUzLDggQEAgc3RhdGljIGlubGluZSBp
bnQgdmlydHF1ZXVlX2FkZF9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gPiAgICAgICAg
IHJldHVybiAwOwo+ID4KPiA+ICB1bm1hcF9yZWxlYXNlOgo+ID4gLSAgICAgICB2aXJ0cXVldWVf
dW5tYXBfc2dzKHZxLCBzZ3MsIHRvdGFsX3NnLCBvdXRfc2dzLCBpbl9zZ3MpOwo+ID4gKyAgICAg
ICBpZiAoZG9fbWFwKQo+ID4gKyAgICAgICAgICAgICAgIHZpcnRxdWV1ZV91bm1hcF9zZ3ModnEs
IHNncywgdG90YWxfc2csIG91dF9zZ3MsIGluX3Nncyk7Cj4gPgo+ID4gICAgICAgICBpZiAoaW5k
aXJlY3QpCj4gPiAgICAgICAgICAgICAgICAga2ZyZWUoZGVzYyk7Cj4gPiAtLQo+ID4gMi4zMi4w
LjMuZzAxMTk1Y2Y5Zgo+ID4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
