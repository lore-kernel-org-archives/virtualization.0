Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F512EB64DD
	for <virtualization@archiver.kernel.org>; Wed,  5 Jul 2023 05:12:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D2D47817A9;
	Wed,  5 Jul 2023 05:12:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D2D47817A9
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fRlkRNQf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TZs7_1UPkRov; Wed,  5 Jul 2023 05:12:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4B00F817A6;
	Wed,  5 Jul 2023 05:11:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4B00F817A6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBD28C0072;
	Wed,  5 Jul 2023 05:11:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1EC45C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 05:11:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E60E860AEA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 05:11:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E60E860AEA
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fRlkRNQf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nct5tFdoWSRw
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 05:11:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EA9BF607D0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EA9BF607D0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 05:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688533915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tO3P2mQX6+9ZgDhiDUsWuq97gou5mJ4BQnOKdZt/xjA=;
 b=fRlkRNQf8wo0cel5+ZJ9THog8swDmAOVKbx6iHHQF/+VpSNra9xUza+wgVNeczT0P/XMgX
 4dX80fMnLBHIVna2hz/RqxiSMlDbtEda6PQThsycSi71K8ZbY5yBLcnUGPtBQihKTwjHMV
 HJOhgO4/L5dOL58O9kIMb4sAXeeQKcY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-jhW0KGy9P6GH7jnzlCMNBQ-1; Wed, 05 Jul 2023 01:11:51 -0400
X-MC-Unique: jhW0KGy9P6GH7jnzlCMNBQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b6fdbe2efdso4049031fa.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Jul 2023 22:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688533909; x=1691125909;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tO3P2mQX6+9ZgDhiDUsWuq97gou5mJ4BQnOKdZt/xjA=;
 b=HBFw/cz6AtyBi8xaeO2kImOMe/MUjXNk6uP+d8eadI5PMBVIvH4IOuSIEzFGuZmWLJ
 9Ehq83IDpD4iYhvy//k5lB9k8Pm8h1HstqrteXiafYPepHGesoKFQsi3fYAY581+3vP+
 fTtC7c68TDcopkQoUHkH5U6OS2NTB/QJZ8P7TS/oMbqZCBenVhxkLy4JhAr2Hk04esZh
 fRs/EEzTsXsVugo9bto5m5ux5yMIPYU4A0e54xLE38MvgHTy4NDlDVjQ1usb0bIcz9ft
 dFv89YmUIBBPyVRNZLPVd+OjIEBNcQJaOs2xtGBTYGn/z24P4tppTf219hqD8ZJdg1db
 6lyg==
X-Gm-Message-State: ABy/qLYuqAGCPn57JvLdcVbhk7Q3qI4UXe6TRbbh+Ex8BTGXFNIOzkSe
 UiPKiUhjMmDJkwqgstnJIbe6qfKEzxVSTEyqwV4ZMojB9L+3u9A94o3QzLq2KWNjJk8gjO5vI2E
 96pl67++ReYxluMzBrG3ilpiQzA+04652dFA9BfRMuIlbI0tZXZZOkgXIQA==
X-Received: by 2002:a2e:9104:0:b0:2b6:9c1d:dea3 with SMTP id
 m4-20020a2e9104000000b002b69c1ddea3mr11475459ljg.2.1688533909764; 
 Tue, 04 Jul 2023 22:11:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGu7A2d5AY6kY3vs5pzspcaW+PcHAazZkUtZptPO44mksXuaFuecbTqN1XahcBVBOOfWpRErBWvTYqQ13Rbu38=
X-Received: by 2002:a2e:9104:0:b0:2b6:9c1d:dea3 with SMTP id
 m4-20020a2e9104000000b002b69c1ddea3mr11475446ljg.2.1688533909459; Tue, 04 Jul
 2023 22:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230703142514.363256-1-eperezma@redhat.com>
 <20230703110241-mutt-send-email-mst@kernel.org>
 <ba5099b8-f72c-f267-41a7-d0ee18680796@oracle.com>
 <20230704061356-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230704061356-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 5 Jul 2023 13:11:37 +0800
Message-ID: <CACGkMEtAfiODhHEMFDKkaVFVs1yjfUFsjfy_=p8Jtd6BXAE1xQ@mail.gmail.com>
Subject: Re: [PATCH] mlx5_vdpa: offer VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, leiyang@redhat.com
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

