Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD50C433F5
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 03:38:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AB0C94018B;
	Wed,  9 Mar 2022 03:38:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gutq8MQPCLoz; Wed,  9 Mar 2022 03:38:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 199F3400EA;
	Wed,  9 Mar 2022 03:38:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC1E2C0012;
	Wed,  9 Mar 2022 03:38:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71335C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 03:38:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5A09F80BC6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 03:38:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dZHoGpIk_F9p
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 03:38:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 14E6E80BBE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 03:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646797129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ODc3FvhZAosS2Q9f9lguzl+ofP+AnKzcUi0ij8uSBzM=;
 b=EjDtetwgyh22eA3jrB/ZLF0KwFEFhMEMumk+WjaeGdYE1RLJ0QuZSo43gUe9Sq9uxSj0AS
 RwlapcNMJOl6xCjocrwMd34KhLZGVbXGEAaLuw/65FU70B0PFfRMmkmox/yXIzi9yknNdP
 pMsEz1kCg6Q+z2jYQ9l5NMfj+o3p1+w=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-8Y0VLaFPOMSBaGo0hFPoAw-1; Tue, 08 Mar 2022 22:38:48 -0500
X-MC-Unique: 8Y0VLaFPOMSBaGo0hFPoAw-1
Received: by mail-pf1-f200.google.com with SMTP id
 k130-20020a628488000000b004f362b45f28so780669pfd.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 19:38:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ODc3FvhZAosS2Q9f9lguzl+ofP+AnKzcUi0ij8uSBzM=;
 b=F6lxWLWj+v5c0DmM6ZdOdps4wct92SRfJ/V7+jXvod/6PvHAreODAp53RUSaSV0DYP
 mMNSpl0fA5yr5I2/sKrfoxlMTdGWXh2fN/HbR39C2XyWXQleXIpevYDvbe3qhit/ufFz
 p1/AmWIhmPElfiVYx59YhoxhcktsppGPWNFXFuhqXMuNIpWPdUTX2nFayIGgvnKcRcVL
 qKNbluYJnSc3a/6jtxlcOB5EPU5t6dGlITron7bNKsi7btixReelLTcq/SMJHfjz0/93
 66YsQAN4hrlQhKLju0N/N8cchNDXb30535yf+oCyb48mH9RNjeRaBpIuqH2lS5GRCbM4
 +gfw==
X-Gm-Message-State: AOAM532YKsNyly8ZHgDc0bMVfej+admcQRwUIQo9Ha6owEYVI7AN/aQs
 JGpL/07OjaDEZBbZ1drTyOwxjGARH8ddQyzw73q7VBm0sO3K0aNSqwsHUNAm24i8bVBbZNyasuR
 ua7+s8zE28W5orVjCTWINJpdD39g5cCTtCGhQcaJEhg==
X-Received: by 2002:a17:902:7d81:b0:14f:e18b:2b9e with SMTP id
 a1-20020a1709027d8100b0014fe18b2b9emr20657994plm.160.1646797127588; 
 Tue, 08 Mar 2022 19:38:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJytpQxpDYX4liC3oStD1o7SXpi885MfR487ys49o0EV5Fgo3XVsQZXcDvNFiGwB1DEXKXQpSg==
X-Received: by 2002:a17:902:7d81:b0:14f:e18b:2b9e with SMTP id
 a1-20020a1709027d8100b0014fe18b2b9emr20657957plm.160.1646797127285; 
 Tue, 08 Mar 2022 19:38:47 -0800 (PST)
