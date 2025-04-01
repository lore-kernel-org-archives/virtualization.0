Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855E2204680
	for <virtualization@lists.linux-foundation.org>; Tue,  1 Apr 2025 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743515987; cv=none; b=RLR7fMo0Yp5gDYy5II+TunGLwZy1z4miKcZ70eTE5dLdWJMoH0mZo3T6a5vTK7hMWA9uk+/aVcpToojp63jL9KCbdsiAMpqQSTHPKDOsNbtZVR5IaSmVLIGBGUsoJewIruZXlL3SVTx6Q++3jXvPc9fasY/fsAETITrAZjzRcnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743515987; c=relaxed/simple;
	bh=hDLzqRPsoDGnUdms0LQYvaYmGEbT2S3EwsAgwQYZnT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QFC9xLk6DlWAiM6ismFTZYuJ2yBSshwknr05tBrQIhxq8HhCK5PwNrDfCoSGTa9S4ZTbGF5ABky5PiF84Xd6bpzMNg5hvTHxj6GMbmSd5JFoFzhvbEXVfWHTUST0wI2d/FWnS++JCNh1uh7TsBIR8VUTjt5VJ+NjorF+hO4OPiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DifNZSxt; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DifNZSxt"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 253B58496C
	for <virtualization@lists.linux-foundation.org>; Tue,  1 Apr 2025 13:59:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sJKbd9-jgmna for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Apr 2025 13:59:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5409E849AC
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5409E849AC
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DifNZSxt
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5409E849AC
	for <virtualization@lists.linux-foundation.org>; Tue,  1 Apr 2025 13:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743515983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t2IgA5uO8titoAWyijzoucLkCRmrJQPxxk3pK7glj/g=;
	b=DifNZSxtqkOyj86qQmFQ9HyLGFhTlyL8/Hd46aEzmA48zum2y9QyEasJyUxz28PMzf+dhr
	CgQzJ63RpQMG+9g8wE+iMre+RHRILSNDBzvA7oeRHzW03r7m2UW+sWmk8TULxBlMI0j4YC
	w92JjcG3By70FB7WuzMhPymJEiDjhEY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-0BSbRiesP0auNzLeFKTljg-1; Tue, 01 Apr 2025 09:59:37 -0400
X-MC-Unique: 0BSbRiesP0auNzLeFKTljg-1
X-Mimecast-MFC-AGG-ID: 0BSbRiesP0auNzLeFKTljg_1743515976
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39135d31ca4so2959477f8f.1
        for <virtualization@lists.linux-foundation.org>; Tue, 01 Apr 2025 06:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743515976; x=1744120776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2IgA5uO8titoAWyijzoucLkCRmrJQPxxk3pK7glj/g=;
        b=d3igfE+TP2CtoNc52HFW+yP1NvJtha2f1LqHe49cadHODKaFvZBPZSgnDt6dhAuu7C
         WcomA9wb+qXMV3w9HwN5SiIhioUSXlIt3OTClU2DNKUIyy1geebSRg0NtZlDeiqf4YRA
         TI/bezL/s1m19UKMGykMLaGiYAuKA5lg7NfL3cLJx6U9Ld7ThS5EV5wYBRCCotECPJYf
         94LQkz/haM0sxuAHkl+5AhT2Yab09bTZ1dFkIQF6oxC3pDqOIP5SmtEQtr71WWsqyWeA
         1F7aI9bK7BNsZvm8+Bk6+ybVkTn3Qjg99E/8KutpsA6zfDyxVbhDnT3ySWrsvPHDq9J3
         iTRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAyYYQhT1JdfetBRiEFTIJHbnhCA8Ltqu82+Z8k0gY/o2ra8H+1l5N9E9D+zg8m/SD41XT9Pjmf0RbeqRtnQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxbLunluO4WjgmOX+nWkw3dr/WRR1xOeuN6xzAjOYyz+W5ivntv
	LJji7ulyjL2lp/uh1bjnjIV6Gdf5K3Z8dCMASK+QDM2aw2DbNNDTwo9z1F+AOpgTPvfYsf4Vb//
	dbKpTmehk2UfqCraSxU1XNZjcUxegNJ60z06MIDcupR8r0R9hB5+fAJhMlhbzncUAOv+GuMspHd
	8Z9GA=
