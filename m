Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0407C38142
	for <virtualization@archiver.kernel.org>; Fri, 27 Jan 2023 10:35:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3BB2E41CC7;
	Fri, 27 Jan 2023 10:35:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3BB2E41CC7
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MoKzET/7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P82bk9r3QulZ; Fri, 27 Jan 2023 10:35:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 24D5641CD1;
	Fri, 27 Jan 2023 10:35:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 24D5641CD1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D949FC0032;
	Fri, 27 Jan 2023 10:35:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C80EC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 10:35:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F2FE741CD5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 10:35:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F2FE741CD5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F7qjSeR86q0F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 10:35:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BE9A341CC7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BE9A341CC7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 10:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674815718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BmJzvPHJ7QD6G8a76242dw/sy7+JnW9AjIP8xDPumTk=;
 b=MoKzET/7+6BlqtT3zab/htRZaToIOkgahd5Hzrg39NzBqTd7iyARL/zmcJCVPglRdGH9M0
 cExbsmZjVCLkXaMhRFqh0Q8rzBIlXdBrrtCdPBN8vpJVguSlV0+SVTgtZXVfaisiRAdGyA
 8EicR4fMu+EOq11Cj+0jTDNPNU/dDZQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-600-S0fhCOrgO1eOk1Epdt0JUg-1; Fri, 27 Jan 2023 05:35:10 -0500
X-MC-Unique: S0fhCOrgO1eOk1Epdt0JUg-1
Received: by mail-ej1-f71.google.com with SMTP id
 nc27-20020a1709071c1b00b0086dae705676so3208831ejc.12
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 02:35:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BmJzvPHJ7QD6G8a76242dw/sy7+JnW9AjIP8xDPumTk=;
 b=OsbL/ivTEnTUGxVt2rsaYswjST1te4JVfpmbR2FqoDaakYr0CjvyGKL5uxIZhSWgYw
 qjIdk7iEH9DNYcmeJEExIBhNJmUTwjAe9zH7RVAQxzBg1L8qXfK+2xrj2yavOsNfv63U
 xoaMEdif1FcpdCG0oAT0VtJVEHWSHB+C1KLj0STc29e3eUNHZhwb7bH6ko1kShoAPmii
 96ZWvN2HC8AuwZ1R2aHQNn3wK1qRgSXIEBVFzGeB7PF01vYx6PyLHtX5Zi0HGAJV9/0l
 tozhsZsyKFDTdXyuBwDCppiuNAkNLGyV25MSFTc+kl7jya0G0dpn60G3lu4hPOCTBFR3
 graA==
X-Gm-Message-State: AO0yUKXKsuKqb+MaGOUzv4X/tdOLnZbAh/zDAt5oqcPQy5cVf4GmuNHu
 bFCyqd/YTtdVJFlfYGg12Y5Uloc090Oqwt/+FOU8TMWyFUbpYweA28nsi/og0fLNWZJvfgyQzGJ
 qJux2Xp0DKpkk4cPz4RWlWjQ1u+Z1cZOhwFMdkgvGUw==
X-Received: by 2002:a17:906:2c03:b0:878:734d:1d87 with SMTP id
 e3-20020a1709062c0300b00878734d1d87mr4305393ejh.47.1674815708661; 
 Fri, 27 Jan 2023 02:35:08 -0800 (PST)
X-Google-Smtp-Source: AK7set+Nl6mfZMXpMHEPp5fPvGNYfYrMOBQ2Ev96amqK7f0vTZb6Yf4j1LsKeLNpRExCWSkCWQk/bA==
X-Received: by 2002:a17:906:2c03:b0:878:734d:1d87 with SMTP id
 e3-20020a1709062c0300b00878734d1d87mr4305377ejh.47.1674815708416; 
 Fri, 27 Jan 2023 02:35:08 -0800 (PST)
Received: from redhat.com ([2.52.137.69]) by smtp.gmail.com with ESMTPSA id
 kv15-20020a17090778cf00b007bd28b50305sm1998997ejc.200.2023.01.27.02.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jan 2023 02:35:07 -0800 (PST)
