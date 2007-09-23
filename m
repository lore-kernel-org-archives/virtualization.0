From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/6] virtio interace
Date: Sun, 23 Sep 2007 18:33:51 +1000
Message-ID: <1190536431.27805.109.camel__5776.13128484717$1190536689$gmane$org@localhost.localdomain>
References: <1190289808.7262.223.camel@localhost.localdomain>
	<200709211622.22005.arnd@arndb.de>
	<1190454934.27805.80.camel@localhost.localdomain>
	<200709221201.33865.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200709221201.33865.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, Dor Laor <dor.laor@qumranet.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 2007-09-22 at 12:01 +0200, Arnd Bergmann wrote:
> On Saturday 22 September 2007, Rusty Russell wrote:
> > But now each virtio device has two "struct device"s, not one.   And
> > you've made up a fictional bus to do it.
> > 
> > Yet for PCI systems, it really is a PCI device; exposing a second bus to
> > userspace just because we put a layer in our implementation is poor
> > form.
> > 
> > Perhaps this is the easiest way of doing it.  But it's still wrong.
> 
> I think it's just a matter of perspective. In the model I'm advocating,
> the PCI device is not the same as the virtio device but rather a virtio
> host bridge, very much like USB or SATA works.
> 
> We could easily have multiple virtio devices behind one PCI device, but
> since virtual PCI devices are cheap, a one-to-one mapping makes sense
> for simplicity.

This is still retro-justification.  The simplest way for PCI systems to
represent a virtio device as a PCI device; this makes life easy for any
guest OS.

I just know we're going to regret this...
Rusty.
