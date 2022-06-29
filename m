Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83429C433EF
	for <virtualization@archiver.kernel.org>; Wed, 29 Jun 2022 04:16:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 120CF40465;
	Wed, 29 Jun 2022 04:16:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 120CF40465
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FyCeTzy9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9FSJ7TGCluJT; Wed, 29 Jun 2022 04:16:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7E3E7402F6;
	Wed, 29 Jun 2022 04:16:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7E3E7402F6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FF5AC0039;
	Wed, 29 Jun 2022 04:16:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B8FBC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 04:16:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D9DDF833CD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 04:16:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D9DDF833CD
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FyCeTzy9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pfRdCOp8Upan
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 04:16:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0A1D582FDE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A1D582FDE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 04:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656476169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PtwcZuLsTm8Dg1uSD41ajc7r0fnpDwfXXB+rZRvhTko=;
 b=FyCeTzy9MIud46C17k26o0lvqcx5cFpJVPoLZktdtTnUbh0VZwmc1Zs+/5x4DGp/wnxT6P
 aSBSsIai1gluGAmkP0LOmVFh7JzOYQ12oWBlx29UnxtP6NB71EarF2yDpUfccbGU+ljjtd
 iR8CCgVlCBABVQ+BmOQxFv+CfhGiUo8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-538-DkGXiQXEPmKbEJ8hNb-vvw-1; Wed, 29 Jun 2022 00:16:08 -0400
X-MC-Unique: DkGXiQXEPmKbEJ8hNb-vvw-1
Received: by mail-lj1-f200.google.com with SMTP id
 x7-20020a05651c024700b002594efe50f0so1961382ljn.21
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 21:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PtwcZuLsTm8Dg1uSD41ajc7r0fnpDwfXXB+rZRvhTko=;
 b=mEVBcD3qx3e7aGX1dGqAj/opdbT9Rt/4OpcypJ5gKDfMQ4dqeH2cDCz+aWESL3iXLC
 RfzuCCnqYAFtvzNVhxX2t1KApQ3bju7WP/9zjg8RHehAWr2XnPihjIcGt1oWx/db8tXL
 lUmToe6Rju+VrQJ3Q0pMWWDWbBZ8NpI2kPIQUoYINwjhWtBz5YyrGI/f//+k8L9PiYYI
 ZqRp8ED4XuThIb3G8D7oUm+whrzjklAUXq/EeMEEYI6n381ibPOOdTyYoryzYgbwFzd0
 C6sxtJhhn+tiw2md5o2JvPWs33V7Q8jo1LSP+tdGAiGHaQrLH21Q6wQ/BRqiZxHU+jIC
 OjmA==
X-Gm-Message-State: AJIora+CoQ6a2V6AZl94Ll54TOQZCBoP0EiPViDxVTmKd4H6XZk+9hhM
 JJjK0iX9tybeev4xbdUKXfrkhg6TweNWuZ7O4l0eD3xlXMbrKt/wfOtJ/OW04Wv+9uCn68LlUzP
 OhqYgIgfd1xPp0s2zYaaKRexh+h09+Ijq/Dxk3Ys6gAN8UYmmYWGSUp/hiA==
X-Received: by 2002:a05:6512:22c3:b0:47f:704b:3820 with SMTP id
 g3-20020a05651222c300b0047f704b3820mr752420lfu.411.1656476166634; 
 Tue, 28 Jun 2022 21:16:06 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1upMFAw7enEFnGLqSFGGLIxAK2UAfb9LAQXHDG8zw5aYCyUArCflbvxul/RikhyXAcaaorbxWBe3MU1XUQAnHc=
X-Received: by 2002:a05:6512:22c3:b0:47f:704b:3820 with SMTP id
 g3-20020a05651222c300b0047f704b3820mr752395lfu.411.1656476166417; Tue, 28 Jun
 2022 21:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220623160738.632852-1-eperezma@redhat.com>
 <20220623160738.632852-4-eperezma@redhat.com>
In-Reply-To: <20220623160738.632852-4-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 29 Jun 2022 12:15:55 +0800
Message-ID: <CACGkMEt6YQvtyYwkYVxmZ01pZJK9PMFM2oPTVttPZ_kZDY-9Jw@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] vhost-vdpa: uAPI to suspend the device
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
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
 habetsm.xilinx@gmail.com, Longpeng <longpeng2@huawei.com>,
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

