Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBEF3B290
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Mar 2024 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711705923; cv=none; b=lkliK0UEeoLWq2SZqN91kYAnN5J7KfJ7D6SEpstSxYkZgFqchpVF+C/1fVpt+Oq3TdKx1ua4eXU8q7JTwknkVEg9OMfBTfgOIZPTSsM/Cg+V3iFw63n1yOQvDeGIwm5HM5yzhYGPLBnm6pbYHPAFGqhudtmJRVFg1S3I2SIrp6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711705923; c=relaxed/simple;
	bh=djiaB4U2ZnOlHE7cFPb+RDg52bCNsVSynx5YnvVL9bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=aDaBA7yuCKU0AVIqrm5JlRF+haB98A1VEbF+Bm6u3UyJZMV/1lU7m3Ppo8N4D4eNKODkRNO+DPMZxcTdDwQZcI4kgb66yxIeLIcxbTZHgf3pl+s5LAG9OtE9vYYQRT5TLAhIF1Tqanp7iTXgYvU4LrGkxHWu5fFXIO+/eR4piqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hbhIGJsd; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbhIGJsd"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3CE8D60E7C
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Mar 2024 09:52:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JqMVH95jYBbG for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Mar 2024 09:52:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4968B60D6D
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4968B60D6D
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hbhIGJsd
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4968B60D6D
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Mar 2024 09:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711705919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=deMJ3oVnouvBFi4X5/gthJT9K+f+3N94offCvLJPHoE=;
	b=hbhIGJsdvicAvRAi3SyFXzUs2IlUkOega50wgVMGjX7auZgpZ4FoZK8rJbJ++/IUz9vl85
	jvc1vDNutnqMXBY120mfkXBuQMyJVyHb63rO+2kNzV0KJrVxgPZ5m48guKs5+EO0SpNNNp
	dYyCOZUr3hdw+x7TQEy2yLoa8D6CVPk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-JeROoRVlOcyY521iuMJNpQ-1; Fri, 29 Mar 2024 05:51:55 -0400
X-MC-Unique: JeROoRVlOcyY521iuMJNpQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-513dda67cbeso1618465e87.3
        for <virtualization@lists.linux-foundation.org>; Fri, 29 Mar 2024 02:51:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711705914; x=1712310714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deMJ3oVnouvBFi4X5/gthJT9K+f+3N94offCvLJPHoE=;
        b=W1vEF++cUR+li9rfSrjosY3grE27CGpXz2CC+5Rnq6wb4Enl2QHOl7eCnnIJa/E2AB
         0JmlS56AgDOXtgX1KWG1QcKypQIOB35Wt59UNPaSrKs/Eh8JjbCIK+VzD196vsC+Ka47
         CZCbtYWi85MlVCMhakwhh95HswP9MRKysDQLYkB2i+x6ygIWy8G5HkVVHn7Hn+9w71lz
         89TtdX6BKlI8VE+4gwlKjfIM1eeehR0sUoaDDjsuivWUk1VALumnh38uBPG5VbG8td6z
         +3pQ/+8uX00R8sN1fV2Gha5hg+QJ7wO2XBqyeVSrk8hdM25UH84xiU8XZZeRGoWDHaMI
         306g==
X-Forwarded-Encrypted: i=1; AJvYcCXcOdIniiOyX7kb9I4dYTIWKUW7IgN+VnEdax4IM2nRaGkACD0Ky/tSPOsYTDUxsExEQlW0e5xAktffCXnPiDsDCOZ88Mz7rACQpROX6GNcAd+9kUPH1/rdKw==
X-Gm-Message-State: AOJu0Yx5Q7xjB/BJWIMEtdKJZSzIqm129VhmIm2Sr2S8coOPEAJtpDVX
	gwc+FHd5lSuEWyk+DTVykXpLZ7Inz7gDRDHGBtmec4aCLVD7cmp4wDI/MVgFLih7GVNgg4sEVRM
	zYSbMKi7yaoURNGJU8Fn6Q61xAJe8o9Pm0JWGK7KwBNCk1o1+f57RXj7wV13bcXiOtmSvXXDE5c
	YYb6w=
