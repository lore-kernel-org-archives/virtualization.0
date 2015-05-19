From: Sudheer K <sudheer.kurichiyath@gmail.com>
Subject: Trying to make VHOST-BLK to work
Date: Tue, 19 May 2015 16:43:34 +0530
Message-ID: <CADM6D_oUqgwvngrY-mNm_HQrfY_qoz-zJY5RMzGaKnCRYB4J7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4179799642984422706=="
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
To: virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

--===============4179799642984422706==
Content-Type: multipart/alternative; boundary=f46d041827f2c4262e05166d66c2

--f46d041827f2c4262e05166d66c2
Content-Type: text/plain; charset=UTF-8

Hi Kernel KVM folks and Michael,

I am trying to make VHOST-BLK to work by myself since I did not hear from
Asias on my personal mail to him. I will be grateful to you for your time
and response.

The problem I am seeing is there is no response seen by the VM through the
HOST has executed the IO successfully and issued
vhost_add_used_and_signal.  Here is my question. Which code in QEMU issues
virtio_notify() when the VHOST completes the IO in kernel?

I have some related questions. Could I connect a iscsi LUN to a VM via
vhost-scsi? Could you please point me to some documents if there are any?

Thanks and Regards

Sudheer

--f46d041827f2c4262e05166d66c2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Kernel KVM folks and Michael,<br><br>I am trying t=
o make VHOST-BLK to work by myself since I did not hear from Asias on=20
my personal mail to him. I will be grateful to you for your time and=20
response.<br><br>The problem I am seeing is there is no response=20
seen by the VM through the HOST has executed the IO successfully and=20
issued vhost_add_used_and_signal.=C2=A0 Here is my question. Which code in =
QEMU issues virtio_notify() when the VHOST completes the IO in kernel?<br><=
br>I
 have some related questions. Could I connect a iscsi LUN to a VM via=20
vhost-scsi? Could you please point me to some documents if there are=20
any?<br><br>Thanks and Regards<br><br></div>Sudheer<br></div>

--f46d041827f2c4262e05166d66c2--

--===============4179799642984422706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4179799642984422706==--
