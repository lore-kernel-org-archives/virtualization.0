Return-Path: <SRS0=2ixu=F5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC5DC433DB
	for <virtualization@archiver.kernel.org>; Fri, 25 Dec 2020 07:00:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 851CF22AAA
	for <virtualization@archiver.kernel.org>; Fri, 25 Dec 2020 07:00:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 851CF22AAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D805F873EC;
	Fri, 25 Dec 2020 07:00:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8BjFjA3nTvcd; Fri, 25 Dec 2020 07:00:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id ED176873BA;
	Fri, 25 Dec 2020 07:00:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF47FC1825;
	Fri, 25 Dec 2020 07:00:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD872C0893
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Dec 2020 07:00:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C79A586AC4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Dec 2020 07:00:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OPtR0JuOsxCr
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Dec 2020 07:00:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1F68786A35
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Dec 2020 07:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608879603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FXXaFNVTGUVp9lrtyUaIa3Klg2oiiWfo9NKoxtJtuRE=;
 b=KZ+WXm0k5yWvhKSQPX5vEU1jXcBqfIMn2yzP+klggmxH4QXsNNpt5yn44N8ESEEh5D/Ro8
 sqDlpEQSVj/2ilU0Ul9GIpe9dqIlhQ2gqd9jic4dQ0JVfhi93ReIvFiEGPhQuSkpabA/No
 Rfd7vXWrNCUIEEiPS1bKqRx852LPTwc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-GcigxxwTOgOrBiQwDAAu7g-1; Fri, 25 Dec 2020 02:00:00 -0500
X-MC-Unique: GcigxxwTOgOrBiQwDAAu7g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D7CB180A093;
 Fri, 25 Dec 2020 06:59:58 +0000 (UTC)
Received: from [10.72.12.97] (ovpn-12-97.pek2.redhat.com [10.72.12.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD6625D9CC;
 Fri, 25 Dec 2020 06:59:22 +0000 (UTC)
Subject: Re: [RFC v2 06/13] vduse: Introduce VDUSE - vDPA Device in Userspace
To: Yongji Xie <xieyongji@bytedance.com>
References: <20201222145221.711-1-xieyongji@bytedance.com>
 <20201222145221.711-7-xieyongji@bytedance.com>
 <468be90d-1d98-c819-5492-32a2152d2e36@redhat.com>
 <CACycT3vYb_CdWz3wZ1OY=KynG=1qZgaa_Ngko2AO0JHn_fFXEA@mail.gmail.com>
 <26ea3a3d-b06b-6256-7243-8ca9eae61bce@redhat.com>
 <CACycT3uKb1P7zXyCBYWDb6VhGXV0cdJPH3CPcRzjwz57tyODgA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a47ecb89-b677-2001-5573-d71be5edd4c9@redhat.com>
Date: Fri, 25 Dec 2020 14:59:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACycT3uKb1P7zXyCBYWDb6VhGXV0cdJPH3CPcRzjwz57tyODgA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: axboe@kernel.dk, corbet@lwn.net, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-aio@kvack.org,
 netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org, bcrl@kvack.org,
 viro@zeniv.linux.org.uk, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org
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

Ck9uIDIwMjAvMTIvMjQg5LiL5Y2INDozNCwgWW9uZ2ppIFhpZSB3cm90ZToKPj4gWWVzLCB0aGUg
ZGlzYWR2YW50YWdlIGlzIHRoZSBwZXJmb3JtYW5jZS4gQnV0IGl0IHNob3VsZCBiZSBzaW1wbGVy
IChJCj4+IGd1ZXNzKSBhbmQgd2Uga25vdyBpdCBjYW4gc3VjY2VlZC4KPj4KPiBZZXMsIGFub3Ro
ZXIgYWR2YW50YWdlIGlzIHRoYXQgd2UgY2FuIHN1cHBvcnQgdGhlIFZNIHVzaW5nIGFub255bW91
cyBtZW1vcnkuCgoKRXhhY3RseS4KCgo+Cj4+PiBJIHRoaW5rIEkgY2FuIHRyeSB0aGlzIGluIHYz
LiBBbmQgdGhlCj4+PiBNTVUtYmFzZWQgSU9NTVUgaW1wbGVtZW50YXRpb24gY2FuIGJlIGEgZnV0
dXJlIG9wdGltaXphdGlvbiBpbiB0aGUKPj4+IHZpcnRpby12ZHBhIGNhc2UuIFdoYXQncyB5b3Vy
IG9waW5pb24/Cj4+IE1heWJlIEkgd2FzIHdyb25nLCBidXQgSSB0aGluayB3ZSBjYW4gdHJ5IGFz
IHdoYXQgaGFzIGJlZW4gcHJvcG9zZWQgaGVyZQo+PiBmaXJzdCBhbmQgdXNlIHNoYWRvdyB2aXJ0
cXVldWUgYXMgYmFja3VwIHBsYW4gaWYgd2UgZmFpbC4KPj4KPiBPSywgSSB3aWxsIGNvbnRpbnVl
IHRvIHdvcmsgb24gdGhpcyBwcm9wb3NhbC4KCgpUaGFua3MKCj4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
