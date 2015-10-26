From: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 3/7] linux-headers/kvm: add Hyper-V SynIC irq
	routing type and struct
Date: Mon, 26 Oct 2015 10:03:17 +0000
Message-ID: <CAFEAcA9_DwrMd7LhLxxxxt307pFY46fFYDXbhbRN7YDmOOFaWw@mail.gmail.com>
References: <1445853060-24201-1-git-send-email-asmetanin@virtuozzo.com>
	<1445853060-24201-4-git-send-email-asmetanin@virtuozzo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1445853060-24201-4-git-send-email-asmetanin@virtuozzo.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrey Smetanin <asmetanin@virtuozzo.com>
Cc: kvm-devel <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, QEMU Developers <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Roman Kagan <rkagan@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 26 October 2015 at 09:50, Andrey Smetanin <asmetanin@virtuozzo.com> wrote:
> Signed-off-by: Andrey Smetanin <asmetanin@virtuozzo.com>
> Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Vitaly Kuznetsov <vkuznets@redhat.com>
> CC: "K. Y. Srinivasan" <kys@microsoft.com>
> CC: Gleb Natapov <gleb@kernel.org>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Roman Kagan <rkagan@virtuozzo.com>
> CC: Denis V. Lunev <den@openvz.org>
> CC: kvm@vger.kernel.org
> CC: virtualization@lists.linux-foundation.org
>
> ---
>  linux-headers/linux/kvm.h | 8 ++++++++
>  1 file changed, 8 insertions(+)

Hi. Changes to linux-headers/ should only be made as part of
an automated update from a mainline Linux kernel tree using
the scripts/update-linux-headers.sh script. This patch looks
like maybe it was a manual edit ?

thanks
-- PMM
