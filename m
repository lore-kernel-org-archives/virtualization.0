Return-Path: <SRS0=vMKq=G7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F36C433E0
	for <virtualization@archiver.kernel.org>; Thu, 28 Jan 2021 04:32:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E06764DD6
	for <virtualization@archiver.kernel.org>; Thu, 28 Jan 2021 04:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E06764DD6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 927588738A;
	Thu, 28 Jan 2021 04:32:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u6GhubN0mU2k; Thu, 28 Jan 2021 04:32:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id ED8C487083;
	Thu, 28 Jan 2021 04:32:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF259C08A1;
	Thu, 28 Jan 2021 04:32:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44E03C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 04:32:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2ABE2871B6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 04:32:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YW46w5snJedQ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 04:32:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5E3DB87083
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 04:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611808351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9NCZe85xmzeU0w+bJ6oE1HvmZ9MVGIS2YzFczMlWDrw=;
 b=WAC41jwmC2myLndYPuxjkVt8/3ykJmBrfX4xSuXxsqMpmrMPmrcCHiYR5DfJxWHkqWz2au
 YkYiUXC/pAWiUS6Uj2Vt3oHggPFY6Dol8rty972p/BepOSW9GOq84ZK0luo7JisGCq30d6
 fBxeM9eKJn/UoYkyqe1jLLBRmNr9SlQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-rl1Hd8ASP-Cc1ju6c1ceNg-1; Wed, 27 Jan 2021 23:31:20 -0500
X-MC-Unique: rl1Hd8ASP-Cc1ju6c1ceNg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D323801FCC;
 Thu, 28 Jan 2021 04:31:18 +0000 (UTC)
