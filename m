Return-Path: <SRS0=T/77=JT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045FDC433B4
	for <virtualization@archiver.kernel.org>; Thu, 22 Apr 2021 08:22:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56B816144A
	for <virtualization@archiver.kernel.org>; Thu, 22 Apr 2021 08:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B816144A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D5A8D605F8;
	Thu, 22 Apr 2021 08:22:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qj6_bRu1OmpI; Thu, 22 Apr 2021 08:22:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6519760651;
	Thu, 22 Apr 2021 08:22:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33023C000F;
	Thu, 22 Apr 2021 08:22:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56EEDC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 08:22:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 51C3440EC9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 08:22:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IySEDACEP2fI
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 08:22:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 48A0E40EC4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 08:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619079731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yAx76mnYnGhhIuzx6Pr3JPcipkIJwQ+OWbLTwHC2ewU=;
 b=HUjWZeT8ddQrMdOvfEm8dMTiObhCDCjxTFfsnsxL40CWmULFW/pPuLbQwsfswrWowVNneM
 GriPpJKizDxj5WnsojipgfXueYXd5rTjXC0ny9gcODlz7QUBi6OhDQTkjA2uBH85uegxQj
 9DWDPSECEfrp34K9lyfjK01MuxsIm6g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-jpioROeLOmu8Td8UCjxkEQ-1; Thu, 22 Apr 2021 04:22:08 -0400
