Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFA6C433F5
	for <virtualization@archiver.kernel.org>; Wed, 25 May 2022 02:50:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CD974191C;
	Wed, 25 May 2022 02:50:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WcFWNeioZAyh; Wed, 25 May 2022 02:49:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7F4F841913;
	Wed, 25 May 2022 02:49:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F834C0032;
	Wed, 25 May 2022 02:49:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC74EC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 02:49:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D90AF81B98
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 02:49:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id egEyW2d9li9x
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 02:49:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2990381B69
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 02:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653446994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ElTuX9jWxfL0CUwfGnyHCc3cXorhj0tUDVKXC9Pq5yE=;
 b=CeDcO1kJycPIxgFyyM//EdA3JFr2pgeHm2Ml+JUnVGu9HzB4lCt40rXAg8BlOnArER833+
 OkE0XrLwKk+ETzEe1rCMoJewnL+E0NN5REkKm0gfEU9izda6GbupvzcV/GsY3kWTkaSkjf
 9EsiDJ9FcgBEe+6y2BCyJ/OQ/+SDHfY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-2MZtJGZFMVqM_w279089qA-1; Tue, 24 May 2022 22:49:53 -0400
X-MC-Unique: 2MZtJGZFMVqM_w279089qA-1
Received: by mail-lf1-f72.google.com with SMTP id
 q17-20020a0565123a9100b0047889d19f70so1995338lfu.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 19:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ElTuX9jWxfL0CUwfGnyHCc3cXorhj0tUDVKXC9Pq5yE=;
 b=uOZl11uZowXAtYsBswS8g6MeJtz39QLLy4eexunuO9Kj6tsGgBBjiXpXqdxYhMzzLq
 5gFefJ+zsVF6aaWJErtsQDqRghKX9K3fL5P0zmC77VkU9sOKddbmx0KO3sO1tct0BPMT
 yiZ2GBZCbvzLWtEns1ypdJTL00tyvu4662OiseLvHCGXKc2+kCzto+2WtC7c1h3jk/eU
 xRPRsTx+36SErqu1ihYDszMw8u5zqnW8m9srUxxvKW7tmqIwcYCrvUUJKrSAZUnUtBo4
 HCycfbbLKgu25vRiZATMWp9hB70ZZeVtSQL2O0XKTeEvZjGG6ErLh92AARHqdZ/mnMF3
 Q0eQ==
X-Gm-Message-State: AOAM533dF/U3TtTDJFdrjq7Mz96vSGmpTIhQTBEXAc/m5bMuC0I/aj7U
 6xueHXXM+cjux107YXHS5iGqZa7un7q+JLMEHqRWnn1ZlSUV4Igizp6D5df1zp9X+5oD2+Dgpfa
 ieh4UAJTS/4NxZDi1sPhY6yxGLMYcwYYzmMU1r3QUbp835RazCmoXUKPiEw==
X-Received: by 2002:a2e:81c1:0:b0:24b:f44:3970 with SMTP id
 s1-20020a2e81c1000000b0024b0f443970mr17702612ljg.97.1653446992173; 
 Tue, 24 May 2022 19:49:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaAlxsbkHduKZFbcUP9Q8h4gtKP25cQ1tcIPf8o5riuG1dRzo29yaMgKzd1IjazP5PKoJ9oIdwVR4fFRKu26Q=
X-Received: by 2002:a2e:81c1:0:b0:24b:f44:3970 with SMTP id
 s1-20020a2e81c1000000b0024b0f443970mr17702581ljg.97.1653446991974; Tue, 24
 May 2022 19:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220524170610.2255608-1-eperezma@redhat.com>
