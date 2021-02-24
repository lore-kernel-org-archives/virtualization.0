Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D193AC433E0
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 07:18:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2371164E79
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 07:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2371164E79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE73C4EBD3;
	Wed, 24 Feb 2021 07:18:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HqTeJA5mX06u; Wed, 24 Feb 2021 07:18:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0FE884EBCB;
	Wed, 24 Feb 2021 07:18:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D81BEC000B;
	Wed, 24 Feb 2021 07:18:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3AC1C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 07:18:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 914014EBCB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 07:18:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9yNf8lhBRQOn
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 07:18:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3520D4EB81
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 07:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614151086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cUD9i8imHS99V2QE+X6CmyOUFv11LLo8e+TKwIxsJK4=;
 b=Gd66Aowr3mO/+2x+ZYqnXLej+SsQsShZUZTwyxX+6hEsiJDUjg/nu1dcHM3PF3mGXYe4We
 wHkoFKqMH0Uz2J3dXFXDIeqH2SrMaHdlB54geXaYMxIok1ab7eQs9P8nUlpsH09xSBENs3
 pUNHvz3rz8WSIB0kI1o858R1Gi/cEPw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-hOiYWiQBPTO-_HhNoXjFjA-1; Wed, 24 Feb 2021 02:18:04 -0500
X-MC-Unique: hOiYWiQBPTO-_HhNoXjFjA-1
Received: by mail-wr1-f69.google.com with SMTP id e29so630555wra.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 23:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=cUD9i8imHS99V2QE+X6CmyOUFv11LLo8e+TKwIxsJK4=;
 b=P14xtfkjLMW6JZJcQNL/KW3/t4fX24Qx+A4+nyOB7eSSUl1FzRyyIJ/bIzxts/HX5d
 HWX01xFC8PcD87lN24w0xSYWt0uhDUGoB/YX4I2E1IqGkvdCWh0va4dkULDBMe2Mb1LD
 dmZSeXf8wXGVLgFUuTZMdis+a4SzsqK0aUMG2BIiCQIV8bgKNtxIwBo58sSM4LR/90FO
 LVa7Fgbtp0v11BzT2RHfB4FdDcSrNJbQg0etX1p33IhW1bzf+RmRlISWAghF3LDbyNDg
 tNxrP0xUOo2GzPr7qaQ389TkOKL4hh2ChZz6L33MJbxSW+GhKu/i3BYI4NfwcGVUc191
 4u5g==
X-Gm-Message-State: AOAM530IVmP5tk9fl7jfFSgUzlbgnXdn2LtSInTvjwGl7ZuEE1JZR46+
 H5jz9Vhm0xKomexdyhTofxf1L0V/K1wZJd2Zpa2bHmZ19f2eDgQMrlIbM/Hyns0bJYOA215vJKl
 kS7oSq20Cpq18UMoG92VbRz4ifVVN99FzZ6F+yKPfgw==
X-Received: by 2002:adf:a2c2:: with SMTP id t2mr29717906wra.47.1614151083002; 
 Tue, 23 Feb 2021 23:18:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx36dvoVgsKzOY2Q0IHxAEQncvNYFTe0HuoFP02ym271+rmQupV6f2qRhf/njQ/cCS+a70DPA==
X-Received: by 2002:adf:a2c2:: with SMTP id t2mr29717890wra.47.1614151082811; 
 Tue, 23 Feb 2021 23:18:02 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id w11sm1800313wru.3.2021.02.23.23.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 23:18:02 -0800 (PST)
Date: Wed, 24 Feb 2021 02:17:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
Message-ID: <20210224021222-mutt-send-email-mst@kernel.org>
References: <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <20210222023040-mutt-send-email-mst@kernel.org>
 <22fe5923-635b-59f0-7643-2fd5876937c2@oracle.com>
 <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
 <20210223082536-mutt-send-email-mst@kernel.org>
 <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <20210224000057-mutt-send-email-mst@kernel.org>
 <0559fd8c-ff44-cb7a-8a74-71976dd2ee33@redhat.com>
 <20210224014232-mutt-send-email-mst@kernel.org>
 <ce6b0380-bc4c-bcb8-db82-2605e819702c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ce6b0380-bc4c-bcb8-db82-2605e819702c@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, netdev@vger.kernel.org, elic@nvidia.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

