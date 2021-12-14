Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDF2C433F5
	for <virtualization@archiver.kernel.org>; Tue, 14 Dec 2021 06:15:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7FD06405D6;
	Tue, 14 Dec 2021 06:15:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3fnZHUCYzhXI; Tue, 14 Dec 2021 06:15:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DFB55405AA;
	Tue, 14 Dec 2021 06:15:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B31EBC002F;
	Tue, 14 Dec 2021 06:15:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7D34C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 06:15:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 87DA781384
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 06:15:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id od88f84Rncv9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 06:15:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3079181382
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 06:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639462513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YwugZBIsB9O3b1tEKG2yDl1lfnlqxf61JgJVJ0aWmUQ=;
 b=Vk2++8tnyfBAP4YnUTj+Dm5WH1aP9yxSgCu5lPLv1iQisZFEJ2QU8AzLsldHM9XQfP9/9n
 XNGMvo2VNxTwqU5KzsEsfCqp2/+vFGpmTrQXyixte8IlX9VFVihFgMwc1AR/Gkb6chkcpz
 2RprZaKhno5bxeXV2GS95msHLpFksbE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-361-mTxwF0aSO_iRYixnqsKGaw-1; Tue, 14 Dec 2021 01:15:11 -0500
X-MC-Unique: mTxwF0aSO_iRYixnqsKGaw-1
Received: by mail-lf1-f71.google.com with SMTP id
 e5-20020ac25ca5000000b0041bf2d8f2e1so8527441lfq.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 22:15:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YwugZBIsB9O3b1tEKG2yDl1lfnlqxf61JgJVJ0aWmUQ=;
 b=C1H9XZ7R9V9tWGCPLIqWZpz0+m7XbgZ+Y7ZQETZOUU1MXSkwe1jsXq3pn+Xqoc1g91
 cMs+Vb/zgA4GwHUoatA38l4L4z6uwMLyRWQup/Ke4Xo7YglgIyC50JK3C3k/SONS3UeQ
 rBsk0l9ScQ4r7201GEgli+kIdrFptJtM3AjIokPFcbTQJjprFC5PHCkbdlrGq/czyNf/
 LJZtJ+RePqQDb6RLuV+Euii370NVv67oh6R2ToYRHM2eZeemIS+nLVfDx57t0bXqyAGA
 I4ABPTsSMaGYTmFn2ALvHXp4Bv5PQ3JzUUP9hsJ8hVTpzaH8e39QU+HDNurtW7iTSA7R
 cxFA==
X-Gm-Message-State: AOAM533S6e12HZ1zR6eeJyxeMLzcFilbK/jMqnoHfflNOXSr2hJZlYhu
 0DoyUjS3BcyfxBMpC8GyLvDoHdAB8RkVf7z6PQYoWse8nGnPxy1e4DeMDO6AsFCY1fl3jmC32pd
 GaBrhloFB8WNE50VhMA66ueioXozvLL4/kU+F9ZTzAzj+AJxdYs6Ej3BVvw==
X-Received: by 2002:a2e:3012:: with SMTP id w18mr2978399ljw.217.1639462510174; 
 Mon, 13 Dec 2021 22:15:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwqenw88BrR2D6Qt+sGpTwBW3+xZwJrfzDxCVORbTErFH0MhwcnexNkpqOBvtu367RvJ0qUvX4Rn9Ui+iPKu5s=
X-Received: by 2002:a2e:3012:: with SMTP id w18mr2978375ljw.217.1639462509908; 
 Mon, 13 Dec 2021 22:15:09 -0800 (PST)
MIME-Version: 1.0
References: <20211213045012.12757-1-mengensun@tencent.com>
 <CACGkMEtLso8QjvmjTQ=S_bbGxu11O_scRa8GT7z6MXfJbfzfRg@mail.gmail.com>
 <CACGkMEukGbDcxJe3nGFkeBNenniJdMkFMRnrN4OOfDsCb7ZPuA@mail.gmail.com>
 <CA+K-gpUBSB0_gX2r7Xi7b6SxrbQApNpneQu_bLAR+e1ALOUwYw@mail.gmail.com>
