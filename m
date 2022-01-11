Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F14C43217
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 11:55:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1027960D75;
	Tue, 11 Jan 2022 11:55:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LvFO2bhTkSUQ; Tue, 11 Jan 2022 11:55:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5D88860AF0;
	Tue, 11 Jan 2022 11:55:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E71DAC0071;
	Tue, 11 Jan 2022 11:55:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A1B8C0030
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 11:55:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 12B0240143
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 11:55:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pxDoHA-vKGL9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 11:54:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9FA7540133
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 11:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641902098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L8tUAuU3sx4wnqm2mHqp+w//Djo25ItZNH0jpA9WCOg=;
 b=fvVubD2L5qj789jjw5XpMDfyKXoz8HR0L83Fmzh1pLig9J/8Uj8KyaWJpRSpONKNuWi4qL
 oCG6Q9c2LIpK7ma6Gc7wAXjIDlHH7SIgwhV2x4/6fOb909dU6xyNLmL+c1xOpu/N+lxWN0
 /2cwwqiB0mPih4do6DhjjJoVGoLxPr8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-YIbB7MP3PE2nhXwOQ1n9_Q-1; Tue, 11 Jan 2022 06:54:56 -0500
X-MC-Unique: YIbB7MP3PE2nhXwOQ1n9_Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 c5-20020a1c3505000000b00345c92c27c6so1423250wma.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 03:54:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=L8tUAuU3sx4wnqm2mHqp+w//Djo25ItZNH0jpA9WCOg=;
 b=UnMl4aB7nyxMkAmt7diQtiSvvOIQfnh4SXVS71+sYCt/v1FnOmTa8CGzQ2wPjyJeW3
 lLIlrtwFauoYdRJIZN2OMGBdCFgsuMPVrz66kkXWoj6GAWq4EmPpZcnYB6u8CShkhFnn
 Tki9bOk7ed1aB42bxtYoGIf6NJvzW7apuWjGJWLxp9vkLiGLNHKYsYnMElxjUbtiBak7
 gr90RhQpCpHHZXfIUkttJ2GhoyI+kNWMli/ocIo8zflj9X2ZEVUsBtcOgDUSsFgK+u7n
 2D6xAn+qMDXA86IGOxeLuHbjc/ic9embwsUdpAdn0bHPCl6NVOXnFOk64sCEKQZSGZ6z
 C1mA==
X-Gm-Message-State: AOAM533dq5ZKZsHIr0r18L6Zx3os0EgHD1MjVQCaxgPFGsI403JWFS9q
 5oOgANKljlS6+S32Ust3qoQRgaq2gNl1HkRIJ1F9Vp/KtDSO9amFnux2islq1AbKrR0XN4gfekm
 Mo/A4cpb7hGh/dIBQxZRp8C7nxp7AnK852oYIAaKG/w==
X-Received: by 2002:a05:6000:184f:: with SMTP id
 c15mr3548896wri.73.1641902094775; 
 Tue, 11 Jan 2022 03:54:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxMB9cKDt3oBelm1sFftDwQwVLNcfaNRNRFFSf7NuXogZYA8px0qiu/L2gStlBR5LFyvB4wcw==
X-Received: by 2002:a05:6000:184f:: with SMTP id
 c15mr3548846wri.73.1641902094469; 
 Tue, 11 Jan 2022 03:54:54 -0800 (PST)
Received: from redhat.com ([2.55.5.100])
 by smtp.gmail.com with ESMTPSA id f10sm1710595wmg.43.2022.01.11.03.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jan 2022 03:54:53 -0800 (PST)
