From: Tyler Sanderson via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: Re: VIRTIO_BALLOON_F_FREE_PAGE_HINT
Date: Sun, 6 Oct 2019 14:42:14 -0700
Message-ID: <CAJuQAmpbmTq8mwYCf1G9Qr7ZB0WtG3VCVyfbEYsm6qUOM1N9Zw@mail.gmail.com>
References: <5D7EE856.2080602@intel.com>
	<09257686-90df-5c31-c35f-9d16fc77fee1@redhat.com>
	<CAJuQAmpQV26kb9vTyoW-Q7PsD0SOfX+otkiQZAks1L6k7rgdig@mail.gmail.com>
	<20191003142854-mutt-send-email-mst@kernel.org>
	<CAJuQAmrCiPsofYpDvm8=i32d9c9yCmKpJRBSRFkeubP_2=XKtw@mail.gmail.com>
	<0df87f00-5102-973b-3a7a-735e44f4ac3f@redhat.com>
	<20191004043446-mutt-send-email-mst@kernel.org>
	<30c6feba-7037-b52f-3ef4-4a5c50be0aff@redhat.com>
	<CAJuQAmpwQ4guGtHTTWC60EAYBuJ264d6CgWmWEHSnb8-CRtWBw@mail.gmail.com>
	<859eada9-d3e2-8f28-ebd6-a8cb562dbff5@redhat.com>
	<20191006073919-mutt-send-email-mst@kernel.org>
Reply-To: Tyler Sanderson <tysand@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7426871338427871768=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191006073919-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

--===============7426871338427871768==
Content-Type: multipart/alternative; boundary="000000000000a18f2b059444cffa"

--000000000000a18f2b059444cffa
Content-Type: text/plain; charset="UTF-8"

On Sun, Oct 6, 2019 at 4:48 AM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Sun, Oct 06, 2019 at 10:30:40AM +0200, David Hildenbrand wrote:
> > Please note the "use outside of a testing or debugging environment is
> > not recommended". Usually you want a "soft" version of this, e.g., via
> > the OOM handler (so only drop parts of the cache, not all).
>
> Right. We'll need something softer I guess. By how much, I don't know.
>

It should be left up to the guest system administrator to configure the
trade off between performance and cache memory reclaimed.
And the primary performance metric would be cache hit rate.
So maybe some configuration option that lets you drop cache pages that have
a hit rate less than X per minute.
Or more simply: Pages that haven't been hit in the last X seconds.

The other way to do it would be to set a strict cache size limit, but that
would be workload dependent and toilsome to tune correctly, so it seems
like a worse choice.


>
> --
> MST
>

--000000000000a18f2b059444cffa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Oct 6, 2019 at 4:48 AM Michae=
l S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Sun, Oc=
t 06, 2019 at 10:30:40AM +0200, David Hildenbrand wrote:<br>
&gt; Please note the &quot;use outside of a testing or debugging environmen=
t is<br>
&gt; not recommended&quot;. Usually you want a &quot;soft&quot; version of =
this, e.g., via<br>
&gt; the OOM handler (so only drop parts of the cache, not all).<br>
<br>
Right. We&#39;ll need something softer I guess. By how much, I don&#39;t kn=
ow.<br></blockquote><div><br></div><div>It should be left up to the guest s=
ystem administrator to configure the trade off between performance and cach=
e memory reclaimed.</div><div>And the primary performance metric would be c=
ache hit rate.</div><div>So maybe some configuration option that lets you d=
rop cache pages that have a hit rate less than X per minute.</div><div>Or m=
ore simply: Pages that haven&#39;t been hit in the last X seconds.</div><di=
v><br></div><div>The other way to do it would be to set a strict cache size=
 limit, but that would be workload dependent and toilsome to tune correctly=
, so it seems like a worse choice.</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
-- <br>
MST<br>
</blockquote></div></div>

--000000000000a18f2b059444cffa--

--===============7426871338427871768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7426871338427871768==--
