Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5ABAC54EBE
	for <virtualization@archiver.kernel.org>; Tue, 10 Jan 2023 15:47:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3157C81EBE;
	Tue, 10 Jan 2023 15:47:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3157C81EBE
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=mf/FK5QQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m5Vvc8LqJrH7; Tue, 10 Jan 2023 15:47:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ADD9E81DF8;
	Tue, 10 Jan 2023 15:47:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ADD9E81DF8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83ED2C0033;
	Tue, 10 Jan 2023 15:47:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BA2CC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 15:47:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7014840B65
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 15:47:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7014840B65
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=mf/FK5QQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WmPjApq11ZRa
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 15:47:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 14D8740B58
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 14D8740B58
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 15:47:14 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id 20so3743319pfu.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 07:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TqAonkvvlkjP3xf6w+ybB+UtrnG/dwyrsl+5Eu8mqc8=;
 b=mf/FK5QQ/vY8QNUoC+WI5SG18LUF8Xluig+DDuFtLBqLVw5dgihnvVzK7W+Ppyh269
 loiqyPI3tiYgww9XXoKRNXiu5kWzC8qeSGFlzagrNlwFaiop0VTNDAfyboGd5suCbcoO
 DOcOduMPFb8sHqfltXjBPKTGXIgikMDhANtS+gatesjve5RBGazeust3y4Q6ltlZuzxo
 lrZ8XMpCJDzJ1vqdC0Wr8P+ETEdHhS+TI91RGEss/pgVvky6iXVFLdrVUnhOpk6rYpab
 T1/o50CZkdIjqF7C8BWjlr7IenQjp5XFPPoK96RdkQFOAjAdCSFCi0VgsTzmfclxu6+H
 2Vbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TqAonkvvlkjP3xf6w+ybB+UtrnG/dwyrsl+5Eu8mqc8=;
 b=ZmN/9YHtMptTTxVvOKkszVfbetEvnfY37nG6Oy4CKyK9n2j6QKovStzAB3dXGABFSD
 dtU5I2Qqf/oTDr7hMsWsrWCikFfBPU1sdTuXisd5Sx9Syfujm+N+INtRaLlGRYXR8eHJ
 Df7Efsp45vyCsK3VO43ZWJA41mhXXJLnPBn4oK21qO2Ao8uLuF/j3jHRNXNKFqS/G2Y+
 MVWct0tFsx9iKMsy55plRJjIZfFQlKcr0kovYWWZZaKYfmTHun1/L0GxmRxsMdjo4k50
 y/RX36kaThuDKPxGww+CAjCdMKXf27Ok6WPaKMURCK7G5pb8qZSlnInGKXw6tJ7rxJLc
 2w2Q==
X-Gm-Message-State: AFqh2kruPRZ++X3S9qCDWKuzHQILlpuB7uyufeWwXl55RG1mFlP/i1e8
 piZtKVNWiZpC5ubCSA4EBgx4F4+BOfqw0lkP0HFzPQ==
X-Google-Smtp-Source: AMrXdXsURvGSkkSc47ezsF3JNgU2Nl01yJsOr807CaAaqedHJcAD6cgm3G2hlvTSKbCOXRiBQXM13PbppreWaK5XaeY=
X-Received: by 2002:a63:eb07:0:b0:4ad:2049:2aa6 with SMTP id
 t7-20020a63eb07000000b004ad20492aa6mr1148308pgh.550.1673365634426; Tue, 10
 Jan 2023 07:47:14 -0800 (PST)
MIME-Version: 1.0
References: <20230109080453.1155113-1-alvaro.karsz@solid-run.com>
 <20230110153434.GA1505598@bhelgaas>
In-Reply-To: <20230110153434.GA1505598@bhelgaas>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Tue, 10 Jan 2023 17:46:37 +0200
Message-ID: <CAJs=3_Cx1Pxg4iwLY5eWV9RVJoJ-btZVop3rHhzFmtErMJzj1Q@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] PCI: Add SolidRun vendor ID
To: mst@redhat.com, Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

Thanks Bjorn.

> This should be indented with tabs instead of spaces so it matches the
> rest of the file.

Michael, sorry about all the versions..
Do you want me to fix it in a new version?
I could fix it with a patch directly to the pci maintainers after your
linux-next is merged, if this is ok with everyone.

> It's helpful if you can send the patches in a series so the individual
> patches are replies to the cover letter.  That makes tools and
> archives work better:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/5.Posting.rst?id=v6.1#n342

Yes, I fixed it in the next version:
https://lists.linuxfoundation.org/pipermail/virtualization/2023-January/064190.html

Alvaro
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
