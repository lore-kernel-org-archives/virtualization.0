Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3543FCD3431
	for <virtualization@archiver.kernel.org>; Mon, 25 Sep 2023 18:16:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B7EF8612A9;
	Mon, 25 Sep 2023 18:16:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B7EF8612A9
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S29OvmRB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mMFvs5-nnk00; Mon, 25 Sep 2023 18:16:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 170426129E;
	Mon, 25 Sep 2023 18:16:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 170426129E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C79C1C0071;
	Mon, 25 Sep 2023 18:16:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C9A8C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 18:16:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5A1D3612A6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 18:16:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5A1D3612A6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pqEKDu-mToI5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 18:16:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6823E6129E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 18:16:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6823E6129E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695665801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NFY8KO7exZJuGoSNda4VqGBb8Equ+XlWtrdZ2h/i9EE=;
 b=S29OvmRBJCjtA6wWvHsAJ8aECx7oTqE8EF+TBn4g2qlmLuQN+HIaLKdK7LOnSc592WxqoO
 mbLc493KrzeRwPtcR+8DlYcLeY+Aj0gRHnZ52WbZc1fBtSW531yISF9auJl0BsMmceEzzM
 NLJkKS1yVHNPj83JOrimUXZH21o5XL0=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-yPRmMf6ANU-YiJtZS_Ufyw-1; Mon, 25 Sep 2023 14:16:39 -0400
X-MC-Unique: yPRmMf6ANU-YiJtZS_Ufyw-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-1dd691b1037so75306fac.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 11:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695665798; x=1696270598;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NFY8KO7exZJuGoSNda4VqGBb8Equ+XlWtrdZ2h/i9EE=;
 b=twfxayGw7iYXjkmfcji7s/ltl9LjA/FOcOmocTcosw2BvvA1eRKGGSJ54T4pnWsar2
 23SVmylzXY80KylmP+5clS1tp2Wx9DCvo5oT4fDB9BRN3EoaoMnfaOL/RC7GOHUbRlS4
 ZT1eD5+xn/M5WRfMdJgkieJ8Vf0ScO23oeGfBhATFR76ifZvXrf0XFSSOs3zUPUWf5qF
 jGiOXzJQC5fvyJkJu2BYPW+RkHii2kt7HQ4L2dRD9Rf5fd2kGseyTR+p6pQOkknAOida
 m2hQ+KvkcdX5aoVib4xUhNAdYsANSka9AV8pSg+O/IJXFTeWj8O7HSIfTavzxqmT7GFk
 i79w==
X-Gm-Message-State: AOJu0YzBxIiCIOvnUGwCeyF0+dpjmVueID2QBwS25n0hsXftPZwDFyBy
 DBd0O0tgUPh4FSn2UZvuJl2r9DWYoecaYypK+HIr/fz60iI16sdiCZMe7YWp2LndZreOJFLrZLU
 iw4lq0kIpysEKN0y+3FaABRQrOZHy4MfMW4i0r7P3eg==
X-Received: by 2002:a05:6870:41c7:b0:1c0:2e8f:17fd with SMTP id
 z7-20020a05687041c700b001c02e8f17fdmr10557332oac.40.1695665798579; 
 Mon, 25 Sep 2023 11:16:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwXE1LPmfUYbPthMNSP0cmJcMi8DExG+rfbujPW1+QPh8DQXLcBnujK+Md9C5G0HWt8tsanw==
X-Received: by 2002:a05:6870:41c7:b0:1c0:2e8f:17fd with SMTP id
 z7-20020a05687041c700b001c02e8f17fdmr10557305oac.40.1695665798203; 
 Mon, 25 Sep 2023 11:16:38 -0700 (PDT)
Received: from redhat.com ([185.184.228.174]) by smtp.gmail.com with ESMTPSA id
 cx4-20020a05620a51c400b007743382121esm941451qkb.84.2023.09.25.11.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:16:37 -0700 (PDT)
