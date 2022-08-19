Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 719DEC25B0E
	for <virtualization@archiver.kernel.org>; Fri, 19 Aug 2022 03:52:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AECF982BF5;
	Fri, 19 Aug 2022 03:52:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AECF982BF5
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YJc4srxN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 86bI2M3_C86O; Fri, 19 Aug 2022 03:52:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2B97082AAA;
	Fri, 19 Aug 2022 03:52:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2B97082AAA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE258C0033;
	Fri, 19 Aug 2022 03:52:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B7C0C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 03:52:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0FAD8400F6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 03:52:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0FAD8400F6
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YJc4srxN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o1g8DVbks6aD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 03:52:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E649E400F2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E649E400F2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 03:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660881169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WAJAq5ZihTLOBrM5eMh7GMiTFrZ/R9PeAnxxmgtqE5k=;
 b=YJc4srxN6S/QkExrilwfMjE/WT759WyCja11FSicy5LPIXzAxATt6pFjtDsvQJFmy7Rd/m
 fx6G4YqNeLKZVoL5pMLp0vSqSmIduNIu7gAZYMEctFhYQhMML1qWbaSnuD71qDeZLzG8Fp
 YZye7wy96O5mHrm+u+hboYJWoPgDX0k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-583-m5jzJ5BPPXiZouWI1gVZjw-1; Thu, 18 Aug 2022 23:52:48 -0400
X-MC-Unique: m5jzJ5BPPXiZouWI1gVZjw-1
Received: by mail-wm1-f71.google.com with SMTP id
 b4-20020a05600c4e0400b003a5a96f1756so3733152wmq.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 20:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=WAJAq5ZihTLOBrM5eMh7GMiTFrZ/R9PeAnxxmgtqE5k=;
 b=mNLFlDWVDIPHoini0CJbXqa4YKGx41CZ3I0sgUzCMoAQJAIyZsMNKG7NSp8s7zDZus
 59NeB85Q3KVS8ILbLxT9OvLacyRauVk9mMkhY3PfB/aOdOlJ+48/yOKJVZE7yvIJvvcP
 nmBKS3kZUgZyT5qT7FtuJwrPs101Xvchvj7ze2uzv0jBxHFl2r1RYfXJTljRISgJmhgM
 i9T+jJ1ZgNyB+ydIw7oZSTiT2ZbZDk5gYGRQbgbDjcvY/4v8ledc/cUinMGYGfQaWy7X
 C0JUOgSwWgeMyQGYHDYHA99RPtSESVthoEx8cuucQ/CS2IKl3fXgybvViRMyf/8mnoX1
 I7Gw==
X-Gm-Message-State: ACgBeo1+UvrVyWQxL17EexBpncrOpEAE+C4r3HBqhcCyxPNJSFO3Aex8
 91+tdx7Fdjjf7kyFl3P7V0s7fAy0cdnoszoYlYWHAtIWOoa//F5113p+ifg7Y5pKyuUnonLld99
 l2wkKezywNJm1OJBIPoXCKnRtxSGZOtifidb/ORLR1g==
X-Received: by 2002:a05:600c:42c3:b0:3a6:431:91bf with SMTP id
 j3-20020a05600c42c300b003a6043191bfmr6340487wme.188.1660881167145; 
 Thu, 18 Aug 2022 20:52:47 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7ZHWj35Cj7E6zxbO8e4bqs00d+Oyu5ZJti0Zd52xBJf2ZL+sVz7snvXxLdwTTpqO7aJUjHWw==
X-Received: by 2002:a05:600c:42c3:b0:3a6:431:91bf with SMTP id
 j3-20020a05600c42c300b003a6043191bfmr6340471wme.188.1660881166864; 
 Thu, 18 Aug 2022 20:52:46 -0700 (PDT)
Received: from redhat.com ([181.214.206.203]) by smtp.gmail.com with ESMTPSA id
 r6-20020a05600c35c600b003a626055569sm4064206wmq.16.2022.08.18.20.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Aug 2022 20:52:45 -0700 (PDT)
