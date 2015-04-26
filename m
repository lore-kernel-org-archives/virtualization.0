From: Luke Gorrie <luke@snabb.co>
Subject: Re: [virtio-dev] Zerocopy VM-to-VM networking using virtio-net
Date: Sun, 26 Apr 2015 15:24:19 +0200
Message-ID: <CAA2XHbed=GMwCAUN4uz4vJ=JZdWeik=D07vwiwV5natk9XSdCg@mail.gmail.com>
References: <20150422170138.GA8388@stefanha-thinkpad.redhat.com>
	<CAA2XHbd_Wxs3O6ChSGouF3ZGH-SA0Lzw7OFVfvnuAXZmLAkZoA@mail.gmail.com>
	<CAJSP0QWtbzWwbvHYHVDJ2bccJ1wPZ0WA31bOH5UkGMhbkLF-Ng@mail.gmail.com>
	<CAA2XHbdvxTviZ-wxRVd87EuajcrOb1g=3Rafdyc5cXrzGbJMqA@mail.gmail.com>
	<CAJSP0QU=0KXC3uRjFGukNvKQkSLnSOMvXpEoLgzoxD7CRSx2iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4519125720344708111=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJSP0QU=0KXC3uRjFGukNvKQkSLnSOMvXpEoLgzoxD7CRSx2iA@mail.gmail.com>
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

--===============4519125720344708111==
Content-Type: multipart/alternative; boundary=047d7bb0427201836c0514a08c6f

--047d7bb0427201836c0514a08c6f
Content-Type: text/plain; charset=UTF-8

On 24 April 2015 at 15:22, Stefan Hajnoczi <stefanha@gmail.com> wrote:

> The motivation for making VM-to-VM fast is that while software
> switches on the host are efficient today (thanks to vhost-user), there
> is no efficient solution if the software switch is a VM.
>

I see. This sounds like a noble goal indeed. I would love to run the
software switch as just another VM in the long term. It would make it much
easier for the various software switches to coexist in the world.

The main technical risk I see in this proposal is that eliminating the
memory copies might not have the desired effect. I might be tempted to keep
the copies but prevent the kernel from having to inspect the vrings (more
like vhost-user). But that is just a hunch and I suppose the first step
would be a prototype to check the performance anyway.

For what it is worth here is my view of networking performance on x86 in
the Haswell+ era:
https://groups.google.com/forum/#!topic/snabb-devel/aez4pEnd4ow

Have you had requests to run SnabbSwitch in a VM instead of on the
> host?


This is not something we have discussed.

I can say that I am not satisfied with our installation process on the
host. I want this to be trivially easy, but it is not.

On the one hand we make some parts easy: we only require one executable
file (~1.5MB) and it works on any modern distro and kernel.

On the other hand we require the user to edit grub.conf to reserve cores
and keep the IOMMU out of the way, and to manually run a traffic process
for each 10G port pinned to a suitable core. That requires a bunch of
downstream work.

Gory details:
https://github.com/SnabbCo/snabb-nfv/wiki/Compute-node-requirements

This should be much simpler. I would quite like to be able to wrap this up
in a VM or a container. The risk is that then we become dependent on other
systems (e.g. OpenStack) pinning cores correctly, etc, and that might be
placing unrealistic expectations on the orchestration systems of the
present and near future (?). I mean: if we make this somebody else's
problem, we had better trust that they will do it right.

Cheers,
-Luke

--047d7bb0427201836c0514a08c6f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On 2=
4 April 2015 at 15:22, Stefan Hajnoczi <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:stefanha@gmail.com" target=3D"_blank">stefanha@gmail.com</a>&gt;</span>=
 wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-st=
yle:solid;padding-left:1ex">The motivation for making VM-to-VM fast is that=
 while software<br>
switches on the host are efficient today (thanks to vhost-user), there<br>
is no efficient solution if the software switch is a VM.<br></blockquote><d=
iv><br></div><div>I see. This sounds like a noble goal indeed. I would love=
 to run the software switch as just another VM in the long term. It would m=
ake it much easier for the various software switches to coexist in the worl=
d.</div><div><br></div><div>The main technical risk I see in this proposal =
is that eliminating the memory copies might not have the desired effect. I =
might be tempted to keep the copies but prevent the kernel from having to i=
nspect the vrings (more like vhost-user). But that is just a hunch and I su=
ppose the first step would be a prototype to check the performance anyway.<=
/div><div><br></div><div>For what it is worth here is my view of networking=
 performance on x86 in the Haswell+ era:</div><div><a href=3D"https://group=
s.google.com/forum/#!topic/snabb-devel/aez4pEnd4ow">https://groups.google.c=
om/forum/#!topic/snabb-devel/aez4pEnd4ow</a></div><div><br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width=
:1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-lef=
t:1ex">Have you had requests to run SnabbSwitch in a VM instead of on the<b=
r>
host?</blockquote><div><br></div><div>This is not something we have discuss=
ed.</div><div><br></div><div>I can say that I am not satisfied with our ins=
tallation process on the host. I want this to be trivially easy, but it is =
not.</div><div><br></div><div>On the one hand we make some parts easy: we o=
nly require one executable file (~1.5MB) and it works on any modern distro =
and kernel.</div><div><br></div><div>On the other hand we require the user =
to edit grub.conf to reserve cores and keep the IOMMU out of the way, and t=
o manually run a traffic process for each 10G port pinned to a suitable cor=
e. That requires a bunch of downstream work.</div><div><br></div><div>Gory =
details:<br></div><div><a href=3D"https://github.com/SnabbCo/snabb-nfv/wiki=
/Compute-node-requirements">https://github.com/SnabbCo/snabb-nfv/wiki/Compu=
te-node-requirements</a><br></div><div><br></div><div>This should be much s=
impler. I would quite like to be able to wrap this up in a VM or a containe=
r. The risk is that then we become dependent on other systems (e.g. OpenSta=
ck) pinning cores correctly, etc, and that might be placing unrealistic exp=
ectations on the orchestration systems of the present and near future (?). =
I mean: if we make this somebody else&#39;s problem, we had better trust th=
at they will do it right.</div><div><br></div><div>Cheers,</div><div>-Luke<=
/div><div><br></div><div><br></div></div></div></div>

--047d7bb0427201836c0514a08c6f--

--===============4519125720344708111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4519125720344708111==--
