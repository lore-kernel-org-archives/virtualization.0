Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB92FC4332F
	for <virtualization@archiver.kernel.org>; Wed,  1 Nov 2023 13:01:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4830D6FC9F;
	Wed,  1 Nov 2023 13:01:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4830D6FC9F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dBkgnjaO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EtXAV4_PJnX7; Wed,  1 Nov 2023 13:01:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CAE8261381;
	Wed,  1 Nov 2023 13:01:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CAE8261381
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2C0AC0039;
	Wed,  1 Nov 2023 13:01:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66016C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 13:01:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2D25E4EC99
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 13:01:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2D25E4EC99
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dBkgnjaO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SYBwddgDfNzI
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 13:01:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E4DBA4EC92
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 13:01:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E4DBA4EC92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698843698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U25hlv0d5a4u4nzaxOvc1rnVpT1wnO8Tahwawd9Dugw=;
 b=dBkgnjaO/VhapUctkA0GdboQn0TY7ePbVPGb8UlGGa3QWgjwx8ggRuheXjUFwoCTPdnprj
 mkGAKo5IIMkoLQxMLKh0nuia1V3waK1Vdz/4NxnGUF0FYo8xvE9WBXanPJPgBS0DUNrpmM
 Jh5+K6wkNIBzNi1Hai24zmQN2/qAkcw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-QqhXGeHIOEOF1NmvFD1XVQ-1; Wed, 01 Nov 2023 09:01:37 -0400
X-MC-Unique: QqhXGeHIOEOF1NmvFD1XVQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9ae0bf9c0a9so451662666b.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 01 Nov 2023 06:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698843696; x=1699448496;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U25hlv0d5a4u4nzaxOvc1rnVpT1wnO8Tahwawd9Dugw=;
 b=cmrTG9H51J9liHReu7QTodmvmNj71LCFCrDPNPImL8Exm45TRzej3sCUCgrac3dm2R
 CGbJj9sDgzJ88SozTjPu8J9TL2UP3YpzoYUZyz1icNoXWynunYLGNBKBpxMGSeNhsXN2
 7sGdJTlWRxs+GVXaAA2Hb6f4rQsxSgv3pbqupN61dYGlLKw/pQsT/dn+rP5XVqcKf/nG
 Y5KxCfm+37GhKEbjjDLn4WutqzYGw4SvQisP/34XzbYpRD1cG7mD6040Q4Ot7Ao5NEGn
 ZWoNR/6cJU0jJMLb0jVuzAlHI+/m4OvUIbqnC4vLA/xAoV7pRGo3OabGFyPGp1No3gOM
 +cVw==
X-Gm-Message-State: AOJu0YzoAoT8eziIJQo6weZ1CavwBKtOKayfK0reJTnRdARgm8dUdkEu
 qiAtqGoAKeedg/pafvpAE5TDjE4h/vGOP2fWTsdzok+1Q8VggtGjU7uHe6onFCSTlzhpf5Y3cRz
 A2EDrvw9R+xcTxWnxwNwsTZKtSQV86YFDPOY0Qi+beA==
X-Received: by 2002:a17:906:b008:b0:9d5:d803:31ee with SMTP id
 v8-20020a170906b00800b009d5d80331eemr1616994ejy.34.1698843695914; 
 Wed, 01 Nov 2023 06:01:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERo4+i+XMFGmYaRUefWF1xxE2JKB60Ea01trIxcM+Pd00A2B92UcuBtp4Hc8zdtSJw0q8cqQ==
X-Received: by 2002:a17:906:b008:b0:9d5:d803:31ee with SMTP id
 v8-20020a170906b00800b009d5d80331eemr1616963ejy.34.1698843695452; 
 Wed, 01 Nov 2023 06:01:35 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:e470:9af7:1504:1b35:8a09])
 by smtp.gmail.com with ESMTPSA id
 oz3-20020a170906cd0300b00977eec7b7e8sm2378853ejb.68.2023.11.01.06.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 06:01:34 -0700 (PDT)
Date: Wed, 1 Nov 2023 09:01:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/2] vdpa: Add logging operatins
Message-ID: <20231101090114-mutt-send-email-mst@kernel.org>
References: <cover.1693012755.git.jiangdongxu1@huawei.com>
 <CACGkMEsP+3nTjG8gj0PoYg0DvyqqOpJKoAxG=m27t+iv-6GVbQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsP+3nTjG8gj0PoYg0DvyqqOpJKoAxG=m27t+iv-6GVbQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: eric.fangyi@huawei.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Jiang Dongxu <jiangdongxu1@huawei.com>, eperezma <eperezma@redhat.com>,
 longpeng2@huawei.com, Siwei Liu <loseweigh@gmail.com>
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

