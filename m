Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A947C433EF
	for <virtualization@archiver.kernel.org>; Tue, 24 May 2022 02:46:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 41FCD82A7F;
	Tue, 24 May 2022 02:46:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BmKeUgSAnlGV; Tue, 24 May 2022 02:46:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9CAB082A53;
	Tue, 24 May 2022 02:46:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B234C0039;
	Tue, 24 May 2022 02:46:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C90CBC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 02:46:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A2D7582A5D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 02:46:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kaqAymRWaUW8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 02:46:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 17E4B82A53
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 02:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653360374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BYJFy+Y4pkEYziHYoAeekoD+3Bc8Qu3A80VyOZfUR80=;
 b=aTVL06TeGTbwRnkWpt/s3Xfh6fNe5Jiiisi3yF2OydlK1hzagVVgW7t8QfJyIQpVT62L+B
 BVWE72ObN5KoufZsC0oRAj08RX2LNSnFkwGIg7073mhOwO8pbPPBpcQmvytl7kZe6RPa2S
 B1qL03s+uPiOjSp4bbSGqpQGlQzIudA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-310-OYei9djHPJ6KiS71mtOtfQ-1; Mon, 23 May 2022 22:46:13 -0400
X-MC-Unique: OYei9djHPJ6KiS71mtOtfQ-1
Received: by mail-pl1-f200.google.com with SMTP id
 s10-20020a170902a50a00b00162359521c9so1419838plq.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 19:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=BYJFy+Y4pkEYziHYoAeekoD+3Bc8Qu3A80VyOZfUR80=;
 b=D1RbMWmzfh7Y//zUx449DINSvMIoazEBxEhzPBCunWBcHa0RKk1cL3ujveVZiLHP7P
 D4G93duDRm0YMVYjz1hqaS/ELlv6r5LReBG1L9nwzZbTc+MNpXpP8MC76feDsu+kmLfx
 45J3fiC98S5ERovnR8X2+ZHHkhiIWqpozkpV20PvhE7b5ck7vouhnTcBqoBXSZHPs8p0
 rl8wlNd7e35Mp5HSzN67SSGjhGZlQB/i74y3PQiCr5GqYNdyck4ZyZlsY6ctC1Vgi/bv
 uXa86YzGAYBptUP0wkhf/Yrg10VgNUqIhOWaQVyH6WMlh/nENk4k3owjgMEPXo5dLTKW
 JRug==
X-Gm-Message-State: AOAM530T5AA3Z33foRpREsbsJ0rhxuQBsx++MKHd4D8/ouQfhjOdwXI7
 ZFrSVSKaDORTmyQT//bG6yUR48pIE7o/KVKFsY5QnNVx79mvolWVJSxuy1VaIzG0X4XlBKKbkws
 //OqP15l21F6sG5kKGxE+3S+1cWlzk6F4gJW77uSvAA==
X-Received: by 2002:a17:903:246:b0:153:87f0:a93e with SMTP id
 j6-20020a170903024600b0015387f0a93emr25486847plh.171.1653360372501; 
 Mon, 23 May 2022 19:46:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuBiLXA4Wufa9VWmoox3iYH6eOe66WEUcrf0/HzhdQBGhqcNjN4ti96gSnG5cETtgP3NLFXw==
X-Received: by 2002:a17:903:246:b0:153:87f0:a93e with SMTP id
 j6-20020a170903024600b0015387f0a93emr25486789plh.171.1653360372044; 
 Mon, 23 May 2022 19:46:12 -0700 (PDT)
Received: from [10.72.12.128] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a17090aaa8900b001cd4989fec6sm417537pjq.18.2022.05.23.19.45.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 May 2022 19:46:08 -0700 (PDT)
Message-ID: <333e957d-af84-24fb-6636-843a9dcfc1e2@redhat.com>
Date: Tue, 24 May 2022 10:45:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 1/4] vdpa: Add stop operation
To: Si-Wei Liu <si-wei.liu@oracle.com>,
 Eugenio Perez Martin <eperezma@redhat.com>
