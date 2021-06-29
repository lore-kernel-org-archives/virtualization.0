Return-Path: <SRS0=tbjA=LX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C747C11F67
	for <virtualization@archiver.kernel.org>; Tue, 29 Jun 2021 10:30:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDC4761D85
	for <virtualization@archiver.kernel.org>; Tue, 29 Jun 2021 10:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC4761D85
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 94EA260597;
	Tue, 29 Jun 2021 10:30:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x_mmYfoIduBb; Tue, 29 Jun 2021 10:30:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4A879607D3;
	Tue, 29 Jun 2021 10:30:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DAD80C0010;
	Tue, 29 Jun 2021 10:30:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DFD2C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 10:30:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2FBF84011F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 10:30:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a2DFQ8q8vpyj
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 10:30:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7430E40117
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 10:30:17 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 z3-20020a17090a3983b029016bc232e40bso2106885pjb.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 03:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=AplI6UhQ/G6u2g2DkIgG3XJVtDuTtMAV8bpatC2NRMA=;
 b=RGz3rS3mFY+gNujWuQHWeD28pyLAd3A55cSGjgbJwhUrTj/QpoWa3tQFzVqw+LpF93
 93s/6VZGbo4RDnbUPsweWP5/kBmHJT3EK7D66wBeI9pNIPJFxAJpB2eY9k6dbNyLXUBH
 TxY3g+8o0TEJMkXc0A6KAFUEGvuobzkDRW4f878knKwuyjqJ7Od9tFYiyPcHO9IBuZci
 i+enWmvZ4ZrmDL3m3AyB8q8HesgPyUr2jxeEmbwX58n59URqVszwZc+118HDiXvgWClE
 twrMj+H4MEUIRw61GiBtp0/VQGPqUn6vGEIN0OVWAYO8yBxoSuFrsOqqV+R7QOZVc4RD
 8SAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=AplI6UhQ/G6u2g2DkIgG3XJVtDuTtMAV8bpatC2NRMA=;
 b=ULM0JBsLTpdwZxKng6CoRH47/xaLQWdxmyclQhLwO3PIMk678G5bEZXeUkjjTjdPXx
 LX65qdpTyPOfjgOCCw80iDAsMHZC9qUIMoMU/OIoVifl5LHkBPAb1GivHzmqQVUpyxQ2
 eiqalLKvobyaOSnpUb141NSYFhQsv2RIbC5TJm8xhrtMeF96wykjHmWpch9EanFhdFqY
 0sHB7HVJL/DB8/zNE9aKbCKUTXLQhiXzFkdnYudr+Pv+AJfTsdpW+8U88zaTLxphY6cw
 SNe8KsQ79ETw2P00znYjpruhN2RCbLpFjZTcAviTR39agbd0Kd+eneCIF8nbxzC9CMqX
 jgXA==
X-Gm-Message-State: AOAM533wDa4CdsU5ttwa37oZ6gf5Kc2CrBQs+W0wF9QBDZxzhaWFDgMQ
 pGuLZDkmPZY34tHVEBNyHA27Nw==
X-Google-Smtp-Source: ABdhPJzj8DyqgsJQPdYIVf1Hs422bzpfb/1ueEKtGoM/X8JqPu9WgSL27fFIOF33UEZWog4ObSleUg==
X-Received: by 2002:a17:90b:4d81:: with SMTP id
 oj1mr24694030pjb.153.1624962616536; 
 Tue, 29 Jun 2021 03:30:16 -0700 (PDT)
Received: from localhost ([136.185.134.182])
 by smtp.gmail.com with ESMTPSA id n69sm18024140pfd.132.2021.06.29.03.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jun 2021 03:30:16 -0700 (PDT)
Date: Tue, 29 Jun 2021 16:00:14 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Wolfram Sang <wsa@kernel.org>, Jie Deng <jie.deng@intel.com>,
 linux-i2c@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 andriy.shevchenko@linux.intel.com, conghui.chen@intel.com,
 arnd@arndb.de, kblaiech@mellanox.com, jarkko.nikula@linux.intel.com,
 Sergey.Semin@baikalelectronics.ru, rppt@kernel.org,
 loic.poulain@linaro.org, tali.perry1@gmail.com,
 u.kleine-koenig@pengutronix.de, bjorn.andersson@linaro.org,
 yu1.wang@intel.com, shuo.a.liu@intel.com, stefanha@redhat.com,
 pbonzini@redhat.com
Subject: Re: [PATCH v10] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210629103014.nlk3mpetydc4mi6l@vireshk-i7>
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <YNrw4rxihFLuqLtY@ninjato>
 <20210629101627.kwc2rszborc3kvjs@vireshk-i7>
 <YNr0uDx1fv+Gjd7m@ninjato>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YNr0uDx1fv+Gjd7m@ninjato>
User-Agent: NeoMutt/20180716-391-311a52
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

On 29-06-21, 12:23, Wolfram Sang wrote:
> 
> > > You are not emulating I2C_FUNC_SMBUS_QUICK, so you need to mask it out.
> > 
> > What is it that we need to have to emulate it ? I did use it in my
> > qemu and rust backends, not sure if this was ever sent by device I
> > used for testing SMBUS though.
> 
> The biggest use is to scan busses for devices, i.e. use 'i2cdetect'
> without the -r parameter.

Okay. But what is missing in the driver because of which it should
mask out I2C_FUNC_SMBUS_QUICK.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
