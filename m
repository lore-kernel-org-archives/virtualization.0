Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB65C77B61
	for <virtualization@archiver.kernel.org>; Mon, 24 Apr 2023 03:47:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9347E405FD;
	Mon, 24 Apr 2023 03:47:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9347E405FD
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T84y3HOP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vznuZL4HDPQj; Mon, 24 Apr 2023 03:47:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2AC0240133;
	Mon, 24 Apr 2023 03:47:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2AC0240133
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EA4FC0037;
	Mon, 24 Apr 2023 03:47:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5390C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 03:47:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9811240568
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 03:47:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9811240568
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Uxsb3mAfU1q9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 03:47:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C75CB40133
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C75CB40133
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 03:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682308046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I584JltpIOHH0XWX0tvqPjwC5qSAM+LcHjOrkleU1aQ=;
 b=T84y3HOPbNxcPbq9gHsL1lTXwps7ot7BFUCtBnb9xssmeWBy4ziYV1ng5exO9FQJkrXT7I
 wTfTCd4bqjkCgdhgAGmXBL2RfDMXI/f0FyIf2xrqwqwYvqAAPI1As3QDpr+oCIaCwWlnll
 rfrb0LuRJtl9KGD6IULLJ+FSiH0hVX4=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-gQ_VqE0CMjufoA1JDYgwLA-1; Sun, 23 Apr 2023 23:47:24 -0400
X-MC-Unique: gQ_VqE0CMjufoA1JDYgwLA-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-38e4f308c49so2819242b6e.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 20:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682308043; x=1684900043;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I584JltpIOHH0XWX0tvqPjwC5qSAM+LcHjOrkleU1aQ=;
 b=UDzskQzalNEA2i0WKHov0JQXjiWG2vMd9Rat4//QvMlHOG3o9lw0vlAbK8rftp/pax
 PuTR4xSC+wdJTKiQJwnT5mDg1/+WfzxMsRpCGV3YG0XHNBF7stHNtUC2k3uPvQFaQ79U
 07Fi5gX7lga//kf7/uHVIwuMW9GU/nc+ydP8EHwwkLddO3Ziq8bf5VA2mE/0Jt+ak0ix
 J+3C1gmkMSQDur2Aps1BBKqpa+BZtuO1atRkibiqo1TImDOGK3AlRGkDxi95UGQqiwDk
 gIzepntUFoDhb82Qf/hg9PhRfjXsBCeoJuFj6lHGOK2PW6O01no1upwpHNeUGuNWneGZ
 MmJg==
X-Gm-Message-State: AAQBX9cNqo8hUC4J9LvjGZEXfuJguifQRJvZ2gHuBVqb3YU5f1PFZO01
 kdFFV9Vfu3BJlGAbqHIPjpWuUoIF57e6QkXcpXYdVNa5gsz1k0VAz6vtkgqs/GMLZCyiP5e6L5U
 37KtdgUZQEclFen4IRNaTOfYeNbfTKO+rVk84lTeHAZalZDWVzzmQ6kdiDg==
X-Received: by 2002:a05:6808:24f:b0:38d:ea2e:15f with SMTP id
 m15-20020a056808024f00b0038dea2e015fmr6603505oie.55.1682308043150; 
 Sun, 23 Apr 2023 20:47:23 -0700 (PDT)
X-Google-Smtp-Source: AKy350ab9SIDhGschCCjuuNyKJylYRhQJOud0D1ec5vKWIcImJUKSc8v87Kjk0mZxymvmmHmwGVwE71m5NCtO8VfDmc=
X-Received: by 2002:a05:6808:24f:b0:38d:ea2e:15f with SMTP id
 m15-20020a056808024f00b0038dea2e015fmr6603496oie.55.1682308042954; Sun, 23
 Apr 2023 20:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230420151734.860168-1-lulu@redhat.com>
In-Reply-To: <20230420151734.860168-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Apr 2023 11:47:12 +0800
Message-ID: <CACGkMEuV8a0sAJPM0aVq4o9R2uRku1Wgdy8o=YBhZM2ay7ssEg@mail.gmail.com>
Subject: Re: [PATCH v3] vhost_vdpa: fix unmap process in no-batch mode
To: Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

