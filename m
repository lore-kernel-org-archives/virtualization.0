Return-Path: <SRS0=WRLV=IJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83762C433E0
	for <virtualization@archiver.kernel.org>; Thu, 11 Mar 2021 06:15:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F3EB64FCE
	for <virtualization@archiver.kernel.org>; Thu, 11 Mar 2021 06:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F3EB64FCE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0DE14C8F7;
	Thu, 11 Mar 2021 06:15:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 19gDnkfuwgFI; Thu, 11 Mar 2021 06:15:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2180F45076;
	Thu, 11 Mar 2021 06:15:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3640C000B;
	Thu, 11 Mar 2021 06:15:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C857EC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 06:15:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B58D183E38
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 06:15:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4glpoXsUHO5q
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 06:15:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DD1D183E34
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 06:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615443302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EGHGtDY6oYOq4ktx0P7B3AMQkeS8BtbFf081LchZP84=;
 b=Vn9HfzsqX9qSz5fdAqwoM0ON26D8lBZ9t6ig8dahiTsMPN5rrzXgrB2QrVdlTLDahsY9g6
 EoBBO7Fnpiku6YwzgAYi7bptEIEV+//aMyaY7KCTgVqakuEElUPmboId6kC6EGdZmZ9oE5
 3qg+rrIzkX6QWivgOt+UTzhvDbVylRs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-F6FLOejKPrGzpWAcUACzDg-1; Thu, 11 Mar 2021 01:14:58 -0500
