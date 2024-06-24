Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1471613D531
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 13:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234618; cv=none; b=SE4AeEF5cE/KloEDycrYvz32FZOyeir8eUN3ThswymizBAJysMwXlNvdA+YaLstIOv5Seakl/vAsl+FryWbeU3NH4BAA4ljHOwAq1d2FycLAVhyO0+3MRZUsTHXb8KNqn9ctjW/EFATGMU9euz2/BIlfO8uEN7N+/Saw+vDvLKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234618; c=relaxed/simple;
	bh=LPEbPhY3dHpttqMilOnAvpTiAsH/L53iw63LbdCYntA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvQMfgz7oD6xY+17EUdJNx2zY7qv5IofF0mcIi/CmrfkzZmzCvFJJi9M/Y9D06vNHVRSPRmo+Dph9QJWkZaFZwsqOJvREta/es2jZ/AHrgwmT1DvOiheDFafjSqYZJ0fqYDpTVofD9eHnLBqH07aMVL2GgZhlAj9wsGgeZ9BPGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=NKatLPHx; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NKatLPHx"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42189d3c7efso47282035e9.2
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 06:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1719234614; x=1719839414; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KYCGbVBgTOKdqNctucJiBEokyy6+FlKDCsKEjtM+4Yc=;
        b=NKatLPHxxYhtx4Ir9M1Sp/brSsTS93Wd++y9Ir5UgIOyyWnZkty11jIQV+UFdpX/7+
         701BYki2IaujMEnjYrT/Lq6TwqOvN3Wugvvt+MhNPlbLGk5DwW84Vd7DFLphTbVi9MKO
         JlTq+6+EukHNWTNlz0MxPTAI2tRBDM4DsLkG2vAmkmi8nyQYG7bGsV1iZP/dzoxe0tdi
         erkUYqymjbUZqiEfcUDebJTu0Ibw6mtlBxekSsnnY8iOZLsYAuksKdOvz610I/V/oY1p
         ENn51lX8uCELDYXJcU4Z1n1MKYzwOkN54pavZugYKPaQlmE+z9eExavHxR7xrvxWP067
         p/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719234614; x=1719839414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYCGbVBgTOKdqNctucJiBEokyy6+FlKDCsKEjtM+4Yc=;
        b=sIxo8C1htoG/GmKiNSerLtZHDbvCEEbH/ZPuMJDmqn/H1e3SB5Nlej3KLG0kG3Diyc
         /yEwuPOpY+F10TfSSgzfstCB6UX+9prXuE1m8XZS9u4btd6gW7hATxo9H64Lnwo8lqYm
         GcJHlCEbHJBIO2hGfH/lSbcHTAA7I+UgWE8aBGzCNpXbNTxwQDlKLYMqoUDPEXiBgn7n
         UFp2/fwc0i8IWSc0LAXAcLjbJs99XhGw6X6sRGQY57iT5nIV/Z4/Gq0FclbPT7QvF/tQ
         6AlUWdagpqXCSL8qDjnpfSbm59jZVAZhhKHfj7JE4bRiSXtjcUIEWPMShJDbhy1PjN7h
         Yp8Q==
X-Gm-Message-State: AOJu0Yxk8EO9DJ2HTayVLVRDs1KJ3cyECZWEb+vznOwuVWZ/nFKTQE2V
	+wk1pZZabOED8JFEB62KTkUKEHrrJFwRJoZVswRpMNQ/YE/TlUcA6NCR+D1rjV0=
X-Google-Smtp-Source: AGHT+IF/7f/DcpSTVAj9StNyyLf5zw6k81xL2VAQPxz85H7E/LPS+grdkiX4MyDyJ0DeyorhU4aN1w==
X-Received: by 2002:a05:600c:6c8e:b0:424:82fe:5f10 with SMTP id 5b1f17b1804b1-4248cc66723mr37088705e9.39.1719234614292;
        Mon, 24 Jun 2024 06:10:14 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0bea05sm173133535e9.18.2024.06.24.06.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 06:10:13 -0700 (PDT)
Date: Mon, 24 Jun 2024 15:10:09 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, Heng Qi <hengqi@linux.alibaba.com>
Subject: Re: [PATCH virtio 7/8] virtio_pci_modern: use completion instead of
 busy loop to wait on admin cmd result
Message-ID: <ZnlwMT_HhrWGtnwU@nanopsycho.orion>
References: <20240624090451.2683976-1-jiri@resnulli.us>
 <20240624090451.2683976-8-jiri@resnulli.us>
 <20240624072340-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624072340-mutt-send-email-mst@kernel.org>

Mon, Jun 24, 2024 at 01:30:54PM CEST, mst@redhat.com wrote:
>On Mon, Jun 24, 2024 at 11:04:50AM +0200, Jiri Pirko wrote:
>> @@ -73,21 +91,30 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_device *vp_dev,
>>  	    !((1ULL << opcode) & admin_vq->supported_cmds))
>>  		return -EOPNOTSUPP;
>>  
>> -	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
>> -	if (ret < 0)
>> -		return -EIO;
>> -
>> -	if (unlikely(!virtqueue_kick(vq)))
>> -		return -EIO;
>> +	init_completion(&cmd->completion);
>>  
>> -	while (!virtqueue_get_buf(vq, &len) &&
>> -	       !virtqueue_is_broken(vq))
>> -		cpu_relax();
>> +again:
>> +	spin_lock_irqsave(&admin_vq->lock, flags);
>> +	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
>> +	if (ret < 0) {
>> +		if (ret == -ENOSPC) {
>> +			spin_unlock_irqrestore(&admin_vq->lock, flags);
>> +			cpu_relax();
>> +			goto again;
>> +		}
>> +		goto unlock_err;
>> +	}
>> +	if (WARN_ON_ONCE(!virtqueue_kick(vq)))
>> +		goto unlock_err;
>> +	spin_unlock_irqrestore(&admin_vq->lock, flags);
>>  
>> -	if (virtqueue_is_broken(vq))
>> -		return -EIO;
>> +	wait_for_completion(&cmd->completion);
>>  
>>  	return 0;
>> +
>> +unlock_err:
>> +	spin_unlock_irqrestore(&admin_vq->lock, flags);
>> +	return -EIO;
>>  }
>>  
>
>
>The reason we had the virtqueue_is_broken check previously,
>is because this way surprise removal works: it happens to set
>vq broken flag on all vqs.
>
>
>So if you are changing that to a completion, I think surprise
>removal needs to trigger a callback so the completion
>can be signalled.

Got it. Will check that out.


>
>I think the cvq work also needs this, BTW.
>
>
>
>
>-- 
>MST
>
