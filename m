Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7ECC64ED6
	for <virtualization@archiver.kernel.org>; Mon, 27 Feb 2023 08:08:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7981160F3B;
	Mon, 27 Feb 2023 08:08:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7981160F3B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LNOwkJKa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Cou_PInLCkx; Mon, 27 Feb 2023 08:08:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BEFA7605A1;
	Mon, 27 Feb 2023 08:08:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BEFA7605A1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D34EC0033;
	Mon, 27 Feb 2023 08:08:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D6A2C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 08:08:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F3D760F15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 08:08:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F3D760F15
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oLNn206-JGvh
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 08:08:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2B213605A1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2B213605A1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 08:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677485299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VbgrnJnNiG3Oslkqyp6Kn5k1IwwzxMrTsAw2pEGNmbA=;
 b=LNOwkJKazdy92Wf3iELEKCTSKadrFnzdYF+voyt27sUkQ68BsWifFRhZCpBVCWly4PaNYa
 96gXgN9/iVkB3w9Nul0mCWD1mFFWVIZ3sS8X4B17uaSQSeQvKeCCTntEMl9Sl3AiLdj3QM
 D4AxPkeXMTW6lG4k01qtVR5k8uWYThc=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-98-liYqWuQ2M7i24dvC7mI97Q-1; Mon, 27 Feb 2023 03:08:18 -0500
X-MC-Unique: liYqWuQ2M7i24dvC7mI97Q-1
Received: by mail-pf1-f199.google.com with SMTP id
 p5-20020a056a0026c500b005cbeecd5c0dso3015048pfw.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 00:08:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VbgrnJnNiG3Oslkqyp6Kn5k1IwwzxMrTsAw2pEGNmbA=;
 b=QWuk0TZvwoD8Iu66gFNNum32Z1WsTV2rbEbge2djr+mkDRAOGqRG5Wp1dQGAkt0c5R
 OdtR7VA8WVd1ESUxGb6+vmncolvfPhsSbjvNaIztZ3bZN6nmplgd1iElsBPGONe/hNvB
 Zvk/4j+FVjGdBKL6s2bHtPr9oiPe10z244SYL9bQQyDaPgWGzv7vmyBU6NVjtF+ZghNn
 vXtUUBiXZBVQ9kwLBLl8chuE6n/OpfGZmMRi4YF4CV1py8oAoTcy0NIDjIJOcCSQ9LqS
 nAHNk+ChX/0iE49icGVTG8KSCU6zF9gTQlv7VDOJEtlAsavq5zNmBZBa6E2uJ46pFS12
 JvYQ==
X-Gm-Message-State: AO0yUKWP0FU7VhBldjw/eSTixEfo+K4iwImAQDq6+hNVUy2i3HNzUNmb
 B0wqrVvpBz/7hmXhPCf3Bp35AxPlhhpRmG2oqK0IG9xUj8S0AiXuFC803hb+f937eoIWaxnUQ/w
 G+EHUT3rWhnZn22gDSE7m1Dd0aJ4nBGjMYuAwwLia+g==
X-Received: by 2002:a05:6a20:1586:b0:c7:13be:6de9 with SMTP id
 h6-20020a056a20158600b000c713be6de9mr29137048pzj.14.1677485297514; 
 Mon, 27 Feb 2023 00:08:17 -0800 (PST)
X-Google-Smtp-Source: AK7set8z6C9/Abm9nKHMqgWDd4iCLCxQyPEXopVgkXKC1gNrmJA0XviMmzy4VMEMLv9AcjOb+GLUeg==
X-Received: by 2002:a05:6a20:1586:b0:c7:13be:6de9 with SMTP id
 h6-20020a056a20158600b000c713be6de9mr29137037pzj.14.1677485297193; 
 Mon, 27 Feb 2023 00:08:17 -0800 (PST)
Received: from [10.72.13.83] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 x27-20020aa793bb000000b005a8dd86018dsm3645029pff.64.2023.02.27.00.08.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Feb 2023 00:08:16 -0800 (PST)
Message-ID: <afad31de-8109-36b7-b7ea-aa2e1a24f254@redhat.com>
Date: Mon, 27 Feb 2023 16:08:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v4 09/15] vdpa: add vdpa net migration state notifier
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20230224155438.112797-1-eperezma@redhat.com>
 <20230224155438.112797-10-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230224155438.112797-10-eperezma@redhat.com>
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

