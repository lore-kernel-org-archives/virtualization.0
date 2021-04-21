Return-Path: <SRS0=p2bm=JS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA982C433B4
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 03:26:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 453A26141C
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 03:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453A26141C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDB504065B;
	Wed, 21 Apr 2021 03:26:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rSEefWKeWgl7; Wed, 21 Apr 2021 03:26:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27A9E40239;
	Wed, 21 Apr 2021 03:26:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED80CC000E;
	Wed, 21 Apr 2021 03:26:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9804DC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 03:26:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8537060B21
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 03:26:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M64GgDS_-MJH
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 03:26:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DFEA360A89
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 03:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618975588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+rTFD/AcsiNi1fg4RyPaqu9yvjl1cmnkSOqYmjolBh8=;
 b=S/7ou5nqZSoyLmY7koUmjxacfeZPlKlcLtohX3XlrQFWoHclC78ytROvAyB5buhff7ONb8
 kBL0ndfqFGpdrV25HX9K7cbu+HLlnftibzgMa2Ch7sumVECmC6Af/0DEoRqy9QISUAPaWd
 wuemV0RSteBDFz25jl2AC3U8R/LcF7Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-D-BMsYZpNSyF4ya5VuwDzg-1; Tue, 20 Apr 2021 23:26:26 -0400
X-MC-Unique: D-BMsYZpNSyF4ya5VuwDzg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0BBC801814;
 Wed, 21 Apr 2021 03:26:24 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-189.pek2.redhat.com
 [10.72.13.189])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D665E5D747;
 Wed, 21 Apr 2021 03:26:18 +0000 (UTC)
Subject: Re: [PATCH net-next v3] virtio-net: page_to_skb() use build_skb when
 there's sufficient tailroom
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <1618922142.0493622-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8e8e8f5c-16aa-668c-9567-b5c1f91e19dc@redhat.com>
Date: Wed, 21 Apr 2021 11:26:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <1618922142.0493622-1-xuanzhuo@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

CtTaIDIwMjEvNC8yMCDPws7nODozNSwgWHVhbiBaaHVvINC0tcA6Cj4+IEkgcmVhbGl6ZSB0aGlz
IGhhcyBiZWVuIG1lcmdlZCB0byBuZXQtbmV4dCBhbHJlYWR5LCBidXQgSSdtIGdldHRpbmcgYQo+
PiB1c2UtYWZ0ZXItZnJlZSB3aXRoIEtBU0FOIGluIHBhZ2VfdG9fc2tiKCkgd2l0aCB0aGlzIHBh
dGNoLiBSZXZlcnRpbmcgdGhpcwo+PiBjaGFuZ2UgZml4ZXMgdGhlIFVBRi4gSSd2ZSBpbmNsdWRl
ZCB0aGUgS0FTQU4gZHVtcCBiZWxvdywgYW5kIGEgY291cGxlIG9mCj4+IGNvbW1lbnRzIGlubGlu
ZS4KPiBJIHRoaW5rIHNvbWV0aGluZyB3ZW50IHdyb25nLCB0aGlzIHdhcyBtZXJnZWQgYmVmb3Jl
IGl0IHdhcyBhY2tlZC4gQmFzZWQgb24gdGhlCj4gSmFzb24gV2FuZydzIGNvbW1lbnRzLCB0aGVy
ZSBhcmUgc3RpbGwgc29tZSB0ZXN0cyB0aGF0IGhhdmUgbm90IGJlZW4gZG9uZT8KPgo+IElmIGl0
IGhhcyBiZWVuIG1lcmdlZCwgd2hhdCBzaG91bGQgSSBkbyBub3csIGNhbiBJIG1ha2UgdXAgdGhl
IHRlc3Q/CgoKSSB0aGluayBzbywgcGxlYXNlIHRlc3QgbmV0LW5leHQgd2hpY2ggc2hvdWxkIGNv
bnRhaW5zIHRoZSBmaXhlcyBmcm9tIEVyaWMuCgpUaGFua3MKCgo+Cj4KPiBUaGFua3MuCj4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