References: <20220520172325.980884-1-eperezma@redhat.com>
 <20220520172325.980884-2-eperezma@redhat.com>
 <79089dc4-07c4-369b-826c-1c6e12edcaff@oracle.com>
 <CAJaqyWd3BqZfmJv+eBYOGRwNz3OhNKjvHPiFOafSjzAnRMA_tQ@mail.gmail.com>
 <4de97962-cf7e-c334-5874-ba739270c705@oracle.com>
 <9f68802c-2692-7321-f916-670ee0abfc40@oracle.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <9f68802c-2692-7321-f916-670ee0abfc40@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: tanuj.kamde@amd.com, kvm list <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, pabloc@xilinx.com,
 Eli Cohen <elic@nvidia.com>, Zhang Min <zhang.min9@zte.com.cn>,
 Cindy Lu <lulu@redhat.com>, Martin Petrus Hubertus Habets <martinh@xilinx.com>,
 Xie Yongji <xieyongji@bytedance.com>, dinang@xilinx.com,
 habetsm.xilinx@gmail.com, Longpeng <longpeng2@huawei.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, Laurent Vivier <lvivier@redhat.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ecree.xilinx@gmail.com,
 Harpreet Singh Anand <hanand@xilinx.com>, martinpo@xilinx.com, "Dawar,
 Gautam" <gautam.dawar@amd.com>, Zhu Lingshan <lingshan.zhu@intel.com>
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

