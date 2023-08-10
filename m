Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C36EB64DD
	for <virtualization@archiver.kernel.org>; Thu, 10 Aug 2023 03:11:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD787418A1;
	Thu, 10 Aug 2023 03:11:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AD787418A1
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VjhS7Dc/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U3MJUPws_knC; Thu, 10 Aug 2023 03:11:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B32EB40547;
	Thu, 10 Aug 2023 03:11:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B32EB40547
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D763C0072;
	Thu, 10 Aug 2023 03:11:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92C15C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 03:11:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7A20060F3C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 03:11:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A20060F3C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VjhS7Dc/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TPcD5yfKNyRk
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 03:11:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A9B9D60BAC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 03:11:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A9B9D60BAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691637083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BjSq2/jRZy5vhViCmQhbUeZdXoVE7rcUYsh36jxfIHo=;
 b=VjhS7Dc/C1YOB2FOrQUsttXBw6MGn0JOLHFZpelLCGu6Nxj2Wl8tQ4c7+C0hWONiPAHOiW
 Ykz9gRU/7A9/SvCsN0Hmb3s/Q9iIVkL+G5SQLiNuhl5dHlOBsW5WMcf7jduqg96ewftQV3
 72y96qTwUKn7Klb2KlX5g7pn8Q7DRpY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-AIONGIkoMtqoJeRwaiKqfw-1; Wed, 09 Aug 2023 23:11:21 -0400
X-MC-Unique: AIONGIkoMtqoJeRwaiKqfw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b9bf493456so4593331fa.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Aug 2023 20:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691637080; x=1692241880;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BjSq2/jRZy5vhViCmQhbUeZdXoVE7rcUYsh36jxfIHo=;
 b=kenH+gYrGt4JhQo1FzWlfRx21qa4zq1D2l08caIKyLbU+mwCBsp6EDw2Upc9IdU2Kq
 DXPTwRohJRIuS5TZPUpt4oLm45q7ZMeYhyCo+Xg+P/roxeSapZOENyH5YJxnEak1NXAC
 82+9bmI/vvNIXlEzTL9A4ewHoD40O18LLJ6wAx4MuoTOLgYWmkZr0B2XOKTQPzBea2Ci
 lV0H711JHHvM4zg8kP+MavhnovXkjIzmPlHL0+GVJsHUBKu0JlbRVD3QtHy/X6gWz4w1
 sQh+qC4QmvncH1lthOv55VN5o1pE5P0M0dV9vOuyaeAzvCal0fq9i+jNcqO0R0vT39qG
 xayg==
X-Gm-Message-State: AOJu0YxZpmAjC0gwZF/o3dxT0DlPY42/DZujqUF+totmekidehWy0q3w
 K2MCkeOwRcPOqDmzr6PN/CoEHxE5xHswlvAJP3VPJk9QcCLXXLLCNWyGX0tsIdnXqXJkiAk20lI
 wKSzyyQ8D5SfzvH47I5e4aNhxtSAi5liCCMMonHc82jMQWwnxTSvS6i1jWw==
X-Received: by 2002:a2e:99c8:0:b0:2b9:e623:c2d8 with SMTP id
 l8-20020a2e99c8000000b002b9e623c2d8mr713263ljj.44.1691637080065; 
 Wed, 09 Aug 2023 20:11:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzk68fYfUkbasLCWhJFVsZVjtwL3zuwTfJ/vuTVo0nFCp+aqUEoqlGOG6tDMXmepGT4QFTUr47CTuqGuzptX8=
X-Received: by 2002:a2e:99c8:0:b0:2b9:e623:c2d8 with SMTP id
 l8-20020a2e99c8000000b002b9e623c2d8mr713255ljj.44.1691637079678; Wed, 09 Aug
 2023 20:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230809031329.251362-1-jasowang@redhat.com>
 <66687029c1235e56d9279800ceb026dca029c966.camel@nvidia.com>
 <CACGkMEvETiKpx3-EsVejLe9EkSroaoFjJkLBEMmh71YU+1GjGA@mail.gmail.com>
 <20230809025039-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230809025039-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 10 Aug 2023 11:11:08 +0800
Message-ID: <CACGkMEvHe09tQttaV-eotf+kZMHajLuRJPd0iF6TB-H9xmFNJA@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: set queues after driver_ok
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>
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

