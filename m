Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4B1C001DB
	for <virtualization@archiver.kernel.org>; Fri, 11 Aug 2023 09:48:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A30581420;
	Fri, 11 Aug 2023 09:48:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5A30581420
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i6KGhJ1i
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g99Ip8ja39jg; Fri, 11 Aug 2023 09:48:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8DE9381414;
	Fri, 11 Aug 2023 09:48:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8DE9381414
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65144C0072;
	Fri, 11 Aug 2023 09:48:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3BFF6C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 09:48:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0FD4F60BCB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 09:48:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0FD4F60BCB
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=i6KGhJ1i
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X1oOG0tmbvHD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 09:48:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 094EC60A93
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 09:48:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 094EC60A93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691747329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fuPwMiCOds871v8o/ogtGSupZ7sHE8svUP10CQtFD/o=;
 b=i6KGhJ1igbSShxZa6tfwrXxa7Hm3iCDUvHMVw/MAe/4PuIYtMMCJuoPbzrVvej7QXTEn1Y
 OD5c49ZruDbFozKDN3dVNYYUlNxq3UE0kO0OQfscuhaT0V7BjGvUCsCp9ZAZWkOUssFy2b
 2dL5M8AwSYXaemhL1GGlWQlgYkjH6Us=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-B6UWLATvOVWafIKldIFWNA-1; Fri, 11 Aug 2023 05:48:47 -0400
X-MC-Unique: B6UWLATvOVWafIKldIFWNA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f5df65fa35so11443395e9.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 02:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691747326; x=1692352126;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fuPwMiCOds871v8o/ogtGSupZ7sHE8svUP10CQtFD/o=;
 b=MONrQmvo4ka9nGXE2Kb/jLxxDg64x0D5lbroynykExjehRF6bmmMkZUwOiPgSzRh4B
 B71jW+kElMpFdFle6/friQB3UUjeFK0VgeucKDureFO1FQFFKwMG+BbFAdxmlnfX33ZJ
 ZE43KSe3+neszRUgejcDEGgdOQ71Oy56vn4WMaA0yE0SVA3Ys91WskePls9zcB/M9O7U
 XOp5Dc1i1aLMViDwI94OGhARP1V9h7E9LT8n5UkAP0fk2s9fRKF8BmiwbzwamT4qNy9J
 ChCSu2LV0kp5/dGTheC/B3fVzC5Li6AWIRrT69RqGb+G2qsQiGolHgm03HqM8RsbNL8W
 ug8g==
X-Gm-Message-State: AOJu0YwmSgIK25q9k3eSKHDfVZwionNZJRgMOLYWq9rH0uGDn6LOHZ+u
 tECmFhOPNyjE1jAfgGdvCS4cUGb5SYFEPHqkY4NDo3lzLbo/LtHi4Lbv/S/lea5iPzhbjAcURd2
 7TH3tX+zHVwM9ejX8d8YZclTARvFkq/b2QlnCEYf4qA==
X-Received: by 2002:a1c:cc12:0:b0:3fa:8db4:91ec with SMTP id
 h18-20020a1ccc12000000b003fa8db491ecmr1134556wmb.10.1691747326505; 
 Fri, 11 Aug 2023 02:48:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGf9bXPD4yjwvlp8v42lTNJRVWFj4ngnnn3DuWzV+hlTBAZcBoR/XB3/gpHHTV7jqPuGXB0EA==
X-Received: by 2002:a1c:cc12:0:b0:3fa:8db4:91ec with SMTP id
 h18-20020a1ccc12000000b003fa8db491ecmr1134544wmb.10.1691747326177; 
 Fri, 11 Aug 2023 02:48:46 -0700 (PDT)
Received: from redhat.com ([2.55.42.146]) by smtp.gmail.com with ESMTPSA id
 c16-20020a7bc010000000b003fc00212c1esm4709023wmb.28.2023.08.11.02.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 02:48:45 -0700 (PDT)
