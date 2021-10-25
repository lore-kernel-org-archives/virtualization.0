Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71350C433F5
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 08:09:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EC1060EBD
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 08:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1EC1060EBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D8EE26082F;
	Mon, 25 Oct 2021 08:09:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PwHXq1anussA; Mon, 25 Oct 2021 08:09:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 99D0E60737;
	Mon, 25 Oct 2021 08:09:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80B4EC0019;
	Mon, 25 Oct 2021 08:09:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D0F9C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 08:09:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4B2DC400DA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 08:09:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fnaxe9f0AY7n
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 08:09:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7A764400C4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 08:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635149354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qwNz1OzfVxbZpS9T9R5N3CImTA+2n4G/TOhUkIMrKaM=;
 b=PTw+HTK2ONftTFOGAxg5AimUJiNjL0Umsiysz6/2W79wGMf0eg110+Fy5+17f2fJI5ZJCI
 wufz4mV5jPieEg1kj9+VGb+QVWKmdaa/Q/FAWdULk0DCZRdBYJJ6pB6khdLkx+2KKymVYk
 +2UTUrONpkPzsvB1mxxti8x7eWHoruM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-Z5VaOb5OPhKfKqUAfa15Nw-1; Mon, 25 Oct 2021 04:09:12 -0400
X-MC-Unique: Z5VaOb5OPhKfKqUAfa15Nw-1
Received: by mail-ed1-f71.google.com with SMTP id
 k28-20020a508adc000000b003dd5e21da4bso1484250edk.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 01:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=qwNz1OzfVxbZpS9T9R5N3CImTA+2n4G/TOhUkIMrKaM=;
 b=m4cHolNS4Xym4pqOzkHrrA3lxavoGEKHgboj9MkQty9EhI2sviflkh7JfxBiOT+DgK
 RU0NtRflIKEHS4aMTDkpY8sK5Kjqhli0twttCrVgl6EWsnUuTQcqu9L0W/U3NAzqBmgS
 yjT3mOHatnd+xQXuWPOEqtxmSNKpBu+wilVPuYv43YQQtvD1gdoL3QohrdXSObRrZiu3
 4rMFI8Az7A69UOrC0S4YGfFTkx6cyD+NsoVyCRlfEXFbrNs0r9AFAqPOcaMDQljTc26A
 UI0beoBwszmyshd9mLtOPjK6jZP46C0gw79pa9/4sMJuFyqQ3yekbWNNRUBpWuowslHR
 hPJw==
X-Gm-Message-State: AOAM530mOGR4yfVuQgMjaNu1pfF4x7rd0QWFAyw9Q5GHHVGlhe/DdW4l
 y7pwjErq3Z1Z62BY795QRfJ6eW/yOlSDhxi8RLTVu3dwz+qnWuIEIdvUUeM1zS2jbvW/cBzplvC
 Sh03a9fFwb5JR1CUYURzdDJMMnJxXmTwitWhO3FDtJg==
X-Received: by 2002:aa7:da84:: with SMTP id q4mr24543668eds.371.1635149351773; 
 Mon, 25 Oct 2021 01:09:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5XdUGb6xrGXVF6ru9a58SvkdHO75N7nnId0dhuWxUTGVyjnl4Ei+9lClMwZK8O5LHYCWn5A==
X-Received: by 2002:aa7:da84:: with SMTP id q4mr24543653eds.371.1635149351644; 
 Mon, 25 Oct 2021 01:09:11 -0700 (PDT)
Received: from redhat.com ([2.55.151.113])
 by smtp.gmail.com with ESMTPSA id r26sm7152807ejd.85.2021.10.25.01.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Oct 2021 01:09:11 -0700 (PDT)
Date: Mon, 25 Oct 2021 04:09:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH linux-next v4 5/8] vdpa_sim_net: Enable user to set mac
 address and mtu
Message-ID: <20211025040853-mutt-send-email-mst@kernel.org>
References: <20211021163509.6978-1-parav@nvidia.com>
 <20211021163509.6978-6-parav@nvidia.com>
 <03d8d907-f54d-f9e2-a058-fd8d50ff927e@redhat.com>
 <PH0PR12MB54818C925D446110117F01DCDC839@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54818C925D446110117F01DCDC839@PH0PR12MB5481.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

T24gTW9uLCBPY3QgMjUsIDIwMjEgYXQgMDc6MTE6MjNBTSArMDAwMCwgUGFyYXYgUGFuZGl0IHdy
b3RlOgo+IAo+IAo+ID4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiA+
IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAyNSwgMjAyMSAxMjozMiBQTQo+ID4gCj4gPiAKPiA+IOWc
qCAyMDIxLzEwLzIyIOS4iuWNiDEyOjM1LCBQYXJhdiBQYW5kaXQg5YaZ6YGTOgo+ID4gPiBFbmFi
bGUgdXNlciB0byBzZXQgdGhlIG1hYyBhZGRyZXNzIGFuZCBtdHUgc28gdGhhdCBlYWNoIHZkcGEg
ZGV2aWNlCj4gPiA+IGNhbiBoYXZlIGl0cyBvd24gdXNlciBzcGVjaWZpZWQgbWFjIGFkZHJlc3Mg
YW5kIG10dS4KPiA+ID4gVGhpcyBpcyBkb25lIGJ5IGltcGxlbWVudGluZyB0aGUgbWFuYWdlbWVu
dCBkZXZpY2UncyBjb25maWd1cmF0aW9uCj4gPiA+IGxheW91dCBmaWVsZHMgc2V0dGluZyBjYWxs
YmFjayByb3V0aW5lLgo+ID4gPgo+ID4gPiBOb3cgdGhhdCB1c2VyIGlzIGVuYWJsZWQgdG8gc2V0
IHRoZSBtYWMgYWRkcmVzcywgcmVtb3ZlIHRoZSBtb2R1bGUKPiA+ID4gcGFyYW1ldGVyIGZvciBz
YW1lLgo+ID4gPgo+ID4gPiBBbmQgZXhhbXBsZSBvZiBzZXR0aW5nIG1hYyBhZGRyIGFuZCBtdHU6
Cj4gPiA+ICQgdmRwYSBtZ210ZGV2IHNob3cKPiA+ID4KPiA+ID4gJCB2ZHBhIGRldiBhZGQgbmFt
ZSBiYXIgbWdtdGRldiB2ZHBhc2ltX25ldCAkIHZkcGEgZGV2IGNvbmZpZyBzZXQgYmFyCj4gPiA+
IG1hYyAwMDoxMToyMjozMzo0NDo1NSBtdHUgOTAwMAo+ID4gCj4gPiAKPiA+IFRoZSBhdHRyaWJ1
dGVzIHdlcmUgc2V0IGR1cmluZyBkZXYgYWRkIGlmIEkgd2FzIG5vdCB3cm9uZy4KPiA+IAo+IFlv
dSBhcmUgcmlnaHQuIEkgbWlzc2VkIHRvIHVwZGF0ZSB0aGUgZXhhbXBsZSBoZXJlLiBDb2RlIGlz
IGp1c3QgZmluZS4KPiAKPiA+IFRoYW5rcwo+ID4gCgpXYW50IHRvIHNlbmQgYSBjb3JyZWN0ZWQg
Y29tbWl0IGxvZz8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
