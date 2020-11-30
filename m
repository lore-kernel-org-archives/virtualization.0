Return-Path: <SRS0=9iyF=FE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B13EC64E7B
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 03:29:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8C53206DF
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 03:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCOj/5rE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C53206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3AAA22150B;
	Mon, 30 Nov 2020 03:29:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H70RZYALLP5p; Mon, 30 Nov 2020 03:29:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 97BA3214EC;
	Mon, 30 Nov 2020 03:29:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8198DC163C;
	Mon, 30 Nov 2020 03:29:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B96BC0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:29:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 217C186BEA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:29:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hMBsLSMBqtkz
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:29:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4FCFC8697D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606706964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GKKzsrpUozh4PU7wUtMTDjDRAex2JbMT/+19r/pxuBo=;
 b=YCOj/5rEtd6YGd9NUVnm0vcXnssaX2xVH4DKu9sPjNmVNa9KQDT+HikLkdZdlv/mJWxYo/
 tAa+aWXqPpONx2S9gmydtOh9Oqd2ArNXDpyUefBW4Fc/DBydWQ/R/OodBspibyc0bUf5kR
 C0+FFU8acmC8Qmyzf0Ml2zim4jVvJJM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-iJ9iWcX4P0e550Bf4Qwlzw-1; Sun, 29 Nov 2020 22:29:19 -0500
X-MC-Unique: iJ9iWcX4P0e550Bf4Qwlzw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB158802B47;
 Mon, 30 Nov 2020 03:29:17 +0000 (UTC)
