From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/6] virtio interace
Date: Sat, 22 Sep 2007 19:55:34 +1000
Message-ID: <1190454934.27805.80.camel@localhost.localdomain>
References: <1190289808.7262.223.camel@localhost.localdomain>
	<200709211405.32116.arnd@arndb.de>
	<1190378736.27805.54.camel@localhost.localdomain>
	<200709211622.22005.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200709211622.22005.arnd@arndb.de>
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

On Fri, 2007-09-21 at 16:22 +0200, Arnd Bergmann wrote:
> On Friday 21 September 2007, Rusty Russell wrote:
> > Hmm, I guess we could have a PCI driver which claims all VIRTIO vendor
> > devices.  
> 
> yes, that was the idea.
> 
> > Then it can call virtio_find_driver() (?) at the top of its 
> > probe function to find if there's a matching virtio driver.  
> > This PCI  driver would have to be initialized after all the virtio
> > drivers are registered, but that's easy.
> 
> No, just use the driver model, instead of working against it:

But now each virtio device has two "struct device"s, not one.   And
you've made up a fictional bus to do it.

Yet for PCI systems, it really is a PCI device; exposing a second bus to
userspace just because we put a layer in our implementation is poor
form.

Perhaps this is the easiest way of doing it.  But it's still wrong.

Rusty.
