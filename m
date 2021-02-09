Return-Path: <SRS0=H/CR=HL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DBFC433DB
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 09:28:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D64464E16
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 09:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D64464E16
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1B4DD8737E;
	Tue,  9 Feb 2021 09:28:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WOsgbBPDU9OK; Tue,  9 Feb 2021 09:28:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 231A6873C6;
	Tue,  9 Feb 2021 09:28:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1AAC6C0891;
	Tue,  9 Feb 2021 09:28:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05A56C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 09:28:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E15C88737E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 09:28:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TXcLRGegw4BJ
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 09:28:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A852386B05
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 09:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612862611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BVmWIv//iucXq6uCAj+vo+FMJ8H4hs+IHQRTElKDAL8=;
 b=NiUYgfsMOvf//2eFXzWnq7cUAgH7kFuXTgb63TpXg4U+LjS404Lg2+d18P82WefULQLq66
 Xpb7p0Td0Sp/1qcB+FxP2OFvnHu5k3ETLiHDYA4DVy6PirOvgfM4Ogp5NW1NRtDtsZJg//
 y2umQBCv/oIge2O+jsWrFVZ+A5icviA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-Jtw2CXPjO3WGpWwlIcMuSg-1; Tue, 09 Feb 2021 04:23:27 -0500
X-MC-Unique: Jtw2CXPjO3WGpWwlIcMuSg-1
Received: by mail-wr1-f70.google.com with SMTP id l7so16362053wrp.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Feb 2021 01:23:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=BVmWIv//iucXq6uCAj+vo+FMJ8H4hs+IHQRTElKDAL8=;
 b=YihYfXLzgtrL7h7JpN0vqlmz/+XtpRH9D/W/rBb7/fLpnjeY9N90uTTyV1oN+heO4H
 CVlkhSmtvCmYSnUH8tuMNFu11gavfudauKbdTdUeqaEnusL4xuKtoSDIehiGNeFziusA
 ed8GbWzQpVsqLOZttoTtIjDTgZn8oyexRFuPCQSVVsT65yP0ib2CMXuzDWBxXst++0nr
 Fqt4lbrO1tEXl+lo9BkZ/IHgwGO9dIdGSeZTGGoxqRLU/Z8Ecf2s1YCdhyiqziyH+tec
 FFKWhQVcedK+X6OfW49WgHGUpLgD84OLkYQev4qOKfJfoq9RW7tgLXEk1d7Sj2IF6W7/
 i7OQ==
X-Gm-Message-State: AOAM530g8TMO82m06XaT3+yVYi67QO6IV7dP9aFjNoCdeAfKFeakVo3E
 boPezaIcP3LhZfvvx+Jv6Op42yV1f0qf9DEQDpAGPhSW+1uDozAYbSPUPdTZBqCQ1lXTXGm/4nT
 R3X8vRFpGn4UfxYW9Kaj/EOzy7ECtcADhpvXNijtsLQ==
X-Received: by 2002:a5d:6189:: with SMTP id j9mr24283587wru.256.1612862606525; 
 Tue, 09 Feb 2021 01:23:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyEgCfd2YHE4LE5EhAHm3i1Bv4aGPtqQBNsL7PCyfGHd2rtLbahxTUalPUc43FnbGJPrFPd3w==
X-Received: by 2002:a5d:6189:: with SMTP id j9mr24283573wru.256.1612862606374; 
 Tue, 09 Feb 2021 01:23:26 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id t17sm3415997wmi.20.2021.02.09.01.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Feb 2021 01:23:25 -0800 (PST)
Date: Tue, 9 Feb 2021 04:23:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 16/19] virtio-pci: introduce modern device module
Message-ID: <20210209042000-mutt-send-email-mst@kernel.org>
References: <20210104065503.199631-1-jasowang@redhat.com>
 <20210104065503.199631-17-jasowang@redhat.com>
 <20210205103214-mutt-send-email-mst@kernel.org>
 <24cb3ebe-1248-3e31-0716-cf498cf1d728@redhat.com>
 <20210208070253-mutt-send-email-mst@kernel.org>
 <fe639f0f-d639-3c3c-e297-042127788aca@redhat.com>
MIME-Version: 1.0
In-Reply-To: <fe639f0f-d639-3c3c-e297-042127788aca@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: shahafs@mellanox.com, lulu@redhat.com, rdunlap@infradead.org,
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

