Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00B93EFD0F
	for <virtualization@lists.linux.dev>; Mon,  6 Jul 2026 08:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327461; cv=none; b=TqLCuw/087MK8+dk6ZTAkY5ZhhOE3RCtO57vlqpOo7bqgeDwR6g9mKY6zvOrTOWIWEB5g0LIbcfJf4Lyr1jrbT3W7F5FBac7hQYzjpSZRYEKXKox5Gj6mX2eA7MXKsZ7UBNqBNb//fikKK11vAq1VZcQT4xxEMqePnlS9ktdpGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327461; c=relaxed/simple;
	bh=fcHRSt2uu6fC372J+gEM8pzdWzCOu8p2V+bxQ9uVUUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SmgsVC+isHgoyJNWAOIehrHxRmFMFtsnVOljBGZL9Hx3XnhFT1rgYQQzGlyvPSCk2m9MDtpBinv9HjfxDzVi0/Bvp67LJX3T5JP8ZINyp7qv6gSQW3uQQJhsPp9mFxp0dFIeMdAXj7iJW0N8Zvw+Qzh3lJSeAWmbxWvu4nRAVfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TQ8xpR3B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQ8xpR3B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783327445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RLCqgq8bJA3wDjgxn0V0PvA/+/Oia2v1so+e3G6fRBo=;
	b=TQ8xpR3BtfIHIjkL6h55ltfki8UrsG+lzlNzk8Pjddr6DWTUFYRJevKJWSNfR/nfw/OLhb
	0zSqQvGZwp4VvAghkjAXkqEll9VNTO5QwDlDF4guKl6+ofI8o04ecOZUH7+GuZx7uH/Vcn
	l/rg7kJ/p5l/Gl6pJSgWgcPS+ocIT1M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-N2wtby1TO-aMMURXJwo5Iw-1; Mon, 06 Jul 2026 04:44:04 -0400
X-MC-Unique: N2wtby1TO-aMMURXJwo5Iw-1
X-Mimecast-MFC-AGG-ID: N2wtby1TO-aMMURXJwo5Iw_1783327443
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-476608a9fefso757433f8f.1
        for <virtualization@lists.linux.dev>; Mon, 06 Jul 2026 01:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783327443; x=1783932243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLCqgq8bJA3wDjgxn0V0PvA/+/Oia2v1so+e3G6fRBo=;
        b=qrCQHQyE7amE3WeYP8DpCadcWkkvRRaPk1wK39XwCTtZqy7L/ep6/LuDhf3vpyeigh
         bpCmF+HIW4EEIKgOUm7IbAoK0qAz0vrd9Fu9REIPAPDL0UHEUi6lRgMcikqNog1krILh
         pq5Cl8rGf5Q1lSDCY+zLO/N6IQ0/eLQDe2eMd3QHE1pjJGqH1trxPiDP0GY+CuJZ9XYQ
         6tjhK9fYN16iuhhHCCx5CKLuDNrAqnc+A2qiuVVN+I+2XE3uotGLTS/7SGCdEJDpO+3S
         EuJ4HLFxVcj2jsV7iayRTVgGx9TsLUxrtWekR/ExjANi/0EbqCgXGXU9091tmqEclqa+
         0Gtw==
X-Forwarded-Encrypted: i=1; AHgh+Rr8kBqeWcaG6IuVwY/sC9987BNhFRpInL6k0MBpjbIkwQlGX6p9mTlh/zfuL+oAgEVW2MyoEbwnLohHMCEzzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywvt9/UPjClVC/KTUkYw6meiEi8Hye1PKQcyLtqTFjxpo6hyVvn
	QKdxU5UESJfZughdnsLHxiFBukPj4UOVloETHoq30pzUtEIPbz/LmLpRj15OGFMkHWWHyedwECh
	jMp5+vc5LPyX5dtMbZVK0sxVwNFC/YiXoTOzKSOxJe47TdW4o9LYRA5kmef//GxYPnhMk
X-Gm-Gg: AfdE7clU5AF4drFKATjeZhE+PIxgM8XND5kwyLaZxjo7Eid8AIIO6wmzjTRmRR3FR9X
	H+tUaQseVxbf2pGc51y/RBdpZIAQyqx4gyQt3sPrAGKqVQkSdBTHaqsmKu0P3Qq7W/GvNLjAjUZ
	RQrMd72ZCVM6ufEGq7wkkcN4qWp03MRc6QXrh6/Mw04H5yKFP9/K2VG6h0tg96wZeorOoKuHMTu
	fpXDOc4NVJEeO0PMAv2H/9CY3HPIh+kDT3BljgfibyoxjWkaEaNwBZeXv0F8DHSo7hIlJbPRXpM
	uvTc9L8nRGHRQ1dWPX2XOkiJ/a0I+KC0BUCdGE6VlQCUKi9xaB3uMqH2LFwifu7fszJrnAUUiAU
	FXaalhOIVpaZpOnc7ChkkzLIH2XKfUDTC
X-Received: by 2002:a5d:5d85:0:b0:473:6590:c42a with SMTP id ffacd0b85a97d-47abad9f1d4mr10815759f8f.9.1783327442841;
        Mon, 06 Jul 2026 01:44:02 -0700 (PDT)
X-Received: by 2002:a5d:5d85:0:b0:473:6590:c42a with SMTP id ffacd0b85a97d-47abad9f1d4mr10815728f8f.9.1783327442334;
        Mon, 06 Jul 2026 01:44:02 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960af0sm21194916f8f.30.2026.07.06.01.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 01:44:01 -0700 (PDT)
Date: Mon, 6 Jul 2026 04:43:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Adam Litke <agl@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>,
	virtualization@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH v2] virtio_balloon: prime stats vq after
 virtio_device_ready()
Message-ID: <20260706044122-mutt-send-email-mst@kernel.org>
References: <2f0d0de033f3005d3b985883be3e5cf37b3f6c42.1783278596.git.mst@redhat.com>
 <13794c5e-375a-4fc5-84b4-a637d077f8a0@kernel.org>
 <20260706042207-mutt-send-email-mst@kernel.org>
 <6b8e4ad3-6909-4d0a-89a4-104a5ad9fe79@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <6b8e4ad3-6909-4d0a-89a4-104a5ad9fe79@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ypcp0NqWW9xjmZDRcvTAYGrgYzkgRfXFV4w1W_duh0U_1783327443
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 06, 2026 at 10:38:18AM +0200, David Hildenbrand (Arm) wrote:
> >>> -		virtqueue_kick(vb->stats_vq);
> >>> +		disable_work(&vb->update_balloon_stats_work);
> >>
> >> That's to stop the stats queue triggering stats_request() I assume?
> > 
> > Yes.
> > 
> >> Is that
> >> valid before we actually added+kicked ourselves?
> > 
> > Why not?
> 
> I was wondering whether the spec would state something about that.

Sorry I do not get the question. Virtio API expects
callers to serialize calls for each VQ. So this just prevents the work
from running and accessing the VQ while probe calls add_buf/kick.
I'll add a comment explaining that.
But it has nothing to do with the spec.

> > 
> >> Also, can't we simply handle that in stats_request(), just ignoring it there?
> > 
> > Then we'd need to maintain a special flag and I dislike that.
> 
> I was hoping that we could use the device-ready indication, but there would be a
> small race window indeed.
> 
> -- 
> Cheers,
> 
> David

