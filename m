From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 00/11] qemu: towards virtio-1 host support
Date: Wed, 22 Oct 2014 17:36:00 +0300
Message-ID: <20141022143600.GA14260@redhat.com>
References: <1412692807-12398-1-git-send-email-cornelia.huck@de.ibm.com>
	<54349246.6000905@amacapital.net>
	<20141008110428.6fc78115.cornelia.huck@de.ibm.com>
	<20141022084438.GA8051@redhat.com> <5447BC84.1010402@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5447BC84.1010402@siemens.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: thuth@linux.vnet.ibm.com, kvm@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-devel@nongnu.org, Andy Lutomirski <luto@amacapital.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 22, 2014 at 04:17:40PM +0200, Jan Kiszka wrote:
> On 2014-10-22 10:44, Michael S. Tsirkin wrote:
> > On Wed, Oct 08, 2014 at 11:04:28AM +0200, Cornelia Huck wrote:
> >> On Tue, 07 Oct 2014 18:24:22 -0700
> >> Andy Lutomirski <luto@amacapital.net> wrote:
> >>
> >>> On 10/07/2014 07:39 AM, Cornelia Huck wrote:
> >>>> This patchset aims to get us some way to implement virtio-1 compliant
> >>>> and transitional devices in qemu. Branch available at
> >>>>
> >>>> git://github.com/cohuck/qemu virtio-1
> >>>>
> >>>> I've mainly focused on:
> >>>> - endianness handling
> >>>> - extended feature bits
> >>>> - virtio-ccw new/changed commands
> >>>
> >>> At the risk of some distraction, would it be worth thinking about a
> >>> solution to the IOMMU bypassing mess as part of this?
> >>
> >> I think that is a whole different issue. virtio-1 is basically done - we
> >> just need to implement it - while the IOMMU/DMA stuff certainly needs
> >> more discussion. Therefore, I'd like to defer to the other discussion
> >> thread here.
> > 
> > I agree, let's do a separate thread for this.
> > I also think it's up to the hypervisors at this point.
> > People talked about using ACPI to report IOMMU bypass
> > to guest.
> > If that happens, we don't need a feature bit.
> 
> I thought about this again, and I'm not sure anymore if we can use ACPI
> to "black-list" the incompatible virtio devices. Reason: hotplug. To my
> understanding, the ACPI DRHD tables won't change during runtime when a
> device shows up or disappears. We would have to isolate virtio devices
> from the rest of the system by using separate buses for it (and avoid
> listing those in any DRHD table) and enforce that they only get plugged
> into those buses. I suppose that is not desirable.

That's reasonable I think.

> Maybe it's better to fix virtio /wrt IOMMUs.
> 
> Jan

Yes but this seems unlikely for 2.2:

The wish to run old guests with iommu remains.
So we'll need to support iommu bypass on the host, and so as
a minimum new guest needs to detect such bypass host and fail.

Unrelated: we also need to teach vhost and dataplane virtio
to get mappings from the iommu.

> -- 
> Siemens AG, Corporate Technology, CT RTC ITP SES-DE
> Corporate Competence Center Embedded Linux
