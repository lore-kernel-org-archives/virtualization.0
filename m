Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41033C433EF
	for <virtualization@archiver.kernel.org>; Mon, 25 Jul 2022 06:57:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C568283EC9;
	Mon, 25 Jul 2022 06:57:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C568283EC9
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PPhGBllW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q3_GKeP6XM1B; Mon, 25 Jul 2022 06:57:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3AC6783E96;
	Mon, 25 Jul 2022 06:57:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3AC6783E96
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14E4DC0035;
	Mon, 25 Jul 2022 06:57:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B8EBC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 06:57:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0365E40CB7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 06:57:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0365E40CB7
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PPhGBllW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bD1oYByi3MI6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 06:57:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7FD9440CB0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7FD9440CB0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 06:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658732245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qmW1hBnXSgXOK1sS9gN4+759LGb0Ym1b2aF+Hz+Xy9U=;
 b=PPhGBllWVvabbVQVeGNpYrkjYRPiC085JZEIVLd7t+hZcTZgbjXxReeX4mRTi7cA7d8JMx
 xvTPwn1baLVaMDK8Ah94ChDeZDn3KXQ9kzEkD7poe6BkiO50WsVb9xfV/rTnGLDzNmooe5
 DbN8EundsC8we50zNOqvnSirdBQlxsI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-NQwcKrhrNtWkN2DJ83n1bw-1; Mon, 25 Jul 2022 02:57:24 -0400
X-MC-Unique: NQwcKrhrNtWkN2DJ83n1bw-1
Received: by mail-lj1-f200.google.com with SMTP id
 f8-20020a05651c02c800b0025deec855c6so1602943ljo.15
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Jul 2022 23:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qmW1hBnXSgXOK1sS9gN4+759LGb0Ym1b2aF+Hz+Xy9U=;
 b=pKGl/nCp7v4Y3VBvtBmei63uj88a3RlRhzlyynOiQ/h9TQm4KzzgVSlW1w7PUPwIjo
 POBN6tBB3GiJY3vQqIHXUnMNgaBxFVqGQL7/3GuStwRybMSb7VKZTUXIdcN58wQ3zZsb
 GdBFHbh7TucsknSTGI5XfdZzzMPSYucS1qL2D9z+XX/+ZUgK62yX1VG+ozTnmPpddl8z
 gGgBoHw2w/8nuk4S0nItkfMseZOPm84vIl5atMLFN5j0rS8+qvrASEfSdEQtqioVdHZD
 YX/aB2d4r356qOkg2osMRXNTzBpc8whJNGBhav74Or+y+zOX9enjWIhXL8zfKww3bES9
 PAIw==
X-Gm-Message-State: AJIora/F2Hz1zM0U/iCHZz1xV15WgaagmLAZIpU55b2JHiroEd/6nUsE
 UCH3NcuhTfGrg/76e9IkKsNQ9uaaRPDqtfmhHky3TfRYisVrAAnLBBsm6LAPCoCfFTafNbIeqkd
 m8JWq80nljroj8/8ywEA3TnAEtBl6zYGw7T/ek/wG/U8WCxkg/ivNpIjEJQ==
X-Received: by 2002:ac2:4205:0:b0:48a:95e6:395c with SMTP id
 y5-20020ac24205000000b0048a95e6395cmr365159lfh.238.1658732242419; 
 Sun, 24 Jul 2022 23:57:22 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1unkGiIlKuXLUSHpJBWTVSAU4zhX72Do0K+zbnbWWScjjTYkm8xiqqQ6k0g8uFHQC6oNFJAAG44P+Vps9/gr6o=
X-Received: by 2002:ac2:4205:0:b0:48a:95e6:395c with SMTP id
 y5-20020ac24205000000b0048a95e6395cmr365123lfh.238.1658732242186; Sun, 24 Jul
 2022 23:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
 <20220720030436.79520-39-xuanzhuo@linux.alibaba.com>
 <726a5056-789a-b445-a2c6-879008ad270a@redhat.com>
 <1658731116.1695666-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1658731116.1695666-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Jul 2022 14:57:11 +0800
