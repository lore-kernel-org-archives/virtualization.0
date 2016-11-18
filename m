From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/3] virtio: Basic implementation of virtio pstore driver
Date: Fri, 18 Nov 2016 06:07:59 +0200
Message-ID: <20161118060649-mutt-send-email-mst__38414.0194896192$1479442091$gmane$org@kernel.org>
References: <20160820080744.10344-1-namhyung@kernel.org>
	<20161110182611-mutt-send-email-mst@kernel.org>
	<20161115045021.GA15992@danjae.aot.lge.com>
	<20161115065658-mutt-send-email-mst@kernel.org>
	<f514ac65-3105-a12c-9e10-2d3b1e8a0516@redhat.com>
	<20161115143629.GA29740@danjae.aot.lge.com>
	<a6fc0acb-6ecc-a184-9e06-e76c7398fc08@redhat.com>
	<CAM9d7cj8CxS77WC-7O7fRX1s0sqTZqJo=ZHseN-hc2jpE8QD2Q@mail.gmail.com>
	<1627682877.13077005.1479298236793.JavaMail.zimbra@redhat.com>
	<20161118033206.GA15698@danjae.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20161118033206.GA15698@danjae.aot.lge.com>
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
Cc: virtio-dev@lists.oasis-open.org, Tony Luck <tony.luck@intel.com>, Kees Cook <keescook@chromium.org>, KVM <kvm@vger.kernel.org>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Anton Vorontsov <anton@enomsg.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, qemu-devel <qemu-devel@nongnu.org>, Minchan Kim <minchan@kernel.org>, Anthony Liguori <aliguori@amazon.com>, Colin Cross <ccross@android.com>, Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 18, 2016 at 12:32:06PM +0900, Namhyung Kim wrote:
> Btw I prefer using the kvmtool for my kernel work since it's much more
> simpler..
> 
> Thanks,
> Namhyung

Up to you but then you should extend that to support 1.0 spec.
I strongly object to adding to the list of legacy interfaces
we need to maintain.

-- 
MST
