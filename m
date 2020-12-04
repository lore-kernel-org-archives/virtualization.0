Return-Path: <SRS0=VsiN=FI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737B3C4361A
	for <virtualization@archiver.kernel.org>; Fri,  4 Dec 2020 08:09:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBFE8225A9
	for <virtualization@archiver.kernel.org>; Fri,  4 Dec 2020 08:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBFE8225A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1CC1520768;
	Fri,  4 Dec 2020 08:09:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sK+CG4XA22JD; Fri,  4 Dec 2020 08:09:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 42962204EA;
	Fri,  4 Dec 2020 08:09:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DC6AC0FA7;
	Fri,  4 Dec 2020 08:09:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34D94C013B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 08:09:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1BCF287BFF
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 08:09:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0ccsQXmdgREO
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 08:09:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3B17D87BF0
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 08:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607069388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7PzD8ci+JJSUGwk83KFpOt0nd1ee50ac53SGYVA8XcE=;
 b=FEAwryQnLilpSZ8I+G3S4656zRuq+XO40X5gumLQYhDcSHciwfoPCSIoFKVDZtKvzQUHib
 Exy9DqJ9E09Gt7V3fqpwcygS3J9s2okzO5iLZxMUfD8DF9OT1fSCXDIspYYdgMsJqqPvCM
 IzSPNyamVwW4M0pUzxyKKBlzWx7mhIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-KFTildZxNF2BQ1FQWqstdA-1; Fri, 04 Dec 2020 03:09:44 -0500
X-MC-Unique: KFTildZxNF2BQ1FQWqstdA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56E85802B40;
 Fri,  4 Dec 2020 08:09:43 +0000 (UTC)
Received: from [10.72.12.116] (ovpn-12-116.pek2.redhat.com [10.72.12.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 847A61A8A4;
 Fri,  4 Dec 2020 08:09:34 +0000 (UTC)
Subject: Re: [RFC PATCH 5/8] vhost: allow userspace to bind vqs to CPUs
To: Mike Christie <michael.christie@oracle.com>, sgarzare@redhat.com,
 stefanha@redhat.com, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, mst@redhat.com, pbonzini@redhat.com,
 virtualization@lists.linux-foundation.org
References: <1607068593-16932-1-git-send-email-michael.christie@oracle.com>
 <1607068593-16932-6-git-send-email-michael.christie@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4546ef72-da7c-df9e-53be-c937a5437436@redhat.com>
Date: Fri, 4 Dec 2020 16:09:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1607068593-16932-6-git-send-email-michael.christie@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

Ck9uIDIwMjAvMTIvNCDkuIvljYgzOjU2LCBNaWtlIENocmlzdGllIHdyb3RlOgo+ICtzdGF0aWMg
bG9uZyB2aG9zdF92cmluZ19zZXRfY3B1KHN0cnVjdCB2aG9zdF9kZXYgKmQsIHN0cnVjdCB2aG9z
dF92aXJ0cXVldWUgKnZxLAo+ICsJCQkJdm9pZCBfX3VzZXIgKmFyZ3ApCj4gK3sKPiArCXN0cnVj
dCB2aG9zdF92cmluZ19zdGF0ZSBzOwo+ICsJaW50IHJldCA9IDA7Cj4gKwo+ICsJaWYgKHZxLT5w
cml2YXRlX2RhdGEpCj4gKwkJcmV0dXJuIC1FQlVTWTsKPiArCj4gKwlpZiAoY29weV9mcm9tX3Vz
ZXIoJnMsIGFyZ3AsIHNpemVvZiBzKSkKPiArCQlyZXR1cm4gLUVGQVVMVDsKPiArCj4gKwlpZiAo
cy5udW0gPT0gLTEpIHsKPiArCQl2cS0+Y3B1ID0gcy5udW07Cj4gKwkJcmV0dXJuIDA7Cj4gKwl9
Cj4gKwo+ICsJaWYgKHMubnVtID49IG5yX2NwdV9pZHMpCj4gKwkJcmV0dXJuIC1FSU5WQUw7Cj4g
Kwo+ICsJaWYgKCFkLT5vcHMgfHwgIWQtPm9wcy0+Z2V0X3dvcmtxdWV1ZSkKPiArCQlyZXR1cm4g
LUVJTlZBTDsKPiArCj4gKwlpZiAoIWQtPndxKQo+ICsJCWQtPndxID0gZC0+b3BzLT5nZXRfd29y
a3F1ZXVlKCk7Cj4gKwlpZiAoIWQtPndxKQo+ICsJCXJldHVybiAtRUlOVkFMOwo+ICsKPiArCXZx
LT5jcHUgPSBzLm51bTsKPiArCXJldHVybiByZXQ7Cj4gK30KCgpTbyBvbmUgcXVlc3Rpb24gaGVy
ZS4gV2hvIGlzIGluIGNoYXJnZSBvZiBkb2luZyB0aGlzIHNldF9jcHU/IE5vdGUgCnRoYXTCoHNj
aGVkX3NldGFmZmluaXR5KDIpIHJlcXVpcmVzIENBUF9TWVNfTklDRSB0byB3b3JrLCBzbyBJIHdv
bmRlciAKd2hldGhlciBvciBub3QgaXQncyBsZWdhbCBmb3IgdW5wcml2aWxlZ2VkIFFlbXUgdG8g
ZG8gdGhpcy4KClRoYW5rcwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
