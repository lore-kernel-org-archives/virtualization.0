Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC5AEB64D9
	for <virtualization@archiver.kernel.org>; Thu,  6 Jul 2023 07:56:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 388554057F;
	Thu,  6 Jul 2023 07:56:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 388554057F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iBKhiAv2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mFGR5b3u4yoO; Thu,  6 Jul 2023 07:56:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6774140194;
	Thu,  6 Jul 2023 07:56:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6774140194
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45151C0072;
	Thu,  6 Jul 2023 07:56:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 435D3C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 07:56:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0FDAD81951
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 07:56:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0FDAD81951
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iBKhiAv2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MDvrTkcmRk6i
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 07:56:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 49D03818D0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 49D03818D0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 07:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688630166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hySNpHyRfM9pyhg8/6aj+xHmN6E1rSwH8K6gl3I4pyE=;
 b=iBKhiAv2/EmLW4MU5uUlu0aZ1PPMYcHHX9ZNPt/Hy+cq5JJco+JiBBXnv10f0uk1NMT99m
 /+2FUqYYPN9mNTVlLUn8l9hA0fzgsoEDFmkCk/UnRY53lPh6ZADRHi+P3mRdtfsRQHWxl8
 7U6A1dzYMD+EJB0XzRsL29k3luTTqC0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-iwQ4jZq9P8q3DmYxsxx1kQ-1; Thu, 06 Jul 2023 03:56:05 -0400
X-MC-Unique: iwQ4jZq9P8q3DmYxsxx1kQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b6f51c5cb3so3861981fa.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jul 2023 00:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688630164; x=1691222164;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hySNpHyRfM9pyhg8/6aj+xHmN6E1rSwH8K6gl3I4pyE=;
 b=O5FMhrC4B+3xycgT13tTvGahfbFkIMoWvOynu8orD1+tjFcsC+8d4VyLb1EGHgGOiz
 uN3IPwYgpxzQejWzo5uwIB57mJd2VCF+GlFJD7SlZnjG/tcDDImRCb50SPetYARbVC74
 GUQS4qwyl/ENvD20+2OQ10OhsOlm3bhFv8Vv20sJHAbxkIPeTQJ5VVEp/KkgUCGSaKlw
 f3BEv860hnd09LAoMhZ0RWiFXh32kGlwqaLxGRFjkgONFwQ82wN/5RsJ/0E4WN30igjX
 yr/1gFjL/dt3DYf9h+uXlgjfCsqeUi/BSfFQN4DPiukgy8fqH1Sq4b5VZUuAZ3tokevd
 z2Xg==
X-Gm-Message-State: ABy/qLYy55Ld3Z2V4t5kgGQkxp6hPvdCDvpVhWEIpTPa3nuxq/PqZf/V
 hCA227XRU1qhf4LjIOXFqV7rFp6ehIlvgqdMZNyoUwysgZ72VN9PQTo1qBFU1m/BEepcnBcWWVX
 zCvpUwKuUxkeNprTFyP9XG7hGz7MT+eibA58KoKGRQ3hQBd3mGSadaWbZ2A==
X-Received: by 2002:a2e:a3d2:0:b0:2b6:e7d6:714d with SMTP id
 w18-20020a2ea3d2000000b002b6e7d6714dmr785218lje.22.1688630163900; 
 Thu, 06 Jul 2023 00:56:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEGqpBXE59HBwjbO7My8NVcvPAFY35DXSBKLlPiZZo3282vdH1Mirq6QjNHCyspslFcO8XqSvO+AtuZfIQIpDY=
