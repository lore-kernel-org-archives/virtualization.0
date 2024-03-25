Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A010A179FA9
	for <virtualization@lists.linux.dev>; Mon, 25 Mar 2024 08:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711356279; cv=none; b=b/p9qiJzU3f3MLQis8jkHQCGAdHg4dvWxtH0Ka4S+M1wEssREWRTWcCOuLj8Jmn2788va3V1zZXScjVls8/rmLhqc0zRMoeqxImCb5HOXlmARAKaE7OA9D7qKUpMobHEQqRwc21LVv7pajWwGoNd5eATv6o/ePlV84eD87lQ98s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711356279; c=relaxed/simple;
	bh=KlNZqGKcY8wJJqzBqoSqe94osLn2EZS8gGGi0MRJ1/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YcpYyanuIjgsFzH8YWyx7Sh1PNFUY8bgmSBnkR1YMMJDgidB+RUcWGW0ja86R4FThhyuVPpfd+//gn5MZcitEGuQ4sAndCn5bzI+v+dTKYcUlgIaH6fnQktlOfMr00OFgD9Ezu23GqY6eA4ZoP18UT8FyQsT/MzqOc70Y9HN/fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=TJd6zPW+; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="TJd6zPW+"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-514ba4e5640so4779562e87.1
        for <virtualization@lists.linux.dev>; Mon, 25 Mar 2024 01:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1711356276; x=1711961076; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AQnc+S8eeewHWVi7q229L+fZxCbZfHJQPdr0bWKRFA=;
        b=TJd6zPW+R+U88L5eY9SlQYA6t9sqgKozZ3GISYNqHp60TdtI00UXgdaz7scsk2F8Na
         hWTq2fqNWyOirxJApH2Sr6E0rA8ZKKrbyochwdOkFUrBG6y1A7+bz1EmiOttgb/33Av2
         kSxDncrHCoBVq16RaBJJTiXvtEPoFhWgjhhOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711356276; x=1711961076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+AQnc+S8eeewHWVi7q229L+fZxCbZfHJQPdr0bWKRFA=;
        b=wCfH+QAfGQV0E2yPwwQUZaO7PFKnX1HsqtnY1hUbCPO5bw23PjRgIhp8Zr5vHyXI0J
         lZU/dkkL5qPdQts9M0+wOCr/yTTSrv5k4dDViVCuKvkWbfLoVNasxBNJ4egYmEjcOJ4S
         7cRqdzKAg2isBMliJz0YnJiW9on9+pUXw9X+ZE1nXXyoHhOqaXnHIh+Wi+F5n09hk02Y
         5Xf/yoMgN1Y+LT4kflKW6cIf1d7Fga3UW6Vk7qvNTt+ohzzGX6Ga6g+jHYThy8nX8Cum
         OHTDw61ZyuS/bRTfk5oM8F+jVdLGIfhY0gByiGXw6xQIV4DtGfCIIWOG9QN5RcbQLR+9
         NsZw==
X-Forwarded-Encrypted: i=1; AJvYcCUZbDvH19LuADpHUP3aJsLDOUHojxZ2bHIkCgYekgRJXedDgOb+3A43EtCM2eWuXn8i0rEsYMV7HWEdZubtWGVK4n11Jb9j1Rx6JXRxXnE=
X-Gm-Message-State: AOJu0YwcxNOnhp7VvwzLYkBH2uWO871iObHZF1cxx1ZkSMnTfpdImEHV
	4uJ5EMTY7ydg+JDFuVOMbg8hUAaIYbqo/qX7YhKiC7PJ2hoLSn7rJtqPR/uvNcBOf9R7FrGJ8dj
	EtEjNzK19Kf/4En8tQVYJFlPo4x06EEeA1VuO
X-Google-Smtp-Source: AGHT+IHpPljUYvS/v6zIPdlCSCskC5KA1wMk0ygWW04BfrfXUTs4QbWjBPvQqYu8FjNfMaTN+Ytdl3l03Fm/KfIPCY0=
X-Received: by 2002:a2e:b176:0:b0:2d4:9334:3c11 with SMTP id
 a22-20020a2eb176000000b002d493343c11mr1669978ljm.16.1711356275855; Mon, 25
 Mar 2024 01:44:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+9S74hbTMxckB=HgRiqL6b8ChZMQfJ6-K9y_GQ0ZDiWkev_vA@mail.gmail.com>
 <20240319131207.GB1096131@fedora> <CA+9S74jMBbgrxaH2Nit50uDQsHES+e+VHnOXkxnq2TrUFtAQRA@mail.gmail.com>
 <CACGkMEvX2R+wKcH5V45Yd6CkgGhADVbpvfmWsHducN2zCS=OKw@mail.gmail.com>
 <CA+9S74g5fR=hBxWk1U2TyvW1uPmU3XgJnjw4Owov8LNwLiiOZw@mail.gmail.com>
 <CACGkMEt4MbyDgdqDGUqQ+0gV-1kmp6CWASDgwMpZnRU8dfPd2Q@mail.gmail.com>
 <CA+9S74hUt_aZCrgN3Yx9Y2OZtwHNan7gmbBa1TzBafW6=YLULQ@mail.gmail.com> <CA+9S74ia-vUag2QMo6zFL7r+wZyOZVmcpe317RdMbK-rpomn+Q@mail.gmail.com>
