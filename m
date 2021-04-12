Return-Path: <SRS0=TAdK=JJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55635C433ED
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 09:37:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB81F61221
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 09:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB81F61221
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 97D32403D7;
	Mon, 12 Apr 2021 09:37:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VaPCLdtVMWa1; Mon, 12 Apr 2021 09:37:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A7FC4038D;
	Mon, 12 Apr 2021 09:37:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF37CC000C;
	Mon, 12 Apr 2021 09:37:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67BA7C000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 09:37:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4817683716
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 09:37:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T5yYyPpAhzjR
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 09:37:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7464883709
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 09:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618220268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wmf9ZGvB5vcgO4CtC2CcyvvFrlcqG76wOFO2zMFyTks=;
 b=hiEPPI1+P2paf0QP41aEDqqVCt0+wm4ogsCvzDXrso6qbDjKJZIYgA+2Tka9FOwVBZcFtQ
 Z3+sNS/i7YOmroyfE5frtLpFgm2Ntan1YF52rdiskZndwXDokOA5NQRuD0kob/fRroGaBN
 MXlOQ239Gnyy4IfGTB0JYxGqcf8bg60=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-78krYvl8MyOKYKMjDvetRQ-1; Mon, 12 Apr 2021 05:37:44 -0400
X-MC-Unique: 78krYvl8MyOKYKMjDvetRQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4287083DD20;
 Mon, 12 Apr 2021 09:37:42 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-232.pek2.redhat.com
 [10.72.13.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 687B25D9DE;
 Mon, 12 Apr 2021 09:37:28 +0000 (UTC)
Subject: Re: [PATCH v6 09/10] vduse: Introduce VDUSE - vDPA Device in Userspace
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210331080519.172-1-xieyongji@bytedance.com>
 <20210331080519.172-10-xieyongji@bytedance.com>
 <c817178a-2ac8-bf93-1ed3-528579c657a3@redhat.com>
 <CACycT3v_KFQXoxRbEj8c0Ve6iKn9RbibtBDgBFs=rf0ZOmTBBQ@mail.gmail.com>
 <091dde74-449b-385c-0ec9-11e4847c6c4c@redhat.com>
 <CACycT3vwATp4+Ao0fjuyeeLQN+xHH=dXF+JUyuitkn4k8hELnA@mail.gmail.com>
 <dc9a90dd-4f86-988c-c1b5-ac606ce5e14b@redhat.com>
 <CACycT3vxO21Yt6+px2c2Q8DONNUNehdo2Vez_RKQCKe76CM2TA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0f386dfe-45c9-5609-55f7-b8ab2a4abf5e@redhat.com>
Date: Mon, 12 Apr 2021 17:37:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CACycT3vxO21Yt6+px2c2Q8DONNUNehdo2Vez_RKQCKe76CM2TA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>,
 Christian Brauner <christian.brauner@canonical.com>, bcrl@kvack.org,
 viro@zeniv.linux.org.uk, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
 =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
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

CuWcqCAyMDIxLzQvMTIg5LiL5Y2INDowMiwgWW9uZ2ppIFhpZSDlhpnpgZM6Cj4gT24gTW9uLCBB
cHIgMTIsIDIwMjEgYXQgMzoxNiBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3
cm90ZToKPj4KPj4g5ZyoIDIwMjEvNC85IOS4i+WNiDQ6MDIsIFlvbmdqaSBYaWUg5YaZ6YGTOgo+
Pj4+Pj4+ICt9Owo+Pj4+Pj4+ICsKPj4+Pj4+PiArc3RydWN0IHZkdXNlX2Rldl9jb25maWdfZGF0
YSB7Cj4+Pj4+Pj4gKyAgICAgX191MzIgb2Zmc2V0OyAvKiBvZmZzZXQgZnJvbSB0aGUgYmVnaW5u
aW5nIG9mIGNvbmZpZyBzcGFjZSAqLwo+Pj4+Pj4+ICsgICAgIF9fdTMyIGxlbjsgLyogdGhlIGxl
bmd0aCB0byByZWFkL3dyaXRlICovCj4+Pj4+Pj4gKyAgICAgX191OCBkYXRhW1ZEVVNFX0NPTkZJ
R19EQVRBX0xFTl07IC8qIGRhdGEgYnVmZmVyIHVzZWQgdG8gcmVhZC93cml0ZSAqLwo+Pj4+Pj4g
Tm90ZSB0aGF0IHNpbmNlIFZEVVNFX0NPTkZJR19EQVRBX0xFTiBpcyBwYXJ0IG9mIHVBUEkgaXQg
bWVhbnMgd2UgY2FuCj4+Pj4+PiBub3QgY2hhbmdlIGl0IGluIHRoZSBmdXR1cmUuCj4+Pj4+Pgo+
Pj4+Pj4gU28gdGhpcyBtaWdodCBzdWZmY2llbnQgZm9yIGZ1dHVyZSBmZWF0dXJlcyBvciBhbGwg
dHlwZSBvZiB2aXJ0aW8gZGV2aWNlcy4KPj4+Pj4+Cj4+Pj4+IERvIHlvdSBtZWFuIDI1NiBpcyBu
byBlbm91Z2ggaGVyZe+8nwo+Pj4+IFllcy4KPj4+Pgo+Pj4gQnV0IHRoaXMgcmVxdWVzdCB3aWxs
IGJlIHN1Ym1pdHRlZCBtdWx0aXBsZSB0aW1lcyBpZiBjb25maWcgbGVuZ2ggaXMKPj4+IGxhcmdl
ciB0aGFuIDI1Ni4gU28gZG8geW91IHRoaW5rIHdoZXRoZXIgd2UgbmVlZCB0byBleHRlbnQgdGhl
IHNpemUgdG8KPj4+IDUxMiBvciBsYXJnZXI/Cj4+Cj4+IFNvIEkgdGhpbmsgeW91J2QgYmV0dGVy
IGVpdGhlcjoKPj4KPj4gMSkgZG9jdW1lbnQgdGhlIGxpbWl0YXRpb24gKDI1NikgaW4gc29tZXdo
ZXJlLCAoYmV0dGVyIGJvdGggdWFwaSBhbmQgZG9jKQo+Pgo+IEJ1dCB0aGUgVkRVU0VfQ09ORklH
X0RBVEFfTEVOIGRvZXNuJ3QgbWVhbiB0aGUgbGltaXRhdGlvbiBvZgo+IGNvbmZpZ3VyYXRpb24g
c3BhY2UuIEl0IG9ubHkgbWVhbnMgdGhlIG1heGltdW0gc2l6ZSBvZiBvbmUgZGF0YQo+IHRyYW5z
ZmVyIGZvciBjb25maWd1cmF0aW9uIHNwYWNlLiBEbyB5b3UgbWVhbiBkb2N1bWVudCB0aGlzPwoK
ClllcywgYW5kIGFub3RoZXIgdGhpbmcgaXMgdGhhdCBzaW5jZSB5b3UncmUgdXNpbmcgCmRhdGFb
VkRVU0VfQ09ORklHX0RBVEFfTEVOXSBpbiB0aGUgdWFwaSwgaXQgaW1wbGllcyB0aGUgbGVuZ3Ro
IGlzIGFsd2F5cyAKMjU2IHdoaWNoIHNlZW1zIG5vdCBnb29kIGFuZCBub3Qgd2hhdCB0aGUgY29k
ZSBpcyB3cm90ZS4KClRoYW5rcwoKCj4KPiBUaGFua3MsCj4gWW9uZ2ppCj4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
