Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3DCC433B4
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 13:30:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E92C561369
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 13:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92C561369
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A77DE40170;
	Tue, 13 Apr 2021 13:30:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id biUSaxu378Y1; Tue, 13 Apr 2021 13:30:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5051A400D7;
	Tue, 13 Apr 2021 13:30:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35124C000B;
	Tue, 13 Apr 2021 13:30:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2EDCAC000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 13:30:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 15E2B83DE4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 13:30:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZWSNxTPeWtIP
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 13:30:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3EA7083DCD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 13:30:16 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id n2so25904664ejy.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 06:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Q/tE+NF4FAO9b03a65yYIPZna6Nz00Nl9rOu80h2ZFM=;
 b=LUTPQI5iqn6jrlhKJwksPMPfAmI226R77m/lN8gGvZ9LVNlU81aiXbzNCa2ik7JoqM
 +0N/ns7FPAtK0EQXqRhdCU7Ksu3G/bJNq/V01Rr3LlMCiKOYfVJ7sFNWyS4LZZoEmear
 17J9ITFAKQ8aGtCbily+E4ADx5cIDwejHIbOai6a6kqwxiBorw3Xln7s0mr4zU9i/jdw
 ZacxUB6esVUc4gnyMr7Qg+C9/uiEeAXWVjyQ1xWZ+7u2VVEJUAyGNl5LjPVC9/fkfLxs
 YVGyn+EcBGjn4SjTa3tQWxFSCmCDdLK5M6Bs8YDX7YWuAeypOuhmn2NZCcyyrJqidKgz
 xzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Q/tE+NF4FAO9b03a65yYIPZna6Nz00Nl9rOu80h2ZFM=;
 b=aaSrDbFyO2a87ZfmG21gWgR2Iwij1Jzi22NmVaNREFNX/s2eivHdSv2evKHjBGMlur
 +YSdr1NvNUgRq5EB0mCvNBABpGZqLydJ1jqW5uXkIYi/3xBZcAUwfx2qdvWuKtaCoCcK
 dJQ0C53dAQ11gtDaF9a0mUiW/212sA0CckhxRcl9Q1mcq51O6R/vHa6UnUtZ1Wo5XDBC
 Fkujj4/N74HI2gXCIscLci3KDDYBtAKwr5qBHPCSh2v3pAyWJhNDc1D4cJ//PVCcvGmu
 pWj+e50Da9vqJVgspPP64DJLTr4ImS/l7LZKbKxoWy52SN0m91rxDDmVhgHRalWhttV+
 GbGw==
X-Gm-Message-State: AOAM533YYK0RwLu4TLFDLvOTfM0HzmiLxFNQQV+nwgUvcCivHLx0aU8a
 vvxkCP9/RNyz9Dc7B4E4OAgZ1jWWJFxnag==
X-Google-Smtp-Source: ABdhPJzWl4ndaGNfra+lpSLPl0QPsD+swM9pJkfoFUR+wZvYqsQaVeFWl8Nt54R/dU+pKv/uHUcMOg==
X-Received: by 2002:a17:907:7051:: with SMTP id
 ws17mr8723211ejb.498.1618320614230; 
 Tue, 13 Apr 2021 06:30:14 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com.
 [209.85.128.46])
 by smtp.gmail.com with ESMTPSA id b22sm9097667edv.96.2021.04.13.06.30.12
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Apr 2021 06:30:13 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id
 q123-20020a1c43810000b029012c7d852459so1099974wma.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 06:30:12 -0700 (PDT)
X-Received: by 2002:a1c:2941:: with SMTP id p62mr41887wmp.120.1618320600066;
 Tue, 13 Apr 2021 06:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210412175341-mutt-send-email-mst@kernel.org>
 <20210412183054-mutt-send-email-mst@kernel.org>
 <cebebed3-7a92-5471-117f-774286731cf5@redhat.com>
 <20210413004420-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210413004420-mutt-send-email-mst@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 13 Apr 2021 09:29:21 -0400
X-Gmail-Original-Message-ID: <CA+FuTSdhU6rYzGwcugUo7cfDY+-YDu_hu7bx0d0Cqi03dDj08A@mail.gmail.com>
Message-ID: <CA+FuTSdhU6rYzGwcugUo7cfDY+-YDu_hu7bx0d0Cqi03dDj08A@mail.gmail.com>
Subject: Re: virtio-net: locking in tx napi
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
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

