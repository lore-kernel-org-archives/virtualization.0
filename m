Return-Path: <SRS0=IhT0=PV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E72BC433F5
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 04:32:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BB6060E08
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 04:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1BB6060E08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF51580C9E;
	Tue,  2 Nov 2021 04:32:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eYJJlsOJ9ouj; Tue,  2 Nov 2021 04:32:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 80D8580BF2;
	Tue,  2 Nov 2021 04:32:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 459A8C0019;
	Tue,  2 Nov 2021 04:32:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 800A8C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 04:32:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7BCFD606CC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 04:32:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZVFEnK0k4OSH
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 04:32:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C061660655
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 04:32:40 +0000 (UTC)
Received: by mail-pg1-x52d.google.com with SMTP id x5so9250532pgk.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Nov 2021 21:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=lBdFLUAdGQcZpaP3XreKK6gk0Uyq547fw5ShqeoqV9s=;
 b=vH3Gibd1V+TOGpERdFzacQ0OtrsTCQ6h4W9sZMgBW/bjrtM6vDhswoZeGqHKmUGlc7
 FsN74pqxt6eLbskqWYocjIlQjpAkDaEvh9LvcqIX5N9zwbHTn+com8lunmYYnlmPQNg4
 7kUhXpD0nbLOi0PcrZBw2DDuAzwWaJgULggsoM3hYypIZcI2O0iycs0y9NYSxTAh3+fN
 Bc8WrJ/YgM2FoYEcFbNgXNrT9F0T80GaThILppaN//bsPb3Tfs0luNAgS2XOy3b1GUDH
 KHUdr1POq6jMuyx2oShQA61rVD/UEB4Lww5VaFZcutFlCnw6l/H4MAxTn10GeByV6WSs
 dAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=lBdFLUAdGQcZpaP3XreKK6gk0Uyq547fw5ShqeoqV9s=;
 b=eqbaFay5vSbhz8FiP6k5F6cNXhQmLvm3fVmla5nECt6egunHHspffcyItoJdK673El
 s+wMLv61Kdul1RjvvdRXuWVNUfEfZXjTzmlK3J+mmNjWRDiKevnLmmXhXq+yU3qbZRq4
 s3+2KGTGX4wsMDQNoufM/6spH6oQPvzKK66L0RqDRgPg4EdFeltvxibScs1G2G7bASH+
 d+zE+OAA27N6KmRgVns5SFeyqQf9U2T0LQ1reD+LpXF2EH0YwY3TVCTRX7F2EPVVFUJz
 TbFx4CmkyXE9pRJiZvTcg3SovXtfYH0ST9vsrs+WjmSMu5U2Ue7z0gVe8gk3Iv30twZr
 LEiQ==
X-Gm-Message-State: AOAM533yncqWbt/fByo9lFrsUs5UBFIjpuU5lCmNVzTVB1gkSfM8G8eD
 v1mmhXEUXdwqeDfmGBhnUS121A==
X-Google-Smtp-Source: ABdhPJyu8mpUiJ+98wGmV5t0oBFG/t+vKOHPikcPoxUoKtE0rIqGYOlWuqj/t1v3sT/9biqwO5AwXQ==
X-Received: by 2002:aa7:8b0d:0:b0:44c:89ca:7844 with SMTP id
 f13-20020aa78b0d000000b0044c89ca7844mr33802758pfd.19.1635827559852; 
 Mon, 01 Nov 2021 21:32:39 -0700 (PDT)
Received: from localhost ([106.201.113.61])
 by smtp.gmail.com with ESMTPSA id kx3sm949628pjb.5.2021.11.01.21.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Nov 2021 21:32:39 -0700 (PDT)
Date: Tue, 2 Nov 2021 10:02:37 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH 2/2] i2c: virtio: fix completion handling
Message-ID: <20211102043237.nhzspynla2a37pok@vireshk-i7>
References: <20211019074647.19061-1-vincent.whitchurch@axis.com>
 <20211019074647.19061-3-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211019074647.19061-3-vincent.whitchurch@axis.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 wsa@kernel.org, kernel@axis.com, linux-i2c@vger.kernel.org
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

On 19-10-21, 09:46, Vincent Whitchurch wrote:
> The driver currently assumes that the notify callback is only received
> when the device is done with all the queued buffers.
> 
> However, this is not true, since the notify callback could be called
> without any of the queued buffers being completed (for example, with
> virtio-pci and shared interrupts) or with only some of the buffers being
> completed (since the driver makes them available to the device in
> multiple separate virtqueue_add_sgs() calls).
> 
> This can lead to incorrect data on the I2C bus or memory corruption in
> the guest if the device operates on buffers which are have been freed by
> the driver.  (The WARN_ON in the driver is also triggered.)
> 
>  BUG kmalloc-128 (Tainted: G        W        ): Poison overwritten
>  First byte 0x0 instead of 0x6b
>  Allocated in i2cdev_ioctl_rdwr+0x9d/0x1de age=243 cpu=0 pid=28
>  	memdup_user+0x2e/0xbd
>  	i2cdev_ioctl_rdwr+0x9d/0x1de
>  	i2cdev_ioctl+0x247/0x2ed
>  	vfs_ioctl+0x21/0x30
>  	sys_ioctl+0xb18/0xb41
>  Freed in i2cdev_ioctl_rdwr+0x1bb/0x1de age=68 cpu=0 pid=28
>  	kfree+0x1bd/0x1cc
>  	i2cdev_ioctl_rdwr+0x1bb/0x1de
>  	i2cdev_ioctl+0x247/0x2ed
>  	vfs_ioctl+0x21/0x30
>  	sys_ioctl+0xb18/0xb41
> 
> Fix this by calling virtio_get_buf() from the notify handler like other
> virtio drivers and by actually waiting for all the buffers to be
> completed.
> 

Add a fixes tag here please, so it can get picked to the buggy kernel
version as well.

> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
