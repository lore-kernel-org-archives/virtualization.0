Return-Path: <SRS0=Lmm9=L2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74449C11F68
	for <virtualization@archiver.kernel.org>; Fri,  2 Jul 2021 04:56:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C5D061416
	for <virtualization@archiver.kernel.org>; Fri,  2 Jul 2021 04:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C5D061416
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C08BE83D61;
	Fri,  2 Jul 2021 04:56:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zH9kfpnYuh_Y; Fri,  2 Jul 2021 04:56:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6BAB683D56;
	Fri,  2 Jul 2021 04:56:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D49BC0010;
	Fri,  2 Jul 2021 04:56:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74A4FC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 04:56:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5433660AA0
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 04:56:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gsEnQiQPyE3g
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 04:56:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D024760653
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 04:56:36 +0000 (UTC)
Received: by mail-pg1-x52f.google.com with SMTP id v7so8473565pgl.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 01 Jul 2021 21:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=qqSo2EHKnteCkmvIob7W7h8j2bBButMHNumXS1B2l4o=;
 b=THUTh9lL4gLgfoWs25q+r7nEzcReUOTkjZ6PBQSvLYhT5h22qQghqFKTbnb+SueClW
 yzFZUuYKHvmbk60MxqoXkPEIZT7QKSU230n1xDMIOEwPaorDYxvR+1FO6c9gXmnUAEyd
 jRmw9Ho2/f6zYuDYpi6/dqnwUEhzU5C9ovYEp1pvzM/GkwAC5SJQdnZMiT9DQsTp3we/
 sIht4/YeX7Sq2U/klwO/Men0mMiCPsDJsV+ip84CFwlRVcNtk1HMWKNMqPPCxaTt42f8
 Ts26/9nOMSVMKIGqnJ4Kejd/m3y2N8FnH+a2Kij8aGj64AQIdpA7vu2IusgPFP7lMtgD
 GrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=qqSo2EHKnteCkmvIob7W7h8j2bBButMHNumXS1B2l4o=;
 b=BIynXNFn6haN1Q5TjE1YppuUIFNz/sBTeHo5ie4V6zqgbUJIVTAzcggByjgwxMNQJo
 FT4yub1QJtlAqYaIxbktQlEcB6oue299+pUbonWjtrZJFHYOvnO+o1WhmVrsyZp5DPj7
 3ha5RDkNJ4Pm5+97oXkrQQ1FP+GxwkBBQJIlnaOtcS/CI4a45CeEtSX8o5XYhN9dkqr2
 Z1dVKOp87bKvaH39f/yWxF0u857gWm6mZwRaq7xlIaZKAwYDvxO+CZYjeurGRbEwidiv
 LBRd2hMrcJwaYpNvci24lGURQZ22JLrYIgKqLvlUNF6yro/OE7ShXhQCvtZLYyippkw7
 o+DA==
X-Gm-Message-State: AOAM531560fXjoi1NR1se+TaALqzC+p90Mto+o93oMEJZuU1+vFkfX0Z
 Nf0hTd3sFyst/o1YqQLq7LCRNw==
X-Google-Smtp-Source: ABdhPJzQoHvs4UddAnwcfgRrte2ZXexLQGMoAiszR4up3WGDmvkA5xdPaNw7h+vVUySdvsIcdSrxSg==
X-Received: by 2002:aa7:96cf:0:b029:30f:d1e8:9264 with SMTP id
 h15-20020aa796cf0000b029030fd1e89264mr3262408pfq.33.1625201796138; 
 Thu, 01 Jul 2021 21:56:36 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id w6sm1824644pgh.56.2021.07.01.21.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jul 2021 21:56:35 -0700 (PDT)
Date: Fri, 2 Jul 2021 10:26:33 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jie Deng <jie.deng@intel.com>
Subject: Re: [PATCH v11] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210702045633.gblpud7wcffd5kyj@vireshk-i7>
References: <510c876952efa693339ab0d6cc78ba7be9ef6897.1625104206.git.jie.deng@intel.com>
 <20210701040436.p7kega6rzeqz5tlm@vireshk-i7>
 <cb35472d-f79e-f3f8-405f-35c699d897a1@intel.com>
 <20210701061846.7u4zorimzpmb66v7@vireshk-i7>
 <34092cb2-03f9-231d-8769-4e45ed51c30f@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <34092cb2-03f9-231d-8769-4e45ed51c30f@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: yu1.wang@intel.com, arnd@arndb.de, mst@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 wsa@kernel.org, wsa+renesas@sang-engineering.com, linux-i2c@vger.kernel.org,
 stefanha@redhat.com, shuo.a.liu@intel.com, andriy.shevchenko@linux.intel.com,
 conghui.chen@intel.com
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 02-07-21, 11:36, Jie Deng wrote:
> OK. Let's add the following two lines to make sure that msg_buf is only
> sent when the msgs len is not zero. And backend judges whether it is
> a zero-length request by checking the number of elements received.
> =

> =A0+ if (msgs[i].len) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reqs[i].buf =3D i2c_get_dma_safe_msg_buf(&=
msgs[i], 1);
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!reqs[i].buf)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
> =

> =A0=A0=A0=A0=A0=A0=A0=A0=A0 sg_init_one(&msg_buf, reqs[i].buf, msgs[i].le=
n);
> =

> =A0=A0=A0=A0=A0=A0=A0=A0=A0 if (msgs[i].flags & I2C_M_RD)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sgs[outcnt + incnt++]=
 =3D &msg_buf;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 else
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sgs[outcnt++] =3D &ms=
g_buf;
> +}

Perfect. Thanks.

-- =

viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
