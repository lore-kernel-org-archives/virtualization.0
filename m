Return-Path: <SRS0=eK/B=J3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563A6C433B4
	for <virtualization@archiver.kernel.org>; Fri, 30 Apr 2021 13:50:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BF5661554
	for <virtualization@archiver.kernel.org>; Fri, 30 Apr 2021 13:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF5661554
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 17D6B418CA;
	Fri, 30 Apr 2021 13:50:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F6mo023GuDiY; Fri, 30 Apr 2021 13:50:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F185418CB;
	Fri, 30 Apr 2021 13:50:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F05ECC000D;
	Fri, 30 Apr 2021 13:50:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08D54C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Apr 2021 13:50:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EB96E40278
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Apr 2021 13:50:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w6_xYR4u4p_7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Apr 2021 13:50:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B7EE540225
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Apr 2021 13:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619790606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O2j5F4fhc46JGejyh96okpN24V0XsQ1KpEWdcsoSTK0=;
 b=CnmX+SEGAzZi9T72+rscI3e9PJG9dsIi8HiQPKKxHBbbfKo9s7Hv8SO4Qiwi/xW1cRaOS6
 XFBitiZrFWYxVm2YpdL/yl+vUhDDmc8JdZ5iNxEbckFY+Hgt1mNXXRmpNe5T8lEYO6fXuM
 xrGRr97LSxi658f0GA83JgHfPxfPbnc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-V8kcEtmoMBSUQFSPzOG68g-1; Fri, 30 Apr 2021 09:50:04 -0400
