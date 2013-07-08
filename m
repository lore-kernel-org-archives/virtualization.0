From: Kevin O'Connor <kevin@koconnor.net>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Mon, 8 Jul 2013 00:25:11 -0400
Message-ID: <20130708042511.GA22991@morn.localdomain>
References: <20130605162029.GB26561@redhat.com> <51AFA92B.2030203@zytor.com>
	<87fvwwmdmf.fsf@codemonkey.ws> <51AFB3DD.1050902@zytor.com>
	<874ndcb47i.fsf@codemonkey.ws> <51AFC4A6.6070607@zytor.com>
	<877gi8nk9e.fsf@codemonkey.ws> <20130606063432.GQ4725@redhat.com>
	<51B0A578.2030104@redhat.com> <20130606151012.GD4725@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130606151012.GD4725@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gleb Natapov <gleb@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Anthony Liguori <aliguori@us.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

I only recently saw this email.

On Thu, Jun 06, 2013 at 06:10:12PM +0300, Gleb Natapov wrote:
> On Thu, Jun 06, 2013 at 05:06:32PM +0200, Gerd Hoffmann wrote:
> > For seabios itself this isn't a big issue, see pci_{readl,writel} in
> > src/pci.c.  When called in 16bit mode it goes into 32bit mode
> > temporarily, just for accessing the mmio register.  ahci driver uses it,
> > xhci driver (wip atm) will use that too, and virtio-{blk,scsi} drivers
> > in seabios can do the same.
> > 
> Isn't this approach broken? How can SeaBIOS be sure it restores real
> mode registers to exactly same state they were before entering 32bit
> mode?

You are correct - SeaBIOS can't fully restore the "hidden" segment
registers.  So, in a way it is broken.

In practice, it seems to work on modern bootloaders (eg, ntldr, grub,
lilo).  It definitely doesn't work with EMM386 (old DOS stuff), but
does seem to work okay with FreeDOS as long as one doesn't run EMM386.

The AHCI code uses this 32bit/16bit trampoline because it would not be
possible to support AHCI otherwise.  I haven't seen any complaints of
failures with the AHCI code - probably because people using AHCI are
using modern guests.

I explored this a bit some time back and the only way I could think of
to reliably restore the 16bit registers would be via SMM.
Unfortunately, using SMM introduces a whole host of complexity and
problems.

-Kevin
