Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956F8E6FE52
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 15:39:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 17DA3418FF;
	Fri, 22 Sep 2023 15:39:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 17DA3418FF
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ipQfZzw3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2L7rIO0OMeNN; Fri, 22 Sep 2023 15:39:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 25C944007B;
	Fri, 22 Sep 2023 15:39:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 25C944007B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EABA3C0071;
	Fri, 22 Sep 2023 15:39:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 630B6C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 15:39:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 293EC80F79
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 15:39:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 293EC80F79
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ipQfZzw3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E45d-jfsrecA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 15:39:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 451C980F02
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 15:39:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 451C980F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695397167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z1juo4wQ/7QEejr5BWLkPOZgP2Az8qd1gn01up27KMk=;
 b=ipQfZzw3orSOcXhcyqu98d/b3Y1TSLZ2g4weJ65qudvU1PkWC5SfnM0J6Yz1VybFB3qJWx
 90kTlyDbbpK+Z6BtIHujr3eBllUXSNRs/4lzu83Xp62CH6/RhPQ6AqE0SNxo++AmYZx2Dp
 9Af0yqjVmuCx38mHt/QuHglqNIb0eKw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-VJAGa6KCNd-blqcK75v02Q-1; Fri, 22 Sep 2023 11:39:26 -0400
X-MC-Unique: VJAGa6KCNd-blqcK75v02Q-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9adb6dd9e94so177826366b.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 08:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695397165; x=1696001965;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z1juo4wQ/7QEejr5BWLkPOZgP2Az8qd1gn01up27KMk=;
 b=asXMqhk2IKosmDo/vna0+JjoMo/hlulJ/Bs7+ISPqwSQ1a9fbsp/RFwyJi8+0jvqWe
 XIqtZXUKnUgWtdzH02DYLBfPBtGTRj9Q9rscYjp2SJ33KCYTO/vWHGefBnTdbaCp+S/h
 4zvkCiTcckr+IBot+rdxCcRn85+kb0HJJmQzci1TKrMqlhq6WkGIAb8NOxTEmkHt8+Qs
 38c0TcnqqOw6rw0CxK+nZ4z3tNoXhb1gy+ry8vXWWO8RALhzyT/KRdSGfX3MHXGpm5hI
 a1+2fsoLgm4m94dRP2dHKwbsaAv5UwdxpQgXwXJoh5rVQKmaTdM66s5UWT5P3waYaM/N
 6iBg==
X-Gm-Message-State: AOJu0Yya71Fr+SbdIhmdkWMJZ4HWI6UfQQngcK0a5RMRQA5avCStCOJv
 1Dmc01IHzmMzona30ZBbHVhXe9JvYJY4/KTmkZ8sRPM/qdwNGpS+0gKOEUmccywMvFc4Pry3Gef
 m4wa7RxHGF3YUI9W9Ly/kW656vgtXh8z9ib+xhJXotA==
X-Received: by 2002:a17:907:2cd4:b0:9ae:50de:1aa5 with SMTP id
 hg20-20020a1709072cd400b009ae50de1aa5mr6475867ejc.19.1695397164855; 
 Fri, 22 Sep 2023 08:39:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeGSdDPaRM6KjwV981O05NHicuJfuebKz9xcHmZZSEqMjJ8lDESI+n36o33v28MriHdfF1uw==
X-Received: by 2002:a17:907:2cd4:b0:9ae:50de:1aa5 with SMTP id
 hg20-20020a1709072cd400b009ae50de1aa5mr6475843ejc.19.1695397164463; 
 Fri, 22 Sep 2023 08:39:24 -0700 (PDT)
Received: from redhat.com ([2.52.150.187]) by smtp.gmail.com with ESMTPSA id
 w27-20020a17090633db00b009a2235ed496sm2923362eja.141.2023.09.22.08.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 08:39:23 -0700 (PDT)
Date: Fri, 22 Sep 2023 11:39:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20230922111342-mutt-send-email-mst@kernel.org>
References: <20230921125348-mutt-send-email-mst@kernel.org>
 <20230921170709.GS13733@nvidia.com>
 <20230921131035-mutt-send-email-mst@kernel.org>
 <20230921174450.GT13733@nvidia.com>
 <20230921135426-mutt-send-email-mst@kernel.org>
 <20230921181637.GU13733@nvidia.com>
 <20230921152802-mutt-send-email-mst@kernel.org>
 <20230921195345.GZ13733@nvidia.com>
 <CACGkMEt=dxhJP4mUUWh+x-TSxA5JQcvmhJbkLJMWdN8oXV6ojg@mail.gmail.com>
 <20230922122501.GP13733@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230922122501.GP13733@nvidia.com>
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

