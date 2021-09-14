Return-Path: <SRS0=LSNt=OE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF852C433F5
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 05:55:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AD3561151
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 05:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4AD3561151
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 071CC80BED;
	Tue, 14 Sep 2021 05:55:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MQDE1uwFJD1r; Tue, 14 Sep 2021 05:55:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B3F8480BDD;
	Tue, 14 Sep 2021 05:55:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C53AC0011;
	Tue, 14 Sep 2021 05:55:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C2AFC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 05:55:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6625E40183
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 05:55:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RAD1hcx0RFMH
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 05:55:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 43716400C7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 05:55:19 +0000 (UTC)
Received: by mail-pg1-x531.google.com with SMTP id w7so11688699pgk.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 22:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6P3Hg4gutReG5Sbg1AE6RT45vebLhTpUQQ0b1X0Vkms=;
 b=MTzR0KmUJ1q87fdNpZpMK9h6XXbkg3fNZXH1AdkDVsoU3folKJwrb7SxjpFephEJ+s
 Co9XYjV55zRvYYAZqUnw6dO4OMIo8ugxiV0uPZtcCDCHNYWlF++UvRgPoWrYlnf3+3U0
 3Anob837AbiXEBBpPm/SKtgL2qJkxWYS9phkXAGetq1PZCNQZPdzkCxIx5xxDuDLQxN8
 3CbGgvObm98SUG0bw9brVu0UgqOsKtB11gRlqpzemoPM4lmQHqmIVG9OWn0XkMSRb79W
 nFTzBA0FqXd/Kd+xCv1JFnHJkeax4Z+gFbP9DwSy2dC0cdz6pCuDHdB+g7eumCL2TwRJ
 0j3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6P3Hg4gutReG5Sbg1AE6RT45vebLhTpUQQ0b1X0Vkms=;
 b=Okbyp+Xawq1VqthEeF0JbPCGSxDRkMWjnaTf5BMPGNF8RGJQvQrCuW13dWLX2z0NAN
 uTghdsdOH8XutA3wfHgWMNGDOy+PqrMkDOBss5HHGX6jZqmUfVItSGKQgEXm1yv8HHRY
 PjVcFT2rjFUO3bmA/LJGpikX8ci74puRtn9u2LAJJ8S+MS+ZZFW5LnKqx5rPv7Zc3Dt/
 ij6XUi6Nkoi60LpkjrqJT5muHRc/Pw/IvTVVERV8d+Cy2F+P1XooEEcFsPuBVQ2q7FR6
 A5Gc0lE+PNBH4aCPlWXTUcV1GsTnLhgoPuVTD0eBn16vBGdEDaP3S4ge/AqT/nwjozWO
 yV8w==
X-Gm-Message-State: AOAM532N29lhqYMNy72jve7wUGAYaKOoW5gdZTnbSv6pHjo5ijXvFTR0
 74CegOrGLffVJe8NKa2wuZeeKw==
X-Google-Smtp-Source: ABdhPJw5fb14z2YynodbTwMlTVY7BcqTzJq0/T4qCik4yyJ5qrktWf11pHZnIZuysBAmwYQb055O/Q==
X-Received: by 2002:aa7:9115:0:b029:359:69db:bc89 with SMTP id
 21-20020aa791150000b029035969dbbc89mr3185623pfh.32.1631598919355; 
 Mon, 13 Sep 2021 22:55:19 -0700 (PDT)
