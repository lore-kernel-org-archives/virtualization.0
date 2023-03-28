Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB45AC76196
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 11:19:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C41061205;
	Tue, 28 Mar 2023 11:19:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5C41061205
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E4nXNwQo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EKyTC25aKirs; Tue, 28 Mar 2023 11:19:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D828560B74;
	Tue, 28 Mar 2023 11:19:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D828560B74
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABD62C0037;
	Tue, 28 Mar 2023 11:19:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05216C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 11:19:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D22964161F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 11:19:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D22964161F
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=E4nXNwQo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jx9D7hMG8fkg
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 11:19:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 57ABC415E4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 57ABC415E4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 11:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680002361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xTS3qxFhBqMP5asqq6o4vShlFpc+3Cgiy/wm+SvxL0Q=;
 b=E4nXNwQoeURnz5bknTQx7aZmKkHu4q8IaDd94j01/oc6/LC+ckUjHJejWhksCnmPW9ZipZ
 zDL6L2eHDiMfDcDddU1qAHG1xeAmNyhklNczvYYd6gWgsCyADc6O49+wK+PqOC0aBAglsz
 lxpIBPQtJR9TeUzOyb04iv4CPU84JCY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-lryDxPf2MAOSAuUhQSu6EQ-1; Tue, 28 Mar 2023 07:19:20 -0400
X-MC-Unique: lryDxPf2MAOSAuUhQSu6EQ-1
Received: by mail-qt1-f197.google.com with SMTP id
 h6-20020ac85846000000b003e3c23d562aso7940315qth.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 04:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680002359;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xTS3qxFhBqMP5asqq6o4vShlFpc+3Cgiy/wm+SvxL0Q=;
 b=HStirnABBL3TYYr99waBDfZXy48p+WK2UVfnS8jklPOPK9ZGLkUMszFHMatMDtaVWp
 uhm7/FsgAPLmF28cQ3Zk8US91HaTdHt8jrPzzv9er7OEob3tuLdWTdV/J5QQP8f7npo2
 m3p+FuwRfqhH6160JgZxWaVHKCCb/2p4zNrt/HKun8T6XWMQIdDyBgJ+8FtBdc/eM1Zb
 fIdaXU7r8Xz22NGzXX8zorPLsIRa1OaN6ovdMeeWbaMqb582L48KNk4ajvQuHkxifEfC
 PetT/O/3ATRc6A/xtZo/BW038jQGq1dgt2fDVStsh/czG88XmK9If8IFc7LYZrXN1uMF
 ff0Q==
X-Gm-Message-State: AO0yUKWhYxDC7M6OzWOra37X1fyaNMvcFSLp+8i7xl0GuHVb4nmcYSqv
 8+P/njezVLfocgi2Wedm5kotkm3TYS2pu3Sx+dymPUVwHxs2A4XU2LsKiyVk9Ps/AliswCJzMfj
 N9dTVnFeROIU93bntMCiMUpG7i+h/eb0qOpJfaQGxnQ==
X-Received: by 2002:a05:622a:88:b0:3d8:3aed:66f4 with SMTP id
 o8-20020a05622a008800b003d83aed66f4mr26549971qtw.41.1680002359528; 
 Tue, 28 Mar 2023 04:19:19 -0700 (PDT)
X-Google-Smtp-Source: AK7set9rLhqoc1M0lOv19pEk7kytc7wZbIHzVGbGY5clwetaWE5MDsGKBYhOBeIW8AABeuWV7JcagA==
X-Received: by 2002:a05:622a:88:b0:3d8:3aed:66f4 with SMTP id
 o8-20020a05622a008800b003d83aed66f4mr26549929qtw.41.1680002359066; 
 Tue, 28 Mar 2023 04:19:19 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-98.retail.telecomitalia.it.
 [82.53.134.98]) by smtp.gmail.com with ESMTPSA id
 v127-20020a379385000000b007456c75edbbsm17581456qkd.129.2023.03.28.04.19.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Mar 2023 04:19:18 -0700 (PDT)
Date: Tue, 28 Mar 2023 13:19:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>, Vishnu Dasa <vdasa@vmware.com>
Subject: Re: [RFC PATCH v1 1/2] vsock: return errors other than -ENOMEM to
 socket
Message-ID: <ak74j6l2qesrixxmw7pfw56najqhdn32lv3xfxcb53nvmkyi3x@fr25vo2jlvbj>
References: <97f19214-ba04-c47e-7486-72e8aa16c690@sberdevices.ru>
 <99da938b-3e67-150c-2f74-41d917a95950@sberdevices.ru>
 <itjmw7vh3a7ggbodsu4mksu2hqbpdpxmu6cpexbra66nfhsw4x@hzpuzwldkfx5>
 <CAGxU2F648TyvAJN+Zk6YCnGUhn=0W_MZTox7RxQ45zHmHHO0SA@mail.gmail.com>
 <0f0a8603-e8a1-5fb2-23d9-5773c808ef85@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <0f0a8603-e8a1-5fb2-23d9-5773c808ef85@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Bryan Tan <bryantan@vmware.com>,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kernel@sberdevices.ru, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

