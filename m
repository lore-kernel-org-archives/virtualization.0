Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE73C433EF
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 10:00:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 360E9401C2;
	Wed,  9 Mar 2022 10:00:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pUl-s82VcjzL; Wed,  9 Mar 2022 09:59:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 48EA24002B;
	Wed,  9 Mar 2022 09:59:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 266F6C0012;
	Wed,  9 Mar 2022 09:59:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D1EAC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:59:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 37DB14167C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:59:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sT64zUVB5qLX
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:59:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1FE0D41622
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:59:55 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R231e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=33; SR=0; TI=SMTPD_---0V6jAtL._1646819988; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V6jAtL._1646819988) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 09 Mar 2022 17:59:49 +0800
Message-ID: <1646819926.6046128-13-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v7 21/26] virtio: add helper virtio_find_vqs_ctx_size()
Date: Wed, 9 Mar 2022 17:58:46 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-22-xuanzhuo@linux.alibaba.com>
 <f1fb522d-74ce-a642-7768-deaad76aeddc@redhat.com>
In-Reply-To: <f1fb522d-74ce-a642-7768-deaad76aeddc@redhat.com>
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org,
 Heiko Carstens <hca@linux.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, kvm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

T24gV2VkLCA5IE1hciAyMDIyIDE3OjA0OjEyICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IOWcqCAyMDIyLzMvOCDkuIvljYg4OjM1LCBYdWFuIFpodW8g
5YaZ6YGTOgo+ID4gSW50cm9kdWNlIGhlbHBlciB2aXJ0aW9fZmluZF92cXNfY3R4X3NpemUoKSB0
byBjYWxsIGZpbmRfdnFzIGFuZCBzcGVjaWZ5Cj4gPiB0aGUgbWF4aW11bSBzaXplIG9mIGVhY2gg
dnEgcmluZy4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPgo+ID4gLS0tCj4gPiAgIGluY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5o
IHwgMTIgKysrKysrKysrKysrCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCsp
Cj4gPgo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oIGIvaW5j
bHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmgKPiA+IGluZGV4IDUxNTc1MjRkODAzNi4uOTIxZDg2
MTBkYjBjIDEwMDY0NAo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmgKPiA+
ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oCj4gPiBAQCAtMjMzLDYgKzIzMywx
OCBAQCBpbnQgdmlydGlvX2ZpbmRfdnFzX2N0eChzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwg
dW5zaWduZWQgbnZxcywKPiA+ICAgCQkJCSAgICAgIGRlc2MsIE5VTEwpOwo+ID4gICB9Cj4gPgo+
ID4gK3N0YXRpYyBpbmxpbmUKPiA+ICtpbnQgdmlydGlvX2ZpbmRfdnFzX2N0eF9zaXplKHN0cnVj
dCB2aXJ0aW9fZGV2aWNlICp2ZGV2LCB1MzIgbnZxcywKPiA+ICsJCQkJIHN0cnVjdCB2aXJ0cXVl
dWUgKnZxc1tdLAo+ID4gKwkJCQkgdnFfY2FsbGJhY2tfdCAqY2FsbGJhY2tzW10sCj4gPiArCQkJ
CSBjb25zdCBjaGFyICogY29uc3QgbmFtZXNbXSwKPiA+ICsJCQkJIGNvbnN0IGJvb2wgKmN0eCwg
c3RydWN0IGlycV9hZmZpbml0eSAqZGVzYywKPiA+ICsJCQkJIHUzMiBzaXplc1tdKQo+ID4gK3sK
PiA+ICsJcmV0dXJuIHZkZXYtPmNvbmZpZy0+ZmluZF92cXModmRldiwgbnZxcywgdnFzLCBjYWxs
YmFja3MsIG5hbWVzLCBjdHgsCj4gPiArCQkJCSAgICAgIGRlc2MsIHNpemVzKTsKPiA+ICt9Cj4K
Pgo+IERvIHdlIG5lZWQgdG8gY29udmVydCBhbGwgdGhlIG9wZW4gY29kZWQgZGlyZWN0IGNhbGwg
dG8gZmluZF92cXMoKSBvdGhlcgo+IHRoYW4gbmV0PwoKCkRvIHlvdSBtZWFuIGNhbGxpbmcgZmlu
ZF92cXMgd2l0aG91dCBhIGhlbHBlcj8gVGhlIGtlcm5lbCBkb2Vzbid0IGRvIHRoYXQKYW55bW9y
ZS4KClRoYW5rcy4KCgo+Cj4gVGhhbmtzCj4KPgo+ID4gKwo+ID4gICAvKioKPiA+ICAgICogdmly
dGlvX3Jlc2V0X3ZxIC0gcmVzZXQgYSBxdWV1ZSBpbmRpdmlkdWFsbHkKPiA+ICAgICogQHZxOiB0
aGUgdmlydHF1ZXVlCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
