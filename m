Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85C1CCA473
	for <virtualization@archiver.kernel.org>; Thu,  2 Jun 2022 02:08:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7ED8441761;
	Thu,  2 Jun 2022 02:08:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MX1xTxSN1ZBL; Thu,  2 Jun 2022 02:08:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E12CB415FD;
	Thu,  2 Jun 2022 02:08:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADAE8C0039;
	Thu,  2 Jun 2022 02:08:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B46BC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 02:08:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 438CF40A04
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 02:08:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7YbLrVFSV_jJ
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 02:08:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 84278400D0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 02:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654135712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1XyspsvoSb3NtHUHpb5oeCcY1zxXsm6k93GfeTwfJEU=;
 b=XqEDv29G5xOqPp2sbY/kpkewKK905vzIQzwnE3khPREyXiRgcw4GN+LxCZX6hUCneuPJuv
 eFxghgvst3RLIUDkLWmbTaeAhU5OuN4wcBaXV9POdoXAwo5UmB21xDON1ykr5IdjPXsNp1
 yLR3+86CZvUXqkZFlkcJDwSOH7ows98=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-75-u5tYvj_FP62qi1mICTdK5w-1; Wed, 01 Jun 2022 22:08:31 -0400
X-MC-Unique: u5tYvj_FP62qi1mICTdK5w-1
Received: by mail-pl1-f198.google.com with SMTP id
 s10-20020a170902a50a00b00162359521c9so1893285plq.23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 01 Jun 2022 19:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=1XyspsvoSb3NtHUHpb5oeCcY1zxXsm6k93GfeTwfJEU=;
 b=uufuiNgVNXsuOdgq+U6sXLhQWGoOT5fFDwUiyKZbvcReJr4xbpHHOWau3qkUrLmXjM
 xHDPBAu46R1VvjXnhg6wSdrRO4YKYlFF5kgWodtRn7RWdAZDVyjELiqtVtVSzB9ZEaUS
 hGTrUC0nCLaVvhucYeysnGUh6vXS1A73/cAFtoye1xe2RWzgvud3UBUKeqMX1xJrWXNv
 r9QHYsOgvpSbk61Ar7sMwtJHmFltv5YRCmi3dWqvUBxHslw8FlGRDb3ROc5ff2gW0FPJ
 KtEvhE8Upiy0z0yhLH3YZa2zNzd1z5omN/GLJtoHr3ZId+r2uR1iK34h45DYtAIIlOAQ
 6jxg==
X-Gm-Message-State: AOAM532/muLiRo9IMbQegPUFlh3eMTyU7m4ymFj00ETR4ugAAQzs0i2D
 A9+SWH9+w5H2zRI8qB2CWPkAjOnjXOMPLYtOATZ9qZyo02gDOSGd5EXk4gUB0KI4ZqQR1DoUfgE
 JYvLE9YrmfKW2TfDzQH8wdDU1bb73F8UTespm6PGpog==
X-Received: by 2002:a17:902:9a92:b0:161:4e50:3b80 with SMTP id
 w18-20020a1709029a9200b001614e503b80mr2320133plp.149.1654135710274; 
 Wed, 01 Jun 2022 19:08:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2dbDxajoyEelOLKZRvwOLRq9wik2EaSJcf1SAoEJF9TtruJ7MBPk0VF5bPP8b9BefjZkjUw==
X-Received: by 2002:a17:902:9a92:b0:161:4e50:3b80 with SMTP id
 w18-20020a1709029a9200b001614e503b80mr2320090plp.149.1654135709878; 
 Wed, 01 Jun 2022 19:08:29 -0700 (PDT)
