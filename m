Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4B4EB64DD
	for <virtualization@archiver.kernel.org>; Tue, 25 Jul 2023 03:03:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D634A60A95;
	Tue, 25 Jul 2023 03:03:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D634A60A95
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XKFQzaEb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NmiIsVO5J6R8; Tue, 25 Jul 2023 03:03:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0E419606C0;
	Tue, 25 Jul 2023 03:03:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0E419606C0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5588C0072;
	Tue, 25 Jul 2023 03:03:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0C16C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 03:03:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C47FE80B07
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 03:03:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C47FE80B07
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XKFQzaEb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iEdDP3W6oidm
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 03:03:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5D860808A6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 03:03:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5D860808A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690254207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PAc0MlqPg/yL4r1FDNENXbaZwCfWYWLTGb4LIsDUBas=;
 b=XKFQzaEbaLNs3+woVb6rIjwQTKbe2Rd7wa3ldLcDlrUnGAF5FhoZLR724MfOkc0ccSEmB7
 Kx3MYB2FOvveOU+ynWAbQWUOXF5Fa5XuxgBzDTAICmoy/gdGNFPlZIYuidvOlSXTWXleV0
 UrocN1ruE4fRcmxfQKZgAfK/EQFzzj4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-SDs0xy3YPK-kTWpP9U90uw-1; Mon, 24 Jul 2023 23:03:24 -0400
X-MC-Unique: SDs0xy3YPK-kTWpP9U90uw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b6f51e170fso42276231fa.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 20:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690254203; x=1690859003;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PAc0MlqPg/yL4r1FDNENXbaZwCfWYWLTGb4LIsDUBas=;
 b=j7WXxN6tJVjO1pKY+wE05hTzpVSFm4R9bG6VNU5Qj7n0Bu7W6AWBWGTK+dMwIvI+K0
 i8HKZLZUA2u7nQURjJaSo5IYuaW8IF1f8O8S8CDGUhVWDtHlR22LXXdxYfrimQob+aYa
 y9aUi532fgkDusW4Oa9b/VUPy4yMPkOinQRz/LKfY0xoJ2vqdvGirnBt+JmSgo0x44Ca
 84Wn9l7hmbtq9qHDO38ADvCkKlzeNFkOLVLRsip+kDW0nMdZlwXX99jsPchXAUw6wUdt
 ve07AyPAmGza+X0nU1Of9YOMP27r5sSHnJpFE6/ouzNf1+HvubObcjcbrYVvXCk3SUBq
 vQag==
X-Gm-Message-State: ABy/qLZv9DjtK9jgJ0RJpeNs2c+Y1nWb+w3+h/TysCeVYxHNVJCkQsOx
 Tt1Jz6ZQD6KVBS3Qap+QYVS3tfA71X2vb/0bbMd8oX6/MENsmP5V8ypCp+aq35TCcMwP4a4eoEE
 iPNKlARpJUZXXRkXrWVjCLEyp5rc2osZSa/ZLdRu4UdPYsOSX7AzcZvO/zA==
X-Received: by 2002:a2e:a0cc:0:b0:2b9:20fe:4bc4 with SMTP id
 f12-20020a2ea0cc000000b002b920fe4bc4mr6683066ljm.40.1690254203107; 
 Mon, 24 Jul 2023 20:03:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE2j04T9RgeFTKLtV6SB4LuID/VCavX2D/V3hGGpp+Qu72PpJU772k7drhxfEdLsbZ5aZyxH2EWCIDc9aGdJHo=
X-Received: by 2002:a2e:a0cc:0:b0:2b9:20fe:4bc4 with SMTP id
 f12-20020a2ea0cc000000b002b920fe4bc4mr6683061ljm.40.1690254202767; Mon, 24
 Jul 2023 20:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230720083839.481487-3-jasowang@redhat.com>
 <e4eb0162-d303-b17c-a71d-ca3929380b31@amd.com>
 <20230720170001-mutt-send-email-mst@kernel.org>
 <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com>
 <20230721104445-mutt-send-email-mst@kernel.org>
 <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com>
 <20230721110925-mutt-send-email-mst@kernel.org>
 <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
 <20230723053441-mutt-send-email-mst@kernel.org>
 <CACGkMEuPcOyjgHkKXrcnofdb5XhYYTrGQeuR3j6Oypr0KZxLMg@mail.gmail.com>
 <20230724031732-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230724031732-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 25 Jul 2023 11:03:11 +0800
Message-ID: <CACGkMEvNqJvLvVqQyrw-5jLDA2RvWkSPfb_RLVZbe_wsM=AK4g@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, edumazet@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

