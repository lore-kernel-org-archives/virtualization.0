Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E452C433EF
	for <virtualization@archiver.kernel.org>; Fri,  1 Jul 2022 08:26:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D13A04089B;
	Fri,  1 Jul 2022 08:26:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D13A04089B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IPfyobFM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uCgnUSbwImRg; Fri,  1 Jul 2022 08:26:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BD4E3404BF;
	Fri,  1 Jul 2022 08:26:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BD4E3404BF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8AD8AC0032;
	Fri,  1 Jul 2022 08:26:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C2F9C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 08:26:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 614A760D89
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 08:26:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 614A760D89
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IPfyobFM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cuUsV9DsuFTm
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 08:26:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 86798608D8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 86798608D8
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 08:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656664001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mem2CtrGfxmddRRMbJG4npPrqtnwHTpIMWeASXZJ6Uo=;
 b=IPfyobFMkNdxqYU/upwO+WqXyuHqwI1B9aeLqxxpqWZ18I4O4NpPyhtHQM42kdVctk7quW
 9bv9v51Tql/4L2V5wGJlh1hw7lU1C1QoOtj/kZLX/JunUCO/DLt1x5MjVcke2UgAkmTht3
 D5Hs1t2CwXM+p2r1R+TnDOguBS5K0oc=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-224-j3OGG4EBN0OsyXspcV2cmw-1; Fri, 01 Jul 2022 04:26:40 -0400
X-MC-Unique: j3OGG4EBN0OsyXspcV2cmw-1
Received: by mail-pg1-f199.google.com with SMTP id
 d66-20020a636845000000b0040a88edd9c1so972211pgc.13
 for <virtualization@lists.linux-foundation.org>;
 Fri, 01 Jul 2022 01:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Mem2CtrGfxmddRRMbJG4npPrqtnwHTpIMWeASXZJ6Uo=;
 b=60211DAxIWlxN9EIObtVUQjt2iumgXxU8sFlI1rGXoes6tkSd4WtafvzjWaGTmESaG
 eOAgObvWec5LWhY3Qo2mMHr7+uIG8zf267nkAqt0kJkOzTvl3t6nHhT+Ashj8Z34FF9z
 tJoCqndbmdvdQ16JvCQg8IpGn0nqVNPIzIMhSJpZ6sRi/l8lHvI8ynpEmL2SQ+Vsw+E0
 TvzC1fh6O7RVAsT5QlPu3dhAwu+e58doM4PvQRFG4zU9vJYk282d2YTTUmrFWf+hm3Pk
 Gv7EBPW0b/RmDEVVak8XKN37TjbORNPfxFK+9WHPnV0PYJGC+yaXMsHevf9+LYA0zZXS
 EMqA==
X-Gm-Message-State: AJIora9Mr+FsEDlqmJGVAmtL6G7zTJWsveoRkZhZSncPzts6d/3GC3Li
 2MLPG5JzyeHUkRv9Gy2++cHd4yvabK4AhqwVWvBA9JTAVLcg46ERZwhNtaPhkUzaMUqqvV9aCOP
 owWoyXk6eugX5vU5SBUPEEdfDuj8v7inP6kS9n0epzw==
X-Received: by 2002:a17:902:e749:b0:16a:2839:9e5 with SMTP id
 p9-20020a170902e74900b0016a283909e5mr19890590plf.48.1656663999677; 
 Fri, 01 Jul 2022 01:26:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vueEJCyj9aKVsA6oCsFeYHLH6QjdhbrRxTJq+B9bWaSeLtACSCbAXT8VnogHMY6xhUpS/k6w==
X-Received: by 2002:a17:902:e749:b0:16a:2839:9e5 with SMTP id
 p9-20020a170902e74900b0016a283909e5mr19890568plf.48.1656663999418; 
 Fri, 01 Jul 2022 01:26:39 -0700 (PDT)
