Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29882DF140
	for <virtualization@lists.linux.dev>; Fri,  7 Nov 2025 01:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762477249; cv=none; b=IyDcErLEWLJ9nOhOoPw1Lce18/8zXbQkh7DUyMvu2yFWiQf6KiJRYiN2dDVFEywhmhpQUnFilkEtszOD5G5eq9WImgnSiFtk8XCsVx30KMZO5fzzl8fB21oIuZF7s3alS+zJji4uCjJZItkzsUNBgS7FLQCT67v0qlSObWhhquQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762477249; c=relaxed/simple;
	bh=NZ4x6TEl3CJtkTGi+wP+m0cvmfYI0RmaIhfXqjufJuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hc5cYvSFBjqFQLN8QJR4R2TJBvRSoATbWW3JcXA74PqDjCYu+V/8K90szGJLqmxxf7N3np9rPsHnNCl/V+SOrzk4Z+ElKz1b3Lf8ueHHduZGqk9IqUN1ErN8eje+bSP3BsOj20q0s4NWNAf127V0d17iMhTl9B8SBhBKYv3Dklw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZilqI2ti; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZilqI2ti"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-63f94733d6cso217241d50.3
        for <virtualization@lists.linux.dev>; Thu, 06 Nov 2025 17:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762477246; x=1763082046; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pUVfqUQtUqV0wkzqiVXGQWjP7m/o2AcCBa4KNQ5qB/w=;
        b=ZilqI2tiS/ZbyM6cOvCmjeoNbHDaXBUUUWPs7P0IKEHTJ1sDaWFsWcBCMmszFt+Q/s
         +vNJGOoENFhIpQLLdPwPFr4UV2nZcDV7WWzIjbwaA0lVFDAQf1WRvAyL+Q0d5W2dLBHL
         J4Ndgns4G2IMrEuVh0bFmNF5Pe7lBaha7NFGXmRJssBJK20xVENSRtAKtDX8h+A81wej
         S9akHy1PoSPq/E0SdtD50gmaBZGhRI+n2ga74F5KRqBG0t0KA/YabqV6xYQDVG7BQFNA
         0OezKrSCOqKlQz/Nj2dXiWacp/JcupD2rvGrN62wSOA3+HV1zuWSvkehTXRc1oyT/rTb
         d8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762477246; x=1763082046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUVfqUQtUqV0wkzqiVXGQWjP7m/o2AcCBa4KNQ5qB/w=;
        b=C0maAVLrhLHP0d+DoJG6V/gwd8noEOeId+s1qA6VHDWAsCGoqxeD755l/RieUudP8F
         xivi+SCY5wP/ZOtMgtjA2uG55g5NJTSQ3BQelkemsd5Wi+VF4HeEgoABPNnDQak13p+u
         BUuC1BhFy7zTdsDCcvy1+bBvfoC0s9HLWUGQbKcj/3n7zG37yQmyLDzawnDEcIYtFl5A
         Z7HQBrLeMjL0Fnopg4sKcMo8GCEYUodk4jiEUI0k2rzwjxlMy9enEhyCA2P3WhXkui+o
         wXj72wgSVrelNwgSpfHZmr+kTWOBQQrmr7fCf56jUEqQw3klf7thfx3QCWPefhkQg0H0
         Cskg==
X-Forwarded-Encrypted: i=1; AJvYcCWjU4j95/5clzCmJsu/r7M41iph7AhDKPImSwegfNrQ5Sz9TQGcpLxFtkh+UGViMJEW3jTpc3zsEpUXlWAZbg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzNm9JZ+DlCt7sW+KNMD824+zm5t9sr/KIbpcrYDD2zjxs9FO+/
	lQxGXnPuF1RD60cpsRaJ6MZfIKbusYQuxkWu4Aw/nI4hnOeRHGDvkKid
X-Gm-Gg: ASbGncvG2FYTHAYwRj6/Ew4Bwlg8VJatnQ+JjIM32MOzuTfccbIfsZyL8bNTl88oteG
	oktmKJzcdzGJ2xysVLWkMY5l+pMd0py4OgjjL2ZviQ3qAvqMNQJsxP1/ll8bnO1RUW6ytZ8l14x
	sTpJx4cp4h4DRP8QGrDVInKRLIcOIfGoRr9TgqgVWEUj8pr46r0/4RZJ/7sBm80IHEBoWN8OXfu
	DIPqIidZd3fvZrMdu5YFE8Y7Mafl6S4ZsJL1KYQ2X/sMYoWIOV8JQTn+lSb7hUD3AXBlnNHrw35
	5if43+yUce3IQb77cYS5Ho2Khd/SH0KNEkfdjIDrCBFH/h7xX4IWnBKYsqJyNTgKScdgtXtZ9sD
	hkuvdekJJ66dS5DweOmSYJDnHuWGdzZx/YBU5I/LxDU0hyDGeBXMyrtgC4Ycu4IciigFZJ+SwPq
	xo+WgAKOhOyapKGAZ0ZEDdfcCiA2DDQGMBlyul
X-Google-Smtp-Source: AGHT+IGXlZDS/7AIW+f4SW9AQZ+mYsEsFZB3pq1/mcaIGtLtZbgr70tzGom2CV/dzdZ26+pnChUzJQ==
X-Received: by 2002:a05:690c:360b:b0:786:6076:e8d6 with SMTP id 00721157ae682-787c542e985mr22214027b3.57.1762477246594;
        Thu, 06 Nov 2025 17:00:46 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b15ffc52sm12984557b3.54.2025.11.06.17.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 17:00:45 -0800 (PST)
Date: Thu, 6 Nov 2025 17:00:44 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 00/14] vsock: add namespace support to
 vhost-vsock
Message-ID: <aQ1EvN3q90v3r3RD@devvm11784.nha0.facebook.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <k4tqyp7wlnbmcntmvzp7oawacfofnnzdi5cjwlj6djxtlo6xai@44ivtv4kgjz2>
 <aP+rCQih4YMm1OAp@devvm11784.nha0.facebook.com>
 <4vleifija3dfkvhvqixov5d6cefsr5wnwae74xwc5wz55wi6ic@su3h4ffnp3et>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4vleifija3dfkvhvqixov5d6cefsr5wnwae74xwc5wz55wi6ic@su3h4ffnp3et>

On Thu, Nov 06, 2025 at 05:23:53PM +0100, Stefano Garzarella wrote:
> On Mon, Oct 27, 2025 at 10:25:29AM -0700, Bobby Eshleman wrote:
> > On Mon, Oct 27, 2025 at 02:28:31PM +0100, Stefano Garzarella wrote:

[...]

> 
> I just reviewed the code changes. I skipped the selftest, since we are still
> discussing the other series (indeed I can't apply this anymore on top of
> that), so I'll check the rest later.
> 
> Thanks for the great work!
> 
> Stefano
> 

I appreciate it! Thanks again for the work on your side reviewing.

I'll address your feedback and rebase onto that other series shortly.

Best,
Bobby
