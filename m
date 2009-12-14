From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] macvlan: add tap device backend
Date: Mon, 14 Dec 2009 16:40:13 +0100
Message-ID: <200912141640.13562.arnd__5431.57203724167$1260805384$gmane$org@arndb.de>
References: <1259862720-28432-1-git-send-email-arnd@arndb.de>
	<1259862720-28432-3-git-send-email-arnd@arndb.de>
	<4B26353A.9020005@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4B26353A.9020005@trash.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Patrick McHardy <kaber@trash.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "Michael S. Tsirkin" <mst@redhat.com>, "Fischer,
	Anna" <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemonkey.ws>, Edge Virtual Bridging <evb@yahoogroups.com>, Stephen Hemminger <shemminger@linux-foundation.org>, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Monday 14 December 2009, Patrick McHardy wrote:
> > +     classdev = device_create(macvtap_class, &dev->dev, devt,
> > +                              dev, "tap%d", dev->ifindex);
> > +     if (IS_ERR(classdev)) {
> > +             err = PTR_ERR(classdev);
> > +             macvtap_del_queues(dev);
> > +             macvlan_dellink(dev, NULL);
> 
> I think this may cause a double free since macvlan_dellink() will
> free the device and rtnl_newlink() will free it again on error.

Ah, right. I've changed this part a few times now, but I think introduced
the same bug again in the current version. I'll send out what I have now
if you want to take another look.

	Arnd
