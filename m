Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A317C433EF
	for <virtualization@archiver.kernel.org>; Mon,  7 Feb 2022 03:41:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BDF2F60B3A;
	Mon,  7 Feb 2022 03:41:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id or38NGPNeF70; Mon,  7 Feb 2022 03:41:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 67173607C0;
	Mon,  7 Feb 2022 03:41:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3EB1CC0011;
	Mon,  7 Feb 2022 03:41:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75BA6C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 03:41:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 62A4E40207
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 03:41:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MlXVdWzRh-Ct
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 03:41:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 655A34019F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 03:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644205277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mPACxARX/I5xiz/m71QMlfbaJbgGVVXIBRuTffqi1uU=;
 b=WOWMHjrReeIVRg1Qf85UVJAOTvRu7wBQGwraCWVsgSbBNg1JOdOZOs6VVosyFwD6+sz5nU
 XtfKG0vfoB/wcWFy4wjOlRLOPUtwdl+uUoLS9nu57MGh9Alm03U+3bZWs2X3+aDa50yqom
 j1bRSK81m3kt8Eme205FYRV0/w4DwHo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-lK3LqsNoO6Ca_Lu66O8X_g-1; Sun, 06 Feb 2022 22:41:13 -0500
X-MC-Unique: lK3LqsNoO6Ca_Lu66O8X_g-1
Received: by mail-pj1-f71.google.com with SMTP id
 iy10-20020a17090b16ca00b001b8a7ed5b2cso2517252pjb.7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 06 Feb 2022 19:41:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=mPACxARX/I5xiz/m71QMlfbaJbgGVVXIBRuTffqi1uU=;
 b=maa9LX+E4oY8eaQmbkunKepZ/Tv5ddg3Nbg84+6k+7mHxEPUQNWktC5567vDBUIZBK
 KpWMfEzZrGQI23+4BAtCVd8vEsVs3c7OgP5qulm+QBWhXZnKsedW5vGAOlgX4uCtKa+U
 1OEobm+YZCyFM82vjGtVv8Vg9UX7JqPD21T+hh2WAyFXo6sUSDRKFiZPWq3wDR012/56
 jznYmk6efGIM6shq4c22Cx1WXowbDvk0gnkw3MNCGcsknCKdqOTurWbvwZamh5EzBhk/
 /ZKEHXL3Jb/5HvxqkGzhqXs572sqlerom09PXCG9tUpiu77WFvgK6IWZgCzcNLCw58YJ
 FaJQ==
X-Gm-Message-State: AOAM5331d9EFb5y9nOxlTV0y2XzAo19GMplXC5mjoBPC3stKI0Yu8wyM
 8QOR7mv7eeS/mg4DVwluYGQ6G3bHb7L2XZwoII40vbRzfNfibXF1C/LjOGCCAGpCQwU7uEA9/vY
 rNEWbO3IXoS7fjc8B8/SHghYQYdwUYv8QLBNB1l6bwQ==
X-Received: by 2002:a62:6385:: with SMTP id x127mr13677039pfb.10.1644205272642; 
 Sun, 06 Feb 2022 19:41:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyOe3ubwUCsl51ytoYFQpcbOFgshGwu+VsOh9kV8c5aIWL/MikcAmaOlMl0lJQNMK56KLKFvA==
X-Received: by 2002:a62:6385:: with SMTP id x127mr13677031pfb.10.1644205272410; 
 Sun, 06 Feb 2022 19:41:12 -0800 (PST)
Received: from [10.72.12.157] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id a12sm5892101pfv.18.2022.02.06.19.41.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Feb 2022 19:41:11 -0800 (PST)
Message-ID: <28013a95-4ce4-7859-9ca1-d836265e8792@redhat.com>
Date: Mon, 7 Feb 2022 11:41:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v3 01/17] virtio_pci: struct virtio_pci_common_cfg add
 queue_notify_data
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20220126073533.44994-1-xuanzhuo@linux.alibaba.com>
 <20220126073533.44994-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220126073533.44994-2-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
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

CuWcqCAyMDIyLzEvMjYg5LiL5Y2IMzozNSwgWHVhbiBaaHVvIOWGmemBkzoKPiBBZGQgcXVldWVf
bm90aWZ5X2RhdGEgaW4gc3RydWN0IHZpcnRpb19wY2lfY29tbW9uX2NmZywgd2hpY2ggY29tZXMg
ZnJvbQo+IGhlcmUgaHR0cHM6Ly9naXRodWIuY29tL29hc2lzLXRjcy92aXJ0aW8tc3BlYy9pc3N1
ZXMvODkKPgo+IFNpbmNlIEkgd2FudCB0byBhZGQgcXVldWVfcmVzZXQgYWZ0ZXIgaXQsIEkgc3Vi
bWl0dGVkIHRoaXMgcGF0Y2ggZmlyc3QuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1
YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+IC0tLQo+ICAgaW5jbHVkZS91YXBpL2xpbnV4L3Zp
cnRpb19wY2kuaCB8IDEgKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4KPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19wY2kuaCBiL2luY2x1ZGUvdWFw
aS9saW51eC92aXJ0aW9fcGNpLmgKPiBpbmRleCAzYTg2ZjM2ZDdlM2QuLjQ5MmM4OWY1NmM2YSAx
MDA2NDQKPiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3BjaS5oCj4gKysrIGIvaW5j
bHVkZS91YXBpL2xpbnV4L3ZpcnRpb19wY2kuaAo+IEBAIC0xNjQsNiArMTY0LDcgQEAgc3RydWN0
IHZpcnRpb19wY2lfY29tbW9uX2NmZyB7Cj4gICAJX19sZTMyIHF1ZXVlX2F2YWlsX2hpOwkJLyog
cmVhZC13cml0ZSAqLwo+ICAgCV9fbGUzMiBxdWV1ZV91c2VkX2xvOwkJLyogcmVhZC13cml0ZSAq
Lwo+ICAgCV9fbGUzMiBxdWV1ZV91c2VkX2hpOwkJLyogcmVhZC13cml0ZSAqLwo+ICsJX19sZTE2
IHF1ZXVlX25vdGlmeV9kYXRhOwkvKiByZWFkLXdyaXRlICovCj4gICB9OwoKClNvIEkgaGFkIHRo
ZSBzYW1lIGNvbmNlcm4gYXMgcHJldmlvdXMgdmVyc2lvbi4KClRoaXMgYnJlYWtzIHVBQkkgd2hl
cmUgcHJvZ3JhbSBtYXkgdHJ5IHRvIHVzZSBzaXplb2Yoc3RydWN0IAp2aXJ0aW9fcGNpX2NvbW1v
bl9jZmcpLgoKV2UgcHJvYmFibHkgbmVlZCBhIGNvbnRhaW5lciBzdHJ1Y3R1cmUgaGVyZS4KClRI
YW5rcwoKCj4gICAKPiAgIC8qIEZpZWxkcyBpbiBWSVJUSU9fUENJX0NBUF9QQ0lfQ0ZHOiAqLwoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
