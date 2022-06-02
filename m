Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE072C433EF
	for <virtualization@archiver.kernel.org>; Thu,  2 Jun 2022 02:03:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 872D540606;
	Thu,  2 Jun 2022 02:03:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FhzLOs2KxTT4; Thu,  2 Jun 2022 02:03:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EC053400D0;
	Thu,  2 Jun 2022 02:03:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBF87C0039;
	Thu,  2 Jun 2022 02:03:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CBE03C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 02:03:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9628341676
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 02:03:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4vtpEqxdrVQe
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 02:03:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E19B641610
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 02:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654135383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JbogCu4cCieqVdCMmZW/jFyVB+BvEMhJqOq5Ni57RGQ=;
 b=HGYDHGZ3MRk9eZzxRrztAqMSpSY9OguBiPO3I8whCdkRqFH0uo4LHtlbrneHDW17pZlOFx
 9pD+h+woxRWS55Hl8fINirAmOeBoYLxIuEIVwW5MaEh9MerkpdYCIFNdFqgB5vNtubzB/N
 89Zg5fvXDyvqhKBoSNls1xOHkbb36eM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335-sS9haIjMPayKoOTLoeYy2Q-1; Wed, 01 Jun 2022 22:03:02 -0400
X-MC-Unique: sS9haIjMPayKoOTLoeYy2Q-1
Received: by mail-lf1-f71.google.com with SMTP id
 p36-20020a05651213a400b004779d806c13so1784545lfa.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 01 Jun 2022 19:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JbogCu4cCieqVdCMmZW/jFyVB+BvEMhJqOq5Ni57RGQ=;
 b=CSgus4MnwBhVBr88wbKye5TQIQ7eEViy/mJzPBc2qh73JFRwlF5ZWMP9a3Tq7u+AnA
 YhZLWjqLzAVwzPDbcsQ2m4oOtrn2j86p1BRmjVpnFG/KQ/a4r5+iT9SV9D5RJk/IfjRd
 NAzApwVAulbMnhMrjf7+KgVhEikxB2ryuXO3LqUPBbmt1YYs6VMqB1Lc7gVTIIVgIdAL
 4L2vYHWqFkdzpddJMf3nrxGCXsdQbdaiQNQ6iheWPfNF9U5Oml7a+rqJeivBFX3MSz+2
 fr8/Kul9lecS9Rmu96+8p5k1/LOfucrr+DmaeJvKpI+xTpu92Zp76gfja8JgG2b382ec
 7WKw==
X-Gm-Message-State: AOAM531LwzdbLonAotri4IU2VHFnhaiRnVdUSC0fM/yRbWUYDKyyiaMB
 sxdPxyb/V2i5Gm48EBQMHIu3sj2fpzZIlJE7+nfla/LbMD6EGrgBYylO7kEpxWH4pBfuUOuaKHL
 vcH1JPRB+1talWreaKjE0eRYUg+hEqzJcvr0qbMSCjdmaIsQcv8Uy5N8+QQ==
X-Received: by 2002:a05:6512:c0e:b0:478:5a91:20bb with SMTP id
 z14-20020a0565120c0e00b004785a9120bbmr42956286lfu.587.1654135380314; 
 Wed, 01 Jun 2022 19:03:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqAQK+T/zKYKhW+h+wH5I2vGaLZi733+pOzkjBsFuyIWvHTvv6WoCBRWN4kHLMhSOqGrYwJ6/gQ9v1y+/MmWU=
X-Received: by 2002:a05:6512:c0e:b0:478:5a91:20bb with SMTP id
 z14-20020a0565120c0e00b004785a9120bbmr42956248lfu.587.1654135380074; Wed, 01
 Jun 2022 19:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220526124338.36247-1-eperezma@redhat.com>
 <PH0PR12MB54819C6C6DAF6572AEADC1AEDCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220527065442-mutt-send-email-mst@kernel.org>
 <CACGkMEubfv_OJOsJ_ROgei41Qx4mPO0Xz8rMVnO8aPFiEqr8rA@mail.gmail.com>
 <PH0PR12MB5481695930E7548BAAF1B0D9DCDC9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJaqyWe7YFM0anKLJvvRja-EJW5bwmb1gMGXnC62LVMKrSn3sw@mail.gmail.com>
 <PH0PR12MB5481DFD45D7B27A4E4783B8BDCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481DFD45D7B27A4E4783B8BDCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 2 Jun 2022 10:02:48 +0800
