From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Thu, 12 Jan 2012 12:12:17 +1030
Message-ID: <87wr8x4rye.fsf@rustcorp.com.au>
References: <4F0DA7A5.7050600@codemonkey.ws>
	<20120111152129.GB20570@redhat.com>
	<4F0DAA9B.7060703@codemonkey.ws>
	<20120111154515.GD20570@redhat.com>
	<4F0DB2AB.8030506@codemonkey.ws>
	<20120111170859.GA22310@redhat.com>
	<4F0DE62F.6030805@codemonkey.ws>
	<20120111201436.GA27292@redhat.com>
	<4F0DF08F.7010706@codemonkey.ws>
	<1326315726.23910.143.camel@pasglop>
	<20120111220232.GC27292@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120111220232.GC27292@redhat.com>
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

On Thu, 12 Jan 2012 00:02:33 +0200, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> Look, we have a race currently. Let us not tie a bug fix to a huge
> rewrite with unclear performance benefits, please.

In theory, yes.  In practice, we bandaid it.

I think in the short term we change ->get to get the entire sequence
twice, and check it's the same.  Theoretically, still racy, but it does
cut the window.  And we haven't seen the bug yet, either.

In the longer term, we fix it properly:

1) Make it readonly, prevents one class of problems.
2) Treat it as constant if drv->config_changed is NULL (we can do this
   now, in fact) and ignore the config interrupt.
3) Use a generation counter on the config, odd means wait.

Cheers,
Rusty.
