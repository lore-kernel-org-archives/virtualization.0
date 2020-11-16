Return-Path: <SRS0=Nqfw=EW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3A9C4742C
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 04:20:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDD8C222B9
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 04:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="REJd60do"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD8C222B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5B85E857D6;
	Mon, 16 Nov 2020 04:20:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b4hcbSCwPdqd; Mon, 16 Nov 2020 04:20:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BA75484495;
	Mon, 16 Nov 2020 04:20:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC0D6C0891;
	Mon, 16 Nov 2020 04:20:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77A2AC07FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 04:20:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5F4E1857D6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 04:20:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y2lp9SrRqjyh
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 04:20:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C474E84495
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 04:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605500410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b/zBHbSGh+sm8yLVC4/oST7xymuxq5Efw+Tm5E/iazs=;
 b=REJd60dolrZEDejeXHZ6Tkq6KI+iDkeVGcVuwNzfXroywJbWZv1ul77VMAgAofly5Qex3x
 YpSr5BFKA0+N+eLkzes77TiqfFZUrhgPl9/cLUtMuiLR7Z2J8wKnvCKtTDPEz/Lh0PKuux
 VPYGw+hhfalo/wpAMwqDdGJVoveEEcM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-yEma_x8EPtyLRI7i3TqwDA-1; Sun, 15 Nov 2020 23:20:06 -0500
X-MC-Unique: yEma_x8EPtyLRI7i3TqwDA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 989631074653;
 Mon, 16 Nov 2020 04:20:05 +0000 (UTC)
Received: from [10.72.13.126] (ovpn-13-126.pek2.redhat.com [10.72.13.126])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18EA860C84;
 Mon, 16 Nov 2020 04:19:56 +0000 (UTC)
Subject: Re: [PATCH RFC 09/12] vdpa_sim: make vdpasim->buffer size configurable
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-10-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <433bbdf4-b69c-7ae8-a734-923ffac646eb@redhat.com>
Date: Mon, 16 Nov 2020 12:19:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201113134712.69744-10-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

Ck9uIDIwMjAvMTEvMTMg5LiL5Y2IOTo0NywgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IEFs
bG93IGVhY2ggZGV2aWNlIHRvIHNwZWNpZnkgdGhlIHNpemUgb2YgdGhlIGJ1ZmZlciBhbGxvY2F0
ZWQKPiBpbiB2ZHBhX3NpbS4KPgo+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8
c2dhcnphcmVAcmVkaGF0LmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4KCgo+IC0tLQo+ICAgZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmggICAg
IHwgMSArCj4gICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYyAgICAgfCAyICstCj4g
ICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fYmxrLmMgfCAxICsKPiAgIGRyaXZlcnMv
dmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9uZXQuYyB8IDEgKwo+ICAgNCBmaWxlcyBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zk
cGEvdmRwYV9zaW0vdmRwYV9zaW0uaCBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5o
Cj4gaW5kZXggZjdlMWZlMGE4OGQzLi5jYzIxZTA3YWEyZjcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmgKPiArKysgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0v
dmRwYV9zaW0uaAo+IEBAIC00OSw2ICs0OSw3IEBAIHN0cnVjdCB2ZHBhc2ltX2RldmljZSB7Cj4g
ICAKPiAgIHN0cnVjdCB2ZHBhc2ltX2luaXRfYXR0ciB7Cj4gICAJc3RydWN0IHZkcGFzaW1fZGV2
aWNlIGRldmljZTsKPiArCXNpemVfdCBidWZmZXJfc2l6ZTsKPiAgIAlpbnQgYmF0Y2hfbWFwcGlu
ZzsKPiAgIAo+ICAgCXdvcmtfZnVuY190CXdvcmtfZm47Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2lt
LmMKPiBpbmRleCBiZDAzNGZiZjQ2ODMuLjM4NjNkNDllMGQ2ZCAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhX3Np
bS92ZHBhX3NpbS5jCj4gQEAgLTIyMyw3ICsyMjMsNyBAQCBzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNp
bV9jcmVhdGUoc3RydWN0IHZkcGFzaW1faW5pdF9hdHRyICphdHRyKQo+ICAgCWlmICghdmRwYXNp
bS0+aW9tbXUpCj4gICAJCWdvdG8gZXJyX2lvbW11Owo+ICAgCj4gLQl2ZHBhc2ltLT5idWZmZXIg
PSBrdm1hbGxvYyhQQUdFX1NJWkUsIEdGUF9LRVJORUwpOwo+ICsJdmRwYXNpbS0+YnVmZmVyID0g
a3ZtYWxsb2MoYXR0ci0+YnVmZmVyX3NpemUsIEdGUF9LRVJORUwpOwo+ICAgCWlmICghdmRwYXNp
bS0+YnVmZmVyKQo+ICAgCQlnb3RvIGVycl9pb21tdTsKPiAgIAo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fYmxrLmMgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0v
dmRwYV9zaW1fYmxrLmMKPiBpbmRleCBmNDU2YTBlNGUwOTcuLjEyMmEzYzAzOTUwNyAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fYmxrLmMKPiArKysgYi9kcml2
ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fYmxrLmMKPiBAQCAtMTAwLDYgKzEwMCw3IEBAIHN0
YXRpYyBpbnQgX19pbml0IHZkcGFzaW1fYmxrX2luaXQodm9pZCkKPiAgIAlhdHRyLmRldmljZS51
cGRhdGVfY29uZmlnID0gdmRwYXNpbV9ibGtfdXBkYXRlX2NvbmZpZzsKPiAgIAo+ICAgCWF0dHIu
d29ya19mbiA9IHZkcGFzaW1fYmxrX3dvcms7Cj4gKwlhdHRyLmJ1ZmZlcl9zaXplID0gUEFHRV9T
SVpFOwo+ICAgCj4gICAJdmRwYXNpbV9ibGtfZGV2ID0gdmRwYXNpbV9jcmVhdGUoJmF0dHIpOwo+
ICAgCWlmIChJU19FUlIodmRwYXNpbV9ibGtfZGV2KSkgewo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fbmV0LmMgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRw
YV9zaW1fbmV0LmMKPiBpbmRleCBiOTM3MmZkZjI0MTUuLmQwYTE0MDNmNjRiMiAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fbmV0LmMKPiArKysgYi9kcml2ZXJz
L3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fbmV0LmMKPiBAQCAtMTI0LDYgKzEyNCw3IEBAIHN0YXRp
YyBpbnQgX19pbml0IHZkcGFzaW1fbmV0X2luaXQodm9pZCkKPiAgIAo+ICAgCWF0dHIud29ya19m
biA9IHZkcGFzaW1fbmV0X3dvcms7Cj4gICAJYXR0ci5iYXRjaF9tYXBwaW5nID0gYmF0Y2hfbWFw
cGluZzsKPiArCWF0dHIuYnVmZmVyX3NpemUgPSBQQUdFX1NJWkU7Cj4gICAKPiAgIAl2ZHBhc2lt
X25ldF9kZXYgPSB2ZHBhc2ltX2NyZWF0ZSgmYXR0cik7Cj4gICAJaWYgKElTX0VSUih2ZHBhc2lt
X25ldF9kZXYpKSB7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
