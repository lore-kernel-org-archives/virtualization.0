Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21754C433F5
	for <virtualization@archiver.kernel.org>; Mon, 28 Feb 2022 03:18:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B68B540425;
	Mon, 28 Feb 2022 03:18:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a7LAK5-akYXJ; Mon, 28 Feb 2022 03:18:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6056540362;
	Mon, 28 Feb 2022 03:18:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25E9FC0033;
	Mon, 28 Feb 2022 03:18:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3155CC001A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 03:18:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1F6D5812B5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 03:18:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 578-iEol3pLU
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 03:18:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5C76F812A8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 03:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646018327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xn+Az+CFSeJBzX65vjUuwFVqmJGow2gEtXe4FrB4xlA=;
 b=Aik5jXcwmHeUFuruqTZkYAOb0HlmVwBZuAyiy+Q8Ayt/X72GDrVeUGYoYgfY1DrCoMZo9R
 41e8OIG1/lV/1Vu690qEsES1JrnWjCMtL81O3noFqBBP6uSikj8HiCkpIEY78OnZuwi2ET
 lG1n3WIC7vX6H4PXmSob2h8UAlT4i5A=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-538-K8ZB-eh5Ngq2i0gQBe5C9Q-1; Sun, 27 Feb 2022 22:18:46 -0500
X-MC-Unique: K8ZB-eh5Ngq2i0gQBe5C9Q-1
Received: by mail-pj1-f72.google.com with SMTP id
 m3-20020a17090a3f8300b001bd33af55f2so1862351pjc.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Feb 2022 19:18:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Xn+Az+CFSeJBzX65vjUuwFVqmJGow2gEtXe4FrB4xlA=;
 b=DxT6Aahb5Xl/M0P7iHt3XzJ/hSMaF619YBLtAiWywuIwL0Wqmnf7x+pz39WL+v5WA+
 09H/iE+bAFiymdCl2+q9wUrf/up3B5I224dozcHJtjbiRHNNeZ/tO9pdMFcL1PSbGrU0
 Yi3CHiN0shOMs7xqC8ee+7jbvob0KQmnchx6qOHV+LFl2rgmINUSuk+7bXWuOE7v0HFU
 rpLugITH+E213bAeeJfTc5xvW6PlLHZzMFvvfc8wA37Pexhio/LjTbChKiySidqqiA0q
 eIKZ2MFpjw92NyqJjQiIKe6NWgzDgPHGaECluM+4oWJwBe8AJQ52iAqkT/JwM8aR0S0n
 7LQg==
X-Gm-Message-State: AOAM533mcKls9WqaC10y311LPnqAWccqD7Th2SuLArHL8RGtESR/MeEX
 gQCmVkn2iOXgj05/kXx0u9iYdfbTU+mcmqLnj0tJlCd+gjZZS9bmKRPDeM3D/p0d6LA4b4TV+SA
 91ml/0WOJXVDTRVrx096u6BdNuBMVWmmBkINDHIAYew==
X-Received: by 2002:a17:90a:f48f:b0:1bc:2521:fb0a with SMTP id
 bx15-20020a17090af48f00b001bc2521fb0amr14681750pjb.48.1646018325657; 
 Sun, 27 Feb 2022 19:18:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRheqPOne1hVfTfPRIbBY/rkeKoAuZJNl8PCgJ1Q7bWhhYlKpS5VczN73TCtI6FazI2q4N7w==
X-Received: by 2002:a17:90a:f48f:b0:1bc:2521:fb0a with SMTP id
 bx15-20020a17090af48f00b001bc2521fb0amr14681708pjb.48.1646018325357; 
 Sun, 27 Feb 2022 19:18:45 -0800 (PST)
