Return-Path: <SRS0=QXZB=GC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD41C433DB
	for <virtualization@archiver.kernel.org>; Wed, 30 Dec 2020 06:34:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FD20207B0
	for <virtualization@archiver.kernel.org>; Wed, 30 Dec 2020 06:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD20207B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1E9E586AB2;
	Wed, 30 Dec 2020 06:34:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DV9quqEuKyqo; Wed, 30 Dec 2020 06:34:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 18E0F85374;
	Wed, 30 Dec 2020 06:34:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDDC2C0893;
	Wed, 30 Dec 2020 06:34:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1AF0C0174
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 06:34:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D072D85EF9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 06:34:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vj4opUYDdFQW
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 06:34:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1C2D885374
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 06:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609310053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eBNGzwi7egS/zPmLxQnZGEadManYeUMP6ZIVWQPjrak=;
 b=P2bd1VgWhmdmdFXmQ4r4SHoIb0enaVbs/53rBM9/wJtH8t9IV6moEHp5wX8voCtdPCir3c
 XWCHZr1PUBx3s4EekXKTjarE3uMmUHnu7csGnJ5rT6c29sbKANEbF1hE6KwhLxC78n3q1N
 fqx60hY9bmaVK2JlumHJbBQrrwWtZXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-wWbJRowYPJ6KjjyT4C-i_Q-1; Wed, 30 Dec 2020 01:34:10 -0500
X-MC-Unique: wWbJRowYPJ6KjjyT4C-i_Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 550E11005504;
 Wed, 30 Dec 2020 06:34:08 +0000 (UTC)
Received: from [10.72.13.30] (ovpn-13-30.pek2.redhat.com [10.72.13.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 61882709B7;
 Wed, 30 Dec 2020 06:33:54 +0000 (UTC)
Subject: Re: [PATCH 11/21] vhost-vdpa: introduce asid based IOTLB
To: Eli Cohen <elic@nvidia.com>
References: <20201216064818.48239-1-jasowang@redhat.com>
 <20201216064818.48239-12-jasowang@redhat.com>
 <20201229120504.GE195479@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <bc85dfe9-7689-2be1-b124-0f0529e1d8dc@redhat.com>
Date: Wed, 30 Dec 2020 14:33:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201229120504.GE195479@mtl-vdi-166.wap.labs.mlnx>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: lulu@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 stefanha@redhat.com, eli@mellanox.com, lingshan.zhu@intel.com,
 rob.miller@broadcom.com
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

Ck9uIDIwMjAvMTIvMjkg5LiL5Y2IODowNSwgRWxpIENvaGVuIHdyb3RlOgo+PiArCj4+ICtzdGF0
aWMgaW50IHZob3N0X3ZkcGFfcmVtb3ZlX2FzKHN0cnVjdCB2aG9zdF92ZHBhICp2LCB1MzIgYXNp
ZCkKPiBUaGUgcmV0dXJuIHZhbHVlIGlzIG5ldmVyIGludGVycHJldGVkLiBJIHRoaW5rIGl0IHNo
b3VsZCBlaXRoZXIgYmUgbWFkZQo+IHZvaWQgb3IgcmV0dXJuIHZhbHVlcyBjaGVja2VkLgoKClJp
Z2h0LCB3aWxsIG1ha2UgaXQgdm9pZC4KCgo+Cj4+ICt7Cj4+ICsJc3RydWN0IHZob3N0X3ZkcGFf
YXMgKmFzID0gYXNpZF90b19hcyh2LCBhc2lkKTsKPj4gKwo+PiArCS8qIFJlbW92ZSBkZWZhdWx0
IGFkZHJlc3Mgc3BhY2UgaXMgbm90IGFsbG93ZWQgKi8KPj4gKwlpZiAoYXNpZCA9PSAwKQo+PiAr
CQlyZXR1cm4gLUVJTlZBTDsKPiBDYW4geW91IGV4cGxhaW4gd2h5PyBJIHRoaW5rIHlvdSBoYXZl
IGEgbWVtb3J5IGxlYWsgZHVlIHRvIHRoaXMgYXMgbm8KPiBvbmUgd2lsbCBldmVyIGZyZWUgYXMg
d2l0aCBpZCAwLgo+CgpMb29rcyBsaWtlIGEgYnVnLiBXaWxsIHJlbW92ZSB0aGlzLgoKVGhhbmtz
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
