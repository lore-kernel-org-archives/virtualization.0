Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B06BEB64DD
	for <virtualization@archiver.kernel.org>; Wed,  5 Jul 2023 08:41:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AFB1C60FBE;
	Wed,  5 Jul 2023 08:41:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AFB1C60FBE
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FYfxK6T1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fKUpz6KxFzjD; Wed,  5 Jul 2023 08:41:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0887460FB0;
	Wed,  5 Jul 2023 08:41:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0887460FB0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9925C0072;
	Wed,  5 Jul 2023 08:41:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1878EC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 08:41:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA27F40526
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 08:41:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DA27F40526
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FYfxK6T1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W-q0YqXYYKSO
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 08:41:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A113A404B0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A113A404B0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 08:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688546479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RMcHS+HYh08mQ8rBNMcHYRimEbsxb6yaJnh1Kb3mgQ0=;
 b=FYfxK6T1gDraYjxAZhyiNOOvgs2RLZEKGipfkdDAnExxOG+znph/NzBvWiWzmsg4TEH1Sa
 5jhKjWt5w6okMC1OSLjPxGgm8Xic84lsWKqbjkWrpZ7Wi/A2fxbRXrf/J9Uw0u/P3XOJCz
 GVywlv+iRXXtrTiZnIOmXKMUy20Wnxs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-fp7fROj2P5OIl3SkqA6e4Q-1; Wed, 05 Jul 2023 04:41:18 -0400
X-MC-Unique: fp7fROj2P5OIl3SkqA6e4Q-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3143c9a3519so1505054f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Jul 2023 01:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688546477; x=1691138477;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RMcHS+HYh08mQ8rBNMcHYRimEbsxb6yaJnh1Kb3mgQ0=;
 b=bTlzGWAi6jut+SP1jtcKqbYxeSl9JYII50/6N7IIxMGKeTTJEDeWfyl85SFIVF9FT3
 kJkRBllyP0w2K7TGP76chbLPkUDTI0L4c5P4LUvB3pZuiNTbzRbGCv1HoqzWMuorBbcF
 XIzVEY/oXeLc8cfpq6HVoTXSreYLVjv7joS1EzF+5PxO6qkobh5PfJbrTqiORw9hZyKp
 gpmPElBi8EowRhRn1pWbxksAvCcxw3Z8zd+6nPSnbXaYv4NQKF9F+cduLWGgd5OEBhie
 IS0IoehXuNA2SV8naHHlwUFw5x/9uEhz1xl2DgyJTm3zwQdKlYW5YwL74CwB+zVx6OSh
 GgYQ==
X-Gm-Message-State: ABy/qLbhN6ZAQwkqB3dB+OgHaVlrkx+Wka18eHbdb/UIxZvCHCbx4JZf
 5XzkxvPZ0BdAc5/TB8N/XY+qtP8tWSyk5z9zw6OltjXlIyvV59L/FRFnscDGJtIcevU5PY7WWaA
 5NwitOxo8gzITbv3ew76One/PftIHC85Z/I5NSrKRDQ==
X-Received: by 2002:adf:facd:0:b0:311:110d:5573 with SMTP id
 a13-20020adffacd000000b00311110d5573mr17013459wrs.64.1688546477134; 
 Wed, 05 Jul 2023 01:41:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHYhxj8BmOxwM9GKxq6po7y4so3795albr5tzeL1hNw2jElCVSdO5UxrFnmlOXNJqsKErJ/XQ==
X-Received: by 2002:adf:facd:0:b0:311:110d:5573 with SMTP id
 a13-20020adffacd000000b00311110d5573mr17013442wrs.64.1688546476766; 
 Wed, 05 Jul 2023 01:41:16 -0700 (PDT)
Received: from redhat.com ([2.52.13.33]) by smtp.gmail.com with ESMTPSA id
 c13-20020adfe74d000000b0030ae499da59sm15301643wrn.111.2023.07.05.01.41.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 01:41:16 -0700 (PDT)
Date: Wed, 5 Jul 2023 04:41:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa: reject F_ENABLE_AFTER_DRIVER_OK if backend does
 not support it
