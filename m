From: David Miller <davem@davemloft.net>
Subject: Re: TUN_F_UFO change breaks live migration
Date: Tue, 11 Nov 2014 11:38:43 -0500 (EST)
Message-ID: <20141111.113843.1982180667154844491.davem@davemloft.net>
References: <20141111105849.GA8482@stefanha-thinkpad.redhat.com>
	<1415708246.3398.88.camel@decadent.org.uk>
	<20141111155750.GA17418@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141111155750.GA17418@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com, jelledejong@powercraft.nl, ben@decadent.org.uk
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Tue, 11 Nov 2014 17:57:50 +0200

> Basically userspace assumed that features will only
> ever be added, never removed, so this change is
> breaking it.

I essentially agree.

We can't just toss feature bits like this which have been present for so
long.

"There is no way I can figure out how to easily make it work" is not an
excuse for breaking existing userspace like this.
