Return-Path: <SRS0=B6Di=JF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3947C433B4
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 09:47:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C1D9610A6
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 09:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1D9610A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00C0E41948;
	Thu,  8 Apr 2021 09:47:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 08NPKlbuLUHX; Thu,  8 Apr 2021 09:47:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8798541920;
	Thu,  8 Apr 2021 09:47:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63C7CC000B;
	Thu,  8 Apr 2021 09:47:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6255AC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 09:47:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4430E405D4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 09:47:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cMkhgtx1b7Xm
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 09:47:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 93468404B0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 09:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617875220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+mPdPPkL2uexbS0eM20lasDqx05OgOBYtjBXonlsDAo=;
 b=LG3eu7tKMK8u63hCuxICxDHcBI1nbW+fm2voxrXgYqG4vYTzx2RXb7DeFdX9ybUVMGZ8N8
 FXaG0rT9dXYedMT1rL9MS2yDrfz8830phszconLPDc0vj8B4Z8yOVPR86peKJZWspyaiFv
 YOlb77Nx5SCgG8By8Zx7rDjA+udQFcY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-bCSOr24NM8yqrpMNEqdq9Q-1; Thu, 08 Apr 2021 05:46:57 -0400
X-MC-Unique: bCSOr24NM8yqrpMNEqdq9Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D325C80364C;
 Thu,  8 Apr 2021 09:46:55 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-53.pek2.redhat.com
 [10.72.13.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3BC985C5E1;
 Thu,  8 Apr 2021 09:46:46 +0000 (UTC)
Subject: Re: [PATCH 4/5] vdpa/mlx5: Fix wrong use of bit numbers
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, parav@nvidia.com,
 si-wei.liu@oracle.com, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org
References: <20210408091047.4269-1-elic@nvidia.com>
 <20210408091047.4269-5-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f2ffac98-2ce7-f9c1-de93-09e9347d0991@redhat.com>
Date: Thu, 8 Apr 2021 17:46:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210408091047.4269-5-elic@nvidia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: stable@vger.kernel.org
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

CtTaIDIwMjEvNC84IM/Czuc1OjEwLCBFbGkgQ29oZW4g0LS1wDoKPiBWSVJUSU9fRl9WRVJTSU9O
XzEgaXMgYSBiaXQgbnVtYmVyLiBVc2UgQklUX1VMTCgpIHdpdGggbWFzawo+IGNvbmRpdGlvbmFs
cy4KPgo+IEFsc28sIGluIG1seDVfdmRwYV9pc19saXR0bGVfZW5kaWFuKCkgdXNlIEJJVF9VTEwg
Zm9yIGNvbnNpc3RlbmN5IHdpdGgKPiB0aGUgcmVzdCBvZiB0aGUgY29kZS4KPgo+IEZpeGVzOiAx
YTg2YjM3N2FhMjEgKCJ2ZHBhL21seDU6IEFkZCBWRFBBIGRyaXZlciBmb3Igc3VwcG9ydGVkIG1s
eDUgZGV2aWNlcyIpCj4gU2lnbmVkLW9mZi1ieTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+
CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAg
IGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDQgKystLQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQv
bWx4NV92bmV0LmMKPiBpbmRleCBhNDllYmIyNTAyNTMuLjZmZTYxZmM1Nzc5MCAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiArKysgYi9kcml2ZXJzL3Zk
cGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiBAQCAtODIwLDcgKzgyMCw3IEBAIHN0YXRpYyBpbnQg
Y3JlYXRlX3ZpcnRxdWV1ZShzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldiwgc3RydWN0IG1seDVf
dmRwYV92aXJ0cXVlCj4gICAJTUxYNV9TRVQodmlydGlvX3EsIHZxX2N0eCwgZXZlbnRfcXBuX29y
X21zaXgsIG12cS0+ZndxcC5tcXAucXBuKTsKPiAgIAlNTFg1X1NFVCh2aXJ0aW9fcSwgdnFfY3R4
LCBxdWV1ZV9zaXplLCBtdnEtPm51bV9lbnQpOwo+ICAgCU1MWDVfU0VUKHZpcnRpb19xLCB2cV9j
dHgsIHZpcnRpb192ZXJzaW9uXzFfMCwKPiAtCQkgISEobmRldi0+bXZkZXYuYWN0dWFsX2ZlYXR1
cmVzICYgVklSVElPX0ZfVkVSU0lPTl8xKSk7Cj4gKwkJICEhKG5kZXYtPm12ZGV2LmFjdHVhbF9m
ZWF0dXJlcyAmIEJJVF9VTEwoVklSVElPX0ZfVkVSU0lPTl8xKSkpOwo+ICAgCU1MWDVfU0VUNjQo
dmlydGlvX3EsIHZxX2N0eCwgZGVzY19hZGRyLCBtdnEtPmRlc2NfYWRkcik7Cj4gICAJTUxYNV9T
RVQ2NCh2aXJ0aW9fcSwgdnFfY3R4LCB1c2VkX2FkZHIsIG12cS0+ZGV2aWNlX2FkZHIpOwo+ICAg
CU1MWDVfU0VUNjQodmlydGlvX3EsIHZxX2N0eCwgYXZhaWxhYmxlX2FkZHIsIG12cS0+ZHJpdmVy
X2FkZHIpOwo+IEBAIC0xNTU0LDcgKzE1NTQsNyBAQCBzdGF0aWMgdm9pZCBjbGVhcl92aXJ0cXVl
dWVzKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2KQo+ICAgc3RhdGljIGlubGluZSBib29sIG1s
eDVfdmRwYV9pc19saXR0bGVfZW5kaWFuKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldikKPiAg
IHsKPiAgIAlyZXR1cm4gdmlydGlvX2xlZ2FjeV9pc19saXR0bGVfZW5kaWFuKCkgfHwKPiAtCQko
bXZkZXYtPmFjdHVhbF9mZWF0dXJlcyAmICgxVUxMIDw8IFZJUlRJT19GX1ZFUlNJT05fMSkpOwo+
ICsJCShtdmRldi0+YWN0dWFsX2ZlYXR1cmVzICYgQklUX1VMTChWSVJUSU9fRl9WRVJTSU9OXzEp
KTsKPiAgIH0KPiAgIAo+ICAgc3RhdGljIF9fdmlydGlvMTYgY3B1X3RvX21seDV2ZHBhMTYoc3Ry
dWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCB1MTYgdmFsKQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
