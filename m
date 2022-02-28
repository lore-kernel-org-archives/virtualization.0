Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3967C433F5
	for <virtualization@archiver.kernel.org>; Mon, 28 Feb 2022 07:38:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D98960AD8;
	Mon, 28 Feb 2022 07:38:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Htn04GpzICfx; Mon, 28 Feb 2022 07:38:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 231A660768;
	Mon, 28 Feb 2022 07:38:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04C19C0077;
	Mon, 28 Feb 2022 07:38:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0444C001A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 07:38:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BFB8940893
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 07:38:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wS_RjPfUBKBh
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 07:38:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2374040865
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 07:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646033909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Wvjc6bhiBV/L81IMZEHXA+XZrxqHRvtBEx7es2Kbyc=;
 b=Rn9GtBcFISlL8AlYLOwwuxJN5XJqq9lXSl5MALTyf7kMcfOFz4jtZ8a2cy5MOUoCp0sjgL
 9Y8terrC9nDC16Mk93yZIcmyHIjgp8AwMFIBtqRmASoj/8MIavEzDqzYZXkfTAvSrsbVSF
 sN6/RQavrcG826Wz/lqJbfz97yk7EYo=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-mg91jR_ePnaI93ZCub4rFA-1; Mon, 28 Feb 2022 02:38:27 -0500
X-MC-Unique: mg91jR_ePnaI93ZCub4rFA-1
Received: by mail-pl1-f197.google.com with SMTP id
 z14-20020a170902ccce00b0014d7a559635so4324866ple.16
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Feb 2022 23:38:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=0Wvjc6bhiBV/L81IMZEHXA+XZrxqHRvtBEx7es2Kbyc=;
 b=L0xduiqt+acBuBQCSmwp2RSx+ewMFJ6zGbti6JKlGqmLGIj9mJ6KdHy0Y0BvSFNex+
 4R3C+T35R0iTj4SNtjiY9R/mW540gOXRKjjAepHlqiMBW48JF+gExqt1TNU0EdT4mEmz
 UclpsBOD1fGLiO6FZ4kpH/WrhuXtmZx2L+YSVTvu7eQfTGB5iFSzMdzWh5LcX/BlV7hv
 FbomlqJWAxyjJfDjp+WZNsHcWbH7Ty7R6XZWr60DOnUgI9oomm2K3PBRgodW2nXTp7AC
 1FgKlMJ36PnLpmCuatxYlxEFcVFNdoFNXTiut6YlPTnAmB2PkpRTjgEzP0F5TvGAjPow
 k97w==
X-Gm-Message-State: AOAM533Z4A413IMav4GeLI5BdsH1mVzb2bKAtWYx8gy4k9i+ddMJ9Ho7
 j4ayPBDF2nEf/8A6qQYpD9EGQZX/BGixd7YXd/r+joqquqzGtmkGt1D/iRY20PVQbiJd3CZaMQM
 0kXbNazaRqtIfy4uHajNBCpvDLRQ5oRWsp3+wbUFZVQ==
X-Received: by 2002:a17:902:82c5:b0:151:476b:c581 with SMTP id
 u5-20020a17090282c500b00151476bc581mr10390680plz.158.1646033906864; 
 Sun, 27 Feb 2022 23:38:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwP9+aMD7qkw3m78bo1fiGWJvGsGa8g0OtxpeXajuBxQA1ADkbmlTIFUUJcGIaq2AozQF7/4g==
X-Received: by 2002:a17:902:82c5:b0:151:476b:c581 with SMTP id
 u5-20020a17090282c500b00151476bc581mr10390639plz.158.1646033906603; 
 Sun, 27 Feb 2022 23:38:26 -0800 (PST)
