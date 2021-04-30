Return-Path: <SRS0=eK/B=J3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC04C433ED
	for <virtualization@archiver.kernel.org>; Fri, 30 Apr 2021 07:03:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C657A613F7
	for <virtualization@archiver.kernel.org>; Fri, 30 Apr 2021 07:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C657A613F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6CE1343107;
	Fri, 30 Apr 2021 07:03:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aTnVClCviJKo; Fri, 30 Apr 2021 07:03:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 93ECF40212;
	Fri, 30 Apr 2021 07:03:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28F48C000E;
	Fri, 30 Apr 2021 07:03:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A84DAC0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Apr 2021 07:03:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5E5FD41B43
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Apr 2021 07:03:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Oqq3JoK5O0xx
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Apr 2021 07:03:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D087D41B3F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Apr 2021 07:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619766197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ev+FiH0qOrXUckbdDN0f3TiSYH0KxnX5cJCySBReIKw=;
 b=EnrQQimngAybrFDpeGLn5W9Jjqv7DqfY8jViTtdaphdkTZloaftouV3y8X98U+1XBSp1uD
 tOLZ93GjCotJwRC3SQjAKKQjbfjAVC4ESawsR7TW1u99CFFUdEemQQtsWoo7s7hU0A3z+5
 tauMYVmOY7YUaO91kcfseZrmvoXEee4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-myIhA6HXOU-mKfNKDX_j3g-1; Fri, 30 Apr 2021 03:03:14 -0400
X-MC-Unique: myIhA6HXOU-mKfNKDX_j3g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE8601008062;
 Fri, 30 Apr 2021 07:03:13 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-175.pek2.redhat.com
 [10.72.12.175])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 697EF70588;
 Fri, 30 Apr 2021 07:03:08 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: Add support for doorbell bypassing
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, Eli Cohen <elic@nvidia.com>
References: <20210421104145.115907-1-elic@nvidia.com>
 <e1885255-34f2-9e90-6478-ff0850a5a3d4@redhat.com>
 <20210422060358.GA140698@mtl-vdi-166.wap.labs.mlnx>
 <20210422080725.GB140698@mtl-vdi-166.wap.labs.mlnx>
 <9d3d8976-800d-bb14-0a4a-c4b008f6872c@redhat.com>
 <20210422083902.GA146406@mtl-vdi-166.wap.labs.mlnx>
 <bdf10e38-8746-51cf-b460-a904a133329c@redhat.com>
 <20210429100033.GA215200@mtl-vdi-166.wap.labs.mlnx>
 <fc887d99-7058-1057-2d1a-3bdc5802a59a@redhat.com>
 <836263af-6791-0bd3-22c7-22197da021e9@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <79d57f53-a5c9-58df-4a79-6cc7892ab1a2@redhat.com>
Date: Fri, 30 Apr 2021 15:03:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <836263af-6791-0bd3-22c7-22197da021e9@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
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

