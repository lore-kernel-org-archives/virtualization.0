From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: Re: [PATCH V2 0/6] virtio-trace: Support virtio-trace
Date: Tue, 21 Aug 2012 21:33:12 +0900
Message-ID: <50338008.6000708@hitachi.com>
References: <20120809123029.8542.38311.stgit@ltc189.sdl.hitachi.co.jp>
	<20120821051619.GF29197@amit.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120821051619.GF29197@amit.redhat.com>
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
Cc: Arnd Bergmann <arnd@arndb.de>, qemu-devel@nongnu.org, Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, Borislav Petkov <bp@amd64.org>, virtualization@lists.linux-foundation.org, Herbert Xu <herbert@gondor.hengli.com.au>, "Franch Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt <rostedt@goodmis.org>, Anthony Liguori <anthony@codemonkey.ws>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, yrl.pp-manager.tt@hitachi.com
List-Id: virtualization@lists.linuxfoundation.org

(2012/08/21 14:16), Amit Shah wrote:
> On (Thu) 09 Aug 2012 [21:30:29], Yoshihiro YUNOMAE wrote:
>> Hi All,
>>
>> The following patch set provides a low-overhead system for collecting kernel
>> tracing data of guests by a host in a virtualization environment.
> 
> ACK this series.

Thank you!

> I ran it through the virtio-serial test suite, and there's no
> regression in existing functionality.
> 
> I encourage you to check out the virtio-serial test suite[1] as well
> as the virtio-serial unit tests in the autotest[2] code, and
> contribute to them to add tests for the new functionality you've
> added.

Ah, OK we'll look into them for adding some tests for
splice support :)

> 
> [1]
> http://fedorapeople.org/cgit/amitshah/public_git/test-virtserial.git/
> 
> [2]
> https://github.com/autotest/autotest/blob/e91cd67b845b291622c8d079a8289c4b0cb1e6ae/client/tests/kvm/tests/virtio_console.py
> 
> 

Thank you again,

-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com
