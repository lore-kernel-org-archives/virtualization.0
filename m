Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E02643E06F
	for <virtualization@lists.linux.dev>; Thu, 16 Jul 2026 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784223193; cv=none; b=iu9nJ9QQDPInZhAVIWYZS9PxtTdBoqnvWrp5ONgAh6TDsrGrR6i78Z+KGyxb3x/B6GJajk5dq6XOUOPalhqWiNZM1PgKmCbnwwiVhqk60Pd5uQTIFHu1V+NTQBmoFBSEw6FLkt+bMXDddvPAKqJOd3QfHK+r39+JpQkBE+3CHv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784223193; c=relaxed/simple;
	bh=14Cq1umL0Y6RBF2SkI1K9PaiHWJyUXEl/l/NTRstlkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNA0LJRahmekR8RGuhBsh3vFq07nr8MOWNMHDfuRQYHITuL4akMlYaYBlmFY2oLIqs5jB1rHJsjZKE1X1e6Vdnj3v2K1S4ESnvyPr8rQEvF77jeiWPSAlvVMUISpwhHHTzAJ7gVovYSVSBPvaxt+fVkbO5PK2dAfgwPgd01XKCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sSUSQJzw; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sSUSQJzw"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so3163427a12.3
        for <virtualization@lists.linux.dev>; Thu, 16 Jul 2026 10:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784223188; x=1784827988; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-description:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xrxnv9tUHFGYCrkcPFQu3jVeHPBv/ZazS8X/HiiUaCM=;
        b=sSUSQJzw6Fh/yuRVAk/vY8a5XEcJzccl+91aw+g9NSLfUPLgC6n81VTwo7gpGLZdeW
         2i8Ks98N6m/O696Y0dX6s/tnmox0GQ0oArW9MEb5FVqD7FLKg/Ww5JuVrxehRtaE8NFg
         8DL0kRFuogp9N1FYIsCmckQKKdaouMe44fA6F6M0VyDQa5XmmWJT2FvE9rAyX/+f7o3t
         FEmLKw5LwneWYyyvu1pNI3sscoK/dJyouLD3o/fTcKsovDihcWGfaEy8WAeOePJiOMEe
         U37IgWROeK4xiFdCoWgpvNsu+086atXRC44olsd0VAfU2WPZgYCi8iQ5f6hRoH+98429
         3KPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784223188; x=1784827988;
        h=in-reply-to:content-disposition:content-description:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xrxnv9tUHFGYCrkcPFQu3jVeHPBv/ZazS8X/HiiUaCM=;
        b=GshsXwKW/3nYejz1ZtJfshsEJyHddqaT2Uw+DZJgp0KmKWeMkmBkAEnEi9yed85t4T
         PDnqHMpW+MMtwoMWbnxg3rEipvJg9buecH02IVI3KXedom36wd3eRnDSRw480nt+7Jti
         E0+Bt/EDaMYGXG5QAolXY5NZy4RUm0OOirt0LitaR75SiGPmWgS61Le3I1w4BoumIkb8
         8olJ+80rnt85+vjSqhatbv7gF1+mo+d8FpMM+Ls8KBqma+RH+RyRw2OaYLbNSL4RKAUT
         xb3hc6onQw+KC7aPwrRUtxewAsTbjByoMaaXg0iOP6A23D9j0YeFw6J1p3bBkbaTtqp1
         JrMA==
X-Forwarded-Encrypted: i=1; AHgh+RoBUzxy3vXIAcwF+3pWG5tkToQUIAf/KWoi2w0fSYNRae+2o17ZBq+r94oCWFA4fziEkMV/nqi2s0A1W8fGWA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQLmSZRVV31OLqyo2+IT+3RkN0+1YaGWD6SmB4xSKVXhNDjdly
	GcjnSNXUU3OkopzwagMYTFXJNtFl4hAtGp5UEddWZLQfL03hxJqXpXw9
