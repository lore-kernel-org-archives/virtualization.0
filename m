Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E62C433EF
	for <virtualization@archiver.kernel.org>; Tue, 28 Jun 2022 07:55:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 499B44050C;
	Tue, 28 Jun 2022 07:55:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 499B44050C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HtVuvHBV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8lch5aiDcgJy; Tue, 28 Jun 2022 07:55:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D726640374;
	Tue, 28 Jun 2022 07:55:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D726640374
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E7A0C0032;
	Tue, 28 Jun 2022 07:55:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57F65C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 07:55:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 405578272C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 07:55:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 405578272C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HtVuvHBV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gEdBfptFROfg
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 07:55:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 78FF1824DD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 78FF1824DD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 07:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656402948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2J9+fR6giAYvAQr6KvneSIDgHdSrKwsAVjfZobXjNJY=;
 b=HtVuvHBVBRiuctHRHeFZn5ijBYXMCRE5FsiwSNL0jl4xci7h1wZIzqsmSkRo/riVyys9pR
 lSGMY1sGYXfogymq/u2tjNbnLRbsgRZRjdki1lpK/7MSBIO4zaGxQJ7vckBIbaxjB43EU5
 7hRQu9LJsoeqXw9KN9NXWo6DIbFxcf8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-Ezuox-FMPa6cAxYu3PaJ_Q-1; Tue, 28 Jun 2022 03:55:42 -0400
X-MC-Unique: Ezuox-FMPa6cAxYu3PaJ_Q-1
Received: by mail-lj1-f200.google.com with SMTP id
 i23-20020a2e9417000000b0025a739223d1so1420430ljh.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 00:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2J9+fR6giAYvAQr6KvneSIDgHdSrKwsAVjfZobXjNJY=;
 b=gr/K7bbql9A1DRZ4mKrz6JQsQbU/+v3ZLgBoBDW/ygnN6dKnfe+W2eoVQXGlPQhKIX
 A3MQH+djti5d3tuEFEDuabYeYR9hIxPbiBdaFfEbJFS8oNAqb4x1Ug8QKRSSishJBWM+
 OAB7aKYw7vM0Ag//rBolY7jVQJNwdo4jN2xWfDDZUw6B9uyrmwlgKUY94Ka4utEgaXF5
 MG/s/k+MJUosJI+d4rm2HclRdGRpQpQd0gBVDb2q+0Z+QbfkTbsdaBu0H5KlhJ75itVZ
 2Lw1PrZuxcSIQw1A2nlmDBZPJ684kv4Rp3pgLLw0yMkEUZHInBI4HrQ8T4s13RXzBMwu
 3ouQ==
X-Gm-Message-State: AJIora9i/kptOAEsN+eGdmsK7nicHOxkPQyXR/6X6BOXcWMq6/39VoKl
 eBr5TMRCujUuCslwKF8qFELnyngVqnf7JbvYlyH+dsIyKOQ5BhADPxM4xhwBfD7GcS+rKdw2+y6
 linbeKwpwPe5A/qWI1v2DUe8iuFyYq7qnA86G3EnFM77cAQqo1iSMnppP6g==
X-Received: by 2002:a05:6512:128a:b0:47f:b6df:6177 with SMTP id
 u10-20020a056512128a00b0047fb6df6177mr11027126lfs.176.1656402939940; 
 Tue, 28 Jun 2022 00:55:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sOuMD5bahhMgNky8humPco5ZAjUxZJfBwy9JtBBHeOLXjJVdIEBsJC0hrwdKN3Ctf/mLPqcvAazE+dAjtmIIw=
X-Received: by 2002:a05:6512:128a:b0:47f:b6df:6177 with SMTP id
 u10-20020a056512128a00b0047fb6df6177mr11027117lfs.176.1656402939721; Tue, 28
 Jun 2022 00:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220621160859.196646-1-sgarzare@redhat.com>
 <20220621160859.196646-3-sgarzare@redhat.com>
 <CACGkMEsk-O=dVwKoEHRY-nL3XEQktPWiBot2NfOUYNdkoL-s=Q@mail.gmail.com>
 <20220623085830.voi6gixpikz64nm2@sgarzare-redhat>
 <CACGkMEvH-LFW3dvcaKNSmKyFG_SeBbTrPKtJOCwJHKMdtormJw@mail.gmail.com>
In-Reply-To: <CACGkMEvH-LFW3dvcaKNSmKyFG_SeBbTrPKtJOCwJHKMdtormJw@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 28 Jun 2022 09:55:27 +0200
Message-ID: <CAGxU2F5uv2gMPp6Mfc_yxytMpbPwPdcfJ=NhazoJQkR3WNjUAQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] vdpa_sim_blk: limit the number of request handled per
 batch
To: Jason Wang <jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

