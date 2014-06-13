From: Jobin Raju George <jobin.rv@gmail.com>
Subject: Re: [Qemu-devel] Why I advise against using ivshmem
Date: Fri, 13 Jun 2014 14:59:33 +0530
Message-ID: <CA+aVsWpPJyfsbMmKUF1ShGHLbYd8kBCtJeHAQb5px+Y3X9n4aQ__13079.1749609218$1402701378$gmane$org@mail.gmail.com>
References: <20140610184818.2e490419@nbschild1> <53978375.6090707@6wind.com>
	<87ppie1v4r.fsf@blackfin.pond.sub.org>
	<20140612094413.15e56938@nbschild1>
	<87vbs6qjhj.fsf_-_@blackfin.pond.sub.org>
	<5399CF09.8030803@6wind.com> <87ppidnqmy.fsf@blackfin.pond.sub.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4802827763824372832=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87ppidnqmy.fsf@blackfin.pond.sub.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Markus Armbruster <armbru@redhat.com>
Cc: Henning Schild <henning.schild@siemens.com>, kvm@vger.kernel.org, QEMU Developers <qemu-devel@nongnu.org>, David Marchand <david.marchand@6wind.com>, sagar patni <patni.sagar12@gmail.com>, virtualization@lists.linux-foundation.org, Vincent JARDIN <vincent.jardin@6wind.com>
List-Id: virtualization@lists.linuxfoundation.org

--===============4802827763824372832==
Content-Type: multipart/alternative; boundary=047d7b2e3d92b30bbb04fbb4501e

--047d7b2e3d92b30bbb04fbb4501e
Content-Type: text/plain; charset=UTF-8

Nahanni's poor current development coupled with virtIO's promising
expansion was what encouraged us to explore virtIO-serial [1] for
inter-virtual machine communication. Though virtIO-serial as it is isn't
helpful for inter-VM communication, some work is needed for this purpose
and this is exactly what we (I and two of my fellow classmates)
accomplished.

We haven't published it yet since we do need to polish yet for upstreaming
it and are planning do it in near future.


[1]: http://fedoraproject.org/wiki/Features/VirtioSerial


On Fri, Jun 13, 2014 at 2:16 PM, Markus Armbruster <armbru@redhat.com>
wrote:

