Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3C7EB64D9
	for <virtualization@archiver.kernel.org>; Thu,  6 Jul 2023 08:03:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E148408C2;
	Thu,  6 Jul 2023 08:03:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9E148408C2
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=US4pwvKy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rxh5_XnCW8gO; Thu,  6 Jul 2023 08:03:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5CA30408B4;
	Thu,  6 Jul 2023 08:03:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5CA30408B4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D1A8C0072;
	Thu,  6 Jul 2023 08:03:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28C8CC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 08:03:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EEBA861088
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 08:03:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EEBA861088
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=US4pwvKy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rael8J5ynEB1
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 08:03:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 984C46104D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 984C46104D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 08:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688630632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uR4y3omuMdeq94aQV10LDw49xhVeOOuaecbCLxNYkRA=;
 b=US4pwvKy6x9Q8zLbDRv1Op2x1P7ADI4jNJXRPu5pvDHoYFUdyMji6tfzw1GsH32byPSCIy
 3Qe1H8u43Na3yLhZLPedzi6RNsqzX/vWdRTCq/LyqxOIeVouokyhcNdjW93FevTfEQsV0/
 IQPk2LBf34o8qTilMJWvLTP/ksNFafw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-43jIuU8NNi-ACmHm0t8DCw-1; Thu, 06 Jul 2023 04:03:51 -0400
X-MC-Unique: 43jIuU8NNi-ACmHm0t8DCw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b6f51c5cb3so3950361fa.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jul 2023 01:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688630630; x=1691222630;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uR4y3omuMdeq94aQV10LDw49xhVeOOuaecbCLxNYkRA=;
 b=kvBA9dufCFf2prgQWpggO5afakk4VzwHBSg8+r4mkrElB/+OQwaznUSFMX6tDJ0+i7
 T3pvkcAhteTe/A9TwNmZkh6uQZMQt66WdngqxYHyr4BmfF7Qd2ypgvCb12jqftQgLaFj
 rcyiGY5PVaAuS5vX5C3HeKWOofE0iwZQ0KZYe1ECYAH4zQjnuJOo132VsFadKiBWN8Yd
 dJjQXlYFUO1GdMxib0r86h5aAi+tDG3NSUKwbgTUJCPP2xZwbo5xMQEQ29LJ3NDfkjeI
 i4UUjn0CMzaGCideXvH+gSdbbGSgU0MtRHX+urV+ACY+QFyC5shavL26J0At7qumwcfM
 dsNA==
X-Gm-Message-State: ABy/qLZ1aIWXdMCBAJSPJELDDDOMitL8V/61VXFt4vaXUUkx1jwpPZVm
 ZfvGiY5R2xSbeY7Pnp0RoiVM7keJaJXRRMX1i8Zerw6jVwDaRyOFKuIXi5RUZl7j5hwfp78mRX4
 nYzLh4RN6FPw6SgqEc915P7jeJLxGJjR69AfNFsUCYcMMYrzZPRw4QATfuw==
X-Received: by 2002:a2e:9591:0:b0:2b4:7380:230 with SMTP id
 w17-20020a2e9591000000b002b473800230mr759828ljh.13.1688630629803; 
 Thu, 06 Jul 2023 01:03:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEs2XjxNnDYt9bsvlBMjZE3fW9f7FULLsL3dT+t9oA/+1JgOYl/i6fgqjaisfA5D3k6EKTaqLBpqg1n2mFUQ/k=