Received: from [10.72.13.173] (ovpn-13-173.pek2.redhat.com [10.72.13.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6259F60C5F;
 Mon, 30 Nov 2020 03:29:09 +0000 (UTC)
Subject: Re: [PATCH v2 16/17] vdpa_sim: split vdpasim_virtqueue's iov field in
 out_iov and in_iov
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-17-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5c01a00d-e7a9-2513-7e9f-39fc620c17c0@redhat.com>
Date: Mon, 30 Nov 2020 11:29:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126144950.92850-17-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

Ck9uIDIwMjAvMTEvMjYg5LiL5Y2IMTA6NDksIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiB2
cmluZ2hfZ2V0ZGVzY19pb3RsYigpIG1hbmFnZXMgMiBpb3ZzIGZvciB3cml0YWJsZSBhbmQgcmVh
ZGFibGUKPiBkZXNjcmlwdG9ycy4gVGhpcyBpcyB2ZXJ5IHVzZWZ1bCBmb3IgdGhlIGJsb2NrIGRl
dmljZSwgd2hlcmUgZm9yCj4gZWFjaCByZXF1ZXN0IHdlIGhhdmUgYm90aCB0eXBlcyBvZiBkZXNj
cmlwdG9yLgo+Cj4gTGV0J3Mgc3BsaXQgdGhlIHZkcGFzaW1fdmlydHF1ZXVlJ3MgaW92IGZpZWxk
IGluIG91dF9pb3YgYW5kCj4gaW5faW92IHRvIHVzZSB0aGVtIHdpdGggdnJpbmdoX2dldGRlc2Nf
aW90bGIoKS4KPgo+IFdlIGFyZSB1c2luZyBWSVJUSU8gdGVybWlub2xvZ3kgZm9yICJvdXQiIChy
ZWFkYWJsZSBieSB0aGUgZGV2aWNlKQo+IGFuZCAiaW4iICh3cml0YWJsZSBieSB0aGUgZGV2aWNl
KSBkZXNjcmlwdG9ycy4KPgo+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dh
cnphcmVAcmVkaGF0LmNvbT4KPiAtLS0KPiB2MjoKPiAtIHVzZWQgVklSVElPIHRlcm1pbm9sb2d5
IFtTdGVmYW5dCj4gLS0tCgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+CgoKPiAgIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jIHwgMTEgKysrKysrLS0t
LS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMgYi9kcml2ZXJz
L3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+IGluZGV4IGY1ZjQxZjIwZWUwYi4uZjhlZTI2MWVm
NGFlIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4gKysr
IGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPiBAQCAtMzMsNyArMzMsOCBAQCB1
OCBtYWNhZGRyX2J1ZltFVEhfQUxFTl07Cj4gICAKPiAgIHN0cnVjdCB2ZHBhc2ltX3ZpcnRxdWV1
ZSB7Cj4gICAJc3RydWN0IHZyaW5naCB2cmluZzsKPiAtCXN0cnVjdCB2cmluZ2hfa2lvdiBpb3Y7
Cj4gKwlzdHJ1Y3QgdnJpbmdoX2tpb3YgaW5faW92Owo+ICsJc3RydWN0IHZyaW5naF9raW92IG91
dF9pb3Y7Cj4gICAJdW5zaWduZWQgc2hvcnQgaGVhZDsKPiAgIAlib29sIHJlYWR5Owo+ICAgCXU2
NCBkZXNjX2FkZHI7Cj4gQEAgLTE5NywxMiArMTk4LDEyIEBAIHN0YXRpYyB2b2lkIHZkcGFzaW1f
bmV0X3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+ICAgCj4gICAJd2hpbGUgKHRydWUp
IHsKPiAgIAkJdG90YWxfd3JpdGUgPSAwOwo+IC0JCWVyciA9IHZyaW5naF9nZXRkZXNjX2lvdGxi
KCZ0eHEtPnZyaW5nLCAmdHhxLT5pb3YsIE5VTEwsCj4gKwkJZXJyID0gdnJpbmdoX2dldGRlc2Nf
aW90bGIoJnR4cS0+dnJpbmcsICZ0eHEtPm91dF9pb3YsIE5VTEwsCj4gICAJCQkJCSAgICZ0eHEt
PmhlYWQsIEdGUF9BVE9NSUMpOwo+ICAgCQlpZiAoZXJyIDw9IDApCj4gICAJCQlicmVhazsKPiAg
IAo+IC0JCWVyciA9IHZyaW5naF9nZXRkZXNjX2lvdGxiKCZyeHEtPnZyaW5nLCBOVUxMLCAmcnhx
LT5pb3YsCj4gKwkJZXJyID0gdnJpbmdoX2dldGRlc2NfaW90bGIoJnJ4cS0+dnJpbmcsIE5VTEws
ICZyeHEtPmluX2lvdiwKPiAgIAkJCQkJICAgJnJ4cS0+aGVhZCwgR0ZQX0FUT01JQyk7Cj4gICAJ
CWlmIChlcnIgPD0gMCkgewo+ICAgCQkJdnJpbmdoX2NvbXBsZXRlX2lvdGxiKCZ0eHEtPnZyaW5n
LCB0eHEtPmhlYWQsIDApOwo+IEBAIC0yMTAsMTMgKzIxMSwxMyBAQCBzdGF0aWMgdm9pZCB2ZHBh
c2ltX25ldF93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKPiAgIAkJfQo+ICAgCj4gICAJ
CXdoaWxlICh0cnVlKSB7Cj4gLQkJCXJlYWQgPSB2cmluZ2hfaW92X3B1bGxfaW90bGIoJnR4cS0+
dnJpbmcsICZ0eHEtPmlvdiwKPiArCQkJcmVhZCA9IHZyaW5naF9pb3ZfcHVsbF9pb3RsYigmdHhx
LT52cmluZywgJnR4cS0+b3V0X2lvdiwKPiAgIAkJCQkJCSAgICAgdmRwYXNpbS0+YnVmZmVyLAo+
ICAgCQkJCQkJICAgICBQQUdFX1NJWkUpOwo+ICAgCQkJaWYgKHJlYWQgPD0gMCkKPiAgIAkJCQli
cmVhazsKPiAgIAo+IC0JCQl3cml0ZSA9IHZyaW5naF9pb3ZfcHVzaF9pb3RsYigmcnhxLT52cmlu
ZywgJnJ4cS0+aW92LAo+ICsJCQl3cml0ZSA9IHZyaW5naF9pb3ZfcHVzaF9pb3RsYigmcnhxLT52
cmluZywgJnJ4cS0+aW5faW92LAo+ICAgCQkJCQkJICAgICAgdmRwYXNpbS0+YnVmZmVyLCByZWFk
KTsKPiAgIAkJCWlmICh3cml0ZSA8PSAwKQo+ICAgCQkJCWJyZWFrOwoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
