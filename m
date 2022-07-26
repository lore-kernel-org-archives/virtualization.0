Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297AAC00140
	for <virtualization@archiver.kernel.org>; Tue, 26 Jul 2022 19:52:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8785D40881;
	Tue, 26 Jul 2022 19:52:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8785D40881
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AaIRRL94
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QcJ2KG9BRPo6; Tue, 26 Jul 2022 19:52:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0F8AE40872;
	Tue, 26 Jul 2022 19:52:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F8AE40872
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE0EFC0033;
	Tue, 26 Jul 2022 19:52:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C57AC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 19:52:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 439008131E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 19:52:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 439008131E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AaIRRL94
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tiK-a9CJEbRC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 19:52:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2309A80D7E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2309A80D7E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 19:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658865127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6CZKvjEOWarDPKvw674EQUQEiUqD5ev91Kf4ytKkJWM=;
 b=AaIRRL94sgYbEcAwlWyBWRhGcmTLUeqbiNWHNdYp2rDSEh6cPZzkn5in4lxNDJVWyT56zj
 gocn4BvLPK63SUJF65A+FYy2GcLZKvs86bUtQ1av9vhB5ATtBoV4D+NaJPAulfNbNeVzMk
 hEBRIUUgn2jHUyAtG44AREGBwJZx9Ho=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-LH7Dze15MAiOGasdiXL0Lw-1; Tue, 26 Jul 2022 15:52:06 -0400
X-MC-Unique: LH7Dze15MAiOGasdiXL0Lw-1
Received: by mail-wm1-f71.google.com with SMTP id
 v67-20020a1cac46000000b003a2be9fa09cso8049659wme.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 12:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=6CZKvjEOWarDPKvw674EQUQEiUqD5ev91Kf4ytKkJWM=;
 b=PBETurxJYaehSNl7kA8obIvbTHYcrmCnZZtnVqkzcMmLMfn8zUG8jP5hHyvlmByhLZ
 x5wf0XDb/ogldZ+WG3vLg34MgbVMNwuwa1FCsrfvLafUvkXQ09Yj5ckK29wfFQwNEAC3
 ze58M3Di47NWbCryutK7yu2lsmi6pK0VSPnz8Je1SbMRdIkUbQe6VjtoQBLDJbdBFE28
 +R0umjb89hpoPWYBgDVWAg88V2d0Y6Qg1cbnSLMwEAMRjUWrjCGIxb8zR/J5XH8jmr8x
 teb+fwJG5H/uIQ6cF1d+sLFoASgpqUuNN6ADMXU2Jl7GNt38WMh3VI0C40VRJPhhq6z0
 0O5g==
X-Gm-Message-State: AJIora/R28hQrtXI3CaOZx17Elew+K+QextPxmmxdHPUGZ8yNFH+C6KK
 827JlTsg3WNz133NadItvSyU8yoi3uO/HTXtWGA1K0hDXo6TnJQD6D6gZ/mv3dOqmxBPi4NyWZZ
 vcavkkbT4W4+UDA1h78x8/gSfGUfY2IPwuhxLY1CF3g==
X-Received: by 2002:a5d:46c7:0:b0:21e:3c82:2df with SMTP id
 g7-20020a5d46c7000000b0021e3c8202dfmr12145049wrs.519.1658865125315; 
 Tue, 26 Jul 2022 12:52:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vDBuORhAbQFR+DTzJRgUoP8PjptZcpyG6r4ergrYBtY3opWPHGede0qqU+ohFSqoQtmnZbzA==
X-Received: by 2002:a5d:46c7:0:b0:21e:3c82:2df with SMTP id
 g7-20020a5d46c7000000b0021e3c8202dfmr12145024wrs.519.1658865124814; 
 Tue, 26 Jul 2022 12:52:04 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7424:0:3d16:86dc:de54:5671])
 by smtp.gmail.com with ESMTPSA id
 i6-20020a5d5226000000b0021d6d9c0bd9sm15158827wra.82.2022.07.26.12.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Jul 2022 12:52:04 -0700 (PDT)
