From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-rng: Remove false BUG for spurious callbacks
Date: Sun, 26 Apr 2009 22:30:36 +0930
Message-ID: <200904262230.37157.rusty@rustcorp.com.au>
References: <200904231642.59939.rusty@rustcorp.com.au>
	<alpine.LFD.2.00.0904240822410.3101@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0904240822410.3101@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, stable@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 25 Apr 2009 12:53:12 am Linus Torvalds wrote:
> 
> On Thu, 23 Apr 2009, Rusty Russell wrote:
> >
> > From: Christian Borntraeger <borntraeger@de.ibm.com>
> > 
> > The virtio-rng drivers checks for spurious callbacks. Since
> > callbacks can be implemented via shared interrupts (e.g. PCI) this
> > could lead to guest kernel oopses with lots of virtio devices.
> > 
> > Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > ---
> 
> I really would have liked a sign-off from you too, rusty. I'll take it 
> as-is, since it's trivial, but just a note..

Sorry, missed that one.

Thanks for the reminder,
Rusty.
