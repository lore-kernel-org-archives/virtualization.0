Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC43DC433F5
	for <virtualization@archiver.kernel.org>; Fri, 27 May 2022 10:56:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 455C04134F;
	Fri, 27 May 2022 10:56:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RQrto7cpbN-I; Fri, 27 May 2022 10:56:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D8FBA41349;
	Fri, 27 May 2022 10:55:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98CC8C0032;
	Fri, 27 May 2022 10:55:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DF0DC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 10:55:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5637441349
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 10:55:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gcJ_hzy-Izef
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 10:55:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9EBC14056C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 10:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653648956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gGQcppmnDaS/J3TRXiziyA5gL0rtQs0/Sd1uzUmYxEU=;
 b=TX/g3FXr8yz7Z4SKaqizhItgcvzPTwiWs0UnO8RLql2ZHXLrE2lKFmltLJ5ce6ogyCaDhz
 ouvtKFLXGk4YeaN6GwgYLwfU/yQCE1a5tCf2rYiwgU5NI2oGD3uAQplMj+KX0jiUH9ITDp
 5O/lrqM8QeB445XnLCX8/8ysK6lxKYQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505-EoaRmsEIPXa6tO0h_FvDzA-1; Fri, 27 May 2022 06:55:55 -0400
X-MC-Unique: EoaRmsEIPXa6tO0h_FvDzA-1
Received: by mail-ed1-f71.google.com with SMTP id
 r10-20020aa7c14a000000b0042bcc99e4cdso2827466edp.18
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 03:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=gGQcppmnDaS/J3TRXiziyA5gL0rtQs0/Sd1uzUmYxEU=;
 b=BgrHCKA5OsgqJKpX2QlJW5HoVEJieJqpi4K7GSBnMSphFq07vm8GetfySPPPkj48++
 otbEi6QPAjJP2jHnMIUF6AfNPtv9qHu1B+tMiPolaOSqdiJPk7Daq9myd5UMobfxGjoi
 P2tuTX0v0fBIYrn7SwibROULtIuHKhNsMAlKhTpmWE6kM3Z+hmkhObkd9FgJ7UwnNYBY
 r4KlJ3zZNA5EkNB/+PKizmmOP7wWce0A7O7JCuKuRfHyCtb59yIfV/HNi4kxClgrMqx/
 UWGhAKu2lnu8bTTyIRrImhYeTw7W/jgICd6pEVW6s5yZdo1L3P4vfQrimB7Pj4mWlZDd
 64ZQ==
X-Gm-Message-State: AOAM533DybZnzwL9zRsG5LX6yicH0mXOxwW55XvsABG2A9rKfpiewKOx
 LmGkbj1+glSrN1EJqiR0N6iwHYaul2psb9L1XW1ztrMISRBId2hI1r7yMd381scMKgscYtZ9LuQ
 K6b1BKRRJmdnNE2/xZ0/C02L50Iy8Jat4ywl+hELrcA==
X-Received: by 2002:a17:907:8a03:b0:6fe:c10d:4bf8 with SMTP id
 sc3-20020a1709078a0300b006fec10d4bf8mr27371025ejc.308.1653648953916; 
 Fri, 27 May 2022 03:55:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyjSEByHUT1dN2e6dwR/wwQsgGO85W9JgRso9Wz+PFfyejclX0Yhn5dm9pxNJ4ZMKkOZKFiA==
X-Received: by 2002:a17:907:8a03:b0:6fe:c10d:4bf8 with SMTP id
 sc3-20020a1709078a0300b006fec10d4bf8mr27371006ejc.308.1653648953659; 
 Fri, 27 May 2022 03:55:53 -0700 (PDT)
Received: from redhat.com ([2.55.130.213]) by smtp.gmail.com with ESMTPSA id
 fm6-20020a1709072ac600b006fec98edf3asm1318544ejc.166.2022.05.27.03.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 May 2022 03:55:53 -0700 (PDT)
Date: Fri, 27 May 2022 06:55:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH v4 0/4] Implement vdpasim stop operation
Message-ID: <20220527065442-mutt-send-email-mst@kernel.org>
References: <20220526124338.36247-1-eperezma@redhat.com>
 <PH0PR12MB54819C6C6DAF6572AEADC1AEDCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54819C6C6DAF6572AEADC1AEDCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
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

