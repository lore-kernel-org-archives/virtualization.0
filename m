Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27411C433EF
	for <virtualization@archiver.kernel.org>; Fri,  1 Jul 2022 09:01:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B112460FF8;
	Fri,  1 Jul 2022 09:01:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B112460FF8
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=glbjwexd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ENZP5HIqFmBR; Fri,  1 Jul 2022 09:01:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3D17B60768;
	Fri,  1 Jul 2022 09:01:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3D17B60768
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10D79C0032;
	Fri,  1 Jul 2022 09:01:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 197F1C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:01:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E8AB5845A8
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:01:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E8AB5845A8
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=glbjwexd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 23v_3Z4Fexud
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:01:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 37D458453F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 37D458453F
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656666069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Pfa1YaU+250DlLqgk/RZjJpc0atpStbB6YSlMBczcM=;
 b=glbjwexd4Xz9i8ttbt4EvR0S5JHFRGS4KOKm2bJftjsiJnFzEGBYGhSXduouahTcQdsX3L
 ci+2Uk+t6a0fYgq5efrg0nzP1Nh232Qju3+NcdmirROPV15aPuDaC/LC/bX3rosltIFYJv
 JhpkwsiXHIK9Q43ExoH5vZK6UZTJxK4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-PI4w6QDFNzGE-l9ATCuuTA-1; Fri, 01 Jul 2022 05:01:00 -0400
X-MC-Unique: PI4w6QDFNzGE-l9ATCuuTA-1
Received: by mail-pl1-f200.google.com with SMTP id
 l6-20020a170902ec0600b0016a1fd93c28so1164425pld.17
 for <virtualization@lists.linux-foundation.org>;
 Fri, 01 Jul 2022 02:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=+Pfa1YaU+250DlLqgk/RZjJpc0atpStbB6YSlMBczcM=;
 b=xrp6uKtF6QSYCghqFFD1qppvEQjuGaV9NAAAxA+Ljy4P1/8dZ9PhJiqa90jVI0nf6q
 UOdwymKasBQEqmAFaOjB+YUMWM4N+X8b3V4kfp14zCjQN1vJuMyW80N2mv0wnxw4ONGa
 FWXkOkdYlEVXH52TlVogJorkrNjA9r+R8pEUJgGm19m221R0XhrC0H4UXQFUIwxfFSWN
 08NsgnZrUGceAX4jU1JreCOoZfRRwaZGWB0wqAJogtPQNtdhvnQzBXF9hEdhH+n8/J/f
 ZYi54zV5eER1svjO66aVlnbgvHv1QYNyMf8FWP3OZPWl5rfGI11l35RPNuUtpHEsx2xY
 sGVA==
X-Gm-Message-State: AJIora/+FoWNDfMMs3z6f/VQvlgnONmxHtrs3s59+Uv1DjrXNIAFSxeS
 8Ye7SALyt61XdiMavJ8ZE5rPSfqkR9tgFUoGzaOBgpPZY8lGcA9oZ25mDHJjmtOafZbrAaAvxIV
 36pbDJCaE/ibcKOu4RKCF4/ZCRKpYPnWR6O643W37xw==
X-Received: by 2002:a17:90b:4c4d:b0:1ec:bb28:9819 with SMTP id
 np13-20020a17090b4c4d00b001ecbb289819mr15145859pjb.140.1656666059276; 
 Fri, 01 Jul 2022 02:00:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ucPJubIDOfAC58GNC+QtWFq5Jmmypvil1fzM2cvP6k6UqH+HE5csI2QsEYjQoPJIF0N0566w==
X-Received: by 2002:a17:90b:4c4d:b0:1ec:bb28:9819 with SMTP id
 np13-20020a17090b4c4d00b001ecbb289819mr15145815pjb.140.1656666059033; 
 Fri, 01 Jul 2022 02:00:59 -0700 (PDT)
