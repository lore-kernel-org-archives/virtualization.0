Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E901FC4332F
	for <virtualization@archiver.kernel.org>; Wed, 28 Dec 2022 11:53:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C3C38126C;
	Wed, 28 Dec 2022 11:53:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6C3C38126C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U+8GTccb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X4MO-M4g-Qls; Wed, 28 Dec 2022 11:53:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DB02C8126B;
	Wed, 28 Dec 2022 11:53:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DB02C8126B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B29AAC0032;
	Wed, 28 Dec 2022 11:53:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2047CC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Dec 2022 11:53:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EF795607C1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Dec 2022 11:53:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EF795607C1
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=U+8GTccb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id glzRNkHrgUeI
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Dec 2022 11:53:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C175160709
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C175160709
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Dec 2022 11:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672228402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3hQKS1NwOrIIXUtr0/6kNG7P651iOA+L6EemF1Qhqo8=;
 b=U+8GTccbjgcYJ1xRAfjUU4EpgbfZcepxxTXJhnygOcQIow2KypTWOy/A0gZFApP+J2mP7Y
 Ld+lRBGyTRfLRMmT9uSpMsGA1JwiGxVbidMy+BgIT9qC3gdfm1lDk336FWLWFWtldlbcrH
 qR+1R1j5l/P6i6qJNlyBE+QQJc59OtU=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-531-5uNuyQ5BOUGt0AtIv6tGhg-1; Wed, 28 Dec 2022 06:53:20 -0500
X-MC-Unique: 5uNuyQ5BOUGt0AtIv6tGhg-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-14fb2bf71e8so5079265fac.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Dec 2022 03:53:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3hQKS1NwOrIIXUtr0/6kNG7P651iOA+L6EemF1Qhqo8=;
 b=lR2AtNIQPCTlLDe04cd6kajSvAQEjnuHDIqypct7aTuH1kA5khZ9Gw1/oFbUXqy++L
 jkMlslN1esCoixwwbWlzqVBR1LHhCHMjAjXazZy3EUdIVFSC49tuGbc4vybc+v3QM/+e
 buSoMNUFGlxaGMbbrk9NcbP+AjdWa9/c1cj7lzIbsBChLhDr1D18F0yb49TqY//06cBA
 4fEIZRY3DaBcvWr0ZA+JMVkmDVu3txWGIEwwqBvaQ6ULnM1JQGBWoxwY8JI5TB1yq5g2
 AT1eJTCn8rMkyH8rbecHZU9SCJ0OXlrtVrJ5orOxtZ9iDtQLkRsr5oVmNqjX4yJ4ONv+
 /Ovg==
X-Gm-Message-State: AFqh2krncyZgDgoaQnzQt6R5eAEJ3rQouUlmbK0+0xsjKjIGy1HdpKz8
 kltncMAn5OQGRcaRU1dHFEh07te2C2fwPjW8oBhuPrKv4Ah3XNmWNOWKNDiiiHC4a8k6rYy218B
 iPrROqogKYpkcmzuDzPPtJsb5c6TDDmeDe1+7aAGWB4wdB53aXjvo0kbkJA==
X-Received: by 2002:a9d:7843:0:b0:678:1eb4:3406 with SMTP id
 c3-20020a9d7843000000b006781eb43406mr1573926otm.237.1672228399900; 
 Wed, 28 Dec 2022 03:53:19 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuiaCrxXL5+xhMG7tUHPCIJ4eF/3FYo5UTrnp+O2D9BcfxMWXCf0aeUTDXkBGQmvAAjX9SfrHhS9db4WpzKM1c=
X-Received: by 2002:a9d:7843:0:b0:678:1eb4:3406 with SMTP id
 c3-20020a9d7843000000b006781eb43406mr1573914otm.237.1672228399502; Wed, 28
 Dec 2022 03:53:19 -0800 (PST)
MIME-Version: 1.0
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-4-jasowang@redhat.com>
 <20221226183705-mutt-send-email-mst@kernel.org>
 <CACGkMEuNZLJRnWw+XNxJ-to1y8L2GrTrJkk0y0Gwb5H2YhDczQ@mail.gmail.com>
 <20221227022255-mutt-send-email-mst@kernel.org>
 <d77bc1ce-b73f-1ba8-f04f-b3bffeb731c3@redhat.com>
 <20221227043148-mutt-send-email-mst@kernel.org>
 <0d9f1b89-9374-747b-3fb0-b4b28ad0ace1@redhat.com>
In-Reply-To: <0d9f1b89-9374-747b-3fb0-b4b28ad0ace1@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 28 Dec 2022 19:53:08 +0800
Message-ID: <CACGkMEv=+D+Es4sfde_X7F0zspVdy4Rs1Wi9qfCudsznsUrOTQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] virtio_ring: introduce a per virtqueue waitqueue
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, maxime.coquelin@redhat.com, kuba@kernel.org,
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

