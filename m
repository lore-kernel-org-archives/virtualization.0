Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF02BECAAA1
	for <virtualization@archiver.kernel.org>; Mon, 31 Oct 2022 13:25:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F2B781911;
	Mon, 31 Oct 2022 13:25:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6F2B781911
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20210112.gappssmtp.com header.i=@kernel-dk.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=hlWtEEl6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6clDHARU4FGz; Mon, 31 Oct 2022 13:25:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A001881430;
	Mon, 31 Oct 2022 13:25:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A001881430
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FD9FC0032;
	Mon, 31 Oct 2022 13:25:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 022A6C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Oct 2022 13:25:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CECA260BEB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Oct 2022 13:25:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CECA260BEB
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel-dk.20210112.gappssmtp.com
 header.i=@kernel-dk.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=hlWtEEl6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SrKlKhFK62UO
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Oct 2022 13:25:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4995B60BA1
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4995B60BA1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Oct 2022 13:25:12 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id 128so10709296pga.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Oct 2022 06:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CWMYmmmibwx2ReqBvBmNSoB8xLK3NIj0RwP04JMJrKs=;
 b=hlWtEEl6iiRSHfaS8OvLrFpy14iFbnLP+GsvSlcFeZKEuJA50HGmW1tTG5eLx5keTc
 N6PjXXS57sDwn99wfG6yb6iDuDnhLc5RBtYGrB/pokimiEYmTPpi0vOzPIsEin9MhoXZ
 DwfngRc16hqhXY1d/TdClaN0cjKpxSqTrhJ+vIi/53H89WW8BmbWVn3R+Vz+6DwxkN2e
 8zkdyHpbUTgh9KFUM0plNzJTGlg2+yChD2AlZ7MLNitu4UxWxt34XiET0+d78ZAkOtSz
 TXpw/5C4+PkTnlOTPCjg2sis0iHuaYc9zLTTIA48kK5WgeoD5CmqcXhknHS6L4QgXBNm
 zeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CWMYmmmibwx2ReqBvBmNSoB8xLK3NIj0RwP04JMJrKs=;
 b=baDnTcb9fVP2WymHsaYfOC2Zi9p3XFX8clS2fn95uQr/8kXeo8hAnFtCFNw7g4Mowj
 fORzE3bQ/LCB/I50IpR7Tt3yhuQH2QZBaofaBk3msz9cDDGiaJVB3tz00aRWwzFereqi
 PMstNWxzOcCEKQTovPz3fD5HFDLEwSMF/cIKwMCMWzp0aGlij5ijjXzWG3GheAbejYJM
 xAC6jdhSsanlkAkxJ2T8/c0ge7uNGv6fJ9mhoXftNUdHJp7+EDbOeDNZzKFHKUsw+95h
 qzh5psYVOC83Q4A1uNXULxjRZwks5af9D1hSyqtdfe2PMJHOVr7kpHbx7KbUOgtlNG8a
 v2Bg==
X-Gm-Message-State: ACrzQf1X35CKO1Zyx6j4ziQeBaw230rV9CnkAiAZld0JMF0ZX1Docth0
 qTcT5NPx9i2YS+xdXBkvEidMhg==
X-Google-Smtp-Source: AMsMyM456NR3W00gWxHmZFr8p6oriRZjLZ710N39waLB35rFt/oiH19XaceqS3OEOm3/efWET8IGuQ==
X-Received: by 2002:a05:6a00:24cb:b0:56c:7815:bc7d with SMTP id
 d11-20020a056a0024cb00b0056c7815bc7dmr14543180pfv.44.1667222701423; 
 Mon, 31 Oct 2022 06:25:01 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157]) by smtp.gmail.com with ESMTPSA id
 k28-20020aa7999c000000b0056bfebfa6e4sm4523279pfh.190.2022.10.31.06.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Oct 2022 06:25:01 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>
In-Reply-To: <20221026051957.358818-1-ming.lei@redhat.com>
References: <20221026051957.358818-1-ming.lei@redhat.com>
Subject: Re: [PATCH V3 1/1] blk-mq: avoid double ->queue_rq() because of early
 timeout
Message-Id: <166722270044.66567.13274204671032495059.b4-ty@kernel.dk>
Date: Mon, 31 Oct 2022 07:25:00 -0600
MIME-Version: 1.0
X-Mailer: b4 0.11.0-dev-d9ed3
Cc: David Jeffery <djeffery@redhat.com>, Bart Van Assche <bvanassche@acm.org>,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Keith Busch <kbusch@kernel.org>
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

On Wed, 26 Oct 2022 13:19:57 +0800, Ming Lei wrote:
> From: David Jeffery <djeffery@redhat.com>
> 
> David Jeffery found one double ->queue_rq() issue, so far it can
> be triggered in VM use case because of long vmexit latency or preempt
> latency of vCPU pthread or long page fault in vCPU pthread, then block
> IO req could be timed out before queuing the request to hardware but after
> calling blk_mq_start_request() during ->queue_rq(), then timeout handler
> may handle it by requeue, then double ->queue_rq() is caused, and kernel
> panic.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: avoid double ->queue_rq() because of early timeout
      commit: 82c229476b8f6afd7e09bc4dc77d89dc19ff7688

Best regards,
-- 
Jens Axboe


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
