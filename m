Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B858C001B0
	for <virtualization@archiver.kernel.org>; Tue,  8 Aug 2023 05:43:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 01B2F40489;
	Tue,  8 Aug 2023 05:43:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 01B2F40489
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RS34BxKb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VG8Cfu_USP_2; Tue,  8 Aug 2023 05:43:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4AA9340102;
	Tue,  8 Aug 2023 05:43:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4AA9340102
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02083C0071;
	Tue,  8 Aug 2023 05:43:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2785CC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 05:43:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E0149402D7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 05:43:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E0149402D7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BIqUmCm65NMJ
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 05:43:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8E56440102
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 05:43:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8E56440102
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691473397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BESHa93GYbY84ybTy6DiDjuyKqGgnqcUoefmzBrlBBs=;
 b=RS34BxKbIqJp48ml/iLaELYF43g5iByU/pkrZMOz575tb4OfwR4yv9sRUCS5CzFG3aTPGh
 zf6L/x2/7YXOX5zyiuFVW+k9AEw14cVMrFfkVzoWzBFYTDMezEV9wcfjp0S/LJbjvrC9B0
 alrC1CItWUhgCwom+PV9mkZuqsrbrGE=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-ead5mvt-PeaYwSQYyptQdQ-1; Tue, 08 Aug 2023 01:43:15 -0400
X-MC-Unique: ead5mvt-PeaYwSQYyptQdQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b8405aace3so23040771fa.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Aug 2023 22:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691473394; x=1692078194;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BESHa93GYbY84ybTy6DiDjuyKqGgnqcUoefmzBrlBBs=;
 b=bd7leo1kUXslAtdXfLzI1kFsG5Xi85TQ5kUGts2fJ7xv1QTgOOeBU3wpQ745jRXoNV
 kkrjjktNHDlyNthx6Tz6SZiHbDaNmC7D7ojlMBD5IX4w6yqLzgeZAAhtmk9SX1kIJdFE
 L4kvEcjYECdY2P1DmTRGNJhF364S16OWtTs5rYF9IeuTLAqxztupQp2Lw1hBCn7ztUXC
 +jvKO/6azQYxJy1DrfOOi9IGDurq/rejhdOPc5vCztRCQESGyUFUhi3YDkAqsV8Ya/RH
 YAKvZJOJUvAAe8XgPhpZQ0EGFHPxDP7C3PEJLFTYRMR6INNIef+3al01RQi0dHw2olB4
 A2fg==
X-Gm-Message-State: AOJu0Yx2YZhi4emwBn0vENhq6Io4d3EPcbbo/3lMEP3gi6kT5/+CTq33
 NFqg+yjJt8i+puhlXwGTlmtjzbNEy814gLJzwA5VdtG8P+jX1tSBY6x+13mpTIKJ4BwZsZU73Am
 6Nv0cSK95svCteyFLU/OCE7L2oQ2Pb7xZRQ1YbSku+fcMrZ8aB5p5yiO8hQ==
X-Received: by 2002:a2e:b0c6:0:b0:2b9:ea6b:64b with SMTP id
 g6-20020a2eb0c6000000b002b9ea6b064bmr7653468ljl.37.1691473394478; 
 Mon, 07 Aug 2023 22:43:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC3CMhrHkub5YyRmarmFcgNYvSaMyar7Cls/hDMGwrfWldVQTbBjZJZpfo0Bq4s7X6uNnT1QxvJlAHvmqZytw=
X-Received: by 2002:a2e:b0c6:0:b0:2b9:ea6b:64b with SMTP id
 g6-20020a2eb0c6000000b002b9ea6b064bmr7653462ljl.37.1691473394165; Mon, 07 Aug
 2023 22:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230808051110.3492693-1-yuanyaogoog@chromium.org>
In-Reply-To: <20230808051110.3492693-1-yuanyaogoog@chromium.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Aug 2023 13:43:02 +0800
Message-ID: <CACGkMEt53ziY_bmgJHVdJ6pkppTyVqKX3=Czygv+yhJR8_KiFA@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: fix avail_wrap_counter in
 virtqueue_add_packed
