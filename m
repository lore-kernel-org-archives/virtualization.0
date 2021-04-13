Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CC0C43461
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 03:35:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70AF0613A9
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 03:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70AF0613A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2582B60B7A;
	Tue, 13 Apr 2021 03:35:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Azn3T2LDe9jW; Tue, 13 Apr 2021 03:35:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id F06BB60B75;
	Tue, 13 Apr 2021 03:35:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D18C6C000C;
	Tue, 13 Apr 2021 03:35:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91585C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 03:35:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 777B940562
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 03:35:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HGasaz_ME3BR
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 03:35:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E20FD400C1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 03:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618284919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FrQIYAVK8VmlMqiK14ZxNTeIpIVDPpOHzlb01A1fM1I=;
 b=M7V+8cEAPeJdnUd3KStz3/TGskkLD3FXnT17TNEO3iyHUctL/IukRVmZ2gYQV9IDo7tBYh
 h81JYpvr2XDWlyQ9XC4sOh5eJ6Fc9kOsZE3rSy/fQhTuZ8ZzRJxr4Rqm06aMiMHZR3MI93
 Xquq/L+hcVa50rMLB3ATxpZTbkb/TGs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-Y3jfzZ-mOiCDL_3yhayrxg-1; Mon, 12 Apr 2021 23:35:18 -0400
