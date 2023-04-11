Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AE2C7619A
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 07:21:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F0066409A6;
	Tue, 11 Apr 2023 07:21:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F0066409A6
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iQpf/gRz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c0fscLAmyNJa; Tue, 11 Apr 2023 07:21:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6771F40970;
	Tue, 11 Apr 2023 07:21:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6771F40970
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4382EC0036;
	Tue, 11 Apr 2023 07:21:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4B79C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 07:21:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 71D8060EA6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 07:21:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 71D8060EA6
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iQpf/gRz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iR01A69nEffU
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 07:21:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 845B760E0D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 845B760E0D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 07:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681197677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tAZEXAkipCz/UZI0IW4Zs9IwForteUAjpxiZW8fBEfw=;
 b=iQpf/gRzm4S+8WCCfF4SmyZQWwMvUX6CfEiSRc7NEQjwHoE2gJoa1eLyo+e3qyUcg7k9bc
 5kfGcG/iyQg/4PNO+TxSj5+7/kHcqafCN4G+yqJcwjBqp4bNDELjW7CiIPxaCzoHZqf0Er
 1TRit8Izy7o6MukvoXOGwpVRmsaeJIA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-639WxNJ6MPGA9F4a4WOw2Q-1; Tue, 11 Apr 2023 03:21:16 -0400
X-MC-Unique: 639WxNJ6MPGA9F4a4WOw2Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 n9-20020a05600c4f8900b003ee21220fccso2181874wmq.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 00:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681197675;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tAZEXAkipCz/UZI0IW4Zs9IwForteUAjpxiZW8fBEfw=;
 b=SGusg80G3Ako5eM7DxmBvEYQ0dBzL48o78HihDjCrwCk0l+BYSFYbdKrho+DxabQP0
 c4NT65UhwKFc7E4Q/4gQ5PtH6pTjTV5L63or9c2hJAABJaSPUhTSItaxktxgIKAyBAut
 8VEaqLDyAb2OA8JxXfDhucRePp+Q9bfAtWBY7bSwaVNkIK3MfYQDJ6bkGh4rSvUR7hz1
 Aihl6cLwyaGEBWRyzcKvwh6fxZSi9MVQg3gif6XC9i5TPOAn31ZqGi6Y6R71tyGwWd1x
 /kD0IygAtGNCbN6H4gB6FlwcGf2V5lWy1WxaR5fyEFQKyezZWQpqEAsdIa1L11lmM20N
 NUWg==
X-Gm-Message-State: AAQBX9cCD0g3WHykzviIBWJ8rACspqJhK8UY99/Fj4eR03wMUMaaDKx/
 Id/WJGppivTQ25cX4U0+7p7+PBSdnN5PyZQeZNwB3Tosw4esnPDDmSQsoaV77ml0FOb4jalUcVt
 cS0fjk5P73DMHCsLeBIRx7u+5EEmUNMk2dZbE3bRBbg==
X-Received: by 2002:adf:cf11:0:b0:2ef:eb54:4dbc with SMTP id
 o17-20020adfcf11000000b002efeb544dbcmr5751657wrj.28.1681197675016; 
 Tue, 11 Apr 2023 00:21:15 -0700 (PDT)
X-Google-Smtp-Source: AKy350bRKpwgpjP8BABfdHYs8C9Q+Dd81bOh2t9RU67SmRqY79xVbk1X/TA83fjyWrCHVFs3idDVkQ==
X-Received: by 2002:adf:cf11:0:b0:2ef:eb54:4dbc with SMTP id
 o17-20020adfcf11000000b002efeb544dbcmr5751640wrj.28.1681197674610; 
 Tue, 11 Apr 2023 00:21:14 -0700 (PDT)
Received: from redhat.com ([2.52.10.80]) by smtp.gmail.com with ESMTPSA id
 e4-20020a5d5944000000b002f02df4c7a3sm5734273wri.30.2023.04.11.00.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Apr 2023 00:21:13 -0700 (PDT)
Date: Tue, 11 Apr 2023 03:21:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Angus Chen <angus.chen@jaguarmicro.com>
Subject: Re: [PATCH] virtio_pci: Wait for legacy device to be reset
Message-ID: <20230411032014-mutt-send-email-mst@kernel.org>
References: <20230411013833.1305-1-angus.chen@jaguarmicro.com>
 <CACGkMEscqtaTpCed_f2cfknO4--mXCyp33u1CmZwNEZxyf=ifQ@mail.gmail.com>
 <TY2PR06MB3424BACFA8B6CB463C12E31E859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <20230411024459-mutt-send-email-mst@kernel.org>
 <TY2PR06MB3424E3C222C3B896BB583DFD859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <20230411025335-mutt-send-email-mst@kernel.org>
 <TY2PR06MB3424DB10784CA5504A10099E859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TY2PR06MB3424DB10784CA5504A10099E859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
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

