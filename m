Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5241AC433DB
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 13:26:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1B59614A7
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 13:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B59614A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 452B883A55;
	Tue, 23 Feb 2021 13:26:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JbUgLZqXNvTx; Tue, 23 Feb 2021 13:26:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 756D283A4A;
	Tue, 23 Feb 2021 13:26:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0FE70C000A;
	Tue, 23 Feb 2021 13:26:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7825C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 13:26:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A684660608
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 13:26:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x14C22rwG2Um
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 13:26:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D12F060604
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 13:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614086801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kAPqwhWPv/wIAMtOEQhvM/iB0b3ykohvYAlF1w+adM8=;
 b=GYFmjCVRMCWN8BVvBBSehMhL2jHUQ0AO2iZFoj1GXrei7Sfr9fFhXleDEofWp0MhJ+HxQS
 5sIcnZ+g1tDmE7+y/y/8yRidDS3lq8OndYX2djlJ3U38vLMh/uByNa9d4l0icVroWxudcX
 rBHZmOoO5uhsduNBgiJ6NS7CovW8+b4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-uMqlWLtvPKK6eXwhxiNS1g-1; Tue, 23 Feb 2021 08:26:39 -0500
X-MC-Unique: uMqlWLtvPKK6eXwhxiNS1g-1
Received: by mail-wm1-f71.google.com with SMTP id j204so1200292wmj.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 05:26:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=kAPqwhWPv/wIAMtOEQhvM/iB0b3ykohvYAlF1w+adM8=;
 b=VIGUscmTdRgR18VAWCcZb/I+Q9fbRIvNiEbXvSbCXmQ3nT6jW8X9ijOylMyTSxkdu+
 saoYi5g+OiyciMroGdskFeNFPWt9RoknmbcHA2878mTVS96fnWnbw5lbQktTs1NrU+Qo
 GcAa/lmeKYtOnVKWkpJYva3p51qsMuzGrBlC3pLtVjqPdBwuDrcnHdf8tvG/DonGhee1
 YPXmGgElBY3RwNDtF0VrqTvCFDJY+dBPQbcp7R9cyUvP/DBTG6eYBbEAjht0iZd4b2BX
 B5T7uMcIJqRFSxUAN8hbWuWQ7iB5dvV0R7WO2K36E/K9Fqm2lWxLP1E1v6SXly6PZqpH
 QwAg==
X-Gm-Message-State: AOAM531OH8j50Ht/SmRQtt2rzYESpWtRlbmcjhLocWT8RasYSZ6r9//N
 kOfllS18Q8zCi4EfDLnFDOv2XjGM3TtoxDslWsQFu2hSuHHOfloqdr24j3UalGQL9UdCNk7v3bq
 SJd3VBwlEQb7eMcPCEBKyi2donk+C3NPVi16nwhlHGg==
X-Received: by 2002:a5d:4c49:: with SMTP id n9mr13476655wrt.168.1614086798484; 
 Tue, 23 Feb 2021 05:26:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyEoRMPyhl21+u/rP1TpH6f40/IsRAK8QU2SB/vc4CL7FMPeR3jC4GZnQVZTfu4Ru6OwogGFA==
X-Received: by 2002:a5d:4c49:: with SMTP id n9mr13476642wrt.168.1614086798340; 
 Tue, 23 Feb 2021 05:26:38 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id a6sm2831755wmj.23.2021.02.23.05.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 05:26:37 -0800 (PST)
Date: Tue, 23 Feb 2021 08:26:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
Message-ID: <20210223082536-mutt-send-email-mst@kernel.org>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <20210222023040-mutt-send-email-mst@kernel.org>
 <22fe5923-635b-59f0-7643-2fd5876937c2@oracle.com>
 <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
MIME-Version: 1.0
In-Reply-To: <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
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

