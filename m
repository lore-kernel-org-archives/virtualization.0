From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [PATCH] KVM simplified virtio balloon driver
Date: Thu, 17 Jan 2008 14:29:32 +1100
Message-ID: <200801171429.32888.rusty__12543.4496011168$1200540728$gmane$org@rustcorp.com.au>
References: <20080114200357.GA18354@dmt>
	<200801171245.59510.rusty@rustcorp.com.au>
	<478EBA22.30301@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <478EBA22.30301@codemonkey.ws>
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
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Marcelo Tosatti <marcelo@kvack.org>, kvm-devel <kvm-devel@lists.sourceforge.net>, David Miller <davem@davemloft.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 17 January 2008 13:14:58 Anthony Liguori wrote:
> Rusty Russell wrote:
> > +static struct virtio_device_id id_table[] = {
> > +	{ VIRTIO_ID_BALLOON, VIRTIO_DEV_ANY_ID},
>
> Could use a space after VIRTIO_DEV_ANY_ID

Thanks, fixed.

> > +		__free_page(page);
> > +		vb->num_pages--;
> > +		totalram_pages++;
>
> Do we really want to modify totalram_pages in this driver?  The only
> other place that I see that modifies it is in mm/memory_hotplug and it
> also modifies other things (like num_physpages).  The cmm driver doesn't
> touch totalram_pages.

I don't think there's a standard here, they're all ad-hoc (eg. no locking)  
Modifying totalram_pages has the nice effect of showing up in "free" in the 
guest.

We should probably not modify num_physpages, because some places seem to use 
it as an address space limit.  But we should probably fix all those 
networking size heuristics to use totalram_pages instead of num_physpages.

> It would be very useful too to write vb->num_pages into the config space
> whenever it was updated.  This way, the host can easily keep track of
> where the guest is at in terms of ballooning.

OTOH it's currently pretty obvious (and usually fatal) if the guest has 
trouble meeting the balloon requirements.  A serious host needs a way of 
detecting stress in the guest anyway, which this doesn't offer until it's too 
late...

Rusty.
