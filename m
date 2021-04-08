Return-Path: <SRS0=B6Di=JF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86C3C433ED
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 03:26:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85B4561181
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 03:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B4561181
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E53283F4B;
	Thu,  8 Apr 2021 03:26:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Glk4TSdd1pYt; Thu,  8 Apr 2021 03:26:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id D4A0783F3B;
	Thu,  8 Apr 2021 03:26:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 972D0C000C;
	Thu,  8 Apr 2021 03:26:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C70EC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 03:26:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7503A4195E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 03:26:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iXbWP6RM55Ko
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 03:26:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 75A19418B5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 03:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617852377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gqqfJQKIdte55u7kG25HpIFh+raZcUjLo8p4M5prlro=;
 b=QxMSTgxRhWqUIInRgytFve11ls1/ZxEqoYZfFBBGPyB4azgzjNVUW1Xu29F9ukvvi/LM5e
 EQmqIDQwn+EWyNy6gGg76qBMi9KtmEhc7uMjJwF+zVQn/vVlip+Ov0sl+AqfRm+r8SxdYa
 40/LxWim+LKOkUsYT455UkJ9PRpDvQM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-3pXw21HFO6KHRixokR3V1g-1; Wed, 07 Apr 2021 23:26:10 -0400
X-MC-Unique: 3pXw21HFO6KHRixokR3V1g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E777B1006C83;
 Thu,  8 Apr 2021 03:26:07 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-194.pek2.redhat.com
 [10.72.12.194])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60B555CC3E;
 Thu,  8 Apr 2021 03:25:51 +0000 (UTC)
Subject: Re: [PATCH v6 08/10] vduse: Implement an MMU-based IOMMU driver
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 hch@infradead.org, christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com
References: <20210331080519.172-1-xieyongji@bytedance.com>
 <20210331080519.172-9-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <30862242-293b-f42f-d8ce-2c31a52e3697@redhat.com>
