Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302A1C433EF
	for <virtualization@archiver.kernel.org>; Tue, 12 Jul 2022 08:04:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBE1C61100;
	Tue, 12 Jul 2022 08:04:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BBE1C61100
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bZoYJ2sT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0qOLk7dxKPV9; Tue, 12 Jul 2022 08:04:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3D56760C0B;
	Tue, 12 Jul 2022 08:04:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3D56760C0B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D861C0035;
	Tue, 12 Jul 2022 08:04:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 849BBC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 08:04:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5083A42221
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 08:04:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5083A42221
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bZoYJ2sT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RwKDJnq-Ipu5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 08:04:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 29D8E42220
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 29D8E42220
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 08:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657613077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zk3S2xAdR/7hGTN3JMUGrzoWncg4Rn0Aa+mjreKRU3I=;
 b=bZoYJ2sTqT4JUS0NwctzuTELgu4CD2qWiT5xGgF+bKi4U2PNRTiq5M5UwDRyDb8XIJ+Z2i
 TNJHfsa+9f1GeXsJ4DrxYu31hGvZEc4gO3qomYJ+wO/H9vn6RlnF2TUyqR9uwAUPs8O0G2
 wzFK1XcQR2TP2L+xHBjId439jbwanvs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-gxJ2pnq_OvCso2S1b3kPKw-1; Tue, 12 Jul 2022 04:04:36 -0400
X-MC-Unique: gxJ2pnq_OvCso2S1b3kPKw-1
Received: by mail-lf1-f69.google.com with SMTP id
 f29-20020a19dc5d000000b004811c8d1918so3264678lfj.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 01:04:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Zk3S2xAdR/7hGTN3JMUGrzoWncg4Rn0Aa+mjreKRU3I=;
 b=G1JH0j4luCLWzh1QUhqnWPiQrNfyPfU6fwKzy0uh3necRolpUZhOOUIBCvzVq6aDM/
 sCLyWctgTyYRE067s+YmQ0vvwbcPwwSssBarMlirKkSpbbM+2OSojFkSPTxOVLz8/G4R
 lnLKzxlvpD62D6uDGWG0bZRlFoUz3koh4ANHQiektQFr/JGFr+Ia/xHA+BAy39YUophc
 Tw9sUomeZGK0oO++KakfovSOsEyL9jf5GmMDPMqDY7ZGHIqb0aomtDUArRu+/SXFqlHF
 vVF8PXT259W66wAqmhNgtdPQ5ak8QfZ2IsXj4Q/23dYVc9JkI+WFJfqbxtSAH4T95Vvp
 niUQ==
X-Gm-Message-State: AJIora+Jl3Oc4+LXLAVfntq4klF2DQvZIWRZp8KSAM2/RyUoJcI7NCgk
 Ld/XiUkwc5VJAygcgZFp8z3BKsfkJyefyhqh8BaGqkd9DqTuolM9PAphBTlHFhm8z7EKtvdAbpO
 4XP6M4YrdCvkEKII+S9RqmSQKH8jIScKxN6TB0GnBGgM4F7dnSokLtrOe6A==
X-Received: by 2002:a05:6512:3b8e:b0:481:1a75:452 with SMTP id
 g14-20020a0565123b8e00b004811a750452mr15293725lfv.238.1657613075127; 
 Tue, 12 Jul 2022 01:04:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vFL+N9RzhXFr/ks5hqi5WjMGbUNrOhsaPrmrfRg/JxZpXDwQSu5M2XKsRZPR3L6Fkftxrqt8icOOXsoZFhCZE=
X-Received: by 2002:a05:6512:3b8e:b0:481:1a75:452 with SMTP id
 g14-20020a0565123b8e00b004811a750452mr15293702lfv.238.1657613074923; Tue, 12
 Jul 2022 01:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220623160738.632852-1-eperezma@redhat.com>
 <20220623160738.632852-2-eperezma@redhat.com>
 <CACGkMEv+yFLCzo-K7eSaVPJqLCa5SxfVCmB=piQ3+6R3=oDz-w@mail.gmail.com>
 <CAJaqyWcsesMV5DSs7sCrsJmZX=QED7p7UXa_7H=1UHfQTnKS6w@mail.gmail.com>
In-Reply-To: <CAJaqyWcsesMV5DSs7sCrsJmZX=QED7p7UXa_7H=1UHfQTnKS6w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Jul 2022 16:04:23 +0800
Message-ID: <CACGkMEsr=2LjU1-UDV1SF9vJPty2003YKORHZMSr1W-p9eNr+A@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] vdpa: Add suspend operation
To: Eugenio Perez Martin <eperezma@redhat.com>
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