In-Reply-To: <20220524170610.2255608-1-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 25 May 2022 10:49:40 +0800
Message-ID: <CACGkMEvHRL7a6njivA0+ae-+nXUB9Dng=oaQny0cHu-Ra+bcFg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Implement vdpasim stop operation
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
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBJbXBsZW1lbnQgc3RvcCBvcGVyYXRpb24gZm9yIHZkcGFf
c2ltIGRldmljZXMsIHNvIHZob3N0LXZkcGEgd2lsbCBvZmZlcgo+IHRoYXQgYmFja2VuZCBmZWF0
dXJlIGFuZCB1c2Vyc3BhY2UgY2FuIGVmZmVjdGl2ZWx5IHN0b3AgdGhlIGRldmljZS4KPgo+IFRo
aXMgaXMgYSBtdXN0IGJlZm9yZSBnZXQgdmlydHF1ZXVlIGluZGV4ZXMgKGJhc2UpIGZvciBsaXZl
IG1pZ3JhdGlvbiwKPiBzaW5jZSB0aGUgZGV2aWNlIGNvdWxkIG1vZGlmeSB0aGVtIGFmdGVyIHVz
ZXJsYW5kIGdldHMgdGhlbS4gVGhlcmUgYXJlCj4gaW5kaXZpZHVhbCB3YXlzIHRvIHBlcmZvcm0g
dGhhdCBhY3Rpb24gZm9yIHNvbWUgZGV2aWNlcwo+IChWSE9TVF9ORVRfU0VUX0JBQ0tFTkQsIFZI
T1NUX1ZTT0NLX1NFVF9SVU5OSU5HLCAuLi4pIGJ1dCB0aGVyZSB3YXMgbm8KPiB3YXkgdG8gcGVy
Zm9ybSBpdCBmb3IgYW55IHZob3N0IGRldmljZSAoYW5kLCBpbiBwYXJ0aWN1bGFyLCB2aG9zdC12
ZHBhKS4KPgo+IEFmdGVyIHRoZSByZXR1cm4gb2YgaW9jdGwgd2l0aCBzdG9wICE9IDAsIHRoZSBk
ZXZpY2UgTVVTVCBmaW5pc2ggYW55Cj4gcGVuZGluZyBvcGVyYXRpb25zIGxpa2UgaW4gZmxpZ2h0
IHJlcXVlc3RzLiBJdCBtdXN0IGFsc28gcHJlc2VydmUgYWxsCj4gdGhlIG5lY2Vzc2FyeSBzdGF0
ZSAodGhlIHZpcnRxdWV1ZSB2cmluZyBiYXNlIHBsdXMgdGhlIHBvc3NpYmxlIGRldmljZQo+IHNw
ZWNpZmljIHN0YXRlcykgdGhhdCBpcyByZXF1aXJlZCBmb3IgcmVzdG9yaW5nIGluIHRoZSBmdXR1
cmUuIFRoZQo+IGRldmljZSBtdXN0IG5vdCBjaGFuZ2UgaXRzIGNvbmZpZ3VyYXRpb24gYWZ0ZXIg
dGhhdCBwb2ludC4KCkknZCBzdWdnZXN0IGRvY3VtZW50aW5nIHRoaXMgaW4gdGhlIGNvZGUgbWF5
YmUgYXJvdW5kIG9wcy0+c3RvcCgpPwoKVGhhbmtzCgo+Cj4gQWZ0ZXIgdGhlIHJldHVybiBvZiBp
b2N0bCB3aXRoIHN0b3AgPT0gMCwgdGhlIGRldmljZSBjYW4gY29udGludWUKPiBwcm9jZXNzaW5n
IGJ1ZmZlcnMgYXMgbG9uZyBhcyB0eXBpY2FsIGNvbmRpdGlvbnMgYXJlIG1ldCAodnEgaXMgZW5h
YmxlZCwKPiBEUklWRVJfT0sgc3RhdHVzIGJpdCBpcyBlbmFibGVkLCBldGMpLgo+Cj4gSW4gdGhl
IGZ1dHVyZSwgd2Ugd2lsbCBwcm92aWRlIGZlYXR1cmVzIHNpbWlsYXIgdG8gVkhPU1RfVVNFUl9H
RVRfSU5GTElHSFRfRkQKPiBzbyB0aGUgZGV2aWNlIGNhbiBzYXZlIHBlbmRpbmcgb3BlcmF0aW9u
cy4KPgo+IENvbW1lbnRzIGFyZSB3ZWxjb21lLgo+Cj4gdjI6Cj4gKiBSZXBsYWNlIHJhdyBfRl9T
VE9QIHdpdGggQklUX1VMTChfRl9TVE9QKS4KPiAqIEZpeCBvYnRhaW5pbmcgb2Ygc3RvcCBpb2N0
bCBhcmcgKGl0IHdhcyBub3Qgb2J0YWluZWQgYnV0IHdyaXR0ZW4pLgo+ICogQWRkIHN0b3AgdG8g
dmRwYV9zaW1fYmxrLgo+Cj4gRXVnZW5pbyBQw6lyZXogKDQpOgo+ICAgdmRwYTogQWRkIHN0b3Ag
b3BlcmF0aW9uCj4gICB2aG9zdC12ZHBhOiBpbnRyb2R1Y2UgU1RPUCBiYWNrZW5kIGZlYXR1cmUg
Yml0Cj4gICB2aG9zdC12ZHBhOiB1QVBJIHRvIHN0b3AgdGhlIGRldmljZQo+ICAgdmRwYV9zaW06
IEltcGxlbWVudCBzdG9wIHZkcGEgb3AKPgo+ICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9z
aW0uYyAgICAgfCAyMSArKysrKysrKysrKysrKysrKwo+ICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0v
dmRwYV9zaW0uaCAgICAgfCAgMSArCj4gIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9i
bGsuYyB8ICAzICsrKwo+ICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fbmV0LmMgfCAg
MyArKysKPiAgZHJpdmVycy92aG9zdC92ZHBhLmMgICAgICAgICAgICAgICAgIHwgMzQgKysrKysr
KysrKysrKysrKysrKysrKysrKysrLQo+ICBpbmNsdWRlL2xpbnV4L3ZkcGEuaCAgICAgICAgICAg
ICAgICAgfCAgNiArKysrKwo+ICBpbmNsdWRlL3VhcGkvbGludXgvdmhvc3QuaCAgICAgICAgICAg
fCAgMyArKysKPiAgaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0X3R5cGVzLmggICAgIHwgIDIgKysK
PiAgOCBmaWxlcyBjaGFuZ2VkLCA3MiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiAt
LQo+IDIuMjcuMAo+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
