From: Luke Gorrie <luke@snabb.co>
Subject: Re: [virtio-dev] Zerocopy VM-to-VM networking using virtio-net
Date: Fri, 24 Apr 2015 10:12:23 +0200
Message-ID: <CAA2XHbd_Wxs3O6ChSGouF3ZGH-SA0Lzw7OFVfvnuAXZmLAkZoA@mail.gmail.com>
References: <20150422170138.GA8388@stefanha-thinkpad.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8617210196920538664=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150422170138.GA8388@stefanha-thinkpad.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Andrew Jones <drjones@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Rik van Riel <riel@redhat.com>, virtualization@lists.linux-foundation.org, virtio-comment@lists.oasis-open.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

--===============8617210196920538664==
Content-Type: multipart/alternative; boundary=089e010d83f6bc12bf051473f40c

--089e010d83f6bc12bf051473f40c
Content-Type: text/plain; charset=UTF-8

Hi Stefan,

Great topic. I am also extremely interested in helping Virtio-net become
the standard for the networking industry (the universe of DPDK, etc).

On 22 April 2015 at 19:01, Stefan Hajnoczi <stefanha@redhat.com> wrote:

> [It may be necessary to remove virtio-dev@lists.oasis-open.org from CC
> if you are a non-TC member.]
>

[Done.]

I think this approach could be fruitful in bringing virtio-net to
> VM-to-VM networking use cases.  Unless virtio-net is extended for this
> use case, I'm afraid DPDK and OpenDataPlane communities might steer
> clear of VIRTIO.
>

Questions:

- How fast is needed?

- How fast is the vhost-user support that shipped in DPDK 2.0?

- How fast would the new design likely be?

Our recent experience in Snabb Switch land is that networking on x86 is now
more of a HPC problem than a system programming problem. The SIMD bandwidth
per core keeps increasing that this erodes the value of traditional (and
complex) system programming optimizations. I will be interested to compare
notes with others on this, already on Haswell but more so when we have
AVX512.

Incidentally, we also did a pile of work last year on zero-copy NIC->VM
transfers and discovered a lot of interesting problems and edge cases where
Virtio-net spec and/or drivers are hard to match up with common NICs. Happy
to explain a bit about our experience if that would be valuable.

Cheers,
-Luke

--089e010d83f6bc12bf051473f40c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Stefan,<div><br></div><div>Great topic. I am also extre=
mely interested in helping Virtio-net become the standard for the networkin=
g industry (the universe of DPDK, etc).<br><div class=3D"gmail_extra"><br><=
div class=3D"gmail_quote">On 22 April 2015 at 19:01, Stefan Hajnoczi <span =
dir=3D"ltr">&lt;<a href=3D"mailto:stefanha@redhat.com" target=3D"_blank">st=
efanha@redhat.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">[=
It may be necessary to remove <a href=3D"mailto:virtio-dev@lists.oasis-open=
.org">virtio-dev@lists.oasis-open.org</a> from CC<br>
if you are a non-TC member.]<br></blockquote><div><br></div><div>[Done.]</d=
iv><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">I think this approach coul=
d be fruitful in bringing virtio-net to<br>
VM-to-VM networking use cases.=C2=A0 Unless virtio-net is extended for this=
<br>
use case, I&#39;m afraid DPDK and OpenDataPlane communities might steer<br>
clear of VIRTIO.<br></blockquote><div><br></div><div>Questions:</div><div><=
br></div><div>- How fast is needed?</div><div><br></div><div>- How fast is =
the vhost-user support that shipped in DPDK 2.0?</div><div><br></div><div>-=
 How fast would the new design likely be?</div><div><br></div><div>Our rece=
nt experience in Snabb Switch land is that networking on x86 is now more of=
 a HPC problem than a system programming problem. The SIMD bandwidth per co=
re keeps increasing that this erodes the value of traditional (and complex)=
 system programming optimizations. I will be interested to compare notes wi=
th others on this, already on Haswell but more so when we have AVX512.</div=
><div><br></div><div>Incidentally, we also did a pile of work last year on =
zero-copy NIC-&gt;VM transfers and discovered a lot of interesting problems=
 and edge cases where Virtio-net spec and/or drivers are hard to match up w=
ith common NICs. Happy to explain a bit about our experience if that would =
be valuable.</div><div><br></div><div>Cheers,</div><div>-Luke</div><div><br=
></div><div><br></div></div></div></div></div>

--089e010d83f6bc12bf051473f40c--

--===============8617210196920538664==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8617210196920538664==--
