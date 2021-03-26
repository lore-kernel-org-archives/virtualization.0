Return-Path: <SRS0=4L+9=IY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA078C433DB
	for <virtualization@archiver.kernel.org>; Fri, 26 Mar 2021 07:36:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 686D161A2D
	for <virtualization@archiver.kernel.org>; Fri, 26 Mar 2021 07:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 686D161A2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 105AC84A07;
	Fri, 26 Mar 2021 07:36:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7WTCnJhMpAWA; Fri, 26 Mar 2021 07:36:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id A2CF283E9F;
	Fri, 26 Mar 2021 07:36:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73013C000D;
	Fri, 26 Mar 2021 07:36:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E963C000A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Mar 2021 07:36:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DB55B40238
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Mar 2021 07:36:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G8eOr5e_3r7m
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Mar 2021 07:36:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E18CC4023D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Mar 2021 07:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616744198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dSLEq+hMh1Ql2uL/IHuUBMQc9+yVTsv/4GeCDE92710=;
 b=ayT0XhuEHrQ9rHwzKP0RBRC33Ib8/AwKoAfRQJXRh5c2iNZHatjeJpllni2WOEPj4Rd0S7
 odIyU4q18ReYfeJWyv3pc5Q7Wvsx4wec8q8agTL1999hZZFMpIh7ng3Tn4DRetzI3zqvDe
 eHj7fA8jxWloRPeUYySCsQfv1su7SiU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-wodSWgXbMYuwG4FqjYaUNw-1; Fri, 26 Mar 2021 03:36:36 -0400