Received: from [10.72.13.251] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a17090ad59600b001b7deb42251sm4455930pju.15.2022.03.08.19.38.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Mar 2022 19:38:46 -0800 (PST)
Message-ID: <56b837a6-c67d-5ffc-bd70-ba51d996a6c2@redhat.com>
Date: Wed, 9 Mar 2022 11:38:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v5 00/15] vDPA shadow virtqueue
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>
References: <20220307153334.3854134-1-eperezma@redhat.com>
 <14d4fde4-6ea5-4805-b684-c33f6b448565@redhat.com>
 <20220308020348-mutt-send-email-mst@kernel.org>
 <CACGkMEvY-+XpPWbtiX9dy+fwDxPp7sHFhH_LY0PB2YuusEugyw@mail.gmail.com>
 <20220308022300-mutt-send-email-mst@kernel.org>
 <CACGkMEvuTPCRk7Ng7CbgpPSPgs_QYijzc5fU+cV3kW09W1R7Qg@mail.gmail.com>
 <20220308024724-mutt-send-email-mst@kernel.org>
 <CACGkMEsPBDM8ko1qgnCR1DcofPNJJo3S2j3pOJHk4xaSGQimcQ@mail.gmail.com>
 <20220308054623-mutt-send-email-mst@kernel.org>
 <CAJaqyWcuitG+01pjO__tYERN9910fL_JGiHG88xU=fTG3KmpJw@mail.gmail.com>
 <20220308071253-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220308071253-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: qemu-devel <qemu-devel@nongnu.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eli Cohen <eli@mellanox.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cindy Lu <lulu@redhat.com>,
 "Fangyi \(Eric\)" <eric.fangyi@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, yebiaoxiang@huawei.com,
 Liuxiangdong <liuxiangdong5@huawei.com>, Laurent Vivier <lvivier@redhat.com>,
 Parav Pandit <parav@mellanox.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gautam Dawar <gdawar@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Lingshan <lingshan.zhu@intel.com>
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

