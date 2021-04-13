Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983CCC433B4
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 14:21:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 396B760FE8
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 14:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 396B760FE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F072E40202;
	Tue, 13 Apr 2021 14:21:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3z0BHB8RFF2t; Tue, 13 Apr 2021 14:21:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6848E4032F;
	Tue, 13 Apr 2021 14:21:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35A60C000C;
	Tue, 13 Apr 2021 14:21:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70F5AC000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 14:21:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 52BCC60B94
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 14:21:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gttccDspMlnB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 14:21:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7F27660A43
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 14:21:22 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id e7so19578435edu.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 07:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XSb26jWChq8UeB+2eG8t5Jx3KUuQ9YtghNH+PRQLkiY=;
 b=k3pN5OC9G/4r78rKs51gKlPvO4wrZICaChTRKTnSRjLSywsKf07n6zNAkTF9Ne1o4d
 +jFK5LbkH7qequCu3zp6PMfMIm0ZOqF5tQlMU0FGle1bTjVZLJYlQJqn4U8NEhpucNnK
 upY+Bcj95F9aZorRKFwRu8uZpDWhTgjb1el7yjPiVJflv59Bpb45WnIk5jmJLP0/WSUJ
 BbJ41+ChRp+bHpKKF3AwHOPh6M4x+EpQpr9PBhRcCxneHRBxhfbLih/fLud/nBSq/lr7
 WMnE0Jd8qUIx5+9/WdOvi8uPusmIJAX0Vwg0Ct7EoqfpeCxI/6a+2yov8TTZQDnLK2L4
 yoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XSb26jWChq8UeB+2eG8t5Jx3KUuQ9YtghNH+PRQLkiY=;
 b=QOjykOJNlPCggl5zt6Q/Sw4qkW+MII0zpNWE1kxVOSxWuAVEh/p591q6Jgxpa27OOq
 OhgeQVQUNLd8n/mHZt8IlfK4E4FbhhxycOWypdnnDLL106Zi54lSB9hxMqK+a5wSq/Ni
 1ZPCWXN3Q+yQsq3ZuJmcSH0lPAgCvZA6CkaQ61ahuE2hGgaQ0aaxTP6VcwhjHIpBV5lp
 rJU7MhdKjPWleAWUr3dADPuNmrq2TRaUvsbXuD96WW58bXCYbhfdb82pouwM5LXPGXaJ
 qCFPKrj73Ai5A13sVX9AUEg38Sp/9mi9+dmyRnz5YSKqLo9JEORkZ43Ymf1tdpRH+A2o
 dVDw==
X-Gm-Message-State: AOAM532l3647g0VLMHxr1FwWmBfP0aeUvKODryHEj5oA+oGOctkp/DQA
 W01S0tp/5YjtnX4uWM4gLI+3QVpLG9LESw==
X-Google-Smtp-Source: ABdhPJxKp+EpdCyg+H0L0gPfnC942fHdXNEgQbs0FLtL99pDhPrSOnPeGCkO0R/fSJdM+OcfZ7fu6Q==
X-Received: by 2002:a05:6402:6c2:: with SMTP id
 n2mr35266339edy.110.1618323679991; 
 Tue, 13 Apr 2021 07:21:19 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com.
 [209.85.221.48])
 by smtp.gmail.com with ESMTPSA id t14sm2680638ejj.77.2021.04.13.07.21.17
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Apr 2021 07:21:18 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id k26so239689wrc.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 07:21:17 -0700 (PDT)
X-Received: by 2002:a5d:510d:: with SMTP id s13mr37457079wrt.12.1618323677563; 
 Tue, 13 Apr 2021 07:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210413054733.36363-1-mst@redhat.com>
 <20210413054733.36363-4-mst@redhat.com>
 <805053bf-960f-3c34-ce23-012d121ca937@redhat.com>
 <20210413100222-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210413100222-mutt-send-email-mst@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 13 Apr 2021 10:20:39 -0400
