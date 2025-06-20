Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E856D7494
	for <virtualization@lists.linux.dev>; Fri, 20 Jun 2025 13:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425663; cv=none; b=atymIOzkxLdwnQ5dK7EJD8syscoTCCSXqLADA88C9MOsqPArXJMmWC6ca5WgzRQQ2HGk0rhIBPt9qLbI8c+QW3CIW6LAbOPFrQQwXq0ealLt+Sfwmc/5H+3zt+a6J7yMEissQdvRl7A406xnyvSbfahkqpoqfFrg+P9a3HSivdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425663; c=relaxed/simple;
	bh=m++IWIdhWcOcndZZ1RdUUYfFhpUVf+EYrm4S0Wxh/7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IFcUr56W0eIIY0jb3j8/j9V7hIaQaQvuIl8+nEeGX6EEm0BoSzbLPH9Kt6QxIGBcCDL6vRNPuddXZfL5QIkdr1TsFNEy5XvVw9POzd3+uEVFdNU3mTUJiiYkO/gf2XOPYpZrcCJqtgHGptu/byXtIa4+22HGc3lzOkNxvirKFtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hUm+WMZ2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUm+WMZ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750425661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wrbqyOjgClJljme6Y8IBM3ztge6H5cPgaXJrix0YAsM=;
	b=hUm+WMZ2A7QejRXsToGjKQ/+jBlSeli6ZcfjjqCBb/n0cxDPBr8HIjqXZF+PwBkWQF+baY
	1qpBnltrPiHhfNn2zsaQFOsT6VsKpOb4QnGzpLcdWzSGwbsLK7ajLmiyaS5XuTBx146jMi
	KPJL2/3Ae29txkuCad8azLZAiUjeqQw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-sMGxmpgdPNKNMc_tqFJ0kQ-1; Fri, 20 Jun 2025 09:20:59 -0400
X-MC-Unique: sMGxmpgdPNKNMc_tqFJ0kQ-1
X-Mimecast-MFC-AGG-ID: sMGxmpgdPNKNMc_tqFJ0kQ_1750425658
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a50816ccc6so1186955f8f.1
        for <virtualization@lists.linux.dev>; Fri, 20 Jun 2025 06:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750425658; x=1751030458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrbqyOjgClJljme6Y8IBM3ztge6H5cPgaXJrix0YAsM=;
        b=CFqhd9vYpYb2jIw03EhklNZr27UMqVIPDO7KDpdQHFIkBcWTWt75s3REsV1e0YmCyc
         EvOJYcVzWgUcGp969CxcR+Mt+1SoYkub41kQYMt1iIBdueUs2gPu92D75Y05FAkY/eqd
         JmNdGEMqyvtH402plfaxFk8XPUU08XAjXxnpvydVxES/ZKokXoWxkn2pxLNmNt4QbL90
         QM7oiO/0IpZ6A5BMe/Lsrf0kJkwCkdEGBsHhDnfqcQY6ND1tSyGdf4/IAv/TFd6tB3Dn
         qCjkT3k1ibslFHtNbuSil8e1zyjnSu3maWceKUiozw5Bf420j1vEiQsFuL6HhD6Xu0cq
         olag==
X-Forwarded-Encrypted: i=1; AJvYcCXuYgIKhMTiYawOAvlaJOSo3k0LbfVa3MU3QUcyjoIXOmG9NeOIzCl6n5p2+QmQMS1h3qnRS7/d/BgVe6E2AQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzyWUJw4Im2yLtHD6tck60v7r2vmEsA8j3k92OIElx2wV/lgZP
	pcXWGSB1L1u4/8BhbhssnsYGM1pagMlTayN/ovhwyTLNE7P/45VX+l8KyfzOP/YrLF1ixyq/eN8
	u0ALbbcuGcOneQ1fblKTPgypu33f91V1m/GvjYFpL7nkgBtLUCGUJ2H3ToPcTVBZmDCPN
X-Gm-Gg: ASbGncstiUkIlnpEOkQxReRNrcpATHah8O1Os/H2o8QQtZFiaNy7cJIX7Q3y+Qj2+uR
	7/1PtB/AA2OxqMDfCTdc0mhJVAgY2KQ/6Sew/qUN9udT52y4Mee31osZmJinsa0BxaOrjzY65TW
	WPQq5su+pX53r02mTJD34Cf5p3i9l+ijE5vXMsaWjkSTW54FrjzvK4yHPZtH1jBSbL9Q3txwhTu
	RHIfqcPTWwHpRZpk2XbHDD7qFQIcHGZM383yWYPup/CrfSmf1IYXyOmafLPw/RRdTBQCziUZbw9
	LRagMtXKeEun+m86fv7KP0T33xM=
X-Received: by 2002:adf:9dd1:0:b0:3a4:f655:8c4d with SMTP id ffacd0b85a97d-3a6d131787bmr2056462f8f.27.1750425658396;
        Fri, 20 Jun 2025 06:20:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9QRtkvxSOLn59Do52l3ix3GhLfK1cWTxETb+z/cJOkSsbedauMcmLKrjvI5kUALGNlARMfA==
