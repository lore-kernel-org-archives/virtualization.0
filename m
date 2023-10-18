Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3874CDB47E
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 11:34:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 399E740C1C;
	Wed, 18 Oct 2023 11:34:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 399E740C1C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=b1/MBqY9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IfiFMu1MHDTE; Wed, 18 Oct 2023 11:34:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 96CC2400F2;
	Wed, 18 Oct 2023 11:34:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 96CC2400F2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B8B5C0039;
	Wed, 18 Oct 2023 11:34:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E907AC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 11:34:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BD69340C1C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 11:34:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BD69340C1C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b36cQuWh8PHp
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 11:34:49 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 29C58400F2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 11:34:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 29C58400F2
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9b2f73e3af3so1028606866b.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 04:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697628887; x=1698233687;
 darn=lists.linux-foundation.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=bLIYllS+O6Xd2qzawS5VK1eQ02CDGNfk+dIUUR4Mb9M=;
 b=b1/MBqY9EkCXPSb3M5t2cHc1xHQ71jAvQL24uY77YJcpv+FrrasiPGzHBegKoQ0iLt
 n9vlrREY7kXtvtzm72aQpNqPO5o1oufUjsduUViAq5JfqpZW2Z8rA3fSdUpfgFjXgYUs
 ZfRQT0eJtCpaV3aplOGAmfzqO7o9uMWFzjQzFGz59L06QJRAyZcmUL3jsqQutXpY2kV3
 T2lcDLPpPFM+O7WEo2U2HWF4RNvJL5OfVtuSGgvD+KUI+bULYS0Y/DymifG/eBhLZW0J
 LYhSNwlsbNm/HpQU6otwwFT3/C8R22vm+aZFv+Uw8obm/3nSw2RJq47lgPea8QH+PFoO
 VhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697628887; x=1698233687;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bLIYllS+O6Xd2qzawS5VK1eQ02CDGNfk+dIUUR4Mb9M=;
 b=HaOx8fbmhYcOpLsTvImXrv2Gao/kVEDdseubIvkziGAxTwNK+XWWSLwHv/H25jHBNq
 VP/XES4I44YVXBmcQfYFiSfks5i7B/6Wgnhz/T15VyTO+JfXN/KlFeQZpiVaIpPz7IQP
 w0E+8F+RSqSybUzbm2j8UF6ReYW9TENc0p4wlSSFEKrzOwEnuZwH2v1JcikIY/NmKaCU
 GRXeb7nA4v/rSWteJbOAlwQ0T4FWc77aOlCXEJtfTucDHHTU2uHEofABMsJr2EQlcDMe
 DcAT3qBPqal4s1HkOFe4DZ2olszNXrE9o3HKy1c8TZKx8IMUwxdw/7VMX0eRRSgHuW3o
 8Q8A==
X-Gm-Message-State: AOJu0Yzafay/wMr/tEgaNmHZriTrZsy6ZAewrSMUDlEVxeFpXCj15f7N
 JM0uvay5iMSJO72atIdjqWI=
X-Google-Smtp-Source: AGHT+IEYuZTECiTe/CWO5fzOqWJ8nMXo46EwDgNlRRBWZqPtxnbzqwj6YGcgm9HvKPNlFMhAV6hFaQ==
X-Received: by 2002:a17:906:dac4:b0:9be:dce3:6e07 with SMTP id
 xi4-20020a170906dac400b009bedce36e07mr4461109ejb.32.1697628886950; 
 Wed, 18 Oct 2023 04:34:46 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
 by smtp.gmail.com with ESMTPSA id
 mm27-20020a170906cc5b00b0099e12a49c8fsm1521281ejb.173.2023.10.18.04.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 04:34:46 -0700 (PDT)
Date: Wed, 18 Oct 2023 13:34:44 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2 3/4] x86/paravirt: switch mixed paravirt/alternative
 calls to alternative_2
Message-ID: <ZS/C1HS/EEXTtVji@gmail.com>
References: <20231016123933.17284-1-jgross@suse.com>
 <20231016123933.17284-4-jgross@suse.com>
 <20231016142930.GE33217@noisy.programming.kicks-ass.net>
 <4f5cc965-36da-43f0-aaaa-082a2235ec1e@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4f5cc965-36da-43f0-aaaa-082a2235ec1e@suse.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Alexey Makhalov <amakhalov@vmware.com>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Ajay Kaher <akaher@vmware.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


* Juergen Gross <jgross@suse.com> wrote:

> On 16.10.23 16:29, Peter Zijlstra wrote:
> > On Mon, Oct 16, 2023 at 02:39:32PM +0200, Juergen Gross wrote:
> > > Instead of stacking alternative and paravirt patching, use the new
> > > ALT_FLAG_CALL flag to switch those mixed calls to pure alternative
> > > handling.
> > > 
> > > This eliminates the need to be careful regarding the sequence of
> > > alternative and paravirt patching.
> > > 
> > > For call depth tracking callthunks_setup() needs to be adapted to patch
> > > calls at alternative patching sites instead of paravirt calls.
> > > 
> > > Signed-off-by: Juergen Gross <jgross@suse.com>
> > 
> > I cannot help but feel this would've been better as two patches, one
> > introducing ALT_NOT_XEN and then a second with the rest.
> 
> In case I need to respin I'll split it up.

Yeah, would be nice to split this patch into two, as Peter requested.

Thanks,

	Ingo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