Received: from [10.72.13.237] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 jb4-20020a170903258400b00169071538a0sm14858030plb.267.2022.07.01.02.00.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Jul 2022 02:00:58 -0700 (PDT)
Message-ID: <cbdd2030-a4b3-afdd-b22d-cb8223524b20@redhat.com>
Date: Fri, 1 Jul 2022 17:00:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v11 11/40] virtio_ring: split: extract the logic of vring
 init
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-12-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220629065656.54420-12-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnpgZM6Cj4gU2VwYXJhdGUgdGhlIGxv
Z2ljIG9mIGluaXRpYWxpemluZyB2cmluZywgYW5kIHN1YnNlcXVlbnQgcGF0Y2hlcyB3aWxsCj4g
Y2FsbCBpdCBzZXBhcmF0ZWx5Lgo+Cj4gVGhpcyBmdW5jdGlvbiBjb21wbGV0ZXMgdGhlIHZhcmlh
YmxlIGluaXRpYWxpemF0aW9uIG9mIHNwbGl0IHZyaW5nLiBJdAo+IHRvZ2V0aGVyIHdpdGggdGhl
IGxvZ2ljIG9mIGF0YXRjaCBjb25zdGl0dXRlcyB0aGUgaW5pdGlhbGl6YXRpb24gb2YKPiB2cmlu
Zy4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5j
b20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0K
PiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAzMCArKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAxMSBkZWxl
dGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIv
ZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IDkwMjViZDM3M2QzYi4uMzU1NDBk
YWFhMWU3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiArKysg
Yi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTk0MCw2ICs5NDAsMjQgQEAgc3Rh
dGljIHZvaWQgKnZpcnRxdWV1ZV9kZXRhY2hfdW51c2VkX2J1Zl9zcGxpdChzdHJ1Y3QgdmlydHF1
ZXVlICpfdnEpCj4gICAJcmV0dXJuIE5VTEw7Cj4gICB9Cj4gICAKPiArc3RhdGljIHZvaWQgdmly
dHF1ZXVlX3ZyaW5nX2luaXRfc3BsaXQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEpCj4gK3sK
PiArCXN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2Owo+ICsKPiArCXZkZXYgPSB2cS0+dnEudmRl
djsKPiArCj4gKwl2cS0+c3BsaXQuYXZhaWxfZmxhZ3Nfc2hhZG93ID0gMDsKPiArCXZxLT5zcGxp
dC5hdmFpbF9pZHhfc2hhZG93ID0gMDsKPiArCj4gKwkvKiBObyBjYWxsYmFjaz8gIFRlbGwgb3Ro
ZXIgc2lkZSBub3QgdG8gYm90aGVyIHVzLiAqLwo+ICsJaWYgKCF2cS0+dnEuY2FsbGJhY2spIHsK
PiArCQl2cS0+c3BsaXQuYXZhaWxfZmxhZ3Nfc2hhZG93IHw9IFZSSU5HX0FWQUlMX0ZfTk9fSU5U
RVJSVVBUOwo+ICsJCWlmICghdnEtPmV2ZW50KQo+ICsJCQl2cS0+c3BsaXQudnJpbmcuYXZhaWwt
PmZsYWdzID0gY3B1X3RvX3ZpcnRpbzE2KHZkZXYsCj4gKwkJCQkJdnEtPnNwbGl0LmF2YWlsX2Zs
YWdzX3NoYWRvdyk7Cj4gKwl9Cj4gK30KPiArCj4gICBzdGF0aWMgdm9pZCB2aXJ0cXVldWVfdnJp
bmdfYXR0YWNoX3NwbGl0KHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLAo+ICAgCQkJCQkgc3Ry
dWN0IHZyaW5nX3ZpcnRxdWV1ZV9zcGxpdCAqdnJpbmcpCj4gICB7Cj4gQEAgLTIyOTksMTcgKzIz
MTcsNiBAQCBzdHJ1Y3QgdmlydHF1ZXVlICpfX3ZyaW5nX25ld192aXJ0cXVldWUodW5zaWduZWQg
aW50IGluZGV4LAo+ICAgCXZxLT5pbmRpcmVjdCA9IHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBW
SVJUSU9fUklOR19GX0lORElSRUNUX0RFU0MpICYmCj4gICAJCSFjb250ZXh0Owo+ICAgCj4gLQl2
cS0+c3BsaXQuYXZhaWxfZmxhZ3Nfc2hhZG93ID0gMDsKPiAtCXZxLT5zcGxpdC5hdmFpbF9pZHhf
c2hhZG93ID0gMDsKPiAtCj4gLQkvKiBObyBjYWxsYmFjaz8gIFRlbGwgb3RoZXIgc2lkZSBub3Qg
dG8gYm90aGVyIHVzLiAqLwo+IC0JaWYgKCFjYWxsYmFjaykgewo+IC0JCXZxLT5zcGxpdC5hdmFp
bF9mbGFnc19zaGFkb3cgfD0gVlJJTkdfQVZBSUxfRl9OT19JTlRFUlJVUFQ7Cj4gLQkJaWYgKCF2
cS0+ZXZlbnQpCj4gLQkJCXZxLT5zcGxpdC52cmluZy5hdmFpbC0+ZmxhZ3MgPSBjcHVfdG9fdmly
dGlvMTYodmRldiwKPiAtCQkJCQl2cS0+c3BsaXQuYXZhaWxfZmxhZ3Nfc2hhZG93KTsKPiAtCX0K
PiAtCj4gICAJdnJpbmcudnJpbmcgPSBfdnJpbmc7Cj4gICAKPiAgIAllcnIgPSB2cmluZ19hbGxv
Y19zdGF0ZV9leHRyYV9zcGxpdCgmdnJpbmcpOwo+IEBAIC0yMzIwLDYgKzIzMjcsNyBAQCBzdHJ1
Y3QgdmlydHF1ZXVlICpfX3ZyaW5nX25ld192aXJ0cXVldWUodW5zaWduZWQgaW50IGluZGV4LAo+
ICAgCj4gICAJdmlydHF1ZXVlX2luaXQodnEsIHZyaW5nLnZyaW5nLm51bSk7Cj4gICAJdmlydHF1
ZXVlX3ZyaW5nX2F0dGFjaF9zcGxpdCh2cSwgJnZyaW5nKTsKPiArCXZpcnRxdWV1ZV92cmluZ19p
bml0X3NwbGl0KHZxKTsKPiAgIAo+ICAgCXNwaW5fbG9jaygmdmRldi0+dnFzX2xpc3RfbG9jayk7
Cj4gICAJbGlzdF9hZGRfdGFpbCgmdnEtPnZxLmxpc3QsICZ2ZGV2LT52cXMpOwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
