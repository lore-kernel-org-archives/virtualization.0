Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F47C43334
	for <virtualization@archiver.kernel.org>; Thu, 21 Jul 2022 09:26:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7F5D1405EC;
	Thu, 21 Jul 2022 09:26:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7F5D1405EC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bb7fqamy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eqAkBl6epVnI; Thu, 21 Jul 2022 09:26:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 01BCB4018F;
	Thu, 21 Jul 2022 09:26:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 01BCB4018F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF9CBC0033;
	Thu, 21 Jul 2022 09:26:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB4D9C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:26:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CC8378476E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:26:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CC8378476E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bb7fqamy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xzzBor5Csi6W
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:26:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CAACA81AC4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CAACA81AC4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658395580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pxqVBZnZmkgOHYwiYGXPDu4uhyKliCc2cAcObS0C01w=;
 b=bb7fqamyHS9GFmq8uDAqWQwb3iJWNvxV9yoq01Smrxkx/x6QUiQDKZ7fHM9p+QCb82ouby
 9KFPRl6THFvmGU9gCQ2KedVChMpYy2Nu4mIVAfHqY9nBG1GCKzmM7QJ0CYeqFF12jIs6xj
 efsJ5tdAHnrnH7/6H1vKQ1QijtDM84k=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-U78XJI3bOdmsACV5n9idYQ-1; Thu, 21 Jul 2022 05:26:19 -0400
X-MC-Unique: U78XJI3bOdmsACV5n9idYQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 r6-20020a17090a2e8600b001f0768a1af1so2560174pjd.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 02:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=pxqVBZnZmkgOHYwiYGXPDu4uhyKliCc2cAcObS0C01w=;
 b=xK3AvB1hfdXQ1xtsKrAImSctsWKA8MJPDgDGQzM5pMQ3NITXW7XtsmbDcOprQI/00X
 Ofm3P5EBzvZmRmC6lQNyr5Kiv7vxBO0i5Hlw+3f3hPrJEzfug4PJKgwCIm+fbIlSJDaw
 y52j9LYdHYIlPu3DW9Pu92XgB6QJLsNdBVASObfAUQ/1Iwr+WaPeSNyFmzEXLqCIsVIU
 MRSG8i4KG/PLp9AsGqu0Nz8UqKeZX8L7fynVNkw4O+B+kO25gfra+Aag5iEWbe1UDfPc
 1ZIgGXkWZObXt1OTaHl+Y/7WRjkQp0HTALv29I0k85EssDq6ebj43lVj0o1FLN7ulS5B
 NHTw==
X-Gm-Message-State: AJIora/Ax7bmSye6D+ujAhvxWUcjxbBT5kNDgxmq0hsdb8P2KxRmci+J
 nGL1MpP7vDWBUC10XvXGAhTvTFzvVtjFTxt5bspVUc+KlNurIoEv/DhOJXxb+GfK4yyVpY6f5xR
 fi15j2hlHJo57qkVHcBOdE+nZkK74Wi/bKl35dphpaw==
X-Received: by 2002:a17:90a:f481:b0:1f2:43c:a61 with SMTP id
 bx1-20020a17090af48100b001f2043c0a61mr10625081pjb.134.1658395578171; 
 Thu, 21 Jul 2022 02:26:18 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sVEm7Oz/22bKmKW2lh3GmJtdU5mssFIrGu+0Tisk4DP+fMNvbSDHGVBHUYgonKpLqTeG+uag==
X-Received: by 2002:a17:90a:f481:b0:1f2:43c:a61 with SMTP id
 bx1-20020a17090af48100b001f2043c0a61mr10625043pjb.134.1658395577872; 
 Thu, 21 Jul 2022 02:26:17 -0700 (PDT)
Received: from [10.72.12.47] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 l28-20020a635b5c000000b0041a411823d4sm1036080pgm.22.2022.07.21.02.26.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Jul 2022 02:26:17 -0700 (PDT)
Message-ID: <726a5056-789a-b445-a2c6-879008ad270a@redhat.com>
Date: Thu, 21 Jul 2022 17:25:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v12 38/40] virtio_net: support rx queue resize
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
 <20220720030436.79520-39-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220720030436.79520-39-xuanzhuo@linux.alibaba.com>
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
 Jakub Kicinski <kuba@kernel.org>, Eric Farman <farman@linux.ibm.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 kangjie.xu@linux.alibaba.com, Heiko Carstens <hca@linux.ibm.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 Johannes Berg <johannes@sipsolutions.net>,
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

