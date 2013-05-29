From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Wed, 29 May 2013 21:16:01 +0300
Message-ID: <20130529181601.GD1771@redhat.com>
References: <20130528160342.GA29915@redhat.com> <87bo7vvxej.fsf@codemonkey.ws>
	<87ppwammp5.fsf@rustcorp.com.au> <87mwreq76y.fsf@codemonkey.ws>
	<20130529132430.GA9363@redhat.com> <8761y1q3aw.fsf@codemonkey.ws>
	<20130529143053.GB10462@redhat.com> <87k3mhkf7o.fsf@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87k3mhkf7o.fsf@codemonkey.ws>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 29, 2013 at 09:55:55AM -0500, Anthony Liguori wrote:
> > Not we. The BIOS can disable IO BAR: it can do this already
> > but the device won't be functional.
> 
> But the only way to expose the device over PCI express is to disable the
> IO BAR, right?

I think this is the source of the misunderstanding:

	1.3.2.2.  PCI Express Endpoint Rules

	...

	PCI Express Endpoint must not depend on operating system
	allocation of I/O resources claimed through BAR(s).

The real meaning here is *not* that an Endpoint should not
have an I/O BAR. An Endpoint can have an I/O BAR,
and PCI Express spec supports I/O transactions.
The meaning is that an Endpoint should work
even if *the OS* decides to disable the I/O BAR.
Note: it's up to the guest. We support I/O
as a device with full compatibility for old guests,
but must be prepared to handle a guest which does not
enable I/O.

This likely means that as time goes on,
future OSes will start disabling I/O BARs,
relying on this not hurting functionality.

-- 
MST
