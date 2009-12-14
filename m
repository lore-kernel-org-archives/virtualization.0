From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] macvlan: add tap device backend
Date: Mon, 14 Dec 2009 13:00:36 +0100
Message-ID: <200912141300.37063.arnd__22854.3985206217$1260792787$gmane$org@arndb.de>
References: <1259862720-28432-1-git-send-email-arnd@arndb.de>
	<1259862720-28432-3-git-send-email-arnd@arndb.de>
	<20091212084112.GA8948@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091212084112.GA8948@gondor.apana.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Edge Virtual Bridging <evb@yahoogroups.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Fischer,
	Anna" <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org, Stephen Hemminger <shemminger@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Saturday 12 December 2009, Herbert Xu wrote:
> On Thu, Dec 03, 2009 at 06:52:00PM +0100, Arnd Bergmann wrote:
> > This is a second prototype of a new interface into the network
> > stack, to eventually replace tun/tap and the bridge driver
> > in certain virtual machine setups. The code has changed
> > significantly, but the goals still remain.
> 
> The idea looks pretty sound to me.

Thanks!

> > I'm posting this mainly to solicit feedback. Not sure how
> > chances for integration into 2.6.33 are, given that the merge
> > window is opening already.
> 
> It's way too late for 2.6.33.  But the earlier this becomes ready
> then the earlier it can go into linux-next.

Right. Since the code is basically working (I have two known bugs
I'm still working on) and people want to test it, what is the
best path? I could
a) keep my git tree for myself,
b) have it added to linux-next,
c) prepare a combined patch for net-next.git, or
d) have it added to drivers/staging

	Arnd
