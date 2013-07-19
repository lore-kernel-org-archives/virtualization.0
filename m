From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 03/10] virtio: console: clean up port data immediately at
	time of unplug
Date: Fri, 19 Jul 2013 10:32:52 +0530
Message-ID: <20130719050252.GA3087@amit-x200.redhat.com>
References: <cover.1374177234.git.amit.shah@redhat.com>
	<fe68b08508c638c6edc4ca2883249a29fdc8fbec.1374177234.git.amit.shah@redhat.com>
	<51E8B0CB.1060703@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <51E8B0CB.1060703@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: stable@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Fri) 19 Jul 2013 [11:21:47], Jason Wang wrote:
> On 07/19/2013 04:16 AM, Amit Shah wrote:


> > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> > index b04ec95..6bf0df3 100644
> > --- a/drivers/char/virtio_console.c
> > +++ b/drivers/char/virtio_console.c
> > @@ -1501,14 +1501,6 @@ static void remove_port(struct kref *kref)
> >  
> >  	port = container_of(kref, struct port, kref);
> >  
> > -	sysfs_remove_group(&port->dev->kobj, &port_attribute_group);
> > -	device_destroy(pdrvdata.class, port->dev->devt);
> > -	cdev_del(port->cdev);
> > -
> > -	kfree(port->name);
> > -
> > -	debugfs_remove(port->debugfs_file);
> > -
> >  	kfree(port);
> >  }
> >  
> > @@ -1566,6 +1558,14 @@ static void unplug_port(struct port *port)
> >  	 */
> >  	port->portdev = NULL;
> >  
> > +	sysfs_remove_group(&port->dev->kobj, &port_attribute_group);
> > +	device_destroy(pdrvdata.class, port->dev->devt);
> > +	cdev_del(port->cdev);
> > +
> > +	kfree(port->name);
> > +
> > +	debugfs_remove(port->debugfs_file);
> > +
> >  	/*
> >  	 * Locks around here are not necessary - a port can't be
> >  	 * opened after we removed the port struct from ports_list
> 
> Should we remove debugfs file before kfree()? Otherwise looks like a
> use-after-free if user access debugfs after kfree().

It is removed before kfree() -- kfree() is called in remove_port(),
which is called when all the references are dropped.  (Did you confuse
kfree(port->name) with kfree(port)?)

Thanks,

		Amit
