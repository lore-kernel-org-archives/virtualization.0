Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45F6C433EF
	for <virtualization@archiver.kernel.org>; Mon,  7 Feb 2022 07:32:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8EF9440155;
	Mon,  7 Feb 2022 07:32:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oY5Qti7y5QhF; Mon,  7 Feb 2022 07:32:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B60F2400D8;
	Mon,  7 Feb 2022 07:32:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94535C001A;
	Mon,  7 Feb 2022 07:32:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1EF9AC000B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 07:32:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EB6D84029D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 07:32:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6rZOyCQuiFRU
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 07:32:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5A96640291
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 07:32:04 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V3leDZt_1644219120; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V3leDZt_1644219120) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 07 Feb 2022 15:32:01 +0800
Message-Id: <1644218386.0457659-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v3 03/17] virtio: queue_reset: struct virtio_config_ops
 add callbacks for queue_reset
Date: Mon, 07 Feb 2022 15:19:46 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
In-Reply-To: <6e3efe44-3ca8-acfa-58a6-c0fc150846e7@redhat.com>
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

T24gTW9uLCA3IEZlYiAyMDIyIDE0OjQ1OjAyICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IOWcqCAyMDIyLzEvMjYg5LiL5Y2IMzozNSwgWHVhbiBaaHVv
IOWGmemBkzoKPiA+IFBlcmZvcm1pbmcgcmVzZXQgb24gYSBxdWV1ZSBpcyBkaXZpZGVkIGludG8g
dHdvIHN0ZXBzOgo+ID4KPiA+IDEuIHJlc2V0X3ZxOiByZXNldCBvbmUgdnEKPiA+IDIuIGVuYWJs
ZV9yZXNldF92cTogcmUtZW5hYmxlIHRoZSByZXNldCBxdWV1ZQo+ID4KPiA+IEluIHRoZSBmaXJz
dCBzdGVwLCB0aGVzZSB0YXNrcyB3aWxsIGJlIGNvbXBsZXRlZDoKPiA+ICAgICAgMS4gbm90aWZ5
IHRoZSBoYXJkd2FyZSBxdWV1ZSB0byByZXNldAo+ID4gICAgICAyLiByZWN5Y2xlIHRoZSBidWZm
ZXIgZnJvbSB2cQo+ID4gICAgICAzLiByZWxlYXNlIHRoZSByaW5nIG9mIHRoZSB2cQo+ID4KPiA+
IFRoZSBzZWNvbmQgc3RlcCBpcyBzaW1pbGFyIHRvIGZpbmQgdnFzLAo+Cj4KPiBOb3Qgc3VyZSwg
c2luY2UgZmluZF92cXMgd2lsbCB1c3VhbGx5IHRyeSB0byBhbGxvY2F0ZSBpbnRlcnJ1cHRzLgo+
Cj4KClllcy4KCgo+ID4gICBwYXNzaW5nIHBhcmFtZXRlcnMgY2FsbGJhY2sgYW5kCj4gPiBuYW1l
LCBldGMuIEJhc2VkIG9uIHRoZSBvcmlnaW5hbCB2cSwgdGhlIHJpbmcgaXMgcmUtYWxsb2NhdGVk
IGFuZAo+ID4gY29uZmlndXJlZCB0byB0aGUgYmFja2VuZC4KPgo+Cj4gSSB3b25kZXIgd2hldGhl
ciB3ZSByZWFsbHkgaGF2ZSBzdWNoIHJlcXVpcmVtZW50Lgo+Cj4gRm9yIGV4YW1wbGUsIGRvIHdl
IHJlYWxseSBoYXZlIGEgdXNlIGNhc2UgdGhhdCBtYXkgY2hhbmdlOgo+Cj4gdnEgY2FsbGJhY2ss
IGN0eCwgcmluZ19udW0gb3IgZXZlbiByZS1jcmVhdGUgdGhlIHZpcnRxdWV1ZT8KCjEuIHZpcnRx
dWV1ZSBpcyBub3QgcmVjcmVhdGVkCjIuIHJpbmdfbnVtIGNhbiBiZSB1c2VkIHRvIG1vZGlmeSBy
aW5nIG51bSBieSBldGh0b29sIC1HCgpUaGVyZSBpcyByZWFsbHkgbm8gc2NlbmUgdG8gbW9kaWZ5
IHZxIGNhbGxiYWNrLCBjdHgsIG5hbWUuCgpEbyB5b3UgbWVhbiB3ZSBzdGlsbCB1c2UgdGhlIG9s
ZCBvbmUgaW5zdGVhZCBvZiBhZGRpbmcgdGhlc2UgcGFyYW1ldGVycz8KClRoYW5rcy4KCj4KPiBU
aGFua3MKPgo+Cj4gPgo+ID4gU28gYWRkIHR3byBjYWxsYmFja3MgcmVzZXRfdnEsIGVuYWJsZV9y
ZXNldF92cSB0byBzdHJ1Y3QKPiA+IHZpcnRpb19jb25maWdfb3BzLgo+ID4KPiA+IEFkZCBhIHN0
cnVjdHVyZSBmb3IgcGFzc2luZyBwYXJhbWV0ZXJzLiBUaGlzIHdpbGwgZmFjaWxpdGF0ZSBzdWJz
ZXF1ZW50Cj4gPiBleHBhbnNpb24gb2YgdGhlIHBhcmFtZXRlcnMgb2YgZW5hYmxlIHJlc2V0IHZx
Lgo+ID4gVGhlcmUgaXMgY3VycmVudGx5IG9ubHkgb25lIGRlZmF1bHQgZXh0ZW5kZWQgcGFyYW1l
dGVyIHJpbmdfbnVtLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9A
bGludXguYWxpYmFiYS5jb20+Cj4gPiAtLS0KPiA+ICAgaW5jbHVkZS9saW51eC92aXJ0aW9fY29u
ZmlnLmggfCA0MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQo+ID4gICAxIGZp
bGUgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+ID4KPiA+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZpcnRpb19jb25maWcuaCBiL2luY2x1ZGUvbGludXgvdmly
dGlvX2NvbmZpZy5oCj4gPiBpbmRleCA0ZDEwN2FkMzExNDkuLjUxZGQ4NDYxZDFiNiAxMDA2NDQK
PiA+IC0tLSBhL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oCj4gPiArKysgYi9pbmNsdWRl
L2xpbnV4L3ZpcnRpb19jb25maWcuaAo+ID4gQEAgLTE2LDYgKzE2LDQ0IEBAIHN0cnVjdCB2aXJ0
aW9fc2htX3JlZ2lvbiB7Cj4gPiAgIAl1NjQgbGVuOwo+ID4gICB9Owo+ID4KPiA+ICt0eXBlZGVm
IHZvaWQgdnFfY2FsbGJhY2tfdChzdHJ1Y3QgdmlydHF1ZXVlICopOwo+ID4gKwo+ID4gKy8qIHZp
cnRpb19yZXNldF92cTogc3BlY2lmeSBwYXJhbWV0ZXJzIGZvciBxdWV1ZV9yZXNldAo+ID4gKyAq
Cj4gPiArICoJdmRldjogdGhlIGRldmljZQo+ID4gKyAqCXF1ZXVlX2luZGV4OiB0aGUgcXVldWUg
aW5kZXgKPiA+ICsgKgo+ID4gKyAqCWZyZWVfdW51c2VkX2NiOiBjYWxsYmFjayB0byBmcmVlIHVu
dXNlZCBidWZzCj4gPiArICoJZGF0YTogdXNlZCBieSBmcmVlX3VudXNlZF9jYgo+ID4gKyAqCj4g
PiArICoJY2FsbGJhY2s6IGNhbGxiYWNrIGZvciB0aGUgdmlydHF1ZXVlLCBOVUxMIGZvciB2cSB0
aGF0IGRvIG5vdCBuZWVkIGEKPiA+ICsgKgkgICAgICAgICAgY2FsbGJhY2sKPiA+ICsgKgluYW1l
OiB2aXJ0cXVldWUgbmFtZXMgKG1haW5seSBmb3IgZGVidWdnaW5nKSwgTlVMTCBmb3IgdnEgdW51
c2VkIGJ5Cj4gPiArICoJICAgICAgZHJpdmVyCj4gPiArICoJY3R4OiBjdHgKPiA+ICsgKgo+ID4g
KyAqCXJpbmdfbnVtOiBzcGVjaWZ5IHJpbmcgbnVtIGZvciB0aGUgdnEgdG8gYmUgcmUtZW5hYmxl
ZC4gMCBtZWFucyB1c2UgdGhlCj4gPiArICoJICAgICAgICAgIGRlZmF1bHQgdmFsdWUuIE1VU1Qg
YmUgYSBwb3dlciBvZiAyLgo+ID4gKyAqLwo+ID4gK3N0cnVjdCB2aXJ0aW9fcmVzZXRfdnE7Cj4g
PiArdHlwZWRlZiB2b2lkIHZxX3Jlc2V0X2NhbGxiYWNrX3Qoc3RydWN0IHZpcnRpb19yZXNldF92
cSAqcGFyYW0sIHZvaWQgKmJ1Zik7Cj4gPiArc3RydWN0IHZpcnRpb19yZXNldF92cSB7Cj4gPiAr
CXN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2Owo+ID4gKwl1MTYgcXVldWVfaW5kZXg7Cj4gPiAr
Cj4gPiArCS8qIHJlc2V0IHZxIHBhcmFtICovCj4gPiArCXZxX3Jlc2V0X2NhbGxiYWNrX3QgKmZy
ZWVfdW51c2VkX2NiOwo+ID4gKwl2b2lkICpkYXRhOwo+ID4gKwo+ID4gKwkvKiBlbmFibGUgcmVz
ZXQgdnEgcGFyYW0gKi8KPiA+ICsJdnFfY2FsbGJhY2tfdCAqY2FsbGJhY2s7Cj4gPiArCWNvbnN0
IGNoYXIgKm5hbWU7Cj4gPiArCWNvbnN0IGJvb2wgKmN0eDsKPiA+ICsKPiA+ICsJLyogZXh0IGVu
YWJsZSByZXNldCB2cSBwYXJhbSAqLwo+ID4gKwl1MTYgcmluZ19udW07Cj4gPiArfTsKPiA+ICsK
PiA+ICAgLyoqCj4gPiAgICAqIHZpcnRpb19jb25maWdfb3BzIC0gb3BlcmF0aW9ucyBmb3IgY29u
ZmlndXJpbmcgYSB2aXJ0aW8gZGV2aWNlCj4gPiAgICAqIE5vdGU6IERvIG5vdCBhc3N1bWUgdGhh
dCBhIHRyYW5zcG9ydCBpbXBsZW1lbnRzIGFsbCBvZiB0aGUgb3BlcmF0aW9ucwo+ID4gQEAgLTc0
LDggKzExMiw5IEBAIHN0cnVjdCB2aXJ0aW9fc2htX3JlZ2lvbiB7Cj4gPiAgICAqIEBzZXRfdnFf
YWZmaW5pdHk6IHNldCB0aGUgYWZmaW5pdHkgZm9yIGEgdmlydHF1ZXVlIChvcHRpb25hbCkuCj4g
PiAgICAqIEBnZXRfdnFfYWZmaW5pdHk6IGdldCB0aGUgYWZmaW5pdHkgZm9yIGEgdmlydHF1ZXVl
IChvcHRpb25hbCkuCj4gPiAgICAqIEBnZXRfc2htX3JlZ2lvbjogZ2V0IGEgc2hhcmVkIG1lbW9y
eSByZWdpb24gYmFzZWQgb24gdGhlIGluZGV4Lgo+ID4gKyAqIEByZXNldF92cTogcmVzZXQgYSBx
dWV1ZSBpbmRpdmlkdWFsbHkKPiA+ICsgKiBAZW5hYmxlX3Jlc2V0X3ZxOiBlbmFibGUgYSByZXNl
dCBxdWV1ZQo+ID4gICAgKi8KPiA+IC10eXBlZGVmIHZvaWQgdnFfY2FsbGJhY2tfdChzdHJ1Y3Qg
dmlydHF1ZXVlICopOwo+ID4gICBzdHJ1Y3QgdmlydGlvX2NvbmZpZ19vcHMgewo+ID4gICAJdm9p
ZCAoKmVuYWJsZV9jYnMpKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KTsKPiA+ICAgCXZvaWQg
KCpnZXQpKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBvZmZzZXQsCj4gPiBA
QCAtMTAwLDYgKzEzOSw4IEBAIHN0cnVjdCB2aXJ0aW9fY29uZmlnX29wcyB7Cj4gPiAgIAkJCWlu
dCBpbmRleCk7Cj4gPiAgIAlib29sICgqZ2V0X3NobV9yZWdpb24pKHN0cnVjdCB2aXJ0aW9fZGV2
aWNlICp2ZGV2LAo+ID4gICAJCQkgICAgICAgc3RydWN0IHZpcnRpb19zaG1fcmVnaW9uICpyZWdp
b24sIHU4IGlkKTsKPiA+ICsJaW50ICgqcmVzZXRfdnEpKHN0cnVjdCB2aXJ0aW9fcmVzZXRfdnEg
KnBhcmFtKTsKPiA+ICsJc3RydWN0IHZpcnRxdWV1ZSAqKCplbmFibGVfcmVzZXRfdnEpKHN0cnVj
dCB2aXJ0aW9fcmVzZXRfdnEgKnBhcmFtKTsKPiA+ICAgfTsKPiA+Cj4gPiAgIC8qIElmIGRyaXZl
ciBkaWRuJ3QgYWR2ZXJ0aXNlIHRoZSBmZWF0dXJlLCBpdCB3aWxsIG5ldmVyIGFwcGVhci4gKi8K
PgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
