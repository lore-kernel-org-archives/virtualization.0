From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 00/11] qemu: towards virtio-1 host support
Date: Thu, 23 Oct 2014 10:12:51 +0300
Message-ID: <20141023071251.GA6287@redhat.com>
References: <1412692807-12398-1-git-send-email-cornelia.huck@de.ibm.com>
	<54349246.6000905@amacapital.net>
	<20141008110428.6fc78115.cornelia.huck@de.ibm.com>
	<20141022084438.GA8051@redhat.com> <5447BC84.1010402@siemens.com>
	<1414010056.364.20.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1414010056.364.20.camel@pasglop>
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
Cc: thuth@linux.vnet.ibm.com, kvm@vger.kernel.org, Rusty Russell <rusty@au1.ibm.com>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel@nongnu.org, Andy Lutomirski <luto@amacapital.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Oct 23, 2014 at 07:34:16AM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2014-10-22 at 16:17 +0200, Jan Kiszka wrote:
> > I thought about this again, and I'm not sure anymore if we can use
> > ACPI
> > to "black-list" the incompatible virtio devices. Reason: hotplug. To
> > my
> > understanding, the ACPI DRHD tables won't change during runtime when a
> > device shows up or disappears. We would have to isolate virtio devices
> > from the rest of the system by using separate buses for it (and avoid
> > listing those in any DRHD table) and enforce that they only get
> > plugged
> > into those buses. I suppose that is not desirable.
> > 
> > Maybe it's better to fix virtio /wrt IOMMUs.
> 
> I always go back to my initial proposal which is to define that current
> virtio always bypass any iommu (which is what it does really) and have
> it expose via a new capability if that isn't the case. That means fixing
> that Xen thingy to allow qemu to know what to expose I assume but that
> seems to be the less bad approach.
> 
> Cheers,
> Ben.
> 

OK so how does this work?
If you want to run an existing guest, you use the old device.
And presumably you blacklist virtio for nested virt then,
unless a new capability is present?


-- 
MST
