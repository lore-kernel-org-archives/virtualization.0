Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E20C43217
	for <virtualization@archiver.kernel.org>; Fri, 11 Feb 2022 07:13:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D48740256;
	Fri, 11 Feb 2022 07:13:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LaAlx6RIMzrf; Fri, 11 Feb 2022 07:13:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8A29340229;
	Fri, 11 Feb 2022 07:13:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FEF6C0011;
	Fri, 11 Feb 2022 07:13:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99D70C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 07:13:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6B63740256
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 07:13:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id au7L_fUGzP9G
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 07:13:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ED73240229
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 07:13:30 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R721e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0V47kTem_1644563606; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V47kTem_1644563606) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 11 Feb 2022 15:13:27 +0800
Message-ID: <1644563228.441517-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v4 09/14] virtio: queue_reset: struct virtio_config_ops
 add callbacks for queue_reset
Date: Fri, 11 Feb 2022 15:07:08 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220209122901.51790-1-xuanzhuo@linux.alibaba.com>
 <20220209122901.51790-10-xuanzhuo@linux.alibaba.com>
 <140fc738-3391-5529-dd5a-c46b9e937355@redhat.com>
In-Reply-To: <140fc738-3391-5529-dd5a-c46b9e937355@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
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

T24gRnJpLCAxMSBGZWIgMjAyMiAxNDo0OTowMyArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMi8yLzkg5LiL5Y2IODoyOCwgWHVhbiBaaHVv
IOWGmemBkzoKPiA+IFBlcmZvcm1pbmcgcmVzZXQgb24gYSBxdWV1ZSBpcyBkaXZpZGVkIGludG8g
Zm91ciBzdGVwczoKPiA+Cj4gPiAxLiByZXNldF92cTogcmVzZXQgb25lIHZxCj4gPiAyLiByZWN5
Y2xlIHRoZSBidWZmZXIgZnJvbSB2cSBieSB2aXJ0cXVldWVfZGV0YWNoX3VudXNlZF9idWYoKQo+
ID4gMy4gcmVsZWFzZSB0aGUgcmluZyBvZiB0aGUgdnEgYnkgdnJpbmdfcmVsZWFzZV92aXJ0cXVl
dWUoKQo+ID4gNC4gZW5hYmxlX3Jlc2V0X3ZxOiByZS1lbmFibGUgdGhlIHJlc2V0IHF1ZXVlCj4g
Pgo+ID4gU28gYWRkIHR3byBjYWxsYmFja3MgcmVzZXRfdnEsIGVuYWJsZV9yZXNldF92cSB0byBz
dHJ1Y3QKPiA+IHZpcnRpb19jb25maWdfb3BzLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFh1YW4g
Wmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiAtLS0KPiA+ICAgaW5jbHVkZS9s
aW51eC92aXJ0aW9fY29uZmlnLmggfCAxMyArKysrKysrKysrKysrCj4gPiAgIDEgZmlsZSBjaGFu
Z2VkLCAxMyBpbnNlcnRpb25zKCspCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
dmlydGlvX2NvbmZpZy5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmgKPiA+IGluZGV4
IDRkMTA3YWQzMTE0OS4uMGQwMWE2NGYyNTc2IDEwMDY0NAo+ID4gLS0tIGEvaW5jbHVkZS9saW51
eC92aXJ0aW9fY29uZmlnLmgKPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5o
Cj4gPiBAQCAtNzQsNiArNzQsMTcgQEAgc3RydWN0IHZpcnRpb19zaG1fcmVnaW9uIHsKPiA+ICAg
ICogQHNldF92cV9hZmZpbml0eTogc2V0IHRoZSBhZmZpbml0eSBmb3IgYSB2aXJ0cXVldWUgKG9w
dGlvbmFsKS4KPiA+ICAgICogQGdldF92cV9hZmZpbml0eTogZ2V0IHRoZSBhZmZpbml0eSBmb3Ig
YSB2aXJ0cXVldWUgKG9wdGlvbmFsKS4KPiA+ICAgICogQGdldF9zaG1fcmVnaW9uOiBnZXQgYSBz
aGFyZWQgbWVtb3J5IHJlZ2lvbiBiYXNlZCBvbiB0aGUgaW5kZXguCj4gPiArICogQHJlc2V0X3Zx
OiByZXNldCBhIHF1ZXVlIGluZGl2aWR1YWxseQo+Cj4KPiBUaGlzIG5lZWRzIHRvIGJlIG1hcmtl
ZCBhcyBvcHRpb25hbCBJIHRoaW5rLgoKT0suCgo+Cj4KPiA+ICsgKgl2cTogdGhlIHZpcnRxdWV1
ZQo+ID4gKyAqCVJldHVybnMgMCBvbiBzdWNjZXNzIG9yIGVycm9yIHN0YXR1cwo+Cj4KPiBJdCBs
b29rcyB0byBtZSB0aGUgY2FsbGVyIHNob3VsZCBhbHNvIGd1YXJhbnRlZSB0aGF0IHRoZSB2cmlu
ZyBpcyBub3QKPiBhY2NzZWQgYnkgYW55IGZ1bmN0aW9ucyBlLmcgTkFQSS4KCk9LLgoKPgo+Cj4g
PiArICoJQWZ0ZXIgc3VjY2Vzc2Z1bGx5IGNhbGxpbmcgdGhpcywgYmUgc3VyZSB0byBjYWxsCj4g
PiArICoJdmlydHF1ZXVlX2RldGFjaF91bnVzZWRfYnVmKCkgdG8gcmVjeWNsZSB0aGUgYnVmZmVy
IGluIHRoZSByaW5nLCBhbmQKPiA+ICsgKgl0aGVuIGNhbGwgdnJpbmdfcmVsZWFzZV92aXJ0cXVl
dWUoKSB0byByZWxlYXNlIHRoZSB2cSByaW5nLgo+ID4gKyAqIEBlbmFibGVfcmVzZXRfdnE6IGVu
YWJsZSBhIHJlc2V0IHF1ZXVlCj4gPiArICoJdnE6IHRoZSB2aXJ0cXVldWUKPiA+ICsgKglyaW5n
X251bTogc3BlY2lmeSByaW5nIG51bSBmb3IgdGhlIHZxIHRvIGJlIHJlLWVuYWJsZWQuIDAgbWVh
bnMgdXNlIHRoZQo+ID4gKyAqCSAgICAgICAgICBkZWZhdWx0IHZhbHVlLiBNVVNUIGJlIGEgcG93
ZXIgb2YgMi4KPgo+Cj4gTm90ZSB0aGF0IHdlIGRvbid0IGhhdmUgcG93ZXIgb2YgMiByZXF1aXJl
bWVudCBmb3IgcGFja2VkIHZpcnRxdWV1ZS4KCgpTbyB0aGUgZm9sbG93aW5nIGNoZWNrIGhlcmUg
ZG9lcyBub3Qgc2VlbSByZWFzb25hYmxlLiAodmlydGlvX3BjaV9tb2Rlcm4uYykKCnN0YXRpYyBz
dHJ1Y3QgdmlydHF1ZXVlICpzZXR1cF92cShzdHJ1Y3QgdmlydGlvX3BjaV9kZXZpY2UgKnZwX2Rl
diwKCQkJCSAgc3RydWN0IHZpcnRpb19wY2lfdnFfaW5mbyAqaW5mbywKCQkJCSAgdW5zaWduZWQg
aW5kZXgsCgkJCQkgIHZvaWQgKCpjYWxsYmFjaykoc3RydWN0IHZpcnRxdWV1ZSAqdnEpLAoJCQkJ
ICBjb25zdCBjaGFyICpuYW1lLAoJCQkJICBib29sIGN0eCwKCQkJCSAgdTE2IG1zaXhfdmVjKQp7
CgoJc3RydWN0IHZpcnRpb19wY2lfbW9kZXJuX2RldmljZSAqbWRldiA9ICZ2cF9kZXYtPm1kZXY7
CglzdHJ1Y3QgdmlydHF1ZXVlICp2cTsKCXUxNiBudW07CglpbnQgZXJyOwoKCWlmIChpbmRleCA+
PSB2cF9tb2Rlcm5fZ2V0X251bV9xdWV1ZXMobWRldikpCgkJcmV0dXJuIEVSUl9QVFIoLUVOT0VO
VCk7CgoJLyogQ2hlY2sgaWYgcXVldWUgaXMgZWl0aGVyIG5vdCBhdmFpbGFibGUgb3IgYWxyZWFk
eSBhY3RpdmUuICovCgludW0gPSB2cF9tb2Rlcm5fZ2V0X3F1ZXVlX3NpemUobWRldiwgaW5kZXgp
OwoJaWYgKCFudW0gfHwgdnBfbW9kZXJuX2dldF9xdWV1ZV9lbmFibGUobWRldiwgaW5kZXgpKQoJ
CXJldHVybiBFUlJfUFRSKC1FTk9FTlQpOwoKCWlmIChudW0gJiAobnVtIC0gMSkpIHsKCQlkZXZf
d2FybigmdnBfZGV2LT5wY2lfZGV2LT5kZXYsICJiYWQgcXVldWUgc2l6ZSAldSIsIG51bSk7CgkJ
cmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7Cgl9CgleXl5eXl5eXl5eXl5eXl5eXl5eXl5eXgoKPgo+
IEFuZCBJIHdvbmRlciBpZiBpdCdzIGNsZWFuZXIgdG8gaGF2ZSBhIGZpbmRfdnEoKSBvcHMgaW5z
dGVhZCB0byBkZWFsaW5nCj4gd2l0aCB0aGUgcmUtYWxsb2NhdGlvbiBhbmQgcG9zc2libGUgc2l6
ZSBjaGFuZ2UsIG9yIGhhdmUgYSBkZWRpY2F0ZWQKPiBoZWxwZXIgdG8gc2V0IHZyaW5nIHNpemUg
c28gZHJpdmVyIGNhbiBkby4KPgo+IHJlc2V0X3ZxKCkKPgo+IHZpcnRxdWV1ZV9zZXRfdnJpbmdf
c2l6ZSgpCj4KPiBlbmFibGVfcmVzZXRfdnEoKQoKSSBsaWtlIHRvIGFkZCBhIGRlZGljYXRlZCBo
ZWxwZXIuCgo+Cj4KPiA+ICsgKglSZXR1cm5zIDAgb24gc3VjY2VzcyBvciBlcnJvciBzdGF0dXMK
PiA+ICAgICovCj4gPiAgIHR5cGVkZWYgdm9pZCB2cV9jYWxsYmFja190KHN0cnVjdCB2aXJ0cXVl
dWUgKik7Cj4gPiAgIHN0cnVjdCB2aXJ0aW9fY29uZmlnX29wcyB7Cj4gPiBAQCAtMTAwLDYgKzEx
MSw4IEBAIHN0cnVjdCB2aXJ0aW9fY29uZmlnX29wcyB7Cj4gPiAgIAkJCWludCBpbmRleCk7Cj4g
PiAgIAlib29sICgqZ2V0X3NobV9yZWdpb24pKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LAo+
ID4gICAJCQkgICAgICAgc3RydWN0IHZpcnRpb19zaG1fcmVnaW9uICpyZWdpb24sIHU4IGlkKTsK
PiA+ICsJaW50ICgqcmVzZXRfdnEpKHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsKPiA+ICsJaW50ICgq
ZW5hYmxlX3Jlc2V0X3ZxKShzdHJ1Y3QgdmlydHF1ZXVlICp2cSwgdTE2IHJpbmdfbnVtKTsKPgo+
Cj4gTm90ZSB0aGF0IHRoZSBjdXJyZW50IGltcGxlbWVudCBpcyBiZXN0LWVmZm9ydCwgc28gaXQn
cyBub3QgZ3VhcmFudGVlCj4gdGhhdCB3ZSBjYW4gaGF2ZSBhIHZyaW5nIHdpdGggcmluZ19udW0s
IHdlIG1heSBnZXQgbGVzcyB1bmRlciBtZW1vcnkKPiBwcmVzc3VyZSBvciBldmVuIGZhaWwuIFdl
IHByb2JhYmx5IG5lZWQgdG8gaGF2ZSBhIHBhbWF0ZXIgdG8gbWFuZGF0ZSB0aGUKPiByaW5nX251
bSBvdGhlcndpc2UgdXNlciBtYXkgc3VycHJpc2UgdG8gc2VlIGEgZGVjcmVhc2VkIHNpemUgb2Yg
dGhlIHJpbmcKPiB3aGVuIGEgaW5jcmVhc2luZyBpcyBhY3R1YWxseSByZXF1ZXN0ZWQuCgoxLiBX
ZSBjYW4gYWRkIGEgaGVscGVyIHRvIHNwZWNpZnkgbWF4IHJpbmcgbnVtLgoyLiBPciBhZnRlciBz
cGVjaWZ5aW5nIHJpbmcgbnVtLCBpbiBjYXNlIG9mIGZhaWx1cmUsIHJldHVybiBkaXJlY3RseS4K
CkkgcHJlZmVyICMxCgpUaGFua3MuCgo+Cj4gVGhhbmtzCj4KPgo+ID4gICB9Owo+ID4KPiA+ICAg
LyogSWYgZHJpdmVyIGRpZG4ndCBhZHZlcnRpc2UgdGhlIGZlYXR1cmUsIGl0IHdpbGwgbmV2ZXIg
YXBwZWFyLiAqLwo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
