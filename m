From: Siwei Liu <loseweigh@gmail.com>
Subject: Re: [RFC PATCH] virtio_net: Extend virtio to use VF datapath when
	available
Date: Wed, 20 Dec 2017 17:31:07 -0800
Message-ID: <CADGSJ23XuaGtBt2AY95nbHVMQ-mAhDsTDLFtg=3o_09HAH9mtg@mail.gmail.com>
References: <20171219174259-mutt-send-email-mst@kernel.org>
	<ca709329-a47a-2e76-b1fc-38fc665d7c0b@intel.com>
	<20171219095548.61d70d10@xeon-e3>
	<20171219.132117.666798483874609477.davem@davemloft.net>
	<20171219104159.30d9caaf@xeon-e3>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3111808510489425058=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171219104159.30d9caaf@xeon-e3>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: mst@redhat.com, sridhar.samudrala@intel.com, alexander.duyck@gmail.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

--===============3111808510489425058==
Content-Type: multipart/alternative; boundary="001a1140228681bb650560cfa78d"

--001a1140228681bb650560cfa78d
Content-Type: text/plain; charset="UTF-8"

On Tue, Dec 19, 2017 at 10:41 AM, Stephen Hemminger <
stephen@networkplumber.org> wrote:

> On Tue, 19 Dec 2017 13:21:17 -0500 (EST)
> David Miller <davem@davemloft.net> wrote:
>
> > From: Stephen Hemminger <stephen@networkplumber.org>
> > Date: Tue, 19 Dec 2017 09:55:48 -0800
> >
> > > could be 10ms, just enough to let udev do its renaming
> >
> > Please, move to some kind of notification or event based handling of
> > this problem.
> >
> > No delay is safe, what if userspace gets swapped out or whatever
> > else might make userspace stall unexpectedly?
> >
>
> The plan is to remove the delay and do the naming in the kernel.
> This was suggested by Lennart since udev is only doing naming policy
> because kernel names were not repeatable.
>
> This makes the VF show up as "ethN_vf" on Hyper-V which is user friendly.
>
> Patch is pending.
>

While it's good to show VF with specific naming to indicate enslavement, I
wonder wouldn't it be better to hide this netdev at all from the user
space? IMHO this extra device is useless when being enslaved and we may
delegate controls (e.g. ethtool) over to the para-virtual device instead?
That way it's possible to eliminate the possibility of additional udev
setup or modification?

I'm not sure if this  is consistent with Windows guest or not, but I don't
find it _Linux_ user friendly that ethtool doesn't work on the composite
interface any more, and I have to end up with finding out the correct
enslaved VF I must operate on.

Regards,
-Siwei

--001a1140228681bb650560cfa78d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Dec 19, 2017 at 10:41 AM, Stephen Hemminger <span dir=3D"ltr">&=
lt;<a href=3D"mailto:stephen@networkplumber.org" target=3D"_blank">stephen@=
networkplumber.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
<div class=3D"HOEnZb"><div class=3D"h5">On Tue, 19 Dec 2017 13:21:17 -0500 =
(EST)<br>
David Miller &lt;<a href=3D"mailto:davem@davemloft.net">davem@davemloft.net=
</a>&gt; wrote:<br>
<br>
&gt; From: Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumber.o=
rg">stephen@networkplumber.org</a>&gt;<br>
&gt; Date: Tue, 19 Dec 2017 09:55:48 -0800<br>
&gt;<br>
&gt; &gt; could be 10ms, just enough to let udev do its renaming<br>
&gt;<br>
&gt; Please, move to some kind of notification or event based handling of<b=
r>
&gt; this problem.<br>
&gt;<br>
&gt; No delay is safe, what if userspace gets swapped out or whatever<br>
&gt; else might make userspace stall unexpectedly?<br>
&gt;<br>
<br>
</div></div>The plan is to remove the delay and do the naming in the kernel=
.<br>
This was suggested by Lennart since udev is only doing naming policy<br>
because kernel names were not repeatable.<br>
<br>
This makes the VF show up as &quot;ethN_vf&quot; on Hyper-V which is user f=
riendly.<br>
<br>
Patch is pending.<br>
</blockquote></div><div class=3D"gmail_extra"><br></div>While it&#39;s good=
 to show VF with specific naming to indicate enslavement, I wonder wouldn&#=
39;t it be better to hide this netdev at all from the user space? IMHO this=
 extra device is useless when being enslaved and we may delegate controls (=
e.g. ethtool) over to the para-virtual device instead? That way it&#39;s po=
ssible to eliminate the possibility of additional udev setup or modificatio=
n?</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">I&#=
39;m not sure if this=C2=A0 is consistent with Windows guest or not, but I =
don&#39;t find it _Linux_ user friendly that ethtool doesn&#39;t work on th=
e composite interface any more, and I have to end up with finding out the c=
orrect enslaved VF I must operate on.=C2=A0</div><div class=3D"gmail_extra"=
><br></div><div class=3D"gmail_extra">Regards,</div><div class=3D"gmail_ext=
ra">-Siwei</div><div class=3D"gmail_extra"><br></div></div>

--001a1140228681bb650560cfa78d--

--===============3111808510489425058==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3111808510489425058==--
