Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01884C4332F
	for <virtualization@archiver.kernel.org>; Fri, 30 Dec 2022 03:43:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6693981A8E;
	Fri, 30 Dec 2022 03:43:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6693981A8E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N0JQjNLI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CuLiIjrrZhQo; Fri, 30 Dec 2022 03:43:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DD53381990;
	Fri, 30 Dec 2022 03:43:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DD53381990
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84907C0033;
	Fri, 30 Dec 2022 03:43:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4AF0C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Dec 2022 03:43:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8885B81A8E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Dec 2022 03:43:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8885B81A8E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BV7qGUe9QBvG
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Dec 2022 03:43:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A5F3281990
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A5F3281990
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Dec 2022 03:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672371802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SKYNQFF9uhdzrxgpM6RHZiv3BQxZcu9+EDqyhxaDQPg=;
 b=N0JQjNLId3LmBtkohOFwzdj8icVl5Kzjqdm9f8cF6/UvVBtSqU7YvbckaSLKo1iDKAawvV
 v2cHwWG1eFfNZUg5LB8SEwBJGJS19pADGfxZf1SilEA7S5rCyyxbNXezXVeH8bN056TfTj
 j8DHAlUaEK/kMT9Ap7e2njUe1LBJOEs=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-640-RTqzQd6sMB6qI1zNjFIYtw-1; Thu, 29 Dec 2022 22:43:20 -0500
X-MC-Unique: RTqzQd6sMB6qI1zNjFIYtw-1
Received: by mail-oo1-f69.google.com with SMTP id
 x1-20020a4a9b81000000b004dfca255b77so2178798ooj.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 19:43:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SKYNQFF9uhdzrxgpM6RHZiv3BQxZcu9+EDqyhxaDQPg=;
 b=J2rIrw/HVvLUvByKCu5J2+7e6UBTdkMQEbBFt0t1wUC3jLoa8STSaBIDHxzns7z5dl
 OKlz0hKs2j5qe0dVls04sVzU0+c1reQqlsSNUvVwEmVoeyA8v6hFKHZVX3txd4gpP8a4
 QnT3g/g5JA0xa5zln8HWgaBocgCfsNNDevESC65OnXzbBtj6ftWiM2RkW0MmhYVqlJPw
 0lziBVs9W3B0szbhHmLDhbRVfdoKZtKqYc30DK03my07wmAmeXiQ11s4TJxeOlMVGAGZ
 BkUW7H1OH4EbOphDoc2fwoU5zSE75bOP8ustjXCqj+OpY+zzAFCruU2PP1aGlRiKcHTL
 S3YA==
X-Gm-Message-State: AFqh2kqjhCEO4WM/MaYDi0970UIrrx/7pgYapDxSrkaZig5DeE6WByuO
 nJRuOIRaACwRXzGtrBLeq3+qkAafoPvvfVb7/v4rG04nj8ixLt0LsLj4XhCDxtrdkr4r3HscKTH
 iYJrzPpZrCyJO71BmMYABp5ghzIQW3M/s7VUAQnJxPAHRLwSPBWYLW9RB+Q==
X-Received: by 2002:aca:1111:0:b0:35e:7a42:7ab5 with SMTP id
 17-20020aca1111000000b0035e7a427ab5mr1625312oir.280.1672371799941; 
 Thu, 29 Dec 2022 19:43:19 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv4NDDUzOLaitxmb36Ed0Wi9X6Ew8PlgA0rL9oGk47+jBfyvQTDFkl+dZSEdzXlqh8l/ctTQgvTKq95bTEitYA=
X-Received: by 2002:aca:1111:0:b0:35e:7a42:7ab5 with SMTP id
 17-20020aca1111000000b0035e7a427ab5mr1625301oir.280.1672371799697; Thu, 29
 Dec 2022 19:43:19 -0800 (PST)
