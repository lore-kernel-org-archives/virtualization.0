Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B5248780
	for <virtualization@lists.linux.dev>; Mon, 22 Jan 2024 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945660; cv=none; b=PDddYVQEUEONIhAJV3uDTpq9F0psRA1esGyoPwXv0cZ6GWcn5I1kSlUgU3QtPoI3N7XSXa7w3UxvVNyWlJykrzxIm4E7Uqvtt44nymks+zWM4dq8ze0f+TgaQ3D4RTWfaksiaVw6YqnHCU61qJzxcMSqIiyN2tZ3X6v7iOF0N+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945660; c=relaxed/simple;
	bh=5JMS+q62XZW23hNclILrAtW7tpPqJU12NjrpErZJU6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=plmc362ArgO6wulMK04JtiUcUaTfr3dLYJqno8FsdFaMI1llpiMeBQpQYteGaQI28Dn7yZ8n5zrluf2oQatyBcapeHW+DaOZWAqGNaxiTRsSuNQWi3+rhZN3emNteI9AnarWimlXPDCMdHWNJWfUB37PlqbfZsM22MWE5iII1O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpP+yuEX; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpP+yuEX"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bbbc6bcc78so3025877b6e.1
        for <virtualization@lists.linux.dev>; Mon, 22 Jan 2024 09:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705945658; x=1706550458; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LXuYDfCriPwb12rx/ZYT8NxGUq7r+dv6zy6nRCpOHlQ=;
        b=MpP+yuEXi8rT5me9hgecM2rx3n7YJbsF7lNjA8br4XIZ7tYbe7XN2AKloqi9ocuVPr
         xzJuBI5yr+y5BVtg/yS00C2D2+QPp/W2+ZNF9DGQyvwmVkkojmjVrAY1p1VxwireDflX
         sks4qbwSSIUJuaENxXXxxbMMejGr2BLbGcJjv6wfHl/MvnzrrbuwXMgrup437bqr2D2y
         EIXVAuEXFRZ9EFRqjgZ+sULynzc7YeAI0R5AxMumG4EZ6lWx/vrCCF4KqaF9CcuyOVpg
         RD6BSPwp5latmiWmQWNtJaF6we/P1de39d1E9VS/KwzzebCX8QwNCbsk674GA1cfrhol
         Li5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705945658; x=1706550458;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LXuYDfCriPwb12rx/ZYT8NxGUq7r+dv6zy6nRCpOHlQ=;
        b=Qqq+Ozkynzif3k3Nb84toDPJqpS2M0ll98/IC4xffgNfV2tvoLUDRLM+PhL8I6gWPQ
         Pk5ll050/BPlozYGTrVHvXn6xdLsQrCN2699IoMjGEAsR7WBBp7dvfS+kFhswnVAI0Cv
         uvUHSsFCo90U/e68cpvHeP/tx49q6mhzfsiJqNXYs9+Vnj4g6sBBPszSeg3iNKE5vBw7
         7CeYaHP8YOKjFfWhWnZNMdK8jTEtd+jt+O6SJm2xz8v2ohZHJt0SBxyW8ZcSSX73y9f4
         NSYd/jJ2pSPWISTow70ZKV0VynbELrxsMA8nXKHPTTx7kAOWvNFLujUdx8/D7FydiP95
         9yuQ==
X-Gm-Message-State: AOJu0YweLQSbXba6KLGHD1v/IO4f/DPqtpb3YcO+ymSYqrK2rlcBsp85
	0eicvjeN0JcusGreyWuaY9fF+8Qpl7MJ9ysPqv1TwC6q6M67obazaV8LXAJ6yD8dKJhXlryspKg
	FeP7LLtE32Cz8/E9eiLswkKOp9uo=
X-Google-Smtp-Source: AGHT+IFBPlz+RgibcswccIxunRUauN9Us0ZVtsgo5fHnIR0Z4jyywDWN7TzgdTClehWzdrId7Z0Ij/5fS4mvUZpKvTs=
X-Received: by 2002:aca:1809:0:b0:3bd:6f2f:6903 with SMTP id
 h9-20020aca1809000000b003bd6f2f6903mr3867589oih.111.1705945658414; Mon, 22
 Jan 2024 09:47:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231130070133.8059-1-kch@nvidia.com> <20231130070133.8059-2-kch@nvidia.com>
 <20231201012507.GA1209828@fedora> <f4c17344-33be-4832-9045-fb6b40a478b6@nvidia.com>
In-Reply-To: <f4c17344-33be-4832-9045-fb6b40a478b6@nvidia.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 22 Jan 2024 12:47:25 -0500
Message-ID: <CAJSP0QX7H5F=rzz=STeWWYZbTxog0S-MARXgoHkR=u04qTD+_w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] virtio-blk: process block layer timedout request
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "hch@lst.de" <hch@lst.de>, 
	"jasowang@redhat.com" <jasowang@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, "axboe@kernel.dk" <axboe@kernel.dk>, 
	Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jan 2024 at 22:33, Chaitanya Kulkarni <chaitanyak@nvidia.com> wrote:
> On 11/30/23 17:25, Stefan Hajnoczi wrote:
> > On Wed, Nov 29, 2023 at 11:01:33PM -0800, Chaitanya Kulkarni wrote:
> >> diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> >> index 3744e4da1b2a..ed864195ab26 100644
> >> --- a/include/uapi/linux/virtio_blk.h
> >> +++ b/include/uapi/linux/virtio_blk.h
> >> @@ -317,6 +317,7 @@ struct virtio_scsi_inhdr {
> >>   #define VIRTIO_BLK_S_OK            0
> >>   #define VIRTIO_BLK_S_IOERR 1
> >>   #define VIRTIO_BLK_S_UNSUPP        2
> >> +#define VIRTIO_BLK_S_TIMEOUT        3
> > The structs and constants in this header file come from the VIRTIO
> > specification. Anything changed in this file must first be accepted into
> > the VIRTIO spec because this is the hardware interface definition.
> >
> > VIRTIO_BLK_S_TIMEOUT seems to be synthetic value that is purely used by
> > software, not the device. Maybe there is no need to update the spec.
> > Just avoid using in_hdr.status to signal timeouts and use a separate
> > flag/field instead in a block layer or virtio_blk driver request struct.
>
> It is a specific error hence I've added that on the similar lines,
> do you have a specific field in mind that you would prefer ?

I didn't have a specific flag or field in mind, but it's probably no
longer necessary in v2 because the code needs to wait for the device
to complete the request anyway.

Stefan
