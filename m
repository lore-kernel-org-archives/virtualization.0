From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 4/5] x86: use mb() around clflush
Date: Thu, 28 Jan 2016 19:25:41 +0100
Message-ID: <20160128182541.GW6356__32722.3839740784$1454005580$gmane$org@twins.programming.kicks-ass.net>
References: <1453921746-16178-1-git-send-email-mst@redhat.com>
	<1453921746-16178-5-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1453921746-16178-5-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Len Brown <len.brown@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Davidlohr Bueso <dbueso@suse.de>, Mike Galbraith <bitbucket@online.de>, the arch/x86 maintainers <x86@kernel.org>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 28, 2016 at 07:02:51PM +0200, Michael S. Tsirkin wrote:
> commit f8e617f4582995f7c25ef25b4167213120ad122b ("sched/idle/x86:
> Optimize unnecessary mwait_idle() resched IPIs") adds
> memory barriers around clflush, but this seems wrong
> for UP since barrier() has no effect on clflush.
> We really want mfence so switch to mb() instead.
> 
> Cc: Mike Galbraith <bitbucket@online.de>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
