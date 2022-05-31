Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A7BC433F5
	for <virtualization@archiver.kernel.org>; Tue, 31 May 2022 05:40:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D32038408A;
	Tue, 31 May 2022 05:40:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4S1e89jrpClh; Tue, 31 May 2022 05:40:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6726B84084;
	Tue, 31 May 2022 05:40:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 368BDC0039;
	Tue, 31 May 2022 05:40:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B875C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 05:40:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 63F2C60B6E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 05:40:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tnIz7uSi2hrs
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 05:40:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4F1EB60B9D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 05:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653975637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g0/inTPXCkYCa8tPwUAmu5S5vMTpS/z+cw62yovLB+o=;
 b=Kpru4rLswabQ2uo6XSRUf/fct/zj5ZOC4LjZgdlYwG8ss6ryaeEClpnTB+vRxjkUHs5t2c
 3Xn2yQTQ/gWd9VRmmCRp0RJAI2xjeWiPXYcZ7X8tT0ckK/1w/Z4PMsedE3PkSG/RUQsilp
 Y7oaPGd6bPekjRFseQThLDElGGNmoR4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-301-8sWbeE8mNK2nU1ld0QdfJg-1; Tue, 31 May 2022 01:40:35 -0400
X-MC-Unique: 8sWbeE8mNK2nU1ld0QdfJg-1
Received: by mail-wm1-f70.google.com with SMTP id
 bg40-20020a05600c3ca800b00394779649b1so845845wmb.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 22:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=g0/inTPXCkYCa8tPwUAmu5S5vMTpS/z+cw62yovLB+o=;
 b=tbdzgOB27b4k1ZYZitmW7VLNIXvg549zPBjrTZdpmUscvWaQ9WZ83YPPx2b+c0yqwo
 TvBAJLpRXKgKq1sj9kcW6m/aiyyA5ZO43avHfCT+yd9Rb8djbsH2tJOHOMb84b0dRQVK
 e9caiNLLbLftOIgkEoooHYwgyxsRQUUMCKbTV9zez6vjG0jXmSzenuHP7KNpaZnbz1no
 9WGbsvJ9LpS2HktpOb4bbutEWokhvMHJvIceeAWxi2bRW+Y88Up9IN6Ibo2KK3SXq5cc
 B4DjBJMS5I60FsWTUlOnN552U4CGPzcs4oP9/1HfD8lj50uVrMEFKkoMXzzYAQKcZ9gl
 tYCA==
X-Gm-Message-State: AOAM531MLCSLCYs4YTctERzmb97SrFCNqRosy7Xo66Uw+NaqnowX8Xq6
 b46v7mpF4ZPmGlU3KhEvE97pw2++gixYkcnDjUKtGe8mpFadPhCsLeGzIW/SYAC4wxbry0zvhT7
 qwY2yUPYgWCwBWM3/HjW97Q9Pv83Sfd/bLTNhpulyJg==
X-Received: by 2002:a05:6000:2c8:b0:210:ddd:170c with SMTP id
 o8-20020a05600002c800b002100ddd170cmr19414104wry.338.1653975634511; 
 Mon, 30 May 2022 22:40:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGl9FELIFTb9xFqXU89C9vQtydLRw+e/4/cFXIEETVgJhiweAwF7+L8FqRQddILAHWIYlsNg==
X-Received: by 2002:a05:6000:2c8:b0:210:ddd:170c with SMTP id
 o8-20020a05600002c800b002100ddd170cmr19414081wry.338.1653975634242; 
 Mon, 30 May 2022 22:40:34 -0700 (PDT)
Received: from redhat.com ([2.52.157.68]) by smtp.gmail.com with ESMTPSA id
 m3-20020a05600c3b0300b003942a244f2fsm1153615wms.8.2022.05.30.22.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 May 2022 22:40:33 -0700 (PDT)
