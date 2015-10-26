From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/7] linux-headers/kvm: add Hyper-V SynIC irq
	routing type and struct
Date: Mon, 26 Oct 2015 16:40:54 +0100
Message-ID: <562E4986.4070605__47605.6799445816$1445874083$gmane$org@redhat.com>
References: <1445853060-24201-1-git-send-email-asmetanin@virtuozzo.com>
	<1445853060-24201-4-git-send-email-asmetanin@virtuozzo.com>
	<CAFEAcA9_DwrMd7LhLxxxxt307pFY46fFYDXbhbRN7YDmOOFaWw@mail.gmail.com>
	<562DFC9B.4050204@openvz.org>
	<CAFEAcA_SwJvN8E_6fCawJnwqM3RaB94XGn9TkU7f2VPg40uo-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAFEAcA_SwJvN8E_6fCawJnwqM3RaB94XGn9TkU7f2VPg40uo-g@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Maydell <peter.maydell@linaro.org>, "Denis V. Lunev" <den@openvz.org>
Cc: kvm-devel <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, QEMU Developers <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Roman Kagan <rkagan@virtuozzo.com>, Andrey Smetanin <asmetanin@virtuozzo.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org



On 26/10/2015 11:16, Peter Maydell wrote:
> On 26 October 2015 at 10:12, Denis V. Lunev <den@openvz.org> wrote:
>> On 10/26/2015 01:03 PM, Peter Maydell wrote:
>>> Hi. Changes to linux-headers/ should only be made as part of
>>> an automated update from a mainline Linux kernel tree using
>>> the scripts/update-linux-headers.sh script. This patch looks
>>> like maybe it was a manual edit ?
> 
>> yep. We know and have discussed this with Paolo already.
>> Kernel stuff is in progress at the moment. The patch
>> is presented to interested people to allow to compile and
>> run.
>>
>> Actual merge will be performed with proper sync
>> when kernel will be in rc3 or 4 stage and the patch will be
>> dropped.
> 
> OK, cool. It's best to tag the series as 'RFC' rather than
> 'PATCH' in that case, as a reminder that it can't be applied
> just yet.

I'm still going to apply it to a branch for now, so it's not strictly
RFC.  I'm not sending a pull request, however, until I rebase the
branch, and then it will just go away.

Paolo
