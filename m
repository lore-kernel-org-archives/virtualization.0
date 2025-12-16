Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A4E33D6C3
	for <virtualization@lists.linux.dev>; Tue, 16 Dec 2025 03:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765857597; cv=none; b=LCQdJPX3E5b2DCxPSc7M+gzXsKuel1/STSrW53Fd4bJh5hvihHOLZ6OFJfHSXoJdwlgmfj7g74oQBQFKwFBNtjSdAPbffwak+l261aeVEQhOLyX7P5tD5z7CIOxjM3MGiXOx7I9kbDiP3vmBHqz3bZ0bnv4KCpFz9t0wRRB/dzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765857597; c=relaxed/simple;
	bh=fBASkUx4hICCkpt0DCnE7ZGt+fuBMI0+J2Ci8bUx1fQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQ9NM/wOEMEg5YTsvRTnDc/evcgdokXAVQjTpI2v19YmPtycr4GaqwlSgcHZVyuX5MaX+N6/i+nMwYmcRJCPZjBKHcRqxitHW81FEMFRQTuuMpeey4I33SpMKVOftB//hixRUA2rR+elbMCKjjFthb0wWTpc7A+Xo9cbCTh42cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N7NEkXZ6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N7NEkXZ6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765857572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s9VRfCdavfdzo4eBTBVylF/3rETmvqrTUCzjfKzI4V8=;
	b=N7NEkXZ6ZoWfoXlgP4agRY32k6uYdD92L2k2AY+tmz6SOc6ojzKEQH9R/VGEPx9M/pR+ud
	xZL7aXjdUeCl51rUdM3ksfZzC2Gp1mq4Wu/PrmckPvSOVq5jKpOPkQ3gxuy80vNZiU9L+y
	FwLDb/AEtkx+Km86ZikLHqnDd+UnU5s=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-esVO2j2YMVub-lOs2BmdXw-1; Mon, 15 Dec 2025 22:59:29 -0500
X-MC-Unique: esVO2j2YMVub-lOs2BmdXw-1
X-Mimecast-MFC-AGG-ID: esVO2j2YMVub-lOs2BmdXw_1765857568
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a08cbeb87eso32679065ad.3
        for <virtualization@lists.linux.dev>; Mon, 15 Dec 2025 19:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765857568; x=1766462368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s9VRfCdavfdzo4eBTBVylF/3rETmvqrTUCzjfKzI4V8=;
        b=UTmDpIWZUbtAmwQNjooj4nOVFLD2nMjPj2XCOMbV4M/v+4WkcMnHNBGDS7Kzvs3NEM
         y3/eX+lC7OE5AXHi3X9dIZuCueD5j7HeQHg4eleoOMpzS0DktJbaKb+rkopVMBlvWK9H
         Zl1bxwtSh/jX/me62BD+xAxt8e1gz/+iMwn+rhAcP9CQAMThT5r6SxnAtNkExaM/eVcs
         PbmwpsS2hhZG6Unk7lbU+bmtjyrO00vIdCtNUrwvBj5yAWSA9n/60NWE1pNlKCvYB/rn
         jBL5yFFPTOYVEDkBYkdPGSIBCkr2/cISwxhwtang+BJyJ6bFl5XHkTvoXtRPUxwpqr/4
         U4YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaT3CdYTgLaRaCtlgREIgXgxK/yCjOtIRJklJjhGZRZ7LAdLmETxX1Hrt2wluY+3ZsYGIup++vx96jyBARBg==@lists.linux.dev
X-Gm-Message-State: AOJu0YySYuJUpo0mDYA1eEMKAeb3oAeJAy6bZ8xw02vn9TuZxO4d3Y67
	hkZadWzkUCvHC1LyDS0WhUFjYA+bkpuM0ii3KXS1Ve1IskmcApCDAIyV+feC03cNyWB9zl3UXCi
	CfRJ0jNzT+OOKeu8E61MBJFDx+S+f82ZsT5sHuwziOH/ChBqr4snHHxM8SL+yBJH58UQj1QxC52
	Dsqj9oXgtgn8BjuywKtX/2fg9B2A2JC+lzn1eb2CW72h4=
X-Gm-Gg: AY/fxX4PzmwgftTkji55qAiEqm4X2FLNkUOFHfdYrlWxIyKDATTVY6vwK+dH+rjSIyF
	TtJLyb7qjeOIfo0geVyiAs2vGF09wMtVTzM09RRfuO0H0z7utI4ejigNy48tkZm9wcNcgKer+95
	y2DH4QqrF41BikUdUbf/NvY3LAxJBXktKLXlWlCvm2AU/UdEJ8oejI/hTTieNLANrNBw==
