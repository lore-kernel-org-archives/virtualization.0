Return-Path: <SRS0=l/A6=KW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87356C47089
	for <virtualization@archiver.kernel.org>; Thu, 27 May 2021 03:48:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F2D2613D1
	for <virtualization@archiver.kernel.org>; Thu, 27 May 2021 03:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2D2613D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C2BA54023C;
	Thu, 27 May 2021 03:48:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QK05CUBmoTu5; Thu, 27 May 2021 03:48:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4D268400C7;
	Thu, 27 May 2021 03:48:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 137A6C000D;
	Thu, 27 May 2021 03:48:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6BC74C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 03:48:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 43E4D60717
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 03:48:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OxXOS6zI65cG
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 03:48:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D3B026071E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 03:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622087324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MndI0BhBeUi0uQEoIZPrttCcXIDrDdb+yFsBIF9E5vo=;
 b=AccJWYss/Te/UD1RWUo7yzuQ3r3zz/DpErmkZcUGAtrUccYrJ75cJWPAVWI8UNieC/GsYh
 TtqiWxYxcMTK+vZtf5sNBatRPgEZ4FTRpes9MJHq0cKxsnsbRJyQ54CdROXrk0oqJM5qrA
 C3LMXBj8vdxLrtoOp802O9k5Z/8zCZQ=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-eDP8vwGiPJy5ca9JGfEFCQ-1; Wed, 26 May 2021 23:48:43 -0400
X-MC-Unique: eDP8vwGiPJy5ca9JGfEFCQ-1
Received: by mail-pg1-f200.google.com with SMTP id
 m7-20020a6545c70000b029020f6af21c77so2151585pgr.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 20:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=MndI0BhBeUi0uQEoIZPrttCcXIDrDdb+yFsBIF9E5vo=;
 b=mfbRolluGsIjSi+9MBzZX0CnOsqV2savLdjb9ngETrdwKxJQfqtbSiM+lbQLzjGcHV
 1bw+cMb403xJEo2YzQH16kYsDyIk67FSOO+gmOJP1GuKSg4S8RnNnPWjTAeky5aDJyqc
 JS9iXtMnUVl5+/TGxwmhvozVWDb/co/esvM6yDd/onKuANLXY0cithOloRGbZPjyvjGG
 muLWTDsCkdDgTgqda5zJju2YMG343f3Q4ao4ErxE43IMkeKPbekQekxoooScjfeWzWqi
 M4XFkvAWhJ5KQ4RwjXJ4lGSNEXHZk1wIrPMQ0XTpzf4S2hgCwKrT4v/oMvG2QqZLnKFG
 YcKA==
X-Gm-Message-State: AOAM533PwID0claDUfFBpNIn7d9E22jAS5sj7ZDfIALvtrUuU+1CvgaS
 3FBbMCyb4vdy9vRyHGeIMKLBn/8oXXWaR2BrffSenHrr3T7yn0fXMz/9EMEbaACHMXDkpAzCV6Y
 w06JgZsnsmUAYCoBja7RioX6Vp8CY0CbVJOqGU03yFaVtoFIBGMlF2fRufxus0DuZtcm0beYtWW
 GbLuGmesLi81C/UZYmpw==
X-Received: by 2002:a17:90a:a014:: with SMTP id
 q20mr216663pjp.124.1622087321929; 
 Wed, 26 May 2021 20:48:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNORR0VqV287Fr5cVhBXhwufI/OJV8Yc3ib3KYYstK5HpQVoRCvYfjDvdmrv8qmwzcLetATA==
X-Received: by 2002:a17:90a:a014:: with SMTP id
 q20mr216615pjp.124.1622087321271; 
 Wed, 26 May 2021 20:48:41 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id s1sm553256pfc.6.2021.05.26.20.48.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 May 2021 20:48:40 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] virtio_net: move txq wakeups under tx q lock
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
References: <20210526082423.47837-1-mst@redhat.com>
 <20210526082423.47837-3-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <30c69182-cc6c-3e45-1db9-5b061e43e1d6@redhat.com>