CuWcqCAyMDIyLzUvMjQgMDg6MDEsIFNpLVdlaSBMaXUg5YaZ6YGTOgo+Cj4KPiBPbiA1LzIzLzIw
MjIgNDo1NCBQTSwgU2ktV2VpIExpdSB3cm90ZToKPj4KPj4KPj4gT24gNS8yMy8yMDIyIDEyOjIw
IFBNLCBFdWdlbmlvIFBlcmV6IE1hcnRpbiB3cm90ZToKPj4+IE9uIFNhdCwgTWF5IDIxLCAyMDIy
IGF0IDEyOjEzIFBNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4gCj4+PiB3cm90
ZToKPj4+Pgo+Pj4+Cj4+Pj4gT24gNS8yMC8yMDIyIDEwOjIzIEFNLCBFdWdlbmlvIFDDqXJleiB3
cm90ZToKPj4+Pj4gVGhpcyBvcGVyYXRpb24gaXMgb3B0aW9uYWw6IEl0IGl0J3Mgbm90IGltcGxl
bWVudGVkLCBiYWNrZW5kIAo+Pj4+PiBmZWF0dXJlIGJpdAo+Pj4+PiB3aWxsIG5vdCBiZSBleHBv
c2VkLgo+Pj4+Pgo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFA
cmVkaGF0LmNvbT4KPj4+Pj4gLS0tCj4+Pj4+IMKgwqAgaW5jbHVkZS9saW51eC92ZHBhLmggfCA2
ICsrKysrKwo+Pj4+PiDCoMKgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKPj4+Pj4K
Pj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmRwYS5oIGIvaW5jbHVkZS9saW51eC92
ZHBhLmgKPj4+Pj4gaW5kZXggMTVhZjgwMmQ0MWM0Li5kZGZlYmM0ZTFlMDEgMTAwNjQ0Cj4+Pj4+
IC0tLSBhL2luY2x1ZGUvbGludXgvdmRwYS5oCj4+Pj4+ICsrKyBiL2luY2x1ZGUvbGludXgvdmRw
YS5oCj4+Pj4+IEBAIC0yMTUsNiArMjE1LDExIEBAIHN0cnVjdCB2ZHBhX21hcF9maWxlIHsKPj4+
Pj4gwqDCoMKgICogQHJlc2V0OsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUmVz
ZXQgZGV2aWNlCj4+Pj4+IMKgwqDCoCAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgQHZkZXY6IHZkcGEgZGV2aWNlCj4+Pj4+IMKgwqDCoCAqwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUmV0dXJucyBpbnRl
Z2VyOiBzdWNjZXNzICgwKSBvciAKPj4+Pj4gZXJyb3IgKDwgMCkKPj4+Pj4gKyAqIEBzdG9wOsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFN0b3Agb3IgcmVzdW1lIHRoZSBk
ZXZpY2UgKG9wdGlvbmFsLCAKPj4+Pj4gYnV0IGl0IG11c3QKPj4+Pj4gKyAqwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBiZSBpbXBsZW1lbnRlZCBp
ZiByZXF1aXJlIGRldmljZSBzdG9wKQo+Pj4+PiArICrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEB2ZGV2OiB2ZHBhIGRldmljZQo+Pj4+PiArICrC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEBzdG9w
OiBzdG9wICh0cnVlKSwgbm90IHN0b3AgKGZhbHNlKQo+Pj4+PiArICrCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJldHVybnMgaW50ZWdlcjogc3Vj
Y2VzcyAoMCkgb3IgCj4+Pj4+IGVycm9yICg8IDApCj4+Pj4gSXMgdGhpcyB1QVBJIG1lYW50IHRv
IGFkZHJlc3MgYWxsIHVzZSBjYXNlcyBkZXNjcmliZWQgaW4gdGhlIGZ1bGwgCj4+Pj4gYmxvd24K
Pj4+PiBfRl9TVE9QIHZpcnRpbyBzcGVjIHByb3Bvc2FsLCBzdWNoIGFzOgo+Pj4+Cj4+Pj4gLS0t
LS0tLS0tLS0tLS0lPC0tLS0tLS0tLS0tLS0tCj4+Pj4KPj4+PiAuLi4uLi4gdGhlIGRldmljZSBN
VVNUIGZpbmlzaCBhbnkgaW4gZmxpZ2h0Cj4+Pj4gb3BlcmF0aW9ucyBhZnRlciB0aGUgZHJpdmVy
IHdyaXRlcyBTVE9QLsKgIERlcGVuZGluZyBvbiB0aGUgZGV2aWNlLCBpdAo+Pj4+IGNhbiBkbyBp
dAo+Pj4+IGluIG1hbnkgd2F5cyBhcyBsb25nIGFzIHRoZSBkcml2ZXIgY2FuIHJlY292ZXIgaXRz
IG5vcm1hbCBvcGVyYXRpb24gCj4+Pj4gaWYgaXQKPj4+PiByZXN1bWVzIHRoZSBkZXZpY2Ugd2l0
aG91dCB0aGUgbmVlZCBvZiByZXNldHRpbmcgaXQ6Cj4+Pj4KPj4+PiAtIERyYWluIGFuZCB3YWl0
IGZvciB0aGUgY29tcGxldGlvbiBvZiBhbGwgcGVuZGluZyByZXF1ZXN0cyB1bnRpbCBhCj4+Pj4g
wqDCoMKgIGNvbnZlbmllbnQgYXZhaWwgZGVzY3JpcHRvci4gSWdub3JlIGFueSBvdGhlciBwb3N0
ZXJpb3IgCj4+Pj4gZGVzY3JpcHRvci4KPj4+PiAtIFJldHVybiBhIGRldmljZS1zcGVjaWZpYyBm
YWlsdXJlIGZvciB0aGVzZSBkZXNjcmlwdG9ycywgc28gdGhlIAo+Pj4+IGRyaXZlcgo+Pj4+IMKg
wqDCoCBjYW4gY2hvb3NlIHRvIHJldHJ5IG9yIHRvIGNhbmNlbCB0aGVtLgo+Pj4+IC0gTWFyayB0
aGVtIGFzIGRvbmUgZXZlbiBpZiB0aGV5IGFyZSBub3QsIGlmIHRoZSBraW5kIG9mIGRldmljZSBj
YW4KPj4+PiDCoMKgwqAgYXNzdW1lIHRvIGxvc2UgdGhlbS4KPj4+PiAtLS0tLS0tLS0tLS0tLSU8
LS0tLS0tLS0tLS0tLS0KPj4+Pgo+Pj4gUmlnaHQsIHRoaXMgaXMgdG90YWxseSB1bmRlcnNwZWNp
ZmllZCBpbiB0aGlzIHNlcmllcy4KPj4+Cj4+PiBJJ2xsIGV4cGFuZCBvbiBpdCBpbiB0aGUgbmV4
dCB2ZXJzaW9uLCBidXQgdGhhdCB0ZXh0IHByb3Bvc2VkIHRvCj4+PiB2aXJ0aW8tY29tbWVudCB3
YXMgY29tcGxpY2F0ZWQgYW5kIG1pc2xlYWRpbmcuIEkgZmluZCBiZXR0ZXIgdG8gZ2V0Cj4+PiB0
aGUgcHJldmlvdXMgdmVyc2lvbiBkZXNjcmlwdGlvbi4gV291bGQgdGhlIG5leHQgZGVzY3JpcHRp
b24gd29yaz8KPj4+Cj4+PiBgYGAKPj4+IEFmdGVyIHRoZSByZXR1cm4gb2YgaW9jdGwsIHRoZSBk
ZXZpY2UgTVVTVCBmaW5pc2ggYW55IHBlbmRpbmcgCj4+PiBvcGVyYXRpb25zIGxpa2UKPj4+IGlu
IGZsaWdodCByZXF1ZXN0cy4gSXQgbXVzdCBhbHNvIHByZXNlcnZlIGFsbCB0aGUgbmVjZXNzYXJ5
IHN0YXRlICh0aGUKPj4+IHZpcnRxdWV1ZSB2cmluZyBiYXNlIHBsdXMgdGhlIHBvc3NpYmxlIGRl
dmljZSBzcGVjaWZpYyBzdGF0ZXMpCj4+IEhtbW0sICJwb3NzaWJsZSBkZXZpY2Ugc3BlY2lmaWMg
c3RhdGVzIiBpcyBhIGJpdCB2YWd1ZS4gRG9lcyBpdCAKPj4gcmVxdWlyZSB0aGUgZGV2aWNlIHRv
IHNhdmUgYW55IGRldmljZSBpbnRlcm5hbCBzdGF0ZSB0aGF0IGlzIG5vdCAKPj4gZGVmaW5lZCBp
biB0aGUgdmlydGlvIHNwZWMgLSBzdWNoIGFzIGFueSBmYWlsZWQgaW4tZmxpZ2h0IHJlcXVlc3Rz
IHRvIAo+PiByZXN1Ym1pdCB1cG9uIHJlc3VtZT8gT3IgeW91IHdvdWxkIGxlYW4gb24gU1ZRIHRv
IGludGVyY2VwdCBpdCBpbiAKPj4gZGVwdGggYW5kIHNhdmUgaXQgd2l0aCBzb21lIG90aGVyIG1l
YW5zPyBJIHRoaW5rIG5ldHdvcmsgZGV2aWNlIGFsc28gCj4+IGhhcyBpbnRlcm5hbCBzdGF0ZSBz
dWNoIGFzIGZsb3cgc3RlZXJpbmcgc3RhdGUgdGhhdCBuZWVkcyBib29ra2VlcGluZyAKPj4gYXMg
d2VsbC4KPiBOb3RlZCB0aGF0IEkgdW5kZXJzdGFuZCB5b3UgbWF5IGludHJvZHVjZSBhZGRpdGlv
bmFsIGZlYXR1cmUgY2FsbCAKPiBzaW1pbGFyIHRvIFZIT1NUX1VTRVJfR0VUX0lORkxJR0hUX0ZE
IGZvciAoZmFpbGVkKSBpbi1mbGlnaHQgcmVxdWVzdCwgCj4gYnV0IHNpbmNlIHRoYXQncyBpcyBh
IGdldCBpbnRlcmZhY2UsIEkgYXNzdW1lIHRoZSBhY3R1YWwgc3RhdGUgCj4gcHJlc2VydmluZyBz
aG91bGQgc3RpbGwgdGFrZSBwbGFjZSBpbiB0aGlzIFNUT1AgY2FsbC4KPgoKWWVzLCBJIHRoaW5r
IHNvLgoKCj4gLVNpd2VpCj4KPj4KPj4gQSBmb2xsb3ctdXAgcXVlc3Rpb24gaXMgd2hhdCBpcyB0
aGUgdXNlIG9mIHRoZSBgc3RvcGAgYXJndW1lbnQgb2YgCj4+IGZhbHNlLCBkb2VzIGl0IHJlcXVp
cmUgdGhlIGRldmljZSB0byBzdXBwb3J0IHJlc3VtZT8gCgoKWWVzLCB0aGlzIGlzIHJlcXVpcmVk
IGJ5IHRoZSBoeXBlcnZpc29yIGUuZyBmb3IgUWVtdSBpdCBzdXBwb3J0cyB2bSAKc3RvcC9yZXN1
bWUuCgoKPj4gSSBzZWVtIHRvIHJlY2FsbCB0aGlzIGlzIHNvbWV0aGluZyB0byBhYmFuZG9uIGlu
IGZhdm9yIG9mIGRldmljZSAKPj4gcmVzZXQgcGx1cyBzZXR0aW5nIHF1ZXVlIGJhc2UvYWRkciBh
ZnRlci4gT3IgaXQncyBqdXN0IGEgb3B0aW9uYWwgCj4+IGZlYXR1cmUgdGhhdCBtYXkgYmUgZGV2
aWNlIHNwZWNpZmljIChpZiBvbmUgY2FuIGRvIHNvIGluIHNpbXBsZSB3YXkpLgoKClJlc3QgaXMg
bW9yZSBsaWtlIGEgd29ya2Fyb25kIGNvbnNpZGVyIHdlIGRvbid0IGhhdmUgYSBzdG9wIEFQSS4g
CkNvbnNpZGVyIHdlIGRvbid0IGFkZCBzdG9wIGF0IHRoZSBiZWdpbm5pbmcsIGl0IGNhbiBvbmx5
IGJlIGFuIG9wdGlvbmFsIApmZWF0dXJlLgoKVGhhbmtzCgoKPj4KPj4gLVNpd2VpCj4+Cj4+PiDC
oCB0aGF0IGlzIHJlcXVpcmVkCj4+PiBmb3IgcmVzdG9yaW5nIGluIHRoZSBmdXR1cmUuCj4+Pgo+
Pj4gSW4gdGhlIGZ1dHVyZSwgd2Ugd2lsbCBwcm92aWRlIGZlYXR1cmVzIHNpbWlsYXIgdG8gCj4+
PiBWSE9TVF9VU0VSX0dFVF9JTkZMSUdIVF9GRAo+Pj4gc28gdGhlIGRldmljZSBjYW4gc2F2ZSBw
ZW5kaW5nIG9wZXJhdGlvbnMuCj4+PiBgYGAKPj4+Cj4+PiBUaGFua3MgZm9yIHBvaW50aW5nIGl0
IG91dCEKPj4+Cj4+Pgo+Pj4KPj4+Cj4+Pgo+Pj4+IEUuZy4gZG8gSSBhc3N1bWUgY29ycmVjdGx5
IGFsbCBpbiBmbGlnaHQgcmVxdWVzdHMgYXJlIGZsdXNoZWQgYWZ0ZXIKPj4+PiByZXR1cm4gZnJv
bSB0aGlzIHVBUEkgY2FsbD8gT3Igc29tZSBvZiBwZW5kaW5nIHJlcXVlc3RzIG1heSBiZSBzdWJq
ZWN0Cj4+Pj4gdG8gbG9zcyBvciBmYWlsdXJlPyBIb3cgZG9lcyB0aGUgY2FsbGVyL3VzZXIgc3Bl
Y2lmeSB0aGVzZSB2YXJpb3VzCj4+Pj4gb3B0aW9ucyAoaWYgdGhlcmUgYXJlKSBmb3IgZGV2aWNl
IHN0b3A/Cj4+Pj4KPj4+PiBCVFcsIGl0IHdvdWxkIGJlIG5pY2UgdG8gYWRkIHRoZSBjb3JyZXNw
b25kaW5nIHN1cHBvcnQgdG8gdmRwYV9zaW1fYmxrCj4+Pj4gYXMgd2VsbCB0byBkZW1vIHRoZSBz
dG9wIGhhbmRsaW5nLiBUbyBqdXN0IHNob3cgaXQgb24gdmRwYS1zaW0tbmV0IAo+Pj4+IElNSE8K
Pj4+PiBpcyBwZXJoYXBzIG5vdCBzbyBjb252aW5jaW5nLgo+Pj4+Cj4+Pj4gLVNpd2VpCj4+Pj4K
Pj4+Pj4gwqDCoMKgICogQGdldF9jb25maWdfc2l6ZTogR2V0IHRoZSBzaXplIG9mIHRoZSBjb25m
aWd1cmF0aW9uIHNwYWNlIAo+Pj4+PiBpbmNsdWRlcwo+Pj4+PiDCoMKgwqAgKsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZpZWxkcyB0aGF0IGFyZSBj
b25kaXRpb25hbCBvbiAKPj4+Pj4gZmVhdHVyZSBiaXRzLgo+Pj4+PiDCoMKgwqAgKsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEB2ZGV2OiB2ZHBhIGRl
dmljZQo+Pj4+PiBAQCAtMzE2LDYgKzMyMSw3IEBAIHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgewo+
Pj4+PiDCoMKgwqDCoMKgwqAgdTggKCpnZXRfc3RhdHVzKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZk
ZXYpOwo+Pj4+PiDCoMKgwqDCoMKgwqAgdm9pZCAoKnNldF9zdGF0dXMpKHN0cnVjdCB2ZHBhX2Rl
dmljZSAqdmRldiwgdTggc3RhdHVzKTsKPj4+Pj4gwqDCoMKgwqDCoMKgIGludCAoKnJlc2V0KShz
dHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpOwo+Pj4+PiArwqDCoMKgwqAgaW50ICgqc3RvcCkoc3Ry
dWN0IHZkcGFfZGV2aWNlICp2ZGV2LCBib29sIHN0b3ApOwo+Pj4+PiDCoMKgwqDCoMKgwqAgc2l6
ZV90ICgqZ2V0X2NvbmZpZ19zaXplKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpOwo+Pj4+PiDC
oMKgwqDCoMKgwqAgdm9pZCAoKmdldF9jb25maWcpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwg
dW5zaWduZWQgaW50IAo+Pj4+PiBvZmZzZXQsCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZvaWQgKmJ1ZiwgdW5zaWduZWQgaW50IGxlbik7
Cj4+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
