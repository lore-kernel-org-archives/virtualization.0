Return-Path: <SRS0=bpJj=DR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2030C433E7
	for <virtualization@archiver.kernel.org>; Sat, 10 Oct 2020 07:32:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 404FF2073A
	for <virtualization@archiver.kernel.org>; Sat, 10 Oct 2020 07:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0nbFCRT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404FF2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D586A87721;
	Sat, 10 Oct 2020 07:32:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F0eqAZ3O63ce; Sat, 10 Oct 2020 07:32:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 077AD87720;
	Sat, 10 Oct 2020 07:32:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0778C016F;
	Sat, 10 Oct 2020 07:32:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6FEAC0051
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 07:32:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CBC4E87721
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 07:32:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TJGFyalldfaX
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 07:32:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BFDBC87720
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 07:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602315123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3smJnnUNNJVW08T6/JEs8wo9FTXzfgaaDu4X4ohk75g=;
 b=A0nbFCRTLhDhGjuqtzdg5TvJtBSx0TcaggI2iQE9+PbmT79OAEKPz3J+ktYQPlma3rH6Ru
 mjSXfeEWSphTU0eLUVt6nnc/OTIN8IKGkDfZuKKMWuBIYBVPVZEi5R0iqaNd3mtpNoWL66
 umfOHw7eQdR04r4A8jDfrQ/kS9uyN5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-3gHG7GwIPQS-bW_Dcxw8gA-1; Sat, 10 Oct 2020 03:32:00 -0400
X-MC-Unique: 3gHG7GwIPQS-bW_Dcxw8gA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 754983FE7;
 Sat, 10 Oct 2020 07:31:59 +0000 (UTC)
