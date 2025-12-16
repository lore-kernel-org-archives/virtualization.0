Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A365A3431EC
	for <virtualization@lists.linux.dev>; Tue, 16 Dec 2025 08:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765873683; cv=none; b=fUnbInq8jXzFVzxBJglIUuw6zCgvTX939sFbTdns3eZP44Sj7TUHkP0C+51YtE5JC6qHBDWuXGA+HNsuiFgzvLxJfyx0pPx9AuF0K0sP7hnRL/MHz+MnRDsHJfpTPtj6McL6ZH3Q5zM2FaRh3cx4WAibL+hgL40I+AvwLGjma2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765873683; c=relaxed/simple;
	bh=LmPG2KteSIEFTbXCbT/y2wT7jJ3MdnOc6ox925ucXKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCxUDN/92SFHA0C5KjzxyqDchNCOZ/AlParloHuJc2kmUg1PWT2iBtiJFKZDDkei8mjyrE270OtdBgRX3hQe8k+6HMJl5P+KtBoB/aUj+U54Tphh/rx9eDDwR5/a62LzYrL8uVxg98j1U+K7ILS2pOnOdie37CxC//20y2HHS6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q6Tcp21e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6Tcp21e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765873677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yWXAAe8snWDxAKX8LnlLjaifu4lIot6VPW5PMWrH97U=;
	b=Q6Tcp21eDyUyL0wawWEDh7vEL6WllVfta3U8eUqtVG2A0wlAQPkQ4FKb/Xexy2RreDqAcs
	KtPvknn6/Zgc509HifBXwKWYEB+kVnK3mzFdw7ax4akHe+QgX/4bTgg9Fc45QVFpG4HQcC
	TOwlNiYJX2nXak0ix6xezMY4BQb0LuI=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-6PiYjtR6OD67NT3p4PSWJQ-1; Tue, 16 Dec 2025 03:27:56 -0500
X-MC-Unique: 6PiYjtR6OD67NT3p4PSWJQ-1
X-Mimecast-MFC-AGG-ID: 6PiYjtR6OD67NT3p4PSWJQ_1765873676
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-9411b2335f4so6775589241.3
        for <virtualization@lists.linux.dev>; Tue, 16 Dec 2025 00:27:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765873674; x=1766478474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yWXAAe8snWDxAKX8LnlLjaifu4lIot6VPW5PMWrH97U=;
        b=emm48+yF0ZzYsp8JDps5eySn9ubeh6+JcCX3dj/J/nX4AAlg3KNm0uMA322moYdv6y
         R8IBpv7oByOSussrhHI6cUkg8XX4q29FEWBPIlAOsOf/Puf2tYPE8xEVMCs599PmVD84
         Dm3s7TcgIOobVYu8hke39PAlQVrJ3yB8h/fTKyeEcrRu9VrQYus7xheZKWiL2irpBCIV
         sS9y8tc7v088fTDu4My2TGa5flQE2fakslVGjylfr/yYg/4znLdSXztP6vtWHfYOgvSZ
         g4cdup804Xu6xqsQHeOkvu6O+UiGPvUzX8FNCeA9EF+kxximXhqq0XuE0JsRFhX0mAzB
         34uQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5SpKji8n6eJijoeN75W6rdrcfF864trQBT6v2uVCWoe9JE+Hcf+/RRoO0pGhhTzLr9+Bb8yandcVL1JI4JQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjFn3334vf7nJp1McaXq4drJ2GO4XvaPSD+uPqDyykrE+uXR9f
	UIra4935CoZwtwtWvfbSASCHD0A7Hw3bpAPm0zYXqujAwr9gbgWMkBUBXTh3GjgYFqF9/rlkAF5
	yfwBN+t2GkdSr+rwcSWus/SfY/XJesOT70lJf7NfnWcnXtZwKWaZ9H5AbNP1PvScjcZvZSNS9JO
	CTk8BVpVPbQFHc+NSV5+ABP1Kxbrj2Xxho0vNcM4cCpaCjWZGessRb8GE2
X-Gm-Gg: AY/fxX7u0WrJaeI236HCoVzdHX4b4yFQm+Hff3Lx3VuKgcDa3L5mnPLnuAHtks83HQf
	kjlMK6kFJUru2EMCbFOuuaK5x9K2eJtCMiAwJh4w6CeVezWibBGW169ha7uZQKppn6gTlA02/bf
	cjGfmrRLJi19/Exqg1h1T/IRZ8IsmVXOakXZ0AD1MpI136Le3brtAgSh0pzrfOC4YbFqDA
X-Received: by 2002:a05:6102:951:b0:5de:78e6:494d with SMTP id ada2fe7eead31-5e827835a90mr4444405137.45.1765873674419;
        Tue, 16 Dec 2025 00:27:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzmMGDnaMl2jajyZBepJfDirHkpZH/nxfIfMgPUfin+/ZCf2X8oey6qtvVUORPaLDeHoBmBjdnRGvoglfblqE=