T24gVHVlLCBKdWwgNCwgMjAyMyBhdCA2OjE24oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBNb24sIEp1bCAwMywgMjAyMyBhdCAwNToyNjowMlBN
IC0wNzAwLCBTaS1XZWkgTGl1IHdyb3RlOgo+ID4KPiA+Cj4gPiBPbiA3LzMvMjAyMyA4OjQ2IEFN
LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+IE9uIE1vbiwgSnVsIDAzLCAyMDIzIGF0
IDA0OjI1OjE0UE0gKzAyMDAsIEV1Z2VuaW8gUMOpcmV6IHdyb3RlOgo+ID4gPiA+IE9mZmVyIHRo
aXMgYmFja2VuZCBmZWF0dXJlIGFzIG1seDUgaXMgY29tcGF0aWJsZSB3aXRoIGl0LiBJdCBhbGxv
d3MgaXQKPiA+ID4gPiB0byBkbyBsaXZlIG1pZ3JhdGlvbiB3aXRoIENWUSwgZHluYW1pY2FsbHkg
c3dpdGNoaW5nIGJldHdlZW4gcGFzc3Rocm91Z2gKPiA+ID4gPiBhbmQgc2hhZG93IHZpcnRxdWV1
ZS4KPiA+ID4gPgo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXpt
YUByZWRoYXQuY29tPgo+ID4gPiBTYW1lIGNvbW1lbnQuCj4gPiB0byB3aGljaD8KPiA+Cj4gPiAt
U2l3ZWkKPgo+IFZIT1NUX0JBQ0tFTkRfRl9FTkFCTEVfQUZURVJfRFJJVkVSX09LIGlzIHRvbyBu
YXJyb3cgYSB1c2UtY2FzZSB0byBjb21taXQgdG8gaXQKPiBhcyBhIGtlcm5lbC91c2Vyc3BhY2Ug
QUJJOiB3aGF0IGlmIG9uZSB3YW50cyB0byBzdGFydCByaW5ncyBpbiBzb21lCj4gb3RoZXIgc3Bl
Y2lmaWMgb3JkZXI/CgpKdXN0IGVuYWJsZSBhIHF1ZXVlIGJ5IHdyaXRpbmcgZS5nIDEgdG8gcXVl
dWVfZW5hYmxlIGluIGEgc3BlY2lmaWMgb3JkZXI/Cgo+IEFzIHdhcyBkaXNjdXNzZWQgb24gbGlz
dCwgYSBiZXR0ZXIgcHJvbWlzZSBpcyBub3QgdG8gYWNjZXNzIHJpbmcKPiB1bnRpbCB0aGUgMXN0
IGtpY2suIHZkcGEgY2FuIHRoZW4gZG8gYSBraWNrIHdoZW4gaXQgd2FudHMKPiB0aGUgZGV2aWNl
IHRvIHN0YXJ0IGFjY2Vzc2luZyByaW5ncy4KClJldGhpbmsgYWJvdXQgdGhlIEFDQ0VTU19BRlRF
Ul9LSUNLLCBpdCBzb3VuZHMgZnVuY3Rpb25hbCBlcXVpdmFsZW50CnRvIGFsbG93IHF1ZXVlX2Vu
YWJsZSBhZnRlciBEUklWRVJfT0ssIGJ1dCBpdCBzZWVtcyB0byBoYXZlCmRpc3RhbnZhZ2VzOgoK
QSBidXN5IHBvbGxpbmcgc29mdHdhcmUgZGV2aWNlIG1heSBkaXNhYmxlIG5vdGlmaWNhdGlvbnMg
YW5kIG5ldmVyCnJlc3BvbmQgdG8gcmVnaXN0ZXIgdG8gYW55IGtpY2sgbm90aWZpZXJzLiBBQ0NF
U1NfQUZURVJfS0lDSyB3aWxsCmludHJvZHVjZSBvdmVyaGVhZCB0byB0aG9zZSBpbXBsZW1lbnRh
dGlvbnMuCgpUaGFua3MKCj4KPiA+ID4KPiA+ID4gPiAtLS0KPiA+ID4gPiAgIGRyaXZlcnMvdmRw
YS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDcgKysrKysrKwo+ID4gPiA+ICAgMSBmaWxlIGNoYW5n
ZWQsIDcgaW5zZXJ0aW9ucygrKQo+ID4gPiA+Cj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3Zu
ZXQuYwo+ID4gPiA+IGluZGV4IDkxMzhlZjJmYjJjOC4uNWYzMDlhMTZiOWRjIDEwMDY0NAo+ID4g
PiA+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ID4gPiA+ICsrKyBi
L2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ID4gPiA+IEBAIC03LDYgKzcsNyBA
QAo+ID4gPiA+ICAgI2luY2x1ZGUgPHVhcGkvbGludXgvdmlydGlvX25ldC5oPgo+ID4gPiA+ICAg
I2luY2x1ZGUgPHVhcGkvbGludXgvdmlydGlvX2lkcy5oPgo+ID4gPiA+ICAgI2luY2x1ZGUgPHVh
cGkvbGludXgvdmRwYS5oPgo+ID4gPiA+ICsjaW5jbHVkZSA8dWFwaS9saW51eC92aG9zdF90eXBl
cy5oPgo+ID4gPiA+ICAgI2luY2x1ZGUgPGxpbnV4L3ZpcnRpb19jb25maWcuaD4KPiA+ID4gPiAg
ICNpbmNsdWRlIDxsaW51eC9hdXhpbGlhcnlfYnVzLmg+Cj4gPiA+ID4gICAjaW5jbHVkZSA8bGlu
dXgvbWx4NS9jcS5oPgo+ID4gPiA+IEBAIC0yNDk5LDYgKzI1MDAsMTEgQEAgc3RhdGljIHZvaWQg
dW5yZWdpc3Rlcl9saW5rX25vdGlmaWVyKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2KQo+ID4g
PiA+ICAgICAgICAgICAgICAgICAgIGZsdXNoX3dvcmtxdWV1ZShuZGV2LT5tdmRldi53cSk7Cj4g
PiA+ID4gICB9Cj4gPiA+ID4gK3N0YXRpYyB1NjQgbWx4NV92ZHBhX2dldF9iYWNrZW5kX2ZlYXR1
cmVzKGNvbnN0IHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSkKPiA+ID4gPiArewo+ID4gPiA+ICsg
cmV0dXJuIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX0VOQUJMRV9BRlRFUl9EUklWRVJfT0spOwo+
ID4gPiA+ICt9Cj4gPiA+ID4gKwo+ID4gPiA+ICAgc3RhdGljIGludCBtbHg1X3ZkcGFfc2V0X2Ry
aXZlcl9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHU2NCBmZWF0dXJlcykKPiA+
ID4gPiAgIHsKPiA+ID4gPiAgICAgICAgICAgc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2ID0g
dG9fbXZkZXYodmRldik7Cj4gPiA+ID4gQEAgLTMxNDAsNiArMzE0Niw3IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzIG1seDVfdmRwYV9vcHMgPSB7Cj4gPiA+ID4gICAgICAg
ICAgIC5nZXRfdnFfYWxpZ24gPSBtbHg1X3ZkcGFfZ2V0X3ZxX2FsaWduLAo+ID4gPiA+ICAgICAg
ICAgICAuZ2V0X3ZxX2dyb3VwID0gbWx4NV92ZHBhX2dldF92cV9ncm91cCwKPiA+ID4gPiAgICAg
ICAgICAgLmdldF9kZXZpY2VfZmVhdHVyZXMgPSBtbHg1X3ZkcGFfZ2V0X2RldmljZV9mZWF0dXJl
cywKPiA+ID4gPiArIC5nZXRfYmFja2VuZF9mZWF0dXJlcyA9IG1seDVfdmRwYV9nZXRfYmFja2Vu
ZF9mZWF0dXJlcywKPiA+ID4gPiAgICAgICAgICAgLnNldF9kcml2ZXJfZmVhdHVyZXMgPSBtbHg1
X3ZkcGFfc2V0X2RyaXZlcl9mZWF0dXJlcywKPiA+ID4gPiAgICAgICAgICAgLmdldF9kcml2ZXJf
ZmVhdHVyZXMgPSBtbHg1X3ZkcGFfZ2V0X2RyaXZlcl9mZWF0dXJlcywKPiA+ID4gPiAgICAgICAg
ICAgLnNldF9jb25maWdfY2IgPSBtbHg1X3ZkcGFfc2V0X2NvbmZpZ19jYiwKPiA+ID4gPiAtLQo+
ID4gPiA+IDIuMzkuMwo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
