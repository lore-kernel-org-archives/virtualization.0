Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23ABC433EF
	for <virtualization@archiver.kernel.org>; Mon, 28 Feb 2022 08:17:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4FC9A605EA;
	Mon, 28 Feb 2022 08:17:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5kwx8SDGX8bx; Mon, 28 Feb 2022 08:17:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A4C736074C;
	Mon, 28 Feb 2022 08:17:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61670C0033;
	Mon, 28 Feb 2022 08:17:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42A14C001A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 08:17:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 30D8F6074C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 08:17:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zXPIiBvB5UsJ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 08:17:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D6798605EA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 08:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646036273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kcQX81TKsBPgI6ZQdBTCH95O8eyfaOBAupOXuKZxV+I=;
 b=Y8xwO7Ix5jczSQlbp3DJs/U4DYPOOFAYqVNOz9NvKLBBx+CB4wU0N9vvY9m3Umk4w2CXB3
 fFBbc9PjS61PwgWeH7hzqQJdUlDE8TmabIDcVHKpUjPhsLkSNp7ffM7XS4SfmYbS7u70Vf
 GJNqdy9ELVmuexrR8tmS5QjpXqTpXD8=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-130-g_8pphKPNvqRPD8PXDlaJw-1; Mon, 28 Feb 2022 03:17:50 -0500
X-MC-Unique: g_8pphKPNvqRPD8PXDlaJw-1
Received: by mail-pf1-f200.google.com with SMTP id
 n135-20020a628f8d000000b004e16d5bdcdbso7385890pfd.20
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 00:17:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=kcQX81TKsBPgI6ZQdBTCH95O8eyfaOBAupOXuKZxV+I=;
 b=3WAFfRqJTn+nb/BDEvbxpaNTiWrwiO08QAAs/Ft08rB77sEt3z9jgXPB8GWbszGQAN
 W0N0cCvScX86qYeIw7SXos7EXOzqaKIgX4aB6zIY5UzeUehtHEihx4f/pG/iMs2Aifam
 xksXU03C2lIVeN/j4fQnEMRAnub/kFaNSMmi/YgHqAK134lqKaxnPdJ+asUHQDxwbaep
 lEJxGJdixxjR8wmVNt6ts1Gpo7TNwqoZPZqLCDqIynXkqcsvfC9hVcB+8lf2he1QDU0a
 lY4LSusmTBKxj2EVg1GntsmKFgNV3+5P8khBzbpNEEKfMGQgLc/qNf1s8QC+1plk2Sun
 yeXw==
X-Gm-Message-State: AOAM532oeHCuvLS4zuhXIR88iyc5q84e4EG/dwrzrVnFXtul6k8CGB6f
 Cr7cbMY+K68dg+ou8X3qAT15uU21Zw/RFwr83rSQa6Q3DEOc4gVkXMKyajSpv/XBMJOZLkNxhPe
 ONFv0A6LL3SWBTog4sjpWqerjyDlsFXY/iHX7x1hjXQ==
X-Received: by 2002:a17:90b:34e:b0:1bd:16db:980e with SMTP id
 fh14-20020a17090b034e00b001bd16db980emr9907430pjb.132.1646036269292; 
 Mon, 28 Feb 2022 00:17:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJySJlNX76ptc/rztyRChRUymNl0t+JDOxQTq6TMo3C0MeY0mFWzNbxlCiWBmIMbFPUWWLxVIw==
X-Received: by 2002:a17:90b:34e:b0:1bd:16db:980e with SMTP id
 fh14-20020a17090b034e00b001bd16db980emr9907392pjb.132.1646036268999; 
 Mon, 28 Feb 2022 00:17:48 -0800 (PST)
