From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 4/4] rpmsg: DMA map sgs passed to virtio
Date: Tue, 23 Jun 2015 07:17:44 +0200
Message-ID: <20150623071620-mutt-send-email-mst@redhat.com>
References: <1430456507-26862-1-git-send-email-edgar.iglesias@gmail.com>
	<1430456507-26862-5-git-send-email-edgar.iglesias@gmail.com>
	<87wq0mgr9f.fsf@rustcorp.com.au> <20150507002809.GW10142@toto>
	<CAK=WgbbYLMNQ4jdXLz9bZf4a8q4pVCyeN84J3G7YGca2MP7SsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAK=WgbbYLMNQ4jdXLz9bZf4a8q4pVCyeN84J3G7YGca2MP7SsA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: edgar.iglesias@xilinx.com, Russell King <linux@arm.linux.org.uk>, michal.simek@xilinx.com, virtualization <virtualization@lists.linux-foundation.org>, j.wu@xilinx.com, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, May 16, 2015 at 12:32:10PM +0300, Ohad Ben-Cohen wrote:
> On Thu, May 7, 2015 at 3:28 AM, Edgar E. Iglesias
> <edgar.iglesias@gmail.com> wrote:
> >
> > On Wed, May 06, 2015 at 03:51:48PM +0930, Rusty Russell wrote:
> > > "Edgar E. Iglesias" <edgar.iglesias@gmail.com> writes:
> > > > From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> > > >
> > > > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> > >
> > > First off, I have handed maintainership off to Michael S. Tsirkin, so
> > > his word is now law.
> > >
> > > That said... there's nothing fundamentally *wrong* with this, but it's
> > > not how standard virtio works.  We decided some time ago that as we're
> > > paravirtualized, we would not be doing address mapping.
> > >
> > > rpmsg uses virtio, but it's with a twist: they're not talking to a
> > > host.  Thus my preference, in order, would be:
> > >
> > > 1) Don't use non-kmalloc addresses.
> > > 2) If that's not possible, call these _dma interfaces _rpmsg instead,
> > >    so normal virtio users don't get confused and try to use them.
> >
> > Thanks Rusty,
> >
> > That was helpful, I'll see if I can do something in line with nr 2.
> >
> > AFAICT, #1 will be hard. The remote-processor would have to be
> > cache-coherent and share memory address-space view with the master
> > CPU. This is not the common case for remoteproc (unlike when virtio
> > communication flows between host and guest on the same CPU or SMP system).
> > Ohad, do you have any thoughts on this?
> 
> rpmsg is allocating a large chunk (256KB) of physically-contiguous CMA
> memory today, which is exposed via the dma_alloc_coherent API (and set
> up in advance by platform-specific code), so if #2 above is
> acceptable, it would be easier, yeah.
> 
> Thanks,
> Ohad.

I'm thinking same as Rusty: I'd prefer 1 but if not possible, I can live
with 2 above.

-- 
MST
