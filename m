Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDA4C433EF
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 02:49:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B3762832C9;
	Tue, 12 Apr 2022 02:49:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QfalFu22j5O5; Tue, 12 Apr 2022 02:49:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 47A038321B;
	Tue, 12 Apr 2022 02:49:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDE21C0082;
	Tue, 12 Apr 2022 02:49:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE380C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 02:49:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D9C3783268
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 02:49:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ab5gzXBgZ_6z
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 02:49:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D2B218321B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 02:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649731774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fJBNte/3e7GfibiQrK4sBywM+oAime7uDuFoDGQDJlo=;
 b=RMEiL5h948Si5TwZueZB+WuaEr65E5Lsep0SVPubgwd1G94r6BEK/uXkkj7TuHeW9nOzyl
 EMhi+7678KH2cxyK8gm/hyYQeYMrK+itZPiSAzioRP+jrzg9Q54nZTAa6i5pQ0hRl0zdjR
 UUstmf4DnRFcsb2cwleupZAEPOq/Cfw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-552-wk9PcsDvP52YRcJFwxUMRA-1; Mon, 11 Apr 2022 22:49:33 -0400
X-MC-Unique: wk9PcsDvP52YRcJFwxUMRA-1
Received: by mail-lj1-f199.google.com with SMTP id
 q129-20020a2e5c87000000b0024b505ca589so3958586ljb.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 19:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fJBNte/3e7GfibiQrK4sBywM+oAime7uDuFoDGQDJlo=;
 b=Bz1fUoc7QipBkPfKOwhTZ6I7wT5wI1JbOdSP90zdGcHROTRAOfd7AOf+kvxI0R77px
 VINTj/QJxgXtDl8QJHSC5YAa6/s+65NfXDHiP30msJwxLpg6f/QL7BP2PeXenVk0zB4I
 9cUjSLnE/XTs665j5xBYAGTjPljDDB6jsBXlv71xCa0J4Lxk0BBqezvzsEE2VWN6+zB+
 v7RnaQFWXjhIse3Cy0zaej40AhOKQ4CxDGjFJIq3xw3A9pzRPZzKQ98PLJvPoV3pPiwd
 /HCh053prq336mI1e5jUbI+apNU5/Tx+QOIr4e4D9kihVOkELFUht/i8ZRWtrUJu8L2+
 G5mw==
X-Gm-Message-State: AOAM532VE7575i/Szsm3C9Svf+/yXlBiV9mUj2tdL7TkgKBToAv/T2Oi
 2xKy69M7JmSgCNLKOcO5AvfwF7g+Fumt+L5fo3ek2rmHZMDKxA2zPRo/EbR+TabZ9ixh+NvfUKp
 Lxdb4a2VQ/A4nhDXTLKVpy4eVd2tclivHV9QHAUEHao5ekSN0J5IIm+AwOA==
X-Received: by 2002:a2e:b53a:0:b0:24b:12f7:237b with SMTP id
 z26-20020a2eb53a000000b0024b12f7237bmr22142520ljm.177.1649731772080; 
 Mon, 11 Apr 2022 19:49:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5gifaFaCekGQJ1T+aENC3f64ZQLZ890sWCpVm+zpEZs7NBKRTWSl38qWP6QLR7AWdmzIlDvMoCmEZyQhCI0I=
X-Received: by 2002:a2e:b53a:0:b0:24b:12f7:237b with SMTP id
 z26-20020a2eb53a000000b0024b12f7237bmr22142498ljm.177.1649731771824; Mon, 11
 Apr 2022 19:49:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-3-xuanzhuo@linux.alibaba.com>
 <9868de23-c171-2492-a43f-78f51df84640@redhat.com>
In-Reply-To: <9868de23-c171-2492-a43f-78f51df84640@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Apr 2022 10:49:20 +0800
Message-ID: <CACGkMEvgO=QsBjHZLhW72gsnWUp6JWOZkSrVZYHBmPoP+KhTZg@mail.gmail.com>
Subject: Re: [PATCH v9 02/32] virtio: struct virtio_config_ops add callbacks
 for queue_reset
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 virtualization <virtualization@lists.linux-foundation.org>
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
 Jakub Kicinski <kuba@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 kvm <kvm@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
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

