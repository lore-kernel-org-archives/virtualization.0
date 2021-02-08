Return-Path: <SRS0=X+k7=HK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8205C433E0
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 04:37:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F96364E66
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 04:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F96364E66
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E145F203F3;
	Mon,  8 Feb 2021 04:37:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id voacb8srrJ6z; Mon,  8 Feb 2021 04:37:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 43BDF203CD;
	Mon,  8 Feb 2021 04:37:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B001C0174;
	Mon,  8 Feb 2021 04:37:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83CACC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 04:37:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6A54886FFA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 04:37:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lMPdlMR98xXz
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 04:37:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9E29386FF8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 04:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612759056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AXyJJxjVxwqQYUGq8cjXowIkJ5w7ooor07ZQr4A7YuY=;
 b=OLEUyBuFob+L3PiZj0znEQk29oDwzdq9nwSKk3xrxXSrpPcTJo767oRJGnyctXmstzGN8T
 wYzXhZ5omw2OHyRfWB5IM5S8qMnzIxwaefzXenXapxq74YBRKtHbIXODBmmafnOivgzD55
 5pdce3PcJ5sXQvVIgwOPVL/I82+ZT04=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-1ibjxQD5NdS8YIl3FSaJFw-1; Sun, 07 Feb 2021 23:37:32 -0500
X-MC-Unique: 1ibjxQD5NdS8YIl3FSaJFw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32416192D786;
 Mon,  8 Feb 2021 04:37:31 +0000 (UTC)
Received: from [10.72.13.185] (ovpn-13-185.pek2.redhat.com [10.72.13.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 436F05C1C2;
 Mon,  8 Feb 2021 04:37:25 +0000 (UTC)
Subject: Re: [PATCH 2/3] mlx5_vdpa: fix feature negotiation across device reset
To: Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com, elic@nvidia.com
References: <1612614564-4220-1-git-send-email-si-wei.liu@oracle.com>
 <1612614564-4220-2-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4d6b8fc7-e697-d027-7763-8e56e0669a31@redhat.com>
Date: Mon, 8 Feb 2021 12:37:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1612614564-4220-2-git-send-email-si-wei.liu@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Ck9uIDIwMjEvMi82IOS4i+WNiDg6MjksIFNpLVdlaSBMaXUgd3JvdGU6Cj4gVGhlIG1seF9mZWF0
dXJlcyBkZW5vdGVzIHRoZSBjYXBhYmlsaXR5IGZvciB3aGljaAo+IHNldCBvZiB2aXJ0aW8gZmVh
dHVyZXMgaXMgc3VwcG9ydGVkIGJ5IGRldmljZS4gSW4KPiBwcmluY2lwbGUsIHRoaXMgZmllbGQg
bmVlZHMgbm90IGJlIGNsZWFyZWQgZHVyaW5nCj4gdmlydGlvIGRldmljZSByZXNldCwgYXMgdGhp
cyBjYXBhYmlsaXR5IGlzIHN0YXRpYwo+IGFuZCBkb2VzIG5vdCBjaGFuZ2UgYWNyb3NzIHJlc2V0
Lgo+Cj4gSW4gZmFjdCwgdGhlIGN1cnJlbnQgY29kZSBtYXkgaGF2ZSB0aGUgYXNzdW1wdGlvbgo+
IHRoYXQgbWx4X2ZlYXR1cmVzIGNhbiBiZSByZWxvYWRlZCBmcm9tIGZpcm13YXJlCj4gdmlhIHRo
ZSAuZ2V0X2ZlYXR1cmVzIG9wcyBhZnRlciBkZXZpY2UgaXMgcmVzZXQKPiAodmlhIHRoZSAuc2V0
X3N0YXR1cyBvcHMpLCB3aGljaCBpcyB1bmZvcnR1bmF0ZWx5Cj4gbm90IHRydWUuIFRoZSB1c2Vy
c3BhY2UgVk1NIG1pZ2h0IHNhdmUgYSBjb3B5Cj4gb2YgYmFja2VuZCBjYXBhYmxlIGZlYXR1cmVz
IGFuZCB3b24ndCBjYWxsIGludG8KPiBrZXJuZWwgYWdhaW4gdG8gZ2V0IGl0IG9uIHJlc2V0LgoK
ClRoaXMgaXMgbm90IHRoZSBiZWhhdmlvciBvZiBRZW11IGJ1dCBpdCdzIHZhbGlkLgoKCj4gVGhp
cyBjYXVzZXMgYWxsCj4gdmlydGlvIGZlYXR1cmVzIGdldHRpbmcgZGlzYWJsZWQgb24gbmV3bHkg
Y3JlYXRlZAo+IHZpcnRxcyBhZnRlciBkZXZpY2UgcmVzZXQsIHdoaWxlIGd1ZXN0IHdvdWxkIGhv
bGQKPiBtaXNtYXRjaGVkIHZpZXcgb2YgYXZhaWxhYmxlIGZlYXR1cmVzLiBGb3IgZS5nLiwKPiB0
aGUgZ3Vlc3QgbWF5IHN0aWxsIGFzc3VtZSB0eCBjaGVja3N1bSBvZmZsb2FkCj4gaXMgYXZhaWxh
YmxlIGFmdGVyIHJlc2V0IGFuZCBmZWF0dXJlIG5lZ290aWF0aW9uLAo+IGNhdXNpbmcgZnJhbWVz
IHdpdGggYm9ndXMgKGluY29tcGxldGUpIGNoZWNrc3VtCj4gdHJhbnNtaXR0ZWQgb24gdGhlIHdp
cmUuCj4KPiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+
CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAg
IGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDEgLQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQv
bWx4NV92bmV0LmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiBpbmRleCBi
ODQxNmM0Li5hYTZmOGNkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1
X3ZuZXQuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+IEBAIC0x
Nzg4LDcgKzE3ODgsNiBAQCBzdGF0aWMgdm9pZCBtbHg1X3ZkcGFfc2V0X3N0YXR1cyhzdHJ1Y3Qg
dmRwYV9kZXZpY2UgKnZkZXYsIHU4IHN0YXR1cykKPiAgIAkJY2xlYXJfdmlydHF1ZXVlcyhuZGV2
KTsKPiAgIAkJbWx4NV92ZHBhX2Rlc3Ryb3lfbXIoJm5kZXYtPm12ZGV2KTsKPiAgIAkJbmRldi0+
bXZkZXYuc3RhdHVzID0gMDsKPiAtCQluZGV2LT5tdmRldi5tbHhfZmVhdHVyZXMgPSAwOwo+ICAg
CQkrK212ZGV2LT5nZW5lcmF0aW9uOwo+ICAgCQlyZXR1cm47Cj4gICAJfQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
