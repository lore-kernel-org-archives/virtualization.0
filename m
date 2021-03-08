Return-Path: <SRS0=agY8=IG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B54C433DB
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 03:17:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CDF46514A
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 03:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CDF46514A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12DBB4DD86;
	Mon,  8 Mar 2021 03:17:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qMC_UPDcRSzF; Mon,  8 Mar 2021 03:17:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 447AF4DCCE;
	Mon,  8 Mar 2021 03:17:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D846C000B;
	Mon,  8 Mar 2021 03:17:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54358C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 03:17:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2D6C5430D8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 03:17:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K3cx5nazNFUJ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 03:17:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6486E42C2B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 03:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615173450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lncFpbesf3+Cf0X7NC13aXAoRjJq1HSTiKB3om5hTS8=;
 b=Xt81nN/sfq0ceLpPB6nZcNLvKPJf12djR7VbPt/Bjm8q+yXatEg3bsjTSIPgNRyD9D6RgZ
 9uGBBK4sikHNhNXO6hT9673gDUKj+Rs8gS6L08oPVMUMfRpHZTwkML+4BqiND5Mi6aaEMM
 23HrFsMyRaU0d3gmTi27B+m1n+yDK8E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-LK-aPUdXMEO8cZ6cb1sLtg-1; Sun, 07 Mar 2021 22:17:26 -0500
