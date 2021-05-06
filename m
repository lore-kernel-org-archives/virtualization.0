Return-Path: <SRS0=qSBX=KB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D7EC43461
	for <virtualization@archiver.kernel.org>; Thu,  6 May 2021 02:22:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 988396112F
	for <virtualization@archiver.kernel.org>; Thu,  6 May 2021 02:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988396112F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 371F040567;
	Thu,  6 May 2021 02:22:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fo6gwy7I_DKE; Thu,  6 May 2021 02:22:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id A554E40566;
	Thu,  6 May 2021 02:22:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63DBBC000D;
	Thu,  6 May 2021 02:22:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E87A6C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 02:22:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E3B4D60787
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 02:22:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J41WdmQGTNsu
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 02:22:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2C212605A5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 02:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620267734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3CdvH8xTT3peeZGIlgh4cyu9+qImg7sI6BgRnLL1RQU=;
 b=F5IEwQ2iVdfQhriFRxrYLBfBHgDflI93Xm+pWAML4UdvWGejsR9thW/s/xNsWERxFKiEzP
 INAoPJw+4unPRzficUMyWlzW28sXuuMM3UuBuuCP9jWEiRZhnsx0VgordGTtKfbssOCymu
 ZRCPwNVM5YMGjV67MLdK0N3NaXg1ejw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-LcMFX_I5M2GzL0Rvi9eX6A-1; Wed, 05 May 2021 22:22:12 -0400
X-MC-Unique: LcMFX_I5M2GzL0Rvi9eX6A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB9C18049C5;
 Thu,  6 May 2021 02:22:11 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-159.pek2.redhat.com
 [10.72.13.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 14AECBA6F;
 Thu,  6 May 2021 02:22:06 +0000 (UTC)
Subject: Re: [PATCH 1/1] virtio-net: don't allocate control_buf if not
 supported
To: Max Gurtovoy <mgurtovoy@nvidia.com>, mst@redhat.com, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org
References: <20210502093319.61313-1-mgurtovoy@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <43ee9a1d-95fc-acbb-0830-1f87770e2f2e@redhat.com>
Date: Thu, 6 May 2021 10:22:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210502093319.61313-1-mgurtovoy@nvidia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

CtTaIDIwMjEvNS8yIM/Czuc1OjMzLCBNYXggR3VydG92b3kg0LS1wDoKPiBOb3QgYWxsIHZpcnRp
b19uZXQgZGV2aWNlcyBzdXBwb3J0IHRoZSBjdHJsIHF1ZXVlIGZlYXR1cmUuIFRodXMsIHRoZXJl
Cj4gaXMgbm8gbmVlZCB0byBhbGxvY2F0ZSB1bnVzZWQgcmVzb3VyY2VzLgo+Cj4gU2lnbmVkLW9m
Zi1ieTogTWF4IEd1cnRvdm95IDxtZ3VydG92b3lAbnZpZGlhLmNvbT4KCgpBY2tlZC1ieTogSmFz
b24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAgZHJpdmVycy9uZXQvdmly
dGlvX25ldC5jIHwgMTAgKysrKysrKy0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9f
bmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBpbmRleCA3ZmRhMmFlNGM0MGYuLjli
NmE0YTg3NWM1NSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiArKysg
Yi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBAQCAtMjg3MCw5ICsyODcwLDEzIEBAIHN0YXRp
YyBpbnQgdmlydG5ldF9hbGxvY19xdWV1ZXMoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4gICB7
Cj4gICAJaW50IGk7Cj4gICAKPiAtCXZpLT5jdHJsID0ga3phbGxvYyhzaXplb2YoKnZpLT5jdHJs
KSwgR0ZQX0tFUk5FTCk7Cj4gLQlpZiAoIXZpLT5jdHJsKQo+IC0JCWdvdG8gZXJyX2N0cmw7Cj4g
KwlpZiAodmktPmhhc19jdnEpIHsKPiArCQl2aS0+Y3RybCA9IGt6YWxsb2Moc2l6ZW9mKCp2aS0+
Y3RybCksIEdGUF9LRVJORUwpOwo+ICsJCWlmICghdmktPmN0cmwpCj4gKwkJCWdvdG8gZXJyX2N0
cmw7Cj4gKwl9IGVsc2Ugewo+ICsJCXZpLT5jdHJsID0gTlVMTDsKPiArCX0KPiAgIAl2aS0+c3Eg
PSBrY2FsbG9jKHZpLT5tYXhfcXVldWVfcGFpcnMsIHNpemVvZigqdmktPnNxKSwgR0ZQX0tFUk5F
TCk7Cj4gICAJaWYgKCF2aS0+c3EpCj4gICAJCWdvdG8gZXJyX3NxOwoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