Received: from [10.72.13.27] (ovpn-13-27.pek2.redhat.com [10.72.13.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 681C755786;
 Sat, 10 Oct 2020 07:31:53 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: should keep avail_index despite device status
To: Si-Wei Liu <si-wei.liu@oracle.com>, netdev@vger.kernel.org, mst@redhat.com
References: <1601583511-15138-1-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f3d1af9e-9164-dd42-1de4-7a40da46abba@redhat.com>
Date: Sat, 10 Oct 2020 15:31:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1601583511-15138-1-git-send-email-si-wei.liu@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: virtualization@lists.linux-foundation.org, boris.ostrovsky@oracle.com,
 linux-kernel@vger.kernel.org
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

Ck9uIDIwMjAvMTAvMiDkuIrljYg0OjE4LCBTaS1XZWkgTGl1IHdyb3RlOgo+IEEgVk0gd2l0aCBt
bHg1IHZEUEEgaGFzIGJlbG93IHdhcm5pbmdzIHdoaWxlIGJlaW5nIHJlc2V0Ogo+Cj4gdmhvc3Qg
VlEgMCByaW5nIHJlc3RvcmUgZmFpbGVkOiAtMTogUmVzb3VyY2UgdGVtcG9yYXJpbHkgdW5hdmFp
bGFibGUgKDExKQo+IHZob3N0IFZRIDEgcmluZyByZXN0b3JlIGZhaWxlZDogLTE6IFJlc291cmNl
IHRlbXBvcmFyaWx5IHVuYXZhaWxhYmxlICgxMSkKPgo+IFdlIHNob3VsZCBhbGxvdyB1c2Vyc3Bh
Y2UgZW11bGF0aW5nIHRoZSB2aXJ0aW8gZGV2aWNlIGJlCj4gYWJsZSB0byBnZXQgdG8gdnEncyBh
dmFpbF9pbmRleCwgcmVnYXJkbGVzcyBvZiB2RFBBIGRldmljZQo+IHN0YXR1cy4gU2F2ZSB0aGUg
aW5kZXggdGhhdCB3YXMgbGFzdCBzZWVuIHdoZW4gdmlydHEgd2FzCj4gc3RvcHBlZCwgc28gdGhh
dCB1c2Vyc3BhY2UgZG9lc24ndCBjb21wbGFpbi4KPgo+IFNpZ25lZC1vZmYtYnk6IFNpLVdlaSBM
aXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dh
bmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5l
dC5jIHwgMjAgKysrKysrKysrKysrKystLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNl
cnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9t
bHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+
IGluZGV4IDcwNjc2YTYuLjc0MjY0ZTU5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1
L25ldC9tbHg1X3ZuZXQuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQu
Ywo+IEBAIC0xMTMzLDE1ICsxMTMzLDE3IEBAIHN0YXRpYyB2b2lkIHN1c3BlbmRfdnEoc3RydWN0
IG1seDVfdmRwYV9uZXQgKm5kZXYsIHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZXVlICptCj4gICAJ
aWYgKCFtdnEtPmluaXRpYWxpemVkKQo+ICAgCQlyZXR1cm47Cj4gICAKPiAtCWlmIChxdWVyeV92
aXJ0cXVldWUobmRldiwgbXZxLCAmYXR0cikpIHsKPiAtCQltbHg1X3ZkcGFfd2FybigmbmRldi0+
bXZkZXYsICJmYWlsZWQgdG8gcXVlcnkgdmlydHF1ZXVlXG4iKTsKPiAtCQlyZXR1cm47Cj4gLQl9
Cj4gICAJaWYgKG12cS0+Zndfc3RhdGUgIT0gTUxYNV9WSVJUSU9fTkVUX1FfT0JKRUNUX1NUQVRF
X1JEWSkKPiAgIAkJcmV0dXJuOwo+ICAgCj4gICAJaWYgKG1vZGlmeV92aXJ0cXVldWUobmRldiwg
bXZxLCBNTFg1X1ZJUlRJT19ORVRfUV9PQkpFQ1RfU1RBVEVfU1VTUEVORCkpCj4gICAJCW1seDVf
dmRwYV93YXJuKCZuZGV2LT5tdmRldiwgIm1vZGlmeSB0byBzdXNwZW5kIGZhaWxlZFxuIik7Cj4g
Kwo+ICsJaWYgKHF1ZXJ5X3ZpcnRxdWV1ZShuZGV2LCBtdnEsICZhdHRyKSkgewo+ICsJCW1seDVf
dmRwYV93YXJuKCZuZGV2LT5tdmRldiwgImZhaWxlZCB0byBxdWVyeSB2aXJ0cXVldWVcbiIpOwo+
ICsJCXJldHVybjsKPiArCX0KPiArCW12cS0+YXZhaWxfaWR4ID0gYXR0ci5hdmFpbGFibGVfaW5k
ZXg7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyB2b2lkIHN1c3BlbmRfdnFzKHN0cnVjdCBtbHg1X3Zk
cGFfbmV0ICpuZGV2KQo+IEBAIC0xNDExLDggKzE0MTMsMTQgQEAgc3RhdGljIGludCBtbHg1X3Zk
cGFfZ2V0X3ZxX3N0YXRlKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTE2IGlkeCwgc3RydWN0
IHZkcGEKPiAgIAlzdHJ1Y3QgbWx4NV92aXJ0cV9hdHRyIGF0dHI7Cj4gICAJaW50IGVycjsKPiAg
IAo+IC0JaWYgKCFtdnEtPmluaXRpYWxpemVkKQo+IC0JCXJldHVybiAtRUFHQUlOOwo+ICsJLyog
SWYgdGhlIHZpcnRxIG9iamVjdCB3YXMgZGVzdHJveWVkLCB1c2UgdGhlIHZhbHVlIHNhdmVkIGF0
Cj4gKwkgKiB0aGUgbGFzdCBtaW51dGUgb2Ygc3VzcGVuZF92cS4gVGhpcyBjYXRlcnMgZm9yIHVz
ZXJzcGFjZQo+ICsJICogdGhhdCBjYXJlcyBhYm91dCBlbXVsYXRpbmcgdGhlIGluZGV4IGFmdGVy
IHZxIGlzIHN0b3BwZWQuCj4gKwkgKi8KPiArCWlmICghbXZxLT5pbml0aWFsaXplZCkgewo+ICsJ
CXN0YXRlLT5hdmFpbF9pbmRleCA9IG12cS0+YXZhaWxfaWR4Owo+ICsJCXJldHVybiAwOwo+ICsJ
fQo+ICAgCj4gICAJZXJyID0gcXVlcnlfdmlydHF1ZXVlKG5kZXYsIG12cSwgJmF0dHIpOwo+ICAg
CWlmIChlcnIpIHsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
