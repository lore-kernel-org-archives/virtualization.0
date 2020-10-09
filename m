Return-Path: <SRS0=qiqk=DQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E37DC433E7
	for <virtualization@archiver.kernel.org>; Fri,  9 Oct 2020 02:01:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B733A22248
	for <virtualization@archiver.kernel.org>; Fri,  9 Oct 2020 02:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4ouKCzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B733A22248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4CC1287616;
	Fri,  9 Oct 2020 02:01:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6G6cCm3+WlNk; Fri,  9 Oct 2020 02:01:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7172587610;
	Fri,  9 Oct 2020 02:01:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53B01C016F;
	Fri,  9 Oct 2020 02:01:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5716C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Oct 2020 02:01:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 98BED2E1CB
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Oct 2020 02:01:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7kvAQJIjjZRX
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Oct 2020 02:01:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id D3F3720107
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Oct 2020 02:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602208887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3s9R39Og5RHDHefHI3q9yhoEDWORC7I7mmgIVvKh3e0=;
 b=c4ouKCzkZ9qDQ+wRvdXUiYKyXyCd589llLsWmQ9rf7MwhKkOOrU6/K+16/CnaWOLE49LtM
 hi4YTCbE+ErzMi6KlP/lYkcKR2ImcC6eXq8C9L5fTmVhiLrjqeLLOlyVuSD7T7rtxu97rd
 lOmZjE54uDh1tKzxZGdtkrPETI+jl50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-q4BrAy5gNG227A1gPlmfPA-1; Thu, 08 Oct 2020 22:01:23 -0400
X-MC-Unique: q4BrAy5gNG227A1gPlmfPA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F286B427C2;
 Fri,  9 Oct 2020 02:01:21 +0000 (UTC)
