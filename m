Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74547C433EF
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 08:16:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DDDB61002
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 08:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1DDDB61002
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D96FE40192;
	Mon, 25 Oct 2021 08:16:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1rFkz_2oAraz; Mon, 25 Oct 2021 08:16:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2F62B400DA;
	Mon, 25 Oct 2021 08:16:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0224BC0019;
	Mon, 25 Oct 2021 08:16:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9350C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 08:16:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AC1A180EC0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 08:16:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D3xQ8-9bWbko
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 08:16:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B156B80EBE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 08:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635149788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BiUoX4X+hVb9BvQ1tuQ2emrLo0O9NwtRBNPgq/ug79w=;
 b=ab83Yg7a5O8FvIyKxb8+3KPAfYchWgPuL8b0HCmV9VU3femP+GOxtwCcZdZ+wCO5MNKp/T
 jddf4LVCf7kDm4fxFWJAN2ltWH+/ex411MLGQEW9oKqzjHvFjVMt3dxqNl4oY6XwbZYskY
 Z5UUl50ZsNdhwXe+wL9m3SXxjgpaF00=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-UKz4qowlNLCEUVLM_p_x3Q-1; Mon, 25 Oct 2021 04:16:27 -0400
X-MC-Unique: UKz4qowlNLCEUVLM_p_x3Q-1
Received: by mail-ed1-f71.google.com with SMTP id
 c25-20020a056402143900b003dc19782ea8so9175781edx.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 01:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=BiUoX4X+hVb9BvQ1tuQ2emrLo0O9NwtRBNPgq/ug79w=;
 b=SlYhzpNn0IZLdLekJWPJb5A9ORd/UskPz7tWyMFQ4FUQeHMTHb/4I4kfeSTHjhpiS+
 MdlMq6nDzhL9j319XQE7Qsb2cwMlOnCnCUPRgFsdVC15nzAikcy8WFM3QASRpH/U7EbM
 RusyzWArbY/yddmtFu0OXPmputtNQCpEtcmQz6beVj+9WXrHKEXqwIP8JgUVbVhiFdvF
 ta9qjIG6uu8y0H6mgbdE0ukSpIhcnzc0r4sKYeYsuvj9+TGppgQeuk1sEU7LFk6RkCf+
 tKdvGVqS4LYBH0A4LBVAcHHVBN/Ig9aFK9OAAmFFqd/+CrACVYVOMEJbLbGDsrJzQ9ht
 hhPg==
X-Gm-Message-State: AOAM532g9sVZyNBEfRGQldaFPdLcFvV6YAfU+OKofpsg/sAN/Es05gOg
 PqeWUS94m/8n+kajmbUVbp6VVpntXumCX/K6tPpJAv+JPoz8vhtK83akS0gRuzIsgP8r94F49cM
 NgFIPFbmD2FWDaTCNHCfD+oP4xUwyzOpCHexH6r24nw==
X-Received: by 2002:aa7:c846:: with SMTP id g6mr24431828edt.51.1635149786004; 
 Mon, 25 Oct 2021 01:16:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzw6g//LBbKjt1o7DMqNXOogFpFCwwXZHrHa1yHlWCTCQnPJ5woVcSr0bdDu7JZSmkRe1kY8w==
X-Received: by 2002:aa7:c846:: with SMTP id g6mr24431809edt.51.1635149785880; 
 Mon, 25 Oct 2021 01:16:25 -0700 (PDT)
Received: from redhat.com ([2.55.151.113])
 by smtp.gmail.com with ESMTPSA id e7sm9083741edk.3.2021.10.25.01.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Oct 2021 01:16:25 -0700 (PDT)
Date: Mon, 25 Oct 2021 04:16:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH linux-next v4 5/8] vdpa_sim_net: Enable user to set mac
 address and mtu
Message-ID: <20211025041220-mutt-send-email-mst@kernel.org>
References: <20211021163509.6978-1-parav@nvidia.com>
 <20211021163509.6978-6-parav@nvidia.com>
 <03d8d907-f54d-f9e2-a058-fd8d50ff927e@redhat.com>
 <PH0PR12MB54818C925D446110117F01DCDC839@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211025040853-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481624C8C6F35197B5AF6A1DC839@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481624C8C6F35197B5AF6A1DC839@PH0PR12MB5481.namprd12.prod.outlook.com>
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

