Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7A5C678D4
	for <virtualization@archiver.kernel.org>; Thu,  2 Mar 2023 16:55:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1CEE5612C6;
	Thu,  2 Mar 2023 16:55:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1CEE5612C6
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=R6yGvig9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vlo9cYH3U91g; Thu,  2 Mar 2023 16:55:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 49573612AD;
	Thu,  2 Mar 2023 16:55:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 49573612AD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29846C0071;
	Thu,  2 Mar 2023 16:55:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5EB6EC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 16:55:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4607B820C8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 16:55:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4607B820C8
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=casper.20170209 header.b=R6yGvig9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gtKreRiHYyOE
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 16:55:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C6E45820BB
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C6E45820BB
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 16:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=AUBDDw7Nqbnm0w1FvorVxn1rzYs+CIAdfSAqMk4EzQ4=; b=R6yGvig9Ts9hZ9YwIX7jE+KDXP
 t31zY8KiwuOsRoiwpeGfE+OrMOFm4gTOnw4nyKd6TM3bSAhrlb1PLEjRa00eW8Kf1wdRRpZ8NQkhk
 a7rdnzajEhXBPW6gLQxVymspP49NBrj2KAVp5JPdx40sKNzrVmVNyUNDhTq1qi24PgcGc2iLUhkD8
 d5LRLYrUUx9JoX7ha8djnfD4E0CnW4f9f+hG4otHypje/2R55Oa4NlVa12HbSq2DZVdDXNK1U9sRB
 slhEZ8ACbxzjqLBPTT6w2i7xP56Pep5DYBsgQHZVPtgM82CQPCzpES7klG728dqqGq2vOYuwWEahF
 scVLpqEQ==;
Received: from [54.239.6.186] (helo=[192.168.10.135])
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1pXmDE-002WtU-Us; Thu, 02 Mar 2023 16:55:25 +0000
Message-ID: <65d872db2e1be29bb03b43ed606e7cc9e74ec08d.camel@infradead.org>
Subject: Re: [PATCH v2 0/2] [RFC] virtio-rng entropy leak reporting feature
From: Amit Shah <amit@infradead.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, Babis Chalios <bchalios@amazon.es>
Date: Thu, 02 Mar 2023 17:55:23 +0100
In-Reply-To: <Y9lBeymca9eFaJ33@zx2c4.com>
References: <20230131145543.86369-1-bchalios@amazon.es>
 <Y9lBeymca9eFaJ33@zx2c4.com>
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
Cc: graf@amazon.de, Herbert Xu <herbert@gondor.apana.org.au>,
 "Michael S. Tsirkin" <mst@redhat.com>, amit@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-crypto@vger.kernel.org, Olivia Mackall <olivia@selenic.com>,
 xmarcalx@amazon.co.uk
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

SGV5wqBhbGwsCgpPbiBUdWUsIDIwMjMtMDEtMzEgYXQgMTc6MjcgKzAxMDAsIEphc29uIEEuIERv
bmVuZmVsZCB3cm90ZToKPiBZb3Ugc2VudCBhIHYyLCBidXQgSSdtIG5vdCBiYWNrIHVudGlsIHRo
ZSAxMXRoIHRvIHByb3ZpZGUgY29tbWVudHMgb24KPiB2MS4gSSBzdGlsbCB0aGluayB0aGlzIGlz
bid0IHRoZSByaWdodCBkaXJlY3Rpb24sIGFzIHRoaXMgbmVlZHMgdGllLWlucwo+IHRvIHRoZSBy
bmcgdG8gYWN0dWFsbHkgYmUgdXNlZnVsLiBQbGVhc2Ugc3RvcCBwb3N0aW5nIG5ldyB2ZXJzaW9u
cyBvZgo+IHRoaXMgZm9yIG5vdywgc28gdGhhdCBzb21lYm9keSBkb2Vzbid0IGFjY2lkZW50YWxs
eSBtZXJnZSBpdDsgdGhhdCdkIGJlCj4gYSBiaWcgbWlzdGFrZS4gSSdsbCBwYXN0ZSB3aGF0IEkg
d3JvdGUgeW91IHByaW9yOgoKSSBzYXQgZG93biB0byByZXZpZXcgdGhlIHBhdGNoc2V0IGJ1dCBs
b29rcyBsaWtlIHRoZXJlJ3Mgc29tZQpiYWNrZ3JvdW5kIEknbSBub3QgYXdhcmUgb2YuCgpJdCBs
b29rcyBsaWtlIEJhYmlzIGhhcyBpbXBsZW1lbnRlZCB0aGUgZ3Vlc3Qgc2lkZSBoZXJlIGFjY29y
ZGluZyB0bwp0aGUgc3BlYyBjaGFuZ2UgdGhhdCBNaWNoYWVsIGhhcyBwb3N0ZWQuCgpKYXNvbiwg
ZG8geW91IGhhdmUgYW4gYWx0ZXJuYXRpdmUgaW4gbWluZD8gIEluIHRoYXQgY2FzZSwgd2Ugc2hv
dWxkCnBpY2sgdGhpcyB1cCBpbiB0aGUgc3BlYyB1cGRhdGUgdGhyZWFkIGluc3RlYWQuCgpTb21l
aG93IGl0IGZlZWxzIGxpa2UgSSBkb24ndCBoYXZlIHRoZSBjb21wbGV0ZSBzdG9yeSBmb3IgdGhp
cyBmZWF0dXJlCnNldCwgaGF2aW5nIG1pc3NlZCB0aGUgZGlzY3Vzc2lvbiBkdXJpbmcgTFBDLgoK
CUFtaXQKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
