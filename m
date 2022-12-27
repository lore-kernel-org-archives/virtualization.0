Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B07C10F1B
	for <virtualization@archiver.kernel.org>; Tue, 27 Dec 2022 07:56:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1FD6B60BDD;
	Tue, 27 Dec 2022 07:56:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1FD6B60BDD
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U1h9lDH1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2QfVUU1x3k-7; Tue, 27 Dec 2022 07:56:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AF51260B9F;
	Tue, 27 Dec 2022 07:56:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AF51260B9F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92453C0035;
	Tue, 27 Dec 2022 07:56:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0FA2C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:56:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A8693403A7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:56:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A8693403A7
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=U1h9lDH1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VvHTQ2vN9_6q
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:56:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 03B5D40272
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 03B5D40272
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672127772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kXIiVrztZsdU7pju6USGfTMhcaQjY/sBo8HpMhE5ZAA=;
 b=U1h9lDH1lcwRpMvI6fRE0QOSO0LULj3MoGgC8hL2iEnXF66BX55KXkcYo2tQ9sHUo075BO
 kJ+mNxI8GeTt3lMhNxvjxlFecNjcLXHxKW3PijaTbLvn1gs9gR9a6jikYFs9z5SsoZqRMk
 btTD/OWjjcVO0qSLgOztx58Cx8Xrmao=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-471-e1AlC1y6OLO-vV4nAyEvbQ-1; Tue, 27 Dec 2022 02:56:08 -0500
X-MC-Unique: e1AlC1y6OLO-vV4nAyEvbQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 oz11-20020a1709077d8b00b007c0dd8018b6so8656278ejc.17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 23:56:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kXIiVrztZsdU7pju6USGfTMhcaQjY/sBo8HpMhE5ZAA=;
 b=VENH4M0cqWjbknjbZXB820yUERkpnMJKgNta72+w5g+a+XNKKzF82UmONSlSP60G1l
 Cro/tUsnNf9HM4dg1jeI3rpvIBNnixWkJNQrbQMCJQCfhcLpO0fYKeAo43cuIDUuhxcF
 55COnL30db+8WsQ1qzV5Mco5iOe+fRwm6r2MrK8wr+/Zc0XSkG88JauSZOxcjFyM4uGK
 1wgZyIoDnyk5ScvQeVhlyAA/+DT3dENhcpSczOxAnGWFaznneRZ16SLGAzvbR1bDCWuh
 5K1sG2y75Wsci6/tZDXTprdN+t8WY0m8OYYktNqiZq231JUqsypluprKCVNWGGGUJtFD
 8Q8g==
X-Gm-Message-State: AFqh2kolL8cdTZgYkgiFhhwCjAyjdPdDmqgdZcPt57ATplPhAKcRYfyd
 zLXHO8ua0yPybp02A13hDf7MsCdMEuQLdZjx/qy2CAqzuxdn4LYWKt7IedeW45LhjtyYEn5OVnr
 9oCet6oDPzOizUCTe6+tiAj+G29yofD08Wu4HWsTHMQ==
X-Received: by 2002:a17:906:abc6:b0:7ad:d835:e822 with SMTP id
 kq6-20020a170906abc600b007add835e822mr19018390ejb.42.1672127767729; 
 Mon, 26 Dec 2022 23:56:07 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuVNGbHfVGyJQhVKDfEoIS76PHdndlS5IKd1waWV9EOOy+ytuh7yvRbAC+e0kyXprTc9YN9KA==
X-Received: by 2002:a17:906:abc6:b0:7ad:d835:e822 with SMTP id
 kq6-20020a170906abc600b007add835e822mr19018382ejb.42.1672127767500; 
 Mon, 26 Dec 2022 23:56:07 -0800 (PST)
Received: from redhat.com ([2.52.151.85]) by smtp.gmail.com with ESMTPSA id
 a1-20020a170906684100b007c0f90a9cc5sm5716281ejs.105.2022.12.26.23.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Dec 2022 23:56:06 -0800 (PST)
Date: Tue, 27 Dec 2022 02:56:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shunsuke Mie <mie@igel.co.jp>
Subject: Re: [RFC PATCH 2/9] vringh: remove vringh_iov and unite to vringh_kiov
Message-ID: <20221227025534-mutt-send-email-mst@kernel.org>
References: <20221227022528.609839-1-mie@igel.co.jp>
 <20221227022528.609839-3-mie@igel.co.jp>
 <CACGkMEtAaYpuZtS0gx_m931nFzcvqSNK9BhvUZH_tZXTzjgQCg@mail.gmail.com>
 <20221227020425-mutt-send-email-mst@kernel.org>
 <CANXvt5pXkS=TTOU0+Lkx6CjcV7xvDHRS6FbFikJ4Ww8832sg8g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CANXvt5pXkS=TTOU0+Lkx6CjcV7xvDHRS6FbFikJ4Ww8832sg8g@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

