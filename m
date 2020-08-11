Return-Path: <SRS0=ofWe=BV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2512C433DF
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 17:10:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77E262076B
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 17:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rCvCwWWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E262076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DFBA687DA8;
	Tue, 11 Aug 2020 17:10:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7aNbrlI6zny3; Tue, 11 Aug 2020 17:10:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E8AA787D77;
	Tue, 11 Aug 2020 17:10:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0E87C07FF;
	Tue, 11 Aug 2020 17:10:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B1C9C004D
 for <virtualization@lists.linuxfoundation.org>;
 Tue, 11 Aug 2020 17:10:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0954D2286F
 for <virtualization@lists.linuxfoundation.org>;
 Tue, 11 Aug 2020 17:10:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MKIIKemXr6ZX
 for <virtualization@lists.linuxfoundation.org>;
 Tue, 11 Aug 2020 17:10:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by silver.osuosl.org (Postfix) with ESMTPS id B50742286C
 for <virtualization@lists.linuxfoundation.org>;
 Tue, 11 Aug 2020 17:10:16 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id f7so12196140wrw.1
 for <virtualization@lists.linuxfoundation.org>;
 Tue, 11 Aug 2020 10:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=user-agent:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9xt9WvCDwPAF46nZSYdCYDyto4AVQaSEzBkuT0tn4tU=;
 b=rCvCwWWFc50fuCoIXhBGW+OMWAK7X+x6junD3Y1743edt1HEKbib56N9smcLzuJiVY
 3DU1Ni7qrGz+7bHOer0tSnhLc/1SQpYwplHgum8Nq1Y3PVtS47RBlWGvZz9hcD7Pb1Md
 F5Df6ZUf2G0BqbQvURz6vu9z92Ul4vphP0dnhjF0LwTjehXAYSqBZFkPu/TMgNAkEY3H
 To8BDWlMFA8obZEn/wC61yHjo3zBl0FtrecTGs60wiGxn7W6jzuR4PbfmKT1CcuLlITK
 72khpa6PEXkOW/ZYtI/88K9mrEIr2A92Aj/7fzT/ZKLJQblKhugb1rt/UyV9GFJ814Vx
 Uvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:user-agent:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=9xt9WvCDwPAF46nZSYdCYDyto4AVQaSEzBkuT0tn4tU=;
 b=lbnhczi9BT8LY3YcPf/ZLbnn+2oOEmXQaz8a/jjXvrLrH3+H8BtI3fZuFw9vMlu7XK
 hr5FGyCa2VsuwegCp5m4c81MNZfLQxvMBm7stMWDQkURhFfdbkbfTIxXJxGUqa7l3PpW
 Ac0G9l0G3/52CzutFudg4QoC28veou05+CCk+ljsPOibYto8rowp8WgNS/DvWzYmQkXG
 qPyRlMaHzZyIDpXU/O9VkyFzO0MQzXJzlymiryMQhxUlwjWmZX0a4xCtkTb0KqsBtRql
 CJuFNX2Y5lKh33Mt5OUbHeuNO0w4TiSVbqyvjoQf4aYpyO5NnAa5BF+YIVXLhOp6nSVH
 QoDg==
X-Gm-Message-State: AOAM532N+vjgClD88YWLRC0tDyYdy+/zvXGjE9d6wi3BkO3k1awbaiQ4
 hdbHITQQtjP/Ifmf6ZKebefaww==
X-Google-Smtp-Source: ABdhPJwW+0ONnRg6KgrxMAvhsJ+GUsP4yn0Oe9slKpVe7EEG6Mnsial520wbmBVq9PyV6rySig7OJA==
X-Received: by 2002:adf:e902:: with SMTP id f2mr29639006wrm.174.1597165815195; 
 Tue, 11 Aug 2020 10:10:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n11sm5752011wmi.15.2020.08.11.10.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 10:10:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AA7E61FF7E;
 Tue, 11 Aug 2020 18:10:12 +0100 (BST)
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: virtio-dev@lists.oasis-open.org, virtualization@lists.linuxfoundation.org
Subject: clarifying the handling of responses for virtio-rpmb
Date: Tue, 11 Aug 2020 18:10:12 +0100
Message-ID: <87sgct153f.fsf@linaro.org>
MIME-Version: 1.0
Cc: Tomas Winkler <tomas.winkler@intel.com>,
 "Michael S.Tsirkin" <mst@redhat.com>, "Zhu, Bing" <bing.zhu@intel.com>,
 Yang Huang <yang.huang@intel.com>
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

