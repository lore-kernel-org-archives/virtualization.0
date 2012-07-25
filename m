From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: Re: [Qemu-devel] [RFC PATCH 0/6] virtio-trace: Support
	virtio-trace
Date: Wed, 25 Jul 2012 17:15:47 +0900
Message-ID: <500FAB33.4060301@hitachi.com>
References: <20120724023657.6600.52706.stgit@ltc189.sdl.hitachi.co.jp>
	<CAAu8pHsfRBsfSCB5gBFX5pweN2j2PdNrQZyCfjJ3sYYmVjCRfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAAu8pHsfRBsfSCB5gBFX5pweN2j2PdNrQZyCfjJ3sYYmVjCRfA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Blue Swirl <blauwirbel@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, Borislav Petkov <bp@amd64.org>, qemu-devel@nongnu.org, "Franch Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt <rostedt@goodmis.org>, Anthony Liguori <anthony@codemonkey.ws>, yrl.pp-manager.tt@hitachi.com, Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

(2012/07/25 5:26), Blue Swirl wrote:>
>> The following patch set provides a low-overhead system for collecting kernel
>> tracing data of guests by a host in a virtualization environment.
>>
>> A guest OS generally shares some devices with other guests or a host, so
>> reasons of any problems occurring in a guest may be from other guests or a
>> host.
>> Then, to collect some tracing data of a number of guests and a host is needed
>> when some problems occur in a virtualization environment. One of methods to
>> realize that is to collect tracing data of guests in a host. To do this,
>> network
>> is generally used. However, high load will be taken to applications on guests
>> using network I/O because there are many network stack layers. Therefore,
>> a communication method for collecting the data without using network is
>> needed.
>
> I implemented something similar earlier by passing trace data from
> OpenBIOS to QEMU using the firmware configuration device. The data
> format was the same as QEMU used for simpletrace event structure
> instead of ftrace. I didn't commit it because of a few problems.

Sounds interesting :)
I guess you traced BIOS events, right?

> I'm not familiar with ftrace, is it possible to trace two guest
> applications (BIOS and kernel) at the same time?

Since ftrace itself is a tracing feature in the linux kernel, it
can trace two or more applications (processes) if those run on linux
kernel. However, I think OpenBIOS runs *under* the guest kernel.
If so, ftrace currently can't trace OpenBIOS from guest side.

I think it may need another enhancement on both OpenBIOS and linux
kernel to trace BIOS event from linux kernel.

> Or could this be
> handled by opening two different virtio-serial pipes, one for BIOS and
> the other for the kernel?

Of course, virtio-serial itself can open multiple channels, thus, if
OpenBIOS can handle virtio, it can pass trace data via another
channel.

> In my version, the tracepoint ID would have been used to demultiplex
> QEMU tracepoints from BIOS tracepoints, but something like separate ID
> spaces would have been better.

I guess your feature notifies events to QEMU and QEMU records that in
their own buffer. Therefore it must have different tracepoint IDs.
On the other hand, with this feature, QEMU just passes trace-data to
host-side pipe. Since outer tracing tool separately collects trace
data, we don't need to demultiplex the data.

Perhaps, in the analyzing phase (after tracing), we have to mix events
again. At that time, we'll add some guest-ID for each event-ID, but
it can be done offline.

Best Regards,

-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com
