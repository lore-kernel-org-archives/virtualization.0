Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50ACBC001DB
	for <virtualization@archiver.kernel.org>; Fri, 11 Aug 2023 09:42:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C9082835CA;
	Fri, 11 Aug 2023 09:42:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C9082835CA
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VEqhdTts
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FywbQtSyFaLV; Fri, 11 Aug 2023 09:42:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 659B083437;
	Fri, 11 Aug 2023 09:42:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 659B083437
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 419E2C0072;
	Fri, 11 Aug 2023 09:42:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62363C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 09:42:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2A174403E7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 09:42:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2A174403E7
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VEqhdTts
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id piBAS57Z7yF7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 09:42:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4590C400D1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 09:42:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4590C400D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691746919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oqy0bfxdlbtDUy2srTvtr6YZyzwRaS7upj1yj7Rr484=;
 b=VEqhdTtspL2OsqMVd4HwXuukQoHx461/xyo1nYFJICOFlMHYf3rBes92spDN0MH5sZVART
 m6F4vhVCgyewP0AYb5hyYVRUSjpXSN0ReRKmPM/Abhs/oBp3/ttaWLff0bXbpPmB3RLRbq
 ot3/6ECsCd728y1DKZrD1BQTen8GVCU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-VsOjfDlNMEOLV3pcVHxAag-1; Fri, 11 Aug 2023 05:41:57 -0400
X-MC-Unique: VsOjfDlNMEOLV3pcVHxAag-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b9ba3d6191so19739591fa.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 02:41:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691746916; x=1692351716;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oqy0bfxdlbtDUy2srTvtr6YZyzwRaS7upj1yj7Rr484=;
 b=koPhOdzf+Zc19jQ4uGg/iTr5yqFDeajgol2bZUwOejawZnEefM5T0B4d/GJvwmKlhR
 KrL3gwtzPYav+suaxLTHrVNn9zgKJ1A3rmizwz9pzOD6wP6g41bCiN6XaMTco8erdvcF
 859+9nB351zgUinB/s+IVjiLWNLNetXUrDOSq28v18N6GsLh+hhvrJ/VGlmfjRTHF2qS
 k64pmueQtOfg+rjYoNayuTokqvJap7jQV/CqSJ8G9KgSXyZSbXwdLdsJ2JRdviVTofFX
 EithPFAr258RUhRl7HDi866d5h7ZGZi+apOPGyc/75RLVEeCprAiv0UwTwPt14zViGOU
 wsfQ==
X-Gm-Message-State: AOJu0YwT6jb0SZ0ZIKUkUDc1FH1nuUbM9exs/ei6gcoi/loc3X16ef8T
 s3+g1PaZpYiEMo5afFeY6Z2zgtnRvb1IuhmaODAzM2BS93/HxZ2uficTnU7BfTdWl9AZSzS8Voe
 uzvBZE1s61jN6pBalA2E9vDnD79nbj7Wee9X5nRxZms17P9fWflyBEDvLHw==
X-Received: by 2002:a2e:961a:0:b0:2b9:4b2b:89d8 with SMTP id
 v26-20020a2e961a000000b002b94b2b89d8mr1155724ljh.35.1691746916232; 
 Fri, 11 Aug 2023 02:41:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/D9QqLWpHj00noMnOjB/q4mgTD9QsQ30YCbBtg1emznV8InsC9P1rDtJ3ldV8Qp7DaHgXUHI/Nk8X8hHOwWk=
X-Received: by 2002:a2e:961a:0:b0:2b9:4b2b:89d8 with SMTP id
 v26-20020a2e961a000000b002b94b2b89d8mr1155711ljh.35.1691746915896; Fri, 11
 Aug 2023 02:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230811091539.1359865-1-jasowang@redhat.com>
 <20230811052435-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230811052435-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 11 Aug 2023 17:41:44 +0800
Message-ID: <CACGkMEuO+smLSY+dRvDOar=pq6MpOv3U9z6gX=xRUkHg494MFw@mail.gmail.com>
Subject: Re: [PATCH] virtio_vdpa: build affinity masks conditionally
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, xieyongji@bytedance.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

