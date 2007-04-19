From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: [PATCH 10/28] i386: map enough initial memory to create lowmem
 mappings
Date: Thu, 19 Apr 2007 16:47:56 -0400
Message-ID: <4627D57C.4070809@redhat.com>
References: <20070414204154.871250608@goop.org>
	<20070414204924.125386443@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070414204924.125386443@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> head.S creates the very initial pagetable for the kernel.  This just
> maps enough space for the kernel itself, and an allocation bitmap.
> The amount of mapped memory is rounded up to 4Mbytes, and so this
> typically ends up mapping 8Mbytes of memory.
> 
> When booting, pagetable_init() needs to create mappings for all
> lowmem, and the pagetables for these mappings are allocated from the
> free pages around the kernel in low memory.  If the number of
> pagetable pages + kernel size exceeds head.S's initial mapping, it
> will end up faulting on an unmapped page.  This will only happen with
> specific combinations of kernel size and memory size.
> 
> This patch makes sure that head.S also maps enough space to fit the
> kernel pagetables as well as the kernel itself.  It ends up using an
> additional two pages of unreclaimable memory.
> 
> Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
> Acked-by: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Andi Kleen <ak@suse.de>
> Cc: Zachary Amsden <zach@vmware.com>
> Cc: Chris Wright <chrisw@sous-sol.org>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>,

Is some version of this going in for 2.6.21, or is it not a real problem?
