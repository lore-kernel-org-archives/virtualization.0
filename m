Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF42C46CA1
	for <virtualization@archiver.kernel.org>; Mon, 18 Sep 2023 11:13:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C7E481FA4;
	Mon, 18 Sep 2023 11:13:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4C7E481FA4
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HVOgKb0W
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JwQEgXhsgcMB; Mon, 18 Sep 2023 11:13:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 76F8681F9F;
	Mon, 18 Sep 2023 11:13:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 76F8681F9F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DF78C0071;
	Mon, 18 Sep 2023 11:13:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16031C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 11:13:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D812061485
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 11:13:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D812061485
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HVOgKb0W
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MJcue3iQG5lg
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 11:13:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E69FE61482
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 11:13:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E69FE61482
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695035602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3dwROEaWuFVAn1odUaI8CMOXiLtYYzOFVr+CEmmfiTI=;
 b=HVOgKb0Woq91aLtKC05HSpyxTh6l1z1PMdap63MfuqV96EB0BG4qxERoa60elXZi33za5W
 Nzhxh6nKodVd/vYodXkfGkDpqeXF9WXz8hK8YpyX3k7c7wqy3FcMGNhitrgfidn1kDkgeB
 ipMoE4M/dRtE/ZWfXq+y1EmNfCrxpes=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-I93kOvDMOpuKgHP5nY4TJA-1; Mon, 18 Sep 2023 07:13:21 -0400
X-MC-Unique: I93kOvDMOpuKgHP5nY4TJA-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-1d5b1fd98c6so6997962fac.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 04:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695035600; x=1695640400;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3dwROEaWuFVAn1odUaI8CMOXiLtYYzOFVr+CEmmfiTI=;
 b=RDBHZ2qBp5jhP1eyRhY68u3ieaCzRSxYuv6nYwpDpKoe3jQ75IDupniPV1ydw6sPuR
 dNJ082dMsdt3d9IleK0/zoXnw2od1WIDGlwx/2WRUix32ILIbPqGUJPA5t7vPS93w+eE
 1MNxkkW01K6alMOMZA/oViCaS49X4FnDm7BBAcCLYdg+6bbYmtAzDgM2jhhmzmv84ujF
 BQfKOC+tt8dw0JknjDPjRIF2mhpF4OP08gEvtE+VdbgpmImhzMfZR/VGPPOQ3iVLxD/I
 fNPNf1Y3sFk4B2sKWMGZLYolDPu+XFBO7JCjvp/dkp9VWbo1KX/jnm3w8lTCmzvuHliY
 q91g==
X-Gm-Message-State: AOJu0Yw8F/1PEp05oEF+9/mlHF1wc0UiW/k/ugHeTlo42qI8Zcz+1UTy
 /SforybbAKGvR4P9oMszNMF7Wwa4Gx0t9IeUWfAW1oLAIrn1Kwz0sED+6qthCd6s7EQoPJT71A8
 rtnDVINeixARRUJegE1cfep/7rTvZRXWWQOMOCNjPvQ==
X-Received: by 2002:a05:6870:3515:b0:1d5:a905:5681 with SMTP id
 k21-20020a056870351500b001d5a9055681mr9462537oah.26.1695035600758; 
 Mon, 18 Sep 2023 04:13:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuC85lj0uJTOsELLpzZtvuWYxaaU91P9QNlISPYC7bivjxYpuTLiQDZbAjZDo0ugvsee6wqw==
X-Received: by 2002:a05:6870:3515:b0:1d5:a905:5681 with SMTP id
 k21-20020a056870351500b001d5a9055681mr9462521oah.26.1695035600425; 
 Mon, 18 Sep 2023 04:13:20 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
 by smtp.gmail.com with ESMTPSA id
 j14-20020a0ce00e000000b0062def68f75csm3348318qvk.124.2023.09.18.04.13.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Sep 2023 04:13:20 -0700 (PDT)
