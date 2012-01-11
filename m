From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Thu, 12 Jan 2012 00:02:33 +0200
Message-ID: <20120111220232.GC27292@redhat.com>
References: <4F0DA7A5.7050600@codemonkey.ws>
	<20120111152129.GB20570@redhat.com>
	<4F0DAA9B.7060703@codemonkey.ws>
	<20120111154515.GD20570@redhat.com>
	<4F0DB2AB.8030506@codemonkey.ws>
	<20120111170859.GA22310@redhat.com>
	<4F0DE62F.6030805@codemonkey.ws>
	<20120111201436.GA27292@redhat.com>
	<4F0DF08F.7010706@codemonkey.ws>
	<1326315726.23910.143.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1326315726.23910.143.camel@pasglop>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Pawel Moll <pawel.moll@arm.com>, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 12, 2012 at 08:02:06AM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2012-01-11 at 14:26 -0600, Anthony Liguori wrote:
> > 
> > I'd say that's a special case but I see what you're getting at here.
> > 
> > So what about keeping the config space read-only and using control
> > queues for 
> > everything else?
> 
> Which is exactly what Rusty and I are proposing :-)
> I would go further
> and eliminate the idea of a seqlock and instead of a status queue with
> precise messages indicating what changed.
>
> I would couple that with the new queue format allowing immediate data in
> the descriptor to avoid having to use indirect buffers for these, which
> means no allocation, no buffer pool etc... which makes everything a lot
> easier to deal with as well.

We just need a couple of buffers outstanding. It can't be easier,
and a single buf descriptors already do not use indirection.

> We could probably have a helper library for sending control messages
> which could handle waiting for a ring slot to be free (practically
> always the case on control queues), writing the message, sending it and
> waiting for a status queue confirmation message.
> 
> Cheers,
> Ben.
> 

Look, we have a race currently. Let us not tie a bug fix to a huge
rewrite with unclear performance benefits, please.

-- 
MST
