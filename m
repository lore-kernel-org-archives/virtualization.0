Return-Path: <SRS0=dJY/=FV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE5CC4361B
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 03:20:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA980236F9
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 03:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA980236F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5A4F487851;
	Thu, 17 Dec 2020 03:20:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZYbAcZK1orqj; Thu, 17 Dec 2020 03:20:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D46C487848;
	Thu, 17 Dec 2020 03:20:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6810C0893;
	Thu, 17 Dec 2020 03:20:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B585C013B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 03:20:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 687622E153
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 03:20:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FG5it85XsfWB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 03:20:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 125BB2035C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 03:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608175215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WxrLNClNxtWpF/I0GtAX4YWo409+WYEx0FJBCyJA26c=;
 b=BPglwhxIjWpdYpxP22UmDwS0doFnJrhRCdkNza7TJgCr1sn3Td5mTWJMRoy8nZJ6PMQYyy
 vAlLXPnmW+n/s9oQA/62nUoJnyOui9S7TlJYsWL1uttMjGMc7f60je5X0HU2/S8RBInWNt
 DZOrnL58ptoCzy1a/wszhEtzAXPSST0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-vxQ0rYcbPOmjdfQFLGLTwA-1; Wed, 16 Dec 2020 22:20:13 -0500
X-MC-Unique: vxQ0rYcbPOmjdfQFLGLTwA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8037800D62;
 Thu, 17 Dec 2020 03:20:11 +0000 (UTC)
Received: from [10.72.12.223] (ovpn-12-223.pek2.redhat.com [10.72.12.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7104A10074E0;
 Thu, 17 Dec 2020 03:19:58 +0000 (UTC)
Subject: Re: [PATCH net v2 2/2] vhost_net: fix high cpu load when sendmsg fails
To: "Michael S. Tsirkin" <mst@redhat.com>, wangyunjian <wangyunjian@huawei.com>
References: <cover.1608065644.git.wangyunjian@huawei.com>
 <6b4c5fff8705dc4b5b6a25a45c50f36349350c73.1608065644.git.wangyunjian@huawei.com>
 <20201216042027-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <482e71e6-2c85-346f-d7f9-10db6a5c716b@redhat.com>
Date: Thu, 17 Dec 2020 11:19:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201216042027-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org,
 jerry.lilijun@huawei.com, virtualization@lists.linux-foundation.org,
 chenchanghu@huawei.com, brian.huangbin@huawei.com, xudingke@huawei.com
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

Ck9uIDIwMjAvMTIvMTYg5LiL5Y2INToyMywgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9u
IFdlZCwgRGVjIDE2LCAyMDIwIGF0IDA0OjIwOjM3UE0gKzA4MDAsIHdhbmd5dW5qaWFuIHdyb3Rl
Ogo+PiBGcm9tOiBZdW5qaWFuIFdhbmc8d2FuZ3l1bmppYW5AaHVhd2VpLmNvbT4KPj4KPj4gQ3Vy
cmVudGx5IHdlIGJyZWFrIHRoZSBsb29wIGFuZCB3YWtlIHVwIHRoZSB2aG9zdF93b3JrZXIgd2hl
bgo+PiBzZW5kbXNnIGZhaWxzLiBXaGVuIHRoZSB3b3JrZXIgd2FrZXMgdXAgYWdhaW4sIHdlJ2xs
IG1lZXQgdGhlCj4+IHNhbWUgZXJyb3IuIFRoaXMgd2lsbCBjYXVzZSBoaWdoIENQVSBsb2FkLiBU
byBmaXggdGhpcyBpc3N1ZSwKPj4gd2UgY2FuIHNraXAgdGhpcyBkZXNjcmlwdGlvbiBieSBpZ25v
cmluZyB0aGUgZXJyb3IuIFdoZW4gd2UKPj4gZXhjZWVkcyBzbmRidWYsIHRoZSByZXR1cm4gdmFs
dWUgb2Ygc2VuZG1zZyBpcyAtRUFHQUlOLiBJbgo+PiB0aGUgY2FzZSB3ZSBkb24ndCBza2lwIHRo
ZSBkZXNjcmlwdGlvbiBhbmQgZG9uJ3QgZHJvcCBwYWNrZXQuCj4gUXVlc3Rpb246IHdpdGggdGhp
cyBwYXRjaCwgd2hhdCBoYXBwZW5zIGlmIHNlbmRtc2cgaXMgaW50ZXJydXB0ZWQgYnkgYSBzaWdu
YWw/CgoKU2luY2Ugd2UgdXNlIE1TR19ET05UV0FJVCwgd2UgZG9uJ3QgbmVlZCB0byBjYXJlIGFi
b3V0IHNpZ25hbCBJIHRoaW5rLgoKVGhhbmtzCgoKPgo+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
