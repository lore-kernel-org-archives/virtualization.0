Return-Path: <SRS0=Nqfw=EW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E53C61DD8
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 04:19:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CAB9222B9
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 04:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUZJqldG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CAB9222B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A65F820420;
	Mon, 16 Nov 2020 04:19:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BFWnAyHM0-Cm; Mon, 16 Nov 2020 04:19:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 78888203C7;
	Mon, 16 Nov 2020 04:19:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E665C0891;
	Mon, 16 Nov 2020 04:19:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C2FEC07FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 04:19:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7B83D868A9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 04:19:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id La+CZ-HuImiC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 04:19:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8E3BD8689E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 04:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605500370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oRixjjrThv6WRA1ni2cjNfsJ7/babpRlPyaRC5yiRXI=;
 b=RUZJqldG4g662FnR2sSAq8ZtgZpki9YSOQYzMtMwnXTBLa8qtbtVnPaqSePbDM1M7tB2U8
 CTpimkzM6W2UmQmrjArFdgoFN1FOwPPTFWmziF42JeSvi5otINfrPKLu7xNUMO7h/WjeIO
 zjb/JOUaTazvswdaoBHDGtpyq0arXlg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-JbdGTnARPB-1fZl4jQsoxA-1; Sun, 15 Nov 2020 23:19:28 -0500
X-MC-Unique: JbdGTnARPB-1fZl4jQsoxA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39A451074654;
 Mon, 16 Nov 2020 04:19:27 +0000 (UTC)
Received: from [10.72.13.126] (ovpn-13-126.pek2.redhat.com [10.72.13.126])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 367795D9CC;
 Mon, 16 Nov 2020 04:19:18 +0000 (UTC)
Subject: Re: [PATCH RFC 08/12] vdpa_sim: use kvmalloc to allocate
 vdpasim->buffer
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-9-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9956d3c1-8464-ef70-a21a-7abaaa948fd2@redhat.com>
Date: Mon, 16 Nov 2020 12:19:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201113134712.69744-9-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Ck9uIDIwMjAvMTEvMTMg5LiL5Y2IOTo0NywgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IFRo
ZSBuZXh0IHBhdGNoIHdpbGwgbWFrZSB0aGUgYnVmZmVyIHNpemUgY29uZmlndXJhYmxlIGZyb20g
ZWFjaAo+IGRldmljZS4KPiBTaW5jZSB0aGUgYnVmZmVyIGNvdWxkIGJlIGxhcmdlciB0aGFuIGEg
cGFnZSwgd2UgdXNlIGt2bWFsbG9jKCkKPiBpbnN0ZWFkIG9mIGttYWxsb2MoKS4KPgo+IFNpZ25l
ZC1vZmYtYnk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4KCgpBY2tl
ZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRoYW5rcwoKCj4gLS0tCj4g
ICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYyB8IDQgKystLQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92
ZHBhX3NpbS5jCj4gaW5kZXggOWMyOWMyMDEzNjYxLi5iZDAzNGZiZjQ2ODMgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPiArKysgYi9kcml2ZXJzL3ZkcGEv
dmRwYV9zaW0vdmRwYV9zaW0uYwo+IEBAIC0yMjMsNyArMjIzLDcgQEAgc3RydWN0IHZkcGFzaW0g
KnZkcGFzaW1fY3JlYXRlKHN0cnVjdCB2ZHBhc2ltX2luaXRfYXR0ciAqYXR0cikKPiAgIAlpZiAo
IXZkcGFzaW0tPmlvbW11KQo+ICAgCQlnb3RvIGVycl9pb21tdTsKPiAgIAo+IC0JdmRwYXNpbS0+
YnVmZmVyID0ga21hbGxvYyhQQUdFX1NJWkUsIEdGUF9LRVJORUwpOwo+ICsJdmRwYXNpbS0+YnVm
ZmVyID0ga3ZtYWxsb2MoUEFHRV9TSVpFLCBHRlBfS0VSTkVMKTsKPiAgIAlpZiAoIXZkcGFzaW0t
PmJ1ZmZlcikKPiAgIAkJZ290byBlcnJfaW9tbXU7Cj4gICAKPiBAQCAtNDk1LDcgKzQ5NSw3IEBA
IHN0YXRpYyB2b2lkIHZkcGFzaW1fZnJlZShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEpCj4gICAJ
c3RydWN0IHZkcGFzaW0gKnZkcGFzaW0gPSB2ZHBhX3RvX3NpbSh2ZHBhKTsKPiAgIAo+ICAgCWNh
bmNlbF93b3JrX3N5bmMoJnZkcGFzaW0tPndvcmspOwo+IC0Ja2ZyZWUodmRwYXNpbS0+YnVmZmVy
KTsKPiArCWt2ZnJlZSh2ZHBhc2ltLT5idWZmZXIpOwo+ICAgCWlmICh2ZHBhc2ltLT5pb21tdSkK
PiAgIAkJdmhvc3RfaW90bGJfZnJlZSh2ZHBhc2ltLT5pb21tdSk7Cj4gICAJa2ZyZWUodmRwYXNp
bS0+dnFzKTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
