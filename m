Return-Path: <SRS0=iZVf=BO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1DAC433DF
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 08:54:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E6E72075D
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 08:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cgVal2Zg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6E72075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B74932052A;
	Tue,  4 Aug 2020 08:54:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j-yoMW1d7poV; Tue,  4 Aug 2020 08:54:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7BA7A203E4;
	Tue,  4 Aug 2020 08:54:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 588ECC0051;
	Tue,  4 Aug 2020 08:54:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A92B8C004C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 08:54:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8B65320429
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 08:54:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e3O6nC6QGMEu
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 08:54:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id C296E203E4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 08:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596531243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ar1+uVqX5UepvjxlNAdSywz/ygeeCC0bBixNmIdie/U=;
 b=cgVal2ZgRdy6jIEtnxCFY7IsbXAxqJ9M4bkvEuZrPHlDju5ft1sC4NZkUmSCxaMDXTnB7v
 HZBr0oycLqWMv23xlqyqea9rMqzNtHdK5HyPYLysjt2G5HKoXKHa2IBejKpwTuyQ6alhu9
 uLi2ud5tjZicRmeCQtgHpU1JQHcTxxQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-J83cjIauNHe_W9vqe6PnKQ-1; Tue, 04 Aug 2020 04:53:59 -0400
X-MC-Unique: J83cjIauNHe_W9vqe6PnKQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99EFC19057A2;
 Tue,  4 Aug 2020 08:53:57 +0000 (UTC)
