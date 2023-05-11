Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261F6C7EE22
	for <virtualization@archiver.kernel.org>; Thu, 11 May 2023 13:00:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A0DE98411C;
	Thu, 11 May 2023 13:00:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A0DE98411C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h+ocTEHI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kCo3OlMDfsW4; Thu, 11 May 2023 13:00:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 12A4A8401C;
	Thu, 11 May 2023 13:00:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 12A4A8401C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA692C0037;
	Thu, 11 May 2023 13:00:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25A26C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 May 2023 13:00:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EB1BF41EBB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 May 2023 13:00:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EB1BF41EBB
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=h+ocTEHI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kjBOiYvBcOnb
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 May 2023 13:00:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8758C41EB5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8758C41EB5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 May 2023 13:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683810030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1YNgJu9g4hsRAs0h9Bi/9rkG5y7jrDdpJUfTR0KD1Tg=;
 b=h+ocTEHIk46djJM57ql5FcFO44aYZslL2z/cEKWe4IQKIVKRLjYFYPCcP7n55w3pkGjjMw
 aGjAaUuz2WJ+/fb6vDeT2VsisiZxu7vurq6/LzZUE5760lmJ90GBfe8LnfgVi5Jx8BNkdQ
 DJJvygZ4rBgt3HCbq9ZyYir0+mIkLXE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-u5PWIav8OUWEuEIvcp3b5g-1; Thu, 11 May 2023 09:00:28 -0400
X-MC-Unique: u5PWIav8OUWEuEIvcp3b5g-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-306286b3573so5247980f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 May 2023 06:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683810026; x=1686402026;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1YNgJu9g4hsRAs0h9Bi/9rkG5y7jrDdpJUfTR0KD1Tg=;
 b=Y1YtfQ/SrcK66BmwIkpbqEcRgfT4Zqg1QUFt8F8npzAeE9yRdirLHe0riVTFFyfMOU
 veQXMAkih0/lwyvTHq/GaA8Q7VRD34mD+stdy7Lqe6oFBAqJCkqIQbaohhBbdv0jPBEh
 suvHBjWSEINBPkkVsqfZOksa1wL2kI8m2GMPfVAZZCGbfAbroK5b+hVYphN6zm3LbNv5
 hzgXZrvikElP8h1aSrRKFxWuX7jZ9Mo+cSYnRQYiG3cBLrvwtjJ0I4q8I81kJbDAXIPU
 39F9zHQc1jZ/9ky3iLHG4z8uYzWnRsUedNbrOiLJRigv1HISysTfMDCeFOc6m8c4PTG6
 LF4A==
X-Gm-Message-State: AC+VfDyvXQbPxVT3E/LRrKOyEpioFhSCVGLN6oS7J1IvxI7NSi7chjI3
 guK+3NPWcQeAqOadQhjYXPwWfyYgofq0nr4BEyRDLvO+x1k+u9ATSqZoa3HrhC4KBZ3w+9hQWvK
 3eenc8QC1fA9CL/KYgzJjz9/ERAHAJT0Ey4zi+dVF/Q==
X-Received: by 2002:a5d:55cf:0:b0:304:b967:956f with SMTP id
 i15-20020a5d55cf000000b00304b967956fmr16336611wrw.8.1683810026737; 
 Thu, 11 May 2023 06:00:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6maX1bAPZW0k8hxurkuPzMZqG473m27W7e8iBYUPNc8cfDsYenYLW5jeTNv5v8llwVfwyINA==
X-Received: by 2002:a5d:55cf:0:b0:304:b967:956f with SMTP id
 i15-20020a5d55cf000000b00304b967956fmr16336585wrw.8.1683810026412; 
 Thu, 11 May 2023 06:00:26 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.69.175])
 by smtp.gmail.com with ESMTPSA id
 w14-20020a5d680e000000b003079693eff2sm12447627wru.41.2023.05.11.06.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 May 2023 06:00:25 -0700 (PDT)
Date: Thu, 11 May 2023 15:00:20 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Zhuang Shengen <zhuangshengen@huawei.com>
Subject: Re: [PATCH net v2] vsock: avoid to close connected socket after the
 timeout
