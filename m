Return-Path: <SRS0=r7vL=NO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599A1C432BE
	for <virtualization@archiver.kernel.org>; Mon, 23 Aug 2021 06:28:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 030A46127B
	for <virtualization@archiver.kernel.org>; Mon, 23 Aug 2021 06:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 030A46127B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B2B0440202;
	Mon, 23 Aug 2021 06:28:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G1sgWwLhaoSn; Mon, 23 Aug 2021 06:28:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4CC80400D4;
	Mon, 23 Aug 2021 06:28:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13A09C001A;
	Mon, 23 Aug 2021 06:28:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E635DC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 06:28:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CCC8D40144
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 06:28:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AzrR-0TcLRdE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 06:28:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D52EA400FE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 06:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629700084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qEgW76/QbsdmzDpY6YbWFRp1GnxyCaBmFQdXxX32rA8=;
 b=FSh/6EoI5lhTCjtFBQWpzh4PTJwQiuFWgZmv5NynYwNJhaVDiHVJ4v+RZM522HcE8aREIk
 hSozSsvYcLvh++/30gqyc/GxhkXHVIOrF4crDQh6P3dhfcZxWA91pax0P66psgvkbd+WX0
 ilY/UOXImbrV108X7RfsXQhd8sVzPHA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-RK-1I7Q-Nf-X7nf7sYWPng-1; Mon, 23 Aug 2021 02:28:01 -0400
X-MC-Unique: RK-1I7Q-Nf-X7nf7sYWPng-1
Received: by mail-pl1-f200.google.com with SMTP id
 n1-20020a170902e54100b0012dbd2c897cso3845642plf.20
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Aug 2021 23:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=qEgW76/QbsdmzDpY6YbWFRp1GnxyCaBmFQdXxX32rA8=;
 b=AxKkOHO+XPhxgLD4/CvD0bFpargS3WQGExdsLkqlKo1QAmX5CTfO06+S00znP2THjg
 CWbewlP8lU888pwBLPQIsIOM71OnWqdaUdfqzog7SHuZduyuaYU/oeUjhYoUx+QoK+L3
 bA5Wy9XhbTNViqOWHuBaJlxbv/edFEH660OTRHIYVc6rBDctjfCuBEvXMBygnUeepfIJ
 bsezbnGZA8wYJej19XGuWUH7LuJAfcRGY2FhCi+PcLS/36mw+atiAoqzU+S71gp0P8tD
 jQrcZhntR2qqNr60KxRS7f5eYLQmWFVRq3RZFA8e0GlY9wZhGfDVsyo7Vtu2OWAPg53y
 wzZw==
X-Gm-Message-State: AOAM532LrSteR5ARQT5ZXsvr86Lzph028L2IdR5K50OqFczNIYaUENO0
 gNV8NyyZ6HRWzd+WLI6azOCIOQ7A3QvdGuaNn7ORx78xA8JqsLHjiQXasfqKk0tmlE7bhZ86PuX
 tc1cMpmAAM1OYS7CDADqpcRygcRUuP9wt+e3W49glWg==
X-Received: by 2002:a17:902:7d90:b0:134:d977:22de with SMTP id
 a16-20020a1709027d9000b00134d97722demr1865289plm.30.1629700080249; 
 Sun, 22 Aug 2021 23:28:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9Au0/duLZTHlJC0wzzpusIjoVy6rg0evHqzqvyikarIys4G/LFXCzlPnifIHGbSty2QhnOQ==
X-Received: by 2002:a17:902:7d90:b0:134:d977:22de with SMTP id
 a16-20020a1709027d9000b00134d97722demr1865251plm.30.1629700079950; 
 Sun, 22 Aug 2021 23:27:59 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j20sm2254119pgb.2.2021.08.22.23.27.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Aug 2021 23:27:59 -0700 (PDT)
Subject: Re: [PATCH v11 03/12] vdpa: Fix some coding style issues
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 hch@infradead.org, christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com,
 robin.murphy@arm.com
References: <20210818120642.165-1-xieyongji@bytedance.com>
 <20210818120642.165-4-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d0ca19ee-3318-df4f-a023-c72034bbb411@redhat.com>
