Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FAB8C433EF
	for <virtualization@archiver.kernel.org>; Mon, 30 May 2022 03:39:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1908140C01;
	Mon, 30 May 2022 03:39:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fFF8tO-T8ynC; Mon, 30 May 2022 03:39:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id ACCF940C03;
	Mon, 30 May 2022 03:39:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E6A1C0032;
	Mon, 30 May 2022 03:39:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E998C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 03:39:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 47AE140C08
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 03:39:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kf4PiwouUltr
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 03:39:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1FD5840C0B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 03:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653881977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FdZG8wd/mfaE1rIlJ69hB8EXyZHW/gHoxx+VKCUjuys=;
 b=ZpxnMyztrZ/XJRsT/N8cgNIxwT4fkBfyfolrDRN+JxuTys+ShDfQw40Gnkx/iNQyR2JK5f
 ch/3fQ/3DBh4pZuyTmhNDS3s7vY+Epwnh6EVA5i4iRcQ+4tha0CViHzMmTTQB+bL0mKGEj
 EhsByTEpPSw7fhS5RIsvs4lL1+80kpA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-UuQxoRReNAeJhTDIXD8hDg-1; Sun, 29 May 2022 23:39:34 -0400
X-MC-Unique: UuQxoRReNAeJhTDIXD8hDg-1
Received: by mail-lf1-f72.google.com with SMTP id
 b2-20020a0565120b8200b00477a4532448so4618880lfv.22
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 May 2022 20:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FdZG8wd/mfaE1rIlJ69hB8EXyZHW/gHoxx+VKCUjuys=;
 b=y/NrMyvApx2uMS6R1aMlV5OqEoSbmxzq1DG9dZQw3TXji03gluhY7lq/fqjg7+2ROI
 PNuxTcXNxBf1/2oCSVVdcDbmfxCO99z7zW8qkKBuSafH1HnKC5b0X5v2A9lWkQWQPkGb
 +jv0f3ypqovNdaCbqYLB4kLo3B/YfqhnMmEJ7T+yQQagZDmLtvVd5L1aTlSzOWHhLd5o
 g1YugmUomcke6dBsLLibVq8XW4DJABLuUGo5g8cnAHmyeNvzkCUvq8pxXvHjMepEWBf7
 srOdoFQsdK5XstzqNW378voEZLZhsCcjOgygkc4kcd/2pBKilEJi88hEypyFsuo7bvaj
 4cQg==
X-Gm-Message-State: AOAM533pBi19ANN5QWgKIlbRhatPuKjaJiA9Nei6rSC1FgVVuHE0xXjf
 SYg20MNYwC46isA2EOSMS0BJTAnwScrvaIr0q756rrZECqmilem+9631HunooAfFom6pgT/HVSq
 6SBXJ+hfSIMMSfVdjoKi8zjp8STl5R7kUuuR249jvW14trAUsq49euJGzeg==
X-Received: by 2002:a2e:bd85:0:b0:250:9bf2:8e27 with SMTP id
 o5-20020a2ebd85000000b002509bf28e27mr31984325ljq.177.1653881972999; 
 Sun, 29 May 2022 20:39:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJ+6zqmnNnl7EEnXkdvxuYG8LYk8erHBazoZjoQnAG/qmTMJwUD0nMIgF2AK7TVkQU1NACb7Vt0qIrH9A2MBc=
X-Received: by 2002:a2e:bd85:0:b0:250:9bf2:8e27 with SMTP id
 o5-20020a2ebd85000000b002509bf28e27mr31984290ljq.177.1653881972697; Sun, 29
 May 2022 20:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220526124338.36247-1-eperezma@redhat.com>
 <PH0PR12MB54819C6C6DAF6572AEADC1AEDCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220527065442-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220527065442-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 30 May 2022 11:39:21 +0800
Message-ID: <CACGkMEubfv_OJOsJ_ROgei41Qx4mPO0Xz8rMVnO8aPFiEqr8rA@mail.gmail.com>
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

