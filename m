Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CF0E8181B
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 04:45:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4726A613E5;
	Tue, 26 Sep 2023 04:45:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4726A613E5
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dYb/qY4n
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FGDI0kLsDRvS; Tue, 26 Sep 2023 04:45:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D18C460FBB;
	Tue, 26 Sep 2023 04:45:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D18C460FBB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92E82C0071;
	Tue, 26 Sep 2023 04:45:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BEEF1C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 04:44:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 85FE34177A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 04:44:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 85FE34177A
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dYb/qY4n
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yk6fhDriPUaD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 04:44:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C395A41779
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 04:44:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C395A41779
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695703497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lKd9lX9BKAg4Mb3Rgphudf1CD/sMa9gnwnekBt6buI8=;
 b=dYb/qY4nn6TiAVL/gtNkKWz4IYjLtCJOpB4HKd219x9NpIOoXwqSL0gi1J4TbW1FodMK5F
 8jb5MDjJH8vgD+e2q8jVThjPN4ILk5s8zfERsbpeeYdnVQPPZ4YvSLqaN5wRAmwogU4PP8
 XReG3ajoGWFeTgebdnodu5KPtmJtwWc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-9vw3tq1YPfyMBxHLOwCZfQ-1; Tue, 26 Sep 2023 00:44:55 -0400
X-MC-Unique: 9vw3tq1YPfyMBxHLOwCZfQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-50433961a36so10105128e87.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 21:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695703494; x=1696308294;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lKd9lX9BKAg4Mb3Rgphudf1CD/sMa9gnwnekBt6buI8=;
 b=eDbPzYxLppAt/EQPmC8jKuBtajNrGClcoykW0rYg2GefYyXswPPoFmvB0QpP9sXBT3
 90Ugeo3pfg8Tila3yT7fNkcCRvoU+gINgMAtT1Ec2KKDwO6kQuZJSJeNZrcibrp3ZcIP
 2eFd8/kbe2K0R+onb6YfPk83MNxC6TUfFtqDcUgUAtwSRcqqRvaGaAZAHnLsD14jtkO+
 NMEkGzNPuv1c1Wa6Cv6dCjqEkdPAdeyIw2qsXBL5WUb5oAc/oxZSAwX7z4Es8CqiWtsR
 IcCea4Mqb+xI0E2fsJwBsw2gPExYkBHjBJwgfC93dMKowjjhmgYT3ok1wxU9qbLig4ks
 BmiQ==
X-Gm-Message-State: AOJu0Yyh+pvihuBLP4hAFWW79+OxRdpKF4JyITwTEa754zV818JYVewG
 TUHOW5BygvWrrqJPbZP0U3uCNDIWnszgIJLV3y1VVgwpuNQdoniCSzZtnJaBebukWMK3+vMC/J6
 T46mF4X50fQlCNJH8K7/c8avarxKQEGWEDkNDKDRSWMFG9IfuQ8qyqC7Zfw==
X-Received: by 2002:ac2:5298:0:b0:500:9a45:63b with SMTP id
 q24-20020ac25298000000b005009a45063bmr6461821lfm.13.1695703494185; 
 Mon, 25 Sep 2023 21:44:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU/RlQVUf27AIXEYRyQljY5TrTb67tO7dTmq4dl8jclKO22hbKDJfJ0W7Wj+Lu4TwB0pdoCzPHtpU0PCHihoQ=
X-Received: by 2002:ac2:5298:0:b0:500:9a45:63b with SMTP id
 q24-20020ac25298000000b005009a45063bmr6461810lfm.13.1695703493888; Mon, 25
 Sep 2023 21:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230912130132.561193-1-dtatulea@nvidia.com>
 <20230912130132.561193-10-dtatulea@nvidia.com>
In-Reply-To: <20230912130132.561193-10-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Sep 2023 12:44:43 +0800
Message-ID: <CACGkMEsC_rgnKyG3stFbc-Mz2yiKGwNUYYqG64jQbNpZBtnVvg@mail.gmail.com>
Subject: Re: [PATCH 09/16] vdpa/mlx5: Allow creation/deletion of any given mr
 struct
To: Dragos Tatulea <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>
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

T24gVHVlLCBTZXAgMTIsIDIwMjMgYXQgOTowMuKAr1BNIERyYWdvcyBUYXR1bGVhIDxkdGF0dWxl
YUBudmlkaWEuY29tPiB3cm90ZToKPgo+IFRoaXMgcGF0Y2ggYWRhcHRzIHRoZSBtciBjcmVhdGlv
bi9kZWxldGlvbiBjb2RlIHRvIGJlIGFibGUgdG8gd29yayB3aXRoCj4gYW55IGdpdmVuIG1yIHN0
cnVjdCBwb2ludGVyLiBBbGwgdGhlIEFQSXMgYXJlIGFkYXB0ZWQgdG8gdGFrZSBhbiBleHRyYQo+
IHBhcmFtZXRlciBmb3IgdGhlIG1yLgo+Cj4gbWx4NV92ZHBhX2NyZWF0ZS9kZWxldGVfbXIgZG9l
c24ndCBuZWVkIGEgQVNJRCBwYXJhbWV0ZXIgYW55bW9yZS4gVGhlCj4gY2hlY2sgaXMgZG9uZSBp
biB0aGUgY2FsbGVyIGluc3RlYWQgKG1seDVfc2V0X21hcCkuCj4KPiBUaGlzIGNoYW5nZSBpcyBu
ZWVkZWQgZm9yIGEgZm9sbG93dXAgcGF0Y2ggd2hpY2ggd2lsbCBpbnRyb2R1Y2UgYW4KPiBhZGRp
dGlvbmFsIG1yIGZvciB0aGUgdnEgZGVzY3JpcHRvciBkYXRhLgo+Cj4gU2lnbmVkLW9mZi1ieTog
RHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVhQG52aWRpYS5jb20+Cj4gLS0tCgpUaGlua2luZyBvZiB0
aGlzIGRlY291cGxpbmcgSSB0aGluayBJIGhhdmUgYSBxdWVzdGlvbi4KCldlIGFkdmVydGlzZSAy
IGFkZHJlc3Mgc3BhY2VzIGFuZCAyIGdyb3Vwcy4gU28gd2UgYWN0dWFsbHkgZG9uJ3Qga25vdwpm
b3IgZXhhbXBsZSB3aGljaCBhZGRyZXNzIHNwYWNlcyB3aWxsIGJlIHVzZWQgYnkgZHZxLgoKQW5k
IGFjdHVhbGx5IHdlIGFsbG93IHRoZSB1c2VyIHNwYWNlIHRvIGRvIHNvbWV0aGluZyBsaWtlCgpz
ZXRfZ3JvdXBfYXNpZChkdnFfZ3JvdXAsIDApCnNldF9tYXAoMCkKc2V0X2dyb3VwX2FzaWQoZHZx
X2dyb3VwLCAxKQpzZXRfbWFwKDEpCgpJIHdvbmRlciBpZiB0aGUgZGVjb3VwbGluZyBsaWtlIHRo
aXMgcGF0Y2ggY2FuIHdvcmsgYW5kIHdoeS4KCkl0IGxvb2tzIHRvIG1lIHRoZSBtb3N0IGVhc3kg
d2F5IGlzIHRvIGxldCBlYWNoIEFTIGJlIGJhY2tlZCBieSBhbiBNUi4KVGhlbiB3ZSBkb24ndCBl
dmVuIG5lZWQgdG8gY2FyZSBhYm91dCB0aGUgZHZxLCBjdnEuCgpUaGFua3MKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
