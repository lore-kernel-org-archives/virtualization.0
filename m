Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33AF7C07545
	for <virtualization@archiver.kernel.org>; Wed, 25 Oct 2023 01:18:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE31184E2F;
	Wed, 25 Oct 2023 01:18:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BE31184E2F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ECPu+pnH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dtSarWz4rEeO; Wed, 25 Oct 2023 01:18:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2EB8784E2B;
	Wed, 25 Oct 2023 01:18:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2EB8784E2B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E307C0071;
	Wed, 25 Oct 2023 01:18:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A93CC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 01:18:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 332344347F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 01:18:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 332344347F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ECPu+pnH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pJpUuVxALaU7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 01:18:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C2526418CD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 01:18:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C2526418CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698196721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6+sYLcUznLWz6ItrEA9/mdy00grfjauD3njlab1BHl8=;
 b=ECPu+pnH/axnjzG9JxqGNVPDwDw+xLjvuoRMfJcw0OcuIJN2vFyjVCC4+faznx8HhhO7Ut
 VlQDjXC3LQsCeZqRrihAZxQwvfgW/vhopakwv/Umk8cr7VL4I4Jm7kj8jna9e3iRv6Y+kd
 brGmqPHq9N9CXSkFQMbcvid7OsuS0Mc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-RWKdoBl2N0KIXfAKqoTDXQ-1; Tue, 24 Oct 2023 21:18:40 -0400
X-MC-Unique: RWKdoBl2N0KIXfAKqoTDXQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-507c8a8e5d1so5484224e87.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 18:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698196719; x=1698801519;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6+sYLcUznLWz6ItrEA9/mdy00grfjauD3njlab1BHl8=;
 b=k0RK8td4fqOIknKkFpyqGZXBO0tVkvZSt8ehxXDURdHLltmnuVkYbBVsgXyPwpI7tQ
 VTFFtxsp8TO4m7tpZK4toy66xpQUXcSEmcc5zzmsyXuchtg3I7g/bp100nv4WXjDpBhF
 mwYN324hKcsdAQ14jBdtYyurJNVLLNhp1kcIidd7sRCdcOj29cSvsnNGbSfIuOBrwHfH
 LtMF8qlXuje/AEau5hm0P4Bf/eflzV4LFOQe6jfyprs0bCEgLYLNDLF/ikHcgVaPBMRX
 AoIvz+7Irv0AB1qG2ATp/J+QoYpHmSAHJAXiKi/Q6iAh0sd0M3bJPmqq9FWAj8CJoY9y
 63Qw==
X-Gm-Message-State: AOJu0Yz+O2znA0cAXwTN57K5aB/WZfbEp+u4nvr+Qfvv1BRtnq5fPsQ0
 /RYjBg/kAr8r/HhWs7m0x8/gklI33d6IxsrKfZPj9k7X1z7E3lu6AgwskkjsDvr5fnlMr4kPH+j
 PzRJXl6lksBRnbo3d4YbrwxnuxteIUvg146aDAwWKsv41ML1XwmOUm0/ySg==
X-Received: by 2002:a05:6512:2098:b0:4fe:ecd:4950 with SMTP id
 t24-20020a056512209800b004fe0ecd4950mr8324354lfr.1.1698196718834; 
 Tue, 24 Oct 2023 18:18:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHw4xiciGsLWrc8jU7nWVlxCfaJXZLHo7Wgqcioh9NM4+EkVTjHFntGoxrq0EFHdcfAj2XvFbsBZLNlWPys+h8=
X-Received: by 2002:a05:6512:2098:b0:4fe:ecd:4950 with SMTP id
 t24-20020a056512209800b004fe0ecd4950mr8324332lfr.1.1698196718401; Tue, 24 Oct
 2023 18:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697093455.git.hengqi@linux.alibaba.com>
 <CACGkMEthktJjPdptHo3EDQxjRqdPELOSbMw4k-d0MyYmR4i9KA@mail.gmail.com>
 <d215566f-8185-463b-aa0b-5925f2a0853c@linux.alibaba.com>
In-Reply-To: <d215566f-8185-463b-aa0b-5925f2a0853c@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 25 Oct 2023 09:18:27 +0800
Message-ID: <CACGkMEseRoUBHOJ2CgPqVe=HNkAJqdj+Sh3pWsRaPCvcjwD9Gw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/5] virtio-net: support dynamic coalescing
 moderation
To: Heng Qi <hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Liu, Yujie" <yujie.liu@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

