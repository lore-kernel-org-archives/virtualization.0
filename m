Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E11AC001DE
	for <virtualization@archiver.kernel.org>; Mon, 24 Jul 2023 07:12:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD45581E47;
	Mon, 24 Jul 2023 07:12:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DD45581E47
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YbjfFxSE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8opKs0qlH6HJ; Mon, 24 Jul 2023 07:12:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5DD7C8175E;
	Mon, 24 Jul 2023 07:12:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5DD7C8175E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F763C0071;
	Mon, 24 Jul 2023 07:12:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80433C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 07:12:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 528FE40A01
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 07:12:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 528FE40A01
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YbjfFxSE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oDlAnGqJBxJN
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 07:12:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CD82E4099D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 07:12:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CD82E4099D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690182729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zelsN5BeeBrPMCjnspiDiZUy4sr+lnzwwZJWHuHRBfs=;
 b=YbjfFxSERCr6YT2stBuGNiKaKsSrZsabMuXfHarJ/G2utjJoWki/fx28z0y0d8vieQhIoN
 gbHN2EeHI/vQKYyumnbPRAqvx2x2CKQpNJm2w2b2NOqabkcuISOCwocfwINtjxKKm4Wjv/
 e5mvghTlORq3gjSkzLxejt+273PzXgk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655--QQO8ooOPS2N8D_-fDx88w-1; Mon, 24 Jul 2023 03:12:08 -0400
X-MC-Unique: -QQO8ooOPS2N8D_-fDx88w-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b95d92116dso34156571fa.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 00:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690182726; x=1690787526;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zelsN5BeeBrPMCjnspiDiZUy4sr+lnzwwZJWHuHRBfs=;
 b=VZDkOBea577j/oKGKlJqKdETjxlkTfNHB0oV3kbk1w9yjY9xRGSXrwEOeaiu9Le0wZ
 F9Z+3f6HsRx9bqrGFPdkAKzRCVhlkvpxHEPausoTpc7/XKj48LguVRg4flWUgscJZWww
 i31CMxoz7H/cYWIEWcODjxh9sf7ad1e9eh49RX6br6RGsU8rN0vzG/fbpP6/phM698XN
 d8WZI0SXHjGGlpUPy5vGHReeE3eC9bSRJ8N1m6KhtRgy64pJKRJPx2T/caMjkksqy0YY
 veVfWwxzA8Dyzas40Pv3Lde80CXFI1Cbgv4qliuGu8xJellZowRD+bIFP1OhQwyzO8+I
 IMJQ==
X-Gm-Message-State: ABy/qLZaiykrOMKGtWPkMsU0VFDWr+M3d7l2rN4sR6DUbQlKEqj+oN/U
 05KBvDngiF54AiaLCOKEnLkjFAhwQSFVs/UmPFgaL/od8BGudEGeFUlL3T46bk2O/s49ufHC7p4
 uz/uvFBLKZtnE457/qHjuK3Zd8Tmm9pqMNLcjcG2+aaoOjMoBTVO2s4yeSg==
X-Received: by 2002:a2e:9c93:0:b0:2b6:dd9a:e1d3 with SMTP id
 x19-20020a2e9c93000000b002b6dd9ae1d3mr5575017lji.44.1690182726703; 
 Mon, 24 Jul 2023 00:12:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF/dSwy0GmZagFnogQhoaJYCR8t/Cuk1jUqXQpbcm+KkX8fY/+GF61XRMrS9DnuWvdZKn5Uuid3IjmwRT2134U=
X-Received: by 2002:a2e:9c93:0:b0:2b6:dd9a:e1d3 with SMTP id
 x19-20020a2e9c93000000b002b6dd9ae1d3mr5575002lji.44.1690182726409; Mon, 24
 Jul 2023 00:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230723080507.3716924-1-linma@zju.edu.cn>
 <20230723050656-mutt-send-email-mst@kernel.org>
 <729f5c17.e4079.18982192866.Coremail.linma@zju.edu.cn>
 <8ecec51.e40ad.1898226c545.Coremail.linma@zju.edu.cn>
 <20230723055820-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230723055820-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Jul 2023 15:11:55 +0800
Message-ID: <CACGkMEuGHMu6te3jRfEhhwTrWR1mpqp3hbVhDKQiXK9tgwz3qw@mail.gmail.com>
Subject: Re: [PATCH v1] vdpa: Complement vdpa_nl_policy for nlattr length check
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eli Cohen <elic@nvidia.com>,
 Lin Ma <linma@zju.edu.cn>
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