Date: Thu, 18 Aug 2022 23:52:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/2] vDPA: conditionally read fields in virtio-net dev
Message-ID: <20220818235137-mutt-send-email-mst@kernel.org>
References: <892b39d6-85f8-bff5-030d-e21288975572@oracle.com>
 <52a47bc7-bf26-b8f9-257f-7dc5cea66d23@intel.com>
 <20220817045406-mutt-send-email-mst@kernel.org>
 <a91fa479-d1cc-a2d6-0821-93386069a2c1@intel.com>
 <20220817053821-mutt-send-email-mst@kernel.org>
 <449c2fb2-3920-7bf9-8c5c-a68456dfea76@intel.com>
 <20220817063450-mutt-send-email-mst@kernel.org>
 <54aa5a5c-69e2-d372-3e0c-b87f595d213c@redhat.com>
 <f0b6ea5c-1783-96d2-2d9f-e5cf726b0fc0@oracle.com>
 <CACGkMEumKfktMUJOTUYL_JYkFbw8qH331gGARPB2bTH=7wKWPg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEumKfktMUJOTUYL_JYkFbw8qH331gGARPB2bTH=7wKWPg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm <kvm@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yongji Xie <xieyongji@bytedance.com>, "Dawar, Gautam" <gautam.dawar@amd.com>,
 "Zhu, Lingshan" <lingshan.zhu@intel.com>
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

