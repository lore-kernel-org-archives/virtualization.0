From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [PATCH 2/6] virtio_config
Date: Fri, 21 Sep 2007 11:50:35 +1000
Message-ID: <1190339435.19451.23.camel__18427.4907027886$1190374842$gmane$org@localhost.localdomain>
References: <1190289808.7262.223.camel@localhost.localdomain>
	<1190290140.7262.228.camel@localhost.localdomain>
	<1190290369.7262.231.camel@localhost.localdomain>
	<46F26958.4080102@qumranet.com>  <46F26DC7.9040001@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46F26DC7.9040001@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-09-20 at 14:55 +0200, Avi Kivity wrote:
> Avi Kivity wrote:
> > Rusty Russell wrote:
> >> Previous versions of virtio didn't commonalize probing.  For every
> >> driver, every virtio implementation (KVM, lguest, etc) needed an
> >> in-kernel stub to join their bus to the probe code.
> >>
> >> To solve this, we introduce a "virtio_config" mechanism, which is
> >> simply a set of [u8 type][u8 len][...data...] fields for each device.
> >> Some convenient wrapper functions make this fairly easy for drivers to
> >> unpack their configuration data themselves.
> >>
> >> This configuration data could be PCI config space, or an unrelated bus
> >> (eg. lguest) or manufactured by the kernel itself.  It's designed to
> >> be extensible: fields get marked as the device reads them so a host
> >> supporting some future extension can tell if the guest driver
> >> understood it.  This also applies to bitfields: the guest explicitly
> >> acks the bits it understands.
> >>
> >> There's also a simple status bitmask useful for low-level host
> >> analysis of what the guest is doing with the device.
> >>
> >>   
> >
> > Lovely.
> >
> 
> A side effect of this is that Xen drivers can no longer use virtio.

I'm not so sure.

We were always assuming that Xen could do state management in its virtio
layer.  If this is not true, it implies we need hooks in the virtio
drivers, and I don't think we've made it worse by making it translate
xenbus config info into virtio_config.

Rusty.
