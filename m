Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC8FC433EF
	for <virtualization@archiver.kernel.org>; Wed, 29 Jun 2022 04:10:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1FB6482DE6;
	Wed, 29 Jun 2022 04:10:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1FB6482DE6
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T/CjEBY+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hm5Po-2dYlxj; Wed, 29 Jun 2022 04:10:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 827ED82B1B;
	Wed, 29 Jun 2022 04:10:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 827ED82B1B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C2A8C0039;
	Wed, 29 Jun 2022 04:10:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DBD6C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 04:10:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 546E140359
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 04:10:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 546E140359
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=T/CjEBY+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SAkroG8voq4A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 04:10:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F03DC402F6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F03DC402F6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 04:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656475846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bg6heNJXq50eL6WsFIMxRV6MiBd1t5LqWZMr8mmOcec=;
 b=T/CjEBY+FmnPFfBffCvVyTEz2BxKwDhjBjN+02RtjS0fcg97k2QJCCMN6QIAmosmV2Bh5A
 hsIP+VPyhpNn1qZ3ANyR2mWGGK09Svbl4ATqnZmq/e9K4ZJlBxilXVSPtZqHw1TbcpZ1i5
 qaUy5vNyBgiep62GDny0uel1xUsvN+o=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-1rkw9mP5NCS3vqSuFX3H3Q-1; Wed, 29 Jun 2022 00:10:45 -0400
X-MC-Unique: 1rkw9mP5NCS3vqSuFX3H3Q-1
Received: by mail-lf1-f71.google.com with SMTP id
 bi38-20020a0565120ea600b0047f640eaee0so7168390lfb.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 21:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bg6heNJXq50eL6WsFIMxRV6MiBd1t5LqWZMr8mmOcec=;
 b=eHAIeYi/ulJHkCxNpmi6JKtfuRVzmPbsCFKaF+iiVSgk+632gqpoGm/O/NL6rGTtxo
 TV24+1YdhtTHKzmXjAq4jebJAlW9M/CjUUP67PZdP5NBOYU/Y3UmJX3AGgadnLmxJhW/
 KMYtCkmcIppDFukA6NQRz4E0GxczIB6/dLI985paa3obcp0XSa5STRzW1dczf8PyrReS
 21qOngyi04/8wmnPnJgLUGQAr7Y/Z30MuovFVfSATYrHDD5r1+aEVlxsieAiKju63vou
 D3Kl5DxmvFzxubx1YOJNjM5cHnH/qs9Y9rpRtSkrQ8NbYZuwbyWLewYskTYMbPt2bolD
 Kkug==
X-Gm-Message-State: AJIora9S75caz7tgKFnVZtvBBLuRn7uDQdxUpKxdG9Ew9CK4f68IV0QH
 oS6t43nEHyPOxyTbmAFbdTrebetGJjXkoDgDzJXAdnD6x3xDrHIWlW5oYPWEOSQcgJix4M8bXN1
 N2iV0Vng8ER1HktHnhqs0hSGDxLOnZBZqQsnvv+WHsicmIumPa0RmT+61eA==
X-Received: by 2002:a05:651c:1610:b0:25a:75fa:f9cc with SMTP id
 f16-20020a05651c161000b0025a75faf9ccmr615161ljq.243.1656475843875; 
 Tue, 28 Jun 2022 21:10:43 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tsRfqKSJ5WREAe866tYR2Av6sXWiFQwf7Na0t+bQDdXFNQBHVv7PWUm2aQHXPC9OFidZUGp5C/19n3ZUbyfXY=
X-Received: by 2002:a05:651c:1610:b0:25a:75fa:f9cc with SMTP id
 f16-20020a05651c161000b0025a75faf9ccmr615131ljq.243.1656475843670; Tue, 28
 Jun 2022 21:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220623160738.632852-1-eperezma@redhat.com>
 <20220623160738.632852-2-eperezma@redhat.com>
