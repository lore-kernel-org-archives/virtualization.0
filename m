From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Mon, 23 Jan 2012 09:23:55 +1030
Message-ID: <87aa5fgxh8.fsf@rustcorp.com.au>
References: <4F0DB2AB.8030506@codemonkey.ws>
	<20120111170859.GA22310@redhat.com>
	<4F0DE62F.6030805@codemonkey.ws>
	<20120111201436.GA27292@redhat.com>
	<4F0DF08F.7010706@codemonkey.ws>
	<1326315726.23910.143.camel@pasglop>
	<20120111220232.GC27292@redhat.com>
	<87wr8x4rye.fsf@rustcorp.com.au>
	<20120113021930.GA15379@redhat.com>
	<1326421962.23910.228.camel@pasglop>
	<20120118152949.GA2665@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120118152949.GA2665@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Pawel Moll <pawel.moll@arm.com>, Sasha Levin <levinsasha928@gmail.com>, Anthony Liguori <anthony@codemonkey.ws>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 18 Jan 2012 17:29:49 +0200, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Fri, Jan 13, 2012 at 01:32:42PM +1100, Benjamin Herrenschmidt wrote:
> > Your interrupt may take an unpredictable amount of time to arrive, I
> > don't see how you can use that as a guarantee.
> 
> In theory yes.
> Practically, under current KVM, what would delay it?

Indeed, if we're talking about a bandaid, this is fine.  For the config
change, I do think we need something more robust.

Thanks,
Rusty.