T24gVHVlLCBBcHIgMTIsIDIwMjIgYXQgMTA6NDcgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4KPgo+IOWcqCAyMDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVv
IOWGmemBkzoKPiA+IFBlcmZvcm1pbmcgcmVzZXQgb24gYSBxdWV1ZSBpcyBkaXZpZGVkIGludG8g
Zm91ciBzdGVwczoKPiA+Cj4gPiAgIDEuIHRyYW5zcG9ydDogbm90aWZ5IHRoZSBkZXZpY2UgdG8g
cmVzZXQgdGhlIHF1ZXVlCj4gPiAgIDIuIHZyaW5nOiAgICAgcmVjeWNsZSB0aGUgYnVmZmVyIHN1
Ym1pdHRlZAo+ID4gICAzLiB2cmluZzogICAgIHJlc2V0L3Jlc2l6ZSB0aGUgdnJpbmcgKG1heSBy
ZS1hbGxvYykKPiA+ICAgNC4gdHJhbnNwb3J0OiBtbWFwIHZyaW5nIHRvIGRldmljZSwgYW5kIGVu
YWJsZSB0aGUgcXVldWUKPgo+Cj4gTml0OiBpdCBsb29rcyB0byBtZSB3ZSdkIGJldHRlciBzYXkg
aXQncyBhbiBleGFtcGxlIChzaW5jZSBzdGVwIDMgb3IKPiBldmVuIDIgaXMgbm90IGEgbXVzdCku
Cj4KPgo+ID4KPiA+IEluIG9yZGVyIHRvIHN1cHBvcnQgcXVldWUgcmVzZXQsIGFkZCB0d28gY2Fs
bGJhY2tzKHJlc2V0X3ZxLAo+ID4gZW5hYmxlX3Jlc2V0X3ZxKSBpbiBzdHJ1Y3QgdmlydGlvX2Nv
bmZpZ19vcHMgdG8gaW1wbGVtZW50IHN0ZXBzIDEgYW5kIDQuCj4gPgo+ID4gU2lnbmVkLW9mZi1i
eTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiA+IC0tLQo+ID4gICBp
bmNsdWRlL2xpbnV4L3ZpcnRpb19jb25maWcuaCB8IDEyICsrKysrKysrKysrKwo+ID4gICAxIGZp
bGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L3ZpcnRpb19jb25maWcuaCBiL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oCj4g
PiBpbmRleCA0ZDEwN2FkMzExNDkuLmQ0YWRjZDBlMWM1NyAxMDA2NDQKPiA+IC0tLSBhL2luY2x1
ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3ZpcnRpb19j
b25maWcuaAo+ID4gQEAgLTc0LDYgKzc0LDE2IEBAIHN0cnVjdCB2aXJ0aW9fc2htX3JlZ2lvbiB7
Cj4gPiAgICAqIEBzZXRfdnFfYWZmaW5pdHk6IHNldCB0aGUgYWZmaW5pdHkgZm9yIGEgdmlydHF1
ZXVlIChvcHRpb25hbCkuCj4gPiAgICAqIEBnZXRfdnFfYWZmaW5pdHk6IGdldCB0aGUgYWZmaW5p
dHkgZm9yIGEgdmlydHF1ZXVlIChvcHRpb25hbCkuCj4gPiAgICAqIEBnZXRfc2htX3JlZ2lvbjog
Z2V0IGEgc2hhcmVkIG1lbW9yeSByZWdpb24gYmFzZWQgb24gdGhlIGluZGV4Lgo+ID4gKyAqIEBy
ZXNldF92cTogcmVzZXQgYSBxdWV1ZSBpbmRpdmlkdWFsbHkgKG9wdGlvbmFsKS4KPiA+ICsgKiAg
IHZxOiB0aGUgdmlydHF1ZXVlCj4gPiArICogICBSZXR1cm5zIDAgb24gc3VjY2VzcyBvciBlcnJv
ciBzdGF0dXMKPiA+ICsgKiAgIHJlc2V0X3ZxIHdpbGwgZ3VhcmFudGVlIHRoYXQgdGhlIGNhbGxi
YWNrcyBhcmUgZGlzYWJsZWQgYW5kIHN5bmNocm9uaXplZC4KPiA+ICsgKiAgIEV4Y2VwdCBmb3Ig
dGhlIGNhbGxiYWNrLCB0aGUgY2FsbGVyIHNob3VsZCBndWFyYW50ZWUgdGhhdCB0aGUgdnJpbmcg
aXMKPgo+Cj4gSSB3b25kZXIgd2hhdCdzIHRoZSBpbXBsaWNhdGlvbnMgZm9yIHZpcnRpbyBoYXJk
ZW5pbmdbMV0uIEluIHRoYXQKCkZvciBbMV0gSSBtZWFudApodHRwczovL2xvcmUua2VybmVsLm9y
Zy9sa21sLzIwMjIwNDA2MDgzNTM4LjE2Mjc0LTEtamFzb3dhbmdAcmVkaGF0LmNvbS8KClRoYW5r
cwoKCj4gc2VyaWVzLCB3ZSBhZ3JlZSB0byBoYXZlIGEgc3luY2hyb25pemVfdnFzKCkgY29uZmln
IG9wcyB0byBtYWtlIHN1cmUKPiBjYWxsYmFja3MgYXJlIHN5bmNocm9uaXplZC4KPgo+IEl0IHVz
ZXMgYSBnbG9iYWwgZmxhZyBhbmQgYSBkZXZpY2Ugd2lzZSBzeW5jaHJvbml6YXRpb24gbWVjaGFu
aXNtLiBJdAo+IGxvb2tzIHRvIG1lIHdlIG5lZWQgdG8gc3dpdGNoIHRvCj4KPiAxKSBwZXIgdmly
dHF1ZXVlIGZsYWcKPiAyKSBwZXIgdmlydHF1ZXVlIHN5bmNocm9uaXphdGlvbgo+Cj4gVGhhbmtz
Cj4KPgo+ID4gKyAqICAgbm90IGFjY2Vzc2VkIGJ5IGFueSBmdW5jdGlvbnMgb2YgdmlydHF1ZXVl
Lgo+ID4gKyAqIEBlbmFibGVfcmVzZXRfdnE6IGVuYWJsZSBhIHJlc2V0IHF1ZXVlCj4gPiArICog
ICB2cTogdGhlIHZpcnRxdWV1ZQo+ID4gKyAqICAgUmV0dXJucyAwIG9uIHN1Y2Nlc3Mgb3IgZXJy
b3Igc3RhdHVzCj4gPiArICogICBJZiByZXNldF92cSBpcyBzZXQsIHRoZW4gZW5hYmxlX3Jlc2V0
X3ZxIG11c3QgYWxzbyBiZSBzZXQuCj4gPiAgICAqLwo+ID4gICB0eXBlZGVmIHZvaWQgdnFfY2Fs
bGJhY2tfdChzdHJ1Y3QgdmlydHF1ZXVlICopOwo+ID4gICBzdHJ1Y3QgdmlydGlvX2NvbmZpZ19v
cHMgewo+ID4gQEAgLTEwMCw2ICsxMTAsOCBAQCBzdHJ1Y3QgdmlydGlvX2NvbmZpZ19vcHMgewo+
ID4gICAgICAgICAgICAgICAgICAgICAgIGludCBpbmRleCk7Cj4gPiAgICAgICBib29sICgqZ2V0
X3NobV9yZWdpb24pKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LAo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBzdHJ1Y3QgdmlydGlvX3NobV9yZWdpb24gKnJlZ2lvbiwgdTggaWQp
Owo+ID4gKyAgICAgaW50ICgqcmVzZXRfdnEpKHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsKPiA+ICsg
ICAgIGludCAoKmVuYWJsZV9yZXNldF92cSkoc3RydWN0IHZpcnRxdWV1ZSAqdnEpOwo+ID4gICB9
Owo+ID4KPiA+ICAgLyogSWYgZHJpdmVyIGRpZG4ndCBhZHZlcnRpc2UgdGhlIGZlYXR1cmUsIGl0
IHdpbGwgbmV2ZXIgYXBwZWFyLiAqLwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
