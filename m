Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4F7C433EF
	for <virtualization@archiver.kernel.org>; Tue, 31 May 2022 06:44:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D59683F24;
	Tue, 31 May 2022 06:44:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KyXVk3xxzxpR; Tue, 31 May 2022 06:44:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BEB5C83EB4;
	Tue, 31 May 2022 06:44:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 871BFC0032;
	Tue, 31 May 2022 06:44:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B385CC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 06:44:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9ADC360F81
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 06:44:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XuSpdF2PhBbt
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 06:44:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5951E60F7A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 06:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653979481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R09ZW9VvFl8cGzXr9uGNwD7esbAV/wMjvzPFPmxSk1k=;
 b=BR+oELBZSPS/Ec1CQRAH2wI4BKU93W9AJEFIboJpwaTKvhydXgJCpkN4uerAFtC/TJgIm6
 Ygxp+ujGWTNwGpuELH4iPO1WfyE2FSZxKFw8jz42LSW7X261Eqk6kRgqIfezsm/jOinjZV
 oX8SXA7ZxXW2+Sca6Ba/UNRbBm2H0fY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-NfjE10fDMJKdKxpbRqZW8Q-1; Tue, 31 May 2022 02:44:38 -0400
X-MC-Unique: NfjE10fDMJKdKxpbRqZW8Q-1
Received: by mail-lj1-f199.google.com with SMTP id
 t23-20020a2e7817000000b002555d1188bdso109480ljc.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 23:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=R09ZW9VvFl8cGzXr9uGNwD7esbAV/wMjvzPFPmxSk1k=;
 b=PmyDtTkUurzXanBcHXWYl0Lc5giIOL2hEpQL0h1CaAx9Wq5UY9fGtXx/WEKDcq1ZGZ
 ZdRj/SR/aaqNKqsYpQ9PLTStWUVbaey+geKe36tbqeWxQpG0VQr1V2CL9/i3uIsZbTFU
 uJPTmG9i4ULaoh5/eMrqIF4FX7+nHrY8+ZV/ruwM0I3BqQftoCohAMohU/9iB+XOvJN2
 bknuQn44Oqtw4qI3w2axRPO25je/KBUf9458q3LpPBXJwdASlbCjJ6BsPnTJYaQngxkU
 hcaoHVM68xC8rMh5Gy7cz5D6DKaIYBu/FurbCgGMTJwpQ9FxRZ4FuoMWX4uD0SBjy/aT
 9Lgw==
X-Gm-Message-State: AOAM531L9iojmCiOCEZK2Zf7y/m2LiZL+iEEzR5v65Vfzc4dH+8gekxT
 nxPysQswtxPJB3o3jXFaJNWWjYtwuJyKD716EQbTaEZZ42V396RijiLWDae7UU1kJcbJYTVNHUg
 vUkaNyC24+69U2Zw7BlVho6vFli8C3DggOheL3iD5+WffEMdxjTNIJonorg==
X-Received: by 2002:a05:6512:128e:b0:478:681c:18d8 with SMTP id
 u14-20020a056512128e00b00478681c18d8mr32302232lfs.190.1653979477014; 
 Mon, 30 May 2022 23:44:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzb9MwkuGePNI9NXoXjO6wTh5Ss6nTswP5TQltBWqHApUqXR5peoNrnh/Uhl83sh1tUvY9O28tBGfW9/BSXTk4=
X-Received: by 2002:a05:6512:128e:b0:478:681c:18d8 with SMTP id
 u14-20020a056512128e00b00478681c18d8mr32302209lfs.190.1653979476807; Mon, 30
 May 2022 23:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220526124338.36247-1-eperezma@redhat.com>
 <PH0PR12MB54819C6C6DAF6572AEADC1AEDCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220527065442-mutt-send-email-mst@kernel.org>
 <CACGkMEubfv_OJOsJ_ROgei41Qx4mPO0Xz8rMVnO8aPFiEqr8rA@mail.gmail.com>
 <20220531013913-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220531013913-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 31 May 2022 14:44:25 +0800
Message-ID: <CACGkMEuC29vaBPi7jDED3DzxPuZZx2hrUmtEUv4UWSdTM5AcFQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Implement vdpasim stop operation
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "tanuj.kamde@amd.com" <tanuj.kamde@amd.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
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

