From: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH v2 1/2] virtio-balloon: tweak config_changed implementation
Date: Sat, 5 Jan 2019 03:32:44 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73DEF57A3__28426.4121357866$1546659050$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <1546585913-34804-1-git-send-email-wei.w.wang@intel.com>
	<1546585913-34804-2-git-send-email-wei.w.wang@intel.com>
	<20190104103213-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190104103213-mutt-send-email-mst@kernel.org>
Content-Language: en-US
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
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Friday, January 4, 2019 11:45 PM, Michael S. Tsirkin wrote:
> >  struct virtio_balloon {
> >  	struct virtio_device *vdev;
> >  	struct virtqueue *inflate_vq, *deflate_vq, *stats_vq, *free_page_vq;
> > @@ -77,6 +81,8 @@ struct virtio_balloon {
> >  	/* Prevent updating balloon when it is being canceled. */
> >  	spinlock_t stop_update_lock;
> >  	bool stop_update;
> > +	/* Bitmap to indicate if reading the related config fields are needed
> */
> > +	unsigned long config_read_bitmap;
> >
> >  	/* The list of allocated free pages, waiting to be given back to mm */
> >  	struct list_head free_page_list;
> 
> It seems that you never initialize this bitmap. Probably harmless here but
> generally using uninitialized memory isn't good.

We've used kzalloc to allocate the vb struct, so it's already 0-initialized :)

> > +
> >  static int send_free_pages(struct virtio_balloon *vb)  {
> >  	int err;
> > @@ -620,6 +630,7 @@ static int send_free_pages(struct virtio_balloon *vb)
> >  		 * stop the reporting.
> >  		 */
> >  		cmd_id_active = virtio32_to_cpu(vb->vdev, vb-
> >cmd_id_active);
> > +		virtio_balloon_read_cmd_id_received(vb);
 

[1]


> >  		if (cmd_id_active != vb->cmd_id_received)
> >  			break;
> >
> > @@ -637,11 +648,9 @@ static int send_free_pages(struct virtio_balloon
> *vb)
> >  	return 0;
> >  }
> >
> > -static void report_free_page_func(struct work_struct *work)
> > +static void virtio_balloon_report_free_page(struct virtio_balloon
> > +*vb)
> >  {
> >  	int err;
> > -	struct virtio_balloon *vb = container_of(work, struct virtio_balloon,
> > -						 report_free_page_work);
> >  	struct device *dev = &vb->vdev->dev;
> >
> >  	/* Start by sending the received cmd id to host with an outbuf. */
> > @@ -659,6 +668,22 @@ static void report_free_page_func(struct
> work_struct *work)
> >  		dev_err(dev, "Failed to send a stop id, err = %d\n", err);  }
> >
> > +static void report_free_page_func(struct work_struct *work) {
> > +	struct virtio_balloon *vb = container_of(work, struct virtio_balloon,
> > +						 report_free_page_work);
> > +
> > +	virtio_balloon_read_cmd_id_received(vb);
> 
> This will not achieve what you are trying to do, which is cancel reporting if it's
> in progress.
> 
> You need to re-read each time you compare to cmd_id_active.

Yes, already did, please see [1] above


> An API similar to
> 	u32 virtio_balloon_cmd_id_received(vb)
> seems to be called for, and I would rename cmd_id_received to
> cmd_id_received_cache to make sure we caught all users.
> 

I'm not sure about adding "cache" here, cmd_id_received refers to the cmd id
that the driver just received from the device. There is one called "cmd_id_active" which
is the one that the driver is actively using. 
So cmd_id_received is already a "cache" to " cmd_id_active " in some sense.

Best,
Wei
