From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: virtio-pci new configuration proposal
Date: Sun, 6 Nov 2011 23:38:49 +0200
Message-ID: <20111106213849.GA14292@redhat.com>
References: <1320309203.29407.1.camel@lappy> <87lirwrzlg.fsf@rustcorp.com.au>
	<20111104114033.GA21308@redhat.com> <1320409939.3334.6.camel@lappy>
	<20111104135113.GA24452@redhat.com>
	<1320414804.3334.13.camel@lappy>
	<20111104142338.GB24452@redhat.com>
	<1320418385.3334.25.camel@lappy> <20111106073007.GA7146@redhat.com>
	<1320611097.3299.10.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1320611097.3299.10.camel@lappy>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: Anthony Liguori <anthony@codemonkey.ws>, linux-kernel <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Nov 06, 2011 at 10:24:57PM +0200, Sasha Levin wrote:
> On Sun, 2011-11-06 at 09:30 +0200, Michael S. Tsirkin wrote:
> > On Fri, Nov 04, 2011 at 04:53:05PM +0200, Sasha Levin wrote:
> > > > > > > As you said, the PCI cap list was introduced both to save space (which
> > > > > > > is not the motivation here), and because it's a very efficient
> > > > > > 
> > > > > > It's actually pretty inefficient - there's an overhead of 3 bytes for
> > > > > > each vendor specific option.
> > > > > 
> > > > > It's efficient because while you pay a small price for each optional
> > > > > option it also means that that option is optional and won't clutter the
> > > > > config space if it's not really in use.
> > > > 
> > > > I guess my assumption is that most options will be in use,
> > > > not discarded dead-ends.
> > > 
> > > I don't know about that. 64 bit features would be pretty rare for now -
> > > and I don't think that setting the alignment will be also enabled by
> > > default.
> > 
> > Setting the alignment might not be *used* by default but
> > I think it must be enabled by default to allow bios access.
> > 
> > > I think that we're looking at it differently because I assume that any
> > > feature we add at this point would be optional and used only in specific
> > > scenarios, while you think that everything added will be used most of
> > > the time.
> > 
> > Options must often be present even if not used. For example, as device
> > has no way to know whether a guest will want to program alignment, it
> > has to make that option available.
> 
> They should be enabled, but heres the difference between the two
> approaches is that if it's cap it simply won't be there,

How can it not be there? They layout is specified by host,
not by guest.

> while in the
> other case it would just remain empty at some random offset of the
> struct.
> 
> -- 
> 
> Sasha.
