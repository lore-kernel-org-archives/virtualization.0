Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F24C64ED8
	for <virtualization@archiver.kernel.org>; Mon, 27 Feb 2023 07:27:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D40C040483;
	Mon, 27 Feb 2023 07:27:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D40C040483
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UwhyYkNc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TK6O4KI7jbuQ; Mon, 27 Feb 2023 07:27:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4882D4017B;
	Mon, 27 Feb 2023 07:27:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4882D4017B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 090C6C0032;
	Mon, 27 Feb 2023 07:27:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9D7DC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 07:27:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ABAD360B48
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 07:27:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ABAD360B48
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UwhyYkNc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4gKrsZtRo_fT
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 07:27:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB94260B43
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB94260B43
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 07:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677482852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d7Kw5/DWzTjaMGafWr+GDqIh5bOIBWiaaDRv7vmWjG8=;
 b=UwhyYkNcStR0MnwOtQ79RgQ6jVAZe3Baq5vROusgPSybWLUspsdyW1AfAU3EAOo1TCDIrt
 5nW31xjUvxRBDiknAKz9r0Lf4DRHrGi4WA+s90e2ba1O5jNb3y+pgt9W6CBKsMKWnBw/fR
 0vsaHvjq3ObVrTtto7K9BCy18Hy8o2w=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-399-yKLniujXMFyDPlstT7CMVQ-1; Mon, 27 Feb 2023 02:27:30 -0500
X-MC-Unique: yKLniujXMFyDPlstT7CMVQ-1
Received: by mail-pf1-f197.google.com with SMTP id
 p5-20020a056a0026c500b005cbeecd5c0dso2965040pfw.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Feb 2023 23:27:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d7Kw5/DWzTjaMGafWr+GDqIh5bOIBWiaaDRv7vmWjG8=;
 b=Mgamjer4z8DPYGqgROlSG2+mFvh8D/mvgo9600LxH2n0SijZS8P80M42vFtmxJL5yq
 Pi1WzKITqNiuFEs1hpAqKETZWVvT6DgqwrPSOlPvG+r5MAqN6YIPIFeFZRdqld/wr323
 uZvo1iSGNQcVQ+sV0HC1YiiYEH+ypd5ZvsDg7wGg89sh05WIQGscGmLPwMpTs7rf3xDD
 MTv+jIlw6AspCf3ttBrPawxsl3RkTTMyj4m19D2rDBWPEJQ77qbSPBNw6kmiD65b4L3r
 Xxmb7olQ6zfoiKkYlCKakd3kpJ6jP8431oJFKtt3thq0fzX5oDCpxo2Dr36/8Mp5ovXX
 c8DA==
X-Gm-Message-State: AO0yUKV7Xr1v0edgDOqiZHnIWPTjvfy83DOqGAyboBkL1cqMQIJlVvbs
 uZ1NK0fjFtQX2a6Mz+Fg+HtD/D+pDJkDrmCXvgmRbQMd5W0BnptQlx7Lk+QdNcd/mZ2yE2uy/Jb
 sn4dmAAs7lAddi6bKqRE+QS7n6cIlrf/JiTb8sdVkBA==
X-Received: by 2002:a05:6a20:7f8b:b0:c7:5e7a:d536 with SMTP id
 d11-20020a056a207f8b00b000c75e7ad536mr7824696pzj.17.1677482849228; 
 Sun, 26 Feb 2023 23:27:29 -0800 (PST)
X-Google-Smtp-Source: AK7set+4H/fFIu6ScwPUUSfUghZ+LmmB3oEqyCzuO1U4PHxsDGGTSnJBaFExkNqKGt5pmDxyj/I3/w==
X-Received: by 2002:a05:6a20:7f8b:b0:c7:5e7a:d536 with SMTP id
 d11-20020a056a207f8b00b000c75e7ad536mr7824668pzj.17.1677482848915; 
 Sun, 26 Feb 2023 23:27:28 -0800 (PST)
