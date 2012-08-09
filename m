From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 2/6] virtio/console: Add a failback for unstealable
	pipe buffer
Date: Thu, 09 Aug 2012 08:35:32 -0400
Message-ID: <1344515732.6935.30.camel__8573.52393582023$1344515751$gmane$org@gandalf.stny.rr.com>
References: <20120724023657.6600.52706.stgit@ltc189.sdl.hitachi.co.jp>
	<20120724023718.6600.68836.stgit@ltc189.sdl.hitachi.co.jp>
	<20120809090312.GH3280@amit.redhat.com> <502381EA.80805@hitachi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <502381EA.80805@hitachi.com>
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
Cc: Arnd Bergmann <arnd@arndb.de>, qemu-devel@nongnu.org, Frederic Weisbecker <fweisbec@gmail.com>, yrl.pp-manager.tt@hitachi.com, linux-kernel@vger.kernel.org, Borislav Petkov <bp@amd64.org>, virtualization@lists.linux-foundation.org, Herbert Xu <herbert@gondor.hengli.com.au>, "Franch Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Anthony Liguori <anthony@codemonkey.ws>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2012-08-09 at 18:24 +0900, Masami Hiramatsu wrote:

> Yeah, it is really easy to fix that.
> But out of curiosity, would that be really a problem?
> I guess that host can access any guest page if need. If that
> is right, is that really insecure to leak randomly allocated
> unused page to the host?

Yeah, it's like protecting userspace pages from the kernel ;-)

-- Steve
