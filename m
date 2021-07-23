Return-Path: <SRS0=XE2Y=MP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC79AC4338F
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 08:13:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CA6E60E8E
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 08:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7CA6E60E8E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3EF828390F;
	Fri, 23 Jul 2021 08:13:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WBYDSnmUl2hp; Fri, 23 Jul 2021 08:13:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CF4AE837C4;
	Fri, 23 Jul 2021 08:13:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80512C001A;
	Fri, 23 Jul 2021 08:13:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 821AFC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 08:13:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 68B10405E1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 08:13:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y63xDRKXI-Iq
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 08:13:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 16791405D4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 08:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627028019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1vkzwTa4HABsnbXYtzP50kINmnVsBzoqicnoVaGFoWQ=;
 b=hxrOOeZsFbS0Xa2RgEopv2K5vgTJv2RaRDfQ4F+Zz17stE44IQOK37+FgOxSZM80SMGvpL
 0p+n7GIgkw6EYbl5DHb2V0WSJ3ZPEXZJFgXee5GbeGqtj3i4imTP+OfGyJUAL6tcC6fQOh
 cz/3Jy/ogSfMPHSBqM8F5Q0QI3vapNs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-h2hfIivjOoCoecOHvnNGMA-1; Fri, 23 Jul 2021 04:13:38 -0400
X-MC-Unique: h2hfIivjOoCoecOHvnNGMA-1
Received: by mail-ed1-f71.google.com with SMTP id
 a23-20020a50ff170000b02903b85a16b672so368487edu.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 01:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=1vkzwTa4HABsnbXYtzP50kINmnVsBzoqicnoVaGFoWQ=;
 b=YXIZDwdK5RY2Apb9FBexECV3fumHL92oGplLxYL1v2ZkhwkXU4dJwZaPf4THJS8MOr
 Cx0uz7V9DUWgVmzLsx/qAVZ1R6+XmW/cMWsLtn1zkZGaZWjaNw4XL2iLZXtk8uItCdm4
 4mBUMEIQq5TYyA+OmMss7Km11C3fbEHB+KWVQciD24numGofwbVISjJAAwlNojqh6j2C
 SbP/OS562XuQDsxQHHs/3WJFw88ii16ZQ+aTnd9n9nYgb129uUOJyGRfQ2N6BG9NwD83
 ZJzsDBQgE1E+Q1T2UTItMbiDDQ0ngLp5Xe8Saj74kXyd2Ovg3eCEvNE43DK3bBzofsBZ
 ++Rg==
X-Gm-Message-State: AOAM533/OO7yJH7TXkCsf18ArxjYGPfpOwTfEeLOVeGZtnVte2oVf/pV
 Sx4DHhiA5vUA7sNqHBc1NAzOCpEu8Ydt53tNRnSpw+ibLaPW8TWbpdQeL8AC6BGs9B9faVRxMls
 BSqXba+VZC31v4O3+ZpJ06D7OgfZ/QuQtvI6+MKAWuA==
X-Received: by 2002:a17:906:4c8c:: with SMTP id
 q12mr3630454eju.254.1627028017557; 
 Fri, 23 Jul 2021 01:13:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/v+S1QNII9Ccy7jxT2Kvzb6WI7e3lojhlx46+ilE84W9ZJVZoi/thrvu+CJy8Z5pzuHRLeA==
X-Received: by 2002:a17:906:4c8c:: with SMTP id
 q12mr3630445eju.254.1627028017431; 
 Fri, 23 Jul 2021 01:13:37 -0700 (PDT)
Received: from redhat.com ([2.55.16.196])
 by smtp.gmail.com with ESMTPSA id o26sm8873485ejx.66.2021.07.23.01.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jul 2021 01:13:36 -0700 (PDT)
Date: Fri, 23 Jul 2021 04:13:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ivan <ivan@prestigetransportation.com>
Subject: Re: PROBLEM: virtio_net LRO kernel panics
Message-ID: <20210723041248-mutt-send-email-mst@kernel.org>
References: <CACFia2dwacaVVYD+1uG=CDGaJqdCOSBvZ5FcXp04caecaWAY3w@mail.gmail.com>
 <CAMDZJNXthLpAPHn62gA1qSmfLOoDFcFGdgnNwW6yA+wjn0FjgQ@mail.gmail.com>
 <CACFia2fDZHUZB5wJ7LK8M2sv_+W58rHw0NzzrwPPoX9=s7yPdQ@mail.gmail.com>
 <9547a9e5-738c-2009-a2af-66173d305c2d@redhat.com>
 <CACFia2eLCJuy=w1r20691s_cSYkBkPaY-Dbd-9CkrcpSAe7z6g@mail.gmail.com>
 <5fd9c67f-d900-7694-f0a8-62682c8a14c8@redhat.com>
 <CACFia2eH3eCZxtt70LB5zoPbhLXRv=crPh5oOhR=6mY3auDdQA@mail.gmail.com>
 <20210723035713-mutt-send-email-mst@kernel.org>
 <CACFia2fWhWKMGF3g8SfU++2-jQ1rCKtCJo3h08KmhGfMTuZaQQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACFia2fWhWKMGF3g8SfU++2-jQ1rCKtCJo3h08KmhGfMTuZaQQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "David S. Miller" <davem@davemloft.net>,
 virtualization@lists.linux-foundation.org,
 Willem de Bruijn <willemb@google.com>
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