X-MC-Unique: F6FLOejKPrGzpWAcUACzDg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F68A1858F2B;
 Thu, 11 Mar 2021 06:14:57 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-9.pek2.redhat.com
 [10.72.13.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8CE062463;
 Thu, 11 Mar 2021 06:14:48 +0000 (UTC)
Subject: Re: [PATCH V3 3/6] vDPA/ifcvf: rename original IFCVF dev ids to N3000
 ids
To: Zhu Lingshan <lingshan.zhu@linux.intel.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, lulu@redhat.com,
 leonro@nvidia.com
References: <20210310090052.4762-1-lingshan.zhu@intel.com>
 <20210310090052.4762-4-lingshan.zhu@intel.com>
 <5e2b22cc-7faa-2987-a30a-ce32f10099b6@redhat.com>
 <4472d8f3-ef44-37a0-8ee1-82caa4a0a843@linux.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a14608bb-bd32-00fe-94bf-1d87361c89df@redhat.com>
Date: Thu, 11 Mar 2021 14:14:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <4472d8f3-ef44-37a0-8ee1-82caa4a0a843@linux.intel.com>
Content-Language: en-GB
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

Ck9uIDIwMjEvMy8xMSAxMjoyMyDkuIvljYgsIFpodSBMaW5nc2hhbiB3cm90ZToKPgo+Cj4gT24g
My8xMS8yMDIxIDExOjI1IEFNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pgo+PiBPbiAyMDIxLzMvMTAg
NTowMCDkuIvljYgsIFpodSBMaW5nc2hhbiB3cm90ZToKPj4+IElGQ1ZGIGRyaXZlciBwcm9iZXMg
bXVsdGlwbGUgdHlwZXMgb2YgZGV2aWNlcyBub3csCj4+PiB0byBkaXN0aW5ndWlzaCB0aGUgb3Jp
Z2luYWwgZGV2aWNlIGRyaXZlbiBieSBJRkNWRgo+Pj4gZnJvbSBvdGhlcnMsIGl0IGlzIHJlbmFt
ZWQgYXMgIk4zMDAwIi4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBaaHUgTGluZ3NoYW4gPGxpbmdz
aGFuLnpodUBpbnRlbC5jb20+Cj4+PiAtLS0KPj4+IMKgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2
Zl9iYXNlLmggfCA4ICsrKystLS0tCj4+PiDCoCBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFp
bi5jIHwgOCArKysrLS0tLQo+Pj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyks
IDggZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9p
ZmN2Zl9iYXNlLmggCj4+PiBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPj4+IGlu
ZGV4IDc1ZDlhODA1MjAzOS4uNzk0ZDE1MDVkODU3IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy92
ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+Pj4gKysrIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3Zm
X2Jhc2UuaAo+Pj4gQEAgLTE4LDEwICsxOCwxMCBAQAo+Pj4gwqAgI2luY2x1ZGUgPHVhcGkvbGlu
dXgvdmlydGlvX2NvbmZpZy5oPgo+Pj4gwqAgI2luY2x1ZGUgPHVhcGkvbGludXgvdmlydGlvX3Bj
aS5oPgo+Pj4gwqAgLSNkZWZpbmUgSUZDVkZfVkVORE9SX0lEwqDCoMKgwqDCoMKgwqAgMHgxQUY0
Cj4+PiAtI2RlZmluZSBJRkNWRl9ERVZJQ0VfSUTCoMKgwqDCoMKgwqDCoCAweDEwNDEKPj4+IC0j
ZGVmaW5lIElGQ1ZGX1NVQlNZU19WRU5ET1JfSUTCoMKgwqAgMHg4MDg2Cj4+PiAtI2RlZmluZSBJ
RkNWRl9TVUJTWVNfREVWSUNFX0lEwqDCoMKgIDB4MDAxQQo+Pj4gKyNkZWZpbmUgTjMwMDBfVkVO
RE9SX0lEwqDCoMKgwqDCoMKgwqAgMHgxQUY0Cj4+PiArI2RlZmluZSBOMzAwMF9ERVZJQ0VfSUTC
oMKgwqDCoMKgwqDCoCAweDEwNDEKPj4+ICsjZGVmaW5lIE4zMDAwX1NVQlNZU19WRU5ET1JfSUTC
oMKgwqAgMHg4MDg2Cj4+PiArI2RlZmluZSBOMzAwMF9TVUJTWVNfREVWSUNFX0lEwqDCoMKgIDB4
MDAxQQo+Pj4gwqAgwqAgI2RlZmluZSBDNTAwMFhfUExfVkVORE9SX0lEwqDCoMKgwqDCoMKgwqAg
MHgxQUY0Cj4+PiDCoCAjZGVmaW5lIEM1MDAwWF9QTF9ERVZJQ0VfSUTCoMKgwqDCoMKgwqDCoCAw
eDEwMDAKPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIAo+
Pj4gYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4+PiBpbmRleCAyNmEyZGFiN2Nh
NjYuLmZkNWJlZmM1Y2JjYyAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2
Zl9tYWluLmMKPj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPj4+IEBA
IC00ODAsMTAgKzQ4MCwxMCBAQCBzdGF0aWMgdm9pZCBpZmN2Zl9yZW1vdmUoc3RydWN0IHBjaV9k
ZXYgKnBkZXYpCj4+PiDCoCB9Cj4+PiDCoCDCoCBzdGF0aWMgc3RydWN0IHBjaV9kZXZpY2VfaWQg
aWZjdmZfcGNpX2lkc1tdID0gewo+Pj4gLcKgwqDCoCB7IFBDSV9ERVZJQ0VfU1VCKElGQ1ZGX1ZF
TkRPUl9JRCwKPj4+IC3CoMKgwqDCoMKgwqDCoCBJRkNWRl9ERVZJQ0VfSUQsCj4+PiAtwqDCoMKg
wqDCoMKgwqAgSUZDVkZfU1VCU1lTX1ZFTkRPUl9JRCwKPj4+IC3CoMKgwqDCoMKgwqDCoCBJRkNW
Rl9TVUJTWVNfREVWSUNFX0lEKSB9LAo+Pj4gK8KgwqDCoCB7IFBDSV9ERVZJQ0VfU1VCKE4zMDAw
X1ZFTkRPUl9JRCwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTjMwMDBfREVWSUNFX0lE
LAo+Pgo+Pgo+PiBJIGFtIG5vdCBzdXJlIHRoZSBwbGFuIGZvciBJbnRlbCBidXQgSSB3b25kZXIg
aWYgd2UgY2FuIHNpbXBseSB1c2UgCj4+IFBDSV9BTllfSUQgZm9yIGRldmljZSBpZCBoZXJlLiBP
dGhlcmV3aXNlIHlvdSBuZWVkIHRvIG1haW50YWluIGEgdmVyeSAKPj4gbG9uZyBsaXN0IG9mIGlk
cyBoZXJlLgo+Pgo+PiBUaGFua3MKPiBIaSBKYXNvbiwKPgo+IFRoYW5rcyEgYnV0IG1heWJlIGlm
IHdlIHByZXNlbnQgYSB2ZXJ5IHNpbXBsZSBhbmQgY2xlYXIgbGlzdCBsaWtlIHdoYXQgCj4gZTEw
MDAgZG9lcyBjYW4gaGVscCB0aGUgdXNlcnMgdW5kZXJzdGFuZCB3aGF0IHdlIHN1cHBvcnQgZWFz
aWx5Lgo+Cj4gVGhhbmtzIQoKClRoYXQncyBmaW5lLgoKVGhhbmtzCgoKPj4KPj4KPj4+ICsgTjMw
MDBfU1VCU1lTX1ZFTkRPUl9JRCwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTjMwMDBf
U1VCU1lTX0RFVklDRV9JRCkgfSwKPj4+IMKgwqDCoMKgwqAgeyBQQ0lfREVWSUNFX1NVQihDNTAw
MFhfUExfVkVORE9SX0lELAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBDNTAwMFhf
UExfREVWSUNFX0lELAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBDNTAwMFhfUExf
U1VCU1lTX1ZFTkRPUl9JRCwKPj4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
