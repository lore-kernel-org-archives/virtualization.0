From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/11] RFC: PCI using capabilitities
Date: Sun, 11 Dec 2011 14:30:57 +0200
Message-ID: <20111211123057.GD11504@redhat.com>
References: <87pqfzgy6p.fsf@rustcorp.com.au> <1323358657.32487.9.camel@lappy>
	<4EE4726F.3010503@redhat.com> <1323597832.4063.4.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1323597832.4063.4.camel@lappy>
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
Cc: Avi Kivity <avi@redhat.com>, kvm@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Dec 11, 2011 at 12:03:52PM +0200, Sasha Levin wrote:
> On Sun, 2011-12-11 at 11:05 +0200, Avi Kivity wrote:
> > mmios are strictly ordered.
> > 
> > Perhaps your printfs are reordered by buffering?  Are they from
> > different threads?  Are you using coalesced mmio (which is still
> > strictly ordered, if used correctly)? 
> 
> I print the queue_selector and queue_address in the printfs, even if
> printfs were reordered they would be printing the data right, unlike
> they do now. It's the data in the printfs that matters, not their order.
> 
> Same vcpu thread with both accesses.
> 
> Not using coalesced mmio.

Not sure why this would matter, but is the BAR a prefetcheable one?
Rusty's patch uses pci_iomap which maps a prefetcheable BAR
as cacheable.


> -- 
> 
> Sasha.