T24gVHVlLCBKdW4gMjgsIDIwMjIgYXQgNjowMSBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPgo+IE9uIFRodSwgSnVuIDIzLCAyMDIyIGF0IDQ6NTggUE0gU3RlZmFu
byBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBUaHUs
IEp1biAyMywgMjAyMiBhdCAxMTo1MDoyMkFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4g
Pk9uIFdlZCwgSnVuIDIyLCAyMDIyIGF0IDEyOjA5IEFNIFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dh
cnphcmVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+Pgo+ID4gPj4gTGltaXQgdGhlIG51bWJlciBv
ZiByZXF1ZXN0cyAoNCBwZXIgcXVldWUgYXMgZm9yIHZkcGFfc2ltX25ldCkgaGFuZGxlZAo+ID4g
Pj4gaW4gYSBiYXRjaCB0byBwcmV2ZW50IHRoZSB3b3JrZXIgZnJvbSB1c2luZyB0aGUgQ1BVIGZv
ciB0b28gbG9uZy4KPiA+ID4+Cj4gPiA+PiBTdWdnZXN0ZWQtYnk6IEV1Z2VuaW8gUMOpcmV6IDxl
cGVyZXptYUByZWRoYXQuY29tPgo+ID4gPj4gU2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6YXJl
bGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgo+ID4gPj4gLS0tCj4gPiA+PiAgZHJpdmVycy92ZHBh
L3ZkcGFfc2ltL3ZkcGFfc2ltX2Jsay5jIHwgMTUgKysrKysrKysrKysrKystCj4gPiA+PiAgMSBm
aWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+ID4+Cj4gPiA+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX2Jsay5jIGIvZHJp
dmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX2Jsay5jCj4gPiA+PiBpbmRleCBhODNhNWM3NmY2
MjAuLmFjODY0Nzg4NDViNiAxMDA2NDQKPiA+ID4+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhX3Np
bS92ZHBhX3NpbV9ibGsuYwo+ID4gPj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFf
c2ltX2Jsay5jCj4gPiA+PiBAQCAtMTk3LDYgKzE5Nyw3IEBAIHN0YXRpYyBib29sIHZkcGFzaW1f
YmxrX2hhbmRsZV9yZXEoc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0sCj4gPiA+PiAgc3RhdGljIHZv
aWQgdmRwYXNpbV9ibGtfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCj4gPiA+PiAgewo+
ID4gPj4gICAgICAgICBzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSA9IGNvbnRhaW5lcl9vZih3b3Jr
LCBzdHJ1Y3QgdmRwYXNpbSwgd29yayk7Cj4gPiA+PiArICAgICAgIGJvb2wgcmVzY2hlZHVsZSA9
IGZhbHNlOwo+ID4gPj4gICAgICAgICBpbnQgaTsKPiA+ID4+Cj4gPiA+PiAgICAgICAgIHNwaW5f
bG9jaygmdmRwYXNpbS0+bG9jayk7Cj4gPiA+PiBAQCAtMjA2LDExICsyMDcsMTUgQEAgc3RhdGlj
IHZvaWQgdmRwYXNpbV9ibGtfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCj4gPiA+Pgo+
ID4gPj4gICAgICAgICBmb3IgKGkgPSAwOyBpIDwgVkRQQVNJTV9CTEtfVlFfTlVNOyBpKyspIHsK
PiA+ID4+ICAgICAgICAgICAgICAgICBzdHJ1Y3QgdmRwYXNpbV92aXJ0cXVldWUgKnZxID0gJnZk
cGFzaW0tPnZxc1tpXTsKPiA+ID4+ICsgICAgICAgICAgICAgICBib29sIHZxX3dvcmsgPSB0cnVl
Owo+ID4gPj4gKyAgICAgICAgICAgICAgIGludCByZXFzID0gMDsKPiA+ID4+Cj4gPiA+PiAgICAg
ICAgICAgICAgICAgaWYgKCF2cS0+cmVhZHkpCj4gPiA+PiAgICAgICAgICAgICAgICAgICAgICAg
ICBjb250aW51ZTsKPiA+ID4+Cj4gPiA+PiAtICAgICAgICAgICAgICAgd2hpbGUgKHZkcGFzaW1f
YmxrX2hhbmRsZV9yZXEodmRwYXNpbSwgdnEpKSB7Cj4gPiA+PiArICAgICAgICAgICAgICAgd2hp
bGUgKHZxX3dvcmspIHsKPiA+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgIHZxX3dvcmsgPSB2
ZHBhc2ltX2Jsa19oYW5kbGVfcmVxKHZkcGFzaW0sIHZxKTsKPiA+ID4+ICsKPiA+ID4KPiA+ID5J
cyBpdCBiZXR0ZXIgdG8gY2hlY2sgYW5kIGV4aXQgdGhlIGxvb3AgZWFybHkgaGVyZT8KPiA+Cj4g
PiBNYXliZSwgYnV0IEknbSBub3Qgc3VyZS4KPiA+Cj4gPiBJbiB2ZHBhX3NpbV9uZXQgd2UgY2Fs
bCB2cmluZ2hfY29tcGxldGVfaW90bGIoKSBhbmQgc2VuZCBub3RpZmljYXRpb24KPiA+IGFsc28g
aW4gdGhlIGVycm9yIHBhdGgsCj4KPiBMb29rcyBub3Q/Cj4KPiAgICAgICAgICAgICAgICAgcmVh
ZCA9IHZyaW5naF9pb3ZfcHVsbF9pb3RsYigmY3ZxLT52cmluZywgJmN2cS0+aW5faW92LCAmY3Ry
bCwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplb2Yo
Y3RybCkpOwo+ICAgICAgICAgICAgICAgICBpZiAocmVhZCAhPSBzaXplb2YoY3RybCkpCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgYnJlYWs7Cj4KPiBXZSBicmVhayB0aGUgbG9vcC4KCkkgd2Fz
IGxvb2tpbmcgYXQgdmRwYXNpbV9uZXRfd29yaygpLCBidXQgSSB3YXMgY29uZnVzZWQgc2luY2Ug
aXQKaGFuZGxlcyAyIHF1ZXVlcy4KCkknbGwgYnJlYWsgdGhlIGxvb3AgYXMgaXQgd2FzIGJlZm9y
ZS4KClRoYW5rcywKU3RlZmFubwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
