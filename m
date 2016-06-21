From: Frank Steinborn <steinex@nognu.de>
Subject: Heavy clock drifts inside of KVM guests (qemu-kvm 2.1.2)
Date: Tue, 21 Jun 2016 11:50:32 +0200
Message-ID: <CANhLx2OteUHmoHMzfOeZw95t7AazEDk1a6VTXyZD0=i+PFGvMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6485938086763592352=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, qemu-discuss@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

--===============6485938086763592352==
Content-Type: multipart/alternative; boundary=001a11410ece87c7fb0535c6c021

--001a11410ece87c7fb0535c6c021
Content-Type: text/plain; charset=UTF-8

Dear list(s),

we are running a cluster of virtual machines on ganeti 2.15.2 on top of
qemu-kvm 2.1.2. Hosts are Debian jessie (Kernel 3.16). We have big trouble
with timekeeping on guests, no matter if these guests are lenny, squeeze,
wheezy or jessie. Clock drifts heavily on some, others are fine. There is
no obvious pattern on which guest this happens and on which not, but it
seems the clock drifts heavier on guests that are idle and have nothing to
do. Some more facts:

* Clocksource on all hosts are set to tsc
* Clocksource on all guests are set to kvm-clock
* CPUs on the hosts are Intel Xeons, all have these related flags: tsc,
constant_tsc, nonstop_tsc. One host has tsc_deadline_timer as an extra,
because it's a newer Xeon, but it doesn't seem to make a difference in
drifting.
* Most guests complain about "Clocksource tsc unstable" in dmesg after boot
(even when set to clocksource=kvm-clock)
* The hosts don't drift at all, we only see the issue in guests
* We don't use CPU pinning for KVM guests
* We run OpenNTPD 5.7p4 on both the hosts and the guests (we build this for
ourselves, so the version is the same in every guest across every Debian
version)

We tried different things to debug the cause of this issue but we're out if
ideas now. This is what we have tested so far:

* Newer kernel from jessie-backports
* Newer qemu-kvm from jessie-backports
* Set clocksource=hpet on the hosts, this made drifts even worse (not
tested yet: acpi_pm)
* Tried to run guests without kvm_steal_time setting
* Tried without running OpenNTPD on the guests

We have some hints along our investigations. Novell for example says that
CPU pinning may help on drifting guests:
https://www.novell.com/support/kb/doc.php?id=7008698

Others suggested using an "failover clocksource" on the guests:
https://blog.laimbock.com/tag/clocksource_failover/

However, before we just continue to poke around in the dark, we wanted to
hear input from virtualization experts that may have stumbled across
something like this before. Any input would be greatly appreciated!

Please reply directly, as I'm not subscribed to the list. And sorry for
cross-posting this to several lists at once, we just hope to get as much
feedback as possible.

Thanks in advance,
Frank

--001a11410ece87c7fb0535c6c021
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear list(s),<br><br>we are running a cluster of virtual m=
achines on ganeti 2.15.2 on top of qemu-kvm 2.1.2. Hosts are Debian jessie =
(Kernel 3.16). We have big trouble with timekeeping on guests, no matter if=
 these guests are lenny, squeeze, wheezy or jessie. Clock drifts heavily on=
 some, others are fine. There is no obvious pattern on which guest this hap=
pens and on which not, but it seems the clock drifts heavier on guests that=
 are idle and have nothing to do. Some more facts:<br><br>* Clocksource on =
all hosts are set to tsc<br>* Clocksource on all guests are set to kvm-cloc=
k<br>* CPUs on the hosts are Intel Xeons, all have these related flags: tsc=
, constant_tsc, nonstop_tsc. One host has tsc_deadline_timer as an extra, b=
ecause it&#39;s a newer Xeon, but it doesn&#39;t seem to make a difference =
in drifting.<br>* Most guests complain about &quot;Clocksource tsc unstable=
&quot; in dmesg after boot (even when set to clocksource=3Dkvm-clock)<br>* =
The hosts don&#39;t drift at all, we only see the issue in guests<br>* We d=
on&#39;t use CPU pinning for KVM guests<br>* We run OpenNTPD 5.7p4 on both =
the hosts and the guests (we build this for ourselves, so the version is th=
e same in every guest across every Debian version)<br><br>We tried differen=
t things to debug the cause of this issue but we&#39;re out if ideas now. T=
his is what we have tested so far:<br><br>* Newer kernel from jessie-backpo=
rts<br>* Newer qemu-kvm from jessie-backports<br>* Set clocksource=3Dhpet o=
n the hosts, this made drifts even worse (not tested yet: acpi_pm)<br>* Tri=
ed to run guests without kvm_steal_time setting<br>* Tried without running =
OpenNTPD on the guests<br><br>We have some hints along our investigations. =
Novell for example says that CPU pinning may help on drifting guests:<br><a=
 href=3D"https://www.novell.com/support/kb/doc.php?id=3D7008698">https://ww=
w.novell.com/support/kb/doc.php?id=3D7008698</a><br><br>Others suggested us=
ing an &quot;failover clocksource&quot; on the guests:<br><a href=3D"https:=
//blog.laimbock.com/tag/clocksource_failover/">https://blog.laimbock.com/ta=
g/clocksource_failover/</a><br><br>However, before we just continue to poke=
 around in the dark, we wanted to hear input from virtualization experts th=
at may have stumbled across something like this before. Any input would be =
greatly appreciated!<br><br>Please reply directly, as I&#39;m not subscribe=
d to the list. And sorry for cross-posting this to several lists at once, w=
e just hope to get as much feedback as possible.<br><br>Thanks in advance,<=
br>Frank<br></div>

--001a11410ece87c7fb0535c6c021--

--===============6485938086763592352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6485938086763592352==--
