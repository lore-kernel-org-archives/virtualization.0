Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 654B9C7EE25
	for <virtualization@archiver.kernel.org>; Tue, 16 May 2023 04:13:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D6CAF41AEF;
	Tue, 16 May 2023 04:13:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D6CAF41AEF
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RG4YLCfI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4YgvPI0ymNyP; Tue, 16 May 2023 04:13:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C75F641A48;
	Tue, 16 May 2023 04:13:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C75F641A48
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99566C0037;
	Tue, 16 May 2023 04:13:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBC2CC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 04:13:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 81E2A84134
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 04:13:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 81E2A84134
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RG4YLCfI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DNjBy0FcnkIy
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 04:13:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1E03E84133
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E03E84133
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 04:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684210382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p249AUCyOn+avTIqZrVK1ogk3k6y7lStqJYRaHHwRL8=;
 b=RG4YLCfIXwXM6kVoRmT02kJp/rAPC08Ybbh/jPJUP7xEt0bpS6IRDQOIj0HMc763BTbOsd
 C2BDh1Ud4UBLgpdex2bx/DxaDxDynn9Te4M+kE/gfrNcw7iYUKMU/aX4x7gHh5Y3xId4/g
 Nh9nM29xXBuycNxbwBS4iIW1Cow7hnE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-505aukaWPBy8_MgRP4My2w-1; Tue, 16 May 2023 00:13:01 -0400
X-MC-Unique: 505aukaWPBy8_MgRP4My2w-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-306311a2b99so5312102f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 21:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684210380; x=1686802380;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p249AUCyOn+avTIqZrVK1ogk3k6y7lStqJYRaHHwRL8=;
 b=Bcn2wDvuob8ByAFbiesDpTHJM82ye9tJUkrotLUiSWZxkhaP1GJbuaeDOcl1fYgZSA
 CjY7Ytx5aFgylWvaS60ayDsc3aBiXlqGQ7Kmoh4OFgG9jPrPAXxVw49qjPDkncHuhipv
 3hup1BGkoGvK+WR5fJR+MKMPmYT7TrW02dVK60Xv6lgmyOIa0q1Rn3f6nRBovuBPkKQe
 20e5A576uFvpAPZ6TBwKoSwNXooRO868rkokFyhMLImktiBPVpFYXrcN16IpF9XHMp/z
 9DsRYXgXJ7573vj1YePX4aopmdTpS2z+n95spsr91EnkDwV5o9dJnM9Z105vR99B99zL
 UW6A==
X-Gm-Message-State: AC+VfDyT/6SgN+raa1m68ncyxD6pxMcLL+Z0GE4+rXYI5aQBui78wUkx
 1DijOcLDeIzCi8HR1zbLkwzkQXgctDRGzDU2tbBMaBNA9d8Kpp9rG0titYLcGWxA+gvdGBwPpjI
 kz1FSGexI5gzPwzL2U1JUXWTrRQeKfOfKxk9dLdXN6A==
X-Received: by 2002:a5d:594e:0:b0:307:8691:1ea5 with SMTP id
 e14-20020a5d594e000000b0030786911ea5mr21650391wri.26.1684210380060; 
 Mon, 15 May 2023 21:13:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7H1AJI3NBhLEY2iVQia+EcKFbxTad+7L3OHQXq8IrXlYUpjX6KWFyz1nHm1Dqsau8LN35wbw==
X-Received: by 2002:a5d:594e:0:b0:307:8691:1ea5 with SMTP id
 e14-20020a5d594e000000b0030786911ea5mr21650380wri.26.1684210379747; 
 Mon, 15 May 2023 21:12:59 -0700 (PDT)
Received: from redhat.com ([2.52.26.5]) by smtp.gmail.com with ESMTPSA id
 i18-20020a5d5592000000b00307acec258esm1075667wrv.3.2023.05.15.21.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 May 2023 21:12:59 -0700 (PDT)
Date: Tue, 16 May 2023 00:12:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next V2 1/2] virtio-net: convert rx mode setting to
 use workqueue
