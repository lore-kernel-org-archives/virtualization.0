From: Luke Gorrie <luke@snabb.co>
Subject: Re: [virtio-dev] Zerocopy VM-to-VM networking using virtio-net
Date: Fri, 24 Apr 2015 14:34:37 +0200
Message-ID: <CAA2XHbeq=OGjXFt00H3gKDrY7P_0VnBWDXkvFyiN-e_3zT-Ujw@mail.gmail.com>
References: <20150422170138.GA8388@stefanha-thinkpad.redhat.com>
	<CAA2XHbd_Wxs3O6ChSGouF3ZGH-SA0Lzw7OFVfvnuAXZmLAkZoA@mail.gmail.com>
	<CAJSP0QWtbzWwbvHYHVDJ2bccJ1wPZ0WA31bOH5UkGMhbkLF-Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8636071126157885145=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJSP0QWtbzWwbvHYHVDJ2bccJ1wPZ0WA31bOH5UkGMhbkLF-Ng@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Andrew Jones <drjones@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Rik van Riel <riel@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

--===============8636071126157885145==
Content-Type: multipart/alternative; boundary=f46d0442886c994d400514779e1f

--f46d0442886c994d400514779e1f
Content-Type: text/plain; charset=UTF-8

On 24 April 2015 at 11:47, Stefan Hajnoczi <stefanha@gmail.com> wrote:

> > Incidentally, we also did a pile of work last year on zero-copy NIC->VM
> > transfers and discovered a lot of interesting problems and edge cases
> where
> > Virtio-net spec and/or drivers are hard to match up with common NICs.
> Happy
> > to explain a bit about our experience if that would be valuable.
>
> That sounds interesting, can you describe the setup?
>

Sure.

We implemented a zero-copy receive path that maps guest buffers received
from the avail ring directly onto hardware receive buffers on a dedicated
hardware receive queue for that VM (VMDq).

This means that when the NIC receives a packet it stores it directly into
the guest's memory but the vswitch has the opportunity to do as much or as
little processing as it wants before making the packet available with a
used ring descriptor.

This scheme seems quite elegant to me. (I am sure it is not original - this
is what the VMDq hardware feature is for, after all.) The devil is in the
details though.

I suspect it would work well given two extensions to Virtio-net:

1. The 'used' ring allow an offset where the payload starts.

2. The guest to always supply buffers with space for >= 2048 bytes of
payload.

but without these things it is tricky to satisfy the requirements of real
NICs such as the Intel 10G ones. There are conflicting requirements. For
example:

- NIC requires buffer sizes to be uniform and a multiple of 1024 bytes.
Guest suppliers variable-size buffers often of ~1500 bytes. These need to
be either rounded down to 1024 bytes (causing excessive segmentation) or
rounded up to 2048 bytes (requiring jumbo frames to be globally disabled on
the port to avoid potential overruns).

- Virtio-net with MRG_RXBUF expects the packet payload to be in a different
offset for the first descriptor in a chain (offset 14 after the vnet
header) vs following descriptions in the chain (offset 0). The NIC always
stores packets at the same offset so the vswitch needs to pick one and then
correct with memmove() when needed.

- If the vswitch wants to shorten the packet payload, e.g. to remove
encapsulation, then this will require a memmove() because there is no way
to communicate an offset on the used ring.

- The NIC has a limit to how many receive descriptors it can chain
together. If the guest is supplying small buffers then this limit may be
too low for jumbo frames to be received.

... and at a certain point we decided we were better off switching our
focus away from clever-but-fragile NIC hacks and towards clever-and-robust
SIMD hacks, and that is the path we have been on since a few months ago.

--f46d0442886c994d400514779e1f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On 2=
4 April 2015 at 11:47, Stefan Hajnoczi <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:stefanha@gmail.com" target=3D"_blank">stefanha@gmail.com</a>&gt;</span>=
 wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex"><span class=3D"">&gt; Incidentall=
y, we also did a pile of work last year on zero-copy NIC-&gt;VM<br>
&gt; transfers and discovered a lot of interesting problems and edge cases =
where<br>
&gt; Virtio-net spec and/or drivers are hard to match up with common NICs. =
Happy<br>
&gt; to explain a bit about our experience if that would be valuable.<br>
<br>
</span>That sounds interesting, can you describe the setup?<br></blockquote=
><div><br></div><div>Sure.</div><div><br></div><div>We implemented a zero-c=
opy receive path that maps guest buffers received from the avail ring direc=
tly onto hardware receive buffers on a dedicated hardware receive queue for=
 that VM (VMDq).</div><div><br></div><div>This means that when the NIC rece=
ives a packet it stores it directly into the guest&#39;s memory but the vsw=
itch has the opportunity to do as much or as little processing as it wants =
before making the packet available with a used ring descriptor.</div><div><=
br></div><div>This scheme seems quite elegant to me. (I am sure it is not o=
riginal - this is what the VMDq hardware feature is for, after all.) The de=
vil is in the details though.</div><div><br></div><div>I suspect it would w=
ork well given two extensions to Virtio-net:</div><div><br></div><div>1. Th=
e &#39;used&#39; ring allow an offset where the payload starts.</div><div><=
br></div><div>2. The guest to always supply buffers with space for &gt;=3D =
2048 bytes of payload.</div><div><br></div><div>but without these things it=
 is tricky to satisfy the requirements of real NICs such as the Intel 10G o=
nes. There are conflicting requirements. For example:</div><div><br></div><=
div>- NIC requires buffer sizes to be uniform and a multiple of 1024 bytes.=
 Guest suppliers variable-size buffers often of ~1500 bytes. These need to =
be either rounded down to 1024 bytes (causing excessive segmentation) or ro=
unded up to 2048 bytes (requiring jumbo frames to be globally disabled on t=
he port to avoid potential overruns).</div><div><br></div><div>- Virtio-net=
 with MRG_RXBUF expects the packet payload to be in a different offset for =
the first descriptor in a chain (offset 14 after the vnet header) vs follow=
ing descriptions in the chain (offset 0). The NIC always stores packets at =
the same offset so the vswitch needs to pick one and then correct with memm=
ove() when needed.</div><div><br></div><div>- If the vswitch wants to short=
en the packet payload, e.g. to remove encapsulation, then this will require=
 a memmove() because there is no way to communicate an offset on the used r=
ing.</div><div><br></div><div>- The NIC has a limit to how many receive des=
criptors it can chain together. If the guest is supplying small buffers the=
n this limit may be too low for jumbo frames to be received.</div><div><br>=
</div><div>... and at a certain point we decided we were better off switchi=
ng our focus away from clever-but-fragile NIC hacks and towards clever-and-=
robust SIMD hacks, and that is the path we have been on since a few months =
ago.</div><div><br></div><div><br></div><div><br></div><div><br></div></div=
></div></div>

--f46d0442886c994d400514779e1f--

--===============8636071126157885145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8636071126157885145==--