X-Received: by 2002:adf:9dd1:0:b0:3a4:f655:8c4d with SMTP id ffacd0b85a97d-3a6d131787bmr2056441f8f.27.1750425657878;
        Fri, 20 Jun 2025 06:20:57 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.146.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0ec947fsm2106321f8f.0.2025.06.20.06.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 06:20:57 -0700 (PDT)
Date: Fri, 20 Jun 2025 15:20:52 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/3] vsock: Fix transport_{h2g,g2h} TOCTOU
Message-ID: <cg25zc7ktl6glh5r7mfxjvbjqguq2s2rj6vk24ful7zg6ydwuz@tjtvbrmemtpw>
References: <20250618-vsock-transports-toctou-v1-0-dd2d2ede9052@rbox.co>
 <20250618-vsock-transports-toctou-v1-1-dd2d2ede9052@rbox.co>
 <r2ms45yka7e2ont3zi5t3oqyuextkwuapixlxskoeclt2uaum2@3zzo5mqd56fs>
 <fd2923f1-b242-42c2-8493-201901df1706@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <fd2923f1-b242-42c2-8493-201901df1706@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: O5TvXSsMsG8TVYYW8jyIV2H_v9VQAWD8KsYN7fShfys_1750425658
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jun 20, 2025 at 02:58:49PM +0200, Michal Luczaj wrote:
>On 6/20/25 10:32, Stefano Garzarella wrote:
>> On Wed, Jun 18, 2025 at 02:34:00PM +0200, Michal Luczaj wrote:
>>> Checking transport_{h2g,g2h} != NULL may race with vsock_core_unregister().
>>> Make sure pointers remain valid.
>>>
>>> KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
>>> RIP: 0010:vsock_dev_do_ioctl.isra.0+0x58/0xf0
>>> Call Trace:
>>> __x64_sys_ioctl+0x12d/0x190
>>> do_syscall_64+0x92/0x1c0
>>> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>>
>>> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>> ---
>>> net/vmw_vsock/af_vsock.c | 4 ++++
>>> 1 file changed, 4 insertions(+)
>>>
>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>> index 2e7a3034e965db30b6ee295370d866e6d8b1c341..047d1bc773fab9c315a6ccd383a451fa11fb703e 100644
>>> --- a/net/vmw_vsock/af_vsock.c
>>> +++ b/net/vmw_vsock/af_vsock.c
>>> @@ -2541,6 +2541,8 @@ static long vsock_dev_do_ioctl(struct file *filp,
>>>
>>> 	switch (cmd) {
>>> 	case IOCTL_VM_SOCKETS_GET_LOCAL_CID:
>>> +		mutex_lock(&vsock_register_mutex);
>>> +
>>> 		/* To be compatible with the VMCI behavior, we prioritize the
>>> 		 * guest CID instead of well-know host CID (VMADDR_CID_HOST).
>>> 		 */
>>> @@ -2549,6 +2551,8 @@ static long vsock_dev_do_ioctl(struct file *filp,
>>> 		else if (transport_h2g)
>>> 			cid = transport_h2g->get_local_cid();
>>>
>>> +		mutex_unlock(&vsock_register_mutex);
>>
>>
>> What about if we introduce a new `vsock_get_local_cid`:
>>
>> u32 vsock_get_local_cid() {
>> 	u32 cid = VMADDR_CID_ANY;
>>
>> 	mutex_lock(&vsock_register_mutex);
>> 	/* To be compatible with the VMCI behavior, we prioritize the
>> 	 * guest CID instead of well-know host CID (VMADDR_CID_HOST).
>> 	 */
>> 	if (transport_g2h)
>> 		cid = transport_g2h->get_local_cid();
>> 	else if (transport_h2g)
>> 		cid = transport_h2g->get_local_cid();
>> 	mutex_lock(&vsock_register_mutex);
>>
>> 	return cid;
>> }
>>
>>
>> And we use it here, and in the place fixed by next patch?
>>
>> I think we can fix all in a single patch, the problem here is to call
>> transport_*->get_local_cid() without the lock IIUC.
>
>Do you mean:
>
> bool vsock_find_cid(unsigned int cid)
> {
>-       if (transport_g2h && cid == transport_g2h->get_local_cid())
>+       if (transport_g2h && cid == vsock_get_local_cid())
>                return true;
>
>?

Nope, I meant:

  bool vsock_find_cid(unsigned int cid)
  {
-       if (transport_g2h && cid == transport_g2h->get_local_cid())
-               return true;
-
-       if (transport_h2g && cid == VMADDR_CID_HOST)
+       if (cid == vsock_get_local_cid())
                 return true;

         if (transport_local && cid == VMADDR_CID_LOCAL)

But now I'm thinking if we should also include `transport_local` in the 
new `vsock_get_local_cid()`.

I think that will fix an issue when calling 
IOCTL_VM_SOCKETS_GET_LOCAL_CID and only vsock-loopback kernel module is 
loaded, so maybe we can do 2 patches:

1. fix IOCTL_VM_SOCKETS_GET_LOCAL_CID to check also `transport_local`
    Fixes: 0e12190578d0 ("vsock: add local transport support in the vsock core")

2. move that code in vsock_get_local_cid() with proper locking and use 
it also in vsock_find_cid()

WDYT?

Thanks,
Stefano

