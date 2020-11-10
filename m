Return-Path: <SRS0=rWzq=EQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E03C2D0A3
	for <virtualization@archiver.kernel.org>; Tue, 10 Nov 2020 02:50:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE7712067B
	for <virtualization@archiver.kernel.org>; Tue, 10 Nov 2020 02:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EV632HYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE7712067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 35E9E87135;
	Tue, 10 Nov 2020 02:50:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dZ-GyFWuGCOZ; Tue, 10 Nov 2020 02:50:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8E2A88712B;
	Tue, 10 Nov 2020 02:50:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CCE0C088B;
	Tue, 10 Nov 2020 02:50:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA8CEC016F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Nov 2020 02:50:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D8018856BF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Nov 2020 02:50:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pVY3nTMxplqD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Nov 2020 02:50:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 11F0C8560E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Nov 2020 02:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604976643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cN43+bPvc1CdMAPDr88esBeeC4ALthX2RLH8XdHg4RI=;
 b=EV632HYGHrfN825X0fYEYhmBC6y4ZJ+ifddwoMJkcL9OBCjPK90bPOHUasF8JqhY6gTqGV
 N86wlBzbTsJtod6osLVEUn9ewC4TwXUBmmtassdth60iRohfpX4c7r9InliNcxs8eXYkPg
 Li4JPvJEE9NlP6uMjIrIG+yPUvJ/lLg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-lc8ooORmPL2OfARN71KMng-1; Mon, 09 Nov 2020 21:50:40 -0500
X-MC-Unique: lc8ooORmPL2OfARN71KMng-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CA675F9C0;
 Tue, 10 Nov 2020 02:50:39 +0000 (UTC)
Received: from [10.72.13.94] (ovpn-13-94.pek2.redhat.com [10.72.13.94])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 53FEC5D9DD;
 Tue, 10 Nov 2020 02:50:31 +0000 (UTC)
Subject: Re: [PATCH 06/11] vhost: support delayed vq creation
To: Mike Christie <michael.christie@oracle.com>, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, mst@redhat.com,
 pbonzini@redhat.com, stefanha@redhat.com,
 virtualization@lists.linux-foundation.org
References: <1604528804-2878-1-git-send-email-michael.christie@oracle.com>
 <1604528804-2878-7-git-send-email-michael.christie@oracle.com>
 <56056e8d-d6ff-9a6e-2a7e-1ea1737b1d27@redhat.com>
 <54285b79-637e-3dcd-382f-ddeff44f6019@oracle.com>
 <fc22b679-08c1-85bb-515a-8f63de7148a2@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5a64e2d5-1b8b-7bc6-2793-a34206c59d75@redhat.com>
Date: Tue, 10 Nov 2020 10:50:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fc22b679-08c1-85bb-515a-8f63de7148a2@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Ck9uIDIwMjAvMTEvMTAg5LiK5Y2INDozMCwgTWlrZSBDaHJpc3RpZSB3cm90ZToKPiBPbiAxMS85
LzIwIDEyOjQxIFBNLCBNaWtlIENocmlzdGllIHdyb3RlOgo+Pgo+PiBJZiB5b3Ugd2FudCB0byBw
YWlyIHRoaXMgcGF0Y2hzZXQgZG93biB0byBpdCdzIGJhcmUgYnVnIGZpeGVzIHRoYXQgCj4+IHBy
ZXZlbnQgdXNlcnMgZnJvbSBnZXR0aW5nIElPIGVycm9ycywgSSB3b3VsZCBkbyByaW5nLmFkZHIg
Y2hlY2sgb25seSAKPj4gYXBwcm9hY2ggZm9yIHRoaXMgYnVnIGZpeCBwYXRjaHNldC4KPgo+IE9o
IHllYWgsIGp1c3Qgc28gd2UgZG9uJ3QgaGF2ZSB0byBidXJuIGFuIGV4dHJhIGRheSwgYWJvdmUg
SSdtIAo+IHByb3Bvc2luZyBJIHJlcG9zdCB0aGUgb3JpZ2luYWwgcGF0Y2hzZXQ6Cj4KPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9saW51eC1zY3NpLzE2MDA3MTI1ODgtOTUxNC0xLWdpdC1zZW5k
LWVtYWlsLW1pY2hhZWwuY2hyaXN0aWVAb3JhY2xlLmNvbS90LyAKPgo+Cj4gZm9yIHRoZSBidWcg
Zml4IG9ubHkgcGF0Y2hlcy4gSXQgd2lsbCBoYXZlIHRoZSBjb21waWxlIGVycm9yIGZpeGVkIGFu
ZCAKPiBCYXJ0J3MgY29tbWVudCBoYW5kbGVkLgo+Cj4gVG8gZXZlbiB0cmltIGl0IGRvd24gbW9y
ZSBJIGNhbiBhbHNvIGRyb3AgdGhlIGxhc3QgMiBwYXRjaGVzOgo+Cj4gMDAwNy12aG9zdC1yZW1v
dmUtd29yay1hcmctZnJvbS12aG9zdF93b3JrX2ZsdXNoLnBhdGNoCj4gMDAwOC12aG9zdC1zY3Np
LXJlbW92ZS1leHRyYS1mbHVzaGVzLnBhdGNoCj4KPiBhbmQgc2VuZCBzZXBhcmF0ZWx5IGluIGEg
Y2xlYW51cHMgcGF0Y2hzZXQgc2luY2UgdGhlIGV4dHJhIGZsdXNoZXMgaXQgCj4ga2lsbHMgZG9u
J3QgcmVhbGx5IGh1cnQuCgoKRmluZSB3aXRoIG1lLgoKVGhhbmtzCgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
