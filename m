Return-Path: <SRS0=VsiN=FI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A82DC4167B
	for <virtualization@archiver.kernel.org>; Fri,  4 Dec 2020 17:13:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D14322B3B
	for <virtualization@archiver.kernel.org>; Fri,  4 Dec 2020 17:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D14322B3B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id ED35F204E2;
	Fri,  4 Dec 2020 17:13:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nL1hWyMajXC0; Fri,  4 Dec 2020 17:13:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8035F204CE;
	Fri,  4 Dec 2020 17:13:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56533C0FA7;
	Fri,  4 Dec 2020 17:13:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3292C013B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 17:13:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9BF2387C04
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 17:13:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ovrQd8eJiQ-0
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 17:13:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C1F8487E57
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 17:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=Uudat3NMCrNIXj1FEuY9SUz/r7syzJ3sbnmnSODxAJg=; b=gIHWQ/mbkOj0QUxq4EXZ66shiW
 IkpsaN4EDANDPQ2SbTsuPA2/NsLd8l6BKwyAabcflmOWv+pZxHqFz0nGS3Xzt236S2IKjMyXbfndg
 B7QgVbWkNpreXf14D4nlCDrv6llYjiHV2bdssCKvmK65JRMicxO3gDcvTnBxx8qzhIrmSzw+ios4g
 w4jQRQPbhmcUVgNV4t1x7yMvIASZZKE5hiwRfbq291Y5kn+BFWh1S0gfksj7VnSCuNaFk4evm+9RE
 6Pb9fdkJLSR5mvTg5GMexDd3kSLtHPoa0+Ni+vv5nXaDyNA6tIWUMH+M4w3Ehcr+OMsCl4VMNJNY5
 DEgP0/Eg==;
Received: from [2601:1c0:6280:3f0::1494]
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1klEdi-0003Dt-Vh; Fri, 04 Dec 2020 17:13:03 +0000
Subject: Re: [PATCH V2 19/19] vdpa: introduce virtio pci driver
To: Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20201204040353.21679-1-jasowang@redhat.com>
 <20201204040353.21679-20-jasowang@redhat.com>
 <20201204152043.ewqlwviaf33wwiyx@steredhat>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <73a1c314-7398-6182-146f-cd2012646736@infradead.org>
Date: Fri, 4 Dec 2020 09:12:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201204152043.ewqlwviaf33wwiyx@steredhat>
Content-Language: en-US
Cc: shahafs@mellanox.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, mst@redhat.com
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

T24gMTIvNC8yMCA3OjIwIEFNLCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gT24gRnJpLCBE
ZWMgMDQsIDIwMjAgYXQgMTI6MDM6NTNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4gVGhp
cyBwYXRjaCBpbnRyb2R1Y2UgYSB2RFBBIGRyaXZlciBmb3IgdmlydGlvLXBjaSBkZXZpY2UuIEl0
IGJyaWRnZXMKPj4gdGhlIHZpcnRpby1wY2kgY29udHJvbCBjb21tYW5kIHRvIHRoZSB2RFBBIGJ1
cy4gVGhpcyB3aWxsIGJlIHVzZWQgZm9yCj4+IGZlYXR1cmVzIHByb3RvdHlwaW5nIGFuZCB0ZXN0
aW5nLgo+Pgo+PiBOb3RlIHRoYXQgZ2V0L3Jlc3RvcmUgdmlydHF1ZXVlIHN0YXRlIGlzIG5vdCBz
dXBwb3J0ZWQgd2hpY2ggbmVlZHMKPj4gZXh0ZW5zaW9uIG9uIHRoZSB2aXJ0aW8gc3BlY2lmaWNh
dGlvbi4KPj4KPj4gU2lnbmVkLW9mZi1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4KPj4gLS0tCj4+IGRyaXZlcnMvdmRwYS9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfMKgwqAgNiArCj4+IGRyaXZlcnMvdmRwYS9NYWtlZmlsZcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8wqDCoCAxICsKPj4gZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kvTWFrZWZpbGXCoCB8wqDC
oCAyICsKPj4gZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5jIHwgNDU1ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKwo+PiA0IGZpbGVzIGNoYW5nZWQsIDQ2NCBpbnNlcnRpb25z
KCspCj4+IGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS9NYWtlZmls
ZQo+PiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5j
Cj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvS2NvbmZpZyBiL2RyaXZlcnMvdmRwYS9L
Y29uZmlnCj4+IGluZGV4IDM1OGY2MDQ4ZGQzYy4uMThjYWQxNGY1MzNlIDEwMDY0NAo+PiAtLS0g
YS9kcml2ZXJzL3ZkcGEvS2NvbmZpZwo+PiArKysgYi9kcml2ZXJzL3ZkcGEvS2NvbmZpZwo+PiBA
QCAtNDgsNCArNDgsMTAgQEAgY29uZmlnIE1MWDVfVkRQQV9ORVQKPj4gwqDCoMKgwqDCoCBiZSBl
eGVjdXRlZCBieSB0aGUgaGFyZHdhcmUuIEl0IGFsc28gc3VwcG9ydHMgYSB2YXJpZXR5IG9mIHN0
YXRlbGVzcwo+PiDCoMKgwqDCoMKgIG9mZmxvYWRzIGRlcGVuZGluZyBvbiB0aGUgYWN0dWFsIGRl
dmljZSB1c2VkIGFuZCBmaXJtd2FyZSB2ZXJzaW9uLgo+Pgo+PiArY29uZmlnIFZQX1ZEUEEKPj4g
K8KgwqDCoCB0cmlzdGF0ZSAiVmlydGlvIFBDSSBicmlkZ2UgdkRQQSBkcml2ZXIiCj4+ICvCoMKg
wqAgZGVwZW5kcyBvbiBQQ0lfTVNJICYmIFZJUlRJT19QQ0lfTU9ERVJOCj4+ICvCoMKgwqAgaGVs
cAo+PiArwqDCoMKgwqDCoCBUaGlzIGtlcm5lbCBtb2R1bGUgdGhhdCBicmlkZ2VzIHZpcnRpbyBQ
Q0kgZGV2aWNlIHRvIHZEUEEgYnVzLgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF4KPiBXaXRob3V0ICd0aGF0JyBtYXliZSBzb3VuZCBi
ZXR0ZXIsIGJ1dCBJJ20gbm90IGEgbmF0aXZlIHNwZWFrZXIgOi0pCgpZZXMsIGRyb3AgJ3RoYXQn
LCBwbGVhc2UuCgo+PiArCj4+IGVuZGlmICMgVkRQQQoKLS0gCn5SYW5keQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
