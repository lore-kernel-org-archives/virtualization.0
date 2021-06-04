Return-Path: <SRS0=Cwtm=K6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23AEC47097
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 02:43:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 725E56140A
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 02:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 725E56140A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C775406AA;
	Fri,  4 Jun 2021 02:43:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jXZ9hd-3HBqF; Fri,  4 Jun 2021 02:43:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8962B406A8;
	Fri,  4 Jun 2021 02:43:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A991C000D;
	Fri,  4 Jun 2021 02:43:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A62A5C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:43:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7EE0D406A9
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:43:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e2XODnHfWDYr
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:43:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CA12B406A8
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:43:33 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R421e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0UbD5T88_1622774609; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0UbD5T88_1622774609) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 04 Jun 2021 10:43:30 +0800
MIME-Version: 1.0
Message-Id: <1622773823.5042562-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net] virtio-net: fix for skb_over_panic inside big mode
Date: Fri, 04 Jun 2021 10:30:23 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
In-Reply-To: <231466df-adc1-79a9-6950-77c88e2783c2@redhat.com>
X-Mailing-List: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 =?utf-8?q?Corentin_No=C3=ABl?= <corentin.noel@collabora.com>,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

T24gRnJpLCA0IEp1biAyMDIxIDEwOjI4OjQxICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IOWcqCAyMDIxLzYvNCDkuIrljYgxOjA5LCBYdWFuIFpodW8g
5YaZ6YGTOgo+ID4gSW4gdmlydGlvLW5ldCdzIGxhcmdlIHBhY2tldCBtb2RlLCB0aGVyZSBpcyBh
IGhvbGUgaW4gdGhlIHNwYWNlIGJlaGluZAo+ID4gYnVmLgo+Cj4KPiBiZWZvcmUgdGhlIGJ1ZiBh
Y3R1YWxseSBvciBiZWhpbmQgdGhlIHZuZXQgaGVhZGVyPwo+Cj4KPiA+Cj4gPiAgICAgIGhkcl9w
YWRkZWRfbGVuIC0gaGRyX2xlbgo+ID4KPiA+IFdlIG11c3QgdGFrZSB0aGlzIGludG8gYWNjb3Vu
dCB3aGVuIGNhbGN1bGF0aW5nIHRhaWxyb29tLgo+ID4KPiA+IFsgICA0NC41NDQzODVdIHNrYl9w
dXQuY29sZCAobmV0L2NvcmUvc2tidWZmLmM6NTI1NCAoZGlzY3JpbWluYXRvciAxKSBuZXQvY29y
ZS9za2J1ZmYuYzo1MjUyIChkaXNjcmltaW5hdG9yIDEpKQo+ID4gWyAgIDQ0LjU0NDg2NF0gcGFn
ZV90b19za2IgKGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYzo0ODUpIFsgICA0NC41NDUzNjFdIHJl
Y2VpdmVfYnVmIChkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmM6ODQ5IGRyaXZlcnMvbmV0L3ZpcnRp
b19uZXQuYzoxMTMxKQo+ID4gWyAgIDQ0LjU0NTg3MF0gPyBuZXRpZl9yZWNlaXZlX3NrYl9saXN0
X2ludGVybmFsIChuZXQvY29yZS9kZXYuYzo1NzE0KQo+ID4gWyAgIDQ0LjU0NjYyOF0gPyBkZXZf
Z3JvX3JlY2VpdmUgKG5ldC9jb3JlL2Rldi5jOjYxMDMpCj4gPiBbICAgNDQuNTQ3MTM1XSA/IG5h
cGlfY29tcGxldGVfZG9uZSAoLi9pbmNsdWRlL2xpbnV4L2xpc3QuaDozNSBuZXQvY29yZS9kZXYu
Yzo1ODY3IG5ldC9jb3JlL2Rldi5jOjU4NjIgbmV0L2NvcmUvZGV2LmM6NjU2NSkKPiA+IFsgICA0
NC41NDc2NzJdIHZpcnRuZXRfcG9sbCAoZHJpdmVycy9uZXQvdmlydGlvX25ldC5jOjE0MjcgZHJp
dmVycy9uZXQvdmlydGlvX25ldC5jOjE1MjUpCj4gPiBbICAgNDQuNTQ4MjUxXSBfX25hcGlfcG9s
bCAobmV0L2NvcmUvZGV2LmM6Njk4NSkKPiA+IFsgICA0NC41NDg3NDRdIG5ldF9yeF9hY3Rpb24g
KG5ldC9jb3JlL2Rldi5jOjcwNTQgbmV0L2NvcmUvZGV2LmM6NzEzOSkKPiA+IFsgICA0NC41NDky
NjRdIF9fZG9fc29mdGlycSAoLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9qdW1wX2xhYmVsLmg6MTkg
Li9pbmNsdWRlL2xpbnV4L2p1bXBfbGFiZWwuaDoyMDAgLi9pbmNsdWRlL3RyYWNlL2V2ZW50cy9p
cnEuaDoxNDIga2VybmVsL3NvZnRpcnEuYzo1NjApCj4gPiBbICAgNDQuNTQ5NzYyXSBpcnFfZXhp
dF9yY3UgKGtlcm5lbC9zb2Z0aXJxLmM6NDMzIGtlcm5lbC9zb2Z0aXJxLmM6NjM3IGtlcm5lbC9z
b2Z0aXJxLmM6NjQ5KQo+ID4gWyAgIDQ0LjU1MTM4NF0gY29tbW9uX2ludGVycnVwdCAoYXJjaC94
ODYva2VybmVsL2lycS5jOjI0MCAoZGlzY3JpbWluYXRvciAxMykpCj4gPiBbICAgNDQuNTUxOTkx
XSA/IGFzbV9jb21tb25faW50ZXJydXB0ICguL2FyY2gveDg2L2luY2x1ZGUvYXNtL2lkdGVudHJ5
Lmg6NjM4KQo+ID4gWyAgIDQ0LjU1MjY1NF0gYXNtX2NvbW1vbl9pbnRlcnJ1cHQgKC4vYXJjaC94
ODYvaW5jbHVkZS9hc20vaWR0ZW50cnkuaDo2MzgpCj4gPgo+ID4gRml4ZXM6IGZiMzI4NTZiMTZh
ZCAoInZpcnRpby1uZXQ6IHBhZ2VfdG9fc2tiKCkgdXNlIGJ1aWxkX3NrYiB3aGVuIHRoZXJlJ3Mg
c3VmZmljaWVudCB0YWlscm9vbSIpCj4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56
aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+ID4gUmVwb3J0ZWQtYnk6IENvcmVudGluIE5vw6tsIDxj
b3JlbnRpbi5ub2VsQGNvbGxhYm9yYS5jb20+Cj4gPiBUZXN0ZWQtYnk6IENvcmVudGluIE5vw6ts
IDxjb3JlbnRpbi5ub2VsQGNvbGxhYm9yYS5jb20+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy9uZXQv
dmlydGlvX25ldC5jIHwgMiArLQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25l
dC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiBpbmRleCBmYTQwN2ViOGI0NTcuLjc4
YTAxYzcxYTE3YyAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4g
KysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiBAQCAtNDA2LDcgKzQwNiw3IEBAIHN0
YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqcGFnZV90b19za2Ioc3RydWN0IHZpcnRuZXRfaW5mbyAqdmks
Cj4gPiAgIAkgKiBhZGRfcmVjdmJ1Zl9tZXJnZWFibGUoKSArIGdldF9tZXJnZWFibGVfYnVmX2xl
bigpCj4gPiAgIAkgKi8KPiA+ICAgCXRydWVzaXplID0gaGVhZHJvb20gPyBQQUdFX1NJWkUgOiB0
cnVlc2l6ZTsKPiA+IC0JdGFpbHJvb20gPSB0cnVlc2l6ZSAtIGxlbiAtIGhlYWRyb29tOwo+ID4g
Kwl0YWlscm9vbSA9IHRydWVzaXplIC0gbGVuIC0gaGVhZHJvb20gLSAoaGRyX3BhZGRlZF9sZW4g
LSBoZHJfbGVuKTsKPgo+Cj4gVGhlIHBhdGNoIGxvb2tzIGNvcnJlY3QgYW5kIEkgc2F3IGl0IGhh
cyBiZWVuIG1lcmdlZC4KPgo+IEJ1dCBJIHByZWZlciB0byBkbyB0aGF0IGluIHJlY2VpdmVfYmln
KCkgaW5zdGVhZCBvZiBoZXJlLgo+Cj4gVGhhbmtzCgpIb3c/CgpjaGFuZ2UgdHJ1ZXNpemUgb3Ig
aGVhZHJvb20/CgpJIGRpZG4ndCBmaW5kIGEgZ29vZCB3YXkuIERvIHlvdSBoYXZlIGEgZ29vZCB3
YXk/CgpUaGFua3MuCgo+Cj4KPgo+ID4gICAJYnVmID0gcCAtIGhlYWRyb29tOwo+ID4KPiA+ICAg
CWxlbiAtPSBoZHJfbGVuOwo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
