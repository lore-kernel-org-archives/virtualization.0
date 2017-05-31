From: "bfields@fieldses.org" <bfields@fieldses.org>
Subject: Re: remove function pointer casts and constify function tables
Date: Wed, 31 May 2017 17:15:37 -0400
Message-ID: <20170531211537.GG23526__16930.9416240596$1497319647$gmane$org@fieldses.org>
References: <1494691819.31377.1.camel@primarydata.com>
	<20170515152134.GC24547@fieldses.org>
	<20170515154450.GA18630@lst.de> <20170523081159.GA19216@lst.de>
	<20170523122334.GA4298@fieldses.org>
	<20170526150839.GA4593@fieldses.org>
	<20170526150956.GB4593@fieldses.org>
	<20170526193133.GA9874@fieldses.org>
	<20170530192544-mutt-send-email-mst@kernel.org>
	<20170531210923.GF23526@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170531210923.GF23526@fieldses.org>
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
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, virtualization@lists.linux-foundation.org, "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>, Trond Myklebust <trondmy@primarydata.com>, "jlayton@poochiereds.net" <jlayton@poochiereds.net>, hch <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 31, 2017 at 05:09:23PM -0400, bfields@fieldses.org wrote:
> On Tue, May 30, 2017 at 07:26:37PM +0300, Michael S. Tsirkin wrote:
> > On Fri, May 26, 2017 at 03:31:33PM -0400, bfields@fieldses.org wrote:
> > > Looks like the culprit is very likely d85b758f72b0 "virtio_net: fix
> > > support for small rings".
> > > 
> > > After that patch, my NFS server VM stops responding to packets after a
> > > few minutes of testing.  Before that patch, my server keeps working.
> > > 
> > > --b.
> > 
> > Others complained about that too.
> > I'm still trying to reproduce though.
> > 
> > Meanwhile, could you please locate this line of code:
> > +               vi->rq[i].min_buf_len = mergeable_min_buf_len(vi, vi->rq[i].vq);
> > 
> > and add something like
> >         printk(KERN_ERR, "min buf = 0x%x expected 0x%x size 0x%x big %d\n",
> >                vi->rq[i].min_buf_len, GOOD_PACKET_LEN,
> >                virtqueue_get_vring_size(vi->rq[i].vq),
> >                (int)vi->big_packets);
> > 
> > after it?
> > Then boot and capture the output.
> 
> Doesn't look like that code's run on boot; apply the below, boot, and:

Whoops, no, just a typo in the printk.  Here you go:

	min buf = 0x101 expected 0x5ee size 0x100 big 1

--b.