MIME-Version: 1.0
References: <20221226074908.8154-4-jasowang@redhat.com>
 <20221226183705-mutt-send-email-mst@kernel.org>
 <CACGkMEuNZLJRnWw+XNxJ-to1y8L2GrTrJkk0y0Gwb5H2YhDczQ@mail.gmail.com>
 <20221227022255-mutt-send-email-mst@kernel.org>
 <d77bc1ce-b73f-1ba8-f04f-b3bffeb731c3@redhat.com>
 <20221227043148-mutt-send-email-mst@kernel.org>
 <0d9f1b89-9374-747b-3fb0-b4b28ad0ace1@redhat.com>
 <CACGkMEv=+D+Es4sfde_X7F0zspVdy4Rs1Wi9qfCudsznsUrOTQ@mail.gmail.com>
 <20221229020553-mutt-send-email-mst@kernel.org>
 <CACGkMEs5s3Muo+4OfjaLK_P76rTdPhjQdTwykRNGOecAWnt+8g@mail.gmail.com>
 <20221229030633-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221229030633-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 30 Dec 2022 11:43:08 +0800
Message-ID: <CACGkMEukqZX=6yz1yCj+psHp5c+ZGVVuEYTUssfRCTQZgVWS6g@mail.gmail.com>
Subject: Re: [PATCH 3/4] virtio_ring: introduce a per virtqueue waitqueue
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, maxime.coquelin@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

