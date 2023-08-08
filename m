Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B60EB64DD
	for <virtualization@archiver.kernel.org>; Tue,  8 Aug 2023 03:08:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 03E5640947;
	Tue,  8 Aug 2023 03:08:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 03E5640947
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iR/HIMqi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hi8KzdEjnQ1T; Tue,  8 Aug 2023 03:08:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 50797406E0;
	Tue,  8 Aug 2023 03:08:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 50797406E0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19EC7C0071;
	Tue,  8 Aug 2023 03:08:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF459C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 03:08:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8939380BFE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 03:08:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8939380BFE
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iR/HIMqi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8KNlzwvlQONN
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 03:08:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 035C181F12
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 03:08:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 035C181F12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691464104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hhbbf/y3ixYRtFGuR8fxsOg96UrZPCnLYZgyvI13pPE=;
 b=iR/HIMqi73LgkSgiGERUf4rtdEbZF8tDqx52p0XWqc0TgxrOUBSvvk/8iva/fb3xQNtP2e
 eviUARNCWaAyRE1+LDNtyd3hXLFiFP7Xdk6dpqdp0IFmdkKVsAVBbAIZ4RjjWD8a3p01We
 aIdNESh/Ejk8awyypfFiUMyGh0aMh7s=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-jQgikRVVP6-_3DFvbmss2A-1; Mon, 07 Aug 2023 23:08:22 -0400
X-MC-Unique: jQgikRVVP6-_3DFvbmss2A-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b9fa64db5cso54093681fa.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Aug 2023 20:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691464101; x=1692068901;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hhbbf/y3ixYRtFGuR8fxsOg96UrZPCnLYZgyvI13pPE=;
 b=KtgaYQVfRqA9uSCUbRyim2ImI9kbbwqfjWutc8XYHoMvBvEW+O6uKbhmVuRscExWyr
 yedkiTk3cJFY/Q8dgMvKjkL8sdQc1ragyG+ay4RCwyjk08ZtdIv7IGZYNoix5LhvqSz7
 RDPE1OWV4jvsEkcfeoIwaPuKoRqgVf2c9QaAiCRe5JArtFoQPUfEAmUr63f6V9vLfKhU
 zNwvL/TW317JMw/sU3M/XIYgTKhkclrcNg39LTVgTB+oGEvcFH+69rrZnHSNF23lrGEC
 gxza4jpy3Xyraaceza9CQHvCrfUYeDMdI5iTlq17IcrpUcgbwogZqFAbelE1sMgt/D0h
 nroQ==
X-Gm-Message-State: AOJu0Yz74nAzgKOGTII3SCMSA7BEvNbVDiI5YCMmXeh7C47pSQWz0xQ8
 WLVswDolY5E86VWYrXt2W/UrCpw2Hj/BJcoT/xLZ4Z3eNPC9PXsPQ47FXaTPF3W+uPBvfqMW/Xq
 ja+8TCGqRZ2KgE2wmCp3uCV7CQQkY58jTsprS5k157CDixbmGSx9WW6kboQ==
X-Received: by 2002:a2e:8e93:0:b0:2b9:412a:111d with SMTP id
 z19-20020a2e8e93000000b002b9412a111dmr8068876ljk.42.1691464101075; 
 Mon, 07 Aug 2023 20:08:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkFzuKUSTBxvr8xUJFBGEljqkZL6F7AvfmOw6ZPETh0gBINujkhDUrVUJXH6NVreAEes81Trgg6dPGFpEKYN0=
X-Received: by 2002:a2e:8e93:0:b0:2b9:412a:111d with SMTP id
 z19-20020a2e8e93000000b002b9412a111dmr8068854ljk.42.1691464100720; Mon, 07
 Aug 2023 20:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-6-xuanzhuo@linux.alibaba.com>
 <ZK/cxNHzI23I6efc@infradead.org>
 <20230713104805-mutt-send-email-mst@kernel.org>
 <ZLjSsmTfcpaL6H/I@infradead.org>
 <20230720131928-mutt-send-email-mst@kernel.org>
 <ZL6qPvd6X1CgUD4S@infradead.org>
 <1690251228.3455179-1-xuanzhuo@linux.alibaba.com>
 <20230725033321-mutt-send-email-mst@kernel.org>
 <1690283243.4048996-1-xuanzhuo@linux.alibaba.com>
 <1690524153.3603117-1-xuanzhuo@linux.alibaba.com>
 <20230801121543-mutt-send-email-mst@kernel.org>
 <1690940971.9409487-2-xuanzhuo@linux.alibaba.com>
 <1691388845.9121156-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsoivXfBV75whjyB0yreUNh7HeucGLw3Bq9Zvu1NGnj_g@mail.gmail.com>
 <1691462837.6043541-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1691462837.6043541-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Aug 2023 11:08:09 +0800