Received: from [10.72.13.237] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 pc3-20020a17090b3b8300b001ef3f85d1aasm2978628pjb.9.2022.07.01.01.26.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Jul 2022 01:26:38 -0700 (PDT)
Message-ID: <3e36e44f-1f37-ad02-eb89-833a0856ec4e@redhat.com>
Date: Fri, 1 Jul 2022 16:26:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v11 08/40] virtio_ring: split: extract the logic of alloc
 queue
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220629065656.54420-9-xuanzhuo@linux.alibaba.com>
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
Z2ljIG9mIHNwbGl0IHRvIGNyZWF0ZSB2cmluZyBxdWV1ZS4KPgo+IFRoaXMgZmVhdHVyZSBpcyBy
ZXF1aXJlZCBmb3Igc3Vic2VxdWVudCB2aXJ0dXF1ZXVlIHJlc2V0IHZyaW5nLgo+Cj4gU2lnbmVk
LW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiAtLS0KPiAg
IGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCA2OCArKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspLCAyNiBk
ZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5j
IGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IDQ5ZDYxZTQxMmRjNi4uYTlj
ZWI5YzE2YzU0IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiAr
KysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTk0OSwyOCArOTQ5LDE5IEBA
IHN0YXRpYyB2b2lkIHZyaW5nX2ZyZWVfc3BsaXQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZV9zcGxp
dCAqdnJpbmcsCj4gICAJa2ZyZWUodnJpbmctPmRlc2NfZXh0cmEpOwo+ICAgfQo+ICAgCj4gLXN0
YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3NwbGl0KAo+IC0J
dW5zaWduZWQgaW50IGluZGV4LAo+IC0JdW5zaWduZWQgaW50IG51bSwKPiAtCXVuc2lnbmVkIGlu
dCB2cmluZ19hbGlnbiwKPiAtCXN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LAo+IC0JYm9vbCB3
ZWFrX2JhcnJpZXJzLAo+IC0JYm9vbCBtYXlfcmVkdWNlX251bSwKPiAtCWJvb2wgY29udGV4dCwK
PiAtCWJvb2wgKCpub3RpZnkpKHN0cnVjdCB2aXJ0cXVldWUgKiksCj4gLQl2b2lkICgqY2FsbGJh
Y2spKHN0cnVjdCB2aXJ0cXVldWUgKiksCj4gLQljb25zdCBjaGFyICpuYW1lKQo+ICtzdGF0aWMg
aW50IHZyaW5nX2FsbG9jX3F1ZXVlX3NwbGl0KHN0cnVjdCB2cmluZ192aXJ0cXVldWVfc3BsaXQg
KnZyaW5nLAo+ICsJCQkJICAgc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsCj4gKwkJCQkgICB1
MzIgbnVtLAo+ICsJCQkJICAgdW5zaWduZWQgaW50IHZyaW5nX2FsaWduLAo+ICsJCQkJICAgYm9v
bCBtYXlfcmVkdWNlX251bSkKPiAgIHsKPiAtCXN0cnVjdCB2aXJ0cXVldWUgKnZxOwo+ICAgCXZv
aWQgKnF1ZXVlID0gTlVMTDsKPiAgIAlkbWFfYWRkcl90IGRtYV9hZGRyOwo+IC0Jc2l6ZV90IHF1
ZXVlX3NpemVfaW5fYnl0ZXM7Cj4gLQlzdHJ1Y3QgdnJpbmcgdnJpbmc7Cj4gICAKPiAgIAkvKiBX
ZSBhc3N1bWUgbnVtIGlzIGEgcG93ZXIgb2YgMi4gKi8KPiAgIAlpZiAobnVtICYgKG51bSAtIDEp
KSB7Cj4gICAJCWRldl93YXJuKCZ2ZGV2LT5kZXYsICJCYWQgdmlydHF1ZXVlIGxlbmd0aCAldVxu
IiwgbnVtKTsKPiAtCQlyZXR1cm4gTlVMTDsKPiArCQlyZXR1cm4gLUVJTlZBTDsKPiAgIAl9Cj4g
ICAKPiAgIAkvKiBUT0RPOiBhbGxvY2F0ZSBlYWNoIHF1ZXVlIGNodW5rIGluZGl2aWR1YWxseSAq
Lwo+IEBAIC05ODEsMTEgKzk3MiwxMSBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdf
Y3JlYXRlX3ZpcnRxdWV1ZV9zcGxpdCgKPiAgIAkJaWYgKHF1ZXVlKQo+ICAgCQkJYnJlYWs7Cj4g
ICAJCWlmICghbWF5X3JlZHVjZV9udW0pCj4gLQkJCXJldHVybiBOVUxMOwo+ICsJCQlyZXR1cm4g
LUVOT01FTTsKPiAgIAl9Cj4gICAKPiAgIAlpZiAoIW51bSkKPiAtCQlyZXR1cm4gTlVMTDsKPiAr
CQlyZXR1cm4gLUVOT01FTTsKPiAgIAo+ICAgCWlmICghcXVldWUpIHsKPiAgIAkJLyogVHJ5IHRv
IGdldCBhIHNpbmdsZSBwYWdlLiBZb3UgYXJlIG15IG9ubHkgaG9wZSEgKi8KPiBAQCAtOTkzLDIx
ICs5ODQsNDYgQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0cXVl
dWVfc3BsaXQoCj4gICAJCQkJCSAgJmRtYV9hZGRyLCBHRlBfS0VSTkVMfF9fR0ZQX1pFUk8pOwo+
ICAgCX0KPiAgIAlpZiAoIXF1ZXVlKQo+IC0JCXJldHVybiBOVUxMOwo+ICsJCXJldHVybiAtRU5P
TUVNOwo+ICsKPiArCXZyaW5nX2luaXQoJnZyaW5nLT52cmluZywgbnVtLCBxdWV1ZSwgdnJpbmdf
YWxpZ24pOwo+ICAgCj4gLQlxdWV1ZV9zaXplX2luX2J5dGVzID0gdnJpbmdfc2l6ZShudW0sIHZy
aW5nX2FsaWduKTsKPiAtCXZyaW5nX2luaXQoJnZyaW5nLCBudW0sIHF1ZXVlLCB2cmluZ19hbGln
bik7Cj4gKwl2cmluZy0+cXVldWVfZG1hX2FkZHIgPSBkbWFfYWRkcjsKPiArCXZyaW5nLT5xdWV1
ZV9zaXplX2luX2J5dGVzID0gdnJpbmdfc2l6ZShudW0sIHZyaW5nX2FsaWduKTsKPiArCj4gKwly
ZXR1cm4gMDsKPiArfQo+ICsKPiArc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0
ZV92aXJ0cXVldWVfc3BsaXQoCj4gKwl1bnNpZ25lZCBpbnQgaW5kZXgsCj4gKwl1bnNpZ25lZCBp
bnQgbnVtLAo+ICsJdW5zaWduZWQgaW50IHZyaW5nX2FsaWduLAo+ICsJc3RydWN0IHZpcnRpb19k
ZXZpY2UgKnZkZXYsCj4gKwlib29sIHdlYWtfYmFycmllcnMsCj4gKwlib29sIG1heV9yZWR1Y2Vf
bnVtLAo+ICsJYm9vbCBjb250ZXh0LAo+ICsJYm9vbCAoKm5vdGlmeSkoc3RydWN0IHZpcnRxdWV1
ZSAqKSwKPiArCXZvaWQgKCpjYWxsYmFjaykoc3RydWN0IHZpcnRxdWV1ZSAqKSwKPiArCWNvbnN0
IGNoYXIgKm5hbWUpCj4gK3sKPiArCXN0cnVjdCB2cmluZ192aXJ0cXVldWVfc3BsaXQgdnJpbmcg
PSB7fTsKPiArCXN0cnVjdCB2aXJ0cXVldWUgKnZxOwo+ICsJaW50IGVycjsKPiArCj4gKwllcnIg
PSB2cmluZ19hbGxvY19xdWV1ZV9zcGxpdCgmdnJpbmcsIHZkZXYsIG51bSwgdnJpbmdfYWxpZ24s
Cj4gKwkJCQkgICAgICBtYXlfcmVkdWNlX251bSk7Cj4gKwlpZiAoZXJyKQo+ICsJCXJldHVybiBO
VUxMOwo+ICAgCj4gLQl2cSA9IF9fdnJpbmdfbmV3X3ZpcnRxdWV1ZShpbmRleCwgdnJpbmcsIHZk
ZXYsIHdlYWtfYmFycmllcnMsIGNvbnRleHQsCj4gLQkJCQkgICBub3RpZnksIGNhbGxiYWNrLCBu
YW1lKTsKPiArCXZxID0gX192cmluZ19uZXdfdmlydHF1ZXVlKGluZGV4LCB2cmluZy52cmluZywg
dmRldiwgd2Vha19iYXJyaWVycywKPiArCQkJCSAgIGNvbnRleHQsIG5vdGlmeSwgY2FsbGJhY2ss
IG5hbWUpOwo+ICAgCWlmICghdnEpIHsKPiAtCQl2cmluZ19mcmVlX3F1ZXVlKHZkZXYsIHF1ZXVl
X3NpemVfaW5fYnl0ZXMsIHF1ZXVlLAo+IC0JCQkJIGRtYV9hZGRyKTsKPiArCQl2cmluZ19mcmVl
X3NwbGl0KCZ2cmluZywgdmRldik7Cj4gICAJCXJldHVybiBOVUxMOwo+ICAgCX0KPiAgIAo+IC0J
dG9fdnZxKHZxKS0+c3BsaXQucXVldWVfZG1hX2FkZHIgPSBkbWFfYWRkcjsKPiAtCXRvX3Z2cSh2
cSktPnNwbGl0LnF1ZXVlX3NpemVfaW5fYnl0ZXMgPSBxdWV1ZV9zaXplX2luX2J5dGVzOwo+ICsJ
dG9fdnZxKHZxKS0+c3BsaXQucXVldWVfZG1hX2FkZHIgPSB2cmluZy5xdWV1ZV9kbWFfYWRkcjsK
CgpOaXQ6IGhhdmluZyB0d28gcXVldWVfZG1hX2FkZHIgc2VlbXMgcmVkdW5kYW50IChzbyBkaWQg
cXVldWVfc2l6ZV9pbl9ieXRlcykuCgpUaGFua3MKCgo+ICsJdG9fdnZxKHZxKS0+c3BsaXQucXVl
dWVfc2l6ZV9pbl9ieXRlcyA9IHZyaW5nLnF1ZXVlX3NpemVfaW5fYnl0ZXM7Cj4gICAJdG9fdnZx
KHZxKS0+d2Vfb3duX3JpbmcgPSB0cnVlOwo+ICAgCj4gICAJcmV0dXJuIHZxOwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
