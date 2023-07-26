Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDD9C001DC
	for <virtualization@archiver.kernel.org>; Wed, 26 Jul 2023 08:10:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF75341BB9;
	Wed, 26 Jul 2023 08:10:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DF75341BB9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FlgmCr1S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QrWloJSR2ftu; Wed, 26 Jul 2023 08:10:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E52BF41BA5;
	Wed, 26 Jul 2023 08:10:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E52BF41BA5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9C02C0072;
	Wed, 26 Jul 2023 08:10:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F002EC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 08:10:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B7D3E41BA8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 08:10:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B7D3E41BA8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lbdCcvvnljKE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 08:10:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5FC2641BA5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 08:10:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5FC2641BA5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690359042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vIQmnRJx6fA+ZHBN0PHWuZVp9Sdb0+7CsK7MphwWnok=;
 b=FlgmCr1SYJtNqflhcc1WlvYHjbLjJ79OqZtOuDZ7O1ulA7FRiFaPyLNio9P8AXw7x7crQq
 2Br5i6Cc8JrwW7a+OIeLF53RHy3baTBCHSbHvcUBDrxzYSPzGa0EiLrpTxQirmjzTuoKtE
 i1QtRN+8WW/zGnJlAh0Q0IUMNNAIbds=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-A6OoWe35OCuwoL_UXH8GYA-1; Wed, 26 Jul 2023 04:10:40 -0400
X-MC-Unique: A6OoWe35OCuwoL_UXH8GYA-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b95d92116dso58265721fa.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 01:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690359039; x=1690963839;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vIQmnRJx6fA+ZHBN0PHWuZVp9Sdb0+7CsK7MphwWnok=;
 b=kBT+fEJ1gySO98SsLBmgVYr2A6um2OQ3i95irlMGzx5MEiOS9t0JH89O8BcYmd8UXC
 PG2hR2PIdORIZsccyMFRPUtskJtDOsoII3X3BPt3Y+RnYzi+pnkYCZRTmEiIcp9oLa4D
 Nhn1xtT+DPOeQYwt9Kqg5j5AAiXIjxCjGbVsHu6uKtMfY1LQi1S5XjaZRDRAT/HJfg75
 PsMN+tst+EY3KMXzruJA4LEImOIfRZekrHZkbIVfqrq97QVruktM3QVEZAmxtTMYkxnK
 Y3Adev0uE2pqTAY4SJORoyQcGK9Q2zlKToL3KIR9Y3fJQksnAsu67eu8b8LxxNczgIFK
 5Q2A==
X-Gm-Message-State: ABy/qLa0V/qLWpmvpFKX5xvHLicOry9jHxq2VJ4wS6OJiSbe+3FbSfwo
 41wRJcyDxfWv5xoPLFlfArjBdH9HqULUKWNjzvu1ulYYxVoEF6YdcWeewCTVc1kinqFhD6U8OYO
 1tguLfU2ONmQM9XhYp8QxhxEcOC1f0iB4hR7rIt/M9u9737YxO7+Ikd3M+Q==
X-Received: by 2002:a2e:9e59:0:b0:2b6:dc55:c3c7 with SMTP id
 g25-20020a2e9e59000000b002b6dc55c3c7mr911751ljk.20.1690359038778; 
 Wed, 26 Jul 2023 01:10:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH2J6eDkvyL5wgPWBoRpCoDpbqnqbV8kra7gLITsk9AtdJfaRahtJihuW40lHshWnwyA4HLSmzXW1m3JkcLFqE=
X-Received: by 2002:a2e:9e59:0:b0:2b6:dc55:c3c7 with SMTP id
 g25-20020a2e9e59000000b002b6dc55c3c7mr911730ljk.20.1690359038417; Wed, 26 Jul
 2023 01:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230418225638.1467969-1-peili.dev@gmail.com>
 <CAJaqyWebSowMMWh+HCjj7tmbA3Ey6C69T=SPA4k+6fd_-GjfoA@mail.gmail.com>
 <CACGkMEu0d0y82wo1p2g-ovbUTYJcVon0-t8fvgFQLokZmd7hDQ@mail.gmail.com>
 <CAGxU2F4N+xAM0gRh2dHDLSujkJ4Ek--Hk+PoTHOsxe4k+GTrrA@mail.gmail.com>
