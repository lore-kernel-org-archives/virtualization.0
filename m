Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B901C433DF
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 08:10:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BD782177B
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 08:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUs8nJqi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD782177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E755088081;
	Wed,  5 Aug 2020 08:09:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lB4vd00p6y2Y; Wed,  5 Aug 2020 08:09:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4824E87FC3;
	Wed,  5 Aug 2020 08:09:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3894BC0050;
	Wed,  5 Aug 2020 08:09:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5AFBC004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 08:09:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A15E5855CE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 08:09:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5VgEHaeCOb0K
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 08:09:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id EAB95855C6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 08:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596614995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=35YQLrzEFpSuMDBiIDVfflKea5B3kUFbcPPBSXZZfAA=;
 b=RUs8nJqi8loJ8AYc2+5XGzoZia2X4A/XVHuX4trs7iZIlHWSSCxDX1iuuk6svTkH0lSqMc
 TZRhW+mh2qm87OV4aDo9NLYKVISQdcpLt52rp9fu94SryVyM4eC5VE8qOWruitXIZf13H3
 TS1M806bSxJTWJZKnR95yjwukJ7Q88I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-jIFZ95raOXGXS3EdU61sUA-1; Wed, 05 Aug 2020 04:09:52 -0400
X-MC-Unique: jIFZ95raOXGXS3EdU61sUA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 249CC100A8FD;
 Wed,  5 Aug 2020 08:09:51 +0000 (UTC)
Received: from [10.72.12.225] (ovpn-12-225.pek2.redhat.com [10.72.12.225])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F44088D57;
 Wed,  5 Aug 2020 08:09:45 +0000 (UTC)
Subject: Re: [PATCH V4 linux-next 12/12] vdpa/mlx5: Add VDPA driver for
 supported mlx5 devices
To: Eli Cohen <eli@mellanox.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20200804162048.22587-1-eli@mellanox.com>
 <20200804162048.22587-13-eli@mellanox.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2e243137-5ada-1161-ed27-62804f24752b@redhat.com>
Date: Wed, 5 Aug 2020 16:09:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200804162048.22587-13-eli@mellanox.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: shahafs@mellanox.com, parav@mellanox.com, saeedm@mellanox.com
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

Ck9uIDIwMjAvOC81IOS4iuWNiDEyOjIwLCBFbGkgQ29oZW4gd3JvdGU6Cj4gQWRkIGEgZnJvbnQg
ZW5kIFZEUEEgZHJpdmVyIHRoYXQgcmVnaXN0ZXJzIGluIHRoZSBWRFBBIGJ1cyBhbmQgcHJvdmlk
ZXMKPiBuZXR3b3JraW5nIHRvIGEgZ3Vlc3QuIFRoZSBWRFBBIGRyaXZlciBjcmVhdGVzIHRoZSBu
ZWNlc3NhcnkgcmVzb3VyY2VzCj4gb24gdGhlIFZGIGl0IGlzIGRyaXZpbmcgc3VjaCB0aGF0IGRh
dGEgcGF0aCB3aWxsIGJlIG9mZmxvYWRlZC4KPgo+IE5vdGlmaWNhdGlvbnMgYXJlIGJlaW5nIGNv
bW11bmljYXRlZCB0aHJvdWdoIHRoZSBkcml2ZXIuCj4KPiBDdXJyZW50bHksIG9ubHkgVkZzIGFy
ZSBzdXBwb3J0ZWQuIEluIHN1YnNlcXVlbnQgcGF0Y2hlcyB3ZSB3aWxsIGhhdmUKPiBkZXZsaW5r
IHN1cHBvcnQgdG8gY29udHJvbCB3aGljaCBWRiBpcyB1c2VkIGZvciBWRFBBIGFuZCB3aGljaCBm
dW5jdGlvbgo+IGlzIHVzZWQgZm9yIHJlZ3VsYXIgbmV0d29ya2luZy4KPgo+IFJldmlld2VkLWJ5
OiBQYXJhdiBQYW5kaXQ8cGFyYXZAbWVsbGFub3guY29tPgo+IFNpZ25lZC1vZmYtYnk6IEVsaSBD
b2hlbjxlbGlAbWVsbGFub3guY29tPgo+IC0tLQoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNv
d2FuZ0ByZWRoYXQuY29tPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
