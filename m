From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv2 0/2] vhost: a kernel-level virtio server
Date: Wed, 12 Aug 2009 15:40:44 +0200
Message-ID: <200908121540.44928.arnd__7683.4935266108$1250084621$gmane$org@arndb.de>
References: <20090811212743.GA26309@redhat.com>
	<200908121452.01802.arnd@arndb.de>
	<20090812130612.GC29200@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090812130612.GC29200@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, hpa@zytor.com, Patrick Mullaney <pmullaney@novell.com>, mingo@elte.hu, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 12 August 2009, Michael S. Tsirkin wrote:
> > If I understand it correctly, you can at least connect a veth pair
> > to a bridge, right? Something like
> > 
> >            veth0 - veth1 - vhost - guest 1 
> > eth0 - br0-|
> >            veth2 - veth3 - vhost - guest 2
> >            
> Heh, you don't need a bridge in this picture:
> 
> guest 1 - vhost - veth0 - veth1 - vhost guest 2

Sure, but the setup I described is the one that I would expect
to see in practice because it gives you external connectivity.

Measuring two guests communicating over a veth pair is
interesting for finding the bottlenecks, but of little
practical relevance.

	Arnd <><
