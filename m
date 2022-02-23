Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECABC433FE
	for <virtualization@archiver.kernel.org>; Wed, 23 Feb 2022 13:31:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C3D760BFB;
	Wed, 23 Feb 2022 13:31:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kfyab3xOtmq3; Wed, 23 Feb 2022 13:31:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A829360A7B;
	Wed, 23 Feb 2022 13:31:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70C50C001A;
	Wed, 23 Feb 2022 13:31:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75443C0011
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 13:31:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4BE8681BB0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 13:31:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4PtAHYtadEuB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 13:31:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 67380812D3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 13:31:55 +0000 (UTC)
Received: by mail-lj1-x22d.google.com with SMTP id bn33so24636219ljb.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 05:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7dnyHmrO36rrHyXARPRiGQlAPqAL/RPhHWzq7NmeXFU=;
 b=DCpZuBYw1K5GBm3Yf8oboPq/eMpixfVzGH8pD4UEALwU6Piq0DHgYQgOt/7CAvI306
 Dcz50R2TMDksWKMuLwdtBmupzNUlRGkvZEr3wrUGXHDsry2cMM5zBquEuUE/lGQio3cy
 dQioRFt9XmtopGgUlNHRhYJyo7M9qv/QhTJs7H/sBz6Y+d0QTU8BHf6TQuNWtwwlfHVy
 CsK3Xgbm2ngEooxg6hRKNJbBTvfjYRUDLlL01JPPYENYx80hxKuFn8POj2bETak/AHLu
 Za/hbi5Gqnd8nDCavCmWhSt5NPE4zh7m8WDnAJZpqs6lI7TkKUByTA7ZENXTV7ySlrYX
 jQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7dnyHmrO36rrHyXARPRiGQlAPqAL/RPhHWzq7NmeXFU=;
 b=OW2olmcm7oE0zVuLY4kTp/hjHdXwXKQD4uCmi2RQA1C8y/3oxMeVeecmIQWxGHwSyq
 7l97A4VTdAZ2s0Uc4Y8LFSUyl44pTKzv+H12KHQQZu13lKbk3axDxUoOznNDllIJwu8Q
 wPfamkLyrFVmPCFeRmYM6FABm/dI2POVcz8CXT+uuFImEf6oC6JBtDhGWW3R6K7iK3ok
 dEVjUkKQ8MEHpjkmm2Z+6UjTKi0CEDQEwPP1+yqE4fu9BstADABTUZnXBFcjle/X9+1S
 LLwUFeZrd4L11l/EIu0hzddOgbNDrKA40hbu0BRb/tPJ9gYCKaIX9I0iHqNjwR6eZxz2
 6k0A==
X-Gm-Message-State: AOAM533XOMtRZ6WmN1rEnpGAWhAs7ir36KnVRc9tKHrK3xiVzCwN7Ghu
 xNg79adGkGFjzK4kSHx0u8XlutbNIH5qP4nVP+/OvQ==
X-Google-Smtp-Source: ABdhPJwJY+a32PVbCbOr6F7WLpIRa1HJ6cmeP7R7LTqqu3aAVT2hhZelkzr7J95bPvGGBDkYywmSkJE5OgieO0xkm/Q=
X-Received: by 2002:a05:651c:1509:b0:246:5f82:eed2 with SMTP id
 e9-20020a05651c150900b002465f82eed2mr1509589ljf.271.1645623113097; Wed, 23
 Feb 2022 05:31:53 -0800 (PST)
MIME-Version: 1.0
References: <20220125084702.3636253-1-andrew@daynix.com>
 <20220125084702.3636253-2-andrew@daynix.com>
 <06a90de0-57ae-9315-dc2c-03cc74b4ae0c@redhat.com>
 <CABcq3pH7HnH_-nCHcX7eet_ouqocQEptp6A9GCbs3=9guArhPA@mail.gmail.com>
 <CACGkMEu3biQ+BM29nDu82jP8y+p4iiL4K=GzM6px+yktU5Zqjw@mail.gmail.com>
In-Reply-To: <CACGkMEu3biQ+BM29nDu82jP8y+p4iiL4K=GzM6px+yktU5Zqjw@mail.gmail.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Wed, 23 Feb 2022 15:31:41 +0200
Message-ID: <CAOEp5OeGNezTasp7zsvpFHGfjkM4bWRbbFY7WEWc7hRYVDSxdA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] uapi/linux/if_tun.h: Added new ioctl for tun/tap.
To: Jason Wang <jasowang@redhat.com>
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

