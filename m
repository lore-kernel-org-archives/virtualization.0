Return-Path: <SRS0=vMKq=G7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178AAC433E0
	for <virtualization@archiver.kernel.org>; Thu, 28 Jan 2021 03:12:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9BD964DA1
	for <virtualization@archiver.kernel.org>; Thu, 28 Jan 2021 03:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9BD964DA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 03694870EF;
	Thu, 28 Jan 2021 03:12:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MHxg+CS6g56F; Thu, 28 Jan 2021 03:12:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 37FE2870E0;
	Thu, 28 Jan 2021 03:12:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16C99C08A1;
	Thu, 28 Jan 2021 03:12:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0378DC013A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 03:12:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CC1AD20445
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 03:12:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 01YmU+j5HQSe
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 03:12:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 96C62203B2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 03:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611803528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DcrTmjoadIb7p2OxWm6C9AN0UzP4YCS8NJ0a7dpGJ98=;
 b=iRxUA8xwPuntLKakKQke54oZ/v1F5Tfi520WXEcQ/cz0sjskvXro3pCa0F0sfUkJhNFe5q
 tNONq6+XX+mRRviWs46xyFphDBODMxasUQ8qEUoTySRTtUTizWvPFV9hHyJKE7O29arTI1
 bzTl4l+wsGPi+n2yt4CL5XIvi8cEIfQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-zc4-TNbrNLWVbKrUpxayDQ-1; Wed, 27 Jan 2021 22:12:04 -0500
X-MC-Unique: zc4-TNbrNLWVbKrUpxayDQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 362EE1005586;
 Thu, 28 Jan 2021 03:12:02 +0000 (UTC)