Date: Fri, 27 Jan 2023 05:35:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 3/4] virtio_ring: introduce a per virtqueue waitqueue
Message-ID: <20230127053112-mutt-send-email-mst@kernel.org>
References: <CACGkMEuNZLJRnWw+XNxJ-to1y8L2GrTrJkk0y0Gwb5H2YhDczQ@mail.gmail.com>
 <20221227022255-mutt-send-email-mst@kernel.org>
 <d77bc1ce-b73f-1ba8-f04f-b3bffeb731c3@redhat.com>
 <20221227043148-mutt-send-email-mst@kernel.org>
 <0d9f1b89-9374-747b-3fb0-b4b28ad0ace1@redhat.com>
 <CACGkMEv=+D+Es4sfde_X7F0zspVdy4Rs1Wi9qfCudsznsUrOTQ@mail.gmail.com>
 <20221229020553-mutt-send-email-mst@kernel.org>
 <CACGkMEs5s3Muo+4OfjaLK_P76rTdPhjQdTwykRNGOecAWnt+8g@mail.gmail.com>
 <20221229030633-mutt-send-email-mst@kernel.org>
 <CACGkMEukqZX=6yz1yCj+psHp5c+ZGVVuEYTUssfRCTQZgVWS6g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEukqZX=6yz1yCj+psHp5c+ZGVVuEYTUssfRCTQZgVWS6g@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

