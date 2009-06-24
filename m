From: Christian =?iso-8859-1?q?Borntr=E4ger?= <borntraeger@de.ibm.com>
Subject: Re: [PATCH/RFC] virtio_test: A module for testing virtio via userspace
Date: Wed, 24 Jun 2009 13:06:40 +0200
Message-ID: <200906241306.40905.borntraeger__11434.047148987$1245841818$gmane$org@de.ibm.com>
References: <200906190927.34831.borntraeger@de.ibm.com>
	<200906241310.35016.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200906241310.35016.rusty@rustcorp.com.au>
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
Cc: Tim Hofmann <tim.hofmann@de.ibm.com>, Christian Ehrhardt <ehrhardt@de.ibm.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, KVM list <kvm@vger.kernel.org>, Adrian Schneider <adrian.schneider@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Am Mittwoch 24 Juni 2009 05:40:34 schrieb Rusty Russell:
> > o  the general idea of a virtio_test module
> > o  the user interface ioctls
> > o  further ideas and comments
>
> Not mugging real drivers would be a requirement, I think.

Ok, I try to find a proper way to avoid that virtio_test binds to devices that 
have real drivers available. That patch to virtio_dev_match should be relatively 
easy.
The open question I have:  Should virtio_test bind to a device if no other 
driver is (yet) available?

> > +config VIRTIO_TEST
> > +	tristate "Virtio test driver (EXPERIMENTAL)"
> > +	select VIRTIO
> > +	select VIRTIO_RING
>
> Perhaps these should be depends?  Plus, depends on EXPERIMENTAL.
>
> > +	 If unsure, say M.
>
> That's "N" I think.

Yes. 

>
> > +	case VIOTEST_IOCGETBUF:
> > +		ret = do_get_buf(vtest, (struct viotest_getbuf __user *) arg);
> > +		break;
> > +	case VIOTEST_IOCGETCBS:
> > +		ret = get_callbacks(vtest, (struct viotest_cbinfo __user *) arg);
> > +		break;
>
> Generally the point of callbacks is to tell you you have new buffers; in
> fact you're insulated from callbacks which don't show new buffers.  So I'm
> not sure these two need to be separate?
> In which case, a read/write interface starts to make sense (write for
> addbuf and kick, read for get_buf).  That fits nicely with O_NONBLOCK and
> poll().

Hmm - makes sense. I will try to propose a 2nd version of the interface. The 
interface must handle multiple virtqueues per device, should allow non-blocking 
mode etc. Lets see what ideas come to my mind.

Thanks for the comments

Christian
