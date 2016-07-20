From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 1/3] virtio: Basic implementation of virtio pstore driver
Date: Wed, 20 Jul 2016 21:56:19 +0900
Message-ID: <CAM9d7cinK951NOk3HBnmFbJEFYGSQoJQSHVrBZtfECFPXByXBg@mail.gmail.com>
References: <1468816661-6345-1-git-send-email-namhyung@kernel.org>
	<1468816661-6345-2-git-send-email-namhyung@kernel.org>
	<CAGXu5jL8frrV99QXrw4touwnXAX0pesxKJnq4Bd_2QZDip7K6Q@mail.gmail.com>
	<20160718055037.GA8051@danjae.aot.lge.com>
	<CAGXu5jJBM6GLwR6B28US11v90pFsiU2yJddm4V6kx3CHdLcOqQ@mail.gmail.com>
	<20160719134303.GA20047@danjae.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160719134303.GA20047@danjae.aot.lge.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Kees Cook <keescook@chromium.org>
Cc: Tony Luck <tony.luck@intel.com>, Radim Kr??m???? <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Anton Vorontsov <anton@enomsg.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, qemu-devel <qemu-devel@nongnu.org>, Minchan Kim <minchan@kernel.org>, Anthony Liguori <aliguori@amazon.com>, Colin Cross <ccross@android.com>, Paolo Bonzini <pbonzini@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 19, 2016 at 10:43 PM, Namhyung Kim <namhyung@kernel.org> wrote:
> The other one is the file management on the host side.  I am thinking
> of a simple way that the log file is splitted when it exceeds the half
> of the allowed max size.  It would be configurable and might allow
> unlimited logs if user requests it explicitly (if qemu guys say ok)..

On a second thought, I think that size of log file should not exceed
the pstore buffer size in order to be read back later.  When total size
of log files becomes larger then the limit, the oldest file of same
type can be deleted. This way looks simpler to manage IMHO.

Also I think the pstore id should be managed by host device rather
than guest driver to handle splitted files properly.

Thanks,
Namhyung
