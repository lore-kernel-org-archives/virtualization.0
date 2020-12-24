Return-Path: <SRS0=rM6z=F4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E61C433E0
	for <virtualization@archiver.kernel.org>; Thu, 24 Dec 2020 02:25:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98D6B2256F
	for <virtualization@archiver.kernel.org>; Thu, 24 Dec 2020 02:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D6B2256F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3DD0687200;
	Thu, 24 Dec 2020 02:25:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dQsmqYdCMxF1; Thu, 24 Dec 2020 02:25:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8AA62871F2;
	Thu, 24 Dec 2020 02:25:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70DE5C1787;
	Thu, 24 Dec 2020 02:25:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 182ECC0893
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Dec 2020 02:25:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0CA38866E4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Dec 2020 02:25:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IJdKGyc2Mz33
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Dec 2020 02:25:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1083B866BD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Dec 2020 02:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608776701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JdMJ8HnlG5riluBKSxMPivzDGvzPYrwD7jfW+dFij+4=;
 b=bqc9ZqzY293ksAoaDEYbKG3bs9Yk69hqC/gzq0J5Ovn4ZH1mSqAqyPiErBpuVWtId85YYj
 NqyrCPv+o6R/Fd8IKDyhF+4soNPH092gQi5sLpEiyBRdXzdk7xg0jwz0NmEbzJ4MFREFWL
 m8G+qRxh5b8d6ltbN6Mvm1MrKRyTnlo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-z5fT8538NHm7DeP68XxA3w-1; Wed, 23 Dec 2020 21:24:58 -0500
X-MC-Unique: z5fT8538NHm7DeP68XxA3w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85A081005D4F;
 Thu, 24 Dec 2020 02:24:55 +0000 (UTC)