Message-ID: <CACGkMEs=wePpvKhmBPJnPX-sDwYkdHtV0i4GjmtQAwkvO9weaw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Implement vdpasim stop operation
To: Parav Pandit <parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "tanuj.kamde@amd.com" <tanuj.kamde@amd.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 "pabloc@xilinx.com" <pabloc@xilinx.com>, Eli Cohen <elic@nvidia.com>,
 Zhang Min <zhang.min9@zte.com.cn>, "lulu@redhat.com" <lulu@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
 "martinh@xilinx.com" <martinh@xilinx.com>,
 Xie Yongji <xieyongji@bytedance.com>, "dinang@xilinx.com" <dinang@xilinx.com>,
 "habetsm.xilinx@gmail.com" <habetsm.xilinx@gmail.com>,
 Longpeng <longpeng2@huawei.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ecree.xilinx@gmail.com" <ecree.xilinx@gmail.com>,
 "hanand@xilinx.com" <hanand@xilinx.com>,
 "martinpo@xilinx.com" <martinpo@xilinx.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>,
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

T24gVGh1LCBKdW4gMiwgMjAyMiBhdCAzOjMwIEFNIFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZpZGlh
LmNvbT4gd3JvdGU6Cj4KPgo+Cj4gPiBGcm9tOiBFdWdlbmlvIFBlcmV6IE1hcnRpbiA8ZXBlcmV6
bWFAcmVkaGF0LmNvbT4KPiA+IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSAxLCAyMDIyIDU6NTAgQU0K
PiA+Cj4gPiBPbiBUdWUsIE1heSAzMSwgMjAyMiBhdCAxMDoxOSBQTSBQYXJhdiBQYW5kaXQgPHBh
cmF2QG52aWRpYS5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPgo+ID4gPiA+IEZyb206IEphc29uIFdh
bmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4gPiA+ID4gU2VudDogU3VuZGF5LCBNYXkgMjksIDIw
MjIgMTE6MzkgUE0KPiA+ID4gPgo+ID4gPiA+IE9uIEZyaSwgTWF5IDI3LCAyMDIyIGF0IDY6NTYg
UE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4KPiA+IHdyb3RlOgo+ID4gPiA+
ID4KPiA+ID4gPiA+IE9uIFRodSwgTWF5IDI2LCAyMDIyIGF0IDEyOjU0OjMyUE0gKzAwMDAsIFBh
cmF2IFBhbmRpdCB3cm90ZToKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBG
cm9tOiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiA+ID4gPiA+ID4gPiBT
ZW50OiBUaHVyc2RheSwgTWF5IDI2LCAyMDIyIDg6NDQgQU0KPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiBJbXBsZW1lbnQgc3RvcCBvcGVyYXRpb24gZm9yIHZkcGFfc2ltIGRldmljZXMsIHNvIHZo
b3N0LXZkcGEKPiA+ID4gPiA+ID4gPiB3aWxsIG9mZmVyCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiB0aGF0IGJhY2tlbmQgZmVhdHVyZSBhbmQgdXNlcnNwYWNlIGNhbiBlZmZlY3RpdmVseSBz
dG9wIHRoZSBkZXZpY2UuCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+ID4gVGhpcyBpcyBhIG11c3QgYmVmb3JlIGdldCB2aXJ0cXVldWUgaW5kZXhl
cyAoYmFzZSkgZm9yIGxpdmUKPiA+ID4gPiA+ID4gPiBtaWdyYXRpb24sCj4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiBzaW5jZSB0aGUgZGV2aWNlIGNvdWxkIG1vZGlmeSB0aGVtIGFmdGVyIHVz
ZXJsYW5kIGdldHMgdGhlbS4KPiA+ID4gPiA+ID4gPiBUaGVyZSBhcmUKPiA+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+IGluZGl2aWR1YWwgd2F5cyB0byBwZXJmb3JtIHRoYXQgYWN0aW9uIGZvciBz
b21lIGRldmljZXMKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IChWSE9TVF9ORVRfU0VUX0JB
Q0tFTkQsIFZIT1NUX1ZTT0NLX1NFVF9SVU5OSU5HLCAuLi4pCj4gPiBidXQKPiA+ID4gPiB0aGVy
ZQo+ID4gPiA+ID4gPiA+IHdhcyBubwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gd2F5IHRv
IHBlcmZvcm0gaXQgZm9yIGFueSB2aG9zdCBkZXZpY2UgKGFuZCwgaW4gcGFydGljdWxhciwgdmhv
c3QtCj4gPiB2ZHBhKS4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiBBZnRlciB0aGUgcmV0dXJuIG9mIGlvY3RsIHdpdGggc3RvcCAhPSAwLCB0
aGUgZGV2aWNlIE1VU1QKPiA+ID4gPiA+ID4gPiBmaW5pc2ggYW55Cj4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiBwZW5kaW5nIG9wZXJhdGlvbnMgbGlrZSBpbiBmbGlnaHQgcmVxdWVzdHMuIEl0
IG11c3QgYWxzbwo+ID4gPiA+ID4gPiA+IHByZXNlcnZlIGFsbAo+ID4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4gdGhlIG5lY2Vzc2FyeSBzdGF0ZSAodGhlIHZpcnRxdWV1ZSB2cmluZyBiYXNlIHBs
dXMgdGhlCj4gPiA+ID4gPiA+ID4gcG9zc2libGUgZGV2aWNlCj4gPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gPiBzcGVjaWZpYyBzdGF0ZXMpIHRoYXQgaXMgcmVxdWlyZWQgZm9yIHJlc3RvcmluZyBp
biB0aGUgZnV0dXJlLgo+ID4gPiA+ID4gPiA+IFRoZQo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gZGV2aWNlIG11c3Qgbm90IGNoYW5nZSBpdHMgY29uZmlndXJhdGlvbiBhZnRlciB0aGF0IHBv
aW50Lgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+IEFmdGVyIHRoZSByZXR1cm4gb2YgaW9jdGwgd2l0aCBzdG9wID09IDAsIHRoZSBkZXZpY2Ug
Y2FuCj4gPiA+ID4gPiA+ID4gY29udGludWUKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IHBy
b2Nlc3NpbmcgYnVmZmVycyBhcyBsb25nIGFzIHR5cGljYWwgY29uZGl0aW9ucyBhcmUgbWV0ICh2
cQo+ID4gPiA+ID4gPiA+IGlzIGVuYWJsZWQsCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBE
UklWRVJfT0sgc3RhdHVzIGJpdCBpcyBlbmFibGVkLCBldGMpLgo+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiBKdXN0IHRvIGJlIGNsZWFyLCB3ZSBhcmUgYWRkaW5nIHZkcGEgbGV2ZWwgbmV3IGlvY3Rs
KCkgdGhhdAo+ID4gPiA+ID4gPiBkb2VzbuKAmXQgbWFwIHRvCj4gPiA+ID4gYW55IG1lY2hhbmlz
bSBpbiB0aGUgdmlydGlvIHNwZWMuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFdoeSBjYW4ndCB3
ZSB1c2UgdGhpcyBpb2N0bCgpIHRvIGluZGljYXRlIGRyaXZlciB0byBzdGFydC9zdG9wCj4gPiA+
ID4gPiA+IHRoZSBkZXZpY2UKPiA+ID4gPiBpbnN0ZWFkIG9mIGRyaXZpbmcgaXQgdGhyb3VnaCB0
aGUgZHJpdmVyX29rPwo+ID4gPiA+ID4gPiBUaGlzIGlzIGluIHRoZSBjb250ZXh0IG9mIG90aGVy
IGRpc2N1c3Npb24gd2UgaGFkIGluIHRoZSBMTSBzZXJpZXMuCj4gPiA+ID4gPgo+ID4gPiA+ID4g
SWYgdGhlcmUncyBzb21ldGhpbmcgaW4gdGhlIHNwZWMgdGhhdCBkb2VzIHRoaXMgdGhlbiBsZXQn
cyB1c2UgdGhhdC4KPiA+ID4gPgo+ID4gPiA+IEFjdHVhbGx5LCB3ZSB0cnkgdG8gcHJvcG9zZSBh
IGluZGVwZW5kZW50IGZlYXR1cmUgaGVyZToKPiA+ID4gPgo+ID4gPiA+IGh0dHBzOi8vbGlzdHMu
b2FzaXMtb3Blbi5vcmcvYXJjaGl2ZXMvdmlydGlvLWRldi8yMDIxMTEvbXNnMDAwMjAuaHRtCj4g
PiA+ID4gbAo+ID4gPiA+Cj4gPiA+IFRoaXMgd2lsbCBzdG9wIHRoZSBkZXZpY2UgZm9yIGFsbCB0
aGUgb3BlcmF0aW9ucy4KPiA+ID4gT25jZSB0aGUgZGV2aWNlIGlzIHN0b3BwZWQsIGl0cyBzdGF0
ZSBjYW5ub3QgYmUgcXVlcmllZCBmdXJ0aGVyIGFzIGRldmljZQo+ID4gd29uJ3QgcmVzcG9uZC4K
PiA+ID4gSXQgaGFzIGxpbWl0ZWQgdXNlIGNhc2UuCj4gPiA+IFdoYXQgd2UgbmVlZCBpcyB0byBz
dG9wIG5vbiBhZG1pbiBxdWV1ZSByZWxhdGVkIHBvcnRpb24gb2YgdGhlIGRldmljZS4KPiA+ID4K
PiA+Cj4gPiBTdGlsbCBkb24ndCBmb2xsb3cgdGhpcywgc29ycnkuCj4gT25jZSBhIGRldmljZSBp
dCBzdG9wcGVkIGl0cyBzdGF0ZSBldGMgY2Fubm90IGJlIHF1ZXJpZWQuCgpUaGlzIGlzIG5vdCB3
aGF0IGlzIHByb3Bvc2VkIGhlcmUuCgo+IGlmIHlvdSB3YW50IHRvIHN0b3AgYW5kIHN0aWxsIGFs
bG93IGNlcnRhaW4gb3BlcmF0aW9ucywgYSBiZXR0ZXIgc3BlYyBkZWZpbml0aW9uIGlzIG5lZWRl
ZCB0aGF0IHNheXMsCj4KPiBzdG9wIEEsIEIsIEMsIGJ1dCBhbGxvdyBELCBFLCBGLCBHLgo+IEEg
PSBzdG9wIENWUXMgYW5kIHNhdmUgaXRzIHN0YXRlIHNvbWV3aGVyZQo+IEIgPSBzdG9wIGRhdGEg
VlFzIGFuZCBzYXZlIGl0IHN0YXRlIHNvbWV3aGVyZQo+IEMgPSBzdG9wIGdlbmVyaWMgY29uZmln
IGludGVycnVwdAoKQWN0dWFsbHksIGl0J3MgdGhlIHN0b3Agb2YgdGhlIGNvbmZpZyBzcGFjZSBj
aGFuZ2UuCkFuZCB3aGF0IG1vcmUsIGFueSBndWVzdCB2aXNpYmxlIHN0YXRlIG11c3Qgbm90IGJl
IGNoYW5nZWQuCgo+Cj4gRCA9IHF1ZXJ5IHN0YXRlIG9mIG11bHRpcGxlIFZRcwo+IEUgPSBxdWVy
eSBkZXZpY2Ugc3RhdGlzdGljcyBhbmQgb3RoZXIgZWxlbWVudHMvb2JqZWN0cyBpbiBmdXR1cmUK
ClRoaXMgaXMgdGhlIGRldmljZSBzdGF0ZSBJIGJlbGlldmUuCgo+IEYgPSBzZXR1cC9jb25maWcv
cmVzdG9yZSBjZXJ0YWluIGZpZWxkcwoKVGhpcyBpcyB0aGUgcmV2ZXJzZSBvZiBEIGFuZCBFLCB0
aGF0IGlzIHNldHRpbmcgdGhlIHN0YXRlLgoKPiBHID0gcmVzdW1lIHRoZSBkZXZpY2UKPgoKVGhh
bmtzCgo+ID4KPiA+IEFkZGluZyB0aGUgYWRtaW4gdnEgdG8gdGhlIG1peCwgdGhpcyB3b3VsZCBz
dG9wIGEgZGV2aWNlIG9mIGEgZGV2aWNlIGdyb3VwLAo+ID4gYnV0IG5vdCB0aGUgd2hvbGUgdmly
dHF1ZXVlIGdyb3VwLiBJZiB0aGUgYWRtaW4gVlEgaXMgb2ZmZXJlZCBieSB0aGUgUEYKPiA+IChz
aW5jZSBpdCdzIG5vdCBleHBvc2VkIHRvIHRoZSBndWVzdCksIGl0IHdpbGwgY29udGludWUgYWNj
ZXB0aW5nIHJlcXVlc3RzIGFzCj4gPiBub3JtYWwuIElmIGl0J3MgZXhwb3NlZCBpbiB0aGUgVkYs
IEkgdGhpbmsgdGhlIGJlc3QgYmV0IGlzIHRvIHNoYWRvdyBpdCwgc2luY2UKPiA+IGd1ZXN0IGFu
ZCBob3N0IHJlcXVlc3RzIGNvdWxkIGNvbmZsaWN0Lgo+ID4KPiA+IFNpbmNlIHRoaXMgaXMgb2Zm
ZXJlZCB0aHJvdWdoIHZkcGEsIHRoZSBkZXZpY2UgYmFja2VuZCBkcml2ZXIgY2FuIHJvdXRlIGl0
IHRvCj4gPiB3aGF0ZXZlciBtZXRob2Qgd29ya3MgYmV0dGVyIGZvciB0aGUgaGFyZHdhcmUuIEZv
ciBleGFtcGxlLCB0byBzZW5kIGFuCj4gPiBhZG1pbiB2cSBjb21tYW5kIHRvIHRoZSBQRi4gVGhh
dCdzIHdoeSBpdCdzIGltcG9ydGFudCB0byBrZWVwIHRoZSBmZWF0dXJlCj4gPiBhcyBzZWxmLWNv
bnRhaW5lZCBhbmQgb3J0aG9nb25hbCB0byBvdGhlcnMgYXMgcG9zc2libGUuCj4gPgo+Cj4gSSBy
ZXBsaWVkIGluIG90aGVyIHRocmVhZCB0byBjb250aW51ZSB0aGVyZS4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
