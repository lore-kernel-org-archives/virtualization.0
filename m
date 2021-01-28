Return-Path: <SRS0=vMKq=G7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E34C433DB
	for <virtualization@archiver.kernel.org>; Thu, 28 Jan 2021 03:05:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EC3264DD7
	for <virtualization@archiver.kernel.org>; Thu, 28 Jan 2021 03:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC3264DD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8065C228E7;
	Thu, 28 Jan 2021 03:05:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TezyMGHwgRJq; Thu, 28 Jan 2021 03:05:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 02842203B2;
	Thu, 28 Jan 2021 03:05:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8607C08A1;
	Thu, 28 Jan 2021 03:05:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BEE8C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 03:05:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 870B986094
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 03:05:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ee1OVdcltY4Z
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 03:05:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B17BE86180
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 03:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611803100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZtvGjwvPJQPTd5iszx1z5cgMmarf/C6MBn65XN9DRzU=;
 b=U/Fp2NoCkI6yeq6CNly09sbU/OX/oWM6yNobWO3+lgVPeldnCVkWXnMMe2gtYuKc86HtP+
 p0IIfzXFaBrx4nm/F4dct0nO1ZYAwSYSAHAaCNuIMHfqTP1+BUv0lTgnuNE5QXLHpWgr5E
 nBvITbN7i73V6pxYRkqs1gMfzpCWmHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-jvgTJUraNSKs0lUfxy9d5A-1; Wed, 27 Jan 2021 22:04:58 -0500
X-MC-Unique: jvgTJUraNSKs0lUfxy9d5A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDBA1107ACE3;
 Thu, 28 Jan 2021 03:04:55 +0000 (UTC)
Received: from [10.72.12.167] (ovpn-12-167.pek2.redhat.com [10.72.12.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D36235D9E3;
 Thu, 28 Jan 2021 03:04:43 +0000 (UTC)
Subject: Re: [RFC v3 01/11] eventfd: track eventfd_signal() recursion depth
 separately in different cases
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210119045920.447-1-xieyongji@bytedance.com>
 <20210119045920.447-2-xieyongji@bytedance.com>
 <e8a2cc15-80f5-01e0-75ec-ea6281fda0eb@redhat.com>
 <CACycT3sN0+dg-NubAK+N-DWf3UDXwWh=RyRX-qC9fwdg3QaLWA@mail.gmail.com>
 <6a5f0186-c2e3-4603-9826-50d5c68a3fda@redhat.com>
 <CACycT3sqDgccOfNcY_FNcHDqJ2DeMbigdFuHYm9DxWWMjkL7CQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b5c9f2d4-5b95-4552-3886-f5cbcb7de232@redhat.com>
Date: Thu, 28 Jan 2021 11:04:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACycT3sqDgccOfNcY_FNcHDqJ2DeMbigdFuHYm9DxWWMjkL7CQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Ck9uIDIwMjEvMS8yNyDkuIvljYg1OjExLCBZb25namkgWGllIHdyb3RlOgo+IE9uIFdlZCwgSmFu
IDI3LCAyMDIxIGF0IDExOjM4IEFNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdy
b3RlOgo+Pgo+PiBPbiAyMDIxLzEvMjAg5LiL5Y2IMjo1MiwgWW9uZ2ppIFhpZSB3cm90ZToKPj4+
IE9uIFdlZCwgSmFuIDIwLCAyMDIxIGF0IDEyOjI0IFBNIEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+IHdyb3RlOgo+Pj4+IE9uIDIwMjEvMS8xOSDkuIvljYgxMjo1OSwgWGllIFlvbmdq
aSB3cm90ZToKPj4+Pj4gTm93IHdlIGhhdmUgYSBnbG9iYWwgcGVyY3B1IGNvdW50ZXIgdG8gbGlt
aXQgdGhlIHJlY3Vyc2lvbiBkZXB0aAo+Pj4+PiBvZiBldmVudGZkX3NpZ25hbCgpLiBUaGlzIGNh
biBhdm9pZCBkZWFkbG9jayBvciBzdGFjayBvdmVyZmxvdy4KPj4+Pj4gQnV0IGluIHN0YWNrIG92
ZXJmbG93IGNhc2UsIGl0IHNob3VsZCBiZSBPSyB0byBpbmNyZWFzZSB0aGUKPj4+Pj4gcmVjdXJz
aW9uIGRlcHRoIGlmIG5lZWRlZC4gU28gd2UgYWRkIGEgcGVyY3B1IGNvdW50ZXIgaW4gZXZlbnRm
ZF9jdHgKPj4+Pj4gdG8gbGltaXQgdGhlIHJlY3Vyc2lvbiBkZXB0aCBmb3IgZGVhZGxvY2sgY2Fz
ZS4gVGhlbiBpdCBjb3VsZCBiZQo+Pj4+PiBmaW5lIHRvIGluY3JlYXNlIHRoZSBnbG9iYWwgcGVy
Y3B1IGNvdW50ZXIgbGF0ZXIuCj4+Pj4gSSB3b25kZXIgd2hldGhlciBvciBub3QgaXQncyB3b3J0
aCB0byBpbnRyb2R1Y2UgcGVyY3B1IGZvciBlYWNoIGV2ZW50ZmQuCj4+Pj4KPj4+PiBIb3cgYWJv
dXQgc2ltcGx5IGNoZWNrIGlmIGV2ZW50ZmRfc2lnbmFsX2NvdW50KCkgaXMgZ3JlYXRlciB0aGFu
IDI/Cj4+Pj4KPj4+IEl0IGNhbid0IGF2b2lkIGRlYWRsb2NrIGluIHRoaXMgd2F5Lgo+Pgo+PiBJ
IG1heSBtaXNzIHNvbWV0aGluZyBidXQgdGhlIGNvdW50IGlzIHRvIGF2b2lkIHJlY3Vyc2l2ZSBl
dmVudGZkIGNhbGwuCj4+IFNvIGZvciBWRFVTRSB3aGF0IHdlIHN1ZmZlcnMgaXMgZS5nIHRoZSBp
bnRlcnJ1cHQgaW5qZWN0aW9uIHBhdGg6Cj4+Cj4+IHVzZXJzcGFjZSB3cml0ZSBJUlFGRCAtPiB2
cS0+Y2IoKSAtPiBhbm90aGVyIElSUUZELgo+Pgo+PiBJdCBsb29rcyBsaWtlIGluY3JlYXNpbmcg
RVZFTlRGRF9XQUtFVVBfREVQVEggc2hvdWxkIGJlIHN1ZmZpY2llbnQ/Cj4+Cj4gQWN0dWFsbHkg
SSBtZWFuIHRoZSBkZWFkbG9jayBkZXNjcmliZWQgaW4gY29tbWl0IGYwYjQ5M2UgKCJpb191cmlu
ZzoKPiBwcmV2ZW50IHBvdGVudGlhbCBldmVudGZkIHJlY3Vyc2lvbiBvbiBwb2xsIikuIEl0IGNh
biBicmVhayB0aGlzIGJ1Zwo+IGZpeCBpZiB3ZSBqdXN0IGluY3JlYXNlIEVWRU5URkRfV0FLRVVQ
X0RFUFRILgoKCk9rLCBzbyBjYW4gd2FpdCBkbyBzb21ldGhpbmcgc2ltaWxhciBpbiB0aGF0IGNv
bW1pdD8gKHVzaW5nIGFzeW5jIHN0dWZmcyAKbGlrZSB3cSkuCgpUaGFua3MKCgo+Cj4gVGhhbmtz
LAo+IFlvbmdqaQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
