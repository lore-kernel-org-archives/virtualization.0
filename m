Return-Path: <SRS0=oNZg=CQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CD1C43461
	for <virtualization@archiver.kernel.org>; Mon,  7 Sep 2020 05:40:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4994C204FD
	for <virtualization@archiver.kernel.org>; Mon,  7 Sep 2020 05:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNM4cuji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4994C204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BD06E2047D;
	Mon,  7 Sep 2020 05:40:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tWYm28W5zeD5; Mon,  7 Sep 2020 05:40:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C0E9720369;
	Mon,  7 Sep 2020 05:40:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F973C0052;
	Mon,  7 Sep 2020 05:40:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 046D1C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 05:40:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E02BA864F4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 05:40:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fvkKv7UDwKup
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 05:40:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D6EFD864E0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 05:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599457240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jVs6OBNIgqQK9iP2OirhXkE9npkIsWRhVViuh8tTbuI=;
 b=GNM4cujihv2z8hsEt5UsHynXd7JvxD+d6QDn4/kOdx0uXjRuaNw/lJY8Uig49aP0uka4Mt
 PoZMu24mTqwRgpTLJgFD7LKhMklnAgc2D+VG0+qceKLQpF6vRgTSc4LN+AlGin/2hpAsgG
 npC/meF7hV/DmLjOVihMEVrFN9+Gs0k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-ZjBFcCuwM2Oa0xEKcpUqdw-1; Mon, 07 Sep 2020 01:40:35 -0400
X-MC-Unique: ZjBFcCuwM2Oa0xEKcpUqdw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 385EF800050;
 Mon,  7 Sep 2020 05:40:33 +0000 (UTC)
