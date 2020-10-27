Return-Path: <SRS0=a9Wa=EC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285B6C4363A
	for <virtualization@archiver.kernel.org>; Tue, 27 Oct 2020 02:44:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92DA520872
	for <virtualization@archiver.kernel.org>; Tue, 27 Oct 2020 02:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVamtyBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92DA520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 227F2203F2;
	Tue, 27 Oct 2020 02:44:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6+Rg12AbVqEA; Tue, 27 Oct 2020 02:44:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 711161FFC1;
	Tue, 27 Oct 2020 02:44:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FEAEC0859;
	Tue, 27 Oct 2020 02:44:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95BE9C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Oct 2020 02:44:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 78AFF85B2F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Oct 2020 02:44:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ckIykOCGe-GU
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Oct 2020 02:44:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8233985B0D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Oct 2020 02:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603766688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+oPgZQ9kwH3Dhos275y17fQzttSlkylt7q9lLolsmfA=;
 b=CVamtyBPyV04smcjE9sjABzOPWyzzjDor/ndOdEKby699p0A1I1/TsMtx+MpHxpTSFyXOU
 2PWrWtJA6SPE5tVsDsP2puJjdpRYy55mk1n+eRiNS0ZURbjeeerZELA+2FI8UFVgRGHBE0
 CZp+FqrUA9vaMAuLvfh3vonZ1lButNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-c6rnTZ4DMlqFQsDprG0VmQ-1; Mon, 26 Oct 2020 22:44:43 -0400
X-MC-Unique: c6rnTZ4DMlqFQsDprG0VmQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6935F186DD2E;
 Tue, 27 Oct 2020 02:44:42 +0000 (UTC)
Received: from [10.72.13.117] (ovpn-13-117.pek2.redhat.com [10.72.13.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D146F62A0B;
 Tue, 27 Oct 2020 02:44:25 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: Fix error return in map_direct_mr()
To: Jing Xiangfeng <jingxiangfeng@huawei.com>, mst@redhat.com,
 eli@mellanox.com, parav@mellanox.com, alex.dewar@gmx.co.uk
References: <20201026070637.164321-1-jingxiangfeng@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8e37340d-2b4f-caaf-3277-32a697b2d204@redhat.com>
Date: Tue, 27 Oct 2020 10:44:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201026070637.164321-1-jingxiangfeng@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjAvMTAvMjYg5LiL5Y2IMzowNiwgSmluZyBYaWFuZ2Zlbmcgd3JvdGU6Cj4gRml4IHRv
IHJldHVybiB0aGUgdmFyaWFibGUgImVyciIgZnJvbSB0aGUgZXJyb3IgaGFuZGxpbmcgY2FzZSBp
bnN0ZWFkCj4gb2YgInJldCIuCj4KPiBGaXhlczogOTRhYmJjY2RmMjkxICgidmRwYS9tbHg1OiBB
ZGQgc2hhcmVkIG1lbW9yeSByZWdpc3RyYXRpb24gY29kZSIpCj4gU2lnbmVkLW9mZi1ieTogSmlu
ZyBYaWFuZ2ZlbmcgPGppbmd4aWFuZ2ZlbmdAaHVhd2VpLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMv
dmRwYS9tbHg1L2NvcmUvbXIuYyB8IDUgKystLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21s
eDUvY29yZS9tci5jIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jCj4gaW5kZXggZWYxYzU1
MGY4MjY2Li40YjYxOTU2NjZjNTggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvY29y
ZS9tci5jCj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jCj4gQEAgLTIzOSw3ICsy
MzksNiBAQCBzdGF0aWMgaW50IG1hcF9kaXJlY3RfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12
ZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX2RpcmVjdF9tcgo+ICAgCXU2NCBwYWVuZDsKPiAgIAlzdHJ1
Y3Qgc2NhdHRlcmxpc3QgKnNnOwo+ICAgCXN0cnVjdCBkZXZpY2UgKmRtYSA9IG12ZGV2LT5tZGV2
LT5kZXZpY2U7Cj4gLQlpbnQgcmV0Owo+ICAgCj4gICAJZm9yIChtYXAgPSB2aG9zdF9pb3RsYl9p
dHJlZV9maXJzdChpb3RsYiwgbXItPnN0YXJ0LCBtci0+ZW5kIC0gMSk7Cj4gICAJICAgICBtYXA7
IG1hcCA9IHZob3N0X2lvdGxiX2l0cmVlX25leHQobWFwLCBzdGFydCwgbXItPmVuZCAtIDEpKSB7
Cj4gQEAgLTI3Nyw4ICsyNzYsOCBAQCBzdGF0aWMgaW50IG1hcF9kaXJlY3RfbXIoc3RydWN0IG1s
eDVfdmRwYV9kZXYgKm12ZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX2RpcmVjdF9tcgo+ICAgZG9uZToK
PiAgIAltci0+bG9nX3NpemUgPSBsb2dfZW50aXR5X3NpemU7Cj4gICAJbXItPm5zZyA9IG5zZzsK
PiAtCXJldCA9IGRtYV9tYXBfc2dfYXR0cnMoZG1hLCBtci0+c2dfaGVhZC5zZ2wsIG1yLT5uc2cs
IERNQV9CSURJUkVDVElPTkFMLCAwKTsKPiAtCWlmICghcmV0KQo+ICsJZXJyID0gZG1hX21hcF9z
Z19hdHRycyhkbWEsIG1yLT5zZ19oZWFkLnNnbCwgbXItPm5zZywgRE1BX0JJRElSRUNUSU9OQUws
IDApOwo+ICsJaWYgKCFlcnIpCj4gICAJCWdvdG8gZXJyX21hcDsKPiAgIAo+ICAgCWVyciA9IGNy
ZWF0ZV9kaXJlY3RfbXIobXZkZXYsIG1yKTsKCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dh
bmdAcmVkaGF0LmNvbT4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
