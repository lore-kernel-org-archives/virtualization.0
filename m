Return-Path: <SRS0=+DIW=J2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010FEC433ED
	for <virtualization@archiver.kernel.org>; Thu, 29 Apr 2021 02:43:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A287613BD
	for <virtualization@archiver.kernel.org>; Thu, 29 Apr 2021 02:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A287613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F05F419C7;
	Thu, 29 Apr 2021 02:43:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f7qV58JgkNVy; Thu, 29 Apr 2021 02:43:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E3BE419C6;
	Thu, 29 Apr 2021 02:43:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 103EBC000E;
	Thu, 29 Apr 2021 02:43:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92DA9C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 02:43:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6C26F8466A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 02:43:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dD4FdhXiSBRc
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 02:43:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 63E8B84664
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 02:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619664206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I5cv0wjr53RlD6+PSvqLqxAxrszRVFuKoJYUqyZkf90=;
 b=QZ32LA1KNwHtoK1tge+p6y6Xs3LEagsNO+wzxGi+s/FHYyk565G0ARKJTGb1FbQ4wNeBMF
 bDbfX4AdFjoFQTvD5nwoaeBDfZwV8UmlTZWT1eP0UpUmo5UrXmKAPMUj6ddmc0DrTUGVvr
 05+0oHjKRIZQ8ZwfuspsdBtoUmM0LyE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-cBpPdm4QMxq_Ur7Ut9ogGA-1; Wed, 28 Apr 2021 22:43:24 -0400
