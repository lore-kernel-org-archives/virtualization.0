Return-Path: <SRS0=F+q/=ND=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A71C432BE
	for <virtualization@archiver.kernel.org>; Thu, 12 Aug 2021 07:04:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 722D16103A
	for <virtualization@archiver.kernel.org>; Thu, 12 Aug 2021 07:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 722D16103A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35782405AB;
	Thu, 12 Aug 2021 07:04:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R1EDcCYPJn9q; Thu, 12 Aug 2021 07:04:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D97744017F;
	Thu, 12 Aug 2021 07:04:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C491C0010;
	Thu, 12 Aug 2021 07:04:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33B1CC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 07:04:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0E73E40175
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 07:04:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eKaMcgj2E_G4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 07:04:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4F6644016F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 07:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628751890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N0AzU7KV2du1FuUKGGs1+687p17R/+JQEDIeqG1AV1A=;
 b=O/NPEQb4+Z2Q7J/t8YdsyYd5XNOoG2NX/Lo514fGtf2oDP+a/c3m9WXk0LVLkk0SkXH87Q
 uzsEvQc8crGHtWMCa6kBlEGBxobesfoEOx7rZaNwUJhJUKlt9eYVNJ2ABJncYrKQaISKsD
 Cbjes8RI7ncUS1FWzoRGGKVT9bW0Awg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-1LE80hGLO32ADxiA1gn3mw-1; Thu, 12 Aug 2021 03:04:49 -0400
X-MC-Unique: 1LE80hGLO32ADxiA1gn3mw-1
Received: by mail-pj1-f71.google.com with SMTP id
 gt7-20020a17090af2c7b02901773c999dcbso3568456pjb.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 00:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=N0AzU7KV2du1FuUKGGs1+687p17R/+JQEDIeqG1AV1A=;
 b=dpOOLLHn9JBAmplu/PH2TntpE4kEYP+4gV5cZGdAF8ypc298Day1HZzlWtDlQToGQ9
 Xf1Zb3vlIzBQz0QbMfU4+hz350+efdo4gEfccx7vsivXU1DzaEtgMCoFWD5J74NqO+rz
 LHBLUq+hWLHxjbsHyuBcL6BwAQElldhh+kif6rFPOf60bGaikIuy38iAit8Ab+1eOzSG
 cPEIScXsBo5qly/Lv3bEUU4VSDepviMShfTRn1QnuANKQx5HbzpFms+cNAWzeHbQozjj
 MYFuImhJr7tmOwypvGALBMjqvcrkbQ5baKnwC67US6UrWQ4f1uTaowyvZ6m5lUbWa4/d
 CDGQ==
X-Gm-Message-State: AOAM530yny4EH6BhGq03BIekaq3CDf4OHpphL2YMduyKF8DGnnrgQhE9
 sMF9QSCq0GZW4KVGZ6JGtZZ8o6NuVsBS0C0YrYWtjnlyUMvxeS7KZA0koDNO/vtCVmlhQrh7rG1
 pcc9+mliiirAI+Z/YIyFy90HAWGEYhAOtU3nv9uSThg==
X-Received: by 2002:a63:4446:: with SMTP id t6mr2655648pgk.76.1628751888093;
 Thu, 12 Aug 2021 00:04:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8aJ0EZptKdaM1fyGABNL7Hku0lsqp3YnkHiRCefSM6YBves2YfrtJZjJxLKLwrxDCJ+7v9w==
X-Received: by 2002:a63:4446:: with SMTP id t6mr2655637pgk.76.1628751887857;
 Thu, 12 Aug 2021 00:04:47 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 141sm2021692pfv.15.2021.08.12.00.04.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Aug 2021 00:04:47 -0700 (PDT)
Subject: Re: [Patch v1 3/3] vdpa/mlx5: Add multiqueue support
To: Eli Cohen <elic@nvidia.com>
References: <20210809140800.97835-1-elic@nvidia.com>
 <20210809140800.97835-4-elic@nvidia.com>
 <07002568-e792-aa35-ec42-5e0f12883a03@redhat.com>
 <20210811075347.GC56418@mtl-vdi-166.wap.labs.mlnx>
 <fccc39c8-f9af-e489-8804-511cb07f1ed2@redhat.com>
 <20210811110401.GB64192@mtl-vdi-166.wap.labs.mlnx>
 <c318303b-3774-909a-a532-2189e9e5a3b9@redhat.com>
 <20210812045535.GA99755@mtl-vdi-166.wap.labs.mlnx>
 <CACGkMEsyHiia5DrRU0nLy_OkUZLcQ1==y4Gxy1sETWpVQpVXvg@mail.gmail.com>
 <20210812070151.GA103566@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2cc15e3e-bd5c-8e43-1d2f-b0e03b8690d5@redhat.com>
