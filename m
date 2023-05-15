Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321B8C7EE22
	for <virtualization@archiver.kernel.org>; Mon, 15 May 2023 05:13:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9E7260D9D;
	Mon, 15 May 2023 05:13:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A9E7260D9D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FpIjMo3g
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tgS7RaGXoSEM; Mon, 15 May 2023 05:13:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 11BA060D4F;
	Mon, 15 May 2023 05:13:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 11BA060D4F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB951C0037;
	Mon, 15 May 2023 05:13:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5876AC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 05:13:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1E3BF60BE4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 05:13:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1E3BF60BE4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9UvSsrjl8jYh
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 05:13:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3A4EA60767
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3A4EA60767
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 05:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684127630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PWL+vmE+VOJe076wrGPBFtIigtHfPH7nZD62FaxHuXw=;
 b=FpIjMo3gEJhQLff7g9A3IOhT/MajYik6ru5SjI049l3dIk0tJRHvIZvFCB/fOR/j5Z+FOq
 4NFZHN83yHkRgh0fR3SAfYtJazrA7YAXmwP0i/us6SHlRdMNGvIqH3q1FGIfhlVNzGJQp0
 n2bFstdVzB6rxOtjcMIEg2ns+4Ugmn4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-eGM04Im1OtK0zR6_7IqWeA-1; Mon, 15 May 2023 01:13:47 -0400
X-MC-Unique: eGM04Im1OtK0zR6_7IqWeA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4edc5526c5eso6753263e87.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 May 2023 22:13:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684127625; x=1686719625;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PWL+vmE+VOJe076wrGPBFtIigtHfPH7nZD62FaxHuXw=;
 b=YdStwSMoeV0eOmP9czXPjH9lyjAcniyMoZXY36Mtm45naKbDmc3B14EfWZjtpELyJ+
 2cSHZXBAoIuNr6z3MhFfWIvJyaiP+zWnHEeoC8bYmu2t7WgyHuTQ4M3iPRDhg24C+olJ
 ux9azHwvQPUxpNEbu5VZpvv0QOyTQlGVT2qD0dp3QMhhdr0ZmWxRgU9p5+lEjGiG8w0l
 D6sa7xAbeULA1xE4Rs0PgShSw/P9u40ba9WExY5YYwYCDVJOG/xIcYPvgIuaACzA5+No
 35wl+B9ZGWcoeZxzXNpAVNCNNbZ5k3O8XTpD/ioxmG2rYaDMjBbWbUuZiinpI8VKCegc
 7rdg==
X-Gm-Message-State: AC+VfDw85cwiXBGxQz289JRnDfhyyI2S4iMicXD70aw7gFsh5DKhvpiM
 gWNx89GU6P7jnY8mZ67ncm2vRnBOKoT9CLy4zWKEMmGYFJOKcQZFYsbbfQ3Oes+qr5wn/iG8MZV
 a5wYws5Qg2tvTSG0B1mqZ2Azryczqiyw+8tUcDyptf/eIWsBOdqkVSghC6A==
X-Received: by 2002:ac2:4c32:0:b0:4f2:e145:7170 with SMTP id
 u18-20020ac24c32000000b004f2e1457170mr1682379lfq.11.1684127625478; 
 Sun, 14 May 2023 22:13:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ZDYbQ+I0fYbiU45FL35gM04BNhJdJfhiYH+NriIaHw8/yqwgU+oUXPwnN3SEJjYQbqiGN9mYQ8oRKuot6BZU=
X-Received: by 2002:ac2:4c32:0:b0:4f2:e145:7170 with SMTP id
 u18-20020ac24c32000000b004f2e1457170mr1682370lfq.11.1684127625214; Sun, 14
 May 2023 22:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230413064027.13267-1-jasowang@redhat.com>
 <20230413064027.13267-2-jasowang@redhat.com>
 <20230413121525-mutt-send-email-mst@kernel.org>
 <CACGkMEunn1Z3n8yjVaWLqdV502yjaCBSAb_LO4KsB0nuxXmV8A@mail.gmail.com>
 <20230414031947-mutt-send-email-mst@kernel.org>
 <CACGkMEtutGn0CoJhoPHbzPuqoCLb4OCT6a_vB_WPV=MhwY0DXg@mail.gmail.com>
 <20230510012951-mutt-send-email-mst@kernel.org>
 <CACGkMEszPydzw_MOUOVJKBBW_8iYn66i_9OFvLDoZMH34hMx=w@mail.gmail.com>
 <20230515004422-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230515004422-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 May 2023 13:13:33 +0800
