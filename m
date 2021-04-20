Return-Path: <SRS0=4Agt=JR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EBEC433B4
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 02:41:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 377E161026
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 02:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377E161026
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2F1260732;
	Tue, 20 Apr 2021 02:41:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5KaZj1DdNfQg; Tue, 20 Apr 2021 02:41:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9463605A1;
	Tue, 20 Apr 2021 02:41:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87678C000E;
	Tue, 20 Apr 2021 02:41:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2529C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 02:41:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CB706605A1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 02:41:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1xHF-Dz9A6S9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 02:41:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 41A6A605A8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 02:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618886475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QCpz0nhIq8lZv1yHAICQ2/pm22I/BSVi7uKhG1j2+KA=;
 b=LjrbaFoLyVpNVaT8WG1KxlQ+QKJc59egPhNTZp//dhY3QU79y30vgLbGAu87+z834nGo9g
 Zb8qE9lEXPGibIiMvLKX/kS6JUei9/HJMd+/Qdd0uieRw1UU1gP1GkJzWZMfSA8rHJ+CMD
 iMhjVQQpwwSW8gpqCzDmeTC4aKWnZ7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-cgdyGORQOYCBCvttY1xtfQ-1; Mon, 19 Apr 2021 22:41:12 -0400
X-MC-Unique: cgdyGORQOYCBCvttY1xtfQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4845910054F6;
 Tue, 20 Apr 2021 02:41:11 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-125.pek2.redhat.com
 [10.72.13.125])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E665C2B1B1;
 Tue, 20 Apr 2021 02:41:05 +0000 (UTC)
Subject: Re: [PATCH net-next v3] virtio-net: page_to_skb() use build_skb when
 there's sufficient tailroom
From: Jason Wang <jasowang@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20210416091615.25198-1-xuanzhuo@linux.alibaba.com>
 <e48bb6f-48c1-681-3288-72cd7b9661c3@linux.intel.com>
 <aa55b487-44bb-1596-d310-9b74b9ba47fe@redhat.com>
Message-ID: <87e01595-de5f-bf52-5769-1d05a455b62b@redhat.com>
Date: Tue, 20 Apr 2021 10:41:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <aa55b487-44bb-1596-d310-9b74b9ba47fe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
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

CuWcqCAyMDIxLzQvMjAg5LiK5Y2IMTA6MzgsIEphc29uIFdhbmcg5YaZ6YGTOgo+Pj4gOgo+Pj4g
K8KgwqDCoCAvKiBoZHJfdmFsaWQgbWVhbnMgbm8gWERQLCBzbyB3ZSBjYW4gY29weSB0aGUgdm5l
dCBoZWFkZXIgKi8KPj4+ICvCoMKgwqAgaWYgKGhkcl92YWxpZCkgewo+Pj4gK8KgwqDCoMKgwqDC
oMKgIGhkciA9IHNrYl92bmV0X2hkcihza2IpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIG1lbWNweSho
ZHIsIGhkcl9wLCBoZHJfbGVuKTsKPj4KPj4gYW5kIGhkcl9wIGlzIGRlcmVmZXJlbmNlZCBoZXJl
Lgo+Cj4KPiBSaWdodCwgSSB0ZW5kIHRvIHJlY292ZXIgdGhlIHdheSB0byBjb3B5IGhkciBhbmQg
c2V0IG1ldGEganVzdCBhZnRlciAKPiBhbGxvYy9idWlsZF9za2IoKS4KPgo+IFRoYW5rcyAKCgpC
dHcsIHNpbmNlIHRoZSBwYXRjaCBtb2RpZmllcyBhIGNyaXRpY2FsIHBhdGggb2YgdmlydGlvLW5l
dCBJIHN1Z2dlc3QgdG8gCnRlc3QgdGhlIGZvbGxvd2luZyBjYXNlczoKCjEpIG5ldHBlcmYgVENQ
IHN0cmVhbQoyKSBuZXRwZXJmIFVEUCB3aXRoIHBhY2tldCBzaXplIGZyb20gNjQgdG8gUEFHRV9T
SVpFCjMpIFhEUF9QQVNTIHdpdGggMSkKNCkgWERQX1BBU1Mgd2l0aCAyKQo1KSBYRFAgbWV0YWRh
dGEgd2l0aCAxKQo2KSBYRFAgbWV0YWRhdGEgd2l0aCAyKQoKVGhhbmtzCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
