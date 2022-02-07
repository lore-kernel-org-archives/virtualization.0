Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1534C4332F
	for <virtualization@archiver.kernel.org>; Mon,  7 Feb 2022 06:07:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8827740207;
	Mon,  7 Feb 2022 06:07:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BVQGXxsQqCVM; Mon,  7 Feb 2022 06:07:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E0940400D8;
	Mon,  7 Feb 2022 06:07:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B365AC001A;
	Mon,  7 Feb 2022 06:07:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92B0DC000B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 06:07:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6BC24400E5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 06:07:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vwu2Bhc2kkfW
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 06:07:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0FE52400D8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 06:06:59 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V3mOPbY_1644214014; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V3mOPbY_1644214014) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 07 Feb 2022 14:06:54 +0800
Message-Id: <1644213876.065673-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v3 01/17] virtio_pci: struct virtio_pci_common_cfg add
 queue_notify_data
Date: Mon, 07 Feb 2022 14:04:36 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
In-Reply-To: <28013a95-4ce4-7859-9ca1-d836265e8792@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gTW9uLCA3IEZlYiAyMDIyIDExOjQxOjA2ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IOWcqCAyMDIyLzEvMjYg5LiL5Y2IMzozNSwgWHVhbiBaaHVv
IOWGmemBkzoKPiA+IEFkZCBxdWV1ZV9ub3RpZnlfZGF0YSBpbiBzdHJ1Y3QgdmlydGlvX3BjaV9j
b21tb25fY2ZnLCB3aGljaCBjb21lcyBmcm9tCj4gPiBoZXJlIGh0dHBzOi8vZ2l0aHViLmNvbS9v
YXNpcy10Y3MvdmlydGlvLXNwZWMvaXNzdWVzLzg5Cj4gPgo+ID4gU2luY2UgSSB3YW50IHRvIGFk
ZCBxdWV1ZV9yZXNldCBhZnRlciBpdCwgSSBzdWJtaXR0ZWQgdGhpcyBwYXRjaCBmaXJzdC4KPiA+
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29t
Pgo+ID4gLS0tCj4gPiAgIGluY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcGNpLmggfCAxICsKPiA+
ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcGNpLmggYi9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlv
X3BjaS5oCj4gPiBpbmRleCAzYTg2ZjM2ZDdlM2QuLjQ5MmM4OWY1NmM2YSAxMDA2NDQKPiA+IC0t
LSBhL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcGNpLmgKPiA+ICsrKyBiL2luY2x1ZGUvdWFw
aS9saW51eC92aXJ0aW9fcGNpLmgKPiA+IEBAIC0xNjQsNiArMTY0LDcgQEAgc3RydWN0IHZpcnRp
b19wY2lfY29tbW9uX2NmZyB7Cj4gPiAgIAlfX2xlMzIgcXVldWVfYXZhaWxfaGk7CQkvKiByZWFk
LXdyaXRlICovCj4gPiAgIAlfX2xlMzIgcXVldWVfdXNlZF9sbzsJCS8qIHJlYWQtd3JpdGUgKi8K
PiA+ICAgCV9fbGUzMiBxdWV1ZV91c2VkX2hpOwkJLyogcmVhZC13cml0ZSAqLwo+ID4gKwlfX2xl
MTYgcXVldWVfbm90aWZ5X2RhdGE7CS8qIHJlYWQtd3JpdGUgKi8KPiA+ICAgfTsKPgo+Cj4gU28g
SSBoYWQgdGhlIHNhbWUgY29uY2VybiBhcyBwcmV2aW91cyB2ZXJzaW9uLgo+Cj4gVGhpcyBicmVh
a3MgdUFCSSB3aGVyZSBwcm9ncmFtIG1heSB0cnkgdG8gdXNlIHNpemVvZihzdHJ1Y3QKPiB2aXJ0
aW9fcGNpX2NvbW1vbl9jZmcpLgo+Cj4gV2UgcHJvYmFibHkgbmVlZCBhIGNvbnRhaW5lciBzdHJ1
Y3R1cmUgaGVyZS4KCkkgc2VlLCBJIHBsYW4gdG8gYWRkIGEgc3RydWN0IGxpa2UgdGhpcywgZG8g
eW91IHRoaW5rIGl0J3MgYXBwcm9wcmlhdGU/CgpzdHJ1Y3QgdmlydGlvX3BjaV9jb21tb25fY2Zn
X3YxIHsKCXN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcgY2ZnOwoJX19sZTE2IHF1ZXVlX25v
dGlmeV9kYXRhOwkvKiByZWFkLXdyaXRlICovCn0KClRoYW5rcy4KCj4KPiBUSGFua3MKPgo+Cj4g
Pgo+ID4gICAvKiBGaWVsZHMgaW4gVklSVElPX1BDSV9DQVBfUENJX0NGRzogKi8KPgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