T24gVHVlLCBEZWMgMjcsIDIwMjIgYXQgMDQ6MTM6NDlQTSArMDkwMCwgU2h1bnN1a2UgTWllIHdy
b3RlOgo+IDIwMjLlubQxMuaciDI35pelKOeBqykgMTY6MDUgTWljaGFlbCBTLiBUc2lya2luIDxt
c3RAcmVkaGF0LmNvbT46Cj4gPgo+ID4gT24gVHVlLCBEZWMgMjcsIDIwMjIgYXQgMDI6MDQ6MDNQ
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gT24gVHVlLCBEZWMgMjcsIDIwMjIgYXQg
MTA6MjUgQU0gU2h1bnN1a2UgTWllIDxtaWVAaWdlbC5jby5qcD4gd3JvdGU6Cj4gPiA+ID4KPiA+
ID4gPiBzdHJ1Y3QgdnJpbmdoX2lvdiBpcyBkZWZpbmVkIHRvIGhvbGQgdXNlcmxhbmQgYWRkcmVz
c2VzLiBIb3dldmVyLCB0byB1c2UKPiA+ID4gPiBjb21tb24gZnVuY3Rpb24sIF9fdnJpbmdfaW92
LCBmaW5hbGx5IHRoZSB2cmluZ2hfaW92IGNvbnZlcnRzIHRvIHRoZQo+ID4gPiA+IHZyaW5naF9r
aW92IHdpdGggc2ltcGxlIGNhc3QuIEl0IGluY2x1ZGVzIGNvbXBpbGUgdGltZSBjaGVjayBjb2Rl
IHRvIG1ha2UKPiA+ID4gPiBzdXJlIGl0IGNhbiBiZSBjYXN0IGNvcnJlY3RseS4KPiA+ID4gPgo+
ID4gPiA+IFRvIHNpbXBsaWZ5IHRoZSBjb2RlLCB0aGlzIHBhdGNoIHJlbW92ZXMgdGhlIHN0cnVj
dCB2cmluZ2hfaW92IGFuZCB1bmlmaWVzCj4gPiA+ID4gQVBJcyB0byBzdHJ1Y3QgdnJpbmdoX2tp
b3YuCj4gPiA+ID4KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTaHVuc3VrZSBNaWUgPG1pZUBpZ2Vs
LmNvLmpwPgo+ID4gPgo+ID4gPiBXaGlsZSBhdCB0aGlzLCBJIHdvbmRlciBpZiB3ZSBuZWVkIHRv
IGdvIGZ1cnRoZXIsIHRoYXQgaXMsIHN3aXRjaCB0bwo+ID4gPiB1c2luZyBhbiBpb3YgaXRlcmF0
b3IgaW5zdGVhZCBvZiBhIHZyaW5naCBjdXN0b21pemVkIG9uZS4KPiA+ID4KPiA+ID4gVGhhbmtz
Cj4gPgo+ID4gUG9zc2libHksIGJ1dCB3aGVuIGRvaW5nIGNoYW5nZXMgbGlrZSB0aGlzIG9uZSBu
ZWVkcyB0byBiZSBjYXJlZnVsCj4gPiB0byBhdm9pZCBicmVha2luZyBhbGwgdGhlIGlubGluaW5n
IHRyaWNrcyB2cmluZ2ggcmVsaWVzIG9uIGZvcgo+ID4gcGVyZm9ybWFuY2UuCj4gRGVmaW5pdGVs
eSwgSSdtIGV2YWx1YXRpbmcgdGhlIHBlcmZvcm1hbmNlIHVzaW5nIHZyaW5naF90ZXN0LiBJJ2xs
IGFkZCBhCj4gcmVzdWx0IG9mIHRoZSBldmFsdWF0aW9uLiBCdXQsIElmIHRoZXJlIGFyZSBvdGhl
ciBldmFsdWF0aW9uIG1ldGhvZHMsIGNvdWxkIHlvdQo+IHBsZWFzZSB0ZWxsIG1lPwoKaGlnaCBs
ZXZlbCB0ZXN0cyBvdmVyIHZpcnRpbyBibGsgYW5kIG5ldCBhcmUgcG9zc2libGUsIGJ1dCBsZXQn
cwpzdGFydCB3aXRoIHZyaW5naF90ZXN0LgoKPiA+IC0tCj4gPiBNU1QKPiA+Cj4gCj4gQmVzdCwK
PiBTaHVuc3VrZQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
