Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B1413AA4C
	for <virtualization@lists.linux.dev>; Wed, 26 Jun 2024 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719423821; cv=none; b=oRKNJ9fMsYeAFwKRrh55D17cX92g+uodHJY3jUEyljPLNceLsgnI8Hp3wUzPBXrR+/kn8CAxrPvX9Le+nm9UlMHXKxh+6M4DQG0e/Edb99nk/n7ZKX3soZFnUjs4nTZH6zP1dtMZWwxkEXeg8azl9gbwhtDXV5Tam90/plENp64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719423821; c=relaxed/simple;
	bh=zBhReINd0zPxFnkkL4Xv24dohlDbe1P3un1fY4tJdD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjWwVOVrOCWH17m48h2gjNAQxjs9YTcLdwNnQcxG3KZa+sGEF9mejPD89I7M2/jkjH77iXEVRoxKGy8d4kRoqDAteC1qQVTINIxvCx4ZhiEVFRGVGaRSsgmaNw1mMJnG9RAm0/zlz1n2fF9k3RaBeoLzWROY40U02Mp7SlFug+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyoMikft; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyoMikft"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52cdd893e5cso5063449e87.1
        for <virtualization@lists.linux.dev>; Wed, 26 Jun 2024 10:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719423818; x=1720028618; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68Go+AztCSeGaELQM462j1U0ArOjXehNFQ7V4OM1BiU=;
        b=EyoMikftikg10t1+my17zAqsjhi2MxpRytPvkyKqo7TatnAGFoq8iivFgov3xMGhrB
         gCaT13pie0U1kiV09YC80aaxFzMlBw3NZEK15jnQQ4rJjdw+sjq6RxX+UnG4ilJ0EkcB
         AKMjjbgPo/eGgFT4Q8C63WHwWkP70A9bY1Je1Y6LTeDdl4Gg8o6t5geFacMrd8AQAtAA
         8K34UpDXvmZmVqE7g7DWCjxg3Ta3nQ/2eik/zofkn7wn0T47Zuf+b+q25lL+C10595fW
         OqNfvA31TnLYdERGqfi+r02dQ41ZCMQouM05DiL6+iQmd6FEpO7qOnaqLklK+XPqafjC
         uXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719423818; x=1720028618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68Go+AztCSeGaELQM462j1U0ArOjXehNFQ7V4OM1BiU=;
        b=ZynIjm2MztYLsiTNyjwcmFgwwi6hivsnwNv0JbZjTCcatyvnzaGuLDVPjVMvMIYxkT
         Ur1qKOERs5PMAVULB86UXIOATcePHUML4BtbZYt3DvyQoyFAwHQ7vT/QnxDwaSSWjvmh
         Sq4ybCkWxHkI0tCKDv85kPMMbrGWZXGYN0tHDacyKRT9tQbT+x6KdDtcIEBskzSfdib/
         oZYvKIxRsdEGdFhcl2OZGLmbVQKIlT8XfGI02UYTo3CpkAregQUDMSaZd9eqQpZK7xif
         OZVcW2abnnEqs6i2rZWlgVDZ3wKVH/JW1jmglelpFaCjOpv8wJ/3/tNINw3kOchth1/6
         YSQw==
X-Forwarded-Encrypted: i=1; AJvYcCU/DCWEThrk4QsjRh6fJgYld8Q3I1rbKtESXLyvmcRq8VJ3QKeWJ34oARobmPe2V1XOcpUDS+Auc3EYYKnKtEWPHsbY0GYkns4eLH0tR7w=
X-Gm-Message-State: AOJu0YzqjLe2NLvP3hRKv1XINI942zprbz2JfUdhAeM4jEX0tzLqX4iM
	sWl8Ib++h1VRC6/qW0xqug+fTPzijFbgQbGSUgWLWZJqf2v+ZaCGVL9V5wVspinFgw2nDeRu7H2
	OwLAyCAPPR+F0/0UY+xXvRBWVP8U=
