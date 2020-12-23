Return-Path: <SRS0=+X4x=F3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C7DC433DB
	for <virtualization@archiver.kernel.org>; Wed, 23 Dec 2020 08:37:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5063622252
	for <virtualization@archiver.kernel.org>; Wed, 23 Dec 2020 08:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5063622252
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 29A4A867C6;
	Wed, 23 Dec 2020 08:37:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fe3JoOausgHu; Wed, 23 Dec 2020 08:37:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0CF24867A3;
	Wed, 23 Dec 2020 08:37:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3EB3C1787;
	Wed, 23 Dec 2020 08:37:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B60FC0893
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 08:37:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 55918867A3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 08:37:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e6af5goEe9fE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 08:37:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3A97786765
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 08:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608712625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3qFyz9h7VZheiEP40gklGEtshCv6pLXIEhugrg/rlew=;
 b=GQJssyank7yX/7ltj6rJImq1YeeBCJLip6Df9NzQyrTtmhsPPoRxlxXBurh0JKweax9vE+
 Tp8M+79M8xmnlAVMhq1I7rj8/YGw1pMwTIOTdJeMMlowPzg+makapkJxIv5dPmZGWOS21j
 kfFk+GV5D+Y7pBKLy/INUApFD/BTgdw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-Pbr5_DBoMqGoFC2SlLc90Q-1; Wed, 23 Dec 2020 03:37:02 -0500
X-MC-Unique: Pbr5_DBoMqGoFC2SlLc90Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 893CD180A096;
 Wed, 23 Dec 2020 08:37:00 +0000 (UTC)
