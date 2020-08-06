Return-Path: <SRS0=OwTx=BQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09861C433E0
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 03:23:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C772820792
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 03:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XX6JaTbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C772820792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2F7E022FF0;
	Thu,  6 Aug 2020 03:23:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b+0xqjmO8EKs; Thu,  6 Aug 2020 03:23:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 42E7822850;
	Thu,  6 Aug 2020 03:23:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 330CCC0051;
	Thu,  6 Aug 2020 03:23:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5882AC004C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 03:23:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4F4E486CE5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 03:23:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GFTA-FNGlzF4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 03:23:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7CEF186CDD
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 03:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596684194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JcQQIKoEvShj7Nz7KJ7jpLfenb6dvm9IOTqVH0VUY/E=;
 b=XX6JaTbDQvA7AZafGqAJQTyYjpl55bYh7lCzEA0IzlG79g/WHUK7r7lxpIPEX0uf9HjT2Z
 2/rgV5cot5XxmYXtcYrDMm1tj8rvUuMGgwsOXBPmFw+NVYRsXBStiNpFNJfhOTUNnunBxY
 JdJ/Npa64QKotmTd8KTFmcLL3TeQLI4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-JY9jGRHGNOugXsQyM-D3lg-1; Wed, 05 Aug 2020 23:23:12 -0400
X-MC-Unique: JY9jGRHGNOugXsQyM-D3lg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDE4F8017FB;
 Thu,  6 Aug 2020 03:23:11 +0000 (UTC)
Received: from [10.72.13.140] (ovpn-13-140.pek2.redhat.com [10.72.13.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB56D7B92E;
 Thu,  6 Aug 2020 03:23:07 +0000 (UTC)
Subject: Re: [PATCH v2 19/24] vdpa: make sure set_features in invoked for
 legacy
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-20-mst@redhat.com>
 <9e47d227-f220-4651-dcb9-7a11f059a715@redhat.com>
 <20200805073929-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <bd915b30-0604-da1b-343f-e228bce4d1d8@redhat.com>
Date: Thu, 6 Aug 2020 11:23:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805073929-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

Ck9uIDIwMjAvOC81IOS4i+WNiDc6NDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBPbiBX
ZWQsIEF1ZyAwNSwgMjAyMCBhdCAwMjoxNDowN1BNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+
PiBPbiAyMDIwLzgvNCDkuIrljYg1OjAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+PiBT
b21lIGxlZ2FjeSBndWVzdHMganVzdCBhc3N1bWUgZmVhdHVyZXMgYXJlIDAgYWZ0ZXIgcmVzZXQu
Cj4+PiBXZSBkZXRlY3QgdGhhdCBjb25maWcgc3BhY2UgaXMgYWNjZXNzZWQgYmVmb3JlIGZlYXR1
cmVzIGFyZQo+Pj4gc2V0IGFuZCBzZXQgZmVhdHVyZXMgdG8gMCBhdXRvbWF0aWNhbGx5Lgo+Pj4g
Tm90ZTogc29tZSBsZWdhY3kgZ3Vlc3RzIG1pZ2h0IG5vdCBldmVuIGFjY2VzcyBjb25maWcgc3Bh
Y2UsIGlmIHRoaXMgaXMKPj4+IHJlcG9ydGVkIGluIHRoZSBmaWVsZCB3ZSBtaWdodCBuZWVkIHRv
IGNhdGNoIGEga2ljayB0byBoYW5kbGUgdGhlc2UuCj4+IEkgd29uZGVyIHdoZXRoZXIgaXQncyBl
YXNpZXIgdG8ganVzdCBzdXBwb3J0IG1vZGVybiBkZXZpY2U/Cj4+Cj4+IFRoYW5rcwo+IFdlbGwg
aGFyZHdhcmUgdmVuZG9ycyBhcmUgSSB0aGluayBpbnRlcmVzdGVkIGluIHN1cHBvcnRpbmcgbGVn
YWN5Cj4gZ3Vlc3RzLiBMaW1pdGluZyB2ZHBhIHRvIG1vZGVybiBvbmx5IHdvdWxkIG1ha2UgaXQg
dW5jb21wZXRpdGl2ZS4KCgpNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQsIElPTU1VX1BMQVRGT1JN
IGlzIG1hbmRhdG9yeSBmb3IgaGFyZHdhcmUgdkRQQSAKdG8gd29yay4gU28gaXQgY2FuIG9ubHkg
d29yayBmb3IgbW9kZXJuIGRldmljZSAuLi4KClRoYW5rcwoKCj4KPgo+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
