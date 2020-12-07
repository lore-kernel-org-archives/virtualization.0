Return-Path: <SRS0=JO0H=FL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EABBC4361B
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 03:55:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ABD722BE8
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 03:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ABD722BE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7F3B52E1A7;
	Mon,  7 Dec 2020 03:55:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JLRRMPEtpveR; Mon,  7 Dec 2020 03:55:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6F0E420365;
	Mon,  7 Dec 2020 03:55:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F893C0FA7;
	Mon,  7 Dec 2020 03:55:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88621C013B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 03:55:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 846908731C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 03:55:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TDCMDh71IePQ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 03:55:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7D3308730F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 03:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607313344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5t7w+CXAhJbK4V7KFhz3B7Y30H+N9uWN7m7f9MGMPd4=;
 b=dSO2IERRMEnd2Vpfp+M8F92hEWd70lywBMzb/Kn1Ojt67AscKCPBqlJDtje2AUjcZi7ijj
 9XJ5Dd13y5LOW5lqebiBRdL885uz+Zy/XZRnHDHNYrKhQP64i0fDNBNchTF9+a8s+xa+sq
 2pjzvrFlho43rQrqI9810UDoo/GP+JQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-qffgb6xVPC2ywIbW0NQoYQ-1; Sun, 06 Dec 2020 22:55:42 -0500
X-MC-Unique: qffgb6xVPC2ywIbW0NQoYQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DD7D107ACE3;
 Mon,  7 Dec 2020 03:55:41 +0000 (UTC)
Received: from [10.72.13.171] (ovpn-13-171.pek2.redhat.com [10.72.13.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 447FA1A262;
 Mon,  7 Dec 2020 03:55:32 +0000 (UTC)
Subject: Re: [PATCH v3 04/19] vhost/iotlb: add VHOST_IOTLB_UNLIMITED macro
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20201203170511.216407-1-sgarzare@redhat.com>
 <20201203170511.216407-5-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <52ab5f00-c59b-9cfa-3837-10c1391fea33@redhat.com>
Date: Mon, 7 Dec 2020 11:55:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201203170511.216407-5-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Shahaf Shuler <shahafs@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eli Cohen <elic@nvidia.com>, Oren Duer <oren@nvidia.com>
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

Ck9uIDIwMjAvMTIvNCDkuIrljYgxOjA0LCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gSXQn
cyBwb3NzaWJsZSB0byBhbGxvY2F0ZSBhbiB1bmxpbWl0ZWQgSU9UTEIgY2FsbGluZwo+IHZob3N0
X2lvdGxiX2FsbG9jKCkgd2l0aCAnbGltaXQnID0gMC4KPgo+IEFkZCBhIG5ldyBtYWNybyAoVkhP
U1RfSU9UTEJfVU5MSU1JVEVEKSBmb3IgdGhpcyBjYXNlIGFuZCBkb2N1bWVudAo+IGl0IGluIHRo
ZSB2aG9zdF9pb3RsYl9hbGxvYygpIGRvY3VtZW50YXRpb24gYmxvY2suCj4KPiBTdWdnZXN0ZWQt
Ynk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogU3Rl
ZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0tCj4gICBpbmNsdWRlL2xpbnV4L3Zob3N0
X2lvdGxiLmggfCAyICsrCj4gICBkcml2ZXJzL3Zob3N0L2lvdGxiLmMgICAgICAgfCAzICsrLQo+
ICAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3Zob3N0X2lvdGxiLmggYi9pbmNsdWRlL2xpbnV4L3Zo
b3N0X2lvdGxiLmgKPiBpbmRleCA2YjA5Yjc4NmE3NjIuLjQ3MDE5Zjk3Zjc5NSAxMDA2NDQKPiAt
LS0gYS9pbmNsdWRlL2xpbnV4L3Zob3N0X2lvdGxiLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L3Zo
b3N0X2lvdGxiLmgKPiBAQCAtNCw2ICs0LDggQEAKPiAgIAo+ICAgI2luY2x1ZGUgPGxpbnV4L2lu
dGVydmFsX3RyZWVfZ2VuZXJpYy5oPgo+ICAgCj4gKyNkZWZpbmUgVkhPU1RfSU9UTEJfVU5MSU1J
VEVEIDAKPiArCj4gICBzdHJ1Y3Qgdmhvc3RfaW90bGJfbWFwIHsKPiAgIAlzdHJ1Y3QgcmJfbm9k
ZSByYjsKPiAgIAlzdHJ1Y3QgbGlzdF9oZWFkIGxpbms7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmhvc3QvaW90bGIuYyBiL2RyaXZlcnMvdmhvc3QvaW90bGIuYwo+IGluZGV4IDBmZDNmODdlOTEz
Yy4uODBmZGRlNzhlZTVhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3QvaW90bGIuYwo+ICsr
KyBiL2RyaXZlcnMvdmhvc3QvaW90bGIuYwo+IEBAIC0xMDAsNyArMTAwLDggQEAgRVhQT1JUX1NZ
TUJPTF9HUEwodmhvc3RfaW90bGJfZGVsX3JhbmdlKTsKPiAgIAo+ICAgLyoqCj4gICAgKiB2aG9z
dF9pb3RsYl9hbGxvYyAtIGFkZCBhIG5ldyB2aG9zdCBJT1RMQgo+IC0gKiBAbGltaXQ6IG1heGlt
dW0gbnVtYmVyIG9mIElPVExCIGVudHJpZXMKPiArICogQGxpbWl0OiBtYXhpbXVtIG51bWJlciBv
ZiBJT1RMQiBlbnRyaWVzICh1c2UgVkhPU1RfSU9UTEJfVU5MSU1JVEVEIGZvciBhbgo+ICsgKiAg
ICAgICAgIHVubGltaXRlZCBJT1RMQikKPiAgICAqIEBmbGFnczogVkhPU1RfSU9UTEJfRkxBR19Y
WFgKPiAgICAqCj4gICAgKiBSZXR1cm5zIGFuIGVycm9yIGlzIG1lbW9yeSBhbGxvY2F0aW9uIGZh
aWxzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
