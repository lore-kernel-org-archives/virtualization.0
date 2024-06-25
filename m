Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A191474B8
	for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 08:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719303084; cv=none; b=bB1gjNzk2dEc4fsJCTNEbDa8twnG5XI6cD4wQwLnYZN+V8Ug3u6MZKMJr6ie7HK4yX68itNCoV0bHuHIjACenmyGt2wq5HtH1w5pGQeWuzWxRQ/jVD4HBUR7zXwZWnJocMBCkPeiYhD7J4DYEKh7erfF8Tu4bHrxAZMypz4dcyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719303084; c=relaxed/simple;
	bh=aiKTsVyZXFeVEbvYSkQtwooDBZYqfXDO1XWCWoqLB6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGFWdxFdPNh8oiG1lbi7ulvVAUDJQBKweaf2/tN2gtzOjrbUMkl0URAzAiu5jWIeFewiAbP0QekcUUDRk52zApRjZ9y8oLsqp5wzp4/wfFVGz8Y0h4y/LoRn5rSQtp9gXetehILlUtpWoCgBVdjJcIZ8S2KS0ePJOBxiaoNhGVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aQDj/cYF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQDj/cYF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719303081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aiKTsVyZXFeVEbvYSkQtwooDBZYqfXDO1XWCWoqLB6s=;
	b=aQDj/cYFFKzqxtn4K7gKIV1KSzXxX/BNJL+oTQ2WHEnJh3yixRlu6yZ65FrmoMHROWwUIM
	y3RpfxiqafqkDicexUpB94IKC1aAopR3RCg91Niw8K7o2eeRxXghqV4qyoI0CaZz8uONbD
	L4tI954AcbvR0aB+LMi0Z8PZyPQISfM=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-3uWuazxQNh69e6o-jDmeuQ-1; Tue, 25 Jun 2024 04:11:18 -0400
X-MC-Unique: 3uWuazxQNh69e6o-jDmeuQ-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-70677422887so2984048b3a.0
        for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 01:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719303077; x=1719907877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiKTsVyZXFeVEbvYSkQtwooDBZYqfXDO1XWCWoqLB6s=;
        b=i+D35CFN5J7134qKERigjWvd+ljVChSLQS6SL728Iw8SW7wNt+0EtXCAVMUrlO9o95
         Mmrwx0uft+7XVjuplwVLL4wqxylhpoUZevOlrCoNxeVyuML7qJ0FHqIgL7qsibX/VLAz
         pYfoQy/xM9XP4L99vjhXDW/E0G7j5QNzJqLA/WQxbNHcqueZfrJOdtis13X9hUHU+Upf
         IKANn2KuAL0YJ1dczFohW1A+YSDt//n9oZXECiW6HFIhVnzu8lTw7W9lyo8Q1lJa6B5p
         uqLl8Zv8mQ1f3PHD4NOJC+rRORkZg8wBdG8lhZ2fiNK+8Q8ghTotn0QEWiwTGG0RuYu7
         OJdg==
X-Forwarded-Encrypted: i=1; AJvYcCXjggIKQTCrg9vOJSQvBGjNx7XmPUZ5ixhmIsRn3zK+ZnhfC5zqYKUj/ipk8mdUHGCxp5VSv/MAyxlZA+s9fqVJNjzw/h8Tp6NKDIWpOk4=
X-Gm-Message-State: AOJu0YxMhdO9jATR5D/A0KtunHtixk7NdrwcPo9B52d2EguMiaLg60Qh
	1OCgY45+UhWNIzacOOAWIJu9Fo6tiVGSIIF82/yQkaus8e3W+fMV5UFe14XeEVYE7lE7Ex3st/E
	u82BSYQlVMzDg0tUQ0xNQtQT+ORmNXissIKO1b4Ilhf5PxQK38vMA3B1Pvvv+1G0WglK1UZ3iHs
	V7pVHQisacviGOl9sH8PJyw2zapRaqG4J3lP6ICFLdqWD5WTM4CA==
X-Received: by 2002:a05:6a20:841c:b0:1bc:f9ca:6153 with SMTP id adf61e73a8af0-1bcf9ca6221mr6768789637.14.1719303077078;
        Tue, 25 Jun 2024 01:11:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTxP7NUZILtOLpE7RPvLE5M6VrDgjulN2KCLl6SrNH4G4epy0uBszytXEo+lWjLhrJAgoEer6T7AKyi5WlAwI=
X-Received: by 2002:a05:6a20:841c:b0:1bc:f9ca:6153 with SMTP id
 adf61e73a8af0-1bcf9ca6221mr6768765637.14.1719303076509; Tue, 25 Jun 2024
 01:11:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240624024523.34272-1-jasowang@redhat.com> <20240624024523.34272-4-jasowang@redhat.com>
 <20240624060057-mutt-send-email-mst@kernel.org> <CACGkMEsysbded3xvU=qq6L_SmR0jmfvXdbthpZ0ERJoQhveZ3w@mail.gmail.com>
 <20240625031455-mutt-send-email-mst@kernel.org> <CACGkMEt4qnbiotLgBx+jHBSsd-k0UAVSxjHovfXk6iGd6uSCPg@mail.gmail.com>
 <20240625035638-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240625035638-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 25 Jun 2024 16:11:05 +0800
Message-ID: <CACGkMEtY1waRRWOKvmq36Wxio3tUGbTooTe-QqCMBFVDjOW-8w@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] virtio-net: synchronize operstate with admin state
 on up/down
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, venkat.x.venkatsubra@oracle.com, 
	gia-khanh.nguyen@oracle.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 3:57=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Jun 25, 2024 at 03:46:44PM +0800, Jason Wang wrote:
> > Workqueue is used to serialize those so we won't lose any change.
>
> So we don't need to re-read then?
>

We might have to re-read but I don't get why it is a problem for us.

Thanks

