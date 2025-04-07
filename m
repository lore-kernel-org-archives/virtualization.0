Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF621C5D44
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Apr 2025 03:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743995777; cv=none; b=myj6nVplbnDzmIOWbJ0SlQqTMHp+SnTWvCSRpaZaIt25Dpy1hp2mjCeyEz6Xh3snUEyGybnfivkwgia43Xy+P8gE78jX4O6ZIX8vqxG4Zbe9nxPRygEZgBavhjX/AjZXhg72SlLELdozHKG2roDuCarsblwiQ+gUBNxt+EOHhjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743995777; c=relaxed/simple;
	bh=2Psv4XKwzaxxk54Wxm2NMdJLhP46x/zOj5VLe1kQqFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUdynQWw/x3IqUOl4gSjy7ZfZLkVVdeAvX5H2agvG+vd8p9m8MyS7OLpRy9wRUd2pBSmlacu+n8Sz+YlkNhYP28X7CNl+u3/AcwA03fDGrRWxAQM2RVRT0ExilutdFskPWBRXcO26hh6yQUHr4TutvEcJenCI6ivRXCKfQejQhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AFK2SNTP; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFK2SNTP"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A502481E61
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Apr 2025 03:16:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q-KPyE0G14ob for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Apr 2025 03:16:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0094381E27
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0094381E27
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AFK2SNTP
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0094381E27
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Apr 2025 03:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743995772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ByT4VM0mlsPMFV1CM9t8/TNYyL/tLm0jIu9vYemq9w=;
	b=AFK2SNTPMRZ/BfbI78/RbV1glk6BQag68dPA7M7oZ6vciguY3MgfzcNmqaqp4+1Ck92HR6
	o89maK4SuzbWIeObWFnnTEuR7J1+zkkDZ/mU6/fGHYY5ZjTAwNwGaFWoV5byZjErQQ0KLq
	RbMrNJhwrGAIbZIv4Vg4UxEiqrzRYC0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-69oIZUh8P1m-SAsPuMvXkw-1; Sun, 06 Apr 2025 23:16:11 -0400
X-MC-Unique: 69oIZUh8P1m-SAsPuMvXkw-1
X-Mimecast-MFC-AGG-ID: 69oIZUh8P1m-SAsPuMvXkw_1743995770
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac28f255a36so310558666b.3
        for <virtualization@lists.linux-foundation.org>; Sun, 06 Apr 2025 20:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743995770; x=1744600570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ByT4VM0mlsPMFV1CM9t8/TNYyL/tLm0jIu9vYemq9w=;
        b=IFvIjk4TjCEAbcqabUC627X5C2kKbkb4QgQi0SQ2K6JrZ//9UGGhEb1QwsPTHEGWb2
         iH1YSnDWkuiBav4/PD50Vwnny4AwS7XzllN/TdGDIiE7Q1u5gLnRr9lx9dXG6l2q67fp
         pLtvAv8VnPzc5VnBF2leUWS9+3noDrFM0we0809ilFrjUokl+TXGUY7KRPfeKmlsl7Kw
         MPvc/0r5ofpSlEPJSix5xXcytBrcmSZOthQFvy0MBcsIpv3ybj650jzEU2lBZFN8B8pP
         wJC+1SP1XbKmv458tc9StSPnqRPOpZJ4ggLhKo5eRZ0RmYYKY8XmO/9D9URPNPvn6FRR
         7s1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6HwiT6B2psLdpjww3lmbzruVFkJZq98g5rnp4R5sdJgTRI0IFub62RRZJAmIq03lz5AYizL/EFWiFMGIAPg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yz40F/m0CyA7MH0ozZTkQYF2Z7yzyZb8hITp6Mco9X6Vo8Ns9pC
	+KpKeUxRRmR7pJtLrqHR4Oehy3wvrF2IaoES6kNNTFirScYoYh50qkLIRgiHlxGI0AQ69BVfitx
	zCvtFuHZ1KZCrgMLylnVTIFKPHK681fDvHDvOWClle5la/SvH+2Yg75UeCI5190SyZLxwarbyOU
	kfaXpeFccdoUaQ2ghupuxCFtTKmknY1B460K4QVD2ZpgHV3Z/kiueBEw==