X-Received: by 2002:a2e:9591:0:b0:2b4:7380:230 with SMTP id
 w17-20020a2e9591000000b002b473800230mr759810ljh.13.1688630629454; Thu, 06 Jul
 2023 01:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230703142218.362549-1-eperezma@redhat.com>
 <20230703105022-mutt-send-email-mst@kernel.org>
 <CAJaqyWf2F_yBLBjj1RiPeJ92_zfq8BSMz8Pak2Vg6QinN8jS1Q@mail.gmail.com>
 <20230704063646-mutt-send-email-mst@kernel.org>
 <CAJaqyWfdPpkD5pY4tfzQdOscLBcrDBhBqzWjMbY_ZKsoyiqGdA@mail.gmail.com>
 <20230704114159-mutt-send-email-mst@kernel.org>
 <CACGkMEtWjOMtsbgQ2sx=e1BkuRSyDmVfXDccCm-QSiSbacQyCA@mail.gmail.com>
 <20230705043940-mutt-send-email-mst@kernel.org>
 <CACGkMEufNZGvWMN9Shh6NPOZOe-vf0RomfS1DX6DtxJjvO7fNA@mail.gmail.com>
 <CAJaqyWcqNkzJXxsoz_Lk_X0CvNW24Ay2Ki6q02EB8iR=qpwsfg@mail.gmail.com>
 <CACGkMEvDsZcyTDBhS8ekXHyv-kiipyHizewpM2+=0XgSYMsmbw@mail.gmail.com>
In-Reply-To: <CACGkMEvDsZcyTDBhS8ekXHyv-kiipyHizewpM2+=0XgSYMsmbw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 6 Jul 2023 16:03:37 +0800
Message-ID: <CACGkMEuKNXCSWWqDTZQpogHqT1K=rsQMFAYxL6OC8OL=XeU3-g@mail.gmail.com>
Subject: Re: [PATCH] vdpa: reject F_ENABLE_AFTER_DRIVER_OK if backend does not
 support it
To: Eugenio Perez Martin <eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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

