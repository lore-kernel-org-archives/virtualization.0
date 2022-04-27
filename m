Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CE9C433FE
	for <virtualization@archiver.kernel.org>; Wed, 27 Apr 2022 07:58:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1232B402BC;
	Wed, 27 Apr 2022 07:58:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UfUy0Gcx7b8Q; Wed, 27 Apr 2022 07:58:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3BD4540192;
	Wed, 27 Apr 2022 07:58:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0F5DC0039;
	Wed, 27 Apr 2022 07:58:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3F7AC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 07:58:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A2B4D60C34
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 07:58:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hLUB0PNuDlgC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 07:58:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 61EB760B4B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 07:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651046299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pk9gD8PZ85VjavB1ddaChX0OVjboNSKEVKwwirKTwi0=;
 b=VzWwfFc05hIry1NnsiVdb9Ne30zZJwFnqW+WzpJsKd/HObYed8pxW3DyxdBqzdSF7apC/o
 JVKZwXw0dvWsthHrRJtw6B0Q8HhCe5HyQPqbtthsNAm78flGlGaj/FvFuWClp0x2r1o0zy
 AI7rqc67uffSshpuvY4380vUVeegKpM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-A2DMSaeVNISD3AyvD3VwnQ-1; Wed, 27 Apr 2022 03:58:10 -0400
X-MC-Unique: A2DMSaeVNISD3AyvD3VwnQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 br31-20020a056512401f00b00471c57013ceso436970lfb.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 00:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pk9gD8PZ85VjavB1ddaChX0OVjboNSKEVKwwirKTwi0=;
 b=BknN8HKXH8l7SLokJnPNx4odiun2qr/ZnlMCm0/n9vIN4OFUh+JT6yV/F9cNJZKaJJ
 zmmZ9j158EB9HiaMhybAUkZ907T0j3GyhZ6I9Yl833Dx+ba54p5crAbD5QfT2pQxd9qf
 NkFJXp1xBhXMximOG17AwyWjfesO+jwxE7Ft+W3MA4cbAcQvuJGMnxVoUmBLMrMXR2sL
 YtHe1W5n6HoQ/oSTPaesq9AeTFmjY6ez3UHjaIk17sRmhGi+1sTk7f2HJrlwO9+PyO/Z
 SRTA6SfBWw0Lu/oKuEl40tEdCc+a4ouNnch3wEqlTF+6whPG6jhRK5tucmby3kaHXGhF
 yWbg==
X-Gm-Message-State: AOAM5332DCZjcvUvIoS+Pdk7VFGpLxRpzgLi8791YA5TMUsm1NLWzTRi
 pYCKNYqoxclcYWUlIVJ1sN9PTIYDVDScFLzAffScXqlPQJHnodW5vBLzNVyalZUgbGf0NQA/uns
 RAQRkD4ADGRR0FpUzViYlbvQUrmttz6L8W1TPKbZL8kUY6jCp+H/AbGFDWw==
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id
 b1-20020a0565120b8100b00448b342513cmr19379445lfv.257.1651046288811; 
 Wed, 27 Apr 2022 00:58:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1d9rI5MFqiDCBdBB2YPxrGZfeR11FcSpb6qkKUtLOApLnox6HDwvgiJyKtlnFTFL9fFMYko/DJtz/W9NvU6A=
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id
 b1-20020a0565120b8100b00448b342513cmr19379423lfv.257.1651046288552; Wed, 27
 Apr 2022 00:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220425095742-mutt-send-email-mst@kernel.org>
 <20220426042911.544477f9.pasic@linux.ibm.com>
 <20220425233434-mutt-send-email-mst@kernel.org>
 <20220425233604-mutt-send-email-mst@kernel.org>
 <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
 <20220425235134-mutt-send-email-mst@kernel.org>
 <20220425235415-mutt-send-email-mst@kernel.org>
 <CACGkMEve+3ugK-Kgao3_2wbjb=fbF7AO2uEuArGjKgEAQcGdiQ@mail.gmail.com>
 <20220426022420-mutt-send-email-mst@kernel.org>
 <CACGkMEtt8irvYVx482Zc4vkjtDANXFvUYHGFoCh=C-Xf3C2JUg@mail.gmail.com>
 <20220427022907-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220427022907-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Apr 2022 15:57:57 +0800
Message-ID: <CACGkMEvfWA9vzVWU6yVdGNwueAAR9MhW8sFAAnGaRB7T+3GYeQ@mail.gmail.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Cindy Lu <lulu@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, eperezma <eperezma@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

