Return-Path: <SRS0=Ra46=BR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E724BC433DF
	for <virtualization@archiver.kernel.org>; Fri,  7 Aug 2020 03:54:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD8A92177B
	for <virtualization@archiver.kernel.org>; Fri,  7 Aug 2020 03:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XR+z0pyz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD8A92177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8756B8720E;
	Fri,  7 Aug 2020 03:54:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TgkDP4Zr24_y; Fri,  7 Aug 2020 03:54:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7088987199;
	Fri,  7 Aug 2020 03:54:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53D26C0050;
	Fri,  7 Aug 2020 03:54:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33148C004C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 03:54:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1CA178844E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 03:54:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UmIkWLseEsB2
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 03:54:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 57894883A3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 03:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596772464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6DD+5YaxG5kafQGDO3acMANf5Iwxl41vTIRFwMojQUI=;
 b=XR+z0pyzpmpdHRxx94xpq0EWDwkym32D13XJRvXmdRbcnbgqr5yg0txVCbYNDq7tQn+Y8c
 nJ915aTP4VpGoj2MDzE6wHntpdRU1HhgG37448MDza8tDLOyYp/FoMFk2dNXZT/r8tti61
 DXm9UgtChaup/vVj+71sIwfdd0am34c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-Q7A8Z20-NoSg2T-18Pwq2Q-1; Thu, 06 Aug 2020 23:54:22 -0400
X-MC-Unique: Q7A8Z20-NoSg2T-18Pwq2Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A71F80046C;
 Fri,  7 Aug 2020 03:54:21 +0000 (UTC)
Received: from [10.72.13.215] (ovpn-13-215.pek2.redhat.com [10.72.13.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5711D5F9DB;
 Fri,  7 Aug 2020 03:54:16 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: Fix uninitialised variable in core/mr.c
To: Alex Dewar <alex.dewar@gmx.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Parav Pandit <parav@mellanox.com>, Eli Cohen <eli@mellanox.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20200806185625.67344-1-alex.dewar@gmx.co.uk>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <307a57f1-7038-f042-a786-bee636509a7b@redhat.com>
Date: Fri, 7 Aug 2020 11:54:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806185625.67344-1-alex.dewar@gmx.co.uk>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

Ck9uIDIwMjAvOC83IOS4iuWNiDI6NTYsIEFsZXggRGV3YXIgd3JvdGU6Cj4gSWYgdGhlIGtlcm5l
bCBpcyB1bmFibGUgdG8gYWxsb2NhdGUgbWVtb3J5IGZvciB0aGUgdmFyaWFibGUgZG1yIHRoZW4K
PiBlcnIgd2lsbCBiZSByZXR1cm5lZCB3aXRob3V0IGJlaW5nIHNldC4gU2V0IGVyciB0byAtRU5P
TUVNIGluIHRoaXMKPiBjYXNlLgo+Cj4gRml4ZXM6IDk0YWJiY2NkZjI5MSAoInZkcGEvbWx4NTog
QWRkIHNoYXJlZCBtZW1vcnkgcmVnaXN0cmF0aW9uIGNvZGUiKQo+IEFkZHJlc3Nlcy1Db3Zlcml0
eTogKCJVbmluaXRpYWxpemVkIHZhcmlhYmxlcyIpCj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXdh
ciA8YWxleC5kZXdhckBnbXguY28udWs+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYyB8IDQg
KysrLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYyBiL2RyaXZlcnMvdmRw
YS9tbHg1L2NvcmUvbXIuYwo+IGluZGV4IGY1ZGVjMDI3NDEzMy4uZWYxYzU1MGY4MjY2IDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYwo+ICsrKyBiL2RyaXZlcnMvdmRw
YS9tbHg1L2NvcmUvbXIuYwo+IEBAIC0zMTksOCArMzE5LDEwIEBAIHN0YXRpYyBpbnQgYWRkX2Rp
cmVjdF9jaGFpbihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHU2NCBzdGFydCwgdTY0IHNp
emUsIHU4Cj4gICAJd2hpbGUgKHNpemUpIHsKPiAgIAkJc3ogPSAodTMyKW1pbl90KHU2NCwgTUFY
X0tMTV9TSVpFLCBzaXplKTsKPiAgIAkJZG1yID0ga3phbGxvYyhzaXplb2YoKmRtciksIEdGUF9L
RVJORUwpOwo+IC0JCWlmICghZG1yKQo+ICsJCWlmICghZG1yKSB7Cj4gKwkJCWVyciA9IC1FTk9N
RU07Cj4gICAJCQlnb3RvIGVycl9hbGxvYzsKPiArCQl9Cj4KPiAgIAkJZG1yLT5zdGFydCA9IHN0
Owo+ICAgCQlkbXItPmVuZCA9IHN0ICsgc3o7Cj4gLS0KPiAyLjI4LjAKPgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