T24gRnJpLCBTZXAgMjIsIDIwMjMgYXQgMDk6MjU6MDFBTSAtMDMwMCwgSmFzb24gR3VudGhvcnBl
IHdyb3RlOgo+IE9uIEZyaSwgU2VwIDIyLCAyMDIzIGF0IDExOjAyOjUwQU0gKzA4MDAsIEphc29u
IFdhbmcgd3JvdGU6Cj4gPiBPbiBGcmksIFNlcCAyMiwgMjAyMyBhdCAzOjUz4oCvQU0gSmFzb24g
R3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT4gd3JvdGU6Cj4gPiA+Cj4gPiA+IE9uIFRodSwgU2Vw
IDIxLCAyMDIzIGF0IDAzOjM0OjAzUE0gLTA0MDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToK
PiA+ID4KPiA+ID4gPiB0aGF0J3MgZWFzeS9wcmFjdGljYWwuICBJZiBpbnN0ZWFkIFZEUEEgZ2l2
ZXMgdGhlIHNhbWUgc3BlZWQgd2l0aCBqdXN0Cj4gPiA+ID4gc2hhZG93IHZxIHRoZW4ga2VlcGlu
ZyB0aGlzIGhhY2sgaW4gdmZpbyBzZWVtcyBsaWtlIGxlc3Mgb2YgYSBwcm9ibGVtLgo+ID4gPiA+
IEZpbmFsbHkgaWYgVkRQQSBpcyBmYXN0ZXIgdGhlbiBtYXliZSB5b3Ugd2lsbCByZWNvbnNpZGVy
IHVzaW5nIGl0IDspCj4gPiA+Cj4gPiA+IEl0IGlzIG5vdCBhbGwgYWJvdXQgdGhlIHNwZWVkLgo+
ID4gPgo+ID4gPiBWRFBBIHByZXNlbnRzIGFub3RoZXIgbGFyZ2UgYW5kIGNvbXBsZXggc29mdHdh
cmUgc3RhY2sgaW4gdGhlCj4gPiA+IGh5cGVydmlzb3IgdGhhdCBjYW4gYmUgZWxpbWluYXRlZCBi
eSBzaW1wbHkgdXNpbmcgVkZJTy4KPiA+IAo+ID4gdkRQQSBzdXBwb3J0cyBzdGFuZGFyZCB2aXJ0
aW8gZGV2aWNlcyBzbyBob3cgZGlkIHlvdSBkZWZpbmUKPiA+IGNvbXBsZXhpdHk/Cj4gCj4gQXMg
SSBzYWlkLCBWRklPIGlzIGFscmVhZHkgcmVxdWlyZWQgZm9yIG90aGVyIGRldmljZXMgaW4gdGhl
c2UgVk1zLiBTbwo+IGFueXRoaW5nIGluY3JlbWVudGFsIG92ZXIgYmFzZS1saW5lIHZmaW8tcGNp
IGlzIGNvbXBsZXhpdHkgdG8KPiBtaW5pbWl6ZS4KPiAKPiBFdmVyeXRoaW5nIHZkcGEgZG9lcyBp
cyBlaXRoZXIgcmVkdW5kYW50IG9yIHVubmVjZXNzYXJ5IGNvbXBhcmVkIHRvCj4gVkZJTyBpbiB0
aGVzZSBlbnZpcm9ubWVudHMuCj4gCj4gSmFzb24KClllcyBidXQgeW91IGtub3cuIFRoZXJlIGFy
ZSBhbGwga2luZCBvZiBlbnZpcm9ubWVudHMuICBJIGd1ZXNzIHlvdQpjb25zaWRlciB5b3VycyB0
aGUgbW9zdCBtYWluc3RyZWFtIGFuZCBpbXBvcnRhbnQsIGFuZCBhcmUgc3VyZSBpdCB3aWxsCmFs
d2F5cyBzdGF5IGxpa2UgdGhpcy4gIEJ1dCBpZiB0aGVyZSdzIGEgZHJpdmVyIHRoYXQgZG9lcyB3
aGF0IHlvdSBuZWVkCnRoZW4geW91IHVzZSB0aGF0LiBZb3UgcmVhbGx5IHNob3VsZCBiZSBleHBs
YWluaW5nIHdoYXQgdmRwYQoqZG9lcyBub3QqIGRvIHRoYXQgeW91IG5lZWQuCgpCdXQgYW55d2F5
LCBpZiBBbGV4IHdhbnRzIHRvIG1haW50YWluIHRoaXMgaXQncyBub3QgdG9vIGJhZCwKYnV0IEkg
d291bGQgbGlrZSB0byBzZWUgbW9yZSBjb2RlIG1vdmUgaW50byBhIGxpYnJhcnkKbGl2aW5nIHVu
ZGVyIHRoZSB2aXJ0aW8gZGlyZWN0b3J5LiBBcyBpdCBpcyBzdHJ1Y3R1cmVkIG5vdwppdCB3aWxs
IG1ha2UgdmlydGlvIGNvcmUgZGV2ZWxvcG1lbnQgaGFyZGVyLgoKLS0gCk1TVAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
