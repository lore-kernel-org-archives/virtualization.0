Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB0AC43334
	for <virtualization@archiver.kernel.org>; Wed, 29 Jun 2022 04:18:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7CCDF60BE1;
	Wed, 29 Jun 2022 04:18:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7CCDF60BE1
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KuDIBN5y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 45Smu3QgWNUd; Wed, 29 Jun 2022 04:18:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F1CD460A80;
	Wed, 29 Jun 2022 04:18:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F1CD460A80
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C05A2C0039;
	Wed, 29 Jun 2022 04:18:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42868C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 04:18:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2550581678
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 04:18:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2550581678
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KuDIBN5y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HX3jjzvrZ4hx
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 04:18:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3F979815AC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3F979815AC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 04:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656476323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2h8ccNqJU95HAa4G/EVV71yAZ0Ts5Xe8taofTuRNpD4=;
 b=KuDIBN5yCUclroqoOwQEEe+1GRPs7moeAaCagkOez2LA2HxlTdGBKRHEfTy97okg1TcutR
 u5dpZk3tZGnjDngPpj6jot48sihQtrDCPMtguaV4UmhJAkZG5Z3o7M/xaXBg8rGgESUa7O
 g9boLwJMdik1nl0s5YVAxdD7JaJp3ZI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-45-rDPk8JOuNC2qRKLuctw0GQ-1; Wed, 29 Jun 2022 00:18:40 -0400
X-MC-Unique: rDPk8JOuNC2qRKLuctw0GQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 z13-20020a056512308d00b004811694f893so4106600lfd.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 21:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2h8ccNqJU95HAa4G/EVV71yAZ0Ts5Xe8taofTuRNpD4=;
 b=215oixxnlmSRsq3WRH/4iuID/SC+pQvJh5p/mZlkOsTc0NWN4QCLBCO6ebCJa7xJ4I
 byCSByO4Ke4ElIUAPlSwem0F6/k61fSpF0X6OsZmevFC3XvwbZ/3BJVR9l96VQ55xDRr
 BK4G8Z/S9JbIXeeKIxf40YiqaL/5FRJwZUtNEAvKyFYghTKt5XKDsygGuUIJwLn14MqI
 kXSgDz2NzRj2IsZwbLEw+ahJELCWvWL8sxfl2Isgi/GSWHEPI8p7kuA359xoaWeL+eOx
 4PAUERV8jUdrfFqte/HgUr/9gGpwGqhAiGSuIG0C8zyD0b0pV7HC05GI9KgjrZtuAvq6
 7KuA==
X-Gm-Message-State: AJIora/PPlEvfno0TlkQb5g4i0dcNpzYpbWAgjb0sT0DO5BwbKsGAOfH
 BxtxgmNofGAL5/T16nKeO6Nwn2z44+8FtcCqEAKNLL62NI7vBpNo5ytL9ip9sAPNX4jpYajV8Yv
 bqJVNOQQRN80hqkUPqQiaqZq9B8OMVloa6hV1TqfqqjBlLNiq7ZQ/u/ynxg==
X-Received: by 2002:a05:6512:158d:b0:47f:718c:28b5 with SMTP id
 bp13-20020a056512158d00b0047f718c28b5mr811927lfb.397.1656476318742; 
 Tue, 28 Jun 2022 21:18:38 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vZ6G4jroIyi6EDss7eqJRupKjJ6aAZH6PLBk1sX8uk6DRDfTN14oyEf9afhAJidDtEIQTSOcMcEre11YiA3MQ=
X-Received: by 2002:a05:6512:158d:b0:47f:718c:28b5 with SMTP id
 bp13-20020a056512158d00b0047f718c28b5mr811892lfb.397.1656476318523; Tue, 28
 Jun 2022 21:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220623160738.632852-1-eperezma@redhat.com>
 <20220623160738.632852-5-eperezma@redhat.com>
In-Reply-To: <20220623160738.632852-5-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 29 Jun 2022 12:18:27 +0800
Message-ID: <CACGkMEtbukb4gcCHytotZr7FA+Dp1cFs4BpPJatR98zqAnNZjA@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] vdpa_sim: Implement suspend vdpa op
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Kamde, Tanuj" <tanuj.kamde@amd.com>, kvm <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>,
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

