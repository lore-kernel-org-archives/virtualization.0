Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AF4C636D3
	for <virtualization@archiver.kernel.org>; Tue, 31 Jan 2023 03:16:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB928813B0;
	Tue, 31 Jan 2023 03:16:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CB928813B0
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e1MHRAEU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RvlgvNjNj_TZ; Tue, 31 Jan 2023 03:16:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2C714813AA;
	Tue, 31 Jan 2023 03:16:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2C714813AA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0898EC0032;
	Tue, 31 Jan 2023 03:16:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36478C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 03:16:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0B4DE400B8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 03:16:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0B4DE400B8
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=e1MHRAEU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i2tw977FUls7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 03:16:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8BD0B400AF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8BD0B400AF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 03:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675134992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yWiJjxw4dIrl+Ur1IaXYBn5fUEbMiL3kVPQT9CCa9z4=;
 b=e1MHRAEU7BSv42TirqRjZet/ljJUtNfK0lEDv39PSxBVy6aFw/nTCaFbZnl7lBa3HFdHdC
 GSaWJwrfyUBFcNIr7cbNWrBwNfB64yXQ/zdgE3FUR/EqUEt4LJynBxKGLOYyCm/3Rjo2bT
 jjMPPkWnJk/NphRHoOxzuY9LCnbix2g=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-38-CJAzBD5sN6-CO_51JjeFUQ-1; Mon, 30 Jan 2023 22:16:31 -0500
X-MC-Unique: CJAzBD5sN6-CO_51JjeFUQ-1
Received: by mail-oi1-f197.google.com with SMTP id
 bg13-20020a056808178d00b00364af0a66f9so5903726oib.14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 19:16:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yWiJjxw4dIrl+Ur1IaXYBn5fUEbMiL3kVPQT9CCa9z4=;
 b=Fz0i1Rj4ifmNIJ8NZIuI1xKIMPEMizddA6TCKhOAJe1mXtG2H5yfJ5cRas91JWWPhA
 Fx2RdJM7OMX6N1bUU+7sqKx7EFCHef9rlKD9dHFq0JLT2y462d0/XQAGBjq758OUj2e+
 cfh+f7vuSKiwkAyUTdeJ1pjitoGMS+KEU2ioT2W7F8ww4klGFdx38z6KfZFXTrt8/UX8
 aVRIHOffd8k3cd2b6fwzUm5cQriyGtnTbdm+bnfC3d/Aho17LtZ8w06A/aOS5/vAqVBU
 ZErgCh8mYKtI0zFZb5QkG0/tgdQ9l+7Kazdmj/cgnzsEY3r9OkRvMA2nhehIY03+PT0v
 hZyw==
X-Gm-Message-State: AO0yUKW/V1W7iiTHqwqBPy6bC6dk7dWe0ubxFMy5h9JuyNHAIVAu3GaI
 6QY9xqz9LNVQCoh1HHdj6s1TZh692ya1sZfw+bPpXkvlwces9JXa/utMQ0wNC5YKqERZyj1f1gX
 M5f7RlR1TiTRu0UwwcmUcCOmkeVVQd5jO35BjaQCmB83CTsx9eD9RrD5wgA==
X-Received: by 2002:a05:6870:959e:b0:163:9cea:eea7 with SMTP id
 k30-20020a056870959e00b001639ceaeea7mr566780oao.35.1675134990465; 
 Mon, 30 Jan 2023 19:16:30 -0800 (PST)
X-Google-Smtp-Source: AK7set96OS1U2BfjLs7lmzFI49lAg6/8VPvlF266fjVSZY7JzDpLd0NGhvpOhMye+Yt56NiHsiUluGiQ8gkYcRC/qWU=
X-Received: by 2002:a05:6870:959e:b0:163:9cea:eea7 with SMTP id
 k30-20020a056870959e00b001639ceaeea7mr566764oao.35.1675134990144; Mon, 30 Jan
 2023 19:16:30 -0800 (PST)
