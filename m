From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/3] Virtio draft IV: the block driver
Date: Tue, 24 Jul 2007 13:02:05 +1000
Message-ID: <1185246125.1803.121.camel@localhost.localdomain>
References: <1183522348.6110.37.camel@localhost.localdomain>
	<1183522765.6110.40.camel@localhost.localdomain>
	<200707231313.11847.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200707231313.11847.borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2007-07-23 at 13:13 +0200, Christian Borntraeger wrote:
> > +#ifdef __KERNEL__
> > +struct gendisk;
> > +struct virtio_device;
> > +
> > +struct gendisk *virtblk_probe(struct virtqueue *vq);
> 
> Hello Rusty,
> 
> I am currently do some prototyping with virtio IV and found tis small issue in 
> the block device. virtblk_probe requires a declaration of virtqueue, not 
> virtio_device. 

Oops, thanks Christian!

	I'll roll this in, thanks!

Rusty.
PS.  2.6.23-rc1 broke the block driver anyway, so will publish new
versions soon.
