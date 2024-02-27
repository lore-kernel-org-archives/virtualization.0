Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D24A14A4F0
	for <virtualization@lists.linux.dev>; Tue, 27 Feb 2024 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046504; cv=none; b=hLu4E4rCPhfAYKtzU31DbJ9q1CyPpyBeuPzOJyDZmeoflPtxnw1+xBs0xA9ezdFBqjkOnUDm/HmhG8nFGoskXJ68xxXQme1KairGa2HbWbzJhsr9EsEJH50OuVr9Girt6sIKLJrbq0pwPUkKd/Alw55pu3nbH32g+4GysY+/070=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046504; c=relaxed/simple;
	bh=kVffUr20Izax4YF9+0wwB28rgK6Y0uZGPUDJDiZR4Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHr1yZsIAUtyFUrG4NIc8/cshxyKJ13RIyE9j59LvvpgdAVB0XiuXkqlaG7h1zzHfqUL0FbkIJmgsYC74dza3/QIBsX8H4CN6z0/yhpRfm59D3RpjSxI/+q+9oxSSVnwxB4TxvwsTeAg8GMrUf42jWR+HYIs5+bedi53TmarS3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=2f0u34yh; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="2f0u34yh"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-512bc0e8ce1so4556429e87.0
        for <virtualization@lists.linux.dev>; Tue, 27 Feb 2024 07:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709046501; x=1709651301; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QgKE4Y5Fe/K9QqRyLFbe9JH+uzN4iuJkkyLvvTToOHA=;
        b=2f0u34yhoqpav+O8mRoK0ZIg+mH1B2XHE6wMeij8a/SPdbTju/8u9HhKkFGqfnWMdx
         SDkBbYc4GQTG0Nbs+EzQwtLbUYxdQrBUfYkHCcwfci+OCUOdSBR1WlrkLEt5egfmxXOw
         KSvrb3oQAZSAo0RtDWvCO9knzDyD+KtY2IuMWp9eH3HqlcQgch3os7oTBY5Z1+FIBZQT
         ICCeyf8TydTRZP58b5OMtUNsEAkRU5Ykj4GZR0puDBOENBrZD1zmRmr96zZMSKbKxr9n
         hPEEqnxiDkokxtkhUcJ0B/eUCa8vDs0j6a+hpGSTsBB/FlGz8yEQfEz81I4zMG6cV8PS
         ssUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046501; x=1709651301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgKE4Y5Fe/K9QqRyLFbe9JH+uzN4iuJkkyLvvTToOHA=;
        b=SrovRof7iPPj0e3jto8kn4MsRkdcLTXVXlC0ancntBY35+c+VztwJfk7eTGjTc2lp9
         wPwRCICByJ/giKG1DiiTUv5xBiWQjlmyGP9l0ygolYgzjSUo8I3HMf2csgb59oATVExw
         6lWYjjtUzurG/fJHzkFyXAsgG+2OXEPW8YZ3pmSNqqS9arpDJ2VSmXtndItUXIrq1LBG
         34eRPGGG+wmiUQQ0N/m2bcYkEtz1JLas4kEgxHNJ8NUEyHAxttxfy3cTpnTVlC+RbLIj
         50h04dhUGhE+Q644inoDoZDfGcKEbivAuK0z11LEnfb4V8HhzigNBdGqL+c/7JBq3Jjy
         n0jA==
X-Forwarded-Encrypted: i=1; AJvYcCXPjcHXdrBSRQ6mdPnwa2ATBALAwhdJFfA1p+/kEj37KbOIZOXm/jGbYBKnY5lW/oTZlKq0t/p64bokgoI7/rfBvjKA2Wi/y09edc8U2xU=
X-Gm-Message-State: AOJu0YxHWnH4b3b2DQ8purdhGsyrOIothAbp+v7VbkwkY3oBqYgk1kwd
	Y2b4QLGjPaC2RFJpDk/llxzxxxhcDdGHr5FWk/JXcbcatSRZUGRFB2mrEFsnKqI=
X-Google-Smtp-Source: AGHT+IGTERjeJ4l2yM/AZTnVBJihHHv2kACSJ6apoYoy24DobZxv5fIlFBhKgDxUgSkMlOVD0RJNmA==
X-Received: by 2002:a19:5e19:0:b0:512:b27c:18b5 with SMTP id s25-20020a195e19000000b00512b27c18b5mr6445800lfb.30.1709046501439;
        Tue, 27 Feb 2024 07:08:21 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ba16-20020a0560001c1000b0033dc7706be3sm9409625wrb.79.2024.02.27.07.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:08:20 -0800 (PST)
Date: Tue, 27 Feb 2024 16:08:18 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v3 6/6] virtio_net: rename stat tx_timeout to
 timeout
Message-ID: <Zd364r85MU0DDVNB@nanopsycho>
References: <20240227080303.63894-1-xuanzhuo@linux.alibaba.com>
 <20240227080303.63894-7-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227080303.63894-7-xuanzhuo@linux.alibaba.com>

Tue, Feb 27, 2024 at 09:03:03AM CET, xuanzhuo@linux.alibaba.com wrote:
>Now, we have this:
>
>    tx_queue_0_tx_timeouts
>
>This is used to record the tx schedule timeout.
>But this has two "tx". I think the below is enough.
>
>    tx_queue_0_timeouts
>
>So I rename this field.
>
>Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