Date: Mon, 18 Sep 2023 13:13:16 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [virtio-comment] virtio-sound linux driver conformance to spec
Message-ID: <ZQgwzAgIdjyWn5nE@fedora>
References: <ZQHPeD0fds9sYzHO@pc-79.home>
 <CABgObfbXsHN6=ZmL0s+mtCypXs11LNECECO3Uud_J6PMr+JwNA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABgObfbXsHN6=ZmL0s+mtCypXs11LNECECO3Uud_J6PMr+JwNA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com, virtio-comment@lists.oasis-open.org
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

T24gV2VkLCBTZXAgMTMsIDIwMjMgYXQgMDU6NTA6NDhQTSArMDIwMCwgUGFvbG8gQm9uemluaSB3
cm90ZToKPiBPbiBXZWQsIFNlcCAxMywgMjAyMyBhdCA1OjA14oCvUE0gTWF0aWFzIEV6ZXF1aWVs
IFZhcmEgTGFyc2VuCj4gPG12YXJhbGFyQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IEhlbGxv
LAo+ID4KPiA+IFRoaXMgZW1haWwgaXMgdG8gcmVwb3J0IGEgYmVoYXZpb3Igb2YgdGhlIExpbnV4
IHZpcnRpby1zb3VuZCBkcml2ZXIgdGhhdAo+ID4gbG9va3MgbGlrZSBpdCBpcyBub3QgY29uZm9y
bWluZyB0byB0aGUgVmlydElPIHNwZWNpZmljYXRpb24uIFRoZSBrZXJuZWwKPiA+IGRyaXZlciBp
cyBtb3ZpbmcgYnVmZmVycyBmcm9tIHRoZSB1c2VkIHJpbmcgdG8gdGhlIGF2YWlsYWJsZSByaW5n
Cj4gPiB3aXRob3V0IGtub3dpbmcgaWYgdGhlIGNvbnRlbnQgaGFzIGJlZW4gdXBkYXRlZCBmcm9t
IHRoZSB1c2VyLiBJZiB0aGUKPiA+IGRldmljZSBwaWNrcyB1cCBidWZmZXJzIGZyb20gdGhlIGF2
YWlsYWJsZSByaW5nIGp1c3QgYWZ0ZXIgaXQgaXMKPiA+IG5vdGlmaWVkLCBpdCBoYXBwZW5zIHRo
YXQgdGhlIGNvbnRlbnQgaXMgb2xkLiBUaGlzIHByb2JsZW0gY2FuIGJlIGZpeGVkCj4gPiBieSB3
YWl0aW5nIGEgcGVyaW9kIG9mIHRpbWUgYWZ0ZXIgdGhlIGRldmljZSBkZXF1ZXVlcyBhIGJ1ZmZl
ciBmcm9tIHRoZQo+ID4gYXZhaWxhYmxlIHJpbmcuIFRoZSBkcml2ZXIgc2hvdWxkIG5vdCBiZSBh
bGxvd2VkIHRvIGNoYW5nZSB0aGUgY29udGVudAo+ID4gb2YgYSBidWZmZXIgaW4gdGhlIGF2YWls
YWJsZSByaW5nLiBXaGVuIGJ1ZmZlcnMgYXJlIGVucXVldWVkIGluIHRoZQo+ID4gYXZhaWxhYmxl
IHJpbmcsIHRoZSBkZXZpY2UgY2FuIGNvbnN1bWUgdGhlbSBpbW1lZGlhdGVseS4KPiA+Cj4gPiAx
LiBJcyB0aGUgYWN0dWFsIGRyaXZlciBpbXBsZW1lbnRhdGlvbiBmb2xsb3dpbmcgdGhlIHNwZWM/
Cj4gCj4gSWYgSSB1bmRlcnN0YW5kIHRoZSBpc3N1ZSBjb3JyZWN0bHksIGl0J3Mgbm90LiBBcyB5
b3Ugc2F5LCBhYnNlbnQgYW55Cj4gY2xhcmlmaWNhdGlvbiBhIGJ1ZmZlciB0aGF0IGhhcyBiZWVu
IHBsYWNlZCBpbiB0aGUgYXZhaWxhYmxlIHJpbmcKPiBzaG91bGQgYmUgdW5tb2RpZmlhYmxlOyB0
aGUgZHJpdmVyIHNob3VsZCBvcGVyYXRlIGFzIGlmIHRoZSBkYXRhIGluCj4gdGhlIGF2YWlsYWJs
ZSByaW5nIGlzIGNvcGllZCB0byBhbiBpbnRlcm5hbCBidWZmZXIgaW5zdGFudGx5IHdoZW4gdGhl
Cj4gYnVmZmVyIGlkIGlzIGFkZGVkIHRvIHRoZSByaW5nLgo+IAo+IEkgYW0gYXNzdW1pbmcgdGhp
cyBpcyBhIHBsYXliYWNrIGJ1ZmZlci4gVG8gY2xhcmlmeSwgZG9lcyB0aGUgZHJpdmVyCj4gZXhw
ZWN0IGJ1ZmZlcnMgdG8gYmUgcmVhZCBvbmx5IGFzIG5lZWRlZCwgd2hpY2ggaXMgYSBmcmFjdGlv
biBvZiBhCj4gc2Vjb25kIGJlZm9yZSB0aGUgZGF0YSBpcyBwbGF5ZWQgYmFjaz8KPiAKVGhlIGRy
aXZlciBleHBlY3RzIHRoYXQgZGV2aWNlIHRvIHJlYWQgYnVmZmVycyBhIGZyYWN0aW9uIG9mIGEg
c2Vjb25kCmJlZm9yZSBwbGF5aW5nIHRoZW0gYmFjay4gSWYgdGhlIGRldmljZSByZWFkcyBpdCBq
dXN0IHdoZW4gdGhleSBhcmUKZXhwb3NlZCBpbiB0aGUgYXZhaWxhYmxlIHJpbmcsIHRoZSBjb250
ZW50IGlzIG9sZC4gVGhlIGRldmljZSBoYXMgdG8KcmVhZCBpdCBqdXN0IHdoZW4gdGhlIGF1ZGlv
IGVuZ2luZSBpcyBnb2luZyB0byBjb25zdW1lIGl0LgoKPiA+IDIuIFNoYWxsIHRoZSBzcGVjIGJl
IGV4dGVuZGVkIHRvIHN1cHBvcnQgc3VjaCBhIHVzZS1jYXNlPwo+IAo+IElmIGl0IHBsYWNlcyBO
IGJ1ZmZlcnMsIEkgdGhpbmsgaXQncyBhIHJlYXNvbmFibGUgZXhwZWN0YXRpb24gKGZvciB0aGUK
PiBzb3VuZCBkZXZpY2Ugb25seSEpIHRoYXQgdGhlIE50aCBpc24ndCByZWFkIHVudGlsIHRoZSAo
Ti0xKXRoIGhhcwo+IHN0YXJ0ZWQgcGxheWluZy4gV2l0aCB0d28gYnVmZmVycyBvbmx5LCB0aGUg
YmVoYXZpb3IgeW91IHNwZWNpZnkgd291bGQKPiBub3QgYmUgcGVybWlzc2libGUgKGJlY2F1c2Ug
YXMgc29vbiBhcyBidWZmZXIgMSBzdGFydHMgcGxheWluZywgdGhlCj4gZGV2aWNlIGNhbiByZWFk
IGJ1ZmZlciAyOyB0aGVyZSBpcyBuZXZlciBhbiBpZGxlIGJ1ZmZlcikuIFdpdGggdGhyZWUKPiBi
dWZmZXJzLCB5b3UgY291bGQgd3JpdGUgYnVmZmVyIDMgd2hpbGUgYnVmZmVyIDEgcGxheXM7IHdy
aXRlIGJ1ZmZlciAxCj4gd2hpbGUgYnVmZmVyIDIgcGxheXM7IGFuZCB3cml0ZSBidWZmZXIgMiB3
aGlsZSBidWZmZXIgMyBwbGF5cy4gSXMgdGhpcwo+IGVub3VnaD8KPiAKPiBUaGF0IHNhaWQsIGJl
aW5nIHJlYXNvbmFibGUgaXNuJ3QgZW5vdWdoIGZvciB2aXJ0aW8tc291bmQgdG8gZG8gaXQgYW5k
Cj4gZGV2aWF0ZSBmcm9tIG90aGVyIHZpcnRpbyBkZXZpY2VzLiBXaHkgZG9lcyB0aGUgTGludXgg
ZHJpdmVyIGJlaGF2ZQo+IGxpa2UgdGhpcz8gSXMgaXQgc29tZWhvdyBjb25zdHJhaW5lZCBieSB0
aGUga2VybmVsLT51c2Vyc3BhY2UgQVBJcz8KPiAKQUZBSVUsIHRoZSBkcml2ZXIgc2VuZHMgZm91
ciByZXF1ZXN0cyBiZWZvcmUgc3RhcnRpbmcgcGxheWluZywgZS5nLiwKYXBsYXkgJ0Zyb250TGVm
dC53YXYnLCBlYWNoIHdpdGggUEVSSU9EX1NJWkUgYnl0ZXMuIFBFUklPRF9TSVpFIGlzCm5lZ290
aWF0ZWQgYmV0d2VlbiB0aGUgZGV2aWNlIGFuZCB0aGUgZHJpdmVyIGJlZm9yZSBwbGF5YmFjayBi
ZWdpbnMuClRoZSByZXF1ZXN0cyBhcmUgc3BsaXQgaW50byBtdWx0aXBsZSBidWZmZXJzLiAgQWZ0
ZXIgYSBQRVJJT0RfU0laRSBpcwpwbGF5ZWQsIHRoZSBkZXZpY2Ugbm90aWZpZXMgdGhlIGd1ZXN0
LiAgVGhlc2UgYnVmZmVycyBhcmUgcGFydCBvZiBhIHJpbmcKYnVmZmVyIHNoYXJlZCB3aXRoIHRo
ZSB1c2VyIGFwcGxpY2F0aW9uLiBUaGUgZGV2aWNlIGp1c3QgcGlja3MgdGhlIGxhc3QKdXNlZCBz
ZXQgb2YgYnVmZmVycyBhbmQgZW5xdWV1ZXMgYWdhaW4gaW4gdGhlIGF2YWlsYWJsZSByaW5nLiBG
b3IKZXhhbXBsZSwgaW4gdGhlIGNhc2Ugb2YgNCByZXF1ZXN0cyBvZiBQRVJJT0RfU0laRSBieXRl
cyBlYWNoLCB0aGUKbWVjaGFuaXNtIGlzIHJvdWdobHkgYXMgZm9sbG93cy4gVGhlIGRyaXZlciBw
cmUtYnVmZmVycyA0IHJlcXVlc3RzLiBXaGVuCml0IHN0YXJ0cyB0byBwbGF5LCB0aGUgZGV2aWNl
IHN0YXJ0cyB3aXRoIFswXS4gQWZ0ZXIgWzBdIGlzIHBsYXllZCwgaXQKYWRkcyB0aGlzIHJlcXVl
c3QgdG8gdGhlIHVzZWQgcmluZyBhbmQgaXQgcGlja3MgdXAgWzFdIGZvciBwbGF5aW5nLiBUaGUK
ZHJpdmVyIGdldHMgdGhlIG5vdGlmaWNhdGlvbiB0aGF0IFswXSBoYXMgYmVlbiBjb25zdW1lZCwg
YW5kIG1vdmVzIHRoZQpyZXF1ZXN0IHRvIHRoZSBhdmFpbGFibGUgcmluZyB0aHVzIG5vdGlmeWlu
ZyB0aGUgZGV2aWNlLiBBdCB0aGlzIHBvaW50LAp0aGUgZGV2aWNlIHNob3VsZCBub3QgZ2V0IHRo
ZSBjb250ZW50IG9mIFswXSBzaW5jZSBpdCBpcyBzdGlsbCBvbGQuIFRoZQpjb250ZW50IHNoYWxs
IGJlIHJlYWQgb25seSBCRUZPUkUgWzBdIGlzIGNvbnN1bWVkIGFnYWluLCBlLmcuLCBhZnRlciA0
CnBlcmlvZHMuCgpNYXRpYXMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