MIME-Version: 1.0
References: <20230118164359.1523760-1-eperezma@redhat.com>
 <20230118164359.1523760-3-eperezma@redhat.com>
 <CACGkMEtq_ZOoLaS=vGYPZUc45oP8ENa+5H1KVCF1NS=-SwuPQw@mail.gmail.com>
 <CAJaqyWetovvndcU=pu_kPNUNYkgao=HsENnrKCzoHdK7RBjyAQ@mail.gmail.com>
 <CACGkMEvX5Li3c8oW2ARc0OAutfDK2=cckjuEf4KQRuNKfH1hfg@mail.gmail.com>
 <CAJaqyWeWaddX9KjZWs8n9eqx8u-Lk4Nj+VVH_jDh38URuZWJdA@mail.gmail.com>
In-Reply-To: <CAJaqyWeWaddX9KjZWs8n9eqx8u-Lk4Nj+VVH_jDh38URuZWJdA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 31 Jan 2023 11:16:19 +0800
Message-ID: <CACGkMEubK3jRyKy5_TsRvKtcUQ2dYnr_hEnWwds4ZtewVsxz_Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] vringh: fetch used_idx from vring at vringh_init_iotlb
To: Eugenio Perez Martin <eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, lulu@redhat.com, mst@redhat.com,
 linux-kernel@vger.kernel.org, Gautam Dawar <gdawar@xilinx.com>,
 virtualization@lists.linux-foundation.org, leiyang@redhat.com,
 "Longpeng \(Mike,
 Cloud Infrastructure Service Product Dept.\)" <longpeng2@huawei.com>
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