T24gRnJpLCBEZWMgMzAsIDIwMjIgYXQgMTE6NDM6MDhBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUaHUsIERlYyAyOSwgMjAyMiBhdCA0OjEwIFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8
bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFRodSwgRGVjIDI5LCAyMDIyIGF0IDA0
OjA0OjEzUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+IE9uIFRodSwgRGVjIDI5LCAy
MDIyIGF0IDM6MDcgUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6
Cj4gPiA+ID4KPiA+ID4gPiBPbiBXZWQsIERlYyAyOCwgMjAyMiBhdCAwNzo1MzowOFBNICswODAw
LCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gT24gV2VkLCBEZWMgMjgsIDIwMjIgYXQgMjoz
NCBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g5ZyoIDIwMjIvMTIvMjcgMTc6MzgsIE1pY2hhZWwgUy4g
VHNpcmtpbiDlhpnpgZM6Cj4gPiA+ID4gPiA+ID4gT24gVHVlLCBEZWMgMjcsIDIwMjIgYXQgMDU6
MTI6NThQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gPj4g5ZyoIDIwMjIv
MTIvMjcgMTU6MzMsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4gPiA+ID4gPiA+ID4+PiBP
biBUdWUsIERlYyAyNywgMjAyMiBhdCAxMjozMDozNVBNICswODAwLCBKYXNvbiBXYW5nIHdyb3Rl
Ogo+ID4gPiA+ID4gPiA+Pj4+PiBCdXQgZGV2aWNlIGlzIHN0aWxsIGdvaW5nIGFuZCB3aWxsIGxh
dGVyIHVzZSB0aGUgYnVmZmVycy4KPiA+ID4gPiA+ID4gPj4+Pj4KPiA+ID4gPiA+ID4gPj4+Pj4g
U2FtZSBmb3IgdGltZW91dCByZWFsbHkuCj4gPiA+ID4gPiA+ID4+Pj4gQXZvaWRpbmcgaW5maW5p
dGUgd2FpdC9wb2xsIGlzIG9uZSBvZiB0aGUgZ29hbHMsIGFub3RoZXIgaXMgdG8gc2xlZXAuCj4g
PiA+ID4gPiA+ID4+Pj4gSWYgd2UgdGhpbmsgdGhlIHRpbWVvdXQgaXMgaGFyZCwgd2UgY2FuIHN0
YXJ0IGZyb20gdGhlIHdhaXQuCj4gPiA+ID4gPiA+ID4+Pj4KPiA+ID4gPiA+ID4gPj4+PiBUaGFu
a3MKPiA+ID4gPiA+ID4gPj4+IElmIHRoZSBnb2FsIGlzIHRvIGF2b2lkIGRpc3J1cHRpbmcgdHJh
ZmZpYyB3aGlsZSBDVlEgaXMgaW4gdXNlLAo+ID4gPiA+ID4gPiA+Pj4gdGhhdCBzb3VuZHMgbW9y
ZSByZWFzb25hYmxlLiBFLmcuIHNvbWVvbmUgaXMgdHVybmluZyBvbiBwcm9taXNjLAo+ID4gPiA+
ID4gPiA+Pj4gYSBzcGlrZSBpbiBDUFUgdXNhZ2UgbWlnaHQgYmUgdW53ZWxjb21lLgo+ID4gPiA+
ID4gPiA+Pgo+ID4gPiA+ID4gPiA+PiBZZXMsIHRoaXMgd291bGQgYmUgbW9yZSBvYnZpb3VzIGlz
IFVQIGlzIHVzZWQuCj4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+ID4+
PiB0aGluZ3Mgd2Ugc2hvdWxkIGJlIGNhcmVmdWwgdG8gYWRkcmVzcyB0aGVuOgo+ID4gPiA+ID4g
PiA+Pj4gMS0gZGVidWdnaW5nLiBDdXJyZW50bHkgaXQncyBlYXN5IHRvIHNlZSBhIHdhcm5pbmcg
aWYgQ1BVIGlzIHN0dWNrCj4gPiA+ID4gPiA+ID4+PiAgICAgIGluIGEgbG9vcCBmb3IgYSB3aGls
ZSwgYW5kIHdlIGFsc28gZ2V0IGEgYmFja3RyYWNlLgo+ID4gPiA+ID4gPiA+Pj4gICAgICBFLmcu
IHdpdGggdGhpcyAtIGhvdyBkbyB3ZSBrbm93IHdobyBoYXMgdGhlIFJUTkw/Cj4gPiA+ID4gPiA+
ID4+PiAgICAgIFdlIG5lZWQgdG8gaW50ZWdyYXRlIHdpdGgga2VybmVsL3dhdGNoZG9nLmMgZm9y
IGdvb2QgcmVzdWx0cwo+ID4gPiA+ID4gPiA+Pj4gICAgICBhbmQgdG8gbWFrZSBzdXJlIHBvbGlj
eSBpcyBjb25zaXN0ZW50Lgo+ID4gPiA+ID4gPiA+Pgo+ID4gPiA+ID4gPiA+PiBUaGF0J3MgZmlu
ZSwgd2lsbCBjb25zaWRlciB0aGlzLgo+ID4gPiA+ID4KPiA+ID4gPiA+IFNvIGFmdGVyIHNvbWUg
aW52ZXN0aWdhdGlvbiwgaXQgc2VlbXMgdGhlIHdhdGNoZG9nLmMgZG9lc24ndCBoZWxwLiBUaGUK
PiA+ID4gPiA+IG9ubHkgZXhwb3J0IGhlbHBlciBpcyB0b3VjaF9zb2Z0bG9ja3VwX3dhdGNoZG9n
KCkgd2hpY2ggdHJpZXMgdG8gYXZvaWQKPiA+ID4gPiA+IHRyaWdnZXJpbmcgdGhlIGxvY2t1cHMg
d2FybmluZyBmb3IgdGhlIGtub3duIHNsb3cgcGF0aC4KPiA+ID4gPgo+ID4gPiA+IEkgbmV2ZXIg
c2FpZCB5b3UgY2FuIGp1c3QgdXNlIGV4aXN0aW5nIGV4cG9ydGluZyBBUElzLiBZb3UnbGwgaGF2
ZSB0bwo+ID4gPiA+IHdyaXRlIG5ldyBvbmVzIDopCj4gPiA+Cj4gPiA+IE9rLCBJIHRob3VnaHQg
eW91IHdhbnRlZCB0byB0cmlnZ2VyIHNpbWlsYXIgd2FybmluZ3MgYXMgYSB3YXRjaGRvZy4KPiA+
ID4KPiA+ID4gQnR3LCBJIHdvbmRlciB3aGF0IGtpbmQgb2YgbG9naWMgeW91IHdhbnQgaGVyZS4g
SWYgd2Ugc3dpdGNoIHRvIHVzaW5nCj4gPiA+IHNsZWVwLCB0aGVyZSB3b24ndCBiZSBzb2Z0IGxv
Y2t1cCBhbnltb3JlLiBBIHNpbXBsZSB3YWl0ICsgdGltZW91dCArCj4gPiA+IHdhcm5pbmcgc2Vl
bXMgc3VmZmljaWVudD8KPiA+ID4KPiA+ID4gVGhhbmtzCj4gPgo+ID4gSSdkIGxpa2UgdG8gYXZv
aWQgbmVlZCB0byB0ZWFjaCB1c2VycyBuZXcgQVBJcy4gU28gd2F0Y2hkb2cgc2V0dXAgdG8gYXBw
bHkKPiA+IHRvIHRoaXMgZHJpdmVyLiBUaGUgd2FybmluZyBjYW4gYmUgZGlmZmVyZW50Lgo+IAo+
IFJpZ2h0LCBzbyBpdCBsb29rcyB0byBtZSB0aGUgb25seSBwb3NzaWJsZSBzZXR1cCBpcyB0aGUK
PiB3YXRjaGRvZ190aHJlcy4gSSBwbGFuIHRvIHRyaWdnZXIgdGhlIHdhcm5pbmcgZXZlcnkgd2F0
Y2hkb2dfdGhyZXMgKiAyCj4gc2Vjb25kIChhcyBzb2Z0bG9ja3VwIGRpZCkuCj4gCj4gQW5kIEkg
dGhpbmsgaXQgd291bGQgc3RpbGwgbWFrZSBzZW5zZSB0byBmYWlsLCB3ZSBjYW4gc3RhcnQgd2l0
aCBhCj4gdmVyeSBsb25nIHRpbWVvdXQgbGlrZSAxIG1pbnV0ZXMgYW5kIGJyZWFrIHRoZSBkZXZp
Y2UuIERvZXMgdGhpcyBtYWtlCj4gc2Vuc2U/Cj4gCj4gVGhhbmtzCgpJJ2Qgc2F5IHdlIG5lZWQg
dG8gbWFrZSB0aGlzIG1hbmFnZWFibGUgdGhlbi4gQ2FuJ3Qgd2UgZG8gaXQgbm9ybWFsbHkKZS5n
LiByZWFjdCB0byBhbiBpbnRlcnJ1cHQgdG8gcmV0dXJuIHRvIHVzZXJzcGFjZT8KCgoKPiA+Cj4g
Pgo+ID4gPiA+Cj4gPiA+ID4gPiBBbmQgYmVmb3JlIHRoZSBwYXRjaCwgd2UgZW5kIHVwIHdpdGgg
YSByZWFsIGluZmluaXRlIGxvb3Agd2hpY2ggY291bGQKPiA+ID4gPiA+IGJlIGNhdWdodCBieSBS
Q1Ugc3RhbGwgZGV0ZWN0b3Igd2hpY2ggaXMgbm90IHRoZSBjYXNlIG9mIHRoZSBzbGVlcC4KPiA+
ID4gPiA+IFdoYXQgd2UgY2FuIGRvIGlzIHByb2JhYmx5IGRvIGEgcGVyaW9kaWMgbmV0ZGV2X2Vy
cigpLgo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+Cj4gPiA+ID4gT25seSB3aXRo
IGEgYmFkIGRldmljZS4KPiA+ID4gPgo+ID4gPiA+ID4gPiA+Pgo+ID4gPiA+ID4gPiA+Pgo+ID4g
PiA+ID4gPiA+Pj4gMi0gb3ZlcmhlYWQuIEluIGEgdmVyeSBjb21tb24gc2NlbmFyaW8gd2hlbiBk
ZXZpY2UgaXMgaW4gaHlwZXJ2aXNvciwKPiA+ID4gPiA+ID4gPj4+ICAgICAgcHJvZ3JhbW1pbmcg
dGltZXJzIGV0YyBoYXMgYSB2ZXJ5IGhpZ2ggb3ZlcmhlYWQsIGF0IGJvb3R1cAo+ID4gPiA+ID4g
PiA+Pj4gICAgICBsb3RzIG9mIENWUSBjb21tYW5kcyBhcmUgcnVuIGFuZCBzbG93aW5nIGJvb3Qg
ZG93biBpcyBub3QgbmljZS4KPiA+ID4gPiA+ID4gPj4+ICAgICAgbGV0J3MgcG9sbCBmb3IgYSBi
aXQgYmVmb3JlIHdhaXRpbmc/Cj4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+ID4+IFRoZW4gd2Ug
Z28gYmFjayB0byB0aGUgcXVlc3Rpb24gb2YgY2hvb3NpbmcgYSBnb29kIHRpbWVvdXQgZm9yIHBv
bGwuIEFuZAo+ID4gPiA+ID4gPiA+PiBwb2xsIHNlZW1zIHByb2JsZW1hdGljIGluIHRoZSBjYXNl
IG9mIFVQLCBzY2hlZHVsZXIgbWlnaHQgbm90IGhhdmUgdGhlCj4gPiA+ID4gPiA+ID4+IGNoYW5j
ZSB0byBydW4uCj4gPiA+ID4gPiA+ID4gUG9sbCBqdXN0IGEgYml0IDopIFNlcmlvdXNseSBJIGRv
bid0IGtub3csIGJ1dCBhdCBsZWFzdCBjaGVjayBvbmNlCj4gPiA+ID4gPiA+ID4gYWZ0ZXIga2lj
ay4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gSSB0aGluayBpdCBpcyB3aGF0
IHRoZSBjdXJyZW50IGNvZGUgZGlkIHdoZXJlIHRoZSBjb25kaXRpb24gd2lsbCBiZQo+ID4gPiA+
ID4gPiBjaGVjayBiZWZvcmUgdHJ5aW5nIHRvIHNsZWVwIGluIHRoZSB3YWl0X2V2ZW50KCkuCj4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPj4+IDMtIHN1
cHJpc2UgcmVtb3ZhbC4gbmVlZCB0byB3YWtlIHVwIHRocmVhZCBpbiBzb21lIHdheS4gd2hhdCBh
Ym91dAo+ID4gPiA+ID4gPiA+Pj4gICAgICBvdGhlciBjYXNlcyBvZiBkZXZpY2UgYnJlYWthZ2Ug
LSBpcyB0aGVyZSBhIGNoYW5jZSB0aGlzCj4gPiA+ID4gPiA+ID4+PiAgICAgIGludHJvZHVjZXMg
bmV3IGJ1Z3MgYXJvdW5kIHRoYXQ/IGF0IGxlYXN0IGVudW1lcmF0ZSB0aGVtIHBsZWFzZS4KPiA+
ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4gPj4gVGhlIGN1cnJlbnQgY29kZSBkaWQ6Cj4gPiA+ID4g
PiA+ID4+Cj4gPiA+ID4gPiA+ID4+IDEpIGNoZWNrIGZvciB2cS0+YnJva2VuCj4gPiA+ID4gPiA+
ID4+IDIpIHdha2V1cCBkdXJpbmcgQkFEX1JJTkcoKQo+ID4gPiA+ID4gPiA+Pgo+ID4gPiA+ID4g
PiA+PiBTbyB3ZSB3b24ndCBlbmQgdXAgd2l0aCBhIG5ldmVyIHdva2UgdXAgcHJvY2VzcyB3aGlj
aCBzaG91bGQgYmUgZmluZS4KPiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4gPj4gVGhhbmtzCj4g
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBCVFcgQkFEX1JJTkcgb24gcmVtb3ZhbCB3aWxsIHRy
aWdnZXIgZGV2X2Vyci4gTm90IHN1cmUgdGhhdCBpcyBhIGdvb2QKPiA+ID4gPiA+ID4gPiBpZGVh
IC0gY2FuIGNhdXNlIGNyYXNoZXMgaWYga2VybmVsIHBhbmljcyBvbiBlcnJvci4KPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gWWVzLCBpdCdzIGJldHRlciB0byB1c2UgX192aXJ0
cXVldWVfYnJlYWsoKSBpbnN0ZWFkLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBCdXQgY29uc2lk
ZXIgd2Ugd2lsbCBzdGFydCBmcm9tIGEgd2FpdCBmaXJzdCwgSSB3aWxsIGxpbWl0IHRoZSBjaGFu
Z2VzCj4gPiA+ID4gPiA+IGluIHZpcnRpby1uZXQgd2l0aG91dCBib3RoZXJpbmcgdmlydGlvIGNv
cmUuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4+Pgo+ID4gPiA+Cj4gPgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
