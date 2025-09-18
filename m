Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130A02F7AC2
	for <virtualization@lists.linux.dev>; Thu, 18 Sep 2025 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211697; cv=none; b=LEftKxBp9Qg4aqocrc820oHDGI8ah/6g0R8djsf68v0AeiYq7bNdlsCGLCVj425VZnG8vfJaKXctWO0d9Lrnr7LIH1iZb0MaKIg2NojO67soPgPAsQDEBn/Hv5NI959AUTQpV2LwcLMFFdENP4cxIW3aJKKuNMdeJL40j1Td1KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211697; c=relaxed/simple;
	bh=JL/qBQ0n0kWZf+AaO8KDJFGjeMqMIUgMtsxBe3k+j+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=AKEYaF9w4fZaE3bW6HHAfmM0Nnvy6yn03NcPAFb50nertEGKLr9UssfLeMhHBlChtKg5t8gmlHAi9Sb6GB+Z9nTp6e6AUrT2O/qCteNAT1frgFsVuUB6SreKDw7onYQ3wV/R6qKMYzjlZYUO0JXi1TzASAr/4CCAz/vY9KrF25g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GPz0rlXW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPz0rlXW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758211695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q3W1jIekrmUS7hGw0PvTqPX4tAe8HmRxhRJM5xSdG6I=;
	b=GPz0rlXWlk1dj//3hCo0FvDp1STSztDzzJFpHem4HP9XKZyaYJHSVTxjg7s3ut3wjVTTK4
	vf/3joggMiFDcQZC3USL3APJPF/stHroNkmmQJAC2O4RUmZKKEXo/iWaNRyNqeDvQFHuqp
	7dreYp0l/FGDyLc464w/Pye3BQBKMwk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-QfXy-hfDOcunRyfM4OOJPA-1; Thu, 18 Sep 2025 12:08:13 -0400
X-MC-Unique: QfXy-hfDOcunRyfM4OOJPA-1
X-Mimecast-MFC-AGG-ID: QfXy-hfDOcunRyfM4OOJPA_1758211692
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3e8c4aa37bbso388970f8f.3
        for <virtualization@lists.linux.dev>; Thu, 18 Sep 2025 09:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758211692; x=1758816492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3W1jIekrmUS7hGw0PvTqPX4tAe8HmRxhRJM5xSdG6I=;
        b=L5sOe/4MwiP75P1avWFpBAP+uoXq7vx5hsd6md7OOxBjzj3x0fZ7LY3gEZaO5TmaAQ
         zDVdTn38FOklylR3IhHi46x7hZD/G/K+qPoXTMXvCKhallPuQjWEDTnaCKEU/6eQunKW
         blpIpGueFIeBkwt+/4GTZIl4GMP5LtxKvL2+C9/NTr2ld7mrsVbN+SG7+cpYZmYvb93c
         jHL/y4RWgUZL8z0n2qMmE4jVqW5zKeLjuyNAmijzmOT4fxz2yazjQ1LhMog4to7HdKgf
         jm9KkosAPy31IUCWGsQR+5xGyBNZRGhKD/OQxnsXEpylrP6/FRIe9AA0/FnZuKAQclaL
         akVw==
X-Forwarded-Encrypted: i=1; AJvYcCWanebJJC2+ZoJ0Oj5y7HjsoIFEWJJ6M+DkMbCCCN6YFpRwDuF9NAFtSkGumtUr6AA+H/BNOUYaqtWgPKA8Dg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzgKV7iRlytHCieZsdEIILXAZAaDRx5NGH+ioAMOs47mWb3ZAvH
	gdqTVawQ8VVkpstXui3jACGPILN21ags4FP6LDbIVHakdQqaeljoPlGfP8M+dJcqJn8GdjHjo+1
	6V+OJDJbSI3x7iV8SUL3vmq9bLgEr5292xNGjPH1HxUAs3oAhixMblyOSqqqQif91Ugeq
X-Gm-Gg: ASbGnctTWM4w95FH/2O5lo1ioG6LGgJoOHcbQHw9RI3s5vBv2yuK7TJSTjo7GBPiO2v
	v3LX1kxcxLQuOgEHGx/zLOXIsgf2id+t2/6AL0oMinZm5proF4zAdrBhgZgCoTEA8nm5M6gdqiw
	j0+vJXsR8kuV3egd4BmJiatYOYDDqN4visYhEo2FUBvoLkh+4wFW0YbHTVW59xdB9PfmihHTU72
	0dy9aD/cN3J9PJj121VgsSosye1XN+ES9dmyxRNEQEKBRS0OpzDKmYF6WMlHOJlgkLtmB642OhY
	x9TDf+IZPJYq0GKJoABFEI40NE29V/gxWNY=
X-Received: by 2002:a05:6000:200e:b0:3eb:f90a:f6cd with SMTP id ffacd0b85a97d-3ecdfa3ce7emr7085258f8f.60.1758211692368;
        Thu, 18 Sep 2025 09:08:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFONswKfp43OXLfg7nMNxh+zteAfi3TDzbvWnbk+eZ4aXLcjPUcMbF4AA2QkD6aFfodROyxZA==
X-Received: by 2002:a05:6000:200e:b0:3eb:f90a:f6cd with SMTP id ffacd0b85a97d-3ecdfa3ce7emr7085210f8f.60.1758211691864;
        Thu, 18 Sep 2025 09:08:11 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee106fd0edsm3919680f8f.53.2025.09.18.09.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 09:08:11 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:08:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] vhost_task: Fix a bug where KVM wakes an exited
 task
Message-ID: <20250918120658-mutt-send-email-mst@kernel.org>
References: <20250827194107.4142164-1-seanjc@google.com>
 <20250827201059.EmmdDFB_@linutronix.de>
 <20250918110828-mutt-send-email-mst@kernel.org>
 <20250918154826.oUc0cW0Y@linutronix.de>
 <aMwtd40q44q5uqwr@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aMwtd40q44q5uqwr@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7_bKFjj51o1namvJOsEgzpbJK-0DQsdzH72cdQfZsZk_1758211692
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 18, 2025 at 09:04:07AM -0700, Sean Christopherson wrote:
> On Thu, Sep 18, 2025, Sebastian Andrzej Siewior wrote:
> > On 2025-09-18 11:09:05 [-0400], Michael S. Tsirkin wrote:
> > > So how about switching to this approach then?
> > > Instead of piling up fixes like we seem to do now ...
> 
> I don't have a strong preference for 6.17, beyond landing a fix of some kind.
> I think there are three options for 6.17, in order of "least like to break
> something":
> 
>  1. Sebastian's get_task_struct() fix


I am just a bit apprehensive that we don't create a situation
where we leak the task struct somehow, given the limited
testing time. Can you help me get convinced that risk is 0?

>  2. This series, without the KILLED sanity check in __vhost_task_wake()
>  3. This series, with my fixup (with which syzbot was happy)
> 
> Longer term, I'd still like to land everything though.

No problem with that.

> > > Sean?
> > 
> > Since I am in To: here. You want me to resent my diff as a proper patch?
> 
> Ya, I think it makes sense to harden against UAF even if we fix the KVM bug more
> directly.

