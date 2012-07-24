From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: [RFC PATCH 0/6] virtio-trace: Support virtio-trace
Date: Tue, 24 Jul 2012 12:27:27 +0900
Message-ID: <500E161F.5020207__37711.13608168$1343147613$gmane$org@hitachi.com>
References: <20120724023657.6600.52706.stgit@ltc189.sdl.hitachi.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120724023657.6600.52706.stgit@ltc189.sdl.hitachi.co.jp>
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>, qemu-devel@nongnu.org, Frederic Weisbecker <fweisbec@gmail.com>, yrl.pp-manager.tt@hitachi.com, linux-kernel@vger.kernel.org, Borislav Petkov <bp@amd64.org>, virtualization@lists.linux-foundation.org, "Franch Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt <rostedt@goodmis.org>, Anthony Liguori <anthony@codemonkey.ws>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

(2012/07/24 11:36), Yoshihiro YUNOMAE wrote:
> Therefore, we propose a new system "virtio-trace", which uses enhanced
> virtio-serial and existing ring-buffer of ftrace, for collecting guest kernel
> tracing data. In this system, there are 5 main components:
>  (1) Ring-buffer of ftrace in a guest
>      - When trace agent reads ring-buffer, a page is removed from ring-buffer.
>  (2) Trace agent in the guest
>      - Splice the page of ring-buffer to read_pipe using splice() without
>        memory copying. Then, the page is spliced from write_pipe to virtio
>        without memory copying.
>  (3) Virtio-console driver in the guest
>      - Pass the page to virtio-ring
>  (4) Virtio-serial bus in QEMU
>      - Copy the page to kernel pipe
>  (5) Reader in the host
>      - Read guest tracing data via FIFO(named pipe)

So, this is our answer for the argued points in previous thread.
This virtio-serial and ftrace enhancements doesn't introduce new
"ringbuffer" in the kernel, and just use virtio's ringbuffer.
Also, using splice gives us a great advantage in the performance
because of copy-less trace-data transfer.

Actually, one copy should occur in the host (to write it into the pipe),
because removing physical pages of the guest is hard to track and may
involve a TLB flush per page, even if it is done in background.

Thank you,

-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com
