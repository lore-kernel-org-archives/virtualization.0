Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30937C433FE
	for <virtualization@archiver.kernel.org>; Sat, 29 Jan 2022 08:11:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8F9860BA8;
	Sat, 29 Jan 2022 08:11:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F1C6t7wtubyZ; Sat, 29 Jan 2022 08:11:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 67ED760B7C;
	Sat, 29 Jan 2022 08:11:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 181B4C0011;
	Sat, 29 Jan 2022 08:11:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 067DBC000B
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jan 2022 08:11:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E272160B94
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jan 2022 08:11:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n2cNNhmkzaFG
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jan 2022 08:11:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 218D260B7C
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jan 2022 08:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643443878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HSiqpHC2F7MZ+jp51/naZ8daN+DMPf4P0m+aaZYxKSs=;
 b=HEiYmS2mhnB9TC6p2EkJnordpyif1dn6dNTONvwvU3nrFg+JaNDsho5N5AYF1qsnSTYL9s
 SYBzM4k2jn7TV8Ddma7h0FTsH4fuQHmrRSrYNp/aUrlfB89sSXUcuWyiFBmK5YSXp6jncc
 r+IEqbViOZQYWwJT/QdgI6WQuCP+ZL0=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537-FuVWE68HOc6vgCinoQVTyg-1; Sat, 29 Jan 2022 03:11:17 -0500
X-MC-Unique: FuVWE68HOc6vgCinoQVTyg-1
Received: by mail-pg1-f198.google.com with SMTP id
 27-20020a63135b000000b0036285f54b6aso4717344pgt.19
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jan 2022 00:11:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=HSiqpHC2F7MZ+jp51/naZ8daN+DMPf4P0m+aaZYxKSs=;
 b=7QEK5FTAHeXUSWjKLbAMVaLNt4gKkZLFGHqhYmmd+HOzrtH+OjhIZx58mxK9+qkMdg
 IGotFHW9erK9CmNsG9Wg1Y0lLlAZu/eLuofJs7IKFNCiBRsqta7WS9SFvtlRIZl7RBNY
 eFebcVbUFp8CoucJeRbqQGg/OPCFQYT2O/ffgr6Mr1aGeUAKeqpOCFa/I7dP4WLvoMX9
 XMp6dxvYX05jm2MdkOE9ZpAOB3m/uY8b4lkkSow+IJ6HVTqe5CoZvwMi2fPwFrAgS/hh
 J8dvjeUyPPVR/p46ZjJYQH68AMG3TkgUa0akes0CRpTImZZiRrNOW/yZG2t+cLGAqShU
 khaw==
X-Gm-Message-State: AOAM532iKBD5LrRIK+C7brObwzsdq7zV2myQkjcg37Mc/a2Ol71KkZmx
 0eoPKkFyniXlaWYkwbekWcYDoQxQGE/Whbel4lFAagfMde0cYNJSMfH+PCIRCVOBAvSQGKZn6Zl
 feEufhLbzlcSRllnPZp/2KAcUu1QPfUOIHLStdI+mPw==
X-Received: by 2002:a63:5306:: with SMTP id h6mr9418351pgb.298.1643443876567; 
 Sat, 29 Jan 2022 00:11:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwFmd/OpM+Vv3EjICOPmSXCzITs12WatKY/fCGWDguLXTEn2aIEjcShBUw3BWEkuYHF+Do2fw==
X-Received: by 2002:a63:5306:: with SMTP id h6mr9418317pgb.298.1643443876234; 
 Sat, 29 Jan 2022 00:11:16 -0800 (PST)
Received: from [10.72.12.112] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id f22sm10372225pfj.206.2022.01.29.00.11.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Jan 2022 00:11:15 -0800 (PST)
Message-ID: <660257ba-6445-3fb2-1da4-3b141e382191@redhat.com>
Date: Sat, 29 Jan 2022 16:11:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH 11/31] vhost: Add vhost_svq_valid_device_features to
 shadow vq
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-12-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220121202733.404989-12-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Gautam Dawar <gdawar@xilinx.com>,
 virtualization@lists.linux-foundation.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
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

