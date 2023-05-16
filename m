Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40051C77B7F
	for <virtualization@archiver.kernel.org>; Tue, 16 May 2023 04:18:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C7F6F4012A;
	Tue, 16 May 2023 04:18:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C7F6F4012A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V5qvpncn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J9O5WuRUMPGc; Tue, 16 May 2023 04:18:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 88BC64016F;
	Tue, 16 May 2023 04:18:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 88BC64016F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D72BC0037;
	Tue, 16 May 2023 04:18:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA906C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 04:18:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 81151613C0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 04:18:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 81151613C0
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=V5qvpncn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r_dkqmWmcspf
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 04:18:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7CC5060F2E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7CC5060F2E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 04:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684210687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9NWCEVhUxXac0SgI8SdAC5oCHCztYJjiGcJEkQVeZHg=;
 b=V5qvpncn9B/VRH1/Zw1UnWUif4+5hazZEFRxrSmzEad7dmiOwxrE/GPIXWAdslCMNcsqCN
 dduNtiMJCWB9C365EbT++pWTsdJCVe+81cm+drYZFZ2T9/NTKRxXJk3EGrIFg0IUutYPNr
 0w6pSCUuGwSWn6S1H6pRNk9M1tlKW6k=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-V_1FnrOTM3m16EcbNF7bmA-1; Tue, 16 May 2023 00:18:03 -0400
X-MC-Unique: V_1FnrOTM3m16EcbNF7bmA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4edc7406cbaso7374097e87.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 21:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684210682; x=1686802682;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9NWCEVhUxXac0SgI8SdAC5oCHCztYJjiGcJEkQVeZHg=;
 b=Flo+nAi5IAwwic5w7VWfJC+re/Rijrf/eKF0hBctncKbhWzJnMptI7eFFBqKg2HGTU
 TWjMSemVtREO7tqXhJqzC/Ktev/2/Tzucd3+rEBBNQ8ID2QdLgCUEZkbu+ox4qOt0V/C
 A1i50ScKqODWRxxzHMyVtYN94xxlz5MfCc3Xjjrq8pyq9nPCq8DiN3b0IuREe/LxSfkL
 ojeCjo1O/bzpKJIaH/V3OxyOeSqGNtFIOCzoH8qsEOvvtyLlt/nOQoM4eKnw95C0tFmi
 j7SIMoR+dmBeHU54getWZVByv93JCg8akOi5tnLPXN8gH3jM5X92pvRPg3CMenjKlWiO
 bq9w==
X-Gm-Message-State: AC+VfDwST3E7RAcCEFykDRcBvgTV6g8SL5ivVRF0jGP/AZIetgi7h3JC
 /UTmIdtP1odhn3DMp602eRDxZmT8XDi0oz1fhJtqCJv5SWFGQfLKRmPaaIg7cBSal0nFm1Zx2JV
 TeEpxFIKc96J6A0fBYEJJLwvx6bDycv9TnGmNgUuA+tTXTs6SzkNVYJWDXQ==
X-Received: by 2002:ac2:4a75:0:b0:4f1:444e:6c5a with SMTP id
 q21-20020ac24a75000000b004f1444e6c5amr6738614lfp.8.1684210682007; 
 Mon, 15 May 2023 21:18:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ZTyVVhSMJw2IulnTZup4VUyz0KR2czGgnHsQrh3Ne6itX4gHPwy0Kq/Y5JuXUsrcYrkZ8FsnaekOT7u9hHTE=
