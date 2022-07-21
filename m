Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849B5C43334
	for <virtualization@archiver.kernel.org>; Thu, 21 Jul 2022 07:09:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0AFB883FF1;
	Thu, 21 Jul 2022 07:09:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0AFB883FF1
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dPog5suA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yo8ojaOGpY0U; Thu, 21 Jul 2022 07:09:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A005683FE7;
	Thu, 21 Jul 2022 07:09:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A005683FE7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83DD4C0035;
	Thu, 21 Jul 2022 07:09:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CE1CC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 07:09:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 656BE83FF1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 07:09:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 656BE83FF1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7bkCAD83APud
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 07:09:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9A9CE83FE7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9A9CE83FE7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 07:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658387340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=20XB7X4uMFrdCQowchk09EqnsM7R3g6B8Dxeh2uQp8M=;
 b=dPog5suAhutplyA4HPvOLgpG4lj8p8qMTci/vPVSZn2FPB0A66knLJpDghmORB8C+5wZ7L
 7pMild5LsDwrhL+El5P1VEJSf+n3HqwrYdvH3V0LJj8aRnxnFRXlRUXgfBv4r7GI6WB57q
 5oreDBRQCLAdrSg2A8teiSKhVIJIQA8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-0EBcGRQkPymyFSWlU8aZZw-1; Thu, 21 Jul 2022 03:08:56 -0400
X-MC-Unique: 0EBcGRQkPymyFSWlU8aZZw-1
Received: by mail-pl1-f198.google.com with SMTP id
 w5-20020a170902e88500b0016ce31d1d79so711122plg.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 00:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=20XB7X4uMFrdCQowchk09EqnsM7R3g6B8Dxeh2uQp8M=;
 b=rkSfZ1Mted8DCDDbrpnv+B41oYG4fg9RFwOD7A+5BY6xGYy3NL51odF+UUERsTPioZ
 cXMPs/bgh+rt/5KwlaVLOyp5xh02taSuZHapV/LISQje2VpU0zivC9wBhwYxqJtRsndH
 VGj62zIUdkrsQLEWeeSUATks1WpFHTOXwRnqwID82lVlJnXlQcJADYLecNkq1kjXHXUt
 2SLjuP8cTRG36gmI3sy5f72d2g3HvYY/Qge0Step+9sAE/pHNNT7aToBQM5mbqGy7Fft
 4K7TP03i3WErMlZJ1g7DN34htdVRN+ZSdGHh9DZQjWp9z0ieoiI5i+aZmrP/SD+zG+e/
 HyVQ==
X-Gm-Message-State: AJIora/gPPiG/jHK5Yn1IstdGP4DubCek1KhqyZ2RkcSW0p0wHKDOdWl
 k9YUKCL73bT+7tujdQZMqKH7Y0rqf86FiE8Ft37vT9pR28OnnvdN188BSXBzGSnilwzHmfb0byG
 u05+LgFaZRAh+X6af9ifo3dFnfb+4bl0UqYZ0SZVUig==
X-Received: by 2002:a05:6a00:998:b0:52a:db4c:541b with SMTP id
 u24-20020a056a00099800b0052adb4c541bmr42860428pfg.35.1658387335775; 
 Thu, 21 Jul 2022 00:08:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uJ7ogdlWO9wq9dujWOVNZNut2Pk1AGg7QtSX4Ep4NpLAUcMg6IEWg7tcD5uQIK4LSqmKQ0RA==
X-Received: by 2002:a05:6a00:998:b0:52a:db4c:541b with SMTP id
 u24-20020a056a00099800b0052adb4c541bmr42860380pfg.35.1658387335468; 
 Thu, 21 Jul 2022 00:08:55 -0700 (PDT)
Received: from [10.72.12.47] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 82-20020a621455000000b0052bae7b2af8sm862397pfu.201.2022.07.21.00.08.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Jul 2022 00:08:54 -0700 (PDT)
Message-ID: <a8a9fd2e-a1e3-ad68-c085-322ec002a4d5@redhat.com>
Date: Thu, 21 Jul 2022 15:08:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v12 07/40] virtio_ring: split: introduce vring_free_split()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
 <20220720030436.79520-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220720030436.79520-8-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzcvMjAgMTE6MDQsIFh1YW4gWmh1byDlhpnpgZM6Cj4gRnJlZSB0aGUgc3RydWN0
dXJlIHN0cnVjdCB2cmluZ192cml0cXVldWVfc3BsaXQuCj4KPiBTdWJzZXF1ZW50IHBhdGNoZXMg
cmVxdWlyZSBpdC4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXgu
YWxpYmFiYS5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
CgoKPiAtLS0KPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAxMSArKysrKysrKysr
Kwo+ICAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
Ywo+IGluZGV4IDg3Y2UxNzU2MmIyOS4uYzk0YzU0NjFlNzAyIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmlu
Zy5jCj4gQEAgLTkzOSw2ICs5MzksMTcgQEAgc3RhdGljIHZvaWQgKnZpcnRxdWV1ZV9kZXRhY2hf
dW51c2VkX2J1Zl9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpCj4gICAJcmV0dXJuIE5VTEw7
Cj4gICB9Cj4gICAKPiArc3RhdGljIHZvaWQgdnJpbmdfZnJlZV9zcGxpdChzdHJ1Y3QgdnJpbmdf
dmlydHF1ZXVlX3NwbGl0ICp2cmluZ19zcGxpdCwKPiArCQkJICAgICBzdHJ1Y3QgdmlydGlvX2Rl
dmljZSAqdmRldikKPiArewo+ICsJdnJpbmdfZnJlZV9xdWV1ZSh2ZGV2LCB2cmluZ19zcGxpdC0+
cXVldWVfc2l6ZV9pbl9ieXRlcywKPiArCQkJIHZyaW5nX3NwbGl0LT52cmluZy5kZXNjLAo+ICsJ
CQkgdnJpbmdfc3BsaXQtPnF1ZXVlX2RtYV9hZGRyKTsKPiArCj4gKwlrZnJlZSh2cmluZ19zcGxp
dC0+ZGVzY19zdGF0ZSk7Cj4gKwlrZnJlZSh2cmluZ19zcGxpdC0+ZGVzY19leHRyYSk7Cj4gK30K
PiArCj4gICBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9z
cGxpdCgKPiAgIAl1bnNpZ25lZCBpbnQgaW5kZXgsCj4gICAJdW5zaWduZWQgaW50IG51bSwKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