T24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgMDc6MTc6MTRBTSArMDAwMCwgQW5ndXMgQ2hlbiB3cm90
ZToKPiAKPiAKPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gPiBGcm9tOiBNaWNoYWVs
IFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgo+ID4gU2VudDogVHVlc2RheSwgQXByaWwgMTEs
IDIwMjMgMjo1NiBQTQo+ID4gVG86IEFuZ3VzIENoZW4gPGFuZ3VzLmNoZW5AamFndWFybWljcm8u
Y29tPgo+ID4gQ2M6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Owo+ID4gdmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcKPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHZpcnRpb19wY2k6IFdhaXQgZm9yIGxl
Z2FjeSBkZXZpY2UgdG8gYmUgcmVzZXQKPiA+IAo+ID4gT24gVHVlLCBBcHIgMTEsIDIwMjMgYXQg
MDY6NDk6MDNBTSArMDAwMCwgQW5ndXMgQ2hlbiB3cm90ZToKPiA+ID4KPiA+ID4KPiA+ID4gPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+ID4gPiA+IEZyb206IE1pY2hhZWwgUy4gVHNpcmtp
biA8bXN0QHJlZGhhdC5jb20+Cj4gPiA+ID4gU2VudDogVHVlc2RheSwgQXByaWwgMTEsIDIwMjMg
Mjo0NyBQTQo+ID4gPiA+IFRvOiBBbmd1cyBDaGVuIDxhbmd1cy5jaGVuQGphZ3Vhcm1pY3JvLmNv
bT4KPiA+ID4gPiBDYzogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT47Cj4gPiA+ID4g
dmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcKPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSB2aXJ0aW9fcGNpOiBX
YWl0IGZvciBsZWdhY3kgZGV2aWNlIHRvIGJlIHJlc2V0Cj4gPiA+ID4KPiA+ID4gPiBPbiBUdWUs
IEFwciAxMSwgMjAyMyBhdCAwNjozNjozOUFNICswMDAwLCBBbmd1cyBDaGVuIHdyb3RlOgo+ID4g
PiA+ID4gSGkuCj4gPiA+ID4gPgo+ID4gPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQo+ID4gPiA+ID4gPiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4g
PiA+ID4gPiBTZW50OiBUdWVzZGF5LCBBcHJpbCAxMSwgMjAyMyAxOjI0IFBNCj4gPiA+ID4gPiA+
IFRvOiBBbmd1cyBDaGVuIDxhbmd1cy5jaGVuQGphZ3Vhcm1pY3JvLmNvbT4KPiA+ID4gPiA+ID4g
Q2M6IG1zdEByZWRoYXQuY29tOyB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZzsKPiA+ID4gPiA+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwo+ID4gPiA+ID4g
PiBTdWJqZWN0OiBSZTogW1BBVENIXSB2aXJ0aW9fcGNpOiBXYWl0IGZvciBsZWdhY3kgZGV2aWNl
IHRvIGJlIHJlc2V0Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IE9uIFR1ZSwgQXByIDExLCAyMDIz
IGF0IDk6MznigK9BTSBBbmd1cyBDaGVuCj4gPiA+ID4gPGFuZ3VzLmNoZW5AamFndWFybWljcm8u
Y29tPgo+ID4gPiA+ID4gPiB3cm90ZToKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IFdlIHJl
YWQgdGhlIHN0YXR1cyBvZiBkZXZpY2UgYWZ0ZXIgcmVzZXQsCj4gPiA+ID4gPiA+ID4gSXQgaXMg
bm90IGd1YXJhbnRlZWQgdGhhdCB0aGUgZGV2aWNlIGJlIHJlc2V0ZWQgc3VjY2Vzc2Z1bGx5Lgo+
ID4gPiA+ID4gPiA+IFdlIGNhbiB1c2UgYSB3aGlsZSBsb29wIHRvIG1ha2Ugc3VyZSB0aGF0LGxp
a2UgdGhlIG1vZGVybiBkZXZpY2UgZGlkLgo+ID4gPiA+ID4gPiA+IFRoZSBzcGVjIGlzIG5vdCBy
ZXF1ZXN0IGl0ICxidXQgaXQgd29yay4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gVGhlIG9ubHkg
Y29uY2VybiBpcyBpZiBpdCdzIHRvbyBsYXRlIHRvIGRvIHRoaXMuCj4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+IEJ0dywgYW55IHJlYXNvbiB5b3Ugd2FudCB0byBoYXZlIGEgbGVnYWN5IGhhcmR3YXJl
IGltcGxlbWVudGF0aW9uLiBJdAo+ID4gPiA+ID4gPiB3aWxsIGJlIHZlcnkgdHJpY2t5IHRvIHdv
cmsgY29ycmVjdGx5Lgo+ID4gPiA+ID4gICBFbixJIGZvdW5kIHRoaXMgaW4gdGhlIHJlYWwgcHJv
ZHVjdGlvbiBlbnZpcm9ubWVudCBzb21lIHRpbWVzIGFib3V0Cj4gPiBvbmUKPiA+ID4gPiB5ZWFy
IGFnby4KPiA+ID4gPiA+IGFuZCBJIGZpeCB0aGlzIG91dCBvZiB0cmVlLm91ciB2aXJ0aW8gY2Fy
ZCBoYWQgYmVlbiBzb2xkIGFib3V0IHRob3VzYW5kcyAuCj4gPiA+ID4gPgo+ID4gPiA+ID4gICBO
b3csd2UgY3JlYXRlZCBhIG5ldyBjYXJkLCBpdCBzdXBwb3J0IHZpcnRpbyAwLjk1LDEuMCwxLjEg
ZXRjLgo+ID4gPiA+Cj4gPiA+ID4gSSBhbSBub3QgMTAwJSBzdXJlIHdoYXQgZG9lcyB0aGlzIG1l
YW4uCj4gPiA+ID4gU28gaXQncyBhIHRyYW5zaXRpb25hbCBkZXZpY2UgdGhlbj8KPiA+ID4gSGkg
bXN0LGl0IGlzIGEgcmVhbCBjYXJkIGluIHRoZSBJbiBjbG91ZCBjb21wdXRpbmcgLG5vdCB0cmFu
c2l0aW9uYWwgZGV2aWNlLgo+ID4gCj4gPiB5ZXMsIGEgcmVhbCBjYXJkLiBCdXQgeW91IHNhaWQg
aXQgc3VwcG9ydHMgMC45NSwgMS4wIGFuZCAxLjEgZ3Vlc3RzLAo+ID4gc28gdGhpcyBpcyB3aGF0
IHRoZSB2aXJ0aW8gc3BlYyBjYWxscyBhIHRyYW5zaXRpb25hbCBkZXZpY2UsIHJpZ2h0Pwo+ID4g
Cj4gPiAJVG8gc2ltcGxpZnkgdHJhbnNpdGlvbiBmcm9tIHRoZXNlIGVhcmxpZXIgZHJhZnQgaW50
ZXJmYWNlcywKPiA+IAlhIGRldmljZSBNQVkgaW1wbGVtZW50Ogo+ID4gCj4gPiAJXGJlZ2lue2Rl
c2NyaXB0aW9ufQo+ID4gCVxpdGVtW1RyYW5zaXRpb25hbCBEZXZpY2VdCj4gPiAJCWEgZGV2aWNl
IHN1cHBvcnRpbmcgYm90aCBkcml2ZXJzIGNvbmZvcm1pbmcgdG8gdGhpcwo+ID4gCQlzcGVjaWZp
Y2F0aW9uLCBhbmQgYWxsb3dpbmcgbGVnYWN5IGRyaXZlcnMuCj4gPiAJXGVuZHtkZXNjcmlwdGlv
bn0KPiA+IAo+ID4gb3IgZGlkIEkgbWlzdW5kZXJzdGFuZD8KPiA+IAo+IFllcywgSSdtIG5vdCBz
dXJlIHdoZXRoZXIgSSBtYWtlIG15c2VsZiBjbGVhci4gCj4gV2Ugc3VwcG9ydCB0aGUgdnJpdGlv
IHNwZWMgIDAuOTUsIDEuMCBhbmQgMS4xIGluIHRoZSBzYW1lIGNhcmQuCj4gQW5kIHRoZSBudW1l
ciBvZiBkZXZpY2VzIGlzIDFrIHBlciBvbmUgY2FyZC4KPiAKPiBCdHcsIHRoYW5rcyBhIGxvdCBm
b3IgdGhlIHdvcmsgb2YgcmVkaGF0LCB3ZSBqdXN0IEltcGxlbWVudCB0aGUgdmlydGlvIHByb3Rv
Y29sIGJ5IGhhcmR3YXJlLgoKWWVzLCBub3QgdmVyeSBjbGVhciBzdGlsbC4gV2hhdCBhcmUgdGhl
IGRldmljZSBhbmQgdmVuZG9yIElEIG9mIHRoZQpjYXJkPyBEb2VzIGl0IGhhdmUgdGhlIHZpcnRp
byBjYXBhYmlsaXRpZXM/ClRoYW5rcwoKPiA+IAo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+ICAg
QW5kIHdlIHVzZSB0aGlzIGhvc3QgdmRwYSsgbGVnYWN5IHZpcnRpbyBpbiB2bSB0byBob3QgbWln
cmF0aW9uLHdlCj4gPiBmb3VuZAo+ID4gPiA+IHRoYXQgdGhlCj4gPiA+ID4gPiAgIExlZ2FjeSBt
b2RlbCBvZnRlbiBnZXQgdGhlIG1pZGRsZSBzdGF0ZSB2YWx1ZSBhZnRlciByZXNldCBhbmQgcHJv
YmUKPiA+IGFnYWluLgo+ID4gPiA+ID4gICBUaGUgU29jIGlzIFNpbXVsYXRlZCBieSBmcGdhIHdo
aWNoIGlzIHJ1biBzbG93ZXIgdGhhbiB0aGUgaG9zdCxzbyB0aGUKPiA+IHNhbWUKPiA+ID4gPiBi
dWcKPiA+ID4gPiA+ICAgSXMgZm91bmQgbW9yZSBmcmVxdWVudGx5IHdoZW4gdGhlIGhvc3QgdXNl
IHRoZSBvdGhlciBrZXJuZWwgbGlrZQo+ID4gdWJ1bnR1IG9yCj4gPiA+ID4gY2VudG9zOC4KPiA+
ID4gPiA+Cj4gPiA+ID4gPiAgIFNvIHdlIGhvcGUgd2UgY2FuIGZpeCB0aGlzIGJ5IHVwc3RyZWFt
IC4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbmd1cyBDaGVuIDxhbmd1cy5jaGVuQGph
Z3Vhcm1pY3JvLmNvbT4KPiA+ID4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+ID4gPiAgZHJpdmVycy92
aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYyB8IDQgKysrLQo+ID4gPiA+ID4gPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3ku
Ywo+ID4gPiA+IGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYwo+ID4gPiA+ID4g
PiA+IGluZGV4IDIyNTdmMWIzZDhhZS4uZjJkMjQxNTYzZTRmIDEwMDY0NAo+ID4gPiA+ID4gPiA+
IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMKPiA+ID4gPiA+ID4gPiAr
KysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jCj4gPiA+ID4gPiA+ID4gQEAg
LTE0LDYgKzE0LDcgQEAKPiA+ID4gPiA+ID4gPiAgICogIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+Cj4gPiA+ID4gPiA+ID4gICAqLwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gKyNpbmNsdWRlIDxsaW51eC9kZWxheS5oPgo+ID4gPiA+ID4gPiA+ICAjaW5jbHVkZSAibGlu
dXgvdmlydGlvX3BjaV9sZWdhY3kuaCIKPiA+ID4gPiA+ID4gPiAgI2luY2x1ZGUgInZpcnRpb19w
Y2lfY29tbW9uLmgiCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBAQCAtOTcsNyArOTgsOCBA
QCBzdGF0aWMgdm9pZCB2cF9yZXNldChzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiA+ID4g
PiA+ID4gPiAgICAgICAgIHZwX2xlZ2FjeV9zZXRfc3RhdHVzKCZ2cF9kZXYtPmxkZXYsIDApOwo+
ID4gPiA+ID4gPiA+ICAgICAgICAgLyogRmx1c2ggb3V0IHRoZSBzdGF0dXMgd3JpdGUsIGFuZCBm
bHVzaCBpbiBkZXZpY2Ugd3JpdGVzLAo+ID4gPiA+ID4gPiA+ICAgICAgICAgICogaW5jbHVkaW5n
IE1TaS1YIGludGVycnVwdHMsIGlmIGFueS4gKi8KPiA+ID4gPiA+ID4gPiAtICAgICAgIHZwX2xl
Z2FjeV9nZXRfc3RhdHVzKCZ2cF9kZXYtPmxkZXYpOwo+ID4gPiA+ID4gPiA+ICsgICAgICAgd2hp
bGUgKHZwX2xlZ2FjeV9nZXRfc3RhdHVzKCZ2cF9kZXYtPmxkZXYpKQo+ID4gPiA+ID4gPiA+ICsg
ICAgICAgICAgICAgICBtc2xlZXAoMSk7Cj4gPiA+ID4gPiA+ID4gICAgICAgICAvKiBGbHVzaCBw
ZW5kaW5nIFZRL2NvbmZpZ3VyYXRpb24gY2FsbGJhY2tzLiAqLwo+ID4gPiA+ID4gPiA+ICAgICAg
ICAgdnBfc3luY2hyb25pemVfdmVjdG9ycyh2ZGV2KTsKPiA+ID4gPiA+ID4gPiAgfQo+ID4gPiA+
ID4gPiA+IC0tCj4gPiA+ID4gPiA+ID4gMi4yNS4xCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+Cj4g
PiA+Cj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
