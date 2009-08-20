From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for  host-guest
	communication
Date: Thu, 20 Aug 2009 09:44:29 +0200
Message-ID: <4A8CFEDD.4000009__13214.5638148815$1250754333$gmane$org@redhat.com>
References: <20090806173740.GA1178@shareable.org>
	<4A856B5E.2000303@redhat.com> <4A858FFC.7000607@codemonkey.ws>
	<200908201701.30467.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200908201701.30467.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Anthony Liguori <anthony@codemonkey.ws>, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

On 08/20/09 09:31, Rusty Russell wrote:
> On Sat, 15 Aug 2009 01:55:32 am Anthony Liguori wrote:
>> Gerd Hoffmann wrote:
>>> Also I still think passing a 'protocol' string for each port is a good
>>> idea, so you can stick that into a sysfs file for guests use.
>> Or drops ports altogether and just use protocol strings...
>
> Both is silly, yes.
>
> I guess strings + HAL magic can make the /dev names sane.  I don't want to
> see userspace trolling through sysfs to figure out what device to open.

udev can create sane /dev names (or symlinks) by checking sysfs 
attributes, apps just open the /dev/whatever then.

> Which is why I prefer assigned numbers, which get mapped to minors.

ports map trivially to minors.  When using protocol strings minors can 
simply be dynamically auto-allocated by the guest and we don't need the 
port numbers in the host<->guest protocol any more.

I think strings are better as numbers for identifying protocols as you 
can work without a central registry for the numbers then.

cheers,
   Gerd
