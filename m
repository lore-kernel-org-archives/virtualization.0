Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C976EB64D9
	for <virtualization@archiver.kernel.org>; Thu,  6 Jul 2023 06:07:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4427D81423;
	Thu,  6 Jul 2023 06:07:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4427D81423
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M79slbfz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rYz7iq2BK4DF; Thu,  6 Jul 2023 06:07:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4146581414;
	Thu,  6 Jul 2023 06:07:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4146581414
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15813C0072;
	Thu,  6 Jul 2023 06:07:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E01D6C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 06:07:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AD55E60AD5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 06:07:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AD55E60AD5
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=M79slbfz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rZg8h2UlVjLY
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 06:07:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 493AA60AAA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 493AA60AAA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 06:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688623651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QO+V26UGI/WBMUGqFJ+p6LZkGHrVbYJRVlupGwNTzEQ=;
 b=M79slbfzMXV71sVGSmMkNc3ahm3eteV+Si+hgeZXkHD9Y0kFioDMPdIU52S8K01L+TyQ+V
 Mj1zrLDkXO0yDyRbK6Hhlt73O8RZcIF70lBQXUVIVOLkzgz99lQMMMszwI2MxVMtEIQW+Y
 2mwLw4TpCfZVTUXnRRf8vcICiE2W5UE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-1LzyGobxM-WIlYUsKKfAKA-1; Thu, 06 Jul 2023 02:07:27 -0400
X-MC-Unique: 1LzyGobxM-WIlYUsKKfAKA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30e3ee8a42eso148262f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Jul 2023 23:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688623646; x=1691215646;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QO+V26UGI/WBMUGqFJ+p6LZkGHrVbYJRVlupGwNTzEQ=;
 b=ZboFV7Si10QKT/V0NrDzNYMnX5MvOJoTbuT+vJoUIwmpkKSCzxH8XD4u8FyTVIKwCl
 Z3X8DaImdWeVqOg//gWFozQxoVhuibSefvDc1UoZP2fEqy8DSwYEehsknCGohWeQ3UtT
 8SO4mfplJJk9htCCpdnUPVyX98iQxnel9yykShpOvmhMBhdngqdi5i/uYVOwJqXRTIIh
 zxlqLDHTBibuvgOo+KsoHoMIoXTck2Tu4X7DEVs2gljDENnCMbjM85sqhWTrHWaKnn69
 xGjEshTeguOGR5AI8G2R5jku62eY36lmFgliPkQ7ZJ43UdlzTgpJ4TOHqkKfhz9iWFSq
 DQ3w==
X-Gm-Message-State: ABy/qLaqFZLfISO6n7g62wcdDjFzKZkhawvQmXWO37OZyGJp2MaUB5Tq
 LkpcR1aTEaNZGYjZbtXU1SpOaHjPuwZ+rpprAWwt7ABjHBlOiQJikvyprkB/4UR7q74VTLekqUs
 C8H4x8r+w1igtUimGoCqMRBbMsga7n55V4GiD+9dcAg==
X-Received: by 2002:a5d:4a92:0:b0:314:1230:29b0 with SMTP id
 o18-20020a5d4a92000000b00314123029b0mr590417wrq.52.1688623646690; 
 Wed, 05 Jul 2023 23:07:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHrDUg7w0Am2K8eApMnGUTNaSK+AtEqMa/Nhk+0S8Dvv6TeSL3nnknCHe+T2JWv5yai8Yzccg==
X-Received: by 2002:a5d:4a92:0:b0:314:1230:29b0 with SMTP id
 o18-20020a5d4a92000000b00314123029b0mr590400wrq.52.1688623646344; 
 Wed, 05 Jul 2023 23:07:26 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e5:9a00:6cb0:ad0c:4846:6126])
 by smtp.gmail.com with ESMTPSA id
 q9-20020adff789000000b00313e2abfb8dsm873455wrp.92.2023.07.05.23.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 23:07:25 -0700 (PDT)
Date: Thu, 6 Jul 2023 02:07:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Subject: Re: [PATCH] vdpa: reject F_ENABLE_AFTER_DRIVER_OK if backend does
 not support it
