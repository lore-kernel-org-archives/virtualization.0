Return-Path: <SRS0=QvMg=HM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7424FC433E6
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 12:35:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A93F64E3E
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 12:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A93F64E3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B2C6286767;
	Wed, 10 Feb 2021 12:35:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aYWcfVEOrZGx; Wed, 10 Feb 2021 12:35:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 09B5686755;
	Wed, 10 Feb 2021 12:35:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E42BDC0174;
	Wed, 10 Feb 2021 12:35:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB4F1C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 12:35:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9842285D17
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 12:35:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TYUNXepLMAXK
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 12:35:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CF905857CB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 12:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612960510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r9BSzyb2e+6npXvlQKaKsVtbO2RXid50XjjwcfxjJRE=;
 b=Ud6QLlCxc48leduOxXbvwN7qGY/IXTru54DGaqS0kyWOj1Q77EOgbVNJwYSfKJR1vGToza
 Bf9vejjDiIGnUgdJ38lyv8fPDd+KvqE6LN4cH0jn8iuIPIte8uBOm0tFmTEhjJ7RS8Kvbu
 Wq5fR4TzIDuTEw4LB1KGOo2p3KhUJt4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-qlhgpvyHOLmtS3MsbdfU1Q-1; Wed, 10 Feb 2021 07:35:09 -0500
X-MC-Unique: qlhgpvyHOLmtS3MsbdfU1Q-1
Received: by mail-wr1-f69.google.com with SMTP id u15so1720428wrn.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 04:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=r9BSzyb2e+6npXvlQKaKsVtbO2RXid50XjjwcfxjJRE=;
 b=rEePzuYPBmDTpy8U8X6PijY/XwGrLutC+m/PRRkr/fsJbRpwNa63z0pKqBLyga43+a
 dhwt9eQFHQadDIERkJ9JdbaxhvaXKnAfsASgn7P+V2RC/9SdIFNiu1RFL7TsigWT5pAt
 15OLdoHdTDr/16VjHie9zu2tJO6PiPYPvgrsPP9lamywbYtyfnOB14l0bPKNSR7j2iHr
 t79ceUCbWV+vhmwDo7MXh+LXv1utUJaoncdAXAoai1Z7cgwLm0bAFTmStpv4fBJTie0y
 VmYDybrlSgU60hq37vUM5DNGEPT9jcb2pHLMe9CzcIWCDzIIm5eTXFvKBiTby3gi7nmN
 iMyA==
X-Gm-Message-State: AOAM530b3jtHZL2OSsurEXzjD88d3fv4WAiUB5PVaKtcQxYZuhB4Co13
 oxVp+CG/hTvtknodMZaiKdQX9EbQSivyP9WbArWC2HRLrAtIn//RsLhGm0jNgJZPkFg6HcQgHJf
 tFXQYwDHO+ZsS7pTMCQAnfb6dlWfbhMTYH4AslRVOfw==
X-Received: by 2002:adf:d852:: with SMTP id k18mr3485072wrl.262.1612960507773; 
 Wed, 10 Feb 2021 04:35:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzkbUgr0QieZfImnKg2Mg3kQ6hfRq4PRP6E/bJ3CbrAeTM6nxJpHt1GPBO96hNlreeAnnVNMA==
X-Received: by 2002:adf:d852:: with SMTP id k18mr3485058wrl.262.1612960507639; 
 Wed, 10 Feb 2021 04:35:07 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id f2sm2856130wrt.7.2021.02.10.04.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Feb 2021 04:35:06 -0800 (PST)
Date: Wed, 10 Feb 2021 07:35:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 16/19] virtio-pci: introduce modern device module
Message-ID: <20210210073404-mutt-send-email-mst@kernel.org>
References: <20210104065503.199631-1-jasowang@redhat.com>
 <20210104065503.199631-17-jasowang@redhat.com>
 <20210209091916-mutt-send-email-mst@kernel.org>
 <721bf1dc-0b06-7f2a-9685-064a7c281366@redhat.com>
MIME-Version: 1.0
In-Reply-To: <721bf1dc-0b06-7f2a-9685-064a7c281366@redhat.com>
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

