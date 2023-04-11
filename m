Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966B4C7619A
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 06:55:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EACBD405AE;
	Tue, 11 Apr 2023 06:55:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EACBD405AE
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JkJy8TxX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pW6Pnnyze3rE; Tue, 11 Apr 2023 06:55:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5AA7D4056D;
	Tue, 11 Apr 2023 06:55:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5AA7D4056D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E68AC0037;
	Tue, 11 Apr 2023 06:55:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BF11C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 06:55:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4F87A6143B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 06:55:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4F87A6143B
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JkJy8TxX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SHcvV1ahyeY9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 06:55:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7654360B0E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7654360B0E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 06:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681196138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+zCqBAbm5qTYKfMyXgiPulTFZxoOZvyL5XnQNHyUmjU=;
 b=JkJy8TxXrpyhvns6sKZGWCyj0yCF0MsPsE4oucU1x36sGYm71lyouAIZ3GG0lvgAAlFURV
 9UxqrEPpaI8y1ftMzSVecBGXNGufa07imb+0ryBJZbSBsweFaup3VmNt0iFjgYotoUId8T
 ag5o5jbpN6x+JuPp72hn8fc65hcuPB0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-kF0mHviLPNiEX6CnaT0qhA-1; Tue, 11 Apr 2023 02:55:38 -0400
X-MC-Unique: kF0mHviLPNiEX6CnaT0qhA-1
Received: by mail-wm1-f70.google.com with SMTP id
 m7-20020a05600c3b0700b003ee112e6df1so1339893wms.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 23:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681196136;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+zCqBAbm5qTYKfMyXgiPulTFZxoOZvyL5XnQNHyUmjU=;
 b=WmUYtrvQfGkxDrqlYEv5JJ/eR57GKmElYQQS9ws1OFDz+RWo6EsMsYZd6+0MAnSd9k
 2QMzX/C36iR9H591wA8ko2Hl9MgJVOngPsz448AvaZ3iQHjHOeRz+v6lI9Z/tXTnfEYL
 asbVoXYJtHYKCqiYLSGq/LeR0T6bdbySXyiAiAJ0Q2fXgy1QAIH/FmAVsl1b5LMv/tpa
 dYlkU11ST1FGh0O0fVfkpg2P4cFafE8eFas4T0dq1WiFXwiI9L8mTWjXHjRU/DpjptEJ
 Yz4sq1RtVkfLcadIhymcn1y28JJZ/BLfn8C9cFsst4zfEqyCyBlQNFfEFiFs432M4HTA
 yGZg==
X-Gm-Message-State: AAQBX9fHWrpSJFhz1teVi8/aQg4+509B2/tV7bwxgCA278DiItJGSReV
 y1MwJejkIm/WvpIbqB9QQlNQhcYDwDrK801K4n6aLJ3pLI5Xfu1JTWwYPf0wo8NJ0qCRLlkWCNU
 5a/YoqrRsYnGk69D4LpVtCy+GbkcokzrykGTgTBOnpw==
X-Received: by 2002:a7b:cd0a:0:b0:3ed:5a12:5641 with SMTP id
 f10-20020a7bcd0a000000b003ed5a125641mr8925384wmj.36.1681196136570; 
 Mon, 10 Apr 2023 23:55:36 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZrsPd8G4tkwqcJfLbRy5yd5WQq51HiKg3l0+zbzKKMWhVaXKtP/pVtrYG0ybGrKVrvsfL9Hg==
X-Received: by 2002:a7b:cd0a:0:b0:3ed:5a12:5641 with SMTP id
 f10-20020a7bcd0a000000b003ed5a125641mr8925371wmj.36.1681196136209; 
 Mon, 10 Apr 2023 23:55:36 -0700 (PDT)
Received: from redhat.com ([2.52.10.80]) by smtp.gmail.com with ESMTPSA id
 f1-20020adfe901000000b002f0442a2d3asm5474879wrm.48.2023.04.10.23.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Apr 2023 23:55:35 -0700 (PDT)
