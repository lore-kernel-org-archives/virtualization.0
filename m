Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC870C433EF
	for <virtualization@archiver.kernel.org>; Mon, 13 Dec 2021 10:43:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4AEE66E3BE;
	Mon, 13 Dec 2021 10:43:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ir3Eo8xhqnLd; Mon, 13 Dec 2021 10:43:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A39AD60E99;
	Mon, 13 Dec 2021 10:43:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8951DC001E;
	Mon, 13 Dec 2021 10:43:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E109C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 10:43:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5E6E785A84
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 10:43:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L_HwSVyI0NGg
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 10:43:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3E87B85A7F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 10:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639392184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PfuPpOABuCOUfJ766e10nvZWJe+DxQ1giE4QiO5fk8I=;
 b=BqAhgV05l9Ofnu44eWS7TZAn9hp5brKjHo2oqzifqWxfKK8GDmuz6nVAFB2tP0xYtgUNj+
 ABqQcUI+Uwr9q+x+kHvtaVQVb4HTyzpE56+d0UjAPO2U+VVz/Xn+Jn92sgrLkvWlVEgtBZ
 12wGdwnjKtvkkapajsddB9IIKqpl53A=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-333-hYKyqE57PUmogXTeF_YDmw-1; Mon, 13 Dec 2021 05:43:00 -0500
X-MC-Unique: hYKyqE57PUmogXTeF_YDmw-1
Received: by mail-ed1-f72.google.com with SMTP id
 m17-20020aa7d351000000b003e7c0bc8523so13560911edr.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 02:43:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=PfuPpOABuCOUfJ766e10nvZWJe+DxQ1giE4QiO5fk8I=;
 b=Riso/Cp/jyMrlDVuf1teC260I5YhBsXmBiw5XH837Irnli6CtE2iH6XyVg6qbtkKcr
 Eoc8JA5SofpzuP9qAHP1RdouJRNaOJi9kZRDFw6zgh1R6/iIHIx0XIHLetGo7LD0215H
 xDK2FmG13hrG3vPeBTgAhpIWKK/PrG1hZaLKoKnaOcvtp25OmJHrSNEZ+irQ7ada65VQ
 ir6OL8VvNIClM/8T5id8ZEluq1M2VkNGqo3tyHpCwCKM36y0lb/ntYxvTzjXZfeCEvuz
 s+zXSitDIzvvJzhfJl9PWex7BxTeuwavnIT+1mxmrPk+jaJa3fhI63a1pHTavdKSDjSY
 0DBg==
X-Gm-Message-State: AOAM530Y5RbKdFEykC5nB68r2xOXAfiyodqRwOppHtwJCe7f9VyJx43a
 hBWNsQvpMmesovUarpqOBCDViai9Vrf+G05/gEiHDvIwmQHX4/ZU9Souoh2Z0L6bGezvOjWSLuY
 rQRyqNLy+H4hLobin1/Lx8C2ccFwr05QTXohyUfROAA==
X-Received: by 2002:a50:bb2a:: with SMTP id y39mr61671552ede.348.1639392179578; 
 Mon, 13 Dec 2021 02:42:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJye188DD7VOBZu1z7K1fsIYJwVvhudMERb9VekFgUrFgqwmr0f6OoIDcHbVxO67vqs6b5qZUg==
X-Received: by 2002:a50:bb2a:: with SMTP id y39mr61671520ede.348.1639392179371; 
 Mon, 13 Dec 2021 02:42:59 -0800 (PST)
Received: from redhat.com ([2.55.148.125])
 by smtp.gmail.com with ESMTPSA id r11sm6278620edd.70.2021.12.13.02.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Dec 2021 02:42:58 -0800 (PST)
Date: Mon, 13 Dec 2021 05:42:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: vdpa legacy guest support (was Re: [PATCH] vdpa/mlx5:
 set_features should allow reset to zero)
Message-ID: <20211213053420-mutt-send-email-mst@kernel.org>
References: <52836a63-4e00-ff58-50fb-9f450ce968d7@oracle.com>
 <20210228163031-mutt-send-email-mst@kernel.org>
 <2cb51a6d-afa0-7cd1-d6f2-6b153186eaca@redhat.com>
 <20210302043419-mutt-send-email-mst@kernel.org>
 <178f8ea7-cebd-0e81-3dc7-10a058d22c07@redhat.com>
 <c9a0932f-a6d7-a9df-38ba-97e50f70c2b2@oracle.com>
 <20211212042311-mutt-send-email-mst@kernel.org>
 <CACGkMEtwWcBNj62Yn_ZSq33N42ZG5yhCcZf=eQZ_AdVgJhEjEA@mail.gmail.com>
 <20211213030535-mutt-send-email-mst@kernel.org>
 <CACGkMEtRfqRDPxXS2T-a0u4Aji3KtUq7-2iUD8Z-X1k84EgOZA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtRfqRDPxXS2T-a0u4Aji3KtUq7-2iUD8Z-X1k84EgOZA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, netdev <netdev@vger.kernel.org>,
 Eli Cohen <elic@nvidia.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

