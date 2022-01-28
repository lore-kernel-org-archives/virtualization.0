Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B23C433EF
	for <virtualization@archiver.kernel.org>; Fri, 28 Jan 2022 06:00:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C67EB40328;
	Fri, 28 Jan 2022 06:00:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1ASmwSmkeYtN; Fri, 28 Jan 2022 06:00:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BDD9F400EA;
	Fri, 28 Jan 2022 06:00:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 936FCC001A;
	Fri, 28 Jan 2022 06:00:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27358C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 06:00:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1589D414C1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 06:00:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6QlXtjbNHDvX
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 06:00:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BFD6A4136B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 06:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643349642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OYgQt0/KeFSCIkAhuFPGEarb+no47SgZxYR96SrPZ0c=;
 b=D5sD7vc0TOc3KjldfAxyfjbwQ+2fJdxMmHnktEwu0QAKrLEfzpZWgoiaQ+gTdCyBnOJkus
 1iGpLbX9vWCMv4j/MDq69piIlbid95TZeSoihywZVGQ82piB0JVYgv1k3mibo7okfWZyXV
 GHlVcbZAyqiReZPIl/T6c2Od8vt7Rjk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-pEt9r2zROxOTH5Ty3PuO0w-1; Fri, 28 Jan 2022 01:00:39 -0500
X-MC-Unique: pEt9r2zROxOTH5Ty3PuO0w-1
Received: by mail-pl1-f198.google.com with SMTP id
 k7-20020a170902ba8700b0014c7e2870d4so2627335pls.21
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 22:00:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=OYgQt0/KeFSCIkAhuFPGEarb+no47SgZxYR96SrPZ0c=;
 b=4kYp73wHCvCE/+LY26UuSGvddT9rBr+9dls/cSTe14racJiOu+VB3SBKEVLhrklLEM
 kZDT7epjn1RhCbVJjPIoH/WpcVb4KyLPmRmpuO9sz3RVxGsJG6u0zUE3OLuC6S5U2J7h
 yuyYXDgBx/B2SEvAM5bLFVsSk3sdsLZxO0gUTaTjvfg8h6kl56RPVfYhnuSBiBP7CfQn
 Vos1XgxI6OTbXlhsIso4k8dQFe42yEgFXRWozgS40XbvJjI1Rt2Nq4/sV+WQlBBW15Rn
 6WKGTACoHBD9AKUL1Z5lcQpEgfNYKP7bIn9Dqj3kIKPKmQbKxUM8PFG9Nk4AhmKDHX//
 J+vA==
X-Gm-Message-State: AOAM5316jujryr3DMIiTz4vQe5ml3Bwv0ZmyOOqA9RGa2OMsxRgLnlGG
 IDhLHWbZbvbo30U4KQSYRXZaQY+kI67YEaRl42U0hXxJiwmhkZxmRt1sYI3H0i5ZXRHLxzXCzlv
 hWZDiip1Ywmdva2+r4kwoFJfggoUH6XvUCyfdZwvNmg==
X-Received: by 2002:a17:902:7e0a:: with SMTP id
 b10mr6658093plm.17.1643349638622; 
 Thu, 27 Jan 2022 22:00:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz7hNeWWqb8aRBUDh65gGxA3ifNtHPG4/49IrbOF8G9VrCDqBH4KQA7MYQApwmP4y74Q+g8mA==
X-Received: by 2002:a17:902:7e0a:: with SMTP id
 b10mr6658050plm.17.1643349638328; 
 Thu, 27 Jan 2022 22:00:38 -0800 (PST)
Received: from [10.72.13.185] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b13sm7427295pfm.27.2022.01.27.22.00.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jan 2022 22:00:37 -0800 (PST)
Message-ID: <3900d7cc-a7a0-90a0-5ba4-6fc37a84922f@redhat.com>
Date: Fri, 28 Jan 2022 14:00:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH 02/31] vhost: Add VhostShadowVirtqueue
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-3-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220121202733.404989-3-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Gautam Dawar <gdawar@xilinx.com>,
 virtualization@lists.linux-foundation.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 Eric Blake <eblake@redhat.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzEvMjIg5LiK5Y2INDoyNywgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IFZob3N0
