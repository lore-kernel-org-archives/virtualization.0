Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7C0C00140
	for <virtualization@archiver.kernel.org>; Fri, 19 Aug 2022 00:56:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 066FA41BAF;
	Fri, 19 Aug 2022 00:56:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 066FA41BAF
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ec2XFyMX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ODsUzkK18gMp; Fri, 19 Aug 2022 00:56:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 24CC941B9E;
	Fri, 19 Aug 2022 00:56:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 24CC941B9E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8D38C0032;
	Fri, 19 Aug 2022 00:56:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CDD07C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 00:56:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A5A1560AD3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 00:56:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A5A1560AD3
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ec2XFyMX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u0Ozwy_DVFV5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 00:56:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C8F8F60AC1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C8F8F60AC1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 00:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660870579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WKb8wMv3kp7XDXlLqqFY9ANzF7bJt+tTfj6q5NOVelU=;
 b=ec2XFyMXYeBcjPdDJflfR1zjljUBRKeojH3/gPxkyYWlZZz8pCMHOTEV/MgrmFvd8cUJtu
 nA68CLZ9oKpoXZ/RKA/hIRuy3tKNeDCM4DnmtZIrZ59WHfDaDjtqZecRxnChMXMCEPJMk6
 htEFX8vt1hg7SATHW7rYn5sBUXqLKM8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-217-bMyg_N-KOdeBsEbAtTo_Ew-1; Thu, 18 Aug 2022 20:56:18 -0400
X-MC-Unique: bMyg_N-KOdeBsEbAtTo_Ew-1
Received: by mail-lf1-f69.google.com with SMTP id
 q10-20020a19f20a000000b0048d029a71d3so973031lfh.17
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 17:56:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
 bh=WKb8wMv3kp7XDXlLqqFY9ANzF7bJt+tTfj6q5NOVelU=;
 b=agZ3aurlEt3pQ/tC89EPjfVmi6GO27w7CgfYvs8PrWbCsj53vQb8d0i2V6QLO4kc8q
 AIfL83f81a4sYz04PkIySUUlNe/WJLyHIpMt7FFm9htqxGtBAPXp8E5LtbJCRyCfe3o/
 BLZy8X9WI/+cMugg78KVGgbG8pDNNL0Ti2he89Ppo2WW2c/rOpxoFfESDWobG4J8yPOW
 LM2QxwWUPGkTuF9BhSQF+8mNQBSPFAjbI3GBQ5FkxFCBIuevFsz60f4h6hwlHtLBIOsg
 nNSbZg2dCCDT1eeR0yHsDPsvS/FxSrBkGFPB6M0dbr5neCI2LXlPenyFmM65bxN2E3XR
 UpJw==
X-Gm-Message-State: ACgBeo2OM/mIuQ1Y4or6X0NcQz3lWKYd121FjIrBh/PXUyj85SFuK5hy
 3prbW/A2UNuO+CDoDU+Rb8xdnN7IcXdmfc4KHBE8+HHG1+Xi8GBDBwrtKI/mSkcMbv66nyj9QSd
 6FPdMhK7IdFP8qVsfE2S7Gn+XAIp+dNKFNnC9zaODpji4JY8cjjAoFsv/pw==
X-Received: by 2002:ac2:43b0:0:b0:48b:1eb:d1e5 with SMTP id
 t16-20020ac243b0000000b0048b01ebd1e5mr1802674lfl.641.1660870577031; 
 Thu, 18 Aug 2022 17:56:17 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7i0/dwaRBFTHT8A2/Jz8ujQitDss25BNCKH8nNf+19R4cWCFm5sm5DSkA6hOMvI0i7uaE60wq6AqnZvmyYw6M=
X-Received: by 2002:ac2:43b0:0:b0:48b:1eb:d1e5 with SMTP id
 t16-20020ac243b0000000b0048b01ebd1e5mr1802668lfl.641.1660870576846; Thu, 18
 Aug 2022 17:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220811135353.2549658-1-eperezma@redhat.com>
 <20220811135353.2549658-3-eperezma@redhat.com>
