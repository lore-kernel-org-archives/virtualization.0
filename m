Return-Path: <SRS0=9iyF=FE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DCDC63777
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 03:32:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 548C4206DF
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 03:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PD3GIFW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548C4206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E526786D92;
	Mon, 30 Nov 2020 03:32:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dqgp-65ydSiE; Mon, 30 Nov 2020 03:32:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 44C5186D94;
	Mon, 30 Nov 2020 03:32:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19BAFC163C;
	Mon, 30 Nov 2020 03:32:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28EA3C0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:32:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0130F21503
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:32:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kwUye1Zk-Tzt
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:31:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id F1844214EC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606707117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I0HRTFCFoP29oy6MJspA5BbLf81O/XKx0AAg815vRN8=;
 b=PD3GIFW2NQOq5dkQdsyWJinlG2bIlQixXO4aYhykWZYmpho+BkRz/O9iEyfZXmbGLv9fEl
 EaHHxooQQylCavhZE1MEM1RMQz1ZGvUP0deAWG8kBT3WvJpc70JXKzbzyLEuk8Yikqzetj
 OxEOZaJNmqNeIvaTHR2UYUvjpVLhpVg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-wqITtZ1iMMKoCD3kiCzHrA-1; Sun, 29 Nov 2020 22:31:55 -0500
X-MC-Unique: wqITtZ1iMMKoCD3kiCzHrA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2215880EDB5;
 Mon, 30 Nov 2020 03:31:54 +0000 (UTC)
Received: from [10.72.13.173] (ovpn-13-173.pek2.redhat.com [10.72.13.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 36A6710016F4;
 Mon, 30 Nov 2020 03:31:44 +0000 (UTC)
Subject: Re: [PATCH v2 17/17] vdpa: split vdpasim to core and net modules
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-18-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ce5f1f8b-a0e2-5c3f-2e49-48e0379d1bba@redhat.com>
Date: Mon, 30 Nov 2020 11:31:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126144950.92850-18-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

Ck9uIDIwMjAvMTEvMjYg5LiL5Y2IMTA6NDksIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiBG
cm9tOiBNYXggR3VydG92b3k8bWd1cnRvdm95QG52aWRpYS5jb20+Cj4KPiBJbnRyb2R1Y2UgbmV3
IHZkcGFfc2ltX25ldCBhbmQgdmRwYV9zaW0gKGNvcmUpIGRyaXZlcnMuIFRoaXMgaXMgYQo+IHBy
ZXBhcmF0aW9uIGZvciBhZGRpbmcgYSB2ZHBhIHNpbXVsYXRvciBtb2R1bGUgZm9yIGJsb2NrIGRl
dmljZXMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBNYXggR3VydG92b3k8bWd1cnRvdm95QG52aWRpYS5j
b20+Cj4gW3NnYXJ6YXJlOiB2YXJpb3VzIGNsZWFudXBzL2ZpeGVzXQo+IFNpZ25lZC1vZmYtYnk6
IFN0ZWZhbm8gR2FyemFyZWxsYTxzZ2FyemFyZUByZWRoYXQuY29tPgo+IC0tLQo+IHYyOgo+IC0g
Rml4ZWQgIndhcm5pbmc6IHZhcmlhYmxlICdkZXYnIGlzIHVzZWQgdW5pbml0aWFsaXplZCIgcmVw
b3J0ZWQgYnkKPiAgICAna2VybmVsIHRlc3Qgcm9ib3QnIGFuZCBEYW4gQ2FycGVudGVyCj4gLSBy
ZWJhc2VkIG9uIHRvcCBvZiBvdGhlciBjaGFuZ2VzIChkZXZfYXR0ciwgZ2V0X2NvbmZpZygpLCBu
b3RpZnkoKSwgZXRjLikKPiAtIGxlZnQgYmF0Y2hfbWFwcGluZyBtb2R1bGUgcGFyYW1ldGVyIGlu
IHRoZSBjb3JlIFtKYXNvbl0KPgo+IHYxOgo+IC0gUmVtb3ZlZCB1bnVzZWQgaGVhZGVycwo+IC0g
UmVtb3ZlZCBlbXB0eSBtb2R1bGVfaW5pdCgpIG1vZHVsZV9leGl0KCkKPiAtIE1vdmVkIHZkcGFz
aW1faXNfbGl0dGxlX2VuZGlhbigpIGluIHZkcGFfc2ltLmgKPiAtIE1vdmVkIHZkcGFzaW0xNl90
b19jcHUvY3B1X3RvX3ZkcGFzaW0xNigpIGluIHZkcGFfc2ltLmgKPiAtIEFkZGVkIHZkcGFzaW0q
X3RvX2NwdS9jcHVfdG9fdmRwYXNpbSooKSBhbHNvIGZvciAzMiBhbmQgNjQKPiAtIFJlcGxhY2Vk
ICdzZWxlY3QgVkRQQV9TSU0nIHdpdGggJ2RlcGVuZHMgb24gVkRQQV9TSU0nIHNpbmNlIHNlbGVj
dGVkCj4gICAgb3B0aW9uIGNhbiBub3QgZGVwZW5kIG9uIG90aGVyIFtKYXNvbl0KPiAtLS0KPiAg
IGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5oICAgICB8IDEwMyArKysrKysrKysrKysr
Cj4gICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYyAgICAgfCAyMjIgKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCj4gICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fbmV0
LmMgfCAxNzEgKysrKysrKysrKysrKysrKysrKysrCj4gICBkcml2ZXJzL3ZkcGEvS2NvbmZpZyAg
ICAgICAgICAgICAgICAgfCAgMTMgKy0KPiAgIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS9NYWtlZmls
ZSAgICAgICB8ICAgMSArCj4gICA1IGZpbGVzIGNoYW5nZWQsIDI5MCBpbnNlcnRpb25zKCspLCAy
MjAgZGVsZXRpb25zKC0pCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy92ZHBhL3ZkcGFf
c2ltL3ZkcGFfc2ltLmgKPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3ZkcGEvdmRwYV9z
aW0vdmRwYV9zaW1fbmV0LmMKCgpMb29rcyBnb29kLCBjb25zaWRlciB0aGVyZSBhcmUgc29tZSBz
dGlsbCBzb21lIHF1ZXN0aW9ucyBsZWZ0LiBJIHdpbGwgCnByb2JhYmx5IGFjayBmb3IgdGhlIG5l
eHQgdmVyc2lvbi4KClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
