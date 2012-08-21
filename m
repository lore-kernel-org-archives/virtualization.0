From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [RFC PATCH 0/6] virtio-trace: Support virtio-trace
Date: Tue, 21 Aug 2012 10:39:05 +0530
Message-ID: <20120821050905.GE29197@amit.redhat.com>
References: <20120724023657.6600.52706.stgit@ltc189.sdl.hitachi.co.jp>
	<20120809101620.GN3280@amit.redhat.com>
	<87393h3s5v.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87393h3s5v.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Arnd Bergmann <arnd@arndb.de>, qemu-devel@nongnu.org, Frederic Weisbecker <fweisbec@gmail.com>, yrl.pp-manager.tt@hitachi.com, linux-kernel@vger.kernel.org, Borislav Petkov <bp@amd64.org>, virtualization@lists.linux-foundation.org, Herbert Xu <herbert@gondor.hengli.com.au>, "Franch Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt <rostedt@goodmis.org>, Anthony Liguori <anthony@codemonkey.ws>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Tue) 21 Aug 2012 [11:47:16], Rusty Russell wrote:
> On Thu, 9 Aug 2012 15:46:20 +0530, Amit Shah <amit.shah@redhat.com> wrote:
> > Hi,
> > 
> > On (Tue) 24 Jul 2012 [11:36:57], Yoshihiro YUNOMAE wrote:
> > > Hi All,
> > > 
> > > The following patch set provides a low-overhead system for collecting kernel
> > > tracing data of guests by a host in a virtualization environment.
> > 
> > So I just have one minor comment, please post a non-RFC version of the
> > patch.
> > 
> > Since you have an ACK from Steven for the ftrace patch, I guess Rusty
> > can push this in via his virtio tree?
> > 
> > I'll ack the virtio-console bits in the next series you send.
> 
> You didn't Ack, BTW.  At least, AFAICT.

Ah, sorry.  Will do that now.

		Amit