T24gRnJpLCBKdW4gMjQsIDIwMjIgYXQgMTI6MDggQU0gRXVnZW5pbyBQw6lyZXogPGVwZXJlem1h
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gSW1wbGVtZW50IHN1c3BlbmQgb3BlcmF0aW9uIGZvciB2
ZHBhX3NpbSBkZXZpY2VzLCBzbyB2aG9zdC12ZHBhIHdpbGwKPiBvZmZlciB0aGF0IGJhY2tlbmQg
ZmVhdHVyZSBhbmQgdXNlcnNwYWNlIGNhbiBlZmZlY3RpdmVseSBzdXNwZW5kIHRoZQo+IGRldmlj
ZS4KPgo+IFRoaXMgaXMgYSBtdXN0IGJlZm9yZSBnZXQgdmlydHF1ZXVlIGluZGV4ZXMgKGJhc2Up
IGZvciBsaXZlIG1pZ3JhdGlvbiwKPiBzaW5jZSB0aGUgZGV2aWNlIGNvdWxkIG1vZGlmeSB0aGVt
IGFmdGVyIHVzZXJsYW5kIGdldHMgdGhlbS4gVGhlcmUgYXJlCj4gaW5kaXZpZHVhbCB3YXlzIHRv
IHBlcmZvcm0gdGhhdCBhY3Rpb24gZm9yIHNvbWUgZGV2aWNlcwo+IChWSE9TVF9ORVRfU0VUX0JB
Q0tFTkQsIFZIT1NUX1ZTT0NLX1NFVF9SVU5OSU5HLCAuLi4pIGJ1dCB0aGVyZSB3YXMgbm8KPiB3
YXkgdG8gcGVyZm9ybSBpdCBmb3IgYW55IHZob3N0IGRldmljZSAoYW5kLCBpbiBwYXJ0aWN1bGFy
LCB2aG9zdC12ZHBhKS4KPgo+IFJldmlld2VkLWJ5OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6
YXJlQHJlZGhhdC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1h
QHJlZGhhdC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jICAg
ICB8IDIxICsrKysrKysrKysrKysrKysrKysrKwo+ICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRw
YV9zaW0uaCAgICAgfCAgMSArCj4gIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9ibGsu
YyB8ICAzICsrKwo+ICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fbmV0LmMgfCAgMyAr
KysKPiAgNCBmaWxlcyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0v
dmRwYV9zaW0uYwo+IGluZGV4IDBmMjg2NTg5OTY0Ny4uMjEzODgzNDg3ZjliIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4gKysrIGIvZHJpdmVycy92ZHBh
L3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPiBAQCAtMTA3LDYgKzEwNyw3IEBAIHN0YXRpYyB2b2lkIHZk
cGFzaW1fZG9fcmVzZXQoc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0pCj4gICAgICAgICBmb3IgKGkg
PSAwOyBpIDwgdmRwYXNpbS0+ZGV2X2F0dHIubmFzOyBpKyspCj4gICAgICAgICAgICAgICAgIHZo
b3N0X2lvdGxiX3Jlc2V0KCZ2ZHBhc2ltLT5pb21tdVtpXSk7Cj4KPiArICAgICAgIHZkcGFzaW0t
PnJ1bm5pbmcgPSB0cnVlOwo+ICAgICAgICAgc3Bpbl91bmxvY2soJnZkcGFzaW0tPmlvbW11X2xv
Y2spOwo+Cj4gICAgICAgICB2ZHBhc2ltLT5mZWF0dXJlcyA9IDA7Cj4gQEAgLTUwNSw2ICs1MDYs
MjQgQEAgc3RhdGljIGludCB2ZHBhc2ltX3Jlc2V0KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSkK
PiAgICAgICAgIHJldHVybiAwOwo+ICB9Cj4KPiArc3RhdGljIGludCB2ZHBhc2ltX3N1c3BlbmQo
c3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhKQo+ICt7Cj4gKyAgICAgICBzdHJ1Y3QgdmRwYXNpbSAq
dmRwYXNpbSA9IHZkcGFfdG9fc2ltKHZkcGEpOwo+ICsgICAgICAgaW50IGk7Cj4gKwo+ICsgICAg
ICAgc3Bpbl9sb2NrKCZ2ZHBhc2ltLT5sb2NrKTsKPiArICAgICAgIHZkcGFzaW0tPnJ1bm5pbmcg
PSBmYWxzZTsKPiArICAgICAgIGlmICh2ZHBhc2ltLT5ydW5uaW5nKSB7Cj4gKyAgICAgICAgICAg
ICAgIC8qIENoZWNrIGZvciBtaXNzZWQgYnVmZmVycyAqLwo+ICsgICAgICAgICAgICAgICBmb3Ig
KGkgPSAwOyBpIDwgdmRwYXNpbS0+ZGV2X2F0dHIubnZxczsgKytpKQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIHZkcGFzaW1fa2lja192cSh2ZHBhLCBpKTsKClRoaXMgc2VlbXMgb25seSB2YWxp
ZCBpZiB3ZSBhbGxvdyByZXN1bWluZz8KClRoYW5rcwoKPiArCj4gKyAgICAgICB9Cj4gKyAgICAg
ICBzcGluX3VubG9jaygmdmRwYXNpbS0+bG9jayk7Cj4gKwo+ICsgICAgICAgcmV0dXJuIDA7Cj4g
K30KPiArCj4gIHN0YXRpYyBzaXplX3QgdmRwYXNpbV9nZXRfY29uZmlnX3NpemUoc3RydWN0IHZk
cGFfZGV2aWNlICp2ZHBhKQo+ICB7Cj4gICAgICAgICBzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSA9
IHZkcGFfdG9fc2ltKHZkcGEpOwo+IEBAIC02OTQsNiArNzEzLDcgQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCB2ZHBhX2NvbmZpZ19vcHMgdmRwYXNpbV9jb25maWdfb3BzID0gewo+ICAgICAgICAgLmdl
dF9zdGF0dXMgICAgICAgICAgICAgPSB2ZHBhc2ltX2dldF9zdGF0dXMsCj4gICAgICAgICAuc2V0
X3N0YXR1cyAgICAgICAgICAgICA9IHZkcGFzaW1fc2V0X3N0YXR1cywKPiAgICAgICAgIC5yZXNl
dCAgICAgICAgICAgICAgICAgID0gdmRwYXNpbV9yZXNldCwKPiArICAgICAgIC5zdXNwZW5kICAg
ICAgICAgICAgICAgID0gdmRwYXNpbV9zdXNwZW5kLAo+ICAgICAgICAgLmdldF9jb25maWdfc2l6
ZSAgICAgICAgPSB2ZHBhc2ltX2dldF9jb25maWdfc2l6ZSwKPiAgICAgICAgIC5nZXRfY29uZmln
ICAgICAgICAgICAgID0gdmRwYXNpbV9nZXRfY29uZmlnLAo+ICAgICAgICAgLnNldF9jb25maWcg
ICAgICAgICAgICAgPSB2ZHBhc2ltX3NldF9jb25maWcsCj4gQEAgLTcyNiw2ICs3NDYsNyBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyB2ZHBhc2ltX2JhdGNoX2NvbmZpZ19v
cHMgPSB7Cj4gICAgICAgICAuZ2V0X3N0YXR1cyAgICAgICAgICAgICA9IHZkcGFzaW1fZ2V0X3N0
YXR1cywKPiAgICAgICAgIC5zZXRfc3RhdHVzICAgICAgICAgICAgID0gdmRwYXNpbV9zZXRfc3Rh
dHVzLAo+ICAgICAgICAgLnJlc2V0ICAgICAgICAgICAgICAgICAgPSB2ZHBhc2ltX3Jlc2V0LAo+
ICsgICAgICAgLnN1c3BlbmQgICAgICAgICAgICAgICAgPSB2ZHBhc2ltX3N1c3BlbmQsCj4gICAg
ICAgICAuZ2V0X2NvbmZpZ19zaXplICAgICAgICA9IHZkcGFzaW1fZ2V0X2NvbmZpZ19zaXplLAo+
ICAgICAgICAgLmdldF9jb25maWcgICAgICAgICAgICAgPSB2ZHBhc2ltX2dldF9jb25maWcsCj4g
ICAgICAgICAuc2V0X2NvbmZpZyAgICAgICAgICAgICA9IHZkcGFzaW1fc2V0X2NvbmZpZywKPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmggYi9kcml2ZXJzL3Zk
cGEvdmRwYV9zaW0vdmRwYV9zaW0uaAo+IGluZGV4IDYyMjc4MmU5MjIzOS4uMDYxOTg2ZjMwOTEx
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5oCj4gKysrIGIv
ZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmgKPiBAQCAtNjYsNiArNjYsNyBAQCBzdHJ1
Y3QgdmRwYXNpbSB7Cj4gICAgICAgICB1MzIgZ2VuZXJhdGlvbjsKPiAgICAgICAgIHU2NCBmZWF0
dXJlczsKPiAgICAgICAgIHUzMiBncm91cHM7Cj4gKyAgICAgICBib29sIHJ1bm5pbmc7Cj4gICAg
ICAgICAvKiBzcGlubG9jayB0byBzeW5jaHJvbml6ZSBpb21tdSB0YWJsZSAqLwo+ICAgICAgICAg
c3BpbmxvY2tfdCBpb21tdV9sb2NrOwo+ICB9Owo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEv
dmRwYV9zaW0vdmRwYV9zaW1fYmxrLmMgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1f
YmxrLmMKPiBpbmRleCA0MmQ0MDFkNDM5MTEuLmJjZGIxOTgyYzM3OCAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fYmxrLmMKPiArKysgYi9kcml2ZXJzL3ZkcGEv
dmRwYV9zaW0vdmRwYV9zaW1fYmxrLmMKPiBAQCAtMjA0LDYgKzIwNCw5IEBAIHN0YXRpYyB2b2lk
IHZkcGFzaW1fYmxrX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+ICAgICAgICAgaWYg
KCEodmRwYXNpbS0+c3RhdHVzICYgVklSVElPX0NPTkZJR19TX0RSSVZFUl9PSykpCj4gICAgICAg
ICAgICAgICAgIGdvdG8gb3V0Owo+Cj4gKyAgICAgICBpZiAoIXZkcGFzaW0tPnJ1bm5pbmcpCj4g
KyAgICAgICAgICAgICAgIGdvdG8gb3V0Owo+ICsKPiAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBW
RFBBU0lNX0JMS19WUV9OVU07IGkrKykgewo+ICAgICAgICAgICAgICAgICBzdHJ1Y3QgdmRwYXNp
bV92aXJ0cXVldWUgKnZxID0gJnZkcGFzaW0tPnZxc1tpXTsKPgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fbmV0LmMgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0v
dmRwYV9zaW1fbmV0LmMKPiBpbmRleCA1MTI1OTc2YTRkZjguLjg4NjQ0OWU4ODUwMiAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fbmV0LmMKPiArKysgYi9kcml2
ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fbmV0LmMKPiBAQCAtMTU0LDYgKzE1NCw5IEBAIHN0
YXRpYyB2b2lkIHZkcGFzaW1fbmV0X3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+Cj4g
ICAgICAgICBzcGluX2xvY2soJnZkcGFzaW0tPmxvY2spOwo+Cj4gKyAgICAgICBpZiAoIXZkcGFz
aW0tPnJ1bm5pbmcpCj4gKyAgICAgICAgICAgICAgIGdvdG8gb3V0Owo+ICsKPiAgICAgICAgIGlm
ICghKHZkcGFzaW0tPnN0YXR1cyAmIFZJUlRJT19DT05GSUdfU19EUklWRVJfT0spKQo+ICAgICAg
ICAgICAgICAgICBnb3RvIG91dDsKPgo+IC0tCj4gMi4zMS4xCj4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
