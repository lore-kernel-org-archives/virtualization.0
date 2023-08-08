Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4257C001B0
	for <virtualization@archiver.kernel.org>; Tue,  8 Aug 2023 03:59:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C36B81F12;
	Tue,  8 Aug 2023 03:59:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6C36B81F12
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FCz57zi4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EXxHpARISGUQ; Tue,  8 Aug 2023 03:59:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2729481BFA;
	Tue,  8 Aug 2023 03:59:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2729481BFA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02EA5C0072;
	Tue,  8 Aug 2023 03:59:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7DF70C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 03:59:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5E726402C3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 03:59:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5E726402C3
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FCz57zi4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T72SuZGbucny
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 03:59:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3A4B540102
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 03:59:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3A4B540102
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691467163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0l/zIpBzoNd3YD/UzVcSkuz5BdVlgIEgD7g5fXRAKWw=;
 b=FCz57zi4sx+xqpwBRicLO3M25Q8FaSe8ya8AnMpON+JFbBfPqXadPGA3wBk2QpLRQ2LmFe
 ke7fKH7/ggtepIOC1QclZE5jaKP+7AhNdulyDQBVbuHd8HJDc8eLaH29h7+0pKxIk+37Ic
 Fsoa5mnXiyCpYeZzw6VI7mtN/d8ru/Q=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-JOm3n6tHO1WZfS7_MAZV_Q-1; Mon, 07 Aug 2023 23:59:21 -0400
X-MC-Unique: JOm3n6tHO1WZfS7_MAZV_Q-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ba1949656bso39771631fa.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Aug 2023 20:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691467160; x=1692071960;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0l/zIpBzoNd3YD/UzVcSkuz5BdVlgIEgD7g5fXRAKWw=;
 b=cMu5QxvG7k6rXAvjVSW90tHOKmEdzvU1sujf284rQkB7vqNSgXLiFBLwwesEtlDERZ
 GEpMlTVLZC4x3oyzKVklJdVtIonq1agPjGENuig8CwO6HtJzP4Ced34cjJmfMRcCxFnk
 gBwfLzZZX0WwR3xwolU7BemlvYiaEnOQWcksycg7L1TzL8ip9+WD4stUV6bdez4I4/ow
 boTX/YyUvhpKR02oWfHxZSI3KXHEvszxzRvS+FTA1ugbTRR/PQeZKUWBf6E3pcbQxUDm
 9nCa/8O24LHAQx5ZB8ORCx0dEoWmpPnOvZWZk7EgUc/7euibxYXRd2wIImKKyRBoDe1S
 cTAQ==
X-Gm-Message-State: AOJu0YxeX5aZK3+grpHOltwzSBbfh1yR7q8a0qM4Uqh3pTa7WIGXS+J5
 Km52HesEC+Sx0kCjoIAGEtKky69gG9LE4W5cY0N+kxhKF3EmSb8ADzg7FuYfK6rouc6uuxxHwiz
 0e3kczTC1UVZPhb6PbxWCgMSPMmLrnomhGdSOjz63OCjyJ61hYsdyl+jaJw==
X-Received: by 2002:a2e:8706:0:b0:2b9:e317:ec4d with SMTP id
 m6-20020a2e8706000000b002b9e317ec4dmr9509534lji.39.1691467160181; 
 Mon, 07 Aug 2023 20:59:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/9DQrTRIe+MaGC1ED1i2uMJlzXFS32E9/+NfifHX+gPXxXE3/LPQ40a8wIeObDaFpyFOuHy6vDfjex5ZAdXk=
X-Received: by 2002:a2e:8706:0:b0:2b9:e317:ec4d with SMTP id
 m6-20020a2e8706000000b002b9e317ec4dmr9509524lji.39.1691467159855; Mon, 07 Aug
 2023 20:59:19 -0700 (PDT)
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
 <CACGkMEsM4cPaMHz-XowU+qpKZL2atZUwYzcUMUfr7N-GN+J2nQ@mail.gmail.com>
 <1691464183.5436294-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvUJ+GhhfkOB4Ux7-bDaPHvkA3xnvnMMQ+dYfWE4ZzFyw@mail.gmail.com>
 <1691466855.2312648-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1691466855.2312648-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Aug 2023 11:59:04 +0800
