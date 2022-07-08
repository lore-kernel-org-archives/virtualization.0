Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E51A4C43334
	for <virtualization@archiver.kernel.org>; Fri,  8 Jul 2022 06:21:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6AD9B84653;
	Fri,  8 Jul 2022 06:21:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6AD9B84653
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NMCPerRJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lDpVTXH7boo2; Fri,  8 Jul 2022 06:21:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C766884082;
	Fri,  8 Jul 2022 06:21:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C766884082
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D611C0033;
	Fri,  8 Jul 2022 06:21:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5EDDC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 06:21:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B2D15844E6
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 06:21:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B2D15844E6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MuAb42vwmYLF
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 06:21:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD32B84082
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CD32B84082
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 06:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657261266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vucI6v2UNiSkfdv0+LNa4VjRInUBJ0CkIXv+ERyy8hk=;
 b=NMCPerRJwoV39q27Be+W+HBa96X3E4jiRbNkxqn4Cckn5/mWlv04rxvNNDAWUcmXxpCq4U
 MxyeLt6BRV3zva9KEoAfHccUGIvl4jbPtatSw/9Y2vE+d8QwA0q61JkbKnk90ug7X2yyPi
 I+ZEPGVbjSdYR+R0cyDLsLbgbkeUVHo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-yZuer-VMNpW65jI5OTdPAg-1; Fri, 08 Jul 2022 02:21:05 -0400
X-MC-Unique: yZuer-VMNpW65jI5OTdPAg-1
Received: by mail-lf1-f72.google.com with SMTP id
 e8-20020ac24e08000000b0047fad5770d2so7425024lfr.17
 for <virtualization@lists.linux-foundation.org>;
 Thu, 07 Jul 2022 23:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vucI6v2UNiSkfdv0+LNa4VjRInUBJ0CkIXv+ERyy8hk=;
 b=skvSRU2M3IUYDG85uE+fXnO8muBLdZvK+KaXaRd3DGM2DfAVZGcoFW17WJDmS84mAy
 9DLAx25Jfb9YGiTNeLNWTVfdgigHTAif0Srsw2uFz28W8SSxadRv3+QRS+SKYEu33fjZ
 slmLFV0AufsgwbObXD+84pZRY8ryDarWVSXHHYpla1pLHINVR2J8PxFOn2UnQpWI8DhN
 At7XmAtridpYaZJamim5qvFJkFYomWSx43C/Q+xI8ERexjsub64EvdXZ2FOVG8F7DOYh
 Y064OdSBfCWNsmXHmfbPsM9OulwP1A2brM5zeHGo1Fm1zfnktxBZkU4OBceS/x4lcDk6
 D7Ag==
X-Gm-Message-State: AJIora+Ncw3BLJ0zqWx092mFPkr0SHJHL9sJxKieV3E5uXCK2mNlWByX
 632CfJO4Z03t/j67pDyy8bjdHeRdd9q/+WQvqDjHNjeGBL9v0u93VUgvB8xCghTG7InSI14sASx
 bgen7qSoKw9CnNMw6thOcI0bw1CV4+1durwKsMgo4iakLxR8DsANuoEyKUA==
X-Received: by 2002:a2e:9ad0:0:b0:25a:7156:26bb with SMTP id
 p16-20020a2e9ad0000000b0025a715626bbmr999504ljj.141.1657261264043; 
 Thu, 07 Jul 2022 23:21:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1siGvuif2Z3b/qz6BV5rwXiRX4Y2KnHOm/sW0UQhHOR8L3Ua/tIp6J6o+V7iV6847cM54TvfHUP9+sN1Wog1zw=
X-Received: by 2002:a2e:9ad0:0:b0:25a:7156:26bb with SMTP id
 p16-20020a2e9ad0000000b0025a715626bbmr999458ljj.141.1657261263714; Thu, 07
 Jul 2022 23:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-39-xuanzhuo@linux.alibaba.com>
 <c0747cbc-685b-85a9-1931-0124124755f2@redhat.com>
 <1656986375.3420787-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1656986375.3420787-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 8 Jul 2022 14:20:52 +0800
Message-ID: <CACGkMEu80KP-ULz_CBvauRk_3XsCubMkkWv0uLnbt-wib5KOnA@mail.gmail.com>
Subject: Re: [PATCH v11 38/40] virtio_net: support rx queue resize
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
 Vasily Gorbik <gor@linux.ibm.com>, kangjie.xu@linux.alibaba.com,
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

