Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F90C433EF
	for <virtualization@archiver.kernel.org>; Mon, 17 Jan 2022 07:55:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D3B1F40360;
	Mon, 17 Jan 2022 07:55:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7VBDwBPE9yil; Mon, 17 Jan 2022 07:55:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3D5ED401A2;
	Mon, 17 Jan 2022 07:55:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15F2BC0039;
	Mon, 17 Jan 2022 07:55:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 687F8C002F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 07:55:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 441674022F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 07:55:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d50FkxrZdMaM
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 07:55:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 85A674021F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 07:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642406150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S794o1+gxZiFBik2xQJ/yYRJWwEkmKRwWvfOGmOlz/A=;
 b=OmSMV8pShftMaQZhRb+huTuVALWaJ9N2ay9nsy9hnArSbInPVMiEWgACcChS3rQxXeFD9J
 0QYgitWEUvr/liB+B7D2iJUU08dMrfuFlgyEIgCXVCV352NJVRR/7xCOPhHVUg6TC4QIJm
 F/vmvy/i2fHaE7BUQF/2GZei6vwUZJA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-577-g_ZDR81oMYenSmb2K-K53A-1; Mon, 17 Jan 2022 02:55:47 -0500
X-MC-Unique: g_ZDR81oMYenSmb2K-K53A-1
Received: by mail-wm1-f71.google.com with SMTP id
 bg32-20020a05600c3ca000b00349f2aca1beso10453603wmb.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Jan 2022 23:55:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=S794o1+gxZiFBik2xQJ/yYRJWwEkmKRwWvfOGmOlz/A=;
 b=RmYL1EU9OE9WZXdoMuEclyfx3pEcomrUMQ7jdYzQvgOn4dIwm4p2K18sGCgNvPNwba
 URJKqbAlDLIpqJlZm6ZfrRAddiyt8ysSOH53sEYBi34Y5fbDIlmPZt29bGY9j7LWQzZr
 hr20ltmMdCOSJsv7VfKHKhMXFZkf+LgPADt7eWJyKRSP5Mw8U+TPsIS9BoelsWSXRcTv
 dZkACJ3L7AipUPZRNH438JXGHkzIu4VSSQoRjYjmG5kdXRWyzOjfx2TnZZKhN1A2dfBq
 EyrsZUE8K7Fj8ZLIQ72vwg/FvbrXaG/vyvxawwzCIYiEwvcDmhtZhb3krkWenD+ZcvIB
 3GrA==
X-Gm-Message-State: AOAM5330zm02FIuyDT8moupMUtJWG3pYObqagqw5Z/nWwbERoX8qkFzK
 g+rue3TbBCfqayfeKEy0CUgLwrFC3i9DGOYh7/3782qkCVROP3WvQSBy3Pc8Xr8/TSOIl1HkN3T
 PsahDw2yi8Kv/cjjrnkuExAqfdRjLoqlHkj/1+KGZXw==
X-Received: by 2002:a5d:6251:: with SMTP id m17mr10886822wrv.49.1642406146785; 
 Sun, 16 Jan 2022 23:55:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyppKFvTpSnYReosIo+xIkvfCskoqdMVLvEKl0f9W0+ccEUUAvaX0prC3KjSPi1+jccsmbe7w==
X-Received: by 2002:a5d:6251:: with SMTP id m17mr10886814wrv.49.1642406146588; 
 Sun, 16 Jan 2022 23:55:46 -0800 (PST)
Received: from redhat.com ([2.55.154.241])
 by smtp.gmail.com with ESMTPSA id t15sm12611807wrz.82.2022.01.16.23.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Jan 2022 23:55:46 -0800 (PST)
Date: Mon, 17 Jan 2022 02:55:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio_mem: break device on remove
Message-ID: <20220117025341-mutt-send-email-mst@kernel.org>
References: <20220114214324.239444-1-mst@redhat.com>
 <1f703ebf-0f78-e530-0fe1-163613397cad@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1f703ebf-0f78-e530-0fe1-163613397cad@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