Message-ID: <20230706020603-mutt-send-email-mst@kernel.org>
References: <20230703142218.362549-1-eperezma@redhat.com>
 <20230703105022-mutt-send-email-mst@kernel.org>
 <CAJaqyWf2F_yBLBjj1RiPeJ92_zfq8BSMz8Pak2Vg6QinN8jS1Q@mail.gmail.com>
 <20230704063646-mutt-send-email-mst@kernel.org>
 <CAJaqyWfdPpkD5pY4tfzQdOscLBcrDBhBqzWjMbY_ZKsoyiqGdA@mail.gmail.com>
 <20230704114159-mutt-send-email-mst@kernel.org>
 <CACGkMEtWjOMtsbgQ2sx=e1BkuRSyDmVfXDccCm-QSiSbacQyCA@mail.gmail.com>
 <CAJaqyWd0QC6x9WHBT0x9beZyC8ZrF2y=d9HvmT0+05RtGc8_og@mail.gmail.com>
 <eff34828-545b-956b-f400-89b585706fe4@amd.com>
MIME-Version: 1.0
In-Reply-To: <eff34828-545b-956b-f400-89b585706fe4@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Eugenio Perez Martin <eperezma@redhat.com>
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

T24gV2VkLCBKdWwgMDUsIDIwMjMgYXQgMDU6MDc6MTFQTSAtMDcwMCwgU2hhbm5vbiBOZWxzb24g
d3JvdGU6Cj4gT24gNy81LzIzIDExOjI3IEFNLCBFdWdlbmlvIFBlcmV6IE1hcnRpbiB3cm90ZToK
PiA+Cj4gPiBPbiBXZWQsIEp1bCA1LCAyMDIzIGF0IDk6NTDigK9BTSBKYXNvbiBXYW5nIDxqYXNv
d2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gCj4gPiA+IE9uIFR1ZSwgSnVsIDQsIDIwMjMg
YXQgMTE6NDXigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToK
PiA+ID4gPiAKPiA+ID4gPiBPbiBUdWUsIEp1bCAwNCwgMjAyMyBhdCAwMTozNjoxMVBNICswMjAw
LCBFdWdlbmlvIFBlcmV6IE1hcnRpbiB3cm90ZToKPiA+ID4gPiA+IE9uIFR1ZSwgSnVsIDQsIDIw
MjMgYXQgMTI6MzjigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90
ZToKPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IE9uIFR1ZSwgSnVsIDA0LCAyMDIzIGF0IDEyOjI1
OjMyUE0gKzAyMDAsIEV1Z2VuaW8gUGVyZXogTWFydGluIHdyb3RlOgo+ID4gPiA+ID4gPiA+IE9u
IE1vbiwgSnVsIDMsIDIwMjMgYXQgNDo1MuKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJl
ZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiBPbiBNb24s
IEp1bCAwMywgMjAyMyBhdCAwNDoyMjoxOFBNICswMjAwLCBFdWdlbmlvIFDDqXJleiB3cm90ZToK
PiA+ID4gPiA+ID4gPiA+ID4gV2l0aCB0aGUgY3VycmVudCBjb2RlIGl0IGlzIGFjY2VwdGVkIGFz
IGxvbmcgYXMgdXNlcmxhbmQgc2VuZCBpdC4KPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+
ID4gPiA+IEFsdGhvdWdoIHVzZXJsYW5kIHNob3VsZCBub3Qgc2V0IGEgZmVhdHVyZSBmbGFnIHRo
YXQgaGFzIG5vdCBiZWVuCj4gPiA+ID4gPiA+ID4gPiA+IG9mZmVyZWQgdG8gaXQgd2l0aCBWSE9T
VF9HRVRfQkFDS0VORF9GRUFUVVJFUywgdGhlIGN1cnJlbnQgY29kZSB3aWxsIG5vdAo+ID4gPiA+
ID4gPiA+ID4gPiBjb21wbGFpbiBmb3IgaXQuCj4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4g
PiA+ID4gPiBTaW5jZSB0aGVyZSBpcyBubyBzcGVjaWZpYyByZWFzb24gZm9yIGFueSBwYXJlbnQg
dG8gcmVqZWN0IHRoYXQgYmFja2VuZAo+ID4gPiA+ID4gPiA+ID4gPiBmZWF0dXJlIGJpdCB3aGVu
IGl0IGhhcyBiZWVuIHByb3Bvc2VkLCBsZXQncyBjb250cm9sIGl0IGF0IHZkcGEgZnJvbnRlbmQK
PiA+ID4gPiA+ID4gPiA+ID4gbGV2ZWwuIEZ1dHVyZSBwYXRjaGVzIG1heSBtb3ZlIHRoaXMgY29u
dHJvbCB0byB0aGUgcGFyZW50IGRyaXZlci4KPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+
ID4gPiA+IEZpeGVzOiA5Njc4MDBkMmQ1MmUgKCJ2ZHBhOiBhY2NlcHQgVkhPU1RfQkFDS0VORF9G
X0VOQUJMRV9BRlRFUl9EUklWRVJfT0sgYmFja2VuZCBmZWF0dXJlIikKPiA+ID4gPiA+ID4gPiA+
ID4gU2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+Cj4g
PiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+IFBsZWFzZSBkbyBzZW5kIHYzLiBBbmQgYWdh
aW4sIEkgZG9uJ3Qgd2FudCB0byBzZW5kICJhZnRlciBkcml2ZXIgb2siIGhhY2sKPiA+ID4gPiA+
ID4gPiA+IHVwc3RyZWFtIGF0IGFsbCwgSSBtZXJnZWQgaXQgaW4gbmV4dCBqdXN0IHRvIGdpdmUg
aXQgc29tZSB0ZXN0aW5nLgo+ID4gPiA+ID4gPiA+ID4gV2Ugd2FudCBSSU5HX0FDQ0VTU19BRlRF
Ul9LSUNLIG9yIHNvbWUgc3VjaC4KPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+IAo+ID4g
PiA+ID4gPiA+IEN1cnJlbnQgZGV2aWNlcyBkbyBub3Qgc3VwcG9ydCB0aGF0IHNlbWFudGljLgo+
ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gV2hpY2ggZGV2aWNlcyBzcGVjaWZpY2FsbHkgYWNjZXNz
IHRoZSByaW5nIGFmdGVyIERSSVZFUl9PSyBidXQgYmVmb3JlCj4gPiA+ID4gPiA+IGEga2ljaz8K
PiAKPiBUaGUgUERTIHZkcGEgZGV2aWNlIGNhbiBkZWFsIHdpdGggYSBjYWxsIHRvIC5zZXRfdnFf
cmVhZHkgYWZ0ZXIgRFJJVkVSX09LIGlzCj4gc2V0LiAgQW5kIEknbSB0b2xkIHRoYXQgb3VyIFZR
IGFjdGl2aXR5IHNob3VsZCBzdGFydCB3aXRob3V0IGEga2ljay4KPiAKPiBPdXIgdmRwYSBkZXZp
Y2UgRlcgZG9lc24ndCBjdXJyZW50bHkgaGF2ZSBzdXBwb3J0IGZvciBWSVJUSU9fRl9SSU5HX1JF
U0VULAo+IGJ1dCBJIGJlbGlldmUgaXQgY291bGQgYmUgYWRkZWQgd2l0aG91dCB0b28gbXVjaCB0
cm91YmxlLgo+IAo+IHNsbgo+IAoKT0sgaXQgc2VlbXMgY2xlYXIgYXQgbGVhc3QgaW4gdGhlIGN1
cnJlbnQgdmVyc2lvbiBwZHMgbmVlZHMKVkhPU1RfQkFDS0VORF9GX0VOQUJMRV9BRlRFUl9EUklW
RVJfT0suCkhvd2V2ZXIgY2FuIHdlIGFsc28gY29kZSB1cCB0aGUgUklOR19SRVNFVCBwYXRoIGFz
IHRoZSBkZWZhdWx0PwpUaGVuIGRvd24gdGhlIHJvYWQgdmVuZG9ycyBjYW4gY2hvb3NlIHdoYXQg
dG8gZG8uCgoKCgoKPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiAKPiA+ID4gPiA+IFByZXZpb3VzIHZl
cnNpb25zIG9mIHRoZSBRRU1VIExNIHNlcmllcyBkaWQgYSBzcHVyaW91cyBraWNrIHRvIHN0YXJ0
Cj4gPiA+ID4gPiB0cmFmZmljIGF0IHRoZSBMTSBkZXN0aW5hdGlvbiBbMV0uIFdoZW4gaXQgd2Fz
IHByb3Bvc2VkLCB0aGF0IHNwdXJpb3VzCj4gPiA+ID4gPiBraWNrIHdhcyByZW1vdmVkIGZyb20g
dGhlIHNlcmllcyBiZWNhdXNlIHRvIGNoZWNrIGZvciBkZXNjcmlwdG9ycwo+ID4gPiA+ID4gYWZ0
ZXIgZHJpdmVyX29rLCBldmVuIHdpdGhvdXQgYSBraWNrLCB3YXMgY29uc2lkZXJlZCB3b3JrIG9m
IHRoZQo+ID4gPiA+ID4gcGFyZW50IGRyaXZlci4KPiA+ID4gPiA+IAo+ID4gPiA+ID4gSSdtIG9r
IHRvIGdvIGJhY2sgdG8gdGhpcyBzcHVyaW91cyBraWNrLCBidXQgSSdtIG5vdCBzdXJlIGlmIHRo
ZSBodwo+ID4gPiA+ID4gd2lsbCByZWFkIHRoZSByaW5nIGJlZm9yZSB0aGUga2ljayBhY3R1YWxs
eS4gSSBjYW4gYXNrLgo+ID4gPiA+ID4gCj4gPiA+ID4gPiBUaGFua3MhCj4gPiA+ID4gPiAKPiA+
ID4gPiA+IFsxXSBodHRwczovL2xpc3RzLm5vbmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2
ZWwvMjAyMy0wMS9tc2cwMjc3NS5odG1sCj4gPiA+ID4gCj4gPiA+ID4gTGV0J3MgZmluZCBvdXQu
IFdlIG5lZWQgdG8gY2hlY2sgZm9yIEVOQUJMRV9BRlRFUl9EUklWRVJfT0sgdG9vLCBubz8KPiA+
ID4gCj4gPiA+IE15IHVuZGVyc3RhbmRpbmcgaXMgWzFdIGFzc3VtaW5nIEFDQ0VTU19BRlRFUl9L
SUNLLiBUaGlzIHNlZW1zCj4gPiA+IHN1Yi1vcHRpbWFsIHRoYW4gYXNzdW1pbmcgRU5BQkxFX0FG
VEVSX0RSSVZFUl9PSy4KPiA+ID4gCj4gPiA+IEJ1dCB0aGlzIHJlbWluZHMgbWUgb25lIHRoaW5n
LCBhcyB0aGUgdGhyZWFkIGlzIGdvaW5nIHRvbyBsb25nLCBJCj4gPiA+IHdvbmRlciBpZiB3ZSBz
aW1wbHkgYXNzdW1lIEVOQUJMRV9BRlRFUl9EUklWRVJfT0sgaWYgUklOR19SRVNFVCBpcwo+ID4g
PiBzdXBwb3J0ZWQ/Cj4gPiA+IAo+ID4gCj4gPiBUaGUgcHJvYmxlbSB3aXRoIHRoYXQgaXMgdGhh
dCB0aGUgZGV2aWNlIG5lZWRzIHRvIHN1cHBvcnQgYWxsCj4gPiBSSU5HX1JFU0VULCBsaWtlIHRv
IGJlIGFibGUgdG8gY2hhbmdlIHZxIGFkZHJlc3MgZXRjIGFmdGVyIERSSVZFUl9PSy4KPiA+IE5v
dCBhbGwgSFcgc3VwcG9ydCBpdC4KPiA+IAo+ID4gV2UganVzdCBuZWVkIHRoZSBzdWJzZXQgb2Yg
aGF2aW5nIHRoZSBkYXRhcGxhbmUgZnJlZXplZCB1bnRpbCBhbGwgQ1ZRCj4gPiBjb21tYW5kcyBo
YXZlIGJlZW4gY29uc3VtZWQuIEknbSBzdXJlIGN1cnJlbnQgdkRQQSBjb2RlIGFscmVhZHkKPiA+
IHN1cHBvcnRzIGl0IGluIHNvbWUgZGV2aWNlcywgbGlrZSBNTFggYW5kIFBTRC4KPiA+IAo+ID4g
VGhhbmtzIQo+ID4gCj4gPiA+IFRoYW5rcwo+ID4gPiAKPiA+ID4gPiAKPiA+ID4gPiAKPiA+ID4g
PiAKPiA+ID4gPiA+ID4gPiBNeSBwbGFuIHdhcyB0byBjb252ZXJ0Cj4gPiA+ID4gPiA+ID4gaXQg
aW4gdnBfdmRwYSBpZiBuZWVkZWQsIGFuZCByZXVzZSB0aGUgY3VycmVudCB2ZHBhIG9wcy4gU29y
cnkgaWYgSQo+ID4gPiA+ID4gPiA+IHdhcyBub3QgZXhwbGljaXQgZW5vdWdoLgo+ID4gPiA+ID4g
PiA+IAo+ID4gPiA+ID4gPiA+IFRoZSBvbmx5IHNvbHV0aW9uIEkgY2FuIHNlZSB0byB0aGF0IGlz
IHRvIHRyYXAgJiBlbXVsYXRlIGluIHRoZSB2ZHBhCj4gPiA+ID4gPiA+ID4gKHBhcmVudD8pIGRy
aXZlciwgYXMgdGFsa2VkIGluIHZpcnRpby1jb21tZW50LiBCdXQgdGhhdCBjb21wbGljYXRlcwo+
ID4gPiA+ID4gPiA+IHRoZSBhcmNoaXRlY3R1cmU6Cj4gPiA+ID4gPiA+ID4gKiBPZmZlciBWSE9T
VF9CQUNLRU5EX0ZfUklOR19BQ0NFU1NfQUZURVJfS0lDSwo+ID4gPiA+ID4gPiA+ICogU3RvcmUg
dnEgZW5hYmxlIHN0YXRlIHNlcGFyYXRlbHksIGF0Cj4gPiA+ID4gPiA+ID4gdmRwYS0+Y29uZmln
LT5zZXRfdnFfcmVhZHkodHJ1ZSksIGJ1dCBub3QgdHJhbnNtaXQgdGhhdCBlbmFibGUgdG8gaHcK
PiA+ID4gPiA+ID4gPiAqIFN0b3JlIHRoZSBkb29yYmVsbCBzdGF0ZSBzZXBhcmF0ZWx5LCBidXQg
ZG8gbm90IGNvbmZpZ3VyZSBpdCB0byB0aGUKPiA+ID4gPiA+ID4gPiBkZXZpY2UgZGlyZWN0bHku
Cj4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gQnV0IGhvdyB0byByZWNvdmVyIGlmIHRoZSBk
ZXZpY2UgY2Fubm90IGNvbmZpZ3VyZSB0aGVtIGF0IGtpY2sgdGltZSwKPiA+ID4gPiA+ID4gPiBm
b3IgZXhhbXBsZT8KPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiBNYXliZSB3ZSBjYW4ganVz
dCBmYWlsIGlmIHRoZSBwYXJlbnQgZHJpdmVyIGRvZXMgbm90IHN1cHBvcnQgZW5hYmxpbmcKPiA+
ID4gPiA+ID4gPiB0aGUgdnEgYWZ0ZXIgRFJJVkVSX09LPyBUaGF0IHdheSBubyBuZXcgZmVhdHVy
ZSBmbGFnIGlzIG5lZWRlZC4KPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiBUaGFua3MhCj4g
PiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gLS0tCj4gPiA+
ID4gPiA+ID4gPiA+IFNlbnQgd2l0aCBGaXhlczogdGFnIHBvaW50aW5nIHRvIGdpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9tc3QKPiA+ID4gPiA+ID4gPiA+ID4gY29tbWl0
LiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgSSBzaG91bGQgc2VuZCBhIHYzIG9mIFsxXSBpbnN0ZWFk
Lgo+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gWzFdIGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xrbWwvMjAyMzA2MDkxMjEyNDQtbXV0dC1zZW5kLWVtYWlsLW1zdEBrZXJuZWwu
b3JnL1QvCj4gPiA+ID4gPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4gPiA+ID4gPiAgIGRyaXZlcnMv
dmhvc3QvdmRwYS5jIHwgNyArKysrKy0tCj4gPiA+ID4gPiA+ID4gPiA+ICAgMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiA+ID4gPiA+ID4gPiA+ID4gCj4g
PiA+ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZl
cnMvdmhvc3QvdmRwYS5jCj4gPiA+ID4gPiA+ID4gPiA+IGluZGV4IGUxYWJmMjlmZWQ1Yi4uYTdl
NTU0MzUyMzUxIDEwMDY0NAo+ID4gPiA+ID4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3Zk
cGEuYwo+ID4gPiA+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ID4gPiA+
ID4gPiA+ID4gPiBAQCAtNjgxLDE4ICs2ODEsMjEgQEAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV91
bmxvY2tlZF9pb2N0bChzdHJ1Y3QgZmlsZSAqZmlsZXAsCj4gPiA+ID4gPiA+ID4gPiA+ICAgewo+
ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgc3RydWN0IHZob3N0X3ZkcGEgKnYgPSBmaWxlcC0+cHJp
dmF0ZV9kYXRhOwo+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgc3RydWN0IHZob3N0X2RldiAqZCA9
ICZ2LT52ZGV2Owo+ID4gPiA+ID4gPiA+ID4gPiArICAgICBjb25zdCBzdHJ1Y3QgdmRwYV9jb25m
aWdfb3BzICpvcHMgPSB2LT52ZHBhLT5jb25maWc7Cj4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICB2
b2lkIF9fdXNlciAqYXJncCA9ICh2b2lkIF9fdXNlciAqKWFyZzsKPiA+ID4gPiA+ID4gPiA+ID4g
ICAgICAgIHU2NCBfX3VzZXIgKmZlYXR1cmVwID0gYXJncDsKPiA+ID4gPiA+ID4gPiA+ID4gLSAg
ICAgdTY0IGZlYXR1cmVzOwo+ID4gPiA+ID4gPiA+ID4gPiArICAgICB1NjQgZmVhdHVyZXMsIHBh
cmVudF9mZWF0dXJlcyA9IDA7Cj4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICBsb25nIHIgPSAwOwo+
ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgIGlmIChjbWQgPT0gVkhP
U1RfU0VUX0JBQ0tFTkRfRkVBVFVSRVMpIHsKPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAg
ICAgaWYgKGNvcHlfZnJvbV91c2VyKCZmZWF0dXJlcywgZmVhdHVyZXAsIHNpemVvZihmZWF0dXJl
cykpKQo+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUZB
VUxUOwo+ID4gPiA+ID4gPiA+ID4gPiArICAgICAgICAgICAgIGlmIChvcHMtPmdldF9iYWNrZW5k
X2ZlYXR1cmVzKQo+ID4gPiA+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgcGFyZW50
X2ZlYXR1cmVzID0gb3BzLT5nZXRfYmFja2VuZF9mZWF0dXJlcyh2LT52ZHBhKTsKPiA+ID4gPiA+
ID4gPiA+ID4gICAgICAgICAgICAgICAgaWYgKGZlYXR1cmVzICYgfihWSE9TVF9WRFBBX0JBQ0tF
TkRfRkVBVFVSRVMgfAo+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX1NVU1BFTkQpIHwKPiA+ID4gPiA+ID4gPiA+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRf
Rl9SRVNVTUUpIHwKPiA+ID4gPiA+ID4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX0VOQUJMRV9BRlRFUl9EUklWRVJfT0spKSkKPiA+
ID4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBhcmVudF9mZWF0
dXJlcykpCj4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1F
T1BOT1RTVVBQOwo+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICBpZiAoKGZlYXR1cmVz
ICYgQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfU1VTUEVORCkpICYmCj4gPiA+ID4gPiA+ID4gPiA+
ICAgICAgICAgICAgICAgICAgICAgIXZob3N0X3ZkcGFfY2FuX3N1c3BlbmQodikpCj4gPiA+ID4g
PiA+ID4gPiA+IC0tCj4gPiA+ID4gPiA+ID4gPiA+IDIuMzkuMwo+ID4gPiA+ID4gPiA+ID4gCj4g
PiA+ID4gPiA+IAo+ID4gPiA+IAo+ID4gPiAKPiA+IAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
