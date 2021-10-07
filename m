Return-Path: <SRS0=OSH5=O3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75817C433F5
	for <virtualization@archiver.kernel.org>; Thu,  7 Oct 2021 16:18:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B54961130
	for <virtualization@archiver.kernel.org>; Thu,  7 Oct 2021 16:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2B54961130
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE95884388;
	Thu,  7 Oct 2021 16:18:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EI3vMAW3SAVY; Thu,  7 Oct 2021 16:18:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C12B984390;
	Thu,  7 Oct 2021 16:18:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C938C0011;
	Thu,  7 Oct 2021 16:18:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 489A0C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 16:18:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3550A40A1A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 16:18:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tX7wEEE9xGvV
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 16:18:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C713F40A13
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 16:18:20 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0Uqr86Q-_1633623496; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Uqr86Q-_1633623496) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 08 Oct 2021 00:18:16 +0800
MIME-Version: 1.0
message-id: <1633623446.6192446-1-xuanzhuo@linux.alibaba.com>
subject: Re: virtio-net: kernel panic in virtio_net.c
date: Fri, 08 Oct 2021 00:17:26 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
to: Greg KH <gregkh@linuxfoundation.org>
in-reply-to: <YV8RTqGSTuVLMFOP@kroah.com>
Cc: regressions@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Corentin_No=C3=ABl?= <corentin.noel@collabora.com>,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>
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

T24gVGh1LCA3IE9jdCAyMDIxIDE3OjI1OjAyICswMjAwLCBHcmVnIEtIIDxncmVna2hAbGludXhm
b3VuZGF0aW9uLm9yZz4gd3JvdGU6Cj4gT24gVGh1LCBPY3QgMDcsIDIwMjEgYXQgMTE6MDY6MTJQ
TSArMDgwMCwgWHVhbiBaaHVvIHdyb3RlOgo+ID4gT24gVGh1LCAwNyBPY3QgMjAyMSAxNDowNDoy
MiArMDIwMCwgQ29yZW50aW4gTm/Dq2wgPGNvcmVudGluLm5vZWxAY29sbGFib3JhLmNvbT4gd3Jv
dGU6Cj4gPiA+IEkndmUgYmVlbiBleHBlcmllbmNpbmcgY3Jhc2hlcyB3aXRoIDUuMTQtcmMxIGFu
ZCBhYm92ZSB0aGF0IGRvIG5vdAo+ID4gPiBvY2N1ciB3aXRoIDUuMTMsCj4gPgo+ID4gSSBzaG91
bGQgaGF2ZSBmaXhlZCB0aGlzIHByb2JsZW0gYmVmb3JlLiBJIGRvbid0IGtub3cgd2h5LCBJIGp1
c3QgbG9va2VkIGF0IHRoZQo+ID4gbGF0ZXN0IG5ldCBjb2RlLCBhbmQgdGhpcyBjb21taXQgc2Vl
bXMgdG8gYmUgbG9zdC4KPiA+Cj4gPiAgICAgIDFhODAyNDIzOWRhY2Y1M2ZjZjM5YzBmMDdmYmYy
NzEyYWYyMjg2NGYgdmlydGlvLW5ldDogZml4IGZvciBza2Jfb3Zlcl9wYW5pYyBpbnNpZGUgYmln
IG1vZGUKPiA+Cj4gPiBDYW4geW91IHRlc3QgdGhpcyBwYXRjaCBhZ2Fpbj8KPgo+IFRoYXQgY29t
bWl0IHNob3dlZCB1cCBpbiA1LjEzLXJjNSwgc28gNS4xNC1yYzEgYW5kIDUuMTMgc2hvdWxkIGhh
dmUgaGFkCj4gaXQgaW4gaXQsIHJpZ2h0Pwo+CgpZZXMsIGl0IG1heSBiZSBsb3N0IGR1ZSB0byBj
b25mbGljdHMgZHVyaW5nIGEgY2VydGFpbiBtZXJnZS4KClRoYW5rcy4KCj4gdGhhbmtzLAo+Cj4g
Z3JlZyBrLWgKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
