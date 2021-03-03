Return-Path: <SRS0=2V5C=IB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76531C433DB
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 09:35:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF2DB64EA4
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 09:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF2DB64EA4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 53FC9484E0;
	Wed,  3 Mar 2021 09:35:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Us_iVSfFunVv; Wed,  3 Mar 2021 09:35:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 95E0E40175;
	Wed,  3 Mar 2021 09:35:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E41FC000A;
	Wed,  3 Mar 2021 09:35:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29EDAC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 09:35:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 17F6F839C0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 09:35:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bIHz8OvWq8EZ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 09:35:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0D9838294A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 09:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614764115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o9mocgsN1JyKYl2Ehc6+h6DUZ6FnYA1QOVXuyuxANxM=;
 b=UYpzJplvlpHvS+IIAHfyqrpoFctkajpBhPcy3G7secKVFEWmxV9DlwFvX4Fb4yTpbAF31x
 M1+5bST2w7BvJf27x0QY0DG64j7WhJM7txcwN0stUw5bQeJxeKXK6ry5fP3FeNsA3mHBoI
 z859eBgBY4002R+ZEhT0RmZsNu+oSSk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-UrRVTy6kPqO2Uvq0BxlKUA-1; Wed, 03 Mar 2021 04:35:11 -0500
X-MC-Unique: UrRVTy6kPqO2Uvq0BxlKUA-1
Received: by mail-ed1-f72.google.com with SMTP id f11so11826724edk.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 Mar 2021 01:35:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=o9mocgsN1JyKYl2Ehc6+h6DUZ6FnYA1QOVXuyuxANxM=;
 b=GCiiSVvaBZB4yUf0SoutzXIB+nlijbV2gwv280Zexrww8eo21UDNQwd5UXbRmkZg+A
 +Z361I+Y6G9YH97XYOM856YLbmizWzlr4rqT27nU5r6ZjzKe8PLWdmDKiZdcGVw2syof
 A8ioCjQdgttsAH85ZEdOlqM1b9qcl7VCsJYHqLct5aFuLsHIYyRlcpv4OBQSOCXIlZs9
 bbBXJ4UuOziN1GOF51oY8pSgLweAIepcViZgYspSYsR+hrvK32Zes0MSfz8KhP5Tc6uA
 E3yH0Awhhw3T/sFbPmigRLpv99unGE3z7Xq6yBumWzdy4sIsfPdOfNOMBTFmSiyYlFGw
 ISLg==
X-Gm-Message-State: AOAM53046sh6kl2SXv/fyAQiSxMSHQq+F192/K14luhuPx7DwzfH7YTZ
 vAE6FKixqmoAjwUE9TqUDu3SNuVvhCNFT8H1eP3kQ8Osa7U8vx5uNrUc11jXvF+VjRAIsv7QpQw
 FEtYA5yQE6ZJW/MNXxhZLSd5DdfC0w5B3TcViV6oPZg==
X-Received: by 2002:a17:906:5295:: with SMTP id
 c21mr16368546ejm.67.1614764109807; 
 Wed, 03 Mar 2021 01:35:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxrQwesCjT6KkOWEJ5nmyBvUnxoRed2JW7mxKBTDsWqeMrWDbiAobL9izp1DJUs547a8QTgYQ==
X-Received: by 2002:a17:906:5295:: with SMTP id
 c21mr16368537ejm.67.1614764109595; 
 Wed, 03 Mar 2021 01:35:09 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id s2sm12152464ejn.112.2021.03.03.01.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Mar 2021 01:35:08 -0800 (PST)
Date: Wed, 3 Mar 2021 04:35:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH linux-next 7/9] vdpa/mlx5: Provide device generated
 random MAC address
Message-ID: <20210303043305-mutt-send-email-mst@kernel.org>
References: <20210224061844.137776-1-parav@nvidia.com>
 <20210224061844.137776-8-parav@nvidia.com>
 <97a01cb9-8278-1ed6-59b5-807c58523c82@redhat.com>
 <20210301070828.GA184680@mtl-vdi-166.wap.labs.mlnx>
 <20210301080731-mutt-send-email-mst@kernel.org>
 <20210301131951.GA196924@mtl-vdi-166.wap.labs.mlnx>
 <20210301110937-mutt-send-email-mst@kernel.org>
 <20210302053919.GB227464@mtl-vdi-166.wap.labs.mlnx>
 <DM6PR12MB43302B0E28AEFDD8A1620D11DC989@DM6PR12MB4330.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM6PR12MB43302B0E28AEFDD8A1620D11DC989@DM6PR12MB4330.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
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