In-Reply-To: <20220811135353.2549658-3-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 19 Aug 2022 08:56:05 +0800
Message-ID: <CACGkMEsMbXyXY94dB2NW_uUK=sXQNd7LTRBgOQVE=zMzHA69Gw@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] vdpa: Remove wrong doc of VHOST_VDPA_SUSPEND ioctl
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Kamde, Tanuj" <tanuj.kamde@amd.com>, kvm <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>,
 Pablo Cascon Katchadourian <pabloc@xilinx.com>, Eli Cohen <elic@nvidia.com>,
 Zhang Min <zhang.min9@zte.com.cn>, Cindy Lu <lulu@redhat.com>, "Uminski,
 Piotr" <Piotr.Uminski@intel.com>,
 Martin Petrus Hubertus Habets <martinh@xilinx.com>,
 Xie Yongji <xieyongji@bytedance.com>, Dinan Gunawardena <dinang@xilinx.com>,
 Martin Habets <habetsm.xilinx@gmail.com>, Longpeng <longpeng2@huawei.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, Laurent Vivier <lvivier@redhat.com>,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 ecree.xilinx@gmail.com, Harpreet Singh Anand <hanand@xilinx.com>,
 Martin Porter <martinpo@xilinx.com>, "Dawar, Gautam" <gautam.dawar@amd.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Zhu Lingshan <lingshan.zhu@intel.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVGh1LCBBdWcgMTEsIDIwMjIgYXQgOTo1NCBQTSBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBJdCB3YXMgYSBsZWZ0b3ZlciBmcm9tIHByZXZpb3VzIHZl
