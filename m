Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B30C43334
	for <virtualization@archiver.kernel.org>; Fri,  1 Jul 2022 09:31:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D25061014;
	Fri,  1 Jul 2022 09:31:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2D25061014
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VtXM5BAT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yneupM30OBbY; Fri,  1 Jul 2022 09:31:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 91AC0605E3;
	Fri,  1 Jul 2022 09:31:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 91AC0605E3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5ECFAC0035;
	Fri,  1 Jul 2022 09:31:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC9E7C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:31:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 85D2D41873
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:31:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 85D2D41873
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VtXM5BAT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9B0TYAPVHGjb
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:31:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6588941870
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6588941870
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656667909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DCnH+p8P5O1tP//jNNfRvqUnP248atTd06tmppMrMwQ=;
 b=VtXM5BATdw978yNVlFFW8YZ1+1Jh2wFuF/rsXUxh8rYiYslef44rtPuaA/CxjO3tFAafc9
 G3q+9u4BiCZrkK4+mex7s718PuigBrXmznARayVQs1aOfADhVnmBon3JhZA8KpFtxvHtdm
 Jc1TEuXaBi3QBAIa05WgtiByVgbFuLs=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-tTmwM11aPK2oSgJ00jeZow-1; Fri, 01 Jul 2022 05:31:48 -0400
X-MC-Unique: tTmwM11aPK2oSgJ00jeZow-1
Received: by mail-pl1-f200.google.com with SMTP id
 c16-20020a170902b69000b0016a71a49c0cso1199421pls.23
 for <virtualization@lists.linux-foundation.org>;
 Fri, 01 Jul 2022 02:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=DCnH+p8P5O1tP//jNNfRvqUnP248atTd06tmppMrMwQ=;
 b=KjnYtTTKZj5eupBQ9PXA21Oks6rHs6od9cKbYKD1Ge9gZb8hnff4CHDIOJHBOIvyKy
 EiicWfGYVJ9xuzcYNYOHlC3BjlYj9YIxstPLiRuuWRhyq01Vr+9/42IGO0HlEsFbDbI2
 0iOWntH2KI1e2jxRqK2yydRXCN5Iw7td3P8C/EEM96+v7g1uS2XJQvWdGhDfT6ufJn6Z
 xj7xLDcdpp1I4ea5uPW6HpC0cgxDO1shTbpUZOxaUSET30dkfETIWlyyiBFM96qC1Fky
 uQBUJ0Qjvb7oGwgsNHLjKVJ+2bxzn51nKK3YsU13v063tB/geykYsjJma2agLAcMS2di
 Bd+w==
X-Gm-Message-State: AJIora9nu1aQOsu7at6hjQKDYg847Q+aN+9mWO9SkzHXIsfZ4PXsfwKh
 gNbSO1ijGe36Uw06wblIwg8P+53/ZThlAuIPkuw+JnZdJFToeA0ejxAB1asEfcaqN+7JsVb/LdM
 NZYdFsfUn5A5QbuEJMFscsQSHvxzfarVCVU3yAdHNCQ==
X-Received: by 2002:a05:6a00:3006:b0:525:266a:852e with SMTP id
 ay6-20020a056a00300600b00525266a852emr20298535pfb.60.1656667906366; 
 Fri, 01 Jul 2022 02:31:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uKrApfLpVijt+2Yurlxy1RscauWDUj8Cy3/b4ekNnk2oyxMF7zuXLSzduxf7YrkXGtDZvHNA==
X-Received: by 2002:a05:6a00:3006:b0:525:266a:852e with SMTP id
 ay6-20020a056a00300600b00525266a852emr20298498pfb.60.1656667906086; 
 Fri, 01 Jul 2022 02:31:46 -0700 (PDT)
