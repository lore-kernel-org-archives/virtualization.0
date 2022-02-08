Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B333EC433F5
	for <virtualization@archiver.kernel.org>; Tue,  8 Feb 2022 03:38:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D5A081777;
	Tue,  8 Feb 2022 03:38:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LXsyU89T5tqu; Tue,  8 Feb 2022 03:38:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B79FC81415;
	Tue,  8 Feb 2022 03:38:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91C2AC001A;
	Tue,  8 Feb 2022 03:38:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C0E6C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:38:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3A99181771
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:38:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JU5hZJt0991W
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:38:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E64BC81415
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644291480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WBJDGjWqVOtiSrvehByB/6mHxa5s6JVt4CfgbH5eOCw=;
 b=a0+G96ECfWHrJxsdhHd8Q8lyDTJtYiw2xiB5BQSyiIHuSLMWwAsT9J68tCt5ZVS+JPl5HF
 1S6vRwI8BSvpSaus14Ag8Y3H/RUmAB58/Yy2qjpuTHZeGzORrFuN2wzEl3lqk1DxnwAy+i
 xBhitKmQdIMnjIjcz9tbc1nh0dlWXI0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-hoifN0zBNF2GaBt_I7Suug-1; Mon, 07 Feb 2022 22:37:59 -0500
X-MC-Unique: hoifN0zBNF2GaBt_I7Suug-1
Received: by mail-pj1-f72.google.com with SMTP id
 g14-20020a17090a7d0e00b001b8ef9f9545so514700pjl.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Feb 2022 19:37:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=WBJDGjWqVOtiSrvehByB/6mHxa5s6JVt4CfgbH5eOCw=;
 b=lyByaYAEmXWCwg9WhjrzJ/BXkHrOdNIPqCptQysGYc2L/yjfRnupRDZJ7P9MZ+D2J4
 K0xnvhSEXZ3RRbRlWEOjxZ/6+u+OP7IcxoxHkaxAjxI/XI3L1coXS5BSRA8nbH9nVkx4
 eMk2AZTiydnzT2Y+bJY2ZPA4X9SHkm+nRX4aF4sCwXXOqNXsimGKbxDCri0hFQujityp
 8kCi6hPzGyYXkDZgBsng0AFARg2Ja0SMXi4FonwLsn+sAkI7SYSjqlpgyGs3jiVdKHkn
 RbS7lnmQmzcBEnEz9tghTjh0sfk5+L2GLzkdeeo6Z3lsIsujcHH8zfil3j++Epc5Gz6C
 Skqg==
X-Gm-Message-State: AOAM533tgYht7HScfOLvtrIJdzmjSH840wplZr1nxkW5XH3JxuWjaV1I
 GbGMG6fsN4Ad800JtfJr2tCEjzPMvJqm8QBw5Pvme8Q2TSR77Q2NRlgbXto0F8mIek5Ejws0x7y
 q43VpoUstgYsoV6WUMp3fn6TAYeR2ZfyY56Rbw7/l1w==
X-Received: by 2002:a63:8648:: with SMTP id x69mr2012593pgd.25.1644291478445; 
 Mon, 07 Feb 2022 19:37:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxt+5PbADUI11q2peCXupot8uYUWm5YMKSY/KIIntuRrfcbN/FhzVjVKAvRjgqVVgStAK0OYw==
X-Received: by 2002:a63:8648:: with SMTP id x69mr2012564pgd.25.1644291478117; 
 Mon, 07 Feb 2022 19:37:58 -0800 (PST)
Received: from [10.72.13.233] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id f3sm13802408pfe.43.2022.02.07.19.37.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Feb 2022 19:37:57 -0800 (PST)
Message-ID: <74f2ed86-d936-4d0c-83cb-9e5d86425bc1@redhat.com>
Date: Tue, 8 Feb 2022 11:37:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH 11/31] vhost: Add vhost_svq_valid_device_features to
 shadow vq
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-12-eperezma@redhat.com>
 <660257ba-6445-3fb2-1da4-3b141e382191@redhat.com>
 <CAJaqyWfaf0RG9AzW4ktH2L3wyfOGuSk=rNm-j7xRkpdfVvkY-g@mail.gmail.com>
 <CAJaqyWc6BqJBDcUE36AQ=bgWjJYkyMo1ZYxRwmc5ZgGj4T-pVg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <CAJaqyWc6BqJBDcUE36AQ=bgWjJYkyMo1ZYxRwmc5ZgGj4T-pVg@mail.gmail.com>
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

