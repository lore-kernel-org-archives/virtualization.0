Return-Path: <SRS0=iZVf=BO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2F4C433E1
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 02:43:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 575FF20786
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 02:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/jKRpVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575FF20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id EDA45877B1;
	Tue,  4 Aug 2020 02:43:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kJ3hYuQNiMXn; Tue,  4 Aug 2020 02:43:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4984C86BE2;
	Tue,  4 Aug 2020 02:43:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 294B7C0050;
	Tue,  4 Aug 2020 02:43:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 893B8C004C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 02:43:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6FFD9877B1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 02:43:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UHp2kx8g26Je
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 02:43:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 698EE86BE2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 02:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596509001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hp9A97oTrVOTq0PRhFxZTZEQWhgsYnn8g0JTZalBa94=;
 b=D/jKRpVMIVOP+sN9yDOlJRvVzb4ZVElYDTY1H31xhFFPFjf4KyrD37wLrSDarYg0qdWUYa
 JL6RS7rBRbI14nxN1W5MV1Ku9/Iv3lhSBVpZVZvbh1654u+h80LkVYctmKyIhoh4GPqOIi
 n1m3pv3z5ky2NjKYGGJ5feA8XRz3/rA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-FKQ4etofOjOF5d755bXmuw-1; Mon, 03 Aug 2020 22:43:17 -0400
X-MC-Unique: FKQ4etofOjOF5d755bXmuw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 437248017FB;
 Tue,  4 Aug 2020 02:43:16 +0000 (UTC)
Received: from [10.72.13.197] (ovpn-13-197.pek2.redhat.com [10.72.13.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A176E7852C;
 Tue,  4 Aug 2020 02:42:57 +0000 (UTC)
Subject: Re: [PATCH -next v3] virtio_ring: Avoid loop when vq is broken in
 virtqueue_poll
To: Mao Wenan <wenan.mao@linux.alibaba.com>, mst@redhat.com
References: <20200802022549-mutt-send-email-mst@kernel.org>
 <1596354249-96204-1-git-send-email-wenan.mao@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <12bf457d-1283-62c6-6901-29e7a14831ca@redhat.com>
Date: Tue, 4 Aug 2020 10:42:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596354249-96204-1-git-send-email-wenan.mao@linux.alibaba.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Ck9uIDIwMjAvOC8yIOS4i+WNiDM6NDQsIE1hbyBXZW5hbiB3cm90ZToKPiBUaGUgbG9vcCBtYXkg
ZXhpc3QgaWYgdnEtPmJyb2tlbiBpcyB0cnVlLAo+IHZpcnRxdWV1ZV9nZXRfYnVmX2N0eF9wYWNr
ZWQgb3IgdmlydHF1ZXVlX2dldF9idWZfY3R4X3NwbGl0Cj4gd2lsbCByZXR1cm4gTlVMTCwgc28g
dmlydG5ldF9wb2xsIHdpbGwgcmVzY2hlZHVsZSBuYXBpIHRvCj4gcmVjZWl2ZSBwYWNrZXQsIGl0
IHdpbGwgbGVhZCBjcHUgdXNhZ2Uoc2kpIHRvIDEwMCUuCj4KPiBjYWxsIHRyYWNlIGFzIGJlbG93
Ogo+IHZpcnRuZXRfcG9sbAo+IAl2aXJ0bmV0X3JlY2VpdmUKPiAJCXZpcnRxdWV1ZV9nZXRfYnVm
X2N0eAo+IAkJCXZpcnRxdWV1ZV9nZXRfYnVmX2N0eF9wYWNrZWQKPiAJCQl2aXJ0cXVldWVfZ2V0
X2J1Zl9jdHhfc3BsaXQKPiAJdmlydHF1ZXVlX25hcGlfY29tcGxldGUKPiAJCXZpcnRxdWV1ZV9w
b2xsICAgICAgICAgICAvL3JldHVybiB0cnVlCj4gCQl2aXJ0cXVldWVfbmFwaV9zY2hlZHVsZSAv
L2l0IHdpbGwgcmVzY2hlZHVsZSBuYXBpCj4KPiB0byBmaXggdGhpcywgcmV0dXJuIGZhbHNlIGlm
IHZxIGlzIGJyb2tlbiBpbiB2aXJ0cXVldWVfcG9sbC4KPgo+IFNpZ25lZC1vZmYtYnk6IE1hbyBX
ZW5hbiA8d2VuYW4ubWFvQGxpbnV4LmFsaWJhYmEuY29tPgo+IEFja2VkLWJ5OiBNaWNoYWVsIFMu
IFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgo+IC0tLQo+ICAgdjItPnYzOiBjaGFuZ2Ugc3ViamVj
dCwgb3JpZ2luYWwgaXMgOiAidmlydGlvX25ldDogQXZvaWQgbG9vcCBpbiB2aXJ0bmV0X3BvbGwi
Cj4gICB2MS0+djI6IGZpeCBpdCBpbiB2aXJ0cXVldWVfcG9sbCBzdWdnZXN0ZWQgYnkgTWljaGFl
bCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4KPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19y
aW5nLmMgfCAzICsrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcmluZy5jCj4gaW5kZXggNThiOTZiYS4uNGY3YzczZSAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jp
bmcuYwo+IEBAIC0xOTYwLDYgKzE5NjAsOSBAQCBib29sIHZpcnRxdWV1ZV9wb2xsKHN0cnVjdCB2
aXJ0cXVldWUgKl92cSwgdW5zaWduZWQgbGFzdF91c2VkX2lkeCkKPiAgIHsKPiAgIAlzdHJ1Y3Qg
dnJpbmdfdmlydHF1ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+ICAgCj4gKwlpZiAodW5saWtlbHko
dnEtPmJyb2tlbikpCj4gKwkJcmV0dXJuIGZhbHNlOwo+ICsKPiAgIAl2aXJ0aW9fbWIodnEtPndl
YWtfYmFycmllcnMpOwo+ICAgCXJldHVybiB2cS0+cGFja2VkX3JpbmcgPyB2aXJ0cXVldWVfcG9s
bF9wYWNrZWQoX3ZxLCBsYXN0X3VzZWRfaWR4KSA6Cj4gICAJCQkJIHZpcnRxdWV1ZV9wb2xsX3Nw
bGl0KF92cSwgbGFzdF91c2VkX2lkeCk7CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
