Return-Path: <SRS0=QXZB=GC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7B8C433E0
	for <virtualization@archiver.kernel.org>; Wed, 30 Dec 2020 06:49:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B60E21919
	for <virtualization@archiver.kernel.org>; Wed, 30 Dec 2020 06:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B60E21919
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id EBC5F8716D;
	Wed, 30 Dec 2020 06:49:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vZxer3GZ15AN; Wed, 30 Dec 2020 06:49:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B3D0A87121;
	Wed, 30 Dec 2020 06:49:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98902C0893;
	Wed, 30 Dec 2020 06:49:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9CFAC0174
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 06:49:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AB8C0842C3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 06:49:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IruoBgrYR2R1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 06:49:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0292E842B4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 06:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609310958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=heg1e+a0V0k76vMPfwBRgNJmwNSkeMx7Vj1PPs8FGPE=;
 b=VKKPcvhHq6gU9fQeXblMMGEbp3CZ6GsWgUTCkToPC0WiIigTK+l3djt2pnO/Ea9xwfEY4x
 MfzvOD2yJXEdpw1/ZM9Y8Uw7V/5dr0kt6jSMu7Q9NUcpMmG/+P8bQFxeLkDo+9UHw+Bmr1
 v8rr/TMiWKeCv3Cyp0dhFO31tJ/f/kc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-Te43lXXeP_qDJgvLF9ML3Q-1; Wed, 30 Dec 2020 01:49:17 -0500
X-MC-Unique: Te43lXXeP_qDJgvLF9ML3Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C497107ACE6;
 Wed, 30 Dec 2020 06:49:15 +0000 (UTC)
