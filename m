Return-Path: <SRS0=1MDK=KU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FCFC2B9F7
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 02:25:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4079B6141D
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 02:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4079B6141D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC15F402BE;
	Tue, 25 May 2021 02:25:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QvhEejxlFyGv; Tue, 25 May 2021 02:25:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E5194018C;
	Tue, 25 May 2021 02:25:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 174A6C000E;
	Tue, 25 May 2021 02:25:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62D6EC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 02:25:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 43B8660624
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 02:25:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H_REX6YJ3hMm
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 02:25:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 73D80600CC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 02:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621909527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1qoKlOsGh04ss63Lt/Lntwf9cwsxjTtguPKVdlfA3Ng=;
 b=jHVhLsPzCkcP8oBb7t9poZ5U9srPSl6NcazfsMAChNpGY1cM0cVp55iTuqyGZn8pV+Mf3X
 6WWnro47HfkrZa/6iMjya/sGC2g7HZtfNQk4SzGkdn8fBEFm32stFg0Lj0wUljIar81xBz
 yTFoYnkIfilky8THqs83vfGhYHEnn8k=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-JKYfX-D3MrqNl8lqNsC1vA-1; Mon, 24 May 2021 22:25:23 -0400
X-MC-Unique: JKYfX-D3MrqNl8lqNsC1vA-1
Received: by mail-pf1-f198.google.com with SMTP id
 a141-20020a621a930000b02902de0bf944f8so15051738pfa.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 19:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=1qoKlOsGh04ss63Lt/Lntwf9cwsxjTtguPKVdlfA3Ng=;
 b=hy7I308ZbtorJghwkFtzZoMHtzeZbXWmSfWE7+zM4spxKudEMooDZexA2nV4etEmtB
 4xk9z1cemjX+8qoWhcsYGsZ2m/DcG49Wii7DK229APbQbhxY/vYOpV6QH895zWaFabL4
 NX0AWeZgc/YwCtHfZVSXCIVVhHDauX/1Eg5Clv3oVhqct1chAP5efsjSkLJz5NidoLjT
 H2cH3CJR1dvjstKeg2vdC1IPd6YgqObR/VLfWEcOnbE33IEyefwkh9cw+0lMU5CmzBBQ
 ab7C/4P1t8CMUMaHTTNSgDY3JaLX9bMqNd331gFhIoGhVYFcYWbQhb9+38GAs8gZLLUE
 BxaA==
X-Gm-Message-State: AOAM532kCM/CtzYfPwXP0weUJJ8St9S8g6VE09GOWbVhR4vwcv0JrZsr
 2o0dCCz4rL+ZwNTQ+GMQUrCpYuslIETLZ+Von7hOCEVyFSJz9vynE4dDgWyKEGHOdnxPbSmIQD3
 Uo6vdBBdPyLwv7v8tdRyevH1bnuTNEqVlMFxsdsuZYQ==
X-Received: by 2002:a17:90b:4a12:: with SMTP id
 kk18mr28055328pjb.99.1621909522559; 
 Mon, 24 May 2021 19:25:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRV+qJUokH6c8EHK6OUiQ6oCyA7PhcBNQL+CnWJHhK5yhITE+2ZcU/lrqFBmiLVDRSYo1z9w==
X-Received: by 2002:a17:90b:4a12:: with SMTP id
 kk18mr28055310pjb.99.1621909522344; 
 Mon, 24 May 2021 19:25:22 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id d15sm3912029pfd.35.2021.05.24.19.25.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 May 2021 19:25:21 -0700 (PDT)
Subject: Re: [PATCH 2/3] virtio_blk: avoid repeating vblk->vqs[qid]
To: Stefan Hajnoczi <stefanha@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20210520141305.355961-1-stefanha@redhat.com>
 <20210520141305.355961-3-stefanha@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <caf006e5-760f-23c9-64a6-35cd6e1f33f4@redhat.com>
Date: Tue, 25 May 2021 10:25:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210520141305.355961-3-stefanha@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>
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