Message-ID: <20230705043940-mutt-send-email-mst@kernel.org>
References: <20230703142218.362549-1-eperezma@redhat.com>
 <20230703105022-mutt-send-email-mst@kernel.org>
 <CAJaqyWf2F_yBLBjj1RiPeJ92_zfq8BSMz8Pak2Vg6QinN8jS1Q@mail.gmail.com>
 <20230704063646-mutt-send-email-mst@kernel.org>
 <CAJaqyWfdPpkD5pY4tfzQdOscLBcrDBhBqzWjMbY_ZKsoyiqGdA@mail.gmail.com>
 <20230704114159-mutt-send-email-mst@kernel.org>
 <CACGkMEtWjOMtsbgQ2sx=e1BkuRSyDmVfXDccCm-QSiSbacQyCA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtWjOMtsbgQ2sx=e1BkuRSyDmVfXDccCm-QSiSbacQyCA@mail.gmail.com>
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

T24gV2VkLCBKdWwgMDUsIDIwMjMgYXQgMDM6NDk6NThQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUdWUsIEp1bCA0LCAyMDIzIGF0IDExOjQ14oCvUE0gTWljaGFlbCBTLiBUc2lya2lu
IDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gVHVlLCBKdWwgMDQsIDIwMjMgYXQg
MDE6MzY6MTFQTSArMDIwMCwgRXVnZW5pbyBQZXJleiBNYXJ0aW4gd3JvdGU6Cj4gPiA+IE9uIFR1
ZSwgSnVsIDQsIDIwMjMgYXQgMTI6MzjigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRo
YXQuY29tPiB3cm90ZToKPiA+ID4gPgo+ID4gPiA+IE9uIFR1ZSwgSnVsIDA0LCAyMDIzIGF0IDEy
OjI1OjMyUE0gKzAyMDAsIEV1Z2VuaW8gUGVyZXogTWFydGluIHdyb3RlOgo+ID4gPiA+ID4gT24g
TW9uLCBKdWwgMywgMjAyMyBhdCA0OjUy4oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IE9uIE1vbiwgSnVsIDAzLCAy
MDIzIGF0IDA0OjIyOjE4UE0gKzAyMDAsIEV1Z2VuaW8gUMOpcmV6IHdyb3RlOgo+ID4gPiA+ID4g
PiA+IFdpdGggdGhlIGN1cnJlbnQgY29kZSBpdCBpcyBhY2NlcHRlZCBhcyBsb25nIGFzIHVzZXJs
YW5kIHNlbmQgaXQuCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBBbHRob3VnaCB1c2VybGFu
ZCBzaG91bGQgbm90IHNldCBhIGZlYXR1cmUgZmxhZyB0aGF0IGhhcyBub3QgYmVlbgo+ID4gPiA+
ID4gPiA+IG9mZmVyZWQgdG8gaXQgd2l0aCBWSE9TVF9HRVRfQkFDS0VORF9GRUFUVVJFUywgdGhl
IGN1cnJlbnQgY29kZSB3aWxsIG5vdAo+ID4gPiA+ID4gPiA+IGNvbXBsYWluIGZvciBpdC4KPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IFNpbmNlIHRoZXJlIGlzIG5vIHNwZWNpZmljIHJlYXNv
biBmb3IgYW55IHBhcmVudCB0byByZWplY3QgdGhhdCBiYWNrZW5kCj4gPiA+ID4gPiA+ID4gZmVh
dHVyZSBiaXQgd2hlbiBpdCBoYXMgYmVlbiBwcm9wb3NlZCwgbGV0J3MgY29udHJvbCBpdCBhdCB2
ZHBhIGZyb250ZW5kCj4gPiA+ID4gPiA+ID4gbGV2ZWwuIEZ1dHVyZSBwYXRjaGVzIG1heSBtb3Zl
IHRoaXMgY29udHJvbCB0byB0aGUgcGFyZW50IGRyaXZlci4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiA+IEZpeGVzOiA5Njc4MDBkMmQ1MmUgKCJ2ZHBhOiBhY2NlcHQgVkhPU1RfQkFDS0VORF9G
X0VOQUJMRV9BRlRFUl9EUklWRVJfT0sgYmFja2VuZCBmZWF0dXJlIikKPiA+ID4gPiA+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gUGxlYXNlIGRvIHNlbmQgdjMuIEFuZCBhZ2FpbiwgSSBkb24ndCB3
YW50IHRvIHNlbmQgImFmdGVyIGRyaXZlciBvayIgaGFjawo+ID4gPiA+ID4gPiB1cHN0cmVhbSBh
dCBhbGwsIEkgbWVyZ2VkIGl0IGluIG5leHQganVzdCB0byBnaXZlIGl0IHNvbWUgdGVzdGluZy4K
PiA+ID4gPiA+ID4gV2Ugd2FudCBSSU5HX0FDQ0VTU19BRlRFUl9LSUNLIG9yIHNvbWUgc3VjaC4K
PiA+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBDdXJyZW50IGRldmljZXMgZG8gbm90IHN1
cHBvcnQgdGhhdCBzZW1hbnRpYy4KPiA+ID4gPgo+ID4gPiA+IFdoaWNoIGRldmljZXMgc3BlY2lm
aWNhbGx5IGFjY2VzcyB0aGUgcmluZyBhZnRlciBEUklWRVJfT0sgYnV0IGJlZm9yZQo+ID4gPiA+
IGEga2ljaz8KPiA+ID4gPgo+ID4gPgo+ID4gPiBQcmV2aW91cyB2ZXJzaW9ucyBvZiB0aGUgUUVN
VSBMTSBzZXJpZXMgZGlkIGEgc3B1cmlvdXMga2ljayB0byBzdGFydAo+ID4gPiB0cmFmZmljIGF0
IHRoZSBMTSBkZXN0aW5hdGlvbiBbMV0uIFdoZW4gaXQgd2FzIHByb3Bvc2VkLCB0aGF0IHNwdXJp
b3VzCj4gPiA+IGtpY2sgd2FzIHJlbW92ZWQgZnJvbSB0aGUgc2VyaWVzIGJlY2F1c2UgdG8gY2hl
Y2sgZm9yIGRlc2NyaXB0b3JzCj4gPiA+IGFmdGVyIGRyaXZlcl9vaywgZXZlbiB3aXRob3V0IGEg
a2ljaywgd2FzIGNvbnNpZGVyZWQgd29yayBvZiB0aGUKPiA+ID4gcGFyZW50IGRyaXZlci4KPiA+
ID4KPiA+ID4gSSdtIG9rIHRvIGdvIGJhY2sgdG8gdGhpcyBzcHVyaW91cyBraWNrLCBidXQgSSdt
IG5vdCBzdXJlIGlmIHRoZSBodwo+ID4gPiB3aWxsIHJlYWQgdGhlIHJpbmcgYmVmb3JlIHRoZSBr
aWNrIGFjdHVhbGx5LiBJIGNhbiBhc2suCj4gPiA+Cj4gPiA+IFRoYW5rcyEKPiA+ID4KPiA+ID4g
WzFdIGh0dHBzOi8vbGlzdHMubm9uZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDIz
LTAxL21zZzAyNzc1Lmh0bWwKPiA+Cj4gPiBMZXQncyBmaW5kIG91dC4gV2UgbmVlZCB0byBjaGVj
ayBmb3IgRU5BQkxFX0FGVEVSX0RSSVZFUl9PSyB0b28sIG5vPwo+IAo+IE15IHVuZGVyc3RhbmRp
bmcgaXMgWzFdIGFzc3VtaW5nIEFDQ0VTU19BRlRFUl9LSUNLLiBUaGlzIHNlZW1zCj4gc3ViLW9w
dGltYWwgdGhhbiBhc3N1bWluZyBFTkFCTEVfQUZURVJfRFJJVkVSX09LLgo+IAo+IEJ1dCB0aGlz
IHJlbWluZHMgbWUgb25lIHRoaW5nLCBhcyB0aGUgdGhyZWFkIGlzIGdvaW5nIHRvbyBsb25nLCBJ
Cj4gd29uZGVyIGlmIHdlIHNpbXBseSBhc3N1bWUgRU5BQkxFX0FGVEVSX0RSSVZFUl9PSyBpZiBS
SU5HX1JFU0VUIGlzCj4gc3VwcG9ydGVkPwo+IAo+IFRoYW5rcwoKSSBkb24ndCBzZWUgd2hhdCBk
b2VzIG9uZSBoYXZlIHRvIGRvIHdpdGggYW5vdGhlciAuLi4KCkkgdGhpbmsgd2l0aCBSSU5HX1JF
U0VUIHdlIGhhZCBhbm90aGVyIHNvbHV0aW9uLCBlbmFibGUgcmluZ3MKbWFwcGluZyB0aGVtIHRv
IGEgemVybyBwYWdlLCB0aGVuIHJlc2V0IGFuZCByZS1lbmFibGUgbGF0ZXIuCgo+ID4KPiA+Cj4g
Pgo+ID4gPiA+ID4gTXkgcGxhbiB3YXMgdG8gY29udmVydAo+ID4gPiA+ID4gaXQgaW4gdnBfdmRw
YSBpZiBuZWVkZWQsIGFuZCByZXVzZSB0aGUgY3VycmVudCB2ZHBhIG9wcy4gU29ycnkgaWYgSQo+
ID4gPiA+ID4gd2FzIG5vdCBleHBsaWNpdCBlbm91Z2guCj4gPiA+ID4gPgo+ID4gPiA+ID4gVGhl
IG9ubHkgc29sdXRpb24gSSBjYW4gc2VlIHRvIHRoYXQgaXMgdG8gdHJhcCAmIGVtdWxhdGUgaW4g
dGhlIHZkcGEKPiA+ID4gPiA+IChwYXJlbnQ/KSBkcml2ZXIsIGFzIHRhbGtlZCBpbiB2aXJ0aW8t
Y29tbWVudC4gQnV0IHRoYXQgY29tcGxpY2F0ZXMKPiA+ID4gPiA+IHRoZSBhcmNoaXRlY3R1cmU6
Cj4gPiA+ID4gPiAqIE9mZmVyIFZIT1NUX0JBQ0tFTkRfRl9SSU5HX0FDQ0VTU19BRlRFUl9LSUNL
Cj4gPiA+ID4gPiAqIFN0b3JlIHZxIGVuYWJsZSBzdGF0ZSBzZXBhcmF0ZWx5LCBhdAo+ID4gPiA+
ID4gdmRwYS0+Y29uZmlnLT5zZXRfdnFfcmVhZHkodHJ1ZSksIGJ1dCBub3QgdHJhbnNtaXQgdGhh
dCBlbmFibGUgdG8gaHcKPiA+ID4gPiA+ICogU3RvcmUgdGhlIGRvb3JiZWxsIHN0YXRlIHNlcGFy
YXRlbHksIGJ1dCBkbyBub3QgY29uZmlndXJlIGl0IHRvIHRoZQo+ID4gPiA+ID4gZGV2aWNlIGRp
cmVjdGx5Lgo+ID4gPiA+ID4KPiA+ID4gPiA+IEJ1dCBob3cgdG8gcmVjb3ZlciBpZiB0aGUgZGV2
aWNlIGNhbm5vdCBjb25maWd1cmUgdGhlbSBhdCBraWNrIHRpbWUsCj4gPiA+ID4gPiBmb3IgZXhh
bXBsZT8KPiA+ID4gPiA+Cj4gPiA+ID4gPiBNYXliZSB3ZSBjYW4ganVzdCBmYWlsIGlmIHRoZSBw
YXJlbnQgZHJpdmVyIGRvZXMgbm90IHN1cHBvcnQgZW5hYmxpbmcKPiA+ID4gPiA+IHRoZSB2cSBh
ZnRlciBEUklWRVJfT0s/IFRoYXQgd2F5IG5vIG5ldyBmZWF0dXJlIGZsYWcgaXMgbmVlZGVkLgo+
ID4gPiA+ID4KPiA+ID4gPiA+IFRoYW5rcyEKPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+ID4gLS0tCj4gPiA+ID4gPiA+ID4gU2VudCB3aXRoIEZpeGVzOiB0YWcgcG9pbnRpbmcgdG8g
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L21zdAo+ID4gPiA+ID4gPiA+
IGNvbW1pdC4gUGxlYXNlIGxldCBtZSBrbm93IGlmIEkgc2hvdWxkIHNlbmQgYSB2MyBvZiBbMV0g
aW5zdGVhZC4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IFsxXSBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9sa21sLzIwMjMwNjA5MTIxMjQ0LW11dHQtc2VuZC1lbWFpbC1tc3RAa2VybmVsLm9y
Zy9ULwo+ID4gPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4gPiA+ICBkcml2ZXJzL3Zob3N0L3ZkcGEu
YyB8IDcgKysrKystLQo+ID4gPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiA+ID4gPiA+
ID4gPiBpbmRleCBlMWFiZjI5ZmVkNWIuLmE3ZTU1NDM1MjM1MSAxMDA2NDQKPiA+ID4gPiA+ID4g
PiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ID4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMv
dmhvc3QvdmRwYS5jCj4gPiA+ID4gPiA+ID4gQEAgLTY4MSwxOCArNjgxLDIxIEBAIHN0YXRpYyBs
b25nIHZob3N0X3ZkcGFfdW5sb2NrZWRfaW9jdGwoc3RydWN0IGZpbGUgKmZpbGVwLAo+ID4gPiA+
ID4gPiA+ICB7Cj4gPiA+ID4gPiA+ID4gICAgICAgc3RydWN0IHZob3N0X3ZkcGEgKnYgPSBmaWxl
cC0+cHJpdmF0ZV9kYXRhOwo+ID4gPiA+ID4gPiA+ICAgICAgIHN0cnVjdCB2aG9zdF9kZXYgKmQg
PSAmdi0+dmRldjsKPiA+ID4gPiA+ID4gPiArICAgICBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdf
b3BzICpvcHMgPSB2LT52ZHBhLT5jb25maWc7Cj4gPiA+ID4gPiA+ID4gICAgICAgdm9pZCBfX3Vz
ZXIgKmFyZ3AgPSAodm9pZCBfX3VzZXIgKilhcmc7Cj4gPiA+ID4gPiA+ID4gICAgICAgdTY0IF9f
dXNlciAqZmVhdHVyZXAgPSBhcmdwOwo+ID4gPiA+ID4gPiA+IC0gICAgIHU2NCBmZWF0dXJlczsK
PiA+ID4gPiA+ID4gPiArICAgICB1NjQgZmVhdHVyZXMsIHBhcmVudF9mZWF0dXJlcyA9IDA7Cj4g
PiA+ID4gPiA+ID4gICAgICAgbG9uZyByID0gMDsKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
ICAgICAgIGlmIChjbWQgPT0gVkhPU1RfU0VUX0JBQ0tFTkRfRkVBVFVSRVMpIHsKPiA+ID4gPiA+
ID4gPiAgICAgICAgICAgICAgIGlmIChjb3B5X2Zyb21fdXNlcigmZmVhdHVyZXMsIGZlYXR1cmVw
LCBzaXplb2YoZmVhdHVyZXMpKSkKPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAg
cmV0dXJuIC1FRkFVTFQ7Cj4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICBpZiAob3BzLT5nZXRf
YmFja2VuZF9mZWF0dXJlcykKPiA+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgcGFy
ZW50X2ZlYXR1cmVzID0gb3BzLT5nZXRfYmFja2VuZF9mZWF0dXJlcyh2LT52ZHBhKTsKPiA+ID4g
PiA+ID4gPiAgICAgICAgICAgICAgIGlmIChmZWF0dXJlcyAmIH4oVkhPU1RfVkRQQV9CQUNLRU5E
X0ZFQVRVUkVTIHwKPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
QklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfU1VTUEVORCkgfAo+ID4gPiA+ID4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9SRVNVTUUpIHwK
PiA+ID4gPiA+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQklUX1VMTChWSE9T
VF9CQUNLRU5EX0ZfRU5BQkxFX0FGVEVSX0RSSVZFUl9PSykpKQo+ID4gPiA+ID4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBwYXJlbnRfZmVhdHVyZXMpKQo+ID4gPiA+ID4gPiA+
ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVPUE5PVFNVUFA7Cj4gPiA+ID4gPiA+ID4g
ICAgICAgICAgICAgICBpZiAoKGZlYXR1cmVzICYgQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfU1VT
UEVORCkpICYmCj4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICF2aG9zdF92ZHBhX2Nh
bl9zdXNwZW5kKHYpKQo+ID4gPiA+ID4gPiA+IC0tCj4gPiA+ID4gPiA+ID4gMi4zOS4zCj4gPiA+
ID4gPiA+Cj4gPiA+ID4KPiA+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
