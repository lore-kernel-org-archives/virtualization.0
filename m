Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A357C433FE
	for <virtualization@archiver.kernel.org>; Thu, 14 Apr 2022 09:30:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 307AE418AD;
	Thu, 14 Apr 2022 09:30:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yV7Uprni0cJS; Thu, 14 Apr 2022 09:30:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 540A8418B3;
	Thu, 14 Apr 2022 09:30:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23DB7C002F;
	Thu, 14 Apr 2022 09:30:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2DFB7C002C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 09:30:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0BA4080FFE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 09:30:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kzC2S0waccHV
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 09:30:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 119AD83268
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 09:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649928616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xTVIrXTky6oGSdrW6vSloYGYrjPuyKnFBXOPprwmmi4=;
 b=PXvhHDhY9PjaCWc7ZQNxbvd/jgqM71Bjb9qsqSMbiNkwKSBcgguYlKun7vVoGGEtzuB2Q5
 EXiAr9afU/RsE6rFiLtiRgXAqrw6Z4G1F4LOCcWt95/pVZGPNoH46ZsrLUXHry6pVCOM5i
 bgevHElrbPQgaABKU6nbyZITQlDEZqs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-8IWNISyOO6Wuj9U0MSYKiQ-1; Thu, 14 Apr 2022 05:30:15 -0400
X-MC-Unique: 8IWNISyOO6Wuj9U0MSYKiQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 t17-20020a056512069100b0046bb606d8efso2099019lfe.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 02:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xTVIrXTky6oGSdrW6vSloYGYrjPuyKnFBXOPprwmmi4=;
 b=X7Tro2IW1gLXFLlkG9n6M/V7TKPsOINNp93amzGsPOLt/MUmYZ6DQqO7Cirl83/+to
 tYsFG4p30ddMsVTZr52Ez0NzJSQUHgWYB3A2Ppr7GzY6rPRue6okWFR0XhffIH9NfBsj
 1G4x5gfIrtrJmnArhNG0oAnkpqsh+IGArLj4GJ0/wC1aJW8gcDfoKNSdIkkUWNbsYA/7
 igZUtXM8j0rnOxIq+YDLWawgkfX46haDY4W8KNNkrlgNzQWx+wGyB9Vc/+MLceUiT4jt
 BO5y7iNx9E53PhdRZ0hhYr68SFf5HZvchDMMewu5QHpl5ju1fnxauQ3TInITscFYQNvG
 kw6Q==
X-Gm-Message-State: AOAM532XCjtAQIn0QICaNEmgi01DVKLjH9HpsL807q35s/TtcfOWAUKB
 ku6xktdJxYYamgBnzSY9trE9IadXRS8tkdhxwxJFlEimGQuHY40Hb4lavZ/63fJ2vTK3g8LWgNz
 oD+eUc8k3ZYtD/13cY4e0bZ38mbIQswpSZXZrFdFg22qNpCqSMoBTIq8phw==
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id
 p21-20020a056512139500b00446d38279a5mr1356173lfa.210.1649928613816; 
 Thu, 14 Apr 2022 02:30:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzr4h2U/Fe61ajhZ/yffQb0+ghbUvKwuL6LwQ7b0T02xdZ+hsOeGv/9VI/5jkuBOiC1HbxYHbK+Cv1CpJTPCfU=
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id
 p21-20020a056512139500b00446d38279a5mr1356123lfa.210.1649928613476; Thu, 14
 Apr 2022 02:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-32-xuanzhuo@linux.alibaba.com>
 <122008a6-1e79-14d3-1478-59f96464afc9@redhat.com>
 <1649838917.6726515-10-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1649838917.6726515-10-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Apr 2022 17:30:02 +0800
Message-ID: <CACGkMEvPH1k76xB_cHq_S9hvMXgGruoXpKLfoMZvJZ-L7wM9iw@mail.gmail.com>
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

