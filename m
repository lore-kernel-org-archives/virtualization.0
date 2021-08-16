Return-Path: <SRS0=J2aX=NH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F334C4338F
	for <virtualization@archiver.kernel.org>; Mon, 16 Aug 2021 19:37:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D39A960E76
	for <virtualization@archiver.kernel.org>; Mon, 16 Aug 2021 19:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D39A960E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 90E6840143;
	Mon, 16 Aug 2021 19:37:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JPo99sdMyF_g; Mon, 16 Aug 2021 19:37:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 116BB4010D;
	Mon, 16 Aug 2021 19:37:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7392C001A;
	Mon, 16 Aug 2021 19:37:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50D41C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 19:37:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3FBE340291
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 19:37:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KurVz_5Ch5m7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 19:37:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 520A040289
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 19:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629142619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sYde9zhS+qnVve1R6X4YcF2zG1MGD2rghZQ99TBGFfA=;
 b=bdv0XAB1GHSbjRSWitLBVjGas+lD+e4rJpi1qNbpdGGy3I2ACaOcotSqdZr+cKWQ3Wcptf
 79SameHI5L0TW/kPFAHMnCPx6pyYTSu2h37jLyd+AYqHTCFp6MXrogk+EL4kiP55cKXyZN
 lnKxTCoPb0ZWEoidAHvDCJMOu4vFyWc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-yq9ecIluONepyOIexdcKCQ-1; Mon, 16 Aug 2021 15:36:58 -0400
X-MC-Unique: yq9ecIluONepyOIexdcKCQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 y39-20020a50bb2a0000b02903bc05daccbaso9369196ede.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 12:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=sYde9zhS+qnVve1R6X4YcF2zG1MGD2rghZQ99TBGFfA=;
 b=etb8NfN1pUvCW779zFPPlpff+6TOmtXvcgryHSwG1c1H4jjclqXvRlrXVrZwKFnBtL
 oxxGl4azJ308/rMCbNGNDn+V/nPJ4+WJCEpyvet8tnze2BIwoZNLCAc9YqfFCgJz7yWt
 p3C8wEDRxaCfKBiccgBayIEruZ8U2OUjqHiFCBdlUNmWotPy9YPwaCso9C8RxifdCPbV
 k4vAimw7752jOeqAb7BewO8M61rlKECeXtZ27kX4T7mwkpQpUxr/Kz1HZapOMb0P1Gmu
 TTvSJCNyVgu3HX2MPYIqQWeYWwdI79Hhzl0zWkjArUHw+apgS/4Ne28/WdbSyc4UZYm8
 SU0g==
X-Gm-Message-State: AOAM530/JpmuN0QCN2nrIpHoILxY9cctKQC7xH1aUdd2K9FolQzc6iR6
 oNHeMGH4HA2FYM0nMsTlG5wn7BIo6dQGQeMuTi0gTGKFR/8/1cgoqN2QtJYiDKZdCCMkYbhqlZs
 K5JsU6UlthZiYYBnWrdVz063YvvKhpPgX5/lpODTf1A==
X-Received: by 2002:a05:6402:1385:: with SMTP id
 b5mr226840edv.276.1629142616918; 
 Mon, 16 Aug 2021 12:36:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzE5jxhhVTFH73kgccTrNGXvafCHMkPSlyLKtFW6tdb5ZNPL6GpgAaSpXcBfBzkvInQ22gwJA==
X-Received: by 2002:a05:6402:1385:: with SMTP id
 b5mr226821edv.276.1629142616718; 
 Mon, 16 Aug 2021 12:36:56 -0700 (PDT)
Received: from redhat.com ([2.55.150.133])
 by smtp.gmail.com with ESMTPSA id m18sm42846edr.18.2021.08.16.12.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Aug 2021 12:36:55 -0700 (PDT)
Date: Mon, 16 Aug 2021 15:36:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [Patch v1 3/3] vdpa/mlx5: Add multiqueue support
Message-ID: <20210816153630-mutt-send-email-mst@kernel.org>
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
MIME-Version: 1.0
In-Reply-To: <20210816165659.GA51703@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: eperezma <eperezma@redhat.com>,
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

