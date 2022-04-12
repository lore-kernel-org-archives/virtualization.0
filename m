Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FA0C4332F
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 02:48:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F0CFF60ECC;
	Tue, 12 Apr 2022 02:48:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EvlxX-3Q1yaT; Tue, 12 Apr 2022 02:48:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 86C9A60E8E;
	Tue, 12 Apr 2022 02:48:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F416C0082;
	Tue, 12 Apr 2022 02:48:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17446C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 02:48:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA8FE4061F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 02:48:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9NqiovwbLd3b
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 02:47:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E5B6F405EC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 02:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649731676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hJ8D0MpKmhUU0VrC5/OdFFUt9V6ywO7AHposB393jHM=;
 b=i+XExlhK6QRR4fobSoDbapPFON7ATojJoTRgUK3ZuMrkxM7nrXxpWWI8eCZBIuQnNbD/hh
 1sZZG2Zna7ZjadNPkcplt/Q4afSDaoYtynhYcoykujcLWHkBFDYR+Nnfk/uGmbRmPmx6jp
 oZziu8/DruWzlUARYMSiBlrbctE1TG0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-207-SvcCSxDVNVePbseLYqjHUQ-1; Mon, 11 Apr 2022 22:47:53 -0400
X-MC-Unique: SvcCSxDVNVePbseLYqjHUQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 y3-20020a17090a8b0300b001cb4831a8fbso724527pjn.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 19:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=hJ8D0MpKmhUU0VrC5/OdFFUt9V6ywO7AHposB393jHM=;
 b=jJUTVD/CCKNl5TuxTQsDzaFD6E2/yZWCW5CatWOYZpMXKk2yaCGmd1orO9hcm+2JKb
 Mwa/AiS7bbEaY3bO/otPuaXbS6uF9ijbyauOBHQO1vTS4J0fBrH1x6tqo0zmxfQsuPrY
 irNKlvXsMd/v7K38KFN+/ae8fxOo/xc/X740Fprm3ds+4lP9f1y7JnpjQX0ig28m2ZkK
 NAylJjEl2CWxBvncrUiy5pB+8BbFmUfo77o0qNSl7FKhGd5ZJO9Zqpegd8/7IT3mXk3a
 jqdw//+v0qZ38rzblRQkrMJl7yI3XlWZ5r0uqCNhX3at64DpqKdkM41t1Bd2kq9hfnrb
 Do3w==
X-Gm-Message-State: AOAM531IRh24mypKrjxNaEKDGVQa5F73KiReT9HaW6uVk/phOfy7na3h
 3pJN7UHKNWA6mNj7JjmmxkzyTP08srKZmVGunB6MtSAetV/DCm3NSZ0k+sTJMvXOu7WKOIY+H7l
 Q3gtuym4h/QPYWIveljqansyRCsYNGgk8jNoP3MJ2Ww==
X-Received: by 2002:a17:902:aa88:b0:156:914b:dc79 with SMTP id
 d8-20020a170902aa8800b00156914bdc79mr35261839plr.138.1649731672248; 
 Mon, 11 Apr 2022 19:47:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0iNy2ww2vpQRiLgmCUeLissGsbocjPE44RHGsIyPREMT6U8PtkHOixn6nv9QmiJuaqKxs0Q==
X-Received: by 2002:a17:902:aa88:b0:156:914b:dc79 with SMTP id
 d8-20020a170902aa8800b00156914bdc79mr35261806plr.138.1649731671976; 
 Mon, 11 Apr 2022 19:47:51 -0700 (PDT)
