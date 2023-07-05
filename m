Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2115FEB64DA
	for <virtualization@archiver.kernel.org>; Wed,  5 Jul 2023 07:50:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7C60840629;
	Wed,  5 Jul 2023 07:50:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7C60840629
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Dk1UZScp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F7A5M0R2BH4h; Wed,  5 Jul 2023 07:50:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C6D1D400D9;
	Wed,  5 Jul 2023 07:50:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C6D1D400D9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 989C3C0071;
	Wed,  5 Jul 2023 07:50:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D57AC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 07:50:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 49BF5813FF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 07:50:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 49BF5813FF
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Dk1UZScp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vsio1wH8PNFx
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 07:50:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DE7E1813E7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DE7E1813E7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 07:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688543413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y48ulS/+kKO7p+XK2cdnd8+mcOJFtW4xSVJ9cfRLRCc=;
 b=Dk1UZScpk7GtS8sD/qYXhdbRtqkYU700Sfo24LQxvNHFgKAbJH8JlgwhxpgXC5z9PrdO4D
 yjRwOzx6BimeXp3KP4t3APfAf7I0Wl3y8P7JsZDshRH0hKiPaKUqBXspPkhJOMcI6hwNIk
 seLwmfhGxg9UUa8lUbYfdQP85UHYlE8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-SRdh6AREMYq8oFrMlRppgQ-1; Wed, 05 Jul 2023 03:50:12 -0400
X-MC-Unique: SRdh6AREMYq8oFrMlRppgQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-635dd236b63so3230046d6.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Jul 2023 00:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688543412; x=1691135412;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y48ulS/+kKO7p+XK2cdnd8+mcOJFtW4xSVJ9cfRLRCc=;
 b=mIH2p45Bp9BYwL86sL3qq62HfyhJBWFOaS//x8m/WO/Hcb22xiypubakvxUvdxK63K
 FynUR5XQ2UvSVcsJeWa7YSKUilJYiSz8SfPUqMLSOLhP6JPqBGimNlGSaaKUe1bEiST5
 j7Yp7ScPnDwF8MLLIB7iPpBGoAiitlkdPrif8O73u31EzHYYJ2nMS+oAKzGIAo7gS//H
 pKXKeGf8scPDkMYlcoXeXg/qq+B0+Qv9Ty1ulKC8ewDDOVoDv5Ci4eT82+yIZN5IpEQ0
 pacwDt/rKLWXpxJAc9VBopLe9hgGNkPhKK81jnXsqUAb5onRt43xY5QUzkA/ChosXE1B
 /XKA==
X-Gm-Message-State: ABy/qLbRa07/xYCZrtIWvfXl7VHWR7IJbcXGzK/rxKM2EyeL+kYB3p3O
 iXHhbakbpOmqDp49QcPJmoSnkWZwGquxqGMfPwUhXGmvgRn+lMpHWRUJGON4sIZ4aSWuBAJUVpx
 FSiqD4rI7ZEUyqb/GgLnj+z0qhQH933utbRiC+mklaSktJv7UB/wPgDzc5A==
X-Received: by 2002:a0c:f1ca:0:b0:630:14e0:982e with SMTP id
 u10-20020a0cf1ca000000b0063014e0982emr1588308qvl.22.1688543412147; 
 Wed, 05 Jul 2023 00:50:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlECWIUnOY9XKAF+JGyO1WxxEdgi7O/d6naJ/xGAnoeQMVdDnnQISxcvMK2kW8kDBCOg+K1qYyW7lCoiy4kASbU=
