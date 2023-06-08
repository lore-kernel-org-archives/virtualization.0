Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B85BC7EE2E
	for <virtualization@archiver.kernel.org>; Thu,  8 Jun 2023 06:03:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C40A24092F;
	Thu,  8 Jun 2023 06:03:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C40A24092F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i38lHIpr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PtRhmgAdqNYA; Thu,  8 Jun 2023 06:03:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9C7B04067C;
	Thu,  8 Jun 2023 06:03:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9C7B04067C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60309C0037;
	Thu,  8 Jun 2023 06:03:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD7CEC0029
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 06:03:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 96A984067C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 06:03:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 96A984067C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id anQhdiuhFV4g
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 06:03:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E971D40512
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E971D40512
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 06:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686204206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LUP1t8+/wdVLK6VBS33/A2HY/mNmkYzUjFS3Usth32g=;
 b=i38lHIpryor6+hdC77nf3Sp8OsJ1RSw0Bl/QulNMo0ZwaSYXp5+aa5qllI9upYKwjlOkAr
 fXlswrMJXrPDdlbxs934UXfwX+k8Rb4w76tkakarWvsPXvnnXum54PPaT0i4lT9aE+u9XL
 NO/tEZ3xSbTITrl8+W4r8zuifgbblks=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-H2ZjM8aYOzqRc24dqS0kjg-1; Thu, 08 Jun 2023 02:03:25 -0400
X-MC-Unique: H2ZjM8aYOzqRc24dqS0kjg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3079c6648e3so148726f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Jun 2023 23:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686204204; x=1688796204;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LUP1t8+/wdVLK6VBS33/A2HY/mNmkYzUjFS3Usth32g=;
 b=HRdkAiGD8lkWfoDZsUx9+Z0uvDSie0ISawB5xW6KSugZ0S0tRBjcoczd+jWVosZH9r
 ovRgMOY8PVEGIJEGigM351js5k2Sg+zEeCfSMeIcoHn3qbt0l5CqNEaEKmunD6fQqeHP
 jkb/m5+67lykIZh3WZw2q2Y/EY9r7s1GivR8JXgNOHmjK3281uOCoGlOnFdMDtibGYzp
 Yee2jmkFeoaI8ToSmFbnoGpk0XFFbe34//GPfxulKPiOMkyTKETWm3tyinHvBwwqwh2N
 QJzTMMUethxbGmKLUHOfkEZLw/rZDDGyzuz+Z/nSCK7T70tM/VS2JdmIlYEsO/ZgAhM0
 aytQ==
X-Gm-Message-State: AC+VfDzAQL4sVqJX+E63G5ujLUq4fXvT+6Ir1cBgFbitxLsgU9SwG8Sd
 YhB0p9hs0mElXwwIQz1VL/fWxm1viWZfrjCcJfrixx+yPVBedhEY3APDWFzNaPqtQlfu2f5mDuk
 rjRC+r73vXBawM1AkyissknW/y4I7b/jNoz1qMRIEpQ==
X-Received: by 2002:a05:6000:1048:b0:30e:56d9:d7ac with SMTP id
 c8-20020a056000104800b0030e56d9d7acmr3159054wrx.35.1686204204553; 
 Wed, 07 Jun 2023 23:03:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6XOPN6+czxWNphCYhbqVa6CfYIa1tItvfka0vY5H/n/q6uIYGPbcpI3V2k64M16atx9nylQw==
X-Received: by 2002:a05:6000:1048:b0:30e:56d9:d7ac with SMTP id
 c8-20020a056000104800b0030e56d9d7acmr3159029wrx.35.1686204204156; 
 Wed, 07 Jun 2023 23:03:24 -0700 (PDT)
Received: from redhat.com ([2.55.41.2]) by smtp.gmail.com with ESMTPSA id
 h4-20020adffa84000000b0030647d1f34bsm470894wrr.1.2023.06.07.23.03.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 23:03:23 -0700 (PDT)
