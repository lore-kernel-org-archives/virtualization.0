Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC34BC433F5
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 02:58:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C981813F3;
	Tue, 12 Apr 2022 02:58:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3wRofJlo4D98; Tue, 12 Apr 2022 02:58:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 27CCB8001C;
	Tue, 12 Apr 2022 02:58:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F28ECC0082;
	Tue, 12 Apr 2022 02:58:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43285C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 02:58:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 305D240192
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 02:58:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cA_rILXBgvqJ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 02:58:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7EF9C400EF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 02:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649732308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kb270zTcKFgdb0H5CrhMTvFSHJ9sEAjIYD+VUSYpTQc=;
 b=f7BdlZXwErmRvTqlJ7SYTZvoSQHac1CQkCdPb4izLJy3DC598P7i1MMKX4r8C0gXqJPjPW
 yya+bFlC8jZxSu0g+rcNDukYXDzF9CiI7wCWZ3jBbHfT4yzTaVkrLns/MUNguL45Rn7gTJ
 B/cg4qrF6Suau5RsN72WcGoQKmcxgLM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-eKC2dF36N-CBui2LQBkZzw-1; Mon, 11 Apr 2022 22:58:26 -0400
X-MC-Unique: eKC2dF36N-CBui2LQBkZzw-1
Received: by mail-pl1-f198.google.com with SMTP id
 h9-20020a170902f54900b001582df39ce2so2803195plf.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 19:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=kb270zTcKFgdb0H5CrhMTvFSHJ9sEAjIYD+VUSYpTQc=;
 b=BPIgxldrYsBHqHNdHLBnt5+/AHToXXfAQ4zPpOH7u+rIb9s73HDKNcPdl6oHtUlJqg
 H5E2V4fxvjmcMhBkMV2FWtf08nC2Yzu0Jy8YA6PGAW4526EHjM2HvNMSvm2AXiUiC4dH
 5eKj1A/KINHq0HyWtIXQAg4wyoyS2qVf94Jjs1WlNTZCw0sk2FwYQs5AL4zGTywB+yxQ
 2zUYwuEGEeYp68qrV/2QrJv05/rbocg6sStwFPJ8giv9R/kIKLZs4IiDieV+wXmNUsUC
 6O9hzurbc/wKU6knBYCpR3PlzbJVFKn7VdfAWZb8cWEZQOosFBeRgplNlFKYBnKXw1II
 friw==
X-Gm-Message-State: AOAM533y2ogiv5y8pDYKDTRqkHeJwi6GRct7Dbi0Td9ivhsMPjYai9eO
 4QdzAxn6vqxvGLwG2S0oQZWeV0O7epOOcmNta/M59xb5uTN/T8RsCd+UwH0Z0b9Lik/hQk6K03f
 kaj0BdPZ9NeSHvEurCwREuD7nU85y5VLSLlA2e3N+3w==
X-Received: by 2002:a17:902:7c01:b0:158:3dd6:d1ba with SMTP id
 x1-20020a1709027c0100b001583dd6d1bamr13393402pll.120.1649732305633; 
 Mon, 11 Apr 2022 19:58:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0eBbGj1OUtWYDo7mmUONDwOeZaEnnKcRCtxgJd2sVmvnSsbaW8//LNh4m+6WALJ5MiKzuew==
X-Received: by 2002:a17:902:7c01:b0:158:3dd6:d1ba with SMTP id
 x1-20020a1709027c0100b001583dd6d1bamr13393363pll.120.1649732305374; 
 Mon, 11 Apr 2022 19:58:25 -0700 (PDT)
Received: from [10.72.14.5] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 21-20020a630115000000b00382a0895661sm999882pgb.11.2022.04.11.19.58.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Apr 2022 19:58:24 -0700 (PDT)
Message-ID: <14b0c4ea-038a-8688-7ca0-4ea0ef407aba@redhat.com>
Date: Tue, 12 Apr 2022 10:58:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 05/32] virtio_ring: extract the logic of freeing vring
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-6-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVvIOWGmemBkzoKPiBJbnRyb2R1Y2Ug
dnJpbmdfZnJlZSgpIHRvIGZyZWUgdGhlIHZyaW5nIG9mIHZxLgo+Cj4gU3Vic2VxdWVudCBwYXRj
aGVzIHdpbGwgdXNlIHZyaW5nX2ZyZWUoKSBhbG9uZS4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4g
Wmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcg
PGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19y
aW5nLmMgfCAxOCArKysrKysrKysrKysrLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNl
cnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlv
L3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gaW5kZXggY2I2
MDEwNzUwYTk0Li4zM2ZkZGZiOTA3YTYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmly
dGlvX3JpbmcuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBAQCAtMjMw
MSwxNCArMjMwMSwxMCBAQCBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19uZXdfdmlydHF1ZXVlKHVu
c2lnbmVkIGludCBpbmRleCwKPiAgIH0KPiAgIEVYUE9SVF9TWU1CT0xfR1BMKHZyaW5nX25ld192
aXJ0cXVldWUpOwo+ICAgCj4gLXZvaWQgdnJpbmdfZGVsX3ZpcnRxdWV1ZShzdHJ1Y3QgdmlydHF1
ZXVlICpfdnEpCj4gK3N0YXRpYyB2b2lkIHZyaW5nX2ZyZWUoc3RydWN0IHZpcnRxdWV1ZSAqX3Zx
KQo+ICAgewo+ICAgCXN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92cSk7Cj4g
ICAKPiAtCXNwaW5fbG9jaygmdnEtPnZxLnZkZXYtPnZxc19saXN0X2xvY2spOwo+IC0JbGlzdF9k
ZWwoJl92cS0+bGlzdCk7Cj4gLQlzcGluX3VubG9jaygmdnEtPnZxLnZkZXYtPnZxc19saXN0X2xv
Y2spOwo+IC0KPiAgIAlpZiAodnEtPndlX293bl9yaW5nKSB7Cj4gICAJCWlmICh2cS0+cGFja2Vk
X3JpbmcpIHsKPiAgIAkJCXZyaW5nX2ZyZWVfcXVldWUodnEtPnZxLnZkZXYsCj4gQEAgLTIzMzks
NiArMjMzNSwxOCBAQCB2b2lkIHZyaW5nX2RlbF92aXJ0cXVldWUoc3RydWN0IHZpcnRxdWV1ZSAq
X3ZxKQo+ICAgCQlrZnJlZSh2cS0+c3BsaXQuZGVzY19zdGF0ZSk7Cj4gICAJCWtmcmVlKHZxLT5z
cGxpdC5kZXNjX2V4dHJhKTsKPiAgIAl9Cj4gK30KPiArCj4gK3ZvaWQgdnJpbmdfZGVsX3ZpcnRx
dWV1ZShzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpCj4gK3sKPiArCXN0cnVjdCB2cmluZ192aXJ0cXVl
dWUgKnZxID0gdG9fdnZxKF92cSk7Cj4gKwo+ICsJc3Bpbl9sb2NrKCZ2cS0+dnEudmRldi0+dnFz
X2xpc3RfbG9jayk7Cj4gKwlsaXN0X2RlbCgmX3ZxLT5saXN0KTsKPiArCXNwaW5fdW5sb2NrKCZ2
cS0+dnEudmRldi0+dnFzX2xpc3RfbG9jayk7Cj4gKwo+ICsJdnJpbmdfZnJlZShfdnEpOwo+ICsK
PiAgIAlrZnJlZSh2cSk7Cj4gICB9Cj4gICBFWFBPUlRfU1lNQk9MX0dQTCh2cmluZ19kZWxfdmly
dHF1ZXVlKTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