T24gV2VkLCBBdWcgOSwgMjAyMyBhdCAyOjUx4oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBXZWQsIEF1ZyAwOSwgMjAyMyBhdCAwMjo0NToxN1BN
ICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gT24gV2VkLCBBdWcgOSwgMjAyMyBhdCAyOjIz
4oCvUE0gRHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVhQG52aWRpYS5jb20+IHdyb3RlOgo+ID4gPgo+
ID4gPiBPbiBUdWUsIDIwMjMtMDgtMDggYXQgMjM6MTMgLTA0MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4gPiA+ID4gQ29tbWl0IDI1MjY2MTI4ZmUxNiAoInZpcnRpby1uZXQ6IGZpeCByYWNlIGJldHdl
ZW4gc2V0IHF1ZXVlcyBhbmQKPiA+ID4gPiBwcm9iZSIpIHRyaWVzIHRvIGZpeCB0aGUgcmFjZSBi
ZXR3ZWVuIHNldCBxdWV1ZXMgYW5kIHByb2JlIGJ5IGNhbGxpbmcKPiA+ID4gPiBfdmlydG5ldF9z
ZXRfcXVldWVzKCkgYmVmb3JlIERSSVZFUl9PSyBpcyBzZXQuIFRoaXMgdmlvbGF0ZXMgdmlydGlv
Cj4gPiA+ID4gc3BlYy4gRml4aW5nIHRoaXMgYnkgc2V0dGluZyBxdWV1ZXMgYWZ0ZXIgdmlydGlv
X2RldmljZV9yZWFkeSgpLgo+ID4gPiA+Cj4gPiA+ID4gRml4ZXM6IDI1MjY2MTI4ZmUxNiAoInZp
cnRpby1uZXQ6IGZpeCByYWNlIGJldHdlZW4gc2V0IHF1ZXVlcyBhbmQgcHJvYmUiKQo+ID4gPiA+
IFJlcG9ydGVkLWJ5OiBEcmFnb3MgVGF0dWxlYSA8ZHRhdHVsZWFAbnZpZGlhLmNvbT4KPiA+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gPiA+
IC0tLQo+ID4gPiA+IFRoZSBwYXRjaCBpcyBuZWVkZWQgZm9yIC1zdGFibGUuCj4gPiA+ID4gLS0t
Cj4gPiA+ID4gIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDQgKystLQo+ID4gPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+ID4gPiA+Cj4gPiA+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYwo+ID4gPiA+IGluZGV4IDEyNzBjOGQyMzQ2My4uZmYwMzkyMWU0NmRmIDEwMDY0
NAo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiA+ICsrKyBiL2Ry
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiA+IEBAIC00MjE5LDggKzQyMTksNiBAQCBzdGF0
aWMgaW50IHZpcnRuZXRfcHJvYmUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gPiA+ID4g
ICAgICAgICBpZiAodmktPmhhc19yc3MgfHwgdmktPmhhc19yc3NfaGFzaF9yZXBvcnQpCj4gPiA+
ID4gICAgICAgICAgICAgICAgIHZpcnRuZXRfaW5pdF9kZWZhdWx0X3Jzcyh2aSk7Cj4gPiA+ID4K
PiA+ID4gPiAtICAgICAgIF92aXJ0bmV0X3NldF9xdWV1ZXModmksIHZpLT5jdXJyX3F1ZXVlX3Bh
aXJzKTsKPiA+ID4gPiAtCj4gPiA+ID4gICAgICAgICAvKiBzZXJpYWxpemUgbmV0ZGV2IHJlZ2lz
dGVyICsgdmlydGlvX2RldmljZV9yZWFkeSgpIHdpdGggbmRvX29wZW4oKQo+ID4gPiA+ICovCj4g
PiA+ID4gICAgICAgICBydG5sX2xvY2soKTsKPiA+ID4gPgo+ID4gPiA+IEBAIC00MjMzLDYgKzQy
MzEsOCBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcHJvYmUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZk
ZXYpCj4gPiA+ID4KPiA+ID4gPiAgICAgICAgIHZpcnRpb19kZXZpY2VfcmVhZHkodmRldik7Cj4g
PiA+ID4KPiA+ID4gPiArICAgICAgIF92aXJ0bmV0X3NldF9xdWV1ZXModmksIHZpLT5jdXJyX3F1
ZXVlX3BhaXJzKTsKPiA+ID4gPiArCj4gPiA+ID4gICAgICAgICAvKiBhIHJhbmRvbSBNQUMgYWRk
cmVzcyBoYXMgYmVlbiBhc3NpZ25lZCwgbm90aWZ5IHRoZSBkZXZpY2UuCj4gPiA+ID4gICAgICAg
ICAgKiBXZSBkb24ndCBmYWlsIHByb2JlIGlmIFZJUlRJT19ORVRfRl9DVFJMX01BQ19BRERSIGlz
IG5vdCB0aGVyZQo+ID4gPiA+ICAgICAgICAgICogYmVjYXVzZSBtYW55IGRldmljZXMgd29yayBm
aW5lIHdpdGhvdXQgZ2V0dGluZyBNQUMgZXhwbGljaXRseQo+ID4gPgo+ID4gPiBUaGFua3MgZm9y
IHRoZSBxdWljayBmaXguIERvZXNuJ3QgdGhpcyBmaXggdGhvdWdoIGJyaW5nIGJhY2sgdGhlIG9y
aWdpbmFsIHJhY2UKPiA+ID4gdGhhdCB3YXMgZml4ZWQgaW4gY29tbWl0IDI1MjY2MTI4ZmUxNiAo
InZpcnRpby1uZXQ6IGZpeCByYWNlIGJldHdlZW4gc2V0IHF1ZXVlcwo+ID4gPiBhbmQgcHJvYmUi
KT8gT3IgaXMgYmVpbmcgdW5kZXIgdGhlIHNhbWUgcm50bF9sb2NrIHNlc3Npb24gYXMgcmVnaXN0
ZXJfbmV0ZGV2Cj4gPiA+IGVub3VnaCB0byBhdm9pZCB0aGUgcmFjZT8KPiA+Cj4gPiBZZXMsIHJ0
bmwgbmVlZHMgdG8gYmUgaGVsZCBmb3IgdXNlcnNwYWNlIHJlcXVlc3RzIHRvIGNoYW5nZSB0aGUg
bnVtYmVyCj4gPiBvZiBxdWV1ZXMuIFNvIHdlIGFyZSBzZXJpYWxpemVkIGluIHRoaXMgd2F5Lgo+
ID4KPiA+IFRoYW5rcwo+Cj4gbWF5YmUgcG9zdCB2MiBhZGRpbmcgdGhpcyBpbiB0aGUgY29tbWl0
IGxvZy4KCk9rLCB2MiB3aWxsIGJlIHBvc3RlZCBzb29uLgoKVGhhbmtzCgo+Cj4KPiA+ID4KPiA+
ID4gVGhhbmtzLAo+ID4gPiBEcmFnb3MKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