Message-ID: <CACGkMEsM4cPaMHz-XowU+qpKZL2atZUwYzcUMUfr7N-GN+J2nQ@mail.gmail.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce virtqueue_dma_dev()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

T24gVHVlLCBBdWcgOCwgMjAyMyBhdCAxMDo1MuKAr0FNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gT24gVHVlLCA4IEF1ZyAyMDIzIDEwOjI2OjA0ICsw
ODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+IE9uIE1vbiwg
QXVnIDcsIDIwMjMgYXQgMjoxNeKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFi
YS5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPiBPbiBXZWQsIDIgQXVnIDIwMjMgMDk6NDk6MzEgKzA4
MDAsIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4gPiA+
IE9uIFR1ZSwgMSBBdWcgMjAyMyAxMjoxNzo0NyAtMDQwMCwgIk1pY2hhZWwgUy4gVHNpcmtpbiIg
PG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+IE9uIEZyaSwgSnVsIDI4LCAyMDIzIGF0
IDAyOjAyOjMzUE0gKzA4MDAsIFh1YW4gWmh1byB3cm90ZToKPiA+ID4gPiA+ID4gT24gVHVlLCAy
NSBKdWwgMjAyMyAxOTowNzoyMyArMDgwMCwgWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGli
YWJhLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gT24gVHVlLCAyNSBKdWwgMjAyMyAwMzozNDoz
NCAtMDQwMCwgIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+
ID4gPiA+ID4gPiA+IE9uIFR1ZSwgSnVsIDI1LCAyMDIzIGF0IDEwOjEzOjQ4QU0gKzA4MDAsIFh1
YW4gWmh1byB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gT24gTW9uLCAyNCBKdWwgMjAyMyAwOTo0
Mzo0MiAtMDcwMCwgQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBpbmZyYWRlYWQub3JnPiB3cm90ZToK
PiA+ID4gPiA+ID4gPiA+ID4gPiBPbiBUaHUsIEp1bCAyMCwgMjAyMyBhdCAwMToyMTowN1BNIC0w
NDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBXZWxs
IEkgdGhpbmsgd2UgY2FuIGFkZCB3cmFwcGVycyBsaWtlIHZpcnRpb19kbWFfc3luYyBhbmQgc28g
b24uCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBUaGVyZSBhcmUgTk9QIGZvciBub24tZG1hIHNvIHBh
c3NpbmcgdGhlIGRtYSBkZXZpY2UgaXMgaGFybWxlc3MuCj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiA+ID4gPiBZZXMsIHBsZWFzZS4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gSSBhbSBub3Qgc3VyZSBJIGdvdCB0aGlzIGZ1bGx5
Lgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiBBcmUgeW91IG1lYW4gdGhpczoK
PiA+ID4gPiA+ID4gPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjMwMjE0MDcy
NzA0LjEyNjY2MC04LXh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tLwo+ID4gPiA+ID4gPiA+ID4g
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzAyMTQwNzI3MDQuMTI2NjYwLTkteHVh
bnpodW9AbGludXguYWxpYmFiYS5jb20vCj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4g
PiA+IFRoZW4gdGhlIGRyaXZlciBtdXN0IGRvIGRtYSBvcGVyYXRpb24obWFwIGFuZCBzeW5jKSBi
eSB0aGVzZSB2aXJ0aW9fZG1hXyogQVBJcy4KPiA+ID4gPiA+ID4gPiA+ID4gTm8gY2FyZSB0aGUg
ZGV2aWNlIGlzIG5vbi1kbWEgZGV2aWNlIG9yIGRtYSBkZXZpY2UuCj4gPiA+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+ID4geWVzCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiBUaGVu
IHRoZSBBRl9YRFAgbXVzdCB1c2UgdGhlc2UgdmlydGlvX2RtYV8qIEFQSXMgZm9yIHZpcnRpbyBk
ZXZpY2UuCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gV2UnbGwgd29ycnkgYWJvdXQg
QUZfWERQIHdoZW4gdGhlIHBhdGNoIGlzIHBvc3RlZC4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+IFlFUy4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IFdlIGRpc2N1c3NlZCBpdC4gVGhl
eSB2b3RlZCAnbm8nLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gaHR0cDovL2xvcmUua2Vy
bmVsLm9yZy9hbGwvMjAyMzA0MjQwODI4NTYuMTVjMWU1OTNAa2VybmVsLm9yZwo+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBIaSBndXlzLCB0aGlzIHRvcGljIGlzIHN0dWNrIGFn
YWluLiBIb3cgc2hvdWxkIEkgcHJvY2VlZCB3aXRoIHRoaXMgd29yaz8KPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gTGV0IG1lIGJyaWVmbHkgc3VtbWFyaXplOgo+ID4gPiA+ID4gPiAxLiBUaGUgcHJv
YmxlbSB3aXRoIGFkZGluZyB2aXJ0aW9fZG1hX3ttYXAsIHN5bmN9IGFwaSBpcyB0aGF0LCBmb3Ig
QUZfWERQIGFuZAo+ID4gPiA+ID4gPiB0aGUgZHJpdmVyIGxheWVyLCB3ZSBuZWVkIHRvIHN1cHBv
cnQgdGhlc2UgQVBJcy4gVGhlIGN1cnJlbnQgY29uY2x1c2lvbiBvZgo+ID4gPiA+ID4gPiBBRl9Y
RFAgaXMgbm8uCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IDIuIFNldCBkbWFfc2V0X21hc2tfYW5k
X2NvaGVyZW50LCB0aGVuIHdlIGNhbiB1c2UgRE1BIEFQSSB1bmlmb3JtbHkgaW5zaWRlCj4gPiA+
ID4gPiA+IGRyaXZlci4gVGhpcyBpZGVhIHNlZW1zIHRvIGJlIGluY29uc2lzdGVudCB3aXRoIHRo
ZSBmcmFtZXdvcmsgZGVzaWduIG9mIERNQS4gVGhlCj4gPiA+ID4gPiA+IGNvbmNsdXNpb24gaXMg
bm8uCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IDMuIFdlIG5vdGljZWQgdGhhdCBpZiB0aGUgdmly
dGlvIGRldmljZSBzdXBwb3J0cyBWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0sIGl0Cj4gPiA+ID4g
PiA+IHVzZXMgRE1BIEFQSS4gQW5kIHRoaXMgdHlwZSBvZiBkZXZpY2UgaXMgdGhlIGZ1dHVyZSBk
aXJlY3Rpb24sIHNvIHdlIG9ubHkKPiA+ID4gPiA+ID4gc3VwcG9ydCBETUEgcHJlbWFwcGVkIGZv
ciB0aGlzIHR5cGUgb2YgdmlydGlvIGRldmljZS4gVGhlIHByb2JsZW0gd2l0aCB0aGlzCj4gPiA+
ID4gPiA+IHNvbHV0aW9uIGlzIHRoYXQgdmlydHF1ZXVlX2RtYV9kZXYoKSBvbmx5IHJldHVybnMg
ZGV2IGluIHNvbWUgY2FzZXMsIGJlY2F1c2UKPiA+ID4gPiA+ID4gVklSVElPX0ZfQUNDRVNTX1BM
QVRGT1JNIGlzIHN1cHBvcnRlZCBpbiBzdWNoIGNhc2VzLgo+ID4KPiA+IENvdWxkIHlvdSBleHBs
YWluIHRoZSBpc3N1ZSBhIGxpdHRsZSBiaXQgbW9yZT8KPiA+Cj4gPiBFLmcgaWYgd2UgbGltaXQg
QUZfWERQIHRvIEFDRVNTX1BMQVRGUk9NIG9ubHksIHdoeSBkb2VzCj4gPiB2aXJ0cXVldWVfZG1h
X2RldigpIG9ubHkgcmV0dXJuIGRldiBpbiBzb21lIGNhc2VzPwo+Cj4gVGhlIGJlaGF2aW9yIG9m
IHZpcnRxdWV1ZV9kbWFfZGV2KCkgaXMgbm90IHJlbGF0ZWQgdG8gQUZfWERQLgo+Cj4gVGhlIHJl
dHVybiB2YWx1ZSBvZiB2aXJ0cXVldWVfZG1hX2RldigpIGlzIHVzZWQgZm9yIHRoZSBETUEgQVBJ
cy4gU28gaXQgY2FuCj4gcmV0dXJuIGRtYSBkZXYgd2hlbiB0aGUgdmlydGlvIGlzIHdpdGggQUND
RVNTX1BMQVRGT1JNLiBJZiB2aXJ0aW8gaXMgd2l0aG91dAo+IEFDQ0VTU19QTEFURk9STSB0aGVu
IGl0IE1VU1QgcmV0dXJuIE5VTEwuCj4KPiBJbiB0aGUgdmlydGlvLW5ldCBkcml2ZXIsIGlmIHRo
ZSB2aXJ0cXVldWVfZG1hX2RldigpIHJldHVybnMgZG1hIGRldiwKPiB3ZSBjYW4gZW5hYmxlIEFG
X1hEUC4gSWYgbm90LCB3ZSByZXR1cm4gZXJyb3IgdG8gQUZfWERQLgoKWWVzLCBhcyBkaXNjdXNz
ZWQsIGp1c3QgaGF2aW5nIHdyYXBwZXJzIGluIHRoZSB2aXJ0aW9fcmluZyBhbmQgZG9pbmcKdGhl
IHN3aXRjaCB0aGVyZS4gVGhlbiBjYW4gdmlydGlvLW5ldCB1c2UgdGhlbSB3aXRob3V0IHdvcnJ5
aW5nIGFib3V0CkRNQSBkZXRhaWxzPwoKVGhhbmtzCgo+Cj4gVGhhbmtzCj4KPgo+Cj4KPiA+Cj4g
PiBUaGFua3MKPiA+Cj4gPiA+T3RoZXJ3aXNlIE5VTEwgaXMgcmV0dXJuZWQuCj4gPiA+ID4gPiA+
IFRoaXMgb3B0aW9uIGlzIGN1cnJlbnRseSBOTy4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gU28g
SSdtIHdvbmRlcmluZyB3aGF0IHNob3VsZCBJIGRvLCBmcm9tIGEgRE1BIHBvaW50IG9mIHZpZXcs
IGlzIHRoZXJlIGFueQo+ID4gPiA+ID4gPiBzb2x1dGlvbiBpbiBjYXNlIG9mIHVzaW5nIERNQSBB
UEk/Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFRoYW5rIHlvdQo+ID4gPiA+ID4KPiA+ID4gPiA+
Cj4gPiA+ID4gPiBJIHRoaW5rIGl0J3Mgb2sgYXQgdGhpcyBwb2ludCwgQ2hyaXN0b3BoIGp1c3Qg
YXNrZWQgeW91Cj4gPiA+ID4gPiB0byBhZGQgd3JhcHBlcnMgZm9yIG1hcC91bm1hcCBmb3IgdXNl
IGluIHZpcnRpbyBjb2RlLgo+ID4gPiA+ID4gU2VlbXMgbGlrZSBhIGNvc21ldGljIGNoYW5nZSwg
c2hvdWxkbid0IGJlIGhhcmQuCj4gPiA+ID4KPiA+ID4gPiBZZXMsIHRoYXQgaXMgbm90IGhhcmQs
IEkgaGFzIHRoaXMgY29kZS4KPiA+ID4gPgo+ID4gPiA+IEJ1dCwgeW91IG1lYW4gdGhhdCB0aGUg
d3JhcHBlcnMgaXMganVzdCB1c2VkIGZvciB0aGUgdmlydGlvIGRyaXZlciBjb2RlPwo+ID4gPiA+
IEFuZCB3ZSBhbHNvIG9mZmVyIHRoZSAgQVBJIHZpcnRxdWV1ZV9kbWFfZGV2KCkgYXQgdGhlIHNh
bWUgdGltZT8KPiA+ID4gPiBUaGVuIHRoZSBkcml2ZXIgd2lsbCBoYXMgdHdvIGNob29zZXMgdG8g
ZG8gRE1BLgo+ID4gPiA+Cj4gPiA+ID4gSXMgdGhhdCBzbz8KPiA+ID4KPiA+ID4gUGluZy4KPiA+
ID4KPiA+ID4gVGhhbmtzCj4gPiA+Cj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gT3RoZXJ3aXNl
IEkgaGF2ZW4ndCBzZWVuIHNpZ25pZmljYW50IGNvbW1lbnRzLgo+ID4gPiA+ID4KPiA+ID4gPiA+
Cj4gPiA+ID4gPiBDaHJpc3RvcGggZG8gSSBzdW1tYXJpemUgd2hhdCB5b3UgYXJlIHNheWluZyBj
b3JyZWN0bHk/Cj4gPiA+ID4gPiAtLQo+ID4gPiA+ID4gTVNUCj4gPiA+ID4gPgo+ID4gPiA+Cj4g
PiA+Cj4gPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