Received: from [10.72.13.30] (ovpn-13-30.pek2.redhat.com [10.72.13.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E61FA71CBB;
 Wed, 30 Dec 2020 06:49:04 +0000 (UTC)
Subject: Re: [PATCH 12/21] vhost-vdpa: introduce uAPI to get the number of
 virtqueue groups
To: Eli Cohen <elic@nvidia.com>
References: <20201216064818.48239-1-jasowang@redhat.com>
 <20201216064818.48239-13-jasowang@redhat.com>
 <20201229122455.GF195479@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f7e603f1-0200-566a-5360-f093da358b6d@redhat.com>
Date: Wed, 30 Dec 2020 14:49:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201229122455.GF195479@mtl-vdi-166.wap.labs.mlnx>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: lulu@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 stefanha@redhat.com, eli@mellanox.com, lingshan.zhu@intel.com,
 rob.miller@broadcom.com
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

Ck9uIDIwMjAvMTIvMjkg5LiL5Y2IODoyNCwgRWxpIENvaGVuIHdyb3RlOgo+IE9uIFdlZCwgRGVj
IDE2LCAyMDIwIGF0IDAyOjQ4OjA5UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+IEZvbGxv
d3MgdGhlIHZEUEEgc3VwcG9ydCBmb3IgbXVsdGlwbGUgYWRkcmVzcyBzcGFjZXMsIHRoaXMgcGF0
Y2gKPj4gaW50cm9kdWNlIHVBUEkgZm9yIHRoZSB1c2Vyc3BhY2UgdG8ga25vdyB0aGUgbnVtYmVy
IG9mIHZpcnRxdWV1ZQo+PiBncm91cHMgc3VwcG9ydGVkIGJ5IHRoZSB2RFBBIGRldmljZS4KPiBD
YW4geW91IGV4cGxhaW4gd2hhdCBleGFjdGx5IHlvdSBtZWFuIGJlIHVzZXJzcGFjZT8KCgpJdCdz
IHRoZSB1c2Vyc3BhY2UgdGhhdCB1c2VzIHRoZSB1QVBJIGludHJvZHVjZWQgaW4gdGhpcyBwYXRj
aC4KCgo+IElzIGl0IGp1c3QgcWVtdSBvcgo+IGlzIGl0IGRlc3RpbmVkIHRvIHRoZSB2aXJ0aW9f
bmV0IGRyaXZlciBydW4gYnkgdGhlIHFlbXUgcHJvY2Vzcz8KCgpJdCBjb3VsZCBiZSBRZW11LCBE
UERLIG9yIG90aGVyIHVzZXJzcGFjZSBwcm9ncmFtLgoKVGhlIGd1ZXN0IHZpcnRpby1uZXQgZHJp
dmVyIHdpbGwgbm90IHVzZSB0aGlzIGJ1dCB0YWxrcyB0byB0aGUgdmlydGlvIApkZXZpY2UgZW11
bGF0ZWQgYnkgUWVtdS4KCgo+IEFsc28gY2FuIHlvdSBzYXkgZm9yIHdoYXQgcHVycG9zZT8KCgpU
aGlzIGNhbiBiZSB1c2VkIGZvciBmYWNpbGl0YXRlIHRoZSBjaGVja2luZyBvZiB3aGV0aGVyIHRo
ZSBjb250cm9sIHZxIApjb3VsZCBiZSBzdXBwb3J0ZWQuCgpFLmcgaWYgdGhlIGRldmljZSBzdXBw
b3J0IGxlc3MgdGhhbiAyIGdyb3VwcywgcWVtdSB3b24ndCBhZHZlcnRpc2UgCmNvbnRyb2wgdnEu
CgpZZXMsICNncm91cHMgY291bGQgYmUgaW5mZXJyZWQgZnJvbSBHRVRfVlJJTkdfR1JPVVAuIEJ1
dCBpdCdzIG5vdCAKc3RyYWlnaHRmb3J3YXJkIGFzIHRoaXMuCgpUaGFua3MKCgo+Cj4+IFNpZ25l
ZC1vZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4+IC0tLQo+PiAgIGRy
aXZlcnMvdmhvc3QvdmRwYS5jICAgICAgIHwgNCArKysrCj4+ICAgaW5jbHVkZS91YXBpL2xpbnV4
L3Zob3N0LmggfCAzICsrKwo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspCj4+
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRw
YS5jCj4+IGluZGV4IDA2MGQ1YjViN2U2NC4uMWJhNTkwMWIyOGU3IDEwMDY0NAo+PiAtLS0gYS9k
cml2ZXJzL3Zob3N0L3ZkcGEuYwo+PiArKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+PiBAQCAt
NTM2LDYgKzUzNiwxMCBAQCBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3VubG9ja2VkX2lvY3RsKHN0
cnVjdCBmaWxlICpmaWxlcCwKPj4gICAJY2FzZSBWSE9TVF9WRFBBX0dFVF9WUklOR19OVU06Cj4+
ICAgCQlyID0gdmhvc3RfdmRwYV9nZXRfdnJpbmdfbnVtKHYsIGFyZ3ApOwo+PiAgIAkJYnJlYWs7
Cj4+ICsJY2FzZSBWSE9TVF9WRFBBX0dFVF9HUk9VUF9OVU06Cj4+ICsJCXIgPSBjb3B5X3RvX3Vz
ZXIoYXJncCwgJnYtPnZkcGEtPm5ncm91cHMsCj4+ICsJCQkJIHNpemVvZih2LT52ZHBhLT5uZ3Jv
dXBzKSk7Cj4+ICsJCWJyZWFrOwo+PiAgIAljYXNlIFZIT1NUX1NFVF9MT0dfQkFTRToKPj4gICAJ
Y2FzZSBWSE9TVF9TRVRfTE9HX0ZEOgo+PiAgIAkJciA9IC1FTk9JT0NUTENNRDsKPj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC92aG9zdC5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L3Zo
b3N0LmgKPj4gaW5kZXggNTljNmMwZmJhYmExLi44YTRlNmU0MjZiYmYgMTAwNjQ0Cj4+IC0tLSBh
L2luY2x1ZGUvdWFwaS9saW51eC92aG9zdC5oCj4+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC92
aG9zdC5oCj4+IEBAIC0xNDUsNCArMTQ1LDcgQEAKPj4gICAvKiBHZXQgdGhlIHZhbGlkIGlvdmEg
cmFuZ2UgKi8KPj4gICAjZGVmaW5lIFZIT1NUX1ZEUEFfR0VUX0lPVkFfUkFOR0UJX0lPUihWSE9T
VF9WSVJUSU8sIDB4NzgsIFwKPj4gICAJCQkJCSAgICAgc3RydWN0IHZob3N0X3ZkcGFfaW92YV9y
YW5nZSkKPj4gKy8qIEdldCB0aGUgbnVtYmVyIG9mIHZpcnRxdWV1ZSBncm91cHMuICovCj4+ICsj
ZGVmaW5lIFZIT1NUX1ZEUEFfR0VUX0dST1VQX05VTQlfSU9SKFZIT1NUX1ZJUlRJTywgMHg3OSwg
dW5zaWduZWQgaW50KQo+PiArCj4+ICAgI2VuZGlmCj4+IC0tIAo+PiAyLjI1LjEKPj4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
