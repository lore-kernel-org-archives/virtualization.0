Return-Path: <SRS0=AynT=JM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A5FC433B4
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 07:16:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A21C9611AB
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 07:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21C9611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F9A1846D1;
	Thu, 15 Apr 2021 07:16:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DsrW2C-IpDhv; Thu, 15 Apr 2021 07:16:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2657845A9;
	Thu, 15 Apr 2021 07:16:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E666C000B;
	Thu, 15 Apr 2021 07:16:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4668EC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:16:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3425740FAA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:16:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MlyJ8UBI0iLQ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:16:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2A65E40F6A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618471009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wCRl0VxJxSL9UjqcPN4nvBTKlzJxeSk0M+fzlCzX4vs=;
 b=Th+nYz6xQdfPCL8RlhVbgzIGQTSfnrdV6ixYubtTpxtMeI5T8K8Jdl6yPfUXT5cUhja1UZ
 UyAqNpoymHLThc+zjHDzv3YbVsV4aPFxgfWb9supX9otc8K5phcau28LS2J3j4Pg8f07Eo
 G1jIAgRKE57ljRTOM/X5xyJr6OIR21U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-QmM1FKnsNjOGZJ6okvmyGg-1; Thu, 15 Apr 2021 03:16:45 -0400
X-MC-Unique: QmM1FKnsNjOGZJ6okvmyGg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E78F481431F;
 Thu, 15 Apr 2021 07:16:43 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-61.pek2.redhat.com
 [10.72.12.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B20F05C255;
 Thu, 15 Apr 2021 07:16:37 +0000 (UTC)
Subject: Re: [PATCH 1/3] vDPA/ifcvf: deduce VIRTIO device ID when probe
To: Zhu Lingshan <lingshan.zhu@linux.intel.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, lulu@redhat.com,
 leonro@nvidia.com
References: <20210414091832.5132-1-lingshan.zhu@intel.com>
 <20210414091832.5132-2-lingshan.zhu@intel.com>
 <85483ff1-cf98-ad05-0c53-74caa2464459@redhat.com>
 <ccf7001b-27f0-27ea-40d2-52ca3cc2386b@linux.intel.com>
 <ffd2861d-2395-de51-a227-f1ef33f74322@redhat.com>
 <92ef6264-4462-cbd4-5db8-6ce6b68762e0@linux.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d3c7ea9f-1849-f890-f647-6caf764a7542@redhat.com>
Date: Thu, 15 Apr 2021 15:16:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <92ef6264-4462-cbd4-5db8-6ce6b68762e0@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

CuWcqCAyMDIxLzQvMTUg5LiL5Y2IMjozNiwgWmh1IExpbmdzaGFuIOWGmemBkzoKPgo+Cj4gT24g
NC8xNS8yMDIxIDI6MzAgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4+Cj4+IOWcqCAyMDIxLzQvMTUg
5LiL5Y2IMTo1MiwgWmh1IExpbmdzaGFuIOWGmemBkzoKPj4+Cj4+Pgo+Pj4gT24gNC8xNS8yMDIx
IDExOjMwIEFNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+Cj4+Pj4g5ZyoIDIwMjEvNC8xNCDkuIvl
jYg1OjE4LCBaaHUgTGluZ3NoYW4g5YaZ6YGTOgo+Pj4+PiBUaGlzIGNvbW1pdCBkZWR1Y2VzIFZJ
UlRJTyBkZXZpY2UgSUQgYXMgZGV2aWNlIHR5cGUgd2hlbiBwcm9iZSwKPj4+Pj4gdGhlbiBpZmN2
Zl92ZHBhX2dldF9kZXZpY2VfaWQoKSBjYW4gc2ltcGx5IHJldHVybiB0aGUgSUQuCj4+Pj4+IGlm
Y3ZmX3ZkcGFfZ2V0X2ZlYXR1cmVzKCkgYW5kIGlmY3ZmX3ZkcGFfZ2V0X2NvbmZpZ19zaXplKCkK
Pj4+Pj4gY2FuIHdvcmsgcHJvcGVybHkgYmFzZWQgb24gdGhlIGRldmljZSBJRC4KPj4+Pj4KPj4+
Pj4gU2lnbmVkLW9mZi1ieTogWmh1IExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+
Pj4+PiAtLS0KPj4+Pj4gwqAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaCB8wqAgMSAr
Cj4+Pj4+IMKgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgfCAyMiArKysrKysrKysr
LS0tLS0tLS0tLS0tCj4+Pj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwg
MTIgZGVsZXRpb25zKC0pCj4+Pj4+Cj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZj
dmYvaWZjdmZfYmFzZS5oIAo+Pj4+PiBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgK
Pj4+Pj4gaW5kZXggYjJlZWIxNmI5YzJjLi4xYzA0Y2QyNTZmYTcgMTAwNjQ0Cj4+Pj4+IC0tLSBh
L2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPj4+Pj4gKysrIGIvZHJpdmVycy92ZHBh
L2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+Pj4+PiBAQCAtODQsNiArODQsNyBAQCBzdHJ1Y3QgaWZjdmZf
aHcgewo+Pj4+PiDCoMKgwqDCoMKgIHUzMiBub3RpZnlfb2ZmX211bHRpcGxpZXI7Cj4+Pj4+IMKg
wqDCoMKgwqAgdTY0IHJlcV9mZWF0dXJlczsKPj4+Pj4gwqDCoMKgwqDCoCB1NjQgaHdfZmVhdHVy
ZXM7Cj4+Pj4+ICvCoMKgwqAgdTMyIGRldl90eXBlOwo+Pj4+PiDCoMKgwqDCoMKgIHN0cnVjdCB2
aXJ0aW9fcGNpX2NvbW1vbl9jZmcgX19pb21lbSAqY29tbW9uX2NmZzsKPj4+Pj4gwqDCoMKgwqDC
oCB2b2lkIF9faW9tZW0gKm5ldF9jZmc7Cj4+Pj4+IMKgwqDCoMKgwqAgc3RydWN0IHZyaW5nX2lu
Zm8gdnJpbmdbSUZDVkZfTUFYX1FVRVVFX1BBSVJTICogMl07Cj4+Pj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIAo+Pj4+PiBiL2RyaXZlcnMvdmRwYS9pZmN2
Zi9pZmN2Zl9tYWluLmMKPj4+Pj4gaW5kZXggNDRkNzU4NjAxOWRhLi45OWIwYTZiNGMyMjcgMTAw
NjQ0Cj4+Pj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPj4+Pj4gKysr
IGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+Pj4+PiBAQCAtMzIzLDE5ICszMjMs
OSBAQCBzdGF0aWMgdTMyIGlmY3ZmX3ZkcGFfZ2V0X2dlbmVyYXRpb24oc3RydWN0IAo+Pj4+PiB2
ZHBhX2RldmljZSAqdmRwYV9kZXYpCj4+Pj4+IMKgIMKgIHN0YXRpYyB1MzIgaWZjdmZfdmRwYV9n
ZXRfZGV2aWNlX2lkKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9kZXYpCj4+Pj4+IMKgIHsKPj4+
Pj4gLcKgwqDCoCBzdHJ1Y3QgaWZjdmZfYWRhcHRlciAqYWRhcHRlciA9IHZkcGFfdG9fYWRhcHRl
cih2ZHBhX2Rldik7Cj4+Pj4+IC3CoMKgwqAgc3RydWN0IHBjaV9kZXYgKnBkZXYgPSBhZGFwdGVy
LT5wZGV2Owo+Pj4+PiAtwqDCoMKgIHUzMiByZXQgPSAtRU5PREVWOwo+Pj4+PiAtCj4+Pj4+IC3C
oMKgwqAgaWYgKHBkZXYtPmRldmljZSA8IDB4MTAwMCB8fCBwZGV2LT5kZXZpY2UgPiAweDEwN2Yp
Cj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+Pj4+PiAtCj4+Pj4+IC3CoMKgwqAg
aWYgKHBkZXYtPmRldmljZSA8IDB4MTA0MCkKPj4+Pj4gLcKgwqDCoMKgwqDCoMKgIHJldCA9wqAg
cGRldi0+c3Vic3lzdGVtX2RldmljZTsKPj4+Pj4gLcKgwqDCoCBlbHNlCj4+Pj4+IC3CoMKgwqDC
oMKgwqDCoCByZXQgPcKgIHBkZXYtPmRldmljZS0weDEwNDA7Cj4+Pj4+ICvCoMKgwqAgc3RydWN0
IGlmY3ZmX2h3ICp2ZiA9IHZkcGFfdG9fdmYodmRwYV9kZXYpOwo+Pj4+PiDCoCAtwqDCoMKgIHJl
dHVybiByZXQ7Cj4+Pj4+ICvCoMKgwqAgcmV0dXJuIHZmLT5kZXZfdHlwZTsKPj4+Pj4gwqAgfQo+
Pj4+PiDCoCDCoCBzdGF0aWMgdTMyIGlmY3ZmX3ZkcGFfZ2V0X3ZlbmRvcl9pZChzdHJ1Y3QgdmRw
YV9kZXZpY2UgKnZkcGFfZGV2KQo+Pj4+PiBAQCAtNDY2LDYgKzQ1NiwxNCBAQCBzdGF0aWMgaW50
IGlmY3ZmX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCAKPj4+Pj4gY29uc3Qgc3RydWN0IHBj
aV9kZXZpY2VfaWQgKmlkKQo+Pj4+PiDCoMKgwqDCoMKgIHBjaV9zZXRfZHJ2ZGF0YShwZGV2LCBh
ZGFwdGVyKTsKPj4+Pj4gwqAgwqDCoMKgwqDCoCB2ZiA9ICZhZGFwdGVyLT52ZjsKPj4+Pj4gK8Kg
wqDCoCBpZiAocGRldi0+ZGV2aWNlIDwgMHgxMDAwIHx8IHBkZXYtPmRldmljZSA+IDB4MTA3ZikK
Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAtRU9QTk9UU1VQUDsKPj4+Pj4gKwo+Pj4+PiAr
wqDCoMKgIGlmIChwZGV2LT5kZXZpY2UgPCAweDEwNDApCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCB2
Zi0+ZGV2X3R5cGUgPcKgIHBkZXYtPnN1YnN5c3RlbV9kZXZpY2U7Cj4+Pj4+ICvCoMKgwqAgZWxz
ZQo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgdmYtPmRldl90eXBlID3CoCBwZGV2LT5kZXZpY2UgLSAw
eDEwNDA7Cj4+Pj4KPj4+Pgo+Pj4+IFNvIGEgcXVlc3Rpb24gaGVyZSwgaXMgdGhlIGRldmljZSBh
IHRyYW5zdGlvbmFsIGRldmljZSBvciBtb2Rlcm4gb25lPwo+Pj4+Cj4+Pj4gSWYgaXQncyBhIHRy
YW5zaXRvbmFsIG9uZSwgY2FuIGl0IHN3dGljaCBlbmRpYW5lc3MgYXV0b21hdGljYWxseSBvciAK
Pj4+PiBub3Q/Cj4+Pj4KPj4+PiBUaGFua3MKPj4+IEhpIEphc29uLAo+Pj4KPj4+IFRoaXMgZHJp
dmVyIHNob3VsZCBkcml2ZSBib3RoIG1vZGVybiBhbmQgdHJhbnNpdGlvbmFsIGRldmljZXMgYXMg
d2UgCj4+PiBkaXNjdXNzZWQgYmVmb3JlLgo+Pj4gSWYgaXQncyBhIHRyYW5zaXRpb25hbCBvbmUs
IGl0IHdpbGwgYWN0IGFzIGEgbW9kZXJuIGRldmljZSBieSAKPj4+IGRlZmF1bHQsIGxlZ2FjeSBt
b2RlIGlzIGEgZmFpbC1vdmVyIHBhdGguCj4+Cj4+Cj4+IE5vdGUgdGhhdCBsZWdhY3kgZHJpdmVy
IHVzZSBuYXRpdmUgZW5kaWFuLCBzdXBwb3J0IGxlZ2FjeSBkcml2ZXIgCj4+IHJlcXVpcmVzIHRo
ZSBkZXZpY2UgdG8ga25vdyBuYXRpdmUgZW5kaWFuIHdoaWNoIEknbSBub3Qgc3VyZSB5b3VyIAo+
PiBkZXZpY2UgY2FuIGRvIHRoYXQuCj4+Cj4+IFRoYW5rcwo+IFllcywgbGVnYWN5IHJlcXVpcmVz
IGd1ZXN0IG5hdGl2ZSBlbmRpYW5lc3MsIEkgdGhpbmsgd2UgZG9uJ3QgbmVlZCB0byAKPiB3b3Jy
eSBhYm91dCB0aGlzIGJlY2F1c2Ugb3VyIHRyYW5zaXRpb25hbCBkZXZpY2Ugc2hvdWxkIHdvcmsg
aW4gbW9kZXJuIAo+IG1vZGUgYnkKPiBkZWZhdWx0KGxlZ2FjeSBtb2RlIGlzIHRoZSBmYWlsb3Zl
ciBwYXRoIHdlIHdpbGwgbmV2ZXIgcmVhY2gsIAo+IGdldF9mZWF0dXJlcyB3aWxsIGZhaWwgaWYg
bm8gQUNDRVNTX1BMQVRGT1JNKSwgd2UgZG9uJ3Qgc3VwcG9ydCBsZWdhY3kgCj4gZGV2aWNlIGlu
IHZEUEEuCj4KPiBUaGFua3MKCgpPaywgc28gSSB0aGluayBpdCdzIGJldHRlciB0byBhZGQgYSBj
b21tZW50IGhlcmUuCgpUaGFua3MKCgo+Pgo+Pgo+Pj4gRm9yIHZEUEEsIGl0IGhhcyB0byBzdXBw
b3J0IFZJUlRJT18xIGFuZCBBQ0NFU1NfUExBVEZPUk0sIHNvIGl0IG11c3QgCj4+PiBpbiBtb2Rl
cm4gbW9kZS4KPj4+IEkgdGhpbmsgd2UgZG9uJ3QgbmVlZCB0byB3b3JyeSBhYm91dCBlbmRpYW5l
c3MgZm9yIGxlZ2FjeSBtb2RlLgo+Pj4KPj4+IFRoYW5rcwo+Pj4gWmh1IExpbmdzaGFuCj4+Pj4K
Pj4+Pgo+Pj4+PiArCj4+Pj4+IMKgwqDCoMKgwqAgdmYtPmJhc2UgPSBwY2ltX2lvbWFwX3RhYmxl
KHBkZXYpOwo+Pj4+PiDCoCDCoMKgwqDCoMKgIGFkYXB0ZXItPnBkZXYgPSBwZGV2Owo+Pj4+Cj4+
Pgo+Pgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
