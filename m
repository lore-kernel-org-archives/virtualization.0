Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46917C32774
	for <virtualization@archiver.kernel.org>; Fri, 19 Aug 2022 00:57:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CAC3241BDD;
	Fri, 19 Aug 2022 00:57:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CAC3241BDD
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i3PgQyoD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nYcQDHhEb7vj; Fri, 19 Aug 2022 00:57:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ED9C441BD3;
	Fri, 19 Aug 2022 00:57:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ED9C441BD3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93705C0032;
	Fri, 19 Aug 2022 00:57:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2719DC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 00:57:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0127160AD3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 00:57:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0127160AD3
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=i3PgQyoD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RObnlt_TS4Y1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 00:57:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 337CA60AC1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 337CA60AC1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 00:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660870662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uuQp/54kzUA0HT/STCK8ZUpvoW2Mnly/Q6xJfw5TSjY=;
 b=i3PgQyoDCSyNAn3xOqUaR7GbelCR2d5rZNwPPJw56V9gvk5zT0OgWyqhzJDRO/CEawUhPc
 lkIb2rrhgmiCE2X1GUQTcCnsntkqgoiPxpSn2cg4Vd9vUf2tLYG4akriTJos+vQ9FP14/+
 NTGixQNb3wUEPjJvU4wko1apS2CJXRw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-546-TNc7ZrUwNYG-6iqgre9XrA-1; Thu, 18 Aug 2022 20:57:40 -0400
X-MC-Unique: TNc7ZrUwNYG-6iqgre9XrA-1
Received: by mail-lf1-f69.google.com with SMTP id
 v16-20020a056512049000b0048d0d86c689so968722lfq.15
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 17:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
 bh=uuQp/54kzUA0HT/STCK8ZUpvoW2Mnly/Q6xJfw5TSjY=;
 b=Bmi94sjfnmfr1Z/pshJN2JwfH+4itObfydKkekwF4K436nqJCwrevLRkIit7dhCCeB
 eoBe0l7PzxloWEtWNQ39VnB2L3KF2IgJICSCvGvlE0eu1mPtqHxBaRSznFIvoKww11Jw
 xUVETYD27nSuIy+DhBAh2WwJ8ixizccoKVUtWNlE75cMOIFtcNnja03PoHjMV5WxrYZ6
 M87ZW8NfqG5H+9FZLd0JhLw67WUuHRL1hQnOgwb/3h0uf+iuOM8QqQN88N7ajNuGHseO
 j4tXa/V7/Xq5/lFRYJF+pj0x/ZCz/HWQa6uElqFbV0UTet5mtCFIffiD3JoijZGphTcb
 8iAA==
X-Gm-Message-State: ACgBeo1k5QZCwkQAoxi/0Fmd13fg67Hq1oghKiw85+BQSx1uTQC9dSYI
 HWCA2Qgg8z5nxcEZ1JrvOfiutLqzID47tq5Ni48qy0DjPJ+jf2RI64fTV3nT7CYIlA1pqEh+LEL
 2tfp9PFBaa+MffEt4aLTEi3zJZJRlLnRZ3SmoOKfzKZ7OLGh1x4kvuCFo8A==
X-Received: by 2002:a05:651c:2103:b0:25d:6478:2a57 with SMTP id
 a3-20020a05651c210300b0025d64782a57mr1520462ljq.496.1660870659373; 
 Thu, 18 Aug 2022 17:57:39 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5NBBg5Ds9XUeFrJ5XIbbNo4QBFxzNKUMH/CyMN4Jn/ghuXR8mPIUiifAo/bM5oS9vi+A6u9mAf/95LI1LMrdo=
X-Received: by 2002:a05:651c:2103:b0:25d:6478:2a57 with SMTP id
 a3-20020a05651c210300b0025d64782a57mr1520433ljq.496.1660870659177; Thu, 18
 Aug 2022 17:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220811135353.2549658-1-eperezma@redhat.com>
 <20220811135353.2549658-4-eperezma@redhat.com>
In-Reply-To: <20220811135353.2549658-4-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 19 Aug 2022 08:57:28 +0800
Message-ID: <CACGkMEvDTky2y_ngUJp69Wt=1hq3U=LeSdnzEj=oYJxh+jTrOQ@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] vhost: Remove invalid parameter of
 VHOST_VDPA_SUSPEND ioctl
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
Cj4gTm90ZSB0aGF0IEknbSBub3Qgc3VyZSB0aGlzIHJlbW92YWwgaXMgdmFsaWQuIFRoZSBpb2N0
bCBpcyBub3QgaW4gbWFzdGVyCj4gYnJhbmNoIGJ5IHRoZSBzZW5kIGRhdGUgb2YgdGhpcyBwYXRj
aCwgYnV0IHRoZXJlIGFyZSBjb21taXRzIG9uIHZob3N0Cj4gYnJhbmNoIHRoYXQgZG8gaGF2ZSBp
dC4KPiAtLS0KPiAgaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0LmggfCAyICstCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvdWFwaS9saW51eC92aG9zdC5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0LmgKPiBp
bmRleCA4OWZjYjJhZmU0NzIuLjc2OGVjNDZhODhiZiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL3Vh
cGkvbGludXgvdmhvc3QuaAo+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC92aG9zdC5oCj4gQEAg
LTE3OCw2ICsxNzgsNiBAQAo+ICAgKiB0aGUgcG9zc2libGUgZGV2aWNlIHNwZWNpZmljIHN0YXRl
cykgdGhhdCBpcyByZXF1aXJlZCBmb3IgcmVzdG9yaW5nIGluIHRoZQo+ICAgKiBmdXR1cmUuIFRo
ZSBkZXZpY2UgbXVzdCBub3QgY2hhbmdlIGl0cyBjb25maWd1cmF0aW9uIGFmdGVyIHRoYXQgcG9p
bnQuCj4gICAqLwo+IC0jZGVmaW5lIFZIT1NUX1ZEUEFfU1VTUEVORCAgICAgICAgICAgICBfSU9X
KFZIT1NUX1ZJUlRJTywgMHg3RCwgaW50KQo+ICsjZGVmaW5lIFZIT1NUX1ZEUEFfU1VTUEVORCAg
ICAgICAgICAgICBfSU8oVkhPU1RfVklSVElPLCAweDdEKQo+Cj4gICNlbmRpZgo+IC0tCj4gMi4z
MS4xCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
