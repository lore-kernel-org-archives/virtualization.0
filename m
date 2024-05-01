Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74A11BDD5
	for <virtualization@lists.linux.dev>; Wed,  1 May 2024 05:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714542749; cv=none; b=NO926ztvOklWj1OfZ02ckSmXrRogIFgULDl/pf0aKQQNZy021whR10i8DpNdwXv3mKzHf9uX0RX5h1GfElZ2NlRYF5eskjnKFqnQinaeYyx4NkAv5PAoMJumdL7dvCZ2h+qp8cMWEIPj3uvgEUvK3H6KJzI24/EZDsx1/+PWieA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714542749; c=relaxed/simple;
	bh=1nSr9Dg9aeCD6ofDp9t4KN3z2l/uZPlh2laVEmngj3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UJrFp0+HI5kPj7MEVo1cFI4BUBOQCcMxP1E/N7BdfJJC9CqS4LDSb1x6Z+aq9VNCn/0Mwv0QHX4R40Rw+5ghqvXrBOv/q9AALmS3dsp50Kg8NTN54lEMME7ZmpqcFGMfzGNZ2YJb5g0ZqAmFR08t1izfPiw4tG3ULWUt2NuSPjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K1l2n20s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1l2n20s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714542746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=20n5h1sY1heSuCVbLnxOhUJlUUXIFUfl98aiHfNTEi0=;
	b=K1l2n20sCUtdz46j6rJY6Fmw79E5dR+OpCm5xzQXdJCI499iaEQSOn8tC1hstpoozlzDbG
	wMkuBVVUqiRz4w0iQGNPk7y0dQpOWFfQP5kH8aclNMA38tYxBVKdj/n1SasWbngc5ARhw8
	K6Jx/F1Y5E+S6AZrmfZex7LcJjeeggo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-PCCUN-9rOAyxPaKrb9j5tA-1; Wed, 01 May 2024 01:52:25 -0400
X-MC-Unique: PCCUN-9rOAyxPaKrb9j5tA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a58f874ca11so212104966b.1
        for <virtualization@lists.linux.dev>; Tue, 30 Apr 2024 22:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714542744; x=1715147544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20n5h1sY1heSuCVbLnxOhUJlUUXIFUfl98aiHfNTEi0=;
        b=O4DIOPs0LUZORMavFG5rDhSkufF8BiOGyW9MP5li/qJNEcmaDlTQGcyDSWNsJiI4aO
         c6jiy9MSS0rWQfqBzsxxMPrefCeUjx29zrXNEgPPkn1bxqrqMWmhzZ/0zuFTaPdU6fUx
         /AKeLC8ySe2gxn1fFAXOq/YTcQ/xPWSbv8IXriCPh+VpcC36gh0f9Q17pxKB2TnJ9Ry8
         FMQvvN9Mf4o/cxoN5Pcobj+UgpLuGRw/lC16qJJrvtNSB1CUeGHcQR3DRUvyPxDqvXlA
         bDKk8IMIa2RrquQxfENaGzdpDvSxKyP67OUK5lED/+QTl8JFLdQ71aC98y5tvnpAtzvf
         UwUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDX8fxxkTAVvADR+K3ED57AH0WA5vf27OlF99JneYfqynCowMFEEq/SQYmh3MkbfdweoUIOmaNVniF0ChMYz/bjtFAayLB/6rSiovf6TE=
X-Gm-Message-State: AOJu0YyV9IL8x8BY4TxDO/KiryV5aXc4dTX21Jj6fidwQc07rC1aU+CC
	CS70q/dOITAMVuhd5+olDTljWXyKERZhLknBt2nNIzjkrH19ik5I+G0QZthzgTSEpYwYTQBbzaF
	noWK80dCjXvth9e6CgrSva0LKU/y6++GjwXSXaxU8UOY50rWEUnxBxgqrL/ypMXIW
