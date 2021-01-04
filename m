Return-Path: <SRS0=kU6l=GH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1637C433E0
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 07:00:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 957AE2087E
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 07:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957AE2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6864F8685C;
	Mon,  4 Jan 2021 07:00:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XHwdraXQqNwq; Mon,  4 Jan 2021 07:00:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CAC6F86854;
	Mon,  4 Jan 2021 07:00:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE530C0893;
	Mon,  4 Jan 2021 07:00:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9DA88C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 07:00:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8876F85F5A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 07:00:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7DtWhct3pVBI
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 07:00:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0285885F58
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 07:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609743655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m95EV6wkqZdUunicOxOCYJRjT+GcrUdr9jvQjDQWdyw=;
 b=NYGFSjQ7pEh7gTQ5eX9BbsZsU6TTDJB+0VyG1374V6LBKuO7vy7RJtvdZnyu70xH0O4bR/
 BI6sYVNpxCkbY2fIFlsfaQuJIg17Mc4ceOmyd0LKAqQcwxTHEpdbuGw9i6ea7eN3xMHGaJ
 flLlC3uEG12g9dhqmXbUckJDOT9HKcU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-WqFmXLEtP7KvW6vt9Cgmmg-1; Mon, 04 Jan 2021 02:00:51 -0500
X-MC-Unique: WqFmXLEtP7KvW6vt9Cgmmg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 507F78018AF;
 Mon,  4 Jan 2021 07:00:50 +0000 (UTC)
Received: from [10.72.13.91] (ovpn-13-91.pek2.redhat.com [10.72.13.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8945E27C4E;
 Mon,  4 Jan 2021 07:00:45 +0000 (UTC)
Subject: Re: [PATCH linux-next v2 1/7] vdpa_sim_net: Make mac address array
 static
To: Parav Pandit <parav@nvidia.com>, virtualization@lists.linux-foundation.org
References: <20201112064005.349268-1-parav@nvidia.com>
 <20210104033141.105876-1-parav@nvidia.com>
 <20210104033141.105876-2-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b3832d82-7c32-52fd-cebc-1cbe2119ecfc@redhat.com>
Date: Mon, 4 Jan 2021 15:00:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210104033141.105876-2-parav@nvidia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: netdev@vger.kernel.org, elic@nvidia.com, mst@redhat.com
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

Ck9uIDIwMjEvMS80IOS4iuWNiDExOjMxLCBQYXJhdiBQYW5kaXQgd3JvdGU6Cj4gTUFDIGFkZHJl
c3MgYXJyYXkgaXMgdXNlZCBvbmx5IGluIHZkcGFfc2ltX25ldC5jLgo+IEhlbmNlLCBrZWVwIGl0
IHN0YXRpYy4KPgo+IFNpZ25lZC1vZmYtYnk6IFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZpZGlhLmNv
bT4KPiAtLS0KPiBDaGFuZ2Vsb2c6Cj4gdjEtPnYyOgo+ICAgLSBuZXcgcGF0Y2gKPiAtLS0KPiAg
IGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9uZXQuYyB8IDIgKy0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9uZXQuYyBiL2RyaXZlcnMvdmRwYS92ZHBhX3Np
bS92ZHBhX3NpbV9uZXQuYwo+IGluZGV4IGMxMGI2OTgxZmRhYi4uZjA0ODI0MjcxODZiIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9uZXQuYwo+ICsrKyBiL2Ry
aXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9uZXQuYwo+IEBAIC0zMyw3ICszMyw3IEBAIHN0
YXRpYyBjaGFyICptYWNhZGRyOwo+ICAgbW9kdWxlX3BhcmFtKG1hY2FkZHIsIGNoYXJwLCAwKTsK
PiAgIE1PRFVMRV9QQVJNX0RFU0MobWFjYWRkciwgIkV0aGVybmV0IE1BQyBhZGRyZXNzIik7Cj4g
ICAKPiAtdTggbWFjYWRkcl9idWZbRVRIX0FMRU5dOwo+ICtzdGF0aWMgdTggbWFjYWRkcl9idWZb
RVRIX0FMRU5dOwo+ICAgCj4gICBzdGF0aWMgc3RydWN0IHZkcGFzaW0gKnZkcGFzaW1fbmV0X2Rl
djsKPiAgIAoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