T24gVHVlLCBGZWIgMDksIDIwMjEgYXQgMTE6Mjk6NDZBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIxLzIvOCDkuIvljYg4OjA0LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6
Cj4gPiBPbiBNb24sIEZlYiAwOCwgMjAyMSBhdCAwMTo0MjoyN1BNICswODAwLCBKYXNvbiBXYW5n
IHdyb3RlOgo+ID4gPiBPbiAyMDIxLzIvNSDkuIvljYgxMTozNCwgTWljaGFlbCBTLiBUc2lya2lu
IHdyb3RlOgo+ID4gPiA+IE9uIE1vbiwgSmFuIDA0LCAyMDIxIGF0IDAyOjU1OjAwUE0gKzA4MDAs
IEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nPGph
c293YW5nQHJlZGhhdC5jb20+Cj4gPiA+ID4gSSBkb24ndCBleGFjdGx5IGdldCB3aHkgd2UgbmVl
ZCB0byBzcGxpdCB0aGUgbW9kZXJuIGRyaXZlciBvdXQsCj4gPiA+ID4gYW5kIGl0IGNhbiBjb25m
dXNlIHBlb3BsZSB3aG8gYXJlIHVzZWQgdG8gYmUgc2VlaW5nIHZpcnRpby1wY2kuCj4gPiA+IAo+
ID4gPiBUaGUgdmlydGlvLXBjaSBtb2R1bGUgc3RpbGwgdGhlcmUuIE5vIHVzZXIgdmlzaWJsZSBj
aGFuZ2VzLiBKdXN0IHNvbWUgY29kZXMKPiA+ID4gdGhhdCBjb3VsZCBiZSBzaGFyZWQgd2l0aCBv
dGhlciBkcml2ZXIgd2VyZSBzcGxpdCBvdXQuCj4gPiA+IAo+ID4gV2hhdCBJIGFtIHNheWluZyBp
cyB0aGlzOiB3ZSBjYW4gaGF2ZSB2aXJ0aW8tdmRwYSBkZXBlbmQgb24KPiA+IHZpcnRpby1wY2kg
d2l0aG91dCBzcGxpdHRpbmcgdGhlIGNvbW1vbiBjb2RlIG91dCB0byBhbgo+ID4gZXh0cmEgbW9k
dWxlLgo+IAo+IAo+IE9rLgo+IAo+IAo+ID4gCj4gPiA+ID4gVGhlIHZkcGEgdGhpbmcgc28gZmFy
IGxvb2tzIGxpa2UgYSBkZXZlbG9wbWVudCB0b29sLCB3aHkgZG8KPiA+ID4gPiB3ZSBjYXJlIHRo
YXQgaXQgZGVwZW5kcyBvbiBhIGJpdCBvZiBleHRyYSBjb2RlPwo+ID4gPiAKPiA+ID4gSWYgSSdt
IG5vdCBtaXN1bmRlcnN0YW5kaW5nLCB0cnlpbmcgdG8gc2hhcmUgY29kZXMgaXMgcHJvcG9zZWQg
YnkgeW91IGhlcmU6Cj4gPiA+IAo+ID4gPiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAyMC82LzEw
LzIzMgo+ID4gPiAKPiA+ID4gV2UgYWxzbyBoYWQgdGhlIHBsYW4gdG8gY29udmVydCBJRkNWRiB0
byB1c2UgdGhpcyBsaWJyYXJ5Lgo+ID4gPiAKPiA+ID4gVGhhbmtzCj4gPiBJZiB0aGF0IGhhcHBl
bnMgdGhlbiBhbiBleHRyYSBtb2R1bGUgbWlnaHQgYmVjb21lIHVzZWZ1bC4KPiAKPiAKPiBTbyBk
b2VzIGl0IG1ha2Ugc2Vuc2UgdGhhdCBJIHBvc3QgYSBuZXcgdmVyc2lvbiBhbmQgbGV0J3MgbWVy
Z2UgaXQgZmlyc3QuCj4gVGhlbiBJbnRlbCBvciBJIGNhbiBjb252ZXJ0IElGQ1ZGIHRvIHVzZSB0
aGUgbGlicmFyeT8KPiAKPiBUaGFua3MKCkdlbmVyYWxseSBpdCdzIGJlc3QgaWYgd2UgYWN0dWFs
bHkgaGF2ZSBhIGNvdXBsZSBvZiB1c2VycyBiZWZvcmUgd2UgYm90aGVyCndpdGggcmVmYWN0b3Jp
bmcgLSBpdCdzIGhhcmQgdG8gcHJlZGljdCB0aGUgZnV0dXJlLApzbyB3ZSBkb24ndCByZWFsbHkg
a25vdyB3aGF0IGtpbmQgb2YgcmVmYWN0b3Jpbmcgd2lsbCB3b3JrIGZvciBJRkNWRiAuLi4KCj4g
Cj4gPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
