Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE17C6FD1D
	for <virtualization@archiver.kernel.org>; Fri, 17 Mar 2023 03:36:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ADC2B61339;
	Fri, 17 Mar 2023 03:36:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ADC2B61339
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b20ymZHW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B862nbPyzrO4; Fri, 17 Mar 2023 03:36:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3C26D6104D;
	Fri, 17 Mar 2023 03:36:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3C26D6104D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1EB74C0035;
	Fri, 17 Mar 2023 03:36:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D4C6C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 03:36:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 152664046A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 03:36:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 152664046A
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=b20ymZHW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lgXHn77L1bOc
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 03:36:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 11F1040129
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 11F1040129
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 03:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679024202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kq7BvkG6r8mc5f/+Ki2Y2nBhbeMzRIKO9qsutt2z3SM=;
 b=b20ymZHWIABhKOJeYFmcWWRZEmWcS9bE+lIRypWQ6lQO99ePtSInEmgNugBha2jqCqt7do
 DmoYbKpWHHKnzyzvF2THItrB73JLk2q+Potuu8GVP0HJLmVZKQrZY38YuXN1rVOF/hLhNg
 vzJ5utWBtMb5CsDJIGZjSoHrMxoO/c0=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-XcSeEteHOyyiq1hdH5jgsw-1; Thu, 16 Mar 2023 23:36:40 -0400
X-MC-Unique: XcSeEteHOyyiq1hdH5jgsw-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-17772c5c940so2263535fac.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 20:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679024200;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kq7BvkG6r8mc5f/+Ki2Y2nBhbeMzRIKO9qsutt2z3SM=;
 b=BlG/+NE6fOq+G/sve1Olb00NemJPjPGlwVYnqbUEFCHIfgaIOiVQHrOqHS9zfYTBk6
 5GtfdDsKXJSJWqhNbYozrF4Xe/9YlTAtXMBZsHJs9VkZ550MxgQqwk4P+y4aNl74W+d8
 eBz0CsD2/wtGFfWjn4cLUHz7QGvxSG1aZK7YZDFADzENzVgCqojWdxAf1hhy1FFa5xGU
 zYZ3GxnovYCNu1gDMKNyhUiZhCJdQCQxoTx1zTmFFhGcHxcja6bhMFhmGoVK3HuvtnWy
 voei5oAO8kuSkXADpm8tIzDow1dU53CBfhcj0EDZQ0ZjrOv41dywZ6B2gGwKUKY5vEeG
 H2Kw==
X-Gm-Message-State: AO0yUKWRRWzvfZyGYsAfN2qwJ5sXJEOVwFMJH97/eRIEOdRM1CcYoLaf
 Z69pzK0kcqQtYBTwGJAce5WmpH6ht1PJwr7aUSZflnZyU20TxNnLX3Df6ZrvU2koBAVPKMiCl/H
 isDQSPoz+CBAv9P/ilciok1NDbZOSe6mDxwSC0TAXT7aGzvAhWAIpycrZbg==
X-Received: by 2002:a54:470c:0:b0:383:fef9:6cac with SMTP id
 k12-20020a54470c000000b00383fef96cacmr2871248oik.9.1679024200057; 
 Thu, 16 Mar 2023 20:36:40 -0700 (PDT)
X-Google-Smtp-Source: AK7set+T6KPM6IMRqEx8BDN7YTTwmjdxGsCZRqnpMabFawh1Uhlesv2xEI0Lnd7ukW16F+PlFKNRCdgdDI0dwHM7/E0=
X-Received: by 2002:a54:470c:0:b0:383:fef9:6cac with SMTP id
 k12-20020a54470c000000b00383fef96cacmr2871242oik.9.1679024199853; Thu, 16 Mar
 2023 20:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230309013046.23523-1-shannon.nelson@amd.com>
 <20230309013046.23523-5-shannon.nelson@amd.com>
 <CACGkMEtcm+VeTUKw_DF=bHFpYRUyqOkhh+UEfc+ppUp5zuNVkw@mail.gmail.com>
 <cde38f74-66da-7eb0-c933-d4848bd17bc1@amd.com>
