Return-Path: <SRS0=yluT=M2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C80C4320A
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 10:54:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3694660FC2
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 10:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3694660FC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3B6C14019B;
	Tue,  3 Aug 2021 10:54:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PYP-6kIdARk3; Tue,  3 Aug 2021 10:54:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9544440219;
	Tue,  3 Aug 2021 10:54:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1CB12C0020;
	Tue,  3 Aug 2021 10:54:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A449C000E;
 Tue,  3 Aug 2021 10:54:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EBABD81DCA;
 Tue,  3 Aug 2021 10:54:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SUnKzj3FMNbG; Tue,  3 Aug 2021 10:54:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1DF2F81D67;
 Tue,  3 Aug 2021 10:54:26 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 237041396;
 Tue,  3 Aug 2021 03:54:26 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 805143F40C;
 Tue,  3 Aug 2021 03:54:22 -0700 (PDT)
Subject: Re: [PATCH v10 01/17] iova: Export alloc_iova_fast() and
 free_iova_fast()
To: Yongji Xie <xieyongji@bytedance.com>, Jason Wang <jasowang@redhat.com>
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-2-xieyongji@bytedance.com>
 <43d88942-1cd3-c840-6fec-4155fd544d80@redhat.com>
 <CACycT3vcpwyA3xjD29f1hGnYALyAd=-XcWp8+wJiwSqpqUu00w@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <6e05e25e-e569-402e-d81b-8ac2cff1c0e8@arm.com>
Date: Tue, 3 Aug 2021 11:53:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CACycT3vcpwyA3xjD29f1hGnYALyAd=-XcWp8+wJiwSqpqUu00w@mail.gmail.com>
Content-Language: en-GB
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Liu Xiaodong <xiaodong.liu@intel.com>, Joe Perches <joe@perches.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>,
 songmuchun@bytedance.com, Jens Axboe <axboe@kernel.dk>,
 He Zhe <zhe.he@windriver.com>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
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

T24gMjAyMS0wOC0wMyAwOTo1NCwgWW9uZ2ppIFhpZSB3cm90ZToKPiBPbiBUdWUsIEF1ZyAzLCAy
MDIxIGF0IDM6NDEgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+
Cj4+Cj4+IOWcqCAyMDIxLzcvMjkg5LiL5Y2IMzozNCwgWGllIFlvbmdqaSDlhpnpgZM6Cj4+PiBF
eHBvcnQgYWxsb2NfaW92YV9mYXN0KCkgYW5kIGZyZWVfaW92YV9mYXN0KCkgc28gdGhhdAo+Pj4g
c29tZSBtb2R1bGVzIGNhbiB1c2UgaXQgdG8gaW1wcm92ZSBpb3ZhIGFsbG9jYXRpb24gZWZmaWNp
ZW5jeS4KPj4KPj4KPj4gSXQncyBiZXR0ZXIgdG8gZXhwbGFpbiB3aHkgYWxsb2NfaW92YSgpIGlz
IG5vdCBzdWZmaWNpZW50IGhlcmUuCj4+Cj4gCj4gRmluZS4KCldoYXQgSSBmYWlsIHRvIHVuZGVy
c3RhbmQgZnJvbSB0aGUgbGF0ZXIgcGF0Y2hlcyBpcyB3aGF0IHRoZSBJT1ZBIGRvbWFpbiAKYWN0
dWFsbHkgcmVwcmVzZW50cy4gSWYgdGhlICJkZXZpY2UiIGlzIGEgdXNlcnNwYWNlIHByb2Nlc3Mg
dGhlbiAKbG9naWNhbGx5IHRoZSAiSU9WQSIgd291bGQgYmUgdGhlIHVzZXJzcGFjZSBhZGRyZXNz
LCBzbyBwcmVzdW1hYmx5IApzb21ld2hlcmUgeW91J3JlIGhhdmluZyB0byB0cmFuc2xhdGUgYmV0
d2VlbiB0aGlzIGFyYml0cmFyeSBhZGRyZXNzIApzcGFjZSBhbmQgYWN0dWFsIHVzYWJsZSBhZGRy
ZXNzZXMgLSBpZiB5b3UncmUgd29ycmllZCBhYm91dCBlZmZpY2llbmN5IApzdXJlbHkgaXQgd291
bGQgYmUgZXZlbiBiZXR0ZXIgdG8gbm90IGRvIHRoYXQ/CgpQcmVzdW1hYmx5IHVzZXJzcGFjZSBk
b2Vzbid0IGhhdmUgYW55IGNvbmNlcm4gYWJvdXQgYWxpZ25tZW50IGFuZCB0aGUgCnRoaW5ncyB3
ZSBoYXZlIHRvIHdvcnJ5IGFib3V0IGZvciB0aGUgRE1BIEFQSSBpbiBnZW5lcmFsLCBzbyBpdCdz
IHByZXR0eSAKbXVjaCBqdXN0IGFsbG9jYXRpbmcgc2xvdHMgaW4gYSBidWZmZXIsIGFuZCB0aGVy
ZSBhcmUgZmFyIG1vcmUgZWZmZWN0aXZlIAp3YXlzIHRvIGRvIHRoYXQgdGhhbiBhIGZ1bGwtYmxv
d24gYWRkcmVzcyBzcGFjZSBtYW5hZ2VyLiBJZiB5b3UncmUgZ29pbmcgCnRvIHJldXNlIGFueSBp
bmZyYXN0cnVjdHVyZSBJJ2QgaGF2ZSBleHBlY3RlZCBpdCB0byBiZSBTV0lPVExCIHJhdGhlciAK
dGhhbiB0aGUgSU9WQSBhbGxvY2F0b3IuIEJlY2F1c2UsIHkna25vdywgeW91J3JlICpsaXRlcmFs
bHkgaW1wbGVtZW50aW5nIAphIHNvZnR3YXJlIEkvTyBUTEIqIDspCgpSb2Jpbi4KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
