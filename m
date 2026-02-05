Received: from mail2.anonaddy.me (mail2.anonaddy.me [185.70.196.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D80A23D7D4
	for <virtualization@lists.linux.dev>; Thu,  5 Feb 2026 08:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.196.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770278563; cv=none; b=np+uJLflp/ORyYbFy4oVprkrF4XnTwOj7PXZ68ec8uAQwIMzWw5CC6HFvIXApe0gj7otr4SKiILC9j6LiEYi6+YwPAQhlutIPh8ZiFlaoVnBFcPokagb6+Y8L74ldGYsQoPwnP7MPlLjj4l3sO8zi1HwKXAVKjh5AyfmvqcTlRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770278563; c=relaxed/simple;
	bh=5AaoRbBNAPkNC4SsGLg3KZJ0Aa//TunCotCzsupFYZ4=;
	h=From:To:Subject:Message-ID:Cc:MIME-Version:Date:Content-Type; b=Tf6auLHy/1+XIT1AQ1Y4DdSf2QYsnNo8Ayxr/WEg5skgr/TkCx6WIsutrgJe6YbWnoqlI+Es3bMAjtMCHvuFAeP4GXqJFDt65rEWmzeRTLg9L8BR3LqgaYrFPvFySU0eZj3m6iB6FNRhCSDwgR3kSCbnXXA0hO7OeyhZB7CMMho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=anonaddy.me; spf=pass smtp.mailfrom=anonaddy.me; dkim=pass (2048-bit key) header.d=anonaddy.me header.i=@anonaddy.me header.b=eC+uxgYt; arc=none smtp.client-ip=185.70.196.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=anonaddy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anonaddy.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anonaddy.me header.i=@anonaddy.me header.b="eC+uxgYt"
Received: from mail2.anonaddy.me (mail2.anonaddy.me [127.0.0.1])
	by mail2.anonaddy.me (Postfix) with ESMTPS id E890E1001E0
	for <virtualization@lists.linux.dev>; Thu,  5 Feb 2026 07:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anonaddy.me; s=default2;
	t=1770278013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=apxmgs+L7pLGJzl95x0JK/zDZ8qpoMIhjhbsuOYRGR4=;
	b=eC+uxgYtNeG69c/XDK47octWLT8xDu71rKSlTTQFlOtFl0deJAevI+bQ0TtcvIdY9D+bjc
	W6W+F+4RuBdNogzlqfj7Jo/hPhtItTcBoDhf8LOSA/pU7rTdJS3RtOoIBaKfWyOeSddWbs
	cl4ZhHgFccugCF225K1ui1LoENL8CE+6WVzH2M3FZncEHL8WBotlGW1yXmj6zXpRsvpNkf
	QCy812Ws0VBinrJhvtAtcYrVLPSzqtRdelE9lV3gh6nv12y8evK3B56kvUYAr+YUgZbw/L
	pvRrgRIlkq6gVBzT5rC12mabo0OpfL4vd/1jYo/hD//DQEDjx5WNrwvIbwcBTQ==
From: agpn1b92@anonaddy.me
To: virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: [BUG] vsock: poll() not waking on data arrival, causing
 multi-second SSH delays
Feedback-ID: S:d17f588e-5717-4190-ab1e-7db474f4dce6:anonaddy
Message-ID: <b8eaada2e7f6aeb8543f55548d1e491a@anonaddy.me>
X-Complaints-To: abuse@help.addy.io
X-Report-Abuse: abuse@help.addy.io
X-Report-Abuse-To: abuse@help.addy.io
Cc: sgarzare@redhat.com
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 05 Feb 2026 07:53:33 +0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I'm experiencing a bug where SSH sessions over vsock take 2-20+ se=
conds
to establish due to poll() not signaling POLLIN when data is availa=
ble.
The bug does NOT occur on the first connection after VM boot, but af=
fects
all subsequent connections.

* Summary

- vsock poll() fail=
s to return POLLIN when data is in the receive buffer
- sshd-session's pp=
oll() times out every ~20ms instead of waking on data
- First SSH connect=
ion after guest boot works instantly
- All subsequent connections experie=
nce 2-20+ second delays
- Non-PTY commands (ssh -T ... 'echo test') work =
instantly
- TCP connections to the same VM work instantly

* Environm=
ent

Host:
- OS: Arch Linux
- Kernel: 6.18.2-arch2-1
- QEMU: syst=
em package (latest)

Guest:
- OS: Debian trixie
- Kernel: 6.17.13+d=
eb13-amd64 (also tested on 6.12.57, same issue)
- OpenSSH: 10.0p2

QE=
MU command (relevant parts):
  qemu-system-x86_64 -enable-kvm -smp 8 \
=
    -object memory-backend-memfd,id=3Dmem,size=3D20G,share=3Don \
    -ma=
chine memory-backend=3Dmem \
    -device vhost-vsock-pci,guest-cid=3D5 \=

    ...

Connection method: ssh user@vsock/5 (via systemd-ssh-proxy)=


* Symptoms

Interactive SSH (PTY) - SLOW:
  $ time ssh user@vso=
ck/5
  # Takes 2-20+ seconds before shell prompt appears

Non-interac=
tive SSH - FAST:
  $ time ssh user@vsock/5 'echo test'
  test
  real =
   0m0.156s

TCP to same VM - FAST:
  $ time ssh -p 33594 user@127.0.=
0.1
  # Instant

* Key observation: First connection after boot is fa=
st

After guest reboot:
  $ ssh user@vsock/5      # INSTANT (< 1 seco=
nd)
  $ exit
  $ ssh user@vsock/5      # SLOW (2-20 seconds)
  $ ssh =
user@vsock/5      # SLOW
  ...

This suggests the bug involves state =
that accumulates or isn't properly
cleaned up between connections.

*=
* bpftrace evidence

Using syscall tracepoints on guest during slow con=
nection:

  =3D=3D=3D MINIMAL VSOCK DIAGNOSTIC =3D=3D=3D
  [   29 ms]=
 sshd-session: ppoll() duration=3D19 ms ret=3D1
             ^^^ 20ms TIM=
EOUT pattern detected!
  [   50 ms] sshd-session: ppoll() duration=3D20 m=
s ret=3D1
             ^^^ 20ms TIMEOUT pattern detected!
  [   70 ms] =
sshd-session: ppoll() duration=3D18 ms ret=3D1
             ^^^ 20ms TIME=
OUT pattern detected!
  ... (continues for ~2 seconds) ...
 =20
  [ 500=
0 ms] --- 5s stats: ppoll=3D455, timeouts=3D103, recv=3D0 (0 bytes) ---
 =
=20
  [19432 ms] sshd: recvmsg() =3D 308 bytes [4 =C2=B5s]
  [19442 ms] s=
shd-session: recvmsg() =3D 308 bytes [4 =C2=B5s]

Pattern analysis:
-=
 ppoll() returns ret=3D1 (1 fd ready) but takes exactly ~20ms (timeout)
-=
 The ready fd is the PTY, NOT the vsock socket
- recv=3D0 during the time=
out phase: vsock data not being read
- recvmsg() finally succeeds after ~=
19 seconds
- When recvmsg() runs, it completes in 4 microseconds (data WA=
S there)

This proves: data is sitting in the vsock receive buffer, but=
 poll()
is not returning POLLIN, so sshd doesn't know to read it.

* =
30-second summary from bpftrace

  Total ppoll calls: 488
  Timeouts =
(20ms pattern): 103
  Successful recvmsg: 6 (984 bytes)
  Timeout rate:=
 21%

* Why PTY-specific?

PTY sessions require bidirectional traff=
ic:
1. Server sends shell prompt =E2=86=92 client must receive it
2. Cl=
ient sends keypress =E2=86=92 server must receive it
3. Server sends echo=
 =E2=86=92 client must receive it

Each exchange relies on poll() wakin=
g on POLLIN. The bug causes poll()
to miss the wakeup, forcing sshd to wa=
it for its 20ms timeout fallback.

Non-PTY commands do request-response=
-exit quickly before the bug
manifests significantly.

## Additional =
context

I previously encountered the identical issue on WSL2's Hyper-V=
 vsock
implementation, suggesting this may be a fundamental issue with ho=
w
vsock transports handle poll/wakeup semantics, not specific to virtio.=


## Hypothesis

Based on the evidence, this appears to be a lost w=
akeup race condition:
1. Host sends packet to guest
2. Packet is enqueu=
ed to socket's rx_queue
3. sk_data_ready() is called but poll waiters are=
n't properly woken
4. vsock_poll() returns 0 (no POLLIN) despite data bei=
ng available
5. ppoll() times out after 20ms, sshd retries
6. Eventuall=
y succeeds through timeout-based retry

The "first connection works" pa=
ttern suggests the race involves
existing state from previous connections=
 - possibly worker threads,
interrupt handlers, or virtqueue state that i=
sn't properly reset.

## Reproducer

1. Start QEMU VM with vhost-vs=
ock-pci device
2. Boot guest, ensure sshd is running
3. From host: ssh =
user@vsock/<CID>  # First connection is fast
4. Exit and reconnect: ssh u=
ser@vsock/<CID>  # Now slow

## Request

Could someone familiar wit=
h the vsock/virtio poll implementation
review the wakeup path? Specifical=
ly:
- virtio_transport_recv_pkt() -> sk_data_ready() path
- vsock_poll(=
) -> poll_wait() registration timing
- Any state that persists between co=
nnections

Happy to provide additional traces or test patches.

Tha=
nks,
[Your Name]

---
bpftrace script used (runs on guest):

#!=
/usr/bin/env bpftrace
BEGIN {
    @start =3D nsecs;
    printf("=3D=
=3D=3D MINIMAL VSOCK DIAGNOSTIC =3D=3D=3D\n");
}
tracepoint:syscalls:sy=
s_enter_ppoll {
    if (comm =3D=3D "sshd-session" || comm =3D=3D "sshd")=
 {
        @ppoll_enter[tid] =3D nsecs;
        @ppoll_count++;
    }=

}
tracepoint:syscalls:sys_exit_ppoll {
    if (@ppoll_enter[tid]) {=

        $ms =3D (nsecs - @start) / 1000000;
        $dur =3D (nsecs - =
@ppoll_enter[tid]) / 1000000;
        if ($dur > 10) {
            prin=
tf("[%5lld ms] %s: ppoll() duration=3D%lld ms ret=3D%d\n",
              =
     $ms, comm, $dur, args->ret);
            if ($dur >=3D 18 && $dur <=
=3D 25) {
                printf("           ^^^ 20ms TIMEOUT pattern det=
ected!\n");
                @timeout_count++;
            }
        }=

        delete(@ppoll_enter[tid]);
    }
}
tracepoint:syscalls:sys=
_exit_recvmsg {
    if (comm =3D=3D "sshd-session" || comm =3D=3D "sshd")=
 {
        if (args->ret > 0) {
            $ms =3D (nsecs - @start) / =
1000000;
            printf("[%5lld ms] %s: recvmsg() =3D %lld bytes\n", =
$ms, comm, args-
>ret);
            @recv_count++;
            @recv_=
bytes +=3D args->ret;
        }
    }
}
interval:s:5 {
    printf=
("\n[%5lld ms] --- 5s stats: ppoll=3D%d, timeouts=3D%d, recv=3D%d (%d bytes=
)
---\n\n",
           (nsecs - @start) / 1000000, @ppoll_count, @timeo=
ut_count,
@recv_count, @recv_bytes);
}