T24gRnJpLCBBdWcgMTEsIDIwMjMgYXQgNToyNeKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gRnJpLCBBdWcgMTEsIDIwMjMgYXQgMDU6MTU6MzlB
TSAtMDQwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+IFdlIHRyeSB0byBidWlsZCBhZmZpbml0eSBt
YXNrIHZpYSBjcmVhdGVfYWZmaW5pdHlfbWFza3MoKQo+ID4gdW5jb25kaXRpb25hbGx5IHdoaWNo
IG1heSBsZWFkIHNldmVyYWwgaXNzdWVzOgo+ID4KPiA+IC0gdGhlIGFmZmluaXR5IG1hc2sgaXMg
bm90IHVzZWQgZm9yIHBhcmVudCB3aXRob3V0IGFmZmluaXR5IHN1cHBvcnQKPiA+ICAgKG9ubHkg
VkRVU0Ugc3VwcG9ydCB0aGUgYWZmaW5pdHkgbm93KQo+ID4gLSB0aGUgbG9naWMgb2YgY3JlYXRl
X2FmZmluaXR5X21hc2tzKCkgbWlnaHQgbm90IHdvcmsgZm9yIGRldmljZXMKPiA+ICAgb3RoZXIg
dGhhbiBibG9jay4gRm9yIGV4YW1wbGUgaXQncyBub3QgcmFyZSBpbiB0aGUgbmV0d29ya2luZyBk
ZXZpY2UKPiA+ICAgd2hlcmUgdGhlIG51bWJlciBvZiBxdWV1ZXMgY291bGQgZXhjZWVkIHRoZSBu
dW1iZXIgb2YgQ1BVcy4gU3VjaAo+ID4gICBjYXNlIGJyZWFrcyB0aGUgY3VycmVudCBhZmZpbml0
eSBsb2dpYyB3aGljaCBpcyBiYXNlZCBvbgo+ID4gICBncm91cF9jcHVzX2V2ZW5seSgpIHdobyBh
c3N1bWVzIHRoZSBudW1iZXIgb2YgQ1BVcyBhcmUgbm90IGxlc3MgdGhhbgo+ID4gICB0aGUgbnVt
YmVyIG9mIGdyb3Vwcy4gVGhpcyBjYW4gdHJpZ2dlciBhIHdhcm5pbmdbMV06Cj4gPgo+ID4gICAg
ICAgaWYgKHJldCA+PSAwKQo+ID4gICAgICAgICAgICAgICBXQVJOX09OKG5yX3ByZXNlbnQgKyBu
cl9vdGhlcnMgPCBudW1ncnBzKTsKPiA+Cj4gPiBGaXhpbmcgdGhpcyBieSBvbmx5IGJ1aWxkIHRo
ZSBhZmZpbml0eSBtYXNrcyBvbmx5IHdoZW4KPiA+Cj4gPiAtIERyaXZlciBwYXNzZXMgYWZmaW5p
dHkgZGVzY3JpcHRvciwgZHJpdmVyIGxpa2UgdmlydGlvLWJsayBjYW4gbWFrZQo+ID4gICBzdXJl
IHRvIGxpbWl0IHRoZSBudW1iZXIgb2YgcXVldWVzIHdoZW4gaXQgZXhjZWVkcyB0aGUgbnVtYmVy
IG9mIENQVXMKPiA+IC0gUGFyZW50IHN1cHBvcnQgYWZmaW5pdHkgc2V0dGluZyBjb25maWcgb3Bz
Cj4gPgo+ID4gVGhpcyBoZWxwIHRvIGF2b2lkIHRoZSB3YXJuaW5nLiBNb3JlIG9wdGltaXphdGlv
bnMgY291bGQgYmUgZG9uZSBvbgo+ID4gdG9wLgo+ID4KPiA+IFsxXQo+ID4gWyAgNjgyLjE0NjY1
NV0gV0FSTklORzogQ1BVOiA2IFBJRDogMTU1MCBhdCBsaWIvZ3JvdXBfY3B1cy5jOjQwMCBncm91
cF9jcHVzX2V2ZW5seSsweDFhYS8weDFjMAo+ID4gWyAgNjgyLjE0NjY2OF0gQ1BVOiA2IFBJRDog
MTU1MCBDb21tOiB2ZHBhIE5vdCB0YWludGVkIDYuNS4wLXJjNWphc29uKyAjNzkKPiA+IFsgIDY4
Mi4xNDY2NzFdIEhhcmR3YXJlIG5hbWU6IFFFTVUgU3RhbmRhcmQgUEMgKGk0NDBGWCArIFBJSVgs
IDE5OTYpLCBCSU9TIHJlbC0xLjE2LjItMC1nZWExYjdhMDczMzkwLXByZWJ1aWx0LnFlbXUub3Jn
IDA0LzAxLzIwMTQKPiA+IFsgIDY4Mi4xNDY2NzNdIFJJUDogMDAxMDpncm91cF9jcHVzX2V2ZW5s
eSsweDFhYS8weDFjMAo+ID4gWyAgNjgyLjE0NjY3Nl0gQ29kZTogNGMgODkgZTAgNWIgNWQgNDEg
NWMgNDEgNWQgNDEgNWUgYzMgY2MgY2MgY2MgY2MgZTggMWIgYzQgNzQgZmYgNDggODkgZWYgZTgg
MTMgYWMgOTggZmYgNGMgODkgZTcgNDUgMzEgZTQgZTggMDggYWMgOTggZmYgZWIgYzIgPDBmPiAw
YiBlYiBiNiBlOCBmZCAwNSBjMyAwMCA0NSAzMSBlNCBlYiBlNSBjYyBjYyBjYyBjYyBjYyBjYyBj
YyBjYwo+ID4gWyAgNjgyLjE0NjY3OV0gUlNQOiAwMDE4OmZmZmZjOTAwMDIxNWY0OTggRUZMQUdT
OiAwMDAxMDI5Mwo+ID4gWyAgNjgyLjE0NjY4Ml0gUkFYOiAwMDAwMDAwMDAwMDFmMWUwIFJCWDog
MDAwMDAwMDAwMDAwMDA0MSBSQ1g6IDAwMDAwMDAwMDAwMDAwMDAKPiA+IFsgIDY4Mi4xNDY2ODRd
IFJEWDogZmZmZjg4ODEwOTkyMjA1OCBSU0k6IDAwMDAwMDAwMDAwMDAwNDEgUkRJOiAwMDAwMDAw
MDAwMDAwMDMwCj4gPiBbICA2ODIuMTQ2Njg2XSBSQlA6IGZmZmY4ODgxMDk5MjIwNTggUjA4OiBm
ZmZmYzkwMDAyMTVmNDk4IFIwOTogZmZmZmM5MDAwMjE1ZjRhMAo+ID4gWyAgNjgyLjE0NjY4N10g
UjEwOiAwMDAwMDAwMDAwMDE5OGQwIFIxMTogMDAwMDAwMDAwMDAwMDAzMCBSMTI6IGZmZmY4ODgx
MDdlMDI4MDAKPiA+IFsgIDY4Mi4xNDY2ODldIFIxMzogMDAwMDAwMDAwMDAwMDAzMCBSMTQ6IDAw
MDAwMDAwMDAwMDAwMzAgUjE1OiAwMDAwMDAwMDAwMDAwMDQxCj4gPiBbICA2ODIuMTQ2NjkyXSBG
UzogIDAwMDA3ZmVmNTIzMTU3NDAoMDAwMCkgR1M6ZmZmZjg4ODIzNzM4MDAwMCgwMDAwKSBrbmxH
UzowMDAwMDAwMDAwMDAwMDAwCj4gPiBbICA2ODIuMTQ2Njk1XSBDUzogIDAwMTAgRFM6IDAwMDAg
RVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzCj4gPiBbICA2ODIuMTQ2Njk2XSBDUjI6IDAw
MDA3ZmVmNTI1MDkwMDAgQ1IzOiAwMDAwMDAwMTEwZGJjMDA0IENSNDogMDAwMDAwMDAwMDM3MGVl
MAo+ID4gWyAgNjgyLjE0NjY5OF0gRFIwOiAwMDAwMDAwMDAwMDAwMDAwIERSMTogMDAwMDAwMDAw
MDAwMDAwMCBEUjI6IDAwMDAwMDAwMDAwMDAwMDAKPiA+IFsgIDY4Mi4xNDY3MDBdIERSMzogMDAw
MDAwMDAwMDAwMDAwMCBEUjY6IDAwMDAwMDAwZmZmZTBmZjAgRFI3OiAwMDAwMDAwMDAwMDAwNDAw
Cj4gPiBbICA2ODIuMTQ2NzAxXSBDYWxsIFRyYWNlOgo+ID4gWyAgNjgyLjE0NjcwM10gIDxUQVNL
Pgo+ID4gWyAgNjgyLjE0NjcwNV0gID8gX193YXJuKzB4N2IvMHgxMzAKPiA+IFsgIDY4Mi4xNDY3
MDldICA/IGdyb3VwX2NwdXNfZXZlbmx5KzB4MWFhLzB4MWMwCj4gPiBbICA2ODIuMTQ2NzEyXSAg
PyByZXBvcnRfYnVnKzB4MWM4LzB4MWUwCj4gPiBbICA2ODIuMTQ2NzE3XSAgPyBoYW5kbGVfYnVn
KzB4M2MvMHg3MAo+ID4gWyAgNjgyLjE0NjcyMV0gID8gZXhjX2ludmFsaWRfb3ArMHgxNC8weDcw
Cj4gPiBbICA2ODIuMTQ2NzIzXSAgPyBhc21fZXhjX2ludmFsaWRfb3ArMHgxNi8weDIwCj4gPiBb
ICA2ODIuMTQ2NzI3XSAgPyBncm91cF9jcHVzX2V2ZW5seSsweDFhYS8weDFjMAo+ID4gWyAgNjgy
LjE0NjcyOV0gID8gZ3JvdXBfY3B1c19ldmVubHkrMHgxNWMvMHgxYzAKPiA+IFsgIDY4Mi4xNDY3
MzFdICBjcmVhdGVfYWZmaW5pdHlfbWFza3MrMHhhZi8weDFhMAo+ID4gWyAgNjgyLjE0NjczNV0g
IHZpcnRpb192ZHBhX2ZpbmRfdnFzKzB4ODMvMHgxZDAKPiA+IFsgIDY4Mi4xNDY3MzhdICA/IF9f
cGZ4X2RlZmF1bHRfY2FsY19zZXRzKzB4MTAvMHgxMAo+ID4gWyAgNjgyLjE0Njc0Ml0gIHZpcnRu
ZXRfZmluZF92cXMrMHgxZjAvMHgzNzAKPiA+IFsgIDY4Mi4xNDY3NDddICB2aXJ0bmV0X3Byb2Jl
KzB4NTAxLzB4Y2QwCj4gPiBbICA2ODIuMTQ2NzQ5XSAgPyB2cF9tb2Rlcm5fZ2V0X3N0YXR1cysw
eDEyLzB4MjAKPiA+IFsgIDY4Mi4xNDY3NTFdICA/IGdldF9jYXBfYWRkci5pc3JhLjArMHgxMC8w
eGMwCj4gPiBbICA2ODIuMTQ2NzU0XSAgdmlydGlvX2Rldl9wcm9iZSsweDFhZi8weDI2MAo+ID4g
WyAgNjgyLjE0Njc1OV0gIHJlYWxseV9wcm9iZSsweDFhNS8weDQxMAo+ID4KPiA+IEZpeGVzOiAz
ZGFkNTY4MjNiNTMgKCJ2aXJ0aW8tdmRwYTogU3VwcG9ydCBpbnRlcnJ1cHQgYWZmaW5pdHkgc3By
ZWFkaW5nIG1lY2hhbmlzbSIpCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2Fu
Z0ByZWRoYXQuY29tPgo+Cj4gVGhpcyB3b24ndCBmaXggdGhlIGNhc2Ugd2hlcmUgYmxvY2sgaGFz
IG1vcmUgcXVldWVzIHRoYW4gQ1BVcyB0aG91Z2gsCj4gd2lsbCBpdD8KCkJsb2NrIHdpbGwgbGlt
aXQgdGhlIG51bWJlciBvZiBxdWV1ZXMgZHVyaW5nIGluaXRfdnEoKToKCiAgICAgICAgbnVtX3Zx
cyA9IG1pbl90KHVuc2lnbmVkIGludCwKICAgICAgICAgICAgICAgICAgICAgICAgbWluX25vdF96
ZXJvKG51bV9yZXF1ZXN0X3F1ZXVlcywgbnJfY3B1X2lkcyksCiAgICAgICAgICAgICAgICAgICAg
ICAgIG51bV92cXMpOwoKClRoYW5rcwoKPgo+ID4gLS0tCj4gPiAgZHJpdmVycy92aXJ0aW8vdmly
dGlvX3ZkcGEuYyB8IDE3ICsrKysrKysrKysrLS0tLS0tCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEx
IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb192ZHBhLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jCj4g
PiBpbmRleCA5NjExNjFkYTU5MDAuLjA2Y2U2ZDhjMmUwMCAxMDA2NDQKPiA+IC0tLSBhL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb192ZHBhLmMKPiA+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192
ZHBhLmMKPiA+IEBAIC0zNjYsMTEgKzM2NiwxNCBAQCBzdGF0aWMgaW50IHZpcnRpb192ZHBhX2Zp
bmRfdnFzKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBpbnQgbnZxcywKPiA+
ICAgICAgIHN0cnVjdCBpcnFfYWZmaW5pdHkgZGVmYXVsdF9hZmZkID0geyAwIH07Cj4gPiAgICAg
ICBzdHJ1Y3QgY3B1bWFzayAqbWFza3M7Cj4gPiAgICAgICBzdHJ1Y3QgdmRwYV9jYWxsYmFjayBj
YjsKPiA+ICsgICAgIGJvb2wgaGFzX2FmZmluaXR5ID0gZGVzYyAmJiBvcHMtPnNldF92cV9hZmZp
bml0eTsKPiA+ICAgICAgIGludCBpLCBlcnIsIHF1ZXVlX2lkeCA9IDA7Cj4gPgo+ID4gLSAgICAg
bWFza3MgPSBjcmVhdGVfYWZmaW5pdHlfbWFza3MobnZxcywgZGVzYyA/IGRlc2MgOiAmZGVmYXVs
dF9hZmZkKTsKPiA+IC0gICAgIGlmICghbWFza3MpCj4gPiAtICAgICAgICAgICAgIHJldHVybiAt
RU5PTUVNOwo+ID4gKyAgICAgaWYgKGhhc19hZmZpbml0eSkgewo+ID4gKyAgICAgICAgICAgICBt
YXNrcyA9IGNyZWF0ZV9hZmZpbml0eV9tYXNrcyhudnFzLCBkZXNjID8gZGVzYyA6ICZkZWZhdWx0
X2FmZmQpOwo+ID4gKyAgICAgICAgICAgICBpZiAoIW1hc2tzKQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgIHJldHVybiAtRU5PTUVNOwo+ID4gKyAgICAgfQo+ID4KPiA+ICAgICAgIGZvciAoaSA9
IDA7IGkgPCBudnFzOyArK2kpIHsKPiA+ICAgICAgICAgICAgICAgaWYgKCFuYW1lc1tpXSkgewo+
ID4gQEAgLTM4NiwyMCArMzg5LDIyIEBAIHN0YXRpYyBpbnQgdmlydGlvX3ZkcGFfZmluZF92cXMo
c3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsIHVuc2lnbmVkIGludCBudnFzLAo+ID4gICAgICAg
ICAgICAgICAgICAgICAgIGdvdG8gZXJyX3NldHVwX3ZxOwo+ID4gICAgICAgICAgICAgICB9Cj4g
Pgo+ID4gLSAgICAgICAgICAgICBpZiAob3BzLT5zZXRfdnFfYWZmaW5pdHkpCj4gPiArICAgICAg
ICAgICAgIGlmIChoYXNfYWZmaW5pdHkpCj4gPiAgICAgICAgICAgICAgICAgICAgICAgb3BzLT5z
ZXRfdnFfYWZmaW5pdHkodmRwYSwgaSwgJm1hc2tzW2ldKTsKPiA+ICAgICAgIH0KPiA+Cj4gPiAg
ICAgICBjYi5jYWxsYmFjayA9IHZpcnRpb192ZHBhX2NvbmZpZ19jYjsKPiA+ICAgICAgIGNiLnBy
aXZhdGUgPSB2ZF9kZXY7Cj4gPiAgICAgICBvcHMtPnNldF9jb25maWdfY2IodmRwYSwgJmNiKTsK
PiA+IC0gICAgIGtmcmVlKG1hc2tzKTsKPiA+ICsgICAgIGlmIChoYXNfYWZmaW5pdHkpCj4gPiAr
ICAgICAgICAgICAgIGtmcmVlKG1hc2tzKTsKPiA+Cj4gPiAgICAgICByZXR1cm4gMDsKPiA+Cj4g
PiAgZXJyX3NldHVwX3ZxOgo+ID4gICAgICAgdmlydGlvX3ZkcGFfZGVsX3Zxcyh2ZGV2KTsKPiA+
IC0gICAgIGtmcmVlKG1hc2tzKTsKPiA+ICsgICAgIGlmIChoYXNfYWZmaW5pdHkpCj4gPiArICAg
ICAgICAgICAgIGtmcmVlKG1hc2tzKTsKPiA+ICAgICAgIHJldHVybiBlcnI7Cj4gPiAgfQo+ID4K
PiA+IC0tCj4gPiAyLjM5LjMKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
