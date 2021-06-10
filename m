Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C058C48BCD
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 06:00:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF2F3613BD
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 06:00:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2F3613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A42A8608FD;
	Thu, 10 Jun 2021 06:00:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e9x7OFgbvg-e; Thu, 10 Jun 2021 06:00:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4C00760866;
	Thu, 10 Jun 2021 06:00:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D96AC000E;
	Thu, 10 Jun 2021 06:00:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4F63C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 06:00:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C2AC783CB4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 06:00:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sFXw0kQQaMBN
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 06:00:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8221B83CBB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 06:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623304806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=chdM2P0E9KTZ0rMDcd+EOBB5Vy3nv7q/7HQrSuV4meI=;
 b=g89axe3HKM+X5Ghx1CX2SAmFU1YimCvxG8ccZCSfxjdgoRhE6ZFw+nBwzFDGjAde2Glonn
 dHJ3gbM0DIm8LNV9099lpNi+MXW03Y9mg0g+ls2hE0GEZmq+aaAW00zlAhwuSWTfMfNZdx
 Ya84D4nM4tIS3ZJXWRs9qMv/JnHk1Ms=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-BrNOHkdRNwed5QU1ANVzvA-1; Thu, 10 Jun 2021 02:00:04 -0400
X-MC-Unique: BrNOHkdRNwed5QU1ANVzvA-1
Received: by mail-pj1-f72.google.com with SMTP id
 15-20020a17090a0f0fb029016ad0f32fd0so2849518pjy.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Jun 2021 23:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=chdM2P0E9KTZ0rMDcd+EOBB5Vy3nv7q/7HQrSuV4meI=;
 b=pJ4u01hffBexE8R4s+Zr/c1D5J/wiX8Pk/2tKflMFONahdg+OFHXECI8ol+V2AFFkg
 8uYG68I2otcmQ1/bBT6fF10rCgOV/r1gBMQdXnCHfk3PP/wo22Hb8+VWgyS4ZsWJ25n/
 4wGKbPMKI6152T/nqcZMUnsJu2AOpUJ4jaGJjTP4V6nQJ7jnwaWZOfe0kLD/kFcpN8Gk
 kvGobYqlFOEGKcu+Sj6jX5zZZqt+v9bAwK3XCgV1+RewzAXxglzODAhHIOS0ysB9/DbD
 NN3IIv1tNVuD7bRfH9V3EHJ4BdNCl4WY0pOr4i9CK9jU139Dnwth6nDrj4sZRL/WOj+4
 HKLg==
X-Gm-Message-State: AOAM532n1XKdx7HOTMfkSPA630G+xXv/6AFoPayNb6/a/s59zmzgSCbM
 NUkUp18McwQbsKP++1ROjFkR9NfULkCkZEeeAxhVQiotIWR3BIbNYtzh+kfn1eAVm+A3NqN7Q2s
 ymYKxZOPipig5jHnZEGNz2atBcVcvs/DSvb/ArnFQ6nee+eIUzpfjEP1Tp344TnuQAb9uFnwboC
 jAOY6ZLtBDf2ZfnyQTrw==
X-Received: by 2002:a63:5c4a:: with SMTP id n10mr3406952pgm.279.1623304802565; 
 Wed, 09 Jun 2021 23:00:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVCxkXOGqKiF3S9LEPFcEybx+MHL3gA2j+6gxHrUZMMg1SnNUTq/bJ6Ykc+kXUfVcINsBZuw==
X-Received: by 2002:a63:5c4a:: with SMTP id n10mr3406919pgm.279.1623304802225; 
 Wed, 09 Jun 2021 23:00:02 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id p14sm1580906pgb.2.2021.06.09.22.59.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jun 2021 23:00:01 -0700 (PDT)
Subject: Re: Security hole in vhost-vdpa?
To: Gautam Dawar <gdawar@xilinx.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <BY5PR02MB6980228A5EA2D021A3F9F47BB1399@BY5PR02MB6980.namprd02.prod.outlook.com>
 <20210606173637-mutt-send-email-mst@kernel.org>
 <82e91727-79f4-b6f1-37f1-9fb5bdf67b8d@redhat.com>
 <20210610002358-mutt-send-email-mst@kernel.org>
 <MN2PR02MB6991BB8836C3688B9EDDD136B1359@MN2PR02MB6991.namprd02.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c7685abe-a979-0877-900a-611d9518eeca@redhat.com>
