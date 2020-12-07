Return-Path: <SRS0=JO0H=FL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81558C433FE
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 03:29:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 028F322D06
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 03:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028F322D06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 936E3873EA;
	Mon,  7 Dec 2020 03:29:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w+woBRbcFr3x; Mon,  7 Dec 2020 03:29:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BBECA8740A;
	Mon,  7 Dec 2020 03:29:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93DACC0FA7;
	Mon,  7 Dec 2020 03:29:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 070ADC013B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 03:29:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0362686B26
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 03:29:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3h_CyrqQNexz
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 03:29:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5984C86B22
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 03:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607311780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TXUkdR17CT0/PFeXaHlete1OGprY+UB5Y5Uzoc4vxP8=;
 b=B1mhJO1p4VM8lXA7jll7+cPnkBpAe0r688HFHUJ8PJZM00WP6r1A/vz5ZvbnTfSK19I7c2
 7aR8N01guDtcTgT2D/bsPZPH/YzcpcyuFCBzbpIjKHDy+GXYVufHwO5wKfXDvYuPNQso2M
 09wJDz6rajwLU+T5Fu9XSlKG71GLMyA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-2EmvEE_XM2SYGv0V3U7eKg-1; Sun, 06 Dec 2020 22:29:38 -0500
X-MC-Unique: 2EmvEE_XM2SYGv0V3U7eKg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53571107ACE4;
 Mon,  7 Dec 2020 03:29:37 +0000 (UTC)
Received: from [10.72.13.171] (ovpn-13-171.pek2.redhat.com [10.72.13.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8C7860CED;
 Mon,  7 Dec 2020 03:29:31 +0000 (UTC)
Subject: Re: [PATCH V2 19/19] vdpa: introduce virtio pci driver
To: Randy Dunlap <rdunlap@infradead.org>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20201204040353.21679-1-jasowang@redhat.com>
 <20201204040353.21679-20-jasowang@redhat.com>
 <20201204152043.ewqlwviaf33wwiyx@steredhat>
 <73a1c314-7398-6182-146f-cd2012646736@infradead.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d7ae5645-9437-2f03-b0c8-35c1812747d2@redhat.com>
Date: Mon, 7 Dec 2020 11:29:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <73a1c314-7398-6182-146f-cd2012646736@infradead.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Ck9uIDIwMjAvMTIvNSDkuIrljYgxOjEyLCBSYW5keSBEdW5sYXAgd3JvdGU6Cj4gT24gMTIvNC8y
MCA3OjIwIEFNLCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4+IE9uIEZyaSwgRGVjIDA0LCAy
MDIwIGF0IDEyOjAzOjUzUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+PiBUaGlzIHBhdGNo
IGludHJvZHVjZSBhIHZEUEEgZHJpdmVyIGZvciB2aXJ0aW8tcGNpIGRldmljZS4gSXQgYnJpZGdl
cwo+Pj4gdGhlIHZpcnRpby1wY2kgY29udHJvbCBjb21tYW5kIHRvIHRoZSB2RFBBIGJ1cy4gVGhp
cyB3aWxsIGJlIHVzZWQgZm9yCj4+PiBmZWF0dXJlcyBwcm90b3R5cGluZyBhbmQgdGVzdGluZy4K
Pj4+Cj4+PiBOb3RlIHRoYXQgZ2V0L3Jlc3RvcmUgdmlydHF1ZXVlIHN0YXRlIGlzIG5vdCBzdXBw
b3J0ZWQgd2hpY2ggbmVlZHMKPj4+IGV4dGVuc2lvbiBvbiB0aGUgdmlydGlvIHNwZWNpZmljYXRp
b24uCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4KPj4+IC0tLQo+Pj4gZHJpdmVycy92ZHBhL0tjb25maWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8wqDCoCA2ICsKPj4+IGRyaXZlcnMvdmRwYS9NYWtlZmlsZcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8wqDCoCAxICsKPj4+IGRyaXZlcnMvdmRwYS92aXJ0aW9fcGNpL01ha2VmaWxlwqAg
fMKgwqAgMiArCj4+PiBkcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMgfCA0NTUgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrCj4+PiA0IGZpbGVzIGNoYW5nZWQsIDQ2NCBpbnNl
cnRpb25zKCspCj4+PiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kv
TWFrZWZpbGUKPj4+IGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92
cF92ZHBhLmMKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL0tjb25maWcgYi9kcml2
ZXJzL3ZkcGEvS2NvbmZpZwo+Pj4gaW5kZXggMzU4ZjYwNDhkZDNjLi4xOGNhZDE0ZjUzM2UgMTAw
NjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvS2NvbmZpZwo+Pj4gKysrIGIvZHJpdmVycy92ZHBh
L0tjb25maWcKPj4+IEBAIC00OCw0ICs0OCwxMCBAQCBjb25maWcgTUxYNV9WRFBBX05FVAo+Pj4g
IMKgwqDCoMKgwqAgYmUgZXhlY3V0ZWQgYnkgdGhlIGhhcmR3YXJlLiBJdCBhbHNvIHN1cHBvcnRz
IGEgdmFyaWV0eSBvZiBzdGF0ZWxlc3MKPj4+ICDCoMKgwqDCoMKgIG9mZmxvYWRzIGRlcGVuZGlu
ZyBvbiB0aGUgYWN0dWFsIGRldmljZSB1c2VkIGFuZCBmaXJtd2FyZSB2ZXJzaW9uLgo+Pj4KPj4+
ICtjb25maWcgVlBfVkRQQQo+Pj4gK8KgwqDCoCB0cmlzdGF0ZSAiVmlydGlvIFBDSSBicmlkZ2Ug
dkRQQSBkcml2ZXIiCj4+PiArwqDCoMKgIGRlcGVuZHMgb24gUENJX01TSSAmJiBWSVJUSU9fUENJ
X01PREVSTgo+Pj4gK8KgwqDCoCBoZWxwCj4+PiArwqDCoMKgwqDCoCBUaGlzIGtlcm5lbCBtb2R1
bGUgdGhhdCBicmlkZ2VzIHZpcnRpbyBQQ0kgZGV2aWNlIHRvIHZEUEEgYnVzLgo+PiAgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXgo+PiBX
aXRob3V0ICd0aGF0JyBtYXliZSBzb3VuZCBiZXR0ZXIsIGJ1dCBJJ20gbm90IGEgbmF0aXZlIHNw
ZWFrZXIgOi0pCj4gWWVzLCBkcm9wICd0aGF0JywgcGxlYXNlLgoKCldpbGwgZml4LgoKVGhhbmtz
CgoKPgo+Pj4gKwo+Pj4gZW5kaWYgIyBWRFBBCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
