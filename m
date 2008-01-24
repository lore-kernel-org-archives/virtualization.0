From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/2] virtio reset support
Date: Fri, 25 Jan 2008 08:19:39 +1100
Message-ID: <200801250819.39484.rusty__45153.6676184789$1201209782$gmane$org@rustcorp.com.au>
References: <200801240116.26160.rusty@rustcorp.com.au>
	<200801240118.09032.rusty@rustcorp.com.au>
	<1201180147.7100.35.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1201180147.7100.35.camel@localhost.localdomain>
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
To: dor.laor@gmail.com
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Friday 25 January 2008 00:09:07 Dor Laor wrote:
> The patches really fix/simplify things :)

Yes, that's why I like reset, it solves multiple problems.

> Did you test device open->close->open? It was broken in my last test,

Well, it's not really fair, since I moved the buffer allocation and 
deallocation to the probe and remove routines (otherwise we'd have to reset 
on every close).

> we cad add link indications too.

Definitely.  We'll use the config_change callback.  It should be quite neat.

> Besides that I also remembered that adding 'vq->num_free =vq->ring.num;'
> after reset fixed part of the problems, I don't remember why (gonna
> re-check it soon), I think it was the reset calls for (..) detach_buf
> for all buffers regardless if they were free already.

My initial reaction was that we don't need to do cleanup, because it's 
nonsensical to use a virtqueue after reset (you can only really do del_vq: in 
fact we may eventually change "reset" to "kill" which also deletes the 
virtqueues).

However, a shared interrupt might make us look at the ring again, and we'll 
get confused.  reset() must at least reset the 'last seen' index of the 
virtqueues (I had the same issue in the guest).

BTW, here's what lguest does on the host side for reset:

/* Resetting a device is fairly easy. */
static void reset_device(struct device *dev)
{
	struct virtqueue *vq;

	verbose("Resetting device %s\n", dev->name);
	/* Clear the status. */
	dev->desc->status = 0;

	/* Clear any features they've acked. */
	memset(get_feature_bits(dev) + dev->desc->feature_len, 0,
	       dev->desc->feature_len);

	/* Zero out the virtqueues. */
	for (vq = dev->vq; vq; vq = vq->next) {
		memset(vq->vring.desc, 0,
		       vring_size(vq->config.num, getpagesize()));
		vq->last_avail_idx = 0;
	}
}

Cheers,
Rusty.
