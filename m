Return-Path: <SRS0=jANb=LB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AB2C4743E
	for <virtualization@archiver.kernel.org>; Mon,  7 Jun 2021 02:11:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 786CA610E7
	for <virtualization@archiver.kernel.org>; Mon,  7 Jun 2021 02:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786CA610E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3392B4032C;
	Mon,  7 Jun 2021 02:11:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yTpOz1NlICOr; Mon,  7 Jun 2021 02:11:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E3B040329;
	Mon,  7 Jun 2021 02:11:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E31FC000E;
	Mon,  7 Jun 2021 02:11:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43823C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:11:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 329D3605DC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:11:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RfVqgV9mk_mo
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:11:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 72E9C605BC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623031894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A/EuEKKNsDXHQ7kk/CTUamf7HDQxmDfNXZ1E2EtyO34=;
 b=W61f+nb2PPDA/L8J86BNJ7WCby0KHPJ8A0/GWe7TVEaI9dvgqi/BXKpQj/wUIqvDEGa/fk
 2DK2Ie0GFSFfyXcqX+5gt5AXAXSQo7DL3lSC/FJUI1f830/HsZV8ZwvGXrThAIG0XIzfIz
 3yKQ6A9R25oBzHErZTm0O9vIvm2gwco=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-NocgIF_nN0WeC9AWgUvttA-1; Sun, 06 Jun 2021 22:11:30 -0400
X-MC-Unique: NocgIF_nN0WeC9AWgUvttA-1
Received: by mail-pf1-f198.google.com with SMTP id
 e17-20020aa798110000b02902f12fffef4eso227320pfl.7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 06 Jun 2021 19:11:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=A/EuEKKNsDXHQ7kk/CTUamf7HDQxmDfNXZ1E2EtyO34=;
 b=k90VJNClUjfGlhMxcTGrrDQCWCTYYOP2IFU1Ibj6BmfZ9H32hVcZZmot2DIePDHRe4
 keOk+tl6vsx/t6umH04FRGythw8JarMJoc7ILKpakxJRNI7IOe125o39SaD+xlBqLJdB
 TntnbQaOAXfIc41crQ/TK3cDQfZ/u9a4HxXdY6VMKpbCdnfGqGZqm//cFbld6ldjQEFJ
 icHi5SJeJe1/avA1Cn4P7XqFkD6ODssqqbNO+RLDDYd3s5q3NOcXiR+ShW02vAZ2W4VE
 +1NbLcd9w4mDZEEYeTJpL6PuwpKCooFO8rKt+DHPM6d/Kvjfbwo7D75BQOHwYwdc3M9D
 4lCg==
X-Gm-Message-State: AOAM532ASIQzKT2IGAcNQwhptaDWV9AGKFnRrwKH8+a++U8BxYiE93Jz
 Lu2fhYa+6YOVF9s1O8ViK948/+AD1UhVRWXbfd75o9uBtCYurQcWrOxE6N+qrO3N0pgtRYgo4Jr
 laf/GAbiH9uNvUoAv3J/h2+s7zNeXtrjc5eIw9KalwQ==
X-Received: by 2002:a17:90a:17ad:: with SMTP id
 q42mr30280703pja.181.1623031889718; 
 Sun, 06 Jun 2021 19:11:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAx4rB2M3pplY+UpbwardmP9ceIokSBmI4mAdVk+jKYwUSzn/gx2IwSAPiLV02x1ehjAP2dg==
X-Received: by 2002:a17:90a:17ad:: with SMTP id
 q42mr30280685pja.181.1623031889551; 
 Sun, 06 Jun 2021 19:11:29 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id h16sm6699394pfk.119.2021.06.06.19.11.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Jun 2021 19:11:29 -0700 (PDT)
