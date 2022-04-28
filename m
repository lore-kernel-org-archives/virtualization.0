Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370ABC433F5
	for <virtualization@archiver.kernel.org>; Thu, 28 Apr 2022 14:04:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB19C83E40;
	Thu, 28 Apr 2022 14:04:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mkoKq35a3DmC; Thu, 28 Apr 2022 14:04:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3C37383E26;
	Thu, 28 Apr 2022 14:04:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6A12C0080;
	Thu, 28 Apr 2022 14:04:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 724F7C0082
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 14:04:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5D06283E14
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 14:04:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sd0qDx8fLsFC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 14:04:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D31A183E0C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 14:04:29 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id
 m14-20020a17090a34ce00b001d5fe250e23so4473480pjf.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 07:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ebyq3t0cku0JBJko0+i5+pZ5xMWPYwbiZj5xlzmmt5U=;
 b=Ewaj6GD+7ylmnl7Nek9NISo81xfEOut07vgy8s3rYiTDvsgLhHLZYC0i3FM+bIkrF9
 egJxdmCLlgMgh3msobyc33KZ+40c0Kr0X72uKjHSvmPApdqXjErVzyoJuP/t7Usddyxs
 V37gmYW40Qs3Pyb3fZqkT70FmE9grSf1HUSiF9gZ95EoAexvJ3y9q4s3gkm/HxzshGuf
 84FHRdEQ7c66VTWyITIZGlJL0u8a8joS8OsOdko7GDzvmQC2mKnZGM4XMAzFyc+aHGdh
 etU1YoD1+CfaiJjDubhco9bEvaUfILSIrCrRf5Yk7xbZLVD5aLbE6xrgDMc6g1LCyVEo
 F14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ebyq3t0cku0JBJko0+i5+pZ5xMWPYwbiZj5xlzmmt5U=;
 b=nBk1+hGjmCWbJuFc2GLYUXCZUuOmOHLyw5PZbOJtDcJxGj9gmyKl/vMeAdh7NLHAV9
 PVTEAbJV1UtSaTQdE/QbiDuASlxDAn/BtVSEpYf8Y26XZ4iREuSGfdc92grglq73DVLn
 5ZNAaxXsSH83yMBHW6zZpw2XzhkeMCKuwKRTzuvKu7NH/bgEumReBzj4lvCEWqBl+b2S
 sdtRs+T1ElIcrr0wU/fA01dNKbW15B3nHf8e4VFn43uR1nB3+KBC2c6yFExknILNKrLF
 nfvbtYRsmHNC2bfokVexU+PFws7AiU4RLZBdf8sJ/Oq7G70n//24K0g/ZjNXEhEk5SAv
 qTJg==
X-Gm-Message-State: AOAM532YmQujFg8yKlmqvDCYE8nLuDeaSDtWZ1LheO+woS87TVScsVZ5
 yVQuvq+fluuVfeLDq53RskLQgw==
X-Google-Smtp-Source: ABdhPJzFXOB4Yvy392O4Xx60+klDrMds8MRiFy7ceV16DQ5b0HI6aGVA1VUPZtKkkrvCgYvI8wN7vQ==
X-Received: by 2002:a17:90b:1b03:b0:1d2:a338:c568 with SMTP id
 nu3-20020a17090b1b0300b001d2a338c568mr50432960pjb.129.1651154669248; 
 Thu, 28 Apr 2022 07:04:29 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.254])
 by smtp.gmail.com with ESMTPSA id
 x129-20020a623187000000b0050835f6d6a1sm38975pfx.9.2022.04.28.07.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 07:04:28 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: mst@redhat.com,
	arei.gonglei@huawei.com,
	berrange@redhat.com
Subject: [PATCH v5 2/9] qapi: crypto-akcipher: Introduce akcipher types to qapi
Date: Thu, 28 Apr 2022 21:59:36 +0800
Message-Id: <20220428135943.178254-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220428135943.178254-1-pizhenwei@bytedance.com>
References: <20220428135943.178254-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Cc: helei.sig11@bytedance.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 zhenwei pi <pizhenwei@bytedance.com>,
 virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org
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

