Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EDDC6FD19
	for <virtualization@archiver.kernel.org>; Thu, 16 Mar 2023 09:30:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E897581F6D;
	Thu, 16 Mar 2023 09:30:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E897581F6D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Iq2qwNh/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oWRplx2Aoh0t; Thu, 16 Mar 2023 09:30:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 592D881EA4;
	Thu, 16 Mar 2023 09:30:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 592D881EA4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B435C0035;
	Thu, 16 Mar 2023 09:30:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8AA5CC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 09:30:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 65FE46103C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 09:30:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 65FE46103C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Iq2qwNh/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0sWr_5d1TeJh
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 09:30:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 84FF961025
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 84FF961025
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 09:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678959049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zu9LuzlUExdZmSdDNar6TeB+0bukdqYe3ZDHoEtXKpo=;
 b=Iq2qwNh/iIi9t5OUA45YA+qBiaNSakSaVSyCCkscwm1sMdK8fMmTfSPzVGUPHUmX1Vc0mP
 iQKaye/bezCjrV/MFS9qbmqHeWrxsuotTbND9PDEOuMOUiBs6qAHHGVK1yZo+0ptoP5WVu
 nyMeCIo8KGsqja9iiyEzmQodBkOOtEg=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-OoOvY7RoMP6Ss4BNqqTPAw-1; Thu, 16 Mar 2023 05:30:48 -0400
X-MC-Unique: OoOvY7RoMP6Ss4BNqqTPAw-1
Received: by mail-oo1-f72.google.com with SMTP id
 z30-20020a4a9861000000b0053714e6f1b7so215620ooi.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 02:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678959047;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zu9LuzlUExdZmSdDNar6TeB+0bukdqYe3ZDHoEtXKpo=;
 b=CUiwM5wIlJwnqtRYQfe375c0cdqi83i72u2KjN1BP/3WijMHS0Typ8+flzMHFzHSA+
 l+kBKBdK3aeCqDSMMdCG1H6AJLzcbJ1plD/aUN3lAqPgkLsE3KHj9l3FBFN6JJ89Q90r
 t+HPxByhfx+xooK4RJ+0ky0zLcil5wOKzv8FWVmbNzWQcjE6xKL0Jmqq7xSyzcUgdy3Y
 NyyYR37/T4zuEhMcZAFWjFHADr0Kev7AB4JivPlaYVhUoNV9AxqSXrK97X6KaqVLiQwz
 hVaI83LAbeNNsV08MlmOaKSdCdtkyIaIJXC05zfzXY4YHRPLMi+u44xmZwxqwdT2Injk
 nVkg==
X-Gm-Message-State: AO0yUKVQM+2hThErmoP1igpBvLEOam+mhpr9m+qP9idRTWW+EJoH4qPV
 XRrDSN8wbPL0SsI58cVgY7+/G6rd5fqNLJCtKs7rVqzIyMXfKJBnjZJRHHRsdTi8MV8LQGVFD15
 wif0Va55nxsXLV0RFQITpWwPIETgzBYBLe3AXn/z4noK5kS3ftoBkvVsnBg==
X-Received: by 2002:a05:6871:2315:b0:177:c2fb:8cec with SMTP id
 sf21-20020a056871231500b00177c2fb8cecmr5522604oab.9.1678959047664; 
 Thu, 16 Mar 2023 02:30:47 -0700 (PDT)
X-Google-Smtp-Source: AK7set/MybTeH6VqAhE6xW1v6MuEEwFvUz7vDxe6JlWA6itRvqzS2b2MeUvZgRHhXHPLtM8/IAiqnOcLk9frG3LphUI=
X-Received: by 2002:a05:6871:2315:b0:177:c2fb:8cec with SMTP id
 sf21-20020a056871231500b00177c2fb8cecmr5522601oab.9.1678959047461; Thu, 16
 Mar 2023 02:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230228094110.37-1-xieyongji@bytedance.com>
 <20230228094110.37-10-xieyongji@bytedance.com>
In-Reply-To: <20230228094110.37-10-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 16 Mar 2023 17:30:36 +0800
Message-ID: <CACGkMEsaeAJbTzx0M3DJzt=dwWyWvX79L1tapfZ1O-AKyG73Mw@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] vduse: Signal interrupt's eventfd directly in
 vhost-vdpa case