Received: from [10.72.13.239] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 l17-20020a170902e2d100b0015e9f45c1f4sm2167309plc.186.2022.06.01.19.08.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jun 2022 19:08:29 -0700 (PDT)
Message-ID: <6a0b9961-40c6-9b22-2b79-608633f78814@redhat.com>
Date: Thu, 2 Jun 2022 10:08:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v4 0/4] Implement vdpasim stop operation
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20220526124338.36247-1-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220526124338.36247-1-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: tanuj.kamde@amd.com, Wu Zongyong <wuzongyong@linux.alibaba.com>,
 Si-Wei Liu <si-wei.liu@oracle.com>, pabloc@xilinx.com,
 Eli Cohen <elic@nvidia.com>, Zhang Min <zhang.min9@zte.com.cn>,
 lulu@redhat.com, Piotr.Uminski@intel.com, martinh@xilinx.com,
 Xie Yongji <xieyongji@bytedance.com>, dinang@xilinx.com,
 habetsm.xilinx@gmail.com, Longpeng <longpeng2@huawei.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, lvivier@redhat.com,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, gautam.dawar@amd.com,
 ecree.xilinx@gmail.com, hanand@xilinx.com, martinpo@xilinx.com,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzUvMjYgMjA6NDMsIEV1Z2VuaW8gUMOpcmV6IOWGmemBkzoKPiBJbXBsZW1lbnQg
