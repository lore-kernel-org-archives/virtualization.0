From: nitesh narayan lal <niteshnarayanlalleo@gmail.com>
Subject: virtio Performance Analysis
Date: Tue, 30 Apr 2013 17:06:19 +0530
Message-ID: <CAAtA1-YwOgw6My-JgNU8UVun9tiCSDZjhr-GeviTE3oQYapeUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3319022061329921834=="
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
List-Id: virtualization@lists.linuxfoundation.org

--===============3319022061329921834==
Content-Type: multipart/alternative; boundary=001a11c33e64fd0f4304db9268f8

--001a11c33e64fd0f4304db9268f8
Content-Type: text/plain; charset=ISO-8859-1

Hi,
I am currently working on the virtio performance analysis in PowerPC .
I was looking at the virtio front-end code and had done tracing by adding
WARN_ON condition in skb_recv_done(),xmit_skb_done() and virtqueue_kick().
What I had seen is virtqueue_kick() internally it calls iowrite16() which
will cause an exit to QEMU, now either I send a packets from Guest or
receive a packets to guest sart_xmit() will be called and inside start_xmit
there is a call to virtqueue_kick() causing Guest exit. Also for every
packet or ack sent from Guest there is an exception received while sending
or receiving the next packet/ack.
Due to all of the above factors mentioned their will be an increase in
signal, EXTINT and guest exits  and hence it will effect the CPU
performance.
This is what my analysis is so far, it would be great if I could get some
help on this such that whether it seems appropriate or not ?

Regards
Nitesh Narayan Lal

--001a11c33e64fd0f4304db9268f8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br>I am currently working on the virtio performan=
ce analysis in PowerPC .<br>I was looking at the virtio front-end code and =
had done tracing by adding WARN_ON condition in skb_recv_done(),xmit_skb_do=
ne() and virtqueue_kick().<br>

What I had seen is virtqueue_kick() internally it calls iowrite16() which w=
ill cause an exit to QEMU, now either I send a packets from Guest or receiv=
e a packets to guest sart_xmit() will be called and inside start_xmit there=
 is a call to virtqueue_kick() causing Guest exit. Also for every packet or=
 ack sent from Guest there is an exception received while sending or receiv=
ing the next packet/ack.<br>

Due to all of the above factors mentioned their will be an increase in sign=
al, EXTINT and guest exits=A0 and hence it will effect the CPU performance.=
<br>This is what my analysis is so far, it would be great if I could get so=
me help on this such that whether it seems appropriate or not ?<br>

<br clear=3D"all"><div><div><div dir=3D"ltr"><div>Regards<br></div>Nitesh N=
arayan Lal<br></div></div>
</div></div></div>

--001a11c33e64fd0f4304db9268f8--

--===============3319022061329921834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3319022061329921834==--
