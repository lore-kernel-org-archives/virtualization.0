Return-Path: <SRS0=a9bH=ML=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DD1C07E9B
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 12:07:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C375760FDA
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 12:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C375760FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8818640187;
	Mon, 19 Jul 2021 12:07:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pDbSTJ5CXpiP; Mon, 19 Jul 2021 12:07:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0D0B9400FF;
	Mon, 19 Jul 2021 12:07:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D67D3C0010;
	Mon, 19 Jul 2021 12:07:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96804C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 12:07:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6A43560705
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 12:07:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aWUNvc-ZzUBs
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 12:07:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BEA2C600CA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 12:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626696439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j6mR133kUcTnX/yOv/hKGU+bNQNqbddt7U+1vR0aDjc=;
 b=L4HMngFWZLQAnShaQmuIc0+tuH7pHYFAjn9PmNbtJURWZIZA0pe1oOrS1QIrKQzhqABEbG
 AmhlK/cDqHtor9xL0iC1jz6FQIvqEPbldQlziJdAKc9S0UhkoWi5h9GmK7bSvfhPNHaiNl
 FfqabjZN1NDowDH1iy3eB1jlzVk9bAQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-4dH9pSXeP6CklWTLqqoxeA-1; Mon, 19 Jul 2021 08:07:16 -0400
X-MC-Unique: 4dH9pSXeP6CklWTLqqoxeA-1
Received: by mail-ej1-f69.google.com with SMTP id
 k1-20020a17090666c1b029041c273a883dso5294293ejp.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 05:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=j6mR133kUcTnX/yOv/hKGU+bNQNqbddt7U+1vR0aDjc=;
 b=eqHIeIeneBqkdFaf+MLPwDvfE+T1mf7Mk+79UycybfCO3a2tR227PKLgsoZPHF4zFu
 F1gFfpNhW9EneHq6KgZWbRDWTNq65fa9zrjprz5nqaDbu7d9hdTeNTCXmodL0fHGNQT/
 4pP7w+9XoZJE3NXnzHcWxdE2LXN5FrfC8/3YJ31fTQWMH8fJcbyBF0uGQsWwGIHXVg4x
 KooPKePJIhfOuVBq1RC49ZqCvI7CS+dVvIvrzfPXCSIsMQk/loZ+4LwszcdBnIB5znA4
 zaLDVYrcviqSi3T3il6dihvTYxvm2/A7s2z8uJNvy+C6KjFwELAMM1SXgIbl4gaac7J6
 8wsA==
X-Gm-Message-State: AOAM530cRakdhU8fJsrqMDnDvvd029x5VT6sw2p90zKabnhrVd43afSz
 ZXd/6f3Kx8ldW2dXTNgCh0Vpp6rVaqNsjVLShpi3K53qAd2k0v5ZYqTmguZUzHHS+7EBM0azMY3
 GVSa58JwxWKp/YFyxzBZ1CsR2cCrAjlj9eWThnD83mQ==
X-Received: by 2002:a05:6402:22e1:: with SMTP id
 dn1mr34391603edb.8.1626696434988; 
 Mon, 19 Jul 2021 05:07:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBeBA7c5HPgoGFC+Eju2e4Ln264P72ou66zESQ73svXi/ffeZc7yEgeRkMEWvJKyKrzbwwvg==
X-Received: by 2002:a05:6402:22e1:: with SMTP id
 dn1mr34391576edb.8.1626696434772; 
 Mon, 19 Jul 2021 05:07:14 -0700 (PDT)
Received: from redhat.com ([2.55.11.37])
 by smtp.gmail.com with ESMTPSA id lv15sm5905936ejb.76.2021.07.19.05.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jul 2021 05:07:13 -0700 (PDT)
Date: Mon, 19 Jul 2021 08:07:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH 4/4] virtio_pci: Support surprise removal of virtio pci
 device
Message-ID: <20210719080539-mutt-send-email-mst@kernel.org>
References: <20210717074258.1463313-1-parav@nvidia.com>
 <20210717074258.1463313-5-parav@nvidia.com>
 <20210717164152-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54813A3CA2397ACE87A1DAF6DCE19@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54813A3CA2397ACE87A1DAF6DCE19@PH0PR12MB5481.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "virtualization@lists.linux-foundation.org"
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

