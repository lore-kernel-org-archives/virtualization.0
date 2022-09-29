Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8BBC07E9D
	for <virtualization@archiver.kernel.org>; Thu, 29 Sep 2022 07:19:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D9C7283E25;
	Thu, 29 Sep 2022 07:19:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D9C7283E25
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gWuOMJ/1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b0X4Bk41Y4dt; Thu, 29 Sep 2022 07:19:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4DEAC83E30;
	Thu, 29 Sep 2022 07:19:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4DEAC83E30
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 229FAC0033;
	Thu, 29 Sep 2022 07:19:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7B5FC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:19:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6E0D7400CE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:19:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6E0D7400CE
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gWuOMJ/1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8ucHpTChCKtd
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:19:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3CE20402B1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3CE20402B1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664435961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pahe0Oi4C4m9h6JwmtN0So34FXt/ImLGT/jbwYjYeWk=;
 b=gWuOMJ/1zKrLQlGC2UnlEQeaQJo83D5cJTdqogmN+Wjzbjdd2F+RLvINFb3CG75vOZnGEu
 KGRWqpj6oiTAuGSH/y73A3azFvWHX1Xb7Kkq7ES8IEYksvEFDRoFLChJYCllS9KHFX5tZD
 e0dIh9wDllFDxz8CEvXmyd0hjwDHdC8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-383-Uwf5VRYoPxiohCSMmpXsBQ-1; Thu, 29 Sep 2022 03:19:20 -0400
X-MC-Unique: Uwf5VRYoPxiohCSMmpXsBQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 g15-20020adfbc8f000000b0022a4510a491so163182wrh.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 00:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date;
 bh=Pahe0Oi4C4m9h6JwmtN0So34FXt/ImLGT/jbwYjYeWk=;
 b=bHasbIUpSUk4Im4MM2eAwW3y9gmVfSgRQaeqFGJ3eSmpoDODUEVKZs341p1IQyK2Rr
 mPKgJr7AQriG+TMqctyp11+k6BNr9E6txXJlng0WpWU9ZBx1E7oW+bPd6MkLXvXcPery
 xyHHLdK7/8VSzK5M0vMmcNv933NIORaGuEIyGYBiuXo1fgTwpvrraU6KFT5iZIYZtyET
 lbfLbdQVj0+dUPJgygGWpJs4dzSWSldy0JS2eBF5Bsqv6KYHeOH4K9w2NnLX0AyWx5o3
 rZ+A4t5r/P3R6FLyvgzMljmNgF6tBz5l7r5d5RX3LKQKpyKOGzoaaAWqUA1kW6HAiRtG
 8D/Q==
X-Gm-Message-State: ACrzQf0BV+qruuJomAhGxttMVwyxuR0br55uB1Pln5ty0coSuN1c1e6M
 Rd3MkPxJd5a2X9OcpDcKrGg0z9lfsGGt5VBmkeo/fx2fxvzQVsmZWg3Zg9gEV3Bw6Aei72vadR6
 cTha+BTjafPQo8XYxTurs5P0crxD0wJ4hRMRpw8X7+w==
X-Received: by 2002:a05:600c:4841:b0:3b4:76f0:99f with SMTP id
 j1-20020a05600c484100b003b476f0099fmr1218127wmo.85.1664435958809; 
 Thu, 29 Sep 2022 00:19:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6fAAMQAEw10LqeyomvQ2r46WQeZdX8Xh4sSb3tkzAaqxsTNtqXiZNJ+nRawX6R9Z621MuZlw==
X-Received: by 2002:a05:600c:4841:b0:3b4:76f0:99f with SMTP id
 j1-20020a05600c484100b003b476f0099fmr1218099wmo.85.1664435958545; 
 Thu, 29 Sep 2022 00:19:18 -0700 (PDT)
Received: from redhat.com ([2.55.47.213]) by smtp.gmail.com with ESMTPSA id
 p16-20020adfe610000000b00225239d9265sm6149634wrm.74.2022.09.29.00.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Sep 2022 00:19:17 -0700 (PDT)