To: Xie Yongji <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
 virtualization@lists.linux-foundation.org, hch@lst.de, mst@redhat.com
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

T24gVHVlLCBGZWIgMjgsIDIwMjMgYXQgNTo0MuKAr1BNIFhpZSBZb25namkgPHhpZXlvbmdqaUBi
eXRlZGFuY2UuY29tPiB3cm90ZToKPgo+IE5vdyB0aGUgdmRwYSBjYWxsYmFjayB3aWxsIGFzc29j
aWF0ZSBhbiBldmVudGZkIGluCj4gdmhvc3QtdmRwYSBjYXNlLgoKSSdkIHN1Z2dlc3QgYXZvaWRp
bmcgbWVudGlvbmluZyBkcml2ZXJzIHNpbmNlIHZEUEEgcGFyZW50cyBzaG91bGQgbm90Cmtub3cg
d2hpY2ggdkRQQSBkcml2ZXIgaXMgYm91bmQuCgpXZSBjb3VsZCBzYXkgInNpZ25hbCB2cSB0cmln
Z2VyIGV2ZW50ZmQgZGlyZWN0bHkgaWYgcG9zc2libGUiPwoKV2l0aCB0aG9zZSB0d2Vha2VkLgoK
QWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MKCj4gRm9y
IHBlcmZvcm1hbmNlIHJlYXNvbnMsIFZEVVNFIGNhbgo+IHNpZ25hbCBpdCBkaXJlY3RseSBkdXJp
bmcgaXJxIGluamVjdGlvbi4KPgo+IFNpZ25lZC1vZmYtYnk6IFhpZSBZb25namkgPHhpZXlvbmdq
aUBieXRlZGFuY2UuY29tPgo+IC0tLQo+ICBkcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rl
di5jIHwgMjcgKysrKysrKysrKysrKysrKysrKysrKystLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAy
MyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMgYi9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNl
X2Rldi5jCj4gaW5kZXggODY5Y2M3ODYwZDgyLi41NmYzYzI0ODBjMmEgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS92
ZHBhX3VzZXIvdmR1c2VfZGV2LmMKPiBAQCAtNDYxLDYgKzQ2MSw3IEBAIHN0YXRpYyB2b2lkIHZk
dXNlX2Rldl9yZXNldChzdHJ1Y3QgdmR1c2VfZGV2ICpkZXYpCj4gICAgICAgICAgICAgICAgIHNw
aW5fbG9jaygmdnEtPmlycV9sb2NrKTsKPiAgICAgICAgICAgICAgICAgdnEtPmNiLmNhbGxiYWNr
ID0gTlVMTDsKPiAgICAgICAgICAgICAgICAgdnEtPmNiLnByaXZhdGUgPSBOVUxMOwo+ICsgICAg
ICAgICAgICAgICB2cS0+Y2IuaXJxX2N0eCA9IE5VTEw7Cj4gICAgICAgICAgICAgICAgIHNwaW5f
dW5sb2NrKCZ2cS0+aXJxX2xvY2spOwo+ICAgICAgICAgICAgICAgICBmbHVzaF93b3JrKCZ2cS0+
aW5qZWN0KTsKPiAgICAgICAgICAgICAgICAgZmx1c2hfd29yaygmdnEtPmtpY2spOwo+IEBAIC01
MjYsNiArNTI3LDcgQEAgc3RhdGljIHZvaWQgdmR1c2VfdmRwYV9zZXRfdnFfY2Ioc3RydWN0IHZk
cGFfZGV2aWNlICp2ZHBhLCB1MTYgaWR4LAo+ICAgICAgICAgc3Bpbl9sb2NrKCZ2cS0+aXJxX2xv
Y2spOwo+ICAgICAgICAgdnEtPmNiLmNhbGxiYWNrID0gY2ItPmNhbGxiYWNrOwo+ICAgICAgICAg
dnEtPmNiLnByaXZhdGUgPSBjYi0+cHJpdmF0ZTsKPiArICAgICAgIHZxLT5jYi5pcnFfY3R4ID0g
Y2ItPmlycV9jdHg7Cj4gICAgICAgICBzcGluX3VubG9jaygmdnEtPmlycV9sb2NrKTsKPiAgfQo+
Cj4gQEAgLTEwMjAsNiArMTAyMiwyMCBAQCBzdGF0aWMgdm9pZCB2ZHVzZV92cV9pcnFfaW5qZWN0
KHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKPiAgICAgICAgIHNwaW5fdW5sb2NrX2lycSgmdnEt
PmlycV9sb2NrKTsKPiAgfQo+Cj4gK3N0YXRpYyBib29sIHZkdXNlX3ZxX3NpZ25hbF9pcnFmZChz
dHJ1Y3QgdmR1c2VfdmlydHF1ZXVlICp2cSkKPiArewo+ICsgICAgICAgYm9vbCBzaWduYWwgPSBm
YWxzZTsKPiArCj4gKyAgICAgICBzcGluX2xvY2tfaXJxKCZ2cS0+aXJxX2xvY2spOwo+ICsgICAg
ICAgaWYgKHZxLT5yZWFkeSAmJiB2cS0+Y2IuaXJxX2N0eCkgewo+ICsgICAgICAgICAgICAgICBl
dmVudGZkX3NpZ25hbCh2cS0+Y2IuaXJxX2N0eCwgMSk7Cj4gKyAgICAgICAgICAgICAgIHNpZ25h
bCA9IHRydWU7Cj4gKyAgICAgICB9Cj4gKyAgICAgICBzcGluX3VubG9ja19pcnEoJnZxLT5pcnFf
bG9jayk7Cj4gKwo+ICsgICAgICAgcmV0dXJuIHNpZ25hbDsKPiArfQo+ICsKPiAgc3RhdGljIGlu
dCB2ZHVzZV9kZXZfcXVldWVfaXJxX3dvcmsoc3RydWN0IHZkdXNlX2RldiAqZGV2LAo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB3b3JrX3N0cnVjdCAqaXJxX3dv
cmssCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IGlycV9lZmZlY3Rp
dmVfY3B1KQo+IEBAIC0xMzIyLDExICsxMzM4LDE0IEBAIHN0YXRpYyBsb25nIHZkdXNlX2Rldl9p
b2N0bChzdHJ1Y3QgZmlsZSAqZmlsZSwgdW5zaWduZWQgaW50IGNtZCwKPiAgICAgICAgICAgICAg
ICAgaWYgKGluZGV4ID49IGRldi0+dnFfbnVtKQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGJy
ZWFrOwo+Cj4gKyAgICAgICAgICAgICAgIHJldCA9IDA7Cj4gICAgICAgICAgICAgICAgIGluZGV4
ID0gYXJyYXlfaW5kZXhfbm9zcGVjKGluZGV4LCBkZXYtPnZxX251bSk7Cj4gLQo+IC0gICAgICAg
ICAgICAgICB2ZHVzZV92cV91cGRhdGVfZWZmZWN0aXZlX2NwdShkZXYtPnZxc1tpbmRleF0pOwo+
IC0gICAgICAgICAgICAgICByZXQgPSB2ZHVzZV9kZXZfcXVldWVfaXJxX3dvcmsoZGV2LCAmZGV2
LT52cXNbaW5kZXhdLT5pbmplY3QsCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGRldi0+dnFzW2luZGV4XS0+aXJxX2VmZmVjdGl2ZV9jcHUpOwo+ICsgICAgICAgICAg
ICAgICBpZiAoIXZkdXNlX3ZxX3NpZ25hbF9pcnFmZChkZXYtPnZxc1tpbmRleF0pKSB7Cj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgdmR1c2VfdnFfdXBkYXRlX2VmZmVjdGl2ZV9jcHUoZGV2LT52
cXNbaW5kZXhdKTsKPiArICAgICAgICAgICAgICAgICAgICAgICByZXQgPSB2ZHVzZV9kZXZfcXVl
dWVfaXJxX3dvcmsoZGV2LAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICZkZXYtPnZxc1tpbmRleF0tPmluamVjdCwKPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZXYtPnZxc1tpbmRleF0tPmlycV9lZmZlY3Rp
dmVfY3B1KTsKPiArICAgICAgICAgICAgICAgfQo+ICAgICAgICAgICAgICAgICBicmVhazsKPiAg
ICAgICAgIH0KPiAgICAgICAgIGNhc2UgVkRVU0VfSU9UTEJfUkVHX1VNRU06IHsKPiAtLQo+IDIu
MjAuMQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
