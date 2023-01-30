Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8632C54EAA
	for <virtualization@archiver.kernel.org>; Mon, 30 Jan 2023 05:43:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1F7734059E;
	Mon, 30 Jan 2023 05:43:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1F7734059E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yfp5g70D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id INQxNE9V0q25; Mon, 30 Jan 2023 05:43:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 311F34048E;
	Mon, 30 Jan 2023 05:43:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 311F34048E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E813BC0033;
	Mon, 30 Jan 2023 05:43:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DBF2BC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 05:43:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A1739818BE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 05:43:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A1739818BE
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yfp5g70D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oAeT8FeGfrrZ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 05:43:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 20E52818A2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 20E52818A2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 05:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675057423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Kuu0GNI+KbyBCEudDzyW7Q6jFDRoiyBH652zdvdW9k=;
 b=Yfp5g70D5OMaetAVdotisj9pfu4YZCYJ2xb0kVoLn4bF9KmyfRZHRW54LRlkEKM5CCz7hj
 nkubUdHmtMiqw9zLbGpnYgNcLvz2ELqE3CbM9qs7lIVdK6cqRdUWBKZeuE8htQwb0Pz3WY
 fl/mUnRKnVmv2nMkuimqaJuJa0mDRQw=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-610-u6zdTBLHPAu78Z_BueyeYA-1; Mon, 30 Jan 2023 00:43:42 -0500
X-MC-Unique: u6zdTBLHPAu78Z_BueyeYA-1
Received: by mail-vs1-f70.google.com with SMTP id
 m63-20020a677142000000b003ce30446ff5so1976695vsc.23
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 21:43:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2Kuu0GNI+KbyBCEudDzyW7Q6jFDRoiyBH652zdvdW9k=;
 b=czQllzUXftHi65lZPWSRGjF69cazs/dqc4Yiby31KKwTYrGoeUl27I0SozqnKmyZyu
 ctvqrZEHf9KtowF71mTgX+DSEXWz0CUQJ8Kv2SscGgQDwAxyRJChz738oNtCCP0s578s
 pHzXNi1RPN5giXYbpqFNtsmgfXoSLXukc0t93B7So3RzhHS+9ngGwkpR8PWL7EgpMBnA
 eyEP2UP16VtAQtwPH45jQqR/iY4QGbtq/lN6X6iRDzZNpXTUIn+2jTtuwKVopCrk5nnj
 MSa5Ed78CCyGCnf6FyuIGyeYUo4kNpoHvMdYD0o2zXJwSh2tq5017SxKlmYdRGm7VFGG
 0obw==
X-Gm-Message-State: AFqh2koshKqwSHXzFbdhuzuuoNTCOPLl4NTc45JIm3RTtrkbH08qen8i
 NFmr5vkVnKfj0FCfsNLQmhtwDJ1q4LBIaDGROEEZu/Lm9cA3dpvTnkGVLRIS6DwY/aYqVRjT/S8
 cLeIjwKzEwOkoKpj2GJypbDKPcSgebvPdDHavbR8fUg==
X-Received: by 2002:a05:6102:50a4:b0:3d0:dc9c:e82e with SMTP id
 bl36-20020a05610250a400b003d0dc9ce82emr30642653vsb.7.1675057420561; 
 Sun, 29 Jan 2023 21:43:40 -0800 (PST)
X-Google-Smtp-Source: AMrXdXujATUMfJc8yKVf9FXdTDbjwCk2aZr0JxpMeuUR+yFC7eaGn7bjMMHIAavl0DoVTfrNkLiTBw==
X-Received: by 2002:a05:6102:50a4:b0:3d0:dc9c:e82e with SMTP id
 bl36-20020a05610250a400b003d0dc9ce82emr30642643vsb.7.1675057420187; 
 Sun, 29 Jan 2023 21:43:40 -0800 (PST)
Received: from redhat.com ([87.249.138.139]) by smtp.gmail.com with ESMTPSA id
 q9-20020a9f3409000000b004c6b53e0fadsm973239uab.25.2023.01.29.21.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jan 2023 21:43:39 -0800 (PST)