T24gRnJpLCBKdWwgOCwgMjAyMiBhdCA3OjMxIFBNIEV1Z2VuaW8gUGVyZXogTWFydGluIDxlcGVy
ZXptYUByZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIFdlZCwgSnVuIDI5LCAyMDIyIGF0IDY6MTAg
QU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gRnJp
LCBKdW4gMjQsIDIwMjIgYXQgMTI6MDcgQU0gRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhh
dC5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPiBUaGlzIG9wZXJhdGlvbiBpcyBvcHRpb25hbDogSXQg
aXQncyBub3QgaW1wbGVtZW50ZWQsIGJhY2tlbmQgZmVhdHVyZSBiaXQKPiA+ID4gd2lsbCBub3Qg
YmUgZXhwb3NlZC4KPiA+Cj4gPiBBIHF1ZXN0aW9uLCBkbyB3ZSBhbGxvdyBzdXNwZW5kaW5nIGEg
ZGV2aWNlIHdpdGhvdXQgRFJJVkVSX09LPwo+ID4KPgo+IFRoYXQgc2hvdWxkIGJlIGludmFsaWQu
IEluIHBhcnRpY3VsYXIsIHZkcGFfc2ltIHdpbGwgcmVzdW1lIGluIHRoYXQKPiBjYXNlLCBidXQg
SSBndWVzcyBpdCB3b3VsZCBkZXBlbmQgb24gdGhlIGRldmljZS4KClllcywgYW5kIHRoYXQgd2ls
bCBtYXRjaCBvdXIgdmlydGlvIHNwZWMgcGF0Y2ggKFNUT1AgYml0KS4KCj4KPiBEbyB5b3UgdGhp
bmsgaXQgc2hvdWxkIGJlIGNvbnRyb2xsZWQgaW4gdGhlIHZkcGEgZnJvbnRlbmQgY29kZT8KClRo
ZSB2ZHBhIGJ1cyBzaG91bGQgdmFsaWRhdGUgdGhpcyBhdCBsZWFzdC4KClRoYW5rcwoKPgo+IFRo
YW5rcyEKPgo+ID4gVGhhbmtzCj4gPgo+ID4gPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbmlv
IFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiA+ID4gLS0tCj4gPiA+ICBpbmNsdWRlL2xp
bnV4L3ZkcGEuaCB8IDQgKysrKwo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KQo+ID4gPgo+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92ZHBhLmggYi9pbmNsdWRl
L2xpbnV4L3ZkcGEuaAo+ID4gPiBpbmRleCA3YjRhMTNkM2JkOTEuLmQyODJmNDY0ZDJmMSAxMDA2
NDQKPiA+ID4gLS0tIGEvaW5jbHVkZS9saW51eC92ZHBhLmgKPiA+ID4gKysrIGIvaW5jbHVkZS9s
aW51eC92ZHBhLmgKPiA+ID4gQEAgLTIxOCw2ICsyMTgsOSBAQCBzdHJ1Y3QgdmRwYV9tYXBfZmls
ZSB7Cj4gPiA+ICAgKiBAcmVzZXQ6ICAgICAgICAgICAgICAgICAgICAgUmVzZXQgZGV2aWNlCj4g
PiA+ICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQHZkZXY6IHZkcGEgZGV2aWNlCj4g
PiA+ICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUmV0dXJucyBpbnRlZ2VyOiBzdWNj
ZXNzICgwKSBvciBlcnJvciAoPCAwKQo+ID4gPiArICogQHN1c3BlbmQ6ICAgICAgICAgICAgICAg
ICAgIFN1c3BlbmQgb3IgcmVzdW1lIHRoZSBkZXZpY2UgKG9wdGlvbmFsKQo+ID4gPiArICogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIEB2ZGV2OiB2ZHBhIGRldmljZQo+ID4gPiArICogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFJldHVybnMgaW50ZWdlcjogc3VjY2VzcyAoMCkgb3Ig
ZXJyb3IgKDwgMCkKPiA+ID4gICAqIEBnZXRfY29uZmlnX3NpemU6ICAgICAgICAgICBHZXQgdGhl
IHNpemUgb2YgdGhlIGNvbmZpZ3VyYXRpb24gc3BhY2UgaW5jbHVkZXMKPiA+ID4gICAqICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBmaWVsZHMgdGhhdCBhcmUgY29uZGl0aW9uYWwgb24gZmVh
dHVyZSBiaXRzLgo+ID4gPiAgICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIEB2ZGV2OiB2
ZHBhIGRldmljZQo+ID4gPiBAQCAtMzE5LDYgKzMyMiw3IEBAIHN0cnVjdCB2ZHBhX2NvbmZpZ19v
cHMgewo+ID4gPiAgICAgICAgIHU4ICgqZ2V0X3N0YXR1cykoc3RydWN0IHZkcGFfZGV2aWNlICp2
ZGV2KTsKPiA+ID4gICAgICAgICB2b2lkICgqc2V0X3N0YXR1cykoc3RydWN0IHZkcGFfZGV2aWNl
ICp2ZGV2LCB1OCBzdGF0dXMpOwo+ID4gPiAgICAgICAgIGludCAoKnJlc2V0KShzdHJ1Y3QgdmRw
YV9kZXZpY2UgKnZkZXYpOwo+ID4gPiArICAgICAgIGludCAoKnN1c3BlbmQpKHN0cnVjdCB2ZHBh
X2RldmljZSAqdmRldik7Cj4gPiA+ICAgICAgICAgc2l6ZV90ICgqZ2V0X2NvbmZpZ19zaXplKShz
dHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpOwo+ID4gPiAgICAgICAgIHZvaWQgKCpnZXRfY29uZmln
KShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHVuc2lnbmVkIGludCBvZmZzZXQsCj4gPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKmJ1ZiwgdW5zaWduZWQgaW50IGxlbik7Cj4g
PiA+IC0tCj4gPiA+IDIuMzEuMQo+ID4gPgo+ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