Received: from [10.72.13.133] (ovpn-13-133.pek2.redhat.com [10.72.13.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9BC3B5D9E8;
 Fri,  9 Oct 2020 02:01:07 +0000 (UTC)
Subject: Re: [RFC PATCH 05/24] vhost-vdpa: passing iotlb to IOMMU mapping
 helpers
To: Eli Cohen <elic@nvidia.com>
References: <20200924032125.18619-1-jasowang@redhat.com>
 <20200924032125.18619-6-jasowang@redhat.com>
 <20200930112609.GA223360@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5f083453-d070-d8a8-1f75-5de1c299cd0b@redhat.com>
Date: Fri, 9 Oct 2020 10:01:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930112609.GA223360@mtl-vdi-166.wap.labs.mlnx>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: lulu@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, mhabets@solarflare.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 hanand@xilinx.com, stefanha@redhat.com, eli@mellanox.com,
 maxime.coquelin@redhat.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
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

Ck9uIDIwMjAvOS8zMCDkuIvljYg3OjI2LCBFbGkgQ29oZW4gd3JvdGU6Cj4gT24gVGh1LCBTZXAg
MjQsIDIwMjAgYXQgMTE6MjE6MDZBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4gVG8gcHJl
cGFyZSBmb3IgdGhlIEFTSUQgc3VwcG9ydCBmb3Igdmhvc3QtdmRwYSwgdHJ5IHRvIHBhc3MgSU9U
TEIKPj4gb2JqZWN0IHRvIGRtYSBoZWxwZXJzLgo+IE1heWJlIGl0J3Mgd29ydGggbWVudGlvbmlu
ZyBoZXJlIHRoYXQgdGhpcyBwYXRjaCBkb2VzIG5vdCBjaGFuZ2UgYW55Cj4gZnVuY3Rpb25hbGl0
eSBhbmQgaXMgcHJlc2VudGVkIGFzIGEgcHJlcGFyYXRpb24gZm9yIHBhc3NpbmcgZGlmZmVyZW50
Cj4gaW90bGIncyBpbnN0ZWFkIG9mIHVzaW5nIGRldi0+aW90bGIKCgpSaWdodCwgbGV0IG1lIGFk
ZCB0aGVtIGluIHRoZSBuZXh0IHZlcnNpb24uCgpUaGFua3MKCgo+Cj4+IFNpZ25lZC1vZmYtYnk6
IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvdmhv
c3QvdmRwYS5jIHwgNDAgKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLQo+
PiAgIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkKPj4K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92ZHBh
LmMKPj4gaW5kZXggOWM2NDEyNzRiOWYzLi43NGJlZjFjMTVhNzAgMTAwNjQ0Cj4+IC0tLSBhL2Ry
aXZlcnMvdmhvc3QvdmRwYS5jCj4+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4+IEBAIC00
ODksMTAgKzQ4OSwxMSBAQCBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3VubG9ja2VkX2lvY3RsKHN0
cnVjdCBmaWxlICpmaWxlcCwKPj4gICAJcmV0dXJuIHI7Cj4+ICAgfQo+PiAgIAo+PiAtc3RhdGlj
IHZvaWQgdmhvc3RfdmRwYV9pb3RsYl91bm1hcChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTY0IHN0
YXJ0LCB1NjQgbGFzdCkKPj4gK3N0YXRpYyB2b2lkIHZob3N0X3ZkcGFfaW90bGJfdW5tYXAoc3Ry
dWN0IHZob3N0X3ZkcGEgKnYsCj4+ICsJCQkJICAgc3RydWN0IHZob3N0X2lvdGxiICppb3RsYiwK
Pj4gKwkJCQkgICB1NjQgc3RhcnQsIHU2NCBsYXN0KQo+PiAgIHsKPj4gICAJc3RydWN0IHZob3N0
X2RldiAqZGV2ID0gJnYtPnZkZXY7Cj4+IC0Jc3RydWN0IHZob3N0X2lvdGxiICppb3RsYiA9IGRl
di0+aW90bGI7Cj4+ICAgCXN0cnVjdCB2aG9zdF9pb3RsYl9tYXAgKm1hcDsKPj4gICAJc3RydWN0
IHBhZ2UgKnBhZ2U7Cj4+ICAgCXVuc2lnbmVkIGxvbmcgcGZuLCBwaW5uZWQ7Cj4+IEBAIC01MTQs
OCArNTE1LDkgQEAgc3RhdGljIHZvaWQgdmhvc3RfdmRwYV9pb3RsYl91bm1hcChzdHJ1Y3Qgdmhv
c3RfdmRwYSAqdiwgdTY0IHN0YXJ0LCB1NjQgbGFzdCkKPj4gICBzdGF0aWMgdm9pZCB2aG9zdF92
ZHBhX2lvdGxiX2ZyZWUoc3RydWN0IHZob3N0X3ZkcGEgKnYpCj4+ICAgewo+PiAgIAlzdHJ1Y3Qg
dmhvc3RfZGV2ICpkZXYgPSAmdi0+dmRldjsKPj4gKwlzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlvdGxi
ID0gZGV2LT5pb3RsYjsKPj4gICAKPj4gLQl2aG9zdF92ZHBhX2lvdGxiX3VubWFwKHYsIDBVTEws
IDBVTEwgLSAxKTsKPj4gKwl2aG9zdF92ZHBhX2lvdGxiX3VubWFwKHYsIGlvdGxiLCAwVUxMLCAw
VUxMIC0gMSk7Cj4+ICAgCWtmcmVlKGRldi0+aW90bGIpOwo+PiAgIAlkZXYtPmlvdGxiID0gTlVM
TDsKPj4gICB9Cj4+IEBAIC01NDIsMTUgKzU0NCwxNCBAQCBzdGF0aWMgaW50IHBlcm1fdG9faW9t
bXVfZmxhZ3ModTMyIHBlcm0pCj4+ICAgCXJldHVybiBmbGFncyB8IElPTU1VX0NBQ0hFOwo+PiAg
IH0KPj4gICAKPj4gLXN0YXRpYyBpbnQgdmhvc3RfdmRwYV9tYXAoc3RydWN0IHZob3N0X3ZkcGEg
KnYsCj4+ICtzdGF0aWMgaW50IHZob3N0X3ZkcGFfbWFwKHN0cnVjdCB2aG9zdF92ZHBhICp2LCBz
dHJ1Y3Qgdmhvc3RfaW90bGIgKmlvdGxiLAo+PiAgIAkJCSAgdTY0IGlvdmEsIHU2NCBzaXplLCB1
NjQgcGEsIHUzMiBwZXJtKQo+PiAgIHsKPj4gLQlzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYgPSAmdi0+
dmRldjsKPj4gICAJc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhID0gdi0+dmRwYTsKPj4gICAJY29u
c3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRwYS0+Y29uZmlnOwo+PiAgIAlpbnQg
ciA9IDA7Cj4+ICAgCj4+IC0JciA9IHZob3N0X2lvdGxiX2FkZF9yYW5nZShkZXYtPmlvdGxiLCBp
b3ZhLCBpb3ZhICsgc2l6ZSAtIDEsCj4+ICsJciA9IHZob3N0X2lvdGxiX2FkZF9yYW5nZShpb3Rs
YiwgaW92YSwgaW92YSArIHNpemUgLSAxLAo+PiAgIAkJCQkgIHBhLCBwZXJtKTsKPj4gICAJaWYg
KHIpCj4+ICAgCQlyZXR1cm4gcjsKPj4gQEAgLTU1OSw3ICs1NjAsNyBAQCBzdGF0aWMgaW50IHZo
b3N0X3ZkcGFfbWFwKHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+PiAgIAkJciA9IG9wcy0+ZG1hX21h
cCh2ZHBhLCBpb3ZhLCBzaXplLCBwYSwgcGVybSk7Cj4+ICAgCX0gZWxzZSBpZiAob3BzLT5zZXRf
bWFwKSB7Cj4+ICAgCQlpZiAoIXYtPmluX2JhdGNoKQo+PiAtCQkJciA9IG9wcy0+c2V0X21hcCh2
ZHBhLCBkZXYtPmlvdGxiKTsKPj4gKwkJCXIgPSBvcHMtPnNldF9tYXAodmRwYSwgaW90bGIpOwo+
PiAgIAl9IGVsc2Ugewo+PiAgIAkJciA9IGlvbW11X21hcCh2LT5kb21haW4sIGlvdmEsIHBhLCBz
aXplLAo+PiAgIAkJCSAgICAgIHBlcm1fdG9faW9tbXVfZmxhZ3MocGVybSkpOwo+PiBAQCAtNTY4
LDI5ICs1NjksMzAgQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX21hcChzdHJ1Y3Qgdmhvc3RfdmRw
YSAqdiwKPj4gICAJcmV0dXJuIHI7Cj4+ICAgfQo+PiAgIAo+PiAtc3RhdGljIHZvaWQgdmhvc3Rf
dmRwYV91bm1hcChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTY0IGlvdmEsIHU2NCBzaXplKQo+PiAr
c3RhdGljIHZvaWQgdmhvc3RfdmRwYV91bm1hcChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPj4gKwkJ
CSAgICAgc3RydWN0IHZob3N0X2lvdGxiICppb3RsYiwKPj4gKwkJCSAgICAgdTY0IGlvdmEsIHU2
NCBzaXplKQo+PiAgIHsKPj4gLQlzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYgPSAmdi0+dmRldjsKPj4g
ICAJc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhID0gdi0+dmRwYTsKPj4gICAJY29uc3Qgc3RydWN0
IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRwYS0+Y29uZmlnOwo+PiAgIAo+PiAtCXZob3N0X3Zk
cGFfaW90bGJfdW5tYXAodiwgaW92YSwgaW92YSArIHNpemUgLSAxKTsKPj4gKwl2aG9zdF92ZHBh
X2lvdGxiX3VubWFwKHYsIGlvdGxiLCBpb3ZhLCBpb3ZhICsgc2l6ZSAtIDEpOwo+PiAgIAo+PiAg
IAlpZiAob3BzLT5kbWFfbWFwKSB7Cj4+ICAgCQlvcHMtPmRtYV91bm1hcCh2ZHBhLCBpb3ZhLCBz
aXplKTsKPj4gICAJfSBlbHNlIGlmIChvcHMtPnNldF9tYXApIHsKPj4gICAJCWlmICghdi0+aW5f
YmF0Y2gpCj4+IC0JCQlvcHMtPnNldF9tYXAodmRwYSwgZGV2LT5pb3RsYik7Cj4+ICsJCQlvcHMt
PnNldF9tYXAodmRwYSwgaW90bGIpOwo+PiAgIAl9IGVsc2Ugewo+PiAgIAkJaW9tbXVfdW5tYXAo
di0+ZG9tYWluLCBpb3ZhLCBzaXplKTsKPj4gICAJfQo+PiAgIH0KPj4gICAKPj4gICBzdGF0aWMg
aW50IHZob3N0X3ZkcGFfcHJvY2Vzc19pb3RsYl91cGRhdGUoc3RydWN0IHZob3N0X3ZkcGEgKnYs
Cj4+ICsJCQkJCSAgIHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIsCj4+ICAgCQkJCQkgICBzdHJ1
Y3Qgdmhvc3RfaW90bGJfbXNnICptc2cpCj4+ICAgewo+PiAgIAlzdHJ1Y3Qgdmhvc3RfZGV2ICpk
ZXYgPSAmdi0+dmRldjsKPj4gLQlzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlvdGxiID0gZGV2LT5pb3Rs
YjsKPj4gICAJc3RydWN0IHBhZ2UgKipwYWdlX2xpc3Q7Cj4+ICAgCXVuc2lnbmVkIGxvbmcgbGlz
dF9zaXplID0gUEFHRV9TSVpFIC8gc2l6ZW9mKHN0cnVjdCBwYWdlICopOwo+PiAgIAl1bnNpZ25l
ZCBpbnQgZ3VwX2ZsYWdzID0gRk9MTF9MT05HVEVSTTsKPj4gQEAgLTY0NCw3ICs2NDYsNyBAQCBz
dGF0aWMgaW50IHZob3N0X3ZkcGFfcHJvY2Vzc19pb3RsYl91cGRhdGUoc3RydWN0IHZob3N0X3Zk
cGEgKnYsCj4+ICAgCQkJaWYgKGxhc3RfcGZuICYmICh0aGlzX3BmbiAhPSBsYXN0X3BmbiArIDEp
KSB7Cj4+ICAgCQkJCS8qIFBpbiBhIGNvbnRpZ3VvdXMgY2h1bmsgb2YgbWVtb3J5ICovCj4+ICAg
CQkJCWNzaXplID0gKGxhc3RfcGZuIC0gbWFwX3BmbiArIDEpIDw8IFBBR0VfU0hJRlQ7Cj4+IC0J
CQkJaWYgKHZob3N0X3ZkcGFfbWFwKHYsIGlvdmEsIGNzaXplLAo+PiArCQkJCWlmICh2aG9zdF92
ZHBhX21hcCh2LCBpb3RsYiwgaW92YSwgY3NpemUsCj4+ICAgCQkJCQkJICAgbWFwX3BmbiA8PCBQ
QUdFX1NISUZULAo+PiAgIAkJCQkJCSAgIG1zZy0+cGVybSkpCj4+ICAgCQkJCQlnb3RvIG91dDsK
Pj4gQEAgLTY2MCwxMSArNjYyLDEyIEBAIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9wcm9jZXNzX2lv
dGxiX3VwZGF0ZShzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPj4gICAJfQo+PiAgIAo+PiAgIAkvKiBQ
aW4gdGhlIHJlc3QgY2h1bmsgKi8KPj4gLQlyZXQgPSB2aG9zdF92ZHBhX21hcCh2LCBpb3ZhLCAo
bGFzdF9wZm4gLSBtYXBfcGZuICsgMSkgPDwgUEFHRV9TSElGVCwKPj4gKwlyZXQgPSB2aG9zdF92
ZHBhX21hcCh2LCBpb3RsYiwgaW92YSwKPj4gKwkJCSAgICAgKGxhc3RfcGZuIC0gbWFwX3BmbiAr
IDEpIDw8IFBBR0VfU0hJRlQsCj4+ICAgCQkJICAgICBtYXBfcGZuIDw8IFBBR0VfU0hJRlQsIG1z
Zy0+cGVybSk7Cj4+ICAgb3V0Ogo+PiAgIAlpZiAocmV0KSB7Cj4+IC0JCXZob3N0X3ZkcGFfdW5t
YXAodiwgbXNnLT5pb3ZhLCBtc2ctPnNpemUpOwo+PiArCQl2aG9zdF92ZHBhX3VubWFwKHYsIGlv
dGxiLCBtc2ctPmlvdmEsIG1zZy0+c2l6ZSk7Cj4+ICAgCQlhdG9taWM2NF9zdWIobnBhZ2VzLCAm
ZGV2LT5tbS0+cGlubmVkX3ZtKTsKPj4gICAJfQo+PiAgIAltbWFwX3JlYWRfdW5sb2NrKGRldi0+
bW0pOwo+PiBAQCAtNjc4LDYgKzY4MSw3IEBAIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9wcm9jZXNz
X2lvdGxiX21zZyhzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCj4+ICAgCXN0cnVjdCB2aG9zdF92ZHBh
ICp2ID0gY29udGFpbmVyX29mKGRldiwgc3RydWN0IHZob3N0X3ZkcGEsIHZkZXYpOwo+PiAgIAlz
dHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEgPSB2LT52ZHBhOwo+PiAgIAljb25zdCBzdHJ1Y3QgdmRw
YV9jb25maWdfb3BzICpvcHMgPSB2ZHBhLT5jb25maWc7Cj4+ICsJc3RydWN0IHZob3N0X2lvdGxi
ICppb3RsYiA9IGRldi0+aW90bGI7Cj4+ICAgCWludCByID0gMDsKPj4gICAKPj4gICAJciA9IHZo
b3N0X2Rldl9jaGVja19vd25lcihkZXYpOwo+PiBAQCAtNjg2LDE3ICs2OTAsMTcgQEAgc3RhdGlj
IGludCB2aG9zdF92ZHBhX3Byb2Nlc3NfaW90bGJfbXNnKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwK
Pj4gICAKPj4gICAJc3dpdGNoIChtc2ctPnR5cGUpIHsKPj4gICAJY2FzZSBWSE9TVF9JT1RMQl9V
UERBVEU6Cj4+IC0JCXIgPSB2aG9zdF92ZHBhX3Byb2Nlc3NfaW90bGJfdXBkYXRlKHYsIG1zZyk7
Cj4+ICsJCXIgPSB2aG9zdF92ZHBhX3Byb2Nlc3NfaW90bGJfdXBkYXRlKHYsIGlvdGxiLCBtc2cp
Owo+PiAgIAkJYnJlYWs7Cj4+ICAgCWNhc2UgVkhPU1RfSU9UTEJfSU5WQUxJREFURToKPj4gLQkJ
dmhvc3RfdmRwYV91bm1hcCh2LCBtc2ctPmlvdmEsIG1zZy0+c2l6ZSk7Cj4+ICsJCXZob3N0X3Zk
cGFfdW5tYXAodiwgaW90bGIsIG1zZy0+aW92YSwgbXNnLT5zaXplKTsKPj4gICAJCWJyZWFrOwo+
PiAgIAljYXNlIFZIT1NUX0lPVExCX0JBVENIX0JFR0lOOgo+PiAgIAkJdi0+aW5fYmF0Y2ggPSB0
cnVlOwo+PiAgIAkJYnJlYWs7Cj4+ICAgCWNhc2UgVkhPU1RfSU9UTEJfQkFUQ0hfRU5EOgo+PiAg
IAkJaWYgKHYtPmluX2JhdGNoICYmIG9wcy0+c2V0X21hcCkKPj4gLQkJCW9wcy0+c2V0X21hcCh2
ZHBhLCBkZXYtPmlvdGxiKTsKPj4gKwkJCW9wcy0+c2V0X21hcCh2ZHBhLCBpb3RsYik7Cj4+ICAg
CQl2LT5pbl9iYXRjaCA9IGZhbHNlOwo+PiAgIAkJYnJlYWs7Cj4+ICAgCWRlZmF1bHQ6Cj4+IC0t
IAo+PiAyLjIwLjEKPj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
