Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A48833AD8A
	for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 07:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776930931; cv=none; b=n2Zym2dRGh+f7oFLNB0luQ2Jg2MJy9i+gFZadoCOSnm5v3pMFvlIMBRb9WHVmbeNgKLEYCMBWMLWj1WsTrjomGq1cRkVJ5fS98/LOfqef4GypbYxgJ8F1N8EgYouvLOPUjJxzc7ha+uTk4hTu7q2eptoWm+yoTnoAbtWDttdlbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776930931; c=relaxed/simple;
	bh=L2WN3Mdkt+PLvtN1w07nhMKHoYH38g1usozRivR3K9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gBasF7X02zRlFcuwqyVb+3T+gWWWhW3h5S2Y4m01bEQz65KT2p6H/Ca4PdXV2zVkJILXnKD6qJiZZSaJ4/P43L8W0zHxH2eg1WSVQbaD3m21BiLbghjbjbyYRtE5dqyfqQdvHinXonbHlGyH7smkTtlIdWIxBpR4814vMB33I/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ecoLtfXe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecoLtfXe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776930929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kw0NWAnxiHM/StsVSGBC26LNQSa2ifdysLtA6b6dLbI=;
	b=ecoLtfXeT8yE7zwVFzHDM4ni+2PCPl76kjsodP3oeDSQniQYsxAgS1Tb2fNVMQMagYK5JK
	hskeqpusb6pc+qdOmIul/yFWknfqUSnI2a1jS9Igh5CnPDNt/y++u+PFt2QsY9aAPSMdMn
	4YP1wEQ9q1FLwwPAhlhWQmCAPh/uELg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-Mfq2wLDsMpiTVETGbsWOkw-1; Thu, 23 Apr 2026 03:55:26 -0400
X-MC-Unique: Mfq2wLDsMpiTVETGbsWOkw-1
X-Mimecast-MFC-AGG-ID: Mfq2wLDsMpiTVETGbsWOkw_1776930925
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-440d0c4401aso3758094f8f.0
        for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 00:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776930925; x=1777535725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kw0NWAnxiHM/StsVSGBC26LNQSa2ifdysLtA6b6dLbI=;
        b=X/q7yaZVw+xTdzGBAwfgXJvqNuIsk7J4eYhdUuvT0Wgc84YefPx6H7rwnRDNfwoVgF
         A6FW9aEkU6T0BFTF6GwwlAFu7530Es0XE1BOKDFqrNmB9FoTVbakpZvnlG2fDk9ggv1v
         apvHwgtRcEowwkcQNt1PRx8EnhV1d+11KiyedsIeQBtYjvC9tZiYODkBd2TqVFdAxzmC
         WXdNLXMjY2ZFvfzXK5DLmyuCuPTBYcvYT7mORD+oateMMyhPU4nXdvjbkkcN23w2dkHU
         iZULYjb/RrUhj8YMegTRC7sm3gvDZoyO3vPus6aZYbM0FEHy6frcsT0e2eDCyDqVm0EG
         tqHA==
X-Forwarded-Encrypted: i=1; AFNElJ+KfBv/uj11JIbapEjTU44ayYrdi/lKfBaYaPTMTI3CB5pw38bu9bwacbiL5zV8dZ0JqTn00tGQkksy7hGwHw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyOSAFeoek4Ga7PSnWYlsVTlvK72VVgvnef7jiiPvDhHUFVX7no
	aDU3DHQTuHoZ2lxxZ2rlhd/veD/EY/Wczc71L2YtKdyD4+UX4D76eZ1sZW1o6oXzq8nqlD+7T+9
	o8IPsNOFjBfvxP96cJNE2giDlggFkZbRCPpggaOFqvLD79LRYU7Uv2oywriRIn1z/m2ao
X-Gm-Gg: AeBDievxYw7FCmiNCvbJwk6iCge1A2N7DUwdjdNN+vQ+ZS8Qnuzv0FsRFjb4uhjuemv
	3L5FEyLOXw6iTAzNb2dP+2vwbh2ntPpjbK35L+EUFo3tSkMssvZZBtwq5FHXhCwqUZ7ores7+xy
	x0/uhKFWIuoSJbYXnJ0uR/cC3oGIkopoK+D966sIxdlEnlnGgKiE7lVycr49C/8pvqeQ4AtYnko
	KgKuK4Fex6Tl0ApiO47pWiJGgE7yoO+Ito4BVh4mOY6l+i2qqtKeh2T0amohEe1dRd5YNWgtj0n
	6zd9WLpRfSZPnJAXD3e+SEU48jA+DDeZpeAvqxgDZyilVKfbafaslJM8jJemgobtZUaLs8+EWRO
	za90xY2AOIMFVf9OSAeD7pkN7QuS9M/xKQe2VZ4zSs+NiqLcCdLoihjUwcQfo7ddt6XFrXlBbc2
	IxyIjWaw==
X-Received: by 2002:a05:6000:610:b0:43d:1c21:ead5 with SMTP id ffacd0b85a97d-43fe3e0b4d8mr40520279f8f.22.1776930925156;
        Thu, 23 Apr 2026 00:55:25 -0700 (PDT)
X-Received: by 2002:a05:6000:610:b0:43d:1c21:ead5 with SMTP id ffacd0b85a97d-43fe3e0b4d8mr40520207f8f.22.1776930924637;
        Thu, 23 Apr 2026 00:55:24 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4412e36ff8bsm2933844f8f.26.2026.04.23.00.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 00:55:23 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:55:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	longli@microsoft.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, niuxuewei.nxw@antgroup.com, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] hv_sock: Return -EIO for malformed/short packets
Message-ID: <aenQQpYW6j0BoC69@sgarzare-redhat>
References: <20260423064811.1371749-1-decui@microsoft.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260423064811.1371749-1-decui@microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VtDXd-z3g4nFnOM0UxRzDWbaPqE-M4_ouD9mFdJLcx8_1776930925
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Apr 22, 2026 at 11:48:11PM -0700, Dexuan Cui wrote:
>Commit f63152958994 fixes a regression, however it fails to report an
>error for malformed/short packets -- normally we should never see such
>packets, but let's report an error for them just in case.
>
>Fixes: f63152958994 ("hv_sock: Report EOF instead of -EIO for FIN")
>Cc: stable@vger.kernel.org
>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>---
>
>Commit f63152958994 is currently only in net.git's master branch.
>
>Changes since v1:
>    Integrated comments from Stefano Garzarella:
>
>        1) access 'vsk' directly:
>           s/hvs->vsk->peer_shutdown/vsk->peer_shutdown/
>
>        2) test the error condition first and return -EIO for that.
>
>    NO other changes.

Thanks, LGTM!

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

