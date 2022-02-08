Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D140DC433F5
	for <virtualization@archiver.kernel.org>; Tue,  8 Feb 2022 08:48:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5229C401C6;
	Tue,  8 Feb 2022 08:48:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4CXXoSPc5hvO; Tue,  8 Feb 2022 08:48:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B5406401B6;
	Tue,  8 Feb 2022 08:48:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 970ECC001A;
	Tue,  8 Feb 2022 08:48:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 956C7C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 08:48:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5FE9581497
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 08:48:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aq_Dvx8O6TZB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 08:48:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 59CAF813E7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 08:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644310097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LLt73gH0j+J0bmE9qEJG+tuGXBlIAzTPan6D+JUTiMg=;
 b=CELzs47xz7kvwHlyEI1lgn8Brt1Iv+zRzEf6YCi7cGSMz24S5dYXFSs9PAqggGv7DDwfhT
 knuMwDCIkZCLeu27fWq/81LWrbO5Vt3qPYN4tOuDGIVfXMAvRNUyWkJBoV6LIeznQ35EWI
 dh3TJqjCkNKBR5XNnPAe6i8IeoFW/xI=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-400-zK1p5xMdMhOlkfIOvEXYcw-1; Tue, 08 Feb 2022 03:48:15 -0500
X-MC-Unique: zK1p5xMdMhOlkfIOvEXYcw-1
Received: by mail-pf1-f199.google.com with SMTP id
 188-20020a6219c5000000b004ce24bef61fso9296248pfz.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Feb 2022 00:48:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=LLt73gH0j+J0bmE9qEJG+tuGXBlIAzTPan6D+JUTiMg=;
 b=g0MurnwN81uBN7ua74Sz6NRq+F3Ass6uDYiOtTJCl1KyD26bUU9Wa+VW6fZ3jqEVc9
 pIUyaTaDDKvPghL4+wbngigvuzcodP+1X/Jv9aYw+hXVel0eIMrn63WqhRFpGHW3rqHk
 cYjdYWuA68htH2Qv6ZeWdoRIc+Jd7E8+hkxPzAA9qnmV0Yke/ELBKgL60tfzmNMDbMoE
 qbhvuDGVS7H0xpwso9hIrSl/YfEEnG+YsbQAbaCEu0Tq/SQK9Pl9fnFhFGNZSL3nbVfD
 ZZjEg9qRIM0HUrdfCyRmC46T0rK/SJcQoEUlWWP3Wxbzl+9UdLZO2FU4MZOkncVfFs7c
 Ekzg==
X-Gm-Message-State: AOAM532E7MgjbE0rTrWz2RhnVIh3+NN1HVYmfnLHiqp9xRZUqCDWa1Zt
 NLClc5sY+U7g6UGfCfL7wLGJogukrG7TBahOwDwrONqi7x9EhKLZC7kuq8Bokdr/QmdCeAkVMY2
 cDuCzDKOEKKhNVOL16JINi1ukuMby64HoT/Ua2ZpRZA==
X-Received: by 2002:a63:f006:: with SMTP id k6mr2735963pgh.173.1644310092823; 
 Tue, 08 Feb 2022 00:48:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJydSy49qfAat3dxJ3ZZMPwR8zeF8OvmFndOyeIxRgM8PMjea66NwPqYo4/Kf/Wuh8rVZe18Ig==
X-Received: by 2002:a63:f006:: with SMTP id k6mr2735935pgh.173.1644310092530; 
 Tue, 08 Feb 2022 00:48:12 -0800 (PST)
Received: from [10.72.13.12] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id om18sm2061145pjb.39.2022.02.08.00.48.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Feb 2022 00:48:12 -0800 (PST)
Message-ID: <2c9e8791-9e0b-0e84-00c2-cb7e693194f1@redhat.com>
Date: Tue, 8 Feb 2022 16:47:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH 04/31] vdpa: Add vhost_svq_set_svq_kick_fd
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-5-eperezma@redhat.com>
 <e10a7631-f1f9-5597-dd74-0f5301a68e27@redhat.com>
 <CAJaqyWc7fbgN-W7y3=iFqHsJzj+1Mg0cuwSu+my=62nu9vGOqA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <CAJaqyWc7fbgN-W7y3=iFqHsJzj+1Mg0cuwSu+my=62nu9vGOqA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Gautam Dawar <gdawar@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
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