X-MC-Unique: wodSWgXbMYuwG4FqjYaUNw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E68B784BA41;
 Fri, 26 Mar 2021 07:36:33 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-10.pek2.redhat.com
 [10.72.13.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 31C995D9CA;
 Fri, 26 Mar 2021 07:36:20 +0000 (UTC)
Subject: Re: [PATCH v5 08/11] vduse: Implement an MMU-based IOMMU driver
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210315053721.189-1-xieyongji@bytedance.com>
 <20210315053721.189-9-xieyongji@bytedance.com>
 <ec5b4146-9844-11b0-c9b0-c657d3328dd4@redhat.com>
 <CACycT3v_-G6ju-poofXEzYt8QPKWNFHwsS7t=KTLgs-=g+iPQQ@mail.gmail.com>
 <7c90754b-681d-f3bf-514c-756abfcf3d23@redhat.com>
 <CACycT3uS870yy04rw7KBk==sioi+VNunxVz6BQH-Lmxk6m-VSg@mail.gmail.com>
 <2db71996-037e-494d-6ef0-de3ff164d3c3@redhat.com>
 <CACycT3v6Lj61fafztOuzBNFLs2TbKeqrNLXkzv5RK6-h-iTnvA@mail.gmail.com>
 <75e3b941-dfd2-ebbc-d752-8f25c1f14cab@redhat.com>
 <CACycT3t+2MC9rQ7iWdWQ4=O3ojCXHvHZ-M7y7AjXoXYZUiAOzQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <817336fa-c026-fd4d-dd2e-eb5f40c63ad4@redhat.com>
Date: Fri, 26 Mar 2021 15:36:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CACycT3t+2MC9rQ7iWdWQ4=O3ojCXHvHZ-M7y7AjXoXYZUiAOzQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, bcrl@kvack.org, viro@zeniv.linux.org.uk,
 Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel@vger.kernel.org,
 Dan Carpenter <dan.carpenter@oracle.com>,
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

CuWcqCAyMDIxLzMvMjYg5LiL5Y2IMjo1NiwgWW9uZ2ppIFhpZSDlhpnpgZM6Cj4gT24gRnJpLCBN
YXIgMjYsIDIwMjEgYXQgMjoxNiBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3
cm90ZToKPj4KPj4g5ZyoIDIwMjEvMy8yNiDkuIvljYgxOjE0LCBZb25namkgWGllIOWGmemBkzoK
Pj4KPj4gKyAgICAgfQo+PiArICAgICBtYXAtPmJvdW5jZV9wYWdlID0gcGFnZTsKPj4gKwo+PiAr
ICAgICAvKiBwYWlyZWQgd2l0aCB2ZHVzZV9kb21haW5fbWFwX3BhZ2UoKSAqLwo+PiArICAgICBz
bXBfbWIoKTsKPj4KPj4gU28gdGhpcyBpcyBzdXNwaWNpb3VzLiBJdCdzIGJldHRlciB0byBleHBs
YWluIGxpa2UsIHdlIG5lZWQgbWFrZSBzdXJlIEEKPj4gbXVzdCBiZSBkb25lIGFmdGVyIEIuCj4+
Cj4+IE9LLiBJIHNlZS4gSXQncyB1c2VkIHRvIHByb3RlY3QgdGhpcyBwYXR0ZXJuOgo+Pgo+PiAg
ICAgICB2ZHVzZV9kb21haW5fYWxsb2NfYm91bmNlX3BhZ2U6ICAgICAgICAgIHZkdXNlX2RvbWFp
bl9tYXBfcGFnZToKPj4gICAgICAgd3JpdGUgbWFwLT5ib3VuY2VfcGFnZSAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHdyaXRlIG1hcC0+b3JpZ19waHlzCj4+ICAgICAgIG1iKCkgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtYigpCj4+
ICAgICAgIHJlYWQgbWFwLT5vcmlnX3BoeXMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICByZWFkIG1hcC0+Ym91bmNlX3BhZ2UKPj4KPj4gTWFrZSBzdXJlIHRoZXJlIHdpbGwgYWx3YXlz
IGJlIGEgcGF0aCB0byBkbyBib3VuY2luZy4KPj4KPj4gT2suCj4+Cj4+Cj4+IEFuZCBpdCBsb29r
cyB0byBtZSB0aGUgaW90bGJfbG9jayBpcyBzdWZmaWNuZXQgdG8gZG8gdGhlIHN5bmNocm9uaXph
dGlvbgo+PiBoZXJlLiBFLmcgYW55IHJlYXNvbiB0aGF0IHlvdSBkb24ndCB0YWtlIGl0IGluCj4+
IHZkdXNlX2RvbWFpbl9tYXBfYm91bmNlX3BhZ2UoKS4KPj4KPj4gWWVzLCB3ZSBjYW4uIEJ1dCB0
aGUgcGVyZm9ybWFuY2UgaW4gbXVsdGktcXVldWUgY2FzZXMgd2lsbCBnbyBkb3duIGlmCj4+IHdl
IHVzZSBpb3RsYl9sb2NrIG9uIHRoaXMgY3JpdGljYWwgcGF0aC4KPj4KPj4gQW5kIHdoYXQncyBt
b3JlLCBpcyB0aGVyZSBhbnl3YXkgdG8gYW92aWQgaG9sZGluZyB0aGUgc3BpbmxvY2sgZHVyaW5n
Cj4+IGJvdW5jaW5nPwo+Pgo+PiBMb29rcyBsaWtlIHdlIGNhbid0LiBJbiB0aGUgY2FzZSB0aGF0
IG11bHRpcGxlIHBhZ2UgZmF1bHRzIGhhcHBlbiBvbgo+PiB0aGUgc2FtZSBwYWdlLCB3ZSBzaG91
bGQgbWFrZSBzdXJlIHRoZSBib3VuY2luZyBpcyBkb25lIGJlZm9yZSBhbnkKPj4gcGFnZSBmYXVs
dCBoYW5kbGVyIHJldHVybnMuCj4+Cj4+IFNvIGl0IGxvb2tzIHRvIG1lIGFsbCB0aG9zZSBleHRy
YSBjb21wbGV4aXRpeSBjb21lcyBmcm9tIHRoZSBmYWN0IHRoYXQKPj4gdGhlIGJvdW5jZV9wYWdl
IGFuZCBvcmlnX3BoeXMgYXJlIHNldCBieSBkaWZmZXJlbnQgcGxhY2VzIHNvIHdlIG5lZWQgdG8K
Pj4gZG8gdGhlIGJvdW5jaW5nIGluIHR3byBwbGFjZXMuCj4+Cj4+IEkgd29uZGVyIGhvdyBtdWNo
IHdlIGNhbiBnYWluIGZyb20gdGhlICJsYXp5IiBib3VjbmluZyBpbiBwYWdlIGZhdWx0Lgo+PiBU
aGUgYnVmZmVyIG1hcHBlZCB2aWEgZG1hX29wcyBmcm9tIHZpcnRpbyBkcml2ZXIgaXMgZXhwZWN0
ZWQgdG8gYmUKPj4gYWNjZXNzZWQgYnkgdGhlIHVzZXJzcGFjZSBzb29uLiAgSXQgbG9va3MgdG8g
bWUgd2UgY2FuIGRvIGFsbCB0aG9zZQo+PiBzdHVmZnMgZHVyaW5nIGRtYV9tYXAoKSB0aGVuIHRo
aW5ncyB3b3VsZCBiZSBncmVhdGx5IHNpbXBsaWZpZWQuCj4+Cj4+IElmIHNvLCB3ZSBuZWVkIHRv
IGFsbG9jYXRlIGxvdHMgb2YgcGFnZXMgZnJvbSB0aGUgcG9vbCByZXNlcnZlZCBmb3IKPj4gYXRv
bWljIG1lbW9yeSBhbGxvY2F0aW9uIHJlcXVlc3RzLgo+Pgo+PiBUaGlzIHNob3VsZCBiZSBmaW5l
LCBhIGxvdCBvZiBkcml2ZXJzIHRyaWVzIHRvIGFsbG9jYXRlIHBhZ2VzIGluIGF0b21pYwo+PiBj
b250ZXh0LiBUaGUgcG9pbnQgaXMgdG8gc2ltcGxpZnkgdGhlIGNvZGVzIHRvIG1ha2UgaXQgZWFz
eSB0bwo+PiBkZXRlcm1pbmNlIHRoZSBjb3JyZWN0bmVzcyBzbyB3ZSBjYW4gYWRkIG9wdGltaXph
dGlvbiBvbiB0b3Agc2ltcGx5IGJ5Cj4+IGJlbmNobWFya2luZyB0aGUgZGlmZmVyZW5jZS4KPj4K
Pj4gT0suIEkgd2lsbCB1c2UgdGhpcyB3YXkgaW4gdGhlIG5leHQgdmVyc2lvbi4KPj4KPj4gRS5n
IHdlIGhhdmUgc2VydmVyYWwgcGxhY2VzIHRoYXQgYWNjZXNzZXMgb3JpZ19waHlzOgo+Pgo+PiAx
KSBtYXBfcGFnZSgpLCB3cml0ZQo+PiAyKSB1bm1hcF9wYWdlKCksIHdyaXRlCj4+IDMpIHBhZ2Ug
ZmF1bHQgaGFuZGxlciwgcmVhZAo+Pgo+PiBJdCdzIG5vdCBjbGVhciB0byBtZSBob3cgdGhleSB3
ZXJlIHN5bmNocm9uaXplZC4gT3IgaWYgaXQgd2FzCj4+IHN5bmNocm9uemllZCBpbXBsaWNpdGx5
ICh2aWEgaW92YSBhbGxvY2F0b3I/KSwgd2UnZCBiZXR0ZXIgZG9jdW1lbnQgaXQuCj4+Cj4+IFll
cy4KPj4KPj4gT3Igc2ltcGx5IHVzZSBzcGlubG9jayAod2hpY2ggaXMgdGhlIHByZWZlcnJhYmxl
IHdheSBJJ2QgbGlrZSB0byBnbykuIFdlCj4+IHByb2JhYmx5IGRvbid0IG5lZWQgdG8gd29ycnkg
dG9vIG11Y2ggYWJvdXQgdGhlIGNvc3Qgb2Ygc3BpbmxvY2sgc2luY2UKPj4gaW92YSBhbGxvY2F0
ZXIgdXNlIGl0IGhlYXZpbHkuCj4+Cj4+IEFjdHVhbGx5IGlvdmEgYWxsb2NhdG9yIGltcGxlbWVu
dHMgYSBwZXItQ1BVIGNhY2hlIHRvIG9wdGltaXplIGl0Lgo+Pgo+PiBUaGFua3MsCj4+IFlvbmdq
aQo+Pgo+Pgo+PiBSaWdodCwgYnV0IGhhdmUgYSBxdWljayBnbGFuY2UsIEkgZ3Vlc3Mgd2hhdCB5
b3UgbWVhbnQgaXMgdGhhdCB1c3VhbGx5IHRoZXJlJ3Mgbm8gbG9jayBjb250ZW50aW9uIHVubGVz
cyBjcHUgaG90LXBsdWcuIFRoaXMgY2FuIHdvcmsgYnV0IHRoZSBwcm9ibGVtIGlzIHRoYXQgc3Vj
aCBzeW5jaG9ybml6YXRpb24gZGVwZW5kcyBvbiB0aGUgaW50ZXJuYWwgaW1wbGVtZW50YXRpb24g
b2YgSU9WQSBhbGxvY2F0b3Igd2hpY2ggaXMga2luZCBvZiBmcmFnaWxlLiBJIHN0aWxsIHRoaW5r
IHdlIHNob3VsZCBkbyB0aGF0IG9uIG91ciBvd24uCj4+Cj4gSSBtaWdodCBtaXNzIHNvbWV0aGlu
Zy4gTG9va3MgbGlrZSB3ZSBkb24ndCBuZWVkIGFueSBzeW5jaHJvbml6YXRpb24KPiBpZiB0aGUg
cGFnZSBmYXVsdCBoYW5kbGVyIGlzIHJlbW92ZWQgYXMgeW91IHN1Z2dlc3RlZC4gV2Ugc2hvdWxk
IG5vdAo+IGFjY2VzcyB0aGUgc2FtZSBvcmlnX3BoeXMgY29uY3VycmVudGx5IChpbiBtYXBfcGFn
ZSgpIGFuZAo+IHVubWFwX3BhZ2UoKSkgdW5sZXNzIHdlIGZyZWUgdGhlIGlvdmEgYmVmb3JlIGFj
Y2Vzc2luZy4KPgo+IFRoYW5rcywKPiBZb25namkKCgpZb3UncmUgcmlnaHQuIEkgb3ZlcmVzdGlt
YXRlIHRoZSBjb21wbGV4aXRpeSB0aGF0IGlzIHJlcXVpcmVkIGJ5IHRoZSAKc3luY2hyb25pemF0
aW9uLgoKVGhhbmtzCgoKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
