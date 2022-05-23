Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440A9C433F5
	for <virtualization@archiver.kernel.org>; Mon, 23 May 2022 03:41:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B9F9E417FA;
	Mon, 23 May 2022 03:41:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xTC6CqAzP-1z; Mon, 23 May 2022 03:41:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0B11C4179B;
	Mon, 23 May 2022 03:41:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBBFAC0039;
	Mon, 23 May 2022 03:41:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7E6FC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 03:41:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 980B2417B0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 03:41:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CNCvyV3eD97h
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 03:41:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7D1004179B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 03:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653277285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Fd0SMNTXnwlHuNSnHZJwk3v/0xk+KRZ87SrUXvtJY8=;
 b=N34hYFcvsNtYmnrqXztD7Sto5dGZjgvmFPY4zEfpDVRI0ytKy0XGYzsYiNNT0vPVFdoTkG
 a6LJZDl45Aj0KhHxzP5llTg5/DV4+wpcsdeXfiAUjedv481lvB7S4cs80bJRVaeuSflWCK
 dvABc5cmy3NZRzg+bMjNCEE+5AdBCic=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-w319xvuKNeGBXfcR-wm98w-1; Sun, 22 May 2022 23:41:24 -0400
X-MC-Unique: w319xvuKNeGBXfcR-wm98w-1
Received: by mail-lf1-f70.google.com with SMTP id
 bq17-20020a056512151100b0047867d569d8so1471779lfb.12
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 May 2022 20:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+Fd0SMNTXnwlHuNSnHZJwk3v/0xk+KRZ87SrUXvtJY8=;
 b=Qf3VvtL/pB8gSp8reK2RXVg3+mdjUCEpi58sBQ6p6nKo9BERIqHZdGuMX2okWt7eIA
 uBcptGVoZgjfalo8Qhx9cKyN20FrSf8tvxC4rdc9IY0omNJFarRxtjf2WkZISIDGTycW
 Ly34Cn/nrAN5AD7FloITBHV++4O8wiJ6FjKUVD62SK12794EZu1BR+aNuPcOvN/Jm8pE
 lHUAZ1/Bufx0q70Ob48k4GeuAVnNuABddMYJVp/7WfXBApA5ZdSvwr69TCVFeTwFbzDV
 S++NAkZYGxkg+8yNXaDxPvq1fTM2W89nIqd72VqSCaOqW1TwecwXNjskygj5okk07NrV
 3IpQ==
X-Gm-Message-State: AOAM532avWjVx3u9ord15Db7+Q45viILADNe4bEaqxUAmPEaOW0ANJS2
 CwvIVpHQ7DjM141kxgQmadjj9SCf+UZzabn0wm2geslhJu82P0qsuu3KKazQX9r82xHIDlseOXB
 6WRCPQc8mUgV7e1NOBvt+hb/H+tOuSclPGaP8cG3JpzsM7AwsXBu/6zRpNg==
X-Received: by 2002:a05:6512:39d2:b0:478:5ad6:1989 with SMTP id
 k18-20020a05651239d200b004785ad61989mr8622223lfu.98.1653277282623; 
 Sun, 22 May 2022 20:41:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWPOesnVvxBxBkgbZ6niqJzDMw4DefLTzIYaM/8utiK0NIrinB7lm7xG/G7VLj6SjeH6tBDdA9lpOSJS3PD0E=
X-Received: by 2002:a05:6512:39d2:b0:478:5ad6:1989 with SMTP id
 k18-20020a05651239d200b004785ad61989mr8622210lfu.98.1653277282437; Sun, 22
 May 2022 20:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220516060342.106-1-xieyongji@bytedance.com>
 <20220516060342.106-2-xieyongji@bytedance.com>
 <PH0PR12MB54813F96E346D591FBE238C1DCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACycT3sRc4bk+3oq7FLzpBMCG_XRN7tOaeEAtNg69o3h8c3=EA@mail.gmail.com>
 <PH0PR12MB5481AD3C1517331EAC4EE078DCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <YoOpBaWcaoujWqO7@kroah.com>
 <PH0PR12MB54819F4E48BE36460BC89457DCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <28a689dc-a9de-ca1f-6b9f-26c735e96781@redhat.com>
 <PH0PR12MB54817B6BE5796E237A50FB2FDCD49@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54817B6BE5796E237A50FB2FDCD49@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 23 May 2022 11:41:11 +0800
