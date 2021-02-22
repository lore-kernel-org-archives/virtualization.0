Return-Path: <SRS0=djY9=HY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC09C433E0
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 03:46:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E96DD64DD3
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 03:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96DD64DD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B6ABA87092;
	Mon, 22 Feb 2021 03:46:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eGYZy3KFUztc; Mon, 22 Feb 2021 03:46:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 315BA87083;
	Mon, 22 Feb 2021 03:46:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18209C000B;
	Mon, 22 Feb 2021 03:46:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C046C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 03:46:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 50DBF83638
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 03:46:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 32FgrMegIg1r
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 03:46:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2620A83518
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 03:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613965558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qqlQReWjU6B7KnkKCdLl5ChxN886RQ4Qyk81WJRNAlE=;
 b=ih0iMevsi0jUgJtzDLqPoODG6h3JC1X/bGiKrNm8eXa9U0wslprG8XphkcaWn/f35lQXKJ
 yFx1SJ8SgFeXj2jZEozHd26K3kXnSlyOkM9/DXum/l6i/54ohmQdMyQQhROb0l2cILBsLj
 rUsYc0gD/Lvfv51q4/7MA4wEHaW2XSI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-3CzHHRC5Oe2noS9NGNWvVQ-1; Sun, 21 Feb 2021 22:45:35 -0500
