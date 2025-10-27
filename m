Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DC62836A6
	for <virtualization@lists.linux.dev>; Mon, 27 Oct 2025 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761585937; cv=none; b=o+WbloTx7+kogxUwLUa0edMmZnHrittA1wqJ6TuPw2kV0qusvAJOH2USgJwl47+b8IeGVoxxQoVs5b/BytvHxBoi3Dn1GI40FRgCHsYf4XWotobry8bkQmV4eVDJ0aheWqS67qYCUuRg0LY6Qpngws1GZG6/90ZjmZGp9QPmdJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761585937; c=relaxed/simple;
	bh=HAqDcgGMjKKzyDltuxO03NIXefnszZjB7wdrs046Gys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjWQOrppTZTeYTVn3IFUCpE5gBHQf952YmY7+NDNJ/JHHxu6aVCz7A/DWuHFjmUjX3nDq6YSqohWz7TWid0c5ckSw+HL2CBVNQ7WzIh7Vn/+4vJjmOme7Wr16+Lh81GyWCRGpt8sQUu+Mzsiph2SR3fgrcpFB4aFi2spuw8hYI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4YYJgcv; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4YYJgcv"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-78488cdc20aso64151407b3.1
        for <virtualization@lists.linux.dev>; Mon, 27 Oct 2025 10:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761585934; x=1762190734; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rJ/ydtqR65wkobsTKCpney8zjIjx42CMb/k/gju9QlM=;
        b=m4YYJgcv//FdwiMQlI5gW+UEL6uv45jfLJePOyQQI2hvhgi5q7/rtA9XouYorTZXlu
         K51/FI9jrvMMP/SJCJT6KGCZkgsK975uElfzgzl85euQKZw9GAb0t2v0MHqhPgnQnpNO
         4q0EyCE4wFq1pL0qqjXQ8lb4YSk4WVATQY+zTf1wm4CxgOuBAyZKnfRlqOoxdTv5tcub
         eCyBhkO5cKi+w801KuonUMO27UQSmG6vy7k1rM6w4jp8aI7uNry/9SYjfl1yLt1iTudh
         aIAtzkNKvb87FcKUiRsSqP2EbnUNW6C4t2IYaVaLfZj3qFtaZIoYSfIKlrz7nDeYgN8Z
         h6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761585934; x=1762190734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJ/ydtqR65wkobsTKCpney8zjIjx42CMb/k/gju9QlM=;
        b=qIJIdxAxlyQ8ishuWfW236H+Ec0dZU00rFe/6yLMsMhsDKxv0fMJH9b3uAgnjWqwj2
         L6t2M1BD6dfZpbvYVurVqxrnUFh8w1fUWbNoZTJtVXo0+izr+HXWKHzaoS5elOwiXftG
         09bXi3T6KF90ERYVm3t/+LbfmWb2RgYipwaJaukqATSxVps9p/3JmDT/MM5vxu3JuNIs
         gSDMJoOyz6omh5ivq7+Dkq6aqXVyyg8DQ7Le4BA6JhvLKNrYDSO2ua49S+47OSpnR9LD
         xRXdvqdlcZKjaQatjsb3toXkwL03Fkkl4+fHRi07KGSTLIdPsm/wb0uB/55XT+IDMDMg
         +0Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWlvSRlvyPZ3rYEuI40gFtx7Ly027s/8aRl5+Pg9BgZIDqS4up1mOGFEyCgofhDblhL3IxH3E+pl+olbPHB5g==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywf7fNe9PBl8zyY/yX9vKnfHYmGSKl6iybGJcxtV9VBJY4HVLVC
	mlmyq5aXsQ/IWc8oSKszNVGdn1Jmv2C/UtNQr6YaJPkj8wgGsUHd1xDY
X-Gm-Gg: ASbGncvv4hQAAwriquOQ8U6g+ZwhOdDyUvgsMJoRfJ+sVRcM7C4WiRrdL2f+uYqzmRl
	4w+I7Xlris78DZRlXm46cHo+5Y+rSuqZO+QlC9wVgieQaCZ4FZlK7VtmUpP2iIupMljyTVTGFep
	57ndu4YY9mmy7NtZL7funpOxhM9ZznoFn/ipfzHPK2+EGzbPdFcW55lMbdmWzwiEKGHkoBO6Twz
	jQ71c2HjuKOue1ikmuuDR7yNJsm9w6m9km+D3WYk4YzmcmNB28PdD9bT4UP2soZTQI6p4tUSVDN
	E6LEGVDdIL6m8Z/g6VFiOSykdtWp304jMtK+uMNOUNIXz+EK572YXd9RN+mccdQ07sxQKA5IQj5
	hJnl+5aJ3jCEeVAr3PUu6jr61XDwpjnOEDgLvM6RJ47lLk+YwTkQJYkv3U9ReNQcu5XyNh/Qy7N
	35DH0nvCjiAe9y98f2a5SFmXFEKMRue1C/1iA=
X-Google-Smtp-Source: AGHT+IGHTF9vBtn+seygObOHlL96iKi+OVb+7MtjlE9jx6wEi+MY/OkA96sVfPPxkYnPfsaXOqXkAw==
X-Received: by 2002:a05:690c:338b:b0:723:bf47:96f8 with SMTP id 00721157ae682-786183ab057mr5505517b3.53.1761585934504;
        Mon, 27 Oct 2025 10:25:34 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:9::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed1423f5sm20564397b3.5.2025.10.27.10.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 10:25:33 -0700 (PDT)
Date: Mon, 27 Oct 2025 10:25:29 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 00/14] vsock: add namespace support to
 vhost-vsock
Message-ID: <aP+rCQih4YMm1OAp@devvm11784.nha0.facebook.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <k4tqyp7wlnbmcntmvzp7oawacfofnnzdi5cjwlj6djxtlo6xai@44ivtv4kgjz2>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <k4tqyp7wlnbmcntmvzp7oawacfofnnzdi5cjwlj6djxtlo6xai@44ivtv4kgjz2>

On Mon, Oct 27, 2025 at 02:28:31PM +0100, Stefano Garzarella wrote:
> Hi Bobby,
> 
> > 
> > Changes in v8:
> > - Break generic cleanup/refactoring patches into standalone series,
> >  remove those from this series
> 
> Yep, thanks for splitting the series. I'll review it ASAP since it's a
> dependency.
> 
> I was at GSoC mentor summit last week, so I'm bit busy with the backlog, but
> I'll do my best to review both series this week.
> 
> Thanks,
> Stefano
> 

Thanks for the heads up!

Best,
Bobby