T24gVHVlLCBNYXIgMjgsIDIwMjMgYXQgMDE6NDI6MTlQTSArMDMwMCwgQXJzZW5peSBLcmFzbm92
IHdyb3RlOgo+Cj4KPk9uIDI4LjAzLjIwMjMgMTI6NDIsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90
ZToKPj4gSSBwcmVzc2VkIHNlbmQgdG9vIGVhcmx5Li4uCj4+Cj4+IENDaW5nIEJyeWFuLCBWaXNo
bnUsIGFuZCBwdi1kcml2ZXJzQHZtd2FyZS5jb20KPj4KPj4gT24gVHVlLCBNYXIgMjgsIDIwMjMg
YXQgMTE6MznigK9BTSBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+IHdy
b3RlOgo+Pj4KPj4+IE9uIFN1biwgTWFyIDI2LCAyMDIzIGF0IDAxOjEzOjExQU0gKzAzMDAsIEFy
c2VuaXkgS3Jhc25vdiB3cm90ZToKPj4+PiBUaGlzIHJlbW92ZXMgYmVoYXZpb3VyLCB3aGVyZSBl
cnJvciBjb2RlIHJldHVybmVkIGZyb20gYW55IHRyYW5zcG9ydAo+Pj4+IHdhcyBhbHdheXMgc3dp
dGNoZWQgdG8gRU5PTUVNLiBUaGlzIHdvcmtzIGluIHRoZSBzYW1lIHdheSBhczoKPj4+PiBjb21t
aXQKPj4+PiBjNDMxNzBiN2UxNTcgKCJ2c29jazogcmV0dXJuIGVycm9ycyBvdGhlciB0aGFuIC1F
Tk9NRU0gdG8gc29ja2V0IiksCj4+Pj4gYnV0IGZvciByZWNlaXZlIGNhbGxzLgo+Pj4+Cj4+Pj4g
U2lnbmVkLW9mZi1ieTogQXJzZW5peSBLcmFzbm92IDxBVktyYXNub3ZAc2JlcmRldmljZXMucnU+
Cj4+Pj4gLS0tCj4+Pj4gbmV0L3Ztd192c29jay9hZl92c29jay5jIHwgNCArKy0tCj4+Pj4gMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4+Pgo+Pj4+IGRp
ZmYgLS1naXQgYS9uZXQvdm13X3Zzb2NrL2FmX3Zzb2NrLmMgYi9uZXQvdm13X3Zzb2NrL2FmX3Zz
b2NrLmMKPj4+PiBpbmRleCAxOWFlYTdjYmEyNmUuLjkyNjJlMGI3N2Q0NyAxMDA2NDQKPj4+PiAt
LS0gYS9uZXQvdm13X3Zzb2NrL2FmX3Zzb2NrLmMKPj4+PiArKysgYi9uZXQvdm13X3Zzb2NrL2Fm
X3Zzb2NrLmMKPj4+PiBAQCAtMjAwNyw3ICsyMDA3LDcgQEAgc3RhdGljIGludCBfX3Zzb2NrX3N0
cmVhbV9yZWN2bXNnKHN0cnVjdCBzb2NrICpzaywgc3RydWN0IG1zZ2hkciAqbXNnLAo+Pj4+Cj4+
Pj4gICAgICAgICAgICAgICByZWFkID0gdHJhbnNwb3J0LT5zdHJlYW1fZGVxdWV1ZSh2c2ssIG1z
ZywgbGVuIC0gY29waWVkLCBmbGFncyk7Cj4+Pgo+Pj4gSW4gdm1jaV90cmFuc3BvcnRfc3RyZWFt
X2RlcXVldWUoKSB2bWNpX3FwYWlyX3BlZWt2KCkgYW5kCj4+PiB2bWNpX3FwYWlyX2RlcXVldigp
IHJldHVybiBWTUNJX0VSUk9SXyogaW4gY2FzZSBvZiBlcnJvcnMuCj4+Pgo+Pj4gTWF5YmUgd2Ug
c2hvdWxkIHJldHVybiAtRU5PTUVNIGluIHZtY2lfdHJhbnNwb3J0X3N0cmVhbV9kZXF1ZXVlKCkg
aWYKPj4+IHRob3NlIGZ1bmN0aW9ucyBmYWlsIHRvIGtlZXAgdGhlIHNhbWUgYmVoYXZpb3IuCj4K
Plllcywgc2VlbXMgaSBtaXNzZWQgaXQsIGJlY2F1c2Ugc2V2ZXJhbCBtb250aHMgYWdvIHdlIGhh
ZCBzaW1pbGFyIHF1ZXN0aW9uIGZvciBzZW5kCj5sb2dpYzoKPmh0dHBzOi8vd3d3LnNwaW5pY3Mu
bmV0L2xpc3RzL2tlcm5lbC9tc2c0NjExMDkxLmh0bWwKPkFuZCBpdCB3YXMgb2sgdG8gbm90IGhh
bmRsZSBWTUNJIHNlbmQgcGF0aCBpbiB0aGlzIHdheS4gU28gaSB0aGluayBjdXJyZW50IGltcGxl
bWVudGF0aW9uCj5mb3IgdHggaXMgYSBsaXR0bGUgYml0IGJ1Z2d5LCBiZWNhdXNlIFZNQ0kgc3Bl
Y2lmaWMgZXJyb3IgZnJvbSAndm1jaV9xcGFpcl9lbnF1ZXYoKScgaXMKPnJldHVybmVkIHRvIGFm
X3Zzb2NrLmMuIEkgdGhpbmsgZXJyb3IgY29udmVyc2lvbiBtdXN0IGJlIGFkZGVkIHRvIFZNQ0kg
dHJhbnNwb3J0IGZvciB0eAo+YWxzby4KCkdvb2QgcG9pbnQhCgpUaGVzZSBhcmUgbmVnYXRpdmUg
dmFsdWVzLCBzbyB0aGVyZSBhcmUgbm8gYmlnIHByb2JsZW1zLCBidXQgSSBkb24ndAprbm93IHdo
YXQgdGhlIHVzZXIgZXhwZWN0cyBpbiB0aGlzIGNhc2UuCgpAVmlzaG51IERvIHdlIHdhbnQgdG8g
cmV0dXJuIGFuIGVycm5vIHRvIHRoZSB1c2VyIG9yIGEgVk1DSV9FUlJPUl8qPwoKSW4gYm90aCBj
YXNlcyBJIHRoaW5rIHdlIHNob3VsZCBkbyB0aGUgc2FtZSBmb3IgYm90aCBlbnF1ZXVlIGFuZApk
ZXF1ZXVlLgoKPgo+R29vZCB0aGluZyBpcyB0aGF0IEh5cGVyLVYgdXNlcyBnZW5lcmFsIGVycm9y
IGNvZGVzLgoKWWVhaCEKClRoYW5rcywKU3RlZmFubwoKPgo+VGhhbmtzLCBBcnNlbml5Cj4+Pgo+
Pj4gQ0NpbmcgQnJ5YW4sIFZpc2hudSwgYW5kIHB2LWRyaXZlcnNAdm13YXJlLmNvbQo+Pj4KPj4+
IFRoZSBvdGhlciB0cmFuc3BvcnRzIHNlZW0gb2theSB0byBtZS4KPj4+Cj4+PiBUaGFua3MsCj4+
PiBTdGVmYW5vCj4+Pgo+Pj4+ICAgICAgICAgICAgICAgaWYgKHJlYWQgPCAwKSB7Cj4+Pj4gLSAg
ICAgICAgICAgICAgICAgICAgICBlcnIgPSAtRU5PTUVNOwo+Pj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgZXJyID0gcmVhZDsKPj4+PiAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7Cj4+Pj4g
ICAgICAgICAgICAgICB9Cj4+Pj4KPj4+PiBAQCAtMjA1OCw3ICsyMDU4LDcgQEAgc3RhdGljIGlu
dCBfX3Zzb2NrX3NlcXBhY2tldF9yZWN2bXNnKHN0cnVjdCBzb2NrICpzaywgc3RydWN0IG1zZ2hk
ciAqbXNnLAo+Pj4+ICAgICAgIG1zZ19sZW4gPSB0cmFuc3BvcnQtPnNlcXBhY2tldF9kZXF1ZXVl
KHZzaywgbXNnLCBmbGFncyk7Cj4+Pj4KPj4+PiAgICAgICBpZiAobXNnX2xlbiA8IDApIHsKPj4+
PiAtICAgICAgICAgICAgICBlcnIgPSAtRU5PTUVNOwo+Pj4+ICsgICAgICAgICAgICAgIGVyciA9
IG1zZ19sZW47Cj4+Pj4gICAgICAgICAgICAgICBnb3RvIG91dDsKPj4+PiAgICAgICB9Cj4+Pj4K
Pj4+PiAtLQo+Pj4+IDIuMjUuMQo+Pj4+Cj4+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
