Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E89230FF39
	for <virtualization@lists.linux.dev>; Tue,  2 Dec 2025 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764670707; cv=none; b=LeRDNH2yofLBgSAepeHS3j/vGrGcCRfyEHUn2aHdTplygO4cnQGpotZ5+6EDcuKqaHy5Ik1xqd2+O5ynrAZL3zIykccWdACQonbmgZvMzuP8bie12O8h3nUfSZyTnhp2LgwvlMqqQj98ltqgCEaG2Eh9asXxLVvBk0xCREN/XEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764670707; c=relaxed/simple;
	bh=C4AsMPURAFZJ6fstRBG4Qg4vpP3aNkGXJBTFj94MTzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DkZiC9oc0yzw8GNYG57nFFEoyTc8AW6vBYbDaP06w7fvw9Y2XH9bFEgg9GQl8qAL0ohphwS/zQB6DapqIrmu0MeyMAvFeSxTvwxoJv5WO8zs1qi03O/u/zakjkO2yjK33+4WFySd4/vMitKuMCajCctaG61dudal1wlXih0yzn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G/OoOUWb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/OoOUWb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764670704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CTt4I/sl26XWVMJJrirBgM5lGXHO7o89v/gepGPRQ/c=;
	b=G/OoOUWbj+ejZWqrBX965hNEIRb5yt9Q5NPurcLyaCmM7lRbtiEQAWsu/bm5rqwm7REpEf
	yPVbBhXPbVQnxVK9uXny7GBbMiL9nsNjAdZxKKofH0DgQ1o/b3AFbDPPN7NK8oMrKA2J+5
	fDfjwoXItoT7hTxpMQOUBOrH0zXdK4A=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-sWVG9rYAPGC1CtE1gaDTJw-1; Tue, 02 Dec 2025 05:18:21 -0500
X-MC-Unique: sWVG9rYAPGC1CtE1gaDTJw-1
X-Mimecast-MFC-AGG-ID: sWVG9rYAPGC1CtE1gaDTJw_1764670701
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-64203afd866so10120291d50.0
        for <virtualization@lists.linux.dev>; Tue, 02 Dec 2025 02:18:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764670701; x=1765275501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CTt4I/sl26XWVMJJrirBgM5lGXHO7o89v/gepGPRQ/c=;
        b=NMzAPeTCC/LctrP1LA3N2wL6ylhwEJZPNBuLux1W6rYuXx3+cbFxAP1lFhUYHw1/vj
         V1isap+2hW6Q2i29P9s7L3EhOnaSBwXnIub+sVfK7yDj5PlNlyT0+ci9OOI51tIet1Ns
         GfnDKuTv6uLlLZbsCjDJgtXGYDcpnD7b7cAhWItAIhGls5Y1AoPDnaNbNddYv0VHbXOg
         WZUZp8YkT4xXLEsoxEL6CtiQGsQvPSnlqVLUFD1f6wrBCszO+7V2gGxsHnsyX+Y2cse8
         PaHNWeYqrPd0Oef7luggupAbz7PO7+uG39CsF0f82V2Im5+wZEqG9RnOvcVOnGWz7eEY
         zhZw==
X-Forwarded-Encrypted: i=1; AJvYcCXpRFTXLEN7f2tbh4I2nMK/G9ZIt4pOedHR3yUp2MUzUbgQXOhyCbEkYp3rAaufDpoTngHIXIAThJ9yV4Tdqg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxCHgkLkyV3aVHp+h1Uko8Dj/Rffn916Ts6BdEFQOX3MMxebRl
	LVh9mbaxRY8uU5dp8LPI3W2uGNsiC5OM5yI3JGphu7qx42Isnk/pXmWpwUDAL8Qz+PhYr4t2mmj
	hv5ZsCbYZVPjCF9tu+JKILrNjbwCz/UHala3q6AwyIHYrlH1sHbpC4vdsF03yhdyAUmT+
