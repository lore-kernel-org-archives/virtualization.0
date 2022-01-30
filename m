Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACAEC433EF
	for <virtualization@archiver.kernel.org>; Sun, 30 Jan 2022 06:47:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D597760B6E;
	Sun, 30 Jan 2022 06:47:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pTwy6p1K8oC9; Sun, 30 Jan 2022 06:47:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8DC3F60B5F;
	Sun, 30 Jan 2022 06:47:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 472D1C001A;
	Sun, 30 Jan 2022 06:47:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6CEC9C000B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Jan 2022 06:47:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 46CFD82BC0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Jan 2022 06:47:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jQX4UVAq9cKY
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Jan 2022 06:47:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 859F981B01
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Jan 2022 06:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643525232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jOYyKgOH8RgV9ghW6d3htexHq30T842ik8y10Dn6PXU=;
 b=QAB+I2NqO0IVVCPZkwEfVTKR5ewIIRkiczaR1HAleKarZtj1h2/V1CFtg+urvN6Qk/rApJ
 s4h/JcgVXbYMfvUJp9VnBRfO/7RP3HiH1o/w4f58xf92o46e/J2zRbdta3kmb9TfP4FsNS
 b7wU6qvckNTZ7rAOy0xIe2wM2kQhkgM=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-6JYD6DhbOVer2K1vpw7M9Q-1; Sun, 30 Jan 2022 01:47:10 -0500
X-MC-Unique: 6JYD6DhbOVer2K1vpw7M9Q-1
Received: by mail-pf1-f198.google.com with SMTP id
 z37-20020a056a001da500b004c74e3fd644so5597201pfw.1
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jan 2022 22:47:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=jOYyKgOH8RgV9ghW6d3htexHq30T842ik8y10Dn6PXU=;
 b=aBTUwOBeHcqNlf0jGltI3AQjRrAuwOTwPLoI4i1UgfjTgyydLn6q6DMyyO2sl/rl30
 hGXUQMKGWChzfixShuYO6wQvH0A0Aq+7TdHvRYplZ+0EuH1eLG/selzDgu59RMa3MMpF
 c72ksI+e8B01WCZD7JEykzKoAp3Uq9Jp54757YiBpuTrwLoJg4bosJQ88cWIpya3h4Xg
 94SDYYShdXM9P68C+CftC3+DTz4D6BXM/0urZJE4PJzxp5fRzoPHh0eA8N5e85572p/m
 Lcz0XNBTt9DdNbdfzj3PC8R83tmjo0PWMiedzXGEU8+vBBearsGkyMoVUIIHzpLPno9A
 Hr2g==
X-Gm-Message-State: AOAM531+FWBfPN8OgY0I7Ped9L4iMgCFOYgIabIxBgc4DQLnDjQwOMiu
 K6REXFQISLOrEM+faC2Tpqgp2YCXNBKtOo8zdL3cRnkIVzKOr5F3ed5lGp30fhD3BkybgH7sPVX
 eJReUw5qtaBbr6tl6lfdi6vxBXqQ620a5mWf5HGozRg==
X-Received: by 2002:a17:903:2310:: with SMTP id
 d16mr15915292plh.20.1643525229497; 
 Sat, 29 Jan 2022 22:47:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyvkJnGJTlkesocFe2yOrHY63ccYBcB9uAQjGdHa8f4+hZV1VOE9H2vT7fPuwB9oTwWXZ0QlA==
X-Received: by 2002:a17:903:2310:: with SMTP id
 d16mr15915263plh.20.1643525229246; 
 Sat, 29 Jan 2022 22:47:09 -0800 (PST)
Received: from [10.72.12.243] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id g1sm7859070pfu.32.2022.01.29.22.47.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Jan 2022 22:47:08 -0800 (PST)
Message-ID: <62e877ca-51d7-da85-13c9-d469a85f33c9@redhat.com>
Date: Sun, 30 Jan 2022 14:46:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH 18/31] vhost: Shadow virtqueue buffers forwarding
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-19-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220121202733.404989-19-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Gautam Dawar <gdawar@xilinx.com>,
 virtualization@lists.linux-foundation.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 Eric Blake <eblake@redhat.com>
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

CuWcqCAyMDIyLzEvMjIg5LiK5Y2INDoyNywgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IEBAIC0y
NzIsNiArNTkwLDI4IEBAIHZvaWQgdmhvc3Rfc3ZxX3NldF9zdnFfa2lja19mZChWaG9zdFNoYWRv
d1ZpcnRxdWV1ZSAqc3ZxLCBpbnQgc3ZxX2tpY2tfZmQpCj4gICB2b2lkIHZob3N0X3N2cV9zdG9w
KFZob3N0U2hhZG93VmlydHF1ZXVlICpzdnEpCj4gICB7Cj4gICAgICAgZXZlbnRfbm90aWZpZXJf
c2V0X2hhbmRsZXIoJnN2cS0+c3ZxX2tpY2ssIE5VTEwpOwo+ICsgICAgZ19hdXRvZnJlZSBWaXJ0
UXVldWVFbGVtZW50ICpuZXh0X2F2YWlsX2VsZW0gPSBOVUxMOwo+ICsKPiArICAgIGlmICghc3Zx
LT52cSkgewo+ICsgICAgICAgIHJldHVybjsKPiArICAgIH0KPiArCj4gKyAgICAvKiBTZW5kIGFs
bCBwZW5kaW5nIHVzZWQgZGVzY3JpcHRvcnMgdG8gZ3Vlc3QgKi8KPiArICAgIHZob3N0X3N2cV9m
bHVzaChzdnEsIGZhbHNlKTsKCgpEbyB3ZSBuZWVkIHRvIHdhaXQgZm9yIGFsbCB0aGUgcGVuZGlu
ZyBkZXNjcmlwdG9ycyB0byBiZSBjb21wbGV0ZWQgaGVyZT8KClRoYW5rcwoKCj4gKwo+ICsgICAg
Zm9yICh1bnNpZ25lZCBpID0gMDsgaSA8IHN2cS0+dnJpbmcubnVtOyArK2kpIHsKPiArICAgICAg
ICBnX2F1dG9mcmVlIFZpcnRRdWV1ZUVsZW1lbnQgKmVsZW0gPSBOVUxMOwo+ICsgICAgICAgIGVs
ZW0gPSBnX3N0ZWFsX3BvaW50ZXIoJnN2cS0+cmluZ19pZF9tYXBzW2ldKTsKPiArICAgICAgICBp
ZiAoZWxlbSkgewo+ICsgICAgICAgICAgICB2aXJ0cXVldWVfZGV0YWNoX2VsZW1lbnQoc3ZxLT52
cSwgZWxlbSwgZWxlbS0+bGVuKTsKPiArICAgICAgICB9Cj4gKyAgICB9Cj4gKwo+ICsgICAgbmV4
dF9hdmFpbF9lbGVtID0gZ19zdGVhbF9wb2ludGVyKCZzdnEtPm5leHRfZ3Vlc3RfYXZhaWxfZWxl
bSk7Cj4gKyAgICBpZiAobmV4dF9hdmFpbF9lbGVtKSB7Cj4gKyAgICAgICAgdmlydHF1ZXVlX2Rl
dGFjaF9lbGVtZW50KHN2cS0+dnEsIG5leHRfYXZhaWxfZWxlbSwKPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgbmV4dF9hdmFpbF9lbGVtLT5sZW4pOwo+ICsgICAgfQo+ICAgfQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
