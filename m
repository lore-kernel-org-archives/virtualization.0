From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 0/3] x86: faster mb()+other barrier.h tweaks
Date: Tue, 26 Jan 2016 13:37:38 -0800
Message-ID: <56A7E722.7030701@zytor.com>
References: <1452635935-5439-1-git-send-email-mst@redhat.com>
	<56957D54.5000602@zytor.com>
	<20160126101921-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160126101921-mutt-send-email-mst@redhat.com>
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
Cc: Davidlohr Bueso <dave@stgolabs.net>, Davidlohr Bueso <dbueso@suse.de>, Peter Zijlstra <peterz@infradead.org>, the arch/x86 maintainers <x86@kernel.org>, linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 01/26/16 00:20, Michael S. Tsirkin wrote:
> On Tue, Jan 12, 2016 at 02:25:24PM -0800, H. Peter Anvin wrote:
> 
> Hi hpa,
> Any luck getting some feedback on this one?
> 

Yes.  What we know so far is that *most* cases it will work, but there
are apparently a few corner cases where MFENCE or a full-blown
serializing instruction is necessary.  We are trying to characterize
those corner cases and see if any of them affect the kernel.

Even if they are, we can probably make those barriers explicitly
different, but we don't want to go ahead with the change until we know
where we need to care.

	-hpa
