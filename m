Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25C5C433EF
	for <virtualization@archiver.kernel.org>; Fri, 17 Jun 2022 01:15:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5A453400DD;
	Fri, 17 Jun 2022 01:15:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5A453400DD
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FnH3v602
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zDey1nAnKZ25; Fri, 17 Jun 2022 01:15:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E0FF340521;
	Fri, 17 Jun 2022 01:15:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E0FF340521
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B02A1C0032;
	Fri, 17 Jun 2022 01:15:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E81DC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 01:15:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 60D59401A0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 01:15:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 60D59401A0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L-yDDlGGrayn
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 01:15:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 66621400DD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 66621400DD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 01:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655428535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qj6jImPewXvPaBqVDCu6KZmly2mSua8Ga/tEmjDhDBg=;
 b=FnH3v602nXi05sqlCkppYZw3B+LsIwCQyrLfafiZMUJhR1z1aR+DqtOKogiDji3QFZn4g0
 vaP4JP8rT//IdQcCFudyGkdtrLEDoC6xAKbpkvYBFOQNZfgGPPngGEOmV/oOioe3x8ELXe
 Yhp/EKoMdzLuwT54whwPEnfvaAVluXA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-RidAi24dOea_S_en7DD30Q-1; Thu, 16 Jun 2022 21:15:32 -0400
X-MC-Unique: RidAi24dOea_S_en7DD30Q-1
Received: by mail-lf1-f72.google.com with SMTP id
 g40-20020a0565123ba800b004791450e602so1556222lfv.17
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Jun 2022 18:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qj6jImPewXvPaBqVDCu6KZmly2mSua8Ga/tEmjDhDBg=;
 b=vjLmR3Z5MAvve3NaWlgi7QXFj3fy3vHiIEeO9pdkDDernkRyfCWuV4/3h7mFFtbi8r
 wcNBtcP7NnKeiKhRUH8Bd8eO163q+7UMayhEr4Jdwc93atzP29a1hnwern/j0nIPjS8/
 aMEJoaAB9EjA7SmjjZK4WlJTb9G5gtQ8+aXTockOR6aCIlXTNxr/F05XS980TYsXQY/q
 5XD3oGLp547lF9YpkqKpeiUjUjG5X890oX0CxRjoF0pdRd5qOZBjMCGCWwJehMjUEcp+
 V94orsD2CHqp7h8oa8mq8hmd3QWMemlS8CPHkf+BdcPzTEw6u9CbWE7wnNPic/0Yoo7Y
 ppzw==
X-Gm-Message-State: AJIora/q1KHGMxSPZNjc4P283RQxSPBpJ8UKaCUZxATU4sIoneQnEVpz
 K4MXtIj7kYyj2ENR9Z5+YMxowpo0UVGyd6od7zgkOlCG/l7BLdvrkkTtN3Evjh32GYref7qGUhy
 eR1R+Sy8JRlwWpPX4ZTfjRJ9cIkxwLkz8I43lrazfrEvyR/A8DaLsCLSL2Q==
X-Received: by 2002:a05:6512:a8f:b0:479:63e5:d59f with SMTP id
 m15-20020a0565120a8f00b0047963e5d59fmr4266506lfu.124.1655428531119; 
 Thu, 16 Jun 2022 18:15:31 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tVLEwZlQ5b3n2hD9EvzjMdrwv7jEBRqw/ihfRAuZxBUVL8mY4ADtDpm6/g+7FS+TtENdDl8nkcM5M830HVPM4=
X-Received: by 2002:a05:6512:a8f:b0:479:63e5:d59f with SMTP id
 m15-20020a0565120a8f00b0047963e5d59fmr4266484lfu.124.1655428530874; Thu, 16
 Jun 2022 18:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220526124338.36247-1-eperezma@redhat.com>
 <PH0PR12MB54819C6C6DAF6572AEADC1AEDCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220527065442-mutt-send-email-mst@kernel.org>
 <CACGkMEubfv_OJOsJ_ROgei41Qx4mPO0Xz8rMVnO8aPFiEqr8rA@mail.gmail.com>
 <PH0PR12MB5481695930E7548BAAF1B0D9DCDC9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsSKF_MyLgFdzVROptS3PCcp1y865znLWgnzq9L7CpFVQ@mail.gmail.com>
 <PH0PR12MB5481CAA3F57892FF7F05B004DCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsJJL34iUYQMxHguOV2cQ7rts+hRG5Gp3XKCGuqNdnNQg@mail.gmail.com>
 <PH0PR12MB5481D099A324C91DAF01259BDCDE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEueG76L8H+F70D=T5kjK_+J68ARNQmQQo51rq3CfcOdRA@mail.gmail.com>
 <PH0PR12MB5481994AF05D3B4999EC1F0EDCAD9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtRTyymit=Zmwwcq0jNan-_C9p70vcLP0g7XmwQiOjUbw@mail.gmail.com>
 <PH0PR12MB548104990A5544C738A5A95BDCAC9@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB548104990A5544C738A5A95BDCAC9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 17 Jun 2022 09:15:19 +0800