X-Received: by 2002:a0c:f1ca:0:b0:630:14e0:982e with SMTP id
 u10-20020a0cf1ca000000b0063014e0982emr1588302qvl.22.1688543411888; Wed, 05
 Jul 2023 00:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230703142218.362549-1-eperezma@redhat.com>
 <20230703105022-mutt-send-email-mst@kernel.org>
 <CAJaqyWf2F_yBLBjj1RiPeJ92_zfq8BSMz8Pak2Vg6QinN8jS1Q@mail.gmail.com>
 <20230704063646-mutt-send-email-mst@kernel.org>
 <CAJaqyWfdPpkD5pY4tfzQdOscLBcrDBhBqzWjMbY_ZKsoyiqGdA@mail.gmail.com>
 <20230704114159-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230704114159-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 5 Jul 2023 15:49:58 +0800
Message-ID: <CACGkMEtWjOMtsbgQ2sx=e1BkuRSyDmVfXDccCm-QSiSbacQyCA@mail.gmail.com>
Subject: Re: [PATCH] vdpa: reject F_ENABLE_AFTER_DRIVER_OK if backend does not
 support it
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

T24gVHVlLCBKdWwgNCwgMjAyMyBhdCAxMTo0NeKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gVHVlLCBKdWwgMDQsIDIwMjMgYXQgMDE6MzY6MTFQ
TSArMDIwMCwgRXVnZW5pbyBQZXJleiBNYXJ0aW4gd3JvdGU6Cj4gPiBPbiBUdWUsIEp1bCA0LCAy
MDIzIGF0IDEyOjM44oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3Jv
dGU6Cj4gPiA+Cj4gPiA+IE9uIFR1ZSwgSnVsIDA0LCAyMDIzIGF0IDEyOjI1OjMyUE0gKzAyMDAs
IEV1Z2VuaW8gUGVyZXogTWFydGluIHdyb3RlOgo+ID4gPiA+IE9uIE1vbiwgSnVsIDMsIDIwMjMg
YXQgNDo1MuKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+
ID4gPiA+ID4KPiA+ID4gPiA+IE9uIE1vbiwgSnVsIDAzLCAyMDIzIGF0IDA0OjIyOjE4UE0gKzAy
MDAsIEV1Z2VuaW8gUMOpcmV6IHdyb3RlOgo+ID4gPiA+ID4gPiBXaXRoIHRoZSBjdXJyZW50IGNv
ZGUgaXQgaXMgYWNjZXB0ZWQgYXMgbG9uZyBhcyB1c2VybGFuZCBzZW5kIGl0Lgo+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiBBbHRob3VnaCB1c2VybGFuZCBzaG91bGQgbm90IHNldCBhIGZlYXR1cmUg
ZmxhZyB0aGF0IGhhcyBub3QgYmVlbgo+ID4gPiA+ID4gPiBvZmZlcmVkIHRvIGl0IHdpdGggVkhP
U1RfR0VUX0JBQ0tFTkRfRkVBVFVSRVMsIHRoZSBjdXJyZW50IGNvZGUgd2lsbCBub3QKPiA+ID4g
PiA+ID4gY29tcGxhaW4gZm9yIGl0Lgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBTaW5jZSB0aGVy
ZSBpcyBubyBzcGVjaWZpYyByZWFzb24gZm9yIGFueSBwYXJlbnQgdG8gcmVqZWN0IHRoYXQgYmFj
a2VuZAo+ID4gPiA+ID4gPiBmZWF0dXJlIGJpdCB3aGVuIGl0IGhhcyBiZWVuIHByb3Bvc2VkLCBs
ZXQncyBjb250cm9sIGl0IGF0IHZkcGEgZnJvbnRlbmQKPiA+ID4gPiA+ID4gbGV2ZWwuIEZ1dHVy
ZSBwYXRjaGVzIG1heSBtb3ZlIHRoaXMgY29udHJvbCB0byB0aGUgcGFyZW50IGRyaXZlci4KPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gRml4ZXM6IDk2NzgwMGQyZDUyZSAoInZkcGE6IGFjY2VwdCBW
SE9TVF9CQUNLRU5EX0ZfRU5BQkxFX0FGVEVSX0RSSVZFUl9PSyBiYWNrZW5kIGZlYXR1cmUiKQo+
ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0
LmNvbT4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBQbGVhc2UgZG8gc2VuZCB2My4gQW5kIGFnYWluLCBJ
IGRvbid0IHdhbnQgdG8gc2VuZCAiYWZ0ZXIgZHJpdmVyIG9rIiBoYWNrCj4gPiA+ID4gPiB1cHN0
cmVhbSBhdCBhbGwsIEkgbWVyZ2VkIGl0IGluIG5leHQganVzdCB0byBnaXZlIGl0IHNvbWUgdGVz
dGluZy4KPiA+ID4gPiA+IFdlIHdhbnQgUklOR19BQ0NFU1NfQUZURVJfS0lDSyBvciBzb21lIHN1
Y2guCj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gQ3VycmVudCBkZXZpY2VzIGRvIG5vdCBzdXBw
b3J0IHRoYXQgc2VtYW50aWMuCj4gPiA+Cj4gPiA+IFdoaWNoIGRldmljZXMgc3BlY2lmaWNhbGx5
IGFjY2VzcyB0aGUgcmluZyBhZnRlciBEUklWRVJfT0sgYnV0IGJlZm9yZQo+ID4gPiBhIGtpY2s/
Cj4gPiA+Cj4gPgo+ID4gUHJldmlvdXMgdmVyc2lvbnMgb2YgdGhlIFFFTVUgTE0gc2VyaWVzIGRp
ZCBhIHNwdXJpb3VzIGtpY2sgdG8gc3RhcnQKPiA+IHRyYWZmaWMgYXQgdGhlIExNIGRlc3RpbmF0
aW9uIFsxXS4gV2hlbiBpdCB3YXMgcHJvcG9zZWQsIHRoYXQgc3B1cmlvdXMKPiA+IGtpY2sgd2Fz
IHJlbW92ZWQgZnJvbSB0aGUgc2VyaWVzIGJlY2F1c2UgdG8gY2hlY2sgZm9yIGRlc2NyaXB0b3Jz
Cj4gPiBhZnRlciBkcml2ZXJfb2ssIGV2ZW4gd2l0aG91dCBhIGtpY2ssIHdhcyBjb25zaWRlcmVk
IHdvcmsgb2YgdGhlCj4gPiBwYXJlbnQgZHJpdmVyLgo+ID4KPiA+IEknbSBvayB0byBnbyBiYWNr
IHRvIHRoaXMgc3B1cmlvdXMga2ljaywgYnV0IEknbSBub3Qgc3VyZSBpZiB0aGUgaHcKPiA+IHdp
bGwgcmVhZCB0aGUgcmluZyBiZWZvcmUgdGhlIGtpY2sgYWN0dWFsbHkuIEkgY2FuIGFzay4KPiA+
Cj4gPiBUaGFua3MhCj4gPgo+ID4gWzFdIGh0dHBzOi8vbGlzdHMubm9uZ251Lm9yZy9hcmNoaXZl
L2h0bWwvcWVtdS1kZXZlbC8yMDIzLTAxL21zZzAyNzc1Lmh0bWwKPgo+IExldCdzIGZpbmQgb3V0
LiBXZSBuZWVkIHRvIGNoZWNrIGZvciBFTkFCTEVfQUZURVJfRFJJVkVSX09LIHRvbywgbm8/CgpN
eSB1bmRlcnN0YW5kaW5nIGlzIFsxXSBhc3N1bWluZyBBQ0NFU1NfQUZURVJfS0lDSy4gVGhpcyBz
ZWVtcwpzdWItb3B0aW1hbCB0aGFuIGFzc3VtaW5nIEVOQUJMRV9BRlRFUl9EUklWRVJfT0suCgpC
dXQgdGhpcyByZW1pbmRzIG1lIG9uZSB0aGluZywgYXMgdGhlIHRocmVhZCBpcyBnb2luZyB0b28g
bG9uZywgSQp3b25kZXIgaWYgd2Ugc2ltcGx5IGFzc3VtZSBFTkFCTEVfQUZURVJfRFJJVkVSX09L
IGlmIFJJTkdfUkVTRVQgaXMKc3VwcG9ydGVkPwoKVGhhbmtzCgo+Cj4KPgo+ID4gPiA+IE15IHBs
YW4gd2FzIHRvIGNvbnZlcnQKPiA+ID4gPiBpdCBpbiB2cF92ZHBhIGlmIG5lZWRlZCwgYW5kIHJl
dXNlIHRoZSBjdXJyZW50IHZkcGEgb3BzLiBTb3JyeSBpZiBJCj4gPiA+ID4gd2FzIG5vdCBleHBs
aWNpdCBlbm91Z2guCj4gPiA+ID4KPiA+ID4gPiBUaGUgb25seSBzb2x1dGlvbiBJIGNhbiBzZWUg
dG8gdGhhdCBpcyB0byB0cmFwICYgZW11bGF0ZSBpbiB0aGUgdmRwYQo+ID4gPiA+IChwYXJlbnQ/
KSBkcml2ZXIsIGFzIHRhbGtlZCBpbiB2aXJ0aW8tY29tbWVudC4gQnV0IHRoYXQgY29tcGxpY2F0
ZXMKPiA+ID4gPiB0aGUgYXJjaGl0ZWN0dXJlOgo+ID4gPiA+ICogT2ZmZXIgVkhPU1RfQkFDS0VO
RF9GX1JJTkdfQUNDRVNTX0FGVEVSX0tJQ0sKPiA+ID4gPiAqIFN0b3JlIHZxIGVuYWJsZSBzdGF0
ZSBzZXBhcmF0ZWx5LCBhdAo+ID4gPiA+IHZkcGEtPmNvbmZpZy0+c2V0X3ZxX3JlYWR5KHRydWUp
LCBidXQgbm90IHRyYW5zbWl0IHRoYXQgZW5hYmxlIHRvIGh3Cj4gPiA+ID4gKiBTdG9yZSB0aGUg
ZG9vcmJlbGwgc3RhdGUgc2VwYXJhdGVseSwgYnV0IGRvIG5vdCBjb25maWd1cmUgaXQgdG8gdGhl
Cj4gPiA+ID4gZGV2aWNlIGRpcmVjdGx5Lgo+ID4gPiA+Cj4gPiA+ID4gQnV0IGhvdyB0byByZWNv
dmVyIGlmIHRoZSBkZXZpY2UgY2Fubm90IGNvbmZpZ3VyZSB0aGVtIGF0IGtpY2sgdGltZSwKPiA+
ID4gPiBmb3IgZXhhbXBsZT8KPiA+ID4gPgo+ID4gPiA+IE1heWJlIHdlIGNhbiBqdXN0IGZhaWwg
aWYgdGhlIHBhcmVudCBkcml2ZXIgZG9lcyBub3Qgc3VwcG9ydCBlbmFibGluZwo+ID4gPiA+IHRo
ZSB2cSBhZnRlciBEUklWRVJfT0s/IFRoYXQgd2F5IG5vIG5ldyBmZWF0dXJlIGZsYWcgaXMgbmVl
ZGVkLgo+ID4gPiA+Cj4gPiA+ID4gVGhhbmtzIQo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4g
PiAtLS0KPiA+ID4gPiA+ID4gU2VudCB3aXRoIEZpeGVzOiB0YWcgcG9pbnRpbmcgdG8gZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L21zdAo+ID4gPiA+ID4gPiBjb21taXQu
IFBsZWFzZSBsZXQgbWUga25vdyBpZiBJIHNob3VsZCBzZW5kIGEgdjMgb2YgWzFdIGluc3RlYWQu
Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21s
LzIwMjMwNjA5MTIxMjQ0LW11dHQtc2VuZC1lbWFpbC1tc3RAa2VybmVsLm9yZy9ULwo+ID4gPiA+
ID4gPiAtLS0KPiA+ID4gPiA+ID4gIGRyaXZlcnMvdmhvc3QvdmRwYS5jIHwgNyArKysrKy0tCj4g
PiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBh
LmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ID4gPiA+ID4gPiBpbmRleCBlMWFiZjI5ZmVkNWIu
LmE3ZTU1NDM1MjM1MSAxMDA2NDQKPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy92aG9zdC92ZHBh
LmMKPiA+ID4gPiA+ID4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiA+ID4gPiA+ID4gQEAg
LTY4MSwxOCArNjgxLDIxIEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfdW5sb2NrZWRfaW9jdGwo
c3RydWN0IGZpbGUgKmZpbGVwLAo+ID4gPiA+ID4gPiAgewo+ID4gPiA+ID4gPiAgICAgICBzdHJ1
Y3Qgdmhvc3RfdmRwYSAqdiA9IGZpbGVwLT5wcml2YXRlX2RhdGE7Cj4gPiA+ID4gPiA+ICAgICAg
IHN0cnVjdCB2aG9zdF9kZXYgKmQgPSAmdi0+dmRldjsKPiA+ID4gPiA+ID4gKyAgICAgY29uc3Qg
c3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdi0+dmRwYS0+Y29uZmlnOwo+ID4gPiA+ID4g
PiAgICAgICB2b2lkIF9fdXNlciAqYXJncCA9ICh2b2lkIF9fdXNlciAqKWFyZzsKPiA+ID4gPiA+
ID4gICAgICAgdTY0IF9fdXNlciAqZmVhdHVyZXAgPSBhcmdwOwo+ID4gPiA+ID4gPiAtICAgICB1
NjQgZmVhdHVyZXM7Cj4gPiA+ID4gPiA+ICsgICAgIHU2NCBmZWF0dXJlcywgcGFyZW50X2ZlYXR1
cmVzID0gMDsKPiA+ID4gPiA+ID4gICAgICAgbG9uZyByID0gMDsKPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gICAgICAgaWYgKGNtZCA9PSBWSE9TVF9TRVRfQkFDS0VORF9GRUFUVVJFUykgewo+ID4g
PiA+ID4gPiAgICAgICAgICAgICAgIGlmIChjb3B5X2Zyb21fdXNlcigmZmVhdHVyZXMsIGZlYXR1
cmVwLCBzaXplb2YoZmVhdHVyZXMpKSkKPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAg
IHJldHVybiAtRUZBVUxUOwo+ID4gPiA+ID4gPiArICAgICAgICAgICAgIGlmIChvcHMtPmdldF9i
YWNrZW5kX2ZlYXR1cmVzKQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgcGFyZW50
X2ZlYXR1cmVzID0gb3BzLT5nZXRfYmFja2VuZF9mZWF0dXJlcyh2LT52ZHBhKTsKPiA+ID4gPiA+
ID4gICAgICAgICAgICAgICBpZiAoZmVhdHVyZXMgJiB+KFZIT1NUX1ZEUEFfQkFDS0VORF9GRUFU
VVJFUyB8Cj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCSVRfVUxM
KFZIT1NUX0JBQ0tFTkRfRl9TVVNQRU5EKSB8Cj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9SRVNVTUUpIHwKPiA+ID4gPiA+
ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9G
X0VOQUJMRV9BRlRFUl9EUklWRVJfT0spKSkKPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHBhcmVudF9mZWF0dXJlcykpCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm4gLUVPUE5PVFNVUFA7Cj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgaWYg
KChmZWF0dXJlcyAmIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX1NVU1BFTkQpKSAmJgo+ID4gPiA+
ID4gPiAgICAgICAgICAgICAgICAgICAgIXZob3N0X3ZkcGFfY2FuX3N1c3BlbmQodikpCj4gPiA+
ID4gPiA+IC0tCj4gPiA+ID4gPiA+IDIuMzkuMwo+ID4gPiA+ID4KPiA+ID4KPgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
