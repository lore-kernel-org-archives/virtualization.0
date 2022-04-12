Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF933C433EF
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 07:16:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F4F241675;
	Tue, 12 Apr 2022 07:16:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iDwOaR9FF5Cv; Tue, 12 Apr 2022 07:16:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B6E1E41679;
	Tue, 12 Apr 2022 07:16:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 838FAC0033;
	Tue, 12 Apr 2022 07:16:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1A76C002C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:16:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DC5EC41675
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:16:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MFNZnUF-2Kdk
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:16:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EDD6841679
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649747762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WVzkj+bZmYlT5FAR8tqeVhbuQLiJC56RxAwusezhQ84=;
 b=PlUnFNHAstJLpO7pCb/E6f+kFvfJEsd3sa+Othqj2hmB0zFXGUtyYHL9ghX8fCa6eX9Vx+
 m16zBN5Dygfub2t4lK4Iso2tHSGSVSHLOWO+fGtmo6RMcJnKRl0FrIq5DTc/TIwsjZ47HF
 mP/TGGdLObTcDUW1u1vcnh5932fhIOI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-TmqhCM-LO9KGRxYuewDQoA-1; Tue, 12 Apr 2022 03:16:00 -0400
X-MC-Unique: TmqhCM-LO9KGRxYuewDQoA-1
Received: by mail-pj1-f69.google.com with SMTP id
 c9-20020a17090a1d0900b001caaf769af6so1090200pjd.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 00:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=WVzkj+bZmYlT5FAR8tqeVhbuQLiJC56RxAwusezhQ84=;
 b=D5LjaDAQzfSg+HBqQXFQgrxfD1tPEvFZcT6acVs59fWflYUhLdwOt1myJiLYRObVNE
 fPwhG/V05oeBm0cwS3eeQXPVehpyBY8sSxf3ksbBa0M3UuMxnMM9dtZ911vwPLezDOE3
 5DpN7uSY/OwD/b8JB8X6bR2LBI/8eG9KvFhXi6ZJaI01TM+BZ/sbxYm951cDZ4Bnm9dA
 eUsreKsjCXevzg5pQpjaS/aImgp82mniQ7v2frmTHn9XDFGg1CkOyFikTVPfaCs+bSVw
 Ne5DuoayLfUS6eg7dqkxWV1v5WzOV6sLAFVUsLfemG1mdiaBRnSXnqmEZNUcJEOBTYh4
 1TgA==
X-Gm-Message-State: AOAM531eivtr4pLjDyiqE1gaDbipdLA8Mq6NDOeCiNGH5vVoL2S9y9BA
 PDfvMirEF0DvRPu3cf9ZohJZRy/MSHionRJL1rFjrreg5Luo7gwj4Mm08Z39jhAzM3Xaelbvp3x
 rIHgBfhTq6Vd0hyWtM+Yt1Fa4h6vNasp+AFdQUw4LoQ==
X-Received: by 2002:a17:902:6b89:b0:154:623c:9517 with SMTP id
 p9-20020a1709026b8900b00154623c9517mr35687019plk.45.1649747759849; 
 Tue, 12 Apr 2022 00:15:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7Spm6ydmB4c+gNo+WzpTpSsuGx/B9P8qij+KvJBZZhrNiJwtOL5scK9AARgGePEjvxDGr1g==
X-Received: by 2002:a17:902:6b89:b0:154:623c:9517 with SMTP id
 p9-20020a1709026b8900b00154623c9517mr35687003plk.45.1649747759617; 
 Tue, 12 Apr 2022 00:15:59 -0700 (PDT)
Received: from [10.72.14.5] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 y15-20020a17090a1f4f00b001c7ecaf9e13sm1705890pjy.35.2022.04.12.00.15.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Apr 2022 00:15:59 -0700 (PDT)
Message-ID: <ccd0fd5d-389a-70e9-ae48-406514e383d6@redhat.com>
Date: Tue, 12 Apr 2022 15:15:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 27/32] virtio: add helper virtio_find_vqs_ctx_size()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-28-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-28-xuanzhuo@linux.alibaba.com>
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
aGVscGVyIHZpcnRpb19maW5kX3Zxc19jdHhfc2l6ZSgpIHRvIGNhbGwgZmluZF92cXMgYW5kIHNw
ZWNpZnkKPiB0aGUgbWF4aW11bSBzaXplIG9mIGVhY2ggdnEgcmluZy4KPgo+IFNpZ25lZC1vZmYt
Ynk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+CgoKQWNrZWQtYnk6IEph
c29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGluY2x1ZGUvbGludXgv
dmlydGlvX2NvbmZpZy5oIHwgMTIgKysrKysrKysrKysrCj4gICAxIGZpbGUgY2hhbmdlZCwgMTIg
aW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZp
Zy5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmgKPiBpbmRleCAwZjdkZWY3ZGRmZDIu
LjIyZTI5YzkyNjk0NiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZpcnRpb19jb25maWcu
aAo+ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oCj4gQEAgLTIzNSw2ICsyMzUs
MTggQEAgaW50IHZpcnRpb19maW5kX3Zxc19jdHgoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYs
IHVuc2lnbmVkIG52cXMsCj4gICAJCQkJICAgICAgY3R4LCBkZXNjKTsKPiAgIH0KPiAgIAo+ICtz
dGF0aWMgaW5saW5lCj4gK2ludCB2aXJ0aW9fZmluZF92cXNfY3R4X3NpemUoc3RydWN0IHZpcnRp
b19kZXZpY2UgKnZkZXYsIHUzMiBudnFzLAo+ICsJCQkJIHN0cnVjdCB2aXJ0cXVldWUgKnZxc1td
LAo+ICsJCQkJIHZxX2NhbGxiYWNrX3QgKmNhbGxiYWNrc1tdLAo+ICsJCQkJIGNvbnN0IGNoYXIg
KiBjb25zdCBuYW1lc1tdLAo+ICsJCQkJIHUzMiBzaXplc1tdLAo+ICsJCQkJIGNvbnN0IGJvb2wg
KmN0eCwgc3RydWN0IGlycV9hZmZpbml0eSAqZGVzYykKPiArewo+ICsJcmV0dXJuIHZkZXYtPmNv
bmZpZy0+ZmluZF92cXModmRldiwgbnZxcywgdnFzLCBjYWxsYmFja3MsIG5hbWVzLCBzaXplcywK
PiArCQkJCSAgICAgIGN0eCwgZGVzYyk7Cj4gK30KPiArCj4gICAvKioKPiAgICAqIHZpcnRpb19k
ZXZpY2VfcmVhZHkgLSBlbmFibGUgdnEgdXNlIGluIHByb2JlIGZ1bmN0aW9uCj4gICAgKiBAdmRl
djogdGhlIGRldmljZQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
