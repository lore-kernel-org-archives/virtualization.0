Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2381D460B
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Oct 2024 13:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307918; cv=none; b=j/8+TUMquYqVN5ufW0Vsu/5QRCAmJPLWCM2B4I6wiwuir5knCp1x2nSzvNnzI5h+oJx1hua/ecnjMVPGPZn9VqvbZRGl1SrKSOAmtM5EoyWpGtPON+yUq7q6U4uE0jvb3GR81cwQhlygYdXacknbKl/EOWEtlGDXgVuFzgEc214=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307918; c=relaxed/simple;
	bh=eIMXnheLgwY5mybCt8FtGo2eFwqlzkHxp79j8QrmOaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=I4kZ9GU/8b2oNlCXDPLtHipOQGVu65dHpS25qSzqZxbjZjUtevymCj0xN4NJy3B9SlKkGbnaOMnkMTJpAhQCyAWGLSEGwK97JHPbpI1t2msaYMkEGZvEdJxMohnrADXqpwy9swvDm0/XTl1X+WTipP5KSN0XE3PuVnxVi3GbfMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XvJcs/b0; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XvJcs/b0"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4838B40179
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Oct 2024 13:31:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w_K8odD-dYaz for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Oct 2024 13:31:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 33C1F40162
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 33C1F40162
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XvJcs/b0
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 33C1F40162
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Oct 2024 13:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728307914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hqk2iWvYlf396g8OOaJ8zXakmd0+WF8brPT7Fp5xgVg=;
	b=XvJcs/b04ALq0fL/gzl5DenGQzzJkpV5xNrG2oGibAMLowaAA+ce/OUj55m2TW017uIs3f
	U7QSG/+FloUvoUPDWsbkrVAlCe4kK66Jku3Xkm20tEywMK+cop8/MTFOxW4FFVuGXU26Yi
	4wsVFOKJlEbow+BScsPOVW+v4kHQggw=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-_8gZm-OPNS63wopXiQvoPQ-1; Mon, 07 Oct 2024 09:31:53 -0400
X-MC-Unique: _8gZm-OPNS63wopXiQvoPQ-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a36a8fa836so29330085ab.3
        for <virtualization@lists.linux-foundation.org>; Mon, 07 Oct 2024 06:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728307913; x=1728912713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqk2iWvYlf396g8OOaJ8zXakmd0+WF8brPT7Fp5xgVg=;
        b=TCFl8XJL5baU6edKdTj9+IUBeYtTcEb71qP5WUZW6upKzGB/A1R0vBMoKsoa7t4JSZ
         bdgDDXSZ4D+YFUKmeT4nyAgBhwYjN/egsyWHteFhGq6Xiqicf8ETBdTOdUGjWG+NbCfJ
         W+A5wEEGeuhsUAbtbARjVUB5P/4PNRiWXXyMh879PJdEeHQu6hOKABpam/gRPiM4JwNt
         uKL27MmzpxJcT+AvL7G4kE4mUPboIGOE3L9A/O3BtbTGfBqbgjZJXR0eIXKNR46ZTrGA
         cWyQlpuOA4aykU61FvojLgLKSbbgCMwm5hUF4zMQE0TWI4CDjBYQ0zVKMCoiVbGKTVKc
         8BpA==
X-Forwarded-Encrypted: i=1; AJvYcCU/Xx5NBCD7S989KM0gJeeXXxPPvSan6tAWhubOFF0ipwu/5L2sxHR92372jwgIcE9sdAr7rwGi96SvCcERiA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwiLJGTsSJ7Kd60JxBA1NFQWe+fPiuZPBBzdyQmvxG8oLpRS9sh
	ysYBq01L6IjlIOwUqebnVlbRxZ5htfG2SgpMRsPBlasrIfcE/Os24xroZH1mTXdl28EUEoOF63A
	kNlDiHkpbxzyln/cCNv03QGQjEtYr53ECBWoLLwN5iZJtJerhp/oOtI4H7fUcObELcClcSfz91B
	8eMOc=
X-Received: by 2002:a05:6e02:1c8b:b0:3a0:9c99:32d6 with SMTP id e9e14a558f8ab-3a375bd2d64mr106097845ab.24.1728307912700;
        Mon, 07 Oct 2024 06:31:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHytcVO1FmhJ+bU2c/zU8wO91+yF3vR0ajfP57WOhlG1bZ8VjO72kOmwPr7mMBL4Ng5gE9mOQ==
X-Received: by 2002:a05:6e02:1c8b:b0:3a0:9c99:32d6 with SMTP id e9e14a558f8ab-3a375bd2d64mr106097255ab.24.1728307912051;
        Mon, 07 Oct 2024 06:31:52 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a37a874e00sm13449195ab.73.2024.10.07.06.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:31:51 -0700 (PDT)
Date: Mon, 7 Oct 2024 15:31:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 1/7] vhost: Add a new modparam to allow userspace
 select vhost_task
Message-ID: <olbm26f3ifb6ypfmfl22xszbpevqsxc3ogfzosrb44ujtzt6pw@uh7irbqfy5jr>
References: <20241004015937.2286459-1-lulu@redhat.com>
 <20241004015937.2286459-2-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241004015937.2286459-2-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Oct 04, 2024 at 09:58:15AM GMT, Cindy Lu wrote:
>The vhost is now using vhost_task and working as a child of the owner thread.
>While this makes sense from containerization POV, some old userspace is
>confused, as previously vhost not 

not what?

> and so was allowed to steal cpu resources
>from outside the container. So we add the kthread API support back

Sorry, but it's not clear the reason.

I understand that we want to provide a way to bring back the previous 
behavior when we had kthreads, but why do we want that?
Do you have examples where the new mechanism is causing problems?

>
>Add a new module parameter to allow userspace to select behaviour
>between using kthread and task
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 9ac25d08f473..a4a0bc34f59b 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -41,6 +41,10 @@ static int max_iotlb_entries = 2048;
> module_param(max_iotlb_entries, int, 0444);
> MODULE_PARM_DESC(max_iotlb_entries,
> 	"Maximum number of iotlb entries. (default: 2048)");
>+bool enforce_inherit_owner = true;
        ^
This should be static:

$ make -j6 O=build C=2 drivers/vhost/
...
   CHECK   ../drivers/vhost/vhost.c
../drivers/vhost/vhost.c:45:6: warning: symbol 'enforce_inherit_owner' 
was not declared. Should it be static?

>+module_param(enforce_inherit_owner, bool, 0444);
>+MODULE_PARM_DESC(enforce_inherit_owner,
>+		 "enforce vhost use vhost_task(default: Y)");

I would follow the style of the other 2 parameters:
                  "Enforce vhost use vhost_task. (default: Y)"

With a view to simplifying bisection, we added this parameter in this 
patch, but it does nothing, so IMHO we should only add it at the end of 
the series when we have all the code ready. Maybe you can just add 
`enforce_inherit_owner` here or in the first patch where you need it, 
but I'd expose it with module_param() only when we have all the pieces 
in place.

About the param name, I'm not sure "enforce" is the right word, since 
IIUC the user can still change it using the ioctl. It would seem that 
set `enforce_inherit_owner` to true, it is always forced, but instead 
ioctl allows you to change it, right?

Is it more of a default behavior?
Something like `inherit_owner_default` ?

Thanks,
Stefano

