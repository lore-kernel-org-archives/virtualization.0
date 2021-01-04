Return-Path: <SRS0=kU6l=GH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB541C433E0
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 03:23:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2025720DD4
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 03:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2025720DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 373EB20516;
	Mon,  4 Jan 2021 03:23:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d-3BjJTJwNfd; Mon,  4 Jan 2021 03:23:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id ACEBC203CA;
	Mon,  4 Jan 2021 03:23:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F6AEC0893;
	Mon,  4 Jan 2021 03:23:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A96FC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 03:23:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 33DF3867D8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 03:23:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ykt4tyt4YgGc
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 03:23:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4FD57867D7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 03:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609730590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gZSEcMV6HrgwioULaRsP1a/F6QmzsKsD5eRpNgK39q0=;
 b=YpG+aUUSA4i+QFZy+R9CnGYCMKXugaowyQ0Wvx+khc4itiVI4ehXmDZyCnS819Fck0VGpT
 tWeaC24qnyHe6VD3NIdY4gOWSMikEy0lwZxiJvur9q0wr1D6aYnLWg0Lr/w0Vj9lmaKfKk
 aZx40aTGm0eSKwwmVQ651jD89atx9C0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-EPvtJQvVOqWZOgwKIvY9pw-1; Sun, 03 Jan 2021 22:23:02 -0500
X-MC-Unique: EPvtJQvVOqWZOgwKIvY9pw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A886800D55;
 Mon,  4 Jan 2021 03:23:01 +0000 (UTC)
Received: from [10.72.13.221] (ovpn-13-221.pek2.redhat.com [10.72.13.221])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 572B16F7EB;
 Mon,  4 Jan 2021 03:22:56 +0000 (UTC)
Subject: Re: [PATCH V2 16/19] virtio-pci: introduce modern device module
To: Randy Dunlap <rdunlap@infradead.org>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20201204040353.21679-1-jasowang@redhat.com>
 <20201204040353.21679-17-jasowang@redhat.com>
 <a325b57b-817f-b96e-76fc-dba4415fe6b0@infradead.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9ea86f91-0ca5-bfd6-4489-93a726455c41@redhat.com>
Date: Mon, 4 Jan 2021 11:22:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a325b57b-817f-b96e-76fc-dba4415fe6b0@infradead.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: shahafs@mellanox.com
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

Ck9uIDIwMjAvMTIvNSDkuIrljYgxOjEwLCBSYW5keSBEdW5sYXAgd3JvdGU6Cj4gSGkgSmFzb24t
LQo+Cj4gT24gMTIvMy8yMCA4OjAzIFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy92aXJ0aW8vS2NvbmZpZyBiL2RyaXZlcnMvdmlydGlvL0tjb25maWcKPj4gaW5k
ZXggN2I0MTEzMGQzZjM1Li5kMWE2YmQyYTk3NWYgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdmly
dGlvL0tjb25maWcKPj4gKysrIGIvZHJpdmVycy92aXJ0aW8vS2NvbmZpZwo+PiBAQCAtMTIsNiAr
MTIsMTQgQEAgY29uZmlnIEFSQ0hfSEFTX1JFU1RSSUNURURfVklSVElPX01FTU9SWV9BQ0NFU1MK
Pj4gICAJICBUaGlzIG9wdGlvbiBpcyBzZWxlY3RlZCBpZiB0aGUgYXJjaGl0ZWN0dXJlIG1heSBu
ZWVkIHRvIGVuZm9yY2UKPj4gICAJICBWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0KPj4gICAKPj4g
K2NvbmZpZyBWSVJUSU9fUENJX01PREVSTgo+PiArCXRyaXN0YXRlICJNb2Rlcm4gVmlydGlvIFBD
SSBEZXZpY2UiCj4+ICsJZGVwZW5kcyBvbiBQQ0kKPj4gKwloZWxwCj4+ICsJICBNb2Rlcm4gUENJ
IGRldmljZSBpbXBsZW1lbnRhdGlvbi4gVGhpcyBtb2R1bGUgaW1wbGVtZW50IHRoZQo+IAkgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbXBsZW1lbnRzCj4K
Pj4gKwkgIGJhc2ljIHByb2JlIGFuZCBjb250cm9sIGZvciBkZXZpY2VzIHdoaWNoIGlzIGJhc2Vk
IG9uIG1vZGVybgo+IAkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGFyZQo+Cj4+ICsJICBQQ0kgZGV2aWNlIHdpdGggcG9zc2libGUgdmVuZG9yIHNwZWNpZmljIGV4
dGVuc2lvbnMuCj4gCSAgICAgIGRldmljZXMKPj4gKwo+Cj4gY2hlZXJzLgoKCkFsbCBmaXhlZC4K
ClRoYW5rcwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
