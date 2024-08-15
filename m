Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142B11AD401
	for <virtualization@lists.linux.dev>; Thu, 15 Aug 2024 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735701; cv=none; b=pmxwmsELpwps3QGTh8x0PfmBoZoSLoQjh4TU62t0KgZ/CJxVz5aKqZjmzT9wUgE5nmDIu2kK+Lb3ohAqDyg8WBxTrqg2tPMGqP+SXdj6o4fZtc8Nuu/0r51HHU6vsjvn9Hkm7hWm6KlDQaJyxvfrA0ck+uQkixaKCMcsdKvszRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735701; c=relaxed/simple;
	bh=w6Y8keq7MC/RcB+oPriVQpHgxKv2tM3osBO16JjXgjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=E3zZWC9ao+0arhiBHnqJVzQ+3Htfn+ZUWr5vsoNHn54J78wvNk9G23A5OxaxFLGBsCYUtnHwKw22P4lo4kftNpJiJBIzacV1PIbWm4QnuclB6U6aFU4lDa3gnqxa3B3x4XTNWVFRF/ee4dLWnoatbCv/8K/dP5GqOZWzfsCR+/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XU6hUFFE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XU6hUFFE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723735699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XnzeqT3NI2WawfrxS2a5Y4awkZprFbrha1qv4O7ZfPE=;
	b=XU6hUFFEIoZDqCpJ2h/PNw7RS1tc+fV+tuoXmnWp+HMkJ1D1Gj1nFQDlE4OqZqYqW7jvlX
	m8Scl+GTMQhJk6BAxFmByLWKe4mFVWEJ1vfL8iGuE9NMGwP1gmaWWyuysw/96L98oyZR78
	r1MHebdsN01dbRQhYCxVEJzaiJOSDcU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-E3ZCq8roOZiihUc-12WU2w-1; Thu, 15 Aug 2024 11:28:17 -0400
X-MC-Unique: E3ZCq8roOZiihUc-12WU2w-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5a2d4fb1e73so814196a12.2
        for <virtualization@lists.linux.dev>; Thu, 15 Aug 2024 08:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723735695; x=1724340495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnzeqT3NI2WawfrxS2a5Y4awkZprFbrha1qv4O7ZfPE=;
        b=TwjibBh67F/+XbwgwzouoBdwIAVzf/4CjzY7zNYtYHXmRPqmnd6ho+dy6IRkbXU8eo
         UIOaQZJFATsuE7J+KdKeZKKrb3RmmTVYenniZCWcBu7IycLRmrAeEOmYqvx+IIoi4s5e
         7/mrKvIIL+uzfVv0hh37+htYUc0+Rt2TZg5UvFNKcQrVMnX2xUNcIYJIwptBX8RHkKPM
         A5GogFEvsQdqA5f+5vW3tRoDKv1HWAVJtxxnys4vI8pqTzQ4r8vtkVJ/pxaFKpD3E9jr
         G6IJNlOOlLfXiTgvRQg6Z5/1vv+Wc+HGaWNC4qsctITe5l2rEk+Vhn94Dl5NplkNqDoH
         JdTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi0arGI/CLio6ssk47b8vXctwsPNLCo5xA+vcODoO0FxxgqNZGS6e+TDW9JCcluDW4SwSA5w9DiE5oiPxIwj18DYDJTVsYaLBFGlucjqY=
X-Gm-Message-State: AOJu0YyAZlkZw7m5pPLvzvyEWBc9rNAxvqE3WwxcgDIkb3CwWYBfKTSH
	iaBHAGsawtk2Fla5hR0xKlnT3fnSvh1VlJQC/580tigzefJO8H7md/3JCdYugYmvSsY4yFKStKr
	uO17slZ4wSaW0G+bcrsEZpRLa0204wDBx02Qp5EDfmGenc6oDmYW8n0MaHJx42wgk
X-Received: by 2002:a05:6402:510b:b0:57d:12c3:eca6 with SMTP id 4fb4d7f45d1cf-5bea1c7c716mr4272245a12.18.1723735695170;
        Thu, 15 Aug 2024 08:28:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/D7aBbTHDx3JnriGHYm8AR362yS4TnGCkKy4ZMsjbocDfbfeVNGG4wtZoRfQcR4P1Ow+x2w==
X-Received: by 2002:a05:6402:510b:b0:57d:12c3:eca6 with SMTP id 4fb4d7f45d1cf-5bea1c7c716mr4272220a12.18.1723735694455;
        Thu, 15 Aug 2024 08:28:14 -0700 (PDT)
Received: from redhat.com ([2a02:14f:178:8f0f:2cfe:cb96:98c4:3fd0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbe7f17bsm1022082a12.59.2024.08.15.08.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 08:28:13 -0700 (PDT)
Date: Thu, 15 Aug 2024 11:28:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	Darren Kenny <darren.kenny@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH RFC 0/3] Revert "virtio_net: rx enable premapped mode by
 default"
Message-ID: <20240815112508-mutt-send-email-mst@kernel.org>
References: <20240511031404.30903-1-xuanzhuo@linux.alibaba.com>
 <a6ec1c84-428f-41b7-9a57-183f2aeca289@leemhuis.info>
 <20240815112228-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240815112228-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 15, 2024 at 11:23:19AM -0400, Michael S. Tsirkin wrote:
> On Thu, Aug 15, 2024 at 09:14:27AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> > [side note: the message I have been replying to at least when downloaded
> > from lore has two message-ids, one of them identical two a older
> > message, which is why this looks odd in the lore archives:
> > https://lore.kernel.org/all/20240511031404.30903-1-xuanzhuo@linux.alibaba.com/]
> 
> Sorry, could you clarify - which message has two message IDs?

Ouch. The one I sent had a bad message Id :(
Donnu how it happened, I guess I was mucking with it
manually and corrupted it. Really sorry.