T24gTW9uLCBBdWcgMTYsIDIwMjEgYXQgMDc6NTY6NTlQTSArMDMwMCwgRWxpIENvaGVuIHdyb3Rl
Ogo+IE9uIE1vbiwgQXVnIDE2LCAyMDIxIGF0IDAxOjU4OjA2UE0gKzA4MDAsIEphc29uIFdhbmcg
d3JvdGU6Cj4gPiAKPiA+IOWcqCAyMDIxLzgvMTYg5LiL5Y2IMTo0NywgRWxpIENvaGVuIOWGmemB
kzoKPiA+ID4gT24gTW9uLCBBdWcgMTYsIDIwMjEgYXQgMTI6MTY6MTRQTSArMDgwMCwgSmFzb24g
V2FuZyB3cm90ZToKPiA+ID4gPiDlnKggMjAyMS84LzEyIOS4i+WNiDU6NTAsIEVsaSBDb2hlbiDl
hpnpgZM6Cj4gPiA+ID4gPiBPbiBUaHUsIEF1ZyAxMiwgMjAyMSBhdCAwMzowNDozNVBNICswODAw
LCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiDlnKggMjAyMS84LzEyIOS4i+WNiDM6MDEs
IEVsaSBDb2hlbiDlhpnpgZM6Cj4gPiA+ID4gPiA+ID4gT24gVGh1LCBBdWcgMTIsIDIwMjEgYXQg
MDI6NDc6MDZQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gPiA+IE9uIFRo
dSwgQXVnIDEyLCAyMDIxIGF0IDEyOjU1IFBNIEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPiB3
cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gT24gVGh1LCBBdWcgMTIsIDIwMjEgYXQgMTE6MTk6MTlB
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiDlnKggMjAyMS84
LzExIOS4i+WNiDc6MDQsIEVsaSBDb2hlbiDlhpnpgZM6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBP
biBXZWQsIEF1ZyAxMSwgMjAyMSBhdCAwNDozNzo0NFBNICswODAwLCBKYXNvbiBXYW5nIHdyb3Rl
Ogo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiDlnKggMjAyMS84LzExIOS4i+WNiDM6NTMsIEVsaSBD
b2hlbiDlhpnpgZM6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBPbmUgdGhpbmcgbmVlZCB0
byBzb2x2ZSBmb3IgbXEgaXMgdGhhdCB0aGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAK
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiArc3RhdGljIHUxNiBjdHJsX3ZxX2lkeChzdHJ1Y3QgIG1seDVfdmRwYV9kZXYgKm12ZGV2KQo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiArewo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiArICAgICByZXR1cm4gMiAqICBtbHg1X3ZkcGFfbWF4X3FwcyhtdmRldi0+bWF4X3Zxcyk7
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICt9Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiBXZSBzaG91bGQgaGFuZGxlIHRoZSBjYXNlIHdoZW4gTVEgaXMgc3VwcG9ydGVkIGJ5IHRo
ZSBkZXZpY2UgYnV0IG5vdCB0aGUKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGRyaXZlci4K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
RS5nIGluIHRoZSBjYXNlIHdoZW4gd2UgaGF2ZSAyIHF1ZXVlIHBhaXJzOgo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBXaGVuIE1RIGlzIGVu
YWJsZWQsIGN2cSBpcyBxdWV1ZSA0Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IFdoZW4gTVEgaXMgbm90IGVuYWJsZWQsIGN2cSBpcyBxdWV1
ZSAyCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiBUaGVyZSdzIHNvbWUgaXNzdWUgd2l0aCB0aGlzLiBJIGdldCBjYWxsYmFja3MgdGFyZ2V0aW5n
IHNwZWNpZmljCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gdmlydHF1ZXVlcyBiZWZvcmUgZmVh
dHVyZXMgbmVnb3RpYXRpb24gaGFzIGJlZW4gY29tcGxldGVkLgo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFNwZWNpZmljYWxseSwgSSBnZXQgc2V0
X3ZxX2NiKCkgY2FsbHMuIEF0IHRoaXMgcG9pbnQgSSBtdXN0IGtub3cgdGhlCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gY29udHJvbCB2cSBpbmRleC4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
U28gSSB0aGluayB3ZSBuZWVkIGRvIGJvdGg6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IAo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiAxKSBBdCBvbmUgaGFuZCwgaXQncyBhIGJ1ZyBmb3IgdGhlIHVz
ZXJzcGFjZSB0byB1c2UgdnFfaW5kZXggYmVmb3JlIGZlYXR1cmUKPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gaXMgbmVnb3RpYXRlZAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gKGxvb2tzIGxpa2UgYSBidWcgaW4gbXkgY3ZxIHNlcmllcyB0aGF0IHdpbGwg
Y2FsbCBTRVRfVlJJTkdfQ0FMTCBiZWZvcmUKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gZmVhdHVy
ZSBpcyBuZWdvdGlhdGUsIHdoaWNoIEkgd2lsbCBsb29rKS4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IDIpIEF0IHRoZSBvdGhlciBoYW5kLCB0aGUgZHJp
dmVyIHNob3VsZCBiZSBhYmxlIHRvIGRlYWwgd2l0aCB0aGF0Cj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQWxsIEkgY2FuIGRvIGlzIGRyb3AgY2FsbGJhY2tz
IGZvciBWUXMgYmVmb3JlIGZlYXR1cmVzIG5lZ290YXRpb24gaGFzCj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiBiZWVuIGNvbXBsZXRlZC4KPiA+ID4gPiA+ID4gPiA+ID4gPiBPciBqdXN0IGxlYXZlIHF1
ZXVlIGluZGV4IDAsIDEgd29yay4KPiA+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+
ID4gPiBTaW5jZSBpdCBpcyBub3QgZXhwZWN0ZWQgdG8gYmUgY2hhbmdlZC4KPiA+ID4gPiA+ID4g
PiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gUmlnaHQsIHdpbGwgZG8uCj4gPiA+ID4gPiA+ID4g
PiA+IAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEkgdGhpbmsgdGhlIENWUSBpbmRleCBtdXN0
IG5vdCBkZXBlbmQgb24gdGhlIG5lZ290aWF0ZWQgZmVhdHVyZXMgYnV0Cj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gcmF0aGVyIGRlcGVuZCBvZiB0aGUgdmFsdWUgdGhlIGRldmljZSBkcml2ZXIg
cHJvdmlkZXMgaW4gdGhlIGNhbGwgdG8KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBfdmRwYV9y
ZWdpc3Rlcl9kZXZpY2UoKS4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQXQgdGhlIHZpcnRpbyBs
ZXZlbCwgaXQncyB0b28gbGF0ZSB0byBjaGFuZ2UgdGhhdCBhbmQgaXQgYnJlYWtzIHRoZSBiYWNr
d2FyZAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBjb21wYXRpYmlsaXR5Lgo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQnV0IGF0IHRoZSB2RFBBIGxldmVs
LCB0aGUgdW5kZXIgbGF5ZXIgZGV2aWNlIGNhbiBtYXAgdmlydGlvIGN2cSB0byBhbnkgb2YKPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gaXQncyB2aXJ0cXVldWUuCj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBFLmcgbWFwIGN2cSAoaW5kZXggMikgdG8gbWx4
NSBjdnEgKHRoZSBsYXN0KS4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiBJIGFtIG5vdCBmb2xsb3dpbmcgeW91IGhlcmUuIEkgc3RpbGwgZG9uJ3Qga25vdyB3
aGF0IGluZGV4IGlzIGN2cS4KPiA+ID4gPiA+ID4gPiA+ID4gPiBSaWdodCwgd2Ugc3RpbGwgbmVl
ZCB0byB3YWl0IGZvciB0aGUgZmVhdHVyZSBiZWluZyBuZWdvdGlhdGVkIGluIG9yZGVyIHRvCj4g
PiA+ID4gPiA+ID4gPiA+ID4gcHJvY2VlZC4KPiA+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+
ID4gPiA+ID4gU28gdG8gc3VtbWFyaXNlLCBiZWZvcmUgZmVhdHVyZSBuZWdvdGlhdGlvbiBjb21w
bGV0ZSwgSSBhY2NlcHQgY2FsbHMKPiA+ID4gPiA+ID4gPiA+ID4gcmVmZXJyaW5nIHRvIFZRcyBv
bmx5IGZvciBpbmRpY2VzIDAgYW5kIDEuCj4gPiA+ID4gPiA+ID4gPiA+IEFmdGVyIGZlYXR1cmUg
bmVnb3RpYXRpb24gY29tcGxldGUgSSBrbm93IENWUSBpbmRleCBhbmQgd2lsbCBhY2NlcHQKPiA+
ID4gPiA+ID4gPiA+ID4gaW5kaWNlcyAwIHRvIGN2cSBpbmRleC4KPiA+ID4gPiA+ID4gPiA+IEkg
ZG9uJ3QgZ2V0IHRoaXMgImFjY2VwdCBpbmRpY2VzIDAgdG8gY3ZxIGluZGV4Ii4KPiA+ID4gPiA+
ID4gPiBXaGF0IEkgbWVhbnQgdG8gc2F5IGlzIHRoYXQgdGhlcmUgYXJlIHNldmVyYWwgY2FsbGJh
Y2tzIHRoYXQgcmVmZXIgdG8KPiA+ID4gPiA+ID4gPiBzcGVjaWZpYyB2aXJ0cXVldWVzLCBlLmcu
IHNldF92cV9hZGRyZXNzKCksIHNldF92cV9udW0oKSBldGMuIFRoZXkgYWxsCj4gPiA+ID4gPiA+
ID4gYWNjZXB0IHZpcnRxdWV1ZSBpbmRleCBhcyBhbiBhcmd1bWVudC4KPiA+ID4gPiA+ID4gPiAK
PiA+ID4gPiA+ID4gPiBXaGF0IHdlIHdhbnQgdG8gZG8gaXMgdmVyaWZ5IHdoZWF0aGVyIHRoZSBp
bmRleCBwcm92aWRlZCBpcyB2YWxpZCBvcgo+ID4gPiA+ID4gPiA+IG5vdC4gSWYgaXQgaXMgbm90
IHZhbGlkLCBlaXRoZXIgcmV0dXJuIGVycm9yIChpZiB0aGUgY2FsbGJhY2sgY2FuIHJldHVybgo+
ID4gPiA+ID4gPiA+IGEgdmFsdWUpIG9yIGp1c3QgYXZvaWQgcHJvY2Vzc2luZyBpdC4gSWYgdGhl
IGluZGV4IGlzIHZhbGlkIHRoZW4gd2UKPiA+ID4gPiA+ID4gPiBwcm9jZXNzIGl0IG5vcm1hbGx5
Lgo+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+IE5vdyB3ZSBuZWVkIHRvIGRlY2lkZSB3aGlj
aCBpbmRleCBpcyB2YWxpZCBvciBub3QuIFdlIG5lZWQgc29tZXRoaW5nCj4gPiA+ID4gPiA+ID4g
bGlrZSB0aGlzIHRvIGlkZW50aWZpeSB2YWxpZCBpbmRleGVzIHJhbmdlOgo+ID4gPiA+ID4gPiA+
IAo+ID4gPiA+ID4gPiA+IENWUSBjbGVhcjogMCBhbmQgMQo+ID4gPiA+ID4gPiA+IENWUSBzZXQs
IE1RIGNsZWFyOiAwLCAxIGFuZCAyIChmb3IgQ1ZRKS4KPiA+ID4gPiA+ID4gPiBDVlEgc2V0LCBN
USBzZXQ6IDAuLm52cSB3aGVyZSBudnEgaXMgd2hhdGV2ZXIgcHJvdmlkZWQgdG8KPiA+ID4gPiA+
ID4gPiBfdmRwYV9yZWdpc3Rlcl9kZXZpY2UoKQo+ID4gPiA+ID4gPiBZZXMuCj4gPiA+ID4gPiA+
IAo+ID4gPiA+ID4gVW5mb3J0dW5hdGVseSBpdCBkb2VzIG5vdCB3b3JrLgo+ID4gPiA+ID4gc2V0
X3ZxX2NiKCkgZm9yIGFsbCB0aGUgbXVsdGlxdWV1ZXMgaXMgY2FsbGVkIGJlb2ZyZSBmZWF0dXJl
Cj4gPiA+ID4gPiBuZWdvdGlhdGlvbi4gSWYgSSBhcHBseSB0aGUgYWJvdmUgbG9naWMsIEkgd2ls
bCBsb3NlIHRoZXNlIHNldHRpbmdzLgo+ID4gPiA+ID4gCj4gPiA+ID4gPiBJIGNhbiBtYWtlIGFu
IGV4Y2VwdGlvbiBmb3Igc2V0X3ZxX2NiKCksIHNhdmUgY2FsbGJhY2tzIGFuZCByZXN0b3JlCj4g
PiA+ID4gPiB0aGVtIGFmdGVyd2FyZHMuIFRoaXMgbG9va3MgdG9vIGNvbnZvbHV0ZWQgYW5kIG1h
eWJlIHdlIHNob3VsZCBzZWVrCj4gPiA+ID4gPiBhbm90aGVyIHNvbHV0aW9uLgo+ID4gPiA+IAo+
ID4gPiA+IEkgYWdyZWUuCj4gPiA+ID4gCj4gPiA+ID4gCj4gPiA+ID4gPiBMZXQgbWUga25vdyB3
aGF0IHlvdSB0aGluay4KPiA+ID4gPiAKPiA+ID4gPiBSZXRoaW5rIGFib3V0IHRoaXMgaXNzdWUu
IEl0IGxvb2tzIHRvIHRoZSBvbmx5IGlzc3VlIHdlIGZhY2UgaXMgdGhlCj4gPiA+ID4gc2V0X3Zx
X2NiKCkuCj4gPiA+ID4gCj4gPiA+ID4gV2l0aCB0aGUgYXNzdW1wdGlvbiB0aGF0IHRoZSB1c2Vy
c3BhY2UgY2FuIHVzZSB0aGUgaW5kZXggY29ycmVjdGx5IChldmVuCj4gPiA+ID4gYmVmb3JlIHNl
dF9mZWF0dXJlcykuIEkgd29uZGVyIHRoZSBmb2xsb3dpbmcgd29ya3MuCj4gPiA+ID4gCj4gPiA+
ID4gSW5zdGVhZCBvZiBjaGVja2luZyB3aGV0aGVyIHRoZSBpbmRleCBpcyBjdnEgaW4gc2V0X3Zx
X2NiKCkgaG93IGFib3V0Ogo+ID4gPiA+IAo+ID4gPiA+IDEpIGRlY291cGxlIGV2ZW50X2NiIG91
dCBvZiBtbHg1X3ZkcGFfdmlydHF1ZXVlIGFuZCBtbHg1X2Nvbmdyb192cQo+ID4gPiA+IDIpIGhh
dmUgYSBkZWRpY2F0ZWQgZXZlbnRfY2IgYXJyYXkgaW4gbWx4NV92ZHBhX25ldAo+ID4gPiA+IDMp
IHRoZW4gd2UgY2FuIGRvCj4gPiA+ID4gCj4gPiA+ID4gbmRldi0+ZXZlbnRfY2JzW2luZGV4XSA9
ICpjYjsKPiA+ID4gPiAKPiA+ID4gU28gYWN0dWFsbHkgeW91J3JlIHN1Z2dlc3RpbmcgdG8gc2F2
ZSBhbGwgdGhlIGNhbGxhYmNrIGNvbmZpZ3VyYXRpb25zIGluCj4gPiA+IGFuIGFycmF5IGFuZCBl
dmFsdWF0ZSBjdnEgaW5kZXggYWZ0ZXIgZmVhdHVyZSBuZWdvdGlhdGlvbiBoYXMgYmVlbgo+ID4g
PiBjb21wbGV0ZWQuCj4gPiAKPiA+IAo+ID4gWWVzLgo+ID4gCj4gPiAKPiA+ID4gCj4gPiA+IEkg
dGhpbmsgdGhhdCBjb3VsZCB3b3JrLiBJIHdpbGwgY29kZSB0aGlzIGFuZCB1cGRhdGUuCj4gPiAK
PiAKPiBJdCB3b3JrcyBmaW5lIHdoZW4gSSBhbSB3b3JraW5nIHdpdGggeW91ciB2ZXJzaW9uIG9m
IHFlbXUgd2l0aCBzdXBwb3J0Cj4gZm9yIG11bHRpIHF1ZXVlLgo+IAo+IFRoZSBwcm9ibGVtIGlz
IHRoYXQgaXQgaXMgYnJva2VuIG9uIHFlbXUgdjYuMC4wLiBJZiBJIHJlZ2lzdGVyIG15IHZkcGEK
PiBkZXZpY2Ugd2l0aCBtb3JlIHRoYW4gMiBkYXRhIHZpcnRxdWV1ZXMsIHFlbXUgd29uJ3QgZXZl
biBjcmVhdGUgYQo+IG5ldGRldmljZSBpbiB0aGUgVk0uCj4gCj4gSSBhbSBub3Qgc3VyZSBob3cg
dG8gaGFuZGxlIHRoaXMuIElzIHRoZXJlIHNvbWUga2luZCBvZiBpbmRpY2F0aW9uIEkgY2FuCj4g
Z2V0IGFzIHRvIHRoZSB2ZXJzaW9uIG9mIHFlbXUgc28gSSBjYW4gYXZvaWQgdXNpbmcgbXVsdGlx
dWV1ZSBmb3IKPiB2ZXJzaW9ucyBJIGtub3cgYXJlIHByb2JsZW1hdGljPwoKTm8gdmVyc2lvbnMg
OykgVGhpcyBpcyB3aGF0IGZlYXR1cmUgYml0cyBhcmUgZm9yIC4uLgoKPiA+IAo+ID4gVGhhbmtz
Lgo+ID4gCj4gPiAKPiA+ID4gCj4gPiA+ID4gaW4gbWx4NV92ZHBhX3NldF92cV9jYigpCj4gPiA+
ID4gCj4gPiA+ID4gNCkgaW4gdGhlIG1seDVfY3ZxX2tpY2tfaGFuZGxlcigpLCB3ZSBrbm93IHRo
ZSBmZWF0dXJlIGlzIG5lZ290aWF0ZWQgYW5kIHdlCj4gPiA+ID4gY2FuIHVzZSB0aGUgY29ycmVj
dCBpbmRleCB0aGVyZS4KPiA+ID4gPiAKPiA+ID4gPiBJbiB0aGUgbWVhbiB0aW1lLCBJIHdpbGwg
bG9vayBhdCBRZW11IGNvZGUgdG8gc2VlIGlmIHdlIGNhbiBndWFyYW50ZWUgdGhhdAo+ID4gPiA+
IHNldF9mZWF0dXJlcyBpcyBjYWxsZWQgYmVmb3JlIHNldF92cV9jYWxsYmFjay4gKEF0IGZpcnN0
IGdsYW5jZSwgaXQncyBub3QKPiA+ID4gPiB0cml2aWFsIGJ1dCBsZXQncyBzZWUpLgo+ID4gPiA+
IAo+ID4gPiA+IFRoYW5rcwo+ID4gPiA+IAo+ID4gPiA+IAo+ID4gPiA+ID4gPiA+IEFuZCB3aGls
ZSB3cml0aW5nIHRoaXMsIEkgdGhpbmsgdGhpcyBsb2dpYyBkb2VzIG5vdCBiZWxvZyBpbiBtbHg1
X3ZkcGEKPiA+ID4gPiA+ID4gPiBidXQgcHJvYmFibHkgaW4gdmRwYS5jCj4gPiA+ID4gPiA+IFRo
ZSBwcm9ibGVtIGlzIHRoYXQgdmRwYSBzaG91bGQgYmUgdW5hd2FyZSBvZiBhIHNwZWNpZmljIGRl
dmljZSB0eXBlLiBFLmcKPiA+ID4gPiA+ID4gdGhlIGFib3ZlIGluZGljZXMgbWF5IHdvcmsgb25s
eSBmb3IgdmlydGlvLW5ldCBidXQgbm90IG90aGVyLgo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4g
VGhhbmtzCj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiAJCj4gPiA+ID4g
PiA+ID4gPiBUaGFua3MKPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiA+IFRoYW5r
cwo+ID4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+IAo+ID4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
