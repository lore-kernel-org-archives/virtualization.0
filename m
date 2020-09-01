Return-Path: <SRS0=JuYR=CK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8947EC433E6
	for <virtualization@archiver.kernel.org>; Tue,  1 Sep 2020 03:07:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5379F2073A
	for <virtualization@archiver.kernel.org>; Tue,  1 Sep 2020 03:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YHptFupO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5379F2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 223F386FC5;
	Tue,  1 Sep 2020 03:07:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lf6BXUaMBVix; Tue,  1 Sep 2020 03:07:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C891D86F95;
	Tue,  1 Sep 2020 03:07:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF692C0052;
	Tue,  1 Sep 2020 03:07:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF016C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 03:07:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BB84486F95
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 03:07:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7O5iG6JrHXUe
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 03:07:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DD9DA86F92
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 03:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598929628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NiMSZ2Bp0rwp10xCJBRx9TIWLthoqJ/GxVfGBmzS4Dk=;
 b=YHptFupOLGc7iYhOHOb6+kywhm8QS3EWM9PJytBXzethlOQnH+0tU0LO0V6MRXL54tiZJv
 Z/RVT60Nof2H3f7t8//Ja0k1qn+cJ/AulIle86V8LsJPi+mrJP3henJcFdqE8xlzgy2o2t
 XNo97GGLExPvpFRV38wMUG2H2si2qTM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-G9NcSATZMni7qWSgOVtv-A-1; Mon, 31 Aug 2020 23:07:04 -0400
X-MC-Unique: G9NcSATZMni7qWSgOVtv-A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE84C1888A1E;
 Tue,  1 Sep 2020 03:07:02 +0000 (UTC)
Received: from [10.72.13.164] (ovpn-13-164.pek2.redhat.com [10.72.13.164])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B891A7EB8A;
 Tue,  1 Sep 2020 03:06:57 +0000 (UTC)
Subject: Re: [PATCH net-next] vhost: fix typo in error message
To: Yunsheng Lin <linyunsheng@huawei.com>, mst@redhat.com
References: <1598927949-201997-1-git-send-email-linyunsheng@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <26f844a5-c7de-cb0b-35eb-e6e30425ed35@redhat.com>
Date: Tue, 1 Sep 2020 11:06:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1598927949-201997-1-git-send-email-linyunsheng@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: netdev@vger.kernel.org, linuxarm@huawei.com, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjAvOS8xIOS4iuWNiDEwOjM5LCBZdW5zaGVuZyBMaW4gd3JvdGU6Cj4gImVuYWJsZSIg
c2hvdWxkIGJlICJkaXNhYmxlIiB3aGVuIHRoZSBmdW5jdGlvbiBuYW1lIGlzCj4gdmhvc3RfZGlz
YWJsZV9ub3RpZnkoKSwgd2hpY2ggZG9lcyB0aGUgZGlzYWJsaW5nIHdvcmsuCj4KPiBTaWduZWQt
b2ZmLWJ5OiBZdW5zaGVuZyBMaW4gPGxpbnl1bnNoZW5nQGh1YXdlaS5jb20+Cj4gLS0tCj4gICBk
cml2ZXJzL3Zob3N0L3Zob3N0LmMgfCAyICstCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3Zob3N0
LmMgYi9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiBpbmRleCA1ODU3ZDRlLi5iNDU1MTljIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+ICsrKyBiL2RyaXZlcnMvdmhvc3Qvdmhv
c3QuYwo+IEBAIC0yNTM3LDcgKzI1MzcsNyBAQCB2b2lkIHZob3N0X2Rpc2FibGVfbm90aWZ5KHN0
cnVjdCB2aG9zdF9kZXYgKmRldiwgc3RydWN0IHZob3N0X3ZpcnRxdWV1ZSAqdnEpCj4gICAJaWYg
KCF2aG9zdF9oYXNfZmVhdHVyZSh2cSwgVklSVElPX1JJTkdfRl9FVkVOVF9JRFgpKSB7Cj4gICAJ
CXIgPSB2aG9zdF91cGRhdGVfdXNlZF9mbGFncyh2cSk7Cj4gICAJCWlmIChyKQo+IC0JCQl2cV9l
cnIodnEsICJGYWlsZWQgdG8gZW5hYmxlIG5vdGlmaWNhdGlvbiBhdCAlcDogJWRcbiIsCj4gKwkJ
CXZxX2Vycih2cSwgIkZhaWxlZCB0byBkaXNhYmxlIG5vdGlmaWNhdGlvbiBhdCAlcDogJWRcbiIs
Cj4gICAJCQkgICAgICAgJnZxLT51c2VkLT5mbGFncywgcik7Cj4gICAJfQo+ICAgfQoKCkFja2Vk
LWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