Date: Mon, 25 Sep 2023 14:16:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20230925133637-mutt-send-email-mst@kernel.org>
References: <20230921131035-mutt-send-email-mst@kernel.org>
 <20230921174450.GT13733@nvidia.com>
 <20230921135426-mutt-send-email-mst@kernel.org>
 <20230921181637.GU13733@nvidia.com>
 <20230921152802-mutt-send-email-mst@kernel.org>
 <20230921195345.GZ13733@nvidia.com>
 <CACGkMEt=dxhJP4mUUWh+x-TSxA5JQcvmhJbkLJMWdN8oXV6ojg@mail.gmail.com>
 <20230922122501.GP13733@nvidia.com>
 <20230922111342-mutt-send-email-mst@kernel.org>
 <20230922161928.GS13733@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230922161928.GS13733@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jiri@nvidia.com, leonro@nvidia.com
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

T24gRnJpLCBTZXAgMjIsIDIwMjMgYXQgMDE6MTk6MjhQTSAtMDMwMCwgSmFzb24gR3VudGhvcnBl
IHdyb3RlOgo+IE9uIEZyaSwgU2VwIDIyLCAyMDIzIGF0IDExOjM5OjE5QU0gLTA0MDAsIE1pY2hh
ZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+IE9uIEZyaSwgU2VwIDIyLCAyMDIzIGF0IDA5OjI1OjAx
QU0gLTAzMDAsIEphc29uIEd1bnRob3JwZSB3cm90ZToKPiA+ID4gT24gRnJpLCBTZXAgMjIsIDIw
MjMgYXQgMTE6MDI6NTBBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiBPbiBGcmks
IFNlcCAyMiwgMjAyMyBhdCAzOjUz4oCvQU0gSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNv
bT4gd3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4gT24gVGh1LCBTZXAgMjEsIDIwMjMgYXQgMDM6
MzQ6MDNQTSAtMDQwMCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gdGhhdCdzIGVhc3kvcHJhY3RpY2FsLiAgSWYgaW5zdGVhZCBWRFBBIGdpdmVzIHRoZSBz
YW1lIHNwZWVkIHdpdGgganVzdAo+ID4gPiA+ID4gPiBzaGFkb3cgdnEgdGhlbiBrZWVwaW5nIHRo
aXMgaGFjayBpbiB2ZmlvIHNlZW1zIGxpa2UgbGVzcyBvZiBhIHByb2JsZW0uCj4gPiA+ID4gPiA+
IEZpbmFsbHkgaWYgVkRQQSBpcyBmYXN0ZXIgdGhlbiBtYXliZSB5b3Ugd2lsbCByZWNvbnNpZGVy
IHVzaW5nIGl0IDspCj4gPiA+ID4gPgo+ID4gPiA+ID4gSXQgaXMgbm90IGFsbCBhYm91dCB0aGUg
c3BlZWQuCj4gPiA+ID4gPgo+ID4gPiA+ID4gVkRQQSBwcmVzZW50cyBhbm90aGVyIGxhcmdlIGFu
ZCBjb21wbGV4IHNvZnR3YXJlIHN0YWNrIGluIHRoZQo+ID4gPiA+ID4gaHlwZXJ2aXNvciB0aGF0
IGNhbiBiZSBlbGltaW5hdGVkIGJ5IHNpbXBseSB1c2luZyBWRklPLgo+ID4gPiA+IAo+ID4gPiA+
IHZEUEEgc3VwcG9ydHMgc3RhbmRhcmQgdmlydGlvIGRldmljZXMgc28gaG93IGRpZCB5b3UgZGVm
aW5lCj4gPiA+ID4gY29tcGxleGl0eT8KPiA+ID4gCj4gPiA+IEFzIEkgc2FpZCwgVkZJTyBpcyBh
bHJlYWR5IHJlcXVpcmVkIGZvciBvdGhlciBkZXZpY2VzIGluIHRoZXNlIFZNcy4gU28KPiA+ID4g
YW55dGhpbmcgaW5jcmVtZW50YWwgb3ZlciBiYXNlLWxpbmUgdmZpby1wY2kgaXMgY29tcGxleGl0
eSB0bwo+ID4gPiBtaW5pbWl6ZS4KPiA+ID4gCj4gPiA+IEV2ZXJ5dGhpbmcgdmRwYSBkb2VzIGlz
IGVpdGhlciByZWR1bmRhbnQgb3IgdW5uZWNlc3NhcnkgY29tcGFyZWQgdG8KPiA+ID4gVkZJTyBp
biB0aGVzZSBlbnZpcm9ubWVudHMuCj4gPiA+IAo+ID4gPiBKYXNvbgo+ID4gCj4gPiBZZXMgYnV0
IHlvdSBrbm93LiBUaGVyZSBhcmUgYWxsIGtpbmQgb2YgZW52aXJvbm1lbnRzLiAgSSBndWVzcyB5
b3UKPiA+IGNvbnNpZGVyIHlvdXJzIHRoZSBtb3N0IG1haW5zdHJlYW0gYW5kIGltcG9ydGFudCwg
YW5kIGFyZSBzdXJlIGl0IHdpbGwKPiA+IGFsd2F5cyBzdGF5IGxpa2UgdGhpcy4gIEJ1dCBpZiB0
aGVyZSdzIGEgZHJpdmVyIHRoYXQgZG9lcyB3aGF0IHlvdSBuZWVkCj4gPiB0aGVuIHlvdSB1c2Ug
dGhhdC4KPiAKPiBDb21lIG9uLCB5b3UgYXJlIHRoZSBvbmUgc2F5aW5nIHdlIGNhbm5vdCBkbyB0
aGluZ3MgaW4gdGhlIGJlc3Qgd2F5Cj4gcG9zc2libGUgYmVjYXVzZSB5b3Ugd2FudCB5b3VyIHdh
eSBvZiBkb2luZyB0aGluZ3MgdG8gYmUgdGhlIG9ubHkgd2F5Cj4gYWxsb3dlZC4gV2hpY2ggb2Yg
dXMgdGhpbmtzICJ5b3VycyB0aGUgbW9zdCBtYWluc3RyZWFtIGFuZCBpbXBvcnRhbnQiID8/Cj4g
Cj4gSSdtIG5vdCB0ZWxsaW5nIHlvdSB0byB0aHJvdyBhd2F5IFZQREEsIEknbSBzYXlpbmcgdGhl
cmUgYXJlCj4gbGVnaW1pdGF0ZSByZWFsIHdvcmxkIHVzZSBjYXNlcyB3aGVyZSBWRklPIGlzIHRo
ZSBhcHByb3ByaWF0ZQo+IGludGVyZmFjZSwgbm90IFZEUEEuCj4gCj4gSSB3YW50IGNob2ljZSwg
bm90IGRvZ21hdGljIGV4Y2x1c2lvbiB0aGF0IHRoZXJlIGlzIE9ubHkgT25lIFRydWUgV2F5LgoK
SSBkb24ndCBwYXJ0aWN1bGFybHkgdGhpbmsgdGhlcmUncyBvbmx5IG9uZSB3YXksIHZmaW8gaXMg
YWxyZWFkeSB0aGVyZS4KSSBhbSBzcGVjaWZpY2FsbHkgdGhpbmtpbmcgYWJvdXQgdGhpcyBwYXRj
aCwgZm9yIGV4YW1wbGUgaXQKbXVkZGllcyB0aGUgd2F0ZXJzIGEgYml0OiBub3JtYWxseSBJIHRo
aW5rIHZmaW8gZXhwb3NlZCBkZXZpY2UKd2l0aCB0aGUgc2FtZSBJRCwgc3VkZGVubHkgaXQgY2hh
bmdlcyB0aGUgSUQgYXMgdmlzaWJsZSB0byB0aGUgZ3Vlc3QuCkJ1dCBhZ2Fpbiwgd2hldGhlciBk
b2luZyB0aGlzIGtpbmQgb2YgdGhpbmcgaXMgT0sgaXMgbW9yZSB1cCB0byBBbGV4IHRoYW4gbWUu
CgpJIGRvIHdhbnQgdG8gdW5kZXJzdGFuZCBpZiB0aGVyZSdzIGEgdXNlLWNhc2UgdGhhdCB2ZHBh
IGRvZXMgbm90IGFkZHJlc3MKc2ltcGx5IGJlY2F1c2UgaXQgbWlnaHQgYmUgd29ydGggd2hpbGUg
dG8gZXh0ZW5kIGl0IHRvIGRvIHNvLCBhbmQgYQpidW5jaCBvZiBwZW9wbGUgd29ya2luZyBvbiBp
dCBhcmUgYXQgUmVkIEhhdCBhbmQgSSBtaWdodCBoYXZlIHNvbWUgaW5wdXQKaW50byBob3cgdGhh
dCBsYWJvciBpcyBhbGxvY2F0ZWQuIEJ1dCBpZiB0aGUgdXNlLWNhc2UgaXMgc2ltcGx5ICJoYXMg
dG8KYmUgdmZpbyBhbmQgbm90IHZkcGEiIHRoZW4gSSBndWVzcyBub3QuCgoKCgo+ID4gWW91IHJl
YWxseSBzaG91bGQgYmUgZXhwbGFpbmluZyB3aGF0IHZkcGEgKmRvZXMgbm90KiBkbyB0aGF0IHlv
dQo+ID4gbmVlZC4KPiAKPiBJIHRoaW5rIEkndmUgZG9uZSB0aGF0IGVub3VnaCwgYnV0IGlmIHlv
dSBoYXZlIGJlZW4gZm9sbG93aW5nIG15Cj4gZXhwbGFuYXRpb24geW91IHNob3VsZCBzZWUgdGhh
dCB0aGUgZW50aXJlIHBvaW50IG9mIHRoaXMgZGVzaWduIGlzIHRvCj4gYWxsb3cgYSB2aXJ0aW8g
ZGV2aWNlIHRvIGJlIGNyZWF0ZWQgaW5zaWRlIGEgRFBVIHRvIGEgc3BlY2lmaWMKPiBkZXRhaWxl
ZCBzcGVjaWZpY2F0aW9uIChlZyBhbiBBV1MgdmlydGlvLW5ldCBkZXZpY2UsIGZvciBpbnN0YW5j
ZSkKPiAKPiBUaGUgaW1wbGVtZW50YXRpb24gaXMgaW4gdGhlIERQVSwgYW5kIG9ubHkgdGhlIERQ
VS4KPiAKPiBBdCB0aGUgZW5kIG9mIHRoZSBkYXkgVkRQQSB1c2VzIG1lZGlhdGlvbiBhbmQgY3Jl
YXRlcyBzb21lCj4gUmVkSGF0L1ZEUEEvUWVtdSB2aXJ0aW8tbmV0IGRldmljZSBpbiB0aGUgZ3Vl
c3QuIEl0IGlzIGVtcGhhdGljYWxseQo+IE5PVCBhIHBlcmZlY3QgcmVjcmVhdGlvbiBvZiB0aGUg
IkFXUyB2aXJ0aW8tbmV0IiB3ZSBzdGFydGVkIG91dCB3aXRoLgo+IAo+IEl0IGVudGlyZWx5IGZh
aWxzIHRvIGFjaGlldmUgdGhlIG1vc3QgaW1wb3J0YW50IHRoaW5nIGl0IG5lZWRzIHRvIGRvIQoK
SXQgY291bGQgYmUgdGhhdCB3ZSBhcmUgdXNpbmcgbWVkaWF0aW9uIGRpZmZlcmVudGx5IC0gaW4g
bXkgd29ybGQgaXQncwp3aGVuIHRoZXJlJ3Mgc29tZSBob3N0IHNvZnR3YXJlIG9uIHRoZSBwYXRo
IGJldHdlZW4gZ3Vlc3QgYW5kIGhhcmR3YXJlLAphbmQgdGhpcyBxdWFsaWZpZXMuICBUaGUgZGlm
ZmVyZW5jZSBiZXR3ZWVuIHdoYXQgdGhpcyBwYXRjaCBkb2VzIGFuZAp3aGF0IHZkcGEgZG9lcyBz
ZWVtcyBxdWFudGl0YXRpdmUsIG5vdCBxdWFsaXRhdGl2ZS4gV2hpY2ggbWlnaHQgYmUKZW5vdWdo
IHRvIG1vdGl2YXRlIHRoaXMgd29yaywgSSBkb24ndCBtaW5kLiBCdXQgeW91IHNlZW0gdG8gZmVl
bAppdCBpcyBxdWFsaXRhdGl2ZSBhbmQgSSBhbSBnZW51aW5lbHkgY3VyaW91cyBhYm91dCBpdCwg
YmVjYXVzZQppZiB5ZXMgdGhlbiBpdCBtaWdodCBsZWFkIGUuZy4gdGhlIHZpcnRpbyBzdGFuZGFy
ZCBpbiBuZXcgZGlyZWN0aW9ucy4KCkkgY2FuICppbWFnaW5lKiBhbGwga2luZCBvZiByZWFzb25z
IHRvIHdhbnQgdG8gdXNlIHZmaW8gYXMgY29tcGFyZWQgdG8gdmRwYTsKaGVyZSBhcmUgc29tZSBl
eGFtcGxlcyBJIGNhbWUgdXAgd2l0aCwgcXVpY2tseToKLSBtYXliZSB5b3UgaGF2ZSBkcml2ZXJz
IHRoYXQgcG9rZSBhdCByZWdpc3RlcnMgbm90IGluIHZpcnRpbyBzcGVjOgogIHZmaW8gYWxsb3dz
IHRoYXQsIHZkcGEgYnkgZGVzaWduIGRvZXMgbm90Ci0gbWF5YmUgeW91IGFyZSB1c2luZyB2Zmlv
IHdpdGggYSBsb3Qgb2YgZGV2aWNlcyBhbHJlYWR5IGFuZCBkb24ndCB3YW50CiAgdG8gc3BlY2lh
bC1jYXNlIGhhbmRsaW5nIGZvciB2aXJ0aW8gZGV2aWNlcyBvbiB0aGUgaG9zdApkbyBhbnkgb2Yg
dGhlIGFib3ZlIG1vdGl2YXRpb25zIHJpbmcgdGhlIGJlbGw/IFNvbWUgb2YgdGhlIHRoaW5ncyB5
b3UKc2FpZCBzZWVtIHRvIGhpbnQgYXQgdGhhdC4gSWYgeWVzIG1heWJlIGluY2x1ZGUgdGhpcyBp
biB0aGUgY292ZXIKbGV0dGVyLgoKVGhlcmUgaXMgYWxzbyBhIHF1ZXN0aW9uIG9mIGNhcGFiaWxp
dHkuIFNwZWNpZmljYWxseSBpb21tdWZkIHN1cHBvcnQKaXMgbGFja2luZyBpbiB2ZHBhICh0aG91
Z2ggdGhlcmUgYXJlIGZpbmFsbHkgc29tZSBSRkMgcGF0Y2hlcyB0bwphZGRyZXNzIHRoYXQpLiBB
bGwgdGhpcyBpcyBmaW5lLCBjb3VsZCBiZSBlbm91Z2ggdG8gbW90aXZhdGUKYSB3b3JrIGxpa2Ug
dGhpcyBvbmUuIEJ1dCBJIGFtIHZlcnkgY3VyaW91cyB0byBrbm93IGlmIHRoZXJlCmlzIGFueSBv
dGhlciBjYXBhYmlsaXR5IGxhY2tpbmcgaW4gdmRwYS4gSSBhc2tlZCBhbHJlYWR5IGFuZCB5b3UK
ZGlkbid0IGFuc3dlciBzbyBJIGd1ZXNzIG5vdD8KCgoKCj4gWWlzaGFpIHdpbGwgcmV3b3JrIHRo
ZSBzZXJpZXMgd2l0aCB5b3VyIHJlbWFya3MsIHdlIGNhbiBsb29rIGFnYWluIG9uCj4gdjIsIHRo
YW5rcyBmb3IgYWxsIHRoZSBpbnB1dCEKPiAKPiBKYXNvbgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
