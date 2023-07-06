Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462B4EB64D9
	for <virtualization@archiver.kernel.org>; Thu,  6 Jul 2023 06:40:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D455408B2;
	Thu,  6 Jul 2023 06:40:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9D455408B2
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a1GLn6+3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 78H24OqfYBVr; Thu,  6 Jul 2023 06:40:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5091240891;
	Thu,  6 Jul 2023 06:40:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5091240891
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A70CFC0071;
	Thu,  6 Jul 2023 06:40:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F2E5C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 06:40:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 44BE94013C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 06:40:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 44BE94013C
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=a1GLn6+3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7QTi8RsU4zZc
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 06:40:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1B40C400D7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1B40C400D7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 06:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688625603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rg4IfexhYec6xUknQtLkQiZWYyOTZiXy0lHs1tnCoTU=;
 b=a1GLn6+3m4yJrmledcprSSezIw+Q1/hIskaWEZOGVq4gueUWbnq1ADNpX4UMoF/ve+qh2y
 x5ChmHz+sXY5jZp0OAQ3WJ7vLUD2D3BrtZlZwIrEeA0pFz2D0n/29q+jODTWozkfn8kvoF
 ED9yuk0KccoG15Xhcl1RCkk9NcJSDMM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-UNkTFK31NGqDKfNxF6PTvQ-1; Thu, 06 Jul 2023 02:40:01 -0400
X-MC-Unique: UNkTFK31NGqDKfNxF6PTvQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4fb89482c48so294737e87.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Jul 2023 23:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688625600; x=1691217600;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rg4IfexhYec6xUknQtLkQiZWYyOTZiXy0lHs1tnCoTU=;
 b=Jemng47VKrzpXAihXbuSBtyf7LWTcmnEg056ZCnhIzaoBbJYJVdJ08XD5Ji/tS7qdu
 WEg+qs2EBhEgmzuFNZDtkDNNGwgR0nXCYKNkLu3WDN4B8zo4JIlLmJi/z4nRE3foybYb
 cjGCPc43zoUWmhxsfXaR7Stcx0fDp2PGSMMK3DB87lDf9kf5n5flrx4mr6fyJk7u6PTt
 8b6/tl1IHTeuH5oc+d8O9A7R4AIAy5403oxCneAFDhiZCsrYUMDNPfUnR5QPI6GR33uJ
 nEvqs5Ur2VrBJDNbzbQPhKHXjmsDAB0hHmWz82xHSvuxOYHuJJ0AeL+rE/StYp9C3iDh
 6dDA==
X-Gm-Message-State: ABy/qLYtFPDhWVDRqOIdDZ1Q34R2P1MHhYJYbi2VbSgH9PkeJJo9VUX9
 KQZY4yscFzpimUOS7nP4LjZEYdvp6Xt7dazwjr7tfnbTf9SHW+OPN6IdIZZGRAWK1hdsXiQsMUm
 60tKVPKfVpG10seDLgHYMO0JoBgWybHxnXABGE4Xf8Q==
X-Received: by 2002:a19:434a:0:b0:4f8:7614:48a5 with SMTP id
 m10-20020a19434a000000b004f8761448a5mr680252lfj.66.1688625600339; 
 Wed, 05 Jul 2023 23:40:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE386jplh0iitvZKDpxQtD+TN3LjC9KlQhdbORFe0IQ5iV+4M8s56CNKTah82KPV4FYkCEBIA==
X-Received: by 2002:a19:434a:0:b0:4f8:7614:48a5 with SMTP id
 m10-20020a19434a000000b004f8761448a5mr680241lfj.66.1688625599972; 
 Wed, 05 Jul 2023 23:39:59 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e5:9a00:6cb0:ad0c:4846:6126])
 by smtp.gmail.com with ESMTPSA id
 l16-20020a5d4bd0000000b0031438e42599sm941035wrt.82.2023.07.05.23.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 23:39:59 -0700 (PDT)
Date: Thu, 6 Jul 2023 02:39:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH] vdpa: reject F_ENABLE_AFTER_DRIVER_OK if backend does
 not support it
