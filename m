From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: virtio remoteproc device
Date: Fri, 20 Apr 2018 19:53:55 +0300
Message-ID: <20180420194321-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-remoteproc@vger.kernel.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, virtualization@lists.linux-foundation.org, Bjorn Andersson <bjorn.andersson@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

Hello!
I note the following in the serial console:

      if (is_rproc_serial(vdev)) {
                /*
                 * Allocate DMA memory from ancestor. When a virtio
                 * device is created by remoteproc, the DMA memory is
                 * associated with the grandparent device:
                 * vdev =3D> rproc =3D> platform-dev.
                 */
                if (!vdev->dev.parent || !vdev->dev.parent->parent)
                        goto free_buf;
                buf->dev =3D vdev->dev.parent->parent;

                /* Increase device refcnt to avoid freeing it */
                get_device(buf->dev);
                buf->buf =3D dma_alloc_coherent(buf->dev, buf_size, &buf->d=
ma,
                                              GFP_KERNEL);
        }

Added here:
	commit 1b6370463e88b0c1c317de16d7b962acc1dab4f2
	Author: Sjur Br=E6ndeland <sjur.brandeland@stericsson.com>
	Date:   Fri Dec 14 14:40:51 2012 +1030

    virtio_console: Add support for remoteproc serial


I am not familiar with rproc so I have a question:
why is it required to use coherent memory here,
and why through a grandparent device?

Would it work to instead change vring_use_dma_api
to whitelist rproc (like we do for xen)?

I can sent a patch for your testing.
Thanks!

-- =

MST
