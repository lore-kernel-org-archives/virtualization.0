Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BBD86243
	for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 09:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713260248; cv=none; b=DfpXr2KW/i+zHkRhJSTndZe9hBZ2YZrbBAkaGqI7MAkx2fL3BjTjTIpNXrUhZpwPWvM/OlnZ0AaaJr78wAZSjz5mXwQVMCxKv/n/eAk3Q5hi1W0qe5zn4VYNksTkt9SytnJzRKL0utqZFJG7ADNxzeIPlfiNB35iowYWL1J5yfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713260248; c=relaxed/simple;
	bh=ffWk3OdR6v/Mse52x1zn4+xDjJA19hq7H0Mp+dTmZ6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmgLTHlN+jFsqGFFD9n6Sdfi4ny2E9TUqGXGpPnP7+1gFTdnZYVMruRershHPS3tOoNeupvm1+pAUeYf3VjgKNTdLauPuy+tUU85B4CkWkYzLMX4wGb0gyNoO2Pqrta+wd2/2MiyaAiyuqICpXFpFwgEBUulq/g7lDtJxfYTr6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=KQSpl4rW; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="KQSpl4rW"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56c5d05128dso4437261a12.0
        for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 02:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713260245; x=1713865045; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/3DPvUKeMNgOHBMbHiy5cwD4zIVoi8D7XJtZoI1Ak70=;
        b=KQSpl4rWfolLFFGVjdrU+3sEE2438OXO2dmA+R3l91bbWnzywPmc7ym+yw07kp8pCs
         qSxQTlQES2XWUTfmLL/654kcW5iXz+WYsab1wiyaRRKBAQC040bjTSe3eX7mImesEe5k
         qm/jAfR+4wikhTzKp0kA6+4AQ8IiMb+nrpDPE8uYh3KgEFRgrigfCO+Rx0BqUIIjiwpV
         /XX5UUKeEQb6b/MpdjqgCHosPFjZxLxOx+GxNrBeonLH14GzqZQ+KvdbliMZiAuEOeVI
         nt25URzuYmL7QgB9F3dAX8uVuf/9i6G0ToNkKjUXcYhngxRPmRz/+SezZQvk93r1Z0Ae
         XNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713260245; x=1713865045;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3DPvUKeMNgOHBMbHiy5cwD4zIVoi8D7XJtZoI1Ak70=;
        b=uomvBwU7uFktvKImTkz+B/VhUB1iCF6ZGBOXDFAfH7GI332Fj8dNt6RpL8A+bc3ZH+
         S0zg0xjvGOHRaRzAb1SbQMUtwnhhpeoulpSJR+b70vgcEpI0zJ+KHg+xNYhuSdAslQCC
         OlBocLnhox4BeL7BwdSSHaJci3hTiqMHZ53YHXA1PBn5ogVbYYQmR5Z3ZubtG0+j3Nrx
         ItrvUremBiXWxk89fpiA6xB6fDZz8aTgMvxtiMdoZ4lxIy/2FBUCzCRqxlc1fdzVJg7y
         70ypKIHMUUoiQ8VAnlZT8ygdLXH47aR3LI4avxweZget4W0krsNgYnz8145/f1ICUeNJ
         uI2A==
X-Forwarded-Encrypted: i=1; AJvYcCVcBHjcasUtPnw4jJjnZvuZDYVeoyTgQ2eB8HgS8dl6UHo5f16aqTYnf/rfMJ0odhLt5tuKh5M7avxff5FFyiQ+9LOm1LX6QEvH+sNFY34=
X-Gm-Message-State: AOJu0YzPe+NniByF/n66XP1+91iMbakbPuWGxTuXHbnNiKO36seoInyR
	GWdv+DUMdgyxNUwj2LxBS4W3mF76zB4D4ZSKtLRIDr5BpSqbGjtXe50kqfowuIo=
X-Google-Smtp-Source: AGHT+IFvrj+8thE7TmHUgLSpaAVmqDEMlhBPdSlqMtVJZFoiX03aKmhBk17QQ+Nc1niwn/fjwRo85w==
X-Received: by 2002:a50:baa4:0:b0:568:b622:f225 with SMTP id x33-20020a50baa4000000b00568b622f225mr9062152ede.30.1713260245215;
        Tue, 16 Apr 2024 02:37:25 -0700 (PDT)
Received: from localhost (37-48-42-173.nat.epc.tmcz.cz. [37.48.42.173])
        by smtp.gmail.com with ESMTPSA id h6-20020aa7c946000000b005702fc1f92asm1835336edt.53.2024.04.16.02.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 02:37:24 -0700 (PDT)
Date: Tue, 16 Apr 2024 11:37:22 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, xuanzhuo@linux.alibaba.com, shuah@kernel.org,
	petrm@nvidia.com, liuhangbin@gmail.com, vladimir.oltean@nxp.com,
	bpoirier@nvidia.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v2 1/6] virtio: add debugfs infrastructure to
 allow to debug virtio features
Message-ID: <Zh5G0sh62hZtOM0J@nanopsycho>
References: <20240415162530.3594670-1-jiri@resnulli.us>
 <20240415162530.3594670-2-jiri@resnulli.us>
 <CACGkMEtpSPFSpikcrsZZBtXOgpAukjCwFRcF79xfzDG-s8_SyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtpSPFSpikcrsZZBtXOgpAukjCwFRcF79xfzDG-s8_SyQ@mail.gmail.com>

Tue, Apr 16, 2024 at 05:52:41AM CEST, jasowang@redhat.com wrote:
>On Tue, Apr 16, 2024 at 12:25 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> From: Jiri Pirko <jiri@nvidia.com>
>>
>> Currently there is no way for user to set what features the driver
>> should obey or not, it is hard wired in the code.
>>
>> In order to be able to debug the device behavior in case some feature is
>> disabled, introduce a debugfs infrastructure with couple of files
>> allowing user to see what features the device advertises and
>> to set filter for features used by driver.
>>
>> Example:
>> $cat /sys/bus/virtio/devices/virtio0/features
>> 1110010111111111111101010000110010000000100000000000000000000000
>> $ echo "5" >/sys/kernel/debug/virtio/virtio0/filter_feature_add
>> $ cat /sys/kernel/debug/virtio/virtio0/filter_features
>> 5
>> $ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/unbind
>> $ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/bind
>> $ cat /sys/bus/virtio/devices/virtio0/features
>> 1110000111111111111101010000110010000000100000000000000000000000
>>
>> Note that sysfs "features" know already exists, this patch does not
>> touch it.
>>
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>
>Note that this can be done already with vp_vdpa feature provisioning:
>
>commit c1ca352d371f724f7fb40f016abdb563aa85fe55
>Author: Jason Wang <jasowang@redhat.com>
>Date:   Tue Sep 27 15:48:10 2022 +0800
>
>    vp_vdpa: support feature provisioning
>
>For example:
>
>vdpa dev add name dev1 mgmtdev pci/0000:02:00.0 device_features 0x300020000

Sure. My intension was to make the testing possible on any virtio
device. Narrowing the testing for vpda would be limitting.


>
>Thanks
>
