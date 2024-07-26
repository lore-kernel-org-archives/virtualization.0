Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5664415666F
	for <virtualization@lists.linux.dev>; Fri, 26 Jul 2024 05:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721973357; cv=none; b=SQjGiTMYjRtotwnQf3ug28QV1NsBTk5YndwIdrLTI6y8MPSNwxfCNG9AeCu+8+5MRXSipyvhHcMGd/CGQvSTl9FSsRHO7kcSy41HXqCKugiUKo8UB7c8rdtKXK0OqmFiJN3eEy2gHlfoAD4TqKr6pFGfz3JElCHs3AkizlDEF3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721973357; c=relaxed/simple;
	bh=fkYfLB7BkpI4W3EQOlvtcDUJr9taWUaCe/cQpnY7uc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tgysXtaVNbI3K+TPgxTH8IQLYMjqXSkdD/GrxiSdFuivsQe3XElLjf3/hJGV813Fq0ljj+uG97rJsKRrIucEpH6CgIc2Y05U5uOopccRkyRDNuNAa8Pm252oRwsj/f8mcTuuB0iV/Lq6uJW2jZcu3oErvzOslbEW3w0/3LwapT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e1Te7lWn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1Te7lWn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721973354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YQThcy6xed9kn8EJsXisAuikWbZtGIN23SlH2PNZkcA=;
	b=e1Te7lWn/sdLgdUQ1fEX0vdHcLlV0BWzR3f6Uk7ZI/V8Zc6lT1Dh16H7WqZfJ7jQySt8li
	FlIEY4VQL3DtX+Xh5xtY3JZf3vfrgRp7dArX5E5XEa+FMiQgRq66qYaNkaCV5Isd6CUxDo
	tK85QSt8yNWc1jMkyFM1XjVJcCy5GCE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-VXcaXSZxMiq5eb_keublQQ-1; Fri, 26 Jul 2024 01:55:52 -0400
X-MC-Unique: VXcaXSZxMiq5eb_keublQQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4280d8e685eso1658785e9.1
        for <virtualization@lists.linux.dev>; Thu, 25 Jul 2024 22:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721973351; x=1722578151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQThcy6xed9kn8EJsXisAuikWbZtGIN23SlH2PNZkcA=;
        b=doFDVKOVcKcZwPX+wATc+W/Dv0qoEzZpVkRgxsGlRgw5BRVWhQwQk9kjg2otgF3s0D
         FYVJTjwH/S69jJRslPcqsGoPNAe+fj2K0+a5e/Ir0qp1gUNi6sNHMck2PLKfJsYroxWP
         e/aP1EBBdihHKp5d8V3a+PqJVDSa6jZi8WFBiPs7gxz1UCyWSRbM6OFdubCNd/WynNTJ
         BrM+cuvOwQzOBuddxo89uZKqk3aZvadPveJCQBOIt4aKVSsWgw023gwO5hN1x2X8isKO
         9O5IxC7PDwLQ4hHVvvdjkyx46BaOuDMOL+AEMtpVH6Qru1Fc9vkn94p3EOjUs0XDsdSY
         IAuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUssTDRdwa+NrJEVO3c77P6b9JpoUG4vaFPIOoSuUnbvz2noE5QRW0JynT7Ng3qMaLyB+EjsLAW9vKBpBNHKsxXNeW3K8AIx2ujJeb4F8w=
X-Gm-Message-State: AOJu0YzhR5aG4G4hIGFIxcSkAXh2WIEvOZfA07k4yZs0RKD6nPlGyL/K
	lNaiNtX2gfKnn2tleM3Iqr5LFqGR95j6ebrOKbk7CWnWABKB9EIP6G3qoXKlI5WBPON0niMDleD
	sOILdiLD0bk34cYa7QrbPpI/uPbLB+LJXx/nvCyEQEoOTBorMITsK/DROEtyqMDNo
X-Received: by 2002:adf:c08b:0:b0:367:8875:dd4c with SMTP id ffacd0b85a97d-36b31ae2541mr2973102f8f.23.1721973351696;
        Thu, 25 Jul 2024 22:55:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwUk9Ft0dVUiNjmu7f1QTIXu6q3o+g6VMlVMK1lSks1buGboeYtzHjiLlkzq1mSCBI88a7sA==
X-Received: by 2002:adf:c08b:0:b0:367:8875:dd4c with SMTP id ffacd0b85a97d-36b31ae2541mr2973059f8f.23.1721973351027;
        Thu, 25 Jul 2024 22:55:51 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:28ce:f21a:7e1e:6a9:f708])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280573edbfsm63673365e9.15.2024.07.25.22.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 22:55:50 -0700 (PDT)
