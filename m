Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F077C41B347
	for <virtualization@lists.linux.dev>; Wed, 13 May 2026 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778675656; cv=none; b=YpQ+FdkUuanyjXFp3FQQJrC+3ImmBgtQvyqGETmW1R1PkdoZzHJ0tbA2Ro8Yl0JdSdO225reUMOW+5kb0xniIH3HSZFazEzr3G/ApKagpTCplb3T4MP+DNr1mx3pGSBFfts4Nqf/m22ttFgxb13uUQBRW9a06rTaLyO8CtaBYxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778675656; c=relaxed/simple;
	bh=NL+0hN7dcmk6reTk4fWsx9HcPciA4cyloazqc/q7UAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iCdoiEtPxipbH/aiO9Fuhi2eTxAc/X7+W1YsgvToO46Gt9mwbZ42X/ZlXP8ge/1aixMauxAuKPNqfkIV63RVi1z++2EmkGj7aGjm54nkx1VHKhkncaVRb3k/OW1R/OuSVP58LgMZNTfTRJAsqeeax7q6DtcdC6iiMlpzc2icMmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NZgUfnll; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZgUfnll"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778675654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+TQYbXlymtDPWPBG8UfeNdlqdxdWRntP15VStFgg3bs=;
	b=NZgUfnllXqdzhKuDTvmUY1nGvIyiCfYuAq62wW4LeLUWrCnFeAqEC+JH/4EiomVHAgQxZO
	w7y8WLVWYG/b1zkEAHaPJpA+0vBrW73aDtdO2YLZ0QOBDXTv/nuGD2wC6Y5TOjasrYxgsK
	zouOPZRQakDd09ddF4vi2slAm6lz1M8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-wvZRXz9oPyO-Ev8Tg8NL-Q-1; Wed, 13 May 2026 08:34:10 -0400
X-MC-Unique: wvZRXz9oPyO-Ev8Tg8NL-Q-1
X-Mimecast-MFC-AGG-ID: wvZRXz9oPyO-Ev8Tg8NL-Q_1778675649
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-441243ba35fso5323871f8f.0
        for <virtualization@lists.linux.dev>; Wed, 13 May 2026 05:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778675649; x=1779280449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+TQYbXlymtDPWPBG8UfeNdlqdxdWRntP15VStFgg3bs=;
        b=oeTVDHHrIFDseNnk8QSjIyrPRrplSEH9v/JItzI+sNzKj6VPG1qyYlSrLHkLFbjmxH
         9jAwnBEXYZc62YX5OelxZn5x+5NF1h2EI5etmimKHWgYvgYcYU+Vz9YWrShPL/wQuREz
         mquDKuO2P3g704xg8E9fwzBGpyHCJJ8PNGyIFDKb942ux4cgXsx9nwykfYcjj4mbeNxJ
         14WiZpM0P9w2gCNRY8Aw0+5HSyOD4JmoKaPtabtWnci71w5J6O0JO4bNMUUWGchXp3nX
         5Gn9rN3cpjXXUUynL0U5skJYQWOqeQApiMeMdRm8xClC7tK6B5KMlYDmbKDs23jiRUh3
         gVtw==
X-Forwarded-Encrypted: i=1; AFNElJ8Qf0Gw6MJ1NNlCBzCPL8Sp2u+CIqo1cN3NgeJiAzbgok62mcVM1Pxlfbo32CQIlTVPL7ASa0MQUtst9x1cww==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHtGeTo5XQraILbECJn//nS6Wn4fiI/tPPqutDlNB5Su/P6M1n
	03pdBfUabCo2hFQYKc/hdyPqzoVGyFdiJSn2G6FyvuZ4L4Yv0VVAeBoiUqTQXLiWlDBqtp3TAAT
	7Va+GdOlGrzkTj8k4Vi9q0QUz1fGOUarvsx/h+LLxUE8TOMPr5WAM3QaQo5i1yUl4qzQp
