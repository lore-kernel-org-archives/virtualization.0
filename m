Return-Path: <SRS0=lZ9m=FO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66256C4361B
	for <virtualization@archiver.kernel.org>; Thu, 10 Dec 2020 09:11:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C198E23D23
	for <virtualization@archiver.kernel.org>; Thu, 10 Dec 2020 09:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C198E23D23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3667F2011B;
	Thu, 10 Dec 2020 09:11:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T8Fs8GLleiHy; Thu, 10 Dec 2020 09:11:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6AAF720029;
	Thu, 10 Dec 2020 09:11:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49A85C0FA7;
	Thu, 10 Dec 2020 09:11:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58B2AC013B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 09:11:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 54FF58766D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 09:11:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id syTIEiXI2Kcz
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 09:11:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CC73A8766A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 09:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607591476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gb3SbnRTo+3pkXXdNLxcd5ljhhUyYYdpcGHBH8tC1V0=;
 b=ZZbUb9Ue/CRtXFx/SakRKa3/fp+9zpKu9Zuuq7RM2KRUc3NDyAcsHmCYTC/h1QpgegMbTM
 r649zVtTVBlNmrLGBTUdRV6oWIahL41XT65mniWtLrSBoKPJ5uu+8CkO3HNtgunmseD8RE
 EqaULq5KRgF7Ox6wyIuA47UvMn91nZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-8hJn_FKvPdSa1KjmAx1-Xg-1; Thu, 10 Dec 2020 04:11:14 -0500
X-MC-Unique: 8hJn_FKvPdSa1KjmAx1-Xg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF953802B49;
 Thu, 10 Dec 2020 09:11:13 +0000 (UTC)
Received: from [10.72.12.50] (ovpn-12-50.pek2.redhat.com [10.72.12.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD8E160BF1;
 Thu, 10 Dec 2020 09:11:03 +0000 (UTC)
Subject: Re: [PATCH v1] vdpa/mlx5: Use write memory barrier after updating CQ
 index
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20201209140004.15892-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <26dd1676-ff63-4940-9b0d-d7097950c1e5@redhat.com>
Date: Thu, 10 Dec 2020 17:11:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201209140004.15892-1-elic@nvidia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: maxime.coquelin@redhat.com, lulu@redhat.com
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

Ck9uIDIwMjAvMTIvOSDkuIvljYgxMDowMCwgRWxpIENvaGVuIHdyb3RlOgo+IE1ha2Ugc3VyZSB0
byBwdXQgZG1hIHdyaXRlIG1lbW9yeSBiYXJyaWVyIGFmdGVyIHVwZGF0aW5nIENRIGNvbnN1bWVy
Cj4gaW5kZXggc28gdGhlIGhhcmR3YXJlIGtub3dzIHRoYXQgdGhlcmUgYXJlIGF2YWlsYWJsZSBD
UUUgc2xvdHMgaW4gdGhlCj4gcXVldWUuCj4KPiBGYWlsdXJlIHRvIGRvIHRoaXMgY2FuIGNhdXNl
IHRoZSB1cGRhdGUgb2YgdGhlIFJYIGRvb3JiZWxsIHJlY29yZCB0byBnZXQKPiB1cGRhdGVkIGJl
Zm9yZSB0aGUgQ1EgY29uc3VtZXIgaW5kZXggcmVzdWx0aW5nIGluIENRIG92ZXJydW4uCj4KPiBG
aXhlczogMWE4NmIzNzdhYTIxICgidmRwYS9tbHg1OiBBZGQgVkRQQSBkcml2ZXIgZm9yIHN1cHBv
cnRlZCBtbHg1IGRldmljZXMiKQo+IFNpZ25lZC1vZmYtYnk6IEVsaSBDb2hlbiA8ZWxpY0Budmlk
aWEuY29tPgo+IC0tLQo+IFYwIC0+IFYxCj4gVXNlIGRtYV93bWIoKSBpbnN0ZWFkIG9mIHdtYigp
CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPgo+ICAgZHJp
dmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIHwgNSArKysrKwo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25l
dC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+IGluZGV4
IGRiODdhYmMzY2I2MC4uNDNiMDA2OWZmOGIxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9t
bHg1L25ldC9tbHg1X3ZuZXQuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3Zu
ZXQuYwo+IEBAIC00NzksNiArNDc5LDExIEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBhX3BvbGxfb25l
KHN0cnVjdCBtbHg1X3ZkcGFfY3EgKnZjcSkKPiAgIHN0YXRpYyB2b2lkIG1seDVfdmRwYV9oYW5k
bGVfY29tcGxldGlvbnMoc3RydWN0IG1seDVfdmRwYV92aXJ0cXVldWUgKm12cSwgaW50IG51bSkK
PiAgIHsKPiAgIAltbHg1X2NxX3NldF9jaSgmbXZxLT5jcS5tY3EpOwo+ICsKPiArCS8qIG1ha2Ug
c3VyZSBDUSBjb3N1bWVyIHVwZGF0ZSBpcyB2aXNpYmxlIHRvIHRoZSBoYXJkd2FyZSBiZWZvcmUg
dXBkYXRpbmcKPiArCSAqIFJYIGRvb3JiZWxsIHJlY29yZC4KPiArCSAqLwo+ICsJZG1hX3dtYigp
Owo+ICAgCXJ4X3Bvc3QoJm12cS0+dnFxcCwgbnVtKTsKPiAgIAlpZiAobXZxLT5ldmVudF9jYi5j
YWxsYmFjaykKPiAgIAkJbXZxLT5ldmVudF9jYi5jYWxsYmFjayhtdnEtPmV2ZW50X2NiLnByaXZh
dGUpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