Message-ID: <CACGkMEv+Q2UoBarNOzKSrc3O=Wb2_73O2j9cZXFdAiLBm1qY-Q@mail.gmail.com>
Subject: Re: [PATCH net-next V2 1/2] virtio-net: convert rx mode setting to
 use workqueue
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, netdev <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, edumazet@google.com, maxime.coquelin@redhat.com,
 kuba@kernel.org, pabeni@redhat.com, david.marchand@redhat.com,
 davem@davemloft.net
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

T24gTW9uLCBNYXkgMTUsIDIwMjMgYXQgMTI6NDXigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1z
dEByZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIE1vbiwgTWF5IDE1LCAyMDIzIGF0IDA5OjA1OjU0
QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiBPbiBXZWQsIE1heSAxMCwgMjAyMyBhdCAx
OjMz4oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+
Cj4gPiA+IE9uIE1vbiwgQXByIDE3LCAyMDIzIGF0IDExOjQwOjU4QU0gKzA4MDAsIEphc29uIFdh
bmcgd3JvdGU6Cj4gPiA+ID4gT24gRnJpLCBBcHIgMTQsIDIwMjMgYXQgMzoyMeKAr1BNIE1pY2hh
ZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4KPiA+ID4gPiA+
IE9uIEZyaSwgQXByIDE0LCAyMDIzIGF0IDAxOjA0OjE1UE0gKzA4MDAsIEphc29uIFdhbmcgd3Jv
dGU6Cj4gPiA+ID4gPiA+IEZvcmdldCB0byBjYyBuZXRkZXYsIGFkZGluZy4KPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gT24gRnJpLCBBcHIgMTQsIDIwMjMgYXQgMTI6MjXigK9BTSBNaWNoYWVsIFMu
IFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+IE9uIFRodSwgQXByIDEzLCAyMDIzIGF0IDAyOjQwOjI2UE0gKzA4MDAsIEphc29uIFdhbmcg
d3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiBUaGlzIHBhdGNoIGNvbnZlcnQgcnggbW9kZSBzZXR0aW5n
IHRvIGJlIGRvbmUgaW4gYSB3b3JrcXVldWUsIHRoaXMgaXMKPiA+ID4gPiA+ID4gPiA+IGEgbXVz
dCBmb3IgYWxsb3cgdG8gc2xlZXAgd2hlbiB3YWl0aW5nIGZvciB0aGUgY3ZxIGNvbW1hbmQgdG8K
PiA+ID4gPiA+ID4gPiA+IHJlc3BvbnNlIHNpbmNlIGN1cnJlbnQgY29kZSBpcyBleGVjdXRlZCB1
bmRlciBhZGRyIHNwaW4gbG9jay4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+ID4gSSBkb24ndCBsaWtlIHRoaXMgZnJhbmtseS4gVGhpcyBtZWFucyB0aGF0
IHNldHRpbmcgUlggbW9kZSB3aGljaCB3b3VsZAo+ID4gPiA+ID4gPiA+IHByZXZpb3VzbHkgYmUg
cmVsaWFibGUsIG5vdyBiZWNvbWVzIHVucmVsaWFibGUuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
IEl0IGlzICJ1bnJlbGlhYmxlIiBieSBkZXNpZ246Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ICAg
ICAgIHZvaWQgICAgICAgICAgICAgICAgICAgICgqbmRvX3NldF9yeF9tb2RlKShzdHJ1Y3QgbmV0
X2RldmljZSAqZGV2KTsKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiAtIGZpcnN0IG9mIGFsbCBj
b25maWd1cmF0aW9uIGlzIG5vIGxvbmdlciBpbW1lZGlhdGUKPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gSXMgaW1tZWRpYXRlIGEgaGFyZCByZXF1aXJlbWVudD8gSSBjYW4gc2VlIGEgd29ya3F1ZXVl
IGlzIHVzZWQgYXQgbGVhc3Q6Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IG1seDVlLCBpcG9pYiwg
ZWZ4LCAuLi4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiAgIGFuZCB0aGVyZSBpcyBubyB3YXkg
Zm9yIGRyaXZlciB0byBmaW5kIG91dCB3aGVuCj4gPiA+ID4gPiA+ID4gICBpdCBhY3R1YWxseSB0
b29rIGVmZmVjdAo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBCdXQgd2Uga25vdyByeCBtb2RlIGlz
IGJlc3QgZWZmb3J0IGUuZyBpdCBkb2Vzbid0IHN1cHBvcnQgdmhvc3QgYW5kIHdlCj4gPiA+ID4g
PiA+IHN1cnZpdmUgZnJvbSB0aGlzIGZvciB5ZWFycy4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiAtIHNlY29uZCwgaWYgZGV2aWNlIGZhaWxzIGNvbW1hbmQsIHRoaXMgaXMgYWxzbyBub3QKPiA+
ID4gPiA+ID4gPiAgIHByb3BhZ2F0ZWQgdG8gZHJpdmVyLCBhZ2FpbiBubyB3YXkgZm9yIGRyaXZl
ciB0byBmaW5kIG91dAo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gVkRVU0UgbmVlZHMgdG8g
YmUgZml4ZWQgdG8gZG8gdHJpY2tzIHRvIGZpeCB0aGlzCj4gPiA+ID4gPiA+ID4gd2l0aG91dCBi
cmVha2luZyBub3JtYWwgZHJpdmVycy4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gSXQncyBub3Qg
c3BlY2lmaWMgdG8gVkRVU0UuIEZvciBleGFtcGxlLCB3aGVuIHVzaW5nIHZpcnRpby1uZXQgaW4g
dGhlCj4gPiA+ID4gPiA+IFVQIGVudmlyb25tZW50IHdpdGggYW55IHNvZnR3YXJlIGN2cSAobGlr
ZSBtbHg1IHZpYSB2RFBBIG9yIGNtYQo+ID4gPiA+ID4gPiB0cmFuc3BvcnQpLgo+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiA+Cj4gPiA+ID4gPiBIbW0uIENhbiB3ZSBkaWZm
ZXJlbnRpYXRlIGJldHdlZW4gdGhlc2UgdXNlLWNhc2VzPwo+ID4gPiA+Cj4gPiA+ID4gSXQgZG9l
c24ndCBsb29rIGVhc3kgc2luY2Ugd2UgYXJlIGRyaXZlcnMgZm9yIHZpcnRpbyBidXMuIFVuZGVy
bGF5ZXIKPiA+ID4gPiBkZXRhaWxzIHdlcmUgaGlkZGVuIGZyb20gdmlydGlvLW5ldC4KPiA+ID4g
Pgo+ID4gPiA+IE9yIGRvIHlvdSBoYXZlIGFueSBpZGVhcyBvbiB0aGlzPwo+ID4gPiA+Cj4gPiA+
ID4gVGhhbmtzCj4gPiA+Cj4gPiA+IEkgZG9uJ3Qga25vdywgcGFzcyBzb21lIGtpbmQgb2YgZmxh
ZyBpbiBzdHJ1Y3QgdmlydHF1ZXVlPwo+ID4gPiAgICAgICAgICJib29sIHNsb3c7IC8qIFRoaXMg
dnEgY2FuIGJlIHZlcnkgc2xvdyBzb21ldGltZXMuIERvbid0IHdhaXQgZm9yIGl0ISAqLyIKPiA+
ID4KPiA+ID4gPwo+ID4gPgo+ID4KPiA+IFNvIGlmIGl0J3Mgc2xvdywgc2xlZXAsIG90aGVyd2lz
ZSBwb2xsPwo+ID4KPiA+IEkgZmVlbCBzZXR0aW5nIHRoaXMgZmxhZyBtaWdodCBiZSB0cmlja3ks
IHNpbmNlIHRoZSBkcml2ZXIgZG9lc24ndAo+ID4ga25vdyB3aGV0aGVyIG9yIG5vdCBpdCdzIHJl
YWxseSBzbG93LiBFLmcgc21hcnROSUMgdmVuZG9yIG1heSBhbGxvdwo+ID4gdmlydGlvLW5ldCBl
bXVsYXRpb24gb3ZlciBQQ0kuCj4gPgo+ID4gVGhhbmtzCj4KPiBkcml2ZXIgd2lsbCBoYXZlIHRo
ZSBjaG9pY2UsIGRlcGVuZGluZyBvbiB3aGV0aGVyCj4gdnEgaXMgZGV0ZXJtaW5pc3RpYyBvciBu
b3QuCgpPaywgYnV0IHRoZSBwcm9ibGVtIGlzLCBzdWNoIGJvb2xlYW5zIGFyZSBvbmx5IHVzZWZ1
bCBmb3IgdmlydGlvIHJpbmcKY29kZXMuIEJ1dCBpbiB0aGlzIGNhc2UsIHZpcnRpby1uZXQga25v
d3Mgd2hhdCB0byBkbyBmb3IgY3ZxLiBTbyBJJ20Kbm90IHN1cmUgd2hvIHRoZSB1c2VyIGlzLgoK
VGhhbmtzCgo+Cj4KPiA+ID4gLS0KPiA+ID4gTVNUCj4gPiA+Cj4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
