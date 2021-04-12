Return-Path: <SRS0=TAdK=JJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C7CC433ED
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 09:10:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18A9661207
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 09:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A9661207
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B6B71403DD;
	Mon, 12 Apr 2021 09:10:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3ycWA8oR0Pxb; Mon, 12 Apr 2021 09:10:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0EC4840389;
	Mon, 12 Apr 2021 09:10:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E44A5C000C;
	Mon, 12 Apr 2021 09:10:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D350C000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 09:10:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3A2556061A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 09:10:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zxy_oHXtF5-e
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 09:10:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 39276605CB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 09:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618218603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kyicAu7oSAEk0C9a5jN90ftzS5kBZ/R9XW19N/Po9Jw=;
 b=NVZDNrawnIEjHMnt9LMpPWFUSWilMsmfkhgaQ3FLuQnICs8BH/mygW15TkrTzzenbtJLZb
 Owg5Kh4WnQU8P6AwhV7ja/5oKQIhJxUy5kf79JftRRQpavukQUCucsj9BOkzQkYt5NDWHA
 87pipBUQBs4tCVPFsUGs4sihLwUYss8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-DvunBINXOY6fnbG6djkLjA-1; Mon, 12 Apr 2021 05:09:59 -0400
X-MC-Unique: DvunBINXOY6fnbG6djkLjA-1
Received: by mail-wr1-f71.google.com with SMTP id b4so2731658wrq.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 02:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=kyicAu7oSAEk0C9a5jN90ftzS5kBZ/R9XW19N/Po9Jw=;
 b=UBnNIGdORZRXVgpFIomfl/4lExlA4KV6GyxtHJSH7liVPTQUx+7FqwWmFPP2zy/a8U
 5lQyCiR76GEudeCCGAeybnRQhO3zN+HukKN2i6wPyb0W/ipItaQXAV8t3UOMTjEWyWov
 MGDjcpg8BUubvBY7U+4uRik2HVD7aVKYaiVDo5vHEnfjLaeGFpj1zViOjENUpyOiCTpw
 U0NUHDNdAPhfSQ0PcgaHb9ao5QK8kldyJVJ6Nl7KV8z+zD3YtjIVcKMm+mIN3GdlRrw1
 q39P8rUZsY25tSApSfWptAuMFbneSLtVfpomqLsVH5VSZ0aYTAzFYWOHn9e+ejVApVZB
 SpAQ==
X-Gm-Message-State: AOAM530uJKoDTUrh773hhWBHLLz5U+0uRfabazJKY4rKu0J88vL38Uw7
 5AgvU8vXnxMCNFL+gRXJrdp264P2uftGF0QZMyZe7yzrCq9H9vs86HEtjN/3YHJmME81KkGnH7K
 RGTXeT9rJW9/30MLb+BQ5bnW8dJ/p1OF4yYhGAS6MOQ==
X-Received: by 2002:a5d:6242:: with SMTP id m2mr30112995wrv.384.1618218598382; 
 Mon, 12 Apr 2021 02:09:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZzSRbut/AX4w/Z5NhgIRjmTIwNxBhovmSFPqcLv7H3F7+4A+7w4uyjzxQf5ifybjKSZNlgg==
X-Received: by 2002:a5d:6242:: with SMTP id m2mr30112985wrv.384.1618218598234; 
 Mon, 12 Apr 2021 02:09:58 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
 by smtp.gmail.com with ESMTPSA id u2sm17041666wmm.5.2021.04.12.02.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Apr 2021 02:09:57 -0700 (PDT)
Date: Mon, 12 Apr 2021 05:09:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH] vdpa: mandate 1.0 device
Message-ID: <20210412050730-mutt-send-email-mst@kernel.org>
References: <20210408082648.20145-1-jasowang@redhat.com>
 <20210408115834-mutt-send-email-mst@kernel.org>
 <a6a4ab68-c958-7266-c67c-142960222b67@redhat.com>
 <20210409115343-mutt-send-email-mst@kernel.org>
 <42891807-cb24-5352-f8cb-798e9d1a1854@redhat.com>
