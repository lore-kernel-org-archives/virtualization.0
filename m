From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Subject: Potential hang in virtnet_send_command
Date: Mon, 18 Apr 2016 19:07:32 +0200
Message-ID: <CAATJJ0JF7-ApjMO+XtsVgD8rU6WTCK28vTjmG-Aww-ASHw4cBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4654977085945591438=="
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
To: virtualization@lists.linux-foundation.org
Cc: Thomas Monjalon <thomas.monjalon@6wind.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

--===============4654977085945591438==
Content-Type: multipart/alternative; boundary=001a1139b43a9a7e090530c5667e

--001a1139b43a9a7e090530c5667e
Content-Type: text/plain; charset=UTF-8

Hi,
I was debugging an issue caused by a bad usage of dpdk.
That is fixed in the meantime and I'll backport that into our code as well.

But along debugging that, I found a potential hang in virtnet_send_command
that my case ran into.
The following code can become an infinite loop:
/* Spin for a response, the kick causes an ioport write, trapping
 * into the hypervisor, so the request should be handled immediately.
 */
while (!virtqueue_get_buf(vi->cvq, &tmp) &&
       !virtqueue_is_broken(vi->cvq))
        cpu_relax();

In my case dpdk broke something - not exactly clear what - and due to that
following calls through virtnet_send_command ran into this hang.
Effectively it seems that the buffers didn't get refreshed at all anymore.

That said the dpdk issue to touch devices that belong to a kernel owned
driver is fixed, so one could leave the code as is for now.
Yet I wanted to make you aware in case you would vote for a time or retry
based upper limit on that loop to avoid hangs - who knows what else might
bring it in this broken state in a different case.

Kind Regards,
Christian Ehrhardt

P.S.
Steps to reproduce, backtraces and more data can be found in:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1570195
A general setup howto for DPDK in KVM guests which is a prereq is at:
https://help.ubuntu.com/16.04/serverguide/DPDK.html#dpdk-in-guest

--001a1139b43a9a7e090530c5667e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div>I was debugging an issue caused by a ba=
d usage of dpdk.</div><div>That is fixed in the meantime and I&#39;ll backp=
ort that into our code as well.</div><div><br></div>But along debugging tha=
t, I found a potential hang in virtnet_send_command that my case ran into.<=
br>The following code can become an infinite loop:<br><font face=3D"monospa=
ce, monospace">/* Spin for a response, the kick causes an ioport write, tra=
pping<br>=C2=A0* into the hypervisor, so the request should be handled imme=
diately.<br>=C2=A0*/ =C2=A0=C2=A0<br>while (!virtqueue_get_buf(vi-&gt;cvq, =
&amp;tmp) &amp;&amp; =C2=A0=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0!virtqueue_=
is_broken(vi-&gt;cvq)) =C2=A0=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_rela=
x();</font><div><br></div><div>In my case dpdk broke something - not exactl=
y clear what - and due to that following calls through=C2=A0virtnet_send_co=
mmand ran into this hang.</div><div>Effectively it seems that the buffers d=
idn&#39;t get refreshed at all anymore.</div><div><br></div><div>That said =
the dpdk issue to touch devices that belong to a kernel owned driver is fix=
ed, so one could leave the code as is for now.</div><div>Yet I wanted to ma=
ke you aware in case you would vote for a time or retry based upper limit o=
n that loop to avoid hangs - who knows what else might bring it in this bro=
ken state in a different case.</div><div><br></div><div>Kind Regards,</div>=
Christian Ehrhardt<br><br>P.S.<div>Steps to reproduce, backtraces and more =
data can be found in:<div><a href=3D"https://bugs.launchpad.net/ubuntu/+sou=
rce/linux/+bug/1570195">https://bugs.launchpad.net/ubuntu/+source/linux/+bu=
g/1570195</a></div><div>A general setup howto for DPDK in KVM guests which =
is a prereq is at:</div><div><a href=3D"https://help.ubuntu.com/16.04/serve=
rguide/DPDK.html#dpdk-in-guest">https://help.ubuntu.com/16.04/serverguide/D=
PDK.html#dpdk-in-guest</a><br><div><br></div></div></div></div>

--001a1139b43a9a7e090530c5667e--

--===============4654977085945591438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4654977085945591438==--
