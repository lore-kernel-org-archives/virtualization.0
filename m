Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE21C001DB
	for <virtualization@archiver.kernel.org>; Tue,  8 Aug 2023 02:26:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EDF3E404E9;
	Tue,  8 Aug 2023 02:26:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EDF3E404E9
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DAWrkLw/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mQ-q16KZy0rH; Tue,  8 Aug 2023 02:26:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7B87940350;
	Tue,  8 Aug 2023 02:26:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7B87940350
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45056C0071;
	Tue,  8 Aug 2023 02:26:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A42D7C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 02:26:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7E9A960BF5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 02:26:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7E9A960BF5
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DAWrkLw/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j2UF3yb_VdPG
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 02:26:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8B1CC60BC5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 02:26:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8B1CC60BC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691461579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S3bPtKkgi1i397NDq9plny0QBkcNq3/yfnepW49dbsU=;
 b=DAWrkLw/OfWnLYJmhHuELtqTbaOEbGbqgdvQ/22hj7Fopw55EjKQKZxJtvliCll7QFMRV2
 It2GUi09GNeP5lTNdHVioxZGQod/e2Mj/AxTyQcZWrt634qNgVFp9wmQj/O/Lv/R8cTnJA
 A5yYsKJzH1ORd9rn9PmhyMgPJA2KnAQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-974vhH9nPKC-tJjV5q9-GA-1; Mon, 07 Aug 2023 22:26:18 -0400
X-MC-Unique: 974vhH9nPKC-tJjV5q9-GA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ba1949656bso39268771fa.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Aug 2023 19:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691461576; x=1692066376;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S3bPtKkgi1i397NDq9plny0QBkcNq3/yfnepW49dbsU=;
 b=iIosxHzbkQG7Ssu1ysRE2bLMxUX+26EIKW2oWhqr7aGaqZO9QsViUnKbmDDMIZ0sa1
 OuS6C3pqwy/Jpr+iJGKzNfUuHOSgW1msylsUJNd+IFQhsUx35Ht2LUYBx+gwcMSkharL
 DiT0oUrbHl8hmawF41Dpa4A9FKmrXZTZDtpqvTLnEfYN6/XBm/CwGnYO8U7gEoLbId9h
 I/VuV6ocQd7/3/1+FobkHPrnrnjA6UBInYtRjRhqIuD9KWMvpLATZoEwPmsVNipnRr0N
 j+ka8j42Sx/CpWSBIkp5GtE7sLUwemLDEZkGSFi3AaTqSik/R4jEdBvJRzOPtd361W9v
 vBQA==
X-Gm-Message-State: AOJu0Yyhg16LjZ2OTY2kz65zqwKOw6Q6a/mgsQaSs45sSD7mjry3roMS
 3v+Ub9l/5Gz65zFKajlJH3NhR1wZrpB+/pfkyQ3nqtkFBKsF5IJHgIseiIxHK4ZrPTKui2vvjsa
 9x3SjKb9rSCAH0I/djKED+4F4Xg20YbD59PtOzKF+sgt3AxNHTMKdI0UM6g==
X-Received: by 2002:a2e:9dd2:0:b0:2b9:e24d:21f6 with SMTP id
 x18-20020a2e9dd2000000b002b9e24d21f6mr8537849ljj.20.1691461576629; 
 Mon, 07 Aug 2023 19:26:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNEm+Y6WWl+v6SW3V5FlF+qxZoMtf5PiRX9TeSa9v9sMGFuEkcW6A6jSYVhkrmtuO0whT+JZmflWz4uo7ct/I=
X-Received: by 2002:a2e:9dd2:0:b0:2b9:e24d:21f6 with SMTP id
 x18-20020a2e9dd2000000b002b9e24d21f6mr8537832ljj.20.1691461576310; Mon, 07
 Aug 2023 19:26:16 -0700 (PDT)
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
In-Reply-To: <1691388845.9121156-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Aug 2023 10:26:04 +0800
Message-ID: <CACGkMEsoivXfBV75whjyB0yreUNh7HeucGLw3Bq9Zvu1NGnj_g@mail.gmail.com>
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