Date: Thu, 10 Jun 2021 13:59:58 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <MN2PR02MB6991BB8836C3688B9EDDD136B1359@MN2PR02MB6991.namprd02.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Martin Petrus Hubertus Habets <martinh@xilinx.com>,
 Harpreet Singh Anand <hanand@xilinx.com>,
 "virtualization@lists.linux-foundation.org"
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIxLzYvMTAg5LiL5Y2IMTowMCwgR2F1dGFtIERhd2FyIOWGmemBkzoKPiBQbHMgc2Vl
IGlubGluZQo+Cj4gUmVnYXJkcywKPiBHYXV0YW0KPgo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tCj4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luPG1zdEByZWRoYXQuY29tPiAgCj4gU2VudDog
VGh1cnNkYXksIEp1bmUgMTAsIDIwMjEgMTA6MDAgQU0KPiBUbzogSmFzb24gV2FuZzxqYXNvd2Fu
Z0ByZWRoYXQuY29tPgo+IENjOiBHYXV0YW0gRGF3YXI8Z2Rhd2FyQHhpbGlueC5jb20+OyBIYXJw
cmVldCBTaW5naCBBbmFuZDxoYW5hbmRAeGlsaW54LmNvbT47IE1hcnRpbiBQZXRydXMgSHViZXJ0
dXMgSGFiZXRzPG1hcnRpbmhAeGlsaW54LmNvbT47dmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKPiBTdWJqZWN0OiBSZTogU2VjdXJpdHkgaG9sZSBpbiB2aG9zdC12ZHBh
Pwo+Cj4gT24gTW9uLCBKdW4gMDcsIDIwMjEgYXQgMTA6MTA6MDNBTSArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZToKPj4g5ZyoIDIwMjEvNi83IOS4iuWNiDU6MzgsIE1pY2hhZWwgUy4gVHNpcmtpbiDl
hpnpgZM6Cj4+PiBPbiBTdW4sIEp1biAwNiwgMjAyMSBhdCAwMjozOTo0OFBNICswMDAwLCBHYXV0
YW0gRGF3YXIgd3JvdGU6Cj4+Pj4gSGkgQWxsLAo+Pj4+Cj4+Pj4KPj4+PiBUaGlzIGlzIGluIGNv
bnRpbnVhdGlvbiB0byBteSBmaW5kaW5ncyBub3RlZCBpbiBCdWcgMjEzMTc5IGFuZAo+Pj4+IGRp
c2N1c3Npb25zIHdlIGhhdmUgaGFkIGluIHRoZSBsYXN0IGNvdXBsZSBvZiB3ZWVrcyBvdmVyIGVt
YWlscy4KPj4+Pgo+Pj4+Cj4+Pj4gVG9kYXksIEkgcHVibGlzaGVkIHRoZSBmaXJzdCBwYXRjaCBm
b3IgdGhpcyBpc3N1ZSB3aGljaCBhZGRzCj4+Pj4gdGltZW91dCBiYXNlZCB3YWl0IGZvciBjb21w
bGV0aW9uIGV2ZW50IGFuZCBhbHNvIGxvZ3MgYSB3YXJuaW5nCj4+Pj4gbWVzc2FnZSB0byBhbGVy
dCB0aGUgdXNlci8gYWRtaW5pc3RyYXRvciBvZiB0aGUgcHJvYmxlbS4KPj4+IENhbid0IGNsb3Nl
IGp1c3QgZmluaXNoIHdpdGhvdXQgd2FpdGluZyBmb3IgdXNlcnNwYWNlPwo+PiBJdCB3b3JrcyBh
cyBsb25nIGFzIHdlIGRvbid0IHVzZSBtbWFwKCkuIFdoZW4gd2UgbWFwIGtpY2tzLCBpdCBsb29r
cwo+PiB0byBtZSB0aGVyZSdzIG5vIHdheSB0byAicmV2b2tlIiB0aGUgbWFwcGluZyBmcm9tIHVz
ZXJzcGFjZT8KPj4KPj4gVGhhbmtzCj4gQ2FuJ3Qgd2UgdHJhY2sgdGhlc2UgbWFwcGluZ3MgYW5k
IG1hcCBzb21lIG90aGVyIHBhZ2UgdGhlcmU/Cj4gTGlrZWx5IG5vIG1vcmUgdGhhbiBvbmUgaXMg
bmVlZGVkIC4uLgo+Cj4gW0dEPj5dIEkgYW0gd29ya2luZyBvbiBhIHNvbHV0aW9uIHRoYXQgaXMg
bGltaXRlZCB0byBrZXJuZWwgc3BhY2Ugb25seSBhbmQgZG9lc24ndCBkZXBlbmQgb24gdXNlcnNw
YWNlIGFwcGxpY2F0aW9uICh3aGljaCBjb3VsZCBiZSBhIG1hbGljaW91cyBvbmUpLgo+IFdpbGwg
c2hhcmUgbW9yZSB1cGRhdGVzIGluIGEgY291cGxlIG9mIGRheXMuCgoKQ29vbC4gTGV0J3Mgc2Vl
LgoKVGhhbmtzCgoKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
