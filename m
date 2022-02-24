Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06DBC433EF
	for <virtualization@archiver.kernel.org>; Thu, 24 Feb 2022 03:34:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C00A41655;
	Thu, 24 Feb 2022 03:34:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h5NfACLxfS3u; Thu, 24 Feb 2022 03:34:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D2FF14156D;
	Thu, 24 Feb 2022 03:34:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8B43C001A;
	Thu, 24 Feb 2022 03:34:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6449C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 03:34:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B699182A17
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 03:34:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pxeh8om0IJgT
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 03:34:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CFE2282980
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 03:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645673651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dRVV6TmPyQlUU8AVGLAcBRDwJHwTdqvbfx7jgBXGTKI=;
 b=hImqZutijLMVBa40aK/yN/92Lvedl58ALTHoYS6Ccw/jl1jbaDN6/oq9W81labi+Tsuoql
 U8IUmVpNkx7YVG67ATKVMtnPrj9oSvCbcfnIghUkGz2/mopzZuirD50hCiy+OgZ0GcCIxF
 dtSYV3PLYamBMxfm3cWoIDU/x/zm+Ak=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-440-hsgUmjGDOF-iyRR6QEYIxQ-1; Wed, 23 Feb 2022 22:34:10 -0500
X-MC-Unique: hsgUmjGDOF-iyRR6QEYIxQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 bn10-20020a05651c178a00b00244baa268b6so390320ljb.15
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 19:34:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dRVV6TmPyQlUU8AVGLAcBRDwJHwTdqvbfx7jgBXGTKI=;
 b=ZeIasAFCHgN9vFoC6GcmDrWsbEF8+iqzmYaY2Klw2b5mgDgKxrfpDHyyUP022VMO50
 1aqmRErHALjZvpYnfY7ChoPAjFKiQmqvFIHN0KDVgS3O9J/ksHxsujEyGRXDuaXZLG6i
 t7hUKjM8c64wlZNFTAGg5AkXSbxNcM90y10B4SPq90ukIJuYP27Kz2Ojd5jSsZ3f2a7y
 FH6kdm0+BC/8KOoegF8fnXnZZ7JcnbJIRd/3GOwO0kvWM0ZoGj4EDje9EXSCjpnVZd9l
 ndX87nlNisCTZiVYS5JjMXE1qVTDuc0oRVr0cuFusf2RWi0bbVlxSS/2VvIAP6ncqnsT
 EYaw==
X-Gm-Message-State: AOAM533EMjiyOGd7hoSBqHRcRw9z6+UHYamuPpIGsAJbinYtYmuqNsW5
 Xyw5vbXCmV+tx8ZnWFVRdsj29CGzFlCR4YNr/eFvk/FLW2I6Cd2YVs2HAGv/F9Z5/l9dQmUjIwp
 s50jhRquwTcVoSTDo/7q83MEAET9yoiNTk93qIZLPKrIoZg3eD802TBXjqQ==
X-Received: by 2002:a05:651c:90b:b0:244:c4a4:d5d8 with SMTP id
 e11-20020a05651c090b00b00244c4a4d5d8mr505698ljq.97.1645673648381; 
 Wed, 23 Feb 2022 19:34:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzpmLs9g/U0Nam8IX5XUKO+vHZBxi+ea87oOifawu8S182lz+abrWGFM4Nuj1sMsYtNTba1YT9wi3dOmn1L1ts=
X-Received: by 2002:a05:651c:90b:b0:244:c4a4:d5d8 with SMTP id
 e11-20020a05651c090b00b00244c4a4d5d8mr505687ljq.97.1645673648154; Wed, 23 Feb
 2022 19:34:08 -0800 (PST)
MIME-Version: 1.0
References: <20220125084702.3636253-1-andrew@daynix.com>
 <20220125084702.3636253-2-andrew@daynix.com>
 <06a90de0-57ae-9315-dc2c-03cc74b4ae0c@redhat.com>
 <CABcq3pH7HnH_-nCHcX7eet_ouqocQEptp6A9GCbs3=9guArhPA@mail.gmail.com>
 <CACGkMEu3biQ+BM29nDu82jP8y+p4iiL4K=GzM6px+yktU5Zqjw@mail.gmail.com>
 <CAOEp5OeGNezTasp7zsvpFHGfjkM4bWRbbFY7WEWc7hRYVDSxdA@mail.gmail.com>