Date: Tue, 11 Apr 2023 02:55:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Angus Chen <angus.chen@jaguarmicro.com>
Subject: Re: [PATCH] virtio_pci: Wait for legacy device to be reset
Message-ID: <20230411025335-mutt-send-email-mst@kernel.org>
References: <20230411013833.1305-1-angus.chen@jaguarmicro.com>
 <CACGkMEscqtaTpCed_f2cfknO4--mXCyp33u1CmZwNEZxyf=ifQ@mail.gmail.com>
 <TY2PR06MB3424BACFA8B6CB463C12E31E859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <20230411024459-mutt-send-email-mst@kernel.org>
 <TY2PR06MB3424E3C222C3B896BB583DFD859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TY2PR06MB3424E3C222C3B896BB583DFD859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
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

T24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgMDY6NDk6MDNBTSArMDAwMCwgQW5ndXMgQ2hlbiB3cm90
ZToKPiAKPiAKPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gPiBGcm9tOiBNaWNoYWVs
IFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgo+ID4gU2VudDogVHVlc2RheSwgQXByaWwgMTEs
IDIwMjMgMjo0NyBQTQo+ID4gVG86IEFuZ3VzIENoZW4gPGFuZ3VzLmNoZW5AamFndWFybWljcm8u
Y29tPgo+ID4gQ2M6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Owo+ID4gdmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcKPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHZpcnRpb19wY2k6IFdhaXQgZm9yIGxl
Z2FjeSBkZXZpY2UgdG8gYmUgcmVzZXQKPiA+IAo+ID4gT24gVHVlLCBBcHIgMTEsIDIwMjMgYXQg
MDY6MzY6MzlBTSArMDAwMCwgQW5ndXMgQ2hlbiB3cm90ZToKPiA+ID4gSGkuCj4gPiA+Cj4gPiA+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPiA+ID4gPiBGcm9tOiBKYXNvbiBXYW5nIDxq
YXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gPiA+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDExLCAyMDIz
IDE6MjQgUE0KPiA+ID4gPiBUbzogQW5ndXMgQ2hlbiA8YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5j
b20+Cj4gPiA+ID4gQ2M6IG1zdEByZWRoYXQuY29tOyB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZzsKPiA+ID4gPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4g
PiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gdmlydGlvX3BjaTogV2FpdCBmb3IgbGVnYWN5IGRl
dmljZSB0byBiZSByZXNldAo+ID4gPiA+Cj4gPiA+ID4gT24gVHVlLCBBcHIgMTEsIDIwMjMgYXQg
OTozOeKAr0FNIEFuZ3VzIENoZW4KPiA+IDxhbmd1cy5jaGVuQGphZ3Vhcm1pY3JvLmNvbT4KPiA+
ID4gPiB3cm90ZToKPiA+ID4gPiA+Cj4gPiA+ID4gPiBXZSByZWFkIHRoZSBzdGF0dXMgb2YgZGV2
aWNlIGFmdGVyIHJlc2V0LAo+ID4gPiA+ID4gSXQgaXMgbm90IGd1YXJhbnRlZWQgdGhhdCB0aGUg
ZGV2aWNlIGJlIHJlc2V0ZWQgc3VjY2Vzc2Z1bGx5Lgo+ID4gPiA+ID4gV2UgY2FuIHVzZSBhIHdo
aWxlIGxvb3AgdG8gbWFrZSBzdXJlIHRoYXQsbGlrZSB0aGUgbW9kZXJuIGRldmljZSBkaWQuCj4g
PiA+ID4gPiBUaGUgc3BlYyBpcyBub3QgcmVxdWVzdCBpdCAsYnV0IGl0IHdvcmsuCj4gPiA+ID4K
PiA+ID4gPiBUaGUgb25seSBjb25jZXJuIGlzIGlmIGl0J3MgdG9vIGxhdGUgdG8gZG8gdGhpcy4K
PiA+ID4gPgo+ID4gPiA+IEJ0dywgYW55IHJlYXNvbiB5b3Ugd2FudCB0byBoYXZlIGEgbGVnYWN5
IGhhcmR3YXJlIGltcGxlbWVudGF0aW9uLiBJdAo+ID4gPiA+IHdpbGwgYmUgdmVyeSB0cmlja3kg
dG8gd29yayBjb3JyZWN0bHkuCj4gPiA+ICAgRW4sSSBmb3VuZCB0aGlzIGluIHRoZSByZWFsIHBy
b2R1Y3Rpb24gZW52aXJvbm1lbnQgc29tZSB0aW1lcyBhYm91dCBvbmUKPiA+IHllYXIgYWdvLgo+
ID4gPiBhbmQgSSBmaXggdGhpcyBvdXQgb2YgdHJlZS5vdXIgdmlydGlvIGNhcmQgaGFkIGJlZW4g
c29sZCBhYm91dCB0aG91c2FuZHMgLgo+ID4gPgo+ID4gPiAgIE5vdyx3ZSBjcmVhdGVkIGEgbmV3
IGNhcmQsIGl0IHN1cHBvcnQgdmlydGlvIDAuOTUsMS4wLDEuMSBldGMuCj4gPiAKPiA+IEkgYW0g
bm90IDEwMCUgc3VyZSB3aGF0IGRvZXMgdGhpcyBtZWFuLgo+ID4gU28gaXQncyBhIHRyYW5zaXRp
b25hbCBkZXZpY2UgdGhlbj8KPiBIaSBtc3QsaXQgaXMgYSByZWFsIGNhcmQgaW4gdGhlIEluIGNs
b3VkIGNvbXB1dGluZyAsbm90IHRyYW5zaXRpb25hbCBkZXZpY2UuCgp5ZXMsIGEgcmVhbCBjYXJk
LiBCdXQgeW91IHNhaWQgaXQgc3VwcG9ydHMgMC45NSwgMS4wIGFuZCAxLjEgZ3Vlc3RzLApzbyB0
aGlzIGlzIHdoYXQgdGhlIHZpcnRpbyBzcGVjIGNhbGxzIGEgdHJhbnNpdGlvbmFsIGRldmljZSwg
cmlnaHQ/CgoJVG8gc2ltcGxpZnkgdHJhbnNpdGlvbiBmcm9tIHRoZXNlIGVhcmxpZXIgZHJhZnQg
aW50ZXJmYWNlcywKCWEgZGV2aWNlIE1BWSBpbXBsZW1lbnQ6CgoJXGJlZ2lue2Rlc2NyaXB0aW9u
fQoJXGl0ZW1bVHJhbnNpdGlvbmFsIERldmljZV0KCQlhIGRldmljZSBzdXBwb3J0aW5nIGJvdGgg
ZHJpdmVycyBjb25mb3JtaW5nIHRvIHRoaXMKCQlzcGVjaWZpY2F0aW9uLCBhbmQgYWxsb3dpbmcg
bGVnYWN5IGRyaXZlcnMuCglcZW5ke2Rlc2NyaXB0aW9ufQoKb3IgZGlkIEkgbWlzdW5kZXJzdGFu
ZD8KCgo+ID4gCj4gPiAKPiA+ID4gICBBbmQgd2UgdXNlIHRoaXMgaG9zdCB2ZHBhKyBsZWdhY3kg
dmlydGlvIGluIHZtIHRvIGhvdCBtaWdyYXRpb24sd2UgZm91bmQKPiA+IHRoYXQgdGhlCj4gPiA+
ICAgTGVnYWN5IG1vZGVsIG9mdGVuIGdldCB0aGUgbWlkZGxlIHN0YXRlIHZhbHVlIGFmdGVyIHJl
c2V0IGFuZCBwcm9iZSBhZ2Fpbi4KPiA+ID4gICBUaGUgU29jIGlzIFNpbXVsYXRlZCBieSBmcGdh
IHdoaWNoIGlzIHJ1biBzbG93ZXIgdGhhbiB0aGUgaG9zdCxzbyB0aGUgc2FtZQo+ID4gYnVnCj4g
PiA+ICAgSXMgZm91bmQgbW9yZSBmcmVxdWVudGx5IHdoZW4gdGhlIGhvc3QgdXNlIHRoZSBvdGhl
ciBrZXJuZWwgbGlrZSB1YnVudHUgb3IKPiA+IGNlbnRvczguCj4gPiA+Cj4gPiA+ICAgU28gd2Ug
aG9wZSB3ZSBjYW4gZml4IHRoaXMgYnkgdXBzdHJlYW0gLgo+ID4gPiA+Cj4gPiA+ID4gVGhhbmtz
Cj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbmd1cyBDaGVuIDxh
bmd1cy5jaGVuQGphZ3Vhcm1pY3JvLmNvbT4KPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4gIGRyaXZl
cnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMgfCA0ICsrKy0KPiA+ID4gPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gPiA+ID4gPgo+ID4gPiA+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMKPiA+IGIv
ZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYwo+ID4gPiA+ID4gaW5kZXggMjI1N2Yx
YjNkOGFlLi5mMmQyNDE1NjNlNGYgMTAwNjQ0Cj4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcGNpX2xlZ2FjeS5jCj4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcGNpX2xlZ2FjeS5jCj4gPiA+ID4gPiBAQCAtMTQsNiArMTQsNyBAQAo+ID4gPiA+ID4gICAq
ICBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgo+ID4gPiA+ID4gICAqLwo+ID4g
PiA+ID4KPiA+ID4gPiA+ICsjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4KPiA+ID4gPiA+ICAjaW5j
bHVkZSAibGludXgvdmlydGlvX3BjaV9sZWdhY3kuaCIKPiA+ID4gPiA+ICAjaW5jbHVkZSAidmly
dGlvX3BjaV9jb21tb24uaCIKPiA+ID4gPiA+Cj4gPiA+ID4gPiBAQCAtOTcsNyArOTgsOCBAQCBz
dGF0aWMgdm9pZCB2cF9yZXNldChzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiA+ID4gPiA+
ICAgICAgICAgdnBfbGVnYWN5X3NldF9zdGF0dXMoJnZwX2Rldi0+bGRldiwgMCk7Cj4gPiA+ID4g
PiAgICAgICAgIC8qIEZsdXNoIG91dCB0aGUgc3RhdHVzIHdyaXRlLCBhbmQgZmx1c2ggaW4gZGV2
aWNlIHdyaXRlcywKPiA+ID4gPiA+ICAgICAgICAgICogaW5jbHVkaW5nIE1TaS1YIGludGVycnVw
dHMsIGlmIGFueS4gKi8KPiA+ID4gPiA+IC0gICAgICAgdnBfbGVnYWN5X2dldF9zdGF0dXMoJnZw
X2Rldi0+bGRldik7Cj4gPiA+ID4gPiArICAgICAgIHdoaWxlICh2cF9sZWdhY3lfZ2V0X3N0YXR1
cygmdnBfZGV2LT5sZGV2KSkKPiA+ID4gPiA+ICsgICAgICAgICAgICAgICBtc2xlZXAoMSk7Cj4g
PiA+ID4gPiAgICAgICAgIC8qIEZsdXNoIHBlbmRpbmcgVlEvY29uZmlndXJhdGlvbiBjYWxsYmFj
a3MuICovCj4gPiA+ID4gPiAgICAgICAgIHZwX3N5bmNocm9uaXplX3ZlY3RvcnModmRldik7Cj4g
PiA+ID4gPiAgfQo+ID4gPiA+ID4gLS0KPiA+ID4gPiA+IDIuMjUuMQo+ID4gPiA+ID4KPiA+ID4K
PiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