T24gV2VkLCBEZWMgMjgsIDIwMjIgYXQgMjozNCBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPgo+Cj4g5ZyoIDIwMjIvMTIvMjcgMTc6MzgsIE1pY2hhZWwgUy4gVHNp
cmtpbiDlhpnpgZM6Cj4gPiBPbiBUdWUsIERlYyAyNywgMjAyMiBhdCAwNToxMjo1OFBNICswODAw
LCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4+IOWcqCAyMDIyLzEyLzI3IDE1OjMzLCBNaWNoYWVsIFMu
IFRzaXJraW4g5YaZ6YGTOgo+ID4+PiBPbiBUdWUsIERlYyAyNywgMjAyMiBhdCAxMjozMDozNVBN
ICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4+Pj4+IEJ1dCBkZXZpY2UgaXMgc3RpbGwgZ29p
bmcgYW5kIHdpbGwgbGF0ZXIgdXNlIHRoZSBidWZmZXJzLgo+ID4+Pj4+Cj4gPj4+Pj4gU2FtZSBm
b3IgdGltZW91dCByZWFsbHkuCj4gPj4+PiBBdm9pZGluZyBpbmZpbml0ZSB3YWl0L3BvbGwgaXMg
b25lIG9mIHRoZSBnb2FscywgYW5vdGhlciBpcyB0byBzbGVlcC4KPiA+Pj4+IElmIHdlIHRoaW5r
IHRoZSB0aW1lb3V0IGlzIGhhcmQsIHdlIGNhbiBzdGFydCBmcm9tIHRoZSB3YWl0Lgo+ID4+Pj4K
PiA+Pj4+IFRoYW5rcwo+ID4+PiBJZiB0aGUgZ29hbCBpcyB0byBhdm9pZCBkaXNydXB0aW5nIHRy
YWZmaWMgd2hpbGUgQ1ZRIGlzIGluIHVzZSwKPiA+Pj4gdGhhdCBzb3VuZHMgbW9yZSByZWFzb25h
YmxlLiBFLmcuIHNvbWVvbmUgaXMgdHVybmluZyBvbiBwcm9taXNjLAo+ID4+PiBhIHNwaWtlIGlu
IENQVSB1c2FnZSBtaWdodCBiZSB1bndlbGNvbWUuCj4gPj4KPiA+PiBZZXMsIHRoaXMgd291bGQg
YmUgbW9yZSBvYnZpb3VzIGlzIFVQIGlzIHVzZWQuCj4gPj4KPiA+Pgo+ID4+PiB0aGluZ3Mgd2Ug
c2hvdWxkIGJlIGNhcmVmdWwgdG8gYWRkcmVzcyB0aGVuOgo+ID4+PiAxLSBkZWJ1Z2dpbmcuIEN1
cnJlbnRseSBpdCdzIGVhc3kgdG8gc2VlIGEgd2FybmluZyBpZiBDUFUgaXMgc3R1Y2sKPiA+Pj4g
ICAgICBpbiBhIGxvb3AgZm9yIGEgd2hpbGUsIGFuZCB3ZSBhbHNvIGdldCBhIGJhY2t0cmFjZS4K
PiA+Pj4gICAgICBFLmcuIHdpdGggdGhpcyAtIGhvdyBkbyB3ZSBrbm93IHdobyBoYXMgdGhlIFJU
Tkw/Cj4gPj4+ICAgICAgV2UgbmVlZCB0byBpbnRlZ3JhdGUgd2l0aCBrZXJuZWwvd2F0Y2hkb2cu
YyBmb3IgZ29vZCByZXN1bHRzCj4gPj4+ICAgICAgYW5kIHRvIG1ha2Ugc3VyZSBwb2xpY3kgaXMg
Y29uc2lzdGVudC4KPiA+Pgo+ID4+IFRoYXQncyBmaW5lLCB3aWxsIGNvbnNpZGVyIHRoaXMuCgpT
byBhZnRlciBzb21lIGludmVzdGlnYXRpb24sIGl0IHNlZW1zIHRoZSB3YXRjaGRvZy5jIGRvZXNu
J3QgaGVscC4gVGhlCm9ubHkgZXhwb3J0IGhlbHBlciBpcyB0b3VjaF9zb2Z0bG9ja3VwX3dhdGNo
ZG9nKCkgd2hpY2ggdHJpZXMgdG8gYXZvaWQKdHJpZ2dlcmluZyB0aGUgbG9ja3VwcyB3YXJuaW5n
IGZvciB0aGUga25vd24gc2xvdyBwYXRoLgoKQW5kIGJlZm9yZSB0aGUgcGF0Y2gsIHdlIGVuZCB1
cCB3aXRoIGEgcmVhbCBpbmZpbml0ZSBsb29wIHdoaWNoIGNvdWxkCmJlIGNhdWdodCBieSBSQ1Ug
c3RhbGwgZGV0ZWN0b3Igd2hpY2ggaXMgbm90IHRoZSBjYXNlIG9mIHRoZSBzbGVlcC4KV2hhdCB3
ZSBjYW4gZG8gaXMgcHJvYmFibHkgZG8gYSBwZXJpb2RpYyBuZXRkZXZfZXJyKCkuCgpUaGFua3MK
Cj4gPj4KPiA+Pgo+ID4+PiAyLSBvdmVyaGVhZC4gSW4gYSB2ZXJ5IGNvbW1vbiBzY2VuYXJpbyB3
aGVuIGRldmljZSBpcyBpbiBoeXBlcnZpc29yLAo+ID4+PiAgICAgIHByb2dyYW1taW5nIHRpbWVy
cyBldGMgaGFzIGEgdmVyeSBoaWdoIG92ZXJoZWFkLCBhdCBib290dXAKPiA+Pj4gICAgICBsb3Rz
IG9mIENWUSBjb21tYW5kcyBhcmUgcnVuIGFuZCBzbG93aW5nIGJvb3QgZG93biBpcyBub3Qgbmlj
ZS4KPiA+Pj4gICAgICBsZXQncyBwb2xsIGZvciBhIGJpdCBiZWZvcmUgd2FpdGluZz8KPiA+Pgo+
ID4+IFRoZW4gd2UgZ28gYmFjayB0byB0aGUgcXVlc3Rpb24gb2YgY2hvb3NpbmcgYSBnb29kIHRp
bWVvdXQgZm9yIHBvbGwuIEFuZAo+ID4+IHBvbGwgc2VlbXMgcHJvYmxlbWF0aWMgaW4gdGhlIGNh
c2Ugb2YgVVAsIHNjaGVkdWxlciBtaWdodCBub3QgaGF2ZSB0aGUKPiA+PiBjaGFuY2UgdG8gcnVu
Lgo+ID4gUG9sbCBqdXN0IGEgYml0IDopIFNlcmlvdXNseSBJIGRvbid0IGtub3csIGJ1dCBhdCBs
ZWFzdCBjaGVjayBvbmNlCj4gPiBhZnRlciBraWNrLgo+Cj4KPiBJIHRoaW5rIGl0IGlzIHdoYXQg
dGhlIGN1cnJlbnQgY29kZSBkaWQgd2hlcmUgdGhlIGNvbmRpdGlvbiB3aWxsIGJlCj4gY2hlY2sg
YmVmb3JlIHRyeWluZyB0byBzbGVlcCBpbiB0aGUgd2FpdF9ldmVudCgpLgo+Cj4KPiA+Cj4gPj4+
IDMtIHN1cHJpc2UgcmVtb3ZhbC4gbmVlZCB0byB3YWtlIHVwIHRocmVhZCBpbiBzb21lIHdheS4g
d2hhdCBhYm91dAo+ID4+PiAgICAgIG90aGVyIGNhc2VzIG9mIGRldmljZSBicmVha2FnZSAtIGlz
IHRoZXJlIGEgY2hhbmNlIHRoaXMKPiA+Pj4gICAgICBpbnRyb2R1Y2VzIG5ldyBidWdzIGFyb3Vu
ZCB0aGF0PyBhdCBsZWFzdCBlbnVtZXJhdGUgdGhlbSBwbGVhc2UuCj4gPj4KPiA+PiBUaGUgY3Vy
cmVudCBjb2RlIGRpZDoKPiA+Pgo+ID4+IDEpIGNoZWNrIGZvciB2cS0+YnJva2VuCj4gPj4gMikg
d2FrZXVwIGR1cmluZyBCQURfUklORygpCj4gPj4KPiA+PiBTbyB3ZSB3b24ndCBlbmQgdXAgd2l0
aCBhIG5ldmVyIHdva2UgdXAgcHJvY2VzcyB3aGljaCBzaG91bGQgYmUgZmluZS4KPiA+Pgo+ID4+
IFRoYW5rcwo+ID4KPiA+IEJUVyBCQURfUklORyBvbiByZW1vdmFsIHdpbGwgdHJpZ2dlciBkZXZf
ZXJyLiBOb3Qgc3VyZSB0aGF0IGlzIGEgZ29vZAo+ID4gaWRlYSAtIGNhbiBjYXVzZSBjcmFzaGVz
IGlmIGtlcm5lbCBwYW5pY3Mgb24gZXJyb3IuCj4KPgo+IFllcywgaXQncyBiZXR0ZXIgdG8gdXNl
IF9fdmlydHF1ZXVlX2JyZWFrKCkgaW5zdGVhZC4KPgo+IEJ1dCBjb25zaWRlciB3ZSB3aWxsIHN0
YXJ0IGZyb20gYSB3YWl0IGZpcnN0LCBJIHdpbGwgbGltaXQgdGhlIGNoYW5nZXMKPiBpbiB2aXJ0
aW8tbmV0IHdpdGhvdXQgYm90aGVyaW5nIHZpcnRpbyBjb3JlLgo+Cj4gVGhhbmtzCj4KPgo+ID4K
PiA+Pj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