Date: Thu, 8 Apr 2021 11:25:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210331080519.172-9-xieyongji@bytedance.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org,
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvMy8zMSDPws7nNDowNSwgWGllIFlvbmdqaSDQtLXAOgo+IFRoaXMgaW1wbGVtZW50
cyBhbiBNTVUtYmFzZWQgSU9NTVUgZHJpdmVyIHRvIHN1cHBvcnQgbWFwcGluZwo+IGtlcm5lbCBk
bWEgYnVmZmVyIGludG8gdXNlcnNwYWNlLiBUaGUgYmFzaWMgaWRlYSBiZWhpbmQgaXQgaXMKPiB0
cmVhdGluZyBNTVUgKFZBLT5QQSkgYXMgSU9NTVUgKElPVkEtPlBBKS4gVGhlIGRyaXZlciB3aWxs
IHNldAo+IHVwIE1NVSBtYXBwaW5nIGluc3RlYWQgb2YgSU9NTVUgbWFwcGluZyBmb3IgdGhlIERN
QSB0cmFuc2ZlciBzbwo+IHRoYXQgdGhlIHVzZXJzcGFjZSBwcm9jZXNzIGlzIGFibGUgdG8gdXNl
IGl0cyB2aXJ0dWFsIGFkZHJlc3MgdG8KPiBhY2Nlc3MgdGhlIGRtYSBidWZmZXIgaW4ga2VybmVs
Lgo+Cj4gQW5kIHRvIGF2b2lkIHNlY3VyaXR5IGlzc3VlLCBhIGJvdW5jZS1idWZmZXJpbmcgbWVj
aGFuaXNtIGlzCj4gaW50cm9kdWNlZCB0byBwcmV2ZW50IHVzZXJzcGFjZSBhY2Nlc3NpbmcgdGhl
IG9yaWdpbmFsIGJ1ZmZlcgo+IGRpcmVjdGx5Lgo+Cj4gU2lnbmVkLW9mZi1ieTogWGllIFlvbmdq
aSA8eGlleW9uZ2ppQGJ5dGVkYW5jZS5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+CgpXaXRoIHNvbWUgbml0czoKCgo+IC0tLQo+ICAgZHJpdmVycy92ZHBh
L3ZkcGFfdXNlci9pb3ZhX2RvbWFpbi5jIHwgNTIxICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrCj4gICBkcml2ZXJzL3ZkcGEvdmRwYV91c2VyL2lvdmFfZG9tYWluLmggfCAgNzAg
KysrKysKPiAgIDIgZmlsZXMgY2hhbmdlZCwgNTkxIGluc2VydGlvbnMoKykKPiAgIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL3ZkcGEvdmRwYV91c2VyL2lvdmFfZG9tYWluLmMKPiAgIGNyZWF0
ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3ZkcGEvdmRwYV91c2VyL2lvdmFfZG9tYWluLmgKCgpbLi4u
XQoKCj4gK3N0YXRpYyB2b2lkIHZkdXNlX2RvbWFpbl9ib3VuY2Uoc3RydWN0IHZkdXNlX2lvdmFf
ZG9tYWluICpkb21haW4sCj4gKwkJCQlkbWFfYWRkcl90IGlvdmEsIHNpemVfdCBzaXplLAo+ICsJ
CQkJZW51bSBkbWFfZGF0YV9kaXJlY3Rpb24gZGlyKQo+ICt7Cj4gKwlzdHJ1Y3QgdmR1c2VfYm91
bmNlX21hcCAqbWFwOwo+ICsJdW5zaWduZWQgaW50IG9mZnNldDsKPiArCXZvaWQgKmFkZHI7Cj4g
KwlzaXplX3Qgc3o7Cj4gKwo+ICsJd2hpbGUgKHNpemUpIHsKPiArCQltYXAgPSAmZG9tYWluLT5i
b3VuY2VfbWFwc1tpb3ZhID4+IFBBR0VfU0hJRlRdOwo+ICsJCW9mZnNldCA9IG9mZnNldF9pbl9w
YWdlKGlvdmEpOwo+ICsJCXN6ID0gbWluX3Qoc2l6ZV90LCBQQUdFX1NJWkUgLSBvZmZzZXQsIHNp
emUpOwo+ICsKPiArCQlpZiAoV0FSTl9PTighbWFwLT5ib3VuY2VfcGFnZSB8fAo+ICsJCQkgICAg
bWFwLT5vcmlnX3BoeXMgPT0gSU5WQUxJRF9QSFlTX0FERFIpKQo+ICsJCQlyZXR1cm47Cj4gKwo+
ICsJCWFkZHIgPSBwYWdlX2FkZHJlc3MobWFwLT5ib3VuY2VfcGFnZSkgKyBvZmZzZXQ7Cj4gKwkJ
ZG9fYm91bmNlKG1hcC0+b3JpZ19waHlzICsgb2Zmc2V0LCBhZGRyLCBzeiwgZGlyKTsKPiArCQlz
aXplIC09IHN6Owo+ICsJCWlvdmEgKz0gc3o7Cj4gKwl9Cj4gK30KPiArCj4gK3N0YXRpYyBzdHJ1
Y3QgcGFnZSAqCj4gK3ZkdXNlX2RvbWFpbl9nZXRfbWFwcGluZ19wYWdlKHN0cnVjdCB2ZHVzZV9p
b3ZhX2RvbWFpbiAqZG9tYWluLCB1NjQgaW92YSkKCgpJdCdzIGJldHRlciB0byByZW5hbWUgdGhp
cyBhcyAidmR1c2VfZG9tYWluX2dldF9jb2hlcmVudF9wYWdlPyIuCgoKPiArewo+ICsJdTY0IHN0
YXJ0ID0gaW92YSAmIFBBR0VfTUFTSzsKPiArCXU2NCBsYXN0ID0gc3RhcnQgKyBQQUdFX1NJWkUg
LSAxOwo+ICsJc3RydWN0IHZob3N0X2lvdGxiX21hcCAqbWFwOwo+ICsJc3RydWN0IHBhZ2UgKnBh
Z2UgPSBOVUxMOwo+ICsKPiArCXNwaW5fbG9jaygmZG9tYWluLT5pb3RsYl9sb2NrKTsKPiArCW1h
cCA9IHZob3N0X2lvdGxiX2l0cmVlX2ZpcnN0KGRvbWFpbi0+aW90bGIsIHN0YXJ0LCBsYXN0KTsK
PiArCWlmICghbWFwKQo+ICsJCWdvdG8gb3V0Owo+ICsKPiArCXBhZ2UgPSBwZm5fdG9fcGFnZSgo
bWFwLT5hZGRyICsgaW92YSAtIG1hcC0+c3RhcnQpID4+IFBBR0VfU0hJRlQpOwo+ICsJZ2V0X3Bh
Z2UocGFnZSk7Cj4gK291dDoKPiArCXNwaW5fdW5sb2NrKCZkb21haW4tPmlvdGxiX2xvY2spOwo+
ICsKPiArCXJldHVybiBwYWdlOwo+ICt9Cj4gKwoKClsuLi5dCgoKPiArCj4gK3N0YXRpYyBkbWFf
YWRkcl90Cj4gK3ZkdXNlX2RvbWFpbl9hbGxvY19pb3ZhKHN0cnVjdCBpb3ZhX2RvbWFpbiAqaW92
YWQsCj4gKwkJCXVuc2lnbmVkIGxvbmcgc2l6ZSwgdW5zaWduZWQgbG9uZyBsaW1pdCkKPiArewo+
ICsJdW5zaWduZWQgbG9uZyBzaGlmdCA9IGlvdmFfc2hpZnQoaW92YWQpOwo+ICsJdW5zaWduZWQg
bG9uZyBpb3ZhX2xlbiA9IGlvdmFfYWxpZ24oaW92YWQsIHNpemUpID4+IHNoaWZ0Owo+ICsJdW5z
aWduZWQgbG9uZyBpb3ZhX3BmbjsKPiArCj4gKwlpZiAoaW92YV9sZW4gPCAoMSA8PCAoSU9WQV9S
QU5HRV9DQUNIRV9NQVhfU0laRSAtIDEpKSkKPiArCQlpb3ZhX2xlbiA9IHJvdW5kdXBfcG93X29m
X3R3byhpb3ZhX2xlbik7CgoKTGV0J3MgYWRkIGEgY29tbWVudCBhcyB3aGF0IGhhcyBiZWVuIGRv
bmUgaW4gZG1hLWlvbW11LmM/CgooSW4gdGhlIGZ1dHVyZSwgaXQgbG9va3MgdG8gbWUgaXQncyBi
ZXR0ZXIgdG8gbW92ZSB0aGVtIHRvIAphbGxvY19pb3ZhX2Zhc3QoKSkuCgpUaGFua3MKCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
