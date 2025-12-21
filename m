Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7277C1E86E
	for <virtualization@lists.linux.dev>; Sun, 21 Dec 2025 13:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766324816; cv=none; b=GXmPlM7yeQmuP0pbn35TDEduM+0DpOoJ6sfluO6eDvvu9RjoTYaNGxdsIFAywW5o/VljOPqnucsjRpEcur6UKSMgG1MUZdPE6Qp4crqPAtYFo6yx23z92WdQdtc2/6wQRjYYYW4NQuVWT7lbSaBkhfuPX4axqFsaE+olV06tPTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766324816; c=relaxed/simple;
	bh=9xYl1VpPyJGY+P/31o4U1JCkKm7c9uAW2DxHgwgFs74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fK86Oko0tS8ZXhfpGaWj+UdXu8R6NxtqGTKL8OhLzvIjhdB/kAdpYTrGcaTi0e5EEmMJ2mgmX/m7BPd5b4BZKL2m7x6ksqbZbrvhwuCFKT1KpDgEsU50AV4DRzlerYhPYibAsoYontnX4YplCD19Uv571r1q0kqaE4jAZ4/RhQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YoNeEeXi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YoNeEeXi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766324813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qH/Hk/c+g6HO0+WmP7cqogfgGgDVjbL6kvaPvTk31Vs=;
	b=YoNeEeXi/xrIkAqIRMZvbn33xB8tXSTWWQu/dELfpbW6SPZgfJtTo9KH7wlS+pXG6LPPRn
	Yz4+3HdlcMPU1YO8805+W/ZEqpsoPfgflQGi6oZ7Ej5KBhYGWnCs/96m6qUBmv/Oyz/K9m
	40dCmGuq44/GDWp+ZJ4Z+AHCxvpRpIs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-_Go3pKRGO3K3D03GJnYv6A-1; Sun, 21 Dec 2025 08:46:51 -0500
X-MC-Unique: _Go3pKRGO3K3D03GJnYv6A-1
X-Mimecast-MFC-AGG-ID: _Go3pKRGO3K3D03GJnYv6A_1766324811
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-431026b6252so3043163f8f.1
        for <virtualization@lists.linux.dev>; Sun, 21 Dec 2025 05:46:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766324811; x=1766929611;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qH/Hk/c+g6HO0+WmP7cqogfgGgDVjbL6kvaPvTk31Vs=;
        b=q4/9R4390XKbLoNPYH63nCNodv1YxYFLKCZMtWlSOTbU5UaqUjvehJNdHE7PcQpUbF
         C2SN8HWt7AGIyW+Hyrgp2xvmh0DsH7If1a6clDG+PRbjcOjNRkzlLuSrtb6Spnn6S9yN
         IOr3GXsrO1YbPRwwWf6bbaQYJTg/EFqtTNrsGFNvwC0xC0EtobXqTRYUvUOiAqKDZ+Qs
         nIElSa3o49SzTd8ZloON8dD4XFFkON0uzPUoOynKI2qc5x3DrK2kp8mZz98vFBWUUp9j
         BlXx62p0LekKxfFKzbM/6wl9vPw/BTWMpV0oby4tjcvA9tLz9GszUjYp8Iv4dYa1WEnY
         FrgA==
X-Forwarded-Encrypted: i=1; AJvYcCUQdgRlUWR9CUi9rpyCsOYYspr09ClJXFr+LMfkXjmEdT8xSPZeacWV7m7cb+M8U5n0fJ17u0apVKaDaiDOHg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQBPRdwT8nKpc2e8n0mqNlMWw1rlLYuL0h6A97YTLGSaI9/Knd
	kMa2siyBebKwyWHlIuqkh0BzTUYgPU0pyGrt+MjRfCGHxLUbZpYgog9NvA8mV9zKCsbOgCQCoXg
	K5UYIKg8kmtRC0qzY3BIkfUQAiNw9J2amTZQ9JZoMi8vH/qGGAFJ5Uu1dyFMVLkbDa6Dc
X-Gm-Gg: AY/fxX47uufHG/CE11ekObSBReQcfzalhVzBko24Xk6JDDfsj0bLmKdHSkF6oAZJZiR
	MomiXnlfnZQzTiBjS5Vhd4PWdgKwUbQyj2egEipuSV9JwmjxMG7I5p+lALUQh0IBAyEsWh97gWo
	mzuUAHADCU7vvzSuNhk4VPdq3254dDCqMKG+RBeKQpRTIonwXGkhEpSx78UmR62/+asiB9dpGeS
	V5Ky23QwDIHejFS4Ys5NJAUuwmQ87vCZ4zW0KSRDalN+tAASekVpIqjW/IUUy+aL0jPkcTVAglI
	dQbXJQ3grfgsVywlSiFplGQQ0JHBRZ2659aJL3enuP95BCgapK4dw7QAFoCyf9yMBq56ObpZVYe
	Ucd0UVo/xXP/jlZ+cOWV7FhnD7HMcLazvuQ==
