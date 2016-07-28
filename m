From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 6/7] qemu: Implement virtio-pstore device
Date: Thu, 28 Jul 2016 10:38:12 -0400
Message-ID: <20160728103812.41e02ae5__32479.2947307744$1469750838$gmane$org@gandalf.local.home>
References: <1469632111-23260-1-git-send-email-namhyung@kernel.org>
	<1469632111-23260-7-git-send-email-namhyung@kernel.org>
	<20160728023254-mutt-send-email-mst@kernel.org>
	<20160728053953.GB4371@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160728053953.GB4371@sejong>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: Anton Vorontsov <anton@enomsg.org>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Minchan Kim <minchan@kernel.org>, Tony Luck <tony.luck@intel.com>, Anthony Liguori <aliguori@amazon.com>, Colin Cross <ccross@android.com>, Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 28 Jul 2016 14:39:53 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> Well, I dont' know.  As you know, the kernel oops dump is already sent
> to serial device but it's rather slow.  As I wrote in the cover
> letter, enabling ftrace_dump_on_oops makes it even worse..  Also
> pstore saves the (compressed) binary data so I thought it'd be better
> to have a dedicated IO channel.

BTW, I agree with this. It is better to have a quick way to grab the
ftrace buffers when a crash happens, as serial is excruciatingly slow.
Although, currently I still use kexec/kdump, but as Namhyung said, it
depends on crash being up to date. I tend to be sending in updates
every time I have to use it.

-- Steve
