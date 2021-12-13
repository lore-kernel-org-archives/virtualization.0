Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77234C433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Dec 2021 08:58:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 15474403DD;
	Mon, 13 Dec 2021 08:58:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vYh9dhYkiw1d; Mon, 13 Dec 2021 08:58:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 64B53403CD;
	Mon, 13 Dec 2021 08:57:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A4EBC001E;
	Mon, 13 Dec 2021 08:57:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3863C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 08:57:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EE8B8409F4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 08:57:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WTlLeAZvDsbC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 08:57:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EF72B4011D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 08:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639385874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p9DVBPqK/d21aVsh+v6i0c9OVAXlQK07WZGATq/KnvE=;
 b=Uy/2QEiekuZZsyO/ICD4Sbw/vjqLtUBie59Qkse0v445p2qlsWgbOo+B/MtmqhlRu50QWh
 QCUzgyT1eB529KQ6GUTxW5KToxwZIZvO9TFYqAQDMXiajlWC2/ViGvzsQTqUkVs5LvHLol
 Qsi/gfEJLUwGmOcozZaz/l0VTog7W8Q=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-QHGbzI7IO7iFeDIE1_cKcQ-1; Mon, 13 Dec 2021 03:57:51 -0500
X-MC-Unique: QHGbzI7IO7iFeDIE1_cKcQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 b14-20020a05651c0b0e00b0021a1a39c481so4268213ljr.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 00:57:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=p9DVBPqK/d21aVsh+v6i0c9OVAXlQK07WZGATq/KnvE=;
 b=TVzgCvlGM7OuBOlm3V6Vqe0azLNtOGiuvAiGrXOB8KkvxE4bRb4di8P3qjb8A1t0ev
 HPhEq3bics39VypP1Tm7UF6rdMpPEUmKNAhb/wUrN23P/1XGYK0BKOz/DSZtcaUR30Fb
 A2KvaJoi5oPD7TRtPWT/M/hnWIDptotCuLbyMUImQpXnAvZNzaLhjdHUqliYn8XQh0gE
 qp6y5JFs+Acdm8KxvlzBLcWvZS9G554fwbW1L1uVuZEsHrxvZwcg3fovDQWBCuENz/aK
 KPVbopQlCD7CN/n3xUPJQ2UkJYIKCOeyspLbw0D1MpF5L+mJUwtchwO8gtqijF15sXMy
 xthg==
X-Gm-Message-State: AOAM533cFlpjLSeZaehInqu43/cW5nRV/OuBvwepoMJjfPK6zVUX1mi5
 brw/JiTRmjGjsZflJlow2zarUMc/ocHoWBU+Zc6pajykyK8r105PehfunduKmcJs2IWOm3dxN7W
 IJcDjblM8aN/HBwHx2LUmd8qCGjsw2cmwOKiCRLU0o36PFFwReb8FVRtThw==
X-Received: by 2002:a05:6512:3b2b:: with SMTP id
 f43mr28111797lfv.629.1639385869934; 
 Mon, 13 Dec 2021 00:57:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwKQv6cjOzLwU+SaW+IgVD/YNCHy3d5cQA+UHXctkBj0q7a1O8d5EuvuGrOXD0FCaxdFFZAe4G2ilJ7UjuF+y4=
X-Received: by 2002:a05:6512:3b2b:: with SMTP id
 f43mr28111776lfv.629.1639385869712; 
 Mon, 13 Dec 2021 00:57:49 -0800 (PST)
MIME-Version: 1.0
References: <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <20210224000057-mutt-send-email-mst@kernel.org>
 <52836a63-4e00-ff58-50fb-9f450ce968d7@oracle.com>
 <20210228163031-mutt-send-email-mst@kernel.org>
 <2cb51a6d-afa0-7cd1-d6f2-6b153186eaca@redhat.com>
 <20210302043419-mutt-send-email-mst@kernel.org>
 <178f8ea7-cebd-0e81-3dc7-10a058d22c07@redhat.com>
 <c9a0932f-a6d7-a9df-38ba-97e50f70c2b2@oracle.com>
 <20211212042311-mutt-send-email-mst@kernel.org>
 <CACGkMEtwWcBNj62Yn_ZSq33N42ZG5yhCcZf=eQZ_AdVgJhEjEA@mail.gmail.com>
 <20211213030535-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211213030535-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 13 Dec 2021 16:57:38 +0800
