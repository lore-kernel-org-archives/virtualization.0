Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E497E95A8F
	for <virtualization@archiver.kernel.org>; Sun,  8 Oct 2023 05:21:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 08C4061067;
	Sun,  8 Oct 2023 05:21:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 08C4061067
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NKV/atcb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KbZsbcZN9C8N; Sun,  8 Oct 2023 05:21:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 562E760784;
	Sun,  8 Oct 2023 05:21:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 562E760784
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32F75C0039;
	Sun,  8 Oct 2023 05:21:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03AB7C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 05:21:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D242C821D4
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 05:21:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D242C821D4
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NKV/atcb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QNplH5QD_-0v
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 05:21:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C1804821D0
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 05:21:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C1804821D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696742479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n2Nj6xnsvoA9iFi7VyFH8pnKjaWY3HVRvayfbB8hPWM=;
 b=NKV/atcbXZ2MgRma8x+tP/UD0A2SNExRc/rgw4OSEf3K0j5/o8IBzNC1Mu2fnR0KXhC8sg
 NQ5YriwzaEPDbqRkkP97D7Tn9h7A4paU1xVpfn5AaAe5RhEbZ6z+GoOMo/lVvcnZ9vXtcJ
 6fQ6nuyhFfHMkqYpBL5OcR3uWusztMM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-8kPANGygM8e4Ok_CIrU7_Q-1; Sun, 08 Oct 2023 01:21:18 -0400
X-MC-Unique: 8kPANGygM8e4Ok_CIrU7_Q-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c030cea151so28520231fa.0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 07 Oct 2023 22:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696742476; x=1697347276;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n2Nj6xnsvoA9iFi7VyFH8pnKjaWY3HVRvayfbB8hPWM=;
 b=PKTuaa+6eNRen6Ew5Kb8pmg3w5dWPoyZLMGM4rxm7DbujXTZwAPBcfoLYxERE3c2kz
 yVDbVvM8c3Xy95fKwsN4zyRt7/s7c/4sABTjLlBPBQM5oLK6YGct3fHHvXofhNqOuTK6
 Ez4Gaz0bIoCG4dxQQO3wV+72qX+CHY3uTuF6doIZ4tciYFmpDfaLDv+okd6fqUnyPC5G
 kqDAMy+4wkQ/Wpai+sIm0VQHXyYPDZoZtzQ1LskqXSTdzPSUzR0JoJf+8rpnyMHRDAPS
 NfqmxEedl0GN1LaX2ma3rRbpqEY6tadeAE3OXZDeKFMdgm+p/NZNxFY/98C1PTY1SPbE
 O37g==
X-Gm-Message-State: AOJu0YwWSESpW27ay4iuuC9l41Fs1QJdOoHFWErM/DGsWv42Lznnqub6
 xBCR3/5DZOOScLnjvRhPvegOotrABrmAz2RtxqqAZ2TV29GtFnMyOuLuA3yAEf8hzxvmCwoSyKA
 YAAv9MMxQwb2nVL14TrU96sQNkCKJLp3B34KOkBmVP2aFTfEtaG4Xmg+LhQ==
X-Received: by 2002:ac2:4e88:0:b0:4fe:1681:9377 with SMTP id
 o8-20020ac24e88000000b004fe16819377mr9630081lfr.44.1696742476706; 
 Sat, 07 Oct 2023 22:21:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER/zYhzn0jvBIgdcTSYmEApRW78P2jQxly3Zzo2RzLXIJm4ROhWtDKebeluGAnDJIQdL0Wbu7Ug4s1typvJJM=
X-Received: by 2002:ac2:4e88:0:b0:4fe:1681:9377 with SMTP id
 o8-20020ac24e88000000b004fe16819377mr9630073lfr.44.1696742476393; Sat, 07 Oct
 2023 22:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695627660.git.hengqi@linux.alibaba.com>
 <1b4f480bed95951b6f4805d6c4e72dd1a315acab.1695627660.git.hengqi@linux.alibaba.com>
 <960e16021a529bc9df217b3c2546e0dc7532ce7b.camel@redhat.com>
 <21d1ab6c-b94c-44c5-b8c3-2d7e7aa32dd9@linux.alibaba.com>
In-Reply-To: <21d1ab6c-b94c-44c5-b8c3-2d7e7aa32dd9@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 8 Oct 2023 13:21:05 +0800
Message-ID: <CACGkMEsqV6KQNJnb9-4+Nt-0bEQ6n7kiZwuvLnBcTXRA+Gofyw@mail.gmail.com>
Subject: Re: [PATCH net v2 5/6] virtio-net: fix the vq coalescing setting for
 vq resize
To: Heng Qi <hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S . Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>,
 Gavin Li <gavinl@nvidia.com>
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

