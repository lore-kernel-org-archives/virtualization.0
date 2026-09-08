Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D8747279F
	for <virtualization@lists.linux.dev>; Tue,  8 Sep 2026 08:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788856361; cv=none; b=OSXJHK7F+4MQEHDSaVIsKnluuEcXYS37NM3JzWH452ODALNBvzrVgCNrpLPVXE6sSML2/jqrjtDor3cQkRfpuofgdWSTBsb/5+I8qMxwdT6inBn96j/cfOZVDPBnkTDt8YWdisUKbkmKv5o7YXSFEolqYP/ffqBDOkvRdsrKVd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788856361; c=relaxed/simple;
	bh=X0LXiwd5Oi4KUYVcotrSCSQyQDEPeZH2ej0WcHSUWuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=s6AcNUrhkvRYiQavvbTIdbDc8ZWCg2qd3IcnwsOhDGNpOmdRbqGQp4780R5VMswX23MlgiT9apNVSuWupNklIg8gDdTsrdeQaVIqALYkbXIBVsdQ7Ejh0liH3T73UsI+jNzLvb2n4E3vDHOAvuKNsoFb2rOnrjeqqHYZ6oMRa/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IN8wbQe2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IN8wbQe2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788856359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bTs3CS9GCivYiUD3IVJLDYldRClQ2qkZlouxGAVv56E=;
	b=IN8wbQe2Hmh3C5ITCgGOXYjTf5gb5PFJySXkxPbyxTCX+5J6VfLCabaP0PmG7dywPfoQqi
	V1mv8XaIFOntMgQPhsaZLro3ZexAF5KK8LmEDKGucHa83JLwWaGrmZX6TpknnSy9wqnNg/
	ZLMqOWJShdcHk3nx2yKSbgYHo/WuS4o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-VdAVnovbPyWuml7iElQD5w-1; Tue, 08 Sep 2026 04:32:38 -0400
X-MC-Unique: VdAVnovbPyWuml7iElQD5w-1
X-Mimecast-MFC-AGG-ID: VdAVnovbPyWuml7iElQD5w_1788856357
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-482ea386bf6so1884228f8f.1
        for <virtualization@lists.linux.dev>; Tue, 08 Sep 2026 01:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788856357; x=1789461157;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bTs3CS9GCivYiUD3IVJLDYldRClQ2qkZlouxGAVv56E=;
        b=dorlaRr1RVgFlszxGWldpI3EqyYaEXl2n5CRu44+MiP77T/Mx7wW0gMa+KsnyBdfcv
         exO+uAaO8EneHmq+gvLgGxg9NfnyqV/0ezTQd+fPUIk29eKxs8GC5cAoMbYUmPq+dTQJ
         2IclwLHW5rd5CEBgS2030B3jn/IzqnqBtQjXYhX2zSiUmLi0oqVpQgwyZDsZRWdJdTK2
         6qRlxjyUz+zs90DRFjGhsy+nl3Zs7Ab+lQUMDW6NfzF+JFe7P0uutc8MhoVvUbt5T6F3
         g1YeN6oxcBdy6Ngrirxx+jnS6OcplWZfaA3j0Bd+CIOyZy2M7Kwsz+0mC5HNmGmNTvZ8
         tpgA==
X-Forwarded-Encrypted: i=1; AKwUvBzoJgnDhucOn/qyCw/fLMWUamxz+/z7u9sZDekNi3RxyLW1sJOMyTKdiCgbbB1m1JcwY5jaGL9rd/Pv77SRiQ==@lists.linux.dev
X-Gm-Message-State: AFuF++mohNKDemRrvDfAcpSCTRk7Gu2s9HoKxqyCA+n55m3Z3eMS8Uo5
	juVdhGj+ot4kuUR5aAz4H0k6hP5Vzm54dz088B3D0dgUW1rEpF9tD3qtoGMOVmmgO+Wp+Y9AI0s
	PAi95rxWUHYXl02sEOzNQIq3kgcjK7tg5lLFdoPrjLso55GfZC6k3j55NMY33A9l/VLBQ