> Some dropped quoted text restored.
>
> Vincent JARDIN <vincent.jardin@6wind.com> writes:
>
> > Markus,
> >
> > see inline (I am not on all mailing list, please, keep the cc list).
> >
> >> Sure!  The reasons for my dislike range from practical to
> >> philosophical.
> >>
> >> My practical concerns include:
> >>
> >> 1. ivshmem code needs work, but has no maintainer
> > See David's contributions:
> >   http://patchwork.ozlabs.org/patch/358750/
>
> We're grateful for David's patch for qemu-char.c, but this isn't ivshmem
> maintenance, yet.
>
> >>   - Error handling is generally poor.  For instance, "device_add
> >>     ivshmem" kills your guest instantly.
> >>
> >>   - More subjectively, I don't trust the code to be robust against
> >>     abuse by our own guest, or the other guests sharing the memory.
> >>     Convincing me would take a code audit.
> >>
> >>   - MAINTAINERS doesn't cover ivshmem.c.
> >>
> >>   - The last non-trivial commit that isn't obviously part of some
> >>     tree-wide infrastructure or cleanup work is from September 2012
> >>     (commit c08ba66).
> >>
> >> 2. There is no libvirt support
> >
> > One can use qemu without libvivrt.
>
> You asked me for my reasons for disliking ivshmem.  This is one.
>
> Sure, I can drink my water through a straw while standing on one foot,
> but that doesn't mean I have to like it.  And me not liking it doesn't
> mean the next guy shouldn't like it.  To each their own.
>
> >> 3. Out-of-tree server program required for full functionality
> >>
> >>   Interrupts require a "shared memory server" running in the host (see
> >>   docs/specs/ivshmem_device_spec.txt).  It doesn't tell where to find
> >>   one.  The initial commit 6cbf4c8 points to
> >>   <www.gitorious.org/nahanni>.  That repository's last commit is from
> >>   September 2012.  He's dead, Jim.
> >>
> >>   ivshmem_device_spec.txt is silent on what the server is supposed to
> >>   do.
> >
> > We have the source code, it provides the documentation to write our
> > own better server program.
>
> Good for you.  Not good enough for the QEMU community.
>
> QEMU features requiring on out-of-tree software to be useful are fine,
> as long as said out-of-tree software is readily available to QEMU
> developers and users.
>
> Free software with a community around it and packaged in major distros
> qualifies.  If you haven't got that, talk to us to find out whether what
> you've got qualifies, and if not, what you'd have to do to make it
> qualify.
>
> Back when we accepted ivshmem, the out-of-tree parts it needs were well
> below the "community & packaged" bar.  But folks interested in it talked
> to us, and the fact that it's in shows that QEMU maintainers decided
> what they had then was enough.
>
> Unfortunately, we now have considerably less: Nahanni appears to be
> dead.
>
> An apparently dead git repository you can study is not enough.  The fact
> that you hold an improved reimplementation privately is immaterial.  So
> is the (plausible) claim that others could also create a
> reimplementation.
>
> >>   If this server requires privileges: I don't trust it without an
> >>   audit.
> >>
> >> 4. Out-of-tree kernel uio driver required
> >
> > No, it is optional.
>
> Good to know.  Would you be willing to send a patch to
> ivshmem_device_spec.txt clarifying that?
>
> >>   The device is "intended to be used with the provided UIO driver"
> >>   (ivshmem_device_spec.txt again).  As far as I can tell, the "provided
> >>   UIO driver" is the one in the dead Nahanni repo.
> >>
> >>   By now, you should be expecting this: I don't trust that one either.
> >>
> >> These concerns are all fixable, but it'll take serious work, and time.
> >> Something like:
> >>
> >> * Find a maintainer for the device model
> > I guess, we can find it into the DPDK.org community.
> >> * Review and fix its code
> >>
> >> * Get the required kernel module upstream
> >
> > which module? uio, it is not required.
> >
> >> * Get all the required parts outside QEMU packaged in major distros, or
> >>    absorbed into QEMU
> >
> > Redhat did disable it. why? it is there in QEMU.
>
> Up to now, I've been wearing my QEMU hat.  Let me exchange it for my Red
> one for a bit.
>
> We (Red Hat) don't just package & ship metric tons of random free
> software.  We package & ship useful free software we can support for
> many, many years.
>
> Sometimes, we find that we have to focus serious development resources
> on making something useful supportable (Paolo mentioned qcow2).  We
> obviously can't focus on everything, though.
>
> Anyway, ivshmem didn't make the cut for RHEL-7.0.  Sorry if that
> inconveniences you.  To get it into RHEL, you need to show it's both
> useful and supportable.  Building a community around it would go a long
> way towards that.
>
> If you want to discuss this in more detail with us, you may want to try
> communication channels provided by your RHEL subscription in addition to
> the QEMU development mailing list.  Don't be shy, you're paying for it!
>
> As always, I'm not speaking for myself, not my employer.
>
> Okay, wearing my QEMU hat again.
>
> >> In short, create a viable community around ivshmem, either within the
> >> QEMU community, or separately but cooperating.
> >
> > At least, DPDK.org community is a community using it.
>
> Using something isn't the same as maintaining something.  But it's a
> necessary first step.
>
> [...]
>
>


-- 

Thanks and regards,

Jobin Raju George

Final Year, Information Technology

College of Engineering Pune

Alternate e-mail: georgejr10.it@coep.ac.in

--047d7b2e3d92b30bbb04fbb4501e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Nahanni&#39;s poor current development coupled with virtIO=
&#39;s promising expansion was what encouraged us to explore virtIO-serial =
[1] for inter-virtual machine communication. Though virtIO-serial as it is =
isn&#39;t helpful for inter-VM communication, some work is needed for this =
purpose and this is exactly what we (I and two of my fellow classmates) acc=
omplished.<br>
<br>We haven&#39;t published it yet since we do need to polish yet for upst=
reaming it and are planning do it in near future.<br><br><br>[1]: <a href=
=3D"http://fedoraproject.org/wiki/Features/VirtioSerial">http://fedoraproje=
ct.org/wiki/Features/VirtioSerial</a><br>
</div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Fri,=
 Jun 13, 2014 at 2:16 PM, Markus Armbruster <span dir=3D"ltr">&lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt;</=
span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Some dropped quoted text restored.<br>
<br>
Vincent JARDIN &lt;<a href=3D"mailto:vincent.jardin@6wind.com">vincent.jard=
in@6wind.com</a>&gt; writes:<br>
<br>
&gt; Markus,<br>
&gt;<br>
&gt; see inline (I am not on all mailing list, please, keep the cc list).<b=
r>
&gt;<br>
&gt;&gt; Sure! =C2=A0The reasons for my dislike range from practical to<br>
&gt;&gt; philosophical.<br>
&gt;&gt;<br>
&gt;&gt; My practical concerns include:<br>
&gt;&gt;<br>
&gt;&gt; 1. ivshmem code needs work, but has no maintainer<br>
&gt; See David&#39;s contributions:<br>
&gt; =C2=A0 <a href=3D"http://patchwork.ozlabs.org/patch/358750/" target=3D=
"_blank">http://patchwork.ozlabs.org/patch/358750/</a><br>
<br>
We&#39;re grateful for David&#39;s patch for qemu-char.c, but this isn&#39;=
t ivshmem<br>
maintenance, yet.<br>
<br>
&gt;&gt; =C2=A0 - Error handling is generally poor. =C2=A0For instance, &qu=
ot;device_add<br>
&gt;&gt; =C2=A0 =C2=A0 ivshmem&quot; kills your guest instantly.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 - More subjectively, I don&#39;t trust the code to be robus=
t against<br>
&gt;&gt; =C2=A0 =C2=A0 abuse by our own guest, or the other guests sharing =
the memory.<br>
&gt;&gt; =C2=A0 =C2=A0 Convincing me would take a code audit.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 - MAINTAINERS doesn&#39;t cover ivshmem.c.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 - The last non-trivial commit that isn&#39;t obviously part=
 of some<br>