In-Reply-To: <CAGxU2F4N+xAM0gRh2dHDLSujkJ4Ek--Hk+PoTHOsxe4k+GTrrA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Jul 2023 16:10:27 +0800
Message-ID: <CACGkMEtGXOC9TCp+YrBPaV14tVt_hxUcOzRe+EFW-1YV--6w3A@mail.gmail.com>
Subject: Re: vdpa: use io_uring passthrough command for IOCTLs [was Re: [PATCH
 1/2] Reduce vdpa initialization / startup overhead]
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: peili.dev@gmail.com, Eugenio Perez Martin <eperezma@redhat.com>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 qemu devel list <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>
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

T24gVHVlLCBKdWwgMTgsIDIwMjMgYXQgNjozMuKAr1BNIFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dh
cnphcmVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBUaHUsIEFwciAyMCwgMjAyMyBhdCA2OjIw
4oCvQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24g
V2VkLCBBcHIgMTksIDIwMjMgYXQgMTE6MzPigK9QTSBFdWdlbmlvIFBlcmV6IE1hcnRpbgo+ID4g
PGVwZXJlem1hQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPiBPbiBXZWQsIEFwciAxOSwg
MjAyMyBhdCAxMjo1NuKAr0FNIDxwZWlsaS5kZXZAZ21haWwuY29tPiB3cm90ZToKPiA+ID4gPgo+
ID4gPiA+IEZyb206IFBlaSBMaSA8cGVpbGkuZGV2QGdtYWlsLmNvbT4KPiA+ID4gPgo+ID4gPiA+
IEN1cnJlbnRseSwgcGFydCBvZiB0aGUgdmRwYSBpbml0aWFsaXphdGlvbiAvIHN0YXJ0dXAgcHJv
Y2Vzcwo+ID4gPiA+IG5lZWRzIHRvIHRyaWdnZXIgbWFueSBpb2N0bHMgcGVyIHZxLCB3aGljaCBp
cyB2ZXJ5IGluZWZmaWNpZW50Cj4gPiA+ID4gYW5kIGNhdXNpbmcgdW5uZWNlc3NhcnkgY29udGV4
dCBzd2l0Y2ggYmV0d2VlbiB1c2VyIG1vZGUgYW5kCj4gPiA+ID4ga2VybmVsIG1vZGUuCj4gPiA+
ID4KPiA+ID4gPiBUaGlzIHBhdGNoIGNyZWF0ZXMgYW4gYWRkaXRpb25hbCBpb2N0bCgpIGNvbW1h
bmQsIG5hbWVseQo+ID4gPiA+IFZIT1NUX1ZEUEFfR0VUX1ZSSU5HX0dST1VQX0JBVENILCB0aGF0
IHdpbGwgYmF0Y2hpbmcKPiA+ID4gPiBjb21tYW5kcyBvZiBWSE9TVF9WRFBBX0dFVF9WUklOR19H
Uk9VUCBpbnRvIGEgc2luZ2xlCj4gPiA+ID4gaW9jdGwoKSBjYWxsLgo+ID4KPiA+IEknZCBleHBl
Y3QgdGhlcmUncyBhIGtlcm5lbCBwYXRjaCBidXQgSSBkaWRuJ3Qgc2VlIHRoYXQ/Cj4gPgo+ID4g
SWYgd2Ugd2FudCB0byBnbyB0aGlzIHdheS4gV2h5IHNpbXBseSBoYXZlIGEgbW9yZSBnZW5lcmlj
IHdheSwgdGhhdCBpcwo+ID4gaW50cm9kdWNpbmcgc29tZXRoaW5nIGxpa2U6Cj4gPgo+ID4gVkhP
U1RfQ01EX0JBVENIIHdoaWNoIGRpZCBzb21ldGhpbmcgbGlrZQo+ID4KPiA+IHN0cnVjdCB2aG9z
dF9jbWRfYmF0Y2ggewo+ID4gICAgIGludCBuY21kczsKPiA+ICAgICBzdHJ1Y3Qgdmhvc3RfaW9j
dGxzW107Cj4gPiB9Owo+ID4KPiA+IFRoZW4geW91IGNhbiBiYXRjaCBvdGhlciBpb2N0bHMgb3Ro
ZXIgdGhhbiBHRVRfVlJJTkdfR1JPVVA/Cj4gPgo+Cj4gSnVzdCByZXN0YXJ0aW5nIHRoaXMgZGlz
Y3Vzc2lvbiwgc2luY2UgSSByZWNlbnRseSB3b3JrZWQgbW9yZSB3aXRoCj4gaW9fdXJpbmcgcGFz
c3Rocm91Z2ggY29tbWFuZHMgYW5kIEkgdGhpbmsgaXQgY2FuIGhlbHAgaGVyZS4KPgo+IFRoZSBO
Vk1lIGd1eXMgaGFkIGEgc2ltaWxhciBwcm9ibGVtIChpb2N0bCB0b28gc2xvdyBmb3IgdGhlaXIg
dXNlCj4gY2FzZSlbMV1bMl0sIHNvIHRoZXkgZGV2ZWxvcGVkIGEgbmV3IGZlYXR1cmUgaW4gaW9f
dXJpbmcgdGhhdAo+IGJhc2ljYWxseSBhbGxvd3MgeW91IHRvIGRvIElPQ1RMcyBhc3luY2hyb25v
dXNseSBhbmQgaW4gYmF0Y2hlcyB1c2luZwo+IGlvX3VyaW5nLgo+Cj4gVGhlIHNhbWUgZmVhdHVy
ZSBpcyBhbHNvIHVzZWQgYnkgdWJsayBbM10gYW5kIEkgcmVjZW50bHkgdGFsa2VkIGFib3V0Cj4g
dGhpcyBhdCBEZXZDb25mIHdpdGggR2VybWFuIFs0XS4KPgo+IEJhc2ljYWxseSwgdGhlcmUncyBh
IG5ldyBjYWxsYmFjayBpbiBmb3BzIChzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zLnVyaW5nX2NtZCku
Cj4gSUlVQyBmb3IgTlZNZSAoZHJpdmVycy9udm1lL2hvc3QvaW9jdGwuYykgdGhleSB1c2VkIGV4
YWN0bHkgdGhlIHNhbWUKPiB2YWx1ZXMgdXNlZCBmb3IgSU9DVExzIGFsc28gZm9yIHRoZSBuZXcg
dXJpbmdfY21kIGNhbGxiYWNrLgo+Cj4gV2UgY291bGQgZG8gdGhlIHNhbWUuIFRoZSBjaGFuZ2Vz
IGluIHRoZSB2aG9zdC12ZHBhIGtlcm5lbCBtb2R1bGUKPiBzaG91bGQgYmUgc2ltcGxlLCBhbmQg
d2UgY291bGQgc2hhcmUgdGhlIGNvZGUgZm9yIGhhbmRsaW5nIGlvY3RsIGFuZAo+IHVyaW5nX2Nt
ZC4KPiBUaGF0IHdheSBhbnkgbmV3IGNvbW1hbmQgY2FuIGJlIHN1cHBvcnRlZCB3aXRoIGJvdGgg
Zm9yIGNvbXBhdGliaWxpdHkuCj4KPiBJbiBRRU1VIHRoZW4gd2UgY2FuIHN0YXJ0IHVzaW5nIGl0
IHRvIG9wdGltaXplIHRoZSBjb250cm9sIHBhdGguCj4KPiBXaGF0IGRvIHlvdSB0aGluaz8KClRo
aXMgbG9va3MgaW50ZXJlc3RpbmcuCgo+Cj4gSWYgaXQncyBpbnRlcmVzdGluZywgSSBjb3VsZCB0
aHJvdyBkb3duIGFuIFJGQyB3aXRoIHRoZSBjaGFuZ2VzIG9yIGlmCj4gYW55b25lIGlzIGludGVy
ZXN0ZWQgaW4gd29ya2luZyBvbiBpdCwgSSBjYW4gaGVscCB3aXRoIHRoZSBkZXRhaWxzLgoKUGxl
YXNlIGRvIHRoYXQuCgpUaGFua3MKCgo+Cj4gVGhhbmtzLAo+IFN0ZWZhbm8KPgo+IFsxXSBodHRw
czovL2xwYy5ldmVudHMvZXZlbnQvMTEvY29udHJpYnV0aW9ucy85ODkvCj4gWzJdIGh0dHBzOi8v
bHBjLmV2ZW50cy9ldmVudC8xNi9jb250cmlidXRpb25zLzEzODIvCj4gWzNdIGh0dHBzOi8vbHdu
Lm5ldC9BcnRpY2xlcy85MDM4NTUvCj4gWzRdIGh0dHBzOi8vd3d3LnlvdXR1YmUuY29tL3dhdGNo
P3Y9NkpxTlBpcnJlb1kKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