T24gVGh1LCBPY3QgNSwgMjAyMyBhdCAyOjEy4oCvUE0gSGVuZyBRaSA8aGVuZ3FpQGxpbnV4LmFs
aWJhYmEuY29tPiB3cm90ZToKPgo+Cj4KPiDlnKggMjAyMy8xMC8zIOS4i+WNiDY6NDEsIFBhb2xv
IEFiZW5pIOWGmemBkzoKPiA+IE9uIE1vbiwgMjAyMy0wOS0yNSBhdCAxNTo1MyArMDgwMCwgSGVu
ZyBRaSB3cm90ZToKPiA+PiBBY2NvcmRpbmcgdG8gdGhlIGRlZmluaXRpb24gb2YgdmlydHF1ZXVl
IGNvYWxlc2Npbmcgc3BlY1sxXToKPiA+Pgo+ID4+ICAgIFVwb24gZGlzYWJsaW5nIGFuZCByZS1l
bmFibGluZyBhIHRyYW5zbWl0IHZpcnRxdWV1ZSwgdGhlIGRldmljZSBNVVNUIHNldAo+ID4+ICAg
IHRoZSBjb2FsZXNjaW5nIHBhcmFtZXRlcnMgb2YgdGhlIHZpcnRxdWV1ZSB0byB0aG9zZSBjb25m
aWd1cmVkIHRocm91Z2ggdGhlCj4gPj4gICAgVklSVElPX05FVF9DVFJMX05PVEZfQ09BTF9UWF9T
RVQgY29tbWFuZCwgb3IsIGlmIHRoZSBkcml2ZXIgZGlkIG5vdCBzZXQKPiA+PiAgICBhbnkgVFgg
Y29hbGVzY2luZyBwYXJhbWV0ZXJzLCB0byAwLgo+ID4+Cj4gPj4gICAgVXBvbiBkaXNhYmxpbmcg
YW5kIHJlLWVuYWJsaW5nIGEgcmVjZWl2ZSB2aXJ0cXVldWUsIHRoZSBkZXZpY2UgTVVTVCBzZXQK
PiA+PiAgICB0aGUgY29hbGVzY2luZyBwYXJhbWV0ZXJzIG9mIHRoZSB2aXJ0cXVldWUgdG8gdGhv
c2UgY29uZmlndXJlZCB0aHJvdWdoIHRoZQo+ID4+ICAgIFZJUlRJT19ORVRfQ1RSTF9OT1RGX0NP
QUxfUlhfU0VUIGNvbW1hbmQsIG9yLCBpZiB0aGUgZHJpdmVyIGRpZCBub3Qgc2V0Cj4gPj4gICAg
YW55IFJYIGNvYWxlc2NpbmcgcGFyYW1ldGVycywgdG8gMC4KPiA+Pgo+ID4+IFdlIG5lZWQgdG8g
YWRkIHRoaXMgc2V0dGluZyBmb3IgdnEgcmVzaXplIChldGh0b29sIC1HKSB3aGVyZSB2cV9yZXNl
dCBoYXBwZW5zLgo+ID4+Cj4gPj4gWzFdIGh0dHBzOi8vbGlzdHMub2FzaXMtb3Blbi5vcmcvYXJj
aGl2ZXMvdmlydGlvLWRldi8yMDIzMDMvbXNnMDA0MTUuaHRtbAo+ID4+Cj4gPj4gRml4ZXM6IDM5
NGJkODc3NjRiNiAoInZpcnRpb19uZXQ6IHN1cHBvcnQgcGVyIHF1ZXVlIGludGVycnVwdCBjb2Fs
ZXNjZSBjb21tYW5kIikKPiA+PiBDYzogR2F2aW4gTGkgPGdhdmlubEBudmlkaWEuY29tPgo+ID4+
IFNpZ25lZC1vZmYtYnk6IEhlbmcgUWkgPGhlbmdxaUBsaW51eC5hbGliYWJhLmNvbT4KPiA+IEBK
YXNvbiwgc2luY2UgeW91IGNvbW1lbnRlZCBvbiB2MSwgd2FpdGluZyBmb3IgeW91ciBhY2suCj4g
Pgo+ID4+IC0tLQo+ID4+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMjcgKysrKysrKysr
KysrKysrKysrKysrKysrKysrCj4gPj4gICAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygr
KQo+ID4+Cj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZl
cnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4+IGluZGV4IDEyZWMzYWUxOWI2MC4uY2IxOWIyMjQ0MTli
IDEwMDY0NAo+ID4+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4+ICsrKyBiL2Ry
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4+IEBAIC0yODU1LDYgKzI4NTUsOSBAQCBzdGF0aWMg
dm9pZCB2aXJ0bmV0X2dldF9yaW5ncGFyYW0oc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiA+PiAg
ICAgIHJpbmctPnR4X3BlbmRpbmcgPSB2aXJ0cXVldWVfZ2V0X3ZyaW5nX3NpemUodmktPnNxWzBd
LnZxKTsKPiA+PiAgIH0KPiA+Pgo+ID4+ICtzdGF0aWMgaW50IHZpcnRuZXRfc2VuZF9jdHJsX2Nv
YWxfdnFfY21kKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ID4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdTE2IHZxbiwgdTMyIG1heF91c2VjcywgdTMyIG1heF9wYWNr
ZXRzKTsKPiA+PiArCj4gPj4gICBzdGF0aWMgaW50IHZpcnRuZXRfc2V0X3JpbmdwYXJhbShzdHJ1
Y3QgbmV0X2RldmljZSAqZGV2LAo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0
cnVjdCBldGh0b29sX3JpbmdwYXJhbSAqcmluZywKPiA+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzdHJ1Y3Qga2VybmVsX2V0aHRvb2xfcmluZ3BhcmFtICprZXJuZWxfcmluZywKPiA+
PiBAQCAtMjg5MCwxMiArMjg5MywzNiBAQCBzdGF0aWMgaW50IHZpcnRuZXRfc2V0X3JpbmdwYXJh
bShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ID4+ICAgICAgICAgICAgICAgICAgICAgIGVyciA9
IHZpcnRuZXRfdHhfcmVzaXplKHZpLCBzcSwgcmluZy0+dHhfcGVuZGluZyk7Cj4gPj4gICAgICAg
ICAgICAgICAgICAgICAgaWYgKGVycikKPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHJldHVybiBlcnI7Cj4gPj4gKwo+ID4+ICsgICAgICAgICAgICAgICAgICAgIC8qIFVwb24gZGlz
YWJsaW5nIGFuZCByZS1lbmFibGluZyBhIHRyYW5zbWl0IHZpcnRxdWV1ZSwgdGhlIGRldmljZSBt
dXN0Cj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICogc2V0IHRoZSBjb2FsZXNjaW5nIHBhcmFt
ZXRlcnMgb2YgdGhlIHZpcnRxdWV1ZSB0byB0aG9zZSBjb25maWd1cmVkCj4gPj4gKyAgICAgICAg
ICAgICAgICAgICAgICogdGhyb3VnaCB0aGUgVklSVElPX05FVF9DVFJMX05PVEZfQ09BTF9UWF9T
RVQgY29tbWFuZCwgb3IsIGlmIHRoZSBkcml2ZXIKPiA+PiArICAgICAgICAgICAgICAgICAgICAg
KiBkaWQgbm90IHNldCBhbnkgVFggY29hbGVzY2luZyBwYXJhbWV0ZXJzLCB0byAwLgo+ID4+ICsg
ICAgICAgICAgICAgICAgICAgICAqLwo+ID4+ICsgICAgICAgICAgICAgICAgICAgIGVyciA9IHZp
cnRuZXRfc2VuZF9jdHJsX2NvYWxfdnFfY21kKHZpLCB0eHEydnEoaSksCj4gPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmktPmludHJf
Y29hbF90eC5tYXhfdXNlY3MsCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdmktPmludHJfY29hbF90eC5tYXhfcGFja2V0cyk7Cj4g
Pj4gKyAgICAgICAgICAgICAgICAgICAgaWYgKGVycikKPiA+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHJldHVybiBlcnI7Cj4gPj4gKyAgICAgICAgICAgICAgICAgICAgLyogU2F2ZSBw
YXJhbWV0ZXJzICovCj4gPiBBcyBhIHZlcnkgbWlub3Igbml0LCBJIGd1ZXNzIHRoZSBjb21tZW50
IGNvdWxkIGJlIGRyb3BwZWQgaGVyZSAoc2ltaWxhcgo+ID4gdG8gcGF0Y2ggNC82KS4gQEhlbmcg
UWk6IHBsZWFzZSBkb24ndCByZXBvc3QganVzdCBmb3IgdGhpcywgbGV0J3Mgd2FpdAo+ID4gZm9y
IEphc29uJyBjb21tZW50cy4KPgo+IE9rLiBXZSBhcmUgY3VycmVudGx5IG9uIHRoZSBOYXRpb25h
bCBEYXkgaG9saWRheSwgSmFzb24gbWF5IHJlcGx5IGluIGEKPiBmZXcgZGF5cywgdGhhbmtzIQoK
V2l0aCB0aGUgY29tbWVudHMgcmVtb3ZlZC4KCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2Fu
Z0ByZWRoYXQuY29tPgoKVGhhbmtzCgo+Cj4gPiBDaGVlcnMsCj4gPgo+ID4gUGFvbG8KPgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