X-Received: by 2002:a05:6000:1861:b0:42b:4081:ccb8 with SMTP id ffacd0b85a97d-4324e4cd796mr10763783f8f.23.1766324810586;
        Sun, 21 Dec 2025 05:46:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlqXiItQ9OzU+oVmIJ5BphjeDkvrJIIgkdhBoM/Dj4AawBQvvynmgns4wZn+2oTnSwXIc3mA==
X-Received: by 2002:a05:6000:1861:b0:42b:4081:ccb8 with SMTP id ffacd0b85a97d-4324e4cd796mr10763769f8f.23.1766324810150;
        Sun, 21 Dec 2025 05:46:50 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea2278dsm16434929f8f.18.2025.12.21.05.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 05:46:48 -0800 (PST)
Date: Sun, 21 Dec 2025 08:46:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lange Tang <lange_tang@163.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	Tang Longjun <tanglongjun@kylinos.cn>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Subject: Re: Re: Re: Re: Re: [PATCH v1 0/7] introduce virtnet_mon for monitor
 virtio_net
Message-ID: <20251221084629-mutt-send-email-mst@kernel.org>
References: <20251127032407.33475-1-lange_tang@163.com>
 <20251210040328-mutt-send-email-mst@kernel.org>
 <4820b08f.2d13.19b0b523dcb.Coremail.lange_tang@163.com>
 <CACGkMEt-v2RGTbzEgfocpZvZw1SKB8j4MQ6zoMFvGJQXXFuMtQ@mail.gmail.com>
 <64d63e98.e7f.19b1595bd4e.Coremail.lange_tang@163.com>
 <CACGkMEvZQb1ADyEM73jE8_OdeU8YtSbR8YCJ+3anDg8VhkpBLg@mail.gmail.com>
 <5ecbc090.8006.19b21117c0a.Coremail.lange_tang@163.com>
 <CACGkMEvjr_iVBzHa8GxKCsn=h1EbWzmVrCkpTy+Rc51gWaxH3w@mail.gmail.com>
 <20d26393.751f.19b26214d83.Coremail.lange_tang@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20d26393.751f.19b26214d83.Coremail.lange_tang@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rfT7GQu_Ldb3U071XyOjGXLh9ViVt8mmRnJtk4NpeWg_1766324811
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Dec 16, 2025 at 03:47:55PM +0800, Lange Tang wrote:
> At 2025-12-16 11:59:14, "Jason Wang" <jasowang@redhat.com> wrote:
> >On Mon, Dec 15, 2025 at 4:12 PM Lange Tang <lange_tang@163.com> wrote:
> >>
> >> At 2025-12-15 14:41:42, "Jason Wang" <jasowang@redhat.com> wrote:
> >> >On Sat, Dec 13, 2025 at 10:41 AM Lange Tang <lange_tang@163.com> wrote:
> >> >>
> >> >> At 2025-12-11 16:32:15, "Jason Wang" <jasowang@redhat.com> wrote:
> >> >> >On Thu, Dec 11, 2025 at 10:52 AM Lange Tang <lange_tang@163.com> wrote:
> >> >> >>
> >> >> >> At 2025-12-10 17:04:04, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> >> >> >On Thu, Nov 27, 2025 at 11:24:00AM +0800, Longjun Tang wrote:
> >> >> >> >> From: Tang Longjun <tanglongjun@kylinos.cn>
> >> >> >> >>
> >> >> >> >> hi,
> >> >> >> >> virtnet_mon is used to monitor the data packets of the virtio_net driver
> >> >> >> >> and the related parameters of virtqueue, useful for tracking its status
> >> >> >> >> and troubleshooting faults.
> >> >> >> >>
> >> >> >> >> pls review. tks
> >> >> >> >>
> >> >> >> >> Best regard.
> >> >> >> >
> >> >> >> >what does this achieve that direct use of tracing would not?
> >> >> >>
> >> >> >> I apologize that my explanation of virtnet_mon was not detailed enough.
> >> >> >> virtnet_mon uses kprobe and buffers to monitor virtio_net.
> >> >> >> To monitor virtio_net, it is necessary to track the member parameters of the virtqueue corresponding to each data packet and output them.
> >> >> >> When PPS very high, other tracing techniques, such as ebpf, may not be able to handle it, resulting in data loss because they do not have sufficiently large buffers to batch export log data.
> >> >> >
> >> >> >Can you expand more about this? For example, in which kind of setup
> >> >> >and what do you want to trace and why ebpf can't handle that. Note
> >> >> >that the most lightweight stuff is the counter, have you tried that?
> >> >>
> >> >> For example, when there is occasional latency in data transmission between the
> >> >> virtual network frontend (virtio_net) and backend (such as vhost_net),
> >> >> we may need to track the time taken for each packet received and sent in the virtio_net driver.
> >> >> Typically, we accomplish this using eBPF, such as bpftrace. The pseudocode might include the following:
> >> >> """
> >> >> kprobe:skb_recv_done {
> >> >>         printf("%ld skb_recv_done Cpu:%d ...\n",...);
> >> >> }
> >> >> kprobe:skb_xmit_done {
> >> >>         printf("%ld skb_xmit_done Cpu:%d ...\n",...);
> >> >> }
> >> >> kprobe:virtnet_poll {
> >> >>         printf("%ld virtnet_poll Cpu:%d budget:%d ...\n",...);
> >> >> }
> >> >> kprobe:start_xmit {
> >> >>   ...
> >> >>   printf("%ld start_xmit Cpu:%d type:%s seq:%ld ...\n",...)
> >> >> }
> >> >> kprobe:gro_receive_skb {
> >> >>   ...
> >> >>   printf("%ld gro_receive_skb Cpu:%d type:%s seq:%ld ...\n",...)
> >> >> }
> >> >> kprobe:receive_buf {
> >> >>   ...
> >> >>   printf("%ld receive_buf Cpu:%d name:%s avali_idx:%d used_idx:%d ...\n",...);
> >> >> }
> >> >> """
> >> >> Using the above bpftrace code, we can track the timestamps of the data as it passes through these functions,
> >> >> along with skb and virtqueue information, and output logs via printf for further diagnosis of the causes of the latency.
> >> >> Interestingly, a significant amount of logs were found to be missing when executing these bpftrace codes.
> >> >> Below is the testing environment:
> >> >> VM: 8G8C，virtio_net mq=4, kernel 6.18-rc7, iperf3 -s -p 1314
> >> >> HOST: iperf3 -c 192.168.122.218 -t 100 -p 1314 -P 4
> >> >> It was also found that when testing with mq=1, there was no log loss.
> >> >>
> >> >> Compared to mq=1, the reason for log loss at mq=4 is suspected to be due to data being sent or received
> >> >> by different CPUs. Additionally, under the 4-thread iperf testing scenario with PPS > 150,000,
> >> >> the log data is asynchronously output from different CPUs, leading to excessive IO pressure that causes log data loss.
> >> >
> >> >I think what I don't understand is how the things you introduced here
> >> >may help in this case?
> >>
> >> The virtnet_mon module introduced here abandons eBPF and uses kprobe + kfifo.
> >> In the aforementioned cases, all the information that needs to be tracked first enters kfifo,
> >> then is formatted into logs and cached in a large buffer.
> >> Finally, it is exported to user space in batches through the virtnet_mon_read function,
> >> thereby reducing IO pressure and preventing log loss.
> >
> >Well, this "problem" seems not virtio-net specific. Have you tried
> >with BPF ringbuf or perfbuf?
> 
> Concerning the ringbuf and perfbuf in bpf, I may need some time to verify whether this can resolve this "problem".
>  I will get back to you with the results. 
> 
> On the other hand, I did not find any tracepoints in virtio_net that track the virtqueue, 
> such as name, num_free, avail.idx, used.idx, last_used_idx, etc. 
> Could you consider inserting these tracepoints in some key functions? This would facilitate direct tracking by perf. 
> For example:
> start_xmit
> receive_buf
> skb_xmit_done
> skb_recv_done

