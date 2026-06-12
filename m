Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4AA3EA968
	for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 13:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781271576; cv=none; b=c0TrXMRKmpdhlxj3uv8k/krgUfe+CmqLVdfJSZ50HSJRnUo4627icH6rCYdAxPVQi4PnBo6UvpI1lCjncaCGtmM6of4CV8AZ/upLIXLECp1G2HBMrnDYeY0vY21VcQ0lDSedR4zTopABxN6o/rAE7jqc8S4ev8AqooAFEkAlF7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781271576; c=relaxed/simple;
	bh=lYvSM21mI5IdNvW11t4ECXqYviymzd4QCxw07mn2wEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LDQuQ1y+WvMZMr7KdBcbNmlHNbt6g1AvnOm5RA3skxzJzr4/GaHfUZznxQDuWnNLXS0fIDDhl5hxBavPhM659Io1TeMi1jYkAa/UuUNeU7smrAd3WDa7r3l5Q5zHcrU0mvyDczj/PI4rWDHY4ERgebz6kIAGAnkdmY0VTmXG1Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ox3/XUkB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ox3/XUkB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781271574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lYvSM21mI5IdNvW11t4ECXqYviymzd4QCxw07mn2wEw=;
	b=Ox3/XUkBrkjv86liLjRC4KjZ+YVg6MQj3BxgDYgpr4/kv3jLohGD9JkXxA7f0DzkkrM0U1
	/dPHobqnjvCMD/oyYsiYavncChwFl7vlDpWfZbsdRrHbe2Ipz2DZSxX4jB4VUro7wwnyh4
	aQZoXmJBFW/I2OSan/43OsJv7v6TAzU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-FfDTPrAHN2iiRd6gqduWCw-1; Fri, 12 Jun 2026 09:39:29 -0400
X-MC-Unique: FfDTPrAHN2iiRd6gqduWCw-1
X-Mimecast-MFC-AGG-ID: FfDTPrAHN2iiRd6gqduWCw_1781271568
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490b9318944so6672895e9.1
        for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 06:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781271568; x=1781876368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYvSM21mI5IdNvW11t4ECXqYviymzd4QCxw07mn2wEw=;
        b=qXtDvvj2QJs/Gz9Dshhgua70y7CtnqWtmkyr+IxDh9QxBZBzJoWqipicxWurJ1yNdX
         jN8NKYy8vNhyiR8QUiyqPIFLCKtN8/dsqV9f0L5DCLMu9i+UOhsysFNCpxgNs42jQmWc
         DVnlJJSthyNTuuegnxNbDk4BiWIzSfjIxPx6WHUan7Ovwnq7W09kUS/99DphiBAn0Txo
         6PXvvPypogtehPG+g9YCfZEbslVoc4t7CbYHYD3nVgi/ZG0iGNTVN1VAiWpOk3SSz6m2
         W8OF4iK94V23P7asDXxxXGSiUC/Lu1qrpVn8/jiIKqRX4rIRtxRTqRk7ExQ21LJqGoc5
         Z0zw==
X-Forwarded-Encrypted: i=1; AFNElJ9ACJ/g9LuA5Pa6rao3RixhzjKgRGiHKkDPT/FHfbXI78YxSXI4YpSVZFZxnOqN0XUvHTFE7M9KqYstpmdCQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUpkHXrMX45eJl0H2vro1kBuar+14Vt7ez+GqkqDwNWfHrc0Dr
	BNJkS9QIkijPCci2Kbs1ZEqS5ed+EEMXRNIQC6xaSKhcAJO41W+nMbDpUUq8qr0YUuqRHDcPVm7
	TXnRoOhhV+Ygq7QiHyy9w/DRn759w+z8QTW0D6XFwYOXcaw1JHPuM1LSStWGkRfxsWJb7
X-Gm-Gg: Acq92OEKTW3DM/GPOkBAph0znf3r+eXKv2ZUG+s3BfyK2v7JIS5VBnNocHEnYqMsvzo
	MPnbNRxgEwWL0gkpewlp+uUx9U+X2ziT+7nW+P9wYymnQEWk+j7SD361wFxrGc/JP4/oXBklzXi
	MnaYTo90PDCa4v7e5bSy/lpfviAMao3KjYSt/s/i4W/BhHY8mKkusIfFHm2cy3UojI86sSZDvmI
	qTe7kS+imf11N6G/AgF0hjoMIlyCo5pHeZtcvKMDW2FatdRAqLdmJBrB/RXjo7tYTVftgLTEeUj
	I9GVTOYtUC+JqaZzoDYq9Y5qpImcNE1FB23Nitdb4HMRaEvbz7wjyeAY1Dw245alfmXUaZQjEA9
	GQXWorQLTh2CVuwnoADz4nDK62pOp3VPEt8DsxGKPyd3GS2TEtwXwjWghad0=
X-Received: by 2002:a05:600c:3b15:b0:490:ec79:3077 with SMTP id 5b1f17b1804b1-490ec79315dmr40207955e9.16.1781271568199;
        Fri, 12 Jun 2026 06:39:28 -0700 (PDT)
X-Received: by 2002:a05:600c:3b15:b0:490:ec79:3077 with SMTP id 5b1f17b1804b1-490ec79315dmr40207405e9.16.1781271567680;
        Fri, 12 Jun 2026 06:39:27 -0700 (PDT)
Received: from leonardi-redhat ([176.206.21.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2c7ead0sm165992055e9.3.2026.06.12.06.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:39:27 -0700 (PDT)
Date: Fri, 12 Jun 2026 15:39:25 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, 
	bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	bobbyeshleman@gmail.com, horms@kernel.org, edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH net-next v3 2/4] vsock: fold sk_acceptq_added() into
 vsock_add_pending()
Message-ID: <aiwMAASKtqsiU_1d@leonardi-redhat>
References: <20260612045216.105796-1-rafdog35@gmail.com>
 <20260612045216.105796-3-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260612045216.105796-3-rafdog35@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JD-eoObVAUi10M89cMGhBMFmInKi2BV6FjxkVQuOMFU_1781271568
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jun 12, 2026 at 04:52:14AM +0000, Raf Dickson wrote:
>Move sk_acceptq_added() into vsock_add_pending() so callers cannot
>forget it. vmci is the only transport using the pending list and
>is updated accordingly.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Raf Dickson <rafdog35@gmail.com>

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