T24gRnJpLCBKdWwgMjMsIDIwMjEgYXQgMDM6MDY6MDRBTSAtMDUwMCwgSXZhbiB3cm90ZToKPiBP
biBGcmksIEp1bCAyMywgMjAyMSBhdCAyOjU5IEFNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJl
ZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFRodSwgSnVsIDIyLCAyMDIxIGF0IDExOjUwOjEx
UE0gLTA1MDAsIEl2YW4gd3JvdGU6Cj4gPiA+IE9uIFRodSwgSnVsIDIyLCAyMDIxIGF0IDExOjI1
IFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+IOWcqCAy
MDIxLzcvMjMg5LiK5Y2IMTA6NTQsIEl2YW4g5YaZ6YGTOgo+ID4gPiA+ID4gT24gVGh1LCBKdWwg
MjIsIDIwMjEgYXQgOTozNyBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90
ZToKPiA+ID4gPiA+PiBEb2VzIGl0IHdvcmsgaWYgeW91IHR1cm4gb2ZmIGxybyBiZWZvcmUgZW5h
YmxpbmcgdGhlIGZvcndhcmRpbmc/Cj4gPiA+ID4gPiAwIHJvb3RATnVSYWlkOn4jIGV0aHRvb2wg
LUsgZXRoMCBscm8gb2ZmCj4gPiA+ID4gPiBBY3R1YWwgY2hhbmdlczoKPiA+ID4gPiA+IHJ4LWxy
bzogb24gW3JlcXVlc3RlZCBvZmZdCj4gPiA+ID4gPiBDb3VsZCBub3QgY2hhbmdlIGFueSBkZXZp
Y2UgZmVhdHVyZXMKPiA+ID4gPgo+ID4gPiA+IE9rLCBpdCBsb29rcyBsaWtlIHRoZSBkZXZpY2Ug
bWlzc2VzIHRoZSBWSVJUSU9fTkVUX0ZfQ1RSTF9HVUVTVF9PRkZMT0FEUwo+ID4gPiA+IHdoaWNo
IG1ha2VzIGl0IGltcG9zc2libGUgdG8gY2hhbmdlIHRoZSBMUk8gc2V0dGluZy4KPiA+ID4gPgo+
ID4gPiA+IERpZCB5b3UgdXNlIHFlbXU/IElmIHllcywgd2hhdCdzIHRoZSBxZW11IHZlcnNpb24g
eW91J3ZlIHVzZWQ/Cj4gPiA+Cj4gPiA+IFRoZXNlIGFyZSBWaXJ0dWFsQm94IG1hY2hpbmVzLCB3
aGljaCBJJ3ZlIGJlZW4gdXNpbmcgZm9yIHllYXJzIHdpdGgKPiA+ID4gbG9uZ3Rlcm0ga2VybmVs
cyA0LjE5LCBhbmQgSSBuZXZlciBoYWQgc3VjaCBhIHByb2JsZW0uICBCdXQgbm93IHRoYXQgSQo+
ID4gPiB0cmllZCB1cGdyYWRpbmcgdG8ga2VybmVscyA1LjEwIG9yIDUuMTMgLS0gdGhlIHBhbmlj
cyBzdGFydGVkLiAgVGhlc2UKPiA+ID4gYXJlIGp1c3QgZ2VuZXJpYyBrZXJuZWwgYnVpbGRzLCBh
bmQgYSBtaW5pbWFsaXN0aWMgdXNlcnNwYWNlLgo+ID4KPiA+IEkgd291bGQgYmUgdXNlZnVsIHRv
IHNlZSB0aGUgZmVhdHVyZXMgeW91ciB2aXJ0dWFsYm94IGluc3RhbmNlIHByb3ZpZGVzCj4gPgo+
ID4gY2F0IC9zeXMvY2xhc3MvbmV0L2V0aDAvZGV2aWNlL2ZlYXR1cmVzCj4gCj4gIyBjYXQgL3N5
cy9jbGFzcy9uZXQvZXRoMC9kZXZpY2UvZmVhdHVyZXMKPiAxMTAwMDEwMTEwMTExMDExMTExMTAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwCgoKU28gaWYgSSdtIG5v
dCB3cm9uZzoKCjEjZGVmaW5lIFZJUlRJT19ORVRfRl9DU1VNICAgICAgMCAgICAgICAvKiBIb3N0
IGhhbmRsZXMgcGt0cyB3LyBwYXJ0aWFsIGNzdW0gKi8KMSNkZWZpbmUgVklSVElPX05FVF9GX0dV
RVNUX0NTVU0gICAgICAgIDEgICAgICAgLyogR3Vlc3QgaGFuZGxlcyBwa3RzIHcvIHBhcnRpYWwg
Y3N1bSAqLwowI2RlZmluZSBWSVJUSU9fTkVUX0ZfQ1RSTF9HVUVTVF9PRkZMT0FEUyAyIC8qIER5
bmFtaWMgb2ZmbG9hZCBjb25maWd1cmF0aW9uLiAqLwowI2RlZmluZSBWSVJUSU9fTkVUX0ZfTVRV
ICAgICAgIDMgICAgICAgLyogSW5pdGlhbCBNVFUgYWR2aWNlICovCjAKMSNkZWZpbmUgVklSVElP
X05FVF9GX01BQyAgICAgICA1ICAgICAgIC8qIEhvc3QgaGFzIGdpdmVuIE1BQyBhZGRyZXNzLiAq
LwowCjEjZGVmaW5lIFZJUlRJT19ORVRfRl9HVUVTVF9UU080ICAgICAgICA3ICAgICAgIC8qIEd1
ZXN0IGNhbiBoYW5kbGUgVFNPdjQgaW4uICovCjEjZGVmaW5lIFZJUlRJT19ORVRfRl9HVUVTVF9U
U082ICAgICAgICA4ICAgICAgIC8qIEd1ZXN0IGNhbiBoYW5kbGUgVFNPdjYgaW4uICovCjAjZGVm
aW5lIFZJUlRJT19ORVRfRl9HVUVTVF9FQ04gOSAgICAgICAvKiBHdWVzdCBjYW4gaGFuZGxlIFRT
T1s2XSB3LyBFQ04gaW4uICovCjEjZGVmaW5lIFZJUlRJT19ORVRfRl9HVUVTVF9VRk8gMTAgICAg
ICAvKiBHdWVzdCBjYW4gaGFuZGxlIFVGTyBpbi4gKi8KMSNkZWZpbmUgVklSVElPX05FVF9GX0hP
U1RfVFNPNCAxMSAgICAgIC8qIEhvc3QgY2FuIGhhbmRsZSBUU092NCBpbi4gKi8KMSNkZWZpbmUg
VklSVElPX05FVF9GX0hPU1RfVFNPNiAxMiAgICAgIC8qIEhvc3QgY2FuIGhhbmRsZSBUU092NiBp
bi4gKi8KMCNkZWZpbmUgVklSVElPX05FVF9GX0hPU1RfRUNOICAxMyAgICAgIC8qIEhvc3QgY2Fu
IGhhbmRsZSBUU09bNl0gdy8gRUNOIGluLiAqLwoxI2RlZmluZSBWSVJUSU9fTkVUX0ZfSE9TVF9V
Rk8gIDE0ICAgICAgLyogSG9zdCBjYW4gaGFuZGxlIFVGTyBpbi4gKi8KMSNkZWZpbmUgVklSVElP
X05FVF9GX01SR19SWEJVRiAxNSAgICAgIC8qIEhvc3QgY2FuIG1lcmdlIHJlY2VpdmUgYnVmZmVy
cy4gKi8KMSNkZWZpbmUgVklSVElPX05FVF9GX1NUQVRVUyAgICAxNiAgICAgIC8qIHZpcnRpb19u
ZXRfY29uZmlnLnN0YXR1cyBhdmFpbGFibGUgKi8KMSNkZWZpbmUgVklSVElPX05FVF9GX0NUUkxf
VlEgICAxNyAgICAgIC8qIENvbnRyb2wgY2hhbm5lbCBhdmFpbGFibGUgKi8KMSNkZWZpbmUgVklS
VElPX05FVF9GX0NUUkxfUlggICAxOCAgICAgIC8qIENvbnRyb2wgY2hhbm5lbCBSWCBtb2RlIHN1
cHBvcnQgKi8KMSNkZWZpbmUgVklSVElPX05FVF9GX0NUUkxfVkxBTiAxOSAgICAgIC8qIENvbnRy
b2wgY2hhbm5lbCBWTEFOIGZpbHRlcmluZyAqLwoKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
