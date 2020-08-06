Return-Path: <SRS0=OwTx=BQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6684C433E0
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 11:51:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AD1922CF7
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 11:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJSZquCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD1922CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0DC0E887C1;
	Thu,  6 Aug 2020 05:53:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BoEL08MLd-8o; Thu,  6 Aug 2020 05:53:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 28DC288780;
	Thu,  6 Aug 2020 05:53:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1693BC0050;
	Thu,  6 Aug 2020 05:53:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC5C8C004C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 05:53:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CFC2A88782
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 05:53:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R+R8YCw6gtdo
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 05:53:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E1AA088780
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 05:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596693194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g0AG8W/Xs0dRN98tWfYfSB2XGEBT9FxGN8gSm2qY254=;
 b=fJSZquCOxOFKzkNh2x7kOF0rJB5tTrsnLAsR0MS33EU49omBMjxD0wq0lQ1wFGk+CRAre+
 wqZIpKTleMxHPQnkOe0n1xMklAEfFvCJHhsIjVq3rB6tuSQhtzd/Uq7hYpVk1w4YXSTzAj
 oM37i24buqvz+o5xUol1988Q+lU5H8g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-OlXg88TCOGyurV3I9SsErA-1; Thu, 06 Aug 2020 01:53:12 -0400
X-MC-Unique: OlXg88TCOGyurV3I9SsErA-1
Received: by mail-wr1-f70.google.com with SMTP id f14so14232634wrm.22
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 22:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=g0AG8W/Xs0dRN98tWfYfSB2XGEBT9FxGN8gSm2qY254=;
 b=e/KutIgVfwiad2X0q26sXBYE6McsliU2kJPGbtVwPEQqGVcFs/ym9rYtKlIlQCd5Zf
 kqRXtMJEQrjNdRib9VECAw2MqERVAsp9gt52KXTl+dG5PQoXTzd8FLg8+dBuH/epmbAt
 wyJN2/TJrJckrydsm/aUbCPrucr4/Ow24yctP2K7KzOf0PEorB3C6IXCakmUOErt4EKP
 U0qyJdgf/lClEJCPVxDhsZbsstKkpXNKQQT3+oTteBXZ8TQXg60qq2kik75RIKzwU4Pa
 m4VYivFzfBgmHIrhlmcwyL2lFZjOiwGzIlEvKPiVwnyAjMZ7jpkLhXz+8dsrS8GWB+GU
 BcaQ==
X-Gm-Message-State: AOAM531xLX1LtH0GSw7u5i7wp6cRaNkoOZ3A7ILlCmb+X08bdWjBVc6i
 2phO3Jw2OV/T+kLF7M2Wvyb6KJwDQlw1wBKdDaDgSf2h3/Lxs1zqXnD7EeJ4OdGyvHF/9GuvCS/
 YObGSgIyghCz53y6RnSZirRGmZRyXnM6mdgpeeL5nEQ==
X-Received: by 2002:a7b:c7c6:: with SMTP id z6mr6718363wmk.17.1596693191726;
 Wed, 05 Aug 2020 22:53:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8a6tMavB7+5XSSwiab+2Y4P011aP3x8ME+5gxJCOmpF1HTdWOiE5IV+wyb5jc2wMEZEBy6w==
X-Received: by 2002:a7b:c7c6:: with SMTP id z6mr6718355wmk.17.1596693191496;
 Wed, 05 Aug 2020 22:53:11 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id f15sm4931149wmj.39.2020.08.05.22.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 22:53:10 -0700 (PDT)
Date: Thu, 6 Aug 2020 01:53:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 19/24] vdpa: make sure set_features in invoked for
 legacy
Message-ID: <20200806015112-mutt-send-email-mst@kernel.org>
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-20-mst@redhat.com>
 <9e47d227-f220-4651-dcb9-7a11f059a715@redhat.com>
 <20200805073929-mutt-send-email-mst@kernel.org>
 <bd915b30-0604-da1b-343f-e228bce4d1d8@redhat.com>
MIME-Version: 1.0
In-Reply-To: <bd915b30-0604-da1b-343f-e228bce4d1d8@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

T24gVGh1LCBBdWcgMDYsIDIwMjAgYXQgMTE6MjM6MDVBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIwLzgvNSDkuIvljYg3OjQwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6
Cj4gPiBPbiBXZWQsIEF1ZyAwNSwgMjAyMCBhdCAwMjoxNDowN1BNICswODAwLCBKYXNvbiBXYW5n
IHdyb3RlOgo+ID4gPiBPbiAyMDIwLzgvNCDkuIrljYg1OjAwLCBNaWNoYWVsIFMuIFRzaXJraW4g
d3JvdGU6Cj4gPiA+ID4gU29tZSBsZWdhY3kgZ3Vlc3RzIGp1c3QgYXNzdW1lIGZlYXR1cmVzIGFy
ZSAwIGFmdGVyIHJlc2V0Lgo+ID4gPiA+IFdlIGRldGVjdCB0aGF0IGNvbmZpZyBzcGFjZSBpcyBh
Y2Nlc3NlZCBiZWZvcmUgZmVhdHVyZXMgYXJlCj4gPiA+ID4gc2V0IGFuZCBzZXQgZmVhdHVyZXMg
dG8gMCBhdXRvbWF0aWNhbGx5Lgo+ID4gPiA+IE5vdGU6IHNvbWUgbGVnYWN5IGd1ZXN0cyBtaWdo
dCBub3QgZXZlbiBhY2Nlc3MgY29uZmlnIHNwYWNlLCBpZiB0aGlzIGlzCj4gPiA+ID4gcmVwb3J0
ZWQgaW4gdGhlIGZpZWxkIHdlIG1pZ2h0IG5lZWQgdG8gY2F0Y2ggYSBraWNrIHRvIGhhbmRsZSB0
aGVzZS4KPiA+ID4gSSB3b25kZXIgd2hldGhlciBpdCdzIGVhc2llciB0byBqdXN0IHN1cHBvcnQg
bW9kZXJuIGRldmljZT8KPiA+ID4gCj4gPiA+IFRoYW5rcwo+ID4gV2VsbCBoYXJkd2FyZSB2ZW5k
b3JzIGFyZSBJIHRoaW5rIGludGVyZXN0ZWQgaW4gc3VwcG9ydGluZyBsZWdhY3kKPiA+IGd1ZXN0
cy4gTGltaXRpbmcgdmRwYSB0byBtb2Rlcm4gb25seSB3b3VsZCBtYWtlIGl0IHVuY29tcGV0aXRp
dmUuCj4gCj4gCj4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0LCBJT01NVV9QTEFURk9STSBpcyBt
YW5kYXRvcnkgZm9yIGhhcmR3YXJlIHZEUEEgdG8KPiB3b3JrLgoKSG1tIEkgZG9uJ3QgcmVhbGx5
IHNlZSB3aHkuIEFzc3VtZSBob3N0IG1hcHMgZ3Vlc3QgbWVtb3J5IHByb3Blcmx5LApWTSBkb2Vz
IG5vdCBoYXZlIGFuIElPTU1VLCBsZWdhY3kgZ3Vlc3QgY2FuIGp1c3Qgd29yay4KCkNhcmUgZXhw
bGFpbmluZyB3aGF0J3Mgd3Jvbmcgd2l0aCB0aGlzIHBpY3R1cmU/CgoKPiBTbyBpdCBjYW4gb25s
eSB3b3JrIGZvciBtb2Rlcm4gZGV2aWNlIC4uLgo+IAo+IFRoYW5rcwo+IAo+IAo+ID4gCj4gPiAK
PiA+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