&gt;&gt; =C2=A0 =C2=A0 tree-wide infrastructure or cleanup work is from Sep=
tember 2012<br>
&gt;&gt; =C2=A0 =C2=A0 (commit c08ba66).<br>
&gt;&gt;<br>
&gt;&gt; 2. There is no libvirt support<br>
&gt;<br>
&gt; One can use qemu without libvivrt.<br>
<br>
You asked me for my reasons for disliking ivshmem. =C2=A0This is one.<br>
<br>
Sure, I can drink my water through a straw while standing on one foot,<br>
but that doesn&#39;t mean I have to like it. =C2=A0And me not liking it doe=
sn&#39;t<br>
mean the next guy shouldn&#39;t like it. =C2=A0To each their own.<br>
<br>
&gt;&gt; 3. Out-of-tree server program required for full functionality<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 Interrupts require a &quot;shared memory server&quot; runni=
ng in the host (see<br>
&gt;&gt; =C2=A0 docs/specs/ivshmem_device_spec.txt). =C2=A0It doesn&#39;t t=
ell where to find<br>
&gt;&gt; =C2=A0 one. =C2=A0The initial commit 6cbf4c8 points to<br>
&gt;&gt; =C2=A0 &lt;<a href=3D"http://www.gitorious.org/nahanni" target=3D"=
_blank">www.gitorious.org/nahanni</a>&gt;. =C2=A0That repository&#39;s last=
 commit is from<br>
