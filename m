Return-Path: <SRS0=N1kl=G6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A122C433E0
	for <virtualization@archiver.kernel.org>; Wed, 27 Jan 2021 03:38:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A793E205CA
	for <virtualization@archiver.kernel.org>; Wed, 27 Jan 2021 03:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A793E205CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 49CDD204B1;
	Wed, 27 Jan 2021 03:38:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z3ryXrtShr5v; Wed, 27 Jan 2021 03:38:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BC1282000E;
	Wed, 27 Jan 2021 03:38:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9BBDC08A1;
	Wed, 27 Jan 2021 03:38:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28DA7C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 03:38:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0D2CB86D52
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 03:38:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X6mdsNIU9IqR
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 03:38:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 62C3D86C94
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 03:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611718699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ojwvtMBCsJJQwZI0mURdly6zmrAVvM3gxoe36lRJ0c=;
 b=cJz9q05B1eYzB6aPCwyUZokeBBWF51vdmy5EWeP5PcFH2KT/Pt8I1Js1ZubX0HGFiRstxI
 Ws1QoMyyRqtH3IFEmd4xXSUbU5TGDJw7ZtS1uSxO4xzqwdH+fEPjrxNUZR9ZYUm0nl+dyJ
 d76QT3Y5jfekZss2Ulvw/o8JG76dcwQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-evH1NpuwP6CCyR5UVzOXgw-1; Tue, 26 Jan 2021 22:38:15 -0500
X-MC-Unique: evH1NpuwP6CCyR5UVzOXgw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CA3F1922021;
 Wed, 27 Jan 2021 03:38:13 +0000 (UTC)
Received: from [10.72.13.33] (ovpn-13-33.pek2.redhat.com [10.72.13.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A00FB19726;
 Wed, 27 Jan 2021 03:37:56 +0000 (UTC)
Subject: Re: [RFC v3 01/11] eventfd: track eventfd_signal() recursion depth
 separately in different cases
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210119045920.447-1-xieyongji@bytedance.com>
 <20210119045920.447-2-xieyongji@bytedance.com>
 <e8a2cc15-80f5-01e0-75ec-ea6281fda0eb@redhat.com>
 <CACycT3sN0+dg-NubAK+N-DWf3UDXwWh=RyRX-qC9fwdg3QaLWA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6a5f0186-c2e3-4603-9826-50d5c68a3fda@redhat.com>
Date: Wed, 27 Jan 2021 11:37:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACycT3sN0+dg-NubAK+N-DWf3UDXwWh=RyRX-qC9fwdg3QaLWA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: axboe@kernel.dk, Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-aio@kvack.org,
 netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Bob Liu <bob.liu@oracle.com>,
 bcrl@kvack.org, viro@zeniv.linux.org.uk, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org
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

Ck9uIDIwMjEvMS8yMCDkuIvljYgyOjUyLCBZb25namkgWGllIHdyb3RlOgo+IE9uIFdlZCwgSmFu
IDIwLCAyMDIxIGF0IDEyOjI0IFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdy
b3RlOgo+Pgo+PiBPbiAyMDIxLzEvMTkg5LiL5Y2IMTI6NTksIFhpZSBZb25namkgd3JvdGU6Cj4+
PiBOb3cgd2UgaGF2ZSBhIGdsb2JhbCBwZXJjcHUgY291bnRlciB0byBsaW1pdCB0aGUgcmVjdXJz
aW9uIGRlcHRoCj4+PiBvZiBldmVudGZkX3NpZ25hbCgpLiBUaGlzIGNhbiBhdm9pZCBkZWFkbG9j
ayBvciBzdGFjayBvdmVyZmxvdy4KPj4+IEJ1dCBpbiBzdGFjayBvdmVyZmxvdyBjYXNlLCBpdCBz
aG91bGQgYmUgT0sgdG8gaW5jcmVhc2UgdGhlCj4+PiByZWN1cnNpb24gZGVwdGggaWYgbmVlZGVk
LiBTbyB3ZSBhZGQgYSBwZXJjcHUgY291bnRlciBpbiBldmVudGZkX2N0eAo+Pj4gdG8gbGltaXQg
dGhlIHJlY3Vyc2lvbiBkZXB0aCBmb3IgZGVhZGxvY2sgY2FzZS4gVGhlbiBpdCBjb3VsZCBiZQo+
Pj4gZmluZSB0byBpbmNyZWFzZSB0aGUgZ2xvYmFsIHBlcmNwdSBjb3VudGVyIGxhdGVyLgo+Pgo+
PiBJIHdvbmRlciB3aGV0aGVyIG9yIG5vdCBpdCdzIHdvcnRoIHRvIGludHJvZHVjZSBwZXJjcHUg
Zm9yIGVhY2ggZXZlbnRmZC4KPj4KPj4gSG93IGFib3V0IHNpbXBseSBjaGVjayBpZiBldmVudGZk
X3NpZ25hbF9jb3VudCgpIGlzIGdyZWF0ZXIgdGhhbiAyPwo+Pgo+IEl0IGNhbid0IGF2b2lkIGRl
YWRsb2NrIGluIHRoaXMgd2F5LgoKCkkgbWF5IG1pc3Mgc29tZXRoaW5nIGJ1dCB0aGUgY291bnQg
aXMgdG8gYXZvaWQgcmVjdXJzaXZlIGV2ZW50ZmQgY2FsbC4gClNvIGZvciBWRFVTRSB3aGF0IHdl
IHN1ZmZlcnMgaXMgZS5nIHRoZSBpbnRlcnJ1cHQgaW5qZWN0aW9uIHBhdGg6Cgp1c2Vyc3BhY2Ug
d3JpdGUgSVJRRkQgLT4gdnEtPmNiKCkgLT4gYW5vdGhlciBJUlFGRC4KCkl0IGxvb2tzIGxpa2Ug
aW5jcmVhc2luZyBFVkVOVEZEX1dBS0VVUF9ERVBUSCBzaG91bGQgYmUgc3VmZmljaWVudD8KClRo
YW5rcwoKCj4gU28gd2UgbmVlZCBhIHBlcmNwdSBjb3VudGVyIGZvcgo+IGVhY2ggZXZlbnRmZCB0
byBsaW1pdCB0aGUgcmVjdXJzaW9uIGRlcHRoIGZvciBkZWFkbG9jayBjYXNlcy4gQW5kCj4gdXNp
bmcgYSBnbG9iYWwgcGVyY3B1IGNvdW50ZXIgdG8gYXZvaWQgc3RhY2sgb3ZlcmZsb3cuCj4KPiBU
aGFua3MsCj4gWW9uZ2ppCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
