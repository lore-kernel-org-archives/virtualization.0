Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A05FC433E0
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 09:25:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 052E264DE9
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 09:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 052E264DE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A4BB787026;
	Tue, 23 Feb 2021 09:25:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aGn7QAjUuA5N; Tue, 23 Feb 2021 09:25:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 03FA387016;
	Tue, 23 Feb 2021 09:25:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B38C8C000B;
	Tue, 23 Feb 2021 09:25:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A7F3C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 09:25:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 666E287026
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 09:25:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hFCCIFvBj9Bb
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 09:25:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 92EDE87016
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 09:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614072314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+RC4HKdCieSzE1GPP3nuYiwb9hCgiuXOjbDbgHSeYuQ=;
 b=WdICmBex27NjpNfmmyI3+2ys2w3Njj2WgMS5tRAzTHIxfk782gwbW9UI31FNO9NGQh0CE5
 h4mSCu0zcyE+G7ECMfLy1IN3AB27nwDk0si5dq3/u0BgtxUgvtfvFXrbj6r17PHILgMNhz
 bAYFxUGQTJyeAkayLURCuzlGfKR9z/Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-fQ-ae_22OHyIa1XstCkhGw-1; Tue, 23 Feb 2021 04:25:10 -0500
X-MC-Unique: fQ-ae_22OHyIa1XstCkhGw-1
Received: by mail-wm1-f71.google.com with SMTP id t15so516570wmj.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 01:25:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=+RC4HKdCieSzE1GPP3nuYiwb9hCgiuXOjbDbgHSeYuQ=;
 b=cNb1Ba5klQTunbBF2oezTOwMUs67qzhgOfVVKuR6YbeRzuoiW0UBFw7NpmPbHxs5Hl
 gMDDJMROncj2pUjhWo+yHF/e4dlnmD2hZfK6e+n2kZeUyO85ip4REY00PGBCC+eWG+Xd
 pS60GicQIED9Pf89p98JXY1iF1u5i1tMhxAhEX/tuQd7H463L8AfvrSdeJlw3M50J5ob
 oqxkH/cFWF0tz9WFeWShSN9a25D3pDvVAudsFX5wNTYk8Hc78zDZ73OaURMijsoS/sok
 P1K+i1niG7aEdRlOwwmrSfES2C3YSi/v9C1CIAV+j56w7XHRmrKbM85UEx9nEVjfx7wX
 uqtQ==
X-Gm-Message-State: AOAM5309g+x0QHyNU3iVsfrJYrqejNZU4O91TMUak7kBmjnRnNrZFbwC
 ehJashbuz2NI2wF9olI5s6+OTjPKg4e46ECneQvZFsk2tl0uGpLSCqESl03pwX1pQb6y8++KOe+
 stP65KYoFfAGBSijPfZZueWeg6HP7ZpA+Nfc/1IU6wA==
X-Received: by 2002:a1c:5419:: with SMTP id i25mr24758761wmb.166.1614072309011; 
 Tue, 23 Feb 2021 01:25:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxbWivNJ1jHNPfZXygVu+eudCK5iHdHVpEBEzm8ae6yMWWk75xprjTHIR+p+f5S+Nq1VlaorA==
X-Received: by 2002:a1c:5419:: with SMTP id i25mr24758746wmb.166.1614072308817; 
 Tue, 23 Feb 2021 01:25:08 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id a6sm2054052wmj.23.2021.02.23.01.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 01:25:07 -0800 (PST)
Date: Tue, 23 Feb 2021 04:25:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
Message-ID: <20210223041740-mutt-send-email-mst@kernel.org>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <ee31e93b-5fbb-1999-0e82-983d3e49ad1e@oracle.com>
MIME-Version: 1.0
In-Reply-To: <ee31e93b-5fbb-1999-0e82-983d3e49ad1e@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtio-dev@lists.oasis-open.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 elic@nvidia.com
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

