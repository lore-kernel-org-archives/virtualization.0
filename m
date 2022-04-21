Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5E7C433EF
	for <virtualization@archiver.kernel.org>; Thu, 21 Apr 2022 02:48:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AEC8E84023;
	Thu, 21 Apr 2022 02:48:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NHTpWmU8me97; Thu, 21 Apr 2022 02:48:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0DEA283FF0;
	Thu, 21 Apr 2022 02:48:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D44C7C0033;
	Thu, 21 Apr 2022 02:48:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C08BDC002C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 02:48:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 99D8A84016
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 02:48:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IWAOckAm-84R
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 02:48:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 639BC83FF0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 02:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650509290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x65C/BsOCGKFAgzhMTsmgqdwuNQxzhSXJ3tCydLTlus=;
 b=AGOobwK4Lm53D+GAfVfVKeX4LkzGulfqRV985D+ml2Fce+wZirRrAYdITc7Fy02WM0R9RZ
 aND1ALb4I48FN3YPtB+vxYUVb5lBOeu2O2IAfB3KlunyElugdugnCkH5hb1d8dujf//FtX
 J7VAr3zNG6xfUhHMH5Qzz6tFxrZ/OeM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-pwhs2EGxP1Kt8XKzc5PGHw-1; Wed, 20 Apr 2022 22:48:09 -0400
X-MC-Unique: pwhs2EGxP1Kt8XKzc5PGHw-1
Received: by mail-lf1-f71.google.com with SMTP id
 br31-20020a056512401f00b00471c57013ceso488871lfb.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 19:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=x65C/BsOCGKFAgzhMTsmgqdwuNQxzhSXJ3tCydLTlus=;
 b=z2pTUC9jMovaDvZVwaU9V+eCMZCYe9QqfPC7FMuV9fA5S4a8LuQjj+bbqgFUSyBIuD
 FcKKsrJauDwQvr/N1heQ+TeHThYD1lZ3SFN/FwCyVZwM6dU+DSG84fBZek5+7ZUMk+7N
 nLimmkXDOlj/VN4e2aVpqdyYjhOitTqyX8DGiXwFDWtPLwDW1ZDegDcc5PrmngxSxVJT
 pUQMgLO7vbsLSPg2YacwckyjA2oSjZwYCPiQljwd9uGhgN2qPe2Yb60F3uRv/FHW5reG
 WAgRcHnH2CmVbosxAgyDermhqYwvUi4I6Cvee7e3HvWq7zWRCcWCtwQ7sK2FCrbmX1R9
 Tk6A==
X-Gm-Message-State: AOAM531pdUnHf0RsDeir/gGt5LMQcSkAhU0/WuQb8+D1+HXCCINcXDm+
 jIhLmXtwS9l8lElIq8i/aWULNNZ8k5wCgFPZCvQzFW/hBb5D/zsfmlY3tACAA4rT7TVt7vysVt9
 blJTjurBFYdhJZRsvJmzTjix250Kbp/U+v72d/pdPOIS83YcBU4O36sAJ8A==
X-Received: by 2002:a05:6512:a8f:b0:471:948b:9b6b with SMTP id
 m15-20020a0565120a8f00b00471948b9b6bmr11829274lfu.471.1650509287673; 
 Wed, 20 Apr 2022 19:48:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCX1Hv4DIUoMsxJZ9l/xvCmnHW1V+knDem2vxCi4L6bfSgTVF/gjRryFIdkGoNUlG/ULlO7pBlZQ6qgoHl36A=
X-Received: by 2002:a05:6512:a8f:b0:471:948b:9b6b with SMTP id
 m15-20020a0565120a8f00b00471948b9b6bmr11829262lfu.471.1650509287477; Wed, 20
 Apr 2022 19:48:07 -0700 (PDT)
MIME-Version: 1.0
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
 <20220420161042-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220420161042-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Apr 2022 10:47:56 +0800