CuWcqCAyMDIyLzIvMSDkuIvljYg2OjU3LCBFdWdlbmlvIFBlcmV6IE1hcnRpbiDlhpnpgZM6Cj4g
T24gTW9uLCBKYW4gMzEsIDIwMjIgYXQgNDo0OSBQTSBFdWdlbmlvIFBlcmV6IE1hcnRpbgo+IDxl
cGVyZXptYUByZWRoYXQuY29tPiB3cm90ZToKPj4gT24gU2F0LCBKYW4gMjksIDIwMjIgYXQgOTox
MSBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPj4+Cj4+PiDlnKgg
MjAyMi8xLzIyIOS4iuWNiDQ6MjcsIEV1Z2VuaW8gUMOpcmV6IOWGmemBkzoKPj4+PiBUaGlzIGFs
bG93cyBTVlEgdG8gbmVnb3RpYXRlIGZlYXR1cmVzIHdpdGggdGhlIGRldmljZS4gRm9yIHRoZSBk
ZXZpY2UsCj4+Pj4gU1ZRIGlzIGEgZHJpdmVyLiBXaGlsZSB0aGlzIGZ1bmN0aW9uIG5lZWRzIHRv
IGJ5cGFzcyBhbGwgbm9uLXRyYW5zcG9ydAo+Pj4+IGZlYXR1cmVzLCBpdCBuZWVkcyB0byBkaXNh
YmxlIHRoZSBmZWF0dXJlcyB0aGF0IFNWUSBkb2VzIG5vdCBzdXBwb3J0Cj4+Pj4gd2hlbiBmb3J3
YXJkaW5nIGJ1ZmZlcnMuIFRoaXMgaW5jbHVkZXMgcGFja2VkIHZxIGxheW91dCwgaW5kaXJlY3QK
Pj4+PiBkZXNjcmlwdG9ycyBvciBldmVudCBpZHguCj4+Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBF
dWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPj4+PiAtLS0KPj4+PiAgICBody92
aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5oIHwgIDIgKysKPj4+PiAgICBody92aXJ0aW8v
dmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5jIHwgNDQgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrCj4+Pj4gICAgaHcvdmlydGlvL3Zob3N0LXZkcGEuYyAgICAgICAgICAgICB8IDIxICsrKysr
KysrKysrKysrCj4+Pj4gICAgMyBmaWxlcyBjaGFuZ2VkLCA2NyBpbnNlcnRpb25zKCspCj4+Pj4K
Pj4+PiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuaCBiL2h3
L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmgKPj4+PiBpbmRleCBjOWZmYTExZmNlLi5k
OTYzODY3YTA0IDEwMDY0NAo+Pj4+IC0tLSBhL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1
ZXVlLmgKPj4+PiArKysgYi9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5oCj4+Pj4g
QEAgLTE1LDYgKzE1LDggQEAKPj4+Pgo+Pj4+ICAgIHR5cGVkZWYgc3RydWN0IFZob3N0U2hhZG93
VmlydHF1ZXVlIFZob3N0U2hhZG93VmlydHF1ZXVlOwo+Pj4+Cj4+Pj4gK2Jvb2wgdmhvc3Rfc3Zx
X3ZhbGlkX2RldmljZV9mZWF0dXJlcyh1aW50NjRfdCAqZmVhdHVyZXMpOwo+Pj4+ICsKPj4+PiAg
ICB2b2lkIHZob3N0X3N2cV9zZXRfc3ZxX2tpY2tfZmQoVmhvc3RTaGFkb3dWaXJ0cXVldWUgKnN2
cSwgaW50IHN2cV9raWNrX2ZkKTsKPj4+PiAgICB2b2lkIHZob3N0X3N2cV9zZXRfZ3Vlc3RfY2Fs
bF9ub3RpZmllcihWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqc3ZxLCBpbnQgY2FsbF9mZCk7Cj4+Pj4g
ICAgY29uc3QgRXZlbnROb3RpZmllciAqdmhvc3Rfc3ZxX2dldF9kZXZfa2lja19ub3RpZmllcigK
Pj4+PiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuYyBiL2h3
L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMKPj4+PiBpbmRleCA5NjE5YzgwODJjLi41
MTQ0MmIzZGJmIDEwMDY0NAo+Pj4+IC0tLSBhL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1
ZXVlLmMKPj4+PiArKysgYi9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5jCj4+Pj4g
QEAgLTQ1LDYgKzQ1LDUwIEBAIGNvbnN0IEV2ZW50Tm90aWZpZXIgKnZob3N0X3N2cV9nZXRfZGV2
X2tpY2tfbm90aWZpZXIoCj4+Pj4gICAgICAgIHJldHVybiAmc3ZxLT5oZGV2X2tpY2s7Cj4+Pj4g
ICAgfQo+Pj4+Cj4+Pj4gKy8qKgo+Pj4+ICsgKiBWYWxpZGF0ZSB0aGUgdHJhbnNwb3J0IGRldmlj
ZSBmZWF0dXJlcyB0aGF0IFNWUSBjYW4gdXNlIHdpdGggdGhlIGRldmljZQo+Pj4+ICsgKgo+Pj4+
ICsgKiBAZGV2X2ZlYXR1cmVzICBUaGUgZGV2aWNlIGZlYXR1cmVzLiBJZiBzdWNjZXNzLCB0aGUg
YWNrbm93bGVkZ2VkIGZlYXR1cmVzLgo+Pj4+ICsgKgo+Pj4+ICsgKiBSZXR1cm5zIHRydWUgaWYg
U1ZRIGNhbiBnbyB3aXRoIGEgc3Vic2V0IG9mIHRoZXNlLCBmYWxzZSBvdGhlcndpc2UuCj4+Pj4g
KyAqLwo+Pj4+ICtib29sIHZob3N0X3N2cV92YWxpZF9kZXZpY2VfZmVhdHVyZXModWludDY0X3Qg
KmRldl9mZWF0dXJlcykKPj4+PiArewo+Pj4+ICsgICAgYm9vbCByID0gdHJ1ZTsKPj4+PiArCj4+
Pj4gKyAgICBmb3IgKHVpbnQ2NF90IGIgPSBWSVJUSU9fVFJBTlNQT1JUX0ZfU1RBUlQ7IGIgPD0g
VklSVElPX1RSQU5TUE9SVF9GX0VORDsKPj4+PiArICAgICAgICAgKytiKSB7Cj4+Pj4gKyAgICAg
ICAgc3dpdGNoIChiKSB7Cj4+Pj4gKyAgICAgICAgY2FzZSBWSVJUSU9fRl9OT1RJRllfT05fRU1Q
VFk6Cj4+Pj4gKyAgICAgICAgY2FzZSBWSVJUSU9fRl9BTllfTEFZT1VUOgo+Pj4+ICsgICAgICAg
ICAgICBjb250aW51ZTsKPj4+PiArCj4+Pj4gKyAgICAgICAgY2FzZSBWSVJUSU9fRl9BQ0NFU1Nf
UExBVEZPUk06Cj4+Pj4gKyAgICAgICAgICAgIC8qIFNWUSBkb2VzIG5vdCBrbm93IGhvdyB0byB0
cmFuc2xhdGUgYWRkcmVzc2VzICovCj4+Pgo+Pj4gSSBtYXkgbWlzcyBzb21ldGhpbmcgYnV0IGFu
eSByZWFzb24gdGhhdCB3ZSBuZWVkIHRvIGRpc2FibGUKPj4+IEFDQ0VTU19QTEFURk9STT8gSSdk
IGV4cGVjdCB0aGUgdnJpbmcgaGVscGVyIHdlIHVzZWQgZm9yIHNoYWRvdwo+Pj4gdmlydHF1ZXVl
IGNhbiBkZWFsIHdpdGggdklPTU1VIHBlcmZlY3RseS4KPj4+Cj4+IFRoaXMgZnVuY3Rpb24gaXMg
dmFsaWRhdGluZyBTVlEgPC0+IERldmljZSBjb21tdW5pY2F0aW9ucyBmZWF0dXJlcywKPj4gdGhh
dCBtYXkgb3IgbWF5IG5vdCBiZSB0aGUgc2FtZSBhcyBndWVzdCA8LT4gU1ZRLiBUaGVzZSBmZWF0
dXJlIGZsYWdzCj4+IGFyZSB2YWxpZCBmb3IgZ3Vlc3QgPC0+IFNWUSBjb21tdW5pY2F0aW9uLCBz
YW1lIGFzIHdpdGggaW5kaXJlY3QKPj4gZGVzY3JpcHRvcnMgb25lLgo+Pgo+PiBIYXZpbmcgc2Fp
ZCB0aGF0LCB0aGVyZSBpcyBhIHBvaW50IGluIHRoZSBzZXJpZXMgd2hlcmUKPj4gVklSVElPX0Zf
QUNDRVNTX1BMQVRGT1JNIGlzIGFjdHVhbGx5IG1hbmRhdG9yeSwgc28gSSB0aGluayB3ZSBjb3Vs
ZAo+PiB1c2UgdGhlIGxhdHRlciBhZGRpdGlvbiBvZiB4LXN2cSBjbWRsaW5lIHBhcmFtZXRlciBh
bmQgZGVsYXkgdGhlCj4+IGZlYXR1cmUgdmFsaWRhdGlvbnMgd2hlcmUgaXQgbWFrZXMgbW9yZSBz
ZW5zZS4KPj4KPj4+PiArICAgICAgICAgICAgaWYgKCpkZXZfZmVhdHVyZXMgJiBCSVRfVUxMKGIp
KSB7Cj4+Pj4gKyAgICAgICAgICAgICAgICBjbGVhcl9iaXQoYiwgZGV2X2ZlYXR1cmVzKTsKPj4+
PiArICAgICAgICAgICAgICAgIHIgPSBmYWxzZTsKPj4+PiArICAgICAgICAgICAgfQo+Pj4+ICsg
ICAgICAgICAgICBicmVhazsKPj4+PiArCj4+Pj4gKyAgICAgICAgY2FzZSBWSVJUSU9fRl9WRVJT
SU9OXzE6Cj4+Pgo+Pj4gSSBoYWQgdGhlIHNhbWUgcXVlc3Rpb24gaGVyZS4KPj4+Cj4+IEZvciBW
RVJTSU9OXzEgaXQncyBlYXNpZXIgdG8gYXNzdW1lIHRoYXQgZ3Vlc3QgaXMgbGl0dGxlIGVuZGlh
biBhdAo+PiBzb21lIHBvaW50cywgYnV0IHdlIGNvdWxkIHRyeSBoYXJkZXIgdG8gc3VwcG9ydCBi
b3RoIGVuZGlhbm5lc3MgaWYKPj4gbmVlZGVkLgo+Pgo+IFJlLXRoaW5raW5nIHRoZSBTVlEgZmVh
dHVyZSBpc29sYXRpb24gc3R1ZmYgZm9yIHRoaXMgZmlyc3QgaXRlcmF0aW9uCj4gYmFzZWQgb24g
eW91ciBjb21tZW50cy4KPgo+IE1heWJlIGl0J3MgZWFzaWVyIHRvIHNpbXBseSBmYWlsIGlmIHRo
ZSBkZXZpY2UgZG9lcyBub3QgKm1hdGNoKiB0aGUKPiBleHBlY3RlZCBmZWF0dXJlIHNldCwgYW5k
IGFkZCBhbGwgb2YgdGhlICJmZWF0dXJlIGlzb2xhdGlvbiIgbGF0ZXIuCj4gV2hpbGUgYSBsb3Qg
b2YgZ3Vlc3QgPC0+IFNWUSBjb21tdW5pY2F0aW9uIGRldGFpbHMgYXJlIGFscmVhZHkgc29sdmVk
Cj4gZm9yIGZyZWUgd2l0aCBxZW11J3MgVmlydFF1ZXVlIChpbmRpcmVjdCwgcGFja2VkLCAuLi4p
LCB3ZSBtYXkKPiBzaW1wbGlmeSB0aGlzIHNlcmllcyBpbiBwYXJ0aWN1bGFyIGFuZCBhZGQgdGhl
IHN1cHBvcnQgZm9yIGl0IGxhdGVyLgo+Cj4gRm9yIGV4YW1wbGUsIGF0IHRoaXMgbW9tZW50IHdv
dWxkIGJlIHZhbGlkIGZvciB0aGUgZGV2aWNlIHRvIGV4cG9ydAo+IGluZGlyZWN0IGRlc2NyaXB0
b3JzIGZlYXR1cmUgZmxhZywgYW5kIFNWUSBzaW1wbHkgZm9yd2FyZCB0aGF0IGZlYXR1cmUKPiBm
bGFnIG9mZmVyaW5nIHRvIHRoZSBndWVzdC4gU28gdGhlIGd1ZXN0IDwtPiBTVlEgY29tbXVuaWNh
dGlvbiBjb3VsZAo+IGhhdmUgaW5kaXJlY3QgZGVzY3JpcHRvcnMgKHFlbXUncyBWaXJ0UXVldWUg
Y29kZSBoYW5kbGVzIGl0IGZvciBmcmVlKSwKPiBidXQgU1ZRIHdvdWxkIG5vdCBhY2tub3dsZWRn
ZSBpdCBmb3IgdGhlIGRldmljZS4gQXMgYSBzaWRlIG5vdGUsIHRvCj4gbmVnb3RpYXRlIGl0IHdv
dWxkIGhhdmUgYmVlbiBoYXJtbGVzcyBhY3R1YWxseSwgYnV0IGl0J3Mgbm90IHRoZSBjYXNlCj4g
b2YgcGFja2VkIHZxLgo+Cj4gU28gbWF5YmUgZm9yIHRoZSB2MiB3ZSBjYW4gc2ltcGx5IGZvcmNl
IHRoZSBkZXZpY2UgdG8ganVzdCBleHBvcnQgdGhlCj4gc3RyaWN0bHkgbmVlZGVkIGZlYXR1cmVz
IGFuZCBub3RoaW5nIGVsc2Ugd2l0aCBxZW11IGNtZGxpbmUsIGFuZCB0aGVuCj4gZW5hYmxlIHRo
ZSBmZWF0dXJlIG5lZ290aWF0aW9uIGlzb2xhdGlvbiBmb3IgZWFjaCBzaWRlIG9mIFNWUT8KCgpZ
ZXMsIHRoYXQncyBleGFjdGx5IG15IHBvaW50LgoKVGhhbmtzCgoKPgo+IFRoYW5rcyEKPgo+Cj4+
IFRoYW5rcyEKPj4KPj4+IFRoYW5rcwo+Pj4KPj4+Cj4+Pj4gKyAgICAgICAgICAgIC8qIFNWUSB0
cnVzdCB0aGF0IGd1ZXN0IHZyaW5nIGlzIGxpdHRsZSBlbmRpYW4gKi8KPj4+PiArICAgICAgICAg
ICAgaWYgKCEoKmRldl9mZWF0dXJlcyAmIEJJVF9VTEwoYikpKSB7Cj4+Pj4gKyAgICAgICAgICAg
ICAgICBzZXRfYml0KGIsIGRldl9mZWF0dXJlcyk7Cj4+Pj4gKyAgICAgICAgICAgICAgICByID0g
ZmFsc2U7Cj4+Pj4gKyAgICAgICAgICAgIH0KPj4+PiArICAgICAgICAgICAgY29udGludWU7Cj4+
Pj4gKwo+Pj4+ICsgICAgICAgIGRlZmF1bHQ6Cj4+Pj4gKyAgICAgICAgICAgIGlmICgqZGV2X2Zl
YXR1cmVzICYgQklUX1VMTChiKSkgewo+Pj4+ICsgICAgICAgICAgICAgICAgY2xlYXJfYml0KGIs
IGRldl9mZWF0dXJlcyk7Cj4+Pj4gKyAgICAgICAgICAgIH0KPj4+PiArICAgICAgICB9Cj4+Pj4g
KyAgICB9Cj4+Pj4gKwo+Pj4+ICsgICAgcmV0dXJuIHI7Cj4+Pj4gK30KPj4+PiArCj4+Pj4gICAg
LyogRm9yd2FyZCBndWVzdCBub3RpZmljYXRpb25zICovCj4+Pj4gICAgc3RhdGljIHZvaWQgdmhv
c3RfaGFuZGxlX2d1ZXN0X2tpY2soRXZlbnROb3RpZmllciAqbikKPj4+PiAgICB7Cj4+Pj4gZGlm
ZiAtLWdpdCBhL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMgYi9ody92aXJ0aW8vdmhvc3QtdmRwYS5j
Cj4+Pj4gaW5kZXggYmRiNDVjODgwOC4uOWQ4MDFjZjkwNyAxMDA2NDQKPj4+PiAtLS0gYS9ody92
aXJ0aW8vdmhvc3QtdmRwYS5jCj4+Pj4gKysrIGIvaHcvdmlydGlvL3Zob3N0LXZkcGEuYwo+Pj4+
IEBAIC04NTUsMTAgKzg1NSwzMSBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfaW5pdF9zdnEoc3Ry
dWN0IHZob3N0X2RldiAqaGRldiwgc3RydWN0IHZob3N0X3ZkcGEgKnYsCj4+Pj4gICAgICAgIHNp
emVfdCBuX3N2cXMgPSB2LT5zaGFkb3dfdnFzX2VuYWJsZWQgPyBoZGV2LT5udnFzIDogMDsKPj4+
PiAgICAgICAgZ19hdXRvcHRyKEdQdHJBcnJheSkgc2hhZG93X3ZxcyA9IGdfcHRyX2FycmF5X25l
d19mdWxsKG5fc3ZxcywKPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHZob3N0X3BzdnFfZnJlZSk7Cj4+Pj4gKyAgICB1aW50
NjRfdCBkZXZfZmVhdHVyZXM7Cj4+Pj4gKyAgICB1aW50NjRfdCBzdnFfZmVhdHVyZXM7Cj4+Pj4g
KyAgICBpbnQgcjsKPj4+PiArICAgIGJvb2wgb2s7Cj4+Pj4gKwo+Pj4+ICAgICAgICBpZiAoIXYt
PnNoYWRvd192cXNfZW5hYmxlZCkgewo+Pj4+ICAgICAgICAgICAgZ290byBvdXQ7Cj4+Pj4gICAg
ICAgIH0KPj4+Pgo+Pj4+ICsgICAgciA9IHZob3N0X3ZkcGFfZ2V0X2ZlYXR1cmVzKGhkZXYsICZk
ZXZfZmVhdHVyZXMpOwo+Pj4+ICsgICAgaWYgKHIgIT0gMCkgewo+Pj4+ICsgICAgICAgIGVycm9y
X3NldGcoZXJycCwgIkNhbid0IGdldCB2ZHBhIGRldmljZSBmZWF0dXJlcywgZ290ICglZCkiLCBy
KTsKPj4+PiArICAgICAgICByZXR1cm4gcjsKPj4+PiArICAgIH0KPj4+PiArCj4+Pj4gKyAgICBz
dnFfZmVhdHVyZXMgPSBkZXZfZmVhdHVyZXM7Cj4+Pj4gKyAgICBvayA9IHZob3N0X3N2cV92YWxp
ZF9kZXZpY2VfZmVhdHVyZXMoJnN2cV9mZWF0dXJlcyk7Cj4+Pj4gKyAgICBpZiAodW5saWtlbHko
IW9rKSkgewo+Pj4+ICsgICAgICAgIGVycm9yX3NldGcoZXJycCwKPj4+PiArICAgICAgICAgICAg
IlNWUSBJbnZhbGlkIGRldmljZSBmZWF0dXJlIGZsYWdzLCBvZmZlcjogMHglIlBSSXg2NCIsIG9r
OiAweCUiUFJJeDY0LAo+Pj4+ICsgICAgICAgICAgICBoZGV2LT5mZWF0dXJlcywgc3ZxX2ZlYXR1
cmVzKTsKPj4+PiArICAgICAgICByZXR1cm4gLTE7Cj4+Pj4gKyAgICB9Cj4+Pj4gKwo+Pj4+ICsg
ICAgc2hhZG93X3ZxcyA9IGdfcHRyX2FycmF5X25ld19mdWxsKGhkZXYtPm52cXMsIHZob3N0X3Bz
dnFfZnJlZSk7Cj4+Pj4gICAgICAgIGZvciAodW5zaWduZWQgbiA9IDA7IG4gPCBoZGV2LT5udnFz
OyArK24pIHsKPj4+PiAgICAgICAgICAgIFZob3N0U2hhZG93VmlydHF1ZXVlICpzdnEgPSB2aG9z
dF9zdnFfbmV3KCk7Cj4+Pj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