T24gV2VkLCBBcHIgMjcsIDIwMjIgYXQgMjozMCBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIFdlZCwgQXByIDI3LCAyMDIyIGF0IDExOjUzOjI1QU0g
KzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiBPbiBUdWUsIEFwciAyNiwgMjAyMiBhdCAyOjMw
IFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPgo+ID4g
PiBPbiBUdWUsIEFwciAyNiwgMjAyMiBhdCAxMjowNzozOVBNICswODAwLCBKYXNvbiBXYW5nIHdy
b3RlOgo+ID4gPiA+IE9uIFR1ZSwgQXByIDI2LCAyMDIyIGF0IDExOjU1IEFNIE1pY2hhZWwgUy4g
VHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4KPiA+ID4gPiA+IE9uIE1v
biwgQXByIDI1LCAyMDIyIGF0IDExOjUzOjI0UE0gLTA0MDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3
cm90ZToKPiA+ID4gPiA+ID4gT24gVHVlLCBBcHIgMjYsIDIwMjIgYXQgMTE6NDI6NDVBTSArMDgw
MCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IOWcqCAyMDIy
LzQvMjYgMTE6MzgsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4gPiA+ID4gPiA+ID4gPiBP
biBNb24sIEFwciAyNSwgMjAyMiBhdCAxMTozNTo0MVBNIC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJr
aW4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+IE9uIFR1ZSwgQXByIDI2LCAyMDIyIGF0IDA0OjI5
OjExQU0gKzAyMDAsIEhhbGlsIFBhc2ljIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+IE9uIE1v
biwgMjUgQXByIDIwMjIgMDk6NTk6NTUgLTA0MDAKPiA+ID4gPiA+ID4gPiA+ID4gPiAiTWljaGFl
bCBTLiBUc2lya2luIiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBPbiBNb24sIEFwciAyNSwgMjAyMiBhdCAxMDo1NDoyNEFN
ICswMjAwLCBDb3JuZWxpYSBIdWNrIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBPbiBN
b24sIEFwciAyNSAyMDIyLCAiTWljaGFlbCBTLiBUc2lya2luIiA8bXN0QHJlZGhhdC5jb20+IHdy
b3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IE9uIE1vbiwgQXByIDI1LCAyMDIyIGF0IDEw
OjQ0OjE1QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiBUaGlzIHBhdGNoIHRyaWVzIHRvIGltcGxlbWVudCB0aGUgc3luY2hyb25pemVfY2JzKCkg
Zm9yIGNjdy4gRm9yIHRoZQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gdnJpbmdfaW50ZXJy
dXB0KCkgdGhhdCBpcyBjYWxsZWQgdmlhIHZpcnRpb19haXJxX2hhbmRsZXIoKSwgdGhlCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBzeW5jaHJvbml6YXRpb24gaXMgc2ltcGx5IGRvbmUgdmlh
IHRoZSBhaXJxX2luZm8ncyBsb2NrLiBGb3IgdGhlCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiB2cmluZ19pbnRlcnJ1cHQoKSB0aGF0IGlzIGNhbGxlZCB2aWEgdmlydGlvX2Njd19pbnRfaGFu
ZGxlcigpLCBhIHBlcgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gZGV2aWNlIHNwaW5sb2Nr
IGZvciBpcnEgaXMgaW50cm9kdWNlZCBhbnMgdXNlZCBpbiB0aGUgc3luY2hyb25pemF0aW9uCj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBtZXRob2QuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQ2M6IFRob21hcyBHbGVpeG5lciA8dGds
eEBsaW51dHJvbml4LmRlPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQ2M6IFBldGVyIFpp
amxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IENjOiAiUGF1bCBFLiBNY0tlbm5leSIgPHBhdWxtY2tAa2VybmVsLm9yZz4KPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IENjOiBNYXJjIFp5bmdpZXIgPG1hekBrZXJuZWwub3JnPgo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gQ2M6IEhhbGlsIFBhc2ljIDxwYXNpY0BsaW51eC5pYm0uY29t
Pgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQ2M6IENvcm5lbGlhIEh1Y2sgPGNvaHVja0By
ZWRoYXQuY29tPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSmFz
b24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFRoaXMgaXMgdGhlIG9ubHkgb25lIHRoYXQgaXMgZ2l2
aW5nIG1lIHBhdXNlLiBIYWxpbCwgQ29ybmVsaWEsCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
c2hvdWxkIHdlIGJlIGNvbmNlcm5lZCBhYm91dCB0aGUgcGVyZm9ybWFuY2UgaW1wYWN0IGhlcmU/
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQW55IGNoYW5jZSBpdCBjYW4gYmUgdGVzdGVkPwo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBXZSBjYW4gaGF2ZSBhIGJ1bmNoIG9mIGRldmljZXMgdXNp
bmcgdGhlIHNhbWUgYWlycSBzdHJ1Y3R1cmUsIGFuZCB0aGUKPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gc3luYyBjYiBjcmVhdGVzIGEgY2hva2UgcG9pbnQsIHNhbWUgYXMgcmVnaXN0ZXJpbmcvdW5y
ZWdpc3RlcmluZy4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEJUVyBjYW4gY2FsbGJhY2tzIGZvciBt
dWx0aXBsZSBWUXMgcnVuIG9uIG11bHRpcGxlIENQVXMgYXQgdGhlIG1vbWVudD8KPiA+ID4gPiA+
ID4gPiA+ID4gPiBJJ20gbm90IHN1cmUgSSB1bmRlcnN0YW5kIHRoZSBxdWVzdGlvbi4KPiA+ID4g
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+IEkgZG8gdGhpbmsgd2UgY2FuIGhhdmUg
bXVsdGlwbGUgQ1BVcyB0aGF0IGFyZSBleGVjdXRpbmcgc29tZSBwb3J0aW9uIG9mCj4gPiA+ID4g
PiA+ID4gPiA+ID4gdmlydGlvX2Njd19pbnRfaGFuZGxlcigpLiBTbyBJIGd1ZXNzIHRoZSBhbnN3
ZXIgaXMgeWVzLiBDb25uaWUgd2hhdCBkbyB5b3UgdGhpbms/Cj4gPiA+ID4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiA+ID4gPiBPbiB0aGUgb3RoZXIgaGFuZCB3ZSBjb3VsZCBhbHNvIGVuZCB1
cCBzZXJpYWxpemluZyBzeW5jaHJvbml6ZV9jYnMoKQo+ID4gPiA+ID4gPiA+ID4gPiA+IGNhbGxz
IGZvciBkaWZmZXJlbnQgZGV2aWNlcyBpZiB0aGV5IGhhcHBlbiB0byB1c2UgdGhlIHNhbWUgYWly
cV9pbmZvLiBCdXQKPiA+ID4gPiA+ID4gPiA+ID4gPiB0aGlzIHByb2JhYmx5IHdhcyBub3QgeW91
ciBxdWVzdGlvbgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiBJIGFtIGxlc3Mg
Y29uY2VybmVkIGFib3V0ICBzeW5jaHJvbml6ZV9jYnMgYmVpbmcgc2xvdyBhbmQgbW9yZSBhYm91
dAo+ID4gPiA+ID4gPiA+ID4gPiB0aGUgc2xvd2Rvd24gaW4gaW50ZXJydXB0IHByb2Nlc3Npbmcg
aXRzZWxmLgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gdGhpcyBwYXRj
aCBzZXJpYWxpemVzIHRoZW0gb24gYSBzcGlubG9jay4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+ID4gPiA+ID4gVGhvc2UgY291bGQgdGhlbiBwaWxlIHVwIG9uIHRoZSBuZXdseSBp
bnRyb2R1Y2VkIHNwaW5sb2NrLgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+
ID4gUmVnYXJkcywKPiA+ID4gPiA+ID4gPiA+ID4gPiBIYWxpbAo+ID4gPiA+ID4gPiA+ID4gPiBI
bW0geWVhIC4uLiBub3QgZ29vZC4KPiA+ID4gPiA+ID4gPiA+IElzIHRoZXJlIGFueSBvdGhlciB3
YXkgdG8gc3luY2hyb25pemUgd2l0aCBhbGwgY2FsbGJhY2tzPwo+ID4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBNYXliZSB1c2luZyByd2xvY2sgYXMgYWlycSBoYW5kbGVy
Pwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gcndsb2NrIGlzIHN0aWxsIGEgc2hhcmVkIGNhY2hlbGluZSBib3Vu
Y2luZyBiZXR3ZWVuIENQVXMgYW5kCj4gPiA+ID4gPiA+IGEgYnVuY2ggb2Ygb3JkZXJpbmcgaW5z
dHJ1Y3Rpb25zLgo+ID4gPiA+Cj4gPiA+ID4gWWVzLCBidXQgaXQgc2hvdWxkIGJlIGZhc3RlciB0
aGFuIHNwaW5sb2NrcyBhbnlob3cuCj4gPiA+ID4KPiA+ID4gPiA+ID4gTWF5YmUgc29tZXRoaW5n
IHBlci1jcHUgKyBzb21lIElQSXMgdG8gcnVuIHRoaW5ncyBvbiBhbGwgQ1BVcyBpbnN0ZWFkPwo+
ID4gPiA+Cj4gPiA+ID4gSXMgdGhpcyBzb21ldGhpbmcgbGlrZSBhIGN1c3RvbWl6ZWQgdmVyc2lv
biBvZiBzeW5jaHJvbnppZV9yY3VfZXhwZWRpdGVkKCk/Cj4gPiA+Cj4gPiA+IFdpdGggaW50ZXJy
dXB0cyBydW5uaW5nIGluIGFuIFJDVSByZWFkIHNpemUgY3JpdGljYWwgc2VjdGlvbj8KPiA+Cj4g
PiBGb3IgdnJpbmdfaW50ZXJydXB0KCksIHllcy4KPiA+Cj4gPgo+ID4gPiBRdWl0ZSBwb3NzaWJs
eSB0aGF0IGlzIGFsc28gYW4gb3B0aW9uLgo+ID4gPiBUaGlzIHdpbGwgbmVlZCBhIGJ1bmNoIG9m
IGRvY3VtZW50YXRpb24gc2luY2UgdGhpcyBpcyBub3QKPiA+ID4gYSBzdGFuZGFyZCB1c2Ugb2Yg
UkNVLAo+ID4KPiA+IEFjY29yZGluZyB0byBEb2N1bWVudGF0aW9uL1JDVS9yZXF1aXJlbWVudHMu
cnN0LCBpdCBsb29rcyBsaWtlIGEgbGVnYWwgY2FzZToKPiA+Cj4gPiAiCj4gPiBUaGUgTGludXgg
a2VybmVsIGhhcyBpbnRlcnJ1cHRzLCBhbmQgUkNVIHJlYWQtc2lkZSBjcml0aWNhbCBzZWN0aW9u
cyBhcmUKPiA+IGxlZ2FsIHdpdGhpbiBpbnRlcnJ1cHQgaGFuZGxlcnMgYW5kIHdpdGhpbiBpbnRl
cnJ1cHQtZGlzYWJsZWQgcmVnaW9ucyBvZgo+ID4gY29kZSwgYXMgYXJlIGludm9jYXRpb25zIG9m
IGNhbGxfcmN1KCkuCj4gPiAiCj4KPiBNeSBwcm9ibGVtIGlzIGl0IGlzIG5vdCBjbGVhciB3aGF0
IGRhdGEgaXMgcHJvdGVjdGVkIGJ5IHJjdSBoZXJlLgo+IE5vdGhpbmcgaXMgdGFnZ2VkIHdpdGgg
X19yY3Ugb3IgdXNlcyByY3VfZGVyZWZlcmVuY2UuCgpJdCBzaG91bGQgYmUgdGhlIHZxLT5icm9r
ZW4gaGVyZS4gV2UgY2FuIHJjdWlmeSBpdC4KCgo+IFdlIG5lZWQgYXQgbGVhc3QgYW4gYWNrIGZy
b20gcmN1IG1haW50YWluZXJzIHRoYXQgdGhpcyBpcwo+IGEgdmFsaWQgdXNlIG9mIHJjdSBhbmQg
bm90IGFuIHVuZG9jdW1lbnRlZCBzaWRlIGVmZmVjdC4KClllcy4KClRoYW5rcwoKCj4KPiA+IEFu
ZCBhcyBkaXNjdXNzZWQsIHN5bmNocm9uaXplX3JjdV9leHBlZGl0ZWQoKSBpcyBub3QgZnJpZW5k
bHkgdG8gcmVhbAo+ID4gdGltZSB3b3JrbG9hZC4gSSB0aGluayB3ZSBjYW4gc2ltcGx5Cj4gPgo+
ID4gMSkgcHJvdGVjdCB2cmluZ19pbnRlcnJ1cHQoKSB3aXRoIHJjdV9yZWFkX2xvY2soKQo+ID4g
MikgdXNlIHN5bmNocm9uaXplX3JjdSgpIGluIHN5bmNocm9uaXplX2NicyBmb3IgY2N3Cj4gPgo+
ID4gQW5kIGlmIHdlIGNhcmUgYWJvdXQgdGhlIGxvbmcgZGVsYXkgd2UgY2FuIHVzZSBwZXIgZGV2
aWNlIHNyY3UgdG8gcmVkdWNlIHRoYXQ/Cj4gPgo+ID4gVGhhbmtzCj4gPgo+ID4gPiBhbmQgcHJv
YmFibHkgZ2V0IGEgY29uZmlybWF0aW9uCj4gPiA+IGZyb20gUkNVIG1haW50YWluZXJzIHRoYXQg
d2hhdGV2ZXIgYXNzdW1wdGlvbnMgd2UgbWFrZQo+ID4gPiBhcmUgZ3VhcmFudGVlZCB0byBob2xk
IGRvd24gdGhlIHJvYWQuCj4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4gLi4uIGFuZCBJIHRoaW5r
IGNsYXNzaWMgYW5kIGRldmljZSBpbnRlcnJ1cHRzIGFyZSBkaWZmZXJlbnQgZW5vdWdoCj4gPiA+
ID4gPiBoZXJlIC4uLgo+ID4gPiA+Cj4gPiA+ID4gWWVzLgo+ID4gPiA+Cj4gPiA+ID4gVGhhbmtz
Cj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiAtLQo+
ID4gPiA+ID4gPiA+ID4gPiBNU1QKPiA+ID4gPiA+Cj4gPiA+Cj4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