T24gTW9uLCBGZWIgMjIsIDIwMjEgYXQgMDk6MDk6MjhBTSAtMDgwMCwgU2ktV2VpIExpdSB3cm90
ZToKPiAKPiAKPiBPbiAyLzIxLzIwMjEgODoxNCBQTSwgSmFzb24gV2FuZyB3cm90ZToKPiA+IAo+
ID4gT24gMjAyMS8yLzE5IDc6NTQg5LiL5Y2ILCBTaS1XZWkgTGl1IHdyb3RlOgo+ID4gPiBDb21t
aXQgNDUyNjM5YTY0YWQ4ICgidmRwYTogbWFrZSBzdXJlIHNldF9mZWF0dXJlcyBpcyBpbnZva2Vk
Cj4gPiA+IGZvciBsZWdhY3kiKSBtYWRlIGFuIGV4Y2VwdGlvbiBmb3IgbGVnYWN5IGd1ZXN0cyB0
byByZXNldAo+ID4gPiBmZWF0dXJlcyB0byAwLCB3aGVuIGNvbmZpZyBzcGFjZSBpcyBhY2Nlc3Nl
ZCBiZWZvcmUgZmVhdHVyZXMKPiA+ID4gYXJlIHNldC4gV2Ugc2hvdWxkIHJlbGlldmUgdGhlIHZl
cmlmeV9taW5fZmVhdHVyZXMoKSBjaGVjawo+ID4gPiBhbmQgYWxsb3cgZmVhdHVyZXMgcmVzZXQg
dG8gMCBmb3IgdGhpcyBjYXNlLgo+ID4gPiAKPiA+ID4gSXQncyB3b3J0aCBub3RpbmcgdGhhdCBu
b3QganVzdCBsZWdhY3kgZ3Vlc3RzIGNvdWxkIGFjY2Vzcwo+ID4gPiBjb25maWcgc3BhY2UgYmVm
b3JlIGZlYXR1cmVzIGFyZSBzZXQuIEZvciBpbnN0YW5jZSwgd2hlbgo+ID4gPiBmZWF0dXJlIFZJ
UlRJT19ORVRfRl9NVFUgaXMgYWR2ZXJ0aXNlZCBzb21lIG1vZGVybiBkcml2ZXIKPiA+ID4gd2ls
bCB0cnkgdG8gYWNjZXNzIGFuZCB2YWxpZGF0ZSB0aGUgTVRVIHByZXNlbnQgaW4gdGhlIGNvbmZp
Zwo+ID4gPiBzcGFjZSBiZWZvcmUgdmlydGlvIGZlYXR1cmVzIGFyZSBzZXQuCj4gPiAKPiA+IAo+
ID4gVGhpcyBsb29rcyBsaWtlIGEgc3BlYyB2aW9sYXRpb246Cj4gPiAKPiA+ICIKPiA+IAo+ID4g
VGhlIGZvbGxvd2luZyBkcml2ZXItcmVhZC1vbmx5IGZpZWxkLCBtdHUgb25seSBleGlzdHMgaWYK
PiA+IFZJUlRJT19ORVRfRl9NVFUgaXMgc2V0LiBUaGlzIGZpZWxkIHNwZWNpZmllcyB0aGUgbWF4
aW11bSBNVFUgZm9yIHRoZQo+ID4gZHJpdmVyIHRvIHVzZS4KPiA+ICIKPiA+IAo+ID4gRG8gd2Ug
cmVhbGx5IHdhbnQgdG8gd29ya2Fyb3VuZCB0aGlzPwo+IAo+IElzbid0IHRoZSBjb21taXQgNDUy
NjM5YTY0YWQ4IGl0c2VsZiBpcyBhIHdvcmthcm91bmQgZm9yIGxlZ2FjeSBndWVzdD8KPiAKPiBJ
IHRoaW5rIHRoZSBwb2ludCBpcywgc2luY2UgdGhlcmUncyBsZWdhY3kgZ3Vlc3Qgd2UnZCBoYXZl
IHRvIHN1cHBvcnQsIHRoaXMKPiBob3N0IHNpZGUgd29ya2Fyb3VuZCBpcyB1bmF2b2lkYWJsZS4g
QWx0aG91Z2ggSSBhZ3JlZSB0aGUgdmlvbGF0aW5nIGRyaXZlcgo+IHNob3VsZCBiZSBmaXhlZCAo
eWVzLCBpdCdzIGluIHRvZGF5J3MgdXBzdHJlYW0ga2VybmVsIHdoaWNoIGV4aXN0cyBmb3IgYQo+
IHdoaWxlIG5vdykuCgpPaCAgeW91IGFyZSByaWdodDoKCgpzdGF0aWMgaW50IHZpcnRuZXRfdmFs
aWRhdGUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCnsKICAgICAgICBpZiAoIXZkZXYtPmNv
bmZpZy0+Z2V0KSB7CiAgICAgICAgICAgICAgICBkZXZfZXJyKCZ2ZGV2LT5kZXYsICIlcyBmYWls
dXJlOiBjb25maWcgYWNjZXNzIGRpc2FibGVkXG4iLAogICAgICAgICAgICAgICAgICAgICAgICBf
X2Z1bmNfXyk7CiAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKICAgICAgICB9CgogICAg
ICAgIGlmICghdmlydG5ldF92YWxpZGF0ZV9mZWF0dXJlcyh2ZGV2KSkKICAgICAgICAgICAgICAg
IHJldHVybiAtRUlOVkFMOwoKICAgICAgICBpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJ
UlRJT19ORVRfRl9NVFUpKSB7CiAgICAgICAgICAgICAgICBpbnQgbXR1ID0gdmlydGlvX2NyZWFk
MTYodmRldiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBvZmZzZXRv
ZihzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgbXR1KSk7CiAgICAgICAgICAgICAgICBpZiAobXR1IDwgTUlO
X01UVSkKICAgICAgICAgICAgICAgICAgICAgICAgX192aXJ0aW9fY2xlYXJfYml0KHZkZXYsIFZJ
UlRJT19ORVRfRl9NVFUpOwogICAgICAgIH0KCiAgICAgICAgcmV0dXJuIDA7Cn0KCkFuZCB0aGUg
c3BlYyBzYXlzOgoKClRoZSBkcml2ZXIgTVVTVCBmb2xsb3cgdGhpcyBzZXF1ZW5jZSB0byBpbml0
aWFsaXplIGEgZGV2aWNlOgoxLiBSZXNldCB0aGUgZGV2aWNlLgoyLiBTZXQgdGhlIEFDS05PV0xF
REdFIHN0YXR1cyBiaXQ6IHRoZSBndWVzdCBPUyBoYXMgbm90aWNlZCB0aGUgZGV2aWNlLgozLiBT
ZXQgdGhlIERSSVZFUiBzdGF0dXMgYml0OiB0aGUgZ3Vlc3QgT1Mga25vd3MgaG93IHRvIGRyaXZl
IHRoZSBkZXZpY2UuCjQuIFJlYWQgZGV2aWNlIGZlYXR1cmUgYml0cywgYW5kIHdyaXRlIHRoZSBz
dWJzZXQgb2YgZmVhdHVyZSBiaXRzIHVuZGVyc3Rvb2QgYnkgdGhlIE9TIGFuZCBkcml2ZXIgdG8g
dGhlCmRldmljZS4gRHVyaW5nIHRoaXMgc3RlcCB0aGUgZHJpdmVyIE1BWSByZWFkIChidXQgTVVT
VCBOT1Qgd3JpdGUpIHRoZSBkZXZpY2Utc3BlY2lmaWMgY29uZmlndXJhdGlvbgpmaWVsZHMgdG8g
Y2hlY2sgdGhhdCBpdCBjYW4gc3VwcG9ydCB0aGUgZGV2aWNlIGJlZm9yZSBhY2NlcHRpbmcgaXQu
CjUuIFNldCB0aGUgRkVBVFVSRVNfT0sgc3RhdHVzIGJpdC4gVGhlIGRyaXZlciBNVVNUIE5PVCBh
Y2NlcHQgbmV3IGZlYXR1cmUgYml0cyBhZnRlciB0aGlzIHN0ZXAuCjYuIFJlLXJlYWQgZGV2aWNl
IHN0YXR1cyB0byBlbnN1cmUgdGhlIEZFQVRVUkVTX09LIGJpdCBpcyBzdGlsbCBzZXQ6IG90aGVy
d2lzZSwgdGhlIGRldmljZSBkb2VzIG5vdApzdXBwb3J0IG91ciBzdWJzZXQgb2YgZmVhdHVyZXMg
YW5kIHRoZSBkZXZpY2UgaXMgdW51c2FibGUuCjcuIFBlcmZvcm0gZGV2aWNlLXNwZWNpZmljIHNl
dHVwLCBpbmNsdWRpbmcgZGlzY292ZXJ5IG9mIHZpcnRxdWV1ZXMgZm9yIHRoZSBkZXZpY2UsIG9w
dGlvbmFsIHBlci1idXMgc2V0dXAsCnJlYWRpbmcgYW5kIHBvc3NpYmx5IHdyaXRpbmcgdGhlIGRl
dmljZeKAmXMgdmlydGlvIGNvbmZpZ3VyYXRpb24gc3BhY2UsIGFuZCBwb3B1bGF0aW9uIG9mIHZp
cnRxdWV1ZXMuCjguIFNldCB0aGUgRFJJVkVSX09LIHN0YXR1cyBiaXQuIEF0IHRoaXMgcG9pbnQg
dGhlIGRldmljZSBpcyDigJxsaXZl4oCdLgoKCkl0ZW0gNCBvbiB0aGUgbGlzdCBleHBsaWNpdGx5
IGFsbG93cyByZWFkaW5nIGNvbmZpZyBzcGFjZSBiZWZvcmUKRkVBVFVSRVNfT0suCgpJIGNvbmNs
dWRlIHRoYXQgVklSVElPX05FVF9GX01UVSBpcyBzZXQgbWVhbnMgInNldCBpbiBkZXZpY2UgZmVh
dHVyZXMiLgoKR2VuZXJhbGx5IGl0IGlzIHdvcnRoIGdvaW5nIG92ZXIgZmVhdHVyZSBkZXBlbmRl
bnQgY29uZmlnIGZpZWxkcwphbmQgY2hlY2tpbmcgd2hldGhlciB0aGV5IHNob3VsZCBiZSBwcmVz
ZW50IHdoZW4gZGV2aWNlIGZlYXR1cmUgaXMgc2V0Cm9yIHdoZW4gZmVhdHVyZSBiaXQgaGFzIGJl
ZW4gbmVnb3RpYXRlZCwgYW5kIG1ha2luZyB0aGlzIGNsZWFyLgoKLS0gCk1TVAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
