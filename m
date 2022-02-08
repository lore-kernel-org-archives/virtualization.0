Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A6AC433F5
	for <virtualization@archiver.kernel.org>; Tue,  8 Feb 2022 08:20:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 64746400D1;
	Tue,  8 Feb 2022 08:20:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3nmpHuozO15N; Tue,  8 Feb 2022 08:20:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CB029404F9;
	Tue,  8 Feb 2022 08:20:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8757DC001A;
	Tue,  8 Feb 2022 08:20:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FFE5C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 08:20:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3E2C160C2F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 08:20:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PpzlRvyYvBAY
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 08:20:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9AAD160C1E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 08:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644308412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EvHJf+2pzfovStVs+MZiZCf947haBubcOit7ajGSdfo=;
 b=QztkmezO2Fae9G5oXG76EU5uD6eJ26ZIuNH41cpuv0M6o8eBWd8y9b8ZrjwD9MCAMGvhla
 DltL6ITEoH7thXjcW3IRdEKMpyDn/qfWYY48xCeDIC1xbZPMUWlL7KLeAEOQGJ2BhBKh3H
 +HILvifpjLdgA0+fFqJoND/Em4P/0mE=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-467-FZdzEwXtNYyCPtz5GYbyDQ-1; Tue, 08 Feb 2022 03:20:09 -0500
X-MC-Unique: FZdzEwXtNYyCPtz5GYbyDQ-1
Received: by mail-pf1-f197.google.com with SMTP id
 t24-20020aa79398000000b004e025989ac7so346018pfe.18
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Feb 2022 00:20:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=EvHJf+2pzfovStVs+MZiZCf947haBubcOit7ajGSdfo=;
 b=NBeCTQSZCRuVW9OpVmpxPqJzIGfIlDzsypGvZJUAptkeN7nQVXG41qjoca/7Ohx3Fj
 j3VRQdJEh1ERpHkO83zomdNOjwN2tz4WYcv4O8GOTFfinwKPggRXF4t9nHVcA4NNu1G+
 iQxrdi8w/jyeBLlIpz8H9maYYqVwXYB8Vm0c5O24Qd3LnMAaHoPeNTkeLNu/qo1BPDtA
 vs0HWJKZFefwVOLWKdYkAd8RnBuH8mPM+iN9eqnhFI+QhudSLamLlv5t/wizVc+Qy4e2
 3KiKgvEwvJE5slb1jP6Tg1Vvd2KyQiZgQVvP/tHctTd8zP1TH6guA8UmEB6p7qBtEqu2
 wpKw==
X-Gm-Message-State: AOAM532Z749+ZikNOY9uoGx0BpZRFdWQZAJ49mEFMsE376QT03tiryUA
 hW7zgtDsabaN+ZseqVxzhEdkdoM0LOrlT5iwCcDM5Cchdle3fipQdd3QSweLeib/FsTx5A3CEic
 Wi0VX3DK8cXGFww1I9LAWtqg4BRd/DgxiZzGLQsAaQw==
X-Received: by 2002:aa7:9d9b:: with SMTP id f27mr3385566pfq.84.1644308408159; 
 Tue, 08 Feb 2022 00:20:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzVMEw3NTbVITKusdMFSzdE8bcRzr/AptfBE8JVpxlbacuCrC3xd44Hc+rj5P+ukq9peJgoqQ==
X-Received: by 2002:aa7:9d9b:: with SMTP id f27mr3385550pfq.84.1644308407944; 
 Tue, 08 Feb 2022 00:20:07 -0800 (PST)
Received: from [10.72.13.12] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id p1sm15934541pfh.98.2022.02.08.00.19.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Feb 2022 00:20:07 -0800 (PST)
Message-ID: <29c05c6b-3ecb-73c4-81d2-eae07c3477a3@redhat.com>
Date: Tue, 8 Feb 2022 16:19:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH 23/31] vdpa: Add custom IOTLB translations to SVQ
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-24-eperezma@redhat.com>
 <e3b9ee89-46e0-cdbe-1093-5f067d2176ac@redhat.com>
 <CAJaqyWe1zH8bfaoxTyz_RXH=0q+Yk9H7QyUffaRB1fCV9oVLZQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <CAJaqyWe1zH8bfaoxTyz_RXH=0q+Yk9H7QyUffaRB1fCV9oVLZQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Gautam Dawar <gdawar@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
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

CuWcqCAyMDIyLzIvMSDkuIrljYgzOjExLCBFdWdlbmlvIFBlcmV6IE1hcnRpbiDlhpnpgZM6Cj4+
PiArICAgICAgICAgICAgcmV0dXJuIGZhbHNlOwo+Pj4gKyAgICAgICAgfQo+Pj4gKwo+Pj4gKyAg
ICAgICAgLyoKPj4+ICsgICAgICAgICAqIE1hcC0+aW92YSBjaHVuayBzaXplIGlzIGlnbm9yZWQu
IFdoYXQgdG8gZG8gaWYgZGVzY3JpcHRvcgo+Pj4gKyAgICAgICAgICogKGFkZHIsIHNpemUpIGRv
ZXMgbm90IGZpdCBpcyBkZWxlZ2F0ZWQgdG8gdGhlIGRldmljZS4KPj4+ICsgICAgICAgICAqLwo+
PiBJIHRoaW5rIHdlIG5lZWQgYXQgbGVhc3QgY2hlY2sgdGhlIHNpemUgYW5kIGZhaWwgaWYgdGhl
IHNpemUgZG9lc24ndAo+PiBtYXRjaCBoZXJlLiBPciBpcyBpdCBwb3NzaWJsZSB0aGF0IHdlIGhh
dmUgYSBidWZmZXIgdGhhdCBtYXkgY3Jvc3MgdHdvCj4+IG1lbW9yeSByZWdpb25zPwo+Pgo+IEl0
IHNob3VsZCBiZSBpbXBvc3NpYmxlLCBzaW5jZSBib3RoIGlvdmFfdHJlZSBhbmQgVmlydFF1ZXVl
IHNob3VsZCBiZQo+IGluIHN5bmMgcmVnYXJkaW5nIHRoZSBtZW1vcnkgcmVnaW9ucyB1cGRhdGVz
LiBJZiBhIFZpcnRRdWV1ZSBidWZmZXIKPiBjcm9zc2VzIG1hbnkgbWVtb3J5IHJlZ2lvbnMsIGlv
dmVjIGhhcyBtb3JlIGVudHJpZXMuCj4KPiBJIGNhbiBhZGQgYSByZXR1cm4gZmFsc2UsIGJ1dCBJ
J20gbm90IGFibGUgdG8gdHJpZ2dlciB0aGF0IHNpdHVhdGlvbgo+IGV2ZW4gd2l0aCBhIG1hbGZv
cm1lZCBkcml2ZXIuCj4KCk9rLCBidXQgaXQgd29uJ3QgaGFybSB0byBhZGQgYSB3YXJuIGhlcmUu
CgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
