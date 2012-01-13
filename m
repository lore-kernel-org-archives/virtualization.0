From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PULL] virtio and lguest
Date: Thu, 12 Jan 2012 16:29:14 -0800
Message-ID: <CA+55aFyOy4bWUq6PH3ThM2CXOFwi75FE8HGOJ8DNZjFWw9rq6A@mail.gmail.com>
References: <87lipd4hqx.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87lipd4hqx.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Stratos Psomadakis <psomas@cslab.ece.ntua.gr>, "Michael S. Tsirkin" <mst@redhat.com>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Sasha Levin <levinsasha928@gmail.com>, Amit Shah <amit.shah@redhat.com>, Jacek Galowicz <jacek@galowicz.de>, Christoph Hellwig <hch@lst.de>, Davidlohr Bueso <dave@gnu.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 11, 2012 at 9:22 PM, Rusty Russell <rusty@rustcorp.com.au> wrot=
e:
>
> Amit Shah (12):
> =A0 =A0 =A0virtio: pci: switch to new PM API

Hmm. Afaik, this is broken, or at least not complete.

Sure, it switches to the new PM API, but it still does the PCI ops itself.

It should not need to - the PCI layer will do the power state and
standard PCI device state saving. And setting the PCI_D3hot state when
shared interrupts can still happen at suspend time is just a bad idea.

So I think you're doing extra work and introducing bugs by doing so -
the default PCI bus operations should already do all you do, just do
it better. And then you can use the SIMPLE_DEV_PM_OPS() to build the
dev_pm_ops structure and get all the normal cases right automatically.

I don't know if there is any particularly good example of this, but
you can see some of the network drivers for examples of this. Notice
how they don't need to worry about PCI power states etc at all, they
just need to worry about the actual chip suspend/resume (and for a
network driver, you'd do the netif_device_detach/netif_device_attach
etc)

                         Linus