T24gVHVlLCBPY3QgMjQsIDIwMjMgYXQgODowM+KAr1BNIEhlbmcgUWkgPGhlbmdxaUBsaW51eC5h
bGliYWJhLmNvbT4gd3JvdGU6Cj4KPgo+Cj4g5ZyoIDIwMjMvMTAvMTIg5LiL5Y2INDoyOSwgSmFz
b24gV2FuZyDlhpnpgZM6Cj4gPiBPbiBUaHUsIE9jdCAxMiwgMjAyMyBhdCAzOjQ04oCvUE0gSGVu
ZyBRaSA8aGVuZ3FpQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+PiBOb3csIHZpcnRpby1u
ZXQgYWxyZWFkeSBzdXBwb3J0cyBwZXItcXVldWUgbW9kZXJhdGlvbiBwYXJhbWV0ZXIKPiA+PiBz
ZXR0aW5nLiBCYXNlZCBvbiB0aGlzLCB3ZSB1c2UgdGhlIG5ldGRpbSBsaWJyYXJ5IG9mIGxpbnV4
IHRvIHN1cHBvcnQKPiA+PiBkeW5hbWljIGNvYWxlc2NpbmcgbW9kZXJhdGlvbiBmb3IgdmlydGlv
LW5ldC4KPiA+Pgo+ID4+IER1ZSB0byBoYXJkd2FyZSBzY2hlZHVsaW5nIGlzc3Vlcywgd2Ugb25s
eSB0ZXN0ZWQgcnggZGltLgo+ID4gRG8geW91IGhhdmUgUFBTIG51bWJlcnM/IEFuZCBUWCBudW1i
ZXJzIGFyZSBhbHNvIGltcG9ydGFudCBhcyB0aGUKPiA+IHRocm91Z2hwdXQgY291bGQgYmUgbWlz
bGVhZGluZyBkdWUgdG8gdmFyaW91cyByZWFzb25zLgo+Cj4gSGkgSmFzb24hCj4KPiBUaGUgY29t
cGFyaXNvbiBvZiByeCBuZXRkaW0gcGVyZm9ybWFuY2UgaXMgYXMgZm9sbG93czoKPiAodGhlIGJh
Y2tlbmQgc3VwcG9ydGluZyB0eCBkaW0gaXMgbm90IHlldCByZWFkeSkKClRoYW5rcyBhIGxvdCBm
b3IgdGhlIG51bWJlcnMuCgpJJ2Qgc3RpbGwgZXhwZWN0IHRoZSBUWCByZXN1bHQgYXMgSSBkaWQg
cGxheSB0eCBpbnRlcnJ1cHQgY29hbGVzY2luZwphYm91dCAxMCB5ZWFycyBhZ28uCgpJIHdpbGwg
c3RhcnQgdG8gcmV2aWV3IHRoZSBzZXJpZXMgYnV0IGxldCdzIHRyeSB0byBoYXZlIHNvbWUgVFgg
bnVtYmVycyBhcyB3ZWxsLgoKQnR3LCBpdCB3b3VsZCBiZSBtb3JlIGNvbnZlbmllbnQgdG8gaGF2
ZSBhIHJhdyBQUFMgYmVuY2htYXJrLiBFLmcgeW91CmNhbiB0cnkgdG8gdXNlIGEgc29mdHdhcmUg
b3IgaGFyZHdhcmUgcGFja2V0IGdlbmVyYXRvci4KClRoYW5rcwoKPgo+Cj4gSS4gU29ja3BlcmYg
VURQCj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+
IDEuIEVudgo+IHJ4cV8wIGlzIGFmZmluaXR5IHRvIGNwdV8wCj4KPiAyLiBDbWQKPiBjbGllbnQ6
ICB0YXNrc2V0IC1jIDAgc29ja3BlcmYgdHAgLXAgODk4OSAtaSAkSVAgLXQgMTAgLW0gMTZCCj4g
c2VydmVyOiB0YXNrc2V0IC1jIDAgc29ja3BlcmYgc3IgLXAgODk4OQo+Cj4gMy4gUmVzdWx0Cj4g
ZGltIG9mZjogMTE0MzI3Ny4wMCByeHBwcywgdGhyb3VnaHB1dCAxNy44NDQgTUJwcywgY3B1IGlz
IDEwMCUuCj4gZGltIG9uOiAxMTI0MTYxLjAwIHJ4cHBzLCB0aHJvdWdocHV0IDE3LjYxMCBNQnBz
LCBjcHUgaXMgODMuNSUuCj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQo+Cj4KPiBJSS4gUmVkaXMKPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09Cj4gMS4gRW52Cj4gVGhlcmUgYXJlIDggcnhxcyBhbmQgcnhx
X2kgaXMgYWZmaW5pdHkgdG8gY3B1X2kuCj4KPiAyLiBSZXN1bHQKPiBXaGVuIGFsbCBjcHVzIGFy
ZSAxMDAlLCBvcHMvc2VjIG9mIG1lbXRpZXJfYmVuY2htYXJrIGNsaWVudCBpcwo+IGRpbSBvZmY6
ICAgOTc4NDM3LjIzCj4gZGltIG9uOiAxMTQzNjM4LjI4Cj4gPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+Cj4KPiBJSUkuIE5naW54Cj4gPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+IDEuIEVudgo+IFRoZXJl
IGFyZSA4IHJ4cXMgYW5kIHJ4cV9pIGlzIGFmZmluaXR5IHRvIGNwdV9pLgo+Cj4gMi4gUmVzdWx0
Cj4gV2hlbiBhbGwgY3B1cyBhcmUgMTAwJSwgcmVxdWVzdHMvc2VjIG9mIHdyayBjbGllbnQgaXMK
PiBkaW0gb2ZmOiAgIDg3NzkzMS42Nwo+IGRpbSBvbjogMTAxOTE2MC4zMQo+ID09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPgo+IFRoYW5rcyEKPgo+ID4K
PiA+IFRoYW5rcwo+ID4KPiA+PiBAVGVzdCBlbnYKPiA+PiByeHEwIGhhcyBhZmZpbml0eSB0byBj
cHUwLgo+ID4+Cj4gPj4gQFRlc3QgY21kCj4gPj4gY2xpZW50OiB0YXNrc2V0IC1jIDAgc29ja3Bl
cmYgdHAgLWkgJHtJUH0gLXQgMzAgLS10Y3AgLW0gJHttc2dfc2l6ZX0KPiA+PiBzZXJ2ZXI6IHRh
c2tzZXQgLWMgMCBzb2NrcGVyZiBzciAtLXRjcAo+ID4+Cj4gPj4gQFRlc3QgcmVzCj4gPj4gVGhl
IHNlY29uZCBjb2x1bW4gaXMgdGhlIHJhdGlvIG9mIHRoZSByZXN1bHQgcmV0dXJuZWQgYnkgY2xp
ZW50Cj4gPj4gd2hlbiByeCBkaW0gaXMgZW5hYmxlZCB0byB0aGUgcmVzdWx0IHJldHVybmVkIGJ5
IGNsaWVudCB3aGVuCj4gPj4gcnggZGltIGlzIGRpc2FibGVkLgo+ID4+ICAgICAgICAgIC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gPj4gICAgICAgICAgfCBtc2dfc2l6
ZSB8ICByeF9kaW09b24gLyByeF9kaW09b2ZmIHwKPiA+PiAgICAgICAgICAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ID4+ICAgICAgICAgIHwgICAxNEIgICAgfCAgICAg
ICAgICsgMyUgICAgICAgICAgICB8Cj4gPj4gICAgICAgICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KPiA+PiAgICAgICAgICB8ICAgMTAwQiAgIHwgICAgICAgICArIDE2
JSAgICAgICAgICAgfAo+ID4+ICAgICAgICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCj4gPj4gICAgICAgICAgfCAgIDUwMEIgICB8ICAgICAgICAgKyAyNSUgICAgICAg
ICAgIHwKPiA+PiAgICAgICAgICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQo+ID4+ICAgICAgICAgIHwgICAxNDAwQiAgfCAgICAgICAgICsgMjglICAgICAgICAgICB8Cj4g
Pj4gICAgICAgICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+PiAg
ICAgICAgICB8ICAgMjA0OEIgIHwgICAgICAgICArIDIyJSAgICAgICAgICAgfAo+ID4+ICAgICAg
ICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gPj4gICAgICAgICAg
fCAgIDQwOTZCICB8ICAgICAgICAgKyA1JSAgICAgICAgICAgIHwKPiA+PiAgICAgICAgICAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ID4+Cj4gPj4gLS0tCj4gPj4gVGhp
cyBwYXRjaCBzZXQgd2FzIHBhcnQgb2YgdGhlIHByZXZpb3VzIG5ldGRpbSBwYXRjaCBzZXRbMV0u
Cj4gPj4gWzFdIHdhcyBzcGxpdCBpbnRvIGEgbWVyZ2VkIGJ1Z2ZpeCBzZXRbMl0gYW5kIHRoZSBj
dXJyZW50IHNldC4KPiA+PiBUaGUgcHJldmlvdXMgcmVsZXZhbnQgY29tbWVudGF0b3JzIGhhdmUg
YmVlbiBDY2VkLgo+ID4+Cj4gPj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIz
MDgxMTA2NTUxMi4yMjE5MC0xLWhlbmdxaUBsaW51eC5hbGliYWJhLmNvbS8KPiA+PiBbMl0gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2NvdmVyLjE2OTY3NDU0NTIuZ2l0LmhlbmdxaUBsaW51
eC5hbGliYWJhLmNvbS8KPiA+Pgo+ID4+IEhlbmcgUWkgKDUpOgo+ID4+ICAgIHZpcnRpby1uZXQ6
IHJldHVybnMgd2hldGhlciBuYXBpIGlzIGNvbXBsZXRlCj4gPj4gICAgdmlydGlvLW5ldDogc2Vw
YXJhdGUgcngvdHggY29hbGVzY2luZyBtb2RlcmF0aW9uIGNtZHMKPiA+PiAgICB2aXJ0aW8tbmV0
OiBleHRyYWN0IHZpcnRxdWV1ZSBjb2FsZXNjaWcgY21kIGZvciByZXVzZQo+ID4+ICAgIHZpcnRp
by1uZXQ6IHN1cHBvcnQgcnggbmV0ZGltCj4gPj4gICAgdmlydGlvLW5ldDogc3VwcG9ydCB0eCBu
ZXRkaW0KPiA+Pgo+ID4+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMzk0ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDMy
MiBpbnNlcnRpb25zKCspLCA3MiBkZWxldGlvbnMoLSkKPiA+Pgo+ID4+IC0tCj4gPj4gMi4xOS4x
LjYuZ2I0ODU3MTBiCj4gPj4KPiA+Pgo+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
