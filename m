From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 01/15] virtio_console: Initialize hv_ops struct at
	declaration instead of in the probe() routine
Date: Thu, 12 Nov 2009 12:31:59 +1030
Message-ID: <200911121231.59312.rusty@rustcorp.com.au>
References: <1257846101-23258-1-git-send-email-amit.shah@redhat.com>
	<200911102337.39372.rusty@rustcorp.com.au>
	<20091111184254.GB6416@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091111184254.GB6416@amit-x200.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 12 Nov 2009 05:12:54 am Amit Shah wrote:
> On (Tue) Nov 10 2009 [23:37:39], Rusty Russell wrote:
> > I chose "port" as a name; it's better once we're finished than
> > "struct virtio_console_struct". 
> 
> I wanted to separate out a 'virtio device' which has vqs common to all
> ports and a 'port', which has its buffers, tells us if it's a console
> port, and all the other port-specific stuff.
> 
> I find 'port' and 'ports' confusing. In your implementation, 'port' has
> vqs.

Yep, that's wrong, no wonder you found it confusing.  They should be in the
'struct ports'.  ie. vq == struct ports =contains= N x struct port.

I'm steering away from the word "console", since that will now be one use
of this driver.  We may end up renaming it "virtio_ports".

> > Re: [PATCH 04/15] virtio_console: Introduce a workqueue for handling host->guest notifications
> > 
> > This one I disagree with.  The host will wait until a buffer comes available.
> > It has to anyway, and it should work just fine.  *If* we need speed, then we
> > might need workqueues so we reduce guest exits, but I don't think we need that
> > yet.
> 
> So each port has a buffer that gets added to the vq and when data is
> received, it would be queued in the port-specific ring. Ports may want
> data to be cached when they're not open or when the userspace app is
> slow in reading the data. In that case, we'll have to allocate a new
> buffer to be stuffed in the vq.

OK, I was thinking one buffer per vq.  But that doesn't really work for input,
since we might get input on any port, and not want it.  Seems OK for output
tho.

Hmm, radical idea: how about 1 vq per input?  Share one for output, but
separate ones for each input port?  That limits us to 255 ports, but would
allow the simplistic "just put a buffer in the queue when you want to read".

May need a control input vq as well in this case?

Thanks,
Rusty.
