Return-Path: <SRS0=qSBX=KB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984FCC433ED
	for <virtualization@archiver.kernel.org>; Thu,  6 May 2021 03:23:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FEBB600CC
	for <virtualization@archiver.kernel.org>; Thu,  6 May 2021 03:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FEBB600CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D500183C0F;
	Thu,  6 May 2021 03:23:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gvmywMGYmIOy; Thu,  6 May 2021 03:23:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5EC4E83C0B;
	Thu,  6 May 2021 03:23:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36752C000E;
	Thu,  6 May 2021 03:23:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEFBAC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 03:23:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BFEDF60DF1
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 03:23:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n58ElscunX12
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 03:23:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3422860717
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 03:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620271424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tRwXkOR/k+ENBKPwJaIaNJZfD4OuzxyeOruC4qrPzjc=;
 b=K4XN1jthP3ELHnCbdk2fNCmGl37q/lqnrJAXYpwnO/M5kFAiR9FlrR5FWYsFFQNdThCkgG
 O024o42oudzaSlxNxQWOp+eMbpzLcMlgVsuRhrI08o5PsxJnn89oAJkjlHO6oSCCQs10rE
 cFaeWZZmcUtt4pz7KZl9XEnIJVJ6UNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-l9YlslM7PzO3CrdpIASveA-1; Wed, 05 May 2021 23:23:40 -0400