sure, that's a reasonable thing to add.

> >
> >Thanks
> >
> >>
> >> Thanks
> >> >
> >> >Thanks
> >> >
> >> >>
> >> >> The above are some of my personal thoughts, and I would love to hear your opinion.
> >> >> Best regard.
> >> >>
> >> >> >
> >> >> >>
> >> >> >> As for the duplicate code, it is only to obtain the layout of the relevant structure, and I have not yet thought of a way to avoid duplication. I would love to hear your suggestions.
> >> >> >
> >> >> >Thanks
> >> >> >
> >> >> >>
> >> >> >> >
> >> >> >> >> Tang Longjun (7):
> >> >> >> >>   tools/virtio/virtnet_mon: create misc driver for virtnet_mon
> >> >> >> >>   tools/virtio/virtnet_mon: add kfifo to virtnet_mon
> >> >> >> >>   tools/virtio/virtnet_mon: add kprobe start_xmit
> >> >> >> >>   tools/virtio/virtnet_mon: add kprobe gro_receive_skb
> >> >> >> >>   tools/virtio/virtnet_mon: add kprobe ip_local_deliver
> >> >> >> >>   tools/virtio/virtnet_mon: add kprobe skb_xmit_done and skb_recv_done
> >> >> >> >>   tools/virtio/virtnet_mon: add README file for virtnet_moin
> >> >> >> >>
> >> >> >> >>  tools/virtio/virtnet_mon/Makefile      |   10 +
> >> >> >> >>  tools/virtio/virtnet_mon/README        |   35 +
> >> >> >> >>  tools/virtio/virtnet_mon/virtnet_mon.c | 1048 ++++++++++++++++++++++++
> >> >> >> >>  3 files changed, 1093 insertions(+)
> >> >> >> >>  create mode 100644 tools/virtio/virtnet_mon/Makefile
> >> >> >> >>  create mode 100644 tools/virtio/virtnet_mon/README
> >> >> >> >>  create mode 100644 tools/virtio/virtnet_mon/virtnet_mon.c
> >> >> >> >>
> >> >> >> >> --
> >> >> >> >> 2.43.0