Date: Tue, 31 May 2022 01:40:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v4 0/4] Implement vdpasim stop operation
Message-ID: <20220531013913-mutt-send-email-mst@kernel.org>
References: <20220526124338.36247-1-eperezma@redhat.com>
 <PH0PR12MB54819C6C6DAF6572AEADC1AEDCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220527065442-mutt-send-email-mst@kernel.org>
 <CACGkMEubfv_OJOsJ_ROgei41Qx4mPO0Xz8rMVnO8aPFiEqr8rA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEubfv_OJOsJ_ROgei41Qx4mPO0Xz8rMVnO8aPFiEqr8rA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "tanuj.kamde@amd.com" <tanuj.kamde@amd.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 "pabloc@xilinx.com" <pabloc@xilinx.com>, Eli Cohen <elic@nvidia.com>,
 Zhang Min <zhang.min9@zte.com.cn>, "lulu@redhat.com" <lulu@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
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

T24gTW9uLCBNYXkgMzAsIDIwMjIgYXQgMTE6Mzk6MjFBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBGcmksIE1heSAyNywgMjAyMiBhdCA2OjU2IFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8
bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFRodSwgTWF5IDI2LCAyMDIyIGF0IDEy
OjU0OjMyUE0gKzAwMDAsIFBhcmF2IFBhbmRpdCB3cm90ZToKPiA+ID4KPiA+ID4KPiA+ID4gPiBG
cm9tOiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiA+ID4gPiBTZW50OiBU
aHVyc2RheSwgTWF5IDI2LCAyMDIyIDg6NDQgQU0KPiA+ID4KPiA+ID4gPiBJbXBsZW1lbnQgc3Rv
cCBvcGVyYXRpb24gZm9yIHZkcGFfc2ltIGRldmljZXMsIHNvIHZob3N0LXZkcGEgd2lsbCBvZmZl
cgo+ID4gPiA+Cj4gPiA+ID4gdGhhdCBiYWNrZW5kIGZlYXR1cmUgYW5kIHVzZXJzcGFjZSBjYW4g
ZWZmZWN0aXZlbHkgc3RvcCB0aGUgZGV2aWNlLgo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPgo+ID4g
PiA+IFRoaXMgaXMgYSBtdXN0IGJlZm9yZSBnZXQgdmlydHF1ZXVlIGluZGV4ZXMgKGJhc2UpIGZv
ciBsaXZlIG1pZ3JhdGlvbiwKPiA+ID4gPgo+ID4gPiA+IHNpbmNlIHRoZSBkZXZpY2UgY291bGQg
bW9kaWZ5IHRoZW0gYWZ0ZXIgdXNlcmxhbmQgZ2V0cyB0aGVtLiBUaGVyZSBhcmUKPiA+ID4gPgo+
ID4gPiA+IGluZGl2aWR1YWwgd2F5cyB0byBwZXJmb3JtIHRoYXQgYWN0aW9uIGZvciBzb21lIGRl
dmljZXMKPiA+ID4gPgo+ID4gPiA+IChWSE9TVF9ORVRfU0VUX0JBQ0tFTkQsIFZIT1NUX1ZTT0NL
X1NFVF9SVU5OSU5HLCAuLi4pIGJ1dCB0aGVyZQo+ID4gPiA+IHdhcyBubwo+ID4gPiA+Cj4gPiA+
ID4gd2F5IHRvIHBlcmZvcm0gaXQgZm9yIGFueSB2aG9zdCBkZXZpY2UgKGFuZCwgaW4gcGFydGlj
dWxhciwgdmhvc3QtdmRwYSkuCj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gQWZ0ZXIg
dGhlIHJldHVybiBvZiBpb2N0bCB3aXRoIHN0b3AgIT0gMCwgdGhlIGRldmljZSBNVVNUIGZpbmlz
aCBhbnkKPiA+ID4gPgo+ID4gPiA+IHBlbmRpbmcgb3BlcmF0aW9ucyBsaWtlIGluIGZsaWdodCBy
ZXF1ZXN0cy4gSXQgbXVzdCBhbHNvIHByZXNlcnZlIGFsbAo+ID4gPiA+Cj4gPiA+ID4gdGhlIG5l
Y2Vzc2FyeSBzdGF0ZSAodGhlIHZpcnRxdWV1ZSB2cmluZyBiYXNlIHBsdXMgdGhlIHBvc3NpYmxl
IGRldmljZQo+ID4gPiA+Cj4gPiA+ID4gc3BlY2lmaWMgc3RhdGVzKSB0aGF0IGlzIHJlcXVpcmVk
IGZvciByZXN0b3JpbmcgaW4gdGhlIGZ1dHVyZS4gVGhlCj4gPiA+ID4KPiA+ID4gPiBkZXZpY2Ug
bXVzdCBub3QgY2hhbmdlIGl0cyBjb25maWd1cmF0aW9uIGFmdGVyIHRoYXQgcG9pbnQuCj4gPiA+
ID4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gQWZ0ZXIgdGhlIHJldHVybiBvZiBpb2N0bCB3aXRo
IHN0b3AgPT0gMCwgdGhlIGRldmljZSBjYW4gY29udGludWUKPiA+ID4gPgo+ID4gPiA+IHByb2Nl
c3NpbmcgYnVmZmVycyBhcyBsb25nIGFzIHR5cGljYWwgY29uZGl0aW9ucyBhcmUgbWV0ICh2cSBp
cyBlbmFibGVkLAo+ID4gPiA+Cj4gPiA+ID4gRFJJVkVSX09LIHN0YXR1cyBiaXQgaXMgZW5hYmxl
ZCwgZXRjKS4KPiA+ID4KPiA+ID4gSnVzdCB0byBiZSBjbGVhciwgd2UgYXJlIGFkZGluZyB2ZHBh
IGxldmVsIG5ldyBpb2N0bCgpIHRoYXQgZG9lc27igJl0IG1hcCB0byBhbnkgbWVjaGFuaXNtIGlu
IHRoZSB2aXJ0aW8gc3BlYy4KPiA+ID4KPiA+ID4gV2h5IGNhbid0IHdlIHVzZSB0aGlzIGlvY3Rs
KCkgdG8gaW5kaWNhdGUgZHJpdmVyIHRvIHN0YXJ0L3N0b3AgdGhlIGRldmljZSBpbnN0ZWFkIG9m
IGRyaXZpbmcgaXQgdGhyb3VnaCB0aGUgZHJpdmVyX29rPwo+ID4gPiBUaGlzIGlzIGluIHRoZSBj
b250ZXh0IG9mIG90aGVyIGRpc2N1c3Npb24gd2UgaGFkIGluIHRoZSBMTSBzZXJpZXMuCj4gPgo+
ID4gSWYgdGhlcmUncyBzb21ldGhpbmcgaW4gdGhlIHNwZWMgdGhhdCBkb2VzIHRoaXMgdGhlbiBs
ZXQncyB1c2UgdGhhdC4KPiAKPiBBY3R1YWxseSwgd2UgdHJ5IHRvIHByb3Bvc2UgYSBpbmRlcGVu
ZGVudCBmZWF0dXJlIGhlcmU6Cj4gCj4gaHR0cHM6Ly9saXN0cy5vYXNpcy1vcGVuLm9yZy9hcmNo
aXZlcy92aXJ0aW8tZGV2LzIwMjExMS9tc2cwMDAyMC5odG1sCj4gCj4gRG9lcyBpdCBtYWtlIHNl
bnNlIHRvIHlvdT8KPiAKPiBUaGFua3MKCkJ1dCBJIHRob3VnaHQgdGhlIExNIHBhdGNoZXMgYXJl
IHRyeWluZyB0byByZXBsYWNlIGFsbCB0aGF0PwoKCj4gPiBVbmZvcnR1bmF0ZWx5IHRoZSBMTSBz
ZXJpZXMgc2VlbXMgdG8gYmUgc3R1Y2sgb24gbW92aW5nCj4gPiBiaXRzIGFyb3VuZCB3aXRoIHRo
ZSBhZG1pbiB2aXJ0cXVldWUgLi4uCj4gPgo+ID4gLS0KPiA+IE1TVAo+ID4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
