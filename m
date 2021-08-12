Return-Path: <SRS0=F+q/=ND=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B778DC4338F
	for <virtualization@archiver.kernel.org>; Thu, 12 Aug 2021 06:47:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B0B36101E
	for <virtualization@archiver.kernel.org>; Thu, 12 Aug 2021 06:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4B0B36101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C67140642;
	Thu, 12 Aug 2021 06:47:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id avWeXbEMTDW1; Thu, 12 Aug 2021 06:47:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 92A5B405EC;
	Thu, 12 Aug 2021 06:47:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AF53C0010;
	Thu, 12 Aug 2021 06:47:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BA7CC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 06:47:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 35E2660890
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 06:47:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c4wacHxgXhmA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 06:47:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 653F060760
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 06:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628750842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QBqBaJQ/znusdWkSiuSPaF1DCyxiXwHukcmYxvDyI7Q=;
 b=VPmeQlTrWZBOj3I1Bg4UUZs8UNk9ZYjVSzbJ/g+ty06+L0Y2uBykPsPSRePYRDpIHM3Mkw
 AlWUM5q3aW2r0DLEq8oBoxUAJWZo8yD5Aht0AC2D0eY9NfMp7aVaNafhOw7tTl+0+WW00R
 jnXQymeYc4I2cMvyXHh2te1mHGG9ZYg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-NN-UCoWuO0i-dPwd8dyMcQ-1; Thu, 12 Aug 2021 02:47:19 -0400
X-MC-Unique: NN-UCoWuO0i-dPwd8dyMcQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 d3-20020a19f2430000b02903c3ec8dea5fso1608540lfk.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 23:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QBqBaJQ/znusdWkSiuSPaF1DCyxiXwHukcmYxvDyI7Q=;
 b=r1mgqlE7hqhQ8OvQ6KtZCITeYff7cq/nksnR5wOMKwgplGdQXcxP/aDTz5O3kF5etN
 df4nclI09r6gV6M+LM15uUQ3GUlFPIxplupZwEdfrP4TsajjEPXjXN46/vzqGbJXuk17
 WcZTGmc2yJn4Guc1gOEiBI//EO1drcrB7N2x9MJr2nRwhlpEFTIdK/vyFbzZSNozRgty
 U5c5hrFluSHKQTb53gi08zuwsN79kkUgMS2j/w09Muqxjyh5xarJG9wPwqp4Y/k+Rwnc
 HsDPzWgGVQynQsFOaDWffkA/U5HtSTvzcC47GtrZLMBFblMaQNmCHd7O5tNyyNNM7etk
 iVpA==
X-Gm-Message-State: AOAM531JYa/tG4Im+R5VVquwMnryYasxMxlG2ZIdCxiEgtHG3yK4lnKD
 YYwFp28GFdqSOmgWCICcaesWvVEOLnphBV7t12kAhQOwCCxkSoGpMLhjWIXa2AlwFBXqwaHexaY
 ZbC6ZrrPCCqDCjRnWIv2oWEJl5XsItHM4jPBYlKXeoL8O6kSusrNwiao5DA==
X-Received: by 2002:ac2:5ddb:: with SMTP id x27mr1101456lfq.258.1628750837573; 
 Wed, 11 Aug 2021 23:47:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+Oo+0wJD52LrzcgbBFxN+79TGNKM/y43eRkcVaSLlrg1c/gwSbfjGnyaWdW2MOQOSWA8U4O9aoFI6ePw0hng=
X-Received: by 2002:ac2:5ddb:: with SMTP id x27mr1101440lfq.258.1628750837304; 
 Wed, 11 Aug 2021 23:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210809140800.97835-1-elic@nvidia.com>
 <20210809140800.97835-4-elic@nvidia.com>
 <07002568-e792-aa35-ec42-5e0f12883a03@redhat.com>
 <20210811075347.GC56418@mtl-vdi-166.wap.labs.mlnx>
 <fccc39c8-f9af-e489-8804-511cb07f1ed2@redhat.com>
 <20210811110401.GB64192@mtl-vdi-166.wap.labs.mlnx>
 <c318303b-3774-909a-a532-2189e9e5a3b9@redhat.com>
 <20210812045535.GA99755@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20210812045535.GA99755@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 Aug 2021 14:47:06 +0800