Date: Thu, 12 Aug 2021 15:04:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210812070151.GA103566@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIxLzgvMTIg5LiL5Y2IMzowMSwgRWxpIENvaGVuIOWGmemBkzoKPiBPbiBUaHUsIEF1
ZyAxMiwgMjAyMSBhdCAwMjo0NzowNlBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiBPbiBU
aHUsIEF1ZyAxMiwgMjAyMSBhdCAxMjo1NSBQTSBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4g
d3JvdGU6Cj4+PiBPbiBUaHUsIEF1ZyAxMiwgMjAyMSBhdCAxMToxOToxOUFNICswODAwLCBKYXNv
biBXYW5nIHdyb3RlOgo+Pj4+IOWcqCAyMDIxLzgvMTEg5LiL5Y2INzowNCwgRWxpIENvaGVuIOWG
memBkzoKPj4+Pj4gT24gV2VkLCBBdWcgMTEsIDIwMjEgYXQgMDQ6Mzc6NDRQTSArMDgwMCwgSmFz
b24gV2FuZyB3cm90ZToKPj4+Pj4+IOWcqCAyMDIxLzgvMTEg5LiL5Y2IMzo1MywgRWxpIENvaGVu
IOWGmemBkzoKPj4+Pj4+Pj4gT25lIHRoaW5nIG5lZWQgdG8gc29sdmUgZm9yIG1xIGlzIHRoYXQg
dGhlOgo+Pj4+Pj4+Pgo+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gK3N0YXRpYyB1MTYgY3RybF92cV9pZHgo
c3RydWN0ICBtbHg1X3ZkcGFfZGV2ICptdmRldikKPj4+Pj4+Pj4+ICt7Cj4+Pj4+Pj4+PiArICAg
ICByZXR1cm4gMiAqICBtbHg1X3ZkcGFfbWF4X3FwcyhtdmRldi0+bWF4X3Zxcyk7Cj4+Pj4+Pj4+
PiArfQo+Pj4+Pj4+PiBXZSBzaG91bGQgaGFuZGxlIHRoZSBjYXNlIHdoZW4gTVEgaXMgc3VwcG9y
dGVkIGJ5IHRoZSBkZXZpY2UgYnV0IG5vdCB0aGUKPj4+Pj4+Pj4gZHJpdmVyLgo+Pj4+Pj4+Pgo+
Pj4+Pj4+PiBFLmcgaW4gdGhlIGNhc2Ugd2hlbiB3ZSBoYXZlIDIgcXVldWUgcGFpcnM6Cj4+Pj4+
Pj4+Cj4+Pj4+Pj4+IFdoZW4gTVEgaXMgZW5hYmxlZCwgY3ZxIGlzIHF1ZXVlIDQKPj4+Pj4+Pj4K
Pj4+Pj4+Pj4gV2hlbiBNUSBpcyBub3QgZW5hYmxlZCwgY3ZxIGlzIHF1ZXVlIDIKPj4+Pj4+Pj4K
Pj4+Pj4+PiBUaGVyZSdzIHNvbWUgaXNzdWUgd2l0aCB0aGlzLiBJIGdldCBjYWxsYmFja3MgdGFy
Z2V0aW5nIHNwZWNpZmljCj4+Pj4+Pj4gdmlydHF1ZXVlcyBiZWZvcmUgZmVhdHVyZXMgbmVnb3Rp
YXRpb24gaGFzIGJlZW4gY29tcGxldGVkLgo+Pj4+Pj4+Cj4+Pj4+Pj4gU3BlY2lmaWNhbGx5LCBJ
IGdldCBzZXRfdnFfY2IoKSBjYWxscy4gQXQgdGhpcyBwb2ludCBJIG11c3Qga25vdyB0aGUKPj4+
Pj4+PiBjb250cm9sIHZxIGluZGV4Lgo+Pj4+Pj4gU28gSSB0aGluayB3ZSBuZWVkIGRvIGJvdGg6
Cj4+Pj4+Pgo+Pj4+Pj4gMSkgQXQgb25lIGhhbmQsIGl0J3MgYSBidWcgZm9yIHRoZSB1c2Vyc3Bh
Y2UgdG8gdXNlIHZxX2luZGV4IGJlZm9yZSBmZWF0dXJlCj4+Pj4+PiBpcyBuZWdvdGlhdGVkCj4+
Pj4+Pgo+Pj4+Pj4gKGxvb2tzIGxpa2UgYSBidWcgaW4gbXkgY3ZxIHNlcmllcyB0aGF0IHdpbGwg
Y2FsbCBTRVRfVlJJTkdfQ0FMTCBiZWZvcmUKPj4+Pj4+IGZlYXR1cmUgaXMgbmVnb3RpYXRlLCB3
aGljaCBJIHdpbGwgbG9vaykuCj4+Pj4+Pgo+Pj4+Pj4gMikgQXQgdGhlIG90aGVyIGhhbmQsIHRo
ZSBkcml2ZXIgc2hvdWxkIGJlIGFibGUgdG8gZGVhbCB3aXRoIHRoYXQKPj4+Pj4+Cj4+Pj4+IEFs
bCBJIGNhbiBkbyBpcyBkcm9wIGNhbGxiYWNrcyBmb3IgVlFzIGJlZm9yZSBmZWF0dXJlcyBuZWdv
dGF0aW9uIGhhcwo+Pj4+PiBiZWVuIGNvbXBsZXRlZC4KPj4+Pgo+Pj4+IE9yIGp1c3QgbGVhdmUg
cXVldWUgaW5kZXggMCwgMSB3b3JrLgo+Pj4+Cj4+Pj4gU2luY2UgaXQgaXMgbm90IGV4cGVjdGVk
IHRvIGJlIGNoYW5nZWQuCj4+Pj4KPj4+IFJpZ2h0LCB3aWxsIGRvLgo+Pj4KPj4+Pj4+PiBJIHRo
aW5rIHRoZSBDVlEgaW5kZXggbXVzdCBub3QgZGVwZW5kIG9uIHRoZSBuZWdvdGlhdGVkIGZlYXR1
cmVzIGJ1dAo+Pj4+Pj4+IHJhdGhlciBkZXBlbmQgb2YgdGhlIHZhbHVlIHRoZSBkZXZpY2UgZHJp
dmVyIHByb3ZpZGVzIGluIHRoZSBjYWxsIHRvCj4+Pj4+Pj4gX3ZkcGFfcmVnaXN0ZXJfZGV2aWNl
KCkuCj4+Pj4+PiBBdCB0aGUgdmlydGlvIGxldmVsLCBpdCdzIHRvbyBsYXRlIHRvIGNoYW5nZSB0
aGF0IGFuZCBpdCBicmVha3MgdGhlIGJhY2t3YXJkCj4+Pj4+PiBjb21wYXRpYmlsaXR5Lgo+Pj4+
Pj4KPj4+Pj4+IEJ1dCBhdCB0aGUgdkRQQSBsZXZlbCwgdGhlIHVuZGVyIGxheWVyIGRldmljZSBj
YW4gbWFwIHZpcnRpbyBjdnEgdG8gYW55IG9mCj4+Pj4+PiBpdCdzIHZpcnRxdWV1ZS4KPj4+Pj4+
Cj4+Pj4+PiBFLmcgbWFwIGN2cSAoaW5kZXggMikgdG8gbWx4NSBjdnEgKHRoZSBsYXN0KS4KPj4+
Pj4+Cj4+Pj4+IEkgYW0gbm90IGZvbGxvd2luZyB5b3UgaGVyZS4gSSBzdGlsbCBkb24ndCBrbm93
IHdoYXQgaW5kZXggaXMgY3ZxLgo+Pj4+Cj4+Pj4gUmlnaHQsIHdlIHN0aWxsIG5lZWQgdG8gd2Fp
dCBmb3IgdGhlIGZlYXR1cmUgYmVpbmcgbmVnb3RpYXRlZCBpbiBvcmRlciB0bwo+Pj4+IHByb2Nl
ZWQuCj4+Pj4KPj4+IFNvIHRvIHN1bW1hcmlzZSwgYmVmb3JlIGZlYXR1cmUgbmVnb3RpYXRpb24g
Y29tcGxldGUsIEkgYWNjZXB0IGNhbGxzCj4+PiByZWZlcnJpbmcgdG8gVlFzIG9ubHkgZm9yIGlu
ZGljZXMgMCBhbmQgMS4KPj4+IEFmdGVyIGZlYXR1cmUgbmVnb3RpYXRpb24gY29tcGxldGUgSSBr
bm93IENWUSBpbmRleCBhbmQgd2lsbCBhY2NlcHQKPj4+IGluZGljZXMgMCB0byBjdnEgaW5kZXgu
Cj4+IEkgZG9uJ3QgZ2V0IHRoaXMgImFjY2VwdCBpbmRpY2VzIDAgdG8gY3ZxIGluZGV4Ii4KPiBX
aGF0IEkgbWVhbnQgdG8gc2F5IGlzIHRoYXQgdGhlcmUgYXJlIHNldmVyYWwgY2FsbGJhY2tzIHRo
YXQgcmVmZXIgdG8KPiBzcGVjaWZpYyB2aXJ0cXVldWVzLCBlLmcuIHNldF92cV9hZGRyZXNzKCks
IHNldF92cV9udW0oKSBldGMuIFRoZXkgYWxsCj4gYWNjZXB0IHZpcnRxdWV1ZSBpbmRleCBhcyBh
biBhcmd1bWVudC4KPgo+IFdoYXQgd2Ugd2FudCB0byBkbyBpcyB2ZXJpZnkgd2hlYXRoZXIgdGhl
IGluZGV4IHByb3ZpZGVkIGlzIHZhbGlkIG9yCj4gbm90LiBJZiBpdCBpcyBub3QgdmFsaWQsIGVp
dGhlciByZXR1cm4gZXJyb3IgKGlmIHRoZSBjYWxsYmFjayBjYW4gcmV0dXJuCj4gYSB2YWx1ZSkg
b3IganVzdCBhdm9pZCBwcm9jZXNzaW5nIGl0LiBJZiB0aGUgaW5kZXggaXMgdmFsaWQgdGhlbiB3
ZQo+IHByb2Nlc3MgaXQgbm9ybWFsbHkuCj4KPiBOb3cgd2UgbmVlZCB0byBkZWNpZGUgd2hpY2gg
aW5kZXggaXMgdmFsaWQgb3Igbm90LiBXZSBuZWVkIHNvbWV0aGluZwo+IGxpa2UgdGhpcyB0byBp
ZGVudGlmaXkgdmFsaWQgaW5kZXhlcyByYW5nZToKPgo+IENWUSBjbGVhcjogMCBhbmQgMQo+IENW
USBzZXQsIE1RIGNsZWFyOiAwLCAxIGFuZCAyIChmb3IgQ1ZRKS4KPiBDVlEgc2V0LCBNUSBzZXQ6
IDAuLm52cSB3aGVyZSBudnEgaXMgd2hhdGV2ZXIgcHJvdmlkZWQgdG8KPiBfdmRwYV9yZWdpc3Rl
cl9kZXZpY2UoKQoKClllcy4KCgo+Cj4gQW5kIHdoaWxlIHdyaXRpbmcgdGhpcywgSSB0aGluayB0
aGlzIGxvZ2ljIGRvZXMgbm90IGJlbG9nIGluIG1seDVfdmRwYQo+IGJ1dCBwcm9iYWJseSBpbiB2
ZHBhLmMKCgpUaGUgcHJvYmxlbSBpcyB0aGF0IHZkcGEgc2hvdWxkIGJlIHVuYXdhcmUgb2YgYSBz
cGVjaWZpYyBkZXZpY2UgdHlwZS4gCkUuZyB0aGUgYWJvdmUgaW5kaWNlcyBtYXkgd29yayBvbmx5
IGZvciB2aXJ0aW8tbmV0IGJ1dCBub3Qgb3RoZXIuCgpUaGFua3MKCgo+IAkKPj4gVGhhbmtzCj4+
Cj4+Pj4gVGhhbmtzCj4+Pj4KPj4+Pgo+Pj4+Pj4gVGhhbmtzCj4+Pj4+Pgo+Pj4+Pj4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
