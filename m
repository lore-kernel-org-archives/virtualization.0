Return-Path: <SRS0=WRLV=IJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC35C433DB
	for <virtualization@archiver.kernel.org>; Thu, 11 Mar 2021 06:13:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B38E601FA
	for <virtualization@archiver.kernel.org>; Thu, 11 Mar 2021 06:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B38E601FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 294CF4CD89;
	Thu, 11 Mar 2021 06:13:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cM0IAMI29hbh; Thu, 11 Mar 2021 06:13:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5BE84AEF5;
	Thu, 11 Mar 2021 06:13:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85C9AC000B;
	Thu, 11 Mar 2021 06:13:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B3FEC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 06:13:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 35D7B6074E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 06:13:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hQkRNY8JD_9R
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 06:13:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 28217606F9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 06:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615443213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O9dIFx5T4B5wQEwSmY/A6qMcWPDW41QAG6OtpF0Rp64=;
 b=OEmBVMboLLBGPCjTcsuRU8tLDXe7ddsx8bVFxx2P44JFlprfDmyfuA/3mru/NiXyOHTQrD
 znFDsbtZgyUnkG9kKxXcSR6P5jarNav05VnCtCZVcw5vgqBLY2kubf8sXWfeIdDSmm9jX+
 jBmrKRZM3Sm/QB7vLQTYoorLjCWUmg8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-WCvA8jlCO1WyXxzT1CSOpQ-1; Thu, 11 Mar 2021 01:13:29 -0500
X-MC-Unique: WCvA8jlCO1WyXxzT1CSOpQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 345071858F17;
 Thu, 11 Mar 2021 06:13:28 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-9.pek2.redhat.com
 [10.72.13.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D63A5945D;
 Thu, 11 Mar 2021 06:13:21 +0000 (UTC)
Subject: Re: [PATCH V3 1/6] vDPA/ifcvf: get_vendor_id returns a device
 specific vendor id
To: Zhu Lingshan <lingshan.zhu@linux.intel.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, lulu@redhat.com,
 leonro@nvidia.com
References: <20210310090052.4762-1-lingshan.zhu@intel.com>
 <20210310090052.4762-2-lingshan.zhu@intel.com>
 <ff5fc8f9-f886-bd2a-60cc-771c628c6c4b@redhat.com>
 <5f2d915f-e1b0-c9eb-9fc8-4b64f5d8cd0f@linux.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <05e3fbc9-be49-a208-19a4-85f891323312@redhat.com>
Date: Thu, 11 Mar 2021 14:13:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <5f2d915f-e1b0-c9eb-9fc8-4b64f5d8cd0f@linux.intel.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

Ck9uIDIwMjEvMy8xMSAxMjoyMSDkuIvljYgsIFpodSBMaW5nc2hhbiB3cm90ZToKPgo+Cj4gT24g
My8xMS8yMDIxIDExOjIzIEFNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pgo+PiBPbiAyMDIxLzMvMTAg
NTowMCDkuIvljYgsIFpodSBMaW5nc2hhbiB3cm90ZToKPj4+IEluIHRoaXMgY29tbWl0LCBpZmN2
Zl9nZXRfdmVuZG9yX2lkKCkgd2lsbCByZXR1cm4KPj4+IGEgZGV2aWNlIHNwZWNpZmljIHZlbmRv
ciBpZCBvZiB0aGUgcHJvYmVkIHBjaSBkZXZpY2UKPj4+IHRoYW4gYSBoYXJkIGNvZGUuCj4+Pgo+
Pj4gU2lnbmVkLW9mZi1ieTogWmh1IExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+
Pj4gLS0tCj4+PiDCoCBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIHwgNSArKysrLQo+
Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pj4K
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIAo+Pj4gYi9k
cml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4+PiBpbmRleCBmYTFhZjMwMWNmNTUuLmU1
MDFlZTA3ZGUxNyAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWlu
LmMKPj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPj4+IEBAIC0zMjQs
NyArMzI0LDEwIEBAIHN0YXRpYyB1MzIgaWZjdmZfdmRwYV9nZXRfZGV2aWNlX2lkKHN0cnVjdCAK
Pj4+IHZkcGFfZGV2aWNlICp2ZHBhX2RldikKPj4+IMKgIMKgIHN0YXRpYyB1MzIgaWZjdmZfdmRw
YV9nZXRfdmVuZG9yX2lkKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9kZXYpCj4+PiDCoCB7Cj4+
PiAtwqDCoMKgIHJldHVybiBJRkNWRl9TVUJTWVNfVkVORE9SX0lEOwo+Pj4gK8KgwqDCoCBzdHJ1
Y3QgaWZjdmZfYWRhcHRlciAqYWRhcHRlciA9IHZkcGFfdG9fYWRhcHRlcih2ZHBhX2Rldik7Cj4+
PiArwqDCoMKgIHN0cnVjdCBwY2lfZGV2ICpwZGV2ID0gYWRhcHRlci0+cGRldjsKPj4+ICsKPj4+
ICvCoMKgwqAgcmV0dXJuIHBkZXYtPnN1YnN5c3RlbV92ZW5kb3I7Cj4+PiDCoCB9Cj4+Cj4+Cj4+
IFdoaWxlIGF0IHRoaXMsIEkgd29uZGVyIGlmIHdlIGNhbiBkbyBzb21ldGhpbmcgc2ltaWxhciBp
biAKPj4gZ2V0X2RldmljZV9pZCgpIGlmIGl0IGNvdWxkIGJlIHNpbXBsZSBkZWR1Y2VkIGZyb20g
c29tZSBzaW1wbGUgbWF0aCAKPj4gZnJvbSB0aGUgcGNpIGRldmljZSBpZD8KPj4KPj4gVGhhbmtz
Cj4gSGkgSmFzb24sCj4KPiBJTUhPLCB0aGlzIGltcGxlbWVudGF0aW9uIGlzIGp1c3Qgc29tZSBt
ZW1vcnkgcmVhZCBvcHMsIEkgdGhpbmsgb3RoZXIgCj4gaW1wbGVtZW50YXRpb25zIG1heSBub3Qg
c2F2ZSBtYW55IGNwdSBjeWNsZXMsIGFuIGlmIGNvc3QgYXQgbGVhc3QgCj4gdGhyZWUgY3B1IGN5
Y2xlcy4KPgo+IFRoYW5rcyEKCgpXZWxsLCBJIG1lYW50IHdoZWh0ZXIgeW91IGNhbiBkZWR1Y2Ug
dmlydGlvIGRldmljZSBpZCBmcm9tIApwZGV2LT5zdWJzeXN0ZW1fZGV2aWNlLgoKVGhhbmtzCgoK
Pj4KPj4KPj4+IMKgIMKgIHN0YXRpYyB1MzIgaWZjdmZfdmRwYV9nZXRfdnFfYWxpZ24oc3RydWN0
IHZkcGFfZGV2aWNlICp2ZHBhX2RldikKPj4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