X-MC-Unique: Y3jfzZ-mOiCDL_3yhayrxg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E156A107ACE6;
 Tue, 13 Apr 2021 03:35:15 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-128.pek2.redhat.com
 [10.72.13.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B514F19D61;
 Tue, 13 Apr 2021 03:35:01 +0000 (UTC)
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
 <0f386dfe-45c9-5609-55f7-b8ab2a4abf5e@redhat.com>
 <CACycT3vbDhUKM0OX-zo02go09gh2+EEdyZ_YQuz8PXzo3EngXw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a85c0a66-ad7f-a344-f8ed-363355f5e283@redhat.com>
Date: Tue, 13 Apr 2021 11:35:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CACycT3vbDhUKM0OX-zo02go09gh2+EEdyZ_YQuz8PXzo3EngXw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

CuWcqCAyMDIxLzQvMTIg5LiL5Y2INTo1OSwgWW9uZ2ppIFhpZSDlhpnpgZM6Cj4gT24gTW9uLCBB
cHIgMTIsIDIwMjEgYXQgNTozNyBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3
cm90ZToKPj4KPj4g5ZyoIDIwMjEvNC8xMiDkuIvljYg0OjAyLCBZb25namkgWGllIOWGmemBkzoK
Pj4+IE9uIE1vbiwgQXByIDEyLCAyMDIxIGF0IDM6MTYgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4g5ZyoIDIwMjEvNC85IOS4i+WNiDQ6MDIsIFlvbmdqaSBY
aWUg5YaZ6YGTOgo+Pj4+Pj4+Pj4gK307Cj4+Pj4+Pj4+PiArCj4+Pj4+Pj4+PiArc3RydWN0IHZk
dXNlX2Rldl9jb25maWdfZGF0YSB7Cj4+Pj4+Pj4+PiArICAgICBfX3UzMiBvZmZzZXQ7IC8qIG9m
ZnNldCBmcm9tIHRoZSBiZWdpbm5pbmcgb2YgY29uZmlnIHNwYWNlICovCj4+Pj4+Pj4+PiArICAg
ICBfX3UzMiBsZW47IC8qIHRoZSBsZW5ndGggdG8gcmVhZC93cml0ZSAqLwo+Pj4+Pj4+Pj4gKyAg
ICAgX191OCBkYXRhW1ZEVVNFX0NPTkZJR19EQVRBX0xFTl07IC8qIGRhdGEgYnVmZmVyIHVzZWQg
dG8gcmVhZC93cml0ZSAqLwo+Pj4+Pj4+PiBOb3RlIHRoYXQgc2luY2UgVkRVU0VfQ09ORklHX0RB
VEFfTEVOIGlzIHBhcnQgb2YgdUFQSSBpdCBtZWFucyB3ZSBjYW4KPj4+Pj4+Pj4gbm90IGNoYW5n
ZSBpdCBpbiB0aGUgZnV0dXJlLgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBTbyB0aGlzIG1pZ2h0IHN1ZmZj
aWVudCBmb3IgZnV0dXJlIGZlYXR1cmVzIG9yIGFsbCB0eXBlIG9mIHZpcnRpbyBkZXZpY2VzLgo+
Pj4+Pj4+Pgo+Pj4+Pj4+IERvIHlvdSBtZWFuIDI1NiBpcyBubyBlbm91Z2ggaGVyZe+8nwo+Pj4+
Pj4gWWVzLgo+Pj4+Pj4KPj4+Pj4gQnV0IHRoaXMgcmVxdWVzdCB3aWxsIGJlIHN1Ym1pdHRlZCBt
dWx0aXBsZSB0aW1lcyBpZiBjb25maWcgbGVuZ2ggaXMKPj4+Pj4gbGFyZ2VyIHRoYW4gMjU2LiBT
byBkbyB5b3UgdGhpbmsgd2hldGhlciB3ZSBuZWVkIHRvIGV4dGVudCB0aGUgc2l6ZSB0bwo+Pj4+
PiA1MTIgb3IgbGFyZ2VyPwo+Pj4+IFNvIEkgdGhpbmsgeW91J2QgYmV0dGVyIGVpdGhlcjoKPj4+
Pgo+Pj4+IDEpIGRvY3VtZW50IHRoZSBsaW1pdGF0aW9uICgyNTYpIGluIHNvbWV3aGVyZSwgKGJl
dHRlciBib3RoIHVhcGkgYW5kIGRvYykKPj4+Pgo+Pj4gQnV0IHRoZSBWRFVTRV9DT05GSUdfREFU
QV9MRU4gZG9lc24ndCBtZWFuIHRoZSBsaW1pdGF0aW9uIG9mCj4+PiBjb25maWd1cmF0aW9uIHNw
YWNlLiBJdCBvbmx5IG1lYW5zIHRoZSBtYXhpbXVtIHNpemUgb2Ygb25lIGRhdGEKPj4+IHRyYW5z
ZmVyIGZvciBjb25maWd1cmF0aW9uIHNwYWNlLiBEbyB5b3UgbWVhbiBkb2N1bWVudCB0aGlzPwo+
Pgo+PiBZZXMsIGFuZCBhbm90aGVyIHRoaW5nIGlzIHRoYXQgc2luY2UgeW91J3JlIHVzaW5nCj4+
IGRhdGFbVkRVU0VfQ09ORklHX0RBVEFfTEVOXSBpbiB0aGUgdWFwaSwgaXQgaW1wbGllcyB0aGUg
bGVuZ3RoIGlzIGFsd2F5cwo+PiAyNTYgd2hpY2ggc2VlbXMgbm90IGdvb2QgYW5kIG5vdCB3aGF0
IHRoZSBjb2RlIGlzIHdyb3RlLgo+Pgo+IEhvdyBhYm91dCByZW5hbWluZyBWRFVTRV9DT05GSUdf
REFUQV9MRU4gdG8gVkRVU0VfTUFYX1RSQU5TRkVSX0xFTj8KPgo+IFRoYW5rcywKPiBZb25namkK
CgpTbyBhIHF1ZXN0aW9uIGlzIHRoZSByZWFzb24gdG8gaGF2ZSBhIGxpbWl0YXRpb24gb2YgdGhp
cyBpbiB0aGUgdUFQST8gCk5vdGUgdGhhdCBpbiB2aG9zdC12ZHBhIHdlIGRvbid0IGhhdmUgc3Vj
aDoKCnN0cnVjdCB2aG9zdF92ZHBhX2NvbmZpZyB7CiDCoMKgwqDCoMKgwqDCoCBfX3UzMiBvZmY7
CiDCoMKgwqDCoMKgwqDCoCBfX3UzMiBsZW47CiDCoMKgwqDCoMKgwqDCoCBfX3U4IGJ1ZlswXTsK
fTsKClRoYW5rcwoKCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