Message-ID: <CACGkMEtf8SHZUdpGwDgtWv=Pf02t7RCLSZusFmsyi93TZ7dFkw@mail.gmail.com>
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

T24gVHVlLCBBdWcgOCwgMjAyMyBhdCAxMTo1N+KAr0FNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gT24gVHVlLCA4IEF1ZyAyMDIzIDExOjQ5OjA4ICsw
ODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+IE9uIFR1ZSwg
QXVnIDgsIDIwMjMgYXQgMTE6MTLigK9BTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJh
YmEuY29tPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gVHVlLCA4IEF1ZyAyMDIzIDExOjA4OjA5ICsw
ODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiBPbiBU
dWUsIEF1ZyA4LCAyMDIzIGF0IDEwOjUy4oCvQU0gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5h
bGliYWJhLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4gT24gVHVlLCA4IEF1ZyAyMDIz
IDEwOjI2OjA0ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToK
PiA+ID4gPiA+ID4gT24gTW9uLCBBdWcgNywgMjAyMyBhdCAyOjE14oCvUE0gWHVhbiBaaHVvIDx4
dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiBPbiBXZWQsIDIgQXVnIDIwMjMgMDk6NDk6MzEgKzA4MDAsIFh1YW4gWmh1byA8eHVhbnpo
dW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gT24gVHVlLCAxIEF1
ZyAyMDIzIDEyOjE3OjQ3IC0wNDAwLCAiTWljaGFlbCBTLiBUc2lya2luIiA8bXN0QHJlZGhhdC5j
b20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiBPbiBGcmksIEp1bCAyOCwgMjAyMyBhdCAwMjow
MjozM1BNICswODAwLCBYdWFuIFpodW8gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gT24gVHVl
LCAyNSBKdWwgMjAyMyAxOTowNzoyMyArMDgwMCwgWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5h
bGliYWJhLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBPbiBUdWUsIDI1IEp1bCAy
MDIzIDAzOjM0OjM0IC0wNDAwLCAiTWljaGFlbCBTLiBUc2lya2luIiA8bXN0QHJlZGhhdC5jb20+
IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBPbiBUdWUsIEp1bCAyNSwgMjAyMyBhdCAx
MDoxMzo0OEFNICswODAwLCBYdWFuIFpodW8gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gT24gTW9uLCAyNCBKdWwgMjAyMyAwOTo0Mzo0MiAtMDcwMCwgQ2hyaXN0b3BoIEhlbGx3aWcg
PGhjaEBpbmZyYWRlYWQub3JnPiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IE9u
IFRodSwgSnVsIDIwLCAyMDIzIGF0IDAxOjIxOjA3UE0gLTA0MDAsIE1pY2hhZWwgUy4gVHNpcmtp
biB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gV2VsbCBJIHRoaW5rIHdlIGNh
biBhZGQgd3JhcHBlcnMgbGlrZSB2aXJ0aW9fZG1hX3N5bmMgYW5kIHNvIG9uLgo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiBUaGVyZSBhcmUgTk9QIGZvciBub24tZG1hIHNvIHBhc3Npbmcg
dGhlIGRtYSBkZXZpY2UgaXMgaGFybWxlc3MuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gWWVzLCBwbGVhc2UuCj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IEkgYW0gbm90IHN1cmUgSSBnb3QgdGhpcyBmdWxseS4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEFyZSB5b3UgbWVhbiB0aGlzOgo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDIxNDA3
MjcwNC4xMjY2NjAtOC14dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbS8KPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzAyMTQwNzI3MDQuMTI2
NjYwLTkteHVhbnpodW9AbGludXguYWxpYmFiYS5jb20vCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBUaGVuIHRoZSBkcml2ZXIgbXVzdCBkbyBkbWEg
b3BlcmF0aW9uKG1hcCBhbmQgc3luYykgYnkgdGhlc2UgdmlydGlvX2RtYV8qIEFQSXMuCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gTm8gY2FyZSB0aGUgZGV2aWNlIGlzIG5vbi1kbWEgZGV2aWNl
IG9yIGRtYSBkZXZpY2UuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IHllcwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IFRoZW4gdGhlIEFGX1hEUCBtdXN0IHVzZSB0aGVzZSB2aXJ0aW9fZG1hXyogQVBJcyBmb3Ig
dmlydGlvIGRldmljZS4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gV2UnbGwgd29ycnkgYWJvdXQgQUZfWERQIHdoZW4gdGhlIHBhdGNoIGlzIHBvc3RlZC4K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBZRVMuCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gV2UgZGlzY3Vzc2VkIGl0LiBUaGV5
IHZvdGVkICdubycuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
aHR0cDovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzA0MjQwODI4NTYuMTVjMWU1OTNAa2VybmVs
Lm9yZwo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiA+ID4gPiBIaSBndXlzLCB0aGlzIHRvcGljIGlzIHN0dWNrIGFnYWluLiBIb3cgc2hvdWxkIEkg
cHJvY2VlZCB3aXRoIHRoaXMgd29yaz8KPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
ID4gPiA+IExldCBtZSBicmllZmx5IHN1bW1hcml6ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiAxLiBU
aGUgcHJvYmxlbSB3aXRoIGFkZGluZyB2aXJ0aW9fZG1hX3ttYXAsIHN5bmN9IGFwaSBpcyB0aGF0
LCBmb3IgQUZfWERQIGFuZAo+ID4gPiA+ID4gPiA+ID4gPiA+IHRoZSBkcml2ZXIgbGF5ZXIsIHdl
IG5lZWQgdG8gc3VwcG9ydCB0aGVzZSBBUElzLiBUaGUgY3VycmVudCBjb25jbHVzaW9uIG9mCj4g
PiA+ID4gPiA+ID4gPiA+ID4gQUZfWERQIGlzIG5vLgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4gPiA+ID4gMi4gU2V0IGRtYV9zZXRfbWFza19hbmRfY29oZXJlbnQsIHRoZW4gd2Ug
Y2FuIHVzZSBETUEgQVBJIHVuaWZvcm1seSBpbnNpZGUKPiA+ID4gPiA+ID4gPiA+ID4gPiBkcml2
ZXIuIFRoaXMgaWRlYSBzZWVtcyB0byBiZSBpbmNvbnNpc3RlbnQgd2l0aCB0aGUgZnJhbWV3b3Jr
IGRlc2lnbiBvZiBETUEuIFRoZQo+ID4gPiA+ID4gPiA+ID4gPiA+IGNvbmNsdXNpb24gaXMgbm8u
Cj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiAzLiBXZSBub3RpY2VkIHRo
YXQgaWYgdGhlIHZpcnRpbyBkZXZpY2Ugc3VwcG9ydHMgVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JN
LCBpdAo+ID4gPiA+ID4gPiA+ID4gPiA+IHVzZXMgRE1BIEFQSS4gQW5kIHRoaXMgdHlwZSBvZiBk
ZXZpY2UgaXMgdGhlIGZ1dHVyZSBkaXJlY3Rpb24sIHNvIHdlIG9ubHkKPiA+ID4gPiA+ID4gPiA+
ID4gPiBzdXBwb3J0IERNQSBwcmVtYXBwZWQgZm9yIHRoaXMgdHlwZSBvZiB2aXJ0aW8gZGV2aWNl
LiBUaGUgcHJvYmxlbSB3aXRoIHRoaXMKPiA+ID4gPiA+ID4gPiA+ID4gPiBzb2x1dGlvbiBpcyB0
aGF0IHZpcnRxdWV1ZV9kbWFfZGV2KCkgb25seSByZXR1cm5zIGRldiBpbiBzb21lIGNhc2VzLCBi
ZWNhdXNlCj4gPiA+ID4gPiA+ID4gPiA+ID4gVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNIGlzIHN1
cHBvcnRlZCBpbiBzdWNoIGNhc2VzLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBDb3VsZCB5b3Ug
ZXhwbGFpbiB0aGUgaXNzdWUgYSBsaXR0bGUgYml0IG1vcmU/Cj4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+IEUuZyBpZiB3ZSBsaW1pdCBBRl9YRFAgdG8gQUNFU1NfUExBVEZST00gb25seSwgd2h5IGRv
ZXMKPiA+ID4gPiA+ID4gdmlydHF1ZXVlX2RtYV9kZXYoKSBvbmx5IHJldHVybiBkZXYgaW4gc29t
ZSBjYXNlcz8KPiA+ID4gPiA+Cj4gPiA+ID4gPiBUaGUgYmVoYXZpb3Igb2YgdmlydHF1ZXVlX2Rt
YV9kZXYoKSBpcyBub3QgcmVsYXRlZCB0byBBRl9YRFAuCj4gPiA+ID4gPgo+ID4gPiA+ID4gVGhl
IHJldHVybiB2YWx1ZSBvZiB2aXJ0cXVldWVfZG1hX2RldigpIGlzIHVzZWQgZm9yIHRoZSBETUEg
QVBJcy4gU28gaXQgY2FuCj4gPiA+ID4gPiByZXR1cm4gZG1hIGRldiB3aGVuIHRoZSB2aXJ0aW8g
aXMgd2l0aCBBQ0NFU1NfUExBVEZPUk0uIElmIHZpcnRpbyBpcyB3aXRob3V0Cj4gPiA+ID4gPiBB
Q0NFU1NfUExBVEZPUk0gdGhlbiBpdCBNVVNUIHJldHVybiBOVUxMLgo+ID4gPiA+ID4KPiA+ID4g
PiA+IEluIHRoZSB2aXJ0aW8tbmV0IGRyaXZlciwgaWYgdGhlIHZpcnRxdWV1ZV9kbWFfZGV2KCkg
cmV0dXJucyBkbWEgZGV2LAo+ID4gPiA+ID4gd2UgY2FuIGVuYWJsZSBBRl9YRFAuIElmIG5vdCwg
d2UgcmV0dXJuIGVycm9yIHRvIEFGX1hEUC4KPiA+ID4gPgo+ID4gPiA+IFllcywgYXMgZGlzY3Vz
c2VkLCBqdXN0IGhhdmluZyB3cmFwcGVycyBpbiB0aGUgdmlydGlvX3JpbmcgYW5kIGRvaW5nCj4g
PiA+ID4gdGhlIHN3aXRjaCB0aGVyZS4gVGhlbiBjYW4gdmlydGlvLW5ldCB1c2UgdGhlbSB3aXRo
b3V0IHdvcnJ5aW5nIGFib3V0Cj4gPiA+ID4gRE1BIGRldGFpbHM/Cj4gPiA+Cj4gPiA+Cj4gPiA+
IFllcy4gSW4gdGhlIHZpcnRpbyBkcml2ZXJzLCB3ZSBjYW4gdXNlIHRoZSB3cmFwcGVycy4gVGhh
dCBpcyBvay4KPiA+ID4KPiA+ID4gQnV0IHdlIGFsc28gbmVlZCB0byBzdXBwb3J0IHZpcnRxdWV1
ZV9kbWFfZGV2KCkgZm9yIEFGX1hEUCwgYmVjYXVzZSB0aGF0IHRoZQo+ID4gPiBBRl9YRFAgd2ls
bCBub3QgdXNlIHRoZSB3cmFwcGVycy4KPiA+Cj4gPiBZb3UgbWVhbiBBRl9YRFAgY29yZSBvciBv
dGhlcj8gQ291bGQgeW91IGdpdmUgbWUgYW4gZXhhbXBsZT8KPgo+Cj4gWWVzLiBUaGUgQUZfWERQ
IGNvcmUuCj4KPiBOb3cgdGhlIEFGX1hEUCBjb3JlIHdpbGwgZG8gdGhlIGRtYSBvcGVyYXRpb24u
ICBCZWNhdXNlIHRoYXQgdGhlIG1lbW9yeSBpcwo+IGFsbG9jYXRlZCBieSB0aGUgdXNlciBmcm9t
IHRoZSB1c2VyIHNwYWNlLiAgU28gYmVmb3JlIHB1dHRpbmcgdGhlIG1lbW9yeSB0byB0aGUKPiBk
cml2ZXIsIHRoZSBBRl9YRFAgd2lsbCBkbyB0aGUgZG1hIG1hcHBpbmcuCj4KPgo+IGludCB4cF9k
bWFfbWFwKHN0cnVjdCB4c2tfYnVmZl9wb29sICpwb29sLCBzdHJ1Y3QgZGV2aWNlICpkZXYsCj4g
ICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBhdHRycywgc3RydWN0IHBhZ2UgKipwYWdlcywg
dTMyIG5yX3BhZ2VzKQo+IHsKCkkgdGhpbmsgaXQncyB0aGUgZHJpdmVyIHdobyBwYXNzZXMgdGhl
IGRldmljZSBwb2ludGVyIGhlcmUuIEFueXRoaW5nIEkgbWlzc2VkPwoKVGhhbmtzCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