X-Received: by 2002:a05:6102:951:b0:5de:78e6:494d with SMTP id
 ada2fe7eead31-5e827835a90mr4444399137.45.1765873673989; Tue, 16 Dec 2025
 00:27:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251127032407.33475-1-lange_tang@163.com> <20251210040328-mutt-send-email-mst@kernel.org>
 <4820b08f.2d13.19b0b523dcb.Coremail.lange_tang@163.com> <CACGkMEt-v2RGTbzEgfocpZvZw1SKB8j4MQ6zoMFvGJQXXFuMtQ@mail.gmail.com>
 <64d63e98.e7f.19b1595bd4e.Coremail.lange_tang@163.com> <CACGkMEvZQb1ADyEM73jE8_OdeU8YtSbR8YCJ+3anDg8VhkpBLg@mail.gmail.com>
 <5ecbc090.8006.19b21117c0a.Coremail.lange_tang@163.com> <CACGkMEvjr_iVBzHa8GxKCsn=h1EbWzmVrCkpTy+Rc51gWaxH3w@mail.gmail.com>
 <20d26393.751f.19b26214d83.Coremail.lange_tang@163.com>
In-Reply-To: <20d26393.751f.19b26214d83.Coremail.lange_tang@163.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 Dec 2025 16:27:38 +0800
X-Gm-Features: AQt7F2rMQm6vDU2W1mxX3_5G9M5Cwao_r4m-ysfRSlQhwDgiWrX1hHqjxrCHDxM
Message-ID: <CACGkMEvPEXBzPSUcVcGfMY2yKCPz4GqDFuXYmZmVsKfQMtACVA@mail.gmail.com>
Subject: Re: Re: Re: Re: Re: [PATCH v1 0/7] introduce virtnet_mon for monitor virtio_net
To: Lange Tang <lange_tang@163.com>
Cc: "mst@redhat.com" <mst@redhat.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, Tang Longjun <tanglongjun@kylinos.cn>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bRV5ShsELbQ9iOaqu4DQRAOBhY6dW3_QKgkb96hQRSo_1765873676
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 3:48=E2=80=AFPM Lange Tang <lange_tang@163.com> wro=
te:
>
> At 2025-12-16 11:59:14, "Jason Wang" <jasowang@redhat.com> wrote:
> >On Mon, Dec 15, 2025 at 4:12=E2=80=AFPM Lange Tang <lange_tang@163.com> =
wrote:
> >>
> >> At 2025-12-15 14:41:42, "Jason Wang" <jasowang@redhat.com> wrote:
> >> >On Sat, Dec 13, 2025 at 10:41=E2=80=AFAM Lange Tang <lange_tang@163.c=
om> wrote:
> >> >>
> >> >> At 2025-12-11 16:32:15, "Jason Wang" <jasowang@redhat.com> wrote:
> >> >> >On Thu, Dec 11, 2025 at 10:52=E2=80=AFAM Lange Tang <lange_tang@16=
3.com> wrote:
> >> >> >>
> >> >> >> At 2025-12-10 17:04:04, "Michael S. Tsirkin" <mst@redhat.com> wr=
ote:
> >> >> >> >On Thu, Nov 27, 2025 at 11:24:00AM +0800, Longjun Tang wrote:
> >> >> >> >> From: Tang Longjun <tanglongjun@kylinos.cn>
> >> >> >> >>
> >> >> >> >> hi,
> >> >> >> >> virtnet_mon is used to monitor the data packets of the virtio=
_net driver
> >> >> >> >> and the related parameters of virtqueue, useful for tracking =
its status
> >> >> >> >> and troubleshooting faults.
> >> >> >> >>
> >> >> >> >> pls review. tks
> >> >> >> >>
> >> >> >> >> Best regard.
> >> >> >> >
> >> >> >> >what does this achieve that direct use of tracing would not?
> >> >> >>
> >> >> >> I apologize that my explanation of virtnet_mon was not detailed =
enough.
> >> >> >> virtnet_mon uses kprobe and buffers to monitor virtio_net.
> >> >> >> To monitor virtio_net, it is necessary to track the member param=
eters of the virtqueue corresponding to each data packet and output them.
> >> >> >> When PPS very high, other tracing techniques, such as ebpf, may =
not be able to handle it, resulting in data loss because they do not have s=
ufficiently large buffers to batch export log data.
> >> >> >
> >> >> >Can you expand more about this? For example, in which kind of setu=
p
> >> >> >and what do you want to trace and why ebpf can't handle that. Note
> >> >> >that the most lightweight stuff is the counter, have you tried tha=
t?
> >> >>
> >> >> For example, when there is occasional latency in data transmission =
between the
> >> >> virtual network frontend (virtio_net) and backend (such as vhost_ne=
t),
> >> >> we may need to track the time taken for each packet received and se=
nt in the virtio_net driver.
> >> >> Typically, we accomplish this using eBPF, such as bpftrace. The pse=
udocode might include the following:
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
> >> >>   printf("%ld receive_buf Cpu:%d name:%s avali_idx:%d used_idx:%d .=
..\n",...);
> >> >> }
> >> >> """
> >> >> Using the above bpftrace code, we can track the timestamps of the d=
ata as it passes through these functions,
> >> >> along with skb and virtqueue information, and output logs via print=
f for further diagnosis of the causes of the latency.
> >> >> Interestingly, a significant amount of logs were found to be missin=
g when executing these bpftrace codes.
> >> >> Below is the testing environment:
> >> >> VM: 8G8C=EF=BC=8Cvirtio_net mq=3D4, kernel 6.18-rc7, iperf3 -s -p 1=
314
> >> >> HOST: iperf3 -c 192.168.122.218 -t 100 -p 1314 -P 4
> >> >> It was also found that when testing with mq=3D1, there was no log l=
oss.
> >> >>
> >> >> Compared to mq=3D1, the reason for log loss at mq=3D4 is suspected =
to be due to data being sent or received
> >> >> by different CPUs. Additionally, under the 4-thread iperf testing s=
cenario with PPS > 150,000,
> >> >> the log data is asynchronously output from different CPUs, leading =
to excessive IO pressure that causes log data loss.
> >> >
> >> >I think what I don't understand is how the things you introduced here
> >> >may help in this case?
> >>
> >> The virtnet_mon module introduced here abandons eBPF and uses kprobe +=
 kfifo.
> >> In the aforementioned cases, all the information that needs to be trac=
ked first enters kfifo,
> >> then is formatted into logs and cached in a large buffer.
> >> Finally, it is exported to user space in batches through the virtnet_m=
on_read function,
> >> thereby reducing IO pressure and preventing log loss.
> >
> >Well, this "problem" seems not virtio-net specific. Have you tried
> >with BPF ringbuf or perfbuf?
>
> Concerning the ringbuf and perfbuf in bpf, I may need some time to verify=
 whether this can resolve this "problem".
>  I will get back to you with the results.
>
> On the other hand, I did not find any tracepoints in virtio_net that trac=
k the virtqueue,
> such as name, num_free, avail.idx, used.idx, last_used_idx, etc.
> Could you consider inserting these tracepoints in some key functions? Thi=
s would facilitate direct tracking by perf.
> For example:
> start_xmit
> receive_buf
> skb_xmit_done
> skb_recv_done

I think it can have.

I posted a tracepoint support for vhost about 10 years ago (-ENOTIME
for a new version though), so perf can track.

https://lists.openwall.net/netdev/2012/05/07/59

Thanks

>
> >
> >Thanks
> >
> >>
> >> Thanks
> >> >
> >> >Thanks
> >> >
> >> >>
> >> >> The above are some of my personal thoughts, and I would love to hea=
r your opinion.
> >> >> Best regard.
> >> >>
> >> >> >
> >> >> >>
> >> >> >> As for the duplicate code, it is only to obtain the layout of th=
e relevant structure, and I have not yet thought of a way to avoid duplicat=
ion. I would love to hear your suggestions.
> >> >> >
> >> >> >Thanks
> >> >> >
> >> >> >>
> >> >> >> >
> >> >> >> >> Tang Longjun (7):
> >> >> >> >>   tools/virtio/virtnet_mon: create misc driver for virtnet_mo=
n
> >> >> >> >>   tools/virtio/virtnet_mon: add kfifo to virtnet_mon
> >> >> >> >>   tools/virtio/virtnet_mon: add kprobe start_xmit
> >> >> >> >>   tools/virtio/virtnet_mon: add kprobe gro_receive_skb
> >> >> >> >>   tools/virtio/virtnet_mon: add kprobe ip_local_deliver
> >> >> >> >>   tools/virtio/virtnet_mon: add kprobe skb_xmit_done and skb_=
recv_done
> >> >> >> >>   tools/virtio/virtnet_mon: add README file for virtnet_moin
> >> >> >> >>
> >> >> >> >>  tools/virtio/virtnet_mon/Makefile      |   10 +
> >> >> >> >>  tools/virtio/virtnet_mon/README        |   35 +
> >> >> >> >>  tools/virtio/virtnet_mon/virtnet_mon.c | 1048 ++++++++++++++=
++++++++++
> >> >> >> >>  3 files changed, 1093 insertions(+)
> >> >> >> >>  create mode 100644 tools/virtio/virtnet_mon/Makefile
> >> >> >> >>  create mode 100644 tools/virtio/virtnet_mon/README
> >> >> >> >>  create mode 100644 tools/virtio/virtnet_mon/virtnet_mon.c
> >> >> >> >>
> >> >> >> >> --
> >> >> >> >> 2.43.0

