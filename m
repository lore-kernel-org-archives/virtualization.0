From: Amit Shah <amit.shah@redhat.com>
Subject: Re: Re: [RFC PATCH 0/6] virtio-trace: Support virtio-trace
Date: Fri, 27 Jul 2012 15:13:20 +0530
Message-ID: <20120727094320.GK18651@amit.redhat.com>
References: <20120724023657.6600.52706.stgit@ltc189.sdl.hitachi.co.jp>
	<20120726113537.GH9473@amit.redhat.com>
	<5012576F.7040500@hitachi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5012576F.7040500@hitachi.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Frederic Weisbecker <fweisbec@gmail.com>, qemu-devel@nongnu.org, Borislav Petkov <bp@amd64.org>, linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.hengli.com.au>, "Franch Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt <rostedt@goodmis.org>, Anthony Liguori <anthony@codemonkey.ws>, yrl.pp-manager.tt@hitachi.com, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Fri) 27 Jul 2012 [17:55:11], Yoshihiro YUNOMAE wrote:
> Hi Amit,
> 
> Thank you for commenting on our work.
> 
> (2012/07/26 20:35), Amit Shah wrote:
> >On (Tue) 24 Jul 2012 [11:36:57], Yoshihiro YUNOMAE wrote:
> 
> [...]
> 
> >>
> >>Therefore, we propose a new system "virtio-trace", which uses enhanced
> >>virtio-serial and existing ring-buffer of ftrace, for collecting guest kernel
> >>tracing data. In this system, there are 5 main components:
> >>  (1) Ring-buffer of ftrace in a guest
> >>      - When trace agent reads ring-buffer, a page is removed from ring-buffer.
> >>  (2) Trace agent in the guest
> >>      - Splice the page of ring-buffer to read_pipe using splice() without
> >>        memory copying. Then, the page is spliced from write_pipe to virtio
> >>        without memory copying.
> >
> >I really like the splicing idea.
> 
> Thanks. We will improve this patch set.
> 
> >>  (3) Virtio-console driver in the guest
> >>      - Pass the page to virtio-ring
> >>  (4) Virtio-serial bus in QEMU
> >>      - Copy the page to kernel pipe
> >>  (5) Reader in the host
> >>      - Read guest tracing data via FIFO(named pipe)
> >
> >So will this be useful only if guest and host run the same kernel?
> >
> >I'd like to see the host kernel not being used at all -- collect all
> >relevant info from the guest and send it out to qemu, where it can be
> >consumed directly by apps driving the tracing.
> 
> No, this patch set is used only for guest kernels, so guest and host
> don't need to run the same kernel.

OK - that's good to know.

> >>***Evaluation***
> >>When a host collects tracing data of a guest, the performance of using
> >>virtio-trace is compared with that of using native(just running ftrace),
> >>IVRing, and virtio-serial(normal method of read/write).
> >
> >Why is tracing performance-sensitive?  i.e. why try to optimise this
> >at all?
> 
> To minimize effects for applications on guests when a host collects
> tracing data of guests.
> For example, we assume the situation where guests A and B are running
> on a host sharing I/O device. An I/O delay problem occur in guest A,
> but it doesn't for the requirement in guest B. In this case, we need to
> collect tracing data of guests A and B, but a usual method using
> network takes high load for applications of guest B even if guest B is
> normally running. Therefore, we try to decrease the load on guests.
> We also use this feature for performance analysis on production
> virtualization systems.

OK, got it.

> 
> [...]
> 
> >>
> >>***Just enhancement ideas***
> >>  - Support for trace-cmd
> >>  - Support for 9pfs protocol
> >>  - Support for non-blocking mode in QEMU
> >
> >There were patches long back (by me) to make chardevs non-blocking but
> >they didn't make it upstream.  Fedora carries them, if you want to try
> >out.  Though we want to converge on a reasonable solution that's
> >acceptable upstream as well.  Just that no one's working on it
> >currently.  Any help here will be appreciated.
> 
> Thanks! In this case, since a guest will stop to run when host reads
> trace data of the guest, char device is needed to add a non-blocking
> mode. I'll read your patch series. Is the latest version 8?
> http://lists.gnu.org/archive/html/qemu-devel/2010-12/msg00035.html

I suppose the latest version on-list is what you quote above.  The
objections to the patch series are mentioned in Anthony's mails.

Hans maintains a rebased version of the patches in his tree at

http://cgit.freedesktop.org/~jwrdegoede/qemu/

those patches are included in Fedora's qemu-kvm, so you can try that
out if it improves performance for you.

> >>  - Make "vhost-serial"
> >
> >I need to understand a) why it's perf-critical, and b) why should the
> >host be involved at all, to comment on these.
> 
> a) To make collecting overhead decrease for application on a guest.
>    (see above)
> b) Trace data of host kernel is not involved even if we introduce this
>    patch set.

I see, so you suggested vhost-serial only because you saw the guest
stopping problem due to the absence of non-blocking code?  If so, it
now makes sense.  I don't think we need vhost-serial in any way yet.

BTW where do you parse the trace data obtained from guests?  On a
remote host?

Thanks,
		Amit
