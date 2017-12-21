From: Jason Behmer via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: Question about eliminating virtio-scsi 30s timeout and hot-unplug
Date: Thu, 21 Dec 2017 11:29:11 -0800
Message-ID: <CAMmhGq+9qZhJRdaeXZtdu6AyJUPBKkbL4F2=NeXhvjUbxEoyow@mail.gmail.com>
Reply-To: Jason Behmer <jbehmer@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3363946370227559046=="
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
To: pbonzini@redhat.com
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

--===============3363946370227559046==
Content-Type: multipart/alternative; boundary="001a113ed256f99c460560deb61b"

--001a113ed256f99c460560deb61b
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,
I had a question about this patch that eliminates virtio-scsi timeout on
IOs - https://patchwork.kernel.org/patch/9802047/.  How does this work when
we have IOs outstanding to a device that is then hot-unplugged.  I'm under
the impression that those IOs will never get returned with any status
(please correct me if I'm wrong), and we will then end up waiting on them
forever with this patch.

Thanks,
Jason

--001a113ed256f99c460560deb61b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Paolo,<div>I had a question about this patch that elimi=
nates virtio-scsi timeout on IOs - <a href=3D"https://patchwork.kernel.org/=
patch/9802047/">https://patchwork.kernel.org/patch/9802047/</a>.=C2=A0 How =
does this work when we have IOs outstanding to a device that is then hot-un=
plugged.=C2=A0 I&#39;m under the impression that those IOs will never get r=
eturned with any status (please correct me if I&#39;m wrong), and we will t=
hen end up waiting on them forever with this patch.<br></div><div><br></div=
><div>Thanks,</div><div>Jason</div></div>

--001a113ed256f99c460560deb61b--

--===============3363946370227559046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3363946370227559046==--
