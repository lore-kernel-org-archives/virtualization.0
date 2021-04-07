Return-Path: <SRS0=59V0=JE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2411CC433B4
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 05:33:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF19D61168
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 05:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF19D61168
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4BE5140EFF;
	Wed,  7 Apr 2021 05:33:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OXD-vGak7uol; Wed,  7 Apr 2021 05:33:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id B31B040F05;
	Wed,  7 Apr 2021 05:33:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F238C000B;
	Wed,  7 Apr 2021 05:33:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 205BCC000A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 05:33:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E9070405A8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 05:32:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 01M3lM9USG3W
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 05:32:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AA0BD4021A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 05:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617773577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=klnp/KcTmqzF8ET/QYKAXHemyaJMbc8NiniBXCEzHh8=;
 b=MS5j6DsXXDK6LlvzkWhqigV3dSnnjM2r1u5jTlVsEauxvvjjrcB0AzBNgfnvo5oIpTusC4
 /o07qAZ6FFUUPTS9o1zeJeSwIb+a94gMLnXDqOqOp0AZwkARraIgqvyoumORL61PO9mVo5
 UZucDLAJOrMdZiXhrzSmTRsxXUToX8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-b6XwmGhrM6e_2-2WdPXoSQ-1; Wed, 07 Apr 2021 01:32:53 -0400
X-MC-Unique: b6XwmGhrM6e_2-2WdPXoSQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4501E5704E;
 Wed,  7 Apr 2021 05:32:52 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-160.pek2.redhat.com
 [10.72.13.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 93E6A5D9CA;
 Wed,  7 Apr 2021 05:32:47 +0000 (UTC)
Subject: Re: [PATCH linux-next v2 08/14] vdpa/mlx5: Retrieve BAR address
 suitable any function
To: Parav Pandit <parav@nvidia.com>, virtualization@lists.linux-foundation.org
References: <20210406170457.98481-1-parav@nvidia.com>
 <20210406170457.98481-9-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <19f4ee55-5789-4ece-ee8a-ab4693a17dd7@redhat.com>
Date: Wed, 7 Apr 2021 13:32:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210406170457.98481-9-parav@nvidia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: elic@nvidia.com, mst@redhat.com
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNC83IMnPzucxOjA0LCBQYXJhdiBQYW5kaXQg0LS1wDoKPiBGcm9tOiBFbGkgQ29o
ZW4gPGVsaWNAbnZpZGlhLmNvbT4KPgo+IHN0cnVjdCBtbHg1X2NvcmVfZGV2IGhhcyBhIGJhcl9h
ZGRyIGZpZWxkIHRoYXQgY29udGFpbnMgdGhlIGNvcnJlY3QgYmFyCj4gYWRkcmVzcyBmb3IgdGhl
IGZ1bmN0aW9uIHJlZ2FyZGxlc3Mgb2Ygd2hldGhlciBpdCBpcyBwY2kgZnVuY3Rpb24gb3Igc3Vi
Cj4gZnVuY3Rpb24uIFVzZSBpdC4KPgo+IFNpZ25lZC1vZmYtYnk6IEVsaSBDb2hlbiA8ZWxpY0Bu
dmlkaWEuY29tPgo+IFJldmlld2VkLWJ5OiBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRpYS5jb20+
Cj4gLS0tCj4gY2hhbmdlbG9nOgo+IHYxLT52MjoKPiAgIC0gbmV3IHBhdGNoCj4gLS0tCj4gICBk
cml2ZXJzL3ZkcGEvbWx4NS9jb3JlL3Jlc291cmNlcy5jIHwgMyArKy0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3ZkcGEvbWx4NS9jb3JlL3Jlc291cmNlcy5jIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9y
ZXNvdXJjZXMuYwo+IGluZGV4IDk2ZTY0MjFjNWQxYy4uNjUyMWNiZDBmNWMyIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvcmVzb3VyY2VzLmMKPiArKysgYi9kcml2ZXJzL3Zk
cGEvbWx4NS9jb3JlL3Jlc291cmNlcy5jCj4gQEAgLTI0Niw3ICsyNDYsOCBAQCBpbnQgbWx4NV92
ZHBhX2FsbG9jX3Jlc291cmNlcyhzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYpCj4gICAJaWYg
KGVycikKPiAgIAkJZ290byBlcnJfa2V5Owo+ICAgCj4gLQlraWNrX2FkZHIgPSBwY2lfcmVzb3Vy
Y2Vfc3RhcnQobWRldi0+cGRldiwgMCkgKyBvZmZzZXQ7Cj4gKwlraWNrX2FkZHIgPSBtZGV2LT5i
YXJfYWRkciArIG9mZnNldDsKPiArCj4gICAJcmVzLT5raWNrX2FkZHIgPSBpb3JlbWFwKGtpY2tf
YWRkciwgUEFHRV9TSVpFKTsKPiAgIAlpZiAoIXJlcy0+a2lja19hZGRyKSB7Cj4gICAJCWVyciA9
IC1FTk9NRU07CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
