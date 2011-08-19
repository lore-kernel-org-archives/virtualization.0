From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC 0/0] Introducing a generic socket offload framework
Date: Fri, 19 Aug 2011 10:28:35 +0100
Message-ID: <20110819102835.0a6b2436__31780.5295614109$1313746338$gmane$org@lxorguk.ukuu.org.uk>
References: <20110818220756.5C93E5C80B@san.sea.corp.google.com>
	<20110818235719.50365b0b@lxorguk.ukuu.org.uk>
	<CAPi7mHqV6Pgk5tSt+fJn_2aEZKZbO=aO78JXgw7MvDaW0musoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAPi7mHqV6Pgk5tSt+fJn_2aEZKZbO=aO78JXgw7MvDaW0musoQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: San Mehat <san@google.com>
Cc: mst@redhat.com, netdev@vger.kernel.org, miche@google.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, digitaleric@google.com, mikew@google.com, maccarro@google.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

> I have no desire to change the 'genericness' of sockets.. just the
> opposite - i wish to
> introduce the notion that sockets (can be) completely generic (when
> offloaded) as far as
> the guest is concerned.

I suppose my concern is that you don't want to design for a specific
offload device, your offload might change but the view from the
application side should not differ.

> > This guest only view means you can't use the abstraction for local
> > sockets too.
> >
> 
> To be honest, the way we're attempting to integrate is in such a way
> that you *could*
> offload AF_LOCAL sockets...  but that world gets a bit too much like
> the 'Twilight Zone'
> for my current linkings..

Until you want to be able to have a pair of apps talking that may or may
not be on different systems and may or may not be on a vm host at all, at
which point having the same acceleration between them (a null accelerator
so to speak) would avoid having to add extra paths to the apps.

> > And yes there is still the complicated cases such as 'the routing table
> > has changed from vitual host to via siberia now what' but I don't believe
> > your proposal addresses that either.
> 
> Can you be more specific? If you mean solving the 'keeping your tcp connections
> open to non virtual endpoints across a migration (or whatever)' then
> no it doesn't :)

That was my assumption.