Received: from ip-10-124-121-13.byted.org
 (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
 by smtp.gmail.com with ESMTPSA id v14sm719432pfi.111.2021.09.13.22.55.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 22:55:18 -0700 (PDT)
From: Jiang Wang <jiang.wang@bytedance.com>
To: jiangleetcode@gmail.com
Subject: [RFC v2 0/5] virtio/vsock: introduce SOCK_DGRAM support
Date: Tue, 14 Sep 2021 05:54:33 +0000
Message-Id: <20210914055440.3121004-1-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: cong.wang@bytedance.com, duanxiongchun@bytedance.com, kvm@vger.kernel.org,
 mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, stefanha@redhat.com,
 Jakub Kicinski <kuba@kernel.org>, arseny.krasnov@kaspersky.com,
 Ingo Molnar <mingo@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 jhansen@vmware.com
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

VGhpcyBwYXRjaHNldCBpbXBsZW1lbnRzIHN1cHBvcnQgb2YgU09DS19ER1JBTSBmb3IgdmlydGlv
CnRyYW5zcG9ydC4KCkRhdGFncmFtIHNvY2tldHMgYXJlIGNvbm5lY3Rpb25sZXNzIGFuZCB1bnJl
bGlhYmxlLiBUbyBhdm9pZCB1bmZhaXIgY29udGVudGlvbgp3aXRoIHN0cmVhbSBhbmQgb3RoZXIg
c29ja2V0cywgYWRkIHR3byBtb3JlIHZpcnRxdWV1ZXMgYW5kCmEgbmV3IGZlYXR1cmUgYml0IHRv
IGluZGljYXRlIGlmIHRob3NlIHR3byBuZXcgcXVldWVzIGV4aXN0IG9yIG5vdC4KCkRncmFtIGRv
ZXMgbm90IHVzZSB0aGUgZXhpc3RpbmcgY3JlZGl0IHVwZGF0ZSBtZWNoYW5pc20gZm9yCnN0cmVh
bSBzb2NrZXRzLiBXaGVuIHNlbmRpbmcgZnJvbSB0aGUgZ3Vlc3QvZHJpdmVyLCBzZW5kaW5nIHBh
Y2tldHMKc3luY2hyb25vdXNseSwgc28gdGhlIHNlbmRlciB3aWxsIGdldCBhbiBlcnJvciB3aGVu
IHRoZSB2aXJ0cXVldWUgaXMgZnVsbC4KV2hlbiBzZW5kaW5nIGZyb20gdGhlIGhvc3QvZGV2aWNl
LCBzZW5kIHBhY2tldHMgYXN5bmNocm9ub3VzbHkKYmVjYXVzZSB0aGUgZGVzY3JpcHRvciBtZW1v
cnkgYmVsb25ncyB0byB0aGUgY29ycmVzcG9uZGluZyBRRU1VCnByb2Nlc3MuCgpUaGUgdmlydGlv
IHNwZWMgcGF0Y2ggaXMgaGVyZToKaHR0cHM6Ly93d3cubWFpbC1hcmNoaXZlLmNvbS92aXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZy9tc2c0NzQ1Ny5odG1sCgpGb3IgdGhv
c2Ugd2hvIHByZWZlciBnaXQgcmVwbywgaGVyZSBpcyB0aGUgbGluayBmb3IgdGhlIGxpbnV4IGtl
cm5lbO+8mgpodHRwczovL2dpdGh1Yi5jb20vSmlhbmcxMTU1L2xpbnV4L3RyZWUvdnNvY2stZGdy
YW0tdjIKCnFlbXUgcGF0Y2ggbGluazoKaHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRt
bC9xZW11LWRldmVsLzIwMjEtMDkvbXNnMDM0NjIuaHRtbAoKClRvIGRvOgoxLiB1c2Ugc2tiIHdo
ZW4gcmVjZWl2aW5nIHBhY2tldHMKMi4gc3VwcG9ydCBtdWx0aXBsZSB0cmFuc3BvcnQKMy4gc3Vw
cG9ydCBtZXJnZWFibGUgcnggYnVmZmVyCjQuIHN1cHBvcnQgZGlzYWJsaW5nIEZfU1RSRUFNIGZl
YXR1cmUgYml0CgoKdjEgLT4gdjIgOgogIC0gZml4IG1pZ3JhdGlvbiBidWcgaW4gdmhvc3QtdnNv
Y2sKICAtIHJlbmFtZSBzb21lIHZhcmlhYmxlcwogIC0gY2xlYW4gdXAgc29tZSBjb2RlIGluIHZp
cnRpby12c29jawogIC0gdXNlIGxlX3RvX2NwdTE2IGluIHZpcnRpby12c29jawoKCgpKaWFuZyBX
YW5nICg1KToKICB2aXJ0aW8vdnNvY2s6IGFkZCBWSVJUSU9fVlNPQ0tfRl9ER1JBTSBmZWF0dXJl
IGJpdAogIHZpcnRpby92c29jazogYWRkIHN1cHBvcnQgZm9yIHZpcnRpbyBkYXRhZ3JhbQogIHZo
b3N0L3Zzb2NrOiBhZGQgc3VwcG9ydCBmb3Igdmhvc3QgZGdyYW0uCiAgdnNvY2tfdGVzdDogYWRk
IHRlc3RzIGZvciB2c29jayBkZ3JhbQogIHZpcnRpby92c29jazogYWRkIHN5c2ZzIGZvciByeCBi
dWYgbGVuIGZvciBkZ3JhbQoKIGRyaXZlcnMvdmhvc3QvdnNvY2suYyAgICAgICAgICAgICAgICAg
ICAgICAgICB8IDIyMCArKysrKysrLS0KIGluY2x1ZGUvbGludXgvdmlydGlvX3Zzb2NrLmggICAg
ICAgICAgICAgICAgICB8ICAgOSArCiBpbmNsdWRlL25ldC9hZl92c29jay5oICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgIDEgKwogLi4uL2V2ZW50cy92c29ja192aXJ0aW9fdHJhbnNwb3J0X2Nv
bW1vbi5oICAgIHwgICAyICsKIGluY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fdnNvY2suaCAgICAg
ICAgICAgICB8ICAgMyArCiBuZXQvdm13X3Zzb2NrL2FmX3Zzb2NrLmMgICAgICAgICAgICAgICAg
ICAgICAgfCAgMTIgKwogbmV0L3Ztd192c29jay92aXJ0aW9fdHJhbnNwb3J0LmMgICAgICAgICAg
ICAgIHwgNDYzICsrKysrKysrKysrKysrKy0tLQogbmV0L3Ztd192c29jay92aXJ0aW9fdHJhbnNw
b3J0X2NvbW1vbi5jICAgICAgIHwgMTgxICsrKysrKy0KIHRvb2xzL3Rlc3RpbmcvdnNvY2svdXRp
bC5jICAgICAgICAgICAgICAgICAgICB8IDEwNSArKysrCiB0b29scy90ZXN0aW5nL3Zzb2NrL3V0
aWwuaCAgICAgICAgICAgICAgICAgICAgfCAgIDQgKwogdG9vbHMvdGVzdGluZy92c29jay92c29j
a190ZXN0LmMgICAgICAgICAgICAgIHwgMTk1ICsrKysrKysrCiAxMSBmaWxlcyBjaGFuZ2VkLCAx
MDgzIGluc2VydGlvbnMoKyksIDExMiBkZWxldGlvbnMoLSkKCi0tIAoyLjIwLjEKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
