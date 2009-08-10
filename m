From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for
	=?iso-8859-1?q?host-guest=09communication?=
Date: Tue, 11 Aug 2009 08:39:28 +0930
Message-ID: <200908110839.28901.rusty__28200.1076186591$1249945864$gmane$org@rustcorp.com.au>
References: <20090805175713.GB28738@shareable.org>
	<20090810065508.GA4499@amit-x200.redhat.com>
	<4A7FECCA.8080804@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A7FECCA.8080804@redhat.com>
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemonkey.ws>, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 10 Aug 2009 07:17:54 pm Gerd Hoffmann wrote:
> On 08/10/09 08:55, Amit Shah wrote:
> >> Bad example.  Quite a lot of modern devices drivers are using dynamic
> >> major/minor numbers because they have proven to be such a pain in the
> >> butt.  That's why we have more sophisticated mechanisms like udev for
> >> userspace to make use of.
> >
> > Let me explain how we came to this numbering: we first had support for
> > 'naming' ports and the names were obtained by userspace programs by an
> > ioctl. Rusty suggested to use some numbering scheme where some ports
> > could exist at predefined locations so that we wouldn't need the naming
> > and the ioctls around it.
> 
> I think the naming is very important.

I disagree.  If you can hand out names, you can hand out numbers.  Whether
the guest chooses to put that number in sysfs or make it a minor, I don't
care.

Rusty.
