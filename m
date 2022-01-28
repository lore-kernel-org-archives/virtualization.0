Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF0CC433EF
	for <virtualization@archiver.kernel.org>; Fri, 28 Jan 2022 06:29:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0D5C340328;
	Fri, 28 Jan 2022 06:29:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wJ68IIMYN9XK; Fri, 28 Jan 2022 06:29:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 19E11400EA;
	Fri, 28 Jan 2022 06:29:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6D0FC0011;
	Fri, 28 Jan 2022 06:29:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D0B8C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 06:29:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8B29E41622
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 06:29:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q-Owl1OL3vsZ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 06:29:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BBBC34161F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 06:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643351379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QzASgu/9tVvpAjpB/sAVevHkStxn/AU6SXOCX+rhuXs=;
 b=JvanKWnZEGoABdC8/kehU2wpEGZWO9QxenqLXQD+yMg7QhyDlbVroM2kKjqBOnuS6vVbn3
 uT7P2/qR3541/AeZp5RE0KymZ7rLAfvrOmckPhOoE7Lg7RARv1vqC74nbpkcWv07gzXLoG
 zhBqwUndOAjRX5XJ9wrjScgM64rXLwU=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-wTTqc6AzPOqQSkhcsp-ysw-1; Fri, 28 Jan 2022 01:29:38 -0500
X-MC-Unique: wTTqc6AzPOqQSkhcsp-ysw-1
Received: by mail-pf1-f197.google.com with SMTP id
 v3-20020a622f03000000b004c412d02ca3so2992181pfv.20
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 22:29:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=QzASgu/9tVvpAjpB/sAVevHkStxn/AU6SXOCX+rhuXs=;
 b=JR/xATUfpRkHqT528FxIuRYPs4BP7efIZFNobe1Nr78xDGwMC9u7xXtei4kE1tGss6
 dYZX6/fObBCNEbbHAN8xs+RU1HOnCoZi33XFD7yek9nBPwtrXZK6Q44/Vv6jwxe76L1g
 /jZVG1/gOMxInHj5jlxNuJIbs6sryzzri55k9pQqpqTYu9+T6IJ9gz1T4rOETL80zT2F
 0C2AaCAklzjHfn6kPo59IJCLLDt7RxsUQOnoiED0jPqZjG1x0x8O5dszN8EgQjuWcxZ1
 LKBz2NIJj6U2F0qF/RhLcQPJGA4LbQwmBIhyKw7N8oBwfdXTmjDwFXQUDivtXm3yzC86
 TsuQ==
X-Gm-Message-State: AOAM530vwlJI/ous4yoaPIMCQDvFzkjfG31tiGSFdpU0STL6WDofLHkf
 gKS5zfuEirJuWFR9s+BrJ5U6yg3kOAavFj39ICtpCe5yJ+HzSdTRAF8dnc+1c+4KtloP64f+JWK
 KDhtcuShyDyv8PTfDN1swvnxIdNUX3dg70pIbxI6gLg==
X-Received: by 2002:a63:5157:: with SMTP id r23mr5544400pgl.196.1643351375487; 
 Thu, 27 Jan 2022 22:29:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyg8cMNPN1yIay8L94kdky5sBwl7+uDaHIfgrajAejrf6mAoVPm6yiDA4LOajE4NRCrF3SWmQ==
X-Received: by 2002:a63:5157:: with SMTP id r23mr5544369pgl.196.1643351375233; 
 Thu, 27 Jan 2022 22:29:35 -0800 (PST)