T24gU3VuLCBKdWwgMjMsIDIwMjMgYXQgNjowMuKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gU3VuLCBKdWwgMjMsIDIwMjMgYXQgMDU6NDg6NDZQ
TSArMDgwMCwgTGluIE1hIHdyb3RlOgo+ID4KPiA+ID4gU3VyZSwgdGhhdCBpcyBhbm90aGVyIHVu
ZGVyZ29pbmcgdGFzayBJJ20gd29ya2luZyBvbi4gSWYgdGhlIG5sYXR0ciBpcyBwYXJzZWQgd2l0
aAo+ID4gPiBOTF9WQUxJREFURV9VTlNQRUMsIGFueSBmb3Jnb3R0ZW4gbmxhdHRyIHdpbGwgYmUg
cmVqZWN0ZWQsIHRoZXJlZm9yZSAod2hpY2ggaXMgdGhlIGRlZmF1bHQKPiA+ID4gZm9yIG1vZGVy
biBubGFfcGFyc2UpLgo+ID4KPiA+IEZvciB0aGUgZ2VuZXJhbCBuZXRsaW5rIGludGVyZmFjZSwg
dGhlIGRlY2lkaW5nIGZsYWcgc2hvdWxkIGJlIGdlbmxfb3BzLnZhbGlkYXRlIGRlZmluZWQgaW4K
PiA+IGVhY2ggb3BzLiBUaGUgZGVmYXVsdCB2YWxpZGF0ZSBmbGFnIGlzIHN0cmljdCwgd2hpbGUg
dGhlIGRldmVsb3BlciBjYW4gb3ZlcndyaXRlIHRoZSBmbGFnCj4gPiB3aXRoIEdFTkxfRE9OVF9W
QUxJREFURV9TVFJJQ1QgdG8gZWFzZSB0aGUgdmFsaWRhdGlvbi4gVGhhdCBpcyB0byBzYXksIHNh
ZmVyIGNvZGUgc2hvdWxkCj4gPiBlbmZvcmNlIE5MX1ZBTElEQVRFX1NUUklDVCBieSBub3Qgb3Zl
cndyaXRpbmcgdGhlIHZhbGlkYXRlIGZsYWcuCj4gPgo+ID4gUmVncmFkcwo+ID4gTGluCj4KPgo+
IE9oIEkgc2VlLgo+Cj4gSXQgc3RhcnRlZCBoZXJlOgo+Cj4gY29tbWl0IDMzYjM0NzUwM2YwMTRl
YmY3NjI1NzMyN2NiYzcwMDFjNmI3MjE5NTYKPiBBdXRob3I6IFBhcmF2IFBhbmRpdCA8cGFyYXZA
bnZpZGlhLmNvbT4KPiBEYXRlOiAgIFR1ZSBKYW4gNSAxMjozMjowMCAyMDIxICswMjAwCj4KPiAg
ICAgdmRwYTogRGVmaW5lIHZkcGEgbWdtdCBkZXZpY2UsIG9wcyBhbmQgYSBuZXRsaW5rIGludGVy
ZmFjZQo+Cj4gd2hpY2ggZGlkOgo+Cj4gKyAgICAgICAgICAgICAgIC52YWxpZGF0ZSA9IEdFTkxf
RE9OVF9WQUxJREFURV9TVFJJQ1QgfCBHRU5MX0RPTlRfVkFMSURBVEVfRFVNUCwKPgo+Cj4gd2hp
Y2ggd2FzIG1vc3QgbGlrZWx5IGp1c3QgYSBjb3B5IHBhc3RlIGZyb20gc29tZXdoZXJlLCByaWdo
dCBQYXJhdj8KPgo+IGFuZCB0aGVuIGV2ZXJ5b25lIGtlcHQgY29weWluZyB0aGlzIGFyb3VuZC4K
Pgo+IFBhcmF2LCBFbGkgY2FuIHdlIGRyb3AgdGhlc2U/IFRoZXJlJ3MgYSB0aW55IGNoYW5jZSBv
ZiBicmVha2luZyBzb21ldGhpbmcKPiBidXQgSSBmZWVsIHRoZXJlIGFyZW4ndCB0aGF0IG1hbnkg
dXNlcnMgb3V0c2lkZSBtbHg1IHlldCwgc28gaWYgeW91Cj4gZ3V5cyBjYW4gdGVzdCBvbiBtbHg1
IGFuZCBjb25maXJtIG5vIGJyZWFrYWdlLCBJIHRoaW5rIHdlIGFyZSBnb29kLgoKQWRkaW5nIERy
YWdvcy4KClRoYW5rcwoKPgo+IC0tCj4gTVNUCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
