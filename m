Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F37C19F21
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 04:35:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9637D8196A;
	Wed, 27 Jul 2022 04:35:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9637D8196A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dgRTNSxh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EQXDD1E5VTMN; Wed, 27 Jul 2022 04:35:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3CC3081947;
	Wed, 27 Jul 2022 04:35:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3CC3081947
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16CB4C0035;
	Wed, 27 Jul 2022 04:35:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BA90C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 04:35:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 50CF4408B6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 04:35:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 50CF4408B6
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dgRTNSxh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SYOOBJ9y50Um
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 04:35:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C767408B5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C767408B5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 04:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658896531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Nhmdd76VxuZywcj4ABrLti2+JKOVAikxn2IN6L8acM=;
 b=dgRTNSxhuFkV7YNGzVBVDTQKwFbBAV/jaFluy71WagnQS8IaRLJYgs3CA1NRb7X7q6wk62
 1NwdA91oL99Ezay9+Yo8dKObFk17QPtPoW+oc9Kf0VJK6zDFh/6wRZaGg3e0bmZU3K/s5A
 miArsWOBOoUjN+rhqJcWAmcXvTrSQoo=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-654xtBtIOommn60hbxSYeg-1; Wed, 27 Jul 2022 00:35:29 -0400
X-MC-Unique: 654xtBtIOommn60hbxSYeg-1
Received: by mail-pf1-f199.google.com with SMTP id
 p21-20020aa78615000000b00528d84505b5so5488097pfn.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 21:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=4Nhmdd76VxuZywcj4ABrLti2+JKOVAikxn2IN6L8acM=;
 b=kmdqpjneuJU9gT+qWQ0qnRQ99lYJBZNsUYCIeJc8TQb4erGFflRFIy++tQbA1wQzCZ
 4l374cz3M8c280CwwPV2YqURjKt8cgDzVcB77pF+G4Xh9IcVGpZNtY6modrY+GQdpM0g
 brn13hFvzJ/3rsGVRsYzoEEA79/TTdAdpv5GQF3kfmpu+Y1NWVVXU1fXFlRP/SDA0sSQ
 rKc6HKK19fNgCy/rdioLyYCsL04CilaygCv0pf8ShXJVBw+jWhYL9u4U87kJk3aGXGHU
 sqY25dZ4VHUwCMIumy1owjhnHBbNbtTTxPRGafUVRkA5NmCERS4g5RyRHZ5am11Ye6C9
 IvjQ==
X-Gm-Message-State: AJIora97hIE4lMlR6fMgZyqfB1w0ou8HA0nRHojWfR0pxyQKJiCvVipk
 yL7iYDYlzzIspRsaQ3JHH2BqVqnl4uVg5k2tPJqn/sqN0L8Gs7Qw9JkQv2UhvPa20eWBZmFju3W
 NiJTVO2OtUsJRzt7gYSsrIru63MRdQDVxL8MCJGv4wQ==
X-Received: by 2002:a17:90b:1d90:b0:1f2:5f47:ca6c with SMTP id
 pf16-20020a17090b1d9000b001f25f47ca6cmr2521244pjb.162.1658896528726; 
 Tue, 26 Jul 2022 21:35:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sv66YMuYLn2D/TECwlGvVrDyp85rujIUbxh1LnRrYj8nx/VinuiyLNA/hwGDceqmYNtwAlaQ==
X-Received: by 2002:a17:90b:1d90:b0:1f2:5f47:ca6c with SMTP id
 pf16-20020a17090b1d9000b001f25f47ca6cmr2521196pjb.162.1658896528457; 
 Tue, 26 Jul 2022 21:35:28 -0700 (PDT)
Received: from [10.72.12.96] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 i17-20020a170902c95100b0016d9d729f0bsm2843421pla.135.2022.07.26.21.35.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Jul 2022 21:35:26 -0700 (PDT)
Message-ID: <7b33b166-785f-ef8a-153f-e0b1c3b7e23d@redhat.com>
Date: Wed, 27 Jul 2022 12:35:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v13 22/42] virtio_ring: packed: introduce
 virtqueue_reinit_packed()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
 <20220726072225.19884-23-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220726072225.19884-23-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzcvMjYgMTU6MjIsIFh1YW4gWmh1byDlhpnpgZM6Cj4gSW50cm9kdWNlIGEgZnVu