Received: from [10.72.13.197] (ovpn-13-197.pek2.redhat.com [10.72.13.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C1787178E;
 Tue,  4 Aug 2020 08:53:41 +0000 (UTC)
Subject: Re: [PATCH V5 1/6] vhost: introduce vhost_vring_call
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, alex.williamson@redhat.com,
 mst@redhat.com, pbonzini@redhat.com, sean.j.christopherson@intel.com,
 wanpengli@tencent.com
References: <20200731065533.4144-1-lingshan.zhu@intel.com>
 <20200731065533.4144-2-lingshan.zhu@intel.com>
 <5e646141-ca8d-77a5-6f41-d30710d91e6d@redhat.com>
 <d51dd4e3-7513-c771-104c-b61f9ee70f30@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <156b8d71-6870-c163-fdfa-35bf4701987d@redhat.com>
Date: Tue, 4 Aug 2020 16:53:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d51dd4e3-7513-c771-104c-b61f9ee70f30@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: shahafs@mellanox.com, parav@mellanox.com, kvm@vger.kernel.org,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eli@mellanox.com
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

Ck9uIDIwMjAvOC80IOS4i+WNiDQ6NDIsIFpodSwgTGluZ3NoYW4gd3JvdGU6Cj4KPgo+IE9uIDgv
NC8yMDIwIDQ6MzggUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4+Cj4+IE9uIDIwMjAvNy8zMSDkuIvl
jYgyOjU1LCBaaHUgTGluZ3NoYW4gd3JvdGU6Cj4+PiBUaGlzIGNvbW1pdCBpbnRyb2R1Y2VzIHN0
cnVjdCB2aG9zdF92cmluZ19jYWxsIHdoaWNoIHJlcGxhY2VkCj4+PiByYXcgc3RydWN0IGV2ZW50
ZmRfY3R4ICpjYWxsX2N0eCBpbiBzdHJ1Y3Qgdmhvc3RfdmlydHF1ZXVlLgo+Pj4gQmVzaWRlcyBl
dmVudGZkX2N0eCwgaXQgY29udGFpbnMgYSBzcGluIGxvY2sgYW5kIGFuCj4+PiBpcnFfYnlwYXNz
X3Byb2R1Y2VyIGluIGl0cyBzdHJ1Y3R1cmUuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogWmh1IExp
bmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+Pj4gU3VnZ2VzdGVkLWJ5OiBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+Pj4gLS0tCj4+PiDCoCBkcml2ZXJzL3Zob3N0L3Zk
cGEuY8KgIHzCoCA0ICsrLS0KPj4+IMKgIGRyaXZlcnMvdmhvc3Qvdmhvc3QuYyB8IDIyICsrKysr
KysrKysrKysrKystLS0tLS0KPj4+IMKgIGRyaXZlcnMvdmhvc3Qvdmhvc3QuaCB8wqAgOSArKysr
KysrKy0KPj4+IMKgIDMgZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlv
bnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJz
L3Zob3N0L3ZkcGEuYwo+Pj4gaW5kZXggYTU0YjYwZDY2MjNmLi5kZjNjZjM4NmIwY2QgMTAwNjQ0
Cj4+PiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+Pj4gKysrIGIvZHJpdmVycy92aG9zdC92
ZHBhLmMKPj4+IEBAIC05Niw3ICs5Niw3IEBAIHN0YXRpYyB2b2lkIGhhbmRsZV92cV9raWNrKHN0
cnVjdCB2aG9zdF93b3JrICp3b3JrKQo+Pj4gwqAgc3RhdGljIGlycXJldHVybl90IHZob3N0X3Zk
cGFfdmlydHF1ZXVlX2NiKHZvaWQgKnByaXZhdGUpCj4+PiDCoCB7Cj4+PiDCoMKgwqDCoMKgIHN0
cnVjdCB2aG9zdF92aXJ0cXVldWUgKnZxID0gcHJpdmF0ZTsKPj4+IC3CoMKgwqAgc3RydWN0IGV2
ZW50ZmRfY3R4ICpjYWxsX2N0eCA9IHZxLT5jYWxsX2N0eDsKPj4+ICvCoMKgwqAgc3RydWN0IGV2
ZW50ZmRfY3R4ICpjYWxsX2N0eCA9IHZxLT5jYWxsX2N0eC5jdHg7Cj4+PiDCoCDCoMKgwqDCoMKg
IGlmIChjYWxsX2N0eCkKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBldmVudGZkX3NpZ25hbChjYWxs
X2N0eCwgMSk7Cj4+PiBAQCAtMzgyLDcgKzM4Miw3IEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFf
dnJpbmdfaW9jdGwoc3RydWN0IAo+Pj4gdmhvc3RfdmRwYSAqdiwgdW5zaWduZWQgaW50IGNtZCwK
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPj4+IMKgIMKgwqDCoMKgwqAgY2FzZSBWSE9T
VF9TRVRfVlJJTkdfQ0FMTDoKPj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAodnEtPmNhbGxfY3R4KSB7
Cj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKHZxLT5jYWxsX2N0eC5jdHgpIHsKPj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGNiLmNhbGxiYWNrID0gdmhvc3RfdmRwYV92aXJ0cXVldWVfY2I7
Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjYi5wcml2YXRlID0gdnE7Cj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgfSBlbHNlIHsKPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3Zo
b3N0LmMgYi9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPj4+IGluZGV4IGQ3YjhkZjNlZGZmYy4uOWYx
YTg0NWE5MzAyIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy92aG9zdC92aG9zdC5jCj4+PiArKysg
Yi9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPj4+IEBAIC0yOTgsNiArMjk4LDEzIEBAIHN0YXRpYyB2
b2lkIHZob3N0X3ZxX21ldGFfcmVzZXQoc3RydWN0IAo+Pj4gdmhvc3RfZGV2ICpkKQo+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgIF9fdmhvc3RfdnFfbWV0YV9yZXNldChkLT52cXNbaV0pOwo+Pj4gwqAg
fQo+Pj4gwqAgK3N0YXRpYyB2b2lkIHZob3N0X3ZyaW5nX2NhbGxfcmVzZXQoc3RydWN0IHZob3N0
X3ZyaW5nX2NhbGwgCj4+PiAqY2FsbF9jdHgpCj4+PiArewo+Pj4gK8KgwqDCoCBjYWxsX2N0eC0+
Y3R4ID0gTlVMTDsKPj4+ICvCoMKgwqAgbWVtc2V0KCZjYWxsX2N0eC0+cHJvZHVjZXIsIDB4MCwg
c2l6ZW9mKHN0cnVjdCAKPj4+IGlycV9ieXBhc3NfcHJvZHVjZXIpKTsKPj4+ICvCoMKgwqAgc3Bp
bl9sb2NrX2luaXQoJmNhbGxfY3R4LT5jdHhfbG9jayk7Cj4+PiArfQo+Pj4gKwo+Pj4gwqAgc3Rh
dGljIHZvaWQgdmhvc3RfdnFfcmVzZXQoc3RydWN0IHZob3N0X2RldiAqZGV2LAo+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHZob3N0X3ZpcnRxdWV1ZSAqdnEpCj4+
PiDCoCB7Cj4+PiBAQCAtMzE5LDEzICszMjYsMTMgQEAgc3RhdGljIHZvaWQgdmhvc3RfdnFfcmVz
ZXQoc3RydWN0IHZob3N0X2RldiAqZGV2LAo+Pj4gwqDCoMKgwqDCoCB2cS0+bG9nX2Jhc2UgPSBO
VUxMOwo+Pj4gwqDCoMKgwqDCoCB2cS0+ZXJyb3JfY3R4ID0gTlVMTDsKPj4+IMKgwqDCoMKgwqAg
dnEtPmtpY2sgPSBOVUxMOwo+Pj4gLcKgwqDCoCB2cS0+Y2FsbF9jdHggPSBOVUxMOwo+Pj4gwqDC
oMKgwqDCoCB2cS0+bG9nX2N0eCA9IE5VTEw7Cj4+PiDCoMKgwqDCoMKgIHZob3N0X3Jlc2V0X2lz
X2xlKHZxKTsKPj4+IMKgwqDCoMKgwqAgdmhvc3RfZGlzYWJsZV9jcm9zc19lbmRpYW4odnEpOwo+
Pj4gwqDCoMKgwqDCoCB2cS0+YnVzeWxvb3BfdGltZW91dCA9IDA7Cj4+PiDCoMKgwqDCoMKgIHZx
LT51bWVtID0gTlVMTDsKPj4+IMKgwqDCoMKgwqAgdnEtPmlvdGxiID0gTlVMTDsKPj4+ICvCoMKg
wqAgdmhvc3RfdnJpbmdfY2FsbF9yZXNldCgmdnEtPmNhbGxfY3R4KTsKPj4+IMKgwqDCoMKgwqAg
X192aG9zdF92cV9tZXRhX3Jlc2V0KHZxKTsKPj4+IMKgIH0KPj4+IMKgIEBAIC02ODUsOCArNjky
LDggQEAgdm9pZCB2aG9zdF9kZXZfY2xlYW51cChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYpCj4+PiBl
dmVudGZkX2N0eF9wdXQoZGV2LT52cXNbaV0tPmVycm9yX2N0eCk7Cj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgaWYgKGRldi0+dnFzW2ldLT5raWNrKQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZnB1dChkZXYtPnZxc1tpXS0+a2ljayk7Cj4+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKGRldi0+
dnFzW2ldLT5jYWxsX2N0eCkKPj4+IC0gZXZlbnRmZF9jdHhfcHV0KGRldi0+dnFzW2ldLT5jYWxs
X2N0eCk7Cj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKGRldi0+dnFzW2ldLT5jYWxsX2N0eC5jdHgp
Cj4+PiArIGV2ZW50ZmRfY3R4X3B1dChkZXYtPnZxc1tpXS0+Y2FsbF9jdHguY3R4KTsKPj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCB2aG9zdF92cV9yZXNldChkZXYsIGRldi0+dnFzW2ldKTsKPj4+IMKg
wqDCoMKgwqAgfQo+Pj4gwqDCoMKgwqDCoCB2aG9zdF9kZXZfZnJlZV9pb3ZlY3MoZGV2KTsKPj4+
IEBAIC0xNjI5LDcgKzE2MzYsMTAgQEAgbG9uZyB2aG9zdF92cmluZ19pb2N0bChzdHJ1Y3Qgdmhv
c3RfZGV2ICpkLCAKPj4+IHVuc2lnbmVkIGludCBpb2N0bCwgdm9pZCBfX3VzZXIgKmFyZwo+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgciA9IFBUUl9FUlIoY3R4KTsKPj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0KPj4+IC3C
oMKgwqDCoMKgwqDCoCBzd2FwKGN0eCwgdnEtPmNhbGxfY3R4KTsKPj4+ICsKPj4+ICvCoMKgwqDC
oMKgwqDCoCBzcGluX2xvY2soJnZxLT5jYWxsX2N0eC5jdHhfbG9jayk7Cj4+PiArwqDCoMKgwqDC
oMKgwqAgc3dhcChjdHgsIHZxLT5jYWxsX2N0eC5jdHgpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIHNw
aW5fdW5sb2NrKCZ2cS0+Y2FsbF9jdHguY3R4X2xvY2spOwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
IGJyZWFrOwo+Pj4gwqDCoMKgwqDCoCBjYXNlIFZIT1NUX1NFVF9WUklOR19FUlI6Cj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgaWYgKGNvcHlfZnJvbV91c2VyKCZmLCBhcmdwLCBzaXplb2YgZikpIHsK
Pj4+IEBAIC0yNDQwLDggKzI0NTAsOCBAQCBzdGF0aWMgYm9vbCB2aG9zdF9ub3RpZnkoc3RydWN0
IHZob3N0X2RldiAKPj4+ICpkZXYsIHN0cnVjdCB2aG9zdF92aXJ0cXVldWUgKnZxKQo+Pj4gwqAg
dm9pZCB2aG9zdF9zaWduYWwoc3RydWN0IHZob3N0X2RldiAqZGV2LCBzdHJ1Y3Qgdmhvc3Rfdmly
dHF1ZXVlICp2cSkKPj4+IMKgIHsKPj4+IMKgwqDCoMKgwqAgLyogU2lnbmFsIHRoZSBHdWVzdCB0
ZWxsIHRoZW0gd2UgdXNlZCBzb21ldGhpbmcgdXAuICovCj4+PiAtwqDCoMKgIGlmICh2cS0+Y2Fs
bF9jdHggJiYgdmhvc3Rfbm90aWZ5KGRldiwgdnEpKQo+Pj4gLcKgwqDCoMKgwqDCoMKgIGV2ZW50
ZmRfc2lnbmFsKHZxLT5jYWxsX2N0eCwgMSk7Cj4+PiArwqDCoMKgIGlmICh2cS0+Y2FsbF9jdHgu
Y3R4ICYmIHZob3N0X25vdGlmeShkZXYsIHZxKSkKPj4+ICvCoMKgwqDCoMKgwqDCoCBldmVudGZk
X3NpZ25hbCh2cS0+Y2FsbF9jdHguY3R4LCAxKTsKPj4+IMKgIH0KPj4+IMKgIEVYUE9SVF9TWU1C
T0xfR1BMKHZob3N0X3NpZ25hbCk7Cj4+PiDCoCBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92
aG9zdC5oIGIvZHJpdmVycy92aG9zdC92aG9zdC5oCj4+PiBpbmRleCBjOGU5NmEwOTVkM2IuLjM4
ZWIxYWEzYjY4ZCAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuaAo+Pj4gKysr
IGIvZHJpdmVycy92aG9zdC92aG9zdC5oCj4+PiBAQCAtMTMsNiArMTMsNyBAQAo+Pj4gwqAgI2lu
Y2x1ZGUgPGxpbnV4L3ZpcnRpb19yaW5nLmg+Cj4+PiDCoCAjaW5jbHVkZSA8bGludXgvYXRvbWlj
Lmg+Cj4+PiDCoCAjaW5jbHVkZSA8bGludXgvdmhvc3RfaW90bGIuaD4KPj4+ICsjaW5jbHVkZSA8
bGludXgvaXJxYnlwYXNzLmg+Cj4+PiDCoCDCoCBzdHJ1Y3Qgdmhvc3Rfd29yazsKPj4+IMKgIHR5
cGVkZWYgdm9pZCAoKnZob3N0X3dvcmtfZm5fdCkoc3RydWN0IHZob3N0X3dvcmsgKndvcmspOwo+
Pj4gQEAgLTYwLDYgKzYxLDEyIEBAIGVudW0gdmhvc3RfdWFkZHJfdHlwZSB7Cj4+PiDCoMKgwqDC
oMKgIFZIT1NUX05VTV9BRERSUyA9IDMsCj4+PiDCoCB9Owo+Pj4gwqAgK3N0cnVjdCB2aG9zdF92
cmluZ19jYWxsIHsKPj4+ICvCoMKgwqAgc3RydWN0IGV2ZW50ZmRfY3R4ICpjdHg7Cj4+PiArwqDC
oMKgIHN0cnVjdCBpcnFfYnlwYXNzX3Byb2R1Y2VyIHByb2R1Y2VyOwo+Pj4gK8KgwqDCoCBzcGlu
bG9ja190IGN0eF9sb2NrOwo+Pgo+Pgo+PiBJdCdzIG5vdCBjbGVhciB0byBtZSB3aHkgd2UgbmVl
ZCBjdHhfbG9jayBoZXJlLgo+Pgo+PiBUaGFua3MKPiBIaSBKYXNvbiwKPgo+IHdlIHVzZSB0aGlz
IGxvY2sgdG8gcHJvdGVjdCB0aGUgZXZlbnRmZF9jdHggYW5kIGlycSBmcm9tIHJhY2UgY29uZGl0
aW9ucywKCgpXZSBkb24ndCBzdXBwb3J0IGlycSBub3RpZmljYXRpb24gZnJvbSB2RFBBIGRldmlj
ZSBkcml2ZXIgaW4gdGhpcyAKdmVyc2lvbiwgZG8gd2Ugc3RpbGwgaGF2ZSByYWNlIGNvbmRpdGlv
bj8KClRoYW5rcwoKCj4gICBhcmUgeW91IHN1Z2dlc3RpbmcgYSBiZXR0ZXIgbmFtZT8KPgo+IFRo
YW5rcwo+Pgo+Pgo+Pj4gK307Cj4+PiArCj4+PiDCoCAvKiBUaGUgdmlydHF1ZXVlIHN0cnVjdHVy
ZSBkZXNjcmliZXMgYSBxdWV1ZSBhdHRhY2hlZCB0byBhIGRldmljZS4gKi8KPj4+IMKgIHN0cnVj
dCB2aG9zdF92aXJ0cXVldWUgewo+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXY7
Cj4+PiBAQCAtNzIsNyArNzksNyBAQCBzdHJ1Y3Qgdmhvc3RfdmlydHF1ZXVlIHsKPj4+IMKgwqDC
oMKgwqAgdnJpbmdfdXNlZF90IF9fdXNlciAqdXNlZDsKPj4+IMKgwqDCoMKgwqAgY29uc3Qgc3Ry
dWN0IHZob3N0X2lvdGxiX21hcCAqbWV0YV9pb3RsYltWSE9TVF9OVU1fQUREUlNdOwo+Pj4gwqDC
oMKgwqDCoCBzdHJ1Y3QgZmlsZSAqa2ljazsKPj4+IC3CoMKgwqAgc3RydWN0IGV2ZW50ZmRfY3R4
ICpjYWxsX2N0eDsKPj4+ICvCoMKgwqAgc3RydWN0IHZob3N0X3ZyaW5nX2NhbGwgY2FsbF9jdHg7
Cj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBldmVudGZkX2N0eCAqZXJyb3JfY3R4Owo+Pj4gwqDCoMKg
wqDCoCBzdHJ1Y3QgZXZlbnRmZF9jdHggKmxvZ19jdHg7Cj4+CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
