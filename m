Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D47926CE1E
	for <virtualization@lists.linux.dev>; Sat, 16 Aug 2025 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755340587; cv=none; b=jGjrf+TRdBgmCbdJ4/tnw8ip0zr+2iSVU8USogUPqoLqtuDfy36IZVme4u29rsUrdivda2QzUqpps5GZURJDlInYcmwuHncMAMBcThQTP35RanRuvpFtfER1dC+R0+F2oLxZdT9CxPTsyt49YngDp8fL42qTGNdotJKvf5Qs+CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755340587; c=relaxed/simple;
	bh=EYfRYy1z92ajS4ke1U1qfeBzLYzlyxCzubIJ3/OY6bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lzBtB0BxeFeS8ZBvnJ+rYL02omr/3rJJD5U70a45dsNsJ9XRJJwnh/YjIrEgpfipWHc7t8O+KcFpIYcflY5XKVP42aJudSDYOsmOnRQJV/Yy6OwWNqkhpgkPGonuGRwm3zFnCZxwJNDIRbYO2up/cHIc/cYPW7Dtwte+zAJrG6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bddQ7JUF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bddQ7JUF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755340584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u8kpb4zYqo4EMmVx2Xny+4AO4zuhFI4D+a2JoLHbhIs=;
	b=bddQ7JUFQ5QD85Kt9P2FeWLty2Uck6PEqmOpr0fEgFoO+a26T4pqgDwdfjeibAcpj3RCG6
	vEgD80IG0Xv/bNdMAnaeAfhYZATaV7MyotMnnKMmviXrUHKqgW0UUOz08Qrg7VoYpzcAx/
	950FWT6RgcZQTNWdwIM5rU454OaZrVM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-PWYM6LAmP0CnFThWMPg0QA-1; Sat, 16 Aug 2025 06:36:23 -0400
X-MC-Unique: PWYM6LAmP0CnFThWMPg0QA-1
X-Mimecast-MFC-AGG-ID: PWYM6LAmP0CnFThWMPg0QA_1755340582
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b9a3471121so1666433f8f.0
        for <virtualization@lists.linux.dev>; Sat, 16 Aug 2025 03:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755340581; x=1755945381;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u8kpb4zYqo4EMmVx2Xny+4AO4zuhFI4D+a2JoLHbhIs=;
        b=mTIzhWT3aFQ1eEExznYqSDFFYuBtq7OHeFT9dQ71dmUhWWKOlt+76M2ezGfBE0peno
         i0CCgBOp7IYmJ11xVnxw4c/tU0jXt8iBIuSw1IZzWFlIO42Ln8uiOJBHyC6IGo2uRvf7
         hQCBcvsyYIsqedVoNvus8wgu8BJWP5WdxQS/GRTZlzsdEE47Gs59NX6/jlsoPaDLB6Aq
         C77AK3KN0RTxp5xNgOI1NlohM+x5Nu5+u4bfaxDiLaEmqrml/LNTpqhCWsYzMacnvQ9h
         yifOAalNwe5ZdbnABXsdYtybq/3ldSC8k3ljXyQzd+CksMYk0zVWjqMQ3vlESlOSJb/l
         +ppg==
X-Forwarded-Encrypted: i=1; AJvYcCXfEpBK1Pc00Fgj115wCIdS9pW4dbz3YahZgGEmF18Fxhtwtsf3Uh0kHYE2nQEWELW5+NVgeRQo8nXbJOoscw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyh1yyLUba656NAqgqssLmm9gyqS4jn8R0sARZB8ZRPyINiQMhp
	bABgSNGjtytfiS8CKOPhvihphpE4kWOdSxIDAllUPN7t3keV/XB0+CkNOMveIeDH0aTLaSaEoVp
	YFOGp2R9DsE7KNKSbCwr9zXDIfNyeoXrTyxBJUFy56HHOCEFNz0NymzLj3UByrz06TdZHIE+95a
	0/
X-Gm-Gg: ASbGncuBD9XqQRpQPEINk7RzQMSYt3OIIqla3muhkjP7+K0SGFsWv/58njD733hVrYg
	AMNveGP7XTyy2pOLp0aWu6SmDGWVpoSCkAjfcqZm0YdcJMptkRrUgPIrE8MNtxthsMEhvy2kh0S
	PyKW3Fv2PvDBT0mDZesKHJBBIr7TuMdBxhOyooqMLqTW8tYI4FjuE3zYaZRxDlPbkPXIC0nidwD
	FvpEbYVR2wAD9sRm3YLLvC3JfvY5qvHZbzEWC5DhFm7WGbt/rMxAwqq8/JxSU106cfkWA17N9P8
	Q7zVrR8+FUBboVq9J4m14txcGu2FGCJDSSI=
