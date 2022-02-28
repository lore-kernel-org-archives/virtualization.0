Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EC9C433F5
	for <virtualization@archiver.kernel.org>; Mon, 28 Feb 2022 03:25:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB00F4090D;
	Mon, 28 Feb 2022 03:25:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xXvFVOrWtUcv; Mon, 28 Feb 2022 03:25:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 56BC440961;
	Mon, 28 Feb 2022 03:25:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B42FC0033;
	Mon, 28 Feb 2022 03:25:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B13FDC001A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 03:25:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8B15760D8E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 03:25:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Pd4Wtbe3Fh9s
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 03:25:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C20B060BD6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 03:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646018741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uBGmmgh3L921GFnnUvUto7LBuBjp7TB4MQ++o/+HMgg=;
 b=WDKSlGDVJ82txEi8l5wn9bn5tcyjKmG+M+CoSlP56iTHS5eifJ9DUa7HScZCYP/9z/boF1
 dWIPjI7y+5BM8S0vROwtXdKuc9o+K4vZrPM9NpFi5To16iTiKb1HGEMDAviiqAcDCJF/dm
 o/yx0WQd/2LwNBMBdeVWTRDT8xYVt+w=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-ZO99e7UWO4W-jL2aFHJUjQ-1; Sun, 27 Feb 2022 22:25:40 -0500
X-MC-Unique: ZO99e7UWO4W-jL2aFHJUjQ-1
Received: by mail-pl1-f200.google.com with SMTP id
 d7-20020a170902654700b0014fd2313fd2so4033908pln.13
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Feb 2022 19:25:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=uBGmmgh3L921GFnnUvUto7LBuBjp7TB4MQ++o/+HMgg=;
 b=WF8CMvkUB2E3fovYIVp0mLwKQ5sOSdLxtLas52NnAXmuGBmpeiD7LGeDKQpldVod0U
 33vQyqZZ1Uaj0GzvgpM9ELC26mVBBtPEL9fN1lGZv2q/UY/TYk7whw2aVKW6Js11aHKA
 9smQartFMZ8dgofU0oRtTf1T8/vBkI/47UCPRUIjKEh2Ii3mhxz8EW/144Zi1eZ4rRyX
 3fp55GuN5S3OAEd56KxNzNDe1RvIAhoJIWyZnHjDNq71MfrbM0KSe6qZXg3qwZLiRldW
 NezdqK1tvULzAFTK/xuBEggAuDDuUDNwjl3SYkg+4TW3V1TIymdBtJi8HnFnS2SssUdd
 cjkg==
X-Gm-Message-State: AOAM531A7BqkM4AVjLbfLX7Zkp3K9L8Q4Zj22xWTnriJ75plYIYZ299N
 tTqNJX3wjjKmiOCJIOJj1nXArpo0613qbisFpp3KR+n1G8LGGCS92yBhMugARap1AA3MugLB9VD
 eWBLc3Sajq4JzbfLI96NyaGUb7BpKZO3v76fjU5fOhQ==
X-Received: by 2002:a17:902:d0d2:b0:14f:d360:c103 with SMTP id
 n18-20020a170902d0d200b0014fd360c103mr18219664pln.7.1646018738198; 
 Sun, 27 Feb 2022 19:25:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy+UxnYE3e32yzxHP9sAdijs47rgWR/U9zXtvLtRRUhDMEg50hRt5las68gLILhDz/fQcof2A==
X-Received: by 2002:a17:902:d0d2:b0:14f:d360:c103 with SMTP id
 n18-20020a170902d0d200b0014fd360c103mr18219633pln.7.1646018737913; 
 Sun, 27 Feb 2022 19:25:37 -0800 (PST)
Received: from [10.72.13.215] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 d32-20020a631d60000000b003650a9d8f9asm8770479pgm.33.2022.02.27.19.25.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Feb 2022 19:25:37 -0800 (PST)
Message-ID: <562b97bc-860e-b2e6-0f45-945a75c25da5@redhat.com>
Date: Mon, 28 Feb 2022 11:25:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v2 04/14] vhost: Add vhost_svq_valid_features to shadow vq
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20220227134111.3254066-1-eperezma@redhat.com>
 <20220227134111.3254066-5-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220227134111.3254066-5-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, Eli Cohen <eli@mellanox.com>,
 Eric Blake <eblake@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Fangyi \(Eric\)" <eric.fangyi@huawei.com>,
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