T24gVGh1LCBBcHIgMjAsIDIwMjMgYXQgMTE6MTfigK9QTSBDaW5keSBMdSA8bHVsdUByZWRoYXQu
Y29tPiB3cm90ZToKPgo+IFdoaWxlIHVzaW5nIHRoZSB2ZHBhIGRldmljZSB3aXRoIHZJT01NVSBl
bmFibGVkCj4gaW4gdGhlIGd1ZXN0IFZNLCB3aGVuIHRoZSB2ZHBhIGRldmljZSBiaW5kIHRvIHZm
aW8tcGNpIGFuZCBydW4gdGVzdHBtZAo+IHRoZW4gc3lzdGVtIHdpbGwgZmFpbCB0byB1bm1hcC4K
PiBUaGUgdGVzdCBwcm9jZXNzIGlzCj4gTG9hZCBndWVzdCBWTSAtLT4gYXR0YWNoIHRvIHZpcnRp
byBkcml2ZXItLT4gYmluZCB0byB2ZmlvLXBjaSBkcml2ZXIKPiBTbyB0aGUgbWFwcGluZyBwcm9j
ZXNzIGlzCj4gMSliYXRjaGVkIG1vZGUgbWFwIHRvIG5vcm1hbCBNUgo+IDIpYmF0Y2hlZCBtb2Rl
IHVubWFwcGVkIHRoZSBub3JtYWwgTVIKPiAzKXVubWFwcGVkIGFsbCB0aGUgbWVtb3J5Cj4gNClt
YXBwZWQgdG8gaW9tbXUgTVIKPgo+IFRoaXMgZXJyb3IgaGFwcGVuZWQgaW4gc3RlcCAzKS4gVGhl
IGlvdGxiIHdhcyBmcmVlZCBpbiBzdGVwIDIpCj4gYW5kIHRoZSBmdW5jdGlvbiB2aG9zdF92ZHBh
X3Byb2Nlc3NfaW90bGJfbXNnIHdpbGwgcmV0dXJuIGZhaWwKPiBXaGljaCBjYXVzZXMgZmFpbHVy
ZS4KPgo+IFRvIGZpeCB0aGlzLCB3ZSB3aWxsIG5vdCByZW1vdmUgdGhlIEFTIHdoaWxlIHRoZSBp
b3RsYi0+bm1hcHMgaXMgMC4KPiBUaGlzIHdpbGwgZnJlZSBpbiB0aGUgdmhvc3RfdmRwYV9jbGVh
bgo+Cj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKPiBGaXhlczogYWFjYTgzNzNjNGIxICgi
dmhvc3QtdmRwYTogc3VwcG9ydCBBU0lEIGJhc2VkIElPVExCIEFQSSIpCj4gU2lnbmVkLW9mZi1i
eTogQ2luZHkgTHUgPGx1bHVAcmVkaGF0LmNvbT4KCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNv
d2FuZ0ByZWRoYXQuY29tPgoKVGhhbmtzCgo+IC0tLQo+ICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyB8
IDggKy0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA3IGRlbGV0aW9u
cygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9z
dC92ZHBhLmMKPiBpbmRleCA3YmU5ZDlkOGYwMWMuLjc0YzdkMWY5NzhiNyAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gQEAg
LTg1MSwxMSArODUxLDcgQEAgc3RhdGljIHZvaWQgdmhvc3RfdmRwYV91bm1hcChzdHJ1Y3Qgdmhv
c3RfdmRwYSAqdiwKPiAgICAgICAgICAgICAgICAgaWYgKCF2LT5pbl9iYXRjaCkKPiAgICAgICAg
ICAgICAgICAgICAgICAgICBvcHMtPnNldF9tYXAodmRwYSwgYXNpZCwgaW90bGIpOwo+ICAgICAg
ICAgfQo+IC0gICAgICAgLyogSWYgd2UgYXJlIGluIHRoZSBtaWRkbGUgb2YgYmF0Y2ggcHJvY2Vz
c2luZywgZGVsYXkgdGhlIGZyZWUKPiAtICAgICAgICAqIG9mIEFTIHVudGlsIEJBVENIX0VORC4K
PiAtICAgICAgICAqLwo+IC0gICAgICAgaWYgKCF2LT5pbl9iYXRjaCAmJiAhaW90bGItPm5tYXBz
KQo+IC0gICAgICAgICAgICAgICB2aG9zdF92ZHBhX3JlbW92ZV9hcyh2LCBhc2lkKTsKPiArCj4g
IH0KPgo+ICBzdGF0aWMgaW50IHZob3N0X3ZkcGFfdmFfbWFwKHN0cnVjdCB2aG9zdF92ZHBhICp2
LAo+IEBAIC0xMTEyLDggKzExMDgsNiBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfcHJvY2Vzc19p
b3RsYl9tc2coc3RydWN0IHZob3N0X2RldiAqZGV2LCB1MzIgYXNpZCwKPiAgICAgICAgICAgICAg
ICAgaWYgKHYtPmluX2JhdGNoICYmIG9wcy0+c2V0X21hcCkKPiAgICAgICAgICAgICAgICAgICAg
ICAgICBvcHMtPnNldF9tYXAodmRwYSwgYXNpZCwgaW90bGIpOwo+ICAgICAgICAgICAgICAgICB2
LT5pbl9iYXRjaCA9IGZhbHNlOwo+IC0gICAgICAgICAgICAgICBpZiAoIWlvdGxiLT5ubWFwcykK
PiAtICAgICAgICAgICAgICAgICAgICAgICB2aG9zdF92ZHBhX3JlbW92ZV9hcyh2LCBhc2lkKTsK
PiAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gICAgICAgICBkZWZhdWx0Ogo+ICAgICAgICAgICAg
ICAgICByID0gLUVJTlZBTDsKPiAtLQo+IDIuMzQuMwo+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
