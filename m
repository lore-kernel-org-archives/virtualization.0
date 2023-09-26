Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66D7E81813
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 02:47:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 529406123D;
	Tue, 26 Sep 2023 02:47:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 529406123D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZGLXhm2/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fvNjl1goAFiX; Tue, 26 Sep 2023 02:47:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C637C60BEA;
	Tue, 26 Sep 2023 02:47:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C637C60BEA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1654C0071;
	Tue, 26 Sep 2023 02:47:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45C89C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 02:47:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 12D1681E21
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 02:47:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 12D1681E21
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZGLXhm2/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M0mrF2zeJCc4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 02:47:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4AD8481D7D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 02:47:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4AD8481D7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695696445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ItET0pMqX+FXEFMhJ+U3a+Ugm6kdUA0QYgdt+0g1epA=;
 b=ZGLXhm2/ZeQUvA1CT4vl5GTc/wMWChFCyN+ujiTT6fBHewzqPokWF4N8XWMXb/QVmrTvgI
 TRbg1zu8g7yUEVm6Pcsww5dd31LroOZJdzu0UyWzydJMWZVQBDpRhGZa1RZXYdiDoBkMba
 ZuqL+o+1kDtjI7yfu4Xmlj3YVvPPYNk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-_mIEUv5cM5GDWPiYhvWxdQ-1; Mon, 25 Sep 2023 22:47:21 -0400
X-MC-Unique: _mIEUv5cM5GDWPiYhvWxdQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-50421897564so11617641e87.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 19:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695696440; x=1696301240;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ItET0pMqX+FXEFMhJ+U3a+Ugm6kdUA0QYgdt+0g1epA=;
 b=pCfPDzYWSMXF7r/UXBtNYCNXlstRfh1K/pBsBtE31M/jLXBp0OoIcE4KkKkyyy1rDM
 XEEIgc+c9OjjN7BbKS+1SOdh/0MQYMSfIPk28AxjI1f1LBCqLll0ltti7YWFNrjiO7S4
 Fn++e1iQ6Sm/zBIe+savePPQQwzDGhvIv3HPTObXrD49XRvTrMncEklWP42oepROoS1p
 Md6MmcoAMlnuZv6Q8lWVmvNnIf0pVF7JlGf7/4ByPSogAajuTy6oDGyrxYvS9RVSIkQk
 AGFvann8NO3cquX18Lxc4NauNPgUiTBhPRE0gsBErlT3yueR1zlkiXZZPidCyw82yc9G
 Qg4Q==
X-Gm-Message-State: AOJu0Yxyv7DnaOYJUSwPZT56tw8dUbtVB9SG92LOwh/Ir5B7S7vM0aLV
 QFKUj3qKTGJsGPSBUh5ehi8VotjMTtE9SR9S4GhnG5x4k/GE4YRQGnoJrlazgr80LGUn6sgr6b1
 tcXJAXKMEsbkW1LfhKoIGu2qv/49Bq4WbvCJ4p5+ONwAhJp+7HsF41mkXdg==
X-Received: by 2002:a05:6512:29a:b0:503:303:9e2d with SMTP id
 j26-20020a056512029a00b0050303039e2dmr6664865lfp.5.1695696439805; 
 Mon, 25 Sep 2023 19:47:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVfoDQ70MvGrrFuSM5F4u5jc1N+fSkvSpE6P8ei76cf78SA8yD0wv/BtCLlpJJLc55YsUP/ur6WGFsVmTMMm4=
X-Received: by 2002:a05:6512:29a:b0:503:303:9e2d with SMTP id
 j26-20020a056512029a00b0050303039e2dmr6664849lfp.5.1695696439422; Mon, 25 Sep
 2023 19:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230923170540.1447301-1-lulu@redhat.com>
 <20230923170540.1447301-6-lulu@redhat.com>
In-Reply-To: <20230923170540.1447301-6-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Sep 2023 10:47:08 +0800
Message-ID: <CACGkMEtWhYPy==_OEEEO=cV7A5Wv-UGMt7FvPeMW4goNtO51FA@mail.gmail.com>
Subject: Re: [RFC 5/7] vdpa: Add new vdpa_config_ops
To: Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: yi.l.liu@intel.com, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 jgg@nvidia.com
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

