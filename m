Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7C7C76196
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 11:13:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2924C60E0D;
	Tue, 11 Apr 2023 11:13:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2924C60E0D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W20vDDWe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QHFcN1Qzed0K; Tue, 11 Apr 2023 11:13:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AFE3260BED;
	Tue, 11 Apr 2023 11:13:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AFE3260BED
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B4F6C0036;
	Tue, 11 Apr 2023 11:13:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DB25C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 11:13:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5569C606C0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 11:13:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5569C606C0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TijUUTp8XFj3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 11:13:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D1D3760675
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D1D3760675
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 11:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681211625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pWOLv0WX3GwUsspxOTFb+6/lyFHPxiFz6fR9eO1Jkbs=;
 b=W20vDDWehcRdgnGz+1yEAqh7w5aLz70IizdPwO4vyMYWySMdMS1y/Gowg+NjmvUYYQHeXK
 M2sbk8/aGjS+chuDoaImpekZfRdS/zxohjnSnVHF4Vi+9nNgMB1tunyB19yK/UmZ6BJS9w
 FRHgDSyHgRlgnVNFgPhlLoJyMvFT0HQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-15Ohb6H-Oty6TScrHwOcHQ-1; Tue, 11 Apr 2023 07:13:42 -0400
X-MC-Unique: 15Ohb6H-Oty6TScrHwOcHQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 u14-20020a05600c19ce00b003f0331154b1so13834212wmq.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 04:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681211621;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pWOLv0WX3GwUsspxOTFb+6/lyFHPxiFz6fR9eO1Jkbs=;
 b=MTbfePJ3AqeUEEZ/vbTNGdqn2+LMxMNH5uhPAvA3u55Yohzps4w9zYvCMuiMPCyOzL
 xc8tpCx3vKHLlVU7LzToNSMz0+G9WGLIy+Gj1H8zROp2qJ+nimQcaHvn799Ty7acWkBi
 HS5e7V5oexwlrLGJPWOlTyLELM8Y0SpFPI8RO037J52H6hTGpA7RqpAKSxC3f/gR8DFp
 PGO+Q5kOZNz0Fe9Xt0+DoASroEGjESjjudhLuCDptK4+lUnMKwlI2ifm3zw5YZdqbDDB
 7cuxb0abgBWBt2IJhGVrPG7fxXH6hhDohO+Nd4I+8RSXnWAA67NVCxZfsM9KZcVj0ShJ
 nM/g==
X-Gm-Message-State: AAQBX9enwnSC+vF0BZ6gxrSHxX/fqavM9L5MJry75792BP9OGo8ef6O+
 IFKjrbCKNdyr9uwD5IBQJJSPNiCbE0YI86tXeMZoqCk/Gu3zs4Ig58ojxpRSSXw+s8FMooWKEqy
 ZVbkJblP+y+09x+8r6UhI14rWSHw70BAMvMIuA/eV0g==
X-Received: by 2002:a7b:c051:0:b0:3ee:da1:1346 with SMTP id
 u17-20020a7bc051000000b003ee0da11346mr9265251wmc.36.1681211620924; 
 Tue, 11 Apr 2023 04:13:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yl98KmSsmJ4WWU8bJsbrQ2am/B1DfCxkytMG8LAIGPKJIu6SLn2Tg7roihlUl5VNYTY9Oe4Q==
X-Received: by 2002:a7b:c051:0:b0:3ee:da1:1346 with SMTP id
 u17-20020a7bc051000000b003ee0da11346mr9265241wmc.36.1681211620587; 
 Tue, 11 Apr 2023 04:13:40 -0700 (PDT)
Received: from redhat.com ([2.52.10.80]) by smtp.gmail.com with ESMTPSA id
 q31-20020a05600c331f00b003ee610d1ce9sm20383391wmp.34.2023.04.11.04.13.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Apr 2023 04:13:39 -0700 (PDT)
Date: Tue, 11 Apr 2023 07:13:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Angus Chen <angus.chen@jaguarmicro.com>
Subject: Re: [PATCH] virtio_pci: Wait for legacy device to be reset
Message-ID: <20230411071111-mutt-send-email-mst@kernel.org>
References: <CACGkMEscqtaTpCed_f2cfknO4--mXCyp33u1CmZwNEZxyf=ifQ@mail.gmail.com>
 <TY2PR06MB3424BACFA8B6CB463C12E31E859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <20230411024459-mutt-send-email-mst@kernel.org>
 <TY2PR06MB3424E3C222C3B896BB583DFD859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <20230411025335-mutt-send-email-mst@kernel.org>
 <TY2PR06MB3424DB10784CA5504A10099E859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <20230411032014-mutt-send-email-mst@kernel.org>
 <TY2PR06MB3424DE523E669A3B1910D7F0859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <20230411061409-mutt-send-email-mst@kernel.org>
 <TY2PR06MB3424185F07F76D82746B6503859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TY2PR06MB3424185F07F76D82746B6503859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