T24gVGh1LCBNYXkgMjYsIDIwMjIgYXQgMTI6NTQ6MzJQTSArMDAwMCwgUGFyYXYgUGFuZGl0IHdy
b3RlOgo+IAo+IAo+ID4gRnJvbTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+
Cj4gPiBTZW50OiBUaHVyc2RheSwgTWF5IDI2LCAyMDIyIDg6NDQgQU0KPiAKPiA+IEltcGxlbWVu
dCBzdG9wIG9wZXJhdGlvbiBmb3IgdmRwYV9zaW0gZGV2aWNlcywgc28gdmhvc3QtdmRwYSB3aWxs
IG9mZmVyCj4gPiAKPiA+IHRoYXQgYmFja2VuZCBmZWF0dXJlIGFuZCB1c2Vyc3BhY2UgY2FuIGVm
ZmVjdGl2ZWx5IHN0b3AgdGhlIGRldmljZS4KPiA+IAo+ID4gCj4gPiAKPiA+IFRoaXMgaXMgYSBt
dXN0IGJlZm9yZSBnZXQgdmlydHF1ZXVlIGluZGV4ZXMgKGJhc2UpIGZvciBsaXZlIG1pZ3JhdGlv
biwKPiA+IAo+ID4gc2luY2UgdGhlIGRldmljZSBjb3VsZCBtb2RpZnkgdGhlbSBhZnRlciB1c2Vy
bGFuZCBnZXRzIHRoZW0uIFRoZXJlIGFyZQo+ID4gCj4gPiBpbmRpdmlkdWFsIHdheXMgdG8gcGVy
Zm9ybSB0aGF0IGFjdGlvbiBmb3Igc29tZSBkZXZpY2VzCj4gPiAKPiA+IChWSE9TVF9ORVRfU0VU
X0JBQ0tFTkQsIFZIT1NUX1ZTT0NLX1NFVF9SVU5OSU5HLCAuLi4pIGJ1dCB0aGVyZQo+ID4gd2Fz
IG5vCj4gPiAKPiA+IHdheSB0byBwZXJmb3JtIGl0IGZvciBhbnkgdmhvc3QgZGV2aWNlIChhbmQs
IGluIHBhcnRpY3VsYXIsIHZob3N0LXZkcGEpLgo+ID4gCj4gPiAKPiA+IAo+ID4gQWZ0ZXIgdGhl
IHJldHVybiBvZiBpb2N0bCB3aXRoIHN0b3AgIT0gMCwgdGhlIGRldmljZSBNVVNUIGZpbmlzaCBh
bnkKPiA+IAo+ID4gcGVuZGluZyBvcGVyYXRpb25zIGxpa2UgaW4gZmxpZ2h0IHJlcXVlc3RzLiBJ
dCBtdXN0IGFsc28gcHJlc2VydmUgYWxsCj4gPiAKPiA+IHRoZSBuZWNlc3Nhcnkgc3RhdGUgKHRo
ZSB2aXJ0cXVldWUgdnJpbmcgYmFzZSBwbHVzIHRoZSBwb3NzaWJsZSBkZXZpY2UKPiA+IAo+ID4g
c3BlY2lmaWMgc3RhdGVzKSB0aGF0IGlzIHJlcXVpcmVkIGZvciByZXN0b3JpbmcgaW4gdGhlIGZ1
dHVyZS4gVGhlCj4gPiAKPiA+IGRldmljZSBtdXN0IG5vdCBjaGFuZ2UgaXRzIGNvbmZpZ3VyYXRp
b24gYWZ0ZXIgdGhhdCBwb2ludC4KPiA+IAo+ID4gCj4gPiAKPiA+IEFmdGVyIHRoZSByZXR1cm4g
b2YgaW9jdGwgd2l0aCBzdG9wID09IDAsIHRoZSBkZXZpY2UgY2FuIGNvbnRpbnVlCj4gPiAKPiA+
IHByb2Nlc3NpbmcgYnVmZmVycyBhcyBsb25nIGFzIHR5cGljYWwgY29uZGl0aW9ucyBhcmUgbWV0
ICh2cSBpcyBlbmFibGVkLAo+ID4gCj4gPiBEUklWRVJfT0sgc3RhdHVzIGJpdCBpcyBlbmFibGVk
LCBldGMpLgo+IAo+IEp1c3QgdG8gYmUgY2xlYXIsIHdlIGFyZSBhZGRpbmcgdmRwYSBsZXZlbCBu
ZXcgaW9jdGwoKSB0aGF0IGRvZXNu4oCZdCBtYXAgdG8gYW55IG1lY2hhbmlzbSBpbiB0aGUgdmly
dGlvIHNwZWMuCj4gCj4gV2h5IGNhbid0IHdlIHVzZSB0aGlzIGlvY3RsKCkgdG8gaW5kaWNhdGUg
ZHJpdmVyIHRvIHN0YXJ0L3N0b3AgdGhlIGRldmljZSBpbnN0ZWFkIG9mIGRyaXZpbmcgaXQgdGhy
b3VnaCB0aGUgZHJpdmVyX29rPwo+IFRoaXMgaXMgaW4gdGhlIGNvbnRleHQgb2Ygb3RoZXIgZGlz
Y3Vzc2lvbiB3ZSBoYWQgaW4gdGhlIExNIHNlcmllcy4KCklmIHRoZXJlJ3Mgc29tZXRoaW5nIGlu
IHRoZSBzcGVjIHRoYXQgZG9lcyB0aGlzIHRoZW4gbGV0J3MgdXNlIHRoYXQuClVuZm9ydHVuYXRl
bHkgdGhlIExNIHNlcmllcyBzZWVtcyB0byBiZSBzdHVjayBvbiBtb3ZpbmcKYml0cyBhcm91bmQg
d2l0aCB0aGUgYWRtaW4gdmlydHF1ZXVlIC4uLgoKLS0gCk1TVAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
