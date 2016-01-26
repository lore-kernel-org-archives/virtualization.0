From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 0/4] x86: faster mb()+documentation tweaks
Date: Tue, 26 Jan 2016 10:23:00 +0200
Message-ID: <20160126102022-mutt-send-email-mst@redhat.com>
References: <1452715911-12067-1-git-send-email-mst@redhat.com>
	<20160114113934.GC19941@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160114113934.GC19941@pd.tnic>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Borislav Petkov <bp@alien8.de>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Davidlohr Bueso <dbueso@suse.de>, Peter Zijlstra <peterz@infradead.org>, the arch/x86 maintainers <x86@kernel.org>, linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 14, 2016 at 12:39:34PM +0100, Borislav Petkov wrote:
> > Michael S. Tsirkin (4):
> >   x86: add cc clobber for addl
> >   x86: drop a comment left over from X86_OOSTORE
> >   x86: tweak the comment about use of wmb for IO
> 
> First three look ok to me regardless of what happens with 4. So applied.

Sorry - in which tree are these applied?
Thanks,

-- 
MST
