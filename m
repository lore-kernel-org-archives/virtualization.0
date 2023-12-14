Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2712EB1C
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OfKdIUbs"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4EF6F405B1
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 09:47:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4EF6F405B1
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OfKdIUbs
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nuArBvJw8J17
	for <virtualization@lists.linux-foundation.org>;
	Thu, 14 Dec 2023 09:47:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 09CAC402D4
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 09:47:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 09CAC402D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702547274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5PF84afDWkdufDlSaavaOE20R3k7202dyNd13pNjgKM=;
	b=OfKdIUbsAb5Lj/MLLCeJm7KO7W6wCvPBoJ6L4JARjqI1rpLBy8W4eaGkGWxsmhUyypMrVj
	BQsuW+rMuqFS5vlO0ror+k3SB2UGxdGoypE/CtrrCnCCkHGG/XNmLOcCO8bGXUrJk9s3I4
	D6xXfUt34xS4d6FXKegT438FYddXq2o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-iDUNgTgKOI-t_A5ZEmsgDQ-1; Thu, 14 Dec 2023 04:47:52 -0500
X-MC-Unique: iDUNgTgKOI-t_A5ZEmsgDQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40c348e529fso46585185e9.2
        for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 01:47:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702547271; x=1703152071;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PF84afDWkdufDlSaavaOE20R3k7202dyNd13pNjgKM=;
        b=wZCHz6CUofRZY0JasQyHZml3bCBNwwqpDtF1d5OPb0gEAr7J4+qY5NctIEoi3VWrkU
         JJEMdksT8IkI1Ngl6dRTgN6BNLVo4fDR4uSokACnwVAku/x3o7KbVxE9uDFgJZ4/t8Mj
         l0fZXav5hhvR2KD+tCNxgFj81+fbT5OdjBkzFHiQdKBcbUok4tLykS504BEppcJHi/CH
         EgPmjlD+NiwoH8nsWYJCm7jwG7nSqGqNOhrbvM/JFR9t/x7S3XHxQOdHP5CeWjDSSFbF
         K5zGYYOUdWCne7FzepuSl4mI8qTLIF38Vykag8E//05496wfdM8KQ0IoWPIW0ppcD+11
         64Jg==
X-Gm-Message-State: AOJu0YwY/D5aHXw+AXXYr7Gey0FHmuRYtcnWl8iqdJv0ObYbbGWlR0D0
	ij+0TuRCDv1ufqnd3B5yGouyAv9j9E8tlkKCxhKT6PXbL3RjW9mPNHDeJlv9c5JDCB/kyYmMHrh
	LwfXWp7o2T5sdJVxi1AF+V6gCl/sTubq47DQ1R0tApA==
X-Received: by 2002:a05:600c:181b:b0:40c:3dce:b02c with SMTP id n27-20020a05600c181b00b0040c3dceb02cmr4246372wmp.156.1702547271567;
        Thu, 14 Dec 2023 01:47:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHwHS3zkCqHcdbEXN95kRzMkgUvUEeVAvgoRWWCHE4s54G90NsvwmBMAxA0az5XLrHhfg94g==
X-Received: by 2002:a05:600c:181b:b0:40c:3dce:b02c with SMTP id n27-20020a05600c181b00b0040c3dceb02cmr4246363wmp.156.1702547271166;
        Thu, 14 Dec 2023 01:47:51 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c4ed400b0040c31bb66dcsm23628094wmq.20.2023.12.14.01.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 01:47:50 -0800 (PST)
Message-ID: <9fb51bfc-576a-4c7b-92c2-c161e7f08ae7@redhat.com>
Date: Thu, 14 Dec 2023 10:47:50 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio: Add support for no-reset virtio PCI PM
To: David Stevens <stevensd@chromium.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20231208070754.3132339-1-stevensd@chromium.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231208070754.3132339-1-stevensd@chromium.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.12.23 08:07, David Stevens wrote:
> If a virtio_pci_device supports native PCI power management and has the
> No_Soft_Reset bit set, then skip resetting and reinitializing the device
> when suspending and restoring the device. This allows system-wide low
> power states like s2idle to be used in systems with stateful virtio
> devices that can't simply be re-initialized (e.g. virtio-fs).
> 
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
> v1 -> v2:
>   - Check the No_Soft_Reset bit
> 
>   drivers/virtio/virtio_pci_common.c | 34 +++++++++++++++++++++++++++++-
>   1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index c2524a7207cf..3a95ecaf12dc 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -492,8 +492,40 @@ static int virtio_pci_restore(struct device *dev)
>   	return virtio_device_restore(&vp_dev->vdev);
>   }
>   
> +static bool vp_supports_pm_no_reset(struct device *dev)
> +{
> +	struct pci_dev *pci_dev = to_pci_dev(dev);
> +	u16 pmcsr;
> +
> +	if (!pci_dev->pm_cap)
> +		return false;
> +
> +	pci_read_config_word(pci_dev, pci_dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> +	if (PCI_POSSIBLE_ERROR(pmcsr)) {
> +		dev_err(dev, "Unable to query pmcsr");
> +		return false;
> +	}
> +
> +	return pmcsr & PCI_PM_CTRL_NO_SOFT_RESET;
> +}
> +
> +static int virtio_pci_suspend(struct device *dev)
> +{
> +	return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_freeze(dev);
> +}
> +
> +static int virtio_pci_resume(struct device *dev)
> +{
> +	return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_restore(dev);
> +}
> +
>   static const struct dev_pm_ops virtio_pci_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(virtio_pci_freeze, virtio_pci_restore)
> +	.suspend = virtio_pci_suspend,
> +	.resume = virtio_pci_resume,
> +	.freeze = virtio_pci_freeze,
> +	.thaw = virtio_pci_restore,
> +	.poweroff = virtio_pci_freeze,
> +	.restore = virtio_pci_restore,
>   };
>   #endif
>   

Am I correct with my assumption that this will make s2idle work with virtio-mem-pci as well?

Right now, all suspending is disabled, but really only s4/hibernate is problematic.

[root@vm-0 ~]# echo "s2idle" > /sys/power/mem_sleep
[root@vm-0 ~]# echo "mem" > /sys/power/state
[  101.822991] PM: suspend entry (s2idle)
[  101.828978] Filesystems sync: 0.004 seconds
[  101.831618] Freezing user space processes
[  101.834569] Freezing user space processes completed (elapsed 0.001 seconds)
[  101.836915] OOM killer disabled.
[  101.838072] Freezing remaining freezable tasks
[  101.841054] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  101.843538] printk: Suspending console(s) (use no_console_suspend to debug)
[  101.957676] virtio_mem virtio0: save/restore not supported.
[  101.957683] virtio-pci 0000:00:02.0: PM: pci_pm_suspend(): virtio_pci_freeze+0x0/0x50 returns -1
[  101.957702] virtio-pci 0000:00:02.0: PM: dpm_run_callback(): pci_pm_suspend+0x0/0x170 returns -1
[  101.957718] virtio-pci 0000:00:02.0: PM: failed to suspend async: error -1


-- 
Cheers,

David / dhildenb