Received: from [10.72.14.5] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 z16-20020a637e10000000b00382b21c6b0bsm975709pgc.51.2022.04.11.19.47.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Apr 2022 19:47:51 -0700 (PDT)
Message-ID: <9868de23-c171-2492-a43f-78f51df84640@redhat.com>
Date: Tue, 12 Apr 2022 10:47:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 02/32] virtio: struct virtio_config_ops add callbacks
 for queue_reset
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-3-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 kvm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVvIOWGmemBkzoKPiBQZXJmb3JtaW5n
IHJlc2V0IG9uIGEgcXVldWUgaXMgZGl2aWRlZCBpbnRvIGZvdXIgc3RlcHM6Cj4KPiAgIDEuIHRy
YW5zcG9ydDogbm90aWZ5IHRoZSBkZXZpY2UgdG8gcmVzZXQgdGhlIHF1ZXVlCj4gICAyLiB2cmlu
ZzogICAgIHJlY3ljbGUgdGhlIGJ1ZmZlciBzdWJtaXR0ZWQKPiAgIDMuIHZyaW5nOiAgICAgcmVz
ZXQvcmVzaXplIHRoZSB2cmluZyAobWF5IHJlLWFsbG9jKQo+ICAgNC4gdHJhbnNwb3J0OiBtbWFw
IHZyaW5nIHRvIGRldmljZSwgYW5kIGVuYWJsZSB0aGUgcXVldWUKCgpOaXQ6IGl0IGxvb2tzIHRv
IG1lIHdlJ2QgYmV0dGVyIHNheSBpdCdzIGFuIGV4YW1wbGUgKHNpbmNlIHN0ZXAgMyBvciAKZXZl
biAyIGlzIG5vdCBhIG11c3QpLgoKCj4KPiBJbiBvcmRlciB0byBzdXBwb3J0IHF1ZXVlIHJlc2V0
LCBhZGQgdHdvIGNhbGxiYWNrcyhyZXNldF92cSwKPiBlbmFibGVfcmVzZXRfdnEpIGluIHN0cnVj
dCB2aXJ0aW9fY29uZmlnX29wcyB0byBpbXBsZW1lbnQgc3RlcHMgMSBhbmQgNC4KPgo+IFNpZ25l
ZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gLS0tCj4g
ICBpbmNsdWRlL2xpbnV4L3ZpcnRpb19jb25maWcuaCB8IDEyICsrKysrKysrKysrKwo+ICAgMSBm
aWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xp
bnV4L3ZpcnRpb19jb25maWcuaCBiL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oCj4gaW5k
ZXggNGQxMDdhZDMxMTQ5Li5kNGFkY2QwZTFjNTcgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51
eC92aXJ0aW9fY29uZmlnLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L3ZpcnRpb19jb25maWcuaAo+
IEBAIC03NCw2ICs3NCwxNiBAQCBzdHJ1Y3QgdmlydGlvX3NobV9yZWdpb24gewo+ICAgICogQHNl
dF92cV9hZmZpbml0eTogc2V0IHRoZSBhZmZpbml0eSBmb3IgYSB2aXJ0cXVldWUgKG9wdGlvbmFs
KS4KPiAgICAqIEBnZXRfdnFfYWZmaW5pdHk6IGdldCB0aGUgYWZmaW5pdHkgZm9yIGEgdmlydHF1
ZXVlIChvcHRpb25hbCkuCj4gICAgKiBAZ2V0X3NobV9yZWdpb246IGdldCBhIHNoYXJlZCBtZW1v
cnkgcmVnaW9uIGJhc2VkIG9uIHRoZSBpbmRleC4KPiArICogQHJlc2V0X3ZxOiByZXNldCBhIHF1
ZXVlIGluZGl2aWR1YWxseSAob3B0aW9uYWwpLgo+ICsgKgl2cTogdGhlIHZpcnRxdWV1ZQo+ICsg
KglSZXR1cm5zIDAgb24gc3VjY2VzcyBvciBlcnJvciBzdGF0dXMKPiArICoJcmVzZXRfdnEgd2ls
bCBndWFyYW50ZWUgdGhhdCB0aGUgY2FsbGJhY2tzIGFyZSBkaXNhYmxlZCBhbmQgc3luY2hyb25p
emVkLgo+ICsgKglFeGNlcHQgZm9yIHRoZSBjYWxsYmFjaywgdGhlIGNhbGxlciBzaG91bGQgZ3Vh
cmFudGVlIHRoYXQgdGhlIHZyaW5nIGlzCgoKSSB3b25kZXIgd2hhdCdzIHRoZSBpbXBsaWNhdGlv
bnMgZm9yIHZpcnRpbyBoYXJkZW5pbmdbMV0uIEluIHRoYXQgCnNlcmllcywgd2UgYWdyZWUgdG8g
aGF2ZSBhIHN5bmNocm9uaXplX3ZxcygpIGNvbmZpZyBvcHMgdG8gbWFrZSBzdXJlIApjYWxsYmFj
a3MgYXJlIHN5bmNocm9uaXplZC4KCkl0IHVzZXMgYSBnbG9iYWwgZmxhZyBhbmQgYSBkZXZpY2Ug
d2lzZSBzeW5jaHJvbml6YXRpb24gbWVjaGFuaXNtLiBJdCAKbG9va3MgdG8gbWUgd2UgbmVlZCB0
byBzd2l0Y2ggdG8KCjEpIHBlciB2aXJ0cXVldWUgZmxhZwoyKSBwZXIgdmlydHF1ZXVlIHN5bmNo
cm9uaXphdGlvbgoKVGhhbmtzCgoKPiArICoJbm90IGFjY2Vzc2VkIGJ5IGFueSBmdW5jdGlvbnMg
b2YgdmlydHF1ZXVlLgo+ICsgKiBAZW5hYmxlX3Jlc2V0X3ZxOiBlbmFibGUgYSByZXNldCBxdWV1
ZQo+ICsgKgl2cTogdGhlIHZpcnRxdWV1ZQo+ICsgKglSZXR1cm5zIDAgb24gc3VjY2VzcyBvciBl
cnJvciBzdGF0dXMKPiArICoJSWYgcmVzZXRfdnEgaXMgc2V0LCB0aGVuIGVuYWJsZV9yZXNldF92
cSBtdXN0IGFsc28gYmUgc2V0Lgo+ICAgICovCj4gICB0eXBlZGVmIHZvaWQgdnFfY2FsbGJhY2tf
dChzdHJ1Y3QgdmlydHF1ZXVlICopOwo+ICAgc3RydWN0IHZpcnRpb19jb25maWdfb3BzIHsKPiBA
QCAtMTAwLDYgKzExMCw4IEBAIHN0cnVjdCB2aXJ0aW9fY29uZmlnX29wcyB7Cj4gICAJCQlpbnQg
aW5kZXgpOwo+ICAgCWJvb2wgKCpnZXRfc2htX3JlZ2lvbikoc3RydWN0IHZpcnRpb19kZXZpY2Ug
KnZkZXYsCj4gICAJCQkgICAgICAgc3RydWN0IHZpcnRpb19zaG1fcmVnaW9uICpyZWdpb24sIHU4
IGlkKTsKPiArCWludCAoKnJlc2V0X3ZxKShzdHJ1Y3QgdmlydHF1ZXVlICp2cSk7Cj4gKwlpbnQg
KCplbmFibGVfcmVzZXRfdnEpKHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsKPiAgIH07Cj4gICAKPiAg
IC8qIElmIGRyaXZlciBkaWRuJ3QgYWR2ZXJ0aXNlIHRoZSBmZWF0dXJlLCBpdCB3aWxsIG5ldmVy
IGFwcGVhci4gKi8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
