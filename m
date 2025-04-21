Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3C825742A
	for <virtualization@lists.linux-foundation.org>; Mon, 21 Apr 2025 03:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745206878; cv=none; b=kXFPBOTp67UcNnxkzp/T70YMIFpM2CnIORru51NiRjR/cnNIUOKFyFcsRzIjp8pcgEpo28sFld7YhvUm15yMoNIud9RhymrnGHeWyKBM7sApN3ACqjkakGREgIlPBLAeCbzmfX4xjBdEqY+SmKipWiy91qNVmFL4mNpA2elwgoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745206878; c=relaxed/simple;
	bh=HuyJ5ZjeMDNi0MDOzVYBUraDwK2NWuFkveGRKSzNHA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eixi1cFRqjS9hx6Jz/mxAM4Z4F95UtIheDMnCWH+3Z/tISCxHR0OBGbTi7LI594RGGR49f6Dc+kDCh1TtwiU3dIChom1ZGjnRHpLb8WWPhHKpWewmd1qrKMvF1AWHSFCmAL+aTi19MJGj79jCgNON9KMY+TeGcl3UlHfMdEdtJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MlLg05Fa; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlLg05Fa"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A281E406E1
	for <virtualization@lists.linux-foundation.org>; Mon, 21 Apr 2025 03:41:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K-UcevjAu7wb for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Apr 2025 03:41:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3347440356
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3347440356
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MlLg05Fa
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3347440356
	for <virtualization@lists.linux-foundation.org>; Mon, 21 Apr 2025 03:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745206873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HuyJ5ZjeMDNi0MDOzVYBUraDwK2NWuFkveGRKSzNHA0=;
	b=MlLg05FaTKiR83on1L5+T/5KptpOFqYn2uMdp+MLz4sTlFDYkNkcXczZXuQYhsxBhLILSg
	7JDNceejhOIDDK8D9aDm00YyD9sLjq1J34m/Pzi+8F1HOjADjZ2OEYVXaDV+A2HAzviMtx
	VJU4AlBIs4+0mUUtuX/gFYVBHm/QJSM=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-TchTrNr-OkWivI0POZ-5og-1; Sun, 20 Apr 2025 23:41:11 -0400
X-MC-Unique: TchTrNr-OkWivI0POZ-5og-1
X-Mimecast-MFC-AGG-ID: TchTrNr-OkWivI0POZ-5og_1745206870
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-73c09e99069so4370769b3a.0
        for <virtualization@lists.linux-foundation.org>; Sun, 20 Apr 2025 20:41:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745206870; x=1745811670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HuyJ5ZjeMDNi0MDOzVYBUraDwK2NWuFkveGRKSzNHA0=;
        b=pOA3m70PjFrk91tu8IoxiuDOxxZOtUyZDTWGvqM9Gmzcj66zfO1j7BJl0eX3/0ROv8
         3p6TJtWuNgWgnBy+RKUOSz/0bbPgEtMzyenY3F+/q3ZnGACBCqyx/bBB2l0sfjy8tecK
         vEsCC7c2gO1EhlCz3A7coANCYBjZOviQtqRj0FQb0NnLohzyxq6NKAEdBRA4RcdWZdm7
         6v5knV4G/O/O9ZBQg8qnqMItDbk3uqJSCtX63qIZfuMO7mhibeEBTA5JvlKnLftx1vK5
         9qQAS11GLL9yKcoWJmDTNpiEeJtWdqaNmMVn6kjfwdwcO35sAXOa3i+PK4chN467HpbH
         S0DQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAKhg4PhiunsFOPxuQdOKQMFsSsgJbw6YHEL+lF8Y6tXSViG9NA0STBf7MpzH/XXKb2oYPMFORluZW/DvS0g==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yx1syWeA5TQN7K/RxJ7bDVSG+80VzhpA5TxbyhtTTYI3aDRhOH5
	/4tCANVDPaIqUmwTWcTzapKfOOkHqqUKk2yYuerLR1CrmNvwoXGSKJJiU6o0YUGMY4Euogm7/Jx
	AaDnZfEdQz+U9xKO7ffdcvYVLbE2GvcWqUjFZDtKl0Di8yaVE/No5g/0kmVCSazCnH6C36inUCi
	PSXy3lQavSkbViZZtjS8D6QTT++P6znMg6FxxTQZI5TNv4hbWw3QKU5g==
X-Gm-Gg: ASbGncunJbb1RwQ/bH5oGqD0Yf1FOKhC8TJM95JuJhnnfCI9idnBBqUD1wF3F2IW5Sb
	ieLBYmC48qBa++XYqqRAOmC8Yo9UV5JstPWa4o0wY/rSfGDIwUSbBGOLqqF/8QulACNwqMg==
X-Received: by 2002:a05:6a00:4648:b0:736:4704:d5da with SMTP id d2e1a72fcca58-73dc15c68a2mr11228291b3a.22.1745206870373;
        Sun, 20 Apr 2025 20:41:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPYgkzH0aAPS+m4dDNwD+hG2inZ9iE8RfSuLcGM/dEyykWwol5iEf/2EDadmje8TzWTiGr0IGa9NVDmTX+rBc=
X-Received: by 2002:a05:6a00:4648:b0:736:4704:d5da with SMTP id
 d2e1a72fcca58-73dc15c68a2mr11228267b3a.22.1745206869974; Sun, 20 Apr 2025
 20:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250421024457.112163-1-lulu@redhat.com> <20250421024457.112163-4-lulu@redhat.com>
In-Reply-To: <20250421024457.112163-4-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Apr 2025 11:40:57 +0800
X-Gm-Features: ATxdqUFUXQU0YTwg1cIJfTuwIr6bdYeh2bbILXsoZ4BkBC1HqGU1qls5XtUYx_4
Message-ID: <CACGkMEuki8JnD-5OGk15nhzrthdb78refcDUv2EeKgejSCQfew@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] vhost: add VHOST_FORK_FROM_OWNER ioctl and
 validate inherit_owner
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 27QAwO9h_IlTGhrqJjFj9lAo77CrDH4fAerKE7UMBmA_1745206870
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 10:45=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> Add a new UAPI to configure the vhost device to use the kthread mode.
> The userspace application can use IOCTL VHOST_FORK_FROM_OWNER
> to choose between owner and kthread mode if necessary.
> This setting must be applied before VHOST_SET_OWNER, as the worker
> will be created in the VHOST_SET_OWNER function.
>
> In addition, the VHOST_NEW_WORKER requires the inherit_owner
> setting to be true. So we need to add a check for this.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

