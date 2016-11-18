From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/3] virtio: Basic implementation of virtio pstore driver
Date: Fri, 18 Nov 2016 10:45:12 +0100
Message-ID: <213903eb-5f1b-f38f-bd10-04402333777d__20830.9853835546$1479462333$gmane$org@redhat.com>
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
Cc: virtio-dev@lists.oasis-open.org, Tony Luck <tony.luck@intel.com>, Kees Cook <keescook@chromium.org>, KVM <kvm@vger.kernel.org>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, qemu-devel <qemu-devel@nongnu.org>, Minchan Kim <minchan@kernel.org>, Anton Vorontsov <anton@enomsg.org>, Anthony Liguori <aliguori@amazon.com>, Colin Cross <ccross@android.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org



On 18/11/2016 04:32, Namhyung Kim wrote:
>> In addition, the firmware will need to reserve a few KB of RAM for the error log
>> address range (I checked a real system and it reserves 8KB).  The first eight
>> bytes are needed for the record identifier interface, because there's no such
>> thing as 64-bit I/O ports, and the rest can be used for the actual buffer.
> 
> Is there a limit on the size?  It'd be great if it can use a few MB..

Yes, you can make it customizable.

>>> Also I need to control pstore driver like using bigger buffer,
>>> enabling specific message types and so on if ERST supports.  Is it
>>> possible for ERST to provide such information?
>>
>> It's the normal pstore driver, same as on a real server.  What exactly do you
>> need?
> 
> Well, I don't want to send additional pstore messages to the device if
> it cannot handle them properly - for example, ftrace message should not
> overwrite kmsg dump.  It'd be great if device somehow could expose
> acceptable message types to the driver IMHO.

This is something that you have to do in the usual kernel pstore
infrastructure.  It should not be specific to virtualization.

Paolo

> Btw I prefer using the kvmtool for my kernel work since it's much more
> simpler..
