From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] kvm/x86: Hyper-V kvm exit
Date: Mon, 12 Oct 2015 15:46:10 +0200
Message-ID: <561BB9A2.1090908@redhat.com>
References: <1444397988-20167-1-git-send-email-den@openvz.org>
	<1444397988-20167-3-git-send-email-den@openvz.org>
	<561BB8D2.60402@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <561BB8D2.60402@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Eric Blake <eblake@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Cc: Gleb Natapov <gleb@kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, rkagan@virtuozzo.com, Andrey Smetanin <asmetanin@virtuozzo.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org



On 12/10/2015 15:42, Eric Blake wrote:
> > +related with Hyper-V emulation. Currently used to synchronize modified
> > +Hyper-V synic state with userspace.
>
> Again, is 'synic' intended?  Hmm, I see it throughout the patch, so it
> looks intentional, but I keep trying to read it as a typo for 'sync'.

It's synthetic interrupt controller, but indeed it's a bit obscure.
Perhaps we can change it in the docs to "Hyper-V synthetic interrupt state".

Paolo