Message-ID: <atd47kt3wyhw2mhrzob4fxzlvmw37xviehn7agao3srni2jmts@gxgzvqrb7mc7>
References: <20230511113430.646292-1-zhuangshengen@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20230511113430.646292-1-zhuangshengen@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, jianjay.zhou@huawei.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-pci@vger.kernel.org, longpeng2@huawei.com
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

T24gVGh1LCBNYXkgMTEsIDIwMjMgYXQgMDc6MzQ6MzBQTSArMDgwMCwgWmh1YW5nIFNoZW5nZW4g
d3JvdGU6Cj5XaGVuIGNsaWVudCBhbmQgc2VydmVyIGVzdGFibGlzaCBhIGNvbm5lY3Rpb24gdGhy
b3VnaCB2c29jaywKPnRoZSBjbGllbnQgc2VuZCBhIHJlcXVlc3QgdG8gdGhlIHNlcnZlciB0byBp
bml0aWF0ZSB0aGUgY29ubmVjdGlvbiwKPnRoZW4gc3RhcnQgYSB0aW1lciB0byB3YWl0IGZvciB0
aGUgc2VydmVyJ3MgcmVzcG9uc2UuIFdoZW4gdGhlIHNlcnZlcidzCj5SRVNQT05TRSBtZXNzYWdl
IGFycml2ZXMsIHRoZSB0aW1lciBhbHNvIHRpbWVzIG91dCBhbmQgZXhpdHMuIFRoZQo+c2VydmVy
J3MgUkVTUE9OU0UgbWVzc2FnZSBpcyBwcm9jZXNzZWQgZmlyc3QsIGFuZCB0aGUgY29ubmVjdGlv
biBpcwo+ZXN0YWJsaXNoZWQuIEhvd2V2ZXIsIHRoZSBjbGllbnQncyB0aW1lciBhbHNvIHRpbWVz
IG91dCwgdGhlIG9yaWdpbmFsCj5wcm9jZXNzaW5nIGxvZ2ljIG9mIHRoZSBjbGllbnQgaXMgdG8g
ZGlyZWN0bHkgc2V0IHRoZSBzdGF0ZSBvZiB0aGlzIHZzb2NrCj50byBDTE9TRSBhbmQgcmV0dXJu
IEVUSU1FRE9VVC4gSXQgd2lsbCBub3Qgbm90aWZ5IHRoZSBzZXJ2ZXIgd2hlbiB0aGUgcG9ydAo+
aXMgcmVsZWFzZWQsIGNhdXNpbmcgdGhlIHNlcnZlciBwb3J0IHJlbWFpbi4KPndoZW4gY2xpZW50
J3MgdnNvY2tfY29ubmVjdCB0aW1lb3V077yMaXQgc2hvdWxkIGNoZWNrIHNrIHN0YXRlIGlzCj5F
U1RBQkxJU0hFRCBvciBub3QuIGlmIHNrIHN0YXRlIGlzIEVTVEFCTElTSEVELCBpdCBtZWFucyB0
aGUgY29ubmVjdGlvbgo+aXMgZXN0YWJsaXNoZWQsIHRoZSBjbGllbnQgc2hvdWxkIG5vdCBzZXQg
dGhlIHNrIHN0YXRlIHRvIENMT1NFCj4KPk5vdGU6IEkgZW5jb3VudGVyZWQgdGhpcyBpc3N1ZSBv
biBrZXJuZWwtNC4xOCwgd2hpY2ggY2FuIGJlIGZpeGVkIGJ5Cj50aGlzIHBhdGNoLiBUaGVuIEkg
Y2hlY2tlZCB0aGUgbGF0ZXN0IGNvZGUgaW4gdGhlIGNvbW11bml0eQo+YW5kIGZvdW5kIHNpbWls
YXIgaXNzdWUuCj4KPkZpeGVzOiBkMDIxYzM0NDA1MWEgKCJWU09DSzogSW50cm9kdWNlIFZNIFNv
Y2tldHMiKQo+U2lnbmVkLW9mZi1ieTogWmh1YW5nIFNoZW5nZW4gPHpodWFuZ3NoZW5nZW5AaHVh
d2VpLmNvbT4KPi0tLQo+IG5ldC92bXdfdnNvY2svYWZfdnNvY2suYyB8IDIgKy0KPiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKClRoZSBwYXRjaCBMR1RNOgoK
UmV2aWV3ZWQtYnk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4KCkkg
bm90aWNlZCB0aGF0IHRoZSBuZXQgbWFpbnRhaW5lcnMgYXJlIG5vdCBpbiBjYywgaWYgdGhpcyBw
YXRjaCBpc24ndApxdWV1ZWQgaW4gdGhlIG5leHQgZGF5cywgcGxlYXNlIHJlc2VuZCBpdCBieSBj
YydpbmcgYWxsIHRoZQptYWludGFpbmVycyBbMV06CgokIC4vc2NyaXB0cy9nZXRfbWFpbnRhaW5l
ci5wbCBcCiAgIDIwMjMwNTEwX3podWFuZ3NoZW5nZW5fdnNvY2tfYnVnZml4X3BvcnRfcmVzaWR1
ZV9pbl9zZXJ2ZXIubWJ4ClN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4g
KG1haW50YWluZXI6Vk0gU09DS0VUUyAoQUZfVlNPQ0spKQoiRGF2aWQgUy4gTWlsbGVyIiA8ZGF2
ZW1AZGF2ZW1sb2Z0Lm5ldD4gKG1haW50YWluZXI6TkVUV09SS0lORyBbR0VORVJBTF0pCkVyaWMg
RHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT4gKG1haW50YWluZXI6TkVUV09SS0lORyBbR0VO
RVJBTF0pCkpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+IChtYWludGFpbmVyOk5FVFdP
UktJTkcgW0dFTkVSQUxdKQpQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+IChtYWludGFp
bmVyOk5FVFdPUktJTkcgW0dFTkVSQUxdKQp2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZyAob3BlbiBsaXN0OlZNIFNPQ0tFVFMgKEFGX1ZTT0NLKSkKbmV0ZGV2QHZnZXIu
a2VybmVsLm9yZyAob3BlbiBsaXN0OlZNIFNPQ0tFVFMgKEFGX1ZTT0NLKSkKbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZyAob3BlbiBsaXN0KQoKVGhhbmtzLApTdGVmYW5vCgpbMV0gaHR0cHM6
Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC92NC4xNy9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hl
cy5odG1sI3NlbGVjdC10aGUtcmVjaXBpZW50cy1mb3IteW91ci1wYXRjaAoKPgo+ZGlmZiAtLWdp
dCBhL25ldC92bXdfdnNvY2svYWZfdnNvY2suYyBiL25ldC92bXdfdnNvY2svYWZfdnNvY2suYwo+
aW5kZXggNDEzNDA3YmI2NDZjLi5lZmI4YTA5MzdhMTMgMTAwNjQ0Cj4tLS0gYS9uZXQvdm13X3Zz
b2NrL2FmX3Zzb2NrLmMKPisrKyBiL25ldC92bXdfdnNvY2svYWZfdnNvY2suYwo+QEAgLTE0NjIs
NyArMTQ2Miw3IEBAIHN0YXRpYyBpbnQgdnNvY2tfY29ubmVjdChzdHJ1Y3Qgc29ja2V0ICpzb2Nr
LCBzdHJ1Y3Qgc29ja2FkZHIgKmFkZHIsCj4gCQkJdnNvY2tfdHJhbnNwb3J0X2NhbmNlbF9wa3Qo
dnNrKTsKPiAJCQl2c29ja19yZW1vdmVfY29ubmVjdGVkKHZzayk7Cj4gCQkJZ290byBvdXRfd2Fp
dDsKPi0JCX0gZWxzZSBpZiAodGltZW91dCA9PSAwKSB7Cj4rCQl9IGVsc2UgaWYgKChzay0+c2tf
c3RhdGUgIT0gVENQX0VTVEFCTElTSEVEKSAmJiAodGltZW91dCA9PSAwKSkgewo+IAkJCWVyciA9
IC1FVElNRURPVVQ7Cj4gCQkJc2stPnNrX3N0YXRlID0gVENQX0NMT1NFOwo+IAkJCXNvY2stPnN0
YXRlID0gU1NfVU5DT05ORUNURUQ7Cj4tLSAKPjIuMjcuMAo+CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
