Return-Path: <SRS0=KYCx=IQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF34FC433E0
	for <virtualization@archiver.kernel.org>; Thu, 18 Mar 2021 02:44:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3954564DE2
	for <virtualization@archiver.kernel.org>; Thu, 18 Mar 2021 02:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3954564DE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBEC54ED12;
	Thu, 18 Mar 2021 02:44:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bXhIjfqWsfzu; Thu, 18 Mar 2021 02:44:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E1C14ED05;
	Thu, 18 Mar 2021 02:44:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBE41C000A;
	Thu, 18 Mar 2021 02:44:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0DEFC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 02:44:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C85054309A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 02:44:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x9RkWsEe3T5o
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 02:44:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AD70042D28
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 02:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616035488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RYfa5a2DxRoWjWb7ZGXHEAtX1EgdbLByNOKHYZ6ZtLI=;
 b=ZbF7JGZrycSWl1Rt0lV/Nr8/gGunT7yqqk/Y643KnAxlutoA9dn3s6MRr8KZr3BJ3yPSdI
 mJ+zvuaI3Slu+E1Gq88BDyLEeXb1rUiuTRsI1HB5RHl4gE6MlwLOa/pmETHsyJMidUVXUI
 nYBxEkWtZw5kOC9uF57zPBNL7tZW6oU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-lMa46TAUM-qfCQ9m7ytemQ-1; Wed, 17 Mar 2021 22:44:46 -0400
X-MC-Unique: lMa46TAUM-qfCQ9m7ytemQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6DA581744F;
 Thu, 18 Mar 2021 02:44:44 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-131.pek2.redhat.com
 [10.72.13.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C163E503EE;
 Thu, 18 Mar 2021 02:44:38 +0000 (UTC)
Subject: Re: [PATCH V5 7/7] vDPA/ifcvf: deduce VIRTIO device ID from pdev ids
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, lulu@redhat.com,
 leonro@nvidia.com
References: <20210317094933.16417-1-lingshan.zhu@intel.com>
 <20210317094933.16417-8-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1ba4d913-b237-8faf-fec8-b844448c26f0@redhat.com>
Date: Thu, 18 Mar 2021 10:44:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210317094933.16417-8-lingshan.zhu@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvMy8xNyDPws7nNTo0OSwgWmh1IExpbmdzaGFuINC0tcA6Cj4gVGhpcyBjb21taXQg
ZGVkdWNlcyB0aGUgVklSVElPIGRldmljZSBJRCBvZiBhIHByb2JlZAo+IGRldmljZSBmcm9tIGl0
cyBwZGV2IGRldmljZSBpZHMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBaaHUgTGluZ3NoYW4gPGxpbmdz
aGFuLnpodUBpbnRlbC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFz
ZS5oIHwgIDEgKwo+ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyB8IDE0ICsrKysr
KysrKysrKystCj4gICAyIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oIGIv
ZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+IGluZGV4IGY3NzIzOWZjMTY0NC4uYjJl
ZWIxNmI5YzJjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgK
PiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oCj4gQEAgLTEyNyw0ICsxMjcs
NSBAQCBpbnQgaWZjdmZfdmVyaWZ5X21pbl9mZWF0dXJlcyhzdHJ1Y3QgaWZjdmZfaHcgKmh3LCB1
NjQgZmVhdHVyZXMpOwo+ICAgdTE2IGlmY3ZmX2dldF92cV9zdGF0ZShzdHJ1Y3QgaWZjdmZfaHcg
Kmh3LCB1MTYgcWlkKTsKPiAgIGludCBpZmN2Zl9zZXRfdnFfc3RhdGUoc3RydWN0IGlmY3ZmX2h3
ICpodywgdTE2IHFpZCwgdTE2IG51bSk7Cj4gICBzdHJ1Y3QgaWZjdmZfYWRhcHRlciAqdmZfdG9f
YWRhcHRlcihzdHJ1Y3QgaWZjdmZfaHcgKmh3KTsKPiAraW50IGlmY3ZmX3Byb2JlZF92aXJ0aW9f
bmV0KHN0cnVjdCBpZmN2Zl9odyAqaHcpOwo+ICAgI2VuZGlmIC8qIF9JRkNWRl9IXyAqLwo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIGIvZHJpdmVycy92ZHBh
L2lmY3ZmL2lmY3ZmX21haW4uYwo+IGluZGV4IGVhOTNlYTdmZDVkZi4uOWZhZGU0MDBiNWE0IDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPiArKysgYi9kcml2
ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4gQEAgLTMyMyw3ICszMjMsMTkgQEAgc3RhdGlj
IHUzMiBpZmN2Zl92ZHBhX2dldF9nZW5lcmF0aW9uKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9k
ZXYpCj4gICAKPiAgIHN0YXRpYyB1MzIgaWZjdmZfdmRwYV9nZXRfZGV2aWNlX2lkKHN0cnVjdCB2
ZHBhX2RldmljZSAqdmRwYV9kZXYpCj4gICB7Cj4gLQlyZXR1cm4gVklSVElPX0lEX05FVDsKPiAr
CXN0cnVjdCBpZmN2Zl9hZGFwdGVyICphZGFwdGVyID0gdmRwYV90b19hZGFwdGVyKHZkcGFfZGV2
KTsKPiArCXN0cnVjdCBwY2lfZGV2ICpwZGV2ID0gYWRhcHRlci0+cGRldjsKPiArCXUzMiByZXQg
PSAtRU5PREVWOwo+ICsKPiArCWlmIChwZGV2LT5kZXZpY2UgPCAweDEwMDAgfHwgcGRldi0+ZGV2
aWNlID4gMHgxMDdmKQo+ICsJCXJldHVybiByZXQ7Cj4gKwo+ICsJaWYgKHBkZXYtPmRldmljZSA8
IDB4MTA0MCkKPiArCQlyZXQgPSAgcGRldi0+c3Vic3lzdGVtX2RldmljZTsKPiArCWVsc2UKPiAr
CQlyZXQgPSAgcGRldi0+ZGV2aWNlIC0gMHgxMDQwOwo+ICsKPiArCXJldHVybiByZXQ7Cj4gICB9
CgoKSXQgd291bGQgYmUgYmV0dGVyIHRvIGtlZXAgdGhlIGNvbW1lbnQuCgpCdXQgYW55d2F5CgpB
Y2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgoKPiAgIAo+ICAgc3Rh
dGljIHUzMiBpZmN2Zl92ZHBhX2dldF92ZW5kb3JfaWQoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBh
X2RldikKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