Message-ID: <CACGkMEvsAyR5uRprobv-bQYPOKKOM4sZzQ-Vw5ZiETMjiCkdRQ@mail.gmail.com>
Subject: Re: [PATCH v12 38/40] virtio_net: support rx queue resize
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 kvm <kvm@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Farman <farman@linux.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, Kangjie Xu <kangjie.xu@linux.alibaba.com>,
 Heiko Carstens <hca@linux.ibm.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org,
 "open list:XDP \(eXpress Data Path\)" <bpf@vger.kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
 netdev <netdev@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gTW9uLCBKdWwgMjUsIDIwMjIgYXQgMjo0MyBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIFRodSwgMjEgSnVsIDIwMjIgMTc6MjU6NTkgKzA4
MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IOWcqCAy
MDIyLzcvMjAgMTE6MDQsIFh1YW4gWmh1byDlhpnpgZM6Cj4gPiA+IFRoaXMgcGF0Y2ggaW1wbGVt
ZW50cyB0aGUgcmVzaXplIGZ1bmN0aW9uIG9mIHRoZSByeCBxdWV1ZXMuCj4gPiA+IEJhc2VkIG9u
IHRoaXMgZnVuY3Rpb24sIGl0IGlzIHBvc3NpYmxlIHRvIG1vZGlmeSB0aGUgcmluZyBudW0gb2Yg
dGhlCj4gPiA+IHF1ZXVlLgo+ID4gPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1
YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+ID4gPiAtLS0KPiA+ID4gICBkcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMgfCAyMiArKysrKysrKysrKysrKysrKysrKysrCj4gPiA+ICAgMSBmaWxlIGNo
YW5nZWQsIDIyIGluc2VydGlvbnMoKykKPiA+ID4KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiBpbmRleCBm
ZTRkYzQzYzA1YTEuLjExMTVhOGI1OWEwOCAxMDA2NDQKPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQv
dmlydGlvX25ldC5jCj4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiBA
QCAtMjc4LDYgKzI3OCw4IEBAIHN0cnVjdCBwYWRkZWRfdm5ldF9oZHIgewo+ID4gPiAgICAgY2hh
ciBwYWRkaW5nWzEyXTsKPiA+ID4gICB9Owo+ID4gPgo+ID4gPiArc3RhdGljIHZvaWQgdmlydG5l
dF9ycV9mcmVlX3VudXNlZF9idWYoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHZvaWQgKmJ1Zik7Cj4g
PiA+ICsKPiA+ID4gICBzdGF0aWMgYm9vbCBpc194ZHBfZnJhbWUodm9pZCAqcHRyKQo+ID4gPiAg
IHsKPiA+ID4gICAgIHJldHVybiAodW5zaWduZWQgbG9uZylwdHIgJiBWSVJUSU9fWERQX0ZMQUc7
Cj4gPiA+IEBAIC0xODQ2LDYgKzE4NDgsMjYgQEAgc3RhdGljIG5ldGRldl90eF90IHN0YXJ0X3ht
aXQoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IG5ldF9kZXZpY2UgKmRldikKPiA+ID4gICAg
IHJldHVybiBORVRERVZfVFhfT0s7Cj4gPiA+ICAgfQo+ID4gPgo+ID4gPiArc3RhdGljIGludCB2
aXJ0bmV0X3J4X3Jlc2l6ZShzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKPiA+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgIHN0cnVjdCByZWNlaXZlX3F1ZXVlICpycSwgdTMyIHJpbmdfbnVtKQo+
ID4gPiArewo+ID4gPiArICAgaW50IGVyciwgcWluZGV4Owo+ID4gPiArCj4gPiA+ICsgICBxaW5k
ZXggPSBycSAtIHZpLT5ycTsKPiA+ID4gKwo+ID4gPiArICAgbmFwaV9kaXNhYmxlKCZycS0+bmFw
aSk7Cj4gPgo+ID4KPiA+IFdlIG5lZWQgdG8gZGlzYWJsZSByZWZpbGwgd29yayBhcyB3ZWxsLiBT
byB0aGlzIHNlcmllcyBtaWdodCBuZWVkCj4gPiByZWJhc2luZyBvbiB0b3Agb2YKPiA+Cj4gPiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvMjAyMjA3MDQwNzQ4NTkuMTY5MTItMS1qYXNv
d2FuZ0ByZWRoYXQuY29tLwo+Cj4gSSB1bmRlcnN0YW5kIHRoYXQgeW91ciBwYXRjaCBpcyB1c2Vk
IHRvIHNvbHZlIHRoZSBzaXR1YXRpb24gd2hlcmUgZGV2IGlzCj4gZGVzdG9yeWVkIGJ1dCByZWZp
bGwgd29yayBpcyBydW5uaW5nLgo+Cj4gQW5kIGlzIHRoZXJlIHN1Y2ggYSBwb3NzaWJpbGl0eSBo
ZXJlPwoKRS5nIHRoZSByZWZpbGwgd29yayBydW5zIGluIHBhcmFsbGVsIHdpdGggdGhpcyBmdW5j
dGlvbj8KClRoYW5rcwoKPiBPciBpcyB0aGVyZSBhbnkgb3RoZXIgc2NlbmFyaW8gdGhhdCBJJ20K
PiBub3QgZXhwZWN0aW5nPwo+Cj4gVGhhbmtzLgo+Cj4KPiA+Cj4gPiBJIHdpbGwgc2VuZCBhIG5l
dyB2ZXJzaW9uIChwcm9iYWJseSB0b21vcnJvdykuCj4gPgo+ID4gVGhhbmtzCj4gPgo+ID4KPiA+
ID4gKwo+ID4gPiArICAgZXJyID0gdmlydHF1ZXVlX3Jlc2l6ZShycS0+dnEsIHJpbmdfbnVtLCB2
aXJ0bmV0X3JxX2ZyZWVfdW51c2VkX2J1Zik7Cj4gPiA+ICsgICBpZiAoZXJyKQo+ID4gPiArICAg
ICAgICAgICBuZXRkZXZfZXJyKHZpLT5kZXYsICJyZXNpemUgcnggZmFpbDogcnggcXVldWUgaW5k
ZXg6ICVkIGVycjogJWRcbiIsIHFpbmRleCwgZXJyKTsKPiA+ID4gKwo+ID4gPiArICAgaWYgKCF0
cnlfZmlsbF9yZWN2KHZpLCBycSwgR0ZQX0tFUk5FTCkpCj4gPiA+ICsgICAgICAgICAgIHNjaGVk
dWxlX2RlbGF5ZWRfd29yaygmdmktPnJlZmlsbCwgMCk7Cj4gPiA+ICsKPiA+ID4gKyAgIHZpcnRu
ZXRfbmFwaV9lbmFibGUocnEtPnZxLCAmcnEtPm5hcGkpOwo+ID4gPiArICAgcmV0dXJuIGVycjsK
PiA+ID4gK30KPiA+ID4gKwo+ID4gPiAgIC8qCj4gPiA+ICAgICogU2VuZCBjb21tYW5kIHZpYSB0
aGUgY29udHJvbCB2aXJ0cXVldWUgYW5kIGNoZWNrIHN0YXR1cy4gIENvbW1hbmRzCj4gPiA+ICAg
ICogc3VwcG9ydGVkIGJ5IHRoZSBoeXBlcnZpc29yLCBhcyBpbmRpY2F0ZWQgYnkgZmVhdHVyZSBi
aXRzLCBzaG91bGQKPiA+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
