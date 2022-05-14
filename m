Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43186C433F5
	for <virtualization@archiver.kernel.org>; Sat, 14 May 2022 00:59:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E67D640441;
	Sat, 14 May 2022 00:59:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9TCouFkhwNiU; Sat, 14 May 2022 00:59:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 90706404AB;
	Sat, 14 May 2022 00:59:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5BE71C0039;
	Sat, 14 May 2022 00:59:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB624C0081
 for <virtualization@lists.linux-foundation.org>;
 Sat, 14 May 2022 00:59:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8ABEF418B5
 for <virtualization@lists.linux-foundation.org>;
 Sat, 14 May 2022 00:59:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lJdmojX_q6E7
 for <virtualization@lists.linux-foundation.org>;
 Sat, 14 May 2022 00:59:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A9032418A5
 for <virtualization@lists.linux-foundation.org>;
 Sat, 14 May 2022 00:59:26 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 cu23-20020a17090afa9700b001d98d8e53b7so9119785pjb.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 17:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ebyq3t0cku0JBJko0+i5+pZ5xMWPYwbiZj5xlzmmt5U=;
 b=MBM+xEUOV19dRN+3DfVQA7Wlr9RpJkVWY8j/eTWiojTA5dkgFe6+3neEqo7JubjKtV
 XvfkYqNg+NUWejB12xLuq45dBG/PbfdWWZQEf2YAOR0Pbekpj6/4D+RYIBkPT9FzuvA+
 gioijVsC0q1qEHfBkG5Tm2YnZXs26WH8kaZ4FlR0Yx2UnlQKH5o2kGS4J5jEzkDXDIXw
 xGCs+y+KcEdCFBkPdwpi4jPB7bmAFvrddCAvr6c3E5lxWG7Tj9FzCigYamlC2kK9xFpx
 6bWy/h0SVYsROsoEw+LtVwJ1//xKFkQM4l0cQhmpvPGCZMf+5EUVBhuKoqD3Tce/zpLb
 Kqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ebyq3t0cku0JBJko0+i5+pZ5xMWPYwbiZj5xlzmmt5U=;
 b=HuAfIp7kDzMZz4X61Tbi06ZxwkqrUNjTX1HRitqr0aZoiAvZup/OVu9tnwgvDn5gX6
 uL7JbVh0Dc5vDuHhp5y1NemyBTxvqjftHy/qW2oZIxAeYD2kb7GfAZSF//dJWV+QPTGK
 CcAZcFJ9cyWeuQhspNLbNGdMQB/4TpGjQXQi0kM/Qe0R7ZvXITe8qdrz86wyuR0ZUk+F
 V8Z8HAFTjjHBA1bo0s8IKwyhdkevvejzmIAQf2PS27TepLPMAboipTmt38VAkSGnm8af
 Tv1NlKPJJSbPiS1pFlxXKqO/bukMtqdrFAIbsn4VjhgNmt7nGswGNTVYyB0F9lMmMLPG
 jcXA==
X-Gm-Message-State: AOAM531UIpxADGIGod4vss3IDqFbs6OwhvNc0lu3tRF9JC/5P5p8khDx
 C9SpJLDRDREy+1w4EEF+gMufJA==
X-Google-Smtp-Source: ABdhPJzdAV0iF8UJoVcS0p3PX/NAJVEJigVxH/GqJRP+2QqddMhi0uaS33V2DwRh1MiMUMiE9fnl8A==
X-Received: by 2002:a17:90a:ee96:b0:1dc:6680:6f2d with SMTP id
 i22-20020a17090aee9600b001dc66806f2dmr7516683pjz.174.1652489966136; 
 Fri, 13 May 2022 17:59:26 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.239])
 by smtp.gmail.com with ESMTPSA id
 t24-20020a170902b21800b0015e8d4eb1dbsm2466125plr.37.2022.05.13.17.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 May 2022 17:59:25 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: mst@redhat.com,
	arei.gonglei@huawei.com,
	berrange@redhat.com
Subject: [PATCH v6 2/9] qapi: crypto-akcipher: Introduce akcipher types to qapi
Date: Sat, 14 May 2022 08:54:57 +0800
Message-Id: <20220514005504.1042884-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220514005504.1042884-1-pizhenwei@bytedance.com>
References: <20220514005504.1042884-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Cc: helei.sig11@bytedance.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 pizhenwei@bytedance.com, virtualization@lists.linux-foundation.org,
 linux-crypto@vger.kernel.org
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
