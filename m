From: G Gregory <graeme.gregory@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2] arm: change vendor ID for virtio-mmio
Date: Thu, 30 Jul 2015 10:37:23 +0100
Message-ID: <CAGCh1+kvLnoW1C-sCaT85=-J5B7DcqOx-K9etRvoh3AfbN0J9w__22106.5904749141$1438620865$gmane$org@mail.gmail.com>
References: <1438196676-30255-1-git-send-email-mst@redhat.com>
	<55B97C88.6010004@linaro.org>
	<20150730105923-mutt-send-email-mst@redhat.com>
	<CAFEAcA9zRArvxhihXZpTVZrMw7UmRHMqh5SOM8Jz83Fmasr1zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAFEAcA9zRArvxhihXZpTVZrMw7UmRHMqh5SOM8Jz83Fmasr1zA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Shannon Zhao <shannon.zhao@linaro.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Igor Mammedov <imammedo@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 30 July 2015 at 10:24, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 30 July 2015 at 09:04, Michael S. Tsirkin <mst@redhat.com> wrote:
>> On Thu, Jul 30, 2015 at 09:23:20AM +0800, Shannon Zhao wrote:
>>>
>>> Why do we drop the previous way using "QEMUXXXX"? Something I missed?
>>
>> So that guests that bind to this interface will work fine with non QEMU
>> implementations of virtio-mmio.
>
> I don't understand this sentence. If there are pre-existing
> non-QEMU virtio-mmio implementations, then they're using
> LNRO0005, and we should use it too.

The only one I have come across is the ARM FVP model, and it happens
that I chose the ID and maintain the tables for that so I can change
it.

Graeme
