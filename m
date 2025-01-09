Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A9C214816
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 07:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736408616; cv=none; b=WaOsZQWewUGhSxw7lS5I0YlEdh+6/LAzcLUsTIIHTOCAvv49rpk2YcptTzhT8bIo6UYD9vVTd9uR/OaGW0F/xITLd9aOm+7czxN9fn5yJVm6wcApqGMrqJ2O1EHEWXmRS2jBWMEiBhzHpVKtnPLygRJYY+RMN71UTWLBmuENLPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736408616; c=relaxed/simple;
	bh=jsaMuSUGwo+RJxj4wQLWlpqmbzwxs+PjsUjLgqIv9aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cF0hrCdXGUK9iiUtx5L7r//DRj3jRMKHGVKGPVocnlPwmycHvPKq6FfAcSYb/Qk4ba+nuLHR3wBVq3yVgVx8oagzxi1FR4J5pPdkqoT10BA39PcIbiM3bO8wfaH3XyFviRlFv3Oi9Tdq4jvOmvRDtVDi61aldO8110esmNIGLlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dqwrd5kW; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqwrd5kW"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A1C8280E39
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 07:43:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RYaF5cY1Sn6e for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jan 2025 07:43:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org CB06B80E1E
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CB06B80E1E
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dqwrd5kW
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CB06B80E1E
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 07:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736408612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x3MkaKicJuTxKB4Uwx+L5vUrVj7eiLsn1FE86R/YDhg=;
	b=dqwrd5kWzHf+pWTOpScn/Jt0o+KoeUicgs3oas3PovDJhh18bW9Cn3FrOa9SXJUd5QlfHv
	P5kpscUuL3lldqShAQNhfCs85wRhUpzdKmyCgCYRtP5yJBXzBiWaG7/HefAUv/fC/voaU7
	jLd7kKkiAvkcdYnzNyk5xleOE/8/CVo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-eFpd5KAhN9SG69ARfZ7DOw-1; Thu, 09 Jan 2025 02:43:31 -0500
X-MC-Unique: eFpd5KAhN9SG69ARfZ7DOw-1
X-Mimecast-MFC-AGG-ID: eFpd5KAhN9SG69ARfZ7DOw
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5d40c0c728aso409814a12.2
        for <virtualization@lists.linux-foundation.org>; Wed, 08 Jan 2025 23:43:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736408610; x=1737013410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3MkaKicJuTxKB4Uwx+L5vUrVj7eiLsn1FE86R/YDhg=;
        b=dOKSN1rrmuaE2IAHX+5QH7RRPo+WzdM/UwCu/FYjC1OvwKPFk/ylWHecfqwRcjcHXv
         TI/fm7XDF4eVovUfzzl4aFgA2nafVmTWi0PQ4NwIJ6tDrb+cfvxWm/M5D+6DFw3YqN/g
         dw4mgan8xvk2+pdgiC20Gv+roJYaRjQKqVYlHshLjbpml4Zyu5mAOQwDSDTE1cXgnXQt
         zqKHj5TXQKmwMQWfDRxLbsaZI4pcJ+O1RV2yI1rna531CzohvuKhOZ5zdE6yx4YotOZe
         hu/5j3tQdtCR4Mqu8fDXqorOUCX+gYCsOC+Aq0UVshrsGCRSahkTxHN5Rs0kEca3thYe
         A1bA==
X-Forwarded-Encrypted: i=1; AJvYcCUMgDFxFSj+PZeCOMRAr/kTuwxYr92YE1jrl2sgKMeEgk7zWjVbzyOcc3rZGmAFjhOoa0eYjRbkK2yOpDNIjQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyARFlRDngoSbpMKb7JCE+2TQQwXWl3t1bECej5o5MPlnRwBYKF
	b3lh8NVoiwBd++MKvyAFmsuXbzrhZ03Ch40SHoKZBUdMvhRj/15Ow+bJ8F2PfwcAAsad91L2R50
	XdklVQuZWQBFX77AmhGU/Ju+R8G2W5J9G5mj+FJKiN5E7mCYimMCKGWcvpW0RtRSw+7ThJI026l
	7vHUc=