X-MC-Unique: jpioROeLOmu8Td8UCjxkEQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7921388CE36;
 Thu, 22 Apr 2021 08:21:49 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-214.pek2.redhat.com
 [10.72.13.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 198EB63623;
 Thu, 22 Apr 2021 08:21:46 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: Add support for doorbell bypassing
To: Eli Cohen <elic@nvidia.com>
References: <20210421104145.115907-1-elic@nvidia.com>
 <e1885255-34f2-9e90-6478-ff0850a5a3d4@redhat.com>
 <20210422060358.GA140698@mtl-vdi-166.wap.labs.mlnx>
 <20210422080725.GB140698@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9d3d8976-800d-bb14-0a4a-c4b008f6872c@redhat.com>
Date: Thu, 22 Apr 2021 16:21:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210422080725.GB140698@mtl-vdi-166.wap.labs.mlnx>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

CuWcqCAyMDIxLzQvMjIg5LiL5Y2INDowNywgRWxpIENvaGVuIOWGmemBkzoKPiBPbiBUaHUsIEFw
ciAyMiwgMjAyMSBhdCAwOTowMzo1OEFNICswMzAwLCBFbGkgQ29oZW4gd3JvdGU6Cj4+IE9uIFRo
dSwgQXByIDIyLCAyMDIxIGF0IDEwOjM3OjM4QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+
PiDlnKggMjAyMS80LzIxIOS4i+WNiDY6NDEsIEVsaSBDb2hlbiDlhpnpgZM6Cj4+Pj4gSW1wbGVt
ZW50IG1seDVfZ2V0X3ZxX25vdGlmaWNhdGlvbigpIHRvIHJldHVybiB0aGUgZG9vcmJlbGwgYWRk
cmVzcy4KPj4+PiBTaXplIGlzIHNldCB0byBvbmUgc3lzdGVtIHBhZ2UgYXMgcmVxdWlyZWQuCj4+
Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPj4+PiAt
LS0KPj4+PiAgICBkcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oIHwgMSArCj4+Pj4g
ICAgZHJpdmVycy92ZHBhL21seDUvY29yZS9yZXNvdXJjZXMuYyB8IDEgKwo+Pj4+ICAgIGRyaXZl
cnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyAgfCA2ICsrKysrKwo+Pj4+ICAgIDMgZmlsZXMg
Y2hhbmdlZCwgOCBpbnNlcnRpb25zKCspCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaCBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92
ZHBhLmgKPj4+PiBpbmRleCBiNmNjNTNiYTk4MGMuLjQ5ZGU2MmNkYTU5OCAxMDA2NDQKPj4+PiAt
LS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oCj4+Pj4gKysrIGIvZHJpdmVy
cy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaAo+Pj4+IEBAIC00MSw2ICs0MSw3IEBAIHN0cnVj
dCBtbHg1X3ZkcGFfcmVzb3VyY2VzIHsKPj4+PiAgICAJdTMyIHBkbjsKPj4+PiAgICAJc3RydWN0
IG1seDVfdWFyc19wYWdlICp1YXI7Cj4+Pj4gICAgCXZvaWQgX19pb21lbSAqa2lja19hZGRyOwo+
Pj4+ICsJdTY0IHBoeXNfa2lja19hZGRyOwo+Pj4+ICAgIAl1MTYgdWlkOwo+Pj4+ICAgIAl1MzIg
bnVsbF9ta2V5Owo+Pj4+ICAgIAlib29sIHZhbGlkOwo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3ZkcGEvbWx4NS9jb3JlL3Jlc291cmNlcy5jIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9yZXNv
dXJjZXMuYwo+Pj4+IGluZGV4IDY1MjFjYmQwZjVjMi4uNjY1ZjhmYzE3MTBmIDEwMDY0NAo+Pj4+
IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvcmVzb3VyY2VzLmMKPj4+PiArKysgYi9kcml2
ZXJzL3ZkcGEvbWx4NS9jb3JlL3Jlc291cmNlcy5jCj4+Pj4gQEAgLTI0Nyw2ICsyNDcsNyBAQCBp
bnQgbWx4NV92ZHBhX2FsbG9jX3Jlc291cmNlcyhzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYp
Cj4+Pj4gICAgCQlnb3RvIGVycl9rZXk7Cj4+Pj4gICAgCWtpY2tfYWRkciA9IG1kZXYtPmJhcl9h
ZGRyICsgb2Zmc2V0Owo+Pj4+ICsJcmVzLT5waHlzX2tpY2tfYWRkciA9IGtpY2tfYWRkcjsKPj4+
PiAgICAJcmVzLT5raWNrX2FkZHIgPSBpb3JlbWFwKGtpY2tfYWRkciwgUEFHRV9TSVpFKTsKPj4+
PiAgICAJaWYgKCFyZXMtPmtpY2tfYWRkcikgewo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zk
cGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0
LmMKPj4+PiBpbmRleCAxMGM1ZmVmM2MwMjAuLjY4MDc1MTA3NGQyYSAxMDA2NDQKPj4+PiAtLS0g
YS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4+PiArKysgYi9kcml2ZXJzL3Zk
cGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4+PiBAQCAtMTg2NSw4ICsxODY1LDE0IEBAIHN0YXRp
YyB2b2lkIG1seDVfdmRwYV9mcmVlKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldikKPj4+PiAgICBz
dGF0aWMgc3RydWN0IHZkcGFfbm90aWZpY2F0aW9uX2FyZWEgbWx4NV9nZXRfdnFfbm90aWZpY2F0
aW9uKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTE2IGlkeCkKPj4+PiAgICB7Cj4+Pj4gKwlz
dHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYgPSB0b19tdmRldih2ZGV2KTsKPj4+PiAgICAJc3Ry
dWN0IHZkcGFfbm90aWZpY2F0aW9uX2FyZWEgcmV0ID0ge307Cj4+Pj4gKwlzdHJ1Y3QgbWx4NV92
ZHBhX25ldCAqbmRldjsKPj4+PiArCj4+Pj4gKwluZGV2ID0gdG9fbWx4NV92ZHBhX25kZXYobXZk
ZXYpOwo+Pj4+ICsJcmV0LmFkZHIgPSAocGh5c19hZGRyX3QpbmRldi0+bXZkZXYucmVzLnBoeXNf
a2lja19hZGRyOwo+Pj4+ICsJcmV0LnNpemUgPSBQQUdFX1NJWkU7Cj4+Pgo+Pj4gTm90ZSB0aGF0
IHRoZSBwYWdlIHdpbGwgYmUgbWFwcGVkIGluIHRvIGd1ZXN0LCBzbyBpdCdzIG9ubHkgc2FmZSBp
ZiB0aGUKPj4+IGRvb3JiZWVsIGV4Y2x1c2l2ZWx5IG93biB0aGUgcGFnZS4gVGhpcyBtZWFucyBp
ZiB0aGVyZSdyZSBvdGhlciByZWdpc3RlcnMgaW4KPj4+IHRoZSBwYWdlLCB3ZSBjYW4gbm90IGxl
dCB0aGUgZG9vcmJlbGwgYnlwYXNzIHRvIHdvcmsuCj4+Pgo+Pj4gU28gdGhpcyBpcyBzdXNwaWNp
b3VzIGF0IGxlYXN0IGluIHRoZSBjYXNlIG9mIHN1YmZ1bmN0aW9uIHdoZXJlIHdlIGNhbGN1bGF0
ZQo+Pj4gdGhlIGJhciBsZW5ndGggaW4gbWx4NV9zZl9kZXZfdGFibGVfY3JlYXRlKCkgYXM6Cj4+
Pgo+Pj4gdGFibGUtPnNmX2Jhcl9sZW5ndGggPSAxIDw8IChNTFg1X0NBUF9HRU4oZGV2LCBsb2df
bWluX3NmX3NpemUpICsgMTIpOwo+Pj4KPj4+IEl0IGxvb2tzIHRvIG1lIHRoaXMgY2FuIG9ubHkg
d29yayBmb3IgdGhlIGFyY2ggd2l0aCBQQUdFX1NJWkUgPSA0MDk2LAo+Pj4gb3RoZXJ3aXNlIHdl
IGNhbiBtYXAgbW9yZSBpbnRvIHRoZSB1c2Vyc3BhY2UoZ3Vlc3QpLgo+Pj4KPj4gQ29ycmVjdCwg
c28gSSBndWVzcyBJIHNob3VsZCByZXR1cm4gaGVyZSA0MDk2LgoKCkknbSBub3QgcXVpdGUgc3Vy
ZSBidXQgc2luY2UgdGhlIGNhbGN1bGF0aW9uIG9mIHRoZSBzZl9iYXJfbGVuZ3RoIGlzIApkb2Vu
IHZpYSBhIHNoaWZ0IG9mIDEyLCBpdCBtaWdodCBiZSBjb3JyZWN0LgoKQW5kIHBsZWFzZSBkb3Vi
bGUgY2hlY2sgaWYgdGhlIGRvb3JiZWxsIG93biB0aGUgcGFnZSBleGNsdXNpdmVseS4KCgo+Pgo+
PiBJIGFsc28gdGhpbmsgdGhhdCB0aGUgY2hlY2sgaW4gdmhvc3RfdmRwYV9tbWFwKCkgc2hvdWxk
IHZlcmlmeSB0aGF0IHRoZQo+PiByZXR1cm5lZCBzaXplIGlzIG5vdCBzbWFsbGVyIHRoYW4gUEFH
RV9TSVpFIGJlY2F1c2UgdGhlIHJldHVybmVkIGFkZHJlc3MKPiBBY3R1YWxseSBJIHRoaW5rIGl0
J3Mgb2sgc2luY2UgeW91IHZlcmlmeSB0aGUgc2l6ZSBlcXVhbHMgdm1hLT52bV9lbmQgLQo+IHZt
YS0+dm1fc3RhcnQgd2hpY2ggbXVzdCBiZSBhdCBsZWFzdCBQQUdFX1NJWkUuCgoKWWVzLgoKVGhh
bmtzCgoKPgo+PiBtaWdodCBqdXN0IGJlIGFsaWduZWQgdG8gUEFHRV9TSVpFLiBJIHRoaW5rIHRo
aXMgc2hvdWxkIGJlIGVub2dodCBidXQKPj4gbWF5YmUgYWxzbyB1c2UgdGhlIHNhbWUgbG9naWMg
aW4gdmhvc3RfdmRwYV9mYXVsdCgpLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
