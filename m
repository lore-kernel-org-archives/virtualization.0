Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33AE222590
	for <virtualization@lists.linux.dev>; Mon,  6 Oct 2025 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759746564; cv=none; b=XgC3Vbn+fEhphkbvvtdPewq6wewtafxHBn1mxevjM1gTWAjY5SYXRYU6nUWjwBo3lq3osNgJ2r3CoDlYvpIn0menCAu33IOqedm/cJ9O7I6RoTbOffRZLSx2ExNzUpwTXX/+P89GHHvMDs2utvzcs/WeafqibfQcy7KJfzVU7nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759746564; c=relaxed/simple;
	bh=X/er2LoDkvUlCWyDSAEiyjLpPRF0VnQhqBtnxbeNMI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MSFZu7vSwcz/PEqzkt5fXVctKRsa4yakQgwVGAPubiqMn1BXayI7GiBd2KoIJfHWgPl7eOM0WGMlcJ6EYxfOhQTTZfKDnBzRlDpzjVr8lrqBxv0Mz8DYSzIEkttqjHhmGzs49N3JnnUdRoSyAylYC0IFnxEjgZK2Nlyg1Vg3wBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gL1Aj7VL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gL1Aj7VL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759746561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4x4Ic6friOxCIiqjgkFZ1nAitS5y19AHJ4CH0PQv8Vk=;
	b=gL1Aj7VLbvaIJxVoEIvzzMvXo2hJVFoLBrs0iomJliWAhENc9wR50kA2E5B6MSyTgMTGu6
	GKGRNJB8fgeWacc7CxCSFGTxQSv4JE/SqsLJJvbduCFAtscXfI3Nispez3xp+dgi8LFbWS
	sk0LGviqF+RHkuRb8mm6c1jgujWYuAY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-AUE9mvftMhy70JgblYncIA-1; Mon, 06 Oct 2025 06:29:20 -0400
X-MC-Unique: AUE9mvftMhy70JgblYncIA-1
X-Mimecast-MFC-AGG-ID: AUE9mvftMhy70JgblYncIA_1759746559
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3f3787688b0so2585158f8f.0
        for <virtualization@lists.linux.dev>; Mon, 06 Oct 2025 03:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759746559; x=1760351359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4x4Ic6friOxCIiqjgkFZ1nAitS5y19AHJ4CH0PQv8Vk=;
        b=twEiKfjX6FArhGETViiKFOQiK9Swg2MFupnbUkK7RjBP07jRnLHzoIxrYlq59Qamnc
         T/tsChNlbAZOYon3whWZgLu+VLuTQ3/9/g6dzM13Xo6HZg6ZJPb0mK5+7LYRGTCibMH3
         ffU57i4HKGvvLpo6tFX+kh8JExHR8AT7ndLXaDBxVvs1ZsRCmsaqhgCJsNGhRSoynsg3
         PZC0o+eM0oV6RkL3B7JC/1YTa4uK1q3rouA0cMn11wCEXuuo+Gg3Apvv3bqhsO7Hf3Nc
         8L/6lX70+7B58CMyjEeKIWjrteMRn/Bs1rm0R93CgLMFNSHDXH4hq6PldyM8PXRSLgCS
         A76A==
X-Forwarded-Encrypted: i=1; AJvYcCWvH7JKup2mN7hjwgaccU7asQd+KJRCP7PUDwhAmkXs/Zwymg7FOj++xtR9msRsdGDRgQ2+ZdaPWQab7tse0g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzoRzFkFQJyEp/GC9OV0h5akboBzmKSWEeFBuwnbtECjDtJZtZU
	rDs4Ej1HmnbmRGW3RYsV14bjRkR7yqU0+3ZoQdSzcDxs9gIc7sL9jKWT33/KxlePPSUgv4qtPOJ
	Cyf0pe99eO/almCSDLhenkI+zY+ex1DC66UTVZ5FFjSEnlaQUuxKVkRnXSuzAazf2yi49
X-Gm-Gg: ASbGncsShQ0UTb64s/xxRe4cDhd/vdNoQ1PLQxpMepl+kdA5NkxEtSbFTWQQwMo7Pk6
	skBAYrXtfnvMP7xs7w0J63T3Pog6rSs73czfgFWKi0nNlySGFRtizzDnwtDIsUL+pLr6EAs3U3g
	wyDlDHJ5XG6+eM56Bb/TdJbwAG3iwik/OEx2ZEk2W0VHqHulu0Iac1ZRGwVHWxlcrM5lLvx8kks
	rKfIvDr2mDaDi9TxHwM/ictWK1Fs1sJ3uTC5aas4X8axs81pifCNHMdaZGIG22DDgSafbEwgVz4
	jmmSsWgl3T6MdtzITPrVaIZF/qG5UY53Y3qq/ys=
X-Received: by 2002:a05:6000:310c:b0:425:7f10:e79b with SMTP id ffacd0b85a97d-4257f10eaa1mr1066564f8f.44.1759746559156;
        Mon, 06 Oct 2025 03:29:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4tbvKRnrBj8QVt2nG5Eh7SlaXI+5atXG7MzqxwfWdVdeV+C+QICcLFfV8wDO9Tk24H1QpXg==
X-Received: by 2002:a05:6000:310c:b0:425:7f10:e79b with SMTP id ffacd0b85a97d-4257f10eaa1mr1066538f8f.44.1759746558652;
        Mon, 06 Oct 2025 03:29:18 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6b5csm20308787f8f.5.2025.10.06.03.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 03:29:18 -0700 (PDT)
Date: Mon, 6 Oct 2025 06:29:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: stable@vger.kernel.org,
	Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
	Daniel Verkamp <dverkamp@chromium.org>, Amit Shah <amit@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux.dev
Subject: Re: Backport request for commit 5326ab737a47 ("virtio_console: fix
 order of fields cols and rows")
Message-ID: <20251006062851-mutt-send-email-mst@kernel.org>
References: <f839e710b4ede119aa9ad1f2a8e8bcc7fcc00233.camel@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <f839e710b4ede119aa9ad1f2a8e8bcc7fcc00233.camel@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Rwe6SdPzYmMcZN-kFP4Qa_YPfhwl_2r5BAgvAmRJCbM_1759746559
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 18, 2025 at 01:13:24AM +0200, Filip Hejsek wrote:
> Hi,
> 
> I would like to request backporting 5326ab737a47 ("virtio_console: fix
> order of fields cols and rows") to all LTS kernels.
> 
> I'm working on QEMU patches that add virtio console size support.
> Without the fix, rows and columns will be swapped.
> 
> As far as I know, there are no device implementations that use the
> wrong order and would by broken by the fix.
> 
> Note: A previous version [1] of the patch contained "Cc: stable" and
> "Fixes:" tags, but they seem to have been accidentally left out from
> the final version.
> 
> [1]: https://lore.kernel.org/all/20250320172654.624657-1-maxbr@linux.ibm.com/
> 
> Thanks,
> Filip Hejsek

But I thought we are reverting it?

-- 
MST