RnJvbTogTGVpIEhlIDxoZWxlaS5zaWcxMUBieXRlZGFuY2UuY29tPgoKSW50cm9kdWNlIGFrY2lw
aGVyIHR5cGVzLCBhbHNvIGluY2x1ZGUgUlNBIHJlbGF0ZWQgdHlwZXMuCgpSZXZpZXdlZC1ieTog
RGFuaWVsIFAuIEJlcnJhbmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT4KU2lnbmVkLW9mZi1ieTog
TGVpIEhlIDxoZWxlaS5zaWcxMUBieXRlZGFuY2UuY29tPgpTaWduZWQtb2ZmLWJ5OiB6aGVud2Vp
IHBpIDxwaXpoZW53ZWlAYnl0ZWRhbmNlLmNvbT4KLS0tCiBxYXBpL2NyeXB0by5qc29uIHwgNjQg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUg
Y2hhbmdlZCwgNjQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3FhcGkvY3J5cHRvLmpzb24g
Yi9xYXBpL2NyeXB0by5qc29uCmluZGV4IDFlYzU0YzE1Y2EuLmY3YmI5YTQyZDAgMTAwNjQ0Ci0t
LSBhL3FhcGkvY3J5cHRvLmpzb24KKysrIGIvcWFwaS9jcnlwdG8uanNvbgpAQCAtNTQwLDMgKzU0
MCw2NyBAQAogICAnZGF0YSc6IHsgJypsb2FkZWQnOiB7ICd0eXBlJzogJ2Jvb2wnLCAnZmVhdHVy
ZXMnOiBbJ2RlcHJlY2F0ZWQnXSB9LAogICAgICAgICAgICAgJypzYW5pdHktY2hlY2snOiAnYm9v
bCcsCiAgICAgICAgICAgICAnKnBhc3N3b3JkaWQnOiAnc3RyJyB9IH0KKyMjCisjIEBRQ3J5cHRv
QWtDaXBoZXJBbGdvcml0aG06CisjCisjIFRoZSBzdXBwb3J0ZWQgYWxnb3JpdGhtcyBmb3IgYXN5
bW1ldHJpYyBlbmNyeXB0aW9uIGNpcGhlcnMKKyMKKyMgQHJzYTogUlNBIGFsZ29yaXRobQorIwor
IyBTaW5jZTogNy4xCisjIworeyAnZW51bSc6ICdRQ3J5cHRvQWtDaXBoZXJBbGdvcml0aG0nLAor
ICAncHJlZml4JzogJ1FDUllQVE9fQUtDSVBIRVJfQUxHJywKKyAgJ2RhdGEnOiBbJ3JzYSddfQor
CisjIworIyBAUUNyeXB0b0FrQ2lwaGVyS2V5VHlwZToKKyMKKyMgVGhlIHR5cGUgb2YgYXN5bW1l
dHJpYyBrZXlzLgorIworIyBTaW5jZTogNy4xCisjIworeyAnZW51bSc6ICdRQ3J5cHRvQWtDaXBo
ZXJLZXlUeXBlJywKKyAgJ3ByZWZpeCc6ICdRQ1JZUFRPX0FLQ0lQSEVSX0tFWV9UWVBFJywKKyAg
J2RhdGEnOiBbJ3B1YmxpYycsICdwcml2YXRlJ119CisKKyMjCisjIEBRQ3J5cHRvUlNBUGFkZGlu
Z0FsZ29yaXRobToKKyMKKyMgVGhlIHBhZGRpbmcgYWxnb3JpdGhtIGZvciBSU0EuCisjCisjIEBy
YXc6IG5vIHBhZGRpbmcgdXNlZAorIyBAcGtjczE6IHBrY3MxI3YxLjUKKyMKKyMgU2luY2U6IDcu
MQorIyMKK3sgJ2VudW0nOiAnUUNyeXB0b1JTQVBhZGRpbmdBbGdvcml0aG0nLAorICAncHJlZml4
JzogJ1FDUllQVE9fUlNBX1BBRERJTkdfQUxHJywKKyAgJ2RhdGEnOiBbJ3JhdycsICdwa2NzMSdd
fQorCisjIworIyBAUUNyeXB0b0FrQ2lwaGVyT3B0aW9uc1JTQToKKyMKKyMgU3BlY2lmaWMgcGFy
YW1ldGVycyBmb3IgUlNBIGFsZ29yaXRobS4KKyMKKyMgQGhhc2gtYWxnOiBRQ3J5cHRvSGFzaEFs
Z29yaXRobQorIyBAcGFkZGluZy1hbGc6IFFDcnlwdG9SU0FQYWRkaW5nQWxnb3JpdGhtCisjCisj
IFNpbmNlOiA3LjEKKyMjCit7ICdzdHJ1Y3QnOiAnUUNyeXB0b0FrQ2lwaGVyT3B0aW9uc1JTQScs
CisgICdkYXRhJzogeyAnaGFzaC1hbGcnOidRQ3J5cHRvSGFzaEFsZ29yaXRobScsCisgICAgICAg
ICAgICAncGFkZGluZy1hbGcnOiAnUUNyeXB0b1JTQVBhZGRpbmdBbGdvcml0aG0nfX0KKworIyMK
KyMgQFFDcnlwdG9Ba0NpcGhlck9wdGlvbnM6CisjCisjIFRoZSBvcHRpb25zIHRoYXQgYXJlIGF2
YWlsYWJsZSBmb3IgYWxsIGFzeW1tZXRyaWMga2V5IGFsZ29yaXRobXMKKyMgd2hlbiBjcmVhdGlu
ZyBhIG5ldyBRQ3J5cHRvQWtDaXBoZXIuCisjCisjIFNpbmNlOiA3LjEKKyMjCit7ICd1bmlvbic6
ICdRQ3J5cHRvQWtDaXBoZXJPcHRpb25zJywKKyAgJ2Jhc2UnOiB7ICdhbGcnOiAnUUNyeXB0b0Fr
Q2lwaGVyQWxnb3JpdGhtJyB9LAorICAnZGlzY3JpbWluYXRvcic6ICdhbGcnLAorICAnZGF0YSc6
IHsgJ3JzYSc6ICdRQ3J5cHRvQWtDaXBoZXJPcHRpb25zUlNBJyB9fQotLSAKMi4yMC4xCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
