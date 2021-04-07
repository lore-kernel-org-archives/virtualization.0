Return-Path: <SRS0=59V0=JE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094A6C433B4
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 09:31:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9435E61139
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 09:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9435E61139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2FDB360A45;
	Wed,  7 Apr 2021 09:31:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wRotFLulplw4; Wed,  7 Apr 2021 09:31:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 688A360595;
	Wed,  7 Apr 2021 09:31:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37358C000C;
	Wed,  7 Apr 2021 09:31:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 706E0C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 09:31:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 55A28414EE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 09:31:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XGnabNRmZnOC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 09:31:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9146F41462
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 09:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617787865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bLU8dIeLbeTGtWFozDr6nuNlzZcXd8594Ubbl7h9kSE=;
 b=QpXbOohsb06R9kftZB9UiyJq4zOfGxhWGshefsXi6nLJFJ3umSIsMJO3UvZT8qSuuF4AfU
 WILrMDFws2Ur+lRrFuFmuooGbcmi+kmNm38x4tNaxWBYvI4R59Oy3FRX9UXXhLSGOaM73G
 /3EjZgsBdby2VdKC3MGyWxvvXKIWEUI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-1eobrNgrNz2QBUqAWKPJ9Q-1; Wed, 07 Apr 2021 05:30:58 -0400
X-MC-Unique: 1eobrNgrNz2QBUqAWKPJ9Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5422887A826;
 Wed,  7 Apr 2021 09:30:56 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-236.pek2.redhat.com
 [10.72.13.236])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ACA6F5C1A1;
 Wed,  7 Apr 2021 09:30:46 +0000 (UTC)
Subject: Re: [PATCH net-next v3 8/8] virtio-net: free old xmit handle xsk
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1617787566.555242-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8417076f-e838-fd75-0f8f-56624c12e0a7@redhat.com>
Date: Wed, 7 Apr 2021 17:30:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <1617787566.555242-6-xuanzhuo@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 netdev@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Dust Li <dust.li@linux.alibaba.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

CuWcqCAyMDIxLzQvNyDkuIvljYg1OjI2LCBYdWFuIFpodW8g5YaZ6YGTOgo+Pj4gKwlfX2ZyZWVf
b2xkX3htaXQoc3EsIGZhbHNlLCAmc3RhdHMpOwo+PiBMZXQncyB1c2UgYSBzZXBhcmF0ZSBwYXRj
aCBmb3IgdGhpcyBraW5kIG9mIGZhY3RvcmluZy4KPj4KPiBJdCBpcyBhbHNvIHBvc3NpYmxlIHRv
IGVuY291bnRlciB4c2sgaGVyZSwgc28gaXQgc2hvdWxkIG5vdCBiZSBhIHNlcGFyYXRlIHBhdGNo
Lgo+Cj4gVGhhbmtzLgoKCllvdSBjYW4gZG8gdGhlIGZhY3RvcmluZyBmaXJzdCBhbmQgYWRkIHhz
ayBzdHVmZnMgb24gdG9wLgoKVGhhbmtzCgoKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
