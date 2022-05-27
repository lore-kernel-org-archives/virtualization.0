Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91053C433F5
	for <virtualization@archiver.kernel.org>; Fri, 27 May 2022 02:26:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 34C21412A4;
	Fri, 27 May 2022 02:26:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tthJcS50s5Jp; Fri, 27 May 2022 02:26:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C3A6F4052C;
	Fri, 27 May 2022 02:26:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A68A1C0039;
	Fri, 27 May 2022 02:26:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10936C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 02:26:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F2C4D60EF9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 02:26:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AuItag4CBfR1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 02:26:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9AAE360E90
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 02:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653618410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oaDAshEcGYeYhJ5+Zo99OPfgNFs1k3b7zVlzbxHYNl0=;
 b=MsoZxVsdQq/zRH23U6ED0gdtz1Yg9cjvDnfEgPZDQ9N4Pxa5/ps8AN/SXeYjIzQ8J3gkWe
 P41sW5r71Ndz4fOchno3wy7tBk1UAVTCV75BTmjC3vn/FZRYi+5Yfb+qPfhvbKGVcig60P
 iUfbLulsOda9qOalJHCsQ+ZwzDfk68o=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-RHFCZJ9PPp6CMp7BbTF5Pw-1; Thu, 26 May 2022 22:26:49 -0400
X-MC-Unique: RHFCZJ9PPp6CMp7BbTF5Pw-1
Received: by mail-lf1-f70.google.com with SMTP id
 w38-20020a0565120b2600b00477b08c1730so1344989lfu.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 19:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=oaDAshEcGYeYhJ5+Zo99OPfgNFs1k3b7zVlzbxHYNl0=;
 b=dQQERVtJGsLcEWoj7FZ7gdHsdTJDUft55cdY2jv4qTnj5pu2A3X5snqyivATZXBoTH
 oaKW5F1dCKitxvxYUmwd3CSyfXg/kCx0rU/j8lf9TIHeOBkYORtoRNuaJqDJpgvkRxfH
 wh39FHh9KzC1Nbgl2hjIkhL1NKUUI3ugLvSO682XD+K8pvjT/9tZGabaAZDKl9Kc7bwo
 N89osKZ50MzoFZjGnSlVEGUOhWYdZVVG2H0/n6jhaBCfKLTJPFecCBgMmQpQ8pkooJ2o
 I/UHrlIPyXn32x6wLUn6A07pzemuLy+Wrbm7hlEYVnOjn3tZhiZSDcLniTB94/mkSVpD
 e6Gg==
X-Gm-Message-State: AOAM530v2VoEmCuOGhWIqb3GFUeIzoPMkCRKKJgYZTXGIhZVK5TFx0Mm
 JP35KLhA/NBxANg1SJUfYXL7UuMjvrlv+K4smdXDUdKYk/u3PPT1P6leLDelHOFHhX25SVLhbJN
 klOPlMSfbdf2gHQrxMB3MeWAJsxIFEI5V2UbF6HGbZhpXzow+klrhULr6Ew==
X-Received: by 2002:a2e:954c:0:b0:253:d9bf:9f55 with SMTP id
 t12-20020a2e954c000000b00253d9bf9f55mr21308457ljh.300.1653618407806; 
 Thu, 26 May 2022 19:26:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHcqEOz1xk1ptv4/JAwcVxyXOZtbrjI3QyKwE3Rw+KFfhLBm5gZOZJQQUeuqyIULlx21HHjnfaD0MAV67KrFc=
X-Received: by 2002:a2e:954c:0:b0:253:d9bf:9f55 with SMTP id
 t12-20020a2e954c000000b00253d9bf9f55mr21308435ljh.300.1653618407570; Thu, 26
 May 2022 19:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220526124338.36247-1-eperezma@redhat.com>
 <PH0PR12MB54819C6C6DAF6572AEADC1AEDCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54819C6C6DAF6572AEADC1AEDCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 May 2022 10:26:35 +0800
Message-ID: <CACGkMEu1YenjBHAssP=FvKX6WxDQ5Aa50r-BsnkfR4zqNTk6hg@mail.gmail.com>
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

