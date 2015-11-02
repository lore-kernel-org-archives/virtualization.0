From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [kvm-unit-tests PATCH] x86: hyperv_synic: Hyper-V SynIC test
Date: Mon, 2 Nov 2015 13:22:55 +0100
Message-ID: <5637559F.9020006@redhat.com>
References: <1445853369-24435-1-git-send-email-asmetanin@virtuozzo.com>
	<56375402.7060406@redhat.com> <56375484.1000206@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <56375484.1000206@openvz.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Denis V. Lunev" <den@openvz.org>, Andrey Smetanin <asmetanin@virtuozzo.com>, kvm@vger.kernel.org
Cc: Gleb Natapov <gleb@kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Roman Kagan <rkagan@virtuozzo.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org



On 02/11/2015 13:18, Denis V. Lunev wrote:
>> I'm keeping the kernel patches queued for my own testing, but this of
>> course has to be fixed before including them---which will delay this
>> feature to 4.5, unfortunately.
> 
> well, the problem is that it actually uses auto EOI....

Ok, no big deal.  We can just disable APICv when SynIC is enabled.

Paolo