X-Google-Smtp-Source: AGHT+IF9satTDRYLl9JbfwfqMs0I7XKZ/C3sQfyyPVsPfLOdo7gU6tnbN/vLDICS0OPH7+x0nGEQqaMcpmsNOwJ3VUo=
X-Received: by 2002:ac2:4d97:0:b0:52c:e170:9d38 with SMTP id
 2adb3069b0e04-52ce183ad20mr7801343e87.31.1719423817353; Wed, 26 Jun 2024
 10:43:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <554ae947-f06e-4b69-b274-47e8a78ae962@amazon.com>
 <14e68dd8-b2fa-496f-8dfc-a883ad8434f5@redhat.com> <c5wziphzhyoqb2mwzd2rstpotjqr3zky6hrgysohwsum4wvgi7@qmboatooyddd>
 <CABgObfasyA7U5Fg5r0gGoFAw73nwGJnWBYmG8vqf0hC2E8SPFw@mail.gmail.com>
 <sejux5gvpakaopre6mk3fyudi2f56hiuxuevfzay3oohg773kd@5odm3x3fryuq>
 <CABgObfb-KrmJzr4YBtuN3+_HLm3S1hmjO7uEy0+AxSDeWE3uWg@mail.gmail.com>
 <l5oxnxkg7owmwuadknttnnl2an37wt3u5kgfjb5563f7llbgwj@bvwfv5d7wrq4>
 <3b6a1f23-bf0e-416d-8880-4556b87b5137@amazon.com> <hyrgztjkjmftnpra2o2skonfs6bwf2sqrncwtec3e4ckupe5ea@76whtcp3zapf>
 <CAFfO_h5_uAwdNJB=fjrxb_pPiwRDQxaZn=OvR3yrYd+c18tUdQ@mail.gmail.com> <xw2rhgn2s677t6cufp2ndpvvgpdlovej44o6ieo7nz2p6msvnw@zza7jzylpw76>
In-Reply-To: <xw2rhgn2s677t6cufp2ndpvvgpdlovej44o6ieo7nz2p6msvnw@zza7jzylpw76>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Wed, 26 Jun 2024 23:43:25 +0600
Message-ID: <CAFfO_h4WnSkinX1faduAD68h=nQCWhPgpYKTPV+xfSqyfMmxEA@mail.gmail.com>
Subject: Re: How to implement message forwarding from one CID to another in
 vhost driver
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Alexander Graf <agraf@csgraf.de>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Stefano,
Thanks a lot for all the details. I will look into them and reach out
if I need further input. Thanks! I have tried to summarize my
understanding below. Let me know if that sounds correct.

On Wed, Jun 26, 2024 at 2:37=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> Hi Dorjoy,
>
> On Tue, Jun 25, 2024 at 11:44:30PM GMT, Dorjoy Chowdhury wrote:
> >Hey Stefano,
>
> [...]
>
> >> >
> >> >So the immediate plan would be to:
> >> >
> >> >  1) Build a new vhost-vsock-forward object model that connects to
> >> >vhost as CID 3 and then forwards every packet from CID 1 to the
> >> >Enclave-CID and every packet that arrives on to CID 3 to CID 2.
> >>
> >> This though requires writing completely from scratch the virtio-vsock
> >> emulation in QEMU. If you have time that would be great, otherwise if
> >> you want to do a PoC, my advice is to start with vhost-user-vsock whic=
h
> >> is already there.
> >>
> >
> >Can you give me some more details about how I can implement the
> >daemon?
>
> We already have a demon written in Rust, so I don't recommend you
> rewrite one from scratch, just start with that. You can find the daemon
> and instructions on how to use it with QEMU here [1].
>
> >I would appreciate some pointers to code too.
>
> I sent the pointer to it in my first reply [2].
>
> >
> >Right now, the "nitro-enclave" machine type (wip) in QEMU
> >automatically spawns a VHOST_VSOCK device with the CID equal to the
> >"guest-cid" machine option. I think this is equivalent to using the
> >"-device vhost-vsock-device,guest-cid=3DN" option explicitly. Does that
> >need any change? I guess instead of "vhost-vsock-device", the
> >vhost-vsock device needs to be equivalent to "-device
> >vhost-user-vsock-device,guest-cid=3DN"?
>
> Nope, the vhost-user-vsock device requires just a `chardev` option.
> The chardev points to the Unix socket used by QEMU to talk with the
> daemon. The daemon has a parameter to set the CID. See [1] for the
> examples.
>
> >
> >The applications inside the nitro-enclave VM will still connect and
> >talk to CID 3. So on the daemon side, do we need to spawn a device
> >that has CID 3 and then forward everything this device receives to CID
> >1 (VMADDR_CID_LOCAL) same port and everything it receives from CID 1
> >to the "guest-cid"?
>
> Yep, I think this is right.
> Note: to use VMADDR_CID_LOCAL, the host needs to load `vsock_loopback`
> kernel module.
>
> Before modifying the code, if you want to do some testing, perhaps you
> can use socat (which supports both UNIX-* and VSOCK-*). The daemon for
> now exposes two unix sockets, one is used to communicate with QEMU via
> the vhost-user protocol, and the other is to be used by the application
> to communicate with vsock sockets in the guest using the hybrid protocol
> defined by firecracker. So you could initiate a socat between the latter
> and VMADDR_CID_LOCAL, the only problem I see is that you have to send
> the first string provided by the hybrid protocol (CONNECT 1234), but for
> a PoC it should be ok.
>
> I just tried the following and it works without touching any code:
>
> shell1$ ./target/debug/vhost-device-vsock \
>      --vm guest-cid=3D3,socket=3D/tmp/vhost3.socket,uds-path=3D/tmp/vm3.v=
sock
>
> shell2$ sudo modprobe vsock_loopback
> shell2$ socat VSOCK-LISTEN:1234 UNIX-CONNECT:/tmp/vm3.vsock
>
> shell3$ qemu-system-x86_64 -smp 2 -M q35,accel=3Dkvm,memory-backend=3Dmem=
 \