X-Received: by 2002:a17:903:32cd:b0:29e:e925:1abf with SMTP id d9443c01a7336-29f24154de4mr113078065ad.43.1765857567878;
        Mon, 15 Dec 2025 19:59:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPB7mA34lCHS9dqAEuTiC2VixalN3me+0Mss7hO4Vz7ikCyI7HFkhgoekCMgY0+/8AvxaAATUT+gcWOxutclw=
X-Received: by 2002:a17:903:32cd:b0:29e:e925:1abf with SMTP id
 d9443c01a7336-29f24154de4mr113077895ad.43.1765857567382; Mon, 15 Dec 2025
 19:59:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251127032407.33475-1-lange_tang@163.com> <20251210040328-mutt-send-email-mst@kernel.org>
 <4820b08f.2d13.19b0b523dcb.Coremail.lange_tang@163.com> <CACGkMEt-v2RGTbzEgfocpZvZw1SKB8j4MQ6zoMFvGJQXXFuMtQ@mail.gmail.com>
 <64d63e98.e7f.19b1595bd4e.Coremail.lange_tang@163.com> <CACGkMEvZQb1ADyEM73jE8_OdeU8YtSbR8YCJ+3anDg8VhkpBLg@mail.gmail.com>
 <5ecbc090.8006.19b21117c0a.Coremail.lange_tang@163.com>
In-Reply-To: <5ecbc090.8006.19b21117c0a.Coremail.lange_tang@163.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 Dec 2025 11:59:14 +0800
X-Gm-Features: AQt7F2qV_F7ty0XFvFHcvHYymZdZUaJiLajI4r4U3cv0tgt7uXAfeyeoNLCFyUg
Message-ID: <CACGkMEvjr_iVBzHa8GxKCsn=h1EbWzmVrCkpTy+Rc51gWaxH3w@mail.gmail.com>
Subject: Re: Re: Re: Re: [PATCH v1 0/7] introduce virtnet_mon for monitor virtio_net
To: Lange Tang <lange_tang@163.com>
Cc: "mst@redhat.com" <mst@redhat.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, Tang Longjun <tanglongjun@kylinos.cn>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 49oEy-PzCOnaIrrXmoa07hI-WHlhDpHSZ_kW6pJ7Myc_1765857568
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 4:12=E2=80=AFPM Lange Tang <lange_tang@163.com> wro=
te:
>
> At 2025-12-15 14:41:42, "Jason Wang" <jasowang@redhat.com> wrote:
> >On Sat, Dec 13, 2025 at 10:41=E2=80=AFAM Lange Tang <lange_tang@163.com>=
 wrote:
> >>
> >> At 2025-12-11 16:32:15, "Jason Wang" <jasowang@redhat.com> wrote:
> >> >On Thu, Dec 11, 2025 at 10:52=E2=80=AFAM Lange Tang <lange_tang@163.c=
om> wrote:
> >> >>
> >> >> At 2025-12-10 17:04:04, "Michael S. Tsirkin" <mst@redhat.com> wrote=
:
> >> >> >On Thu, Nov 27, 2025 at 11:24:00AM +0800, Longjun Tang wrote:
> >> >> >> From: Tang Longjun <tanglongjun@kylinos.cn>
> >> >> >>
> >> >> >> hi,
> >> >> >> virtnet_mon is used to monitor the data packets of the virtio_ne=
t driver
> >> >> >> and the related parameters of virtqueue, useful for tracking its=
 status
> >> >> >> and troubleshooting faults.
> >> >> >>
> >> >> >> pls review. tks
> >> >> >>
> >> >> >> Best regard.
> >> >> >
> >> >> >what does this achieve that direct use of tracing would not?
> >> >>
> >> >> I apologize that my explanation of virtnet_mon was not detailed eno=
ugh.
> >> >> virtnet_mon uses kprobe and buffers to monitor virtio_net.
> >> >> To monitor virtio_net, it is necessary to track the member paramete=
rs of the virtqueue corresponding to each data packet and output them.
> >> >> When PPS very high, other tracing techniques, such as ebpf, may not=
 be able to handle it, resulting in data loss because they do not have suff=