X-Gm-Gg: ASbGncs9NKX3XcIklGjZ2Cg5s0KmOXCEXnC0uUSxGxAF0abTRhUbOQP1eDdEpGj9Ys4
	hyFJ+xqVx5EGdBmN6Z6pkoOnRNDtoKl3gApqDGaNKLdPoBTUCIr31eMrbnv13sHBVScUxDfnInA
	==
X-Received: by 2002:a17:907:7ea6:b0:ac2:a5c7:7fc9 with SMTP id a640c23a62f3a-ac7d6e93599mr994473666b.51.1743995770476;
        Sun, 06 Apr 2025 20:16:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMJnXbAYIz1U9EXfhPLXDao58wG6UnY/kQ+tnR0/5Lpt/9hn9DGVTkSTF2KUQRBQfoiF3etXQ5fFZKr+LUKAs=
X-Received: by 2002:a17:907:7ea6:b0:ac2:a5c7:7fc9 with SMTP id
 a640c23a62f3a-ac7d6e93599mr994472366b.51.1743995770124; Sun, 06 Apr 2025
 20:16:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250328100359.1306072-1-lulu@redhat.com> <20250328100359.1306072-8-lulu@redhat.com>
 <d35istatjtnr42x4gwpwlgx627pl3ntqua3kde7fymtotl676i@jxxxkrii6rue>
In-Reply-To: <d35istatjtnr42x4gwpwlgx627pl3ntqua3kde7fymtotl676i@jxxxkrii6rue>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 7 Apr 2025 11:15:33 +0800
X-Gm-Features: ATxdqUHJ6Q-Ip5ecSwCjJr9VIgAypATzgnh9U_7r0L81kSaqxYSAPR91ELbFrEQ
Message-ID: <CACLfguXFeV6aRL+rW9ULWh=gyF8u5vLncMFJhsOrfMWe7PhvTA@mail.gmail.com>
Subject: Re: [PATCH v8 7/8] vhost: Add check for inherit_owner status
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Jpc5rzfkX676JcAD7aGCyfBRoIeuCldSAzSrSuuUXl4_1743995770
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 9:59=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Fri, Mar 28, 2025 at 06:02:51PM +0800, Cindy Lu wrote:
> >The VHOST_NEW_WORKER requires the inherit_owner
> >setting to be true. So we need to add a check for this.
> >
> >Signed-off-by: Cindy Lu <lulu@redhat.com>
> >---
> > drivers/vhost/vhost.c | 7 +++++++
> > 1 file changed, 7 insertions(+)
>
> IMHO we should squash this patch also with the previous one, or do this
> before allowing the user to change inherit_owner, otherwise bisection
> can be broken.
>
> Thanks,
> Stefano
>
Sure, will do
Thanks
Cindy
> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index ff930c2e5b78..fb0c7fb43f78 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
> >@@ -1018,6 +1018,13 @@ long vhost_worker_ioctl(struct vhost_dev *dev, un=
signed int ioctl,
> >       switch (ioctl) {
> >       /* dev worker ioctls */
> >       case VHOST_NEW_WORKER:
> >+              /*
> >+               * vhost_tasks will account for worker threads under the =
parent's
> >+               * NPROC value but kthreads do not. To avoid userspace ov=
erflowing
> >+               * the system with worker threads inherit_owner must be t=
rue.
> >+               */
> >+              if (!dev->inherit_owner)
> >+                      return -EFAULT;
> >               ret =3D vhost_new_worker(dev, &state);
> >               if (!ret && copy_to_user(argp, &state, sizeof(state)))
> >                       ret =3D -EFAULT;
> >--
> >2.45.0
> >
>

