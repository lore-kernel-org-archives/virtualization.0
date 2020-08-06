Return-Path: <SRS0=OwTx=BQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A25C433DF
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 11:18:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6793206B5
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 11:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpd4ctnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6793206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A57C786E57;
	Thu,  6 Aug 2020 10:00:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 85ysvWIhiVF9; Thu,  6 Aug 2020 10:00:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D62E386DA1;
	Thu,  6 Aug 2020 10:00:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C96DBC0050;
	Thu,  6 Aug 2020 10:00:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B21D0C004C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 10:00:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A778D88299
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 10:00:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cPaw3i6jEiSE
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 10:00:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id F09E688052
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 10:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596708027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OndzkDmNcgoNifiVvnQ+KZRjYfgTXWBU8ZH831EcGLA=;
 b=fpd4ctnjqxoKlkASyYkbfYgqlojy2pKz5NlJJyRzgNDxxErkXg2NKsfqWwuWVL7TWuZRLo
 OPRVRb4Qwo1FqR+eQ0ed9/za1vXcFe3lGCSB7/bzod8V2oi6MtllI0+1qKk5RUK8RAamVr
 lcjvDCFeHMXeQ553Z4gPS2cj0qqx6AU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-2wH_ISCnMiqvfpoWIDm_IA-1; Thu, 06 Aug 2020 06:00:26 -0400
X-MC-Unique: 2wH_ISCnMiqvfpoWIDm_IA-1
Received: by mail-wm1-f71.google.com with SMTP id g72so3382895wme.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Aug 2020 03:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=OndzkDmNcgoNifiVvnQ+KZRjYfgTXWBU8ZH831EcGLA=;
 b=DEnMpg58zi5bpZWxdNX9QR10W7hd7xE+jl50B8x1ejkTUes+X7qnRAwH7x4CD9Ci5o
 iwvAqrxeP70Jr21vcjbg1Yi0ILE/hMisUsLtjqdvxyJzWb/XSl90SEcRVfxbZRWEYlpg
 5HkNt+WRjifn3GP1zj/g0rb3D16pZ9N2I3Ihic8m3BLH56jiRzUmmEaj+/piisHaLl4Y
 zof8NVhxy4KziaIe4zsA8GQ5JOA2572orpTL0QwXyA2DPHXd38ci9y0OepYa1BY9ut+h
 XymBvrZrxrrgemx4pXVsOff4ai3sQTYTVnOjlNKUBxtub4t/N+k/SdddeYbDmwe6VPrC
 Xd4g==
X-Gm-Message-State: AOAM5339JJL2jvuwXlm0DwDz+RgZWohZ1KHnoQq+DV/nN8Ee5GJo1DBI
 fk3uLPWOFzxUAsEGKnuT9bgWL95IRzqAsjoRVb/q3lBQ9MSA3r9M6Wfa3rmJKu/E5HCOmFtj3/b
 OCf7ItMyWhEC5fxUf/jHUxPal4aMyM2XF+E7Q0XDxBg==
X-Received: by 2002:adf:a35e:: with SMTP id d30mr7131953wrb.53.1596708024438; 
 Thu, 06 Aug 2020 03:00:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5PxHtKOZg3btYcrqVmyb7L9kNpR4DBCaDwStXUxvVDuujSnEeCKFRtxCmXegq8/gGKsNKQg==
X-Received: by 2002:adf:a35e:: with SMTP id d30mr7131930wrb.53.1596708024241; 
 Thu, 06 Aug 2020 03:00:24 -0700 (PDT)
Received: from redhat.com (bzq-79-178-123-8.red.bezeqint.net. [79.178.123.8])
 by smtp.gmail.com with ESMTPSA id
 z6sm6435422wml.41.2020.08.06.03.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:00:23 -0700 (PDT)
Date: Thu, 6 Aug 2020 06:00:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 19/24] vdpa: make sure set_features in invoked for
 legacy
Message-ID: <20200806055818-mutt-send-email-mst@kernel.org>
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-20-mst@redhat.com>
 <9e47d227-f220-4651-dcb9-7a11f059a715@redhat.com>
 <20200805073929-mutt-send-email-mst@kernel.org>
 <bd915b30-0604-da1b-343f-e228bce4d1d8@redhat.com>
 <20200806015112-mutt-send-email-mst@kernel.org>
 <cc5cb366-be79-908d-edc6-4aebb488cc59@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cc5cb366-be79-908d-edc6-4aebb488cc59@redhat.com>
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

