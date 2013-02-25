From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] virtio-blk: emit udev event when device is resized
Date: Mon, 25 Feb 2013 14:43:39 -0800
Message-ID: <20130225224339.GA19153__21768.7307078906$1361832249$gmane$org@kroah.com>
References: <1361473348-7660-1-git-send-email-milos.vyletel@sde.cz>
	<87y5ehfczy.fsf@rustcorp.com.au> <20130225221238.GA10575@kroah.com>
	<CAPXgP13M_krpPMFoBroYkXc4dUQHsZJDua-jSGby8cQ1Afy-HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAPXgP13M_krpPMFoBroYkXc4dUQHsZJDua-jSGby8cQ1Afy-HQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Kay Sievers <kay@vrfy.org>
Cc: mst@redhat.com, linux-hotplug@vger.kernel.org, linux-kernel@vger.kernel.org, Milos Vyletel <milos.vyletel@sde.cz>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Feb 25, 2013 at 11:39:52PM +0100, Kay Sievers wrote:
> On Mon, Feb 25, 2013 at 11:12 PM, Greg KH <greg@kroah.com> wrote:
> 
> > Hm, I thought we were frowning apon running binaries from udev rules
> > these days, especially ones that might have big consequences (like
> > resizing a disk image) like this.
> >
> > Kay, am I right?
> 
> We removed most of them from the default setups, yes. But there is
> nothing wrong if people want to ship that in some package or as custom
> rules.
> 
> It looks fine to me, we would just not add such things to the default
> set of of rules these days.
> 
> > We already emit KOBJECT_CHANGE events when block devices change, from
> > within the block core code.  Why is the patch below needed instead of
> > using these events that are already generated?  How are virtio block
> > devices special?
> 
> I think we only do that for dm and md and a couple of special cases
> like loop and read-only settings.

What about when we repartition a block device?  I've seen the events
happen then.

Anyway, if you are ok with this, no objection from my side then Rusty.

thanks,

greg k-h
