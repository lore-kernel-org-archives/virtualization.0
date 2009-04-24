From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] virtio-rng: Remove false BUG for spurious callbacks
Date: Fri, 24 Apr 2009 08:23:12 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904240822410.3101@localhost.localdomain>
References: <200904231642.59939.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200904231642.59939.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, stable@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



On Thu, 23 Apr 2009, Rusty Russell wrote:
>
> From: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> The virtio-rng drivers checks for spurious callbacks. Since
> callbacks can be implemented via shared interrupts (e.g. PCI) this
> could lead to guest kernel oopses with lots of virtio devices.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---

I really would have liked a sign-off from you too, rusty. I'll take it 
as-is, since it's trivial, but just a note..

		Linus