X-Gm-Gg: Acq92OE2Uz9cIFq1up6xcJceZAd8DEdykLycw5Px+ZMiBH1NcLvOP0yBCiN7M27pl5O
	wtYph3uPUvnyYjfDRBr15sZPYpOU4Eq7sBRObpsezPvfACnIeLnhl1GHFkJOFTNJx0NCwEBfG1g
	oQMe5j6u3moHtDdnIRmpBqcARLlsMaP5HPU3M0GjsTR9YTqoQEYDK+ZSHFxJeM5OK2sAcZ6Yrzt
	ERy666u+uJAvB0/E4VwQsE+a/Iln5JA3ms31uuavXfw2w/NZsAL9BDmvibM5P8xCW6svs2oy1w+
	i4nJEJihZWcsQwsUxSa+x3qX75SBqiFe7n0HbfiUQKrJ3FNtI/CfxctX9yMpbjxuK/KQrtHPGrY
	aWM+SwaxRpkLepmnfFVKAC/97qtJ1Flm+wIAwaOGx
X-Received: by 2002:a5d:5d87:0:b0:441:1c18:f779 with SMTP id ffacd0b85a97d-45c59cce4demr5115648f8f.37.1778675649240;
        Wed, 13 May 2026 05:34:09 -0700 (PDT)
X-Received: by 2002:a5d:5d87:0:b0:441:1c18:f779 with SMTP id ffacd0b85a97d-45c59cce4demr5115580f8f.37.1778675648751;
        Wed, 13 May 2026 05:34:08 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6c221sm41530491f8f.13.2026.05.13.05.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 05:34:08 -0700 (PDT)
Date: Wed, 13 May 2026 08:34:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jinhui Guo <guojinhui.liam@bytedance.com>
Cc: David Laight <david.laight.linux@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH] virtio_pci_modern: Use GFP_ATOMIC with spin_lock_irqsave
 held in virtqueue_exec_admin_cmd()
Message-ID: <20260513083332-mutt-send-email-mst@kernel.org>
References: <20260413101759.6323fb68@pumpkin>
 <20260413122244.534-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260413122244.534-1-guojinhui.liam@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mIxDySvqCdPYRaDfSeq5WIwnAHvRgDuo01OsyBgO9zU_1778675649
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 13, 2026 at 08:22:44PM +0800, Jinhui Guo wrote:
> On Mon, Apr 13, 2026 at 10:17:59 +0100, David Laight wrote:
> > Or do the allocate before acquiring the lock (and free it not used
> > in the error path).
> 
> Hi David,
> 
> Thanks for the suggestion.
> 
> Pre-allocating the memory outside the lock is indeed a good practice,
> but unfortunately it doesn't work in this specific virtqueue context.
> 
> The kmalloc() in question is not happening at the virtqueue_exec_admin_cmd()
> level. Instead, it is deeply embedded inside virtqueue_add_sgs()
> (specifically, in functions like alloc_indirect_split() or
> virtqueue_add_indirect_packed()) to allocate indirect descriptors when
> multiple SG elements are provided.
> 
> As a caller, we have no mechanism to pre-allocate this indirect descriptor
> memory and pass it down to virtqueue_add_sgs(). Furthermore, virtqueue_add_sgs()
> needs to atomically check the queue's num_free status, allocate the indirect
> table if necessary, and update the queue pointers. All these operations
> must be protected by admin_vq->lock to prevent concurrent admin command
> submissions from corrupting the virtqueue state.
> 
> Therefore, allocating before acquiring the lock isn't feasible here, and
> replacing GFP_KERNEL with GFP_ATOMIC (with a proper sleepable retry upon
> failure) seems to be the more viable fix.
> 
> Does this make sense?
> 
> Thanks,
> Jinhui

it might be quite ok. what is missing is the analysis of whether we
can actually get this error and what happens then.

