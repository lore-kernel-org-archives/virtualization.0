Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02054D599
	for <virtualization@lists.linux.dev>; Tue, 12 Aug 2025 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992201; cv=none; b=QO2cGnLoS8PB7LfQCJBVf0YZiI1YXsoO7O2PCbI6cYgVmcg+e31LSdRQom92KvQ23hqXc/7Npem8dEHdN0dzCl1wF/f98XooxUy1UJoUgR/TLafHbIPWtyOiA6cbSSfKWKD9XiVb0pbcMEJ50qhxrmJzSW1WMYPG7YNHoDxe0Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992201; c=relaxed/simple;
	bh=0490oyMMcCSA6IAYKsOOlTvkHGvUwxMFO7SMFhwwTEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWg7MSgJ967swRuTWarFI/gcnb0zTxeUWVrRDbuWTYTMW606iR2oCB7i1Ndtd5fTIblUj/Rx0x2TgNymcBAKuKRvyL14xqNoCKUpN9ztjam34RlTCu47E0yoi8/aelmxKLaDLd8Go1LiI2BD4nHb5tRc5bt23wt4hAK9FmN0TGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J3iuEWal; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J3iuEWal"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32138e0d9adso4429858a91.2
        for <virtualization@lists.linux.dev>; Tue, 12 Aug 2025 02:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754992199; x=1755596999; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rHx6Lde4qag7Ztq8SOjvT6+8sJ05xOxFR27nxsVwgtA=;
        b=J3iuEWalzn5bEz3E4a1QE0LcxiebZL6dFHjbLq6FQROKMpUKVQTPaRUXB+hKxGUh9A
         slxNMQBD3bLxF4G4hl2PZqyCK1KW4tEH/e3TteyOPjL2gqpDljoNkoKNmbvNfj1fwrdR
         B5ouPrDfnUuuWMc5MAgHQkgVcTARd+fp87+Oc+lazAPB2ghXXbaLc8Pmwzr4zM7K16Cm
         phv0p3mtMLqUaL3lcbEntqSZEOW+U4e98bwb/1NKE1Q3MDEz+Ct1IdE6L7z4KJsOqtzR
         EaNGFZ2AS0ytWVz4mnARlq0nU9py+HTiYfyh/92lD5SplO+QIZPowZBXPvx36rUNA7ji
         yfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754992199; x=1755596999;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rHx6Lde4qag7Ztq8SOjvT6+8sJ05xOxFR27nxsVwgtA=;
        b=auxOFwCR2YOkl5uoFHcIdq5mbYXoMHjU+6G0SbSlROEuv0QPIykePHUXvTtku8cT+k
         taE6tXZSg/KJp/oQsVf6lpygvPksGl1mQpjRtOVGG28b/xU6bN88bD/8ipQELAqXRP8u
         iqT3zg0WxRxOEfDI/SmKspyU9DcLNmDcz0f8EKrtPaX1XCAJOJluHcaMb378d0vIMsVx
         tQaZodCjuTY28Oi/bkanUFAxoMkr8d5be65RQATZ5hgAFYjPOjCGObpz1nwsHL7ah9Vr
         dFAKShApWhOKXoDHjbCoKK3Ncua41gMUWaB1io+eOBRBIj41YIUjl4ym9V6u45pmxAnY
         YMAA==
X-Forwarded-Encrypted: i=1; AJvYcCWzJJA3Low96bs7PLis4+rEwc0XvtdyS8Xgw4V8c2uCXaazOVBY6mbONRCMiUEDipxhXf69Z8U/pEfHXHxvug==@lists.linux.dev
X-Gm-Message-State: AOJu0YyH49hgW5r6KQHCQ5xHU9MG1qTG0DSOKZ3+NTFVhgqOCpn3Ei5I
	OJI2NqFEuBpa3pB2QrrhWDAIeWUJj+Us47LPw5epVyuAok6IMafxwSsuACVBJSfpRIM=