CuWcqCAyMDIyLzMvOCDkuIvljYg4OjE2LCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+IE9u
IFR1ZSwgTWFyIDA4LCAyMDIyIGF0IDEyOjM3OjMzUE0gKzAxMDAsIEV1Z2VuaW8gUGVyZXogTWFy
dGluIHdyb3RlOgo+PiBPbiBUdWUsIE1hciA4LCAyMDIyIGF0IDExOjQ4IEFNIE1pY2hhZWwgUy4g
VHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4gT24gVHVlLCBNYXIgMDgsIDIwMjIg
YXQgMDQ6MjA6NTNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pj4gTm90IGJ5IGl0c2Vs
ZiBidXQgSSdtIG5vdCBzdXJlIHdlIGNhbiBndWFyYW50ZWUgZ3Vlc3Qgd2lsbCBub3QKPj4+Pj4g
YXR0ZW1wdCB0byB1c2UgdGhlIElPVkEgYWRkcmVzc2VzIHdlIGFyZSByZXNlcnZpbmcgZG93bgo+
Pj4+PiB0aGUgcm9hZC4KPj4+PiBUaGUgSU9WQSBpcyBhbGxvY2F0ZWQgdmlhIHRoZSBsaXN0ZW5l
cnMgYW5kIHN0b3JlZCBpbiB0aGUgaW92YSB0cmVlCj4+Pj4gcGVyIEdQQSByYW5nZSBhcyBJT1ZB
LT4oR1BBKS0+SFZBLkd1ZXN0cyB3aWxsIG9ubHkgc2VlIEdQQSwgUWVtdQo+Pj4+IHZpcnRpbyBj
b3JlIHNlZSBHUEEgdG8gSFZBIG1hcHBpbmcuIEFuZCB3ZSBkbyBhIHJldmVyc2UgbG9va3VwIHRv
IGZpbmQKPj4+PiB0aGUgSFZBLT5JT1ZBIHdlIGFsbG9jYXRlZCBwcmV2aW91c2x5LiAgU28gd2Ug
aGF2ZSBkb3VibGUgY2hlY2sgaGVyZToKPj4+Pgo+Pj4+IDEpIFFlbXUgbWVtb3J5IGNvcmUgdG8g
bWFrZSBzdXJlIHRoZSBHUEEgdGhhdCBndWVzdCB1c2VzIGlzIHZhbGlkCj4+Pj4gMikgdGhlIElP
VkEgdHJlZSB0aGF0IGd1YXJhbnRlZXMgdGhlcmUgd2lsbCBiZSBubyBIVkEgYmV5b25kIHdoYXQK
Pj4+PiBndWVzdCBjYW4gc2VlIGlzIHVzZWQKPj4+Pgo+Pj4+IFNvIHRlY2huaWNhbGx5LCB0aGVy
ZSdzIG5vIHdheSBmb3IgdGhlIGd1ZXN0IHRvIHVzZSB0aGUgSU9WQSBhZGRyZXNzCj4+Pj4gYWxs
b2NhdGVkIGZvciB0aGUgc2hhZG93IHZpcnRxdWV1ZS4KPj4+Pgo+Pj4+IFRoYW5rcwo+Pj4gSSBt
ZWFuLCBJT1ZBIGlzIHByb2dyYW1tZWQgaW4gdGhlIGhvc3QgaGFyZHdhcmUgdG8gdHJhbnNsYXRl
IHRvIEhQQSwgcmlnaHQ/Cj4+Pgo+PiBZZXMsIHRoYXQncyByaWdodCBpZiB0aGUgZGV2aWNlIHVz
ZXMgcGh5c2ljYWwgbWFwcy4gQWxzbyB0byBub3RlLCBTVlEKPj4gdnJpbmcgaXMgYWxsb2NhdGVk
IGluIG11bHRpcGxlcyBvZiBob3N0IGh1Z2UgcGFnZXMgdG8gYXZvaWQgZ2FyYmFnZSBvcgo+PiB1
bmludGVuZGVkIGFjY2VzcyBmcm9tIHRoZSBkZXZpY2UuCj4+Cj4+IElmIGEgdmRwYSBkZXZpY2Ug
dXNlcyBwaHlzaWNhbCBhZGRyZXNzZXMsIGtlcm5lbCB2ZHBhIHdpbGwgcGluIHFlbXUKPj4gbWVt
b3J5IGZpcnN0IGFuZCB0aGVuIHdpbGwgc2VuZCBJT1ZBIHRvIEhQQSB0cmFuc2xhdGlvbiB0byBo
YXJkd2FyZS4KPj4gQnV0IHRoaXMgSU9WQSBzcGFjZSBpcyBub3QgY29udHJvbGxlZCBieSB0aGUg
Z3Vlc3QsIGJ1dCBieSBTVlEuIElmIGEKPj4gZ3Vlc3QncyB2aXJ0cXVldWUgYnVmZmVyIGNhbm5v
dCBiZSB0cmFuc2xhdGVkIGZpcnN0IHRvIEdQQSwgaXQgd2lsbAo+PiBub3QgYmUgZm9yd2FyZGVk
Lgo+Pgo+PiBUaGFua3MhCj4gUmlnaHQuIFNvIGlmIGd1ZXN0cyBzZW5kIGEgYnVmZmVyIHdoZXJl
IGJ1ZmZlciBhZGRyZXNzIG92ZXJsYXBzIHRoZQo+IHJhbmdlIHdlIHVzZWQgZm9yIHRoZSBTVlEs
IHRoZW4gSSB0aGluayBhdCB0aGUgbW9tZW50IGd1ZXN0IHdvbid0IHdvcmsuCgoKVGhlcmUncyBu
byB3YXkgZm9yIGEgZ3Vlc3QgdG8gZG8gdGhpcywgaXQgY2FuIG9ubHkgdXNlIEdQQSBidXQgdGhl
IFFlbXUgCndvbid0IGxldCB2RFBBIHRvIHVzZSBHUEEgYXMgSU9WQS4gRGVkaWNhdGVkIElPVkEg
cmFuZ2VzIHdlcmUgYWxsb2NhdGVkIApmb3IgdGhvc2UgR1BBIHJhbmdlcyBzbyBTVlEgd29uJ3Qg
dXNlIElPVkEgdGhhdCBpcyBvdmVybGFwcGVkIHdpdGggd2hhdCAKR3Vlc3QgdXNlLgoKVGhhbmtz
CgoKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