T24gTW9uLCBKdWwgMTksIDIwMjEgYXQgMDU6NDQ6NDlBTSArMDAwMCwgUGFyYXYgUGFuZGl0IHdy
b3RlOgo+IAo+IAo+ID4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4K
PiA+IFNlbnQ6IFN1bmRheSwgSnVseSAxOCwgMjAyMSAyOjE3IEFNCj4gPiAKPiA+IE9uIFNhdCwg
SnVsIDE3LCAyMDIxIGF0IDEwOjQyOjU4QU0gKzAzMDAsIFBhcmF2IFBhbmRpdCB3cm90ZToKPiA+
ID4gV2hlbiBhIHZpcnRpbyBwY2kgZGV2aWNlIHVuZGVyZ28gc3VycHJpc2UgcmVtb3ZhbCAoYWth
IGFzeW5jIHJlbW92YWxuCj4gPiA+IGluCj4gPiAKPiA+IHR5cG8KPiBGaXhpbmcgaXQuIENoZWNr
cGF0Y2gucGwgYW5kIGNvZGVzcGVsbCwgYm90aCBkaWRuJ3QgY2F0Y2ggaXQuIPCfmIoKPiAKPiA+
IAo+ID4gT0sgdGhhdCdzIG5pY2UsIGJ1dCBJIHN1c3BlY3QgdGhpcyBpcyBub3QgZW5vdWdoLgo+
ID4gRm9yIGV4YW1wbGUgd2UgbmVlZCB0byBhbHNvIGZpeCB1cCBhbGwgY29uZmlnIHNwYWNlIHJl
YWRzIHRvIGhhbmRsZSBhbGwtb25lcwo+ID4gcGF0dGVybnMgc3BlY2lhbGx5Lgo+ID4gCj4gPiBF
LmcuCj4gPiAKPiA+ICAgICAgICAgLyogQWZ0ZXIgd3JpdGluZyAwIHRvIGRldmljZV9zdGF0dXMs
IHRoZSBkcml2ZXIgTVVTVCB3YWl0IGZvciBhIHJlYWQgb2YKPiA+ICAgICAgICAgICogZGV2aWNl
X3N0YXR1cyB0byByZXR1cm4gMCBiZWZvcmUgcmVpbml0aWFsaXppbmcgdGhlIGRldmljZS4KPiA+
ICAgICAgICAgICogVGhpcyB3aWxsIGZsdXNoIG91dCB0aGUgc3RhdHVzIHdyaXRlLCBhbmQgZmx1
c2ggaW4gZGV2aWNlIHdyaXRlcywKPiA+ICAgICAgICAgICogaW5jbHVkaW5nIE1TSS1YIGludGVy
cnVwdHMsIGlmIGFueS4KPiA+ICAgICAgICAgICovCj4gPiAgICAgICAgIHdoaWxlICh2cF9tb2Rl
cm5fZ2V0X3N0YXR1cyhtZGV2KSkKPiA+ICAgICAgICAgICAgICAgICBtc2xlZXAoMSk7Cj4gPiAK
PiA+IGxvdHMgb2YgY29kZSBpbiBkcml2ZXJzIG5lZWRzIHRvIGJlIGZpeGVkIHRvby4KPiBBYm92
ZSBvbmUgcGFydGljdWxhcmx5IGtub3duIHRvIHVzIGluIHRoZSBob3QgcGx1ZyBhcmVhLgo+IEFi
b3ZlIGZpeCBpcyBuZWVkZWQgdG8gY2xvc2UgdGhlIHJhY2Ugb2YgaG90IHBsdWcgYW5kIHVucGx1
ZyBoYXBwZW5pbmcgaW4gcGFyYWxsZWwsIHdoaWNoIGlzIG9jY3VycmluZyB0b2RheSwgYnV0IGxl
c3MgY29tbW9uLgo+IEl0IGlzIGluIG15IHRvZG8gbGlzdCB0byBmaXggaXQuCj4gV2lsbCB0YWtl
IGNhcmUgb2YgaXQgaW4gbmVhciBmdXR1cmUgaW4gb3RoZXIgc2VyaWVzLgo+IAo+ID4gCj4gPiBJ
IGd1ZXNzIHdlIG5lZWQgdG8gYW5ub3RhdGUgZHJpdmVycyBzb21laG93IHRvIG1hcmsgdXAgd2hl
dGhlciB0aGV5Cj4gPiBzdXBwb3J0IHN1cnByaXNlIHJlbW92YWw/IEFuZCBtYXliZSBmaW5kIGEg
d2F5IHRvIGxldCBob3N0IGtub3c/Cj4gV2hhdCBpcyB0aGUgYmVuZWZpdCBvZiBpdD8gV2hvIGNh
biBtYWtlIHVzZSBvZiB0aGF0IGluZm9ybWF0aW9uPwoKRm9yIGV4YW1wbGUsIGhvc3QgY291bGQg
YXZvaWQgcmVtb3ZpbmcgZGV2aWNlcyBieSBob3QgcmVtb3ZhbCBpZiBndWVzdAppcyBub3QgcmVh
ZHkgZm9yIGl0LiBPciBsaWJvc2luZm8gY291bGQgdXNlIHRoYXQgdG8gdGVsbCB1c2VycyB3aGF0
IHRvCmRvLgoKPiBJbiB2aXJ0aW8gcGNpIGNhc2UsIGl0IGlzIHNpbWlsYXIgaW1wcm92ZW1lbnQg
dG8gd2hhdCBudm1lIHBjaSBkcml2ZXIgd2VudCB0aHJvdWdoIGZldyB5ZWFycyBiYWNrIHRvIHN1
cHBvcnQgaG90IHBsdWcvdW5wbHVnLgo+IExldHMgY29tcGxldGUgdGhpcyBvZiBmaXhlcyB0byBt
YWtlIGl0IGxpdHRsZSBtb3JlIHJvYnVzdCBsaWtlIG52bWUuCgpBdCBsZWFzdCBwbGVhc2UgbWVu
dGlvbiBpbiBjb21taXQgbG9nIHRoYXQgaXQncyBpbmNvbXBsZXRlLgoKPiA+IAo+ID4gCj4gPiAK
PiA+ID4gLS0tCj4gPiA+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jIHwgNyAr
KysrKysrCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspCj4gPiA+Cj4gPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jCj4gPiA+IGIv
ZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uYwo+ID4gPiBpbmRleCAyMjJkNjMwYzQx
ZmMuLmIzNWJiMmQ1N2Y2MiAxMDA2NDQKPiA+ID4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlv
X3BjaV9jb21tb24uYwo+ID4gPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1v
bi5jCj4gPiA+IEBAIC01NzYsNiArNTc2LDEzIEBAIHN0YXRpYyB2b2lkIHZpcnRpb19wY2lfcmVt
b3ZlKHN0cnVjdCBwY2lfZGV2Cj4gPiAqcGNpX2RldikKPiA+ID4gIAlzdHJ1Y3QgdmlydGlvX3Bj
aV9kZXZpY2UgKnZwX2RldiA9IHBjaV9nZXRfZHJ2ZGF0YShwY2lfZGV2KTsKPiA+ID4gIAlzdHJ1
Y3QgZGV2aWNlICpkZXYgPSBnZXRfZGV2aWNlKCZ2cF9kZXYtPnZkZXYuZGV2KTsKPiA+ID4KPiA+
ID4gKwkvKgo+ID4gPiArCSAqIERldmljZSBpcyBtYXJrZWQgYnJva2VuIG9uIHN1cnByaXNlIHJl
bW92YWwgc28gdGhhdCB2aXJ0aW8gdXBwZXIKPiA+ID4gKwkgKiBsYXllcnMgY2FuIGFib3J0IGFu
eSBvbmdvaW5nIG9wZXJhdGlvbi4KPiA+ID4gKwkgKi8KPiA+ID4gKwlpZiAoIXBjaV9kZXZpY2Vf
aXNfcHJlc2VudChwY2lfZGV2KSkKPiA+ID4gKwkJdmlydGlvX2JyZWFrX2RldmljZSgmdnBfZGV2
LT52ZGV2KTsKPiA+ID4gKwo+ID4gPiAgCXBjaV9kaXNhYmxlX3NyaW92KHBjaV9kZXYpOwo+ID4g
Pgo+ID4gPiAgCXVucmVnaXN0ZXJfdmlydGlvX2RldmljZSgmdnBfZGV2LT52ZGV2KTsKPiA+ID4g
LS0KPiA+ID4gMi4yNy4wCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