Date: Fri, 11 Aug 2023 05:48:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio_vdpa: build affinity masks conditionally
Message-ID: <20230811054736-mutt-send-email-mst@kernel.org>
References: <20230811091539.1359865-1-jasowang@redhat.com>
 <20230811052435-mutt-send-email-mst@kernel.org>
 <CACGkMEuO+smLSY+dRvDOar=pq6MpOv3U9z6gX=xRUkHg494MFw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuO+smLSY+dRvDOar=pq6MpOv3U9z6gX=xRUkHg494MFw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, xieyongji@bytedance.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

T24gRnJpLCBBdWcgMTEsIDIwMjMgYXQgMDU6NDE6NDRQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBGcmksIEF1ZyAxMSwgMjAyMyBhdCA1OjI14oCvUE0gTWljaGFlbCBTLiBUc2lya2lu
IDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gRnJpLCBBdWcgMTEsIDIwMjMgYXQg
MDU6MTU6MzlBTSAtMDQwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gV2UgdHJ5IHRvIGJ1aWxk
IGFmZmluaXR5IG1hc2sgdmlhIGNyZWF0ZV9hZmZpbml0eV9tYXNrcygpCj4gPiA+IHVuY29uZGl0
aW9uYWxseSB3aGljaCBtYXkgbGVhZCBzZXZlcmFsIGlzc3VlczoKPiA+ID4KPiA+ID4gLSB0aGUg
YWZmaW5pdHkgbWFzayBpcyBub3QgdXNlZCBmb3IgcGFyZW50IHdpdGhvdXQgYWZmaW5pdHkgc3Vw
cG9ydAo+ID4gPiAgIChvbmx5IFZEVVNFIHN1cHBvcnQgdGhlIGFmZmluaXR5IG5vdykKPiA+ID4g
LSB0aGUgbG9naWMgb2YgY3JlYXRlX2FmZmluaXR5X21hc2tzKCkgbWlnaHQgbm90IHdvcmsgZm9y
IGRldmljZXMKPiA+ID4gICBvdGhlciB0aGFuIGJsb2NrLiBGb3IgZXhhbXBsZSBpdCdzIG5vdCBy
YXJlIGluIHRoZSBuZXR3b3JraW5nIGRldmljZQo+ID4gPiAgIHdoZXJlIHRoZSBudW1iZXIgb2Yg
cXVldWVzIGNvdWxkIGV4Y2VlZCB0aGUgbnVtYmVyIG9mIENQVXMuIFN1Y2gKPiA+ID4gICBjYXNl
IGJyZWFrcyB0aGUgY3VycmVudCBhZmZpbml0eSBsb2dpYyB3aGljaCBpcyBiYXNlZCBvbgo+ID4g
PiAgIGdyb3VwX2NwdXNfZXZlbmx5KCkgd2hvIGFzc3VtZXMgdGhlIG51bWJlciBvZiBDUFVzIGFy
ZSBub3QgbGVzcyB0aGFuCj4gPiA+ICAgdGhlIG51bWJlciBvZiBncm91cHMuIFRoaXMgY2FuIHRy
aWdnZXIgYSB3YXJuaW5nWzFdOgo+ID4gPgo+ID4gPiAgICAgICBpZiAocmV0ID49IDApCj4gPiA+
ICAgICAgICAgICAgICAgV0FSTl9PTihucl9wcmVzZW50ICsgbnJfb3RoZXJzIDwgbnVtZ3Jwcyk7
Cj4gPiA+Cj4gPiA+IEZpeGluZyB0aGlzIGJ5IG9ubHkgYnVpbGQgdGhlIGFmZmluaXR5IG1hc2tz
IG9ubHkgd2hlbgo+ID4gPgo+ID4gPiAtIERyaXZlciBwYXNzZXMgYWZmaW5pdHkgZGVzY3JpcHRv
ciwgZHJpdmVyIGxpa2UgdmlydGlvLWJsayBjYW4gbWFrZQo+ID4gPiAgIHN1cmUgdG8gbGltaXQg
dGhlIG51bWJlciBvZiBxdWV1ZXMgd2hlbiBpdCBleGNlZWRzIHRoZSBudW1iZXIgb2YgQ1BVcwo+
ID4gPiAtIFBhcmVudCBzdXBwb3J0IGFmZmluaXR5IHNldHRpbmcgY29uZmlnIG9wcwo+ID4gPgo+
ID4gPiBUaGlzIGhlbHAgdG8gYXZvaWQgdGhlIHdhcm5pbmcuIE1vcmUgb3B0aW1pemF0aW9ucyBj
b3VsZCBiZSBkb25lIG9uCj4gPiA+IHRvcC4KPiA+ID4KPiA+ID4gWzFdCj4gPiA+IFsgIDY4Mi4x
NDY2NTVdIFdBUk5JTkc6IENQVTogNiBQSUQ6IDE1NTAgYXQgbGliL2dyb3VwX2NwdXMuYzo0MDAg
Z3JvdXBfY3B1c19ldmVubHkrMHgxYWEvMHgxYzAKPiA+ID4gWyAgNjgyLjE0NjY2OF0gQ1BVOiA2
IFBJRDogMTU1MCBDb21tOiB2ZHBhIE5vdCB0YWludGVkIDYuNS4wLXJjNWphc29uKyAjNzkKPiA+
ID4gWyAgNjgyLjE0NjY3MV0gSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoaTQ0MEZY
ICsgUElJWCwgMTk5NiksIEJJT1MgcmVsLTEuMTYuMi0wLWdlYTFiN2EwNzMzOTAtcHJlYnVpbHQu
cWVtdS5vcmcgMDQvMDEvMjAxNAo+ID4gPiBbICA2ODIuMTQ2NjczXSBSSVA6IDAwMTA6Z3JvdXBf
Y3B1c19ldmVubHkrMHgxYWEvMHgxYzAKPiA+ID4gWyAgNjgyLjE0NjY3Nl0gQ29kZTogNGMgODkg
ZTAgNWIgNWQgNDEgNWMgNDEgNWQgNDEgNWUgYzMgY2MgY2MgY2MgY2MgZTggMWIgYzQgNzQgZmYg
NDggODkgZWYgZTggMTMgYWMgOTggZmYgNGMgODkgZTcgNDUgMzEgZTQgZTggMDggYWMgOTggZmYg
ZWIgYzIgPDBmPiAwYiBlYiBiNiBlOCBmZCAwNSBjMyAwMCA0NSAzMSBlNCBlYiBlNSBjYyBjYyBj
YyBjYyBjYyBjYyBjYyBjYwo+ID4gPiBbICA2ODIuMTQ2Njc5XSBSU1A6IDAwMTg6ZmZmZmM5MDAw
MjE1ZjQ5OCBFRkxBR1M6IDAwMDEwMjkzCj4gPiA+IFsgIDY4Mi4xNDY2ODJdIFJBWDogMDAwMDAw
MDAwMDAxZjFlMCBSQlg6IDAwMDAwMDAwMDAwMDAwNDEgUkNYOiAwMDAwMDAwMDAwMDAwMDAwCj4g
PiA+IFsgIDY4Mi4xNDY2ODRdIFJEWDogZmZmZjg4ODEwOTkyMjA1OCBSU0k6IDAwMDAwMDAwMDAw
MDAwNDEgUkRJOiAwMDAwMDAwMDAwMDAwMDMwCj4gPiA+IFsgIDY4Mi4xNDY2ODZdIFJCUDogZmZm
Zjg4ODEwOTkyMjA1OCBSMDg6IGZmZmZjOTAwMDIxNWY0OTggUjA5OiBmZmZmYzkwMDAyMTVmNGEw
Cj4gPiA+IFsgIDY4Mi4xNDY2ODddIFIxMDogMDAwMDAwMDAwMDAxOThkMCBSMTE6IDAwMDAwMDAw
MDAwMDAwMzAgUjEyOiBmZmZmODg4MTA3ZTAyODAwCj4gPiA+IFsgIDY4Mi4xNDY2ODldIFIxMzog
MDAwMDAwMDAwMDAwMDAzMCBSMTQ6IDAwMDAwMDAwMDAwMDAwMzAgUjE1OiAwMDAwMDAwMDAwMDAw
MDQxCj4gPiA+IFsgIDY4Mi4xNDY2OTJdIEZTOiAgMDAwMDdmZWY1MjMxNTc0MCgwMDAwKSBHUzpm
ZmZmODg4MjM3MzgwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDAKPiA+ID4gWyAgNjgy
LjE0NjY5NV0gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAz
Mwo+ID4gPiBbICA2ODIuMTQ2Njk2XSBDUjI6IDAwMDA3ZmVmNTI1MDkwMDAgQ1IzOiAwMDAwMDAw
MTEwZGJjMDA0IENSNDogMDAwMDAwMDAwMDM3MGVlMAo+ID4gPiBbICA2ODIuMTQ2Njk4XSBEUjA6
IDAwMDAwMDAwMDAwMDAwMDAgRFIxOiAwMDAwMDAwMDAwMDAwMDAwIERSMjogMDAwMDAwMDAwMDAw
MDAwMAo+ID4gPiBbICA2ODIuMTQ2NzAwXSBEUjM6IDAwMDAwMDAwMDAwMDAwMDAgRFI2OiAwMDAw
MDAwMGZmZmUwZmYwIERSNzogMDAwMDAwMDAwMDAwMDQwMAo+ID4gPiBbICA2ODIuMTQ2NzAxXSBD
YWxsIFRyYWNlOgo+ID4gPiBbICA2ODIuMTQ2NzAzXSAgPFRBU0s+Cj4gPiA+IFsgIDY4Mi4xNDY3
MDVdICA/IF9fd2FybisweDdiLzB4MTMwCj4gPiA+IFsgIDY4Mi4xNDY3MDldICA/IGdyb3VwX2Nw
dXNfZXZlbmx5KzB4MWFhLzB4MWMwCj4gPiA+IFsgIDY4Mi4xNDY3MTJdICA/IHJlcG9ydF9idWcr
MHgxYzgvMHgxZTAKPiA+ID4gWyAgNjgyLjE0NjcxN10gID8gaGFuZGxlX2J1ZysweDNjLzB4NzAK
PiA+ID4gWyAgNjgyLjE0NjcyMV0gID8gZXhjX2ludmFsaWRfb3ArMHgxNC8weDcwCj4gPiA+IFsg
IDY4Mi4xNDY3MjNdICA/IGFzbV9leGNfaW52YWxpZF9vcCsweDE2LzB4MjAKPiA+ID4gWyAgNjgy
LjE0NjcyN10gID8gZ3JvdXBfY3B1c19ldmVubHkrMHgxYWEvMHgxYzAKPiA+ID4gWyAgNjgyLjE0
NjcyOV0gID8gZ3JvdXBfY3B1c19ldmVubHkrMHgxNWMvMHgxYzAKPiA+ID4gWyAgNjgyLjE0Njcz
MV0gIGNyZWF0ZV9hZmZpbml0eV9tYXNrcysweGFmLzB4MWEwCj4gPiA+IFsgIDY4Mi4xNDY3MzVd
ICB2aXJ0aW9fdmRwYV9maW5kX3ZxcysweDgzLzB4MWQwCj4gPiA+IFsgIDY4Mi4xNDY3MzhdICA/
IF9fcGZ4X2RlZmF1bHRfY2FsY19zZXRzKzB4MTAvMHgxMAo+ID4gPiBbICA2ODIuMTQ2NzQyXSAg
dmlydG5ldF9maW5kX3ZxcysweDFmMC8weDM3MAo+ID4gPiBbICA2ODIuMTQ2NzQ3XSAgdmlydG5l
dF9wcm9iZSsweDUwMS8weGNkMAo+ID4gPiBbICA2ODIuMTQ2NzQ5XSAgPyB2cF9tb2Rlcm5fZ2V0
X3N0YXR1cysweDEyLzB4MjAKPiA+ID4gWyAgNjgyLjE0Njc1MV0gID8gZ2V0X2NhcF9hZGRyLmlz
cmEuMCsweDEwLzB4YzAKPiA+ID4gWyAgNjgyLjE0Njc1NF0gIHZpcnRpb19kZXZfcHJvYmUrMHgx
YWYvMHgyNjAKPiA+ID4gWyAgNjgyLjE0Njc1OV0gIHJlYWxseV9wcm9iZSsweDFhNS8weDQxMAo+
ID4gPgo+ID4gPiBGaXhlczogM2RhZDU2ODIzYjUzICgidmlydGlvLXZkcGE6IFN1cHBvcnQgaW50
ZXJydXB0IGFmZmluaXR5IHNwcmVhZGluZyBtZWNoYW5pc20iKQo+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4KPiA+IFRoaXMgd29uJ3QgZml4
IHRoZSBjYXNlIHdoZXJlIGJsb2NrIGhhcyBtb3JlIHF1ZXVlcyB0aGFuIENQVXMgdGhvdWdoLAo+
ID4gd2lsbCBpdD8KPiAKPiBCbG9jayB3aWxsIGxpbWl0IHRoZSBudW1iZXIgb2YgcXVldWVzIGR1
cmluZyBpbml0X3ZxKCk6Cj4gCj4gICAgICAgICBudW1fdnFzID0gbWluX3QodW5zaWduZWQgaW50
LAo+ICAgICAgICAgICAgICAgICAgICAgICAgIG1pbl9ub3RfemVybyhudW1fcmVxdWVzdF9xdWV1
ZXMsIG5yX2NwdV9pZHMpLAo+ICAgICAgICAgICAgICAgICAgICAgICAgIG51bV92cXMpOwo+IAo+
IAo+IFRoYW5rcwoKR29vZCBwb2ludC4gVGhpcyBkb2Vzbid0IHBsYXkgd2VsbCB3aXRoIGNwdSBo
b3RwbHVnIGJ1dCB0aGF0IGlzIG5vdCBuZXcuCgo+ID4KPiA+ID4gLS0tCj4gPiA+ICBkcml2ZXJz
L3ZpcnRpby92aXJ0aW9fdmRwYS5jIHwgMTcgKysrKysrKysrKystLS0tLS0KPiA+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+ID4gPgo+ID4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYyBiL2RyaXZlcnMvdmlydGlv
L3ZpcnRpb192ZHBhLmMKPiA+ID4gaW5kZXggOTYxMTYxZGE1OTAwLi4wNmNlNmQ4YzJlMDAgMTAw
NjQ0Cj4gPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMKPiA+ID4gKysrIGIv
ZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYwo+ID4gPiBAQCAtMzY2LDExICszNjYsMTQgQEAg
c3RhdGljIGludCB2aXJ0aW9fdmRwYV9maW5kX3ZxcyhzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRl
diwgdW5zaWduZWQgaW50IG52cXMsCj4gPiA+ICAgICAgIHN0cnVjdCBpcnFfYWZmaW5pdHkgZGVm
YXVsdF9hZmZkID0geyAwIH07Cj4gPiA+ICAgICAgIHN0cnVjdCBjcHVtYXNrICptYXNrczsKPiA+
ID4gICAgICAgc3RydWN0IHZkcGFfY2FsbGJhY2sgY2I7Cj4gPiA+ICsgICAgIGJvb2wgaGFzX2Fm
ZmluaXR5ID0gZGVzYyAmJiBvcHMtPnNldF92cV9hZmZpbml0eTsKPiA+ID4gICAgICAgaW50IGks
IGVyciwgcXVldWVfaWR4ID0gMDsKPiA+ID4KPiA+ID4gLSAgICAgbWFza3MgPSBjcmVhdGVfYWZm
aW5pdHlfbWFza3MobnZxcywgZGVzYyA/IGRlc2MgOiAmZGVmYXVsdF9hZmZkKTsKPiA+ID4gLSAg
ICAgaWYgKCFtYXNrcykKPiA+ID4gLSAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsKPiA+ID4g
KyAgICAgaWYgKGhhc19hZmZpbml0eSkgewo+ID4gPiArICAgICAgICAgICAgIG1hc2tzID0gY3Jl
YXRlX2FmZmluaXR5X21hc2tzKG52cXMsIGRlc2MgPyBkZXNjIDogJmRlZmF1bHRfYWZmZCk7Cj4g
PiA+ICsgICAgICAgICAgICAgaWYgKCFtYXNrcykKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAg
IHJldHVybiAtRU5PTUVNOwo+ID4gPiArICAgICB9Cj4gPiA+Cj4gPiA+ICAgICAgIGZvciAoaSA9
IDA7IGkgPCBudnFzOyArK2kpIHsKPiA+ID4gICAgICAgICAgICAgICBpZiAoIW5hbWVzW2ldKSB7
Cj4gPiA+IEBAIC0zODYsMjAgKzM4OSwyMiBAQCBzdGF0aWMgaW50IHZpcnRpb192ZHBhX2ZpbmRf
dnFzKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBpbnQgbnZxcywKPiA+ID4g
ICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyX3NldHVwX3ZxOwo+ID4gPiAgICAgICAgICAg
ICAgIH0KPiA+ID4KPiA+ID4gLSAgICAgICAgICAgICBpZiAob3BzLT5zZXRfdnFfYWZmaW5pdHkp
Cj4gPiA+ICsgICAgICAgICAgICAgaWYgKGhhc19hZmZpbml0eSkKPiA+ID4gICAgICAgICAgICAg
ICAgICAgICAgIG9wcy0+c2V0X3ZxX2FmZmluaXR5KHZkcGEsIGksICZtYXNrc1tpXSk7Cj4gPiA+
ICAgICAgIH0KPiA+ID4KPiA+ID4gICAgICAgY2IuY2FsbGJhY2sgPSB2aXJ0aW9fdmRwYV9jb25m
aWdfY2I7Cj4gPiA+ICAgICAgIGNiLnByaXZhdGUgPSB2ZF9kZXY7Cj4gPiA+ICAgICAgIG9wcy0+
c2V0X2NvbmZpZ19jYih2ZHBhLCAmY2IpOwo+ID4gPiAtICAgICBrZnJlZShtYXNrcyk7Cj4gPiA+
ICsgICAgIGlmIChoYXNfYWZmaW5pdHkpCj4gPiA+ICsgICAgICAgICAgICAga2ZyZWUobWFza3Mp
Owo+ID4gPgo+ID4gPiAgICAgICByZXR1cm4gMDsKPiA+ID4KPiA+ID4gIGVycl9zZXR1cF92cToK
PiA+ID4gICAgICAgdmlydGlvX3ZkcGFfZGVsX3Zxcyh2ZGV2KTsKPiA+ID4gLSAgICAga2ZyZWUo
bWFza3MpOwo+ID4gPiArICAgICBpZiAoaGFzX2FmZmluaXR5KQo+ID4gPiArICAgICAgICAgICAg
IGtmcmVlKG1hc2tzKTsKPiA+ID4gICAgICAgcmV0dXJuIGVycjsKPiA+ID4gIH0KPiA+ID4KPiA+
ID4gLS0KPiA+ID4gMi4zOS4zCj4gPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
