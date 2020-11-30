Return-Path: <SRS0=9iyF=FE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A71C64E8A
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 11:24:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1156206C0
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 11:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AcIosT/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1156206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 28E6D85D6C;
	Mon, 30 Nov 2020 11:24:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BT8NwfV-K4fE; Mon, 30 Nov 2020 11:24:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C0B7F85D72;
	Mon, 30 Nov 2020 11:24:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2922C0859;
	Mon, 30 Nov 2020 11:24:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D0F1C0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 11:24:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 96F5586820
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 11:24:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8NDmvH3hPiQe
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 11:24:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D4F248681A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 11:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606735481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+IfSyc3oeRx7gQiNyYPDe/qMdnGQeeK0VYHxr9f3Tb4=;
 b=AcIosT/+oxoGWwStE0jWlW8M6p73oDevmB1HKSMQruwkaO9Ug5xRsl0nleKcEQUCd3GIkv
 chroKLP+2zP5ORBQ2BS1JEPg3qo8cR3ubJILdSHMqwb1z77dHVaMaT40yExMurFAUKwaA9
 Mti28yMtkx0eoVle5JTNoGWinbnaQog=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-5bUGl5OsNEW_x8dMNLuvqg-1; Mon, 30 Nov 2020 06:24:39 -0500
X-MC-Unique: 5bUGl5OsNEW_x8dMNLuvqg-1
Received: by mail-wr1-f69.google.com with SMTP id n13so8312037wrs.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:24:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=+IfSyc3oeRx7gQiNyYPDe/qMdnGQeeK0VYHxr9f3Tb4=;
 b=nmZaTa7Y/4Pj6jpE9C+2/m2wQ/e1nHZesIz/MtF6YqvUE0v7ZzjHblgo/6mvXnui4r
 leUGMTAxJ55EBK0+9tOCZ8Iy2P8GtHbegxZw2Q8Q4b51jeZjwjppfYFLV1BUhEJ4eusO
 sDFySorvWqaeNK85EPFqHQdG2EsL0MQmI+bvrCZR8KqOzZojNDCeIkYhbAwgHFOPmX9p
 UXaBzZ7kaKAodih+b8rvlvCjF7UjFVuKuzH7qGd3kAe6T0jvNfJF2JjBFbCw54/ooFi7
 vOKeC3J4Zt2mKczEgcs41aYjqsUeikxy3PE63XglKqxTXunliE10Z8/yhfyH6sWaPDY5
 OHBA==
X-Gm-Message-State: AOAM531sxBW6mmE0rhiqMb8SGz2xv1Ic0ouyhOYhNfrMh0miCM+pFJUX
 X4ZZBRAhvSgz6JHeQE+ub64hc8WHGlFuB9wMFdnakMg5TjRa+JY/S3Rkw5YHx8wksFTdbgwKpfP
 RyT++SvoYU2x2VB16+qXCxJwgZTslmsGSKAZG+C/HzA==
X-Received: by 2002:a1c:7d94:: with SMTP id
 y142mr18766789wmc.105.1606735478650; 
 Mon, 30 Nov 2020 03:24:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/AvsYD6gHoCniifoJdETBrqkKIGVgtgec5OdlwKQMCfot5hGiMNa6XokE458kB5aHmeQjsg==
X-Received: by 2002:a1c:7d94:: with SMTP id
 y142mr18766765wmc.105.1606735478412; 
 Mon, 30 Nov 2020 03:24:38 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it.
 [79.17.248.175])
 by smtp.gmail.com with ESMTPSA id b62sm16322794wmh.41.2020.11.30.03.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Nov 2020 03:24:37 -0800 (PST)
Date: Mon, 30 Nov 2020 12:24:35 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 04/17] vdpa_sim: remove the limit of IOTLB entries
Message-ID: <20201130112435.sbxqi2wpm3vlmpfi@steredhat>
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-5-sgarzare@redhat.com>
 <42989b66-9d53-cc2e-4d8e-5a93aad2efa1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <42989b66-9d53-cc2e-4d8e-5a93aad2efa1@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
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

T24gTW9uLCBOb3YgMzAsIDIwMjAgYXQgMTE6MDc6MDhBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+T24gMjAyMC8xMS8yNiDkuIvljYgxMDo0OSwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3Rl
Ogo+PlRoZSBzaW11bGF0ZWQgZGV2aWNlcyBjYW4gc3VwcG9ydCBtdWx0aXBsZSBxdWV1ZXMsIHNv
IHRoaXMgbGltaXQKPj5zaG91bGQgYmUgZGVmaW5lZCBhY2NvcmRpbmcgdG8gdGhlIG51bWJlciBv
ZiBxdWV1ZXMgc3VwcG9ydGVkIGJ5Cj4+dGhlIGRldmljZS4KPj4KPj5TaW5jZSB3ZSBhcmUgaW4g
YSBzaW11bGF0b3IsIGxldCdzIHNpbXBseSByZW1vdmUgdGhhdCBsaW1pdC4KPj4KPj5TdWdnZXN0
ZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4+QWNrZWQtYnk6IEphc29u
IFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4+U2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6
YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgo+Pi0tLQo+PnYyOgo+Pi0gYWRkZWQgVkRQQVNJ
TV9JT1RMQl9MSU1JVCBtYWNybyBbSmFzb25dCj4KPgo+U29ycnkgZm9yIGJlaW5nIHVuY2xlYXIu
IEkgbWVhbnQgYWRkaW5nIGEgbWFjcm8gbGlrZQo+Cj5WSE9TVF9JT1RMQl9VTkxJTUlURUQgMCBp
biB2aG9zdF9pb3RsYi5oLgo+Cj5BbmQgdXNlIHRoYXQgaW4gdmRwYV9zaW0uCgpHb3QgaXQgOi0p
IEknbGwgZml4IGFkZGluZyB0aGUgbWFjcm8gaW4gYW5vdGhlciBwYXRjaCBhbmQgdXNpbmcgaXQg
aW4gCnRoaXMgb25lLgoKVGhhbmtzLApTdGVmYW5vCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
