Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF6EC77B75
	for <virtualization@archiver.kernel.org>; Mon, 15 May 2023 04:45:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 42C4083B2B;
	Mon, 15 May 2023 04:45:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 42C4083B2B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ITQgWkUE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DElPaBYYCvWs; Mon, 15 May 2023 04:45:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BB21983B19;
	Mon, 15 May 2023 04:45:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB21983B19
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B4A4C0036;
	Mon, 15 May 2023 04:45:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F54EC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 04:45:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 63A5E60FBA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 04:45:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 63A5E60FBA
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ITQgWkUE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h1S93_8PhjjR
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 04:45:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C46C660B9A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C46C660B9A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 04:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684125934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2XjOq8S6eLxylOWfxVE7lTJHF71GQ9YxxKOvqpFm4bE=;
 b=ITQgWkUEseAHNRW+Vc5Pi5B+lGNBQzzbGu0Z9Gcups2QiaDYhm4QiRWYA1OxFy3J9hjgSh
 fRev+AegwtnLu+yPBFOHPi4ndpQgNYJyz6q9o00WKcDnGJA3i4b+hYvk3wRp+PsU7SplGl
 2WyplDh86pz1+yfsk3YKmIRmJyfcmoU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-sN76TQCVOwqy1hWnAOsorA-1; Mon, 15 May 2023 00:45:30 -0400
X-MC-Unique: sN76TQCVOwqy1hWnAOsorA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f509037a45so12025455e9.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 May 2023 21:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684125929; x=1686717929;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2XjOq8S6eLxylOWfxVE7lTJHF71GQ9YxxKOvqpFm4bE=;
 b=eCLdLAKOJNPrbNORxWt4CTouf3ITmzQmB/LKhJ8h+oz6gcuMoOYEHOxX2Ed+yBHvCU
 F27RmY2uAH+wdtGeba2Ty2viZe6NIJpPCPPhYxit2676R62gCu568+4sQRAw2eFmgMXM
 hfsq+fczy3fTRqDr0faps0cfVwVeEOQuMIqzj/+WGlKoIbO6kHivEKlFyk9dP2NbFSu2
 +8n6hhU7+858S127dVWQ6Hd1Lo22fkPzYo7pC3NRvY6HJk9c9VNJQcTR4pMHV59EGVyx
 pg1vmtqbwcMiKqhrDQLl6V6+X3atsiJlM9tl3fIwPUQRXgWxJVjE9yJpB76YO2Bo8qmj
 qZ8Q==
X-Gm-Message-State: AC+VfDwMVHme879PkNKA11WJsZkC01ItkwSO0veVO67dWW8aD6VXIlE6
 QmtQh/3Gwz6IULbukElFo+8JQcwnuaA/oPYPdYwaAiscR1jB2ahD4k6YrVzRNIC04zocejotNwz
 JwTLEyYUroL62cYamuGhXHUQIQ7bLtEh3xBnC+VPpww==
X-Received: by 2002:adf:dd83:0:b0:307:7d1a:20fd with SMTP id
 x3-20020adfdd83000000b003077d1a20fdmr21880982wrl.12.1684125929769; 
 Sun, 14 May 2023 21:45:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4OdZsGOJb5yblTc2DXNqTp+ArQzg1WhoBfxb9JKuFEQkr0FvMpdV5CBb5jM57qjG8ZfvnWbw==
X-Received: by 2002:adf:dd83:0:b0:307:7d1a:20fd with SMTP id
 x3-20020adfdd83000000b003077d1a20fdmr21880965wrl.12.1684125929446; 
 Sun, 14 May 2023 21:45:29 -0700 (PDT)
Received: from redhat.com ([2.52.146.3]) by smtp.gmail.com with ESMTPSA id
 k11-20020adff5cb000000b0030649242b72sm31024743wrp.113.2023.05.14.21.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 May 2023 21:45:28 -0700 (PDT)
Date: Mon, 15 May 2023 00:45:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next V2 1/2] virtio-net: convert rx mode setting to
 use workqueue
