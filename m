Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95696C433FE
	for <virtualization@archiver.kernel.org>; Fri,  3 Dec 2021 04:39:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0BCD78175D;
	Fri,  3 Dec 2021 04:39:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vgq7Nn9MA1tV; Fri,  3 Dec 2021 04:39:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6FE6780E43;
	Fri,  3 Dec 2021 04:39:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46005C0012;
	Fri,  3 Dec 2021 04:39:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C155EC000A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 04:39:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9C6C960631
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 04:39:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id taNhEiX6LLB3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 04:39:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9C4166062E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 04:39:21 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id 137so1877409pgg.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Dec 2021 20:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=OcPdj+R92LM+0ZI0wmyCsSW46rzlUsrsE3LQQ/iEpLE=;
 b=dBx99xt9ShaVFEHeymStBpp3iQP2Pd4gcfLkcVUqJ51OiRwy283uuc+wXxjnuh5TRT
 XLuB2ZOWRzZJc1rFq/U1CatDfpn2yM5dM9335x3YCeZgZuRYxBwXnkOI7mdCi+j9iv3/
 st8uatwl7bGGU6kchQ+vpyziRshakjMSllwWn2P8cEvHnB/aikDe6LFq0As/ZyclNFS+
 DfUUTOvq0O9a6o4qxfONFuqK81srsX+D6BeQ8PvfxMdCGmd4+0HWDeC3c146CsUigE6G
 S9aFXC7vr1ETdAAbooJxFIebB8dXtZo1z587/GVTcd0vOTeuZxtnNrMOSeO0gJ+HiBA/
 RUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=OcPdj+R92LM+0ZI0wmyCsSW46rzlUsrsE3LQQ/iEpLE=;
 b=7TaQ9z6/V9OPzXKRxRx9A0Hl6sVeWROB5obCrzFZktnjWU43nheyv7/4I3EWpJrQX1
 nHN2DM5uA22OW9NnThFJ90uVzWaT2dfSIJf/k8f6+ZjxDwjGZ7o3FPuqtKh1Fo3D0Vq2
 mh2l4ap0XEHHM5twO2v+qS52YVz5pBvVgLKEqA0bMPhNm7DDIXbj819OzyBylFHZELEJ
 oDpQpD4S8PY0rXOpL8sAmtLt8y2vzGU3IrTMjZcIpDTXBEqJFBTe3MEUQRciHhq7kGfS
 YTcSVA7a+PTmWfIjpCCvtDy7AgnKrrPop3E15CIkJxpAMce7KVS8LcGZmdzLYO0vZXPh
 0vaQ==
X-Gm-Message-State: AOAM530nVGBhu7YfT8TkNGpr4F2Ao0DEn2I/Q55CdipnZnQCr7CG8UCa
 cAcu6QcG6enr2smHm9ogd794DA==
X-Google-Smtp-Source: ABdhPJx3r5/a3LSEpyJfO3oVjqbl62c8FXOn/xd99G1hXtUmAXrpEYkc/n2bP7s/+FAWNOZxxXXI9A==
X-Received: by 2002:aa7:9d81:0:b0:49f:e072:bfc7 with SMTP id
 f1-20020aa79d81000000b0049fe072bfc7mr16975671pfq.48.1638506360976; 
 Thu, 02 Dec 2021 20:39:20 -0800 (PST)
Received: from localhost ([106.201.42.111])
 by smtp.gmail.com with ESMTPSA id p2sm924575pja.55.2021.12.02.20.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Dec 2021 20:39:20 -0800 (PST)
Date: Fri, 3 Dec 2021 10:09:17 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH v3] i2c: virtio: fix completion handling
Message-ID: <20211203043917.z4njhql4y43tcbew@vireshk-i7>
References: <20211202153215.31796-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211202153215.31796-1-vincent.whitchurch@axis.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, wsa@kernel.org, kernel@axis.com,
 linux-i2c@vger.kernel.org, Conghui Chen <conghui.chen@intel.com>
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

On 02-12-21, 16:32, Vincent Whitchurch wrote:
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
> Fixes: 3cfc88380413d20f ("i2c: virtio: add a virtio i2c frontend driver")
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
> 
> Notes:
>     v3: Wait for all completions instead of only the last one.

LGTM, thanks.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
