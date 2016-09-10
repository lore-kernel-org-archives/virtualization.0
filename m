From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] virtio_console: Stop doing DMA on the stack
Date: Sat, 10 Sep 2016 06:33:48 +0200
Message-ID: <20160910043348.GA6061@gmail.com>
References: <0afe68f9b4be6c95af9e7672b07acd0274c26dfe.1472569320.git.luto@kernel.org>
	<20160906070343.GD3100@amit-lp.rh>
	<20160908064943.GA25876@gmail.com>
	<20160909210940-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160909210940-mutt-send-email-mst@kernel.org>
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
Cc: Amit Shah <amit.shah@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


* Michael S. Tsirkin <mst@redhat.com> wrote:

> On Thu, Sep 08, 2016 at 08:49:43AM +0200, Ingo Molnar wrote:
> > 
> > * Amit Shah <amit.shah@redhat.com> wrote:
> > 
> > > On (Tue) 30 Aug 2016 [08:04:15], Andy Lutomirski wrote:
> > > > virtio_console uses a small DMA buffer for control requests.  Move
> > > > that buffer into heap memory.
> > > > 
> > > > Doing virtio DMA on the stack is normally okay on non-DMA-API virtio
> > > > systems (which is currently most of them), but it breaks completely
> > > > if the stack is virtually mapped.
> > > > 
> > > > Tested by typing both directions using picocom aimed at /dev/hvc0.
> > > > 
> > > > Signed-off-by: Andy Lutomirski <luto@kernel.org>
> > > 
> > > Looks fine,
> > > 
> > > Reviewed-by: Amit Shah <amit.shah@redhat.com>
> > > 
> > > > ---
> > > > 
> > > > Hi all-
> > > > 
> > > > This is currently broken in tip:x86/asm.  If you (Amit) like this patch,
> > > > would it make sense for Ingo to add it to -tip?
> > > 
> > > Yes, I'm fine with that.
> > 
> > Thanks! FYI, this patch now lives as:
> > 
> >   9472fe7040bb ("virtio_console: Stop doing DMA on the stack")
> > 
> > in tip:x86/asm, and is targeted for a v4.9 merge.
> > 
> > Thanks,
> > 
> > 	Ingo
> 
> Thinking about it, maybe we should put it in 4.8
> after all, for benefit of systems using DMA API with virtio.
> Thoughts?

So CONFIG_VMAP_STACK=y is only going to be enabled for v4.9 - the enabling commit 
is part of tip:x86/asm as well. So AFAICS the commit is not strictly needed for 
v4.8.

Thanks,

	Ingo
