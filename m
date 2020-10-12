Return-Path: <SRS0=R3N6=DT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C431C433DF
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 03:43:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C278C20781
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 03:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XV558swp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C278C20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 38DF2866EB;
	Mon, 12 Oct 2020 03:43:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YV-3eIPYNRF1; Mon, 12 Oct 2020 03:43:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B66A786676;
	Mon, 12 Oct 2020 03:43:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98A14C07FF;
	Mon, 12 Oct 2020 03:43:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7540C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 03:43:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CF9E887168
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 03:43:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0U65bjhHEYiE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 03:43:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C0B3B87166
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 03:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602474230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LRc/4gOXa8jCVo/d1ERRs5SER0ImU1RZc38TDUpLQFc=;
 b=XV558swpm17KKRmjprcpUn3ow+9fQLPcm4jvSa8XtqZm4yHmJV+P4D0PfGNhtKgCxKawnW
 pocaGI6bZoOEYmoqRaaecfxaI93AKrN0VskLdF1Iew4bZP/yjPrZVDA+GGuOCQ0GZOS7P+
 lhrC1mklbd/PSbtPTBO6RT/AzMh00RY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-hQRGdXMNNcu0xzgFnXbrDA-1; Sun, 11 Oct 2020 23:43:45 -0400
X-MC-Unique: hQRGdXMNNcu0xzgFnXbrDA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8589D805F0B;
 Mon, 12 Oct 2020 03:43:43 +0000 (UTC)
