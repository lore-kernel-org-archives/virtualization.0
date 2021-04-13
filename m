Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3936CC43460
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 08:53:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFEA36135C
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 08:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFEA36135C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 775BC606E7;
	Tue, 13 Apr 2021 08:53:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SZaVL8PjzxuG; Tue, 13 Apr 2021 08:53:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1DC67606E5;
	Tue, 13 Apr 2021 08:53:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E90AEC000C;
	Tue, 13 Apr 2021 08:53:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9370DC000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 08:53:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 688EC4065C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 08:53:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1JSb5F7aQ3K3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 08:53:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8632540657
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 08:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618304025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LDhoSh21yQrWIxiZzfscdfh5hO+ef3/ijfa5Lxrgzu8=;
 b=IyIxUIslQmFm7Ti9NSAMWRUvyFDMBVF1eU8j+yoZsRodihxh31/H8duSKi3rkphwNOYGXX
 l1q9ESRtoF8/8JU7X+tbAIDqRBMPhA5jhycXfAKPUmhjEd2dJLkp4lj4JWscZbjTwekqW1
 AebpzkuGZtIEqo01adRfeZDoURQbDdY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-ucyBEUMsMZS0xJSAi2JD3Q-1; Tue, 13 Apr 2021 04:53:41 -0400
X-MC-Unique: ucyBEUMsMZS0xJSAi2JD3Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D7B010054F6;
 Tue, 13 Apr 2021 08:53:40 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-128.pek2.redhat.com
 [10.72.13.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 37A2D1C952;
 Tue, 13 Apr 2021 08:53:33 +0000 (UTC)
Subject: Re: [PATCH RFC v2 2/4] virtio_net: disable cb aggressively
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
References: <20210413054733.36363-1-mst@redhat.com>
 <20210413054733.36363-3-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <43db5c1e-9908-55bb-6d1a-c6c8d71e2315@redhat.com>
Date: Tue, 13 Apr 2021 16:53:32 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210413054733.36363-3-mst@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 Wei Wang <weiwan@google.com>, David Miller <davem@davemloft.net>
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

CtTaIDIwMjEvNC8xMyDPws7nMTo0NywgTWljaGFlbCBTLiBUc2lya2luINC0tcA6Cj4gVGhlcmUg
YXJlIGN1cnJlbnRseSB0d28gY2FzZXMgd2hlcmUgd2UgcG9sbCBUWCB2cSBub3QgaW4gcmVzcG9u
c2UgdG8gYQo+IGNhbGxiYWNrOiBzdGFydCB4bWl0IGFuZCByeCBuYXBpLiAgV2UgY3VycmVudGx5
IGRvIHRoaXMgd2l0aCBjYWxsYmFja3MKPiBlbmFibGVkIHdoaWNoIGNhbiBjYXVzZSBleHRyYSBp
bnRlcnJ1cHRzIGZyb20gdGhlIGNhcmQuICBVc2VkIG5vdCB0byBiZQo+IGEgYmlnIGlzc3VlIGFz
IHdlIHJ1biB3aXRoIGludGVycnVwdHMgZGlzYWJsZWQgYnV0IHRoYXQgaXMgbm8gbG9uZ2VyIHRo
ZQo+IGNhc2UsIGFuZCBpbiBzb21lIGNhc2VzIHRoZSByYXRlIG9mIHNwdXJpb3VzIGludGVycnVw
dHMgaXMgc28gaGlnaAo+IGxpbnV4IGRldGVjdHMgdGhpcyBhbmQgYWN0dWFsbHkga2lsbHMgdGhl
IGludGVycnVwdC4KPgo+IEZpeCB1cCBieSBkaXNhYmxpbmcgdGhlIGNhbGxiYWNrcyBiZWZvcmUg
cG9sbGluZyB0aGUgdHggdnEuCj4KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4g
PG1zdEByZWRoYXQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMiAr
Kwo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+IGluZGV4
IDgyZTUyMGQyY2IxMi4uMTZkNWFiZWQ1ODJjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYwo+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+IEBAIC0xNDI5LDYg
KzE0MjksNyBAQCBzdGF0aWMgdm9pZCB2aXJ0bmV0X3BvbGxfY2xlYW50eChzdHJ1Y3QgcmVjZWl2
ZV9xdWV1ZSAqcnEpCj4gICAJCXJldHVybjsKPiAgIAo+ICAgCWlmIChfX25ldGlmX3R4X3RyeWxv
Y2sodHhxKSkgewo+ICsJCXZpcnRxdWV1ZV9kaXNhYmxlX2NiKHNxLT52cSk7Cj4gICAJCWZyZWVf
b2xkX3htaXRfc2ticyhzcSwgdHJ1ZSk7Cj4gICAJCV9fbmV0aWZfdHhfdW5sb2NrKHR4cSk7CgoK
QW55IHJlYXNvbiB0aGF0IHdlIGRvbid0IG5lZWQgdG8gZW5hYmxlIHRoZSBjYiBoZXJlPwoKQW5k
IGFzIHdlIGRpc2N1c3NlZCBpbiB0aGUgcGFzdCwgaXQncyBwcm9iYWJseSB0aGUgdGltZSB0byBo
YXZlIGEgc2luZ2xlIApOQVBJIGZvciBib3RoIHR4IGFuZCByeD8KClRoYW5rcwoKCj4gICAJfQo+
IEBAIC0xNTgyLDYgKzE1ODMsNyBAQCBzdGF0aWMgbmV0ZGV2X3R4X3Qgc3RhcnRfeG1pdChzdHJ1
Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQo+ICAgCWJvb2wgdXNlX25h
cGkgPSBzcS0+bmFwaS53ZWlnaHQ7Cj4gICAKPiAgIAkvKiBGcmVlIHVwIGFueSBwZW5kaW5nIG9s
ZCBidWZmZXJzIGJlZm9yZSBxdWV1ZWluZyBuZXcgb25lcy4gKi8KPiArCXZpcnRxdWV1ZV9kaXNh
YmxlX2NiKHNxLT52cSk7Cj4gICAJZnJlZV9vbGRfeG1pdF9za2JzKHNxLCBmYWxzZSk7Cj4gICAK
PiAgIAlpZiAodXNlX25hcGkgJiYga2ljaykKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
