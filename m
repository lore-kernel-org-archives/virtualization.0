From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC 1/4] New virtio bus driver
Date: Mon, 09 Jul 2007 09:42:13 +1000
Message-ID: <1183938133.6005.372.camel@localhost.localdomain>
References: <20070706124200.988637662@arndb.de>
	<200707081729.58461.arnd@arndb.de> <4691076B.5050106@qumranet.com>
	<200707082229.00810.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200707082229.00810.arnd@arndb.de>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2007-07-08 at 22:29 +0200, Arnd Bergmann wrote:
> On Sunday 08 July 2007, Avi Kivity wrote:
> 
> > > Alternatively, we could have a mechanism separate from the
> > > virtqueue concept, like a synchronous get_config_data/set_config_data
> > > callback into the host driver.
> > >   
> > 
> > You also need to allow the host to notify the guest about configuration 
> > changes.
> 
> That is much harder to do, it would require a separate interrupt if you
> want to have a device independent mechanism.

See, I was going to have a "virtblk_device_change()" entry point and
leave others to solve the problem of how to connect it up...

TBH I think it's a little early to design the One True Bus: I'm just not
smart enough to see so far ahead.  When we have a bundle of devices
which support a most of the functionality we want, I think we'll have a
better idea of how to encapsulate it.

(That said, I love that Arnd is thinking about this now: it will make it
much easier when we do reach that point).

Cheers,
Rusty.
