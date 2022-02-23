Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4379C433EF
	for <virtualization@archiver.kernel.org>; Wed, 23 Feb 2022 08:33:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4477A408D5;
	Wed, 23 Feb 2022 08:33:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w0gZGcneqIlO; Wed, 23 Feb 2022 08:33:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9935A40180;
	Wed, 23 Feb 2022 08:33:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66B51C001A;
	Wed, 23 Feb 2022 08:33:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69E4EC0011
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 08:33:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 58B4260F36
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 08:33:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id saXWmsdYPWDP
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 08:33:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3F45360B53
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 08:33:47 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V5HWCH._1645605224; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V5HWCH._1645605224) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 23 Feb 2022 16:33:44 +0800
Message-ID: <1645605017.395006-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v1 3/6] virtio: remove flags check for unmap packed
 indirect desc
Date: Wed, 23 Feb 2022 16:30:17 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220210085124.15466-1-xuanzhuo@linux.alibaba.com>
 <20220210085124.15466-4-xuanzhuo@linux.alibaba.com>
 <a0885532-11a6-615f-bb17-2290686c4f03@redhat.com>
In-Reply-To: <a0885532-11a6-615f-bb17-2290686c4f03@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

T24gV2VkLCAyMyBGZWIgMjAyMiAxMDo1MzoyNiArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMi8yLzEwIOS4i+WNiDQ6NTEsIFh1YW4gWmh1
byDlhpnpgZM6Cj4gPiBXaGVuIGNhbGxpbmcgdnJpbmdfdW5tYXBfZGVzY19wYWNrZWQoKSwgaXQg
d2lsbCBub3QgZW5jb3VudGVyIHRoZQo+ID4gc2l0dWF0aW9uIHRoYXQgdGhlIGZsYWdzIGNvbnRh
aW5zIFZSSU5HX0RFU0NfRl9JTkRJUkVDVC4gU28gcmVtb3ZlIHRoaXMKPiA+IGxvZ2ljLgo+Cj4K
PiBUaGlzIHNlZW1zIG5vdCBjb3JyZWN0Lgo+Cj4gVGhlcmUncyBhIGNhbGwgZnJvbSBkZXRhY2hf
YnVmX3BhY2tlZCgpIHRoYXQgY2FuIHdvcmsgZm9yIGluZGlyZWN0Cj4gZGVzY3JpcHRvcnM/Cj4K
ClllcywgaXQgd29ya3Mgd2l0aCBpbmRpcmVjdCBkZXNjcmlwdG9ycy4gQnV0IHRoZXNlIGRlc2Ny
aXB0b3JzIGRvIG5vdCBjb250YWluClZSSU5HX0RFU0NfRl9JTkRJUkVDVC4KClRoZSBvbmUgdGhh
dCBjb250YWlucyBWUklOR19ERVNDX0ZfSU5ESVJFQ1QgaXMgdnEtPnBhY2tlZC5kZXNjX2V4dHJh
W2lkXS5mbGFncy4KVGhpcyBpcyBoYW5kbGVkIGJ5IHZyaW5nX3VubWFwX3N0YXRlX3BhY2tlZCgp
LgoKVGhhbmtzLgoKPiBUaGFua3MKPgo+Cj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVv
IDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiA+IC0tLQo+ID4gICBkcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jIHwgMTggKysrKystLS0tLS0tLS0tLS0tCj4gPiAgIDEgZmlsZSBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jp
bmcuYwo+ID4gaW5kZXggZmFkZDBhNzUwM2U5Li5jZmIwMjhjYTIzOGUgMTAwNjQ0Cj4gPiAtLS0g
YS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiArKysgYi9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcmluZy5jCj4gPiBAQCAtMTAwOSwxOSArMTAwOSwxMSBAQCBzdGF0aWMgdm9pZCB2cmlu
Z191bm1hcF9kZXNjX3BhY2tlZChjb25zdCBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwKPiA+
Cj4gPiAgIAlmbGFncyA9IGxlMTZfdG9fY3B1KGRlc2MtPmZsYWdzKTsKPiA+Cj4gPiAtCWlmIChm
bGFncyAmIFZSSU5HX0RFU0NfRl9JTkRJUkVDVCkgewo+ID4gLQkJZG1hX3VubWFwX3NpbmdsZSh2
cmluZ19kbWFfZGV2KHZxKSwKPiA+IC0JCQkJIGxlNjRfdG9fY3B1KGRlc2MtPmFkZHIpLAo+ID4g
LQkJCQkgbGUzMl90b19jcHUoZGVzYy0+bGVuKSwKPiA+IC0JCQkJIChmbGFncyAmIFZSSU5HX0RF
U0NfRl9XUklURSkgPwo+ID4gLQkJCQkgRE1BX0ZST01fREVWSUNFIDogRE1BX1RPX0RFVklDRSk7
Cj4gPiAtCX0gZWxzZSB7Cj4gPiAtCQlkbWFfdW5tYXBfcGFnZSh2cmluZ19kbWFfZGV2KHZxKSwK
PiA+IC0JCQkgICAgICAgbGU2NF90b19jcHUoZGVzYy0+YWRkciksCj4gPiAtCQkJICAgICAgIGxl
MzJfdG9fY3B1KGRlc2MtPmxlbiksCj4gPiAtCQkJICAgICAgIChmbGFncyAmIFZSSU5HX0RFU0Nf
Rl9XUklURSkgPwo+ID4gLQkJCSAgICAgICBETUFfRlJPTV9ERVZJQ0UgOiBETUFfVE9fREVWSUNF
KTsKPiA+IC0JfQo+ID4gKwlkbWFfdW5tYXBfcGFnZSh2cmluZ19kbWFfZGV2KHZxKSwKPiA+ICsJ
CSAgICAgICBsZTY0X3RvX2NwdShkZXNjLT5hZGRyKSwKPiA+ICsJCSAgICAgICBsZTMyX3RvX2Nw
dShkZXNjLT5sZW4pLAo+ID4gKwkJICAgICAgIChmbGFncyAmIFZSSU5HX0RFU0NfRl9XUklURSkg
Pwo+ID4gKwkJICAgICAgIERNQV9GUk9NX0RFVklDRSA6IERNQV9UT19ERVZJQ0UpOwo+ID4gICB9
Cj4gPgo+ID4gICBzdGF0aWMgc3RydWN0IHZyaW5nX3BhY2tlZF9kZXNjICphbGxvY19pbmRpcmVj
dF9wYWNrZWQodW5zaWduZWQgaW50IHRvdGFsX3NnLAo+Cl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
