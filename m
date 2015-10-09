From: Roman Kagan <rkagan@virtuozzo.com>
Subject: Re: [PATCH 2/2] kvm/x86: Hyper-V kvm exit
Date: Fri, 9 Oct 2015 17:53:59 +0300
Message-ID: <20151009145358.GT27239__24388.7302269743$1444649887$gmane$org@rkaganb.sw.ru>
References: <1444397988-20167-1-git-send-email-den@openvz.org>
	<1444397988-20167-3-git-send-email-den@openvz.org>
	<5617D20B.1080402@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5617D20B.1080402@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Andrey Smetanin <asmetanin@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 09, 2015 at 04:41:15PM +0200, Paolo Bonzini wrote:
> On 09/10/2015 15:39, Denis V. Lunev wrote:
> > A new vcpu exit is introduced to notify the userspace of the
> > changes in Hyper-V synic configuraion triggered by guest writing to the
> > corresponding MSRs.
> 
> Why is this exit necessary?

The guest writes to synic-related MSRs and that should take "immediate"
effect.

E.g. it may decide to disable or relocate the message page by writing to
SIMP MSR.  The host is then supposed to stop accessing the old message
page before the vCPU proceeds to the next instruction.  Hence the exit,
to allow the userspace to react accordingly before reentering the guest.

Roman.
