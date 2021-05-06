Return-Path: <SRS0=qSBX=KB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5641C43460
	for <virtualization@archiver.kernel.org>; Thu,  6 May 2021 03:17:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 426C7613BA
	for <virtualization@archiver.kernel.org>; Thu,  6 May 2021 03:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426C7613BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB7C383BC3;
	Thu,  6 May 2021 03:17:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wIr_z8MEcwSy; Thu,  6 May 2021 03:17:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9DDEC83BC4;
	Thu,  6 May 2021 03:17:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78D9EC000E;
	Thu,  6 May 2021 03:17:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E10DC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 03:17:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1924D4057D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 03:17:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8MD6budNzotH
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 03:17:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 341D540577
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 03:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620271056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mHcgWqiBds5lBtditwajbBOEjZ3IZCTkxDstlE/eLZI=;
 b=SQ9rw4/JXr6GVlHFB898M847wE8UY9CIxcGVF+CJJIMo0F1xXSTcUAkKtcH1az9wAc9CdE
 9nlkMIsNH5y52wIisWj76bVF3PG7uVWGkQB/9Qi9LhF3pfiKhK2vPTYl+fYQlSBUXx15TC
 Sm/3zzuGXXlx6elRcFT4JmQ0X3iXEEo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-hfWxXVjoNJ6ug_c-ehhd0g-1; Wed, 05 May 2021 23:17:35 -0400
X-MC-Unique: hfWxXVjoNJ6ug_c-ehhd0g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E2E71006C80;
 Thu,  6 May 2021 03:17:34 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-159.pek2.redhat.com
 [10.72.13.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD130BA6F;
 Thu,  6 May 2021 03:17:28 +0000 (UTC)
Subject: Re: [PATCH] vhost-iotlb: fix vhost_iotlb_del_range() documentation
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20210504135444.158716-1-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <93e4cb04-105e-e853-e2b6-d95435ca55f2@redhat.com>
Date: Thu, 6 May 2021 11:17:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210504135444.158716-1-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

CtTaIDIwMjEvNS80IM/Czuc5OjU0LCBTdGVmYW5vIEdhcnphcmVsbGEg0LS1wDoKPiBUcml2aWFs
IGNoYW5nZSBmb3IgdGhlIHZob3N0X2lvdGxiX2RlbF9yYW5nZSgpIGRvY3VtZW50YXRpb24sCj4g
Zml4aW5nIHRoZSBmdW5jdGlvbiBuYW1lIGluIHRoZSBjb21tZW50IGJsb2NrLgo+Cj4gRGlzY292
ZXJlZCB3aXRoIGBtYWtlIEM9MiBNPWRyaXZlcnMvdmhvc3RgOgo+IC4uL2RyaXZlcnMvdmhvc3Qv
aW90bGIuYzo5Mjogd2FybmluZzogZXhwZWN0aW5nIHByb3RvdHlwZSBmb3IgdnJpbmdfaW90bGJf
ZGVsX3JhbmdlKCkuIFByb3RvdHlwZSB3YXMgZm9yIHZob3N0X2lvdGxiX2RlbF9yYW5nZSgpIGlu
c3RlYWQKPgo+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVk
aGF0LmNvbT4KPiAtLS0KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4KCgo+ICAgZHJpdmVycy92aG9zdC9pb3RsYi5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
aG9zdC9pb3RsYi5jIGIvZHJpdmVycy92aG9zdC9pb3RsYi5jCj4gaW5kZXggMGZkM2Y4N2U5MTNj
Li4wNTgyMDc5ZTRiY2MgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aG9zdC9pb3RsYi5jCj4gKysr
IGIvZHJpdmVycy92aG9zdC9pb3RsYi5jCj4gQEAgLTgzLDcgKzgzLDcgQEAgaW50IHZob3N0X2lv
dGxiX2FkZF9yYW5nZShzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlvdGxiLAo+ICAgRVhQT1JUX1NZTUJP
TF9HUEwodmhvc3RfaW90bGJfYWRkX3JhbmdlKTsKPiAgIAo+ICAgLyoqCj4gLSAqIHZyaW5nX2lv
dGxiX2RlbF9yYW5nZSAtIGRlbGV0ZSBvdmVybGFwcGVkIHJhbmdlcyBmcm9tIHZob3N0IElPVExC
Cj4gKyAqIHZob3N0X2lvdGxiX2RlbF9yYW5nZSAtIGRlbGV0ZSBvdmVybGFwcGVkIHJhbmdlcyBm
cm9tIHZob3N0IElPVExCCj4gICAgKiBAaW90bGI6IHRoZSBJT1RMQgo+ICAgICogQHN0YXJ0OiBz
dGFydCBvZiB0aGUgSU9WQSByYW5nZQo+ICAgICogQGxhc3Q6IGxhc3Qgb2YgSU9WQSByYW5nZQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