CuWcqCAyMDIyLzIvMjcg5LiL5Y2IOTo0MSwgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IFRoaXMg
YWxsb3dzIFNWUSB0byBuZWdvdGlhdGUgZmVhdHVyZXMgd2l0aCB0aGUgZ3Vlc3QgYW5kIHRoZSBk
ZXZpY2UuIEZvcgo+IHRoZSBkZXZpY2UsIFNWUSBpcyBhIGRyaXZlci4gV2hpbGUgdGhpcyBmdW5j
dGlvbiBieXBhc3NlcyBhbGwKPiBub24tdHJhbnNwb3J0IGZlYXR1cmVzLCBpdCBuZWVkcyB0byBk
aXNhYmxlIHRoZSBmZWF0dXJlcyB0aGF0IFNWUSBkb2VzCj4gbm90IHN1cHBvcnQgd2hlbiBmb3J3
YXJkaW5nIGJ1ZmZlcnMuIFRoaXMgaW5jbHVkZXMgcGFja2VkIHZxIGxheW91dCwKPiBpbmRpcmVj
dCBkZXNjcmlwdG9ycyBvciBldmVudCBpZHguCj4KPiBGdXR1cmUgY2hhbmdlcyBjYW4gYWRkIHN1
cHBvcnQgdG8gb2ZmZXIgbW9yZSBmZWF0dXJlcyB0byB0aGUgZ3Vlc3QsCj4gc2luY2UgdGhlIHVz
ZSBvZiBWaXJ0UXVldWUgZ2l2ZXMgdGhpcyBmb3IgZnJlZS4gVGhpcyBpcyBsZWZ0IG91dCBhdCB0
aGUKPiBtb21lbnQgZm9yIHNpbXBsaWNpdHkuCj4KPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDD
qXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiAtLS0KPiAgIGh3L3ZpcnRpby92aG9zdC1zaGFk
b3ctdmlydHF1ZXVlLmggfCAgMiArKwo+ICAgaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVl
dWUuYyB8IDM5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ICAgaHcvdmlydGlvL3Zo
b3N0LXZkcGEuYyAgICAgICAgICAgICB8IDE4ICsrKysrKysrKysrKysrCj4gICAzIGZpbGVzIGNo
YW5nZWQsIDU5IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhvc3Qt
c2hhZG93LXZpcnRxdWV1ZS5oIGIvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuaAo+
IGluZGV4IDFkNGMxNjBkMGEuLjg0NzQ3NjU1YWQgMTAwNjQ0Cj4gLS0tIGEvaHcvdmlydGlvL3Zo
b3N0LXNoYWRvdy12aXJ0cXVldWUuaAo+ICsrKyBiL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmly
dHF1ZXVlLmgKPiBAQCAtMzMsNiArMzMsOCBAQCB0eXBlZGVmIHN0cnVjdCBWaG9zdFNoYWRvd1Zp
cnRxdWV1ZSB7Cj4gICAgICAgRXZlbnROb3RpZmllciBzdnFfY2FsbDsKPiAgIH0gVmhvc3RTaGFk
b3dWaXJ0cXVldWU7Cj4gICAKPiArYm9vbCB2aG9zdF9zdnFfdmFsaWRfZmVhdHVyZXModWludDY0
X3QgKmZlYXR1cmVzKTsKPiArCj4gICB2b2lkIHZob3N0X3N2cV9zZXRfc3ZxX2tpY2tfZmQoVmhv
c3RTaGFkb3dWaXJ0cXVldWUgKnN2cSwgaW50IHN2cV9raWNrX2ZkKTsKPiAgIHZvaWQgdmhvc3Rf
c3ZxX3NldF9ndWVzdF9jYWxsX25vdGlmaWVyKFZob3N0U2hhZG93VmlydHF1ZXVlICpzdnEsIGlu
dCBjYWxsX2ZkKTsKPiAgIAo+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZp
cnRxdWV1ZS5jIGIvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuYwo+IGluZGV4IDU0
YzcwMWExOTYuLjM0MzU0YWVhMmMgMTAwNjQ0Cj4gLS0tIGEvaHcvdmlydGlvL3Zob3N0LXNoYWRv
dy12aXJ0cXVldWUuYwo+ICsrKyBiL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMK
PiBAQCAtMTQsNiArMTQsNDUgQEAKPiAgICNpbmNsdWRlICJxZW11L21haW4tbG9vcC5oIgo+ICAg
I2luY2x1ZGUgImxpbnV4LWhlYWRlcnMvbGludXgvdmhvc3QuaCIKPiAgIAo+ICsvKioKPiArICog
VmFsaWRhdGUgdGhlIHRyYW5zcG9ydCBkZXZpY2UgZmVhdHVyZXMgdGhhdCBib3RoIGd1ZXN0cyBj
YW4gdXNlIHdpdGggdGhlIFNWUQo+ICsgKiBhbmQgU1ZRcyBjYW4gdXNlIHdpdGggdGhlIGRldmlj
ZS4KPiArICoKPiArICogQGRldl9mZWF0dXJlcyAgVGhlIGZlYXR1cmVzLiBJZiBzdWNjZXNzLCB0
aGUgYWNrbm93bGVkZ2VkIGZlYXR1cmVzLiBJZgo+ICsgKiAgICAgICAgICAgICAgICBmYWlsdXJl
LCB0aGUgbWluaW1hbCBzZXQgZnJvbSBpdC4KPiArICoKPiArICogUmV0dXJucyB0cnVlIGlmIFNW
USBjYW4gZ28gd2l0aCBhIHN1YnNldCBvZiB0aGVzZSwgZmFsc2Ugb3RoZXJ3aXNlLgo+ICsgKi8K
PiArYm9vbCB2aG9zdF9zdnFfdmFsaWRfZmVhdHVyZXModWludDY0X3QgKmZlYXR1cmVzKQo+ICt7
Cj4gKyAgICBib29sIHIgPSB0cnVlOwo+ICsKPiArICAgIGZvciAodWludDY0X3QgYiA9IFZJUlRJ
T19UUkFOU1BPUlRfRl9TVEFSVDsgYiA8PSBWSVJUSU9fVFJBTlNQT1JUX0ZfRU5EOwo+ICsgICAg
ICAgICArK2IpIHsKPiArICAgICAgICBzd2l0Y2ggKGIpIHsKPiArICAgICAgICBjYXNlIFZJUlRJ
T19GX0FOWV9MQVlPVVQ6Cj4gKyAgICAgICAgICAgIGNvbnRpbnVlOwo+ICsKPiArICAgICAgICBj
YXNlIFZJUlRJT19GX0FDQ0VTU19QTEFURk9STToKPiArICAgICAgICAgICAgLyogU1ZRIHRydXN0
IGluIHRoZSBob3N0J3MgSU9NTVUgdG8gdHJhbnNsYXRlIGFkZHJlc3NlcyAqLwo+ICsgICAgICAg
IGNhc2UgVklSVElPX0ZfVkVSU0lPTl8xOgo+ICsgICAgICAgICAgICAvKiBTVlEgdHJ1c3QgdGhh
dCB0aGUgZ3Vlc3QgdnJpbmcgaXMgbGl0dGxlIGVuZGlhbiAqLwo+ICsgICAgICAgICAgICBpZiAo
ISgqZmVhdHVyZXMgJiBCSVRfVUxMKGIpKSkgewo+ICsgICAgICAgICAgICAgICAgc2V0X2JpdChi
LCBmZWF0dXJlcyk7Cj4gKyAgICAgICAgICAgICAgICByID0gZmFsc2U7Cj4gKyAgICAgICAgICAg
IH0KPiArICAgICAgICAgICAgY29udGludWU7CgoKSXQgbG9va3MgdG8gbWUgdGhlICpmZWF0dXJl
cyBpcyBvbmx5IHVzZWQgZm9yIGxvZ2dpbmcgZXJyb3JzLCBpZiB0aGlzIGlzIAp0aGUgdHJ1dGgu
IEkgc3VnZ2VzdCB0byBkbyBlcnJvcl9zZXRnIGluIHRoaXMgZnVuY3Rpb24gaW5zdGVhZCBvZiAK
bGV0dGluZyB0aGUgY2FsbGVyIHRvIHBhc3MgYSBwb2ludGVyLgoKCj4gKwo+ICsgICAgICAgIGRl
ZmF1bHQ6Cj4gKyAgICAgICAgICAgIGlmICgqZmVhdHVyZXMgJiBCSVRfVUxMKGIpKSB7Cj4gKyAg
ICAgICAgICAgICAgICBjbGVhcl9iaXQoYiwgZmVhdHVyZXMpOwo+ICsgICAgICAgICAgICB9CgoK
RG8gd2UgbmVlZCB0byBjaGVjayBpbmRpcmVjdCBhbmQgZXZlbnQgaWR4IGhlcmU/CgpUaGFua3MK
Cgo+ICsgICAgICAgIH0KPiArICAgIH0KPiArCj4gKyAgICByZXR1cm4gcjsKPiArfQo+ICsKPiAg
IC8qKiBGb3J3YXJkIGd1ZXN0IG5vdGlmaWNhdGlvbnMgKi8KPiAgIHN0YXRpYyB2b2lkIHZob3N0
X2hhbmRsZV9ndWVzdF9raWNrKEV2ZW50Tm90aWZpZXIgKm4pCj4gICB7Cj4gZGlmZiAtLWdpdCBh
L2h3L3ZpcnRpby92aG9zdC12ZHBhLmMgYi9ody92aXJ0aW8vdmhvc3QtdmRwYS5jCj4gaW5kZXgg
YzczMjE1NzUxZC4uZDYxNGM0MzVmMyAxMDA2NDQKPiAtLS0gYS9ody92aXJ0aW8vdmhvc3QtdmRw
YS5jCj4gKysrIGIvaHcvdmlydGlvL3Zob3N0LXZkcGEuYwo+IEBAIC0zNDgsMTEgKzM0OCwyOSBA
QCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfaW5pdF9zdnEoc3RydWN0IHZob3N0X2RldiAqaGRldiwg
c3RydWN0IHZob3N0X3ZkcGEgKnYsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
RXJyb3IgKiplcnJwKQo+ICAgewo+ICAgICAgIGdfYXV0b3B0cihHUHRyQXJyYXkpIHNoYWRvd192
cXMgPSBOVUxMOwo+ICsgICAgdWludDY0X3QgZGV2X2ZlYXR1cmVzLCBzdnFfZmVhdHVyZXM7Cj4g
KyAgICBpbnQgcjsKPiArICAgIGJvb2wgb2s7Cj4gICAKPiAgICAgICBpZiAoIXYtPnNoYWRvd192
cXNfZW5hYmxlZCkgewo+ICAgICAgICAgICByZXR1cm4gMDsKPiAgICAgICB9Cj4gICAKPiArICAg
IHIgPSBoZGV2LT52aG9zdF9vcHMtPnZob3N0X2dldF9mZWF0dXJlcyhoZGV2LCAmZGV2X2ZlYXR1
cmVzKTsKPiArICAgIGlmIChyICE9IDApIHsKPiArICAgICAgICBlcnJvcl9zZXRnX2Vycm5vKGVy
cnAsIC1yLCAiQ2FuJ3QgZ2V0IHZkcGEgZGV2aWNlIGZlYXR1cmVzIik7Cj4gKyAgICAgICAgcmV0
dXJuIHI7Cj4gKyAgICB9Cj4gKwo+ICsgICAgc3ZxX2ZlYXR1cmVzID0gZGV2X2ZlYXR1cmVzOwo+
ICsgICAgb2sgPSB2aG9zdF9zdnFfdmFsaWRfZmVhdHVyZXMoJnN2cV9mZWF0dXJlcyk7Cj4gKyAg
ICBpZiAodW5saWtlbHkoIW9rKSkgewo+ICsgICAgICAgIGVycm9yX3NldGcoZXJycCwKPiArICAg
ICAgICAgICAgIlNWUSBJbnZhbGlkIGRldmljZSBmZWF0dXJlIGZsYWdzLCBvZmZlcjogMHglIlBS
SXg2NCIsIG9rOiAweCUiUFJJeDY0LAo+ICsgICAgICAgICAgICBkZXZfZmVhdHVyZXMsIHN2cV9m
ZWF0dXJlcyk7Cj4gKyAgICAgICAgcmV0dXJuIC0xOwo+ICsgICAgfQo+ICsKPiAgICAgICBzaGFk
b3dfdnFzID0gZ19wdHJfYXJyYXlfbmV3X2Z1bGwoaGRldi0+bnZxcywgdmhvc3Rfc3ZxX2ZyZWUp
Owo+ICAgICAgIGZvciAodW5zaWduZWQgbiA9IDA7IG4gPCBoZGV2LT5udnFzOyArK24pIHsKPiAg
ICAgICAgICAgZ19hdXRvcHRyKFZob3N0U2hhZG93VmlydHF1ZXVlKSBzdnEgPSB2aG9zdF9zdnFf
bmV3KCk7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
