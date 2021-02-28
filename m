Return-Path: <SRS0=D/xy=H6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F33C433DB
	for <virtualization@archiver.kernel.org>; Sun, 28 Feb 2021 21:29:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 331FF64E62
	for <virtualization@archiver.kernel.org>; Sun, 28 Feb 2021 21:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331FF64E62
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D586F83DDD;
	Sun, 28 Feb 2021 21:29:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BtNliooafZpa; Sun, 28 Feb 2021 21:29:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4BD3483DD6;
	Sun, 28 Feb 2021 21:29:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21609C000A;
	Sun, 28 Feb 2021 21:29:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79C02C0001
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Feb 2021 21:29:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 67EBA4DC17
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Feb 2021 21:29:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uaoAQbyOctbs
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Feb 2021 21:29:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 497DE4C88E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Feb 2021 21:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614547739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GwitB7tmJHor6lKADpKSPcH+bNxWXn08rGoAHV5xDeo=;
 b=F8EeKrRtLA0R7xBypN8vW+mf8ekHJUlWh5EVTMFIGw/lVkzT7Bm1wke1jv/7UBsBbTZwvv
 4LzQOgGvFqA0/MvmY0ugF550ny7g6FNqwQdAlsRoB2qoA/MYK5+FQ+92cQJpCsDHibQt6t
 6Wy9TeZSGekJq/BSJ3FQ30hxPFxSgGs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-D6T_HM9uM8KLuv_vsRKH9Q-1; Sun, 28 Feb 2021 16:28:57 -0500
X-MC-Unique: D6T_HM9uM8KLuv_vsRKH9Q-1
Received: by mail-ej1-f70.google.com with SMTP id r26so86213eja.22
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Feb 2021 13:28:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=GwitB7tmJHor6lKADpKSPcH+bNxWXn08rGoAHV5xDeo=;
 b=pEdYPi56+iJo9fnLCg7TiXTRn9Qoo6//QU9pibkomjsWUbgHY+H6OdLMTg8wM3ZvFN
 SjnVNP2MtbXYdTEZR8L85cO6ylSa2Xg1NzqnIHKdcZYoswWtleOyIrSEnTlKB8BWq0tr
 piqTPMrEKqtWFU1R2ZnfDxAxskGdnJOzE/A1aO5sBUXg/UpmhCoRGwTMaIPTGSzLaadt
 d1jCZaoyetzr0Gs+YdYgBNHxQGVGyobdljJJzGtn/1jLwOIAGBu4VdQbeS2brGTw4hsW
 LuBJquxBT2kKGmsYbXqnzu2e8xjpvMPnUN8lmyWZRPMpcc55p1C8E33+SeIROWEcbF3s
 THlg==
X-Gm-Message-State: AOAM530gwfNTnoQPmR3qT+Mr3U9gIDyZW6NUtKJzroLLw4FUk0hnb8Z/
 UY8K2IS43uusHNMNEj15vJuxfQLLoHtj9ThJXP0AwtyXP2Ym9dytSap9WDvWch9ZEOTrXnAXweY
 KvEthCEojUj62afI6PbYKB8hS7samSCxgdUmXcpA1bQ==
X-Received: by 2002:a17:906:32c5:: with SMTP id
 k5mr12555462ejk.249.1614547736016; 
 Sun, 28 Feb 2021 13:28:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzAVsa1rVUShElsu/jH2CLezpldoPZzydNiv+5BgmwRkiWsGZ/DvQoLF+G1p2t3dj0L2+6pRA==
X-Received: by 2002:a17:906:32c5:: with SMTP id
 k5mr12555456ejk.249.1614547735871; 
 Sun, 28 Feb 2021 13:28:55 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id fi11sm9432236ejb.73.2021.02.28.13.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Feb 2021 13:28:55 -0800 (PST)
