Return-Path: <SRS0=6MyX=JZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060A9C433B4
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 09:22:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 722B66141F
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 09:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 722B66141F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 12FA9400C9;
	Wed, 28 Apr 2021 09:22:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wXb5C2p6nTHT; Wed, 28 Apr 2021 09:22:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id AF277400DC;
	Wed, 28 Apr 2021 09:22:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74833C0022;
	Wed, 28 Apr 2021 09:22:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84381C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 09:21:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 64B6E84338
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 09:21:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bbijnYQx1nYN
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 09:21:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 96AF384332
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 09:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619601717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=axU4olOyFNuAi1siDolpKEA8kn46+KAy0fVSsUFenIk=;
 b=VI08gX5lmE8LhskhHD71g3tihpYRSrIHUhX43HOV821vJS3TtKm8xFcWoV+RwCQBP0Bdxk
 YpvdPzmPWdk7eFdIEOyg6njH6XwZdeJ8Dk2orfysPzFc75b4FMbC2VxUPn4rE/hM6Fabai
 FV1vdzUUV1bUN10ei2Dg5+6w/rD+OUY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-TqqIchBUMpmMqypacMgirw-1; Wed, 28 Apr 2021 05:21:54 -0400
X-MC-Unique: TqqIchBUMpmMqypacMgirw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DA0B818CA3;
 Wed, 28 Apr 2021 09:21:53 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-25.pek2.redhat.com
 [10.72.12.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 83A6A5C224;
 Wed, 28 Apr 2021 09:21:50 +0000 (UTC)
Subject: Re: [PATCH 2/2] vDPA/ifcvf: implement doorbell mapping for ifcvf
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, mst@redhat.com
References: <20210428082133.6766-1-lingshan.zhu@intel.com>
 <20210428082133.6766-3-lingshan.zhu@intel.com>
 <f6d9a424-9025-3eb5-1cb4-0ff22f7bec63@redhat.com>
 <5052fced-cd9a-e453-5cb2-39cdde60a208@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1984491f-cd5e-d4bc-b328-41e2f2e935fd@redhat.com>
Date: Wed, 28 Apr 2021 17:21:48 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <5052fced-cd9a-e453-5cb2-39cdde60a208@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIxLzQvMjgg5LiL5Y2INDo1OSwgWmh1LCBMaW5nc2hhbiDlhpnpgZM6Cj4KPgo+IE9u
IDQvMjgvMjAyMSA0OjQyIFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pgo+PiDlnKggMjAyMS80LzI4
IOS4i+WNiDQ6MjEsIFpodSBMaW5nc2hhbiDlhpnpgZM6Cj4+PiBUaGlzIGNvbW1pdCBpbXBsZW1l
bnRzIGRvb3JiZWxsIG1hcHBpbmcgZmVhdHVyZSBmb3IgaWZjdmYuCj4+PiBUaGlzIGZlYXR1cmUg
bWFwcyB0aGUgbm90aWZ5IHBhZ2UgdG8gdXNlcnNwYWNlLCB0byBlbGltaW5hdGUKPj4+IHZtZXhp
dCB3aGVuIGtpY2sgYSB2cS4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBaaHUgTGluZ3NoYW4gPGxp
bmdzaGFuLnpodUBpbnRlbC5jb20+Cj4+PiAtLS0KPj4+IMKgIGRyaXZlcnMvdmRwYS9pZmN2Zi9p
ZmN2Zl9tYWluLmMgfCAxOCArKysrKysrKysrKysrKysrKysKPj4+IMKgIDEgZmlsZSBjaGFuZ2Vk
LCAxOCBpbnNlcnRpb25zKCspCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2
Zi9pZmN2Zl9tYWluLmMgCj4+PiBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPj4+
IGluZGV4IGU0OGU2Yjc0ZmUyZS4uYWZjYjcxYmMwZjUxIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVy
cy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+Pj4gKysrIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lm
Y3ZmX21haW4uYwo+Pj4gQEAgLTQxMyw2ICs0MTMsMjMgQEAgc3RhdGljIGludCBpZmN2Zl92ZHBh
X2dldF92cV9pcnEoc3RydWN0IAo+Pj4gdmRwYV9kZXZpY2UgKnZkcGFfZGV2LAo+Pj4gwqDCoMKg
wqDCoCByZXR1cm4gdmYtPnZyaW5nW3FpZF0uaXJxOwo+Pj4gwqAgfQo+Pj4gwqAgK3N0YXRpYyBz
dHJ1Y3QgdmRwYV9ub3RpZmljYXRpb25fYXJlYSAKPj4+IGlmY3ZmX2dldF92cV9ub3RpZmljYXRp
b24oc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhX2RldiwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1MTYgaWR4
KQo+Pj4gK3sKPj4+ICvCoMKgwqAgc3RydWN0IGlmY3ZmX2h3ICp2ZiA9IHZkcGFfdG9fdmYodmRw
YV9kZXYpOwo+Pj4gK8KgwqDCoCBzdHJ1Y3QgdmRwYV9ub3RpZmljYXRpb25fYXJlYSBhcmVhOwo+
Pj4gKwo+Pj4gK8KgwqDCoCBpZiAodmYtPm5vdGlmeV9wYSAlIFBBR0VfU0laRSkgewo+Pj4gK8Kg
wqDCoMKgwqDCoMKgIGFyZWEuYWRkciA9IDA7Cj4+PiArwqDCoMKgwqDCoMKgwqAgYXJlYS5zaXpl
ID0gMDsKPj4KPj4KPj4gV2UgZG9uJ3QgbmVlZCB0aGlzIHNpbmNlOgo+Pgo+PiAxKSB0aGVyZSdz
IGEgY2hlY2sgaW4gdGhlIHZob3N0IHZEUEEKPiBJIHRoaW5rIHlvdSBtZWFuIHRoaXMgY29kZSBi
bG9jayBpbiB2ZHBhLmMKPiDCoMKgwqDCoMKgwqDCoCBub3RpZnkgPSBvcHMtPmdldF92cV9ub3Rp
ZmljYXRpb24odmRwYSwgaW5kZXgpOwo+IMKgwqDCoMKgwqDCoMKgIGlmIChub3RpZnkuYWRkciAm
IChQQUdFX1NJWkUgLSAxKSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IC1FSU5WQUw7Cj4KPiBUaGlzIHNob3VsZCB3b3JrLCBob3dldmVyLCBJIHRoaW5rIHRoZSBwYXJl
bnQgZHJpdmVyIHNob3VsZCBlbnN1cmUgaXQgCj4gcGFzc2VzIGEgUEFHRV9TSVpFIGFsaWduZWQg
YWRkcmVzcyB0byB1c2Vyc3BhY2UsIHRvIGJlIHJvYnVzdCwgdG8gYmUgCj4gcmVsaWFibGUuCgoK
VGhlIHBvaW50IGlzIHBhcmVudCBpcyB1bmF3YXJlIG9mIHdoZXRoZXIgb3Igbm90IHRoZXJlJ3Mg
YSB1c2Vyc3BhY2UuCgoKPj4gMikgZGV2aWNlIGlzIHVuYXdhcmUgb2YgdGhlIGJvdW5kIGRyaXZl
ciwgbm9uIHBhZ2UgYWxpZ25lZCBkb29yYmVsbCAKPj4gZG9lc24ndCBuZWNlc3NhcmlseSBtZWFu
dCBpdCBjYW4gYmUgdXNlZAo+IFllcywgbm9uIHBhZ2UgYWxpZ25lZCBkb29yYmVsbCBjYW4gbm90
IGJlIHVzZWQsIHNvIHRoZXJlIGlzIGEgY2hlY2suCgoKVHlwbywgd2hhdCBJIG1lYW50IGlzICJp
dCBjYW4ndCBiZSB1c2VkIi4gVGhhdCBpcyB0byBzYXksIHdlIHNob3VsZCBsZXQgCnRoZSB2RFBB
IGJ1cyBkcml2ZXIgdG8gZGVjaWRlIHdoZXRoZXIgb3Igbm90IGl0IGNhbiBiZSB1c2VkLgoKVGhh
bmtzCgoKPgo+IFRoYW5rcwo+IFpodSBMaW5nc2hhbgo+Pgo+PiBMZXQncyBsZWF2ZSB0aG9zZSBw
b2xpY2VzIHRvIHRoZSBkcml2ZXIuCj4+Cj4+IFRoYW5rcwo+Pgo+Pgo+Pj4gK8KgwqDCoCB9IGVs
c2Ugewo+Pj4gK8KgwqDCoMKgwqDCoMKgIGFyZWEuYWRkciA9IHZmLT5ub3RpZnlfcGE7Cj4+PiAr
wqDCoMKgwqDCoMKgwqAgYXJlYS5zaXplID0gUEFHRV9TSVpFOwo+Pj4gK8KgwqDCoCB9Cj4+PiAr
Cj4+PiArwqDCoMKgIHJldHVybiBhcmVhOwo+Pj4gK30KPj4+ICsKPj4+IMKgIC8qCj4+PiDCoMKg
ICogSUZDVkYgY3VycmVudGx5IGRvZXMndCBoYXZlIG9uLWNoaXAgSU9NTVUsIHNvIG5vdAo+Pj4g
wqDCoCAqIGltcGxlbWVudGVkIHNldF9tYXAoKS9kbWFfbWFwKCkvZG1hX3VubWFwKCkKPj4+IEBA
IC00NDAsNiArNDU3LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgaWZj
X3ZkcGFfb3BzID17Cj4+PiDCoMKgwqDCoMKgIC5nZXRfY29uZmlnwqDCoMKgID0gaWZjdmZfdmRw
YV9nZXRfY29uZmlnLAo+Pj4gwqDCoMKgwqDCoCAuc2V0X2NvbmZpZ8KgwqDCoCA9IGlmY3ZmX3Zk
cGFfc2V0X2NvbmZpZywKPj4+IMKgwqDCoMKgwqAgLnNldF9jb25maWdfY2LCoCA9IGlmY3ZmX3Zk
cGFfc2V0X2NvbmZpZ19jYiwKPj4+ICvCoMKgwqAgLmdldF92cV9ub3RpZmljYXRpb24gPSBpZmN2
Zl9nZXRfdnFfbm90aWZpY2F0aW9uLAo+Pj4gwqAgfTsKPj4+IMKgIMKgIHN0YXRpYyBpbnQgaWZj
dmZfcHJvYmUoc3RydWN0IHBjaV9kZXYgKnBkZXYsIGNvbnN0IHN0cnVjdCAKPj4+IHBjaV9kZXZp
Y2VfaWQgKmlkKQo+Pgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