T24gRnJpLCBKdW4gMjQsIDIwMjIgYXQgMTI6MDggQU0gRXVnZW5pbyBQw6lyZXogPGVwZXJlem1h
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gVGhlIGlvY3RsIGFkZHMgc3VwcG9ydCBmb3Igc3VzcGVu
ZGluZyB0aGUgZGV2aWNlIGZyb20gdXNlcnNwYWNlLgo+Cj4gVGhpcyBpcyBhIG11c3QgYmVmb3Jl
IGdldHRpbmcgdmlydHF1ZXVlIGluZGV4ZXMgKGJhc2UpIGZvciBsaXZlIG1pZ3JhdGlvbiwKPiBz
aW5jZSB0aGUgZGV2aWNlIGNvdWxkIG1vZGlmeSB0aGVtIGFmdGVyIHVzZXJsYW5kIGdldHMgdGhl
bS4gVGhlcmUgYXJlCj4gaW5kaXZpZHVhbCB3YXlzIHRvIHBlcmZvcm0gdGhhdCBhY3Rpb24gZm9y
IHNvbWUgZGV2aWNlcwo+IChWSE9TVF9ORVRfU0VUX0JBQ0tFTkQsIFZIT1NUX1ZTT0NLX1NFVF9S
VU5OSU5HLCAuLi4pIGJ1dCB0aGVyZSB3YXMgbm8KPiB3YXkgdG8gcGVyZm9ybSBpdCBmb3IgYW55
IHZob3N0IGRldmljZSAoYW5kLCBpbiBwYXJ0aWN1bGFyLCB2aG9zdC12ZHBhKS4KPgo+IEFmdGVy
IGEgc3VjY2Vzc2Z1bCByZXR1cm4gb2YgdGhlIGlvY3RsIGNhbGwgdGhlIGRldmljZSBtdXN0IG5v
dCBwcm9jZXNzCj4gbW9yZSB2aXJ0cXVldWUgZGVzY3JpcHRvcnMuIFRoZSBkZXZpY2UgY2FuIGFu
c3dlciB0byByZWFkIG9yIHdyaXRlcyBvZgo+IGNvbmZpZyBmaWVsZHMgYXMgaWYgaXQgd2VyZSBu
b3Qgc3VzcGVuZGVkLiBJbiBwYXJ0aWN1bGFyLCB3cml0aW5nIHRvCj4gInF1ZXVlX2VuYWJsZSIg
d2l0aCBhIHZhbHVlIG9mIDEgd2lsbCBub3QgbWFrZSB0aGUgZGV2aWNlIHN0YXJ0Cj4gcHJvY2Vz
c2luZyBidWZmZXJzIG9mIHRoZSB2aXJ0cXVldWUuCj4KPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbmlv
IFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiAtLS0KPiAgZHJpdmVycy92aG9zdC92ZHBh
LmMgICAgICAgfCAxOSArKysrKysrKysrKysrKysrKysrCj4gIGluY2x1ZGUvdWFwaS9saW51eC92
aG9zdC5oIHwgMTQgKysrKysrKysrKysrKysKPiAgMiBmaWxlcyBjaGFuZ2VkLCAzMyBpbnNlcnRp
b25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zo
b3N0L3ZkcGEuYwo+IGluZGV4IDNkNjM2ZTE5MjA2MS4uN2ZhNjcxYWM0YmRmIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiBA
QCAtNDc4LDYgKzQ3OCwyMiBAQCBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX2dldF92cXNfY291bnQo
c3RydWN0IHZob3N0X3ZkcGEgKnYsIHUzMiBfX3VzZXIgKmFyZ3ApCj4gICAgICAgICByZXR1cm4g
MDsKPiAgfQo+Cj4gKy8qIEFmdGVyIGEgc3VjY2Vzc2Z1bCByZXR1cm4gb2YgaW9jdGwgdGhlIGRl
dmljZSBtdXN0IG5vdCBwcm9jZXNzIG1vcmUKPiArICogdmlydHF1ZXVlIGRlc2NyaXB0b3JzLiBU
aGUgZGV2aWNlIGNhbiBhbnN3ZXIgdG8gcmVhZCBvciB3cml0ZXMgb2YgY29uZmlnCj4gKyAqIGZp
ZWxkcyBhcyBpZiBpdCB3ZXJlIG5vdCBzdXNwZW5kZWQuIEluIHBhcnRpY3VsYXIsIHdyaXRpbmcg
dG8gInF1ZXVlX2VuYWJsZSIKPiArICogd2l0aCBhIHZhbHVlIG9mIDEgd2lsbCBub3QgbWFrZSB0
aGUgZGV2aWNlIHN0YXJ0IHByb2Nlc3NpbmcgYnVmZmVycy4KPiArICovCj4gK3N0YXRpYyBsb25n
IHZob3N0X3ZkcGFfc3VzcGVuZChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdikKPiArewo+ICsgICAgICAg
c3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhID0gdi0+dmRwYTsKPiArICAgICAgIGNvbnN0IHN0cnVj
dCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHZkcGEtPmNvbmZpZzsKPiArCj4gKyAgICAgICBpZiAo
IW9wcy0+c3VzcGVuZCkKPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FT1BOT1RTVVBQOwo+ICsK
PiArICAgICAgIHJldHVybiBvcHMtPnN1c3BlbmQodmRwYSk7Cj4gK30KPiArCj4gIHN0YXRpYyBs
b25nIHZob3N0X3ZkcGFfdnJpbmdfaW9jdGwoc3RydWN0IHZob3N0X3ZkcGEgKnYsIHVuc2lnbmVk
IGludCBjbWQsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkIF9fdXNl
ciAqYXJncCkKPiAgewo+IEBAIC02NTQsNiArNjcwLDkgQEAgc3RhdGljIGxvbmcgdmhvc3RfdmRw
YV91bmxvY2tlZF9pb2N0bChzdHJ1Y3QgZmlsZSAqZmlsZXAsCj4gICAgICAgICBjYXNlIFZIT1NU
X1ZEUEFfR0VUX1ZRU19DT1VOVDoKPiAgICAgICAgICAgICAgICAgciA9IHZob3N0X3ZkcGFfZ2V0
X3Zxc19jb3VudCh2LCBhcmdwKTsKPiAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gKyAgICAgICBj
YXNlIFZIT1NUX1ZEUEFfU1VTUEVORDoKPiArICAgICAgICAgICAgICAgciA9IHZob3N0X3ZkcGFf
c3VzcGVuZCh2KTsKPiArICAgICAgICAgICAgICAgYnJlYWs7Cj4gICAgICAgICBkZWZhdWx0Ogo+
ICAgICAgICAgICAgICAgICByID0gdmhvc3RfZGV2X2lvY3RsKCZ2LT52ZGV2LCBjbWQsIGFyZ3Ap
Owo+ICAgICAgICAgICAgICAgICBpZiAociA9PSAtRU5PSU9DVExDTUQpCj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvdWFwaS9saW51eC92aG9zdC5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0LmgK
PiBpbmRleCBjYWI2NDVkNGE2NDUuLjZkOWY0NTE2MzE1NSAxMDA2NDQKPiAtLS0gYS9pbmNsdWRl
L3VhcGkvbGludXgvdmhvc3QuaAo+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC92aG9zdC5oCj4g
QEAgLTE3MSw0ICsxNzEsMTggQEAKPiAgI2RlZmluZSBWSE9TVF9WRFBBX1NFVF9HUk9VUF9BU0lE
ICAgICAgX0lPVyhWSE9TVF9WSVJUSU8sIDB4N0MsIFwKPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgdmhvc3RfdnJpbmdfc3RhdGUpCj4KPiArLyog
U3VzcGVuZCBvciByZXN1bWUgYSBkZXZpY2Ugc28gaXQgZG9lcyBub3QgcHJvY2VzcyB2aXJ0cXVl
dWUgcmVxdWVzdHMgYW55bW9yZQo+ICsgKgo+ICsgKiBBZnRlciB0aGUgcmV0dXJuIG9mIGlvY3Rs
IHdpdGggc3VzcGVuZCAhPSAwLCB0aGUgZGV2aWNlIG11c3QgZmluaXNoIGFueQo+ICsgKiBwZW5k
aW5nIG9wZXJhdGlvbnMgbGlrZSBpbiBmbGlnaHQgcmVxdWVzdHMuCgpJJ20gbm90IHN1cmUgd2Ug
c2hvdWxkIG1hbmRhdGUgdGhlIGZsdXNoIGhlcmUuIFRoaXMgcHJvYmFibHkgYmxvY2tzIHVzCmZy
b20gYWRkaW5nIGluZmxpZ2h0IGRlc2NyaXB0b3IgcmVwb3J0aW5nIGluIHRoZSBmdXR1cmUuCgpU
aGFua3MKCkl0IG11c3QgYWxzbyBwcmVzZXJ2ZSBhbGwgdGhlCj4gKyAqIG5lY2Vzc2FyeSBzdGF0
ZSAodGhlIHZpcnRxdWV1ZSB2cmluZyBiYXNlIHBsdXMgdGhlIHBvc3NpYmxlIGRldmljZSBzcGVj
aWZpYwo+ICsgKiBzdGF0ZXMpIHRoYXQgaXMgcmVxdWlyZWQgZm9yIHJlc3RvcmluZyBpbiB0aGUg
ZnV0dXJlLiBUaGUgZGV2aWNlIG11c3Qgbm90Cj4gKyAqIGNoYW5nZSBpdHMgY29uZmlndXJhdGlv
biBhZnRlciB0aGF0IHBvaW50Lgo+ICsgKgo+ICsgKiBBZnRlciB0aGUgcmV0dXJuIG9mIGlvY3Rs
IHdpdGggc3VzcGVuZCA9PSAwLCB0aGUgZGV2aWNlIGNhbiBjb250aW51ZQo+ICsgKiBwcm9jZXNz
aW5nIGJ1ZmZlcnMgYXMgbG9uZyBhcyB0eXBpY2FsIGNvbmRpdGlvbnMgYXJlIG1ldCAodnEgaXMg
ZW5hYmxlZCwKPiArICogRFJJVkVSX09LIHN0YXR1cyBiaXQgaXMgZW5hYmxlZCwgZXRjKS4KPiAr
ICovCj4gKyNkZWZpbmUgVkhPU1RfVkRQQV9TVVNQRU5EICAgICAgICAgICAgIF9JT1coVkhPU1Rf
VklSVElPLCAweDdELCBpbnQpCj4gKwo+ICAjZW5kaWYKPiAtLQo+IDIuMzEuMQo+CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
