From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv4 2/2] vhost_net: a kernel-level virtio server
Date: Tue, 25 Aug 2009 20:50:16 +0300
Message-ID: <20090825175016.GA15790__39788.6486295194$1251223200$gmane$org@redhat.com>
References: <cover.1250693417.git.mst@redhat.com>
	<20090819150309.GC4236@redhat.com>
	<200908252140.41295.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200908252140.41295.rusty@rustcorp.com.au>
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
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, hpa@zytor.com, mingo@elte.hu, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 25, 2009 at 09:40:40PM +0930, Rusty Russell wrote:
> > +	u32 __user *featurep = argp;
> > +	int __user *fdp = argp;
> > +	u32 features;
> > +	int fd, r;
> > +	switch (ioctl) {
> > +	case VHOST_NET_SET_SOCKET:
> > +		r = get_user(fd, fdp);
> > +		if (r < 0)
> > +			return r;
> > +		return vhost_net_set_socket(n, fd);
> > +	case VHOST_GET_FEATURES:
> > +		/* No features for now */
> > +		features = 0;
> > +		return put_user(features, featurep);
> 
> We may well get more than 32 feature bits, at least for virtio_net, which will
> force us to do some trickery in virtio_pci.

Unlike PCI, if we ever run out of bits we can just
add FEATURES_EXTENDED ioctl, no need for trickery.

>  I'd like to avoid that here,
> though it's kind of ugly.  We'd need VHOST_GET_FEATURES (and ACK) to take a
> struct like:
> 
> 	u32 feature_size;
> 	u32 features[];


Thinking about this proposal some more, how will the guest
determine the size to supply the GET_FEATURES ioctl?

Since we are a bit tight in 32 bit space already,
let's just use a 64 bit integer and be done with it?
Right?

-- 
MST