Received: from [10.72.13.215] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 j13-20020a63594d000000b003639cf2f9c7sm9487274pgm.71.2022.02.27.23.38.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Feb 2022 23:38:26 -0800 (PST)
Message-ID: <d0a5454b-b01e-50a6-3a2d-e5223768a163@redhat.com>
Date: Mon, 28 Feb 2022 15:38:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v2 11/14] vdpa: Adapt vhost_vdpa_get_vring_base to SVQ
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20220227134111.3254066-1-eperezma@redhat.com>
 <20220227134111.3254066-12-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220227134111.3254066-12-eperezma@redhat.com>
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
aXMgbmVlZGVkIHRvIGFjaGlldmUgbWlncmF0aW9uLCBzbyB0aGUgZGVzdGluYXRpb24gY2FuIHJl
c3RvcmUgaXRzCj4gaW5kZXguCgoKSSBzdWdnZXN0IHRvIGR1cGxpY2F0ZSB0aGUgY29tbWVudCBi
ZWxvdyBoZXJlLgoKVGhhbmtzCgoKPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBl
cmV6bWFAcmVkaGF0LmNvbT4KPiAtLS0KPiAgIGh3L3ZpcnRpby92aG9zdC12ZHBhLmMgfCAxNyAr
KysrKysrKysrKysrKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykKPgo+
IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhvc3QtdmRwYS5jIGIvaHcvdmlydGlvL3Zob3N0LXZk
cGEuYwo+IGluZGV4IDU2ZjlmMTI1Y2QuLmFjY2M0MDI0YzIgMTAwNjQ0Cj4gLS0tIGEvaHcvdmly
dGlvL3Zob3N0LXZkcGEuYwo+ICsrKyBiL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMKPiBAQCAtMTE4
MCw4ICsxMTgwLDI1IEBAIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9zZXRfdnJpbmdfYmFzZShzdHJ1
Y3Qgdmhvc3RfZGV2ICpkZXYsCj4gICBzdGF0aWMgaW50IHZob3N0X3ZkcGFfZ2V0X3ZyaW5nX2Jh
c2Uoc3RydWN0IHZob3N0X2RldiAqZGV2LAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgc3RydWN0IHZob3N0X3ZyaW5nX3N0YXRlICpyaW5nKQo+ICAgewo+ICsgICAg
c3RydWN0IHZob3N0X3ZkcGEgKnYgPSBkZXYtPm9wYXF1ZTsKPiAgICAgICBpbnQgcmV0Owo+ICAg
Cj4gKyAgICBpZiAodi0+c2hhZG93X3Zxc19lbmFibGVkKSB7Cj4gKyAgICAgICAgVmhvc3RTaGFk
b3dWaXJ0cXVldWUgKnN2cSA9IGdfcHRyX2FycmF5X2luZGV4KHYtPnNoYWRvd192cXMsCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJpbmct
PmluZGV4KTsKPiArCj4gKyAgICAgICAgLyoKPiArICAgICAgICAgKiBTZXR0aW5nIGJhc2UgYXMg
bGFzdCB1c2VkIGlkeCwgc28gZGVzdGluYXRpb24gd2lsbCBzZWUgYXMgYXZhaWxhYmxlCj4gKyAg
ICAgICAgICogYWxsIHRoZSBlbnRyaWVzIHRoYXQgdGhlIGRldmljZSBkaWQgbm90IHVzZSwgaW5j
bHVkaW5nIHRoZSBpbi1mbGlnaHQKPiArICAgICAgICAgKiBwcm9jZXNzaW5nIG9uZXMuCj4gKyAg
ICAgICAgICoKPiArICAgICAgICAgKiBUT0RPOiBUaGlzIGlzIG9rIGZvciBuZXR3b3JraW5nLCBi
dXQgb3RoZXIga2luZHMgb2YgZGV2aWNlcyBtaWdodAo+ICsgICAgICAgICAqIGhhdmUgcHJvYmxl
bXMgd2l0aCB0aGVzZSByZXRyYW5zbWlzc2lvbnMuCj4gKyAgICAgICAgICovCj4gKyAgICAgICAg
cmluZy0+bnVtID0gc3ZxLT5sYXN0X3VzZWRfaWR4Owo+ICsgICAgICAgIHJldHVybiAwOwo+ICsg
ICAgfQo+ICsKPiAgICAgICByZXQgPSB2aG9zdF92ZHBhX2NhbGwoZGV2LCBWSE9TVF9HRVRfVlJJ
TkdfQkFTRSwgcmluZyk7Cj4gICAgICAgdHJhY2Vfdmhvc3RfdmRwYV9nZXRfdnJpbmdfYmFzZShk
ZXYsIHJpbmctPmluZGV4LCByaW5nLT5udW0pOwo+ICAgICAgIHJldHVybiByZXQ7CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