T24gVHVlLCBNYXkgMzEsIDIwMjIgYXQgMTo0MCBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIE1vbiwgTWF5IDMwLCAyMDIyIGF0IDExOjM5OjIxQU0g
KzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiBPbiBGcmksIE1heSAyNywgMjAyMiBhdCA2OjU2
IFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPgo+ID4g
PiBPbiBUaHUsIE1heSAyNiwgMjAyMiBhdCAxMjo1NDozMlBNICswMDAwLCBQYXJhdiBQYW5kaXQg
d3JvdGU6Cj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gRnJvbTogRXVnZW5pbyBQw6lyZXogPGVw
ZXJlem1hQHJlZGhhdC5jb20+Cj4gPiA+ID4gPiBTZW50OiBUaHVyc2RheSwgTWF5IDI2LCAyMDIy
IDg6NDQgQU0KPiA+ID4gPgo+ID4gPiA+ID4gSW1wbGVtZW50IHN0b3Agb3BlcmF0aW9uIGZvciB2
ZHBhX3NpbSBkZXZpY2VzLCBzbyB2aG9zdC12ZHBhIHdpbGwgb2ZmZXIKPiA+ID4gPiA+Cj4gPiA+
ID4gPiB0aGF0IGJhY2tlbmQgZmVhdHVyZSBhbmQgdXNlcnNwYWNlIGNhbiBlZmZlY3RpdmVseSBz
dG9wIHRoZSBkZXZpY2UuCj4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBU
aGlzIGlzIGEgbXVzdCBiZWZvcmUgZ2V0IHZpcnRxdWV1ZSBpbmRleGVzIChiYXNlKSBmb3IgbGl2
ZSBtaWdyYXRpb24sCj4gPiA+ID4gPgo+ID4gPiA+ID4gc2luY2UgdGhlIGRldmljZSBjb3VsZCBt
b2RpZnkgdGhlbSBhZnRlciB1c2VybGFuZCBnZXRzIHRoZW0uIFRoZXJlIGFyZQo+ID4gPiA+ID4K
PiA+ID4gPiA+IGluZGl2aWR1YWwgd2F5cyB0byBwZXJmb3JtIHRoYXQgYWN0aW9uIGZvciBzb21l
IGRldmljZXMKPiA+ID4gPiA+Cj4gPiA+ID4gPiAoVkhPU1RfTkVUX1NFVF9CQUNLRU5ELCBWSE9T
VF9WU09DS19TRVRfUlVOTklORywgLi4uKSBidXQgdGhlcmUKPiA+ID4gPiA+IHdhcyBubwo+ID4g
PiA+ID4KPiA+ID4gPiA+IHdheSB0byBwZXJmb3JtIGl0IGZvciBhbnkgdmhvc3QgZGV2aWNlIChh
bmQsIGluIHBhcnRpY3VsYXIsIHZob3N0LXZkcGEpLgo+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+
ID4gPgo+ID4gPiA+ID4gQWZ0ZXIgdGhlIHJldHVybiBvZiBpb2N0bCB3aXRoIHN0b3AgIT0gMCwg
dGhlIGRldmljZSBNVVNUIGZpbmlzaCBhbnkKPiA+ID4gPiA+Cj4gPiA+ID4gPiBwZW5kaW5nIG9w
ZXJhdGlvbnMgbGlrZSBpbiBmbGlnaHQgcmVxdWVzdHMuIEl0IG11c3QgYWxzbyBwcmVzZXJ2ZSBh
bGwKPiA+ID4gPiA+Cj4gPiA+ID4gPiB0aGUgbmVjZXNzYXJ5IHN0YXRlICh0aGUgdmlydHF1ZXVl
IHZyaW5nIGJhc2UgcGx1cyB0aGUgcG9zc2libGUgZGV2aWNlCj4gPiA+ID4gPgo+ID4gPiA+ID4g
c3BlY2lmaWMgc3RhdGVzKSB0aGF0IGlzIHJlcXVpcmVkIGZvciByZXN0b3JpbmcgaW4gdGhlIGZ1
dHVyZS4gVGhlCj4gPiA+ID4gPgo+ID4gPiA+ID4gZGV2aWNlIG11c3Qgbm90IGNoYW5nZSBpdHMg
Y29uZmlndXJhdGlvbiBhZnRlciB0aGF0IHBvaW50Lgo+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+
ID4gPgo+ID4gPiA+ID4gQWZ0ZXIgdGhlIHJldHVybiBvZiBpb2N0bCB3aXRoIHN0b3AgPT0gMCwg
dGhlIGRldmljZSBjYW4gY29udGludWUKPiA+ID4gPiA+Cj4gPiA+ID4gPiBwcm9jZXNzaW5nIGJ1
ZmZlcnMgYXMgbG9uZyBhcyB0eXBpY2FsIGNvbmRpdGlvbnMgYXJlIG1ldCAodnEgaXMgZW5hYmxl
ZCwKPiA+ID4gPiA+Cj4gPiA+ID4gPiBEUklWRVJfT0sgc3RhdHVzIGJpdCBpcyBlbmFibGVkLCBl
dGMpLgo+ID4gPiA+Cj4gPiA+ID4gSnVzdCB0byBiZSBjbGVhciwgd2UgYXJlIGFkZGluZyB2ZHBh
IGxldmVsIG5ldyBpb2N0bCgpIHRoYXQgZG9lc27igJl0IG1hcCB0byBhbnkgbWVjaGFuaXNtIGlu
IHRoZSB2aXJ0aW8gc3BlYy4KPiA+ID4gPgo+ID4gPiA+IFdoeSBjYW4ndCB3ZSB1c2UgdGhpcyBp
b2N0bCgpIHRvIGluZGljYXRlIGRyaXZlciB0byBzdGFydC9zdG9wIHRoZSBkZXZpY2UgaW5zdGVh
ZCBvZiBkcml2aW5nIGl0IHRocm91Z2ggdGhlIGRyaXZlcl9vaz8KPiA+ID4gPiBUaGlzIGlzIGlu
IHRoZSBjb250ZXh0IG9mIG90aGVyIGRpc2N1c3Npb24gd2UgaGFkIGluIHRoZSBMTSBzZXJpZXMu
Cj4gPiA+Cj4gPiA+IElmIHRoZXJlJ3Mgc29tZXRoaW5nIGluIHRoZSBzcGVjIHRoYXQgZG9lcyB0
aGlzIHRoZW4gbGV0J3MgdXNlIHRoYXQuCj4gPgo+ID4gQWN0dWFsbHksIHdlIHRyeSB0byBwcm9w
b3NlIGEgaW5kZXBlbmRlbnQgZmVhdHVyZSBoZXJlOgo+ID4KPiA+IGh0dHBzOi8vbGlzdHMub2Fz
aXMtb3Blbi5vcmcvYXJjaGl2ZXMvdmlydGlvLWRldi8yMDIxMTEvbXNnMDAwMjAuaHRtbAo+ID4K
PiA+IERvZXMgaXQgbWFrZSBzZW5zZSB0byB5b3U/Cj4gPgo+ID4gVGhhbmtzCj4KPiBCdXQgSSB0
aG91Z2h0IHRoZSBMTSBwYXRjaGVzIGFyZSB0cnlpbmcgdG8gcmVwbGFjZSBhbGwgdGhhdD8KCkkn
bSBub3Qgc3VyZSwgYW5kIGFjdHVhbGx5IEkgdGhpbmsgdGhleSBhcmUgb3J0aG9nb25hbC4gV2Ug
bmVlZCBhIG5ldwpzdGF0ZSBhbmQgdGhlIGNvbW1hbmQgdG8gc2V0IHRoZSBzdGF0ZSBjb3VsZCBi
ZSB0cmFuc3BvcnQgc3BlY2lmaWMgb3IKYSB2aXJ0cXVldWUuCgpBcyBmYXIgYXMgSSBrbm93LCBt
b3N0IG9mIHRoZSB2ZW5kb3JzIGhhdmUgaW1wbGVtZW50ZWQgdGhpcyBzZW1hbnRpYy4KClRoYW5r
cwoKPgo+Cj4gPiA+IFVuZm9ydHVuYXRlbHkgdGhlIExNIHNlcmllcyBzZWVtcyB0byBiZSBzdHVj
ayBvbiBtb3ZpbmcKPiA+ID4gYml0cyBhcm91bmQgd2l0aCB0aGUgYWRtaW4gdmlydHF1ZXVlIC4u
Lgo+ID4gPgo+ID4gPiAtLQo+ID4gPiBNU1QKPiA+ID4KPgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
