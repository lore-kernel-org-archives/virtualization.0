Return-Path: <SRS0=CB8P=DZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BB3C433E7
	for <virtualization@archiver.kernel.org>; Sun, 18 Oct 2020 16:34:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1911C20874
	for <virtualization@archiver.kernel.org>; Sun, 18 Oct 2020 16:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZorFqTTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1911C20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 80DD98766C;
	Sun, 18 Oct 2020 16:34:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r58ubC5RFBUu; Sun, 18 Oct 2020 16:34:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D6F0E8764F;
	Sun, 18 Oct 2020 16:34:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5817C088B;
	Sun, 18 Oct 2020 16:34:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEC5DC0051
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 16:34:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D612087651
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 16:34:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 96uPot5BppWR
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 16:34:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0674D8764F
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 16:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603038868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tj1GVI5fIufYKq33cZcp4lMggRo37S38C44brLbdXpI=;
 b=ZorFqTTN4/Y96RZ+CRIndniaATWuTBktierzqqLOmxn2YbyTX0GnY7wEpwTTaEE7L66qSO
 TxeLnMeJ7NiO6S2fm/JklXzaL5xlahctqQ5T+s+7xp4hByio/i7GXrLsvW9gtmhbKkY7kI
 +6ySZoe4oeVZnSemGUdx9K3QDLdM1y0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-IZeUUyFqMnaMDwWt6JC-KA-1; Sun, 18 Oct 2020 12:34:24 -0400
X-MC-Unique: IZeUUyFqMnaMDwWt6JC-KA-1
Received: by mail-ej1-f69.google.com with SMTP id c20so3667766ejs.12
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 09:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=5OQ9GqIpXNZUq0RyT7/UOYX7bWD6BBz65MJ1fbErdN4=;
 b=bq+p5ZXvGW4j9Oj3IGZXdGtlfaoWzjuuB4zHUPRJqqxHgzxcXWLFcwG3HJWgH4ZRoe
 ODMWv6xU4prIJoQL3qCzeUFA6V4tH7yF1v3fVS3T8c6C7I0uxGuTQ9y02EGpsTRlcBcZ
 h3o7S2NeQ1aoKrwMlBK1mp3GrPU128aFIdQUZk2iSDHKnwXRKQSkIPnq271x6mcQQXcd
 PG2NfRWluz4vVN8kTOCgc7Ncjssv7gaqlh5a/Wp3eDmnTUef9tX/Yb79lFvMEAJCfJEG
 yY9UDfSdOpe8fQ9lwVEZlMYYekz3XPlt7GC86VHP2BCAnwSLGkeraBxUwf7XVqrbd5aY
 sBMg==
X-Gm-Message-State: AOAM533IrrIZRRqJ+EheLIDT9lC+DFJCFKlTwVNxb9j015m7Mb46XKi9
 5zqwwbT+YgR6ZwUW2RlKXii3Vh5IluWqBaMpJixD/eCQTunvGmQf4M18WmxaHwSESwIsdWR2cpa
 Ko9IAZghoL4InfflAGoDJ4UjuSMepy1Wvj74cIHbsyA==
X-Received: by 2002:a50:8e5a:: with SMTP id 26mr14602823edx.161.1603038863244; 
 Sun, 18 Oct 2020 09:34:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyuH9POxrGvtu+LMKcbrcV/4vICqK4liEhBDN37HvQGacvH9EfF3s6tT5q2bHufDhLBfH4Wg==
X-Received: by 2002:a50:8e5a:: with SMTP id 26mr14602809edx.161.1603038863027; 
 Sun, 18 Oct 2020 09:34:23 -0700 (PDT)
Received: from [192.168.3.114] (p4ff233d0.dip0.t-ipconnect.de. [79.242.51.208])
 by smtp.gmail.com with ESMTPSA id v14sm7677245ejh.6.2020.10.18.09.34.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Oct 2020 09:34:22 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1 00/29] virtio-mem: Big Block Mode (BBM)
Date: Sun, 18 Oct 2020 18:34:21 +0200
Message-Id: <ED93C2B5-67F0-4FFA-8FF1-4545B86456FA@redhat.com>
References: <20201018112849-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201018112849-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: iPhone Mail (18A393)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Wei Yang <richard.weiyang@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>,
 Oscar Salvador <osalvador@suse.de>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Cj4gQW0gMTguMTAuMjAyMCB1bSAxNzoyOSBzY2hyaWViIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+Ogo+IAo+IO+7v09uIE1vbiwgT2N0IDEyLCAyMDIwIGF0IDAyOjUyOjU0UE0g
KzAyMDAsIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOgo+PiB2aXJ0aW8tbWVtIGN1cnJlbnRseSBv
bmx5IHN1cHBvcnRzIGRldmljZSBibG9jayBzaXplcyB0aGF0IHNwYW4gYXQgbW9zdAo+PiBhIHNp
bmdsZSBMaW51eCBtZW1vcnkgYmxvY2suIEZvciBleGFtcGxlLCBnaWdhbnRpYyBwYWdlcyBpbiB0
aGUgaHlwZXJ2aXNvcgo+PiByZXN1bHQgb24geDg2LTY0IGluIGEgZGV2aWNlIGJsb2NrIHNpemUg
b2YgMSBHaUIgLSB3aGVuIHRoZSBMaW51eCBtZW1vcnkKPj4gYmxvY2sgc2l6ZSBpcyAxMjggTWlC
LCB3ZSBjYW5ub3Qgc3VwcG9ydCBzdWNoIGRldmljZXMgKHdlIGZhaWwgbG9hZGluZyB0aGUKPj4g
ZHJpdmVyKS4gT2YgY291cnNlLCB3ZSB3YW50IHRvIHN1cHBvcnQgYW55IGRldmljZSBibG9jayBz
aXplIGluIGFueSBMaW51eAo+PiBWTS4KPj4gCj4+IEJpZ2dlciBkZXZpY2UgYmxvY2sgc2l6ZXMg
d2lsbCBiZWNvbWUgZXNwZWNpYWxseSBpbXBvcnRhbnQgb25jZSBzdXBwb3J0aW5nCj4+IFZGSU8g
aW4gUUVNVSAtIGVhY2ggZGV2aWNlIGJsb2NrIGhhcyB0byBiZSBtYXBwZWQgc2VwYXJhdGVseSwg
YW5kIHRoZQo+PiBtYXhpbXVtIG51bWJlciBvZiBtYXBwaW5ncyBmb3IgVkZJTyBpcyA2NGsuIFNv
IHdlIHVzdWFsbHkgd2FudCBibG9ja3MgaW4KPj4gdGhlIGdpZ2FieXRlIHJhbmdlIHdoZW4gd2Fu
dGluZyB0byBncm93IHRoZSBWTSBiaWcuCj4gCj4gSSBndWVzcyBpdCBtaXNzZWQgdGhpcyBMaW51
eCByaWdodD8gVGhlcmUncyBhbiBtbSBjaGFuZ2Ugd2hpY2ggZGlkIG5vdAo+IGdldCBhbiBhY2sg
ZnJvbSBtbSBtYWluYXRpbmVycywgc28gSSBjYW4ndCBtZXJnZSBpdCAuLi4KCk5vIGlzc3VlLCBJ
IHdhcyB0YXJnZXRpbmcgNS4xMSBlaXRoZXIgd2F5ISBJ4oCYbGwgcmVzZW5kIGJhc2VkIG9uIGxp
bnVz4oCYIHRyZWUgbm93IHRoYXQgYWxsIHByZXJlcXMgYXJlIHVwc3RyZWFtLgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
