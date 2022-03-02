Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0E0C433F5
	for <virtualization@archiver.kernel.org>; Wed,  2 Mar 2022 16:49:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00BF5813EE;
	Wed,  2 Mar 2022 16:49:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MlfYODdQzkvI; Wed,  2 Mar 2022 16:49:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 843BA813C9;
	Wed,  2 Mar 2022 16:49:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 550F4C0012;
	Wed,  2 Mar 2022 16:49:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C61A5C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 16:49:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9FA9D813DA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 16:49:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lZGsOZlktIyi
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 16:49:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 77A7B813C9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 16:49:21 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 a5-20020a05600c224500b003832be89f25so1639267wmm.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Mar 2022 08:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=IecOz5iKn2Rc7yD1b1vqfvTpVOYHa2wL2PoxDv2Qr/w=;
 b=VIpMijEI/uc7QRXHd8OO4zobB3xGHjz4KThVMq514TNw8RwXRYNSQBSrVjnHjxY/O3
 l2zH6Fnc4g7cXglDba8qa97Y60BjqOi/08Td2ssOClPjgo2nZjxZ5uM6JK9LNl67aDQX
 gUSqG+T8ucekupVq7KheTANlEi90R6HHLHrmK6xVXJROxoYMuVMd51xKMMPnh2UJLPox
 cVRcZ2YIOo3Y4OzB4SDJuF87jLQ7x42oV9w3qB/s1UXjEkj6bKqen/wgYWVukInOW5g2
 NiTjge+zSAtBPJp5ddERJiqnrLi83eYLRdF2Miz0jbs/TDPeruRJXTDi23qQWPGymHYs
 D9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=IecOz5iKn2Rc7yD1b1vqfvTpVOYHa2wL2PoxDv2Qr/w=;
 b=lbQcfIOAq6zL1v0joOVml9lcMlb0xkpWYAfGTsdyOoAM8XIdz0iCNtE8arvYgCdilO
 qRkAGU2GRT4unuUuFBnZS8n4Dc/3Y2LEDupGXYBjaCApVy2FCelQNjpRexysSeckCuFg
 SuRyoPhYl/V5oycCEefN5Uqy4GDGGChgqgZH4BcKsbQkYVAGKFvNokxeafP5sFu1LkvA
 RQafzCj4XMk1XQ2QW7NCG8vx7+HUBTyHfXXqb+5j5EREAn+8zULbYXxQAH3hDhRZzRrc
 98gEXMQzbdByjg8JYJsCqlZ6v/Jnu76QpZDpT8OboJzVA2mkllh1JeZfkL7vu3+fqeH/
 V/SA==
X-Gm-Message-State: AOAM530Jf5D9xa5xK10RUo1xCtAgxGMdNHsBTz/bRYGmWTQ032ovVjv+
 ixn3ng8/Y+HvRBi/5dZOwHtfaa64CA/w4eXA
X-Google-Smtp-Source: ABdhPJyfbodKVJwvZA9sMWbjL8XK8jIc29C/7YVF8TlsJ7M4ci3plCbQeVXpYLBlRnsDqwXOYk/BBw==
X-Received: by 2002:a1c:4603:0:b0:381:19fe:280b with SMTP id
 t3-20020a1c4603000000b0038119fe280bmr524853wma.67.1646239759465; 
 Wed, 02 Mar 2022 08:49:19 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net.
 [86.27.177.88]) by smtp.gmail.com with ESMTPSA id
 n15-20020a05600c4f8f00b003842f011bc5sm2707823wmq.2.2022.03.02.08.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Mar 2022 08:49:18 -0800 (PST)
Date: Wed, 2 Mar 2022 16:49:17 +0000
From: Lee Jones <lee.jones@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <Yh+gDZUbgBRx/1ro@google.com>
References: <20220302075421.2131221-1-lee.jones@linaro.org>
 <20220302082021-mutt-send-email-mst@kernel.org>
 <Yh93k2ZKJBIYQJjp@google.com>
 <20220302095045-mutt-send-email-mst@kernel.org>
 <Yh+F1gkCGoYF2lMV@google.com>
 <CAGxU2F4cUDrMzoHH1NT5_ivxBPgEE8HOzP5s_Bt5JURRaSsLdQ@mail.gmail.com>
 <20220302112945-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220302112945-mutt-send-email-mst@kernel.org>
Cc: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com,
 kvm <kvm@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
 kernel list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
 Linux Virtualization <virtualization@lists.linux-foundation.org>
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

