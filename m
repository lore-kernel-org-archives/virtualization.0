Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA340C43334
	for <virtualization@archiver.kernel.org>; Fri,  1 Jul 2022 09:03:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A3F58460C;
	Fri,  1 Jul 2022 09:03:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7A3F58460C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cwAib/SV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xPe8fEM61X42; Fri,  1 Jul 2022 09:03:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E30F28415A;
	Fri,  1 Jul 2022 09:03:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E30F28415A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8103C0032;
	Fri,  1 Jul 2022 09:03:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FB72C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:03:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DE2ED40B69
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:03:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DE2ED40B69
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cwAib/SV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IM_xsRmJDFTE
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:03:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 31A0F40B7C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 31A0F40B7C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656666215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D1b6P6ndaF684cAO7Vh4K15FYuoIpDfb/buQv2cS9+s=;
 b=cwAib/SVcSnosIT6Qru3ZdypKl2x87gVyu/iczePVPCHgqMoqU17FnPOXu9CJ40N7DfNeE
 UG08uHrs8JotRxb2XgSyKIGWcsU8kOt1cNjaoscMrNurejgtME0JK4BK2hNfH4uAsCSUlw
 V5ihda7IAKjpJcVkC1z3fvyQrVKyZGk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-HtoFiPc9Mmq-3wZNYvEseA-1; Fri, 01 Jul 2022 05:03:34 -0400
X-MC-Unique: HtoFiPc9Mmq-3wZNYvEseA-1
Received: by mail-pl1-f198.google.com with SMTP id
 j5-20020a170902da8500b0016b90578019so1164356plx.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 01 Jul 2022 02:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=D1b6P6ndaF684cAO7Vh4K15FYuoIpDfb/buQv2cS9+s=;
 b=xBZ6tineMNcUow5G72+pzo9DRTykKh7NES4mZbN6+EHUKdaVuxnn4biLVCuOaShwcB
 BEbPO7ptfbXnPtqRnphBbl6xeLpV5HwHN7H8wIpEMJrRXBo3QOtWvPNR5Z8aYAUU+wmm
 kDdnQ+AbGX1y9MNtQQRRTD1AZazQsQMit41zEUSG3o7iPyqUrXxWNnXGPuwQdgJy1++R
 I+NW+PqKg6aOkgYiGhmOYJywgpiElFcqRc8G2+cFWn4DBDJRO54CjFJgvVOhrxtqdB0G
 nUc7KshB2TYwEkHTAxGhvESduPH9k/WltmTm1EqGh6n6+4qZJmdDVhiiy70XMq1IfUEX
 3kew==
X-Gm-Message-State: AJIora+falQESTWjrmdjgmrF067/3uu5RrHH/S/wdHF0qZVuAg8uA3D9
 KCOPlXZW4IAGeGIqF1NxE2AItzz2QQaHWzz+HMproYkLt0Y7nA96sfIRic4HNgJI/fHOtKpcIgt
 k2LK9mgIyDNlkJrOSynjhnNC/mogYzIlBmNNCdDllew==
X-Received: by 2002:a17:903:18c:b0:16b:8f8a:335f with SMTP id
 z12-20020a170903018c00b0016b8f8a335fmr18699050plg.133.1656666212899; 
 Fri, 01 Jul 2022 02:03:32 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1umuzlHjb+AVT8pHf+MDYjA/xytvg2Ww3qrvKeBf7drySw0yZL85wg1m0wVfhF0UW2aCpNd7Q==
X-Received: by 2002:a17:903:18c:b0:16b:8f8a:335f with SMTP id
 z12-20020a170903018c00b0016b8f8a335fmr18699008plg.133.1656666212635; 
 Fri, 01 Jul 2022 02:03:32 -0700 (PDT)
Received: from [10.72.13.237] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 s22-20020a17090aba1600b001ec71be4145sm6020700pjr.2.2022.07.01.02.03.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Jul 2022 02:03:32 -0700 (PDT)
Message-ID: <e27e4f98-5f3f-6ad5-b612-163cb967fa8a@redhat.com>
Date: Fri, 1 Jul 2022 17:03:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v11 13/40] virtio_ring: split: reserve vring_align,
 may_reduce_num
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-14-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220629065656.54420-14-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnpgZM6Cj4gSW4gdnJpbmdfY3JlYXRl
X3ZpcnRxdWV1ZV9zcGxpdCgpIHNhdmUgdnJpbmdfYWxpZ24sIG1heV9yZWR1Y2VfbnVtIHRvCj4g
c3RydWN0dXJlIHZyaW5nX3ZpcnRxdWV1ZV9zcGxpdC4gVXNlZCB0byBjcmVhdGUgYSBuZXcgdnJp
bmcgd2hlbgo+IGltcGxlbWVudGluZyByZXNpemUgLgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBa
aHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8
amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jp
bmcuYyB8IDkgKysrKysrKysrCj4gICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmly
dGlvL3ZpcnRpb19yaW5nLmMKPiBpbmRleCA0Yzg5NzJkYTU0MjMuLjljODNjNWU2ZDVhOSAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gKysrIGIvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYwo+IEBAIC0xMDUsNiArMTA1LDEzIEBAIHN0cnVjdCB2cmluZ192
aXJ0cXVldWVfc3BsaXQgewo+ICAgCS8qIERNQSBhZGRyZXNzIGFuZCBzaXplIGluZm9ybWF0aW9u
ICovCj4gICAJZG1hX2FkZHJfdCBxdWV1ZV9kbWFfYWRkcjsKPiAgIAlzaXplX3QgcXVldWVfc2l6
ZV9pbl9ieXRlczsKPiArCj4gKwkvKgo+ICsJICogVGhlIHBhcmFtZXRlcnMgZm9yIGNyZWF0aW5n
IHZyaW5ncyBhcmUgcmVzZXJ2ZWQgZm9yIGNyZWF0aW5nIG5ldwo+ICsJICogdnJpbmcuCj4gKwkg
Ki8KPiArCXUzMiB2cmluZ19hbGlnbjsKPiArCWJvb2wgbWF5X3JlZHVjZV9udW07Cj4gICB9Owo+
ICAgCj4gICBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlX3BhY2tlZCB7Cj4gQEAgLTEwOTgsNiArMTEw
NSw4IEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3Nw
bGl0KAo+ICAgCQlyZXR1cm4gTlVMTDsKPiAgIAl9Cj4gICAKPiArCXRvX3Z2cSh2cSktPnNwbGl0
LnZyaW5nX2FsaWduID0gdnJpbmdfYWxpZ247Cj4gKwl0b192dnEodnEpLT5zcGxpdC5tYXlfcmVk
dWNlX251bSA9IG1heV9yZWR1Y2VfbnVtOwo+ICAgCXRvX3Z2cSh2cSktPnNwbGl0LnF1ZXVlX2Rt
YV9hZGRyID0gdnJpbmcucXVldWVfZG1hX2FkZHI7Cj4gICAJdG9fdnZxKHZxKS0+c3BsaXQucXVl
dWVfc2l6ZV9pbl9ieXRlcyA9IHZyaW5nLnF1ZXVlX3NpemVfaW5fYnl0ZXM7Cj4gICAJdG9fdnZx
KHZxKS0+d2Vfb3duX3JpbmcgPSB0cnVlOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
