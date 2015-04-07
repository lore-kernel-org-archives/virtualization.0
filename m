From: Luke Gorrie <luke@snabb.co>
Subject: Re: [snabb-devel] Re: memory barriers in virtq.lua?
Date: Tue, 7 Apr 2015 16:22:42 +0200
Message-ID: <CAA2XHbcU0tV0NrBXT6oh6LOz7sKm9P8jqD1=T-ZgTahSVM_qwQ__10662.5897264623$1428425992$gmane$org@mail.gmail.com>
References: <20150127160126.GA10651@redhat.com>
	<CADDJ2=M6hwFwooXqUjUc9+JxjW1sVYvKhY9dBavrmMUrej6Ysw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6151805301478526211=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CADDJ2=M6hwFwooXqUjUc9+JxjW1sVYvKhY9dBavrmMUrej6Ysw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "snabb-devel@googlegroups.com" <snabb-devel@googlegroups.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, virtualization@lists.linux-foundation.org, VirtualOpenSystems Technical Team <tech@virtualopensystems.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

--===============6151805301478526211==
Content-Type: multipart/alternative; boundary=001a11c26e5cd4ba5b0513232593

--001a11c26e5cd4ba5b0513232593
Content-Type: text/plain; charset=UTF-8

Hi Michael,

I'm writing to follow up the previous discussion about memory barriers in
virtio-net device implementations, and Cc'ing the DPDK list because I
believe this is relevant to them too.

First, thanks again for getting in touch and reviewing our code.

I have now found a missed case where we *do* require a hardware memory
barrier on x86 in our vhost/virtio-net device. That is when checking the
interrupt suppression flag after updating used->idx. This is needed because
x86 can reorder the write to used->idx after the read from avail->flags,
and that causes the guest to see a stale value of used->idx after it
toggles interrupt suppression.

If I may spell out my mental model, for the sake of being corrected and/or
as an example of how third party developers are reading and interpreting
the Virtio-net spec:

Relating this to Virtio 1.0, the most relevant section is 3.2.1 (Supplying
Buffers to the Device) which calls for two "suitable memory barriers". The
spec talks about these from the driver perspective, but they are both
relevant to the device side too.

The first barrier (write to descriptor table before write to used->idx) is
implicit on x86 because writes by the same core are not reordered. This
means that no explicit hardware barrier is needed. (A compiler barrier may
be needed, however.)

The second memory barrier (write to used->idx before reading avail->flags)
is not implicit on x86 because stores are reordered after loads. So an
explicit hardware memory barrier is needed.

I hope that is a correct assessment of the situation. (Forgive my
x86centricity, I am sure that seems very foreign to kernel hackers.)

If this assessment is correct then the DPDK developers might also want to
review librte_vhost/vhost_rxtx.c and consider adding a hardware memory
barrier between writing used->idx and reading avail->flags.

Cheers,
-Luke

P.S. I notice that the Linux virtio-net driver does not seem to tolerate
spurious interrupts, even though the Virtio 1.0 spec requires this
("must"). On 3.13.11-ckt15 I see them trigger an "irq nobody cared" kernel
log message and then the irq is disabled. If that sounds suspicious I can
supply more information.

--001a11c26e5cd4ba5b0513232593
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">Hi M=
ichael,</div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote=
">I&#39;m writing to follow up the previous discussion about memory barrier=
s in virtio-net device implementations, and Cc&#39;ing the DPDK list becaus=
e I believe this is relevant to them too.</div><div class=3D"gmail_quote"><=
br></div><div class=3D"gmail_quote">First, thanks again for getting in touc=
h and reviewing our code.</div><div class=3D"gmail_quote"><br></div><div cl=
ass=3D"gmail_quote">I have now found a missed case where we *do* require a =
hardware memory barrier on x86 in our vhost/virtio-net device. That is when=
 checking the interrupt suppression flag after updating used-&gt;idx. This =
is needed because x86 can reorder the write to used-&gt;idx after the read =
from avail-&gt;flags, and that causes the guest to see a stale value of use=
d-&gt;idx after it toggles interrupt suppression.</div><div class=3D"gmail_=
quote"><br></div><div class=3D"gmail_quote">If I may spell out my mental mo=
del, for the sake of being corrected and/or as an example of how third part=
y developers are reading and interpreting the Virtio-net spec:</div><div cl=
ass=3D"gmail_quote"><br></div><div class=3D"gmail_quote">Relating this to V=
irtio 1.0, the most relevant section is 3.2.1 (Supplying Buffers to the Dev=
ice) which calls for two &quot;suitable memory barriers&quot;. The spec tal=
ks about these from the driver perspective, but they are both relevant to t=
he device side too.</div><div class=3D"gmail_quote"><br></div><div class=3D=
"gmail_quote">The first barrier (write to descriptor table before write to =
used-&gt;idx) is implicit on x86 because writes by the same core are not re=
ordered. This means that no explicit hardware barrier is needed. (A compile=
r barrier may be needed, however.)</div><div class=3D"gmail_quote"><br></di=
v><div class=3D"gmail_quote">The second memory barrier (write to used-&gt;i=
dx before reading avail-&gt;flags) is not implicit on x86 because stores ar=
e reordered after loads. So an explicit hardware memory barrier is needed.<=
/div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">I hope=
 that is a correct assessment of the situation. (Forgive my x86centricity, =
I am sure that seems very foreign to kernel hackers.)</div><div class=3D"gm=
ail_quote"><br></div><div class=3D"gmail_quote">If this assessment is corre=
ct then the DPDK developers might also want to review librte_vhost/vhost_rx=
tx.c and consider adding a hardware memory barrier between writing used-&gt=
;idx and reading avail-&gt;flags.</div><div class=3D"gmail_quote"><br></div=
><div class=3D"gmail_quote">Cheers,</div><div class=3D"gmail_quote">-Luke</=
div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">P.S. I =
notice that the Linux virtio-net driver does not seem to tolerate spurious =
interrupts, even though the Virtio 1.0 spec requires this (&quot;must&quot;=
). On 3.13.11-ckt15 I see them trigger an &quot;irq nobody cared&quot; kern=
el log message and then the irq is disabled. If that sounds suspicious I ca=
n supply more information.</div><div class=3D"gmail_quote"><br></div><div c=
lass=3D"gmail_quote"><br></div></div></div>

--001a11c26e5cd4ba5b0513232593--

--===============6151805301478526211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6151805301478526211==--
