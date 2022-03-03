Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72091C433FE
	for <virtualization@archiver.kernel.org>; Thu,  3 Mar 2022 07:12:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D894415C4;
	Thu,  3 Mar 2022 07:12:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QWFXHpwSRLxt; Thu,  3 Mar 2022 07:12:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6F487415B2;
	Thu,  3 Mar 2022 07:12:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 532F9C0012;
	Thu,  3 Mar 2022 07:12:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 097BBC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 07:12:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D564240156
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 07:12:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2RY0XdA8kdju
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 07:12:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7F319400FE
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 07:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646291562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u03toGc1Cuj4ki0WWn7NaYZO/CaX2s4sPSYAy/b0ovo=;
 b=PborGCD/tCf7j0C2ARnEdqx1vFgLxxJ1ggVbUiD1Kf6IvulLdFR5HteHdiSKouJgey8gC6
 uKbe/ifv++nSx2XOik9bwEFotivOc+YISlFREVntAzh2k1PGCZuj2LahKKmmOL03utfcu/
 +UtQ5Tc8AiWHJfFMqA/7uW3l4ZkiuRo=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-472-y3Z_bhOkM6-AmFSiW0MEiA-1; Thu, 03 Mar 2022 02:12:41 -0500
X-MC-Unique: y3Z_bhOkM6-AmFSiW0MEiA-1
Received: by mail-pg1-f197.google.com with SMTP id
 u74-20020a63794d000000b00373efe2ac5aso2353482pgc.14
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Mar 2022 23:12:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=u03toGc1Cuj4ki0WWn7NaYZO/CaX2s4sPSYAy/b0ovo=;
 b=qgjPFBh1KffdAB7YsCpwKwyZ1gZ46sHTGW3Gr88RWk3rCNPvFUSSYqGnV5TPwuy4z+
 S362MLs5HrDX6iN3F2pblpr+MxXZi1KeIxAufIUCExg9YFwhAPo9J0fYRr43nt39I9G0
 B66eQm80lFMYhCcP8zDCa/5owk3sovNYYaLvpS3hfqbeDrNZaXxeJ9RMkyHM/UJNOwnQ
 oOOPC+KC0Dft4gAWNCqKgOAZt8FGlTydwepzg+h8+FaPZesqRPAqgZmz1cv3RBMpeII9
 w4vPcsWxxHz8FaNBo3wJIgMbvg0zUpEv0r/zOy5FTNdQeSM8un61RcLDvYxGS0xX05Y5
 sJDg==
X-Gm-Message-State: AOAM5319fXbOP3jJ2L+zgO1x/Pkvc9M7DhLz/XUJe5O7gVjmzEgp3eZF
 Gld95n+QW54/HPZH1DYWDtTTLxNXFBlow4KcsKx+fWcTypmzVagqB7S24ltxuQt75gOWeq7oGT3
 o59agW20rFTfMYNXoGvb6Upv/up8ZX1DPfIHxGBPbrg==
X-Received: by 2002:a63:2786:0:b0:365:8a2d:327b with SMTP id
 n128-20020a632786000000b003658a2d327bmr29058599pgn.16.1646291559821; 
 Wed, 02 Mar 2022 23:12:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJziV9kMjCvcRqx/tjtWnUEYDiNfGNwbTON8Q2L9Iu6io3kzCC6iC+C77IS2KOg7m8meMTkD/Q==
X-Received: by 2002:a63:2786:0:b0:365:8a2d:327b with SMTP id
 n128-20020a632786000000b003658a2d327bmr29058572pgn.16.1646291559514; 
 Wed, 02 Mar 2022 23:12:39 -0800 (PST)
Received: from [10.72.13.250] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 g15-20020a056a0023cf00b004e17e11cb17sm1413250pfc.111.2022.03.02.23.12.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Mar 2022 23:12:38 -0800 (PST)
Message-ID: <1da7c2b8-ba6e-e9aa-4d55-b1345bd65ba4@redhat.com>
Date: Thu, 3 Mar 2022 15:12:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v2 02/14] vhost: Add Shadow VirtQueue kick forwarding
 capabilities
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20220227134111.3254066-1-eperezma@redhat.com>
 <20220227134111.3254066-3-eperezma@redhat.com>
 <40c5bb81-b33a-9a4a-8ce0-20289b13b907@redhat.com>
 <CAJaqyWezcrc=iPLe=Y7+g9oBYfUY9pK8OM4=ZUeRgXqr9ZUWkg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <CAJaqyWezcrc=iPLe=Y7+g9oBYfUY9pK8OM4=ZUeRgXqr9ZUWkg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-level <qemu-devel@nongnu.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eli Cohen <eli@mellanox.com>, Eric Blake <eblake@redhat.com>,
 Parav Pandit <parav@mellanox.com>, Cindy Lu <lulu@redhat.com>,
 "Fangyi \(Eric\)" <eric.fangyi@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, yebiaoxiang@huawei.com,
 Liuxiangdong <liuxiangdong5@huawei.com>, Laurent Vivier <lvivier@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gautam Dawar <gdawar@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Lingshan <lingshan.zhu@intel.com>
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