X-Gm-Gg: AfdE7clwFA850WenIKoOvjAEeFjSXbjzYPelKBy0MeW1p2+USXkU04Q6k0de/Lbmu1T
	Ww3qc9b/SEeSvGUk28s5fhhH2Ivm74FFx7fVpe6JrGm2QUaT2JSXVLE6Ks4NjCABGneDiekgiLF
	wLDEWv+XHmen678uRlmJCN4tqtZsXtgX4PiIVCuZSQ1sTbiNfUtvQcJzqeJykwTfTONqsjfCGBW
	wtdBoFn2ZcKQc803aWnFkqD+G74rS037sy1FOWPT5b8md+l/Ipfu83PFaiOydB73gIs10lx77RL
	J9h1cXrVPCWOv/eyIzW6JmphSpIRweGKvWB0uAEA5VeDe9hgbwX7GOqUnb9iPOG1YBD9n44O9/4
	2ke3U5RMGEjAZ+5UU2jBU3Iy+94UGYuP8dPZ1K+PBwMpfmdovRww66vT+YK1iiLIkJ/rT8ZozAc
	bUpHxbEejzCOr1SNLgU6rSOYt0Z1oNOsUlmzZPr1zU3zU=
X-Received: by 2002:a05:6a20:244f:b0:3c3:9557:3b56 with SMTP id adf61e73a8af0-3c3a5e12181mr84522637.72.1784223188091;
        Thu, 16 Jul 2026 10:33:08 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:38ea:b937:53f6:928c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd4284a92sm10258037c88.4.2026.07.16.10.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 10:33:07 -0700 (PDT)
Date: Thu, 16 Jul 2026 10:33:04 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hari Mishal <harimishal1@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Amit Shah <amit@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	David Hildenbrand <david@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 2/4] virtio_input: validate device-reported multitouch
 slot count
Message-ID: <alkU66ViqO8pnjQQ@google.com>
References: <20260715142337.22811-1-harimishal1@gmail.com>
 <20260715142337.22811-3-harimishal1@gmail.com>
 <20260715115018-mutt-send-email-mst@kernel.org>
 <CAMmC+=AnE-p7B=DbBPYeNzJdcdiBf7q=5bfcuV0VQrPRK+pmug@mail.gmail.com>
 <20260715120911-mutt-send-email-mst@kernel.org>
 <alfPcWKMGL-S9BRl@google.com>
 <CAMmC+=DXS=xs0CZyf+N-71NT8D51xQYatBv=dfVQC1aBohDdmA@mail.gmail.com>
 <alkTnRb9qhgcMGGi@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: avid@kernel.org>, Henrik Rydberg =?utf-8?Q?=3Crydberg?=
	=?utf-8?Q?=40bitmath=2Eorg=3E=2C__Xuan_Zhuo_=3Cxuanzhuo=40linux=2Ealibaba?=
	=?utf-8?B?LmNvbT4sIEV1Z2VuaW8gUMOpcmV6?= <eperezma@redhat.com>,   
Content-Disposition: inline
In-Reply-To: <alkTnRb9qhgcMGGi@google.com>

[ Just realized that CC was dropped in the email I was replying to, so
  restoring and resending... ]

On Thu, Jul 16, 2026 at 10:28:36AM -0700, Dmitry Torokhov wrote:
> On Thu, Jul 16, 2026 at 12:34:57PM +0200, Hari Mishal wrote:
> > > What is the failure mode if we keep the ABS_MT_SLOT capability? Does the
> > > kernel crash? And if this can cause crash then we should fix
> > > input_mt_init_slots() to reject requests for 0 slots with -EINVAL.
> > >
> > 
> > No, it doesn't crash. I think every place in the input core that touches
> > dev->mt guards against it being NULL: input_handle_abs_event() and
> > the mt_slots check in input.c, and evdev's EVIOCGMTSLOTS ioctl
> > handler all explicitly check for NULL and degrade cleanly instead of
> > dereferencing. From my understanding, the worst case is what the
> > original commit message already covers: the device advertises
> > multitouch support it can't back.
> 
> So what? I still do not see the problem. Let's say I have a device that
> properly supports multitouch and has slots, but then never sends any
> events because firmware is buggy. How would that affect anything?
> 
> If there is no crash that I would leave the driver alone.
> 
> And we need to remember that we are dealing with a hypervisor here that
> normally had higher level of trust than the VM. If it messes up we do
> not have to clean up after it. This scenario is different from user
> attaching a malicious USB device to their system and getting owned.
> 
> Thanks.
> 

-- 
Dmitry