c3RvcCBvcGVyYXRpb24gZm9yIHZkcGFfc2ltIGRldmljZXMsIHNvIHZob3N0LXZkcGEgd2lsbCBv
ZmZlcgo+IHRoYXQgYmFja2VuZCBmZWF0dXJlIGFuZCB1c2Vyc3BhY2UgY2FuIGVmZmVjdGl2ZWx5
IHN0b3AgdGhlIGRldmljZS4KPgo+IFRoaXMgaXMgYSBtdXN0IGJlZm9yZSBnZXQgdmlydHF1ZXVl
IGluZGV4ZXMgKGJhc2UpIGZvciBsaXZlIG1pZ3JhdGlvbiwKPiBzaW5jZSB0aGUgZGV2aWNlIGNv
dWxkIG1vZGlmeSB0aGVtIGFmdGVyIHVzZXJsYW5kIGdldHMgdGhlbS4gVGhlcmUgYXJlCj4gaW5k
aXZpZHVhbCB3YXlzIHRvIHBlcmZvcm0gdGhhdCBhY3Rpb24gZm9yIHNvbWUgZGV2aWNlcwo+IChW
SE9TVF9ORVRfU0VUX0JBQ0tFTkQsIFZIT1NUX1ZTT0NLX1NFVF9SVU5OSU5HLCAuLi4pIGJ1dCB0
aGVyZSB3YXMgbm8KPiB3YXkgdG8gcGVyZm9ybSBpdCBmb3IgYW55IHZob3N0IGRldmljZSAoYW5k
LCBpbiBwYXJ0aWN1bGFyLCB2aG9zdC12ZHBhKS4KPgo+IEFmdGVyIHRoZSByZXR1cm4gb2YgaW9j
dGwgd2l0aCBzdG9wICE9IDAsIHRoZSBkZXZpY2UgTVVTVCBmaW5pc2ggYW55Cj4gcGVuZGluZyBv
cGVyYXRpb25zIGxpa2UgaW4gZmxpZ2h0IHJlcXVlc3RzLiBJdCBtdXN0IGFsc28gcHJlc2VydmUg
YWxsCj4gdGhlIG5lY2Vzc2FyeSBzdGF0ZSAodGhlIHZpcnRxdWV1ZSB2cmluZyBiYXNlIHBsdXMg
dGhlIHBvc3NpYmxlIGRldmljZQo+IHNwZWNpZmljIHN0YXRlcykgdGhhdCBpcyByZXF1aXJlZCBm
b3IgcmVzdG9yaW5nIGluIHRoZSBmdXR1cmUuIFRoZQo+IGRldmljZSBtdXN0IG5vdCBjaGFuZ2Ug
aXRzIGNvbmZpZ3VyYXRpb24gYWZ0ZXIgdGhhdCBwb2ludC4KCgpJIHRoaW5rIHdlIHByb2JhYmx5
IG5lZWQgbW9yZSBhY2N1cmF0ZSBkZWZpbml0aW9uIG9uIHRoZSBzdGF0ZSBhcyBQYXJhdiAKc3Vn
Z2VzdGVkLgoKQmVzaWRlcyB0aGlzLCB3ZSBzaG91bGQgYWxzbyBjbGFyaWZ5IHdoZW4gc3RvcCBp
cyBhbGxvd2VkLiBFLmcgc2hvdWxkIHdlIAphbGxvdyBzZXR0aW5nIHN0b3Agd2l0aG91dCBEUklW
RVJfT0s/CgpUaGFua3MKCgo+Cj4gQWZ0ZXIgdGhlIHJldHVybiBvZiBpb2N0bCB3aXRoIHN0b3Ag
PT0gMCwgdGhlIGRldmljZSBjYW4gY29udGludWUKPiBwcm9jZXNzaW5nIGJ1ZmZlcnMgYXMgbG9u
ZyBhcyB0eXBpY2FsIGNvbmRpdGlvbnMgYXJlIG1ldCAodnEgaXMgZW5hYmxlZCwKPiBEUklWRVJf
T0sgc3RhdHVzIGJpdCBpcyBlbmFibGVkLCBldGMpLgo+Cj4gSW4gdGhlIGZ1dHVyZSwgd2Ugd2ls
bCBwcm92aWRlIGZlYXR1cmVzIHNpbWlsYXIgdG8gVkhPU1RfVVNFUl9HRVRfSU5GTElHSFRfRkQK
PiBzbyB0aGUgZGV2aWNlIGNhbiBzYXZlIHBlbmRpbmcgb3BlcmF0aW9ucy4KPgo+IENvbW1lbnRz
IGFyZSB3ZWxjb21lLgo+Cj4gdjQ6Cj4gKiBSZXBsYWNlIFZIT1NUX1NUT1AgdG8gVkhPU1RfVkRQ
QV9TVE9QIGluIHZob3N0IGlvY3RsIHN3aXRjaCBjYXNlIHRvby4KPgo+IHYzOgo+ICogcy9WSE9T
VF9TVE9QL1ZIT1NUX1ZEUEFfU1RPUC8KPiAqIEFkZCBkb2N1bWVudGF0aW9uIGFuZCByZXF1aXJl
bWVudHMgb2YgdGhlIGlvY3RsIGFib3ZlIGl0cyBkZWZpbml0aW9uLgo+Cj4gdjI6Cj4gKiBSZXBs
YWNlIHJhdyBfRl9TVE9QIHdpdGggQklUX1VMTChfRl9TVE9QKS4KPiAqIEZpeCBvYnRhaW5pbmcg
b2Ygc3RvcCBpb2N0bCBhcmcgKGl0IHdhcyBub3Qgb2J0YWluZWQgYnV0IHdyaXR0ZW4pLgo+ICog
QWRkIHN0b3AgdG8gdmRwYV9zaW1fYmxrLgo+Cj4gRXVnZW5pbyBQw6lyZXogKDQpOgo+ICAgIHZk
cGE6IEFkZCBzdG9wIG9wZXJhdGlvbgo+ICAgIHZob3N0LXZkcGE6IGludHJvZHVjZSBTVE9QIGJh
Y2tlbmQgZmVhdHVyZSBiaXQKPiAgICB2aG9zdC12ZHBhOiB1QVBJIHRvIHN0b3AgdGhlIGRldmlj
ZQo+ICAgIHZkcGFfc2ltOiBJbXBsZW1lbnQgc3RvcCB2ZHBhIG9wCj4KPiAgIGRyaXZlcnMvdmRw
YS92ZHBhX3NpbS92ZHBhX3NpbS5jICAgICB8IDIxICsrKysrKysrKysrKysrKysrCj4gICBkcml2
ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uaCAgICAgfCAgMSArCj4gICBkcml2ZXJzL3ZkcGEv
dmRwYV9zaW0vdmRwYV9zaW1fYmxrLmMgfCAgMyArKysKPiAgIGRyaXZlcnMvdmRwYS92ZHBhX3Np
bS92ZHBhX3NpbV9uZXQuYyB8ICAzICsrKwo+ICAgZHJpdmVycy92aG9zdC92ZHBhLmMgICAgICAg
ICAgICAgICAgIHwgMzQgKysrKysrKysrKysrKysrKysrKysrKysrKysrLQo+ICAgaW5jbHVkZS9s
aW51eC92ZHBhLmggICAgICAgICAgICAgICAgIHwgIDYgKysrKysKPiAgIGluY2x1ZGUvdWFwaS9s
aW51eC92aG9zdC5oICAgICAgICAgICB8IDE0ICsrKysrKysrKysrKwo+ICAgaW5jbHVkZS91YXBp
L2xpbnV4L3Zob3N0X3R5cGVzLmggICAgIHwgIDIgKysKPiAgIDggZmlsZXMgY2hhbmdlZCwgODMg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
