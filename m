From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: vhost-net todo list
Date: Thu, 17 Sep 2009 14:47:40 +0300
Message-ID: <20090917114739.GD18916__18708.4724581384$1253188245$gmane$org@redhat.com>
References: <20090916100438.GA30036@redhat.com>
	<200909161727.26153.arnd@arndb.de>
	<20090916164509.GB6034@redhat.com>
	<200909171330.01414.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200909171330.01414.arnd@arndb.de>
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
Cc: kvm@vger.kernel.org, anthony@codemonkey.ws, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 17, 2009 at 01:30:00PM +0200, Arnd Bergmann wrote:
> On Wednesday 16 September 2009, Michael S. Tsirkin wrote:
> > > Also, I might not want to allow the user to open a
> > > random random raw socket, but only one on a specific downstream
> > > port of a macvlan interface, so I can filter out the data from
> > > that respective MAC address in an external switch.
> > 
> > I agree. Maybe we can fix that for raw sockets, want me to
> > add it to the list? :)
> 
> So far, I could not find any theoretical solution how to fix this,

What if socket had a LOCKBIND ioctl after which you can not bind it to
any other device?  Then someone with RAW capability can open the socket,
bind to device and hand it to you. You can send packets but not
switch to another device.


> but if you think it can be done, it would be good to have it on the
> list somewhere.
> 
> 	Arnd <><
