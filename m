Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B47E125B3
	for <virtualization@lists.linux.dev>; Sat,  9 Dec 2023 10:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="czHkUlaR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702118552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jYXGvxRUfrhZD8ZKPprmEb3EjUd1OkMKc/tesKE8NYk=;
	b=czHkUlaRiaNFarIf6BSDsjk88VT9tvhozYXPxIXUCUsU23g9TIrnlziiDoKha1CmmfKduO
	fstOCHzGxgW31FGX+UT7NbBStab/JULX1Moikmk0df3Z+R/0IU2oGGeu6bM+GtHKXojTK0
	zAxPpMNgGAd0ec6MER5K97T9Q7at8bI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-6Fvx6rq9N16H80VyVSSdmg-1; Sat, 09 Dec 2023 05:42:30 -0500
X-MC-Unique: 6Fvx6rq9N16H80VyVSSdmg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40c27a351e2so17506395e9.2
        for <virtualization@lists.linux.dev>; Sat, 09 Dec 2023 02:42:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702118549; x=1702723349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYXGvxRUfrhZD8ZKPprmEb3EjUd1OkMKc/tesKE8NYk=;
        b=XZwr13TVKPXFw1249QAvRLZxebIk68MIVfaP/Y+4g+quaJlpGtFNxU5ndPH6WfOALu
         0WtTdm8G+TKQuVdddwXmRc/1sQqTVvlVDXUAES2NjdDvXq/yj+U1JbY0Q69ndF8+pWbW
         qwYFF9gmwFinZe53a0reyqwmLDfhdRLjH1n/50HyO8cAZY4QwnUpSYnBMPSN1rcyJ+Lv
         TxzfX4x4B/imeU0u3mkCdMuuftLLLTpR5xI8vDh/iK+dAcCUnF5Xm/PEwiSqsX6+8PGi
         25DfDK+kO8Z3Vw3dBjt4b3CtYIf6SNgUU9EnH6RuYGJqPXDj9mNt2xm0lDfHfsg42UCi
         FDjA==
X-Gm-Message-State: AOJu0Ywkc0KSlkhV1bdQzKfQV6/R9ptZVV4DuonC+GuO/hdJx9HSYFQM
	RLgiVvGVQncWLWdT0ZGFj2jYOALlvaT4QWno74aPa9urRSVrwVjKJOhero4YvjcGnkMHel+jRnM
	DiQPVoo9yzff+UATiHhc1cY9PWVo=
X-Received: by 2002:a05:600c:808:b0:40c:32df:da03 with SMTP id k8-20020a05600c080800b0040c32dfda03mr347243wmp.305.1702118549569;
        Sat, 09 Dec 2023 02:42:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdC86jKPcminvAV1YfnbyeFnlInlsAzYlkskejvPuH6o846ik+MKMa3TBW5xfIsAmcSOb+EA==
X-Received: by 2002:a05:600c:808:b0:40c:32df:da03 with SMTP id k8-20020a05600c080800b0040c32dfda03mr347239wmp.305.1702118549151;
        Sat, 09 Dec 2023 02:42:29 -0800 (PST)
Received: from redhat.com ([2a06:c701:73ff:4f00:b091:120e:5537:ac67])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c138f00b004060f0a0fd5sm6031663wmf.13.2023.12.09.02.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 02:42:28 -0800 (PST)
Date: Sat, 9 Dec 2023 05:42:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tobias Huschle <huschle@linux.ibm.com>
Cc: Abel Wu <wuyun.abel@bytedance.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	jasowang@redhat.com
Subject: Re: Re: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6
 sched/fair: Add lag based placement)
Message-ID: <20231209053443-mutt-send-email-mst@kernel.org>
References: <46a997c2-5a38-4b60-b589-6073b1fac677@bytedance.com>
 <ZVyt4UU9+XxunIP7@DESKTOP-2CCOB1S.>
 <20231122100016.GO8262@noisy.programming.kicks-ass.net>
 <6564a012.c80a0220.adb78.f0e4SMTPIN_ADDED_BROKEN@mx.google.com>
 <d4110c79-d64f-49bd-9f69-0a94369b5e86@bytedance.com>
 <07513.123120701265800278@us-mta-474.us.mimecast.lan>
 <20231207014626-mutt-send-email-mst@kernel.org>
 <56082.123120804242300177@us-mta-137.us.mimecast.lan>
 <20231208052150-mutt-send-email-mst@kernel.org>
 <53044.123120806415900549@us-mta-342.us.mimecast.lan>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <53044.123120806415900549@us-mta-342.us.mimecast.lan>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 08, 2023 at 12:41:38PM +0100, Tobias Huschle wrote:
