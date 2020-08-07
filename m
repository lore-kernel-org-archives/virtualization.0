Return-Path: <SRS0=Ra46=BR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBA5C433DF
	for <virtualization@archiver.kernel.org>; Fri,  7 Aug 2020 03:59:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B38722CAF
	for <virtualization@archiver.kernel.org>; Fri,  7 Aug 2020 03:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C1Wf1Kia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B38722CAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B3AD78868C;
	Fri,  7 Aug 2020 03:59:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uwPLW8cz767P; Fri,  7 Aug 2020 03:59:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7B82A88689;
	Fri,  7 Aug 2020 03:59:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5EFD4C0050;
	Fri,  7 Aug 2020 03:59:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BEFA0C004C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 03:59:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A556C24F78
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 03:59:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PN0ywGOpZGuv
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 03:59:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by silver.osuosl.org (Postfix) with ESMTPS id C597A24E83
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 03:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596772778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ur7u+L4AiUpxBUHlNLWgY5xdw+Rt8MUvqmC6sx75eg=;
 b=C1Wf1KiawA0CklZxFa+RSXGSeJFePmsb17Oukj7RqAlZ+FpouLdfPFWQTsgtW0FTda+doW
 OvOfW6zIl9ktjrdOFgzd1J06FokfVbWeyLw3gpPZz+Ez0nIZvInkTMKe7g/QKTFmiL6aR5
 Bj9H3iQCwQkDIL7li9BtpU7pVFq4UQM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-eu1zuceKMwaHilGdVSy2Hg-1; Thu, 06 Aug 2020 23:59:36 -0400
X-MC-Unique: eu1zuceKMwaHilGdVSy2Hg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A64318C63DE;
 Fri,  7 Aug 2020 03:59:35 +0000 (UTC)
Received: from [10.72.13.215] (ovpn-13-215.pek2.redhat.com [10.72.13.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9829187A5A;
 Fri,  7 Aug 2020 03:59:30 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: Fix erroneous null pointer checks
From: Jason Wang <jasowang@redhat.com>
To: Alex Dewar <alex.dewar90@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Eli Cohen <eli@mellanox.com>, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <20200806191849.82189-1-alex.dewar90@gmail.com>
 <a1fb552a-bd5c-d7a2-7eae-d787cc61ec73@redhat.com>
Message-ID: <59bf7e04-a834-2728-dd2a-a2cd62a724a8@redhat.com>
Date: Fri, 7 Aug 2020 11:59:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a1fb552a-bd5c-d7a2-7eae-d787cc61ec73@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

Ck9uIDIwMjAvOC83IOS4iuWNiDExOjM3LCBKYXNvbiBXYW5nIHdyb3RlOgo+Cj4gT24gMjAyMC84
Lzcg5LiK5Y2IMzoxOCwgQWxleCBEZXdhciB3cm90ZToKPj4gSW4gYWxsb2NfaW5vdXQoKSBpbiBu
ZXQvbWx4NV92bmV0LmMsIHRoZXJlIGFyZSBhIGZldyBwbGFjZXMgd2hlcmUgbWVtb3J5Cj4+IGlz
IGFsbG9jYXRlZCB0byAqaW4gYW5kICpvdXQsIGJ1dCBvbmx5IHRoZSB2YWx1ZXMgb2YgaW4gYW5k
IG91dCBhcmUKPj4gbnVsbC1jaGVja2VkIChpLmUuIHRoZXJlIGlzIGEgbWlzc2luZyBkZXJlZmVy
ZW5jZSkuIEZpeCB0aGlzLgo+Pgo+PiBBZGRyZXNzZXMtQ292ZXJpdHk6ICgiQ0lEIDE0OTY2MDM6
IChSRVZFUlNFX0lOVUxMKSIpCj4+IEZpeGVzOiAxYTg2YjM3N2FhMjEgKCJ2ZHBhL21seDU6IEFk
ZCBWRFBBIGRyaXZlciBmb3Igc3VwcG9ydGVkIG1seDUgCj4+IGRldmljZXMiKQo+PiBTaWduZWQt
b2ZmLWJ5OiBBbGV4IERld2FyIDxhbGV4LmRld2FyOTBAZ21haWwuY29tPgo+Cj4KPiBBY2tlZC1i
eTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgpDb2xpbiBwb3N0ZWQgc29tZXRo
aW5nIHNpbWlsYXI6IFtQQVRDSF1bbmV4dF0gdmRwYS9tbHg1OiBmaXggbWVtb3J5IAphbGxvY2F0
aW9uIGZhaWx1cmUgY2hlY2tzCgpBbmQgSSB0aGluayBoaXMgZml4IGlzIGJldHRlciBzaW5jZSBp
dCBwcmV2ZW50IHJhdyBwb2ludGVycyB0byBiZSBmcmVlZC4KClRoYW5rcwoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
