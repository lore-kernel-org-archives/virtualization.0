Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389A0C64ED8
	for <virtualization@archiver.kernel.org>; Mon, 27 Feb 2023 07:34:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B938C4091F;
	Mon, 27 Feb 2023 07:34:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B938C4091F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JLdjUxNV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WnZJAEt-Wtpf; Mon, 27 Feb 2023 07:34:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DCF484091A;
	Mon, 27 Feb 2023 07:34:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DCF484091A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0335C0032;
	Mon, 27 Feb 2023 07:34:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 465FFC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 07:34:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 218BD4091F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 07:34:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 218BD4091F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lTSb7CbAUkiF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 07:34:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 089674091A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 089674091A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 07:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677483257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LNyh6ty354TqaT+I9MM6JrQEa/RfxXfuVfvsohl8EN4=;
 b=JLdjUxNV8Own5vNLDCvtAVlTf7S69ss/Tx3yoZLpdT2g2V3ionsdN0dw+P8p7zEKcu0UM+
 E5gwibJ7FnJdYWk5mnM5SjHrjB3Jgs54lRaFnbcjOdW2GFgct4fzYk/oumCUpJAeQM+BDq
 ADtdVVBvuNhMYLQp8FIimHiD2fvaCZc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-576-N8zsPrVKMZmCBk87eddZSA-1; Mon, 27 Feb 2023 02:34:15 -0500
X-MC-Unique: N8zsPrVKMZmCBk87eddZSA-1
Received: by mail-pj1-f71.google.com with SMTP id
 ip3-20020a17090b314300b00237c16adf30so3002227pjb.5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Feb 2023 23:34:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LNyh6ty354TqaT+I9MM6JrQEa/RfxXfuVfvsohl8EN4=;
 b=J4sm0mmul/rn9+bufgU/41MbVZ9q9T/oC0/jQWNJxhMfOhKotXmhEqnln7cAM0G4uT
 kQME7G6tVvSXby0zktMyv7nS8nPYzAHfAfIstXdHf683ouu0ZsPMLmkHkVawQjsUFZKH
 8u1Lq5HbWBRYEDaOJhrzFTegEPb4W5Q3EH/8eUDb3/GWb5lEfGHfMFL8jqgIiJPTjdTJ
 OddRk0FTNvavsaa3n5uZZVXBv3KEGEl9xh7FE9UXs+sVzlF9//QljXQmRiyfaDIfVVYw
 qaCnqTOq0WLCyAKNTKpK8GshC7ZaFx3ZPO9hfAFmV41W8y3VaN+ZpKoIlSL0jFFAk1bW
 xXnw==
X-Gm-Message-State: AO0yUKWibflX9ETHivU8SPeyTQy9wiT4mEWLgS1TwOuXDXiRAIsCL6ex
 l8OCKwnCWNc2zxajL274rZBJFlsNwIN5SAR31MdOZ2wr41qyhfxUQ+lYQFea+iC0mEaHmnZKUvA
 LoiXKGBjrJm5dbaQoq/1xk8OaGi8GVNVHoSTHq1Wtyg==
X-Received: by 2002:a17:903:78b:b0:19d:473:4dca with SMTP id
 kn11-20020a170903078b00b0019d04734dcamr3545928plb.15.1677483252557; 
 Sun, 26 Feb 2023 23:34:12 -0800 (PST)
X-Google-Smtp-Source: AK7set8vREmQ9wU019pF54R3mtn9CLTcVfGuTTUOnsyzFyQcC2yVw9Ha6UyGLkRkJm3BIC/YcTn+UQ==
X-Received: by 2002:a17:903:78b:b0:19d:473:4dca with SMTP id
 kn11-20020a170903078b00b0019d04734dcamr3545908plb.15.1677483252246; 
 Sun, 26 Feb 2023 23:34:12 -0800 (PST)
Received: from [10.72.13.83] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 d91-20020a17090a6f6400b00233b1da232csm5531088pjk.41.2023.02.26.23.34.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Feb 2023 23:34:11 -0800 (PST)
Message-ID: <83e6d634-3f03-e10b-eebc-b3a9c9c8705e@redhat.com>
Date: Mon, 27 Feb 2023 15:34:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v4 08/15] vdpa: rewind at get_base, not set_base
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20230224155438.112797-1-eperezma@redhat.com>
 <20230224155438.112797-9-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230224155438.112797-9-eperezma@redhat.com>
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