X-Received: by 2002:ac2:4a75:0:b0:4f1:444e:6c5a with SMTP id
 q21-20020ac24a75000000b004f1444e6c5amr6738602lfp.8.1684210681690; Mon, 15 May
 2023 21:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230413121525-mutt-send-email-mst@kernel.org>
 <CACGkMEunn1Z3n8yjVaWLqdV502yjaCBSAb_LO4KsB0nuxXmV8A@mail.gmail.com>
 <20230414031947-mutt-send-email-mst@kernel.org>
 <CACGkMEtutGn0CoJhoPHbzPuqoCLb4OCT6a_vB_WPV=MhwY0DXg@mail.gmail.com>
 <20230510012951-mutt-send-email-mst@kernel.org>
 <CACGkMEszPydzw_MOUOVJKBBW_8iYn66i_9OFvLDoZMH34hMx=w@mail.gmail.com>
 <20230515004422-mutt-send-email-mst@kernel.org>
 <CACGkMEv+Q2UoBarNOzKSrc3O=Wb2_73O2j9cZXFdAiLBm1qY-Q@mail.gmail.com>
 <20230515061455-mutt-send-email-mst@kernel.org>
 <CACGkMEt8QkK1PnTrRUjDbyJheBurdibr4--Es8P0Y9NZM659pQ@mail.gmail.com>
 <20230516000829-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230516000829-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 May 2023 12:17:50 +0800
Message-ID: <CACGkMEvCHQLFbtB2fbF27oCd5fNSjUtUOS0q-Lx7=MeYR8KzRA@mail.gmail.com>
Subject: Re: [PATCH net-next V2 1/2] virtio-net: convert rx mode setting to
 use workqueue
To: "Michael S. Tsirkin" <mst@redhat.com>, kuba@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, netdev <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, edumazet@google.com, maxime.coquelin@redhat.com,
 pabeni@redhat.com, david.marchand@redhat.com, davem@davemloft.net
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

