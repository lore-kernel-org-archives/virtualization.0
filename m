Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F825C433EF
	for <virtualization@archiver.kernel.org>; Wed, 25 May 2022 02:54:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ECD7B40145;
	Wed, 25 May 2022 02:54:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xMtoGK66U6UR; Wed, 25 May 2022 02:54:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6CE7640105;
	Wed, 25 May 2022 02:54:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A8FDC0032;
	Wed, 25 May 2022 02:54:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30BFAC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 02:54:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1011040145
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 02:54:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KthN9Ky6K0K7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 02:54:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1FCB240105
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 02:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653447275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L6n7+yQgn+nVFUYyJzAWXpzjroQrckSxh/1Ms4Uuyq4=;
 b=bsFfQwqwBZTULx/d4jQPmvurxeWczypazEBY8WzbkWI8xOtj4MYKcUQMpigUSPIBLy43t4
 ACQpQu7cH5p/HquIMwJJlkXgD+sJigE8woPhlvGguQFeD3joO3BTfSghHOHIkWPSEVs2jP
 jTpcv1+Q0s96X7IZLSjLx2ZOrVS0JXc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-ycsXqdfQNImgU5vFXmy97w-1; Tue, 24 May 2022 22:54:32 -0400
X-MC-Unique: ycsXqdfQNImgU5vFXmy97w-1
Received: by mail-lf1-f69.google.com with SMTP id
 h36-20020a0565123ca400b004786d543fdeso3854595lfv.20
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 19:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=L6n7+yQgn+nVFUYyJzAWXpzjroQrckSxh/1Ms4Uuyq4=;
 b=k1F8KHkg4gkPCNZSb6z1WRPNBGpdEDDXoITJtzZZ8vGviCdWcvtW+LMl/WjW8NgzGu
 XXJFLDvwsDdlzUZtoVRCSHHUtB1n2/nDORsZ8e1SZsXoLf+phU9aThbls6EV+mQjn7nJ
 Y/La0YEY/RZp0NnN74ihtfCfzXzJZXICXRFFRgMRFFbE/B7UOnbvbjouediW2uQ7Ax7n
 XXlPdEAaDOUtt+qqKCj/sNEhLQqpeGt1FA7T71n4VHam0pimkiZrJ6Hh/gFV5CG8G1iW
 r2h/+MStrxe4a8HOWoiKKeltcVtpeKY7tIbI74XF6RqKLIi+bE2wCiVEbgt+4ShQSfdY
 Psmg==
X-Gm-Message-State: AOAM531BMtwrNDNPAetHcB92eqzUnR1JYsMzAVl9eL4rDyC+SwihmO80
 0EAKO9BqyVHzG96dp+e87db8H26E4os8K/W2RWia+T1ZD0PpnnxOZr6HzotPHxlapN7+5bnlQMt
 omJvU6puleeEZPTclO3mHYDZI2ZwTDQeizwc3H6PlfwaHF5Sp6DUMmMV3Wg==
X-Received: by 2002:a2e:1651:0:b0:253:d7ce:22df with SMTP id
 17-20020a2e1651000000b00253d7ce22dfmr16348490ljw.315.1653447270767; 
 Tue, 24 May 2022 19:54:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIeIyQFHdGFnE6GT5C+d47WqLD+jsGOmC4iPh7DCf0Fyx5p+BGfhhylBc3/GXzoRqdQbk+uILqUmEN70ocZiY=
X-Received: by 2002:a2e:1651:0:b0:253:d7ce:22df with SMTP id
 17-20020a2e1651000000b00253d7ce22dfmr16348477ljw.315.1653447270564; Tue, 24
 May 2022 19:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220524170610.2255608-1-eperezma@redhat.com>
 <20220524170610.2255608-5-eperezma@redhat.com>
In-Reply-To: <20220524170610.2255608-5-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 25 May 2022 10:54:19 +0800
Message-ID: <CACGkMEvCzxy+1BX2FMs5CvsvVvd9oedtgXmpiyAZWZECPypRig@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] vdpa_sim: Implement stop vdpa op
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: tanuj.kamde@amd.com, kvm <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
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

