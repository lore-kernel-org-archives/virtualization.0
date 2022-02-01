Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222FEC433F5
	for <virtualization@archiver.kernel.org>; Tue,  1 Feb 2022 07:27:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B01B94096A;
	Tue,  1 Feb 2022 07:27:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EXh_wTC-x9bG; Tue,  1 Feb 2022 07:27:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B672E40120;
	Tue,  1 Feb 2022 07:27:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 941A8C0011;
	Tue,  1 Feb 2022 07:27:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 073B0C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Feb 2022 07:27:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D4C9640959
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Feb 2022 07:27:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Za74rvhW9tbo
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Feb 2022 07:27:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1E01A40120
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Feb 2022 07:27:41 +0000 (UTC)
Received: by mail-pg1-x530.google.com with SMTP id e9so14560397pgb.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jan 2022 23:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:subject:to:cc:message-id:date:user-agent:mime-version
 :content-transfer-encoding:content-language;
 bh=gb6FpjDviXqkxJ6tLKBKooggf+e2HvpPzlaYq1JqIm4=;
 b=bnc/76N1EHpYnVPW0XvmUduROAoPN/BPMdfuK+CbCaGMaDLhq9vVyYnoauw4VUy74M
 goJr9Vz1HZ/knFlNZl3LdsRqn5exiyvIQX7oF1Klbm8vRves0iepp3npexp9I0RM91z6
 B+LVOWEg0833b+k8LBpD4jzy5z172K9hHkAqbLSsiEPsJYn3p0mCW2DI7wau+ryZ7GAv
 /petSKnTeBErJ1rtmG2aMKvd4oGx5YWsRRQMFqZXPK9PMXvU7nq2iXYnCREQ71USITOc
 9b2uZN2O8lkx+N1A0KzvnJUIuU8do4nHw6v+WxEBj2+IGY8z32n9ioLMVuuRVxWTmSIZ
 c9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
 :mime-version:content-transfer-encoding:content-language;
 bh=gb6FpjDviXqkxJ6tLKBKooggf+e2HvpPzlaYq1JqIm4=;
 b=CxgFWqGydcQpQBo/VQtWw6VS3CzxUbRb2/hQjlrPAt491WCHL6UhMb4YkLP1rZSW+H
 uJuMoZbt7efLBhh9dfKB0+pe+isQXLgxxsdjg9uKc+Zz1zAh30WnZAf3gNp9fzFx2wTi
 Z1pFOiHP4mkgJbpWHzRQ+WOEMsMlXzFL6bjSwZBlSVNEBBjrW1U2iWWItmFxI+yYdA7b
 QrPzZvrBD3KfnmiB39jTfRpkKZfNVXyyePlJ0E7t/fpC508jo9rtrW76hoD1CHHOY0CD
 tBhDQo08SrPkLx/jLNNjYcY1prLFRvq9LzDJKQu0lS5HLS18xaa0YVkMSbVBH2Pl8whd
 P4Og==
X-Gm-Message-State: AOAM533yvlB2+nlraUxQoXPUIXVIHAmRaXMN3Se3cGG6Uj0cq+eZWxq+
 2aDB/vt5bGlviODua9NHvkE=
X-Google-Smtp-Source: ABdhPJwE6FampCug81yvTDRInbet6MFgiUScRXkZxzKvq4ickx/7NOJpJQ0E7JVRTT0yev9CkhIFKw==
X-Received: by 2002:a63:1a21:: with SMTP id a33mr19938856pga.35.1643700460589; 
 Mon, 31 Jan 2022 23:27:40 -0800 (PST)
Received: from [10.59.0.6] ([85.203.23.80])
 by smtp.gmail.com with ESMTPSA id c14sm19908190pfm.169.2022.01.31.23.27.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jan 2022 23:27:39 -0800 (PST)
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] vhost: two possible deadlocks involving locking and waiting
To: jasowang@redhat.com
Message-ID: <22f57c53-1a0b-ced9-b36e-1b4de8d55572@gmail.com>
Date: Tue, 1 Feb 2022 15:27:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Language: en-US
Cc: netdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