Y3Rpb24gdG8gaW5pdGlhbGl6ZSB2cSB3aXRob3V0IGFsbG9jYXRpbmcgbmV3IHJpbmcsCj4gZGVz
Y19zdGF0ZSwgZGVzY19leHRyYS4KPgo+IFN1YnNlcXVlbnQgcGF0Y2hlcyB3aWxsIGNhbGwgdGhp
cyBmdW5jdGlvbiBhZnRlciByZXNldCB2cSB0bwo+IHJlaW5pdGlhbGl6ZSB2cS4KPgo+IFNpZ25l
ZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+CgoKQWNrZWQt
Ynk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMv
dmlydGlvL3ZpcnRpb19yaW5nLmMgfCAyMSArKysrKysrKysrKysrKysrKysrKysKPiAgIDEgZmls
ZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0
aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBpbmRleCAw
MGIxOGNmM2I0ZDkuLjdkNGM0NDRiNWE5ZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcmluZy5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IEBAIC0x
OTU3LDYgKzE5NTcsMjcgQEAgc3RhdGljIHZvaWQgdmlydHF1ZXVlX3ZyaW5nX2F0dGFjaF9wYWNr
ZWQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEsCj4gICAJdnEtPnBhY2tlZCA9ICp2cmluZ19w
YWNrZWQ7Cj4gICB9Cj4gICAKPiArc3RhdGljIHZvaWQgdmlydHF1ZXVlX3JlaW5pdF9wYWNrZWQo
c3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEpCj4gK3sKPiArCWludCBzaXplLCBpOwo+ICsKPiAr
CW1lbXNldCh2cS0+cGFja2VkLnZyaW5nLmRldmljZSwgMCwgdnEtPnBhY2tlZC5ldmVudF9zaXpl
X2luX2J5dGVzKTsKPiArCW1lbXNldCh2cS0+cGFja2VkLnZyaW5nLmRyaXZlciwgMCwgdnEtPnBh
Y2tlZC5ldmVudF9zaXplX2luX2J5dGVzKTsKPiArCW1lbXNldCh2cS0+cGFja2VkLnZyaW5nLmRl
c2MsIDAsIHZxLT5wYWNrZWQucmluZ19zaXplX2luX2J5dGVzKTsKPiArCj4gKwlzaXplID0gc2l6
ZW9mKHN0cnVjdCB2cmluZ19kZXNjX3N0YXRlX3BhY2tlZCkgKiB2cS0+cGFja2VkLnZyaW5nLm51
bTsKPiArCW1lbXNldCh2cS0+cGFja2VkLmRlc2Nfc3RhdGUsIDAsIHNpemUpOwo+ICsKPiArCXNp
emUgPSBzaXplb2Yoc3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEpICogdnEtPnBhY2tlZC52cmluZy5u
dW07Cj4gKwltZW1zZXQodnEtPnBhY2tlZC5kZXNjX2V4dHJhLCAwLCBzaXplKTsKPiArCj4gKwlm
b3IgKGkgPSAwOyBpIDwgdnEtPnBhY2tlZC52cmluZy5udW0gLSAxOyBpKyspCj4gKwkJdnEtPnBh
Y2tlZC5kZXNjX2V4dHJhW2ldLm5leHQgPSBpICsgMTsKPiArCj4gKwl2aXJ0cXVldWVfaW5pdCh2
cSwgdnEtPnBhY2tlZC52cmluZy5udW0pOwo+ICsJdmlydHF1ZXVlX3ZyaW5nX2luaXRfcGFja2Vk
KCZ2cS0+cGFja2VkLCAhIXZxLT52cS5jYWxsYmFjayk7Cj4gK30KPiArCj4gICBzdGF0aWMgc3Ry
dWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9wYWNrZWQoCj4gICAJdW5zaWdu
ZWQgaW50IGluZGV4LAo+ICAgCXVuc2lnbmVkIGludCBudW0sCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