T24gTW9uLCBKYW4gMTcsIDIwMjIgYXQgMDI6NDA6MTFQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMi8xLzE1IOS4iuWNiDU6NDMsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnp
gZM6Cj4gPiBBIGNvbW1vbiBwYXR0ZXJuIGZvciBkZXZpY2UgcmVzZXQgaXMgY3VycmVudGx5Ogo+
ID4gdmRldi0+Y29uZmlnLT5yZXNldCh2ZGV2KTsKPiA+IC4uIGNsZWFudXAgLi4KPiA+IAo+ID4g
cmVzZXQgcHJldmVudHMgbmV3IGludGVycnVwdHMgZnJvbSBhcnJpdmluZyBhbmQgd2FpdHMgZm9y
IGludGVycnVwdAo+ID4gaGFuZGxlcnMgdG8gZmluaXNoLgo+ID4gCj4gPiBIb3dldmVyIGlmIC0g
YXMgaXMgY29tbW9uIC0gdGhlIGhhbmRsZXIgcXVldWVzIGEgd29yayByZXF1ZXN0IHdoaWNoIGlz
Cj4gPiBmbHVzaGVkIGR1cmluZyB0aGUgY2xlYW51cCBzdGFnZSwgd2UgaGF2ZSBjb2RlIGFkZGlu
ZyBidWZmZXJzIC8gdHJ5aW5nCj4gPiB0byBnZXQgYnVmZmVycyB3aGlsZSBkZXZpY2UgaXMgcmVz
ZXQuIE5vdCBnb29kLgo+ID4gCj4gPiBUaGlzIHdhcyByZXByb2R1Y2VkIGJ5IHJ1bm5pbmcKPiA+
IAltb2Rwcm9iZSB2aXJ0aW9fY29uc29sZQo+ID4gCW1vZHByb2JlIC1yIHZpcnRpb19jb25zb2xl
Cj4gPiBpbiBhIGxvb3AsIGFuZCB0aGlzIHJlYXNvbmluZyBzZWVtcyB0byBhcHBseSB0byB2aXJ0
aW8gbWVtIHRob3VnaAo+ID4gSSBjb3VsZCBub3QgcmVwcm9kdWNlIGl0IHRoZXJlLgo+ID4gCj4g
PiBGaXggdGhpcyB1cCBieSBjYWxsaW5nIHZpcnRpb19icmVha19kZXZpY2UgKyBmbHVzaCBiZWZv
cmUgcmVzZXQuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX21lbS5jIHwg
MiArKwo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4gPiAKPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fbWVtLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fbWVtLmMKPiA+IGluZGV4IDM4YmVjZDhkNTc4Yy4uMzNiOGExMThhM2FlIDEwMDY0NAo+ID4g
LS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX21lbS5jCj4gPiArKysgYi9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fbWVtLmMKPiA+IEBAIC0yODg4LDYgKzI4ODgsOCBAQCBzdGF0aWMgdm9pZCB2aXJ0
aW9fbWVtX3JlbW92ZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiA+ICAgCQl2aXJ0aW9f
bWVtX2RlaW5pdF9ob3RwbHVnKHZtKTsKPiA+ICAgCS8qIHJlc2V0IHRoZSBkZXZpY2UgYW5kIGNs
ZWFudXAgdGhlIHF1ZXVlcyAqLwo+ID4gKwl2aXJ0aW9fYnJlYWtfZGV2aWNlKHZkZXYpOwo+ID4g
KwlmbHVzaF93b3JrKCZ2bS0+d3EpOwo+IAo+IAo+IFdlIHNldCB2bS0+cmVtb3ZpbmcgdG8gdHJ1
ZSBhbmQgY2FsbCBjYW5jZWxfd29ya19zeW5jKCkgaW4KPiB2aXJ0aW9fbWVtX2RlaW5pdF9ob3Rw
bHVnKCkuIElzbid0IGlzIHN1ZmZpY2llbnQ/Cj4gCj4gVGhhbmtzCgoKSG1tIEkgdGhpbmsgeW91
IGFyZSByaWdodC4gRGF2aWQsIEkgd2lsbCBkcm9wIHRoaXMgZm9yIG5vdy4KVXAgdG8geW91IHRv
IGNvbnNpZGVyIHdoZXRoZXIgc29tZSBjZW50cmFsIGNhcGFiaWxpdHkgd2lsbCBiZQpoZWxwZnVs
IGFzIGEgcmVwbGFjZW1lbnQgZm9yIHRoZSB2aXJ0aW8tbWVtIHNwZWNpZmljICJyZW1vdmluZyIg
ZmxhZy4KCj4gCj4gPiAgIAl2aXJ0aW9fcmVzZXRfZGV2aWNlKHZkZXYpOwo+ID4gICAJdmRldi0+
Y29uZmlnLT5kZWxfdnFzKHZkZXYpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