X-MC-Unique: cBpPdm4QMxq_Ur7Ut9ogGA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4BAD8014C1;
 Thu, 29 Apr 2021 02:43:23 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-162.pek2.redhat.com
 [10.72.13.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D3DD5F9A6;
 Thu, 29 Apr 2021 02:43:17 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: Add support for doorbell bypassing
To: Si-Wei Liu <siwliu.kernel@gmail.com>
References: <20210421104145.115907-1-elic@nvidia.com>
 <e1885255-34f2-9e90-6478-ff0850a5a3d4@redhat.com>
 <20210422060358.GA140698@mtl-vdi-166.wap.labs.mlnx>
 <20210422080725.GB140698@mtl-vdi-166.wap.labs.mlnx>
 <9d3d8976-800d-bb14-0a4a-c4b008f6872c@redhat.com>
 <20210422083902.GA146406@mtl-vdi-166.wap.labs.mlnx>
 <bdf10e38-8746-51cf-b460-a904a133329c@redhat.com>
 <20210425132523.GA43506@mtl-vdi-166.wap.labs.mlnx>
 <086936c8-adff-d4c2-469f-2df58c4db858@redhat.com>
 <CAPWQSg35eGLr0jKEy0uVQVB0OOT7nUs_JaW2e_L9oME54nLvzQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8afce038-dbb1-7583-fe28-59f5940cfe03@redhat.com>
Date: Thu, 29 Apr 2021 10:43:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAPWQSg35eGLr0jKEy0uVQVB0OOT7nUs_JaW2e_L9oME54nLvzQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Eli Cohen <elic@nvidia.com>, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, "Zhu, Lingshan" <lingshan.zhu@intel.com>,
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

CuWcqCAyMDIxLzQvMjkg5LiK5Y2INDo1MywgU2ktV2VpIExpdSDlhpnpgZM6Cj4gT24gU3VuLCBB
cHIgMjUsIDIwMjEgYXQgNzozOCBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3
cm90ZToKPj4KPj4g5ZyoIDIwMjEvNC8yNSDkuIvljYg5OjI1LCBFbGkgQ29oZW4g5YaZ6YGTOgo+
Pj4gT24gVGh1LCBBcHIgMjIsIDIwMjEgYXQgMDQ6NTk6MTFQTSArMDgwMCwgSmFzb24gV2FuZyB3
cm90ZToKPj4+PiDlnKggMjAyMS80LzIyIOS4i+WNiDQ6MzksIEVsaSBDb2hlbiDlhpnpgZM6Cj4+
Pj4+IE9uIFRodSwgQXByIDIyLCAyMDIxIGF0IDA0OjIxOjQ1UE0gKzA4MDAsIEphc29uIFdhbmcg
d3JvdGU6Cj4+Pj4+PiDlnKggMjAyMS80LzIyIOS4i+WNiDQ6MDcsIEVsaSBDb2hlbiDlhpnpgZM6
Cj4+Pj4+Pj4gT24gVGh1LCBBcHIgMjIsIDIwMjEgYXQgMDk6MDM6NThBTSArMDMwMCwgRWxpIENv
aGVuIHdyb3RlOgo+Pj4+Pj4+PiBPbiBUaHUsIEFwciAyMiwgMjAyMSBhdCAxMDozNzozOEFNICsw
ODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+Pj4+Pj4g5ZyoIDIwMjEvNC8yMSDkuIvljYg2OjQx
LCBFbGkgQ29oZW4g5YaZ6YGTOgo+Pj4+Pj4+Pj4+IEltcGxlbWVudCBtbHg1X2dldF92cV9ub3Rp
ZmljYXRpb24oKSB0byByZXR1cm4gdGhlIGRvb3JiZWxsIGFkZHJlc3MuCj4+Pj4+Pj4+Pj4gU2l6
ZSBpcyBzZXQgdG8gb25lIHN5c3RlbSBwYWdlIGFzIHJlcXVpcmVkLgo+Pj4+Pj4+Pj4+Cj4+Pj4+
Pj4+Pj4gU2lnbmVkLW9mZi1ieTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+Cj4+Pj4+Pj4+
Pj4gLS0tCj4+Pj4+Pj4+Pj4gICAgICAgZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEu
aCB8IDEgKwo+Pj4+Pj4+Pj4+ICAgICAgIGRyaXZlcnMvdmRwYS9tbHg1L2NvcmUvcmVzb3VyY2Vz
LmMgfCAxICsKPj4+Pj4+Pj4+PiAgICAgICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0
LmMgIHwgNiArKysrKysKPj4+Pj4+Pj4+PiAgICAgICAzIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0
aW9ucygrKQo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9t
bHg1L2NvcmUvbWx4NV92ZHBhLmggYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5o
Cj4+Pj4+Pj4+Pj4gaW5kZXggYjZjYzUzYmE5ODBjLi40OWRlNjJjZGE1OTggMTAwNjQ0Cj4+Pj4+
Pj4+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaAo+Pj4+Pj4+Pj4+
ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgKPj4+Pj4+Pj4+PiBAQCAt
NDEsNiArNDEsNyBAQCBzdHJ1Y3QgbWx4NV92ZHBhX3Jlc291cmNlcyB7Cj4+Pj4+Pj4+Pj4gICAg
ICAgICB1MzIgcGRuOwo+Pj4+Pj4+Pj4+ICAgICAgICAgc3RydWN0IG1seDVfdWFyc19wYWdlICp1
YXI7Cj4+Pj4+Pj4+Pj4gICAgICAgICB2b2lkIF9faW9tZW0gKmtpY2tfYWRkcjsKPj4+Pj4+Pj4+
PiArICAgICAgdTY0IHBoeXNfa2lja19hZGRyOwo+Pj4+Pj4+Pj4+ICAgICAgICAgdTE2IHVpZDsK
Pj4+Pj4+Pj4+PiAgICAgICAgIHUzMiBudWxsX21rZXk7Cj4+Pj4+Pj4+Pj4gICAgICAgICBib29s
IHZhbGlkOwo+Pj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL3Jl
c291cmNlcy5jIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9yZXNvdXJjZXMuYwo+Pj4+Pj4+Pj4+
IGluZGV4IDY1MjFjYmQwZjVjMi4uNjY1ZjhmYzE3MTBmIDEwMDY0NAo+Pj4+Pj4+Pj4+IC0tLSBh
L2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvcmVzb3VyY2VzLmMKPj4+Pj4+Pj4+PiArKysgYi9kcml2
ZXJzL3ZkcGEvbWx4NS9jb3JlL3Jlc291cmNlcy5jCj4+Pj4+Pj4+Pj4gQEAgLTI0Nyw2ICsyNDcs
NyBAQCBpbnQgbWx4NV92ZHBhX2FsbG9jX3Jlc291cmNlcyhzdHJ1Y3QgbWx4NV92ZHBhX2RldiAq
bXZkZXYpCj4+Pj4+Pj4+Pj4gICAgICAgICAgICAgICAgIGdvdG8gZXJyX2tleTsKPj4+Pj4+Pj4+
PiAgICAgICAgIGtpY2tfYWRkciA9IG1kZXYtPmJhcl9hZGRyICsgb2Zmc2V0Owo+Pj4+Pj4+Pj4+
ICsgICAgICByZXMtPnBoeXNfa2lja19hZGRyID0ga2lja19hZGRyOwo+Pj4+Pj4+Pj4+ICAgICAg
ICAgcmVzLT5raWNrX2FkZHIgPSBpb3JlbWFwKGtpY2tfYWRkciwgUEFHRV9TSVpFKTsKPj4+Pj4+
Pj4+PiAgICAgICAgIGlmICghcmVzLT5raWNrX2FkZHIpIHsKPj4+Pj4+Pj4+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIGIvZHJpdmVycy92ZHBhL21seDUv
bmV0L21seDVfdm5ldC5jCj4+Pj4+Pj4+Pj4gaW5kZXggMTBjNWZlZjNjMDIwLi42ODA3NTEwNzRk
MmEgMTAwNjQ0Cj4+Pj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5l
dC5jCj4+Pj4+Pj4+Pj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+
Pj4+Pj4+Pj4gQEAgLTE4NjUsOCArMTg2NSwxNCBAQCBzdGF0aWMgdm9pZCBtbHg1X3ZkcGFfZnJl
ZShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpCj4+Pj4+Pj4+Pj4gICAgICAgc3RhdGljIHN0cnVj
dCB2ZHBhX25vdGlmaWNhdGlvbl9hcmVhIG1seDVfZ2V0X3ZxX25vdGlmaWNhdGlvbihzdHJ1Y3Qg
dmRwYV9kZXZpY2UgKnZkZXYsIHUxNiBpZHgpCj4+Pj4+Pj4+Pj4gICAgICAgewo+Pj4+Pj4+Pj4+
ICsgICAgICBzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYgPSB0b19tdmRldih2ZGV2KTsKPj4+
Pj4+Pj4+PiAgICAgICAgIHN0cnVjdCB2ZHBhX25vdGlmaWNhdGlvbl9hcmVhIHJldCA9IHt9Owo+
Pj4+Pj4+Pj4+ICsgICAgICBzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldjsKPj4+Pj4+Pj4+PiAr
Cj4+Pj4+Pj4+Pj4gKyAgICAgIG5kZXYgPSB0b19tbHg1X3ZkcGFfbmRldihtdmRldik7Cj4+Pj4+
Pj4+Pj4gKyAgICAgIHJldC5hZGRyID0gKHBoeXNfYWRkcl90KW5kZXYtPm12ZGV2LnJlcy5waHlz
X2tpY2tfYWRkcjsKPj4+Pj4+Pj4+PiArICAgICAgcmV0LnNpemUgPSBQQUdFX1NJWkU7Cj4+Pj4+
Pj4+PiBOb3RlIHRoYXQgdGhlIHBhZ2Ugd2lsbCBiZSBtYXBwZWQgaW4gdG8gZ3Vlc3QsIHNvIGl0
J3Mgb25seSBzYWZlIGlmIHRoZQo+Pj4+Pj4+Pj4gZG9vcmJlZWwgZXhjbHVzaXZlbHkgb3duIHRo
ZSBwYWdlLiBUaGlzIG1lYW5zIGlmIHRoZXJlJ3JlIG90aGVyIHJlZ2lzdGVycyBpbgo+Pj4+Pj4+
Pj4gdGhlIHBhZ2UsIHdlIGNhbiBub3QgbGV0IHRoZSBkb29yYmVsbCBieXBhc3MgdG8gd29yay4K
Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBTbyB0aGlzIGlzIHN1c3BpY2lvdXMgYXQgbGVhc3QgaW4gdGhl
IGNhc2Ugb2Ygc3ViZnVuY3Rpb24gd2hlcmUgd2UgY2FsY3VsYXRlCj4+Pj4+Pj4+PiB0aGUgYmFy
IGxlbmd0aCBpbiBtbHg1X3NmX2Rldl90YWJsZV9jcmVhdGUoKSBhczoKPj4+Pj4+Pj4+Cj4+Pj4+
Pj4+PiB0YWJsZS0+c2ZfYmFyX2xlbmd0aCA9IDEgPDwgKE1MWDVfQ0FQX0dFTihkZXYsIGxvZ19t
aW5fc2Zfc2l6ZSkgKyAxMik7Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gSXQgbG9va3MgdG8gbWUgdGhp
cyBjYW4gb25seSB3b3JrIGZvciB0aGUgYXJjaCB3aXRoIFBBR0VfU0laRSA9IDQwOTYsCj4+Pj4+
Pj4+PiBvdGhlcndpc2Ugd2UgY2FuIG1hcCBtb3JlIGludG8gdGhlIHVzZXJzcGFjZShndWVzdCku
Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+PiBDb3JyZWN0LCBzbyBJIGd1ZXNzIEkgc2hvdWxkIHJldHVybiBo
ZXJlIDQwOTYuCj4+Pj4+PiBJJ20gbm90IHF1aXRlIHN1cmUgYnV0IHNpbmNlIHRoZSBjYWxjdWxh
dGlvbiBvZiB0aGUgc2ZfYmFyX2xlbmd0aCBpcyBkb2VuCj4+Pj4+PiB2aWEgYSBzaGlmdCBvZiAx
MiwgaXQgbWlnaHQgYmUgY29ycmVjdC4KPj4+Pj4+Cj4+Pj4+PiBBbmQgcGxlYXNlIGRvdWJsZSBj
aGVjayBpZiB0aGUgZG9vcmJlbGwgb3duIHRoZSBwYWdlIGV4Y2x1c2l2ZWx5Lgo+Pj4+PiBJIGFt
IGNoZWNraW5nIGlmIGl0IGlzIHNhZmUgdG8gbWFwIHRoZSBhbnkgcGFydCBvZiB0aGUgU0YncyBC
QVIgdG8KPj4+Pj4gdXNlcnNwYWNlIHdpdGhvdXQgaGFybWluZyBvdGhlciBmdW5jdGlvbnMuIElm
IHRoaXMgaXMgdHJ1ZSwgSSB3aWxsIGNoZWNrCj4+Pj4+IGlmIEkgY2FuIHJldHVybiBQQUdFX1NJ
WkUgd2l0aG91dCBjb21wcm9taXNpbmcgc2VjdXJpdHkuCj4+Pj4gSXQncyB1c2FsbHkgbm90IHNh
ZmUgYW5kIGEgbGF5ZXIgdmlvbGF0aW9uIGlmIG90aGVyIHJlZ2lzdGVycyBhcmUgcGxhY2VkIGF0
Cj4+Pj4gdGhlIHNhbWUgcGFnZS4KPj4+Pgo+Pj4+Cj4+Pj4+ICAgICBJIHRoaW5rIHdlIG1heQo+
Pj4+PiBuZWVkIHRvIGV4dGVuZCBzdHJ1Y3QgdmRwYV9ub3RpZmljYXRpb25fYXJlYSB0byBjb250
YWluIGFub3RoZXIgZmllbGQKPj4+Pj4gb2Zmc2V0IHdoaWNoIGluZGljYXRlcyB0aGUgb2Zmc2V0
IGZyb20gYWRkciB3aGVyZSB0aGUgYWN0dWFsIGRvb3JiZWxsCj4+Pj4+IHJlc2lkZXMuCj4+Pj4g
VGhlIG1vdml0aWF0b24gb2YgdGhlIGN1cnJlbnQgZGVzaWduIGlzIHRvIGJlIGZpdCBzZWFtbGVz
cyBpbnRvIGhvdyBRZW11Cj4+Pj4gbW9kZWwgZG9vcmJlbGwgbGF5b3V0cyBjdXJyZW50bHk6Cj4+
Pj4KPj4+PiAxKSBwYWdlLXBlci12cSwgZWFjaCB2cSBoYXMgaXRzIG93biBwYWdlIGFsaWduZWQg
ZG9vcmJlbGwKPj4+PiAyKSAyIGJ5dGVzIGRvb3JiZWxsLCBlYWNoIHZxIGhhcyBpdHMgb3duIDIg
Ynl0ZSBhbGlnZW5kIGRvb3JiZWxsCj4+Pj4KPj4+PiBPbmx5IDEpIGlzIHN1cHBvcnQgaW4gdmhv
c3QtdkRQQSAoYW5kIHZob3N0LXVzZXIpIHNpbmNlIGl0J3MgcmF0aGVyIHNpbXBsZQo+Pj4+IGFu
ZCBzZWN1cmUgKHBhZ2UgYWxpZ25lZCkgdG8gYmUgbW9kZWxsZWQgYW5kIGltcGxlbWVudGVkIHZp
YSBtbWFwKCkuCj4+Pj4KPj4+PiBFeHBvcnRpbmcgYSBjb21wbGV4IGxheW91dCBpcyBwb3NzYmls
ZSBidXQgcmVxdWlyZXMgY2FyZWZ1bCBkZXNpZ24uCj4+Pj4KPj4+PiBBY3R1YWxseSwgd2UgaGFk
IGFudG9oZXIgb3B0aW9uCj4+Pj4KPj4+PiAzKSBzaGFyZWQgZG9vcmJlbGw6IGFsbCB2aXJ0cXVl
dWUgc2hhcmVzIGEgc2luZ2xlIHBhZ2UgYWxpZ25lZCBkb29yYmVsbAo+Pj4+Cj4+PiBUaGlzIG5l
YXJseSBtYXRjaGVzIHdlIGhhdmUgaW4gQ29ubmVjdFggZGV2aWNlcy4gQWxsIHRoZSBkb29yYmVs
bHMgYXJlCj4+PiBsb2NhdGVkIGF0IHRoZSBzYW1lIHBsYWNlLiBGb3IgNEsgcGFnZSBzaXplIGF0
Y2hpdGVjdHVyZXMgaXQgaXMgYWxpZ25lZAo+Pj4gdG8gdGhlIHN0YXJ0IG9mIHRoZSBwYWdlLiBG
b3IgbGFyZ2VyIHBhZ2Ugc2l6ZXMgaXQgaXMgbm90IGFsaWduZWQuCj4+PiBJZiB3ZSBkb24ndCBh
bGxvdyB0byBzb21lIG9mZnNldCB3aXRoaW4gdGhlIHBhZ2UsIGl0IG1lYW5zIHRoYXQgZGlyZWN0
Cj4+PiBkb29yYmVsbHMgd2lsbCBub3Qgd29yayBmb3IgNjRLIHBhZ2Ugc2l6ZSBhcmNocyBvdmVy
IENvbm5lY3RYLgo+Pgo+PiBSaWdodCwganVzdCB0byBjbGFyaWZ5LiBUaGlzIGNhbiBzdGlsbCBi
ZSBtb2RlbCBieSB0aGUgY3VycmVudAo+PiBwYWdlLXBlci12cSBtb2RlbC4gSXQgbWVhbnMgdGhl
IGRvb3JiZWxsIHdpbGwgYmUgbWFwcGVkIGludG8gZGlmZmVyZW50Cj4+IHBhZ2VzIGZvciBlYWNo
IHZpcnRxdWV1ZSBieSBRZW11LiBTbyBmcm9tIHRoZSB2aWV3IG9mIFFlbXUgb3IgZ3Vlc3QsCj4+
IGVhY2ggdmlydHF1ZXVlIGhhcyBpdHMgb3duIGRvb3JiZWxsIGluIHRoaXMgY2FzZS4KPiBTbyB0
aGlzIGlzIHRoZSBwcm9wb3NlZCBtb2RlbCBmb3IgbWx4NSB2ZHBhIHdpdGggZG9vcmJlbGwgcGVy
LWluc3RhbmNlCj4gKHJhdGhlciB0aGFuIHBlci12cSksIGFzc3VtaW5nIHRoZSBleGNsdXNpdmUg
b3duZXJzaGlwIG9mIG1hcHBlZAo+IGRvb3JiZWxsIHBhZ2U/CgoKU28gbGV0IG1lIHRyeSB0byBl
eHBsYWluIGhlcmU6CgpMZXQncyBhc3N1bWUgdGhlIG1seDUgdkRQQSBoYXMgYSBleGNsdXNpdmUg
cGFnZSB3aGljaCBpcyB1c2VkIGZvciAKZG9vcmJlbGwgZm9yIGFsbCB0aGUgdmlydHF1ZXVlcy4K
ClRoaXMgZml0cyBmb3IgdGhlIHBhZ2UtcGVyLXZxIG1vZGVsIG9mIFFlbXU6CgoxKSBUaGUgdmly
dGlvLXBjaSBkZXZpY2VzIGVtdWxhdGVkIGJ5IFFlbXUgcHJvdmlkZXMgYSBwZXIgdmlydHF1ZXVl
IApkb29yYmVsbCAob25lIHBhZ2UgcGVyIHZxKQoyKSBRZW11IHVzZSBtbWFwKCkgZm9yIG1hcCB0
aGUgZG9vcmJlbGwgc2VwYXJhdGVseQozKSBUaGUgdmhvc3QtdkRQQSBwcmVwYXJlIHRoZSBwYWdl
LCBhbmQgaW4gdGhpcyBjYXNlLCBpdCBhbHdheXMgcHJvdmlkZSAKdGhlIHNhbWUgcGFnZSBmb3Ig
dXNlcnNwYWNlL1FlbXUKNCkgU28gdmhvc3QtdkRQQSBhY3R1YWxseSBtYXAgdGhlIHNpbmdsZSBw
aHlzaWNhbCBwYWdlIGludG8gbXVsdGlwbGUgCnZpcnR1YWwgcGFnZXMgYW5kIHVzZSB0aG9zZSB2
aXJ0dWFsIHBhZ2VzIGZvciBwZXItdnEtZG9vcmJlbGwgd2l0aCB0aGUgCmhlbHAgb2YgS1ZNCjUp
IFRoZSBkZXZpY2UgY2FuIHN0aWxsIGRpc3Rpbmd1aXNoIHRoZSB2aXJ0cXVldWUgaW5kZXggc2lu
Y2UgaXQgaXMgCnJlcXVpcmVkIGFzIHRoZSB2YWx1ZSB3cm90ZSB0byB0aGUgZG9vcmJlbGwKClNv
IGl0IHNob3VsZCB3b3JrIGxpa2UgYSBjaGFybS4gRnJvbSBxZW11IHBvaW50IG9mIHZpZXcsIGl0
J3MgCnBhZ2UtcGVyLXZxLCBidXQgYXQgdGhlIHBoeXNpY2FsIGRldmljZSBsZXZlbCwgaXQncyB0
aGUgc2hhcmVkIGRvb3JiZWxsLgoKCj4KPj4KPj4+PiBUaGlzIGlzIG5vdCB5ZXQgc3VwcG9ydGVk
IGJ5IFFlbXUuCj4+Cj4+IEZvciAibm90IHN1cHBvcnRlZCIgSSBtZWFudCBwcmVzZW50IHRoaXMg
KGRvb3JiZWxscyBzaGFyaW5nKSBsYXlvdXQgdG8KPj4gZ3Vlc3QuCj4gU28gaXQgbWVhbnMgdGhp
cyBuZXcgbGF5b3V0IHBlcmhhcHMgd2lsbCBoYXZlIHRvIGludHJvZHVjZSBuZXcgdmlydGlvCj4g
ZmVhdHVyZXMgdG8gZ3Vlc3QgdGh1cyBub3QgY29tcGF0aWJsZSB3aXRoIGVpeHN0aW5nIGRyaXZl
cj8KCgpDb25zaWRlciBwYWdlLXBlci12cSBtb2RlbCB3b3JrcywgSSBkb24ndCB0aGluayB3ZSBu
ZWVkIHRvIGludHJvZHVjZSBhIAp1c2Vyc3BhY2Ugbm90aWNlYWJsZSBzaGFyZWQgZG9vcmJlbGwg
bW9kZWwuIFRoZSBkZXRhaWxzIHdlcmUgaGlkZGVuIApwZXJmZWN0bHkgd2l0aCB0aGUgaGVscCBv
ZiB2aG9zdC12RFBBIGFuZCBpdCBwcm92aWRlcyBleHRyYSBmbGV4aWJpbGl0eS4gClRoZSBtYXBw
aW5nIGlzIGRvbmUgcGVyIHZxIHZpYToKCm1tYXAoTlVMTCwgdnFfaW5kZXggPDwgUEFHRV9TSVpF
KTsKClVzZXJzcGFjZSBjYW4gZGVjaWRlIHRvOgoKMSkgb25seSBtYXAgcGFydCBvZiB0aGUgdmly
dHF1ZXVlLCB0aGlzIGlzIHZlcnkgaW1wb3J0YW50IGZvciB0aGUgY2FzZSAKd2hlbiBRZW11IHdh
bnQgdG8gaW50ZXJjZXB0IHRoZSB2aXJ0cXVldWUgdHJhbnNhY3Rpb25zIHdoZW4gd2Ugd2FudCB0
byAKaW1wbGVtZW50IGNvbnRyb2wgdnEgb3Igc2hhZG93IHZxCjIpIGRldmljZXMgY2FuIHNlbGVj
dGl2ZWx5IHByb3ZpZGUgZG9vcmJlbGwgbWFwcGluZyBiYXNlZCBvbiB0aGUgdnEgaW5kZXgKCkV4
cG9ydGluZyBvdGhlciBsYXlvdXQgaXMgcG9zc2libGUgYnV0IGl0IHdpbGwgcmVxdWlyZSBhIGNh
cmVmdWwgZGVzaWduIApvZiB0aGUgdUFQSSBhbmQgd2lsbCBjb21wbGljYXRlIHRoZSBtYW5hZ2Vt
ZW50IHN0dWZmIChtaWdyYXRpb24gCmNvbXBhdGliaWxpdHkgZXNwZWNpYWxseSkuCgpUaGFua3MK
Cgo+Cj4gLVNpd2VpCj4+IFRoYW5rcwo+Pgo+Pgo+Pj4+IFRoYW5rcwo+Pj4+Cj4+Pj4KPj4+Pj4+
Pj4gSSBhbHNvIHRoaW5rIHRoYXQgdGhlIGNoZWNrIGluIHZob3N0X3ZkcGFfbW1hcCgpIHNob3Vs
ZCB2ZXJpZnkgdGhhdCB0aGUKPj4+Pj4+Pj4gcmV0dXJuZWQgc2l6ZSBpcyBub3Qgc21hbGxlciB0
aGFuIFBBR0VfU0laRSBiZWNhdXNlIHRoZSByZXR1cm5lZCBhZGRyZXNzCj4+Pj4+Pj4gQWN0dWFs
bHkgSSB0aGluayBpdCdzIG9rIHNpbmNlIHlvdSB2ZXJpZnkgdGhlIHNpemUgZXF1YWxzIHZtYS0+
dm1fZW5kIC0KPj4+Pj4+PiB2bWEtPnZtX3N0YXJ0IHdoaWNoIG11c3QgYmUgYXQgbGVhc3QgUEFH
RV9TSVpFLgo+Pj4+Pj4gWWVzLgo+Pj4+Pj4KPj4+Pj4+IFRoYW5rcwo+Pj4+Pj4KPj4+Pj4+Cj4+
Pj4+Pj4+IG1pZ2h0IGp1c3QgYmUgYWxpZ25lZCB0byBQQUdFX1NJWkUuIEkgdGhpbmsgdGhpcyBz
aG91bGQgYmUgZW5vZ2h0IGJ1dAo+Pj4+Pj4+PiBtYXliZSBhbHNvIHVzZSB0aGUgc2FtZSBsb2dp
YyBpbiB2aG9zdF92ZHBhX2ZhdWx0KCkuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
