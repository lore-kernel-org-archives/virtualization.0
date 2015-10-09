From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] kvm/x86: Hyper-V kvm exit
Date: Fri, 9 Oct 2015 16:41:15 +0200
Message-ID: <5617D20B.1080402@redhat.com>
References: <1444397988-20167-1-git-send-email-den@openvz.org>
	<1444397988-20167-3-git-send-email-den@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1444397988-20167-3-git-send-email-den@openvz.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Denis V. Lunev" <den@openvz.org>
Cc: Gleb Natapov <gleb@kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, rkagan@virtuozzo.com, Andrey Smetanin <asmetanin@virtuozzo.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org



On 09/10/2015 15:39, Denis V. Lunev wrote:
> From: Andrey Smetanin <asmetanin@virtuozzo.com>
> 
> A new vcpu exit is introduced to notify the userspace of the
> changes in Hyper-V synic configuraion triggered by guest writing to the
> corresponding MSRs.
> 
> Signed-off-by: Andrey Smetanin <asmetanin@virtuozzo.com>
> Reviewed-by: Roman Kagan <rkagan@virtiozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Vitaly Kuznetsov <vkuznets@redhat.com>
> CC: "K. Y. Srinivasan" <kys@microsoft.com>
> CC: Gleb Natapov <gleb@kernel.org>
> CC: Paolo Bonzini <pbonzini@redhat.com>

Why is this exit necessary?

Paolo