CuWcqCAyMDIyLzEvMzEg5LiL5Y2INjoxOCwgRXVnZW5pbyBQZXJleiBNYXJ0aW4g5YaZ6YGTOgo+
IE9uIEZyaSwgSmFuIDI4LCAyMDIyIGF0IDc6MjkgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4+Cj4+IOWcqCAyMDIyLzEvMjIg5LiK5Y2INDoyNywgRXVnZW5pbyBQ
w6lyZXog5YaZ6YGTOgo+Pj4gVGhpcyBmdW5jdGlvbiBhbGxvd3MgdGhlIHZob3N0LXZkcGEgYmFj
a2VuZCB0byBvdmVycmlkZSBraWNrX2ZkLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaW8g
UMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgo+Pj4gLS0tCj4+PiAgICBody92aXJ0aW8vdmhv
c3Qtc2hhZG93LXZpcnRxdWV1ZS5oIHwgIDEgKwo+Pj4gICAgaHcvdmlydGlvL3Zob3N0LXNoYWRv
dy12aXJ0cXVldWUuYyB8IDQ1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+Pj4gICAg
MiBmaWxlcyBjaGFuZ2VkLCA0NiBpbnNlcnRpb25zKCspCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2h3
L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmggYi9ody92aXJ0aW8vdmhvc3Qtc2hhZG93
LXZpcnRxdWV1ZS5oCj4+PiBpbmRleCA0MDBlZmZkOWYyLi5hNTZlY2ZjMDlkIDEwMDY0NAo+Pj4g
LS0tIGEvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuaAo+Pj4gKysrIGIvaHcvdmly
dGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuaAo+Pj4gQEAgLTE1LDYgKzE1LDcgQEAKPj4+Cj4+
PiAgICB0eXBlZGVmIHN0cnVjdCBWaG9zdFNoYWRvd1ZpcnRxdWV1ZSBWaG9zdFNoYWRvd1ZpcnRx
dWV1ZTsKPj4+Cj4+PiArdm9pZCB2aG9zdF9zdnFfc2V0X3N2cV9raWNrX2ZkKFZob3N0U2hhZG93
VmlydHF1ZXVlICpzdnEsIGludCBzdnFfa2lja19mZCk7Cj4+PiAgICBjb25zdCBFdmVudE5vdGlm
aWVyICp2aG9zdF9zdnFfZ2V0X2Rldl9raWNrX25vdGlmaWVyKAo+Pj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IFZob3N0U2hhZG93VmlydHF1
ZXVlICpzdnEpOwo+Pj4KPj4+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZp
cnRxdWV1ZS5jIGIvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuYwo+Pj4gaW5kZXgg
YmQ4NzExMDA3My4uMjE1MzRiYzk0ZCAxMDA2NDQKPj4+IC0tLSBhL2h3L3ZpcnRpby92aG9zdC1z
aGFkb3ctdmlydHF1ZXVlLmMKPj4+ICsrKyBiL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1
ZXVlLmMKPj4+IEBAIC0xMSw2ICsxMSw3IEBACj4+PiAgICAjaW5jbHVkZSAiaHcvdmlydGlvL3Zo
b3N0LXNoYWRvdy12aXJ0cXVldWUuaCIKPj4+Cj4+PiAgICAjaW5jbHVkZSAicWVtdS9lcnJvci1y
ZXBvcnQuaCIKPj4+ICsjaW5jbHVkZSAicWVtdS9tYWluLWxvb3AuaCIKPj4+Cj4+PiAgICAvKiBT
aGFkb3cgdmlydHF1ZXVlIHRvIHJlbGF5IG5vdGlmaWNhdGlvbnMgKi8KPj4+ICAgIHR5cGVkZWYg
c3RydWN0IFZob3N0U2hhZG93VmlydHF1ZXVlIHsKPj4+IEBAIC0xOCw4ICsxOSwyMCBAQCB0eXBl
ZGVmIHN0cnVjdCBWaG9zdFNoYWRvd1ZpcnRxdWV1ZSB7Cj4+PiAgICAgICAgRXZlbnROb3RpZmll
ciBoZGV2X2tpY2s7Cj4+PiAgICAgICAgLyogU2hhZG93IGNhbGwgbm90aWZpZXIsIHNlbnQgdG8g
dmhvc3QgKi8KPj4+ICAgICAgICBFdmVudE5vdGlmaWVyIGhkZXZfY2FsbDsKPj4+ICsKPj4+ICsg
ICAgLyoKPj4+ICsgICAgICogQm9ycm93ZWQgdmlydHF1ZXVlJ3MgZ3Vlc3QgdG8gaG9zdCBub3Rp
Zmllci4KPj4+ICsgICAgICogVG8gYm9ycm93IGl0IGluIHRoaXMgZXZlbnQgbm90aWZpZXIgYWxs
b3dzIHRvIHJlZ2lzdGVyIG9uIHRoZSBldmVudAo+Pj4gKyAgICAgKiBsb29wIGFuZCBhY2Nlc3Mg
dGhlIGFzc29jaWF0ZWQgc2hhZG93IHZpcnRxdWV1ZSBlYXNpbHkuIElmIHdlIHVzZSB0aGUKPj4+
ICsgICAgICogVmlydFF1ZXVlLCB3ZSBkb24ndCBoYXZlIGFuIGVhc3kgd2F5IHRvIHJldHJpZXZl
IGl0Lgo+Pj4gKyAgICAgKgo+Pj4gKyAgICAgKiBTbyBzaGFkb3cgdmlydHF1ZXVlIG11c3Qgbm90
IGNsZWFuIGl0LCBvciB3ZSB3b3VsZCBsb3NlIFZpcnRRdWV1ZSBvbmUuCj4+PiArICAgICAqLwo+
Pj4gKyAgICBFdmVudE5vdGlmaWVyIHN2cV9raWNrOwo+Pj4gICAgfSBWaG9zdFNoYWRvd1ZpcnRx
dWV1ZTsKPj4+Cj4+PiArI2RlZmluZSBJTlZBTElEX1NWUV9LSUNLX0ZEIC0xCj4+PiArCj4+PiAg
ICAvKioKPj4+ICAgICAqIFRoZSBub3RpZmllciB0aGF0IFNWUSB3aWxsIHVzZSB0byBub3RpZnkg
dGhlIGRldmljZS4KPj4+ICAgICAqLwo+Pj4gQEAgLTI5LDYgKzQyLDM1IEBAIGNvbnN0IEV2ZW50
Tm90aWZpZXIgKnZob3N0X3N2cV9nZXRfZGV2X2tpY2tfbm90aWZpZXIoCj4+PiAgICAgICAgcmV0
dXJuICZzdnEtPmhkZXZfa2ljazsKPj4+ICAgIH0KPj4+Cj4+PiArLyoqCj4+PiArICogU2V0IGEg
bmV3IGZpbGUgZGVzY3JpcHRvciBmb3IgdGhlIGd1ZXN0IHRvIGtpY2sgU1ZRIGFuZCBub3RpZnkg
Zm9yIGF2YWlsCj4+PiArICoKPj4+ICsgKiBAc3ZxICAgICAgICAgIFRoZSBzdnEKPj4+ICsgKiBA
c3ZxX2tpY2tfZmQgIFRoZSBuZXcgc3ZxIGtpY2sgZmQKPj4+ICsgKi8KPj4+ICt2b2lkIHZob3N0
X3N2cV9zZXRfc3ZxX2tpY2tfZmQoVmhvc3RTaGFkb3dWaXJ0cXVldWUgKnN2cSwgaW50IHN2cV9r
aWNrX2ZkKQo+Pj4gK3sKPj4+ICsgICAgRXZlbnROb3RpZmllciB0bXA7Cj4+PiArICAgIGJvb2wg
Y2hlY2tfb2xkID0gSU5WQUxJRF9TVlFfS0lDS19GRCAhPQo+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgIGV2ZW50X25vdGlmaWVyX2dldF9mZCgmc3ZxLT5zdnFfa2ljayk7Cj4+PiArCj4+PiArICAg
IGlmIChjaGVja19vbGQpIHsKPj4+ICsgICAgICAgIGV2ZW50X25vdGlmaWVyX3NldF9oYW5kbGVy
KCZzdnEtPnN2cV9raWNrLCBOVUxMKTsKPj4+ICsgICAgICAgIGV2ZW50X25vdGlmaWVyX2luaXRf
ZmQoJnRtcCwgZXZlbnRfbm90aWZpZXJfZ2V0X2ZkKCZzdnEtPnN2cV9raWNrKSk7Cj4+PiArICAg
IH0KPj4KPj4gSXQgbG9va3MgdG8gbWUgd2UgZG9uJ3QgZG8gc2ltaWxhciB0aGluZ3MgaW4gdmhv
c3QtbmV0LiBBbnkgcmVhc29uIGZvcgo+PiBjYXJpbmcgYWJvdXQgdGhlIG9sZCBzdnFfa2ljaz8K
Pj4KPiBEbyB5b3UgbWVhbiB0byBjaGVjayBmb3Igb2xkIGtpY2tfZmQgaW4gY2FzZSB3ZSBtaXNz
IG5vdGlmaWNhdGlvbnMsCj4gYW5kIGV4cGxpY2l0bHkgb21pdCB0aGUgSU5WQUxJRF9TVlFfS0lD
S19GRD8KCgpZZXMuCgoKPgo+IElmIHlvdSBtZWFuIHFlbXUncyB2aG9zdC1uZXQsIEkgZ3Vlc3Mg
aXQncyBiZWNhdXNlIHRoZSBkZXZpY2UncyBraWNrCj4gZmQgaXMgbmV2ZXIgY2hhbmdlZCBpbiBh
bGwgdGhlIHZob3N0IGRldmljZSBsaWZlY3ljbGUsIGl0J3Mgb25seSBzZXQKPiBhdCB0aGUgYmVn
aW5uaW5nLiBQcmV2aW91cyBSRkMgYWxzbyBkZXBlbmRlZCBvbiB0aGF0LCBidXQgeW91Cj4gc3Vn
Z2VzdGVkIGJldHRlciB2aG9zdCBhbmQgU1ZRIGluIHY0IGZlZWRiYWNrIGlmIEkgdW5kZXJzdG9v
ZAo+IGNvcnJlY3RseSBbMV0uIE9yIGFtIEkgbWlzc2luZyBzb21ldGhpbmc/CgoKTm8sIEkgZm9y
Z290IHRoYXQuIEJ1dCBpbiB0aGlzIGNhc2Ugd2Ugc2hvdWxkIGhhdmUgYSBiZXR0ZXIgZGVhbGlu
ZyB3aXRoIAp0aGUgdGhlIGNvbnZlcnNpb24gZnJvbSB2YWxpZCBmZCB0byAtMSBieSBkaXNhYmxp
bmcgdGhlIGhhbmRsZXIuCgoKPgo+IFFlbXUncyB2aG9zdC1uZXQgZG9lcyBub3QgbmVlZCB0byB1
c2UgdGhpcyBiZWNhdXNlIGl0IGlzIG5vdCBwb2xsaW5nCj4gaXQuIEZvciBrZXJuZWwncyB2aG9z
dCwgSSBndWVzcyB0aGUgY2xvc2VzdCBpcyB0aGUgdXNlIG9mIHBvbGxzdG9wIGFuZAo+IHBvbGxz
dGFydCBhdCB2aG9zdF92cmluZ19pb2N0bC4KPgo+IEluIG15IG9waW5pb24sIEkgdGhpbmsgdGhh
dCBTVlEgY29kZSBzaXplIGNhbiBiZW5lZml0IGZyb20gbm93Cj4gYWxsb3dpbmcgdG8gb3ZlcnJp
ZGUga2lja19mZCBmcm9tIHRoZSBzdGFydCBvZiB0aGUgb3BlcmF0aW9uLiBOb3QgZnJvbQo+IGlu
aXRpYWxpemF0aW9uLCBidXQgc3RhcnQuIEJ1dCBJIGNhbiBzZWUgdGhlIGJlbmVmaXRzIG9mIGhh
dmluZyB0aGUKPiBjaGFuZ2UgaW50byBhY2NvdW50IGZyb20gdGhpcyBtb21lbnQgc28gaXQncyBt
b3JlIHJlc2lsaWVudCB0byB0aGUKPiBmdXR1cmUuCj4KPj4+ICsKPj4+ICsgICAgLyoKPj4+ICsg
ICAgICogZXZlbnRfbm90aWZpZXJfc2V0X2hhbmRsZXIgYWxyZWFkeSBjaGVja3MgZm9yIGd1ZXN0
J3Mgbm90aWZpY2F0aW9ucyBpZgo+Pj4gKyAgICAgKiB0aGV5IGFycml2ZSB0byB0aGUgbmV3IGZp
bGUgZGVzY3JpcHRvciBpbiB0aGUgc3dpdGNoLCBzbyB0aGVyZSBpcyBubwo+Pj4gKyAgICAgKiBu
ZWVkIHRvIGV4cGxpY2l0ZWx5IGNoZWNrIGZvciB0aGVtLgo+Pj4gKyAgICAgKi8KPj4+ICsgICAg
ZXZlbnRfbm90aWZpZXJfaW5pdF9mZCgmc3ZxLT5zdnFfa2ljaywgc3ZxX2tpY2tfZmQpOwo+Pj4g
Kwo+Pj4gKyAgICBpZiAoIWNoZWNrX29sZCB8fCBldmVudF9ub3RpZmllcl90ZXN0X2FuZF9jbGVh
cigmdG1wKSkgewo+Pj4gKyAgICAgICAgZXZlbnRfbm90aWZpZXJfc2V0KCZzdnEtPmhkZXZfa2lj
ayk7Cj4+Cj4+IEFueSByZWFzb24gd2UgbmVlZCB0byBraWNrIHRoZSBkZXZpY2UgZGlyZWN0bHkg
aGVyZT8KPj4KPiBBdCB0aGlzIHBvaW50IG9mIHRoZSBzZXJpZXMgb25seSBub3RpZmljYXRpb25z
IGFyZSBmb3J3YXJkZWQsIG5vdAo+IGJ1ZmZlcnMuIElmIGtpY2tfZmQgaXMgc2V0LCB3ZSBuZWVk
IHRvIGNoZWNrIHRoZSBvbGQgb25lLCB0aGUgc2FtZSB3YXkKPiBhcyB2aG9zdCBjaGVja3MgdGhl
IG1hc2tlZCBub3RpZmllciBpbiBjYXNlIG9mIGNoYW5nZS4KCgpJIG1lYW50IHdlIG5lZWQgdG8g
a2ljayB0aGUgc3ZxIGluc3RlYWQgb2Ygdmhvc3QtdmRwYSBpbiB0aGlzIGNhc2U/CgpUaGFua3MK
Cgo+Cj4gVGhhbmtzIQo+Cj4gWzFdIGh0dHBzOi8vbGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwv
cWVtdS1kZXZlbC8yMDIxLTEwL21zZzAzMTUyLmh0bWwKPiAsIGZyb20gIkknZCBzdWdnZXN0IHRv
IG5vdCBkZXBlbmQgb24gdGhpcyBzaW5jZSBpdDoiCj4KPgo+PiBUaGFua3MKPj4KPj4KPj4+ICsg
ICAgfQo+Pj4gK30KPj4+ICsKPj4+ICAgIC8qKgo+Pj4gICAgICogQ3JlYXRlcyB2aG9zdCBzaGFk
b3cgdmlydHF1ZXVlLCBhbmQgaW5zdHJ1Y3Qgdmhvc3QgZGV2aWNlIHRvIHVzZSB0aGUgc2hhZG93
Cj4+PiAgICAgKiBtZXRob2RzIGFuZCBmaWxlIGRlc2NyaXB0b3JzLgo+Pj4gQEAgLTUyLDYgKzk0
LDkgQEAgVmhvc3RTaGFkb3dWaXJ0cXVldWUgKnZob3N0X3N2cV9uZXcodm9pZCkKPj4+ICAgICAg
ICAgICAgZ290byBlcnJfaW5pdF9oZGV2X2NhbGw7Cj4+PiAgICAgICAgfQo+Pj4KPj4+ICsgICAg
LyogUGxhY2Vob2xkZXIgZGVzY3JpcHRvciwgaXQgc2hvdWxkIGJlIGRlbGV0ZWQgYXQgc2V0X2tp
Y2tfZmQgKi8KPj4+ICsgICAgZXZlbnRfbm90aWZpZXJfaW5pdF9mZCgmc3ZxLT5zdnFfa2ljaywg
SU5WQUxJRF9TVlFfS0lDS19GRCk7Cj4+PiArCj4+PiAgICAgICAgcmV0dXJuIGdfc3RlYWxfcG9p
bnRlcigmc3ZxKTsKPj4+Cj4+PiAgICBlcnJfaW5pdF9oZGV2X2NhbGw6CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
