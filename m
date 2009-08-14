From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for
	host-guest	communication
Date: Fri, 14 Aug 2009 15:49:18 +0200
Message-ID: <4A856B5E.2000303@redhat.com>
References: <20090806173740.GA1178@shareable.org>
	<20090807063800.GA16769@amit-x200.redhat.com>
	<4A7C36D3.3040305@codemonkey.ws>
	<20090810065508.GA4499@amit-x200.redhat.com>
	<4A7FECCA.8080804@redhat.com> <4A801A7B.1020208@codemonkey.ws>
	<4A80287C.7050400@redhat.com> <4A802CA7.9020701@codemonkey.ws>
	<4A803E07.7080407@redhat.com> <4A8051F3.7040400@codemonkey.ws>
	<20090814081518.GA7418@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090814081518.GA7418@amit-x200.redhat.com>
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
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Anthony Liguori <anthony@codemonkey.ws>, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

On 08/14/09 10:15, Amit Shah wrote:
> The guest code sort-of ends up looking like this after merging
> virtio_console into virtio_serial.

I think it should better go the other way around: add multichannel 
support to virtio-concole, probably guarded by a feature flag so old 
host+new guest and new host+old guest combinations continue to work.

> Since there's support for only one console as of now, I've assigned port
> #2 as the console port so that we hook into hvc when a port is found at
> that location.

Doesn't sound like this is going to be backward compatible ...

Also I still think passing a 'protocol' string for each port is a good 
idea, so you can stick that into a sysfs file for guests use.

Note it is probably easy to make virtio-console support multiple hvc 
lines by having one protocol for that (named 'console' for example).

cheers,
   Gerd
