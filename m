Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9B5C433EF
	for <virtualization@archiver.kernel.org>; Tue, 30 Nov 2021 17:36:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0BDA606C9;
	Tue, 30 Nov 2021 17:36:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9uBRGDnncz1B; Tue, 30 Nov 2021 17:36:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 845FB606B3;
	Tue, 30 Nov 2021 17:36:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C199C001C;
	Tue, 30 Nov 2021 17:36:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 544D1C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 17:36:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 335D582741
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 17:36:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id snDO_AYpZZy6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 17:36:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 95689826E7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 17:36:02 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id w1so90252638edc.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 09:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Oywvq+utTerFq6V8S/x70IeHU0QO5TyY6jTfAnkHZ9I=;
 b=cfojqhysDIMRwY+mqnD9kh3WDnYnhLEiUMTbj+w3NNvkofPxAL0FuELgxKL/o9Jqvc
 1twq8TqzePvIO+ya7YgXvK/2bJul8eN13GdklzL75WmOk8bf7btZoTtZqHPRpswx8E9h
 BCYfi9mtp+FoTixbdaVD0VDX6Jbk8wjWuJAtFIKXyEueo4+E5ipefcQu6wTdf5EIq4X8
 X4sh7jWhd+8X//LKwLTkDwqlDqEMpLbI9/qbRQ3HAxoAjV907M7DpCJLh48agnXXrfiV
 rpJsCnp9/yUrBe+MTnfRUJ85UDVpv4VeJIrKFmq6V+H4wIUmvp8bvMfPg2h/1OaPtlfj
 tl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
 :subject:content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Oywvq+utTerFq6V8S/x70IeHU0QO5TyY6jTfAnkHZ9I=;
 b=U5E4rn8xs/cQ1YkjLLuSTVi5FDdAJ9cMu+0rdrlqiS7wOpy3fHG0tcEtD7FtK4koAh
 sPn+mIJxxM0i3Hw5UGqJXqLhzRO9aIBK3tMrnrzjTzOiS3G+acMwnBR31R7tP/X8U+de
 KXI5crtD19lspf1qclPsC2+A+9MYLQqFOBt4WdE0zNRraSN6t5MTJxWWolCYfsJoC1Mq
 81yHDsVVstMpQb6veTfLD5SBQgr4glS4ZhKVu7CVBxVQGK30gqNc3vGLrITBesVUTJjX
 4nqU2PAfhGLfDuCgYe9JZa22FZrDfHJJCXUOjSHxd/QeL4/QeSLhDk3mJNP/lXlt2xeZ
 FrSQ==
X-Gm-Message-State: AOAM532lN1uklhhWTxFExAKY/xivHtha1QH4iCXCfhwO0VEdiDQ0vkfP
 3wBsSy4BElsgF+UUXrveyn8=
X-Google-Smtp-Source: ABdhPJwX+VqmCvUvIH+Vrzn67m5keK1nVizErpKsz9xY5hMnklBKQ0T/tH8iHItv+tP4C3Zz7cXSsg==
X-Received: by 2002:a50:ce46:: with SMTP id k6mr532940edj.45.1638293760775;
 Tue, 30 Nov 2021 09:36:00 -0800 (PST)
Received: from ?IPV6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a?
 ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
 by smtp.googlemail.com with ESMTPSA id oz11sm9583941ejc.81.2021.11.30.09.35.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Nov 2021 09:36:00 -0800 (PST)
Message-ID: <ecb2f3c6-af8c-dd43-1dcf-0b5e8a9d8848@redhat.com>
Date: Tue, 30 Nov 2021 18:35:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] scsi: virtio_scsi: Fix a NULL pointer dereference in
 virtscsi_rescan_hotunplug()
Content-Language: en-US
To: Zhou Qingyang <zhou1615@umn.edu>
References: <20211130171901.202229-1-zhou1615@umn.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211130171901.202229-1-zhou1615@umn.edu>
Cc: linux-scsi@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, kjlu@umn.edu,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Matt Lupfer <mlupfer@ddn.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 11/30/21 18:19, Zhou Qingyang wrote:
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -337,7 +337,11 @@ static void virtscsi_rescan_hotunplug(struct virtio_scsi *vscsi)
>   	unsigned char scsi_cmd[MAX_COMMAND_SIZE];
>   	int result, inquiry_len, inq_result_len = 256;
>   	char *inq_result = kmalloc(inq_result_len, GFP_KERNEL);
> -
> +	if (!inq_result) {
> +		pr_err("%s:no enough memory for inq_result\n",
> +			__func__);
> +		return;
> +	}
>   	shost_for_each_device(sdev, shost) {
>   		inquiry_len = sdev->inquiry_len ? sdev->inquiry_len : 36;
>   

In practice this will never happen, since the kmalloc is very small, so 
I think it's easier to just return early without a printk.  On the other 
hand, if the out-of-memory really could happen, this should be a 
pr_err_ratelimited.

Paolo
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
