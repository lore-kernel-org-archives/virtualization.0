Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A41DEB64DD
	for <virtualization@archiver.kernel.org>; Thu, 27 Jul 2023 06:04:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ACA4E612F2;
	Thu, 27 Jul 2023 06:04:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ACA4E612F2
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bcXbyMGh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id alQ7BzJTHtNp; Thu, 27 Jul 2023 06:04:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D0AB8612EF;
	Thu, 27 Jul 2023 06:04:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D0AB8612EF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A284CC0072;
	Thu, 27 Jul 2023 06:04:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCEFFC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 06:04:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 81E1041ECA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 06:04:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 81E1041ECA
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bcXbyMGh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MjagYxsXpm94
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 06:04:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BB7CE41EBD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 06:04:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BB7CE41EBD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690437854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ERmF9zdnwQnncOVhFORT4PHWXzJ5Avyj/gIeOqR4Hrs=;
 b=bcXbyMGhpJd8oImhbEnlQ6coc0jQB8WOWAlR2fs4siaIbGCRYkaInNAyLMPcacRbkHRm0b
 xTK67uCyIrblU2tnTRNG/SvoOgB3QqP9ctnT1p/1mirzZRKqt4ZRNOkbl8BhHt25A4f+zb
 DXHEVejO0acfr0nXT3fKQc0XwcADjYc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-ZzGxTSgKOlWmrRPpLUs94Q-1; Thu, 27 Jul 2023 02:04:13 -0400
X-MC-Unique: ZzGxTSgKOlWmrRPpLUs94Q-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b9bf493456so4456941fa.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 23:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690437851; x=1691042651;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ERmF9zdnwQnncOVhFORT4PHWXzJ5Avyj/gIeOqR4Hrs=;
 b=XV7clYT5yFaP2QiIjDgj7AgXYFrGVjYfQSLmp8IYJlz/gBCwEB9yGizWv73Hn7MO56
 zG8yOOxbletyJwrTfrh9YqFVM+80kVaCfcIWBbZh5aZyy7ANSWldmH34lGU4VOUw50Gd
 68VYK1LVPm43C4hqqnISxyA0/VVdZPDKTIKr6VzCCZBLMbF2MRIsCBGErRIj2uatyj/6
 69ea5UIItZbFvBCu5tJ0V3BGq3+kbI2Mh///QxDR2v3GIbYO0OY1U8S4uI9ibZAfwcU+
 tNMMYJu2gQn3kgj5d7/zkL3CDL30RS5PLG/waH1w0xwP3cqNHWixFece1TUZ2H9Rd6X4
 De/Q==
X-Gm-Message-State: ABy/qLbI6K0/V3Y6cHSYWDz6JzgSfG4fxBfbdmjH9L1bR6NN4Xh21JOO
 uyww9LTiIqyoWIYSgqNiHWz7MweAbjLk4IWmOTOz3HFzd7536mMKiRCScAFVVLUH5b5zxVtOi5W
 +K8WwwPajbxsGCwtMJcJPH7Zxt7pMe+g2cRxzjL/fcWJ40sPfvpIcfRwYmg==
X-Received: by 2002:a2e:7d0f:0:b0:2a7:adf7:1781 with SMTP id
 y15-20020a2e7d0f000000b002a7adf71781mr886244ljc.2.1690437851567; 
 Wed, 26 Jul 2023 23:04:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGJ+wg/Ce1LBxht0mOx0tsOAY3PdEIQoMv1e0/Q3XAPRgHquTlMcfPhw2vIjOSYB1sw2+IU/RGZq4y+QmqT41E=