CuWcqCAyMDIxLzQvMzAg5LiL5Y2IMjozMSwgWmh1LCBMaW5nc2hhbiDlhpnpgZM6Cj4KPgo+IE9u
IDQvMzAvMjAyMSAxMjo0MCBQTSwgSmFzb24gV2FuZyB3cm90ZToKPj4KPj4g5ZyoIDIwMjEvNC8y
OSDkuIvljYg2OjAwLCBFbGkgQ29oZW4g5YaZ6YGTOgo+Pj4gT24gVGh1LCBBcHIgMjIsIDIwMjEg
YXQgMDQ6NTk6MTFQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+PiDlnKggMjAyMS80LzIy
IOS4i+WNiDQ6MzksIEVsaSBDb2hlbiDlhpnpgZM6Cj4+Pj4+IE9uIFRodSwgQXByIDIyLCAyMDIx
IGF0IDA0OjIxOjQ1UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+Pj4+PiDlnKggMjAyMS80
LzIyIOS4i+WNiDQ6MDcsIEVsaSBDb2hlbiDlhpnpgZM6Cj4+Pj4+Pj4gT24gVGh1LCBBcHIgMjIs
IDIwMjEgYXQgMDk6MDM6NThBTSArMDMwMCwgRWxpIENvaGVuIHdyb3RlOgo+Pj4+Pj4+PiBPbiBU
aHUsIEFwciAyMiwgMjAyMSBhdCAxMDozNzozOEFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+
Pj4+Pj4+Pj4g5ZyoIDIwMjEvNC8yMSDkuIvljYg2OjQxLCBFbGkgQ29oZW4g5YaZ6YGTOgo+Pj4+
Pj4+Pj4+IEltcGxlbWVudCBtbHg1X2dldF92cV9ub3RpZmljYXRpb24oKSB0byByZXR1cm4gdGhl
IGRvb3JiZWxsIAo+Pj4+Pj4+Pj4+IGFkZHJlc3MuCj4+Pj4+Pj4+Pj4gU2l6ZSBpcyBzZXQgdG8g
b25lIHN5c3RlbSBwYWdlIGFzIHJlcXVpcmVkLgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gU2lnbmVk
LW9mZi1ieTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+Cj4+Pj4+Pj4+Pj4gLS0tCj4+Pj4+
Pj4+Pj4gwqDCoMKgwqAgZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaCB8IDEgKwo+
Pj4+Pj4+Pj4+IMKgwqDCoMKgIGRyaXZlcnMvdmRwYS9tbHg1L2NvcmUvcmVzb3VyY2VzLmMgfCAx
ICsKPj4+Pj4+Pj4+PiDCoMKgwqDCoCBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmPC
oCB8IDYgKysrKysrCj4+Pj4+Pj4+Pj4gwqDCoMKgwqAgMyBmaWxlcyBjaGFuZ2VkLCA4IGluc2Vy
dGlvbnMoKykKPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEv
bWx4NS9jb3JlL21seDVfdmRwYS5oIAo+Pj4+Pj4+Pj4+IGIvZHJpdmVycy92ZHBhL21seDUvY29y
ZS9tbHg1X3ZkcGEuaAo+Pj4+Pj4+Pj4+IGluZGV4IGI2Y2M1M2JhOTgwYy4uNDlkZTYyY2RhNTk4
IDEwMDY0NAo+Pj4+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBh
LmgKPj4+Pj4+Pj4+PiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oCj4+
Pj4+Pj4+Pj4gQEAgLTQxLDYgKzQxLDcgQEAgc3RydWN0IG1seDVfdmRwYV9yZXNvdXJjZXMgewo+
Pj4+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqAgdTMyIHBkbjsKPj4+Pj4+Pj4+PiDCoMKgwqDCoMKg
wqDCoMKgIHN0cnVjdCBtbHg1X3VhcnNfcGFnZSAqdWFyOwo+Pj4+Pj4+Pj4+IMKgwqDCoMKgwqDC
oMKgwqAgdm9pZCBfX2lvbWVtICpraWNrX2FkZHI7Cj4+Pj4+Pj4+Pj4gK8KgwqDCoCB1NjQgcGh5
c19raWNrX2FkZHI7Cj4+Pj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCB1MTYgdWlkOwo+Pj4+Pj4+
Pj4+IMKgwqDCoMKgwqDCoMKgwqAgdTMyIG51bGxfbWtleTsKPj4+Pj4+Pj4+PiDCoMKgwqDCoMKg
wqDCoMKgIGJvb2wgdmFsaWQ7Cj4+Pj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9t
bHg1L2NvcmUvcmVzb3VyY2VzLmMgCj4+Pj4+Pj4+Pj4gYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3Jl
L3Jlc291cmNlcy5jCj4+Pj4+Pj4+Pj4gaW5kZXggNjUyMWNiZDBmNWMyLi42NjVmOGZjMTcxMGYg
MTAwNjQ0Cj4+Pj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9yZXNvdXJjZXMu
Ywo+Pj4+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvcmVzb3VyY2VzLmMKPj4+
Pj4+Pj4+PiBAQCAtMjQ3LDYgKzI0Nyw3IEBAIGludCBtbHg1X3ZkcGFfYWxsb2NfcmVzb3VyY2Vz
KHN0cnVjdCAKPj4+Pj4+Pj4+PiBtbHg1X3ZkcGFfZGV2ICptdmRldikKPj4+Pj4+Pj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJfa2V5Owo+Pj4+Pj4+Pj4+IMKgwqDCoMKgwqDC
oMKgwqAga2lja19hZGRyID0gbWRldi0+YmFyX2FkZHIgKyBvZmZzZXQ7Cj4+Pj4+Pj4+Pj4gK8Kg
wqDCoCByZXMtPnBoeXNfa2lja19hZGRyID0ga2lja19hZGRyOwo+Pj4+Pj4+Pj4+IMKgwqDCoMKg
wqDCoMKgwqAgcmVzLT5raWNrX2FkZHIgPSBpb3JlbWFwKGtpY2tfYWRkciwgUEFHRV9TSVpFKTsK
Pj4+Pj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgIGlmICghcmVzLT5raWNrX2FkZHIpIHsKPj4+Pj4+
Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIAo+Pj4+
Pj4+Pj4+IGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+Pj4+Pj4+Pj4gaW5k
ZXggMTBjNWZlZjNjMDIwLi42ODA3NTEwNzRkMmEgMTAwNjQ0Cj4+Pj4+Pj4+Pj4gLS0tIGEvZHJp
dmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+Pj4+Pj4+Pj4gKysrIGIvZHJpdmVycy92
ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+Pj4+Pj4+Pj4gQEAgLTE4NjUsOCArMTg2NSwxNCBA
QCBzdGF0aWMgdm9pZCBtbHg1X3ZkcGFfZnJlZShzdHJ1Y3QgCj4+Pj4+Pj4+Pj4gdmRwYV9kZXZp
Y2UgKnZkZXYpCj4+Pj4+Pj4+Pj4gwqDCoMKgwqAgc3RhdGljIHN0cnVjdCB2ZHBhX25vdGlmaWNh
dGlvbl9hcmVhIAo+Pj4+Pj4+Pj4+IG1seDVfZ2V0X3ZxX25vdGlmaWNhdGlvbihzdHJ1Y3QgdmRw
YV9kZXZpY2UgKnZkZXYsIHUxNiBpZHgpCj4+Pj4+Pj4+Pj4gwqDCoMKgwqAgewo+Pj4+Pj4+Pj4+
ICvCoMKgwqAgc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2ID0gdG9fbXZkZXYodmRldik7Cj4+
Pj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgdmRwYV9ub3RpZmljYXRpb25fYXJlYSBy
ZXQgPSB7fTsKPj4+Pj4+Pj4+PiArwqDCoMKgIHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2Owo+
Pj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4+PiArwqDCoMKgIG5kZXYgPSB0b19tbHg1X3ZkcGFfbmRldiht
dmRldik7Cj4+Pj4+Pj4+Pj4gK8KgwqDCoCByZXQuYWRkciA9IChwaHlzX2FkZHJfdCluZGV2LT5t
dmRldi5yZXMucGh5c19raWNrX2FkZHI7Cj4+Pj4+Pj4+Pj4gK8KgwqDCoCByZXQuc2l6ZSA9IFBB
R0VfU0laRTsKPj4+Pj4+Pj4+IE5vdGUgdGhhdCB0aGUgcGFnZSB3aWxsIGJlIG1hcHBlZCBpbiB0
byBndWVzdCwgc28gaXQncyBvbmx5IAo+Pj4+Pj4+Pj4gc2FmZSBpZiB0aGUKPj4+Pj4+Pj4+IGRv
b3JiZWVsIGV4Y2x1c2l2ZWx5IG93biB0aGUgcGFnZS4gVGhpcyBtZWFucyBpZiB0aGVyZSdyZSAK
Pj4+Pj4+Pj4+IG90aGVyIHJlZ2lzdGVycyBpbgo+Pj4+Pj4+Pj4gdGhlIHBhZ2UsIHdlIGNhbiBu
b3QgbGV0IHRoZSBkb29yYmVsbCBieXBhc3MgdG8gd29yay4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBT
byB0aGlzIGlzIHN1c3BpY2lvdXMgYXQgbGVhc3QgaW4gdGhlIGNhc2Ugb2Ygc3ViZnVuY3Rpb24g
Cj4+Pj4+Pj4+PiB3aGVyZSB3ZSBjYWxjdWxhdGUKPj4+Pj4+Pj4+IHRoZSBiYXIgbGVuZ3RoIGlu
IG1seDVfc2ZfZGV2X3RhYmxlX2NyZWF0ZSgpIGFzOgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IHRhYmxl
LT5zZl9iYXJfbGVuZ3RoID0gMSA8PCAoTUxYNV9DQVBfR0VOKGRldiwgCj4+Pj4+Pj4+PiBsb2df
bWluX3NmX3NpemUpICsgMTIpOwo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IEl0IGxvb2tzIHRvIG1lIHRo
aXMgY2FuIG9ubHkgd29yayBmb3IgdGhlIGFyY2ggd2l0aCBQQUdFX1NJWkUgCj4+Pj4+Pj4+PiA9
IDQwOTYsCj4+Pj4+Pj4+PiBvdGhlcndpc2Ugd2UgY2FuIG1hcCBtb3JlIGludG8gdGhlIHVzZXJz
cGFjZShndWVzdCkuCj4+Pj4+Pj4+Pgo+Pj4+Pj4+PiBDb3JyZWN0LCBzbyBJIGd1ZXNzIEkgc2hv
dWxkIHJldHVybiBoZXJlIDQwOTYuCj4+Pj4+PiBJJ20gbm90IHF1aXRlIHN1cmUgYnV0IHNpbmNl
IHRoZSBjYWxjdWxhdGlvbiBvZiB0aGUgc2ZfYmFyX2xlbmd0aCAKPj4+Pj4+IGlzIGRvZW4KPj4+
Pj4+IHZpYSBhIHNoaWZ0IG9mIDEyLCBpdCBtaWdodCBiZSBjb3JyZWN0Lgo+Pj4+Pj4KPj4+Pj4+
IEFuZCBwbGVhc2UgZG91YmxlIGNoZWNrIGlmIHRoZSBkb29yYmVsbCBvd24gdGhlIHBhZ2UgZXhj
bHVzaXZlbHkuCj4+Pj4+IEkgYW0gY2hlY2tpbmcgaWYgaXQgaXMgc2FmZSB0byBtYXAgdGhlIGFu
eSBwYXJ0IG9mIHRoZSBTRidzIEJBUiB0bwo+Pj4+PiB1c2Vyc3BhY2Ugd2l0aG91dCBoYXJtaW5n
IG90aGVyIGZ1bmN0aW9ucy4gSWYgdGhpcyBpcyB0cnVlLCBJIHdpbGwgCj4+Pj4+IGNoZWNrCj4+
Pj4+IGlmIEkgY2FuIHJldHVybiBQQUdFX1NJWkUgd2l0aG91dCBjb21wcm9taXNpbmcgc2VjdXJp
dHkuCj4+Pj4KPj4+PiBJdCdzIHVzYWxseSBub3Qgc2FmZSBhbmQgYSBsYXllciB2aW9sYXRpb24g
aWYgb3RoZXIgcmVnaXN0ZXJzIGFyZSAKPj4+PiBwbGFjZWQgYXQKPj4+PiB0aGUgc2FtZSBwYWdl
Lgo+Pj4+Cj4+Pj4KPj4+Pj4gwqDCoCBJIHRoaW5rIHdlIG1heQo+Pj4+PiBuZWVkIHRvIGV4dGVu
ZCBzdHJ1Y3QgdmRwYV9ub3RpZmljYXRpb25fYXJlYSB0byBjb250YWluIGFub3RoZXIgZmllbGQK
Pj4+Pj4gb2Zmc2V0IHdoaWNoIGluZGljYXRlcyB0aGUgb2Zmc2V0IGZyb20gYWRkciB3aGVyZSB0
aGUgYWN0dWFsIGRvb3JiZWxsCj4+Pj4+IHJlc2lkZXMuCj4+Pj4KPj4+PiBUaGUgbW92aXRpYXRv
biBvZiB0aGUgY3VycmVudCBkZXNpZ24gaXMgdG8gYmUgZml0IHNlYW1sZXNzIGludG8gaG93IAo+
Pj4+IFFlbXUKPj4+PiBtb2RlbCBkb29yYmVsbCBsYXlvdXRzIGN1cnJlbnRseToKPj4+Pgo+Pj4+
IDEpIHBhZ2UtcGVyLXZxLCBlYWNoIHZxIGhhcyBpdHMgb3duIHBhZ2UgYWxpZ25lZCBkb29yYmVs
bAo+Pj4+IDIpIDIgYnl0ZXMgZG9vcmJlbGwsIGVhY2ggdnEgaGFzIGl0cyBvd24gMiBieXRlIGFs
aWdlbmQgZG9vcmJlbGwKPj4+Pgo+Pj4+IE9ubHkgMSkgaXMgc3VwcG9ydCBpbiB2aG9zdC12RFBB
IChhbmQgdmhvc3QtdXNlcikgc2luY2UgaXQncyByYXRoZXIgCj4+Pj4gc2ltcGxlCj4+Pj4gYW5k
IHNlY3VyZSAocGFnZSBhbGlnbmVkKSB0byBiZSBtb2RlbGxlZCBhbmQgaW1wbGVtZW50ZWQgdmlh
IG1tYXAoKS4KPj4+Pgo+Pj4+IEV4cG9ydGluZyBhIGNvbXBsZXggbGF5b3V0IGlzIHBvc3NiaWxl
IGJ1dCByZXF1aXJlcyBjYXJlZnVsIGRlc2lnbi4KPj4+Pgo+Pj4+IEFjdHVhbGx5LCB3ZSBoYWQg
YW50b2hlciBvcHRpb24KPj4+Pgo+Pj4+IDMpIHNoYXJlZCBkb29yYmVsbDogYWxsIHZpcnRxdWV1
ZSBzaGFyZXMgYSBzaW5nbGUgcGFnZSBhbGlnbmVkIAo+Pj4+IGRvb3JiZWxsCj4+PiBJIGFtIG5v
dCBzdXJlIGhvdyB0aGlzIGNvdWxkIHNvbHZlIHRoZSBwcm9ibGVtIG9mIDY0S0IgYXJjaHMuCj4+
PiBUaGUgcG9pbnQgaXMgdGhhdCBpbiBDb25uZWN0WCBkZXZpY2VzLCB0aGUgdmlydGlvIHF1ZXVl
IG9iamVjdHMgCj4+PiBkb29yYmVsbAo+Pj4gaXMgYWxpZ25lZCB0byA0Sy4gRm9yIGxhcmdlciBz
eXN0ZW0gcGFnZSBzaXplcywgdGhlIGRvb3JiZWxsIG1heSBub3QgYmUKPj4+IGFsaWduZWQgdG8g
YSBzeXN0ZW0gcGFnZS4KPj4+IFNvIGl0IHNlZW1zIG5vdCB0b28gY29tcGxleCB0byBpbnRyb2R1
Y2Ugb2Zmc2V0IHdpdGhpbiB0aGUgcGFnZS4KPj4KPj4KPj4gVGhyZWUgbWFqb3IgaXNzdWVzOgo+
Pgo+PiAxKSBzaW5nbGUgbW1hcCgpIHdvcmtzIGF0IHBhZ2UgbGV2ZWwsIGl0IG1lYW5zIHdlIG5l
ZWQgbWFwIDY0SyB0byAKPj4gZ3Vlc3QgYW5kIHdlIGNhbiBvbmx5IGRvIHRoaXMgc2FmZWx5IGlm
IG5vIG90aGVyIHJlZ2lzdGVycyBhcmUgcGxhY2VkIAo+PiBpbnRvIHRoZSBzYW1lIHBhZ2UKPj4g
MikgbmV3IHVBUEkgdG8gbGV0IHRoZSB1c2Vyc3BhY2Uga25vdyB0aGUgb2Zmc2V0Cj4+IDMpIGhv
dyB0byBtb2RlbCB0aGVtIHdpdGggdGhlIHZpcnRpby1wY2kgaW4gUWVtdSwgYW5kIHRoaXMgbWF5
IAo+PiBpbnRyb2R1Y2UgYnVyZGVucyBmb3IgbWFuYWdlbWVudCAobmVlZCBzb21lIGNoYW5nZXMg
aW4gdGhlIHFlbXUgCj4+IGNvbW1hbmQgbGluZSkgdG8gZGVhbCB3aXRoIHRoZSBtaWdyYXRpb24g
Y29tcGF0aWJpbGl0eQo+Pgo+PiBTbyBjb25zaWRlciB0aGUgY29tcGxleGl0eSwgd2UgY2FuIGp1
c3Qgc3RpY2sgdG8gdGhlIGN1cnJlbnQgY29kZS4gCj4+IFRoYXQgbWVhbnMgbW1hcCgpIHdpbGwg
ZmFpbCBhbmQgcWVtdSB3aWxsIGtlZXAgdXNpbmcgdGhlIGV2ZW50ZmQgCj4+IGJhc2VkIGtpY2su
Cj4gVGhlcmUgaXMgYW5vdGhlciBjYXNlLCBtbWFwKCkgd29ya3MgYXQgcGFnZSBsZXZlbCwgcGFn
ZSBzaXplIGlzIGF0IAo+IGxlYXN0IDRLLiBDb25zaWRlciBpZiBhIGRldmljZSBoYXMgYSBiYXIg
Y29udGFpbmluZyB0aGUgc2hhcmVkIAo+IGRvb3JiZWxsIHBhZ2UgYXQgaXRzIGxhc3QgNEsgc3Bh
Y2UuIEluIHRoaXMgYmFyIGxheW91dCwgbWFwIGEgCj4gYXJjaC5wYWdlX3NpemU9NjRLIHBhZ2Ug
dG8gdXNlcnNhcGNlIHdvdWxkIGxlYWQgdG8gZmF0YWwgZXJyb3JzLgoKCldoeSBpdCdzIGEgZmF0
YWwgZXJyb3I/IFVzZXJzcGFjZSBzaG91bGQgc3Vydml2ZSBmcm9tIG1tYXAoKSBlcnJvcnMgYW5k
IAprZWVwIHVzaW5nIHRoZSBraWNrZmQuCgoKPiBJIHRoaW5rIHdlIGNhbiBhc3NpZ24gdGhlIGFj
dHVhbCBzaXplIG9mIHRoZSBkb29yYmVsbCBhcmVhIHNpemUgdG8gCj4gdmRwYV9ub3RpZmljYXRp
b24uc2l6ZSB0aGFuIGFyY2gucGFnZV9zaXplIHRvIGF2b2lkIHN1Y2ggaXNzdWVzLiBUaGVuIAo+
IHVwcGVyIGxheWVycyBsaWtlIHZob3N0X3ZkcGEgc2hvdWxkIGNoZWNrIHdoZXRoZXIgdGhpcyBz
aXplIGNhbiB3b3JrIAo+IHdpdGggdGhlIG1hY2hpbmUgYXJjaCBhbmQgaXRzIGFsaWdubWVudCwg
aWYgbm90LCBzaG91bGQgZmFpbCBvdmVyIHRvIAo+IHVzZSBldmVudGZkLgoKCklzbid0IHRoaXMg
aG93IGdldF92ZXRfbm90aWZpY2F0aW9uKCkgZGVzaWduZWQgYW5kIGltcGxlbWVudGVkIHJpZ2h0
IApub3c/IFdoYXQgcGFyZW50IG5lZWQgaXMganVzdCB0byByZXBvcnQgdGhlIGRvb3JiZWxsIHNp
emUsIGl0J3MgdGhlIGJ1cyAKZHJpdmVyICh2aG9zdC12RFBBKSB0byBkZWNpZGUgaWYgYW5kIGhv
dyBpdCBpcyB1c2VkLgoKVGhhbmtzCgoKPiBUaGVuIGRvIHdlIHN0aWxsIG5lZWQgYSB1QVBJIHRl
bGwgdGhlIG9mZnNldCB3aXRoaW4gdGhlIHBhZ2U/Cj4KPiBUaGFua3MKPiBaaHUgTGluZ3NoYW4K
Pj4KPj4KPj4KPj4+Cj4+PiBCVFcsIGZvciBub3csIEkgYW0gZ29pbmcgdG8gc2VuZCBhbm90aGVy
IHBhdGNoIHRoYXQgbWFrZXMgc3VyZSBwYWdlCj4+PiBib3VuZGFyaWVzIGFyZSBub3QgdmlsYXRl
ZC4gSXQgcmVxdWlyZXMgc29tZSBzdXBwb3J0IGZyb20gbWx4NV9jb3JlCj4+PiB3aGljaCBpcyBj
dXJyZW50bHkgYmVpbmcgcmV2aWV3ZWQgaW50ZXJuYWxseS4KPj4KPj4KPj4gU3VyZS4KPj4KPj4g
VGhhbmtzCj4+Cj4+Cj4+Pgo+Pj4+IFRoaXMgaXMgbm90IHlldCBzdXBwb3J0ZWQgYnkgUWVtdS4K
Pj4+Pgo+Pj4+IFRoYW5rcwo+Pj4+Cj4+Pj4KPj4+Pj4+Pj4gSSBhbHNvIHRoaW5rIHRoYXQgdGhl
IGNoZWNrIGluIHZob3N0X3ZkcGFfbW1hcCgpIHNob3VsZCB2ZXJpZnkgCj4+Pj4+Pj4+IHRoYXQg
dGhlCj4+Pj4+Pj4+IHJldHVybmVkIHNpemUgaXMgbm90IHNtYWxsZXIgdGhhbiBQQUdFX1NJWkUg
YmVjYXVzZSB0aGUgCj4+Pj4+Pj4+IHJldHVybmVkIGFkZHJlc3MKPj4+Pj4+PiBBY3R1YWxseSBJ
IHRoaW5rIGl0J3Mgb2sgc2luY2UgeW91IHZlcmlmeSB0aGUgc2l6ZSBlcXVhbHMgCj4+Pj4+Pj4g
dm1hLT52bV9lbmQgLQo+Pj4+Pj4+IHZtYS0+dm1fc3RhcnQgd2hpY2ggbXVzdCBiZSBhdCBsZWFz
dCBQQUdFX1NJWkUuCj4+Pj4+PiBZZXMuCj4+Pj4+Pgo+Pj4+Pj4gVGhhbmtzCj4+Pj4+Pgo+Pj4+
Pj4KPj4+Pj4+Pj4gbWlnaHQganVzdCBiZSBhbGlnbmVkIHRvIFBBR0VfU0laRS4gSSB0aGluayB0
aGlzIHNob3VsZCBiZSAKPj4+Pj4+Pj4gZW5vZ2h0IGJ1dAo+Pj4+Pj4+PiBtYXliZSBhbHNvIHVz
ZSB0aGUgc2FtZSBsb2dpYyBpbiB2aG9zdF92ZHBhX2ZhdWx0KCkuCj4+Cj4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