Date: Thu, 8 Jun 2023 02:03:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
Message-ID: <20230608020111-mutt-send-email-mst@kernel.org>
References: <24fjdwp44hovz3d3qkzftmvjie45er3g3boac7aezpvzbwvuol@lmo47ydvnqau>
 <20230605085840-mutt-send-email-mst@kernel.org>
 <gi2hngx3ndsgz5d2rpqjywdmou5vxhd7xgi5z2lbachr7yoos4@kpifz37oz2et>
 <20230605095404-mutt-send-email-mst@kernel.org>
 <32ejjuvhvcicv7wjuetkv34qtlpa657n4zlow4eq3fsi2twozk@iqnd2t5tw2an>
 <CACGkMEu3PqQ99UoKF5NHgVADD3q=BF6jhLiyumeT4S1QCqN1tw@mail.gmail.com>
 <20230606085643-mutt-send-email-mst@kernel.org>
 <CAGxU2F7fkgL-HpZdj=5ZEGNWcESCHQpgRAYQA3W2sPZaoEpNyQ@mail.gmail.com>
 <20230607054246-mutt-send-email-mst@kernel.org>
 <CACGkMEuUapKvUYiJiLwtsN+x941jafDKS9tuSkiNrvkrrSmQkg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuUapKvUYiJiLwtsN+x941jafDKS9tuSkiNrvkrrSmQkg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, Tiwei Bie <tiwei.bie@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
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

