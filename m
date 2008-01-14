From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] fix bug in virtio-rng
Date: Mon, 14 Jan 2008 18:31:35 +0100
Message-ID: <200801141831.35481.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty,

I have seen an oops triggered by the following bug statement in=20
virtio-rng:

if (vq->vq_ops->add_buf(vq, &sg, 0, 1, &random_data) !=3D 0)
	BUG();

The problem is that we never called get_buf for complete buffers.

The fix is simple: We have to free the buffer on interrupt to=20
avoid a virtqueue "overflow".

Christian

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>


---
 drivers/char/hw_random/virtio-rng.c |    3 +++
 1 file changed, 3 insertions(+)

Index: kvm/drivers/char/hw_random/virtio-rng.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- kvm.orig/drivers/char/hw_random/virtio-rng.c
+++ kvm/drivers/char/hw_random/virtio-rng.c
@@ -29,6 +29,9 @@ static bool have_data;
=20
 static void random_recv_done(struct virtqueue *vq)
 {
+	int len =3D 0;
+	vq->vq_ops->get_buf(vq, &len);
+	BUG_ON(!len);
 	have_data =3D true;
=20
 	/* No need to call disable_cb: there can't be any more since we
--=20
IBM Deutschland Entwicklung GmbH
Vorsitzender des Aufsichtsrats: Martin Jetter
Gesch=E4ftsf=FChrung: Herbert Kircher=20
Sitz der Gesellschaft: B=F6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
