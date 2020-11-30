Return-Path: <SRS0=9iyF=FE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F72AC63777
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 03:16:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1278520691
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 03:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0CEOUac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1278520691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D976E87281;
	Mon, 30 Nov 2020 03:16:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hqIZGrMiEV5q; Mon, 30 Nov 2020 03:16:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5827087256;
	Mon, 30 Nov 2020 03:16:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A44FC163C;
	Mon, 30 Nov 2020 03:16:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15F51C0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:16:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 04ADC8725E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:16:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2wOWL+Cy8EIG
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:16:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6103B87256
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606706182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3YOBvfhhlFFo3dwfriq09oew+AgJp9hrH3M7EIqOG/o=;
 b=P0CEOUacT/6K8+/+4jyq4lCQh6KRUiRKSMhvPKwwrQiLB+1SZM6PAYDzbXCNqZB0MlBFVe
 RB7T6zclvgjMbaVahU+9R7bnYg28jFlTTc0yLUmtbxQtpIX0BtEbgfCWRI8hHZazi8UuXC
 Q6HbkX8Dp4PxdGMWW/zsZhXUXIUs8OY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-7lw4UWtvM06MFf3UiC0MfQ-1; Sun, 29 Nov 2020 22:16:18 -0500
X-MC-Unique: 7lw4UWtvM06MFf3UiC0MfQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 778C11E7EF;
 Mon, 30 Nov 2020 03:16:17 +0000 (UTC)
Received: from [10.72.13.173] (ovpn-13-173.pek2.redhat.com [10.72.13.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F6135D9D2;
 Mon, 30 Nov 2020 03:16:08 +0000 (UTC)
Subject: Re: [PATCH v2 09/17] vdpa_sim: add work_fn in vdpasim_dev_attr
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-10-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6824a28b-8611-d83e-259c-d84be8513683@redhat.com>
Date: Mon, 30 Nov 2020 11:16:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126144950.92850-10-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>
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

Ck9uIDIwMjAvMTEvMjYg5LiL5Y2IMTA6NDksIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiBS
ZW5hbWUgdmRwYXNpbV93b3JrKCkgaW4gdmRwYXNpbV9uZXRfd29yaygpIGFuZCBhZGQgaXQgdG8K
PiB0aGUgdmRwYXNpbV9kZXZfYXR0ciBzdHJ1Y3R1cmUuCj4KPiBDby1kZXZlbG9wZWQtYnk6IE1h
eCBHdXJ0b3ZveSA8bWd1cnRvdm95QG52aWRpYS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogTWF4IEd1
cnRvdm95IDxtZ3VydG92b3lAbnZpZGlhLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW5vIEdh
cnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvdmRw
YV9zaW0vdmRwYV9zaW0uYyB8IDcgKysrKystLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4KCgo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBh
X3NpbS5jIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPiBpbmRleCAzNjY3N2Zj
MzYzMWIuLmI4NGQ5YWNkMTMwYyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0v
dmRwYV9zaW0uYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4gQEAg
LTYwLDYgKzYwLDggQEAgc3RydWN0IHZkcGFzaW1fZGV2X2F0dHIgewo+ICAgCXU2NCBzdXBwb3J0
ZWRfZmVhdHVyZXM7Cj4gICAJaW50IG52cXM7Cj4gICAJdTMyIGlkOwo+ICsKPiArCXdvcmtfZnVu
Y190IHdvcmtfZm47Cj4gICB9Owo+ICAgCj4gICAvKiBTdGF0ZSBvZiBlYWNoIHZkcGFzaW0gZGV2
aWNlICovCj4gQEAgLTE1Myw3ICsxNTUsNyBAQCBzdGF0aWMgdm9pZCB2ZHBhc2ltX3Jlc2V0KHN0
cnVjdCB2ZHBhc2ltICp2ZHBhc2ltKQo+ICAgCSsrdmRwYXNpbS0+Z2VuZXJhdGlvbjsKPiAgIH0K
PiAgIAo+IC1zdGF0aWMgdm9pZCB2ZHBhc2ltX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3Jr
KQo+ICtzdGF0aWMgdm9pZCB2ZHBhc2ltX25ldF93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29y
aykKPiAgIHsKPiAgIAlzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSA9IGNvbnRhaW5lcl9vZih3b3Jr
LCBzdHJ1Y3QKPiAgIAkJCQkJCSB2ZHBhc2ltLCB3b3JrKTsKPiBAQCAtMzYwLDcgKzM2Miw3IEBA
IHN0YXRpYyBzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbV9jcmVhdGUoc3RydWN0IHZkcGFzaW1fZGV2
X2F0dHIgKmRldl9hdHRyKQo+ICAgCQlnb3RvIGVycl9hbGxvYzsKPiAgIAo+ICAgCXZkcGFzaW0t
PmRldl9hdHRyID0gKmRldl9hdHRyOwo+IC0JSU5JVF9XT1JLKCZ2ZHBhc2ltLT53b3JrLCB2ZHBh
c2ltX3dvcmspOwo+ICsJSU5JVF9XT1JLKCZ2ZHBhc2ltLT53b3JrLCBkZXZfYXR0ci0+d29ya19m
bik7Cj4gICAJc3Bpbl9sb2NrX2luaXQoJnZkcGFzaW0tPmxvY2spOwo+ICAgCXNwaW5fbG9ja19p
bml0KCZ2ZHBhc2ltLT5pb21tdV9sb2NrKTsKPiAgIAo+IEBAIC03MzAsNiArNzMyLDcgQEAgc3Rh
dGljIGludCBfX2luaXQgdmRwYXNpbV9kZXZfaW5pdCh2b2lkKQo+ICAgCWRldl9hdHRyLmlkID0g
VklSVElPX0lEX05FVDsKPiAgIAlkZXZfYXR0ci5zdXBwb3J0ZWRfZmVhdHVyZXMgPSBWRFBBU0lN
X05FVF9GRUFUVVJFUzsKPiAgIAlkZXZfYXR0ci5udnFzID0gVkRQQVNJTV9WUV9OVU07Cj4gKwlk
ZXZfYXR0ci53b3JrX2ZuID0gdmRwYXNpbV9uZXRfd29yazsKPiAgIAo+ICAgCXZkcGFzaW1fZGV2
ID0gdmRwYXNpbV9jcmVhdGUoJmRldl9hdHRyKTsKPiAgIAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