T24gV2VkLCBBcHIgMTMsIDIwMjIgYXQgNDo0NyBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIFdlZCwgMTMgQXByIDIwMjIgMTY6MDA6MTggKzA4
MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IOWcqCAy
MDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVvIOWGmemBkzoKPiA+ID4gVGhpcyBwYXRjaCBp
bXBsZW1lbnRzIHRoZSByZXNpemUgZnVuY3Rpb24gb2YgdGhlIHJ4LCB0eCBxdWV1ZXMuCj4gPiA+
IEJhc2VkIG9uIHRoaXMgZnVuY3Rpb24sIGl0IGlzIHBvc3NpYmxlIHRvIG1vZGlmeSB0aGUgcmlu
ZyBudW0gb2YgdGhlCj4gPiA+IHF1ZXVlLgo+ID4gPgo+ID4gPiBUaGVyZSBtYXkgYmUgYW4gZXhj
ZXB0aW9uIGR1cmluZyB0aGUgcmVzaXplIHByb2Nlc3MsIHRoZSByZXNpemUgbWF5Cj4gPiA+IGZh
aWwsIG9yIHRoZSB2cSBjYW4gbm8gbG9uZ2VyIGJlIHVzZWQuIEVpdGhlciB3YXksIHdlIG11c3Qg
ZXhlY3V0ZQo+ID4gPiBuYXBpX2VuYWJsZSgpLiBCZWNhdXNlIG5hcGlfZGlzYWJsZSBpcyBzaW1p
bGFyIHRvIGEgbG9jaywgbmFwaV9lbmFibGUKPiA+ID4gbXVzdCBiZSBjYWxsZWQgYWZ0ZXIgY2Fs
bGluZyBuYXBpX2Rpc2FibGUuCj4gPiA+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8
eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiA+IC0tLQo+ID4gPiAgIGRyaXZlcnMvbmV0
L3ZpcnRpb19uZXQuYyB8IDgxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysKPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgODEgaW5zZXJ0aW9ucygrKQo+ID4gPgo+ID4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jCj4gPiA+IGluZGV4IGI4YmYwMDUyNTE3Ny4uYmE2ODU5ZjMwNWY3IDEwMDY0NAo+ID4g
PiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gKysrIGIvZHJpdmVycy9uZXQv
dmlydGlvX25ldC5jCj4gPiA+IEBAIC0yNTEsNiArMjUxLDkgQEAgc3RydWN0IHBhZGRlZF92bmV0
X2hkciB7Cj4gPiA+ICAgICBjaGFyIHBhZGRpbmdbNF07Cj4gPiA+ICAgfTsKPiA+ID4KPiA+ID4g
K3N0YXRpYyB2b2lkIHZpcnRuZXRfc3FfZnJlZV91bnVzZWRfYnVmKHN0cnVjdCB2aXJ0cXVldWUg
KnZxLCB2b2lkICpidWYpOwo+ID4gPiArc3RhdGljIHZvaWQgdmlydG5ldF9ycV9mcmVlX3VudXNl
ZF9idWYoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHZvaWQgKmJ1Zik7Cj4gPiA+ICsKPiA+ID4gICBz
dGF0aWMgYm9vbCBpc194ZHBfZnJhbWUodm9pZCAqcHRyKQo+ID4gPiAgIHsKPiA+ID4gICAgIHJl
dHVybiAodW5zaWduZWQgbG9uZylwdHIgJiBWSVJUSU9fWERQX0ZMQUc7Cj4gPiA+IEBAIC0xMzY5
LDYgKzEzNzIsMTUgQEAgc3RhdGljIHZvaWQgdmlydG5ldF9uYXBpX2VuYWJsZShzdHJ1Y3Qgdmly
dHF1ZXVlICp2cSwgc3RydWN0IG5hcGlfc3RydWN0ICpuYXBpKQo+ID4gPiAgIHsKPiA+ID4gICAg
IG5hcGlfZW5hYmxlKG5hcGkpOwo+ID4gPgo+ID4gPiArICAgLyogQ2hlY2sgaWYgdnEgaXMgaW4g
cmVzZXQgc3RhdGUuIFRoZSBub3JtYWwgcmVzZXQvcmVzaXplIHByb2Nlc3Mgd2lsbAo+ID4gPiAr
ICAgICogYmUgcHJvdGVjdGVkIGJ5IG5hcGkuIEhvd2V2ZXIsIHRoZSBwcm90ZWN0aW9uIG9mIG5h
cGkgaXMgb25seSBlbmFibGVkCj4gPiA+ICsgICAgKiBkdXJpbmcgdGhlIG9wZXJhdGlvbiwgYW5k
IHRoZSBwcm90ZWN0aW9uIG9mIG5hcGkgd2lsbCBlbmQgYWZ0ZXIgdGhlCj4gPiA+ICsgICAgKiBv
cGVyYXRpb24gaXMgY29tcGxldGVkLiBJZiByZS1lbmFibGUgZmFpbHMgZHVyaW5nIHRoZSBwcm9j
ZXNzLCB2cQo+ID4gPiArICAgICogd2lsbCByZW1haW4gdW5hdmFpbGFibGUgd2l0aCByZXNldCBz
dGF0ZS4KPiA+ID4gKyAgICAqLwo+ID4gPiArICAgaWYgKHZxLT5yZXNldCkKPiA+ID4gKyAgICAg
ICAgICAgcmV0dXJuOwo+ID4KPiA+Cj4gPiBJIGRvbid0IGdldCB3aGVuIGNvdWxkIHdlIGhpdCB0
aGlzIGNvbmRpdGlvbi4KPgo+Cj4gSW4gcGF0Y2ggMjMsIHRoZSBjb2RlIHRvIGltcGxlbWVudCBy
ZS1lbmFibGUgdnEgaXMgYXMgZm9sbG93czoKPgo+ICtzdGF0aWMgaW50IHZwX21vZGVybl9lbmFi
bGVfcmVzZXRfdnEoc3RydWN0IHZpcnRxdWV1ZSAqdnEpCj4gK3sKPiArICAgICAgIHN0cnVjdCB2
aXJ0aW9fcGNpX2RldmljZSAqdnBfZGV2ID0gdG9fdnBfZGV2aWNlKHZxLT52ZGV2KTsKPiArICAg
ICAgIHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9kZXZpY2UgKm1kZXYgPSAmdnBfZGV2LT5tZGV2
Owo+ICsgICAgICAgc3RydWN0IHZpcnRpb19wY2lfdnFfaW5mbyAqaW5mbzsKPiArICAgICAgIHVu
c2lnbmVkIGxvbmcgZmxhZ3MsIGluZGV4Owo+ICsgICAgICAgaW50IGVycjsKPiArCj4gKyAgICAg
ICBpZiAoIXZxLT5yZXNldCkKPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FQlVTWTsKPiArCj4g
KyAgICAgICBpbmRleCA9IHZxLT5pbmRleDsKPiArICAgICAgIGluZm8gPSB2cF9kZXYtPnZxc1tp
bmRleF07Cj4gKwo+ICsgICAgICAgLyogY2hlY2sgcXVldWUgcmVzZXQgc3RhdHVzICovCj4gKyAg
ICAgICBpZiAodnBfbW9kZXJuX2dldF9xdWV1ZV9yZXNldChtZGV2LCBpbmRleCkgIT0gMSkKPiAr
ICAgICAgICAgICAgICAgcmV0dXJuIC1FQlVTWTsKPiArCj4gKyAgICAgICBlcnIgPSB2cF9hY3Rp
dmVfdnEodnEsIGluZm8tPm1zaXhfdmVjdG9yKTsKPiArICAgICAgIGlmIChlcnIpCj4gKyAgICAg
ICAgICAgICAgIHJldHVybiBlcnI7Cj4gKwo+ICsgICAgICAgaWYgKHZxLT5jYWxsYmFjaykgewo+
ICsgICAgICAgICAgICAgICBzcGluX2xvY2tfaXJxc2F2ZSgmdnBfZGV2LT5sb2NrLCBmbGFncyk7
Cj4gKyAgICAgICAgICAgICAgIGxpc3RfYWRkKCZpbmZvLT5ub2RlLCAmdnBfZGV2LT52aXJ0cXVl
dWVzKTsKPiArICAgICAgICAgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmdnBfZGV2LT5s
b2NrLCBmbGFncyk7Cj4gKyAgICAgICB9IGVsc2Ugewo+ICsgICAgICAgICAgICAgICBJTklUX0xJ
U1RfSEVBRCgmaW5mby0+bm9kZSk7Cj4gKyAgICAgICB9Cj4gKwo+ICsgICAgICAgdnBfbW9kZXJu
X3NldF9xdWV1ZV9lbmFibGUoJnZwX2Rldi0+bWRldiwgaW5kZXgsIHRydWUpOwo+ICsKPiArICAg
ICAgIGlmICh2cF9kZXYtPnBlcl92cV92ZWN0b3JzICYmIGluZm8tPm1zaXhfdmVjdG9yICE9IFZJ
UlRJT19NU0lfTk9fVkVDVE9SKQo+ICsgICAgICAgICAgICAgICBlbmFibGVfaXJxKHBjaV9pcnFf
dmVjdG9yKHZwX2Rldi0+cGNpX2RldiwgaW5mby0+bXNpeF92ZWN0b3IpKTsKPiArCj4gKyAgICAg
ICB2cS0+cmVzZXQgPSBmYWxzZTsKPiArCj4gKyAgICAgICByZXR1cm4gMDsKPiArfQo+Cj4KPiBU
aGVyZSBhcmUgdGhyZWUgc2l0dWF0aW9ucyB3aGVyZSBhbiBlcnJvciB3aWxsIGJlIHJldHVybmVk
LiBUaGVzZSBhcmUgdGhlCj4gc2l0dWF0aW9ucyBJIHdhbnQgdG8gaGFuZGxlLgoKUmlnaHQsIGJ1
dCBpdCBsb29rcyBoYXJtbGVzcyBpZiB3ZSBqdXN0IHNjaGVkdWxlIHRoZSBOQVBJIHdpdGhvdXQg
dGhlIGNoZWNrLgoKPgo+IEJ1dCBJJ20gcmV0aGlua2luZyB0aGUgcXVlc3Rpb24sIGFuZCBJIGZl
ZWwgbGlrZSB5b3UncmUgcmlnaHQsIGFsdGhvdWdoIHRoZQo+IGhhcmR3YXJlIHNldHVwIG1heSBm
YWlsLiBXZSBjYW4gbm8gbG9uZ2VyIHN5bmMgd2l0aCB0aGUgaGFyZHdhcmUuIEJ1dCB1c2luZyBp
dAo+IGFzIGEgbm9ybWFsIHZxIGRvZXNuJ3QgaGF2ZSBhbnkgcHJvYmxlbXMuCgpOb3RlIHRoYXQg
d2Ugc2hvdWxkIG1ha2Ugc3VyZSB0aGUgYnVnZ3kobWFsaWNvdXMpIGRldmljZSB3b24ndCBjcmFz
aAp0aGUgY29kZXMgYnkgY2hhbmdpbmcgdGhlIHF1ZXVlX3Jlc2V0IHZhbHVlIGF0IGl0cyB3aWxs
LgoKPgo+ID4KPiA+Cj4gPiA+ICsKPiA+ID4gICAgIC8qIElmIGFsbCBidWZmZXJzIHdlcmUgZmls
bGVkIGJ5IG90aGVyIHNpZGUgYmVmb3JlIHdlIG5hcGlfZW5hYmxlZCwgd2UKPiA+ID4gICAgICAq
IHdvbid0IGdldCBhbm90aGVyIGludGVycnVwdCwgc28gcHJvY2VzcyBhbnkgb3V0c3RhbmRpbmcg
cGFja2V0cyBub3cuCj4gPiA+ICAgICAgKiBDYWxsIGxvY2FsX2JoX2VuYWJsZSBhZnRlciB0byB0
cmlnZ2VyIHNvZnRJUlEgcHJvY2Vzc2luZy4KPiA+ID4gQEAgLTE0MTMsNiArMTQyNSwxNSBAQCBz
dGF0aWMgdm9pZCByZWZpbGxfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCj4gPiA+ICAg
ICAgICAgICAgIHN0cnVjdCByZWNlaXZlX3F1ZXVlICpycSA9ICZ2aS0+cnFbaV07Cj4gPiA+Cj4g
PiA+ICAgICAgICAgICAgIG5hcGlfZGlzYWJsZSgmcnEtPm5hcGkpOwo+ID4gPiArCj4gPiA+ICsg
ICAgICAgICAgIC8qIENoZWNrIGlmIHZxIGlzIGluIHJlc2V0IHN0YXRlLiBTZWUgbW9yZSBpbgo+
ID4gPiArICAgICAgICAgICAgKiB2aXJ0bmV0X25hcGlfZW5hYmxlKCkKPiA+ID4gKyAgICAgICAg
ICAgICovCj4gPiA+ICsgICAgICAgICAgIGlmIChycS0+dnEtPnJlc2V0KSB7Cj4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgdmlydG5ldF9uYXBpX2VuYWJsZShycS0+dnEsICZycS0+bmFwaSk7Cj4g
PiA+ICsgICAgICAgICAgICAgICAgICAgY29udGludWU7Cj4gPiA+ICsgICAgICAgICAgIH0KPiA+
Cj4gPgo+ID4gQ2FuIHdlIGRvIHNvbWV0aGluZyBzaW1pbGFyIGluIHZpcnRuZXRfY2xvc2UoKSBi
eSBjYW5jZWxpbmcgdGhlIHdvcms/Cj4KPiBJIHRoaW5rIHRoZXJlIGlzIG5vIG5lZWQgdG8gY2Fu
Y2VsIHRoZSB3b3JrIGhlcmUsIGJlY2F1c2UgbmFwaV9kaXNhYmxlIHdpbGwgd2FpdAo+IGZvciB0
aGUgbmFwaV9lbmFibGUgb2YgdGhlIHJlc2l6ZS4gU28gaWYgdGhlIHJlLWVuYWJsZSBmYWlsZWQg
dnEgaXMgdXNlZCBhcyBhIG5vcm1hbAo+IHZxLCB0aGlzIGxvZ2ljIGNhbiBiZSByZW1vdmVkLgoK
QWN0dWFsbHkgSSBtZWFudCB0aGUgcGFydCBvZiB2aXJ0bmV0X3J4X3Jlc2l6ZSgpLgoKSWYgd2Ug
ZG9uJ3Qgc3luY2hyb25pemUgd2l0aCB0aGUgcmVmaWxsIHdvcmssIGl0IG1pZ2h0IGVuYWJsZSBO
QVBJIHVuZXhwZWN0ZWRseT8KClRoYW5rcwoKPgo+Cj4gPgo+ID4KPiA+ID4gKwo+ID4gPiAgICAg
ICAgICAgICBzdGlsbF9lbXB0eSA9ICF0cnlfZmlsbF9yZWN2KHZpLCBycSwgR0ZQX0tFUk5FTCk7
Cj4gPiA+ICAgICAgICAgICAgIHZpcnRuZXRfbmFwaV9lbmFibGUocnEtPnZxLCAmcnEtPm5hcGkp
Owo+ID4gPgo+ID4gPiBAQCAtMTUyMyw2ICsxNTQ0LDEwIEBAIHN0YXRpYyB2b2lkIHZpcnRuZXRf
cG9sbF9jbGVhbnR4KHN0cnVjdCByZWNlaXZlX3F1ZXVlICpycSkKPiA+ID4gICAgIGlmICghc3Et
Pm5hcGkud2VpZ2h0IHx8IGlzX3hkcF9yYXdfYnVmZmVyX3F1ZXVlKHZpLCBpbmRleCkpCj4gPiA+
ICAgICAgICAgICAgIHJldHVybjsKPiA+ID4KPiA+ID4gKyAgIC8qIENoZWNrIGlmIHZxIGlzIGlu
IHJlc2V0IHN0YXRlLiBTZWUgbW9yZSBpbiB2aXJ0bmV0X25hcGlfZW5hYmxlKCkgKi8KPiA+ID4g
KyAgIGlmIChzcS0+dnEtPnJlc2V0KQo+ID4gPiArICAgICAgICAgICByZXR1cm47Cj4gPgo+ID4K
PiA+IFdlJ3ZlIGRpc2FibGVkIFRYIG5hcGksIGFueSBjaGFuY2Ugd2UgY2FuIHN0aWxsIGhpdCB0
aGlzPwo+Cj4gU2FtZSBhcyBhYm92ZS4KPgo+ID4KPiA+Cj4gPiA+ICsKPiA+ID4gICAgIGlmIChf
X25ldGlmX3R4X3RyeWxvY2sodHhxKSkgewo+ID4gPiAgICAgICAgICAgICBkbyB7Cj4gPiA+ICAg
ICAgICAgICAgICAgICAgICAgdmlydHF1ZXVlX2Rpc2FibGVfY2Ioc3EtPnZxKTsKPiA+ID4gQEAg
LTE3NjksNiArMTc5NCw2MiBAQCBzdGF0aWMgbmV0ZGV2X3R4X3Qgc3RhcnRfeG1pdChzdHJ1Y3Qg
c2tfYnVmZiAqc2tiLCBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQo+ID4gPiAgICAgcmV0dXJuIE5F
VERFVl9UWF9PSzsKPiA+ID4gICB9Cj4gPiA+Cj4gPiA+ICtzdGF0aWMgaW50IHZpcnRuZXRfcnhf
cmVzaXplKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ID4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgc3RydWN0IHJlY2VpdmVfcXVldWUgKnJxLCB1MzIgcmluZ19udW0pCj4gPiA+ICt7Cj4g
PiA+ICsgICBpbnQgZXJyOwo+ID4gPiArCj4gPiA+ICsgICBuYXBpX2Rpc2FibGUoJnJxLT5uYXBp
KTsKPiA+ID4gKwo+ID4gPiArICAgZXJyID0gdmlydHF1ZXVlX3Jlc2l6ZShycS0+dnEsIHJpbmdf
bnVtLCB2aXJ0bmV0X3JxX2ZyZWVfdW51c2VkX2J1Zik7Cj4gPiA+ICsgICBpZiAoZXJyKQo+ID4g
PiArICAgICAgICAgICBnb3RvIGVycjsKPiA+ID4gKwo+ID4gPiArICAgaWYgKCF0cnlfZmlsbF9y
ZWN2KHZpLCBycSwgR0ZQX0tFUk5FTCkpCj4gPiA+ICsgICAgICAgICAgIHNjaGVkdWxlX2RlbGF5
ZWRfd29yaygmdmktPnJlZmlsbCwgMCk7Cj4gPiA+ICsKPiA+ID4gKyAgIHZpcnRuZXRfbmFwaV9l
bmFibGUocnEtPnZxLCAmcnEtPm5hcGkpOwo+ID4gPiArICAgcmV0dXJuIDA7Cj4gPiA+ICsKPiA+
ID4gK2VycjoKPiA+ID4gKyAgIG5ldGRldl9lcnIodmktPmRldiwKPiA+ID4gKyAgICAgICAgICAg
ICAgInJlc2V0IHJ4IHJlc2V0IHZxIGZhaWw6IHJ4IHF1ZXVlIGluZGV4OiAldGQgZXJyOiAlZFxu
IiwKPiA+ID4gKyAgICAgICAgICAgICAgcnEgLSB2aS0+cnEsIGVycik7Cj4gPiA+ICsgICB2aXJ0
bmV0X25hcGlfZW5hYmxlKHJxLT52cSwgJnJxLT5uYXBpKTsKPiA+ID4gKyAgIHJldHVybiBlcnI7
Cj4gPiA+ICt9Cj4gPiA+ICsKPiA+ID4gK3N0YXRpYyBpbnQgdmlydG5ldF90eF9yZXNpemUoc3Ry
dWN0IHZpcnRuZXRfaW5mbyAqdmksCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1
Y3Qgc2VuZF9xdWV1ZSAqc3EsIHUzMiByaW5nX251bSkKPiA+ID4gK3sKPiA+ID4gKyAgIHN0cnVj
dCBuZXRkZXZfcXVldWUgKnR4cTsKPiA+ID4gKyAgIGludCBlcnIsIHFpbmRleDsKPiA+ID4gKwo+
ID4gPiArICAgcWluZGV4ID0gc3EgLSB2aS0+c3E7Cj4gPiA+ICsKPiA+ID4gKyAgIHZpcnRuZXRf
bmFwaV90eF9kaXNhYmxlKCZzcS0+bmFwaSk7Cj4gPiA+ICsKPiA+ID4gKyAgIHR4cSA9IG5ldGRl
dl9nZXRfdHhfcXVldWUodmktPmRldiwgcWluZGV4KTsKPiA+ID4gKyAgIF9fbmV0aWZfdHhfbG9j
a19iaCh0eHEpOwo+ID4gPiArICAgbmV0aWZfc3RvcF9zdWJxdWV1ZSh2aS0+ZGV2LCBxaW5kZXgp
Owo+ID4gPiArICAgX19uZXRpZl90eF91bmxvY2tfYmgodHhxKTsKPiA+ID4gKwo+ID4gPiArICAg
ZXJyID0gdmlydHF1ZXVlX3Jlc2l6ZShzcS0+dnEsIHJpbmdfbnVtLCB2aXJ0bmV0X3NxX2ZyZWVf
dW51c2VkX2J1Zik7Cj4gPiA+ICsgICBpZiAoZXJyKQo+ID4gPiArICAgICAgICAgICBnb3RvIGVy
cjsKPiA+ID4gKwo+ID4gPiArICAgbmV0aWZfc3RhcnRfc3VicXVldWUodmktPmRldiwgcWluZGV4
KTsKPiA+ID4gKyAgIHZpcnRuZXRfbmFwaV90eF9lbmFibGUodmksIHNxLT52cSwgJnNxLT5uYXBp
KTsKPiA+ID4gKyAgIHJldHVybiAwOwo+ID4gPiArCj4gPiA+ICtlcnI6Cj4gPgo+ID4KPiA+IEkg
Z3Vlc3Mgd2UgY2FuIHN0aWxsIHN0YXJ0IHRoZSBxdWV1ZSBpbiB0aGlzIGNhc2U/IChTaW5jZSB3
ZSBkb24ndAo+ID4gY2hhbmdlIHRoZSBxdWV1ZSBpZiByZXNpemUgZmFpbHMpLgo+Cj4gWWVzLCB5
b3UgYXJlIHJpZ2h0Lgo+Cj4gVGhhbmtzLgo+Cj4gPgo+ID4KPiA+ID4gKyAgIG5ldGRldl9lcnIo
dmktPmRldiwKPiA+ID4gKyAgICAgICAgICAgICAgInJlc2V0IHR4IHJlc2V0IHZxIGZhaWw6IHR4
IHF1ZXVlIGluZGV4OiAldGQgZXJyOiAlZFxuIiwKPiA+ID4gKyAgICAgICAgICAgICAgc3EgLSB2
aS0+c3EsIGVycik7Cj4gPiA+ICsgICB2aXJ0bmV0X25hcGlfdHhfZW5hYmxlKHZpLCBzcS0+dnEs
ICZzcS0+bmFwaSk7Cj4gPiA+ICsgICByZXR1cm4gZXJyOwo+ID4gPiArfQo+ID4gPiArCj4gPiA+
ICAgLyoKPiA+ID4gICAgKiBTZW5kIGNvbW1hbmQgdmlhIHRoZSBjb250cm9sIHZpcnRxdWV1ZSBh
bmQgY2hlY2sgc3RhdHVzLiAgQ29tbWFuZHMKPiA+ID4gICAgKiBzdXBwb3J0ZWQgYnkgdGhlIGh5
cGVydmlzb3IsIGFzIGluZGljYXRlZCBieSBmZWF0dXJlIGJpdHMsIHNob3VsZAo+ID4KPgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
