Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93321C77B7F
	for <virtualization@archiver.kernel.org>; Fri, 19 May 2023 09:52:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F264140494;
	Fri, 19 May 2023 09:52:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F264140494
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=nYxSjSYc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N4Bk45HLH2lA; Fri, 19 May 2023 09:52:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 86403400C7;
	Fri, 19 May 2023 09:52:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 86403400C7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C934C0036;
	Fri, 19 May 2023 09:52:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65F37C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 May 2023 09:52:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 47DC883123
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 May 2023 09:52:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 47DC883123
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20221208 header.b=nYxSjSYc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s7l-0ajLzlKl
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 May 2023 09:52:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5507A83112
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5507A83112
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 May 2023 09:52:03 +0000 (UTC)
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-62381fe42b3so13771056d6.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 May 2023 02:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684489922; x=1687081922;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lYlFoKtA5IkPlUC08PPhE1HRAZ9SjNGPuMwfpP8csYw=;
 b=nYxSjSYcaXL9wBLYYxr18nPzFhoS6t/XMYh9wWv4olQ5Ajdh0ltDPhpnV6tMT0kw2L
 7PVzfD8g+760Xthp7t3msGPUjuZ59gQw4rwzaEmCtQ8hyGpsue8N+xUoLitFBMGgdB9W
 jVGc5vSq1XyykVvXwliYjJhs52PRT3SjBYJ7iwE5d7/KP6vVYRumAVbxhCiJ5soKreN4
 brAcrHDbctTGfUlLlmhxftAZM3pPIDGyFEnEQC4iY77FwsJnKWjlVhqa4CFYiyr2O4Qf
 7YR2QIMjUYV5AhK5aiXR9mtSexGX2S4hbthpMwYW3yJ58fFaMoJ96fz6odyG79IA5mY6
 tJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684489922; x=1687081922;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lYlFoKtA5IkPlUC08PPhE1HRAZ9SjNGPuMwfpP8csYw=;
 b=Inxo3Xfi5X31S7CrW+S5PzuGEZZ0aTbFsnuikYIlTnfbxWEFWmpl+BB4nOHhiLBAIG
 azs31rrAsyG+euTuPuVSm5Ho11hZGOuyPiwKnr1llOeS4bBQYPRYsNrzgM1amMhQbvAf
 TDPhSmEvJFwSZD8EWcLRXpK5amqFnD508YerMr/qEfCgSIqlsHOW37GWs8ejTxywaY6k
 WhUVqI4QxJVX2RGLxrPcR4wSUW5wwFd8tcllTIf1Fc+NLff2cHPjrqX/LUmpFTleicay
 OgEvvo/LCra1THfELKucbtF1DszNGFqFrf6D1DKvPjCrkLF1A25p9Abrsu6Zn1nnc9YX
 py2w==
X-Gm-Message-State: AC+VfDx6F1KhQWytnCwdMOqMyJnyihv4cnZ9ZkgYcianrsyXQfPaPvG/
 1+CuBt+XBXXoNKngySipyvX8e2KuqMHBXxNgJCs=
X-Google-Smtp-Source: ACHHUZ5LXB2GGpTth50QwGaF1r9ATLp3VHmm5/m7EW57RPp9upvSN9LQS14BGDeYC2Kr+/Vi0wX8BeWxerm5Q629S9k=
X-Received: by 2002:a05:6214:5183:b0:61a:fe65:4481 with SMTP id
 kl3-20020a056214518300b0061afe654481mr2595650qvb.51.1684489921968; Fri, 19
 May 2023 02:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230516193549.544673-1-arnd@kernel.org>
 <a78d9dcd-0bc1-7e98-a8f1-e5d6cd0c09a3@intel.com>
In-Reply-To: <a78d9dcd-0bc1-7e98-a8f1-e5d6cd0c09a3@intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 19 May 2023 12:51:25 +0300
Message-ID: <CAHp75VeX9=1+apLMZsidudUziO_s4WUb=HOd0mraRHL17DN+cw@mail.gmail.com>
Subject: Re: [PATCH 00/20] x86: address -Wmissing-prototype warnings
To: Dave Hansen <dave.hansen@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, linux-pci@vger.kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Alexey Makhalov <amakhalov@vmware.com>, Thomas Gleixner <tglx@linutronix.de>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Darren Hart <dvhart@infradead.org>, linux-trace-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, xen-devel@lists.xenproject.org,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 platform-driver-x86@vger.kernel.org, Juergen Gross <jgross@suse.com>,
 Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Andy Shevchenko <andy@infradead.org>
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

T24gRnJpLCBNYXkgMTksIDIwMjMgYXQgMTI6NTbigK9BTSBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5z
ZW5AaW50ZWwuY29tPiB3cm90ZToKPiBPbiA1LzE2LzIzIDEyOjM1LCBBcm5kIEJlcmdtYW5uIHdy
b3RlOgoKPiBJIHBpY2tlZCB1cCB0aGUgb25lcyB0aGF0IHdlcmUgYmxhdGFudGx5IG9idmlvdXMs
IGJ1dCBsZWZ0IG91dCAwMywgMDQsCj4gMTAsIDEyIGFuZCAxOSBmb3IgdGhlIG1vbWVudC4KCkJ0
dywgdGhlcmUgaXMgc2VyaWVzIHRoYXQgd2VudCB1bm5vdGljZWQKCmh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FsbC8yMDIxMTExOTExMDAxNy40ODUxMC0xLWFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4
LmludGVsLmNvbS8KCkkgZHVubm8gd2h5LgoKLS0gCldpdGggQmVzdCBSZWdhcmRzLApBbmR5IFNo
ZXZjaGVua28KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
