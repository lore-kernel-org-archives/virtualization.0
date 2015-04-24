From: Luke Gorrie <luke@snabb.co>
Subject: Re: [virtio-dev] Zerocopy VM-to-VM networking using virtio-net
Date: Fri, 24 Apr 2015 14:17:54 +0200
Message-ID: <CAA2XHbdvxTviZ-wxRVd87EuajcrOb1g=3Rafdyc5cXrzGbJMqA@mail.gmail.com>
References: <20150422170138.GA8388@stefanha-thinkpad.redhat.com>
	<CAA2XHbd_Wxs3O6ChSGouF3ZGH-SA0Lzw7OFVfvnuAXZmLAkZoA@mail.gmail.com>
	<CAJSP0QWtbzWwbvHYHVDJ2bccJ1wPZ0WA31bOH5UkGMhbkLF-Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9045202712520385152=="
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
Cc: Andrew Jones <drjones@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Rik van Riel <riel@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-comment@lists.oasis-open.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

--===============9045202712520385152==
Content-Type: multipart/alternative; boundary=f46d04426ca6c80b12051477620c

--f46d04426ca6c80b12051477620c
Content-Type: text/plain; charset=UTF-8

On 24 April 2015 at 11:47, Stefan Hajnoczi <stefanha@gmail.com> wrote:

> My concern is the overhead of the vhost_net component copying
> descriptors between NICs.


I see. So you would not have to reserve CPU resources for vswitches.
Instead you would give all cores to the VMs and they would pay for their
own networking. This would be especially appealing in the extreme case
where all networking is "Layer 1" connectivity between local virtual
machines.

This would make VM<->VM links different to VM<->network links. I suppose
that when you created VMs you would need to be conscious of whether or not
you are placing them on the same host or NUMA node so that you can predict
what network performance will be available.

For what it is worth, I think this would make life more difficult for
network operators hosting DPDK-style network applications ("NFV").
Virtio-net would become a more complex abstraction, the orchestration
systems would need to take this into account, and there would be more
opportunity for interoperability problems between virtual machines.

The simpler alternative that I prefer is to provide network operators with
a Virtio-net abstraction that behaves and performs in exactly the same way
for all kinds of network traffic -- whether or not the VMs are on the same
machine and NUMA node.

That would be more in line with SR-IOV behavior which seems to me like the
other horse in this race. Perhaps my world view here is too narrow though
and other technologies like ivshmem are more relevant than I give them
credit for?

--f46d04426ca6c80b12051477620c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On 2=
4 April 2015 at 11:47, Stefan Hajnoczi <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:stefanha@gmail.com" target=3D"_blank">stefanha@gmail.com</a>&gt;</span>=
 wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">My concern is the overhead of the=
 vhost_net component copying<br>
descriptors between NICs.</blockquote><div><br></div><div>I see. So you wou=
ld not have to reserve CPU resources for vswitches. Instead you would give =
all cores to the VMs and they would pay for their own networking. This woul=
d be especially appealing in the extreme case where all networking is &quot=
;Layer 1&quot; connectivity between local virtual machines.</div><div><br><=
/div><div>This would make VM&lt;-&gt;VM links different to VM&lt;-&gt;netwo=
rk links. I suppose that when you created VMs you would need to be consciou=
s of whether or not you are placing them on the same host or NUMA node so t=
hat you can predict what network performance will be available.</div><div><=
br></div><div>For what it is worth, I think this would make life more diffi=
cult for network operators hosting DPDK-style network applications (&quot;N=
FV&quot;). Virtio-net would become a more complex abstraction, the orchestr=
ation systems would need to take this into account, and there would be more=
 opportunity for interoperability problems between virtual machines.</div><=
div><br></div><div>The simpler alternative that I prefer is to provide netw=
ork operators with a Virtio-net abstraction that behaves and performs in ex=
actly the same way for all kinds of network traffic -- whether or not the V=
Ms are on the same machine and NUMA node.</div><div><br></div><div>That wou=
ld be more in line with SR-IOV behavior which seems to me like the other ho=
rse in this race. Perhaps my world view here is too narrow though and other=
 technologies like ivshmem are more relevant than I give them credit for?</=
div><div><br></div><div><br></div></div></div></div>

--f46d04426ca6c80b12051477620c--

--===============9045202712520385152==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============9045202712520385152==--
