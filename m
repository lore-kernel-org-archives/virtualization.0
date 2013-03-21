From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 12/22] virtio_pci: allow duplicate capabilities.
Date: Thu, 21 Mar 2013 18:11:43 +0200
Message-ID: <20130321161143.GC1925@redhat.com>
References: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
	<1363854584-25795-13-git-send-email-rusty@rustcorp.com.au>
	<20130321102814.GC30493@redhat.com> <514B188A.3030502@zytor.com>
	<20130321144330.GA1454@redhat.com> <514B1D25.9090206@zytor.com>
	<20130321151937.GB1454@redhat.com> <514B26BC.6010700@zytor.com>
	<20130321155810.GA1925@redhat.com> <514B2FA0.9000204@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <514B2FA0.9000204@zytor.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 21, 2013 at 09:04:48AM -0700, H. Peter Anvin wrote:
> On 03/21/2013 08:58 AM, Michael S. Tsirkin wrote:
> >>
> >> Most of them do really ugly hacks in hardware (like putting in a "back
> >> door" in config space) to make that possible.
> > 
> > config space register that let us access
> > registers within BAR actually sounds pretty reasonable.
> > Way better than an I/O BAR.
> > 
> 
> It is really, really, nasty, not to mention slow.

Almost everything we do is through DMA, except a single write
to start transmit and a single read to clear interrupts. So all it means
is we do 2 io writes or reads per packet instead of 1.  Seems harmless
enough. A bit slower than native but should be good enough for
BIOS.  Needs no resources at all.  Why nasty? What's not to like?

> >>> Problem is, BIOS and OS normally assume failure to allocate
> >>> any resources means card won't function and disable it.
> >>> So it does not seem to be worth it to have such a
> >>> device specific failover ability.
> >>>
> >>
> >> That is a violation of the PCIe spec; the PCIe spec specifically states
> >> that failure to allocate an I/O BAR should still allow the device to
> >> function.
> > 
> > Where does it say this?
> 
> In PCI Express 1.1 base, it is section 1.3.2.2, third bullet.
> 
> 	-hpa

Thanks. Same place in latest 3.0:
	A PCI Express Endpoint must not depend on operating system allocation of
	I/O resources claimed through BAR(s).
	A PCI Express Endpoint must not generate I/O Requests.
of course this only applies to express :)

-- 
MST