CuWcqCAyMDIyLzcvMjAgMTE6MDQsIFh1YW4gWmh1byDlhpnpgZM6Cj4gVGhpcyBwYXRjaCBpbXBs
ZW1lbnRzIHRoZSByZXNpemUgZnVuY3Rpb24gb2YgdGhlIHJ4IHF1ZXVlcy4KPiBCYXNlZCBvbiB0
aGlzIGZ1bmN0aW9uLCBpdCBpcyBwb3NzaWJsZSB0byBtb2RpZnkgdGhlIHJpbmcgbnVtIG9mIHRo
ZQo+IHF1ZXVlLgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5h
bGliYWJhLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDIyICsrKysr
KysrKysrKysrKysrKysrKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmly
dGlvX25ldC5jCj4gaW5kZXggZmU0ZGM0M2MwNWExLi4xMTE1YThiNTlhMDggMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25l
dC5jCj4gQEAgLTI3OCw2ICsyNzgsOCBAQCBzdHJ1Y3QgcGFkZGVkX3ZuZXRfaGRyIHsKPiAgIAlj
aGFyIHBhZGRpbmdbMTJdOwo+ICAgfTsKPiAgIAo+ICtzdGF0aWMgdm9pZCB2aXJ0bmV0X3JxX2Zy
ZWVfdW51c2VkX2J1ZihzdHJ1Y3QgdmlydHF1ZXVlICp2cSwgdm9pZCAqYnVmKTsKPiArCj4gICBz
dGF0aWMgYm9vbCBpc194ZHBfZnJhbWUodm9pZCAqcHRyKQo+ICAgewo+ICAgCXJldHVybiAodW5z
aWduZWQgbG9uZylwdHIgJiBWSVJUSU9fWERQX0ZMQUc7Cj4gQEAgLTE4NDYsNiArMTg0OCwyNiBA
QCBzdGF0aWMgbmV0ZGV2X3R4X3Qgc3RhcnRfeG1pdChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1
Y3QgbmV0X2RldmljZSAqZGV2KQo+ICAgCXJldHVybiBORVRERVZfVFhfT0s7Cj4gICB9Cj4gICAK
PiArc3RhdGljIGludCB2aXJ0bmV0X3J4X3Jlc2l6ZShzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwK
PiArCQkJICAgICBzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEsIHUzMiByaW5nX251bSkKPiArewo+
ICsJaW50IGVyciwgcWluZGV4Owo+ICsKPiArCXFpbmRleCA9IHJxIC0gdmktPnJxOwo+ICsKPiAr
CW5hcGlfZGlzYWJsZSgmcnEtPm5hcGkpOwoKCldlIG5lZWQgdG8gZGlzYWJsZSByZWZpbGwgd29y
ayBhcyB3ZWxsLiBTbyB0aGlzIHNlcmllcyBtaWdodCBuZWVkIApyZWJhc2luZyBvbiB0b3Agb2YK
Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi8yMDIyMDcwNDA3NDg1OS4xNjkxMi0xLWph
c293YW5nQHJlZGhhdC5jb20vCgpJIHdpbGwgc2VuZCBhIG5ldyB2ZXJzaW9uIChwcm9iYWJseSB0
b21vcnJvdykuCgpUaGFua3MKCgo+ICsKPiArCWVyciA9IHZpcnRxdWV1ZV9yZXNpemUocnEtPnZx
LCByaW5nX251bSwgdmlydG5ldF9ycV9mcmVlX3VudXNlZF9idWYpOwo+ICsJaWYgKGVycikKPiAr
CQluZXRkZXZfZXJyKHZpLT5kZXYsICJyZXNpemUgcnggZmFpbDogcnggcXVldWUgaW5kZXg6ICVk
IGVycjogJWRcbiIsIHFpbmRleCwgZXJyKTsKPiArCj4gKwlpZiAoIXRyeV9maWxsX3JlY3Yodmks
IHJxLCBHRlBfS0VSTkVMKSkKPiArCQlzY2hlZHVsZV9kZWxheWVkX3dvcmsoJnZpLT5yZWZpbGws
IDApOwo+ICsKPiArCXZpcnRuZXRfbmFwaV9lbmFibGUocnEtPnZxLCAmcnEtPm5hcGkpOwo+ICsJ
cmV0dXJuIGVycjsKPiArfQo+ICsKPiAgIC8qCj4gICAgKiBTZW5kIGNvbW1hbmQgdmlhIHRoZSBj
b250cm9sIHZpcnRxdWV1ZSBhbmQgY2hlY2sgc3RhdHVzLiAgQ29tbWFuZHMKPiAgICAqIHN1cHBv
cnRlZCBieSB0aGUgaHlwZXJ2aXNvciwgYXMgaW5kaWNhdGVkIGJ5IGZlYXR1cmUgYml0cywgc2hv
dWxkCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
