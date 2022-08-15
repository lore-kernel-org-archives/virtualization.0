Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648ACC00140
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 20:45:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E6BC68176B;
	Mon, 15 Aug 2022 20:45:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E6BC68176B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=POQ4Lda3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tBBwKfo-exVG; Mon, 15 Aug 2022 20:45:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8A9DC81360;
	Mon, 15 Aug 2022 20:45:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8A9DC81360
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52DBBC0032;
	Mon, 15 Aug 2022 20:45:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88F3EC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 20:45:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 52A0A4089D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 20:45:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 52A0A4089D
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=POQ4Lda3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wQZwd5_jkUCk
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 20:45:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 877EB402E0
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 877EB402E0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 20:45:04 +0000 (UTC)
Received: by mail-pl1-x629.google.com with SMTP id y1so7371869plb.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 13:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc;
 bh=XS5K4OzaHR63BIa1xws9D0ReOq3Svv2Wh4Lbm5YbAfM=;
 b=POQ4Lda376BXN0B9b1jtVn5dk06uCU+dpZ0TVOwcNXMKz4thbYFRfKcbTZRu413o8T
 joeFgGN35weFYtqnpQK0bxOorsyX2IoaQh8HFvWBT/pU8Rgg6U19N8K63aJ5xdrVPx1e
 SAUAQ3qOPpIMIzPMdtk3n3Dpv7rKWuDRvcnWMTOxAFeiGUd39rD3fkovoFIg4QpAbLSb
 xzyyCNrPDZsmdqII7ChdtrONVxQiXbqyAvjmUwRC/QwxbXSxSi93uZ690b4+QkfteDr/
 1wBzjH901vu1iRNR39joY4Mg6o1vDcJR3SEKW37tqYsqJbiCLvc+UZpiEZpzbrhcLKaM
 L38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
 bh=XS5K4OzaHR63BIa1xws9D0ReOq3Svv2Wh4Lbm5YbAfM=;
 b=fUiNpviDrnqoK2vqZFKQ8eYRtyRJGZkGKrBFpl0XaAaOgEGKK4WrjAvXOX2LktrpVB
 dHTUVCY40/OvwIRIWrdIxOnmpqpadq+UPf3SwdeN/NX+Ud7XfvRWT78puftTy8DdOsr0
 8KopzUFjrsPiN0PtMUfGmnBcT/9Yi+FQnfBdkq/yuMUqd5Bl/khqqiqFBsJs1g+iqMoc
 sjySaju9WA/8rlQtgm6eXF9E97NoihehYT5QprRSEj2+MuYlxb2eUzk+KH7v35LUvkKM
 f4aLtfLLPemQPNrZuz9axvEHidmvj+R/1QEmEpjJpCYbsAgMo776ZAlKGDuj8P1DyJfA
 /ZJw==
X-Gm-Message-State: ACgBeo2ovOFoURRD80+S2WAzs4+IWgkLafE0+R3ioLI/VWIIKLxyA8A5
 SoXLkehyRRjRNCmlBqK93H0=
X-Google-Smtp-Source: AA6agR5hpN5Jw5Lb8baKNCmKSASjXILStRaT2kte+VwGknYpI/t1N4jPKG7MFOa60MRd2+2GnQcNFg==
X-Received: by 2002:a17:902:720b:b0:16d:2c4c:b52a with SMTP id
 ba11-20020a170902720b00b0016d2c4cb52amr18276430plb.155.1660596304001; 
 Mon, 15 Aug 2022 13:45:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 y11-20020a17090322cb00b0016c40f8cb58sm7386806plg.81.2022.08.15.13.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Aug 2022 13:45:03 -0700 (PDT)
Date: Mon, 15 Aug 2022 13:45:02 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: upstream kernel crashes
Message-ID: <20220815204502.GC509309@roeck-us.net>
References: <20220815013651.mrm7qgklk6sgpkbb@awork3.anarazel.de>
 <CAHk-=wikzU4402P-FpJRK_QwfVOS+t-3p1Wx5awGHTvr-s_0Ew@mail.gmail.com>
 <20220815071143.n2t5xsmifnigttq2@awork3.anarazel.de>
 <20220815034532-mutt-send-email-mst@kernel.org>
 <20220815081527.soikyi365azh5qpu@awork3.anarazel.de>
 <20220815042623-mutt-send-email-mst@kernel.org>
 <FCDC5DDE-3CDD-4B8A-916F-CA7D87B547CE@anarazel.de>
 <20220815113729-mutt-send-email-mst@kernel.org>
 <20220815164503.jsoezxcm6q4u2b6j@awork3.anarazel.de>
 <20220815124748-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220815124748-mutt-send-email-mst@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Greg KH <gregkh@linuxfoundation.org>,
 c@redhat.com, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andres Freund <andres@anarazel.de>,
 "David S. Miller" <davem@davemloft.net>
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

Michael,

On Mon, Aug 15, 2022 at 12:50:52PM -0400, Michael S. Tsirkin wrote:
[ ...]
> 
> Okay! And just to be 100% sure, can you try the following on top of 5.19:
> 

You should now be able to test any patches using the syzkaller
infrastructure. Pick any (or all) of the now-published syzkaller
reports from the linux-kernel mailing list, reply with:

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v5.19

and provide your patch as attachment.

Guenter
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