Received: from [10.72.13.185] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j18sm8153040pfj.13.2022.01.27.22.29.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jan 2022 22:29:34 -0800 (PST)
Message-ID: <e10a7631-f1f9-5597-dd74-0f5301a68e27@redhat.com>
Date: Fri, 28 Jan 2022 14:29:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH 04/31] vdpa: Add vhost_svq_set_svq_kick_fd
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-5-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220121202733.404989-5-eperezma@redhat.com>
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
ZnVuY3Rpb24gYWxsb3dzIHRoZSB2aG9zdC12ZHBhIGJhY2tlbmQgdG8gb3ZlcnJpZGUga2lja19m
ZC4KPgo+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29t
Pgo+IC0tLQo+ICAgaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuaCB8ICAxICsKPiAg
IGh3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMgfCA0NSArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysKPiAgIDIgZmlsZXMgY2hhbmdlZCwgNDYgaW5zZXJ0aW9ucygrKQo+Cj4g
ZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmggYi9ody92aXJ0
aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5oCj4gaW5kZXggNDAwZWZmZDlmMi4uYTU2ZWNmYzA5
ZCAxMDA2NDQKPiAtLS0gYS9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5oCj4gKysr
IGIvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuaAo+IEBAIC0xNSw2ICsxNSw3IEBA
Cj4gICAKPiAgIHR5cGVkZWYgc3RydWN0IFZob3N0U2hhZG93VmlydHF1ZXVlIFZob3N0U2hhZG93
VmlydHF1ZXVlOwo+ICAgCj4gK3ZvaWQgdmhvc3Rfc3ZxX3NldF9zdnFfa2lja19mZChWaG9zdFNo
YWRvd1ZpcnRxdWV1ZSAqc3ZxLCBpbnQgc3ZxX2tpY2tfZmQpOwo+ICAgY29uc3QgRXZlbnROb3Rp
ZmllciAqdmhvc3Rfc3ZxX2dldF9kZXZfa2lja19ub3RpZmllcigKPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBWaG9zdFNoYWRvd1ZpcnRxdWV1
ZSAqc3ZxKTsKPiAgIAo+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRx
dWV1ZS5jIGIvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuYwo+IGluZGV4IGJkODcx
MTAwNzMuLjIxNTM0YmM5NGQgMTAwNjQ0Cj4gLS0tIGEvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12
aXJ0cXVldWUuYwo+ICsrKyBiL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMKPiBA
QCAtMTEsNiArMTEsNyBAQAo+ICAgI2luY2x1ZGUgImh3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmly
dHF1ZXVlLmgiCj4gICAKPiAgICNpbmNsdWRlICJxZW11L2Vycm9yLXJlcG9ydC5oIgo+ICsjaW5j
bHVkZSAicWVtdS9tYWluLWxvb3AuaCIKPiAgIAo+ICAgLyogU2hhZG93IHZpcnRxdWV1ZSB0byBy
ZWxheSBub3RpZmljYXRpb25zICovCj4gICB0eXBlZGVmIHN0cnVjdCBWaG9zdFNoYWRvd1ZpcnRx
dWV1ZSB7Cj4gQEAgLTE4LDggKzE5LDIwIEBAIHR5cGVkZWYgc3RydWN0IFZob3N0U2hhZG93Vmly
dHF1ZXVlIHsKPiAgICAgICBFdmVudE5vdGlmaWVyIGhkZXZfa2ljazsKPiAgICAgICAvKiBTaGFk
b3cgY2FsbCBub3RpZmllciwgc2VudCB0byB2aG9zdCAqLwo+ICAgICAgIEV2ZW50Tm90aWZpZXIg
aGRldl9jYWxsOwo+ICsKPiArICAgIC8qCj4gKyAgICAgKiBCb3Jyb3dlZCB2aXJ0cXVldWUncyBn
dWVzdCB0byBob3N0IG5vdGlmaWVyLgo+ICsgICAgICogVG8gYm9ycm93IGl0IGluIHRoaXMgZXZl
bnQgbm90aWZpZXIgYWxsb3dzIHRvIHJlZ2lzdGVyIG9uIHRoZSBldmVudAo+ICsgICAgICogbG9v
cCBhbmQgYWNjZXNzIHRoZSBhc3NvY2lhdGVkIHNoYWRvdyB2aXJ0cXVldWUgZWFzaWx5LiBJZiB3
ZSB1c2UgdGhlCj4gKyAgICAgKiBWaXJ0UXVldWUsIHdlIGRvbid0IGhhdmUgYW4gZWFzeSB3YXkg
dG8gcmV0cmlldmUgaXQuCj4gKyAgICAgKgo+ICsgICAgICogU28gc2hhZG93IHZpcnRxdWV1ZSBt
dXN0IG5vdCBjbGVhbiBpdCwgb3Igd2Ugd291bGQgbG9zZSBWaXJ0UXVldWUgb25lLgo+ICsgICAg
ICovCj4gKyAgICBFdmVudE5vdGlmaWVyIHN2cV9raWNrOwo+ICAgfSBWaG9zdFNoYWRvd1ZpcnRx
dWV1ZTsKPiAgIAo+ICsjZGVmaW5lIElOVkFMSURfU1ZRX0tJQ0tfRkQgLTEKPiArCj4gICAvKioK
PiAgICAqIFRoZSBub3RpZmllciB0aGF0IFNWUSB3aWxsIHVzZSB0byBub3RpZnkgdGhlIGRldmlj
ZS4KPiAgICAqLwo+IEBAIC0yOSw2ICs0MiwzNSBAQCBjb25zdCBFdmVudE5vdGlmaWVyICp2aG9z
dF9zdnFfZ2V0X2Rldl9raWNrX25vdGlmaWVyKAo+ICAgICAgIHJldHVybiAmc3ZxLT5oZGV2X2tp
Y2s7Cj4gICB9Cj4gICAKPiArLyoqCj4gKyAqIFNldCBhIG5ldyBmaWxlIGRlc2NyaXB0b3IgZm9y
IHRoZSBndWVzdCB0byBraWNrIFNWUSBhbmQgbm90aWZ5IGZvciBhdmFpbAo+ICsgKgo+ICsgKiBA
c3ZxICAgICAgICAgIFRoZSBzdnEKPiArICogQHN2cV9raWNrX2ZkICBUaGUgbmV3IHN2cSBraWNr
IGZkCj4gKyAqLwo+ICt2b2lkIHZob3N0X3N2cV9zZXRfc3ZxX2tpY2tfZmQoVmhvc3RTaGFkb3dW
aXJ0cXVldWUgKnN2cSwgaW50IHN2cV9raWNrX2ZkKQo+ICt7Cj4gKyAgICBFdmVudE5vdGlmaWVy
IHRtcDsKPiArICAgIGJvb2wgY2hlY2tfb2xkID0gSU5WQUxJRF9TVlFfS0lDS19GRCAhPQo+ICsg
ICAgICAgICAgICAgICAgICAgICBldmVudF9ub3RpZmllcl9nZXRfZmQoJnN2cS0+c3ZxX2tpY2sp
Owo+ICsKPiArICAgIGlmIChjaGVja19vbGQpIHsKPiArICAgICAgICBldmVudF9ub3RpZmllcl9z
ZXRfaGFuZGxlcigmc3ZxLT5zdnFfa2ljaywgTlVMTCk7Cj4gKyAgICAgICAgZXZlbnRfbm90aWZp
ZXJfaW5pdF9mZCgmdG1wLCBldmVudF9ub3RpZmllcl9nZXRfZmQoJnN2cS0+c3ZxX2tpY2spKTsK
PiArICAgIH0KCgpJdCBsb29rcyB0byBtZSB3ZSBkb24ndCBkbyBzaW1pbGFyIHRoaW5ncyBpbiB2
aG9zdC1uZXQuIEFueSByZWFzb24gZm9yIApjYXJpbmcgYWJvdXQgdGhlIG9sZCBzdnFfa2ljaz8K
Cgo+ICsKPiArICAgIC8qCj4gKyAgICAgKiBldmVudF9ub3RpZmllcl9zZXRfaGFuZGxlciBhbHJl
YWR5IGNoZWNrcyBmb3IgZ3Vlc3QncyBub3RpZmljYXRpb25zIGlmCj4gKyAgICAgKiB0aGV5IGFy
cml2ZSB0byB0aGUgbmV3IGZpbGUgZGVzY3JpcHRvciBpbiB0aGUgc3dpdGNoLCBzbyB0aGVyZSBp
cyBubwo+ICsgICAgICogbmVlZCB0byBleHBsaWNpdGVseSBjaGVjayBmb3IgdGhlbS4KPiArICAg
ICAqLwo+ICsgICAgZXZlbnRfbm90aWZpZXJfaW5pdF9mZCgmc3ZxLT5zdnFfa2ljaywgc3ZxX2tp
Y2tfZmQpOwo+ICsKPiArICAgIGlmICghY2hlY2tfb2xkIHx8IGV2ZW50X25vdGlmaWVyX3Rlc3Rf
YW5kX2NsZWFyKCZ0bXApKSB7Cj4gKyAgICAgICAgZXZlbnRfbm90aWZpZXJfc2V0KCZzdnEtPmhk
ZXZfa2ljayk7CgoKQW55IHJlYXNvbiB3ZSBuZWVkIHRvIGtpY2sgdGhlIGRldmljZSBkaXJlY3Rs
eSBoZXJlPwoKVGhhbmtzCgoKPiArICAgIH0KPiArfQo+ICsKPiAgIC8qKgo+ICAgICogQ3JlYXRl
cyB2aG9zdCBzaGFkb3cgdmlydHF1ZXVlLCBhbmQgaW5zdHJ1Y3Qgdmhvc3QgZGV2aWNlIHRvIHVz
ZSB0aGUgc2hhZG93Cj4gICAgKiBtZXRob2RzIGFuZCBmaWxlIGRlc2NyaXB0b3JzLgo+IEBAIC01
Miw2ICs5NCw5IEBAIFZob3N0U2hhZG93VmlydHF1ZXVlICp2aG9zdF9zdnFfbmV3KHZvaWQpCj4g
ICAgICAgICAgIGdvdG8gZXJyX2luaXRfaGRldl9jYWxsOwo+ICAgICAgIH0KPiAgIAo+ICsgICAg
LyogUGxhY2Vob2xkZXIgZGVzY3JpcHRvciwgaXQgc2hvdWxkIGJlIGRlbGV0ZWQgYXQgc2V0X2tp
Y2tfZmQgKi8KPiArICAgIGV2ZW50X25vdGlmaWVyX2luaXRfZmQoJnN2cS0+c3ZxX2tpY2ssIElO
VkFMSURfU1ZRX0tJQ0tfRkQpOwo+ICsKPiAgICAgICByZXR1cm4gZ19zdGVhbF9wb2ludGVyKCZz
dnEpOwo+ICAgCj4gICBlcnJfaW5pdF9oZGV2X2NhbGw6CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