X-Gm-Gg: ASbGnctCtGKyRQ3FsXRtZkxcRSFluhsVyDqmZd7UdA/bt4VI+lLVoNbXDTKiESfPA4u
	DJkVJnCLf07qZQ0vsf/ffiaLXriz4vzuVCaHrHmjw+XU7zdr8R3FLkRyY9w7ZwXCHgz/KzBiPd2
	/VFFvfHlUDcUC0G+d0w2Y5gE4SWLeh1g8Hqjcs0m5y2jwXrohzMeHCSS7aG0Fa6FFXxrzJ5ZJNT
	Klu9tGq3XDg2KS76OAMN8lOfOgFbKy2ZGck9d7qcQ6bWHD78UVNzWiomdKgxD9BQSpN5vS5rAs9
	3rPkFBUMuxRiv47eH9Mray+REAA6TQ2EDSatb6eN9ItytanfcrCd6xMMdVGlgNXBs5sQZa81brT
	YRgvy7GggWIf9Si3epL91+bhq
X-Google-Smtp-Source: AGHT+IFaE9wVmVALZ0AY3vMXxmm7SesZjwR/ULKy6XjkkdnNRyUoc7TfxGfX3avMzoLT05C0xMUULg==
X-Received: by 2002:a17:90b:55cd:b0:312:1c83:58e7 with SMTP id 98e67ed59e1d1-321b3e81bb1mr7812400a91.1.1754992199185;
        Tue, 12 Aug 2025 02:49:59 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7d86f7sm24860991a12.24.2025.08.12.02.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:49:58 -0700 (PDT)
Date: Tue, 12 Aug 2025 15:19:55 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Saravana Kannan <saravanak@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Bill Mills <bill.mills@linaro.org>, devicetree@vger.kernel.org,
	virtualization@lists.linux.dev, Sudeep Holla <sudeep.holla@arm.com>,
	Bertrand Marquis <bertrand.marquis@arm.com>,
	"Edgar E . Iglesias" <edgar.iglesias@amd.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [RFC PATCH 0/6] virtio: Add support for Virtio message transport
Message-ID: <20250812094955.fdyil4cbxr3bx4bo@vireshk-i7>
References: <cover.1753865268.git.viresh.kumar@linaro.org>
 <CAL_JsqJn2XtvWaDBSqYPUe2ZVxE7t4EbAt8OPncbQaKjh1jY5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJn2XtvWaDBSqYPUe2ZVxE7t4EbAt8OPncbQaKjh1jY5w@mail.gmail.com>

Hi Rob,

On 30-07-25, 08:39, Rob Herring wrote:
> On Wed, Jul 30, 2025 at 4:29 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > ### Memory Mapping and Reserved Memory Usage
> >
> > The first two patches enhance the reserved-memory subsystem to support attaching
> > struct device`s that do not originate from DT nodes — essential for virtual or
> > dynamically discovered devices like the FF-A or loopback buses.
> 
> We support creating devices from reserved-memory nodes.

I didn't know about this.

> Just add a
> compatible which you should do anyways because node names are not
> supposed to be that specific or an ABI.

Yeah, I already knew that the node-names thing isn't going to fly as
you and Krzysztof rightly pointed out. I just wanted inputs from you
guys and so did that as a first implementation to get the discussion
started.

I tried something like this now:

      reserved-memory {
        #address-cells = <2>;
        #size-cells   = <2>;
        ranges;

        rmem@100000000 {
          compatible = "restricted-dma-pool", "virtio-msg,loopback";
          reg = <0x00000001 0x00000000  0x0 0x00400000>; /* 4 MiB */
        };
      };

and this works fine. I am adding two compatibles for virtio-msg:
"virtio-msg,loopback" and "virtio-msg,ffa". Yes I will properly
document them in the next version.

With this, we don't need the 2nd patch anymore:
  of: reserved-memory: Add of_reserved_mem_lookup_by_name

but still need the 1st one:
  of: reserved-memory: Add reserved_mem_device_init()

Thanks.

-- 
viresh