T24gV2VkLCBNYXkgMjUsIDIwMjIgYXQgMTowNiBBTSBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBJbXBsZW1lbnQgc3RvcCBvcGVyYXRpb24gZm9yIHZkcGFf
c2ltIGRldmljZXMsIHNvIHZob3N0LXZkcGEgd2lsbCBvZmZlcgo+IHRoYXQgYmFja2VuZCBmZWF0
dXJlIGFuZCB1c2Vyc3BhY2UgY2FuIGVmZmVjdGl2ZWx5IHN0b3AgdGhlIGRldmljZS4KPgo+IFRo
aXMgaXMgYSBtdXN0IGJlZm9yZSBnZXQgdmlydHF1ZXVlIGluZGV4ZXMgKGJhc2UpIGZvciBsaXZl
IG1pZ3JhdGlvbiwKPiBzaW5jZSB0aGUgZGV2aWNlIGNvdWxkIG1vZGlmeSB0aGVtIGFmdGVyIHVz
ZXJsYW5kIGdldHMgdGhlbS4gVGhlcmUgYXJlCj4gaW5kaXZpZHVhbCB3YXlzIHRvIHBlcmZvcm0g
dGhhdCBhY3Rpb24gZm9yIHNvbWUgZGV2aWNlcwo+IChWSE9TVF9ORVRfU0VUX0JBQ0tFTkQsIFZI
T1NUX1ZTT0NLX1NFVF9SVU5OSU5HLCAuLi4pIGJ1dCB0aGVyZSB3YXMgbm8KPiB3YXkgdG8gcGVy
Zm9ybSBpdCBmb3IgYW55IHZob3N0IGRldmljZSAoYW5kLCBpbiBwYXJ0aWN1bGFyLCB2aG9zdC12
ZHBhKS4KPgo+IEFmdGVyIHRoZSByZXR1cm4gb2YgaW9jdGwgd2l0aCBzdG9wICE9IDAsIHRoZSBk
ZXZpY2UgTVVTVCBmaW5pc2ggYW55Cj4gcGVuZGluZyBvcGVyYXRpb25zIGxpa2UgaW4gZmxpZ2h0
IHJlcXVlc3RzLiBJdCBtdXN0IGFsc28gcHJlc2VydmUgYWxsCj4gdGhlIG5lY2Vzc2FyeSBzdGF0
ZSAodGhlIHZpcnRxdWV1ZSB2cmluZyBiYXNlIHBsdXMgdGhlIHBvc3NpYmxlIGRldmljZQo+IHNw
ZWNpZmljIHN0YXRlcykgdGhhdCBpcyByZXF1aXJlZCBmb3IgcmVzdG9yaW5nIGluIHRoZSBmdXR1
cmUuIFRoZQo+IGRldmljZSBtdXN0IG5vdCBjaGFuZ2UgaXRzIGNvbmZpZ3VyYXRpb24gYWZ0ZXIg
dGhhdCBwb2ludC4KPgo+IEFmdGVyIHRoZSByZXR1cm4gb2YgaW9jdGwgd2l0aCBzdG9wID09IDAs
IHRoZSBkZXZpY2UgY2FuIGNvbnRpbnVlCj4gcHJvY2Vzc2luZyBidWZmZXJzIGFzIGxvbmcgYXMg
dHlwaWNhbCBjb25kaXRpb25zIGFyZSBtZXQgKHZxIGlzIGVuYWJsZWQsCj4gRFJJVkVSX09LIHN0
YXR1cyBiaXQgaXMgZW5hYmxlZCwgZXRjKS4KPgo+IEluIHRoZSBmdXR1cmUsIHdlIHdpbGwgcHJv
dmlkZSBmZWF0dXJlcyBzaW1pbGFyIHRvCj4gVkhPU1RfVVNFUl9HRVRfSU5GTElHSFRfRkQgc28g
dGhlIGRldmljZSBjYW4gc2F2ZSBwZW5kaW5nIG9wZXJhdGlvbnMuCj4KPiBTaWduZWQtb2ZmLWJ5
OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiAtLS0KPiAgZHJpdmVycy92
ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMgICAgIHwgMjEgKysrKysrKysrKysrKysrKysrKysrCj4g
IGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5oICAgICB8ICAxICsKPiAgZHJpdmVycy92
ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX2Jsay5jIHwgIDMgKysrCj4gIGRyaXZlcnMvdmRwYS92ZHBh
X3NpbS92ZHBhX3NpbV9uZXQuYyB8ICAzICsrKwo+ICA0IGZpbGVzIGNoYW5nZWQsIDI4IGluc2Vy
dGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0u
YyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4gaW5kZXggNTBkNzIxMDcyYmVi
Li4wNTE1Y2YzMTRiZWQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFf
c2ltLmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+IEBAIC0xMDcs
NiArMTA3LDcgQEAgc3RhdGljIHZvaWQgdmRwYXNpbV9kb19yZXNldChzdHJ1Y3QgdmRwYXNpbSAq
dmRwYXNpbSkKPiAgICAgICAgIGZvciAoaSA9IDA7IGkgPCB2ZHBhc2ltLT5kZXZfYXR0ci5uYXM7
IGkrKykKPiAgICAgICAgICAgICAgICAgdmhvc3RfaW90bGJfcmVzZXQoJnZkcGFzaW0tPmlvbW11
W2ldKTsKPgo+ICsgICAgICAgdmRwYXNpbS0+cnVubmluZyA9IHRydWU7Cj4gICAgICAgICBzcGlu
X3VubG9jaygmdmRwYXNpbS0+aW9tbXVfbG9jayk7Cj4KPiAgICAgICAgIHZkcGFzaW0tPmZlYXR1
cmVzID0gMDsKPiBAQCAtNTA1LDYgKzUwNiwyNCBAQCBzdGF0aWMgaW50IHZkcGFzaW1fcmVzZXQo
c3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhKQo+ICAgICAgICAgcmV0dXJuIDA7Cj4gIH0KPgo+ICtz
dGF0aWMgaW50IHZkcGFzaW1fc3RvcChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEsIGJvb2wgc3Rv
cCkKPiArewo+ICsgICAgICAgc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0gPSB2ZHBhX3RvX3NpbSh2
ZHBhKTsKPiArICAgICAgIGludCBpOwo+ICsKPiArICAgICAgIHNwaW5fbG9jaygmdmRwYXNpbS0+
bG9jayk7Cj4gKyAgICAgICB2ZHBhc2ltLT5ydW5uaW5nID0gIXN0b3A7Cj4gKyAgICAgICBpZiAo
dmRwYXNpbS0+cnVubmluZykgewo+ICsgICAgICAgICAgICAgICAvKiBDaGVjayBmb3IgbWlzc2Vk
IGJ1ZmZlcnMgKi8KPiArICAgICAgICAgICAgICAgZm9yIChpID0gMDsgaSA8IHZkcGFzaW0tPmRl
dl9hdHRyLm52cXM7ICsraSkKPiArICAgICAgICAgICAgICAgICAgICAgICB2ZHBhc2ltX2tpY2tf
dnEodmRwYSwgaSk7Cj4gKwo+ICsgICAgICAgfQo+ICsgICAgICAgc3Bpbl91bmxvY2soJnZkcGFz
aW0tPmxvY2spOwo+ICsKPiArICAgICAgIHJldHVybiAwOwo+ICt9Cj4gKwo+ICBzdGF0aWMgc2l6
ZV90IHZkcGFzaW1fZ2V0X2NvbmZpZ19zaXplKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSkKPiAg
ewo+ICAgICAgICAgc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0gPSB2ZHBhX3RvX3NpbSh2ZHBhKTsK
PiBAQCAtNjk0LDYgKzcxMyw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3Bz
IHZkcGFzaW1fY29uZmlnX29wcyA9IHsKPiAgICAgICAgIC5nZXRfc3RhdHVzICAgICAgICAgICAg
ID0gdmRwYXNpbV9nZXRfc3RhdHVzLAo+ICAgICAgICAgLnNldF9zdGF0dXMgICAgICAgICAgICAg
PSB2ZHBhc2ltX3NldF9zdGF0dXMsCj4gICAgICAgICAucmVzZXQgICAgICAgICAgICAgICAgICA9
IHZkcGFzaW1fcmVzZXQsCj4gKyAgICAgICAuc3RvcCAgICAgICAgICAgICAgICAgICA9IHZkcGFz
aW1fc3RvcCwKPiAgICAgICAgIC5nZXRfY29uZmlnX3NpemUgICAgICAgID0gdmRwYXNpbV9nZXRf
Y29uZmlnX3NpemUsCj4gICAgICAgICAuZ2V0X2NvbmZpZyAgICAgICAgICAgICA9IHZkcGFzaW1f
Z2V0X2NvbmZpZywKPiAgICAgICAgIC5zZXRfY29uZmlnICAgICAgICAgICAgID0gdmRwYXNpbV9z
ZXRfY29uZmlnLAo+IEBAIC03MjYsNiArNzQ2LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2ZHBh
X2NvbmZpZ19vcHMgdmRwYXNpbV9iYXRjaF9jb25maWdfb3BzID0gewo+ICAgICAgICAgLmdldF9z
dGF0dXMgICAgICAgICAgICAgPSB2ZHBhc2ltX2dldF9zdGF0dXMsCj4gICAgICAgICAuc2V0X3N0
YXR1cyAgICAgICAgICAgICA9IHZkcGFzaW1fc2V0X3N0YXR1cywKPiAgICAgICAgIC5yZXNldCAg
ICAgICAgICAgICAgICAgID0gdmRwYXNpbV9yZXNldCwKPiArICAgICAgIC5zdG9wICAgICAgICAg
ICAgICAgICAgID0gdmRwYXNpbV9zdG9wLAo+ICAgICAgICAgLmdldF9jb25maWdfc2l6ZSAgICAg
ICAgPSB2ZHBhc2ltX2dldF9jb25maWdfc2l6ZSwKPiAgICAgICAgIC5nZXRfY29uZmlnICAgICAg
ICAgICAgID0gdmRwYXNpbV9nZXRfY29uZmlnLAo+ICAgICAgICAgLnNldF9jb25maWcgICAgICAg
ICAgICAgPSB2ZHBhc2ltX3NldF9jb25maWcsCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92
ZHBhX3NpbS92ZHBhX3NpbS5oIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmgKPiBp
bmRleCA2MjI3ODJlOTIyMzkuLjA2MTk4NmYzMDkxMSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zk
cGEvdmRwYV9zaW0vdmRwYV9zaW0uaAo+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBh
X3NpbS5oCj4gQEAgLTY2LDYgKzY2LDcgQEAgc3RydWN0IHZkcGFzaW0gewo+ICAgICAgICAgdTMy
IGdlbmVyYXRpb247Cj4gICAgICAgICB1NjQgZmVhdHVyZXM7Cj4gICAgICAgICB1MzIgZ3JvdXBz
Owo+ICsgICAgICAgYm9vbCBydW5uaW5nOwo+ICAgICAgICAgLyogc3BpbmxvY2sgdG8gc3luY2hy
b25pemUgaW9tbXUgdGFibGUgKi8KPiAgICAgICAgIHNwaW5sb2NrX3QgaW9tbXVfbG9jazsKPiAg
fTsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX2Jsay5jIGIv
ZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX2Jsay5jCj4gaW5kZXggNDJkNDAxZDQzOTEx
Li5iY2RiMTk4MmMzNzggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFf
c2ltX2Jsay5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX2Jsay5jCj4g
QEAgLTIwNCw2ICsyMDQsOSBAQCBzdGF0aWMgdm9pZCB2ZHBhc2ltX2Jsa193b3JrKHN0cnVjdCB3
b3JrX3N0cnVjdCAqd29yaykKPiAgICAgICAgIGlmICghKHZkcGFzaW0tPnN0YXR1cyAmIFZJUlRJ
T19DT05GSUdfU19EUklWRVJfT0spKQo+ICAgICAgICAgICAgICAgICBnb3RvIG91dDsKPgo+ICsg
ICAgICAgaWYgKCF2ZHBhc2ltLT5ydW5uaW5nKQo+ICsgICAgICAgICAgICAgICBnb3RvIG91dDsK
PiArCj4gICAgICAgICBmb3IgKGkgPSAwOyBpIDwgVkRQQVNJTV9CTEtfVlFfTlVNOyBpKyspIHsK
PiAgICAgICAgICAgICAgICAgc3RydWN0IHZkcGFzaW1fdmlydHF1ZXVlICp2cSA9ICZ2ZHBhc2lt
LT52cXNbaV07Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2lt
X25ldC5jIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX25ldC5jCj4gaW5kZXggNTEy
NTk3NmE0ZGY4Li44ODY0NDllODg1MDIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGFf
c2ltL3ZkcGFfc2ltX25ldC5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2lt
X25ldC5jCj4gQEAgLTE1NCw2ICsxNTQsOSBAQCBzdGF0aWMgdm9pZCB2ZHBhc2ltX25ldF93b3Jr
KHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKPgo+ICAgICAgICAgc3Bpbl9sb2NrKCZ2ZHBhc2lt
LT5sb2NrKTsKPgo+ICsgICAgICAgaWYgKCF2ZHBhc2ltLT5ydW5uaW5nKQo+ICsgICAgICAgICAg
ICAgICBnb3RvIG91dDsKPiArCgpEbyB3ZSBuZWVkIHRvIGNoZWNrIHZkcGFzaW0tPnJ1bm5pbmcg
aW4gdmRwYXNpbV9raWNrX3ZxKCk/CgpUaGFua3MKCj4gICAgICAgICBpZiAoISh2ZHBhc2ltLT5z
dGF0dXMgJiBWSVJUSU9fQ09ORklHX1NfRFJJVkVSX09LKSkKPiAgICAgICAgICAgICAgICAgZ290
byBvdXQ7Cj4KPiAtLQo+IDIuMjcuMAo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