CuWcqCAyMDIyLzEvMjIg5LiK5Y2INDoyNywgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IFRoaXMg
YWxsb3dzIFNWUSB0byBuZWdvdGlhdGUgZmVhdHVyZXMgd2l0aCB0aGUgZGV2aWNlLiBGb3IgdGhl
IGRldmljZSwKPiBTVlEgaXMgYSBkcml2ZXIuIFdoaWxlIHRoaXMgZnVuY3Rpb24gbmVlZHMgdG8g
YnlwYXNzIGFsbCBub24tdHJhbnNwb3J0Cj4gZmVhdHVyZXMsIGl0IG5lZWRzIHRvIGRpc2FibGUg
dGhlIGZlYXR1cmVzIHRoYXQgU1ZRIGRvZXMgbm90IHN1cHBvcnQKPiB3aGVuIGZvcndhcmRpbmcg
YnVmZmVycy4gVGhpcyBpbmNsdWRlcyBwYWNrZWQgdnEgbGF5b3V0LCBpbmRpcmVjdAo+IGRlc2Ny
aXB0b3JzIG9yIGV2ZW50IGlkeC4KPgo+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaW8gUMOpcmV6IDxl
cGVyZXptYUByZWRoYXQuY29tPgo+IC0tLQo+ICAgaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0
cXVldWUuaCB8ICAyICsrCj4gICBody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5jIHwg
NDQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gICBody92aXJ0aW8vdmhvc3QtdmRw
YS5jICAgICAgICAgICAgIHwgMjEgKysrKysrKysrKysrKysKPiAgIDMgZmlsZXMgY2hhbmdlZCwg
NjcgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ct
dmlydHF1ZXVlLmggYi9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5oCj4gaW5kZXgg
YzlmZmExMWZjZS4uZDk2Mzg2N2EwNCAxMDA2NDQKPiAtLS0gYS9ody92aXJ0aW8vdmhvc3Qtc2hh
ZG93LXZpcnRxdWV1ZS5oCj4gKysrIGIvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUu
aAo+IEBAIC0xNSw2ICsxNSw4IEBACj4gICAKPiAgIHR5cGVkZWYgc3RydWN0IFZob3N0U2hhZG93
VmlydHF1ZXVlIFZob3N0U2hhZG93VmlydHF1ZXVlOwo+ICAgCj4gK2Jvb2wgdmhvc3Rfc3ZxX3Zh
bGlkX2RldmljZV9mZWF0dXJlcyh1aW50NjRfdCAqZmVhdHVyZXMpOwo+ICsKPiAgIHZvaWQgdmhv
c3Rfc3ZxX3NldF9zdnFfa2lja19mZChWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqc3ZxLCBpbnQgc3Zx
X2tpY2tfZmQpOwo+ICAgdm9pZCB2aG9zdF9zdnFfc2V0X2d1ZXN0X2NhbGxfbm90aWZpZXIoVmhv
c3RTaGFkb3dWaXJ0cXVldWUgKnN2cSwgaW50IGNhbGxfZmQpOwo+ICAgY29uc3QgRXZlbnROb3Rp
ZmllciAqdmhvc3Rfc3ZxX2dldF9kZXZfa2lja19ub3RpZmllcigKPiBkaWZmIC0tZ2l0IGEvaHcv
dmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuYyBiL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ct
dmlydHF1ZXVlLmMKPiBpbmRleCA5NjE5YzgwODJjLi41MTQ0MmIzZGJmIDEwMDY0NAo+IC0tLSBh
L2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMKPiArKysgYi9ody92aXJ0aW8vdmhv
c3Qtc2hhZG93LXZpcnRxdWV1ZS5jCj4gQEAgLTQ1LDYgKzQ1LDUwIEBAIGNvbnN0IEV2ZW50Tm90
aWZpZXIgKnZob3N0X3N2cV9nZXRfZGV2X2tpY2tfbm90aWZpZXIoCj4gICAgICAgcmV0dXJuICZz
dnEtPmhkZXZfa2ljazsKPiAgIH0KPiAgIAo+ICsvKioKPiArICogVmFsaWRhdGUgdGhlIHRyYW5z
cG9ydCBkZXZpY2UgZmVhdHVyZXMgdGhhdCBTVlEgY2FuIHVzZSB3aXRoIHRoZSBkZXZpY2UKPiAr
ICoKPiArICogQGRldl9mZWF0dXJlcyAgVGhlIGRldmljZSBmZWF0dXJlcy4gSWYgc3VjY2Vzcywg
dGhlIGFja25vd2xlZGdlZCBmZWF0dXJlcy4KPiArICoKPiArICogUmV0dXJucyB0cnVlIGlmIFNW
USBjYW4gZ28gd2l0aCBhIHN1YnNldCBvZiB0aGVzZSwgZmFsc2Ugb3RoZXJ3aXNlLgo+ICsgKi8K
PiArYm9vbCB2aG9zdF9zdnFfdmFsaWRfZGV2aWNlX2ZlYXR1cmVzKHVpbnQ2NF90ICpkZXZfZmVh
dHVyZXMpCj4gK3sKPiArICAgIGJvb2wgciA9IHRydWU7Cj4gKwo+ICsgICAgZm9yICh1aW50NjRf
dCBiID0gVklSVElPX1RSQU5TUE9SVF9GX1NUQVJUOyBiIDw9IFZJUlRJT19UUkFOU1BPUlRfRl9F
TkQ7Cj4gKyAgICAgICAgICsrYikgewo+ICsgICAgICAgIHN3aXRjaCAoYikgewo+ICsgICAgICAg
IGNhc2UgVklSVElPX0ZfTk9USUZZX09OX0VNUFRZOgo+ICsgICAgICAgIGNhc2UgVklSVElPX0Zf
QU5ZX0xBWU9VVDoKPiArICAgICAgICAgICAgY29udGludWU7Cj4gKwo+ICsgICAgICAgIGNhc2Ug
VklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNOgo+ICsgICAgICAgICAgICAvKiBTVlEgZG9lcyBub3Qg
a25vdyBob3cgdG8gdHJhbnNsYXRlIGFkZHJlc3NlcyAqLwoKCkkgbWF5IG1pc3Mgc29tZXRoaW5n
IGJ1dCBhbnkgcmVhc29uIHRoYXQgd2UgbmVlZCB0byBkaXNhYmxlIApBQ0NFU1NfUExBVEZPUk0/
IEknZCBleHBlY3QgdGhlIHZyaW5nIGhlbHBlciB3ZSB1c2VkIGZvciBzaGFkb3cgCnZpcnRxdWV1
ZSBjYW4gZGVhbCB3aXRoIHZJT01NVSBwZXJmZWN0bHkuCgoKPiArICAgICAgICAgICAgaWYgKCpk
ZXZfZmVhdHVyZXMgJiBCSVRfVUxMKGIpKSB7Cj4gKyAgICAgICAgICAgICAgICBjbGVhcl9iaXQo
YiwgZGV2X2ZlYXR1cmVzKTsKPiArICAgICAgICAgICAgICAgIHIgPSBmYWxzZTsKPiArICAgICAg
ICAgICAgfQo+ICsgICAgICAgICAgICBicmVhazsKPiArCj4gKyAgICAgICAgY2FzZSBWSVJUSU9f
Rl9WRVJTSU9OXzE6CgoKSSBoYWQgdGhlIHNhbWUgcXVlc3Rpb24gaGVyZS4KClRoYW5rcwoKCj4g
KyAgICAgICAgICAgIC8qIFNWUSB0cnVzdCB0aGF0IGd1ZXN0IHZyaW5nIGlzIGxpdHRsZSBlbmRp
YW4gKi8KPiArICAgICAgICAgICAgaWYgKCEoKmRldl9mZWF0dXJlcyAmIEJJVF9VTEwoYikpKSB7
Cj4gKyAgICAgICAgICAgICAgICBzZXRfYml0KGIsIGRldl9mZWF0dXJlcyk7Cj4gKyAgICAgICAg
ICAgICAgICByID0gZmFsc2U7Cj4gKyAgICAgICAgICAgIH0KPiArICAgICAgICAgICAgY29udGlu
dWU7Cj4gKwo+ICsgICAgICAgIGRlZmF1bHQ6Cj4gKyAgICAgICAgICAgIGlmICgqZGV2X2ZlYXR1
cmVzICYgQklUX1VMTChiKSkgewo+ICsgICAgICAgICAgICAgICAgY2xlYXJfYml0KGIsIGRldl9m
ZWF0dXJlcyk7Cj4gKyAgICAgICAgICAgIH0KPiArICAgICAgICB9Cj4gKyAgICB9Cj4gKwo+ICsg
ICAgcmV0dXJuIHI7Cj4gK30KPiArCj4gICAvKiBGb3J3YXJkIGd1ZXN0IG5vdGlmaWNhdGlvbnMg
Ki8KPiAgIHN0YXRpYyB2b2lkIHZob3N0X2hhbmRsZV9ndWVzdF9raWNrKEV2ZW50Tm90aWZpZXIg
Km4pCj4gICB7Cj4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMgYi9ody92aXJ0
aW8vdmhvc3QtdmRwYS5jCj4gaW5kZXggYmRiNDVjODgwOC4uOWQ4MDFjZjkwNyAxMDA2NDQKPiAt
LS0gYS9ody92aXJ0aW8vdmhvc3QtdmRwYS5jCj4gKysrIGIvaHcvdmlydGlvL3Zob3N0LXZkcGEu
Ywo+IEBAIC04NTUsMTAgKzg1NSwzMSBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfaW5pdF9zdnEo
c3RydWN0IHZob3N0X2RldiAqaGRldiwgc3RydWN0IHZob3N0X3ZkcGEgKnYsCj4gICAgICAgc2l6
ZV90IG5fc3ZxcyA9IHYtPnNoYWRvd192cXNfZW5hYmxlZCA/IGhkZXYtPm52cXMgOiAwOwo+ICAg
ICAgIGdfYXV0b3B0cihHUHRyQXJyYXkpIHNoYWRvd192cXMgPSBnX3B0cl9hcnJheV9uZXdfZnVs
bChuX3N2cXMsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHZob3N0X3BzdnFfZnJlZSk7Cj4gKyAgICB1aW50NjRfdCBkZXZfZmVh
dHVyZXM7Cj4gKyAgICB1aW50NjRfdCBzdnFfZmVhdHVyZXM7Cj4gKyAgICBpbnQgcjsKPiArICAg
IGJvb2wgb2s7Cj4gKwo+ICAgICAgIGlmICghdi0+c2hhZG93X3Zxc19lbmFibGVkKSB7Cj4gICAg
ICAgICAgIGdvdG8gb3V0Owo+ICAgICAgIH0KPiAgIAo+ICsgICAgciA9IHZob3N0X3ZkcGFfZ2V0
X2ZlYXR1cmVzKGhkZXYsICZkZXZfZmVhdHVyZXMpOwo+ICsgICAgaWYgKHIgIT0gMCkgewo+ICsg
ICAgICAgIGVycm9yX3NldGcoZXJycCwgIkNhbid0IGdldCB2ZHBhIGRldmljZSBmZWF0dXJlcywg
Z290ICglZCkiLCByKTsKPiArICAgICAgICByZXR1cm4gcjsKPiArICAgIH0KPiArCj4gKyAgICBz
dnFfZmVhdHVyZXMgPSBkZXZfZmVhdHVyZXM7Cj4gKyAgICBvayA9IHZob3N0X3N2cV92YWxpZF9k
ZXZpY2VfZmVhdHVyZXMoJnN2cV9mZWF0dXJlcyk7Cj4gKyAgICBpZiAodW5saWtlbHkoIW9rKSkg
ewo+ICsgICAgICAgIGVycm9yX3NldGcoZXJycCwKPiArICAgICAgICAgICAgIlNWUSBJbnZhbGlk
IGRldmljZSBmZWF0dXJlIGZsYWdzLCBvZmZlcjogMHglIlBSSXg2NCIsIG9rOiAweCUiUFJJeDY0
LAo+ICsgICAgICAgICAgICBoZGV2LT5mZWF0dXJlcywgc3ZxX2ZlYXR1cmVzKTsKPiArICAgICAg
ICByZXR1cm4gLTE7Cj4gKyAgICB9Cj4gKwo+ICsgICAgc2hhZG93X3ZxcyA9IGdfcHRyX2FycmF5
X25ld19mdWxsKGhkZXYtPm52cXMsIHZob3N0X3BzdnFfZnJlZSk7Cj4gICAgICAgZm9yICh1bnNp
Z25lZCBuID0gMDsgbiA8IGhkZXYtPm52cXM7ICsrbikgewo+ICAgICAgICAgICBWaG9zdFNoYWRv
d1ZpcnRxdWV1ZSAqc3ZxID0gdmhvc3Rfc3ZxX25ldygpOwo+ICAgCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