In-Reply-To: <CA+K-gpUBSB0_gX2r7Xi7b6SxrbQApNpneQu_bLAR+e1ALOUwYw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Dec 2021 14:14:59 +0800
Message-ID: <CACGkMEtMcU6f+AD6+_cKuDpLTFgaBJura39j16PnKqGWB2fULA@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: make copy len check in xdp_linearize_page
To: =?UTF-8?B?5a2Z6JKZ5oGp?= <mengensun8801@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: MengLong Dong <imagedong@tencent.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev <netdev@vger.kernel.org>,
 mengensun <mengensun@tencent.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 ZhengXiong Jiang <mungerjiang@tencent.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 davem <davem@davemloft.net>, linux-kernel <linux-kernel@vger.kernel.org>
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

T24gVHVlLCBEZWMgMTQsIDIwMjEgYXQgMTE6NDggQU0g5a2Z6JKZ5oGpIDxtZW5nZW5zdW44ODAx
QGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiDk
uo4yMDIx5bm0MTLmnIgxNOaXpeWRqOS6jCAxMToxM+WGmemBk++8mgo+ID4KPiA+IE9uIE1vbiwg
RGVjIDEzLCAyMDIxIGF0IDU6MTQgUE0g5a2Z6JKZ5oGpIDxtZW5nZW5zdW44ODAxQGdtYWlsLmNv
bT4gd3JvdGU6Cj4gPiA+Cj4gPiA+IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IOS6
jjIwMjHlubQxMuaciDEz5pel5ZGo5LiAIDE1OjQ55YaZ6YGT77yaCj4gPiA+ID4KPiA+ID4gPiBP
biBNb24sIERlYyAxMywgMjAyMSBhdCAxMjo1MCBQTSA8bWVuZ2Vuc3VuODgwMUBnbWFpbC5jb20+
IHdyb3RlOgo+ID4gPiA+ID4KPiA+ID4gPiA+IEZyb206IG1lbmdlbnN1biA8bWVuZ2Vuc3VuQHRl
bmNlbnQuY29tPgo+ID4gPiA+ID4KPiA+ID4gPiA+IHhkcF9saW5lYXJpemVfcGFnZSBhc3VtZSBy
aW5nIGVsZW0gc2l6ZSBpcyBzbWFsbGVyIHRoZW4gcGFnZSBzaXplCj4gPiA+ID4gPiB3aGVuIGNv
cHkgdGhlIGZpcnN0IHJpbmcgZWxlbSwgYnV0LCB0aGVyZSBtYXkgYmUgYSBlbGVtIHNpemUgYmln
Z2VyCj4gPiA+ID4gPiB0aGVuIHBhZ2Ugc2l6ZS4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBhZGRfcmVj
dmJ1Zl9tZXJnZWFibGUgbWF5IGFkZCBhIGhvbGUgdG8gcmluZyBlbGVtLCB0aGUgaG9sZSBzaXpl
IGlzCj4gPiA+ID4gPiBub3Qgc3VyZSwgYWNjb3JkaW5nIEVXTUEuCj4gPiA+ID4KPiA+ID4gPiBU
aGUgbG9naWMgaXMgdG8gdHJ5IHRvIGF2b2lkIGRyb3BwaW5nIHBhY2tldHMgaW4gdGhpcyBjYXNl
LCBzbyBJCj4gPiA+ID4gd29uZGVyIGlmIGl0J3MgYmV0dGVyIHRvICJmaXgiIHRoZSBhZGRfcmVj
dmJ1Zl9tZXJnZWFibGUoKS4KPiA+ID4KPiA+Cj4gPiBBZGRpbmcgbGlzdHMgYmFjay4KPiA+Cj4g
PiA+IHR1cm4gdG8gWERQIGdlbmVyaWMgaXMgc28gZGlmZmljdWx0eSBmb3IgbWUsIGhlcmUgY2Fu
ICJmaXgiIHRoZQo+ID4gPiBhZGRfcmVjdmJ1Zl9tZXJnZWFibGUgbGluayBmb2xsb3c6Cj4gPiA+
IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiArKysgYi9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMKPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBi
L2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiBpbmRleCAzNmE0YjdjMTk1ZDUuLjA2Y2U4
YmIxMGI0NyAxMDA2NDQKPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+
ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiBAQCAtMTMxNSw2ICsxMzE1LDcg
QEAgc3RhdGljIGludCBhZGRfcmVjdmJ1Zl9tZXJnZWFibGUoc3RydWN0IHZpcnRuZXRfaW5mbyAq
dmksCj4gPiA+ICAgICAgICAgICAgICAgICBhbGxvY19mcmFnLT5vZmZzZXQgKz0gaG9sZTsKPiA+
ID4gICAgICAgICB9Cj4gPiA+ICsgICAgICAgbGVuID0gbWluKGxlbiwgUEFHRV9TSVpFIC0gcm9v
bSk7Cj4gPiA+ICAgICAgICAgc2dfaW5pdF9vbmUocnEtPnNnLCBidWYsIGxlbik7Cj4gPiA+ICAg
ICAgICAgY3R4ID0gbWVyZ2VhYmxlX2xlbl90b19jdHgobGVuLCBoZWFkcm9vbSk7Cj4gPgo+ID4g
VGhlbiB0aGUgdHJ1ZXNpemUgaGVyZSBpcyB3cm9uZy4KPiBtYW55IHRoYW5rcyEhIGkgaGF2ZSAg
a25vd24gaSdtIHdyb25nIGltbWVkaWF0ZWx5IGFmdGVyIGNsaWNrIHRoZQo+ICJzZW5kIiBib3R0
b24gLCBub3csIHRoaXMgcHJvYmxlbSBzZWVtIG5vdCBvbmx5IGFib3V0IHRoZSAqaG9sZSogYnV0
Cj4gdGhlICBFV01BLCBFV01BIHdpbGwgZ2l2ZSBidWZmIGxlbiBiZXd0ZWVuIG1pbl9idWZfbGVu
IGFuZCBQQUdFX1NJWkUsCj4gd2hpbGUgc3dpdGggZnJvbSBuby1hdHRhY2gteGRwIHRvIGF0dGFj
aCB4ZHAsIHRoZXJlIG1heSBiZSBzb21lIGJ1ZmYKPiBhbHJlYWR5IGluIHJpbmcgYW5kIGZpbGxl
ZCBiZWZvcmUgeGRwIGF0dGFjaC4geGRwX2xpbmVhcml6ZV9wYWdlCj4gYXNzdW1lIGJ1ZiBzaXpl
IGlzIFBBR0VfU0laRSAtIFZJUlRJT19YRFBfSEVBRFJPT00sIGFuZCBjb3BlZCAibGVuIgo+IGZy
b20gdGhlIGJ1ZmYsIHdoaWxlIHRoZSBidWZmIG1heSBiZSAqKlBBR0VfU0laRSoqCgpTbyB0aGUg
aXNzdWUgSSBzZWUgaXMgdGhhdCB0aG91Z2ggYWRkX3JlY3ZidWZfbWVyZ2VhYmxlKCkgdHJpZXMg
dG8KbWFrZSB0aGUgYnVmZmVyIHNpemUgaXMgUEFHRV9TSVpFLCBYRFAgbWlnaHQgcmVxdWlyZXMg
bW9yZSBvbiB0aGUKaGVhZGVyIHdoaWNoIG1ha2VzIGEgc2luZ2xlIHBhZ2UgaXMgbm90IHN1ZmZp
Y2llbnQuCgo+Cj4gYmVjYXVzZSB3ZSBoYXZlIG5vIGlkZWFyIHdoZW4gdGhlIHVzZXIgYXR0YWNo
IHhkcCBwcm9nLCBzbywgaSBoYXZlIG5vCj4gaWRlYXIgZXhjZXB0IG1ha2UgYWxsIHRoZSBidWZm
IGhhdmUgYSAiaGVhZGVyIGhvbGUiIGxlbiBvZgo+IFZJUlRJT19YRFBfSEVBRFJPT00oMTI4KSwg
YnV0IGl0IHNlZW0gc28gZXhwZW5zaXZlIGZvciBuby14ZHAtYXR0YWNoCj4gdmlydGlvIGV0aCB0
byBhd2F5cyBsZWF2ZSAxMjggYnl0ZSBub3QgdXNlZCBhdCBhbGwuCgpUaGF0J3MgYW4gcmVxdWly
ZW1lbnQgZm9yIFhEUCBoZWFkZXIgYWRqdXN0bWVudCBzbyBmYXIuCgo+Cj4gdGhpcyBwcm9ibGVt
IGlzIGZvdW5kIGJ5IHJldmlldyBjb2RlLCBpbiByZWFsbHkgdGVzdCwgaXQgc2VlbWVkIG5vdCBz
bwo+IG1heSBiaWcgZnJhbWUuIHNvIGhlcmUgd2UgY2FuIGp1c3QgImZpeCIgdGhlICB4ZHBfbGlu
ZWFyaXplX3BhZ2UsIG1ha2UKPiBpdCB0cnlpbmcgYmVzdCB0byBub3QgZHJvcCBmcmFtZXMgZm9y
IG5vdz8KCkkgdGhpbmsgeW91IGNhbiByZXByb2R1Y2UgdGhlIGlzc3VlIGJ5IGtlZXBpbmcgc2Vu
ZGluZyBsYXJnZSBmcmFtZXMgdG8KZ3Vlc3QgYW5kIHRyeSB0byBhdHRhY2ggWERQIGluIHRoZSBt
aWRkbGUuCgo+Cj4gYnR3LCAgaXQgc2VlbSBubyB3YXkgdG8gZml4IHRoaXMgdGhvcm91Z2hseSwg
ZXhjZXB0IHdlIGRyYWluZWQgYWxsIHRoZQo+IGJ1ZmYgaW4gdGhlIHJpbmcsIGFuZCBmbHVzaCBp
dCBhbGwgdG8gInhkcCBidWZmIiB3aGVuIGF0dGFjaGluZyB4ZHAKPiBwcm9nLgo+Cj4gaXMgdGhh
dCBzb21lIG1pc3Rha2UgaSBoYXZlIG1ha2VlZCBhZ2Fpbj8gI15fXgoKSSBzZWUgdHdvIHdheXMg
dG8gc29sdmUgdGhpczoKCjEpIHJldmVyc2UgbW9yZSByb29tIChidXQgbm90IGhlYWRlcnJvb20p
IHRvIG1ha2Ugc3VyZSBQQUdFX1NJWkUgY2FuCndvcmsgaW4gdGhlIGNhc2Ugb2YgbGluZWFyaXpp
bmcKMikgc3dpdGNoIHRvIHVzZSBYRFAgZ2VucmVpYwoKMikgbG9va3MgbXVjaCBtb3JlIGVhc2ll
ciwgeW91IG1heSByZWZlciB0dW5feGRwX29uZSgpIHRvIHNlZSBob3cgaXQKd29ya3MsIGl0J3Mg
YXMgc2ltcGxlIGFzIGNhbGwgZG9feGRwX2dlbmVyaWMoKQoKVGhhbmtzCgo+Cj4gPgo+ID4KPiA+
ID4gICAgICAgICBlcnIgPSB2aXJ0cXVldWVfYWRkX2luYnVmX2N0eChycS0+dnEsIHJxLT5zZywg
MSwgYnVmLCBjdHgsIGdmcCk7Cj4gPiA+Cj4gPiA+IGl0IHNlZW1zIGEgcnVsZSB0aGF0LCBsZW5n
dGggb2YgZWxlbSBnaXZpbmcgdG8gdnJpbmcgaXMgYXdheSBzbWFsbGVyCj4gPiA+IG9yIGVxdWFs
bCB0aGVuIFBBR0VfU0laRQo+ID4KPiA+IEl0IGFpbXMgdG8gYmUgY29uc2lzdGVudCB0byB3aGF0
IEVXTUEgdHJpZXMgdG8gZG86Cj4gPgo+ID4gICAgICAgICBsZW4gPSBoZHJfbGVuICsgY2xhbXBf
dCh1bnNpZ25lZCBpbnQsIGV3bWFfcGt0X2xlbl9yZWFkKGF2Z19wa3RfbGVuKSwKPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgIHJxLT5taW5fYnVmX2xlbiwgUEFHRV9TSVpFIC0gaGRyX2xlbik7
Cj4gPgo+ID4gVGhhbmtzCj4gPgo+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gT3IgYW5vdGhlciBpZGVh
IGlzIHRvIHN3aXRjaCB0byB1c2UgWERQIGdlbmVyaWMgaGVyZSB3aGVyZSB3ZSBjYW4gdXNlCj4g
PiA+ID4gc2tiX2xpbmVhcml6ZSgpIHdoaWNoIHNob3VsZCBiZSBtb3JlIHJvYnVzdCBhbmQgd2Ug
Y2FuIGRyb3AgdGhlCj4gPiA+ID4geGRwX2xpbmVhcml6ZV9wYWdlKCkgbG9naWMgY29tcGxldGVs
eS4KPiA+ID4gPgo+ID4gPiA+IFRoYW5rcwo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4gc28s
IGZpeCBpdCBieSBjaGVjayBjb3B5IGxlbixpZiBjaGVja2VkIGZhaWxlZCwganVzdCBkcm9wcGVk
IHRoZQo+ID4gPiA+ID4gd2hvbGUgZnJhbWUsIG5vdCBtYWtlIHRoZSBtZW1vcnkgZGlydHkgYWZ0
ZXIgdGhlIHBhZ2UuCj4gPiA+ID4gPgo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogbWVuZ2Vuc3Vu
IDxtZW5nZW5zdW5AdGVuY2VudC5jb20+Cj4gPiA+ID4gPiBSZXZpZXdlZC1ieTogTWVuZ0xvbmcg
RG9uZyA8aW1hZ2Vkb25nQHRlbmNlbnQuY29tPgo+ID4gPiA+ID4gUmV2aWV3ZWQtYnk6IFpoZW5n
WGlvbmcgSmlhbmcgPG11bmdlcmppYW5nQHRlbmNlbnQuY29tPgo+ID4gPiA+ID4gLS0tCj4gPiA+
ID4gPiAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgNiArKysrKy0KPiA+ID4gPiA+ICAxIGZp
bGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gPiA+ID4gPgo+ID4g
PiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0
L3ZpcnRpb19uZXQuYwo+ID4gPiA+ID4gaW5kZXggMzZhNGI3YzE5NWQ1Li44NDRiZGJkNjdmZjcg
MTAwNjQ0Cj4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gPiA+
ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiA+ID4gQEAgLTY2Miw4ICs2NjIs
MTIgQEAgc3RhdGljIHN0cnVjdCBwYWdlICp4ZHBfbGluZWFyaXplX3BhZ2Uoc3RydWN0IHJlY2Vp
dmVfcXVldWUgKnJxLAo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaW50IHBhZ2Vfb2ZmLAo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdW5zaWduZWQgaW50ICpsZW4pCj4gPiA+ID4gPiAgewo+ID4gPiA+ID4gLSAg
ICAgICBzdHJ1Y3QgcGFnZSAqcGFnZSA9IGFsbG9jX3BhZ2UoR0ZQX0FUT01JQyk7Cj4gPiA+ID4g
PiArICAgICAgIHN0cnVjdCBwYWdlICpwYWdlOwo+ID4gPiA+ID4KPiA+ID4gPiA+ICsgICAgICAg
aWYgKCpsZW4gPiBQQUdFX1NJWkUgLSBwYWdlX29mZikKPiA+ID4gPiA+ICsgICAgICAgICAgICAg
ICByZXR1cm4gTlVMTDsKPiA+ID4gPiA+ICsKPiA+ID4gPiA+ICsgICAgICAgcGFnZSA9IGFsbG9j
X3BhZ2UoR0ZQX0FUT01JQyk7Cj4gPiA+ID4gPiAgICAgICAgIGlmICghcGFnZSkKPiA+ID4gPiA+
ICAgICAgICAgICAgICAgICByZXR1cm4gTlVMTDsKPiA+ID4gPiA+Cj4gPiA+ID4gPiAtLQo+ID4g
PiA+ID4gMi4yNy4wCj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+Cj4gPgo+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