T24gVGh1LCBNYXkgMjYsIDIwMjIgYXQgODo1NCBQTSBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRp
YS5jb20+IHdyb3RlOgo+Cj4KPgo+ID4gRnJvbTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJl
ZGhhdC5jb20+Cj4gPiBTZW50OiBUaHVyc2RheSwgTWF5IDI2LCAyMDIyIDg6NDQgQU0KPgo+ID4g
SW1wbGVtZW50IHN0b3Agb3BlcmF0aW9uIGZvciB2ZHBhX3NpbSBkZXZpY2VzLCBzbyB2aG9zdC12
ZHBhIHdpbGwgb2ZmZXIKPiA+Cj4gPiB0aGF0IGJhY2tlbmQgZmVhdHVyZSBhbmQgdXNlcnNwYWNl
IGNhbiBlZmZlY3RpdmVseSBzdG9wIHRoZSBkZXZpY2UuCj4gPgo+ID4KPiA+Cj4gPiBUaGlzIGlz
IGEgbXVzdCBiZWZvcmUgZ2V0IHZpcnRxdWV1ZSBpbmRleGVzIChiYXNlKSBmb3IgbGl2ZSBtaWdy
YXRpb24sCj4gPgo+ID4gc2luY2UgdGhlIGRldmljZSBjb3VsZCBtb2RpZnkgdGhlbSBhZnRlciB1
c2VybGFuZCBnZXRzIHRoZW0uIFRoZXJlIGFyZQo+ID4KPiA+IGluZGl2aWR1YWwgd2F5cyB0byBw
ZXJmb3JtIHRoYXQgYWN0aW9uIGZvciBzb21lIGRldmljZXMKPiA+Cj4gPiAoVkhPU1RfTkVUX1NF
VF9CQUNLRU5ELCBWSE9TVF9WU09DS19TRVRfUlVOTklORywgLi4uKSBidXQgdGhlcmUKPiA+IHdh
cyBubwo+ID4KPiA+IHdheSB0byBwZXJmb3JtIGl0IGZvciBhbnkgdmhvc3QgZGV2aWNlIChhbmQs
IGluIHBhcnRpY3VsYXIsIHZob3N0LXZkcGEpLgo+ID4KPiA+Cj4gPgo+ID4gQWZ0ZXIgdGhlIHJl
dHVybiBvZiBpb2N0bCB3aXRoIHN0b3AgIT0gMCwgdGhlIGRldmljZSBNVVNUIGZpbmlzaCBhbnkK
PiA+Cj4gPiBwZW5kaW5nIG9wZXJhdGlvbnMgbGlrZSBpbiBmbGlnaHQgcmVxdWVzdHMuIEl0IG11
c3QgYWxzbyBwcmVzZXJ2ZSBhbGwKPiA+Cj4gPiB0aGUgbmVjZXNzYXJ5IHN0YXRlICh0aGUgdmly
dHF1ZXVlIHZyaW5nIGJhc2UgcGx1cyB0aGUgcG9zc2libGUgZGV2aWNlCj4gPgo+ID4gc3BlY2lm
aWMgc3RhdGVzKSB0aGF0IGlzIHJlcXVpcmVkIGZvciByZXN0b3JpbmcgaW4gdGhlIGZ1dHVyZS4g
VGhlCj4gPgo+ID4gZGV2aWNlIG11c3Qgbm90IGNoYW5nZSBpdHMgY29uZmlndXJhdGlvbiBhZnRl
ciB0aGF0IHBvaW50Lgo+ID4KPiA+Cj4gPgo+ID4gQWZ0ZXIgdGhlIHJldHVybiBvZiBpb2N0bCB3
aXRoIHN0b3AgPT0gMCwgdGhlIGRldmljZSBjYW4gY29udGludWUKPiA+Cj4gPiBwcm9jZXNzaW5n
IGJ1ZmZlcnMgYXMgbG9uZyBhcyB0eXBpY2FsIGNvbmRpdGlvbnMgYXJlIG1ldCAodnEgaXMgZW5h
YmxlZCwKPiA+Cj4gPiBEUklWRVJfT0sgc3RhdHVzIGJpdCBpcyBlbmFibGVkLCBldGMpLgo+Cj4g
SnVzdCB0byBiZSBjbGVhciwgd2UgYXJlIGFkZGluZyB2ZHBhIGxldmVsIG5ldyBpb2N0bCgpIHRo
YXQgZG9lc27igJl0IG1hcCB0byBhbnkgbWVjaGFuaXNtIGluIHRoZSB2aXJ0aW8gc3BlYy4KCldl
IHRyeSB0byBwcm92aWRlIGZvcndhcmQgY29tcGF0aWJpbGl0eSB0byBWSVJUSU9fQ09ORklHX1Nf
U1RPUC4gVGhhdAptZWFucyBpdCBpcyBleHBlY3RlZCB0byBpbXBsZW1lbnQgYXQgbGVhc3QgYSBz
dWJzZXQgb2YKVklSVElPX0NPTkZJR19TX1NUT1AuCgo+Cj4gV2h5IGNhbid0IHdlIHVzZSB0aGlz
IGlvY3RsKCkgdG8gaW5kaWNhdGUgZHJpdmVyIHRvIHN0YXJ0L3N0b3AgdGhlIGRldmljZSBpbnN0
ZWFkIG9mIGRyaXZpbmcgaXQgdGhyb3VnaCB0aGUgZHJpdmVyX29rPwoKU28gdGhlIGlkZWEgaXMg
dG8gYWRkIGNhcGFiaWxpdHkgdGhhdCBkb2VzIG5vdCBleGlzdCBpbiB0aGUgc3BlYy4gVGhlbgpj
YW1lIHRoZSBzdG9wL3Jlc3VtZSB3aGljaCBjYW4ndCBiZSBkb25lIHZpYSBEUklWRVJfT0suIEkg
dGhpbmsgd2UKc2hvdWxkIG9ubHkgYWxsb3cgdGhlIHN0b3AvcmVzdW1lIHRvIHN1Y2NlZWQgYWZ0
ZXIgRFJJVkVSX09LIGlzIHNldC4KCj4gVGhpcyBpcyBpbiB0aGUgY29udGV4dCBvZiBvdGhlciBk
aXNjdXNzaW9uIHdlIGhhZCBpbiB0aGUgTE0gc2VyaWVzLgoKRG8geW91IHNlZSBhbnkgaXNzdWUg
dGhhdCBibG9ja3MgdGhlIGxpdmUgbWlncmF0aW9uPwoKVGhhbmtzCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
