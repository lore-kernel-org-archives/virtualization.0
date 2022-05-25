Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B917C433F5
	for <virtualization@archiver.kernel.org>; Wed, 25 May 2022 02:51:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45E0381BC2;
	Wed, 25 May 2022 02:51:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T__BgvRcZpoi; Wed, 25 May 2022 02:51:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E282981B98;
	Wed, 25 May 2022 02:51:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9013C0032;
	Wed, 25 May 2022 02:51:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23D71C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 02:51:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0258541959
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 02:51:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7RE-hTj7rz9v
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 02:51:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A376341913
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 02:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653447078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Tsl43vKOyakBAOjeNueNb9Uu0rxAb3Y9S+ROwk9uac=;
 b=PxrpwnNMmca9THgj1LIGlBbMa9/SylzGtfPVuxlmItqJIDDGgl3Yy7u/BRdCHFVKKLidyj
 osDzLMBVSyid6HfvIJxKibi2jbBgjcWdOn+I36NoU+/98VrCRz3PHs9DhhkxmdlmhpY4wr
 0wSo8sjhZkIf54XXatQhSDupxxMUeis=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-178-CTSrzoJoOQi3yunw6xxN7g-1; Tue, 24 May 2022 22:51:16 -0400
X-MC-Unique: CTSrzoJoOQi3yunw6xxN7g-1
Received: by mail-lf1-f69.google.com with SMTP id
 w38-20020a0565120b2600b00477b08c1730so9994928lfu.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 19:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2Tsl43vKOyakBAOjeNueNb9Uu0rxAb3Y9S+ROwk9uac=;
 b=zYpgIXTEqXv1KwsROrzMnpXeBFbvv2euQ+PyYqRJXpBekJf6V4RhJJ0vpWz1wTpg3Z
 J/y6Gge37qOQaFbjlqkmmac2jMhbp1NzSPSgeTVjh9hjBBZX+Cb4Yf0pXAHBC+3MoUTk
 lmJP51xZ1sTAeosFufzexucobTzydC6vZTyhA4Gdxuo5kFiQX0bHugCHEBqDpka39KUs
 pftJtFskYy6Q50ED0eeAy8VH4VeLGpn39sg77sL3eaCdqhYsic5DX35cdxEKjy5zCX3w
 OmUAjThtajCFls3ZehwLgQHuvTFYXX/Z+1QlQO535CeKysNGpdH7pzU3q+PWG741oAgk
 8LBg==
X-Gm-Message-State: AOAM531QrZPuyS1PEFW7TzhNhD3kLgTrPTVixeM3BRsFEB74bKEF8Sb4
 nMjSA4bY9bR9SsDZXaR/HfaN7SrHCfpsUP4Fi6WvG4ArJfFkOwFaAJjQnqGMaMMFjRXdpDpn8fT
 sXGrlo7ZRL6Y1EJQf9mvTwHgGigx4vrrR+GrWYISdcn4d0ioZDkOxowDHig==
X-Received: by 2002:a05:6512:1588:b0:477:a556:4ab2 with SMTP id
 bp8-20020a056512158800b00477a5564ab2mr21566057lfb.376.1653447075322; 
 Tue, 24 May 2022 19:51:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtJSo05GNByny047zFBzRM80HBxjhYV4+wk4PnaZNHQVflRy1NntKSrmKYUijvKrR3IvcwS4VX7V20tGdl8fc=
X-Received: by 2002:a05:6512:1588:b0:477:a556:4ab2 with SMTP id
 bp8-20020a056512158800b00477a5564ab2mr21566038lfb.376.1653447075136; Tue, 24
 May 2022 19:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220524170610.2255608-1-eperezma@redhat.com>
 <20220524170610.2255608-4-eperezma@redhat.com>
In-Reply-To: <20220524170610.2255608-4-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 25 May 2022 10:51:04 +0800
Message-ID: <CACGkMEsZSTgsgYkg5HhpJ62pKFTr6mtiNwYJa8E+r4RMTRuU8A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] vhost-vdpa: uAPI to stop the device
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: tanuj.kamde@amd.com, kvm <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 Pablo Cascon Katchadourian <pabloc@xilinx.com>, Eli Cohen <elic@nvidia.com>,
 Zhang Min <zhang.min9@zte.com.cn>, Cindy Lu <lulu@redhat.com>, "Uminski,
 Piotr" <Piotr.Uminski@intel.com>,
 Martin Petrus Hubertus Habets <martinh@xilinx.com>,
 Xie Yongji <xieyongji@bytedance.com>, Dinan Gunawardena <dinang@xilinx.com>,
 habetsm.xilinx@gmail.com, Longpeng <longpeng2@huawei.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, Laurent Vivier <lvivier@redhat.com>,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 ecree.xilinx@gmail.com, Harpreet Singh Anand <hanand@xilinx.com>,
 Martin Porter <martinpo@xilinx.com>, "Dawar, Gautam" <gautam.dawar@amd.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Zhu Lingshan <lingshan.zhu@intel.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gV2VkLCBNYXkgMjUsIDIwMjIgYXQgMTowNiBBTSBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBUaGUgaW9jdGwgYWRkcyBzdXBwb3J0IGZvciBzdG9wIHRo
