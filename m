Return-Path: <SRS0=AynT=JM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44793C433ED
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 06:31:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B998361132
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 06:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B998361132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 65C4440FA4;
	Thu, 15 Apr 2021 06:31:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7H55q2pqa0Sg; Thu, 15 Apr 2021 06:31:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id B7FA540FA3;
	Thu, 15 Apr 2021 06:31:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92D07C000C;
	Thu, 15 Apr 2021 06:31:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B2FEC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 06:31:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 48C6B40FA4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 06:31:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 53oe8IE7F86z
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 06:31:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 36D2540FA3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 06:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618468305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kcvdl3uD8+2LgJaL7oJQC6aaLITV3ADZAkHD8ZOhfaE=;
 b=YlOvgkYPgQNqLbbqok7mfj+k8tJWdQ6btTLArbhtnrK+s87gqiC70j5tpeJjdoWQlji83R
 9iu5ekO0c9gAntud1GbF2YUg0vWvGx4DpGdEWfDPnp0ObNw9QJ3X9D2BPYjy4Sx9mErbE8
 Vamqs/L/PSkmWXxIedz1S6ybzZfymJU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-QtWbLfupOUSwdcpNPss4tw-1; Thu, 15 Apr 2021 02:31:43 -0400
X-MC-Unique: QtWbLfupOUSwdcpNPss4tw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F102501E0;
 Thu, 15 Apr 2021 06:31:42 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-61.pek2.redhat.com
 [10.72.12.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0BC795D76F;
 Thu, 15 Apr 2021 06:31:35 +0000 (UTC)
Subject: Re: [PATCH 2/3] vDPA/ifcvf: enable Intel C5000X-PL virtio-block for
 vDPA
To: Zhu Lingshan <lingshan.zhu@linux.intel.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, lulu@redhat.com,
 leonro@nvidia.com
References: <20210414091832.5132-1-lingshan.zhu@intel.com>
 <20210414091832.5132-3-lingshan.zhu@intel.com>
 <54839b05-78d2-8edf-317c-372f0ecda024@redhat.com>
 <1a1f9f50-dc92-ced3-759d-e600abca3138@linux.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c90a923f-7c8d-9a32-ce14-2370f85f1ba4@redhat.com>
Date: Thu, 15 Apr 2021 14:31:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <1a1f9f50-dc92-ced3-759d-e600abca3138@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

CuWcqCAyMDIxLzQvMTUg5LiL5Y2IMTo1NSwgWmh1IExpbmdzaGFuIOWGmemBkzoKPgo+Cj4gT24g
NC8xNS8yMDIxIDExOjM0IEFNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pgo+PiDlnKggMjAyMS80LzE0
IOS4i+WNiDU6MTgsIFpodSBMaW5nc2hhbiDlhpnpgZM6Cj4+PiBUaGlzIGNvbW1pdCBlbmFibGVk
IEludGVsIEZQR0EgU21hcnROSUMgQzUwMDBYLVBMIHZpcnRpby1ibG9jawo+Pj4gZm9yIHZEUEEu
Cj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogWmh1IExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwu
Y29tPgo+Pj4gLS0tCj4+PiDCoCBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oIHwgMTcg
KysrKysrKysrKysrKysrKy0KPj4+IMKgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMg
fCAxMCArKysrKysrKystCj4+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9p
ZmN2Zl9iYXNlLmggCj4+PiBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPj4+IGlu
ZGV4IDFjMDRjZDI1NmZhNy4uOGI0MDM1MjJiZjA2IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy92
ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+Pj4gKysrIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3Zm
X2Jhc2UuaAo+Pj4gQEAgLTE1LDYgKzE1LDcgQEAKPj4+IMKgICNpbmNsdWRlIDxsaW51eC9wY2lf
cmVncy5oPgo+Pj4gwqAgI2luY2x1ZGUgPGxpbnV4L3ZkcGEuaD4KPj4+IMKgICNpbmNsdWRlIDx1
YXBpL2xpbnV4L3ZpcnRpb19uZXQuaD4KPj4+ICsjaW5jbHVkZSA8dWFwaS9saW51eC92aXJ0aW9f
YmxrLmg+Cj4+PiDCoCAjaW5jbHVkZSA8dWFwaS9saW51eC92aXJ0aW9fY29uZmlnLmg+Cj4+PiDC
oCAjaW5jbHVkZSA8dWFwaS9saW51eC92aXJ0aW9fcGNpLmg+Cj4+PiDCoCBAQCAtMjgsNyArMjks
MTIgQEAKPj4+IMKgICNkZWZpbmUgQzUwMDBYX1BMX1NVQlNZU19WRU5ET1JfSUTCoMKgwqAgMHg4
MDg2Cj4+PiDCoCAjZGVmaW5lIEM1MDAwWF9QTF9TVUJTWVNfREVWSUNFX0lEwqDCoMKgIDB4MDAw
MQo+Pj4gwqAgLSNkZWZpbmUgSUZDVkZfU1VQUE9SVEVEX0ZFQVRVUkVTIFwKPj4+ICsjZGVmaW5l
IEM1MDAwWF9QTF9CTEtfVkVORE9SX0lEwqDCoMKgwqDCoMKgwqAgMHgxQUY0Cj4+PiArI2RlZmlu
ZSBDNTAwMFhfUExfQkxLX0RFVklDRV9JRMKgwqDCoMKgwqDCoMKgIDB4MTAwMQo+Pj4gKyNkZWZp
bmUgQzUwMDBYX1BMX0JMS19TVUJTWVNfVkVORE9SX0lEwqDCoMKgIDB4ODA4Ngo+Pj4gKyNkZWZp
bmUgQzUwMDBYX1BMX0JMS19TVUJTWVNfREVWSUNFX0lEwqDCoMKgIDB4MDAwMgo+Pj4gKwo+Pj4g
KyNkZWZpbmUgSUZDVkZfTkVUX1NVUFBPUlRFRF9GRUFUVVJFUyBcCj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgKCgxVUxMIDw8IFZJUlRJT19ORVRfRl9NQUMpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
IFwKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgICgxVUxMIDw8IFZJUlRJT19GX0FOWV9MQVlPVVQp
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IFwKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgICgxVUxM
IDw8IFZJUlRJT19GX1ZFUlNJT05fMSnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgXAo+Pj4gQEAg
LTM3LDYgKzQzLDE1IEBACj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoMVVMTCA8PCBWSVJUSU9f
Rl9BQ0NFU1NfUExBVEZPUk0pwqDCoMKgwqDCoMKgwqAgfCBcCj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAoMVVMTCA8PCBWSVJUSU9fTkVUX0ZfTVJHX1JYQlVGKSkKPj4+IMKgICsjZGVmaW5lIElG
Q1ZGX0JMS19TVVBQT1JURURfRkVBVFVSRVMgXAo+Pj4gK8KgwqDCoMKgwqDCoMKgICgoMVVMTCA8
PCBWSVJUSU9fQkxLX0ZfU0laRV9NQVgpwqDCoMKgwqDCoMKgwqAgfCBcCj4+PiArwqDCoMKgwqDC
oMKgwqDCoCAoMVVMTCA8PCBWSVJUSU9fQkxLX0ZfU0VHX01BWCnCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHwgXAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKDFVTEwgPDwgVklSVElPX0JMS19GX0JMS19T
SVpFKcKgwqDCoMKgwqDCoMKgIHwgXAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKDFVTEwgPDwgVklS
VElPX0JMS19GX1RPUE9MT0dZKcKgwqDCoMKgwqDCoMKgIHwgXAo+Pj4gK8KgwqDCoMKgwqDCoMKg
wqAgKDFVTEwgPDwgVklSVElPX0JMS19GX01RKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCBcCj4+
PiArwqDCoMKgwqDCoMKgwqDCoCAoMVVMTCA8PCBWSVJUSU9fRl9WRVJTSU9OXzEpwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8IFwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgICgxVUxMIDw8IFZJUlRJT19G
X0FDQ0VTU19QTEFURk9STSkpCj4+Cj4+Cj4+IEkgdGhpbmsgd2UndmUgZGlzY3Vzc2VkIHRoaXMg
c29tZXRpbWUgaW4gdGhlIHBhc3QgYnV0IHdoYXQncyB0aGUgCj4+IHJlYXNvbiBmb3Igc3VjaCB3
aGl0ZWxpc3QgY29uc2lkZXIgdGhlcmUncyBhbHJlYWR5IGEgZ2V0X2ZlYXR1cmVzKCkgCj4+IGlt
cGxlbWVudGlvbj8KPj4KPj4gRS5nIEFueSByZWFzb24gdG8gYmxvY2sgVklSVElPX0JMS19GX1dS
SVRFX1pFUk9TIG9yIAo+PiBWSVJUSU9fRl9SSU5HX1BBQ0tFRD8KPj4KPj4gVGhhbmtzCj4gVGhl
IHJlYXNvbiBpcyBzb21lIGZlYXR1cmUgYml0cyBhcmUgc3VwcG9ydGVkIGluIHRoZSBkZXZpY2Ug
YnV0IG5vdCAKPiBzdXBwb3J0ZWQgYnkgdGhlIGRyaXZlciwgZS5nLCBmb3IgdmlydGlvLW5ldCwg
bXEgJiBjcSBpbXBsZW1lbnRhdGlvbiAKPiBpcyBub3QgcmVhZHkgaW4gdGhlIGRyaXZlci4KCgpJ
IHVuZGVyc3RhbmQgdGhlIGNhc2Ugb2YgdmlydGlvLW5ldCBidXQgSSB3b25kZXIgd2h5IHdlIG5l
ZWQgdGhpcyBmb3IgCmJsb2NrIHdoZXJlIHdlIGRvbid0IHZxIGN2cS4KClRoYW5rcwoKCj4KPiBU
aGFua3MhCj4KPj4KPj4KPj4+ICsKPj4+IMKgIC8qIE9ubHkgb25lIHF1ZXVlIHBhaXIgZm9yIG5v
dy4gKi8KPj4+IMKgICNkZWZpbmUgSUZDVkZfTUFYX1FVRVVFX1BBSVJTwqDCoMKgIDEKPj4+IMKg
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIAo+Pj4gYi9kcml2
ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4+PiBpbmRleCA5OWIwYTZiNGMyMjcuLjliNmEz
OGI3OThmYSAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMK
Pj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPj4+IEBAIC0xNzEsNyAr
MTcxLDExIEBAIHN0YXRpYyB1NjQgaWZjdmZfdmRwYV9nZXRfZmVhdHVyZXMoc3RydWN0IAo+Pj4g
dmRwYV9kZXZpY2UgKnZkcGFfZGV2KQo+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgaWZjdmZfaHcgKnZm
ID0gdmRwYV90b192Zih2ZHBhX2Rldik7Cj4+PiDCoMKgwqDCoMKgIHU2NCBmZWF0dXJlczsKPj4+
IMKgIC3CoMKgwqAgZmVhdHVyZXMgPSBpZmN2Zl9nZXRfZmVhdHVyZXModmYpICYgSUZDVkZfU1VQ
UE9SVEVEX0ZFQVRVUkVTOwo+Pj4gK8KgwqDCoCBpZiAodmYtPmRldl90eXBlID09IFZJUlRJT19J
RF9ORVQpCj4+PiArwqDCoMKgwqDCoMKgwqAgZmVhdHVyZXMgPSBpZmN2Zl9nZXRfZmVhdHVyZXMo
dmYpICYgCj4+PiBJRkNWRl9ORVRfU1VQUE9SVEVEX0ZFQVRVUkVTOwo+Pj4gKwo+Pj4gK8KgwqDC
oCBpZiAodmYtPmRldl90eXBlID09IFZJUlRJT19JRF9CTE9DSykKPj4+ICvCoMKgwqDCoMKgwqDC
oCBmZWF0dXJlcyA9IGlmY3ZmX2dldF9mZWF0dXJlcyh2ZikgJiAKPj4+IElGQ1ZGX0JMS19TVVBQ
T1JURURfRkVBVFVSRVM7Cj4+PiDCoCDCoMKgwqDCoMKgIHJldHVybiBmZWF0dXJlczsKPj4+IMKg
IH0KPj4+IEBAIC01MDksNiArNTEzLDEwIEBAIHN0YXRpYyBzdHJ1Y3QgcGNpX2RldmljZV9pZCBp
ZmN2Zl9wY2lfaWRzW10gPSB7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEM1MDAw
WF9QTF9ERVZJQ0VfSUQsCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEM1MDAwWF9Q
TF9TVUJTWVNfVkVORE9SX0lELAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBDNTAw
MFhfUExfU1VCU1lTX0RFVklDRV9JRCkgfSwKPj4+ICvCoMKgwqAgeyBQQ0lfREVWSUNFX1NVQihD
NTAwMFhfUExfQkxLX1ZFTkRPUl9JRCwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQzUw
MDBYX1BMX0JMS19ERVZJQ0VfSUQsCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEM1MDAw
WF9QTF9CTEtfU1VCU1lTX1ZFTkRPUl9JRCwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
QzUwMDBYX1BMX0JMS19TVUJTWVNfREVWSUNFX0lEKSB9LAo+Pj4gwqAgwqDCoMKgwqDCoCB7IDAg
fSwKPj4+IMKgIH07Cj4+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
