Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB691922FE
	for <virtualization@lists.linux.dev>; Thu,  8 Aug 2024 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130938; cv=none; b=NznKn49DlpJobMTb0Aid5xg9PwIcpiKU4u9HfR60N0Tm8OCWqtRxyUPIqYbL4tl1CqEYQ4eWIz/9y7cH7ll2bT7unN0+qjrnK0oAMCv/S154RjWE4l4bq2ifJHmfmP/BA2QZd8Xe2ay4VzAccyWVEiEmh5Me/obfCOQV2xRq/ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130938; c=relaxed/simple;
	bh=aw9Xng6hnlicSSBCNfgV3RC00vVWh3x9RqULWZidsCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6R/NZWRHcxfTqzTk08vpVGcJWdah65YC6DIV4kvLFLixNTuxB+Ge211XbcuI3EQdNA8bqAHXoeaX1k6cysOd30ucLC//eRDnpm4mg37gKSNi4smeBKaUszCqZg3dogY9ULlAcMoPPblaZE4zAOxtwGtnt+Z9EpOSCWo9ZJfWc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=sCdCW7iF; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="sCdCW7iF"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a1c49632deso1172045a12.2
        for <virtualization@lists.linux.dev>; Thu, 08 Aug 2024 08:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723130934; x=1723735734; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jnhmQnmP7IyJNihYnngPeQZmYDUEfF0VywLMKOpnWZs=;
        b=sCdCW7iFZ9UVaU6T9Sp0ctTXOI1nzufDlWu6OJucYaYxgQdwpV44XPNv75+WJo1bdD
         KidQ/SZrKzINGOWL17CfgLFKYvQwTMu5XMatPEeRieFyAU2JTLP5jzgN12hWfcWQxVHE
         VgWlu+W/kPV8O0zt7PxqV671t9MKvq4g/9tzdIJx/x9qZOfYGUD7XlzhLCuAT3QTzXKF
         vxzLJjeAUC9e93VDhwPP6eHKmTPZEsx2UFBjOWfmWBzT8Dr77/f+wah/6CJWEj0/qR0J
         gQwH7Bcab1tjYXRLzlG+eLpEHTuFk/gVlwnsKx94Wf6+IAdxqii/U92F6deFxvtcXarb
         OisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723130934; x=1723735734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnhmQnmP7IyJNihYnngPeQZmYDUEfF0VywLMKOpnWZs=;
        b=Ii2TtFdXgg1IWsQPnQnljv+JGoBJLDRQpYDDTf8UELg+KE3bL5SyxU1WD1BCJzXxTa
         B7QkngIERln/08Z2HyjOLFPrzz4/kaxU1ul29QBEY5DuVSKTuXptVojdHmbGGYsCtQgQ
         1u6RkgqjuHBG8G39MUDEM9E0gSayFxkM0wgc68GKty+VVTJ6oQWFVScbAt8eWlGl32Gh
         4s7hz+vCf/Bt+wo7KdM9opL9H3TUvukpfVRu++onsCJmQYYijrd38batO1Q/5n0aLfL2
         N2b6+hfyC8TZFhKAgDwewwQwsB3vHztlXqC8WGRGcHhBccwe+7XHlmXxyl9I0ytGe1nk
         NQeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpO0GlGg5pXlXob1t8Dt/tyNJdNGYAaLkWkN9Mrwx7M8WbEDascdQu/osdad1lD4F5YNMq/eOkY1iu2mSJhJiqiBCujCMx9OJuWm2v3ls=
X-Gm-Message-State: AOJu0YylhK3G6Mq9zpdI4AyUF+w0ze0yjWbZAOllT4i/9FDmwjvzBl2B
	5b7250DIzZtot3X4swYxrkez8Lir0cytNpPB4vvvA2E1E4ZqIy/9o+1GcqQvkbc=
X-Google-Smtp-Source: AGHT+IFVkXIIsX8nA56eA8djSmI0KbyIntGTCsgK7o0p60nH7gDNab4XFcAqWv4Pl7Y+SKusOt+AyA==
X-Received: by 2002:a05:6402:2549:b0:5a1:f680:5470 with SMTP id 4fb4d7f45d1cf-5bbb21ac2femr1931023a12.13.1723130934206;
        Thu, 08 Aug 2024 08:28:54 -0700 (PDT)
Received: from localhost ([213.235.133.38])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2d35172sm773074a12.71.2024.08.08.08.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 08:28:53 -0700 (PDT)
Date: Thu, 8 Aug 2024 17:28:49 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Hongyu Ning <hongyu.ning@linux.intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: Remove virtio devices on device_shutdown()
Message-ID: <ZrTkMVMS1WEglahx@nanopsycho.orion>
References: <20240808075141.3433253-1-kirill.shutemov@linux.intel.com>
 <ZrSuBlWkE-USicQw@nanopsycho.orion>
 <o7duejn6zoua2zu6ff5x4nn43bdbqllsmhqtc2i3dkqme5pmig@4nsfqi6wsjsd>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <o7duejn6zoua2zu6ff5x4nn43bdbqllsmhqtc2i3dkqme5pmig@4nsfqi6wsjsd>

Thu, Aug 08, 2024 at 02:11:09PM CEST, kirill.shutemov@linux.intel.com wrote:
>On Thu, Aug 08, 2024 at 01:37:42PM +0200, Jiri Pirko wrote:
>> Thu, Aug 08, 2024 at 09:51:41AM CEST, kirill.shutemov@linux.intel.com wrote:
>> >Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
>> >accesses during the hang.
>> >
>> >	Invalid read at addr 0x102877002, size 2, region '(null)', reason: rejected
>> >	Invalid write at addr 0x102877A44, size 2, region '(null)', reason: rejected
>> >	...
>> >
>> >It was traced down to virtio-console. Kexec works fine if virtio-console
>> >is not in use.
>> >
>> >Looks like virtio-console continues to write to the MMIO even after
>> >underlying virtio-pci device is removed.
>> >
>> >The problem can be mitigated by removing all virtio devices on virtio
>> >bus shutdown.
>> >
>> >Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> >Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
>> 
>> Could you provide a "Fixes:" tag pointing to the commit that introduced
>> the bug?
>
>I am not sure if it is a regression. Maybe it was there forever.

Does not have to be regression. You can blame the commit that added the
code.


>
>Hongyu, could you please check with bisect if it is possible to point to a
>specific commit?
>
>-- 
>  Kiryl Shutsemau / Kirill A. Shutemov