>      -drive file=3Dfedora40.qcow2,format=3Dqcow2,if=3Dvirtio\
>      -chardev socket,id=3Dchar0,path=3D/tmp/vhost3.socket \
>      -device vhost-user-vsock-pci,chardev=3Dchar0 \
>      -object memory-backend-memfd,id=3Dmem,size=3D512M \
>      -nographic
>
>      guest$ nc --vsock -l 1234
>
> shell4$ nc --vsock 1 1234
> CONNECT 1234
>
>      Note: the `CONNECT 1234` is required by the hybrid vsock protocol
>      defined by firecracker, so if we extend the vhost-device-vsock
>      daemon to forward packet to VMADDR_CID_LOCAL, that would not be
>      needed (including running socat).
>

Understood. Just trying to think out loud what the final UX will be
from the user perspective to successfully run a nitro VM before I try
to modify vhost-device-vsock to support forwarding to
VMADDR_CID_LOCAL.
I guess because the "vhost-user-vsock" device needs to be spawned
implicitly (without any explicit option) inside nitro-enclave in QEMU,
we now need to provide the "chardev" as a machine option, so the
nitro-enclave command would look something like below:
"./qemu-system-x86_64 -M nitro-enclave,chardev=3Dchar0 -kernel
/path/to/eif -chardev socket,id=3Dchar0,path=3D/tmp/vhost5.socket -m 4G
--enable-kvm -cpu host"
and then set the chardev id to the vhost-user-vsock device in the code
from the machine option.

The modified "vhost-device-vsock" would need to be run with the new
option that will forward everything to VMADDR_CID_LOCAL (below by the
"-z" I mean the new option)
"./target/debug/vhost-device-vsock -z --vm
guest-cid=3D5,socket=3D/tmp/vhost5.socket,uds-path=3D/tmp/vm5.vsock"
this means the guest-cid of the nitro VM is CID 5, right?

And the applications in the host would need to use VMADDR_CID_LOCAL
for communication instead of "guest-cid" (5) (assuming vsock_loopback
is modprobed). Let's say there are 2 applications inside the nitro VM
that connect to CID 3 on port 9000 and 9001. And the applications on
the host listen on 9000 and 9001 using VMADDR_CID_LOCAL. So, after the
commands above (qemu VM and vhost-device-vsock) are run, the
communication between the applications in the host and the
applications in the nitro VM on port 9000 and 9001 should just work,
right, without needing to run any extra socat commands or such? or
will the user still need to run some socat commands for all the
relevant ports (e.g.,9000 and 9001)?

I am just wondering what kind of changes are needed in
vhost-device-vsock for forwarding packets to VMADDR_CID_LOCAL? Will
that be something like this: the codepath that handles
"/tmp/vm5.vsock", upon receiving a "connect" (from inside the nitro
VM) for any port to "/tmp/vm5.vsock", vhost-device-vsock will just
connect to the same port using AF_VSOCK using the socket system calls
and messages received on that port in "/tmp/vm5.vsock" will be "send"
to the AF_VSOCK socket? or am I not thinking right and the
implementation would be something different entirely (change the CID
from 3 to 2 (or 1?) on the packets before they are handled then socat
will be needed probably)? Will this work if the applications in the
host want to connect to applications inside the nitro VM (as opposed
to applications inside the nitro VM connecting to CID 3)?

Thanks and Regards,
Dorjoy
