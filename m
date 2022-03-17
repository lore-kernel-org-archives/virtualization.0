Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2DCC433F5
	for <virtualization@archiver.kernel.org>; Thu, 17 Mar 2022 16:11:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 878A1417D7;
	Thu, 17 Mar 2022 16:11:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bj4dNnHW9Gz2; Thu, 17 Mar 2022 16:11:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1C1FA417AB;
	Thu, 17 Mar 2022 16:11:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1432C001A;
	Thu, 17 Mar 2022 16:11:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0855BC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 16:11:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D387440151
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 16:11:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel-dk.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GVwTz733_NIj
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 16:11:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E4DD34012D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 16:11:40 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id
 l4-20020a17090a49c400b001c6840df4a3so2103947pjm.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 09:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:in-reply-to:references:subject:message-id:date
 :mime-version:content-transfer-encoding;
 bh=wywg4x91ht1wDsZE8LDgwKs/937jDdBiI3aoJq8Icig=;
 b=EcRFu47wdTKbqMSAq17bN6l3fW68je9I7sz6dNGS5tKD2WRbtx22XzizUZtR0qkyAQ
 QWP1OHwCDN5A0Nw0t3Q7qmd76Q7jNga+edrTyslT2xibkPds1nD37wWbuAnO8SwFuhrO
 gsVcYZtwJfnoFR7QpeZ53g8ha9BP7vQeAQagIeRfmuB8NZSh871Oy/O22T8GKZQsso7+
 GAqKZ5LuYXbJaI8VOrspWlTrq9NYT2zp8TS48/UvpIibmW0S8anvsp+TLqAO1q5KW6Bh
 lxRLQvTEz/3EMFmPsbBbDBLIo1E7GTCaZssTwBenfG227MP1XIuXr1IbCZbQ1ApUnFqh
 aueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
 :message-id:date:mime-version:content-transfer-encoding;
 bh=wywg4x91ht1wDsZE8LDgwKs/937jDdBiI3aoJq8Icig=;
 b=FuMlH+5ls0TFo5AxhNBDORY908KxFPuUUDYDMnNAovDbFgWh3AQNrcnEdRyYzNLimd
 pSOq3psaDZ9V+1u3TnV5zP07c0SY+UzABnHe61tCOE5uRJiwdFlHRXdmvADQvnv7wikr
 f1mSygCIz+oY/FOCEWw9lOseDsjkss5WwxJ+8Yh+qOmE638JLxV2t0JwIwSUaIZrhfFK
 UbCAunc7T5Nzu1XACE8/eRzOBtTX4lERFipFajdxcwadYgsOs9nrnTHhsPiqAzsYXwEw
 qW+MlcQY2LhHCuffmbqhQ4o+aP4zyeK+g6KY76pB+2SPg3byR4/G2B38vnytK59aLnd4
 lLew==
X-Gm-Message-State: AOAM532ArC+f2RNcFXyfptDtlrVD67MOfZPsFIvRjwlB2Oc923faHWj1
 mrgVIWJqh8mYmNF9yTfaMBJVXA==
X-Google-Smtp-Source: ABdhPJzujChC6izQDJEHNAPYk2A2y6Fs/ty0Hxcz37xAtsWb7B2FaolAnh/R0gH50blU6B7YVSPE4w==
X-Received: by 2002:a17:902:7613:b0:151:6e1c:c49c with SMTP id
 k19-20020a170902761300b001516e1cc49cmr5906213pll.109.1647533499805; 
 Thu, 17 Mar 2022 09:11:39 -0700 (PDT)
Received: from [127.0.1.1] ([2620:10d:c090:400::5:d2fd])
 by smtp.gmail.com with ESMTPSA id
 q10-20020a056a00088a00b004f7ceff389esm7702590pfj.152.2022.03.17.09.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Mar 2022 09:11:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220316192010.19001-1-rdunlap@infradead.org>
References: <20220316192010.19001-1-rdunlap@infradead.org>
Subject: Re: (subset) [PATCH 0/9] treewide: eliminate anonymous module_init &
 module_exit
Message-Id: <164753349550.89091.10994175450707575992.b4-ty@kernel.dk>
Date: Thu, 17 Mar 2022 10:11:35 -0600
MIME-Version: 1.0
Cc: Joachim Fritschi <jfritschi@freenet.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, nouveau@lists.freedesktop.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Eli Cohen <eli@mellanox.com>, Valentina Manea <valentina.manea.m@gmail.com>,
 virtualization@lists.linux-foundation.org,
 Krzysztof Opasiak <k.opasiak@samsung.com>, "H. Peter Anvin" <hpa@zytor.com>,
 netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>,
 linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org, x86@kernel.org,
 Jozsef Kadlecsik <kadlec@netfilter.org>, coreteam@netfilter.org,
 Jussi Kivilinna <jussi.kivilinna@mbnet.fi>, Jakub Kicinski <kuba@kernel.org>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Amit Shah <amit@kernel.org>, "James E.J. Bottomley" <jejb@linux.ibm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 linux-block@vger.kernel.org, Pekka Paalanen <ppaalanen@gmail.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
 Leon Romanovsky <leon@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 Florian Westphal <fw@strlen.de>, Karol Herbst <karolherbst@gmail.com>,
 netfilter-devel@vger.kernel.org, linux-crypto@vger.kernel.org,
 Igor Kotrasinski <i.kotrasinsk@samsung.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
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

On Wed, 16 Mar 2022 12:20:01 -0700, Randy Dunlap wrote:
> There are a number of drivers that use "module_init(init)" and
> "module_exit(exit)", which are anonymous names and can lead to
> confusion or ambiguity when reading System.map, crashes/oops/bugs,
> or an initcall_debug log.
> 
> Give each of these init and exit functions unique driver-specific
> names to eliminate the anonymous names.
> 
> [...]

Applied, thanks!

[1/9] virtio_blk: eliminate anonymous module_init & module_exit
      commit: bcfe9b6cbb4438b8c1cc4bd475221652c8f9301b

Best regards,
-- 
Jens Axboe


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