Message-ID: <20230706023949-mutt-send-email-mst@kernel.org>
References: <20230703105022-mutt-send-email-mst@kernel.org>
 <CAJaqyWf2F_yBLBjj1RiPeJ92_zfq8BSMz8Pak2Vg6QinN8jS1Q@mail.gmail.com>
 <20230704063646-mutt-send-email-mst@kernel.org>
 <CAJaqyWfdPpkD5pY4tfzQdOscLBcrDBhBqzWjMbY_ZKsoyiqGdA@mail.gmail.com>
 <20230704114159-mutt-send-email-mst@kernel.org>
 <CACGkMEtWjOMtsbgQ2sx=e1BkuRSyDmVfXDccCm-QSiSbacQyCA@mail.gmail.com>
 <CAJaqyWd0QC6x9WHBT0x9beZyC8ZrF2y=d9HvmT0+05RtGc8_og@mail.gmail.com>
 <eff34828-545b-956b-f400-89b585706fe4@amd.com>
 <20230706020603-mutt-send-email-mst@kernel.org>
 <CAJaqyWeCv6HhWni=c7xySTCyj9WAFfM3JhWL2e_mDKjHp3wPzQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWeCv6HhWni=c7xySTCyj9WAFfM3JhWL2e_mDKjHp3wPzQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

