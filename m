Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B6FC6FD1D
	for <virtualization@archiver.kernel.org>; Thu, 23 Mar 2023 07:37:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 40A8A41CAD;
	Thu, 23 Mar 2023 07:37:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 40A8A41CAD
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NfdCFV/t
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uHqbva5U51rd; Thu, 23 Mar 2023 07:37:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C06D5402BC;
	Thu, 23 Mar 2023 07:37:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C06D5402BC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97320C0071;
	Thu, 23 Mar 2023 07:37:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCF75C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 07:37:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 914FB41CAA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 07:37:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 914FB41CAA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fimv0ftbl7ds
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 07:37:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D8228402BC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D8228402BC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 07:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679557045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ASpqWWfn4/Pghp46A648jZMTYKlpL4ywq85+5CfPLiM=;
 b=NfdCFV/tyWkMHPvk62C7eNWPo2v/iV5AI85EkIDHKYSWc3wO87tlH0G1tGM34S9kSJasEn
 WNO6s9zvBZrq//A4hnl6X7Fi9emwXLvpU7ii/D6sArHgrAefZ7lqtlBSHZMZEsPY8oBaRv
 3wMcFfDFTB80Y25+eEtWo6AdcQAK1Xk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-i4979rCjM4SL9x5XENTyMg-1; Thu, 23 Mar 2023 03:37:24 -0400
X-MC-Unique: i4979rCjM4SL9x5XENTyMg-1
Received: by mail-ed1-f69.google.com with SMTP id
 q13-20020a5085cd000000b004af50de0bcfso31421274edh.15
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 00:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679557043;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ASpqWWfn4/Pghp46A648jZMTYKlpL4ywq85+5CfPLiM=;
 b=rq5nVmlNJt4PR3Xp3XT7FBeC9lNsRWUcpyRbGguhqzMh1cJZIbTVFb7BznE0eYjSRr
 SYteKTQ6nTgBTWC19sbPbA36RVv/gdBqKumnwVvAoJlUOitgqQmajsf96mHWqTd6+dm8
 BzBQY7Fhh/94Zs51VEU6a1wXx79ZEn///05SkcDdY/MZzb6JMtqxkG7Z1i8+GdIqQ0e8
 FQ45q2qWRkij5Hv/wuV/22RV5ZTPr6qHyuh6Atd5ZAfYSlW23PpuqBlFJ9Fe7M1LRNQF
 ov/voxWOdXXdF+nypb6dbt2gJODoRS1PYtZKSyibls0UuO/lAbnmneFivxS2SNidw9p4
 8e+Q==
X-Gm-Message-State: AO0yUKX+VEZvkAqudaQrecQXITlCWUNNNc407p78YoLkbLvU+n1w1Og9
 dmyIHgdQ58aygYaA3lxfJwMVNrfD60+RfNeUYwDhFGYZjX7SWHhS+S/7Jh2Z5PxvESXQzutezpB
 oarMZA1h1bHNgpthAe3DKmQhef2DGwLbRxOdfAvDUlw==
X-Received: by 2002:a17:906:7211:b0:933:3a22:8513 with SMTP id
 m17-20020a170906721100b009333a228513mr10805911ejk.53.1679557043438; 
 Thu, 23 Mar 2023 00:37:23 -0700 (PDT)
X-Google-Smtp-Source: AK7set8b/L3BTDQBOOU5TMs2+wIlVxaD2QXEXQ7Fntb3f/aW6QW0aeG0Wm8pxwOFNNaJCGOwphxUNQ==
X-Received: by 2002:a17:906:7211:b0:933:3a22:8513 with SMTP id
 m17-20020a170906721100b009333a228513mr10805896ejk.53.1679557043131; 
 Thu, 23 Mar 2023 00:37:23 -0700 (PDT)
Received: from redhat.com ([2.52.143.71]) by smtp.gmail.com with ESMTPSA id
 d7-20020a1709067f0700b00882f9130eafsm8208911ejr.26.2023.03.23.00.37.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Mar 2023 00:37:22 -0700 (PDT)
Date: Thu, 23 Mar 2023 03:37:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 1/1] vhost_task: Fix vhost_task_create return value
Message-ID: <20230323033557-mutt-send-email-mst@kernel.org>
References: <20230322185605.1307-1-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20230322185605.1307-1-michael.christie@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: brauner@kernel.org, syzbot+6b27b2d2aba1c80cc13b@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com
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

On Wed, Mar 22, 2023 at 01:56:05PM -0500, Mike Christie wrote:
> vhost_task_create is supposed to return the vhost_task or NULL on
> failure. This fixes it to return the correct value when the allocation
> of the struct fails.
> 
> Fixes: 77feab3c4156 ("vhost_task: Allow vhost layer to use copy_process") # mainline only
> Reported-by: syzbot+6b27b2d2aba1c80cc13b@syzkaller.appspotmail.com
> Signed-off-by: Mike Christie <michael.christie@oracle.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

The affected patch is not upstream yet, right?
I don't know if the tree in question allows rebases - linux-next
does. So ideally it would be squashed to avoid issues during bisect.
Still it's error path so I guess not a tragedy even without squashing.

> ---
>  kernel/vhost_task.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index 4b8aff160640..b7cbd66f889e 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -88,7 +88,7 @@ struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg,
>  
>  	vtsk = kzalloc(sizeof(*vtsk), GFP_KERNEL);
>  	if (!vtsk)
> -		return ERR_PTR(-ENOMEM);
> +		return NULL;
>  	init_completion(&vtsk->exited);
>  	vtsk->data = arg;
>  	vtsk->fn = fn;
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