> On Fri, Dec 08, 2023 at 05:31:18AM -0500, Michael S. Tsirkin wrote:
> > On Fri, Dec 08, 2023 at 10:24:16AM +0100, Tobias Huschle wrote:
> > > On Thu, Dec 07, 2023 at 01:48:40AM -0500, Michael S. Tsirkin wrote:
> > > > On Thu, Dec 07, 2023 at 07:22:12AM +0100, Tobias Huschle wrote:
> > > > > 3. vhost looping endlessly, waiting for kworker to be scheduled
> > > > > 
> > > > > I dug a little deeper on what the vhost is doing. I'm not an expert on
> > > > > virtio whatsoever, so these are just educated guesses that maybe
> > > > > someone can verify/correct. Please bear with me probably messing up 
> > > > > the terminology.
> > > > > 
> > > > > - vhost is looping through available queues.
> > > > > - vhost wants to wake up a kworker to process a found queue.
> > > > > - kworker does something with that queue and terminates quickly.
> > > > > 
> > > > > What I found by throwing in some very noisy trace statements was that,
> > > > > if the kworker is not woken up, the vhost just keeps looping accross
> > > > > all available queues (and seems to repeat itself). So it essentially
> > > > > relies on the scheduler to schedule the kworker fast enough. Otherwise
> > > > > it will just keep on looping until it is migrated off the CPU.
> > > > 
> > > > 
> > > > Normally it takes the buffers off the queue and is done with it.
> > > > I am guessing that at the same time guest is running on some other
> > > > CPU and keeps adding available buffers?
> > > > 
> > > 
> > > It seems to do just that, there are multiple other vhost instances
> > > involved which might keep filling up thoses queues. 
> > > 
> > 
> > No vhost is ever only draining queues. Guest is filling them.
> > 
> > > Unfortunately, this makes the problematic vhost instance to stay on
> > > the CPU and prevents said kworker to get scheduled. The kworker is
> > > explicitly woken up by vhost, so it wants it to do something.
> > > 
> > > At this point it seems that there is an assumption about the scheduler
> > > in place which is no longer fulfilled by EEVDF. From the discussion so
> > > far, it seems like EEVDF does what is intended to do.
> > > 
> > > Shouldn't there be a more explicit mechanism in use that allows the
> > > kworker to be scheduled in favor of the vhost?
> > > 
> > > It is also concerning that the vhost seems cannot be preempted by the
> > > scheduler while executing that loop.
> > 
> > 
> > Which loop is that, exactly?
> 
> The loop continously passes translate_desc in drivers/vhost/vhost.c
> That's where I put the trace statements.
> 
> The overall sequence seems to be (top to bottom):
> 
> handle_rx
> get_rx_bufs
> vhost_get_vq_desc
> vhost_get_avail_head
> vhost_get_avail
> __vhost_get_user_slow
> translate_desc               << trace statement in here
> vhost_iotlb_itree_first

I wonder why do you keep missing cache and re-translating.
Is pr_debug enabled for you? If not could you check if it
outputs anything?
Or you can tweak:

#define vq_err(vq, fmt, ...) do {                                  \
                pr_debug(pr_fmt(fmt), ##__VA_ARGS__);       \
                if ((vq)->error_ctx)                               \
                                eventfd_signal((vq)->error_ctx, 1);\
        } while (0)

to do pr_err if you prefer.

> These functions show up as having increased overhead in perf.
> 
> There are multiple loops going on in there.
> Again the disclaimer though, I'm not familiar with that code at all.


So there's a limit there: vhost_exceeds_weight should requeue work:

        } while (likely(!vhost_exceeds_weight(vq, ++recv_pkts, total_len)));

then we invoke scheduler each time before re-executing it:


{       
        struct vhost_worker *worker = data;
        struct vhost_work *work, *work_next;
        struct llist_node *node;
        
        node = llist_del_all(&worker->work_list);
        if (node) {
                __set_current_state(TASK_RUNNING);

                node = llist_reverse_order(node);
                /* make sure flag is seen after deletion */
                smp_wmb();
                llist_for_each_entry_safe(work, work_next, node, node) {
                        clear_bit(VHOST_WORK_QUEUED, &work->flags);
                        kcov_remote_start_common(worker->kcov_handle);
                        work->fn(work);
                        kcov_remote_stop();
                        cond_resched();
                }
        }

        return !!node;
}       

These are the byte and packet limits:

/* Max number of bytes transferred before requeueing the job.
 * Using this limit prevents one virtqueue from starving others. */
#define VHOST_NET_WEIGHT 0x80000

/* Max number of packets transferred before requeueing the job.
 * Using this limit prevents one virtqueue from starving others with small
 * pkts.
 */
#define VHOST_NET_PKT_WEIGHT 256


Try reducing the VHOST_NET_WEIGHT limit and see if that improves things any?

-- 
MST