MIME-Version: 1.0
In-Reply-To: <42891807-cb24-5352-f8cb-798e9d1a1854@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: elic@nvidia.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

T24gTW9uLCBBcHIgMTIsIDIwMjEgYXQgMDI6MzU6MDdQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMS80LzEwIOS4iuWNiDEyOjA0LCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ
6YGTOgo+ID4gT24gRnJpLCBBcHIgMDksIDIwMjEgYXQgMTI6NDc6NTVQTSArMDgwMCwgSmFzb24g
V2FuZyB3cm90ZToKPiA+ID4g5ZyoIDIwMjEvNC84IOS4i+WNiDExOjU5LCBNaWNoYWVsIFMuIFRz
aXJraW4g5YaZ6YGTOgo+ID4gPiA+IE9uIFRodSwgQXByIDA4LCAyMDIxIGF0IDA0OjI2OjQ4UE0g
KzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiBUaGlzIHBhdGNoIG1hbmRhdGVzIDEu
MCBmb3IgdkRQQSBkZXZpY2VzLiBUaGUgZ29hbCBpcyB0byBoYXZlIHRoZQo+ID4gPiA+ID4gc2Vt
YW50aWMgb2Ygbm9ybWF0aXZlIHN0YXRlbWVudCBpbiB0aGUgdmlydGlvIHNwZWMgYW5kIGVsaW1p
bmF0ZSB0aGUKPiA+ID4gPiA+IGJ1cmRlbiBvZiB0cmFuc2l0aW9uYWwgZGV2aWNlIGZvciBib3Ro
IHZEUEEgYnVzIGFuZCB2RFBBIHBhcmVudC4KPiA+ID4gPiA+IAo+ID4gPiA+ID4gdUFQSSBzZWVt
cyBmaW5lIHNpbmNlIGFsbCB0aGUgdkRQQSBwYXJlbnQgbWFuZGF0ZXMKPiA+ID4gPiA+IFZJUlRJ
T19GX0FDQ0VTU19QTEFURk9STSB3aGljaCBpbXBsaWVzIDEuMCBkZXZpY2VzLgo+ID4gPiA+ID4g
Cj4gPiA+ID4gPiBGb3IgbGVnYWN5IGd1ZXN0cywgaXQgY2FuIHN0aWxsIHdvcmsgc2luY2UgUWVt
dSB3aWxsIG1lZGlhdGUgd2hlbgo+ID4gPiA+ID4gbmVjZXNzYXJ5IChlLmcgZG9pbmcgdGhlIGVu
ZGlhbiBjb252ZXJzaW9uKS4KPiA+ID4gPiA+IAo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSmFz
b24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiA+ID4gPiBIbW0uIElmIHdlIGRvIHRoaXMs
IGRvbid0IHdlIHN0aWxsIGhhdmUgYSBwcm9ibGVtIHdpdGgKPiA+ID4gPiBsZWdhY3kgZHJpdmVy
cyB3aGljaCBkb24ndCBhY2sgMS4wPwo+ID4gPiAKPiA+ID4gWWVzLCBidXQgaXQncyBub3Qgc29t
ZXRoaW5nIHRoYXQgaXMgaW50cm9kdWNlZCBpbiB0aGlzIGNvbW1pdC4gVGhlIGxlZ2FjeQo+ID4g
PiBkcml2ZXIgbmV2ZXIgd29yayAuLi4KPiA+IE15IHBvaW50IGlzIHRoaXMgbmVpdGhlciBmaXhl
cyBvciBwcmV2ZW50cyB0aGlzLgo+ID4gCj4gPiBTbyBteSBzdWdnZXN0aW9uIGlzIHRvIGZpbmFs
bHkgYWRkIGlvY3RscyBhbG9uZyB0aGUgbGluZXMKPiA+IG9mIFBST1RPQ09MX0ZFQVRVUkVTIG9m
IHZob3N0LXVzZXIuCj4gPiAKPiA+IFRoZW4gdGhhdCBvbmUgY2FuIGhhdmUgYml0cyBmb3IgbGVn
YWN5IGxlLCBsZWdhY3kgYmUgYW5kIG1vZGVybi4KPiA+IAo+ID4gQlRXIEkgbG9va2VkIGF0IHZo
b3N0LXVzZXIgYW5kIGl0IGRvZXMgbm90IGxvb2sgbGlrZSB0aGF0Cj4gPiBoYXMgYSBzb2x1dGlv
biBmb3IgdGhpcyBwcm9ibGVtIGVpdGhlciwgcmlnaHQ/Cj4gCj4gCj4gUmlnaHQuCj4gCj4gCj4g
PiAKPiA+IAo+ID4gPiA+IE5vdGUgMS4wIGFmZmVjdHMgcmluZyBlbmRpYW5uZXNzIHdoaWNoIGlz
IG5vdCBtZWRpYXRlZCBpbiBRRU1VCj4gPiA+ID4gc28gUUVNVSBjYW4ndCBwcmV0ZW5kIHRvIGRl
dmljZSBndWVzdCBpcyAxLjAuCj4gPiA+IAo+ID4gPiBSaWdodCwgSSBwbGFuIHRvIHNlbmQgcGF0
Y2hlcyB0byBkbyBtZWRpYXRpb24gaW4gdGhlIFFlbXUgdG8gdW5icmVhayBsZWdhY3kKPiA+ID4g
ZHJpdmVycy4KPiA+ID4gCj4gPiA+IFRoYW5rcwo+ID4gSSBmcmFua2x5IHRoaW5rIHdlJ2xsIG5l
ZWQgUFJPVE9DT0xfRkVBVFVSRVMgYW55d2F5LCBpdCdzIHRvbyB1c2VmdWwgLi4uCj4gPiBzbyB3
aHkgbm90IHRlYWNoIGRyaXZlcnMgYWJvdXQgaXQgYW5kIGJlIGRvbmUgd2l0aCBpdD8gWW91IGNh
bid0IGVtdWxhdGUKPiA+IGxlZ2FjeSBvbiBtb2Rlcm4gaW4gYSBjcm9zcyBlbmRpYW4gc2l0dWF0
aW9uIGJlY2F1c2Ugb2YgdnJpbmcKPiA+IGVuZGlhbi1uZXNzIC4uLgo+IAo+IAo+IFNvIHRoZSBw
cm9ibGVtIHN0aWxsLiBUaGlzIGNhbiBvbmx5IHdvcmsgd2hlbiB0aGUgaGFyZHdhcmUgY2FuIHN1
cHBvcnQKPiBsZWdhY3kgdnJpbmcgZW5kaWFuLW5lc3MuCj4gCj4gQ29uc2lkZXI6Cj4gCj4gMSkg
dGhlIGxlYWdjeSBkcml2ZXIgc3VwcG9ydCBpcyBub24tbm9ybWF0aXZlIGluIHRoZSBzcGVjCj4g
Mikgc3VwcG9ydCBhIHRyYW5zaXRpb25hbCBkZXZpY2UgaW4gdGhlIGtlbnJlbCBtYXkgcmVxdWly
ZXMgdGhlIGhhcmR3YXJlCj4gc3VwcG9ydCBhbmQgYSBidXJkZW4gb2Yga2VybmVsIGNvZGVzCj4g
Cj4gSSdkIHJhdGhlciBzaW1wbHkgZHJvcCB0aGUgbGVnYWN5IGRyaXZlciBzdXBwb3J0CgoKTXkg
cG9pbnQgaXMgdGhpcyBwYXRjaCBkb2VzIG5vdCBkcm9wIGxlZ2FjeSBzdXBwb3J0LiBJdCBtZXJl
bHkgbWFuZGF0ZXMKbW9kZXJuIHN1cHBvcnQuCgo+IHRvIGhhdmUgYSBzaW1wbGUgYW5kIGVhc3kK
PiBhYnN0YXJjdGlvbiBpbiB0aGUga2VucmVsLiBGb3IgbGVnYWN5IGRyaXZlciBpbiB0aGUgZ3Vl
c3QsIGh5cGVydmlzb3IgaXMgaW4KPiBjaGFyZ2Ugb2YgdGhlIG1lZGlhdGlvbjoKPiAKPiAxKSBj
b25maWcgc3BhY2UgYWNjZXNzIGVuZGlhbiBjb252ZXJzaW9uCj4gMikgdXNpbmcgc2hhZG93IHZp
cnRxdWV1ZSB0byBjaGFuZ2UgdGhlIGVuZGlhbiBpbiB0aGUgdnJpbmcKPiAKPiBUaGFua3MKCkkn
ZCBsaWtlIHRvIGF2b2lkIHNoYWRvdyB2aXJ0cXVldWUgaGFja3MgaWYgYXQgYWxsIHBvc3NpYmxl
LgpMYXN0IEkgY2hlY2tlZCBwZXJmb3JtYW5jZSB3YXNuJ3QgbXVjaCBiZXR0ZXIgdGhhbiBqdXN0
IGVtdWxhdGluZwp2aXJ0aW8gaW4gc29mdHdhcmUuCgo+IAo+ID4gCj4gPiAKPiA+ID4gPiAKPiA+
ID4gPiAKPiA+ID4gPiAKPiA+ID4gPiAKPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4gICAgaW5jbHVk
ZS9saW51eC92ZHBhLmggfCA2ICsrKysrKwo+ID4gPiA+ID4gICAgMSBmaWxlIGNoYW5nZWQsIDYg
aW5zZXJ0aW9ucygrKQo+ID4gPiA+ID4gCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC92ZHBhLmggYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+ID4gPiA+ID4gaW5kZXggMGZlZmVi
OTc2ODc3Li5jZmRlNGVjOTk5YjQgMTAwNjQ0Cj4gPiA+ID4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4
L3ZkcGEuaAo+ID4gPiA+ID4gKysrIGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPiA+ID4gPiA+IEBA
IC02LDYgKzYsNyBAQAo+ID4gPiA+ID4gICAgI2luY2x1ZGUgPGxpbnV4L2RldmljZS5oPgo+ID4g
PiA+ID4gICAgI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPgo+ID4gPiA+ID4gICAgI2luY2x1
ZGUgPGxpbnV4L3Zob3N0X2lvdGxiLmg+Cj4gPiA+ID4gPiArI2luY2x1ZGUgPHVhcGkvbGludXgv
dmlydGlvX2NvbmZpZy5oPgo+ID4gPiA+ID4gICAgLyoqCj4gPiA+ID4gPiAgICAgKiB2RFBBIGNh
bGxiYWNrIGRlZmluaXRpb24uCj4gPiA+ID4gPiBAQCAtMzE3LDYgKzMxOCwxMSBAQCBzdGF0aWMg
aW5saW5lIGludCB2ZHBhX3NldF9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHU2
NCBmZWF0dXJlcykKPiA+ID4gPiA+ICAgIHsKPiA+ID4gPiA+ICAgICAgICAgICAgY29uc3Qgc3Ry
dWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRldi0+Y29uZmlnOwo+ID4gPiA+ID4gKyAgICAg
ICAgLyogTWFuZGF0aW5nIDEuMCB0byBoYXZlIHNlbWFudGljcyBvZiBub3JtYXRpdmUgc3RhdGVt
ZW50cyBpbgo+ID4gPiA+ID4gKyAgICAgICAgICogdGhlIHNwZWMuICovCj4gPiA+ID4gPiArICAg
ICAgICBpZiAoIShmZWF0dXJlcyAmIEJJVF9VTEwoVklSVElPX0ZfVkVSU0lPTl8xKSkpCj4gPiA+
ID4gPiArCQlyZXR1cm4gLUVJTlZBTDsKPiA+ID4gPiA+ICsKPiA+ID4gPiA+ICAgIAl2ZGV2LT5m
ZWF0dXJlc192YWxpZCA9IHRydWU7Cj4gPiA+ID4gPiAgICAgICAgICAgIHJldHVybiBvcHMtPnNl
dF9mZWF0dXJlcyh2ZGV2LCBmZWF0dXJlcyk7Cj4gPiA+ID4gPiAgICB9Cj4gPiA+ID4gPiAtLSAK
PiA+ID4gPiA+IDIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
