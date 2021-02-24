Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF7EC433E0
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 05:04:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E6DE64EBA
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 05:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6DE64EBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BC04C43074;
	Wed, 24 Feb 2021 05:04:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RSUDiYfZ9ODl; Wed, 24 Feb 2021 05:04:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2FF0743078;
	Wed, 24 Feb 2021 05:04:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0696DC000B;
	Wed, 24 Feb 2021 05:04:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5907BC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 05:04:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3A63183ACF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 05:04:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8eSFCi3Ci_IQ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 05:04:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CE0F583C33
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 05:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614143092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qg7BvJGVrkmLzWoca1uwqa7WR08fGmAwdwMQIZ6814o=;
 b=GtpNSXDCOuYLE32UB94so5M7Uo5SfhrFS6oW0YrLo/r8LfNE+6a7pxiuAe/iHZhLY4ouRw
 vTQ3zQaL0CiD/u+KIAYO/sOvot2mC/yn6aOBXRnDfJ8yra3p1Qg71a1wso7xTxzUzniDPX
 +HLBkXu4/l2JIciLIpyKr5v2yV3WNcw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-qS01g4qEPyOOzOmN7tx4ag-1; Wed, 24 Feb 2021 00:04:22 -0500
X-MC-Unique: qS01g4qEPyOOzOmN7tx4ag-1
Received: by mail-wr1-f72.google.com with SMTP id e11so472760wro.19
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 21:04:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=qg7BvJGVrkmLzWoca1uwqa7WR08fGmAwdwMQIZ6814o=;
 b=N5Gw81VRpaZv4kVDWSq2Bm/PoNBFbbM16mzlffWzmS8rE4EoUdvcx9avs3SPOkqEx5
 clUg8tlMPOhj4ldnPcWFj1c7XN9DUoZbLbqJP7rz9B8VmtXUj2F0bBSkc1N7F6z8vV34
 7dlNYb9SLt7suS7W5tyDDZxWufhV5IYiZBwSi/dK56sJR4IHmnVL45Vr4x3Xnd67CFAn
 aM5uvuzXkIYyhUnVsh74NUqPtvb/0Y2I2cf503tpT+o514Gn5OvcFTZFBFR+uByiMymU
 JZR/wnbGD4nlwc7kLAOsZtV7hf8CJsPV3BCATHvC5qBcphQ5AmzZhMBix3tCcVNry88M
 Uqbg==
X-Gm-Message-State: AOAM531Ex2tiCHPUV2g82uKkcskaRmRfMzgdYvQPLAoutN9uOam+dEwO
 yBxgqTQ6L8oR6UjUNUoJYjjOdtkdE01yFv5FrOqDHdUIBpXrVnjmgpj1K6avDXhGTXS5rrX3wZo
 AORHhnr96HEkpZHeKgNB5viE+hyXra3nKqgX3yqllrA==
X-Received: by 2002:a1c:a7d3:: with SMTP id q202mr1810772wme.93.1614143060718; 
 Tue, 23 Feb 2021 21:04:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwunTZi4C12uuXwV71LG4B0VWOYbn2ATYH4hZ4doxg/op9ieMqFayUgQTdJX1JbFuvjFcJIRg==
X-Received: by 2002:a1c:a7d3:: with SMTP id q202mr1810757wme.93.1614143060543; 
 Tue, 23 Feb 2021 21:04:20 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id g11sm920528wmk.32.2021.02.23.21.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 21:04:19 -0800 (PST)
Date: Wed, 24 Feb 2021 00:04:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
Message-ID: <20210224000057-mutt-send-email-mst@kernel.org>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <20210222023040-mutt-send-email-mst@kernel.org>
 <22fe5923-635b-59f0-7643-2fd5876937c2@oracle.com>
 <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
 <20210223082536-mutt-send-email-mst@kernel.org>
 <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
MIME-Version: 1.0
In-Reply-To: <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
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

