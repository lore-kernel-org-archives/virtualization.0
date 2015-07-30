From: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2] arm: change vendor ID for virtio-mmio
Date: Thu, 30 Jul 2015 10:24:11 +0100
Message-ID: <CAFEAcA9zRArvxhihXZpTVZrMw7UmRHMqh5SOM8Jz83Fmasr1zA@mail.gmail.com>
References: <1438196676-30255-1-git-send-email-mst@redhat.com>
	<55B97C88.6010004@linaro.org>
	<20150730105923-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150730105923-mutt-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Graeme Gregory <graeme.gregory@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Shannon Zhao <shannon.zhao@linaro.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Igor Mammedov <imammedo@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 30 July 2015 at 09:04, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Thu, Jul 30, 2015 at 09:23:20AM +0800, Shannon Zhao wrote:
>>
>> Why do we drop the previous way using "QEMUXXXX"? Something I missed?
>
> So that guests that bind to this interface will work fine with non QEMU
> implementations of virtio-mmio.

I don't understand this sentence. If there are pre-existing
non-QEMU virtio-mmio implementations, then they're using
LNRO0005, and we should use it too. If there are going to
be implementations of virtio-mmio in future, then they will
use whatever identifier we pick here. Either way, we get
interoperability. I don't see any difference between our
saying "the ID for virtio-mmio is QEMU0005" and saying
"the ID for virtio-mmio is 1AF4103F".

(The latter seems unnecessarily opaque to me, to be honest.
At least an ID string QEMUxxxx gives you a clue where to
look for who owns the thing.)

Note also that strictly you don't mean "non-QEMU implementations
of virtio-mmio", you mean "non-QEMU implementations of the
ACPI tables". The hardware implementation of virtio-mmio
doesn't care at all about the ACPI ID. (In fact the most
plausible other-implementation would be UEFI using its
own (hard-coded) ACPI tables on top of a QEMU vexpress-a15
model or something similar.)

-- PMM