X-MC-Unique: l9YlslM7PzO3CrdpIASveA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1550C801B13;
 Thu,  6 May 2021 03:23:39 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-159.pek2.redhat.com
 [10.72.13.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 582185C3DF;
 Thu,  6 May 2021 03:23:34 +0000 (UTC)
Subject: Re: [PATCH net-next] virtio-net: fix use-after-free in skb_gro_receive
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <1620030574.9881887-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <770ce8e6-4948-2977-4d63-7d82075e7fc8@redhat.com>
Date: Thu, 6 May 2021 11:23:32 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <1620030574.9881887-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Jakub Kicinski <kuba@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 virtualization@lists.linux-foundation.org
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

CuWcqCAyMDIxLzUvMyDkuIvljYg0OjI5LCBYdWFuIFpodW8g5YaZ6YGTOgo+IE9uIE1vbiwgMyBN
YXkgMjAyMSAwNDowMDoxMyAtMDQwMCwgTWljaGFlbCBTLiBUc2lya2luPG1zdEByZWRoYXQuY29t
PiAgd3JvdGU6Cj4+IE9uIEZyaSwgQXByIDIzLCAyMDIxIGF0IDEyOjMzOjA5UE0gKzA4MDAsIEph
c29uIFdhbmcgd3JvdGU6Cj4+PiDlnKggMjAyMS80LzIzIOS4i+WNiDEyOjE5LCBYdWFuIFpodW8g
5YaZ6YGTOgo+Pj4+IE9uIEZyaSwgMjMgQXByIDIwMjEgMTI6MDg6MzQgKzA4MDAsIEphc29uIFdh
bmc8amFzb3dhbmdAcmVkaGF0LmNvbT4gIHdyb3RlOgo+Pj4+PiDlnKggMjAyMS80LzIyIOS4i+WN
iDExOjE2LCBYdWFuIFpodW8g5YaZ6YGTOgo+Pj4+Pj4gV2hlbiAiaGVhZHJvb20iID4gMCwgdGhl
IGFjdHVhbCBhbGxvY2F0ZWQgbWVtb3J5IHNwYWNlIGlzIHRoZSBlbnRpcmUKPj4+Pj4+IHBhZ2Us
IHNvIHRoZSBhZGRyZXNzIG9mIHRoZSBwYWdlIHNob3VsZCBiZSB1c2VkIHdoZW4gcGFzc2luZyBp
dCB0bwo+Pj4+Pj4gYnVpbGRfc2tiKCkuCj4+Pj4+Pgo+Pj4+Pj4gQlVHOiBLQVNBTjogdXNlLWFm
dGVyLWZyZWUgaW4gc2tiX2dyb19yZWNlaXZlIChuZXQvY29yZS9za2J1ZmYuYzo0MjYwKQo+Pj4+
Pj4gV3JpdGUgb2Ygc2l6ZSAxNiBhdCBhZGRyIGZmZmY4ODgxMTYxOWZmZmMgYnkgdGFzayBrd29y
a2VyL3U5OjAvNTM0Cj4+Pj4+PiBDUFU6IDIgUElEOiA1MzQgQ29tbToga3dvcmtlci91OTowIE5v
dCB0YWludGVkIDUuMTIuMC1yYzctY3VzdG9tLTE2MzcyLWdiMTUwYmUwNWI4MDYgIzMzODIKPj4+
Pj4+IEhhcmR3YXJlIG5hbWU6IFFFTVUgTVNOMjcwMCwgQklPUyByZWwtMS4xMy4wLTAtZ2YyMWI1
YTRhZWIwMi1wcmVidWlsdC5xZW11Lm9yZyAwNC8wMS8yMDE0Cj4+Pj4+PiBXb3JrcXVldWU6IHhw
cnRpb2QgeHNfc3RyZWFtX2RhdGFfcmVjZWl2ZV93b3JrZm4gW3N1bnJwY10KPj4+Pj4+IENhbGwg
VHJhY2U6Cj4+Pj4+PiAgICAgPElSUT4KPj4+Pj4+IGR1bXBfc3RhY2sgKGxpYi9kdW1wX3N0YWNr
LmM6MTIyKQo+Pj4+Pj4gcHJpbnRfYWRkcmVzc19kZXNjcmlwdGlvbi5jb25zdHByb3AuMCAobW0v
a2FzYW4vcmVwb3J0LmM6MjMzKQo+Pj4+Pj4ga2FzYW5fcmVwb3J0LmNvbGQgKG1tL2thc2FuL3Jl
cG9ydC5jOjQwMCBtbS9rYXNhbi9yZXBvcnQuYzo0MTYpCj4+Pj4+PiBza2JfZ3JvX3JlY2VpdmUg
KG5ldC9jb3JlL3NrYnVmZi5jOjQyNjApCj4+Pj4+PiB0Y3BfZ3JvX3JlY2VpdmUgKG5ldC9pcHY0
L3RjcF9vZmZsb2FkLmM6MjY2IChkaXNjcmltaW5hdG9yIDEpKQo+Pj4+Pj4gdGNwNF9ncm9fcmVj
ZWl2ZSAobmV0L2lwdjQvdGNwX29mZmxvYWQuYzozMTYpCj4+Pj4+PiBpbmV0X2dyb19yZWNlaXZl
IChuZXQvaXB2NC9hZl9pbmV0LmM6MTU0NSAoZGlzY3JpbWluYXRvciAyKSkKPj4+Pj4+IGRldl9n
cm9fcmVjZWl2ZSAobmV0L2NvcmUvZGV2LmM6NjA3NSkKPj4+Pj4+IG5hcGlfZ3JvX3JlY2VpdmUg
KG5ldC9jb3JlL2Rldi5jOjYxNjggbmV0L2NvcmUvZGV2LmM6NjE5OCkKPj4+Pj4+IHJlY2VpdmVf
YnVmIChkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmM6MTE1MSkgdmlydGlvX25ldAo+Pj4+Pj4gdmly
dG5ldF9wb2xsIChkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmM6MTQxNSBkcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmM6MTUxOSkgdmlydGlvX25ldAo+Pj4+Pj4gX19uYXBpX3BvbGwgKG5ldC9jb3JlL2Rl
di5jOjY5NjQpCj4+Pj4+PiBuZXRfcnhfYWN0aW9uIChuZXQvY29yZS9kZXYuYzo3MDMzIG5ldC9j
b3JlL2Rldi5jOjcxMTgpCj4+Pj4+PiBfX2RvX3NvZnRpcnEgKC4vYXJjaC94ODYvaW5jbHVkZS9h
c20vanVtcF9sYWJlbC5oOjI1IC4vaW5jbHVkZS9saW51eC9qdW1wX2xhYmVsLmg6MjAwIC4vaW5j
bHVkZS90cmFjZS9ldmVudHMvaXJxLmg6MTQyIGtlcm5lbC9zb2Z0aXJxLmM6MzQ2KQo+Pj4+Pj4g
aXJxX2V4aXRfcmN1IChrZXJuZWwvc29mdGlycS5jOjIyMSBrZXJuZWwvc29mdGlycS5jOjQyMiBr
ZXJuZWwvc29mdGlycS5jOjQzNCkKPj4+Pj4+IGNvbW1vbl9pbnRlcnJ1cHQgKGFyY2gveDg2L2tl
cm5lbC9pcnEuYzoyNDAgKGRpc2NyaW1pbmF0b3IgMTQpKQo+Pj4+Pj4gPC9JUlE+Cj4+Pj4+Pgo+
Pj4+Pj4gRml4ZXM6IGZiMzI4NTZiMTZhZCAoInZpcnRpby1uZXQ6IHBhZ2VfdG9fc2tiKCkgdXNl
IGJ1aWxkX3NrYiB3aGVuIHRoZXJlJ3Mgc3VmZmljaWVudCB0YWlscm9vbSIpCj4+Pj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBYdWFuIFpodW88eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4+Pj4+PiBS
ZXBvcnRlZC1ieTogSWRvIFNjaGltbWVsPGlkb3NjaEBudmlkaWEuY29tPgo+Pj4+Pj4gVGVzdGVk
LWJ5OiBJZG8gU2NoaW1tZWw8aWRvc2NoQG52aWRpYS5jb20+Cj4+Pj4+PiAtLS0KPj4+Pj4gQWNr
ZWQtYnk6IEphc29uIFdhbmc8amFzb3dhbmdAcmVkaGF0LmNvbT4KPj4+Pj4KPj4+Pj4gVGhlIGNv
ZGVzIGJlY2FtZSBoYXJkIHRvIHJlYWQsIEkgdGhpbmsgd2UgY2FuIHRyeSB0byBkbyBzb21lIGNs
ZWFudXBzIG9uCj4+Pj4+IHRvcCB0byBtYWtlIGl0IGVhc2llciB0byByZWFkLgo+Pj4+Pgo+Pj4+
PiBUaGFua3MKPj4+PiBZZXMsIHRoaXMgcGllY2Ugb2YgY29kZSBuZWVkcyB0byBiZSBzb3J0ZWQg
b3V0LiBFc3BlY2lhbGx5IHRoZSBiaWcgYW5kIG1lcmdlYWJsZQo+Pj4+IHNjZW5hcmlvcyBzaG91
bGQgYmUgaGFuZGxlZCBzZXBhcmF0ZWx5LiBSZW1vdmUgdGhlIG1lcmdlYWJsZSBjb2RlIGZyb20g
dGhpcwo+Pj4+IGZ1bmN0aW9uLCBhbmQgbWVyZ2VhYmxlIHVzZXMgYSBuZXcgZnVuY3Rpb24gYWxv
bmUuCj4+PiBSaWdodCwgYW5vdGhlciB0aGluZyBpcyB0aGF0IHdlIG1heSBjb25zaWRlciB0byBy
ZWxheCB0aGUgY2hlY2tpbmcgb2YgbGVuIDwKPj4+IEdPT0RfQ09QWV9MRU4uCj4+IFdhbnQgdG8g
cG9zdCBhIHBhdGNoIG9uIHRvcD8KPiBZZXMsIEkgaGF2ZSBjb21wbGV0ZWQgdGhlIHJlZmFjdG9y
aW5nIG9mIHRoaXMgcGFydCBvZiB0aGUgY29kZSwgYW5kIHRoZSByZWxhdGVkCj4gdGVzdGluZyB3
b3JrIGlzIGluIHByb2dyZXNzLiBJIHdpbGwgc3VibWl0IHRoZSBwYXRjaCBhZnRlciB0aGUgY29t
cGxldGUgdGVzdCBpcwo+IGNvbXBsZXRlZC4KPgo+IFRoYW5rcy4KCgpDb29sLCBvbmUgdGhpbmcg
aW4gbXkgbWluZCBpcyB3ZSdkIGJldHRlciBwYWNrIHRoZSBjb3JyZWN0IHRydWVzaXplIChlLmcg
ClBBR0VfU0laRSBpbiB0aGUgY2FzZSBvZiBYRFApIGluIHRoZSBjdHggYW5kIGF2b2lkIHRyaWNr
eSBjb2RlcyBsaWtlOgoKIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBCdWZmZXJz
IHdpdGggaGVhZHJvb20gdXNlIFBBR0VfU0laRSBhcyBhbGxvYyBzaXplLAogwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBzZWUgYWRkX3JlY3ZidWZfbWVyZ2VhYmxlKCkgKyBnZXRf
bWVyZ2VhYmxlX2J1Zl9sZW4oKQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8K
ClRoYW5rcwoKCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
