Return-Path: <SRS0=OwTx=BQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37CAC433E0
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 03:27:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 721E522D05
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 03:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bcQw6mra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721E522D05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 838A023B28;
	Thu,  6 Aug 2020 03:27:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WgLDkaAUzV-r; Thu,  6 Aug 2020 03:27:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 45DAE228EB;
	Thu,  6 Aug 2020 03:27:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36275C0051;
	Thu,  6 Aug 2020 03:27:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB501C004C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 03:27:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A3B1C887E9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 03:27:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XdEFh8vwmTRv
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 03:27:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B4E32887E5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 03:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596684454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yj1ihXQO2M1TsL9VeUKDmXbzc/ApdSgHZZHy2dOrKJk=;
 b=bcQw6mraHDsF+rsx9l6d783z9bp7TUCV220sotl2PexpvrFbKLjMCBTf2aqZLhAOblvFLc
 phgvIuZ7S4t2vRO8C84PwetDznfU2L7X89x+c0RVfNlfHgZn+rRsRjBGlbXaxc2eHknoAc
 gVeZKXfNg9p19+agnfR6PE6yLllkiBk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-EWkCYCeNMcm4t8G3QDakkQ-1; Wed, 05 Aug 2020 23:27:33 -0400
X-MC-Unique: EWkCYCeNMcm4t8G3QDakkQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C0D1106B242;
 Thu,  6 Aug 2020 03:27:31 +0000 (UTC)
Received: from [10.72.13.140] (ovpn-13-140.pek2.redhat.com [10.72.13.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E19EA19D81;
 Thu,  6 Aug 2020 03:27:17 +0000 (UTC)
Subject: Re: [PATCH 3/4] vdpa: get_iova_range() is mandatory for device
 specific DMA translation
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200617032947.6371-1-jasowang@redhat.com>
 <20200617032947.6371-4-jasowang@redhat.com>
 <20200805085217-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d371771e-b17a-8ccb-e185-4762b9ac0914@redhat.com>
Date: Thu, 6 Aug 2020 11:27:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805085217-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: shahafs@mellanox.com, lulu@redhat.com, saugatm@xilinx.com,
 mhabets@solarflare.com, vmireyno@marvell.com, linux-kernel@vger.kernel.org,
 gdawar@xilinx.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, hanand@xilinx.com, zhangweining@ruijie.com.cn,
 eli@mellanox.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
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

Ck9uIDIwMjAvOC81IOS4i+WNiDg6NTUsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBPbiBX
ZWQsIEp1biAxNywgMjAyMCBhdCAxMToyOTo0NkFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+
PiBJbiBvcmRlciB0byBsZXQgdXNlcnNwYWNlIHdvcmsgY29ycmVjdGx5LCBnZXRfaW92YV9yYW5n
ZSgpIGlzIGEgbXVzdAo+PiBmb3IgdGhlIGRldmljZSB0aGF0IGhhcyBpdHMgb3duIERNQSB0cmFu
c2xhdGlvbiBsb2dpYy4KPiBJIGd1ZXNzIHlvdSBtZWFuIGZvciBhIGRldmljZS4KPgo+IEhvd2V2
ZXIgaW4gYWJzZW5jZSBvZiB0aHMgb3AsIEkgZG9uJ3Qgc2VlIHdoYXQgaXMgd3Jvbmcgd2l0aCBq
dXN0Cj4gYXNzdW1pbmcgZGV2aWNlIGNhbiBhY2Nlc3MgYW55IGFkZHJlc3MuCgoKSXQncyBqdXN0
IGZvciBzYWZlLCBpZiB5b3Ugd2FudCwgd2UgY2FuIGFzc3VtZSBhbnkgYWRkcmVzcyB3aXRob3V0
IHRoaXMgb3AuCgoKPgo+PiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPgo+PiAtLS0KPj4gICBkcml2ZXJzL3ZkcGEvdmRwYS5jIHwgNCArKysrCj4+ICAgMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
ZHBhL3ZkcGEuYyBiL2RyaXZlcnMvdmRwYS92ZHBhLmMKPj4gaW5kZXggZGUyMTFlZjM3MzhjLi5h
YjdhZjk3OGVmNzAgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhLmMKPj4gKysrIGIv
ZHJpdmVycy92ZHBhL3ZkcGEuYwo+PiBAQCAtODIsNiArODIsMTAgQEAgc3RydWN0IHZkcGFfZGV2
aWNlICpfX3ZkcGFfYWxsb2NfZGV2aWNlKHN0cnVjdCBkZXZpY2UgKnBhcmVudCwKPj4gICAJaWYg
KCEhY29uZmlnLT5kbWFfbWFwICE9ICEhY29uZmlnLT5kbWFfdW5tYXApCj4+ICAgCQlnb3RvIGVy
cjsKPj4gICAKPj4gKwlpZiAoKGNvbmZpZy0+ZG1hX21hcCB8fCBjb25maWctPnNldF9tYXApICYm
Cj4+ICsJICAgICFjb25maWctPmdldF9pb3ZhX3JhbmdlKQo+PiArCQlnb3RvIGVycjsKPj4gKwo+
PiAgIAllcnIgPSAtRU5PTUVNOwo+PiAgIAl2ZGV2ID0ga3phbGxvYyhzaXplLCBHRlBfS0VSTkVM
KTsKPj4gICAJaWYgKCF2ZGV2KQo+IFdoYXQgYWJvdXQgZGV2aWNlcyB1c2luZyBhbiBJT01NVSBm
b3IgdHJhbnNsYXRpb24/Cj4gSU9NTVVzIGdlbmVyYWxseSBoYXZlIGEgbGltaXRlZCBJT1ZBIHJh
bmdlIHRvbywgcmlnaHQ/CgoKU2VlIHBhdGNoIDQgd2hpY2ggcXVlcnkgdGhlIElPTU1VIGdlb21l
dHJ5IGluIHRoaXMgY2FzZToKCivCoMKgwqAgwqDCoMKgIGlvbW11X2RvbWFpbl9nZXRfYXR0cih2
LT5kb21haW4sCivCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgwqDCoCBET01BSU5f
QVRUUl9HRU9NRVRSWSwgJmdlbyk7CivCoMKgwqAgwqDCoMKgIHJhbmdlLnN0YXJ0ID0gZ2VvLmFw
ZXJ0dXJlX3N0YXJ0OworwqDCoMKgIMKgwqDCoCByYW5nZS5lbmQgPSBnZW8uYXBlcnR1cmVfZW5k
OwoKVGhhbmtzCgoKPgo+Cj4KPj4gLS0gCj4+IDIuMjAuMQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