X-MC-Unique: LK-aPUdXMEO8cZ6cb1sLtg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B80857;
 Mon,  8 Mar 2021 03:17:24 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-193.pek2.redhat.com
 [10.72.13.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 719CA5C5FC;
 Mon,  8 Mar 2021 03:17:10 +0000 (UTC)
Subject: Re: [RFC v4 06/11] vduse: Implement an MMU-based IOMMU driver
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210223115048.435-1-xieyongji@bytedance.com>
 <20210223115048.435-7-xieyongji@bytedance.com>
 <573ab913-55ce-045a-478f-1200bd78cf7b@redhat.com>
 <CACycT3sVhDKKu4zGbt1Lw-uWfKDAWs=O=C7kXXcuSnePohmBdQ@mail.gmail.com>
 <c173b7ec-8c90-d0e3-7272-a56aa8935e64@redhat.com>
 <CACycT3vb=WyrMpiOOdVDGEh8cEDb-xaj1esQx2UEQpJnOOWhmw@mail.gmail.com>
 <4db35f8c-ee3a-90fb-8d14-5d6014b4f6fa@redhat.com>
 <CACycT3sUJNmi2BdLsi3W72+qTKQaCo_nQYu-fdxg9y4pAvBMow@mail.gmail.com>
 <2652f696-faf7-26eb-a8b2-c4cfe3aaed15@redhat.com>
 <CACycT3uMV9wg5yVKmEJpbZrs3x0b4+b9eNcUTh3+CjxsG7x2LA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d4681614-bd1e-8fe7-3b03-72eb2011c3c2@redhat.com>
Date: Mon, 8 Mar 2021 11:17:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CACycT3uMV9wg5yVKmEJpbZrs3x0b4+b9eNcUTh3+CjxsG7x2LA@mail.gmail.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

Ck9uIDIwMjEvMy81IDM6NTkg5LiL5Y2ILCBZb25namkgWGllIHdyb3RlOgo+IE9uIEZyaSwgTWFy
IDUsIDIwMjEgYXQgMzoyNyBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90
ZToKPj4KPj4gT24gMjAyMS8zLzUgMzoxMyDkuIvljYgsIFlvbmdqaSBYaWUgd3JvdGU6Cj4+PiBP
biBGcmksIE1hciA1LCAyMDIxIGF0IDI6NTIgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4+Pj4gT24gMjAyMS8zLzUgMjoxNSDkuIvljYgsIFlvbmdqaSBYaWUgd3Jv
dGU6Cj4+Pj4KPj4+PiBTb3JyeSBpZiBJJ3ZlIGFza2VkIHRoaXMgYmVmb3JlLgo+Pj4+Cj4+Pj4g
QnV0IHdoYXQncyB0aGUgcmVhc29uIGZvciBtYWludGFpbmcgYSBkZWRpY2F0ZWQgSU9UTEIgaGVy
ZT8gSSB0aGluayB3ZQo+Pj4+IGNvdWxkIHJldXNlIHZkdXNlX2Rldi0+aW9tbXUgc2luY2UgdGhl
IGRldmljZSBjYW4gbm90IGJlIHVzZWQgYnkgYm90aAo+Pj4+IHZpcnRpbyBhbmQgdmhvc3QgaW4g
dGhlIHNhbWUgdGltZSBvciB1c2UgdmR1c2VfaW92YV9kb21haW4tPmlvdGxiIGZvcgo+Pj4+IHNl
dF9tYXAoKS4KPj4+Pgo+Pj4+IFRoZSBtYWluIGRpZmZlcmVuY2UgYmV0d2VlbiBkb21haW4tPmlv
dGxiIGFuZCBkZXYtPmlvdGxiIGlzIHRoZSB3YXkgdG8KPj4+PiBkZWFsIHdpdGggYm91bmNlIGJ1
ZmZlci4gSW4gdGhlIGRvbWFpbi0+aW90bGIgY2FzZSwgYm91bmNlIGJ1ZmZlcgo+Pj4+IG5lZWRz
IHRvIGJlIG1hcHBlZCBlYWNoIERNQSB0cmFuc2ZlciBiZWNhdXNlIHdlIG5lZWQgdG8gZ2V0IHRo
ZSBib3VuY2UKPj4+PiBwYWdlcyBieSBhbiBJT1ZBIGR1cmluZyBETUEgdW5tYXBwaW5nLiBJbiB0
aGUgZGV2LT5pb3RsYiBjYXNlLCBib3VuY2UKPj4+PiBidWZmZXIgb25seSBuZWVkcyB0byBiZSBt
YXBwZWQgb25jZSBkdXJpbmcgaW5pdGlhbGl6YXRpb24sIHdoaWNoIHdpbGwKPj4+PiBiZSB1c2Vk
IHRvIHRlbGwgdXNlcnNwYWNlIGhvdyB0byBkbyBtbWFwKCkuCj4+Pj4KPj4+PiBBbHNvLCBzaW5j
ZSB2aG9zdCBJT1RMQiBzdXBwb3J0IHBlciBtYXBwaW5nIHRva2VuIChvcGF1cWUpLCBjYW4gd2Ug
dXNlCj4+Pj4gdGhhdCBpbnN0ZWFkIG9mIHRoZSBib3VuY2VfcGFnZXMgKj8KPj4+Pgo+Pj4+IFNv
cnJ5LCBJIGRpZG4ndCBnZXQgeW91IGhlcmUuIFdoaWNoIHZhbHVlIGRvIHlvdSBtZWFuIHRvIHN0
b3JlIGluIHRoZQo+Pj4+IG9wYXF1ZSBwb2ludGVy77yfCj4+Pj4KPj4+PiBTbyBJIHdvdWxkIGxp
a2UgdG8gaGF2ZSBhIHdheSB0byB1c2UgYSBzaW5nbGUgSU9UTEIgZm9yIG1hbmFnZSBhbGwga2lu
ZHMKPj4+PiBvZiBtYXBwaW5ncy4gVHdvIHBvc3NpYmxlIGlkZWFzOgo+Pj4+Cj4+Pj4gMSkgbWFw
IGJvdW5jZSBwYWdlIG9uZSBieSBvbmUgaW4gdmR1c2VfZGV2X21hcF9wYWdlKCksIGluCj4+Pj4g
VkRVU0VfSU9UTEJfR0VUX0ZELCB0cnkgdG8gbWVyZ2UgdGhlIHJlc3VsdCBpZiB3ZSBoYWQgdGhl
IHNhbWUgZmQuIFRoZW4KPj4+PiBmb3IgYm91bmNlIHBhZ2VzLCB1c2Vyc3BhY2Ugc3RpbGwgb25s
eSBuZWVkIHRvIG1hcCBpdCBvbmNlIGFuZCB3ZSBjYW4KPj4+PiBtYWludGFpbiB0aGUgYWN0dWFs
IG1hcHBpbmcgYnkgc3RvcmluZyB0aGUgcGFnZSBvciBwYSBpbiB0aGUgb3BhcXVlCj4+Pj4gZmll
bGQgb2YgSU9UTEIgZW50cnkuCj4+Pj4KPj4+PiBMb29rcyBsaWtlIHVzZXJzcGFjZSBzdGlsbCBu
ZWVkcyB0byB1bm1hcCB0aGUgb2xkIHJlZ2lvbiBhbmQgbWFwIGEgbmV3Cj4+Pj4gcmVnaW9uIChz
aXplIGlzIGNoYW5nZWQpIHdpdGggdGhlIGZkIGluIGVhY2ggVkRVU0VfSU9UTEJfR0VUX0ZEIGlv
Y3RsLgo+Pj4+Cj4+Pj4KPj4+PiBJIGRvbid0IGdldCBoZXJlLiBDYW4geW91IGdpdmUgYW4gZXhh
bXBsZT8KPj4+Pgo+Pj4gRm9yIGV4YW1wbGUsIHVzZXJzcGFjZSBuZWVkcyB0byBwcm9jZXNzIHR3
byBJL08gcmVxdWVzdHMgKG9uZSBwYWdlIHBlcgo+Pj4gcmVxdWVzdCkuIFRvIHByb2Nlc3MgdGhl
IGZpcnN0IHJlcXVlc3QsIHVzZXJzcGFjZSB1c2VzCj4+PiBWRFVTRV9JT1RMQl9HRVRfRkQgaW9j
dGwgdG8gcXVlcnkgdGhlIGlvdmEgcmVnaW9uICgwIH4gNDA5NikgYW5kIG1tYXAKPj4+IGl0Lgo+
Pgo+PiBJIHRoaW5rIGluIHRoaXMgY2FzZSB3ZSBzaG91bGQgbGV0IFZEVVNFX0lPVExCX0dFVF9G
RCByZXR1cm4gdGhlIG1heGltdW0KPj4gcmFuZ2UgYXMgZmFyIGFzIHRoZXkgYXJlIGJhY2tlZCBi
eSB0aGUgc2FtZSBmZC4KPj4KPiBCdXQgbm93IHRoZSBib3VuY2UgcGFnZSBpcyBtYXBwZWQgb25l
IGJ5IG9uZS4gVGhlIHNlY29uZCBwYWdlICg0MDk2IH4KPiA4MTkyKSBtaWdodCBub3QgYmUgbWFw
cGVkIHdoZW4gdXNlcnNwYWNlIGlzIHByb2Nlc3NpbmcgdGhlIGZpcnN0Cj4gcmVxdWVzdC4gU28g
dGhlIG1heGltdW0gcmFuZ2UgaXMgMCB+IDQwOTYgYXQgdGhhdCB0aW1lLgo+Cj4gVGhhbmtzLAo+
IFlvbmdqaQoKCkEgcXVlc3Rpb24sIGlmIEkgcmVhZCB0aGUgY29kZSBjb3JyZWN0bHksIFZEVVNF
X0lPVExCX0dFVF9GRCB3aWxsIHJldHVybiAKdGhlIHdob2xlIGJvdW5jZSBtYXAgcmFuZ2Ugd2hp
Y2ggaXMgc2V0dXAgaW4gdmR1c2VfZGV2X21hcF9wYWdlKCk/IFNvIG15IAp1bmRlcnN0YW5kaW5n
IGlzIHRoYXQgdXNlcnNhcGNlIG1heSBjaG9vc2UgdG8gbWFwIGFsbCBpdHMgcmFuZ2UgdmlhIG1t
YXAoKS4KClNvIGlmIHdlICdtYXAnIGJvdW5jZSBwYWdlIG9uZSBieSBvbmUgaW4gdmR1c2VfZGV2
X21hcF9wYWdlKCkuIChIZXJlIAonbWFwJyBtZWFucyB1c2luZyBtdWx0aXBsZSBpdHJlZSBlbnRy
aWVzIGluc3RlYWQgb2YgYSBzaW5nbGUgb25lKS4gVGhlbiAKaW4gdGhlIFZEVVNFX0lPVExCX0dF
VF9GRCB3ZSBjYW4ga2VlcCB0cmF2ZXJzaW5nIGl0cmVlIChkZXYtPmlvbW11KSAKdW50aWwgdGhl
IHJhbmdlIGlzIGJhY2tlZCBieSBhIGRpZmZlcmVudCBmaWxlLgoKV2l0aCB0aGlzLCB0aGVyZSdz
IG5vIHVzZXJzcGFjZSB2aXNpYmxlIGNoYW5nZXMgYW5kIHRoZXJlJ3Mgbm8gbmVlZCBmb3IgCnRo
ZSBkb21haW4tPmlvdGxiPwoKVGhhbmtzCgoKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