ZSBkZXZpY2UgZnJvbSB1c2Vyc3BhY2UuCj4KPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDDqXJl
eiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiAtLS0KPiAgZHJpdmVycy92aG9zdC92ZHBhLmMgICAg
ICAgfCAxOCArKysrKysrKysrKysrKysrKysKPiAgaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0Lmgg
fCAgMyArKysKPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+IGluZGV4
IDMyNzEzZGI1ODMxZC4uYTVkMzNiYWQ5MmY5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3Qv
dmRwYS5jCj4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiBAQCAtNDc4LDYgKzQ3OCwyMSBA
QCBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX2dldF92cXNfY291bnQoc3RydWN0IHZob3N0X3ZkcGEg
KnYsIHUzMiBfX3VzZXIgKmFyZ3ApCj4gICAgICAgICByZXR1cm4gMDsKPiAgfQo+Cj4gK3N0YXRp
YyBsb25nIHZob3N0X3ZkcGFfc3RvcChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTMyIF9fdXNlciAq
YXJncCkKPiArewo+ICsgICAgICAgc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhID0gdi0+dmRwYTsK
PiArICAgICAgIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHZkcGEtPmNvbmZp
ZzsKPiArICAgICAgIGludCBzdG9wOwo+ICsKPiArICAgICAgIGlmICghb3BzLT5zdG9wKQo+ICsg
ICAgICAgICAgICAgICByZXR1cm4gLUVPUE5PVFNVUFA7Cj4gKwo+ICsgICAgICAgaWYgKGNvcHlf
ZnJvbV91c2VyKCZzdG9wLCBhcmdwLCBzaXplb2Yoc3RvcCkpKQo+ICsgICAgICAgICAgICAgICBy
ZXR1cm4gLUVGQVVMVDsKPiArCj4gKyAgICAgICByZXR1cm4gb3BzLT5zdG9wKHZkcGEsIHN0b3Ap
Owo+ICt9Cj4gKwo+ICBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3ZyaW5nX2lvY3RsKHN0cnVjdCB2
aG9zdF92ZHBhICp2LCB1bnNpZ25lZCBpbnQgY21kLAo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdm9pZCBfX3VzZXIgKmFyZ3ApCj4gIHsKPiBAQCAtNjUwLDYgKzY2NSw5IEBA
IHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfdW5sb2NrZWRfaW9jdGwoc3RydWN0IGZpbGUgKmZpbGVw
LAo+ICAgICAgICAgY2FzZSBWSE9TVF9WRFBBX0dFVF9WUVNfQ09VTlQ6Cj4gICAgICAgICAgICAg
ICAgIHIgPSB2aG9zdF92ZHBhX2dldF92cXNfY291bnQodiwgYXJncCk7Cj4gICAgICAgICAgICAg
ICAgIGJyZWFrOwo+ICsgICAgICAgY2FzZSBWSE9TVF9TVE9QOgo+ICsgICAgICAgICAgICAgICBy
ID0gdmhvc3RfdmRwYV9zdG9wKHYsIGFyZ3ApOwo+ICsgICAgICAgICAgICAgICBicmVhazsKPiAg
ICAgICAgIGRlZmF1bHQ6Cj4gICAgICAgICAgICAgICAgIHIgPSB2aG9zdF9kZXZfaW9jdGwoJnYt
PnZkZXYsIGNtZCwgYXJncCk7Cj4gICAgICAgICAgICAgICAgIGlmIChyID09IC1FTk9JT0NUTENN
RCkKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0LmggYi9pbmNsdWRlL3Vh
cGkvbGludXgvdmhvc3QuaAo+IGluZGV4IGNhYjY0NWQ0YTY0NS4uZTc1MjY5NjhhYjBjIDEwMDY0
NAo+IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC92aG9zdC5oCj4gKysrIGIvaW5jbHVkZS91YXBp
L2xpbnV4L3Zob3N0LmgKPiBAQCAtMTcxLDQgKzE3MSw3IEBACj4gICNkZWZpbmUgVkhPU1RfVkRQ
QV9TRVRfR1JPVVBfQVNJRCAgICAgIF9JT1coVkhPU1RfVklSVElPLCAweDdDLCBcCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZob3N0X3ZyaW5n
X3N0YXRlKQo+Cj4gKy8qIFN0b3Agb3IgcmVzdW1lIGEgZGV2aWNlIHNvIGl0IGRvZXMgbm90IHBy
b2Nlc3MgdmlydHF1ZXVlIHJlcXVlc3RzIGFueW1vcmUgKi8KPiArI2RlZmluZSBWSE9TVF9TVE9Q
ICAgICAgICAgICAgICAgICAgICAgX0lPVyhWSE9TVF9WSVJUSU8sIDB4N0QsIGludCkKPiArCgpV
bmxlc3Mgd2Uga25vdyBpdCdzIGEgdmhvc3QgZ2VuZXJhbCB1QVBJLCBsZXQncyB1c2UgVkhPU1Rf
VkRQQV9TVE9QIGhlcmUuCgpUaGFua3MKCj4gICNlbmRpZgo+IC0tCj4gMi4yNy4wCj4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
