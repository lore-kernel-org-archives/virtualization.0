Return-Path: <SRS0=dYih=NI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BD1C4338F
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 03:56:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24D3C60F35
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 03:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 24D3C60F35
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0AD280CC7;
	Tue, 17 Aug 2021 03:56:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ip8f7kVfqAkl; Tue, 17 Aug 2021 03:56:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6602B80C4E;
	Tue, 17 Aug 2021 03:56:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BEB0C001A;
	Tue, 17 Aug 2021 03:56:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA518C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 03:55:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 93043402DF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 03:55:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rxUB8ymZNBvc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 03:55:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2825D402CE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 03:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629172555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Ef9jRpUHHmKrSBFC7l5fwEuMR/XTDyuAYeBLIj+x4c=;
 b=Nyfyi98Taf3+4PqMEXBvwU66D1E+AQfM5qr9mCt+RaKJOx/V5xn2g5f9N5SdGdikY5yoCl
 4pxPm2JVddJc2u9ht1ZF/Bwk5zD5QEOo4HiRfshETtMfu7PKQ2ByKdF1RRd+2ClAo8ktYm
 Hz6vOKk25RIoddBkDD3TDhUA410+N3Y=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-lK8Qj6EmNRC6wPzcwee_jw-1; Mon, 16 Aug 2021 23:55:54 -0400
X-MC-Unique: lK8Qj6EmNRC6wPzcwee_jw-1
Received: by mail-lj1-f199.google.com with SMTP id
 w28-20020a2e161c000000b001ba14fc0cd4so1229096ljd.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 20:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/Ef9jRpUHHmKrSBFC7l5fwEuMR/XTDyuAYeBLIj+x4c=;
 b=eG81vJkfNpWZqww/EbSVSCt1qhmMpjE8Umzm/ZgzruWdpDcV6a2tWTEenXrjYsRH5M
 N15+hMJ3B6DyNEKguVvaGFu7h+ZUa+ALAjGeejuymo+oJKTaqaRM8/2/oDfw4cSYZyIN
 0m/ypRY1bhM55z3QaP74W/EYxRrcrPsz37wZto+VLOhsuVozvzUf/aX2GSIn6gGKisuu
 LOkE899TpAZafoTtJXo4tGmOzWzoacZThu+hSx++Z4f+0Nw60oyNpQMao+XK318fEsL0
 +G/cfH/BL2vowzyk3eTiw5ACTzJpdXsCsWGMR76RzdMt853y146fASttioN6Q/Nu0rVM
 ohgw==
X-Gm-Message-State: AOAM533D6/zb9fw1z3ly0zvWQn1uiUVtk2Cmeoa23m/y0HHcWwEURhv/
 tpkIyRD+tUiBRbB4OUocFqxG1CY2XhLVrrq5kFoP8xpdCFEHtklsdsRU7FAA22nm3/aiLn9r1Li
 Hj31eAUI98kSy4oW/vNEZ3C6zwVptikVVRjARGRz3Roage8FhdcbnjQqfrg==
X-Received: by 2002:a2e:9ec1:: with SMTP id h1mr1342936ljk.0.1629172553153;
 Mon, 16 Aug 2021 20:55:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxukgICKmeeTQHY8orkepIgNu74cN861S59l6rRYxFpxT99/QJde4+LgsPDUeJqz3RNSpGM0YKMHX/Rf3aUMF0=
X-Received: by 2002:a2e:9ec1:: with SMTP id h1mr1342923ljk.0.1629172552925;
 Mon, 16 Aug 2021 20:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <c318303b-3774-909a-a532-2189e9e5a3b9@redhat.com>
 <20210812045535.GA99755@mtl-vdi-166.wap.labs.mlnx>
 <CACGkMEsyHiia5DrRU0nLy_OkUZLcQ1==y4Gxy1sETWpVQpVXvg@mail.gmail.com>
 <20210812070151.GA103566@mtl-vdi-166.wap.labs.mlnx>
 <2cc15e3e-bd5c-8e43-1d2f-b0e03b8690d5@redhat.com>
 <20210812095035.GA105096@mtl-vdi-166.wap.labs.mlnx>
 <61b913bb-3f6b-49d4-f5f1-32dce3bd7fae@redhat.com>
 <20210816054746.GA30532@mtl-vdi-166.wap.labs.mlnx>
 <3f26a849-d1a8-49e2-cb60-d58d7c4cbcd9@redhat.com>
 <20210816165659.GA51703@mtl-vdi-166.wap.labs.mlnx>
 <20210816153630-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210816153630-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 17 Aug 2021 11:55:42 +0800