Received: from [10.72.13.215] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 nn10-20020a17090b38ca00b001bc3a60b324sm9451560pjb.46.2022.02.28.00.17.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Feb 2022 00:17:48 -0800 (PST)
Message-ID: <19843d2b-dfe9-5e2d-4d3d-ca55456947dc@redhat.com>
Date: Mon, 28 Feb 2022 16:17:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [RFC PATCH v2 00/19] Control VQ support in vDPA
To: Gautam Dawar <gautam.dawar@xilinx.com>
References: <20201216064818.48239-1-jasowang@redhat.com>
 <20220224212314.1326-1-gdawar@xilinx.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220224212314.1326-1-gdawar@xilinx.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>,
 linux-kernel@vger.kernel.org, gdawar@xilinx.com,
 virtualization@lists.linux-foundation.org, martinh@xilinx.com,
 eperezma@redhat.com, hanand@xilinx.com, tanujk@xilinx.com,
 Si-Wei Liu <si-wei.liu@oracle.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 Longpeng <longpeng2@huawei.com>, Eli Cohen <elic@nvidia.com>
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

CuWcqCAyMDIyLzIvMjUg5LiK5Y2INToyMiwgR2F1dGFtIERhd2FyIOWGmemBkzoKPiBIaSBBbGw6
Cj4KPiBUaGlzIHNlcmllcyB0cmllcyB0byBhZGQgdGhlIHN1cHBvcnQgZm9yIGNvbnRyb2wgdmly
dHF1ZXVlIGluIHZEUEEuCj4KPiBDb250cm9sIHZpcnRxdWV1ZSBpcyB1c2VkIGJ5IG5ldHdvcmtp
bmcgZGV2aWNlIGZvciBhY2NlcHRpbmcgdmFyaW91cwo+IGNvbW1hbmRzIGZyb20gdGhlIGRyaXZl
ci4gSXQncyBhIG11c3QgdG8gc3VwcG9ydCBtdWx0aXF1ZXVlIGFuZCBvdGhlcgo+IGNvbmZpZ3Vy
YXRpb25zLgo+Cj4gV2hlbiB1c2VkIGJ5IHZob3N0LXZEUEEgYnVzIGRyaXZlciBmb3IgVk0sIHRo
ZSBjb250cm9sIHZpcnRxdWV1ZQo+IHNob3VsZCBiZSBzaGFkb3dlZCB2aWEgdXNlcnNwYWNlIFZN
TSAoUWVtdSkgaW5zdGVhZCBvZiBiZWluZyBhc3NpZ25lZAo+IGRpcmVjdGx5IHRvIEd1ZXN0LiBU
aGlzIGlzIGJlY2F1c2UgUWVtdSBuZWVkcyB0byBrbm93IHRoZSBkZXZpY2Ugc3RhdGUKPiBpbiBv
cmRlciB0byBzdGFydCBhbmQgc3RvcCBkZXZpY2UgY29ycmVjdGx5IChlLmcgZm9yIExpdmUgTWln
cmF0aW9uKS4KPgo+IFRoaXMgcmVxdWllcyB0byBpc29sYXRlIHRoZSBtZW1vcnkgbWFwcGluZyBm
b3IgY29udHJvbCB2aXJ0cXVldWUKPiBwcmVzZW50ZWQgYnkgdmhvc3QtdkRQQSB0byBwcmV2ZW50
IGd1ZXN0IGZyb20gYWNjZXNzaW5nIGl0IGRpcmVjdGx5Lgo+Cj4gVG8gYWNoaWV2ZSB0aGlzLCB2
RFBBIGludHJvZHVjZSB0d28gbmV3IGFic3RyYWN0aW9uczoKPgo+IC0gYWRkcmVzcyBzcGFjZTog
aWRlbnRpZmllZCB0aHJvdWdoIGFkZHJlc3Mgc3BhY2UgaWQgKEFTSUQpIGFuZCBhIHNldAo+ICAg
ICAgICAgICAgICAgICAgIG9mIG1lbW9yeSBtYXBwaW5nIGluIG1haW50YWluZWQKPiAtIHZpcnRx
dWV1ZSBncm91cDogdGhlIG1pbmltYWwgc2V0IG9mIHZpcnRxdWV1ZXMgdGhhdCBtdXN0IHNoYXJl
IGFuCj4gICAgICAgICAgICAgICAgICAgYWRkcmVzcyBzcGFjZQo+Cj4gRGV2aWNlIG5lZWRzIHRv
IGFkdmVydGlzZSB0aGUgZm9sbG93aW5nIGF0dHJpYnV0ZXMgdG8gdkRQQToKPgo+IC0gdGhlIG51
bWJlciBvZiBhZGRyZXNzIHNwYWNlcyBzdXBwb3J0ZWQgaW4gdGhlIGRldmljZQo+IC0gdGhlIG51
bWJlciBvZiB2aXJ0cXVldWUgZ3JvdXBzIHN1cHBvcnRlZCBpbiB0aGUgZGV2aWNlCj4gLSB0aGUg
bWFwcGluZ3MgZnJvbSBhIHNwZWNpZmljIHZpcnRxdWV1ZSB0byBpdHMgdmlydHF1ZXVlIGdyb3Vw
cwo+Cj4gVGhlIG1hcHBpbmdzIGZyb20gdmlydHF1ZXVlIHRvIHZpcnRxdWV1ZSBncm91cHMgaXMg
Zml4ZWQgYW5kIGRlZmluZWQKPiBieSB2RFBBIGRldmljZSBkcml2ZXIuIEUuZzoKPgo+IC0gRm9y
IHRoZSBkZXZpY2UgdGhhdCBoYXMgaGFyZHdhcmUgQVNJRCBzdXBwb3J0LCBpdCBjYW4gc2ltcGx5
Cj4gICAgYWR2ZXJ0aXNlIGEgcGVyIHZpcnRxdWV1ZSB2aXJ0cXVldWUgZ3JvdXAuCj4gLSBGb3Ig
dGhlIGRldmljZSB0aGF0IGRvZXMgbm90IGhhdmUgaGFyZHdhcmUgQVNJRCBzdXBwb3J0LCBpdCBj
YW4KPiAgICBzaW1wbHkgYWR2ZXJ0aXNlIGEgc2luZ2xlIHZpcnRxdWV1ZSBncm91cCB0aGF0IGNv
bnRhaW5zIGFsbAo+ICAgIHZpcnRxdWV1ZXMuIE9yIGlmIGl0IHdhbnRzIGEgc29mdHdhcmUgZW11
bGF0ZWQgY29udHJvbCB2aXJ0cXVldWUsIGl0Cj4gICAgY2FuIGFkdmVydGlzZSB0d28gdmlydHF1
ZXVlIGdyb3Vwcywgb25lIGlzIGZvciBjdnEsIGFub3RoZXIgaXMgZm9yCj4gICAgdGhlIHJlc3Qg
dmlydHF1ZXVlcy4KPgo+IHZEUEEgYWxzbyBhbGxvdyB0byBjaGFuZ2UgdGhlIGFzc29jaWF0aW9u
IGJldHdlZW4gdmlydHF1ZXVlIGdyb3VwIGFuZAo+IGFkZHJlc3Mgc3BhY2UuIFNvIGluIHRoZSBj
YXNlIG9mIGNvbnRyb2wgdmlydHF1ZXVlLCB1c2Vyc3BhY2UKPiBWTU0oUWVtdSkgbWF5IHVzZSBh
IGRlZGljYXRlZCBhZGRyZXNzIHNwYWNlIGZvciB0aGUgY29udHJvbCB2aXJ0cXVldWUKPiBncm91
cCB0byBpc29sYXRlIHRoZSBtZW1vcnkgbWFwcGluZy4KPgo+IFRoZSB2aG9zdC92aG9zdC12RFBB
IGlzIGFsc28gZXh0ZW5kIGZvciB0aGUgdXNlcnNwYWNlIHRvOgo+Cj4gLSBxdWVyeSB0aGUgbnVt
YmVyIG9mIHZpcnRxdWV1ZSBncm91cHMgYW5kIGFkZHJlc3Mgc3BhY2VzIHN1cHBvcnRlZCBieQo+
ICAgIHRoZSBkZXZpY2UKPiAtIHF1ZXJ5IHRoZSB2aXJ0cXVldWUgZ3JvdXAgZm9yIGEgc3BlY2lm
aWMgdmlydHF1ZXVlCj4gLSBhc3NvY2FpdGUgYSB2aXJ0cXVldWUgZ3JvdXAgd2l0aCBhbiBhZGRy
ZXNzIHNwYWNlCj4gLSBzZW5kIEFTSUQgYmFzZWQgSU9UTEIgY29tbWFuZHMKPgo+IFRoaXMgd2ls
bCBoZWxwIHVzZXJzcGFjZSBWTU0oUWVtdSkgdG8gZGV0ZWN0IHdoZXRoZXIgdGhlIGNvbnRyb2wg
dnEKPiBjb3VsZCBiZSBzdXBwb3J0ZWQgYW5kIGlzb2xhdGUgbWVtb3J5IG1hcHBpbmdzIG9mIGNv
bnRyb2wgdmlydHF1ZXVlCj4gZnJvbSB0aGUgb3RoZXJzLgo+Cj4gVG8gZGVtb25zdHJhdGUgdGhl
IHVzYWdlLCB2RFBBIHNpbXVsYXRvciBpcyBleHRlbmRlZCB0byBzdXBwb3J0Cj4gc2V0dGluZyBN
QUMgYWRkcmVzcyB2aWEgYSBlbXVsYXRlZCBjb250cm9sIHZpcnRxdWV1ZS4KPgo+IFBsZWFzZSBy
ZXZpZXcuCj4KPiBDaGFuZ2VzIHNpbmNlIHYxOgo+Cj4gLSBSZWJhc2VkIHRoZSB2MSBwYXRjaCBz
ZXJpZXMgb24gdmhvc3QgYnJhbmNoIG9mIE1TVCB2aG9zdCBnaXQgcmVwbwo+ICAgIGdpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9tc3Qvdmhvc3QuZ2l0L2xvZy8/aD12aG9z
dAo+IC0gVXBkYXRlcyB0byBhY2NvbW1vZGF0ZSB2ZHBhX3NpbSBjaGFuZ2VzIGZyb20gbW9ub2xp
dGhpYyBtb2R1bGUgaW4KPiAgICBrZXJuZWwgdXNlZCB2MSBwYXRjaCBzZXJpZXMgdG8gY3VycmVu
dCBtb2R1bGFyaXplZCBjbGFzcyAobmV0LCBibG9jaykKPiAgICBiYXNlZCBhcHByb2FjaC4KPiAt
IEFkZGVkIG5ldyBhdHRyaWJ1dGVzIChuZ3JvdXBzIGFuZCBuYXMpIHRvICJ2ZHBhc2ltX2Rldl9h
dHRyIiBhbmQKPiAgICBwcm9wYWdhdGVkIHRoZW0gZnJvbSB2ZHBhX3NpbV9uZXQgdG8gdmRwYV9z
aW0KPiAtIFdpZGVuZWQgdGhlIGRhdGEtdHlwZSBmb3IgImFzaWQiIG1lbWJlciBvZiB2aG9zdF9t
c2dfdjIgdG8gX191MzIKPiAgICB0byBhY2NvbW1vZGF0ZSBQQVNJRAoKClRoaXMgaXMgZ3JlYXQu
IFRoZW4gdGhlIHNlbWFudGljIG1hdGNoZXMgZXhhY3RseSB0aGUgUEFTSUQgcHJvcG9zYWwgaGVy
ZVsxXS4KCgo+IC0gRml4ZWQgdGhlIGJ1aWxkYm90IHdhcm5pbmdzCj4gLSBSZXNvbHZlZCBhbGwg
Y2hlY2twYXRjaC5wbCBlcnJvcnMgYW5kIHdhcm5pbmdzCj4gLSBUZXN0ZWQgYm90aCBjb250cm9s
IGFuZCBkYXRhcGF0aCB3aXRoIFhpbGlueCBTbWFydG5pYyBTTjEwMDAgc2VyaWVzCj4gICAgZGV2
aWNlIHVzaW5nIFFFTVUgaW1wbGVtZW50aW5nIHRoZSBTaGFkb3cgdmlydHF1ZXVlIGFuZCBzdXBw
b3J0IGZvcgo+ICAgIFZRIGdyb3VwcyBhbmQgQVNJRCBhdmFpbGFibGUgYXQ6Cj4gICAgZ2l0aHVi
LmNvbS9ldWdwZXJtYXIvcWVtdS9yZWxlYXNlcy90YWcvdmRwYV9zd19saXZlX21pZ3JhdGlvbi5k
JTJGCj4gICAgYXNpZF9ncm91cHMtdjEuZCUyRjAwCgoKT24gdG9wLCB3ZSBtYXkgZXh0ZW5kIHRo
ZSBuZXRsaW5rIHByb3RvY29sIHRvIHJlcG9ydCB0aGUgbWFwcGluZyBiZXR3ZWVuIAp2aXJ0cXVl
dWUgdG8gaXRzIGdyb3Vwcy4KCgpUaGFua3MKClsxXSAKaHR0cHM6Ly93d3cubWFpbC1hcmNoaXZl
LmNvbS92aXJ0aW8tZGV2QGxpc3RzLm9hc2lzLW9wZW4ub3JnL21zZzA4MDc3Lmh0bWwKCgo+Cj4g
Q2hhbmdlcyBzaW5jZSBSRkM6Cj4KPiAtIHR3ZWFrIHZob3N0IHVBUEkgZG9jdW1lbnRhdGlvbgo+
IC0gc3dpdGNoIHRvIHVzZSBkZXZpY2Ugc3BlY2lmaWMgSU9UTEIgcmVhbGx5IGluIHBhdGNoIDQK
PiAtIHR3ZWFrIHRoZSBjb21taXQgbG9nCj4gLSBmaXggdGhhdCBBU0lEIGluIHZob3N0IGlzIGNs
YWltZWQgdG8gYmUgMzIgYWN0dWFsbHkgYnV0IDE2Yml0Cj4gICAgYWN0dWFsbHkKPiAtIGZpeCB1
c2UgYWZ0ZXIgZnJlZSB3aGVuIHVzaW5nIEFTSUQgd2l0aCBJT1RMQiBiYXRjaGluZyByZXF1ZXN0
cwo+IC0gc3dpdGNoIHRvIHVzZSBTdGVmYW5vJ3MgcGF0Y2ggZm9yIGhhdmluZyBzZXBhcmF0ZWQg
aW92Cj4gLSByZW1vdmUgdW51c2VkICJ1c2VkX2FzIiB2YXJpYWJsZQo+IC0gZml4IHRoZSBpb3Rs
Yi9hc2lkIGNoZWNraW5nIGluIHZob3N0X3ZkcGFfdW5tYXAoKQo+Cj4gVGhhbmtzCj4KPiBHYXV0
YW0gRGF3YXIgKDE5KToKPiAgICB2aG9zdDogbW92ZSB0aGUgYmFja2VuZCBmZWF0dXJlIGJpdHMg
dG8gdmhvc3RfdHlwZXMuaAo+ICAgIHZpcnRpby12ZHBhOiBkb24ndCBzZXQgY2FsbGJhY2sgaWYg
dmlydGlvIGRvZXNuJ3QgbmVlZCBpdAo+ICAgIHZob3N0LXZkcGE6IHBhc3NpbmcgaW90bGIgdG8g
SU9NTVUgbWFwcGluZyBoZWxwZXJzCj4gICAgdmhvc3QtdmRwYTogc3dpdGNoIHRvIHVzZSB2aG9z
dC12ZHBhIHNwZWNpZmljIElPVExCCj4gICAgdmRwYTogaW50cm9kdWNlIHZpcnRxdWV1ZSBncm91
cHMKPiAgICB2ZHBhOiBtdWx0aXBsZSBhZGRyZXNzIHNwYWNlcyBzdXBwb3J0Cj4gICAgdmRwYTog
aW50cm9kdWNlIGNvbmZpZyBvcGVyYXRpb25zIGZvciBhc3NvY2lhdGluZyBBU0lEIHRvIGEgdmly
dHF1ZXVlCj4gICAgICBncm91cAo+ICAgIHZob3N0X2lvdGxiOiBzcGxpdCBvdXQgSU9UTEIgaW5p
dGlhbGl6YXRpb24KPiAgICB2aG9zdDogc3VwcG9ydCBBU0lEIGluIElPVExCIEFQSQo+ICAgIHZo
b3N0LXZkcGE6IGludHJvZHVjZSBhc2lkIGJhc2VkIElPVExCCj4gICAgdmhvc3QtdmRwYTogaW50
cm9kdWNlIHVBUEkgdG8gZ2V0IHRoZSBudW1iZXIgb2YgdmlydHF1ZXVlIGdyb3Vwcwo+ICAgIHZo
b3N0LXZkcGE6IGludHJvZHVjZSB1QVBJIHRvIGdldCB0aGUgbnVtYmVyIG9mIGFkZHJlc3Mgc3Bh
Y2VzCj4gICAgdmhvc3QtdmRwYTogdUFQSSB0byBnZXQgdmlydHF1ZXVlIGdyb3VwIGlkCj4gICAg
dmhvc3QtdmRwYTogaW50cm9kdWNlIHVBUEkgdG8gc2V0IGdyb3VwIEFTSUQKPiAgICB2aG9zdC12
ZHBhOiBzdXBwb3J0IEFTSUQgYmFzZWQgSU9UTEIgQVBJCj4gICAgdmRwYV9zaW06IGFkdmVydGlz
ZSBWSVJUSU9fTkVUX0ZfTVRVCj4gICAgdmRwYV9zaW06IGZhY3RvciBvdXQgYnVmZmVyIGNvbXBs
ZXRpb24gbG9naWMKPiAgICB2ZHBhX3NpbTogZmlsdGVyIGRlc3RpbmF0aW9uIG1hYyBhZGRyZXNz
Cj4gICAgdmRwYXNpbTogY29udHJvbCB2aXJ0cXVldWUgc3VwcG9ydAo+Cj4gICBkcml2ZXJzL3Zk
cGEvaWZjdmYvaWZjdmZfbWFpbi5jICAgICAgfCAgIDggKy0KPiAgIGRyaXZlcnMvdmRwYS9tbHg1
L25ldC9tbHg1X3ZuZXQuYyAgICB8ICAxMSArLQo+ICAgZHJpdmVycy92ZHBhL3ZkcGEuYyAgICAg
ICAgICAgICAgICAgIHwgICA1ICsKPiAgIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5j
ICAgICB8IDEwMCArKysrKysrKy0tCj4gICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0u
aCAgICAgfCAgIDMgKwo+ICAgZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX25ldC5jIHwg
MTY5ICsrKysrKysrKysrKystLS0tCj4gICBkcml2ZXJzL3Zob3N0L2lvdGxiLmMgICAgICAgICAg
ICAgICAgfCAgMjMgKystCj4gICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyAgICAgICAgICAgICAgICAg
fCAyNzIgKysrKysrKysrKysrKysrKysrKysrLS0tLS0tCj4gICBkcml2ZXJzL3Zob3N0L3Zob3N0
LmMgICAgICAgICAgICAgICAgfCAgMjMgKystCj4gICBkcml2ZXJzL3Zob3N0L3Zob3N0LmggICAg
ICAgICAgICAgICAgfCAgIDQgKy0KPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMgICAg
ICAgICB8ICAgMiArLQo+ICAgaW5jbHVkZS9saW51eC92ZHBhLmggICAgICAgICAgICAgICAgIHwg
IDQ2ICsrKystCj4gICBpbmNsdWRlL2xpbnV4L3Zob3N0X2lvdGxiLmggICAgICAgICAgfCAgIDIg
Kwo+ICAgaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0LmggICAgICAgICAgIHwgIDI1ICsrLQo+ICAg
aW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0X3R5cGVzLmggICAgIHwgIDExICstCj4gICAxNSBmaWxl
cyBjaGFuZ2VkLCA1NjYgaW5zZXJ0aW9ucygrKSwgMTM4IGRlbGV0aW9ucygtKQo+CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
