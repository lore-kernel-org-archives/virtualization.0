Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EDC282F06
	for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270813; cv=none; b=CsmbgImtu2ztnqrBGD2sK7+P4ASxsW0XJwymAWmdChOLpHdAD9jfQ085nEvy1JsSAbfsVIWXa4K/gm8Rf5QuJRsxdKfeuR543yfeHo60qZVmNo5rF/VohEhixqW2+QBrc2xyQQM8pv2TG5FqZSIsBEURJmHfyof7hJ3x6NgvV+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270813; c=relaxed/simple;
	bh=rqNpdonaMf4xUXPVpMxWOBKDwUXW9fTTnr7wXzHdCvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VH62oFJq8yckx5+1mohs4zuzctK2wT+wI4JK/nj0zXOuCzMKFmSodWxR2aBj4MZX1+lBbWyzYyfohehInPBPRB23OHPZ9BmIdp2Laofni8NCx7mtBWx5BymD3al5UfcAYHCOnCN1EUTwXKWwmcK7uPaZZxpcdDec8e2kNeRTfxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J86zNxve; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J86zNxve"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781270811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rqNpdonaMf4xUXPVpMxWOBKDwUXW9fTTnr7wXzHdCvI=;
	b=J86zNxveDe8VhO61mgQ42q7VhVv7fNn3vAr34fGTdOmq/k8/dlIj+7EeNTR0Mp/jm675Ku
	8GFg3Wu0ciStILBrQHqPc/MY2VlPCev4yRfmsYYnDfr+AVE43XSE+yxMwxLJIwwnyfUPp9
	Ox0lcaubpVBWnBo9uMMR+kKeqsi6Y0s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-rArxXby4NWGDIW2Sp4j8Nw-1; Fri, 12 Jun 2026 09:26:49 -0400
X-MC-Unique: rArxXby4NWGDIW2Sp4j8Nw-1
X-Mimecast-MFC-AGG-ID: rArxXby4NWGDIW2Sp4j8Nw_1781270808
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45ef2bd566bso637596f8f.0
        for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 06:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270808; x=1781875608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqNpdonaMf4xUXPVpMxWOBKDwUXW9fTTnr7wXzHdCvI=;
        b=aGykZE88ioATU3IhQuuvsBd8S1CtEWjrkWbHornyWFGWd2ain6yK7tC+G89RU0wtaQ
         dFVn88j/QSpIiUupme0q1gH/04B7OuVfvE60egjftqFasHZcNt40WyYUHOfGiHsu+nyE
         2kFp2KGMbTeBMszfksvMhivx835lw5GpPMeUge9Vq2CYItpW4uE/eoM6DQMyp3hZfGCF
         8wPfvZao4v4Tljav0Qf3oZzxYo33bBphxBc5HiKV7Tva8woFaxbRB30+VgyPBrziU7WM
         rlanGGEChL3FxMCihkW3g2yIIio3waf087Qcal5OGNbThpkaiWWmFokAdpFCgoZ4sZWX
         ACPw==
X-Forwarded-Encrypted: i=1; AFNElJ/Tk5T+0V2CpZ1KNEW+unWgVoQ3B5tHQZIIjAdYt4diRdGpr3Pn/nMTFt7dYte2S2gKjCYyzrvM/6f1W9oXHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyyTaDoE5T+K4ajG2cxYblweZVk7YAPw4s/aa9zXNLK+JMLTaI0
	rhae4fyWNoBPgG7estk3nHkHJmyxE46PN8kck8SqHeX2euwtGsIC4ZY20kUAS4TmX2Jm0Fk0NEV
	Zw6Msewz2wEcX6vE4nWfiCRLvUYjiPhqcf+Ft7FQV+AmXb+rgNmjA5vHl8jdvGrFo1A1G
X-Gm-Gg: Acq92OEGNlfe6XPnjKnTb6mDnUdQOQ5ett8o1FCBF6opNPbhfy4AVn9V57YOhWSp79u
	tSpCXUk7NEs2tKESyE5hryI7u3iYGUJJWZZpx1kMUhdDQ96iovNY08gR8Tbpak7/G9VdzOEHxFS
	YuVQFdQegB+6o5RYFg965+eFl3xwK1TSHGnntPwKGYIVSYp4jrbHzoixiJufKxZxYW+jA7kSZX1
	EkobKbmIzvioDkbU4eELOM5L/yvGVKGlzkKy5jvOEs9CAa7f7GWTa3HKrKhohDzP30kaLZet/TA
	bgZX3tfIyvdEWbQsariwxdSc26M1KK6PHkJnNIOfvSjzVxjhcKsniGrcuB3YuhH7AyITdJI+zOc
	3QGBIqmg8jVPq7ApPb+UPMCujX9svWEMPPLkqQGUg/IJj9MgM4W/qsJGbSqI=
X-Received: by 2002:a5d:64e1:0:b0:45e:e1a4:c4c3 with SMTP id ffacd0b85a97d-4606da66f9amr4155967f8f.15.1781270808143;
        Fri, 12 Jun 2026 06:26:48 -0700 (PDT)
X-Received: by 2002:a5d:64e1:0:b0:45e:e1a4:c4c3 with SMTP id ffacd0b85a97d-4606da66f9amr4155918f8f.15.1781270807597;
        Fri, 12 Jun 2026 06:26:47 -0700 (PDT)
Received: from leonardi-redhat ([176.206.21.116])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26392esm6139232f8f.3.2026.06.12.06.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:26:46 -0700 (PDT)
Date: Fri, 12 Jun 2026 15:26:44 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, 
	bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	horms@kernel.org, edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH net-next v2] vsock/vmci: use sk_acceptq_is_full() helper
Message-ID: <aiwI8HR0l_mHyNSA@leonardi-redhat>
References: <20260612045842.122207-1-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260612045842.122207-1-rafdog35@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Bz5d-mmtxM-Ey3k4ecVZQdERlgbz_xWgYE1Aliu5RgQ_1781270808
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jun 12, 2026 at 04:58:42AM +0000, Raf Dickson wrote:
>Replace the open-coded backlog check with sk_acceptq_is_full().
>The helper uses > instead of >=, which is the correct comparison
>per commit 64a146513f8f ("[NET]: Revert incorrect accept queue
>backlog changes."), and adds READ_ONCE() for proper memory ordering.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Raf Dickson <rafdog35@gmail.com>

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