SGkgSmFzb24sCldlIGFncmVlIHRoYXQgdGhlIHNhbWUgY2FuIGJlIGRvbmUgYWxzbyB1c2luZyB0
aGUgb2xkIHdheSwgaS5lLiB0cnkgdG8Kc2V0IHNwZWNpZmljIG9mZmxvYWQgLSBpZiBmYWlsZWQs
IHByb2JhYmx5IGl0IGlzIG5vdCBzdXBwb3J0ZWQuCldlIHRoaW5rIHRoaXMgaXMgYSBsaXR0bGUg
bm90IHNjYWxhYmxlIGFuZCB3ZSBzdWdnZXN0IGFkZGluZyB0aGUgaW9jdGwKdGhhdCB3aWxsIGFs
bG93IHVzIHRvIHF1ZXJ5IGFsbG8gdGhlIHN1cHBvcnRlZCBmZWF0dXJlcyBpbiBhIHNpbmdsZQpj
YWxsLgpXZSB0aGluayB0aGlzIHdpbGwgbWFrZSBRRU1VIGNvZGUgbW9yZSBzaW1wbGUgYWxzbyBp
biBmdXR1cmUuCkRvIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHkgdGhhdCB5b3Ugc3VnZ2VzdCB0byBz
a2lwIHRoaXMgbmV3IGlvY3RsIGFuZAp1c2UgdGhlIG9sZCB3YXkgb2YgcXVlcnkgZm9yIHRoaXMg
KFVTTykgZmVhdHVyZSBhbmQgYWxsIGZ1dHVyZQpleHRlbnNpb25zPwoKVGhhbmtzCgoKT24gV2Vk
LCBGZWIgMjMsIDIwMjIgYXQgNTo1MyBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
PiB3cm90ZToKPgo+IE9uIFR1ZSwgRmViIDIyLCAyMDIyIGF0IDk6MjggUE0gQW5kcmV3IE1lbG5p
Y2hlbmtvIDxhbmRyZXdAZGF5bml4LmNvbT4gd3JvdGU6Cj4gPgo+ID4gSGkgYWxsLAo+ID4KPiA+
IE9uIFdlZCwgRmViIDksIDIwMjIgYXQgNjoyNiBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPiA+ID4KPiA+ID4KPiA+ID4g5ZyoIDIwMjIvMS8yNSDkuIvljYg0OjQ2
LCBBbmRyZXcgTWVsbnljaGVua28g5YaZ6YGTOgo+ID4gPiA+IEFkZGVkIFRVTkdFVFNVUFBPUlRF
RE9GRkxPQURTIHRoYXQgc2hvdWxkIGFsbG93Cj4gPiA+ID4gdG8gZ2V0IGJpdHMgb2Ygc3VwcG9y
dGVkIG9mZmxvYWRzLgo+ID4gPgo+ID4gPgo+ID4gPiBTbyB3ZSBkb24ndCB1c2UgZGVkaWNhdGVk
IGlvY3RscyBpbiB0aGUgcGFzdCwgaW5zdGVhZCwgd2UganVzdCBwcm9iaW5nCj4gPiA+IGJ5IGNo
ZWNraW5nIHRoZSByZXR1cm4gdmFsdWUgb2YgVFVOU0VUT0ZGTE9BRFMuCj4gPiA+Cj4gPiA+IEUu
ZyBxZW11IGhhcyB0aGUgZm9sbG93aW5nIGNvZGVzOgo+ID4gPgo+ID4gPiBpbnQgdGFwX3Byb2Jl
X2hhc191Zm8oaW50IGZkKQo+ID4gPiB7Cj4gPiA+ICAgICAgdW5zaWduZWQgb2ZmbG9hZDsKPiA+
ID4KPiA+ID4gICAgICBvZmZsb2FkID0gVFVOX0ZfQ1NVTSB8IFRVTl9GX1VGTzsKPiA+ID4KPiA+
ID4gICAgICBpZiAoaW9jdGwoZmQsIFRVTlNFVE9GRkxPQUQsIG9mZmxvYWQpIDwgMCkKPiA+ID4g
ICAgICAgICAgcmV0dXJuIDA7Cj4gPiA+Cj4gPiA+ICAgICAgcmV0dXJuIDE7Cj4gPiA+IH0KPiA+
ID4KPiA+ID4gQW55IHJlYXNvbiB3ZSBjYW4ndCBrZWVwIHVzaW5nIHRoYXQ/Cj4gPiA+Cj4gPiA+
IFRoYW5rcwo+ID4gPgo+ID4KPiA+IFdlbGwsIGV2ZW4gaW4gdGhpcyBleGFtcGxlLiBUbyBjaGVj
ayB0aGUgdWZvIGZlYXR1cmUsIHdlIHRyeWluZyB0byBzZXQgaXQuCj4gPiBXaGF0IGlmIHdlIGRv
bid0IG5lZWQgdG8gImVuYWJsZSIgVUZPIGFuZC9vciBkbyBub3QgY2hhbmdlIGl0cyBzdGF0ZT8K
Pgo+IFNvIGF0IGxlYXN0IFFlbXUgZG9lc24ndCBoYXZlIHN1Y2ggYSByZXF1aXJlbWVudCBzaW5j
ZSBkdXJpbmcgdGhlCj4gcHJvYmUgdGhlIHZpcnR1YWwgbmV0d29ya2luZyBiYWNrZW5kIGlzIG5v
dCBldmVuIHN0YXJ0ZWQuCj4KPiA+IEkgdGhpbmsgaXQncyBhIGdvb2QgaWRlYSB0byBoYXZlIHRo
ZSBhYmlsaXR5IHRvIGdldCBzdXBwb3J0ZWQgb2ZmbG9hZHMKPiA+IHdpdGhvdXQgY2hhbmdpbmcg
ZGV2aWNlIGJlaGF2aW9yLgo+Cj4gRG8geW91IHNlZSBhIHJlYWwgdXNlciBmb3IgdGhpcz8KPgo+
IEJ0dywgd2Ugc3RpbGwgbmVlZCB0byBwcm9iZSB0aGlzIG5ldyBpb2N0bCBhbnl3YXkuCj4KPiBU
aGFua3MKPgo+ID4KPiA+ID4KPiA+ID4gPiBBZGRlZCAyIGFkZGl0aW9uYWwgb2ZmbGxvYWRzIGZv
ciBVU08oSVB2NCAmIElQdjYpLgo+ID4gPiA+IFNlcGFyYXRlIG9mZmxvYWRzIGFyZSByZXF1aXJl
ZCBmb3IgV2luZG93cyBWTSBndWVzdHMsCj4gPiA+ID4gZy5lLiBXaW5kb3dzIG1heSBzZXQgVVNP
IHJ4IG9ubHkgZm9yIElQdjQuCj4gPiA+ID4KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXcg
TWVsbnljaGVua28gPGFuZHJld0BkYXluaXguY29tPgo+ID4gPiA+IC0tLQo+ID4gPiA+ICAgaW5j
bHVkZS91YXBpL2xpbnV4L2lmX3R1bi5oIHwgMyArKysKPiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKykKPiA+ID4gPgo+ID4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3Vh
cGkvbGludXgvaWZfdHVuLmggYi9pbmNsdWRlL3VhcGkvbGludXgvaWZfdHVuLmgKPiA+ID4gPiBp
bmRleCA0NTRhZTMxYjkzYzcuLjA3NjgwZmFlNmUxOCAxMDA2NDQKPiA+ID4gPiAtLS0gYS9pbmNs
dWRlL3VhcGkvbGludXgvaWZfdHVuLmgKPiA+ID4gPiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgv
aWZfdHVuLmgKPiA+ID4gPiBAQCAtNjEsNiArNjEsNyBAQAo+ID4gPiA+ICAgI2RlZmluZSBUVU5T
RVRGSUxURVJFQlBGIF9JT1IoJ1QnLCAyMjUsIGludCkKPiA+ID4gPiAgICNkZWZpbmUgVFVOU0VU
Q0FSUklFUiBfSU9XKCdUJywgMjI2LCBpbnQpCj4gPiA+ID4gICAjZGVmaW5lIFRVTkdFVERFVk5F
VE5TIF9JTygnVCcsIDIyNykKPiA+ID4gPiArI2RlZmluZSBUVU5HRVRTVVBQT1JURURPRkZMT0FE
UyBfSU9SKCdUJywgMjI4LCB1bnNpZ25lZCBpbnQpCj4gPiA+ID4KPiA+ID4gPiAgIC8qIFRVTlNF
VElGRiBpZnIgZmxhZ3MgKi8KPiA+ID4gPiAgICNkZWZpbmUgSUZGX1RVTiAgICAgICAgICAgICAw
eDAwMDEKPiA+ID4gPiBAQCAtODgsNiArODksOCBAQAo+ID4gPiA+ICAgI2RlZmluZSBUVU5fRl9U
U082ICAweDA0ICAgIC8qIEkgY2FuIGhhbmRsZSBUU08gZm9yIElQdjYgcGFja2V0cyAqLwo+ID4g
PiA+ICAgI2RlZmluZSBUVU5fRl9UU09fRUNOICAgICAgIDB4MDggICAgLyogSSBjYW4gaGFuZGxl
IFRTTyB3aXRoIEVDTiBiaXRzLiAqLwo+ID4gPiA+ICAgI2RlZmluZSBUVU5fRl9VRk8gICAweDEw
ICAgIC8qIEkgY2FuIGhhbmRsZSBVRk8gcGFja2V0cyAqLwo+ID4gPiA+ICsjZGVmaW5lIFRVTl9G
X1VTTzQgICAweDIwICAgIC8qIEkgY2FuIGhhbmRsZSBVU08gZm9yIElQdjQgcGFja2V0cyAqLwo+
ID4gPiA+ICsjZGVmaW5lIFRVTl9GX1VTTzYgICAweDQwICAgIC8qIEkgY2FuIGhhbmRsZSBVU08g
Zm9yIElQdjYgcGFja2V0cyAqLwo+ID4gPiA+Cj4gPiA+ID4gICAvKiBQcm90b2NvbCBpbmZvIHBy
ZXBlbmRlZCB0byB0aGUgcGFja2V0cyAod2hlbiBJRkZfTk9fUEkgaXMgbm90IHNldCkgKi8KPiA+
ID4gPiAgICNkZWZpbmUgVFVOX1BLVF9TVFJJUCAgICAgICAweDAwMDEKPiA+ID4KPiA+Cj4KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
