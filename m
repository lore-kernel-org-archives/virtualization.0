Return-Path: <SRS0=tvPF=IP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B730EC433E0
	for <virtualization@archiver.kernel.org>; Wed, 17 Mar 2021 04:08:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC5164F45
	for <virtualization@archiver.kernel.org>; Wed, 17 Mar 2021 04:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC5164F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA36E60686;
	Wed, 17 Mar 2021 04:08:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uJgl_4PzGz3G; Wed, 17 Mar 2021 04:08:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D85F60071;
	Wed, 17 Mar 2021 04:08:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74F8CC000C;
	Wed, 17 Mar 2021 04:08:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 165B4C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 04:08:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F214F83A89
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 04:08:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YaZXZCUI8Ivw
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 04:08:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AAD9883560
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 04:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615954084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HdiveM119yE82h3FVSM3fQt9fV4OqxVZRZ4Nl+K7F/Y=;
 b=YBdW3H0SR3oBO3u6u+WpcsIFgwcW80Vcd1vh1qU++n58+Ktk4p3SRUbrBin+lZGn/flixH
 eyAvfIN+f46r1D5UsxRw8hi3gcWiVhmMYRUpwo7AgGIMUJkyDTJ/nHt/LJvZ2VGsmHcXUb
 G8BiUo0MKjaaMm1FsE1v+os2s4AXYiA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-25agm97fMqCYyxv1ABnnMQ-1; Wed, 17 Mar 2021 00:08:02 -0400
X-MC-Unique: 25agm97fMqCYyxv1ABnnMQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA84487A826;
 Wed, 17 Mar 2021 04:08:00 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-188.pek2.redhat.com
 [10.72.12.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06E5E19706;
 Wed, 17 Mar 2021 04:07:54 +0000 (UTC)
Subject: Re: [PATCH V4 7/7] vDPA/ifcvf: deduce VIRTIO device ID from pdev ids
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, lulu@redhat.com,
 leonro@nvidia.com
References: <20210315074501.15868-1-lingshan.zhu@intel.com>
 <20210315074501.15868-8-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a873deef-81e9-9177-b297-7c7063077ff6@redhat.com>
Date: Wed, 17 Mar 2021 12:07:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210315074501.15868-8-lingshan.zhu@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIxLzMvMTUg5LiL5Y2IMzo0NSwgWmh1IExpbmdzaGFuIOWGmemBkzoKPiAgIHN0YXRp
YyB1MzIgaWZjdmZfdmRwYV9nZXRfZGV2aWNlX2lkKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9k
ZXYpCj4gICB7Cj4gLQlyZXR1cm4gVklSVElPX0lEX05FVDsKPiArCXN0cnVjdCBpZmN2Zl9odyAq
dmYgPSB2ZHBhX3RvX3ZmKHZkcGFfZGV2KTsKPiArCXUzMiByZXQgPSAtRU9QTk9UU1VQUDsKPiAr
Cj4gKwlpZiAoaWZjdmZfcHJvYmVkX3ZpcnRpb19uZXQodmYpKQo+ICsJCXJldCA9IFZJUlRJT19J
RF9ORVQ7CgoKU28gdGhlIHBvaW50IGlzIHRvIHNpbXBsaWZ5IHRoZSBmdXR1cmUgZXh0ZW5zaW9u
LgoKSG93IGFib3V0IHNpbXBseT8KCmlmIChkZXZpY2VfaWQ+MHgxMDQwKQogwqDCoMKgIHJldHVy
biBkZXZjZV9pZCAtIDB4MTA0MDsKZWxzZQogwqDCoMKgIHJldHVybiBkZXZpY2VfaWQ7CgpTaW5j
ZSBJIGRvbid0IHRoaW5rIHlvdSBwbGFuIHRvIGludHJvZHVjZSBkZXZpY2Ugd2hvc2UgdmVuZG9y
IGlkIGlzIG5vdCAKMUFGNCBhbmQgdGhlIHN1YnN5cyB2ZW5kb3IvZGV2aWNlIGlkIGlzIG5vdCBp
bnRlcmVzdGluZyB0byB2RFBBIGJ1cy4KClRoYW5rcwoKCj4gKwo+ICsJcmV0dXJuIHJldDsKPiAg
IH0KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
