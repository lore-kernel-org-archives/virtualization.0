Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F1B7C001DB
	for <virtualization@archiver.kernel.org>; Tue, 15 Aug 2023 01:28:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0FB1F408E9;
	Tue, 15 Aug 2023 01:28:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0FB1F408E9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eQ+eT+HI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZSIooAv7tRWQ; Tue, 15 Aug 2023 01:28:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1293E4085E;
	Tue, 15 Aug 2023 01:28:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1293E4085E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D07FAC0072;
	Tue, 15 Aug 2023 01:28:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80260C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 01:28:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 491E340600
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 01:28:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 491E340600
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eQ+eT+HI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vuk3hQzSg6q8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 01:28:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E8E5F4020B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 01:28:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E8E5F4020B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692062913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VE6mob003STEOzTU2eNJ6jYzNMv9F/ENb7pqQWeZKlY=;
 b=eQ+eT+HIUTyznN2zvxmDsbgKwTteETX35dmIhnQzrG2LQdl1ZwuFChg5a39JzpLaQXYxUT
 qY85F6BqB7eClZWkRlvcSbV2Eg7gj71s0iTmrsyd4nWu367F+iyVe43Avd6uydS7XbX121
 PkoCy2l69vXuYB3qpicRO+RRK2i5FEs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-oCElpWbGMd6i70ybimikOA-1; Mon, 14 Aug 2023 21:28:31 -0400
X-MC-Unique: oCElpWbGMd6i70ybimikOA-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2bb8ba5dfa2so470091fa.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 18:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692062910; x=1692667710;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VE6mob003STEOzTU2eNJ6jYzNMv9F/ENb7pqQWeZKlY=;
 b=kxB6AbYhiUV/MBVuAtaZof7D6SF+9KIwPvqNMJiJOZmGd5eWwEMcq8Jk3ulcx84CNe
 f9HeIep9UEH4/JJiuRM7MCD+gB+JA+hlB+41x8MEkuupCKlMmNRxRrunW7P4MmMxGJCw
 mpcY1izzy6d6Fvzw7croquLCXGE51BWZUSEjuRAa2gxlnrxWPxrU2+cUmNqVUP5S1/ZN
 AgwjuGammmXxG0t2BUe/1h7irPvmaCQFzOUWunWaabkmjLVIaJRxgoplEJ897afINnsR
 xoKlEssmVAbPQifcsQYJ3JCCNxpFqfzFeLjljA9Cx1MLqGvW6Lrfzx0KyL0lMq5i8zPc
 j6MQ==
X-Gm-Message-State: AOJu0YxoWT/zR5pTfP0GLraa4yBj+/F21VU60myeRS9qqLBd5Krd4B2V
 w7nZHGD62kX3W5krkySFtOe82N4uPDvwRz/UkwxBcAfb07jDYXiCP0Fyskw+ZbyaAptKpiOk5It
 89i6g952qnSEGwTqK9VSeWOnnAeP3R8tCjbMMr6Xz0v9gcu95yF40fin2lA==
X-Received: by 2002:a05:651c:324:b0:2b9:b1fb:5ff4 with SMTP id
 b4-20020a05651c032400b002b9b1fb5ff4mr152366ljp.21.1692062910254; 
 Mon, 14 Aug 2023 18:28:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvWOWCxpqCNTpDtqy6UKDkdmXaQ46MPGRiK9GSWe2FregOL7ihD6zQjbmg/VMrJzLvEcpXYAbNdb191YrWGa4=