T24gV2VkLCAwMiBNYXIgMjAyMiwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgoKPiBPbiBXZWQs
IE1hciAwMiwgMjAyMiBhdCAwNToyODozMVBNICswMTAwLCBTdGVmYW5vIEdhcnphcmVsbGEgd3Jv
dGU6Cj4gPiBPbiBXZWQsIE1hciAyLCAyMDIyIGF0IDM6NTcgUE0gTGVlIEpvbmVzIDxsZWUuam9u
ZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4gPiA+Cj4gPiA+IE9uIFdlZCwgMDIgTWFyIDIwMjIsIE1p
Y2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4KPiA+ID4gPiBPbiBXZWQsIE1hciAwMiwgMjAy
MiBhdCAwMTo1NjozNVBNICswMDAwLCBMZWUgSm9uZXMgd3JvdGU6Cj4gPiA+ID4gPiBPbiBXZWQs
IDAyIE1hciAyMDIyLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+
ID4gPiBPbiBXZWQsIE1hciAwMiwgMjAyMiBhdCAwNzo1NDoyMUFNICswMDAwLCBMZWUgSm9uZXMg
d3JvdGU6Cj4gPiA+ID4gPiA+ID4gdmhvc3RfdnNvY2tfaGFuZGxlX3R4X2tpY2soKSBhbHJlYWR5
IGhvbGRzIHRoZSBtdXRleCBkdXJpbmcgaXRzIGNhbGwKPiA+ID4gPiA+ID4gPiB0byB2aG9zdF9n
ZXRfdnFfZGVzYygpLiAgQWxsIHdlIGhhdmUgdG8gZG8gaXMgdGFrZSB0aGUgc2FtZSBsb2NrCj4g
PiA+ID4gPiA+ID4gZHVyaW5nIHZpcnRxdWV1ZSBjbGVhbi11cCBhbmQgd2UgbWl0aWdhdGUgdGhl
IHJlcG9ydGVkIGlzc3Vlcy4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IExpbms6IGh0dHBz
Oi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9leHRpZD0yNzk0MzJkMzBkODI1ZTYzYmEwMAo+
ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPgo+
ID4gPiA+ID4gPiA+IFJlcG9ydGVkLWJ5OiBzeXpib3QrYWRjM2NiMzIzODU1ODZiZWM4NTlAc3l6
a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQo+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IExlZSBK
b25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Cj4gPiA+ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiA+
ID4gIGRyaXZlcnMvdmhvc3Qvdmhvc3QuYyB8IDIgKysKPiA+ID4gPiA+ID4gPiAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+ID4g
PiA+ID4gPiA+IGluZGV4IDU5ZWRiNWExZmZlMjguLmJiYWZmNmE1ZTIxYjggMTAwNjQ0Cj4gPiA+
ID4gPiA+ID4gLS0tIGEvZHJpdmVycy92aG9zdC92aG9zdC5jCj4gPiA+ID4gPiA+ID4gKysrIGIv
ZHJpdmVycy92aG9zdC92aG9zdC5jCj4gPiA+ID4gPiA+ID4gQEAgLTY5Myw2ICs2OTMsNyBAQCB2
b2lkIHZob3N0X2Rldl9jbGVhbnVwKHN0cnVjdCB2aG9zdF9kZXYgKmRldikKPiA+ID4gPiA+ID4g
PiAgICAgICAgIGludCBpOwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gICAgICAgICBmb3Ig
KGkgPSAwOyBpIDwgZGV2LT5udnFzOyArK2kpIHsKPiA+ID4gPiA+ID4gPiArICAgICAgICAgICAg
ICAgbXV0ZXhfbG9jaygmZGV2LT52cXNbaV0tPm11dGV4KTsKPiA+ID4gPiA+ID4gPiAgICAgICAg
ICAgICAgICAgaWYgKGRldi0+dnFzW2ldLT5lcnJvcl9jdHgpCj4gPiA+ID4gPiA+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgZXZlbnRmZF9jdHhfcHV0KGRldi0+dnFzW2ldLT5lcnJvcl9jdHgp
Owo+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICBpZiAoZGV2LT52cXNbaV0tPmtpY2spCj4g
PiA+ID4gPiA+ID4gQEAgLTcwMCw2ICs3MDEsNyBAQCB2b2lkIHZob3N0X2Rldl9jbGVhbnVwKHN0
cnVjdCB2aG9zdF9kZXYgKmRldikKPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgaWYgKGRl
di0+dnFzW2ldLT5jYWxsX2N0eC5jdHgpCj4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgZXZlbnRmZF9jdHhfcHV0KGRldi0+dnFzW2ldLT5jYWxsX2N0eC5jdHgpOwo+ID4gPiA+
ID4gPiA+ICAgICAgICAgICAgICAgICB2aG9zdF92cV9yZXNldChkZXYsIGRldi0+dnFzW2ldKTsK
PiA+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZkZXYtPnZxc1tpXS0+
bXV0ZXgpOwo+ID4gPiA+ID4gPiA+ICAgICAgICAgfQo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBT
byB0aGlzIGlzIGEgbWl0aWdhdGlvbiBwbGFuIGJ1dCB0aGUgYnVnIGlzIHN0aWxsIHRoZXJlIHRo
b3VnaAo+ID4gPiA+ID4gPiB3ZSBkb24ndCBrbm93IGV4YWN0bHkgd2hhdCBpdCBpcy4gIEkgd291
bGQgcHJlZmVyIGFkZGluZyBzb21ldGhpbmcgbGlrZQo+ID4gPiA+ID4gPiBXQVJOX09OKG11dGV4
X2lzX2xvY2tlZCh2cXNbaV0tPm11dGV4KSBoZXJlIC0gZG9lcyB0aGlzIG1ha2Ugc2Vuc2U/Cj4g
PiA+ID4gPgo+ID4gPiA+ID4gQXMgYSByZXdvcmsgdG8gdGhpcywgb3IgYXMgYSBzdWJzZXF1ZW50
IHBhdGNoPwo+ID4gPiA+Cj4gPiA+ID4gQ2FuIGJlIGEgc2VwYXJhdGUgcGF0Y2guCj4gPiA+ID4K
PiA+ID4gPiA+IEp1c3QgYmVmb3JlIHRoZSBmaXJzdCBsb2NrIEkgYXNzdW1lPwo+ID4gPiA+Cj4g
PiA+ID4gSSBndWVzcyBzbywgeWVzLgo+ID4gPgo+ID4gPiBObyBwcm9ibGVtLiAgUGF0Y2ggdG8g
Zm9sbG93Lgo+ID4gPgo+ID4gPiBJJ20gYWxzbyBnb2luZyB0byBhdHRlbXB0IHRvIGRlYnVnIHRo
ZSByb290IGNhdXNlLCBidXQgSSdtIG5ldyB0byB0aGlzCj4gPiA+IHN1YnN5c3RlbSB0byBpdCBt
aWdodCB0YWtlIGEgd2hpbGUgZm9yIG1lIHRvIGdldCBteSBoZWFkIGFyb3VuZC4KPiA+IAo+ID4g
SUlVQyB0aGUgcm9vdCBjYXVzZSBzaG91bGQgYmUgdGhlIHNhbWUgYXMgdGhlIG9uZSB3ZSBzb2x2
ZWQgaGVyZToKPiA+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwv
Z2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPWE1OGRhNTNmZmQ3MDI5NGViZWE4ZWNk
MGViNDVmZDBkNzRhZGQ5ZjkKPiA+IAo+ID4gVGhlIHdvcmtlciB3YXMgbm90IHN0b3BwZWQgYmVm
b3JlIGNhbGxpbmcgdmhvc3RfZGV2X2NsZWFudXAoKS4gU28gd2hpbGUgCj4gPiB0aGUgd29ya2Vy
IHdhcyBzdGlsbCBydW5uaW5nIHdlIHdlcmUgZ29pbmcgdG8gZnJlZSBtZW1vcnkgb3IgaW5pdGlh
bGl6ZSAKPiA+IGZpZWxkcyB3aGlsZSBpdCB3YXMgc3RpbGwgdXNpbmcgdmlydHF1ZXVlLgo+IAo+
IFJpZ2h0LCBhbmQgSSBhZ3JlZSBidXQgaXQncyBub3QgdGhlIHJvb3QgdGhvdWdoLCB3ZSBkbyBh
dHRlbXB0IHRvIHN0b3AgYWxsIHdvcmtlcnMuCgpFeGFjdGx5LiAgVGhpcyBpcyB3aGF0IGhhcHBl
bnMsIGJ1dCB0aGUgcXVlc3Rpb24gSSdtIGdvaW5nIHRvIGF0dGVtcHQKdG8gYW5zd2VyIGlzICp3
aHkqIGRvZXMgdGhpcyBoYXBwZW4uCgotLSAKTGVlIEpvbmVzIFvmnY7nkLzmlq9dClByaW5jaXBh
bCBUZWNobmljYWwgTGVhZCAtIERldmVsb3BlciBTZXJ2aWNlcwpMaW5hcm8ub3JnIOKUgiBPcGVu
IHNvdXJjZSBzb2Z0d2FyZSBmb3IgQXJtIFNvQ3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBU
d2l0dGVyIHwgQmxvZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