Message-ID: <CACGkMEtytpnCdWdmSh-BuFGXt55DJ9dYxnbw7JQwMXi9bQ8fvQ@mail.gmail.com>
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
 Wu Zongyong <wuzongyong@linux.alibaba.com>,
 "pabloc@xilinx.com" <pabloc@xilinx.com>, Eli Cohen <elic@nvidia.com>,
 Zhang Min <zhang.min9@zte.com.cn>, "lulu@redhat.com" <lulu@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
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

T24gRnJpLCBKdW4gMTcsIDIwMjIgYXQgMzozNiBBTSBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRp
YS5jb20+IHdyb3RlOgo+Cj4KPiA+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+Cj4gPiBTZW50OiBUdWVzZGF5LCBKdW5lIDE0LCAyMDIyIDk6MjkgUE0KPiA+Cj4gPiBXZWxs
LCBpdCdzIGFuIGV4YW1wbGUgb2YgaG93IHZEUEEgaXMgaW1wbGVtZW50ZWQuIEkgdGhpbmsgd2Ug
YWdyZWUgdGhhdCBmb3IKPiA+IHZEUEEsIHZlbmRvcnMgaGF2ZSB0aGUgZmxleGliaWxpdHkgdG8g
aW1wbGVtZW50IHRoZWlyIHBlcmZlcnJhYmxlIGRhdGFwYXRoLgo+ID4KPiBZZXMgZm9yIHRoZSB2
ZHBhIGxldmVsIGFuZCBmb3IgdGhlIHZpcnRpbyBsZXZlbC4KPgo+ID4gPgo+ID4gPiBJIHJlbWVt
YmVyIGZldyBtb250aHMgYmFjaywgeW91IGFja2VkIGluIHRoZSB3ZWVrbHkgbWVldGluZyB0aGF0
IFRDIGhhcwo+ID4gYXBwcm92ZWQgdGhlIEFRIGRpcmVjdGlvbi4KPiA+ID4gQW5kIHdlIGFyZSBz
dGlsbCBpbiB0aGlzIGNpcmNsZSBvZiBkZWJhdGluZyB0aGUgQVEuCj4gPgo+ID4gSSB0aGluayBu
b3QuIEp1c3QgdG8gbWFrZSBzdXJlIHdlIGFyZSBvbiB0aGUgc2FtZSBwYWdlLCB0aGUgcHJvcG9z
YWwgaGVyZSBpcwo+ID4gZm9yIHZEUEEsIGFuZCBob3BlIGl0IGNhbiBwcm92aWRlIGZvcndhcmQg
Y29tcGF0aWJpbGl0eSB0byB2aXJ0aW8uIFNvIGluIHRoZQo+ID4gY29udGV4dCBvZiB2RFBBLCBh
ZG1pbiB2aXJ0cXVldWUgaXMgbm90IGEgbXVzdC4KPiBJbiBjb250ZXh0IG9mIHZkcGEgb3ZlciB2
aXJ0aW8sIGFuIGVmZmljaWVudCB0cmFuc3BvcnQgaW50ZXJmYWNlIGlzIG5lZWRlZC4KPiBJZiBB
USBpcyBub3QgbXVjaCBhbnkgb3RoZXIgaW50ZXJmYWNlIHN1Y2ggYXMgaHVuZHJlZHMgdG8gdGhv
dXNhbmRzIG9mIHJlZ2lzdGVycyBpcyBub3QgbXVzdCBlaXRoZXIuCj4KPiBBUSBpcyBvbmUgaW50
ZXJmYWNlIHByb3Bvc2VkIHdpdGggbXVsdGlwbGUgYmVuZWZpdHMuCj4gSSBoYXZlbuKAmXQgc2Vl
biBhbnkgb3RoZXIgYWx0ZXJuYXRpdmVzIHRoYXQgZGVsaXZlcnMgYWxsIHRoZSBiZW5lZml0cy4K
PiBPbmx5IG9uZSBJIGhhdmUgc2VlbiBpcyBzeW5jaHJvbm91cyBjb25maWcgcmVnaXN0ZXJzLgo+
Cj4gSWYgeW91IGxldCB2ZW5kb3JzIHByb2dyZXNzLCBoYW5kZnVsIG9mIHNlbnNpYmxlIGludGVy
ZmFjZXMgY2FuIGV4aXN0LCBlYWNoIHdpdGggZGlmZmVyZW50IGNoYXJhY3RlcmlzdGljcy4KPiBI
b3cgd291bGQgd2UgcHJvY2VlZCBmcm9tIGhlcmU/CgpJJ20gcHJldHR5IGZpbmUgd2l0aCBoYXZp
bmcgYWRtaW4gdmlydHF1ZXVlIGluIHRoZSB2aXJ0aW8gc3BlYy4gSWYgeW91CnJlbWVtYmVyLCBJ
J3ZlIGV2ZW4gc3VibWl0dGVkIGEgcHJvcG9zYWwgdG8gdXNlIGFkbWluIHZpcnRxdWV1ZSBhcyBh
CnRyYW5zcG9ydCBsYXN0IHllYXIuCgpMZXQncyBqdXN0IHByb2NlZWQgaW4gdGhlIHZpcnRpby1k
ZXYgbGlzdC4KClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
