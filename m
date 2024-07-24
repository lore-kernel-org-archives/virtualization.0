Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6182A15F3F9
	for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721841730; cv=none; b=ivTmStbJRshi6yhQwUgTI++19hkTGF7G9ePPG3PVNznpKo4nALl0xiTrciB5SqcWERCq2Kh6cnReeDBYrrJi9ahDwuAEatBTdskU9rbBuFCHt1zx9rliu/4MpHPA11dKYPQc1C1UjfVPG/M2hg0uGCcMf6D5QWuFGONRss+rSAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721841730; c=relaxed/simple;
	bh=e35cdCpA4LhllwkRXD5p+aA3bbV183QGT1UYMqTKgFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5INK9cC4mxDLccXcYAABmBIk2Ny0dOwdOP7+2GQVkAREdPTd0GlCFo5y8xLZk4tSHT+br7hVES0M9L7GtyurgLldyH97bekohK096vQ7bDNhDnfjCQytRws3yX+D71Xv8l0SVo8Y36SboiHsccyXTW9yj4YJqhrRlwHOLTraGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYnGZ3BO; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYnGZ3BO"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4f6ba99286cso29976e0c.0
        for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 10:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721841728; x=1722446528; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e35cdCpA4LhllwkRXD5p+aA3bbV183QGT1UYMqTKgFE=;
        b=VYnGZ3BOPvwxLwA0VQ7u1cL8IMPp4KNQUhab+b7yI5sGLN5Uhp1rkwRiGPYkoxYjv1
         n54S2rDT17aJWx4V+2xIq6pdYX+Kxuin6kln9Ok6edxCrx4QPD2QySdu/1hx/ZO+sP4D
         5d5Hzi3ey+0PJhgZUcHxyPRyGvjvXG5y63jApI34xPqR5g7B6lvhcdYTI7V5jJG0qhiW
         J7Kk8W5NXOPbNdeLdMu/HciUZejcOrQQUuF2mUpgUeHSIfliw3jX6mqR6Lxv22ZeJ5ij
         pTKXRYZKScSYeKXjsCBhBXEvgG9TI5qREpJ2ON64ieRy7jkCaaCRR+wIadibY3PSZ4ec
         o+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721841728; x=1722446528;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e35cdCpA4LhllwkRXD5p+aA3bbV183QGT1UYMqTKgFE=;
        b=YXXmNFeVBYFRNJf8FBqGj+DxH/KE4ybQRBlm/mTosu2slQScSD7hETwsEK262QgRRY
         aj1j2iheUn7xmg86R/bUCar100XA2dM4T+bdvghjwtW7UgtCyIJgmRy4QHBkhocR1zOa
         N7LEd0FdnudSP75wStOnbmckWnEv19SO78AwT766hstHSN80mYw+qHQm7b4C6ttPSWrR
         GCir5z2v31BZRR9fopqEK8l+Olp2Gdd+PSZUwkRkt5rUUBzQeGI1dSrvwXqx6xFY6uru
         1UIYFNdVgoWqzyeW11zDTpxDg/f+ztN7LiD8gD7upvQViT7jM9xac2/Qrsz5+EsJJO+e
         mkqQ==
X-Gm-Message-State: AOJu0Yw5HhdBpu4Lwu48Bdq2Pti5Q83LrotICyF3Y2OunlNdTqnla781
	v4Uxu/lxKoCwT3EgHCFnrCNjLCLOL3A9sY8pV2SozkOOHI1B1ovO4xwCtU8P
X-Google-Smtp-Source: AGHT+IF2wlbj0hbtsXUkX19eiRW0M+qL9pXHP+SqFN0vxnGvT6lFsOto7WjkirQvBy6EVRCjGy3vQg==
X-Received: by 2002:a05:6122:3b14:b0:4f6:b478:767c with SMTP id 71dfb90a1353d-4f6c5d889dfmr562614e0c.6.1721841727951;
        Wed, 24 Jul 2024 10:22:07 -0700 (PDT)
Received: from fedora ([2800:e6:4000:47e:7c52:7bd4:cfe5:9874])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f51f9aa7b9sm1922643e0c.44.2024.07.24.10.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 10:22:07 -0700 (PDT)
Date: Wed, 24 Jul 2024 12:22:07 -0500
From: Juan =?iso-8859-1?Q?Jos=E9?= Arboleda <soyjuanarbol@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev
Subject: Re: [PATCH] virtio: Fix various coding style issues
Message-ID: <ZqE4P1EjiLI9iQj-@fedora>
References: <Zpn9t5xJCPMhvpZO@fedora>
 <CAJaqyWfU0th74hJ3Vww6QXqewvSyOobgogT=Vt57M+HqaTZ0ig@mail.gmail.com>
 <20240719140906-mutt-send-email-mst@kernel.org>
 <ZpromZpQ7ajhEJHB@fedora>
 <20240724100022-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240724100022-mutt-send-email-mst@kernel.org>

> Makes backports harder for little gain.
> Code gets tweaked naturally as someone works on it.

I understand your concern about backports. However, this patch only updates
the coding style to match kernel-wide standards without altering behavior.
Consistent style improves readability and maintainability without impacting
functionality, thus not complicating backports.

Thank you for considering this.

Best,
- Juan José
