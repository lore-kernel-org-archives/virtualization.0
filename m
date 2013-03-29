From: Eviatar Khen <eviatarkhen@gmail.com>
Subject: Virtio Replication
Date: Fri, 29 Mar 2013 14:30:27 +0300
Message-ID: <CAGKFB7+209QMS+kPtao5Am8zCDEJ8CHBdtTWicuZVmAGZ30M9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0884531959110568766=="
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

--===============0884531959110568766==
Content-Type: multipart/alternative; boundary=20cf307c9bba0d758c04d90e99c5

--20cf307c9bba0d758c04d90e99c5
Content-Type: text/plain; charset=ISO-8859-1

Hello All,
I'm currently implementing replication on an Lguest guest machine. As a
guest is a single process (the Launcher), so forking the process is doing
most of the job. Nevertheless, the Launcher uses listeners to virtio
events, a thread for each virtqueue.
I wonder if virtio has a dedicated API for replicating a virtqueue state?

Thank you and best regards,

Eviatar

--20cf307c9bba0d758c04d90e99c5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello All,<div>I&#39;m currently implementing replication =
on an Lguest guest machine. As a guest is a single process (the Launcher), =
so forking the process is doing most of the job. Nevertheless, the Launcher=
 uses listeners to virtio events, a thread for each virtqueue.</div>
<div>I wonder if virtio has a dedicated API for replicating a virtqueue sta=
te?</div><div><br></div><div>Thank you and best regards,</div><div><br></di=
v><div>Eviatar=A0</div></div>

--20cf307c9bba0d758c04d90e99c5--

--===============0884531959110568766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0884531959110568766==--
