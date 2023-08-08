Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68195C001DB
	for <virtualization@archiver.kernel.org>; Tue,  8 Aug 2023 03:49:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E197481E7D;
	Tue,  8 Aug 2023 03:49:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E197481E7D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YQGipajZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aNW-AaXtX3_H; Tue,  8 Aug 2023 03:49:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D932581A30;
	Tue,  8 Aug 2023 03:49:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D932581A30
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B98F6C0072;
	Tue,  8 Aug 2023 03:49:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37B1FC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 03:49:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 00329410C0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 03:49:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 00329410C0
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YQGipajZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6JfVG7wXAh7n
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 03:49:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9A623410B1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 03:49:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9A623410B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691466566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MwOfpaMivjlVT9pjwrG/H0BICQpgMmoEERyGjmBXqDY=;
 b=YQGipajZp0ZCqLfE8BnOKbiLkWeLLax24OG1yquLaO28ZCMpIaU6c8L5aVsT9PP7usVEiD
 7yyZ2EhmnHsEm9Z57xq0hzOg7hgPXdDHTXOFT76/gNsyAnypM6TkdDZvmNThrzT48yOm8x
 cxiadHFctrRJAxgP2huNRbgZnhuKiWA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-N-kLuuEWMMCAg10llFtElw-1; Mon, 07 Aug 2023 23:49:24 -0400
X-MC-Unique: N-kLuuEWMMCAg10llFtElw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b9c5cba6d1so52373461fa.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Aug 2023 20:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691466563; x=1692071363;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MwOfpaMivjlVT9pjwrG/H0BICQpgMmoEERyGjmBXqDY=;
 b=dNzfL4Slsl9PV32Np9BimBscitwKIue6fWddhKBSoKHPX6mSNuLaxCVY3o45Yfdp/n
 F50GRNoxE5FYVrduy4fiAUIjXr6gOzxpf5sVsbTfy6PpofhJjCcHnA/7OqJkz+VChtBl
 vhkwXqbRMjUJBFv/CgzsleGp7Tn2aS507Lj51kV+0RL3L8WwBZ7wkcjGcMhPPYq9hprg
 A53j2wHM2hbmZALAIw26InHcYu4u6sywGXuJ1wRNZp2DKzxnjdxkcMhOFKFtR7ekqdD3
 El2GfC2MJcfv1hP8o53QTMAhZzg6VIC4N8CDYuDtBlvNXvOnosGbIHjhmQt39ylpwK68
 XzxQ==
X-Gm-Message-State: AOJu0YxxZL6/RiXV9XAi/XjJ2Vs6xZVMStcltFFDPwyxkrrJIdwJ7rdF
 4qU7uRkKLhrYM21pSxukLPg7yxaaxC5PeZEewS8EA3Por7hkt5U3AbMWoGSRZi/3fui64KNiyJP
 rG0ToHAa00r8dSFTvE1wflU1aiMtGrZ7SS0yuWFvEFeukXPo8mbW4hs9oYQ==
X-Received: by 2002:a2e:7a0f:0:b0:2b9:c046:8617 with SMTP id
 v15-20020a2e7a0f000000b002b9c0468617mr7247328ljc.5.1691466563350; 
 Mon, 07 Aug 2023 20:49:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHf3NaTvpEKqdFmEjZFFevb9rA74T4ua1YzugN83Ckq49vACctmgXCYQ6hViq6x2aQYUDJb/zbm+8H3hsMulM=
X-Received: by 2002:a2e:7a0f:0:b0:2b9:c046:8617 with SMTP id
 v15-20020a2e7a0f000000b002b9c0468617mr7247321ljc.5.1691466563000; Mon, 07 Aug
 2023 20:49:23 -0700 (PDT)
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
In-Reply-To: <1691464183.5436294-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Aug 2023 11:49:08 +0800
Message-ID: <CACGkMEvUJ+GhhfkOB4Ux7-bDaPHvkA3xnvnMMQ+dYfWE4ZzFyw@mail.gmail.com>
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

