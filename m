Return-Path: <SRS0=QmqV=FB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E08DC63777
	for <virtualization@archiver.kernel.org>; Fri, 27 Nov 2020 02:54:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFE4B2222A
	for <virtualization@archiver.kernel.org>; Fri, 27 Nov 2020 02:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGr9JCuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE4B2222A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A3E5887514;
	Fri, 27 Nov 2020 02:54:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QhIssEGayGqI; Fri, 27 Nov 2020 02:54:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2E24A8751B;
	Fri, 27 Nov 2020 02:54:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15056C163C;
	Fri, 27 Nov 2020 02:54:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D76A7C0052
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Nov 2020 02:54:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C63EB87534
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Nov 2020 02:54:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BoPqYP6xcAnq
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Nov 2020 02:54:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 15ECD87244
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Nov 2020 02:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606445663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IGZK39FnAHCfDZOGE7x+2RX5gE8a4CIozSMLiIymFQw=;
 b=NGr9JCuwKxPhC5Dp0taNmAAW6ll+3E7Wm+pES+S/xZJucx7jd/+zjFyQ5PVDOfzyMXG36u
 U5Qhb5WvdqFbgILYsP68ruoPBxbmWkE2RBPxSmIMPRtmcNFBHsXrvox4bXLhN7q14kP7hI
 5dtufOSyW7waRV74zakXcvYLjTL87h4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-bMBfN4IPOHKgvLpWNJBV5A-1; Thu, 26 Nov 2020 21:54:21 -0500
X-MC-Unique: bMBfN4IPOHKgvLpWNJBV5A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 090301005E42;
 Fri, 27 Nov 2020 02:54:20 +0000 (UTC)
Received: from [10.72.13.168] (ovpn-13-168.pek2.redhat.com [10.72.13.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ABDAA5D6AC;
 Fri, 27 Nov 2020 02:54:15 +0000 (UTC)
Subject: Re: [PATCH V2 02/14] virtio-pci: switch to use devres for modern
 devices
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20201126092604.208033-1-jasowang@redhat.com>
 <20201126092604.208033-3-jasowang@redhat.com>
 <20201126084708-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9638da54-394c-98f1-ad0e-12f3f0ddf17e@redhat.com>
Date: Fri, 27 Nov 2020 10:54:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126084708-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: shahafs@mellanox.com, linux-kernel@vger.kernel.org,
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

Ck9uIDIwMjAvMTEvMjYg5LiL5Y2IOTo1NywgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9u
IFRodSwgTm92IDI2LCAyMDIwIGF0IDA1OjI1OjUyUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4+IFRoaXMgcGF0Y2ggdHJpZXMgdG8gY29udmVydCB0aGUgbW9kZXJuIGRldmljZSB0byB1c2Ug
ZGV2cmVzIHRvIG1hbmFnZQo+PiBpdHMgcmVzb3VyY2VzIChpb21hcHMpLiBCZWZvcmUgdGhpcyBw
YXRjaCB0aGUgSU8gYWRkcmVzcyBpcyBtYXBwZWQKPj4gaW5kaXZpZHVhbGx5IGFjY29yZGluZyB0
byB0aGUgY2FwYWJpbGl0eS4gQWZ0ZXIgdGhpcyBwYXRjaCwgd2Ugc2ltcGx5Cj4+IG1hcCB0aGUg
d2hvbGUgQkFSLgo+IEkgdGhpbmsgdGhlIHBvaW50IG9mIG1hcHBpbmcgY2FwYWJpbGl0eSB3YXMg
ZS5nLiBmb3IgZGV2aWNlcyB3aXRoCj4gaHVnZSBCQVJzLiBXZSBkb24ndCB3YW50IHRvIHdhc3Rl
IHZpcnR1YWwgbWVtb3J5IGZvciBlLmcuIDMyIGJpdCBndWVzdHMuCj4KPiBBbmQgaW4gcGFydGlj
dWxhciB0aGUgc3BlYyBzYXlzOgo+Cj4gCVRoZSBkcml2ZXJzIFNIT1VMRCBvbmx5IG1hcCBwYXJ0
IG9mIGNvbmZpZ3VyYXRpb24gc3RydWN0dXJlIGxhcmdlIGVub3VnaCBmb3IgZGV2aWNlIG9wZXJh
dGlvbi4gVGhlIGRyaXZlcnMKPiAJTVVTVCBoYW5kbGUgYW4gdW5leHBlY3RlZGx5IGxhcmdlIGxl
bmd0aCwgYnV0IE1BWSBjaGVjayB0aGF0IGxlbmd0aCBpcyBsYXJnZSBlbm91Z2ggZm9yIGRldmlj
ZSBvcGVyYXRpb24uCgoKR29vZCBwb2ludCwgc28gSSB3aWxsIHN0aWNrIHRvIGRldnJlcyBidXQg
bm90IHVzZSB0aGUgc2hvcnRjdXQgbGlrZSAKd2hvbGUgQkFSIG1hcHBpbmcuCgoKPgo+IEkgYWxz
byB3b25kZXIgaG93IHdvdWxkIHRoaXMgaW50ZXJhY3Qgd2l0aCBjYXNlcyB3aGVyZSBkZXZpY2Ug
bWVtb3J5IGlzCj4gbWFwcGVkIGZvciBkaWZmZXJlbnQgcmVhc29ucywgc3VjaCBhcyBmb3IgTVNJ
IHRhYmxlIGFjY2VzcywgaW50byB1c2Vyc3BhY2UKPiBhcyBpdCBoYXMgcmVzb3VyY2VzIHN1Y2gg
YXMgdmlydGlvIG1lbSwgZXRjLgoKCkkgdGhpbmsgaXQgZGVwZW5kcyBvbiB0aGUgZHJpdmVyLCBl
LmcgZm9yIHZpcnRpby1wY2kgYW5kIHZEUEEsIHRoZSB1cHBlciAKbGF5ZXIgZHJpdmVyICh2aXJ0
aW8gYnVzIG9yIHZEUEEgYnVzKSBrbm93IG5vdGhpbmcgYWJvdXQgdHJhbnNwb3J0IApzcGVjaWZp
YyB0aGluZy4gSXQgc2hvdWxkIGJlIG9rLgoKCj4gRS5nLiBkb24ndCBlLmcuIGludGVsIENQVXMg
ZGlzYWxsb3cgbWFwcGluZyB0aGUgc2FtZSBhZGRyZXNzIHR3aWNlCj4gd2l0aCBkaWZmZXJlbnQg
YXR0cmlidXRlcz8KCgpEbyB5b3UgbWVhbiBpdCBkb2Vzbid0IGFsbG93IG9uZSBWQSBpcyBtYXBw
ZWQgYXMgVUMgYnV0IHRoZSBvdGhlciBpcyAKbm90PyBJIGRvbid0IGtub3cuIEJ1dCBhbnlob3cg
bXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IAp2aXJ0aW8tcGNpL3ZwX3ZkcGEgdHJpZXMgdG8gaGlk
ZSB0aGUgZGV0YWlscyBzbyB3ZSBjYW4gbm90IGhhdmUgdHdvIAptYXBwaW5ncyBoZXJlLgoKVGhh
bmtzCgoKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
