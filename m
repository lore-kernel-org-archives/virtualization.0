Return-Path: <SRS0=dYih=NI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C808C4338F
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 05:48:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBCC460F38
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 05:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DBCC460F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F07F81046;
	Tue, 17 Aug 2021 05:48:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B9l0n5XZP_TV; Tue, 17 Aug 2021 05:48:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4016081029;
	Tue, 17 Aug 2021 05:48:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 239D4C001A;
	Tue, 17 Aug 2021 05:48:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65B15C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 05:48:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4DE36400C1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 05:48:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pHsj7dxHQvUN
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 05:48:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DFED740010
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 05:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629179311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ap2uWILKdJe840azIpwVT7/DH3Oy9qCdc4viPi8ZOU=;
 b=d39LG20RjYSbWiW3/+3A5DVCkvHQbWTemqRZwT42OTeYmaXVES95SmJWHsPuY4rvHF3uSS
 mdNBZeLJbbZo4mCvoUvVBVyTu2B7DyRE6Beg6ZUaL8r5O406ssDcDlyhyxCcMoWLdzA7RA
 9522tGqUVlsysPTHQXY1gxZuQkYgiX0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-Lt93tHcyME6R785CHhrWhw-1; Tue, 17 Aug 2021 01:48:30 -0400
X-MC-Unique: Lt93tHcyME6R785CHhrWhw-1
Received: by mail-lf1-f70.google.com with SMTP id
 s8-20020a19ad480000b02903be9e365859so4951242lfd.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 22:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8ap2uWILKdJe840azIpwVT7/DH3Oy9qCdc4viPi8ZOU=;
 b=iYBXYb90cjGLPNSMvW5YGh+dGf5YzVUS7gAPyVajn+6gOjEgQMZPeA0FDfQGNl112x
 4Y4iDF78tWmWT5rQOQan/SpvxNM/hUD+B6ziU5omDtznyX5JUA9kxPFtR2sYOELPYns9
 4hoSF5wS8KuUY8+jBh0KEVnnWgff41MLiiQ5MiEfvql5Kx65IYIMI3LZWmurQMVeSuSn
 VKhFXWrp2z3d0fu8XF/rvt0zeDMEoHqdfuLm9QawzHfITeiflZfQ5y2iu/HnKTSftnXj
 qHlmZJK1IVFpbfEmq1pt3VUYNOS5agRrYG5b9r/hImO9QvAP2WYLfJdJhWWmdPKF8IuY
 hHag==
X-Gm-Message-State: AOAM53290asHkR0FLYlAE6n5qcFpIBIMOVXjpidl77FpWpDn6RtbtRfi
 pI71yY/C4vOeUj8U5lfN+4N7Umje7pS+/qA0X6nFc3F+Sq6JgMrwiz7ssQNkMSMsyDOntvDxpVM
 7qhhaV35NyKciFBKdei/894SWrsHEhlxMi6bZVeAu2+KTQSGjqPCArEtV8g==
X-Received: by 2002:a19:f719:: with SMTP id z25mr1117677lfe.339.1629179308852; 
 Mon, 16 Aug 2021 22:48:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6DGbn2xunQ751c9Ae4ZIAeWw2HHGGJBWC0ZwE+QROkSlRTUD8VDnaGyTyowzw52wdJ9hc5dn4uQ6MyEN+uvc=
X-Received: by 2002:a19:f719:: with SMTP id z25mr1117667lfe.339.1629179308663; 
 Mon, 16 Aug 2021 22:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <2cc15e3e-bd5c-8e43-1d2f-b0e03b8690d5@redhat.com>
 <20210812095035.GA105096@mtl-vdi-166.wap.labs.mlnx>
 <61b913bb-3f6b-49d4-f5f1-32dce3bd7fae@redhat.com>
 <20210816054746.GA30532@mtl-vdi-166.wap.labs.mlnx>
 <3f26a849-d1a8-49e2-cb60-d58d7c4cbcd9@redhat.com>
 <20210816165659.GA51703@mtl-vdi-166.wap.labs.mlnx>
 <20210816153630-mutt-send-email-mst@kernel.org>
 <CACGkMEvu9tUWPkYqLoDzJ0gR=5RMstMhcU+OkhFtHn7TB5Ki6Q@mail.gmail.com>
 <PH0PR12MB5481B0AC416186D7B20FCB26DCFE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <d54f2e9b-1a04-7118-5c39-c93997eb2afd@redhat.com>
 <20210817052644.GB74703@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20210817052644.GB74703@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 17 Aug 2021 13:48:17 +0800
