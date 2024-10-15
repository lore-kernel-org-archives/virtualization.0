Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1238618B46D
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 07:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728976843; cv=none; b=oCqaG1YEpZOV8P8RxkRzFVwsUS3ba+I7t2il43i+PqkgN/ikAb0oQUM827RhQQiC8jUdoLulSdtkss8VxyE+P7hmWsxMjiuKieo4bej8RCtDve8qVs8b5ov7vP5k9LqQhs00aIaiDP/lD34TcMj4RDE1wR56uvUlc8y0CmmK09o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728976843; c=relaxed/simple;
	bh=aZ0nI4wEoXTnix+K7vnHNRRZ5u2CxP/xJ7+eeSluSRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P41j7EOXN8wx/oSl7pAd8OSdR6b5vgsVLQaZoTfqAyweeEZN8SdP/m1xCuGjK/bEpcDsY5hdaOCzO7yfKenJXD8K4ojFvSzl/xNEYQKAnzTiSQi2PLIcAW6rPa1oMz0QCLASYuoXBmk/jDv9MHo/BLK2lJdjn5/rFNDKVygSEb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YyS4ujRP; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YyS4ujRP"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98C6680F7C
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 07:20:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XhP3wx6e2tV4 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Oct 2024 07:20:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D186080DD8
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D186080DD8
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YyS4ujRP
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D186080DD8
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 07:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728976839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dm4roKBoCmtc4l/ytASp7XB8VjJl6kkguFPg7ZNJ3FY=;
	b=YyS4ujRPMDVas9kPkT2bsaXXyBPUy1M+iXkYrMfiLSM17rOMpp3QnKJ5Je4yXE8yko0AXP
	T/eXohZ0wY8n05quiVF74VSxkL95gWeqBvkqYxpQeEbZHggklqiFDy4qp3Mope34D1w9zE
	fQUQ9JYwPSaqVKpK4iAfAaAnoVlQjoQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-mDGvCnCuOgOLOv2n3DBbzg-1; Tue, 15 Oct 2024 03:20:38 -0400
X-MC-Unique: mDGvCnCuOgOLOv2n3DBbzg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a93d0b27d37so432003066b.0
        for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 00:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728976837; x=1729581637;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dm4roKBoCmtc4l/ytASp7XB8VjJl6kkguFPg7ZNJ3FY=;
        b=HMr+bi89P40hZNnCtYa63OC/VOxJMdoukeAid6GMSvMI1X/YfYWfYM9ibmRsfZem1h
         MqSqcFkiWVDB109yWgV6tkCVYEYOETaPcb94dtcI/Pxbo73xTtYByCL78ieMK/Oyj82K
         wmBMjs2vUaxhQAFhMxExq0Y665G0nTsDYVgtY5+PfNCJAv3dzmgqYLOCfTdW0L4NNkKD
         zAAz/r+xGJ3REGb28srMtNVPKGyrFOvOhH+EAfgUmkzjRRBrU42j2xAm3C3YfjfWhq8/
         8TN8k+8Qn2A9aqplh4BXzStrtux1ML1Erq2mnraome1GrFoCi1dUMCFwpiMGJ54nKaO7
         St/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8nOGaVhCrvzhHbeABjMCENkN8ELvo+kUZ90AWkyXQSLhe8LLyFwqwxCmfbAKw+3ZXnnfei3Z+AF+dECL0LQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyKW/56rS0I2D/RA/pysGCuVXWrUxBFHjrDDOfzIM6gMpdV71Y3
	IJSZ5P3H9oV3eyvEkw3ELjoPe0tGuG4Os9RsL4N9DkRrMMQQ+A1mY1oAOHjsST/CtykAZkD23pj
	gkOIN6XwjBaYxWQuOqfjh48eiixm6I1nWB9aQnypKsoeWcCn8xrrNIBJHNf9ktdlZObRwOi5sur
	yI3AbUUWt0OHYE9MSd5guvzS5FgPq66e9IGSee2q3WOKPtrOLONSkusA==
X-Received: by 2002:a17:907:9693:b0:a9a:1cbd:257e with SMTP id a640c23a62f3a-a9a1cbd2a10mr370384566b.29.1728976836713;
        Tue, 15 Oct 2024 00:20:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/SQ7uHHwUBTGa0Un4BlqLc26yoGrlspeQeIyQ7UgPrdorFar9eEEL6Uh2CsWThHDqSlkBzEqBAUNaiivaeT8=
X-Received: by 2002:a17:907:9693:b0:a9a:1cbd:257e with SMTP id
 a640c23a62f3a-a9a1cbd2a10mr370382166b.29.1728976836340; Tue, 15 Oct 2024
 00:20:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241004015937.2286459-1-lulu@redhat.com> <20241004015937.2286459-4-lulu@redhat.com>
 <acb5ea13-9695-4158-9152-aff761401be3@oracle.com> <CACLfguVB0Xn2vsj6kJB9ONv1AhpcUteH9PEqDaPX-7JkxxqvKQ@mail.gmail.com>
 <lpwqg4j2nnh3xgg64vrlk635vcmu2bxrq37sapwp3yl2pdp5rz@lg3wgfop6rkx>
In-Reply-To: <lpwqg4j2nnh3xgg64vrlk635vcmu2bxrq37sapwp3yl2pdp5rz@lg3wgfop6rkx>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 15 Oct 2024 15:19:58 +0800
Message-ID: <CACLfguV1vzs84mKQCQZzT+x5rNo9u+pFwk7i54ng4=OSQdixBA@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] vhost: Add kthread support in function vhost_workers_free()
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Mike Christie <michael.christie@oracle.com>, jasowang@redhat.com, mst@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Oct 2024 at 14:52, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Tue, Oct 15, 2024 at 02:05:47PM +0800, Cindy Lu wrote:
> >On Tue, 15 Oct 2024 at 05:06, Mike Christie <michael.christie@oracle.com> wrote:
> >>
> >> On 10/3/24 8:58 PM, Cindy Lu wrote:
> >> > +static void vhost_workers_free(struct vhost_dev *dev)
> >> > +{
> >> > +     if (enforce_inherit_owner)
> >> > +             vhost_workers_free_task(dev);
> >> > +     else
> >> > +             vhost_workers_free_kthread(dev);
> >> > +}
> >>
> >> With patch 7, userspace could change enforce_inherit_owner after
> >> we created thread and we would call the wrong function above.
> >>
> >enforce_inherit_owner will only change before the owner was set.
>
> As I pointed out in patch 7, enforce_inherit_owner seems to be shared
> among all vhost devices, so what happens if for example a user sets it
> to /dev/vhost-net, while /dev/vhost-vsock is already initialized and
> therefore already has an owner?
>
> Thanks,
> Stefano
>
You are correct, I will think about this and provide a new version
Thanks
cindy

> >the process is like set enforce_inherit_owner---->set owner->
> >thread/task creating
> >in in patch 7's code I have add the check for vhost's owner, if the
> >owner was set, the ioctl
> >to set enforce_inherit_owner will fail
> >Thanks
> >Cindy
> >
> >
>