CuWcqCAyMDIyLzMvMiDkuIrljYgyOjQ5LCBFdWdlbmlvIFBlcmV6IE1hcnRpbiDlhpnpgZM6Cj4g
T24gTW9uLCBGZWIgMjgsIDIwMjIgYXQgMzo1NyBBTSBKYXNvbiBXYW5nPGphc293YW5nQHJlZGhh
dC5jb20+ICB3cm90ZToKPj4g5ZyoIDIwMjIvMi8yNyDkuIvljYg5OjQwLCBFdWdlbmlvIFDDqXJl
eiDlhpnpgZM6Cj4+PiBBdCB0aGlzIG1vZGUgbm8gYnVmZmVyIGZvcndhcmRpbmcgd2lsbCBiZSBw
ZXJmb3JtZWQgaW4gU1ZRIG1vZGU6IFFlbXUKPj4+IHdpbGwganVzdCBmb3J3YXJkIHRoZSBndWVz
dCdzIGtpY2tzIHRvIHRoZSBkZXZpY2UuCj4+Pgo+Pj4gSG9zdCBtZW1vcnkgbm90aWZpZXJzIHJl
Z2lvbnMgYXJlIGxlZnQgb3V0IGZvciBzaW1wbGljaXR5LCBhbmQgdGhleSB3aWxsCj4+PiBub3Qg
YmUgYWRkcmVzc2VkIGluIHRoaXMgc2VyaWVzLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IEV1Z2Vu
aW8gUMOpcmV6PGVwZXJlem1hQHJlZGhhdC5jb20+Cj4+PiAtLS0KPj4+ICAgIGh3L3ZpcnRpby92
aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmggfCAgMTQgKysrCj4+PiAgICBpbmNsdWRlL2h3L3ZpcnRp
by92aG9zdC12ZHBhLmggICAgIHwgICA0ICsKPj4+ICAgIGh3L3ZpcnRpby92aG9zdC1zaGFkb3ct
dmlydHF1ZXVlLmMgfCAgNTIgKysrKysrKysrKysKPj4+ICAgIGh3L3ZpcnRpby92aG9zdC12ZHBh
LmMgICAgICAgICAgICAgfCAxNDUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0KPj4+ICAg
IDQgZmlsZXMgY2hhbmdlZCwgMjEzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Pgo+
Pj4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmggYi9ody92
aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5oCj4+PiBpbmRleCBmMTUxOWUzYzdiLi4xY2Jj
ODdkNWQ4IDEwMDY0NAo+Pj4gLS0tIGEvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUu
aAo+Pj4gKysrIGIvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuaAo+Pj4gQEAgLTE4
LDggKzE4LDIyIEBAIHR5cGVkZWYgc3RydWN0IFZob3N0U2hhZG93VmlydHF1ZXVlIHsKPj4+ICAg
ICAgICBFdmVudE5vdGlmaWVyIGhkZXZfa2ljazsKPj4+ICAgICAgICAvKiBTaGFkb3cgY2FsbCBu
b3RpZmllciwgc2VudCB0byB2aG9zdCAqLwo+Pj4gICAgICAgIEV2ZW50Tm90aWZpZXIgaGRldl9j
YWxsOwo+Pj4gKwo+Pj4gKyAgICAvKgo+Pj4gKyAgICAgKiBCb3Jyb3dlZCB2aXJ0cXVldWUncyBn
dWVzdCB0byBob3N0IG5vdGlmaWVyLiBUbyBib3Jyb3cgaXQgaW4gdGhpcyBldmVudAo+Pj4gKyAg
ICAgKiBub3RpZmllciBhbGxvd3MgdG8gcmVjb3ZlciB0aGUgVmhvc3RTaGFkb3dWaXJ0cXVldWUg
ZnJvbSB0aGUgZXZlbnQgbG9vcAo+Pj4gKyAgICAgKiBlYXNpbHkuIElmIHdlIHVzZSB0aGUgVmly
dFF1ZXVlJ3Mgb25lLCB3ZSBkb24ndCBoYXZlIGFuIGVhc3kgd2F5IHRvCj4+PiArICAgICAqIHJl
dHJpZXZlIFZob3N0U2hhZG93VmlydHF1ZXVlLgo+Pj4gKyAgICAgKgo+Pj4gKyAgICAgKiBTbyBz
aGFkb3cgdmlydHF1ZXVlIG11c3Qgbm90IGNsZWFuIGl0LCBvciB3ZSB3b3VsZCBsb3NlIFZpcnRR
dWV1ZSBvbmUuCj4+PiArICAgICAqLwo+Pj4gKyAgICBFdmVudE5vdGlmaWVyIHN2cV9raWNrOwo+
Pj4gICAgfSBWaG9zdFNoYWRvd1ZpcnRxdWV1ZTsKPj4+Cj4+PiArdm9pZCB2aG9zdF9zdnFfc2V0
X3N2cV9raWNrX2ZkKFZob3N0U2hhZG93VmlydHF1ZXVlICpzdnEsIGludCBzdnFfa2lja19mZCk7
Cj4+PiArCj4+PiArdm9pZCB2aG9zdF9zdnFfc3RvcChWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqc3Zx
KTsKPj4+ICsKPj4+ICAgIFZob3N0U2hhZG93VmlydHF1ZXVlICp2aG9zdF9zdnFfbmV3KHZvaWQp
Owo+Pj4KPj4+ICAgIHZvaWQgdmhvc3Rfc3ZxX2ZyZWUoZ3BvaW50ZXIgdnEpOwo+Pj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvaHcvdmlydGlvL3Zob3N0LXZkcGEuaCBiL2luY2x1ZGUvaHcvdmlydGlv
L3Zob3N0LXZkcGEuaAo+Pj4gaW5kZXggM2NlNzlhNjQ2ZC4uMDA5YTlmM2I2YiAxMDA2NDQKPj4+
IC0tLSBhL2luY2x1ZGUvaHcvdmlydGlvL3Zob3N0LXZkcGEuaAo+Pj4gKysrIGIvaW5jbHVkZS9o
dy92aXJ0aW8vdmhvc3QtdmRwYS5oCj4+PiBAQCAtMTIsNiArMTIsOCBAQAo+Pj4gICAgI2lmbmRl
ZiBIV19WSVJUSU9fVkhPU1RfVkRQQV9ICj4+PiAgICAjZGVmaW5lIEhXX1ZJUlRJT19WSE9TVF9W
RFBBX0gKPj4+Cj4+PiArI2luY2x1ZGUgPGdtb2R1bGUuaD4KPj4+ICsKPj4+ICAgICNpbmNsdWRl
ICJody92aXJ0aW8vdmlydGlvLmgiCj4+PiAgICAjaW5jbHVkZSAic3RhbmRhcmQtaGVhZGVycy9s
aW51eC92aG9zdF90eXBlcy5oIgo+Pj4KPj4+IEBAIC0yNyw2ICsyOSw4IEBAIHR5cGVkZWYgc3Ry
dWN0IHZob3N0X3ZkcGEgewo+Pj4gICAgICAgIGJvb2wgaW90bGJfYmF0Y2hfYmVnaW5fc2VudDsK
Pj4+ICAgICAgICBNZW1vcnlMaXN0ZW5lciBsaXN0ZW5lcjsKPj4+ICAgICAgICBzdHJ1Y3Qgdmhv
c3RfdmRwYV9pb3ZhX3JhbmdlIGlvdmFfcmFuZ2U7Cj4+PiArICAgIGJvb2wgc2hhZG93X3Zxc19l
bmFibGVkOwo+Pj4gKyAgICBHUHRyQXJyYXkgKnNoYWRvd192cXM7Cj4+PiAgICAgICAgc3RydWN0
IHZob3N0X2RldiAqZGV2Owo+Pj4gICAgICAgIFZob3N0VkRQQUhvc3ROb3RpZmllciBub3RpZmll
cltWSVJUSU9fUVVFVUVfTUFYXTsKPj4+ICAgIH0gVmhvc3RWRFBBOwo+Pj4gZGlmZiAtLWdpdCBh
L2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMgYi9ody92aXJ0aW8vdmhvc3Qtc2hh
ZG93LXZpcnRxdWV1ZS5jCj4+PiBpbmRleCAwMTljZjE5NTBmLi5hNWQwNjU5Zjg2IDEwMDY0NAo+
Pj4gLS0tIGEvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuYwo+Pj4gKysrIGIvaHcv
dmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuYwo+Pj4gQEAgLTExLDYgKzExLDU2IEBACj4+
PiAgICAjaW5jbHVkZSAiaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuaCIKPj4+Cj4+
PiAgICAjaW5jbHVkZSAicWVtdS9lcnJvci1yZXBvcnQuaCIKPj4+ICsjaW5jbHVkZSAicWVtdS9t
YWluLWxvb3AuaCIKPj4+ICsjaW5jbHVkZSAibGludXgtaGVhZGVycy9saW51eC92aG9zdC5oIgo+
Pj4gKwo+Pj4gKy8qKiBGb3J3YXJkIGd1ZXN0IG5vdGlmaWNhdGlvbnMgKi8KPj4+ICtzdGF0aWMg
dm9pZCB2aG9zdF9oYW5kbGVfZ3Vlc3Rfa2ljayhFdmVudE5vdGlmaWVyICpuKQo+Pj4gK3sKPj4+
ICsgICAgVmhvc3RTaGFkb3dWaXJ0cXVldWUgKnN2cSA9IGNvbnRhaW5lcl9vZihuLCBWaG9zdFNo
YWRvd1ZpcnRxdWV1ZSwKPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzdnFfa2ljayk7Cj4+PiArICAgIGV2ZW50X25vdGlmaWVyX3Rlc3RfYW5kX2NsZWFy
KG4pOwo+Pj4gKyAgICBldmVudF9ub3RpZmllcl9zZXQoJnN2cS0+aGRldl9raWNrKTsKPj4+ICt9
Cj4+PiArCj4+PiArLyoqCj4+PiArICogU2V0IGEgbmV3IGZpbGUgZGVzY3JpcHRvciBmb3IgdGhl
IGd1ZXN0IHRvIGtpY2sgdGhlIFNWUSBhbmQgbm90aWZ5IGZvciBhdmFpbAo+Pj4gKyAqCj4+PiAr
ICogQHN2cSAgICAgICAgICBUaGUgc3ZxCj4+PiArICogQHN2cV9raWNrX2ZkICBUaGUgc3ZxIGtp
Y2sgZmQKPj4+ICsgKgo+Pj4gKyAqIE5vdGUgdGhhdCB0aGUgU1ZRIHdpbGwgbmV2ZXIgY2xvc2Ug
dGhlIG9sZCBmaWxlIGRlc2NyaXB0b3IuCj4+PiArICovCj4+PiArdm9pZCB2aG9zdF9zdnFfc2V0
X3N2cV9raWNrX2ZkKFZob3N0U2hhZG93VmlydHF1ZXVlICpzdnEsIGludCBzdnFfa2lja19mZCkK
Pj4+ICt7Cj4+PiArICAgIEV2ZW50Tm90aWZpZXIgKnN2cV9raWNrID0gJnN2cS0+c3ZxX2tpY2s7
Cj4+PiArICAgIGJvb2wgcG9sbF9zdG9wID0gVkhPU1RfRklMRV9VTkJJTkQgIT0gZXZlbnRfbm90
aWZpZXJfZ2V0X2ZkKHN2cV9raWNrKTsKPj4gSSB3b25kZXIgaWYgdGhpcyBpcyByb2J1c3QuIEUu
ZyBpcyB0aGVyZSBhbnkgY2hhbmNlIHRoYXQgbWF5IGVuZCB1cCB3aXRoCj4+IGJvdGggcG9sbF9z
dG9wIGFuZCBwb2xsX3N0YXJ0IGFyZSBmYWxzZT8KPj4KPiBJIGNhbm5vdCBtYWtlIHRoYXQgaGFw
cGVuIGluIHFlbXUsIGJ1dCB0aGUgZnVuY3Rpb24gc3VwcG9ydHMgdGhhdCBjYXNlCj4gd2VsbDog
SXQgd2lsbCBkbyBub3RoaW5nLiBJdCdzIG1vcmUgb3IgbGVzcyB0aGUgc2FtZSBjb2RlIGFzIHVz
ZWQgaW4KPiB0aGUgdmhvc3Qga2VybmVsLCBhbmQgaXMgdGhlIGV4cGVjdGVkIGJlaGF2aW91ciBp
ZiB5b3Ugc2VuZCB0d28KPiBWSE9TVF9GSUxFX1VOQklORCBvbmUgcmlnaHQgYWZ0ZXIgYW5vdGhl
ciB0byBtZS4KCgpJIHdvdWxkIHRoaW5rIGl0J3MganVzdCBzdG9wIHR3aWNlLgoKCj4KPj4gSWYg
bm90LCBjYW4gd2Ugc2ltcGxlIGRldGVjdCBwb2xsX3N0b3AgYXMgYmVsb3cgYW5kIHRyZWF0ICFw
b2xsX3N0YXJ0Cj4+IGFuZCBwb2xsX3N0b3A/Cj4+Cj4gSSdtIG5vdCBzdXJlIHdoYXQgZG9lcyBp
dCBhZGQuIElzIHRoZXJlIGFuIHVuZXhwZWN0ZWQgY29uc2VxdWVuY2Ugd2l0aAo+IHRoZSBjdXJy
ZW50IGRvLW5vdGhpbmcgYmVoYXZpb3IgSSd2ZSBtaXNzZWQ/CgoKSSdtIG5vdCBzdXJlLCBidXQg
aXQgZmVlbHMgb2RkIGlmIHBvbGxfc3RhcnQgaXMgbm90IHRoZSByZXZlcnNlIHZhbHVlIG9mIApw
b2xsX3N0b3AuCgpUaGFua3MKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