T24gTW9uLCBBdWcgNywgMjAyMyBhdCAyOjE14oCvUE0gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51
eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4KPiBPbiBXZWQsIDIgQXVnIDIwMjMgMDk6NDk6MzEgKzA4
MDAsIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4gT24g
VHVlLCAxIEF1ZyAyMDIzIDEyOjE3OjQ3IC0wNDAwLCAiTWljaGFlbCBTLiBUc2lya2luIiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiBPbiBGcmksIEp1bCAyOCwgMjAyMyBhdCAwMjowMjoz
M1BNICswODAwLCBYdWFuIFpodW8gd3JvdGU6Cj4gPiA+ID4gT24gVHVlLCAyNSBKdWwgMjAyMyAx
OTowNzoyMyArMDgwMCwgWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4gd3Jv
dGU6Cj4gPiA+ID4gPiBPbiBUdWUsIDI1IEp1bCAyMDIzIDAzOjM0OjM0IC0wNDAwLCAiTWljaGFl
bCBTLiBUc2lya2luIiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiBPbiBUdWUs
IEp1bCAyNSwgMjAyMyBhdCAxMDoxMzo0OEFNICswODAwLCBYdWFuIFpodW8gd3JvdGU6Cj4gPiA+
ID4gPiA+ID4gT24gTW9uLCAyNCBKdWwgMjAyMyAwOTo0Mzo0MiAtMDcwMCwgQ2hyaXN0b3BoIEhl
bGx3aWcgPGhjaEBpbmZyYWRlYWQub3JnPiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+IE9uIFRodSwg
SnVsIDIwLCAyMDIzIGF0IDAxOjIxOjA3UE0gLTA0MDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90
ZToKPiA+ID4gPiA+ID4gPiA+ID4gV2VsbCBJIHRoaW5rIHdlIGNhbiBhZGQgd3JhcHBlcnMgbGlr
ZSB2aXJ0aW9fZG1hX3N5bmMgYW5kIHNvIG9uLgo+ID4gPiA+ID4gPiA+ID4gPiBUaGVyZSBhcmUg
Tk9QIGZvciBub24tZG1hIHNvIHBhc3NpbmcgdGhlIGRtYSBkZXZpY2UgaXMgaGFybWxlc3MuCj4g
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gWWVzLCBwbGVhc2UuCj4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IEkgYW0gbm90IHN1cmUgSSBnb3QgdGhpcyBmdWxs
eS4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IEFyZSB5b3UgbWVhbiB0aGlzOgo+ID4gPiA+
ID4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDIxNDA3MjcwNC4xMjY2NjAt
OC14dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbS8KPiA+ID4gPiA+ID4gPiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9hbGwvMjAyMzAyMTQwNzI3MDQuMTI2NjYwLTkteHVhbnpodW9AbGludXguYWxp
YmFiYS5jb20vCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBUaGVuIHRoZSBkcml2ZXIgbXVz
dCBkbyBkbWEgb3BlcmF0aW9uKG1hcCBhbmQgc3luYykgYnkgdGhlc2UgdmlydGlvX2RtYV8qIEFQ
SXMuCj4gPiA+ID4gPiA+ID4gTm8gY2FyZSB0aGUgZGV2aWNlIGlzIG5vbi1kbWEgZGV2aWNlIG9y
IGRtYSBkZXZpY2UuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IHllcwo+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+IFRoZW4gdGhlIEFGX1hEUCBtdXN0IHVzZSB0aGVzZSB2aXJ0aW9fZG1hXyogQVBJ
cyBmb3IgdmlydGlvIGRldmljZS4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gV2UnbGwgd29ycnkg
YWJvdXQgQUZfWERQIHdoZW4gdGhlIHBhdGNoIGlzIHBvc3RlZC4KPiA+ID4gPiA+Cj4gPiA+ID4g
PiBZRVMuCj4gPiA+ID4gPgo+ID4gPiA+ID4gV2UgZGlzY3Vzc2VkIGl0LiBUaGV5IHZvdGVkICdu
bycuCj4gPiA+ID4gPgo+ID4gPiA+ID4gaHR0cDovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzA0
MjQwODI4NTYuMTVjMWU1OTNAa2VybmVsLm9yZwo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBIaSBn
dXlzLCB0aGlzIHRvcGljIGlzIHN0dWNrIGFnYWluLiBIb3cgc2hvdWxkIEkgcHJvY2VlZCB3aXRo
IHRoaXMgd29yaz8KPiA+ID4gPgo+ID4gPiA+IExldCBtZSBicmllZmx5IHN1bW1hcml6ZToKPiA+
ID4gPiAxLiBUaGUgcHJvYmxlbSB3aXRoIGFkZGluZyB2aXJ0aW9fZG1hX3ttYXAsIHN5bmN9IGFw
aSBpcyB0aGF0LCBmb3IgQUZfWERQIGFuZAo+ID4gPiA+IHRoZSBkcml2ZXIgbGF5ZXIsIHdlIG5l
ZWQgdG8gc3VwcG9ydCB0aGVzZSBBUElzLiBUaGUgY3VycmVudCBjb25jbHVzaW9uIG9mCj4gPiA+
ID4gQUZfWERQIGlzIG5vLgo+ID4gPiA+Cj4gPiA+ID4gMi4gU2V0IGRtYV9zZXRfbWFza19hbmRf
Y29oZXJlbnQsIHRoZW4gd2UgY2FuIHVzZSBETUEgQVBJIHVuaWZvcm1seSBpbnNpZGUKPiA+ID4g
PiBkcml2ZXIuIFRoaXMgaWRlYSBzZWVtcyB0byBiZSBpbmNvbnNpc3RlbnQgd2l0aCB0aGUgZnJh
bWV3b3JrIGRlc2lnbiBvZiBETUEuIFRoZQo+ID4gPiA+IGNvbmNsdXNpb24gaXMgbm8uCj4gPiA+
ID4KPiA+ID4gPiAzLiBXZSBub3RpY2VkIHRoYXQgaWYgdGhlIHZpcnRpbyBkZXZpY2Ugc3VwcG9y
dHMgVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNLCBpdAo+ID4gPiA+IHVzZXMgRE1BIEFQSS4gQW5k
IHRoaXMgdHlwZSBvZiBkZXZpY2UgaXMgdGhlIGZ1dHVyZSBkaXJlY3Rpb24sIHNvIHdlIG9ubHkK
PiA+ID4gPiBzdXBwb3J0IERNQSBwcmVtYXBwZWQgZm9yIHRoaXMgdHlwZSBvZiB2aXJ0aW8gZGV2
aWNlLiBUaGUgcHJvYmxlbSB3aXRoIHRoaXMKPiA+ID4gPiBzb2x1dGlvbiBpcyB0aGF0IHZpcnRx
dWV1ZV9kbWFfZGV2KCkgb25seSByZXR1cm5zIGRldiBpbiBzb21lIGNhc2VzLCBiZWNhdXNlCj4g
PiA+ID4gVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNIGlzIHN1cHBvcnRlZCBpbiBzdWNoIGNhc2Vz
LgoKQ291bGQgeW91IGV4cGxhaW4gdGhlIGlzc3VlIGEgbGl0dGxlIGJpdCBtb3JlPwoKRS5nIGlm
IHdlIGxpbWl0IEFGX1hEUCB0byBBQ0VTU19QTEFURlJPTSBvbmx5LCB3aHkgZG9lcwp2aXJ0cXVl
dWVfZG1hX2RldigpIG9ubHkgcmV0dXJuIGRldiBpbiBzb21lIGNhc2VzPwoKVGhhbmtzCgo+T3Ro
ZXJ3aXNlIE5VTEwgaXMgcmV0dXJuZWQuCj4gPiA+ID4gVGhpcyBvcHRpb24gaXMgY3VycmVudGx5
IE5PLgo+ID4gPiA+Cj4gPiA+ID4gU28gSSdtIHdvbmRlcmluZyB3aGF0IHNob3VsZCBJIGRvLCBm
cm9tIGEgRE1BIHBvaW50IG9mIHZpZXcsIGlzIHRoZXJlIGFueQo+ID4gPiA+IHNvbHV0aW9uIGlu
IGNhc2Ugb2YgdXNpbmcgRE1BIEFQST8KPiA+ID4gPgo+ID4gPiA+IFRoYW5rIHlvdQo+ID4gPgo+
ID4gPgo+ID4gPiBJIHRoaW5rIGl0J3Mgb2sgYXQgdGhpcyBwb2ludCwgQ2hyaXN0b3BoIGp1c3Qg
YXNrZWQgeW91Cj4gPiA+IHRvIGFkZCB3cmFwcGVycyBmb3IgbWFwL3VubWFwIGZvciB1c2UgaW4g
dmlydGlvIGNvZGUuCj4gPiA+IFNlZW1zIGxpa2UgYSBjb3NtZXRpYyBjaGFuZ2UsIHNob3VsZG4n
dCBiZSBoYXJkLgo+ID4KPiA+IFllcywgdGhhdCBpcyBub3QgaGFyZCwgSSBoYXMgdGhpcyBjb2Rl
Lgo+ID4KPiA+IEJ1dCwgeW91IG1lYW4gdGhhdCB0aGUgd3JhcHBlcnMgaXMganVzdCB1c2VkIGZv
ciB0aGUgdmlydGlvIGRyaXZlciBjb2RlPwo+ID4gQW5kIHdlIGFsc28gb2ZmZXIgdGhlICBBUEkg
dmlydHF1ZXVlX2RtYV9kZXYoKSBhdCB0aGUgc2FtZSB0aW1lPwo+ID4gVGhlbiB0aGUgZHJpdmVy
IHdpbGwgaGFzIHR3byBjaG9vc2VzIHRvIGRvIERNQS4KPiA+Cj4gPiBJcyB0aGF0IHNvPwo+Cj4g
UGluZy4KPgo+IFRoYW5rcwo+Cj4gPgo+ID4KPiA+ID4gT3RoZXJ3aXNlIEkgaGF2ZW4ndCBzZWVu
IHNpZ25pZmljYW50IGNvbW1lbnRzLgo+ID4gPgo+ID4gPgo+ID4gPiBDaHJpc3RvcGggZG8gSSBz
dW1tYXJpemUgd2hhdCB5b3UgYXJlIHNheWluZyBjb3JyZWN0bHk/Cj4gPiA+IC0tCj4gPiA+IE1T
VAo+ID4gPgo+ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