T24gVGh1LCBKdW4gMDgsIDIwMjMgYXQgMDg6NDI6MTVBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBXZWQsIEp1biA3LCAyMDIzIGF0IDU6NDPigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4g
PG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBXZWQsIEp1biAwNywgMjAyMyBhdCAx
MDozOToxNUFNICswMjAwLCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gPiA+IE9uIFR1ZSwg
SnVuIDYsIDIwMjMgYXQgMjo1OOKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5j
b20+IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4gT24gVHVlLCBKdW4gMDYsIDIwMjMgYXQgMDk6Mjk6
MjJBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+IE9uIE1vbiwgSnVuIDUsIDIw
MjMgYXQgMTA6NTjigK9QTSBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+
IHdyb3RlOgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBPbiBNb24sIEp1biAwNSwgMjAyMyBhdCAw
OTo1NDo1N0FNIC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+ID4gPiA+ID5P
biBNb24sIEp1biAwNSwgMjAyMyBhdCAwMzozMDozNVBNICswMjAwLCBTdGVmYW5vIEdhcnphcmVs
bGEgd3JvdGU6Cj4gPiA+ID4gPiA+ID4+IE9uIE1vbiwgSnVuIDA1LCAyMDIzIGF0IDA5OjAwOjI1
QU0gLTA0MDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gPiA+ID4gPj4gPiBPbiBN
b24sIEp1biAwNSwgMjAyMyBhdCAwMjo1NDoyMFBNICswMjAwLCBTdGVmYW5vIEdhcnphcmVsbGEg
d3JvdGU6Cj4gPiA+ID4gPiA+ID4+ID4gPiBPbiBNb24sIEp1biAwNSwgMjAyMyBhdCAwODo0MTo1
NEFNIC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4+ID4gPiA+
IE9uIE1vbiwgSnVuIDA1LCAyMDIzIGF0IDAxOjA2OjQ0UE0gKzAyMDAsIFN0ZWZhbm8gR2FyemFy
ZWxsYSB3cm90ZToKPiA+ID4gPiA+ID4gPj4gPiA+ID4gPiB2aG9zdC12ZHBhIElPQ1RMcyAoZWcu
IFZIT1NUX0dFVF9WUklOR19CQVNFLCBWSE9TVF9TRVRfVlJJTkdfQkFTRSkKPiA+ID4gPiA+ID4g
Pj4gPiA+ID4gPiBkb24ndCBzdXBwb3J0IHBhY2tlZCB2aXJ0cXVldWUgd2VsbCB5ZXQsIHNvIGxl
dCdzIGZpbHRlciB0aGUKPiA+ID4gPiA+ID4gPj4gPiA+ID4gPiBWSVJUSU9fRl9SSU5HX1BBQ0tF
RCBmZWF0dXJlIGZvciBub3cgaW4gdmhvc3RfdmRwYV9nZXRfZmVhdHVyZXMoKS4KPiA+ID4gPiA+
ID4gPj4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+PiA+ID4gPiA+IFRoaXMgd2F5LCBldmVuIGlmIHRo
ZSBkZXZpY2Ugc3VwcG9ydHMgaXQsIHdlIGRvbid0IHJpc2sgaXQgYmVpbmcKPiA+ID4gPiA+ID4g
Pj4gPiA+ID4gPiBuZWdvdGlhdGVkLCB0aGVuIHRoZSBWTU0gaXMgdW5hYmxlIHRvIHNldCB0aGUg
dnJpbmcgc3RhdGUgcHJvcGVybHkuCj4gPiA+ID4gPiA+ID4+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
Pj4gPiA+ID4gPiBGaXhlczogNGM4Y2YzMTg4NWY2ICgidmhvc3Q6IGludHJvZHVjZSB2RFBBLWJh
c2VkIGJhY2tlbmQiKQo+ID4gPiA+ID4gPiA+PiA+ID4gPiA+IENjOiBzdGFibGVAdmdlci5rZXJu
ZWwub3JnCj4gPiA+ID4gPiA+ID4+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6
YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgo+ID4gPiA+ID4gPiA+PiA+ID4gPiA+IC0tLQo+
ID4gPiA+ID4gPiA+PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4+ID4gPiA+ID4gTm90ZXM6Cj4gPiA+
ID4gPiA+ID4+ID4gPiA+ID4gICAgIFRoaXMgcGF0Y2ggc2hvdWxkIGJlIGFwcGxpZWQgYmVmb3Jl
IHRoZSAiW1BBVENIIHYyIDAvM10gdmhvc3RfdmRwYToKPiA+ID4gPiA+ID4gPj4gPiA+ID4gPiAg
ICAgYmV0dGVyIFBBQ0tFRCBzdXBwb3J0IiBzZXJpZXMgWzFdIGFuZCBiYWNrcG9ydGVkIGluIHN0
YWJsZSBicmFuY2hlcy4KPiA+ID4gPiA+ID4gPj4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+PiA+ID4g
PiA+ICAgICBXZSBjYW4gcmV2ZXJ0IGl0IHdoZW4gd2UgYXJlIHN1cmUgdGhhdCBldmVyeXRoaW5n
IGlzIHdvcmtpbmcgd2l0aAo+ID4gPiA+ID4gPiA+PiA+ID4gPiA+ICAgICBwYWNrZWQgdmlydHF1
ZXVlcy4KPiA+ID4gPiA+ID4gPj4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+PiA+ID4gPiA+ICAgICBU
aGFua3MsCj4gPiA+ID4gPiA+ID4+ID4gPiA+ID4gICAgIFN0ZWZhbm8KPiA+ID4gPiA+ID4gPj4g
PiA+ID4gPgo+ID4gPiA+ID4gPiA+PiA+ID4gPiA+ICAgICBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvdmlydHVhbGl6YXRpb24vMjAyMzA0MjQyMjUwMzEuMTg5NDctMS1zaGFubm9uLm5lbHNv
bkBhbWQuY29tLwo+ID4gPiA+ID4gPiA+PiA+ID4gPgo+ID4gPiA+ID4gPiA+PiA+ID4gPiBJJ20g
YSBiaXQgbG9zdCBoZXJlLiBTbyB3aHkgYW0gSSBtZXJnaW5nICJiZXR0ZXIgUEFDS0VEIHN1cHBv
cnQiIHRoZW4/Cj4gPiA+ID4gPiA+ID4+ID4gPgo+ID4gPiA+ID4gPiA+PiA+ID4gVG8gcmVhbGx5
IHN1cHBvcnQgcGFja2VkIHZpcnRxdWV1ZSB3aXRoIHZob3N0LXZkcGEsIGF0IHRoYXQgcG9pbnQg
d2Ugd291bGQKPiA+ID4gPiA+ID4gPj4gPiA+IGFsc28gaGF2ZSB0byByZXZlcnQgdGhpcyBwYXRj
aC4KPiA+ID4gPiA+ID4gPj4gPiA+Cj4gPiA+ID4gPiA+ID4+ID4gPiBJIHdhc24ndCBzdXJlIGlm
IHlvdSB3YW50ZWQgdG8gcXVldWUgdGhlIHNlcmllcyBmb3IgdGhpcyBtZXJnZSB3aW5kb3cuCj4g
PiA+ID4gPiA+ID4+ID4gPiBJbiB0aGF0IGNhc2UgZG8geW91IHRoaW5rIGl0IGlzIGJldHRlciB0
byBzZW5kIHRoaXMgcGF0Y2ggb25seSBmb3Igc3RhYmxlCj4gPiA+ID4gPiA+ID4+ID4gPiBicmFu
Y2hlcz8KPiA+ID4gPiA+ID4gPj4gPiA+ID4gRG9lcyB0aGlzIHBhdGNoIG1ha2UgdGhlbSBhIE5P
UD8KPiA+ID4gPiA+ID4gPj4gPiA+Cj4gPiA+ID4gPiA+ID4+ID4gPiBZZXAsIGFmdGVyIGFwcGx5
aW5nIHRoZSAiYmV0dGVyIFBBQ0tFRCBzdXBwb3J0IiBzZXJpZXMgYW5kIGJlaW5nCj4gPiA+ID4g
PiA+ID4+ID4gPiBzdXJlIHRoYXQKPiA+ID4gPiA+ID4gPj4gPiA+IHRoZSBJT0NUTHMgb2Ygdmhv
c3QtdmRwYSBzdXBwb3J0IHBhY2tlZCB2aXJ0cXVldWUsIHdlIHNob3VsZCByZXZlcnQgdGhpcwo+
ID4gPiA+ID4gPiA+PiA+ID4gcGF0Y2guCj4gPiA+ID4gPiA+ID4+ID4gPgo+ID4gPiA+ID4gPiA+
PiA+ID4gTGV0IG1lIGtub3cgaWYgeW91IHByZWZlciBhIGRpZmZlcmVudCBhcHByb2FjaC4KPiA+
ID4gPiA+ID4gPj4gPiA+Cj4gPiA+ID4gPiA+ID4+ID4gPiBJJ20gY29uY2VybmVkIHRoYXQgUUVN
VSB1c2VzIHZob3N0LXZkcGEgSU9DVExzIHRoaW5raW5nIHRoYXQgdGhlIGtlcm5lbAo+ID4gPiA+
ID4gPiA+PiA+ID4gaW50ZXJwcmV0cyB0aGVtIHRoZSByaWdodCB3YXksIHdoZW4gaXQgZG9lcyBu
b3QuCj4gPiA+ID4gPiA+ID4+ID4gPgo+ID4gPiA+ID4gPiA+PiA+ID4gVGhhbmtzLAo+ID4gPiA+
ID4gPiA+PiA+ID4gU3RlZmFubwo+ID4gPiA+ID4gPiA+PiA+ID4KPiA+ID4gPiA+ID4gPj4gPgo+
ID4gPiA+ID4gPiA+PiA+IElmIHRoaXMgZml4ZXMgYSBidWcgY2FuIHlvdSBhZGQgRml4ZXMgdGFn
cyB0byBlYWNoIG9mIHRoZW0/IFRoZW4gaXQncyBvawo+ID4gPiA+ID4gPiA+PiA+IHRvIG1lcmdl
IGluIHRoaXMgd2luZG93LiBQcm9iYWJseSBlYXNpZXIgdGhhbiB0aGUgZWxhYm9yYXRlCj4gPiA+
ID4gPiA+ID4+ID4gbWFzay91bm1hc2sgZGFuY2UuCj4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+
ID4+IENDaW5nIFNoYW5ub24gKHRoZSBvcmlnaW5hbCBhdXRob3Igb2YgdGhlICJiZXR0ZXIgUEFD
S0VEIHN1cHBvcnQiCj4gPiA+ID4gPiA+ID4+IHNlcmllcykuCj4gPiA+ID4gPiA+ID4+Cj4gPiA+
ID4gPiA+ID4+IElJVUMgU2hhbm5vbiBpcyBnb2luZyB0byBzZW5kIGEgdjMgb2YgdGhhdCBzZXJp
ZXMgdG8gZml4IHRoZQo+ID4gPiA+ID4gPiA+PiBkb2N1bWVudGF0aW9uLCBzbyBTaGFubm9uIGNh
biB5b3UgYWxzbyBhZGQgdGhlIEZpeGVzIHRhZ3M/Cj4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+
ID4+IFRoYW5rcywKPiA+ID4gPiA+ID4gPj4gU3RlZmFubwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+ID5XZWxsIHRoaXMgaXMgaW4gbXkgdHJlZSBhbHJlYWR5LiBKdXN0IHJlcGx5IHdpdGgKPiA+
ID4gPiA+ID4gPkZpeGVzOiA8Pgo+ID4gPiA+ID4gPiA+dG8gZWFjaCBhbmQgSSB3aWxsIGFkZCB0
aGVzZSB0YWdzLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBJIHRyaWVkLCBidXQgaXQgaXMgbm90
IGVhc3kgc2luY2Ugd2UgYWRkZWQgdGhlIHN1cHBvcnQgZm9yIHBhY2tlZAo+ID4gPiA+ID4gPiB2
aXJ0cXVldWUgaW4gdmRwYSBhbmQgdmhvc3QgaW5jcmVtZW50YWxseS4KPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gSW5pdGlhbGx5IEkgd2FzIHRoaW5raW5nIG9mIGFkZGluZyB0aGUgc2FtZSB0YWcg
dXNlZCBoZXJlOgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBGaXhlczogNGM4Y2YzMTg4NWY2ICgi
dmhvc3Q6IGludHJvZHVjZSB2RFBBLWJhc2VkIGJhY2tlbmQiKQo+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiBUaGVuIEkgZGlzY292ZXJlZCB0aGF0IHZxX3N0YXRlIHdhc24ndCB0aGVyZSwgc28gSSB3
YXMgdGhpbmtpbmcgb2YKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gRml4ZXM6IDUzMGE1Njc4YmMw
MCAoInZkcGE6IHN1cHBvcnQgcGFja2VkIHZpcnRxdWV1ZSBmb3Igc2V0L2dldF92cV9zdGF0ZSgp
IikKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gU28gd2Ugd291bGQgaGF2ZSB0byBiYWNrcG9ydCBx
dWl0ZSBhIGZldyBwYXRjaGVzIGludG8gdGhlIHN0YWJsZSBicmFuY2hlcy4KPiA+ID4gPiA+ID4g
SSBkb24ndCBrbm93IGlmIGl0J3Mgd29ydGggaXQuLi4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
SSBzdGlsbCB0aGluayBpdCBpcyBiZXR0ZXIgdG8gZGlzYWJsZSBwYWNrZWQgaW4gdGhlIHN0YWJs
ZSBicmFuY2hlcywKPiA+ID4gPiA+ID4gb3RoZXJ3aXNlIEkgaGF2ZSB0byBtYWtlIGEgbGlzdCBv
ZiBhbGwgdGhlIHBhdGNoZXMgd2UgbmVlZC4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gQW55IG90
aGVyIGlkZWFzPwo+ID4gPiA+ID4KPiA+ID4gPiA+IEFGQUlLLCBleGNlcHQgZm9yIHZwX3ZkcGEs
IHBkcyBzZWVtcyB0byBiZSB0aGUgZmlyc3QgcGFyZW50IHRoYXQKPiA+ID4gPiA+IHN1cHBvcnRz
IHBhY2tlZCB2aXJ0cXVldWUuIFVzZXJzIHNob3VsZCBub3Qgbm90aWNlIGFueXRoaW5nIHdyb25n
IGlmCj4gPiA+ID4gPiB0aGV5IGRvbid0IHVzZSBwYWNrZWQgdmlydHF1ZXVlLiBBbmQgdGhlIHBy
b2JsZW0gb2YgdnBfdmRwYSArIHBhY2tlZAo+ID4gPiA+ID4gdmlydHF1ZXVlIGNhbWUgc2luY2Ug
dGhlIGRheTAgb2YgdnBfdmRwYS4gSXQgc2VlbXMgZmluZSB0byBkbyBub3RoaW5nCj4gPiA+ID4g
PiBJIGd1ZXNzLgo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+Cj4gPiA+ID4KPiA+
ID4gPiBJIGhhdmUgYSBxdWVzdGlvbiB0aG91Z2gsIHdoYXQgaWYgZG93biB0aGUgcm9hZCB0aGVy
ZQo+ID4gPiA+IGlzIGEgbmV3IGZlYXR1cmUgdGhhdCBuZWVkcyBtb3JlIGNoYW5nZXM/IEl0IHdp
bGwgYmUKPiA+ID4gPiBicm9rZW4gdG9vIGp1c3QgbGlrZSBQQUNLRUQgbm8/Cj4gPiA+ID4gU2hv
dWxkbid0IHZkcGEgaGF2ZSBhbiBhbGxvd2xpc3Qgb2YgZmVhdHVyZXMgaXQga25vd3MgaG93Cj4g
PiA+ID4gdG8gc3VwcG9ydD8KPiA+ID4KPiA+ID4gSXQgbG9va3MgbGlrZSB3ZSBoYWQgaXQsIGJ1
dCB3ZSB0b29rIGl0IG91dCAoYnkgdGhlIHdheSwgd2Ugd2VyZQo+ID4gPiBlbmFibGluZyBwYWNr
ZWQgZXZlbiB0aG91Z2ggd2UgZGlkbid0IHN1cHBvcnQgaXQpOgo+ID4gPiBodHRwczovL2dpdC5r
ZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29t
bWl0Lz9pZD02MjM0ZjgwNTc0ZDc1Njk0NDRkODcxODM1NWZhMjgzOGU5MmIxNThiCj4gPiA+Cj4g
PiA+IFRoZSBvbmx5IHByb2JsZW0gSSBzZWUgaXMgdGhhdCBmb3IgZWFjaCBuZXcgZmVhdHVyZSB3
ZSBoYXZlIHRvIG1vZGlmeQo+ID4gPiB0aGUga2VybmVsLgo+ID4gPiBDb3VsZCB3ZSBoYXZlIG5l
dyBmZWF0dXJlcyB0aGF0IGRvbid0IHJlcXVpcmUgaGFuZGxpbmcgYnkgdmhvc3QtdmRwYT8KPiA+
ID4KPiA+ID4gVGhhbmtzLAo+ID4gPiBTdGVmYW5vCj4gPgo+ID4gSmFzb24gd2hhdCBkbyB5b3Ug
c2F5IHRvIHJldmVydGluZyB0aGlzPwo+IAo+IEkgbWF5IG1pc3Mgc29tZXRoaW5nIGJ1dCBJIGRv
bid0IHNlZSBhbnkgcHJvYmxlbSB3aXRoIHZEUEEgY29yZS4KPiAKPiBJdCdzIHRoZSBkdXR5IG9m
IHRoZSBwYXJlbnRzIHRvIGFkdmVydGlzZSB0aGUgZmVhdHVyZXMgaXQgaGFzLiBGb3IgZXhhbXBs
ZSwKPiAKPiAxKSBJZiBzb21lIGtlcm5lbCB2ZXJzaW9uIHRoYXQgaXMgcGFja2VkIGlzIG5vdCBz
dXBwb3J0ZWQgdmlhCj4gc2V0X3ZxX3N0YXRlLCBwYXJlbnRzIHNob3VsZCBub3QgYWR2ZXJ0aXNl
IFBBQ0tFRCBmZWF0dXJlcyBpbiB0aGlzCj4gY2FzZS4KPiAyKSBJZiB0aGUga2VybmVsIGhhcyBz
dXBwb3J0IHBhY2tlZCBzZXRfdnFfc3RhdGUoKSwgYnV0IGl0J3MgZW11bGF0ZWQKPiBjdnEgZG9l
c24ndCBzdXBwb3J0LCBwYXJlbnRzIHNob3VsZCBub3QgYWR2ZXJ0aXNlIFBBQ0tFRCBhcyB3ZWxs
Cj4gCj4gSWYgYSBwYXJlbnQgdmlvbGF0ZXMgdGhlIGFib3ZlIDIsIGl0IGxvb2tzIGxpa2UgYSBi
dWcgb2YgdGhlIHBhcmVudHMuCj4gCj4gVGhhbmtzCgpZZXMgYnV0IHdoYXQgYWJvdXQgdmhvc3Rf
dmRwYT8gVGFsa2luZyBhYm91dCB0aGF0IG5vdCB0aGUgY29yZS4KU2hvdWxkIHRoYXQgbm90IGhh
dmUgYSB3aGl0ZWxpc3Qgb2YgZmVhdHVyZXMKc2luY2UgaXQgaW50ZXJwcmV0cyBpb2N0bHMgZGlm
ZmVyZW50bHkgZGVwZW5kaW5nIG9uIHRoaXM/Cgo+ID4KPiA+IC0tCj4gPiBNU1QKPiA+CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