Received: from [10.72.13.109] (ovpn-13-109.pek2.redhat.com [10.72.13.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4130D60C04;
 Thu, 24 Dec 2020 02:24:31 +0000 (UTC)
Subject: Re: [RFC v2 00/13] Introduce VDUSE - vDPA Device in Userspace
To: Yongji Xie <xieyongji@bytedance.com>
References: <20201222145221.711-1-xieyongji@bytedance.com>
 <c892652a-3f57-c337-8c67-084ba6d10834@redhat.com>
 <CACycT3tr-1EDeH4j0AojD+-qM5yqDUU0tQHieVUXgL7AOTHyvQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6e81f56a-0f95-248c-e88f-4190ca7f49a2@redhat.com>
Date: Thu, 24 Dec 2020 10:24:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACycT3tr-1EDeH4j0AojD+-qM5yqDUU0tQHieVUXgL7AOTHyvQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: axboe@kernel.dk, corbet@lwn.net, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-aio@kvack.org,
 netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org, bcrl@kvack.org,
 viro@zeniv.linux.org.uk, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org
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

Ck9uIDIwMjAvMTIvMjMg5LiL5Y2INjo1OSwgWW9uZ2ppIFhpZSB3cm90ZToKPiBPbiBXZWQsIERl
YyAyMywgMjAyMCBhdCAyOjM4IFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdy
b3RlOgo+Pgo+PiBPbiAyMDIwLzEyLzIyIOS4i+WNiDEwOjUyLCBYaWUgWW9uZ2ppIHdyb3RlOgo+
Pj4gVGhpcyBzZXJpZXMgaW50cm9kdWNlcyBhIGZyYW1ld29yaywgd2hpY2ggY2FuIGJlIHVzZWQg
dG8gaW1wbGVtZW50Cj4+PiB2RFBBIERldmljZXMgaW4gYSB1c2Vyc3BhY2UgcHJvZ3JhbS4gVGhl
IHdvcmsgY29uc2lzdCBvZiB0d28gcGFydHM6Cj4+PiBjb250cm9sIHBhdGggZm9yd2FyZGluZyBh
bmQgZGF0YSBwYXRoIG9mZmxvYWRpbmcuCj4+Pgo+Pj4gSW4gdGhlIGNvbnRyb2wgcGF0aCwgdGhl
IFZEVVNFIGRyaXZlciB3aWxsIG1ha2UgdXNlIG9mIG1lc3NhZ2UKPj4+IG1lY2huaXNtIHRvIGZv
cndhcmQgdGhlIGNvbmZpZyBvcGVyYXRpb24gZnJvbSB2ZHBhIGJ1cyBkcml2ZXIKPj4+IHRvIHVz
ZXJzcGFjZS4gVXNlcnNwYWNlIGNhbiB1c2UgcmVhZCgpL3dyaXRlKCkgdG8gcmVjZWl2ZS9yZXBs
eQo+Pj4gdGhvc2UgY29udHJvbCBtZXNzYWdlcy4KPj4+Cj4+PiBJbiB0aGUgZGF0YSBwYXRoLCB0
aGUgY29yZSBpcyBtYXBwaW5nIGRtYSBidWZmZXIgaW50byBWRFVTRQo+Pj4gZGFlbW9uJ3MgYWRk
cmVzcyBzcGFjZSwgd2hpY2ggY2FuIGJlIGltcGxlbWVudGVkIGluIGRpZmZlcmVudCB3YXlzCj4+
PiBkZXBlbmRpbmcgb24gdGhlIHZkcGEgYnVzIHRvIHdoaWNoIHRoZSB2RFBBIGRldmljZSBpcyBh
dHRhY2hlZC4KPj4+Cj4+PiBJbiB2aXJ0aW8tdmRwYSBjYXNlLCB3ZSBpbXBsZW1lbnRzIGEgTU1V
LWJhc2VkIG9uLWNoaXAgSU9NTVUgZHJpdmVyIHdpdGgKPj4+IGJvdW5jZS1idWZmZXJpbmcgbWVj
aGFuaXNtIHRvIGFjaGlldmUgdGhhdC4KPj4KPj4gUmV0aGluayBhYm91dCB0aGUgYm91bmNlIGJ1
ZmZlciBzdHVmZnMuIEkgd29uZGVyIGluc3RlYWQgb2YgdXNpbmcga2VybmVsCj4+IHBhZ2VzIHdp
dGggbW1hcCgpLCBob3cgYWJvdXQganVzdCB1c2UgdXNlcnNwYWNlIHBhZ2VzIGxpa2Ugd2hhdCB2
aG9zdCBkaWQ/Cj4+Cj4+IEl0IG1lYW5zIHdlIG5lZWQgYSB3b3JrZXIgdG8gZG8gYm91bmNpbmcg
YnV0IHdlIGRvbid0IG5lZWQgdG8gY2FyZSBhYm91dAo+PiBhbm5veWluZyBzdHVmZnMgbGlrZSBw
YWdlIHJlY2xhaW1pbmc/Cj4+Cj4gTm93IHRoZSBJL08gYm91bmNpbmcgaXMgZG9uZSBpbiB0aGUg
c3RyZWFtaW5nIERNQSBtYXBwaW5nIHJvdXRpbmVzCj4gd2hpY2ggY2FuIGJlIGNhbGxlZCBmcm9t
IGludGVycnVwdCBjb250ZXh0LiBJZiB3ZSBwdXQgdGhpcyBpbnRvIGEKPiBrd29ya2VyLCB0aGF0
IG1lYW5zIHdlIG5lZWQgdG8gc3luY2hyb25pemUgd2l0aCBhIGt3b3JrZXIgaW4gYW4KPiBpbnRl
cnJ1cHQgY29udGV4dC4gSSB0aGluayBpdCBjYW4ndCB3b3JrLgoKCldlIGp1c3QgbmVlZCB0byBt
YWtlIHN1cmUgdGhlIGJ1ZmZlciBpcyByZWFkeSBiZWZvcmUgdGhlIHVzZXIgaXMgdHJ5aW5nIAp0
byBhY2Nlc3MgdGhlbS4KCkJ1dCBJIGFkbWl0IGl0IHdvdWxkIGJlIHRyaWNreSAocmVxdWlyZSBz
aGFkb3cgdmlydHF1ZXVlIGV0Yykgd2hpY2ggaXMgCnByb2JhYmx5IG5vdCBhIGdvb2QgaWRlYS4K
ClRoYW5rcwoKCj4KPiBUaGFua3MsCj4gWW9uZ2ppCj4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