X-Received: by 2002:a17:906:a24e:b0:a58:866a:1e80 with SMTP id bi14-20020a170906a24e00b00a58866a1e80mr991885ejb.36.1714542743897;
        Tue, 30 Apr 2024 22:52:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBGvs60kCUCPWvX1cwlAhol2+CkeL02isqut8YkmaCVV+Z+zcH4uvAU7Plv220noZVfxO0rg==
X-Received: by 2002:a17:906:a24e:b0:a58:866a:1e80 with SMTP id bi14-20020a170906a24e00b00a58866a1e80mr991871ejb.36.1714542743405;
        Tue, 30 Apr 2024 22:52:23 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:6a42:bb79:449b:3f0b:a228])
        by smtp.gmail.com with ESMTPSA id ld4-20020a170906f94400b00a5906d14c31sm2821481ejb.64.2024.04.30.22.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 22:52:22 -0700 (PDT)
Date: Wed, 1 May 2024 01:52:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: Hillf Danton <hdanton@sina.com>, Edward Adam Davis <eadavis@qq.com>,
	syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com,
	jasowang@redhat.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Subject: Re: [PATCH next] vhost_task: after freeing vhost_task it should not
 be accessed in vhost_task_fn
Message-ID: <20240501014753-mutt-send-email-mst@kernel.org>
References: <20240501001544.1606-1-hdanton@sina.com>
 <59d61db8-8d3a-44f1-b664-d4649615afc7@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <59d61db8-8d3a-44f1-b664-d4649615afc7@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 30, 2024 at 08:01:11PM -0500, Mike Christie wrote:
> On 4/30/24 7:15 PM, Hillf Danton wrote:
> > On Tue, Apr 30, 2024 at 11:23:04AM -0500, Mike Christie wrote:
> >> On 4/30/24 8:05 AM, Edward Adam Davis wrote:
> >>>  static int vhost_task_fn(void *data)
> >>>  {
> >>>  	struct vhost_task *vtsk = data;
> >>> @@ -51,7 +51,7 @@ static int vhost_task_fn(void *data)
> >>>  			schedule();
> >>>  	}
> >>>  
> >>> -	mutex_lock(&vtsk->exit_mutex);
> >>> +	mutex_lock(&exit_mutex);
> >>>  	/*
> >>>  	 * If a vhost_task_stop and SIGKILL race, we can ignore the SIGKILL.
> >>>  	 * When the vhost layer has called vhost_task_stop it's already stopped
> >>> @@ -62,7 +62,7 @@ static int vhost_task_fn(void *data)
> >>>  		vtsk->handle_sigkill(vtsk->data);
> >>>  	}
> >>>  	complete(&vtsk->exited);
> >>> -	mutex_unlock(&vtsk->exit_mutex);
> >>> +	mutex_unlock(&exit_mutex);
> >>>  
> >>
> >> Edward, thanks for the patch. I think though I just needed to swap the
> >> order of the calls above.
> >>
> >> Instead of:
> >>
> >> complete(&vtsk->exited);
> >> mutex_unlock(&vtsk->exit_mutex);
> >>
> >> it should have been:
> >>
> >> mutex_unlock(&vtsk->exit_mutex);
> >> complete(&vtsk->exited);
> > 
> > JFYI Edward did it [1]
> > 
> > [1] https://lore.kernel.org/lkml/tencent_546DA49414E876EEBECF2C78D26D242EE50A@qq.com/
> 
> Thanks.
> 
> I tested the code with that change and it no longer triggers the UAF.

Weird but syzcaller said that yes it triggers.

Compare
000000000000dcc0ca06174e65d4@google.com
which tests the order
	mutex_unlock(&vtsk->exit_mutex);
	complete(&vtsk->exited);
that you like and says it triggers

and
00000000000097bda906175219bc@google.com
which says it does not trigger.

Whatever you do please send it to syzcaller in the original
thread and then when you post please include the syzcaller report.

Given this gets confusing I'm fine with just a fixup patch,
and note in the commit log where I should squash it.


> I've fixed up the original patch that had the bug and am going to
> resubmit the patchset like how Michael requested.
> 

