Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9D8C433F5
	for <virtualization@archiver.kernel.org>; Wed,  1 Jun 2022 02:42:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC3A982A17;
	Wed,  1 Jun 2022 02:42:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xqn6yidXKqp0; Wed,  1 Jun 2022 02:42:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3AAB7829B6;
	Wed,  1 Jun 2022 02:42:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F29E8C0039;
	Wed,  1 Jun 2022 02:42:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF117C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 02:42:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BD72C829AF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 02:42:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tt1_64Okl5Oe
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 02:42:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 78F5382980
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 02:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654051346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WB1eoNVPIkOVFlU558AybWrSuZCEkhfGeXbR5VK67Ks=;
 b=cp5ti+U9KkHxTKvdWu3ggcai7OpXHkwqSGOKQtXm1ubnuL5JfDtm8M9ekhrf3Uw19zcxTF
 JjAgh5zMSFITI2HjfLxI034bbGr4tTevSd9q7eCEETk3+cgOSpTeyAsCDShSyZzXxhz6e+
 wHIpLgpsI6XGfDPTjVev6hDwVAsK+/g=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-230-YuuRLwdlPHSyLSqjRFMw4g-1; Tue, 31 May 2022 22:42:25 -0400
X-MC-Unique: YuuRLwdlPHSyLSqjRFMw4g-1
Received: by mail-lf1-f72.google.com with SMTP id
 bu3-20020a056512168300b0047791fb1d68so193244lfb.23
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 19:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WB1eoNVPIkOVFlU558AybWrSuZCEkhfGeXbR5VK67Ks=;
 b=YGrjMwjJBQeuhBHLAGDas9G5VK5KIOvVrOukFkmXcKbOo2fDic3XEyVFT4EqS4g4oJ
 LF6R72Y2epnodViAeS6Rf7iMcsYgFpQVyhZeHQJW2l/tANBLOIGbKiqbxGdi1tok13br
 7oAWlasV6l0edI3sN5qhfNZ9jTFBbatAFuSrCtjyL4G1VKS6vwlLw7Z+Nmzh6KpxgSfR
 Z2dywjgD/hAFcVxL0EZA68UACYsauusfRrCcZ6OzeTwOf75oQk+OGOko3YPXaD5qwnpE
 ZQLmpS1bps9WH95vGqUoOu2cZHKTZhTw6Zf2CJDMg4WlchfwXxAi6BIyt7rqWbm9ybV8
 5kKw==
X-Gm-Message-State: AOAM53163bGbDmeqr8kyWzrblM9vyJ/zkiBZV1tXsxANeog2AIvQh09x
 C6NxO3DoZLUCPTp3/VkhSWqOPl+FCs0IJfTROQFC10XStHH7RXGKpKXXbMCGG5Ml3xP7DblCFqh
 jCe3RK07JkO0FnWQRl4MnDzx1RRlCytOCz/vCDDib3dKL38VA3VKFeO0Iiw==
X-Received: by 2002:a05:6512:c0e:b0:478:5a91:20bb with SMTP id
 z14-20020a0565120c0e00b004785a9120bbmr39100836lfu.587.1654051344030; 
 Tue, 31 May 2022 19:42:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmBp820NSJHDcSD2dOZzrKRPNlKlD6GwXH3X8zApWh8utE/CuOZMV9CsZAbAB4NHKmtcInCEEIporstHBP+gc=
X-Received: by 2002:a05:6512:c0e:b0:478:5a91:20bb with SMTP id
 z14-20020a0565120c0e00b004785a9120bbmr39100798lfu.587.1654051343791; Tue, 31
 May 2022 19:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220526124338.36247-1-eperezma@redhat.com>
 <PH0PR12MB54819C6C6DAF6572AEADC1AEDCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220527065442-mutt-send-email-mst@kernel.org>
 <CACGkMEubfv_OJOsJ_ROgei41Qx4mPO0Xz8rMVnO8aPFiEqr8rA@mail.gmail.com>
 <PH0PR12MB5481695930E7548BAAF1B0D9DCDC9@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481695930E7548BAAF1B0D9DCDC9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 1 Jun 2022 10:42:12 +0800
Message-ID: <CACGkMEsSKF_MyLgFdzVROptS3PCcp1y865znLWgnzq9L7CpFVQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Implement vdpasim stop operation
To: Parav Pandit <parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "tanuj.kamde@amd.com" <tanuj.kamde@amd.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 "pabloc@xilinx.com" <pabloc@xilinx.com>, Eli Cohen <elic@nvidia.com>,
 Zhang Min <zhang.min9@zte.com.cn>, "lulu@redhat.com" <lulu@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
 "martinh@xilinx.com" <martinh@xilinx.com>,
 Xie Yongji <xieyongji@bytedance.com>, "dinang@xilinx.com" <dinang@xilinx.com>,
 "habetsm.xilinx@gmail.com" <habetsm.xilinx@gmail.com>,
 Longpeng <longpeng2@huawei.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ecree.xilinx@gmail.com" <ecree.xilinx@gmail.com>,
 "hanand@xilinx.com" <hanand@xilinx.com>,
 "martinpo@xilinx.com" <martinpo@xilinx.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>,
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