Received: from [10.72.12.54] (ovpn-12-54.pek2.redhat.com [10.72.12.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DCDED60C6A;
 Wed, 23 Dec 2020 08:36:48 +0000 (UTC)
Subject: Re: [RFC v2 08/13] vdpa: Introduce process_iotlb_msg() in
 vdpa_config_ops
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 akpm@linux-foundation.org, rdunlap@infradead.org, willy@infradead.org,
 viro@zeniv.linux.org.uk, axboe@kernel.dk, bcrl@kvack.org, corbet@lwn.net
References: <20201222145221.711-1-xieyongji@bytedance.com>
 <20201222145221.711-9-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5b36bc51-1e19-2b59-6287-66aed435c8ed@redhat.com>
Date: Wed, 23 Dec 2020 16:36:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201222145221.711-9-xieyongji@bytedance.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: linux-aio@kvack.org, kvm@vger.kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
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

Ck9uIDIwMjAvMTIvMjIg5LiL5Y2IMTA6NTIsIFhpZSBZb25namkgd3JvdGU6Cj4gVGhpcyBwYXRj
aCBpbnRyb2R1Y2VzIGEgbmV3IG1ldGhvZCBpbiB0aGUgdmRwYV9jb25maWdfb3BzIHRvCj4gc3Vw
cG9ydCBwcm9jZXNzaW5nIHRoZSByYXcgdmhvc3QgbWVtb3J5IG1hcHBpbmcgbWVzc2FnZSBpbiB0
aGUKPiB2RFBBIGRldmljZSBkcml2ZXIuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4
aWV5b25namlAYnl0ZWRhbmNlLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmhvc3QvdmRwYS5jIHwg
NSArKysrLQo+ICAgaW5jbHVkZS9saW51eC92ZHBhLmggfCA3ICsrKysrKysKPiAgIDIgZmlsZXMg
Y2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiBpbmRleCA0NDhi
ZTc4NzViNmQuLmNjYmIzOTFlMzhiZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEu
Ywo+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gQEAgLTcyOCw2ICs3MjgsOSBAQCBzdGF0
aWMgaW50IHZob3N0X3ZkcGFfcHJvY2Vzc19pb3RsYl9tc2coc3RydWN0IHZob3N0X2RldiAqZGV2
LAo+ICAgCWlmIChyKQo+ICAgCQlyZXR1cm4gcjsKPiAgIAo+ICsJaWYgKG9wcy0+cHJvY2Vzc19p
b3RsYl9tc2cpCj4gKwkJcmV0dXJuIG9wcy0+cHJvY2Vzc19pb3RsYl9tc2codmRwYSwgbXNnKTsK
PiArCj4gICAJc3dpdGNoIChtc2ctPnR5cGUpIHsKPiAgIAljYXNlIFZIT1NUX0lPVExCX1VQREFU
RToKPiAgIAkJciA9IHZob3N0X3ZkcGFfcHJvY2Vzc19pb3RsYl91cGRhdGUodiwgbXNnKTsKPiBA
QCAtNzcwLDcgKzc3Myw3IEBAIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9hbGxvY19kb21haW4oc3Ry
dWN0IHZob3N0X3ZkcGEgKnYpCj4gICAJaW50IHJldDsKPiAgIAo+ICAgCS8qIERldmljZSB3YW50
IHRvIGRvIERNQSBieSBpdHNlbGYgKi8KPiAtCWlmIChvcHMtPnNldF9tYXAgfHwgb3BzLT5kbWFf
bWFwKQo+ICsJaWYgKG9wcy0+c2V0X21hcCB8fCBvcHMtPmRtYV9tYXAgfHwgb3BzLT5wcm9jZXNz
X2lvdGxiX21zZykKPiAgIAkJcmV0dXJuIDA7Cj4gICAKPiAgIAlidXMgPSBkbWFfZGV2LT5idXM7
Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmRwYS5oIGIvaW5jbHVkZS9saW51eC92ZHBh
LmgKPiBpbmRleCA2NTZmZTI2NDIzNGUuLjdiY2NlZGYyMmY0YiAxMDA2NDQKPiAtLS0gYS9pbmNs
dWRlL2xpbnV4L3ZkcGEuaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4gQEAgLTUsNiAr
NSw3IEBACj4gICAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+Cj4gICAjaW5jbHVkZSA8bGludXgv
ZGV2aWNlLmg+Cj4gICAjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+Cj4gKyNpbmNsdWRlIDxs
aW51eC92aG9zdF90eXBlcy5oPgo+ICAgI2luY2x1ZGUgPGxpbnV4L3Zob3N0X2lvdGxiLmg+Cj4g
ICAjaW5jbHVkZSA8bmV0L2dlbmV0bGluay5oPgo+ICAgCj4gQEAgLTE3Miw2ICsxNzMsMTAgQEAg
c3RydWN0IHZkcGFfaW92YV9yYW5nZSB7Cj4gICAgKgkJCQlAdmRldjogdmRwYSBkZXZpY2UKPiAg
ICAqCQkJCVJldHVybnMgdGhlIGlvdmEgcmFuZ2Ugc3VwcG9ydGVkIGJ5Cj4gICAgKgkJCQl0aGUg
ZGV2aWNlLgo+ICsgKiBAcHJvY2Vzc19pb3RsYl9tc2c6CQlQcm9jZXNzIHZob3N0IG1lbW9yeSBt
YXBwaW5nIG1lc3NhZ2UgKG9wdGlvbmFsKQo+ICsgKgkJCQlPbmx5IHVzZWQgZm9yIFZEVVNFIGRl
dmljZSBub3cKPiArICoJCQkJQHZkZXY6IHZkcGEgZGV2aWNlCj4gKyAqCQkJCUBtc2c6IHZob3N0
IG1lbW9yeSBtYXBwaW5nIG1lc3NhZ2UKPiAgICAqIEBzZXRfbWFwOgkJCVNldCBkZXZpY2UgbWVt
b3J5IG1hcHBpbmcgKG9wdGlvbmFsKQo+ICAgICoJCQkJTmVlZGVkIGZvciBkZXZpY2UgdGhhdCB1
c2luZyBkZXZpY2UKPiAgICAqCQkJCXNwZWNpZmljIERNQSB0cmFuc2xhdGlvbiAob24tY2hpcCBJ
T01NVSkKPiBAQCAtMjQwLDYgKzI0NSw4IEBAIHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgewo+ICAg
CXN0cnVjdCB2ZHBhX2lvdmFfcmFuZ2UgKCpnZXRfaW92YV9yYW5nZSkoc3RydWN0IHZkcGFfZGV2
aWNlICp2ZGV2KTsKPiAgIAo+ICAgCS8qIERNQSBvcHMgKi8KPiArCWludCAoKnByb2Nlc3NfaW90
bGJfbXNnKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsCj4gKwkJCQkgc3RydWN0IHZob3N0X2lv
dGxiX21zZyAqbXNnKTsKPiAgIAlpbnQgKCpzZXRfbWFwKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZk
ZXYsIHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIpOwo+ICAgCWludCAoKmRtYV9tYXApKHN0cnVj
dCB2ZHBhX2RldmljZSAqdmRldiwgdTY0IGlvdmEsIHU2NCBzaXplLAo+ICAgCQkgICAgICAgdTY0
IHBhLCB1MzIgcGVybSk7CgoKSXMgdGhlcmUgYW55IHJlYXNvbiB0aGF0IGl0IGNhbid0IGJlIGRv
bmUgdmlhIGRtYV9tYXAvZG1hX3VubWFwIG9yIHNldF9tYXA/CgpUaGFua3MKCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