In-Reply-To: <cde38f74-66da-7eb0-c933-d4848bd17bc1@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 17 Mar 2023 11:36:28 +0800
Message-ID: <CACGkMEvm03ANeDKMQbVcoFzcgrHLEUXXXaar1JwYBG91J_THEQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 virtio 4/7] pds_vdpa: add vdpa config client
 commands
To: Shannon Nelson <shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: brett.creeley@amd.com, mst@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kuba@kernel.org,
 drivers@pensando.io, davem@davemloft.net
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVGh1LCBNYXIgMTYsIDIwMjMgYXQgMTE6MjXigK9BTSBTaGFubm9uIE5lbHNvbiA8c2hhbm5v
bi5uZWxzb25AYW1kLmNvbT4gd3JvdGU6Cj4KPiBPbiAzLzE1LzIzIDEyOjA1IEFNLCBKYXNvbiBX
YW5nIHdyb3RlOgo+ID4gT24gVGh1LCBNYXIgOSwgMjAyMyBhdCA5OjMx4oCvQU0gU2hhbm5vbiBO
ZWxzb24gPHNoYW5ub24ubmVsc29uQGFtZC5jb20+IHdyb3RlOgo+ID4+Cj4gPj4gVGhlc2UgYXJl
IHRoZSBhZG1pbnEgY29tbWFuZHMgdGhhdCB3aWxsIGJlIG5lZWRlZCBmb3IKPiA+PiBzZXR0aW5n
IHVwIGFuZCB1c2luZyB0aGUgdkRQQSBkZXZpY2UuCj4gPgo+ID4gSXQncyBiZXR0ZXIgdG8gZXhw
bGFpbiB1bmRlciB3aGljaCBjYXNlIHRoZSBkcml2ZXIgc2hvdWxkIHVzZSBhZG1pbnEsCj4gPiBJ
IHNlZSBzb21lIGZ1bmN0aW9ucyBvdmVybGFwIHdpdGggY29tbW9uIGNvbmZpZ3VyYXRpb24gY2Fw
YWJpbGl0eS4KPiA+IE1vcmUgYmVsb3cuCj4KPiBZZXMsIEkgYWdyZWUgdGhpcyBuZWVkcyB0byBi
ZSBtb3JlIGNsZWFybHkgc3RhdGVkLiAgVGhlIG92ZXJsYXAgaXMKPiBiZWNhdXNlIHRoZSBvcmln
aW5hbCBGVyBkaWRuJ3QgaGF2ZSB0aGUgdmlydGlvIGRldmljZSBhcyB3ZWxsIG1vZGVsZWQKPiBh
bmQgd2UgaGFkIHRvIGdvIHRocm91Z2ggYWRtaW5xIGNhbGxzIHRvIGdldCB0aGluZ3MgZG9uZS4K
CkRvZXMgdGhpcyBtZWFuIHRoZSBkZXZpY2UgY291bGQgYmUgYWN0dWFsbHkgcHJvYmVkIGJ5IGEg
dmlydGlvLXBjaSBkcml2ZXI/Cgo+ICBOb3cgdGhhdCB3ZQo+IGhhdmUgYSByZWFzb25hYmxlIHZp
cnRpbyBlbXVsYXRpb24gYW5kIGNhbiB1c2UgdGhlIHZpcnRpb19uZXRfY29uZmlnLCB3ZQo+IGhh
dmUgYSBsb3QgbGVzcyBuZWVkIGZvciB0aGUgYWRtaW5xIGNhbGxzLgoKUGxlYXNlIGFkZCB0aG9z
ZSBpbiB0aGUgY2hhbmdlbG9nLiBCdHcsIGFkbWlucSBzaG91bGQgYmUgbW9yZSBmbGV4aWJsZQpz
aW5jZSBpdCdzIGVhc2llciB0byBleHRlbmQgZm9yIG5ldyBmZWF0dXJlcy4gSWYgdGhlcmUncyBu
byBwbGFuIHRvCm1vZGVsIGEgdmlydGlvLXBjaSBkcml2ZXIgd2UgY2FuIGV2ZW4gYXZvaWQgbWFw
cGluZyBQQ0kgY2FwYWJpbGl0aWVzCndoaWNoIG1heSBzaW1wbGlmeSB0aGUgY29kZXMuCgpUaGFu
a3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