Date: Mon, 30 Jan 2023 00:43:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 3/4] virtio_ring: introduce a per virtqueue waitqueue
Message-ID: <20230130003334-mutt-send-email-mst@kernel.org>
References: <0d9f1b89-9374-747b-3fb0-b4b28ad0ace1@redhat.com>
 <CACGkMEv=+D+Es4sfde_X7F0zspVdy4Rs1Wi9qfCudsznsUrOTQ@mail.gmail.com>
 <20221229020553-mutt-send-email-mst@kernel.org>
 <CACGkMEs5s3Muo+4OfjaLK_P76rTdPhjQdTwykRNGOecAWnt+8g@mail.gmail.com>
 <20221229030633-mutt-send-email-mst@kernel.org>
 <CACGkMEukqZX=6yz1yCj+psHp5c+ZGVVuEYTUssfRCTQZgVWS6g@mail.gmail.com>
 <20230127053112-mutt-send-email-mst@kernel.org>
 <CACGkMEsZs=6TaeSUnu_9Rf+38uisi6ViHyM50=2+ut3Wze2S1g@mail.gmail.com>
 <20230129022809-mutt-send-email-mst@kernel.org>
 <CACGkMEuya+_2P8d4hokoyL_LKGdVzyCC1nDwOCdZb0=+2rjKPQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuya+_2P8d4hokoyL_LKGdVzyCC1nDwOCdZb0=+2rjKPQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

