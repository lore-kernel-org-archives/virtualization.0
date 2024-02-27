Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8271332A7
	for <virtualization@lists.linux.dev>; Tue, 27 Feb 2024 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040223; cv=none; b=faHk0xY0ZsMupotqXP27AoAcBIuIrrWuhIR6OjhpFR8xzct4tUsgQhFbvl8esO3OsIro94oi18npckPmJpK+ZQXdOpT4jm8o5BRliFUs5OSXH+np74E8qJNKKNWhkrBk1tkqNf90j9r1oOjviYLbREdVNt+ukTZ1S2JJDY+Z1Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040223; c=relaxed/simple;
	bh=UIELqrAjJbz7rdlwdI1d6a/VDVzleOGjv9AG0sxZGlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlD8YZ3yPreAnAUoKp5S3HMzxkExS1l8Un36hiKgaqBMaqLssevd67ptF2zErR96rj9eHns7HlywI93gkpp8WBJwdhyObM6huU5YBtPcQQGa2t1+7U6yUh2HZOSoAmPT3BvY1zfJ1AOirJt9MaO+7QhNpQ7/o83ESfX2ENzGrPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=eaeCYiin; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="eaeCYiin"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-412a9c1921dso9312635e9.0
        for <virtualization@lists.linux.dev>; Tue, 27 Feb 2024 05:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709040220; x=1709645020; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UIELqrAjJbz7rdlwdI1d6a/VDVzleOGjv9AG0sxZGlE=;
        b=eaeCYiins9yN4pD8EOJDnCwYX4LVAfzxCAST0gE8ji2Lit/ui8biIBYuA3trSHJN7B
         yBe5oQwxgixqIlP/rbjLB82pvWJptnmu7v2RJ3iZbWrsaOCkGRk1gUxAuaSWQIrzsv61
         e6jd5aYWphargjFXrf/3xMLik3Dt4Tm1lzd4OTNPcasfGbFO7Z+RI9tXINv0d9+oNPsm
         ptfrgifsYjVLmQGzHwitzWkC7rwy9Kp/gvPTgh2gsvLMgsTtLCFvLR1XDxsHmjHvcDJk
         FC2ZT7jfbRyALj5vX634ViedpOQ5FRL9S2XdyZ3bckCPm6h80bKl0/GWmU2yKwoiHEXL
         bXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709040220; x=1709645020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIELqrAjJbz7rdlwdI1d6a/VDVzleOGjv9AG0sxZGlE=;
        b=TRqoqCVpqKY6cyuny3LaDWJro+BKh0XZNU5hhuc7AruGsWjAdCSp2jFNVpyk3v1LcJ
         2j/W6y+eOulgFD7wrQf90dETY7FxkchZyqqR8jwo3NF8GYudUAMNASNpUAt+GV6OGHeQ
         /p/VRESQJeryx6kq9w7/xT1vOQNJ+lVUCppKN/BvG3A4MzOtwN3yQIw7B50qvPIzEJXB
         tvhhaIUD06QBYDTOvpkELDw7hufWV68Y8RfUCVU73uixYTf8cd7fBk5kfVQxe+ehJ7X/
         qZhxeBXEZ/2VSUb3PQMKP/RkLEGDntWGSndDixXr97l3ixLiWineY9XSXEr5c4E5kGkP
         nwTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXa/kcv9HJ6E1ckBLm24pZkvbqMhocYQTNus59ZEEij5YdTjup2s4e95ElFYfwamN1DSLBu5+aqM10ttKABRgpSiR+On94RT4hGqWra3x8=
X-Gm-Message-State: AOJu0YyaNAz2r5QKaQp+47wOhg05FmHSOPOjlbt9OxdjiZHDpW16nAOq
	R+Ft7yPtAc8sBkVXzno+VXul9aGBDY70N/8fYnj+ALaUEw8q9cH8lF7wTVHK22Y=
X-Google-Smtp-Source: AGHT+IF4MMY+biBEI84lgrZhaf8tscNysmDzD+JZeZxxS+RTEPp8RpJw1pxkiXUE91IEmAcNraq5bg==
X-Received: by 2002:a05:600c:4f4a:b0:412:9d6c:eb28 with SMTP id m10-20020a05600c4f4a00b004129d6ceb28mr6558234wmq.20.1709040220156;
        Tue, 27 Feb 2024 05:23:40 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id fc10-20020a05600c524a00b00411e3cc0e0asm11363841wmb.44.2024.02.27.05.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 05:23:39 -0800 (PST)
Date: Tue, 27 Feb 2024 14:23:36 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v3 2/6] virtio_net: virtnet_send_command
 supports command-specific-result
Message-ID: <Zd3iWJut1tMHRIdU@nanopsycho>
References: <20240227080303.63894-1-xuanzhuo@linux.alibaba.com>
 <20240227080303.63894-3-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227080303.63894-3-xuanzhuo@linux.alibaba.com>

The patch subject should clearly indicate what should be changed,
something like this:

Subject: virtio_net: add support for command-specific-result in virtnet_send_command()

Tue, Feb 27, 2024 at 09:02:59AM CET, xuanzhuo@linux.alibaba.com wrote:
>As the spec https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
>
>The virtnet cvq supports to get result from the device.
>This commit implement this.

Again, be imperative to the codebase clearly saying what it should
change. Much easier to read and understand the patch description then.

The code looks ok.

