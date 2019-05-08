From: Pankaj Gupta <pagupta@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 2/6] virtio-pmem: Add virtio pmem driver
Date: Wed, 8 May 2019 11:23:32 -0400 (EDT)
Message-ID: <1482604497.27348783.1557329012320.JavaMail.zimbra__36728.6894282856$1557329031$gmane$org@redhat.com>
References: <20190426050039.17460-1-pagupta@redhat.com>
	<20190426050039.17460-3-pagupta@redhat.com>
	<3d6479ae-6c39-d614-f1d9-aa1978e2e438@google.com>
	<1555943483.27247564.1557313967518.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1555943483.27247564.1557313967518.JavaMail.zimbra@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jakub =?utf-8?Q?Staro=C5=84?= <jstaron@google.com>
Cc: cohuck@redhat.com, jack@suse.cz, kvm@vger.kernel.org, mst@redhat.com, david@fromorbit.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, adilger kernel <adilger.kernel@dilger.ca>, smbarber@google.com, zwisler@kernel.org, aarcange@redhat.com, dave jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org, vishal l verma <vishal.l.verma@intel.com>, willy@infradead.org, hch@infradead.org, linux-acpi@vger.kernel.org, jmoyer@redhat.com, linux-ext4@vger.kernel.org, lenb@kernel.org, kilobyte@angband.pl, riel@surriel.com, yuval shaia <yuval.shaia@oracle.com>, stefanha@redhat.com, imammedo@redhat.com, dan j williams <dan.j.williams@intel.com>, lcapitulino@redhat.com, nilal@redhat.com, tytso@mit.edu, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, darrick wong <darrick.wong@oracle.com>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.o
List-Id: virtualization@lists.linuxfoundation.org


> > 
> > > +int virtio_pmem_flush(struct nd_region *nd_region)
> > > +{
> > > +        int err;
> > > +        unsigned long flags;
> > > +        struct scatterlist *sgs[2], sg, ret;
> > > +        struct virtio_device *vdev = nd_region->provider_data;
> > > +        struct virtio_pmem *vpmem = vdev->priv;
> > > +        struct virtio_pmem_request *req;
> > > +
> > > +        might_sleep();
> > > +        req = kmalloc(sizeof(*req), GFP_KERNEL);
> > > +        if (!req)
> > > +                return -ENOMEM;
> > > +
> > > +        req->done = req->wq_buf_avail = false;
> > > +        strcpy(req->name, "FLUSH");
> > > +        init_waitqueue_head(&req->host_acked);
> > > +        init_waitqueue_head(&req->wq_buf);
> > > +        sg_init_one(&sg, req->name, strlen(req->name));
> > > +        sgs[0] = &sg;
> > > +        sg_init_one(&ret, &req->ret, sizeof(req->ret));
> > > +        sgs[1] = &ret;
> > > +
> > > +        spin_lock_irqsave(&vpmem->pmem_lock, flags);
> > > +        err = virtqueue_add_sgs(vpmem->req_vq, sgs, 1, 1, req, GFP_ATOMIC);
> > > +        if (err) {
> > > +                dev_err(&vdev->dev, "failed to send command to virtio pmem device\n");
> > > +
> > > +                list_add_tail(&vpmem->req_list, &req->list);
> > > +                spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> > > +
> > > +                /* When host has read buffer, this completes via host_ack */
> > > +                wait_event(req->wq_buf, req->wq_buf_avail);
> > > +                spin_lock_irqsave(&vpmem->pmem_lock, flags);
> > > +        }
> > 
> > Aren't the arguments in `list_add_tail` swapped? The element we are adding
> 

Yes, arguments for 'list_add_tail' should be swapped.

list_add_tail(&req->list, &vpmem->req_list);


Thank you,
Pankaj