T24gVHVlLCBBcHIgMTMsIDIwMjEgYXQgMTI6NDQgQU0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBUdWUsIEFwciAxMywgMjAyMSBhdCAxMDoyOTowM0FN
ICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4KPiA+IOWcqCAyMDIxLzQvMTMg5LiK5Y2INjoz
MSwgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPiA+ID4gT24gTW9uLCBBcHIgMTIsIDIwMjEg
YXQgMDY6MDM6NTBQTSAtMDQwMCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4gPiA+IEkg
d2FzIHdvcmtpbmcgb24gdGhlIHNwdXJpb3MgaW50ZXJydXB0IHByb2JsZW0gYW5kCj4gPiA+ID4g
SSBub3RpY2VkIHNvbWV0aGluZyB3ZWlyZC4KPiA+ID4gPgo+ID4gPiA+IHN0YXRpYyBpbnQgdmly
dG5ldF9wb2xsX3R4KHN0cnVjdCBuYXBpX3N0cnVjdCAqbmFwaSwgaW50IGJ1ZGdldCkKPiA+ID4g
PiB7Cj4gPiA+ID4gICAgICAgICAgc3RydWN0IHNlbmRfcXVldWUgKnNxID0gY29udGFpbmVyX29m
KG5hcGksIHN0cnVjdCBzZW5kX3F1ZXVlLCBuYXBpKTsKPiA+ID4gPiAgICAgICAgICBzdHJ1Y3Qg
dmlydG5ldF9pbmZvICp2aSA9IHNxLT52cS0+dmRldi0+cHJpdjsKPiA+ID4gPiAgICAgICAgICB1
bnNpZ25lZCBpbnQgaW5kZXggPSB2cTJ0eHEoc3EtPnZxKTsKPiA+ID4gPiAgICAgICAgICBzdHJ1
Y3QgbmV0ZGV2X3F1ZXVlICp0eHE7Cj4gPiA+ID4KPiA+ID4gPiAgICAgICAgICBpZiAodW5saWtl
bHkoaXNfeGRwX3Jhd19idWZmZXJfcXVldWUodmksIGluZGV4KSkpIHsKPiA+ID4gPiAgICAgICAg
ICAgICAgICAgIC8qIFdlIGRvbid0IG5lZWQgdG8gZW5hYmxlIGNiIGZvciBYRFAgKi8KPiA+ID4g
PiAgICAgICAgICAgICAgICAgIG5hcGlfY29tcGxldGVfZG9uZShuYXBpLCAwKTsKPiA+ID4gPiAg
ICAgICAgICAgICAgICAgIHJldHVybiAwOwo+ID4gPiA+ICAgICAgICAgIH0KPiA+ID4gPgo+ID4g
PiA+ICAgICAgICAgIHR4cSA9IG5ldGRldl9nZXRfdHhfcXVldWUodmktPmRldiwgaW5kZXgpOwo+
ID4gPiA+ICAgICAgICAgIF9fbmV0aWZfdHhfbG9jayh0eHEsIHJhd19zbXBfcHJvY2Vzc29yX2lk
KCkpOwo+ID4gPiA+ICAgICAgICAgIGZyZWVfb2xkX3htaXRfc2ticyhzcSwgdHJ1ZSk7Cj4gPiA+
ID4gICAgICAgICAgX19uZXRpZl90eF91bmxvY2sodHhxKTsKPiA+ID4gPiAgICAgICAgICB2aXJ0
cXVldWVfbmFwaV9jb21wbGV0ZShuYXBpLCBzcS0+dnEsIDApOwo+ID4gPiA+ICAgICAgICAgIGlm
IChzcS0+dnEtPm51bV9mcmVlID49IDIgKyBNQVhfU0tCX0ZSQUdTKQo+ID4gPiA+ICAgICAgICAg
ICAgICAgICAgbmV0aWZfdHhfd2FrZV9xdWV1ZSh0eHEpOwo+ID4gPiA+ICAgICAgICAgIHJldHVy
biAwOwo+ID4gPiA+IH0KPiA+ID4gPgo+ID4gPiA+IFNvIHZpcnRxdWV1ZV9uYXBpX2NvbXBsZXRl
IGlzIGNhbGxlZCB3aGVuIHR4cSBpcyBub3QgbG9ja2VkLAo+ID4gPiA+IHRoaW5rYWJseSBzdGFy
dF94bWl0IGNhbiBoYXBwZW4gcmlnaHQ/Cj4gPgo+ID4KPiA+IFllcywgSSB0aGluayBzby4KCkFn
cmVlZC4KCkkgc2VlIEknbSBxdWl0ZSBhIGZldyBlbWFpbHMgYmVoaW5kIGFscmVhZHkuIFdpbGwg
cmVzcG9uZCBpbiBtb3JlCmRldGFpbCB0byB0aGUgbGF0ZXN0IHBhdGNoIHNlcmllcy4KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
