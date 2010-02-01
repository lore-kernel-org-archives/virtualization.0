From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 21/31] virtio: console: Prepare for writing to
	userspace buffers
Date: Mon, 1 Feb 2010 10:38:35 +0530
Message-ID: <20100201050835.GB30125@amit-x200.redhat.com>
References: <1264772563-25517-1-git-send-email-amit.shah@redhat.com>
	<1264772563-25517-3-git-send-email-amit.shah@redhat.com>
	<1264772563-25517-4-git-send-email-amit.shah@redhat.com>
	<201002011049.52053.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201002011049.52053.rusty@rustcorp.com.au>
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

On (Mon) Feb 01 2010 [10:49:51], Rusty Russell wrote:
> On Sat, 30 Jan 2010 12:12:40 am Amit Shah wrote:
> > When ports get advertised as char devices, the buffers will come from
> > userspace. Equip the fill_readbuf function with the ability to write
> > to userspace buffers.
> > 
> > Signed-off-by: Amit Shah <amit.shah@redhat.com>
> > ---
> >  drivers/char/virtio_console.c |   20 ++++++++++++++------
> >  1 files changed, 14 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> > index 9d33239..5f61021 100644
> > --- a/drivers/char/virtio_console.c
> > +++ b/drivers/char/virtio_console.c
> > @@ -365,7 +365,8 @@ fail:
> >   * Give out the data that's requested from the buffer that we have
> >   * queued up.
> >   */
> > -static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count)
> > +static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count,
> > +			    bool to_user)
> 
> This patch does not apply: your previous 19/31 "Introduce a send_buf function
> for a common path for sending data to host" made this "void *out_buf".  The
> rest I can't even sort out.

Sorry for that, Rusty.

I've sent you a tarball privately.

The tarball contains an additional patch (contained in the series
itself), that drops the use of outbuf for sending control messages
as well:

(The 'outbuf' was used earlier when we had multiple buffers that could
be queued up for the host to consume. We now only queue up one buffer at
a time and wait for the host to ack the buffer before we move along.
When we revisit the design to allow multiple out-buffers, we can go this
path again.)


 drivers/char/virtio_console.c |   21 ++++-----------------
 1 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 2c2de35..793285d 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -134,9 +134,6 @@ struct ports_device {
 	/* Array of per-port IO virtqueues */
 	struct virtqueue **in_vqs, **out_vqs;
 
-	/* The control messages to the Host are sent via this buffer */
-	struct port_buffer *outbuf;
-
 	/* Used for numbering devices for sysfs and debugfs */
 	unsigned int drv_index;
 
@@ -372,8 +369,7 @@ static ssize_t send_control_msg(struct port *port, unsigned int event,
 	struct scatterlist sg[1];
 	struct virtio_console_control cpkt;
 	struct virtqueue *vq;
-	struct port_buffer *outbuf;
-	int tmplen;
+	int len;
 
 	if (!use_multiport(port->portdev))
 		return 0;
@@ -383,14 +379,11 @@ static ssize_t send_control_msg(struct port *port, unsigned int event,
 	cpkt.value = value;
 
 	vq = port->portdev->c_ovq;
-	outbuf = port->portdev->outbuf;
-
-	memcpy(outbuf->buf, (void *)&cpkt, sizeof(cpkt));
 
-	sg_init_one(sg, outbuf->buf, sizeof(cpkt));
-	if (vq->vq_ops->add_buf(vq, sg, 1, 0, outbuf) >= 0) {
+	sg_init_one(sg, &cpkt, sizeof(cpkt));
+	if (vq->vq_ops->add_buf(vq, sg, 1, 0, &cpkt) >= 0) {
 		vq->vq_ops->kick(vq);
-		while (!vq->vq_ops->get_buf(vq, &tmplen))
+		while (!vq->vq_ops->get_buf(vq, &len))
 			cpu_relax();
 	}
 	return 0;
@@ -1432,12 +1425,6 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 		INIT_WORK(&portdev->control_work, &control_work_handler);
 		INIT_WORK(&portdev->config_work, &config_work_handler);
 
-		portdev->outbuf = alloc_buf(PAGE_SIZE);
-		if (!portdev->outbuf) {
-			err = -ENOMEM;
-			dev_err(&vdev->dev, "OOM for control outbuf\n");
-			goto free_vqs;
-		}
 		fill_queue(portdev->c_ivq, &portdev->cvq_lock);
 	}
 
		Amit
