Return-Path: <SRS0=wNjl=IW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7D5C433DB
	for <virtualization@archiver.kernel.org>; Wed, 24 Mar 2021 04:46:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E035C60201
	for <virtualization@archiver.kernel.org>; Wed, 24 Mar 2021 04:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E035C60201
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9CCC260A5B;
	Wed, 24 Mar 2021 04:46:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ESWGgqdJTY-O; Wed, 24 Mar 2021 04:46:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3A2BE606F7;
	Wed, 24 Mar 2021 04:46:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2869C000E;
	Wed, 24 Mar 2021 04:46:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90124C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 04:45:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 82D7540632
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 04:45:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I-xFp4WTu5ZL
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 04:45:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 79AE440631
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 04:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616561157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wHehOERrAJPJrkG9TfBBSJhEhdYmMieQY+5EDb8k3i4=;
 b=AL13FeS79mi6SmIC3Jff+MvztAQ3Gq05rOiwSBxbHhgUIwJK3WbLiLFIzwyl+1BH1Nm6ET
 sCmRvTcSbhYA5HlDo1cehLx8Buwx2v9A4gaixKEW44n21Gwwjov0zAAaj7cbwt45Q5QjiA
 1gTQehybyS3d/o/9VjssoZ7OTQVhPXM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-SfJEFJOPPBi6Wzkb3Ah2iA-1; Wed, 24 Mar 2021 00:45:53 -0400
