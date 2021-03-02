Return-Path: <SRS0=LnXi=IA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221F6C433DB
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 06:47:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C56761601
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 06:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C56761601
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54B0B60714;
	Tue,  2 Mar 2021 06:47:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BOiHrGTupzty; Tue,  2 Mar 2021 06:47:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 041FC606FF;
	Tue,  2 Mar 2021 06:47:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9A06C000B;
	Tue,  2 Mar 2021 06:47:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28877C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 06:47:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 004E260714
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 06:47:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6c9sdFEtB_Ei
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 06:47:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 482B3606FF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 06:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614667661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A33+VwIK3bf5osqIxTxxyG3hL3urzpweVkSG9X2C69k=;
 b=IxMsAW1m9rc+281NJiq5h5lhWiyNx9u99eyJRY+sY5dryAspx5cJH9s0XUU1Iwys9HddnM
 /kmyAS9Q5rLAMrHXFDgNfHQBK66ixTEyRjaLY+S51tVbkyhrX24sZtp+Zeeu4SlSm872EK
 FnGfRq2BFfI7sguymprDwI3uKpmWDfI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-GwLs2Ht7Ns6Ngsa4ODZhAQ-1; Tue, 02 Mar 2021 01:47:39 -0500
X-MC-Unique: GwLs2Ht7Ns6Ngsa4ODZhAQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF9E11005501;
 Tue,  2 Mar 2021 06:47:37 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-133.pek2.redhat.com
 [10.72.12.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 999FC5D766;
 Tue,  2 Mar 2021 06:47:23 +0000 (UTC)
Subject: Re: [RFC v4 02/11] vhost-vdpa: protect concurrent access to vhost
 device iotlb
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 bob.liu@oracle.com, hch@infradead.org, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net
References: <20210223115048.435-1-xieyongji@bytedance.com>
 <20210223115048.435-3-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a170e0ec-f0cf-e23f-0ca7-e8a5bfd1cf31@redhat.com>
Date: Tue, 2 Mar 2021 14:47:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210223115048.435-3-xieyongji@bytedance.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: linux-aio@kvack.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjEvMi8yMyA3OjUwIOS4i+WNiCwgWGllIFlvbmdqaSB3cm90ZToKPiBVc2Ugdmhvc3Rf
ZGV2LT5tdXRleCB0byBwcm90ZWN0IHZob3N0IGRldmljZSBpb3RsYiBmcm9tCj4gY29uY3VycmVu
dCBhY2Nlc3MuCj4KPiBGaXhlczogNGM4Y2YzMTgoInZob3N0OiBpbnRyb2R1Y2UgdkRQQS1iYXNl
ZCBiYWNrZW5kIikKPiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4aWV5b25namlAYnl0ZWRh
bmNlLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmhvc3QvdmRwYS5jIHwgMiArKwo+ICAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3Qv
dmRwYS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiBpbmRleCBjNTAwNzlkZmIyODEuLjU1MDBl
M2JmMDVjMSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ICsrKyBiL2RyaXZl
cnMvdmhvc3QvdmRwYS5jCj4gQEAgLTcyMyw2ICs3MjMsNyBAQCBzdGF0aWMgaW50IHZob3N0X3Zk
cGFfcHJvY2Vzc19pb3RsYl9tc2coc3RydWN0IHZob3N0X2RldiAqZGV2LAo+ICAgCWlmIChyKQo+
ICAgCQlyZXR1cm4gcjsKPiAgIAo+ICsJbXV0ZXhfbG9jaygmZGV2LT5tdXRleCk7CgoKSSB0aGlu
ayB0aGlzIHNob3VsZCBiZSBkb25lIGJlZm9yZSB0aGUgdmhvc3RfZGV2X2NoZWNrX293bmVyKCkg
YWJvdmUuCgpUaGFua3MKCgo+ICAgCXN3aXRjaCAobXNnLT50eXBlKSB7Cj4gICAJY2FzZSBWSE9T
VF9JT1RMQl9VUERBVEU6Cj4gICAJCXIgPSB2aG9zdF92ZHBhX3Byb2Nlc3NfaW90bGJfdXBkYXRl
KHYsIG1zZyk7Cj4gQEAgLTc0Miw2ICs3NDMsNyBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfcHJv
Y2Vzc19pb3RsYl9tc2coc3RydWN0IHZob3N0X2RldiAqZGV2LAo+ICAgCQlyID0gLUVJTlZBTDsK
PiAgIAkJYnJlYWs7Cj4gICAJfQo+ICsJbXV0ZXhfdW5sb2NrKCZkZXYtPm11dGV4KTsKPiAgIAo+
ICAgCXJldHVybiByOwo+ICAgfQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
