From: "Denis V. Lunev" <den@openvz.org>
Subject: Re: [Qemu-devel] [PATCH 3/7] linux-headers/kvm: add Hyper-V SynIC irq
	routing type and struct
Date: Mon, 26 Oct 2015 13:12:43 +0300
Message-ID: <562DFC9B.4050204@openvz.org>
References: <1445853060-24201-1-git-send-email-asmetanin@virtuozzo.com>
	<1445853060-24201-4-git-send-email-asmetanin@virtuozzo.com>
	<CAFEAcA9_DwrMd7LhLxxxxt307pFY46fFYDXbhbRN7YDmOOFaWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAFEAcA9_DwrMd7LhLxxxxt307pFY46fFYDXbhbRN7YDmOOFaWw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Maydell <peter.maydell@linaro.org>, Andrey Smetanin <asmetanin@virtuozzo.com>
Cc: kvm-devel <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, QEMU Developers <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 10/26/2015 01:03 PM, Peter Maydell wrote:
> On 26 October 2015 at 09:50, Andrey Smetanin <asmetanin@virtuozzo.com> wrote:
>> Signed-off-by: Andrey Smetanin <asmetanin@virtuozzo.com>
>> Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Vitaly Kuznetsov <vkuznets@redhat.com>
>> CC: "K. Y. Srinivasan" <kys@microsoft.com>
>> CC: Gleb Natapov <gleb@kernel.org>
>> CC: Paolo Bonzini <pbonzini@redhat.com>
>> CC: Roman Kagan <rkagan@virtuozzo.com>
>> CC: Denis V. Lunev <den@openvz.org>
>> CC: kvm@vger.kernel.org
>> CC: virtualization@lists.linux-foundation.org
>>
>> ---
>>   linux-headers/linux/kvm.h | 8 ++++++++
>>   1 file changed, 8 insertions(+)
> Hi. Changes to linux-headers/ should only be made as part of
> an automated update from a mainline Linux kernel tree using
> the scripts/update-linux-headers.sh script. This patch looks
> like maybe it was a manual edit ?
>
> thanks
> -- PMM

yep. We know and have discussed this with Paolo already.
Kernel stuff is in progress at the moment. The patch
is presented to interested people to allow to compile and
run.

Actual merge will be performed with proper sync
when kernel will be in rc3 or 4 stage and the patch will be
dropped.

The same applies for patch 5.

Den
