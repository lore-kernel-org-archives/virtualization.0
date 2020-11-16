Return-Path: <SRS0=Nqfw=EW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A678C4742C
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 04:12:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96B7D22284
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 04:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WfLX7DMx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B7D22284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4E91285E6F;
	Mon, 16 Nov 2020 04:12:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A7n7MO9p5YHl; Mon, 16 Nov 2020 04:12:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CEFC88558F;
	Mon, 16 Nov 2020 04:12:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B260DC0891;
	Mon, 16 Nov 2020 04:12:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 726EDC07FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 04:12:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5FAD486892
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 04:12:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AzGKwR7Rtb7F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 04:12:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CA04A86891
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 04:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605499955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i7Vss3nxtQh7qgaw4fJV/OR1O3wbN/QeZ53EHIIQef8=;
 b=WfLX7DMxdn4VEGhyci4r98om1wybh46qE4bfXD/J1ZN8fi95zeQUSAiQznEc+Bgi3fPs/E
 Wlr/ZGfsAo/rHfNOqXYvEKBOihUN9X6aoqEhmLNXtwMdHhQ8LUShY2ZPRhPhxxCTds6QeR
 +SjtRFL7n+2UaJWFHT37p75uGAMoHe8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-7AP2DiVXP1KPnH_efDnqxQ-1; Sun, 15 Nov 2020 23:12:33 -0500
X-MC-Unique: 7AP2DiVXP1KPnH_efDnqxQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FF4F8015FB;
 Mon, 16 Nov 2020 04:12:32 +0000 (UTC)
Received: from [10.72.13.126] (ovpn-13-126.pek2.redhat.com [10.72.13.126])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B26618439;
 Mon, 16 Nov 2020 04:12:23 +0000 (UTC)
Subject: Re: [PATCH RFC 05/12] vdpa_sim: remove the limit of IOTLB entries
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-6-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <67e0358e-0ae8-75e9-156f-4156f58387d9@redhat.com>
Date: Mon, 16 Nov 2020 12:12:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201113134712.69744-6-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Ck9uIDIwMjAvMTEvMTMg5LiL5Y2IOTo0NywgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IFRo
ZSBzaW11bGF0ZWQgZGV2aWNlcyBjYW4gc3VwcG9ydCBtdWx0aXBsZSBxdWV1ZXMsIHNvIHRoaXMg
bGltaXQKPiBzaG91bGQgYmUgZGVmaW5lZCBhY2NvcmRpbmcgdG8gdGhlIG51bWJlciBvZiBxdWV1
ZXMgc3VwcG9ydGVkIGJ5Cj4gdGhlIGRldmljZS4KPgo+IFNpbmNlIHdlIGFyZSBpbiBhIHNpbXVs
YXRvciwgbGV0J3Mgc2ltcGx5IHJlbW92ZSB0aGF0IGxpbWl0Lgo+Cj4gU3VnZ2VzdGVkLWJ5OiBK
YXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbm8g
R2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8
amFzb3dhbmdAcmVkaGF0LmNvbT4KCkl0IHdvdWxkIGJlIGdvb2QgdG8gaW50cm9kdWNlIGEgbWFj
cm8gaW5zdGVhZCBvZiB1c2luZyB0aGUgbWFnaWMgMCBoZXJlLgoKVGhhbmtzCgoKPiAtLS0KPiAg
IGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9z
aW0uYwo+IGluZGV4IDJiNGZlYTM1NDQxMy4uOWM5NzE3NDQxYmJlIDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFf
c2ltL3ZkcGFfc2ltLmMKPiBAQCAtMjMwLDcgKzIzMCw3IEBAIHN0cnVjdCB2ZHBhc2ltICp2ZHBh
c2ltX2NyZWF0ZShzdHJ1Y3QgdmRwYXNpbV9pbml0X2F0dHIgKmF0dHIpCj4gICAJCWdvdG8gZXJy
X2lvbW11Owo+ICAgCXNldF9kbWFfb3BzKGRldiwgJnZkcGFzaW1fZG1hX29wcyk7Cj4gICAKPiAt
CXZkcGFzaW0tPmlvbW11ID0gdmhvc3RfaW90bGJfYWxsb2MoMjA0OCwgMCk7Cj4gKwl2ZHBhc2lt
LT5pb21tdSA9IHZob3N0X2lvdGxiX2FsbG9jKDAsIDApOwo+ICAgCWlmICghdmRwYXNpbS0+aW9t
bXUpCj4gICAJCWdvdG8gZXJyX2lvbW11Owo+ICAgCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