X-Received: by 2002:a2e:7d0f:0:b0:2a7:adf7:1781 with SMTP id
 y15-20020a2e7d0f000000b002a7adf71781mr886220ljc.2.1690437851120; Wed, 26 Jul
 2023 23:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com>
 <20230721104445-mutt-send-email-mst@kernel.org>
 <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com>
 <20230721110925-mutt-send-email-mst@kernel.org>
 <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
 <CACGkMEv1B9xFE7-LrLQC3FbH6CxTZC+toHXoLHFvJWn6wgobrA@mail.gmail.com>
 <20230724025720-mutt-send-email-mst@kernel.org>
 <CACGkMEs7zTXk77h-v_ORhvbtQ4FgehY6w6xCfFeVTeCnzChYkw@mail.gmail.com>
 <20230725033506-mutt-send-email-mst@kernel.org>
 <CACGkMEuAHeA4SqFCzY2v0EFcL9J07msXgDO-jTAWVy6OXzs=hA@mail.gmail.com>
 <20230726073453-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230726073453-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 27 Jul 2023 14:03:59 +0800
Message-ID: <CACGkMEv+CYD3SqmWkay1qVaC8-FQTDpC05Y+3AkmQtJwLMLUjQ@mail.gmail.com>
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

T24gV2VkLCBKdWwgMjYsIDIwMjMgYXQgNzozOOKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gV2VkLCBKdWwgMjYsIDIwMjMgYXQgMDk6NTU6MzdB
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+IE9uIFR1ZSwgSnVsIDI1LCAyMDIzIGF0IDM6
MzbigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4K
PiA+ID4gT24gVHVlLCBKdWwgMjUsIDIwMjMgYXQgMTE6MDc6NDBBTSArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZToKPiA+ID4gPiBPbiBNb24sIEp1bCAyNCwgMjAyMyBhdCAzOjE34oCvUE0gTWljaGFl
bCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4g
T24gTW9uLCBKdWwgMjQsIDIwMjMgYXQgMDI6NTI6MDVQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiA+ID4gPiA+ID4gT24gU2F0LCBKdWwgMjIsIDIwMjMgYXQgNDoxOOKAr0FNIE1heGltZSBD
b3F1ZWxpbgo+ID4gPiA+ID4gPiA8bWF4aW1lLmNvcXVlbGluQHJlZGhhdC5jb20+IHdyb3RlOgo+
ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IE9u
IDcvMjEvMjMgMTc6MTAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+
IE9uIEZyaSwgSnVsIDIxLCAyMDIzIGF0IDA0OjU4OjA0UE0gKzAyMDAsIE1heGltZSBDb3F1ZWxp
biB3cm90ZToKPiA+ID4gPiA+ID4gPiA+Pgo+ID4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+ID4g
Pj4gT24gNy8yMS8yMyAxNjo0NSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4gPiA+ID4g
PiA+ID4+PiBPbiBGcmksIEp1bCAyMSwgMjAyMyBhdCAwNDozNzowMFBNICswMjAwLCBNYXhpbWUg
Q29xdWVsaW4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPj4+Pgo+ID4gPiA+ID4gPiA+ID4+Pj4KPiA+
ID4gPiA+ID4gPiA+Pj4+IE9uIDcvMjAvMjMgMjM6MDIsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90
ZToKPiA+ID4gPiA+ID4gPiA+Pj4+PiBPbiBUaHUsIEp1bCAyMCwgMjAyMyBhdCAwMToyNjoyMFBN
IC0wNzAwLCBTaGFubm9uIE5lbHNvbiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+Pj4+Pj4gT24gNy8y
MC8yMyAxOjM4IEFNLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4+Pj4+Pj4KPiA+
ID4gPiA+ID4gPiA+Pj4+Pj4+IEFkZGluZyBjb25kX3Jlc2NoZWQoKSB0byB0aGUgY29tbWFuZCB3
YWl0aW5nIGxvb3AgZm9yIGEgYmV0dGVyCj4gPiA+ID4gPiA+ID4gPj4+Pj4+PiBjby1vcGVyYXRp
b24gd2l0aCB0aGUgc2NoZWR1bGVyLiBUaGlzIGFsbG93cyB0byBnaXZlIENQVSBhIGJyZWF0aCB0
bwo+ID4gPiA+ID4gPiA+ID4+Pj4+Pj4gcnVuIG90aGVyIHRhc2sod29ya3F1ZXVlKSBpbnN0ZWFk
IG9mIGJ1c3kgbG9vcGluZyB3aGVuIHByZWVtcHRpb24gaXMKPiA+ID4gPiA+ID4gPiA+Pj4+Pj4+
IG5vdCBhbGxvd2VkIG9uIGEgZGV2aWNlIHdob3NlIENWUSBtaWdodCBiZSBzbG93Lgo+ID4gPiA+
ID4gPiA+ID4+Pj4+Pj4KPiA+ID4gPiA+ID4gPiA+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEphc29u
IFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4gPiA+ID4gPiA+ID4gPj4+Pj4+Cj4gPiA+ID4g
PiA+ID4gPj4+Pj4+IFRoaXMgc3RpbGwgbGVhdmVzIGh1bmcgcHJvY2Vzc2VzLCBidXQgYXQgbGVh
c3QgaXQgZG9lc24ndCBwaW4gdGhlIENQVSBhbnkKPiA+ID4gPiA+ID4gPiA+Pj4+Pj4gbW9yZS4g
IFRoYW5rcy4KPiA+ID4gPiA+ID4gPiA+Pj4+Pj4gUmV2aWV3ZWQtYnk6IFNoYW5ub24gTmVsc29u
IDxzaGFubm9uLm5lbHNvbkBhbWQuY29tPgo+ID4gPiA+ID4gPiA+ID4+Pj4+Pgo+ID4gPiA+ID4g
PiA+ID4+Pj4+Cj4gPiA+ID4gPiA+ID4gPj4+Pj4gSSdkIGxpa2UgdG8gc2VlIGEgZnVsbCBzb2x1
dGlvbgo+ID4gPiA+ID4gPiA+ID4+Pj4+IDEtIGJsb2NrIHVudGlsIGludGVycnVwdAo+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiBJIHJlbWVtYmVyIGluIHByZXZpb3VzIHZlcnNpb25zLCB5b3Ugd29y
cmllZCBhYm91dCB0aGUgZXh0cmEgTVNJCj4gPiA+ID4gPiA+IHZlY3Rvci4gKE1heWJlIEkgd2Fz
IHdyb25nKS4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+Pj4+Cj4gPiA+ID4gPiA+ID4gPj4+
PiBXb3VsZCBpdCBtYWtlIHNlbnNlIHRvIGFsc28gaGF2ZSBhIHRpbWVvdXQ/Cj4gPiA+ID4gPiA+
ID4gPj4+PiBBbmQgd2hlbiB0aW1lb3V0IGV4cGlyZXMsIHNldCBGQUlMRUQgYml0IGluIGRldmlj
ZSBzdGF0dXM/Cj4gPiA+ID4gPiA+ID4gPj4+Cj4gPiA+ID4gPiA+ID4gPj4+IHZpcnRpbyBzcGVj
IGRvZXMgbm90IHNldCBhbnkgbGltaXRzIG9uIHRoZSB0aW1pbmcgb2YgdnEKPiA+ID4gPiA+ID4g
PiA+Pj4gcHJvY2Vzc2luZy4KPiA+ID4gPiA+ID4gPiA+Pgo+ID4gPiA+ID4gPiA+ID4+IEluZGVl
ZCwgYnV0IEkgdGhvdWdodCB0aGUgZHJpdmVyIGNvdWxkIGRlY2lkZSBpdCBpcyB0b28gbG9uZyBm
b3IgaXQuCj4gPiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4gPiA+PiBUaGUgaXNzdWUgaXMgd2Ug
a2VlcCB3YWl0aW5nIHdpdGggcnRubCBsb2NrZWQsIGl0IGNhbiBxdWlja2x5IG1ha2UgdGhlCj4g
PiA+ID4gPiA+ID4gPj4gc3lzdGVtIHVudXNhYmxlLgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiA+IGlmIHRoaXMgaXMgYSBwcm9ibGVtIHdlIHNob3VsZCBmaW5kIGEgd2F5IG5vdCB0byBr
ZWVwIHJ0bmwKPiA+ID4gPiA+ID4gPiA+IGxvY2tlZCBpbmRlZmluaXRlbHkuCj4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+IEFueSBpZGVhcyBvbiB0aGlzIGRpcmVjdGlvbj8gU2ltcGx5IGRyb3BwaW5n
IHJ0bmwgZHVyaW5nIHRoZSBidXN5IGxvb3AKPiA+ID4gPiA+ID4gd2lsbCByZXN1bHQgaW4gYSBs
b3Qgb2YgcmFjZXMuIFRoaXMgc2VlbXMgdG8gcmVxdWlyZSBub24tdHJpdmlhbAo+ID4gPiA+ID4g
PiBjaGFuZ2VzIGluIHRoZSBuZXR3b3JraW5nIGNvcmUuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gPiAgRnJvbSB0aGUgdGVzdHMgSSBoYXZlIGRvbmUsIEkgdGhpbmsgaXQg
aXMuIFdpdGggT1ZTLCBhIHJlY29uZmlndXJhdGlvbgo+ID4gPiA+ID4gPiA+IGlzIHBlcmZvcm1l
ZCB3aGVuIHRoZSBWRFVTRSBkZXZpY2UgaXMgYWRkZWQsIGFuZCB3aGVuIGEgTUxYNSBkZXZpY2Ug
aXMKPiA+ID4gPiA+ID4gPiBpbiB0aGUgc2FtZSBicmlkZ2UsIGl0IGVuZHMgdXAgZG9pbmcgYW4g
aW9jdGwoKSB0aGF0IHRyaWVzIHRvIHRha2UgdGhlCj4gPiA+ID4gPiA+ID4gcnRubCBsb2NrLiBJ
biB0aGlzIGNvbmZpZ3VyYXRpb24sIGl0IGlzIG5vdCBwb3NzaWJsZSB0byBraWxsIE9WUyBiZWNh
dXNlCj4gPiA+ID4gPiA+ID4gaXQgaXMgc3R1Y2sgdHJ5aW5nIHRvIGFjcXVpcmUgcnRubCBsb2Nr
IGZvciBtbHg1IHRoYXQgaXMgaGVsZCBieSB2aXJ0aW8tCj4gPiA+ID4gPiA+ID4gbmV0Lgo+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiBZZWFoLCBiYXNpY2FsbHksIGFueSBSVE5MIHVzZXJzIHdvdWxk
IGJlIGJsb2NrZWQgZm9yZXZlci4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gQW5kIHRoZSBpbmZp
bml0ZSBsb29wIGhhcyBvdGhlciBzaWRlIGVmZmVjdHMgbGlrZSBpdCBibG9ja3MgdGhlIGZyZWV6
ZXIgdG8gd29yay4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gVG8gc3VtbWFyaXplLCB0aGVyZSBh
cmUgdGhyZWUgaXNzdWVzCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IDEpIGJ1c3kgcG9sbGluZwo+
ID4gPiA+ID4gPiAyKSBicmVha3MgZnJlZXplcgo+ID4gPiA+ID4gPiAzKSBob2xkIFJUTkwgZHVy
aW5nIHRoZSBsb29wCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFNvbHZpbmcgMyBtYXkgaGVscCBz
b21laG93IGZvciAyIGUuZyBzb21lIHBtIHJvdXRpbmUgZS5nIHdpcmVndWFyZCBvcgo+ID4gPiA+
ID4gPiBldmVuIHZpcnRuZXRfcmVzdG9yZSgpIGl0c2VsZiBtYXkgdHJ5IHRvIGhvbGQgdGhlIGxv
Y2suCj4gPiA+ID4gPgo+ID4gPiA+ID4gWWVwLiBTbyBteSBmZWVsaW5nIGN1cnJlbnRseSBpcywg
dGhlIG9ubHkgcmVhbCBmaXggaXMgdG8gYWN0dWFsbHkKPiA+ID4gPiA+IHF1ZXVlIHVwIHRoZSB3
b3JrIGluIHNvZnR3YXJlLgo+ID4gPiA+Cj4gPiA+ID4gRG8geW91IG1lYW4gc29tZXRoaW5nIGxp
a2U6Cj4gPiA+ID4KPiA+ID4gPiBydG5sX2xvY2soKTsKPiA+ID4gPiBxdWV1ZSB1cCB0aGUgd29y
awo+ID4gPiA+IHJ0bmxfdW5sb2NrKCk7Cj4gPiA+ID4gcmV0dXJuIHN1Y2Nlc3M7Cj4gPiA+ID4K
PiA+ID4gPiA/Cj4gPiA+Cj4gPiA+IHllcwo+ID4KPiA+IFdlIHdpbGwgbG9zZSB0aGUgZXJyb3Ig
cmVwb3J0aW5nLCBpcyBpdCBhIHJlYWwgcHJvYmxlbSBvciBub3Q/Cj4KPiBGdW5kYW1lbnRhbCBp
c24ndCBpdD8gTWF5YmUgd2Ugd2FudCBhIHBlci1kZXZpY2UgZmxhZyBmb3IgYSBhc3luY2ggY29t
bWFuZHMsCj4gYW5kIHZkdXNlIHdpbGwgc2V0IGl0IHdoaWxlIGhhcmR3YXJlIHZpcnRpbyB3b24n
dC4KPiB0aGlzIHdheSB3ZSBvbmx5IGxvc2UgZXJyb3IgcmVwb3J0aW5nIGZvciB2ZHVzZS4KClRo
aXMgcHJvYmxlbSBpcyBub3QgVkRVU0Ugc3BlY2lmaWMsIERQVXMvdkRQQSBtYXkgc3VmZmVyIGZy
b20gdGhpcyBhcwp3ZWxsLiBUaGlzIG1pZ2h0IHJlcXVpcmUgbW9yZSB0aG91Z2h0cy4KClRoYW5r
cwoKPgo+ID4gPgo+ID4gPgo+ID4gPiA+ID4gSXQncyBtb3N0bHkgdHJpdmlhbCB0byBsaW1pdAo+
ID4gPiA+ID4gbWVtb3J5IGNvbnN1bXB0aW9uLCB2aWQncyBpcyB0aGUKPiA+ID4gPiA+IG9ubHkg
b25lIHdoZXJlIGl0IHdvdWxkIG1ha2Ugc2Vuc2UgdG8gaGF2ZSBtb3JlIHRoYW4KPiA+ID4gPiA+
IDEgY29tbWFuZCBvZiBhIGdpdmVuIHR5cGUgb3V0c3RhbmRpbmcuCj4gPiA+ID4KPiA+ID4gPiBB
bmQgcnggbW9kZSBzbyB0aGlzIGltcGxpZXMgd2Ugd2lsbCBmYWlsIGFueSBjb21tYW5kIGlmIHRo
ZSBwcmV2aW91cwo+ID4gPiA+IHdvcmsgaXMgbm90IGZpbmlzaGVkLgo+ID4gPgo+ID4gPiBkb24n
dCBmYWlsIGl0LCBzdG9yZSBpdC4KPiA+Cj4gPiBPay4KPiA+Cj4gPiBUaGFua3MKPiA+Cj4gPiA+
Cj4gPiA+ID4gPiBoYXZlIGEgdHJlZQo+ID4gPiA+ID4gb3IgYSBiaXRtYXAgd2l0aCB2aWRzIHRv
IGFkZC9yZW1vdmU/Cj4gPiA+ID4KPiA+ID4gPiBQcm9iYWJseS4KPiA+ID4gPgo+ID4gPiA+IFRo
YW5rcwo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPj4+Pj4gMi0gc3RpbGwgaGFuZGxlIHN1cnBy
aXNlIHJlbW92YWwgY29ycmVjdGx5IGJ5IHdha2luZyBpbiB0aGF0IGNhc2UKPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gVGhpcyBpcyBiYXNpY2FsbHkgd2hhdCB2ZXJzaW9uIDEgZGlkPwo+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzYwMjZlODAxLTZm
ZGEtZmVlOS1hNjliLWQwNmE4MDM2ODYyMUByZWRoYXQuY29tL3QvCj4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+IFRoYW5rcwo+ID4gPiA+ID4KPiA+ID4gPiA+IFllcyAtIGV4Y2VwdCB0aGUgdGltZW91
dCBwYXJ0Lgo+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPj4+Pj4KPiA+ID4gPiA+
ID4gPiA+Pj4+Pgo+ID4gPiA+ID4gPiA+ID4+Pj4+Cj4gPiA+ID4gPiA+ID4gPj4+Pj4+PiAtLS0K
PiA+ID4gPiA+ID4gPiA+Pj4+Pj4+ICAgICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgNCAr
KystCj4gPiA+ID4gPiA+ID4gPj4+Pj4+PiAgICAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkKPiA+ID4gPiA+ID4gPiA+Pj4+Pj4+Cj4gPiA+ID4gPiA+ID4g
Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9u
ZXQvdmlydGlvX25ldC5jCj4gPiA+ID4gPiA+ID4gPj4+Pj4+PiBpbmRleCA5ZjNiMWQ2YWMzM2Qu
LmU3NTMzZjI5YjIxOSAxMDA2NDQKPiA+ID4gPiA+ID4gPiA+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYwo+ID4gPiA+ID4gPiA+ID4+Pj4+Pj4gKysrIGIvZHJpdmVycy9uZXQv
dmlydGlvX25ldC5jCj4gPiA+ID4gPiA+ID4gPj4+Pj4+PiBAQCAtMjMxNCw4ICsyMzE0LDEwIEBA
IHN0YXRpYyBib29sIHZpcnRuZXRfc2VuZF9jb21tYW5kKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZp
LCB1OCBjbGFzcywgdTggY21kLAo+ID4gPiA+ID4gPiA+ID4+Pj4+Pj4gICAgICAgICAgICAgICog
aW50byB0aGUgaHlwZXJ2aXNvciwgc28gdGhlIHJlcXVlc3Qgc2hvdWxkIGJlIGhhbmRsZWQgaW1t
ZWRpYXRlbHkuCj4gPiA+ID4gPiA+ID4gPj4+Pj4+PiAgICAgICAgICAgICAgKi8KPiA+ID4gPiA+
ID4gPiA+Pj4+Pj4+ICAgICAgICAgICAgIHdoaWxlICghdmlydHF1ZXVlX2dldF9idWYodmktPmN2
cSwgJnRtcCkgJiYKPiA+ID4gPiA+ID4gPiA+Pj4+Pj4+IC0gICAgICAgICAgICAgICF2aXJ0cXVl
dWVfaXNfYnJva2VuKHZpLT5jdnEpKQo+ID4gPiA+ID4gPiA+ID4+Pj4+Pj4gKyAgICAgICAgICAg
ICAgIXZpcnRxdWV1ZV9pc19icm9rZW4odmktPmN2cSkpIHsKPiA+ID4gPiA+ID4gPiA+Pj4+Pj4+
ICsgICAgICAgICAgICAgICBjb25kX3Jlc2NoZWQoKTsKPiA+ID4gPiA+ID4gPiA+Pj4+Pj4+ICAg
ICAgICAgICAgICAgICAgICAgY3B1X3JlbGF4KCk7Cj4gPiA+ID4gPiA+ID4gPj4+Pj4+PiArICAg
ICAgIH0KPiA+ID4gPiA+ID4gPiA+Pj4+Pj4+Cj4gPiA+ID4gPiA+ID4gPj4+Pj4+PiAgICAgICAg
ICAgICByZXR1cm4gdmktPmN0cmwtPnN0YXR1cyA9PSBWSVJUSU9fTkVUX09LOwo+ID4gPiA+ID4g
PiA+ID4+Pj4+Pj4gICAgICB9Cj4gPiA+ID4gPiA+ID4gPj4+Pj4+PiAtLQo+ID4gPiA+ID4gPiA+
ID4+Pj4+Pj4gMi4zOS4zCj4gPiA+ID4gPiA+ID4gPj4+Pj4+Pgo+ID4gPiA+ID4gPiA+ID4+Pj4+
Pj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiA+ID4g
PiA+ID4gPiA+Pj4+Pj4+IFZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdAo+ID4gPiA+ID4gPiA+
ID4+Pj4+Pj4gVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKPiA+ID4g
PiA+ID4gPiA+Pj4+Pj4+IGh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9uCj4gPiA+ID4gPiA+ID4gPj4+Pj4KPiA+ID4gPiA+ID4g
PiA+Pj4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+Cj4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