X-Received: by 2002:a05:651c:324:b0:2b9:b1fb:5ff4 with SMTP id
 b4-20020a05651c032400b002b9b1fb5ff4mr152360ljp.21.1692062909897; Mon, 14 Aug
 2023 18:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230802171231.11001-1-dtatulea@nvidia.com>
 <20230802171231.11001-3-dtatulea@nvidia.com>
 <CACGkMEsE45k+fqv-biYfOX5VbqZLo_drQV5rPYByuLJZK03hWQ@mail.gmail.com>
 <b31737724cdcf0cc63fbec56209b7288dc8fcfce.camel@nvidia.com>
 <CACGkMEvoE=1ac1EGxPd14AwCfuOTiZYzYgDQC_qZjSubt891sA@mail.gmail.com>
 <83ca86a42041248f8db717cdc858b7f973cbd85b.camel@nvidia.com>
 <CACGkMEt95WsDxuc-vGWNhZfZ5G9AGUykV5+kV8oDcGZQ4jD-Lg@mail.gmail.com>
 <8316b7a41f80d9a0b03795e33201be02b3be756e.camel@nvidia.com>
In-Reply-To: <8316b7a41f80d9a0b03795e33201be02b3be756e.camel@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 15 Aug 2023 09:28:18 +0800
Message-ID: <CACGkMEsGfbOK-SX-xv2Re5PrPt343UdvgxU+etvXBTmQEjhwSQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa/mlx5: Fix mr->initialized semantics
To: Dragos Tatulea <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "mst@redhat.com" <mst@redhat.com>, Gal Pressman <gal@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>
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

