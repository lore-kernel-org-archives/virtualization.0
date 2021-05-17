Return-Path: <SRS0=CgtS=KM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF0DC43460
	for <virtualization@archiver.kernel.org>; Mon, 17 May 2021 20:23:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15016610A1
	for <virtualization@archiver.kernel.org>; Mon, 17 May 2021 20:23:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15016610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D649F83F80;
	Mon, 17 May 2021 20:23:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qOj4II1ec7Ki; Mon, 17 May 2021 20:23:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9088383EFE;
	Mon, 17 May 2021 20:23:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71219C000D;
	Mon, 17 May 2021 20:23:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17200C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 20:23:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ECB1F607CE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 20:23:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jNblBPi1bU1L
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 20:23:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B528A605BA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 20:23:53 +0000 (UTC)
Received: by mail-ua1-x934.google.com with SMTP id c6so1951261uat.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 13:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=TNVxp+4uYZU44gvo81BAyFu2mBsVyk6HxBgwuTdRjGw=;
 b=Xb7tt3YStfK16ujxVVCoZcExFZ22Uh+FtP8r3MT4LMYX1A5AgkQEaEGiKG5wJH+qdP
 PeNZ4c6i8DVxyi57luCsqW5Ang2kb43bKhIFOEcYFm/B8/pxVqavwixiTK5k8mW1PvXM
 f8ipUarjrgWCa6PhRPlYtawPv/yyGxu3TENCGJfGc6r6YdP326WIN+M1FxI5Ie18ylvj
 c5ONkEc6z+UwtEdeUnoVROVztdfeshg5E4q3VJu1YsYwfEc0Gsi8mBDqlrDwOfmwYbWO
 xZd4kPYJn8JPLDxoDJ6i7VJUIWRFHKeR00WgLYTTv5UT07AcWjY2IpnpdzAO254m4FmG
 epkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TNVxp+4uYZU44gvo81BAyFu2mBsVyk6HxBgwuTdRjGw=;
 b=ZOzErNEQCnohEpQ9L3r+7rgus1fFsOs6gWJIKGXC+iF3w111FMn715g8IolkdQke7g
 /AzSRUhfkM6/a2CDf4sjRJSzaltkTvgrw3iMGOPbZcOlbxit9gUhcVCwVTXDltj2+HTK
 +SKLORf42ohMGEG+Q9IQVsppU9++EQL0YqHpZ8hHJ3H5pUgNeElWD9eVhmuz8gwbIcJh
 HFQ7ITuGwFvYeWirAQ/8bgLZ4IxZ93Ypna2oRXDkoksUlcygCEq5BQV0lG73nzPnTgLs
 9bPVatR4PAENwGPXUbn4wKbm9iPx01RtGyzPDNtQlUfB6nyCEk+lXDhL3yQ2yCPFNPZG
 1fow==
X-Gm-Message-State: AOAM530uuGznOLLrx2lz2q3iSRI06wk6jC3KziUE50qYQJ3ENIpbnOin
 uWhi8YFYjEqqLOT2z/K4D5x1FMNIFjGdIYYV
X-Google-Smtp-Source: ABdhPJzKmGN30qTpTwu71epBhBfNaZi/aPVbO2rS88t7Yf13XRLnJPQb9EVUbWRLKI6c5ld3KgN1Rw==
X-Received: by 2002:ab0:3482:: with SMTP id c2mr1766554uar.122.1621283031986; 
 Mon, 17 May 2021 13:23:51 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com.
 [209.85.217.48])
 by smtp.gmail.com with ESMTPSA id f65sm947358vke.43.2021.05.17.13.23.49
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 May 2021 13:23:50 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id f15so2467584vsq.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 13:23:49 -0700 (PDT)
X-Received: by 2002:a67:fe57:: with SMTP id m23mr2025033vsr.47.1621283029295; 
 Mon, 17 May 2021 13:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <56270996-33a6-d71b-d935-452dad121df7@linux.alibaba.com>
 <CAA93jw6LUAnWZj0b5FvefpDKUyd6cajCNLoJ6OKrwbu-V_ffrA@mail.gmail.com>
In-Reply-To: <CAA93jw6LUAnWZj0b5FvefpDKUyd6cajCNLoJ6OKrwbu-V_ffrA@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 17 May 2021 16:23:10 -0400
X-Gmail-Original-Message-ID: <CA+FuTSf0Af2RXEG=rCthNNEb5mwKTG37gpEBBZU16qKkvmF=qw@mail.gmail.com>
Message-ID: <CA+FuTSf0Af2RXEG=rCthNNEb5mwKTG37gpEBBZU16qKkvmF=qw@mail.gmail.com>
Subject: Re: virtio_net: BQL?
To: Dave Taht <dave.taht@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Xianting Tian <xianting.tian@linux.alibaba.com>,
 Linux Kernel Network Developers <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
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