X-Gm-Gg: ASbGncukDYVapCufjTICz+jHbLrN35b6KKTIBzolmp78OQRKZ2stCZG7cVJa/P84L/0
	JwXzfob2fe3K6ZXg4IvZijwNoGzKNdPuOggEdKceHC+TkpaTBhAjSis+IUJZjppOpplHoM7iUzD
	/P65cr0LVuzE5HA1/Hm29JO76c+/PuYuSZ1FO6hROkd1H5bK58Zh5//dtd8hRlwaxHRX8pF1uNw
	MhCRoxfXYR5MPvUDX34kdjwNCAw+3F/uH29Mu0g7KQrfHjldSP3+0GhIg52eIeHGZe3CfnzceFd
	LJ0yomymH3tRK8+ZrHI/zFY8tKZ/dQhcdYvh5B5b6uPVxK9Vknf4zeXLolnO3ap1GA2kf+PurnX
	qy9ji2OtBdyTlwQ==
X-Received: by 2002:a05:690e:d03:b0:641:f5bc:6959 with SMTP id 956f58d0204a3-6442f18c515mr1347966d50.42.1764670701057;
        Tue, 02 Dec 2025 02:18:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9Y2QIm+VTnIL7mAD4ACmwgT3wSBe6KSOZFrHyLZqmktUrNUAn/hV1QCPy5jYE4S4xdld0TA==
X-Received: by 2002:a05:690e:d03:b0:641:f5bc:6959 with SMTP id 956f58d0204a3-6442f18c515mr1347929d50.42.1764670700596;
        Tue, 02 Dec 2025 02:18:20 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.136])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c089431sm6041059d50.10.2025.12.02.02.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 02:18:20 -0800 (PST)
Message-ID: <6cef5a68-375a-4bb6-84f8-fccc00cf7162@redhat.com>
Date: Tue, 2 Dec 2025 11:18:14 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 04/12] vsock: add netns support to virtio
 transports
To: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa
 <vishnu.dasa@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kselftest@vger.kernel.org, berrange@redhat.com,
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@meta.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
 <20251126-vsock-vmtest-v12-4-257ee21cd5de@meta.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251126-vsock-vmtest-v12-4-257ee21cd5de@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6Yi3O99XYz4VzQyF9Aav6MRWfspvMBkSia2b-o2V9Hk_1764670701
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/27/25 8:47 AM, Bobby Eshleman wrote:
> @@ -674,6 +689,17 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
>  		goto out;
>  	}
>  
> +	net = current->nsproxy->net_ns;
> +	vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
> +
> +	/* Store the mode of the namespace at the time of creation. If this
> +	 * namespace later changes from "global" to "local", we want this vsock
> +	 * to continue operating normally and not suddenly break. For that
> +	 * reason, we save the mode here and later use it when performing
> +	 * socket lookups with vsock_net_check_mode() (see vhost_vsock_get()).
> +	 */
> +	vsock->net_mode = vsock_net_mode(net);

I'm sorry for the very late feedback. I think that at very least the
user-space needs a way to query if the given transport is in local or
global mode, as AFAICS there is no way to tell that when socket creation
races with mode change.

Also I'm a bit uneasy with the model implemented here, as 'local' socket
may cross netns boundaris and connect to 'local' socket in other netns
(if I read correctly patch 2/12). That in turns AFAICS break the netns
isolation.

Have you considered instead a slightly different model, where the
local/global model is set in stone at netns creation time - alike what
/proc/sys/net/ipv4/tcp_child_ehash_entries is doing[1] - and inter-netns
connectivity is explicitly granted by the admin (I guess you will need
new transport operations for that)?

/P

[1] tcp allows using per-netns established socket lookup tables - as
opposed to the default global lookup table (even if match always takes
in account the netns obviously). The mentioned sysctl specify such
configuration for the children namespaces, if any.