Date: Fri, 26 Jul 2024 01:55:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Peter Hilber <peter.hilber@opensynergy.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
	"Ridoux, Julien" <ridouxj@amazon.com>, virtio-dev@lists.linux.dev,
	"Luu, Ryan" <rluu@amazon.com>,
	"Chashper, David" <chashper@amazon.com>,
	"Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
	"Christopher S . Hall" <christopher.s.hall@intel.com>,
	Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
	netdev@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	qemu-devel <qemu-devel@nongnu.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH] ptp: Add vDSO-style vmclock support
Message-ID: <20240726012933-mutt-send-email-mst@kernel.org>
References: <98813a70f6d3377d3a9d502fd175be97334fcc87.camel@infradead.org>
 <20240725100351-mutt-send-email-mst@kernel.org>
 <2a27205bfc61e19355d360f428a98e2338ff68c3.camel@infradead.org>
 <20240725122603-mutt-send-email-mst@kernel.org>
 <0959390cad71b451dc19e5f9396d3f4fdb8fd46f.camel@infradead.org>
 <20240725163843-mutt-send-email-mst@kernel.org>
 <d62925d94a28b4f8e07d14c1639023f3b78b0769.camel@infradead.org>
 <20240725170328-mutt-send-email-mst@kernel.org>
 <c5a48c032a2788ecd98bbcec71f6f3fb0fb65e8c.camel@infradead.org>
 <20240726010511-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240726010511-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 26, 2024 at 01:09:24AM -0400, Michael S. Tsirkin wrote:
> On Thu, Jul 25, 2024 at 10:29:18PM +0100, David Woodhouse wrote:
> > > > > Then can't we fix it by interrupting all CPUs right after LM?
> > > > > 
> > > > > To me that seems like a cleaner approach - we then compartmentalize
> > > > > the ABI issue - kernel has its own ABI against userspace,
> > > > > devices have their own ABI against kernel.
> > > > > It'd mean we need a way to detect that interrupt was sent,
> > > > > maybe yet another counter inside that structure.
> > > > > 
> > > > > WDYT?
> > > > > 
> > > > > By the way the same idea would work for snapshots -
> > > > > some people wanted to expose that info to userspace, too.
> > 
> > Those people included me. I wanted to interrupt all the vCPUs, even the
> > ones which were in userspace at the moment of migration, and have the
> > kernel deal with passing it on to userspace via a different ABI.
> > 
> > It ends up being complex and intricate, and requiring a lot of new
> > kernel and userspace support. I gave up on it in the end for snapshots,
> > and didn't go there again for this.
> 
> Maybe become you insist on using ACPI?
> I see a fairly simple way to do it. For example, with virtio:
> 
> one vq per CPU, with a single outstanding buffer,
> callback copies from the buffer into the userspace
> visible memory.
> 
> Want me to show you the code?

Couldn't resist, so I wrote a bit of this code.
Fundamentally, we keep a copy of the hypervisor abi
in the device:

struct virtclk_info *vci {
	struct vmclock_abi abi;
};

each vq will has its own copy:

struct virtqueue_info {
	struct scatterlist sg[];
	struct vmclock_abi abi;
}

we add it during probe:
        sg_init_one(vqi->sg, &vqi->abi, sizeof(vqi->abi));
	virtqueue_add_inbuf(vq,
                        vqi->sg, 1,
                        &vq->vabi,
                        GFP_ATOMIC);



We set the affinity for each vq:

       for (i = 0; i < num_online_cpus(); i++)
               virtqueue_set_affinity(vi->vq[i], i);

(virtio net does it, and it handles cpu hotplug as well)

each vq callback would do:

static void vmclock_cb(struct virtqueue *vq)
{
        struct virtclk_info *vci = vq->vdev->priv;
        struct virtqueue_info *vqi = vq->priv;
	void *buf;
        unsigned int len;

	buf = virtqueue_get_buf(vq, &len);
	if (!buf)
		return;

	BUG_ON(buf != &vq->abi);

	spin_lock(vci->lock);
	if (memcmp(&vci->abi, &vqi->abi, sizeof(vqi->abi))) {
		memcpy(&vci->abi, &vqi->abi, sizeof(vqi->abi));
	}

	/* Update the userspace visible structure now */
	.....

	/* Re-add the buffer */
	virtqueue_add_inbuf(vq,
                        vqi->sg, 1,
                        &vqi->abi,
                        GFP_ATOMIC);

	spin_unlock(vi->lock);
}

That's it!
Where's the problem here?

-- 
MST

