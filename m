From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio: remove explicit pci ids from virtio_pci.c
Date: Mon, 21 Jan 2008 22:22:27 +1100
Message-ID: <200801212222.28266.rusty__31781.6692906947$1200914728$gmane$org@rustcorp.com.au>
References: <200801211130.51401.rusty@rustcorp.com.au>
	<479420D2.7050902@us.ibm.com> <4794620E.7010900@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4794620E.7010900@qumranet.com>
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
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Monday 21 January 2008 20:12:46 Avi Kivity wrote:
> Anthony Liguori wrote:
> > Rusty Russell wrote:
> >> Qumranet let us use their PCI vendor ID, with device ids >= 0x1000.
> >> We can specify that we accept all of them in the device ID table, and
> >> then return -ENODEV in the probe routine.
> >
> > I thought the device id range was smaller.  Avi?
>
> Yes, 0x1000-0x10ff IIRC.
>
> Also, if we break compatibility in the future, won't this claim devices
> we don't actually support?

Yep, I reduced it to 0x1000 - 0x103F for the moment.  We can always expand 
long before we get our 64th device type.

Cheers,
Rusty.