T24gV2VkLCBNYXIgMDMsIDIwMjEgYXQgMDM6NTk6NTBBTSArMDAwMCwgUGFyYXYgUGFuZGl0IHdy
b3RlOgo+IEhpIEVsaSwKPiAKPiA+IEZyb206IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPgo+
ID4gU2VudDogVHVlc2RheSwgTWFyY2ggMiwgMjAyMSAxMTowOSBBTQo+ID4gCj4gPiBPbiBNb24s
IE1hciAwMSwgMjAyMSBhdCAxMToxMjozM0FNIC0wNTAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3Jv
dGU6Cj4gPiA+IE9uIE1vbiwgTWFyIDAxLCAyMDIxIGF0IDAzOjE5OjUxUE0gKzAyMDAsIEVsaSBD
b2hlbiB3cm90ZToKPiA+ID4gPiBPbiBNb24sIE1hciAwMSwgMjAyMSBhdCAwODowOTo0OEFNIC0w
NTAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+ID4gPiBPbiBNb24sIE1hciAwMSwg
MjAyMSBhdCAwOTowODoyOEFNICswMjAwLCBFbGkgQ29oZW4gd3JvdGU6Cj4gPiA+ID4gPiA+IE9u
IFdlZCwgRmViIDI0LCAyMDIxIGF0IDA1OjExOjIzUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBPbiAyMDIxLzIvMjQgMjoxOCDkuIvljYgsIFBh
cmF2IFBhbmRpdCB3cm90ZToKPiA+ID4gPiA+ID4gPiA+IEZyb206IEVsaSBDb2hlbiA8ZWxpY0Bu
dmlkaWEuY29tPgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IFVzZSBhIHJhbmRvbWx5
IGdlbmVyYXRlZCBNQUMgYWRkcmVzcyB0byBiZSBhcHBsaWVkIGluIGNhc2UKPiA+ID4gPiA+ID4g
PiA+IGl0IGlzIG5vdCBjb25maWd1cmVkIGJ5IG1hbmFnZW1lbnQgdG9vbC4KPiA+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gPiBUaGUgdmFsdWUgcXVlcmllZCB0aHJvdWdoIG1seDVfcXVlcnlf
bmljX3Zwb3J0X21hY19hZGRyZXNzKCkKPiA+ID4gPiA+ID4gPiA+IGlzIG5vdCByZWxlbGF2bnQg
dG8gdmRwYSBzaW5jZSBpdCBpcyB0aGUgbWFjIHRoYXQgc2hvdWxkIGJlCj4gPiA+ID4gPiA+ID4g
PiB1c2VkIGJ5IHRoZSByZWd1bGFyIE5JQyBkcml2ZXIuCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+Cj4gPiA+
ID4gPiA+ID4gPiBSZXZpZXdlZC1ieTogUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPgo+
ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBBY2tlZC1ieTogSmFzb24g
V2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+ID4gPiA+ICAgZHJpdmVycy92ZHBhL21seDUvbmV0
L21seDVfdm5ldC5jIHwgNSArLS0tLQo+ID4gPiA+ID4gPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDQgZGVsZXRpb25zKC0pCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ID4g
PiA+ID4gPiA+ID4gYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+ID4gPiA+
ID4gPiA+IGluZGV4IGI2N2JiYTU4MWRmZC4uZWNlMjE4M2U3YjIwIDEwMDY0NAo+ID4gPiA+ID4g
PiA+ID4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gPiA+ID4gPiA+
ID4gPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+ID4gPiA+ID4g
PiA+IEBAIC0yMDA1LDEwICsyMDA1LDcgQEAgc3RhdGljIGludCBtbHg1X3ZkcGFfZGV2X2FkZChz
dHJ1Y3QKPiA+IHZkcGFfbWdtdF9kZXYgKnZfbWRldiwgY29uc3QgY2hhciAqbmFtZSkKPiA+ID4g
PiA+ID4gPiA+ICAgCWlmIChlcnIpCj4gPiA+ID4gPiA+ID4gPiAgIAkJZ290byBlcnJfbXR1Owo+
ID4gPiA+ID4gPiA+ID4gLQllcnIgPSBtbHg1X3F1ZXJ5X25pY192cG9ydF9tYWNfYWRkcmVzcyht
ZGV2LCAwLCAwLCBjb25maWctCj4gPiA+bWFjKTsKPiA+ID4gPiA+ID4gPiA+IC0JaWYgKGVycikK
PiA+ID4gPiA+ID4gPiA+IC0JCWdvdG8gZXJyX210dTsKPiA+ID4gPiA+ID4gPiA+IC0KPiA+ID4g
PiA+ID4gPiA+ICsJZXRoX3JhbmRvbV9hZGRyKGNvbmZpZy0+bWFjKTsKPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gSSB0aGluayB0aGlzIHBhdGNoIGlzIG1pc3Npbmcgc2V0dGluZyBWSVJUSU9fTkVU
X0ZfTVRVLiBJIHdpbGwKPiA+ID4gPiA+ID4gcG9zdCB2MiB3aXRoIHRoZSBvdGhlciBmaXhlcyBp
biB0aGlzIHNlcmllcy4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBJIGRvbid0IHJlYWxseSB1bmRlcnN0
YW5kIHdoeSB0aGlzIGlzIGEgZ29vZCBpZGVhLgo+ID4gPiA+ID4KPiA+ID4gPiA+IElmIHVzZXJz
cGFjZSB3YW50cyBhIHJhbmRvbSBtYWMgaXQgY2FuIHNldCBpdCwgd2l0aCB0aGlzIHBhdGNoIGl0
Cj4gPiA+ID4gPiBpcyBpbXBvc3NpYmxlIHRvIGtub3cgd2hldGhlciB0aGUgbWFjIGlzIGEgaGFy
ZHdhcmUgb25lICh3aGljaAo+ID4gPiA+ID4gd2lsbCBiZSBwZXJzaXN0ZW50IGUuZy4gYWNyb3Nz
IHJlYm9vdHMpIG9yIGEgcmFuZG9tIG9uZS4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBZb3Ug
Y2FuIHN0aWxsIGdldCBhIHBlcnNpc3RlbnQgTUFDIHNldCBieSB0aGUgdmRwYSB0b29sLiBlLmcK
PiA+ID4gPgo+ID4gPiA+IHZkcGEgZGV2IGNvbmZpZyBzZXQgdmRwYTAgbWFjIDAwOjExOjIyOjMz
OjQ0OjU1Cj4gPiA+ID4KPiA+ID4gPiBJZiB5b3UgZG9uJ3QgdXNlIHZkcGEgdG9vbCwgdGhlIGRl
dmljZSBhc3NpZ25zIGEgcmFuZG9tIE1BQy4gVGhpcwo+ID4gPiA+IE1BQyBpcyB1c2VkIHRvIGZp
bHRlciBpbWNvbWluZyB1bmljYXN0IHRyYWZmaWMgKGRvbmUgaW4gYSBzdWJzZXF1ZW50Cj4gPiBw
YXRjaCkuCj4gPiA+Cj4gPiA+IFdlbGwgcHJldmlvdXNseSBkZXZpY2UgbGVhcm5lZCB0aGUgTUFD
IGZyb20gb3V0Z29pbmcgdHJhZmZpYyBhbmQgdXNlZAo+ID4gPiB0aGF0IGZvciB0aGUgZmlsdGVy
Lgo+ID4gCj4gPiBObywgd2FzIGlzIGFkZGVkIG9ubHkgaW4gdGhlIGxhc3Qgc2VyaWVzIHRoYXQg
UGFyYXYgc2VuZC4gQmVmb3JlIHRoYXQgdGhlCj4gPiBkZXZpY2UgZGlkIG5vdCBmaWx0ZXIgYW5k
IGZvcndhcmRlZCBhbnkgcGFja2V0IHRoYXQgd2FzIGZvcndhcmRlZCB0byBpdCBidXkKPiA+IHRo
ZSBlc3dpdGNoLgo+ID4gCj4gPiA+IElzIGNoYW5naW5nIHRoYXQgdG8gYSByYW5kb20gdmFsdWUg
cmVhbGx5IGFsbCB0aGF0IHVzZWZ1bCBhcyBhCj4gPiA+IGRlZmF1bHQ/ICBXaHkgbm90IGRvIHRo
ZSByYW5kb21pemF0aW9uIGluIHVzZXJzcGFjZT8KPiA+ID4KPiA+IAo+ID4gSSB0aGluayB3ZSB3
YW50IG1hbmFnZW1lbnQgZW50aXR5IHRvIHNldCB0aGUgTUFDLCB0aGF0J3MgdGhlIFZEUEEgdG9v
bC4KPiA+IFNvIGFzIHRoaW5ncyBhcmUgcmlnaHQgbm93ICh3aXRoIHRoZSBsYXN0IHNlcmllcyBh
cHBsaWVkKSwgdGhlIHZkcGEgdG9vbCBpcyB0aGUKPiA+IHRvb2wgdG8gYXNzaWduIE1BQyBhZGRy
ZXNzZXMgYW5kIGlmIGl0IGRvZXNuJ3QsIGEgZGV2aWNlIHJhbmRvbWx5IGdlbmVyYXRlZAo+ID4g
TUFDIGFwcGxpZXMuIEN1cnJlbnRseSBNQUMgYWRkcmVzc2VzIHNldCBieSBxZW11IGNvbW1hbmQg
bGluZSBhcmUKPiA+IGlnbm9yZWQgKHNldF9jb25maWcgaXMgbm90IGltcGxlbWVudGQpLiBXZSBj
YW4gYWxsb3cgdGhpcyBidXQgdGhpcyB3aWxsCj4gPiBvdmVycmlkZSB2ZHBhIHRvb2wgY29uZmln
dXJhdGlvbi4KPiAKPiBJIGJlbGlldmUgaXRzIGluY29ycmVjdCB0byBhbHdheXMgZG8gcmFuZG9t
IGdlbmVyYXRlZCBtYWMgYXMgb2YgdGhpcyBwYXRjaC4KPiBUaGlzIGlzIGJlY2F1c2UsIGRvaW5n
IHNvIGlnbm9yZXMgYW55IGFkbWluIGNvbmZpZyBkb25lIGJ5IHRoZSBzeXNhZG1pbiBvbiB0aGUg
c3dpdGNoIChvdnMgc2lkZSkgdXNpbmcgWzFdLgo+IAo+IFNvIGlmIHVzZXIgY2hvb3NlIHRvIGNv
bmZpZ3VyZSB1c2luZyBlc3dpdGNoIGNvbmZpZywgbWx4NV92bmV0IHRvIGhvbm9yIHRoYXQuCj4g
QW5kIGlmIHVzZXIgcHJlZmVycyB0byBvdmVycmlkZSBpcyB1c2luZyB2ZHBhIHRvb2wgb3Igc2V0
X2NvbmZpZyBmcm9tIFFFTVUgc2lkZSwgc28gYmUgaXQuCj4gSGVuY2UsIGluc3RlYWQgb2YgcmVw
b3J0aW5nIGFsbCB6ZXJvcywgbWx4NSBzaG91bGQgcXVlcnkgb3duIHZwb3J0IGNvbnRleHQgYW5k
IHB1Ymxpc2ggdGhhdCBtYWMgaW4gdGhlIGNvbmZpZyBsYXlvdXQgYW5kIHJ4IHN0ZWVyaW5nIHNp
ZGUuCj4gCj4gSWYgdXNlciBjaG9vc2UgdG8gb3ZlcnJpZGUgaXQsIGNvbmZpZyBsYXlvdXQgYW5k
IHJ4IHJ1bGVzIHdpbGwgaGF2ZSB0byB1cGRhdGVkIG9uIHN1Y2ggY29uZmlnLgo+IAo+IFsxXSBk
ZXZsaW5rIHBvcnQgZnVuY3Rpb24gc2V0IHBjaS8wMDAwOjAzOjAwLjAvPHBvcnRfaWRfb2Zfc2Yv
dmY+LyBod19hZGRyIDAwOjExOjIyOjMzOjQ0OjU1Cgp3ZWxsIGl0IGhhcyByZXBvcnRlZCBhbGwg
emVyb3MgdG8gbWVhbiAibGVhcm5pbmcgYnJpZGdlIiBmb3IgYQpzbyB3aGlsZSBJIHN1c3BlY3Qg
Y2hhbmdpbmcgdGhhdCBpcyBhbiBBQkkgY2hhbmdlLCB0aG91Z2gKYSBtaW5vciBvbmUgLi4uCgpJ
ZiB5b3UgZG8gY2hhbmdlIGl0IHBsZWFzZSBhZGQgc29tZSBvdGhlciB3YXkgdG8gZmluZCBvdXQK
d2hldGhlciBpdCBzdGlsbCBsZWFybnMgZnJvbSBvdXRnb2luZyB0cmFmZmljCihpZSB3aGV0aGVy
IG1hYyBzcG9vZmluZyBpcyBlbmFibGVkKS4KCi0tIApNU1QKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