T24gTW9uLCBKYW4gMzAsIDIwMjMgYXQgMTA6NTM6NTRBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBTdW4sIEphbiAyOSwgMjAyMyBhdCAzOjMwIFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8
bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFN1biwgSmFuIDI5LCAyMDIzIGF0IDAx
OjQ4OjQ5UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+IE9uIEZyaSwgSmFuIDI3LCAy
MDIzIGF0IDY6MzUgUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6
Cj4gPiA+ID4KPiA+ID4gPiBPbiBGcmksIERlYyAzMCwgMjAyMiBhdCAxMTo0MzowOEFNICswODAw
LCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gT24gVGh1LCBEZWMgMjksIDIwMjIgYXQgNDox
MCBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gT24gVGh1LCBEZWMgMjksIDIwMjIgYXQgMDQ6MDQ6MTNQTSArMDgwMCwg
SmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gPiBPbiBUaHUsIERlYyAyOSwgMjAyMiBhdCAz
OjA3IFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IE9uIFdlZCwgRGVjIDI4LCAyMDIyIGF0IDA3OjUzOjA4
UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+IE9uIFdlZCwgRGVj
IDI4LCAyMDIyIGF0IDI6MzQgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3Jv
dGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
ID4gPiA+IOWcqCAyMDIyLzEyLzI3IDE3OjM4LCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gT24gVHVlLCBEZWMgMjcsIDIwMjIgYXQgMDU6MTI6NThQTSAr
MDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiA+PiDlnKggMjAyMi8x
Mi8yNyAxNTozMywgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPiA+ID4gPiA+ID4gPiA+ID4g
PiA+Pj4gT24gVHVlLCBEZWMgMjcsIDIwMjIgYXQgMTI6MzA6MzVQTSArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pj4+PiBCdXQgZGV2aWNlIGlzIHN0aWxsIGdv
aW5nIGFuZCB3aWxsIGxhdGVyIHVzZSB0aGUgYnVmZmVycy4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+
Pj4+Pgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4+Pj4+IFNhbWUgZm9yIHRpbWVvdXQgcmVhbGx5Lgo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4+Pj4gQXZvaWRpbmcgaW5maW5pdGUgd2FpdC9wb2xsIGlzIG9u
ZSBvZiB0aGUgZ29hbHMsIGFub3RoZXIgaXMgdG8gc2xlZXAuCj4gPiA+ID4gPiA+ID4gPiA+ID4g
Pj4+PiBJZiB3ZSB0aGluayB0aGUgdGltZW91dCBpcyBoYXJkLCB3ZSBjYW4gc3RhcnQgZnJvbSB0
aGUgd2FpdC4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pj4+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPj4+
PiBUaGFua3MKPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pj4gSWYgdGhlIGdvYWwgaXMgdG8gYXZvaWQg
ZGlzcnVwdGluZyB0cmFmZmljIHdoaWxlIENWUSBpcyBpbiB1c2UsCj4gPiA+ID4gPiA+ID4gPiA+
ID4gPj4+IHRoYXQgc291bmRzIG1vcmUgcmVhc29uYWJsZS4gRS5nLiBzb21lb25lIGlzIHR1cm5p
bmcgb24gcHJvbWlzYywKPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pj4gYSBzcGlrZSBpbiBDUFUgdXNh
Z2UgbWlnaHQgYmUgdW53ZWxjb21lLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+
ID4gPiA+ID4gPj4gWWVzLCB0aGlzIHdvdWxkIGJlIG1vcmUgb2J2aW91cyBpcyBVUCBpcyB1c2Vk
Lgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+Pj4gdGhpbmdzIHdlIHNob3VsZCBiZSBjYXJlZnVsIHRvIGFkZHJlc3MgdGhl
bjoKPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pj4gMS0gZGVidWdnaW5nLiBDdXJyZW50bHkgaXQncyBl
YXN5IHRvIHNlZSBhIHdhcm5pbmcgaWYgQ1BVIGlzIHN0dWNrCj4gPiA+ID4gPiA+ID4gPiA+ID4g
Pj4+ICAgICAgaW4gYSBsb29wIGZvciBhIHdoaWxlLCBhbmQgd2UgYWxzbyBnZXQgYSBiYWNrdHJh
Y2UuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPj4+ICAgICAgRS5nLiB3aXRoIHRoaXMgLSBob3cgZG8g
d2Uga25vdyB3aG8gaGFzIHRoZSBSVE5MPwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4+PiAgICAgIFdl
IG5lZWQgdG8gaW50ZWdyYXRlIHdpdGgga2VybmVsL3dhdGNoZG9nLmMgZm9yIGdvb2QgcmVzdWx0
cwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4+PiAgICAgIGFuZCB0byBtYWtlIHN1cmUgcG9saWN5IGlz
IGNvbnNpc3RlbnQuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+
PiBUaGF0J3MgZmluZSwgd2lsbCBjb25zaWRlciB0aGlzLgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+ID4gPiBTbyBhZnRlciBzb21lIGludmVzdGlnYXRpb24sIGl0IHNlZW1zIHRoZSB3
YXRjaGRvZy5jIGRvZXNuJ3QgaGVscC4gVGhlCj4gPiA+ID4gPiA+ID4gPiA+IG9ubHkgZXhwb3J0
IGhlbHBlciBpcyB0b3VjaF9zb2Z0bG9ja3VwX3dhdGNoZG9nKCkgd2hpY2ggdHJpZXMgdG8gYXZv
aWQKPiA+ID4gPiA+ID4gPiA+ID4gdHJpZ2dlcmluZyB0aGUgbG9ja3VwcyB3YXJuaW5nIGZvciB0
aGUga25vd24gc2xvdyBwYXRoLgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IEkgbmV2
ZXIgc2FpZCB5b3UgY2FuIGp1c3QgdXNlIGV4aXN0aW5nIGV4cG9ydGluZyBBUElzLiBZb3UnbGwg
aGF2ZSB0bwo+ID4gPiA+ID4gPiA+ID4gd3JpdGUgbmV3IG9uZXMgOikKPiA+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+IE9rLCBJIHRob3VnaHQgeW91IHdhbnRlZCB0byB0cmlnZ2VyIHNpbWlsYXIg
d2FybmluZ3MgYXMgYSB3YXRjaGRvZy4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IEJ0dywg
SSB3b25kZXIgd2hhdCBraW5kIG9mIGxvZ2ljIHlvdSB3YW50IGhlcmUuIElmIHdlIHN3aXRjaCB0
byB1c2luZwo+ID4gPiA+ID4gPiA+IHNsZWVwLCB0aGVyZSB3b24ndCBiZSBzb2Z0IGxvY2t1cCBh
bnltb3JlLiBBIHNpbXBsZSB3YWl0ICsgdGltZW91dCArCj4gPiA+ID4gPiA+ID4gd2FybmluZyBz
ZWVtcyBzdWZmaWNpZW50Pwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gVGhhbmtzCj4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+IEknZCBsaWtlIHRvIGF2b2lkIG5lZWQgdG8gdGVhY2ggdXNlcnMg
bmV3IEFQSXMuIFNvIHdhdGNoZG9nIHNldHVwIHRvIGFwcGx5Cj4gPiA+ID4gPiA+IHRvIHRoaXMg
ZHJpdmVyLiBUaGUgd2FybmluZyBjYW4gYmUgZGlmZmVyZW50Lgo+ID4gPiA+ID4KPiA+ID4gPiA+
IFJpZ2h0LCBzbyBpdCBsb29rcyB0byBtZSB0aGUgb25seSBwb3NzaWJsZSBzZXR1cCBpcyB0aGUK
PiA+ID4gPiA+IHdhdGNoZG9nX3RocmVzLiBJIHBsYW4gdG8gdHJpZ2dlciB0aGUgd2FybmluZyBl
dmVyeSB3YXRjaGRvZ190aHJlcyAqIDIKPiA+ID4gPiA+IHNlY29uZCAoYXMgc29mdGxvY2t1cCBk
aWQpLgo+ID4gPiA+ID4KPiA+ID4gPiA+IEFuZCBJIHRoaW5rIGl0IHdvdWxkIHN0aWxsIG1ha2Ug
c2Vuc2UgdG8gZmFpbCwgd2UgY2FuIHN0YXJ0IHdpdGggYQo+ID4gPiA+ID4gdmVyeSBsb25nIHRp
bWVvdXQgbGlrZSAxIG1pbnV0ZXMgYW5kIGJyZWFrIHRoZSBkZXZpY2UuIERvZXMgdGhpcyBtYWtl
Cj4gPiA+ID4gPiBzZW5zZT8KPiA+ID4gPiA+Cj4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPgo+ID4g
PiA+IEknZCBzYXkgd2UgbmVlZCB0byBtYWtlIHRoaXMgbWFuYWdlYWJsZSB0aGVuLgo+ID4gPgo+
ID4gPiBEaWQgeW91IG1lYW4gc29tZXRoaW5nIGxpa2Ugc3lzZnMgb3IgbW9kdWxlIHBhcmFtZXRl
cnM/Cj4gPgo+ID4gTm8gSSdkIHNheSBwYXNzIGl0IHdpdGggYW4gaW9jdGwuCj4gPgo+ID4gPiA+
IENhbid0IHdlIGRvIGl0IG5vcm1hbGx5Cj4gPiA+ID4gZS5nLiByZWFjdCB0byBhbiBpbnRlcnJ1
cHQgdG8gcmV0dXJuIHRvIHVzZXJzcGFjZT8KPiA+ID4KPiA+ID4gSSBkaWRuJ3QgZ2V0IHRoZSBt
ZWFuaW5nIG9mIHRoaXMuIFNvcnJ5Lgo+ID4gPgo+ID4gPiBUaGFua3MKPiA+Cj4gPiBTdGFuZGFy
ZCB3YXkgdG8gaGFuZGxlIHRoaW5ncyB0aGF0IGNhbiB0aW1lb3V0IGFuZCB3aGVyZSB1c2Vyc3Bh
Y2UKPiA+IGRpZCBub3Qgc3VwcGx5IHRoZSB0aW1lIGlzIHRvIGJsb2NrIHVudGlsIGFuIGludGVy
cnVwdAo+ID4gdGhlbiByZXR1cm4gRUlOVFIuCj4gCj4gV2VsbCB0aGlzIHNlZW1zIHRvIGJlIGEg
aHVnZSBjaGFuZ2UsIGlvY3RsKDIpIGRvZXNuJ3Qgc2F5IGl0IGNhbgo+IHJldHVybiBFSU5UUiBu
b3cuCgp0aGUgb25lIG9uIGZlZG9yYSAzNyBkb2VzIG5vdCBidXQgaXQgc2F5czoKICAgICAgIE5v
IHNpbmdsZSBzdGFuZGFyZC4gIEFyZ3VtZW50cywgcmV0dXJucywgYW5kIHNlbWFudGljcyBvZiBp
b2N0bCgpIHZhcnkgYWNjb3JkaW5nIHRvIHRoZSBkZXZpY2UgZHJpdmVyIGluIHF1ZXN0aW9uICh0
aGUgY2FsbCAgaXMKICAgICAgIHVzZWQgYXMgYSBjYXRjaC1hbGwgZm9yIG9wZXJhdGlvbnMgdGhh
dCBkb24ndCBjbGVhbmx5IGZpdCB0aGUgVU5JWCBzdHJlYW0gSS9PIG1vZGVsKS4KCnNvIGl0IGRl
cGVuZHMgb24gdGhlIGRldmljZSBlLmcuIGZvciBhIHN0cmVhbXMgZGV2aWNlIGl0IGRvZXM6Cmh0
dHBzOi8vcHVicy5vcGVuZ3JvdXAub3JnL29ubGluZXB1YnMvOTY5OTkxOTc5OS9mdW5jdGlvbnMv
aW9jdGwuaHRtbApoYXMgRUlOVFIuCgoKCj4gQWN0dWFsbHksIGEgZHJpdmVyIHRpbWVvdXQgaXMg
dXNlZCBieSBvdGhlciBkcml2ZXJzIHdoZW4gdXNpbmcKPiBjb250cm9scS9hZG1pbnEgKGUuZyBp
NDBlKS4gU3RhcnRpbmcgZnJvbSBhIHNhbmUgdmFsdWUgKGUuZyAxIG1pbnV0ZXMKPiB0byBhdm9p
ZCBmYWxzZSBuZWdhdGl2ZXMpIHNlZW1zIHRvIGJlIGEgZ29vZCBmaXJzdCBzdGVwLgoKV2VsbCBi
ZWNhdXNlIGl0J3Mgc3BlY2lmaWMgaGFyZHdhcmUgc28gdGltZW91dCBtYXRjaGVzIHdoYXQgaXQg
Y2FuCnByb21pc2UuICB2aXJ0aW8gc3BlYyBkb2VzIG5vdCBnaXZlIGd1YXJhbnRlZXMuICBPbmUg
aXNzdWUgaXMgd2l0aApzb2Z0d2FyZSBpbXBsZW1lbnRhdGlvbnMuIEF0IHRoZSBtb21lbnQgSSBj
YW4gc2V0IGEgYnJlYWtwb2ludCBpbiBxZW11Cm9yIHZob3N0IHVzZXIgYmFja2VuZCBhbmQgbm90
aGluZyBiYWQgaGFwcGVucyBpbiBqdXN0IGNvbnRpbnVlcy4KCgo+ID4gVXNlcnNwYWNlIGNvbnRy
b2xzIHRoZSB0aW1lb3V0IGJ5Cj4gPiB1c2luZyBlLmcuIGFsYXJtKDIpLgo+IAo+IE5vdCB1c2Vk
IGluIGlwcm91dGUyIGFmdGVyIGEgZ2l0IGdyZXAuCj4gCj4gVGhhbmtzCgpObyBuZWVkIGZvciBp
cHJvdXRlMiB0byBkbyBpdCB1c2VyIGNhbiBqdXN0IGRvIGl0IGZyb20gc2hlbGwuIE9yIHVzZXIg
Y2FuIGp1c3QgcHJlc3MgQ1RSTC1DLgoKPiA+Cj4gPgo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPgo+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4g
QW5kIGJlZm9yZSB0aGUgcGF0Y2gsIHdlIGVuZCB1cCB3aXRoIGEgcmVhbCBpbmZpbml0ZSBsb29w
IHdoaWNoIGNvdWxkCj4gPiA+ID4gPiA+ID4gPiA+IGJlIGNhdWdodCBieSBSQ1Ugc3RhbGwgZGV0
ZWN0b3Igd2hpY2ggaXMgbm90IHRoZSBjYXNlIG9mIHRoZSBzbGVlcC4KPiA+ID4gPiA+ID4gPiA+
ID4gV2hhdCB3ZSBjYW4gZG8gaXMgcHJvYmFibHkgZG8gYSBwZXJpb2RpYyBuZXRkZXZfZXJyKCku
Cj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gPiA+IE9ubHkgd2l0aCBhIGJhZCBkZXZpY2UuCj4gPiA+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+Pj4gMi0gb3ZlcmhlYWQuIEluIGEgdmVyeSBjb21tb24gc2NlbmFyaW8gd2hl
biBkZXZpY2UgaXMgaW4gaHlwZXJ2aXNvciwKPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pj4gICAgICBw
cm9ncmFtbWluZyB0aW1lcnMgZXRjIGhhcyBhIHZlcnkgaGlnaCBvdmVyaGVhZCwgYXQgYm9vdHVw
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPj4+ICAgICAgbG90cyBvZiBDVlEgY29tbWFuZHMgYXJlIHJ1
biBhbmQgc2xvd2luZyBib290IGRvd24gaXMgbm90IG5pY2UuCj4gPiA+ID4gPiA+ID4gPiA+ID4g
Pj4+ICAgICAgbGV0J3MgcG9sbCBmb3IgYSBiaXQgYmVmb3JlIHdhaXRpbmc/Cj4gPiA+ID4gPiA+
ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+PiBUaGVuIHdlIGdvIGJhY2sgdG8gdGhl
IHF1ZXN0aW9uIG9mIGNob29zaW5nIGEgZ29vZCB0aW1lb3V0IGZvciBwb2xsLiBBbmQKPiA+ID4g
PiA+ID4gPiA+ID4gPiA+PiBwb2xsIHNlZW1zIHByb2JsZW1hdGljIGluIHRoZSBjYXNlIG9mIFVQ
LCBzY2hlZHVsZXIgbWlnaHQgbm90IGhhdmUgdGhlCj4gPiA+ID4gPiA+ID4gPiA+ID4gPj4gY2hh
bmNlIHRvIHJ1bi4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFBvbGwganVzdCBhIGJpdCA6KSBTZXJp
b3VzbHkgSSBkb24ndCBrbm93LCBidXQgYXQgbGVhc3QgY2hlY2sgb25jZQo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gYWZ0ZXIga2ljay4KPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gSSB0aGluayBpdCBpcyB3aGF0IHRoZSBjdXJyZW50IGNv
ZGUgZGlkIHdoZXJlIHRoZSBjb25kaXRpb24gd2lsbCBiZQo+ID4gPiA+ID4gPiA+ID4gPiA+IGNo
ZWNrIGJlZm9yZSB0cnlpbmcgdG8gc2xlZXAgaW4gdGhlIHdhaXRfZXZlbnQoKS4KPiA+ID4gPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4+PiAzLSBzdXByaXNlIHJlbW92YWwuIG5lZWQgdG8gd2FrZSB1cCB0
aHJlYWQgaW4gc29tZSB3YXkuIHdoYXQgYWJvdXQKPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pj4gICAg
ICBvdGhlciBjYXNlcyBvZiBkZXZpY2UgYnJlYWthZ2UgLSBpcyB0aGVyZSBhIGNoYW5jZSB0aGlz
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPj4+ICAgICAgaW50cm9kdWNlcyBuZXcgYnVncyBhcm91bmQg
dGhhdD8gYXQgbGVhc3QgZW51bWVyYXRlIHRoZW0gcGxlYXNlLgo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPj4gVGhlIGN1cnJlbnQgY29kZSBkaWQ6Cj4gPiA+ID4g
PiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+PiAxKSBjaGVjayBmb3IgdnEtPmJy
b2tlbgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4+IDIpIHdha2V1cCBkdXJpbmcgQkFEX1JJTkcoKQo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPj4gU28gd2Ugd29uJ3Qg
ZW5kIHVwIHdpdGggYSBuZXZlciB3b2tlIHVwIHByb2Nlc3Mgd2hpY2ggc2hvdWxkIGJlIGZpbmUu
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+PiBUaGFua3MKPiA+
ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBCVFcgQkFEX1JJTkcgb24g
cmVtb3ZhbCB3aWxsIHRyaWdnZXIgZGV2X2Vyci4gTm90IHN1cmUgdGhhdCBpcyBhIGdvb2QKPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IGlkZWEgLSBjYW4gY2F1c2UgY3Jhc2hlcyBpZiBrZXJuZWwgcGFu
aWNzIG9uIGVycm9yLgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiA+ID4gPiBZZXMsIGl0J3MgYmV0dGVyIHRvIHVzZSBfX3ZpcnRxdWV1ZV9icmVh
aygpIGluc3RlYWQuCj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiBCdXQg
Y29uc2lkZXIgd2Ugd2lsbCBzdGFydCBmcm9tIGEgd2FpdCBmaXJzdCwgSSB3aWxsIGxpbWl0IHRo
ZSBjaGFuZ2VzCj4gPiA+ID4gPiA+ID4gPiA+ID4gaW4gdmlydGlvLW5ldCB3aXRob3V0IGJvdGhl
cmluZyB2aXJ0aW8gY29yZS4KPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+
IFRoYW5rcwo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPj4+Cj4gPiA+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPgo+ID4gPiA+Cj4gPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
