Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7015DC433E0
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 09:12:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E6064E05
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 09:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E6064E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6234943092;
	Wed, 24 Feb 2021 09:12:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1YDYv47z4amA; Wed, 24 Feb 2021 09:12:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0029C43050;
	Wed, 24 Feb 2021 09:12:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8B9AC000B;
	Wed, 24 Feb 2021 09:12:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 471F4C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 09:12:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 292DF83CD9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 09:12:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id srq3eDMtuHAb
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 09:12:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5142483CA8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 09:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614157968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9QSuGw1zUzgxECYWYBf97Ue0BVoH4ZWqzeIx3W8sHVw=;
 b=c0Ztkikgnrr/oeil7lnnyqWzq+LVFHd4CYegij3yuOWPHZNAGJJxd9b3qxggt+vdvhl+pA
 0GYpMGvdMdLW4gB8IWqyQaPFHc/M4NDdYwmM33h0riL236J45wZv7t+idMFjWW2vRRvAg+
 OQOFGUZT1oZP7F82CpsXPUANTbPwtEs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-MQzIptiqOwWZ04KajVaTLw-1; Wed, 24 Feb 2021 04:12:14 -0500
X-MC-Unique: MQzIptiqOwWZ04KajVaTLw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 189F684E245;
 Wed, 24 Feb 2021 09:12:13 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-28.pek2.redhat.com
 [10.72.12.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7D1E6064B;
 Wed, 24 Feb 2021 09:12:08 +0000 (UTC)
Subject: Re: [PATCH linux-next 8/9] vdpa/mlx5: Support configuration of MAC
To: Parav Pandit <parav@nvidia.com>, virtualization@lists.linux-foundation.org
References: <20210224061844.137776-1-parav@nvidia.com>
 <20210224061844.137776-9-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <de2a5d99-90de-d333-ff9a-77ff6353583d@redhat.com>
Date: Wed, 24 Feb 2021 17:12:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210224061844.137776-9-parav@nvidia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-GB
Cc: Eli Cohen <elic@nvidia.com>, mst@redhat.com
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

Ck9uIDIwMjEvMi8yNCAyOjE4IOS4i+WNiCwgUGFyYXYgUGFuZGl0IHdyb3RlOgo+IEZyb206IEVs
aSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPgo+Cj4gQWRkIGNvZGUgdG8gYWNjZXB0IE1BQyBjb25m
aWd1cmF0aW9uIHRocm91Z2ggdmRwYSB0b29sLiBUaGUgTUFDIGlzCj4gd3JpdHRlbiBpbnRvIHRo
ZSBjb25maWcgc3RydWN0IGFuZCBsYXRlciBjYW4gYmUgcmV0cmlldmVkIHRocm91Z2gKPiBnZXRf
Y29uZmlnKCkuCj4KPiBFeGFtcGxlczoKPiAxLiBDb25maWd1cmUgTUFDOgo+ICQgdmRwYSBkZXYg
Y29uZmlnIHNldCB2ZHBhMCBtYWMgMDA6MTE6MjI6MzM6NDQ6NTUKPgo+IDIuIFNob3cgY29uZmln
dXJlZCBwYXJhbXM6Cj4gJCB2ZHBhIGRldiBjb25maWcgc2hvdwo+IHZkcGEwOiBtYWMgMDA6MTE6
MjI6MzM6NDQ6NTUgbGluayBkb3duIGxpbmtfYW5ub3VuY2UgZmFsc2UgbXR1IDAgc3BlZWQgMCBk
dXBsZXggMAo+Cj4gU2lnbmVkLW9mZi1ieTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+Cj4g
UmV2aWV3ZWQtYnk6IFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZpZGlhLmNvbT4KPiAtLS0KCgpBY2tl
ZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+ICAgZHJpdmVycy92ZHBh
L21seDUvbmV0L21seDVfdm5ldC5jIHwgMTcgKysrKysrKysrKysrKysrKysKPiAgIDEgZmlsZSBj
aGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21s
eDUvbmV0L21seDVfdm5ldC5jIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4g
aW5kZXggZWNlMjE4M2U3YjIwLi41MWEzZmM0Y2RlNGQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92
ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21s
eDVfdm5ldC5jCj4gQEAgLTE5NzIsNiArMTk3MiwyMiBAQCBzdHJ1Y3QgbWx4NV92ZHBhX21nbXRk
ZXYgewo+ICAgCXN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2Owo+ICAgfTsKPiAgIAo+ICtzdGF0
aWMgaW50IG1seDVfdmRwYV9uZXRfZGV2X2NvbmZpZ19zZXQoc3RydWN0IHZkcGFfbWdtdF9kZXYg
KnZfbWRldiwKPiArCQkJCQlzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsCj4gKwkJCQkJY29uc3Qg
c3RydWN0IHZkcGFfZGV2X2NvbmZpZ19zZXRfYXR0ciAqYXR0cnMpCj4gK3sKPiArCXN0cnVjdCBt
bHg1X3ZkcGFfbWdtdGRldiAqbWd0ZGV2ID0gY29udGFpbmVyX29mKHZfbWRldiwgc3RydWN0IG1s
eDVfdmRwYV9tZ210ZGV2LCBtZ3RkZXYpOwo+ICsJc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYg
PSBtZ3RkZXYtPm5kZXY7Cj4gKwo+ICsJaWYgKGF0dHJzLT5tYXNrLm10dV92YWxpZCkKPiArCQly
ZXR1cm4gLUVPUE5PVFNVUFA7Cj4gKwo+ICsJaWYgKGF0dHJzLT5tYXNrLm1hY192YWxpZCkKPiAr
CQltZW1jcHkobmRldi0+Y29uZmlnLm1hYywgYXR0cnMtPmNmZy5tYWMsIEVUSF9BTEVOKTsKPiAr
Cj4gKwlyZXR1cm4gMDsKPiArfQo+ICsKPiAgIHN0YXRpYyBpbnQgbWx4NV92ZHBhX2Rldl9hZGQo
c3RydWN0IHZkcGFfbWdtdF9kZXYgKnZfbWRldiwgY29uc3QgY2hhciAqbmFtZSkKPiAgIHsKPiAg
IAlzdHJ1Y3QgbWx4NV92ZHBhX21nbXRkZXYgKm1ndGRldiA9IGNvbnRhaW5lcl9vZih2X21kZXYs
IHN0cnVjdCBtbHg1X3ZkcGFfbWdtdGRldiwgbWd0ZGV2KTsKPiBAQCAtMjA0NCw2ICsyMDYwLDcg
QEAgc3RhdGljIHZvaWQgbWx4NV92ZHBhX2Rldl9kZWwoc3RydWN0IHZkcGFfbWdtdF9kZXYgKnZf
bWRldiwgc3RydWN0IHZkcGFfZGV2aWNlICoKPiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdmRwYV9t
Z210ZGV2X29wcyBtZGV2X29wcyA9IHsKPiAgIAkuZGV2X2FkZCA9IG1seDVfdmRwYV9kZXZfYWRk
LAo+ICAgCS5kZXZfZGVsID0gbWx4NV92ZHBhX2Rldl9kZWwsCj4gKwkuZGV2X2NvbmZpZ19zZXQg
PSBtbHg1X3ZkcGFfbmV0X2Rldl9jb25maWdfc2V0LAo+ICAgfTsKPiAgIAo+ICAgc3RhdGljIHN0
cnVjdCB2aXJ0aW9fZGV2aWNlX2lkIGlkX3RhYmxlW10gPSB7CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
