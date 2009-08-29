From: Jamie Lokier <jamie@shareable.org>
Subject: Re: [Qemu-devel] Re: Extending virtio_console to support multiple
	ports
Date: Sat, 29 Aug 2009 02:15:17 +0100
Message-ID: <20090829011517.GG8036__34946.8159176924$1251508695$gmane$org@shareable.org>
References: <1251181044-3696-1-git-send-email-amit.shah@redhat.com>
	<20090826112718.GA11117@amit-x200.redhat.com>
	<20090826154552.GA31910@amit-x200.redhat.com>
	<1251346023.20467.21.camel@pasglop>
	<20090827100809.5f0aa0a7@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090827100809.5f0aa0a7@linux.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alan Cox <alan@linux.intel.com>
Cc: kvm@vger.kernel.org, borntraeger@de.ibm.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-devel@nongnu.org, miltonm@bga.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, brueckner@linux.vnet.ibm.com, Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Alan Cox wrote:
> >  - Then, are we certain that there's no case where the tty layer will
> > call us with some lock held or in an atomic context ? To be honest,
> > I've totally lost track of the locking rules in tty land lately so it
> > might well be ok, but something to verify.
> 
> Some of the less well behaved line disciplines do this and always have
> done.

I had a backtrace in my kernel log recently which looked like that,
while doing PPP over Bluetooth RFCOMM.  Resulted in AppArmor
complaining that it's hook was being called in irq context.

-- Jamie