X-Received: by 2002:a05:6000:4310:b0:3a5:8991:64b7 with SMTP id ffacd0b85a97d-3ba5093b77dmr7934612f8f.26.1755340581487;
        Sat, 16 Aug 2025 03:36:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhOaIvnCh51kO1M3yudZ1Zco2KV8bF2xaTDUF4+BRWU8NLMhH+ezyI4LNzBjTWj+A0q+/Xgw==
X-Received: by 2002:a05:6000:4310:b0:3a5:8991:64b7 with SMTP id ffacd0b85a97d-3ba5093b77dmr7934596f8f.26.1755340581068;
        Sat, 16 Aug 2025 03:36:21 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73cf:b700:6c5c:d9e7:553f:9f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb64d307cfsm5181464f8f.18.2025.08.16.03.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 03:36:20 -0700 (PDT)
Date: Sat, 16 Aug 2025 06:36:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alyssa Ross <hi@alyssa.is>
Cc: SamiUddinsami.md.ko@gmail.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Sami Uddin <sami.md.ko@gmail.com>, regressions@lists.linux.dev
Subject: Re: [REGRESSION] virtio: reject shm region if length is zero
Message-ID: <20250816063522-mutt-send-email-mst@kernel.org>
References: <20250511222153.2332-1-sami.md.ko@gmail.com>
 <kgasjsq2s4pshravsinycfihdfjhdts5iz2fox42aejs4xqhce@frurksambnk3>
 <87y0rkie9l.fsf@alyssa.is>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <87y0rkie9l.fsf@alyssa.is>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -_9Z8fWhsJYuy2v0c3GSHIYOzQ1aFcVXnoj4PE3Tbcw_1755340582
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Aug 15, 2025 at 09:19:34PM +0200, Alyssa Ross wrote:
> Alyssa Ross <hi@alyssa.is> writes:
> 
> > On Mon, May 12, 2025 at 07:51:53AM +0930, SamiUddinsami.md.ko@gmail.com wrote:
> >> From: Sami Uddin <sami.md.ko@gmail.com>
> >>
> >> Prevent usage of shared memory regions where the length is zero,
> >> as such configurations are not valid and may lead to unexpected behavior.
> >>
> >> Signed-off-by: Sami Uddin <sami.md.ko@gmail.com>
> >> ---
> >> v3:
> >> - Use idiomatic 'if (!region->len)' as suggested by reviewer
> >> v2:
> >> - Fixed coding style issue: added space after 'if' statement
> >>
> >>  include/linux/virtio_config.h | 2 ++
> >>  1 file changed, 2 insertions(+)
> >
> > Hi, I'm sorry to be the bearer of bad news, but since this patch my VM
> > no longer works.  The system is running wayland-proxy-virtwl[1] inside
> > a crosvm[2] VM, using crosvm's virtio-gpu device to do cross-domain
> > Wayland forwarding.
> >
> > Since this change, wayland-proxy-virtwl crashes with the following log
> > message:
> >
> > 	wl-proxy [WARNING]: Error handling client: Unix.Unix_error(Unix.EINVAL, "DRM_IOCTL_VIRTGPU_RESOURCE_CREATE_BLOB", "")
> >
> > I'm pretty confused by what this change was supposed to do in the first
> > place…  Looking at how virtio_get_shm_region() is used in
> > virtio_gpu_init(), it's called with a pointer to zeroed memory, and then
> > the get_shm_region() implementation is supposed to write to the region,
> > without ever reading from it as far as I can tell.  Why is the initial
> > value of an out parameter being checked at all?  How does this prevent
> > using zero-length shared memory regions?
> >
> > [1]: https://crosvm.dev/
> > [2]: https://github.com/talex5/wayland-proxy-virtwl
> >
> > #regzbot introduced: 206cc44588f72b49ad4d7e21a7472ab2a72a83df
> 
> Okay, just found that it's already been reverted:
> https://lore.kernel.org/all/20250808072533-mutt-send-email-mst@kernel.org/
> 
> Still, I'm confused how this was supposed to fix anything…
> 
> #regzbot fix: Revert "virtio: reject shm region if length is zero"



Are you asking why was the patch applied in the 1st place?
It seemed like an invalid behaviour to me, and I thought it's
not too late to block it so we don't need to support it
down the road.

-- 
MST