T24gVGh1LCBBdWcgMDYsIDIwMjAgYXQgMDM6Mjc6MzhQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIwLzgvNiDkuIvljYgxOjUzLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6
Cj4gPiBPbiBUaHUsIEF1ZyAwNiwgMjAyMCBhdCAxMToyMzowNUFNICswODAwLCBKYXNvbiBXYW5n
IHdyb3RlOgo+ID4gPiBPbiAyMDIwLzgvNSDkuIvljYg3OjQwLCBNaWNoYWVsIFMuIFRzaXJraW4g
d3JvdGU6Cj4gPiA+ID4gT24gV2VkLCBBdWcgMDUsIDIwMjAgYXQgMDI6MTQ6MDdQTSArMDgwMCwg
SmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+IE9uIDIwMjAvOC80IOS4iuWNiDU6MDAsIE1pY2hh
ZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gPiA+ID4gU29tZSBsZWdhY3kgZ3Vlc3RzIGp1c3Qg
YXNzdW1lIGZlYXR1cmVzIGFyZSAwIGFmdGVyIHJlc2V0Lgo+ID4gPiA+ID4gPiBXZSBkZXRlY3Qg
dGhhdCBjb25maWcgc3BhY2UgaXMgYWNjZXNzZWQgYmVmb3JlIGZlYXR1cmVzIGFyZQo+ID4gPiA+
ID4gPiBzZXQgYW5kIHNldCBmZWF0dXJlcyB0byAwIGF1dG9tYXRpY2FsbHkuCj4gPiA+ID4gPiA+
IE5vdGU6IHNvbWUgbGVnYWN5IGd1ZXN0cyBtaWdodCBub3QgZXZlbiBhY2Nlc3MgY29uZmlnIHNw
YWNlLCBpZiB0aGlzIGlzCj4gPiA+ID4gPiA+IHJlcG9ydGVkIGluIHRoZSBmaWVsZCB3ZSBtaWdo
dCBuZWVkIHRvIGNhdGNoIGEga2ljayB0byBoYW5kbGUgdGhlc2UuCj4gPiA+ID4gPiBJIHdvbmRl
ciB3aGV0aGVyIGl0J3MgZWFzaWVyIHRvIGp1c3Qgc3VwcG9ydCBtb2Rlcm4gZGV2aWNlPwo+ID4g
PiA+ID4gCj4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiBXZWxsIGhhcmR3YXJlIHZlbmRvcnMgYXJl
IEkgdGhpbmsgaW50ZXJlc3RlZCBpbiBzdXBwb3J0aW5nIGxlZ2FjeQo+ID4gPiA+IGd1ZXN0cy4g
TGltaXRpbmcgdmRwYSB0byBtb2Rlcm4gb25seSB3b3VsZCBtYWtlIGl0IHVuY29tcGV0aXRpdmUu
Cj4gPiA+IAo+ID4gPiBNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQsIElPTU1VX1BMQVRGT1JNIGlz
IG1hbmRhdG9yeSBmb3IgaGFyZHdhcmUgdkRQQSB0bwo+ID4gPiB3b3JrLgo+ID4gSG1tIEkgZG9u
J3QgcmVhbGx5IHNlZSB3aHkuIEFzc3VtZSBob3N0IG1hcHMgZ3Vlc3QgbWVtb3J5IHByb3Blcmx5
LAo+ID4gVk0gZG9lcyBub3QgaGF2ZSBhbiBJT01NVSwgbGVnYWN5IGd1ZXN0IGNhbiBqdXN0IHdv
cmsuCj4gCj4gCj4gWWVzLCBndWVzdCBtYXkgbm90IHNldCBJT01NVV9QTEFURk9STS4KPiAKPiAK
PiA+IAo+ID4gQ2FyZSBleHBsYWluaW5nIHdoYXQncyB3cm9uZyB3aXRoIHRoaXMgcGljdHVyZT8K
PiAKPiAKPiBUaGUgcHJvYmxlbSBpcyB2aXJ0aW9fdmRwYSwgd2l0aG91dCBJT01NVV9QTEFURk9S
TSBpdCB1c2VzIFBBIHdoaWNoIGNhbiBub3QKPiB3b3JrIGlmIElPTU1VIGlzIGVuYWJsZWQuCj4g
Cj4gVGhhbmtzCgpTbyB0aGF0J3MgYSB2aXJ0aW9fdmRwYSBsaW1pdGF0aW9uLiBJbiB0aGUgc2Ft
ZSB3YXksIGlmIGEgZGV2aWNlCmRvZXMgbm90IGhhdmUgYW4gb24tZGV2aWNlIGlvbW11ICphbmQq
IGlzIG5vdCBiZWhpbmQgYW4gaW9tbXUsCnRoZW4gdmRwYSBjYW4ndCBiaW5kIHRvIGl0LgoKQnV0
IHRoaXMgdmlydGlvX3ZkcGEgc3BlY2lmaWMgaGFjayBkb2VzIG5vdCBiZWxvbmcgaW4gYSBnZW5l
cmljIHZkcGEgY29kZS4KCj4gCj4gPiAKPiA+IAo+ID4gPiBTbyBpdCBjYW4gb25seSB3b3JrIGZv
ciBtb2Rlcm4gZGV2aWNlIC4uLgo+ID4gPiAKPiA+ID4gVGhhbmtzCj4gPiA+IAo+ID4gPiAKPiA+
ID4gPiAKPiA+ID4gPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
