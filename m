Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6FA1BEF79
	for <virtualization@lists.linux-foundation.org>; Wed, 22 Jan 2025 07:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737530301; cv=none; b=K65v8uwD9TzrjitoHflxrB/UgaewVW6Stpyc2j/zZnIm90/t343ls5jF8oOLKV8Njkggsumt2BzgCTA3EZDlq1bZvn61Lf5ufMSH8S+B9TTGLUP6PaNl1zM5LIRV+PQfJX5cN82qPMFiQzq5TF27ngePUP2LuxgL6QSPuuGp2Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737530301; c=relaxed/simple;
	bh=YEGflwjghorvVYU5vOk121ZOciaycJ1sBGE8jPcq2T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=coZz+Aw4jwCOwKMPfSvCBeHkHP2J0Dq90SUNiLyXrZ6BC8W3dRxsBVcJpKMLgzYc0aw4Os4BnZZuu5sShzuhZVOKotwRkd/nCKl/qgArVCNrXcS6l5xfGlzhTP6J5P/hd/YpNuwX6nfOCgNkfipWZ/jwnjUFrNC/MCdFlu5Ivx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gf1pzwl4; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gf1pzwl4"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8056861087
	for <virtualization@lists.linux-foundation.org>; Wed, 22 Jan 2025 07:18:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O5cm5roz4-gE for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jan 2025 07:18:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B6E0060A81
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B6E0060A81
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gf1pzwl4
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B6E0060A81
	for <virtualization@lists.linux-foundation.org>; Wed, 22 Jan 2025 07:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737530296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YEGflwjghorvVYU5vOk121ZOciaycJ1sBGE8jPcq2T4=;
	b=Gf1pzwl4emu+vlXm6OU8dt+g+b2Uki7CkVHrM7i/a+U5MPWDHIIpDwdyQWzChIkw6KGhG8
	Rw5KJ4Dr4u3bTAERaWhBK89tfi3MwisZI4uDdsEhDuZefIEIMI2FZLqoHoCy9WCWGAC0rd
	qFAYcWiioWnFUeym+S1N/Maltq4UTO8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-QuzzOqW3MX-Iq8ikFAPqHw-1; Wed, 22 Jan 2025 02:18:14 -0500
X-MC-Unique: QuzzOqW3MX-Iq8ikFAPqHw-1
X-Mimecast-MFC-AGG-ID: QuzzOqW3MX-Iq8ikFAPqHw
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5d3f3d6a999so8732446a12.0
        for <virtualization@lists.linux-foundation.org>; Tue, 21 Jan 2025 23:18:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737530293; x=1738135093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEGflwjghorvVYU5vOk121ZOciaycJ1sBGE8jPcq2T4=;
        b=O41SXVPSV9yla/WHi1MBSu16/23HP0vbEGo01Kz+LTq0GzKjFTQQNXfjWWk53ZxUPc
         HnIphQmSn3AokXsi2C8q+Vn3iT2JPWqtdVJIXGLoTvUcgnezmH8vaW76I0m0TlxHKzUU
         MdXzfd65wbZbXiFmobdOPHjk91HalXAj7saa6H9CjgtNlVbIK9QGgtRPMlCPuXJVL4U2
         byjrdXs9d22bEboWfcZ+0Liq0EsEYJt/riJIcTE4tptt5nCgGOIbd4myU3AhrVtKh3bD
         oPnz6JWhPvXj/7EhFURnr/r2ZSAnjYz3v6bGZhQS+VjgHYe9XquKaVQrKL/CLGuAwm5D
         lr2A==
X-Forwarded-Encrypted: i=1; AJvYcCVZBUnWLKcHSHxj1dtLI8+2G2g79OJklU/DUIkgBk9bkqNJYd2PoHz0Fc9qSa3IMdjXnIXtEQLL21L46i6PKw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yx9ABWUhwEkOSBqLNCD+4OLRYhOyifRsttR9REvllbchte4fRAX
	OKVy0Mgahajb9Lp7/OaRo1aVXYeEmyjaMEmaPXAGdCzLJX6G2hdXRAPv8C2+e6P7gfFEfUEMZr3
	p1jrxcr8N45dyMz7LRRVuVCMIFLD5RdLMhCc2gHZWDG0EKN8YQXEypQoch+JwYo1DjPz32/U75H
	eMdmM=
X-Gm-Gg: ASbGncup+dWrJ0Q9Mus7eUkGAxDhthS4/Qy+AuAueUDfz4p/XIT6hRwOYxpqQ7SUt5J
	rY0evX5gD694f1Q+Rq5r0XpjsjMg3BgsgIudkYPNn4/NaIYCFbAv3exIQALG24zJATvP3CY8gZh
	pMuhNZj5McTsBnGFzIAWzQ8uk/M224NYoXT5rGslAo4S9sYStSCIkaPk/MqHq1VBvtsS/MfgOzx
	h9H3XBcikjRohnL7BFKrcAYBpVP3xxlRSVL+h7HqUAHhEt6L5ep7Ek8X5+zCYYYOw==
X-Received: by 2002:a05:6402:350b:b0:5d9:f362:1678 with SMTP id 4fb4d7f45d1cf-5db7d827306mr18359486a12.23.1737530293306;
        Tue, 21 Jan 2025 23:18:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyqRjQyumBjYcUQXfl81qk1Ssy2hqd/dBbWDlwe25OUNiHUGvNrn7xmiKDctNp/BPDMN7QhA==
X-Received: by 2002:a05:6402:350b:b0:5d9:f362:1678 with SMTP id 4fb4d7f45d1cf-5db7d827306mr18359479a12.23.1737530292977;
        Tue, 21 Jan 2025 23:18:12 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:443:5f4e:8fd1:d298:3d75:448e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73642509sm8016880a12.10.2025.01.21.23.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 23:18:12 -0800 (PST)
Date: Wed, 22 Jan 2025 02:18:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, michael.christie@oracle.com,
	sgarzare@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 7/8] vhost: Add new UAPI to support change to task mode
Message-ID: <20250122021720-mutt-send-email-mst@kernel.org>
References: <20241210164456.925060-1-lulu@redhat.com>
 <20241210164456.925060-8-lulu@redhat.com>
 <20250108071107-mutt-send-email-mst@kernel.org>
 <CACLfguUffb-kTZgUoBnJAJxhpxh-xq8xBM-Hv5CZeWzDoha6tA@mail.gmail.com>
 <CACGkMEsDjFgyFFxz9Gdi2dFbk+JHP6cr7e1xGnLYuPBce-aLHw@mail.gmail.com>
 <CACLfguVoJP-yruzy-6UVb2SBD_hv-4aF-kBU0oLAooi8X56E7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACLfguVoJP-yruzy-6UVb2SBD_hv-4aF-kBU0oLAooi8X56E7Q@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cttyvwx4rOZnNC3gVi6heI72R8peVmpmcmlYXW8nteE_1737530293
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 22, 2025 at 10:07:19AM +0800, Cindy Lu wrote:
> Ping for review, Hi MST and Jason, do you have any comments on this?
> Thanks
> Cindy


I see there are unaddressed comments by Jason and Stefano.