T24gU3VuLCBTZXAgMjQsIDIwMjMgYXQgMTowNuKAr0FNIENpbmR5IEx1IDxsdWx1QHJlZGhhdC5j
b20+IHdyb3RlOgo+Cj4gQWRkIG5ldyB2ZHBhX2NvbmZpZ19vcHMgdG8gc3VwcG9ydCBpb21tdWZk
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBDaW5keSBMdSA8bHVsdUByZWRoYXQuY29tPgo+IC0tLQo+ICBp
bmNsdWRlL2xpbnV4L3ZkcGEuaCB8IDM0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0KPiAgMSBmaWxlIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaCBiL2luY2x1ZGUvbGludXgvdmRwYS5o
Cj4gaW5kZXggNmQwZjVlNGU4MmMyLi40YWRhNWJkNmY5MGUgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVk
ZS9saW51eC92ZHBhLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+IEBAIC01LDYgKzUs
NyBAQAo+ICAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+Cj4gICNpbmNsdWRlIDxsaW51eC9kZXZp
Y2UuaD4KPiAgI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPgo+ICsjaW5jbHVkZSA8bGludXgv
aW9tbXVmZC5oPgo+ICAjaW5jbHVkZSA8bGludXgvdmhvc3RfaW90bGIuaD4KPiAgI2luY2x1ZGUg
PGxpbnV4L3ZpcnRpb19uZXQuaD4KPiAgI2luY2x1ZGUgPGxpbnV4L2lmX2V0aGVyLmg+Cj4gQEAg
LTkxLDYgKzkyLDEyIEBAIHN0cnVjdCB2ZHBhX2RldmljZSB7Cj4gICAgICAgICBzdHJ1Y3QgdmRw
YV9tZ210X2RldiAqbWRldjsKPiAgICAgICAgIHVuc2lnbmVkIGludCBuZ3JvdXBzOwo+ICAgICAg
ICAgdW5zaWduZWQgaW50IG5hczsKPiArICAgICAgIHN0cnVjdCBpb21tdWZkX2FjY2VzcyAqaW9t
bXVmZF9hY2Nlc3M7Cj4gKyAgICAgICBzdHJ1Y3QgaW9tbXVmZF9kZXZpY2UgKmlvbW11ZmRfZGV2
aWNlOwo+ICsgICAgICAgc3RydWN0IGlvbW11ZmRfY3R4ICppb21tdWZkX2ljdHg7Cj4gKyAgICAg
ICB1bnNpZ25lZCBsb25nICp2cV9iaXRtYXA7Cj4gKyAgICAgICBhdG9taWNfdCBpb21tdWZkX3Vz
ZXJzOwo+ICsgICAgICAgYm9vbCBpb21tdWZkX2F0dGFjaGVkOwo+ICB9Owo+Cj4gIC8qKgo+IEBA
IC0yODIsNiArMjg5LDE1IEBAIHN0cnVjdCB2ZHBhX21hcF9maWxlIHsKPiAgICogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIEBpb3ZhOiBpb3ZhIHRvIGJlIHVubWFwcGVkCj4gICAqICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBAc2l6ZTogc2l6ZSBvZiB0aGUgYXJlYQo+ICAgKiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgUmV0dXJucyBpbnRlZ2VyOiBzdWNjZXNzICgwKSBvciBl
cnJvciAoPCAwKQo+ICsgKiBAYmluZF9pb21tdWZkOiAgICAgICAgICAgICAgdXNlIHZkcGFfaW9t
bXVmZF9waHlzaWNhbF9iaW5kIGZvciBhbiBJT01NVQo+ICsgKiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgYmFja2VkIGRldmljZS4KPiArICogICAgICAgICAgICAgICAgICAgICAgICAgICAg
IG90aGVyd2lzZSB1c2UgdmRwYV9pb21tdWZkX2VtdWxhdGVkX2JpbmQKPiArICogQHVuYmluZF9p
b21tdWZkOiAgICAgICAgICAgIHVzZSB2ZHBhX2lvbW11ZmRfcGh5c2ljYWxfdW5iaW5kIGZvciBh
biBJT01NVQo+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYmFja2VkIGRldmljZS4K
PiArICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIG90aGVyd2lzZSwgdXNlIHZkcGFfaW9t
bXVmZF9lbXVsYXRlZF91bmJpbmQKPiArICogQGF0dGFjaF9pb2FzOiAgICAgICAgICAgICAgIHVz
ZSB2ZHBhX2lvbW11ZmRfcGh5c2ljYWxfYXR0YWNoX2lvYXMgZm9yIGFuCj4gKyAqICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBJT01NVSBiYWNrZWQgZGV2aWNlLgo+ICsgKiBAZGV0YWNoX2lv
YXM6ICAgICAgICAgICAgICAgT3Bwb3NpdGUgb2YgYXR0YWNoX2lvYXMKClRob3NlIHNob3VsZCBi
ZSBtYXJrZWQgYXMgbWFuZGF0b3J5IG9ubHkgZm9yIHBhcmVudHMgd2l0aCBzcGVjaWZpYwp0cmFu
c2xhdGlvbnMgKGUuZyBzaW11bGF0b3IgYW5kIG1seDVfdmRwYSkuCgpPciBhbnl0aGluZyBJIG1p
c3NlZD8KClRoYW5rcwoKCj4gICAqIEBmcmVlOiAgICAgICAgICAgICAgICAgICAgICBGcmVlIHJl
c291cmNlcyB0aGF0IGJlbG9uZ3MgdG8gdkRQQSAob3B0aW9uYWwpCj4gICAqICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBAdmRldjogdmRwYSBkZXZpY2UKPiAgICovCj4gQEAgLTM0MSw2ICsz
NTcsMTIgQEAgc3RydWN0IHZkcGFfY29uZmlnX29wcyB7Cj4gICAgICAgICAgICAgICAgICAgICAg
ICAgIHU2NCBpb3ZhLCB1NjQgc2l6ZSk7Cj4gICAgICAgICBpbnQgKCpzZXRfZ3JvdXBfYXNpZCko
c3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBpbnQgZ3JvdXAsCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IGFzaWQpOwo+ICsgICAgICAgLyogSU9N
TVVGRCBvcHMgKi8KPiArICAgICAgIGludCAoKmJpbmRfaW9tbXVmZCkoc3RydWN0IHZkcGFfZGV2
aWNlICp2ZGV2LCBzdHJ1Y3QgaW9tbXVmZF9jdHggKmljdHgsCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHUzMiAqb3V0X2RldmljZV9pZCk7Cj4gKyAgICAgICB2b2lkICgqdW5iaW5kX2lv
bW11ZmQpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldik7Cj4gKyAgICAgICBpbnQgKCphdHRhY2hf
aW9hcykoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1MzIgKnB0X2lkKTsKPiArICAgICAgIGlu
dCAoKmRldGFjaF9pb2FzKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpOwo+Cj4gICAgICAgICAv
KiBGcmVlIGRldmljZSByZXNvdXJjZXMgKi8KPiAgICAgICAgIHZvaWQgKCpmcmVlKShzdHJ1Y3Qg
dmRwYV9kZXZpY2UgKnZkZXYpOwo+IEBAIC01MTAsNCArNTMyLDE0IEBAIHN0cnVjdCB2ZHBhX21n
bXRfZGV2IHsKPiAgaW50IHZkcGFfbWdtdGRldl9yZWdpc3RlcihzdHJ1Y3QgdmRwYV9tZ210X2Rl
diAqbWRldik7Cj4gIHZvaWQgdmRwYV9tZ210ZGV2X3VucmVnaXN0ZXIoc3RydWN0IHZkcGFfbWdt
dF9kZXYgKm1kZXYpOwo+Cj4gLSNlbmRpZiAvKiBfTElOVVhfVkRQQV9IICovCj4gK2ludCB2ZHBh
X2lvbW11ZmRfcGh5c2ljYWxfYmluZChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEsCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBpb21tdWZkX2N0eCAqaWN0eCwgdTMyICpv
dXRfZGV2aWNlX2lkKTsKPiArdm9pZCB2ZHBhX2lvbW11ZmRfcGh5c2ljYWxfdW5iaW5kKHN0cnVj
dCB2ZHBhX2RldmljZSAqdmRwYSk7Cj4gK2ludCB2ZHBhX2lvbW11ZmRfcGh5c2ljYWxfYXR0YWNo
X2lvYXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhLCB1MzIgKnB0X2lkKTsKPiAraW50IHZkcGFf
aW9tbXVmZF9lbXVsYXRlZF9iaW5kKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSwKPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGlvbW11ZmRfY3R4ICppY3R4LCB1MzIgKm91
dF9kZXZpY2VfaWQpOwo+ICt2b2lkIHZkcGFfaW9tbXVmZF9lbXVsYXRlZF91bmJpbmQoc3RydWN0
IHZkcGFfZGV2aWNlICp2ZHBhKTsKPiAraW50IHZkcGFfaW9tbXVmZF9lbXVsYXRlZF9hdHRhY2hf
aW9hcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEsIHUzMiAqcHRfaWQpOwo+ICtpbnQgdmRwYV9p
b21tdWZkX2VtdWxhdGVkX2RldGFjaF9pb2FzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSk7Cj4g
Kwo+ICsjZW5kaWYKPiAtLQo+IDIuMzQuMwo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