X-Gm-Gg: ASbGncvrYnrsH3jbz9+KBxEms/wFgLkU6p6obiCjPpVvY4TXJryaIrBNzxs/XshTTVS
	/r2iJt/JmfEMIZ0hTJgbjt5k+B/KmfEsSdkyzYCLq/2F/v9cNm1KBtnZQjchTjzwzbr9WNwPbq5
	WDSMCbzwjEFtSrP7AhiDxE/TGewabKv1NTbcJLjLoyNS93k6R/tmQujekrE9jxgQO4g1Hak3IeD
	KbYWIhVMJJ38wQEyr9PspDo7hyiq/821r+9ZiN8o+304z/qnOb8iVDb9nddpotr4Be8NfQpZ8ND
	vxmNH7JBUe4hkZgNLH4yI500i8IeHDFVOfipOW554MoDUK7SyKWAdAnQljo=
X-Received: by 2002:a5d:584c:0:b0:39b:3c96:80df with SMTP id ffacd0b85a97d-39c27ee611bmr75397f8f.11.1743515976251;
        Tue, 01 Apr 2025 06:59:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF09FwfqnRb8UJMujFmXs/QqdYBJeJRX2YI3guWVQi2x8F5XNEe7ScWOGZy7YxSOXZw3qmefg==
X-Received: by 2002:a5d:584c:0:b0:39b:3c96:80df with SMTP id ffacd0b85a97d-39c27ee611bmr75369f8f.11.1743515975769;
        Tue, 01 Apr 2025 06:59:35 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-59.retail.telecomitalia.it. [87.11.6.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82e6adf6sm198134245e9.15.2025.04.01.06.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 06:59:34 -0700 (PDT)
Date: Tue, 1 Apr 2025 15:59:26 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v8 7/8] vhost: Add check for inherit_owner status
Message-ID: <d35istatjtnr42x4gwpwlgx627pl3ntqua3kde7fymtotl676i@jxxxkrii6rue>
References: <20250328100359.1306072-1-lulu@redhat.com>
 <20250328100359.1306072-8-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250328100359.1306072-8-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2zQ8ZuC-ZSCmd-cHBEpYbwboYXATKIefGxQ41eoDdYg_1743515976
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Mar 28, 2025 at 06:02:51PM +0800, Cindy Lu wrote:
>The VHOST_NEW_WORKER requires the inherit_owner
>setting to be true. So we need to add a check for this.
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c | 7 +++++++
> 1 file changed, 7 insertions(+)

IMHO we should squash this patch also with the previous one, or do this 
before allowing the user to change inherit_owner, otherwise bisection 
can be broken.

Thanks,
Stefano

>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index ff930c2e5b78..fb0c7fb43f78 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -1018,6 +1018,13 @@ long vhost_worker_ioctl(struct vhost_dev *dev, unsigned int ioctl,
> 	switch (ioctl) {
> 	/* dev worker ioctls */
> 	case VHOST_NEW_WORKER:
>+		/*
>+		 * vhost_tasks will account for worker threads under the parent's
>+		 * NPROC value but kthreads do not. To avoid userspace overflowing
>+		 * the system with worker threads inherit_owner must be true.
>+		 */
>+		if (!dev->inherit_owner)
>+			return -EFAULT;
> 		ret = vhost_new_worker(dev, &state);
> 		if (!ret && copy_to_user(argp, &state, sizeof(state)))
> 			ret = -EFAULT;
>-- 
>2.45.0
>

