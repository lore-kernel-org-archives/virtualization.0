Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C1D1D967B
	for <virtualization@lists.linux.dev>; Mon,  7 Oct 2024 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316034; cv=none; b=cI0xSo6F9AucPc2TtSPfH+GeyVc9Jni2Gycb1nCpPxUUFmvJJSMwMLt4yPLK0XddsFJ6IYNxEL8MJORpI1fNQ/V9E0e9AdrFDBRI3551EpK+vM6ZRPduN4U5n6kncGcI8quG0Wt4QhOpgxk2XY/YNOeR8x3Mv3buXM8/PlNoHlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316034; c=relaxed/simple;
	bh=DQZCNIJ48pE5/m76HV8ZC97oJTUUoycjro9TNIIqwwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lQEwHeQszlwYZ8EGK3CmCuJo8u8exuMtnWGUBoxQ2XRTUzeDJ7kM0K46m4QnsEQdd1klnvwXusH+lwega1wZz7hLzo5mjqjWGmhXjJjW3l6r8Wo2lGAptCuoYe5hN+dzSwlLDYzxXOEJhXJhfkakDE/YreD1EDfuX15g0T3BDa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gset2AdH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gset2AdH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728316031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j/qSM1gi+xzbWol0GgR9iU7ZEDf5izrAUc1BvVzk/UM=;
	b=gset2AdHW3G7CNgu3YRex9lVmKwCC8IwvtP/WOSic/5A7d530JEO5b/49ySfk2M6QfmcCn
	Dm8ASKrAhsOiefdsA7zF94Y0ACbIdWl4g/MegATC1l9KRh+ljM8Q492hMGjxkVDaMz0/Qq
	/hHAAupzlJmmBUcmhYfB4VIv0YV/TcE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-0pKbp9NdMDebyApnumbCJw-1; Mon, 07 Oct 2024 11:47:09 -0400
X-MC-Unique: 0pKbp9NdMDebyApnumbCJw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5398863cdfeso3461936e87.3
        for <virtualization@lists.linux.dev>; Mon, 07 Oct 2024 08:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728316028; x=1728920828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/qSM1gi+xzbWol0GgR9iU7ZEDf5izrAUc1BvVzk/UM=;
        b=KhBMvA1Zgr7bHt7gM3zCsPVxbXwHkcPddzxu3JP5Zl68o6Xt8iiPX5V5F94KFyZb6U
         VoV9gtMXSFfw/TVtL/h73HZERiJ8eo9EXhxxfG1ZQGGW8BmUCK+Dh1tiE1nYUrJDBNlz
         BUo+/IRF740f06GGOWgsdxFOwz5z238l3MHdmpDSz+EDUniE4OHZFlI+9tOyDUzgnBBC
         xOM5MNAuhdeU9BZA6JpyUq58Prxx6hsGYtt0LTI2a0+AkR+SMFaS97akIR4mCX9JYBsb
         MdJ3tT/Y/d5CazRfWXTrpQyWtL2uIQ7p00do6p6JR7GLH6AWX5iF/hOu4W5Bq2utSGJZ
         vvWA==
X-Forwarded-Encrypted: i=1; AJvYcCWXoQUJ83KOHg/6ExWb1J6qEepLCGOBxe+x26xiTXbNI4JZprTrRb03h41WcJO6PKMx1viDnnKCnI/lg0G5Kw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxzvVHNsB7EyZb41DLO/nZzSUV5FNdBfyYqWhcwBvlKeu13ZUrC
	Y4O+VIWV3GQHJYU7bTIif5rT40vDJT4Y0Jtf6KbA/sKlka0x3W+1cX9gK52UaLnAA9/2+QM68XJ
	A7YYKrJaUGhK+2nDKIf2xy0mBDMS3k0do06g4LMXWHVYVCVLTtKCZ6TyNAJM7fLZS
X-Received: by 2002:a05:6512:3b20:b0:52c:dbe7:cfd5 with SMTP id 2adb3069b0e04-539ab88ad63mr5809838e87.32.1728316028356;
        Mon, 07 Oct 2024 08:47:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFI5CdxaS7NGjXGnhFpfvKBPg6dFQrE1IAMYDLqlZB8GcB73cj72b1bEGAmRYzgtVhZ1Lo4Kw==
X-Received: by 2002:a05:6512:3b20:b0:52c:dbe7:cfd5 with SMTP id 2adb3069b0e04-539ab88ad63mr5809803e87.32.1728316027827;
        Mon, 07 Oct 2024 08:47:07 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:8906:45ec:feb4:98e4:6184])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff1d13bsm890443e87.139.2024.10.07.08.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:47:07 -0700 (PDT)
Date: Mon, 7 Oct 2024 11:46:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Luigi Leonardi <luigi.leonardi@outlook.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Marco Pinna <marco.pinn95@gmail.com>,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] vsock/virtio: use GFP_ATOMIC under RCU read lock
Message-ID: <20241007114637-mutt-send-email-mst@kernel.org>
References: <3fbfb6e871f625f89eb578c7228e127437b1975a.1727876449.git.mst@redhat.com>
 <20241007083920.185578a7@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241007083920.185578a7@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 07, 2024 at 08:39:20AM -0700, Jakub Kicinski wrote:
> On Wed, 2 Oct 2024 09:41:42 -0400 Michael S. Tsirkin wrote:
> > virtio_transport_send_pkt in now called on transport fast path,
> > under RCU read lock. In that case, we have a bug: virtio_add_sgs
> > is called with GFP_KERNEL, and might sleep.
> > 
> > Pass the gfp flags as an argument, and use GFP_ATOMIC on
> > the fast path.
> 
> Hi Michael! The To: linux-kernel@vger.kernel.org doesn't give much info
> on who you expect to apply this ;) Please let us know if you plan to
> take it via your own tree, otherwise we'll ship it to Linus on Thu.

Hi!
It's in my tree, was in the process of sending a pull request actually.