X-Received: by 2002:ac2:414e:0:b0:512:cc50:c3e0 with SMTP id c14-20020ac2414e000000b00512cc50c3e0mr1283296lfi.52.1711705914342;
        Fri, 29 Mar 2024 02:51:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzCIBkxIKVbMHIoPNaKtpwlibzeDnCCEzGl88sYaXjP+u7tE0mYtwUWm3GQccH/hMA1lWuvA==
X-Received: by 2002:ac2:414e:0:b0:512:cc50:c3e0 with SMTP id c14-20020ac2414e000000b00512cc50c3e0mr1283273lfi.52.1711705913698;
        Fri, 29 Mar 2024 02:51:53 -0700 (PDT)
Received: from redhat.com ([2.52.20.36])
        by smtp.gmail.com with ESMTPSA id y13-20020a5d4acd000000b00341e5f487casm3782337wrs.46.2024.03.29.02.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 02:51:53 -0700 (PDT)
Date: Fri, 29 Mar 2024 05:51:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: Add reconnect process for VDUSE
Message-ID: <20240329054845-mutt-send-email-mst@kernel.org>
References: <20240329093832.140690-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240329093832.140690-1-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 29, 2024 at 05:38:25PM +0800, Cindy Lu wrote:
> Add a document explaining the reconnect process, including what the
> Userspace App needs to do and how it works with the kernel.
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  Documentation/userspace-api/vduse.rst | 41 +++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/userspace-api/vduse.rst
> index bdb880e01132..f903aed714d1 100644
> --- a/Documentation/userspace-api/vduse.rst
> +++ b/Documentation/userspace-api/vduse.rst
> @@ -231,3 +231,44 @@ able to start the dataplane processing as follows:
>     after the used ring is filled.
>  
>  For more details on the uAPI, please see include/uapi/linux/vduse.h.
> +
> +HOW VDUSE devices reconnectoin works

typo

> +------------------------------------
> +1. What is reconnection?
> +
> +   When the userspace application loads, it should establish a connection
> +   to the vduse kernel device. Sometimes,the userspace application exists,
> +   and we want to support its restart and connect to the kernel device again
> +
> +2. How can I support reconnection in a userspace application?
> +
> +2.1 During initialization, the userspace application should first verify the
> +    existence of the device "/dev/vduse/vduse_name".
> +    If it doesn't exist, it means this is the first-time for connection. goto step 2.2
> +    If it exists, it means this is a reconnection, and we should goto step 2.3
> +
> +2.2 Create a new VDUSE instance with ioctl(VDUSE_CREATE_DEV) on
> +    /dev/vduse/control.
> +    When ioctl(VDUSE_CREATE_DEV) is called, kernel allocates memory for
> +    the reconnect information. The total memory size is PAGE_SIZE*vq_mumber.
> +
> +2.3 Check if the information is suitable for reconnect
> +    If this is reconnection :
> +    Before attempting to reconnect, The userspace application needs to use the
> +    ioctl(VDUSE_DEV_GET_CONFIG, VDUSE_DEV_GET_STATUS, VDUSE_DEV_GET_FEATURES...)
> +    to get the information from kernel.
> +    Please review the information and confirm if it is suitable to reconnect.
> +
> +2.4 Userspace application needs to mmap the memory to userspace
> +    The userspace application requires mapping one page for every vq. These pages
> +    should be used to save vq-related information during system running. Additionally,
> +    the application must define its own structure to store information for reconnection.
> +
> +2.5 Completed the initialization and running the application.
> +    While the application is running, it is important to store relevant information
> +    about reconnections in mapped pages. When calling the ioctl VDUSE_VQ_GET_INFO to
> +    get vq information, it's necessary to check whether it's a reconnection. If it is
> +    a reconnection, the vq-related information must be get from the mapped pages.
> +


I don't get it. So this is just a way for the application to allocate
memory? Why do we need this new way to do it?
Why not just mmap a file anywhere at all?


> +2.6 When the Userspace application exits, it is necessary to unmap all the
> +    pages for reconnection
> -- 
> 2.43.0