CtTaIDIwMjEvNS8yMCDPws7nMTA6MTMsIFN0ZWZhbiBIYWpub2N6aSDQtLXAOgo+IHN0cnVjdCB2
aXJ0aW9fYmxrX3ZxIGlzIGFjY2Vzc2VkIGluIG1hbnkgcGxhY2VzLiBJbnRyb2R1Y2UgInZicSIg
bG9jYWwKPiB2YXJpYWJsZXMgdG8gYXZvaWQgcmVwZWF0aW5nIHZibGstPnZxc1txaWRdIHRocm91
Z2hvdXQgdGhlIGNvZGUuIFRoZQo+IHBhdGNoZXMgdGhhdCBmb2xsb3cgd2lsbCBhZGQgbW9yZSBh
Y2Nlc3NlcywgbWFraW5nIHRoZSBwYXlvZmYgZXZlbgo+IGdyZWF0ZXIuCj4KPiB2aXJ0aW9fY29t
bWl0X3JxcygpIGNhbGxzIHRoZSBsb2NhbCB2YXJpYWJsZSAidnEiLCB3aGljaCBpcyBlYXNpbHkK
PiBjb25mdXNlZCB3aXRoIHN0cnVjdCB2aXJ0cXVldWUuIFJlbmFtZSB0byAidmJxIiBmb3IgY2xh
cml0eS4KPgo+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0
LmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0t
LQo+ICAgZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmMgfCAzNCArKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMTcg
ZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmMg
Yi9kcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYwo+IGluZGV4IGI5ZmEzZWY1YjU3Yy4uZmMwZmIx
ZGNkMzk5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvYmxvY2svdmlydGlvX2Jsay5jCj4gKysrIGIv
ZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmMKPiBAQCAtMTc0LDE2ICsxNzQsMTYgQEAgc3RhdGlj
IGlubGluZSB2b2lkIHZpcnRibGtfcmVxdWVzdF9kb25lKHN0cnVjdCByZXF1ZXN0ICpyZXEpCj4g
ICBzdGF0aWMgdm9pZCB2aXJ0YmxrX2RvbmUoc3RydWN0IHZpcnRxdWV1ZSAqdnEpCj4gICB7Cj4g
ICAJc3RydWN0IHZpcnRpb19ibGsgKnZibGsgPSB2cS0+dmRldi0+cHJpdjsKPiArCXN0cnVjdCB2
aXJ0aW9fYmxrX3ZxICp2YnEgPSAmdmJsay0+dnFzW3ZxLT5pbmRleF07Cj4gICAJYm9vbCByZXFf
ZG9uZSA9IGZhbHNlOwo+IC0JaW50IHFpZCA9IHZxLT5pbmRleDsKPiAgIAlzdHJ1Y3QgdmlydGJs
a19yZXEgKnZicjsKPiAgIAl1bnNpZ25lZCBsb25nIGZsYWdzOwo+ICAgCXVuc2lnbmVkIGludCBs
ZW47Cj4gICAKPiAtCXNwaW5fbG9ja19pcnFzYXZlKCZ2YmxrLT52cXNbcWlkXS5sb2NrLCBmbGFn
cyk7Cj4gKwlzcGluX2xvY2tfaXJxc2F2ZSgmdmJxLT5sb2NrLCBmbGFncyk7Cj4gICAJZG8gewo+
ICAgCQl2aXJ0cXVldWVfZGlzYWJsZV9jYih2cSk7Cj4gLQkJd2hpbGUgKCh2YnIgPSB2aXJ0cXVl
dWVfZ2V0X2J1Zih2YmxrLT52cXNbcWlkXS52cSwgJmxlbikpICE9IE5VTEwpIHsKPiArCQl3aGls
ZSAoKHZiciA9IHZpcnRxdWV1ZV9nZXRfYnVmKHZxLCAmbGVuKSkgIT0gTlVMTCkgewo+ICAgCQkJ
c3RydWN0IHJlcXVlc3QgKnJlcSA9IGJsa19tcV9ycV9mcm9tX3BkdSh2YnIpOwo+ICAgCj4gICAJ
CQlpZiAobGlrZWx5KCFibGtfc2hvdWxkX2Zha2VfdGltZW91dChyZXEtPnEpKSkKPiBAQCAtMTk3
LDMyICsxOTcsMzIgQEAgc3RhdGljIHZvaWQgdmlydGJsa19kb25lKHN0cnVjdCB2aXJ0cXVldWUg
KnZxKQo+ICAgCS8qIEluIGNhc2UgcXVldWUgaXMgc3RvcHBlZCB3YWl0aW5nIGZvciBtb3JlIGJ1
ZmZlcnMuICovCj4gICAJaWYgKHJlcV9kb25lKQo+ICAgCQlibGtfbXFfc3RhcnRfc3RvcHBlZF9o
d19xdWV1ZXModmJsay0+ZGlzay0+cXVldWUsIHRydWUpOwo+IC0Jc3Bpbl91bmxvY2tfaXJxcmVz
dG9yZSgmdmJsay0+dnFzW3FpZF0ubG9jaywgZmxhZ3MpOwo+ICsJc3Bpbl91bmxvY2tfaXJxcmVz
dG9yZSgmdmJxLT5sb2NrLCBmbGFncyk7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyB2b2lkIHZpcnRp
b19jb21taXRfcnFzKHN0cnVjdCBibGtfbXFfaHdfY3R4ICpoY3R4KQo+ICAgewo+ICAgCXN0cnVj
dCB2aXJ0aW9fYmxrICp2YmxrID0gaGN0eC0+cXVldWUtPnF1ZXVlZGF0YTsKPiAtCXN0cnVjdCB2
aXJ0aW9fYmxrX3ZxICp2cSA9ICZ2YmxrLT52cXNbaGN0eC0+cXVldWVfbnVtXTsKPiArCXN0cnVj
dCB2aXJ0aW9fYmxrX3ZxICp2YnEgPSAmdmJsay0+dnFzW2hjdHgtPnF1ZXVlX251bV07Cj4gICAJ
Ym9vbCBraWNrOwo+ICAgCj4gLQlzcGluX2xvY2tfaXJxKCZ2cS0+bG9jayk7Cj4gLQlraWNrID0g
dmlydHF1ZXVlX2tpY2tfcHJlcGFyZSh2cS0+dnEpOwo+IC0Jc3Bpbl91bmxvY2tfaXJxKCZ2cS0+
bG9jayk7Cj4gKwlzcGluX2xvY2tfaXJxKCZ2YnEtPmxvY2spOwo+ICsJa2ljayA9IHZpcnRxdWV1
ZV9raWNrX3ByZXBhcmUodmJxLT52cSk7Cj4gKwlzcGluX3VubG9ja19pcnEoJnZicS0+bG9jayk7
Cj4gICAKPiAgIAlpZiAoa2ljaykKPiAtCQl2aXJ0cXVldWVfbm90aWZ5KHZxLT52cSk7Cj4gKwkJ
dmlydHF1ZXVlX25vdGlmeSh2YnEtPnZxKTsKPiAgIH0KPiAgIAo+ICAgc3RhdGljIGJsa19zdGF0
dXNfdCB2aXJ0aW9fcXVldWVfcnEoc3RydWN0IGJsa19tcV9od19jdHggKmhjdHgsCj4gICAJCQkg
ICBjb25zdCBzdHJ1Y3QgYmxrX21xX3F1ZXVlX2RhdGEgKmJkKQo+ICAgewo+ICAgCXN0cnVjdCB2
aXJ0aW9fYmxrICp2YmxrID0gaGN0eC0+cXVldWUtPnF1ZXVlZGF0YTsKPiArCXN0cnVjdCB2aXJ0
aW9fYmxrX3ZxICp2YnEgPSAmdmJsay0+dnFzW2hjdHgtPnF1ZXVlX251bV07Cj4gICAJc3RydWN0
IHJlcXVlc3QgKnJlcSA9IGJkLT5ycTsKPiAgIAlzdHJ1Y3QgdmlydGJsa19yZXEgKnZiciA9IGJs
a19tcV9ycV90b19wZHUocmVxKTsKPiAgIAl1bnNpZ25lZCBsb25nIGZsYWdzOwo+ICAgCXVuc2ln
bmVkIGludCBudW07Cj4gLQlpbnQgcWlkID0gaGN0eC0+cXVldWVfbnVtOwo+ICAgCWludCBlcnI7
Cj4gICAJYm9vbCBub3RpZnkgPSBmYWxzZTsKPiAgIAlib29sIHVubWFwID0gZmFsc2U7Cj4gQEAg
LTI3NCwxNiArMjc0LDE2IEBAIHN0YXRpYyBibGtfc3RhdHVzX3QgdmlydGlvX3F1ZXVlX3JxKHN0
cnVjdCBibGtfbXFfaHdfY3R4ICpoY3R4LAo+ICAgCQkJdmJyLT5vdXRfaGRyLnR5cGUgfD0gY3B1
X3RvX3ZpcnRpbzMyKHZibGstPnZkZXYsIFZJUlRJT19CTEtfVF9JTik7Cj4gICAJfQo+ICAgCj4g
LQlzcGluX2xvY2tfaXJxc2F2ZSgmdmJsay0+dnFzW3FpZF0ubG9jaywgZmxhZ3MpOwo+IC0JZXJy
ID0gdmlydGJsa19hZGRfcmVxKHZibGstPnZxc1txaWRdLnZxLCB2YnIsIHZici0+c2csIG51bSk7
Cj4gKwlzcGluX2xvY2tfaXJxc2F2ZSgmdmJxLT5sb2NrLCBmbGFncyk7Cj4gKwllcnIgPSB2aXJ0
YmxrX2FkZF9yZXEodmJxLT52cSwgdmJyLCB2YnItPnNnLCBudW0pOwo+ICAgCWlmIChlcnIpIHsK
PiAtCQl2aXJ0cXVldWVfa2ljayh2YmxrLT52cXNbcWlkXS52cSk7Cj4gKwkJdmlydHF1ZXVlX2tp
Y2sodmJxLT52cSk7Cj4gICAJCS8qIERvbid0IHN0b3AgdGhlIHF1ZXVlIGlmIC1FTk9NRU06IHdl
IG1heSBoYXZlIGZhaWxlZCB0bwo+ICAgCQkgKiBib3VuY2UgdGhlIGJ1ZmZlciBkdWUgdG8gZ2xv
YmFsIHJlc291cmNlIG91dGFnZS4KPiAgIAkJICovCj4gICAJCWlmIChlcnIgPT0gLUVOT1NQQykK
PiAgIAkJCWJsa19tcV9zdG9wX2h3X3F1ZXVlKGhjdHgpOwo+IC0JCXNwaW5fdW5sb2NrX2lycXJl
c3RvcmUoJnZibGstPnZxc1txaWRdLmxvY2ssIGZsYWdzKTsKPiArCQlzcGluX3VubG9ja19pcnFy
ZXN0b3JlKCZ2YnEtPmxvY2ssIGZsYWdzKTsKPiAgIAkJc3dpdGNoIChlcnIpIHsKPiAgIAkJY2Fz
ZSAtRU5PU1BDOgo+ICAgCQkJcmV0dXJuIEJMS19TVFNfREVWX1JFU09VUkNFOwo+IEBAIC0yOTQs
MTIgKzI5NCwxMiBAQCBzdGF0aWMgYmxrX3N0YXR1c190IHZpcnRpb19xdWV1ZV9ycShzdHJ1Y3Qg
YmxrX21xX2h3X2N0eCAqaGN0eCwKPiAgIAkJfQo+ICAgCX0KPiAgIAo+IC0JaWYgKGJkLT5sYXN0
ICYmIHZpcnRxdWV1ZV9raWNrX3ByZXBhcmUodmJsay0+dnFzW3FpZF0udnEpKQo+ICsJaWYgKGJk
LT5sYXN0ICYmIHZpcnRxdWV1ZV9raWNrX3ByZXBhcmUodmJxLT52cSkpCj4gICAJCW5vdGlmeSA9
IHRydWU7Cj4gLQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZ2YmxrLT52cXNbcWlkXS5sb2NrLCBm
bGFncyk7Cj4gKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZ2YnEtPmxvY2ssIGZsYWdzKTsKPiAg
IAo+ICAgCWlmIChub3RpZnkpCj4gLQkJdmlydHF1ZXVlX25vdGlmeSh2YmxrLT52cXNbcWlkXS52
cSk7Cj4gKwkJdmlydHF1ZXVlX25vdGlmeSh2YnEtPnZxKTsKPiAgIAlyZXR1cm4gQkxLX1NUU19P
SzsKPiAgIH0KPiAgIAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
