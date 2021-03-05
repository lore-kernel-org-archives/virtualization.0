Return-Path: <SRS0=gmSK=ID=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB64C433DB
	for <virtualization@archiver.kernel.org>; Fri,  5 Mar 2021 03:12:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EFB264FF3
	for <virtualization@archiver.kernel.org>; Fri,  5 Mar 2021 03:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EFB264FF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A8664ECBD;
	Fri,  5 Mar 2021 03:12:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eVDkznmhwbVG; Fri,  5 Mar 2021 03:11:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E76F4ECA6;
	Fri,  5 Mar 2021 03:11:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15E0AC000B;
	Fri,  5 Mar 2021 03:11:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B9D0C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 03:11:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3297D432D1
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 03:11:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id saAvf1BDV00G
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 03:11:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 864BE432CD
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 03:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614913916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bRNOpSLwFJxiZfQagzjze9iaWCzAF8OGRLFEB+wT6tI=;
 b=YLBOzpRPG48V4uJOGoqmgAXQorKLf8zVDRI7jORLxFKJ4/cTfXTwsGUuwTmN3qVUKwWUbE
 n5ZsXEwtq9UcySHQQOtSIOOSjBLmRs+RKov3FjPz9Wq+i8JKRJuw7jqo+8jMiLDX9w35nS
 ZptaHUjUvD8GqtKyuKBYTSco13dRlDA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-ZMZ_vDNzMG6EOd8-U9krxA-1; Thu, 04 Mar 2021 22:11:54 -0500
X-MC-Unique: ZMZ_vDNzMG6EOd8-U9krxA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E081107465F;
 Fri,  5 Mar 2021 03:11:52 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-196.pek2.redhat.com
 [10.72.13.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 66B4A6268B;
 Fri,  5 Mar 2021 03:11:40 +0000 (UTC)
Subject: Re: [RFC v4 11/11] vduse: Support binding irq to the specified cpu
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210223115048.435-1-xieyongji@bytedance.com>
 <20210223115048.435-12-xieyongji@bytedance.com>
 <d104a518-799d-c13f-311c-f7a673f9241b@redhat.com>
 <CACycT3uaOU5ybwojfiSL0kSpW9GUnh82ZeDH7drdkfK72iP8bg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <86af7b84-23f0-dca7-183b-e4d586cbcea6@redhat.com>
Date: Fri, 5 Mar 2021 11:11:38 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CACycT3uaOU5ybwojfiSL0kSpW9GUnh82ZeDH7drdkfK72iP8bg@mail.gmail.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-aio@kvack.org, netdev@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>, Matthew Wilcox <willy@infradead.org>,
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

Ck9uIDIwMjEvMy80IDQ6MTkg5LiL5Y2ILCBZb25namkgWGllIHdyb3RlOgo+IE9uIFRodSwgTWFy
IDQsIDIwMjEgYXQgMzozMCBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90
ZToKPj4KPj4gT24gMjAyMS8yLzIzIDc6NTAg5LiL5Y2ILCBYaWUgWW9uZ2ppIHdyb3RlOgo+Pj4g
QWRkIGEgcGFyYW1ldGVyIGZvciB0aGUgaW9jdGwgVkRVU0VfSU5KRUNUX1ZRX0lSUSB0byBzdXBw
b3J0Cj4+PiBpbmplY3RpbmcgdmlydHF1ZXVlJ3MgaW50ZXJydXB0IHRvIHRoZSBzcGVjaWZpZWQg
Y3B1Lgo+Pgo+PiBIb3cgdXNlcnNwYWNlIGtub3cgd2hpY2ggQ1BVIGlzIHRoaXMgaXJxIGZvcj8g
SXQgbG9va3MgdG8gbWUgd2UgbmVlZCB0bwo+PiBkbyBpdCBhdCBkaWZmZXJlbnQgbGV2ZWwuCj4+
Cj4+IEUuZyBpbnRyb2R1Y2Ugc29tZSBBUEkgaW4gc3lzIHRvIGFsbG93IGFkbWluIHRvIHR1bmUg
Zm9yIHRoYXQuCj4+Cj4+IEJ1dCBJIHRoaW5rIHdlIGNhbiBkbyB0aGF0IGluIGFudG9oZXIgcGF0
Y2ggb24gdG9wIG9mIHRoaXMgc2VyaWVzLgo+Pgo+IE9LLiBJIHdpbGwgdGhpbmsgbW9yZSBhYm91
dCBpdC4KCgpJdCBzaG91bGQgYmUgc29lbXRoaW5nIGxpa2UgCi9zeXMvY2xhc3MvdmR1c2UvJGRl
dl9uYW1lL3ZxLzAvaXJxX2FmZmluaXR5LiBBbHNvIG5lZWQgdG8gbWFrZSBzdXJlIApldmVudGZk
IGNvdWxkIG5vdCBiZSByZXVzZWQuCgpUaGFua3MKCgo+Cj4gVGhhbmtzLAo+IFlvbmdqaQo+Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