Subject: Re: [PATCH v1] vdp/mlx5: Fix setting the correct dma_device
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210606053150.170489-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fa91edcc-2c99-311d-3501-8643e37c83de@redhat.com>
Date: Mon, 7 Jun 2021 10:11:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210606053150.170489-1-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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

CtTaIDIwMjEvNi82IM/CzucxOjMxLCBFbGkgQ29oZW4g0LS1wDoKPiBCZWZvcmUgU0Ygc3VwcG9y
dCB3YXMgaW50cm9kdWNlZCwgdGhlIERNQSBkZXZpY2Ugd2FzIGVxdWFsIHRvCj4gbWRldi0+ZGV2
aWNlIHdoaWNoIHdhcyBpbiBlc3NlbmNlIGVxdWFsIHRvIHBkZXYtPmRldi4KPgo+IFdpdGggU0Yg
aW50cm9kdWN0aW9uIHRoaXMgaXMgbm8gbG9uZ2VyIHRydWUuIEl0IGhhcyBhbHJlYWR5IGJlZW4K
PiBoYW5kbGVkIGZvciB2aG9zdF92ZHBhIHNpbmNlIHRoZSByZWZlcmVuY2UgdG8gdGhlIGRtYSBk
ZXZpY2UgY2FuIGZyb20KPiB3aXRoaW4gbWx4NV92ZHBhLiBXaXRoIHZpcnRpb192ZHBhIHRoaXMg
YnJva2UuIFRvIGZpeCB0aGlzIHdlIHNldCB0aGUKPiByZWFsIGRtYSBkZXZpY2Ugd2hlbiBpbml0
aWFsaXppbmcgdGhlIGRldmljZS4KPgo+IEluIGFkZGl0aW9uLCBmb3IgdGhlIHNha2Ugb2YgY29u
c2lzdGVuY3ksIHByZXZpb3VzIHJlZmVyZW5jZXMgaW4gdGhlCj4gY29kZSB0byB0aGUgZG1hIGRl
dmljZSBhcmUgY2hhbmdlZCB0byB2ZGV2LT5kbWFfZGV2Lgo+Cj4gRml4ZXM6IGQxM2ExNWQ1NDRj
ZTUgKCJ2ZHBhL21seDU6IFVzZSB0aGUgY29ycmVjdCBkbWEgZGV2aWNlIHdoZW4gcmVnaXN0ZXJp
bmcgbWVtb3J5IikKPiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4K
CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+IHYw
IC0tPiB2MToKPiAgICAgQ2hhbmdlIGJsYW1lZCBjb21taXQgYW5kIG1vZGlmeSByZWZlcmVuY2Vz
IHRvIHRoZSBkbWEgZGV2aWNlCj4KPiAgIGRyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYyAgICAg
ICB8IDkgKystLS0tLS0tCj4gICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCAy
ICstCj4gICAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMgYi9kcml2ZXJzL3Zk
cGEvbWx4NS9jb3JlL21yLmMKPiBpbmRleCBmMGI4OWI2MmRlMzYuLmRjZWU2MDM5ZTk2NiAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMKPiArKysgYi9kcml2ZXJzL3Zk
cGEvbWx4NS9jb3JlL21yLmMKPiBAQCAtMjE5LDExICsyMTksNiBAQCBzdGF0aWMgdm9pZCBkZXN0
cm95X2luZGlyZWN0X2tleShzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHN0cnVjdCBtbHg1
X3ZkcGFfbQo+ICAgCW1seDVfdmRwYV9kZXN0cm95X21rZXkobXZkZXYsICZta2V5LT5ta2V5KTsK
PiAgIH0KPiAgIAo+IC1zdGF0aWMgc3RydWN0IGRldmljZSAqZ2V0X2RtYV9kZXZpY2Uoc3RydWN0
IG1seDVfdmRwYV9kZXYgKm12ZGV2KQo+IC17Cj4gLQlyZXR1cm4gJm12ZGV2LT5tZGV2LT5wZGV2
LT5kZXY7Cj4gLX0KPiAtCj4gICBzdGF0aWMgaW50IG1hcF9kaXJlY3RfbXIoc3RydWN0IG1seDVf
dmRwYV9kZXYgKm12ZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX2RpcmVjdF9tciAqbXIsCj4gICAJCQkg
c3RydWN0IHZob3N0X2lvdGxiICppb3RsYikKPiAgIHsKPiBAQCAtMjM5LDcgKzIzNCw3IEBAIHN0
YXRpYyBpbnQgbWFwX2RpcmVjdF9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHN0cnVj
dCBtbHg1X3ZkcGFfZGlyZWN0X21yCj4gICAJdTY0IHBhOwo+ICAgCXU2NCBwYWVuZDsKPiAgIAlz
dHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnOwo+IC0Jc3RydWN0IGRldmljZSAqZG1hID0gZ2V0X2RtYV9k
ZXZpY2UobXZkZXYpOwo+ICsJc3RydWN0IGRldmljZSAqZG1hID0gbXZkZXYtPnZkZXYuZG1hX2Rl
djsKPiAgIAo+ICAgCWZvciAobWFwID0gdmhvc3RfaW90bGJfaXRyZWVfZmlyc3QoaW90bGIsIG1y
LT5zdGFydCwgbXItPmVuZCAtIDEpOwo+ICAgCSAgICAgbWFwOyBtYXAgPSB2aG9zdF9pb3RsYl9p
dHJlZV9uZXh0KG1hcCwgc3RhcnQsIG1yLT5lbmQgLSAxKSkgewo+IEBAIC0yOTgsNyArMjkzLDcg
QEAgc3RhdGljIGludCBtYXBfZGlyZWN0X21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwg
c3RydWN0IG1seDVfdmRwYV9kaXJlY3RfbXIKPiAgIAo+ICAgc3RhdGljIHZvaWQgdW5tYXBfZGly
ZWN0X21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgc3RydWN0IG1seDVfdmRwYV9kaXJl
Y3RfbXIgKm1yKQo+ICAgewo+IC0Jc3RydWN0IGRldmljZSAqZG1hID0gZ2V0X2RtYV9kZXZpY2Uo
bXZkZXYpOwo+ICsJc3RydWN0IGRldmljZSAqZG1hID0gbXZkZXYtPnZkZXYuZG1hX2RldjsKPiAg
IAo+ICAgCWRlc3Ryb3lfZGlyZWN0X21yKG12ZGV2LCBtcik7Cj4gICAJZG1hX3VubWFwX3NnX2F0
dHJzKGRtYSwgbXItPnNnX2hlYWQuc2dsLCBtci0+bnNnLCBETUFfQklESVJFQ1RJT05BTCwgMCk7
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZl
cnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+IGluZGV4IDdlMGQxYjhhZTNkMy4uYTUxNjNk
OGE0ODI4IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+
ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+IEBAIC0yMDQ2LDcgKzIw
NDYsNyBAQCBzdGF0aWMgaW50IG1seDVfdmRwYV9kZXZfYWRkKHN0cnVjdCB2ZHBhX21nbXRfZGV2
ICp2X21kZXYsIGNvbnN0IGNoYXIgKm5hbWUpCj4gICAJaWYgKGVycikKPiAgIAkJZ290byBlcnJf
bXR1Owo+ICAgCj4gLQltdmRldi0+dmRldi5kbWFfZGV2ID0gbWRldi0+ZGV2aWNlOwo+ICsJbXZk
ZXYtPnZkZXYuZG1hX2RldiA9ICZtZGV2LT5wZGV2LT5kZXY7Cj4gICAJZXJyID0gbWx4NV92ZHBh
X2FsbG9jX3Jlc291cmNlcygmbmRldi0+bXZkZXYpOwo+ICAgCWlmIChlcnIpCj4gICAJCWdvdG8g
ZXJyX210dTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