Message-ID: <CACGkMEvu9tUWPkYqLoDzJ0gR=5RMstMhcU+OkhFtHn7TB5Ki6Q@mail.gmail.com>
Subject: Re: [Patch v1 3/3] vdpa/mlx5: Add multiqueue support
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: eperezma <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>,
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

T24gVHVlLCBBdWcgMTcsIDIwMjEgYXQgMzozNyBBTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIE1vbiwgQXVnIDE2LCAyMDIxIGF0IDA3OjU2OjU5UE0g
KzAzMDAsIEVsaSBDb2hlbiB3cm90ZToKPiA+IE9uIE1vbiwgQXVnIDE2LCAyMDIxIGF0IDAxOjU4
OjA2UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+Cj4gPiA+IOWcqCAyMDIxLzgvMTYg
5LiL5Y2IMTo0NywgRWxpIENvaGVuIOWGmemBkzoKPiA+ID4gPiBPbiBNb24sIEF1ZyAxNiwgMjAy
MSBhdCAxMjoxNjoxNFBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4g5ZyoIDIw
MjEvOC8xMiDkuIvljYg1OjUwLCBFbGkgQ29oZW4g5YaZ6YGTOgo+ID4gPiA+ID4gPiBPbiBUaHUs
IEF1ZyAxMiwgMjAyMSBhdCAwMzowNDozNVBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4g
PiA+ID4gPiA+IOWcqCAyMDIxLzgvMTIg5LiL5Y2IMzowMSwgRWxpIENvaGVuIOWGmemBkzoKPiA+
ID4gPiA+ID4gPiA+IE9uIFRodSwgQXVnIDEyLCAyMDIxIGF0IDAyOjQ3OjA2UE0gKzA4MDAsIEph
c29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+IE9uIFRodSwgQXVnIDEyLCAyMDIxIGF0
IDEyOjU1IFBNIEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4g
PiA+ID4gPiBPbiBUaHUsIEF1ZyAxMiwgMjAyMSBhdCAxMToxOToxOUFNICswODAwLCBKYXNvbiBX
YW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g5ZyoIDIwMjEvOC8xMSDkuIvljYg3OjA0
LCBFbGkgQ29oZW4g5YaZ6YGTOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBPbiBXZWQsIEF1ZyAx
MSwgMjAyMSBhdCAwNDozNzo0NFBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IOWcqCAyMDIxLzgvMTEg5LiL5Y2IMzo1MywgRWxpIENvaGVuIOWGmemB
kzoKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gT25lIHRoaW5nIG5lZWQgdG8gc29sdmUg
Zm9yIG1xIGlzIHRoYXQgdGhlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICtz
dGF0aWMgdTE2IGN0cmxfdnFfaWR4KHN0cnVjdCAgbWx4NV92ZHBhX2RldiAqbXZkZXYpCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gK3sKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiArICAgICByZXR1cm4gMiAqICBtbHg1X3ZkcGFfbWF4X3FwcyhtdmRldi0+bWF4X3Zxcyk7
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gK30KPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gV2Ugc2hvdWxkIGhhbmRsZSB0aGUgY2FzZSB3aGVuIE1RIGlzIHN1cHBvcnRlZCBi
eSB0aGUgZGV2aWNlIGJ1dCBub3QgdGhlCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGRy
aXZlci4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gRS5nIGluIHRoZSBjYXNlIHdoZW4gd2UgaGF2ZSAyIHF1ZXVlIHBhaXJzOgo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBX
aGVuIE1RIGlzIGVuYWJsZWQsIGN2cSBpcyBxdWV1ZSA0Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFdoZW4gTVEgaXMgbm90IGVuYWJs
ZWQsIGN2cSBpcyBxdWV1ZSAyCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiBUaGVyZSdzIHNvbWUgaXNzdWUgd2l0aCB0aGlzLiBJIGdldCBj
YWxsYmFja3MgdGFyZ2V0aW5nIHNwZWNpZmljCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiB2
aXJ0cXVldWVzIGJlZm9yZSBmZWF0dXJlcyBuZWdvdGlhdGlvbiBoYXMgYmVlbiBjb21wbGV0ZWQu
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
U3BlY2lmaWNhbGx5LCBJIGdldCBzZXRfdnFfY2IoKSBjYWxscy4gQXQgdGhpcyBwb2ludCBJIG11
c3Qga25vdyB0aGUKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGNvbnRyb2wgdnEgaW5kZXgu
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gU28gSSB0aGluayB3ZSBuZWVkIGRvIGJvdGg6Cj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAxKSBBdCBv
bmUgaGFuZCwgaXQncyBhIGJ1ZyBmb3IgdGhlIHVzZXJzcGFjZSB0byB1c2UgdnFfaW5kZXggYmVm
b3JlIGZlYXR1cmUKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBpcyBuZWdvdGlhdGVkCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAobG9va3MgbGlr
ZSBhIGJ1ZyBpbiBteSBjdnEgc2VyaWVzIHRoYXQgd2lsbCBjYWxsIFNFVF9WUklOR19DQUxMIGJl
Zm9yZQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGZlYXR1cmUgaXMgbmVnb3RpYXRlLCB3aGlj
aCBJIHdpbGwgbG9vaykuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiAyKSBBdCB0aGUgb3RoZXIgaGFuZCwgdGhlIGRyaXZlciBzaG91bGQgYmUgYWJs
ZSB0byBkZWFsIHdpdGggdGhhdAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IEFsbCBJIGNhbiBkbyBpcyBkcm9wIGNhbGxiYWNrcyBmb3IgVlFzIGJlZm9y
ZSBmZWF0dXJlcyBuZWdvdGF0aW9uIGhhcwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBiZWVuIGNv
bXBsZXRlZC4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IE9yIGp1c3QgbGVhdmUgcXVldWUgaW5kZXgg
MCwgMSB3b3JrLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFNp
bmNlIGl0IGlzIG5vdCBleHBlY3RlZCB0byBiZSBjaGFuZ2VkLgo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiBSaWdodCwgd2lsbCBkby4KPiA+ID4gPiA+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gSSB0aGluayB0aGUgQ1ZRIGluZGV4IG11c3Qg
bm90IGRlcGVuZCBvbiB0aGUgbmVnb3RpYXRlZCBmZWF0dXJlcyBidXQKPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IHJhdGhlciBkZXBlbmQgb2YgdGhlIHZhbHVlIHRoZSBkZXZpY2UgZHJpdmVy
IHByb3ZpZGVzIGluIHRoZSBjYWxsIHRvCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBfdmRw
YV9yZWdpc3Rlcl9kZXZpY2UoKS4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBBdCB0aGUgdmly
dGlvIGxldmVsLCBpdCdzIHRvbyBsYXRlIHRvIGNoYW5nZSB0aGF0IGFuZCBpdCBicmVha3MgdGhl
IGJhY2t3YXJkCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gY29tcGF0aWJpbGl0eS4KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEJ1dCBhdCB0aGUg
dkRQQSBsZXZlbCwgdGhlIHVuZGVyIGxheWVyIGRldmljZSBjYW4gbWFwIHZpcnRpbyBjdnEgdG8g
YW55IG9mCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gaXQncyB2aXJ0cXVldWUuCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBFLmcgbWFwIGN2cSAo
aW5kZXggMikgdG8gbWx4NSBjdnEgKHRoZSBsYXN0KS4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBJIGFtIG5vdCBmb2xsb3dpbmcgeW91IGhlcmUuIEkg
c3RpbGwgZG9uJ3Qga25vdyB3aGF0IGluZGV4IGlzIGN2cS4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IFJpZ2h0LCB3ZSBzdGlsbCBuZWVkIHRvIHdhaXQgZm9yIHRoZSBmZWF0dXJlIGJlaW5nIG5lZ290
aWF0ZWQgaW4gb3JkZXIgdG8KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHByb2NlZWQuCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+IFNvIHRvIHN1bW1hcmlzZSwgYmVmb3Jl
IGZlYXR1cmUgbmVnb3RpYXRpb24gY29tcGxldGUsIEkgYWNjZXB0IGNhbGxzCj4gPiA+ID4gPiA+
ID4gPiA+ID4gcmVmZXJyaW5nIHRvIFZRcyBvbmx5IGZvciBpbmRpY2VzIDAgYW5kIDEuCj4gPiA+
ID4gPiA+ID4gPiA+ID4gQWZ0ZXIgZmVhdHVyZSBuZWdvdGlhdGlvbiBjb21wbGV0ZSBJIGtub3cg
Q1ZRIGluZGV4IGFuZCB3aWxsIGFjY2VwdAo+ID4gPiA+ID4gPiA+ID4gPiA+IGluZGljZXMgMCB0
byBjdnEgaW5kZXguCj4gPiA+ID4gPiA+ID4gPiA+IEkgZG9uJ3QgZ2V0IHRoaXMgImFjY2VwdCBp
bmRpY2VzIDAgdG8gY3ZxIGluZGV4Ii4KPiA+ID4gPiA+ID4gPiA+IFdoYXQgSSBtZWFudCB0byBz
YXkgaXMgdGhhdCB0aGVyZSBhcmUgc2V2ZXJhbCBjYWxsYmFja3MgdGhhdCByZWZlciB0bwo+ID4g
PiA+ID4gPiA+ID4gc3BlY2lmaWMgdmlydHF1ZXVlcywgZS5nLiBzZXRfdnFfYWRkcmVzcygpLCBz
ZXRfdnFfbnVtKCkgZXRjLiBUaGV5IGFsbAo+ID4gPiA+ID4gPiA+ID4gYWNjZXB0IHZpcnRxdWV1
ZSBpbmRleCBhcyBhbiBhcmd1bWVudC4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBX
aGF0IHdlIHdhbnQgdG8gZG8gaXMgdmVyaWZ5IHdoZWF0aGVyIHRoZSBpbmRleCBwcm92aWRlZCBp
cyB2YWxpZCBvcgo+ID4gPiA+ID4gPiA+ID4gbm90LiBJZiBpdCBpcyBub3QgdmFsaWQsIGVpdGhl
ciByZXR1cm4gZXJyb3IgKGlmIHRoZSBjYWxsYmFjayBjYW4gcmV0dXJuCj4gPiA+ID4gPiA+ID4g
PiBhIHZhbHVlKSBvciBqdXN0IGF2b2lkIHByb2Nlc3NpbmcgaXQuIElmIHRoZSBpbmRleCBpcyB2
YWxpZCB0aGVuIHdlCj4gPiA+ID4gPiA+ID4gPiBwcm9jZXNzIGl0IG5vcm1hbGx5Lgo+ID4gPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IE5vdyB3ZSBuZWVkIHRvIGRlY2lkZSB3aGljaCBpbmRl
eCBpcyB2YWxpZCBvciBub3QuIFdlIG5lZWQgc29tZXRoaW5nCj4gPiA+ID4gPiA+ID4gPiBsaWtl
IHRoaXMgdG8gaWRlbnRpZml5IHZhbGlkIGluZGV4ZXMgcmFuZ2U6Cj4gPiA+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+ID4gQ1ZRIGNsZWFyOiAwIGFuZCAxCj4gPiA+ID4gPiA+ID4gPiBDVlEgc2V0
LCBNUSBjbGVhcjogMCwgMSBhbmQgMiAoZm9yIENWUSkuCj4gPiA+ID4gPiA+ID4gPiBDVlEgc2V0
LCBNUSBzZXQ6IDAuLm52cSB3aGVyZSBudnEgaXMgd2hhdGV2ZXIgcHJvdmlkZWQgdG8KPiA+ID4g
PiA+ID4gPiA+IF92ZHBhX3JlZ2lzdGVyX2RldmljZSgpCj4gPiA+ID4gPiA+ID4gWWVzLgo+ID4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFVuZm9ydHVuYXRlbHkgaXQgZG9lcyBub3Qgd29yay4KPiA+
ID4gPiA+ID4gc2V0X3ZxX2NiKCkgZm9yIGFsbCB0aGUgbXVsdGlxdWV1ZXMgaXMgY2FsbGVkIGJl
b2ZyZSBmZWF0dXJlCj4gPiA+ID4gPiA+IG5lZ290aWF0aW9uLiBJZiBJIGFwcGx5IHRoZSBhYm92
ZSBsb2dpYywgSSB3aWxsIGxvc2UgdGhlc2Ugc2V0dGluZ3MuCj4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+IEkgY2FuIG1ha2UgYW4gZXhjZXB0aW9uIGZvciBzZXRfdnFfY2IoKSwgc2F2ZSBjYWxsYmFj
a3MgYW5kIHJlc3RvcmUKPiA+ID4gPiA+ID4gdGhlbSBhZnRlcndhcmRzLiBUaGlzIGxvb2tzIHRv
byBjb252b2x1dGVkIGFuZCBtYXliZSB3ZSBzaG91bGQgc2Vlawo+ID4gPiA+ID4gPiBhbm90aGVy
IHNvbHV0aW9uLgo+ID4gPiA+ID4KPiA+ID4gPiA+IEkgYWdyZWUuCj4gPiA+ID4gPgo+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gTGV0IG1lIGtub3cgd2hhdCB5b3UgdGhpbmsuCj4gPiA+ID4gPgo+ID4g
PiA+ID4gUmV0aGluayBhYm91dCB0aGlzIGlzc3VlLiBJdCBsb29rcyB0byB0aGUgb25seSBpc3N1
ZSB3ZSBmYWNlIGlzIHRoZQo+ID4gPiA+ID4gc2V0X3ZxX2NiKCkuCj4gPiA+ID4gPgo+ID4gPiA+
ID4gV2l0aCB0aGUgYXNzdW1wdGlvbiB0aGF0IHRoZSB1c2Vyc3BhY2UgY2FuIHVzZSB0aGUgaW5k
ZXggY29ycmVjdGx5IChldmVuCj4gPiA+ID4gPiBiZWZvcmUgc2V0X2ZlYXR1cmVzKS4gSSB3b25k
ZXIgdGhlIGZvbGxvd2luZyB3b3Jrcy4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBJbnN0ZWFkIG9mIGNo
ZWNraW5nIHdoZXRoZXIgdGhlIGluZGV4IGlzIGN2cSBpbiBzZXRfdnFfY2IoKSBob3cgYWJvdXQ6
Cj4gPiA+ID4gPgo+ID4gPiA+ID4gMSkgZGVjb3VwbGUgZXZlbnRfY2Igb3V0IG9mIG1seDVfdmRw
YV92aXJ0cXVldWUgYW5kIG1seDVfY29uZ3JvX3ZxCj4gPiA+ID4gPiAyKSBoYXZlIGEgZGVkaWNh
dGVkIGV2ZW50X2NiIGFycmF5IGluIG1seDVfdmRwYV9uZXQKPiA+ID4gPiA+IDMpIHRoZW4gd2Ug
Y2FuIGRvCj4gPiA+ID4gPgo+ID4gPiA+ID4gbmRldi0+ZXZlbnRfY2JzW2luZGV4XSA9ICpjYjsK
PiA+ID4gPiA+Cj4gPiA+ID4gU28gYWN0dWFsbHkgeW91J3JlIHN1Z2dlc3RpbmcgdG8gc2F2ZSBh
bGwgdGhlIGNhbGxhYmNrIGNvbmZpZ3VyYXRpb25zIGluCj4gPiA+ID4gYW4gYXJyYXkgYW5kIGV2
YWx1YXRlIGN2cSBpbmRleCBhZnRlciBmZWF0dXJlIG5lZ290aWF0aW9uIGhhcyBiZWVuCj4gPiA+
ID4gY29tcGxldGVkLgo+ID4gPgo+ID4gPgo+ID4gPiBZZXMuCj4gPiA+Cj4gPiA+Cj4gPiA+ID4K
PiA+ID4gPiBJIHRoaW5rIHRoYXQgY291bGQgd29yay4gSSB3aWxsIGNvZGUgdGhpcyBhbmQgdXBk
YXRlLgo+ID4gPgo+ID4KPiA+IEl0IHdvcmtzIGZpbmUgd2hlbiBJIGFtIHdvcmtpbmcgd2l0aCB5
b3VyIHZlcnNpb24gb2YgcWVtdSB3aXRoIHN1cHBvcnQKPiA+IGZvciBtdWx0aSBxdWV1ZS4KPiA+
Cj4gPiBUaGUgcHJvYmxlbSBpcyB0aGF0IGl0IGlzIGJyb2tlbiBvbiBxZW11IHY2LjAuMC4gSWYg
SSByZWdpc3RlciBteSB2ZHBhCj4gPiBkZXZpY2Ugd2l0aCBtb3JlIHRoYW4gMiBkYXRhIHZpcnRx
dWV1ZXMsIHFlbXUgd29uJ3QgZXZlbiBjcmVhdGUgYQo+ID4gbmV0ZGV2aWNlIGluIHRoZSBWTS4K
ClFlbXUgc2hvdWxkIGhpZGUgTVEgZmVhdHVyZSBpbiB0aGlzIGNhc2UgYnV0IGxvb2tzIGxpa2Ug
aXQgZG9lc24ndC4KCldpbGwgaGF2ZSBhIGxvb2suCgo+ID4KPiA+IEkgYW0gbm90IHN1cmUgaG93
IHRvIGhhbmRsZSB0aGlzLiBJcyB0aGVyZSBzb21lIGtpbmQgb2YgaW5kaWNhdGlvbiBJIGNhbgo+
ID4gZ2V0IGFzIHRvIHRoZSB2ZXJzaW9uIG9mIHFlbXUgc28gSSBjYW4gYXZvaWQgdXNpbmcgbXVs
dGlxdWV1ZSBmb3IKPiA+IHZlcnNpb25zIEkga25vdyBhcmUgcHJvYmxlbWF0aWM/Cj4KPiBObyB2
ZXJzaW9ucyA7KSBUaGlzIGlzIHdoYXQgZmVhdHVyZSBiaXRzIGFyZSBmb3IgLi4uCgpZZXMuCgpT
byBkb2VzIGl0IHdvcmsgaWYgIm1xPW9mZiIgaXMgc3BlY2lmaWVkIGluIHRoZSBjb21tYW5kIGxp
bmU/CgpUaGFua3MKCgo+Cj4gPiA+Cj4gPiA+IFRoYW5rcy4KPiA+ID4KPiA+ID4KPiA+ID4gPgo+
ID4gPiA+ID4gaW4gbWx4NV92ZHBhX3NldF92cV9jYigpCj4gPiA+ID4gPgo+ID4gPiA+ID4gNCkg
aW4gdGhlIG1seDVfY3ZxX2tpY2tfaGFuZGxlcigpLCB3ZSBrbm93IHRoZSBmZWF0dXJlIGlzIG5l
Z290aWF0ZWQgYW5kIHdlCj4gPiA+ID4gPiBjYW4gdXNlIHRoZSBjb3JyZWN0IGluZGV4IHRoZXJl
Lgo+ID4gPiA+ID4KPiA+ID4gPiA+IEluIHRoZSBtZWFuIHRpbWUsIEkgd2lsbCBsb29rIGF0IFFl
bXUgY29kZSB0byBzZWUgaWYgd2UgY2FuIGd1YXJhbnRlZSB0aGF0Cj4gPiA+ID4gPiBzZXRfZmVh
dHVyZXMgaXMgY2FsbGVkIGJlZm9yZSBzZXRfdnFfY2FsbGJhY2suIChBdCBmaXJzdCBnbGFuY2Us
IGl0J3Mgbm90Cj4gPiA+ID4gPiB0cml2aWFsIGJ1dCBsZXQncyBzZWUpLgo+ID4gPiA+ID4KPiA+
ID4gPiA+IFRoYW5rcwo+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBBbmQgd2hp
bGUgd3JpdGluZyB0aGlzLCBJIHRoaW5rIHRoaXMgbG9naWMgZG9lcyBub3QgYmVsb2cgaW4gbWx4
NV92ZHBhCj4gPiA+ID4gPiA+ID4gPiBidXQgcHJvYmFibHkgaW4gdmRwYS5jCj4gPiA+ID4gPiA+
ID4gVGhlIHByb2JsZW0gaXMgdGhhdCB2ZHBhIHNob3VsZCBiZSB1bmF3YXJlIG9mIGEgc3BlY2lm
aWMgZGV2aWNlIHR5cGUuIEUuZwo+ID4gPiA+ID4gPiA+IHRoZSBhYm92ZSBpbmRpY2VzIG1heSB3
b3JrIG9ubHkgZm9yIHZpcnRpby1uZXQgYnV0IG5vdCBvdGhlci4KPiA+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+Cj4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
