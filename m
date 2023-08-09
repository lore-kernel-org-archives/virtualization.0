Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B273CC001B0
	for <virtualization@archiver.kernel.org>; Wed,  9 Aug 2023 01:43:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1AD9A60D67;
	Wed,  9 Aug 2023 01:43:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1AD9A60D67
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G5QqJV2w
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9FLUKJQC6vqw; Wed,  9 Aug 2023 01:42:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9045F607C9;
	Wed,  9 Aug 2023 01:42:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9045F607C9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 624BFC0071;
	Wed,  9 Aug 2023 01:42:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74B05C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 01:42:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 41CE560B1A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 01:42:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 41CE560B1A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r_ZSmHxtk3Qz
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 01:42:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 49DA4607C9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 01:42:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 49DA4607C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691545374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pa2LVSoDWp2k+eTV35Hp4pdi9W8RLvbM8EeGVoHpM5c=;
 b=G5QqJV2wjxvEiQXYXYePHioX6U6TcSRpCJMU58Qhkpb3EeR+SJOwbH6ucswfkhnAJ+LAFC
 hjWQRtpQYwKK31pFxRpdFv1qUXex93q3jlZkIlX4sXzYdKKBiSDql6mr+a1aVXxKhV7CRw
 UWfmAjrlMYsXTp2bC6ZBh+lZ3w5RdR8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-FtE36E_lPh6tS2btNPLLew-1; Tue, 08 Aug 2023 21:42:53 -0400
X-MC-Unique: FtE36E_lPh6tS2btNPLLew-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b9bb2d0b47so33987541fa.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Aug 2023 18:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691545372; x=1692150172;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pa2LVSoDWp2k+eTV35Hp4pdi9W8RLvbM8EeGVoHpM5c=;
 b=jh0VSWbQQQSnMlnnvu1OdGy2/bymfJBSyE39lJwc65D0Kh9rJtA6VUnorTDXYt2iMJ
 aWlm515hHm6QhlsPgNBgBeqmneaUi6+D0JBJUAN+VIR1ax4erMv/izs/zZjDYV2T1NzP
 ITr3F2PxDaf6dfDWB5dNMFD+DUY+Ib7ObrxhYzRxOt+a4LUR6Rh31pvlDnVNSG6fAVAW
 r9h4vhbHxCeuxF7gJyItDcOGI1YBiHHdun6Dgh7hpzuTAG0FO2kjJNKk18iGUP9aXJk5
 eK1P+Wt0X2Blog2sUnc/gXPfEbQWteTEVB7oTrnUF5SS94m7SOOpsnCa7d//XuohWUk7
 omLw==
X-Gm-Message-State: AOJu0YwyRh75ZnzS+udIEDRitqt0eP90VFEwOgPKvrGIVnTHAtkwRfy/
 0HpOza26LEY8/P3C61XvGWZL97QG6HEYja+ORkoCKdrGKg1zzYbQBqFbFJoyarkSP1KLnqXksxI
 WvA/1QjvHeLhKKe/d7YjpEuhvYBbbVDPYxcpP+FK1MbSFwOqH7mFIaaAlfQ==
X-Received: by 2002:a2e:9345:0:b0:2b6:fa8d:ff91 with SMTP id
 m5-20020a2e9345000000b002b6fa8dff91mr748549ljh.3.1691545371787; 
 Tue, 08 Aug 2023 18:42:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuGPiqXB2iMg3rd8On/takdRRDIG01o5eNOrBgpXP7IJN7g9X9X7bEgLfxq8C4t5goQ02D36hJKdKWsv0guOw=
X-Received: by 2002:a2e:9345:0:b0:2b6:fa8d:ff91 with SMTP id
 m5-20020a2e9345000000b002b6fa8dff91mr748539ljh.3.1691545371412; Tue, 08 Aug
 2023 18:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230802171231.11001-1-dtatulea@nvidia.com>
 <20230802171231.11001-3-dtatulea@nvidia.com>
 <CACGkMEsE45k+fqv-biYfOX5VbqZLo_drQV5rPYByuLJZK03hWQ@mail.gmail.com>
 <b31737724cdcf0cc63fbec56209b7288dc8fcfce.camel@nvidia.com>
 <CACGkMEvoE=1ac1EGxPd14AwCfuOTiZYzYgDQC_qZjSubt891sA@mail.gmail.com>
 <83ca86a42041248f8db717cdc858b7f973cbd85b.camel@nvidia.com>