Date: Tue, 11 Jan 2022 06:54:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v12 00/13] Introduce VDUSE - vDPA Device in Userspace
Message-ID: <20220111065301-mutt-send-email-mst@kernel.org>
References: <20210830141737.181-1-xieyongji@bytedance.com>
 <20220110075546-mutt-send-email-mst@kernel.org>
 <CACycT3v1aEViw7vV4x5qeGVPrSrO-BTDvQshEX35rx_X0Au2vw@mail.gmail.com>
 <20220110100911-mutt-send-email-mst@kernel.org>
 <CACycT3v6jo3-8ATWUzf659vV94a2oRrm-zQtGNDZd6OQr-MENA@mail.gmail.com>
 <20220110103938-mutt-send-email-mst@kernel.org>
 <CACycT3sbJC1Jn7NeWk_ccQ_2_YgKybjugfxmKpfgCP3Ayoju4w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3sbJC1Jn7NeWk_ccQ_2_YgKybjugfxmKpfgCP3Ayoju4w@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm <kvm@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 joro@8bytes.org, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>, John Garry <john.garry@huawei.com>,
 Liu Xiaodong <xiaodong.liu@intel.com>, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>,
 songmuchun@bytedance.com, Jens Axboe <axboe@kernel.dk>,
 He Zhe <zhe.he@windriver.com>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, Netdev <netdev@vger.kernel.org>, Joe Perches <joe@perches.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>
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