T24gVHVlLCBGZWIgMjMsIDIwMjEgYXQgMTA6MDM6NTdBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIxLzIvMjMgOToxMiDkuIrljYgsIFNpLVdlaSBMaXUgd3JvdGU6Cj4gPiAK
PiA+IAo+ID4gT24gMi8yMS8yMDIxIDExOjM0IFBNLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6
Cj4gPiA+IE9uIE1vbiwgRmViIDIyLCAyMDIxIGF0IDEyOjE0OjE3UE0gKzA4MDAsIEphc29uIFdh
bmcgd3JvdGU6Cj4gPiA+ID4gT24gMjAyMS8yLzE5IDc6NTQg5LiL5Y2ILCBTaS1XZWkgTGl1IHdy
b3RlOgo+ID4gPiA+ID4gQ29tbWl0IDQ1MjYzOWE2NGFkOCAoInZkcGE6IG1ha2Ugc3VyZSBzZXRf
ZmVhdHVyZXMgaXMgaW52b2tlZAo+ID4gPiA+ID4gZm9yIGxlZ2FjeSIpIG1hZGUgYW4gZXhjZXB0
aW9uIGZvciBsZWdhY3kgZ3Vlc3RzIHRvIHJlc2V0Cj4gPiA+ID4gPiBmZWF0dXJlcyB0byAwLCB3
aGVuIGNvbmZpZyBzcGFjZSBpcyBhY2Nlc3NlZCBiZWZvcmUgZmVhdHVyZXMKPiA+ID4gPiA+IGFy
ZSBzZXQuIFdlIHNob3VsZCByZWxpZXZlIHRoZSB2ZXJpZnlfbWluX2ZlYXR1cmVzKCkgY2hlY2sK
PiA+ID4gPiA+IGFuZCBhbGxvdyBmZWF0dXJlcyByZXNldCB0byAwIGZvciB0aGlzIGNhc2UuCj4g
PiA+ID4gPiAKPiA+ID4gPiA+IEl0J3Mgd29ydGggbm90aW5nIHRoYXQgbm90IGp1c3QgbGVnYWN5
IGd1ZXN0cyBjb3VsZCBhY2Nlc3MKPiA+ID4gPiA+IGNvbmZpZyBzcGFjZSBiZWZvcmUgZmVhdHVy
ZXMgYXJlIHNldC4gRm9yIGluc3RhbmNlLCB3aGVuCj4gPiA+ID4gPiBmZWF0dXJlIFZJUlRJT19O
RVRfRl9NVFUgaXMgYWR2ZXJ0aXNlZCBzb21lIG1vZGVybiBkcml2ZXIKPiA+ID4gPiA+IHdpbGwg
dHJ5IHRvIGFjY2VzcyBhbmQgdmFsaWRhdGUgdGhlIE1UVSBwcmVzZW50IGluIHRoZSBjb25maWcK
PiA+ID4gPiA+IHNwYWNlIGJlZm9yZSB2aXJ0aW8gZmVhdHVyZXMgYXJlIHNldC4KPiA+ID4gPiAK
PiA+ID4gPiBUaGlzIGxvb2tzIGxpa2UgYSBzcGVjIHZpb2xhdGlvbjoKPiA+ID4gPiAKPiA+ID4g
PiAiCj4gPiA+ID4gCj4gPiA+ID4gVGhlIGZvbGxvd2luZyBkcml2ZXItcmVhZC1vbmx5IGZpZWxk
LCBtdHUgb25seSBleGlzdHMgaWYKPiA+ID4gPiBWSVJUSU9fTkVUX0ZfTVRVIGlzCj4gPiA+ID4g
c2V0Lgo+ID4gPiA+IFRoaXMgZmllbGQgc3BlY2lmaWVzIHRoZSBtYXhpbXVtIE1UVSBmb3IgdGhl
IGRyaXZlciB0byB1c2UuCj4gPiA+ID4gIgo+ID4gPiA+IAo+ID4gPiA+IERvIHdlIHJlYWxseSB3
YW50IHRvIHdvcmthcm91bmQgdGhpcz8KPiA+ID4gPiAKPiA+ID4gPiBUaGFua3MKPiA+ID4gQW5k
IGFsc286Cj4gPiA+IAo+ID4gPiBUaGUgZHJpdmVyIE1VU1QgZm9sbG93IHRoaXMgc2VxdWVuY2Ug
dG8gaW5pdGlhbGl6ZSBhIGRldmljZToKPiA+ID4gMS4gUmVzZXQgdGhlIGRldmljZS4KPiA+ID4g
Mi4gU2V0IHRoZSBBQ0tOT1dMRURHRSBzdGF0dXMgYml0OiB0aGUgZ3Vlc3QgT1MgaGFzIG5vdGlj
ZWQgdGhlIGRldmljZS4KPiA+ID4gMy4gU2V0IHRoZSBEUklWRVIgc3RhdHVzIGJpdDogdGhlIGd1
ZXN0IE9TIGtub3dzIGhvdyB0byBkcml2ZSB0aGUKPiA+ID4gZGV2aWNlLgo+ID4gPiA0LiBSZWFk
IGRldmljZSBmZWF0dXJlIGJpdHMsIGFuZCB3cml0ZSB0aGUgc3Vic2V0IG9mIGZlYXR1cmUgYml0
cwo+ID4gPiB1bmRlcnN0b29kIGJ5IHRoZSBPUyBhbmQgZHJpdmVyIHRvIHRoZQo+ID4gPiBkZXZp
Y2UuIER1cmluZyB0aGlzIHN0ZXAgdGhlIGRyaXZlciBNQVkgcmVhZCAoYnV0IE1VU1QgTk9UIHdy
aXRlKQo+ID4gPiB0aGUgZGV2aWNlLXNwZWNpZmljIGNvbmZpZ3VyYXRpb24KPiA+ID4gZmllbGRz
IHRvIGNoZWNrIHRoYXQgaXQgY2FuIHN1cHBvcnQgdGhlIGRldmljZSBiZWZvcmUgYWNjZXB0aW5n
IGl0Lgo+ID4gPiA1LiBTZXQgdGhlIEZFQVRVUkVTX09LIHN0YXR1cyBiaXQuIFRoZSBkcml2ZXIg
TVVTVCBOT1QgYWNjZXB0IG5ldwo+ID4gPiBmZWF0dXJlIGJpdHMgYWZ0ZXIgdGhpcyBzdGVwLgo+
ID4gPiA2LiBSZS1yZWFkIGRldmljZSBzdGF0dXMgdG8gZW5zdXJlIHRoZSBGRUFUVVJFU19PSyBi
aXQgaXMgc3RpbGwgc2V0Ogo+ID4gPiBvdGhlcndpc2UsIHRoZSBkZXZpY2UgZG9lcyBub3QKPiA+
ID4gc3VwcG9ydCBvdXIgc3Vic2V0IG9mIGZlYXR1cmVzIGFuZCB0aGUgZGV2aWNlIGlzIHVudXNh
YmxlLgo+ID4gPiA3LiBQZXJmb3JtIGRldmljZS1zcGVjaWZpYyBzZXR1cCwgaW5jbHVkaW5nIGRp
c2NvdmVyeSBvZiB2aXJ0cXVldWVzCj4gPiA+IGZvciB0aGUgZGV2aWNlLCBvcHRpb25hbCBwZXIt
YnVzIHNldHVwLAo+ID4gPiByZWFkaW5nIGFuZCBwb3NzaWJseSB3cml0aW5nIHRoZSBkZXZpY2Xi
gJlzIHZpcnRpbyBjb25maWd1cmF0aW9uCj4gPiA+IHNwYWNlLCBhbmQgcG9wdWxhdGlvbiBvZiB2
aXJ0cXVldWVzLgo+ID4gPiA4LiBTZXQgdGhlIERSSVZFUl9PSyBzdGF0dXMgYml0LiBBdCB0aGlz
IHBvaW50IHRoZSBkZXZpY2UgaXMg4oCcbGl2ZeKAnS4KPiA+ID4gCj4gPiA+IAo+ID4gPiBzbyBh
Y2Nlc3NpbmcgY29uZmlnIHNwYWNlIGJlZm9yZSBGRUFUVVJFU19PSyBpcyBhIHNwZWMgdmlvbGF0
aW9uLCByaWdodD8KPiA+IEl0IGlzLCBidXQgaXQncyBub3QgcmVsZXZhbnQgdG8gd2hhdCB0aGlz
IGNvbW1pdCB0cmllcyB0byBhZGRyZXNzLiBJCj4gPiB0aG91Z2h0IHRoZSBsZWdhY3kgZ3Vlc3Qg
c3RpbGwgbmVlZHMgdG8gYmUgc3VwcG9ydGVkLgo+ID4gCj4gPiBIYXZpbmcgc2FpZCwgYSBzZXBh
cmF0ZSBwYXRjaCBoYXMgdG8gYmUgcG9zdGVkIHRvIGZpeCB0aGUgZ3Vlc3QgZHJpdmVyCj4gPiBp
c3N1ZSB3aGVyZSB0aGlzIGRpc2NyZXBhbmN5IGlzIGludHJvZHVjZWQgdG8gdmlydG5ldF92YWxp
ZGF0ZSgpIChzaW5jZQo+ID4gY29tbWl0IGZlMzZjYmUwNjcpLiBCdXQgaXQncyBub3QgdGVjaG5p
Y2FsbHkgcmVsYXRlZCB0byB0aGlzIHBhdGNoLgo+ID4gCj4gPiAtU2l3ZWkKPiAKPiAKPiBJIHRo
aW5rIGl0J3MgYSBidWcgdG8gcmVhZCBjb25maWcgc3BhY2UgaW4gdmFsaWRhdGUsIHdlIHNob3Vs
ZCBtb3ZlIGl0IHRvCj4gdmlydG5ldF9wcm9iZSgpLgo+IAo+IFRoYW5rcwoKSSB0YWtlIGl0IGJh
Y2ssIHJlYWRpbmcgYnV0IG5vdCB3cml0aW5nIHNlZW1zIHRvIGJlIGV4cGxpY2l0bHkgYWxsb3dl
ZCBieSBzcGVjLgpTbyBvdXIgd2F5IHRvIGRldGVjdCBhIGxlZ2FjeSBndWVzdCBpcyBib2d1cywg
bmVlZCB0byB0aGluayB3aGF0IGlzCnRoZSBiZXN0IHdheSB0byBoYW5kbGUgdGhpcy4KCj4gCj4g
PiAKPiA+ID4gCj4gPiA+IAo+ID4gPiA+ID4gUmVqZWN0aW5nIHJlc2V0IHRvIDAKPiA+ID4gPiA+
IHByZW1hdHVyZWx5IGNhdXNlcyBjb3JyZWN0IE1UVSBhbmQgbGluayBzdGF0dXMgdW5hYmxlIHRv
IGxvYWQKPiA+ID4gPiA+IGZvciB0aGUgdmVyeSBmaXJzdCBjb25maWcgc3BhY2UgYWNjZXNzLCBy
ZW5kZXJpbmcgaXNzdWVzIGxpa2UKPiA+ID4gPiA+IGd1ZXN0IHNob3dpbmcgaW5hY2N1cmF0ZSBN
VFUgdmFsdWUsIG9yIGZhaWx1cmUgdG8gcmVqZWN0Cj4gPiA+ID4gPiBvdXQtb2YtcmFuZ2UgTVRV
Lgo+ID4gPiA+ID4gCj4gPiA+ID4gPiBGaXhlczogMWE4NmIzNzdhYTIxICgidmRwYS9tbHg1OiBB
ZGQgVkRQQSBkcml2ZXIgZm9yCj4gPiA+ID4gPiBzdXBwb3J0ZWQgbWx4NSBkZXZpY2VzIikKPiA+
ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4K
PiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4gwqDCoCBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92
bmV0LmMgfCAxNSArLS0tLS0tLS0tLS0tLS0KPiA+ID4gPiA+IMKgwqAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxNCBkZWxldGlvbnMoLSkKPiA+ID4gPiA+IAo+ID4gPiA+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ID4gPiA+ID4gYi9k
cml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+ID4gPiA+IGluZGV4IDdjMWY3ODku
LjU0MGRkNjcgMTAwNjQ0Cj4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4
NV92bmV0LmMKPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQu
Ywo+ID4gPiA+ID4gQEAgLTE0OTAsMTQgKzE0OTAsNiBAQCBzdGF0aWMgdTY0Cj4gPiA+ID4gPiBt
bHg1X3ZkcGFfZ2V0X2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldikKPiA+ID4gPiA+
IMKgwqDCoMKgwqDCoCByZXR1cm4gbXZkZXYtPm1seF9mZWF0dXJlczsKPiA+ID4gPiA+IMKgwqAg
fQo+ID4gPiA+ID4gLXN0YXRpYyBpbnQgdmVyaWZ5X21pbl9mZWF0dXJlcyhzdHJ1Y3QgbWx4NV92
ZHBhX2RldiAqbXZkZXYsCj4gPiA+ID4gPiB1NjQgZmVhdHVyZXMpCj4gPiA+ID4gPiAtewo+ID4g
PiA+ID4gLcKgwqDCoCBpZiAoIShmZWF0dXJlcyAmIEJJVF9VTEwoVklSVElPX0ZfQUNDRVNTX1BM
QVRGT1JNKSkpCj4gPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FT1BOT1RTVVBQOwo+
ID4gPiA+ID4gLQo+ID4gPiA+ID4gLcKgwqDCoCByZXR1cm4gMDsKPiA+ID4gPiA+IC19Cj4gPiA+
ID4gPiAtCj4gPiA+ID4gPiDCoMKgIHN0YXRpYyBpbnQgc2V0dXBfdmlydHF1ZXVlcyhzdHJ1Y3Qg
bWx4NV92ZHBhX25ldCAqbmRldikKPiA+ID4gPiA+IMKgwqAgewo+ID4gPiA+ID4gwqDCoMKgwqDC
oMKgIGludCBlcnI7Cj4gPiA+ID4gPiBAQCAtMTU1OCwxOCArMTU1MCwxMyBAQCBzdGF0aWMgaW50
Cj4gPiA+ID4gPiBtbHg1X3ZkcGFfc2V0X2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRl
diwgdTY0Cj4gPiA+ID4gPiBmZWF0dXJlcykKPiA+ID4gPiA+IMKgwqAgewo+ID4gPiA+ID4gwqDC
oMKgwqDCoMKgIHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiA9IHRvX212ZGV2KHZkZXYpOwo+
ID4gPiA+ID4gwqDCoMKgwqDCoMKgIHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2ID0gdG9fbWx4
NV92ZHBhX25kZXYobXZkZXYpOwo+ID4gPiA+ID4gLcKgwqDCoCBpbnQgZXJyOwo+ID4gPiA+ID4g
wqDCoMKgwqDCoMKgIHByaW50X2ZlYXR1cmVzKG12ZGV2LCBmZWF0dXJlcywgdHJ1ZSk7Cj4gPiA+
ID4gPiAtwqDCoMKgIGVyciA9IHZlcmlmeV9taW5fZmVhdHVyZXMobXZkZXYsIGZlYXR1cmVzKTsK
PiA+ID4gPiA+IC3CoMKgwqAgaWYgKGVycikKPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoCByZXR1
cm4gZXJyOwo+ID4gPiA+ID4gLQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgIG5kZXYtPm12ZGV2LmFj
dHVhbF9mZWF0dXJlcyA9IGZlYXR1cmVzICYKPiA+ID4gPiA+IG5kZXYtPm12ZGV2Lm1seF9mZWF0
dXJlczsKPiA+ID4gPiA+IMKgwqDCoMKgwqDCoCBuZGV2LT5jb25maWcubXR1ID0gY3B1X3RvX21s
eDV2ZHBhMTYobXZkZXYsIG5kZXYtPm10dSk7Cj4gPiA+ID4gPiDCoMKgwqDCoMKgwqAgbmRldi0+
Y29uZmlnLnN0YXR1cyB8PSBjcHVfdG9fbWx4NXZkcGExNihtdmRldiwKPiA+ID4gPiA+IFZJUlRJ
T19ORVRfU19MSU5LX1VQKTsKPiA+ID4gPiA+IC3CoMKgwqAgcmV0dXJuIGVycjsKPiA+ID4gPiA+
ICvCoMKgwqAgcmV0dXJuIDA7Cj4gPiA+ID4gPiDCoMKgIH0KPiA+ID4gPiA+IMKgwqAgc3RhdGlj
IHZvaWQgbWx4NV92ZHBhX3NldF9jb25maWdfY2Ioc3RydWN0IHZkcGFfZGV2aWNlCj4gPiA+ID4g
PiAqdmRldiwgc3RydWN0IHZkcGFfY2FsbGJhY2sgKmNiKQo+ID4gCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