Message-ID: <20230516000829-mutt-send-email-mst@kernel.org>
References: <20230413121525-mutt-send-email-mst@kernel.org>
 <CACGkMEunn1Z3n8yjVaWLqdV502yjaCBSAb_LO4KsB0nuxXmV8A@mail.gmail.com>
 <20230414031947-mutt-send-email-mst@kernel.org>
 <CACGkMEtutGn0CoJhoPHbzPuqoCLb4OCT6a_vB_WPV=MhwY0DXg@mail.gmail.com>
 <20230510012951-mutt-send-email-mst@kernel.org>
 <CACGkMEszPydzw_MOUOVJKBBW_8iYn66i_9OFvLDoZMH34hMx=w@mail.gmail.com>
 <20230515004422-mutt-send-email-mst@kernel.org>
 <CACGkMEv+Q2UoBarNOzKSrc3O=Wb2_73O2j9cZXFdAiLBm1qY-Q@mail.gmail.com>
 <20230515061455-mutt-send-email-mst@kernel.org>
 <CACGkMEt8QkK1PnTrRUjDbyJheBurdibr4--Es8P0Y9NZM659pQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEt8QkK1PnTrRUjDbyJheBurdibr4--Es8P0Y9NZM659pQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

T24gVHVlLCBNYXkgMTYsIDIwMjMgYXQgMTA6NDQ6NDVBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBNb24sIE1heSAxNSwgMjAyMyBhdCA2OjE34oCvUE0gTWljaGFlbCBTLiBUc2lya2lu
IDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gTW9uLCBNYXkgMTUsIDIwMjMgYXQg
MDE6MTM6MzNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gT24gTW9uLCBNYXkgMTUs
IDIwMjMgYXQgMTI6NDXigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3
cm90ZToKPiA+ID4gPgo+ID4gPiA+IE9uIE1vbiwgTWF5IDE1LCAyMDIzIGF0IDA5OjA1OjU0QU0g
KzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiBPbiBXZWQsIE1heSAxMCwgMjAyMyBh
dCAxOjMz4oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+IE9uIE1vbiwgQXByIDE3LCAyMDIzIGF0IDExOjQwOjU4QU0g
KzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gT24gRnJpLCBBcHIgMTQsIDIw
MjMgYXQgMzoyMeKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3Rl
Ogo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IE9uIEZyaSwgQXByIDE0LCAyMDIzIGF0
IDAxOjA0OjE1UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+IEZv
cmdldCB0byBjYyBuZXRkZXYsIGFkZGluZy4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiA+ID4gT24gRnJpLCBBcHIgMTQsIDIwMjMgYXQgMTI6MjXigK9BTSBNaWNoYWVsIFMuIFRzaXJr
aW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+ID4gPiA+IE9uIFRodSwgQXByIDEzLCAyMDIzIGF0IDAyOjQwOjI2UE0gKzA4MDAsIEphc29u
IFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBUaGlzIHBhdGNoIGNvbnZlcnQgcngg
bW9kZSBzZXR0aW5nIHRvIGJlIGRvbmUgaW4gYSB3b3JrcXVldWUsIHRoaXMgaXMKPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IGEgbXVzdCBmb3IgYWxsb3cgdG8gc2xlZXAgd2hlbiB3YWl0aW5nIGZvciB0
aGUgY3ZxIGNvbW1hbmQgdG8KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHJlc3BvbnNlIHNpbmNlIGN1
cnJlbnQgY29kZSBpcyBleGVjdXRlZCB1bmRlciBhZGRyIHNwaW4gbG9jay4KPiA+ID4gPiA+ID4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5n
IDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4g
PiA+ID4gSSBkb24ndCBsaWtlIHRoaXMgZnJhbmtseS4gVGhpcyBtZWFucyB0aGF0IHNldHRpbmcg
UlggbW9kZSB3aGljaCB3b3VsZAo+ID4gPiA+ID4gPiA+ID4gPiA+IHByZXZpb3VzbHkgYmUgcmVs
aWFibGUsIG5vdyBiZWNvbWVzIHVucmVsaWFibGUuCj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+ID4gPiA+IEl0IGlzICJ1bnJlbGlhYmxlIiBieSBkZXNpZ246Cj4gPiA+ID4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+ID4gPiA+ICAgICAgIHZvaWQgICAgICAgICAgICAgICAgICAgICgqbmRvX3Nl
dF9yeF9tb2RlKShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KTsKPiA+ID4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiA+ID4gPiAtIGZpcnN0IG9mIGFsbCBjb25maWd1cmF0aW9uIGlzIG5vIGxvbmdl
ciBpbW1lZGlhdGUKPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gSXMgaW1tZWRp
YXRlIGEgaGFyZCByZXF1aXJlbWVudD8gSSBjYW4gc2VlIGEgd29ya3F1ZXVlIGlzIHVzZWQgYXQg
bGVhc3Q6Cj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IG1seDVlLCBpcG9pYiwg
ZWZ4LCAuLi4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiAgIGFuZCB0aGVy
ZSBpcyBubyB3YXkgZm9yIGRyaXZlciB0byBmaW5kIG91dCB3aGVuCj4gPiA+ID4gPiA+ID4gPiA+
ID4gICBpdCBhY3R1YWxseSB0b29rIGVmZmVjdAo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+ID4gPiBCdXQgd2Uga25vdyByeCBtb2RlIGlzIGJlc3QgZWZmb3J0IGUuZyBpdCBkb2Vzbid0
IHN1cHBvcnQgdmhvc3QgYW5kIHdlCj4gPiA+ID4gPiA+ID4gPiA+IHN1cnZpdmUgZnJvbSB0aGlz
IGZvciB5ZWFycy4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiAtIHNlY29u
ZCwgaWYgZGV2aWNlIGZhaWxzIGNvbW1hbmQsIHRoaXMgaXMgYWxzbyBub3QKPiA+ID4gPiA+ID4g
PiA+ID4gPiAgIHByb3BhZ2F0ZWQgdG8gZHJpdmVyLCBhZ2FpbiBubyB3YXkgZm9yIGRyaXZlciB0
byBmaW5kIG91dAo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gVkRVU0Ug
bmVlZHMgdG8gYmUgZml4ZWQgdG8gZG8gdHJpY2tzIHRvIGZpeCB0aGlzCj4gPiA+ID4gPiA+ID4g
PiA+ID4gd2l0aG91dCBicmVha2luZyBub3JtYWwgZHJpdmVycy4KPiA+ID4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiA+ID4gSXQncyBub3Qgc3BlY2lmaWMgdG8gVkRVU0UuIEZvciBleGFtcGxl
LCB3aGVuIHVzaW5nIHZpcnRpby1uZXQgaW4gdGhlCj4gPiA+ID4gPiA+ID4gPiA+IFVQIGVudmly
b25tZW50IHdpdGggYW55IHNvZnR3YXJlIGN2cSAobGlrZSBtbHg1IHZpYSB2RFBBIG9yIGNtYQo+
ID4gPiA+ID4gPiA+ID4gPiB0cmFuc3BvcnQpLgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+ID4gPiBUaGFua3MKPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBIbW0uIENhbiB3
ZSBkaWZmZXJlbnRpYXRlIGJldHdlZW4gdGhlc2UgdXNlLWNhc2VzPwo+ID4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+ID4gSXQgZG9lc24ndCBsb29rIGVhc3kgc2luY2Ugd2UgYXJlIGRyaXZlcnMgZm9y
IHZpcnRpbyBidXMuIFVuZGVybGF5ZXIKPiA+ID4gPiA+ID4gPiBkZXRhaWxzIHdlcmUgaGlkZGVu
IGZyb20gdmlydGlvLW5ldC4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IE9yIGRvIHlvdSBo
YXZlIGFueSBpZGVhcyBvbiB0aGlzPwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gVGhhbmtz
Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IEkgZG9uJ3Qga25vdywgcGFzcyBzb21lIGtpbmQgb2Yg
ZmxhZyBpbiBzdHJ1Y3QgdmlydHF1ZXVlPwo+ID4gPiA+ID4gPiAgICAgICAgICJib29sIHNsb3c7
IC8qIFRoaXMgdnEgY2FuIGJlIHZlcnkgc2xvdyBzb21ldGltZXMuIERvbid0IHdhaXQgZm9yIGl0
ISAqLyIKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+
ID4gPiA+IFNvIGlmIGl0J3Mgc2xvdywgc2xlZXAsIG90aGVyd2lzZSBwb2xsPwo+ID4gPiA+ID4K
PiA+ID4gPiA+IEkgZmVlbCBzZXR0aW5nIHRoaXMgZmxhZyBtaWdodCBiZSB0cmlja3ksIHNpbmNl
IHRoZSBkcml2ZXIgZG9lc24ndAo+ID4gPiA+ID4ga25vdyB3aGV0aGVyIG9yIG5vdCBpdCdzIHJl
YWxseSBzbG93LiBFLmcgc21hcnROSUMgdmVuZG9yIG1heSBhbGxvdwo+ID4gPiA+ID4gdmlydGlv
LW5ldCBlbXVsYXRpb24gb3ZlciBQQ0kuCj4gPiA+ID4gPgo+ID4gPiA+ID4gVGhhbmtzCj4gPiA+
ID4KPiA+ID4gPiBkcml2ZXIgd2lsbCBoYXZlIHRoZSBjaG9pY2UsIGRlcGVuZGluZyBvbiB3aGV0
aGVyCj4gPiA+ID4gdnEgaXMgZGV0ZXJtaW5pc3RpYyBvciBub3QuCj4gPiA+Cj4gPiA+IE9rLCBi
dXQgdGhlIHByb2JsZW0gaXMsIHN1Y2ggYm9vbGVhbnMgYXJlIG9ubHkgdXNlZnVsIGZvciB2aXJ0
aW8gcmluZwo+ID4gPiBjb2Rlcy4gQnV0IGluIHRoaXMgY2FzZSwgdmlydGlvLW5ldCBrbm93cyB3
aGF0IHRvIGRvIGZvciBjdnEuIFNvIEknbQo+ID4gPiBub3Qgc3VyZSB3aG8gdGhlIHVzZXIgaXMu
Cj4gPiA+Cj4gPiA+IFRoYW5rcwo+ID4KPiA+IENpcmNsaW5nIGJhY2ssIHdoYXQgZXhhY3RseSBk
b2VzIHRoZSBhcmNoaXRlY3R1cmUgeW91IGFyZSB0cnlpbmcKPiA+IHRvIGZpeCBsb29rIGxpa2U/
IFdobyBpcyBnb2luZyB0byBpbnRyb2R1Y2UgdW5ib3VuZGVkIGxhdGVuY3k/Cj4gPiBUaGUgaHlw
ZXJ2aXNvcj8KPiAKPiBIeXBlcnZpc29yIGlzIG9uZSBvZiB0aGUgcG9zc2libGUgcmVhc29uLCB3
ZSBoYXZlIG1hbnkgbW9yZToKPiAKPiBIYXJkd2FyZSBkZXZpY2UgdGhhdCBwcm92aWRlcyB2aXJ0
aW8tcGNpIGVtdWxhdGlvbi4KPiBVc2Vyc3BhY2UgZGV2aWNlcyBsaWtlIFZEVVNFLgoKU28gbGV0
J3Mgc3RhcnQgYnkgYWRkcmVzc2luZyBWRFVTRSBtYXliZT8KCj4gPiBJZiBzbyBkbyB3ZSBub3Qg
bWF5YmUgd2FudCBhIG5ldyBmZWF0dXJlIGJpdAo+ID4gdGhhdCBkb2N1bWVudHMgdGhpcz8gSHlw
ZXJ2aXNvciB0aGVuIGNhbiBkZXRlY3Qgb2xkIGd1ZXN0cwo+ID4gdGhhdCBzcGluIGFuZCBkZWNp
ZGUgd2hhdCB0byBkbywgZS5nLiBwcmlvcml0aXNlIGN2cSBtb3JlLAo+ID4gb3IgZmFpbCBGRUFU
VVJFU19PSy4KPiAKPiBXZSBzdWZmZXIgZnJvbSB0aGlzIGZvciBiYXJlIG1ldGFsIGFzIHdlbGwu
Cj4gCj4gQnV0IGEgcXVlc3Rpb24gaXMgd2hhdCdzIHdyb25nIHdpdGggdGhlIGFwcHJvYWNoIHRo
YXQgaXMgdXNlZCBpbiB0aGlzCj4gcGF0Y2g/IEkndmUgYW5zd2VyZWQgdGhhdCBzZXRfcnhfbW9k
ZSBpcyBub3QgcmVsaWFibGUsIHNvIGl0IHNob3VsZCBiZQo+IGZpbmUgdG8gdXNlIHdvcmtxdWV1
ZS4gRXhjZXB0IGZvciB0aGlzLCBhbnkgb3RoZXIgdGhpbmcgdGhhdCB3b3JyaWVzCj4geW91Pwo+
IAo+IFRoYW5rcwoKSXQncyBub3QgcmVsaWFibGUgZm9yIG90aGVyIGRyaXZlcnMgYnV0IGhhcyBi
ZWVuIHJlbGlhYmxlIGZvciB2aXJ0aW8uCkkgd29ycnkgc29tZSBzb2Z0d2FyZSByZWxpZWQgb24g
dGhpcy4KWW91IGFyZSBtYWtpbmcgZ29vZCBwb2ludHMgdGhvdWdoIC4uLiBjb3VsZCB3ZSBnZXQg
c29tZQptYWludGFpbmVyJ3MgZmVlZGJhY2sgb24gdGhpcz8KCj4gPgo+ID4gPiA+Cj4gPiA+ID4K
PiA+ID4gPiA+ID4gLS0KPiA+ID4gPiA+ID4gTVNUCj4gPiA+ID4gPiA+Cj4gPiA+ID4KPiA+Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