Received: from [10.72.13.74] (ovpn-13-74.pek2.redhat.com [10.72.13.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1888460C13;
 Mon, 12 Oct 2020 03:43:33 +0000 (UTC)
Subject: Re: [PATCH v3] i2c: virtio: add a virtio i2c frontend driver
To: Jie Deng <jie.deng@intel.com>, linux-i2c@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1350309657ab0c7b9f97e7a5c71d084f88caa549.1600743079.git.jie.deng@intel.com>
 <958b69c3-0321-d5cb-4c12-702795925583@redhat.com>
 <2dc4bd12-9f23-7caa-b1ec-f3403d36e065@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <83529dac-7b87-aec9-55f0-85face47e7b6@redhat.com>
Date: Mon, 12 Oct 2020 11:43:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2dc4bd12-9f23-7caa-b1ec-f3403d36e065@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Sergey.Semin@baikalelectronics.ru, bjorn.andersson@linaro.org,
 loic.poulain@linaro.org, yu1.wang@intel.com, mst@redhat.com, krzk@kernel.org,
 tali.perry1@gmail.com, wsa@kernel.org, wsa+renesas@sang-engineering.com,
 jarkko.nikula@linux.intel.com, rppt@kernel.org, shuo.a.liu@intel.com,
 andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, jdelvare@suse.de
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

Ck9uIDIwMjAvMTAvMTIg5LiK5Y2IMTA6NDUsIEppZSBEZW5nIHdyb3RlOgo+Cj4KPiBPbiAyMDIw
LzEwLzEwIDExOjE0LCBKYXNvbiBXYW5nIHdyb3RlOgo+Pgo+Pj4gKwo+Pj4gK8KgwqDCoMKgwqDC
oMKgIHZpcnRxdWV1ZV9raWNrKHZxKTsKPj4+ICsKPj4+ICvCoMKgwqDCoMKgwqDCoCB0aW1lX2xl
ZnQgPSB3YWl0X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQoJnZpLT5jb21wbGV0aW9uLCAKPj4+IGFk
YXAtPnRpbWVvdXQpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmICghdGltZV9sZWZ0KSB7Cj4+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfZXJyKCZhZGFwLT5kZXYsICJtc2dbJWRdOiBhZGRy
PTB4JXggdGltZW91dC5cbiIsIGksIAo+Pj4gbXNnc1tpXS5hZGRyKTsKPj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGJyZWFrOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIH0KPj4KPj4KPj4gWW91IGRv
bid0IHNldCBlcnJvciBudW1iZXIgaGVyZS4gSXMgdGhpcyBpbnRlbmRlZD8KPj4KPj4gQW5kIHVz
aW5nIGEgdGltZW91dCBoZXJlIGlzIG5vdCBnb29kLCBhbmQgaWYgdGhlIHJlcXVlc3QgaXMgZmlu
aXNoZWQgCj4+IGp1c3QgYWZ0ZXIgdGhlIHRpbWVvdXQsIGluIHRoZSBuZXh0IHhmZXIgeW91IG1h
eSBoaXQgdGhlIGZvbGxvd2luZyAKPj4gY2hlY2suCj4+Cj4+IEl0J3MgYmV0dGVyIHRvIHVzZSBl
aXRoZXIgaW50ZXJydXB0IGhlcmUuCj4+Cj4gQ291bGQgeW91IGNoZWNrIHRoZSBJMkMgZHJpdmVy
cyBpbiB0aGUga2VybmVsID8gVGhlIAo+ICJ3YWl0X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQiIG1l
Y2hhbmlzbQo+IGlzIGNvbW1vbmx5IHVzZWQgYnkgSTJDIGJ1cyBkcml2ZXJzIGluIHRoZWlyIGky
Y19hbGdvcml0aG0ubWFzdGVyX3hmZXIuCgoKVGhlcmUncyBhIG1ham9yIGRpZmZlcmVuY2UgYmV0
d2VlbiB2aXJ0aW8taTJjIGFuZCBvdGhlciBkcml2ZXJzLiBJbiB0aGUgCmNhc2Ugb2YgdmlydGlv
LCB0aGUgZGV2aWNlIGNvdWxkIGJlIGEgc29mdHdhcmUgZGV2aWNlIGVtdWxhdGVkIGJ5IGEgCnJl
bW90ZSBwcm9jZXNzLiBUaGlzIG1lYW5zIHRoZSB0aW1lb3V0IG1pZ2h0IG5vdCBiZSByYXJlLgoK
SSBkb24ndCBzZWUgaG93IHRpbWVvdXQgaXMgcHJvcGVybHkgaGFuZGxlZCBpbiB0aGlzIHBhdGNo
IChlLmcgZGlkIHlvdSAKbm90aWNlIHRoYXQgeW91IGRvbid0IHNldCBhbnkgZXJyb3Igd2hlbiB0
aW1lb3V0PyBvciBpcyB0aGlzIGludGVuZGVkPykKCgo+Cj4+Cj4+PiArCj4+PiArwqDCoMKgwqDC
oMKgwqAgdm1zZyA9IChzdHJ1Y3QgdmlydGlvX2kyY19tc2cgKil2aXJ0cXVldWVfZ2V0X2J1Zih2
cSwgJmxlbik7Cj4+PiArwqDCoMKgwqDCoMKgwqAgLyogdm1zZyBzaG91bGQgcG9pbnQgdG8gdGhl
IHNhbWUgYWRkcmVzcyB3aXRoICZ2aS0+dm1zZyAqLwo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmICgo
IXZtc2cpIHx8ICh2bXNnICE9ICZ2aS0+dm1zZykpIHsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGRldl9lcnIoJmFkYXAtPmRldiwgIm1zZ1slZF06IGFkZHI9MHgleCB2aXJ0cXVldWUgCj4+
PiBlcnJvci5cbiIsCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGksIG1zZ3Nb
aV0uYWRkcik7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPj4+ICvCoMKgwqDC
oMKgwqDCoCB9Cj4+Cj4+Cj4+IFNvIEkgdGhpbmsgd2UgY2FuIHJlbW92ZSB0aGlzIGNoZWNrLiBD
b25zaWRlciBvbmx5IG9uZSBkZXNjcmlwdG9yIAo+PiB3aWxsIGJlIHVzZWQgYXQgbW9zdCwgdW5s
ZXNzIHRoZXJlJ3MgYSBidWcgaW4gdGhlIGRldmljZSAoYW5kIG5vIAo+PiBvdGhlciBkcml2ZXIg
dG8gdGhlIHNpbWlsYXIgY2hlY2spLCB3ZSBzaG91bGQgbm90IGhpdCB0aGlzLgo+Pgo+PiBCdHcs
IGFzIEkgcmVwbGllZCBpbiB0aGUgcHJldmlvdXMgdmVyc2lvbiwgdGhlIGRldmljZSBzaG91bGQg
YmUgCj4+IGNhY3BhYmxlIG9mIGRlYWxpbmcgb2YgYSBiYXRjaCBvZiByZXF1ZXN0cyB0aHJvdWdo
IHRoZSB2aXJ0cXVldWUsIAo+PiBvdGhlcndpc2UgaXQncyBtZWFuaW5nbGVzcyB0byB1c2UgYSBx
dWV1ZSBoZXJlLgo+Pgo+IFdlIHNob3VsZCBub3QgYXNzdW1lIHRoZXJlIGlzIG5vIGJ1ZyBpbiB0
aGUgZGV2aWNlLiBJIGRvbid0IHRoaW5rIHdlIAo+IGNhbiByZW1vdmUgdGhpcyBjaGVjayBpZiB3
ZSB3YW50IG91ciBjb2RlIHRvIGJlIHJvYnVzdC4KCgpDYW4geW91IHRlbGwgd2hlbiBhdCB3aGlj
aCBjYXNlIHlvdSBtYXkgaGl0ICF2bXNnIG9yIHZtc2cgIT0gdmktPnZtc2c/CgoKCj4gQXMgSSBz
YWlkLCBjdXJyZW50bHksIHdlIGFyZSB1c2luZyB0aGUgdmlydHF1ZXVlIHRvIHNlbmQgdGhlIG1z
ZyBvbmUgCj4gYnkgb25lIHRvIHRoZSBiYWNrZW5kLiBUaGUgbWVjaGFuaXNtIGlzIGRlc2NyaWJl
ZCBpbiB0aGUgc3BlYy4gCgoKV2hpY2ggcGFydCBvZiB0aGUgc3BlYyBkZXNjcmliZXMgc3VjaCAi
b25lIGJ5IG9uZSIgbWVjaGFuaXNtPyBJZiB0aGVyZSAKaXMgb25lLCBJJ2QgaGFwcGlseSBnaXZl
IGEgTkFDSyBzaW5jZSBpdCBkb2Vzbid0IHJlcXVpcmUgYSBxdWV1ZSB0byB3b3JrIAp3aGljaCBp
cyBjb25mbGljdCB3aXRoIHRoZSBjb25jZXB0IG9mIHRoZSB2aXJ0cXVldWUuCgoKPiBUaGFua3Mu
Cj4KPgo+Pgo+Pj4gKwo+Pj4KPj4+ICsKPj4+ICsjaWZuZGVmIF9VQVBJX0xJTlVYX1ZJUlRJT19J
MkNfSAo+Pj4gKyNkZWZpbmUgX1VBUElfTElOVVhfVklSVElPX0kyQ19ICj4+PiArCj4+PiArI2lu
Y2x1ZGUgPGxpbnV4L3R5cGVzLmg+Cj4+PiArI2luY2x1ZGUgPGxpbnV4L3ZpcnRpb19pZHMuaD4K
Pj4+ICsjaW5jbHVkZSA8bGludXgvdmlydGlvX2NvbmZpZy5oPgo+Pj4gKwo+Pj4gKy8qKgo+Pj4g
KyAqIHN0cnVjdCB2aXJ0aW9faTJjX2hkciAtIHRoZSB2aXJ0aW8gSTJDIG1lc3NhZ2UgaGVhZGVy
IHN0cnVjdHVyZQo+Pj4gKyAqIEBhZGRyOiBpMmNfbXNnIGFkZHIsIHRoZSBzbGF2ZSBhZGRyZXNz
Cj4+PiArICogQGZsYWdzOiBpMmNfbXNnIGZsYWdzCj4+PiArICogQGxlbjogaTJjX21zZyBsZW4K
Pj4+ICsgKi8KPj4+ICtzdHJ1Y3QgdmlydGlvX2kyY19oZHIgewo+Pj4gK8KgwqDCoCBfX2xlMTYg
YWRkcjsKPj4+ICvCoMKgwqAgX19sZTE2IGZsYWdzOwo+Pj4gK8KgwqDCoCBfX2xlMTYgbGVuOwo+
Pj4gK307Cj4+Cj4+Cj4+IEknbSBhZnJhaWQgdGhpcyBpcyBub3QgY29tcGxldGUuIEUuZyB0aGUg
c3RhdHVzIGlzIG1pc3NlZC4KPj4KPj4gSSBzdXNwZWN0IHdoYXQgdmlydGlvLXNjc2kgdXNlIGlz
IGJldHRlci4gV2hpY2ggc3BsaXQgdGhlIGluIGZyb20gdGhlIAo+PiBvdXQgaW5zdGVhZCBvZiBy
ZXVzaW5nIHRoZSBzYW1lIGJ1ZmZlci4gQW5kIGl0IGNhbiBlYXNlIHRoZSB1QVBJIAo+PiBoZWFk
ZXIgZXhwb3J0Lgo+Pgo+PiBUaGFua3MKPj4KPj4KPgo+IEkgdGhpbmsgZm9sbG93aW5nIGRlZmlu
aXRpb24gaW4gdUFQSSBmb3IgdGhlIHN0YXR1cyBpcyBlbm91Z2guCj4gVGhlcmUgaXMgbm8gbmVl
ZCB0byBwcm92aWRlIGEgInU4IiBzdGF0dXMgaW4gdGhlIHN0cnVjdHVyZS4KPgo+IC8qIFRoZSBm
aW5hbCBzdGF0dXMgd3JpdHRlbiBieSB0aGUgZGV2aWNlICovCj4gI2RlZmluZSBWSVJUSU9fSTJD
X01TR19PS8KgwqDCoCAwCj4gI2RlZmluZSBWSVJUSU9fSTJDX01TR19FUlLCoMKgwqAgMQo+Cj4g
WW91IGNhbiBzZWUgYW4gZXhhbXBsZSBpbiB2aXJ0aW9fYmxrLgo+Cj4gSW4gdGhlIHNwZWM6Cj4K
PiBzdHJ1Y3QgdmlydGlvX2Jsa19yZXEgewo+IGxlMzIgdHlwZTsKPiBsZTMyIHJlc2VydmVkOwo+
IGxlNjQgc2VjdG9yOwo+IHU4IGRhdGFbXTsKPiB1OCBzdGF0dXM7Cj4gfTsKPgo+IEluIHZpcnRp
b19ibGsuaCwgdGhlcmUgaXMgb25seSBmb2xsb3dpbmcgZGVmaW5pdGlvbnMuCj4KPiAjZGVmaW5l
IFZJUlRJT19CTEtfU19PS8KgwqDCoCDCoMKgwqAgMAo+ICNkZWZpbmUgVklSVElPX0JMS19TX0lP
RVJSwqDCoMKgIDEKPiAjZGVmaW5lIFZJUlRJT19CTEtfU19VTlNVUFDCoMKgwqAgMgo+Cgp2aXJ0
aW8tYmxrIGlzIGEgYmFkIGV4YW1wbGUsIGl0J3MganVzdCB0b28gbGF0ZSB0byBmaXguIEZvciBh
bnkgbmV3IAppbnRyb2R1Y2VkIHVBUEkgaXQgc2hvdWxkIGJlIGEgY29tcGxldGUgb25lLgoKVGhh
bmtzCgoKPiBUaGFua3MuCj4KPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
