From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv2 0/2] vhost: a kernel-level virtio server
Date: Wed, 12 Aug 2009 14:52:01 +0200
Message-ID: <200908121452.01802.arnd__47179.7757469632$1250081693$gmane$org@arndb.de>
References: <20090811212743.GA26309@redhat.com>
	<20090812120541.GA29158@redhat.com> <4A82B87B.4010208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A82B87B.4010208@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gregory Haskins <gregory.haskins@gmail.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, hpa@zytor.com, Patrick Mullaney <pmullaney@novell.com>, mingo@elte.hu, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 12 August 2009, Gregory Haskins wrote:
> >> Are you saying SRIOV is a requirement, and I can either program the
> >> SRIOV adapter with a mac or use promis?  Or are you saying I can use
> >> SRIOV+programmed mac OR a regular nic + promisc (with a perf penalty).
> > 
> > SRIOV is not a requirement. And you can also use a dedicated
> > nic+programmed mac if you are so inclined.
> 
> Makes sense.  Got it.
> 
> I was going to add guest-to-guest to the test matrix, but I assume that
> is not supported with vhost unless you have something like a VEPA
> enabled bridge?
> 

If I understand it correctly, you can at least connect a veth pair
to a bridge, right? Something like

           veth0 - veth1 - vhost - guest 1 
eth0 - br0-|
           veth2 - veth3 - vhost - guest 2
          
It's a bit more complicated than it need to be, but should work fine.

	Arnd <><