To: Yuan Yao <yuanyaogoog@chromium.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Tiwei Bie <tiwei.bie@intel.com>, Junichi Uekawa <uekawa@chromium.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Takaya Saeki <takayas@chromium.org>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
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

T24gVHVlLCBBdWcgOCwgMjAyMyBhdCAxOjEx4oCvUE0gWXVhbiBZYW8gPHl1YW55YW9nb29nQGNo
cm9taXVtLm9yZz4gd3JvdGU6Cj4KPiBJbiBjdXJyZW50IHBhY2tlZCB2aXJ0cXVldWUgaW1wbGVt
ZW50YXRpb24sIHRoZSBhdmFpbF93cmFwX2NvdW50ZXIgd29uJ3QKPiBmbGlwLCBpbiB0aGUgY2Fz
ZSB3aGVuIHRoZSBkcml2ZXIgc3VwcGxpZXMgYSBkZXNjcmlwdG9yIGNoYWluIHdpdGggYQo+IGxl
bmd0aCBlcXVhbHMgdG8gdGhlIHF1ZXVlIHNpemU7IHRvdGFsX3NnID09IHZxLT5wYWNrZWQudnJp
bmcubnVtLgo+Cj4gTGV04oCZcyBhc3N1bWUgdGhlIGZvbGxvd2luZyBzaXR1YXRpb246Cj4gdnEt
PnBhY2tlZC52cmluZy5udW09NAo+IHZxLT5wYWNrZWQubmV4dF9hdmFpbF9pZHg6IDEKPiB2cS0+
cGFja2VkLmF2YWlsX3dyYXBfY291bnRlcjogMAo+Cj4gVGhlbiB0aGUgZHJpdmVyIGFkZHMgYSBk
ZXNjcmlwdG9yIGNoYWluIGNvbnRhaW5pbmcgNCBkZXNjcmlwdG9ycy4KPgo+IFdlIGV4cGVjdCB0
aGUgZm9sbG93aW5nIHJlc3VsdCB3aXRoIGF2YWlsX3dyYXBfY291bnRlciBmbGlwcGVkOgo+IHZx
LT5wYWNrZWQubmV4dF9hdmFpbF9pZHg6IDEKPiB2cS0+cGFja2VkLmF2YWlsX3dyYXBfY291bnRl
cjogMQo+Cj4gQnV0LCB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiBnaXZlcyB0aGUgZm9sbG93
aW5nIHJlc3VsdDoKPiB2cS0+cGFja2VkLm5leHRfYXZhaWxfaWR4OiAxCj4gdnEtPnBhY2tlZC5h
dmFpbF93cmFwX2NvdW50ZXI6IDAKPgo+IFRvIHJlcHJvZHVjZSB0aGUgYnVnLCB5b3UgY2FuIHNl
dCBhIHBhY2tlZCBxdWV1ZSBzaXplIGFzIHNtYWxsIGFzCj4gcG9zc2libGUsIHNvIHRoYXQgdGhl
IGRyaXZlciBpcyBtb3JlIGxpa2VseSB0byBwcm92aWRlIGEgZGVzY3JpcHRvcgo+IGNoYWluIHdp
dGggYSBsZW5ndGggZXF1YWwgdG8gdGhlIHBhY2tlZCBxdWV1ZSBzaXplLiBGb3IgZXhhbXBsZSwg
aW4KPiBxZW11IHJ1biBmb2xsb3dpbmcgY29tbWFuZHM6Cj4gc3VkbyBxZW11LXN5c3RlbS14ODZf
NjQgXAo+IC1lbmFibGUta3ZtIFwKPiAtbm9ncmFwaGljIFwKPiAta2VybmVsICJwYXRoL3RvL2tl
cm5lbF9pbWFnZSIgXAo+IC1tIDFHIFwKPiAtZHJpdmUgZmlsZT0icGF0aC90by9yb290ZnMiLGlm
PW5vbmUsaWQ9ZGlzayBcCj4gLWRldmljZSB2aXJ0aW8tYmxrLGRyaXZlPWRpc2sgXAo+IC1kcml2
ZSBmaWxlPSJwYXRoL3RvL2Rpc2tfaW1hZ2UiLGlmPW5vbmUsaWQ9cndkaXNrIFwKPiAtZGV2aWNl
IHZpcnRpby1ibGssZHJpdmU9cndkaXNrLHBhY2tlZD1vbixxdWV1ZS1zaXplPTQsXAo+IGluZGly
ZWN0X2Rlc2M9b2ZmIFwKPiAtYXBwZW5kICJjb25zb2xlPXR0eVMwIHJvb3Q9L2Rldi92ZGEgcncg
aW5pdD0vYmluL2Jhc2giCj4KPiBJbnNpZGUgdGhlIFZNLCBjcmVhdGUgYSBkaXJlY3RvcnkgYW5k
IG1vdW50IHRoZSByd2Rpc2sgZGV2aWNlIG9uIGl0LiBUaGUKPiByd2Rpc2sgd2lsbCBoYW5nIGFu
ZCBtb3VudCBvcGVyYXRpb24gd2lsbCBub3QgY29tcGxldGUuCj4KPiBUaGlzIGNvbW1pdCBmaXhl
cyB0aGUgd3JhcCBjb3VudGVyIGVycm9yIGJ5IGZsaXBwaW5nIHRoZQo+IHBhY2tlZC5hdmFpbF93
cmFwX2NvdW50ZXIsIHdoZW4gc3RhcnQgb2YgZGVzY3JpcHRvciBjaGFpbiBlcXVhbHMgdG8gdGhl
Cj4gZW5kIG9mIGRlc2NyaXB0b3IgY2hhaW4gKGhlYWQgPT0gaSkuCj4KPiBGaXhlczogMWNlOWU2
MDU1ZmEwICgidmlydGlvX3Jpbmc6IGludHJvZHVjZSBwYWNrZWQgcmluZyBzdXBwb3J0IikKPiBT
aWduZWQtb2ZmLWJ5OiBZdWFuIFlhbyA8eXVhbnlhb2dvb2dAY2hyb21pdW0ub3JnPgo+IC0tLQo+
Cj4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gaW5k
ZXggYzUzMTBlYWY4YjQ2Li5kYTExNTBkMTI3YzIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0
aW8vdmlydGlvX3JpbmcuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBA
QCAtMTQ2MSw3ICsxNDYxLDcgQEAgc3RhdGljIGlubGluZSBpbnQgdmlydHF1ZXVlX2FkZF9wYWNr
ZWQoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxLAo+ICAgICAgICAgICAgICAgICB9Cj4gICAgICAgICB9
Cj4KPiAtICAgICAgIGlmIChpIDwgaGVhZCkKPiArICAgICAgIGlmIChpIDw9IGhlYWQpCj4gICAg
ICAgICAgICAgICAgIHZxLT5wYWNrZWQuYXZhaWxfd3JhcF9jb3VudGVyIF49IDE7CgpXb3VsZCBp
dCBiZSBiZXR0ZXIgdG8gbW92ZSB0aGUgZmxpcHBpbmcgdG8gdGhlIHBsYWNlIHdoZXJlIHdlIGZs
aXAKYXZhaWxfdXNlZF9mbGFncz8KCiAgICAgICAgICAgICAgICAgICAgICAgIGlmICgodW5saWtl
bHkoKytpID49IHZxLT5wYWNrZWQudnJpbmcubnVtKSkpIHsKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBpID0gMDsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2cS0+cGFj
a2VkLmF2YWlsX3VzZWRfZmxhZ3MgXj0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDEgPDwgVlJJTkdfUEFDS0VEX0RFU0NfRl9BVkFJTCB8CiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAxIDw8IFZSSU5HX1BBQ0tFRF9ERVNDX0ZfVVNFRDsKICAg
ICAgICAgICAgICAgICAgICAgICAgfQoKVGhhbmtzCgo+Cj4gICAgICAgICAvKiBXZSdyZSB1c2lu
ZyBzb21lIGJ1ZmZlcnMgZnJvbSB0aGUgZnJlZSBsaXN0LiAqLwo+IC0tCj4gMi40MS4wLjY0MC5n
YTk1ZGVmNTVkMC1nb29nCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
