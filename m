Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED99315D2C
	for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 04:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768278095; cv=none; b=mnY3RmmTcOmwaIgpEP/O66tJRdky3UeyRN/KVeu/U8BMDhmGYcHI0rTRut6+8LzU2UUUIlVssyr+PR+iexb6fl6Zlcg36N6pMmdwuB1BkVDW3c5APksvdqd9X8taYrsh2SEQH4DCbXILqNxnqCGkE15F5byWAJJL4hvhF1J0hcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768278095; c=relaxed/simple;
	bh=9z2ygHADRlPRv6GZSQG6Zjqzw6mYA3L1xkaQe+u4lys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbmY6xka/rpgSjmyXJmRk9Q9BEFgs+gwqyoteqFbPuTB+O1q/ZFhJDlUM8M8PJcId5k0jG+vN0NE4oMgia+zG0yUOHDphRpHgWZwJZIqa0KigXq3PYBYtur+u6fkMPe9scaYEfIFl5hXawhI2togZhpzIqWbpykJGWANdb0rdKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUvTDiSl; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUvTDiSl"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6468f0d5b1cso6312180d50.1
        for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 20:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768278093; x=1768882893; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9z2ygHADRlPRv6GZSQG6Zjqzw6mYA3L1xkaQe+u4lys=;
        b=DUvTDiSlI4Xl7omVTb+PgeT1qa5alaT0vee9Qjb4hgAUrGSgtjinfnJBXI1A5zLTVE
         13Oy/En4gxU9AM4/r45cAoQ6kWu1ownGEDr+mtzQVJX32MeOSyK5uoXoL5ywSjrCDYE9
         RQ3ff/2O5n8hUAd9nixymEB/qEyZ2dMXFLkFDtBb80fSALdwmHs6umqcOzYqVXWH0IWj
         iyfGoT8FluH8x8Slv9C6VlG/HBKDYQC/lxbpJC/xtlRreLK4Dii/dmeBymf088MvauN3
         lagowfXcBtZ5vZ58DKqrFgmfPZh6eqxw1VgxedQyVIhXbw4QkVx3oH7ViC9zmiM9fbfb
         JUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768278093; x=1768882893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9z2ygHADRlPRv6GZSQG6Zjqzw6mYA3L1xkaQe+u4lys=;
        b=shCIwvDwiH/t/VWrJJ4/gqAe5/JTR6BZR4TF20XQjJaGVtjx1227APyMBI/gEz9lt2
         uQNF2tIz8vahjy8O1xN/Jv8NwMe/oycjiF/KsLqhiD7xzqY1+2IEFMmzqaaWTBbXNsbi
         HZHpubAwrPUpx9Hk7sflFHAXz2fXo7WDoTyqniucWL/CdyVHhuFNtlS6ZEF+MmvKfhQ8
         wF1mp7UgDpQQyCg+4n0qq5LHH2lyZA4oCtjdx7byWn6s9IaefxqRWuAlAzpiLxxoedI3
         vBnLM8QnP7a9/KJqo6ou6JxOZ3aD8jFXVmX2avniq6BPTAIQ6pC0+InE9+v1uw6a/rcZ
         0LvA==
X-Forwarded-Encrypted: i=1; AJvYcCVL+oCkyjRlvIURrnap/9e+MfCDpNOqbZmF9HuUR8R+FwVTzW9UESDMXmuOl27lJ5pm1EgcfIJ+nW6O27PHzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx49KBM0OPs6gnDYaWyhBTd4nrd2nT99jz/mKtu9jKIV+YwwcHF
	RHjV5xxLFzOf5Lvf8F2N5c3Q54sHK8iS3YlKYQcKAQspUKshu9JiwvCa
X-Gm-Gg: AY/fxX4ib8boXRVXeAFzX14g9rDJ6rj3CkL/Ng1GgSG7ecsfNqM+gJhyi34D/yv/uU2
	0kIa4eC3GnaWE0MF8AG9sw56vYY3SwSVAr4Fx6oSt2J+Lri3z/d9tW8Tmt42ah2Z/ctkxctPZo6
	ImJK0hWAozjkubsMb2rm5zu8A62jCgCvQVKlinyUMUdTkxNcqej0FH9TxA0n9YV3vnZ2IUEnyHR
	1tPTnK1Uc9rgzBfxuoCbI/ewPie5SUzIVLsQ3TRFq27yzhZDn7RBtK64/y8yNpjvnrVuzjSYL+P
	Ug/zV/5mEi1mjhKqA6m+79kC8J2pqL3XEfIRjh8G/reJztGhG1WOpqDaKWMRfzXV9sQexibgeWJ
	kpsTdSxDvwRtszbh5O4R9VaqBw78KKt0wkA9+3dQ1lbeRKMenoZO6z9XOVtk2hp7GvY1rI/UqOC
	yAtSYNjYDqzkYKaS7wXgIsJQuO5jZ1BaocCW6rGlOV
X-Google-Smtp-Source: AGHT+IGGcZLGkIPFIQNjOBHEDejVFdSxvol43+/5acwy+R+srjitlMp64hasZauwcNrOFpf7o0YCkA==
X-Received: by 2002:a05:690e:12c6:b0:641:f5bc:6999 with SMTP id 956f58d0204a3-64716c7a1b8mr16140967d50.85.1768278093158;
        Mon, 12 Jan 2026 20:21:33 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6ac1c4sm76004817b3.45.2026.01.12.20.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 20:21:32 -0800 (PST)
Date: Mon, 12 Jan 2026 20:21:29 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Dust Li <dust.li@linux.alibaba.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Woodhouse <dwmw2@infradead.org>,
	virtualization@lists.linux.dev, Nick Shi <nick.shi@broadcom.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Paolo Abeni <pabeni@redhat.com>, linux-clk@vger.kernel.org
Subject: Re: [RFC] Defining a home/maintenance model for non-NIC PHC devices
 using the /dev/ptpX API
Message-ID: <aWXISRWpkW-oHyUw@hoboy.vegasvil.org>
References: <0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux.alibaba.com>

On Fri, Jan 09, 2026 at 10:56:56AM +0800, Wen Gu wrote:

> Introducing a new clock type or a new userspace API (e.g. /dev/XXX) would
> require widespread userspace changes, duplicated tooling, and long-term
> fragmentation. This RFC is explicitly NOT proposing a new userspace API.

Actually I disagree.

The PHC devices appear to user space as clockid_t.

The API for these works seamlessly and interchangeably with SYS-V clock IDs.

The path that is opened, whether /dev/ptpX or some new /dev/hwclkX etc
is a trivial detail that adds no burden to user space.

Thanks,
Richard
