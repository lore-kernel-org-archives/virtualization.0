Return-Path: <SRS0=OwTx=BQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B65C433E0
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 03:37:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C671122B40
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 03:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oh+3rFcX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C671122B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 77CC2881AC;
	Thu,  6 Aug 2020 03:37:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sdSLZuGGOyum; Thu,  6 Aug 2020 03:37:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D9D4E88172;
	Thu,  6 Aug 2020 03:37:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C01B6C0051;
	Thu,  6 Aug 2020 03:37:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 379E8C004C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 03:37:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 04DCC2343B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 03:37:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tidd0BtZDudt
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 03:37:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by silver.osuosl.org (Postfix) with ESMTPS id E9A63232D2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 03:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596685066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y0/VXs+49Tf/58Sjz8LOy4NeNinqvStP7kb/YaGK0P8=;
 b=Oh+3rFcXKl3/aq6Q7vUJsfKOGpD6nn980qNj/yiK/UprZv6AqzjyPql1lUgQTsXWs+oGjI
 kYwqYogVdDSRf3W2jGHPRuBMCvKTamkD6Mxl1pFsp16ZslVqlj6pT0B8yAQKqqJB9IBITj
 AMjC4xk6brWAM/k2hnbz2gRum7/yhu0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-Jy2ewWUWMiOChdw0cmnpfw-1; Wed, 05 Aug 2020 23:37:45 -0400
X-MC-Unique: Jy2ewWUWMiOChdw0cmnpfw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 517661005510;
 Thu,  6 Aug 2020 03:37:44 +0000 (UTC)
Received: from [10.72.13.140] (ovpn-13-140.pek2.redhat.com [10.72.13.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 38BBC65C6D;
 Thu,  6 Aug 2020 03:37:39 +0000 (UTC)
Subject: Re: [PATCH v2 03/24] virtio: allow __virtioXX, __leXX in config space
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-4-mst@redhat.com>
 <ce85a206-45a6-da3d-45a7-06f068f3bad7@redhat.com>
 <20200805074434-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4aa65ad6-5324-0a8c-0fa6-0d8e680f0706@redhat.com>
Date: Thu, 6 Aug 2020 11:37:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805074434-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjAvOC81IOS4i+WNiDc6NDUsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4+ICAg
ICNkZWZpbmUgdmlydGlvX2NyZWFkKHZkZXYsIHN0cnVjdG5hbWUsIG1lbWJlciwgcHRyKQkJCVwK
Pj4+ICAgIAlkbyB7CQkJCQkJCQlcCj4+PiAgICAJCW1pZ2h0X3NsZWVwKCk7CQkJCQkJXAo+Pj4g
ICAgCQkvKiBNdXN0IG1hdGNoIHRoZSBtZW1iZXIncyB0eXBlLCBhbmQgYmUgaW50ZWdlciAqLwlc
Cj4+PiAtCQlpZiAoIXR5cGVjaGVjayh0eXBlb2YoKCgoc3RydWN0bmFtZSopMCktPm1lbWJlcikp
LCAqKHB0cikpKSBcCj4+PiArCQlpZiAoIV9fdmlydGlvX3R5cGVjaGVjayhzdHJ1Y3RuYW1lLCBt
ZW1iZXIsICoocHRyKSkpCVwKPj4+ICAgIAkJCSgqcHRyKSA9IDE7CQkJCQlcCj4+IEEgc2lsbHkg
cXVlc3Rpb24swqAgY29tcGFyZSB0byB1c2luZyBzZXQoKS9nZXQoKSBkaXJlY3RseSwgd2hhdCdz
IHRoZSB2YWx1ZQo+PiBvZiB0aGUgYWNjZXNzb3JzIG1hY3JvIGhlcmU/Cj4+Cj4+IFRoYW5rcwo+
IGdldC9zZXQgZG9uJ3QgY29udmVydCB0byB0aGUgbmF0aXZlIGVuZGlhbiwgSSBndWVzcyB0aGF0
J3Mgd2h5Cj4gZHJpdmVycyB1c2UgY3JlYWQvY3dyaXRlLiBJdCBpcyBhbHNvIG5pY2UgdGhhdCB0
aGVyZSdzIHR5cGUKPiBzYWZldHksIGNoZWNraW5nIHRoZSBjb3JyZWN0IGludGVnZXIgd2lkdGgg
aXMgdXNlZC4KCgpZZXMsIGJ1dCB0aGlzIGlzIHNpbXBseSBiZWNhdXNlIGEgbWFjcm8gaXMgdXNl
ZCBoZXJlLCBob3cgYWJvdXQganVzdCAKZG9pbmcgdGhpbmdzIHNpbWlsYXIgbGlrZSB2aXJ0aW9f
Y3JlYWRfYnl0ZXMoKToKCnN0YXRpYyBpbmxpbmUgdm9pZCB2aXJ0aW9fY3JlYWQoc3RydWN0IHZp
cnRpb19kZXZpY2UgKnZkZXYsCiDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgwqDC
oCB1bnNpZ25lZCBpbnQgb2Zmc2V0LAogwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDC
oMKgwqAgdm9pZCAqYnVmLCBzaXplX3QgbGVuKQoKCkFuZCBkbyB0aGUgZW5kaWFuIGNvbnZlcnNp
b24gaW5zaWRlPwoKVGhhbmtzCgoKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