T24gTW9uLCBEZWMgMTMsIDIwMjEgYXQgMDQ6NTc6MzhQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBNb24sIERlYyAxMywgMjAyMSBhdCA0OjA3IFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8
bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIE1vbiwgRGVjIDEzLCAyMDIxIGF0IDEx
OjAyOjM5QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+IE9uIFN1biwgRGVjIDEyLCAy
MDIxIGF0IDU6MjYgUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6
Cj4gPiA+ID4KPiA+ID4gPiBPbiBGcmksIERlYyAxMCwgMjAyMSBhdCAwNTo0NDoxNVBNIC0wODAw
LCBTaS1XZWkgTGl1IHdyb3RlOgo+ID4gPiA+ID4gU29ycnkgZm9yIHJldml2aW5nIHRoaXMgYW5j
aWVudCB0aHJlYWQuIEkgd2FzIGtpbmRhIGxvc3QgZm9yIHRoZSBjb25jbHVzaW9uCj4gPiA+ID4g
PiBpdCBlbmRlZCB1cCB3aXRoLiBJIGhhdmUgdGhlIGZvbGxvd2luZyBxdWVzdGlvbnMsCj4gPiA+
ID4gPgo+ID4gPiA+ID4gMS4gbGVnYWN5IGd1ZXN0IHN1cHBvcnQ6IGZyb20gdGhlIHBhc3QgY29u
dmVyc2F0aW9ucyBpdCBkb2Vzbid0IHNlZW0gdGhlCj4gPiA+ID4gPiBzdXBwb3J0IHdpbGwgYmUg
Y29tcGxldGVseSBkcm9wcGVkIGZyb20gdGhlIHRhYmxlLCBpcyBteSB1bmRlcnN0YW5kaW5nCj4g
PiA+ID4gPiBjb3JyZWN0PyBBY3R1YWxseSB3ZSdyZSBpbnRlcmVzdGVkIGluIHN1cHBvcnRpbmcg
dmlydGlvIHYwLjk1IGd1ZXN0IGZvciB4ODYsCj4gPiA+ID4gPiB3aGljaCBpcyBiYWNrZWQgYnkg
dGhlIHNwZWMgYXQKPiA+ID4gPiA+IGh0dHBzOi8vb3psYWJzLm9yZy9+cnVzdHkvdmlydGlvLXNw
ZWMvdmlydGlvLTAuOS41LnBkZi4gVGhvdWdoIEknbSBub3Qgc3VyZQo+ID4gPiA+ID4gaWYgdGhl
cmUncyByZXF1ZXN0L25lZWQgdG8gc3VwcG9ydCB3aWxkZXIgbGVnYWN5IHZpcnRpbyB2ZXJzaW9u
cyBlYXJsaWVyCj4gPiA+ID4gPiBiZXlvbmQuCj4gPiA+ID4KPiA+ID4gPiBJIHBlcnNvbmFsbHkg
ZmVlbCBpdCdzIGxlc3Mgd29yayB0byBhZGQgaW4ga2VybmVsIHRoYW4gdHJ5IHRvCj4gPiA+ID4g
d29yayBhcm91bmQgaXQgaW4gdXNlcnNwYWNlLiBKYXNvbiBmZWVscyBkaWZmZXJlbnRseS4KPiA+
ID4gPiBNYXliZSBwb3N0IHRoZSBwYXRjaGVzIGFuZCB0aGlzIHdpbGwgcHJvdmUgdG8gSmFzb24g
aXQncyBub3QKPiA+ID4gPiB0b28gdGVycmlibGU/Cj4gPiA+Cj4gPiA+IFRoYXQncyBvbmUgd2F5
LCBvdGhlciB0aGFuIHRoZSBjb25maWcgYWNjZXNzIGJlZm9yZSBzZXR0aW5nIGZlYXR1cmVzLAo+
ID4gPiB3ZSBuZWVkIHRvIGRlYWwgd2l0aCBvdGhlciBzdHVmZnM6Cj4gPiA+Cj4gPiA+IDEpIFZJ
UlRJT19GX09SREVSX1BMQVRGT1JNCj4gPiA+IDIpIHRoZXJlIGNvdWxkIGJlIGEgcGFyZW50IGRl
dmljZSB0aGF0IG9ubHkgc3VwcG9ydCAxLjAgZGV2aWNlCj4gPiA+Cj4gPiA+IEFuZCBhIGxvdCBv
ZiBvdGhlciBzdHVmZiBzdW1tYXJpemVkIGluIHNwZWMgNy40IHdoaWNoIHNlZW1zIG5vdCBhbgo+
ID4gPiBlYXN5IHRhc2suIFZhcmlvdXMgdkRQQSBwYXJlbnQgZHJpdmVycyB3ZXJlIHdyaXR0ZW4g
dW5kZXIgdGhlCj4gPiA+IGFzc3VtcHRpb24gdGhhdCBvbmx5IG1vZGVybiBkZXZpY2VzIGFyZSBz
dXBwb3J0ZWQuCj4gPiA+Cj4gPiA+IFRoYW5rcwo+ID4KPiA+IExpbWl0aW5nIHRoaW5ncyB0byB4
ODYgd2lsbCBsaWtlbHkgYWRkcmVzcyBtb3N0IGlzc3VlcyB0aG91Z2gsIHdvbid0IGl0Pwo+IAo+
IEZvciB0aGUgb3JkZXJpbmcsIHllcy4gQnV0IGl0IG1lYW5zIHdlIG5lZWQgdG8gaW50cm9kdWNl
IGEgY29uZmlnCj4gb3B0aW9uIGZvciBsZWdhY3kgbG9naWM/Cj4gQW5kIHdlIG5lZWQgdG8gZGVh
bCB3aXRoLCBhcyB5b3Ugc2FpZCBpbiBhbm90aGVyIHRocmVhZCwga2ljayBiZWZvcmUgRFJJVkVS
X09LOgo+IAo+IEUuZyB3ZSBoYWQgdGhpbmcgbGlrZSB0aGlzOgo+IAo+ICAgICAgICAgaWYgKChz
dGF0dXMgJiBWSVJUSU9fQ09ORklHX1NfRFJJVkVSX09LKSAmJgo+ICAgICAgICAgICAgICEoc3Rh
dHVzX29sZCAmIFZJUlRJT19DT05GSUdfU19EUklWRVJfT0spKSB7Cj4gICAgICAgICAgICAgICAg
IHJldCA9IGlmY3ZmX3JlcXVlc3RfaXJxKGFkYXB0ZXIpOwo+ICAgICAgICAgICAgICAgICBpZiAo
cmV0KSB7Cj4gCj4gU2ltaWxhciBpc3N1ZXMgY291bGQgYmUgZm91bmQgaW4gb3RoZXIgcGFyZW50
cy4KClRoZSBkcml2ZXIgb2sgdGhpbmcgaXMgbW9zdGx5IGFuIGlzc3VlIGZvciBibG9jayB3aGVy
ZSBpdApleHBlY3RzIHRvIGFjY2VzcyB0aGUgZGlzayBkaXJlY3RseSBkdXJpbmcgcHJvYmUuCgo+
IFdlIGFsc28gbmVlZCB0byBjb25zaWRlciB3aGV0aGVyIHdlIHNob3VsZCBlbmNvdXJhZ2UgdGhl
IHZlbmRvciB0bwo+IGltcGxlbWVudCB0aGUgbG9naWMuCj4gCj4gSSB0aGluayB3ZSBjYW4gdHJ5
IGFuZCBzZWUgaG93IGhhcmQgaXQgaXMuCj4gCj4gVGhhbmtzCgpSaWdodC4gTXkgcG9pbnQgZXhh
Y3RseS4KCj4gPgo+ID4gPiA+Cj4gPiA+ID4gPiAyLiBzdXBwb3NlIHNvbWUgZm9ybSBvZiBsZWdh
Y3kgZ3Vlc3Qgc3VwcG9ydCBuZWVkcyB0byBiZSB0aGVyZSwgaG93IGRvIHdlCj4gPiA+ID4gPiBk
ZWFsIHdpdGggdGhlIGJvZ3VzIGFzc3VtcHRpb24gYmVsb3cgaW4gdmRwYV9nZXRfY29uZmlnKCkg
aW4gdGhlIHNob3J0IHRlcm0/Cj4gPiA+ID4gPiBJdCBsb29rcyBvbmUgb2YgdGhlIGludHVpdGl2
ZSBmaXggaXMgdG8gbW92ZSB0aGUgdmRwYV9zZXRfZmVhdHVyZXMgY2FsbCBvdXQKPiA+ID4gPiA+
IG9mIHZkcGFfZ2V0X2NvbmZpZygpIHRvIHZkcGFfc2V0X2NvbmZpZygpLgo+ID4gPiA+ID4KPiA+
ID4gPiA+ICAgICAgICAgLyoKPiA+ID4gPiA+ICAgICAgICAgICogQ29uZmlnIGFjY2Vzc2VzIGFy
ZW4ndCBzdXBwb3NlZCB0byB0cmlnZ2VyIGJlZm9yZSBmZWF0dXJlcyBhcmUKPiA+ID4gPiA+IHNl
dC4KPiA+ID4gPiA+ICAgICAgICAgICogSWYgaXQgZG9lcyBoYXBwZW4gd2UgYXNzdW1lIGEgbGVn
YWN5IGd1ZXN0Lgo+ID4gPiA+ID4gICAgICAgICAgKi8KPiA+ID4gPiA+ICAgICAgICAgaWYgKCF2
ZGV2LT5mZWF0dXJlc192YWxpZCkKPiA+ID4gPiA+ICAgICAgICAgICAgICAgICB2ZHBhX3NldF9m
ZWF0dXJlcyh2ZGV2LCAwKTsKPiA+ID4gPiA+ICAgICAgICAgb3BzLT5nZXRfY29uZmlnKHZkZXYs
IG9mZnNldCwgYnVmLCBsZW4pOwo+ID4gPiA+ID4KPiA+ID4gPiA+IEkgY2FuIHBvc3QgYSBwYXRj
aCB0byBmaXggMikgaWYgdGhlcmUncyBjb25zZW5zdXMgYWxyZWFkeSByZWFjaGVkLgo+ID4gPiA+
ID4KPiA+ID4gPiA+IFRoYW5rcywKPiA+ID4gPiA+IC1TaXdlaQo+ID4gPiA+Cj4gPiA+ID4gSSdt
IG5vdCBzdXJlIGhvdyBpbXBvcnRhbnQgaXQgaXMgdG8gY2hhbmdlIHRoYXQuCj4gPiA+ID4gSW4g
YW55IGNhc2UgaXQgb25seSBhZmZlY3RzIHRyYW5zaXRpb25hbCBkZXZpY2VzLCByaWdodD8KPiA+
ID4gPiBMZWdhY3kgb25seSBzaG91bGQgbm90IGNhcmUgLi4uCj4gPiA+ID4KPiA+ID4gPgo+ID4g
PiA+ID4gT24gMy8yLzIwMjEgMjo1MyBBTSwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gT24gMjAyMS8zLzIgNTo0NyDkuIvljYgsIE1pY2hhZWwgUy4gVHNpcmtpbiB3
cm90ZToKPiA+ID4gPiA+ID4gPiBPbiBNb24sIE1hciAwMSwgMjAyMSBhdCAxMTo1Njo1MEFNICsw
ODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gT24gMjAyMS8zLzEgNTozNCDk
uIrljYgsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gT24gV2Vk
LCBGZWIgMjQsIDIwMjEgYXQgMTA6MjQ6NDFBTSAtMDgwMCwgU2ktV2VpIExpdSB3cm90ZToKPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IERldGVjdGluZyBpdCBpc24ndCBlbm91Z2ggdGhvdWdoLCB3ZSB3
aWxsIG5lZWQgYSBuZXcgaW9jdGwgdG8gbm90aWZ5Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiB0aGUg
a2VybmVsIHRoYXQgaXQncyBhIGxlZ2FjeSBndWVzdC4gVWdoIDooCj4gPiA+ID4gPiA+ID4gPiA+
ID4gV2VsbCwgYWx0aG91Z2ggSSB0aGluayBhZGRpbmcgYW4gaW9jdGwgaXMgZG9hYmxlLCBtYXkg
SQo+ID4gPiA+ID4gPiA+ID4gPiA+IGtub3cgd2hhdCB0aGUgdXNlCj4gPiA+ID4gPiA+ID4gPiA+
ID4gY2FzZSB0aGVyZSB3aWxsIGJlIGZvciBrZXJuZWwgdG8gbGV2ZXJhZ2Ugc3VjaCBpbmZvCj4g
PiA+ID4gPiA+ID4gPiA+ID4gZGlyZWN0bHk/IElzIHRoZXJlIGEKPiA+ID4gPiA+ID4gPiA+ID4g
PiBjYXNlIFFFTVUgY2FuJ3QgZG8gd2l0aCBkZWRpY2F0ZSBpb2N0bHMgbGF0ZXIgaWYgdGhlcmUn
cyBpbmRlZWQKPiA+ID4gPiA+ID4gPiA+ID4gPiBkaWZmZXJlbnRpYXRpb24gKGxlZ2FjeSB2LnMu
IG1vZGVybikgbmVlZGVkPwo+ID4gPiA+ID4gPiA+ID4gPiBCVFcgYSBnb29kIEFQSSBjb3VsZCBi
ZQo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiAjZGVmaW5lIFZIT1NUX1NFVF9F
TkRJQU4gX0lPVyhWSE9TVF9WSVJUSU8sID8sIGludCkKPiA+ID4gPiA+ID4gPiA+ID4gI2RlZmlu
ZSBWSE9TVF9HRVRfRU5ESUFOIF9JT1coVkhPU1RfVklSVElPLCA/LCBpbnQpCj4gPiA+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IHdlIGRpZCBpdCBwZXIgdnJpbmcgYnV0IG1heWJlIHRo
YXQgd2FzIGEgbWlzdGFrZSAuLi4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBBY3R1
YWxseSwgSSB3b25kZXIgd2hldGhlciBpdCdzIGdvb2QgdGltZSB0byBqdXN0IG5vdCBzdXBwb3J0
Cj4gPiA+ID4gPiA+ID4gPiBsZWdhY3kgZHJpdmVyCj4gPiA+ID4gPiA+ID4gPiBmb3IgdkRQQS4g
Q29uc2lkZXI6Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gMSkgSXQncyBkZWZpbml0
aW9uIGlzIG5vLW5vcm1hdGl2ZQo+ID4gPiA+ID4gPiA+ID4gMikgQSBsb3Qgb2YgYnVkcmVuIG9m
IGNvZGVzCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gU28gcWVtdSBjYW4gc3RpbGwg
cHJlc2VudCB0aGUgbGVnYWN5IGRldmljZSBzaW5jZSB0aGUgY29uZmlnCj4gPiA+ID4gPiA+ID4g
PiBzcGFjZSBvciBvdGhlcgo+ID4gPiA+ID4gPiA+ID4gc3R1ZmZzIHRoYXQgaXMgcHJlc2VudGVk
IGJ5IHZob3N0LXZEUEEgaXMgbm90IGV4cGVjdGVkIHRvIGJlCj4gPiA+ID4gPiA+ID4gPiBhY2Nl
c3NlZCBieQo+ID4gPiA+ID4gPiA+ID4gZ3Vlc3QgZGlyZWN0bHkuIFFlbXUgY2FuIGRvIHRoZSBl
bmRpYW4gY29udmVyc2lvbiB3aGVuIG5lY2Vzc2FyeQo+ID4gPiA+ID4gPiA+ID4gaW4gdGhpcwo+
ID4gPiA+ID4gPiA+ID4gY2FzZT8KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBUaGFu
a3MKPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gT3ZlcmFsbCBJIHdvdWxkIGJlIGZpbmUg
d2l0aCB0aGlzIGFwcHJvYWNoIGJ1dCB3ZSBuZWVkIHRvIGF2b2lkIGJyZWFraW5nCj4gPiA+ID4g
PiA+ID4gd29ya2luZyB1c2Vyc3BhY2UsIHFlbXUgcmVsZWFzZXMgd2l0aCB2ZHBhIHN1cHBvcnQg
YXJlIG91dCB0aGVyZSBhbmQKPiA+ID4gPiA+ID4gPiBzZWVtIHRvIHdvcmsgZm9yIHBlb3BsZS4g
QW55IGNoYW5nZXMgbmVlZCB0byB0YWtlIHRoYXQgaW50byBhY2NvdW50Cj4gPiA+ID4gPiA+ID4g
YW5kIGRvY3VtZW50IGNvbXBhdGliaWxpdHkgY29uY2VybnMuCj4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+IEFncmVlLCBsZXQgbWUgY2hlY2suCj4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gICBJIG5vdGUgdGhhdCBhbnkgaGFyZHdhcmUKPiA+ID4gPiA+ID4g
PiBpbXBsZW1lbnRhdGlvbiBpcyBhbHJlYWR5IGJyb2tlbiBmb3IgbGVnYWN5IGV4Y2VwdCBvbiBw
bGF0Zm9ybXMgd2l0aAo+ID4gPiA+ID4gPiA+IHN0cm9uZyBvcmRlcmluZyB3aGljaCBtaWdodCBi
ZSBoZWxwZnVsIGluIHJlZHVjaW5nIHRoZSBzY29wZS4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gWWVzLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4g
PiA+ID4KPiA+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
