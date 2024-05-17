Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCCF179AB
	for <virtualization@lists.linux.dev>; Fri, 17 May 2024 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715932350; cv=none; b=QzICMRQwuEPSrLGYXg3MXqpelGk3qmt2d4cp8XgI16i32Q83NowmaMOJNlAgJbA25G2TLCtHV6POIsjmmdc9c8LJqnLNXYKCQhuL4av/5siYA3Oy3PhFILMPNfRu4qhozTTYP0ZhnXj+BntSt24/7aMoG04gwdV3RSeTUUgtYq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715932350; c=relaxed/simple;
	bh=/v6sjHG+0+ZKEPpS9tqIzcUKC/LKTqQCiFB7jNWcUX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meMM2Qst15ZDs7ZjyHLtG2zXAEEUhh0FoQiAKb1XW0fb6ttmrU4hUC99mjTL8OcOl9kd+392KRyDYFQWrjyOKFwZQt16fiKgVfdQkW2xKTVFUBsfz3SkGRQAcrbFTigqrM7PhymmWf0VVxO/0250rHv6I8+owp+lFdtMaKsM40U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=lG40rnrv; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="lG40rnrv"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-352129e3c8eso873635f8f.2
        for <virtualization@lists.linux.dev>; Fri, 17 May 2024 00:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715932347; x=1716537147; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PFTsZHpcHAIaSjKi6HhILgkEVSJRgmc6M+HW7iQenNE=;
        b=lG40rnrvWk8tifw2dNfMcy/BcrchDQ/4yz5zm1/i7b/8KqT5xqp2fe7Z7WgYJRNgel
         GDVPYJ0WYpx97RITzt7VwomqMYDiefesM387BBptQkhadr5ax4A4qr274BUytwTW2WKu
         hlZjW9guNwnH3kG94ARe52iIU3JNX7JEjiF08QpW49LTQN17s9tb4f8truuKC8KY3VzO
         SK1ICEtG7BdlL4hlp4PD/2xiBabxV76gT7C6D2uI9EcMYnxpjsXluTErIPb+mVnf8B9F
         VEpdfwP++Knl3uQTn/41IGx7IFAn7oTKM1dTL0KpL8oe2tOUhkgJIk8xwShrGIXYS8x7
         PL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715932347; x=1716537147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFTsZHpcHAIaSjKi6HhILgkEVSJRgmc6M+HW7iQenNE=;
        b=JdVFCYciEGSqNtpPUqdHh9AIYNDuboCLsWmQscO3X4vzLJ8ouAyOafjbpFZPHx5ZL9
         fQz6hd4GTPgfR311GuXq+DzPp68k1F79ZXqBr0RUs3nBAJ+TyHym12dCUbPDZb8V8F/U
         Yso0NWM3Nw85bXdB7Vo2PkJWpJX/uPgY/dZNzKLpaIB4jMO05ryZd8SbSA/H973YMeUx
         8X+V7sP5IPvdnhR8k4j3g8vHt5Fdv5VlPTUEOTS5aEq4N6uStUiltN8UU84BMsjdeCIC
         oSwTwEsnixWa0zduRJpgdoQ9dNzIwbjro70XFvk0uEHwW6Y619606upJxgv76DRWktpy
         +Xeg==
X-Forwarded-Encrypted: i=1; AJvYcCXAQftlfcPzQj/0terXCPOwWTYBCeInhQexIEu+941E4JZNXmP7A+oua2UQYy2icr25I+JJdJBQACzJvSYuIa0X5PDFfr2yvYBHhGtXe6M=
X-Gm-Message-State: AOJu0Yy/4YxiSwYEEF3UD332trVJRExs7Z3eMnqJOUn3UZ5N8y3VhLVD
	VniVc7UBfmecelyG4P5gLJ1BjQ0B59TuLhDuHKmX7NAps86RIrNUh8BaijmTY40=
X-Google-Smtp-Source: AGHT+IGuekRx9JCbSJ8aPjEkgDSPx0b09Ah96HfjfNrA2JQkcpnO0zi7rNwoFiUHiHt0SWJgb+QhzA==
X-Received: by 2002:a5d:618d:0:b0:34c:9393:4c29 with SMTP id ffacd0b85a97d-3504a737a07mr16118061f8f.21.1715932346608;
        Fri, 17 May 2024 00:52:26 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-351d3bdad9bsm4337495f8f.46.2024.05.17.00.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 00:52:26 -0700 (PDT)
Date: Fri, 17 May 2024 09:52:22 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <ZkcMthuRwhMsWJgn@nanopsycho.orion>
References: <20240510072431-mutt-send-email-mst@kernel.org>
 <ZkRlcBU0Nb3O-Kg1@nanopsycho.orion>
 <20240515041909-mutt-send-email-mst@kernel.org>
 <ZkSKo1npMxCVuLfT@nanopsycho.orion>
 <ZkSwbaA74z1QwwJz@nanopsycho.orion>
 <CACGkMEsLfLLwjfHu5MT8Ug0_tS_LASvw-raiXiYx_WHJzMcWbg@mail.gmail.com>
 <ZkXmAjlm-A50m4dx@nanopsycho.orion>
 <20240516083100-mutt-send-email-mst@kernel.org>
 <ZkYlYLFthXVmHOaQ@nanopsycho.orion>
 <20240516150101-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516150101-mutt-send-email-mst@kernel.org>

Thu, May 16, 2024 at 09:04:41PM CEST, mst@redhat.com wrote:
>On Thu, May 16, 2024 at 05:25:20PM +0200, Jiri Pirko wrote:
>> 
>> >I'd expect a regression if any to be in a streaming benchmark.
>> 
>> Can you elaborate?
>
>BQL does two things that can hurt throughput:
>- limits amount of data in the queue - can limit bandwidth
>  if we now get queue underruns
>- adds CPU overhead - can limit bandwidth if CPU bound
>
>So checking result of a streaming benchmark seems important.

I understand. Didn't see any degradation in TCP_STREAM netperf. But I
will try to extend the testing.

Thanks!

>
>
>-- 
>MST
>