In-Reply-To: <20220623160738.632852-2-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 29 Jun 2022 12:10:32 +0800
Message-ID: <CACGkMEv+yFLCzo-K7eSaVPJqLCa5SxfVCmB=piQ3+6R3=oDz-w@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] vdpa: Add suspend operation
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

T24gRnJpLCBKdW4gMjQsIDIwMjIgYXQgMTI6MDcgQU0gRXVnZW5pbyBQw6lyZXogPGVwZXJlem1h
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gVGhpcyBvcGVyYXRpb24gaXMgb3B0aW9uYWw6IEl0IGl0
J3Mgbm90IGltcGxlbWVudGVkLCBiYWNrZW5kIGZlYXR1cmUgYml0Cj4gd2lsbCBub3QgYmUgZXhw
b3NlZC4KCkEgcXVlc3Rpb24sIGRvIHdlIGFsbG93IHN1c3BlbmRpbmcgYSBkZXZpY2Ugd2l0aG91
dCBEUklWRVJfT0s/CgpUaGFua3MKCj4KPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8
ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiAtLS0KPiAgaW5jbHVkZS9saW51eC92ZHBhLmggfCA0ICsr
KysKPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgvdmRwYS5oIGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPiBpbmRleCA3YjRhMTNk
M2JkOTEuLmQyODJmNDY0ZDJmMSAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+
ICsrKyBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4gQEAgLTIxOCw2ICsyMTgsOSBAQCBzdHJ1Y3Qg
dmRwYV9tYXBfZmlsZSB7Cj4gICAqIEByZXNldDogICAgICAgICAgICAgICAgICAgICBSZXNldCBk
ZXZpY2UKPiAgICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIEB2ZGV2OiB2ZHBhIGRldmlj
ZQo+ICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUmV0dXJucyBpbnRlZ2VyOiBzdWNj
ZXNzICgwKSBvciBlcnJvciAoPCAwKQo+ICsgKiBAc3VzcGVuZDogICAgICAgICAgICAgICAgICAg
U3VzcGVuZCBvciByZXN1bWUgdGhlIGRldmljZSAob3B0aW9uYWwpCj4gKyAqICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBAdmRldjogdmRwYSBkZXZpY2UKPiArICogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFJldHVybnMgaW50ZWdlcjogc3VjY2VzcyAoMCkgb3IgZXJyb3IgKDwgMCkK
PiAgICogQGdldF9jb25maWdfc2l6ZTogICAgICAgICAgIEdldCB0aGUgc2l6ZSBvZiB0aGUgY29u
ZmlndXJhdGlvbiBzcGFjZSBpbmNsdWRlcwo+ICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZmllbGRzIHRoYXQgYXJlIGNvbmRpdGlvbmFsIG9uIGZlYXR1cmUgYml0cy4KPiAgICogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIEB2ZGV2OiB2ZHBhIGRldmljZQo+IEBAIC0zMTksNiAr
MzIyLDcgQEAgc3RydWN0IHZkcGFfY29uZmlnX29wcyB7Cj4gICAgICAgICB1OCAoKmdldF9zdGF0
dXMpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldik7Cj4gICAgICAgICB2b2lkICgqc2V0X3N0YXR1
cykoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1OCBzdGF0dXMpOwo+ICAgICAgICAgaW50ICgq
cmVzZXQpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldik7Cj4gKyAgICAgICBpbnQgKCpzdXNwZW5k
KShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpOwo+ICAgICAgICAgc2l6ZV90ICgqZ2V0X2NvbmZp
Z19zaXplKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpOwo+ICAgICAgICAgdm9pZCAoKmdldF9j
b25maWcpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdW5zaWduZWQgaW50IG9mZnNldCwKPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICpidWYsIHVuc2lnbmVkIGludCBsZW4pOwo+
IC0tCj4gMi4zMS4xCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