In-Reply-To: <CAOEp5OeGNezTasp7zsvpFHGfjkM4bWRbbFY7WEWc7hRYVDSxdA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 24 Feb 2022 11:33:56 +0800
Message-ID: <CACGkMEvJj040VqzhaJkAZs-bLeGoWWUYtBguEZAqTqVBH7ShLg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] uapi/linux/if_tun.h: Added new ioctl for tun/tap.
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrew Melnichenko <andrew@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yan Vugenfirer <yan@daynix.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

T24gV2VkLCBGZWIgMjMsIDIwMjIgYXQgOTozMSBQTSBZdXJpIEJlbmRpdG92aWNoCjx5dXJpLmJl
bmRpdG92aWNoQGRheW5peC5jb20+IHdyb3RlOgo+Cj4gSGkgSmFzb24sCj4gV2UgYWdyZWUgdGhh
dCB0aGUgc2FtZSBjYW4gYmUgZG9uZSBhbHNvIHVzaW5nIHRoZSBvbGQgd2F5LCBpLmUuIHRyeSB0
bwo+IHNldCBzcGVjaWZpYyBvZmZsb2FkIC0gaWYgZmFpbGVkLCBwcm9iYWJseSBpdCBpcyBub3Qg
c3VwcG9ydGVkLgo+IFdlIHRoaW5rIHRoaXMgaXMgYSBsaXR0bGUgbm90IHNjYWxhYmxlIGFuZCB3
ZSBzdWdnZXN0IGFkZGluZyB0aGUgaW9jdGwKPiB0aGF0IHdpbGwgYWxsb3cgdXMgdG8gcXVlcnkg
YWxsbyB0aGUgc3VwcG9ydGVkIGZlYXR1cmVzIGluIGEgc2luZ2xlCj4gY2FsbC4KClBvc3NpYmx5
IGJ1dCB0aGVuIHlvdSBuZWVkIHNvbWUga2luZCBvZiBwcm9iaW5nLiBFLmcgd2UgbmVlZCBlbmR1
cAp3aXRoIHByb2JpbmcgVFVOR0VUU1VQUE9SVEVET0ZGTE9BRFMgaW90Y3RsIGl0c2VsZi4KCj4g
V2UgdGhpbmsgdGhpcyB3aWxsIG1ha2UgUUVNVSBjb2RlIG1vcmUgc2ltcGxlIGFsc28gaW4gZnV0
dXJlLgoKV2UgY2FuIGRpc2N1c3MgdGhpcyB3aGVuIHFlbXUgcGF0Y2hlcyB3ZXJlIHNlbnQuCgo+
IERvIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHkgdGhhdCB5b3Ugc3VnZ2VzdCB0byBza2lwIHRoaXMg
bmV3IGlvY3RsIGFuZAo+IHVzZSB0aGUgb2xkIHdheSBvZiBxdWVyeSBmb3IgdGhpcyAoVVNPKSBm
ZWF0dXJlIGFuZCBhbGwgZnV0dXJlCj4gZXh0ZW5zaW9ucz8KClllcywgc2luY2UgaXQncyBub3Qg
YSBtdXN0LiBBbmQgd2UgY2FuIGRvIHRoZSBUVU5HRVRTVVBQT1JURURPRkZMT0FEUwppbiBhIHNl
cGFyYXRlIHNlcmllcy4KClRoYW5rcwoKPgo+IFRoYW5rcwo+Cj4KPiBPbiBXZWQsIEZlYiAyMywg
MjAyMiBhdCA1OjUzIEFNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+
ID4KPiA+IE9uIFR1ZSwgRmViIDIyLCAyMDIyIGF0IDk6MjggUE0gQW5kcmV3IE1lbG5pY2hlbmtv
IDxhbmRyZXdAZGF5bml4LmNvbT4gd3JvdGU6Cj4gPiA+Cj4gPiA+IEhpIGFsbCwKPiA+ID4KPiA+
ID4gT24gV2VkLCBGZWIgOSwgMjAyMiBhdCA2OjI2IEFNIEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiDlnKggMjAyMi8xLzI1IOS4
i+WNiDQ6NDYsIEFuZHJldyBNZWxueWNoZW5rbyDlhpnpgZM6Cj4gPiA+ID4gPiBBZGRlZCBUVU5H
RVRTVVBQT1JURURPRkZMT0FEUyB0aGF0IHNob3VsZCBhbGxvdwo+ID4gPiA+ID4gdG8gZ2V0IGJp
dHMgb2Ygc3VwcG9ydGVkIG9mZmxvYWRzLgo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBTbyB3ZSBk
b24ndCB1c2UgZGVkaWNhdGVkIGlvY3RscyBpbiB0aGUgcGFzdCwgaW5zdGVhZCwgd2UganVzdCBw
cm9iaW5nCj4gPiA+ID4gYnkgY2hlY2tpbmcgdGhlIHJldHVybiB2YWx1ZSBvZiBUVU5TRVRPRkZM
T0FEUy4KPiA+ID4gPgo+ID4gPiA+IEUuZyBxZW11IGhhcyB0aGUgZm9sbG93aW5nIGNvZGVzOgo+
ID4gPiA+Cj4gPiA+ID4gaW50IHRhcF9wcm9iZV9oYXNfdWZvKGludCBmZCkKPiA+ID4gPiB7Cj4g
PiA+ID4gICAgICB1bnNpZ25lZCBvZmZsb2FkOwo+ID4gPiA+Cj4gPiA+ID4gICAgICBvZmZsb2Fk
ID0gVFVOX0ZfQ1NVTSB8IFRVTl9GX1VGTzsKPiA+ID4gPgo+ID4gPiA+ICAgICAgaWYgKGlvY3Rs
KGZkLCBUVU5TRVRPRkZMT0FELCBvZmZsb2FkKSA8IDApCj4gPiA+ID4gICAgICAgICAgcmV0dXJu
IDA7Cj4gPiA+ID4KPiA+ID4gPiAgICAgIHJldHVybiAxOwo+ID4gPiA+IH0KPiA+ID4gPgo+ID4g
PiA+IEFueSByZWFzb24gd2UgY2FuJ3Qga2VlcCB1c2luZyB0aGF0Pwo+ID4gPiA+Cj4gPiA+ID4g
VGhhbmtzCj4gPiA+ID4KPiA+ID4KPiA+ID4gV2VsbCwgZXZlbiBpbiB0aGlzIGV4YW1wbGUuIFRv
IGNoZWNrIHRoZSB1Zm8gZmVhdHVyZSwgd2UgdHJ5aW5nIHRvIHNldCBpdC4KPiA+ID4gV2hhdCBp
ZiB3ZSBkb24ndCBuZWVkIHRvICJlbmFibGUiIFVGTyBhbmQvb3IgZG8gbm90IGNoYW5nZSBpdHMg
c3RhdGU/Cj4gPgo+ID4gU28gYXQgbGVhc3QgUWVtdSBkb2Vzbid0IGhhdmUgc3VjaCBhIHJlcXVp
cmVtZW50IHNpbmNlIGR1cmluZyB0aGUKPiA+IHByb2JlIHRoZSB2aXJ0dWFsIG5ldHdvcmtpbmcg
YmFja2VuZCBpcyBub3QgZXZlbiBzdGFydGVkLgo+ID4KPiA+ID4gSSB0aGluayBpdCdzIGEgZ29v
ZCBpZGVhIHRvIGhhdmUgdGhlIGFiaWxpdHkgdG8gZ2V0IHN1cHBvcnRlZCBvZmZsb2Fkcwo+ID4g
PiB3aXRob3V0IGNoYW5naW5nIGRldmljZSBiZWhhdmlvci4KPiA+Cj4gPiBEbyB5b3Ugc2VlIGEg
cmVhbCB1c2VyIGZvciB0aGlzPwo+ID4KPiA+IEJ0dywgd2Ugc3RpbGwgbmVlZCB0byBwcm9iZSB0
aGlzIG5ldyBpb2N0bCBhbnl3YXkuCj4gPgo+ID4gVGhhbmtzCj4gPgo+ID4gPgo+ID4gPiA+Cj4g
PiA+ID4gPiBBZGRlZCAyIGFkZGl0aW9uYWwgb2ZmbGxvYWRzIGZvciBVU08oSVB2NCAmIElQdjYp
Lgo+ID4gPiA+ID4gU2VwYXJhdGUgb2ZmbG9hZHMgYXJlIHJlcXVpcmVkIGZvciBXaW5kb3dzIFZN
IGd1ZXN0cywKPiA+ID4gPiA+IGcuZS4gV2luZG93cyBtYXkgc2V0IFVTTyByeCBvbmx5IGZvciBJ
UHY0Lgo+ID4gPiA+ID4KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFuZHJldyBNZWxueWNoZW5r
byA8YW5kcmV3QGRheW5peC5jb20+Cj4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+ICAgaW5jbHVkZS91
YXBpL2xpbnV4L2lmX3R1bi5oIHwgMyArKysKPiA+ID4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKQo+ID4gPiA+ID4KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3Vh
cGkvbGludXgvaWZfdHVuLmggYi9pbmNsdWRlL3VhcGkvbGludXgvaWZfdHVuLmgKPiA+ID4gPiA+
IGluZGV4IDQ1NGFlMzFiOTNjNy4uMDc2ODBmYWU2ZTE4IDEwMDY0NAo+ID4gPiA+ID4gLS0tIGEv
aW5jbHVkZS91YXBpL2xpbnV4L2lmX3R1bi5oCj4gPiA+ID4gPiArKysgYi9pbmNsdWRlL3VhcGkv
bGludXgvaWZfdHVuLmgKPiA+ID4gPiA+IEBAIC02MSw2ICs2MSw3IEBACj4gPiA+ID4gPiAgICNk
ZWZpbmUgVFVOU0VURklMVEVSRUJQRiBfSU9SKCdUJywgMjI1LCBpbnQpCj4gPiA+ID4gPiAgICNk
ZWZpbmUgVFVOU0VUQ0FSUklFUiBfSU9XKCdUJywgMjI2LCBpbnQpCj4gPiA+ID4gPiAgICNkZWZp
bmUgVFVOR0VUREVWTkVUTlMgX0lPKCdUJywgMjI3KQo+ID4gPiA+ID4gKyNkZWZpbmUgVFVOR0VU
U1VQUE9SVEVET0ZGTE9BRFMgX0lPUignVCcsIDIyOCwgdW5zaWduZWQgaW50KQo+ID4gPiA+ID4K
PiA+ID4gPiA+ICAgLyogVFVOU0VUSUZGIGlmciBmbGFncyAqLwo+ID4gPiA+ID4gICAjZGVmaW5l
IElGRl9UVU4gICAgICAgICAgICAgMHgwMDAxCj4gPiA+ID4gPiBAQCAtODgsNiArODksOCBAQAo+
ID4gPiA+ID4gICAjZGVmaW5lIFRVTl9GX1RTTzYgIDB4MDQgICAgLyogSSBjYW4gaGFuZGxlIFRT
TyBmb3IgSVB2NiBwYWNrZXRzICovCj4gPiA+ID4gPiAgICNkZWZpbmUgVFVOX0ZfVFNPX0VDTiAg
ICAgICAweDA4ICAgIC8qIEkgY2FuIGhhbmRsZSBUU08gd2l0aCBFQ04gYml0cy4gKi8KPiA+ID4g
PiA+ICAgI2RlZmluZSBUVU5fRl9VRk8gICAweDEwICAgIC8qIEkgY2FuIGhhbmRsZSBVRk8gcGFj
a2V0cyAqLwo+ID4gPiA+ID4gKyNkZWZpbmUgVFVOX0ZfVVNPNCAgIDB4MjAgICAgLyogSSBjYW4g
aGFuZGxlIFVTTyBmb3IgSVB2NCBwYWNrZXRzICovCj4gPiA+ID4gPiArI2RlZmluZSBUVU5fRl9V
U082ICAgMHg0MCAgICAvKiBJIGNhbiBoYW5kbGUgVVNPIGZvciBJUHY2IHBhY2tldHMgKi8KPiA+
ID4gPiA+Cj4gPiA+ID4gPiAgIC8qIFByb3RvY29sIGluZm8gcHJlcGVuZGVkIHRvIHRoZSBwYWNr
ZXRzICh3aGVuIElGRl9OT19QSSBpcyBub3Qgc2V0KSAqLwo+ID4gPiA+ID4gICAjZGVmaW5lIFRV
Tl9QS1RfU1RSSVAgICAgICAgMHgwMDAxCj4gPiA+ID4KPiA+ID4KPiA+Cj4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