Received: from [10.72.13.151] (ovpn-13-151.pek2.redhat.com [10.72.13.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8EAB15D9D2;
 Mon,  7 Sep 2020 05:40:22 +0000 (UTC)
Subject: Re: [PATCH] i2c: virtio: add a virtio i2c frontend driver
To: Jie Deng <jie.deng@intel.com>, linux-i2c@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <0efc2605c8c06b4b1bf68cbad5536c4a900dc019.1599110284.git.jie.deng@intel.com>
 <18828d17-c3ac-31bd-2dcf-ecdbd4ad844e@redhat.com>
 <e63a96bf-65d2-ed03-dadc-42d1d8808c9d@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3dc0d61c-9345-2b61-828c-89ca96555e5e@redhat.com>
Date: Mon, 7 Sep 2020 13:40:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e63a96bf-65d2-ed03-dadc-42d1d8808c9d@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Ck9uIDIwMjAvOS80IOS4i+WNiDk6MjEsIEppZSBEZW5nIHdyb3RlOgo+Cj4gT24gMjAyMC85LzQg
MTI6MDYsIEphc29uIFdhbmcgd3JvdGU6Cj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pMmMv
YnVzc2VzL0tjb25maWcgYi9kcml2ZXJzL2kyYy9idXNzZXMvS2NvbmZpZwo+Pj4gaW5kZXggMjkz
ZTdhMC4uNzBjOGUzMCAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9LY29uZmln
Cj4+PiArKysgYi9kcml2ZXJzL2kyYy9idXNzZXMvS2NvbmZpZwo+Pj4gQEAgLTIxLDYgKzIxLDE3
IEBAIGNvbmZpZyBJMkNfQUxJMTUzNQo+Pj4gwqDCoMKgwqDCoMKgwqAgVGhpcyBkcml2ZXIgY2Fu
IGFsc28gYmUgYnVpbHQgYXMgYSBtb2R1bGUuwqAgSWYgc28sIHRoZSBtb2R1bGUKPj4+IMKgwqDC
oMKgwqDCoMKgIHdpbGwgYmUgY2FsbGVkIGkyYy1hbGkxNTM1Lgo+Pj4gwqAgK2NvbmZpZyBJMkNf
VklSVElPCj4+PiArwqDCoMKgIHRyaXN0YXRlICJWaXJ0aW8gSTJDIEFkYXB0ZXIiCj4+PiArwqDC
oMKgIGRlcGVuZHMgb24gVklSVElPCj4+Cj4+Cj4+IEkgZ3Vlc3MgaXQgc2hvdWxkIGRlcGVuZCBv
biBzb21lIEkyQyBtb2R1bGUgaGVyZS4KPj4KPiBUaGUgZGVwZW5kZW5jeSBvZiBJMkMgaXMgaW5j
bHVkZWQgaW4gdGhlIEtjb25maWcgaW4gaXRzIHBhcmVudCBkaXJlY3RvcnkuCj4gU28gdGhlcmUg
aXMgbm90aGluZyBzcGVjaWFsIHRvIGFkZCBoZXJlLgoKCk9rLgoKCj4KPgo+Pgo+Pj4KPj4+ICtz
dHJ1Y3QgdmlydGlvX2kyY19tc2cgewo+Pj4gK8KgwqDCoCBzdHJ1Y3QgdmlydGlvX2kyY19oZHIg
aGRyOwo+Pj4gK8KgwqDCoCBjaGFyICpidWY7Cj4+PiArwqDCoMKgIHU4IHN0YXR1czsKPj4KPj4K
Pj4gQW55IHJlYXNvbiBmb3Igc2VwYXJhdGluZyBzdGF0dXMgb3V0IG9mIHZpcnRpb19pMmNfaGRy
Pwo+Pgo+IFRoZSBzdGF0dXMgaXMgbm90IGZyb20gaTJjX21zZy4gCgoKWW91IG1lYW50IGljMl9o
ZHI/IFlvdSBlbWJlZCBzdGF0dXMgaW4gdmlydGlvX2kyY19tc2cgYW55d2F5LgoKCj4gU28gSSBw
dXQgaXQgb3V0IG9mIHZpcnRpb19pMmNfaGRyLgoKClNvbWV0aGluZyBsaWtlIHN0YXR1cyBvciBy
ZXNwb25zZSBpcyBwcmV0dHkgY29tbW9uIGluIHZpcnRpbyByZXF1ZXN0IAooZS5nIG5ldCBvciBz
Y3NpKSwgaWYgbm8gc3BlY2lhbCByZWFzb24sIGl0J3MgYmV0dGVyIHRvIGtlZXAgaXQgaW4gdGhl
IGhkci4KCgo+Cj4+Cj4+PiArfTsKPj4+ICsKPj4+ICsvKioKPj4+ICsgKiBzdHJ1Y3QgdmlydGlv
X2kyYyAtIHZpcnRpbyBJMkMgZGF0YQo+Pj4gKyAqIEB2ZGV2OiB2aXJ0aW8gZGV2aWNlIGZvciB0
aGlzIGNvbnRyb2xsZXIKPj4+ICsgKiBAY29tcGxldGlvbjogY29tcGxldGlvbiBvZiB2aXJ0aW8g
STJDIG1lc3NhZ2UKPj4+ICsgKiBAYWRhcDogSTJDIGFkYXB0ZXIgZm9yIHRoaXMgY29udHJvbGxl
cgo+Pj4gKyAqIEBpMmNfbG9jazogbG9jayBmb3IgdmlydHF1ZXVlIHByb2Nlc3NpbmcKPj4+ICsg
KiBAdnE6IHRoZSB2aXJ0aW8gdmlydHF1ZXVlIGZvciBjb21tdW5pY2F0aW9uCj4+PiArICovCj4+
PiArc3RydWN0IHZpcnRpb19pMmMgewo+Pj4gK8KgwqDCoCBzdHJ1Y3QgdmlydGlvX2RldmljZSAq
dmRldjsKPj4+ICvCoMKgwqAgc3RydWN0IGNvbXBsZXRpb24gY29tcGxldGlvbjsKPj4+ICvCoMKg
wqAgc3RydWN0IGkyY19hZGFwdGVyIGFkYXA7Cj4+PiArwqDCoMKgIHN0cnVjdCBtdXRleCBpMmNf
bG9jazsKPj4+ICvCoMKgwqAgc3RydWN0IHZpcnRxdWV1ZSAqdnE7Cj4+PiArfTsKPj4+ICsKPj4+
ICtzdGF0aWMgdm9pZCB2aXJ0aW9faTJjX21zZ19kb25lKHN0cnVjdCB2aXJ0cXVldWUgKnZxKQo+
Pj4gK3sKPj4+ICvCoMKgwqAgc3RydWN0IHZpcnRpb19pMmMgKnZpID0gdnEtPnZkZXYtPnByaXY7
Cj4+PiArCj4+PiArwqDCoMKgIGNvbXBsZXRlKCZ2aS0+Y29tcGxldGlvbik7Cj4+PiArfQo+Pj4g
Kwo+Pj4gK3N0YXRpYyBpbnQgdmlydGlvX2kyY19hZGRfbXNnKHN0cnVjdCB2aXJ0cXVldWUgKnZx
LAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHZpcnRpb19p
MmNfbXNnICp2bXNnLAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3Ry
dWN0IGkyY19tc2cgKm1zZykKPj4+ICt7Cj4+PiArwqDCoMKgIHN0cnVjdCBzY2F0dGVybGlzdCAq
c2dzWzNdLCBoZHIsIGJvdXQsIGJpbiwgc3RhdHVzOwo+Pj4gK8KgwqDCoCBpbnQgb3V0Y250ID0g
MCwgaW5jbnQgPSAwOwo+Pj4gKwo+Pj4gK8KgwqDCoCBpZiAoIW1zZy0+bGVuKQo+Pj4gK8KgwqDC
oMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOwo+Pj4gKwo+Pj4gK8KgwqDCoCB2bXNnLT5oZHIuYWRk
ciA9IG1zZy0+YWRkcjsKPj4+ICvCoMKgwqAgdm1zZy0+aGRyLmZsYWdzID0gbXNnLT5mbGFnczsK
Pj4+ICvCoMKgwqAgdm1zZy0+aGRyLmxlbiA9IG1zZy0+bGVuOwo+Pgo+Pgo+PiBNaXNzaW5nIGVu
ZGlhbiBjb252ZXJzaW9uPwo+Pgo+IFlvdSBhcmUgcmlnaHQuIE5lZWQgY29udmVyc2lvbiBoZXJl
Lgo+Pgo+Pj4gKwo+Pj4gK8KgwqDCoCB2bXNnLT5idWYgPSBremFsbG9jKHZtc2ctPmhkci5sZW4s
IEdGUF9LRVJORUwpOwo+Pj4gK8KgwqDCoCBpZiAoIXZtc2ctPmJ1ZikKPj4+ICvCoMKgwqDCoMKg
wqDCoCByZXR1cm4gLUVOT01FTTsKPj4+ICsKPj4+ICvCoMKgwqAgc2dfaW5pdF9vbmUoJmhkciwg
JnZtc2ctPmhkciwgc2l6ZW9mKHN0cnVjdCB2aXJ0aW9faTJjX2hkcikpOwo+Pj4gK8KgwqDCoCBz
Z3Nbb3V0Y250KytdID0gJmhkcjsKPj4+ICvCoMKgwqAgaWYgKHZtc2ctPmhkci5mbGFncyAmIEky
Q19NX1JEKSB7Cj4+PiArwqDCoMKgwqDCoMKgwqAgc2dfaW5pdF9vbmUoJmJpbiwgdm1zZy0+YnVm
LCBtc2ctPmxlbik7Cj4+PiArwqDCoMKgwqDCoMKgwqAgc2dzW291dGNudCArIGluY250KytdID0g
JmJpbjsKPj4+ICvCoMKgwqAgfSBlbHNlIHsKPj4+ICvCoMKgwqDCoMKgwqDCoCBtZW1jcHkodm1z
Zy0+YnVmLCBtc2ctPmJ1ZiwgbXNnLT5sZW4pOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIHNnX2luaXRf
b25lKCZib3V0LCB2bXNnLT5idWYsIG1zZy0+bGVuKTsKPj4+ICvCoMKgwqDCoMKgwqDCoCBzZ3Nb
b3V0Y250KytdID0gJmJvdXQ7Cj4+PiArwqDCoMKgIH0KPj4+ICvCoMKgwqAgc2dfaW5pdF9vbmUo
JnN0YXR1cywgJnZtc2ctPnN0YXR1cywgc2l6ZW9mKHZtc2ctPnN0YXR1cykpOwo+Pj4gK8KgwqDC
oCBzZ3Nbb3V0Y250ICsgaW5jbnQrK10gPSAmc3RhdHVzOwo+Pj4gKwo+Pj4gK8KgwqDCoCByZXR1
cm4gdmlydHF1ZXVlX2FkZF9zZ3ModnEsIHNncywgb3V0Y250LCBpbmNudCwgdm1zZywgCj4+PiBH
RlBfS0VSTkVMKTsKPj4+ICt9Cj4+PiArCj4+PiArc3RhdGljIGludCB2aXJ0aW9faTJjX3hmZXIo
c3RydWN0IGkyY19hZGFwdGVyICphZGFwLCBzdHJ1Y3QgaTJjX21zZyAKPj4+ICptc2dzLCBpbnQg
bnVtKQo+Pj4gK3sKPj4+ICvCoMKgwqAgc3RydWN0IHZpcnRpb19pMmMgKnZpID0gaTJjX2dldF9h
ZGFwZGF0YShhZGFwKTsKPj4+ICvCoMKgwqAgc3RydWN0IHZpcnRpb19pMmNfbXNnICp2bXNnX28s
ICp2bXNnX2k7Cj4+PiArwqDCoMKgIHN0cnVjdCB2aXJ0cXVldWUgKnZxID0gdmktPnZxOwo+Pj4g
K8KgwqDCoCB1bnNpZ25lZCBsb25nIHRpbWVfbGVmdDsKPj4+ICvCoMKgwqAgaW50IGxlbiwgaSwg
cmV0ID0gMDsKPj4+ICsKPj4+ICvCoMKgwqAgdm1zZ19vID0ga3phbGxvYyhzaXplb2YoKnZtc2df
byksIEdGUF9LRVJORUwpOwo+Pj4gK8KgwqDCoCBpZiAoIXZtc2dfbykKPj4+ICvCoMKgwqDCoMKg
wqDCoCByZXR1cm4gLUVOT01FTTsKPj4KPj4KPj4gSXQgbG9va3MgdG8gbWUgd2UgY2FuIGF2b2lk
IHRoZSBhbGxvY2F0aW9uIGJ5IGVtYmVkZGluZyAKPj4gdmlydGlvX2kyY19tc2cgaW50byBzdHJ1
Y3QgdmlydGlvX2kyYzsKPj4KPiBZZWFoLi4uIFRoYXQncyBiZXR0ZXIuIFRoYW5rcy4KPgo+Cj4+
Cj4+PiArCj4+PiArwqDCoMKgIG11dGV4X2xvY2soJnZpLT5pMmNfbG9jayk7Cj4+PiArwqDCoMKg
IHZtc2dfby0+YnVmID0gTlVMTDsKPj4+ICvCoMKgwqAgZm9yIChpID0gMDsgaSA8IG51bTsgaSsr
KSB7Cj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0ID0gdmlydGlvX2kyY19hZGRfbXNnKHZxLCB2bXNn
X28sICZtc2dzW2ldKTsKPj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAocmV0KSB7Cj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBkZXZfZXJyKCZhZGFwLT5kZXYsICJmYWlsZWQgdG8gYWRkIG1zZ1sl
ZF0gdG8gCj4+PiB2aXJ0cXVldWUuXG4iLCBpKTsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGdvdG8gZXJyX3VubG9ja19mcmVlOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIH0KPj4+ICsKPj4+ICvC
oMKgwqDCoMKgwqDCoCB2aXJ0cXVldWVfa2ljayh2cSk7Cj4+PiArCj4+PiArwqDCoMKgwqDCoMKg
wqAgdGltZV9sZWZ0ID0gd2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0KCZ2aS0+Y29tcGxldGlv
biwgCj4+PiBhZGFwLT50aW1lb3V0KTsKPj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoIXRpbWVfbGVm
dCkgewo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X2VycigmYWRhcC0+ZGV2LCAibXNn
WyVkXTogYWRkcj0weCV4IHRpbWVvdXQuXG4iLCBpLCAKPj4+IG1zZ3NbaV0uYWRkcik7Cj4+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZ290byBlcnJfdW5sb2NrX2ZyZWU7Cj4+PiArwqDCoMKgwqDCoMKgwqAgfQo+Pj4gKwo+Pj4g
K8KgwqDCoMKgwqDCoMKgIHZtc2dfaSA9IChzdHJ1Y3QgdmlydGlvX2kyY19tc2cgKil2aXJ0cXVl
dWVfZ2V0X2J1Zih2cSwgJmxlbik7Cj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKHZtc2dfaSkgewo+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogdm1zZ19pIHNob3VsZCBwb2ludCB0byB0aGUg
c2FtZSBhZGRyZXNzIHdpdGggdm1zZ19vICovCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
ZiAodm1zZ19pICE9IHZtc2dfbykgewo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBkZXZfZXJyKCZhZGFwLT5kZXYsICJtc2dbJWRdOiBhZGRyPTB4JXggdmlydHF1ZXVlIAo+Pj4g
ZXJyb3IuXG4iLAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGks
IHZtc2dfaS0+aGRyLmFkZHIpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZXQgPSBpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycl91bmxv
Y2tfZnJlZTsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPj4KPj4KPj4gRG9lcyB0aGlz
IGltcGx5IGluIG9yZGVyIGNvbXBsZXRpb24gb2YgaTJjIGRldmljZT/CoCAoRS5nIHdoYXQgaGFw
cGVucyAKPj4gaWYgbXVsdGlwbGUgdmlydGlvIGkyYyByZXF1ZXN0cyBhcmUgc3VibWl0dGVkKQo+
Pgo+PiBCdHcsIHRoaXMgYWx3YXlzIHVzZSBhIHNpbmdsZSBkZXNjcmlwdG9yIG9uY2UgYSB0aW1l
IHdoaWNoIG1ha2VzIG1lIAo+PiBzdXNwZWN0IGlmIGEgdmlydHF1ZXVlKHZpcnRpbykgaXMgcmVh
bGx5IG5lZWRlZC4gSXQgbG9va3MgdG8gbWUgd2UgCj4+IGNhbiB1dGlsaXplIHRoZSB2aXJ0cXVl
dWUgYnkgc3VibWl0IHRoZSByZXF1ZXN0IGluIGEgYmF0Y2guCj4+Cj4gSSdtIGFmcmFpZCBub3Qg
YWxsIHBoeXNpY2FsIGRldmljZXMgc3VwcG9ydCBiYXRjaC4gCgoKWWVzIGJ1dCBJIHRoaW5rIEkg
bWVhbnQgZm9yIHRoZSB2aXJ0aW8gZGV2aWNlIG5vdCB0aGUgcGh5c2ljYWwgb25lLiBJdCdzIApp
bXBvc3NpYmxlIHRvIGZvcmJpZCBiYXRjaGluZyBpZiB5b3UgaGF2ZSBhIHF1ZXVlIGFueXdheSAu
Li4KCgo+IEknZCBsaWtlIHRvIGtlZXAgdGhlIGN1cnJlbnQgZGVzaWduIGFuZCBjb25zaWRlcgo+
IHlvdXIgc3VnZ2VzdGlvbiBhcyBhIHBvc3NpYmxlIG9wdGltaXphdGlvbiBpbiB0aGUgZnV0dXJl
Lgo+Cj4gVGhhbmtzLgo+Cj4KPj4+Cj4+PiArfQo+Pj4gKwo+Pj4gK3N0YXRpYyB2b2lkIHZpcnRp
b19pMmNfZGVsX3ZxcyhzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPj4+ICt7Cj4+PiArwqDC
oMKgIHZkZXYtPmNvbmZpZy0+cmVzZXQodmRldik7Cj4+Cj4+Cj4+IFdoeSBuZWVkIHJlc2V0IGhl
cmU/Cj4+Cj4+IFRoYW5rcwo+Pgo+IEknbSBmb2xsb3dpbmcgd2hhdCBvdGhlciB2aXJ0aW8gZHJp
dmVycyBkby4KPiBUaGV5IHJlc2V0IHRoZSBkZXZpY2VzIGJlZm9yZSB0aGV5IGNsZWFuIHVwIHRo
ZSBxdWV1ZXMuCgoKWW91J3JlIHJpbmcuCgpUaGFua3MKCgo+Cj4KPj4KPj4+ICvCoMKgwqAgdmRl
di0+Y29uZmlnLT5kZWxfdnFzKHZkZXYpOwo+Pj4gK30KPj4+ICsKPj4+ICtzdGF0aWMgaW50IHZp
cnRpb19pMmNfc2V0dXBfdnFzKHN0cnVjdCB2aXJ0aW9faTJjICp2aSkKPj4+ICt7Cj4+PiArwqDC
oMKgIHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2ID0gdmktPnZkZXY7Cj4+PiArCj4+PiArwqDC
oMKgIHZpLT52cSA9IHZpcnRpb19maW5kX3NpbmdsZV92cSh2ZGV2LCB2aXJ0aW9faTJjX21zZ19k
b25lLCAKPj4+ICJpMmMtbXNnIik7Cj4+Cj4+Cj4+IFdlJ3ZlIGluIHRoZSBzY29wZSBvZiBpYzIs
IHNvICJtc2ciIHNob3VsZCBiZSBzdWZmaWNpZW50Lgo+Pgo+Pgo+IE9LLiBXaWxsIGNoYW5nZSB0
aGlzIG5hbWUuIFRoYW5rcy4KPgo+Cj4+PiArwqDCoMKgIHJldHVybiBQVFJfRVJSX09SX1pFUk8o
dmktPnZxKTsKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
