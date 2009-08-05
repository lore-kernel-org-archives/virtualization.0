From: Jamie Lokier <jamie@shareable.org>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for host-guest
	communication
Date: Wed, 5 Aug 2009 19:00:49 +0100
Message-ID: <20090805180049.GC28738__885.321052237664$1249495309$gmane$org@shareable.org>
References: <1248717876-17630-1-git-send-email-amit.shah@redhat.com>
	<4A6E0C9E.10908@codemonkey.ws> <20090727203214.GG15020@redhat.com>
	<20090727204627.GA32432@shareable.org>
	<4A6E3BDC.8050101@codemonkey.ws>
	<20090728103624.GA5176@amit-x200.redhat.com>
	<4A6F0048.1000103@codemonkey.ws>
	<20090729074418.GA24925@amit-x200.redhat.com>
	<20090729074827.GJ30449@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090729074827.GJ30449@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gleb Natapov <gleb@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemonkey.ws>, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Gleb Natapov wrote:
> On Wed, Jul 29, 2009 at 01:14:18PM +0530, Amit Shah wrote:
> > But why do we want to limit the device to only one port? It's not too
> > complex supporting additional ones.
> > 
> > As I see it qemu and the kernel should provide the basic abstraction for
> > the userspace to go do its job. Why create unnecessary barriers?
> > 
> I agree. If userspace wants it may use only one channel and demultiplex
> messages by itself, but we shouldn't force it to. Also one of the
> requirements for virtio-serial is to have connect disconnect
> notifications. It is not possible with demultiplexing in the userspace.

I agree too, for all those reasons.

However it would be useful if the devices provided a simpler way to be
found by guest applications than /dev/vmch0, vmch1, vmch2...

On Linux udev provides a sane way to find devices according to roles,
subtypes, serial numbers, whatever you want, if the appropriate id
codes are available from the devices and put into /sys/* by the kernel
driver.  That would make the devices much more useful to independent
applications, imho.

-- Jamie
