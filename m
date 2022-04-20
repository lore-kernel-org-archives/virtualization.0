Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D59C433EF
	for <virtualization@archiver.kernel.org>; Wed, 20 Apr 2022 20:18:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9529484094;
	Wed, 20 Apr 2022 20:18:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IaMTNiM_HEp2; Wed, 20 Apr 2022 20:18:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 276A1840E4;
	Wed, 20 Apr 2022 20:18:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2986C0033;
	Wed, 20 Apr 2022 20:18:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA63AC002C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 20:18:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 98AF74199E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 20:18:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nH9Nu8Wj6wII
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 20:18:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3EF554199C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 20:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650485882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7BDCEduF2hLG+f+21jzAX1565oQqqve7cOcfyOyH/30=;
 b=cV3H4B4k5esBr2M/3BLK3qR4A9UfAaZIDjTqp9PKpBngyEZkehv/N8dVTPF5g760fr1LM9
 F/yzUeW7omZVdB50RvPeYZ+LiYtZ5Cu9B/tz7E0jQgHmLex2Q/W51ZOLGaHnHtrvYjHeyG
 nP5VUcSGK+SoS56LtRXRJ22fP9kRcEg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-xm6qtXG_NxWHtA2eeT4Zug-1; Wed, 20 Apr 2022 16:18:01 -0400
X-MC-Unique: xm6qtXG_NxWHtA2eeT4Zug-1
Received: by mail-wm1-f69.google.com with SMTP id
 k66-20020a1ca145000000b003928959f8efso2163177wme.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 13:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=7BDCEduF2hLG+f+21jzAX1565oQqqve7cOcfyOyH/30=;
 b=F5GuYdF0h+oUdYcQVYUQq7AFFaFRPY3DzoAfqTSKPamRtWzbwCwc77aHHyg1wTeYog
 Zn5GBx5cuPf4+gWQzgarqvr4B928twgEnYRZXy4EcJ0owjOU+eA1XlODS4XOTz5pwjoZ
 fhbaKL28vYQnKEIqdlOKtGisah9mSca1jBzLm+jG8w8N0ErFtCM71y1cNJ8sDG0fmIUA
 hoof8OlRV+LNHqtbRJCbQ91Md+wP4SgzZcprGPWoNk07lBFttaiJmmX2pV0FdC0jsEaa
 lxCgzZK/rEZju0hlcYBmaaQ8g8JZrwflQyfSZ+ryD2bWLliXNXaT9XGn7riYR574ofnV
 XE+w==
X-Gm-Message-State: AOAM530TF3vvrHlKa7Lh/ppkS/fwW7ScfFswv2WSRwfJc7wsm1vOhyYS
 SHUIVo8dHjrIAoTEteePRD94Yi5ntB4hpWGserJRGUlST6qxBZyHtQAsDHPI5booesx7U4Ss5F4
 0Z59hN91/vm7GWzU2UAtiEer3GX2vOov6/GaYscOECg==
X-Received: by 2002:adf:ee81:0:b0:206:1b32:d6f2 with SMTP id
 b1-20020adfee81000000b002061b32d6f2mr16365085wro.144.1650485880374; 
 Wed, 20 Apr 2022 13:18:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWYCrpe+5LHKhzY94bqgzwTWdcr4U5oHV7BL5KV+n1AGJ3VLhcAcVWQs2sI+pPp7LT2Azplg==
X-Received: by 2002:adf:ee81:0:b0:206:1b32:d6f2 with SMTP id
 b1-20020adfee81000000b002061b32d6f2mr16365077wro.144.1650485880112; 
 Wed, 20 Apr 2022 13:18:00 -0700 (PDT)
Received: from redhat.com ([2.53.17.80]) by smtp.gmail.com with ESMTPSA id
 a9-20020a7bc1c9000000b0038eb67e966esm284461wmj.29.2022.04.20.13.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Apr 2022 13:17:59 -0700 (PDT)
Date: Wed, 20 Apr 2022 16:17:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maciej =?utf-8?Q?Szyma=C5=84ski?= <maciej.szymanski@opensynergy.com>
Subject: Re: virtio-net: Unpermitted usage of virtqueue before virtio driver
 initialization