T24gVGh1LCBKdWwgMDYsIDIwMjMgYXQgMDg6MzU6MzBBTSArMDIwMCwgRXVnZW5pbyBQZXJleiBN
YXJ0aW4gd3JvdGU6Cj4gT24gVGh1LCBKdWwgNiwgMjAyMyBhdCA4OjA34oCvQU0gTWljaGFlbCBT
LiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gV2VkLCBKdWwgMDUs
IDIwMjMgYXQgMDU6MDc6MTFQTSAtMDcwMCwgU2hhbm5vbiBOZWxzb24gd3JvdGU6Cj4gPiA+IE9u
IDcvNS8yMyAxMToyNyBBTSwgRXVnZW5pbyBQZXJleiBNYXJ0aW4gd3JvdGU6Cj4gPiA+ID4KPiA+
ID4gPiBPbiBXZWQsIEp1bCA1LCAyMDIzIGF0IDk6NTDigK9BTSBKYXNvbiBXYW5nIDxqYXNvd2Fu
Z0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+Cj4gPiA+ID4gPiBPbiBUdWUsIEp1bCA0LCAy
MDIzIGF0IDExOjQ14oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3Jv
dGU6Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IE9uIFR1ZSwgSnVsIDA0LCAyMDIzIGF0IDAxOjM2
OjExUE0gKzAyMDAsIEV1Z2VuaW8gUGVyZXogTWFydGluIHdyb3RlOgo+ID4gPiA+ID4gPiA+IE9u
IFR1ZSwgSnVsIDQsIDIwMjMgYXQgMTI6MzjigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBPbiBUdWUs
IEp1bCAwNCwgMjAyMyBhdCAxMjoyNTozMlBNICswMjAwLCBFdWdlbmlvIFBlcmV6IE1hcnRpbiB3
cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gT24gTW9uLCBKdWwgMywgMjAyMyBhdCA0OjUy4oCvUE0g
TWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiBPbiBNb24sIEp1bCAwMywgMjAyMyBhdCAwNDoyMjox
OFBNICswMjAwLCBFdWdlbmlvIFDDqXJleiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFdp
dGggdGhlIGN1cnJlbnQgY29kZSBpdCBpcyBhY2NlcHRlZCBhcyBsb25nIGFzIHVzZXJsYW5kIHNl
bmQgaXQuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQWx0aG91
Z2ggdXNlcmxhbmQgc2hvdWxkIG5vdCBzZXQgYSBmZWF0dXJlIGZsYWcgdGhhdCBoYXMgbm90IGJl
ZW4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IG9mZmVyZWQgdG8gaXQgd2l0aCBWSE9TVF9HRVRfQkFD
S0VORF9GRUFUVVJFUywgdGhlIGN1cnJlbnQgY29kZSB3aWxsIG5vdAo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gY29tcGxhaW4gZm9yIGl0Lgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiA+ID4gPiA+IFNpbmNlIHRoZXJlIGlzIG5vIHNwZWNpZmljIHJlYXNvbiBmb3IgYW55IHBhcmVu
dCB0byByZWplY3QgdGhhdCBiYWNrZW5kCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBmZWF0dXJlIGJp
dCB3aGVuIGl0IGhhcyBiZWVuIHByb3Bvc2VkLCBsZXQncyBjb250cm9sIGl0IGF0IHZkcGEgZnJv
bnRlbmQKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGxldmVsLiBGdXR1cmUgcGF0Y2hlcyBtYXkgbW92
ZSB0aGlzIGNvbnRyb2wgdG8gdGhlIHBhcmVudCBkcml2ZXIuCj4gPiA+ID4gPiA+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gRml4ZXM6IDk2NzgwMGQyZDUyZSAoInZkcGE6IGFjY2Vw
dCBWSE9TVF9CQUNLRU5EX0ZfRU5BQkxFX0FGVEVSX0RSSVZFUl9PSyBiYWNrZW5kIGZlYXR1cmUi
KQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXogPGVw
ZXJlem1hQHJlZGhhdC5jb20+Cj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4g
PiBQbGVhc2UgZG8gc2VuZCB2My4gQW5kIGFnYWluLCBJIGRvbid0IHdhbnQgdG8gc2VuZCAiYWZ0
ZXIgZHJpdmVyIG9rIiBoYWNrCj4gPiA+ID4gPiA+ID4gPiA+ID4gdXBzdHJlYW0gYXQgYWxsLCBJ
IG1lcmdlZCBpdCBpbiBuZXh0IGp1c3QgdG8gZ2l2ZSBpdCBzb21lIHRlc3RpbmcuCj4gPiA+ID4g
PiA+ID4gPiA+ID4gV2Ugd2FudCBSSU5HX0FDQ0VTU19BRlRFUl9LSUNLIG9yIHNvbWUgc3VjaC4K
PiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiBD
dXJyZW50IGRldmljZXMgZG8gbm90IHN1cHBvcnQgdGhhdCBzZW1hbnRpYy4KPiA+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gPiBXaGljaCBkZXZpY2VzIHNwZWNpZmljYWxseSBhY2Nlc3MgdGhl
IHJpbmcgYWZ0ZXIgRFJJVkVSX09LIGJ1dCBiZWZvcmUKPiA+ID4gPiA+ID4gPiA+IGEga2ljaz8K
PiA+ID4KPiA+ID4gVGhlIFBEUyB2ZHBhIGRldmljZSBjYW4gZGVhbCB3aXRoIGEgY2FsbCB0byAu
c2V0X3ZxX3JlYWR5IGFmdGVyIERSSVZFUl9PSyBpcwo+ID4gPiBzZXQuICBBbmQgSSdtIHRvbGQg
dGhhdCBvdXIgVlEgYWN0aXZpdHkgc2hvdWxkIHN0YXJ0IHdpdGhvdXQgYSBraWNrLgo+ID4gPgo+
ID4gPiBPdXIgdmRwYSBkZXZpY2UgRlcgZG9lc24ndCBjdXJyZW50bHkgaGF2ZSBzdXBwb3J0IGZv
ciBWSVJUSU9fRl9SSU5HX1JFU0VULAo+ID4gPiBidXQgSSBiZWxpZXZlIGl0IGNvdWxkIGJlIGFk
ZGVkIHdpdGhvdXQgdG9vIG11Y2ggdHJvdWJsZS4KPiA+ID4KPiA+ID4gc2xuCj4gPiA+Cj4gPgo+
ID4gT0sgaXQgc2VlbXMgY2xlYXIgYXQgbGVhc3QgaW4gdGhlIGN1cnJlbnQgdmVyc2lvbiBwZHMg
bmVlZHMKPiA+IFZIT1NUX0JBQ0tFTkRfRl9FTkFCTEVfQUZURVJfRFJJVkVSX09LLgo+ID4gSG93
ZXZlciBjYW4gd2UgYWxzbyBjb2RlIHVwIHRoZSBSSU5HX1JFU0VUIHBhdGggYXMgdGhlIGRlZmF1
bHQ/Cj4gPiBUaGVuIGRvd24gdGhlIHJvYWQgdmVuZG9ycyBjYW4gY2hvb3NlIHdoYXQgdG8gZG8u
Cj4gPgo+IAo+IFllcywgdGhlIFJJTkdfUkVTRVQgcGF0aCBjYW4gYmUgY29kZWQgJiB0ZXN0ZWQg
Zm9yIHZwX3ZkcGEsIGZvcgo+IGV4YW1wbGUuIEknbSBvayB3aXRoIG1ha2luZyBpdCB0aGUgZGVm
YXVsdCwgYW5kIGxldAo+IF9GX0VOQUJMRV9BRlRFUl9EUklWRVJfT0sgYXMgYSBmYWxsYmFjay4K
ClNvdW5kcyBnb29kLgoKPiA+Cj4gPgo+ID4KPiA+Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gUHJldmlvdXMgdmVyc2lvbnMgb2YgdGhlIFFFTVUgTE0gc2VyaWVz
IGRpZCBhIHNwdXJpb3VzIGtpY2sgdG8gc3RhcnQKPiA+ID4gPiA+ID4gPiB0cmFmZmljIGF0IHRo
ZSBMTSBkZXN0aW5hdGlvbiBbMV0uIFdoZW4gaXQgd2FzIHByb3Bvc2VkLCB0aGF0IHNwdXJpb3Vz
Cj4gPiA+ID4gPiA+ID4ga2ljayB3YXMgcmVtb3ZlZCBmcm9tIHRoZSBzZXJpZXMgYmVjYXVzZSB0
byBjaGVjayBmb3IgZGVzY3JpcHRvcnMKPiA+ID4gPiA+ID4gPiBhZnRlciBkcml2ZXJfb2ssIGV2
ZW4gd2l0aG91dCBhIGtpY2ssIHdhcyBjb25zaWRlcmVkIHdvcmsgb2YgdGhlCj4gPiA+ID4gPiA+
ID4gcGFyZW50IGRyaXZlci4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IEknbSBvayB0byBn
byBiYWNrIHRvIHRoaXMgc3B1cmlvdXMga2ljaywgYnV0IEknbSBub3Qgc3VyZSBpZiB0aGUgaHcK
PiA+ID4gPiA+ID4gPiB3aWxsIHJlYWQgdGhlIHJpbmcgYmVmb3JlIHRoZSBraWNrIGFjdHVhbGx5
LiBJIGNhbiBhc2suCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBUaGFua3MhCj4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiBbMV0gaHR0cHM6Ly9saXN0cy5ub25nbnUub3JnL2FyY2hpdmUv
aHRtbC9xZW11LWRldmVsLzIwMjMtMDEvbXNnMDI3NzUuaHRtbAo+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiBMZXQncyBmaW5kIG91dC4gV2UgbmVlZCB0byBjaGVjayBmb3IgRU5BQkxFX0FGVEVSX0RS
SVZFUl9PSyB0b28sIG5vPwo+ID4gPiA+ID4KPiA+ID4gPiA+IE15IHVuZGVyc3RhbmRpbmcgaXMg
WzFdIGFzc3VtaW5nIEFDQ0VTU19BRlRFUl9LSUNLLiBUaGlzIHNlZW1zCj4gPiA+ID4gPiBzdWIt
b3B0aW1hbCB0aGFuIGFzc3VtaW5nIEVOQUJMRV9BRlRFUl9EUklWRVJfT0suCj4gPiA+ID4gPgo+
ID4gPiA+ID4gQnV0IHRoaXMgcmVtaW5kcyBtZSBvbmUgdGhpbmcsIGFzIHRoZSB0aHJlYWQgaXMg
Z29pbmcgdG9vIGxvbmcsIEkKPiA+ID4gPiA+IHdvbmRlciBpZiB3ZSBzaW1wbHkgYXNzdW1lIEVO
QUJMRV9BRlRFUl9EUklWRVJfT0sgaWYgUklOR19SRVNFVCBpcwo+ID4gPiA+ID4gc3VwcG9ydGVk
Pwo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+IFRoZSBwcm9ibGVtIHdpdGggdGhhdCBpcyB0aGF0
IHRoZSBkZXZpY2UgbmVlZHMgdG8gc3VwcG9ydCBhbGwKPiA+ID4gPiBSSU5HX1JFU0VULCBsaWtl
IHRvIGJlIGFibGUgdG8gY2hhbmdlIHZxIGFkZHJlc3MgZXRjIGFmdGVyIERSSVZFUl9PSy4KPiA+
ID4gPiBOb3QgYWxsIEhXIHN1cHBvcnQgaXQuCj4gPiA+ID4KPiA+ID4gPiBXZSBqdXN0IG5lZWQg
dGhlIHN1YnNldCBvZiBoYXZpbmcgdGhlIGRhdGFwbGFuZSBmcmVlemVkIHVudGlsIGFsbCBDVlEK
PiA+ID4gPiBjb21tYW5kcyBoYXZlIGJlZW4gY29uc3VtZWQuIEknbSBzdXJlIGN1cnJlbnQgdkRQ
QSBjb2RlIGFscmVhZHkKPiA+ID4gPiBzdXBwb3J0cyBpdCBpbiBzb21lIGRldmljZXMsIGxpa2Ug
TUxYIGFuZCBQU0QuCj4gPiA+ID4KPiA+ID4gPiBUaGFua3MhCj4gPiA+ID4KPiA+ID4gPiA+IFRo
YW5rcwo+ID4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gPiA+ID4gTXkgcGxhbiB3YXMgdG8gY29udmVydAo+ID4gPiA+ID4gPiA+ID4gPiBpdCBp
biB2cF92ZHBhIGlmIG5lZWRlZCwgYW5kIHJldXNlIHRoZSBjdXJyZW50IHZkcGEgb3BzLiBTb3Jy
eSBpZiBJCj4gPiA+ID4gPiA+ID4gPiA+IHdhcyBub3QgZXhwbGljaXQgZW5vdWdoLgo+ID4gPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiBUaGUgb25seSBzb2x1dGlvbiBJIGNhbiBzZWUg
dG8gdGhhdCBpcyB0byB0cmFwICYgZW11bGF0ZSBpbiB0aGUgdmRwYQo+ID4gPiA+ID4gPiA+ID4g
PiAocGFyZW50PykgZHJpdmVyLCBhcyB0YWxrZWQgaW4gdmlydGlvLWNvbW1lbnQuIEJ1dCB0aGF0
IGNvbXBsaWNhdGVzCj4gPiA+ID4gPiA+ID4gPiA+IHRoZSBhcmNoaXRlY3R1cmU6Cj4gPiA+ID4g
PiA+ID4gPiA+ICogT2ZmZXIgVkhPU1RfQkFDS0VORF9GX1JJTkdfQUNDRVNTX0FGVEVSX0tJQ0sK
PiA+ID4gPiA+ID4gPiA+ID4gKiBTdG9yZSB2cSBlbmFibGUgc3RhdGUgc2VwYXJhdGVseSwgYXQK
PiA+ID4gPiA+ID4gPiA+ID4gdmRwYS0+Y29uZmlnLT5zZXRfdnFfcmVhZHkodHJ1ZSksIGJ1dCBu
b3QgdHJhbnNtaXQgdGhhdCBlbmFibGUgdG8gaHcKPiA+ID4gPiA+ID4gPiA+ID4gKiBTdG9yZSB0
aGUgZG9vcmJlbGwgc3RhdGUgc2VwYXJhdGVseSwgYnV0IGRvIG5vdCBjb25maWd1cmUgaXQgdG8g
dGhlCj4gPiA+ID4gPiA+ID4gPiA+IGRldmljZSBkaXJlY3RseS4KPiA+ID4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiA+ID4gQnV0IGhvdyB0byByZWNvdmVyIGlmIHRoZSBkZXZpY2UgY2Fubm90
IGNvbmZpZ3VyZSB0aGVtIGF0IGtpY2sgdGltZSwKPiA+ID4gPiA+ID4gPiA+ID4gZm9yIGV4YW1w
bGU/Cj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IE1heWJlIHdlIGNhbiBqdXN0
IGZhaWwgaWYgdGhlIHBhcmVudCBkcml2ZXIgZG9lcyBub3Qgc3VwcG9ydCBlbmFibGluZwo+ID4g
PiA+ID4gPiA+ID4gPiB0aGUgdnEgYWZ0ZXIgRFJJVkVSX09LPyBUaGF0IHdheSBubyBuZXcgZmVh
dHVyZSBmbGFnIGlzIG5lZWRlZC4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4g
VGhhbmtzIQo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFNlbnQgd2l0aCBGaXhlczogdGFn
IHBvaW50aW5nIHRvIGdpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9tc3QK
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IGNvbW1pdC4gUGxlYXNlIGxldCBtZSBrbm93IGlmIEkgc2hv
dWxkIHNlbmQgYSB2MyBvZiBbMV0gaW5zdGVhZC4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMDYw
OTEyMTI0NC1tdXR0LXNlbmQtZW1haWwtbXN0QGtlcm5lbC5vcmcvVC8KPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IC0tLQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyB8
IDcgKysrKystLQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMv
dmhvc3QvdmRwYS5jCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBpbmRleCBlMWFiZjI5ZmVkNWIuLmE3
ZTU1NDM1MjM1MSAxMDA2NDQKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmhv
c3QvdmRwYS5jCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEu
Ywo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQEAgLTY4MSwxOCArNjgxLDIxIEBAIHN0YXRpYyBsb25n
IHZob3N0X3ZkcGFfdW5sb2NrZWRfaW9jdGwoc3RydWN0IGZpbGUgKmZpbGVwLAo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gICB7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgc3RydWN0IHZob3N0
X3ZkcGEgKnYgPSBmaWxlcC0+cHJpdmF0ZV9kYXRhOwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAg
ICAgIHN0cnVjdCB2aG9zdF9kZXYgKmQgPSAmdi0+dmRldjsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ICsgICAgIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHYtPnZkcGEtPmNvbmZp
ZzsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICB2b2lkIF9fdXNlciAqYXJncCA9ICh2b2lk
IF9fdXNlciAqKWFyZzsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICB1NjQgX191c2VyICpm
ZWF0dXJlcCA9IGFyZ3A7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAtICAgICB1NjQgZmVhdHVyZXM7
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiArICAgICB1NjQgZmVhdHVyZXMsIHBhcmVudF9mZWF0dXJl
cyA9IDA7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgbG9uZyByID0gMDsKPiA+ID4gPiA+
ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgaWYgKGNtZCA9PSBWSE9T
VF9TRVRfQkFDS0VORF9GRUFUVVJFUykgewo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAg
ICAgICAgaWYgKGNvcHlfZnJvbV91c2VyKCZmZWF0dXJlcywgZmVhdHVyZXAsIHNpemVvZihmZWF0
dXJlcykpKQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm4gLUVGQVVMVDsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgaWYgKG9wcy0+
Z2V0X2JhY2tlbmRfZmVhdHVyZXMpCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiArICAgICAgICAgICAg
ICAgICAgICAgcGFyZW50X2ZlYXR1cmVzID0gb3BzLT5nZXRfYmFja2VuZF9mZWF0dXJlcyh2LT52
ZHBhKTsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgIGlmIChmZWF0dXJlcyAm
IH4oVkhPU1RfVkRQQV9CQUNLRU5EX0ZFQVRVUkVTIHwKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfU1VT
UEVORCkgfAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9SRVNVTUUpIHwKPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRf
Rl9FTkFCTEVfQUZURVJfRFJJVkVSX09LKSkpCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgcGFyZW50X2ZlYXR1cmVzKSkKPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FT1BOT1RTVVBQOwo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgaWYgKChmZWF0dXJlcyAmIEJJVF9VTEwoVkhP
U1RfQkFDS0VORF9GX1NVU1BFTkQpKSAmJgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAg
ICAgICAgICAgICAhdmhvc3RfdmRwYV9jYW5fc3VzcGVuZCh2KSkKPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IC0tCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAyLjM5LjMKPiA+ID4gPiA+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