CuWcqCAyMDIzLzIvMjQgMjM6NTQsIEV1Z2VuaW8gUMOpcmV6IOWGmemBkzoKPiBBdCB0aGlzIG1v
bWVudCBpdCBpcyBvbmx5IHBvc3NpYmxlIHRvIG1pZ3JhdGUgdG8gYSB2ZHBhIGRldmljZSBydW5u
aW5nCj4gd2l0aCB4LXN2cT1vbi4gQXMgYSBwcm90ZWN0aXZlIG1lYXN1cmUsIHRoZSByZXdpbmQg
b2YgdGhlIGluZmxpZ2h0Cj4gZGVzY3JpcHRvcnMgd2FzIGRvbmUgYXQgdGhlIGRlc3RpbmF0aW9u
LiBUaGF0IHdheSBpZiB0aGUgc291cmNlIHNlbnQgYQo+IHZpcnRxdWV1ZSB3aXRoIGludXNlIGRl
c2NyaXB0b3JzIHRoZXkgYXJlIGFsd2F5cyBkaXNjYXJkZWQuCj4KPiBTaW5jZSB0aGlzIHNlcmll
cyBhbGxvd3MgdG8gbWlncmF0ZSBhbHNvIHRvIHBhc3N0aHJvdWdoIGRldmljZXMgd2l0aCBubwo+
IFNWUSwgdGhlIHJpZ2h0IHRoaW5nIHRvIGRvIGlzIHRvIHJld2luZCBhdCB0aGUgc291cmNlIHNv
IHRoZSBiYXNlIG9mCj4gdnJpbmdzIGFyZSBjb3JyZWN0Lgo+Cj4gU3VwcG9ydCBmb3IgaW5mbGln
aHQgZGVzY3JpcHRvcnMgbWF5IGJlIGFkZGVkIGluIHRoZSBmdXR1cmUuCj4KPiBTaWduZWQtb2Zm
LWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KCgpBY2tlZC1ieTogSmFz
b24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRoYW5rcwoKCj4gLS0tCj4gdjQ6Cj4gKiBV
c2UgdmlydHF1ZXVlX3VucG9wIGF0IHZob3N0X3N2cV9zdG9wIGluc3RlYWQgb2YgcmV3aW5kaW5n
IGF0Cj4gICAgdmhvc3RfdmRwYV9nZXRfdnJpbmdfYmFzZS4KPiAtLS0KPiAgIGh3L3ZpcnRpby92
aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMgfCAgOCArKysrKystLQo+ICAgaHcvdmlydGlvL3Zob3N0
LXZkcGEuYyAgICAgICAgICAgICB8IDExIC0tLS0tLS0tLS0tCj4gICAyIGZpbGVzIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvaHcvdmly
dGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuYyBiL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmly
dHF1ZXVlLmMKPiBpbmRleCA0MzA3Mjk2MzU4Li41MjNiMzc5NDM5IDEwMDY0NAo+IC0tLSBhL2h3
L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMKPiArKysgYi9ody92aXJ0aW8vdmhvc3Qt
c2hhZG93LXZpcnRxdWV1ZS5jCj4gQEAgLTY5NCwxMyArNjk0LDE3IEBAIHZvaWQgdmhvc3Rfc3Zx
X3N0b3AoVmhvc3RTaGFkb3dWaXJ0cXVldWUgKnN2cSkKPiAgICAgICAgICAgZ19hdXRvZnJlZSBW
aXJ0UXVldWVFbGVtZW50ICplbGVtID0gTlVMTDsKPiAgICAgICAgICAgZWxlbSA9IGdfc3RlYWxf
cG9pbnRlcigmc3ZxLT5kZXNjX3N0YXRlW2ldLmVsZW0pOwo+ICAgICAgICAgICBpZiAoZWxlbSkg
ewo+IC0gICAgICAgICAgICB2aXJ0cXVldWVfZGV0YWNoX2VsZW1lbnQoc3ZxLT52cSwgZWxlbSwg
MCk7Cj4gKyAgICAgICAgICAgIC8qCj4gKyAgICAgICAgICAgICAqIFRPRE86IFRoaXMgaXMgb2sg
Zm9yIG5ldHdvcmtpbmcsIGJ1dCBvdGhlciBraW5kcyBvZiBkZXZpY2VzCj4gKyAgICAgICAgICAg
ICAqIG1pZ2h0IGhhdmUgcHJvYmxlbXMgd2l0aCBqdXN0IHVucG9wIHRoZXNlLgo+ICsgICAgICAg
ICAgICAgKi8KPiArICAgICAgICAgICAgdmlydHF1ZXVlX3VucG9wKHN2cS0+dnEsIGVsZW0sIDAp
Owo+ICAgICAgICAgICB9Cj4gICAgICAgfQo+ICAgCj4gICAgICAgbmV4dF9hdmFpbF9lbGVtID0g
Z19zdGVhbF9wb2ludGVyKCZzdnEtPm5leHRfZ3Vlc3RfYXZhaWxfZWxlbSk7Cj4gICAgICAgaWYg
KG5leHRfYXZhaWxfZWxlbSkgewo+IC0gICAgICAgIHZpcnRxdWV1ZV9kZXRhY2hfZWxlbWVudChz
dnEtPnZxLCBuZXh0X2F2YWlsX2VsZW0sIDApOwo+ICsgICAgICAgIHZpcnRxdWV1ZV91bnBvcChz
dnEtPnZxLCBuZXh0X2F2YWlsX2VsZW0sIDApOwo+ICAgICAgIH0KPiAgICAgICBzdnEtPnZxID0g
TlVMTDsKPiAgICAgICBnX2ZyZWUoc3ZxLT5kZXNjX25leHQpOwo+IGRpZmYgLS1naXQgYS9ody92
aXJ0aW8vdmhvc3QtdmRwYS5jIGIvaHcvdmlydGlvL3Zob3N0LXZkcGEuYwo+IGluZGV4IGY1NDI5
NjBhNjQuLjcxZTNkYzIxZmUgMTAwNjQ0Cj4gLS0tIGEvaHcvdmlydGlvL3Zob3N0LXZkcGEuYwo+
ICsrKyBiL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMKPiBAQCAtMTIxOCwxOCArMTIxOCw3IEBAIHN0
YXRpYyBpbnQgdmhvc3RfdmRwYV9zZXRfdnJpbmdfYmFzZShzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYs
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgdmhvc3Rf
dnJpbmdfc3RhdGUgKnJpbmcpCj4gICB7Cj4gICAgICAgc3RydWN0IHZob3N0X3ZkcGEgKnYgPSBk
ZXYtPm9wYXF1ZTsKPiAtICAgIFZpcnRRdWV1ZSAqdnEgPSB2aXJ0aW9fZ2V0X3F1ZXVlKGRldi0+
dmRldiwgcmluZy0+aW5kZXgpOwo+ICAgCj4gLSAgICAvKgo+IC0gICAgICogdmhvc3QtdmRwYSBk
ZXZpY2VzIGRvZXMgbm90IHN1cHBvcnQgaW4tZmxpZ2h0IHJlcXVlc3RzLiBTZXQgYWxsIG9mIHRo
ZW0KPiAtICAgICAqIGFzIGF2YWlsYWJsZS4KPiAtICAgICAqCj4gLSAgICAgKiBUT0RPOiBUaGlz
IGlzIG9rIGZvciBuZXR3b3JraW5nLCBidXQgb3RoZXIga2luZHMgb2YgZGV2aWNlcyBtaWdodAo+
IC0gICAgICogaGF2ZSBwcm9ibGVtcyB3aXRoIHRoZXNlIHJldHJhbnNtaXNzaW9ucy4KPiAtICAg
ICAqLwo+IC0gICAgd2hpbGUgKHZpcnRxdWV1ZV9yZXdpbmQodnEsIDEpKSB7Cj4gLSAgICAgICAg
Y29udGludWU7Cj4gLSAgICB9Cj4gICAgICAgaWYgKHYtPnNoYWRvd192cXNfZW5hYmxlZCkgewo+
ICAgICAgICAgICAvKgo+ICAgICAgICAgICAgKiBEZXZpY2UgdnJpbmcgYmFzZSB3YXMgc2V0IGF0
IGRldmljZSBzdGFydC4gU1ZRIGJhc2UgaXMgaGFuZGxlZCBieQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
