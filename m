Return-Path: <SRS0=SHSW=II=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BFCC433DB
	for <virtualization@archiver.kernel.org>; Wed, 10 Mar 2021 03:59:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C0CA64F80
	for <virtualization@archiver.kernel.org>; Wed, 10 Mar 2021 03:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C0CA64F80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A5FF4EBAF;
	Wed, 10 Mar 2021 03:59:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7WmgX2ZINKFx; Wed, 10 Mar 2021 03:59:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8014C4BA46;
	Wed, 10 Mar 2021 03:59:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6431AC000B;
	Wed, 10 Mar 2021 03:59:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE95FC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 03:59:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CF0454EBAF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 03:59:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nB3G0ZJqwi7e
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 03:59:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0283B4BA46
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 03:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615348773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zqvaTm0YYGfnIq7+2390v7zCd44rG+1I8H0HRw9yO+w=;
 b=Rfv47xLLNaBg035BBcXudLYlgavZkHiqwKl5EtxfL5fjoGpyRfn+OTW+pg2jmZYYrkeKj9
 m5Boz9Dfvz/ZLMEns3EVm1T5qOqMsYI65NQeZsc6sYsElreiv8rU7ps7ISnlJHEKaM52SN
 7hj+iW0bSqSIZ5mJ6c5RITKNROn81Ao=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-kucxnTcWNDy5a7PZoL9CWw-1; Tue, 09 Mar 2021 22:59:32 -0500
X-MC-Unique: kucxnTcWNDy5a7PZoL9CWw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 839FA80432D;
 Wed, 10 Mar 2021 03:59:29 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-88.pek2.redhat.com
 [10.72.12.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 356E65D9DB;
 Wed, 10 Mar 2021 03:59:10 +0000 (UTC)
Subject: Re: [PATCH v6] i2c: virtio: add a virtio i2c frontend driver
To: Jie Deng <jie.deng@intel.com>, linux-i2c@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <9a2086f37c0a62069b67c39a3f75941b78a0039c.1614749417.git.jie.deng@intel.com>
 <43b0842b-8b0f-1979-ed07-d6124e3a6b79@redhat.com>
 <db9350b3-b847-8f54-546f-9a0bdec425d4@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a3d4ce55-db25-5f96-ff44-5b76edfe9e08@redhat.com>
Date: Wed, 10 Mar 2021 11:59:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <db9350b3-b847-8f54-546f-9a0bdec425d4@intel.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Sergey.Semin@baikalelectronics.ru, bjorn.andersson@linaro.org,
 loic.poulain@linaro.org, yu1.wang@intel.com, arnd@arndb.de, mst@redhat.com,
 viresh.kumar@linaro.org, shuo.a.liu@intel.com, tali.perry1@gmail.com,
 wsa@kernel.org, wsa+renesas@sang-engineering.com, pbonzini@redhat.com,
 jarkko.nikula@linux.intel.com, stefanha@redhat.com,
 u.kleine-koenig@pengutronix.de, kblaiech@mellanox.com,
 andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, rppt@kernel.org
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

Ck9uIDIwMjEvMy8xMCAxMDoyMiDkuIrljYgsIEppZSBEZW5nIHdyb3RlOgo+Cj4gT24gMjAyMS8z
LzQgMTc6MTUsIEphc29uIFdhbmcgd3JvdGU6Cj4+Cj4+Cj4+PiArwqDCoMKgwqDCoMKgwqAgfQo+
Pj4gKwo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChtc2dzW2ldLmZsYWdzICYgSTJDX01fUkQpCj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtZW1jcHkobXNnc1tpXS5idWYsIHJlcS0+YnVmLCBt
c2dzW2ldLmxlbik7Cj4+Cj4+Cj4+IFNvcnJ5IGlmIEkgaGFkIGFza2VkIHRoaXMgYmVmb3JlIGJ1
dCBhbnkgcmFzb24gbm90IHRvIHVzZSBtc2dbaV0uYnVmIAo+PiBkaXJlY3RseT8KPj4KPj4KPiBU
aGUgbXNnW2ldLmJ1ZiBpcyBwYXNzZWQgYnkgdGhlIEkyQyBjb3JlLiBJIGp1c3Qgbm90aWNlZCB0
aGF0IHRoZXNlIAo+IGJ1ZnMgYXJlIG5vdAo+IGFsd2F5cyBhbGxvY2F0ZWQgYnkga21hbGxvYy4g
VGhleSBtYXkgY29tZSBmcm9tIHRoZSBzdGFjaywgd2hpY2ggbWF5IAo+IGNhdXNlCj4gdGhlIGNo
ZWNrICJzZ19pbml0X29uZSAtPiBzZ19zZXRfYnVmIC0+IHZpcnRfYWRkcl92YWxpZCLCoCB0byBm
YWlsLiAKPiBUaGVyZWZvcmUgdGhlCj4gbXNnW2ldLmJ1ZiBpcyBub3Qgc3VpdGFibGUgZm9yIGRp
cmVjdCB1c2UgaGVyZS4KPgo+IFJlZ2FyZHMuCgoKUmlnaHQsIHN0YWNrIGlzIHZpcnR1YWxseSBt
YXBwZWQuCgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
