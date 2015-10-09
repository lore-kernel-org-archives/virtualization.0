From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] kvm/x86: Hyper-V kvm exit
Date: Fri, 9 Oct 2015 16:57:33 +0200
Message-ID: <5617D5DD.7050701@redhat.com>
References: <1444397988-20167-1-git-send-email-den@openvz.org>
	<1444397988-20167-3-git-send-email-den@openvz.org>
	<5617D20B.1080402@redhat.com> <20151009145358.GT27239@rkaganb.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20151009145358.GT27239@rkaganb.sw.ru>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Roman Kagan <rkagan@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, Andrey Smetanin <asmetanin@virtuozzo.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Gleb Natapov <gleb@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org



On 09/10/2015 16:53, Roman Kagan wrote:
>> > Why is this exit necessary?
> The guest writes to synic-related MSRs and that should take "immediate"
> effect.
> 
> E.g. it may decide to disable or relocate the message page by writing to
> SIMP MSR.  The host is then supposed to stop accessing the old message
> page before the vCPU proceeds to the next instruction.  Hence the exit,
> to allow the userspace to react accordingly before reentering the guest.

Ok, thanks!

Paolo
