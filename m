Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1A3C433F5
	for <virtualization@archiver.kernel.org>; Mon, 18 Apr 2022 07:49:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E697C61207;
	Mon, 18 Apr 2022 07:49:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pMz8iJ8iCl_B; Mon, 18 Apr 2022 07:49:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3F8E760625;
	Mon, 18 Apr 2022 07:49:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 220B6C0033;
	Mon, 18 Apr 2022 07:49:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13D6AC002C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 07:49:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DEF7341B7B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 07:49:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p9yJb1VS3BYl
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 07:49:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2430641B6C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 07:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650268184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mnfv0wNYltyi7i75x7CfPVfEPHaNVts12r24quKUZeE=;
 b=WjB26+Mn/fnqBBggxM8fnoXs2Lt8FnEK07yw1GRtE31ArObCIkzGkPk7HLwtkLLDZE7jGT
 KiPTGtFfHK9Y7eX9e4RlLTssnlKdy2toTKaIgjWeA4u948jWLGT5ql6rT6IU4rl0XMsWCi
 de04L0/PLW2ylR6uwrv8NEEA62GKsaI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-rOeBjglnOvGOsOCm419J4g-1; Mon, 18 Apr 2022 03:49:42 -0400
X-MC-Unique: rOeBjglnOvGOsOCm419J4g-1
Received: by mail-lf1-f71.google.com with SMTP id
 o4-20020a056512230400b0046d0a7f733cso4541982lfu.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 00:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mnfv0wNYltyi7i75x7CfPVfEPHaNVts12r24quKUZeE=;
 b=z+Jini3/Y2QSx2tmAtgKztyNIf4Bq6O7yYxuiYPEgQgJs8TCkBOCf/ocgVLqOES+3+
 6qMULXTg9lDuSSoTzFayKwW1Oc+SuQG1q8JMP+9+JpmkQcKd+OcOYR1XQq6kcBZRADVl
 0twlqTonSiW2CDfCQD8+Mx6n2thXHHndYJlbfO6xFSfx/CkpF5pSsbso/wz/+dQWjvX8
 VSaZDC+3OSzTokiBD1X5I/dW8mRz3rAFLvS/S+3Pkvg6nhzdubDK7zbqC1ztEL28E2HH
 JQYnRznf1V357cuXCMidghXEQ6r5S4Mx3URKZQoQgquY1ExXKk4IHZk9eEHQLunMcMIm
 xNfQ==
X-Gm-Message-State: AOAM530WDQnPSpCu7UlnuKat7EjkFtY/djsyBHI7YT4oDaFUAJxUhSkS
 +sMqXmYhrxC9oX0jXCMnka0vuk1WUJKpV0ntQh0hz0PuHQfjSWKuDu1FB6N8NfGo+C7Itva4wE5
 +1YrM0YbKHJNXhXdzJOX367j1R8w4iei4nDq5fR0MbRirETCpfMzvdpQm4g==
X-Received: by 2002:a05:6512:33c5:b0:46b:af94:55f4 with SMTP id
 d5-20020a05651233c500b0046baf9455f4mr7367197lfg.98.1650268181379; 
 Mon, 18 Apr 2022 00:49:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLtmsnyubTWj2Yy6V283b2x4yR5RwYa5Rj8a/3qzc1lPd7gSTeVjA3xFAfIb7AgFuIOEEkBJncBR9AcK6VPes=
X-Received: by 2002:a05:6512:33c5:b0:46b:af94:55f4 with SMTP id
 d5-20020a05651233c500b0046baf9455f4mr7367160lfg.98.1650268181074; Mon, 18 Apr
 2022 00:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-32-xuanzhuo@linux.alibaba.com>
 <122008a6-1e79-14d3-1478-59f96464afc9@redhat.com>
 <1650252077.7934203-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1650252077.7934203-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 18 Apr 2022 15:49:29 +0800