CkhpLAoKVGhlIHNwZWNpZmljYXRpb24gbGlzdHMgYSBudW1iZXIgb2YgY29tbWFuZHMgdGhhdCBo
YXZlIHJlc3BvbnNlczoKCiAgVGhlIG9wZXJhdGlvbiBvZiBhIHZpcnRpbyBSUE1CIGRldmljZSBp
cyBkcml2ZW4gYnkgdGhlIHJlcXVlc3RzIHBsYWNlZAogIG9uIHRoZSB2aXJ0cXVldWUuIFRoZSB0
eXBlIG9mIHJlcXVlc3QgY2FuIGJlIHByb2dyYW0ga2V5CiAgKFZJUlRJT19SUE1CX1JFUV9QUk9H
UkFNX0tFWSksIGdldCB3cml0ZSBjb3VudGVyCiAgKFZJUlRJT19SUE1CX1JFUV9HRVRfV1JJVEVf
Q09VTlRFUiksIHdyaXRlCiAgKFZJUlRJT19SUE1CX1JFUV9EQVRBX1dSSVRFKSwgYW5kIHJlYWQg
KFZJUlRJT19SUE1CX1JFUV9EQVRBX1JFQUQpLiBBCiAgcHJvZ3JhbSBrZXkgb3Igd3JpdGUgcmVx
dWVzdCBjYW4gYWxzbyBjb21iaW5lIHdpdGggYSByZXN1bHQgcmVhZAogIChWSVJUSU9fUlBNQl9S
RVFfUkVTVUxUX1JFQUQpIGZvciBhIHJldHVybmVkIHJlc3VsdC4KCk5vdyBJJ20gZGVlcCBpbiB0
aGUgZ3V0cyBvZiB2aXJ0IHF1ZXVlcyBkb2luZyB0aGUgaW1wbGVtZW50YXRpb24gSSdtCnRyeWlu
ZyB0byBjbGFyaWZ5IGV4YWN0bHkgd2hhdCBmcmFtZXMgc2hvdWxkIGJlIHNlbnQgdG8gdGhlIGRl
dmljZSBhbmQKaWYgdGhleSBzaG91bGQgYmUgb3V0X3NncyBvciBpbl9zZ3MuIEkgc3VzcGVjdCB0
aGVyZSBpcyBzb21lIGRpZmZlcmVuY2UKYmV0d2VlbiB0aGUgb3JpZ2luYWwgcHJvdG90eXBlIGlu
dGVyZmFjZSBhbmQgd2hhdCB3ZSBoYXZlIG5vdy4KClNvbWUgb3BlcmF0aW9ucyBvYnZpb3VzbHkg
aGF2ZSBhbiBpbXBsaWVkIHJlc3BvbnNlCihWSVJUSU9fUlBNQl9SRVFfR0VUX1dSSVRFX0NPVU5U
RVIgYW5kIFZJUlRJT19SUE1CX1JFUV9EQVRBX1JFQUQpLiBBcwpmYXIgYXMgSSBjb3VsZCB0ZWxs
IHRoZSBmcmFtZSBzaG91bGQgYmUgc2ltcGxlOgoKICBzZ1swXSAob3V0X3NnPTEpIC0gZnJhbWUg
d2l0aCBjb21tYW5kCiAgc2dbMS4ubl0gKGluX3NnPTEuLm4pIC0gc3BhY2UgZm9yIHRoZSByZXBs
eSB0byBiZSBmaWxsZWQgaW4gYnkgdGhlIGRldmljZQoKSG93ZXZlciB0aGUgbGFuZ3VhZ2UgZm9y
IHRoZSBwcm9ncmFtIGtleSBhbmQgZGF0YSB3cml0ZSBzYXkgdGhleSBjYW4gYmUKY29tYmluZWQg
d2l0aCBhIFZJUlRJT19SUE1CX1JFUV9SRVNVTFRfUkVBRCB0byBvcHRpb25hbGx5IHJldHVybiBh
CnJlc3VsdC4gTXkgcXVlc3Rpb24gaXMgaXMgdGhpcyByZXN1bHQgcmVhZCBtZWFudCB0byBiZSBp
biBhIHNlcGFyYXRlCnJlcXVlc3QgZnJhbWUgYW5kIHJlc3BvbnNlIGZyYW1lIHNvIHlvdSBnZXQ6
Cgogc2dbMF0gLSBWSVJUSU9fUlBNQl9SRVFfUFJPR1JBTV9LRVkvVklSVElPX1JQTUJfUkVRX0RB
VEFfV1JJVEUgZnJhbWUKIHNnWzFdIC0gVklSVElPX1JQTUJfUkVRX1JFU1VMVF9SRUFEIChvdXRf
c2c9MikKIHNnWzJdIC0gZW1wdHkgZnJhbWUgZm9yIHJlc3BvbnNlIChpbl9zZz0xKQoKb3I6Cgog
c2dbMF0gLSBWSVJUSU9fUlBNQl9SRVFfUFJPR1JBTV9LRVkvVklSVElPX1JQTUJfUkVRX0RBVEFf
V1JJVEUgZnJhbWUgKG91dF9zZz0xKQogc2dbMV0gLSBWSVJUSU9fUlBNQl9SRVFfUkVTVUxUX1JF
QUQgKGluX3NnPTEpCgp3aGVyZSB0aGUgcmVzdWx0IGZyYW1lIGlzIGZpbGxlZCBpbiBhbmQgc2Vu
dCBiYWNrPwoKSSBtdXN0IHNheSBJJ20gYSBsaXR0bGUgY29uZnVzZWQgYnkgdGhlIGxvZ2ljIGlu
IHJwbWJfaW9jdGwgKGluIHRoZQp1c2Vyc3BhY2UgdG9vbCkgd2hpY2ggY3JlYXRlcyBib3RoIG91
dF9mcmFtZXMgYW5kIHJlc3AgZnJhbWVzOgoKICBzdGF0aWMgaW50IHJwbWJfaW9jdGwodWludDhf
dCBmcmFtZV90eXBlLCBpbnQgZmQsIHVpbnQxNl90IHJlcSwKICAgICAgICAgICAgICAgICAgICAg
ICAgY29uc3Qgdm9pZCAqZnJhbWVzX2luLCB1bnNpZ25lZCBpbnQgY250X2luLAogICAgICAgICAg
ICAgICAgICAgICAgICB2b2lkICpmcmFtZXNfb3V0LCB1bnNpZ25lZCBpbnQgY250X291dCkKICB7
CiAgICAgICAgICBpbnQgcmV0OwogICAgICAgICAgc3RydWN0IF9fcGFja2VkIHsKICAgICAgICAg
ICAgICAgICAgc3RydWN0IHJwbWJfaW9jX3NlcV9jbWQgaDsKICAgICAgICAgICAgICAgICAgc3Ry
dWN0IHJwbWJfaW9jX2NtZCBjbWRbM107CiAgICAgICAgICB9IGlzZXEgPSB7fTsKCiAgICAgICAg
ICB2b2lkICpmcmFtZV9yZXMgPSBOVUxMOwogICAgICAgICAgaW50IGk7CiAgICAgICAgICB1aW50
MzJfdCBmbGFnczsKCiAgICAgICAgICBycG1iX2RiZygiUlBNQiBPUDogJXNcbiIsIHJwbWJfb3Bf
c3RyKHJlcSkpOwogICAgICAgICAgZGJnX2R1bXBfZnJhbWUoZnJhbWVfdHlwZSwgIkluIEZyYW1l
OiAiLCBmcmFtZXNfaW4sIGNudF9pbik7CgogICAgICAgICAgaSA9IDA7CiAgICAgICAgICBmbGFn
cyA9IFJQTUJfRl9XUklURTsKICAgICAgICAgIGlmIChyZXEgPT0gUlBNQl9XUklURV9EQVRBIHx8
IHJlcSA9PSBSUE1CX1BST0dSQU1fS0VZKQogICAgICAgICAgICAgICAgICBmbGFncyB8PSBSUE1C
X0ZfUkVMX1dSSVRFOwogICAgICAgICAgcnBtYl9pb2NfY21kX3NldChpc2VxLmNtZFtpXSwgZmxh
Z3MsIGZyYW1lc19pbiwgY250X2luKTsKICAgICAgICAgIGkrKzsKCiAgICAgICAgICBpZiAocmVx
ID09IFJQTUJfV1JJVEVfREFUQSB8fCByZXEgPT0gUlBNQl9QUk9HUkFNX0tFWSkgewogICAgICAg
ICAgICAgICAgICBmcmFtZV9yZXMgPSBycG1iX2ZyYW1lX2FsbG9jKGZyYW1lX3R5cGUsIDApOwog
ICAgICAgICAgICAgICAgICBpZiAoIWZyYW1lX3JlcykKICAgICAgICAgICAgICAgICAgICAgICAg
ICByZXR1cm4gLUVOT01FTTsKICAgICAgICAgICAgICAgICAgcnBtYl9mcmFtZV9zZXQoZnJhbWVf
dHlwZSwgZnJhbWVfcmVzLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSUE1CX1JF
U1VMVF9SRUFELCAwLCAwLCAwKTsKICAgICAgICAgICAgICAgICAgcnBtYl9pb2NfY21kX3NldChp
c2VxLmNtZFtpXSwgUlBNQl9GX1dSSVRFLCBmcmFtZV9yZXMsIDApOwogICAgICAgICAgICAgICAg
ICBpKys7CiAgICAgICAgICB9CgogICAgICAgICAgcnBtYl9pb2NfY21kX3NldChpc2VxLmNtZFtp
XSwgMCwgZnJhbWVzX291dCwgY250X291dCk7CiAgICAgICAgICBpKys7CgogICAgICAgICAgaXNl
cS5oLm51bV9vZl9jbWRzID0gaTsKICAgICAgICAgIHJldCA9IGlvY3RsKGZkLCBSUE1CX0lPQ19T
RVFfQ01ELCAmaXNlcSk7CiAgICAgICAgICBpZiAocmV0IDwgMCkKICAgICAgICAgICAgICAgICAg
cnBtYl9lcnIoImlvY3RsIGZhaWx1cmUgJWQ6ICVzLlxuIiwgcmV0LCBzdHJlcnJvcihlcnJubykp
OwoKICAgICAgICAgIHJldCA9IHJwbWJfY2hlY2tfcmVxX3Jlc3AoZnJhbWVfdHlwZSwgcmVxLCBm
cmFtZXNfb3V0KTsKCiAgICAgICAgICBkYmdfZHVtcF9mcmFtZShmcmFtZV90eXBlLCAiUmVzIEZy
YW1lOiAiLCBmcmFtZV9yZXMsIDEpOwogICAgICAgICAgZGJnX2R1bXBfZnJhbWUoZnJhbWVfdHlw
ZSwgIk91dCBGcmFtZTogIiwgZnJhbWVzX291dCwgY250X291dCk7CiAgICAgICAgICBmcmVlKGZy
YW1lX3Jlcyk7CiAgICAgICAgICByZXR1cm4gcmV0OwogIH0KCmFsdGhvdWdoIEknbSBndWVzc2lu
ZyB0aGlzIG1pZ2h0IGp1c3QgYmUgYW4gaW1wZWRhbmNlIGJldHdlZW4gdGhlCmNoYXJkZXYgaW9j
dGwgaW50ZXJmYWNlIGZvciBycG1iIGFuZCB0aGUgdmlydGlvIEZFIGRyaXZlciB3aGljaCBpcyBv
bmx5Cm9uZSBwb3RlbnRpYWwgY29uc3VtZXIgb2YgdGhlc2UgcnBtYiBpb2MgY29tbWFuZHM/IAoK
Q2FuIGFueW9uZSBjbGFyaWZ5PwoKLS0gCkFsZXggQmVubsOpZQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