Message-ID: <20220420161042-mutt-send-email-mst@kernel.org>
References: <20220419103826-mutt-send-email-mst@kernel.org>
 <CACGkMEvJu8ADk=+QJryDfuh9y8pXzfYQ3KRg0Lq0POH3Z-SHuQ@mail.gmail.com>
 <20220420023511-mutt-send-email-mst@kernel.org>
 <4080d799-b42e-018a-8b14-621295e55a8d@opensynergy.com>
 <b4899534-8c08-ddfc-dea0-460a94b00c32@redhat.com>
 <0a118236-bb98-9183-8be2-84f6b83e2581@opensynergy.com>
 <20220420070944-mutt-send-email-mst@kernel.org>
 <4050a523-85a8-0f3c-b7de-c371a42c8f6c@opensynergy.com>
 <20220420134755-mutt-send-email-mst@kernel.org>
 <06dc4f89-1770-67cc-a843-6e956c0504dc@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <06dc4f89-1770-67cc-a843-6e956c0504dc@opensynergy.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Willem de Bruijn <willemb@google.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

T24gV2VkLCBBcHIgMjAsIDIwMjIgYXQgMDg6NTc6MThQTSArMDIwMCwgTWFjaWVqIFN6eW1hxYRz
a2kgd3JvdGU6Cj4gT24gMjAuMDQuMjAyMiAxOTo1NCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Ogo+ID4gT24gV2VkLCBBcHIgMjAsIDIwMjIgYXQgMDQ6NTg6NTFQTSArMDIwMCwgTWFjaWVqIFN6
eW1hxYRza2kgd3JvdGU6Cj4gPiA+IE9uIDIwLjA0LjIwMjIgMTM6MTAsIE1pY2hhZWwgUy4gVHNp
cmtpbiB3cm90ZToKPiA+ID4gPiBPbiBXZWQsIEFwciAyMCwgMjAyMiBhdCAxMDoxNzoyN0FNICsw
MjAwLCBNYWNpZWogU3p5bWHFhHNraSB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiBIbW0gc28g
d2UgaGF2ZSB0aGlzOgo+ID4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiA+IAo+
ID4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgaWYgKChkZXYtPmZlYXR1cmVzIF4gZmVhdHVy
ZXMpICYgTkVUSUZfRl9HUk9fSFcpIHsKPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAg
ICAgICAgaWYgKHZpLT54ZHBfZW5hYmxlZCkKPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gLUVCVVNZOwo+ID4gPiA+ID4gPiA+ID4gPiA+IAo+ID4g
PiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICBpZiAoZmVhdHVyZXMgJiBORVRJRl9G
X0dST19IVykKPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICBv
ZmZsb2FkcyA9IHZpLT5ndWVzdF9vZmZsb2Fkc19jYXBhYmxlOwo+ID4gPiA+ID4gPiA+ID4gPiA+
ICAgICAgICAgICAgICAgICAgICBlbHNlCj4gPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgb2ZmbG9hZHMgPSB2aS0+Z3Vlc3Rfb2ZmbG9hZHNfY2FwYWJsZSAmCj4g
PiA+ID4gPiA+ID4gPiA+ID4gfkdVRVNUX09GRkxPQURfR1JPX0hXX01BU0s7Cj4gPiA+ID4gPiA+
ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgIGVyciA9IHZp
cnRuZXRfc2V0X2d1ZXN0X29mZmxvYWRzKHZpLCBvZmZsb2Fkcyk7Cj4gPiA+ID4gPiA+ID4gPiA+
ID4gICAgICAgICAgICAgICAgICAgIGlmIChlcnIpCj4gPiA+ID4gPiA+ID4gPiA+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGVycjsKPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAg
ICAgICAgICAgICAgICAgdmktPmd1ZXN0X29mZmxvYWRzID0gb2ZmbG9hZHM7Cj4gPiA+ID4gPiA+
ID4gPiA+ID4gICAgICAgICAgICB9Cj4gPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4g
PiA+ID4gd2hpY2ggSSBndWVzcyBzaG91bGQgaGF2ZSBwcmV2ZW50ZWQgdmlydG5ldF9zZXRfZ3Vl
c3Rfb2ZmbG9hZHMKPiA+ID4gPiA+ID4gPiA+ID4gPiBmcm9tIGV2ZXIgcnVubmluZy4KPiA+ID4g
PiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gPiAgICBGcm9tIHlvdXIgZGVzY3JpcHRp
b24gaXQgc291bmRzIGxpa2UgeW91IGhhdmUgb2JzZXJ2ZWQgdGhpcwo+ID4gPiA+ID4gPiA+ID4g
PiA+IGluIHByYWN0aWNlLCByaWdodD8KPiA+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4g
PiBZZXMuIEkgaGF2ZSBwcm9wcmlldGFyeSB2aXJ0aW8tbmV0IGRldmljZSB3aGljaCBhZHZlcnRp
c2VzIGZvbGxvd2luZwo+ID4gPiA+ID4gPiA+IGd1ZXN0IG9mZmxvYWQgZmVhdHVyZXMgOgo+ID4g
PiA+ID4gPiA+IC0gVklSVElPX05FVF9GX0dVRVNUX0NTVU0KPiA+ID4gPiA+ID4gPiAtIFZJUlRJ
T19ORVRfRl9HVUVTVF9UU080Cj4gPiA+ID4gPiA+ID4gLSBWSVJUSU9fTkVUX0ZfR1VFU1RfVFNP
Ngo+ID4gPiA+ID4gPiA+IC0gVklSVElPX05FVF9GX0dVRVNUX1VGTwo+ID4gPiA+ID4gPiA+IAo+
ID4gPiA+ID4gPiA+IFRoaXMgZmVhdHVyZSBzZXQgcGFzc2VzIHRoZSBjb25kaXRpb24gaW4gdmly
dG5ldF9zZXRfZmVhdHVyZXMuCj4gPiA+ID4gU28gd2h5IGlzbid0IGRldi0+ZmVhdHVyZXMgZXF1
YWwgdG8gZmVhdHVyZXM/Cj4gPiA+ID4gCj4gPiA+IEkganVzdCBkb3VibGUgdmVyaWZpZWQgYW5k
IGZvdW5kIHRoYXQgbXkgZGV2aWNlIGFkdmVydGlzZXMKPiA+ID4gVklSVElPX05FVF9HVUVTVF9U
U080IGFuZCBWSVJUSU9fTkVUX0ZfR1VFU1RfVFNPNiBidXQgbm90Cj4gPiA+IFZJUlRJT19ORVRf
Rl9HVUVTVF9DU1VNIGFzIG1lbnRpb25lZCBiZWZvcmUuCj4gPiBTbywgeW91ciBkZXZpY2UgaXMg
b3V0IG9mIHNwZWM6Cj4gPiAKPiA+IFZJUlRJT19ORVRfRl9HVUVTVF9UU080IFJlcXVpcmVzIFZJ
UlRJT19ORVRfRl9HVUVTVF9DU1VNLgo+ID4gCj4gPiBBbmQKPiA+IAo+ID4gVGhlIGRldmljZSBN
VVNUIE5PVCBvZmZlciBhIGZlYXR1cmUgd2hpY2ggcmVxdWlyZXMgYW5vdGhlciBmZWF0dXJlIHdo
aWNoIHdhcyBub3Qgb2ZmZXJlZC4KPiA+IAo+ID4gCj4gPiBJcyB0aGlzIGEgcHJvZHVjdGlvbiBk
ZXZpY2U/IENhbiBpdCBiZSBmaXhlZD8KPiBUaGUgcHJvYmxlbSBzZWVtcyB0byBiZSBtb3JlIGNv
bXBsaWNhdGVkLiBJbiBmYWN0Cj4gVklSVElPX05FVF9GX0dVRVNUX0NTVU0gaXMgb2ZmZXJlZCBi
eSBvdXIgZGV2aWNlLCBidXQgZHVyaW5nIGZlYXR1cmUKPiBuZWdvdGlhdGlvbiBpdCBpcyBiZWlu
ZyBkcm9wcGVkLgo+IFRoaXMgbW9zdCBsaWtlbHkgZG9lcyBub3QgaGFwcGVuIHdoZW4gd2UgdXNl
IE1NSU8sIGJ1dCBmb3Igc29tZSByZWFzb24KPiBoYXBwZW5zIGluIFFFTVUgZm9yIFZIT1NUX1VT
RVIgKyBQQ0kuCj4gSSBuZWVkIHRvIGludmVzdGlnYXRlIHRoaXMgbW9yZSBkZWVwbHkuLi4KCgpJ
IGRvbid0IHNlZSB3aGVyZSBsaW51eCB3b3VsZCBkcm9wIGl0LiBJIHN1c3BlY3QgaXQncyBkcm9w
cGVkIGJldHdlZW4KUUVNVSBhbmQgdmhvc3QgdXNlci4gSSdkIHNheSBsZXQncyBmaXggaXQgaW4g
dGhlIGRldmljZSBmaXJzdC4KV2UgY2FuIG5leHQgY29uc2lkZXIgbWFya2luZyB2cXMgYnJva2Vu
IGJlZm9yZSBkZXZpY2UgaXMgcmVhZHkgLQpKYXNvbiB3aGF0IGRvIHlvdSB0aGluaz8KRmluYWxs
eSwgd2UgY2FuIGFkZCBjb2RlIHRvIGF2b2lkIGFja2luZyBkZXBlbmRlbnQgZmVhdHVyZXMKaWYg
dGhlIGZlYXR1cmUgdGhleSBkZXBlbmQgb24gaGFzIG5vdCBiZWVuIG5lZ290aWF0ZWQgLSBkb2lu
ZwpzbyBpcyBhbHNvIGEgc3BlYyB2aW9sYXRpb24gYWZ0ZXIgYWxsLgoKCj4gCj4gPiAKPiA+ID4g
VGhhdCBsZWFkcyB0byB0aGUgZm9sbG93aW5nIHNpdHVhdGlvbiA6Cj4gPiA+IAo+ID4gPiBpbiB2
aXJ0aW9fcHJvYmUgOgo+ID4gPiAKPiA+ID4gICAgaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2
LCBWSVJUSU9fTkVUX0ZfR1VFU1RfQ1NVTSkpCj4gPiA+ICAgICAgZGV2LT5mZWF0dXJlcyB8PSBO
RVRJRl9GX1JYQ1NVTTsKPiA+ID4gICAgaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJU
SU9fTkVUX0ZfR1VFU1RfVFNPNCkgfHwKPiA+ID4gICAgICAgIHZpcnRpb19oYXNfZmVhdHVyZSh2
ZGV2LCBWSVJUSU9fTkVUX0ZfR1VFU1RfVFNPNikpCj4gPiA+ICAgICAgZGV2LT5mZWF0dXJlcyB8
PSBORVRJRl9GX0dST19IVzsKPiA+ID4gICAgaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBW
SVJUSU9fTkVUX0ZfQ1RSTF9HVUVTVF9PRkZMT0FEUykpCj4gPiA+ICAgICAgZGV2LT5od19mZWF0
dXJlcyB8PSBORVRJRl9GX0dST19IVzsKPiA+ID4gCj4gPiA+IAo+ID4gPiB3aGlsZSBpbiBuZXRk
ZXZfZml4X2ZlYXR1cmVzIDoKPiA+ID4gCj4gPiA+ICAgIGlmICghKGZlYXR1cmVzICYgTkVUSUZf
Rl9SWENTVU0pKSB7Cj4gPiA+ICAgICAgLyogTkVUSUZfRl9HUk9fSFcgaW1wbGllcyBkb2luZyBS
WENTVU0gc2luY2UgZXZlcnkgcGFja2V0Cj4gPiA+ICAgICAgICogc3VjY2Vzc2Z1bGx5IG1lcmdl
ZCBieSBoYXJkd2FyZSBtdXN0IGFsc28gaGF2ZSB0aGUKPiA+ID4gICAgICAgKiBjaGVja3N1bSB2
ZXJpZmllZCBieSBoYXJkd2FyZS4gIElmIHRoZSB1c2VyIGRvZXMgbm90Cj4gPiA+ICAgICAgICog
d2FudCB0byBlbmFibGUgUlhDU1VNLCBsb2dpY2FsbHksIHdlIHNob3VsZCBkaXNhYmxlIEdST19I
Vy4KPiA+ID4gICAgICAgKi8KPiA+ID4gICAgICBpZiAoZmVhdHVyZXMgJiBORVRJRl9GX0dST19I
Vykgewo+ID4gPiAgICAgICAgbmV0ZGV2X2RiZyhkZXYsICJEcm9wcGluZyBORVRJRl9GX0dST19I
VyBzaW5jZSBubyBSWENTVU0KPiA+ID4gZmVhdHVyZS5cbiIpOwo+ID4gPiAgICAgICAgZmVhdHVy
ZXMgJj0gfk5FVElGX0ZfR1JPX0hXOwo+ID4gPiAgICAgIH0KPiA+ID4gICAgfQo+ID4gPiAKPiA+
ID4gQXMgcmVzdWx0IGRldi0+ZmVhdHVyZXMgYW5kIGZlYXR1cmVzIHBhc3NlZCBmcm9tCj4gPiA+
IF9fbmV0ZGV2X3VwZGF0ZV9mZWF0dXJlcyBkaWZmZXJzIGV4YWN0bHkgaW4gTkVUSUZfRl9HUk9f
SFcgYml0Lgo+ID4gPiAKPiA+ID4gCj4gPiA+IFBsZWFzZSBtaW5kIG91ciBwcml2YWN5IG5vdGlj
ZTxodHRwczovL3d3dy5vcGVuc3luZXJneS5jb20vZGF0ZW5zY2h1dHplcmtsYWVydW5nL3ByaXZh
Y3ktbm90aWNlLWZvci1idXNpbmVzcy1wYXJ0bmVycy1wdXJzdWFudC10by1hcnRpY2xlLTEzLW9m
LXRoZS1nZW5lcmFsLWRhdGEtcHJvdGVjdGlvbi1yZWd1bGF0aW9uLWdkcHIvPiBwdXJzdWFudCB0
byBBcnQuIDEzIEdEUFIuIC8vIFVuc2VyZSBIaW53ZWlzZSB6dW0gRGF0ZW5zY2h1dHogZ2VtLiBB
cnQuIDEzIERTR1ZPIGZpbmRlbiBTaWUgaGllci48aHR0cHM6Ly93d3cub3BlbnN5bmVyZ3kuY29t
L2RlL2RhdGVuc2NodXR6ZXJrbGFlcnVuZy9kYXRlbnNjaHV0emhpbndlaXNlLWZ1ZXItZ2VzY2hh
ZWZ0c3BhcnRuZXItZ2VtLWFydC0xMy1kc2d2by8+Cj4gCj4gCj4gUGxlYXNlIG1pbmQgb3VyIHBy
aXZhY3kgbm90aWNlPGh0dHBzOi8vd3d3Lm9wZW5zeW5lcmd5LmNvbS9kYXRlbnNjaHV0emVya2xh
ZXJ1bmcvcHJpdmFjeS1ub3RpY2UtZm9yLWJ1c2luZXNzLXBhcnRuZXJzLXB1cnN1YW50LXRvLWFy
dGljbGUtMTMtb2YtdGhlLWdlbmVyYWwtZGF0YS1wcm90ZWN0aW9uLXJlZ3VsYXRpb24tZ2Rwci8+
IHB1cnN1YW50IHRvIEFydC4gMTMgR0RQUi4gLy8gVW5zZXJlIEhpbndlaXNlIHp1bSBEYXRlbnNj
aHV0eiBnZW0uIEFydC4gMTMgRFNHVk8gZmluZGVuIFNpZSBoaWVyLjxodHRwczovL3d3dy5vcGVu
c3luZXJneS5jb20vZGUvZGF0ZW5zY2h1dHplcmtsYWVydW5nL2RhdGVuc2NodXR6aGlud2Vpc2Ut
ZnVlci1nZXNjaGFlZnRzcGFydG5lci1nZW0tYXJ0LTEzLWRzZ3ZvLz4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
