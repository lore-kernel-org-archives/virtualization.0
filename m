Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCDF175560
	for <virtualization@lists.linux.dev>; Tue, 30 Apr 2024 18:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714500405; cv=none; b=EAjov/sFsx63VqSQ7Fg0VngLmKAB+8g6ofUL1AUrHLsEL05VFp9BaE8z0AxsC/tH4CNOnzVaZhbMEi37BpvufmOQDS1JtVWX5Fzvj8QHzftjgx9hRhq52BzTq1LQn3D4wXFODYXO4SNobKsf9ceo6oMMPKWtteUJ4ITSnw8XuBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714500405; c=relaxed/simple;
	bh=qJioFQM6gatzhNfw88pAwDEH8AUYC7rqX3dJnAvMfM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gASHvyD0PYPJX5mJP8kpx5UMrp+ox5yN3s30DR27HWKiNFNI+2WUMgfOZwXTtvniCVBcrajx4tVbzJnorcKdkwSFG2w75cf8nKHjZi186Aw0JYD3WbPbE1n/cXPz8ZjB1yZldQiMXCJz10MUnyNlE/LpSrpC23a8ARI4rqJ5eSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qv+kOX9G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qv+kOX9G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714500402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F5zx7cpE5g24SyrILpVbFuVBHG+ow92d4f3RUXTPOCU=;
	b=Qv+kOX9G/hX1VU0NvIFhavWeqMZRKyJto7tJy74t39zBiLpiL2ArPnvBmAzax6MkhYlm5V
	TEwxPEbFifiIEvRSF6AmGDfmveMvnjTKKn0t6vuxPYS3r53eogjWRRGarOpN/7RS3svr7c
	z4U6HfKuAmK4DBvkAbySq5/Ri4Rv/UY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-OL7c8g04Piy8wgWTae5uqg-1; Tue, 30 Apr 2024 14:06:41 -0400
X-MC-Unique: OL7c8g04Piy8wgWTae5uqg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-56c1ac93679so4882583a12.2
        for <virtualization@lists.linux.dev>; Tue, 30 Apr 2024 11:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714500399; x=1715105199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5zx7cpE5g24SyrILpVbFuVBHG+ow92d4f3RUXTPOCU=;
        b=E6HRS5uSb1uvnmhEK6RWtLuHAYlcFz2HpRNMGFiJTirSiCS2tFz2vr8+rJmi6xqtnq
         lTPrENdST/RxaM8xTfPfhxt8sM+CopyPEPYUNH1fyuTUiOSTaXDvvZHu3X9g3DLoLEUf
         cFT7l0QtrGaK3OCk9M+o5tXdhp4+XKsTSLkF6LH/DUn8MoXr8jBLGUsPkcGdhAVFaK9e
         AA/3mMxnnY7AiEtaNgRyzT1fw1AOFQnj5Z+CRidnaJwj4yKBwM3ycrU4ZTN/h8QcHkNg
         hKEkdQE4emLM0tI4kJRc2Nj8QhtKXcsb1rrZnvQNChmeZIRVCUyWMnIaPWYMWQWXFVI2
         5w4g==
X-Forwarded-Encrypted: i=1; AJvYcCWacDds1zvvH8llDYj9F2zGAYXR4f18gpYnoy7YHJaAdDBb9gwDYQvJWZj3dPIEdTxJUuA1dpIybg1N0gw85gWIvnuYtR9ksLVFpnXOI1E=
X-Gm-Message-State: AOJu0Yy9nhJK1JpSeJqLItQCVUSWX+Jxxc0IjZZi+yKgVn9nPIFZl+YT
	iPrx8yD8uBdwN8B9kTRyyCOrULpmFXIAOna5ATeqoaMN2uOm/gAVMb4AMbnz1M3gbxylfUFIA8I
	roTlpl0T23ruVwkqx1ysXSvtndWb5A3Genf2hSdRuBElnuZrEVCA3q3CCwQxBmxrMYWkheaIW
X-Received: by 2002:a17:906:dffa:b0:a58:bd8e:f24 with SMTP id lc26-20020a170906dffa00b00a58bd8e0f24mr301836ejc.39.1714500399318;
        Tue, 30 Apr 2024 11:06:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAMU+eVyJELNlfDZqGybmwpL1icWgq7FgiEnNy2tDXnkcVLH1RcMMycitIzluk5myVZUO69Q==
X-Received: by 2002:a17:906:dffa:b0:a58:bd8e:f24 with SMTP id lc26-20020a170906dffa00b00a58bd8e0f24mr301804ejc.39.1714500398788;
        Tue, 30 Apr 2024 11:06:38 -0700 (PDT)
Received: from redhat.com ([2.55.56.94])
        by smtp.gmail.com with ESMTPSA id cd19-20020a170906b35300b00a4673706b4dsm15347234ejb.78.2024.04.30.11.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 11:06:38 -0700 (PDT)
Date: Tue, 30 Apr 2024 14:06:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com,
	jasowang@redhat.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Subject: Re: [PATCH next] vhost_task: after freeing vhost_task it should not
 be accessed in vhost_task_fn
Message-ID: <20240430140613-mutt-send-email-mst@kernel.org>
References: <000000000000a9613006174c1c4c@google.com>
 <tencent_4271296B83A6E4413776576946DAB374E305@qq.com>
 <b959b82a-510f-45c0-9e06-acf526c2f4a1@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <b959b82a-510f-45c0-9e06-acf526c2f4a1@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 30, 2024 at 11:23:04AM -0500, Mike Christie wrote:
> On 4/30/24 8:05 AM, Edward Adam Davis wrote:
> >  static int vhost_task_fn(void *data)
> >  {
> >  	struct vhost_task *vtsk = data;
> > @@ -51,7 +51,7 @@ static int vhost_task_fn(void *data)
> >  			schedule();
> >  	}
> >  
> > -	mutex_lock(&vtsk->exit_mutex);
> > +	mutex_lock(&exit_mutex);
> >  	/*
> >  	 * If a vhost_task_stop and SIGKILL race, we can ignore the SIGKILL.
> >  	 * When the vhost layer has called vhost_task_stop it's already stopped
> > @@ -62,7 +62,7 @@ static int vhost_task_fn(void *data)
> >  		vtsk->handle_sigkill(vtsk->data);
> >  	}
> >  	complete(&vtsk->exited);
> > -	mutex_unlock(&vtsk->exit_mutex);
> > +	mutex_unlock(&exit_mutex);
> >  
> 
> Edward, thanks for the patch. I think though I just needed to swap the
> order of the calls above.
> 
> Instead of:
> 
> complete(&vtsk->exited);
> mutex_unlock(&vtsk->exit_mutex);
> 
> it should have been:
> 
> mutex_unlock(&vtsk->exit_mutex);
> complete(&vtsk->exited);
> 
> If my analysis is correct, then Michael do you want me to resubmit a
> patch on top of your vhost branch or resubmit the entire patchset?

Resubmit all please.

-- 
MST

