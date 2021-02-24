Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49B8C433DB
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 09:13:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47F4D64D79
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 09:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F4D64D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D2746F5F5;
	Wed, 24 Feb 2021 09:13:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5vXOUz94UZcR; Wed, 24 Feb 2021 09:13:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 33F4C6F5E9;
	Wed, 24 Feb 2021 09:13:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C9A0C000B;
	Wed, 24 Feb 2021 09:13:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7A03C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 09:13:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C8A4D4EBCC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 09:13:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 63hnEDoiXuzS
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 09:13:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E1FF64C8BF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 09:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614157984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=882FqVHlgt3C2JzonU+gvirRUujkP7ELBj9xrL7rlig=;
 b=Z9R4bfgoWsw2kFDQk1MijBuxw5zrrmePqd8BMGlbMu9pEkxZj7azUexQ+ucGrt6WrWwLct
 NLzSa0hQik9OiSn088wsVRAXOwF2t48UTOUtZZ5Lv58pIaOVa5gQ2FFc69Hucgql8auRVf
 08PrSEGZEYJYdBADzo/+HcABTF7nZeM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-EVm0NHeeMUKX4yq2f1yplg-1; Wed, 24 Feb 2021 04:11:29 -0500
X-MC-Unique: EVm0NHeeMUKX4yq2f1yplg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6F1F1020C24;
 Wed, 24 Feb 2021 09:11:28 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-28.pek2.redhat.com
 [10.72.12.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A5E235D9D0;
 Wed, 24 Feb 2021 09:11:24 +0000 (UTC)
Subject: Re: [PATCH linux-next 7/9] vdpa/mlx5: Provide device generated random
 MAC address
To: Parav Pandit <parav@nvidia.com>, virtualization@lists.linux-foundation.org
References: <20210224061844.137776-1-parav@nvidia.com>
 <20210224061844.137776-8-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <97a01cb9-8278-1ed6-59b5-807c58523c82@redhat.com>
Date: Wed, 24 Feb 2021 17:11:23 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210224061844.137776-8-parav@nvidia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
aSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPgo+Cj4gVXNlIGEgcmFuZG9tbHkgZ2VuZXJhdGVkIE1B
QyBhZGRyZXNzIHRvIGJlIGFwcGxpZWQgaW4gY2FzZSBpdCBpcyBub3QKPiBjb25maWd1cmVkIGJ5
IG1hbmFnZW1lbnQgdG9vbC4KPgo+IFRoZSB2YWx1ZSBxdWVyaWVkIHRocm91Z2ggbWx4NV9xdWVy
eV9uaWNfdnBvcnRfbWFjX2FkZHJlc3MoKSBpcyBub3QKPiByZWxlbGF2bnQgdG8gdmRwYSBzaW5j
ZSBpdCBpcyB0aGUgbWFjIHRoYXQgc2hvdWxkIGJlIHVzZWQgYnkgdGhlIHJlZ3VsYXIKPiBOSUMg
ZHJpdmVyLgo+Cj4gU2lnbmVkLW9mZi1ieTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+Cj4g
UmV2aWV3ZWQtYnk6IFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZpZGlhLmNvbT4KCgpBY2tlZC1ieTog
SmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAgZHJpdmVycy92ZHBh
L21seDUvbmV0L21seDVfdm5ldC5jIHwgNSArLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCA0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9t
bHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+
IGluZGV4IGI2N2JiYTU4MWRmZC4uZWNlMjE4M2U3YjIwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
dmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9t
bHg1X3ZuZXQuYwo+IEBAIC0yMDA1LDEwICsyMDA1LDcgQEAgc3RhdGljIGludCBtbHg1X3ZkcGFf
ZGV2X2FkZChzdHJ1Y3QgdmRwYV9tZ210X2RldiAqdl9tZGV2LCBjb25zdCBjaGFyICpuYW1lKQo+
ICAgCWlmIChlcnIpCj4gICAJCWdvdG8gZXJyX210dTsKPiAgIAo+IC0JZXJyID0gbWx4NV9xdWVy
eV9uaWNfdnBvcnRfbWFjX2FkZHJlc3MobWRldiwgMCwgMCwgY29uZmlnLT5tYWMpOwo+IC0JaWYg
KGVycikKPiAtCQlnb3RvIGVycl9tdHU7Cj4gLQo+ICsJZXRoX3JhbmRvbV9hZGRyKGNvbmZpZy0+
bWFjKTsKPiAgIAltdmRldi0+dmRldi5kbWFfZGV2ID0gbWRldi0+ZGV2aWNlOwo+ICAgCWVyciA9
IG1seDVfdmRwYV9hbGxvY19yZXNvdXJjZXMoJm5kZXYtPm12ZGV2KTsKPiAgIAlpZiAoZXJyKQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