&gt;&gt; =C2=A0 September 2012. =C2=A0He&#39;s dead, Jim.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 ivshmem_device_spec.txt is silent on what the server is sup=
posed to<br>
&gt;&gt; =C2=A0 do.<br>
&gt;<br>
&gt; We have the source code, it provides the documentation to write our<br=
>
&gt; own better server program.<br>
<br>
Good for you. =C2=A0Not good enough for the QEMU community.<br>
<br>
QEMU features requiring on out-of-tree software to be useful are fine,<br>
as long as said out-of-tree software is readily available to QEMU<br>
developers and users.<br>
<br>
Free software with a community around it and packaged in major distros<br>
qualifies. =C2=A0If you haven&#39;t got that, talk to us to find out whethe=
r what<br>
you&#39;ve got qualifies, and if not, what you&#39;d have to do to make it<=
br>
qualify.<br>
<br>
Back when we accepted ivshmem, the out-of-tree parts it needs were well<br>
below the &quot;community &amp; packaged&quot; bar. =C2=A0But folks interes=
ted in it talked<br>
to us, and the fact that it&#39;s in shows that QEMU maintainers decided<br=
>
what they had then was enough.<br>
<br>
Unfortunately, we now have considerably less: Nahanni appears to be<br>
dead.<br>
<br>
An apparently dead git repository you can study is not enough. =C2=A0The fa=
ct<br>
that you hold an improved reimplementation privately is immaterial. =C2=A0S=
o<br>
is the (plausible) claim that others could also create a<br>
reimplementation.<br>
<br>
&gt;&gt; =C2=A0 If this server requires privileges: I don&#39;t trust it wi=
thout an<br>
&gt;&gt; =C2=A0 audit.<br>
&gt;&gt;<br>
&gt;&gt; 4. Out-of-tree kernel uio driver required<br>
&gt;<br>
&gt; No, it is optional.<br>
<br>
Good to know. =C2=A0Would you be willing to send a patch to<br>
ivshmem_device_spec.txt clarifying that?<br>
<br>
&gt;&gt; =C2=A0 The device is &quot;intended to be used with the provided U=
IO driver&quot;<br>
&gt;&gt; =C2=A0 (ivshmem_device_spec.txt again). =C2=A0As far as I can tell=
, the &quot;provided<br>
&gt;&gt; =C2=A0 UIO driver&quot; is the one in the dead Nahanni repo.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 By now, you should be expecting this: I don&#39;t trust tha=
t one either.<br>
&gt;&gt;<br>
&gt;&gt; These concerns are all fixable, but it&#39;ll take serious work, a=
nd time.<br>
&gt;&gt; Something like:<br>
&gt;&gt;<br>
&gt;&gt; * Find a maintainer for the device model<br>
&gt; I guess, we can find it into the DPDK.org community.<br>
&gt;&gt; * Review and fix its code<br>
&gt;&gt;<br>
&gt;&gt; * Get the required kernel module upstream<br>
&gt;<br>
&gt; which module? uio, it is not required.<br>
&gt;<br>
&gt;&gt; * Get all the required parts outside QEMU packaged in major distro=
s, or<br>
&gt;&gt; =C2=A0 =C2=A0absorbed into QEMU<br>
&gt;<br>
&gt; Redhat did disable it. why? it is there in QEMU.<br>
<br>
Up to now, I&#39;ve been wearing my QEMU hat. =C2=A0Let me exchange it for =
my Red<br>
one for a bit.<br>
<br>
We (Red Hat) don&#39;t just package &amp; ship metric tons of random free<b=
r>
software. =C2=A0We package &amp; ship useful free software we can support f=
or<br>
many, many years.<br>
<br>
Sometimes, we find that we have to focus serious development resources<br>
on making something useful supportable (Paolo mentioned qcow2). =C2=A0We<br=
>
obviously can&#39;t focus on everything, though.<br>
<br>
Anyway, ivshmem didn&#39;t make the cut for RHEL-7.0. =C2=A0Sorry if that<b=
r>
inconveniences you. =C2=A0To get it into RHEL, you need to show it&#39;s bo=
th<br>
useful and supportable. =C2=A0Building a community around it would go a lon=
g<br>
way towards that.<br>
<br>
If you want to discuss this in more detail with us, you may want to try<br>
communication channels provided by your RHEL subscription in addition to<br=
>
the QEMU development mailing list. =C2=A0Don&#39;t be shy, you&#39;re payin=
g for it!<br>
<br>
As always, I&#39;m not speaking for myself, not my employer.<br>
<br>
Okay, wearing my QEMU hat again.<br>
<br>
&gt;&gt; In short, create a viable community around ivshmem, either within =
the<br>
&gt;&gt; QEMU community, or separately but cooperating.<br>
&gt;<br>
&gt; At least, DPDK.org community is a community using it.<br>
<br>
Using something isn&#39;t the same as maintaining something. =C2=A0But it&#=
39;s a<br>
necessary first step.<br>
<br>
[...]<br>
<br>
</blockquote></div><br><br clear=3D"all"><br>-- <br><div dir=3D"ltr"><div s=
tyle=3D"text-align:left"><p style=3D"margin-bottom:0.0001pt"></p><p style=
=3D"margin-bottom:0.0001pt"></p><p style=3D"margin-bottom:0.0001pt"></p><p =
style=3D"margin-bottom:0.0001pt">
</p><p style=3D"margin-bottom:0.0001pt"></p><p style=3D"margin-bottom:0in;m=
argin-bottom:.0001pt"><span style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;;color:#ff0066">Thanks and regards,</span><span style=3D"font=
-family:Arial,sans-serif"></span></p>


<p style=3D"margin-top:0in;margin-right:0in;margin-left:0in;margin-bottom:0=
.0001pt"><span style=3D"font-family:&quot;Arial&quot;,&quot;sans-serif&quot=
;;color:#548dd4">Jobin Raju George</span><span style=3D"font-family:Arial,s=
ans-serif"></span></p>


<p style=3D"margin-top:0in;margin-right:0in;margin-left:0in;margin-bottom:0=
.0001pt"><span style=3D"font-family:&quot;Arial&quot;,&quot;sans-serif&quot=
;;color:#548dd4">Final Year, Information Technology</span><span style=3D"fo=
nt-family:Arial,sans-serif"></span></p>


<p style=3D"margin-top:0in;margin-right:0in;margin-left:0in;margin-bottom:0=
.0001pt"><span style=3D"font-family:&quot;Arial&quot;,&quot;sans-serif&quot=
;;color:#548dd4">College of Engineering Pune</span><span style=3D"font-fami=
ly:Arial,sans-serif"></span></p>


<p style=3D"margin-top:0in;margin-right:0in;margin-left:0in;margin-bottom:0=
.0001pt"><span style=3D"font-family:&quot;Arial&quot;,&quot;sans-serif&quot=
;;color:#548dd4">Alternate e-mail:<span>=C2=A0</span></span><span style=3D"=
font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#00b050"><a href=
=3D"mailto:georgejr10.it@coep.ac.in" target=3D"_blank">georgejr10.it@coep.a=
c.in</a></span><span style=3D"font-family:Arial,sans-serif"></span></p>
<p></p><p></p><p></p><p></p><p></p></div></div>
</div>

--047d7b2e3d92b30bbb04fbb4501e--

--===============4802827763824372832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4802827763824372832==--
