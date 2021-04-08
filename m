Return-Path: <SRS0=B6Di=JF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FDCC43461
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 09:45:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B11F61207
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 09:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B11F61207
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0DAE9400E6;
	Thu,  8 Apr 2021 09:45:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kdOB81Ofn1Nc; Thu,  8 Apr 2021 09:45:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id B14CD4041A;
	Thu,  8 Apr 2021 09:45:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E697C000B;
	Thu,  8 Apr 2021 09:45:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38D11C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 09:45:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2680C60D9C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 09:45:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SWiqsP7CcF7B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 09:45:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 48C3260A4A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 09:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617875109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=42x2upVyYod6eEZwxNE9tSmc24Wlu+lcP45ZijnXyiM=;
 b=ismgqzQiAIC9YhpOzolOfDmYP3se6TRniQXKI+aYCfqni6t5peI1RuH+VNTwyiKAgkGNWn
 4aDSlXMS02Z5o8d3Ib2247Tg9rkPrqKwWD/xu51Dc53iunXYtT+BeLwriPxMayxEIWX+/n
 SaQ/PIhW+5EYU19aAghoNydvUoPblIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-PX7V1EInNKmfGvDHRpwAKA-1; Thu, 08 Apr 2021 05:45:01 -0400
X-MC-Unique: PX7V1EInNKmfGvDHRpwAKA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 550078189C6;
 Thu,  8 Apr 2021 09:44:55 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-53.pek2.redhat.com
 [10.72.13.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 768E65D71D;
 Thu,  8 Apr 2021 09:44:49 +0000 (UTC)
Subject: Re: [PATCH 2/5] vdpa/mlx5: Use the correct dma device when
 registering memory
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, parav@nvidia.com,
 si-wei.liu@oracle.com, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org
References: <20210408091047.4269-1-elic@nvidia.com>
 <20210408091047.4269-3-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <37f7982a-d065-1c2e-abcf-00e9fbc5732a@redhat.com>
Date: Thu, 8 Apr 2021 17:44:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210408091047.4269-3-elic@nvidia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: stable@vger.kernel.org
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

CtTaIDIwMjEvNC84IM/Czuc1OjEwLCBFbGkgQ29oZW4g0LS1wDoKPiBJbiBjYXNlcyB3aGVyZSB0
aGUgdmRwYSBpbnN0YW5jZSB1c2VzIGEgU0YgKHN1YiBmdW5jdGlvbiksIHRoZSBETUEKPiBkZXZp
Y2UgaXMgdGhlIHBhcmVudCBkZXZpY2UuIFVzZSBhIGZ1bmN0aW9uIHRvIHJldHJpZXZlIHRoZSBj
b3JyZWN0IERNQQo+IGRldmljZS4KPgo+IEZpeGVzOiAxOTU4ZmMyZjA3MTIgKCJuZXQvbWx4NTog
U0YsIEFkZCBhdXhpbGlhcnkgZGV2aWNlIGRyaXZlciIpCj4gU2lnbmVkLW9mZi1ieTogRWxpIENv
aGVuIDxlbGljQG52aWRpYS5jb20+Cj4gUmV2aWV3ZWQtYnk6IFBhcmF2IFBhbmRpdCA8cGFyYXZA
bnZpZGlhLmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4K
Cgo+IC0tLQo+ICAgZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jIHwgOSArKysrKysrLS0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jIGIvZHJpdmVycy92ZHBhL21seDUv
Y29yZS9tci5jCj4gaW5kZXggZDMwMGY3OTllZmNkLi4zOTA4ZmYyOGVlYzAgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jCj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUv
Y29yZS9tci5jCj4gQEAgLTIxOSw2ICsyMTksMTEgQEAgc3RhdGljIHZvaWQgZGVzdHJveV9pbmRp
cmVjdF9rZXkoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX20K
PiAgIAltbHg1X3ZkcGFfZGVzdHJveV9ta2V5KG12ZGV2LCAmbWtleS0+bWtleSk7Cj4gICB9Cj4g
ICAKPiArc3RhdGljIHN0cnVjdCBkZXZpY2UgKmdldF9kbWFfZGV2aWNlKHN0cnVjdCBtbHg1X3Zk
cGFfZGV2ICptdmRldikKPiArewo+ICsJcmV0dXJuICZtdmRldi0+bWRldi0+cGRldi0+ZGV2Owo+
ICt9Cj4gKwo+ICAgc3RhdGljIGludCBtYXBfZGlyZWN0X21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2
ICptdmRldiwgc3RydWN0IG1seDVfdmRwYV9kaXJlY3RfbXIgKm1yLAo+ICAgCQkJIHN0cnVjdCB2
aG9zdF9pb3RsYiAqaW90bGIpCj4gICB7Cj4gQEAgLTIzNCw3ICsyMzksNyBAQCBzdGF0aWMgaW50
IG1hcF9kaXJlY3RfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCBzdHJ1Y3QgbWx4NV92
ZHBhX2RpcmVjdF9tcgo+ICAgCXU2NCBwYTsKPiAgIAl1NjQgcGFlbmQ7Cj4gICAJc3RydWN0IHNj
YXR0ZXJsaXN0ICpzZzsKPiAtCXN0cnVjdCBkZXZpY2UgKmRtYSA9IG12ZGV2LT5tZGV2LT5kZXZp
Y2U7Cj4gKwlzdHJ1Y3QgZGV2aWNlICpkbWEgPSBnZXRfZG1hX2RldmljZShtdmRldik7Cj4gICAK
PiAgIAlmb3IgKG1hcCA9IHZob3N0X2lvdGxiX2l0cmVlX2ZpcnN0KGlvdGxiLCBtci0+c3RhcnQs
IG1yLT5lbmQgLSAxKTsKPiAgIAkgICAgIG1hcDsgbWFwID0gdmhvc3RfaW90bGJfaXRyZWVfbmV4
dChtYXAsIHN0YXJ0LCBtci0+ZW5kIC0gMSkpIHsKPiBAQCAtMjkxLDcgKzI5Niw3IEBAIHN0YXRp
YyBpbnQgbWFwX2RpcmVjdF9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHN0cnVjdCBt
bHg1X3ZkcGFfZGlyZWN0X21yCj4gICAKPiAgIHN0YXRpYyB2b2lkIHVubWFwX2RpcmVjdF9tcihz
dHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHN0cnVjdCBtbHg1X3ZkcGFfZGlyZWN0X21yICpt
cikKPiAgIHsKPiAtCXN0cnVjdCBkZXZpY2UgKmRtYSA9IG12ZGV2LT5tZGV2LT5kZXZpY2U7Cj4g
KwlzdHJ1Y3QgZGV2aWNlICpkbWEgPSBnZXRfZG1hX2RldmljZShtdmRldik7Cj4gICAKPiAgIAlk
ZXN0cm95X2RpcmVjdF9tcihtdmRldiwgbXIpOwo+ICAgCWRtYV91bm1hcF9zZ19hdHRycyhkbWEs
IG1yLT5zZ19oZWFkLnNnbCwgbXItPm5zZywgRE1BX0JJRElSRUNUSU9OQUwsIDApOwoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
