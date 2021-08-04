Return-Path: <SRS0=5nkl=M3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B6FC43214
	for <virtualization@archiver.kernel.org>; Wed,  4 Aug 2021 15:43:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D997D60F14
	for <virtualization@archiver.kernel.org>; Wed,  4 Aug 2021 15:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D997D60F14
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D11283CBD;
	Wed,  4 Aug 2021 15:43:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xr4Zl6UH7G5S; Wed,  4 Aug 2021 15:43:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1393483C88;
	Wed,  4 Aug 2021 15:43:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91BB2C000E;
	Wed,  4 Aug 2021 15:43:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52869C000E;
 Wed,  4 Aug 2021 15:43:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 41D3D83BEF;
 Wed,  4 Aug 2021 15:43:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9YMJHiWdQ9DE; Wed,  4 Aug 2021 15:43:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 06C6B83C88;
 Wed,  4 Aug 2021 15:43:53 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 191B531B;
 Wed,  4 Aug 2021 08:43:53 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D22B33F66F;
 Wed,  4 Aug 2021 08:43:48 -0700 (PDT)
Subject: Re: [PATCH v10 01/17] iova: Export alloc_iova_fast() and
 free_iova_fast()
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-2-xieyongji@bytedance.com>
 <43d88942-1cd3-c840-6fec-4155fd544d80@redhat.com>
 <CACycT3vcpwyA3xjD29f1hGnYALyAd=-XcWp8+wJiwSqpqUu00w@mail.gmail.com>
 <6e05e25e-e569-402e-d81b-8ac2cff1c0e8@arm.com>
 <CACycT3sm2r8NMMUPy1k1PuSZZ3nM9aic-O4AhdmRRCwgmwGj4Q@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <417ce5af-4deb-5319-78ce-b74fb4dd0582@arm.com>
Date: Wed, 4 Aug 2021 16:43:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CACycT3sm2r8NMMUPy1k1PuSZZ3nM9aic-O4AhdmRRCwgmwGj4Q@mail.gmail.com>
Content-Language: en-GB
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Liu Xiaodong <xiaodong.liu@intel.com>, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>,
 songmuchun@bytedance.com, Jens Axboe <axboe@kernel.dk>,
 He Zhe <zhe.he@windriver.com>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, netdev@vger.kernel.org, Joe Perches <joe@perches.com>,
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