X-MC-Unique: 3CzHHRC5Oe2noS9NGNWvVQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF0A118449E7;
 Mon, 22 Feb 2021 03:45:33 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-112.pek2.redhat.com
 [10.72.13.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A91610074E2;
 Mon, 22 Feb 2021 03:45:28 +0000 (UTC)
Subject: Re: [PATCH] virtio: remove export for virtio_config_{enable, disable}
To: Xianting Tian <xianting_tian@126.com>, mst@redhat.com
References: <1613838498-8791-1-git-send-email-xianting_tian@126.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6bc59452-5d9e-851a-6c03-3611c4c388f0@redhat.com>
Date: Mon, 22 Feb 2021 11:45:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1613838498-8791-1-git-send-email-xianting_tian@126.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: guoren@linux.alibaba.com, linux-kernel@vger.kernel.org,
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

Ck9uIDIwMjEvMi8yMSAxMjoyOCDkuIrljYgsIFhpYW50aW5nIFRpYW4gd3JvdGU6Cj4gdmlydGlv
X2NvbmZpZ19lbmFibGUoKSwgdmlydGlvX2NvbmZpZ19kaXNhYmxlKCkgYXJlIG9ubHkgdXNlZCBp
bnNpZGUKPiBkcml2ZXJzL3ZpcnRpby92aXJ0aW8uYywgc28gaXQgZG9lc24ndCBuZWVkIGV4cG9y
dCB0aGUgc3ltYm9scy4KPgo+IFNpZ25lZC1vZmYtYnk6IFhpYW50aW5nIFRpYW4gPHhpYW50aW5n
X3RpYW5AMTI2LmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4KCgo+IC0tLQo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvLmMgfCA2ICsrLS0tLQo+ICAgaW5j
bHVkZS9saW51eC92aXJ0aW8uaCAgfCAyIC0tCj4gICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92
aXJ0aW8uYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpby5jCj4gaW5kZXggNDJlMDljYy4uNGIxNWMw
MCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW8uYwo+ICsrKyBiL2RyaXZlcnMv
dmlydGlvL3ZpcnRpby5jCj4gQEAgLTE0MSwxNSArMTQxLDE0IEBAIHZvaWQgdmlydGlvX2NvbmZp
Z19jaGFuZ2VkKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICpkZXYpCj4gICB9Cj4gICBFWFBPUlRfU1lN
Qk9MX0dQTCh2aXJ0aW9fY29uZmlnX2NoYW5nZWQpOwo+ICAgCj4gLXZvaWQgdmlydGlvX2NvbmZp
Z19kaXNhYmxlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICpkZXYpCj4gK3N0YXRpYyB2b2lkIHZpcnRp
b19jb25maWdfZGlzYWJsZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqZGV2KQo+ICAgewo+ICAgCXNw
aW5fbG9ja19pcnEoJmRldi0+Y29uZmlnX2xvY2spOwo+ICAgCWRldi0+Y29uZmlnX2VuYWJsZWQg
PSBmYWxzZTsKPiAgIAlzcGluX3VubG9ja19pcnEoJmRldi0+Y29uZmlnX2xvY2spOwo+ICAgfQo+
IC1FWFBPUlRfU1lNQk9MX0dQTCh2aXJ0aW9fY29uZmlnX2Rpc2FibGUpOwo+ICAgCj4gLXZvaWQg
dmlydGlvX2NvbmZpZ19lbmFibGUoc3RydWN0IHZpcnRpb19kZXZpY2UgKmRldikKPiArc3RhdGlj
IHZvaWQgdmlydGlvX2NvbmZpZ19lbmFibGUoc3RydWN0IHZpcnRpb19kZXZpY2UgKmRldikKPiAg
IHsKPiAgIAlzcGluX2xvY2tfaXJxKCZkZXYtPmNvbmZpZ19sb2NrKTsKPiAgIAlkZXYtPmNvbmZp
Z19lbmFibGVkID0gdHJ1ZTsKPiBAQCAtMTU4LDcgKzE1Nyw2IEBAIHZvaWQgdmlydGlvX2NvbmZp
Z19lbmFibGUoc3RydWN0IHZpcnRpb19kZXZpY2UgKmRldikKPiAgIAlkZXYtPmNvbmZpZ19jaGFu
Z2VfcGVuZGluZyA9IGZhbHNlOwo+ICAgCXNwaW5fdW5sb2NrX2lycSgmZGV2LT5jb25maWdfbG9j
ayk7Cj4gICB9Cj4gLUVYUE9SVF9TWU1CT0xfR1BMKHZpcnRpb19jb25maWdfZW5hYmxlKTsKPiAg
IAo+ICAgdm9pZCB2aXJ0aW9fYWRkX3N0YXR1cyhzdHJ1Y3QgdmlydGlvX2RldmljZSAqZGV2LCB1
bnNpZ25lZCBpbnQgc3RhdHVzKQo+ICAgewo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3Zp
cnRpby5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW8uaAo+IGluZGV4IDU1ZWEzMjkuLmIxODk0ZTAg
MTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51eC92aXJ0aW8uaAo+ICsrKyBiL2luY2x1ZGUvbGlu
dXgvdmlydGlvLmgKPiBAQCAtMTMyLDggKzEzMiw2IEBAIHN0YXRpYyBpbmxpbmUgc3RydWN0IHZp
cnRpb19kZXZpY2UgKmRldl90b192aXJ0aW8oc3RydWN0IGRldmljZSAqX2RldikKPiAgIHZvaWQg
dmlydGlvX2JyZWFrX2RldmljZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqZGV2KTsKPiAgIAo+ICAg
dm9pZCB2aXJ0aW9fY29uZmlnX2NoYW5nZWQoc3RydWN0IHZpcnRpb19kZXZpY2UgKmRldik7Cj4g
LXZvaWQgdmlydGlvX2NvbmZpZ19kaXNhYmxlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICpkZXYpOwo+
IC12b2lkIHZpcnRpb19jb25maWdfZW5hYmxlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICpkZXYpOwo+
ICAgaW50IHZpcnRpb19maW5hbGl6ZV9mZWF0dXJlcyhzdHJ1Y3QgdmlydGlvX2RldmljZSAqZGV2
KTsKPiAgICNpZmRlZiBDT05GSUdfUE1fU0xFRVAKPiAgIGludCB2aXJ0aW9fZGV2aWNlX2ZyZWV6
ZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqZGV2KTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
