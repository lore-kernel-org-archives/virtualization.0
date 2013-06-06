From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Thu, 06 Jun 2013 13:12:04 +0930
Message-ID: <87y5anrjlf.fsf@rustcorp.com.au>
References: <20130530140132.GC21440@redhat.com>
	<874ndgujiw.fsf@rustcorp.com.au> <20130603101136.GB8649@redhat.com>
	<87fvwytpa1.fsf@rustcorp.com.au>
	<20130604064216.GD19433@redhat.com> <871u8g67d6.fsf@codemonkey.ws>
	<20130605140936.GB10604@redhat.com> <87ehcgr3wq.fsf@codemonkey.ws>
	<20130605151953.GA25987@redhat.com> <87bo7ktvaw.fsf@codemonkey.ws>
	<20130605162029.GB26561@redhat.com> <87li6obd2r.fsf@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87li6obd2r.fsf@codemonkey.ws>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori <aliguori@us.ibm.com> writes:
> 4) Do virtio-pcie, make it PCI-e friendly (drop the IO BAR completely), give
>    it a new device/vendor ID.   Continue to use virtio-pci for existing
>    devices potentially adding virtio-{net,blk,...}-pcie variants for
>    people that care to use them.

Now you have a different compatibility problem; how do you know the
guest supports the new virtio-pcie net?

If you put a virtio-pci card behind a PCI-e bridge today, it's not
compliant, but AFAICT it will Just Work.  (Modulo the 16-dev limit).

I've been assuming we'd avoid a "flag day" change; that devices would
look like existing virtio-pci with capabilities indicating the new
config layout.

> I think 4 is the best path forward.  It's better for users (guests
> continue to work as they always have).  There's less confusion about
> enabling PCI-e support--you must ask for the virtio-pcie variant and you
> must have a virtio-pcie driver.  It's easy to explain.

Removing both forward and backward compatibility is easy to explain, but
I think it'll be harder to deploy.  This is your area though, so perhaps
I'm wrong.

> It also maps to what regular hardware does.  I highly doubt that there
> are any real PCI cards that made the shift from PCI to PCI-e without
> bumping at least a revision ID.

Noone expected the new cards to Just Work with old OSes: a new machine
meant a new OS and new drivers.  Hardware vendors like that.

Since virtualization often involves legacy, our priorities might be
different.

Cheers,
Rusty.