T24gRnJpLCBBdWcgMTksIDIwMjIgYXQgMDg6NDI6MzJBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBGcmksIEF1ZyAxOSwgMjAyMiBhdCA3OjIwIEFNIFNpLVdlaSBMaXUgPHNpLXdlaS5s
aXVAb3JhY2xlLmNvbT4gd3JvdGU6Cj4gPgo+ID4KPiA+Cj4gPiBPbiA4LzE3LzIwMjIgOToxNSBQ
TSwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4KPiA+ID4g5ZyoIDIwMjIvOC8xNyAxODozNywgTWlj
aGFlbCBTLiBUc2lya2luIOWGmemBkzoKPiA+ID4+IE9uIFdlZCwgQXVnIDE3LCAyMDIyIGF0IDA1
OjQzOjIyUE0gKzA4MDAsIFpodSwgTGluZ3NoYW4gd3JvdGU6Cj4gPiA+Pj4KPiA+ID4+PiBPbiA4
LzE3LzIwMjIgNTozOSBQTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4gPj4+PiBPbiBX
ZWQsIEF1ZyAxNywgMjAyMiBhdCAwNToxMzo1OVBNICswODAwLCBaaHUsIExpbmdzaGFuIHdyb3Rl
Ogo+ID4gPj4+Pj4gT24gOC8xNy8yMDIyIDQ6NTUgUE0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90
ZToKPiA+ID4+Pj4+PiBPbiBXZWQsIEF1ZyAxNywgMjAyMiBhdCAxMDoxNDoyNkFNICswODAwLCBa
aHUsIExpbmdzaGFuIHdyb3RlOgo+ID4gPj4+Pj4+PiBZZXMgaXQgaXMgYSBsaXR0bGUgbWVzc3ks
IGFuZCB3ZSBjYW4gbm90IGNoZWNrIF9GX1ZFUlNJT05fMQo+ID4gPj4+Pj4+PiBiZWNhdXNlIG9m
Cj4gPiA+Pj4+Pj4+IHRyYW5zaXRpb25hbCBkZXZpY2VzLCBzbyBtYXliZSB0aGlzIGlzIHRoZSBi
ZXN0IHdlIGNhbiBkbyBmb3Igbm93Cj4gPiA+Pj4+Pj4gSSB0aGluayB2aG9zdCBnZW5lcmFsbHkg
bmVlZHMgYW4gQVBJIHRvIGRlY2xhcmUgY29uZmlnIHNwYWNlCj4gPiA+Pj4+Pj4gZW5kaWFuLW5l
c3MKPiA+ID4+Pj4+PiB0byBrZXJuZWwuIHZkcGEgY2FuIHJldXNlIHRoYXQgdG9vIHRoZW4uCj4g
PiA+Pj4+PiBZZXMsIEkgcmVtZW1iZXIgeW91IGhhdmUgbWVudGlvbmVkIHNvbWUgSU9DVEwgdG8g
c2V0IHRoZSBlbmRpYW4tbmVzcywKPiA+ID4+Pj4+IGZvciB2RFBBLCBJIHRoaW5rIG9ubHkgdGhl
IHZlbmRvciBkcml2ZXIga25vd3MgdGhlIGVuZGlhbiwKPiA+ID4+Pj4+IHNvIHdlIG1heSBuZWVk
IGEgbmV3IGZ1bmN0aW9uIHZkcGFfb3BzLT5nZXRfZW5kaWFuKCkuCj4gPiA+Pj4+PiBJbiB0aGUg
bGFzdCB0aHJlYWQsIHdlIHNheSBtYXliZSBpdCdzIGJldHRlciB0byBhZGQgYSBjb21tZW50IGZv
cgo+ID4gPj4+Pj4gbm93Lgo+ID4gPj4+Pj4gQnV0IGlmIHlvdSB0aGluayB3ZSBzaG91bGQgYWRk
IGEgdmRwYV9vcHMtPmdldF9lbmRpYW4oKSwgSSBjYW4gd29yawo+ID4gPj4+Pj4gb24gaXQgZm9y
IHN1cmUhCj4gPiA+Pj4+Pgo+ID4gPj4+Pj4gVGhhbmtzCj4gPiA+Pj4+PiBaaHUgTGluZ3NoYW4K
PiA+ID4+Pj4gSSB0aGluayBRRU1VIGhhcyB0byBzZXQgZW5kaWFuLW5lc3MuIE5vIG9uZSBlbHNl
IGtub3dzLgo+ID4gPj4+IFllcywgZm9yIFNXIGJhc2VkIHZob3N0IGl0IGlzIHRydWUuIEJ1dCBm
b3IgSFcgdkRQQSwgb25seQo+ID4gPj4+IHRoZSBkZXZpY2UgJiBkcml2ZXIga25vd3MgdGhlIGVu
ZGlhbiwgSSB0aGluayB3ZSBjYW4gbm90Cj4gPiA+Pj4gInNldCIgYSBoYXJkd2FyZSdzIGVuZGlh
bi4KPiA+ID4+IFFFTVUga25vd3MgdGhlIGd1ZXN0IGVuZGlhbi1uZXNzIGFuZCBpdCBrbm93cyB0
aGF0Cj4gPiA+PiBkZXZpY2UgaXMgYWNjZXNzZWQgdGhyb3VnaCB0aGUgbGVnYWN5IGludGVyZmFj
ZS4KPiA+ID4+IEl0IGNhbiBhY2NvcmRpbmdseSBzZW5kIGVuZGlhbi1uZXNzIHRvIHRoZSBrZXJu
ZWwgYW5kCj4gPiA+PiBrZXJuZWwgY2FuIHByb3BhZ2F0ZSBpdCB0byB0aGUgZHJpdmVyLgo+ID4g
Pgo+ID4gPgo+ID4gPiBJIHdvbmRlciBpZiB3ZSBjYW4gc2ltcGx5IGZvcmNlIExFIGFuZCB0aGVu
IFFlbXUgY2FuIGRvIHRoZSBlbmRpYW4KPiA+ID4gY29udmVyc2lvbj8KPiA+IGNvbnZlcnQgZnJv
bSBMRSBmb3IgY29uZmlnIHNwYWNlIGZpZWxkcyBvbmx5LCBvciBRRU1VIGhhcyB0byBmb3JjZWZ1
bGx5Cj4gPiBtZWRpYXRlIGFuZCBjb3ZlcnQgZW5kaWFubmVzcyBmb3IgYWxsIGRldmljZSBtZW1v
cnkgYWNjZXNzIGluY2x1ZGluZwo+ID4gZXZlbiB0aGUgZGF0YXBhdGggKGZpZWxkcyBpbiBkZXNj
cmlwdG9yIGFuZCBhdmFpbC91c2VkIHJpbmdzKT8KPiAKPiBGb3JtZXIuIEFjdHVhbGx5LCBJIHdh
bnQgdG8gZm9yY2UgbW9kZXJuIGRldmljZXMgZm9yIHZEUEEgd2hlbgo+IGRldmVsb3BpbmcgdGhl
IHZEUEEgZnJhbWV3b3JrLiBCdXQgdGhlbiB3ZSBzZWUgcmVxdWlyZW1lbnRzIGZvcgo+IHRyYW5z
aXRpb25hbCBvciBldmVuIGxlZ2FjeSAoZS5nIHRoZSBBbGkgRU5JIHBhcmVudCkuIFNvIGl0Cj4g
Y29tcGxpY2F0ZXMgdGhpbmdzIGEgbG90Lgo+IAo+IEkgdGhpbmsgc2V2ZXJhbCBpZGVhcyBoYXMg
YmVlbiBwcm9wb3NlZDoKPiAKPiAxKSBZb3VyIHByb3Bvc2FsIG9mIGhhdmluZyBhIHZEUEEgc3Bl
Y2lmaWMgd2F5IGZvcgo+IG1vZGVybi90cmFuc2l0aW9uYWwvbGVnYWN5IGF3YXJlbmVzcy4gVGhp
cyBzZWVtcyB2ZXJ5IGNsZWFuIHNpbmNlIGVhY2gKPiB0cmFuc3BvcnQgc2hvdWxkIGhhdmUgdGhl
IGFiaWxpdHkgdG8gZG8gdGhhdCBidXQgaXQgc3RpbGwgcmVxdWlyZXMKPiBzb21lIGtpbmQgb2Yg
bWVkaWF0aW9uIGZvciB0aGUgY2FzZSBlLmcgcnVubmluZyBCRSBsZWdhY3kgZ3Vlc3Qgb24gTEUK
PiBob3N0Lgo+IAo+IDIpIE1pY2hhZWwgc3VnZ2VzdHMgdXNpbmcgVkhPU1RfU0VUX1ZSSU5HX0VO
RElBTiB3aGVyZSBpdCBtZWFucyB3ZQo+IG5lZWQgYSBuZXcgY29uZmlnIG9wcyBmb3IgdkRQQSBi
dXMsIGJ1dCBpdCBkb2Vzbid0IHNvbHZlIHRoZSBpc3N1ZSBmb3IKPiBjb25maWcgc3BhY2UgKGF0
IGxlYXN0IGZyb20gaXRzIG5hbWUpLiBXZSBwcm9iYWJseSBuZWVkIGEgbmV3IGlvY3RsCj4gZm9y
IGJvdGggdnJpbmcgYW5kIGNvbmZpZyBzcGFjZS4KPiAKPiBvcgoKClllYSwgbGlrZSBWSE9TVF9T
RVRfQ09ORklHX0VORElBTi4KCgoKPiAzKSByZXZpc2l0IHRoZSBpZGVhIG9mIGZvcmNpbmcgbW9k
ZXJuIG9ubHkgZGV2aWNlIHdoaWNoIG1heSBzaW1wbGlmeQo+IHRoaW5ncyBhIGxvdAoKUHJvYmxl
bSBpcyB2aG9zdCBuZWVkcyBWSE9TVF9TRVRfQ09ORklHX0VORElBTiB0b28uIGl0J3Mgbm90CmEg
dmRwYSBzcGVjaWZpYyBpc3N1ZS4KCj4gd2hpY2ggd2F5IHNob3VsZCB3ZSBnbz8KPiAKPiA+IEkg
aG9wZQo+ID4gaXQncyBub3QgdGhlIGxhdHRlciwgb3RoZXJ3aXNlIGl0IGxvc2VzIHRoZSBwb2lu
dCB0byB1c2UgdkRQQSBmb3IKPiA+IGRhdGFwYXRoIGFjY2VsZXJhdGlvbi4KPiA+Cj4gPiBFdmVu
IGlmIGl0cyB0aGUgZm9ybWVyLCBpdCdzIGEgbGl0dGxlIHdlaXJkIGZvciB2ZW5kb3IgZGV2aWNl
IHRvCj4gPiBpbXBsZW1lbnQgYSBMRSBjb25maWcgc3BhY2Ugd2l0aCBCRSByaW5nIGxheW91dCwg
YWx0aG91Z2ggc3RpbGwgcG9zc2libGUuLi4KPiAKPiBSaWdodC4KPiAKPiBUaGFua3MKPiAKPiA+
Cj4gPiAtU2l3ZWkKPiA+ID4KPiA+ID4gVGhhbmtzCj4gPiA+Cj4gPiA+Cj4gPiA+Pgo+ID4gPj4+
IFNvIGlmIHlvdSB0aGluayB3ZSBzaG91bGQgYWRkIGEgdmRwYV9vcHMtPmdldF9lbmRpYW4oKSwK
PiA+ID4+PiBJIHdpbGwgZHJvcCB0aGVzZSBjb21tZW50cyBpbiB0aGUgbmV4dCB2ZXJzaW9uIG9m
Cj4gPiA+Pj4gc2VyaWVzLCBhbmQgd29yayBvbiBhIG5ldyBwYXRjaCBmb3IgZ2V0X2VuZGlhbigp
Lgo+ID4gPj4+Cj4gPiA+Pj4gVGhhbmtzLAo+ID4gPj4+IFpodSBMaW5nc2hhbgo+ID4gPj4gR3Vl
c3RzIGRvbid0IGdldCBlbmRpYW4tbmVzcyBmcm9tIGRldmljZXMgc28gdGhpcyBzZWVtcyBwb2lu
dGxlc3MuCj4gPiA+Pgo+ID4gPgo+ID4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
