From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Mon, 19 Dec 2011 11:13:26 +0200
Message-ID: <20111219091324.GA19535@redhat.com>
References: <87pqfzgy6p.fsf@rustcorp.com.au> <87zkf3fiu2.fsf@rustcorp.com.au>
	<20111211094256.GB11504@redhat.com>
	<87boreohhs.fsf@rustcorp.com.au>
	<20111212182533.GB25916@redhat.com>
	<87liqhtdnj.fsf@rustcorp.com.au> <20111215063004.GA3630@redhat.com>
	<87zketp9nz.fsf@rustcorp.com.au>
	<20111218101831.GB30374@redhat.com>
	<87bor5nlht.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87bor5nlht.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Pawel Moll <pawel.moll@arm.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Dec 19, 2011 at 04:36:38PM +1030, Rusty Russell wrote:
> On Sun, 18 Dec 2011 12:18:32 +0200, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Fri, Dec 16, 2011 at 12:20:08PM +1030, Rusty Russell wrote:
> > > Perhaps a new feature VIRTIO_F_UNSTABLE?  Which (unlike other features)
> > > appears and vanishes around config writes by either side?  Kind of a
> > > hack though...
> > 
> > Not sure how this can work in such a setup: when would guest
> > check this bit to avoid races?
> > A separate registers also seems nicer than a flag.
> > 
> > Some other possible design choices:
> > - a flag to signal config accesses in progress by guest
> >   host would need to buffer changes and apply them in one go
> >   when flag is cleared
> > - a register to make host get/set config in guest memory
> > - use a control vq for all devices
> 
> - seqlock-style generation count register(s)?
>   Has the advantage of
>   being a noop if things never change.

The counter can be in guest memory, right? So we don't pay extra exits.

> - continue to ignore it ;)

Since you decided on a config layout redesign it seems a good time to
fix architectural problems ...

> And yes, it's a more general problem than virtio_pci...
> 
> Cheers,
> Rusty.


-- 
MST