T24gTW9uLCBBdWcgMTQsIDIwMjMgYXQgMTA6MTXigK9QTSBEcmFnb3MgVGF0dWxlYSA8ZHRhdHVs
ZWFAbnZpZGlhLmNvbT4gd3JvdGU6Cj4KPiBPbiBXZWQsIDIwMjMtMDgtMDkgYXQgMDk6NDIgKzA4
MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiBPbiBUdWUsIEF1ZyA4LCAyMDIzIGF0IDM6MjTigK9Q
TSBEcmFnb3MgVGF0dWxlYSA8ZHRhdHVsZWFAbnZpZGlhLmNvbT4gd3JvdGU6Cj4gPiA+Cj4gPiA+
IE9uIFR1ZSwgMjAyMy0wOC0wOCBhdCAxMDo1NyArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+
ID4gPiBPbiBUaHUsIEF1ZyAzLCAyMDIzIGF0IDc6NDDigK9QTSBEcmFnb3MgVGF0dWxlYSA8ZHRh
dHVsZWFAbnZpZGlhLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4gT24gVGh1LCAyMDIz
LTA4LTAzIGF0IDE2OjAzICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiBPbiBU
aHUsIEF1ZyAzLCAyMDIzIGF0IDE6MTPigK9BTSBEcmFnb3MgVGF0dWxlYSA8ZHRhdHVsZWFAbnZp
ZGlhLmNvbT4KPiA+ID4gPiA+ID4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBU
aGUgbXItPmluaXRpYWxpemVkIGZsYWcgaXMgc2hhcmVkIGJldHdlZW4gdGhlIGNvbnRyb2wgdnEg
YW5kIGRhdGEKPiA+ID4gPiA+ID4gPiB2cQo+ID4gPiA+ID4gPiA+IHBhcnQgb2YgdGhlIG1yIGlu
aXQvdW5pbml0LiBCdXQgaWYgdGhlIGNvbnRyb2wgdnEgYW5kIGRhdGEgdnEgZ2V0Cj4gPiA+ID4g
PiA+ID4gcGxhY2VkCj4gPiA+ID4gPiA+ID4gaW4gZGlmZmVyZW50IEFTSURzLCBpdCBjYW4gaGFw
cGVuIHRoYXQgaW5pdGlhbGl6aW5nIHRoZSBjb250cm9sIHZxCj4gPiA+ID4gPiA+ID4gd2lsbAo+
ID4gPiA+ID4gPiA+IHByZXZlbnQgdGhlIGRhdGEgdnEgbXIgZnJvbSBiZWluZyBpbml0aWFsaXpl
ZC4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IFRoaXMgcGF0Y2ggY29uc29saWRhdGVzIHRo
ZSBjb250cm9sIGFuZCBkYXRhIHZxIGluaXQgcGFydHMgaW50bwo+ID4gPiA+ID4gPiA+IHRoZWly
Cj4gPiA+ID4gPiA+ID4gb3duIGluaXQgZnVuY3Rpb25zLiBUaGUgbXItPmluaXRpYWxpemVkIHdp
bGwgbm93IGJlIHVzZWQgZm9yIHRoZQo+ID4gPiA+ID4gPiA+IGRhdGEgdnEKPiA+ID4gPiA+ID4g
PiBvbmx5LiBUaGUgY29udHJvbCB2cSBjdXJyZW50bHkgZG9lc24ndCBuZWVkIGEgZmxhZy4KPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IFRoZSB1bmluaXRpYWxpemluZyBwYXJ0IGlzIGFsc28g
dGFrZW4gY2FyZSBvZjogbWx4NV92ZHBhX2Rlc3Ryb3lfbXIKPiA+ID4gPiA+ID4gPiBnb3QKPiA+
ID4gPiA+ID4gPiBzcGxpdCBpbnRvIGRhdGEgYW5kIGNvbnRyb2wgdnEgZnVuY3Rpb25zIHdoaWNo
IGFyZSBub3cgYWxzbyBBU0lECj4gPiA+ID4gPiA+ID4gYXdhcmUuCj4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiBGaXhlczogOGZjZDIwYzMwNzA0ICgidmRwYS9tbHg1OiBTdXBwb3J0IGRpZmZl
cmVudCBhZGRyZXNzIHNwYWNlcwo+ID4gPiA+ID4gPiA+IGZvcgo+ID4gPiA+ID4gPiA+IGNvbnRy
b2wgYW5kIGRhdGEiKQo+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IERyYWdvcyBUYXR1bGVh
IDxkdGF0dWxlYUBudmlkaWEuY29tPgo+ID4gPiA+ID4gPiA+IFJldmlld2VkLWJ5OiBFdWdlbmlv
IFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiA+ID4gPiA+ID4gPiBSZXZpZXdlZC1ieTog
R2FsIFByZXNzbWFuIDxnYWxAbnZpZGlhLmNvbT4KPiA+ID4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+
ID4gPiAgZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaCB8ICAxICsKPiA+ID4gPiA+
ID4gPiAgZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jICAgICAgICB8IDk3ICsrKysrKysrKysr
KysrKysrKysrKy0tLS0tLQo+ID4gPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4gPiA+ICAyIGZpbGVz
IGNoYW5nZWQsIDcxIGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQo+ID4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92
ZHBhLmgKPiA+ID4gPiA+ID4gPiBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgK
PiA+ID4gPiA+ID4gPiBpbmRleCAyNWZjNDEyMGI2MTguLmEwNDIwYmU1MDU5ZiAxMDA2NDQKPiA+
ID4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oCj4gPiA+
ID4gPiA+ID4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaAo+ID4gPiA+
ID4gPiA+IEBAIC0zMSw2ICszMSw3IEBAIHN0cnVjdCBtbHg1X3ZkcGFfbXIgewo+ID4gPiA+ID4g
PiA+ICAgICAgICAgc3RydWN0IGxpc3RfaGVhZCBoZWFkOwo+ID4gPiA+ID4gPiA+ICAgICAgICAg
dW5zaWduZWQgbG9uZyBudW1fZGlyZWN0czsKPiA+ID4gPiA+ID4gPiAgICAgICAgIHVuc2lnbmVk
IGxvbmcgbnVtX2tsbXM7Cj4gPiA+ID4gPiA+ID4gKyAgICAgICAvKiBzdGF0ZSBvZiBkdnEgbXIg
Ki8KPiA+ID4gPiA+ID4gPiAgICAgICAgIGJvb2wgaW5pdGlhbGl6ZWQ7Cj4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiAgICAgICAgIC8qIHNlcmlhbGl6ZSBta2V5IGNyZWF0aW9uIGFuZCBkZXN0
cnVjdGlvbiAqLwo+ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9j
b3JlL21yLmMKPiA+ID4gPiA+ID4gPiBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYwo+ID4g
PiA+ID4gPiA+IGluZGV4IDAzZTU0MzIyOTc5MS4uNGFlMTRhMjQ4YTRiIDEwMDY0NAo+ID4gPiA+
ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYwo+ID4gPiA+ID4gPiA+ICsr
KyBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYwo+ID4gPiA+ID4gPiA+IEBAIC00ODksNjAg
KzQ4OSwxMDMgQEAgc3RhdGljIHZvaWQgZGVzdHJveV91c2VyX21yKHN0cnVjdAo+ID4gPiA+ID4g
PiA+IG1seDVfdmRwYV9kZXYKPiA+ID4gPiA+ID4gPiAqbXZkZXYsIHN0cnVjdCBtbHg1X3ZkcGFf
bXIgKm1yCj4gPiA+ID4gPiA+ID4gICAgICAgICB9Cj4gPiA+ID4gPiA+ID4gIH0KPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+IC12b2lkIG1seDVfdmRwYV9kZXN0cm95X21yKHN0cnVjdCBtbHg1
X3ZkcGFfZGV2ICptdmRldikKPiA+ID4gPiA+ID4gPiArc3RhdGljIHZvaWQgX21seDVfdmRwYV9k
ZXN0cm95X2N2cV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsCj4gPiA+ID4gPiA+ID4g
dW5zaWduZWQKPiA+ID4gPiA+ID4gPiBpbnQgYXNpZCkKPiA+ID4gPiA+ID4gPiArewo+ID4gPiA+
ID4gPiA+ICsgICAgICAgaWYgKG12ZGV2LT5ncm91cDJhc2lkW01MWDVfVkRQQV9DVlFfR1JPVVBd
ICE9IGFzaWQpCj4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybjsKPiA+ID4gPiA+
ID4gPiArCj4gPiA+ID4gPiA+ID4gKyAgICAgICBwcnVuZV9pb3RsYihtdmRldik7Cj4gPiA+ID4g
PiA+ID4gK30KPiA+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ID4gK3N0YXRpYyB2b2lkIF9tbHg1
X3ZkcGFfZGVzdHJveV9kdnFfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LAo+ID4gPiA+
ID4gPiA+IHVuc2lnbmVkCj4gPiA+ID4gPiA+ID4gaW50IGFzaWQpCj4gPiA+ID4gPiA+ID4gIHsK
PiA+ID4gPiA+ID4gPiAgICAgICAgIHN0cnVjdCBtbHg1X3ZkcGFfbXIgKm1yID0gJm12ZGV2LT5t
cjsKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IC0gICAgICAgbXV0ZXhfbG9jaygmbXItPm1r
ZXlfbXR4KTsKPiA+ID4gPiA+ID4gPiArICAgICAgIGlmIChtdmRldi0+Z3JvdXAyYXNpZFtNTFg1
X1ZEUEFfREFUQVZRX0dST1VQXSAhPSBhc2lkKQo+ID4gPiA+ID4gPiA+ICsgICAgICAgICAgICAg
ICByZXR1cm47Cj4gPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiA+ICAgICAgICAgaWYgKCFtci0+
aW5pdGlhbGl6ZWQpCj4gPiA+ID4gPiA+ID4gLSAgICAgICAgICAgICAgIGdvdG8gb3V0Owo+ID4g
PiA+ID4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm47Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiAtICAgICAgIHBydW5lX2lvdGxiKG12ZGV2KTsKPiA+ID4gPiA+ID4gPiAgICAgICAgIGlm
IChtci0+dXNlcl9tcikKPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgZGVzdHJveV91c2Vy
X21yKG12ZGV2LCBtcik7Cj4gPiA+ID4gPiA+ID4gICAgICAgICBlbHNlCj4gPiA+ID4gPiA+ID4g
ICAgICAgICAgICAgICAgIGRlc3Ryb3lfZG1hX21yKG12ZGV2LCBtcik7Cj4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiAgICAgICAgIG1yLT5pbml0aWFsaXplZCA9IGZhbHNlOwo+ID4gPiA+ID4g
PiA+IC1vdXQ6Cj4gPiA+ID4gPiA+ID4gK30KPiA+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ID4g
K3N0YXRpYyB2b2lkIG1seDVfdmRwYV9kZXN0cm95X21yX2FzaWQoc3RydWN0IG1seDVfdmRwYV9k
ZXYgKm12ZGV2LAo+ID4gPiA+ID4gPiA+IHVuc2lnbmVkCj4gPiA+ID4gPiA+ID4gaW50IGFzaWQp
Cj4gPiA+ID4gPiA+ID4gK3sKPiA+ID4gPiA+ID4gPiArICAgICAgIHN0cnVjdCBtbHg1X3ZkcGFf
bXIgKm1yID0gJm12ZGV2LT5tcjsKPiA+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ID4gKyAgICAg
ICBtdXRleF9sb2NrKCZtci0+bWtleV9tdHgpOwo+ID4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4g
PiArICAgICAgIF9tbHg1X3ZkcGFfZGVzdHJveV9kdnFfbXIobXZkZXYsIGFzaWQpOwo+ID4gPiA+
ID4gPiA+ICsgICAgICAgX21seDVfdmRwYV9kZXN0cm95X2N2cV9tcihtdmRldiwgYXNpZCk7Cj4g
PiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiA+ICAgICAgICAgbXV0ZXhfdW5sb2NrKCZtci0+bWtl
eV9tdHgpOwo+ID4gPiA+ID4gPiA+ICB9Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiAtc3Rh
dGljIGludCBfbWx4NV92ZHBhX2NyZWF0ZV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYs
Cj4gPiA+ID4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgdmhv
c3RfaW90bGIgKmlvdGxiLCB1bnNpZ25lZAo+ID4gPiA+ID4gPiA+IGludAo+ID4gPiA+ID4gPiA+
IGFzaWQpCj4gPiA+ID4gPiA+ID4gK3ZvaWQgbWx4NV92ZHBhX2Rlc3Ryb3lfbXIoc3RydWN0IG1s
eDVfdmRwYV9kZXYgKm12ZGV2KQo+ID4gPiA+ID4gPiA+ICt7Cj4gPiA+ID4gPiA+ID4gKyAgICAg
ICBtbHg1X3ZkcGFfZGVzdHJveV9tcl9hc2lkKG12ZGV2LCBtdmRldi0KPiA+ID4gPiA+ID4gPiA+
IGdyb3VwMmFzaWRbTUxYNV9WRFBBX0NWUV9HUk9VUF0pOwo+ID4gPiA+ID4gPiA+ICsgICAgICAg
bWx4NV92ZHBhX2Rlc3Ryb3lfbXJfYXNpZChtdmRldiwgbXZkZXYtCj4gPiA+ID4gPiA+ID4gPiBn
cm91cDJhc2lkW01MWDVfVkRQQV9EQVRBVlFfR1JPVVBdKTsKPiA+ID4gPiA+ID4gPiArfQo+ID4g
PiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gPiArc3RhdGljIGludCBfbWx4NV92ZHBhX2NyZWF0ZV9j
dnFfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LAo+ID4gPiA+ID4gPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIsCj4g
PiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQg
aW50IGFzaWQpCj4gPiA+ID4gPiA+ID4gK3sKPiA+ID4gPiA+ID4gPiArICAgICAgIGlmIChtdmRl
di0+Z3JvdXAyYXNpZFtNTFg1X1ZEUEFfQ1ZRX0dST1VQXSAhPSBhc2lkKQo+ID4gPiA+ID4gPiA+
ICsgICAgICAgICAgICAgICByZXR1cm4gMDsKPiA+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ID4g
KyAgICAgICByZXR1cm4gZHVwX2lvdGxiKG12ZGV2LCBpb3RsYik7Cj4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+IFRoaXMgd29ycmllcyBtZSBhcyBjb25jZXB0dWFsbHksIHRoZXJlIHNob3VsZCBiZSBu
byBkaWZmZXJlbmNlIGJldHdlZW4KPiA+ID4gPiA+ID4gZHZxIG1yIGFuZCBjdnEgbXIuIFRoZSB2
aXJ0cXVldWUgc2hvdWxkIGJlIGxvb3NlbHkgY291cGxlZCB3aXRoIG1yLgo+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gQXJlIHlvdSB3b3JyaWVkIGJ5IHRoZSBjaGFuZ2VzIGluIHRoaXMgcGF0Y2ggb3Ig
YWJvdXQgdGhlIHBvc3NpYmlsaXR5IG9mCj4gPiA+ID4gPiBoYXZpbmcKPiA+ID4gPiA+Cj4gPiA+
ID4gPiBUaGUgcmVhc29uIGZvciB0aGlzIGNoYW5nZSBpcyB0aGF0IEkgbm90aWNlZCBpZiB5b3Ug
Y3JlYXRlIG9uZSBtciBpbiBvbmUKPiA+ID4gPiA+IGFzaWQKPiA+ID4gPiA+IHlvdSBjb3VsZCBi
ZSBibG9ja2VkIG91dCBmcm9tIGNyZWF0aW5nIGFub3RoZXIgb25lIGluIGEgZGlmZmVyZW50IGFz
aWQKPiA+ID4gPiA+IGR1ZQo+ID4gPiA+ID4gdG8KPiA+ID4gPiA+IG1yLT5pbml0aWFsaXplZCBi
ZWluZyB0cnVlLiBUbyBtZSB0aGF0IHNlZW1lZCBwcm9ibGVtYXRpYy4gSXMgaXQgbm90Pwo+ID4g
PiA+Cj4gPiA+ID4gTXkgZmVlbGluZyBpcyB0aGF0IG1yLmMgc2hvdWxkIGJlIGRldmljZSBhZ25v
c3RpYy4gSXQgbmVlZHMgdG8ga25vdwo+ID4gPiA+IG5vdGhpbmcgYWJvdXQgdGhlIGRldmljZSBk
ZXRhaWxzIHRvIHdvcmsuIEJ1dCB0aGlzIHBhdGNoIHNlZW1zIHRvCj4gPiA+ID4gYnJlYWsgdGhl
IGxheWVyLgo+ID4gPiA+Cj4gPiA+IEJ1dCB0aGUgc2FtZSBsb2dpYyB3YXMgdGhlcmUgYmVmb3Jl
ICh3aXRoIHRoZSBleGNlcHRpb24gb2YgY3ZxIG5vdCBoYXZpbmcgYW4KPiA+ID4gaW5pdCBmbGFn
IGFueW1vcmUpLiBTbyB3aGF0IGFtIEkgbWlzc2luZyBoZXJlPwo+ID4KPiA+IE5vdGhpbmcsIEkg
dGhpbmsgeW91J3JlIHJpZ2h0Lgo+ID4KPiA+IEkgdGhpbmsgd2UgY2FuIGhhdmUgdGhpcyBwYXRj
aCBnbyBmaXJzdCBhbmQgdHdlYWsgb24gdG9wIGJ5IG1vdmluZyBDVlEKPiA+IGF3YXJlIGxvZ2lj
IGludG8gdGhlIG5ldCBzcGVjaWZpYyBjb2Rlcy4KPiA+Cj4gSXMgdGhpcyBhbnl0aGluZyBtb3Jl
IHRoYW4gYSByZS1vcmc/CgpOby4KCj4gTXkgcGxhbiBpcyB0byBtb3ZlIHRoZSBjdnEgbXIgcGFy
dCBmcm9tCj4gbWx4NV92ZHBhX2RldiBpbnRvIG1seDVfdmRwYV9uZXQuIElzIHRoZXJlIGFueXRo
aW5nIGVsc2UgdGhhdCB5b3Ugd2VyZSBleHBlY3RpbmcKPiBoZXJlPwo+CgpUaGF0J3MgZmluZS4K
ClRoYW5rcwoKPiBUaGFua3MsCj4gRHJhZ29zCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