X-Gmail-Original-Message-ID: <CA+FuTSe=3cAkhwjSDDt1U8mSiVj5BKgJ7DJGxAAoF22kac3CMQ@mail.gmail.com>
Message-ID: <CA+FuTSe=3cAkhwjSDDt1U8mSiVj5BKgJ7DJGxAAoF22kac3CMQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 3/4] virtio_net: move tx vq operation under tx
 queue lock
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Network Development <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVHVlLCBBcHIgMTMsIDIwMjEgYXQgMTA6MDMgQU0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBUdWUsIEFwciAxMywgMjAyMSBhdCAwNDo1NDo0MlBN
ICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4KPiA+IOWcqCAyMDIxLzQvMTMg5LiL5Y2IMTo0
NywgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPiA+ID4gSXQncyB1bnNhZmUgdG8gb3BlcmF0
ZSBhIHZxIGZyb20gbXVsdGlwbGUgdGhyZWFkcy4KPiA+ID4gVW5mb3J0dW5hdGVseSB0aGlzIGlz
IGV4YWN0bHkgd2hhdCB3ZSBkbyB3aGVuIGludm9raW5nCj4gPiA+IGNsZWFuIHR4IHBvbGwgZnJv
bSByeCBuYXBpLgoKQWN0dWFsbHksIHRoZSBpc3N1ZSBnb2VzIGJhY2sgdG8gdGhlIG5hcGktdHgg
ZXZlbiB3aXRob3V0IHRoZQpvcHBvcnR1bmlzdGljIGNsZWFuaW5nIGZyb20gdGhlIHJlY2VpdmUg
aW50ZXJydXB0LCBJIHRoaW5rPyBUaGF0IHJhY2VzCndpdGggcHJvY2Vzc2luZyB0aGUgdnEgaW4g
c3RhcnRfeG1pdC4KCj4gPiA+IEFzIGEgZml4IG1vdmUgZXZlcnl0aGluZyB0aGF0IGRlYWxzIHdp
dGggdGhlIHZxIHRvIHVuZGVyIHR4IGxvY2suCj4gPiA+CgpJZiB0aGUgYWJvdmUgaXMgY29ycmVj
dDoKCkZpeGVzOiBiOTJmMWU2NzUxYTYgKCJ2aXJ0aW8tbmV0OiB0cmFuc21pdCBuYXBpIikKCj4g
PiA+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+Cj4g
PiA+IC0tLQo+ID4gPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDIyICsrKysrKysrKysr
KysrKysrKysrKy0KPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQo+ID4gPgo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25l
dC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+IGluZGV4IDE2ZDVhYmVkNTgyYy4u
NDYwY2NkYmI4NDBlIDEwMDY0NAo+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMK
PiA+ID4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+IEBAIC0xNTA1LDYgKzE1
MDUsOCBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcG9sbF90eChzdHJ1Y3QgbmFwaV9zdHJ1Y3QgKm5h
cGksIGludCBidWRnZXQpCj4gPiA+ICAgICBzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSA9IHNxLT52
cS0+dmRldi0+cHJpdjsKPiA+ID4gICAgIHVuc2lnbmVkIGludCBpbmRleCA9IHZxMnR4cShzcS0+
dnEpOwo+ID4gPiAgICAgc3RydWN0IG5ldGRldl9xdWV1ZSAqdHhxOwo+ID4gPiArICAgaW50IG9w
YXF1ZTsKCm5pdDogdmlydHF1ZXVlX25hcGlfY29tcGxldGUgYWxzbyBzdG9yZXMgYXMgaW50IG9w
YXF1ZSwgYnV0CnZpcnRxdWV1ZV9lbmFibGVfY2JfcHJlcGFyZSBhY3R1YWxseSByZXR1cm5zLCBh
bmQgdmlydHF1ZXVlX3BvbGwKZXhwZWN0cywgYW4gdW5zaWduZWQgaW50LiBJbiB0aGUgZW5kLCBj
b252ZXJzaW9uIHdvcmtzIGNvcnJlY3RseS4gQnV0CmNsZWFuZXIgdG8gdXNlIHRoZSByZWFsIHR5
cGUuCgo+ID4gPiArICAgYm9vbCBkb25lOwo+ID4gPiAgICAgaWYgKHVubGlrZWx5KGlzX3hkcF9y
YXdfYnVmZmVyX3F1ZXVlKHZpLCBpbmRleCkpKSB7Cj4gPiA+ICAgICAgICAgICAgIC8qIFdlIGRv
bid0IG5lZWQgdG8gZW5hYmxlIGNiIGZvciBYRFAgKi8KPiA+ID4gQEAgLTE1MTQsMTAgKzE1MTYs
MjggQEAgc3RhdGljIGludCB2aXJ0bmV0X3BvbGxfdHgoc3RydWN0IG5hcGlfc3RydWN0ICpuYXBp
LCBpbnQgYnVkZ2V0KQo+ID4gPiAgICAgdHhxID0gbmV0ZGV2X2dldF90eF9xdWV1ZSh2aS0+ZGV2
LCBpbmRleCk7Cj4gPiA+ICAgICBfX25ldGlmX3R4X2xvY2sodHhxLCByYXdfc21wX3Byb2Nlc3Nv
cl9pZCgpKTsKPiA+ID4gKyAgIHZpcnRxdWV1ZV9kaXNhYmxlX2NiKHNxLT52cSk7Cj4gPiA+ICAg
ICBmcmVlX29sZF94bWl0X3NrYnMoc3EsIHRydWUpOwo+ID4gPiArCj4gPiA+ICsgICBvcGFxdWUg
PSB2aXJ0cXVldWVfZW5hYmxlX2NiX3ByZXBhcmUoc3EtPnZxKTsKPiA+ID4gKwo+ID4gPiArICAg
ZG9uZSA9IG5hcGlfY29tcGxldGVfZG9uZShuYXBpLCAwKTsKPiA+ID4gKwo+ID4gPiArICAgaWYg
KCFkb25lKQo+ID4gPiArICAgICAgICAgICB2aXJ0cXVldWVfZGlzYWJsZV9jYihzcS0+dnEpOwo+
ID4gPiArCj4gPiA+ICAgICBfX25ldGlmX3R4X3VubG9jayh0eHEpOwo+ID4gPiAtICAgdmlydHF1
ZXVlX25hcGlfY29tcGxldGUobmFwaSwgc3EtPnZxLCAwKTsKPiA+Cj4gPgo+ID4gU28gSSB3b25k
ZXIgd2h5IG5vdCBzaW1wbHkgbW92ZSBfX25ldGlmX3R4X3VubG9jaygpIGFmdGVyCj4gPiB2aXJ0
cXVldWVfbmFwaV9jb21wbGV0ZSgpPwo+ID4KPiA+IFRoYW5rcwo+ID4KPgo+Cj4gQmVjYXVzZSB0
aGF0IGNhbGxzIHR4IHBvbGwgd2hpY2ggYWxzbyB0YWtlcyB0eCBsb2NrIGludGVybmFsbHkgLi4u
Cgp3aGljaCB0eCBwb2xsPwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
