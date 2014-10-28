From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: [PATCH] virtio_ccw: remove unsued variable
Date: Tue, 28 Oct 2014 16:39:12 +0100 (CET)
Message-ID: <alpine.LFD.2.11.1410281634560.1567@denkbrett>
References: <alpine.LFD.2.11.1410201242390.1601@denkbrett>
	<20141020141931.GB11062@redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1744176940-282550839-1414510753=:1567"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141020141931.GB11062@redhat.com>
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1744176940-282550839-1414510753=:1567
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Oct 2014, Michael S. Tsirkin wrote:
> On Mon, Oct 20, 2014 at 12:48:18PM +0200, Sebastian Ott wrote:
> > Hi,
> >=20
> > 016c98c6f virtio: unify config_changed handling
> >=20
> > introduced a warning in virtio_ccw which is fixed by the following pa=
tch.
> >=20
> > Regards,
> > Sebastian
> > ---
> > virtio_ccw: remove unsued variable
>=20
> s/unsued/unused/
>=20

Totally forgot to send an updated version..sry. Here it is.

Regards,
Sebastian

---
virtio_ccw: remove unused variable

Fix this warning:
drivers/s390/kvm/virtio_ccw.c: In function =E2=80=98virtio_ccw_int_handle=
r=E2=80=99:
drivers/s390/kvm/virtio_ccw.c:891:24: warning: unused variable =E2=80=98d=
rv=E2=80=99 [-Wunused-variable]
    struct virtio_driver *drv;

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 drivers/s390/kvm/virtio_ccw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.=
c
index 6cbe6ef..bda52f1 100644
--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -888,7 +888,6 @@ static void virtio_ccw_int_handler(struct ccw_device =
*cdev,
 	struct virtio_ccw_device *vcdev =3D dev_get_drvdata(&cdev->dev);
 	int i;
 	struct virtqueue *vq;
-	struct virtio_driver *drv;
=20
 	if (!vcdev)
 		return;
--=20
1.8.4.2

---1744176940-282550839-1414510753=:1567
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
---1744176940-282550839-1414510753=:1567--