Message-ID: <CACGkMEtRfqRDPxXS2T-a0u4Aji3KtUq7-2iUD8Z-X1k84EgOZA@mail.gmail.com>
Subject: Re: vdpa legacy guest support (was Re: [PATCH] vdpa/mlx5:
 set_features should allow reset to zero)
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

T24gTW9uLCBEZWMgMTMsIDIwMjEgYXQgNDowNyBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIE1vbiwgRGVjIDEzLCAyMDIxIGF0IDExOjAyOjM5QU0g
KzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiBPbiBTdW4sIERlYyAxMiwgMjAyMSBhdCA1OjI2
IFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPgo+ID4g
PiBPbiBGcmksIERlYyAxMCwgMjAyMSBhdCAwNTo0NDoxNVBNIC0wODAwLCBTaS1XZWkgTGl1IHdy
b3RlOgo+ID4gPiA+IFNvcnJ5IGZvciByZXZpdmluZyB0aGlzIGFuY2llbnQgdGhyZWFkLiBJIHdh
cyBraW5kYSBsb3N0IGZvciB0aGUgY29uY2x1c2lvbgo+ID4gPiA+IGl0IGVuZGVkIHVwIHdpdGgu
IEkgaGF2ZSB0aGUgZm9sbG93aW5nIHF1ZXN0aW9ucywKPiA+ID4gPgo+ID4gPiA+IDEuIGxlZ2Fj
eSBndWVzdCBzdXBwb3J0OiBmcm9tIHRoZSBwYXN0IGNvbnZlcnNhdGlvbnMgaXQgZG9lc24ndCBz
ZWVtIHRoZQo+ID4gPiA+IHN1cHBvcnQgd2lsbCBiZSBjb21wbGV0ZWx5IGRyb3BwZWQgZnJvbSB0
aGUgdGFibGUsIGlzIG15IHVuZGVyc3RhbmRpbmcKPiA+ID4gPiBjb3JyZWN0PyBBY3R1YWxseSB3
ZSdyZSBpbnRlcmVzdGVkIGluIHN1cHBvcnRpbmcgdmlydGlvIHYwLjk1IGd1ZXN0IGZvciB4ODYs
Cj4gPiA+ID4gd2hpY2ggaXMgYmFja2VkIGJ5IHRoZSBzcGVjIGF0Cj4gPiA+ID4gaHR0cHM6Ly9v
emxhYnMub3JnL35ydXN0eS92aXJ0aW8tc3BlYy92aXJ0aW8tMC45LjUucGRmLiBUaG91Z2ggSSdt
IG5vdCBzdXJlCj4gPiA+ID4gaWYgdGhlcmUncyByZXF1ZXN0L25lZWQgdG8gc3VwcG9ydCB3aWxk
ZXIgbGVnYWN5IHZpcnRpbyB2ZXJzaW9ucyBlYXJsaWVyCj4gPiA+ID4gYmV5b25kLgo+ID4gPgo+
ID4gPiBJIHBlcnNvbmFsbHkgZmVlbCBpdCdzIGxlc3Mgd29yayB0byBhZGQgaW4ga2VybmVsIHRo
YW4gdHJ5IHRvCj4gPiA+IHdvcmsgYXJvdW5kIGl0IGluIHVzZXJzcGFjZS4gSmFzb24gZmVlbHMg
ZGlmZmVyZW50bHkuCj4gPiA+IE1heWJlIHBvc3QgdGhlIHBhdGNoZXMgYW5kIHRoaXMgd2lsbCBw
cm92ZSB0byBKYXNvbiBpdCdzIG5vdAo+ID4gPiB0b28gdGVycmlibGU/Cj4gPgo+ID4gVGhhdCdz
IG9uZSB3YXksIG90aGVyIHRoYW4gdGhlIGNvbmZpZyBhY2Nlc3MgYmVmb3JlIHNldHRpbmcgZmVh
dHVyZXMsCj4gPiB3ZSBuZWVkIHRvIGRlYWwgd2l0aCBvdGhlciBzdHVmZnM6Cj4gPgo+ID4gMSkg
VklSVElPX0ZfT1JERVJfUExBVEZPUk0KPiA+IDIpIHRoZXJlIGNvdWxkIGJlIGEgcGFyZW50IGRl
dmljZSB0aGF0IG9ubHkgc3VwcG9ydCAxLjAgZGV2aWNlCj4gPgo+ID4gQW5kIGEgbG90IG9mIG90
aGVyIHN0dWZmIHN1bW1hcml6ZWQgaW4gc3BlYyA3LjQgd2hpY2ggc2VlbXMgbm90IGFuCj4gPiBl
YXN5IHRhc2suIFZhcmlvdXMgdkRQQSBwYXJlbnQgZHJpdmVycyB3ZXJlIHdyaXR0ZW4gdW5kZXIg
dGhlCj4gPiBhc3N1bXB0aW9uIHRoYXQgb25seSBtb2Rlcm4gZGV2aWNlcyBhcmUgc3VwcG9ydGVk
Lgo+ID4KPiA+IFRoYW5rcwo+Cj4gTGltaXRpbmcgdGhpbmdzIHRvIHg4NiB3aWxsIGxpa2VseSBh
ZGRyZXNzIG1vc3QgaXNzdWVzIHRob3VnaCwgd29uJ3QgaXQ/CgpGb3IgdGhlIG9yZGVyaW5nLCB5
ZXMuIEJ1dCBpdCBtZWFucyB3ZSBuZWVkIHRvIGludHJvZHVjZSBhIGNvbmZpZwpvcHRpb24gZm9y
IGxlZ2FjeSBsb2dpYz8KCkFuZCB3ZSBuZWVkIHRvIGRlYWwgd2l0aCwgYXMgeW91IHNhaWQgaW4g
YW5vdGhlciB0aHJlYWQsIGtpY2sgYmVmb3JlIERSSVZFUl9PSzoKCkUuZyB3ZSBoYWQgdGhpbmcg
bGlrZSB0aGlzOgoKICAgICAgICBpZiAoKHN0YXR1cyAmIFZJUlRJT19DT05GSUdfU19EUklWRVJf
T0spICYmCiAgICAgICAgICAgICEoc3RhdHVzX29sZCAmIFZJUlRJT19DT05GSUdfU19EUklWRVJf
T0spKSB7CiAgICAgICAgICAgICAgICByZXQgPSBpZmN2Zl9yZXF1ZXN0X2lycShhZGFwdGVyKTsK
ICAgICAgICAgICAgICAgIGlmIChyZXQpIHsKClNpbWlsYXIgaXNzdWVzIGNvdWxkIGJlIGZvdW5k
IGluIG90aGVyIHBhcmVudHMuCgpXZSBhbHNvIG5lZWQgdG8gY29uc2lkZXIgd2hldGhlciB3ZSBz
aG91bGQgZW5jb3VyYWdlIHRoZSB2ZW5kb3IgdG8KaW1wbGVtZW50IHRoZSBsb2dpYy4KCkkgdGhp
bmsgd2UgY2FuIHRyeSBhbmQgc2VlIGhvdyBoYXJkIGl0IGlzLgoKVGhhbmtzCgo+Cj4gPiA+Cj4g
PiA+ID4gMi4gc3VwcG9zZSBzb21lIGZvcm0gb2YgbGVnYWN5IGd1ZXN0IHN1cHBvcnQgbmVlZHMg
dG8gYmUgdGhlcmUsIGhvdyBkbyB3ZQo+ID4gPiA+IGRlYWwgd2l0aCB0aGUgYm9ndXMgYXNzdW1w
dGlvbiBiZWxvdyBpbiB2ZHBhX2dldF9jb25maWcoKSBpbiB0aGUgc2hvcnQgdGVybT8KPiA+ID4g
PiBJdCBsb29rcyBvbmUgb2YgdGhlIGludHVpdGl2ZSBmaXggaXMgdG8gbW92ZSB0aGUgdmRwYV9z
ZXRfZmVhdHVyZXMgY2FsbCBvdXQKPiA+ID4gPiBvZiB2ZHBhX2dldF9jb25maWcoKSB0byB2ZHBh
X3NldF9jb25maWcoKS4KPiA+ID4gPgo+ID4gPiA+ICAgICAgICAgLyoKPiA+ID4gPiAgICAgICAg
ICAqIENvbmZpZyBhY2Nlc3NlcyBhcmVuJ3Qgc3VwcG9zZWQgdG8gdHJpZ2dlciBiZWZvcmUgZmVh
dHVyZXMgYXJlCj4gPiA+ID4gc2V0Lgo+ID4gPiA+ICAgICAgICAgICogSWYgaXQgZG9lcyBoYXBw
ZW4gd2UgYXNzdW1lIGEgbGVnYWN5IGd1ZXN0Lgo+ID4gPiA+ICAgICAgICAgICovCj4gPiA+ID4g
ICAgICAgICBpZiAoIXZkZXYtPmZlYXR1cmVzX3ZhbGlkKQo+ID4gPiA+ICAgICAgICAgICAgICAg
ICB2ZHBhX3NldF9mZWF0dXJlcyh2ZGV2LCAwKTsKPiA+ID4gPiAgICAgICAgIG9wcy0+Z2V0X2Nv
bmZpZyh2ZGV2LCBvZmZzZXQsIGJ1ZiwgbGVuKTsKPiA+ID4gPgo+ID4gPiA+IEkgY2FuIHBvc3Qg
YSBwYXRjaCB0byBmaXggMikgaWYgdGhlcmUncyBjb25zZW5zdXMgYWxyZWFkeSByZWFjaGVkLgo+
ID4gPiA+Cj4gPiA+ID4gVGhhbmtzLAo+ID4gPiA+IC1TaXdlaQo+ID4gPgo+ID4gPiBJJ20gbm90
IHN1cmUgaG93IGltcG9ydGFudCBpdCBpcyB0byBjaGFuZ2UgdGhhdC4KPiA+ID4gSW4gYW55IGNh
c2UgaXQgb25seSBhZmZlY3RzIHRyYW5zaXRpb25hbCBkZXZpY2VzLCByaWdodD8KPiA+ID4gTGVn
YWN5IG9ubHkgc2hvdWxkIG5vdCBjYXJlIC4uLgo+ID4gPgo+ID4gPgo+ID4gPiA+IE9uIDMvMi8y
MDIxIDI6NTMgQU0sIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4gT24gMjAy
MS8zLzIgNTo0NyDkuIvljYgsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gPiA+ID4g
T24gTW9uLCBNYXIgMDEsIDIwMjEgYXQgMTE6NTY6NTBBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiA+ID4gPiA+ID4gPiBPbiAyMDIxLzMvMSA1OjM0IOS4iuWNiCwgTWljaGFlbCBTLiBUc2ly
a2luIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gT24gV2VkLCBGZWIgMjQsIDIwMjEgYXQgMTA6MjQ6
NDFBTSAtMDgwMCwgU2ktV2VpIExpdSB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiBEZXRlY3Rp
bmcgaXQgaXNuJ3QgZW5vdWdoIHRob3VnaCwgd2Ugd2lsbCBuZWVkIGEgbmV3IGlvY3RsIHRvIG5v
dGlmeQo+ID4gPiA+ID4gPiA+ID4gPiA+IHRoZSBrZXJuZWwgdGhhdCBpdCdzIGEgbGVnYWN5IGd1
ZXN0LiBVZ2ggOigKPiA+ID4gPiA+ID4gPiA+ID4gV2VsbCwgYWx0aG91Z2ggSSB0aGluayBhZGRp
bmcgYW4gaW9jdGwgaXMgZG9hYmxlLCBtYXkgSQo+ID4gPiA+ID4gPiA+ID4gPiBrbm93IHdoYXQg
dGhlIHVzZQo+ID4gPiA+ID4gPiA+ID4gPiBjYXNlIHRoZXJlIHdpbGwgYmUgZm9yIGtlcm5lbCB0
byBsZXZlcmFnZSBzdWNoIGluZm8KPiA+ID4gPiA+ID4gPiA+ID4gZGlyZWN0bHk/IElzIHRoZXJl
IGEKPiA+ID4gPiA+ID4gPiA+ID4gY2FzZSBRRU1VIGNhbid0IGRvIHdpdGggZGVkaWNhdGUgaW9j
dGxzIGxhdGVyIGlmIHRoZXJlJ3MgaW5kZWVkCj4gPiA+ID4gPiA+ID4gPiA+IGRpZmZlcmVudGlh
dGlvbiAobGVnYWN5IHYucy4gbW9kZXJuKSBuZWVkZWQ/Cj4gPiA+ID4gPiA+ID4gPiBCVFcgYSBn
b29kIEFQSSBjb3VsZCBiZQo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ICNkZWZpbmUg
VkhPU1RfU0VUX0VORElBTiBfSU9XKFZIT1NUX1ZJUlRJTywgPywgaW50KQo+ID4gPiA+ID4gPiA+
ID4gI2RlZmluZSBWSE9TVF9HRVRfRU5ESUFOIF9JT1coVkhPU1RfVklSVElPLCA/LCBpbnQpCj4g
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gd2UgZGlkIGl0IHBlciB2cmluZyBidXQgbWF5
YmUgdGhhdCB3YXMgYSBtaXN0YWtlIC4uLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gQWN0
dWFsbHksIEkgd29uZGVyIHdoZXRoZXIgaXQncyBnb29kIHRpbWUgdG8ganVzdCBub3Qgc3VwcG9y
dAo+ID4gPiA+ID4gPiA+IGxlZ2FjeSBkcml2ZXIKPiA+ID4gPiA+ID4gPiBmb3IgdkRQQS4gQ29u
c2lkZXI6Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiAxKSBJdCdzIGRlZmluaXRpb24gaXMg
bm8tbm9ybWF0aXZlCj4gPiA+ID4gPiA+ID4gMikgQSBsb3Qgb2YgYnVkcmVuIG9mIGNvZGVzCj4g
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBTbyBxZW11IGNhbiBzdGlsbCBwcmVzZW50IHRoZSBs
ZWdhY3kgZGV2aWNlIHNpbmNlIHRoZSBjb25maWcKPiA+ID4gPiA+ID4gPiBzcGFjZSBvciBvdGhl
cgo+ID4gPiA+ID4gPiA+IHN0dWZmcyB0aGF0IGlzIHByZXNlbnRlZCBieSB2aG9zdC12RFBBIGlz
IG5vdCBleHBlY3RlZCB0byBiZQo+ID4gPiA+ID4gPiA+IGFjY2Vzc2VkIGJ5Cj4gPiA+ID4gPiA+
ID4gZ3Vlc3QgZGlyZWN0bHkuIFFlbXUgY2FuIGRvIHRoZSBlbmRpYW4gY29udmVyc2lvbiB3aGVu
IG5lY2Vzc2FyeQo+ID4gPiA+ID4gPiA+IGluIHRoaXMKPiA+ID4gPiA+ID4gPiBjYXNlPwo+ID4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
T3ZlcmFsbCBJIHdvdWxkIGJlIGZpbmUgd2l0aCB0aGlzIGFwcHJvYWNoIGJ1dCB3ZSBuZWVkIHRv
IGF2b2lkIGJyZWFraW5nCj4gPiA+ID4gPiA+IHdvcmtpbmcgdXNlcnNwYWNlLCBxZW11IHJlbGVh
c2VzIHdpdGggdmRwYSBzdXBwb3J0IGFyZSBvdXQgdGhlcmUgYW5kCj4gPiA+ID4gPiA+IHNlZW0g
dG8gd29yayBmb3IgcGVvcGxlLiBBbnkgY2hhbmdlcyBuZWVkIHRvIHRha2UgdGhhdCBpbnRvIGFj
Y291bnQKPiA+ID4gPiA+ID4gYW5kIGRvY3VtZW50IGNvbXBhdGliaWxpdHkgY29uY2VybnMuCj4g
PiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+IEFncmVlLCBsZXQgbWUgY2hlY2suCj4gPiA+ID4g
Pgo+ID4gPiA+ID4KPiA+ID4gPiA+ID4gICBJIG5vdGUgdGhhdCBhbnkgaGFyZHdhcmUKPiA+ID4g
PiA+ID4gaW1wbGVtZW50YXRpb24gaXMgYWxyZWFkeSBicm9rZW4gZm9yIGxlZ2FjeSBleGNlcHQg
b24gcGxhdGZvcm1zIHdpdGgKPiA+ID4gPiA+ID4gc3Ryb25nIG9yZGVyaW5nIHdoaWNoIG1pZ2h0
IGJlIGhlbHBmdWwgaW4gcmVkdWNpbmcgdGhlIHNjb3BlLgo+ID4gPiA+ID4KPiA+ID4gPiA+Cj4g
PiA+ID4gPiBZZXMuCj4gPiA+ID4gPgo+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPgo+ID4gPiA+
ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+Cj4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