cnNpb25zLgo+Cj4gU2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhh
dC5jb20+CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCj4gLS0t
Cj4gIGluY2x1ZGUvbGludXgvdmRwYS5oICAgICAgIHwgIDIgKy0KPiAgaW5jbHVkZS91YXBpL2xp
bnV4L3Zob3N0LmggfCAxNSArKysrKy0tLS0tLS0tLS0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvdmRwYS5oIGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPiBpbmRleCBkMjgyZjQ2NGQyZjEuLjZj
NGU2ZWE3ZjdlYiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+ICsrKyBiL2lu
Y2x1ZGUvbGludXgvdmRwYS5oCj4gQEAgLTIxOCw3ICsyMTgsNyBAQCBzdHJ1Y3QgdmRwYV9tYXBf
ZmlsZSB7Cj4gICAqIEByZXNldDogICAgICAgICAgICAgICAgICAgICBSZXNldCBkZXZpY2UKPiAg
ICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIEB2ZGV2OiB2ZHBhIGRldmljZQo+ICAgKiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgUmV0dXJucyBpbnRlZ2VyOiBzdWNjZXNzICgwKSBv
ciBlcnJvciAoPCAwKQo+IC0gKiBAc3VzcGVuZDogICAgICAgICAgICAgICAgICAgU3VzcGVuZCBv
ciByZXN1bWUgdGhlIGRldmljZSAob3B0aW9uYWwpCj4gKyAqIEBzdXNwZW5kOiAgICAgICAgICAg
ICAgICAgICBTdXNwZW5kIHRoZSBkZXZpY2UgKG9wdGlvbmFsKQo+ICAgKiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgQHZkZXY6IHZkcGEgZGV2aWNlCj4gICAqICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBSZXR1cm5zIGludGVnZXI6IHN1Y2Nlc3MgKDApIG9yIGVycm9yICg8IDApCj4g
ICAqIEBnZXRfY29uZmlnX3NpemU6ICAgICAgICAgICBHZXQgdGhlIHNpemUgb2YgdGhlIGNvbmZp
Z3VyYXRpb24gc3BhY2UgaW5jbHVkZXMKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4
L3Zob3N0LmggYi9pbmNsdWRlL3VhcGkvbGludXgvdmhvc3QuaAo+IGluZGV4IDZkOWY0NTE2MzE1
NS4uODlmY2IyYWZlNDcyIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC92aG9zdC5o
Cj4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0LmgKPiBAQCAtMTcxLDE3ICsxNzEsMTIg
QEAKPiAgI2RlZmluZSBWSE9TVF9WRFBBX1NFVF9HUk9VUF9BU0lEICAgICAgX0lPVyhWSE9TVF9W
SVJUSU8sIDB4N0MsIFwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBzdHJ1Y3Qgdmhvc3RfdnJpbmdfc3RhdGUpCj4KPiAtLyogU3VzcGVuZCBvciByZXN1bWUg
YSBkZXZpY2Ugc28gaXQgZG9lcyBub3QgcHJvY2VzcyB2aXJ0cXVldWUgcmVxdWVzdHMgYW55bW9y
ZQo+ICsvKiBTdXNwZW5kIGEgZGV2aWNlIHNvIGl0IGRvZXMgbm90IHByb2Nlc3MgdmlydHF1ZXVl
IHJlcXVlc3RzIGFueW1vcmUKPiAgICoKPiAtICogQWZ0ZXIgdGhlIHJldHVybiBvZiBpb2N0bCB3
aXRoIHN1c3BlbmQgIT0gMCwgdGhlIGRldmljZSBtdXN0IGZpbmlzaCBhbnkKPiAtICogcGVuZGlu
ZyBvcGVyYXRpb25zIGxpa2UgaW4gZmxpZ2h0IHJlcXVlc3RzLiBJdCBtdXN0IGFsc28gcHJlc2Vy
dmUgYWxsIHRoZQo+IC0gKiBuZWNlc3Nhcnkgc3RhdGUgKHRoZSB2aXJ0cXVldWUgdnJpbmcgYmFz
ZSBwbHVzIHRoZSBwb3NzaWJsZSBkZXZpY2Ugc3BlY2lmaWMKPiAtICogc3RhdGVzKSB0aGF0IGlz
IHJlcXVpcmVkIGZvciByZXN0b3JpbmcgaW4gdGhlIGZ1dHVyZS4gVGhlIGRldmljZSBtdXN0IG5v
dAo+IC0gKiBjaGFuZ2UgaXRzIGNvbmZpZ3VyYXRpb24gYWZ0ZXIgdGhhdCBwb2ludC4KPiAtICoK
PiAtICogQWZ0ZXIgdGhlIHJldHVybiBvZiBpb2N0bCB3aXRoIHN1c3BlbmQgPT0gMCwgdGhlIGRl
dmljZSBjYW4gY29udGludWUKPiAtICogcHJvY2Vzc2luZyBidWZmZXJzIGFzIGxvbmcgYXMgdHlw
aWNhbCBjb25kaXRpb25zIGFyZSBtZXQgKHZxIGlzIGVuYWJsZWQsCj4gLSAqIERSSVZFUl9PSyBz
dGF0dXMgYml0IGlzIGVuYWJsZWQsIGV0YykuCj4gKyAqIEFmdGVyIHRoZSByZXR1cm4gb2YgaW9j
dGwgdGhlIGRldmljZSBtdXN0IGZpbmlzaCBhbnkgcGVuZGluZyBvcGVyYXRpb25zLiBJdAo+ICsg
KiBtdXN0IGFsc28gcHJlc2VydmUgYWxsIHRoZSBuZWNlc3Nhcnkgc3RhdGUgKHRoZSB2aXJ0cXVl
dWUgdnJpbmcgYmFzZSBwbHVzCj4gKyAqIHRoZSBwb3NzaWJsZSBkZXZpY2Ugc3BlY2lmaWMgc3Rh
dGVzKSB0aGF0IGlzIHJlcXVpcmVkIGZvciByZXN0b3JpbmcgaW4gdGhlCj4gKyAqIGZ1dHVyZS4g
VGhlIGRldmljZSBtdXN0IG5vdCBjaGFuZ2UgaXRzIGNvbmZpZ3VyYXRpb24gYWZ0ZXIgdGhhdCBw
b2ludC4KPiAgICovCj4gICNkZWZpbmUgVkhPU1RfVkRQQV9TVVNQRU5EICAgICAgICAgICAgIF9J
T1coVkhPU1RfVklSVElPLCAweDdELCBpbnQpCj4KPiAtLQo+IDIuMzEuMQo+CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
