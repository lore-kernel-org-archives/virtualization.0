Return-Path: <SRS0=dJY/=FV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D882C4361B
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 04:30:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F19F22376F
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 04:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F19F22376F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 87CF9874E3;
	Thu, 17 Dec 2020 04:30:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4AxCRsHHq-vF; Thu, 17 Dec 2020 04:30:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EC3D4874D2;
	Thu, 17 Dec 2020 04:30:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2EDEC088E;
	Thu, 17 Dec 2020 04:30:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6243BC013B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 04:30:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4E09C87851
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 04:30:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mwEsCWVB4pjA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 04:30:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2244C8784E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 04:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608179406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QdO71qRUUAyY5eL/yMHU3bjLmoNw6kNHGPr/hpOtBbg=;
 b=IWr9G7ZJWvokZ1lXLR6f1/FZW1Hn7Bi18OIzgpWKRSobjjy0TcBnHdYcF8rfyHStuppqVs
 sUHQEUYczPNUF52P4gkb+9nkTmKG6XyKEID1Q+CAVyWXSZML+gljyXGnzLYXhckxbpj2Wy
 SrLdw3KbWIkXGuyOKAvlo1dAGPKPRdY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-ZG7HCQpgMceVHl9ij-eGrQ-1; Wed, 16 Dec 2020 23:30:02 -0500
X-MC-Unique: ZG7HCQpgMceVHl9ij-eGrQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E65A6100F340;
 Thu, 17 Dec 2020 04:30:00 +0000 (UTC)
Received: from [10.72.12.223] (ovpn-12-223.pek2.redhat.com [10.72.12.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2210F19814;
 Thu, 17 Dec 2020 04:29:49 +0000 (UTC)
Subject: Re: [PATCH v4 04/18] vdpa_sim: make IOTLB entries limit configurable
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20201215144256.155342-1-sgarzare@redhat.com>
 <20201215144256.155342-5-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <648d7b72-134c-0dfb-8d91-8c2eda51e86c@redhat.com>
Date: Thu, 17 Dec 2020 12:29:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201215144256.155342-5-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel@vger.kernel.org, Shahaf Shuler <shahafs@nvidia.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>,
 Oren Duer <oren@nvidia.com>
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

Ck9uIDIwMjAvMTIvMTUg5LiL5Y2IMTA6NDIsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiBT
b21lIGRldmljZXMgbWF5IHJlcXVpcmUgYSBoaWdoZXIgbGltaXQgZm9yIHRoZSBudW1iZXIgb2Yg
SU9UTEIKPiBlbnRyaWVzLCBzbyBsZXQncyBtYWtlIGl0IGNvbmZpZ3VyYWJsZSB0aHJvdWdoIGEg
bW9kdWxlIHBhcmFtZXRlci4KPgo+IEJ5IGRlZmF1bHQsIGl0J3MgaW5pdGlhbGl6ZWQgd2l0aCB0
aGUgY3VycmVudCBsaW1pdCAoMjA0OCkuCj4KPiBTdWdnZXN0ZWQtYnk6IEphc29uIFdhbmcgPGph
c293YW5nQHJlZGhhdC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxz
Z2FyemFyZUByZWRoYXQuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPgoKCj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYyB8IDcg
KysrKysrLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jIGIvZHJp
dmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPiBpbmRleCAwN2NjYzg2MDk3ODQuLmQ3MTZi
ZmFhZGIzYiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+
ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4gQEAgLTMxLDYgKzMxLDEx
IEBAIHN0YXRpYyBpbnQgYmF0Y2hfbWFwcGluZyA9IDE7Cj4gICBtb2R1bGVfcGFyYW0oYmF0Y2hf
bWFwcGluZywgaW50LCAwNDQ0KTsKPiAgIE1PRFVMRV9QQVJNX0RFU0MoYmF0Y2hfbWFwcGluZywg
IkJhdGNoZWQgbWFwcGluZyAxIC1FbmFibGU7IDAgLSBEaXNhYmxlIik7Cj4gICAKPiArc3RhdGlj
IGludCBtYXhfaW90bGJfZW50cmllcyA9IDIwNDg7Cj4gK21vZHVsZV9wYXJhbShtYXhfaW90bGJf
ZW50cmllcywgaW50LCAwNDQ0KTsKPiArTU9EVUxFX1BBUk1fREVTQyhtYXhfaW90bGJfZW50cmll
cywKPiArCQkgIk1heGltdW0gbnVtYmVyIG9mIGlvdGxiIGVudHJpZXMuIDAgbWVhbnMgdW5saW1p
dGVkLiAoZGVmYXVsdDogMjA0OCkiKTsKPiArCj4gICBzdGF0aWMgY2hhciAqbWFjYWRkcjsKPiAg
IG1vZHVsZV9wYXJhbShtYWNhZGRyLCBjaGFycCwgMCk7Cj4gICBNT0RVTEVfUEFSTV9ERVNDKG1h
Y2FkZHIsICJFdGhlcm5ldCBNQUMgYWRkcmVzcyIpOwo+IEBAIC0zNzEsNyArMzc2LDcgQEAgc3Rh
dGljIHN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltX2NyZWF0ZSh2b2lkKQo+ICAgCWlmICghdmRwYXNp
bS0+dnFzKQo+ICAgCQlnb3RvIGVycl9pb21tdTsKPiAgIAo+IC0JdmRwYXNpbS0+aW9tbXUgPSB2
aG9zdF9pb3RsYl9hbGxvYygyMDQ4LCAwKTsKPiArCXZkcGFzaW0tPmlvbW11ID0gdmhvc3RfaW90
bGJfYWxsb2MobWF4X2lvdGxiX2VudHJpZXMsIDApOwo+ICAgCWlmICghdmRwYXNpbS0+aW9tbXUp
Cj4gICAJCWdvdG8gZXJyX2lvbW11Owo+ICAgCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