T24gV2VkLCBGZWIgMTAsIDIwMjEgYXQgMTI6NDQ6MDNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIxLzIvOSDkuIvljYgxMDoyMCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Ogo+ID4gT24gTW9uLCBKYW4gMDQsIDIwMjEgYXQgMDI6NTU6MDBQTSArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZToKPiA+ID4gU2lnbmVkLW9mZi1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0
LmNvbT4KPiA+ID4gLS0tCj4gPiA+ICAgZHJpdmVycy92aXJ0aW8vS2NvbmZpZyAgICAgICAgICAg
ICAgICAgfCAgMTAgKy0KPiA+ID4gICBkcml2ZXJzL3ZpcnRpby9NYWtlZmlsZSAgICAgICAgICAg
ICAgICB8ICAgMSArCj4gPiA+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uaCAg
ICAgfCAgMjcgKy0KPiA+ID4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybi5jICAg
ICB8IDYxNyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gPiA+ICAgZHJpdmVycy92aXJ0aW8v
dmlydGlvX3BjaV9tb2Rlcm5fZGV2LmMgfCA1OTkgKysrKysrKysrKysrKysrKysrKysrKysrCj4g
PiA+ICAgaW5jbHVkZS9saW51eC92aXJ0aW9fcGNpX21vZGVybi5oICAgICAgfCAxMTEgKysrKysK
PiA+ID4gICA2IGZpbGVzIGNoYW5nZWQsIDcyMSBpbnNlcnRpb25zKCspLCA2NDQgZGVsZXRpb25z
KC0pCj4gPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lf
bW9kZXJuX2Rldi5jCj4gPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvdmly
dGlvX3BjaV9tb2Rlcm4uaAo+ID4gPiAKPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlv
L0tjb25maWcgYi9kcml2ZXJzL3ZpcnRpby9LY29uZmlnCj4gPiA+IGluZGV4IDdiNDExMzBkM2Yz
NS4uNmI5YjgxZjRiOGMyIDEwMDY0NAo+ID4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby9LY29uZmln
Cj4gPiA+ICsrKyBiL2RyaXZlcnMvdmlydGlvL0tjb25maWcKPiA+ID4gQEAgLTEyLDYgKzEyLDE0
IEBAIGNvbmZpZyBBUkNIX0hBU19SRVNUUklDVEVEX1ZJUlRJT19NRU1PUllfQUNDRVNTCj4gPiA+
ICAgCSAgVGhpcyBvcHRpb24gaXMgc2VsZWN0ZWQgaWYgdGhlIGFyY2hpdGVjdHVyZSBtYXkgbmVl
ZCB0byBlbmZvcmNlCj4gPiA+ICAgCSAgVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNCj4gPiA+ICtj
b25maWcgVklSVElPX1BDSV9NT0RFUk4KPiA+ID4gKwl0cmlzdGF0ZSAiTW9kZXJuIFZpcnRpbyBQ
Q0kgRGV2aWNlIgo+ID4gPiArCWRlcGVuZHMgb24gUENJCj4gPiA+ICsJaGVscAo+ID4gPiArCSAg
TW9kZXJuIFBDSSBkZXZpY2UgaW1wbGVtZW50YXRpb24uIFRoaXMgbW9kdWxlIGltcGxlbWVudHMg
dGhlCj4gPiA+ICsJICBiYXNpYyBwcm9iZSBhbmQgY29udHJvbCBmb3IgZGV2aWNlcyB3aGljaCBh
cmUgYmFzZWQgb24gbW9kZXJuCj4gPiA+ICsJICBQQ0kgZGV2aWNlIHdpdGggcG9zc2libGUgdmVu
ZG9yIHNwZWNpZmljIGV4dGVuc2lvbnMuCj4gPiA+ICsKPiA+ID4gICBtZW51Y29uZmlnIFZJUlRJ
T19NRU5VCj4gPiA+ICAgCWJvb2wgIlZpcnRpbyBkcml2ZXJzIgo+ID4gPiAgIAlkZWZhdWx0IHkK
PiA+ID4gQEAgLTIwLDcgKzI4LDcgQEAgaWYgVklSVElPX01FTlUKPiA+ID4gICBjb25maWcgVklS
VElPX1BDSQo+ID4gPiAgIAl0cmlzdGF0ZSAiUENJIGRyaXZlciBmb3IgdmlydGlvIGRldmljZXMi
Cj4gPiA+IC0JZGVwZW5kcyBvbiBQQ0kKPiA+ID4gKwlkZXBlbmRzIG9uIFZJUlRJT19QQ0lfTU9E
RVJOCj4gPiA+ICAgCXNlbGVjdCBWSVJUSU8KPiA+ID4gICAJaGVscAo+ID4gPiAgIAkgIFRoaXMg
ZHJpdmVyIHByb3ZpZGVzIHN1cHBvcnQgZm9yIHZpcnRpbyBiYXNlZCBwYXJhdmlydHVhbCBkZXZp
Y2UKPiA+IExvb2tzIGxpa2UgVklSVElPX1BDSV9NT0RFUk4gaXMgYWN0dWFsbHkganVzdCBhIGxp
YnJhcnkgdGhhdAo+ID4gdmlydGlvIHBjaSB1c2VzLiBJcyB0aGF0IHJpZ2h0Pwo+IAo+IAo+IFJp
Z2h0Lgo+IAo+IAo+ID4gSW4gdGhhdCBjYXNlIGp1c3Qgc2VsZWN0IGl0Cj4gPiBhdXRvbWF0aWNh
bGx5LCBsZXQncyBub3QgbWFrZSB1c2VycyBlbmFibGUgaXQgbWFudWFsbHkuCj4gCj4gCj4gSSd2
ZSBjb25zaWRlcmVkIHRvIGRvIHRoaXMgYnV0IHRoZSBwcm9ibGVtIGlzIHRoYXQgdGhlIG1vZHVs
ZSBkZXBlbmRzIG9uIFBDSQo+IHNvIGl0IGNhbid0IGJlIHNlbGVjdGVkIEkgdGhpbmsuCgpEcm9w
IHRoZSBkZXBlbmRlbmN5LCBkb2N1bWVudCB0aGF0IHdob2V2ZXIgc2VsZWN0cyBpdCBtdXN0IGRl
cGVuZCBvbiBQQ0kuCgo+IFRoYW5rcwo+IAo+IAo+ID4gCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
