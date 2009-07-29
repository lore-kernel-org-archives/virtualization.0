From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for host-guest
	communication
Date: Wed, 29 Jul 2009 10:48:27 +0300
Message-ID: <20090729074827.GJ30449__190.323757897382$1248853857$gmane$org@redhat.com>
References: <1248717876-17630-1-git-send-email-amit.shah@redhat.com>
	<4A6E0C9E.10908@codemonkey.ws> <20090727203214.GG15020@redhat.com>
	<20090727204627.GA32432@shareable.org>
	<4A6E3BDC.8050101@codemonkey.ws>
	<20090728103624.GA5176@amit-x200.redhat.com>
	<4A6F0048.1000103@codemonkey.ws>
	<20090729074418.GA24925@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090729074418.GA24925@amit-x200.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, kvm@vger.kernel.org, Jamie Lokier <jamie@shareable.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 29, 2009 at 01:14:18PM +0530, Amit Shah wrote:
> On (Tue) Jul 28 2009 [08:42:32], Anthony Liguori wrote:
> > Amit Shah wrote:
> >> Right; use virtio just as the transport and all the interesting
> >> activity happens in userspaces. That was the basis with which I started.
> >> I can imagine dbus doing the copy/paste, lock screen, etc. actions.
> >>
> >> However for libguestfs, dbus isn't an option and they already have some
> >> predefined agents for each port. So libguestfs is an example for a
> >> multi-port usecase for virtio-serial.
> >>   
> >
> > Or don't use dbus and use something that libguestfs is able to embed.   
> > The fact that libguestfs doesn't want dbus in the guest is not an  
> > argument for using a higher level kernel interface especially one that  
> > doesn't meet the requirements of the interface.
> 
> But why do we want to limit the device to only one port? It's not too
> complex supporting additional ones.
> 
> As I see it qemu and the kernel should provide the basic abstraction for
> the userspace to go do its job. Why create unnecessary barriers?
> 
I agree. If userspace wants it may use only one channel and demultiplex
messages by itself, but we shouldn't force it to. Also one of the
requirements for virtio-serial is to have connect disconnect
notifications. It is not possible with demultiplexing in the userspace.

--
			Gleb.