T24gRnJpLCBNYXkgMjcsIDIwMjIgYXQgNjo1NiBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIFRodSwgTWF5IDI2LCAyMDIyIGF0IDEyOjU0OjMyUE0g
KzAwMDAsIFBhcmF2IFBhbmRpdCB3cm90ZToKPiA+Cj4gPgo+ID4gPiBGcm9tOiBFdWdlbmlvIFDD
qXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiA+ID4gU2VudDogVGh1cnNkYXksIE1heSAyNiwg
MjAyMiA4OjQ0IEFNCj4gPgo+ID4gPiBJbXBsZW1lbnQgc3RvcCBvcGVyYXRpb24gZm9yIHZkcGFf
c2ltIGRldmljZXMsIHNvIHZob3N0LXZkcGEgd2lsbCBvZmZlcgo+ID4gPgo+ID4gPiB0aGF0IGJh
Y2tlbmQgZmVhdHVyZSBhbmQgdXNlcnNwYWNlIGNhbiBlZmZlY3RpdmVseSBzdG9wIHRoZSBkZXZp
Y2UuCj4gPiA+Cj4gPiA+Cj4gPiA+Cj4gPiA+IFRoaXMgaXMgYSBtdXN0IGJlZm9yZSBnZXQgdmly
dHF1ZXVlIGluZGV4ZXMgKGJhc2UpIGZvciBsaXZlIG1pZ3JhdGlvbiwKPiA+ID4KPiA+ID4gc2lu
Y2UgdGhlIGRldmljZSBjb3VsZCBtb2RpZnkgdGhlbSBhZnRlciB1c2VybGFuZCBnZXRzIHRoZW0u
IFRoZXJlIGFyZQo+ID4gPgo+ID4gPiBpbmRpdmlkdWFsIHdheXMgdG8gcGVyZm9ybSB0aGF0IGFj
dGlvbiBmb3Igc29tZSBkZXZpY2VzCj4gPiA+Cj4gPiA+IChWSE9TVF9ORVRfU0VUX0JBQ0tFTkQs
IFZIT1NUX1ZTT0NLX1NFVF9SVU5OSU5HLCAuLi4pIGJ1dCB0aGVyZQo+ID4gPiB3YXMgbm8KPiA+
ID4KPiA+ID4gd2F5IHRvIHBlcmZvcm0gaXQgZm9yIGFueSB2aG9zdCBkZXZpY2UgKGFuZCwgaW4g
cGFydGljdWxhciwgdmhvc3QtdmRwYSkuCj4gPiA+Cj4gPiA+Cj4gPiA+Cj4gPiA+IEFmdGVyIHRo
ZSByZXR1cm4gb2YgaW9jdGwgd2l0aCBzdG9wICE9IDAsIHRoZSBkZXZpY2UgTVVTVCBmaW5pc2gg
YW55Cj4gPiA+Cj4gPiA+IHBlbmRpbmcgb3BlcmF0aW9ucyBsaWtlIGluIGZsaWdodCByZXF1ZXN0
cy4gSXQgbXVzdCBhbHNvIHByZXNlcnZlIGFsbAo+ID4gPgo+ID4gPiB0aGUgbmVjZXNzYXJ5IHN0
YXRlICh0aGUgdmlydHF1ZXVlIHZyaW5nIGJhc2UgcGx1cyB0aGUgcG9zc2libGUgZGV2aWNlCj4g
PiA+Cj4gPiA+IHNwZWNpZmljIHN0YXRlcykgdGhhdCBpcyByZXF1aXJlZCBmb3IgcmVzdG9yaW5n
IGluIHRoZSBmdXR1cmUuIFRoZQo+ID4gPgo+ID4gPiBkZXZpY2UgbXVzdCBub3QgY2hhbmdlIGl0
cyBjb25maWd1cmF0aW9uIGFmdGVyIHRoYXQgcG9pbnQuCj4gPiA+Cj4gPiA+Cj4gPiA+Cj4gPiA+
IEFmdGVyIHRoZSByZXR1cm4gb2YgaW9jdGwgd2l0aCBzdG9wID09IDAsIHRoZSBkZXZpY2UgY2Fu
IGNvbnRpbnVlCj4gPiA+Cj4gPiA+IHByb2Nlc3NpbmcgYnVmZmVycyBhcyBsb25nIGFzIHR5cGlj
YWwgY29uZGl0aW9ucyBhcmUgbWV0ICh2cSBpcyBlbmFibGVkLAo+ID4gPgo+ID4gPiBEUklWRVJf
T0sgc3RhdHVzIGJpdCBpcyBlbmFibGVkLCBldGMpLgo+ID4KPiA+IEp1c3QgdG8gYmUgY2xlYXIs
IHdlIGFyZSBhZGRpbmcgdmRwYSBsZXZlbCBuZXcgaW9jdGwoKSB0aGF0IGRvZXNu4oCZdCBtYXAg
dG8gYW55IG1lY2hhbmlzbSBpbiB0aGUgdmlydGlvIHNwZWMuCj4gPgo+ID4gV2h5IGNhbid0IHdl
IHVzZSB0aGlzIGlvY3RsKCkgdG8gaW5kaWNhdGUgZHJpdmVyIHRvIHN0YXJ0L3N0b3AgdGhlIGRl
dmljZSBpbnN0ZWFkIG9mIGRyaXZpbmcgaXQgdGhyb3VnaCB0aGUgZHJpdmVyX29rPwo+ID4gVGhp
cyBpcyBpbiB0aGUgY29udGV4dCBvZiBvdGhlciBkaXNjdXNzaW9uIHdlIGhhZCBpbiB0aGUgTE0g
c2VyaWVzLgo+Cj4gSWYgdGhlcmUncyBzb21ldGhpbmcgaW4gdGhlIHNwZWMgdGhhdCBkb2VzIHRo
aXMgdGhlbiBsZXQncyB1c2UgdGhhdC4KCkFjdHVhbGx5LCB3ZSB0cnkgdG8gcHJvcG9zZSBhIGlu
ZGVwZW5kZW50IGZlYXR1cmUgaGVyZToKCmh0dHBzOi8vbGlzdHMub2FzaXMtb3Blbi5vcmcvYXJj
aGl2ZXMvdmlydGlvLWRldi8yMDIxMTEvbXNnMDAwMjAuaHRtbAoKRG9lcyBpdCBtYWtlIHNlbnNl
IHRvIHlvdT8KClRoYW5rcwoKPiBVbmZvcnR1bmF0ZWx5IHRoZSBMTSBzZXJpZXMgc2VlbXMgdG8g
YmUgc3R1Y2sgb24gbW92aW5nCj4gYml0cyBhcm91bmQgd2l0aCB0aGUgYWRtaW4gdmlydHF1ZXVl
IC4uLgo+Cj4gLS0KPiBNU1QKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