Date: Thu, 27 May 2021 11:48:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210526082423.47837-3-mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 Wei Wang <weiwan@google.com>, David Miller <davem@davemloft.net>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNS8yNiDPws7nNDoyNCwgTWljaGFlbCBTLiBUc2lya2luINC0tcA6Cj4gV2UgY3Vy
cmVudGx5IGNoZWNrIG51bV9mcmVlIG91dHNpZGUgdHggcSBsb2NrCj4gd2hpY2ggaXMgdW5zYWZl
OiBuZXcgcGFja2V0cyBjYW4gYXJyaXZlIG1lYW53aGlsZQo+IGFuZCB0aGVyZSB3b24ndCBiZSBz
cGFjZSBpbiB0aGUgcXVldWUuCj4gVGh1cyBhIHNwdXJpb3VzIHF1ZXVlIHdha2V1cCBjYXVzaW5n
IG92ZXJoZWFkCj4gYW5kIGV2ZW4gcGFja2V0IGRyb3BzLgo+Cj4gTW92ZSB0aGUgY2hlY2sgdW5k
ZXIgdGhlIGxvY2sgdG8gZml4IHRoYXQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFMuIFRz
aXJraW4gPG1zdEByZWRoYXQuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPgoKCj4gLS0tCj4gICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCAxMyArKysr
KysrLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9u
cygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYwo+IGluZGV4IDEyNTEyZDEwMDJlYy4uYzI5ZjQyZDFlMDRmIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ICsrKyBiL2RyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYwo+IEBAIC0xNDM0LDExICsxNDM0LDEyIEBAIHN0YXRpYyB2b2lkIHZpcnRuZXRf
cG9sbF9jbGVhbnR4KHN0cnVjdCByZWNlaXZlX3F1ZXVlICpycSkKPiAgIAo+ICAgCWlmIChfX25l
dGlmX3R4X3RyeWxvY2sodHhxKSkgewo+ICAgCQlmcmVlX29sZF94bWl0X3NrYnMoc3EsIHRydWUp
Owo+ICsKPiArCQlpZiAoc3EtPnZxLT5udW1fZnJlZSA+PSAyICsgTUFYX1NLQl9GUkFHUykKPiAr
CQkJbmV0aWZfdHhfd2FrZV9xdWV1ZSh0eHEpOwo+ICsKPiAgIAkJX19uZXRpZl90eF91bmxvY2so
dHhxKTsKPiAgIAl9Cj4gLQo+IC0JaWYgKHNxLT52cS0+bnVtX2ZyZWUgPj0gMiArIE1BWF9TS0Jf
RlJBR1MpCj4gLQkJbmV0aWZfdHhfd2FrZV9xdWV1ZSh0eHEpOwo+ICAgfQo+ICAgCj4gICBzdGF0
aWMgaW50IHZpcnRuZXRfcG9sbChzdHJ1Y3QgbmFwaV9zdHJ1Y3QgKm5hcGksIGludCBidWRnZXQp
Cj4gQEAgLTE1MjIsNiArMTUyMyw5IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9wb2xsX3R4KHN0cnVj
dCBuYXBpX3N0cnVjdCAqbmFwaSwgaW50IGJ1ZGdldCkKPiAgIAl2aXJ0cXVldWVfZGlzYWJsZV9j
YihzcS0+dnEpOwo+ICAgCWZyZWVfb2xkX3htaXRfc2ticyhzcSwgdHJ1ZSk7Cj4gICAKPiArCWlm
IChzcS0+dnEtPm51bV9mcmVlID49IDIgKyBNQVhfU0tCX0ZSQUdTKQo+ICsJCW5ldGlmX3R4X3dh
a2VfcXVldWUodHhxKTsKPiArCj4gICAJb3BhcXVlID0gdmlydHF1ZXVlX2VuYWJsZV9jYl9wcmVw
YXJlKHNxLT52cSk7Cj4gICAKPiAgIAlkb25lID0gbmFwaV9jb21wbGV0ZV9kb25lKG5hcGksIDAp
Owo+IEBAIC0xNTQyLDkgKzE1NDYsNiBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcG9sbF90eChzdHJ1
Y3QgbmFwaV9zdHJ1Y3QgKm5hcGksIGludCBidWRnZXQpCj4gICAJCX0KPiAgIAl9Cj4gICAKPiAt
CWlmIChzcS0+dnEtPm51bV9mcmVlID49IDIgKyBNQVhfU0tCX0ZSQUdTKQo+IC0JCW5ldGlmX3R4
X3dha2VfcXVldWUodHhxKTsKPiAtCj4gICAJcmV0dXJuIDA7Cj4gICB9Cj4gICAKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
