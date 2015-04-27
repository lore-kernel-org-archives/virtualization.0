From: Luke Gorrie <luke@snabb.co>
Subject: Re: [virtio-dev] Zerocopy VM-to-VM networking using virtio-net
Date: Mon, 27 Apr 2015 16:36:49 +0200
Message-ID: <CAA2XHbd9DX6FXg3Ck++gxHxgr4qLR9ArDQrr+Z5eS7jT+8u-2g@mail.gmail.com>
References: <20150422170138.GA8388@stefanha-thinkpad.redhat.com>
	<CAA2XHbd_Wxs3O6ChSGouF3ZGH-SA0Lzw7OFVfvnuAXZmLAkZoA@mail.gmail.com>
	<CAJSP0QWtbzWwbvHYHVDJ2bccJ1wPZ0WA31bOH5UkGMhbkLF-Ng@mail.gmail.com>
	<CAA2XHbdvxTviZ-wxRVd87EuajcrOb1g=3Rafdyc5cXrzGbJMqA@mail.gmail.com>
	<CAJSP0QU=0KXC3uRjFGukNvKQkSLnSOMvXpEoLgzoxD7CRSx2iA@mail.gmail.com>
	<CAA2XHbed=GMwCAUN4uz4vJ=JZdWeik=D07vwiwV5natk9XSdCg@mail.gmail.com>
	<CAJSP0QW9dqvbqNVt0Ggk2d=Yd=jCQsbCqZA+TCEaGqU35wbDjg@mail.gmail.com>
	<553E2D07.9040406@siemens.com> <553E31DC.6040108@siemens.com>
	<CAJSP0QVLCN-=7V3K8CJL8n0sN_Zm=vpJzWksH9gbYEP+AU8ndQ@mail.gmail.com>
	<553E480B.1020502@siemens.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2169312678547170699=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <553E480B.1020502@siemens.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Andrew Jones <drjones@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Rik van Riel <riel@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

--===============2169312678547170699==
Content-Type: multipart/alternative; boundary=f46d0442886c1c75430514b5ad50

--f46d0442886c1c75430514b5ad50
Content-Type: text/plain; charset=UTF-8

On 27 April 2015 at 16:30, Jan Kiszka <jan.kiszka@siemens.com> wrote:

> Today, we have posted interrupts to avoid the vm-exit on the target CPU,
> but there is nothing yet (to my best knowledge) to avoid the exit on the
> sender side (unless we ignore security). That's the same problem with
> intra-guest IPIs, BTW.
>
> For throughput and given NAPI patterns, that's probably not an issue as
> you noted. It may be for latency, though, when almost every cycle counts.
>

Poll-mode networking applications (DPDK, Snabb Switch, etc) are typically
busy-looping to poll the vring. They may have a very short usleep() between
checks to save power but they don't wait on their eventfd. So for those
particular applications latency is on the order of tens of microseconds
even without guest exits.

--f46d0442886c1c75430514b5ad50
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On 2=
7 April 2015 at 16:30, Jan Kiszka <span dir=3D"ltr">&lt;<a href=3D"mailto:j=
an.kiszka@siemens.com" target=3D"_blank">jan.kiszka@siemens.com</a>&gt;</sp=
an> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div cla=
ss=3D"h5"><span style=3D"color:rgb(34,34,34)">Today, we have posted interru=
pts to avoid the vm-exit on the target CPU,</span><br></div></div>
but there is nothing yet (to my best knowledge) to avoid the exit on the<br=
>
sender side (unless we ignore security). That&#39;s the same problem with<b=
r>
intra-guest IPIs, BTW.<br>
<br>
For throughput and given NAPI patterns, that&#39;s probably not an issue as=
<br>
you noted. It may be for latency, though, when almost every cycle counts.<b=
r></blockquote><div><br></div><div>Poll-mode networking applications (DPDK,=
 Snabb Switch, etc) are typically busy-looping to poll the vring. They may =
have a very short usleep() between checks to save power but they don&#39;t =
wait on their eventfd. So for those particular applications latency is on t=
he order of tens of microseconds even without guest exits.</div><div><br></=
div><div><br></div></div></div></div>

--f46d0442886c1c75430514b5ad50--

--===============2169312678547170699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2169312678547170699==--
