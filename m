Return-Path: <SRS0=59V0=JE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA26EC433ED
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 04:00:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E272613B3
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 04:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E272613B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE7A640F52;
	Wed,  7 Apr 2021 04:00:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dc0W_R59bvwZ; Wed,  7 Apr 2021 04:00:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5311D40647;
	Wed,  7 Apr 2021 04:00:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BD92C000B;
	Wed,  7 Apr 2021 04:00:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98DABC000A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 04:00:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8553D405A6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 04:00:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AfFW6FZHe0mY
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 04:00:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C1AC6405A0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 04:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617768043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3DDn0FbN0a1PxN6pAjwQAfzrdMJl4mYrXvcXZOn54YQ=;
 b=HqYpd0yJ8SFz97T5LwFuP1fo96rGjrQahiwXAUPMy9p26wJAIoPNghuSNkKJDguMfBhucw
 lFw4q87dXJ0CiMweXT74nvSx+73BDOfGaukgn17UxtlC3k6wGHrBGAqFQse1OyASV9ul+G
 T/Sm7vJkpDJBJmknzsKDuTu/5ddIgVk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-36v0tyZ0OB-usdRkgJk00Q-1; Wed, 07 Apr 2021 00:00:40 -0400
X-MC-Unique: 36v0tyZ0OB-usdRkgJk00Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B706B107ACCD;
 Wed,  7 Apr 2021 04:00:38 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-69.pek2.redhat.com
 [10.72.12.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1DC945B4BF;
 Wed,  7 Apr 2021 04:00:33 +0000 (UTC)
Subject: Re: [PATCH linux-next v2 07/14] vdpa/mlx5: Use the correct dma device
 when registering memory
To: Parav Pandit <parav@nvidia.com>, virtualization@lists.linux-foundation.org
References: <20210406170457.98481-1-parav@nvidia.com>
 <20210406170457.98481-8-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9bbcc864-a350-62e8-0663-a426764f7f59@redhat.com>
Date: Wed, 7 Apr 2021 12:00:32 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210406170457.98481-8-parav@nvidia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: elic@nvidia.com, mst@redhat.com
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

CtTaIDIwMjEvNC83IMnPzucxOjA0LCBQYXJhdiBQYW5kaXQg0LS1wDoKPiBGcm9tOiBFbGkgQ29o
ZW4gPGVsaWNAbnZpZGlhLmNvbT4KPgo+IEluIGNhc2VzIHdoZXJlIHRoZSB2ZHBhIGluc3RhbmNl
IHVzZXMgYSBTRiAoc3ViIGZ1bmN0aW9uKSwgdGhlIERNQQo+IGRldmljZSBpcyB0aGUgcGFyZW50
IGRldmljZS4gVXNlIGEgZnVuY3Rpb24gdG8gcmV0cmlldmUgdGhlIGNvcnJlY3QgRE1BCj4gZGV2
aWNlLgo+Cj4gU2lnbmVkLW9mZi1ieTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+Cj4gUmV2
aWV3ZWQtYnk6IFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZpZGlhLmNvbT4KCgpBY2tlZC1ieTogSmFz
b24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+IGNoYW5nZWxvZzoKPiB2MS0+
djI6Cj4gICAtIG5ldyBwYXRjaAo+IC0tLQo+ICAgZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5j
IHwgOSArKysrKysrLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jIGIv
ZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jCj4gaW5kZXggZDMwMGY3OTllZmNkLi4zOTA4ZmYy
OGVlYzAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jCj4gKysrIGIv
ZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jCj4gQEAgLTIxOSw2ICsyMTksMTEgQEAgc3RhdGlj
IHZvaWQgZGVzdHJveV9pbmRpcmVjdF9rZXkoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCBz
dHJ1Y3QgbWx4NV92ZHBhX20KPiAgIAltbHg1X3ZkcGFfZGVzdHJveV9ta2V5KG12ZGV2LCAmbWtl
eS0+bWtleSk7Cj4gICB9Cj4gICAKPiArc3RhdGljIHN0cnVjdCBkZXZpY2UgKmdldF9kbWFfZGV2
aWNlKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldikKPiArewo+ICsJcmV0dXJuICZtdmRldi0+
bWRldi0+cGRldi0+ZGV2Owo+ICt9Cj4gKwo+ICAgc3RhdGljIGludCBtYXBfZGlyZWN0X21yKHN0
cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgc3RydWN0IG1seDVfdmRwYV9kaXJlY3RfbXIgKm1y
LAo+ICAgCQkJIHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIpCj4gICB7Cj4gQEAgLTIzNCw3ICsy
MzksNyBAQCBzdGF0aWMgaW50IG1hcF9kaXJlY3RfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12
ZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX2RpcmVjdF9tcgo+ICAgCXU2NCBwYTsKPiAgIAl1NjQgcGFl
bmQ7Cj4gICAJc3RydWN0IHNjYXR0ZXJsaXN0ICpzZzsKPiAtCXN0cnVjdCBkZXZpY2UgKmRtYSA9
IG12ZGV2LT5tZGV2LT5kZXZpY2U7Cj4gKwlzdHJ1Y3QgZGV2aWNlICpkbWEgPSBnZXRfZG1hX2Rl
dmljZShtdmRldik7Cj4gICAKPiAgIAlmb3IgKG1hcCA9IHZob3N0X2lvdGxiX2l0cmVlX2ZpcnN0
KGlvdGxiLCBtci0+c3RhcnQsIG1yLT5lbmQgLSAxKTsKPiAgIAkgICAgIG1hcDsgbWFwID0gdmhv
c3RfaW90bGJfaXRyZWVfbmV4dChtYXAsIHN0YXJ0LCBtci0+ZW5kIC0gMSkpIHsKPiBAQCAtMjkx
LDcgKzI5Niw3IEBAIHN0YXRpYyBpbnQgbWFwX2RpcmVjdF9tcihzdHJ1Y3QgbWx4NV92ZHBhX2Rl
diAqbXZkZXYsIHN0cnVjdCBtbHg1X3ZkcGFfZGlyZWN0X21yCj4gICAKPiAgIHN0YXRpYyB2b2lk
IHVubWFwX2RpcmVjdF9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHN0cnVjdCBtbHg1
X3ZkcGFfZGlyZWN0X21yICptcikKPiAgIHsKPiAtCXN0cnVjdCBkZXZpY2UgKmRtYSA9IG12ZGV2
LT5tZGV2LT5kZXZpY2U7Cj4gKwlzdHJ1Y3QgZGV2aWNlICpkbWEgPSBnZXRfZG1hX2RldmljZSht
dmRldik7Cj4gICAKPiAgIAlkZXN0cm95X2RpcmVjdF9tcihtdmRldiwgbXIpOwo+ICAgCWRtYV91
bm1hcF9zZ19hdHRycyhkbWEsIG1yLT5zZ19oZWFkLnNnbCwgbXItPm5zZywgRE1BX0JJRElSRUNU
SU9OQUwsIDApOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