Date: Thu, 29 Sep 2022 03:19:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Junichi Uekawa =?utf-8?B?KOS4iuW3nee0lOS4gCk=?= <uekawa@google.com>
Subject: Re: [PATCH] vhost/vsock: Use kvmalloc/kvfree for larger packets.
Message-ID: <20220929031419-mutt-send-email-mst@kernel.org>
References: <20220928064538.667678-1-uekawa@chromium.org>
 <20220928082823.wyxplop5wtpuurwo@sgarzare-redhat>
 <20220928052738-mutt-send-email-mst@kernel.org>
 <20220928151135.pvrlsylg6j3hzh74@sgarzare-redhat>
 <CADgJSGHxPWXJjbakEeWnqF42A03yK7Dpw6U1SKNLhk+B248Ymg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CADgJSGHxPWXJjbakEeWnqF42A03yK7Dpw6U1SKNLhk+B248Ymg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 Bobby Eshleman <bobby.eshleman@gmail.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net
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

T24gVGh1LCBTZXAgMjksIDIwMjIgYXQgMDg6MTQ6MjRBTSArMDkwMCwgSnVuaWNoaSBVZWthd2Eg
KOS4iuW3nee0lOS4gCkgd3JvdGU6Cj4gMjAyMuW5tDnmnIgyOeaXpSjmnKgpIDA6MTEgU3RlZmFu
byBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPjoKPiA+Cj4gPiBPbiBXZWQsIFNlcCAy
OCwgMjAyMiBhdCAwNTozMTo1OEFNIC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4g
PiA+T24gV2VkLCBTZXAgMjgsIDIwMjIgYXQgMTA6Mjg6MjNBTSArMDIwMCwgU3RlZmFubyBHYXJ6
YXJlbGxhIHdyb3RlOgo+ID4gPj4gT24gV2VkLCBTZXAgMjgsIDIwMjIgYXQgMDM6NDU6MzhQTSAr
MDkwMCwgSnVuaWNoaSBVZWthd2Egd3JvdGU6Cj4gPiA+PiA+IFdoZW4gY29weWluZyBhIGxhcmdl
IGZpbGUgb3ZlciBzZnRwIG92ZXIgdnNvY2ssIGRhdGEgc2l6ZSBpcyB1c3VhbGx5IDMya0IsCj4g
PiA+PiA+IGFuZCBrbWFsbG9jIHNlZW1zIHRvIGZhaWwgdG8gdHJ5IHRvIGFsbG9jYXRlIDMyIDMy
a0IgcmVnaW9ucy4KPiA+ID4+ID4KPiA+ID4+ID4gQ2FsbCBUcmFjZToKPiA+ID4+ID4gIFs8ZmZm
ZmZmZmZiNmEwZGY2ND5dIGR1bXBfc3RhY2srMHg5Ny8weGRiCj4gPiA+PiA+ICBbPGZmZmZmZmZm
YjY4ZDZhZWQ+XSB3YXJuX2FsbG9jX2ZhaWxlZCsweDEwZi8weDEzOAo+ID4gPj4gPiAgWzxmZmZm
ZmZmZmI2OGQ4NjhhPl0gPyBfX2FsbG9jX3BhZ2VzX2RpcmVjdF9jb21wYWN0KzB4MzgvMHhjOAo+
ID4gPj4gPiAgWzxmZmZmZmZmZmI2NjQ2MTlmPl0gX19hbGxvY19wYWdlc19ub2RlbWFzaysweDg0
Yy8weDkwZAo+ID4gPj4gPiAgWzxmZmZmZmZmZmI2NjQ2ZTU2Pl0gYWxsb2Nfa21lbV9wYWdlcysw
eDE3LzB4MTkKPiA+ID4+ID4gIFs8ZmZmZmZmZmZiNjY1M2EyNj5dIGttYWxsb2Nfb3JkZXJfdHJh
Y2UrMHgyYi8weGRiCj4gPiA+PiA+ICBbPGZmZmZmZmZmYjY2NjgyZjM+XSBfX2ttYWxsb2MrMHgx
NzcvMHgxZjcKPiA+ID4+ID4gIFs8ZmZmZmZmZmZiNjZlMGQ5ND5dID8gY29weV9mcm9tX2l0ZXIr
MHg4ZC8weDMxZAo+ID4gPj4gPiAgWzxmZmZmZmZmZmMwNjg5YWI3Pl0gdmhvc3RfdnNvY2tfaGFu
ZGxlX3R4X2tpY2srMHgxZmEvMHgzMDEgW3Zob3N0X3Zzb2NrXQo+ID4gPj4gPiAgWzxmZmZmZmZm
ZmMwNjgyOGQ5Pl0gdmhvc3Rfd29ya2VyKzB4ZjcvMHgxNTcgW3Zob3N0XQo+ID4gPj4gPiAgWzxm
ZmZmZmZmZmI2ODNkZGNlPl0ga3RocmVhZCsweGZkLzB4MTA1Cj4gPiA+PiA+ICBbPGZmZmZmZmZm
YzA2ODI3ZTI+XSA/IHZob3N0X2Rldl9zZXRfb3duZXIrMHgyMmUvMHgyMmUgW3Zob3N0XQo+ID4g
Pj4gPiAgWzxmZmZmZmZmZmI2ODNkY2QxPl0gPyBmbHVzaF9rdGhyZWFkX3dvcmtlcisweGYzLzB4
ZjMKPiA+ID4+ID4gIFs8ZmZmZmZmZmZiNmViMzMyZT5dIHJldF9mcm9tX2ZvcmsrMHg0ZS8weDgw
Cj4gPiA+PiA+ICBbPGZmZmZmZmZmYjY4M2RjZDE+XSA/IGZsdXNoX2t0aHJlYWRfd29ya2VyKzB4
ZjMvMHhmMwo+ID4gPj4gPgo+ID4gPj4gPiBXb3JrIGFyb3VuZCBieSBkb2luZyBrdm1hbGxvYyBp
bnN0ZWFkLgo+ID4gPj4gPgo+ID4gPj4gPiBTaWduZWQtb2ZmLWJ5OiBKdW5pY2hpIFVla2F3YSA8
dWVrYXdhQGNocm9taXVtLm9yZz4KPiA+ID4KPiA+ID5NeSB3b3JyeSBoZXJlIGlzIHRoYXQgdGhp
cyBpbiBtb3JlIG9mIGEgd29yayBhcm91bmQuCj4gPiA+SXQgd291bGQgYmUgYmV0dGVyIHRvIG5v
dCBhbGxvY2F0ZSBtZW1vcnkgc28gYWdncmVzc2l2ZWx5Ogo+ID4gPmlmIHdlIGFyZSBzbyBzaG9y
dCBvbiBtZW1vcnkgd2Ugc2hvdWxkIHByb2JhYmx5IHByb2Nlc3MKPiA+ID5wYWNrZXRzIG9uZSBh
dCBhIHRpbWUuIElzIHRoYXQgdmVyeSBoYXJkIHRvIGltcGxlbWVudD8KPiA+Cj4gPiBDdXJyZW50
bHkgdGhlICJ2aXJ0aW9fdnNvY2tfcGt0IiBpcyBhbGxvY2F0ZWQgaW4gdGhlICJoYW5kbGVfa2lj
ayIKPiA+IGNhbGxiYWNrIG9mIFRYIHZpcnRxdWV1ZS4gVGhlbiB0aGUgcGFja2V0IGlzIG11bHRp
cGxleGVkIG9uIHRoZSByaWdodAo+ID4gc29ja2V0IHF1ZXVlLCB0aGVuIHRoZSB1c2VyIHNwYWNl
IGNhbiBkZS1xdWV1ZSBpdCB3aGVuZXZlciB0aGV5IHdhbnQuCj4gPgo+ID4gU28gbWF5YmUgd2Ug
Y2FuIHN0b3AgcHJvY2Vzc2luZyB0aGUgdmlydHF1ZXVlIGlmIHdlIGFyZSBzaG9ydCBvbiBtZW1v
cnksCj4gPiBidXQgd2hlbiBjYW4gd2UgcmVzdGFydCB0aGUgVFggdmlydHF1ZXVlIHByb2Nlc3Np
bmc/Cj4gPgo+ID4gSSB0aGluayBhcyBsb25nIGFzIHRoZSBndWVzdCB1c2VkIG9ubHkgNEsgYnVm
ZmVycyB3ZSBoYWQgbm8gcHJvYmxlbSwgYnV0Cj4gPiBub3cgdGhhdCBpdCBjYW4gY3JlYXRlIGxh
cmdlciBidWZmZXJzIHRoZSBob3N0IG1heSBub3QgYmUgYWJsZSB0bwo+ID4gYWxsb2NhdGUgaXQg
Y29udGlndW91c2x5LiBTaW5jZSB0aGVyZSBpcyBubyBuZWVkIHRvIGhhdmUgdGhlbSBjb250aWd1
b3VzCj4gPiBoZXJlLCBJIHRoaW5rIHRoaXMgcGF0Y2ggaXMgb2theS4KPiA+Cj4gPiBIb3dldmVy
LCBpZiB3ZSBzd2l0Y2ggdG8gc2tfYnVmZiAoYXMgQm9iYnkgaXMgYWxyZWFkeSBkb2luZyksIG1h
eWJlIHdlCj4gPiBkb24ndCBoYXZlIHRoaXMgcHJvYmxlbSBiZWNhdXNlIEkgdGhpbmsgdGhlcmUg
aXMgc29tZSBraW5kIG9mCj4gPiBwcmUtYWxsb2NhdGVkIHBvb2wuCj4gPgo+IAo+IFRoYW5rIHlv
dSBmb3IgdGhlIHJldmlldyEgSSB3YXMgd29uZGVyaW5nIGlmIHRoaXMgaXMgYSByZWFzb25hYmxl
IHdvcmthcm91bmQgKGFzCj4gd2UgZm91bmQgdGhhdCB0aGlzIHBhdGNoIG1ha2VzIGEgcmVsaWFi
bHkgY3Jhc2hpbmcgc3lzdGVtIGludG8gYQo+IHJlbGlhYmx5IHN1cnZpdmluZyBzeXN0ZW0uKQo+
IAo+IAo+IC4uLiBTb3VuZHMgbGlrZSBpdCBpcyBhIHJlYXNvbmFibGUgcGF0Y2ggdG8gdXNlIGJh
Y2twb3J0ZWQgdG8gb2xkZXIga2VybmVscz8KCkhtbS4gR29vZCBwb2ludCBhYm91dCBzdGFibGUu
IE9LLgoKQWNrZWQtYnk6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+CgoKPiA+
ID4KPiA+ID4KPiA+ID4KPiA+ID4+ID4gLS0tCj4gPiA+PiA+Cj4gPiA+PiA+IGRyaXZlcnMvdmhv
c3QvdnNvY2suYyAgICAgICAgICAgICAgICAgICB8IDIgKy0KPiA+ID4+ID4gbmV0L3Ztd192c29j
ay92aXJ0aW9fdHJhbnNwb3J0X2NvbW1vbi5jIHwgMiArLQo+ID4gPj4gPiAyIGZpbGVzIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiA+ID4+ID4KPiA+ID4+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdnNvY2suYyBiL2RyaXZlcnMvdmhvc3QvdnNvY2suYwo+
ID4gPj4gPiBpbmRleCAzNjgzMzA0MTdiZGUuLjU3MDM3NzVhZjEyOSAxMDA2NDQKPiA+ID4+ID4g
LS0tIGEvZHJpdmVycy92aG9zdC92c29jay5jCj4gPiA+PiA+ICsrKyBiL2RyaXZlcnMvdmhvc3Qv
dnNvY2suYwo+ID4gPj4gPiBAQCAtMzkzLDcgKzM5Myw3IEBAIHZob3N0X3Zzb2NrX2FsbG9jX3Br
dChzdHJ1Y3Qgdmhvc3RfdmlydHF1ZXVlICp2cSwKPiA+ID4+ID4gICAgICAgICAgICByZXR1cm4g
TlVMTDsKPiA+ID4+ID4gICAgfQo+ID4gPj4gPgo+ID4gPj4gPiAtICBwa3QtPmJ1ZiA9IGttYWxs
b2MocGt0LT5sZW4sIEdGUF9LRVJORUwpOwo+ID4gPj4gPiArICBwa3QtPmJ1ZiA9IGt2bWFsbG9j
KHBrdC0+bGVuLCBHRlBfS0VSTkVMKTsKPiA+ID4+ID4gICAgaWYgKCFwa3QtPmJ1Zikgewo+ID4g
Pj4gPiAgICAgICAgICAgIGtmcmVlKHBrdCk7Cj4gPiA+PiA+ICAgICAgICAgICAgcmV0dXJuIE5V
TEw7Cj4gPiA+PiA+IGRpZmYgLS1naXQgYS9uZXQvdm13X3Zzb2NrL3ZpcnRpb190cmFuc3BvcnRf
Y29tbW9uLmMgYi9uZXQvdm13X3Zzb2NrL3ZpcnRpb190cmFuc3BvcnRfY29tbW9uLmMKPiA+ID4+
ID4gaW5kZXggZWMyYzJhZmJmMGQwLi4zYTEyYWVlMzNlOTIgMTAwNjQ0Cj4gPiA+PiA+IC0tLSBh
L25ldC92bXdfdnNvY2svdmlydGlvX3RyYW5zcG9ydF9jb21tb24uYwo+ID4gPj4gPiArKysgYi9u
ZXQvdm13X3Zzb2NrL3ZpcnRpb190cmFuc3BvcnRfY29tbW9uLmMKPiA+ID4+ID4gQEAgLTEzNDIs
NyArMTM0Miw3IEBAIEVYUE9SVF9TWU1CT0xfR1BMKHZpcnRpb190cmFuc3BvcnRfcmVjdl9wa3Qp
Owo+ID4gPj4gPgo+ID4gPj4gPiB2b2lkIHZpcnRpb190cmFuc3BvcnRfZnJlZV9wa3Qoc3RydWN0
IHZpcnRpb192c29ja19wa3QgKnBrdCkKPiA+ID4+ID4gewo+ID4gPj4gPiAtICBrZnJlZShwa3Qt
PmJ1Zik7Cj4gPiA+PiA+ICsgIGt2ZnJlZShwa3QtPmJ1Zik7Cj4gPiA+Pgo+ID4gPj4gdmlydGlv
X3RyYW5zcG9ydF9mcmVlX3BrdCgpIGlzIHVzZWQgYWxzbyBpbiB2aXJ0aW9fdHJhbnNwb3J0LmMg
YW5kCj4gPiA+PiB2c29ja19sb29wYmFjay5jIHdoZXJlIHBrdC0+YnVmIGlzIGFsbG9jYXRlZCB3
aXRoIGttYWxsb2MoKSwgYnV0IElJVUMKPiA+ID4+IGt2ZnJlZSgpIGNhbiBiZSB1c2VkIHdpdGgg
dGhhdCBtZW1vcnksIHNvIHRoaXMgc2hvdWxkIGJlIGZpbmUuCj4gPiA+Pgo+ID4gPj4gPiAgICBr
ZnJlZShwa3QpOwo+ID4gPj4gPiB9Cj4gPiA+PiA+IEVYUE9SVF9TWU1CT0xfR1BMKHZpcnRpb190
cmFuc3BvcnRfZnJlZV9wa3QpOwo+ID4gPj4gPiAtLQo+ID4gPj4gPiAyLjM3LjMuOTk4Lmc1Nzdl
NTkxNDNmLWdvb2cKPiA+ID4+ID4KPiA+ID4+Cj4gPiA+PiBUaGlzIGlzc3VlIHNob3VsZCBnbyBh
d2F5IHdpdGggdGhlIEJvYmJ5J3Mgd29yayBhYm91dCBpbnRyb2R1Y2luZyBza19idWZmCj4gPiA+
PiBbMV0sIGJ1dCB3ZSBjYW4gcXVldWUgdGhpcyBmb3Igbm93Lgo+ID4gPj4KPiA+ID4+IEknbSBu
b3Qgc3VyZSBpZiB3ZSBzaG91bGQgZG8gdGhlIHNhbWUgYWxzbyBpbiB0aGUgdmlydGlvLXZzb2Nr
IGRyaXZlcgo+ID4gPj4gKHZpcnRpb190cmFuc3BvcnQuYykuIEhlcmUgaW4gdmhvc3QtdnNvY2sg
dGhlIGJ1ZiBhbGxvY2F0ZWQgaXMgb25seSB1c2VkIGluCj4gPiA+PiB0aGUgaG9zdCwgd2hpbGUg
aW4gdGhlIHZpcnRpby12c29jayBkcml2ZXIgdGhlIGJ1ZmZlciBpcyBleHBvc2VkIHRvIHRoZQo+
ID4gPj4gZGV2aWNlIGVtdWxhdGVkIGluIHRoZSBob3N0LCBzbyBpdCBzaG91bGQgYmUgcGh5c2lj
YWxseSBjb250aWd1b3VzIChpZiBub3QsCj4gPiA+PiBtYXliZSB3ZSBuZWVkIHRvIGFkanVzdCB2
aXJ0aW9fdnNvY2tfcnhfZmlsbCgpKS4KPiA+ID4KPiA+ID5Nb3JlIGltcG9ydGFudGx5IGl0IG5l
ZWRzIHRvIHN1cHBvcnQgRE1BIEFQSSB3aGljaCBJSVVDIGt2bWFsbG9jCj4gPiA+bWVtb3J5IGRv
ZXMgbm90Lgo+ID4gPgo+ID4KPiA+IFJpZ2h0LCBnb29kIHBvaW50IQo+ID4KPiA+IFRoYW5rcywK
PiA+IFN0ZWZhbm8KPiA+Cj4gCj4gCj4gLS0gCj4gSnVuaWNoaSBVZWthd2EKPiBHb29nbGUKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