T24gVHVlLCBKYW4gMTEsIDIwMjIgYXQgMTE6MzE6MzdBTSArMDgwMCwgWW9uZ2ppIFhpZSB3cm90
ZToKPiBPbiBNb24sIEphbiAxMCwgMjAyMiBhdCAxMTo0NCBQTSBNaWNoYWVsIFMuIFRzaXJraW4g
PG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBNb24sIEphbiAxMCwgMjAyMiBhdCAx
MToyNDo0MFBNICswODAwLCBZb25namkgWGllIHdyb3RlOgo+ID4gPiBPbiBNb24sIEphbiAxMCwg
MjAyMiBhdCAxMToxMCBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90
ZToKPiA+ID4gPgo+ID4gPiA+IE9uIE1vbiwgSmFuIDEwLCAyMDIyIGF0IDA5OjU0OjA4UE0gKzA4
MDAsIFlvbmdqaSBYaWUgd3JvdGU6Cj4gPiA+ID4gPiBPbiBNb24sIEphbiAxMCwgMjAyMiBhdCA4
OjU3IFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiBPbiBNb24sIEF1ZyAzMCwgMjAyMSBhdCAxMDoxNzoyNFBNICswODAw
LCBYaWUgWW9uZ2ppIHdyb3RlOgo+ID4gPiA+ID4gPiA+IFRoaXMgc2VyaWVzIGludHJvZHVjZXMg
YSBmcmFtZXdvcmsgdGhhdCBtYWtlcyBpdCBwb3NzaWJsZSB0byBpbXBsZW1lbnQKPiA+ID4gPiA+
ID4gPiBzb2Z0d2FyZS1lbXVsYXRlZCB2RFBBIGRldmljZXMgaW4gdXNlcnNwYWNlLiBBbmQgdG8g
bWFrZSB0aGUgZGV2aWNlCj4gPiA+ID4gPiA+ID4gZW11bGF0aW9uIG1vcmUgc2VjdXJlLCB0aGUg
ZW11bGF0ZWQgdkRQQSBkZXZpY2UncyBjb250cm9sIHBhdGggaXMgaGFuZGxlZAo+ID4gPiA+ID4g
PiA+IGluIHRoZSBrZXJuZWwgYW5kIG9ubHkgdGhlIGRhdGEgcGF0aCBpcyBpbXBsZW1lbnRlZCBp
biB0aGUgdXNlcnNwYWNlLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gU2luY2UgdGhlIGVt
dWxkYXRlZCB2RFBBIGRldmljZSdzIGNvbnRyb2wgcGF0aCBpcyBoYW5kbGVkIGluIHRoZSBrZXJu
ZWwsCj4gPiA+ID4gPiA+ID4gYSBtZXNzYWdlIG1lY2huaXNtIGlzIGludHJvZHVjZWQgdG8gbWFr
ZSB1c2Vyc3BhY2UgYmUgYXdhcmUgb2YgdGhlIGRhdGEKPiA+ID4gPiA+ID4gPiBwYXRoIHJlbGF0
ZWQgY2hhbmdlcy4gVXNlcnNwYWNlIGNhbiB1c2UgcmVhZCgpL3dyaXRlKCkgdG8gcmVjZWl2ZS9y
ZXBseQo+ID4gPiA+ID4gPiA+IHRoZSBjb250cm9sIG1lc3NhZ2VzLgo+ID4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+ID4gSW4gdGhlIGRhdGEgcGF0aCwgdGhlIGNvcmUgaXMgbWFwcGluZyBkbWEgYnVm
ZmVyIGludG8gVkRVU0UgZGFlbW9uJ3MKPiA+ID4gPiA+ID4gPiBhZGRyZXNzIHNwYWNlLCB3aGlj
aCBjYW4gYmUgaW1wbGVtZW50ZWQgaW4gZGlmZmVyZW50IHdheXMgZGVwZW5kaW5nIG9uCj4gPiA+
ID4gPiA+ID4gdGhlIHZkcGEgYnVzIHRvIHdoaWNoIHRoZSB2RFBBIGRldmljZSBpcyBhdHRhY2hl
ZC4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IEluIHZpcnRpby12ZHBhIGNhc2UsIHdlIGlt
cGxlbWVudHMgYSBNTVUtYmFzZWQgc29mdHdhcmUgSU9UTEIgd2l0aAo+ID4gPiA+ID4gPiA+IGJv
dW5jZS1idWZmZXJpbmcgbWVjaGFuaXNtIHRvIGFjaGlldmUgdGhhdC4gQW5kIGluIHZob3N0LXZk
cGEgY2FzZSwgdGhlIGRtYQo+ID4gPiA+ID4gPiA+IGJ1ZmZlciBpcyByZXNpZGUgaW4gYSB1c2Vy
c3BhY2UgbWVtb3J5IHJlZ2lvbiB3aGljaCBjYW4gYmUgc2hhcmVkIHRvIHRoZQo+ID4gPiA+ID4g
PiA+IFZEVVNFIHVzZXJzcGFjZSBwcm9jZXNzcyB2aWEgdHJhbnNmZXJyaW5nIHRoZSBzaG1mZC4K
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IFRoZSBkZXRhaWxzIGFuZCBvdXIgdXNlciBjYXNl
IGlzIHNob3duIGJlbG93Ogo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gICAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gPiA+ID4gPiA+ID4gfCAgICAgICAg
ICAgIENvbnRhaW5lciB8ICAgIHwgICAgICAgICAgICAgIFFFTVUoVk0pIHwgICB8ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFZEVVNFIGRhZW1vbiB8Cj4gPiA+ID4gPiA+ID4gfCAgICAg
ICAtLS0tLS0tLS0gICAgICB8ICAgIHwgIC0tLS0tLS0tLS0tLS0tLS0tLS0gIHwgICB8IC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0gLS0tLS0tLS0tLS0tLS0tLSB8Cj4gPiA+ID4gPiA+ID4gfCAg
ICAgICB8ZGV2L3ZkeHwgICAgICB8ICAgIHwgIHwvZGV2L3Zob3N0LXZkcGEteHwgIHwgICB8IHwg
dkRQQSBkZXZpY2UgZW11bGF0aW9uIHwgfCBibG9jayBkcml2ZXIgfCB8Cj4gPiA+ID4gPiA+ID4g
LS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tICAgICAtLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0gICAt
LS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tCj4gPiA+ID4gPiA+
ID4gICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICB8Cj4gPiA+ID4gPiA+ID4gICAg
ICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICB8Cj4gPiA+ID4gPiA+ID4gLS0tLS0tLS0t
LS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tCj4gPiA+ID4gPiA+ID4gfCAgICB8
IGJsb2NrIGRldmljZSB8ICAgICAgICAgICB8ICB2aG9zdCBkZXZpY2UgfCAgICAgICAgICAgIHwg
dmR1c2UgZHJpdmVyIHwgICAgICAgICAgfCBUQ1AvSVAgfCAgICB8Cj4gPiA+ID4gPiA+ID4gfCAg
ICAtLS0tLS0tKy0tLS0tLS0tICAgICAgICAgICAtLS0tLS0tLSstLS0tLS0tLSAgICAgICAgICAg
IC0tLS0tLS0rLS0tLS0tLS0gICAgICAgICAgLS0tLS0rLS0tLSAgICB8Cj4gPiA+ID4gPiA+ID4g
fCAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICB8Cj4gPiA+ID4gPiA+
ID4gfCAtLS0tLS0tLS0tKy0tLS0tLS0tLS0gICAgICAgLS0tLS0tLS0tLSstLS0tLS0tLS0tLSAg
ICAgICAgIC0tLS0tLS0rLS0tLS0tLSAgICAgICAgICAgICAgICB8ICAgICAgICB8Cj4gPiA+ID4g
PiA+ID4gfCB8IHZpcnRpby1ibGsgZHJpdmVyIHwgICAgICAgfCAgdmhvc3QtdmRwYSBkcml2ZXIg
fCAgICAgICAgIHwgdmRwYSBkZXZpY2UgfCAgICAgICAgICAgICAgICB8ICAgICAgICB8Cj4gPiA+
ID4gPiA+ID4gfCAtLS0tLS0tLS0tKy0tLS0tLS0tLS0gICAgICAgLS0tLS0tLS0tLSstLS0tLS0t
LS0tLSAgICAgICAgIC0tLS0tLS0rLS0tLS0tLSAgICAgICAgICAgICAgICB8ICAgICAgICB8Cj4g
PiA+ID4gPiA+ID4gfCAgICAgICAgICAgfCAgICAgIHZpcnRpbyBidXMgICAgICAgICAgIHwgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICB8
Cj4gPiA+ID4gPiA+ID4gfCAgIC0tLS0tLS0tKy0tLS0rLS0tLS0tLS0tLS0gICAgICAgICAgIHwg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAg
ICB8Cj4gPiA+ID4gPiA+ID4gfCAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAg
IHwgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICB8ICAg
ICAgICB8Cj4gPiA+ID4gPiA+ID4gfCAgICAgIC0tLS0tLS0tLS0rLS0tLS0tLS0tLSAgICAgICAg
ICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICB8
ICAgICAgICB8Cj4gPiA+ID4gPiA+ID4gfCAgICAgIHwgdmlydGlvLWJsayBkZXZpY2UgfCAgICAg
ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgICAgICB8Cj4gPiA+ID4gPiA+ID4gfCAgICAgIC0tLS0tLS0tLS0rLS0tLS0tLS0tLSAg
ICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgICAgICB8Cj4gPiA+ID4gPiA+ID4gfCAgICAgICAgICAgICAgICB8ICAgICAgICAg
ICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgICAgICB8Cj4gPiA+ID4gPiA+ID4gfCAgICAgLS0tLS0tLS0tLS0rLS0tLS0t
LS0tLS0gICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgICAgICB8Cj4gPiA+ID4gPiA+ID4gfCAgICAgfCAgdmlydGlvLXZkcGEg
ZHJpdmVyIHwgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAg
ICAgICAgICAgICAgICB8ICAgICAgICB8Cj4gPiA+ID4gPiA+ID4gfCAgICAgLS0tLS0tLS0tLS0r
LS0tLS0tLS0tLS0gICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgICAgICB8Cj4gPiA+ID4gPiA+ID4gfCAgICAgICAgICAgICAg
ICB8ICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAg
IHZkcGEgYnVzICAgICAgICAgICB8ICAgICAgICB8Cj4gPiA+ID4gPiA+ID4gfCAgICAgLS0tLS0t
LS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0r
LS0tLS0tLS0tLS0tICAgICAgICAgICB8ICAgICAgICB8Cj4gPiA+ID4gPiA+ID4gfCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAtLS0rLS0tICAgICB8Cj4gPiA+ID4gPiA+ID4gLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18IE5JQyB8LS0tLS0tCj4gPiA+ID4gPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLS0rLS0tCj4gPiA+ID4gPiA+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8Cj4gPiA+ID4gPiA+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAtLS0tLS0tLS0rLS0tLS0tLS0tCj4gPiA+ID4gPiA+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8IFJlbW90ZSBTdG9yYWdlcyB8Cj4gPiA+ID4gPiA+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAtLS0tLS0tLS0tLS0tLS0tLS0tCj4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiBXZSBtYWtlIHVzZSBvZiBpdCB0byBpbXBsZW1lbnQgYSBibG9jayBkZXZpY2Ug
Y29ubmVjdGluZyB0bwo+ID4gPiA+ID4gPiA+IG91ciBkaXN0cmlidXRlZCBzdG9yYWdlLCB3aGlj
aCBjYW4gYmUgdXNlZCBib3RoIGluIGNvbnRhaW5lcnMgYW5kCj4gPiA+ID4gPiA+ID4gVk1zLiBU
aHVzLCB3ZSBjYW4gaGF2ZSBhbiB1bmlmaWVkIHRlY2hub2xvZ3kgc3RhY2sgaW4gdGhpcyB0d28g
Y2FzZXMuCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBUbyB0ZXN0IGl0IHdpdGggbnVsbC1i
bGs6Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiAgICQgcWVtdS1zdG9yYWdlLWRhZW1vbiBc
Cj4gPiA+ID4gPiA+ID4gICAgICAgLS1jaGFyZGV2IHNvY2tldCxpZD1jaGFybW9uaXRvcixwYXRo
PS90bXAvcW1wLnNvY2ssc2VydmVyLG5vd2FpdCBcCj4gPiA+ID4gPiA+ID4gICAgICAgLS1tb25p
dG9yIGNoYXJkZXY9Y2hhcm1vbml0b3IgXAo+ID4gPiA+ID4gPiA+ICAgICAgIC0tYmxvY2tkZXYg
ZHJpdmVyPWhvc3RfZGV2aWNlLGNhY2hlLmRpcmVjdD1vbixhaW89bmF0aXZlLGZpbGVuYW1lPS9k
ZXYvbnVsbGIwLG5vZGUtbmFtZT1kaXNrMCBcCj4gPiA+ID4gPiA+ID4gICAgICAgLS1leHBvcnQg
dHlwZT12ZHVzZS1ibGssaWQ9dGVzdCxub2RlLW5hbWU9ZGlzazAsd3JpdGFibGU9b24sbmFtZT12
ZHVzZS1udWxsLG51bS1xdWV1ZXM9MTYscXVldWUtc2l6ZT0xMjgKPiA+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+IFRoZSBxZW11LXN0b3JhZ2UtZGFlbW9uIGNhbiBiZSBmb3VuZCBhdCBodHRwczov
L2dpdGh1Yi5jb20vYnl0ZWRhbmNlL3FlbXUvdHJlZS92ZHVzZQo+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiBJdCdzIGJlZW4gaGFsZiBhIHllYXIgLSBhbnkgcGxhbnMgdG8gdXBzdHJlYW0gdGhpcz8K
PiA+ID4gPiA+Cj4gPiA+ID4gPiBZZWFoLCB0aGlzIGlzIG9uIG15IHRvLWRvIGxpc3QgdGhpcyBt
b250aC4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBTb3JyeSBmb3IgdGFraW5nIHNvIGxvbmcuLi4gSSd2
ZSBiZWVuIHdvcmtpbmcgb24gYW5vdGhlciBwcm9qZWN0Cj4gPiA+ID4gPiBlbmFibGluZyB1c2Vy
c3BhY2UgUkRNQSB3aXRoIFZEVVNFIGZvciB0aGUgcGFzdCBmZXcgbW9udGhzLiBTbyBJCj4gPiA+
ID4gPiBkaWRuJ3QgaGF2ZSBtdWNoIHRpbWUgZm9yIHRoaXMuIEFueXdheSwgSSB3aWxsIHN1Ym1p
dCB0aGUgZmlyc3QKPiA+ID4gPiA+IHZlcnNpb24gYXMgc29vbiBhcyBwb3NzaWJsZS4KPiA+ID4g
PiA+Cj4gPiA+ID4gPiBUaGFua3MsCj4gPiA+ID4gPiBZb25namkKPiA+ID4gPgo+ID4gPiA+IE9o
IGZ1bi4gWW91IG1lYW4gbGlrZSB2aXJ0aW8tcmRtYT8gT3IgUkRNQSBhcyBhIGJhY2tlbmQgZm9y
IHJlZ3VsYXIKPiA+ID4gPiB2aXJ0aW8/Cj4gPiA+ID4KPiA+ID4KPiA+ID4gWWVzLCBsaWtlIHZp
cnRpby1yZG1hLiBUaGVuIHdlIGNhbiBkZXZlbG9wIHNvbWV0aGluZyBsaWtlIHVzZXJzcGFjZQo+
ID4gPiByeGXjgIFzaXcgb3IgY3VzdG9tIHByb3RvY29sIHdpdGggVkRVU0UuCj4gPiA+Cj4gPiA+
IFRoYW5rcywKPiA+ID4gWW9uZ2ppCj4gPgo+ID4gV291bGQgYmUgaW50ZXJlc3RpbmcgdG8gc2Vl
IHRoZSBzcGVjIGZvciB0aGF0Lgo+IAo+IFdpbGwgc2VuZCBpdCBBU0FQLgo+IAo+ID4gVGhlIGlz
c3VlcyB3aXRoIFJETUEgcmV2b2x2ZWQgYXJvdW5kIHRoZSBmYWN0IHRoYXQgY3VycmVudAo+ID4g
YXBwcyB0ZW5kIHRvIGVpdGhlciB1c2Ugbm9uLXN0YW5kYXJkIHByb3BvY29scyBmb3IgY29ubmVj
dGlvbgo+ID4gZXN0YWJsaXNobWVudCBvciB1c2UgVUQgd2hlcmUgdGhlcmUncyBJSVJDIG5vIHN0
YW5kYXJkCj4gPiBhdCBhbGwuIFNvIFFQIG51bWJlcnMgYXJlIGhhcmQgdG8gdmlydHVhbGl6ZS4K
PiA+IFNpbWlsYXJseSBtYW55IHVzZSBMSURzIGRpcmVjdGx5IHdpdGggdGhlIHNhbWUgZWZmZWN0
Lgo+ID4gR1VJRHMgbWlnaHQgYmUgdmlydHVhbGl6ZWFibGUgYnV0IG5vIG9uZSB3ZW50IHRvIHRo
ZSBlZmZvcnQuCj4gPgo+IAo+IEFjdHVhbGx5IHdlIGFpbWVkIGF0IGVtdWxhdGluZyBhIHNvZnQg
UkRNQSB3aXRoIG5vcm1hbCBOSUMgKG5vdCB1c2UKPiBSRE1BIGNhcGFiaWxpdHkpIHJhdGhlciB0
aGFuIHZpcnR1YWxpemluZyBhIHBoeXNpY2FsIFJETUEgTklDIGludG8KPiBzZXZlcmFsIHZSRE1B
IGRldmljZXMuIElmIHNvLCBJIHRoaW5rIHdlIHdvbid0IGhhdmUgdGhvc2UgaXNzdWVzLAo+IHJp
Z2h0PwoKUmlnaHQsIG1heWJlIHlvdSB3b24ndC4KCj4gPiBUbyBzYXkgbm90aGluZyBhYm91dCB0
aGUgaW50ZXJhY3Rpb24gd2l0aCBtZW1vcnkgb3ZlcmNvbW1pdC4KPiA+Cj4gCj4gSSBkb24ndCBn
ZXQgeW91IGhlcmUuIENvdWxkIHlvdSBnaXZlIG1lIG1vcmUgZGV0YWlscz8KPiAKPiBUaGFua3Ms
Cj4gWW9uZ2ppCgpSRE1BIGRldmljZXMgdGVuZCB0byB3YW50IHRvIHBpbiB0aGUgbWVtb3J5IHVu
ZGVyIERNQS4KCi0tIApNU1QKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