X-Gm-Gg: ASbGncvRT/INV/lFfxfeaXigmmcGLQOmYgKhAh+ydjMMEo7k+vJA/l4gSOzDHvt/ZmK
	NNTEMBfJzCk56FX6+xQPRiswl5YjwiLTNieOIGiMitqJROuiv3WWh2V/TWF9mLqDV0xj9cyWuA0
	9WjGeynin/qGHS7K2AXc/w6EgOnux8aAYciy2M2UMZ4MYH6XmEeosQvxCVITPCDnmdoCXPp6Xe+
	k93sDJqsDQqWLrW5+FfXLxu2QprAqM02SHPnYYqx+m2hKlcmDw=
X-Received: by 2002:a05:6402:4415:b0:5d0:abb8:7a3 with SMTP id 4fb4d7f45d1cf-5d972e000c5mr13006300a12.6.1736408609812;
        Wed, 08 Jan 2025 23:43:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYt/wbH0uxT4gdtapB81xUXkFqeKr4f1zw0epCAPN6UFsJyXpBp3gKNbdqX6u30o9JHhMZqQ==
X-Received: by 2002:a05:6402:4415:b0:5d0:abb8:7a3 with SMTP id 4fb4d7f45d1cf-5d972e000c5mr13006223a12.6.1736408609409;
        Wed, 08 Jan 2025 23:43:29 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9563b06sm42928566b.100.2025.01.08.23.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 23:43:28 -0800 (PST)
Date: Thu, 9 Jan 2025 02:43:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	gur.stavi@huawei.com, devel@daynix.com
Subject: Re: [PATCH v2 2/3] tun: Pad virtio header with zero
Message-ID: <20250109024247-mutt-send-email-mst@kernel.org>
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-2-388d7d5a287a@daynix.com>
 <20250109023056-mutt-send-email-mst@kernel.org>
 <571a2d61-5fbe-4e49-b4d1-6bf0c7604a57@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <571a2d61-5fbe-4e49-b4d1-6bf0c7604a57@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: siG5i-q_9MwA07sh3UYRGqZTTbW5E_eCEtaPLy8gMfs_1736408610
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 09, 2025 at 04:41:50PM +0900, Akihiko Odaki wrote:
> On 2025/01/09 16:31, Michael S. Tsirkin wrote:
> > On Thu, Jan 09, 2025 at 03:58:44PM +0900, Akihiko Odaki wrote:
> > > tun used to simply advance iov_iter when it needs to pad virtio header,
> > > which leaves the garbage in the buffer as is. This is especially
> > > problematic when tun starts to allow enabling the hash reporting
> > > feature; even if the feature is enabled, the packet may lack a hash
> > > value and may contain a hole in the virtio header because the packet
> > > arrived before the feature gets enabled or does not contain the
> > > header fields to be hashed. If the hole is not filled with zero, it is
> > > impossible to tell if the packet lacks a hash value.
> > > 
> > > In theory, a user of tun can fill the buffer with zero before calling
> > > read() to avoid such a problem, but leaving the garbage in the buffer is
> > > awkward anyway so fill the buffer in tun.
> > > 
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > 
> > But if the user did it, you have just overwritten his value,
> > did you not?
> 
> Yes. but that means the user expects some part of buffer is not filled after
> read() or recvmsg(). I'm a bit worried that not filling the buffer may break
> assumptions others (especially the filesystem and socket infrastructures in
> the kernel) may have.
> 
> If we are really confident that it will not cause problems, this behavior
> can be opt-in based on a flag or we can just write some documentation
> warning userspace programmers to initialize the buffer.

It's been like this for years, I'd say we wait until we know there's a problem?

> > 
> > > ---
> > >   drivers/net/tun_vnet.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/tun_vnet.c b/drivers/net/tun_vnet.c
> > > index fe842df9e9ef..ffb2186facd3 100644
> > > --- a/drivers/net/tun_vnet.c
> > > +++ b/drivers/net/tun_vnet.c
> > > @@ -138,7 +138,8 @@ int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
> > >   	if (copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr))
> > >   		return -EFAULT;
> > > -	iov_iter_advance(iter, sz - sizeof(*hdr));
> > > +	if (iov_iter_zero(sz - sizeof(*hdr), iter) != sz - sizeof(*hdr))
> > > +		return -EFAULT;
> > >   	return 0;
> > >   }
> > > 
> > > -- 
> > > 2.47.1
> > 