iciently large buffers to batch export log data.
> >> >
> >> >Can you expand more about this? For example, in which kind of setup
> >> >and what do you want to trace and why ebpf can't handle that. Note
> >> >that the most lightweight stuff is the counter, have you tried that?
> >>
> >> For example, when there is occasional latency in data transmission bet=
ween the
> >> virtual network frontend (virtio_net) and backend (such as vhost_net),
> >> we may need to track the time taken for each packet received and sent =
in the virtio_net driver.
> >> Typically, we accomplish this using eBPF, such as bpftrace. The pseudo=
code might include the following:
> >> """
> >> kprobe:skb_recv_done {
> >>         printf("%ld skb_recv_done Cpu:%d ...\n",...);
> >> }
> >> kprobe:skb_xmit_done {
> >>         printf("%ld skb_xmit_done Cpu:%d ...\n",...);
> >> }
> >> kprobe:virtnet_poll {
> >>         printf("%ld virtnet_poll Cpu:%d budget:%d ...\n",...);
> >> }
> >> kprobe:start_xmit {
> >>   ...
> >>   printf("%ld start_xmit Cpu:%d type:%s seq:%ld ...\n",...)
> >> }
> >> kprobe:gro_receive_skb {
> >>   ...
> >>   printf("%ld gro_receive_skb Cpu:%d type:%s seq:%ld ...\n",...)
> >> }
> >> kprobe:receive_buf {
> >>   ...
> >>   printf("%ld receive_buf Cpu:%d name:%s avali_idx:%d used_idx:%d ...\=
n",...);
> >> }
> >> """
> >> Using the above bpftrace code, we can track the timestamps of the data=
 as it passes through these functions,
> >> along with skb and virtqueue information, and output logs via printf f=
or further diagnosis of the causes of the latency.
> >> Interestingly, a significant amount of logs were found to be missing w=
hen executing these bpftrace codes.
> >> Below is the testing environment:
> >> VM: 8G8C=EF=BC=8Cvirtio_net mq=3D4, kernel 6.18-rc7, iperf3 -s -p 1314
> >> HOST: iperf3 -c 192.168.122.218 -t 100 -p 1314 -P 4
> >> It was also found that when testing with mq=3D1, there was no log loss=
.
> >>
> >> Compared to mq=3D1, the reason for log loss at mq=3D4 is suspected to =
be due to data being sent or received
> >> by different CPUs. Additionally, under the 4-thread iperf testing scen=
ario with PPS > 150,000,
> >> the log data is asynchronously output from different CPUs, leading to =
excessive IO pressure that causes log data loss.
> >
> >I think what I don't understand is how the things you introduced here
> >may help in this case?
>
> The virtnet_mon module introduced here abandons eBPF and uses kprobe + kf=
ifo.
> In the aforementioned cases, all the information that needs to be tracked=
 first enters kfifo,
> then is formatted into logs and cached in a large buffer.
> Finally, it is exported to user space in batches through the virtnet_mon_=
read function,
> thereby reducing IO pressure and preventing log loss.

Well, this "problem" seems not virtio-net specific. Have you tried
with BPF ringbuf or perfbuf?

Thanks

>
> Thanks
> >
> >Thanks
> >
> >>
> >> The above are some of my personal thoughts, and I would love to hear y=
our opinion.
> >> Best regard.
> >>
> >> >
> >> >>
> >> >> As for the duplicate code, it is only to obtain the layout of the r=
elevant structure, and I have not yet thought of a way to avoid duplication=
. I would love to hear your suggestions.
> >> >
> >> >Thanks
> >> >
> >> >>
> >> >> >
> >> >> >> Tang Longjun (7):
> >> >> >>   tools/virtio/virtnet_mon: create misc driver for virtnet_mon
> >> >> >>   tools/virtio/virtnet_mon: add kfifo to virtnet_mon
> >> >> >>   tools/virtio/virtnet_mon: add kprobe start_xmit
> >> >> >>   tools/virtio/virtnet_mon: add kprobe gro_receive_skb
> >> >> >>   tools/virtio/virtnet_mon: add kprobe ip_local_deliver
> >> >> >>   tools/virtio/virtnet_mon: add kprobe skb_xmit_done and skb_rec=
v_done
> >> >> >>   tools/virtio/virtnet_mon: add README file for virtnet_moin
> >> >> >>
> >> >> >>  tools/virtio/virtnet_mon/Makefile      |   10 +
> >> >> >>  tools/virtio/virtnet_mon/README        |   35 +
> >> >> >>  tools/virtio/virtnet_mon/virtnet_mon.c | 1048 +++++++++++++++++=
+++++++
> >> >> >>  3 files changed, 1093 insertions(+)
> >> >> >>  create mode 100644 tools/virtio/virtnet_mon/Makefile
> >> >> >>  create mode 100644 tools/virtio/virtnet_mon/README
> >> >> >>  create mode 100644 tools/virtio/virtnet_mon/virtnet_mon.c
> >> >> >>
> >> >> >> --
> >> >> >> 2.43.0

