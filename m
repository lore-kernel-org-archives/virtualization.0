Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCC1C77B73
	for <virtualization@archiver.kernel.org>; Fri, 28 Apr 2023 02:00:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9F1AB402D4;
	Fri, 28 Apr 2023 02:00:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9F1AB402D4
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20221208.gappssmtp.com header.i=@igel-co-jp.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=ABdw2dWY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6NZyw7dKLtCC; Fri, 28 Apr 2023 02:00:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EF17041E36;
	Fri, 28 Apr 2023 02:00:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EF17041E36
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEF0FC0036;
	Fri, 28 Apr 2023 02:00:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA509C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 02:00:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 85BA160BFB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 02:00:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 85BA160BFB
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20221208.gappssmtp.com
 header.i=@igel-co-jp.20221208.gappssmtp.com header.a=rsa-sha256
 header.s=20221208 header.b=ABdw2dWY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U4fk24j75kVt
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 02:00:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3705560E5B
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com
 [IPv6:2607:f8b0:4864:20::a2f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3705560E5B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 02:00:28 +0000 (UTC)
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-44062aa1b5bso3126506e0c.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 19:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1682647227; x=1685239227;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gl4UcZhexIohjefd4ELF83XHOyhrEBsBVG6iR4uVgNM=;
 b=ABdw2dWYlDukm9J5D/DtEXqh1ZkOJzYRX/FH3TiKebIZ/Knwom7xTvnBcM6RBDtyBv
 /o+AGSG3yYgkFJohuBV0zBLSCW5wVo4W4ABLqmMLaj7npr2oeW7zXXDTNnmQtW1zW97c
 Xy7n3edElkqWMvaiYaCXQFZ0GwX7I55GYirDnbpn/u4FF1oBrUtk+VPn7xh0xlk2Si0Z
 +XDaJBe1wKBcAOkXuW8yvtyYdvYNaJCTqICXqUTnIxh9c8hXe+G4aDeTWYJif2kXaLYX
 622PYWOoA0S1Z1jyQ9xHyjU1Ru4af3D3Hd8TyEgTObKCimt9ltptfWqv+jCe0BTHxVZ0
 SgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682647227; x=1685239227;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gl4UcZhexIohjefd4ELF83XHOyhrEBsBVG6iR4uVgNM=;
 b=hH38g9RtxQepKK2kIrZhVO+L6Rw+vLhERcmKVDku4nYgIRXTebL6UKT5qyZEu/kcFC
 oYgUBKt1kLbIvnM6zwE8BTAAS3w37hyua/fRm4a/NdSfzKcXztcY7hxVwGjq+uvAbZW1
 YtvdzbxnHYLmzMiGUfXczzW0SiPP3XTkWLJje4uhnawxPrw3YFfUcrbls1+3KhsyMzwQ
 zHNjKq+ZuK0ihS3BrjOeR4aJ4n6fyYQ2lKneoK+MnUiGcCYD5RG7z6W0xWmFd1y9n/sD
 na49n962bFANN0eDGFHtPFmYaTmqbqDb51sbbNbD1ipdISZwNbzdHC4jeyKnP66dJlJK
 KwqQ==
X-Gm-Message-State: AC+VfDxXNEwTO5dP9vnNpPugRSJD66pwrQQrj+UquJvC66POzJSQ2u6X
 cBQcd7YAwWQw4YPwClMuRaMxW+rquAe39FvOEu3dDg==
X-Google-Smtp-Source: ACHHUZ6bXAHX3os0g+edZnDMBXePIfbnxThJdyz0sgMrCWX55u39Ow0FXGJjamRkioyW0WH1Feggfua5iFpnPLCBbuM=
X-Received: by 2002:a1f:3f43:0:b0:443:9b17:72e9 with SMTP id
 m64-20020a1f3f43000000b004439b1772e9mr1396826vka.12.1682647227075; Thu, 27
 Apr 2023 19:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230425102250.3847395-1-mie@igel.co.jp>
 <ZEl5yKYzsw/g+tQh@corigine.com>
In-Reply-To: <ZEl5yKYzsw/g+tQh@corigine.com>
From: Shunsuke Mie <mie@igel.co.jp>
Date: Fri, 28 Apr 2023 11:00:16 +0900
Message-ID: <CANXvt5pjEau8_h7x_2kx9E79Dsc4g1ohnof5fo5QHL=KR261AA@mail.gmail.com>
Subject: Re: [PATCH v3] vringh: IOMEM support
To: Simon Horman <simon.horman@corigine.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

SGkgU2ltb24tc2FuLAoKMjAyM+W5tDTmnIgyN+aXpSjmnKgpIDQ6MjEgU2ltb24gSG9ybWFuIDxz
aW1vbi5ob3JtYW5AY29yaWdpbmUuY29tPjoKPgo+IE9uIFR1ZSwgQXByIDI1LCAyMDIzIGF0IDA3
OjIyOjUwUE0gKzA5MDAsIFNodW5zdWtlIE1pZSB3cm90ZToKPiA+IEludHJvZHVjZSBhIG5ldyBt
ZW1vcnkgYWNjZXNzb3IgZm9yIHZyaW5naC4gSXQgaXMgYWJsZSB0byB1c2UgdnJpbmdoIHRvCj4g
PiB2aXJ0aW8gcmluZ3MgbG9jYXRlZCBvbiBpby1tZW1vcnkgcmVnaW9uLgo+ID4KPiA+IFNpZ25l
ZC1vZmYtYnk6IFNodW5zdWtlIE1pZSA8bWllQGlnZWwuY28uanA+Cj4KPiAuLi4KPgo+IEhpIE1p
ZS1zYW4sCj4KPiB0aGFua3MgZm9yIHlvdXIgcGF0Y2guCj4gT25lIHNtYWxsIG5pdCBmcm9tIG1l
IGJlbG93Lgo+Cj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92cmluZ2guaCBiL2luY2x1
ZGUvbGludXgvdnJpbmdoLmgKPiA+IGluZGV4IGMzYTgxMTdkYWJlOC4uYzAzZDA0NWY3ZjNmIDEw
MDY0NAo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC92cmluZ2guaAo+ID4gKysrIGIvaW5jbHVkZS9s
aW51eC92cmluZ2guaAo+ID4gQEAgLTMzMCw0ICszMzAsMzcgQEAgaW50IHZyaW5naF9uZWVkX25v
dGlmeV9pb3RsYihzdHJ1Y3QgdnJpbmdoICp2cmgpOwo+ID4KPiA+ICAjZW5kaWYgLyogQ09ORklH
X1ZIT1NUX0lPVExCICovCj4gPgo+ID4gKyNpZiBJU19SRUFDSEFCTEUoQ09ORklHX1ZIT1NUX1JJ
TkdfSU9NRU0pCj4gPiArCj4gPiAraW50IHZyaW5naF9pbml0X2lvbWVtKHN0cnVjdCB2cmluZ2gg
KnZyaCwgdTY0IGZlYXR1cmVzLAo+ID4gKyAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQg
bnVtLCBib29sIHdlYWtfYmFycmllcnMsCj4gPiArICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2
cmluZ19kZXNjICpkZXNjLAo+ID4gKyAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdnJpbmdfYXZh
aWwgKmF2YWlsLAo+ID4gKyAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdnJpbmdfdXNlZCAqdXNl
ZCk7Cj4gPiArCj4gPiArCj4KPiBuaXQ6IG9uZSBibGFuayBsaW5lIGlzIGVub3VnaC4KSXQgc2hv
dWxkIG5vdCBoYXZlIGluY2x1ZGVkIHRoaXMgcGF0Y2guIFRoYW5rcy4KPiA+ICtpbnQgdnJpbmdo
X2dldGRlc2NfaW9tZW0oc3RydWN0IHZyaW5naCAqdnJoLAo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICBzdHJ1Y3QgdnJpbmdoX2tpb3YgKnJpb3YsCj4gPiArICAgICAgICAgICAgICAgICAgICAg
IHN0cnVjdCB2cmluZ2hfa2lvdiAqd2lvdiwKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgdTE2
ICpoZWFkLAo+ID4gKyAgICAgICAgICAgICAgICAgICAgICBnZnBfdCBnZnApOwo+Cj4gLi4uCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
