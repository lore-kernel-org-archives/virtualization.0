From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for
	=?iso-8859-1?q?host-guest=09communication?=
Date: Thu, 20 Aug 2009 17:01:29 +0930
Message-ID: <200908201701.30467.rusty__27181.7393870608$1250753668$gmane$org@rustcorp.com.au>
References: <20090806173740.GA1178@shareable.org>
	<4A856B5E.2000303@redhat.com> <4A858FFC.7000607@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A858FFC.7000607@codemonkey.ws>
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
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 15 Aug 2009 01:55:32 am Anthony Liguori wrote:
> Gerd Hoffmann wrote:
> > Also I still think passing a 'protocol' string for each port is a good 
> > idea, so you can stick that into a sysfs file for guests use.
> 
> Or drops ports altogether and just use protocol strings...

Both is silly, yes.

I guess strings + HAL magic can make the /dev names sane.  I don't want to
see userspace trolling through sysfs to figure out what device to open.

Which is why I prefer assigned numbers, which get mapped to minors.

Rusty.