Received: from [10.72.13.83] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 y9-20020a62b509000000b005a851e6d2b5sm3523206pfe.161.2023.02.26.23.27.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Feb 2023 23:27:28 -0800 (PST)
Message-ID: <da8a880b-8b5b-8a41-a0ef-13adcc742821@redhat.com>
Date: Mon, 27 Feb 2023 15:27:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v4 07/15] vdpa: add vhost_vdpa_suspend
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20230224155438.112797-1-eperezma@redhat.com>
 <20230224155438.112797-8-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230224155438.112797-8-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gautam Dawar <gdawar@xilinx.com>, virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Lei Yang <leiyang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 longpeng2@huawei.com, Shannon Nelson <snelson@pensando.io>,
 Liuxiangdong <liuxiangdong5@huawei.com>
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

CuWcqCAyMDIzLzIvMjQgMjM6NTQsIEV1Z2VuaW8gUMOpcmV6IOWGmemBkzoKPiBUaGUgZnVuY3Rp
b24gdmhvc3QuYzp2aG9zdF9kZXZfc3RvcCBmZXRjaGVzIHRoZSB2cmluZyBiYXNlIHNvIHRoZSB2
cQo+IHN0YXRlIGNhbiBiZSBtaWdyYXRlZCB0byBvdGhlciBkZXZpY2VzLiAgSG93ZXZlciwgdGhp
cyBpcyB1bnJlbGlhYmxlIGluCj4gdmRwYSwgc2luY2Ugd2UgZGlkbid0IHNpZ25hbCB0aGUgZGV2
aWNlIHRvIHN1c3BlbmQgdGhlIHF1ZXVlcywgbWFraW5nCj4gdGhlIHZhbHVlIGZldGNoZWQgdXNl
bGVzcy4KPgo+IFN1c3BlbmQgdGhlIGRldmljZSBpZiBwb3NzaWJsZSBiZWZvcmUgZmV0Y2hpbmcg
Zmlyc3QgYW5kIHN1YnNlcXVlbnQKPiB2cmluZyBiYXNlcy4KPgo+IE1vcmVvdmVyLCB2ZHBhIHRv
dGFsbHkgcmVzZXQgYW5kIHdpcGVzIHRoZSBkZXZpY2UgYXQgdGhlIGxhc3QgZGV2aWNlCj4gYmVm
b3JlIGZldGNoIGl0cyB2cmluZ3MgYmFzZSwgbWFraW5nIHRoYXQgb3BlcmF0aW9uIHVzZWxlc3Mg
aW4gdGhlIGxhc3QKPiBkZXZpY2UuIFRoaXMgd2lsbCBiZSBmaXhlZCBpbiBsYXRlciBwYXRjaGVz
IG9mIHRoaXMgc2VyaWVzLgo+Cj4gU2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJl
em1hQHJlZGhhdC5jb20+CgoKSSBzdWdnZXN0IHRvIHNxdWFzaCB0aGlzIGludG8gcGF0Y2ggNSAo
b3IgZXZlbiBzcXVhc2ggcGF0Y2ggNiBpbnRvIHRoaXMpIApzaW5jZSBpdCdzIG5vdCBnb29kIHRv
IGludHJvZHVjZSBhIGJ1ZyBpbiA1IGFuZCBmaXggaW4gNy4KCgo+IC0tLQo+IHY0Ogo+ICogTG9v
ayBmb3IgX0ZfU1VTUEVORCBhdCB2aG9zdF9kZXYtPmJhY2tlbmRfY2FwLCBub3QgYmFja2VuZF9m
ZWF0dXJlcwo+ICogRmFsbCBiYWNrIG9uIHJlc2V0ICYgZmV0Y2ggdXNlZCBpZHggZnJvbSBndWVz
dCdzIG1lbW9yeQoKCkEgaGludCB0byBzcXVhc2ggcGF0Y2ggNi4KClRoYW5rcwoKCj4gLS0tCj4g
ICBody92aXJ0aW8vdmhvc3QtdmRwYS5jIHwgMjUgKysrKysrKysrKysrKysrKysrKysrKysrKwo+
ICAgaHcvdmlydGlvL3RyYWNlLWV2ZW50cyB8ICAxICsKPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjYg
aW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMgYi9o
dy92aXJ0aW8vdmhvc3QtdmRwYS5jCj4gaW5kZXggMjI4Njc3ODk1YS4uZjU0Mjk2MGE2NCAxMDA2
NDQKPiAtLS0gYS9ody92aXJ0aW8vdmhvc3QtdmRwYS5jCj4gKysrIGIvaHcvdmlydGlvL3Zob3N0
LXZkcGEuYwo+IEBAIC03MTIsNiArNzEyLDcgQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX3Jlc2V0
X2RldmljZShzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYpCj4gICAKPiAgICAgICByZXQgPSB2aG9zdF92
ZHBhX2NhbGwoZGV2LCBWSE9TVF9WRFBBX1NFVF9TVEFUVVMsICZzdGF0dXMpOwo+ICAgICAgIHRy
YWNlX3Zob3N0X3ZkcGFfcmVzZXRfZGV2aWNlKGRldiwgc3RhdHVzKTsKPiArICAgIHYtPnN1c3Bl
bmRlZCA9IGZhbHNlOwo+ICAgICAgIHJldHVybiByZXQ7Cj4gICB9Cj4gICAKPiBAQCAtMTEwOSw2
ICsxMTEwLDI5IEBAIHN0YXRpYyB2b2lkIHZob3N0X3ZkcGFfc3Zxc19zdG9wKHN0cnVjdCB2aG9z
dF9kZXYgKmRldikKPiAgICAgICB9Cj4gICB9Cj4gICAKPiArc3RhdGljIHZvaWQgdmhvc3RfdmRw
YV9zdXNwZW5kKHN0cnVjdCB2aG9zdF9kZXYgKmRldikKPiArewo+ICsgICAgc3RydWN0IHZob3N0
X3ZkcGEgKnYgPSBkZXYtPm9wYXF1ZTsKPiArICAgIGludCByOwo+ICsKPiArICAgIGlmICghdmhv
c3RfdmRwYV9maXJzdF9kZXYoZGV2KSkgewo+ICsgICAgICAgIHJldHVybjsKPiArICAgIH0KPiAr
Cj4gKyAgICBpZiAoIShkZXYtPmJhY2tlbmRfY2FwICYgQklUX1VMTChWSE9TVF9CQUNLRU5EX0Zf
U1VTUEVORCkpKSB7Cj4gKyAgICAgICAgdHJhY2Vfdmhvc3RfdmRwYV9zdXNwZW5kKGRldik7Cj4g
KyAgICAgICAgciA9IGlvY3RsKHYtPmRldmljZV9mZCwgVkhPU1RfVkRQQV9TVVNQRU5EKTsKPiAr
ICAgICAgICBpZiAodW5saWtlbHkocikpIHsKPiArICAgICAgICAgICAgZXJyb3JfcmVwb3J0KCJD
YW5ub3Qgc3VzcGVuZDogJXMoJWQpIiwgZ19zdHJlcnJvcihlcnJubyksIGVycm5vKTsKPiArICAg
ICAgICB9IGVsc2Ugewo+ICsgICAgICAgICAgICB2LT5zdXNwZW5kZWQgPSB0cnVlOwo+ICsgICAg
ICAgICAgICByZXR1cm47Cj4gKyAgICAgICAgfQo+ICsgICAgfQo+ICsKPiArICAgIHZob3N0X3Zk
cGFfcmVzZXRfZGV2aWNlKGRldik7Cj4gK30KPiArCj4gICBzdGF0aWMgaW50IHZob3N0X3ZkcGFf
ZGV2X3N0YXJ0KHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgYm9vbCBzdGFydGVkKQo+ICAgewo+ICAg
ICAgIHN0cnVjdCB2aG9zdF92ZHBhICp2ID0gZGV2LT5vcGFxdWU7Cj4gQEAgLTExMjMsNiArMTE0
Nyw3IEBAIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9kZXZfc3RhcnQoc3RydWN0IHZob3N0X2RldiAq
ZGV2LCBib29sIHN0YXJ0ZWQpCj4gICAgICAgICAgIH0KPiAgICAgICAgICAgdmhvc3RfdmRwYV9z
ZXRfdnJpbmdfcmVhZHkoZGV2KTsKPiAgICAgICB9IGVsc2Ugewo+ICsgICAgICAgIHZob3N0X3Zk
cGFfc3VzcGVuZChkZXYpOwo+ICAgICAgICAgICB2aG9zdF92ZHBhX3N2cXNfc3RvcChkZXYpOwo+
ICAgICAgICAgICB2aG9zdF92ZHBhX2hvc3Rfbm90aWZpZXJzX3VuaW5pdChkZXYsIGRldi0+bnZx
cyk7Cj4gICAgICAgfQo+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdHJhY2UtZXZlbnRzIGIvaHcv
dmlydGlvL3RyYWNlLWV2ZW50cwo+IGluZGV4IGE4N2M1ZjM5YTIuLjhmOGQwNWNmOWIgMTAwNjQ0
Cj4gLS0tIGEvaHcvdmlydGlvL3RyYWNlLWV2ZW50cwo+ICsrKyBiL2h3L3ZpcnRpby90cmFjZS1l
dmVudHMKPiBAQCAtNTAsNiArNTAsNyBAQCB2aG9zdF92ZHBhX3NldF92cmluZ19yZWFkeSh2b2lk
ICpkZXYpICJkZXY6ICVwIgo+ICAgdmhvc3RfdmRwYV9kdW1wX2NvbmZpZyh2b2lkICpkZXYsIGNv
bnN0IGNoYXIgKmxpbmUpICJkZXY6ICVwICVzIgo+ICAgdmhvc3RfdmRwYV9zZXRfY29uZmlnKHZv
aWQgKmRldiwgdWludDMyX3Qgb2Zmc2V0LCB1aW50MzJfdCBzaXplLCB1aW50MzJfdCBmbGFncykg
ImRldjogJXAgb2Zmc2V0OiAlIlBSSXUzMiIgc2l6ZTogJSJQUkl1MzIiIGZsYWdzOiAweCUiUFJJ
eDMyCj4gICB2aG9zdF92ZHBhX2dldF9jb25maWcodm9pZCAqZGV2LCB2b2lkICpjb25maWcsIHVp
bnQzMl90IGNvbmZpZ19sZW4pICJkZXY6ICVwIGNvbmZpZzogJXAgY29uZmlnX2xlbjogJSJQUkl1
MzIKPiArdmhvc3RfdmRwYV9zdXNwZW5kKHZvaWQgKmRldikgImRldjogJXAiCj4gICB2aG9zdF92
ZHBhX2Rldl9zdGFydCh2b2lkICpkZXYsIGJvb2wgc3RhcnRlZCkgImRldjogJXAgc3RhcnRlZDog
JWQiCj4gICB2aG9zdF92ZHBhX3NldF9sb2dfYmFzZSh2b2lkICpkZXYsIHVpbnQ2NF90IGJhc2Us
IHVuc2lnbmVkIGxvbmcgbG9uZyBzaXplLCBpbnQgcmVmY250LCBpbnQgZmQsIHZvaWQgKmxvZykg
ImRldjogJXAgYmFzZTogMHglIlBSSXg2NCIgc2l6ZTogJWxsdSByZWZjbnQ6ICVkIGZkOiAlZCBs
b2c6ICVwIgo+ICAgdmhvc3RfdmRwYV9zZXRfdnJpbmdfYWRkcih2b2lkICpkZXYsIHVuc2lnbmVk
IGludCBpbmRleCwgdW5zaWduZWQgaW50IGZsYWdzLCB1aW50NjRfdCBkZXNjX3VzZXJfYWRkciwg
dWludDY0X3QgdXNlZF91c2VyX2FkZHIsIHVpbnQ2NF90IGF2YWlsX3VzZXJfYWRkciwgdWludDY0
X3QgbG9nX2d1ZXN0X2FkZHIpICJkZXY6ICVwIGluZGV4OiAldSBmbGFnczogMHgleCBkZXNjX3Vz
ZXJfYWRkcjogMHglIlBSSXg2NCIgdXNlZF91c2VyX2FkZHI6IDB4JSJQUkl4NjQiIGF2YWlsX3Vz
ZXJfYWRkcjogMHglIlBSSXg2NCIgbG9nX2d1ZXN0X2FkZHI6IDB4JSJQUkl4NjQKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