X-Received: by 2002:a2e:a3d2:0:b0:2b6:e7d6:714d with SMTP id
 w18-20020a2ea3d2000000b002b6e7d6714dmr785203lje.22.1688630163562; Thu, 06 Jul
 2023 00:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230703142218.362549-1-eperezma@redhat.com>
 <20230703105022-mutt-send-email-mst@kernel.org>
 <CAJaqyWf2F_yBLBjj1RiPeJ92_zfq8BSMz8Pak2Vg6QinN8jS1Q@mail.gmail.com>
 <20230704063646-mutt-send-email-mst@kernel.org>
 <CAJaqyWfdPpkD5pY4tfzQdOscLBcrDBhBqzWjMbY_ZKsoyiqGdA@mail.gmail.com>
 <20230704114159-mutt-send-email-mst@kernel.org>
 <CACGkMEtWjOMtsbgQ2sx=e1BkuRSyDmVfXDccCm-QSiSbacQyCA@mail.gmail.com>
 <20230705043940-mutt-send-email-mst@kernel.org>
 <CACGkMEufNZGvWMN9Shh6NPOZOe-vf0RomfS1DX6DtxJjvO7fNA@mail.gmail.com>
 <CAJaqyWcqNkzJXxsoz_Lk_X0CvNW24Ay2Ki6q02EB8iR=qpwsfg@mail.gmail.com>
In-Reply-To: <CAJaqyWcqNkzJXxsoz_Lk_X0CvNW24Ay2Ki6q02EB8iR=qpwsfg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 6 Jul 2023 15:55:51 +0800
Message-ID: <CACGkMEvDsZcyTDBhS8ekXHyv-kiipyHizewpM2+=0XgSYMsmbw@mail.gmail.com>
Subject: Re: [PATCH] vdpa: reject F_ENABLE_AFTER_DRIVER_OK if backend does not
 support it
To: Eugenio Perez Martin <eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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