T24gMjAyMS0wOC0wNCAwNjowMiwgWW9uZ2ppIFhpZSB3cm90ZToKPiBPbiBUdWUsIEF1ZyAzLCAy
MDIxIGF0IDY6NTQgUE0gUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4gd3JvdGU6
Cj4+Cj4+IE9uIDIwMjEtMDgtMDMgMDk6NTQsIFlvbmdqaSBYaWUgd3JvdGU6Cj4+PiBPbiBUdWUs
IEF1ZyAzLCAyMDIxIGF0IDM6NDEgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4g
d3JvdGU6Cj4+Pj4KPj4+Pgo+Pj4+IOWcqCAyMDIxLzcvMjkg5LiL5Y2IMzozNCwgWGllIFlvbmdq
aSDlhpnpgZM6Cj4+Pj4+IEV4cG9ydCBhbGxvY19pb3ZhX2Zhc3QoKSBhbmQgZnJlZV9pb3ZhX2Zh
c3QoKSBzbyB0aGF0Cj4+Pj4+IHNvbWUgbW9kdWxlcyBjYW4gdXNlIGl0IHRvIGltcHJvdmUgaW92
YSBhbGxvY2F0aW9uIGVmZmljaWVuY3kuCj4+Pj4KPj4+Pgo+Pj4+IEl0J3MgYmV0dGVyIHRvIGV4
cGxhaW4gd2h5IGFsbG9jX2lvdmEoKSBpcyBub3Qgc3VmZmljaWVudCBoZXJlLgo+Pj4+Cj4+Pgo+
Pj4gRmluZS4KPj4KPj4gV2hhdCBJIGZhaWwgdG8gdW5kZXJzdGFuZCBmcm9tIHRoZSBsYXRlciBw
YXRjaGVzIGlzIHdoYXQgdGhlIElPVkEgZG9tYWluCj4+IGFjdHVhbGx5IHJlcHJlc2VudHMuIElm
IHRoZSAiZGV2aWNlIiBpcyBhIHVzZXJzcGFjZSBwcm9jZXNzIHRoZW4KPj4gbG9naWNhbGx5IHRo
ZSAiSU9WQSIgd291bGQgYmUgdGhlIHVzZXJzcGFjZSBhZGRyZXNzLCBzbyBwcmVzdW1hYmx5Cj4+
IHNvbWV3aGVyZSB5b3UncmUgaGF2aW5nIHRvIHRyYW5zbGF0ZSBiZXR3ZWVuIHRoaXMgYXJiaXRy
YXJ5IGFkZHJlc3MKPj4gc3BhY2UgYW5kIGFjdHVhbCB1c2FibGUgYWRkcmVzc2VzIC0gaWYgeW91
J3JlIHdvcnJpZWQgYWJvdXQgZWZmaWNpZW5jeQo+PiBzdXJlbHkgaXQgd291bGQgYmUgZXZlbiBi
ZXR0ZXIgdG8gbm90IGRvIHRoYXQ/Cj4+Cj4gCj4gWWVzLCB1c2Vyc3BhY2UgZGFlbW9uIG5lZWRz
IHRvIHRyYW5zbGF0ZSB0aGUgIklPVkEiIGluIGEgRE1BCj4gZGVzY3JpcHRvciB0byB0aGUgVkEg
KGZyb20gbW1hcCgyKSkuIEJ1dCB0aGlzIGFjdHVhbGx5IGRvZXNuJ3QgYWZmZWN0Cj4gcGVyZm9y
bWFuY2Ugc2luY2UgaXQncyBhbiBpZGVudGljYWwgbWFwcGluZyBpbiBtb3N0IGNhc2VzLgoKSSdt
IG5vdCBmYW1pbGlhciB3aXRoIHRoZSB2aG9zdF9pb3RsYiBzdHVmZiwgYnV0IGl0IGxvb2tzIHN1
c3BpY2lvdXNseSAKbGlrZSB5b3UncmUgd2Fsa2luZyB5ZXQgYW5vdGhlciB0cmVlIHRvIG1ha2Ug
dGhvc2UgdHJhbnNsYXRpb25zLiBFdmVuIGlmIAp0aGUgYnVmZmVyIGNhbiBiZSBtYXBwZWQgYWxs
IGF0IG9uY2Ugd2l0aCBhIGZpeGVkIG9mZnNldCBzdWNoIHRoYXQgZWFjaCAKRE1BIG1hcHBpbmcg
Y2FsbCBkb2Vzbid0IG5lZWQgYSBsb29rdXAgZm9yIGVhY2ggaW5kaXZpZHVhbCAiSU9WQSIgLSB0
aGF0IAptaWdodCBiZSB3aGF0J3MgaGFwcGVuaW5nIGFscmVhZHksIGJ1dCBpdCdzIGEgYml0IGhh
cmQgdG8gZm9sbG93IGp1c3QgCnJlYWRpbmcgdGhlIHBhdGNoZXMgaW4gbXkgbWFpbCBjbGllbnQg
LSB2aG9zdF9pb3RsYl9hZGRfcmFuZ2UoKSBkb2Vzbid0IApsb29rIGxpa2UgaXQncyBzdXBlci1j
aGVhcCB0byBjYWxsLCBhbmQgeW91J3JlIHNlcmlhbGlzaW5nIG9uIGEgbG9jayBmb3IgCnRoYXQu
CgpNeSBtYWluIHBvaW50LCB0aG91Z2gsIGlzIHRoYXQgaWYgeW91J3ZlIGFscmVhZHkgZ290IHNv
bWV0aGluZyBlbHNlIAprZWVwaW5nIHRyYWNrIG9mIHRoZSBhY3R1YWwgYWRkcmVzc2VzLCB0aGVu
IHRoZSB3YXkgeW91J3JlIHVzaW5nIGFuIAppb3ZhX2RvbWFpbiBhcHBlYXJzIHRvIGJlIHNvbWV0
aGluZyB5b3UgY291bGQgZG8gd2l0aCBhIHRyaXZpYWwgYml0bWFwIAphbGxvY2F0b3IuIFRoYXQn
cyB3aHkgSSBkb24ndCBidXkgdGhlIGVmZmljaWVuY3kgYXJndW1lbnQuIFRoZSBtYWluIApkZXNp
Z24gcG9pbnRzIG9mIHRoZSBJT1ZBIGFsbG9jYXRvciBhcmUgdG8gbWFuYWdlIGxhcmdlIGFkZHJl
c3Mgc3BhY2VzIAp3aGlsZSB0cnlpbmcgdG8gbWF4aW1pc2Ugc3BhdGlhbCBsb2NhbGl0eSB0byBt
aW5pbWlzZSB0aGUgdW5kZXJseWluZyAKcGFnZXRhYmxlIHVzYWdlLCBhbmQgYWxsb2NhdGluZyB3
aXRoIGEgZmxleGlibGUgbGltaXQgdG8gc3VwcG9ydCAKbXVsdGlwbGUgZGV2aWNlcyB3aXRoIGRp
ZmZlcmVudCBhZGRyZXNzaW5nIGNhcGFiaWxpdGllcyBpbiB0aGUgc2FtZSAKYWRkcmVzcyBzcGFj
ZS4gSWYgbm9uZSBvZiB0aG9zZSBhc3BlY3RzIGFyZSByZWxldmFudCB0byB0aGUgdXNlLWNhc2Ug
LSAKd2hpY2ggQUZBSUNTIGFwcGVhcnMgdG8gYmUgdHJ1ZSBoZXJlIC0gdGhlbiBhcyBhIGdlbmVy
YWwtcHVycG9zZSAKcmVzb3VyY2UgYWxsb2NhdG9yIGl0J3MgcnViYmlzaCBhbmQgaGFzIGFuIHVu
cmVhc29uYWJseSBtYXNzaXZlIG1lbW9yeSAKb3ZlcmhlYWQgYW5kIHRoZXJlIGFyZSBtYW55LCBt
YW55IGJldHRlciBjaG9pY2VzLgoKRldJVyBJJ3ZlIHJlY2VudGx5IHN0YXJ0ZWQgdGhpbmtpbmcg
YWJvdXQgbW92aW5nIGFsbCB0aGUgY2FjaGluZyBzdHVmZiAKb3V0IG9mIGlvdmFfZG9tYWluIGFu
ZCBpbnRvIHRoZSBpb21tdS1kbWEgbGF5ZXIgc2luY2UgaXQncyBub3cgYSBnaWFudCAKd2FzdGUg
b2Ygc3BhY2UgZm9yIGFsbCB0aGUgb3RoZXIgY3VycmVudCBJT1ZBIHVzZXJzLgoKPj4gUHJlc3Vt
YWJseSB1c2Vyc3BhY2UgZG9lc24ndCBoYXZlIGFueSBjb25jZXJuIGFib3V0IGFsaWdubWVudCBh
bmQgdGhlCj4+IHRoaW5ncyB3ZSBoYXZlIHRvIHdvcnJ5IGFib3V0IGZvciB0aGUgRE1BIEFQSSBp
biBnZW5lcmFsLCBzbyBpdCdzIHByZXR0eQo+PiBtdWNoIGp1c3QgYWxsb2NhdGluZyBzbG90cyBp
biBhIGJ1ZmZlciwgYW5kIHRoZXJlIGFyZSBmYXIgbW9yZSBlZmZlY3RpdmUKPj4gd2F5cyB0byBk
byB0aGF0IHRoYW4gYSBmdWxsLWJsb3duIGFkZHJlc3Mgc3BhY2UgbWFuYWdlci4KPiAKPiBDb25z
aWRlcmluZyBpb3ZhIGFsbG9jYXRpb24gZWZmaWNpZW5jeSwgSSB0aGluayB0aGUgaW92YSBhbGxv
Y2F0b3IgaXMKPiBiZXR0ZXIgaGVyZS4gSW4gbW9zdCBjYXNlcywgd2UgZG9uJ3QgZXZlbiBuZWVk
IHRvIGhvbGQgYSBzcGluIGxvY2sKPiBkdXJpbmcgaW92YSBhbGxvY2F0aW9uLgo+IAo+PiBJZiB5
b3UncmUgZ29pbmcKPj4gdG8gcmV1c2UgYW55IGluZnJhc3RydWN0dXJlIEknZCBoYXZlIGV4cGVj
dGVkIGl0IHRvIGJlIFNXSU9UTEIgcmF0aGVyCj4+IHRoYW4gdGhlIElPVkEgYWxsb2NhdG9yLiBC
ZWNhdXNlLCB5J2tub3csIHlvdSdyZSAqbGl0ZXJhbGx5IGltcGxlbWVudGluZwo+PiBhIHNvZnR3
YXJlIEkvTyBUTEIqIDspCj4+Cj4gCj4gQnV0IGFjdHVhbGx5IHdoYXQgd2UgY2FuIHJldXNlIGlu
IFNXSU9UTEIgaXMgdGhlIElPVkEgYWxsb2NhdG9yLgoKSHVoPyBUaG9zZSBhcmUgY29tcGxldGVs
eSB1bnJlbGF0ZWQgYW5kIG9ydGhvZ29uYWwgdGhpbmdzIC0gU1dJT1RMQiBkb2VzIApub3QgdXNl
IGFuIGV4dGVybmFsIGFsbG9jYXRvciAoc2VlIGZpbmRfc2xvdHMoKSkuIEJ5IFNXSU9UTEIgSSBt
ZWFuIApzcGVjaWZpY2FsbHkgdGhlIGxpYnJhcnkgaXRzZWxmLCBub3QgZG1hLWRpcmVjdCBvciBh
bnkgb2YgdGhlIG90aGVyIAp1c2VycyBidWlsdCBhcm91bmQgaXQuIFRoZSBmdW5jdGlvbmFsaXR5
IGZvciBtYW5hZ2luZyBzbG90cyBpbiBhIGJ1ZmZlciAKYW5kIGJvdW5jaW5nIGRhdGEgaW4gYW5k
IG91dCBjYW4gYWJzb2x1dGVseSBiZSByZXVzZWQgLSB0aGF0J3Mgd2h5IHVzZXJzIApsaWtlIHRo
ZSBYZW4gYW5kIGlvbW11LWRtYSBjb2RlICphcmUqIHJldXNpbmcgaXQgaW5zdGVhZCBvZiBvcGVu
LWNvZGluZyAKdGhlaXIgb3duIHZlcnNpb25zLgoKPiBBbmQKPiB0aGUgSU9WQSBtYW5hZ2VtZW50
IGluIFNXSU9UTEIgaXMgbm90IHdoYXQgd2Ugd2FudC4gRm9yIGV4YW1wbGUsCj4gU1dJT1RMQiBh
bGxvY2F0ZXMgYW5kIHVzZXMgY29udGlndW91cyBtZW1vcnkgZm9yIGJvdW5jaW5nLCB3aGljaCBp
cwo+IG5vdCBuZWNlc3NhcnkgaW4gVkRVU0UgY2FzZS4KCmFsbG9jX2lvdmEoKSBhbGxvY2F0ZXMg
YSBjb250aWd1b3VzIChpbiBJT1ZBIGFkZHJlc3MpIHJlZ2lvbiBvZiBzcGFjZS4gCkluIHZkdXNl
X2RvbWFpbl9tYXBfcGFnZSgpIHlvdSB1c2UgaXQgdG8gYWxsb2NhdGUgYSBjb250aWd1b3VzIHJl
Z2lvbiBvZiAKc3BhY2UgZnJvbSB5b3VyIGJvdW5jZSBidWZmZXIuIENhbiB5b3UgY2xhcmlmeSBo
b3cgdGhhdCBpcyBmdW5kYW1lbnRhbGx5IApkaWZmZXJlbnQgZnJvbSBhbGxvY2F0aW5nIGEgY29u
dGlndW91cyByZWdpb24gb2Ygc3BhY2UgZnJvbSBhIGJvdW5jZSAKYnVmZmVyPyBOb2JvZHkncyBz
YXlpbmcgdGhlIHVuZGVybHlpbmcgaW1wbGVtZW50YXRpb24gZGV0YWlscyBvZiB3aGVyZSAKdGhl
IGJ1ZmZlciBpdHNlbGYgY29tZXMgZnJvbSBjYW4ndCBiZSB0d2Vha2VkLgoKPiBBbmQgVkRVU0Ug
bmVlZHMgY29oZXJlbnQgbWFwcGluZyB3aGljaCBpcwo+IG5vdCBzdXBwb3J0ZWQgYnkgdGhlIFNX
SU9UTEIuIEJlc2lkZXMsIHRoZSBTV0lPVExCIHdvcmtzIGluIHNpbmdsZXRvbgo+IG1vZGUgKGRl
c2lnbmVkIGZvciBwbGF0Zm9ybSBJT01NVSkgLCBidXQgVkRVU0UgaXMgYmFzZWQgb24gb24tY2hp
cAo+IElPTU1VIChzdXBwb3J0cyBtdWx0aXBsZSBpbnN0YW5jZXMpLgpUaGF0J3Mgbm90IGVudGly
ZWx5IHRydWUgLSB0aGUgSU9NTVUgYm91bmNlIGJ1ZmZlcmluZyBzY2hlbWUgaW50cm9kdWNlZCAK
aW4gaW50ZWwtaW9tbXUgYW5kIG5vdyBtb3ZlZCBpbnRvIHRoZSBpb21tdS1kbWEgbGF5ZXIgd2Fz
IGFscmVhZHkgYSBzdGVwIAp0b3dhcmRzIHNvbWV0aGluZyBjb25jZXB0dWFsbHkgc2ltaWxhci4g
SXQgZG9lcyBzdGlsbCByZWx5IG9uIHN0ZWFsaW5nIAp0aGUgdW5kZXJseWluZyBwYWdlcyBmcm9t
IHRoZSBnbG9iYWwgU1dJT1RMQiBwb29sIGF0IHRoZSBtb21lbnQsIGJ1dCB0aGUgCmJvdW5jaW5n
IGlzIGVmZmVjdGl2ZWx5IGRvbmUgaW4gYSBwZXItSU9NTVUtZG9tYWluIGNvbnRleHQuCgpUaGUg
bmV4dCBzdGVwIGlzIGN1cnJlbnRseSBxdWV1ZWQgaW4gbGludXgtbmV4dCwgd2hlcmVpbiB3ZSBj
YW4gbm93IGhhdmUgCmluZGl2aWR1YWwgcGVyLWRldmljZSBTV0lPVExCIHBvb2xzLiBJbiBmYWN0
IGF0IHRoYXQgcG9pbnQgSSB0aGluayB5b3UgCm1pZ2h0IGFjdHVhbGx5IGJlIGFibGUgdG8gZG8g
eW91ciB0aGluZyB3aXRob3V0IGltcGxlbWVudGluZyBhbnkgc3BlY2lhbCAKRE1BIG9wcyBhdCBh
bGwgLSB5b3UnZCBuZWVkIHRvIHNldCB1cCBhIHBvb2wgZm9yIHlvdXIgImRldmljZSIgd2l0aCAK
Zm9yY2VfYm91bmNlIHNldCwgdGhlbiB3aGVuIHlvdSBtbWFwKCkgdGhhdCB0byB1c2Vyc3BhY2Us
IHNldCB1cCAKZGV2LT5kbWFfcmFuZ2VfbWFwIHRvIGRlc2NyaWJlIGFuIG9mZnNldCBmcm9tIHRo
ZSBwaHlzaWNhbCBhZGRyZXNzIG9mIAp0aGUgYnVmZmVyIHRvIHRoZSB1c2Vyc3BhY2UgYWRkcmVz
cywgYW5kIEkgdGhpbmsgZG1hLWRpcmVjdCB3b3VsZCBiZSAKdHJpY2tlZCBpbnRvIGRvaW5nIHRo
ZSByaWdodCB0aGluZy4gSXQncyBhIGJpdCB3YWNreSwgYnV0IGl0IGNvdWxkIHN0YW5kIAp0byBz
YXZlIGEgaGVsbCBvZiBhIGxvdCBvZiBib3RoZXIuCgpGaW5hbGx5LCBlbmhhbmNpbmcgU1dJT1RM
QiB0byBjb3BlIHdpdGggdmlydHVhbGx5LW1hcHBlZCBidWZmZXJzIHRoYXQgCmRvbid0IGhhdmUg
dG8gYmUgcGh5c2ljYWxseSBjb250aWd1b3VzIGlzIGEgZnV0dXJlIGltcHJvdmVtZW50IHdoaWNo
IEkgCnRoaW5rIGNvdWxkIGJlbmVmaXQgdmFyaW91cyB1c2UtY2FzZXMgLSBpbmRlZWQgaXQncyBw
b3NzaWJseSBhbHJlYWR5IG9uIAp0aGUgdGFibGUgZm9yIElPTU1VIGJvdW5jZSBwYWdlcyAtIHNv
IHdvdWxkIHByb2JhYmx5IGJlIHdlbGNvbWUgaW4gZ2VuZXJhbC4KCiA+IFNvIEkgc3RpbGwgcHJl
ZmVyIHRvIHJldXNlIHRoZQogPiBJT1ZBIGFsbG9jYXRvciB0byBpbXBsZW1lbnQgYSBNTVUtYmFz
ZWQgc29mdHdhcmUgSU9UTEIuCgpJZiB5b3UncmUgZGVhZCBzZXQgb24gb3Blbi1jb2RpbmcgYWxs
IHRoZSBib3VuY2UtYnVmZmVyaW5nIG1hY2hpbmVyeSwgCnRoZW4gSSdkIGhvbmVzdGx5IHJlY29t
bWVuZCBvcGVuLWNvZGluZyBhIG1vcmUgc3VpdGFibGUgYnVmZmVyIGFsbG9jYXRvciAKYXMgd2Vs
bCA7KQoKVGhhbmtzLApSb2Jpbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
