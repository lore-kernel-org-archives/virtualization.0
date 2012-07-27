From: Dmitry Torokhov <dtor@vmware.com>
Subject: Re: [Pv-drivers] [vmw_vmci 11/11] Apply the header code to make VMCI
	build
Date: Fri, 27 Jul 2012 11:04:19 -0700
Message-ID: <20120727180419.GA8262@dtor-ws.eng.vmware.com>
References: <1343345980-32397-1-git-send-email-astiegmann@vmware.com>
	<1343345980-32397-12-git-send-email-astiegmann@vmware.com>
	<20120727105357.2e40dd10@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120727105357.2e40dd10@pyramind.ukuu.org.uk>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: pv-drivers@vmware.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, vm-crosstalk@vmware.com, "Andrew Stiegmann (stieg)" <astiegmann@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Alan,

On Fri, Jul 27, 2012 at 10:53:57AM +0100, Alan Cox wrote:
> > +enum {
> > +	VMCI_SUCCESS_QUEUEPAIR_ATTACH	=  5,
> > +	VMCI_SUCCESS_QUEUEPAIR_CREATE	=  4,
> > +	VMCI_SUCCESS_LAST_DETACH	=  3,
> > +	VMCI_SUCCESS_ACCESS_GRANTED	=  2,
> > +	VMCI_SUCCESS_ENTRY_DEAD	=  1,
> 
> We've got a nice collection of Linux error codes than you, and it would
> make the driver enormously more readable on the Linux side if as low
> level as possible it started using Linux error codes.

If VMCI was only used on Linux we'd definitely do that; however VMCI
core is shared among several operating systems (much like ACPI is) and
we'd like to limit divergencies between them while conforming to the
kernel coding style as much as possible.

We'll make sure that we will not leak VMCI-specific errors to the
standard kernel APIs.

Thanks,
Dmitry