Message-ID: <CACGkMEvrekJFMFLpgUHZ7HOTed7oRSt4Mv2ASUHLNC3ZCs-NEA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] vdpa: Add a device object for vdpa management
 device
To: Parav Pandit <parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "mst@redhat.com" <mst@redhat.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Yongji Xie <xieyongji@bytedance.com>,
 "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>, Eli Cohen <elic@nvidia.com>
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

T24gTW9uLCBNYXkgMjMsIDIwMjIgYXQgMTA6MDAgQU0gUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlk
aWEuY29tPiB3cm90ZToKPgo+Cj4gPiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPgo+ID4gU2VudDogV2VkbmVzZGF5LCBNYXkgMTgsIDIwMjIgNDozMiBBTQo+ID4KPiA+IOWc
qCAyMDIyLzUvMTggMDc6MDMsIFBhcmF2IFBhbmRpdCDlhpnpgZM6Cj4gPiA+Pj4gQW5kIHJlZ2Fy
ZGluZyB2ZHVzZV9kZXZfcmVsZWFzZSgpIGFuZCBleGlzdGluZyBlbXB0eSByZWxlYXNlCj4gPiA+
Pj4gZnVuY3Rpb24sCj4gPiA+PiB0aGV5IGNhbiBiZSBkeW5hbWljYWxseSBhbGxvY2F0ZWQuCj4g
PiA+Pj4gVGhpcyBpcyBiZWNhdXNlIHRoZXkgYXJlIHJlYWxseSB0aGUgc3RydWN0IGRldmljZS4K
PiA+ID4+IEkgZG8gbm90IHVuZGVyc3RhbmQgdGhpcyBzdGF0ZW1lbnQsIHNvcnJ5Lgo+ID4gPiBJ
dCB3YXMgYmFkIHNlbnRlbmNlLCBteSBiYWQuCj4gPiA+Cj4gPiA+IFdoYXQgSSB3YW50ZWQgdG8g
c2F5IGlzLCBwcm9iYWJseSBiZXR0ZXIgZXhwbGFpbmVkIHdpdGggcmVhbCBwYXRjaCBiZWxvdy4K
PiA+ID4gSW4gY29udGV4dCBvZiBbMV0sIHN0cnVjdCB2ZHVzZV9tZ210ZGV2IGVtcHR5IHJlbGVh
c2UgZnVuY3Rpb24gY2FuIGJlCj4gPiBhdm9pZGVkIGJ5IGJlbG93IGlubGluZSBwYXRjaCBbMl0u
Cj4gPiA+Cj4gPiA+IFsxXWh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2xpbnV4LXZpcnR1
YWxpemF0aW9uL21zZzU2MzcxLmh0bWwKPiA+ID4KPiA+ID4gWzJdIHBhdGNoOgo+ID4KPiA+Cj4g
PiBPaywgaWYgd2UgZ28gdGhpcyB3YXkgKGxvb2tzIG1vcmUgbGlrZSBtZGV2X3BhcmVudCkuIEkg
dGhpbmsgd2UgbmVlZCBhdCBsZWFzdAo+ID4gcmVuYW1lIHRoZSB2ZHBhX21nbXRfZGV2aWNlLCBt
YXliZSB2ZHBhX3BhcmVudCAobGlrZSBtZGV2X3BhcmVudCk/Cj4gPgo+IEl0IGNhbiBiZS4KPiBQ
YXJlbnQgaXMgYWxzbyBhIGRldmljZS4gU28uLi4KCkhvdyBhYm91dCAidmRwYV9wYXJlbnRfZGF0
YSI/IE5vdCBhIG5hdGl2ZSBzcGVha2VyIGJ1dCBpdCdzIGJldHRlciB0bwpyZW1vdmUgImRldmlj
ZSIgZnJvbSB0aGUgbmFtZSBhbmhvdy4KClRoYW5rcwoKPiBTaW5jZSB0aGVyZSBhcmUgbm8gZnVy
dGhlciBjb21tZW50cyBvbiB0aGUgaW5saW5lIHBhdGNoLCBJIHdpbGwgc2VuZCBpdCBhcyBzZXBh
cmF0ZSBwYXRjaCB0aGlzIHdlZWsuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