T24gVHVlLCBKYW4gMzEsIDIwMjMgYXQgMTI6MzkgQU0gRXVnZW5pbyBQZXJleiBNYXJ0aW4KPGVw
ZXJlem1hQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gU3VuLCBKYW4gMjksIDIwMjMgYXQgNzow
MSBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBU
aHUsIEphbiAxOSwgMjAyMyBhdCA0OjExIFBNIEV1Z2VuaW8gUGVyZXogTWFydGluCj4gPiA8ZXBl
cmV6bWFAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+Cj4gPiA+IE9uIFRodSwgSmFuIDE5LCAyMDIz
IGF0IDQ6MjAgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+
ID4KPiA+ID4gPiBPbiBUaHUsIEphbiAxOSwgMjAyMyBhdCAxMjo0NCBBTSBFdWdlbmlvIFDDqXJl
eiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4gU3RhcnRp
bmcgZnJvbSBhbiB1c2VkX2lkeCBkaWZmZXJlbnQgdGhhbiAwIGlzIG5lZWRlZCBpbiB1c2UgY2Fz
ZXMgbGlrZQo+ID4gPiA+ID4gdmlydHVhbCBtYWNoaW5lIG1pZ3JhdGlvbi4gIE5vdCBkb2luZyBz
byBhbmQgbGV0dGluZyB0aGUgY2FsbGVyIHNldCBhbgo+ID4gPiA+ID4gYXZhaWwgaWR4IGRpZmZl
cmVudCB0aGFuIDAgY2F1c2VzIGRlc3RpbmF0aW9uIGRldmljZSB0byB0cnkgdG8gdXNlIG9sZAo+
ID4gPiA+ID4gYnVmZmVycyB0aGF0IHNvdXJjZSBkcml2ZXIgYWxyZWFkeSByZWNvdmVyIGFuZCBh
cmUgbm90IGF2YWlsYWJsZQo+ID4gPiA+ID4gYW55bW9yZS4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBX
aGlsZSBjYWxsZXJzIGxpa2UgdmRwYV9zaW0gc2V0IGF2YWlsX2lkeCBkaXJlY3RseSBpdCBkb2Vz
IG5vdCBzZXQKPiA+ID4gPiA+IHVzZWRfaWR4LiAgSW5zdGVhZCBvZiBsZXQgdGhlIGNhbGxlciBk
byB0aGUgYXNzaWdubWVudCwgZmV0Y2ggaXQgZnJvbQo+ID4gPiA+ID4gdGhlIGd1ZXN0IGF0IGlu
aXRpYWxpemF0aW9uIGxpa2Ugdmhvc3Qta2VybmVsIGRvLgo+ID4gPiA+ID4KPiA+ID4gPiA+IFRv
IHBlcmZvcm0gdGhlIHNhbWUgYXQgdnJpbmdfa2VybmVsX2luaXQgYW5kIHZyaW5nX3VzZXJfaW5p
dCBpcyBsZWZ0IGZvcgo+ID4gPiA+ID4gdGhlIGZ1dHVyZS4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiA+ID4g
PiA+IC0tLQo+ID4gPiA+ID4gIGRyaXZlcnMvdmhvc3QvdnJpbmdoLmMgfCAyNSArKysrKysrKysr
KysrKysrKysrKysrKy0tCj4gPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pCj4gPiA+ID4gPgo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmhvc3QvdnJpbmdoLmMgYi9kcml2ZXJzL3Zob3N0L3ZyaW5naC5jCj4gPiA+ID4gPiBpbmRl
eCAzM2ViOTQxZmNmMTUuLjBlZWQ4MjUxOTdmMiAxMDA2NDQKPiA+ID4gPiA+IC0tLSBhL2RyaXZl
cnMvdmhvc3QvdnJpbmdoLmMKPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdnJpbmdoLmMK
PiA+ID4gPiA+IEBAIC0xMzAxLDYgKzEzMDEsMTcgQEAgc3RhdGljIGlubGluZSBpbnQgcHV0dXNl
ZF9pb3RsYihjb25zdCBzdHJ1Y3QgdnJpbmdoICp2cmgsCj4gPiA+ID4gPiAgICAgICAgIHJldHVy
biAwOwo+ID4gPiA+ID4gIH0KPiA+ID4gPiA+Cj4gPiA+ID4gPiArLyoqCj4gPiA+ID4gPiArICog
dnJpbmdoX3VwZGF0ZV91c2VkX2lkeCAtIGZldGNoIHVzZWQgaWR4IGZyb20gZHJpdmVyJ3MgdXNl
ZCBzcGxpdCB2cmluZwo+ID4gPiA+ID4gKyAqIEB2cmg6IFRoZSB2cmluZy4KPiA+ID4gPiA+ICsg
Kgo+ID4gPiA+ID4gKyAqIFJldHVybnMgLWVycm5vIG9yIDAuCj4gPiA+ID4gPiArICovCj4gPiA+
ID4gPiArc3RhdGljIGlubGluZSBpbnQgdnJpbmdoX3VwZGF0ZV91c2VkX2lkeChzdHJ1Y3QgdnJp
bmdoICp2cmgpCj4gPiA+ID4gPiArewo+ID4gPiA+ID4gKyAgICAgICByZXR1cm4gZ2V0dTE2X2lv
dGxiKHZyaCwgJnZyaC0+bGFzdF91c2VkX2lkeCwgJnZyaC0+dnJpbmcudXNlZC0+aWR4KTsKPiA+
ID4gPiA+ICt9Cj4gPiA+ID4gPiArCj4gPiA+ID4gPiAgLyoqCj4gPiA+ID4gPiAgICogdnJpbmdo
X2luaXRfaW90bGIgLSBpbml0aWFsaXplIGEgdnJpbmdoIGZvciBhIHJpbmcgd2l0aCBJT1RMQi4K
PiA+ID4gPiA+ICAgKiBAdnJoOiB0aGUgdnJpbmdoIHRvIGluaXRpYWxpemUuCj4gPiA+ID4gPiBA
QCAtMTMxOSw4ICsxMzMwLDE4IEBAIGludCB2cmluZ2hfaW5pdF9pb3RsYihzdHJ1Y3QgdnJpbmdo
ICp2cmgsIHU2NCBmZWF0dXJlcywKPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICBzdHJ1
Y3QgdnJpbmdfYXZhaWwgKmF2YWlsLAo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgIHN0
cnVjdCB2cmluZ191c2VkICp1c2VkKQo+ID4gPiA+ID4gIHsKPiA+ID4gPgo+ID4gPiA+IFdoaWxl
IGF0IHRoaXMsIEkgd29uZGVyIGlmIGl0J3MgYmV0dGVyIHRvIGhhdmUgYSBkZWRpY2F0ZWQgcGFy
YW1ldGVyCj4gPiA+ID4gZm9yIGxhc3RfYXZhaWxfaWR4Pwo+ID4gPiA+Cj4gPiA+Cj4gPiA+IEkg
YWxzbyBoYWQgdGhhdCB0aG91Z2h0LiBUbyBkaXJlY3RseSBhc3NpZ24gbGFzdF9hdmFpbF9pZHgg
aXMgbm90IGEKPiA+ID4gc3BlY2lhbGx5IGVsZWdhbnQgQVBJIElNTy4KPiA+ID4KPiA+ID4gTWF5
YmUgZXhwb3NlIGEgd2F5IHRvIGZldGNoIHVzZWRfaWR4IGZyb20gZGV2aWNlIHZyaW5nIGFuZCBw
YXNzCj4gPiA+IHVzZWRfaWR4IGFzIHBhcmFtZXRlciB0b28/Cj4gPgo+ID4gSWYgSSB3YXMgbm90
IHdyb25nLCB3ZSBjYW4gc3RhcnQgZnJvbSBsYXN0X2F2YWlsX2lkeCwgZm9yIHVzZWRfaWR4IGl0
Cj4gPiBpcyBvbmx5IG5lZWRlZCBmb3IgaW5mbGlnaHQgZGVzY3JpcHRvcnMgd2hpY2ggbWlnaHQg
cmVxdWlyZSBvdGhlcgo+ID4gQVBJcz8KPiA+Cj4gPiAoQWxsIHRoZSBjdXJyZW50IHZEUEEgdXNl
ciBvZiB2cmluZ2ggaXMgZG9pbmcgaW4gb3JkZXIgcHJvY2Vzc2luZykKPiA+Cj4KPiBUaGF0IHdh
cyBhY3R1YWxseSBteSBmaXJzdCBhdHRlbXB0IGFuZCBpdCB3b3JrcyBlcXVhbGx5IHdlbGwgZm9y
IHRoZQo+IG1vbWVudCwgYnV0IGl0IGRpdmVyZ2VzIGZyb20gdmhvc3Qta2VybmVsIGJlaGF2aW9y
IGZvciBsaXR0bGUgYmVuZWZpdC4KPgo+IFRvIGFzc2lnbiBib3RoIHZhbHVlcyBhdCBzZXRfdnJp
bmdfYmFzZSBtZWFuIHRoYXQgaWYgdkRQQSBpbnRyb2R1Y2VzCj4gYW4gKGh5cG90aGV0aWNhbCkg
VkhPU1RfVkRQQV9GX0lORkxJR0hUIGJhY2tlbmQgZmVhdHVyZSBpbiB0aGUgZnV0dXJlLAo+IHRo
ZSBpbml0aWFsaXphdGlvbiBwcm9jZXNzIHdvdWxkIHZhcnkgYSBsb3Q6Cj4gKiBXaXRob3V0IHRo
YXQgZmVhdHVyZSwgdGhlIHVzZWRfaWR4IHN0YXJ0cyB3aXRoIDAsIGFuZCB0aGUgYXZhaWwgb25l
Cj4gaXMgMCBvciB3aGF0ZXZlciB2YWx1ZSB0aGUgdXNlciBzZXQgd2l0aCB2cmluZ19zZXRfYmFz
ZS4KPiAqIFdpdGggdGhhdCBmZWF0dXJlLCB0aGUgZGV2aWNlIHdpbGwgcmVhZCBndWVzdCdzIHVz
ZWRfaWR4IGFzCj4gdmhvc3Qta2VybmVsPyBXZSB3b3VsZCBlbmFibGUgYSBuZXcgaW9jdGwgdG8g
c2V0IGl0LCBvciBleHBhbmQKPiBzZXRfYmFzZSB0byBpbmNsdWRlIHVzZWRfaWR4LCBlZmZlY3Rp
dmVseSBkaXZlcnRpbmcgZnJvbSB2aG9zdC1rZXJuZWw/CgpBZGRpbmcgTG9uZ3Blbmcgd2hvIGlz
IGxvb2tpbmcgYXQgdGhpcy4KCldlIGNhbiBsZWF2ZSB0aGlzIHRvIHRoZSBjYWxsZXIgdG8gZGVj
aWRlLgoKQnR3LCBhIHF1ZXN0aW9uLCBhdCB3aGljaCBjYXNlIHRoZSBkZXZpY2UgdXNlZCBpbmRl
eCBkb2VzIG5vdCBlcXVhbCB0bwp0aGUgdXNlZCBpbmRleCBpbiB0aGUgdnJpbmcgd2hlbiB0aGUg
ZGV2aWNlIGlzIHN1c3BlbmRlZD8gSSB0aGluayB0aGUKY29ycmVjdCB3YXkgaXMgdG8gZmx1c2gg
dGhlIHBlbmRpbmcgdXNlZCBpbmRleGVzIGJlZm9yZSBzdXNwZW5kaW5nLgpPdGhlcndpc2Ugd2Ug
bmVlZCBhbiBBUEkgdG8gZ2V0IHBlbmRpbmcgdXNlZCBpbmRpY2VzPwoKPgo+IFRvIG1lIHRoZSB3
aXNlc3Qgb3B0aW9uIGlzIHRvIG1vdmUgdGhpcyB3aXRoIHZob3N0LWtlcm5lbC4gTWF5YmUgd2UK
PiBuZWVkIHRvIGFkZCBhIGZlYXR1cmUgYml0IHRvIGtub3cgdGhhdCB0aGUgaHlwZXJ2aXNvciBj
YW4gdHJ1c3QgdGhlCj4gZGV2aWNlIHdpbGwgZG8gInRoZSByaWdodCB0aGluZyIgKFZIT1NUX1ZE
UEFfRl9GRVRDSF9VU0VEX0FUX0VOQUJMRT8pLAo+IGJ1dCB3ZSBzaG91bGQga2VlcCBpdCBvcnRo
b2dvbmFsIHRvIGluZmxpZ2h0IGRlc2NyaXB0b3IgbWlncmF0aW9uIGluCj4gbXkgb3Bpbmlvbi4K
CkkgdGhpbmsgd2UgbmVlZCB0byB1bmRlcnN0YW5kIGlmIHRoZXJlIGFyZSBhbnkgb3RoZXIgcG9z
c2libGUgdXNlCmNhc2VzIGZvciBzZXR0aW5nIHVzZWQgaWR4IG90aGVyIHRoYW4gaW5mbGlnaHQg
c3R1ZmYuCgo+Cj4gSGF2aW5nIHNhaWQgdGhhdCwgSSdtIHRvdGFsbHkgb2sgdG8gZG8gaXQgb3Ro
ZXJ3aXNlIChvciB0byBleHBhbmQgdGhlCj4gcGF0Y2ggbWVzc2FnZSBpZiBuZWVkZWQpLgoKSSB0
ZW5kIHRvIGRvIHRoYXQgaW4gYW5vdGhlciBzZXJpZXMgKG5vdCBtaXggd2l0aCB0aGUgZml4ZXMp
LgoKPgo+ID4gPgo+ID4gPiA+ID4gLSAgICAgICByZXR1cm4gdnJpbmdoX2luaXRfa2Vybih2cmgs
IGZlYXR1cmVzLCBudW0sIHdlYWtfYmFycmllcnMsCj4gPiA+ID4gPiAtICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGRlc2MsIGF2YWlsLCB1c2VkKTsKPiA+ID4gPiA+ICsgICAgICAgaW50
IHIgPSB2cmluZ2hfaW5pdF9rZXJuKHZyaCwgZmVhdHVyZXMsIG51bSwgd2Vha19iYXJyaWVycywg
ZGVzYywKPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGF2YWlsLCB1
c2VkKTsKPiA+ID4gPiA+ICsKPiA+ID4gPiA+ICsgICAgICAgaWYgKHIgIT0gMCkKPiA+ID4gPiA+
ICsgICAgICAgICAgICAgICByZXR1cm4gcjsKPiA+ID4gPiA+ICsKPiA+ID4gPiA+ICsgICAgICAg
LyogQ29uc2lkZXIgdGhlIHJpbmcgbm90IGluaXRpYWxpemVkICovCj4gPiA+ID4gPiArICAgICAg
IGlmICgodm9pZCAqKWRlc2MgPT0gdXNlZCkKPiA+ID4gPiA+ICsgICAgICAgICAgICAgICByZXR1
cm4gMDsKPiA+ID4gPgo+ID4gPiA+IEkgZG9uJ3QgdW5kZXJzdGFuZCB3aGVuIHdlIGNhbiBnZXQg
dGhpcyAoYWN0dWFsbHkgaXQgc2hvdWxkIGJlIGEgYnVnCj4gPiA+ID4gb2YgdGhlIGNhbGxlciku
Cj4gPiA+ID4KPiA+ID4KPiA+ID4gWW91IGNhbiBzZWUgaXQgaW4gdmRwYXNpbV92cV9yZXNldC4K
PiA+ID4KPiA+ID4gTm90ZSB0aGF0IHRvIGNvbnNpZGVyIGRlc2MgPT0gMCB0byBiZSBhbiB1bmlu
aXRpYWxpemVkIHJpbmcgaXMgYSBidWcKPiA+ID4gSU1PLiBRRU1VIGNvbnNpZGVycyBpdCB0aGF0
IHdheSBhbHNvLCBidXQgdGhlIHN0YW5kYXJkIGRvZXMgbm90IGZvcmJpZAo+ID4gPiBhbnkgcmlu
ZyB0byBiZSBhdCBhZGRyZXNzIDAuIEVzcGVjaWFsbHkgaWYgd2UgdXNlIHZJT01NVS4KPiA+ID4K
PiA+ID4gU28gSSB0aGluayB0aGUgYmVzdCB3YXkgdG8ga25vdyBpZiB3ZSBjYW4gdXNlIHRoZSB2
cmluZ2ggaXMgZWl0aGVyCj4gPiA+IHRoaXMgd2F5LCBvciBwcm92aWRlIGFuIGV4cGxpY2l0ICJp
bml0aWFsaXplZCIgYm9vbGVhbiBhdHRyaWJ1dGUuCj4gPiA+IE1heWJlIGEgbmV3ICJib29sIGlz
X2luaXRpYWxpemVkKHZyaCkiIGlzIGVub3VnaCwgaWYgd2UgZG9uJ3Qgd2FudCB0bwo+ID4gPiBh
ZGQgbmV3IGF0dHJpYnV0ZXMuCj4gPgo+ID4gSSB3b25kZXIgaWYgd2UgY2FuIGF2b2lkIHRoaXMg
aW4gdGhlIHNpbXVsYXRvciBsZXZlbCBpbnN0ZWFkIG9mIHRoZQo+ID4gdnJpbmdoIChhbnlob3cg
aXQgb25seSBleHBvc2VzIGEgdnJpbmdoX2luaXRfeHh4KCkgaGVscGVyIG5vdykuCj4gPgo+Cj4g
SW4gbXkgb3BpbmlvbiB0aGF0IGlzIGEgbWlzdGFrZSBpZiBvdGhlciBkcml2ZXJzIHdpbGwgdXNl
IGl0IHRvCj4gaW1wbGVtZW50IHRoZSBlbXVsYXRlZCBjb250cm9sIHZpcnRxdWV1ZS4gQW5kIGl0
IHJlcXVpcmVzIG1vcmUKPiBjaGFuZ2VzLiBCdXQgaXQgaXMgZG9hYmxlIGZvciBzdXJlLgoKVGhl
IHByb2JsZW0gaXMsIHRoZXJlJ3Mgbm8gcmVzZXQgQVBJIGluIHZyaW5naCwgdGhhdCdzIHdoeSB5
b3UgbmVlZCB0bwpkbyBpZiAoKHZvaWQgKilkZXNjID09IHVzZWQpIHdoaWNoIGRlcGVuZHMgb24g
YmVoYXZpb3VyIG9mIHRoZSB2cmluZ2gKdXNlci4KClNvIEkgdGhpbmsgd2Ugc2hvdWxkIGVpdGhl
cjoKCjEpIG1vdmUgdGhhdCBjaGVjayBpbiB2ZHBhX3NpbSAoc2luY2UgaXQncyBub3QgZ3VhcmFu
dGVlZCB0aGF0IGFsbCB0aGUKdnJpbmdoIHVzZXJzIHdpbGwgbWFrZSBkZXNjIGVxdWFsIHRvIHVz
ZWQgZHVyaW5nIHJlc2V0KQoKb3IKCjIpIGludHJvZHVjZSBhIHZyaW5naF9yZXNldF94eHgoKQoK
MSkgc2VlbXMgYSBnb29kIHN0ZXAgZm9yIC1zdGFibGUuCgpUaGFua3MKCj4KPiBUaGFua3MhCj4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
