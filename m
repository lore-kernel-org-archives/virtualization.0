Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEDA296BA2
	for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 20:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758488188; cv=none; b=JKvRd7am0ISndGDKIVjPjuYLZVW+8rqHq1VHusfkfEq6g8e2MJ7glOrkTgiMmP7H65arJANFwYcgljYLAFS2iFbchdkHtfqx0PGsroT7d+isAUCZUecvtmNDWkJpx9N2DYhjcrlq9LCBqcGDCk/75xQFHgkoCAfNF+gfhiUSIUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758488188; c=relaxed/simple;
	bh=vcRE+eOSUt9r7QlljmvLF/beKVSKoUFncXZuFjVkhlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kvHbyjwiWOpQK/rzejyPIIc6reNhXcrKnzscerNRhNmdbq3oU+F6ih7slHYnV0xc5959s6J9LjMa4uY+c7onTzPiJ+yZqWV43CeelsDKhXcert3mRQJwjarhKYC7DlUMth0KuoG7++nhq4pBpG/za+hLzFLb0wT491faR301V40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iRAdl7SE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iRAdl7SE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758488185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YZa+gvlnzJbu0CdEMidkqaQp0dZ4QxQQFlF/kZd1gcw=;
	b=iRAdl7SECa4uQZ1B4Ac/dJqZS7yeM8Uo44vCOlv5P6yHmxwtd0SvrEyX5jP4YpcmMdqWQq
	Yy4I6VS/bZjCLNbpIuBVeeXHfnyz4JC8dRm1vWyAw8sqV1vqNEmsWEIrfXF9Kn9j+gsZ2/
	kGCzHfIspL7Em+F21hni5233Nt0O31s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-zv9cxGlxOtmTq9Ak15RPFQ-1; Sun, 21 Sep 2025 16:56:21 -0400
X-MC-Unique: zv9cxGlxOtmTq9Ak15RPFQ-1
X-Mimecast-MFC-AGG-ID: zv9cxGlxOtmTq9Ak15RPFQ_1758488180
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45de07b831dso22823735e9.1
        for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 13:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758488180; x=1759092980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZa+gvlnzJbu0CdEMidkqaQp0dZ4QxQQFlF/kZd1gcw=;
        b=eOKGs/mzXSG2AosL1mU6WP7efRxqERakyNA6UNtKjJ46pUX/TKA2e687bpb9upKxVU
         sDuTOEKXVDSTdWxnao6w5xXlBDHoMqHFapAKsCF5pjIraYjuc9vydNnSRM+QGmxZoTRI
         8PRQ0S9gWPhSV5SjErV5g+K5xT2sX50JX7Yhz3ZtMzqiABiNvkc9YLkkgBf4UCKqLj/p
         kprTiy+sq7QPugC0QKsZZ2HYs/VVRuTGPZ4VtowH0fCMWcAV5BJQKeEHLOymXf3rQujX
         RMJYwW0GLWtk4DbElVqhPIl9bd3mAmae2lyhayqckAaJ+aAOMbMaQzGO2lZ04Umwvcgy
         Ll6w==
X-Forwarded-Encrypted: i=1; AJvYcCXlbbKvl8mut1GiXNmmK1p4ZAYW6KNVA7+/Br42JYak76ZY3pmAvwu2DMMo0ZsiQWlL6F9IiG5q10PZcUJbRw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzzGgUIyCFp6sljtX82Tc2Jp5E7taZHg7/kSUuXP+fPQWkYXQVa
	KqhKCzzpIQfHkpr3W1c49loL8EtHfWfpGeZcINLbJZ3k2OcPVfu/p2V1gWdhJf0Gc2BQvOXw6mG
	OUBMIPLkKUQ8LZcGP+abgRsrX13/skF78irJ5aVArQo7VWaoII2JQFBUNM301m2dbTym1
