Return-Path: <SRS0=zQmE=GX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39938C433E0
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 03:44:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98D0623110
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 03:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D0623110
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 170AB204F6;
	Wed, 20 Jan 2021 03:44:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xegIZcqMlsSD; Wed, 20 Jan 2021 03:44:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1A06E20443;
	Wed, 20 Jan 2021 03:44:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 007FFC088B;
	Wed, 20 Jan 2021 03:44:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6C27C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 03:44:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9BA5E85D90
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 03:44:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0ZWzEEtuRCXs
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 03:44:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id EFBA284D2E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 03:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611114274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BHJzsbGQ3zxMDMbJJfdomjMvNc/E1eGKV+czPVXzYNc=;
 b=cU2LU63/dKTtn2SfSQjtJYrVfutH/Pj8vm7EbsjUw1QyGpA9UoDGbpZe5LD9wmvXV0gFW8
 403TTatXPPhBHXkiJl9ZaYgSR+pCjashSEMgUod4jSJnP5nFnSVXBcWMR0WkPBSK9r0I4V
 +r2gUNe94UQxv60f6fL7dnJBBE/i6rI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-MChJ_65cNhSYzTRY33kfEQ-1; Tue, 19 Jan 2021 22:44:33 -0500
X-MC-Unique: MChJ_65cNhSYzTRY33kfEQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1D3A800D53;
 Wed, 20 Jan 2021 03:44:30 +0000 (UTC)
Received: from [10.72.13.124] (ovpn-13-124.pek2.redhat.com [10.72.13.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8FDF760C9C;
 Wed, 20 Jan 2021 03:44:19 +0000 (UTC)
Subject: Re: [RFC v3 04/11] vhost-vdpa: protect concurrent access to vhost
 device iotlb
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 bob.liu@oracle.com, hch@infradead.org, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net
References: <20210119045920.447-1-xieyongji@bytedance.com>
 <20210119045920.447-5-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8fbcb4c3-a09a-a00a-97e2-dde0a03be5a9@redhat.com>
Date: Wed, 20 Jan 2021 11:44:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210119045920.447-5-xieyongji@bytedance.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

Ck9uIDIwMjEvMS8xOSDkuIvljYgxMjo1OSwgWGllIFlvbmdqaSB3cm90ZToKPiBJbnRyb2R1Y2Ug
YSBtdXRleCB0byBwcm90ZWN0IHZob3N0IGRldmljZSBpb3RsYiBmcm9tCj4gY29uY3VycmVudCBh
Y2Nlc3MuCj4KPiBGaXhlczogNGM4Y2YzMTgoInZob3N0OiBpbnRyb2R1Y2UgdkRQQS1iYXNlZCBi
YWNrZW5kIikKPiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4aWV5b25namlAYnl0ZWRhbmNl
LmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmhvc3QvdmRwYS5jIHwgNCArKysrCj4gICAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92
ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+IGluZGV4IDQ0OGJlNzg3NWI2ZC4uNGEyNDFk
MzgwYzQwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gKysrIGIvZHJpdmVy
cy92aG9zdC92ZHBhLmMKPiBAQCAtNDksNiArNDksNyBAQCBzdHJ1Y3Qgdmhvc3RfdmRwYSB7Cj4g
ICAJc3RydWN0IGV2ZW50ZmRfY3R4ICpjb25maWdfY3R4Owo+ICAgCWludCBpbl9iYXRjaDsKPiAg
IAlzdHJ1Y3QgdmRwYV9pb3ZhX3JhbmdlIHJhbmdlOwo+ICsJc3RydWN0IG11dGV4IG11dGV4OwoK
CkxldCdzIHVzZSB0aGUgZGV2aWNlIG11dGV4IGxpa2Ugd2hhdCB2aG9zdF9wcm9jZXNzX2lvdGxi
X21zZygpIGRpZC4KClRoYW5rcwoKCj4gICB9Owo+ICAgCj4gICBzdGF0aWMgREVGSU5FX0lEQSh2
aG9zdF92ZHBhX2lkYSk7Cj4gQEAgLTcyOCw2ICs3MjksNyBAQCBzdGF0aWMgaW50IHZob3N0X3Zk
cGFfcHJvY2Vzc19pb3RsYl9tc2coc3RydWN0IHZob3N0X2RldiAqZGV2LAo+ICAgCWlmIChyKQo+
ICAgCQlyZXR1cm4gcjsKPiAgIAo+ICsJbXV0ZXhfbG9jaygmdi0+bXV0ZXgpOwo+ICAgCXN3aXRj
aCAobXNnLT50eXBlKSB7Cj4gICAJY2FzZSBWSE9TVF9JT1RMQl9VUERBVEU6Cj4gICAJCXIgPSB2
aG9zdF92ZHBhX3Byb2Nlc3NfaW90bGJfdXBkYXRlKHYsIG1zZyk7Cj4gQEAgLTc0Nyw2ICs3NDks
NyBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfcHJvY2Vzc19pb3RsYl9tc2coc3RydWN0IHZob3N0
X2RldiAqZGV2LAo+ICAgCQlyID0gLUVJTlZBTDsKPiAgIAkJYnJlYWs7Cj4gICAJfQo+ICsJbXV0
ZXhfdW5sb2NrKCZ2LT5tdXRleCk7Cj4gICAKPiAgIAlyZXR1cm4gcjsKPiAgIH0KPiBAQCAtMTAx
Nyw2ICsxMDIwLDcgQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX3Byb2JlKHN0cnVjdCB2ZHBhX2Rl
dmljZSAqdmRwYSkKPiAgIAkJcmV0dXJuIG1pbm9yOwo+ICAgCX0KPiAgIAo+ICsJbXV0ZXhfaW5p
dCgmdi0+bXV0ZXgpOwo+ICAgCWF0b21pY19zZXQoJnYtPm9wZW5lZCwgMCk7Cj4gICAJdi0+bWlu
b3IgPSBtaW5vcjsKPiAgIAl2LT52ZHBhID0gdmRwYTsKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