Received: from [10.72.13.237] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 cu7-20020a056a00448700b00525373aac7csm14994715pfb.26.2022.07.01.02.31.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Jul 2022 02:31:45 -0700 (PDT)
Message-ID: <d3788739-1c7f-4f1e-a222-f83bd73c14a1@redhat.com>
Date: Fri, 1 Jul 2022 17:31:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v11 22/40] virtio_ring: introduce virtqueue_resize()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-23-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220629065656.54420-23-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnpgZM6Cj4gSW50cm9kdWNlIHZpcnRx
dWV1ZV9yZXNpemUoKSB0byBpbXBsZW1lbnQgdGhlIHJlc2l6ZSBvZiB2cmluZy4KPiBCYXNlZCBv
biB0aGVzZSwgdGhlIGRyaXZlciBjYW4gZHluYW1pY2FsbHkgYWRqdXN0IHRoZSBzaXplIG9mIHRo
ZSB2cmluZy4KPiBGb3IgZXhhbXBsZTogZXRodG9vbCAtRy4KPgo+IHZpcnRxdWV1ZV9yZXNpemUo
KSBpbXBsZW1lbnRzIHJlc2l6ZSBiYXNlZCBvbiB0aGUgdnEgcmVzZXQgZnVuY3Rpb24uIEluCj4g
Y2FzZSBvZiBmYWlsdXJlIHRvIGFsbG9jYXRlIGEgbmV3IHZyaW5nLCBpdCB3aWxsIGdpdmUgdXAg
cmVzaXplIGFuZCB1c2UKPiB0aGUgb3JpZ2luYWwgdnJpbmcuCj4KPiBEdXJpbmcgdGhpcyBwcm9j
ZXNzLCBpZiB0aGUgcmUtZW5hYmxlIHJlc2V0IHZxIGZhaWxzLCB0aGUgdnEgY2FuIG5vCj4gbG9u
Z2VyIGJlIHVzZWQuIEFsdGhvdWdoIHRoZSBwcm9iYWJpbGl0eSBvZiB0aGlzIHNpdHVhdGlvbiBp
cyBub3QgaGlnaC4KPgo+IFRoZSBwYXJhbWV0ZXIgcmVjeWNsZSBpcyB1c2VkIHRvIHJlY3ljbGUg
dGhlIGJ1ZmZlciB0aGF0IGlzIG5vIGxvbmdlcgo+IHVzZWQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBY
dWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDcyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKwo+ICAgaW5jbHVkZS9saW51eC92aXJ0aW8uaCAgICAgICB8ICAzICsrCj4gICAyIGZpbGVz
IGNoYW5nZWQsIDc1IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IDQ4
NjA3ODcyODZkYi4uNWVjNDM2MDdjYzE1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3Zp
cnRpb19yaW5nLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTI1
NDIsNiArMjU0Miw3OCBAQCBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVl
KAo+ICAgfQo+ICAgRVhQT1JUX1NZTUJPTF9HUEwodnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZSk7Cj4g
ICAKPiArLyoqCj4gKyAqIHZpcnRxdWV1ZV9yZXNpemUgLSByZXNpemUgdGhlIHZyaW5nIG9mIHZx
Cj4gKyAqIEBfdnE6IHRoZSBzdHJ1Y3QgdmlydHF1ZXVlIHdlJ3JlIHRhbGtpbmcgYWJvdXQuCj4g
KyAqIEBudW06IG5ldyByaW5nIG51bQo+ICsgKiBAcmVjeWNsZTogY2FsbGJhY2sgZm9yIHJlY3lj
bGUgdGhlIHVzZWxlc3MgYnVmZmVyCj4gKyAqCj4gKyAqIFdoZW4gaXQgaXMgcmVhbGx5IG5lY2Vz
c2FyeSB0byBjcmVhdGUgYSBuZXcgdnJpbmcsIGl0IHdpbGwgc2V0IHRoZSBjdXJyZW50IHZxCj4g
KyAqIGludG8gdGhlIHJlc2V0IHN0YXRlLiBUaGVuIGNhbGwgdGhlIHBhc3NlZCBjYWxsYmFjayB0
byByZWN5Y2xlIHRoZSBidWZmZXIKPiArICogdGhhdCBpcyBubyBsb25nZXIgdXNlZC4gT25seSBh
ZnRlciB0aGUgbmV3IHZyaW5nIGlzIHN1Y2Nlc3NmdWxseSBjcmVhdGVkLCB0aGUKPiArICogb2xk
IHZyaW5nIHdpbGwgYmUgcmVsZWFzZWQuCj4gKyAqCj4gKyAqIENhbGxlciBtdXN0IGVuc3VyZSB3
ZSBkb24ndCBjYWxsIHRoaXMgd2l0aCBvdGhlciB2aXJ0cXVldWUgb3BlcmF0aW9ucwo+ICsgKiBh
dCB0aGUgc2FtZSB0aW1lIChleGNlcHQgd2hlcmUgbm90ZWQpLgo+ICsgKgo+ICsgKiBSZXR1cm5z
IHplcm8gb3IgYSBuZWdhdGl2ZSBlcnJvci4KPiArICogMDogc3VjY2Vzcy4KPiArICogLUVOT01F
TTogRmFpbGVkIHRvIGFsbG9jYXRlIGEgbmV3IHJpbmcsIGZhbGwgYmFjayB0byB0aGUgb3JpZ2lu
YWwgcmluZyBzaXplLgo+ICsgKiAgdnEgY2FuIHN0aWxsIHdvcmsgbm9ybWFsbHkKPiArICogLUVC
VVNZOiBGYWlsZWQgdG8gc3luYyB3aXRoIGRldmljZSwgdnEgbWF5IG5vdCB3b3JrIHByb3Blcmx5
Cj4gKyAqIC1FTk9FTlQ6IFRyYW5zcG9ydCBvciBkZXZpY2Ugbm90IHN1cHBvcnRlZAo+ICsgKiAt
RTJCSUcvLUVJTlZBTDogbnVtIGVycm9yCj4gKyAqIC1FUEVSTTogT3BlcmF0aW9uIG5vdCBwZXJt
aXR0ZWQKPiArICoKPiArICovCj4gK2ludCB2aXJ0cXVldWVfcmVzaXplKHN0cnVjdCB2aXJ0cXVl
dWUgKl92cSwgdTMyIG51bSwKPiArCQkgICAgIHZvaWQgKCpyZWN5Y2xlKShzdHJ1Y3QgdmlydHF1
ZXVlICp2cSwgdm9pZCAqYnVmKSkKPiArewo+ICsJc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEg
PSB0b192dnEoX3ZxKTsKPiArCXN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2ID0gdnEtPnZxLnZk
ZXY7Cj4gKwlib29sIHBhY2tlZDsKPiArCXZvaWQgKmJ1ZjsKPiArCWludCBlcnI7Cj4gKwo+ICsJ
aWYgKCF2cS0+d2Vfb3duX3JpbmcpCj4gKwkJcmV0dXJuIC1FUEVSTTsKPiArCj4gKwlpZiAobnVt
ID4gdnEtPnZxLm51bV9tYXgpCj4gKwkJcmV0dXJuIC1FMkJJRzsKPiArCj4gKwlpZiAoIW51bSkK
PiArCQlyZXR1cm4gLUVJTlZBTDsKPiArCj4gKwlwYWNrZWQgPSB2aXJ0aW9faGFzX2ZlYXR1cmUo
dmRldiwgVklSVElPX0ZfUklOR19QQUNLRUQpID8gdHJ1ZSA6IGZhbHNlOwoKCnZxLT5wYWNrZWRf
cmluZz8KCgo+ICsKPiArCWlmICgocGFja2VkID8gdnEtPnBhY2tlZC52cmluZy5udW0gOiB2cS0+
c3BsaXQudnJpbmcubnVtKSA9PSBudW0pCj4gKwkJcmV0dXJuIDA7Cj4gKwo+ICsJaWYgKCF2ZGV2
LT5jb25maWctPnJlc2V0X3ZxKQo+ICsJCXJldHVybiAtRU5PRU5UOwo+ICsKPiArCWlmICghdmRl
di0+Y29uZmlnLT5lbmFibGVfcmVzZXRfdnEpCj4gKwkJcmV0dXJuIC1FTk9FTlQ7CgoKTm90IHN1
cmUgdGhpcyBpcyB1c2VmdWwsIGUuZyBkcml2ZXIgbWF5IGNob29zZSB0byByZXNpemUgYWZ0ZXIg
YSByZXNldCAKb2YgdGhlIGRldmljZT8KClRoYW5rcwoKCj4gKwo+ICsJZXJyID0gdmRldi0+Y29u
ZmlnLT5yZXNldF92cShfdnEpOwo+ICsJaWYgKGVycikKPiArCQlyZXR1cm4gZXJyOwo+ICsKPiAr
CXdoaWxlICgoYnVmID0gdmlydHF1ZXVlX2RldGFjaF91bnVzZWRfYnVmKF92cSkpICE9IE5VTEwp
Cj4gKwkJcmVjeWNsZShfdnEsIGJ1Zik7Cj4gKwo+ICsJaWYgKHBhY2tlZCkKPiArCQllcnIgPSB2
aXJ0cXVldWVfcmVzaXplX3BhY2tlZChfdnEsIG51bSk7Cj4gKwllbHNlCj4gKwkJZXJyID0gdmly
dHF1ZXVlX3Jlc2l6ZV9zcGxpdChfdnEsIG51bSk7Cj4gKwo+ICsJaWYgKHZkZXYtPmNvbmZpZy0+
ZW5hYmxlX3Jlc2V0X3ZxKF92cSkpCj4gKwkJcmV0dXJuIC1FQlVTWTsKPiArCj4gKwlyZXR1cm4g
ZXJyOwo+ICt9Cj4gK0VYUE9SVF9TWU1CT0xfR1BMKHZpcnRxdWV1ZV9yZXNpemUpOwo+ICsKPiAg
IC8qIE9ubHkgYXZhaWxhYmxlIGZvciBzcGxpdCByaW5nICovCj4gICBzdHJ1Y3QgdmlydHF1ZXVl
ICp2cmluZ19uZXdfdmlydHF1ZXVlKHVuc2lnbmVkIGludCBpbmRleCwKPiAgIAkJCQkgICAgICB1
bnNpZ25lZCBpbnQgbnVtLAo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oIGIv
aW5jbHVkZS9saW51eC92aXJ0aW8uaAo+IGluZGV4IGE4MjYyMDAzMmU0My4uMTI3MjU2NmFkZWM2
IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvdmlydGlvLmgKPiArKysgYi9pbmNsdWRlL2xp
bnV4L3ZpcnRpby5oCj4gQEAgLTkxLDYgKzkxLDkgQEAgZG1hX2FkZHJfdCB2aXJ0cXVldWVfZ2V0
X2Rlc2NfYWRkcihzdHJ1Y3QgdmlydHF1ZXVlICp2cSk7Cj4gICBkbWFfYWRkcl90IHZpcnRxdWV1
ZV9nZXRfYXZhaWxfYWRkcihzdHJ1Y3QgdmlydHF1ZXVlICp2cSk7Cj4gICBkbWFfYWRkcl90IHZp
cnRxdWV1ZV9nZXRfdXNlZF9hZGRyKHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsKPiAgIAo+ICtpbnQg
dmlydHF1ZXVlX3Jlc2l6ZShzdHJ1Y3QgdmlydHF1ZXVlICp2cSwgdTMyIG51bSwKPiArCQkgICAg
IHZvaWQgKCpyZWN5Y2xlKShzdHJ1Y3QgdmlydHF1ZXVlICp2cSwgdm9pZCAqYnVmKSk7Cj4gKwo+
ICAgLyoqCj4gICAgKiB2aXJ0aW9fZGV2aWNlIC0gcmVwcmVzZW50YXRpb24gb2YgYSBkZXZpY2Ug
dXNpbmcgdmlydGlvCj4gICAgKiBAaW5kZXg6IHVuaXF1ZSBwb3NpdGlvbiBvbiB0aGUgdmlydGlv
IGJ1cwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