T24gTW9uLCBNYXkgMTcsIDIwMjEgYXQgMjo0NCBQTSBEYXZlIFRhaHQgPGRhdmUudGFodEBnbWFp
bC5jb20+IHdyb3RlOgo+Cj4gTm90IHJlYWxseSByZWxhdGVkIHRvIHRoaXMgcGF0Y2gsIGJ1dCBp
cyB0aGVyZSBzb21lIHJlYXNvbiB3aHkgdmlydGlvCj4gaGFzIG5vIHN1cHBvcnQgZm9yIEJRTD8K
ClRoZXJlIGhhdmUgYmVlbiBhIGZldyBhdHRlbXB0cyB0byBhZGQgaXQgb3ZlciB0aGUgeWVhcnMu
CgpNb3N0IHJlY2VudGx5LCBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMTgxMjA1MjI1
MzIzLjEyNTU1LTItbXN0QHJlZGhhdC5jb20vCgpUaGF0IHRocmVhZCBoYXMgYSBsb25nIGRpc2N1
c3Npb24uIEkgdGhpbmsgdGhlIGtleSBvcGVuIGlzc3VlIHJlbWFpbnMKCiJUaGUgdHJpY2t5IHBh
cnQgaXMgdGhlIG1vZGUgc3dpdGNoaW5nIGJldHdlZW4gbmFwaSBhbmQgbm8gbmFwaS4iCgo+IE9u
IE1vbiwgTWF5IDE3LCAyMDIxIGF0IDExOjQxIEFNIFhpYW50aW5nIFRpYW4KPiA8eGlhbnRpbmcu
dGlhbkBsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPgo+ID4gQlVHX09OKCkgdXNlcyB1bmxp
a2VseSBpbiBpZigpLCB3aGljaCBjYW4gYmUgb3B0aW1pemVkIGF0IGNvbXBpbGUgdGltZS4KPiA+
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBYaWFudGluZyBUaWFuIDx4aWFudGluZy50aWFuQGxpbnV4LmFs
aWJhYmEuY29tPgo+ID4gLS0tCj4gPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDUgKyst
LS0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkK
PiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9u
ZXQvdmlydGlvX25ldC5jCj4gPiBpbmRleCBjOTIxZWJmM2FlODIuLjIxMmQ1MjIwNDg4NCAxMDA2
NDQKPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gKysrIGIvZHJpdmVycy9u
ZXQvdmlydGlvX25ldC5jCj4gPiBAQCAtMTY0NiwxMCArMTY0Niw5IEBAIHN0YXRpYyBpbnQgeG1p
dF9za2Ioc3RydWN0IHNlbmRfcXVldWUgKnNxLCBzdHJ1Y3QKPiA+IHNrX2J1ZmYgKnNrYikKPiA+
ICAgICAgICAgZWxzZQo+ID4gICAgICAgICAgICAgICAgIGhkciA9IHNrYl92bmV0X2hkcihza2Ip
Owo+ID4KPiA+IC0gICAgICAgaWYgKHZpcnRpb19uZXRfaGRyX2Zyb21fc2tiKHNrYiwgJmhkci0+
aGRyLAo+ID4gKyAgICAgICBCVUdfT04odmlydGlvX25ldF9oZHJfZnJvbV9za2Ioc2tiLCAmaGRy
LT5oZHIsCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2aXJ0aW9faXNf
bGl0dGxlX2VuZGlhbih2aS0+dmRldiksIGZhbHNlLAo+ID4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgMCkpCj4gPiAtICAgICAgICAgICAgICAgQlVHKCk7Cj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwKSk7Cj4gPgo+ID4gICAgICAgICBpZiAodmkt
Pm1lcmdlYWJsZV9yeF9idWZzKQo+ID4gICAgICAgICAgICAgICAgIGhkci0+bnVtX2J1ZmZlcnMg
PSAwOwo+ID4gLS0KPiA+IDIuMTcuMQo+ID4KPgo+Cj4gLS0KPiBMYXRlc3QgUG9kY2FzdDoKPiBo
dHRwczovL3d3dy5saW5rZWRpbi5jb20vZmVlZC91cGRhdGUvdXJuOmxpOmFjdGl2aXR5OjY3OTEw
MTQyODQ5MzY3ODU5MjAvCj4KPiBEYXZlIFTDpGh0IENUTywgVGVrTGlicmUsIExMQwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