IHNoYWRvdyB2aXJ0cXVldWUgKFNWUSkgaXMgYW4gaW50ZXJtZWRpYXRlIGp1bXAgZm9yIHZpcnRx
dWV1ZQo+IG5vdGlmaWNhdGlvbnMgYW5kIGJ1ZmZlcnMsIGFsbG93aW5nIHFlbXUgdG8gdHJhY2sg
dGhlbS4gV2hpbGUgcWVtdSBpcwo+IGZvcndhcmRpbmcgdGhlIGJ1ZmZlcnMgYW5kIHZpcnRxdWV1
ZSBjaGFuZ2VzLCBpdCBpcyBhYmxlIHRvIGNvbW1pdCB0aGUKPiBtZW1vcnkgaXQncyBiZWluZyBk
aXJ0aWVkLCB0aGUgc2FtZSB3YXkgcmVndWxhciBxZW11J3MgVmlydElPIGRldmljZXMKPiBkby4K
Pgo+IFRoaXMgY29tbWl0IG9ubHkgZXhwb3NlcyBiYXNpYyBTVlEgYWxsb2NhdGlvbiBhbmQgZnJl
ZS4gTmV4dCBwYXRjaGVzIG9mCj4gdGhlIHNlcmllcyBhZGQgZnVuY3Rpb25hbGl0eSBsaWtlIG5v
dGlmaWNhdGlvbnMgYW5kIGJ1ZmZlcnMgZm9yd2FyZGluZy4KPgo+IFNpZ25lZC1vZmYtYnk6IEV1
Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgo+IC0tLQo+ICAgaHcvdmlydGlvL3Zo
b3N0LXNoYWRvdy12aXJ0cXVldWUuaCB8IDIxICsrKysrKysrKysKPiAgIGh3L3ZpcnRpby92aG9z
dC1zaGFkb3ctdmlydHF1ZXVlLmMgfCA2NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysK
PiAgIGh3L3ZpcnRpby9tZXNvbi5idWlsZCAgICAgICAgICAgICAgfCAgMiArLQo+ICAgMyBmaWxl
cyBjaGFuZ2VkLCA4NiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gICBjcmVhdGUgbW9k
ZSAxMDA2NDQgaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuaAo+ICAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGh3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMKPgo+IGRpZmYgLS1n
aXQgYS9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5oIGIvaHcvdmlydGlvL3Zob3N0
LXNoYWRvdy12aXJ0cXVldWUuaAo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gaW5kZXggMDAwMDAw
MDAwMC4uNjFlYTExMjAwMgo+IC0tLSAvZGV2L251bGwKPiArKysgYi9ody92aXJ0aW8vdmhvc3Qt
c2hhZG93LXZpcnRxdWV1ZS5oCj4gQEAgLTAsMCArMSwyMSBAQAo+ICsvKgo+ICsgKiB2aG9zdCBz
aGFkb3cgdmlydHF1ZXVlCj4gKyAqCj4gKyAqIFNQRFgtRmlsZUNvcHlyaWdodFRleHQ6IFJlZCBI
YXQsIEluYy4gMjAyMQo+ICsgKiBTUERYLUZpbGVDb250cmlidXRvcjogQXV0aG9yOiBFdWdlbmlv
IFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiArICoKPiArICogU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKPiArICovCj4gKwo+ICsjaWZuZGVmIFZIT1NUX1NI
QURPV19WSVJUUVVFVUVfSAo+ICsjZGVmaW5lIFZIT1NUX1NIQURPV19WSVJUUVVFVUVfSAo+ICsK
PiArI2luY2x1ZGUgImh3L3ZpcnRpby92aG9zdC5oIgo+ICsKPiArdHlwZWRlZiBzdHJ1Y3QgVmhv
c3RTaGFkb3dWaXJ0cXVldWUgVmhvc3RTaGFkb3dWaXJ0cXVldWU7Cj4gKwo+ICtWaG9zdFNoYWRv
d1ZpcnRxdWV1ZSAqdmhvc3Rfc3ZxX25ldyh2b2lkKTsKPiArCj4gK3ZvaWQgdmhvc3Rfc3ZxX2Zy
ZWUoVmhvc3RTaGFkb3dWaXJ0cXVldWUgKnZxKTsKPiArCj4gKyNlbmRpZgo+IGRpZmYgLS1naXQg
YS9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5jIGIvaHcvdmlydGlvL3Zob3N0LXNo
YWRvdy12aXJ0cXVldWUuYwo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gaW5kZXggMDAwMDAwMDAw
MC4uNWVlN2I0MDFjYgo+IC0tLSAvZGV2L251bGwKPiArKysgYi9ody92aXJ0aW8vdmhvc3Qtc2hh
ZG93LXZpcnRxdWV1ZS5jCj4gQEAgLTAsMCArMSw2NCBAQAo+ICsvKgo+ICsgKiB2aG9zdCBzaGFk
b3cgdmlydHF1ZXVlCj4gKyAqCj4gKyAqIFNQRFgtRmlsZUNvcHlyaWdodFRleHQ6IFJlZCBIYXQs
IEluYy4gMjAyMQo+ICsgKiBTUERYLUZpbGVDb250cmlidXRvcjogQXV0aG9yOiBFdWdlbmlvIFDD
qXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiArICoKPiArICogU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKPiArICovCj4gKwo+ICsjaW5jbHVkZSAicWVtdS9vc2Rl
cC5oIgo+ICsjaW5jbHVkZSAiaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuaCIKPiAr
Cj4gKyNpbmNsdWRlICJxZW11L2Vycm9yLXJlcG9ydC5oIgo+ICsjaW5jbHVkZSAicWVtdS9ldmVu
dF9ub3RpZmllci5oIgo+ICsKPiArLyogU2hhZG93IHZpcnRxdWV1ZSB0byByZWxheSBub3RpZmlj
YXRpb25zICovCj4gK3R5cGVkZWYgc3RydWN0IFZob3N0U2hhZG93VmlydHF1ZXVlIHsKPiArICAg
IC8qIFNoYWRvdyBraWNrIG5vdGlmaWVyLCBzZW50IHRvIHZob3N0ICovCj4gKyAgICBFdmVudE5v
dGlmaWVyIGhkZXZfa2ljazsKPiArICAgIC8qIFNoYWRvdyBjYWxsIG5vdGlmaWVyLCBzZW50IHRv
IHZob3N0ICovCj4gKyAgICBFdmVudE5vdGlmaWVyIGhkZXZfY2FsbDsKPiArfSBWaG9zdFNoYWRv
d1ZpcnRxdWV1ZTsKPiArCj4gKy8qKgo+ICsgKiBDcmVhdGVzIHZob3N0IHNoYWRvdyB2aXJ0cXVl
dWUsIGFuZCBpbnN0cnVjdCB2aG9zdCBkZXZpY2UgdG8gdXNlIHRoZSBzaGFkb3cKPiArICogbWV0
aG9kcyBhbmQgZmlsZSBkZXNjcmlwdG9ycy4KPiArICovCj4gK1Zob3N0U2hhZG93VmlydHF1ZXVl
ICp2aG9zdF9zdnFfbmV3KHZvaWQpCj4gK3sKPiArICAgIGdfYXV0b2ZyZWUgVmhvc3RTaGFkb3dW
aXJ0cXVldWUgKnN2cSA9IGdfbmV3MChWaG9zdFNoYWRvd1ZpcnRxdWV1ZSwgMSk7Cj4gKyAgICBp
bnQgcjsKPiArCj4gKyAgICByID0gZXZlbnRfbm90aWZpZXJfaW5pdCgmc3ZxLT5oZGV2X2tpY2ss
IDApOwo+ICsgICAgaWYgKHIgIT0gMCkgewo+ICsgICAgICAgIGVycm9yX3JlcG9ydCgiQ291bGRu
J3QgY3JlYXRlIGtpY2sgZXZlbnQgbm90aWZpZXI6ICVzIiwKPiArICAgICAgICAgICAgICAgICAg
ICAgc3RyZXJyb3IoZXJybm8pKTsKPiArICAgICAgICBnb3RvIGVycl9pbml0X2hkZXZfa2ljazsK
PiArICAgIH0KPiArCj4gKyAgICByID0gZXZlbnRfbm90aWZpZXJfaW5pdCgmc3ZxLT5oZGV2X2Nh
bGwsIDApOwo+ICsgICAgaWYgKHIgIT0gMCkgewo+ICsgICAgICAgIGVycm9yX3JlcG9ydCgiQ291
bGRuJ3QgY3JlYXRlIGNhbGwgZXZlbnQgbm90aWZpZXI6ICVzIiwKPiArICAgICAgICAgICAgICAg
ICAgICAgc3RyZXJyb3IoZXJybm8pKTsKPiArICAgICAgICBnb3RvIGVycl9pbml0X2hkZXZfY2Fs
bDsKPiArICAgIH0KPiArCj4gKyAgICByZXR1cm4gZ19zdGVhbF9wb2ludGVyKCZzdnEpOwo+ICsK
PiArZXJyX2luaXRfaGRldl9jYWxsOgo+ICsgICAgZXZlbnRfbm90aWZpZXJfY2xlYW51cCgmc3Zx
LT5oZGV2X2tpY2spOwo+ICsKPiArZXJyX2luaXRfaGRldl9raWNrOgo+ICsgICAgcmV0dXJuIE5V
TEw7Cj4gK30KPiArCj4gKy8qKgo+ICsgKiBGcmVlIHRoZSByZXNvdXJjZXMgb2YgdGhlIHNoYWRv
dyB2aXJ0cXVldWUuCj4gKyAqLwo+ICt2b2lkIHZob3N0X3N2cV9mcmVlKFZob3N0U2hhZG93Vmly
dHF1ZXVlICp2cSkKPiArewo+ICsgICAgZXZlbnRfbm90aWZpZXJfY2xlYW51cCgmdnEtPmhkZXZf
a2ljayk7Cj4gKyAgICBldmVudF9ub3RpZmllcl9jbGVhbnVwKCZ2cS0+aGRldl9jYWxsKTsKPiAr
ICAgIGdfZnJlZSh2cSk7Cj4gK30KPiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL21lc29uLmJ1aWxk
IGIvaHcvdmlydGlvL21lc29uLmJ1aWxkCj4gaW5kZXggNTIxZjdkNjRhOC4uMmRjODc2MTNiYyAx
MDA2NDQKPiAtLS0gYS9ody92aXJ0aW8vbWVzb24uYnVpbGQKPiArKysgYi9ody92aXJ0aW8vbWVz
b24uYnVpbGQKPiBAQCAtMTEsNyArMTEsNyBAQCBzb2Z0bW11X3NzLmFkZCh3aGVuOiAnQ09ORklH
X0FMTCcsIGlmX3RydWU6IGZpbGVzKCd2aG9zdC1zdHViLmMnKSkKPiAgIAo+ICAgdmlydGlvX3Nz
ID0gc3Muc291cmNlX3NldCgpCj4gICB2aXJ0aW9fc3MuYWRkKGZpbGVzKCd2aXJ0aW8uYycpKQo+
IC12aXJ0aW9fc3MuYWRkKHdoZW46ICdDT05GSUdfVkhPU1QnLCBpZl90cnVlOiBmaWxlcygndmhv
c3QuYycsICd2aG9zdC1iYWNrZW5kLmMnKSkKPiArdmlydGlvX3NzLmFkZCh3aGVuOiAnQ09ORklH
X1ZIT1NUJywgaWZfdHJ1ZTogZmlsZXMoJ3Zob3N0LmMnLCAndmhvc3QtYmFja2VuZC5jJywgJ3Zo
b3N0LXNoYWRvdy12aXJ0cXVldWUuYycpKQoKCkkgd29uZGVyIGlmIHdlIG5lZWQgYSBkZWRpY2F0
ZWQgY29uZmlnIG9wdGlvbiBmb3Igc2hhZG93IHZpcnRxdWV1ZS4KClRoYW5rcwoKCj4gICB2aXJ0
aW9fc3MuYWRkKHdoZW46ICdDT05GSUdfVkhPU1RfVVNFUicsIGlmX3RydWU6IGZpbGVzKCd2aG9z
dC11c2VyLmMnKSkKPiAgIHZpcnRpb19zcy5hZGQod2hlbjogJ0NPTkZJR19WSE9TVF9WRFBBJywg
aWZfdHJ1ZTogZmlsZXMoJ3Zob3N0LXZkcGEuYycpKQo+ICAgdmlydGlvX3NzLmFkZCh3aGVuOiAn
Q09ORklHX1ZJUlRJT19CQUxMT09OJywgaWZfdHJ1ZTogZmlsZXMoJ3ZpcnRpby1iYWxsb29uLmMn
KSkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
