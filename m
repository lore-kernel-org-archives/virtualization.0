Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A77A15278D
	for <virtualization@lists.linux.dev>; Thu,  9 May 2024 13:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715261524; cv=none; b=oZ9Ak+AqHwaJ8uMVOrVQATnlbSeGMLmsVp0ypGWqmLnI9GzjTR5kS5nkkp+uKf+5xnPuXHqRfhwFoum9EEAMsPpGWsUo2fdx1IAtCtAI/7Rthi7RGPKwTxthCDt6wFCkpiXosFS4BnxG0gCYvNAjzR19N+kTNoMYjzCV8T9IAMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715261524; c=relaxed/simple;
	bh=UGtd25PtHEIWxCFYY/R1k/CiR1C5wx6tTMdVM+SZH6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNpV+GbT7zS4cgK4W50PiJOqSzWbBu1PLwh2D15k/VCuvegEYtKs/qG0BF1cCv8iWsU2PKpcjD2cS1oniDNy3kC+p/Ar5CPKLJzklthGK7i5Npsv9uChhsM7gHrzKHQefaoV9r4iXP0DHU9WgpyiQerD2AxMy0Kqx/a8RPy0Ho8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=LsBHbJeJ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="LsBHbJeJ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41fc2f7fbb5so4639625e9.1
        for <virtualization@lists.linux.dev>; Thu, 09 May 2024 06:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715261521; x=1715866321; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=70d8HmBhBsVnOVGM9dBLiSdBfBSq7HfimZSV/5XPOsY=;
        b=LsBHbJeJIDd1Szm2a4fMcf5ANA3YdUXuyMXi1l5Z4u/YG5FKle4MmqPF0Rjzo+o/rV
         S+Hme6KTJzbC+OyVJ2oetQ1foSuuohsRrhFw+L9rcnAJ5myX57X4zrTdxjjiYi8tXwf2
         gA2lf/6W7mfVIRt5DRMuYoHWZilwoY7mMi2zNkCwkexN8I+hViZ8eNht5vqvJoO79nDD
         XK+JZlCeaQg5hu3tUiExRDK3yVFG1LBQZyClhjWcI3qC0TveAa7eWDSsl0BE7tnyW2Rj
         g1oRcwD9wzpBE3Ih4BLtWOab1hTDgPQIDkYufG5J3vjsYZbj0ellYIbmUd13XYHJ1vmk
         1mQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715261521; x=1715866321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70d8HmBhBsVnOVGM9dBLiSdBfBSq7HfimZSV/5XPOsY=;
        b=vzSUm6a3k4TEICgBG7yFQ+hfABNpH1p/NSVY8SWU1wka4Tx4/ehQtNawq2dONUjsuk
         re/JO/hkkx2HK4PuiDPS+EFnKU6+bMW6KjJae8mOkjJPdw/l/X9V35/0adsTk9UOM8Sz
         egQYf8DithxHpLGApMO9Oyu19o6Y4E4q53tMnZKnHSaoQlGcEvQE3WYsPfNkwWy0cUsp
         3IaM9W9166091uQAE5+a4jlx0xiyWSlLrWYF0qtv1UnR3s0tj1fR/y5idchRgFWRVy3b
         G7/W+W937glE7e0kMjpMU7J9QsMzqtkQX1x2YQYYJ07ZbB/3rz9FFZMF0hfWBVvUc/DV
         bzRw==
X-Forwarded-Encrypted: i=1; AJvYcCX64SqXF/JNvhTf8WjiVTTlCvmcY67ULhNehEHvINoyutcaIrhGtTVgLyTfsu610b61TDUoy35XFqbmEoJdz7tDqV5iapujAsth0zSqwZ4=
X-Gm-Message-State: AOJu0YxJpKzPq7/iT234H+1zdCYhYntF0S8GBXNCiqTg5G5XILBZBJ1G
	oH3NSRXryD7qIM+tPVNwDvqg+x00XEI9RZjzLQPdKD+Q+AYGgwgQ5LOkwHLctbY=
X-Google-Smtp-Source: AGHT+IF5XnRKnh+zxxiQWj046SakVClKzAm5n/VwxuaCxO5rFmV2zyz0T1mPR2yDxRk1wD0FiW+FfQ==
X-Received: by 2002:a05:600c:1d05:b0:418:d3f4:677b with SMTP id 5b1f17b1804b1-41fbce7ddc9mr23119235e9.17.1715261520556;
        Thu, 09 May 2024 06:32:00 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce9426sm26020195e9.25.2024.05.09.06.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 06:32:00 -0700 (PDT)
Date: Thu, 9 May 2024 15:31:56 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <ZjzQTFq5lJIoeSqM@nanopsycho.orion>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <20240509084050-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509084050-mutt-send-email-mst@kernel.org>

Thu, May 09, 2024 at 02:41:39PM CEST, mst@redhat.com wrote:
>On Thu, May 09, 2024 at 01:46:15PM +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Add support for Byte Queue Limits (BQL).
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>
>Can we get more detail on the benefits you observe etc?
>Thanks!

More info about the BQL in general is here:
https://lwn.net/Articles/469652/

