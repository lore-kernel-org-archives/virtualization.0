Return-Path: <SRS0=COaL=H7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB72C433DB
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 07:53:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80D0D64DBA
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 07:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D0D64DBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 33B4184333;
	Mon,  1 Mar 2021 07:53:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zif4YBbOXFwn; Mon,  1 Mar 2021 07:53:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id B4DDA8431A;
	Mon,  1 Mar 2021 07:53:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8844AC000B;
	Mon,  1 Mar 2021 07:53:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41A1CC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 07:53:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3039243005
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 07:53:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id os9o4oP6N-DC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 07:53:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 808CB414EF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 07:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614585179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0CNsQ5PANkIBnhwAb5s093rNx2yiWanVGyrgP1R4R4=;
 b=SLtD17zJDmikrX7aX9/5Qqv4I/HSXaZc9nYvPV/6KeP5eLj1DfQKNlwR6s+cDc2PPRQMBR
 xqLHdpdOeFtdbLWzYA7RP/RhOuUNrh6IlIDKf6tdAuYzWAn/IitAUF4B3LDxXhExBV/Fov
 b9yQyUH9B0oAiu52LyZ56aX7BUVdlxw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-og48gR6wNbKswwmGmqyYpw-1; Mon, 01 Mar 2021 02:52:54 -0500
X-MC-Unique: og48gR6wNbKswwmGmqyYpw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8770E107ACF5;
 Mon,  1 Mar 2021 07:52:53 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-188.pek2.redhat.com
 [10.72.13.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3CC1C6A8EA;
 Mon,  1 Mar 2021 07:52:47 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: Fix wrong use of bit numbers
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org
References: <20210301062817.39331-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <959916f2-5fc9-bdb4-31ca-632fe0d98979@redhat.com>
Date: Mon, 1 Mar 2021 15:52:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210301062817.39331-1-elic@nvidia.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Ck9uIDIwMjEvMy8xIDI6Mjgg5LiL5Y2ILCBFbGkgQ29oZW4gd3JvdGU6Cj4gVklSVElPX0ZfVkVS
U0lPTl8xIGlzIGEgYml0IG51bWJlci4gVXNlIEJJVF9VTEwoKSB3aXRoIG1hc2sKPiBjb25kaXRp
b25hbHMuCj4KPiBBbHNvLCBpbiBtbHg1X3ZkcGFfaXNfbGl0dGxlX2VuZGlhbigpIHVzZSBCSVRf
VUxMIGZvciBjb25zaXN0ZW5jeSB3aXRoCj4gdGhlIHJlc3Qgb2YgdGhlIGNvZGUuCj4KPiBGaXhl
czogMWE4NmIzNzdhYTIxICgidmRwYS9tbHg1OiBBZGQgVkRQQSBkcml2ZXIgZm9yIHN1cHBvcnRl
ZCBtbHg1IGRldmljZXMiKQo+IFNpZ25lZC1vZmYtYnk6IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEu
Y29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0t
Cj4gICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCA0ICsrLS0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIGIvZHJpdmVycy92ZHBhL21seDUv
bmV0L21seDVfdm5ldC5jCj4gaW5kZXggZGM3MDMxMTMyZmZmLi43ZDIxYjg1N2E5NGEgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gKysrIGIvZHJpdmVy
cy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gQEAgLTgyMSw3ICs4MjEsNyBAQCBzdGF0aWMg
aW50IGNyZWF0ZV92aXJ0cXVldWUoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYsIHN0cnVjdCBt
bHg1X3ZkcGFfdmlydHF1ZQo+ICAgCU1MWDVfU0VUKHZpcnRpb19xLCB2cV9jdHgsIGV2ZW50X3Fw
bl9vcl9tc2l4LCBtdnEtPmZ3cXAubXFwLnFwbik7Cj4gICAJTUxYNV9TRVQodmlydGlvX3EsIHZx
X2N0eCwgcXVldWVfc2l6ZSwgbXZxLT5udW1fZW50KTsKPiAgIAlNTFg1X1NFVCh2aXJ0aW9fcSwg
dnFfY3R4LCB2aXJ0aW9fdmVyc2lvbl8xXzAsCj4gLQkJICEhKG5kZXYtPm12ZGV2LmFjdHVhbF9m
ZWF0dXJlcyAmIFZJUlRJT19GX1ZFUlNJT05fMSkpOwo+ICsJCSAhIShuZGV2LT5tdmRldi5hY3R1
YWxfZmVhdHVyZXMgJiBCSVRfVUxMKFZJUlRJT19GX1ZFUlNJT05fMSkpKTsKPiAgIAlNTFg1X1NF
VDY0KHZpcnRpb19xLCB2cV9jdHgsIGRlc2NfYWRkciwgbXZxLT5kZXNjX2FkZHIpOwo+ICAgCU1M
WDVfU0VUNjQodmlydGlvX3EsIHZxX2N0eCwgdXNlZF9hZGRyLCBtdnEtPmRldmljZV9hZGRyKTsK
PiAgIAlNTFg1X1NFVDY0KHZpcnRpb19xLCB2cV9jdHgsIGF2YWlsYWJsZV9hZGRyLCBtdnEtPmRy
aXZlcl9hZGRyKTsKPiBAQCAtMTU3OCw3ICsxNTc4LDcgQEAgc3RhdGljIHZvaWQgdGVhcmRvd25f
dmlydHF1ZXVlcyhzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldikKPiAgIHN0YXRpYyBpbmxpbmUg
Ym9vbCBtbHg1X3ZkcGFfaXNfbGl0dGxlX2VuZGlhbihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZk
ZXYpCj4gICB7Cj4gICAJcmV0dXJuIHZpcnRpb19sZWdhY3lfaXNfbGl0dGxlX2VuZGlhbigpIHx8
Cj4gLQkJKG12ZGV2LT5hY3R1YWxfZmVhdHVyZXMgJiAoMVVMTCA8PCBWSVJUSU9fRl9WRVJTSU9O
XzEpKTsKPiArCQkobXZkZXYtPmFjdHVhbF9mZWF0dXJlcyAmIEJJVF9VTEwoVklSVElPX0ZfVkVS
U0lPTl8xKSk7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyBfX3ZpcnRpbzE2IGNwdV90b19tbHg1dmRw
YTE2KHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgdTE2IHZhbCkKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