T24gVGh1LCBKdWwgNiwgMjAyMyBhdCAzOjU14oCvUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBUaHUsIEp1bCA2LCAyMDIzIGF0IDM6MDbigK9QTSBFdWdl
bmlvIFBlcmV6IE1hcnRpbiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24g
VGh1LCBKdWwgNiwgMjAyMyBhdCAzOjU14oCvQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4gPiA+Cj4gPiA+IE9uIFdlZCwgSnVsIDUsIDIwMjMgYXQgNDo0MeKAr1BN
IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+Cj4gPiA+
ID4gT24gV2VkLCBKdWwgMDUsIDIwMjMgYXQgMDM6NDk6NThQTSArMDgwMCwgSmFzb24gV2FuZyB3
cm90ZToKPiA+ID4gPiA+IE9uIFR1ZSwgSnVsIDQsIDIwMjMgYXQgMTE6NDXigK9QTSBNaWNoYWVs
IFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gT24gVHVlLCBKdWwgMDQsIDIwMjMgYXQgMDE6MzY6MTFQTSArMDIwMCwgRXVnZW5pbyBQZXJl
eiBNYXJ0aW4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gT24gVHVlLCBKdWwgNCwgMjAyMyBhdCAxMjoz
OOKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IE9uIFR1ZSwgSnVsIDA0LCAyMDIzIGF0IDEyOjI1OjMy
UE0gKzAyMDAsIEV1Z2VuaW8gUGVyZXogTWFydGluIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiBP
biBNb24sIEp1bCAzLCAyMDIzIGF0IDQ6NTLigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+
IE9uIE1vbiwgSnVsIDAzLCAyMDIzIGF0IDA0OjIyOjE4UE0gKzAyMDAsIEV1Z2VuaW8gUMOpcmV6
IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gV2l0aCB0aGUgY3VycmVudCBjb2RlIGl0IGlz
IGFjY2VwdGVkIGFzIGxvbmcgYXMgdXNlcmxhbmQgc2VuZCBpdC4KPiA+ID4gPiA+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBBbHRob3VnaCB1c2VybGFuZCBzaG91bGQgbm90IHNl
dCBhIGZlYXR1cmUgZmxhZyB0aGF0IGhhcyBub3QgYmVlbgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
b2ZmZXJlZCB0byBpdCB3aXRoIFZIT1NUX0dFVF9CQUNLRU5EX0ZFQVRVUkVTLCB0aGUgY3VycmVu
dCBjb2RlIHdpbGwgbm90Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBjb21wbGFpbiBmb3IgaXQuCj4g
PiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gU2luY2UgdGhlcmUgaXMg
bm8gc3BlY2lmaWMgcmVhc29uIGZvciBhbnkgcGFyZW50IHRvIHJlamVjdCB0aGF0IGJhY2tlbmQK
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IGZlYXR1cmUgYml0IHdoZW4gaXQgaGFzIGJlZW4gcHJvcG9z
ZWQsIGxldCdzIGNvbnRyb2wgaXQgYXQgdmRwYSBmcm9udGVuZAo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gbGV2ZWwuIEZ1dHVyZSBwYXRjaGVzIG1heSBtb3ZlIHRoaXMgY29udHJvbCB0byB0aGUgcGFy
ZW50IGRyaXZlci4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBG
aXhlczogOTY3ODAwZDJkNTJlICgidmRwYTogYWNjZXB0IFZIT1NUX0JBQ0tFTkRfRl9FTkFCTEVf
QUZURVJfRFJJVkVSX09LIGJhY2tlbmQgZmVhdHVyZSIpCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiA+ID4g
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+IFBsZWFzZSBkbyBzZW5kIHYzLiBBbmQg
YWdhaW4sIEkgZG9uJ3Qgd2FudCB0byBzZW5kICJhZnRlciBkcml2ZXIgb2siIGhhY2sKPiA+ID4g
PiA+ID4gPiA+ID4gPiB1cHN0cmVhbSBhdCBhbGwsIEkgbWVyZ2VkIGl0IGluIG5leHQganVzdCB0
byBnaXZlIGl0IHNvbWUgdGVzdGluZy4KPiA+ID4gPiA+ID4gPiA+ID4gPiBXZSB3YW50IFJJTkdf
QUNDRVNTX0FGVEVSX0tJQ0sgb3Igc29tZSBzdWNoLgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IEN1cnJlbnQgZGV2aWNlcyBkbyBub3Qgc3Vw
cG9ydCB0aGF0IHNlbWFudGljLgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IFdoaWNo
IGRldmljZXMgc3BlY2lmaWNhbGx5IGFjY2VzcyB0aGUgcmluZyBhZnRlciBEUklWRVJfT0sgYnV0
IGJlZm9yZQo+ID4gPiA+ID4gPiA+ID4gYSBraWNrPwo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+IFByZXZpb3VzIHZlcnNpb25zIG9mIHRoZSBRRU1VIExNIHNlcmll
cyBkaWQgYSBzcHVyaW91cyBraWNrIHRvIHN0YXJ0Cj4gPiA+ID4gPiA+ID4gdHJhZmZpYyBhdCB0
aGUgTE0gZGVzdGluYXRpb24gWzFdLiBXaGVuIGl0IHdhcyBwcm9wb3NlZCwgdGhhdCBzcHVyaW91
cwo+ID4gPiA+ID4gPiA+IGtpY2sgd2FzIHJlbW92ZWQgZnJvbSB0aGUgc2VyaWVzIGJlY2F1c2Ug
dG8gY2hlY2sgZm9yIGRlc2NyaXB0b3JzCj4gPiA+ID4gPiA+ID4gYWZ0ZXIgZHJpdmVyX29rLCBl
dmVuIHdpdGhvdXQgYSBraWNrLCB3YXMgY29uc2lkZXJlZCB3b3JrIG9mIHRoZQo+ID4gPiA+ID4g
PiA+IHBhcmVudCBkcml2ZXIuCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBJJ20gb2sgdG8g
Z28gYmFjayB0byB0aGlzIHNwdXJpb3VzIGtpY2ssIGJ1dCBJJ20gbm90IHN1cmUgaWYgdGhlIGh3
Cj4gPiA+ID4gPiA+ID4gd2lsbCByZWFkIHRoZSByaW5nIGJlZm9yZSB0aGUga2ljayBhY3R1YWxs
eS4gSSBjYW4gYXNrLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gVGhhbmtzIQo+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gWzFdIGh0dHBzOi8vbGlzdHMubm9uZ251Lm9yZy9hcmNoaXZl
L2h0bWwvcWVtdS1kZXZlbC8yMDIzLTAxL21zZzAyNzc1Lmh0bWwKPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gTGV0J3MgZmluZCBvdXQuIFdlIG5lZWQgdG8gY2hlY2sgZm9yIEVOQUJMRV9BRlRFUl9E
UklWRVJfT0sgdG9vLCBubz8KPiA+ID4gPiA+Cj4gPiA+ID4gPiBNeSB1bmRlcnN0YW5kaW5nIGlz
IFsxXSBhc3N1bWluZyBBQ0NFU1NfQUZURVJfS0lDSy4gVGhpcyBzZWVtcwo+ID4gPiA+ID4gc3Vi
LW9wdGltYWwgdGhhbiBhc3N1bWluZyBFTkFCTEVfQUZURVJfRFJJVkVSX09LLgo+ID4gPiA+ID4K
PiA+ID4gPiA+IEJ1dCB0aGlzIHJlbWluZHMgbWUgb25lIHRoaW5nLCBhcyB0aGUgdGhyZWFkIGlz
IGdvaW5nIHRvbyBsb25nLCBJCj4gPiA+ID4gPiB3b25kZXIgaWYgd2Ugc2ltcGx5IGFzc3VtZSBF
TkFCTEVfQUZURVJfRFJJVkVSX09LIGlmIFJJTkdfUkVTRVQgaXMKPiA+ID4gPiA+IHN1cHBvcnRl
ZD8KPiA+ID4gPiA+Cj4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPgo+ID4gPiA+IEkgZG9uJ3Qgc2Vl
IHdoYXQgZG9lcyBvbmUgaGF2ZSB0byBkbyB3aXRoIGFub3RoZXIgLi4uCj4gPiA+ID4KPiA+ID4g
PiBJIHRoaW5rIHdpdGggUklOR19SRVNFVCB3ZSBoYWQgYW5vdGhlciBzb2x1dGlvbiwgZW5hYmxl
IHJpbmdzCj4gPiA+ID4gbWFwcGluZyB0aGVtIHRvIGEgemVybyBwYWdlLCB0aGVuIHJlc2V0IGFu
ZCByZS1lbmFibGUgbGF0ZXIuCj4gPiA+Cj4gPiA+IEFzIGRpc2N1c3NlZCBiZWZvcmUsIHRoaXMg
c2VlbXMgdG8gaGF2ZSBzb21lIHByb2JsZW1zOgo+ID4gPgo+ID4gPiAxKSBUaGUgYmVoYXZpb3Vy
IGlzIG5vdCBjbGFyaWZpZWQgaW4gdGhlIGRvY3VtZW50Cj4gPiA+IDIpIHplcm8gaXMgYSB2YWxp
ZCBJT1ZBCj4gPiA+Cj4gPgo+ID4gSSB0aGluayB3ZSdyZSBub3Qgb24gdGhlIHNhbWUgcGFnZSBo
ZXJlLgo+ID4KPiA+IEFzIEkgdW5kZXJzdG9vZCwgcmluZ3MgbWFwcGVkIHRvIGEgemVybyBwYWdl
IG1lYW5zIGVzc2VudGlhbGx5IGFuCj4gPiBhdmFpbCByaW5nIHdob3NlIGF2YWlsX2lkeCBpcyBh
bHdheXMgMCwgb2ZmZXJlZCB0byB0aGUgZGV2aWNlIGluc3RlYWQKPiA+IG9mIHRoZSBndWVzdCdz
IHJpbmcuIE9uY2UgYWxsIENWUSBjb21tYW5kcyBhcmUgcHJvY2Vzc2VkLCB3ZSB1c2UKPiA+IFJJ
TkdfUkVTRVQgdG8gc3dpdGNoIHRvIHRoZSByaWdodCByaW5nLCBiZWluZyBndWVzdCdzIG9yIFNW
USB2cmluZy4KPgo+IEkgZ2V0IHRoaXMuIFRoaXMgc2VlbXMgbW9yZSBjb21wbGljYXRlZCBpbiB0
aGUgZGVzdGluYXRpb246IHNoYWRvdyB2cSArIEFTSUQ/CgpTbyBpdCdzIHNvbWV0aGluZyBsaWtl
OgoKMSkgc2V0IGFsbCB2cSBBU0lEIHRvIHNoYWRvdyB2aXJ0cXVldWUKMikgZG8gbm90IGFkZCBh
bnkgYnVmcyB0byBkYXRhIHFwIChzdGljayAwIGFzIGF2YWlsIGluZGV4KQozKSBzdGFydCB0byBy
ZXN0b3JlIHN0YXRlcyB2aWEgY3ZxCjQpIHJpbmdfcmVzdCBmb3IgZGF0YXFwCjUpIHNldF92cV9z
dGF0ZSBmb3IgZGF0YXFwCjYpIHJlLWluaXRpYWxpemUgZGF0YXFwIGFkZHJlc3MgZXRjCjcpIHNl
dCBkYXRhIFFQIEFTSUQgdG8gZ3Vlc3QKOCkgc2V0IHF1ZXVlX2VuYWJsZQoKPwoKVGhhbmtzCgo+
Cj4gVGhhbmtzCj4KPiA+Cj4gPgo+ID4KPiA+ID4gVGhhbmtzCj4gPiA+Cj4gPiA+ID4KPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gTXkgcGxhbiB3
YXMgdG8gY29udmVydAo+ID4gPiA+ID4gPiA+ID4gPiBpdCBpbiB2cF92ZHBhIGlmIG5lZWRlZCwg
YW5kIHJldXNlIHRoZSBjdXJyZW50IHZkcGEgb3BzLiBTb3JyeSBpZiBJCj4gPiA+ID4gPiA+ID4g
PiA+IHdhcyBub3QgZXhwbGljaXQgZW5vdWdoLgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+ID4gPiBUaGUgb25seSBzb2x1dGlvbiBJIGNhbiBzZWUgdG8gdGhhdCBpcyB0byB0cmFwICYg
ZW11bGF0ZSBpbiB0aGUgdmRwYQo+ID4gPiA+ID4gPiA+ID4gPiAocGFyZW50PykgZHJpdmVyLCBh
cyB0YWxrZWQgaW4gdmlydGlvLWNvbW1lbnQuIEJ1dCB0aGF0IGNvbXBsaWNhdGVzCj4gPiA+ID4g
PiA+ID4gPiA+IHRoZSBhcmNoaXRlY3R1cmU6Cj4gPiA+ID4gPiA+ID4gPiA+ICogT2ZmZXIgVkhP
U1RfQkFDS0VORF9GX1JJTkdfQUNDRVNTX0FGVEVSX0tJQ0sKPiA+ID4gPiA+ID4gPiA+ID4gKiBT
dG9yZSB2cSBlbmFibGUgc3RhdGUgc2VwYXJhdGVseSwgYXQKPiA+ID4gPiA+ID4gPiA+ID4gdmRw
YS0+Y29uZmlnLT5zZXRfdnFfcmVhZHkodHJ1ZSksIGJ1dCBub3QgdHJhbnNtaXQgdGhhdCBlbmFi
bGUgdG8gaHcKPiA+ID4gPiA+ID4gPiA+ID4gKiBTdG9yZSB0aGUgZG9vcmJlbGwgc3RhdGUgc2Vw
YXJhdGVseSwgYnV0IGRvIG5vdCBjb25maWd1cmUgaXQgdG8gdGhlCj4gPiA+ID4gPiA+ID4gPiA+
IGRldmljZSBkaXJlY3RseS4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gQnV0
IGhvdyB0byByZWNvdmVyIGlmIHRoZSBkZXZpY2UgY2Fubm90IGNvbmZpZ3VyZSB0aGVtIGF0IGtp
Y2sgdGltZSwKPiA+ID4gPiA+ID4gPiA+ID4gZm9yIGV4YW1wbGU/Cj4gPiA+ID4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+ID4gPiA+IE1heWJlIHdlIGNhbiBqdXN0IGZhaWwgaWYgdGhlIHBhcmVudCBk
cml2ZXIgZG9lcyBub3Qgc3VwcG9ydCBlbmFibGluZwo+ID4gPiA+ID4gPiA+ID4gPiB0aGUgdnEg
YWZ0ZXIgRFJJVkVSX09LPyBUaGF0IHdheSBubyBuZXcgZmVhdHVyZSBmbGFnIGlzIG5lZWRlZC4K
PiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gVGhhbmtzIQo+ID4gPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAtLS0KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IFNlbnQgd2l0aCBGaXhlczogdGFnIHBvaW50aW5nIHRvIGdpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9tc3QKPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IGNvbW1pdC4gUGxlYXNlIGxldCBtZSBrbm93IGlmIEkgc2hvdWxkIHNlbmQgYSB2MyBvZiBbMV0g
aW5zdGVhZC4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBbMV0g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMDYwOTEyMTI0NC1tdXR0LXNlbmQtZW1h
aWwtbXN0QGtlcm5lbC5vcmcvVC8KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gIGRyaXZlcnMvdmhvc3QvdmRwYS5jIHwgNyArKysrKy0tCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkKPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gaW5kZXggZTFhYmYyOWZlZDViLi5hN2U1NTQzNTIzNTEgMTAwNjQ0Cj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IEBAIC02ODEsMTggKzY4MSwyMSBAQCBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3VubG9ja2VkX2lv
Y3RsKHN0cnVjdCBmaWxlICpmaWxlcCwKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICB7Cj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiAgICAgICBzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiA9IGZpbGVwLT5wcml2YXRl
X2RhdGE7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAgICBzdHJ1Y3Qgdmhvc3RfZGV2ICpkID0g
JnYtPnZkZXY7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiArICAgICBjb25zdCBzdHJ1Y3QgdmRwYV9j
b25maWdfb3BzICpvcHMgPSB2LT52ZHBhLT5jb25maWc7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAg
ICAgICB2b2lkIF9fdXNlciAqYXJncCA9ICh2b2lkIF9fdXNlciAqKWFyZzsKPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ICAgICAgIHU2NCBfX3VzZXIgKmZlYXR1cmVwID0gYXJncDsKPiA+ID4gPiA+ID4g
PiA+ID4gPiA+IC0gICAgIHU2NCBmZWF0dXJlczsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICsgICAg
IHU2NCBmZWF0dXJlcywgcGFyZW50X2ZlYXR1cmVzID0gMDsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ICAgICAgIGxvbmcgciA9IDA7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gICAgICAgaWYgKGNtZCA9PSBWSE9TVF9TRVRfQkFDS0VORF9GRUFUVVJFUykgewo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICBpZiAoY29weV9mcm9tX3VzZXIoJmZlYXR1
cmVzLCBmZWF0dXJlcCwgc2l6ZW9mKGZlYXR1cmVzKSkpCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAg
ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FRkFVTFQ7Cj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiArICAgICAgICAgICAgIGlmIChvcHMtPmdldF9iYWNrZW5kX2ZlYXR1cmVzKQo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIHBhcmVudF9mZWF0dXJlcyA9IG9wcy0+
Z2V0X2JhY2tlbmRfZmVhdHVyZXModi0+dmRwYSk7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAg
ICAgICAgICAgIGlmIChmZWF0dXJlcyAmIH4oVkhPU1RfVkRQQV9CQUNLRU5EX0ZFQVRVUkVTIHwK
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCSVRf
VUxMKFZIT1NUX0JBQ0tFTkRfRl9TVVNQRU5EKSB8Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfUkVTVU1F
KSB8Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
QklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfRU5BQkxFX0FGVEVSX0RSSVZFUl9PSykpKQo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBhcmVudF9mZWF0
dXJlcykpCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJu
IC1FT1BOT1RTVVBQOwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICBpZiAoKGZl
YXR1cmVzICYgQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfU1VTUEVORCkpICYmCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgIXZob3N0X3ZkcGFfY2FuX3N1c3BlbmQodikp
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAtLQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gMi4zOS4zCj4g
PiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4KPiA+
ID4KPiA+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