T24gVHVlLCBNYXkgMTYsIDIwMjMgYXQgMTI6MTPigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1z
dEByZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIFR1ZSwgTWF5IDE2LCAyMDIzIGF0IDEwOjQ0OjQ1
QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiBPbiBNb24sIE1heSAxNSwgMjAyMyBhdCA2
OjE34oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+
Cj4gPiA+IE9uIE1vbiwgTWF5IDE1LCAyMDIzIGF0IDAxOjEzOjMzUE0gKzA4MDAsIEphc29uIFdh
bmcgd3JvdGU6Cj4gPiA+ID4gT24gTW9uLCBNYXkgMTUsIDIwMjMgYXQgMTI6NDXigK9QTSBNaWNo
YWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+Cj4gPiA+ID4g
PiBPbiBNb24sIE1heSAxNSwgMjAyMyBhdCAwOTowNTo1NEFNICswODAwLCBKYXNvbiBXYW5nIHdy
b3RlOgo+ID4gPiA+ID4gPiBPbiBXZWQsIE1heSAxMCwgMjAyMyBhdCAxOjMz4oCvUE0gTWljaGFl
bCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gPiBPbiBNb24sIEFwciAxNywgMjAyMyBhdCAxMTo0MDo1OEFNICswODAwLCBKYXNvbiBX
YW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gT24gRnJpLCBBcHIgMTQsIDIwMjMgYXQgMzoyMeKA
r1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiBPbiBGcmksIEFwciAxNCwgMjAyMyBhdCAwMTowNDox
NVBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+IEZvcmdldCB0
byBjYyBuZXRkZXYsIGFkZGluZy4KPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4g
PiA+IE9uIEZyaSwgQXByIDE0LCAyMDIzIGF0IDEyOjI14oCvQU0gTWljaGFlbCBTLiBUc2lya2lu
IDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gT24gVGh1LCBBcHIgMTMsIDIwMjMgYXQgMDI6NDA6MjZQTSArMDgwMCwgSmFz
b24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gVGhpcyBwYXRjaCBjb252ZXJ0
IHJ4IG1vZGUgc2V0dGluZyB0byBiZSBkb25lIGluIGEgd29ya3F1ZXVlLCB0aGlzIGlzCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IGEgbXVzdCBmb3IgYWxsb3cgdG8gc2xlZXAgd2hlbiB3YWl0aW5n
IGZvciB0aGUgY3ZxIGNvbW1hbmQgdG8KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gcmVzcG9uc2Ug
c2luY2UgY3VycmVudCBjb2RlIGlzIGV4ZWN1dGVkIHVuZGVyIGFkZHIgc3BpbiBsb2NrLgo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IEkgZG9uJ3QgbGlrZSB0aGlzIGZyYW5rbHkuIFRoaXMgbWVh
bnMgdGhhdCBzZXR0aW5nIFJYIG1vZGUgd2hpY2ggd291bGQKPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IHByZXZpb3VzbHkgYmUgcmVsaWFibGUsIG5vdyBiZWNvbWVzIHVucmVsaWFibGUuCj4gPiA+ID4g
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiBJdCBpcyAidW5yZWxpYWJsZSIgYnkgZGVz
aWduOgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgdm9pZCAg
ICAgICAgICAgICAgICAgICAgKCpuZG9fc2V0X3J4X21vZGUpKHN0cnVjdCBuZXRfZGV2aWNlICpk
ZXYpOwo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAtIGZpcnN0IG9m
IGFsbCBjb25maWd1cmF0aW9uIGlzIG5vIGxvbmdlciBpbW1lZGlhdGUKPiA+ID4gPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+IElzIGltbWVkaWF0ZSBhIGhhcmQgcmVxdWlyZW1lbnQ/
IEkgY2FuIHNlZSBhIHdvcmtxdWV1ZSBpcyB1c2VkIGF0IGxlYXN0Ogo+ID4gPiA+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gbWx4NWUsIGlwb2liLCBlZngsIC4uLgo+ID4gPiA+ID4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgIGFuZCB0aGVyZSBpcyBubyB3YXkgZm9y
IGRyaXZlciB0byBmaW5kIG91dCB3aGVuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgIGl0IGFjdHVh
bGx5IHRvb2sgZWZmZWN0Cj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiBC
dXQgd2Uga25vdyByeCBtb2RlIGlzIGJlc3QgZWZmb3J0IGUuZyBpdCBkb2Vzbid0IHN1cHBvcnQg
dmhvc3QgYW5kIHdlCj4gPiA+ID4gPiA+ID4gPiA+ID4gc3Vydml2ZSBmcm9tIHRoaXMgZm9yIHll
YXJzLgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAtIHNlY29uZCwg
aWYgZGV2aWNlIGZhaWxzIGNvbW1hbmQsIHRoaXMgaXMgYWxzbyBub3QKPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ICAgcHJvcGFnYXRlZCB0byBkcml2ZXIsIGFnYWluIG5vIHdheSBmb3IgZHJpdmVyIHRv
IGZpbmQgb3V0Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gVkRV
U0UgbmVlZHMgdG8gYmUgZml4ZWQgdG8gZG8gdHJpY2tzIHRvIGZpeCB0aGlzCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiB3aXRob3V0IGJyZWFraW5nIG5vcm1hbCBkcml2ZXJzLgo+ID4gPiA+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gSXQncyBub3Qgc3BlY2lmaWMgdG8gVkRVU0UuIEZv
ciBleGFtcGxlLCB3aGVuIHVzaW5nIHZpcnRpby1uZXQgaW4gdGhlCj4gPiA+ID4gPiA+ID4gPiA+
ID4gVVAgZW52aXJvbm1lbnQgd2l0aCBhbnkgc29mdHdhcmUgY3ZxIChsaWtlIG1seDUgdmlhIHZE
UEEgb3IgY21hCj4gPiA+ID4gPiA+ID4gPiA+ID4gdHJhbnNwb3J0KS4KPiA+ID4gPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiA+ID4gPiBIbW0uIENhbiB3ZSBkaWZmZXJlbnRpYXRlIGJldHdlZW4gdGhlc2UgdXNlLWNh
c2VzPwo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IEl0IGRvZXNuJ3QgbG9vayBlYXN5
IHNpbmNlIHdlIGFyZSBkcml2ZXJzIGZvciB2aXJ0aW8gYnVzLiBVbmRlcmxheWVyCj4gPiA+ID4g
PiA+ID4gPiBkZXRhaWxzIHdlcmUgaGlkZGVuIGZyb20gdmlydGlvLW5ldC4KPiA+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gPiBPciBkbyB5b3UgaGF2ZSBhbnkgaWRlYXMgb24gdGhpcz8KPiA+
ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiA+IEkgZG9uJ3Qga25vdywgcGFzcyBzb21lIGtpbmQgb2YgZmxhZyBpbiBzdHJ1Y3Qgdmly
dHF1ZXVlPwo+ID4gPiA+ID4gPiA+ICAgICAgICAgImJvb2wgc2xvdzsgLyogVGhpcyB2cSBjYW4g
YmUgdmVyeSBzbG93IHNvbWV0aW1lcy4gRG9uJ3Qgd2FpdCBmb3IgaXQhICovIgo+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gPwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
IFNvIGlmIGl0J3Mgc2xvdywgc2xlZXAsIG90aGVyd2lzZSBwb2xsPwo+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiBJIGZlZWwgc2V0dGluZyB0aGlzIGZsYWcgbWlnaHQgYmUgdHJpY2t5LCBzaW5jZSB0
aGUgZHJpdmVyIGRvZXNuJ3QKPiA+ID4gPiA+ID4ga25vdyB3aGV0aGVyIG9yIG5vdCBpdCdzIHJl
YWxseSBzbG93LiBFLmcgc21hcnROSUMgdmVuZG9yIG1heSBhbGxvdwo+ID4gPiA+ID4gPiB2aXJ0
aW8tbmV0IGVtdWxhdGlvbiBvdmVyIFBDSS4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gVGhhbmtz
Cj4gPiA+ID4gPgo+ID4gPiA+ID4gZHJpdmVyIHdpbGwgaGF2ZSB0aGUgY2hvaWNlLCBkZXBlbmRp
bmcgb24gd2hldGhlcgo+ID4gPiA+ID4gdnEgaXMgZGV0ZXJtaW5pc3RpYyBvciBub3QuCj4gPiA+
ID4KPiA+ID4gPiBPaywgYnV0IHRoZSBwcm9ibGVtIGlzLCBzdWNoIGJvb2xlYW5zIGFyZSBvbmx5
IHVzZWZ1bCBmb3IgdmlydGlvIHJpbmcKPiA+ID4gPiBjb2Rlcy4gQnV0IGluIHRoaXMgY2FzZSwg
dmlydGlvLW5ldCBrbm93cyB3aGF0IHRvIGRvIGZvciBjdnEuIFNvIEknbQo+ID4gPiA+IG5vdCBz
dXJlIHdobyB0aGUgdXNlciBpcy4KPiA+ID4gPgo+ID4gPiA+IFRoYW5rcwo+ID4gPgo+ID4gPiBD
aXJjbGluZyBiYWNrLCB3aGF0IGV4YWN0bHkgZG9lcyB0aGUgYXJjaGl0ZWN0dXJlIHlvdSBhcmUg
dHJ5aW5nCj4gPiA+IHRvIGZpeCBsb29rIGxpa2U/IFdobyBpcyBnb2luZyB0byBpbnRyb2R1Y2Ug
dW5ib3VuZGVkIGxhdGVuY3k/Cj4gPiA+IFRoZSBoeXBlcnZpc29yPwo+ID4KPiA+IEh5cGVydmlz
b3IgaXMgb25lIG9mIHRoZSBwb3NzaWJsZSByZWFzb24sIHdlIGhhdmUgbWFueSBtb3JlOgo+ID4K
PiA+IEhhcmR3YXJlIGRldmljZSB0aGF0IHByb3ZpZGVzIHZpcnRpby1wY2kgZW11bGF0aW9uLgo+
ID4gVXNlcnNwYWNlIGRldmljZXMgbGlrZSBWRFVTRS4KPgo+IFNvIGxldCdzIHN0YXJ0IGJ5IGFk
ZHJlc3NpbmcgVkRVU0UgbWF5YmU/CgpJdCdzIHJlcG9ydGVkIGJ5IGF0IGxlYXN0IG9uZSBoYXJk
d2FyZSB2ZW5kb3IgYXMgd2VsbC4gSSByZW1lbWJlciBpdAp3YXMgQWx2YXJvIHdobyByZXBvcnRl
ZCB0aGlzIGZpcnN0IGluIHRoZSBwYXN0LgoKPgo+ID4gPiBJZiBzbyBkbyB3ZSBub3QgbWF5YmUg
d2FudCBhIG5ldyBmZWF0dXJlIGJpdAo+ID4gPiB0aGF0IGRvY3VtZW50cyB0aGlzPyBIeXBlcnZp
c29yIHRoZW4gY2FuIGRldGVjdCBvbGQgZ3Vlc3RzCj4gPiA+IHRoYXQgc3BpbiBhbmQgZGVjaWRl
IHdoYXQgdG8gZG8sIGUuZy4gcHJpb3JpdGlzZSBjdnEgbW9yZSwKPiA+ID4gb3IgZmFpbCBGRUFU
VVJFU19PSy4KPiA+Cj4gPiBXZSBzdWZmZXIgZnJvbSB0aGlzIGZvciBiYXJlIG1ldGFsIGFzIHdl
bGwuCj4gPgo+ID4gQnV0IGEgcXVlc3Rpb24gaXMgd2hhdCdzIHdyb25nIHdpdGggdGhlIGFwcHJv
YWNoIHRoYXQgaXMgdXNlZCBpbiB0aGlzCj4gPiBwYXRjaD8gSSd2ZSBhbnN3ZXJlZCB0aGF0IHNl
dF9yeF9tb2RlIGlzIG5vdCByZWxpYWJsZSwgc28gaXQgc2hvdWxkIGJlCj4gPiBmaW5lIHRvIHVz
ZSB3b3JrcXVldWUuIEV4Y2VwdCBmb3IgdGhpcywgYW55IG90aGVyIHRoaW5nIHRoYXQgd29ycmll
cwo+ID4geW91Pwo+ID4KPiA+IFRoYW5rcwo+Cj4gSXQncyBub3QgcmVsaWFibGUgZm9yIG90aGVy
IGRyaXZlcnMgYnV0IGhhcyBiZWVuIHJlbGlhYmxlIGZvciB2aXJ0aW8uCj4gSSB3b3JyeSBzb21l
IHNvZnR3YXJlIHJlbGllZCBvbiB0aGlzLgoKSXQncyBwcm9iYWJseSBmaW5lIHNpbmNlIHNvbWUg
ZGV2aWNlIGxpa2Ugdmhvc3QgZG9lc24ndCBzdXBwb3J0IHRoaXMKYXQgYWxsIGFuZCB3ZSBtYW5h
Z2UgdG8gc3Vydml2ZSBmb3Igc2V2ZXJhbCB5ZWFycy4KCj4gWW91IGFyZSBtYWtpbmcgZ29vZCBw
b2ludHMgdGhvdWdoIC4uLiBjb3VsZCB3ZSBnZXQgc29tZQo+IG1haW50YWluZXIncyBmZWVkYmFj
ayBvbiB0aGlzPwoKVGhhdCB3b3VsZCBiZSBoZWxwZnVsLiBKYWt1YiwgYW55IGlucHV0IG9uIHRo
aXM/CgpUaGFua3MKCj4KPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IC0t
Cj4gPiA+ID4gPiA+ID4gTVNUCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+Cj4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