Message-ID: <20230515004422-mutt-send-email-mst@kernel.org>
References: <20230413064027.13267-1-jasowang@redhat.com>
 <20230413064027.13267-2-jasowang@redhat.com>
 <20230413121525-mutt-send-email-mst@kernel.org>
 <CACGkMEunn1Z3n8yjVaWLqdV502yjaCBSAb_LO4KsB0nuxXmV8A@mail.gmail.com>
 <20230414031947-mutt-send-email-mst@kernel.org>
 <CACGkMEtutGn0CoJhoPHbzPuqoCLb4OCT6a_vB_WPV=MhwY0DXg@mail.gmail.com>
 <20230510012951-mutt-send-email-mst@kernel.org>
 <CACGkMEszPydzw_MOUOVJKBBW_8iYn66i_9OFvLDoZMH34hMx=w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEszPydzw_MOUOVJKBBW_8iYn66i_9OFvLDoZMH34hMx=w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, netdev <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, edumazet@google.com, maxime.coquelin@redhat.com,
 kuba@kernel.org, pabeni@redhat.com, david.marchand@redhat.com,
 davem@davemloft.net
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

T24gTW9uLCBNYXkgMTUsIDIwMjMgYXQgMDk6MDU6NTRBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBXZWQsIE1heSAxMCwgMjAyMyBhdCAxOjMz4oCvUE0gTWljaGFlbCBTLiBUc2lya2lu
IDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gTW9uLCBBcHIgMTcsIDIwMjMgYXQg
MTE6NDA6NThBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gT24gRnJpLCBBcHIgMTQs
IDIwMjMgYXQgMzoyMeKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdy
b3RlOgo+ID4gPiA+Cj4gPiA+ID4gT24gRnJpLCBBcHIgMTQsIDIwMjMgYXQgMDE6MDQ6MTVQTSAr
MDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+IEZvcmdldCB0byBjYyBuZXRkZXYsIGFk
ZGluZy4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBPbiBGcmksIEFwciAxNCwgMjAyMyBhdCAxMjoyNeKA
r0FNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiBPbiBUaHUsIEFwciAxMywgMjAyMyBhdCAwMjo0MDoyNlBNICswODAwLCBK
YXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+IFRoaXMgcGF0Y2ggY29udmVydCByeCBtb2Rl
IHNldHRpbmcgdG8gYmUgZG9uZSBpbiBhIHdvcmtxdWV1ZSwgdGhpcyBpcwo+ID4gPiA+ID4gPiA+
IGEgbXVzdCBmb3IgYWxsb3cgdG8gc2xlZXAgd2hlbiB3YWl0aW5nIGZvciB0aGUgY3ZxIGNvbW1h
bmQgdG8KPiA+ID4gPiA+ID4gPiByZXNwb25zZSBzaW5jZSBjdXJyZW50IGNvZGUgaXMgZXhlY3V0
ZWQgdW5kZXIgYWRkciBzcGluIGxvY2suCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiBJIGRvbid0IGxpa2UgdGhpcyBmcmFua2x5LiBUaGlzIG1lYW5zIHRoYXQgc2V0
dGluZyBSWCBtb2RlIHdoaWNoIHdvdWxkCj4gPiA+ID4gPiA+IHByZXZpb3VzbHkgYmUgcmVsaWFi
bGUsIG5vdyBiZWNvbWVzIHVucmVsaWFibGUuCj4gPiA+ID4gPgo+ID4gPiA+ID4gSXQgaXMgInVu
cmVsaWFibGUiIGJ5IGRlc2lnbjoKPiA+ID4gPiA+Cj4gPiA+ID4gPiAgICAgICB2b2lkICAgICAg
ICAgICAgICAgICAgICAoKm5kb19zZXRfcnhfbW9kZSkoc3RydWN0IG5ldF9kZXZpY2UgKmRldik7
Cj4gPiA+ID4gPgo+ID4gPiA+ID4gPiAtIGZpcnN0IG9mIGFsbCBjb25maWd1cmF0aW9uIGlzIG5v
IGxvbmdlciBpbW1lZGlhdGUKPiA+ID4gPiA+Cj4gPiA+ID4gPiBJcyBpbW1lZGlhdGUgYSBoYXJk
IHJlcXVpcmVtZW50PyBJIGNhbiBzZWUgYSB3b3JrcXVldWUgaXMgdXNlZCBhdCBsZWFzdDoKPiA+
ID4gPiA+Cj4gPiA+ID4gPiBtbHg1ZSwgaXBvaWIsIGVmeCwgLi4uCj4gPiA+ID4gPgo+ID4gPiA+
ID4gPiAgIGFuZCB0aGVyZSBpcyBubyB3YXkgZm9yIGRyaXZlciB0byBmaW5kIG91dCB3aGVuCj4g
PiA+ID4gPiA+ICAgaXQgYWN0dWFsbHkgdG9vayBlZmZlY3QKPiA+ID4gPiA+Cj4gPiA+ID4gPiBC
dXQgd2Uga25vdyByeCBtb2RlIGlzIGJlc3QgZWZmb3J0IGUuZyBpdCBkb2Vzbid0IHN1cHBvcnQg
dmhvc3QgYW5kIHdlCj4gPiA+ID4gPiBzdXJ2aXZlIGZyb20gdGhpcyBmb3IgeWVhcnMuCj4gPiA+
ID4gPgo+ID4gPiA+ID4gPiAtIHNlY29uZCwgaWYgZGV2aWNlIGZhaWxzIGNvbW1hbmQsIHRoaXMg
aXMgYWxzbyBub3QKPiA+ID4gPiA+ID4gICBwcm9wYWdhdGVkIHRvIGRyaXZlciwgYWdhaW4gbm8g
d2F5IGZvciBkcml2ZXIgdG8gZmluZCBvdXQKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gVkRVU0Ug
bmVlZHMgdG8gYmUgZml4ZWQgdG8gZG8gdHJpY2tzIHRvIGZpeCB0aGlzCj4gPiA+ID4gPiA+IHdp
dGhvdXQgYnJlYWtpbmcgbm9ybWFsIGRyaXZlcnMuCj4gPiA+ID4gPgo+ID4gPiA+ID4gSXQncyBu
b3Qgc3BlY2lmaWMgdG8gVkRVU0UuIEZvciBleGFtcGxlLCB3aGVuIHVzaW5nIHZpcnRpby1uZXQg
aW4gdGhlCj4gPiA+ID4gPiBVUCBlbnZpcm9ubWVudCB3aXRoIGFueSBzb2Z0d2FyZSBjdnEgKGxp
a2UgbWx4NSB2aWEgdkRQQSBvciBjbWEKPiA+ID4gPiA+IHRyYW5zcG9ydCkuCj4gPiA+ID4gPgo+
ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4KPiA+ID4gPiBIbW0uIENhbiB3ZSBkaWZmZXJlbnRpYXRl
IGJldHdlZW4gdGhlc2UgdXNlLWNhc2VzPwo+ID4gPgo+ID4gPiBJdCBkb2Vzbid0IGxvb2sgZWFz
eSBzaW5jZSB3ZSBhcmUgZHJpdmVycyBmb3IgdmlydGlvIGJ1cy4gVW5kZXJsYXllcgo+ID4gPiBk
ZXRhaWxzIHdlcmUgaGlkZGVuIGZyb20gdmlydGlvLW5ldC4KPiA+ID4KPiA+ID4gT3IgZG8geW91
IGhhdmUgYW55IGlkZWFzIG9uIHRoaXM/Cj4gPiA+Cj4gPiA+IFRoYW5rcwo+ID4KPiA+IEkgZG9u
J3Qga25vdywgcGFzcyBzb21lIGtpbmQgb2YgZmxhZyBpbiBzdHJ1Y3QgdmlydHF1ZXVlPwo+ID4g
ICAgICAgICAiYm9vbCBzbG93OyAvKiBUaGlzIHZxIGNhbiBiZSB2ZXJ5IHNsb3cgc29tZXRpbWVz
LiBEb24ndCB3YWl0IGZvciBpdCEgKi8iCj4gPgo+ID4gPwo+ID4KPiAKPiBTbyBpZiBpdCdzIHNs
b3csIHNsZWVwLCBvdGhlcndpc2UgcG9sbD8KPiAKPiBJIGZlZWwgc2V0dGluZyB0aGlzIGZsYWcg
bWlnaHQgYmUgdHJpY2t5LCBzaW5jZSB0aGUgZHJpdmVyIGRvZXNuJ3QKPiBrbm93IHdoZXRoZXIg
b3Igbm90IGl0J3MgcmVhbGx5IHNsb3cuIEUuZyBzbWFydE5JQyB2ZW5kb3IgbWF5IGFsbG93Cj4g
dmlydGlvLW5ldCBlbXVsYXRpb24gb3ZlciBQQ0kuCj4gCj4gVGhhbmtzCgpkcml2ZXIgd2lsbCBo
YXZlIHRoZSBjaG9pY2UsIGRlcGVuZGluZyBvbiB3aGV0aGVyCnZxIGlzIGRldGVybWluaXN0aWMg
b3Igbm90LgoKCj4gPiAtLQo+ID4gTVNUCj4gPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