T24gVHVlLCBGZWIgMjMsIDIwMjEgYXQgMTE6MzU6NTdBTSAtMDgwMCwgU2ktV2VpIExpdSB3cm90
ZToKPiAKPiAKPiBPbiAyLzIzLzIwMjEgNToyNiBBTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Ogo+ID4gT24gVHVlLCBGZWIgMjMsIDIwMjEgYXQgMTA6MDM6NTdBTSArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZToKPiA+ID4gT24gMjAyMS8yLzIzIDk6MTIg5LiK5Y2ILCBTaS1XZWkgTGl1IHdyb3Rl
Ogo+ID4gPiA+IAo+ID4gPiA+IE9uIDIvMjEvMjAyMSAxMTozNCBQTSwgTWljaGFlbCBTLiBUc2ly
a2luIHdyb3RlOgo+ID4gPiA+ID4gT24gTW9uLCBGZWIgMjIsIDIwMjEgYXQgMTI6MTQ6MTdQTSAr
MDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gT24gMjAyMS8yLzE5IDc6NTQg5LiL
5Y2ILCBTaS1XZWkgTGl1IHdyb3RlOgo+ID4gPiA+ID4gPiA+IENvbW1pdCA0NTI2MzlhNjRhZDgg
KCJ2ZHBhOiBtYWtlIHN1cmUgc2V0X2ZlYXR1cmVzIGlzIGludm9rZWQKPiA+ID4gPiA+ID4gPiBm
b3IgbGVnYWN5IikgbWFkZSBhbiBleGNlcHRpb24gZm9yIGxlZ2FjeSBndWVzdHMgdG8gcmVzZXQK
PiA+ID4gPiA+ID4gPiBmZWF0dXJlcyB0byAwLCB3aGVuIGNvbmZpZyBzcGFjZSBpcyBhY2Nlc3Nl
ZCBiZWZvcmUgZmVhdHVyZXMKPiA+ID4gPiA+ID4gPiBhcmUgc2V0LiBXZSBzaG91bGQgcmVsaWV2
ZSB0aGUgdmVyaWZ5X21pbl9mZWF0dXJlcygpIGNoZWNrCj4gPiA+ID4gPiA+ID4gYW5kIGFsbG93
IGZlYXR1cmVzIHJlc2V0IHRvIDAgZm9yIHRoaXMgY2FzZS4KPiA+ID4gPiA+ID4gPiAKPiA+ID4g
PiA+ID4gPiBJdCdzIHdvcnRoIG5vdGluZyB0aGF0IG5vdCBqdXN0IGxlZ2FjeSBndWVzdHMgY291
bGQgYWNjZXNzCj4gPiA+ID4gPiA+ID4gY29uZmlnIHNwYWNlIGJlZm9yZSBmZWF0dXJlcyBhcmUg
c2V0LiBGb3IgaW5zdGFuY2UsIHdoZW4KPiA+ID4gPiA+ID4gPiBmZWF0dXJlIFZJUlRJT19ORVRf
Rl9NVFUgaXMgYWR2ZXJ0aXNlZCBzb21lIG1vZGVybiBkcml2ZXIKPiA+ID4gPiA+ID4gPiB3aWxs
IHRyeSB0byBhY2Nlc3MgYW5kIHZhbGlkYXRlIHRoZSBNVFUgcHJlc2VudCBpbiB0aGUgY29uZmln
Cj4gPiA+ID4gPiA+ID4gc3BhY2UgYmVmb3JlIHZpcnRpbyBmZWF0dXJlcyBhcmUgc2V0Lgo+ID4g
PiA+ID4gPiBUaGlzIGxvb2tzIGxpa2UgYSBzcGVjIHZpb2xhdGlvbjoKPiA+ID4gPiA+ID4gCj4g
PiA+ID4gPiA+ICIKPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IFRoZSBmb2xsb3dpbmcgZHJpdmVy
LXJlYWQtb25seSBmaWVsZCwgbXR1IG9ubHkgZXhpc3RzIGlmCj4gPiA+ID4gPiA+IFZJUlRJT19O
RVRfRl9NVFUgaXMKPiA+ID4gPiA+ID4gc2V0Lgo+ID4gPiA+ID4gPiBUaGlzIGZpZWxkIHNwZWNp
ZmllcyB0aGUgbWF4aW11bSBNVFUgZm9yIHRoZSBkcml2ZXIgdG8gdXNlLgo+ID4gPiA+ID4gPiAi
Cj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiBEbyB3ZSByZWFsbHkgd2FudCB0byB3b3JrYXJvdW5k
IHRoaXM/Cj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiA+IEFuZCBhbHNv
Ogo+ID4gPiA+ID4gCj4gPiA+ID4gPiBUaGUgZHJpdmVyIE1VU1QgZm9sbG93IHRoaXMgc2VxdWVu
Y2UgdG8gaW5pdGlhbGl6ZSBhIGRldmljZToKPiA+ID4gPiA+IDEuIFJlc2V0IHRoZSBkZXZpY2Uu
Cj4gPiA+ID4gPiAyLiBTZXQgdGhlIEFDS05PV0xFREdFIHN0YXR1cyBiaXQ6IHRoZSBndWVzdCBP
UyBoYXMgbm90aWNlZCB0aGUgZGV2aWNlLgo+ID4gPiA+ID4gMy4gU2V0IHRoZSBEUklWRVIgc3Rh
dHVzIGJpdDogdGhlIGd1ZXN0IE9TIGtub3dzIGhvdyB0byBkcml2ZSB0aGUKPiA+ID4gPiA+IGRl
dmljZS4KPiA+ID4gPiA+IDQuIFJlYWQgZGV2aWNlIGZlYXR1cmUgYml0cywgYW5kIHdyaXRlIHRo
ZSBzdWJzZXQgb2YgZmVhdHVyZSBiaXRzCj4gPiA+ID4gPiB1bmRlcnN0b29kIGJ5IHRoZSBPUyBh
bmQgZHJpdmVyIHRvIHRoZQo+ID4gPiA+ID4gZGV2aWNlLiBEdXJpbmcgdGhpcyBzdGVwIHRoZSBk
cml2ZXIgTUFZIHJlYWQgKGJ1dCBNVVNUIE5PVCB3cml0ZSkKPiA+ID4gPiA+IHRoZSBkZXZpY2Ut
c3BlY2lmaWMgY29uZmlndXJhdGlvbgo+ID4gPiA+ID4gZmllbGRzIHRvIGNoZWNrIHRoYXQgaXQg
Y2FuIHN1cHBvcnQgdGhlIGRldmljZSBiZWZvcmUgYWNjZXB0aW5nIGl0Lgo+ID4gPiA+ID4gNS4g
U2V0IHRoZSBGRUFUVVJFU19PSyBzdGF0dXMgYml0LiBUaGUgZHJpdmVyIE1VU1QgTk9UIGFjY2Vw
dCBuZXcKPiA+ID4gPiA+IGZlYXR1cmUgYml0cyBhZnRlciB0aGlzIHN0ZXAuCj4gPiA+ID4gPiA2
LiBSZS1yZWFkIGRldmljZSBzdGF0dXMgdG8gZW5zdXJlIHRoZSBGRUFUVVJFU19PSyBiaXQgaXMg
c3RpbGwgc2V0Ogo+ID4gPiA+ID4gb3RoZXJ3aXNlLCB0aGUgZGV2aWNlIGRvZXMgbm90Cj4gPiA+
ID4gPiBzdXBwb3J0IG91ciBzdWJzZXQgb2YgZmVhdHVyZXMgYW5kIHRoZSBkZXZpY2UgaXMgdW51
c2FibGUuCj4gPiA+ID4gPiA3LiBQZXJmb3JtIGRldmljZS1zcGVjaWZpYyBzZXR1cCwgaW5jbHVk
aW5nIGRpc2NvdmVyeSBvZiB2aXJ0cXVldWVzCj4gPiA+ID4gPiBmb3IgdGhlIGRldmljZSwgb3B0
aW9uYWwgcGVyLWJ1cyBzZXR1cCwKPiA+ID4gPiA+IHJlYWRpbmcgYW5kIHBvc3NpYmx5IHdyaXRp
bmcgdGhlIGRldmljZeKAmXMgdmlydGlvIGNvbmZpZ3VyYXRpb24KPiA+ID4gPiA+IHNwYWNlLCBh
bmQgcG9wdWxhdGlvbiBvZiB2aXJ0cXVldWVzLgo+ID4gPiA+ID4gOC4gU2V0IHRoZSBEUklWRVJf
T0sgc3RhdHVzIGJpdC4gQXQgdGhpcyBwb2ludCB0aGUgZGV2aWNlIGlzIOKAnGxpdmXigJ0uCj4g
PiA+ID4gPiAKPiA+ID4gPiA+IAo+ID4gPiA+ID4gc28gYWNjZXNzaW5nIGNvbmZpZyBzcGFjZSBi
ZWZvcmUgRkVBVFVSRVNfT0sgaXMgYSBzcGVjIHZpb2xhdGlvbiwgcmlnaHQ/Cj4gPiA+ID4gSXQg
aXMsIGJ1dCBpdCdzIG5vdCByZWxldmFudCB0byB3aGF0IHRoaXMgY29tbWl0IHRyaWVzIHRvIGFk
ZHJlc3MuIEkKPiA+ID4gPiB0aG91Z2h0IHRoZSBsZWdhY3kgZ3Vlc3Qgc3RpbGwgbmVlZHMgdG8g
YmUgc3VwcG9ydGVkLgo+ID4gPiA+IAo+ID4gPiA+IEhhdmluZyBzYWlkLCBhIHNlcGFyYXRlIHBh
dGNoIGhhcyB0byBiZSBwb3N0ZWQgdG8gZml4IHRoZSBndWVzdCBkcml2ZXIKPiA+ID4gPiBpc3N1
ZSB3aGVyZSB0aGlzIGRpc2NyZXBhbmN5IGlzIGludHJvZHVjZWQgdG8gdmlydG5ldF92YWxpZGF0
ZSgpIChzaW5jZQo+ID4gPiA+IGNvbW1pdCBmZTM2Y2JlMDY3KS4gQnV0IGl0J3Mgbm90IHRlY2hu
aWNhbGx5IHJlbGF0ZWQgdG8gdGhpcyBwYXRjaC4KPiA+ID4gPiAKPiA+ID4gPiAtU2l3ZWkKPiA+
ID4gCj4gPiA+IEkgdGhpbmsgaXQncyBhIGJ1ZyB0byByZWFkIGNvbmZpZyBzcGFjZSBpbiB2YWxp
ZGF0ZSwgd2Ugc2hvdWxkIG1vdmUgaXQgdG8KPiA+ID4gdmlydG5ldF9wcm9iZSgpLgo+ID4gPiAK
PiA+ID4gVGhhbmtzCj4gPiBJIHRha2UgaXQgYmFjaywgcmVhZGluZyBidXQgbm90IHdyaXRpbmcg
c2VlbXMgdG8gYmUgZXhwbGljaXRseSBhbGxvd2VkIGJ5IHNwZWMuCj4gPiBTbyBvdXIgd2F5IHRv
IGRldGVjdCBhIGxlZ2FjeSBndWVzdCBpcyBib2d1cywgbmVlZCB0byB0aGluayB3aGF0IGlzCj4g
PiB0aGUgYmVzdCB3YXkgdG8gaGFuZGxlIHRoaXMuCj4gVGhlbiBtYXliZSByZXZlcnQgY29tbWl0
IGZlMzZjYmUwNjcgYW5kIGZyaWVuZHMsIGFuZCBoYXZlIFFFTVUgZGV0ZWN0IGxlZ2FjeQo+IGd1
ZXN0PyBTdXBwb3NlZGx5IG9ubHkgY29uZmlnIHNwYWNlIHdyaXRlIGFjY2VzcyBuZWVkcyB0byBi
ZSBndWFyZGVkIGJlZm9yZQo+IHNldHRpbmcgRkVBVFVSRVNfT0suCj4gCj4gLVNpd2llCgpEZXRl
Y3RpbmcgaXQgaXNuJ3QgZW5vdWdoIHRob3VnaCwgd2Ugd2lsbCBuZWVkIGEgbmV3IGlvY3RsIHRv
IG5vdGlmeQp0aGUga2VybmVsIHRoYXQgaXQncyBhIGxlZ2FjeSBndWVzdC4gVWdoIDooCgoKPiA+
ID4gPiA+IAo+ID4gPiA+ID4gPiA+IFJlamVjdGluZyByZXNldCB0byAwCj4gPiA+ID4gPiA+ID4g
cHJlbWF0dXJlbHkgY2F1c2VzIGNvcnJlY3QgTVRVIGFuZCBsaW5rIHN0YXR1cyB1bmFibGUgdG8g
bG9hZAo+ID4gPiA+ID4gPiA+IGZvciB0aGUgdmVyeSBmaXJzdCBjb25maWcgc3BhY2UgYWNjZXNz
LCByZW5kZXJpbmcgaXNzdWVzIGxpa2UKPiA+ID4gPiA+ID4gPiBndWVzdCBzaG93aW5nIGluYWNj
dXJhdGUgTVRVIHZhbHVlLCBvciBmYWlsdXJlIHRvIHJlamVjdAo+ID4gPiA+ID4gPiA+IG91dC1v
Zi1yYW5nZSBNVFUuCj4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gRml4ZXM6IDFhODZiMzc3
YWEyMSAoInZkcGEvbWx4NTogQWRkIFZEUEEgZHJpdmVyIGZvcgo+ID4gPiA+ID4gPiA+IHN1cHBv
cnRlZCBtbHg1IGRldmljZXMiKQo+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFNpLVdlaSBM
aXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4KPiA+ID4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+ID4g
PiAgwqDCoCBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCAxNSArLS0tLS0tLS0t
LS0tLS0KPiA+ID4gPiA+ID4gPiAgwqDCoCAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDE0IGRlbGV0aW9ucygtKQo+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+ID4gPiA+ID4gPiBiL2RyaXZl
cnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ID4gPiA+ID4gPiA+IGluZGV4IDdjMWY3ODku
LjU0MGRkNjcgMTAwNjQ0Cj4gPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvbmV0
L21seDVfdm5ldC5jCj4gPiA+ID4gPiA+ID4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21s
eDVfdm5ldC5jCj4gPiA+ID4gPiA+ID4gQEAgLTE0OTAsMTQgKzE0OTAsNiBAQCBzdGF0aWMgdTY0
Cj4gPiA+ID4gPiA+ID4gbWx4NV92ZHBhX2dldF9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2Ug
KnZkZXYpCj4gPiA+ID4gPiA+ID4gIMKgwqDCoMKgwqDCoCByZXR1cm4gbXZkZXYtPm1seF9mZWF0
dXJlczsKPiA+ID4gPiA+ID4gPiAgwqDCoCB9Cj4gPiA+ID4gPiA+ID4gLXN0YXRpYyBpbnQgdmVy
aWZ5X21pbl9mZWF0dXJlcyhzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsCj4gPiA+ID4gPiA+
ID4gdTY0IGZlYXR1cmVzKQo+ID4gPiA+ID4gPiA+IC17Cj4gPiA+ID4gPiA+ID4gLcKgwqDCoCBp
ZiAoIShmZWF0dXJlcyAmIEJJVF9VTEwoVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNKSkpCj4gPiA+
ID4gPiA+ID4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU9QTk9UU1VQUDsKPiA+ID4gPiA+ID4g
PiAtCj4gPiA+ID4gPiA+ID4gLcKgwqDCoCByZXR1cm4gMDsKPiA+ID4gPiA+ID4gPiAtfQo+ID4g
PiA+ID4gPiA+IC0KPiA+ID4gPiA+ID4gPiAgwqDCoCBzdGF0aWMgaW50IHNldHVwX3ZpcnRxdWV1
ZXMoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYpCj4gPiA+ID4gPiA+ID4gIMKgwqAgewo+ID4g
PiA+ID4gPiA+ICDCoMKgwqDCoMKgwqAgaW50IGVycjsKPiA+ID4gPiA+ID4gPiBAQCAtMTU1OCwx
OCArMTU1MCwxMyBAQCBzdGF0aWMgaW50Cj4gPiA+ID4gPiA+ID4gbWx4NV92ZHBhX3NldF9mZWF0
dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHU2NAo+ID4gPiA+ID4gPiA+IGZlYXR1cmVz
KQo+ID4gPiA+ID4gPiA+ICDCoMKgIHsKPiA+ID4gPiA+ID4gPiAgwqDCoMKgwqDCoMKgIHN0cnVj
dCBtbHg1X3ZkcGFfZGV2ICptdmRldiA9IHRvX212ZGV2KHZkZXYpOwo+ID4gPiA+ID4gPiA+ICDC
oMKgwqDCoMKgwqAgc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYgPSB0b19tbHg1X3ZkcGFfbmRl
dihtdmRldik7Cj4gPiA+ID4gPiA+ID4gLcKgwqDCoCBpbnQgZXJyOwo+ID4gPiA+ID4gPiA+ICDC
oMKgwqDCoMKgwqAgcHJpbnRfZmVhdHVyZXMobXZkZXYsIGZlYXR1cmVzLCB0cnVlKTsKPiA+ID4g
PiA+ID4gPiAtwqDCoMKgIGVyciA9IHZlcmlmeV9taW5fZmVhdHVyZXMobXZkZXYsIGZlYXR1cmVz
KTsKPiA+ID4gPiA+ID4gPiAtwqDCoMKgIGlmIChlcnIpCj4gPiA+ID4gPiA+ID4gLcKgwqDCoMKg
wqDCoMKgIHJldHVybiBlcnI7Cj4gPiA+ID4gPiA+ID4gLQo+ID4gPiA+ID4gPiA+ICDCoMKgwqDC
oMKgwqAgbmRldi0+bXZkZXYuYWN0dWFsX2ZlYXR1cmVzID0gZmVhdHVyZXMgJgo+ID4gPiA+ID4g
PiA+IG5kZXYtPm12ZGV2Lm1seF9mZWF0dXJlczsKPiA+ID4gPiA+ID4gPiAgwqDCoMKgwqDCoMKg
IG5kZXYtPmNvbmZpZy5tdHUgPSBjcHVfdG9fbWx4NXZkcGExNihtdmRldiwgbmRldi0+bXR1KTsK
PiA+ID4gPiA+ID4gPiAgwqDCoMKgwqDCoMKgIG5kZXYtPmNvbmZpZy5zdGF0dXMgfD0gY3B1X3Rv
X21seDV2ZHBhMTYobXZkZXYsCj4gPiA+ID4gPiA+ID4gVklSVElPX05FVF9TX0xJTktfVVApOwo+
ID4gPiA+ID4gPiA+IC3CoMKgwqAgcmV0dXJuIGVycjsKPiA+ID4gPiA+ID4gPiArwqDCoMKgIHJl
dHVybiAwOwo+ID4gPiA+ID4gPiA+ICDCoMKgIH0KPiA+ID4gPiA+ID4gPiAgwqDCoCBzdGF0aWMg
dm9pZCBtbHg1X3ZkcGFfc2V0X2NvbmZpZ19jYihzdHJ1Y3QgdmRwYV9kZXZpY2UKPiA+ID4gPiA+
ID4gPiAqdmRldiwgc3RydWN0IHZkcGFfY2FsbGJhY2sgKmNiKQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
