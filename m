Return-Path: <SRS0=MC01=FN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34428C4361B
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 09:30:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3DAE23B7B
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 09:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3DAE23B7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1D9BD86E41;
	Wed,  9 Dec 2020 09:30:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OH-LaqlvBgPC; Wed,  9 Dec 2020 09:30:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1860186E3F;
	Wed,  9 Dec 2020 09:30:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E948BC0893;
	Wed,  9 Dec 2020 09:30:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A557C013B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 09:30:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3596086DE1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 09:30:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qouhIRVrZOWQ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 09:30:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 61B7786DA9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 09:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607506239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eIdwFldhm6zBa8ine4tHp/RGdsb0WnWCdNxasu3YKbA=;
 b=Yghfgu8z3RNCmESyo8k5LE0ClB58qCLQu1AOUtmDNmvfxmZvYMtdhULAKwl9s5wrFJrraG
 K8XCdxizHnxRV+UXGBcrRAwKgSIroxmJQAJyJXeDJUGVC/ZOqnwparUVf3/nVsZS0Px6yG
 689ejP/PRx7s095j/80vP4lPJsPt7fo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-2nC50HvXNnK0BgFAeTUY8w-1; Wed, 09 Dec 2020 04:30:37 -0500
X-MC-Unique: 2nC50HvXNnK0BgFAeTUY8w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C430A107ACF5;
 Wed,  9 Dec 2020 09:30:34 +0000 (UTC)
Received: from [10.72.12.31] (ovpn-12-31.pek2.redhat.com [10.72.12.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 45461100238C;
 Wed,  9 Dec 2020 09:30:25 +0000 (UTC)
Subject: Re: [PATCH net-next] tun: fix ubuf refcount incorrectly on error path
From: Jason Wang <jasowang@redhat.com>
To: wangyunjian <wangyunjian@huawei.com>, "mst@redhat.com" <mst@redhat.com>
References: <1606982459-41752-1-git-send-email-wangyunjian@huawei.com>
 <094f1828-9a73-033e-b1ca-43b73588d22b@redhat.com>
 <34EFBCA9F01B0748BEB6B629CE643AE60DB4E07B@dggemm513-mbx.china.huawei.com>
 <e972e42b-4344-31dc-eb4c-d963adb08a5c@redhat.com>
 <34EFBCA9F01B0748BEB6B629CE643AE60DB5CD27@DGGEMM533-MBX.china.huawei.com>
 <b70d75f3-d717-4cd6-4966-299916a223c3@redhat.com>
Message-ID: <c31de6ba-e758-1c42-b662-d1787ea8237c@redhat.com>
Date: Wed, 9 Dec 2020 17:30:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b70d75f3-d717-4cd6-4966-299916a223c3@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Lilijun \(Jerry\)" <jerry.lilijun@huawei.com>, xudingke <xudingke@huawei.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

Ck9uIDIwMjAvMTIvOCDkuIrljYgxMDozMiwgSmFzb24gV2FuZyB3cm90ZToKPgo+IE9uIDIwMjAv
MTIvNyDkuIvljYg5OjM4LCB3YW5neXVuamlhbiB3cm90ZToKPj4gSSB0aGluayB0aGUgbmV3bHkg
YWRkZWQgY29kZSBpcyBlYXN5IHRvIG1pc3MgdGhpcyBwcm9ibGVtLCBzbyBJIHdhbnQgdG8KPj4g
Y29weSB1YnVmX2luZm8gdW50aWwgd2UncmUgc3VyZSB0aGVyZSdzIG5vIGVycm9ycy4KPj4KPj4g
VGhhbmtzLAo+PiBZdW5qaWFuCj4KPgo+IEJ1dCBpc24ndCB0aGlzIGFjdHVhbGx5IGEgZGlzYWJs
aW5nIG9mIHplcm9jb3B5Pwo+Cj4gVGhhbmtzCj4KPgoKU29ycnksIEkgbWlzcmVhZCB0aGUgcGF0
Y2guCgpQbGVhc2Ugc2VuZCBhIGZvcm1hbCB2ZXJzaW9uLCBhbmQgbGV0J3MgbW92ZSB0aGUgZGlz
Y3Vzc2lvbiB0aGVyZS4KClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