Received: from [10.72.12.167] (ovpn-12-167.pek2.redhat.com [10.72.12.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 649365D9E3;
 Thu, 28 Jan 2021 03:11:51 +0000 (UTC)
Subject: Re: [RFC v3 03/11] vdpa: Remove the restriction that only supports
 virtio-net devices
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20210119045920.447-1-xieyongji@bytedance.com>
 <20210119045920.447-4-xieyongji@bytedance.com>
 <310d7793-e4ff-fba3-f358-418cb64c7988@redhat.com>
 <20210120110832.oijcmywq7pf7psg3@steredhat>
 <1979cffc-240e-a9f9-b0ab-84a1f82ac81e@redhat.com>
 <20210127085728.j6x5yzrldp2wp55c@steredhat>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3cb239f5-fdd5-8311-35a0-c0f50b552521@redhat.com>
Date: Thu, 28 Jan 2021 11:11:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210127085728.j6x5yzrldp2wp55c@steredhat>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: axboe@kernel.dk, corbet@lwn.net, kvm@vger.kernel.org, mst@redhat.com,
 linux-aio@kvack.org, netdev@vger.kernel.org, rdunlap@infradead.org,
 willy@infradead.org, virtualization@lists.linux-foundation.org,
 hch@infradead.org, Xie Yongji <xieyongji@bytedance.com>, bob.liu@oracle.com,
 bcrl@kvack.org, viro@zeniv.linux.org.uk, stefanha@redhat.com,
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

Ck9uIDIwMjEvMS8yNyDkuIvljYg0OjU3LCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gT24g
V2VkLCBKYW4gMjcsIDIwMjEgYXQgMTE6MzM6MDNBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4KPj4gT24gMjAyMS8xLzIwIOS4i+WNiDc6MDgsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToK
Pj4+IE9uIFdlZCwgSmFuIDIwLCAyMDIxIGF0IDExOjQ2OjM4QU0gKzA4MDAsIEphc29uIFdhbmcg
d3JvdGU6Cj4+Pj4KPj4+PiBPbiAyMDIxLzEvMTkg5LiL5Y2IMTI6NTksIFhpZSBZb25namkgd3Jv
dGU6Cj4+Pj4+IFdpdGggVkRVU0UsIHdlIHNob3VsZCBiZSBhYmxlIHRvIHN1cHBvcnQgYWxsIGtp
bmRzIG9mIHZpcnRpbyBkZXZpY2VzLgo+Pj4+Pgo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9u
Z2ppIDx4aWV5b25namlAYnl0ZWRhbmNlLmNvbT4KPj4+Pj4gLS0tCj4+Pj4+IMKgZHJpdmVycy92
aG9zdC92ZHBhLmMgfCAyOSArKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+Pj4+PiDCoDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDI2IGRlbGV0aW9ucygtKQo+Pj4+Pgo+Pj4+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEu
Ywo+Pj4+PiBpbmRleCAyOWVkNDE3M2YwNGUuLjQ0OGJlNzg3NWI2ZCAxMDA2NDQKPj4+Pj4gLS0t
IGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4+Pj4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMK
Pj4+Pj4gQEAgLTIyLDYgKzIyLDcgQEAKPj4+Pj4gwqAjaW5jbHVkZSA8bGludXgvbm9zcGVjLmg+
Cj4+Pj4+IMKgI2luY2x1ZGUgPGxpbnV4L3Zob3N0Lmg+Cj4+Pj4+IMKgI2luY2x1ZGUgPGxpbnV4
L3ZpcnRpb19uZXQuaD4KPj4+Pj4gKyNpbmNsdWRlIDxsaW51eC92aXJ0aW9fYmxrLmg+Cj4+Pj4+
IMKgI2luY2x1ZGUgInZob3N0LmgiCj4+Pj4+IEBAIC0xODUsMjYgKzE4Niw2IEBAIHN0YXRpYyBs
b25nIHZob3N0X3ZkcGFfc2V0X3N0YXR1cyhzdHJ1Y3QgCj4+Pj4+IHZob3N0X3ZkcGEgKnYsIHU4
IF9fdXNlciAqc3RhdHVzcCkKPj4+Pj4gwqDCoMKgwqAgcmV0dXJuIDA7Cj4+Pj4+IMKgfQo+Pj4+
PiAtc3RhdGljIGludCB2aG9zdF92ZHBhX2NvbmZpZ192YWxpZGF0ZShzdHJ1Y3Qgdmhvc3RfdmRw
YSAqdiwKPj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
dHJ1Y3Qgdmhvc3RfdmRwYV9jb25maWcgKmMpCj4+Pj4+IC17Cj4+Pj4+IC3CoMKgwqAgbG9uZyBz
aXplID0gMDsKPj4+Pj4gLQo+Pj4+PiAtwqDCoMKgIHN3aXRjaCAodi0+dmlydGlvX2lkKSB7Cj4+
Pj4+IC3CoMKgwqAgY2FzZSBWSVJUSU9fSURfTkVUOgo+Pj4+PiAtwqDCoMKgwqDCoMKgwqAgc2l6
ZSA9IHNpemVvZihzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcpOwo+Pj4+PiAtwqDCoMKgwqDCoMKg
wqAgYnJlYWs7Cj4+Pj4+IC3CoMKgwqAgfQo+Pj4+PiAtCj4+Pj4+IC3CoMKgwqAgaWYgKGMtPmxl
biA9PSAwKQo+Pj4+PiAtwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7Cj4+Pj4+IC0KPj4+
Pj4gLcKgwqDCoCBpZiAoYy0+bGVuID4gc2l6ZSAtIGMtPm9mZikKPj4+Pj4gLcKgwqDCoMKgwqDC
oMKgIHJldHVybiAtRTJCSUc7Cj4+Pj4+IC0KPj4+Pj4gLcKgwqDCoCByZXR1cm4gMDsKPj4+Pj4g
LX0KPj4+Pgo+Pj4+Cj4+Pj4gSSB0aGluayB3ZSBzaG91bGQgdXNlIGEgc2VwYXJhdGUgcGF0Y2gg
Zm9yIHRoaXMuCj4+Pgo+Pj4gRm9yIHRoZSB2ZHBhLWJsayBzaW11bGF0b3IgSSBoYWQgdGhlIHNh
bWUgaXNzdWVzIGFuZCBJJ20gYWRkaW5nIGEgCj4+PiAuZ2V0X2NvbmZpZ19zaXplKCkgY2FsbGJh
Y2sgdG8gdmRwYSBkZXZpY2VzLgo+Pj4KPj4+IERvIHlvdSB0aGluayBtYWtlIHNlbnNlIG9yIGlz
IGJldHRlciB0byByZW1vdmUgdGhpcyBjaGVjayBpbiAKPj4+IHZob3N0L3ZkcGEsIGRlbGVnYXRp
bmcgdGhlIGJvdW5kYXJpZXMgY2hlY2tzIHRvIAo+Pj4gZ2V0X2NvbmZpZy9zZXRfY29uZmlnIGNh
bGxiYWNrcy4KPj4KPj4KPj4gQSBxdWVzdGlvbiBoZXJlLiBIb3cgbXVjaCB2YWx1ZSBjb3VsZCB3
ZSBnYWluIGZyb20gZ2V0X2NvbmZpZ19zaXplKCkgCj4+IGNvbnNpZGVyIHdlIGNhbiBsZXQgdkRQ
QSBwYXJlbnQgdG8gdmFsaWRhdGUgdGhlIGxlbmd0aCBpbiBpdHMgCj4+IGdldF9jb25maWcoKS4K
Pj4KPgo+IEkgYWdyZWUsIG1vc3Qgb2YgdGhlIGltcGxlbWVudGF0aW9ucyBhbHJlYWR5IHZhbGlk
YXRlIHRoZSBsZW5ndGgsIHRoZSAKPiBvbmx5IGdhaW4gaXMgYW4gZXJyb3IgcmV0dXJuZWQgc2lu
Y2UgZ2V0X2NvbmZpZygpIGlzIHZvaWQsIGJ1dCAKPiBldmVudHVhbGx5IHdlIGNhbiBhZGQgYSBy
ZXR1cm4gdmFsdWUgdG8gaXQuCgoKUmlnaHQsIG9uZSBwcm9ibGVtIGhlcmUgaXMgdGhhdC4gRm9y
IHRoZSB2aXJpdG8gcGF0aCwgaXRzIGdldF9jb25maWcoKSAKcmV0dXJucyB2b2lkLiBTbyB3ZSBj
YW4gbm90IHByb3BhZ2F0ZSBlcnJvciB0byB2aXJ0aW8gZHJpdmVycy4gQnV0IGl0IAptaWdodCBu
b3QgYmUgYSBiaWcgaXNzdWUgc2luY2Ugd2UgdHJ1c3Qga2VybmVsIHZpcnRpbyBkcml2ZXIuCgpT
byBJIHRoaW5rIGl0IG1ha2VzIHNlbnNlIHRvIGNoYW5nZSB0aGUgcmV0dXJuIHZhbHVlIGluIHRo
ZSB2ZHBhIGNvbmZpZyBvcHMuCgpUaGFua3MKCgo+Cj4gVGhhbmtzLAo+IFN0ZWZhbm8KPgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