T24gTW9uLCBTZXAgMTEsIDIwMjMgYXQgMDI6NTY6NThQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBBZGRpbmcgRXVnZW5pbyBhbmQgU2kgV2VpLgo+IAo+IE9uIFNhdCwgQXVnIDI2LCAyMDIz
IGF0IDk6MjTigK9BTSBKaWFuZyBEb25neHUgPGppYW5nZG9uZ3h1MUBodWF3ZWkuY29tPiB3cm90
ZToKPiA+Cj4gPiBGcm9tOiBqaWFuZ2Rvbmd4dSA8amlhbmdkb25neHUxQGh1YXdlaS5jb20+Cj4g
Pgo+ID4gQ3VycmVudGx5LCB0aGUgdmRwYSBkZXZpY2Ugc3VwcG9ydHMgc3VzcGVuZCBhbmQgcmVz
dW1lIG9wZXJhdGlvbnMuCj4gPiBUbyBzdXBwb3J0IHZkcGEgZGV2aWNlIGxpdmUgbWlncmF0aW9u
LCB3ZSBuZWVkIHRvIHN1cHBvcnQgbG9nZ2luZwo+ID4gb3BlcmF0aW9ucyBhbmQgZGV2aWNlIHN0
YXRlIHNhdmUvbG9hZCBvcGVydGlvbnMuCj4gPgo+ID4gVGhlc2Ugc2VyaWVzIGludHJvZHVjZXMg
c29tZSBuZXcgb3BlcmF0aW9ucyBmb3IgdmRwYSBkZXZpY2VzLgo+ID4gVGhleSBhbGxvdyB2ZHBh
IHRvIGVuYWJsZSBsb2dnaW5nIHdoaWxlIHZtIHN0YXJ0IGxpdmUgbWlncmF0aW9uLgo+ID4KPiA+
IEFuZCBJIHdpbGwgc3VibWl0IGFub3RoZXIgcGF0Y2hlcyBhYm91dCBzYXZpbmcgYW5kIGxvYWRp
bmcKPiA+IHZkcGEgZGV2aWNlIHN0YXRlIGxhdGVyLgo+IAo+IFRoYW5rcyBmb3Igd29ya2luZyBv
biB0aGlzLCBJIGhhdmUgc2V2ZXJhbCBxdWVzdGlvbnM6Cj4gCj4gMSkgSXMgdGhlcmUgYW4gZXhh
bXBsZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgbG9nZ2luZyBpbiB0aGUgZHJpdmVycz8KPiBXZSBu
ZWVkIGEgcmVhbCB1c2VyIGluIG9yZGVyIHRvIG1lcmdlIHRoaXMuCj4gMikgSXMgdGhlIGxvZ2dp
bmcgYmFzZWQgb24gSU9WQSBvciBWQT8gSG93IHRoZSBETUEgaXNvbGF0aW9uIGlzIGJlaW5nCj4g
ZG9uZSB3aXRoIHRoaXM/IERvIHdlIG5lZWQgYSBTRVRfTE9HR0lOR19BU0lEIHVBUEkgZm9yIHRo
aXM/IChXZSBoYWQKPiBzb21lIGRpc2N1c3Npb24gb24gdGhpcyBpbiB0aGUgcGFzdCkuCj4gCj4g
VGhhbmtzCgoKTm8gYW5zd2VyIHNvIGZhciBzbyBJJ2xsIGRyb3AgdGhpcyBmb3Igbm93LgoKPiA+
Cj4gPiBqaWFuZ2Rvbmd4dSAoMik6Cj4gPiAgIHZkcGE6IGFkZCBsb2cgb3BlcmF0aW9ucwo+ID4g
ICB2aG9zdC12ZHBhOiBhZGQgdUFQSSBmb3IgbG9nZ2luZwo+ID4KPiA+ICBkcml2ZXJzL3Zob3N0
L3ZkcGEuYyAgICAgICB8IDQ5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Cj4gPiAgaW5jbHVkZS9saW51eC92ZHBhLmggICAgICAgfCAxNCArKysrKysrKysrKwo+ID4gIGlu
Y2x1ZGUvdWFwaS9saW51eC92aG9zdC5oIHwgIDQgKysrKwo+ID4gIDMgZmlsZXMgY2hhbmdlZCwg
NjcgaW5zZXJ0aW9ucygrKQo+ID4KPiA+IC0tCj4gPiAyLjI3LjAKPiA+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