X-MC-Unique: V8kcEtmoMBSUQFSPzOG68g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8CE7107ACCA;
 Fri, 30 Apr 2021 13:50:02 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-38.pek2.redhat.com
 [10.72.12.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 778B15D9E2;
 Fri, 30 Apr 2021 13:49:56 +0000 (UTC)
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
 <79d57f53-a5c9-58df-4a79-6cc7892ab1a2@redhat.com>
 <35c30715-f24b-704c-af3c-2b0259c2fd43@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2b5dc35a-13ee-863f-16cb-cc6a96d7f738@redhat.com>
Date: Fri, 30 Apr 2021 21:49:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <35c30715-f24b-704c-af3c-2b0259c2fd43@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

CuWcqCAyMDIxLzQvMzAg5LiL5Y2INToyNSwgWmh1LCBMaW5nc2hhbiDlhpnpgZM6Cj4KPgo+IE9u
IDQvMzAvMjAyMSAzOjAzIFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pgo+PiDlnKggMjAyMS80LzMw
IOS4i+WNiDI6MzEsIFpodSwgTGluZ3NoYW4g5YaZ6YGTOgo+Pj4KPj4+Cj4+PiBPbiA0LzMwLzIw
MjEgMTI6NDAgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4+Pj4KPj4+PiDlnKggMjAyMS80LzI5IOS4
i+WNiDY6MDAsIEVsaSBDb2hlbiDlhpnpgZM6Cj4+Pj4+IE9uIFRodSwgQXByIDIyLCAyMDIxIGF0
IDA0OjU5OjExUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+Pj4+PiDlnKggMjAyMS80LzIy
IOS4i+WNiDQ6MzksIEVsaSBDb2hlbiDlhpnpgZM6Cj4+Pj4+Pj4gT24gVGh1LCBBcHIgMjIsIDIw
MjEgYXQgMDQ6MjE6NDVQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pj4+Pj4g5ZyoIDIw
MjEvNC8yMiDkuIvljYg0OjA3LCBFbGkgQ29oZW4g5YaZ6YGTOgo+Pj4+Pj4+Pj4gT24gVGh1LCBB
cHIgMjIsIDIwMjEgYXQgMDk6MDM6NThBTSArMDMwMCwgRWxpIENvaGVuIHdyb3RlOgo+Pj4+Pj4+
Pj4+IE9uIFRodSwgQXByIDIyLCAyMDIxIGF0IDEwOjM3OjM4QU0gKzA4MDAsIEphc29uIFdhbmcg
d3JvdGU6Cj4+Pj4+Pj4+Pj4+IOWcqCAyMDIxLzQvMjEg5LiL5Y2INjo0MSwgRWxpIENvaGVuIOWG
memBkzoKPj4+Pj4+Pj4+Pj4+IEltcGxlbWVudCBtbHg1X2dldF92cV9ub3RpZmljYXRpb24oKSB0
byByZXR1cm4gdGhlIGRvb3JiZWxsIAo+Pj4+Pj4+Pj4+Pj4gYWRkcmVzcy4KPj4+Pj4+Pj4+Pj4+
IFNpemUgaXMgc2V0IHRvIG9uZSBzeXN0ZW0gcGFnZSBhcyByZXF1aXJlZC4KPj4+Pj4+Pj4+Pj4+
Cj4+Pj4+Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4K
Pj4+Pj4+Pj4+Pj4+IC0tLQo+Pj4+Pj4+Pj4+Pj4gwqDCoMKgwqAgZHJpdmVycy92ZHBhL21seDUv
Y29yZS9tbHg1X3ZkcGEuaCB8IDErCj4+Pj4+Pj4+Pj4+PiDCoMKgwqDCoCBkcml2ZXJzL3ZkcGEv
bWx4NS9jb3JlL3Jlc291cmNlcy5jIHwgMSsKPj4+Pj4+Pj4+Pj4+IMKgwqDCoMKgIGRyaXZlcnMv
dmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuY8KgIHwgNiArKysrKysKPj4+Pj4+Pj4+Pj4+IMKgwqDC
oMKgIDMgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspCj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+
Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmggCj4+
Pj4+Pj4+Pj4+PiBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgKPj4+Pj4+Pj4+
Pj4+IGluZGV4IGI2Y2M1M2JhOTgwYy4uNDlkZTYyY2RhNTk4IDEwMDY0NAo+Pj4+Pj4+Pj4+Pj4g
LS0tIGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaAo+Pj4+Pj4+Pj4+Pj4gKysr
IGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaAo+Pj4+Pj4+Pj4+Pj4gQEAgLTQx
LDYgKzQxLDcgQEAgc3RydWN0IG1seDVfdmRwYV9yZXNvdXJjZXMgewo+Pj4+Pj4+Pj4+Pj4gwqDC
oMKgwqDCoMKgwqDCoCB1MzIgcGRuOwo+Pj4+Pj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCBzdHJ1
Y3QgbWx4NV91YXJzX3BhZ2UgKnVhcjsKPj4+Pj4+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqAgdm9p
ZCBfX2lvbWVtICpraWNrX2FkZHI7Cj4+Pj4+Pj4+Pj4+PiArwqDCoMKgIHU2NCBwaHlzX2tpY2tf
YWRkcjsKPj4+Pj4+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqAgdTE2IHVpZDsKPj4+Pj4+Pj4+Pj4+
IMKgwqDCoMKgwqDCoMKgwqAgdTMyIG51bGxfbWtleTsKPj4+Pj4+Pj4+Pj4+IMKgwqDCoMKgwqDC
oMKgwqAgYm9vbCB2YWxpZDsKPj4+Pj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEv
bWx4NS9jb3JlL3Jlc291cmNlcy5jIAo+Pj4+Pj4+Pj4+Pj4gYi9kcml2ZXJzL3ZkcGEvbWx4NS9j
b3JlL3Jlc291cmNlcy5jCj4+Pj4+Pj4+Pj4+PiBpbmRleCA2NTIxY2JkMGY1YzIuLjY2NWY4ZmMx
NzEwZiAxMDA2NDQKPj4+Pj4+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvcmVz
b3VyY2VzLmMKPj4+Pj4+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvcmVzb3Vy
Y2VzLmMKPj4+Pj4+Pj4+Pj4+IEBAIC0yNDcsNiArMjQ3LDcgQEAgaW50IG1seDVfdmRwYV9hbGxv
Y19yZXNvdXJjZXMoc3RydWN0IAo+Pj4+Pj4+Pj4+Pj4gbWx4NV92ZHBhX2RldiAqbXZkZXYpCj4+
Pj4+Pj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJfa2V5Owo+Pj4+Pj4+
Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCBraWNrX2FkZHIgPSBtZGV2LT5iYXJfYWRkciArIG9mZnNl
dDsKPj4+Pj4+Pj4+Pj4+ICvCoMKgwqAgcmVzLT5waHlzX2tpY2tfYWRkciA9IGtpY2tfYWRkcjsK
Pj4+Pj4+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqAgcmVzLT5raWNrX2FkZHI9IGlvcmVtYXAoa2lj
a19hZGRyLCBQQUdFX1NJWkUpOwo+Pj4+Pj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAoIXJl
cy0+a2lja19hZGRyKSB7Cj4+Pj4+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21s
eDUvbmV0L21seDVfdm5ldC5jIAo+Pj4+Pj4+Pj4+Pj4gYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQv
bWx4NV92bmV0LmMKPj4+Pj4+Pj4+Pj4+IGluZGV4IDEwYzVmZWYzYzAyMC4uNjgwNzUxMDc0ZDJh
IDEwMDY0NAo+Pj4+Pj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5l
dC5jCj4+Pj4+Pj4+Pj4+PiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMK
Pj4+Pj4+Pj4+Pj4+IEBAIC0xODY1LDggKzE4NjUsMTQgQEAgc3RhdGljIHZvaWQgbWx4NV92ZHBh
X2ZyZWUoc3RydWN0IAo+Pj4+Pj4+Pj4+Pj4gdmRwYV9kZXZpY2UgKnZkZXYpCj4+Pj4+Pj4+Pj4+
PiDCoMKgwqDCoCBzdGF0aWMgc3RydWN0IHZkcGFfbm90aWZpY2F0aW9uX2FyZWEgCj4+Pj4+Pj4+
Pj4+PiBtbHg1X2dldF92cV9ub3RpZmljYXRpb24oc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1
MTYgaWR4KQo+Pj4+Pj4+Pj4+Pj4gwqDCoMKgwqAgewo+Pj4+Pj4+Pj4+Pj4gK8KgwqDCoCBzdHJ1
Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYgPSB0b19tdmRldih2ZGV2KTsKPj4+Pj4+Pj4+Pj4+IMKg
wqDCoMKgwqDCoMKgwqAgc3RydWN0IHZkcGFfbm90aWZpY2F0aW9uX2FyZWEgcmV0ID0ge307Cj4+
Pj4+Pj4+Pj4+PiArwqDCoMKgIHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2Owo+Pj4+Pj4+Pj4+
Pj4gKwo+Pj4+Pj4+Pj4+Pj4gK8KgwqDCoCBuZGV2ID0gdG9fbWx4NV92ZHBhX25kZXYobXZkZXYp
Owo+Pj4+Pj4+Pj4+Pj4gK8KgwqDCoCByZXQuYWRkciA9IChwaHlzX2FkZHJfdCluZGV2LT5tdmRl
di5yZXMucGh5c19raWNrX2FkZHI7Cj4+Pj4+Pj4+Pj4+PiArwqDCoMKgIHJldC5zaXplID0gUEFH
RV9TSVpFOwo+Pj4+Pj4+Pj4+PiBOb3RlIHRoYXQgdGhlIHBhZ2Ugd2lsbCBiZSBtYXBwZWQgaW4g
dG8gZ3Vlc3QsIHNvIGl0J3Mgb25seSAKPj4+Pj4+Pj4+Pj4gc2FmZSBpZiB0aGUKPj4+Pj4+Pj4+
Pj4gZG9vcmJlZWwgZXhjbHVzaXZlbHkgb3duIHRoZSBwYWdlLiBUaGlzIG1lYW5zIGlmIHRoZXJl
J3JlIAo+Pj4+Pj4+Pj4+PiBvdGhlciByZWdpc3RlcnMgaW4KPj4+Pj4+Pj4+Pj4gdGhlIHBhZ2Us
IHdlIGNhbiBub3QgbGV0IHRoZSBkb29yYmVsbCBieXBhc3MgdG8gd29yay4KPj4+Pj4+Pj4+Pj4K
Pj4+Pj4+Pj4+Pj4gU28gdGhpcyBpcyBzdXNwaWNpb3VzIGF0IGxlYXN0IGluIHRoZSBjYXNlIG9m
IHN1YmZ1bmN0aW9uIAo+Pj4+Pj4+Pj4+PiB3aGVyZSB3ZSBjYWxjdWxhdGUKPj4+Pj4+Pj4+Pj4g
dGhlIGJhciBsZW5ndGggaW4gbWx4NV9zZl9kZXZfdGFibGVfY3JlYXRlKCkgYXM6Cj4+Pj4+Pj4+
Pj4+Cj4+Pj4+Pj4+Pj4+IHRhYmxlLT5zZl9iYXJfbGVuZ3RoID0gMSA8PCAoTUxYNV9DQVBfR0VO
KGRldiwgCj4+Pj4+Pj4+Pj4+IGxvZ19taW5fc2Zfc2l6ZSkgKyAxMik7Cj4+Pj4+Pj4+Pj4+Cj4+
Pj4+Pj4+Pj4+IEl0IGxvb2tzIHRvIG1lIHRoaXMgY2FuIG9ubHkgd29yayBmb3IgdGhlIGFyY2gg
d2l0aCAKPj4+Pj4+Pj4+Pj4gUEFHRV9TSVpFID0gNDA5NiwKPj4+Pj4+Pj4+Pj4gb3RoZXJ3aXNl
IHdlIGNhbiBtYXAgbW9yZSBpbnRvIHRoZSB1c2Vyc3BhY2UoZ3Vlc3QpLgo+Pj4+Pj4+Pj4+Pgo+
Pj4+Pj4+Pj4+IENvcnJlY3QsIHNvIEkgZ3Vlc3MgSSBzaG91bGQgcmV0dXJuIGhlcmUgNDA5Ni4K
Pj4+Pj4+Pj4gSSdtIG5vdCBxdWl0ZSBzdXJlIGJ1dCBzaW5jZSB0aGUgY2FsY3VsYXRpb24gb2Yg
dGhlIAo+Pj4+Pj4+PiBzZl9iYXJfbGVuZ3RoIGlzIGRvZW4KPj4+Pj4+Pj4gdmlhIGEgc2hpZnQg
b2YgMTIsIGl0IG1pZ2h0IGJlIGNvcnJlY3QuCj4+Pj4+Pj4+Cj4+Pj4+Pj4+IEFuZCBwbGVhc2Ug
ZG91YmxlIGNoZWNrIGlmIHRoZSBkb29yYmVsbCBvd24gdGhlIHBhZ2UgZXhjbHVzaXZlbHkuCj4+
Pj4+Pj4gSSBhbSBjaGVja2luZyBpZiBpdCBpcyBzYWZlIHRvIG1hcCB0aGUgYW55IHBhcnQgb2Yg
dGhlIFNGJ3MgQkFSIHRvCj4+Pj4+Pj4gdXNlcnNwYWNlIHdpdGhvdXQgaGFybWluZyBvdGhlciBm
dW5jdGlvbnMuIElmIHRoaXMgaXMgdHJ1ZSwgSSAKPj4+Pj4+PiB3aWxsIGNoZWNrCj4+Pj4+Pj4g
aWYgSSBjYW4gcmV0dXJuIFBBR0VfU0laRSB3aXRob3V0IGNvbXByb21pc2luZyBzZWN1cml0eS4K
Pj4+Pj4+Cj4+Pj4+PiBJdCdzIHVzYWxseSBub3Qgc2FmZSBhbmQgYSBsYXllciB2aW9sYXRpb24g
aWYgb3RoZXIgcmVnaXN0ZXJzIGFyZSAKPj4+Pj4+IHBsYWNlZCBhdAo+Pj4+Pj4gdGhlIHNhbWUg
cGFnZS4KPj4+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4+IMKgwqAgSSB0aGluayB3ZSBtYXkKPj4+Pj4+PiBu
ZWVkIHRvIGV4dGVuZCBzdHJ1Y3QgdmRwYV9ub3RpZmljYXRpb25fYXJlYSB0byBjb250YWluIGFu
b3RoZXIgCj4+Pj4+Pj4gZmllbGQKPj4+Pj4+PiBvZmZzZXQgd2hpY2ggaW5kaWNhdGVzIHRoZSBv
ZmZzZXQgZnJvbSBhZGRyIHdoZXJlIHRoZSBhY3R1YWwgCj4+Pj4+Pj4gZG9vcmJlbGwKPj4+Pj4+
PiByZXNpZGVzLgo+Pj4+Pj4KPj4+Pj4+IFRoZSBtb3ZpdGlhdG9uIG9mIHRoZSBjdXJyZW50IGRl
c2lnbiBpcyB0byBiZSBmaXQgc2VhbWxlc3MgaW50byAKPj4+Pj4+IGhvdyBRZW11Cj4+Pj4+PiBt
b2RlbCBkb29yYmVsbCBsYXlvdXRzIGN1cnJlbnRseToKPj4+Pj4+Cj4+Pj4+PiAxKSBwYWdlLXBl
ci12cSwgZWFjaCB2cSBoYXMgaXRzIG93biBwYWdlIGFsaWduZWQgZG9vcmJlbGwKPj4+Pj4+IDIp
IDIgYnl0ZXMgZG9vcmJlbGwsIGVhY2ggdnEgaGFzIGl0cyBvd24gMiBieXRlIGFsaWdlbmQgZG9v
cmJlbGwKPj4+Pj4+Cj4+Pj4+PiBPbmx5IDEpIGlzIHN1cHBvcnQgaW4gdmhvc3QtdkRQQSAoYW5k
IHZob3N0LXVzZXIpIHNpbmNlIGl0J3MgCj4+Pj4+PiByYXRoZXIgc2ltcGxlCj4+Pj4+PiBhbmQg
c2VjdXJlIChwYWdlIGFsaWduZWQpIHRvIGJlIG1vZGVsbGVkIGFuZCBpbXBsZW1lbnRlZCB2aWEg
bW1hcCgpLgo+Pj4+Pj4KPj4+Pj4+IEV4cG9ydGluZyBhIGNvbXBsZXggbGF5b3V0IGlzIHBvc3Ni
aWxlIGJ1dCByZXF1aXJlcyBjYXJlZnVsIGRlc2lnbi4KPj4+Pj4+Cj4+Pj4+PiBBY3R1YWxseSwg
d2UgaGFkIGFudG9oZXIgb3B0aW9uCj4+Pj4+Pgo+Pj4+Pj4gMykgc2hhcmVkIGRvb3JiZWxsOiBh
bGwgdmlydHF1ZXVlIHNoYXJlcyBhIHNpbmdsZSBwYWdlIGFsaWduZWQgCj4+Pj4+PiBkb29yYmVs
bAo+Pj4+PiBJIGFtIG5vdCBzdXJlIGhvdyB0aGlzIGNvdWxkIHNvbHZlIHRoZSBwcm9ibGVtIG9m
IDY0S0IgYXJjaHMuCj4+Pj4+IFRoZSBwb2ludCBpcyB0aGF0IGluIENvbm5lY3RYIGRldmljZXMs
IHRoZSB2aXJ0aW8gcXVldWUgb2JqZWN0cyAKPj4+Pj4gZG9vcmJlbGwKPj4+Pj4gaXMgYWxpZ25l
ZCB0byA0Sy4gRm9yIGxhcmdlciBzeXN0ZW0gcGFnZSBzaXplcywgdGhlIGRvb3JiZWxsIG1heSAK
Pj4+Pj4gbm90IGJlCj4+Pj4+IGFsaWduZWQgdG8gYSBzeXN0ZW0gcGFnZS4KPj4+Pj4gU28gaXQg
c2VlbXMgbm90IHRvbyBjb21wbGV4IHRvIGludHJvZHVjZSBvZmZzZXQgd2l0aGluIHRoZSBwYWdl
Lgo+Pj4+Cj4+Pj4KPj4+PiBUaHJlZSBtYWpvciBpc3N1ZXM6Cj4+Pj4KPj4+PiAxKSBzaW5nbGUg
bW1hcCgpIHdvcmtzIGF0IHBhZ2UgbGV2ZWwsIGl0IG1lYW5zIHdlIG5lZWQgbWFwIDY0SyB0byAK
Pj4+PiBndWVzdCBhbmQgd2UgY2FuIG9ubHkgZG8gdGhpcyBzYWZlbHkgaWYgbm8gb3RoZXIgcmVn
aXN0ZXJzIGFyZSAKPj4+PiBwbGFjZWQgaW50byB0aGUgc2FtZSBwYWdlCj4+Pj4gMikgbmV3IHVB
UEkgdG8gbGV0IHRoZSB1c2Vyc3BhY2Uga25vdyB0aGUgb2Zmc2V0Cj4+Pj4gMykgaG93IHRvIG1v
ZGVsIHRoZW0gd2l0aCB0aGUgdmlydGlvLXBjaSBpbiBRZW11LCBhbmQgdGhpcyBtYXkgCj4+Pj4g
aW50cm9kdWNlIGJ1cmRlbnMgZm9yIG1hbmFnZW1lbnQgKG5lZWQgc29tZSBjaGFuZ2VzIGluIHRo
ZSBxZW11IAo+Pj4+IGNvbW1hbmQgbGluZSkgdG8gZGVhbCB3aXRoIHRoZSBtaWdyYXRpb24gY29t
cGF0aWJpbGl0eQo+Pj4+Cj4+Pj4gU28gY29uc2lkZXIgdGhlIGNvbXBsZXhpdHksIHdlIGNhbiBq
dXN0IHN0aWNrIHRvIHRoZSBjdXJyZW50IGNvZGUuIAo+Pj4+IFRoYXQgbWVhbnMgbW1hcCgpIHdp
bGwgZmFpbCBhbmQgcWVtdSB3aWxsIGtlZXAgdXNpbmcgdGhlIGV2ZW50ZmQgCj4+Pj4gYmFzZWQg
a2ljay4KPj4+IFRoZXJlIGlzIGFub3RoZXIgY2FzZSwgbW1hcCgpIHdvcmtzIGF0IHBhZ2UgbGV2
ZWwsIHBhZ2Ugc2l6ZSBpcyBhdCAKPj4+IGxlYXN0IDRLLiBDb25zaWRlciBpZiBhIGRldmljZSBo
YXMgYSBiYXIgY29udGFpbmluZyB0aGUgc2hhcmVkIAo+Pj4gZG9vcmJlbGwgcGFnZSBhdCBpdHMg
bGFzdCA0SyBzcGFjZS4gSW4gdGhpcyBiYXIgbGF5b3V0LCBtYXAgYSAKPj4+IGFyY2gucGFnZV9z
aXplPTY0SyBwYWdlIHRvIHVzZXJzYXBjZSB3b3VsZCBsZWFkIHRvIGZhdGFsIGVycm9ycy4KPj4K
Pj4KPj4gV2h5IGl0J3MgYSBmYXRhbCBlcnJvcj8gVXNlcnNwYWNlIHNob3VsZCBzdXJ2aXZlIGZy
b20gbW1hcCgpIGVycm9ycyAKPj4gYW5kIGtlZXAgdXNpbmcgdGhlIGtpY2tmZC4KPiBJIG1lYW4g
dmhvc3QtdmRwYSBzaG91bGQgbm90IG9ubHkgY2hlY2sgdGhlIGFsaWdubWVudCwgYWxzbyBuZWVk
IHRvIAo+IGNoZWNrIHdoZXRoZXIgdGhlIGRvb3JiZWxsIHNpemUgbm8gbGVzcyB0aGFuIGEgYXJj
aC5wYWdlX3NpemUuIAoKClRoZSBjb2RlIGhhcyBhbHJlYWR5IGRpZCB0aGlzLCBpc24ndCBpdD8K
CiDCoMKgwqDCoMKgwqDCoCBpZiAodm1hLT52bV9lbmQgLSB2bWEtPnZtX3N0YXJ0ICE9IFBBR0Vf
U0laRSkKIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTlZBTDsKCi4u
LgoKIMKgwqDCoMKgwqDCoMKgIG5vdGlmeSA9IG9wcy0+Z2V0X3ZxX25vdGlmaWNhdGlvbih2ZHBh
LCBpbmRleCk7CiDCoMKgwqDCoMKgwqDCoCBpZiAobm90aWZ5LmFkZHIgJiAoUEFHRV9TSVpFIC0g
MSkpCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7CiDCoMKg
wqDCoMKgwqDCoCBpZiAodm1hLT52bV9lbmQgLSB2bWEtPnZtX3N0YXJ0ICE9IG5vdGlmeS5zaXpl
KQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5PVFNVUFA7CgoKPiBJ
ZiB0aGUgZG9vcmJlbGwgcGxhY2VkIGF0IHRoZSBsYXN0IDRLIGluIGJhciwgbWFwIDY0ayBwYWdl
IGNvdWxkIGJlIGFuIAo+IGVycm9yLgoKCm1tYXAoKSB3aWxsIGZhaWwgaW4gdGhpcyBjYXNlLgoK
VGhhbmtzCgoKPgo+IFRoYW5rcwo+Pgo+Pgo+Pj4gSSB0aGluayB3ZSBjYW4gYXNzaWduIHRoZSBh
Y3R1YWwgc2l6ZSBvZiB0aGUgZG9vcmJlbGwgYXJlYSBzaXplIHRvIAo+Pj4gdmRwYV9ub3RpZmlj
YXRpb24uc2l6ZSB0aGFuIGFyY2gucGFnZV9zaXplIHRvIGF2b2lkIHN1Y2ggaXNzdWVzLiAKPj4+
IFRoZW4gdXBwZXIgbGF5ZXJzIGxpa2Ugdmhvc3RfdmRwYSBzaG91bGQgY2hlY2sgd2hldGhlciB0
aGlzIHNpemUgY2FuIAo+Pj4gd29yayB3aXRoIHRoZSBtYWNoaW5lIGFyY2ggYW5kIGl0cyBhbGln
bm1lbnQsIGlmIG5vdCwgc2hvdWxkIGZhaWwgCj4+PiBvdmVyIHRvIHVzZSBldmVudGZkLgo+Pgo+
Pgo+PiBJc24ndCB0aGlzIGhvdyBnZXRfdmV0X25vdGlmaWNhdGlvbigpIGRlc2lnbmVkIGFuZCBp
bXBsZW1lbnRlZCByaWdodCAKPj4gbm93PyBXaGF0IHBhcmVudCBuZWVkIGlzIGp1c3QgdG8gcmVw
b3J0IHRoZSBkb29yYmVsbCBzaXplLCBpdCdzIHRoZSAKPj4gYnVzIGRyaXZlciAodmhvc3QtdkRQ
QSkgdG8gZGVjaWRlIGlmIGFuZCBob3cgaXQgaXMgdXNlZC4KPj4KPj4gVGhhbmtzCj4+Cj4+Cj4+
PiBUaGVuIGRvIHdlIHN0aWxsIG5lZWQgYSB1QVBJIHRlbGwgdGhlIG9mZnNldCB3aXRoaW4gdGhl
IHBhZ2U/Cj4+Pgo+Pj4gVGhhbmtzCj4+PiBaaHUgTGluZ3NoYW4KPj4+Pgo+Pj4+Cj4+Pj4KPj4+
Pj4KPj4+Pj4gQlRXLCBmb3Igbm93LCBJIGFtIGdvaW5nIHRvIHNlbmQgYW5vdGhlciBwYXRjaCB0
aGF0IG1ha2VzIHN1cmUgcGFnZQo+Pj4+PiBib3VuZGFyaWVzIGFyZSBub3QgdmlsYXRlZC4gSXQg
cmVxdWlyZXMgc29tZSBzdXBwb3J0IGZyb20gbWx4NV9jb3JlCj4+Pj4+IHdoaWNoIGlzIGN1cnJl
bnRseSBiZWluZyByZXZpZXdlZCBpbnRlcm5hbGx5Lgo+Pj4+Cj4+Pj4KPj4+PiBTdXJlLgo+Pj4+
Cj4+Pj4gVGhhbmtzCj4+Pj4KPj4+Pgo+Pj4+Pgo+Pj4+Pj4gVGhpcyBpcyBub3QgeWV0IHN1cHBv
cnRlZCBieSBRZW11Lgo+Pj4+Pj4KPj4+Pj4+IFRoYW5rcwo+Pj4+Pj4KPj4+Pj4+Cj4+Pj4+Pj4+
Pj4gSSBhbHNvIHRoaW5rIHRoYXQgdGhlIGNoZWNrIGluIHZob3N0X3ZkcGFfbW1hcCgpIHNob3Vs
ZCAKPj4+Pj4+Pj4+PiB2ZXJpZnkgdGhhdCB0aGUKPj4+Pj4+Pj4+PiByZXR1cm5lZCBzaXplIGlz
IG5vdCBzbWFsbGVyIHRoYW4gUEFHRV9TSVpFIGJlY2F1c2UgdGhlIAo+Pj4+Pj4+Pj4+IHJldHVy
bmVkIGFkZHJlc3MKPj4+Pj4+Pj4+IEFjdHVhbGx5IEkgdGhpbmsgaXQncyBvayBzaW5jZSB5b3Ug
dmVyaWZ5IHRoZSBzaXplIGVxdWFscyAKPj4+Pj4+Pj4+IHZtYS0+dm1fZW5kIC0KPj4+Pj4+Pj4+
IHZtYS0+dm1fc3RhcnQgd2hpY2ggbXVzdCBiZSBhdCBsZWFzdCBQQUdFX1NJWkUuCj4+Pj4+Pj4+
IFllcy4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gVGhhbmtzCj4+Pj4+Pj4+Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+
Pj4gbWlnaHQganVzdCBiZSBhbGlnbmVkIHRvIFBBR0VfU0laRS4gSSB0aGluayB0aGlzIHNob3Vs
ZCBiZSAKPj4+Pj4+Pj4+PiBlbm9naHQgYnV0Cj4+Pj4+Pj4+Pj4gbWF5YmUgYWxzbyB1c2UgdGhl
IHNhbWUgbG9naWMgaW4gdmhvc3RfdmRwYV9mYXVsdCgpLgo+Pj4+Cj4+Pgo+Pgo+CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
