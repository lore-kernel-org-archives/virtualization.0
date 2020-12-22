Return-Path: <SRS0=Q5yb=F2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6328C433E0
	for <virtualization@archiver.kernel.org>; Tue, 22 Dec 2020 03:49:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AA0E22CB2
	for <virtualization@archiver.kernel.org>; Tue, 22 Dec 2020 03:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA0E22CB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DF69A869AB;
	Tue, 22 Dec 2020 03:49:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IEq7X7QXpQlx; Tue, 22 Dec 2020 03:49:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 53712869A0;
	Tue, 22 Dec 2020 03:49:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4172CC1825;
	Tue, 22 Dec 2020 03:49:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81698C0893
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 03:49:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 67B8F871ED
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 03:49:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GniTFtj7tGX1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 03:49:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 55DE1871E9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 03:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608608954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LP/jJCPXp1ZjxGWbs4WF0FNxRzF7g1uBxZujdFuaZik=;
 b=QFGyJnPcNRkuss7A8RWksBZ63HmzB/FifNT+iv2KjXgMTzEjYU3BVhHn1LHmFxbX3yhdcl
 0oTHRnHdGyeWJi4PsDxFPWg8IJxA37EsUXRyv4/ugA7V9T3qdcLhDsWsPfQy3lox51tv63
 MSLARxiH3PuyHr/QVR0qsRCYSv4IuJY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-DnmK1liDNoCCV-6_azYVEw-1; Mon, 21 Dec 2020 22:49:11 -0500
X-MC-Unique: DnmK1liDNoCCV-6_azYVEw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50399801817;
 Tue, 22 Dec 2020 03:49:10 +0000 (UTC)
Received: from [10.72.13.168] (ovpn-13-168.pek2.redhat.com [10.72.13.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 948DC1B534;
 Tue, 22 Dec 2020 03:49:05 +0000 (UTC)
Subject: Re: [PATCH] virtio_net: Fix recursive call to cpus_read_lock()
To: Jeff Dike <jdike@akamai.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20201222033648.14752-1-jdike@akamai.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e8379ba8-6578-baa0-8a67-1deada809271@redhat.com>
Date: Tue, 22 Dec 2020 11:49:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201222033648.14752-1-jdike@akamai.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
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

Ck9uIDIwMjAvMTIvMjIg5LiK5Y2IMTE6MzYsIEplZmYgRGlrZSB3cm90ZToKPiB2aXJ0bmV0X3Nl
dF9jaGFubmVscyBjYW4gcmVjdXJzaXZlbHkgY2FsbCBjcHVzX3JlYWRfbG9jayBpZiBDT05GSUdf
WFBTCj4gYW5kIENPTkZJR19IT1RQTFVHIGFyZSBlbmFibGVkLgo+Cj4gVGhlIHBhdGggaXM6Cj4g
ICAgICB2aXJ0bmV0X3NldF9jaGFubmVscyAtIGNhbGxzIGdldF9vbmxpbmVfY3B1cygpLCB3aGlj
aCBpcyBhIHRyaXZpYWwKPiB3cmFwcGVyIGFyb3VuZCBjcHVzX3JlYWRfbG9jaygpCj4gICAgICBu
ZXRpZl9zZXRfcmVhbF9udW1fdHhfcXVldWVzCj4gICAgICBuZXRpZl9yZXNldF94cHNfcXVldWVz
X2d0Cj4gICAgICBuZXRpZl9yZXNldF94cHNfcXVldWVzIC0gY2FsbHMgY3B1c19yZWFkX2xvY2so
KQo+Cj4gVGhpcyBjYWxsIGNoYWluIGFuZCBwb3RlbnRpYWwgZGVhZGxvY2sgaGFwcGVucyB3aGVu
IHRoZSBudW1iZXIgb2YgVFgKPiBxdWV1ZXMgaXMgcmVkdWNlZC4KPgo+IFRoaXMgY29tbWl0IHRo
ZSByZW1vdmVzIG5ldGlmX3NldF9yZWFsX251bV9bdHJdeF9xdWV1ZXMgY2FsbHMgZnJvbQo+IGlu
c2lkZSB0aGUgZ2V0L3B1dF9vbmxpbmVfY3B1cyBzZWN0aW9uLCBhcyB0aGV5IGRvbid0IHJlcXVp
cmUgdGhhdCBpdAo+IGJlIGhlbGQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBKZWZmIERpa2UgPGpkaWtl
QGFrYW1haS5jb20+Cj4gLS0tCgoKQWRkaW5nIG5ldGRldi4KClRoZSBwYXRjaCBjYW4gZ28gd2l0
aCAtbmV0IGFuZCBpcyBuZWVkZWQgZm9yIC1zdGFibGUuCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8
amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMTIg
KysrKysrKy0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA1IGRlbGV0
aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZl
cnMvbmV0L3ZpcnRpb19uZXQuYwo+IGluZGV4IDA1Mjk3NWVhMGFmNC4uZTAyYzdlMGYxY2Y5IDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ICsrKyBiL2RyaXZlcnMvbmV0
L3ZpcnRpb19uZXQuYwo+IEBAIC0yMDkzLDE0ICsyMDkzLDE2IEBAIHN0YXRpYyBpbnQgdmlydG5l
dF9zZXRfY2hhbm5lbHMoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiAgIAo+ICAgCWdldF9vbmxp
bmVfY3B1cygpOwo+ICAgCWVyciA9IF92aXJ0bmV0X3NldF9xdWV1ZXModmksIHF1ZXVlX3BhaXJz
KTsKPiAtCWlmICghZXJyKSB7Cj4gLQkJbmV0aWZfc2V0X3JlYWxfbnVtX3R4X3F1ZXVlcyhkZXYs
IHF1ZXVlX3BhaXJzKTsKPiAtCQluZXRpZl9zZXRfcmVhbF9udW1fcnhfcXVldWVzKGRldiwgcXVl
dWVfcGFpcnMpOwo+IC0KPiAtCQl2aXJ0bmV0X3NldF9hZmZpbml0eSh2aSk7Cj4gKwlpZiAoZXJy
KXsKPiArCQlwdXRfb25saW5lX2NwdXMoKTsKPiArCQlnb3RvIGVycjsKPiAgIAl9Cj4gKwl2aXJ0
bmV0X3NldF9hZmZpbml0eSh2aSk7Cj4gICAJcHV0X29ubGluZV9jcHVzKCk7Cj4gICAKPiArCW5l
dGlmX3NldF9yZWFsX251bV90eF9xdWV1ZXMoZGV2LCBxdWV1ZV9wYWlycyk7Cj4gKwluZXRpZl9z
ZXRfcmVhbF9udW1fcnhfcXVldWVzKGRldiwgcXVldWVfcGFpcnMpOwo+ICsgZXJyOgo+ICAgCXJl
dHVybiBlcnI7Cj4gICB9Cj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