Message-ID: <CACGkMEu=9Sn_tyZ5apaxw8sWO6b3JSdbm08XLVGznB9t_XXL9A@mail.gmail.com>
Subject: Re: virtio-net: Unpermitted usage of virtqueue before virtio driver
 initialization
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Willem de Bruijn <willemb@google.com>,
 =?UTF-8?Q?Maciej_Szyma=C5=84ski?= <maciej.szymanski@opensynergy.com>,
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

T24gVGh1LCBBcHIgMjEsIDIwMjIgYXQgNDoxOCBBTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIFdlZCwgQXByIDIwLCAyMDIyIGF0IDA4OjU3OjE4UE0g
KzAyMDAsIE1hY2llaiBTenltYcWEc2tpIHdyb3RlOgo+ID4gT24gMjAuMDQuMjAyMiAxOTo1NCwg
TWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4gPiBPbiBXZWQsIEFwciAyMCwgMjAyMiBhdCAw
NDo1ODo1MVBNICswMjAwLCBNYWNpZWogU3p5bWHFhHNraSB3cm90ZToKPiA+ID4gPiBPbiAyMC4w
NC4yMDIyIDEzOjEwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+ID4gPiBPbiBXZWQs
IEFwciAyMCwgMjAyMiBhdCAxMDoxNzoyN0FNICswMjAwLCBNYWNpZWogU3p5bWHFhHNraSB3cm90
ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEhtbSBzbyB3ZSBoYXZlIHRoaXM6Cj4gPiA+ID4gPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICAg
ICAgICAgICAgaWYgKChkZXYtPmZlYXR1cmVzIF4gZmVhdHVyZXMpICYgTkVUSUZfRl9HUk9fSFcp
IHsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICBpZiAodmktPnhkcF9l
bmFibGVkKQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
cmV0dXJuIC1FQlVTWTsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiAgICAgICAgICAgICAgICAgICAgaWYgKGZlYXR1cmVzICYgTkVUSUZfRl9HUk9fSFcpCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICBvZmZsb2FkcyA9IHZp
LT5ndWVzdF9vZmZsb2Fkc19jYXBhYmxlOwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAg
ICAgICAgICAgIGVsc2UKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIG9mZmxvYWRzID0gdmktPmd1ZXN0X29mZmxvYWRzX2NhcGFibGUgJgo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gfkdVRVNUX09GRkxPQURfR1JPX0hXX01BU0s7Cj4gPiA+ID4gPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgIGVyciA9IHZpcnRu
ZXRfc2V0X2d1ZXN0X29mZmxvYWRzKHZpLCBvZmZsb2Fkcyk7Cj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiAgICAgICAgICAgICAgICAgICAgaWYgKGVycikKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBlcnI7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAg
ICAgICAgICAgICAgICAgICAgdmktPmd1ZXN0X29mZmxvYWRzID0gb2ZmbG9hZHM7Cj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiAgICAgICAgICAgIH0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiB3aGljaCBJIGd1ZXNzIHNob3VsZCBoYXZlIHByZXZlbnRlZCB2aXJ0bmV0
X3NldF9ndWVzdF9vZmZsb2Fkcwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gZnJvbSBldmVyIHJ1bm5p
bmcuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAgRnJvbSB5
b3VyIGRlc2NyaXB0aW9uIGl0IHNvdW5kcyBsaWtlIHlvdSBoYXZlIG9ic2VydmVkIHRoaXMKPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IGluIHByYWN0aWNlLCByaWdodD8KPiA+ID4gPiA+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gPiBZZXMuIEkgaGF2ZSBwcm9wcmlldGFyeSB2aXJ0aW8tbmV0IGRl
dmljZSB3aGljaCBhZHZlcnRpc2VzIGZvbGxvd2luZwo+ID4gPiA+ID4gPiA+ID4gZ3Vlc3Qgb2Zm
bG9hZCBmZWF0dXJlcyA6Cj4gPiA+ID4gPiA+ID4gPiAtIFZJUlRJT19ORVRfRl9HVUVTVF9DU1VN
Cj4gPiA+ID4gPiA+ID4gPiAtIFZJUlRJT19ORVRfRl9HVUVTVF9UU080Cj4gPiA+ID4gPiA+ID4g
PiAtIFZJUlRJT19ORVRfRl9HVUVTVF9UU082Cj4gPiA+ID4gPiA+ID4gPiAtIFZJUlRJT19ORVRf
Rl9HVUVTVF9VRk8KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBUaGlzIGZlYXR1cmUg
c2V0IHBhc3NlcyB0aGUgY29uZGl0aW9uIGluIHZpcnRuZXRfc2V0X2ZlYXR1cmVzLgo+ID4gPiA+
ID4gU28gd2h5IGlzbid0IGRldi0+ZmVhdHVyZXMgZXF1YWwgdG8gZmVhdHVyZXM/Cj4gPiA+ID4g
Pgo+ID4gPiA+IEkganVzdCBkb3VibGUgdmVyaWZpZWQgYW5kIGZvdW5kIHRoYXQgbXkgZGV2aWNl
IGFkdmVydGlzZXMKPiA+ID4gPiBWSVJUSU9fTkVUX0dVRVNUX1RTTzQgYW5kIFZJUlRJT19ORVRf
Rl9HVUVTVF9UU082IGJ1dCBub3QKPiA+ID4gPiBWSVJUSU9fTkVUX0ZfR1VFU1RfQ1NVTSBhcyBt
ZW50aW9uZWQgYmVmb3JlLgo+ID4gPiBTbywgeW91ciBkZXZpY2UgaXMgb3V0IG9mIHNwZWM6Cj4g
PiA+Cj4gPiA+IFZJUlRJT19ORVRfRl9HVUVTVF9UU080IFJlcXVpcmVzIFZJUlRJT19ORVRfRl9H
VUVTVF9DU1VNLgo+ID4gPgo+ID4gPiBBbmQKPiA+ID4KPiA+ID4gVGhlIGRldmljZSBNVVNUIE5P
VCBvZmZlciBhIGZlYXR1cmUgd2hpY2ggcmVxdWlyZXMgYW5vdGhlciBmZWF0dXJlIHdoaWNoIHdh
cyBub3Qgb2ZmZXJlZC4KPiA+ID4KPiA+ID4KPiA+ID4gSXMgdGhpcyBhIHByb2R1Y3Rpb24gZGV2
aWNlPyBDYW4gaXQgYmUgZml4ZWQ/Cj4gPiBUaGUgcHJvYmxlbSBzZWVtcyB0byBiZSBtb3JlIGNv
bXBsaWNhdGVkLiBJbiBmYWN0Cj4gPiBWSVJUSU9fTkVUX0ZfR1VFU1RfQ1NVTSBpcyBvZmZlcmVk
IGJ5IG91ciBkZXZpY2UsIGJ1dCBkdXJpbmcgZmVhdHVyZQo+ID4gbmVnb3RpYXRpb24gaXQgaXMg
YmVpbmcgZHJvcHBlZC4KPiA+IFRoaXMgbW9zdCBsaWtlbHkgZG9lcyBub3QgaGFwcGVuIHdoZW4g
d2UgdXNlIE1NSU8sIGJ1dCBmb3Igc29tZSByZWFzb24KPiA+IGhhcHBlbnMgaW4gUUVNVSBmb3Ig
VkhPU1RfVVNFUiArIFBDSS4KPiA+IEkgbmVlZCB0byBpbnZlc3RpZ2F0ZSB0aGlzIG1vcmUgZGVl
cGx5Li4uCj4KPgo+IEkgZG9uJ3Qgc2VlIHdoZXJlIGxpbnV4IHdvdWxkIGRyb3AgaXQuIEkgc3Vz
cGVjdCBpdCdzIGRyb3BwZWQgYmV0d2Vlbgo+IFFFTVUgYW5kIHZob3N0IHVzZXIuIEknZCBzYXkg
bGV0J3MgZml4IGl0IGluIHRoZSBkZXZpY2UgZmlyc3QuCj4gV2UgY2FuIG5leHQgY29uc2lkZXIg
bWFya2luZyB2cXMgYnJva2VuIGJlZm9yZSBkZXZpY2UgaXMgcmVhZHkgLQo+IEphc29uIHdoYXQg
ZG8geW91IHRoaW5rPwoKWWVzLCB3ZSBjYW4gZG8gdGhhdC4KClRoYW5rcwoKPiBGaW5hbGx5LCB3
ZSBjYW4gYWRkIGNvZGUgdG8gYXZvaWQgYWNraW5nIGRlcGVuZGVudCBmZWF0dXJlcwo+IGlmIHRo
ZSBmZWF0dXJlIHRoZXkgZGVwZW5kIG9uIGhhcyBub3QgYmVlbiBuZWdvdGlhdGVkIC0gZG9pbmcK
PiBzbyBpcyBhbHNvIGEgc3BlYyB2aW9sYXRpb24gYWZ0ZXIgYWxsLgo+Cj4KPiA+Cj4gPiA+Cj4g
PiA+ID4gVGhhdCBsZWFkcyB0byB0aGUgZm9sbG93aW5nIHNpdHVhdGlvbiA6Cj4gPiA+ID4KPiA+
ID4gPiBpbiB2aXJ0aW9fcHJvYmUgOgo+ID4gPiA+Cj4gPiA+ID4gICAgaWYgKHZpcnRpb19oYXNf
ZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfR1VFU1RfQ1NVTSkpCj4gPiA+ID4gICAgICBkZXYt
PmZlYXR1cmVzIHw9IE5FVElGX0ZfUlhDU1VNOwo+ID4gPiA+ICAgIGlmICh2aXJ0aW9faGFzX2Zl
YXR1cmUodmRldiwgVklSVElPX05FVF9GX0dVRVNUX1RTTzQpIHx8Cj4gPiA+ID4gICAgICAgIHZp
cnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfR1VFU1RfVFNPNikpCj4gPiA+ID4g
ICAgICBkZXYtPmZlYXR1cmVzIHw9IE5FVElGX0ZfR1JPX0hXOwo+ID4gPiA+ICAgIGlmICh2aXJ0
aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX05FVF9GX0NUUkxfR1VFU1RfT0ZGTE9BRFMpKQo+
ID4gPiA+ICAgICAgZGV2LT5od19mZWF0dXJlcyB8PSBORVRJRl9GX0dST19IVzsKPiA+ID4gPgo+
ID4gPiA+Cj4gPiA+ID4gd2hpbGUgaW4gbmV0ZGV2X2ZpeF9mZWF0dXJlcyA6Cj4gPiA+ID4KPiA+
ID4gPiAgICBpZiAoIShmZWF0dXJlcyAmIE5FVElGX0ZfUlhDU1VNKSkgewo+ID4gPiA+ICAgICAg
LyogTkVUSUZfRl9HUk9fSFcgaW1wbGllcyBkb2luZyBSWENTVU0gc2luY2UgZXZlcnkgcGFja2V0
Cj4gPiA+ID4gICAgICAgKiBzdWNjZXNzZnVsbHkgbWVyZ2VkIGJ5IGhhcmR3YXJlIG11c3QgYWxz
byBoYXZlIHRoZQo+ID4gPiA+ICAgICAgICogY2hlY2tzdW0gdmVyaWZpZWQgYnkgaGFyZHdhcmUu
ICBJZiB0aGUgdXNlciBkb2VzIG5vdAo+ID4gPiA+ICAgICAgICogd2FudCB0byBlbmFibGUgUlhD
U1VNLCBsb2dpY2FsbHksIHdlIHNob3VsZCBkaXNhYmxlIEdST19IVy4KPiA+ID4gPiAgICAgICAq
Lwo+ID4gPiA+ICAgICAgaWYgKGZlYXR1cmVzICYgTkVUSUZfRl9HUk9fSFcpIHsKPiA+ID4gPiAg
ICAgICAgbmV0ZGV2X2RiZyhkZXYsICJEcm9wcGluZyBORVRJRl9GX0dST19IVyBzaW5jZSBubyBS
WENTVU0KPiA+ID4gPiBmZWF0dXJlLlxuIik7Cj4gPiA+ID4gICAgICAgIGZlYXR1cmVzICY9IH5O
RVRJRl9GX0dST19IVzsKPiA+ID4gPiAgICAgIH0KPiA+ID4gPiAgICB9Cj4gPiA+ID4KPiA+ID4g
PiBBcyByZXN1bHQgZGV2LT5mZWF0dXJlcyBhbmQgZmVhdHVyZXMgcGFzc2VkIGZyb20KPiA+ID4g
PiBfX25ldGRldl91cGRhdGVfZmVhdHVyZXMgZGlmZmVycyBleGFjdGx5IGluIE5FVElGX0ZfR1JP
X0hXIGJpdC4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gUGxlYXNlIG1pbmQgb3VyIHByaXZhY3kg
bm90aWNlPGh0dHBzOi8vd3d3Lm9wZW5zeW5lcmd5LmNvbS9kYXRlbnNjaHV0emVya2xhZXJ1bmcv
cHJpdmFjeS1ub3RpY2UtZm9yLWJ1c2luZXNzLXBhcnRuZXJzLXB1cnN1YW50LXRvLWFydGljbGUt
MTMtb2YtdGhlLWdlbmVyYWwtZGF0YS1wcm90ZWN0aW9uLXJlZ3VsYXRpb24tZ2Rwci8+IHB1cnN1
YW50IHRvIEFydC4gMTMgR0RQUi4gLy8gVW5zZXJlIEhpbndlaXNlIHp1bSBEYXRlbnNjaHV0eiBn
ZW0uIEFydC4gMTMgRFNHVk8gZmluZGVuIFNpZSBoaWVyLjxodHRwczovL3d3dy5vcGVuc3luZXJn
eS5jb20vZGUvZGF0ZW5zY2h1dHplcmtsYWVydW5nL2RhdGVuc2NodXR6aGlud2Vpc2UtZnVlci1n
ZXNjaGFlZnRzcGFydG5lci1nZW0tYXJ0LTEzLWRzZ3ZvLz4KPiA+Cj4gPgo+ID4gUGxlYXNlIG1p
bmQgb3VyIHByaXZhY3kgbm90aWNlPGh0dHBzOi8vd3d3Lm9wZW5zeW5lcmd5LmNvbS9kYXRlbnNj
aHV0emVya2xhZXJ1bmcvcHJpdmFjeS1ub3RpY2UtZm9yLWJ1c2luZXNzLXBhcnRuZXJzLXB1cnN1
YW50LXRvLWFydGljbGUtMTMtb2YtdGhlLWdlbmVyYWwtZGF0YS1wcm90ZWN0aW9uLXJlZ3VsYXRp
b24tZ2Rwci8+IHB1cnN1YW50IHRvIEFydC4gMTMgR0RQUi4gLy8gVW5zZXJlIEhpbndlaXNlIHp1
bSBEYXRlbnNjaHV0eiBnZW0uIEFydC4gMTMgRFNHVk8gZmluZGVuIFNpZSBoaWVyLjxodHRwczov
L3d3dy5vcGVuc3luZXJneS5jb20vZGUvZGF0ZW5zY2h1dHplcmtsYWVydW5nL2RhdGVuc2NodXR6
aGlud2Vpc2UtZnVlci1nZXNjaGFlZnRzcGFydG5lci1nZW0tYXJ0LTEzLWRzZ3ZvLz4KPgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