T24gVGh1LCBEZWMgMjksIDIwMjIgYXQgNDoxMCBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIFRodSwgRGVjIDI5LCAyMDIyIGF0IDA0OjA0OjEzUE0g
KzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiBPbiBUaHUsIERlYyAyOSwgMjAyMiBhdCAzOjA3
IFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPgo+ID4g
PiBPbiBXZWQsIERlYyAyOCwgMjAyMiBhdCAwNzo1MzowOFBNICswODAwLCBKYXNvbiBXYW5nIHdy
b3RlOgo+ID4gPiA+IE9uIFdlZCwgRGVjIDI4LCAyMDIyIGF0IDI6MzQgUE0gSmFzb24gV2FuZyA8
amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+
IOWcqCAyMDIyLzEyLzI3IDE3OjM4LCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+ID4gPiA+
ID4gPiBPbiBUdWUsIERlYyAyNywgMjAyMiBhdCAwNToxMjo1OFBNICswODAwLCBKYXNvbiBXYW5n
IHdyb3RlOgo+ID4gPiA+ID4gPj4g5ZyoIDIwMjIvMTIvMjcgMTU6MzMsIE1pY2hhZWwgUy4gVHNp
cmtpbiDlhpnpgZM6Cj4gPiA+ID4gPiA+Pj4gT24gVHVlLCBEZWMgMjcsIDIwMjIgYXQgMTI6MzA6
MzVQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4+Pj4+IEJ1dCBkZXZpY2Ug
aXMgc3RpbGwgZ29pbmcgYW5kIHdpbGwgbGF0ZXIgdXNlIHRoZSBidWZmZXJzLgo+ID4gPiA+ID4g
Pj4+Pj4KPiA+ID4gPiA+ID4+Pj4+IFNhbWUgZm9yIHRpbWVvdXQgcmVhbGx5Lgo+ID4gPiA+ID4g
Pj4+PiBBdm9pZGluZyBpbmZpbml0ZSB3YWl0L3BvbGwgaXMgb25lIG9mIHRoZSBnb2FscywgYW5v
dGhlciBpcyB0byBzbGVlcC4KPiA+ID4gPiA+ID4+Pj4gSWYgd2UgdGhpbmsgdGhlIHRpbWVvdXQg
aXMgaGFyZCwgd2UgY2FuIHN0YXJ0IGZyb20gdGhlIHdhaXQuCj4gPiA+ID4gPiA+Pj4+Cj4gPiA+
ID4gPiA+Pj4+IFRoYW5rcwo+ID4gPiA+ID4gPj4+IElmIHRoZSBnb2FsIGlzIHRvIGF2b2lkIGRp
c3J1cHRpbmcgdHJhZmZpYyB3aGlsZSBDVlEgaXMgaW4gdXNlLAo+ID4gPiA+ID4gPj4+IHRoYXQg
c291bmRzIG1vcmUgcmVhc29uYWJsZS4gRS5nLiBzb21lb25lIGlzIHR1cm5pbmcgb24gcHJvbWlz
YywKPiA+ID4gPiA+ID4+PiBhIHNwaWtlIGluIENQVSB1c2FnZSBtaWdodCBiZSB1bndlbGNvbWUu
Cj4gPiA+ID4gPiA+Pgo+ID4gPiA+ID4gPj4gWWVzLCB0aGlzIHdvdWxkIGJlIG1vcmUgb2J2aW91
cyBpcyBVUCBpcyB1c2VkLgo+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+Pj4g
dGhpbmdzIHdlIHNob3VsZCBiZSBjYXJlZnVsIHRvIGFkZHJlc3MgdGhlbjoKPiA+ID4gPiA+ID4+
PiAxLSBkZWJ1Z2dpbmcuIEN1cnJlbnRseSBpdCdzIGVhc3kgdG8gc2VlIGEgd2FybmluZyBpZiBD
UFUgaXMgc3R1Y2sKPiA+ID4gPiA+ID4+PiAgICAgIGluIGEgbG9vcCBmb3IgYSB3aGlsZSwgYW5k
IHdlIGFsc28gZ2V0IGEgYmFja3RyYWNlLgo+ID4gPiA+ID4gPj4+ICAgICAgRS5nLiB3aXRoIHRo
aXMgLSBob3cgZG8gd2Uga25vdyB3aG8gaGFzIHRoZSBSVE5MPwo+ID4gPiA+ID4gPj4+ICAgICAg
V2UgbmVlZCB0byBpbnRlZ3JhdGUgd2l0aCBrZXJuZWwvd2F0Y2hkb2cuYyBmb3IgZ29vZCByZXN1
bHRzCj4gPiA+ID4gPiA+Pj4gICAgICBhbmQgdG8gbWFrZSBzdXJlIHBvbGljeSBpcyBjb25zaXN0
ZW50Lgo+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4+IFRoYXQncyBmaW5lLCB3aWxsIGNvbnNpZGVy
IHRoaXMuCj4gPiA+ID4KPiA+ID4gPiBTbyBhZnRlciBzb21lIGludmVzdGlnYXRpb24sIGl0IHNl
ZW1zIHRoZSB3YXRjaGRvZy5jIGRvZXNuJ3QgaGVscC4gVGhlCj4gPiA+ID4gb25seSBleHBvcnQg
aGVscGVyIGlzIHRvdWNoX3NvZnRsb2NrdXBfd2F0Y2hkb2coKSB3aGljaCB0cmllcyB0byBhdm9p
ZAo+ID4gPiA+IHRyaWdnZXJpbmcgdGhlIGxvY2t1cHMgd2FybmluZyBmb3IgdGhlIGtub3duIHNs
b3cgcGF0aC4KPiA+ID4KPiA+ID4gSSBuZXZlciBzYWlkIHlvdSBjYW4ganVzdCB1c2UgZXhpc3Rp
bmcgZXhwb3J0aW5nIEFQSXMuIFlvdSdsbCBoYXZlIHRvCj4gPiA+IHdyaXRlIG5ldyBvbmVzIDop
Cj4gPgo+ID4gT2ssIEkgdGhvdWdodCB5b3Ugd2FudGVkIHRvIHRyaWdnZXIgc2ltaWxhciB3YXJu
aW5ncyBhcyBhIHdhdGNoZG9nLgo+ID4KPiA+IEJ0dywgSSB3b25kZXIgd2hhdCBraW5kIG9mIGxv
Z2ljIHlvdSB3YW50IGhlcmUuIElmIHdlIHN3aXRjaCB0byB1c2luZwo+ID4gc2xlZXAsIHRoZXJl
IHdvbid0IGJlIHNvZnQgbG9ja3VwIGFueW1vcmUuIEEgc2ltcGxlIHdhaXQgKyB0aW1lb3V0ICsK
PiA+IHdhcm5pbmcgc2VlbXMgc3VmZmljaWVudD8KPiA+Cj4gPiBUaGFua3MKPgo+IEknZCBsaWtl
IHRvIGF2b2lkIG5lZWQgdG8gdGVhY2ggdXNlcnMgbmV3IEFQSXMuIFNvIHdhdGNoZG9nIHNldHVw
IHRvIGFwcGx5Cj4gdG8gdGhpcyBkcml2ZXIuIFRoZSB3YXJuaW5nIGNhbiBiZSBkaWZmZXJlbnQu
CgpSaWdodCwgc28gaXQgbG9va3MgdG8gbWUgdGhlIG9ubHkgcG9zc2libGUgc2V0dXAgaXMgdGhl
CndhdGNoZG9nX3RocmVzLiBJIHBsYW4gdG8gdHJpZ2dlciB0aGUgd2FybmluZyBldmVyeSB3YXRj
aGRvZ190aHJlcyAqIDIKc2Vjb25kIChhcyBzb2Z0bG9ja3VwIGRpZCkuCgpBbmQgSSB0aGluayBp
dCB3b3VsZCBzdGlsbCBtYWtlIHNlbnNlIHRvIGZhaWwsIHdlIGNhbiBzdGFydCB3aXRoIGEKdmVy
eSBsb25nIHRpbWVvdXQgbGlrZSAxIG1pbnV0ZXMgYW5kIGJyZWFrIHRoZSBkZXZpY2UuIERvZXMg
dGhpcyBtYWtlCnNlbnNlPwoKVGhhbmtzCgo+Cj4KPiA+ID4KPiA+ID4gPiBBbmQgYmVmb3JlIHRo
ZSBwYXRjaCwgd2UgZW5kIHVwIHdpdGggYSByZWFsIGluZmluaXRlIGxvb3Agd2hpY2ggY291bGQK
PiA+ID4gPiBiZSBjYXVnaHQgYnkgUkNVIHN0YWxsIGRldGVjdG9yIHdoaWNoIGlzIG5vdCB0aGUg
Y2FzZSBvZiB0aGUgc2xlZXAuCj4gPiA+ID4gV2hhdCB3ZSBjYW4gZG8gaXMgcHJvYmFibHkgZG8g
YSBwZXJpb2RpYyBuZXRkZXZfZXJyKCkuCj4gPiA+ID4KPiA+ID4gPiBUaGFua3MKPiA+ID4KPiA+
ID4gT25seSB3aXRoIGEgYmFkIGRldmljZS4KPiA+ID4KPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+
Pgo+ID4gPiA+ID4gPj4+IDItIG92ZXJoZWFkLiBJbiBhIHZlcnkgY29tbW9uIHNjZW5hcmlvIHdo
ZW4gZGV2aWNlIGlzIGluIGh5cGVydmlzb3IsCj4gPiA+ID4gPiA+Pj4gICAgICBwcm9ncmFtbWlu
ZyB0aW1lcnMgZXRjIGhhcyBhIHZlcnkgaGlnaCBvdmVyaGVhZCwgYXQgYm9vdHVwCj4gPiA+ID4g
PiA+Pj4gICAgICBsb3RzIG9mIENWUSBjb21tYW5kcyBhcmUgcnVuIGFuZCBzbG93aW5nIGJvb3Qg
ZG93biBpcyBub3QgbmljZS4KPiA+ID4gPiA+ID4+PiAgICAgIGxldCdzIHBvbGwgZm9yIGEgYml0
IGJlZm9yZSB3YWl0aW5nPwo+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4+IFRoZW4gd2UgZ28gYmFj
ayB0byB0aGUgcXVlc3Rpb24gb2YgY2hvb3NpbmcgYSBnb29kIHRpbWVvdXQgZm9yIHBvbGwuIEFu
ZAo+ID4gPiA+ID4gPj4gcG9sbCBzZWVtcyBwcm9ibGVtYXRpYyBpbiB0aGUgY2FzZSBvZiBVUCwg
c2NoZWR1bGVyIG1pZ2h0IG5vdCBoYXZlIHRoZQo+ID4gPiA+ID4gPj4gY2hhbmNlIHRvIHJ1bi4K
PiA+ID4gPiA+ID4gUG9sbCBqdXN0IGEgYml0IDopIFNlcmlvdXNseSBJIGRvbid0IGtub3csIGJ1
dCBhdCBsZWFzdCBjaGVjayBvbmNlCj4gPiA+ID4gPiA+IGFmdGVyIGtpY2suCj4gPiA+ID4gPgo+
ID4gPiA+ID4KPiA+ID4gPiA+IEkgdGhpbmsgaXQgaXMgd2hhdCB0aGUgY3VycmVudCBjb2RlIGRp
ZCB3aGVyZSB0aGUgY29uZGl0aW9uIHdpbGwgYmUKPiA+ID4gPiA+IGNoZWNrIGJlZm9yZSB0cnlp
bmcgdG8gc2xlZXAgaW4gdGhlIHdhaXRfZXZlbnQoKS4KPiA+ID4gPiA+Cj4gPiA+ID4gPgo+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPj4+IDMtIHN1cHJpc2UgcmVtb3ZhbC4gbmVlZCB0byB3YWtlIHVw
IHRocmVhZCBpbiBzb21lIHdheS4gd2hhdCBhYm91dAo+ID4gPiA+ID4gPj4+ICAgICAgb3RoZXIg
Y2FzZXMgb2YgZGV2aWNlIGJyZWFrYWdlIC0gaXMgdGhlcmUgYSBjaGFuY2UgdGhpcwo+ID4gPiA+
ID4gPj4+ICAgICAgaW50cm9kdWNlcyBuZXcgYnVncyBhcm91bmQgdGhhdD8gYXQgbGVhc3QgZW51
bWVyYXRlIHRoZW0gcGxlYXNlLgo+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4+IFRoZSBjdXJyZW50
IGNvZGUgZGlkOgo+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4+IDEpIGNoZWNrIGZvciB2cS0+YnJv
a2VuCj4gPiA+ID4gPiA+PiAyKSB3YWtldXAgZHVyaW5nIEJBRF9SSU5HKCkKPiA+ID4gPiA+ID4+
Cj4gPiA+ID4gPiA+PiBTbyB3ZSB3b24ndCBlbmQgdXAgd2l0aCBhIG5ldmVyIHdva2UgdXAgcHJv
Y2VzcyB3aGljaCBzaG91bGQgYmUgZmluZS4KPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+PiBUaGFu
a3MKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gQlRXIEJBRF9SSU5HIG9uIHJlbW92YWwgd2lsbCB0
cmlnZ2VyIGRldl9lcnIuIE5vdCBzdXJlIHRoYXQgaXMgYSBnb29kCj4gPiA+ID4gPiA+IGlkZWEg
LSBjYW4gY2F1c2UgY3Jhc2hlcyBpZiBrZXJuZWwgcGFuaWNzIG9uIGVycm9yLgo+ID4gPiA+ID4K
PiA+ID4gPiA+Cj4gPiA+ID4gPiBZZXMsIGl0J3MgYmV0dGVyIHRvIHVzZSBfX3ZpcnRxdWV1ZV9i
cmVhaygpIGluc3RlYWQuCj4gPiA+ID4gPgo+ID4gPiA+ID4gQnV0IGNvbnNpZGVyIHdlIHdpbGwg
c3RhcnQgZnJvbSBhIHdhaXQgZmlyc3QsIEkgd2lsbCBsaW1pdCB0aGUgY2hhbmdlcwo+ID4gPiA+
ID4gaW4gdmlydGlvLW5ldCB3aXRob3V0IGJvdGhlcmluZyB2aXJ0aW8gY29yZS4KPiA+ID4gPiA+
Cj4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPj4+Cj4gPiA+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
