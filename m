Return-Path: <SRS0=byTZ=IU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E02C433DB
	for <virtualization@archiver.kernel.org>; Mon, 22 Mar 2021 03:43:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01C6F61944
	for <virtualization@archiver.kernel.org>; Mon, 22 Mar 2021 03:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C6F61944
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B2F574032D;
	Mon, 22 Mar 2021 03:43:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w1mI_rWai5u6; Mon, 22 Mar 2021 03:43:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 31241402EC;
	Mon, 22 Mar 2021 03:43:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08766C000A;
	Mon, 22 Mar 2021 03:43:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19034C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 03:43:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 07E0482B2F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 03:43:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c9zU2zDxomnF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 03:43:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5F12482B08
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 03:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616384586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s9aeaOu4BBMArdsItvL2pkshodWNoERpCDLkQgAkiDQ=;
 b=XU8v3VNWJpQJ89a6Y8F/DeRF5JhpTzuuE7THHP5w7Bb+JskqgGXOAbm9hpb897YlbzoPNN
 UlkPZXpJ3xgc1A3DqyGIE+dvCQrBtpyFlIDU2ExZQon7g6hyJOsXlW2Znd9/Rb6rMtiwyG
 ST/bUHwvP9vhN/Yt/zDNI+CenxvzRvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-mj6K3magMeiHqJy22sSI8w-1; Sun, 21 Mar 2021 23:43:03 -0400
X-MC-Unique: mj6K3magMeiHqJy22sSI8w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8DD080006E;
 Mon, 22 Mar 2021 03:43:02 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-188.pek2.redhat.com
 [10.72.13.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A0CE462A23;
 Mon, 22 Mar 2021 03:42:47 +0000 (UTC)
Subject: Re: [PATCH 3/3] fuse: fix typo for fuse_conn.max_pages comment
To: Connor Kuehl <ckuehl@redhat.com>, virtio-fs@redhat.com
References: <20210318135223.1342795-1-ckuehl@redhat.com>
 <20210318135223.1342795-4-ckuehl@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <71b3495d-655e-2258-969d-076c48d9f265@redhat.com>
Date: Mon, 22 Mar 2021 11:42:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210318135223.1342795-4-ckuehl@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: miklos@szeredi.hu, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, stefanha@redhat.com,
 linux-fsdevel@vger.kernel.org, vgoyal@redhat.com
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

CtTaIDIwMjEvMy8xOCDPws7nOTo1MiwgQ29ubm9yIEt1ZWhsINC0tcA6Cj4gJ01heG11bScgLT4g
J01heGltdW0nCgoKTmVlZCBhIGJldHRlciBsb2cgaGVyZS4KCldpdGggdGhlIGNvbW1pdCBsb2cg
Zml4ZWQuCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+Cj4g
U2lnbmVkLW9mZi1ieTogQ29ubm9yIEt1ZWhsIDxja3VlaGxAcmVkaGF0LmNvbT4KPiAtLS0KPiAg
IGZzL2Z1c2UvZnVzZV9pLmggfCAyICstCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9mcy9mdXNlL2Z1c2VfaS5oIGIvZnMv
ZnVzZS9mdXNlX2kuaAo+IGluZGV4IGYwZTRlZTkwNjQ2NC4uOGJkZWU3OWJhNTkzIDEwMDY0NAo+
IC0tLSBhL2ZzL2Z1c2UvZnVzZV9pLmgKPiArKysgYi9mcy9mdXNlL2Z1c2VfaS5oCj4gQEAgLTU1
Miw3ICs1NTIsNyBAQCBzdHJ1Y3QgZnVzZV9jb25uIHsKPiAgIAkvKiogTWF4aW11bSB3cml0ZSBz
aXplICovCj4gICAJdW5zaWduZWQgbWF4X3dyaXRlOwo+ICAgCj4gLQkvKiogTWF4bXVtIG51bWJl
ciBvZiBwYWdlcyB0aGF0IGNhbiBiZSB1c2VkIGluIGEgc2luZ2xlIHJlcXVlc3QgKi8KPiArCS8q
KiBNYXhpbXVtIG51bWJlciBvZiBwYWdlcyB0aGF0IGNhbiBiZSB1c2VkIGluIGEgc2luZ2xlIHJl
cXVlc3QgKi8KPiAgIAl1bnNpZ25lZCBpbnQgbWF4X3BhZ2VzOwo+ICAgCj4gICAjaWYgSVNfRU5B
QkxFRChDT05GSUdfVklSVElPX0ZTKQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