Message-ID: <CACGkMEssyoArFmGhHL_sT0mNW_mvd-e9HeJXCMrUnzZggMr8yA@mail.gmail.com>
Subject: Re: [Patch v1 3/3] vdpa/mlx5: Add multiqueue support
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: eperezma <eperezma@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

T24gVHVlLCBBdWcgMTcsIDIwMjEgYXQgMToyNiBQTSBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNv
bT4gd3JvdGU6Cj4KPiBPbiBUdWUsIEF1ZyAxNywgMjAyMSBhdCAxMjoxOTo1NVBNICswODAwLCBK
YXNvbiBXYW5nIHdyb3RlOgo+ID4KPiA+IOWcqCAyMDIxLzgvMTcg5LiL5Y2IMTI6MDMsIFBhcmF2
IFBhbmRpdCDlhpnpgZM6Cj4gPiA+ID4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0
LmNvbT4KPiA+ID4gPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMTcsIDIwMjEgOToyNiBBTQo+ID4g
PiA+Cj4gPiA+ID4gT24gVHVlLCBBdWcgMTcsIDIwMjEgYXQgMzozNyBBTSBNaWNoYWVsIFMuIFRz
aXJraW4gPG1zdEByZWRoYXQuY29tPgo+ID4gPiA+IHdyb3RlOgo+ID4gPiA+ID4gT24gTW9uLCBB
dWcgMTYsIDIwMjEgYXQgMDc6NTY6NTlQTSArMDMwMCwgRWxpIENvaGVuIHdyb3RlOgo+ID4gPiA+
ID4gPiBPbiBNb24sIEF1ZyAxNiwgMjAyMSBhdCAwMTo1ODowNlBNICswODAwLCBKYXNvbiBXYW5n
IHdyb3RlOgo+ID4gPiA+ID4gPiA+IOWcqCAyMDIxLzgvMTYg5LiL5Y2IMTo0NywgRWxpIENvaGVu
IOWGmemBkzoKPiA+ID4gPiA+ID4gPiA+IE9uIE1vbiwgQXVnIDE2LCAyMDIxIGF0IDEyOjE2OjE0
UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+IOWcqCAyMDIxLzgv
MTIg5LiL5Y2INTo1MCwgRWxpIENvaGVuIOWGmemBkzoKPiA+ID4gPiA+ID4gPiA+ID4gPiBPbiBU
aHUsIEF1ZyAxMiwgMjAyMSBhdCAwMzowNDozNVBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4g5ZyoIDIwMjEvOC8xMiDkuIvljYgzOjAxLCBFbGkgQ29oZW4g
5YaZ6YGTOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBPbiBUaHUsIEF1ZyAxMiwgMjAyMSBhdCAw
Mjo0NzowNlBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IE9uIFRodSwgQXVnIDEyLCAyMDIxIGF0IDEyOjU1IFBNIEVsaSBDb2hlbgo+ID4gPiA+IDxl
bGljQG52aWRpYS5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gT24gVGh1
LCBBdWcgMTIsIDIwMjEgYXQgMTE6MTk6MTlBTSArMDgwMCwgSmFzb24gV2FuZwo+ID4gPiA+IHdy
b3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiDlnKggMjAyMS84LzExIOS4i+WNiDc6
MDQsIEVsaSBDb2hlbiDlhpnpgZM6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gT24g
V2VkLCBBdWcgMTEsIDIwMjEgYXQgMDQ6Mzc6NDRQTSArMDgwMCwgSmFzb24KPiA+ID4gPiBXYW5n
IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g5ZyoIDIwMjEvOC8xMSDk
uIvljYgzOjUzLCBFbGkgQ29oZW4g5YaZ6YGTOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+IE9uZSB0aGluZyBuZWVkIHRvIHNvbHZlIGZvciBtcSBpcyB0aGF0IHRoZToKPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAr
c3RhdGljIHUxNiBjdHJsX3ZxX2lkeChzdHJ1Y3QKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ICttbHg1X3ZkcGFfZGV2ICptdmRldikgewo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgcmV0dXJuIDIgKgo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gK21seDVfdmRwYV9tYXhfcXBzKG12ZGV2LT5tYXhfdnFzKTsK
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICt9Cj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gV2Ugc2hvdWxkIGhhbmRsZSB0aGUgY2FzZSB3aGVuIE1R
IGlzCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gc3VwcG9ydGVkIGJ5IHRo
ZSBkZXZpY2UgYnV0IG5vdCB0aGUgZHJpdmVyLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gRS5nIGluIHRo
ZSBjYXNlIHdoZW4gd2UgaGF2ZSAyIHF1ZXVlIHBhaXJzOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gV2hl
biBNUSBpcyBlbmFibGVkLCBjdnEgaXMgcXVldWUgNAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gV2hlbiBN
USBpcyBub3QgZW5hYmxlZCwgY3ZxIGlzIHF1ZXVlIDIKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBUaGVyZSdz
IHNvbWUgaXNzdWUgd2l0aCB0aGlzLiBJIGdldAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiBjYWxsYmFja3MgdGFyZ2V0aW5nIHNwZWNpZmljIHZpcnRxdWV1ZXMgYmVmb3JlCj4g
PiA+ID4gZmVhdHVyZXMgbmVnb3RpYXRpb24gaGFzIGJlZW4gY29tcGxldGVkLgo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBTcGVjaWZpY2FsbHksIEkgZ2V0IHNldF92cV9jYigp
IGNhbGxzLiBBdAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiB0aGlzIHBvaW50
IEkgbXVzdCBrbm93IHRoZSBjb250cm9sIHZxIGluZGV4Lgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gU28gSSB0aGluayB3ZSBuZWVkIGRvIGJvdGg6Cj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gMSkgQXQg
b25lIGhhbmQsIGl0J3MgYSBidWcgZm9yIHRoZSB1c2Vyc3BhY2UKPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IHRvIHVzZSB2cV9pbmRleCBiZWZvcmUgZmVhdHVyZSBpcyBuZWdvdGlh
dGVkCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gKGxvb2tzIGxpa2UgYSBidWcgaW4gbXkgY3ZxIHNlcmllcyB0aGF0IHdp
bGwKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGNhbGwgU0VUX1ZSSU5HX0NBTEwg
YmVmb3JlIGZlYXR1cmUgaXMgbmVnb3RpYXRlLAo+ID4gPiA+IHdoaWNoIEkgd2lsbCBsb29rKS4K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IDIpIEF0IHRoZSBvdGhlciBoYW5kLCB0
aGUgZHJpdmVyIHNob3VsZCBiZQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gYWJs
ZSB0byBkZWFsIHdpdGggdGhhdAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBBbGwgSSBjYW4gZG8gaXMgZHJvcCBjYWxsYmFj
a3MgZm9yIFZRcyBiZWZvcmUKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBmZWF0dXJl
cyBuZWdvdGF0aW9uIGhhcyBiZWVuIGNvbXBsZXRlZC4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gT3IganVzdCBsZWF2ZSBxdWV1ZSBpbmRleCAwLCAxIHdvcmsuCj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFNpbmNlIGl0IGlz
IG5vdCBleHBlY3RlZCB0byBiZSBjaGFuZ2VkLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gUmlnaHQsIHdpbGwgZG8uCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBJIHRo
aW5rIHRoZSBDVlEgaW5kZXggbXVzdCBub3QgZGVwZW5kIG9uIHRoZQo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiBuZWdvdGlhdGVkIGZlYXR1cmVzIGJ1dCByYXRoZXIgZGVwZW5k
IG9mIHRoZQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiB2YWx1ZSB0aGUgZGV2
aWNlIGRyaXZlciBwcm92aWRlcyBpbiB0aGUgY2FsbCB0bwo+ID4gPiA+IF92ZHBhX3JlZ2lzdGVy
X2RldmljZSgpLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQXQgdGhlIHZpcnRp
byBsZXZlbCwgaXQncyB0b28gbGF0ZSB0byBjaGFuZ2UKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+IHRoYXQgYW5kIGl0IGJyZWFrcyB0aGUgYmFja3dhcmQgY29tcGF0aWJpbGl0eS4K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiBCdXQgYXQgdGhlIHZEUEEgbGV2ZWwsIHRoZSB1bmRlciBsYXllciBkZXZpY2UK
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGNhbiBtYXAgdmlydGlvIGN2cSB0byBh
bnkgb2YgaXQncyB2aXJ0cXVldWUuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gRS5nIG1hcCBjdnEgKGluZGV4IDIpIHRv
IG1seDUgY3ZxICh0aGUgbGFzdCkuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEkgYW0gbm90IGZvbGxvd2luZyB5b3UgaGVy
ZS4gSSBzdGlsbCBkb24ndCBrbm93IHdoYXQKPiA+ID4gPiBpbmRleCBpcyBjdnEuCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IFJpZ2h0LCB3ZSBzdGlsbCBuZWVkIHRvIHdhaXQgZm9yIHRo
ZSBmZWF0dXJlIGJlaW5nCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IG5lZ290aWF0ZWQg
aW4gb3JkZXIgdG8gcHJvY2VlZC4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IFNvIHRvIHN1bW1hcmlzZSwgYmVmb3JlIGZlYXR1cmUgbmVn
b3RpYXRpb24KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGNvbXBsZXRlLCBJIGFjY2VwdCBj
YWxscyByZWZlcnJpbmcgdG8gVlFzIG9ubHkgZm9yIGluZGljZXMgMAo+ID4gPiA+IGFuZCAxLgo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQWZ0ZXIgZmVhdHVyZSBuZWdvdGlhdGlvbiBjb21w
bGV0ZSBJIGtub3cgQ1ZRIGluZGV4Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBhbmQgd2ls
bCBhY2NlcHQgaW5kaWNlcyAwIHRvIGN2cSBpbmRleC4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiBJIGRvbid0IGdldCB0aGlzICJhY2NlcHQgaW5kaWNlcyAwIHRvIGN2cSBpbmRleCIuCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IFdoYXQgSSBtZWFudCB0byBzYXkgaXMgdGhhdCB0aGVyZSBhcmUg
c2V2ZXJhbCBjYWxsYmFja3MKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gdGhhdCByZWZlciB0byBz
cGVjaWZpYyB2aXJ0cXVldWVzLCBlLmcuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHNldF92cV9h
ZGRyZXNzKCksIHNldF92cV9udW0oKSBldGMuIFRoZXkgYWxsIGFjY2VwdCB2aXJ0cXVldWUKPiA+
ID4gPiBpbmRleCBhcyBhbiBhcmd1bWVudC4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gV2hhdCB3
ZSB3YW50IHRvIGRvIGlzIHZlcmlmeSB3aGVhdGhlciB0aGUgaW5kZXggcHJvdmlkZWQKPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gaXMgdmFsaWQgb3Igbm90LiBJZiBpdCBpcyBub3QgdmFsaWQsIGVp
dGhlciByZXR1cm4gZXJyb3IKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gKGlmIHRoZSBjYWxsYmFj
ayBjYW4gcmV0dXJuIGEgdmFsdWUpIG9yIGp1c3QgYXZvaWQKPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gcHJvY2Vzc2luZyBpdC4gSWYgdGhlIGluZGV4IGlzIHZhbGlkIHRoZW4gd2UgcHJvY2VzcyBp
dCBub3JtYWxseS4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gTm93IHdlIG5lZWQgdG8gZGVjaWRlIHdoaWNoIGluZGV4IGlzIHZhbGlkIG9yIG5vdC4gV2UK
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gbmVlZCBzb21ldGhpbmcgbGlrZSB0aGlzIHRvIGlkZW50
aWZpeSB2YWxpZCBpbmRleGVzIHJhbmdlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiBDVlEgY2xlYXI6IDAgYW5kIDEKPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gQ1ZRIHNldCwgTVEgY2xlYXI6IDAsIDEgYW5kIDIgKGZvciBDVlEpLgo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiBDVlEgc2V0LCBNUSBzZXQ6IDAuLm52cSB3aGVyZSBudnEgaXMgd2hhdGV2ZXIg
cHJvdmlkZWQKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gdG8KPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gX3ZkcGFfcmVnaXN0ZXJfZGV2aWNlKCkKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFllcy4KPiA+
ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gVW5mb3J0dW5hdGVseSBpdCBk
b2VzIG5vdCB3b3JrLgo+ID4gPiA+ID4gPiA+ID4gPiA+IHNldF92cV9jYigpIGZvciBhbGwgdGhl
IG11bHRpcXVldWVzIGlzIGNhbGxlZCBiZW9mcmUgZmVhdHVyZQo+ID4gPiA+ID4gPiA+ID4gPiA+
IG5lZ290aWF0aW9uLiBJZiBJIGFwcGx5IHRoZSBhYm92ZSBsb2dpYywgSSB3aWxsIGxvc2UgdGhl
c2Ugc2V0dGluZ3MuCj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiBJIGNh
biBtYWtlIGFuIGV4Y2VwdGlvbiBmb3Igc2V0X3ZxX2NiKCksIHNhdmUgY2FsbGJhY2tzIGFuZAo+
ID4gPiA+ID4gPiA+ID4gPiA+IHJlc3RvcmUgdGhlbSBhZnRlcndhcmRzLiBUaGlzIGxvb2tzIHRv
byBjb252b2x1dGVkIGFuZCBtYXliZQo+ID4gPiA+ID4gPiA+ID4gPiA+IHdlIHNob3VsZCBzZWVr
IGFub3RoZXIgc29sdXRpb24uCj4gPiA+ID4gPiA+ID4gPiA+IEkgYWdyZWUuCj4gPiA+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gTGV0IG1lIGtub3cg
d2hhdCB5b3UgdGhpbmsuCj4gPiA+ID4gPiA+ID4gPiA+IFJldGhpbmsgYWJvdXQgdGhpcyBpc3N1
ZS4gSXQgbG9va3MgdG8gdGhlIG9ubHkgaXNzdWUgd2UgZmFjZQo+ID4gPiA+ID4gPiA+ID4gPiBp
cyB0aGUgc2V0X3ZxX2NiKCkuCj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IFdp
dGggdGhlIGFzc3VtcHRpb24gdGhhdCB0aGUgdXNlcnNwYWNlIGNhbiB1c2UgdGhlIGluZGV4Cj4g
PiA+ID4gPiA+ID4gPiA+IGNvcnJlY3RseSAoZXZlbiBiZWZvcmUgc2V0X2ZlYXR1cmVzKS4gSSB3
b25kZXIgdGhlIGZvbGxvd2luZyB3b3Jrcy4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiA+ID4gSW5zdGVhZCBvZiBjaGVja2luZyB3aGV0aGVyIHRoZSBpbmRleCBpcyBjdnEgaW4gc2V0
X3ZxX2NiKCkgaG93Cj4gPiA+ID4gYWJvdXQ6Cj4gPiA+ID4gPiA+ID4gPiA+IDEpIGRlY291cGxl
IGV2ZW50X2NiIG91dCBvZiBtbHg1X3ZkcGFfdmlydHF1ZXVlIGFuZAo+ID4gPiA+ID4gPiA+ID4g
PiBtbHg1X2Nvbmdyb192cQo+ID4gPiA+ID4gPiA+ID4gPiAyKSBoYXZlIGEgZGVkaWNhdGVkIGV2
ZW50X2NiIGFycmF5IGluIG1seDVfdmRwYV9uZXQKPiA+ID4gPiA+ID4gPiA+ID4gMykgdGhlbiB3
ZSBjYW4gZG8KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gbmRldi0+ZXZlbnRf
Y2JzW2luZGV4XSA9ICpjYjsKPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IFNvIGFj
dHVhbGx5IHlvdSdyZSBzdWdnZXN0aW5nIHRvIHNhdmUgYWxsIHRoZSBjYWxsYWJjawo+ID4gPiA+
ID4gPiA+ID4gY29uZmlndXJhdGlvbnMgaW4gYW4gYXJyYXkgYW5kIGV2YWx1YXRlIGN2cSBpbmRl
eCBhZnRlciBmZWF0dXJlCj4gPiA+ID4gPiA+ID4gPiBuZWdvdGlhdGlvbiBoYXMgYmVlbiBjb21w
bGV0ZWQuCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBZZXMuCj4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gSSB0aGluayB0aGF0IGNvdWxkIHdvcmsuIEkgd2ls
bCBjb2RlIHRoaXMgYW5kIHVwZGF0ZS4KPiA+ID4gPiA+ID4gSXQgd29ya3MgZmluZSB3aGVuIEkg
YW0gd29ya2luZyB3aXRoIHlvdXIgdmVyc2lvbiBvZiBxZW11IHdpdGgKPiA+ID4gPiA+ID4gc3Vw
cG9ydCBmb3IgbXVsdGkgcXVldWUuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFRoZSBwcm9ibGVt
IGlzIHRoYXQgaXQgaXMgYnJva2VuIG9uIHFlbXUgdjYuMC4wLiBJZiBJIHJlZ2lzdGVyIG15Cj4g
PiA+ID4gPiA+IHZkcGEgZGV2aWNlIHdpdGggbW9yZSB0aGFuIDIgZGF0YSB2aXJ0cXVldWVzLCBx
ZW11IHdvbid0IGV2ZW4gY3JlYXRlCj4gPiA+ID4gPiA+IGEgbmV0ZGV2aWNlIGluIHRoZSBWTS4K
PiA+ID4gPiBRZW11IHNob3VsZCBoaWRlIE1RIGZlYXR1cmUgaW4gdGhpcyBjYXNlIGJ1dCBsb29r
cyBsaWtlIGl0IGRvZXNuJ3QuCj4gPiA+ID4KPiA+ID4gPiBXaWxsIGhhdmUgYSBsb29rLgo+ID4g
PiA+Cj4gPiA+ID4gPiA+IEkgYW0gbm90IHN1cmUgaG93IHRvIGhhbmRsZSB0aGlzLiBJcyB0aGVy
ZSBzb21lIGtpbmQgb2YgaW5kaWNhdGlvbiBJCj4gPiA+ID4gPiA+IGNhbiBnZXQgYXMgdG8gdGhl
IHZlcnNpb24gb2YgcWVtdSBzbyBJIGNhbiBhdm9pZCB1c2luZyBtdWx0aXF1ZXVlCj4gPiA+ID4g
PiA+IGZvciB2ZXJzaW9ucyBJIGtub3cgYXJlIHByb2JsZW1hdGljPwo+ID4gPiA+ID4gTm8gdmVy
c2lvbnMgOykgVGhpcyBpcyB3aGF0IGZlYXR1cmUgYml0cyBhcmUgZm9yIC4uLgo+ID4gPiA+IFll
cy4KPiA+ID4gPgo+ID4gPiA+IFNvIGRvZXMgaXQgd29yayBpZiAibXE9b2ZmIiBpcyBzcGVjaWZp
ZWQgaW4gdGhlIGNvbW1hbmQgbGluZT8KPiA+ID4gPgo+ID4gPiBXZSBzaG91bGQgbm90IGFkZCBk
cml2ZXIgbW9kdWxlIHBhcmFtZXRlci4KPiA+Cj4gPgo+ID4gTm90ZSB0aGF0LCBpdCdzIG5vdCBh
IG1vZHVsZSBwYXJhbWV0ZXIgYnV0IGEgcWVtdSBjb21tYW5kIGxpbmUgdG8gZGlzYWJsZSBtcQo+
ID4gZmVhdHVyZS4KPiA+Cj4gPgo+ID4gPiBXZSBhbnl3YXkgbmVlZCBudW1iZXIgb2YgVlFzIHRv
IGJlIGRyaXZlbiBieSB0aGUgbnVtYmVyIG9mIHZjcHVzIHVzZWQgYnkgdGhlIFZNLgo+ID4gPiBT
byB3aHkgbm90IHNwZWNpZnkgdGhpcyB3aGVuIGNyZWF0aW5nIGEgdmRwYSBkZXZpY2U/Cj4gPgo+
ID4KPiA+IFllcywgSSB0aGluayBpdCBzaG91bGQgd29yayBhcyB3ZWxsLgo+ID4KPiA+IFNvIG1h
bmFnZW1lbnQgbmVlZCBlaXRoZXI6Cj4gPgo+ID4gMSkgZGlzYWJsZSBtdWx0aXF1ZXVlIHZpYSAi
bXE9b2ZmIgo+ID4KPiA+IG9yCj4gPgo+ID4gMikgdXNpbmcgbmV0bGluayBBUEkgdG8gY3JlYXRl
IGEgc2luZ2xlIHF1ZXVlIHBhaXIgZGV2aWNlCj4gPgo+ID4gZm9yIHRoZSBxZW11IDw9Ni4xLgo+
ID4KPgo+IFdoaWNoIG1hbmFnZW1lbnQgZW50aXR5IGFyZSB5b3UgcmVmZXJyaW5nIHRvIGhlcmU/
CgpUaGUgb25lIHRoYXQgbGF1bmNoZXMgUWVtdS4gKEUuZyBsaWJ2aXJ0IG9yIG90aGVyKS4KClRo
YW5rcwoKPgo+ID4gVGhhbmtzCj4gPgo+ID4KPiA+ID4KPiA+Cj4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
