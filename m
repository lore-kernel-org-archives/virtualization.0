Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36059C7EE29
	for <virtualization@archiver.kernel.org>; Mon, 29 May 2023 14:02:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B03A0610E3;
	Mon, 29 May 2023 14:02:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B03A0610E3
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y1d51Sju
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zaV_0MPxDp9H; Mon, 29 May 2023 14:02:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0B90A60F33;
	Mon, 29 May 2023 14:02:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0B90A60F33
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2CABC0036;
	Mon, 29 May 2023 14:02:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01B29C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 14:02:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D065B417D6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 14:02:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D065B417D6
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y1d51Sju
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wC6Vz1uJbVAI
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 14:02:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1F930400C7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1F930400C7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 14:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685368949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zJ8lVkJGMAf7X6sgK7+SzlistNxfN3tza5OmhJom+fY=;
 b=Y1d51SjuWUwuzEjZ5mG/0xDJfZbbB6AN4cds61E9HDAYALyZ/mt+NEQEWHj7Cuxcoau345
 1fHnH+FbANsrN9stLgCXPNftY2be5uIuD/lq3/rJTiOBI/sNv+YzqpUpOQlxtTc0t9/vWa
 6cXTSP9FfHjG9nSQer0mXTjIYYKQ1uI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-Mx71HVHMMhmlKK2ut2OOTQ-1; Mon, 29 May 2023 10:02:28 -0400
X-MC-Unique: Mx71HVHMMhmlKK2ut2OOTQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-50de84a3861so2755402a12.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 07:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685368947; x=1687960947;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zJ8lVkJGMAf7X6sgK7+SzlistNxfN3tza5OmhJom+fY=;
 b=mGO7A004gzwYuF18ZYbIomdPQe7zgk6f5OnEPJxhghYGj2PEFkzHG1YwQOU2wo4NE7
 pwdmK6LZJMgw7nYW7DfU5fRa8log1h0EpFfbO5hVqeraTDGmkWdJBW1EWhCAUN+TMdnt
 i3i31WTHPM6CKLeF7WxOnK6pIaBRvQWryTn9/b0nYIeW3RwgLDzm+2bAtyByCe4lywvV
 vL8sCxEf7AcmSZ6f7nUIsCVZSZZHosgqB7aUCpBM5fqHgcLSU5Y1g3V7T6/0e6kD3b//
 CJ7TlGX9blF6Cpg12lHBMeHAkL4d15N868Xnqao0vOYlPD+s7Ofy8yBDvaQp90TYIiiW
 3Qnw==
X-Gm-Message-State: AC+VfDy4G0Hy1iwEsbpwmzsYg3hpBQPBUEYTjHqX5YyaZTw+DlFVJACR
 7HwgWBQ027h0TtpCajs1IRnHfPcWc8it3fhMtNixxbdV5ohAEDxmHFCkI3P0nYN9BcRVFLUd3LQ
 d3EAz2K6w0MWtZRL/JOF3C3oV2hTWpQq3MK4pT8lYsQ==
X-Received: by 2002:aa7:ccd8:0:b0:514:a179:b151 with SMTP id
 y24-20020aa7ccd8000000b00514a179b151mr1610790edt.41.1685368947363; 
 Mon, 29 May 2023 07:02:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ510QWjG+RFlHmeCrPdvlqvEtFovcewTXQ5zlrjDXHvEmH5MVjEwz12mTI4MyNmn0RyD1YbTg==
X-Received: by 2002:aa7:ccd8:0:b0:514:a179:b151 with SMTP id
 y24-20020aa7ccd8000000b00514a179b151mr1610778edt.41.1685368947089; 
 Mon, 29 May 2023 07:02:27 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 ay1-20020a056402202100b005066cadcc54sm3115204edb.43.2023.05.29.07.02.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 May 2023 07:02:26 -0700 (PDT)
Message-ID: <d03d78be-76e6-dff7-b11b-cac82e6eeedd@redhat.com>
Date: Mon, 29 May 2023 16:02:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] scsi: virtio_scsi: Remove a useless function call
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <08740635cdb0f8293e57c557b22e048daae50961.1685345683.git.christophe.jaillet@wanadoo.fr>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <08740635cdb0f8293e57c557b22e048daae50961.1685345683.git.christophe.jaillet@wanadoo.fr>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On 5/29/23 09:35, Christophe JAILLET wrote:
> 'inq_result' is known to be NULL. There is no point calling kfree().
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/scsi/virtio_scsi.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index 58498da9869a..bd5633667d01 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -338,10 +338,8 @@ static int virtscsi_rescan_hotunplug(struct virtio_scsi *vscsi)
>   	int result, inquiry_len, inq_result_len = 256;
>   	char *inq_result = kmalloc(inq_result_len, GFP_KERNEL);
>   
> -	if (!inq_result) {
> -		kfree(inq_result);
> +	if (!inq_result)
>   		return -ENOMEM;
> -	}
>   
>   	shost_for_each_device(sdev, shost) {
>   		inquiry_len = sdev->inquiry_len ? sdev->inquiry_len : 36;

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