T24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgMTA6NTc6NTFBTSArMDAwMCwgQW5ndXMgQ2hlbiB3cm90
ZToKPiA+ID4gPiBZZXMsIG5vdCB2ZXJ5IGNsZWFyIHN0aWxsLiBXaGF0IGFyZSB0aGUgZGV2aWNl
IGFuZCB2ZW5kb3IgSUQgb2YgdGhlCj4gPiA+ID4gY2FyZD8gRG9lcyBpdCBoYXZlIHRoZSB2aXJ0
aW8gY2FwYWJpbGl0aWVzPwo+ID4gPiA+IFRoYW5rcwo+ID4gPiBJdCdzIGhhdmUgdGhlIHZpcnRp
byBjYXBhYmlsaXRpZXMuCj4gPiA+IFdoZW4gaXQgaXMgdXNlZCBpbiBiYXJlIG1ldGFsIO+8jAo+
ID4gPiAgICBpdCBqdXN0IHVzZSBQQ0lfVkVORE9SX0lEX1JFREhBVF9RVU1SQU5FVC4KPiA+ID4g
V2hlbiBpdCB1c2UgaW4gdm0sCj4gPiA+ICBJdCBpcyBqdXN0IGxpa2UgOgo+ID4gPiB7IFBDSV9E
RVZJQ0VfU1VCKFBDSV9WRU5ET1JfSURfUkVESEFUX1FVTVJBTkVULAo+ID4gPiAgICAgICAgICAg
ICAgVklSVElPX1RSQU5TX0lEX05FVCwKPiA+ID4gICAgICAgICAgICAgIFBDSV9WRU5ET1JfSURf
SkFHVUFSTUlDUk8sCj4gPiA+ICAgICAgICAgICAgICBWSVJUSU9fSURfTkVUKSB9LAo+ID4gPiAg
ICAgeyBQQ0lfREVWSUNFX1NVQihQQ0lfVkVORE9SX0lEX1JFREhBVF9RVU1SQU5FVCwKPiA+ID4g
ICAgICAgICAgICAgIFZJUlRJT19UUkFOU19JRF9CTE9DSywKPiA+ID4gICAgICAgICAgICAgIFBD
SV9WRU5ET1JfSURfSkFHVUFSTUlDUk8sCj4gPiA+ICAgICAgICAgICAgICBWSVJUSU9fSURfQkxP
Q0spIH0sCj4gPiA+Cj4gPiAKPiA+IE9rYXkuIFNvIGl0J3MgYSB0cmFuc2l0aW9uYWwgZGV2aWNl
LiBUaGUgcXVlc3Rpb24sIHRoZW4sCj4gPiBpcyBob3cgY29tZSB5b3UgZW5kIHVwIHdpdGggZHJp
dmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYwo+ID4gd2l0aCBhIG1vZGVybiBsaW51eCBh
dCBhbGw/Cj4gPiBEaWQgeW91IGJ5IGNoYW5jZSBzZXQgZm9yY2VfbGVnYWN5ID0gdHJ1ZSA/Cj4g
WWVzLEkgY2FuIHByb3ZpZGUgbW9yZSBpbmZvcm1hdGlvbiBhYm91dCBpdC4KPiBXZSBjYW4gdGVz
dCBpdCB1c2UgZm9yY2VfbGVnYWN5ICxvciB3ZSB1c2UgYSBzZXJ2ZXIgd2l0aCBtdWx0aSBvcyBi
dXQgaXQgdXNlIG9ubHkgb25lIGNhcmQuCj4gVGhhbmtzLgoKT2theSwgc28gSSBkb24ndCB5ZXQg
c2VlIGxvdHMgb2YgdmFsdWUgb2YgbWVyZ2luZyB0aGlzIHBhdGNoIHVwc3RyZWFtLgpUaGUgcHJv
YmxlbWF0aWMgY29kZSBkb2VzIG5vdCBydW4gYnkgZGVmYXVsdCBhcyB0aGUgbW9kZXJuIGRyaXZl
ciBpcwp1c2VkLCBhbmQgYXBwbHlpbmcgdGhlIHBhdGNoIHVwc3RyZWFtIGRvZXMgbm90aGluZyB0
byBmaXggdGhlIG11bHRpLW9zCmNhc2UuCgpXaGF0IGRpZCBJIG1pc3M/CgoKLS0gCk1TVAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
