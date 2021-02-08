Return-Path: <SRS0=X+k7=HK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA897C433DB
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 04:38:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B7E264E2F
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 04:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7E264E2F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 315CC87002;
	Mon,  8 Feb 2021 04:38:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id foj6L6g4hAdO; Mon,  8 Feb 2021 04:38:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 84C6F86FFD;
	Mon,  8 Feb 2021 04:38:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E939C0174;
	Mon,  8 Feb 2021 04:38:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93CBCC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 04:38:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8D88A86816
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 04:38:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bsYLy2ZJZmIZ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 04:38:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D82FB86457
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 04:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612759106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9wWsUqUhlv7QqnvbHZyfnA9QSR8BaLZUw3dSMQV+dxg=;
 b=fjVZ/DOrotFrSM8VYjFmOR4vdm0yEKpigAuq5EHDAUTszl8nJi86xLBa3ptlUYPHj52U3X
 2rmE/jN8oHejgROzHetJ/aCBCG6D151gWG6svmqFyfiyq+vbX7Oiqxu79I3l+WirNv46VL
 VUXBlEkukowDHlhP2hdPYkpebQPUg8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-Uw2q1OM3NLi7RnEvgIpDyw-1; Sun, 07 Feb 2021 23:38:22 -0500
X-MC-Unique: Uw2q1OM3NLi7RnEvgIpDyw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C16580364B;
 Mon,  8 Feb 2021 04:38:21 +0000 (UTC)
Received: from [10.72.13.185] (ovpn-13-185.pek2.redhat.com [10.72.13.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 69C655C1C2;
 Mon,  8 Feb 2021 04:38:16 +0000 (UTC)
Subject: Re: [PATCH 3/3] mlx5_vdpa: defer clear_virtqueues to until DRIVER_OK
To: Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com, elic@nvidia.com
References: <1612614564-4220-1-git-send-email-si-wei.liu@oracle.com>
 <1612614564-4220-3-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <17374b6e-83c5-29c8-de28-60e06f4ce6ca@redhat.com>
Date: Mon, 8 Feb 2021 12:38:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1612614564-4220-3-git-send-email-si-wei.liu@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Ck9uIDIwMjEvMi82IOS4i+WNiDg6MjksIFNpLVdlaSBMaXUgd3JvdGU6Cj4gV2hpbGUgdmlydHEg
aXMgc3RvcHBlZCwgIGdldF92cV9zdGF0ZSgpIGlzIHN1cHBvc2VkIHRvCj4gYmUgIGNhbGxlZCB0
byAgZ2V0ICBzeW5jJ2VkICB3aXRoICB0aGUgbGF0ZXN0IGludGVybmFsCj4gYXZhaWxfaW5kZXgg
ZnJvbSBkZXZpY2UuIFRoZSBzYXZlZCBhdmFpbF9pbmRleCBpcyB1c2VkCj4gdG8gcmVzdGF0ZSAg
dGhlIHZpcnRxICBvbmNlIGRldmljZSBpcyBzdGFydGVkLiAgQ29tbWl0Cj4gYjM1Y2NlYmUzZWY3
IGludHJvZHVjZWQgdGhlIGNsZWFyX3ZpcnRxdWV1ZXMoKSByb3V0aW5lCj4gdG8gIHJlc2V0ICB0
aGUgc2F2ZWQgIGF2YWlsX2luZGV4LCAgaG93ZXZlciwgdGhlIGluZGV4Cj4gZ2V0cyBjbGVhcmVk
IGEgYml0IGVhcmxpZXIgYmVmb3JlIGdldF92cV9zdGF0ZSgpIHRyaWVzCj4gdG8gcmVhZCBpdC4g
VGhpcyB3b3VsZCBjYXVzZSBjb25zaXN0ZW5jeSBwcm9ibGVtcyB3aGVuCj4gdmlydHEgaXMgcmVz
dGFydGVkLCBlLmcuIHRocm91Z2ggYSBzZXJpZXMgb2YgbGluayBkb3duCj4gYW5kIGxpbmsgdXAg
ZXZlbnRzLiBXZSAgY291bGQgIGRlZmVyICB0aGUgIGNsZWFyaW5nIG9mCj4gYXZhaWxfaW5kZXgg
IHRvICB1bnRpbCAgdGhlICBkZXZpY2UgIGlzIHRvIGJlIHN0YXJ0ZWQsCj4gaS5lLiB1bnRpbCAg
VklSVElPX0NPTkZJR19TX0RSSVZFUl9PSyAgaXMgc2V0IGFnYWluIGluCj4gc2V0X3N0YXR1cygp
Lgo+Cj4gRml4ZXM6IGIzNWNjZWJlM2VmNyAoInZkcGEvbWx4NTogUmVzdG9yZSB0aGUgaGFyZHdh
cmUgdXNlZCBpbmRleCBhZnRlciBjaGFuZ2UgbWFwIikKPiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkg
TGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3Zu
ZXQuYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBi
L2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+IGluZGV4IGFhNmY4Y2QuLjQ0NGFi
NTggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gKysr
IGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gQEAgLTE3ODUsNyArMTc4NSw2
IEBAIHN0YXRpYyB2b2lkIG1seDVfdmRwYV9zZXRfc3RhdHVzKHN0cnVjdCB2ZHBhX2RldmljZSAq
dmRldiwgdTggc3RhdHVzKQo+ICAgCWlmICghc3RhdHVzKSB7Cj4gICAJCW1seDVfdmRwYV9pbmZv
KG12ZGV2LCAicGVyZm9ybWluZyBkZXZpY2UgcmVzZXRcbiIpOwo+ICAgCQl0ZWFyZG93bl9kcml2
ZXIobmRldik7Cj4gLQkJY2xlYXJfdmlydHF1ZXVlcyhuZGV2KTsKPiAgIAkJbWx4NV92ZHBhX2Rl
c3Ryb3lfbXIoJm5kZXYtPm12ZGV2KTsKPiAgIAkJbmRldi0+bXZkZXYuc3RhdHVzID0gMDsKPiAg
IAkJKyttdmRldi0+Z2VuZXJhdGlvbjsKPiBAQCAtMTc5NCw2ICsxNzkzLDcgQEAgc3RhdGljIHZv
aWQgbWx4NV92ZHBhX3NldF9zdGF0dXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1OCBzdGF0
dXMpCj4gICAKPiAgIAlpZiAoKHN0YXR1cyBeIG5kZXYtPm12ZGV2LnN0YXR1cykgJiBWSVJUSU9f
Q09ORklHX1NfRFJJVkVSX09LKSB7Cj4gICAJCWlmIChzdGF0dXMgJiBWSVJUSU9fQ09ORklHX1Nf
RFJJVkVSX09LKSB7Cj4gKwkJCWNsZWFyX3ZpcnRxdWV1ZXMobmRldik7Cj4gICAJCQllcnIgPSBz
ZXR1cF9kcml2ZXIobmRldik7Cj4gICAJCQlpZiAoZXJyKSB7Cj4gICAJCQkJbWx4NV92ZHBhX3dh
cm4obXZkZXYsICJmYWlsZWQgdG8gc2V0dXAgZHJpdmVyXG4iKTsKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
