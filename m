Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707EBC433EF
	for <virtualization@archiver.kernel.org>; Mon,  4 Jul 2022 03:59:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0A28340121;
	Mon,  4 Jul 2022 03:59:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0A28340121
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xy3G0e+2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DP8zG9GXjJ5J; Mon,  4 Jul 2022 03:59:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7ABC240114;
	Mon,  4 Jul 2022 03:59:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7ABC240114
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4EBDDC0032;
	Mon,  4 Jul 2022 03:59:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83560C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 03:59:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5684560BB1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 03:59:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5684560BB1
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xy3G0e+2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tTa2XXKvUc-r
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 03:59:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6BA6860BC7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6BA6860BC7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 03:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656907159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p95fHLs7IXJ+3ymkILJufL2vVjxBw7J8XWFPcIqmw9I=;
 b=Xy3G0e+2hBhN4G3IS3AkdWaAA+wf+E8IOG7sIfArhsd0qba5CeMGb26G2SlOzVUGXD+GZ0
 Kuk0veM//9BI/tW1MInCF+IXLfx56u5t8QoI7LVKw7/ULhrFgwDuvAex6Dt+mOMKpJLW/B
 +lam0kbEyJ4SMODDb7V2WAlKp0rPHhc=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-mXE8e9oJPdWCgdIOZH-20g-1; Sun, 03 Jul 2022 23:59:18 -0400
X-MC-Unique: mXE8e9oJPdWCgdIOZH-20g-1
Received: by mail-pg1-f198.google.com with SMTP id
 t142-20020a635f94000000b0040d27168bf7so3479858pgb.20
 for <virtualization@lists.linux-foundation.org>;
 Sun, 03 Jul 2022 20:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=p95fHLs7IXJ+3ymkILJufL2vVjxBw7J8XWFPcIqmw9I=;
 b=TFml6kfEVlSkpwGFJjlH6/CiXnuO1PIUyBT87dvjvNKR+Lv00kgScdaPf+4ud1frPM
 a/sfl82aPYygCOB/Odj1bDYFtNveRfaTyIp//V5uZUsNW2fIzxe5KnDzn0LdIrjU5m4e
 zqWQ0Vgf5/CNE3fL7AW2I38yMb6V1mGA87oqY1BQCHUIOXClXL8udnF6rcqIOEt+7tHT
 aPNcue9Z/+wsaDaHZlvwCBzxUJAo/lzAAzSSk31mbCfcCACjn6qFh+CjzgdvcrZphOsf
 eekUV9DigADcCWLYcGBYe8mQkEi2MLzKSGpNLI0qLXeF1b2Zx4ek6/mUa8b8zuc5fcSM
 fusg==
X-Gm-Message-State: AJIora/x0me1WqWWg5Jr4A9tvAwSh8dFSHzzkjpfvs1x3qBfuZyQXcfQ
 pwYp58/inNJt4FvcdzBBPRK0X50klN+fILeXHFNBKTHCwg6dH4ZxXPWDIpxdUaoEE9BIgPG16Bk
 oKakvW6t5lYPLc2Wed5jLa4TrkysfjR74AxNVJ21RGQ==
X-Received: by 2002:a05:6a00:16ca:b0:525:a5d5:d16f with SMTP id
 l10-20020a056a0016ca00b00525a5d5d16fmr34632590pfc.9.1656907156991; 
 Sun, 03 Jul 2022 20:59:16 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sWi4hsGm0Pp4sg0fpR82xMi1IIpeySfzr0ygsh6naHJBfI17iJdT2wRICqdgS0m98H2IZYQw==
X-Received: by 2002:a05:6a00:16ca:b0:525:a5d5:d16f with SMTP id
 l10-20020a056a0016ca00b00525a5d5d16fmr34632565pfc.9.1656907156707; 
 Sun, 03 Jul 2022 20:59:16 -0700 (PDT)
Received: from [10.72.13.251] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 c9-20020a170903234900b0016be834d54asm212167plh.306.2022.07.03.20.59.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Jul 2022 20:59:16 -0700 (PDT)
Message-ID: <6daca7fd-ae2a-cd0c-2030-3c6e503a3200@redhat.com>
Date: Mon, 4 Jul 2022 11:59:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v11 08/40] virtio_ring: split: extract the logic of alloc
 queue
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-9-xuanzhuo@linux.alibaba.com>
 <3e36e44f-1f37-ad02-eb89-833a0856ec4e@redhat.com>
 <1656665158.0036178-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <1656665158.0036178-3-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Farman <farman@linux.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, kangjie.xu@linux.alibaba.com,
 Heiko Carstens <hca@linux.ibm.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
 netdev@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 Sven Schnelle <svens@linux.ibm.com>, Johannes Berg <johannes@sipsolutions.net>,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzcvMSAxNjo0NSwgWHVhbiBaaHVvIOWGmemBkzoKPiBPbiBGcmksIDEgSnVsIDIw
