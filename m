Return-Path: <SRS0=LnXi=IA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83D2C433DB
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 06:51:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2967F614A7
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 06:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2967F614A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ACE6D4EC21;
	Tue,  2 Mar 2021 06:50:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4rIC1K5A75nk; Tue,  2 Mar 2021 06:50:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B3554EC8E;
	Tue,  2 Mar 2021 06:50:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E822BC000B;
	Tue,  2 Mar 2021 06:50:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30C27C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 06:50:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2CBF743015
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 06:50:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uqW_RE6JcUQi
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 06:50:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6DDE142FDF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 06:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614667854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pw0+OpAgN2cuqHokScOT5T0Eyke5jNWE452MsWUrx9k=;
 b=X7ObH80gtVnum4cKQSdI2cRhHE9uYpAO2rf+n6lG7o+O03Z9Y7YBzXw1WEoXCUj00IHza2
 LQRWAc0zdw+HDawkHM33XCYqzGcy4qWpm9qOpvdJX49IfPqF3/KaVfXhHCRNCIxH1Eqm+c
 zp1pWEBXqkto+694E6QAmT5GnqmIvZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-iDdTdt3lNCipFcnOqlRw-g-1; Tue, 02 Mar 2021 01:50:52 -0500
X-MC-Unique: iDdTdt3lNCipFcnOqlRw-g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48CC8193578B;
 Tue,  2 Mar 2021 06:50:50 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-133.pek2.redhat.com
 [10.72.12.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D86105D766;
 Tue,  2 Mar 2021 06:50:38 +0000 (UTC)
Subject: Re: [RFC v4 04/11] vdpa: Add an opaque pointer for
 vdpa_config_ops.dma_map()
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 bob.liu@oracle.com, hch@infradead.org, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net
References: <20210223115048.435-1-xieyongji@bytedance.com>
 <20210223115048.435-5-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <977e44fe-63ec-a695-11a5-d7c584124294@redhat.com>
Date: Tue, 2 Mar 2021 14:50:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210223115048.435-5-xieyongji@bytedance.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: linux-aio@kvack.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjEvMi8yMyA3OjUwIOS4i+WNiCwgWGllIFlvbmdqaSB3cm90ZToKPiBBZGQgYW4gb3Bh
cXVlIHBvaW50ZXIgZm9yIERNQSBtYXBwaW5nLgo+Cj4gU3VnZ2VzdGVkLWJ5OiBKYXNvbiBXYW5n
IDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFhpZSBZb25namkgPHhpZXlv
bmdqaUBieXRlZGFuY2UuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPgoKCj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYyB8IDYg
KysrLS0tCj4gICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyAgICAgICAgICAgICB8IDIgKy0KPiAgIGlu
Y2x1ZGUvbGludXgvdmRwYS5oICAgICAgICAgICAgIHwgMiArLQo+ICAgMyBmaWxlcyBjaGFuZ2Vk
LCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9z
aW0uYwo+IGluZGV4IGQ1OTQyODQyNDMyZC4uNWNmYzI2MmNlMDU1IDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFf
c2ltL3ZkcGFfc2ltLmMKPiBAQCAtNTEyLDE0ICs1MTIsMTQgQEAgc3RhdGljIGludCB2ZHBhc2lt
X3NldF9tYXAoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhLAo+ICAgfQo+ICAgCj4gICBzdGF0aWMg
aW50IHZkcGFzaW1fZG1hX21hcChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEsIHU2NCBpb3ZhLCB1
NjQgc2l6ZSwKPiAtCQkJICAgdTY0IHBhLCB1MzIgcGVybSkKPiArCQkJICAgdTY0IHBhLCB1MzIg
cGVybSwgdm9pZCAqb3BhcXVlKQo+ICAgewo+ICAgCXN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltID0g
dmRwYV90b19zaW0odmRwYSk7Cj4gICAJaW50IHJldDsKPiAgIAo+ICAgCXNwaW5fbG9jaygmdmRw
YXNpbS0+aW9tbXVfbG9jayk7Cj4gLQlyZXQgPSB2aG9zdF9pb3RsYl9hZGRfcmFuZ2UodmRwYXNp
bS0+aW9tbXUsIGlvdmEsIGlvdmEgKyBzaXplIC0gMSwgcGEsCj4gLQkJCQkgICAgcGVybSk7Cj4g
KwlyZXQgPSB2aG9zdF9pb3RsYl9hZGRfcmFuZ2VfY3R4KHZkcGFzaW0tPmlvbW11LCBpb3ZhLCBp
b3ZhICsgc2l6ZSAtIDEsCj4gKwkJCQkJcGEsIHBlcm0sIG9wYXF1ZSk7Cj4gICAJc3Bpbl91bmxv
Y2soJnZkcGFzaW0tPmlvbW11X2xvY2spOwo+ICAgCj4gICAJcmV0dXJuIHJldDsKPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+IGluZGV4
IDU1MDBlM2JmMDVjMS4uNzA4NTdmZTMyNjNjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3Qv
dmRwYS5jCj4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiBAQCAtNTQ0LDcgKzU0NCw3IEBA
IHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9tYXAoc3RydWN0IHZob3N0X3ZkcGEgKnYsCj4gICAJCXJl
dHVybiByOwo+ICAgCj4gICAJaWYgKG9wcy0+ZG1hX21hcCkgewo+IC0JCXIgPSBvcHMtPmRtYV9t
YXAodmRwYSwgaW92YSwgc2l6ZSwgcGEsIHBlcm0pOwo+ICsJCXIgPSBvcHMtPmRtYV9tYXAodmRw
YSwgaW92YSwgc2l6ZSwgcGEsIHBlcm0sIE5VTEwpOwo+ICAgCX0gZWxzZSBpZiAob3BzLT5zZXRf
bWFwKSB7Cj4gICAJCWlmICghdi0+aW5fYmF0Y2gpCj4gICAJCQlyID0gb3BzLT5zZXRfbWFwKHZk
cGEsIGRldi0+aW90bGIpOwo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaCBiL2lu
Y2x1ZGUvbGludXgvdmRwYS5oCj4gaW5kZXggNGFiNTQ5NDUwM2E4Li45M2RjYTJjMzI4YWUgMTAw
NjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51eC92ZHBhLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L3Zk
cGEuaAo+IEBAIC0yNDEsNyArMjQxLDcgQEAgc3RydWN0IHZkcGFfY29uZmlnX29wcyB7Cj4gICAJ
LyogRE1BIG9wcyAqLwo+ICAgCWludCAoKnNldF9tYXApKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRl
diwgc3RydWN0IHZob3N0X2lvdGxiICppb3RsYik7Cj4gICAJaW50ICgqZG1hX21hcCkoc3RydWN0
IHZkcGFfZGV2aWNlICp2ZGV2LCB1NjQgaW92YSwgdTY0IHNpemUsCj4gLQkJICAgICAgIHU2NCBw
YSwgdTMyIHBlcm0pOwo+ICsJCSAgICAgICB1NjQgcGEsIHUzMiBwZXJtLCB2b2lkICpvcGFxdWUp
Owo+ICAgCWludCAoKmRtYV91bm1hcCkoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1NjQgaW92
YSwgdTY0IHNpemUpOwo+ICAgCj4gICAJLyogRnJlZSBkZXZpY2UgcmVzb3VyY2VzICovCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