T24gTW9uLCBKdWwgMjQsIDIwMjMgYXQgMzoxOOKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gTW9uLCBKdWwgMjQsIDIwMjMgYXQgMDI6NTI6NDlQ
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+IE9uIE1vbiwgSnVsIDI0LCAyMDIzIGF0IDI6
NDbigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4K
PiA+ID4gT24gRnJpLCBKdWwgMjEsIDIwMjMgYXQgMTA6MTg6MDNQTSArMDIwMCwgTWF4aW1lIENv
cXVlbGluIHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBPbiA3LzIxLzIzIDE3OjEwLCBN
aWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+ID4gPiBPbiBGcmksIEp1bCAyMSwgMjAyMyBh
dCAwNDo1ODowNFBNICswMjAwLCBNYXhpbWUgQ29xdWVsaW4gd3JvdGU6Cj4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+IE9uIDcvMjEvMjMgMTY6NDUsIE1pY2hhZWwgUy4gVHNpcmtp
biB3cm90ZToKPiA+ID4gPiA+ID4gPiBPbiBGcmksIEp1bCAyMSwgMjAyMyBhdCAwNDozNzowMFBN
ICswMjAwLCBNYXhpbWUgQ29xdWVsaW4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiA+IE9uIDcvMjAvMjMgMjM6MDIsIE1pY2hhZWwgUy4gVHNpcmtp
biB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gT24gVGh1LCBKdWwgMjAsIDIwMjMgYXQgMDE6MjY6
MjBQTSAtMDcwMCwgU2hhbm5vbiBOZWxzb24gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gT24g
Ny8yMC8yMyAxOjM4IEFNLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IEFkZGluZyBjb25kX3Jlc2NoZWQoKSB0byB0aGUgY29tbWFu
ZCB3YWl0aW5nIGxvb3AgZm9yIGEgYmV0dGVyCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBjby1vcGVy
YXRpb24gd2l0aCB0aGUgc2NoZWR1bGVyLiBUaGlzIGFsbG93cyB0byBnaXZlIENQVSBhIGJyZWF0
aCB0bwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gcnVuIG90aGVyIHRhc2sod29ya3F1ZXVlKSBpbnN0
ZWFkIG9mIGJ1c3kgbG9vcGluZyB3aGVuIHByZWVtcHRpb24gaXMKPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IG5vdCBhbGxvd2VkIG9uIGEgZGV2aWNlIHdob3NlIENWUSBtaWdodCBiZSBzbG93Lgo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEph
c29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gPiA+ID4gPiBUaGlzIHN0aWxsIGxlYXZlcyBodW5nIHByb2Nlc3NlcywgYnV0IGF0IGxl
YXN0IGl0IGRvZXNuJ3QgcGluIHRoZSBDUFUgYW55Cj4gPiA+ID4gPiA+ID4gPiA+ID4gbW9yZS4g
IFRoYW5rcy4KPiA+ID4gPiA+ID4gPiA+ID4gPiBSZXZpZXdlZC1ieTogU2hhbm5vbiBOZWxzb24g
PHNoYW5ub24ubmVsc29uQGFtZC5jb20+Cj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gSSdkIGxpa2UgdG8gc2VlIGEgZnVsbCBzb2x1dGlvbgo+
ID4gPiA+ID4gPiA+ID4gPiAxLSBibG9jayB1bnRpbCBpbnRlcnJ1cHQKPiA+ID4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+ID4gPiBXb3VsZCBpdCBtYWtlIHNlbnNlIHRvIGFsc28gaGF2ZSBhIHRpbWVv
dXQ/Cj4gPiA+ID4gPiA+ID4gPiBBbmQgd2hlbiB0aW1lb3V0IGV4cGlyZXMsIHNldCBGQUlMRUQg
Yml0IGluIGRldmljZSBzdGF0dXM/Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiB2aXJ0aW8g
c3BlYyBkb2VzIG5vdCBzZXQgYW55IGxpbWl0cyBvbiB0aGUgdGltaW5nIG9mIHZxCj4gPiA+ID4g
PiA+ID4gcHJvY2Vzc2luZy4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gSW5kZWVkLCBidXQgSSB0
aG91Z2h0IHRoZSBkcml2ZXIgY291bGQgZGVjaWRlIGl0IGlzIHRvbyBsb25nIGZvciBpdC4KPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gVGhlIGlzc3VlIGlzIHdlIGtlZXAgd2FpdGluZyB3aXRoIHJ0
bmwgbG9ja2VkLCBpdCBjYW4gcXVpY2tseSBtYWtlIHRoZQo+ID4gPiA+ID4gPiBzeXN0ZW0gdW51
c2FibGUuCj4gPiA+ID4gPgo+ID4gPiA+ID4gaWYgdGhpcyBpcyBhIHByb2JsZW0gd2Ugc2hvdWxk
IGZpbmQgYSB3YXkgbm90IHRvIGtlZXAgcnRubAo+ID4gPiA+ID4gbG9ja2VkIGluZGVmaW5pdGVs
eS4KPiA+ID4gPgo+ID4gPiA+IEZyb20gdGhlIHRlc3RzIEkgaGF2ZSBkb25lLCBJIHRoaW5rIGl0
IGlzLiBXaXRoIE9WUywgYSByZWNvbmZpZ3VyYXRpb24gaXMKPiA+ID4gPiBwZXJmb3JtZWQgd2hl
biB0aGUgVkRVU0UgZGV2aWNlIGlzIGFkZGVkLCBhbmQgd2hlbiBhIE1MWDUgZGV2aWNlIGlzCj4g
PiA+ID4gaW4gdGhlIHNhbWUgYnJpZGdlLCBpdCBlbmRzIHVwIGRvaW5nIGFuIGlvY3RsKCkgdGhh
dCB0cmllcyB0byB0YWtlIHRoZQo+ID4gPiA+IHJ0bmwgbG9jay4gSW4gdGhpcyBjb25maWd1cmF0
aW9uLCBpdCBpcyBub3QgcG9zc2libGUgdG8ga2lsbCBPVlMgYmVjYXVzZQo+ID4gPiA+IGl0IGlz
IHN0dWNrIHRyeWluZyB0byBhY3F1aXJlIHJ0bmwgbG9jayBmb3IgbWx4NSB0aGF0IGlzIGhlbGQg
YnkgdmlydGlvLQo+ID4gPiA+IG5ldC4KPiA+ID4KPiA+ID4gU28gZm9yIHN1cmUsIHdlIGNhbiBx
dWV1ZSB1cCB0aGUgd29yayBhbmQgcHJvY2VzcyBpdCBsYXRlci4KPiA+ID4gVGhlIHNvbWV3aGF0
IHRyaWNreSBwYXJ0IGlzIGxpbWl0aW5nIHRoZSBtZW1vcnkgY29uc3VtcHRpb24uCj4gPgo+ID4g
QW5kIGl0IG5lZWRzIHRvIHN5bmMgd2l0aCBydG5sIHNvbWVob3csIGUuZyBkZXZpY2UgdW5yZWdp
c3RlcmluZyB3aGljaAo+ID4gc2VlbXMgbm90IGVhc3kuCj4gPgo+ID4gVGhhbmtzCj4KPiBzaW5j
ZSB3aGVuIGRvZXMgZGV2aWNlIHVucmVnaXN0ZXIgbmVlZCB0byBzZW5kIGN2cSBjb21tYW5kcz8K
Ckl0IGRvZXNuJ3QgZG8gdGhpcyBub3cuIEJ1dCBpZiB3ZSBkb24ndCBwcm9jZXNzIHRoZSB3b3Jr
IHVuZGVyIHJ0bmwsCndlIG5lZWQgdG8gc3luY2hyb25pemUgd2l0aCBkZXZpY2UgdW5yZWdpc3Rl
cmluZy4KClRoYW5rcwoKPgo+ID4gPgo+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4g
Mi0gc3RpbGwgaGFuZGxlIHN1cnByaXNlIHJlbW92YWwgY29ycmVjdGx5IGJ5IHdha2luZyBpbiB0
aGF0IGNhc2UKPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAg
ICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCA0ICsrKy0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ICAgICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IGluZGV4IDlmM2IxZDZhYzMzZC4uZTc1MzNmMjliMjE5IDEwMDY0NAo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gPiA+ID4g
PiA+ID4gPiA+IEBAIC0yMzE0LDggKzIzMTQsMTAgQEAgc3RhdGljIGJvb2wgdmlydG5ldF9zZW5k
X2NvbW1hbmQoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksIHU4IGNsYXNzLCB1OCBjbWQsCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgKiBpbnRvIHRoZSBoeXBlcnZpc29yLCBzbyB0
aGUgcmVxdWVzdCBzaG91bGQgYmUgaGFuZGxlZCBpbW1lZGlhdGVseS4KPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ICAgICAgICAgICAgICAqLwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAg
d2hpbGUgKCF2aXJ0cXVldWVfZ2V0X2J1Zih2aS0+Y3ZxLCAmdG1wKSAmJgo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gLSAgICAgICAgICAgICAgIXZpcnRxdWV1ZV9pc19icm9rZW4odmktPmN2cSkpCj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAhdmlydHF1ZXVlX2lzX2Jyb2tlbih2
aS0+Y3ZxKSkgewo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIGNvbmRfcmVz
Y2hlZCgpOwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICBjcHVfcmVs
YXgoKTsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgfQo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgIHJldHVybiB2aS0+Y3RybC0+c3Rh
dHVzID09IFZJUlRJT19ORVRfT0s7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAgIH0KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IC0tCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAyLjM5LjMKPiA+ID4gPiA+
ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24K
PiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4KPgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
