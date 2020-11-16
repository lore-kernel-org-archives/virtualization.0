Return-Path: <SRS0=Nqfw=EW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC09C4742C
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 04:32:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD69C222B9
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 04:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eMNvgmBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD69C222B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 41EE087152;
	Mon, 16 Nov 2020 04:32:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zPoxoAuimiLJ; Mon, 16 Nov 2020 04:32:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9CFBC870FB;
	Mon, 16 Nov 2020 04:32:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90113C0891;
	Mon, 16 Nov 2020 04:32:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2F16C07FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 04:32:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8876B2041E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 04:32:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lipzRinjm+rc
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 04:32:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 583C22001C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 04:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605501136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rWwwHi+vPJ8ujzj6hxsvoqxeQ6ueO5UlgElf6+sCWok=;
 b=eMNvgmBPjOTE/KG/ahvFKdvYCigf5BJBVzzSRDr+2BxUMfhmIirVeTew50FoR/S/xlH30f
 uXZ6Y9I7iz76rzGyGCeIQfqXLGVbbK2BMjFsz7MJNX+2Qvq99FHUljWHtLPLWPbXlJR1Ck
 1Srlb2lxQi/Q9qefHsZHwBYXhQvIGu4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-EPvhdJzgOy60UuEuZ9rE2A-1; Sun, 15 Nov 2020 23:32:15 -0500
X-MC-Unique: EPvhdJzgOy60UuEuZ9rE2A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 186831007474;
 Mon, 16 Nov 2020 04:32:14 +0000 (UTC)
Received: from [10.72.13.126] (ovpn-13-126.pek2.redhat.com [10.72.13.126])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 535C15B4C5;
 Mon, 16 Nov 2020 04:32:04 +0000 (UTC)
Subject: Re: [PATCH RFC 11/12] vringh: allow vringh_iov_xfer() to skip bytes
 when ptr is NULL
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-12-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a5cfe66f-5ae2-1a73-6010-74123721135b@redhat.com>
Date: Mon, 16 Nov 2020 12:32:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201113134712.69744-12-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>
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

Ck9uIDIwMjAvMTEvMTMg5LiL5Y2IOTo0NywgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IElu
IHNvbWUgY2FzZXMsIGl0IG1heSBiZSB1c2VmdWwgdG8gcHJvdmlkZSBhIHdheSB0byBza2lwIGEg
bnVtYmVyCj4gb2YgYnl0ZXMgaW4gYSB2cmluZ2hfaW92Lgo+Cj4gSW4gb3JkZXIgdG8ga2VlcCB2
cmluZ2hfaW92IGNvbnNpc3RlbnQsIGxldCdzIHJldXNlIHZyaW5naF9pb3ZfeGZlcigpCj4gbG9n
aWMgYW5kIHNraXAgYnl0ZXMgd2hlbiB0aGUgcHRyIGlzIE5VTEwuCj4KPiBTaWduZWQtb2ZmLWJ5
OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+Cj4gLS0tCj4KPiBJJ20g
bm90IHN1cmUgaWYgdGhpcyBpcyB0aGUgYmVzdCBvcHRpb24sIG1heWJlIHdlIGNhbiBhZGQgYSBu
ZXcKPiBmdW5jdGlvbiB2cmluZ2hfaW92X3NraXAoKS4KPgo+IFN1Z2dlc3Rpb25zPwoKCkkgbWln
aHQgYmUgd29ydGggdG8gY2hlY2sgd2hldGhlciB3ZSBjYW4gY29udmVydCB2cmluZ2hfaW92IHRv
IHVzZSBpb3YgCml0ZXJhdG9yIHRoZW4gd2UgY2FuIHVzZSBpb3ZfaXRlcmF0b3JfYWR2YW5jZSgp
IGhlcmUuCgpUaGFua3MKCgo+IC0tLQo+ICAgZHJpdmVycy92aG9zdC92cmluZ2guYyB8IDE2ICsr
KysrKysrKysrLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA1IGRl
bGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdnJpbmdoLmMgYi9kcml2
ZXJzL3Zob3N0L3ZyaW5naC5jCj4gaW5kZXggOGJkOGI0MDNmMDg3Li5lZDMyOTA5NDZhZDcgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy92aG9zdC92cmluZ2guYwo+ICsrKyBiL2RyaXZlcnMvdmhvc3Qv
dnJpbmdoLmMKPiBAQCAtNzUsNyArNzUsOSBAQCBzdGF0aWMgaW5saW5lIGludCBfX3ZyaW5naF9n
ZXRfaGVhZChjb25zdCBzdHJ1Y3QgdnJpbmdoICp2cmgsCj4gICAJcmV0dXJuIGhlYWQ7Cj4gICB9
Cj4gICAKPiAtLyogQ29weSBzb21lIGJ5dGVzIHRvL2Zyb20gdGhlIGlvdmVjLiAgUmV0dXJucyBu
dW0gY29waWVkLiAqLwo+ICsvKiBDb3B5IHNvbWUgYnl0ZXMgdG8vZnJvbSB0aGUgaW92ZWMuICBS
ZXR1cm5zIG51bSBjb3BpZWQuCj4gKyAqIElmIHB0ciBpcyBOVUxMLCBza2lwcyBhdCBtb3N0IGxl
biBieXRlcy4KPiArICovCj4gICBzdGF0aWMgaW5saW5lIHNzaXplX3QgdnJpbmdoX2lvdl94ZmVy
KHN0cnVjdCB2cmluZ2ggKnZyaCwKPiAgIAkJCQkgICAgICBzdHJ1Y3QgdnJpbmdoX2tpb3YgKmlv
diwKPiAgIAkJCQkgICAgICB2b2lkICpwdHIsIHNpemVfdCBsZW4sCj4gQEAgLTg5LDEyICs5MSwx
NiBAQCBzdGF0aWMgaW5saW5lIHNzaXplX3QgdnJpbmdoX2lvdl94ZmVyKHN0cnVjdCB2cmluZ2gg
KnZyaCwKPiAgIAkJc2l6ZV90IHBhcnRsZW47Cj4gICAKPiAgIAkJcGFydGxlbiA9IG1pbihpb3Yt
Pmlvdltpb3YtPmldLmlvdl9sZW4sIGxlbik7Cj4gLQkJZXJyID0geGZlcih2cmgsIGlvdi0+aW92
W2lvdi0+aV0uaW92X2Jhc2UsIHB0ciwgcGFydGxlbik7Cj4gLQkJaWYgKGVycikKPiAtCQkJcmV0
dXJuIGVycjsKPiArCj4gKwkJaWYgKHB0cikgewo+ICsJCQllcnIgPSB4ZmVyKHZyaCwgaW92LT5p
b3ZbaW92LT5pXS5pb3ZfYmFzZSwgcHRyLCBwYXJ0bGVuKTsKPiArCQkJaWYgKGVycikKPiArCQkJ
CXJldHVybiBlcnI7Cj4gKwkJCXB0ciArPSBwYXJ0bGVuOwo+ICsJCX0KPiArCj4gICAJCWRvbmUg
Kz0gcGFydGxlbjsKPiAgIAkJbGVuIC09IHBhcnRsZW47Cj4gLQkJcHRyICs9IHBhcnRsZW47Cj4g
ICAJCWlvdi0+Y29uc3VtZWQgKz0gcGFydGxlbjsKPiAgIAkJaW92LT5pb3ZbaW92LT5pXS5pb3Zf
bGVuIC09IHBhcnRsZW47Cj4gICAJCWlvdi0+aW92W2lvdi0+aV0uaW92X2Jhc2UgKz0gcGFydGxl
bjsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