X-Gm-Gg: AYBFou2rz8fENfL7BmtudZ4Q5xtxg1GKLZSjKKMh0sVfPQumCgpO3sb3ru+tY9iGJrF
	cAaRRa8TaYYH0xSkkeFUUzkWQFAx4rCYNj2Sqw9NVzhtahVfTEAXJgeOb8V5OypGrLPdplMlyrA
	M/e6fd6sv3fdJRaCH06s6xtmMl+wkkLzF0tTaIBHpKQpF3l9OpO/ONNy5y8ofmYpd3E9qmthwTM
	siw8eIJj1lAY2CIlh/Bt+G18XdMRToPUr9hkN1E9boCrAZMM67BLCshMxjq7eBDwM5ovZSXLoox
	8OOuKXThKZoF8sjRzffGPDYApHB5kCwRV50yN6tSWsimr/ozq7VNQLCjgfD/b6QIOAO9kH3UNcD
	58SJdy7eNoj8Ud4eJxWbifGY=
X-Received: by 2002:a05:6000:4302:b0:485:96ac:5a96 with SMTP id ffacd0b85a97d-48596ac5acbmr31640619f8f.16.1788856356716;
        Tue, 08 Sep 2026 01:32:36 -0700 (PDT)
X-Received: by 2002:a05:6000:4302:b0:485:96ac:5a96 with SMTP id ffacd0b85a97d-48596ac5acbmr31640474f8f.16.1788856356160;
        Tue, 08 Sep 2026 01:32:36 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c5bc5sm37007020f8f.24.2026.09.08.01.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 01:32:35 -0700 (PDT)
Date: Tue, 8 Sep 2026 04:32:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linfeng Sun <linfeng.sun.dev@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vduse: return compat ioctl results directly
Message-ID: <20260908043143-mutt-send-email-mst@kernel.org>
References: <20260908-fix-vduse_dev_compat_ioctl-v1-1-62264d9bfb8d@gmail.com>
 <20260908035646-mutt-send-email-mst@kernel.org>
 <ea3ba5cc-ae68-4c1d-a3a9-c2840a1cb9e7@app.fastmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ea3ba5cc-ae68-4c1d-a3a9-c2840a1cb9e7@app.fastmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VGbsYSYhKXTz8k1xPPhw9HJ7EWjZXiYQH0Av0ONVg7U_1788856357
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 08, 2026 at 10:08:46AM +0200, Arnd Bergmann wrote:
> On Tue, Sep 8, 2026, at 09:57, Michael S. Tsirkin wrote:
> > On Tue, Sep 08, 2026 at 03:31:51PM +0800, Linfeng Sun wrote:
> >> The compat handler handles VDUSE_IOTLB_GET_FD and VDUSE_VQ_GET_INFO, but
> >> then calls the native handler. Their different command sizes make native
> >> dispatch return -ENOIOCTLCMD.
> >> 
> >> For GET_FD, this overwrites receive_fd()'s return value after the
> >> descriptor is installed, leaking one fd per call. Return handled compat
> >> results directly and use native dispatch only for other commands.
> >> 
> >> Fixes: 455a2a1af926 ("vduse: fix compat handling for VDUSE_IOTLB_GET_FD/VDUSE_VQ_GET_INFO")
> >> Signed-off-by: Linfeng Sun <linfeng.sun.dev@gmail.com>
> >
> > indeed, I will apply.
> 
> The fix looks correct to me, thanks!
> 
> > But ... how was the original patch working then? Arnd, what gives?
> 
> It looks I either broke it during refactoring from two functions
> into one, or I just didn't do it right in the first place.
> 
> I did write in the extra patch text
> 
> | The code is directly copied from the native ioctl handler, but I
> | did not test this with actual x86-32 userspace, so please review
> | carefully.
> 
> but obviously should have caught this one myself since it is a much
> less subtle bug than the one I was trying to fix in the first place.
> 
>       Arnd

Should teach me not to apply untested code. No amount of
careful review replaces testing)

-- 
MST