X-MC-Unique: SfJEFJOPPBi6Wzkb3Ah2iA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7E20107ACCD;
 Wed, 24 Mar 2021 04:45:51 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-134.pek2.redhat.com
 [10.72.12.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D6F35D9CA;
 Wed, 24 Mar 2021 04:45:37 +0000 (UTC)
Subject: Re: [PATCH v5 10/11] vduse: Add config interrupt support
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 bob.liu@oracle.com, hch@infradead.org, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com
References: <20210315053721.189-1-xieyongji@bytedance.com>
 <20210315053721.189-11-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9a2835b1-1f0e-5646-6c77-524e6ccdc613@redhat.com>
Date: Wed, 24 Mar 2021 12:45:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210315053721.189-11-xieyongji@bytedance.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

CtTaIDIwMjEvMy8xNSDPws7nMTozNywgWGllIFlvbmdqaSDQtLXAOgo+IFRoaXMgcGF0Y2ggaW50
cm9kdWNlcyBhIG5ldyBpb2N0bCBWRFVTRV9JTkpFQ1RfQ09ORklHX0lSUQo+IHRvIHN1cHBvcnQg
aW5qZWN0aW5nIGNvbmZpZyBpbnRlcnJ1cHQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9uZ2pp
IDx4aWV5b25namlAYnl0ZWRhbmNlLmNvbT4KCgpJIHN1Z2dlc3QgdG8gc3F1YXNoIHRoaXMgaW50
byBwYXRoIDkuCgpPdGhlciBsb29rcyBnb29kLgoKVGhhbmtzCgoKPiAtLS0KPiAgIGRyaXZlcnMv
dmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMgfCAyNCArKysrKysrKysrKysrKysrKysrKysrKy0K
PiAgIGluY2x1ZGUvdWFwaS9saW51eC92ZHVzZS5oICAgICAgICAgfCAgMyArKysKPiAgIDIgZmls
ZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMgYi9kcml2ZXJzL3ZkcGEvdmRw
YV91c2VyL3ZkdXNlX2Rldi5jCj4gaW5kZXggMDdkMGFlOTJkNDcwLi5jYzEyYjU4YmRjMDkgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYwo+ICsrKyBiL2Ry
aXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMKPiBAQCAtNjQsNiArNjQsOCBAQCBzdHJ1
Y3QgdmR1c2VfZGV2IHsKPiAgIAlzdHJ1Y3QgbGlzdF9oZWFkIHNlbmRfbGlzdDsKPiAgIAlzdHJ1
Y3QgbGlzdF9oZWFkIHJlY3ZfbGlzdDsKPiAgIAlzdHJ1Y3QgbGlzdF9oZWFkIGxpc3Q7Cj4gKwlz
dHJ1Y3QgdmRwYV9jYWxsYmFjayBjb25maWdfY2I7Cj4gKwlzcGlubG9ja190IGlycV9sb2NrOwo+
ICAgCWJvb2wgY29ubmVjdGVkOwo+ICAgCWludCBtaW5vcjsKPiAgIAl1MTYgdnFfc2l6ZV9tYXg7
Cj4gQEAgLTQzOSw2ICs0NDEsMTEgQEAgc3RhdGljIHZvaWQgdmR1c2VfZGV2X3Jlc2V0KHN0cnVj
dCB2ZHVzZV9kZXYgKmRldikKPiAgIAl2ZHVzZV9kb21haW5fcmVzZXRfYm91bmNlX21hcChkZXYt
PmRvbWFpbik7Cj4gICAJdmR1c2VfZGV2X3VwZGF0ZV9pb3RsYihkZXYsIDBVTEwsIFVMTE9OR19N
QVgpOwo+ICAgCj4gKwlzcGluX2xvY2soJmRldi0+aXJxX2xvY2spOwo+ICsJZGV2LT5jb25maWdf
Y2IuY2FsbGJhY2sgPSBOVUxMOwo+ICsJZGV2LT5jb25maWdfY2IucHJpdmF0ZSA9IE5VTEw7Cj4g
KwlzcGluX3VubG9jaygmZGV2LT5pcnFfbG9jayk7Cj4gKwo+ICAgCWZvciAoaSA9IDA7IGkgPCBk
ZXYtPnZxX251bTsgaSsrKSB7Cj4gICAJCXN0cnVjdCB2ZHVzZV92aXJ0cXVldWUgKnZxID0gJmRl
di0+dnFzW2ldOwo+ICAgCj4gQEAgLTU1Nyw3ICs1NjQsMTIgQEAgc3RhdGljIGludCB2ZHVzZV92
ZHBhX3NldF9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEsIHU2NCBmZWF0dXJlcykK
PiAgIHN0YXRpYyB2b2lkIHZkdXNlX3ZkcGFfc2V0X2NvbmZpZ19jYihzdHJ1Y3QgdmRwYV9kZXZp
Y2UgKnZkcGEsCj4gICAJCQkJICBzdHJ1Y3QgdmRwYV9jYWxsYmFjayAqY2IpCj4gICB7Cj4gLQkv
KiBXZSBkb24ndCBzdXBwb3J0IGNvbmZpZyBpbnRlcnJ1cHQgKi8KPiArCXN0cnVjdCB2ZHVzZV9k
ZXYgKmRldiA9IHZkcGFfdG9fdmR1c2UodmRwYSk7Cj4gKwo+ICsJc3Bpbl9sb2NrKCZkZXYtPmly
cV9sb2NrKTsKPiArCWRldi0+Y29uZmlnX2NiLmNhbGxiYWNrID0gY2ItPmNhbGxiYWNrOwo+ICsJ
ZGV2LT5jb25maWdfY2IucHJpdmF0ZSA9IGNiLT5wcml2YXRlOwo+ICsJc3Bpbl91bmxvY2soJmRl
di0+aXJxX2xvY2spOwo+ICAgfQo+ICAgCj4gICBzdGF0aWMgdTE2IHZkdXNlX3ZkcGFfZ2V0X3Zx
X251bV9tYXgoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhKQo+IEBAIC04NDIsNiArODU0LDE1IEBA
IHN0YXRpYyBsb25nIHZkdXNlX2Rldl9pb2N0bChzdHJ1Y3QgZmlsZSAqZmlsZSwgdW5zaWduZWQg
aW50IGNtZCwKPiAgIAkJcmV0ID0gMDsKPiAgIAkJcXVldWVfd29yayh2ZHVzZV9pcnFfd3EsICZk
ZXYtPnZxc1thcmddLmluamVjdCk7Cj4gICAJCWJyZWFrOwo+ICsJY2FzZSBWRFVTRV9JTkpFQ1Rf
Q09ORklHX0lSUToKPiArCQlyZXQgPSAtRUlOVkFMOwo+ICsJCXNwaW5fbG9ja19pcnEoJmRldi0+
aXJxX2xvY2spOwo+ICsJCWlmIChkZXYtPmNvbmZpZ19jYi5jYWxsYmFjaykgewo+ICsJCQlkZXYt
PmNvbmZpZ19jYi5jYWxsYmFjayhkZXYtPmNvbmZpZ19jYi5wcml2YXRlKTsKPiArCQkJcmV0ID0g
MDsKPiArCQl9Cj4gKwkJc3Bpbl91bmxvY2tfaXJxKCZkZXYtPmlycV9sb2NrKTsKPiArCQlicmVh
azsKPiAgIAlkZWZhdWx0Ogo+ICAgCQlyZXQgPSAtRU5PSU9DVExDTUQ7Cj4gICAJCWJyZWFrOwo+
IEBAIC05MTgsNiArOTM5LDcgQEAgc3RhdGljIHN0cnVjdCB2ZHVzZV9kZXYgKnZkdXNlX2Rldl9j
cmVhdGUodm9pZCkKPiAgIAlJTklUX0xJU1RfSEVBRCgmZGV2LT5zZW5kX2xpc3QpOwo+ICAgCUlO
SVRfTElTVF9IRUFEKCZkZXYtPnJlY3ZfbGlzdCk7Cj4gICAJYXRvbWljNjRfc2V0KCZkZXYtPm1z
Z191bmlxdWUsIDApOwo+ICsJc3Bpbl9sb2NrX2luaXQoJmRldi0+aXJxX2xvY2spOwo+ICAgCj4g
ICAJaW5pdF93YWl0cXVldWVfaGVhZCgmZGV2LT53YWl0cSk7Cj4gICAKPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS91YXBpL2xpbnV4L3ZkdXNlLmggYi9pbmNsdWRlL3VhcGkvbGludXgvdmR1c2UuaAo+
IGluZGV4IDM3ZjdkNzA1OWFhOC4uMzM3ZTc2NmY1NjIyIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUv
dWFwaS9saW51eC92ZHVzZS5oCj4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZkdXNlLmgKPiBA
QCAtMTUwLDQgKzE1MCw3IEBAIHN0cnVjdCB2ZHVzZV92cV9ldmVudGZkIHsKPiAgIC8qIEluamVj
dCBhbiBpbnRlcnJ1cHQgZm9yIHNwZWNpZmljIHZpcnRxdWV1ZSAqLwo+ICAgI2RlZmluZSBWRFVT
RV9JTkpFQ1RfVlFfSVJRCV9JTyhWRFVTRV9CQVNFLCAweDA1KQo+ICAgCj4gKy8qIEluamVjdCBh
IGNvbmZpZyBpbnRlcnJ1cHQgKi8KPiArI2RlZmluZSBWRFVTRV9JTkpFQ1RfQ09ORklHX0lSUQlf
SU8oVkRVU0VfQkFTRSwgMHgwNikKPiArCj4gICAjZW5kaWYgLyogX1VBUElfVkRVU0VfSF8gKi8K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