CuWcqCAyMDIzLzIvMjQgMjM6NTQsIEV1Z2VuaW8gUMOpcmV6IOWGmemBkzoKPiBUaGlzIGFsbG93
cyBuZXQgdG8gcmVzdGFydCB0aGUgZGV2aWNlIGJhY2tlbmQgdG8gY29uZmlndXJlIFNWUSBvbiBp
dC4KPgo+IElkZWFsbHksIHRoZXNlIGNoYW5nZXMgc2hvdWxkIG5vdCBiZSBuZXQgc3BlY2lmaWMu
IEhvd2V2ZXIsIHRoZSB2ZHBhIG5ldAo+IGJhY2tlbmQgaXMgdGhlIG9uZSB3aXRoIGVub3VnaCBr
bm93bGVkZ2UgdG8gY29uZmlndXJlIGV2ZXJ5dGhpbmcgYmVjYXVzZQo+IG9mIHNvbWUgcmVhc29u
czoKPiAqIFF1ZXVlcyBtaWdodCBuZWVkIHRvIGJlIHNoYWRvd2VkIG9yIG5vdCBkZXBlbmRpbmcg
b24gaXRzIGtpbmQgKGNvbnRyb2wKPiAgICB2cyBkYXRhKS4KPiAqIFF1ZXVlcyBuZWVkIHRvIHNo
YXJlIHRoZSBzYW1lIG1hcCB0cmFuc2xhdGlvbnMgKGlvdmEgdHJlZSkuCj4KPiBCZWNhdXNlIG9m
IHRoYXQgaXQgaXMgY2xlYW5lciB0byByZXN0YXJ0IHRoZSB3aG9sZSBuZXQgYmFja2VuZCBhbmQK
PiBjb25maWd1cmUgYWdhaW4gYXMgZXhwZWN0ZWQsIHNpbWlsYXIgdG8gaG93IHZob3N0LWtlcm5l
bCBtb3ZlcyBiZXR3ZWVuCj4gdXNlcnNwYWNlIGFuZCBwYXNzdGhyb3VnaC4KPgo+IElmIG1vcmUg
a2luZHMgb2YgZGV2aWNlcyBuZWVkIGR5bmFtaWMgc3dpdGNoaW5nIHRvIFNWUSB3ZSBjYW4gY3Jl
YXRlIGEKPiBjYWxsYmFjayBzdHJ1Y3QgbGlrZSBWaG9zdE9wcyBhbmQgbW92ZSBtb3N0IG9mIHRo
ZSBjb2RlIHRoZXJlLgo+IFZob3N0T3BzIGNhbm5vdCBiZSByZXVzZWQgc2luY2UgYWxsIHZkcGEg
YmFja2VuZCBzaGFyZSB0aGVtLCBhbmQgdG8KPiBwZXJzb25hbGl6ZSBqdXN0IGZvciBuZXR3b3Jr
aW5nIHdvdWxkIGJlIHRvbyBoZWF2eS4KPgo+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaW8gUMOpcmV6
IDxlcGVyZXptYUByZWRoYXQuY29tPgo+IC0tLQo+IHY0Ogo+ICogRGVsZXRlIGR1cGxpY2F0aW9u
IG9mIHNldCBzaGFkb3dfZGF0YSBhbmQgc2hhZG93X3Zxc19lbmFibGVkIG1vdmluZyBpdAo+ICAg
IHRvIGRhdGEgLyBjdnEgbmV0IHN0YXJ0IGZ1bmN0aW9ucy4KPgo+IHYzOgo+ICogQ2hlY2sgZm9y
IG1pZ3JhdGlvbiBzdGF0ZSBhdCB2ZHBhIGRldmljZSBzdGFydCB0byBlbmFibGUgU1ZRIGluIGRh
dGEKPiAgICB2cXMuCj4KPiB2MSBmcm9tIFJGQzoKPiAqIEFkZCBUT0RPIHRvIHVzZSB0aGUgcmVz
dW1lIG9wZXJhdGlvbiBpbiB0aGUgZnV0dXJlLgo+ICogVXNlIG1pZ3JhdGlvbl9pbl9zZXR1cCBh
bmQgbWlncmF0aW9uX2hhc19mYWlsZWQgaW5zdGVhZCBvZiBhCj4gICAgY29tcGxpY2F0ZWQgc3dp
dGNoIGNhc2UuCj4gLS0tCj4gICBuZXQvdmhvc3QtdmRwYS5jIHwgNzIgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tCj4gICAxIGZpbGUgY2hhbmdlZCwgNjkg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9uZXQvdmhvc3Qt
dmRwYS5jIGIvbmV0L3Zob3N0LXZkcGEuYwo+IGluZGV4IGI4OWM5OTA2NmEuLmM1NTEyZGRmMTAg
MTAwNjQ0Cj4gLS0tIGEvbmV0L3Zob3N0LXZkcGEuYwo+ICsrKyBiL25ldC92aG9zdC12ZHBhLmMK
PiBAQCAtMjYsMTIgKzI2LDE1IEBACj4gICAjaW5jbHVkZSA8ZXJyLmg+Cj4gICAjaW5jbHVkZSAi
c3RhbmRhcmQtaGVhZGVycy9saW51eC92aXJ0aW9fbmV0LmgiCj4gICAjaW5jbHVkZSAibW9uaXRv
ci9tb25pdG9yLmgiCj4gKyNpbmNsdWRlICJtaWdyYXRpb24vbWlncmF0aW9uLmgiCj4gKyNpbmNs
dWRlICJtaWdyYXRpb24vbWlzYy5oIgo+ICAgI2luY2x1ZGUgImh3L3ZpcnRpby92aG9zdC5oIgo+
ICAgCj4gICAvKiBUb2RvOm5lZWQgdG8gYWRkIHRoZSBtdWx0aXF1ZXVlIHN1cHBvcnQgaGVyZSAq
Lwo+ICAgdHlwZWRlZiBzdHJ1Y3QgVmhvc3RWRFBBU3RhdGUgewo+ICAgICAgIE5ldENsaWVudFN0
YXRlIG5jOwo+ICAgICAgIHN0cnVjdCB2aG9zdF92ZHBhIHZob3N0X3ZkcGE7Cj4gKyAgICBOb3Rp
ZmllciBtaWdyYXRpb25fc3RhdGU7Cj4gICAgICAgVkhvc3ROZXRTdGF0ZSAqdmhvc3RfbmV0Owo+
ICAgCj4gICAgICAgLyogQ29udHJvbCBjb21tYW5kcyBzaGFkb3cgYnVmZmVycyAqLwo+IEBAIC0y
MzksMTAgKzI0Miw1OSBAQCBzdGF0aWMgVmhvc3RWRFBBU3RhdGUgKnZob3N0X3ZkcGFfbmV0X2Zp
cnN0X25jX3ZkcGEoVmhvc3RWRFBBU3RhdGUgKnMpCj4gICAgICAgcmV0dXJuIERPX1VQQ0FTVChW
aG9zdFZEUEFTdGF0ZSwgbmMsIG5jMCk7Cj4gICB9Cj4gICAKPiArc3RhdGljIHZvaWQgdmhvc3Rf
dmRwYV9uZXRfbG9nX2dsb2JhbF9lbmFibGUoVmhvc3RWRFBBU3RhdGUgKnMsIGJvb2wgZW5hYmxl
KQo+ICt7Cj4gKyAgICBzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiA9ICZzLT52aG9zdF92ZHBhOwo+ICsg
ICAgVmlydElPTmV0ICpuOwo+ICsgICAgVmlydElPRGV2aWNlICp2ZGV2Owo+ICsgICAgaW50IGRh
dGFfcXVldWVfcGFpcnMsIGN2cSwgcjsKPiArCj4gKyAgICAvKiBXZSBhcmUgb25seSBjYWxsZWQg
b24gdGhlIGZpcnN0IGRhdGEgdnFzIGFuZCBvbmx5IGlmIHgtc3ZxIGlzIG5vdCBzZXQgKi8KPiAr
ICAgIGlmIChzLT52aG9zdF92ZHBhLnNoYWRvd192cXNfZW5hYmxlZCA9PSBlbmFibGUpIHsKPiAr
ICAgICAgICByZXR1cm47Cj4gKyAgICB9Cj4gKwo+ICsgICAgdmRldiA9IHYtPmRldi0+dmRldjsK
PiArICAgIG4gPSBWSVJUSU9fTkVUKHZkZXYpOwo+ICsgICAgaWYgKCFuLT52aG9zdF9zdGFydGVk
KSB7Cj4gKyAgICAgICAgcmV0dXJuOwo+ICsgICAgfQo+ICsKPiArICAgIGRhdGFfcXVldWVfcGFp
cnMgPSBuLT5tdWx0aXF1ZXVlID8gbi0+bWF4X3F1ZXVlX3BhaXJzIDogMTsKPiArICAgIGN2cSA9
IHZpcnRpb192ZGV2X2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9DVFJMX1ZRKSA/Cj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBuLT5tYXhfbmNzIC0gbi0+bWF4X3F1
ZXVlX3BhaXJzIDogMDsKPiArICAgIC8qCj4gKyAgICAgKiBUT0RPOiB2aG9zdF9uZXRfc3RvcCBk
b2VzIHN1c3BlbmQsIGdldF9iYXNlIGFuZCByZXNldC4gV2UgY2FuIGJlIHNtYXJ0ZXIKPiArICAg
ICAqIGluIHRoZSBmdXR1cmUgYW5kIHJlc3VtZSB0aGUgZGV2aWNlIGlmIHJlYWQtb25seSBvcGVy
YXRpb25zIGJldHdlZW4KPiArICAgICAqIHN1c3BlbmQgYW5kIHJlc2V0IGdvZXMgd3JvbmcuCj4g
KyAgICAgKi8KPiArICAgIHZob3N0X25ldF9zdG9wKHZkZXYsIG4tPm5pYy0+bmNzLCBkYXRhX3F1
ZXVlX3BhaXJzLCBjdnEpOwo+ICsKPiArICAgIC8qIFN0YXJ0IHdpbGwgY2hlY2sgbWlncmF0aW9u
IHNldHVwX29yX2FjdGl2ZSB0byBjb25maWd1cmUgb3Igbm90IFNWUSAqLwo+ICsgICAgciA9IHZo
b3N0X25ldF9zdGFydCh2ZGV2LCBuLT5uaWMtPm5jcywgZGF0YV9xdWV1ZV9wYWlycywgY3ZxKTsK
PiArICAgIGlmICh1bmxpa2VseShyIDwgMCkpIHsKPiArICAgICAgICBlcnJvcl9yZXBvcnQoInVu
YWJsZSB0byBzdGFydCB2aG9zdCBuZXQ6ICVzKCVkKSIsIGdfc3RyZXJyb3IoLXIpLCAtcik7Cj4g
KyAgICB9Cj4gK30KPiArCj4gK3N0YXRpYyB2b2lkIHZkcGFfbmV0X21pZ3JhdGlvbl9zdGF0ZV9u
b3RpZmllcihOb3RpZmllciAqbm90aWZpZXIsIHZvaWQgKmRhdGEpCj4gK3sKPiArICAgIE1pZ3Jh
dGlvblN0YXRlICptaWdyYXRpb24gPSBkYXRhOwo+ICsgICAgVmhvc3RWRFBBU3RhdGUgKnMgPSBj
b250YWluZXJfb2Yobm90aWZpZXIsIFZob3N0VkRQQVN0YXRlLAo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgbWlncmF0aW9uX3N0YXRlKTsKPiArCj4gKyAgICBpZiAobWln
cmF0aW9uX2luX3NldHVwKG1pZ3JhdGlvbikpIHsKPiArICAgICAgICB2aG9zdF92ZHBhX25ldF9s
b2dfZ2xvYmFsX2VuYWJsZShzLCB0cnVlKTsKPiArICAgIH0gZWxzZSBpZiAobWlncmF0aW9uX2hh
c19mYWlsZWQobWlncmF0aW9uKSkgewo+ICsgICAgICAgIHZob3N0X3ZkcGFfbmV0X2xvZ19nbG9i
YWxfZW5hYmxlKHMsIGZhbHNlKTsKPiArICAgIH0KPiArfQo+ICsKPiAgIHN0YXRpYyB2b2lkIHZo
b3N0X3ZkcGFfbmV0X2RhdGFfc3RhcnRfZmlyc3QoVmhvc3RWRFBBU3RhdGUgKnMpCj4gICB7Cj4g
ICAgICAgc3RydWN0IHZob3N0X3ZkcGEgKnYgPSAmcy0+dmhvc3RfdmRwYTsKPiAgIAo+ICsgICAg
YWRkX21pZ3JhdGlvbl9zdGF0ZV9jaGFuZ2Vfbm90aWZpZXIoJnMtPm1pZ3JhdGlvbl9zdGF0ZSk7
Cj4gICAgICAgaWYgKHYtPnNoYWRvd192cXNfZW5hYmxlZCkgewo+ICAgICAgICAgICB2LT5pb3Zh
X3RyZWUgPSB2aG9zdF9pb3ZhX3RyZWVfbmV3KHYtPmlvdmFfcmFuZ2UuZmlyc3QsCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdi0+aW92YV9yYW5nZS5sYXN0
KTsKPiBAQCAtMjU2LDYgKzMwOCwxNSBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfbmV0X2RhdGFf
c3RhcnQoTmV0Q2xpZW50U3RhdGUgKm5jKQo+ICAgCj4gICAgICAgYXNzZXJ0KG5jLT5pbmZvLT50
eXBlID09IE5FVF9DTElFTlRfRFJJVkVSX1ZIT1NUX1ZEUEEpOwo+ICAgCj4gKyAgICBpZiAocy0+
YWx3YXlzX3N2cSB8fAo+ICsgICAgICAgIG1pZ3JhdGlvbl9pc19zZXR1cF9vcl9hY3RpdmUobWln
cmF0ZV9nZXRfY3VycmVudCgpLT5zdGF0ZSkpIHsKPiArICAgICAgICB2LT5zaGFkb3dfdnFzX2Vu
YWJsZWQgPSB0cnVlOwo+ICsgICAgICAgIHYtPnNoYWRvd19kYXRhID0gdHJ1ZTsKPiArICAgIH0g
ZWxzZSB7Cj4gKyAgICAgICAgdi0+c2hhZG93X3Zxc19lbmFibGVkID0gZmFsc2U7Cj4gKyAgICAg
ICAgdi0+c2hhZG93X2RhdGEgPSBmYWxzZTsKPiArICAgIH0KPiArCj4gICAgICAgaWYgKHYtPmlu
ZGV4ID09IDApIHsKPiAgICAgICAgICAgdmhvc3RfdmRwYV9uZXRfZGF0YV9zdGFydF9maXJzdChz
KTsKPiAgICAgICAgICAgcmV0dXJuIDA7Cj4gQEAgLTI3Niw2ICszMzcsMTAgQEAgc3RhdGljIHZv
aWQgdmhvc3RfdmRwYV9uZXRfY2xpZW50X3N0b3AoTmV0Q2xpZW50U3RhdGUgKm5jKQo+ICAgCj4g
ICAgICAgYXNzZXJ0KG5jLT5pbmZvLT50eXBlID09IE5FVF9DTElFTlRfRFJJVkVSX1ZIT1NUX1ZE
UEEpOwo+ICAgCj4gKyAgICBpZiAocy0+dmhvc3RfdmRwYS5pbmRleCA9PSAwKSB7Cj4gKyAgICAg
ICAgcmVtb3ZlX21pZ3JhdGlvbl9zdGF0ZV9jaGFuZ2Vfbm90aWZpZXIoJnMtPm1pZ3JhdGlvbl9z
dGF0ZSk7Cj4gKyAgICB9CgoKVGhpcyBzaG91bGQgd29yayBidXQgSSBqdXN0IHJlYWxpemUgdGhh
dCB2aG9zdCBzdXBwb3J0IAp2aG9zdF9kZXZfc2V0X2xvZygpLCBJIHdvbmRlciBpZiBpdCB3b3Vs
ZCBiZSBzaW1wbGVyIHRvIGdvIHdpdGggdGhhdCB3YXkuCgpVc2luZyB2aG9zdF92aXJ0cXVldWVf
c2V0X2FkZHIoLCBlbmFibGVfbG9nID0gdHJ1ZSk/CgpUaGFua3MKCgo+ICsKPiAgICAgICBkZXYg
PSBzLT52aG9zdF92ZHBhLmRldjsKPiAgICAgICBpZiAoZGV2LT52cV9pbmRleCArIGRldi0+bnZx
cyA9PSBkZXYtPnZxX2luZGV4X2VuZCkgewo+ICAgICAgICAgICBnX2NsZWFyX3BvaW50ZXIoJnMt
PnZob3N0X3ZkcGEuaW92YV90cmVlLCB2aG9zdF9pb3ZhX3RyZWVfZGVsZXRlKTsKPiBAQCAtNDEy
LDExICs0NzcsMTIgQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX25ldF9jdnFfc3RhcnQoTmV0Q2xp
ZW50U3RhdGUgKm5jKQo+ICAgICAgIHMgPSBET19VUENBU1QoVmhvc3RWRFBBU3RhdGUsIG5jLCBu
Yyk7Cj4gICAgICAgdiA9ICZzLT52aG9zdF92ZHBhOwo+ICAgCj4gLSAgICB2LT5zaGFkb3dfZGF0
YSA9IHMtPmFsd2F5c19zdnE7Cj4gKyAgICBzMCA9IHZob3N0X3ZkcGFfbmV0X2ZpcnN0X25jX3Zk
cGEocyk7Cj4gKyAgICB2LT5zaGFkb3dfZGF0YSA9IHMwLT52aG9zdF92ZHBhLnNoYWRvd192cXNf
ZW5hYmxlZDsKPiAgICAgICB2LT5zaGFkb3dfdnFzX2VuYWJsZWQgPSBzLT5hbHdheXNfc3ZxOwo+
ICAgICAgIHMtPnZob3N0X3ZkcGEuYWRkcmVzc19zcGFjZV9pZCA9IFZIT1NUX1ZEUEFfR1VFU1Rf
UEFfQVNJRDsKPiAgIAo+IC0gICAgaWYgKHMtPmFsd2F5c19zdnEpIHsKPiArICAgIGlmIChzLT52
aG9zdF92ZHBhLnNoYWRvd19kYXRhKSB7Cj4gICAgICAgICAgIC8qIFNWUSBpcyBhbHJlYWR5IGNv
bmZpZ3VyZWQgZm9yIGFsbCB2aXJ0cXVldWVzICovCj4gICAgICAgICAgIGdvdG8gb3V0Owo+ICAg
ICAgIH0KPiBAQCAtNDczLDcgKzUzOSw2IEBAIG91dDoKPiAgICAgICAgICAgcmV0dXJuIDA7Cj4g
ICAgICAgfQo+ICAgCj4gLSAgICBzMCA9IHZob3N0X3ZkcGFfbmV0X2ZpcnN0X25jX3ZkcGEocyk7
Cj4gICAgICAgaWYgKHMwLT52aG9zdF92ZHBhLmlvdmFfdHJlZSkgewo+ICAgICAgICAgICAvKgo+
ICAgICAgICAgICAgKiBTVlEgaXMgYWxyZWFkeSBjb25maWd1cmVkIGZvciBhbGwgdmlydHF1ZXVl
cy4gIFJldXNlIElPVkEgdHJlZSBmb3IKPiBAQCAtNzQ5LDYgKzgxNCw3IEBAIHN0YXRpYyBOZXRD
bGllbnRTdGF0ZSAqbmV0X3Zob3N0X3ZkcGFfaW5pdChOZXRDbGllbnRTdGF0ZSAqcGVlciwKPiAg
ICAgICBzLT52aG9zdF92ZHBhLmRldmljZV9mZCA9IHZkcGFfZGV2aWNlX2ZkOwo+ICAgICAgIHMt
PnZob3N0X3ZkcGEuaW5kZXggPSBxdWV1ZV9wYWlyX2luZGV4Owo+ICAgICAgIHMtPmFsd2F5c19z
dnEgPSBzdnE7Cj4gKyAgICBzLT5taWdyYXRpb25fc3RhdGUubm90aWZ5ID0gdmRwYV9uZXRfbWln
cmF0aW9uX3N0YXRlX25vdGlmaWVyOwo+ICAgICAgIHMtPnZob3N0X3ZkcGEuc2hhZG93X3Zxc19l
bmFibGVkID0gc3ZxOwo+ICAgICAgIHMtPnZob3N0X3ZkcGEuaW92YV9yYW5nZSA9IGlvdmFfcmFu
Z2U7Cj4gICAgICAgcy0+dmhvc3RfdmRwYS5zaGFkb3dfZGF0YSA9IHN2cTsKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