Date: Tue, 26 Jul 2022 15:52:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH V3 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
Message-ID: <20220726154930-mutt-send-email-mst@kernel.org>
References: <20220701132826.8132-6-lingshan.zhu@intel.com>
 <PH0PR12MB548173B9511FD3941E2D5F64DCBD9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ef1c42e8-2350-dd9c-c6c0-2e9bbe85adb4@intel.com>
 <PH0PR12MB5481FF0AE64F3BB24FF8A869DC829@PH0PR12MB5481.namprd12.prod.outlook.com>
 <00c1f5e8-e58d-5af7-cc6b-b29398e17c8b@intel.com>
 <PH0PR12MB54817863E7BA89D6BB5A5F8CDC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <c7c8f49c-484f-f5b3-39e6-0d17f396cca7@intel.com>
 <PH0PR12MB5481E65037E0B4F6F583193BDC899@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1246d2f1-2822-0edb-cd57-efc4015f05a2@intel.com>
 <PH0PR12MB54815985C202E81122459DFFDC949@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54815985C202E81122459DFFDC949@PH0PR12MB5481.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>
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

T24gVHVlLCBKdWwgMjYsIDIwMjIgYXQgMDM6NTY6MzJQTSArMDAwMCwgUGFyYXYgUGFuZGl0IHdy
b3RlOgo+IAo+ID4gRnJvbTogWmh1LCBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4K
PiA+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMTIsIDIwMjIgMTE6NDYgUE0KPiA+ID4gV2hlbiB0aGUg
dXNlciBzcGFjZSB3aGljaCBpbnZva2VzIG5ldGxpbmsgY29tbWFuZHMsIGRldGVjdHMgdGhhdCBf
TVEKPiA+IGlzIG5vdCBzdXBwb3J0ZWQsIGhlbmNlIGl0IHRha2VzIG1heF9xdWV1ZV9wYWlyID0g
MSBieSBpdHNlbGYuCj4gPiBJIHRoaW5rIHRoZSBrZXJuZWwgbW9kdWxlIGhhdmUgYWxsIG5lY2Vz
c2FyeSBpbmZvcm1hdGlvbiBhbmQgaXQgaXMgdGhlIG9ubHkKPiA+IG9uZSB3aGljaCBoYXZlIHBy
ZWNpc2UgaW5mb3JtYXRpb24gb2YgYSBkZXZpY2UsIHNvIGl0IHNob3VsZCBhbnN3ZXIgcHJlY2lz
ZWx5Cj4gPiB0aGFuIGxldCB0aGUgdXNlciBzcGFjZSBndWVzcy4gVGhlIGtlcm5lbCBtb2R1bGUg
c2hvdWxkIGJlIHJlbGlhYmxlIHRoYW4gc3RheQo+ID4gc2lsZW50LCBsZWF2ZSB0aGUgcXVlc3Rp
b24gdG8gdGhlIHVzZXIgc3BhY2UgdG9vbC4KPiBLZXJuZWwgaXMgcmVsaWFibGUuIEl0IGRvZXNu
4oCZdCBleHBvc2UgYSBjb25maWcgc3BhY2UgZmllbGQgaWYgdGhlIGZpZWxkIGRvZXNu4oCZdCBl
eGlzdCByZWdhcmRsZXNzIG9mIGZpZWxkIHNob3VsZCBoYXZlIGRlZmF1bHQgb3Igbm8gZGVmYXVs
dC4KPiBVc2VyIHNwYWNlIHNob3VsZCBub3QgZ3Vlc3MgZWl0aGVyLiBVc2VyIHNwYWNlIGdldHMg
dG8gc2VlIGlmIF9NUSBwcmVzZW50L25vdCBwcmVzZW50LiBJZiBfTVEgcHJlc2VudCB0aGFuIGdl
dCByZWxpYWJsZSBkYXRhIGZyb20ga2VybmVsLgo+IElmIF9NUSBub3QgcHJlc2VudCwgaXQgbWVh
bnMgdGhpcyBkZXZpY2UgaGFzIG9uZSBWUSBwYWlyLgoKWWVzIHRoYXQncyBmaW5lLiBBbmQgaWYg
d2UganVzdCBkaWRuJ3QgcmV0dXJuIGFueXRoaW5nIHdpdGhvdXQgTVEgdGhhdAp3b3VsZCBiZSBm
aW5lLiAgQnV0IElJVUMgbmV0bGluayByZXBvcnRzIHRoZSAjIG9mIHBhaXJzIHJlZ2FyZGxlc3Ms
IGl0Cmp1c3QgcHV0cyAwIHRoZXJlLgoKLS0gCk1TVAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