Received: from [10.72.12.167] (ovpn-12-167.pek2.redhat.com [10.72.12.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A1685C1BB;
 Thu, 28 Jan 2021 04:31:03 +0000 (UTC)
Subject: Re: [RFC v3 01/11] eventfd: track eventfd_signal() recursion depth
 separately in different cases
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210119045920.447-1-xieyongji@bytedance.com>
 <20210119045920.447-2-xieyongji@bytedance.com>
 <e8a2cc15-80f5-01e0-75ec-ea6281fda0eb@redhat.com>
 <CACycT3sN0+dg-NubAK+N-DWf3UDXwWh=RyRX-qC9fwdg3QaLWA@mail.gmail.com>
 <6a5f0186-c2e3-4603-9826-50d5c68a3fda@redhat.com>
 <CACycT3sqDgccOfNcY_FNcHDqJ2DeMbigdFuHYm9DxWWMjkL7CQ@mail.gmail.com>
 <b5c9f2d4-5b95-4552-3886-f5cbcb7de232@redhat.com>
 <CACycT3u6Ayf_X8Mv4EvF+B=B4OzFSK8ygvJMRnO6CDgYF13Qnw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9226c594-e045-544d-4e46-c4c3c9c573a9@redhat.com>
Date: Thu, 28 Jan 2021 12:31:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACycT3u6Ayf_X8Mv4EvF+B=B4OzFSK8ygvJMRnO6CDgYF13Qnw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

Ck9uIDIwMjEvMS8yOCDkuIrljYgxMTo1MiwgWW9uZ2ppIFhpZSB3cm90ZToKPiBPbiBUaHUsIEph
biAyOCwgMjAyMSBhdCAxMTowNSBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3
cm90ZToKPj4KPj4gT24gMjAyMS8xLzI3IOS4i+WNiDU6MTEsIFlvbmdqaSBYaWUgd3JvdGU6Cj4+
PiBPbiBXZWQsIEphbiAyNywgMjAyMSBhdCAxMTozOCBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPj4+PiBPbiAyMDIxLzEvMjAg5LiL5Y2IMjo1MiwgWW9uZ2ppIFhp
ZSB3cm90ZToKPj4+Pj4gT24gV2VkLCBKYW4gMjAsIDIwMjEgYXQgMTI6MjQgUE0gSmFzb24gV2Fu
ZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4+PiBPbiAyMDIxLzEvMTkg5LiL5Y2I
MTI6NTksIFhpZSBZb25namkgd3JvdGU6Cj4+Pj4+Pj4gTm93IHdlIGhhdmUgYSBnbG9iYWwgcGVy
Y3B1IGNvdW50ZXIgdG8gbGltaXQgdGhlIHJlY3Vyc2lvbiBkZXB0aAo+Pj4+Pj4+IG9mIGV2ZW50
ZmRfc2lnbmFsKCkuIFRoaXMgY2FuIGF2b2lkIGRlYWRsb2NrIG9yIHN0YWNrIG92ZXJmbG93Lgo+
Pj4+Pj4+IEJ1dCBpbiBzdGFjayBvdmVyZmxvdyBjYXNlLCBpdCBzaG91bGQgYmUgT0sgdG8gaW5j
cmVhc2UgdGhlCj4+Pj4+Pj4gcmVjdXJzaW9uIGRlcHRoIGlmIG5lZWRlZC4gU28gd2UgYWRkIGEg
cGVyY3B1IGNvdW50ZXIgaW4gZXZlbnRmZF9jdHgKPj4+Pj4+PiB0byBsaW1pdCB0aGUgcmVjdXJz
aW9uIGRlcHRoIGZvciBkZWFkbG9jayBjYXNlLiBUaGVuIGl0IGNvdWxkIGJlCj4+Pj4+Pj4gZmlu
ZSB0byBpbmNyZWFzZSB0aGUgZ2xvYmFsIHBlcmNwdSBjb3VudGVyIGxhdGVyLgo+Pj4+Pj4gSSB3
b25kZXIgd2hldGhlciBvciBub3QgaXQncyB3b3J0aCB0byBpbnRyb2R1Y2UgcGVyY3B1IGZvciBl
YWNoIGV2ZW50ZmQuCj4+Pj4+Pgo+Pj4+Pj4gSG93IGFib3V0IHNpbXBseSBjaGVjayBpZiBldmVu
dGZkX3NpZ25hbF9jb3VudCgpIGlzIGdyZWF0ZXIgdGhhbiAyPwo+Pj4+Pj4KPj4+Pj4gSXQgY2Fu
J3QgYXZvaWQgZGVhZGxvY2sgaW4gdGhpcyB3YXkuCj4+Pj4gSSBtYXkgbWlzcyBzb21ldGhpbmcg
YnV0IHRoZSBjb3VudCBpcyB0byBhdm9pZCByZWN1cnNpdmUgZXZlbnRmZCBjYWxsLgo+Pj4+IFNv
IGZvciBWRFVTRSB3aGF0IHdlIHN1ZmZlcnMgaXMgZS5nIHRoZSBpbnRlcnJ1cHQgaW5qZWN0aW9u
IHBhdGg6Cj4+Pj4KPj4+PiB1c2Vyc3BhY2Ugd3JpdGUgSVJRRkQgLT4gdnEtPmNiKCkgLT4gYW5v
dGhlciBJUlFGRC4KPj4+Pgo+Pj4+IEl0IGxvb2tzIGxpa2UgaW5jcmVhc2luZyBFVkVOVEZEX1dB
S0VVUF9ERVBUSCBzaG91bGQgYmUgc3VmZmljaWVudD8KPj4+Pgo+Pj4gQWN0dWFsbHkgSSBtZWFu
IHRoZSBkZWFkbG9jayBkZXNjcmliZWQgaW4gY29tbWl0IGYwYjQ5M2UgKCJpb191cmluZzoKPj4+
IHByZXZlbnQgcG90ZW50aWFsIGV2ZW50ZmQgcmVjdXJzaW9uIG9uIHBvbGwiKS4gSXQgY2FuIGJy
ZWFrIHRoaXMgYnVnCj4+PiBmaXggaWYgd2UganVzdCBpbmNyZWFzZSBFVkVOVEZEX1dBS0VVUF9E
RVBUSC4KPj4KPj4gT2ssIHNvIGNhbiB3YWl0IGRvIHNvbWV0aGluZyBzaW1pbGFyIGluIHRoYXQg
Y29tbWl0PyAodXNpbmcgYXN5bmMgc3R1ZmZzCj4+IGxpa2Ugd3EpLgo+Pgo+IFdlIGNhbiBkbyB0
aGF0LiBCdXQgaXQgd2lsbCByZWR1Y2UgdGhlIHBlcmZvcm1hbmNlLiBCZWNhdXNlIHRoZQo+IGV2
ZW50ZmQgcmVjdXJzaW9uIHdpbGwgYmUgdHJpZ2dlcmVkIGV2ZXJ5IHRpbWUga3ZtIGtpY2sgZXZl
bnRmZCBpbgo+IHZob3N0LXZkcGEgY2FzZXM6Cj4KPiBLVk0gd3JpdGUgS0lDS0ZEIC0+IG9wcy0+
a2lja192cSAtPiBWRFVTRSB3cml0ZSBLSUNLRkQKPgo+IFRoYW5rcywKPiBZb25namkKCgpSaWdo
dCwgSSB0aGluayBpbiB0aGUgZnV0dXJlIHdlIG5lZWQgdG8gZmluZCBhIHdheSB0byBsZXQgS1ZN
IHRvIHdha2V1cCAKVkRVU0UgZGlyZWN0bHkuCgpIYXZuJ3QgaGFkIGEgZGVlcCB0aG91Z2h0IGJ1
dCBpdCBtaWdodCB3b3JrIGxpa2UgaXJxIGJ5cGFzcyBtYW5hZ2VyLgoKVGhhbmtzCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