Date: Sun, 28 Feb 2021 16:28:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
Message-ID: <20210228162802-mutt-send-email-mst@kernel.org>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <20210222023040-mutt-send-email-mst@kernel.org>
 <22fe5923-635b-59f0-7643-2fd5876937c2@oracle.com>
 <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
 <20210223082536-mutt-send-email-mst@kernel.org>
 <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <20210224000057-mutt-send-email-mst@kernel.org>
 <52836a63-4e00-ff58-50fb-9f450ce968d7@oracle.com>
MIME-Version: 1.0
In-Reply-To: <52836a63-4e00-ff58-50fb-9f450ce968d7@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 elic@nvidia.com, linux-kernel@vger.kernel.org
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

T24gV2VkLCBGZWIgMjQsIDIwMjEgYXQgMTA6MjQ6NDFBTSAtMDgwMCwgU2ktV2VpIExpdSB3cm90
ZToKPiAKPiAKPiBPbiAyLzIzLzIwMjEgOTowNCBQTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Ogo+ID4gT24gVHVlLCBGZWIgMjMsIDIwMjEgYXQgMTE6MzU6NTdBTSAtMDgwMCwgU2ktV2VpIExp
dSB3cm90ZToKPiA+ID4gCj4gPiA+IE9uIDIvMjMvMjAyMSA1OjI2IEFNLCBNaWNoYWVsIFMuIFRz
aXJraW4gd3JvdGU6Cj4gPiA+ID4gT24gVHVlLCBGZWIgMjMsIDIwMjEgYXQgMTA6MDM6NTdBTSAr
MDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+IE9uIDIwMjEvMi8yMyA5OjEyIOS4iuWN
iCwgU2ktV2VpIExpdSB3cm90ZToKPiA+ID4gPiA+ID4gT24gMi8yMS8yMDIxIDExOjM0IFBNLCBN
aWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gT24gTW9uLCBGZWIgMjIsIDIw
MjEgYXQgMTI6MTQ6MTdQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gPiA+
IE9uIDIwMjEvMi8xOSA3OjU0IOS4i+WNiCwgU2ktV2VpIExpdSB3cm90ZToKPiA+ID4gPiA+ID4g
PiA+ID4gQ29tbWl0IDQ1MjYzOWE2NGFkOCAoInZkcGE6IG1ha2Ugc3VyZSBzZXRfZmVhdHVyZXMg
aXMgaW52b2tlZAo+ID4gPiA+ID4gPiA+ID4gPiBmb3IgbGVnYWN5IikgbWFkZSBhbiBleGNlcHRp
b24gZm9yIGxlZ2FjeSBndWVzdHMgdG8gcmVzZXQKPiA+ID4gPiA+ID4gPiA+ID4gZmVhdHVyZXMg
dG8gMCwgd2hlbiBjb25maWcgc3BhY2UgaXMgYWNjZXNzZWQgYmVmb3JlIGZlYXR1cmVzCj4gPiA+
ID4gPiA+ID4gPiA+IGFyZSBzZXQuIFdlIHNob3VsZCByZWxpZXZlIHRoZSB2ZXJpZnlfbWluX2Zl
YXR1cmVzKCkgY2hlY2sKPiA+ID4gPiA+ID4gPiA+ID4gYW5kIGFsbG93IGZlYXR1cmVzIHJlc2V0
IHRvIDAgZm9yIHRoaXMgY2FzZS4KPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+
IEl0J3Mgd29ydGggbm90aW5nIHRoYXQgbm90IGp1c3QgbGVnYWN5IGd1ZXN0cyBjb3VsZCBhY2Nl
c3MKPiA+ID4gPiA+ID4gPiA+ID4gY29uZmlnIHNwYWNlIGJlZm9yZSBmZWF0dXJlcyBhcmUgc2V0
LiBGb3IgaW5zdGFuY2UsIHdoZW4KPiA+ID4gPiA+ID4gPiA+ID4gZmVhdHVyZSBWSVJUSU9fTkVU
X0ZfTVRVIGlzIGFkdmVydGlzZWQgc29tZSBtb2Rlcm4gZHJpdmVyCj4gPiA+ID4gPiA+ID4gPiA+
IHdpbGwgdHJ5IHRvIGFjY2VzcyBhbmQgdmFsaWRhdGUgdGhlIE1UVSBwcmVzZW50IGluIHRoZSBj
b25maWcKPiA+ID4gPiA+ID4gPiA+ID4gc3BhY2UgYmVmb3JlIHZpcnRpbyBmZWF0dXJlcyBhcmUg
c2V0Lgo+ID4gPiA+ID4gPiA+ID4gVGhpcyBsb29rcyBsaWtlIGEgc3BlYyB2aW9sYXRpb246Cj4g
PiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ICIKPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+
ID4gPiA+ID4gVGhlIGZvbGxvd2luZyBkcml2ZXItcmVhZC1vbmx5IGZpZWxkLCBtdHUgb25seSBl
eGlzdHMgaWYKPiA+ID4gPiA+ID4gPiA+IFZJUlRJT19ORVRfRl9NVFUgaXMKPiA+ID4gPiA+ID4g
PiA+IHNldC4KPiA+ID4gPiA+ID4gPiA+IFRoaXMgZmllbGQgc3BlY2lmaWVzIHRoZSBtYXhpbXVt
IE1UVSBmb3IgdGhlIGRyaXZlciB0byB1c2UuCj4gPiA+ID4gPiA+ID4gPiAiCj4gPiA+ID4gPiA+
ID4gPiAKPiA+ID4gPiA+ID4gPiA+IERvIHdlIHJlYWxseSB3YW50IHRvIHdvcmthcm91bmQgdGhp
cz8KPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPiA+ID4g
QW5kIGFsc286Cj4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gVGhlIGRyaXZlciBNVVNUIGZv
bGxvdyB0aGlzIHNlcXVlbmNlIHRvIGluaXRpYWxpemUgYSBkZXZpY2U6Cj4gPiA+ID4gPiA+ID4g
MS4gUmVzZXQgdGhlIGRldmljZS4KPiA+ID4gPiA+ID4gPiAyLiBTZXQgdGhlIEFDS05PV0xFREdF
IHN0YXR1cyBiaXQ6IHRoZSBndWVzdCBPUyBoYXMgbm90aWNlZCB0aGUgZGV2aWNlLgo+ID4gPiA+
ID4gPiA+IDMuIFNldCB0aGUgRFJJVkVSIHN0YXR1cyBiaXQ6IHRoZSBndWVzdCBPUyBrbm93cyBo
b3cgdG8gZHJpdmUgdGhlCj4gPiA+ID4gPiA+ID4gZGV2aWNlLgo+ID4gPiA+ID4gPiA+IDQuIFJl
YWQgZGV2aWNlIGZlYXR1cmUgYml0cywgYW5kIHdyaXRlIHRoZSBzdWJzZXQgb2YgZmVhdHVyZSBi
aXRzCj4gPiA+ID4gPiA+ID4gdW5kZXJzdG9vZCBieSB0aGUgT1MgYW5kIGRyaXZlciB0byB0aGUK
PiA+ID4gPiA+ID4gPiBkZXZpY2UuIER1cmluZyB0aGlzIHN0ZXAgdGhlIGRyaXZlciBNQVkgcmVh
ZCAoYnV0IE1VU1QgTk9UIHdyaXRlKQo+ID4gPiA+ID4gPiA+IHRoZSBkZXZpY2Utc3BlY2lmaWMg
Y29uZmlndXJhdGlvbgo+ID4gPiA+ID4gPiA+IGZpZWxkcyB0byBjaGVjayB0aGF0IGl0IGNhbiBz
dXBwb3J0IHRoZSBkZXZpY2UgYmVmb3JlIGFjY2VwdGluZyBpdC4KPiA+ID4gPiA+ID4gPiA1LiBT
ZXQgdGhlIEZFQVRVUkVTX09LIHN0YXR1cyBiaXQuIFRoZSBkcml2ZXIgTVVTVCBOT1QgYWNjZXB0
IG5ldwo+ID4gPiA+ID4gPiA+IGZlYXR1cmUgYml0cyBhZnRlciB0aGlzIHN0ZXAuCj4gPiA+ID4g
PiA+ID4gNi4gUmUtcmVhZCBkZXZpY2Ugc3RhdHVzIHRvIGVuc3VyZSB0aGUgRkVBVFVSRVNfT0sg
Yml0IGlzIHN0aWxsIHNldDoKPiA+ID4gPiA+ID4gPiBvdGhlcndpc2UsIHRoZSBkZXZpY2UgZG9l
cyBub3QKPiA+ID4gPiA+ID4gPiBzdXBwb3J0IG91ciBzdWJzZXQgb2YgZmVhdHVyZXMgYW5kIHRo
ZSBkZXZpY2UgaXMgdW51c2FibGUuCj4gPiA+ID4gPiA+ID4gNy4gUGVyZm9ybSBkZXZpY2Utc3Bl
Y2lmaWMgc2V0dXAsIGluY2x1ZGluZyBkaXNjb3Zlcnkgb2YgdmlydHF1ZXVlcwo+ID4gPiA+ID4g
PiA+IGZvciB0aGUgZGV2aWNlLCBvcHRpb25hbCBwZXItYnVzIHNldHVwLAo+ID4gPiA+ID4gPiA+
IHJlYWRpbmcgYW5kIHBvc3NpYmx5IHdyaXRpbmcgdGhlIGRldmljZeKAmXMgdmlydGlvIGNvbmZp
Z3VyYXRpb24KPiA+ID4gPiA+ID4gPiBzcGFjZSwgYW5kIHBvcHVsYXRpb24gb2YgdmlydHF1ZXVl
cy4KPiA+ID4gPiA+ID4gPiA4LiBTZXQgdGhlIERSSVZFUl9PSyBzdGF0dXMgYml0LiBBdCB0aGlz
IHBvaW50IHRoZSBkZXZpY2UgaXMg4oCcbGl2ZeKAnS4KPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+
ID4gPiAKPiA+ID4gPiA+ID4gPiBzbyBhY2Nlc3NpbmcgY29uZmlnIHNwYWNlIGJlZm9yZSBGRUFU
VVJFU19PSyBpcyBhIHNwZWMgdmlvbGF0aW9uLCByaWdodD8KPiA+ID4gPiA+ID4gSXQgaXMsIGJ1
dCBpdCdzIG5vdCByZWxldmFudCB0byB3aGF0IHRoaXMgY29tbWl0IHRyaWVzIHRvIGFkZHJlc3Mu
IEkKPiA+ID4gPiA+ID4gdGhvdWdodCB0aGUgbGVnYWN5IGd1ZXN0IHN0aWxsIG5lZWRzIHRvIGJl
IHN1cHBvcnRlZC4KPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IEhhdmluZyBzYWlkLCBhIHNlcGFy
YXRlIHBhdGNoIGhhcyB0byBiZSBwb3N0ZWQgdG8gZml4IHRoZSBndWVzdCBkcml2ZXIKPiA+ID4g
PiA+ID4gaXNzdWUgd2hlcmUgdGhpcyBkaXNjcmVwYW5jeSBpcyBpbnRyb2R1Y2VkIHRvIHZpcnRu
ZXRfdmFsaWRhdGUoKSAoc2luY2UKPiA+ID4gPiA+ID4gY29tbWl0IGZlMzZjYmUwNjcpLiBCdXQg
aXQncyBub3QgdGVjaG5pY2FsbHkgcmVsYXRlZCB0byB0aGlzIHBhdGNoLgo+ID4gPiA+ID4gPiAK
PiA+ID4gPiA+ID4gLVNpd2VpCj4gPiA+ID4gPiBJIHRoaW5rIGl0J3MgYSBidWcgdG8gcmVhZCBj
b25maWcgc3BhY2UgaW4gdmFsaWRhdGUsIHdlIHNob3VsZCBtb3ZlIGl0IHRvCj4gPiA+ID4gPiB2
aXJ0bmV0X3Byb2JlKCkuCj4gPiA+ID4gPiAKPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+IEkgdGFr
ZSBpdCBiYWNrLCByZWFkaW5nIGJ1dCBub3Qgd3JpdGluZyBzZWVtcyB0byBiZSBleHBsaWNpdGx5
IGFsbG93ZWQgYnkgc3BlYy4KPiA+ID4gPiBTbyBvdXIgd2F5IHRvIGRldGVjdCBhIGxlZ2FjeSBn
dWVzdCBpcyBib2d1cywgbmVlZCB0byB0aGluayB3aGF0IGlzCj4gPiA+ID4gdGhlIGJlc3Qgd2F5
IHRvIGhhbmRsZSB0aGlzLgo+ID4gPiBUaGVuIG1heWJlIHJldmVydCBjb21taXQgZmUzNmNiZTA2
NyBhbmQgZnJpZW5kcywgYW5kIGhhdmUgUUVNVSBkZXRlY3QgbGVnYWN5Cj4gPiA+IGd1ZXN0PyBT
dXBwb3NlZGx5IG9ubHkgY29uZmlnIHNwYWNlIHdyaXRlIGFjY2VzcyBuZWVkcyB0byBiZSBndWFy
ZGVkIGJlZm9yZQo+ID4gPiBzZXR0aW5nIEZFQVRVUkVTX09LLgo+ID4gPiAKPiA+ID4gLVNpd2ll
Cj4gPiBEZXRlY3RpbmcgaXQgaXNuJ3QgZW5vdWdoIHRob3VnaCwgd2Ugd2lsbCBuZWVkIGEgbmV3
IGlvY3RsIHRvIG5vdGlmeQo+ID4gdGhlIGtlcm5lbCB0aGF0IGl0J3MgYSBsZWdhY3kgZ3Vlc3Qu
IFVnaCA6KAo+IFdlbGwsIGFsdGhvdWdoIEkgdGhpbmsgYWRkaW5nIGFuIGlvY3RsIGlzIGRvYWJs
ZSwgbWF5IEkga25vdyB3aGF0IHRoZSB1c2UKPiBjYXNlIHRoZXJlIHdpbGwgYmUgZm9yIGtlcm5l
bCB0byBsZXZlcmFnZSBzdWNoIGluZm8gZGlyZWN0bHk/IElzIHRoZXJlIGEKPiBjYXNlIFFFTVUg
Y2FuJ3QgZG8gd2l0aCBkZWRpY2F0ZSBpb2N0bHMgbGF0ZXIgaWYgdGhlcmUncyBpbmRlZWQKPiBk
aWZmZXJlbnRpYXRpb24gKGxlZ2FjeSB2LnMuIG1vZGVybikgbmVlZGVkPwo+IAo+IE9uZSBvZiB0
aGUgcmVhc29uIEkgYXNrZWQgaXMgaWYgdGhpcyBpb2N0bCBiZWNvbWVzIGEgbWFuZGF0ZSBmb3Ig
dmhvc3QtdmRwYQo+IGtlcm5lbC4gUUVNVSB3b3VsZCByZWplY3QgaW5pdGlhbGl6ZSB2aG9zdC12
ZHBhIGlmIGRvZXNuJ3Qgc2VlIHRoaXMgaW9jdGwKPiBjb21pbmc/CgpPbmx5IG9uIEJFIGhvc3Rz
IG9yIGd1ZXN0cyBJIHRoaW5rLiBXaXRoIExFIGhvc3QgYW5kIGd1ZXN0IGxlZ2FjeSBhbmQKbW9k
ZXJuIGJlaGF2ZSB0aGUgc2FtZSBzbyBpb2N0bCBpc24ndCBuZWVkZWQuCgo+IElmIGl0J3Mgb3B0
aW9uYWwsIHN1cHBvc2UgdGhlIGtlcm5lbCBtYXkgbmVlZCBpdCBvbmx5IHdoZW4gaXQgYmVjb21l
cwo+IG5lY2Vzc2FyeT8KPiAKPiBUaGFua3MsCj4gLVNpd2VpCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