T24gV2VkLCBKdW4gMSwgMjAyMiBhdCA0OjE5IEFNIFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZpZGlh
LmNvbT4gd3JvdGU6Cj4KPgo+ID4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4KPiA+IFNlbnQ6IFN1bmRheSwgTWF5IDI5LCAyMDIyIDExOjM5IFBNCj4gPgo+ID4gT24gRnJp
LCBNYXkgMjcsIDIwMjIgYXQgNjo1NiBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQu
Y29tPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gVGh1LCBNYXkgMjYsIDIwMjIgYXQgMTI6NTQ6MzJQ
TSArMDAwMCwgUGFyYXYgUGFuZGl0IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+IEZy
b206IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgo+ID4gPiA+ID4gU2VudDog
VGh1cnNkYXksIE1heSAyNiwgMjAyMiA4OjQ0IEFNCj4gPiA+ID4KPiA+ID4gPiA+IEltcGxlbWVu
dCBzdG9wIG9wZXJhdGlvbiBmb3IgdmRwYV9zaW0gZGV2aWNlcywgc28gdmhvc3QtdmRwYSB3aWxs
Cj4gPiA+ID4gPiBvZmZlcgo+ID4gPiA+ID4KPiA+ID4gPiA+IHRoYXQgYmFja2VuZCBmZWF0dXJl
IGFuZCB1c2Vyc3BhY2UgY2FuIGVmZmVjdGl2ZWx5IHN0b3AgdGhlIGRldmljZS4KPiA+ID4gPiA+
Cj4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoaXMgaXMgYSBtdXN0IGJlZm9yZSBnZXQg
dmlydHF1ZXVlIGluZGV4ZXMgKGJhc2UpIGZvciBsaXZlCj4gPiA+ID4gPiBtaWdyYXRpb24sCj4g
PiA+ID4gPgo+ID4gPiA+ID4gc2luY2UgdGhlIGRldmljZSBjb3VsZCBtb2RpZnkgdGhlbSBhZnRl
ciB1c2VybGFuZCBnZXRzIHRoZW0uIFRoZXJlCj4gPiA+ID4gPiBhcmUKPiA+ID4gPiA+Cj4gPiA+
ID4gPiBpbmRpdmlkdWFsIHdheXMgdG8gcGVyZm9ybSB0aGF0IGFjdGlvbiBmb3Igc29tZSBkZXZp
Y2VzCj4gPiA+ID4gPgo+ID4gPiA+ID4gKFZIT1NUX05FVF9TRVRfQkFDS0VORCwgVkhPU1RfVlNP
Q0tfU0VUX1JVTk5JTkcsIC4uLikgYnV0Cj4gPiB0aGVyZQo+ID4gPiA+ID4gd2FzIG5vCj4gPiA+
ID4gPgo+ID4gPiA+ID4gd2F5IHRvIHBlcmZvcm0gaXQgZm9yIGFueSB2aG9zdCBkZXZpY2UgKGFu
ZCwgaW4gcGFydGljdWxhciwgdmhvc3QtdmRwYSkuCj4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4g
PiA+Cj4gPiA+ID4gPiBBZnRlciB0aGUgcmV0dXJuIG9mIGlvY3RsIHdpdGggc3RvcCAhPSAwLCB0
aGUgZGV2aWNlIE1VU1QgZmluaXNoCj4gPiA+ID4gPiBhbnkKPiA+ID4gPiA+Cj4gPiA+ID4gPiBw
ZW5kaW5nIG9wZXJhdGlvbnMgbGlrZSBpbiBmbGlnaHQgcmVxdWVzdHMuIEl0IG11c3QgYWxzbyBw
cmVzZXJ2ZQo+ID4gPiA+ID4gYWxsCj4gPiA+ID4gPgo+ID4gPiA+ID4gdGhlIG5lY2Vzc2FyeSBz
dGF0ZSAodGhlIHZpcnRxdWV1ZSB2cmluZyBiYXNlIHBsdXMgdGhlIHBvc3NpYmxlCj4gPiA+ID4g
PiBkZXZpY2UKPiA+ID4gPiA+Cj4gPiA+ID4gPiBzcGVjaWZpYyBzdGF0ZXMpIHRoYXQgaXMgcmVx
dWlyZWQgZm9yIHJlc3RvcmluZyBpbiB0aGUgZnV0dXJlLiBUaGUKPiA+ID4gPiA+Cj4gPiA+ID4g
PiBkZXZpY2UgbXVzdCBub3QgY2hhbmdlIGl0cyBjb25maWd1cmF0aW9uIGFmdGVyIHRoYXQgcG9p
bnQuCj4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBBZnRlciB0aGUgcmV0
dXJuIG9mIGlvY3RsIHdpdGggc3RvcCA9PSAwLCB0aGUgZGV2aWNlIGNhbiBjb250aW51ZQo+ID4g
PiA+ID4KPiA+ID4gPiA+IHByb2Nlc3NpbmcgYnVmZmVycyBhcyBsb25nIGFzIHR5cGljYWwgY29u
ZGl0aW9ucyBhcmUgbWV0ICh2cSBpcwo+ID4gPiA+ID4gZW5hYmxlZCwKPiA+ID4gPiA+Cj4gPiA+
ID4gPiBEUklWRVJfT0sgc3RhdHVzIGJpdCBpcyBlbmFibGVkLCBldGMpLgo+ID4gPiA+Cj4gPiA+
ID4gSnVzdCB0byBiZSBjbGVhciwgd2UgYXJlIGFkZGluZyB2ZHBhIGxldmVsIG5ldyBpb2N0bCgp
IHRoYXQgZG9lc27igJl0IG1hcCB0bwo+ID4gYW55IG1lY2hhbmlzbSBpbiB0aGUgdmlydGlvIHNw
ZWMuCj4gPiA+ID4KPiA+ID4gPiBXaHkgY2FuJ3Qgd2UgdXNlIHRoaXMgaW9jdGwoKSB0byBpbmRp
Y2F0ZSBkcml2ZXIgdG8gc3RhcnQvc3RvcCB0aGUgZGV2aWNlCj4gPiBpbnN0ZWFkIG9mIGRyaXZp
bmcgaXQgdGhyb3VnaCB0aGUgZHJpdmVyX29rPwo+ID4gPiA+IFRoaXMgaXMgaW4gdGhlIGNvbnRl
eHQgb2Ygb3RoZXIgZGlzY3Vzc2lvbiB3ZSBoYWQgaW4gdGhlIExNIHNlcmllcy4KPiA+ID4KPiA+
ID4gSWYgdGhlcmUncyBzb21ldGhpbmcgaW4gdGhlIHNwZWMgdGhhdCBkb2VzIHRoaXMgdGhlbiBs
ZXQncyB1c2UgdGhhdC4KPiA+Cj4gPiBBY3R1YWxseSwgd2UgdHJ5IHRvIHByb3Bvc2UgYSBpbmRl
cGVuZGVudCBmZWF0dXJlIGhlcmU6Cj4gPgo+ID4gaHR0cHM6Ly9saXN0cy5vYXNpcy1vcGVuLm9y
Zy9hcmNoaXZlcy92aXJ0aW8tZGV2LzIwMjExMS9tc2cwMDAyMC5odG1sCj4gPgo+IFRoaXMgd2ls
bCBzdG9wIHRoZSBkZXZpY2UgZm9yIGFsbCB0aGUgb3BlcmF0aW9ucy4KCldlbGwsIHRoZSBhYmls
aXR5IHRvIHF1ZXJ5IHRoZSB2aXJ0cXVldWUgc3RhdGUgd2FzIHByb3Bvc2VkIGFzIGFub3RoZXIK
ZmVhdHVyZSAoRXVnZW5pbywgcGxlYXNlIGNvcnJlY3QgbWUpLiBUaGlzIHNob3VsZCBiZSBzdWZm
aWNpZW50IGZvcgptYWtpbmcgdmlydGlvLW5ldCB0byBiZSBsaXZlIG1pZ3JhdGVkLgoKaHR0cHM6
Ly9saXN0cy5vYXNpcy1vcGVuLm9yZy9hcmNoaXZlcy92aXJ0aW8tY29tbWVudC8yMDIxMDMvbXNn
MDAwMDguaHRtbAoKPiBPbmNlIHRoZSBkZXZpY2UgaXMgc3RvcHBlZCwgaXRzIHN0YXRlIGNhbm5v
dCBiZSBxdWVyaWVkIGZ1cnRoZXIgYXMgZGV2aWNlIHdvbid0IHJlc3BvbmQuCj4gSXQgaGFzIGxp
bWl0ZWQgdXNlIGNhc2UuCj4gV2hhdCB3ZSBuZWVkIGlzIHRvIHN0b3Agbm9uIGFkbWluIHF1ZXVl
IHJlbGF0ZWQgcG9ydGlvbiBvZiB0aGUgZGV2aWNlLgoKU2VlIGFib3ZlLgoKVGhhbmtzCgo+Cj4g
PiBEb2VzIGl0IG1ha2Ugc2Vuc2UgdG8geW91Pwo+ID4KPiA+IFRoYW5rcwo+ID4KPiA+ID4gVW5m
b3J0dW5hdGVseSB0aGUgTE0gc2VyaWVzIHNlZW1zIHRvIGJlIHN0dWNrIG9uIG1vdmluZyBiaXRz
IGFyb3VuZAo+ID4gPiB3aXRoIHRoZSBhZG1pbiB2aXJ0cXVldWUgLi4uCj4gPiA+Cj4gPiA+IC0t
Cj4gPiA+IE1TVAo+ID4gPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
