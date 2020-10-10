Return-Path: <SRS0=bpJj=DR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F62AC433DF
	for <virtualization@archiver.kernel.org>; Sat, 10 Oct 2020 02:32:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D904D206D4
	for <virtualization@archiver.kernel.org>; Sat, 10 Oct 2020 02:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KgBdC8ka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D904D206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 62AF0200E5;
	Sat, 10 Oct 2020 02:32:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NWyzEtaU3qaZ; Sat, 10 Oct 2020 02:32:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3EF1B20334;
	Sat, 10 Oct 2020 02:32:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 163EEC016F;
	Sat, 10 Oct 2020 02:32:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B72BC0051
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 02:32:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 817D0872D5
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 02:32:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9JSzKXPb+DGD
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 02:32:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 87C7587293
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 02:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602297146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z0+yMqB5qWuc0BoeYtvqmNWdzEX4ZInq9BnlDhYqt00=;
 b=KgBdC8ka4pzzFX8+ylRSN7bTfgF9/IuE092YsI+crcZgMvdpRIcuRvyor5Tfh/6my4FnG5
 YgrMOYO1fDcZLyfhs2UAQDfv/ZcyWz5WrMF1Jrz3FIYEh7yWl63a9/G5ubJt4Ldo/w/qZ6
 MjOdwehFkLNU0AMXyomlTKHyZkYn7hY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-55hpNga7MaCPTcKGrULuZw-1; Fri, 09 Oct 2020 22:32:24 -0400
X-MC-Unique: 55hpNga7MaCPTcKGrULuZw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71949879514;
 Sat, 10 Oct 2020 02:32:22 +0000 (UTC)
Received: from [10.72.13.27] (ovpn-13-27.pek2.redhat.com [10.72.13.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D59260BE2;
 Sat, 10 Oct 2020 02:32:15 +0000 (UTC)
Subject: Re: [PATCH v3 2/3] vhost: Use vhost_get_used_size() in
 vhost_vring_set_addr()
To: Greg Kurz <groug@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>
References: <160171888144.284610.4628526949393013039.stgit@bahia.lan>
 <160171932300.284610.11846106312938909461.stgit@bahia.lan>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5fc896c6-e60d-db0b-f7b0-5b6806d70b8e@redhat.com>
Date: Sat, 10 Oct 2020 10:32:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <160171932300.284610.11846106312938909461.stgit@bahia.lan>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
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

Ck9uIDIwMjAvMTAvMyDkuIvljYg2OjAyLCBHcmVnIEt1cnogd3JvdGU6Cj4gVGhlIG9wZW4tY29k
ZWQgY29tcHV0YXRpb24gb2YgdGhlIHVzZWQgc2l6ZSBkb2Vzbid0IHRha2UgdGhlIGV2ZW50Cj4g
aW50byBhY2NvdW50IHdoZW4gdGhlIFZJUlRJT19SSU5HX0ZfRVZFTlRfSURYIGZlYXR1cmUgaXMg
cHJlc2VudC4KPiBGaXggdGhhdCBieSB1c2luZyB2aG9zdF9nZXRfdXNlZF9zaXplKCkuCj4KPiBT
aWduZWQtb2ZmLWJ5OiBHcmVnIEt1cnogPGdyb3VnQGthb2Qub3JnPgo+IC0tLQo+ICAgZHJpdmVy
cy92aG9zdC92aG9zdC5jIHwgICAgMyArLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3Zob3N0
LmMgYi9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiBpbmRleCBjM2I0OTk3NWRjMjguLjlkMmMyMjVm
YjUxOCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiArKysgYi9kcml2ZXJz
L3Zob3N0L3Zob3N0LmMKPiBAQCAtMTUxOSw4ICsxNTE5LDcgQEAgc3RhdGljIGxvbmcgdmhvc3Rf
dnJpbmdfc2V0X2FkZHIoc3RydWN0IHZob3N0X2RldiAqZCwKPiAgIAkJLyogQWxzbyB2YWxpZGF0
ZSBsb2cgYWNjZXNzIGZvciB1c2VkIHJpbmcgaWYgZW5hYmxlZC4gKi8KPiAgIAkJaWYgKChhLmZs
YWdzICYgKDB4MSA8PCBWSE9TVF9WUklOR19GX0xPRykpICYmCj4gICAJCQkhbG9nX2FjY2Vzc19v
ayh2cS0+bG9nX2Jhc2UsIGEubG9nX2d1ZXN0X2FkZHIsCj4gLQkJCQlzaXplb2YgKnZxLT51c2Vk
ICsKPiAtCQkJCXZxLT5udW0gKiBzaXplb2YgKnZxLT51c2VkLT5yaW5nKSkKPiArCQkJCSAgICAg
ICB2aG9zdF9nZXRfdXNlZF9zaXplKHZxLCB2cS0+bnVtKSkpCj4gICAJCQlyZXR1cm4gLUVJTlZB
TDsKPiAgIAl9Cj4gICAKPgo+CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0
LmNvbT4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
