From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] virtio_console: Stop doing DMA on the stack
Date: Thu, 8 Sep 2016 08:49:43 +0200
Message-ID: <20160908064943.GA25876__16662.7385108315$1473317397$gmane$org@gmail.com>
References: <0afe68f9b4be6c95af9e7672b07acd0274c26dfe.1472569320.git.luto@kernel.org>
	<20160906070343.GD3100@amit-lp.rh>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160906070343.GD3100@amit-lp.rh>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: x86@kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


* Amit Shah <amit.shah@redhat.com> wrote:

> On (Tue) 30 Aug 2016 [08:04:15], Andy Lutomirski wrote:
> > virtio_console uses a small DMA buffer for control requests.  Move
> > that buffer into heap memory.
> > 
> > Doing virtio DMA on the stack is normally okay on non-DMA-API virtio
> > systems (which is currently most of them), but it breaks completely
> > if the stack is virtually mapped.
> > 
> > Tested by typing both directions using picocom aimed at /dev/hvc0.
> > 
> > Signed-off-by: Andy Lutomirski <luto@kernel.org>
> 
> Looks fine,
> 
> Reviewed-by: Amit Shah <amit.shah@redhat.com>
> 
> > ---
> > 
> > Hi all-
> > 
> > This is currently broken in tip:x86/asm.  If you (Amit) like this patch,
> > would it make sense for Ingo to add it to -tip?
> 
> Yes, I'm fine with that.

Thanks! FYI, this patch now lives as:

  9472fe7040bb ("virtio_console: Stop doing DMA on the stack")

in tip:x86/asm, and is targeted for a v4.9 merge.

Thanks,

	Ingo