Message-ID: <CACGkMEtZOJ2PCsJidDcFKL57Q6oLHk4TH7xtewrLCTFhrbXSAA@mail.gmail.com>
Subject: Re: [PATCH v9 31/32] virtio_net: support rx/tx queue resize
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Heiko Carstens <hca@linux.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, kvm <kvm@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev <netdev@vger.kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 "open list:XDP \(eXpress Data Path\)" <bpf@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

T24gTW9uLCBBcHIgMTgsIDIwMjIgYXQgMTE6MjQgQU0gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51
eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4KPiBPbiBXZWQsIDEzIEFwciAyMDIyIDE2OjAwOjE4ICsw
ODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiDlnKgg
MjAyMi80LzYg5LiK5Y2IMTE6NDMsIFh1YW4gWmh1byDlhpnpgZM6Cj4gPiA+IFRoaXMgcGF0Y2gg
aW1wbGVtZW50cyB0aGUgcmVzaXplIGZ1bmN0aW9uIG9mIHRoZSByeCwgdHggcXVldWVzLgo+ID4g
PiBCYXNlZCBvbiB0aGlzIGZ1bmN0aW9uLCBpdCBpcyBwb3NzaWJsZSB0byBtb2RpZnkgdGhlIHJp
bmcgbnVtIG9mIHRoZQo+ID4gPiBxdWV1ZS4KPiA+ID4KPiA+ID4gVGhlcmUgbWF5IGJlIGFuIGV4
Y2VwdGlvbiBkdXJpbmcgdGhlIHJlc2l6ZSBwcm9jZXNzLCB0aGUgcmVzaXplIG1heQo+ID4gPiBm
YWlsLCBvciB0aGUgdnEgY2FuIG5vIGxvbmdlciBiZSB1c2VkLiBFaXRoZXIgd2F5LCB3ZSBtdXN0
IGV4ZWN1dGUKPiA+ID4gbmFwaV9lbmFibGUoKS4gQmVjYXVzZSBuYXBpX2Rpc2FibGUgaXMgc2lt
aWxhciB0byBhIGxvY2ssIG5hcGlfZW5hYmxlCj4gPiA+IG11c3QgYmUgY2FsbGVkIGFmdGVyIGNh
bGxpbmcgbmFwaV9kaXNhYmxlLgo+ID4gPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8g
PHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+ID4gPiAtLS0KPiA+ID4gICBkcml2ZXJzL25l
dC92aXJ0aW9fbmV0LmMgfCA4MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrCj4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDgxIGluc2VydGlvbnMoKykKPiA+ID4KPiA+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRp
b19uZXQuYwo+ID4gPiBpbmRleCBiOGJmMDA1MjUxNzcuLmJhNjg1OWYzMDVmNyAxMDA2NDQKPiA+
ID4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0
L3ZpcnRpb19uZXQuYwo+ID4gPiBAQCAtMjUxLDYgKzI1MSw5IEBAIHN0cnVjdCBwYWRkZWRfdm5l
dF9oZHIgewo+ID4gPiAgICAgY2hhciBwYWRkaW5nWzRdOwo+ID4gPiAgIH07Cj4gPiA+Cj4gPiA+
ICtzdGF0aWMgdm9pZCB2aXJ0bmV0X3NxX2ZyZWVfdW51c2VkX2J1ZihzdHJ1Y3QgdmlydHF1ZXVl
ICp2cSwgdm9pZCAqYnVmKTsKPiA+ID4gK3N0YXRpYyB2b2lkIHZpcnRuZXRfcnFfZnJlZV91bnVz
ZWRfYnVmKHN0cnVjdCB2aXJ0cXVldWUgKnZxLCB2b2lkICpidWYpOwo+ID4gPiArCj4gPiA+ICAg
c3RhdGljIGJvb2wgaXNfeGRwX2ZyYW1lKHZvaWQgKnB0cikKPiA+ID4gICB7Cj4gPiA+ICAgICBy
ZXR1cm4gKHVuc2lnbmVkIGxvbmcpcHRyICYgVklSVElPX1hEUF9GTEFHOwo+ID4gPiBAQCAtMTM2
OSw2ICsxMzcyLDE1IEBAIHN0YXRpYyB2b2lkIHZpcnRuZXRfbmFwaV9lbmFibGUoc3RydWN0IHZp
cnRxdWV1ZSAqdnEsIHN0cnVjdCBuYXBpX3N0cnVjdCAqbmFwaSkKPiA+ID4gICB7Cj4gPiA+ICAg
ICBuYXBpX2VuYWJsZShuYXBpKTsKPiA+ID4KPiA+ID4gKyAgIC8qIENoZWNrIGlmIHZxIGlzIGlu
IHJlc2V0IHN0YXRlLiBUaGUgbm9ybWFsIHJlc2V0L3Jlc2l6ZSBwcm9jZXNzIHdpbGwKPiA+ID4g
KyAgICAqIGJlIHByb3RlY3RlZCBieSBuYXBpLiBIb3dldmVyLCB0aGUgcHJvdGVjdGlvbiBvZiBu
YXBpIGlzIG9ubHkgZW5hYmxlZAo+ID4gPiArICAgICogZHVyaW5nIHRoZSBvcGVyYXRpb24sIGFu
ZCB0aGUgcHJvdGVjdGlvbiBvZiBuYXBpIHdpbGwgZW5kIGFmdGVyIHRoZQo+ID4gPiArICAgICog
b3BlcmF0aW9uIGlzIGNvbXBsZXRlZC4gSWYgcmUtZW5hYmxlIGZhaWxzIGR1cmluZyB0aGUgcHJv
Y2VzcywgdnEKPiA+ID4gKyAgICAqIHdpbGwgcmVtYWluIHVuYXZhaWxhYmxlIHdpdGggcmVzZXQg
c3RhdGUuCj4gPiA+ICsgICAgKi8KPiA+ID4gKyAgIGlmICh2cS0+cmVzZXQpCj4gPiA+ICsgICAg
ICAgICAgIHJldHVybjsKPiA+Cj4gPgo+ID4gSSBkb24ndCBnZXQgd2hlbiBjb3VsZCB3ZSBoaXQg
dGhpcyBjb25kaXRpb24uCj4gPgo+ID4KPiA+ID4gKwo+ID4gPiAgICAgLyogSWYgYWxsIGJ1ZmZl
cnMgd2VyZSBmaWxsZWQgYnkgb3RoZXIgc2lkZSBiZWZvcmUgd2UgbmFwaV9lbmFibGVkLCB3ZQo+
ID4gPiAgICAgICogd29uJ3QgZ2V0IGFub3RoZXIgaW50ZXJydXB0LCBzbyBwcm9jZXNzIGFueSBv
dXRzdGFuZGluZyBwYWNrZXRzIG5vdy4KPiA+ID4gICAgICAqIENhbGwgbG9jYWxfYmhfZW5hYmxl
IGFmdGVyIHRvIHRyaWdnZXIgc29mdElSUSBwcm9jZXNzaW5nLgo+ID4gPiBAQCAtMTQxMyw2ICsx
NDI1LDE1IEBAIHN0YXRpYyB2b2lkIHJlZmlsbF93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29y
aykKPiA+ID4gICAgICAgICAgICAgc3RydWN0IHJlY2VpdmVfcXVldWUgKnJxID0gJnZpLT5ycVtp
XTsKPiA+ID4KPiA+ID4gICAgICAgICAgICAgbmFwaV9kaXNhYmxlKCZycS0+bmFwaSk7Cj4gPiA+
ICsKPiA+ID4gKyAgICAgICAgICAgLyogQ2hlY2sgaWYgdnEgaXMgaW4gcmVzZXQgc3RhdGUuIFNl
ZSBtb3JlIGluCj4gPiA+ICsgICAgICAgICAgICAqIHZpcnRuZXRfbmFwaV9lbmFibGUoKQo+ID4g
PiArICAgICAgICAgICAgKi8KPiA+ID4gKyAgICAgICAgICAgaWYgKHJxLT52cS0+cmVzZXQpIHsK
PiA+ID4gKyAgICAgICAgICAgICAgICAgICB2aXJ0bmV0X25hcGlfZW5hYmxlKHJxLT52cSwgJnJx
LT5uYXBpKTsKPiA+ID4gKyAgICAgICAgICAgICAgICAgICBjb250aW51ZTsKPiA+ID4gKyAgICAg
ICAgICAgfQo+ID4KPiA+Cj4gPiBDYW4gd2UgZG8gc29tZXRoaW5nIHNpbWlsYXIgaW4gdmlydG5l
dF9jbG9zZSgpIGJ5IGNhbmNlbGluZyB0aGUgd29yaz8KPiA+Cj4gPgo+ID4gPiArCj4gPiA+ICAg
ICAgICAgICAgIHN0aWxsX2VtcHR5ID0gIXRyeV9maWxsX3JlY3YodmksIHJxLCBHRlBfS0VSTkVM
KTsKPiA+ID4gICAgICAgICAgICAgdmlydG5ldF9uYXBpX2VuYWJsZShycS0+dnEsICZycS0+bmFw
aSk7Cj4gPiA+Cj4gPiA+IEBAIC0xNTIzLDYgKzE1NDQsMTAgQEAgc3RhdGljIHZvaWQgdmlydG5l
dF9wb2xsX2NsZWFudHgoc3RydWN0IHJlY2VpdmVfcXVldWUgKnJxKQo+ID4gPiAgICAgaWYgKCFz
cS0+bmFwaS53ZWlnaHQgfHwgaXNfeGRwX3Jhd19idWZmZXJfcXVldWUodmksIGluZGV4KSkKPiA+
ID4gICAgICAgICAgICAgcmV0dXJuOwo+ID4gPgo+ID4gPiArICAgLyogQ2hlY2sgaWYgdnEgaXMg
aW4gcmVzZXQgc3RhdGUuIFNlZSBtb3JlIGluIHZpcnRuZXRfbmFwaV9lbmFibGUoKSAqLwo+ID4g
PiArICAgaWYgKHNxLT52cS0+cmVzZXQpCj4gPiA+ICsgICAgICAgICAgIHJldHVybjsKPiA+Cj4g
Pgo+ID4gV2UndmUgZGlzYWJsZWQgVFggbmFwaSwgYW55IGNoYW5jZSB3ZSBjYW4gc3RpbGwgaGl0
IHRoaXM/Cj4KPgo+IHN0YXRpYyBpbnQgdmlydG5ldF9wb2xsKHN0cnVjdCBuYXBpX3N0cnVjdCAq
bmFwaSwgaW50IGJ1ZGdldCkKPiB7Cj4gICAgICAgICBzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEg
PQo+ICAgICAgICAgICAgICAgICBjb250YWluZXJfb2YobmFwaSwgc3RydWN0IHJlY2VpdmVfcXVl
dWUsIG5hcGkpOwo+ICAgICAgICAgc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkgPSBycS0+dnEtPnZk
ZXYtPnByaXY7Cj4gICAgICAgICBzdHJ1Y3Qgc2VuZF9xdWV1ZSAqc3E7Cj4gICAgICAgICB1bnNp
Z25lZCBpbnQgcmVjZWl2ZWQ7Cj4gICAgICAgICB1bnNpZ25lZCBpbnQgeGRwX3htaXQgPSAwOwo+
Cj4gICAgICAgICB2aXJ0bmV0X3BvbGxfY2xlYW50eChycSk7Cj4gLi4uCj4gfQo+Cj4gVGhpcyBp
cyBjYWxsZWQgYnkgcnggcG9sbC4gQWx0aG91Z2ggaXQgaXMgdGhlIGxvZ2ljIG9mIHR4LCBpdCBp
cyBub3QgZHJpdmVuIGJ5Cj4gdHggbmFwaSwgYnV0IGlzIGNhbGxlZCBpbiByeCBwb2xsLgoKT2ss
IGJ1dCB3ZSBuZWVkIGd1YXJhbnRlZSB0aGUgbWVtb3J5IG9yZGVyaW5nIGluIHRoaXMgY2FzZS4g
RGlzYWJsZSBSWApuYXBpIGNvdWxkIGJlIGEgc29sdXRpb24gZm9yIHRoaXMuCgpUaGFua3MKCj4K
PiBUaGFua3MuCj4KPgo+ID4KPiA+Cj4gPiA+ICsKPiA+ID4gICAgIGlmIChfX25ldGlmX3R4X3Ry
eWxvY2sodHhxKSkgewo+ID4gPiAgICAgICAgICAgICBkbyB7Cj4gPiA+ICAgICAgICAgICAgICAg
ICAgICAgdmlydHF1ZXVlX2Rpc2FibGVfY2Ioc3EtPnZxKTsKPiA+ID4gQEAgLTE3NjksNiArMTc5
NCw2MiBAQCBzdGF0aWMgbmV0ZGV2X3R4X3Qgc3RhcnRfeG1pdChzdHJ1Y3Qgc2tfYnVmZiAqc2ti
LCBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQo+ID4gPiAgICAgcmV0dXJuIE5FVERFVl9UWF9PSzsK
PiA+ID4gICB9Cj4gPiA+Cj4gPiA+ICtzdGF0aWMgaW50IHZpcnRuZXRfcnhfcmVzaXplKHN0cnVj
dCB2aXJ0bmV0X2luZm8gKnZpLAo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IHJlY2VpdmVfcXVldWUgKnJxLCB1MzIgcmluZ19udW0pCj4gPiA+ICt7Cj4gPiA+ICsgICBpbnQg
ZXJyOwo+ID4gPiArCj4gPiA+ICsgICBuYXBpX2Rpc2FibGUoJnJxLT5uYXBpKTsKPiA+ID4gKwo+
ID4gPiArICAgZXJyID0gdmlydHF1ZXVlX3Jlc2l6ZShycS0+dnEsIHJpbmdfbnVtLCB2aXJ0bmV0
X3JxX2ZyZWVfdW51c2VkX2J1Zik7Cj4gPiA+ICsgICBpZiAoZXJyKQo+ID4gPiArICAgICAgICAg
ICBnb3RvIGVycjsKPiA+ID4gKwo+ID4gPiArICAgaWYgKCF0cnlfZmlsbF9yZWN2KHZpLCBycSwg
R0ZQX0tFUk5FTCkpCj4gPiA+ICsgICAgICAgICAgIHNjaGVkdWxlX2RlbGF5ZWRfd29yaygmdmkt
PnJlZmlsbCwgMCk7Cj4gPiA+ICsKPiA+ID4gKyAgIHZpcnRuZXRfbmFwaV9lbmFibGUocnEtPnZx
LCAmcnEtPm5hcGkpOwo+ID4gPiArICAgcmV0dXJuIDA7Cj4gPiA+ICsKPiA+ID4gK2VycjoKPiA+
ID4gKyAgIG5ldGRldl9lcnIodmktPmRldiwKPiA+ID4gKyAgICAgICAgICAgICAgInJlc2V0IHJ4
IHJlc2V0IHZxIGZhaWw6IHJ4IHF1ZXVlIGluZGV4OiAldGQgZXJyOiAlZFxuIiwKPiA+ID4gKyAg
ICAgICAgICAgICAgcnEgLSB2aS0+cnEsIGVycik7Cj4gPiA+ICsgICB2aXJ0bmV0X25hcGlfZW5h
YmxlKHJxLT52cSwgJnJxLT5uYXBpKTsKPiA+ID4gKyAgIHJldHVybiBlcnI7Cj4gPiA+ICt9Cj4g
PiA+ICsKPiA+ID4gK3N0YXRpYyBpbnQgdmlydG5ldF90eF9yZXNpemUoc3RydWN0IHZpcnRuZXRf
aW5mbyAqdmksCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgc2VuZF9xdWV1
ZSAqc3EsIHUzMiByaW5nX251bSkKPiA+ID4gK3sKPiA+ID4gKyAgIHN0cnVjdCBuZXRkZXZfcXVl
dWUgKnR4cTsKPiA+ID4gKyAgIGludCBlcnIsIHFpbmRleDsKPiA+ID4gKwo+ID4gPiArICAgcWlu
ZGV4ID0gc3EgLSB2aS0+c3E7Cj4gPiA+ICsKPiA+ID4gKyAgIHZpcnRuZXRfbmFwaV90eF9kaXNh
YmxlKCZzcS0+bmFwaSk7Cj4gPiA+ICsKPiA+ID4gKyAgIHR4cSA9IG5ldGRldl9nZXRfdHhfcXVl
dWUodmktPmRldiwgcWluZGV4KTsKPiA+ID4gKyAgIF9fbmV0aWZfdHhfbG9ja19iaCh0eHEpOwo+
ID4gPiArICAgbmV0aWZfc3RvcF9zdWJxdWV1ZSh2aS0+ZGV2LCBxaW5kZXgpOwo+ID4gPiArICAg
X19uZXRpZl90eF91bmxvY2tfYmgodHhxKTsKPiA+ID4gKwo+ID4gPiArICAgZXJyID0gdmlydHF1
ZXVlX3Jlc2l6ZShzcS0+dnEsIHJpbmdfbnVtLCB2aXJ0bmV0X3NxX2ZyZWVfdW51c2VkX2J1Zik7
Cj4gPiA+ICsgICBpZiAoZXJyKQo+ID4gPiArICAgICAgICAgICBnb3RvIGVycjsKPiA+ID4gKwo+
ID4gPiArICAgbmV0aWZfc3RhcnRfc3VicXVldWUodmktPmRldiwgcWluZGV4KTsKPiA+ID4gKyAg
IHZpcnRuZXRfbmFwaV90eF9lbmFibGUodmksIHNxLT52cSwgJnNxLT5uYXBpKTsKPiA+ID4gKyAg
IHJldHVybiAwOwo+ID4gPiArCj4gPiA+ICtlcnI6Cj4gPgo+ID4KPiA+IEkgZ3Vlc3Mgd2UgY2Fu
IHN0aWxsIHN0YXJ0IHRoZSBxdWV1ZSBpbiB0aGlzIGNhc2U/IChTaW5jZSB3ZSBkb24ndAo+ID4g
Y2hhbmdlIHRoZSBxdWV1ZSBpZiByZXNpemUgZmFpbHMpLgo+ID4KPiA+Cj4gPiA+ICsgICBuZXRk
ZXZfZXJyKHZpLT5kZXYsCj4gPiA+ICsgICAgICAgICAgICAgICJyZXNldCB0eCByZXNldCB2cSBm
YWlsOiB0eCBxdWV1ZSBpbmRleDogJXRkIGVycjogJWRcbiIsCj4gPiA+ICsgICAgICAgICAgICAg
IHNxIC0gdmktPnNxLCBlcnIpOwo+ID4gPiArICAgdmlydG5ldF9uYXBpX3R4X2VuYWJsZSh2aSwg
c3EtPnZxLCAmc3EtPm5hcGkpOwo+ID4gPiArICAgcmV0dXJuIGVycjsKPiA+ID4gK30KPiA+ID4g
Kwo+ID4gPiAgIC8qCj4gPiA+ICAgICogU2VuZCBjb21tYW5kIHZpYSB0aGUgY29udHJvbCB2aXJ0
cXVldWUgYW5kIGNoZWNrIHN0YXR1cy4gIENvbW1hbmRzCj4gPiA+ICAgICogc3VwcG9ydGVkIGJ5
IHRoZSBoeXBlcnZpc29yLCBhcyBpbmRpY2F0ZWQgYnkgZmVhdHVyZSBiaXRzLCBzaG91bGQKPiA+
Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