Message-ID: <CACGkMEsyHiia5DrRU0nLy_OkUZLcQ1==y4Gxy1sETWpVQpVXvg@mail.gmail.com>
Subject: Re: [Patch v1 3/3] vdpa/mlx5: Add multiqueue support
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: eperezma <eperezma@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 mst <mst@redhat.com>
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

T24gVGh1LCBBdWcgMTIsIDIwMjEgYXQgMTI6NTUgUE0gRWxpIENvaGVuIDxlbGljQG52aWRpYS5j
b20+IHdyb3RlOgo+Cj4gT24gVGh1LCBBdWcgMTIsIDIwMjEgYXQgMTE6MTk6MTlBTSArMDgwMCwg
SmFzb24gV2FuZyB3cm90ZToKPiA+Cj4gPiDlnKggMjAyMS84LzExIOS4i+WNiDc6MDQsIEVsaSBD
b2hlbiDlhpnpgZM6Cj4gPiA+IE9uIFdlZCwgQXVnIDExLCAyMDIxIGF0IDA0OjM3OjQ0UE0gKzA4
MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4g5ZyoIDIwMjEvOC8xMSDkuIvljYgzOjUzLCBF
bGkgQ29oZW4g5YaZ6YGTOgo+ID4gPiA+ID4gPiBPbmUgdGhpbmcgbmVlZCB0byBzb2x2ZSBmb3Ig
bXEgaXMgdGhhdCB0aGU6Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gK3N0
YXRpYyB1MTYgY3RybF92cV9pZHgoc3RydWN0ICBtbHg1X3ZkcGFfZGV2ICptdmRldikKPiA+ID4g
PiA+ID4gPiArewo+ID4gPiA+ID4gPiA+ICsgICAgIHJldHVybiAyICogIG1seDVfdmRwYV9tYXhf
cXBzKG12ZGV2LT5tYXhfdnFzKTsKPiA+ID4gPiA+ID4gPiArfQo+ID4gPiA+ID4gPiBXZSBzaG91
bGQgaGFuZGxlIHRoZSBjYXNlIHdoZW4gTVEgaXMgc3VwcG9ydGVkIGJ5IHRoZSBkZXZpY2UgYnV0
IG5vdCB0aGUKPiA+ID4gPiA+ID4gZHJpdmVyLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBFLmcg
aW4gdGhlIGNhc2Ugd2hlbiB3ZSBoYXZlIDIgcXVldWUgcGFpcnM6Cj4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+IFdoZW4gTVEgaXMgZW5hYmxlZCwgY3ZxIGlzIHF1ZXVlIDQKPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gV2hlbiBNUSBpcyBub3QgZW5hYmxlZCwgY3ZxIGlzIHF1ZXVlIDIKPiA+ID4gPiA+
ID4KPiA+ID4gPiA+IFRoZXJlJ3Mgc29tZSBpc3N1ZSB3aXRoIHRoaXMuIEkgZ2V0IGNhbGxiYWNr
cyB0YXJnZXRpbmcgc3BlY2lmaWMKPiA+ID4gPiA+IHZpcnRxdWV1ZXMgYmVmb3JlIGZlYXR1cmVz
IG5lZ290aWF0aW9uIGhhcyBiZWVuIGNvbXBsZXRlZC4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBTcGVj
aWZpY2FsbHksIEkgZ2V0IHNldF92cV9jYigpIGNhbGxzLiBBdCB0aGlzIHBvaW50IEkgbXVzdCBr
bm93IHRoZQo+ID4gPiA+ID4gY29udHJvbCB2cSBpbmRleC4KPiA+ID4gPgo+ID4gPiA+IFNvIEkg
dGhpbmsgd2UgbmVlZCBkbyBib3RoOgo+ID4gPiA+Cj4gPiA+ID4gMSkgQXQgb25lIGhhbmQsIGl0
J3MgYSBidWcgZm9yIHRoZSB1c2Vyc3BhY2UgdG8gdXNlIHZxX2luZGV4IGJlZm9yZSBmZWF0dXJl
Cj4gPiA+ID4gaXMgbmVnb3RpYXRlZAo+ID4gPiA+Cj4gPiA+ID4gKGxvb2tzIGxpa2UgYSBidWcg
aW4gbXkgY3ZxIHNlcmllcyB0aGF0IHdpbGwgY2FsbCBTRVRfVlJJTkdfQ0FMTCBiZWZvcmUKPiA+
ID4gPiBmZWF0dXJlIGlzIG5lZ290aWF0ZSwgd2hpY2ggSSB3aWxsIGxvb2spLgo+ID4gPiA+Cj4g
PiA+ID4gMikgQXQgdGhlIG90aGVyIGhhbmQsIHRoZSBkcml2ZXIgc2hvdWxkIGJlIGFibGUgdG8g
ZGVhbCB3aXRoIHRoYXQKPiA+ID4gPgo+ID4gPiBBbGwgSSBjYW4gZG8gaXMgZHJvcCBjYWxsYmFj
a3MgZm9yIFZRcyBiZWZvcmUgZmVhdHVyZXMgbmVnb3RhdGlvbiBoYXMKPiA+ID4gYmVlbiBjb21w
bGV0ZWQuCj4gPgo+ID4KPiA+IE9yIGp1c3QgbGVhdmUgcXVldWUgaW5kZXggMCwgMSB3b3JrLgo+
ID4KPiA+IFNpbmNlIGl0IGlzIG5vdCBleHBlY3RlZCB0byBiZSBjaGFuZ2VkLgo+ID4KPgo+IFJp
Z2h0LCB3aWxsIGRvLgo+Cj4gPgo+ID4gPgo+ID4gPiA+ID4gSSB0aGluayB0aGUgQ1ZRIGluZGV4
IG11c3Qgbm90IGRlcGVuZCBvbiB0aGUgbmVnb3RpYXRlZCBmZWF0dXJlcyBidXQKPiA+ID4gPiA+
IHJhdGhlciBkZXBlbmQgb2YgdGhlIHZhbHVlIHRoZSBkZXZpY2UgZHJpdmVyIHByb3ZpZGVzIGlu
IHRoZSBjYWxsIHRvCj4gPiA+ID4gPiBfdmRwYV9yZWdpc3Rlcl9kZXZpY2UoKS4KPiA+ID4gPgo+
ID4gPiA+IEF0IHRoZSB2aXJ0aW8gbGV2ZWwsIGl0J3MgdG9vIGxhdGUgdG8gY2hhbmdlIHRoYXQg
YW5kIGl0IGJyZWFrcyB0aGUgYmFja3dhcmQKPiA+ID4gPiBjb21wYXRpYmlsaXR5Lgo+ID4gPiA+
Cj4gPiA+ID4gQnV0IGF0IHRoZSB2RFBBIGxldmVsLCB0aGUgdW5kZXIgbGF5ZXIgZGV2aWNlIGNh
biBtYXAgdmlydGlvIGN2cSB0byBhbnkgb2YKPiA+ID4gPiBpdCdzIHZpcnRxdWV1ZS4KPiA+ID4g
Pgo+ID4gPiA+IEUuZyBtYXAgY3ZxIChpbmRleCAyKSB0byBtbHg1IGN2cSAodGhlIGxhc3QpLgo+
ID4gPiA+Cj4gPiA+IEkgYW0gbm90IGZvbGxvd2luZyB5b3UgaGVyZS4gSSBzdGlsbCBkb24ndCBr
bm93IHdoYXQgaW5kZXggaXMgY3ZxLgo+ID4KPiA+Cj4gPiBSaWdodCwgd2Ugc3RpbGwgbmVlZCB0
byB3YWl0IGZvciB0aGUgZmVhdHVyZSBiZWluZyBuZWdvdGlhdGVkIGluIG9yZGVyIHRvCj4gPiBw
cm9jZWVkLgo+ID4KPgo+IFNvIHRvIHN1bW1hcmlzZSwgYmVmb3JlIGZlYXR1cmUgbmVnb3RpYXRp
b24gY29tcGxldGUsIEkgYWNjZXB0IGNhbGxzCj4gcmVmZXJyaW5nIHRvIFZRcyBvbmx5IGZvciBp
bmRpY2VzIDAgYW5kIDEuCj4gQWZ0ZXIgZmVhdHVyZSBuZWdvdGlhdGlvbiBjb21wbGV0ZSBJIGtu
b3cgQ1ZRIGluZGV4IGFuZCB3aWxsIGFjY2VwdAo+IGluZGljZXMgMCB0byBjdnEgaW5kZXguCgpJ
IGRvbid0IGdldCB0aGlzICJhY2NlcHQgaW5kaWNlcyAwIHRvIGN2cSBpbmRleCIuCgpUaGFua3MK
Cj4KPiA+IFRoYW5rcwo+ID4KPiA+Cj4gPiA+Cj4gPiA+ID4gVGhhbmtzCj4gPiA+ID4KPiA+ID4g
Pgo+ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
