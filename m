Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5A8524D7
	for <virtualization@lists.linux.dev>; Wed, 22 May 2024 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716365851; cv=none; b=ODrgAbZj/6r3vYSRWhTxXACReel/+8tC0Cy9Ix3hwP9PAMWzku4NGUxBKL6r57yeJeJ/qK2qGt4UHBTuNeBNmDszNeKtUru4EoZ3oU2EFIhEyJBjuocPN20rqLgA/BVhE6BET08XfcrRNZNNvPAAQ8RT90cFynyI5Y7lpvxLisU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716365851; c=relaxed/simple;
	bh=JpAPXBGTodsPSy3NwwfJ8SNzxC6FDxFhAbszrLfwads=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5B4wKYskhVPA6hHI48j2ZaL/o3IVcZFjB8d0vI0Q8ce6Hqdl8pqaVvrf1fbF8zwU9f+Kf7lhKHiaGEDdksW6bHanJhOHFTsBUEBCvHww+r8ZYTvv7hAvCj9vdNf7uBgHNpJEx6jea7jpxQBLHNq5Di7QN/hDOTgbUJRbwZt0LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Nbe2C+u+; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Nbe2C+u+"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-572a93890d1so10823206a12.3
        for <virtualization@lists.linux.dev>; Wed, 22 May 2024 01:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1716365848; x=1716970648; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AUlOf7PiQ+Iis+GSXHl45zjGGmyQX2YyD93PWV/kmtQ=;
        b=Nbe2C+u+W3KOdbENDBBQ6Qt8auvbfM/W5Rs27Lz1AvBDNt/AGYhn+I4Qree4bxs3Yl
         XBPYOvABcjXOB7kfXh/8ym6c8BQjDJ/Foo8Ucys6bRL6ziydGMlc9lwzNLs8O1bYkPbJ
         k4qG1+bINoSbDHd/Mx0/H748lMekxNpEnUk/sS2povKaIdPsEhG/l/hvgGH8sjYQTFMX
         6aUuTiR3v8fnsEBxx3X///DntEOJpvYJYVoGywgnQIpCGRn84Jq+NeGiVAkh9qvXzu+2
         aljZ3lrb45u6B3dE22P7qaW0dp0ddCIqcFwS9C7bpjuK80HxURjp0RCSYwQgr5JSIqdL
         F8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716365848; x=1716970648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUlOf7PiQ+Iis+GSXHl45zjGGmyQX2YyD93PWV/kmtQ=;
        b=oMVfVuzTV4Lr3PAFGRjaRaM+EXs15KrTyPP8JRkiaemdP7UvoFB+DpgaerDfvm+a0E
         UEmbOSD5J82dVP2oGedmOhFyWZCtUa+7IURxksPsgSUXpwWm/RSUsST5ortNOWdJwbaP
         7VVZM5FNdUdtZ0pby3BbT5bK3TpQj58G3XREBaT7F7DfpYZvGUxo+fYE2R0cvTIV3hIn
         fF4ip8ricfbSoFuupWR0BfDfIfNWFJ3qw23GYmx+eJe+CDD6/x+6J5uqp8a9x02BOOUU
         INVEQVSmQr4MX+qMcL1WMmYQemfPirIz9ppQDV6YbVxY2FkwBty+3b7lIbQnpA716sDn
         UZ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUe2n5DOmpxASVS9G8UHOxGJSP9vZ2EEd+K87LaiK61ON/GZ6EFly6oUqd0pm1EEnDuoSXG4qzZLEjqqneYAv9mvfG+ZuPHriI/bemSJhI=
X-Gm-Message-State: AOJu0YyKe6/bnVi9LAH7OYEbDdEsJco/nIosunBtjXNzuuXkpDS2MS1c
	sselCTv0AALE0dyxmWhtBidFGsDdoTws1dYfVAKmUvuf7QjlmUOETA79z3Qn4X8=
X-Google-Smtp-Source: AGHT+IF2u9M8wmL3gHSyXUK5Xk6BEDD6Xpgeh4DJe8nj6573+HCok4jIjRA3nd/ZBlqBD9qjjds3sQ==
X-Received: by 2002:a17:906:cf87:b0:a5a:1bd8:b7d9 with SMTP id a640c23a62f3a-a62281466d5mr123517166b.46.1716365847825;
        Wed, 22 May 2024 01:17:27 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5cfbd73547sm799554566b.171.2024.05.22.01.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 01:17:27 -0700 (PDT)
Date: Wed, 22 May 2024 10:17:25 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net 1/2] virtio_net: fix possible dim status unrecoverable
Message-ID: <Zk2qFRSKRkbxdfjJ@nanopsycho.orion>
References: <20240522034548.58131-1-hengqi@linux.alibaba.com>
 <20240522034548.58131-2-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522034548.58131-2-hengqi@linux.alibaba.com>

Wed, May 22, 2024 at 05:45:47AM CEST, hengqi@linux.alibaba.com wrote:
>When the dim worker is scheduled, if it no longer needs to issue
>commands, dim may not be able to return to the working state later.
>
>For example, the following single queue scenario:
>  1. The dim worker of rxq0 is scheduled, and the dim status is
>     changed to DIM_APPLY_NEW_PROFILE;
>  2. dim is disabled or parameters have not been modified;
>  3. virtnet_rx_dim_work exits directly;
>
>Then, even if net_dim is invoked again, it cannot work because the
>state is not restored to DIM_START_MEASURE.
>
>Fixes: 6208799553a8 ("virtio-net: support rx netdim")
>Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
