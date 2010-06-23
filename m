From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH for-2.6.35] virtio-pci: disable msi at startup
Date: Wed, 23 Jun 2010 08:51:53 -0700
Message-ID: <20100623085153.603e943f__4451.32003301314$1277308455$gmane$org@virtuousgeek.org>
References: <20100610152252.GA3510@redhat.com> <4C22132F.4060307@redhat.com>
	<20100623135946.GA30526@redhat.com> <4C221871.6020509@redhat.com>
	<20100623144307.GB30526@redhat.com> <4C222508.2060804@redhat.com>
	<20100623152633.GC30526@redhat.com> <4C2229DB.6060706@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4C2229DB.6060706@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-pci@vger.kernel.org, Matt Carlson <mcarlson@broadcom.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Tejun Heo <tj@kernel.org>, "David S. Miller" <davem@davemloft.net>, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 23 Jun 2010 18:35:55 +0300
Avi Kivity <avi@redhat.com> wrote:

> On 06/23/2010 06:26 PM, Michael S. Tsirkin wrote:
> >
> >
> >>>
> >>>        
> >>>>>> Shouldn't a reset be equivalent to power cycling?
> >>>>>>
> >>>>>>
> >>>>>>              
> >>>>> If we did this, driver would need to restore registers
> >>>>> such as BAR etc.
> >>>>>
> >>>>>
> >>>>>            
> >>>> We could save/restore the registers we care about.
> >>>>
> >>>>          
> >>> It seems easier to clear registers we care about.
> >>>        
> >> We know the registers we care about, we don't know the ones we don't.
> >>      
> > If/when we use more registers, we can update driver to clear them on start.
> >    
> 
> The kdump kernel may not load drivers for those extra devices.

FLR or another type of reset also has the nice property of bringing the
device into a known state.  kexec/kdump has always been vulnerable to
having devices in partial states when the new kernel loads; would be
good to make it more robust.

> 
> >> I'm talking about FLRing all cards, not just those you want to use.
> >>      
> > reset using FLR/PM is complex because of the need to save/restore
> > config space. Doing this on a crashing kernel sounds scary.
> >    
> 
> Well, you only need to save/restore for the devices you use.  The rest 
> you reset and forget.
> 
> I don't really see why copying some config space is crazy.

We could push any needed save/restore of core settings and regs into
the PCI core like we do for PM.  That would save a bunch of driver
trouble...

-- 
Jesse Barnes, Intel Open Source Technology Center