T24gTW9uLCBPY3QgMjUsIDIwMjEgYXQgMDg6MTA6MTVBTSArMDAwMCwgUGFyYXYgUGFuZGl0IHdy
b3RlOgo+IAo+IAo+ID4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4K
PiA+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAyNSwgMjAyMSAxOjM5IFBNCj4gPiAKPiA+IE9uIE1v
biwgT2N0IDI1LCAyMDIxIGF0IDA3OjExOjIzQU0gKzAwMDAsIFBhcmF2IFBhbmRpdCB3cm90ZToK
PiA+ID4KPiA+ID4KPiA+ID4gPiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
Pgo+ID4gPiA+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAyNSwgMjAyMSAxMjozMiBQTQo+ID4gPiA+
Cj4gPiA+ID4KPiA+ID4gPiDlnKggMjAyMS8xMC8yMiDkuIrljYgxMjozNSwgUGFyYXYgUGFuZGl0
IOWGmemBkzoKPiA+ID4gPiA+IEVuYWJsZSB1c2VyIHRvIHNldCB0aGUgbWFjIGFkZHJlc3MgYW5k
IG10dSBzbyB0aGF0IGVhY2ggdmRwYQo+ID4gPiA+ID4gZGV2aWNlIGNhbiBoYXZlIGl0cyBvd24g
dXNlciBzcGVjaWZpZWQgbWFjIGFkZHJlc3MgYW5kIG10dS4KPiA+ID4gPiA+IFRoaXMgaXMgZG9u
ZSBieSBpbXBsZW1lbnRpbmcgdGhlIG1hbmFnZW1lbnQgZGV2aWNlJ3MgY29uZmlndXJhdGlvbgo+
ID4gPiA+ID4gbGF5b3V0IGZpZWxkcyBzZXR0aW5nIGNhbGxiYWNrIHJvdXRpbmUuCj4gPiA+ID4g
Pgo+ID4gPiA+ID4gTm93IHRoYXQgdXNlciBpcyBlbmFibGVkIHRvIHNldCB0aGUgbWFjIGFkZHJl
c3MsIHJlbW92ZSB0aGUgbW9kdWxlCj4gPiA+ID4gPiBwYXJhbWV0ZXIgZm9yIHNhbWUuCj4gPiA+
ID4gPgo+ID4gPiA+ID4gQW5kIGV4YW1wbGUgb2Ygc2V0dGluZyBtYWMgYWRkciBhbmQgbXR1Ogo+
ID4gPiA+ID4gJCB2ZHBhIG1nbXRkZXYgc2hvdwo+ID4gPiA+ID4KPiA+ID4gPiA+ICQgdmRwYSBk
ZXYgYWRkIG5hbWUgYmFyIG1nbXRkZXYgdmRwYXNpbV9uZXQgJCB2ZHBhIGRldiBjb25maWcgc2V0
Cj4gPiA+ID4gPiBiYXIgbWFjIDAwOjExOjIyOjMzOjQ0OjU1IG10dSA5MDAwCj4gPiA+ID4KPiA+
ID4gPgo+ID4gPiA+IFRoZSBhdHRyaWJ1dGVzIHdlcmUgc2V0IGR1cmluZyBkZXYgYWRkIGlmIEkg
d2FzIG5vdCB3cm9uZy4KPiA+ID4gPgo+ID4gPiBZb3UgYXJlIHJpZ2h0LiBJIG1pc3NlZCB0byB1
cGRhdGUgdGhlIGV4YW1wbGUgaGVyZS4gQ29kZSBpcyBqdXN0IGZpbmUuCj4gPiA+Cj4gPiA+ID4g
VGhhbmtzCj4gPiA+ID4KPiA+IAo+ID4gV2FudCB0byBzZW5kIGEgY29ycmVjdGVkIGNvbW1pdCBs
b2c/Cj4gWWVzLiB3b3VsZCBsaWtlIHRvIHNlbmQgdjUgd2l0aCB0aGUgY29ycmVjdGVkIGNvbW1p
dCBsb2cgYW5kIEFDSyBmcm9tIEphc29uIG9uIG90aGVyIHBhdGNoZXMuCgpHbyBhaGVhZCwgSSB3
aWxsIHBpY2sgaXQgdXAgaWYgbWVyZ2Ugd2luZG93IGRvZXMgbm90IG9wZW4geWV0LgoKVGhlcmUg
d2FzIGFsc28gb25lIGNvbW1lbnQgYnkgSmFzb24geW91IGRpZG4ndCByZXNvbHZlIHBhdGNoIDEg
SSB0aGluaz8uCkFuZCBpdCBjYW4ndCBodXJ0IHRvIGFkZCBhIGNvbW1lbnQgbmVhciB0aGUgY2Fw
YWJpbGl0eSBjaGVjawpleHBsYWluaW5nIHdoeSBkb24ndCBjaGVjayBpZiBubyBhdHRyaWJ1dGVz
LgoKLS0gCk1TVAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
