From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: Re: [RFC PATCH 0/6] virtio-trace: Support virtio-trace
Date: Tue, 24 Jul 2012 14:43:43 +0100
Message-ID: <CAJSP0QVU3_Y-ASC+G4pgGpBzym3+PZPD=adbYHVB5Uxs5kTr5g@mail.gmail.com>
References: <20120724023657.6600.52706.stgit@ltc189.sdl.hitachi.co.jp>
	<CAJSP0QW_2JJ0nf=NW0y30VSid2HSxaqb=mRGV8CTtAKj0ujDWw@mail.gmail.com>
	<500E810A.4030309@hitachi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <500E810A.4030309@hitachi.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Frederic Weisbecker <fweisbec@gmail.com>, Dhaval Giani <dhaval.giani@gmail.com>, linux-kernel@vger.kernel.org, Borislav Petkov <bp@amd64.org>, qemu-devel@nongnu.org, "Franch Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt <rostedt@goodmis.org>, Anthony Liguori <anthony@codemonkey.ws>, yrl.pp-manager.tt@hitachi.com, Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org, Srikar Dronamraju <srikar@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 24, 2012 at 12:03 PM, Masami Hiramatsu
<masami.hiramatsu.pt@hitachi.com> wrote:
> (2012/07/24 19:02), Stefan Hajnoczi wrote:
>> On Tue, Jul 24, 2012 at 3:36 AM, Yoshihiro YUNOMAE
>> <yoshihiro.yunomae.ez@hitachi.com> wrote:
>>> The performance of each method is compared as follows:
>>>  [1] Native
>>>      - only recording trace data to ring-buffer on a guest
>>>  [2] Virtio-trace
>>>      - running a trace agent on a guest
>>>      - a reader on a host opens FIFO using cat command
>>>  [3] IVRing
>>>      - A SystemTap script in a guest records trace data to IVRing.
>>>        -- probe points are same as ftrace.
>>>  [4] Virtio-serial(normal)
>>>      - A reader(using cat) on a guest output trace data to a host using
>>>        standard output via virtio-serial.
>>
>> The first time I read this I thought you are adding a new virtio-trace
>> device.  But it looks like this series really add splice support to
>> virtio-console and that yields a big performance improvement when
>> sending trace_pipe_raw.
>
> Yes, sorry for the confusion. Actually this is an enhancement of
> virtio-serial. I'm working with Yoshihiro on this feature.
>
>> Guest ftrace is useful and I like this.  Have you thought about
>> controlling ftrace from the host?  Perhaps a command could be added to
>> the QEMU guest agent which basically invokes trace-cmd/perf.
>
> As you can see, guest trace-agent can be controlled via a
> control channel. In our scenario, host tools can control that
> instead of guest one.
>
> We are considering that exporting the tracing part of guest's
> debugfs to host via another virtio-serial channel by using
> 9pfs, so that the host tools can refer that.
>
> (In this scenario, guest trace-agent will also provide 9pfs server.
> Since it means that the agent can handle writing a special file,
> trace-agent can be controlled via the special file on exported
> debugfs.)
>
> Of course, this also requires modifying trace-cmd/perf to accept
> some options like guest-debugfs mount point, guest's serial
> channel pipe (or unix socket?), etc. However, it will be a small
> change.

Okay, thanks for explaining some of the ideas you have.  I won't ask
more because it's out of scope for this patch series :).

Stefan