In-Reply-To: <CA+9S74ia-vUag2QMo6zFL7r+wZyOZVmcpe317RdMbK-rpomn+Q@mail.gmail.com>
From: Igor Raits <igor@gooddata.com>
Date: Mon, 25 Mar 2024 09:44:23 +0100
Message-ID: <CA+9S74hs_1Ft9iyXOPU_vF_EFKuoG8LjDpSna0QSPMFnMywd_g@mail.gmail.com>
Subject: Re: REGRESSION: RIP: 0010:skb_release_data+0xb8/0x1e0 in vhost/tun
To: Jason Wang <jasowang@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	Stefano Garzarella <sgarzare@redhat.com>, Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Mar 22, 2024 at 12:19=E2=80=AFPM Igor Raits <igor@gooddata.com> wro=
te:
>
> Hi Jason,
>
> On Fri, Mar 22, 2024 at 9:39=E2=80=AFAM Igor Raits <igor@gooddata.com> wr=
ote:
> >
> > Hi Jason,
> >
> > On Fri, Mar 22, 2024 at 6:31=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Thu, Mar 21, 2024 at 5:44=E2=80=AFPM Igor Raits <igor@gooddata.com=
> wrote:
> > > >
> > > > Hello Jason & others,
> > > >
> > > > On Wed, Mar 20, 2024 at 10:33=E2=80=AFAM Jason Wang <jasowang@redha=
t.com> wrote:
> > > > >
> > > > > On Tue, Mar 19, 2024 at 9:15=E2=80=AFPM Igor Raits <igor@gooddata=
.com> wrote:
> > > > > >
> > > > > > Hello Stefan,
> > > > > >
> > > > > > On Tue, Mar 19, 2024 at 2:12=E2=80=AFPM Stefan Hajnoczi <stefan=
ha@redhat.com> wrote:
> > > > > > >
> > > > > > > On Tue, Mar 19, 2024 at 10:00:08AM +0100, Igor Raits wrote:
> > > > > > > > Hello,
> > > > > > > >
> > > > > > > > We have started to observe kernel crashes on 6.7.y kernels =
(atm we
> > > > > > > > have hit the issue 5 times on 6.7.5 and 6.7.10). On 6.6.9 w=
here we
> > > > > > > > have nodes of cluster it looks stable. Please see stacktrac=
e below. If
> > > > > > > > you need more information please let me know.
> > > > > > > >
> > > > > > > > We do not have a consistent reproducer but when we put some=
 bigger
> > > > > > > > network load on a VM, the hypervisor's kernel crashes.
> > > > > > > >
> > > > > > > > Help is much appreciated! We are happy to test any patches.
> > > > > > >
> > > > > > > CCing Michael Tsirkin and Jason Wang for vhost_net.
> > > > > > >
> > > > > > > >
> > > > > > > > [62254.167584] stack segment: 0000 [#1] PREEMPT SMP NOPTI
> > > > > > > > [62254.173450] CPU: 63 PID: 11939 Comm: vhost-11890 Tainted=
: G
> > > > > > > >    E      6.7.10-1.gdc.el9.x86_64 #1
> > > > > > >
> > > > > > > Are there any patches in this kernel?
> > > > > >
> > > > > > Only one, unrelated to this part. Removal of pr_err("EEVDF sche=
duling
> > > > > > fail, picking leftmost\n"); line (reported somewhere few months=
 ago
> > > > > > and it was suggested workaround until proper solution comes).
> > > > >
> > > > > Btw, a bisection would help as well.
> > > >
> > > > In the end it seems like we don't really have "stable" setup, so
> > > > bisection looks to be useless but we did find few things meantime:
> > > >
> > > > 1. On 6.6.9 it crashes either with unexpected GSO type or usercopy:
> > > > Kernel memory exposure attempt detected from SLUB object
> > > > 'skbuff_head_cache'
> > >
> > > Do you have a full calltrace for this?
> >
> > I have shared it in one of the messages in this thread.
> > https://marc.info/?l=3Dlinux-virtualization&m=3D171085443512001&w=3D2
> >
> > > > 2. On 6.7.5, 6.7.10 and 6.8.1 it crashes with RIP:
> > > > 0010:skb_release_data+0xb8/0x1e0
> > >
> > > And for this?
> >
> > https://marc.info/?l=3Dlinux-netdev&m=3D171083870801761&w=3D2
> >
> > > > 3. It does NOT crash on 6.8.1 when VM does not have multi-queue set=
up
> > > >
> > > > Looks like the multi-queue setup (we have 2 interfaces =C3=97 3 vir=
tio
> > > > queues for each) is causing problems as if we set only one queue fo=
r
> > > > each interface the issue is gone.
> > > > Maybe there is some race condition in __pfx_vhost_task_fn+0x10/0x10=
 or
> > > > somewhere around?
> > >
> > > I can't tell now, but it seems not because if we have 3 queue pairs w=
e
> > > will have 3 vhost threads.
> > >
> > > > We have noticed that there are 3 of such functions
> > > > in the stacktrace that gave us hints about what we could try=E2=80=
=A6
> > >
> > > Let's try to enable SLUB_DEBUG and KASAN to see if we can get
> > > something interesting.
> >
> > We were able to reproduce it even with 1 vhost queue... And now we
> > have slub_debug + kasan so I hopefully have more useful data for you
> > now.
> > I have attached it for better readability.
>
> Looks like we have found a "stable" kernel and that is 6.1.32. The
> 6.3.y is broken and we are testing 6.2.y now.
> My guess it would be related to virtio/vsock: replace virtio_vsock_pkt
> with sk_buff that was done around that time but we are going to test,
> bisect and let you know more.

So we have been trying to bisect it but it is basically impossible for
us to do so as the ICE driver was quite broken for most of the release
cycle so we have no networking on 99% of the builds and we can't test
such a setup.
More specifically, the bug was introduced between 6.2 and 6.3 but we
could not get much further. The last good commit we were able to test
was f18f9845f2f10d3d1fc63e4ad16ee52d2d9292fa and then after 20 commits
where we had no networking we gave up.

If you have some suspicious commit(s) we could revert - happy to test.

Thanks again.