T24gVGh1LCBKdWwgNiwgMjAyMyBhdCAzOjA24oCvUE0gRXVnZW5pbyBQZXJleiBNYXJ0aW4gPGVw
ZXJlem1hQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gVGh1LCBKdWwgNiwgMjAyMyBhdCAzOjU1
4oCvQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24g
V2VkLCBKdWwgNSwgMjAyMyBhdCA0OjQx4oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4gPiA+Cj4gPiA+IE9uIFdlZCwgSnVsIDA1LCAyMDIzIGF0IDAzOjQ5
OjU4UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gT24gVHVlLCBKdWwgNCwgMjAy
MyBhdCAxMTo0NeKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3Rl
Ogo+ID4gPiA+ID4KPiA+ID4gPiA+IE9uIFR1ZSwgSnVsIDA0LCAyMDIzIGF0IDAxOjM2OjExUE0g
KzAyMDAsIEV1Z2VuaW8gUGVyZXogTWFydGluIHdyb3RlOgo+ID4gPiA+ID4gPiBPbiBUdWUsIEp1
bCA0LCAyMDIzIGF0IDEyOjM44oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNv
bT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBPbiBUdWUsIEp1bCAwNCwgMjAy
MyBhdCAxMjoyNTozMlBNICswMjAwLCBFdWdlbmlvIFBlcmV6IE1hcnRpbiB3cm90ZToKPiA+ID4g
PiA+ID4gPiA+IE9uIE1vbiwgSnVsIDMsIDIwMjMgYXQgNDo1MuKAr1BNIE1pY2hhZWwgUy4gVHNp
cmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+ID4gPiBPbiBNb24sIEp1bCAwMywgMjAyMyBhdCAwNDoyMjoxOFBNICswMjAwLCBFdWdlbmlv
IFDDqXJleiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiBXaXRoIHRoZSBjdXJyZW50IGNvZGUg
aXQgaXMgYWNjZXB0ZWQgYXMgbG9uZyBhcyB1c2VybGFuZCBzZW5kIGl0Lgo+ID4gPiA+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gQWx0aG91Z2ggdXNlcmxhbmQgc2hvdWxkIG5vdCBz
ZXQgYSBmZWF0dXJlIGZsYWcgdGhhdCBoYXMgbm90IGJlZW4KPiA+ID4gPiA+ID4gPiA+ID4gPiBv
ZmZlcmVkIHRvIGl0IHdpdGggVkhPU1RfR0VUX0JBQ0tFTkRfRkVBVFVSRVMsIHRoZSBjdXJyZW50
IGNvZGUgd2lsbCBub3QKPiA+ID4gPiA+ID4gPiA+ID4gPiBjb21wbGFpbiBmb3IgaXQuCj4gPiA+
ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiBTaW5jZSB0aGVyZSBpcyBubyBzcGVj
aWZpYyByZWFzb24gZm9yIGFueSBwYXJlbnQgdG8gcmVqZWN0IHRoYXQgYmFja2VuZAo+ID4gPiA+
ID4gPiA+ID4gPiA+IGZlYXR1cmUgYml0IHdoZW4gaXQgaGFzIGJlZW4gcHJvcG9zZWQsIGxldCdz
IGNvbnRyb2wgaXQgYXQgdmRwYSBmcm9udGVuZAo+ID4gPiA+ID4gPiA+ID4gPiA+IGxldmVsLiBG
dXR1cmUgcGF0Y2hlcyBtYXkgbW92ZSB0aGlzIGNvbnRyb2wgdG8gdGhlIHBhcmVudCBkcml2ZXIu
Cj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiBGaXhlczogOTY3ODAwZDJk
NTJlICgidmRwYTogYWNjZXB0IFZIT1NUX0JBQ0tFTkRfRl9FTkFCTEVfQUZURVJfRFJJVkVSX09L
IGJhY2tlbmQgZmVhdHVyZSIpCj4gPiA+ID4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogRXVn
ZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+Cj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4gPiA+IFBsZWFzZSBkbyBzZW5kIHYzLiBBbmQgYWdhaW4sIEkgZG9uJ3Qgd2FudCB0
byBzZW5kICJhZnRlciBkcml2ZXIgb2siIGhhY2sKPiA+ID4gPiA+ID4gPiA+ID4gdXBzdHJlYW0g
YXQgYWxsLCBJIG1lcmdlZCBpdCBpbiBuZXh0IGp1c3QgdG8gZ2l2ZSBpdCBzb21lIHRlc3Rpbmcu
Cj4gPiA+ID4gPiA+ID4gPiA+IFdlIHdhbnQgUklOR19BQ0NFU1NfQUZURVJfS0lDSyBvciBzb21l
IHN1Y2guCj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4g
Q3VycmVudCBkZXZpY2VzIGRvIG5vdCBzdXBwb3J0IHRoYXQgc2VtYW50aWMuCj4gPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gPiBXaGljaCBkZXZpY2VzIHNwZWNpZmljYWxseSBhY2Nlc3MgdGhlIHJp
bmcgYWZ0ZXIgRFJJVkVSX09LIGJ1dCBiZWZvcmUKPiA+ID4gPiA+ID4gPiBhIGtpY2s/Cj4gPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gUHJldmlvdXMgdmVyc2lvbnMgb2YgdGhl
IFFFTVUgTE0gc2VyaWVzIGRpZCBhIHNwdXJpb3VzIGtpY2sgdG8gc3RhcnQKPiA+ID4gPiA+ID4g
dHJhZmZpYyBhdCB0aGUgTE0gZGVzdGluYXRpb24gWzFdLiBXaGVuIGl0IHdhcyBwcm9wb3NlZCwg
dGhhdCBzcHVyaW91cwo+ID4gPiA+ID4gPiBraWNrIHdhcyByZW1vdmVkIGZyb20gdGhlIHNlcmll
cyBiZWNhdXNlIHRvIGNoZWNrIGZvciBkZXNjcmlwdG9ycwo+ID4gPiA+ID4gPiBhZnRlciBkcml2
ZXJfb2ssIGV2ZW4gd2l0aG91dCBhIGtpY2ssIHdhcyBjb25zaWRlcmVkIHdvcmsgb2YgdGhlCj4g
PiA+ID4gPiA+IHBhcmVudCBkcml2ZXIuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IEknbSBvayB0
byBnbyBiYWNrIHRvIHRoaXMgc3B1cmlvdXMga2ljaywgYnV0IEknbSBub3Qgc3VyZSBpZiB0aGUg
aHcKPiA+ID4gPiA+ID4gd2lsbCByZWFkIHRoZSByaW5nIGJlZm9yZSB0aGUga2ljayBhY3R1YWxs
eS4gSSBjYW4gYXNrLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBUaGFua3MhCj4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+IFsxXSBodHRwczovL2xpc3RzLm5vbmdudS5vcmcvYXJjaGl2ZS9odG1sL3Fl
bXUtZGV2ZWwvMjAyMy0wMS9tc2cwMjc3NS5odG1sCj4gPiA+ID4gPgo+ID4gPiA+ID4gTGV0J3Mg
ZmluZCBvdXQuIFdlIG5lZWQgdG8gY2hlY2sgZm9yIEVOQUJMRV9BRlRFUl9EUklWRVJfT0sgdG9v
LCBubz8KPiA+ID4gPgo+ID4gPiA+IE15IHVuZGVyc3RhbmRpbmcgaXMgWzFdIGFzc3VtaW5nIEFD
Q0VTU19BRlRFUl9LSUNLLiBUaGlzIHNlZW1zCj4gPiA+ID4gc3ViLW9wdGltYWwgdGhhbiBhc3N1
bWluZyBFTkFCTEVfQUZURVJfRFJJVkVSX09LLgo+ID4gPiA+Cj4gPiA+ID4gQnV0IHRoaXMgcmVt
aW5kcyBtZSBvbmUgdGhpbmcsIGFzIHRoZSB0aHJlYWQgaXMgZ29pbmcgdG9vIGxvbmcsIEkKPiA+
ID4gPiB3b25kZXIgaWYgd2Ugc2ltcGx5IGFzc3VtZSBFTkFCTEVfQUZURVJfRFJJVkVSX09LIGlm
IFJJTkdfUkVTRVQgaXMKPiA+ID4gPiBzdXBwb3J0ZWQ/Cj4gPiA+ID4KPiA+ID4gPiBUaGFua3MK
PiA+ID4KPiA+ID4gSSBkb24ndCBzZWUgd2hhdCBkb2VzIG9uZSBoYXZlIHRvIGRvIHdpdGggYW5v
dGhlciAuLi4KPiA+ID4KPiA+ID4gSSB0aGluayB3aXRoIFJJTkdfUkVTRVQgd2UgaGFkIGFub3Ro
ZXIgc29sdXRpb24sIGVuYWJsZSByaW5ncwo+ID4gPiBtYXBwaW5nIHRoZW0gdG8gYSB6ZXJvIHBh
Z2UsIHRoZW4gcmVzZXQgYW5kIHJlLWVuYWJsZSBsYXRlci4KPiA+Cj4gPiBBcyBkaXNjdXNzZWQg
YmVmb3JlLCB0aGlzIHNlZW1zIHRvIGhhdmUgc29tZSBwcm9ibGVtczoKPiA+Cj4gPiAxKSBUaGUg
YmVoYXZpb3VyIGlzIG5vdCBjbGFyaWZpZWQgaW4gdGhlIGRvY3VtZW50Cj4gPiAyKSB6ZXJvIGlz
IGEgdmFsaWQgSU9WQQo+ID4KPgo+IEkgdGhpbmsgd2UncmUgbm90IG9uIHRoZSBzYW1lIHBhZ2Ug
aGVyZS4KPgo+IEFzIEkgdW5kZXJzdG9vZCwgcmluZ3MgbWFwcGVkIHRvIGEgemVybyBwYWdlIG1l
YW5zIGVzc2VudGlhbGx5IGFuCj4gYXZhaWwgcmluZyB3aG9zZSBhdmFpbF9pZHggaXMgYWx3YXlz
IDAsIG9mZmVyZWQgdG8gdGhlIGRldmljZSBpbnN0ZWFkCj4gb2YgdGhlIGd1ZXN0J3MgcmluZy4g
T25jZSBhbGwgQ1ZRIGNvbW1hbmRzIGFyZSBwcm9jZXNzZWQsIHdlIHVzZQo+IFJJTkdfUkVTRVQg
dG8gc3dpdGNoIHRvIHRoZSByaWdodCByaW5nLCBiZWluZyBndWVzdCdzIG9yIFNWUSB2cmluZy4K
CkkgZ2V0IHRoaXMuIFRoaXMgc2VlbXMgbW9yZSBjb21wbGljYXRlZCBpbiB0aGUgZGVzdGluYXRp
b246IHNoYWRvdyB2cSArIEFTSUQ/CgpUaGFua3MKCj4KPgo+Cj4gPiBUaGFua3MKPiA+Cj4gPiA+
Cj4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBNeSBwbGFuIHdh
cyB0byBjb252ZXJ0Cj4gPiA+ID4gPiA+ID4gPiBpdCBpbiB2cF92ZHBhIGlmIG5lZWRlZCwgYW5k
IHJldXNlIHRoZSBjdXJyZW50IHZkcGEgb3BzLiBTb3JyeSBpZiBJCj4gPiA+ID4gPiA+ID4gPiB3
YXMgbm90IGV4cGxpY2l0IGVub3VnaC4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBU
aGUgb25seSBzb2x1dGlvbiBJIGNhbiBzZWUgdG8gdGhhdCBpcyB0byB0cmFwICYgZW11bGF0ZSBp
biB0aGUgdmRwYQo+ID4gPiA+ID4gPiA+ID4gKHBhcmVudD8pIGRyaXZlciwgYXMgdGFsa2VkIGlu
IHZpcnRpby1jb21tZW50LiBCdXQgdGhhdCBjb21wbGljYXRlcwo+ID4gPiA+ID4gPiA+ID4gdGhl
IGFyY2hpdGVjdHVyZToKPiA+ID4gPiA+ID4gPiA+ICogT2ZmZXIgVkhPU1RfQkFDS0VORF9GX1JJ
TkdfQUNDRVNTX0FGVEVSX0tJQ0sKPiA+ID4gPiA+ID4gPiA+ICogU3RvcmUgdnEgZW5hYmxlIHN0
YXRlIHNlcGFyYXRlbHksIGF0Cj4gPiA+ID4gPiA+ID4gPiB2ZHBhLT5jb25maWctPnNldF92cV9y
ZWFkeSh0cnVlKSwgYnV0IG5vdCB0cmFuc21pdCB0aGF0IGVuYWJsZSB0byBodwo+ID4gPiA+ID4g
PiA+ID4gKiBTdG9yZSB0aGUgZG9vcmJlbGwgc3RhdGUgc2VwYXJhdGVseSwgYnV0IGRvIG5vdCBj
b25maWd1cmUgaXQgdG8gdGhlCj4gPiA+ID4gPiA+ID4gPiBkZXZpY2UgZGlyZWN0bHkuCj4gPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gQnV0IGhvdyB0byByZWNvdmVyIGlmIHRoZSBkZXZp
Y2UgY2Fubm90IGNvbmZpZ3VyZSB0aGVtIGF0IGtpY2sgdGltZSwKPiA+ID4gPiA+ID4gPiA+IGZv
ciBleGFtcGxlPwo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IE1heWJlIHdlIGNhbiBq
dXN0IGZhaWwgaWYgdGhlIHBhcmVudCBkcml2ZXIgZG9lcyBub3Qgc3VwcG9ydCBlbmFibGluZwo+
ID4gPiA+ID4gPiA+ID4gdGhlIHZxIGFmdGVyIERSSVZFUl9PSz8gVGhhdCB3YXkgbm8gbmV3IGZl
YXR1cmUgZmxhZyBpcyBuZWVkZWQuCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gVGhh
bmtzIQo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4g
PiAtLS0KPiA+ID4gPiA+ID4gPiA+ID4gPiBTZW50IHdpdGggRml4ZXM6IHRhZyBwb2ludGluZyB0
byBnaXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbXN0Cj4gPiA+ID4gPiA+
ID4gPiA+ID4gY29tbWl0LiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgSSBzaG91bGQgc2VuZCBhIHYz
IG9mIFsxXSBpbnN0ZWFkLgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4g
WzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMzA2MDkxMjEyNDQtbXV0dC1zZW5k
LWVtYWlsLW1zdEBrZXJuZWwub3JnL1QvCj4gPiA+ID4gPiA+ID4gPiA+ID4gLS0tCj4gPiA+ID4g
PiA+ID4gPiA+ID4gIGRyaXZlcnMvdmhvc3QvdmRwYS5jIHwgNyArKysrKy0tCj4gPiA+ID4gPiA+
ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
Cj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ID4gPiA+ID4gPiA+ID4g
PiA+IGluZGV4IGUxYWJmMjlmZWQ1Yi4uYTdlNTU0MzUyMzUxIDEwMDY0NAo+ID4gPiA+ID4gPiA+
ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gPiA+ID4gPiA+ID4gPiA+ID4gKysr
IGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiA+ID4gPiA+ID4gPiA+ID4gPiBAQCAtNjgxLDE4ICs2
ODEsMjEgQEAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV91bmxvY2tlZF9pb2N0bChzdHJ1Y3QgZmls
ZSAqZmlsZXAsCj4gPiA+ID4gPiA+ID4gPiA+ID4gIHsKPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAg
ICBzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiA9IGZpbGVwLT5wcml2YXRlX2RhdGE7Cj4gPiA+ID4gPiA+
ID4gPiA+ID4gICAgICAgc3RydWN0IHZob3N0X2RldiAqZCA9ICZ2LT52ZGV2Owo+ID4gPiA+ID4g
PiA+ID4gPiA+ICsgICAgIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHYtPnZk
cGEtPmNvbmZpZzsKPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAgICB2b2lkIF9fdXNlciAqYXJncCA9
ICh2b2lkIF9fdXNlciAqKWFyZzsKPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAgICB1NjQgX191c2Vy
ICpmZWF0dXJlcCA9IGFyZ3A7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gLSAgICAgdTY0IGZlYXR1cmVz
Owo+ID4gPiA+ID4gPiA+ID4gPiA+ICsgICAgIHU2NCBmZWF0dXJlcywgcGFyZW50X2ZlYXR1cmVz
ID0gMDsKPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAgICBsb25nIHIgPSAwOwo+ID4gPiA+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgaWYgKGNtZCA9PSBWSE9TVF9TRVRfQkFD
S0VORF9GRUFUVVJFUykgewo+ID4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgaWYgKGNv
cHlfZnJvbV91c2VyKCZmZWF0dXJlcywgZmVhdHVyZXAsIHNpemVvZihmZWF0dXJlcykpKQo+ID4g
PiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVGQVVMVDsKPiA+
ID4gPiA+ID4gPiA+ID4gPiArICAgICAgICAgICAgIGlmIChvcHMtPmdldF9iYWNrZW5kX2ZlYXR1
cmVzKQo+ID4gPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICBwYXJlbnRfZmVh
dHVyZXMgPSBvcHMtPmdldF9iYWNrZW5kX2ZlYXR1cmVzKHYtPnZkcGEpOwo+ID4gPiA+ID4gPiA+
ID4gPiA+ICAgICAgICAgICAgICAgaWYgKGZlYXR1cmVzICYgfihWSE9TVF9WRFBBX0JBQ0tFTkRf
RkVBVFVSRVMgfAo+ID4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9TVVNQRU5EKSB8Cj4gPiA+ID4gPiA+ID4gPiA+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9G
X1JFU1VNRSkgfAo+ID4gPiA+ID4gPiA+ID4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9FTkFCTEVfQUZURVJfRFJJVkVSX09LKSkpCj4g
PiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBhcmVudF9m
ZWF0dXJlcykpCj4gPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgIHJldHVy
biAtRU9QTk9UU1VQUDsKPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgIGlmICgoZmVh
dHVyZXMgJiBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9TVVNQRU5EKSkgJiYKPiA+ID4gPiA+ID4g
PiA+ID4gPiAgICAgICAgICAgICAgICAgICAgIXZob3N0X3ZkcGFfY2FuX3N1c3BlbmQodikpCj4g
PiA+ID4gPiA+ID4gPiA+ID4gLS0KPiA+ID4gPiA+ID4gPiA+ID4gPiAyLjM5LjMKPiA+ID4gPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4KPiA+Cj4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