MjIgMTY6MjY6MjUgKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3Rl
Ogo+PiDlnKggMjAyMi82LzI5IDE0OjU2LCBYdWFuIFpodW8g5YaZ6YGTOgo+Pj4gU2VwYXJhdGUg
dGhlIGxvZ2ljIG9mIHNwbGl0IHRvIGNyZWF0ZSB2cmluZyBxdWV1ZS4KPj4+Cj4+PiBUaGlzIGZl
YXR1cmUgaXMgcmVxdWlyZWQgZm9yIHN1YnNlcXVlbnQgdmlydHVxdWV1ZSByZXNldCB2cmluZy4K
Pj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEu
Y29tPgo+Pj4gLS0tCj4+PiAgICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgNjggKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tCj4+PiAgICAxIGZpbGUgY2hhbmdlZCwg
NDIgaW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5j
Cj4+PiBpbmRleCA0OWQ2MWU0MTJkYzYuLmE5Y2ViOWMxNmM1NCAxMDA2NDQKPj4+IC0tLSBhL2Ry
aXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPj4+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmMKPj4+IEBAIC05NDksMjggKzk0OSwxOSBAQCBzdGF0aWMgdm9pZCB2cmluZ19mcmVl
X3NwbGl0KHN0cnVjdCB2cmluZ192aXJ0cXVldWVfc3BsaXQgKnZyaW5nLAo+Pj4gICAgCWtmcmVl
KHZyaW5nLT5kZXNjX2V4dHJhKTsKPj4+ICAgIH0KPj4+Cj4+PiAtc3RhdGljIHN0cnVjdCB2aXJ0
cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0cXVldWVfc3BsaXQoCj4+PiAtCXVuc2lnbmVkIGludCBp
bmRleCwKPj4+IC0JdW5zaWduZWQgaW50IG51bSwKPj4+IC0JdW5zaWduZWQgaW50IHZyaW5nX2Fs
aWduLAo+Pj4gLQlzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwKPj4+IC0JYm9vbCB3ZWFrX2Jh
cnJpZXJzLAo+Pj4gLQlib29sIG1heV9yZWR1Y2VfbnVtLAo+Pj4gLQlib29sIGNvbnRleHQsCj4+
PiAtCWJvb2wgKCpub3RpZnkpKHN0cnVjdCB2aXJ0cXVldWUgKiksCj4+PiAtCXZvaWQgKCpjYWxs
YmFjaykoc3RydWN0IHZpcnRxdWV1ZSAqKSwKPj4+IC0JY29uc3QgY2hhciAqbmFtZSkKPj4+ICtz
dGF0aWMgaW50IHZyaW5nX2FsbG9jX3F1ZXVlX3NwbGl0KHN0cnVjdCB2cmluZ192aXJ0cXVldWVf
c3BsaXQgKnZyaW5nLAo+Pj4gKwkJCQkgICBzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwKPj4+
ICsJCQkJICAgdTMyIG51bSwKPj4+ICsJCQkJICAgdW5zaWduZWQgaW50IHZyaW5nX2FsaWduLAo+
Pj4gKwkJCQkgICBib29sIG1heV9yZWR1Y2VfbnVtKQo+Pj4gICAgewo+Pj4gLQlzdHJ1Y3Qgdmly
dHF1ZXVlICp2cTsKPj4+ICAgIAl2b2lkICpxdWV1ZSA9IE5VTEw7Cj4+PiAgICAJZG1hX2FkZHJf
dCBkbWFfYWRkcjsKPj4+IC0Jc2l6ZV90IHF1ZXVlX3NpemVfaW5fYnl0ZXM7Cj4+PiAtCXN0cnVj
dCB2cmluZyB2cmluZzsKPj4+Cj4+PiAgICAJLyogV2UgYXNzdW1lIG51bSBpcyBhIHBvd2VyIG9m
IDIuICovCj4+PiAgICAJaWYgKG51bSAmIChudW0gLSAxKSkgewo+Pj4gICAgCQlkZXZfd2Fybigm
dmRldi0+ZGV2LCAiQmFkIHZpcnRxdWV1ZSBsZW5ndGggJXVcbiIsIG51bSk7Cj4+PiAtCQlyZXR1
cm4gTlVMTDsKPj4+ICsJCXJldHVybiAtRUlOVkFMOwo+Pj4gICAgCX0KPj4+Cj4+PiAgICAJLyog
VE9ETzogYWxsb2NhdGUgZWFjaCBxdWV1ZSBjaHVuayBpbmRpdmlkdWFsbHkgKi8KPj4+IEBAIC05
ODEsMTEgKzk3MiwxMSBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3Zp
cnRxdWV1ZV9zcGxpdCgKPj4+ICAgIAkJaWYgKHF1ZXVlKQo+Pj4gICAgCQkJYnJlYWs7Cj4+PiAg
ICAJCWlmICghbWF5X3JlZHVjZV9udW0pCj4+PiAtCQkJcmV0dXJuIE5VTEw7Cj4+PiArCQkJcmV0
dXJuIC1FTk9NRU07Cj4+PiAgICAJfQo+Pj4KPj4+ICAgIAlpZiAoIW51bSkKPj4+IC0JCXJldHVy
biBOVUxMOwo+Pj4gKwkJcmV0dXJuIC1FTk9NRU07Cj4+Pgo+Pj4gICAgCWlmICghcXVldWUpIHsK
Pj4+ICAgIAkJLyogVHJ5IHRvIGdldCBhIHNpbmdsZSBwYWdlLiBZb3UgYXJlIG15IG9ubHkgaG9w
ZSEgKi8KPj4+IEBAIC05OTMsMjEgKzk4NCw0NiBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAq
dnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9zcGxpdCgKPj4+ICAgIAkJCQkJICAmZG1hX2FkZHIsIEdG
UF9LRVJORUx8X19HRlBfWkVSTyk7Cj4+PiAgICAJfQo+Pj4gICAgCWlmICghcXVldWUpCj4+PiAt
CQlyZXR1cm4gTlVMTDsKPj4+ICsJCXJldHVybiAtRU5PTUVNOwo+Pj4gKwo+Pj4gKwl2cmluZ19p
bml0KCZ2cmluZy0+dnJpbmcsIG51bSwgcXVldWUsIHZyaW5nX2FsaWduKTsKPj4+Cj4+PiAtCXF1
ZXVlX3NpemVfaW5fYnl0ZXMgPSB2cmluZ19zaXplKG51bSwgdnJpbmdfYWxpZ24pOwo+Pj4gLQl2
cmluZ19pbml0KCZ2cmluZywgbnVtLCBxdWV1ZSwgdnJpbmdfYWxpZ24pOwo+Pj4gKwl2cmluZy0+
cXVldWVfZG1hX2FkZHIgPSBkbWFfYWRkcjsKPj4+ICsJdnJpbmctPnF1ZXVlX3NpemVfaW5fYnl0
ZXMgPSB2cmluZ19zaXplKG51bSwgdnJpbmdfYWxpZ24pOwo+Pj4gKwo+Pj4gKwlyZXR1cm4gMDsK
Pj4+ICt9Cj4+PiArCj4+PiArc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92
aXJ0cXVldWVfc3BsaXQoCj4+PiArCXVuc2lnbmVkIGludCBpbmRleCwKPj4+ICsJdW5zaWduZWQg
aW50IG51bSwKPj4+ICsJdW5zaWduZWQgaW50IHZyaW5nX2FsaWduLAo+Pj4gKwlzdHJ1Y3Qgdmly
dGlvX2RldmljZSAqdmRldiwKPj4+ICsJYm9vbCB3ZWFrX2JhcnJpZXJzLAo+Pj4gKwlib29sIG1h
eV9yZWR1Y2VfbnVtLAo+Pj4gKwlib29sIGNvbnRleHQsCj4+PiArCWJvb2wgKCpub3RpZnkpKHN0
cnVjdCB2aXJ0cXVldWUgKiksCj4+PiArCXZvaWQgKCpjYWxsYmFjaykoc3RydWN0IHZpcnRxdWV1
ZSAqKSwKPj4+ICsJY29uc3QgY2hhciAqbmFtZSkKPj4+ICt7Cj4+PiArCXN0cnVjdCB2cmluZ192
aXJ0cXVldWVfc3BsaXQgdnJpbmcgPSB7fTsKPj4+ICsJc3RydWN0IHZpcnRxdWV1ZSAqdnE7Cj4+
PiArCWludCBlcnI7Cj4+PiArCj4+PiArCWVyciA9IHZyaW5nX2FsbG9jX3F1ZXVlX3NwbGl0KCZ2
cmluZywgdmRldiwgbnVtLCB2cmluZ19hbGlnbiwKPj4+ICsJCQkJICAgICAgbWF5X3JlZHVjZV9u
dW0pOwo+Pj4gKwlpZiAoZXJyKQo+Pj4gKwkJcmV0dXJuIE5VTEw7Cj4+Pgo+Pj4gLQl2cSA9IF9f
dnJpbmdfbmV3X3ZpcnRxdWV1ZShpbmRleCwgdnJpbmcsIHZkZXYsIHdlYWtfYmFycmllcnMsIGNv
bnRleHQsCj4+PiAtCQkJCSAgIG5vdGlmeSwgY2FsbGJhY2ssIG5hbWUpOwo+Pj4gKwl2cSA9IF9f
dnJpbmdfbmV3X3ZpcnRxdWV1ZShpbmRleCwgdnJpbmcudnJpbmcsIHZkZXYsIHdlYWtfYmFycmll
cnMsCj4+PiArCQkJCSAgIGNvbnRleHQsIG5vdGlmeSwgY2FsbGJhY2ssIG5hbWUpOwo+Pj4gICAg
CWlmICghdnEpIHsKPj4+IC0JCXZyaW5nX2ZyZWVfcXVldWUodmRldiwgcXVldWVfc2l6ZV9pbl9i
eXRlcywgcXVldWUsCj4+PiAtCQkJCSBkbWFfYWRkcik7Cj4+PiArCQl2cmluZ19mcmVlX3NwbGl0
KCZ2cmluZywgdmRldik7Cj4+PiAgICAJCXJldHVybiBOVUxMOwo+Pj4gICAgCX0KPj4+Cj4+PiAt
CXRvX3Z2cSh2cSktPnNwbGl0LnF1ZXVlX2RtYV9hZGRyID0gZG1hX2FkZHI7Cj4+PiAtCXRvX3Z2
cSh2cSktPnNwbGl0LnF1ZXVlX3NpemVfaW5fYnl0ZXMgPSBxdWV1ZV9zaXplX2luX2J5dGVzOwo+
Pj4gKwl0b192dnEodnEpLT5zcGxpdC5xdWV1ZV9kbWFfYWRkciA9IHZyaW5nLnF1ZXVlX2RtYV9h
ZGRyOwo+Pgo+PiBOaXQ6IGhhdmluZyB0d28gcXVldWVfZG1hX2FkZHIgc2VlbXMgcmVkdW5kYW50
IChzbyBkaWQgcXVldWVfc2l6ZV9pbl9ieXRlcykuCj4gdHdvPwo+Cj4gV2hlcmUgaXMgdGhlIHBy
b2JsZW0gSSBkb24ndCB1bmRlcnN0YW5kPwo+Cj4gVGhhbmtzLgoKCkkgbWVhbnQgd2UgaGFkOgoK
IMKgwqDCoMKgwqDCoMKgIHZyaW5nLnZyaW5nID0gX3ZyaW5nOwoKaW4gX192cmluZ19uZXdfdmly
dHF1ZXVlKCkuCgpUaGlzIG1lYW5zIHdlJ2QgYmV0dGVyIGluaXRpYWxpemUgdnJpbmcgZnVsbHkg
YmVmb3JlIHRoYXQ/CgpFLmcKCnZyaW5nLnF1ZXVlX2RtYV9hZGRyID0gZG1hX2FkZHI7CgouLi4K
Cl9fdnJpbmdfbmV3X3ZpcnRxdWV1ZSgpCgpUaGFua3MKCgo+Cj4+IFRoYW5rcwo+Pgo+Pgo+Pj4g
Kwl0b192dnEodnEpLT5zcGxpdC5xdWV1ZV9zaXplX2luX2J5dGVzID0gdnJpbmcucXVldWVfc2l6
ZV9pbl9ieXRlczsKPj4+ICAgIAl0b192dnEodnEpLT53ZV9vd25fcmluZyA9IHRydWU7Cj4+Pgo+
Pj4gICAgCXJldHVybiB2cTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