In-Reply-To: <83ca86a42041248f8db717cdc858b7f973cbd85b.camel@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Aug 2023 09:42:40 +0800
Message-ID: <CACGkMEt95WsDxuc-vGWNhZfZ5G9AGUykV5+kV8oDcGZQ4jD-Lg@mail.gmail.com>
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

T24gVHVlLCBBdWcgOCwgMjAyMyBhdCAzOjI04oCvUE0gRHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVh
QG52aWRpYS5jb20+IHdyb3RlOgo+Cj4gT24gVHVlLCAyMDIzLTA4LTA4IGF0IDEwOjU3ICswODAw
LCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gT24gVGh1LCBBdWcgMywgMjAyMyBhdCA3OjQw4oCvUE0g
RHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVhQG52aWRpYS5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPiBP
biBUaHUsIDIwMjMtMDgtMDMgYXQgMTY6MDMgKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+
ID4gT24gVGh1LCBBdWcgMywgMjAyMyBhdCAxOjEz4oCvQU0gRHJhZ29zIFRhdHVsZWEgPGR0YXR1
bGVhQG52aWRpYS5jb20+IHdyb3RlOgo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoZSBtci0+aW5pdGlh
bGl6ZWQgZmxhZyBpcyBzaGFyZWQgYmV0d2VlbiB0aGUgY29udHJvbCB2cSBhbmQgZGF0YSB2cQo+
ID4gPiA+ID4gcGFydCBvZiB0aGUgbXIgaW5pdC91bmluaXQuIEJ1dCBpZiB0aGUgY29udHJvbCB2
cSBhbmQgZGF0YSB2cSBnZXQgcGxhY2VkCj4gPiA+ID4gPiBpbiBkaWZmZXJlbnQgQVNJRHMsIGl0
IGNhbiBoYXBwZW4gdGhhdCBpbml0aWFsaXppbmcgdGhlIGNvbnRyb2wgdnEgd2lsbAo+ID4gPiA+
ID4gcHJldmVudCB0aGUgZGF0YSB2cSBtciBmcm9tIGJlaW5nIGluaXRpYWxpemVkLgo+ID4gPiA+
ID4KPiA+ID4gPiA+IFRoaXMgcGF0Y2ggY29uc29saWRhdGVzIHRoZSBjb250cm9sIGFuZCBkYXRh
IHZxIGluaXQgcGFydHMgaW50byB0aGVpcgo+ID4gPiA+ID4gb3duIGluaXQgZnVuY3Rpb25zLiBU
aGUgbXItPmluaXRpYWxpemVkIHdpbGwgbm93IGJlIHVzZWQgZm9yIHRoZSBkYXRhIHZxCj4gPiA+
ID4gPiBvbmx5LiBUaGUgY29udHJvbCB2cSBjdXJyZW50bHkgZG9lc24ndCBuZWVkIGEgZmxhZy4K
PiA+ID4gPiA+Cj4gPiA+ID4gPiBUaGUgdW5pbml0aWFsaXppbmcgcGFydCBpcyBhbHNvIHRha2Vu
IGNhcmUgb2Y6IG1seDVfdmRwYV9kZXN0cm95X21yIGdvdAo+ID4gPiA+ID4gc3BsaXQgaW50byBk
YXRhIGFuZCBjb250cm9sIHZxIGZ1bmN0aW9ucyB3aGljaCBhcmUgbm93IGFsc28gQVNJRCBhd2Fy
ZS4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBGaXhlczogOGZjZDIwYzMwNzA0ICgidmRwYS9tbHg1OiBT
dXBwb3J0IGRpZmZlcmVudCBhZGRyZXNzIHNwYWNlcyBmb3IKPiA+ID4gPiA+IGNvbnRyb2wgYW5k
IGRhdGEiKQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogRHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVh
QG52aWRpYS5jb20+Cj4gPiA+ID4gPiBSZXZpZXdlZC1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJl
em1hQHJlZGhhdC5jb20+Cj4gPiA+ID4gPiBSZXZpZXdlZC1ieTogR2FsIFByZXNzbWFuIDxnYWxA
bnZpZGlhLmNvbT4KPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4gIGRyaXZlcnMvdmRwYS9tbHg1L2Nv
cmUvbWx4NV92ZHBhLmggfCAgMSArCj4gPiA+ID4gPiAgZHJpdmVycy92ZHBhL21seDUvY29yZS9t
ci5jICAgICAgICB8IDk3ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQo+ID4gPiA+ID4g
IDIgZmlsZXMgY2hhbmdlZCwgNzEgaW5zZXJ0aW9ucygrKSwgMjcgZGVsZXRpb25zKC0pCj4gPiA+
ID4gPgo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92
ZHBhLmgKPiA+ID4gPiA+IGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaAo+ID4g
PiA+ID4gaW5kZXggMjVmYzQxMjBiNjE4Li5hMDQyMGJlNTA1OWYgMTAwNjQ0Cj4gPiA+ID4gPiAt
LS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oCj4gPiA+ID4gPiArKysgYi9k
cml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oCj4gPiA+ID4gPiBAQCAtMzEsNiArMzEs
NyBAQCBzdHJ1Y3QgbWx4NV92ZHBhX21yIHsKPiA+ID4gPiA+ICAgICAgICAgc3RydWN0IGxpc3Rf
aGVhZCBoZWFkOwo+ID4gPiA+ID4gICAgICAgICB1bnNpZ25lZCBsb25nIG51bV9kaXJlY3RzOwo+
ID4gPiA+ID4gICAgICAgICB1bnNpZ25lZCBsb25nIG51bV9rbG1zOwo+ID4gPiA+ID4gKyAgICAg
ICAvKiBzdGF0ZSBvZiBkdnEgbXIgKi8KPiA+ID4gPiA+ICAgICAgICAgYm9vbCBpbml0aWFsaXpl
ZDsKPiA+ID4gPiA+Cj4gPiA+ID4gPiAgICAgICAgIC8qIHNlcmlhbGl6ZSBta2V5IGNyZWF0aW9u
IGFuZCBkZXN0cnVjdGlvbiAqLwo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9t
bHg1L2NvcmUvbXIuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYwo+ID4gPiA+ID4gaW5k
ZXggMDNlNTQzMjI5NzkxLi40YWUxNGEyNDhhNGIgMTAwNjQ0Cj4gPiA+ID4gPiAtLS0gYS9kcml2
ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMKPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1
L2NvcmUvbXIuYwo+ID4gPiA+ID4gQEAgLTQ4OSw2MCArNDg5LDEwMyBAQCBzdGF0aWMgdm9pZCBk
ZXN0cm95X3VzZXJfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYKPiA+ID4gPiA+ICptdmRldiwgc3Ry
dWN0IG1seDVfdmRwYV9tciAqbXIKPiA+ID4gPiA+ICAgICAgICAgfQo+ID4gPiA+ID4gIH0KPiA+
ID4gPiA+Cj4gPiA+ID4gPiAtdm9pZCBtbHg1X3ZkcGFfZGVzdHJveV9tcihzdHJ1Y3QgbWx4NV92
ZHBhX2RldiAqbXZkZXYpCj4gPiA+ID4gPiArc3RhdGljIHZvaWQgX21seDVfdmRwYV9kZXN0cm95
X2N2cV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsCj4gPiA+ID4gPiB1bnNpZ25lZAo+
ID4gPiA+ID4gaW50IGFzaWQpCj4gPiA+ID4gPiArewo+ID4gPiA+ID4gKyAgICAgICBpZiAobXZk
ZXYtPmdyb3VwMmFzaWRbTUxYNV9WRFBBX0NWUV9HUk9VUF0gIT0gYXNpZCkKPiA+ID4gPiA+ICsg
ICAgICAgICAgICAgICByZXR1cm47Cj4gPiA+ID4gPiArCj4gPiA+ID4gPiArICAgICAgIHBydW5l
X2lvdGxiKG12ZGV2KTsKPiA+ID4gPiA+ICt9Cj4gPiA+ID4gPiArCj4gPiA+ID4gPiArc3RhdGlj
IHZvaWQgX21seDVfdmRwYV9kZXN0cm95X2R2cV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZk
ZXYsCj4gPiA+ID4gPiB1bnNpZ25lZAo+ID4gPiA+ID4gaW50IGFzaWQpCj4gPiA+ID4gPiAgewo+
ID4gPiA+ID4gICAgICAgICBzdHJ1Y3QgbWx4NV92ZHBhX21yICptciA9ICZtdmRldi0+bXI7Cj4g
PiA+ID4gPgo+ID4gPiA+ID4gLSAgICAgICBtdXRleF9sb2NrKCZtci0+bWtleV9tdHgpOwo+ID4g
PiA+ID4gKyAgICAgICBpZiAobXZkZXYtPmdyb3VwMmFzaWRbTUxYNV9WRFBBX0RBVEFWUV9HUk9V
UF0gIT0gYXNpZCkKPiA+ID4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm47Cj4gPiA+ID4gPiAr
Cj4gPiA+ID4gPiAgICAgICAgIGlmICghbXItPmluaXRpYWxpemVkKQo+ID4gPiA+ID4gLSAgICAg
ICAgICAgICAgIGdvdG8gb3V0Owo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybjsKPiA+
ID4gPiA+Cj4gPiA+ID4gPiAtICAgICAgIHBydW5lX2lvdGxiKG12ZGV2KTsKPiA+ID4gPiA+ICAg
ICAgICAgaWYgKG1yLT51c2VyX21yKQo+ID4gPiA+ID4gICAgICAgICAgICAgICAgIGRlc3Ryb3lf
dXNlcl9tcihtdmRldiwgbXIpOwo+ID4gPiA+ID4gICAgICAgICBlbHNlCj4gPiA+ID4gPiAgICAg
ICAgICAgICAgICAgZGVzdHJveV9kbWFfbXIobXZkZXYsIG1yKTsKPiA+ID4gPiA+Cj4gPiA+ID4g
PiAgICAgICAgIG1yLT5pbml0aWFsaXplZCA9IGZhbHNlOwo+ID4gPiA+ID4gLW91dDoKPiA+ID4g
PiA+ICt9Cj4gPiA+ID4gPiArCj4gPiA+ID4gPiArc3RhdGljIHZvaWQgbWx4NV92ZHBhX2Rlc3Ry
b3lfbXJfYXNpZChzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsCj4gPiA+ID4gPiB1bnNpZ25l
ZAo+ID4gPiA+ID4gaW50IGFzaWQpCj4gPiA+ID4gPiArewo+ID4gPiA+ID4gKyAgICAgICBzdHJ1
Y3QgbWx4NV92ZHBhX21yICptciA9ICZtdmRldi0+bXI7Cj4gPiA+ID4gPiArCj4gPiA+ID4gPiAr
ICAgICAgIG11dGV4X2xvY2soJm1yLT5ta2V5X210eCk7Cj4gPiA+ID4gPiArCj4gPiA+ID4gPiAr
ICAgICAgIF9tbHg1X3ZkcGFfZGVzdHJveV9kdnFfbXIobXZkZXYsIGFzaWQpOwo+ID4gPiA+ID4g
KyAgICAgICBfbWx4NV92ZHBhX2Rlc3Ryb3lfY3ZxX21yKG12ZGV2LCBhc2lkKTsKPiA+ID4gPiA+
ICsKPiA+ID4gPiA+ICAgICAgICAgbXV0ZXhfdW5sb2NrKCZtci0+bWtleV9tdHgpOwo+ID4gPiA+
ID4gIH0KPiA+ID4gPiA+Cj4gPiA+ID4gPiAtc3RhdGljIGludCBfbWx4NV92ZHBhX2NyZWF0ZV9t
cihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsCj4gPiA+ID4gPiAtICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIsIHVuc2lnbmVkIGludAo+
ID4gPiA+ID4gYXNpZCkKPiA+ID4gPiA+ICt2b2lkIG1seDVfdmRwYV9kZXN0cm95X21yKHN0cnVj
dCBtbHg1X3ZkcGFfZGV2ICptdmRldikKPiA+ID4gPiA+ICt7Cj4gPiA+ID4gPiArICAgICAgIG1s
eDVfdmRwYV9kZXN0cm95X21yX2FzaWQobXZkZXYsIG12ZGV2LQo+ID4gPiA+ID4gPiBncm91cDJh
c2lkW01MWDVfVkRQQV9DVlFfR1JPVVBdKTsKPiA+ID4gPiA+ICsgICAgICAgbWx4NV92ZHBhX2Rl
c3Ryb3lfbXJfYXNpZChtdmRldiwgbXZkZXYtCj4gPiA+ID4gPiA+IGdyb3VwMmFzaWRbTUxYNV9W
RFBBX0RBVEFWUV9HUk9VUF0pOwo+ID4gPiA+ID4gK30KPiA+ID4gPiA+ICsKPiA+ID4gPiA+ICtz
dGF0aWMgaW50IF9tbHg1X3ZkcGFfY3JlYXRlX2N2cV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAq
bXZkZXYsCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1
Y3Qgdmhvc3RfaW90bGIgKmlvdGxiLAo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdW5zaWduZWQgaW50IGFzaWQpCj4gPiA+ID4gPiArewo+ID4gPiA+ID4gKyAg
ICAgICBpZiAobXZkZXYtPmdyb3VwMmFzaWRbTUxYNV9WRFBBX0NWUV9HUk9VUF0gIT0gYXNpZCkK
PiA+ID4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsKPiA+ID4gPiA+ICsKPiA+ID4gPiA+
ICsgICAgICAgcmV0dXJuIGR1cF9pb3RsYihtdmRldiwgaW90bGIpOwo+ID4gPiA+Cj4gPiA+ID4g
VGhpcyB3b3JyaWVzIG1lIGFzIGNvbmNlcHR1YWxseSwgdGhlcmUgc2hvdWxkIGJlIG5vIGRpZmZl
cmVuY2UgYmV0d2Vlbgo+ID4gPiA+IGR2cSBtciBhbmQgY3ZxIG1yLiBUaGUgdmlydHF1ZXVlIHNo
b3VsZCBiZSBsb29zZWx5IGNvdXBsZWQgd2l0aCBtci4KPiA+ID4gPgo+ID4gPiBBcmUgeW91IHdv
cnJpZWQgYnkgdGhlIGNoYW5nZXMgaW4gdGhpcyBwYXRjaCBvciBhYm91dCB0aGUgcG9zc2liaWxp
dHkgb2YKPiA+ID4gaGF2aW5nCj4gPiA+Cj4gPiA+IFRoZSByZWFzb24gZm9yIHRoaXMgY2hhbmdl
IGlzIHRoYXQgSSBub3RpY2VkIGlmIHlvdSBjcmVhdGUgb25lIG1yIGluIG9uZQo+ID4gPiBhc2lk
Cj4gPiA+IHlvdSBjb3VsZCBiZSBibG9ja2VkIG91dCBmcm9tIGNyZWF0aW5nIGFub3RoZXIgb25l
IGluIGEgZGlmZmVyZW50IGFzaWQgZHVlCj4gPiA+IHRvCj4gPiA+IG1yLT5pbml0aWFsaXplZCBi
ZWluZyB0cnVlLiBUbyBtZSB0aGF0IHNlZW1lZCBwcm9ibGVtYXRpYy4gSXMgaXQgbm90Pwo+ID4K
PiA+IE15IGZlZWxpbmcgaXMgdGhhdCBtci5jIHNob3VsZCBiZSBkZXZpY2UgYWdub3N0aWMuIEl0
IG5lZWRzIHRvIGtub3cKPiA+IG5vdGhpbmcgYWJvdXQgdGhlIGRldmljZSBkZXRhaWxzIHRvIHdv
cmsuIEJ1dCB0aGlzIHBhdGNoIHNlZW1zIHRvCj4gPiBicmVhayB0aGUgbGF5ZXIuCj4gPgo+IEJ1
dCB0aGUgc2FtZSBsb2dpYyB3YXMgdGhlcmUgYmVmb3JlICh3aXRoIHRoZSBleGNlcHRpb24gb2Yg
Y3ZxIG5vdCBoYXZpbmcgYW4KPiBpbml0IGZsYWcgYW55bW9yZSkuIFNvIHdoYXQgYW0gSSBtaXNz
aW5nIGhlcmU/CgpOb3RoaW5nLCBJIHRoaW5rIHlvdSdyZSByaWdodC4KCkkgdGhpbmsgd2UgY2Fu
IGhhdmUgdGhpcyBwYXRjaCBnbyBmaXJzdCBhbmQgdHdlYWsgb24gdG9wIGJ5IG1vdmluZyBDVlEK
YXdhcmUgbG9naWMgaW50byB0aGUgbmV0IHNwZWNpZmljIGNvZGVzLgoKVGhhbmtzCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