T24gV2VkLCBGZWIgMjQsIDIwMjEgYXQgMDI6NTM6MDhQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIxLzIvMjQgMjo0NiDkuIvljYgsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90
ZToKPiA+IE9uIFdlZCwgRmViIDI0LCAyMDIxIGF0IDAyOjA0OjM2UE0gKzA4MDAsIEphc29uIFdh
bmcgd3JvdGU6Cj4gPiA+IE9uIDIwMjEvMi8yNCAxOjA0IOS4i+WNiCwgTWljaGFlbCBTLiBUc2ly
a2luIHdyb3RlOgo+ID4gPiA+IE9uIFR1ZSwgRmViIDIzLCAyMDIxIGF0IDExOjM1OjU3QU0gLTA4
MDAsIFNpLVdlaSBMaXUgd3JvdGU6Cj4gPiA+ID4gPiBPbiAyLzIzLzIwMjEgNToyNiBBTSwgTWlj
aGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4gPiA+ID4gPiBPbiBUdWUsIEZlYiAyMywgMjAyMSBh
dCAxMDowMzo1N0FNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+IE9uIDIw
MjEvMi8yMyA5OjEyIOS4iuWNiCwgU2ktV2VpIExpdSB3cm90ZToKPiA+ID4gPiA+ID4gPiA+IE9u
IDIvMjEvMjAyMSAxMTozNCBQTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4gPiA+ID4g
PiA+ID4gPiBPbiBNb24sIEZlYiAyMiwgMjAyMSBhdCAxMjoxNDoxN1BNICswODAwLCBKYXNvbiBX
YW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+IE9uIDIwMjEvMi8xOSA3OjU0IOS4i+WNiCwg
U2ktV2VpIExpdSB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IENvbW1pdCA0NTI2MzlhNjRh
ZDggKCJ2ZHBhOiBtYWtlIHN1cmUgc2V0X2ZlYXR1cmVzIGlzIGludm9rZWQKPiA+ID4gPiA+ID4g
PiA+ID4gPiA+IGZvciBsZWdhY3kiKSBtYWRlIGFuIGV4Y2VwdGlvbiBmb3IgbGVnYWN5IGd1ZXN0
cyB0byByZXNldAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gZmVhdHVyZXMgdG8gMCwgd2hlbiBjb25m
aWcgc3BhY2UgaXMgYWNjZXNzZWQgYmVmb3JlIGZlYXR1cmVzCj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiBhcmUgc2V0LiBXZSBzaG91bGQgcmVsaWV2ZSB0aGUgdmVyaWZ5X21pbl9mZWF0dXJlcygpIGNo
ZWNrCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBhbmQgYWxsb3cgZmVhdHVyZXMgcmVzZXQgdG8gMCBm
b3IgdGhpcyBjYXNlLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiBJdCdzIHdvcnRoIG5vdGluZyB0aGF0IG5vdCBqdXN0IGxlZ2FjeSBndWVzdHMgY291bGQgYWNj
ZXNzCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBjb25maWcgc3BhY2UgYmVmb3JlIGZlYXR1cmVzIGFy
ZSBzZXQuIEZvciBpbnN0YW5jZSwgd2hlbgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gZmVhdHVyZSBW
SVJUSU9fTkVUX0ZfTVRVIGlzIGFkdmVydGlzZWQgc29tZSBtb2Rlcm4gZHJpdmVyCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiB3aWxsIHRyeSB0byBhY2Nlc3MgYW5kIHZhbGlkYXRlIHRoZSBNVFUgcHJl
c2VudCBpbiB0aGUgY29uZmlnCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBzcGFjZSBiZWZvcmUgdmly
dGlvIGZlYXR1cmVzIGFyZSBzZXQuCj4gPiA+ID4gPiA+ID4gPiA+ID4gVGhpcyBsb29rcyBsaWtl
IGEgc3BlYyB2aW9sYXRpb246Cj4gPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+
ID4gIgo+ID4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiA+IFRoZSBmb2xsb3dp
bmcgZHJpdmVyLXJlYWQtb25seSBmaWVsZCwgbXR1IG9ubHkgZXhpc3RzIGlmCj4gPiA+ID4gPiA+
ID4gPiA+ID4gVklSVElPX05FVF9GX01UVSBpcwo+ID4gPiA+ID4gPiA+ID4gPiA+IHNldC4KPiA+
ID4gPiA+ID4gPiA+ID4gPiBUaGlzIGZpZWxkIHNwZWNpZmllcyB0aGUgbWF4aW11bSBNVFUgZm9y
IHRoZSBkcml2ZXIgdG8gdXNlLgo+ID4gPiA+ID4gPiA+ID4gPiA+ICIKPiA+ID4gPiA+ID4gPiA+
ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gPiBEbyB3ZSByZWFsbHkgd2FudCB0byB3b3JrYXJvdW5k
IHRoaXM/Cj4gPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+ID4gVGhhbmtzCj4g
PiA+ID4gPiA+ID4gPiA+IEFuZCBhbHNvOgo+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4g
PiA+ID4gVGhlIGRyaXZlciBNVVNUIGZvbGxvdyB0aGlzIHNlcXVlbmNlIHRvIGluaXRpYWxpemUg
YSBkZXZpY2U6Cj4gPiA+ID4gPiA+ID4gPiA+IDEuIFJlc2V0IHRoZSBkZXZpY2UuCj4gPiA+ID4g
PiA+ID4gPiA+IDIuIFNldCB0aGUgQUNLTk9XTEVER0Ugc3RhdHVzIGJpdDogdGhlIGd1ZXN0IE9T
IGhhcyBub3RpY2VkIHRoZSBkZXZpY2UuCj4gPiA+ID4gPiA+ID4gPiA+IDMuIFNldCB0aGUgRFJJ
VkVSIHN0YXR1cyBiaXQ6IHRoZSBndWVzdCBPUyBrbm93cyBob3cgdG8gZHJpdmUgdGhlCj4gPiA+
ID4gPiA+ID4gPiA+IGRldmljZS4KPiA+ID4gPiA+ID4gPiA+ID4gNC4gUmVhZCBkZXZpY2UgZmVh
dHVyZSBiaXRzLCBhbmQgd3JpdGUgdGhlIHN1YnNldCBvZiBmZWF0dXJlIGJpdHMKPiA+ID4gPiA+
ID4gPiA+ID4gdW5kZXJzdG9vZCBieSB0aGUgT1MgYW5kIGRyaXZlciB0byB0aGUKPiA+ID4gPiA+
ID4gPiA+ID4gZGV2aWNlLiBEdXJpbmcgdGhpcyBzdGVwIHRoZSBkcml2ZXIgTUFZIHJlYWQgKGJ1
dCBNVVNUIE5PVCB3cml0ZSkKPiA+ID4gPiA+ID4gPiA+ID4gdGhlIGRldmljZS1zcGVjaWZpYyBj
b25maWd1cmF0aW9uCj4gPiA+ID4gPiA+ID4gPiA+IGZpZWxkcyB0byBjaGVjayB0aGF0IGl0IGNh
biBzdXBwb3J0IHRoZSBkZXZpY2UgYmVmb3JlIGFjY2VwdGluZyBpdC4KPiA+ID4gPiA+ID4gPiA+
ID4gNS4gU2V0IHRoZSBGRUFUVVJFU19PSyBzdGF0dXMgYml0LiBUaGUgZHJpdmVyIE1VU1QgTk9U
IGFjY2VwdCBuZXcKPiA+ID4gPiA+ID4gPiA+ID4gZmVhdHVyZSBiaXRzIGFmdGVyIHRoaXMgc3Rl
cC4KPiA+ID4gPiA+ID4gPiA+ID4gNi4gUmUtcmVhZCBkZXZpY2Ugc3RhdHVzIHRvIGVuc3VyZSB0
aGUgRkVBVFVSRVNfT0sgYml0IGlzIHN0aWxsIHNldDoKPiA+ID4gPiA+ID4gPiA+ID4gb3RoZXJ3
aXNlLCB0aGUgZGV2aWNlIGRvZXMgbm90Cj4gPiA+ID4gPiA+ID4gPiA+IHN1cHBvcnQgb3VyIHN1
YnNldCBvZiBmZWF0dXJlcyBhbmQgdGhlIGRldmljZSBpcyB1bnVzYWJsZS4KPiA+ID4gPiA+ID4g
PiA+ID4gNy4gUGVyZm9ybSBkZXZpY2Utc3BlY2lmaWMgc2V0dXAsIGluY2x1ZGluZyBkaXNjb3Zl
cnkgb2YgdmlydHF1ZXVlcwo+ID4gPiA+ID4gPiA+ID4gPiBmb3IgdGhlIGRldmljZSwgb3B0aW9u
YWwgcGVyLWJ1cyBzZXR1cCwKPiA+ID4gPiA+ID4gPiA+ID4gcmVhZGluZyBhbmQgcG9zc2libHkg
d3JpdGluZyB0aGUgZGV2aWNl4oCZcyB2aXJ0aW8gY29uZmlndXJhdGlvbgo+ID4gPiA+ID4gPiA+
ID4gPiBzcGFjZSwgYW5kIHBvcHVsYXRpb24gb2YgdmlydHF1ZXVlcy4KPiA+ID4gPiA+ID4gPiA+
ID4gOC4gU2V0IHRoZSBEUklWRVJfT0sgc3RhdHVzIGJpdC4gQXQgdGhpcyBwb2ludCB0aGUgZGV2
aWNlIGlzIOKAnGxpdmXigJ0uCj4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiAK
PiA+ID4gPiA+ID4gPiA+ID4gc28gYWNjZXNzaW5nIGNvbmZpZyBzcGFjZSBiZWZvcmUgRkVBVFVS
RVNfT0sgaXMgYSBzcGVjIHZpb2xhdGlvbiwgcmlnaHQ/Cj4gPiA+ID4gPiA+ID4gPiBJdCBpcywg
YnV0IGl0J3Mgbm90IHJlbGV2YW50IHRvIHdoYXQgdGhpcyBjb21taXQgdHJpZXMgdG8gYWRkcmVz
cy4gSQo+ID4gPiA+ID4gPiA+ID4gdGhvdWdodCB0aGUgbGVnYWN5IGd1ZXN0IHN0aWxsIG5lZWRz
IHRvIGJlIHN1cHBvcnRlZC4KPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gSGF2aW5n
IHNhaWQsIGEgc2VwYXJhdGUgcGF0Y2ggaGFzIHRvIGJlIHBvc3RlZCB0byBmaXggdGhlIGd1ZXN0
IGRyaXZlcgo+ID4gPiA+ID4gPiA+ID4gaXNzdWUgd2hlcmUgdGhpcyBkaXNjcmVwYW5jeSBpcyBp
bnRyb2R1Y2VkIHRvIHZpcnRuZXRfdmFsaWRhdGUoKSAoc2luY2UKPiA+ID4gPiA+ID4gPiA+IGNv
bW1pdCBmZTM2Y2JlMDY3KS4gQnV0IGl0J3Mgbm90IHRlY2huaWNhbGx5IHJlbGF0ZWQgdG8gdGhp
cyBwYXRjaC4KPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gLVNpd2VpCj4gPiA+ID4g
PiA+ID4gSSB0aGluayBpdCdzIGEgYnVnIHRvIHJlYWQgY29uZmlnIHNwYWNlIGluIHZhbGlkYXRl
LCB3ZSBzaG91bGQgbW92ZSBpdCB0bwo+ID4gPiA+ID4gPiA+IHZpcnRuZXRfcHJvYmUoKS4KPiA+
ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiA+ID4gSSB0YWtlIGl0IGJh
Y2ssIHJlYWRpbmcgYnV0IG5vdCB3cml0aW5nIHNlZW1zIHRvIGJlIGV4cGxpY2l0bHkgYWxsb3dl
ZCBieSBzcGVjLgo+ID4gPiA+ID4gPiBTbyBvdXIgd2F5IHRvIGRldGVjdCBhIGxlZ2FjeSBndWVz
dCBpcyBib2d1cywgbmVlZCB0byB0aGluayB3aGF0IGlzCj4gPiA+ID4gPiA+IHRoZSBiZXN0IHdh
eSB0byBoYW5kbGUgdGhpcy4KPiA+ID4gPiA+IFRoZW4gbWF5YmUgcmV2ZXJ0IGNvbW1pdCBmZTM2
Y2JlMDY3IGFuZCBmcmllbmRzLCBhbmQgaGF2ZSBRRU1VIGRldGVjdCBsZWdhY3kKPiA+ID4gPiA+
IGd1ZXN0PyBTdXBwb3NlZGx5IG9ubHkgY29uZmlnIHNwYWNlIHdyaXRlIGFjY2VzcyBuZWVkcyB0
byBiZSBndWFyZGVkIGJlZm9yZQo+ID4gPiA+ID4gc2V0dGluZyBGRUFUVVJFU19PSy4KPiA+ID4g
PiA+IAo+ID4gPiA+ID4gLVNpd2llCj4gPiA+ID4gRGV0ZWN0aW5nIGl0IGlzbid0IGVub3VnaCB0
aG91Z2gsIHdlIHdpbGwgbmVlZCBhIG5ldyBpb2N0bCB0byBub3RpZnkKPiA+ID4gPiB0aGUga2Vy
bmVsIHRoYXQgaXQncyBhIGxlZ2FjeSBndWVzdC4gVWdoIDooCj4gPiA+IAo+ID4gPiBJJ20gbm90
IHN1cmUgSSBnZXQgdGhpcywgaG93IGNhbiB3ZSBrbm93IGlmIHRoZXJlJ3MgYSBsZWdhY3kgZHJp
dmVyIGJlZm9yZQo+ID4gPiBzZXRfZmVhdHVyZXMoKT8KPiA+IHFlbXUga25vd3MgZm9yIHN1cmUu
IEl0IGRvZXMgbm90IGNvbW11bmljYXRlIHRoaXMgaW5mb3JtYXRpb24gdG8gdGhlCj4gPiBrZXJu
ZWwgcmlnaHQgbm93IHVuZm9ydHVuYXRlbHkuCj4gCj4gCj4gSSBtYXkgbWlzcyBzb21ldGhpbmcs
IGJ1dCBJIHN0aWxsIGRvbid0IGdldCBob3cgdGhlIG5ldyBpb2N0bCBpcyBzdXBwb3NlZCB0bwo+
IHdvcmsuCj4gCj4gVGhhbmtzCgoKCkJhc2ljYWxseSBvbiBmaXJzdCBndWVzdCBhY2Nlc3MgUUVN
VSB3b3VsZCB0ZWxsIGtlcm5lbCB3aGV0aGVyCmd1ZXN0IGlzIHVzaW5nIHRoZSBsZWdhY3kgb3Ig
dGhlIG1vZGVybiBpbnRlcmZhY2UuCkUuZy4gdmlydGlvX3BjaV9jb25maWdfcmVhZC92aXJ0aW9f
cGNpX2NvbmZpZ193cml0ZSB3aWxsIGNhbGwgaW9jdGwoRU5BQkxFX0xFR0FDWSwgMSkKd2hpbGUg
dmlydGlvX3BjaV9jb21tb25fcmVhZCB3aWxsIGNhbGwgaW9jdGwoRU5BQkxFX0xFR0FDWSwgMCkK
Ck9yIG1heWJlIHdlIGp1c3QgYWRkIEdFVF9DT05GSUdfTU9ERVJOIGFuZCBHRVRfQ09ORklHX0xF
R0FDWSBhbmQKY2FsbCB0aGUgY29ycmVjdCBpb2N0bCAuLi4gdGhlcmUgYXJlIG1hbnkgd2F5cyB0
byBidWlsZCB0aGlzIEFQSS4KCj4gCj4gPiAKPiA+ID4gQW5kIEkgd29uZGVyIHdoYXQgd2lsbCBo
YXBlZW4gaWYgd2UganVzdCByZXZlcnQgdGhlIHNldF9mZWF0dXJlcygwKT8KPiA+ID4gCj4gPiA+
IFRoYW5rcwo+ID4gPiAKPiA+ID4gCj4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBSZWpl
Y3RpbmcgcmVzZXQgdG8gMAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gcHJlbWF0dXJlbHkgY2F1c2Vz
IGNvcnJlY3QgTVRVIGFuZCBsaW5rIHN0YXR1cyB1bmFibGUgdG8gbG9hZAo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gZm9yIHRoZSB2ZXJ5IGZpcnN0IGNvbmZpZyBzcGFjZSBhY2Nlc3MsIHJlbmRlcmlu
ZyBpc3N1ZXMgbGlrZQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gZ3Vlc3Qgc2hvd2luZyBpbmFjY3Vy
YXRlIE1UVSB2YWx1ZSwgb3IgZmFpbHVyZSB0byByZWplY3QKPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IG91dC1vZi1yYW5nZSBNVFUuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IEZpeGVzOiAxYTg2YjM3N2FhMjEgKCJ2ZHBhL21seDU6IEFkZCBWRFBBIGRyaXZlciBm
b3IKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHN1cHBvcnRlZCBtbHg1IGRldmljZXMiKQo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFj
bGUuY29tPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAg
ICDCoMKgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDE1ICstLS0tLS0tLS0t
LS0tLQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAgwqDCoCAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDE0IGRlbGV0aW9ucygtKQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5l
dC5jCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3Zu
ZXQuYwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gaW5kZXggN2MxZjc4OS4uNTQwZGQ2NyAxMDA2NDQK
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3Zu
ZXQuYwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21s
eDVfdm5ldC5jCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBAQCAtMTQ5MCwxNCArMTQ5MCw2IEBAIHN0
YXRpYyB1NjQKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IG1seDVfdmRwYV9nZXRfZmVhdHVyZXMoc3Ry
dWN0IHZkcGFfZGV2aWNlICp2ZGV2KQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAgwqDCoMKgwqDC
oMKgIHJldHVybiBtdmRldi0+bWx4X2ZlYXR1cmVzOwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAg
wqDCoCB9Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAtc3RhdGljIGludCB2ZXJpZnlfbWluX2ZlYXR1
cmVzKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHU2
NCBmZWF0dXJlcykKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IC17Cj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiAtwqDCoMKgIGlmICghKGZlYXR1cmVzICYgQklUX1VMTChWSVJUSU9fRl9BQ0NFU1NfUExBVEZP
Uk0pKSkKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVPUE5P
VFNVUFA7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAtCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAtwqDC
oMKgIHJldHVybiAwOwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gLX0KPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IC0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICAgIMKgwqAgc3RhdGljIGludCBzZXR1cF92aXJ0
cXVldWVzKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2KQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
ICAgwqDCoCB7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgICDCoMKgwqDCoMKgwqAgaW50IGVycjsK
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IEBAIC0xNTU4LDE4ICsxNTUwLDEzIEBAIHN0YXRpYyBpbnQK
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IG1seDVfdmRwYV9zZXRfZmVhdHVyZXMoc3RydWN0IHZkcGFf
ZGV2aWNlICp2ZGV2LCB1NjQKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGZlYXR1cmVzKQo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gICAgwqDCoCB7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgICDCoMKgwqDC
oMKgwqAgc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2ID0gdG9fbXZkZXYodmRldik7Cj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiAgICDCoMKgwqDCoMKgwqAgc3RydWN0IG1seDVfdmRwYV9uZXQgKm5k
ZXYgPSB0b19tbHg1X3ZkcGFfbmRldihtdmRldik7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAtwqDC
oMKgIGludCBlcnI7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgICDCoMKgwqDCoMKgwqAgcHJpbnRf
ZmVhdHVyZXMobXZkZXYsIGZlYXR1cmVzLCB0cnVlKTsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IC3C
oMKgwqAgZXJyID0gdmVyaWZ5X21pbl9mZWF0dXJlcyhtdmRldiwgZmVhdHVyZXMpOwo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gLcKgwqDCoCBpZiAoZXJyKQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gLcKg
wqDCoMKgwqDCoMKgIHJldHVybiBlcnI7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAtCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiAgICDCoMKgwqDCoMKgwqAgbmRldi0+bXZkZXYuYWN0dWFsX2ZlYXR1cmVz
ID0gZmVhdHVyZXMgJgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gbmRldi0+bXZkZXYubWx4X2ZlYXR1
cmVzOwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAgwqDCoMKgwqDCoMKgIG5kZXYtPmNvbmZpZy5t
dHUgPSBjcHVfdG9fbWx4NXZkcGExNihtdmRldiwgbmRldi0+bXR1KTsKPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ICAgIMKgwqDCoMKgwqDCoCBuZGV2LT5jb25maWcuc3RhdHVzIHw9IGNwdV90b19tbHg1
dmRwYTE2KG12ZGV2LAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gVklSVElPX05FVF9TX0xJTktfVVAp
Owo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gLcKgwqDCoCByZXR1cm4gZXJyOwo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gK8KgwqDCoCByZXR1cm4gMDsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICAgIMKgwqAg
fQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAgwqDCoCBzdGF0aWMgdm9pZCBtbHg1X3ZkcGFfc2V0
X2NvbmZpZ19jYihzdHJ1Y3QgdmRwYV9kZXZpY2UKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICp2ZGV2
LCBzdHJ1Y3QgdmRwYV9jYWxsYmFjayAqY2IpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