Received: from [10.72.13.215] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 gl5-20020a17090b120500b001bc5d44f233sm14937012pjb.52.2022.02.27.19.18.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Feb 2022 19:18:44 -0800 (PST)
Message-ID: <627893d5-9976-8cfb-7e2c-edb55ad54254@redhat.com>
Date: Mon, 28 Feb 2022 11:18:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v2 03/14] vhost: Add Shadow VirtQueue call forwarding
 capabilities
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20220227134111.3254066-1-eperezma@redhat.com>
 <20220227134111.3254066-4-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220227134111.3254066-4-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, Eli Cohen <eli@mellanox.com>,
 Eric Blake <eblake@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Fangyi \(Eric\)" <eric.fangyi@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, yebiaoxiang@huawei.com,
 Liuxiangdong <liuxiangdong5@huawei.com>, Laurent Vivier <lvivier@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gautam Dawar <gdawar@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Lingshan <lingshan.zhu@intel.com>
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

CuWcqCAyMDIyLzIvMjcg5LiL5Y2IOTo0MSwgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IFRoaXMg
d2lsbCBtYWtlIHFlbXUgYXdhcmUgb2YgdGhlIGRldmljZSB1c2VkIGJ1ZmZlcnMsIGFsbG93aW5n
IGl0IHRvCj4gd3JpdGUgdGhlIGd1ZXN0IG1lbW9yeSB3aXRoIGl0cyBjb250ZW50cyBpZiBuZWVk
ZWQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNv
bT4KPiAtLS0KPiAgIGh3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmggfCAgNCArKysr
Cj4gICBody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5jIHwgMzQgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrCj4gICBody92aXJ0aW8vdmhvc3QtdmRwYS5jICAgICAgICAgICAg
IHwgMzEgKysrKysrKysrKysrKysrKysrKysrKysrKy0tCj4gICAzIGZpbGVzIGNoYW5nZWQsIDY3
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlv
L3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuaCBiL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1
ZXVlLmgKPiBpbmRleCAxY2JjODdkNWQ4Li4xZDRjMTYwZDBhIDEwMDY0NAo+IC0tLSBhL2h3L3Zp
cnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmgKPiArKysgYi9ody92aXJ0aW8vdmhvc3Qtc2hh
ZG93LXZpcnRxdWV1ZS5oCj4gQEAgLTI4LDkgKzI4LDEzIEBAIHR5cGVkZWYgc3RydWN0IFZob3N0
U2hhZG93VmlydHF1ZXVlIHsKPiAgICAgICAgKiBTbyBzaGFkb3cgdmlydHF1ZXVlIG11c3Qgbm90
IGNsZWFuIGl0LCBvciB3ZSB3b3VsZCBsb3NlIFZpcnRRdWV1ZSBvbmUuCj4gICAgICAgICovCj4g
ICAgICAgRXZlbnROb3RpZmllciBzdnFfa2ljazsKPiArCj4gKyAgICAvKiBHdWVzdCdzIGNhbGwg
bm90aWZpZXIsIHdoZXJlIHRoZSBTVlEgY2FsbHMgZ3Vlc3QuICovCj4gKyAgICBFdmVudE5vdGlm
aWVyIHN2cV9jYWxsOwo+ICAgfSBWaG9zdFNoYWRvd1ZpcnRxdWV1ZTsKPiAgIAo+ICAgdm9pZCB2
aG9zdF9zdnFfc2V0X3N2cV9raWNrX2ZkKFZob3N0U2hhZG93VmlydHF1ZXVlICpzdnEsIGludCBz
dnFfa2lja19mZCk7Cj4gK3ZvaWQgdmhvc3Rfc3ZxX3NldF9ndWVzdF9jYWxsX25vdGlmaWVyKFZo
b3N0U2hhZG93VmlydHF1ZXVlICpzdnEsIGludCBjYWxsX2ZkKTsKPiAgIAo+ICAgdm9pZCB2aG9z
dF9zdnFfc3RvcChWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqc3ZxKTsKPiAgIAo+IGRpZmYgLS1naXQg
YS9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5jIGIvaHcvdmlydGlvL3Zob3N0LXNo
YWRvdy12aXJ0cXVldWUuYwo+IGluZGV4IGE1ZDA2NTlmODYuLjU0YzcwMWExOTYgMTAwNjQ0Cj4g
LS0tIGEvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuYwo+ICsrKyBiL2h3L3ZpcnRp
by92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMKPiBAQCAtMjMsNiArMjMsMzggQEAgc3RhdGljIHZv
aWQgdmhvc3RfaGFuZGxlX2d1ZXN0X2tpY2soRXZlbnROb3RpZmllciAqbikKPiAgICAgICBldmVu
dF9ub3RpZmllcl9zZXQoJnN2cS0+aGRldl9raWNrKTsKPiAgIH0KPiAgIAo+ICsvKiBGb3J3YXJk
IHZob3N0IG5vdGlmaWNhdGlvbnMgKi8KPiArc3RhdGljIHZvaWQgdmhvc3Rfc3ZxX2hhbmRsZV9j
YWxsKEV2ZW50Tm90aWZpZXIgKm4pCj4gK3sKPiArICAgIFZob3N0U2hhZG93VmlydHF1ZXVlICpz
dnEgPSBjb250YWluZXJfb2YobiwgVmhvc3RTaGFkb3dWaXJ0cXVldWUsCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGhkZXZfY2FsbCk7Cj4gKyAgICBldmVu
dF9ub3RpZmllcl90ZXN0X2FuZF9jbGVhcihuKTsKPiArICAgIGV2ZW50X25vdGlmaWVyX3NldCgm
c3ZxLT5zdnFfY2FsbCk7Cj4gK30KPiArCj4gKy8qKgo+ICsgKiBTZXQgdGhlIGNhbGwgbm90aWZp
ZXIgZm9yIHRoZSBTVlEgdG8gY2FsbCB0aGUgZ3Vlc3QKPiArICoKPiArICogQHN2cSBTaGFkb3cg
dmlydHF1ZXVlCj4gKyAqIEBjYWxsX2ZkIGNhbGwgbm90aWZpZXIKPiArICoKPiArICogQ2FsbGVk
IG9uIEJRTCBjb250ZXh0Lgo+ICsgKi8KPiArdm9pZCB2aG9zdF9zdnFfc2V0X2d1ZXN0X2NhbGxf
bm90aWZpZXIoVmhvc3RTaGFkb3dWaXJ0cXVldWUgKnN2cSwgaW50IGNhbGxfZmQpCgoKSSB0aGlu
ayB3ZSBuZWVkIHRvIGhhdmUgY29uc2lzdGVudCBuYW1pbmcgZm9yIGJvdGgga2ljayBhbmQgY2Fs
bC4gTm90ZSAKdGhhdCBpbiBwYXRjaCAyIHdlIGhhZAoKdmhvc3Rfc3ZxX3NldF9zdnFfa2lja19m
ZAoKTWF5YmUgaXQncyBiZXR0ZXIgdG8gdXNlIHZob3N0X3N2cV9zZXRfZ3Vlc3RfY2FsbF9mZCgp
IGhlcmUuCgoKPiArewo+ICsgICAgaWYgKGNhbGxfZmQgPT0gVkhPU1RfRklMRV9VTkJJTkQpIHsK
PiArICAgICAgICAvKgo+ICsgICAgICAgICAqIEZhaWwgZXZlbnRfbm90aWZpZXJfc2V0IGlmIGNh
bGxlZCBoYW5kbGluZyBkZXZpY2UgY2FsbC4KPiArICAgICAgICAgKgo+ICsgICAgICAgICAqIFNW
USBzdGlsbCBuZWVkcyBkZXZpY2Ugbm90aWZpY2F0aW9ucywgc2luY2UgaXQgbmVlZHMgdG8ga2Vl
cAo+ICsgICAgICAgICAqIGZvcndhcmRpbmcgdXNlZCBidWZmZXJzIGV2ZW4gd2l0aCB0aGUgdW5i
aW5kLgo+ICsgICAgICAgICAqLwo+ICsgICAgICAgIG1lbXNldCgmc3ZxLT5zdnFfY2FsbCwgMCwg
c2l6ZW9mKHN2cS0+c3ZxX2NhbGwpKTsKCgpJIG1heSBtaXNzIHNvbWV0aGluZyBidXQgc2hvdWxk
bid0IHdlIHN0b3AgcG9sbGluZyBzdnFfY2FsbCBoZXJlIGxpa2UKCmV2ZW50X25vdGlmaWVyX3Nl
dF9oYW5kbGUoJnN2cS0+c3ZxX2NhbGwsIGZhbHNlKTsKCj8KClRoYW5rcwoKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