X-Gm-Gg: ASbGncvJONSY9u/b9lH0KNJIgmrUgMq8Vf76TztucL65wn5m9VsN/+dxf8wkQdX6zqI
	i63xJvs31Nm4jwOgCC1IukiwO4mo/vc1dShbcK6ZLkiKX7gPZ3Cb55juQqrzOo1fAB3LUgM0vMF
	tXeu/WF9do10vNrWKokiLwPDcRWucWo9AeE+YgwhwzMZGZgEUA4FojAT+wwYofOXTfgQBTXrsgb
	Zy4LpS0QCKAvW3+8pvDobpFGpTNqNcoIdpf9q5cs9UP7ye6Kgf//F2sy/8+h5C42JEB6Ajk/hqO
	jIzP6C4+wyGPmSiZ7lqhgxfmw1R5OoDsjds=
X-Received: by 2002:a05:600c:9a5:b0:46c:e3df:529e with SMTP id 5b1f17b1804b1-46ce3df54dfmr9206395e9.19.1758488180274;
        Sun, 21 Sep 2025 13:56:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnqwMssDCjhijdZ/zRsJjF/aux8aMPTu3vT6tEWO8ityPhOqzUTeSFi2aStyrPs+FMZNaF1Q==
X-Received: by 2002:a05:600c:9a5:b0:46c:e3df:529e with SMTP id 5b1f17b1804b1-46ce3df54dfmr9206345e9.19.1758488179887;
        Sun, 21 Sep 2025 13:56:19 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f321032a1sm131335005e9.2.2025.09.21.13.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 13:56:19 -0700 (PDT)
Date: Sun, 21 Sep 2025 16:56:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: Take a reference on the task that is reference in
 struct vhost_task.
Message-ID: <20250921165538-mutt-send-email-mst@kernel.org>
References: <20250827194107.4142164-1-seanjc@google.com>
 <20250827201059.EmmdDFB_@linutronix.de>
 <20250918110828-mutt-send-email-mst@kernel.org>
 <20250918154826.oUc0cW0Y@linutronix.de>
 <20250918120607-mutt-send-email-mst@kernel.org>
 <20250918181144.Ygo8BZ-R@linutronix.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250918181144.Ygo8BZ-R@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TE6Tgh7H73buceY-9xApV4uROsUJ7ISlnRya7IkMwko_1758488180
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Subject: that is reference -> that is referenced

On Thu, Sep 18, 2025 at 08:11:44PM +0200, Sebastian Andrzej Siewior wrote:
> vhost_task_create() creates a task and keeps a reference to its
> task_struct. That task may exit early via a signal and its task_struct
> will be released.
> A pending vhost_task_wake() will then attempt to wake the task and
> access a task_struct which is no longer there.
> 
> Acquire a reference on the task_struct while creating the thread and
> release the reference while the struct vhost_task itself is removed.
> If the task exits early due to a signal, then the vhost_task_wake() will
> still access a valid task_struct. The wake is safe and will be skipped
> in this case.
> 
> Fixes: f9010dbdce911 ("fork, vhost: Use CLONE_THREAD to fix freezer/ps regression")
> Reported-by: Sean Christopherson <seanjc@google.com>
> Closes: https://lore.kernel.org/all/aKkLEtoDXKxAAWju@google.com/
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/vhost_task.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index bc738fa90c1d6..27107dcc1cbfe 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -100,6 +100,7 @@ void vhost_task_stop(struct vhost_task *vtsk)
>  	 * freeing it below.
>  	 */
>  	wait_for_completion(&vtsk->exited);
> +	put_task_struct(vtsk->task);
>  	kfree(vtsk);
>  }
>  EXPORT_SYMBOL_GPL(vhost_task_stop);
> @@ -148,7 +149,7 @@ struct vhost_task *vhost_task_create(bool (*fn)(void *),
>  		return ERR_CAST(tsk);
>  	}
>  
> -	vtsk->task = tsk;
> +	vtsk->task = get_task_struct(tsk);
>  	return vtsk;
>  }
>  EXPORT_SYMBOL_GPL(vhost_task_create);
> -- 
> 2.51.0