SGVsbG8sCgpNeSBzdGF0aWMgYW5hbHlzaXMgdG9vbCByZXBvcnRzIHR3byBwb3NzaWJsZSBkZWFk
bG9ja3MgaW4gdGhlIHZob3N0IApkcml2ZXIgaW4gTGludXggNS4xNjoKCiNCVUcgMQp2aG9zdF9u
ZXRfc2V0X2JhY2tlbmQoKQogwqAgbXV0ZXhfbG9jaygmbi0+ZGV2Lm11dGV4KTsgLS0+IExpbmUg
MTUxMShMb2NrIEEpCiDCoCB2aG9zdF9uZXRfdWJ1Zl9wdXRfd2FpdF9hbmRfZnJlZSgpCiDCoMKg
wqAgdmhvc3RfbmV0X3VidWZfcHV0X2FuZF93YWl0KCkKIMKgwqDCoCB3YWl0X2V2ZW50KHVidWZz
LT53YWl0IC4uLik7IC0tPiBMaW5lIDI2MCAoV2FpdCBYKQoKdmhvc3RfbmV0X2lvY3RsKCkKIMKg
IG11dGV4X2xvY2soJm4tPmRldi5tdXRleCk7IC0tPiBMaW5lIDE3MzQgKExvY2sgQSkKIMKgIHZo
b3N0X25ldF9mbHVzaCgpCiDCoMKgwqAgdmhvc3RfbmV0X3VidWZfcHV0X2FuZF93YWl0KCkKIMKg
wqDCoMKgwqAgdmhvc3RfbmV0X3VidWZfcHV0KCkKIMKgwqDCoMKgwqDCoMKgIHdha2VfdXAoJnVi
dWZzLT53YWl0KTsgLS0+IExpbmUgMjUzIChXYWtlIFgpCgpXaGVuIHZob3N0X25ldF9zZXRfYmFj
a2VuZCgpIGlzIGV4ZWN1dGVkLCAiV2FpdCBYIiBpcyBwZXJmb3JtZWQgYnkgCmhvbGRpbmcgIkxv
Y2sgQSIuIElmIHZob3N0X25ldF9pb2N0bCgpIGlzIGV4ZWN1dGVkIGF0IHRoaXMgdGltZSwgIldh
a2UgClgiIGNhbm5vdCBiZSBwZXJmb3JtZWQgdG8gd2FrZSB1cCAiV2FpdCBYIiBpbiB2aG9zdF9u
ZXRfc2V0X2JhY2tlbmQoKSwgCmJlY2F1c2UgIkxvY2sgQSIgaGFzIGJlZW4gYWxyZWFkeSBob2xk
IGJ5IHZob3N0X25ldF9zZXRfYmFja2VuZCgpLCAKY2F1c2luZyBhIHBvc3NpYmxlIGRlYWRsb2Nr
LgoKI0JVRzIKdmhvc3RfbmV0X3NldF9iYWNrZW5kKCkKIMKgIG11dGV4X2xvY2soJnZxLT5tdXRl
eCk7IC0tPiBMaW5lIDE1MjIoTG9jayBBKQogwqAgdmhvc3RfbmV0X3VidWZfcHV0X3dhaXRfYW5k
X2ZyZWUoKQogwqDCoMKgIHZob3N0X25ldF91YnVmX3B1dF9hbmRfd2FpdCgpCiDCoMKgwqAgd2Fp
dF9ldmVudCh1YnVmcy0+d2FpdCAuLi4pOyAtLT4gTGluZSAyNjAgKFdhaXQgWCkKCmhhbmRsZV90
eCgpCiDCoCBtdXRleF9sb2NrX25lc3RlZCgmdnEtPm11dGV4LCAuLi4pOyAtLT4gTGluZSA5NjYg
KExvY2sgQSkKIMKgIGhhbmRsZV90eF96ZXJvY29weSgpCiDCoMKgwqAgdmhvc3RfbmV0X3VidWZf
cHV0KCkKIMKgwqDCoMKgwqAgd2FrZV91cCgmdWJ1ZnMtPndhaXQpOyAtLT4gTGluZSAyNTMgKFdh
a2UgWCkKCldoZW4gdmhvc3RfbmV0X3NldF9iYWNrZW5kKCkgaXMgZXhlY3V0ZWQsICJXYWl0IFgi
IGlzIHBlcmZvcm1lZCBieSAKaG9sZGluZyAiTG9jayBBIi4gSWYgaGFuZGxlX3R4KCkgaXMgZXhl
Y3V0ZWQgYXQgdGhpcyB0aW1lLCAiV2FrZSBYIiAKY2Fubm90IGJlIHBlcmZvcm1lZCB0byB3YWtl
IHVwICJXYWl0IFgiIGluIHZob3N0X25ldF9zZXRfYmFja2VuZCgpLCAKYmVjYXVzZSAiTG9jayBB
IiBoYXMgYmVlbiBhbHJlYWR5IGhvbGQgYnkgdmhvc3RfbmV0X3NldF9iYWNrZW5kKCksIApjYXVz
aW5nIGEgcG9zc2libGUgZGVhZGxvY2suCgpJIGFtIG5vdCBxdWl0ZSBzdXJlIHdoZXRoZXIgdGhl
c2UgcG9zc2libGUgcHJvYmxlbXMgYXJlIHJlYWwgYW5kIGhvdyB0byAKZml4IHRoZW0gaWYgdGhl
eSBhcmUgcmVhbC4KQW55IGZlZWRiYWNrIHdvdWxkIGJlIGFwcHJlY2lhdGVkLCB0aGFua3MgOikK
CgpCZXN0IHdpc2hlcywKSmlhLUp1IEJhaQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