Date: Mon, 23 Aug 2021 14:27:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818120642.165-4-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 songmuchun@bytedance.com, linux-fsdevel@vger.kernel.org
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvOC8xOCDPws7nODowNiwgWGllIFlvbmdqaSDQtLXAOgo+IEZpeCBzb21lIGNvZGUg
aW5kZW50IGlzc3VlcyBhbmQgZm9sbG93aW5nIGNoZWNrcGF0Y2ggd2FybmluZzoKPgo+IFdBUk5J
Tkc6IFByZWZlciAndW5zaWduZWQgaW50JyB0byBiYXJlIHVzZSBvZiAndW5zaWduZWQnCj4gMzcx
OiBGSUxFOiBpbmNsdWRlL2xpbnV4L3ZkcGEuaDozNzE6Cj4gK3N0YXRpYyBpbmxpbmUgdm9pZCB2
ZHBhX2dldF9jb25maWcoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBvZmZzZXQs
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4aWV5b25namlAYnl0ZWRhbmNlLmNvbT4K
CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAg
aW5jbHVkZS9saW51eC92ZHBhLmggfCAzNCArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0t
LS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0p
Cj4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92ZHBhLmggYi9pbmNsdWRlL2xpbnV4L3Zk
cGEuaAo+IGluZGV4IDk1NGIzNDBmNmMyZi4uOGE2NDVmOGY0NDc2IDEwMDY0NAo+IC0tLSBhL2lu
Y2x1ZGUvbGludXgvdmRwYS5oCj4gKysrIGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPiBAQCAtNDMs
MTcgKzQzLDE3IEBAIHN0cnVjdCB2ZHBhX3ZxX3N0YXRlX3NwbGl0IHsKPiAgICAqIEBsYXN0X3Vz
ZWRfaWR4OiB1c2VkIGluZGV4Cj4gICAgKi8KPiAgIHN0cnVjdCB2ZHBhX3ZxX3N0YXRlX3BhY2tl
ZCB7Cj4gLSAgICAgICAgdTE2CWxhc3RfYXZhaWxfY291bnRlcjoxOwo+IC0gICAgICAgIHUxNgls
YXN0X2F2YWlsX2lkeDoxNTsKPiAtICAgICAgICB1MTYJbGFzdF91c2VkX2NvdW50ZXI6MTsKPiAt
ICAgICAgICB1MTYJbGFzdF91c2VkX2lkeDoxNTsKPiArCXUxNglsYXN0X2F2YWlsX2NvdW50ZXI6
MTsKPiArCXUxNglsYXN0X2F2YWlsX2lkeDoxNTsKPiArCXUxNglsYXN0X3VzZWRfY291bnRlcjox
Owo+ICsJdTE2CWxhc3RfdXNlZF9pZHg6MTU7Cj4gICB9Owo+ICAgCj4gICBzdHJ1Y3QgdmRwYV92
cV9zdGF0ZSB7Cj4gLSAgICAgdW5pb24gewo+IC0gICAgICAgICAgc3RydWN0IHZkcGFfdnFfc3Rh
dGVfc3BsaXQgc3BsaXQ7Cj4gLSAgICAgICAgICBzdHJ1Y3QgdmRwYV92cV9zdGF0ZV9wYWNrZWQg
cGFja2VkOwo+IC0gICAgIH07Cj4gKwl1bmlvbiB7Cj4gKwkJc3RydWN0IHZkcGFfdnFfc3RhdGVf
c3BsaXQgc3BsaXQ7Cj4gKwkJc3RydWN0IHZkcGFfdnFfc3RhdGVfcGFja2VkIHBhY2tlZDsKPiAr
CX07Cj4gICB9Owo+ICAgCj4gICBzdHJ1Y3QgdmRwYV9tZ210X2RldjsKPiBAQCAtMTMxLDcgKzEz
MSw3IEBAIHN0cnVjdCB2ZHBhX2lvdmFfcmFuZ2Ugewo+ICAgICoJCQkJQHZkZXY6IHZkcGEgZGV2
aWNlCj4gICAgKgkJCQlAaWR4OiB2aXJ0cXVldWUgaW5kZXgKPiAgICAqCQkJCUBzdGF0ZTogcG9p
bnRlciB0byByZXR1cm5lZCBzdGF0ZSAobGFzdF9hdmFpbF9pZHgpCj4gLSAqIEBnZXRfdnFfbm90
aWZpY2F0aW9uOiAJR2V0IHRoZSBub3RpZmljYXRpb24gYXJlYSBmb3IgYSB2aXJ0cXVldWUKPiAr
ICogQGdldF92cV9ub3RpZmljYXRpb246CUdldCB0aGUgbm90aWZpY2F0aW9uIGFyZWEgZm9yIGEg
dmlydHF1ZXVlCj4gICAgKgkJCQlAdmRldjogdmRwYSBkZXZpY2UKPiAgICAqCQkJCUBpZHg6IHZp
cnRxdWV1ZSBpbmRleAo+ICAgICoJCQkJUmV0dXJucyB0aGUgbm90aWZjYXRpb24gYXJlYQo+IEBA
IC0zNTMsMjUgKzM1MywyNSBAQCBzdGF0aWMgaW5saW5lIHN0cnVjdCBkZXZpY2UgKnZkcGFfZ2V0
X2RtYV9kZXYoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2KQo+ICAgCj4gICBzdGF0aWMgaW5saW5l
IHZvaWQgdmRwYV9yZXNldChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpCj4gICB7Cj4gLSAgICAg
ICAgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRldi0+Y29uZmlnOwo+ICsJ
Y29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRldi0+Y29uZmlnOwo+ICAgCj4g
ICAJdmRldi0+ZmVhdHVyZXNfdmFsaWQgPSBmYWxzZTsKPiAtICAgICAgICBvcHMtPnNldF9zdGF0
dXModmRldiwgMCk7Cj4gKwlvcHMtPnNldF9zdGF0dXModmRldiwgMCk7Cj4gICB9Cj4gICAKPiAg
IHN0YXRpYyBpbmxpbmUgaW50IHZkcGFfc2V0X2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAq
dmRldiwgdTY0IGZlYXR1cmVzKQo+ICAgewo+IC0gICAgICAgIGNvbnN0IHN0cnVjdCB2ZHBhX2Nv
bmZpZ19vcHMgKm9wcyA9IHZkZXYtPmNvbmZpZzsKPiArCWNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZp
Z19vcHMgKm9wcyA9IHZkZXYtPmNvbmZpZzsKPiAgIAo+ICAgCXZkZXYtPmZlYXR1cmVzX3ZhbGlk
ID0gdHJ1ZTsKPiAtICAgICAgICByZXR1cm4gb3BzLT5zZXRfZmVhdHVyZXModmRldiwgZmVhdHVy
ZXMpOwo+ICsJcmV0dXJuIG9wcy0+c2V0X2ZlYXR1cmVzKHZkZXYsIGZlYXR1cmVzKTsKPiAgIH0K
PiAgIAo+IC0KPiAtc3RhdGljIGlubGluZSB2b2lkIHZkcGFfZ2V0X2NvbmZpZyhzdHJ1Y3QgdmRw
YV9kZXZpY2UgKnZkZXYsIHVuc2lnbmVkIG9mZnNldCwKPiAtCQkJCSAgIHZvaWQgKmJ1ZiwgdW5z
aWduZWQgaW50IGxlbikKPiArc3RhdGljIGlubGluZSB2b2lkIHZkcGFfZ2V0X2NvbmZpZyhzdHJ1
Y3QgdmRwYV9kZXZpY2UgKnZkZXYsCj4gKwkJCQkgICB1bnNpZ25lZCBpbnQgb2Zmc2V0LCB2b2lk
ICpidWYsCj4gKwkJCQkgICB1bnNpZ25lZCBpbnQgbGVuKQo+ICAgewo+IC0gICAgICAgIGNvbnN0
IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHZkZXYtPmNvbmZpZzsKPiArCWNvbnN0IHN0
cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHZkZXYtPmNvbmZpZzsKPiAgIAo+ICAgCS8qCj4g
ICAJICogQ29uZmlnIGFjY2Vzc2VzIGFyZW4ndCBzdXBwb3NlZCB0byB0cmlnZ2VyIGJlZm9yZSBm
ZWF0dXJlcyBhcmUgc2V0LgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