T24gVHVlLCBKdWwgNSwgMjAyMiBhdCAxMDowMCBBTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIE1vbiwgNCBKdWwgMjAyMiAxMTo0NDoxMiArMDgw
MCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4g5ZyoIDIw
MjIvNi8yOSAxNDo1NiwgWHVhbiBaaHVvIOWGmemBkzoKPiA+ID4gVGhpcyBwYXRjaCBpbXBsZW1l
bnRzIHRoZSByZXNpemUgZnVuY3Rpb24gb2YgdGhlIHJ4IHF1ZXVlcy4KPiA+ID4gQmFzZWQgb24g
dGhpcyBmdW5jdGlvbiwgaXQgaXMgcG9zc2libGUgdG8gbW9kaWZ5IHRoZSByaW5nIG51bSBvZiB0
aGUKPiA+ID4gcXVldWUuCj4gPiA+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVh
bnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiA+IC0tLQo+ID4gPiAgIGRyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYyB8IDIyICsrKysrKysrKysrKysrKysrKysrKysKPiA+ID4gICAxIGZpbGUgY2hh
bmdlZCwgMjIgaW5zZXJ0aW9ucygrKQo+ID4gPgo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
ZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+IGluZGV4IDlm
ZTIyMmEzNjYzYS4uNmFiMTZmZDE5M2U1IDEwMDY0NAo+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMKPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+IEBA
IC0yNzgsNiArMjc4LDggQEAgc3RydWN0IHBhZGRlZF92bmV0X2hkciB7Cj4gPiA+ICAgICBjaGFy
IHBhZGRpbmdbMTJdOwo+ID4gPiAgIH07Cj4gPiA+Cj4gPiA+ICtzdGF0aWMgdm9pZCB2aXJ0bmV0
X3JxX2ZyZWVfdW51c2VkX2J1ZihzdHJ1Y3QgdmlydHF1ZXVlICp2cSwgdm9pZCAqYnVmKTsKPiA+
ID4gKwo+ID4gPiAgIHN0YXRpYyBib29sIGlzX3hkcF9mcmFtZSh2b2lkICpwdHIpCj4gPiA+ICAg
ewo+ID4gPiAgICAgcmV0dXJuICh1bnNpZ25lZCBsb25nKXB0ciAmIFZJUlRJT19YRFBfRkxBRzsK
PiA+ID4gQEAgLTE4NDYsNiArMTg0OCwyNiBAQCBzdGF0aWMgbmV0ZGV2X3R4X3Qgc3RhcnRfeG1p
dChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQo+ID4gPiAgICAg
cmV0dXJuIE5FVERFVl9UWF9PSzsKPiA+ID4gICB9Cj4gPiA+Cj4gPiA+ICtzdGF0aWMgaW50IHZp
cnRuZXRfcnhfcmVzaXplKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgc3RydWN0IHJlY2VpdmVfcXVldWUgKnJxLCB1MzIgcmluZ19udW0pCj4g
PiA+ICt7Cj4gPiA+ICsgICBpbnQgZXJyLCBxaW5kZXg7Cj4gPiA+ICsKPiA+ID4gKyAgIHFpbmRl
eCA9IHJxIC0gdmktPnJxOwo+ID4gPiArCj4gPiA+ICsgICBuYXBpX2Rpc2FibGUoJnJxLT5uYXBp
KTsKPiA+Cj4gPgo+ID4gRG8gd2UgbmVlZCB0byBjYW5jZWwgdGhlIHJlZmlsbCB3b3JrIGhlcmU/
Cj4KPgo+IEkgdGhpbmsgbm8sIG5hcGlfZGlzYWJsZSBpcyBtdXR1YWxseSBleGNsdXNpdmUsIHdo
aWNoIGVuc3VyZXMgdGhhdCB0aGVyZSB3aWxsIGJlCj4gbm8gY29uZmxpY3RzIGJldHdlZW4gdGhl
bS4KClNvIHRoaXMgc291bmRzIHNpbWlsYXIgdG8gd2hhdCBJJ3ZlIGZpeGVkIHJlY2VudGx5LgoK
MSkgTkFQSSBzY2hlZHVsZSBkZWxheWVkIHdvcmsuCjIpIHdlIGRpc2FibGUgTkFQSSBoZXJlCjMp
IGRlbGF5ZWQgd29yayBnZXQgc2NoZWR1bGUgYW5kIGNhbGwgTkFQSSBhZ2FpbgoKPwoKVGhhbmtz
Cgo+Cj4gVGhhbmtzLgo+Cj4gPgo+ID4gVGhhbmtzCj4gPgo+ID4KPiA+ID4gKwo+ID4gPiArICAg
ZXJyID0gdmlydHF1ZXVlX3Jlc2l6ZShycS0+dnEsIHJpbmdfbnVtLCB2aXJ0bmV0X3JxX2ZyZWVf
dW51c2VkX2J1Zik7Cj4gPiA+ICsgICBpZiAoZXJyKQo+ID4gPiArICAgICAgICAgICBuZXRkZXZf
ZXJyKHZpLT5kZXYsICJyZXNpemUgcnggZmFpbDogcnggcXVldWUgaW5kZXg6ICVkIGVycjogJWRc
biIsIHFpbmRleCwgZXJyKTsKPiA+ID4gKwo+ID4gPiArICAgaWYgKCF0cnlfZmlsbF9yZWN2KHZp
LCBycSwgR0ZQX0tFUk5FTCkpCj4gPiA+ICsgICAgICAgICAgIHNjaGVkdWxlX2RlbGF5ZWRfd29y
aygmdmktPnJlZmlsbCwgMCk7Cj4gPiA+ICsKPiA+ID4gKyAgIHZpcnRuZXRfbmFwaV9lbmFibGUo
cnEtPnZxLCAmcnEtPm5hcGkpOwo+ID4gPiArICAgcmV0dXJuIGVycjsKPiA+ID4gK30KPiA+ID4g
Kwo+ID4gPiAgIC8qCj4gPiA+ICAgICogU2VuZCBjb21tYW5kIHZpYSB0aGUgY29udHJvbCB2aXJ0
cXVldWUgYW5kIGNoZWNrIHN0YXR1cy4gIENvbW1hbmRzCj4gPiA+ICAgICogc3VwcG9ydGVkIGJ5
IHRoZSBoeXBlcnZpc29yLCBhcyBpbmRpY2F0ZWQgYnkgZmVhdHVyZSBiaXRzLCBzaG91bGQKPiA+
Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
