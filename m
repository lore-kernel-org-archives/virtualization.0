From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC PATCH 0/6] virtio-trace: Support virtio-trace
Date: Tue, 24 Jul 2012 11:02:04 +0100
Message-ID: <CAJSP0QW_2JJ0nf=NW0y30VSid2HSxaqb=mRGV8CTtAKj0ujDWw@mail.gmail.com>
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Frederic Weisbecker <fweisbec@gmail.com>, Dhaval Giani <dhaval.giani@gmail.com>, qemu-devel@nongnu.org, Borislav Petkov <bp@amd64.org>, linux-kernel@vger.kernel.org, "Franch Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt <rostedt@goodmis.org>, Anthony Liguori <anthony@codemonkey.ws>, yrl.pp-manager.tt@hitachi.com, Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org, Srikar Dronamraju <srikar@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 24, 2012 at 3:36 AM, Yoshihiro YUNOMAE
<yoshihiro.yunomae.ez@hitachi.com> wrote:
> The performance of each method is compared as follows:
>  [1] Native
>      - only recording trace data to ring-buffer on a guest
>  [2] Virtio-trace
>      - running a trace agent on a guest
>      - a reader on a host opens FIFO using cat command
>  [3] IVRing
>      - A SystemTap script in a guest records trace data to IVRing.
>        -- probe points are same as ftrace.
>  [4] Virtio-serial(normal)
>      - A reader(using cat) on a guest output trace data to a host using
>        standard output via virtio-serial.

The first time I read this I thought you are adding a new virtio-trace
device.  But it looks like this series really add splice support to
virtio-console and that yields a big performance improvement when
sending trace_pipe_raw.

Guest ftrace is useful and I like this.  Have you thought about
controlling ftrace from the host?  Perhaps a command could be added to
the QEMU guest agent which basically invokes trace-cmd/perf.

Are you using text formatted ftrace?

Stefan
