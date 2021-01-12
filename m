Return-Path: <SRS0=ALvA=GP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905CCC433DB
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 02:54:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2200022CAD
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 02:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2200022CAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BBB6622FB9;
	Tue, 12 Jan 2021 02:54:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pda7elcC-6Uz; Tue, 12 Jan 2021 02:54:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id ACE182049D;
	Tue, 12 Jan 2021 02:54:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93F1BC088B;
	Tue, 12 Jan 2021 02:54:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5591DC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 02:54:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4482A22EC9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 02:54:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D2rfsCE6ia4l
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 02:54:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 2839D2049D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 02:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610420043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hBNIZoVEFYnZolBPXDxQvsKxura8sTWXxEYo+kfOlYs=;
 b=cFXmGcYHNd0t2am0TZqWM+DQwdlLteKst4A3LNRpecda3PWWh+faEsix2j/a8Y2Xg1P9Hn
 OZZl/r+JaB4TXZSuAtx/cPZ4eg9rr2annuqcgr9pPXlAPCiUhWb9pKP0e6bUvULIdbAh1u
 nY2vaaqHzHIPsX/8sIpR2XUpRLy09C8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-NeFrT79jM9uRKsLdnRlk2A-1; Mon, 11 Jan 2021 21:54:02 -0500
X-MC-Unique: NeFrT79jM9uRKsLdnRlk2A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DAF0107ACF8;
 Tue, 12 Jan 2021 02:54:01 +0000 (UTC)
Received: from [10.72.12.225] (ovpn-12-225.pek2.redhat.com [10.72.12.225])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B3E094F3C6;
 Tue, 12 Jan 2021 02:53:56 +0000 (UTC)
Subject: Re: [PATCH] mlx5: vdpa: fix possible uninitialized var
To: Eli Cohen <elic@nvidia.com>
References: <20210108082443.5609-1-jasowang@redhat.com>
 <20210110063955.GA115874@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ae775c12-65d1-6623-be54-8d9e9be08fd0@redhat.com>
Date: Tue, 12 Jan 2021 10:53:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210110063955.GA115874@mtl-vdi-166.wap.labs.mlnx>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
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

Ck9uIDIwMjEvMS8xMCDkuIvljYgyOjM5LCBFbGkgQ29oZW4gd3JvdGU6Cj4gT24gRnJpLCBKYW4g
MDgsIDIwMjEgYXQgMDQ6MjQ6NDNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4gVXBzdHJl
YW06IHBvc3RlZAo+Pgo+PiBXaGVuIGNvbXBpbGluZyB3aXRoIC1XZXJyb3I9bWF5YmUtdW5pbml0
aWFsaXplZCwgZ2NjIG1heSBjb21wbGFpbnMgdGhlCj4+IHBvc3NpYmxlIHVuaW5pdGlhbGl6ZWQg
dW1lbS4gRml4IHRoYXQuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQu
YyB8IDMgKysrCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+Pgo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIGIvZHJpdmVycy92ZHBh
L21seDUvbmV0L21seDVfdm5ldC5jCj4+IGluZGV4IGYxZDU0ODE0ZGI5Ny4uYTZhZDgzZDhkOGUy
IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4gKysr
IGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+IEBAIC03MDYsNiArNzA2LDkg
QEAgc3RhdGljIHZvaWQgdW1lbV9kZXN0cm95KHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2LCBz
dHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdWV1ZQo+PiAgIAljYXNlIDM6Cj4+ICAgCQl1bWVtID0gJm12
cS0+dW1lbTM7Cj4+ICAgCQlicmVhazsKPj4gKwlkZWZhdWx0Ogo+PiArCQlXQVJOKDEsICJ1bnN1
cHBvcnRlZCB1bWVtIG51bSAlZFxuIiwgbnVtKTsKPj4gKwkJcmV0dXJuOwo+PiAgIAl9Cj4+ICAg
Cj4+ICAgCU1MWDVfU0VUKGRlc3Ryb3lfdW1lbV9pbiwgaW4sIG9wY29kZSwgTUxYNV9DTURfT1Bf
REVTVFJPWV9VTUVNKTsKPiBTaW5jZSB0aGUgImRlZmF1bHQiIGNhc2Ugd2lsbCBuZXZlciBiZSBl
eGVjdXRlZCwgbWF5YmUgaXQncyBiZXR0ZXIgdG8KPiBqdXN0IGNoYW5nZSAiY2FzZSAzOiIgdG8g
ImRlZmF1bHQ6IiBhbmQgYXZvaWQgdGhlIFdBUk4oKS4KCgpGaW5lIHdpdGggbWUuIFdpbGwgZG8g
dGhhdCBpbiBWMy4KClRoYW5rcwoKCj4KPj4gLS0gCj4+IDIuMjUuMQo+PgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