T24gVHVlLCBBdWcgOCwgMjAyMyBhdCAxMToxMuKAr0FNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gT24gVHVlLCA4IEF1ZyAyMDIzIDExOjA4OjA5ICsw
ODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+IE9uIFR1ZSwg
QXVnIDgsIDIwMjMgYXQgMTA6NTLigK9BTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJh
YmEuY29tPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gVHVlLCA4IEF1ZyAyMDIzIDEwOjI2OjA0ICsw
ODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiBPbiBN
b24sIEF1ZyA3LCAyMDIzIGF0IDI6MTXigK9QTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFs
aWJhYmEuY29tPiB3cm90ZToKPiA+ID4gPiA+Cj4gPiA+ID4gPiBPbiBXZWQsIDIgQXVnIDIwMjMg
MDk6NDk6MzEgKzA4MDAsIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdy
b3RlOgo+ID4gPiA+ID4gPiBPbiBUdWUsIDEgQXVnIDIwMjMgMTI6MTc6NDcgLTA0MDAsICJNaWNo
YWVsIFMuIFRzaXJraW4iIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gT24g
RnJpLCBKdWwgMjgsIDIwMjMgYXQgMDI6MDI6MzNQTSArMDgwMCwgWHVhbiBaaHVvIHdyb3RlOgo+
ID4gPiA+ID4gPiA+ID4gT24gVHVlLCAyNSBKdWwgMjAyMyAxOTowNzoyMyArMDgwMCwgWHVhbiBa
aHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+
IE9uIFR1ZSwgMjUgSnVsIDIwMjMgMDM6MzQ6MzQgLTA0MDAsICJNaWNoYWVsIFMuIFRzaXJraW4i
IDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gT24gVHVlLCBKdWwg
MjUsIDIwMjMgYXQgMTA6MTM6NDhBTSArMDgwMCwgWHVhbiBaaHVvIHdyb3RlOgo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gT24gTW9uLCAyNCBKdWwgMjAyMyAwOTo0Mzo0MiAtMDcwMCwgQ2hyaXN0b3Bo
IEhlbGx3aWcgPGhjaEBpbmZyYWRlYWQub3JnPiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gT24gVGh1LCBKdWwgMjAsIDIwMjMgYXQgMDE6MjE6MDdQTSAtMDQwMCwgTWljaGFlbCBTLiBU
c2lya2luIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFdlbGwgSSB0aGluayB3ZSBj
YW4gYWRkIHdyYXBwZXJzIGxpa2UgdmlydGlvX2RtYV9zeW5jIGFuZCBzbyBvbi4KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiBUaGVyZSBhcmUgTk9QIGZvciBub24tZG1hIHNvIHBhc3NpbmcgdGhl
IGRtYSBkZXZpY2UgaXMgaGFybWxlc3MuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IFllcywgcGxlYXNlLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBJIGFtIG5vdCBzdXJlIEkgZ290
IHRoaXMgZnVsbHkuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
QXJlIHlvdSBtZWFuIHRoaXM6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9hbGwvMjAyMzAyMTQwNzI3MDQuMTI2NjYwLTgteHVhbnpodW9AbGludXguYWxpYmFi
YS5jb20vCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwv
MjAyMzAyMTQwNzI3MDQuMTI2NjYwLTkteHVhbnpodW9AbGludXguYWxpYmFiYS5jb20vCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gVGhlbiB0aGUgZHJpdmVyIG11
c3QgZG8gZG1hIG9wZXJhdGlvbihtYXAgYW5kIHN5bmMpIGJ5IHRoZXNlIHZpcnRpb19kbWFfKiBB
UElzLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gTm8gY2FyZSB0aGUgZGV2aWNlIGlzIG5vbi1kbWEg
ZGV2aWNlIG9yIGRtYSBkZXZpY2UuCj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+
ID4gPiB5ZXMKPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gVGhlbiB0
aGUgQUZfWERQIG11c3QgdXNlIHRoZXNlIHZpcnRpb19kbWFfKiBBUElzIGZvciB2aXJ0aW8gZGV2
aWNlLgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gV2UnbGwgd29ycnkg
YWJvdXQgQUZfWERQIHdoZW4gdGhlIHBhdGNoIGlzIHBvc3RlZC4KPiA+ID4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiA+ID4gWUVTLgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4g
PiBXZSBkaXNjdXNzZWQgaXQuIFRoZXkgdm90ZWQgJ25vJy4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiA+ID4gaHR0cDovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzA0MjQwODI4NTYu
MTVjMWU1OTNAa2VybmVsLm9yZwo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4gPiBIaSBndXlzLCB0aGlzIHRvcGljIGlzIHN0dWNrIGFnYWluLiBIb3cgc2hvdWxk
IEkgcHJvY2VlZCB3aXRoIHRoaXMgd29yaz8KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4g
PiBMZXQgbWUgYnJpZWZseSBzdW1tYXJpemU6Cj4gPiA+ID4gPiA+ID4gPiAxLiBUaGUgcHJvYmxl
bSB3aXRoIGFkZGluZyB2aXJ0aW9fZG1hX3ttYXAsIHN5bmN9IGFwaSBpcyB0aGF0LCBmb3IgQUZf
WERQIGFuZAo+ID4gPiA+ID4gPiA+ID4gdGhlIGRyaXZlciBsYXllciwgd2UgbmVlZCB0byBzdXBw
b3J0IHRoZXNlIEFQSXMuIFRoZSBjdXJyZW50IGNvbmNsdXNpb24gb2YKPiA+ID4gPiA+ID4gPiA+
IEFGX1hEUCBpcyBuby4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiAyLiBTZXQgZG1h
X3NldF9tYXNrX2FuZF9jb2hlcmVudCwgdGhlbiB3ZSBjYW4gdXNlIERNQSBBUEkgdW5pZm9ybWx5
IGluc2lkZQo+ID4gPiA+ID4gPiA+ID4gZHJpdmVyLiBUaGlzIGlkZWEgc2VlbXMgdG8gYmUgaW5j
b25zaXN0ZW50IHdpdGggdGhlIGZyYW1ld29yayBkZXNpZ24gb2YgRE1BLiBUaGUKPiA+ID4gPiA+
ID4gPiA+IGNvbmNsdXNpb24gaXMgbm8uCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4g
My4gV2Ugbm90aWNlZCB0aGF0IGlmIHRoZSB2aXJ0aW8gZGV2aWNlIHN1cHBvcnRzIFZJUlRJT19G
X0FDQ0VTU19QTEFURk9STSwgaXQKPiA+ID4gPiA+ID4gPiA+IHVzZXMgRE1BIEFQSS4gQW5kIHRo
aXMgdHlwZSBvZiBkZXZpY2UgaXMgdGhlIGZ1dHVyZSBkaXJlY3Rpb24sIHNvIHdlIG9ubHkKPiA+
ID4gPiA+ID4gPiA+IHN1cHBvcnQgRE1BIHByZW1hcHBlZCBmb3IgdGhpcyB0eXBlIG9mIHZpcnRp
byBkZXZpY2UuIFRoZSBwcm9ibGVtIHdpdGggdGhpcwo+ID4gPiA+ID4gPiA+ID4gc29sdXRpb24g
aXMgdGhhdCB2aXJ0cXVldWVfZG1hX2RldigpIG9ubHkgcmV0dXJucyBkZXYgaW4gc29tZSBjYXNl
cywgYmVjYXVzZQo+ID4gPiA+ID4gPiA+ID4gVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNIGlzIHN1
cHBvcnRlZCBpbiBzdWNoIGNhc2VzLgo+ID4gPiA+Cj4gPiA+ID4gQ291bGQgeW91IGV4cGxhaW4g
dGhlIGlzc3VlIGEgbGl0dGxlIGJpdCBtb3JlPwo+ID4gPiA+Cj4gPiA+ID4gRS5nIGlmIHdlIGxp
bWl0IEFGX1hEUCB0byBBQ0VTU19QTEFURlJPTSBvbmx5LCB3aHkgZG9lcwo+ID4gPiA+IHZpcnRx
dWV1ZV9kbWFfZGV2KCkgb25seSByZXR1cm4gZGV2IGluIHNvbWUgY2FzZXM/Cj4gPiA+Cj4gPiA+
IFRoZSBiZWhhdmlvciBvZiB2aXJ0cXVldWVfZG1hX2RldigpIGlzIG5vdCByZWxhdGVkIHRvIEFG
X1hEUC4KPiA+ID4KPiA+ID4gVGhlIHJldHVybiB2YWx1ZSBvZiB2aXJ0cXVldWVfZG1hX2Rldigp
IGlzIHVzZWQgZm9yIHRoZSBETUEgQVBJcy4gU28gaXQgY2FuCj4gPiA+IHJldHVybiBkbWEgZGV2
IHdoZW4gdGhlIHZpcnRpbyBpcyB3aXRoIEFDQ0VTU19QTEFURk9STS4gSWYgdmlydGlvIGlzIHdp
dGhvdXQKPiA+ID4gQUNDRVNTX1BMQVRGT1JNIHRoZW4gaXQgTVVTVCByZXR1cm4gTlVMTC4KPiA+
ID4KPiA+ID4gSW4gdGhlIHZpcnRpby1uZXQgZHJpdmVyLCBpZiB0aGUgdmlydHF1ZXVlX2RtYV9k
ZXYoKSByZXR1cm5zIGRtYSBkZXYsCj4gPiA+IHdlIGNhbiBlbmFibGUgQUZfWERQLiBJZiBub3Qs
IHdlIHJldHVybiBlcnJvciB0byBBRl9YRFAuCj4gPgo+ID4gWWVzLCBhcyBkaXNjdXNzZWQsIGp1
c3QgaGF2aW5nIHdyYXBwZXJzIGluIHRoZSB2aXJ0aW9fcmluZyBhbmQgZG9pbmcKPiA+IHRoZSBz
d2l0Y2ggdGhlcmUuIFRoZW4gY2FuIHZpcnRpby1uZXQgdXNlIHRoZW0gd2l0aG91dCB3b3JyeWlu
ZyBhYm91dAo+ID4gRE1BIGRldGFpbHM/Cj4KPgo+IFllcy4gSW4gdGhlIHZpcnRpbyBkcml2ZXJz
LCB3ZSBjYW4gdXNlIHRoZSB3cmFwcGVycy4gVGhhdCBpcyBvay4KPgo+IEJ1dCB3ZSBhbHNvIG5l
ZWQgdG8gc3VwcG9ydCB2aXJ0cXVldWVfZG1hX2RldigpIGZvciBBRl9YRFAsIGJlY2F1c2UgdGhh
dCB0aGUKPiBBRl9YRFAgd2lsbCBub3QgdXNlIHRoZSB3cmFwcGVycy4KCllvdSBtZWFuIEFGX1hE
UCBjb3JlIG9yIG90aGVyPyBDb3VsZCB5b3UgZ2l2ZSBtZSBhbiBleGFtcGxlPwoKVGhhbmtzCgo+
Cj4gU28gdGhhdCBpcyBvayBmb3IgeW91Pwo+Cj4gVGhhbmtzLgo+Cj4gPgo+ID4gVGhhbmtzCj4g
Pgo+ID4gPgo+ID4gPiBUaGFua3MKPiA+ID4KPiA+ID4KPiA+ID4KPiA+ID4KPiA+ID4gPgo+ID4g
PiA+IFRoYW5rcwo+ID4gPiA+Cj4gPiA+ID4gPk90aGVyd2lzZSBOVUxMIGlzIHJldHVybmVkLgo+
ID4gPiA+ID4gPiA+ID4gVGhpcyBvcHRpb24gaXMgY3VycmVudGx5IE5PLgo+ID4gPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gPiA+IFNvIEknbSB3b25kZXJpbmcgd2hhdCBzaG91bGQgSSBkbywgZnJv
bSBhIERNQSBwb2ludCBvZiB2aWV3LCBpcyB0aGVyZSBhbnkKPiA+ID4gPiA+ID4gPiA+IHNvbHV0
aW9uIGluIGNhc2Ugb2YgdXNpbmcgRE1BIEFQST8KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gPiBUaGFuayB5b3UKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4g
SSB0aGluayBpdCdzIG9rIGF0IHRoaXMgcG9pbnQsIENocmlzdG9waCBqdXN0IGFza2VkIHlvdQo+
ID4gPiA+ID4gPiA+IHRvIGFkZCB3cmFwcGVycyBmb3IgbWFwL3VubWFwIGZvciB1c2UgaW4gdmly
dGlvIGNvZGUuCj4gPiA+ID4gPiA+ID4gU2VlbXMgbGlrZSBhIGNvc21ldGljIGNoYW5nZSwgc2hv
dWxkbid0IGJlIGhhcmQuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFllcywgdGhhdCBpcyBub3Qg
aGFyZCwgSSBoYXMgdGhpcyBjb2RlLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBCdXQsIHlvdSBt
ZWFuIHRoYXQgdGhlIHdyYXBwZXJzIGlzIGp1c3QgdXNlZCBmb3IgdGhlIHZpcnRpbyBkcml2ZXIg
Y29kZT8KPiA+ID4gPiA+ID4gQW5kIHdlIGFsc28gb2ZmZXIgdGhlICBBUEkgdmlydHF1ZXVlX2Rt
YV9kZXYoKSBhdCB0aGUgc2FtZSB0aW1lPwo+ID4gPiA+ID4gPiBUaGVuIHRoZSBkcml2ZXIgd2ls
bCBoYXMgdHdvIGNob29zZXMgdG8gZG8gRE1BLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBJcyB0
aGF0IHNvPwo+ID4gPiA+ID4KPiA+ID4gPiA+IFBpbmcuCj4gPiA+ID4gPgo+ID4gPiA+ID4gVGhh
bmtzCj4gPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IE90aGVy
d2lzZSBJIGhhdmVuJ3Qgc2VlbiBzaWduaWZpY2FudCBjb21tZW50cy4KPiA+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gQ2hyaXN0b3BoIGRvIEkgc3VtbWFyaXplIHdoYXQg
eW91IGFyZSBzYXlpbmcgY29ycmVjdGx5Pwo+ID4gPiA+ID4gPiA+IC0tCj4gPiA+ID4gPiA+ID4g
TVNUCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4KPiA+
Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
